-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:18 PM

local QuestID = 422;
local ReqClv = 30;
local ReqJlv = 0;
local NextQuest = 423;
local RewZeny = 1726;
local RewCxp = 6958;
local RewJxp = 2783;
local RewWxp = 0;
local RewItem1 = 1700115;
local RewItem2 = 0;
local RewItemCount1 = 1;
local RewItemCount2 = 0;
local StepID = 0;

-- Modify steps below for gameplay

function QUEST_START(cid)
	Saga.AddStep(cid, QuestID, 42201);
	Saga.AddStep(cid, QuestID, 42202);
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
	-- Collect item from Devil Entraion (8)
	Saga.FindQuestItem(cid,QuestID,StepID,10329,4231,8000,8,1);
	Saga.FindQuestItem(cid,QuestID,StepID,10330,4231,8000,8,1);
	
	-- Check if all substeps are completed
	for i = 1, 1 do
		if Saga.IsSubStepCompleted(cid,QuestID,StepID,i) == false then
			return -1;
		end
	end
	
	Saga.StepComplete(cid,QuestID,StepID);
	return 0;
end

function QUEST_STEP_2(cid)
	-- Deliver claws to Chayenne
	Saga.AddWaypoint(cid,QuestID,StepID,1,1022);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1022 then
		Saga.GeneralDialog(cid, 3933);
	
		local ItemCountA = Saga.CheckUserInventory(cid, 4231);
		if ItemCountA > 7 then
			Saga.NpcTakeItem(cid, 4231, 8);
			Saga.SubstepComplete(cid, QuestID, StepID, 1);
		else
			Saga.InventoryNotFound(cid);
		end
	end
	
	-- Check if all substeps are completed
	for i = 1, 1 do
		if Saga.IsSubStepCompleted(cid,QuestID,StepID,i) == false then
			return -1;
		end
	end
	
	-- Clear waypoints
	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid,QuestID,StepID);
	Saga.QuestComplete(cid,QuestID);
	return -1;
end

function QUEST_CHECK(cid)
	-- Check all steps for progress
	local CurStepID = Saga.GetStepIndex(cid, QuestID );
	local ret = -1;
	StepID = CurStepID;
	
	if CurStepID == 42201 then
		ret = QUEST_STEP_1(cid);
	elseif CurStepID == 42202 then
		ret = QUEST_STEP_2(cid);
	end
	
	if ret == 0 then
		QUEST_CHECK(cid)
	end
	
	return ret;
end
