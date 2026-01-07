unit OLValidationLocalization;

interface

{$IF CompilerVersion >= 34.0}

uses
  SysUtils,
  OLDictionaries,
  OLStringType;

type
  /// <summary>Record containing localized message dictionaries for all validation rules.</summary>
  TValidationMessagesTranslations = record
    // Generic
    Required: OLStrStrDictionary;
    InvalidValue: OLStrStrDictionary;

    // Integer / Numeric
    MinInt: OLStrStrDictionary;
    MaxInt: OLStrStrDictionary;
    BetweenInt: OLStrStrDictionary;
    MinDouble: OLStrStrDictionary;
    MaxDouble: OLStrStrDictionary;
    BetweenDouble: OLStrStrDictionary;
    MinCurrency: OLStrStrDictionary;
    MaxCurrency: OLStrStrDictionary;
    BetweenCurrency: OLStrStrDictionary;
    Positive: OLStrStrDictionary;
    Negative: OLStrStrDictionary;

    // String
    MinLength: OLStrStrDictionary;
    MaxLength: OLStrStrDictionary;
    AlphaNumeric: OLStrStrDictionary;
    DigitsOnly: OLStrStrDictionary;
    Email: OLStrStrDictionary;
    Url: OLStrStrDictionary;
    CreditCard: OLStrStrDictionary;
    Ean: OLStrStrDictionary;
    Bic: OLStrStrDictionary;
    Ipv4: OLStrStrDictionary;
    Ipv6: OLStrStrDictionary;
    Iban: OLStrStrDictionary;
    Pesel: OLStrStrDictionary;
    Nip: OLStrStrDictionary;

    // Password granular
    PassRequired: OLStrStrDictionary;
    PassTooShort: OLStrStrDictionary;
    PassMixedCase: OLStrStrDictionary;
    PassDigit: OLStrStrDictionary;
    PassSpecial: OLStrStrDictionary;

    // Date / DateTime
    PastDate: OLStrStrDictionary;
    FutureDate: OLStrStrDictionary;
    AfterDate: OLStrStrDictionary;
    BeforeDate: OLStrStrDictionary;
    MinDate: OLStrStrDictionary;
    MaxDate: OLStrStrDictionary;
    BetweenDate: OLStrStrDictionary;
    Today: OLStrStrDictionary;
    MinAge: OLStrStrDictionary;
    MaxAge: OLStrStrDictionary;
    IsWeekday: OLStrStrDictionary;
    IsWeekend: OLStrStrDictionary;
    
    PastDateTime: OLStrStrDictionary;
    FutureDateTime: OLStrStrDictionary;
    AfterDateTime: OLStrStrDictionary;
    BeforeDateTime: OLStrStrDictionary;
    BetweenDateTime: OLStrStrDictionary;
  end;

var
  ValidationMessages: TValidationMessagesTranslations;

/// <summary>
///   Returns a localized message from the dictionary based on current OS language.
///   Falls back to 'EN' if preferred language is missing.
/// </summary>
function GetLocalizedMessage(const ADict: OLStrStrDictionary; const DefaultEN: string): string;

/// <summary>
///   Initializes the global registry with default translations for all supported languages
///   (EN, PL, ES, DE, FR, IT, ZH, JA, PT).
/// </summary>
procedure InitializeDefaultTranslations;

{$IFEND}

implementation

{$IF CompilerVersion >= 34.0}

uses
  {$IF CompilerVersion >= 23.0} Winapi.Windows, System.StrUtils {$ELSE} Windows, StrUtils {$IFEND};

function GetCurrentLangCode: string;
var
  Buffer: array[0..9] of Char;
begin
  // Use GetLocaleInfo for broad compatibility (Delphi 2010+)
  if GetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_SISO639LANGNAME, Buffer, 10) > 0 then
    Result := UpperCase(string(Buffer))
  else
    Result := 'EN';
end;

function GetLocalizedMessage(const ADict: OLStrStrDictionary; const DefaultEN: string): string;
var
  LangCode: string;
  Msg: OLString;
begin
  LangCode := GetCurrentLangCode;
  if ADict.TryGetValue(LangCode, Msg) then
    Result := Msg
  else if ADict.TryGetValue('EN', Msg) then
    Result := Msg
  else
    Result := DefaultEN;
end;

