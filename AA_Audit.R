library(tidyverse)
library(xlsx)
library(RSiteCatalyst)
install.packages("googlesheets")
library(googlesheets)

uw <- "alice.malone@searchdiscovery.com:American Century"
pw <- "f96e29f9b75d56d3ad611f119e7f9ab5"
SCAuth(uw, pw)
loc <- "C:/Users/Jamarius Taylor/Desktop" ###specify path for the file to be writte to
rsid <- GetReportSuites()
rs <- rsid$rsid[5] ## report suite of choice
eVars <- GetEvars(rs) %>% as.data.frame() 
eVars <- eVars[,-9] 
props <- GetProps(rs) %>% as.data.frame() 
events <- GetSuccessEvents(rs) %>% as.data.frame() 
metrics <- GetMetrics(rs) %>% as.data.frame() 
Elements <- GetElements(rs) %>% as.data.frame() 


# 
# write.csv(eVars,"C:/Users/Jamarius Taylor/Desktop/AA_Audit_eVars.csv")
# write.csv(props,"C:/Users/Jamarius Taylor/Desktop/AA_Audit_props.csv")
# write.csv(events,"C:/Users/Jamarius Taylor/Desktop/AA_Audit_events.csv")
# write.csv(metrics,"C:/Users/Jamarius Taylor/Desktop/AA_Audit_metrics.csv")
# write.csv(Elements,"C:/Users/Jamarius Taylor/Desktop/AA_Audit_Elements.csv")


gs_auth(new_user = TRUE)
gs_new("AA_Audit","Evars",input = eVars) ## Create new Google sheet 
for_gs <- gs_title("AA_Audit")
gs_aa <- gs_read(for_gs)
gs_ws_new(ss =for_gs, ws = "props", anchor = "A1", input = props, byrow = TRUE)
gs_ws_new(for_gs, ws = "events", anchor = "A1", input = events, byrow = TRUE)
gs_ws_new(for_gs, ws = "metrics", anchor = "A1", input = metrics, byrow = TRUE)
gs_ws_new(for_gs, ws = "elements", anchor = "A1", input = Elements, byrow = TRUE)
