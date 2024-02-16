unit Shared;{22.Cze.2023}

interface

uses
  Text__Search_Replace,

  System.SysUtils, System.Classes, System.ImageList, Vcl.ImgList, Vcl.Controls,
  SynEditHighlighter, SynEditMiscClasses, SynEditSearch, SynEditRegexSearch,

  SynEditCodeFolding,

  SynHighlighterADSP21xx,
  SynHighlighterAsm,
  SynHighlighterAWK,
  SynHighlighterBaan,
  SynHighlighterBat,
  SynHighlighterCache,
  SynHighlighterCAC,
  SynHighlighterCobol,
  SynHighlighterCPM,
  SynHighlighterCpp,
  SynHighlighterCss,
  SynHighlighterCS,
  SynHighlighterDfm,
  SynHighlighterDml,
  SynHighlighterDOT,
  SynHighlighterDWS,
  SynHighlighterEiffel,
  SynHighlighterFortran,
  SynHighlighterFoxpro,
  SynHighlighterGalaxy,
  SynHighlighterGeneral,
  SynHighlighterGWS, //SynHighlighterGWScript
  SynHighlighterHaskell,
  SynHighlighterHC11,
  //SynHighlighterHP48, // Range check error in function SynHighlighterHP48.TSpeedStringList.AddObj(const Value: TSpeedListObject): Integer; line 283 Datas[crc][DatasUsed[crc]] := Value; procedure SynHighlighterHP48.TSpeedStringList.SetStringList( TSpeedStringList.SetStringList i = 10 SKIPYES; line 469 AddObj(TSpeedListObject.Create(value[i]));
  SynHighlighterHTML,
  SynHighlighterIdl,
  SynHighlighterIni,
  SynHighlighterInno,
  SynHighlighterJava,
  SynHighlighterJScript,
  SynHighlighterJSON,
  SynHighlighterKix,
  SynHighlighterLDraw, //SynHighlighterLDR
  SynHighlighterM3,
  SynHighlighterModelica,
  SynHighlighterMsg,
  SynHighlighterPas,
  SynHighlighterPerl,
  SynHighlighterPHP,
  SynHighlighterProgress,
  SynHighlighterPython,
  SynHighlighterRC,
  SynHighlighterRuby,
  SynHighlighterSDD,
  SynHighlighterSML,
  SynHighlighterSQL,
  SynHighlighterST,
  SynHighlighterTclTk,
  SynHighlighterTeX,
  SynHighlighterUNIXShellScript,
  SynHighlighterUnreal,
  SynHighlighterURI,
  SynHighlighterVB,
  SynHighlighterVBScript,
  SynHighlighterVrml97,
  SynHighlighterXML;

