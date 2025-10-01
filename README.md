# AI Agent for estimating upper bounds on Latency percentiles
By José Alberto Hernández, Universidad Carlos III de Madrid, Oct 2025.

This repository provides a practical example for applying the latency envelope methodology of article: 

[1] N Koneva, A Sánchez-Macián, JA Hernández, F Arpanaei, O González de Dios, "On finding empirical upper bound models for latency guarantees in packet-optical networks" in 2025 Optical Network Design and Modeling (ONDM) 2025, Pisa, Italy
URL: https://opendl.ifip-tc6.org/db/conf/ondm2025/ondm2025/1571109850.pdf

In the article, we propose how to find M/M/1 queuing envelopes that act as upper bound of observed latency measurements. This M/M/1 approximation requires first to transform the real link load rho into the so-called "envelope load" rho_e (typically larger). Then we can apply the classical M/M/1 queuing model equations for finding latency upper bound values of the link's delay percentile above percentile 0.5 (or 50%).

The code has been programmed in R, and uses the ellmer library for prototyping the AI Agent. The code can use Google Gemini or any other LLM API as long as its key is provided (typically OpenAI, Claude, etc).

As shown, you can interface the Agent using natural language and the Agent finds that it has to use internal tools for calculating such latency values. 

Example: 