procedure SetEnglish;
begin
  ValidationMessages.Required['EN'] := 'Field is required.';
  ValidationMessages.InvalidValue['EN'] := 'Invalid value.';
  ValidationMessages.MinInt['EN'] := 'Value must be at least %d.';
  ValidationMessages.MaxInt['EN'] := 'Value cannot exceed %d.';
  ValidationMessages.BetweenInt['EN'] := 'Value must be between %d and %d.';
  ValidationMessages.MinDouble['EN'] := 'Value must be at least %g.';
  ValidationMessages.MaxDouble['EN'] := 'Value cannot exceed %g.';
  ValidationMessages.BetweenDouble['EN'] := 'Value must be between %g and %g.';
  ValidationMessages.MinCurrency['EN'] := 'Value must be at least %m.';
  ValidationMessages.MaxCurrency['EN'] := 'Value cannot exceed %m.';
  ValidationMessages.BetweenCurrency['EN'] := 'Value must be between %m and %m.';
  ValidationMessages.Positive['EN'] := 'Value must be positive.';
  ValidationMessages.Negative['EN'] := 'Value must be negative.';
  ValidationMessages.MinLength['EN'] := 'Length must be at least %d characters.';
  ValidationMessages.MaxLength['EN'] := 'Length cannot exceed %d characters.';
  ValidationMessages.AlphaNumeric['EN'] := 'Only letters and digits are allowed.';
  ValidationMessages.DigitsOnly['EN'] := 'Only digits are allowed.';
  ValidationMessages.Email['EN'] := 'Invalid email format.';
  ValidationMessages.Url['EN'] := 'Invalid URL (must start with http://, https:// or ftp://).';
  ValidationMessages.CreditCard['EN'] := 'Invalid credit card number (Luhn check failed).';
  ValidationMessages.Ean['EN'] := 'Invalid EAN/GTIN check digit.';
  ValidationMessages.Bic['EN'] := 'Invalid BIC/SWIFT code (must be 8 or 11 characters).';
  ValidationMessages.Ipv4['EN'] := 'Invalid IPv4 address.';
  ValidationMessages.Ipv6['EN'] := 'Invalid IPv6 address.';
  ValidationMessages.Iban['EN'] := 'Invalid IBAN.';
  ValidationMessages.Pesel['EN'] := 'Invalid PESEL number.';
  ValidationMessages.Nip['EN'] := 'Invalid NIP number.';
  ValidationMessages.PassRequired['EN'] := 'Password is required.';
  ValidationMessages.PassTooShort['EN'] := 'Password must be at least %d characters long.';
  ValidationMessages.PassMixedCase['EN'] := 'Password must contain both upper and lower case letters.';
  ValidationMessages.PassDigit['EN'] := 'Password must contain at least one digit.';
  ValidationMessages.PassSpecial['EN'] := 'Password must contain at least one special character.';
  ValidationMessages.PastDate['EN'] := 'Date must be in the past.';
  ValidationMessages.FutureDate['EN'] := 'Date must be in the future.';
  ValidationMessages.AfterDate['EN'] := 'Date must be after %s.';
  ValidationMessages.BeforeDate['EN'] := 'Date must be before %s.';
  ValidationMessages.MinDate['EN'] := 'Date must be on or after %s.';
  ValidationMessages.MaxDate['EN'] := 'Date must be on or before %s.';
  ValidationMessages.BetweenDate['EN'] := 'Date must be between %s and %s.';
  ValidationMessages.Today['EN'] := 'Date must be today.';
  ValidationMessages.MinAge['EN'] := 'You must be at least %d years old.';
  ValidationMessages.MaxAge['EN'] := 'Age cannot exceed %d years.';
  ValidationMessages.IsWeekday['EN'] := 'Date must be a weekday (Monday-Friday).';
  ValidationMessages.IsWeekend['EN'] := 'Date must be a weekend (Saturday-Sunday).';
  ValidationMessages.PastDateTime['EN'] := 'Date and time must be in the past.';
  ValidationMessages.FutureDateTime['EN'] := 'Date and time must be in the future.';
  ValidationMessages.AfterDateTime['EN'] := 'Date and time must be after %s.';
  ValidationMessages.BeforeDateTime['EN'] := 'Date and time must be before %s.';
  ValidationMessages.BetweenDateTime['EN'] := 'Date and time must be between %s and %s.';
end;

procedure SetPolish;
begin
  ValidationMessages.Required['PL'] := 'Pole jest wymagane.';
  ValidationMessages.InvalidValue['PL'] := 'Nieprawidłowa wartość.';
  ValidationMessages.MinInt['PL'] := 'Minimalna wartość to %d.';
  ValidationMessages.MaxInt['PL'] := 'Maksymalna wartość to %d.';
  ValidationMessages.BetweenInt['PL'] := 'Wartość musi mieścić się w zakresie od %d do %d.';
  ValidationMessages.MinDouble['PL'] := 'Minimalna wartość to %g.';
  ValidationMessages.MaxDouble['PL'] := 'Maksymalna wartość to %g.';
  ValidationMessages.BetweenDouble['PL'] := 'Wartość musi mieścić się w zakresie od %g do %g.';
  ValidationMessages.MinCurrency['PL'] := 'Minimalna wartość to %m.';
  ValidationMessages.MaxCurrency['PL'] := 'Maksymalna wartość to %m.';
  ValidationMessages.BetweenCurrency['PL'] := 'Wartość musi mieścić się w zakresie od %m do %m.';
  ValidationMessages.Positive['PL'] := 'Wartość musi być dodatnia.';
  ValidationMessages.Negative['PL'] := 'Wartość musi być ujemna.';
  ValidationMessages.MinLength['PL'] := 'Minimalna długość to %d znaków.';
  ValidationMessages.MaxLength['PL'] := 'Maksymalna długość to %d znaków.';
  ValidationMessages.AlphaNumeric['PL'] := 'Dozwolone są tylko litery i cyfry.';
  ValidationMessages.DigitsOnly['PL'] := 'Dozwolone są tylko cyfry.';
  ValidationMessages.Email['PL'] := 'Nieprawidłowy format adresu email.';
  ValidationMessages.Url['PL'] := 'Nieprawidłowy adres URL (musi zaczynać się od http://, https:// lub ftp://).';
  ValidationMessages.CreditCard['PL'] := 'Nieprawidłowy numer karty kredytowej (błąd sumy kontrolnej).';
  ValidationMessages.Ean['PL'] := 'Nieprawidłowa cyfra kontrolna EAN/GTIN.';
  ValidationMessages.Bic['PL'] := 'Nieprawidłowy kod BIC/SWIFT (musi mieć 8 lub 11 znaków).';
  ValidationMessages.Ipv4['PL'] := 'Nieprawidłowy adres IPv4.';
  ValidationMessages.Ipv6['PL'] := 'Nieprawidłowy adres IPv6.';
  ValidationMessages.Iban['PL'] := 'Nieprawidłowy numer IBAN.';
  ValidationMessages.Pesel['PL'] := 'Nieprawidłowy numer PESEL.';
  ValidationMessages.Nip['PL'] := 'Nieprawidłowy numer NIP.';
  ValidationMessages.PassRequired['PL'] := 'Hasło jest wymagane.';
  ValidationMessages.PassTooShort['PL'] := 'Hasło musi mieć co najmniej %d znaków.';
  ValidationMessages.PassMixedCase['PL'] := 'Hasło musi zawierać małe i wielkie litery.';
  ValidationMessages.PassDigit['PL'] := 'Hasło musi zawierać co najmniej jedną cyfrę.';
  ValidationMessages.PassSpecial['PL'] := 'Hasło musi zawierać co najmniej jeden znak specjalny.';
  ValidationMessages.PastDate['PL'] := 'Data musi być z przeszłości.';
  ValidationMessages.FutureDate['PL'] := 'Data musi być z przyszłości.';
  ValidationMessages.AfterDate['PL'] := 'Data musi być po %s.';
  ValidationMessages.BeforeDate['PL'] := 'Data musi być przed %s.';
  ValidationMessages.MinDate['PL'] := 'Minimalna data to %s.';
  ValidationMessages.MaxDate['PL'] := 'Maksymalna data to %s.';
  ValidationMessages.BetweenDate['PL'] := 'Data musi mieścić się w zakresie od %s do %s.';
  ValidationMessages.Today['PL'] := 'Data musi być dzisiejsza.';
  ValidationMessages.MinAge['PL'] := 'Musisz mieć co najmniej %d lat.';
  ValidationMessages.MaxAge['PL'] := 'Wiek nie może przekraczać %d lat.';
  ValidationMessages.IsWeekday['PL'] := 'Data musi być dniem roboczym (Pn-Pt).';
  ValidationMessages.IsWeekend['PL'] := 'Data musi być dniem weekendowym (So-Nd).';
  ValidationMessages.PastDateTime['PL'] := 'Data i czas muszą być z przeszłości.';
  ValidationMessages.FutureDateTime['PL'] := 'Data i czas muszą być z przyszłości.';
  ValidationMessages.AfterDateTime['PL'] := 'Data i czas muszą być po %s.';
  ValidationMessages.BeforeDateTime['PL'] := 'Data i czas muszą być przed %s.';
  ValidationMessages.BetweenDateTime['PL'] := 'Data i czas muszą być w zakresie od %s do %s.';
