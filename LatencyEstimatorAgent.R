
library(tidyverse)
library(gemini.R)
library(ellmer)
library(httr2)
library(pdftools)
library(dplyr)

rm(list=ls())


#===============================================================================
# Networking Usecase #1: Applying a function for calculating latency


get_latency <- tool(
  function(bitrate, traffic, percentile) {
    load = traffic/bitrate
    load_env = 0.5 + 0.16*load + 0.34*load^2
    EX = 8*1161/(bitrate*1e9)
    latency = EX * (1/(1-load_env)) * log (1/(1-percentile))
    return(latency)
  },
  name = "get_latency",
  description = "
    This is a function that gives you a maximum delay percentile for a link operating at bitrate gbps fed with traffic gbps
  ",
  arguments = list(
    bitrate = type_array(type_number("in Gbps"), "maximum bitrate of the link in Gbps"),
    traffic = type_array(type_number("in Gbps"), "traffic offered to the link in Gbps"),
    percentile = type_array(type_number(), "percentile value between 0 and 1")
  )
)



prompt_calculate_percentile = "You are a network specialist that needs to calculate latency percentiles based on an equation that 
      takes as input the link's maximum bitrate and the traffic offered to the link, both in Gbps. Such offered traffic must be smaller
      than the maximum bitrate. Also the percentile required needs to be provided (which is a number between 0 and 1), 
      for example 0.9 for the 90th percentile or 0.99 for the 99th percentile. 
      With that information, you need to calculate the maximum delay percentile for that link. Use microsecs as output units"


chat4 <- chat_google_gemini(
  #system_prompt = "You are a research assistant who specializes in extracting structured data from scientific papers.",
  system_prompt = prompt_calculate_percentile,
  #  name = "roll_die_agent",
  model = "gemini-2.5-flash", # "gpt-oss-20b", #  "gemini-2.5-flash"
  #  max_tokens = 1000,
  params = params(temperature = 1.2, top_p = NULL, top_k = NULL, max_tokens = 1000),
  api_key = c("YOUR_GOOGLE_API_KEY_HERE") # or any other API key if you want to use other models
)

chat4$register_tool(get_latency)
chat4$chat("Can you calculate the 0.8 latency percentile for two links in series, the first one operates at 100 Gbps link loaded with 8 Gbps, while the second one operates at 400G and is loaded with 210 Gbps? Calculate the two latency values separately")


