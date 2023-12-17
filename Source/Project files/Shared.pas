unit Shared;{22.Cze.2023}

interface

uses
  Text__Search_Replace,

  System.SysUtils, System.Classes, System.ImageList, Vcl.ImgList, Vcl.Controls,
  SynEditHighlighter, SynHighlighterSQL, SynEditMiscClasses, SynEditSearch, SynEditRegexSearch;

type
  TShared_DataModule = class( TDataModule )
    ImageList1: TImageList;
    Sql_Text__SynSQLSyn: TSynSQLSyn;
    SynEditSearch1: TSynEditSearch;
    SynEditRegexSearch1: TSynEditRegexSearch;
    procedure DataModuleCreate( Sender: TObject );
    procedure DataModuleDestroy( Sender: TObject );
  private
    { Private declarations }
  public
    { Public declarations }
    text__search_replace_form__shared : Text__Search_Replace.TText__Search_Replace_Form;
  end;

var
  Shared_DataModule: TShared_DataModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TShared_DataModule.DataModuleCreate( Sender: TObject );
begin

  text__search_replace_form__shared := nil;

end;

procedure TShared_DataModule.DataModuleDestroy( Sender: TObject );
begin

  if text__search_replace_form__shared <> nil then
    FreeAndNil( text__search_replace_form__shared );

end;

end.
