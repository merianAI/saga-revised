-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:15 PM

local QuestID = 201;
local ReqClv = 16;
local ReqJlv = 0;
local NextQuest = 202;
local RewZeny = 300;
local RewCxp = 1700;
local RewJxp = 680;
local RewWxp = 0;
local RewItem1 = 1700113;
local RewItem2 = 0;
local RewItemCount1 = 3;
local RewItemCount2 = 0;
local StepID = 0;

-- Modify steps below for gameplay

function QUEST_START(cid)
	Saga.AddStep(cid, QuestID, 20101);
	Saga.AddStep(cid, QuestID, 20102);
	Saga.AddStep(cid, QuestID, 20103);
	Saga.InsertQuest(cid, QuestID, 1);
	return 0;
end

function QUEST_FINISH(cid)
	-- Gives all rewards
	Saga.GiveItem(cid, RewItem1, RewItemCount1 );
	Saga.GiveZeny(cid, RewZeny);
	Saga.GiveExp(cid, RewCxp, RewJxp, RewWxp);
	Saga.InsertQuest(cid, NextQuest, 1);
	return 0;
end

function QUEST_CANCEL(cid)
	return 0;
end

function QUEST_STEP_1(cid)
	-- Talk with Shantos Kebby
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1092);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1092 then
		Saga.GeneralDialog(cid, 3936);
		Saga.SubstepComplete(cid, QuestID, StepID, 1);
	end
	
	-- Check if all substeps are completed
	for i = 1, 1 do
		if Saga.IsSubStepCompleted(cid,QuestID,StepID, i) == false then
			return -1;
		end
	end
	
	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, StepID);
	return 0;
end

function QUEST_STEP_2(cid)
	-- Find a twig (8)
	Saga.FindQuestItem(cid, QuestID, StepID, 5, 3993, 10000, 8, 1);

	-- (De-)Activates the Action Objectd on request
	if Saga.IsSubStepCompleted(cid,QuestID,StepID, 1) == false then
		Saga.UserUpdateActionObjectType(cid, QuestID, StepID, 5, 0 );
	else
		Saga.UserUpdateActionObjectType(cid, QuestID, StepID, 5, 1 );
	end
	
	-- Check if all substeps are completed
	for i = 1, 1 do
		if Saga.IsSubStepCompleted(cid,QuestID,StepID, i) == false then
			return -1;
		end
	end
	
	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, StepID);
	return 0;
end

function QUEST_STEP_3(cid)
	-- Talk with Shantos Kebby
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1092);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1092 then
		Saga.GeneralDialog(cid, 3936);
	
		local ItemCountA = Saga.CheckUserInventory(cid,3993);
		if ItemCountA > 7 then
			Saga.NpcTakeItem(cid, 3993,8);
			Saga.SubstepComplete(cid, QuestID, StepID, 1);
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
	local CurStepID = Saga.GetStepIndex(cid, QuestID );
	StepID = CurStepID;
	local ret = -1;

	if CurStepID == 20101 then
		ret = QUEST_STEP_1(cid);
	elseif CurStepID == 20102 then
		ret = QUEST_STEP_2(cid);
	elseif CurStepID == 20103 then
		ret = QUEST_STEP_3(cid);
	end
	
	if ret == 0 then
		QUEST_CHECK(cid)
	end
	
	return ret;
end
