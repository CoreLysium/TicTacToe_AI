unit frmTicTacToeAI_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmTicTacToe = class(TForm)
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    btn4: TButton;
    btn5: TButton;
    btn6: TButton;
    btn7: TButton;
    btn8: TButton;
    btn9: TButton;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure btn6Click(Sender: TObject);
    procedure btn7Click(Sender: TObject);
    procedure btn8Click(Sender: TObject);
    procedure btn9Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    arrBoard: Array[1..9] of Integer;

    function MinMax(iDepth: Integer;bMaximizing: Boolean):Integer;
    function CheckWin(iParty: Integer):Boolean;
    function CheckDraw():Boolean;

    procedure Display_Board();
    procedure AI_Move();
    procedure Player_Move(iPos: Integer);
    procedure Reset_Board();
  public
    { Public declarations }
  end;

var
  frmTicTacToe: TfrmTicTacToe;

implementation

{$R *.dfm}

procedure TfrmTicTacToe.btn1Click(Sender: TObject);
begin
 Player_Move(1);
end;

procedure TfrmTicTacToe.btn2Click(Sender: TObject);
begin
  Player_Move(2);
end;

procedure TfrmTicTacToe.btn3Click(Sender: TObject);
begin
  Player_Move(3);
end;

procedure TfrmTicTacToe.btn4Click(Sender: TObject);
begin
  Player_Move(4);
end;

procedure TfrmTicTacToe.btn5Click(Sender: TObject);
begin
  Player_Move(5);
end;

procedure TfrmTicTacToe.btn6Click(Sender: TObject);
begin
  Player_Move(6);
end;

procedure TfrmTicTacToe.btn7Click(Sender: TObject);
begin
  Player_Move(7);
end;

procedure TfrmTicTacToe.btn8Click(Sender: TObject);
begin
  Player_Move(8);
end;

procedure TfrmTicTacToe.btn9Click(Sender: TObject);
begin
  Player_Move(9);
end;

function TfrmTicTacToe.CheckDraw: Boolean;
var
  I: Integer;
begin
  for I := 1 to 9 do
    if arrBoard[I] = 0 then
      begin
        Result := False;
        exit;
      end;
  Result := True;

end;

function TfrmTicTacToe.CheckWin(iParty: Integer): Boolean;
begin
  if (arrBoard[1] = arrBoard[2]) and (arrBoard[1] = arrBoard[3]) and (arrBoard[1] = iParty) then
    begin
      Result := True;
      exit;
    end
  else
  if (arrBoard[1] = arrBoard[2]) and (arrBoard[1] = arrBoard[3]) and (arrBoard[1] = iParty) then
    begin
      Result := True;
      exit;
    end
  else
  if (arrBoard[4] = arrBoard[5]) and (arrBoard[4] = arrBoard[6]) and (arrBoard[4] = iParty) then
    begin
      Result := True;
      exit;
    end
  else
  if (arrBoard[7] = arrBoard[8]) and (arrBoard[7] = arrBoard[9]) and (arrBoard[7] = iParty) then
    begin
      Result := True;
      exit;
    end
  else
  if (arrBoard[1] = arrBoard[4]) and (arrBoard[1] = arrBoard[7]) and (arrBoard[1] = iParty) then
    begin
      Result := True;
      exit;
    end
  else
  if (arrBoard[2] = arrBoard[5]) and (arrBoard[2] = arrBoard[8]) and (arrBoard[2] = iParty) then
    begin
      Result := True;
      exit;
    end
  else
  if (arrBoard[3] = arrBoard[6]) and (arrBoard[3] = arrBoard[9]) and (arrBoard[3] = iParty) then
    begin
      Result := True;
      exit;
    end
  else
  if (arrBoard[1] = arrBoard[5]) and (arrBoard[1] = arrBoard[9]) and (arrBoard[1] = iParty) then
    begin
      Result := True;
      exit;
    end
  else
  if (arrBoard[7] = arrBoard[5]) and (arrBoard[7] = arrBoard[3]) and (arrBoard[7] = iParty) then
    begin
      Result := True;
      exit;
    end
  else
    Result := False;
end;

procedure TfrmTicTacToe.Display_Board;
var
  I: Integer;
  btn: TButton;
begin
  for I := 1 to 9 do
    begin
      btn := TButton(FindComponent('btn' + IntToStr(I)));
      if arrBoard[I] = 1 then
        btn.Caption := 'X'
      else
      if arrBoard[I] = 2 then
        btn.Caption := 'O'
      else
        btn.Caption := '';
    end;

end;

procedure TfrmTicTacToe.FormShow(Sender: TObject);
begin
  Reset_Board;
  AI_Move;
end;

function TfrmTicTacToe.MinMax(iDepth: Integer; bMaximizing: Boolean): Integer;
var
  iBestScore, iScore, I: Integer;
begin
  if CheckWin(1) then
    begin
      Result := 1;
      exit;
    end
  else
  if CheckWin(2) then
    begin
      Result := -1;
      exit;
    end
  else
  if CheckDraw() then
    begin
      Result := 0;
      exit;
    end;

  if bMaximizing then
    begin
      iBestScore := -800;
      for I := 1 to 9 do
        begin
          if arrBoard[I] = 0 then
            begin
              arrBoard[I] := 1;
              iScore := MinMax(iDepth + 1, False);
              arrBoard[I] := 0;
              if iScore > iBestScore then
                iBestScore := iScore;
            end;
        end;
    end
  else
    begin
      iBestScore := 800;
        for I := 1 to 9 do
        begin
          if arrBoard[I] = 0 then
            begin
              arrBoard[I] := 2;
              iScore := MinMax(iDepth + 1, True);
              arrBoard[I] := 0;
              if iScore < iBestScore then
                iBestScore := iScore;
            end;
        end;
    end;

  Result := iBestScore;



end;

procedure TfrmTicTacToe.Player_Move(iPos: Integer);
begin
  if arrBoard[iPos] = 0 then
    begin
      arrBoard[iPos] := 2;
      Display_Board;
      if CheckDraw then
        begin
          showmessage('Draw');
          Reset_Board;
        end;
      if CheckWin(1) then
        begin
          showmessage('You lose!!');
          Reset_Board;
        end
      else
      if CheckWin(2) then
        begin
          showmessage('You Win!!');
          Reset_Board;
        end;
      AI_Move;
    end
    else
      showmessage('Please select an empty space.')
end;

procedure TfrmTicTacToe.Reset_Board;
var
  I : Integer;
begin
  for I := 1 to 9 do
    arrBoard[I] := 0;

  Display_Board;

end;

procedure TfrmTicTacToe.AI_Move;
var
  iScore, iBestScore, iBestMove, I: Integer;
begin
  iBestScore := -800;
  iBestMove := 0;
  for I := 1 to 9 do
    begin
      if (arrBoard[I] = 0) then
        begin
          arrBoard[I] := 1;
          iScore := MinMax(0,False);
          arrBoard[I] := 0;
          if iScore > iBestScore then
            begin
              iBestScore := iScore;
              iBestMove := I;
            end;
        end;
    end;
  arrBoard[iBestMove] := 1;
  Display_Board;
  if CheckWin(1) then
    begin
      showmessage('You Lose!!');
      Reset_Board;
      exit;
    end;
  if CheckDraw then
    begin
      showmessage('Draw!!');
      Reset_Board;
    end;
end;

end.