end;

procedure SetSpanish;
begin
  ValidationMessages.Required['ES'] := 'El campo es obligatorio.';
  ValidationMessages.InvalidValue['ES'] := 'Valor no válido.';
  ValidationMessages.MinInt['ES'] := 'El valor debe ser al menos %d.';
  ValidationMessages.MaxInt['ES'] := 'El valor no puede exceder %d.';
  ValidationMessages.BetweenInt['ES'] := 'El valor debe estar entre %d y %d.';
  ValidationMessages.MinDouble['ES'] := 'El valor debe ser al menos %g.';
  ValidationMessages.MaxDouble['ES'] := 'El valor no puede exceder %g.';
  ValidationMessages.BetweenDouble['ES'] := 'El valor debe estar entre %g y %g.';
  ValidationMessages.MinCurrency['ES'] := 'El valor debe ser al menos %m.';
  ValidationMessages.MaxCurrency['ES'] := 'El valor no puede exceder %m.';
  ValidationMessages.BetweenCurrency['ES'] := 'El valor debe estar entre %m y %m.';
  ValidationMessages.Positive['ES'] := 'El valor debe ser positivo.';
  ValidationMessages.Negative['ES'] := 'El valor debe ser negativo.';
  ValidationMessages.MinLength['ES'] := 'La longitud debe ser de al menos %d caracteres.';
  ValidationMessages.MaxLength['ES'] := 'La longitud no puede exceder los %d caracteres.';
  ValidationMessages.AlphaNumeric['ES'] := 'Solo se permiten letras y dígitos.';
  ValidationMessages.DigitsOnly['ES'] := 'Solo se permiten dígitos.';
  ValidationMessages.Email['ES'] := 'Formato de correo electrónico no válido.';
  ValidationMessages.Url['ES'] := 'URL no válida (debe comenzar con http://, https:// o ftp://).';
  ValidationMessages.CreditCard['ES'] := 'Número de tarjeta de crédito no válido (falló la comprobación de Luhn).';
  ValidationMessages.Ean['ES'] := 'Dígito de control EAN/GTIN no válido.';
  ValidationMessages.Bic['ES'] := 'Código BIC/SWIFT no válido (debe tener 8 u 11 caracteres).';
  ValidationMessages.Ipv4['ES'] := 'Dirección IPv4 no válida.';
  ValidationMessages.Ipv6['ES'] := 'Dirección IPv6 no válida.';
  ValidationMessages.Iban['ES'] := 'IBAN no válido.';
  ValidationMessages.Pesel['ES'] := 'Número PESEL no válido.';
  ValidationMessages.Nip['ES'] := 'Número NIP no válido.';
  ValidationMessages.PassRequired['ES'] := 'La contraseña es obligatoria.';
  ValidationMessages.PassTooShort['ES'] := 'La contraseña debe tener al menos %d caracteres.';
  ValidationMessages.PassMixedCase['ES'] := 'La contraseña debe contener letras mayúsculas y minúsculas.';
  ValidationMessages.PassDigit['ES'] := 'La contraseña debe contener al menos un dígito.';
  ValidationMessages.PassSpecial['ES'] := 'La contraseña debe contener al menos un carácter especial.';
  ValidationMessages.PastDate['ES'] := 'La fecha debe ser anterior.';
  ValidationMessages.FutureDate['ES'] := 'La fecha debe ser posterior.';
  ValidationMessages.AfterDate['ES'] := 'La fecha debe ser después de %s.';
  ValidationMessages.BeforeDate['ES'] := 'La fecha debe ser antes de %s.';
  ValidationMessages.MinDate['ES'] := 'La fecha mínima es %s.';
  ValidationMessages.MaxDate['ES'] := 'La fecha máxima es %s.';
  ValidationMessages.BetweenDate['ES'] := 'La fecha debe estar entre %s y %s.';
  ValidationMessages.Today['ES'] := 'La fecha debe ser hoy.';
  ValidationMessages.MinAge['ES'] := 'Debes tener al menos %d años.';
  ValidationMessages.MaxAge['ES'] := 'La edad no puede exceder los %d años.';
  ValidationMessages.IsWeekday['ES'] := 'La fecha debe ser un día laborable (lunes a viernes).';
  ValidationMessages.IsWeekend['ES'] := 'La fecha debe ser un fin de semana (sábado-domingo).';
  ValidationMessages.PastDateTime['ES'] := 'La fecha y la hora deben ser anteriores.';
  ValidationMessages.FutureDateTime['ES'] := 'La fecha y la hora deben ser posteriores.';
  ValidationMessages.AfterDateTime['ES'] := 'La fecha y la hora deben ser después de %s.';
  ValidationMessages.BeforeDateTime['ES'] := 'La fecha y la hora deben ser antes de %s.';
  ValidationMessages.BetweenDateTime['ES'] := 'La fecha y la hora deben estar entre %s y %s.';
