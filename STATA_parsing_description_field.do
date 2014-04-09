*STATA 12.1
index int %10.0g index
Street int %10.0g Street#
StreetName str15 %15s StreetName
StreetType str4 %9s StreetType
City str7 %9s City
State str2 %9s State
lat byte %10.0g lat
H byte %10.0g long
Parcel str13 %13s Parcel #
Record str8 %9s Record #
RecordType str10 %10s Record Type
Status str8 %9s Status
FiledDate int %td.. Filed Date
StatusDate int %td.. Status Date
Description str142 %142s Description
RelatedRecords byte %10.0g Related Records
Balance double %10.0g Balance
Level byte %10.0g Level
Exempted str1 %9s Exempted
Unit str21 %21s Unit

*Description holds most of the detail. By parsing parts of it, we can create other variables. We want to get number of units, Level of substructure problem, and if they are exept.
*Task 1: Split apart at number of units.
split Description, p(",")
split Description2 , p("unit")

Task 2: Split apart at Level, code for level #
gen level = strpos( Description1,"Level") & strpos(Description1, "LEVEL")

*Split apart at except
gen exept=1 if level==.
