DateTime? parseMovieDateFromString(String? rowDate) {
if(rowDate == null || rowDate.isEmpty) return null;
return DateTime.tryParse(rowDate);
}