end;

procedure SetGerman;
begin
  ValidationMessages.Required['DE'] := 'Feld ist erforderlich.';
  ValidationMessages.InvalidValue['DE'] := 'Ungültiger Wert.';
  ValidationMessages.MinInt['DE'] := 'Der Wert muss mindestens %d sein.';
  ValidationMessages.MaxInt['DE'] := 'Der Wert darf %d nicht überschreiten.';
  ValidationMessages.BetweenInt['DE'] := 'Der Wert muss zwischen %d und %d liegen.';
  ValidationMessages.MinDouble['DE'] := 'Der Wert muss mindestens %g sein.';
  ValidationMessages.MaxDouble['DE'] := 'Der Wert darf %g nicht überschreiten.';
  ValidationMessages.BetweenDouble['DE'] := 'Der Wert muss zwischen %g und %g liegen.';
  ValidationMessages.MinCurrency['DE'] := 'Der Wert muss mindestens %m sein.';
  ValidationMessages.MaxCurrency['DE'] := 'Der Wert darf %m nicht überschreiten.';
  ValidationMessages.BetweenCurrency['DE'] := 'Der Wert muss zwischen %m und %m liegen.';
  ValidationMessages.Positive['DE'] := 'Der Wert muss positiv sein.';
  ValidationMessages.Negative['DE'] := 'Der Wert muss negativ sein.';
  ValidationMessages.MinLength['DE'] := 'Die Länge muss mindestens %d Zeichen betragen.';
  ValidationMessages.MaxLength['DE'] := 'Die Länge darf %d Zeichen nicht überschreiten.';
  ValidationMessages.AlphaNumeric['DE'] := 'Nur Buchstaben und Ziffern sind erlaubt.';
  ValidationMessages.DigitsOnly['DE'] := 'Nur Ziffern sind erlaubt.';
  ValidationMessages.Email['DE'] := 'Ungültiges E-Mail-Format.';
  ValidationMessages.Url['DE'] := 'Ungültige URL (muss mit http://, https:// oder ftp:// beginnen).';
  ValidationMessages.CreditCard['DE'] := 'Ungültige Kreditkartennummer (Luhn-Prüfung fehlgeschlagen).';
  ValidationMessages.Ean['DE'] := 'Ungültige EAN/GTIN-Prüfziffer.';
  ValidationMessages.Bic['DE'] := 'Ungültiger BIC/SWIFT-Code (muss 8 oder 11 Zeichen lang sein).';
  ValidationMessages.Ipv4['DE'] := 'Ungültige IPv4-Adresse.';
  ValidationMessages.Ipv6['DE'] := 'Ungültige IPv6-Adresse.';
  ValidationMessages.Iban['DE'] := 'Ungültige IBAN.';
  ValidationMessages.Pesel['DE'] := 'Ungültige PESEL-Nummer.';
  ValidationMessages.Nip['DE'] := 'Ungültige NIP-Nummer.';
  ValidationMessages.PassRequired['DE'] := 'Passwort ist erforderlich.';
  ValidationMessages.PassTooShort['DE'] := 'Passwort muss mindestens %d Zeichen lang sein.';
  ValidationMessages.PassMixedCase['DE'] := 'Passwort muss sowohl Groß- als auch Kleinschreibung enthalten.';
  ValidationMessages.PassDigit['DE'] := 'Passwort muss mindestens eine Ziffer enthalten.';
  ValidationMessages.PassSpecial['DE'] := 'Passwort muss mindestens ein Sonderzeichen enthalten.';
  ValidationMessages.PastDate['DE'] := 'Datum muss in der Vergangenheit liegen.';
  ValidationMessages.FutureDate['DE'] := 'Datum muss in der Zukunft liegen.';
  ValidationMessages.AfterDate['DE'] := 'Datum muss nach %s liegen.';
  ValidationMessages.BeforeDate['DE'] := 'Datum muss vor %s liegen.';
  ValidationMessages.MinDate['DE'] := 'Das Datum muss mindestens %s sein.';
  ValidationMessages.MaxDate['DE'] := 'Das Datum darf %s nicht überschreiten.';
  ValidationMessages.BetweenDate['DE'] := 'Datum muss zwischen %s und %s liegen.';
  ValidationMessages.Today['DE'] := 'Datum muss heute sein.';
  ValidationMessages.MinAge['DE'] := 'Sie müssen mindestens %d Jahre alt sein.';
  ValidationMessages.MaxAge['DE'] := 'Das Alter darf %d Jahre nicht überschreiten.';
  ValidationMessages.IsWeekday['DE'] := 'Datum muss ein Wochentag sein (Montag-Freitag).';
  ValidationMessages.IsWeekend['DE'] := 'Datum muss am Wochenende liegen (Samstag-Sonntag).';
  ValidationMessages.PastDateTime['DE'] := 'Datum und Uhrzeit müssen in der Vergangenheit liegen.';
  ValidationMessages.FutureDateTime['DE'] := 'Datum und Uhrzeit müssen in der Zukunft liegen.';
  ValidationMessages.AfterDateTime['DE'] := 'Datum und Uhrzeit müssen nach %s liegen.';
  ValidationMessages.BeforeDateTime['DE'] := 'Datum und Uhrzeit müssen vor %s liegen.';
  ValidationMessages.BetweenDateTime['DE'] := 'Datum und Uhrzeit müssen zwischen %s und %s liegen.';
end;

