-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:15 PM

local QuestID = 158;
local ReqClv = 12;
local ReqJlv = 0;
local NextQuest = 0;
local RewZeny = 212;
local RewCxp = 675;
local RewJxp = 0;
local RewWxp = 0;
local RewItem1 = 1700113;
local RewItem2 = 0;
local RewItemCount1 = 2;
local RewItemCount2 = 0;
local StepID = 0;

-- Modify steps below for gameplay

function QUEST_START(cid)
	Saga.AddStep(cid, QuestID, 15801);
	Saga.AddStep(cid, QuestID, 15802);
	Saga.AddStep(cid, QuestID, 15803);
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
	return 0;
end

function QUEST_STEP_1(cid)
	-- Talk with Monika Reynolds
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1012);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1012 then
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
	-- Talk with Joachim Tristan
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1014);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1014 then
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

function QUEST_STEP_3(cid)
	-- Talk with Sophie
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1151);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1151 then
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

function QUEST_STEP_3(cid)
	-- Talk with Sophie
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1151);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1151 then
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

function QUEST_STEP_4(cid)
	-- Receive Flowers from Pelshia Hiltrud
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1013);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1013 then
		Saga.NpcGiveItem(cid, 3972,1);
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

function QUEST_STEP_5(cid)
	-- Laydown flowers at the Tombstone
	local ret = Saga.GetActionObjectIndex(cid);
	if ret == 1 then
		local ItemCountA = Saga.CheckUserInventory(cid, 3972);
		if ItemCountA > 0 then
			Saga.NpcTakeItem(cid, 3972,1);
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

	if CurStepID == 15801 then
		ret = QUEST_STEP_1(cid);
	elseif CurStepID == 15802 then
		ret = QUEST_STEP_2(cid);
	elseif CurStepID == 15803 then
		ret = QUEST_STEP_3(cid);
	elseif CurStepID == 15804 then
		ret = QUEST_STEP_3(cid);
	elseif CurStepID == 15805 then
		ret = QUEST_STEP_3(cid);
	end

	if ret == 0 then
		QUEST_CHECK(cid)
	end
	
	return ret;
end
