-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:14 PM

local QuestID = 32;
local ReqClv = 11;
local ReqJlv = 0;
local NextQuest = 0;
local RewZeny = 408;
local RewCxp = 774;
local RewJxp = 306;
local RewWxp = 0;
local RewItem1 = 1700113;
local RewItem2 = 0;
local RewItemCount1 = 10;
local RewItemCount2 = 0;
local StepID = 0;

function QUEST_VERIFY(cid)
	Saga.GeneralDialog(cid, 3957);
	return 0;
end

-- Modify steps below for gameplay

function QUEST_START(cid)
	-- Initialize all quest steps
	-- Initialize all starting navigation points
	Saga.AddStep(cid, QuestID, 3201);
	Saga.AddStep(cid, QuestID, 3202);
	Saga.AddStep(cid, QuestID, 3203);
	Saga.InsertQuest(cid, QuestID, 2);
	return 0;
end

function QUEST_FINISH(cid)
	-- Gives all rewards
	local freeslots = Saga.FreeInventoryCount(cid, 0);
	if freeslots > 0 then
		Saga.GiveZeny(cid, RewZeny);
		Saga.GiveExp(cid, RewCxp, RewJxp, RewWxp);
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
	-- Get boss pukui ring
	Saga.FindQuestItem(cid,QuestID,StepID,10011,2646,2500,1,1);
	
	-- Check if all substeps are completed
	if Saga.IsSubStepCompleted(cid,QuestID,3202, 1) == false then
		return -1;
	end
	
	Saga.StepComplete(cid,QuestID,StepID);
	return 0;
end

function QUEST_STEP_3(cid)
	-- Talk to Klaret Natali
	Saga.AddWaypoint(cid, QuestID, 3203, 1, 1001);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1001 then
		Saga.NpcTakeItem(cid, 2646, 4);
		Saga.SubstepComplete(cid,QuestID,StepID,1);
	end
	
	-- Check if all substeps are completed
	if Saga.IsSubStepCompleted(cid,QuestID,3203, 1) == false then
		return -1;
	end
	
	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid,QuestID,StepID);
	Saga.QuestComplete(cid, QuestID);
	return -1;
end

function QUEST_CHECK(cid)
	-- Check all steps for progress
	local CurStepID = Saga.GetStepIndex(cid, QuestID );
	local ret = -1;
	StepID = CurStepID;
	
	if CurStepID == 3201 then
		ret = QUEST_STEP_1(cid);
	elseif CurStepID == 3202 then
		ret = QUEST_STEP_2(cid);
	elseif CurStepID == 3203 then
		ret = QUEST_STEP_3(cid);
	end
	
	if ret == 0 then
		QUEST_CHECK(cid)
	end
	
	return ret;
end
