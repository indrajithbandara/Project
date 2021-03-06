unit Exercicio3DMUn;

interface

uses
  System.SysUtils, System.Classes, Data.DBXFirebird, Data.DB, Data.SqlExpr,
  Data.FMTBcd, Datasnap.Provider, Datasnap.DBClient;

type
  TExercicio3DM = class(TDataModule)
    DBSQLConnection: TSQLConnection;
    PessoaSQLDataSet: TSQLDataSet;
    PessoaSQLDataSetCDPESSOA: TIntegerField;
    PessoaSQLDataSetNMPESSOA: TStringField;
    PessoaSQLDataSetDELOGRADOURO: TStringField;
    PessoaSQLDataSetDEBAIRRO: TStringField;
    PessoaSQLDataSetCDCIDADE: TIntegerField;
    PessoaDataSetProvider: TDataSetProvider;
    PessoaClientDataSet: TClientDataSet;
    PessoaClientDataSetCDPESSOA: TIntegerField;
    PessoaClientDataSetNMPESSOA: TStringField;
    PessoaClientDataSetDELOGRADOURO: TStringField;
    PessoaClientDataSetDEBAIRRO: TStringField;
    PessoaClientDataSetCDCIDADE: TIntegerField;
    CidadeSQLDataSet: TSQLDataSet;
    CidadeDataSetProvider: TDataSetProvider;
    CidadeClientDataSet: TClientDataSet;
    CidadeSQLDataSetCDCIDADE: TIntegerField;
    CidadeSQLDataSetNMCIDADE: TStringField;
    CidadeSQLDataSetUF: TStringField;
    CidadeClientDataSetCDCIDADE: TIntegerField;
    CidadeClientDataSetNMCIDADE: TStringField;
    CidadeClientDataSetUF: TStringField;
    PesquisaCidadeSQLDataSet: TSQLDataSet;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    StringField2: TStringField;
    PesquisaCidadeProvider: TDataSetProvider;
    PesquisaCidadeClientDataSet: TClientDataSet;
    IntegerField2: TIntegerField;
    StringField3: TStringField;
    StringField4: TStringField;
    PesquisaPessoaSQLDataSet: TSQLDataSet;
    PesquisaPessoaProvider: TDataSetProvider;
    PesquisaPessoaClientDataSet: TClientDataSet;
    PesquisaPessoaSQLDataSetCDPESSOA: TIntegerField;
    PesquisaPessoaSQLDataSetDEBAIRRO: TStringField;
    PesquisaPessoaSQLDataSetDELOGRADOURO: TStringField;
    PesquisaPessoaSQLDataSetNMPESSOA: TStringField;
    PesquisaPessoaClientDataSetCDPESSOA: TIntegerField;
    PesquisaPessoaClientDataSetDEBAIRRO: TStringField;
    PesquisaPessoaClientDataSetDELOGRADOURO: TStringField;
    PesquisaPessoaClientDataSetNMPESSOA: TStringField;
    PesquisaPessoaSQLDataSetNMCIDADE: TStringField;
    PesquisaPessoaClientDataSetNMCIDADE: TStringField;
    ArquivoSQLDataSet: TSQLDataSet;
    ArquivoDataSetProvider: TDataSetProvider;
    ArquivoClientDataSet: TClientDataSet;
    ArquivoSQLDataSetNMPESSOA: TStringField;
    ArquivoSQLDataSetNMCIDADE: TStringField;
    ArquivoSQLDataSetUF: TStringField;
    procedure PessoaClientDataSetNewRecord(DataSet: TDataSet);
    procedure DBSQLConnectionBeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SelectCidadeById(const aId: integer);
    function geNextIdPessoa: integer;
  end;

var
  Exercicio3DM: TExercicio3DM;

implementation

uses Forms;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TExercicio3DM }

procedure TExercicio3DM.DBSQLConnectionBeforeConnect(Sender: TObject);
var
  _iniParams: TStringList;
  _i: integer;
begin
  _iniParams := TStringList.Create;
  try
    _iniParams.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Parametros.ini');
    for _i := 0 to _iniParams.Count - 1 do
      DBSQLConnection.Params.Values[_iniParams.Names[_i]] := _iniParams.ValueFromIndex[_i];
  finally
    _iniParams.Free;
  end;
end;

function TExercicio3DM.geNextIdPessoa: integer;
var
  _qry: TSQLDataSet;
begin
  _qry := TSQLDataSet.Create(Self);
  try
    _qry.SQLConnection := Self.DBSQLConnection;
    _qry.CommandText := 'SELECT GEN_ID( Pessoa_Generator, 1 ) FROM RDB$DATABASE;';
    _qry.Open;
    Result := _qry.Fields[0].AsInteger;
  finally
    _qry.Free;
  end;

end;

procedure TExercicio3DM.PessoaClientDataSetNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('cdPessoa').AsInteger := Self.geNextIdPessoa;
  CidadeClientDataSet.Close;
end;

procedure TExercicio3DM.SelectCidadeById(const aId: integer);
begin
  CidadeClientDataSet.Close;
  CidadeClientDataSet.ParamByName('Codigo').AsInteger := aId;
  CidadeClientDataSet.Open;
end;

end.
