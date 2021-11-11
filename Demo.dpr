{ ********************************************************************** }
{  DEMO 1.0b - Dises Game Engine 2008 by Daniela Auriema                 }
{                                                                        }
{  This program is free software: you can redistribute it and/or modify  }
{  it under the terms of the GNU General Public License as published by  }
{  the Free Software Foundation, either version 3 of the License, or     }
{  any later version.                                                    }
{                                                                        }
{  This program is distributed in the hope that it will be useful,       }
{  but WITHOUT ANY WARRANTY; without even the implied warranty of        }
{  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the          }
{   GNU General Public License for more details. (www.gnu.org)           }
{                                                                        }
{  https://github.com/danielaauriema/Danyz10b                            }
{                                                                        }
{ ********************************************************************** }

program Demo;

uses
  Forms,
  Dises,
  Megaman in 'Megaman.pas' {dmMegaman: TDataModule},
  Monstros in 'Monstros.pas' {dmMonstros: TDataModule},
  GAME01 in 'GAME01.pas' {dmDEMO_01: TDataModule},
  Config in 'Config.pas' {frmConfig};

{$R *.res}
begin
  Application.Initialize;
  Application.Title := 'Danyz10b';
  Application.CreateForm(TDxForm, DxForm);
  Application.CreateForm(TdmDEMO_01, dmDEMO_01);
  Application.CreateForm(TdmMegaman, dmMegaman);
  Application.CreateForm(TdmMonstros, dmMonstros);
  Application.Run;
end.