procedure SetFrench;
begin
  ValidationMessages.Required['FR'] := 'Le champ est obligatoire.';
  ValidationMessages.InvalidValue['FR'] := 'Valeur non valide.';
  ValidationMessages.MinInt['FR'] := 'La valeur doit être d''au moins %d.';
  ValidationMessages.MaxInt['FR'] := 'La valeur ne peut pas dépasser %d.';
  ValidationMessages.BetweenInt['FR'] := 'La valeur doit être comprise entre %d et %d.';
  ValidationMessages.MinDouble['FR'] := 'La valeur doit être d''au moins %g.';
  ValidationMessages.MaxDouble['FR'] := 'La valeur ne peut pas dépasser %g.';
  ValidationMessages.BetweenDouble['FR'] := 'La valeur doit être comprise entre %g et %g.';
  ValidationMessages.MinCurrency['FR'] := 'La valeur doit être d''au moins %m.';
  ValidationMessages.MaxCurrency['FR'] := 'La valeur ne peut pas dépasser %m.';
  ValidationMessages.BetweenCurrency['FR'] := 'La valeur doit être comprise entre %m et %m.';
  ValidationMessages.Positive['FR'] := 'La valeur doit être positive.';
  ValidationMessages.Negative['FR'] := 'La valeur doit être négative.';
  ValidationMessages.MinLength['FR'] := 'La longueur doit être d''au moins %d caractères.';
  ValidationMessages.MaxLength['FR'] := 'La longueur ne peut pas dépasser %d caractères.';
  ValidationMessages.AlphaNumeric['FR'] := 'Seuls les lettres et les chiffres sont autorisés.';
  ValidationMessages.DigitsOnly['FR'] := 'Seuls les chiffres sont autorisés.';
  ValidationMessages.Email['FR'] := 'Format d''e-mail non valide.';
  ValidationMessages.Url['FR'] := 'URL non valide (doit commencer par http://, https:// ou ftp://).';
  ValidationMessages.CreditCard['FR'] := 'Numéro de carte de crédit non valide (échec du test de Luhn).';
  ValidationMessages.Ean['FR'] := 'Chiffre de contrôle EAN/GTIN non valide.';
  ValidationMessages.Bic['FR'] := 'Code BIC/SWIFT non valide (doit comporter 8 ou 11 caractères).';
  ValidationMessages.Ipv4['FR'] := 'Adresse IPv4 non valide.';
  ValidationMessages.Ipv6['FR'] := 'Adresse IPv6 non valide.';
  ValidationMessages.Iban['FR'] := 'IBAN non valide.';
  ValidationMessages.Pesel['FR'] := 'Numéro PESEL non valide.';
  ValidationMessages.Nip['FR'] := 'Numéro NIP non valide.';
  ValidationMessages.PassRequired['FR'] := 'Le mot de passe est obligatoire.';
  ValidationMessages.PassTooShort['FR'] := 'Le mot de passe doit comporter au moins %d caractères.';
  ValidationMessages.PassMixedCase['FR'] := 'Le mot de passe doit contenir des majuscules et des minuscules.';
  ValidationMessages.PassDigit['FR'] := 'Le mot de passe doit contenir au moins un chiffre.';
  ValidationMessages.PassSpecial['FR'] := 'Le mot de passe doit contenir au moins un caractère spécial.';
  ValidationMessages.PastDate['FR'] := 'La date doit être passée.';
  ValidationMessages.FutureDate['FR'] := 'La date doit être future.';
  ValidationMessages.AfterDate['FR'] := 'La date doit être après %s.';
  ValidationMessages.BeforeDate['FR'] := 'La date doit être avant %s.';
  ValidationMessages.MinDate['FR'] := 'La date doit être au moins le %s.';
  ValidationMessages.MaxDate['FR'] := 'La date ne peut pas dépasser le %s.';
  ValidationMessages.BetweenDate['FR'] := 'La date doit être comprise entre %s et %s.';
  ValidationMessages.Today['FR'] := 'La date doit être aujourd''hui.';
  ValidationMessages.MinAge['FR'] := 'Vous devez avoir au moins %d ans.';
  ValidationMessages.MaxAge['FR'] := 'L''âge ne peut pas dépasser %d ans.';
  ValidationMessages.IsWeekday['FR'] := 'La date doit être un jour de semaine (lundi-vendredi).';
  ValidationMessages.IsWeekend['FR'] := 'La date doit être un week-end (samedi-dimanche).';
  ValidationMessages.PastDateTime['FR'] := 'La date et l''heure doivent être passées.';
  ValidationMessages.FutureDateTime['FR'] := 'La date et l''heure doivent être futures.';
  ValidationMessages.AfterDateTime['FR'] := 'La date et l''heure doivent être après %s.';
  ValidationMessages.BeforeDateTime['FR'] := 'La date et l''heure doivent être avant %s.';
  ValidationMessages.BetweenDateTime['FR'] := 'La date et l''heure doivent être comprises entre %s et %s.';
end;

