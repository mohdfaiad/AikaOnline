unit NPCHandlers;

interface

uses Windows, SysUtils, Math,
  Player, Packets, NPC, PlayerData, ItemFunctions, MiscData;

type TNPCHandlers = class(TObject)
  public
    class function Handle(var player: TPlayer; var buffer: array of Byte): Boolean; static;

  private
    class function Sephirot(var player: TPlayer; var npc: TNpc; var packet: TNpcPacket): Boolean; static;
    class function Juli(var player: TPlayer; var npc: TNpc; var packet: TNpcPacket): Boolean; static;
    class function GuardaReal(var player: TPlayer; var npc: TNpc; var packet: TNpcPacket): Boolean; static;
    class function Kibita(var player: TPlayer; var npc: TNpc; var packet: TNpcPacket): Boolean; static;
    class function MestreHab(var player: TPlayer; var npc: TNpc; var packet: TNpcPacket): Boolean; static;
    class function GodGovernament(var player: TPlayer; var npc: TNpc; var packet: TNpcPacket): Boolean; static;
    class function EntradasQuest(var player: TPlayer; var npc: TNpc; var packet: TNpcPacket): Boolean; static;
    class function KingdomBroker(var player: TPlayer; var npc: TNpc; var packet: TNpcPacket): Boolean; static;
    class function Oraculo(var player: TPlayer; var npc: TNpc; var packet: TNpcPacket): Boolean; static;
    class function Cosmos(var player: TPlayer; var npc: TNpc; var packet: TNpcPacket): Boolean; static;
    class function Kingdom(var player: TPlayer; var npc: TNpc; var packet: TNpcPacket): Boolean; static;
    class function Arch(var player: TPlayer; var npc: TNpc; var packet: TNpcPacket): Boolean; static;
    class function Khadin(var player: TPlayer; var npc: TNpc; var packet: TNpcPacket): Boolean; static;
    class function NpcDeTroca(var player: TPlayer; var npc: TNpc; var packet: TNpcPacket): Boolean; static;
    class function QuestCapaVerde(var player: TPlayer; var npc: TNpc; var packet: TNpcPacket): Boolean; static;
    class function Unis(var player: TPlayer; var npc: TNpc; var packet: TNpcPacket): Boolean; static;
    class function CarbWind(var player: TPlayer; var npc: TNpc; var packet: TNpcPacket): Boolean; static;
end;

implementation

uses GlobalDefs, Util;

{ TNPCHandlers }
class function TNPCHandlers.Handle(var player: TPlayer; var buffer: array of Byte): Boolean;
begin

end;

class function TNPCHandlers.Sephirot(var player: TPlayer; var npc: TNpc; var packet: TNpcPacket): Boolean;
begin

end;

class function TNPCHandlers.Juli(var player: TPlayer; var npc: TNpc; var packet: TNpcPacket): Boolean;
var dest: TPosition;
begin

end;

class function TNPCHandlers.GuardaReal(var player: TPlayer; var npc: TNpc; var packet: TNpcPacket): Boolean;
begin

end;

