-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:15 PM

local QuestID = 131;
local ReqClv = 11;
local ReqJlv = 0;
local NextQuest = 0;
local RewZeny = 408;
local RewCxp = 929;
local RewJxp = 368;
local RewWxp = 0;
local RewItem1 = 1700113;
local RewItem2 = 0;
local RewItemCount1 = 10;
local RewItemCount2 = 0;

-- Modify steps below for gameplay

function QUEST_START(cid)
	Saga.AddStep(cid, QuestID, 13101);
	Saga.AddStep(cid, QuestID, 13102);
	Saga.AddStep(cid, QuestID, 13103);
	Saga.InsertQuest(cid, QuestID, 2);
	return 0;
end
function QUEST_FINISH(cid)
	local freeslots = Saga.FreeInventoryCount(cid, 0);
	if freeslots > 1 then
	Saga.GiveZeny(RewZeny);
	Saga.GiveExp( RewCxp, RewJxp, RewWxp);
	Saga.GiveItem(cid, RewItem1, RewItemCount1 );
	Saga.GiveItem(cid, RewItem2, RewItemCount2 );
	return 0;
	else
	return -1;
	end

end
function QUEST_CANCEL(cid)
	return 0;
end

function QUEST_STEP_1(cid)
	Saga.StepComplete(cid, QuestID, 13101);
	return 0;
end

function QUEST_STEP_2(cid)
	--Collect Garbage

	Saga.FindQuestItem(cid, QuestID, 13102, 27, 2811, 10000, 5, 1);
	--Object Activation toggle

	if Saga.IsSubStepCompleted(cid, QuestID, 13102, 1) == false
	then
	Saga.UserUpdateActionObject(cid, QuestID, 13102, 27, 0);
	else
	Saga.UserUpdateActionObject(cid, QuestID, 13102, 27, 1);
	end
	--check if all substeps are completed
	for i = 1, 1 do
	if Saga.IsSubsStepCompleted(cid, QuestID, 13102, i) == false
	then
	return -1;
	end
	end
	Saga.StepComplete(cid, QuestID, 13102);
	return 0;
end

function QUEST_STEP_3(cid)
	--Talk with Ivo

	Saga.AddWaypoint(cid, QuestID, 13103, 1, 1062);
	--check for completion
	local ret = Saga.GetNPCIndex(cid);
	local ItemCount = Saga.CheckUserInventory(cid, 2811);
	if ret == 1062
	then
	Saga.GeneralDialog(cid, 3936);
	if ItemCount > 4
	then
	Saga.NpcTakeItem(cid, 2811, 5);
	Saga.SubstepComplete(cid, QuestID, 13103, 1);
	end
	end
	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, 13103);
	Saga.QuestComplete(cid, QuestID);
	return -1;
end
function QUEST_CHECK(cid)
	-- Check all steps for progress
	local CurStepID = Saga.GetStepIndex(cid, QuestID );
	local ret = -1;

	if CurStepID == 13101 then
		ret = QUEST_STEP_1(cid);
	elseif CurStepID == 13102 then
		ret = QUEST_STEP_2(cid);
	elseif CurStepID == 13103 then
		ret = QUEST_STEP_3(cid);
	end

	if ret == 0 then
		QUEST_CHECK(cid)
	end

	return ret;
end
