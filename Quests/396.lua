-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:18 PM

local QuestID = 396;
local ReqClv = 1;
local ReqJlv = 0;
local NextQuest = 0;
local RewZeny = 10;
local RewCxp = 5;
local RewJxp = 0;
local RewWxp = 0;
local RewItem1 = 100001;
local RewItem2 = 0;
local RewItemCount1 = 1;
local RewItemCount2 = 0;

-- Modify steps below for gameplay

function QUEST_START(cid)
	-- Initialize all quest steps
	-- Initialize all starting navigation points

	Saga.AddStep(cid, QuestID, 39601);
	Saga.AddStep(cid, QuestID, 39602);
	Saga.AddStep(cid, QuestID, 39603);
	Saga.InsertQuest(cid, QuestID, 1);

	return 0;
end

function QUEST_FINISH(cid)
	-- Gives all rewards

	Saga.GiveItem(cid, RewItem1, RewItemCount1 );
	Saga.GiveZeny(cid, RewZeny);
	Saga.GiveExp(cid, RewCxp, RewJxp, RewWxp);
	return 0;
end

function QUEST_CANCEL(cid)
	-- Do nothing
	return 0;
end

function QUEST_STEP_1(cid)
	-- Add all waypoints
	Saga.AddWaypoint(cid, QuestID, 39601, 1, 1174);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1174 then
		Saga.GeneralDialog(cid, 3936);
		Saga.SubstepComplete(cid, QuestID, 39601, 1);
	end
	
	-- Check if all substeps are completed
	for i = 1, 1 do
		if Saga.IsSubStepCompleted(cid,QuestID,39601, i) == false then
			return -1;
		end
	end
	
	-- Clear waypoints
	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, 39601);
	return 0;
end

function QUEST_STEP_2(cid)
	-- Find training result
	local ActionObjectID = 47;
	local ItemId = 9944;
	
	Saga.UserUpdateActionObjectType(cid, QuestID, 39602, ActionObjectID, 0 );
	if Saga.FindQuestItem(cid, QuestID, 39602, ActionObjectID, ItemId, 10000, 1, 1) > 0 then
  	  Saga.UserUpdateActionObjectType(cid, QuestID, 39602, ActionObjectID, 1 );
	else
		return -1;
	end
	
	Saga.StepComplete(cid, QuestID, 39602);
	return 0;
end

function QUEST_STEP_3(cid)
	-- Deliver training result to Dein
	Saga.AddWaypoint(cid, QuestID, 39603, 1, 1173);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1173 then
		Saga.GeneralDialog(cid, 3936);
		if Saga.CheckUserInventory(cid, 9944 ) > 0 then
			Saga.NpcTakeItem(cid, 9944, 1 );
			Saga.SubstepComplete(cid, QuestID, 39603, 1);
		end
	end
	
	-- Check if all substeps are completed
	for i = 1, 1 do
		if Saga.IsSubStepCompleted(cid,QuestID,39603, i) == false then
			return -1;
		end
	end
	
	-- Clear waypoints
	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, 39603);
	Saga.QuestComplete(cid, QuestID);
	return -1;


end

function QUEST_CHECK(cid)
	-- Check all steps for progress
	local CurStepID = Saga.GetStepIndex(cid, QuestID );
	local ret = -1;

	if CurStepID == 39601 then
		ret = QUEST_STEP_1(cid);
	elseif CurStepID == 39602 then
		ret = QUEST_STEP_2(cid);
	elseif CurStepID == 39603 then
		ret = QUEST_STEP_3(cid);
	end

	if ret == 0 then
		QUEST_CHECK(cid)
	end

	return ret;
end