class function TNPCHandlers.Kibita(var player: TPlayer; var npc: TNpc; var packet: TNpcPacket): Boolean;
var lacSlot: Integer;
begin
  {
	if(player.Character.Citizenship <> TCitizenship.None) then
	begin
		if(player.Character.Base.Gold < 5000000) then
		begin
			player.SendClientMessage('Preciso de 5 Milh�es(5kk) para cadastrar voc� nesse servidor.');
			exit;
		end;
		Dec(player.Character.Base.Gold, 5000000);
		player.Character.Citizenship := CurrentServer;
		player.SendClientMessage('Voc� se cadastrou nesse servidor.');
		exit;
	end;

  if (DayOfWeek >= 2) AND (DayOfWeek() <= 6) AND (HourOf(Now) = 21) then
  begin
    npc.Base.SendChat('Retorne durante a semana as 21h');
    exit;
  end;

  if not(player.Character.Base.IsMortal) then
  begin
    npc.Base.SendChat('Exclusivo aos Mortais');
    exit;
  end;

  if (player.Character.Base.bStatus.Level >= 369) then
  begin
    npc.Base.SendChat('Level inadequado [1~368].');
    exit;
  end;
  lacSlot := player.Base.GetFirstSlot(420, INV_TYPE);

  if(lacSlot = -1) then
  begin
    npc.Base.SendChat('Traga-me um Resto de Lactolerium.');
    exit;
  end;

			bool hasSoulOn := false;

			for(INT8 i := 0; i < 16; i++)
			begin
				if(mBuffer[clientId].Affects[i].Index = 29)
				begin
					hasSoulOn := true;
					mBuffer[clientId].Affects[i].Master := 11;
					mBuffer[clientId].Affects[i].Time := 10800;
					mBuffer[clientId].Affects[i].Value := 4;
					break;
				end;
				if(!hasSoulOn)
				begin
					if(!mBuffer[clientId].Affects[i].Index)
					begin
						mBuffer[clientId].Affects[i].Index := 29;
						mBuffer[clientId].Affects[i].Master := 11;
						mBuffer[clientId].Affects[i].Time := 10800;
						mBuffer[clientId].Affects[i].Value := 4;
						break;
					end;
				end;
			end;

			DoTeleport(clientId, 2463, 1841);

			GetCurrentScore(clientId);

			AmountMinus(&player->Inventory[RestLac]);

			SendItem(clientId, INVENTORY, RestLac, &player->Inventory[RestLac]);

			exit;
		end;

		const WORD szStones [4] := begin5334, 5336, 5335, 5337end;;

		if(player.Character.Base.Equip[15].Index <> 3194 && player.Character.Base.Equip[15].Index <> 3195 && player.Character.Base.Equip[15].Index <> 3196)
		begin
			if(player.Character.Base.bStatus.Level >= 369 && player.Character.Base.Equip[0].EFV2 = MORTAL)
			begin
				if(player->ClassInfo < 0 || player->ClassInfo > 3)
				begin
					player.SendClientMessage('H� um erro na sua conta. Favor contatar a administra��o');

					exit;
				end;

				INT16 slotId := GetFirstSlot(clientId, szStones[player->ClassInfo], INVENTORY);

				if(slotId = -1)
				begin
					char szMsg[256];

					sprintf(szMsg, " Traga-me a %s para adiquirir a soul.", ItemList[szStones[player->ClassInfo]].Name);

					player.SendClientMessage(szMsg);

					exit;
				end;

				memset(&player.Character.Base.Equip[15], 0, sizeof st_Item);
				memset(&player->Inventory[slotId], 0, sizeof st_Item);

				INT16 kingDom := 0;

				if(player->CapeInfo = 7)
					kingDom := 3194;
				if(player->CapeInfo = 8)
					kingDom := 3195;
				else
					kingDom := 3196;

				player.Character.Base.Equip[15].Index := kingDom;

				SendItem(clientId, EQUIP, 15, &player.Character.Base.Equip[15]);

				player->Learn |=  (1 << 30);

				SendCharList(clientId);

				player.SendClientMessage('Que os Deuses de Kersef ilumine seu caminho.');

				SendClientSignalParm(clientId, clientId, 0x3B4, wdBuffer[clientId].Ingame.LoggedMob);
			end;
		end;
	end;
  }
	npc.base.SendChat('NPC','Desculpe.');
end;

class function TNPCHandlers.MestreHab(var player: TPlayer; var npc: TNpc; var packet: TNpcPacket): Boolean;
begin

end;

class function TNPCHandlers.GodGovernament(var player: TPlayer; var npc: TNpc; var packet: TNpcPacket): Boolean;
begin

end;

class function TNPCHandlers.EntradasQuest(var player: TPlayer; var npc: TNpc; var packet: TNpcPacket): Boolean;
var questId: Byte;
  questItemSlot: Int8;
  quest: TQuest;
begin

end;

class function TNPCHandlers.KingdomBroker(var player: TPlayer; var npc: TNpc; var packet: TNpcPacket): Boolean;
var fame: WORD;
begin

end;

class function TNPCHandlers.Oraculo(var player: TPlayer; var npc: TNpc; var packet: TNpcPacket): Boolean;
var uni, fenix: Integer;
  safires: TItemAmount;
  i: BYTE;
  imor: TItem;
  slot: BYTE;
begin

end;

class function TNPCHandlers.Cosmos(var player: TPlayer; var npc: TNpc; var packet: TNpcPacket): Boolean;
begin

end;

class function TNPCHandlers.Kingdom(var player: TPlayer; var npc: TNpc; var packet: TNpcPacket): Boolean;
begin

end;

class function TNPCHandlers.Arch(var player: TPlayer; var npc: TNpc; var packet: TNpcPacket): Boolean;
begin

end;

class function TNPCHandlers.Khadin(var player: TPlayer; var npc: TNpc; var packet: TNpcPacket): Boolean;
var face: WORD;
begin

end;

class function TNPCHandlers.NpcDeTroca(var player: TPlayer; var npc: TNpc; var packet: TNpcPacket): Boolean;
begin

end;

class function TNPCHandlers.QuestCapaVerde(var player: TPlayer; var npc: TNpc; var packet: TNpcPacket): Boolean;
var errorStr : string;
begin

end;

class function TNPCHandlers.Unis(var player: TPlayer; var npc: TNpc; var packet: TNpcPacket): Boolean;
var neededItem, neededSlot: Integer;
  prize: TItem;
  i: Integer;
begin

end;

class function TNPCHandlers.CarbWind(var player: TPlayer; var npc: TNpc; var packet: TNpcPacket): Boolean;
var
  npcBuffId: Integer;
  playerBuffId: Integer;

  npcAffect: TAffect;
begin

end;

end.
