-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:14 PM

local QuestID = 26;
local ReqClv = 5;
local ReqJlv = 0;
local NextQuest = 0;
local RewZeny = 70;
local RewCxp = 161;
local RewJxp = 63;
local RewWxp = 0;
local RewItem1 = 1700113;
local RewItem2 = 16107;
local RewItemCount1 = 3;
local RewItemCount2 = 1;
local StepID = 0;

-- Modify steps below for gameplay

function QUEST_START(cid)
	Saga.AddStep(cid, QuestID, 2601);
	Saga.AddStep(cid, QuestID, 2602);
	Saga.InsertQuest(cid, QuestID, 1);
	return 0;
end

function QUEST_FINISH(cid)
	-- Gives all rewards
	local freeslots = Saga.FreeInventoryCount(cid, 0);
	if freeslots > 1 then
		Saga.GiveZeny(RewZeny);
		Saga.GiveExp( RewCxp, RewJxp, RewWxp);
		Saga.GiveItem(cid, RewItem1, RewItemCount1 );
		Saga.GiveItem(cid, RewItem2, RewItemCount2 );
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
	--Find Cornutu's Claws;Loot Tropical Hydra's Organs;Find Marine Sphere Parts;Capture a Pukui;

	Saga.FindQuestItem(cid,QuestID,StepID,10021,4072,8000,1,1);
	Saga.FindQuestItem(cid,QuestID,StepID,10022,4072,8000,1,1);
	Saga.FindQuestItem(cid,QuestID,StepID,10050,2644,8000,2,2);
	Saga.FindQuestItem(cid,QuestID,StepID,10051,2644,8000,2,2);
	Saga.FindQuestItem(cid,QuestID,StepID,10040,2645,8000,2,3);
	Saga.FindQuestItem(cid,QuestID,StepID,10041,2645,8000,2,3);
	--pukui need testing, see Npc.xml
	Saga.FindQuestItem(cid,QuestID,StepID,10257,2639,8000,1,4);
	Saga.FindQuestItem(cid,QuestID,StepID,10005,2639,8000,1,4);
	Saga.FindQuestItem(cid,QuestID,StepID,40000,2639,8000,1,4);

	--check if all Substeps are completed
	for i = 1, 4 do
		if Saga.IsSubStepCompleted(cid,QuestID,StepID,i) == false then
			return -1;
		end
	end
	
	Saga.StepComplete(cid,QuestID,StepID);
	return 0;
end

function QUEST_STEP_2(cid)
	--Deliver Material to Zarko Ruzzoli

	Saga.AddWaypoint(cid, QuestID, 2602, 1, 1005);
	local ret = Saga.GetNPCIndex(cid);
	local IitemCountA = Saga.CheckInventory(cid, 4072)
	local IitemCountB = Saga.CheckInventory(cid, 2644)
	local IitemCountC = Saga.CheckInventory(cid, 2645)
	local IitemCountD = Saga.CheckInventory(cid, 2639)
	if ret == 1005 then
		Saga.GeneralDialog(cid, 3936);
		if ItemCountA > 0 and ItemCountB > 1 and ItemCountC > 1 and ItemCountD > 0 then
			Saga.NpcTakeItem(cid, 4072, 1)
			Saga.NpcTakeItem(cid, 2644, 2)
			Saga.NpcTakeItem(cid, 2645, 2)
			Saga.NpcTakeItem(cid, 2639, 1)
			Saga.SubstepComplete(cid, 2602, 1);
		end
	end
	
	--check if all substeps are complete
	for i = 1, 1 do
		if Saga.IsSubStepCompleted(cid,QuestID,StepID,i) == false then
			return -1;
		end
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
	
	if CurStepID == 2601 then
		ret = QUEST_STEP_1(cid);
	elseif CurStepID == 2602 then
		ret = QUEST_STEP_2(cid);
	end
	
	if ret == 0 then
		QUEST_CHECK(cid)
	end
	
	return ret;
end