procedure SetItalian;
begin
  ValidationMessages.Required['IT'] := 'Il campo è obbligatorio.';
  ValidationMessages.InvalidValue['IT'] := 'Valore non valido.';
  ValidationMessages.MinInt['IT'] := 'Il valore deve essere almeno %d.';
  ValidationMessages.MaxInt['IT'] := 'Il valore non può superare %d.';
  ValidationMessages.BetweenInt['IT'] := 'Il valore deve essere compreso tra %d e %d.';
  ValidationMessages.MinDouble['IT'] := 'Il valore deve essere almeno %g.';
  ValidationMessages.MaxDouble['IT'] := 'Il valore non può superare %g.';
  ValidationMessages.BetweenDouble['IT'] := 'Il valore deve essere compreso tra %g e %g.';
  ValidationMessages.MinCurrency['IT'] := 'Il valore deve essere almeno %m.';
  ValidationMessages.MaxCurrency['IT'] := 'Il valore non può superare %m.';
  ValidationMessages.BetweenCurrency['IT'] := 'Il valore deve essere compreso tra %m e %m.';
  ValidationMessages.Positive['IT'] := 'Il valore deve essere positivo.';
  ValidationMessages.Negative['IT'] := 'Il valore deve essere negativo.';
  ValidationMessages.MinLength['IT'] := 'La lunghezza deve essere di almeno %d caratteri.';
  ValidationMessages.MaxLength['IT'] := 'La lunghezza non può superare i %d caratteri.';
  ValidationMessages.AlphaNumeric['IT'] := 'Sono ammessi solo lettere e cifre.';
  ValidationMessages.DigitsOnly['IT'] := 'Sono ammessi solo cifre.';
  ValidationMessages.Email['IT'] := 'Formato email non valido.';
  ValidationMessages.Url['IT'] := 'URL non valido (deve iniziare con http://, https:// o ftp://).';
  ValidationMessages.CreditCard['IT'] := 'Numero di carta di credito non valido (test di Luhn fallito).';
  ValidationMessages.Ean['IT'] := 'Cifra di controllo EAN/GTIN non valida.';
  ValidationMessages.Bic['IT'] := 'Codice BIC/SWIFT non valido (deve essere di 8 o 11 caratteri).';
  ValidationMessages.Ipv4['IT'] := 'Indirizzo IPv4 non valido.';
  ValidationMessages.Ipv6['IT'] := 'Indirizzo IPv6 non valido.';
  ValidationMessages.Iban['IT'] := 'IBAN non valido.';
  ValidationMessages.Pesel['IT'] := 'Numero PESEL non valido.';
  ValidationMessages.Nip['IT'] := 'Numero NIP non valido.';
  ValidationMessages.PassRequired['IT'] := 'La password è obbligatoria.';
  ValidationMessages.PassTooShort['IT'] := 'La password deve contenere almeno %d caratteri.';
  ValidationMessages.PassMixedCase['IT'] := 'La password deve contenere sia lettere maiuscole che minuscole.';
  ValidationMessages.PassDigit['IT'] := 'La password deve contenere almeno una cifra.';
  ValidationMessages.PassSpecial['IT'] := 'La password deve contenere almeno un carattere speciale.';
  ValidationMessages.PastDate['IT'] := 'La data deve essere nel passato.';
  ValidationMessages.FutureDate['IT'] := 'La data deve essere nel futuro.';
  ValidationMessages.AfterDate['IT'] := 'La data deve essere dopo il %s.';
  ValidationMessages.BeforeDate['IT'] := 'La data deve essere prima del %s.';
  ValidationMessages.MinDate['IT'] := 'La data deve essere almeno il %s.';
  ValidationMessages.MaxDate['IT'] := 'La data non può superare il %s.';
  ValidationMessages.BetweenDate['IT'] := 'La data deve essere compresa tra il %s e il %s.';
  ValidationMessages.Today['IT'] := 'La data deve essere oggi.';
  ValidationMessages.MinAge['IT'] := 'Devi avere almeno %d anni.';
  ValidationMessages.MaxAge['IT'] := 'L''età non può superare i %d anni.';
  ValidationMessages.IsWeekday['IT'] := 'La data deve essere un giorno feriale (lunedì-venerdì).';
  ValidationMessages.IsWeekend['IT'] := 'La data deve essere un fine settimana (sabato-domenica).';
  ValidationMessages.PastDateTime['IT'] := 'La data e l''ora devono essere nel passato.';
  ValidationMessages.FutureDateTime['IT'] := 'La data e l''ora devono essere nel futuro.';
  ValidationMessages.AfterDateTime['IT'] := 'La data e l''ora devono essere dopo il %s.';
  ValidationMessages.BeforeDateTime['IT'] := 'La data e l''ora devono essere prima del %s.';
  ValidationMessages.BetweenDateTime['IT'] := 'La data e l''ora devono essere comprese tra il %s e il %s.';
end;

procedure SetChinese;
begin
  ValidationMessages.Required['ZH'] := '该字段是必填的。';
  ValidationMessages.InvalidValue['ZH'] := '无效的值。';
  ValidationMessages.MinInt['ZH'] := '值必须至少为 %d。';
  ValidationMessages.MaxInt['ZH'] := '值不能超过 %d。';
  ValidationMessages.BetweenInt['ZH'] := '值必须在 %d 到 %d 之间。';
  ValidationMessages.MinDouble['ZH'] := '值必须至少为 %g。';
  ValidationMessages.MaxDouble['ZH'] := '值不能超过 %g。';
  ValidationMessages.BetweenDouble['ZH'] := '值必须在 %g 到 %g 之间。';
  ValidationMessages.MinCurrency['ZH'] := '值必须至少为 %m。';
  ValidationMessages.MaxCurrency['ZH'] := '值不能超过 %m。';
  ValidationMessages.BetweenCurrency['ZH'] := '值必须在 %m 到 %m 之间。';
  ValidationMessages.Positive['ZH'] := '值必须是正数。';
  ValidationMessages.Negative['ZH'] := '值必须是负数。';
  ValidationMessages.MinLength['ZH'] := '长度必须至少为 %d 个字符。';
  ValidationMessages.MaxLength['ZH'] := '长度不能超过 %d 个字符。';
  ValidationMessages.AlphaNumeric['ZH'] := '只允许字母和数字。';
  ValidationMessages.DigitsOnly['ZH'] := '只允许数字。';
  ValidationMessages.Email['ZH'] := '无效的电子邮件格式。';
  ValidationMessages.Url['ZH'] := '无效的 URL（必须以 http://、https:// 或 ftp:// 开头）。';
  ValidationMessages.CreditCard['ZH'] := '无效的信用卡号（Luhn 检查失败）。';
  ValidationMessages.Ean['ZH'] := '无效的 EAN/GTIN 校验位。';
  ValidationMessages.Bic['ZH'] := '无效的 BIC/SWIFT 代码（必须为 8 或 11 个字符）。';
  ValidationMessages.Ipv4['ZH'] := '无效的 IPv4 地址。';
  ValidationMessages.Ipv6['ZH'] := '无效的 IPv6 地址。';
  ValidationMessages.Iban['ZH'] := '无效的 IBAN。';
  ValidationMessages.Pesel['ZH'] := '无效的 PESEL 号码。';
  ValidationMessages.Nip['ZH'] := '无效的 NIP 号码。';
  ValidationMessages.PassRequired['ZH'] := '密码是必填的。';
  ValidationMessages.PassTooShort['ZH'] := '密码至少应包含 %d 个字符。';
  ValidationMessages.PassMixedCase['ZH'] := '密码必须包含大小写字母。';
  ValidationMessages.PassDigit['ZH'] := '密码必须包含至少一个数字。';
  ValidationMessages.PassSpecial['ZH'] := '密码必须包含至少一个特殊字符。';
  ValidationMessages.PastDate['ZH'] := '日期必须是过去的。';
  ValidationMessages.FutureDate['ZH'] := '日期必须是未来的。';
  ValidationMessages.AfterDate['ZH'] := '日期必须在 %s 之后。';
  ValidationMessages.BeforeDate['ZH'] := '日期必须在 %s 之前。';
  ValidationMessages.MinDate['ZH'] := '日期必须至少为 %s。';
  ValidationMessages.MaxDate['ZH'] := '日期不能超过 %s。';
  ValidationMessages.BetweenDate['ZH'] := '日期必须在 %s 到 %s 之间。';
  ValidationMessages.Today['ZH'] := '日期必须是今天。';
  ValidationMessages.MinAge['ZH'] := '您必须年满 %d 岁。';
  ValidationMessages.MaxAge['ZH'] := '年龄不能超过 %d 岁。';
  ValidationMessages.IsWeekday['ZH'] := '日期必须是工作日（周一至周五）。';
  ValidationMessages.IsWeekend['ZH'] := '日期必须是周末（周六至周日）。';
  ValidationMessages.PastDateTime['ZH'] := '日期和时间必须是过去的。';
  ValidationMessages.FutureDateTime['ZH'] := '日期和时间必须是未来的。';
  ValidationMessages.AfterDateTime['ZH'] := '日期和时间必须在 %s 之后。';
  ValidationMessages.BeforeDateTime['ZH'] := '日期和时间必须在 %s 之前。';
  ValidationMessages.BetweenDateTime['ZH'] := '日期和时间必须在 %s 到 %s 之间。';
