program frmTicTacToeAI_p;

uses
  Forms,
  frmTicTacToeAI_u in 'frmTicTacToeAI_u.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmTicTacToe, frmTicTacToe);
  Application.Run;
end.