type
  TShared_DataModule = class( TDataModule )
    ImageList1: TImageList;
    SynSQLSyn1: TSynSQLSyn;
    SynEditSearch1: TSynEditSearch;
    SynEditRegexSearch1: TSynEditRegexSearch;
    SynADSP21xxSyn1: TSynADSP21xxSyn;
    SynAsmSyn1: TSynAsmSyn;
    SynAWKSyn1: TSynAWKSyn;
    SynBaanSyn1: TSynBaanSyn;
    SynBatSyn1: TSynBatSyn;
    SynCacheSyn1: TSynCacheSyn;
    SynCACSyn1: TSynCACSyn;
    SynCobolSyn1: TSynCobolSyn;
    SynCPMSyn1: TSynCPMSyn;
    SynCppSyn1: TSynCppSyn;
    SynCssSyn1: TSynCssSyn;
    SynCSSyn1: TSynCSSyn;
    SynDfmSyn1: TSynDfmSyn;
    SynDmlSyn1: TSynDmlSyn;
    SynDOTSyn1: TSynDOTSyn;
    SynDWSSyn1: TSynDWSSyn;
    SynEiffelSyn1: TSynEiffelSyn;
    SynFortranSyn1: TSynFortranSyn;
    SynFoxproSyn1: TSynFoxproSyn;
    SynGalaxySyn1: TSynGalaxySyn;
    SynGeneralSyn1: TSynGeneralSyn;
    SynGWScriptSyn1: TSynGWScriptSyn;
    SynHaskellSyn1: TSynHaskellSyn;
    SynHC11Syn1: TSynHC11Syn;
    SynHTMLSyn1: TSynHTMLSyn;
    SynIdlSyn1: TSynIdlSyn;
    SynIniSyn1: TSynIniSyn;
    SynInnoSyn1: TSynInnoSyn;
    SynJavaSyn1: TSynJavaSyn;
    SynJScriptSyn1: TSynJScriptSyn;
    SynJSONSyn1: TSynJSONSyn;
    SynKixSyn1: TSynKixSyn;
    SynLDRSyn1: TSynLDRSyn;
    SynM3Syn1: TSynM3Syn;
    SynModelicaSyn1: TSynModelicaSyn;
    SynMsgSyn1: TSynMsgSyn;
    SynPasSyn1: TSynPasSyn;
    SynPerlSyn1: TSynPerlSyn;
    SynPHPSyn1: TSynPHPSyn;
    SynProgressSyn1: TSynProgressSyn;
    SynPythonSyn1: TSynPythonSyn;
    SynRCSyn1: TSynRCSyn;
    SynRubySyn1: TSynRubySyn;
    SynSDDSyn1: TSynSDDSyn;
    SynSMLSyn1: TSynSMLSyn;
    SynSTSyn1: TSynSTSyn;
    SynTclTkSyn1: TSynTclTkSyn;
    SynTeXSyn1: TSynTeXSyn;
    SynUNIXShellScriptSyn1: TSynUNIXShellScriptSyn;
    SynUnrealSyn1: TSynUnrealSyn;
    SynURISyn1: TSynURISyn;
    SynVBSyn1: TSynVBSyn;
    SynVBScriptSyn1: TSynVBScriptSyn;
    SynVrml97Syn1: TSynVrml97Syn;
    SynXMLSyn1: TSynXMLSyn;

    procedure DataModuleCreate( Sender: TObject );
    procedure DataModuleDestroy( Sender: TObject );
  private
    { Private declarations }
  public
    { Public declarations }
    text__search_replace_form__shared : Text__Search_Replace.TText__Search_Replace_Form;

    procedure Syn_Edit__Highlight__Manager_Names__Get( string_list_f : TStringList );
    function Syn_Edit__Highlighter__Get( const highlighter_name_f : string ) : SynEditHighlighter.TSynCustomHighlighter;
  end;

const
  sql_editor__highlights__syntax__none_c : string = '<none>';

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

procedure TShared_DataModule.Syn_Edit__Highlight__Manager_Names__Get( string_list_f : TStringList );
var
  i,
  j,
  zti
    : integer;

  zt_string_list : TStringList;
begin

  if string_list_f = nil then
    Exit;


  zt_string_list := TStringList.Create();


  for i := 0 to Self.ComponentCount - 1 do
    if   (
               ( Self.Components[ i ].ClassParent <> nil )
           and ( Self.Components[ i ].ClassParent = TSynCustomHighlighter )
         )
      or (
               ( Self.Components[ i ].ClassParent <> nil )
           and ( Self.Components[ i ].ClassParent.ClassParent <> nil )
           and ( Self.Components[ i ].ClassParent.ClassParent = TSynCustomHighlighter )
         ) then
      begin

        zt_string_list.Add
          (
            AnsiLowerCase
              (
                TSynCustomHighlighter(Self.Components[ i ]).GetFriendlyLanguageName +
                Self.Components[ i ].Name
              )
          );


        string_list_f.Add
          (
            TSynCustomHighlighter(Self.Components[ i ]).GetFriendlyLanguageName
          );

        string_list_f.Add
          (
            Self.Components[ i ].Name
          );

      end;


  zt_string_list.Sort();


  // Sorting.
  zti := 0;

  for i := 0 to zt_string_list.Count - 1 do
    begin

      j := zti;

      while j <= string_list_f.Count - 2 do
        begin

          if zt_string_list[ i ] = AnsiLowerCase( string_list_f[ j ] + string_list_f[ j + 1 ] ) then
            begin

              if   ( string_list_f[ zti ] <> string_list_f[ j ] )
                or ( string_list_f[ zti + 1 ] <> string_list_f[ j + 1 ] ) then
                begin

                  string_list_f.Move( j, zti );
                  string_list_f.Move( j + 1, zti + 1 );

                end;


              zti := zti + 2;

              Break;

            end;

          j := j + 2;

        end;

    end;
  //---// Sorting.

  zt_string_list.Clear();
  FreeAndNil( zt_string_list );

end;

function TShared_DataModule.Syn_Edit__Highlighter__Get( const highlighter_name_f : string ) : SynEditHighlighter.TSynCustomHighlighter;
begin

  if highlighter_name_f = sql_editor__highlights__syntax__none_c then
    begin

      Result := nil;

      Exit;

    end;


  Result := SynEditHighlighter.TSynCustomHighlighter(Self.FindComponent( highlighter_name_f ));


  if Result = nil then
    Result := SynSQLSyn1;

end;

end.