end;

procedure SetJapanese;
begin
  ValidationMessages.Required['JA'] := 'この項目は必須です。';
  ValidationMessages.InvalidValue['JA'] := '無効な値です。';
  ValidationMessages.MinInt['JA'] := '値は %d 以上である必要があります。';
  ValidationMessages.MaxInt['JA'] := '値は %d を超えることはできません。';
  ValidationMessages.BetweenInt['JA'] := '値は %d から %d の間である必要があります。';
  ValidationMessages.MinDouble['JA'] := '値は %g 以上である必要があります。';
  ValidationMessages.MaxDouble['JA'] := '値は %g を超えることはできません。';
  ValidationMessages.BetweenDouble['JA'] := '値は %g から %g の間である必要があります。';
  ValidationMessages.MinCurrency['JA'] := '値は %m 以上である必要があります。';
  ValidationMessages.MaxCurrency['JA'] := '値は %m を超えることはできません。';
  ValidationMessages.BetweenCurrency['JA'] := '値は %m から %m の間である必要があります。';
  ValidationMessages.Positive['JA'] := '値は正である必要があります。';
  ValidationMessages.Negative['JA'] := '値は負である必要があります。';
  ValidationMessages.MinLength['JA'] := '長さは少なくとも %d 文字である必要があります。';
  ValidationMessages.MaxLength['JA'] := '長さは %d 文字を超えることはできません。';
  ValidationMessages.AlphaNumeric['JA'] := '英数字のみが許可されています。';
  ValidationMessages.DigitsOnly['JA'] := '数字のみが許可されています。';
  ValidationMessages.Email['JA'] := '無効なメール形式です。';
  ValidationMessages.Url['JA'] := '無効な URL です（http://、https://、または ftp:// で始まる必要があります）。';
  ValidationMessages.CreditCard['JA'] := '無効なクレジットカード番号です（Luhn チェックに失敗しました）。';
  ValidationMessages.Ean['JA'] := '無効な EAN/GTIN チェックディジットです。';
  ValidationMessages.Bic['JA'] := '無効な BIC/SWIFT コードです（8 文字または 11 文字である必要があります）。';
  ValidationMessages.Ipv4['JA'] := '無効な IPv4 アドレスです。';
  ValidationMessages.Ipv6['JA'] := '無効な IPv6 アドレスです。';
  ValidationMessages.Iban['JA'] := '無効な IBAN です。';
  ValidationMessages.Pesel['JA'] := '無効な PESEL 番号です。';
  ValidationMessages.Nip['JA'] := '無効な NIP 番号です。';
  ValidationMessages.PassRequired['JA'] := 'パスワードは必須です。';
  ValidationMessages.PassTooShort['JA'] := 'パスワードは少なくとも %d 文字である必要があります。';
  ValidationMessages.PassMixedCase['JA'] := 'パスワードには大文字と小文字の両方を含める必要があります。';
  ValidationMessages.PassDigit['JA'] := 'パスワードには少なくとも 1 つの数字を含める必要があります。';
  ValidationMessages.PassSpecial['JA'] := 'パスワードには少なくとも 1 つの特殊文字を含める必要があります。';
  ValidationMessages.PastDate['JA'] := '日付は過去である必要があります。';
  ValidationMessages.FutureDate['JA'] := '日付は未来である必要があります。';
  ValidationMessages.AfterDate['JA'] := '日付は %s より後である必要があります。';
  ValidationMessages.BeforeDate['JA'] := '日付は %s より前である必要があります。';
  ValidationMessages.MinDate['JA'] := '日付は %s 以降である必要があります。';
  ValidationMessages.MaxDate['JA'] := '日付は %s 以前である必要があります。';
  ValidationMessages.BetweenDate['JA'] := '日付は %s から %s の間である必要があります。';
  ValidationMessages.Today['JA'] := '日付は今日である必要があります。';
  ValidationMessages.MinAge['JA'] := '%d 歳以上である必要があります。';
  ValidationMessages.MaxAge['JA'] := '年齢は %d 歳を超えることはできません。';
  ValidationMessages.IsWeekday['JA'] := '日付は平日（月曜日〜金曜日）である必要があります。';
  ValidationMessages.IsWeekend['JA'] := '日付は週末（土曜日〜日曜日）である必要があります。';
  ValidationMessages.PastDateTime['JA'] := '日時、時刻は過去である必要があります。';
  ValidationMessages.FutureDateTime['JA'] := '日時、時刻は未来である必要があります。';
  ValidationMessages.AfterDateTime['JA'] := '日時、時刻は %s より後である必要があります。';
  ValidationMessages.BeforeDateTime['JA'] := '日時、時刻は %s より前である必要があります。';
  ValidationMessages.BetweenDateTime['JA'] := '日時、時刻は %s から %s の間である必要があります。';
