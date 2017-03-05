
tp = STRING

tp <- gsub(")", ")NA", tp)
tp <- gsub(" ", "", tp)
tpc <- unlist(strsplit(tp, "[\\(\\),;]"))
tpc <- tpc[tpc != ""]
