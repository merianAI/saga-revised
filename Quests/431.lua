-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:19 PM

local QuestID = 431;
local ReqClv = 31;
local ReqJlv = 0;
local NextQuest = 0;
local RewZeny = 1199;
local RewCxp = 7860;
local RewJxp = 3132;
local RewWxp = 0;
local RewItem1 = 1700115;
local RewItem2 = 0;
local RewItemCount1 = 3;
local RewItemCount2 = 0;
local StepID = 0;

-- Modify steps below for gameplay

function QUEST_START(cid)
	Saga.AddStep(cid, QuestID, 43101);
	Saga.AddStep(cid, QuestID, 43102);
	Saga.AddStep(cid, QuestID, 43103);
	Saga.InsertQuest(cid, QuestID, 1);
	return 0;
end

function QUEST_FINISH(cid)
	-- Gives all rewards
	local freeslots = Saga.FreeInventoryCount(cid, 0);
	if freeslots > 0 then
		Saga.GiveZeny(RewZeny);
		Saga.GiveExp( RewCxp, RewJxp, RewWxp);
		Saga.GiveItem(cid, RewItem1, RewItemCount1 );
		return 0;
	else
		Saga.EmptyInventory(cid);
		return -1;
	end
end

function QUEST_CANCEL(cid)
	return 0;
end

function QUEST_STEP_1(cid)
	Saga.StepComplete(cid,QuestID,StepID);
	return 0;
end

function QUEST_STEP_2(cid)
	-- Collect Gearbaz's Bolt (10)
	Saga.FindQuestItem(cid,QuestID,StepID,10353,4241,8000,10,1);
	Saga.FindQuestItem(cid,QuestID,StepID,10354,4241,8000,10,1);
	
	-- Check if all substeps are completed
	for i = 1, 1 do
		if Saga.IsSubStepCompleted(cid,QuestID,StepID,i) == false then
			return -1;
		end
	end
	
	Saga.StepComplete(cid,QuestID,StepID);
	return 0;
end

function QUEST_STEP_3(cid)
	-- Hand in to Kafra Board Mailbox
	local ret = Saga.GetActionObjectIndex(cid);
	if ret == 1123 then
		local ItemCountA = Saga.CheckUserInventory(cid, 4241);
		if ItemCountA > 9 then
			Saga.NpcTakeItem(cid, 4241, 10);
			Saga.SubstepComplete(cid, QuestID, StepID, 1);
		else
			Saga.InventoryNotFound(cid);
		end
	end
	
	-- Check if all substeps are completed
	for i = 1, 1 do
		if Saga.IsSubStepCompleted(cid,QuestID,StepID, i) == false then
			return -1;
		end
	end
	
	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, StepID);
	Saga.QuestComplete(cid, QuestID);
	return -1;
end

function QUEST_CHECK(cid)
	-- Check all steps for progress
	local CurStepID = Saga.GetStepIndex(cid, QuestID );
	local ret = -1;
	StepID = CurStepID;
	
	if CurStepID == 43101 then
		ret = QUEST_STEP_1(cid);
	elseif CurStepID == 43102 then
		ret = QUEST_STEP_2(cid);
	elseif CurStepID == 43103 then
		ret = QUEST_STEP_3(cid);
	end
	
	if ret == 0 then
		QUEST_CHECK(cid)
	end
	
	return ret;
end