end;

procedure SetPortuguese;
begin
  ValidationMessages.Required['PT'] := 'O campo é obrigatório.';
  ValidationMessages.InvalidValue['PT'] := 'Valor inválido.';
  ValidationMessages.MinInt['PT'] := 'O valor deve ser pelo menos %d.';
  ValidationMessages.MaxInt['PT'] := 'O valor não pode exceder %d.';
  ValidationMessages.BetweenInt['PT'] := 'O valor deve estar entre %d e %d.';
  ValidationMessages.MinDouble['PT'] := 'O valor deve ser pelo menos %g.';
  ValidationMessages.MaxDouble['PT'] := 'O valor não pode exceder %g.';
  ValidationMessages.BetweenDouble['PT'] := 'O valor deve estar entre %g e %g.';
  ValidationMessages.MinCurrency['PT'] := 'O valor deve ser pelo menos %m.';
  ValidationMessages.MaxCurrency['PT'] := 'O valor não pode exceder %m.';
  ValidationMessages.BetweenCurrency['PT'] := 'O valor deve estar entre %m e %m.';
  ValidationMessages.Positive['PT'] := 'O valor deve ser positivo.';
  ValidationMessages.Negative['PT'] := 'O valor deve ser negativo.';
  ValidationMessages.MinLength['PT'] := 'O comprimento deve ter pelo menos %d caracteres.';
  ValidationMessages.MaxLength['PT'] := 'O comprimento não pode exceder %d caracteres.';
  ValidationMessages.AlphaNumeric['PT'] := 'Apenas letras e dígitos são permitidos.';
  ValidationMessages.DigitsOnly['PT'] := 'Apenas dígitos são permitidos.';
  ValidationMessages.Email['PT'] := 'Formato de e-mail inválido.';
  ValidationMessages.Url['PT'] := 'URL inválido (deve começar com http://, https:// ou ftp://).';
  ValidationMessages.CreditCard['PT'] := 'Número de cartão de crédito inválido (falha na verificação de Luhn).';
  ValidationMessages.Ean['PT'] := 'Dígito de controle EAN/GTIN inválido.';
  ValidationMessages.Bic['PT'] := 'Código BIC/SWIFT inválido (deve ter 8 ou 11 caracteres).';
  ValidationMessages.Ipv4['PT'] := 'Endereço IPv4 inválido.';
  ValidationMessages.Ipv6['PT'] := 'Endereço IPv6 inválido.';
  ValidationMessages.Iban['PT'] := 'IBAN inválido.';
  ValidationMessages.Pesel['PT'] := 'Número PESEL inválido.';
  ValidationMessages.Nip['PT'] := 'Número NIP inválido.';
  ValidationMessages.PassRequired['PT'] := 'A senha é obrigatória.';
  ValidationMessages.PassTooShort['PT'] := 'A senha deve ter pelo menos %d caracteres.';
  ValidationMessages.PassMixedCase['PT'] := 'A senha deve conter letras maiúsculas e minúsculas.';
  ValidationMessages.PassDigit['PT'] := 'A senha deve conter pelo menos um dígito.';
  ValidationMessages.PassSpecial['PT'] := 'A senha deve conter pelo menos um caractere especial.';
  ValidationMessages.PastDate['PT'] := 'A data deve ser no passado.';
  ValidationMessages.FutureDate['PT'] := 'A data deve ser no futuro.';
  ValidationMessages.AfterDate['PT'] := 'A data deve ser posterior a %s.';
  ValidationMessages.BeforeDate['PT'] := 'A data deve ser anterior a %s.';
  ValidationMessages.MinDate['PT'] := 'A data deve ser pelo menos %s.';
  ValidationMessages.MaxDate['PT'] := 'A data não pode exceder %s.';
  ValidationMessages.BetweenDate['PT'] := 'A data deve estar entre %s e %s.';
  ValidationMessages.Today['PT'] := 'A data deve ser hoje.';
  ValidationMessages.MinAge['PT'] := 'Você deve ter pelo menos %d anos.';
  ValidationMessages.MaxAge['PT'] := 'A idade não pode exceder %d anos.';
  ValidationMessages.IsWeekday['PT'] := 'A data deve ser um dia da semana (segunda a sexta).';
  ValidationMessages.IsWeekend['PT'] := 'A data deve ser um fin de semana (sábado-domingo).';
  ValidationMessages.PastDateTime['PT'] := 'A data e hora devem ser no passado.';
  ValidationMessages.FutureDateTime['PT'] := 'A data e hora devem ser no futuro.';
  ValidationMessages.AfterDateTime['PT'] := 'A data e hora devem ser posteriores a %s.';
  ValidationMessages.BeforeDateTime['PT'] := 'A data e hora devem ser anteriores a %s.';
  ValidationMessages.BetweenDateTime['PT'] := 'A data e hora devem estar entre %s e %s.';
end;

procedure InitializeDefaultTranslations;
begin
  SetEnglish;
  SetPolish;
  SetSpanish;
  SetGerman;
  SetFrench;
  SetItalian;
  SetChinese;
  SetJapanese;
  SetPortuguese;
end;


initialization
  InitializeDefaultTranslations;

{$IFEND}

end.
