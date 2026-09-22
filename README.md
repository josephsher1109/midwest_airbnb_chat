# ISA 401 Airbnb Chat

**Ask a question in plain English, get the SQL and a table back**

A twelve-line [querychat](https://github.com/posit-dev/querychat) app built in ISA 401 (Miami University) on the job postings that [ChatISA](https://chatisa.fsb.miamioh.edu) Job Scout collected. It is the starting point for Assignment 05, where you rebuild it on the Airbnb data, deploy it to [Render](https://render.com) from your GitHub repository, and then improve it.

**Live app:** https://midwest-airbnb-chat.onrender.com

---

## What is this app?

The app connects to a SQLite database (`data/scout.db`), hands the `scout_postings` table to querychat, and lets an LLM translate your question into SQL. Every answer shows the query it ran, so you can check the logic and reuse the SQL yourself.

**Example queries:**
-  "Which city has the highest median nightly price for entire homes/apartments? (see Example 1a and 1c in midwest_airbnb_chat)
   <img width="1893" height="832" alt="Example1a" src="https://github.com/user-attachments/assets/177a7222-63dd-4a12-b3e2-6062e392a00c" />
  <img width="392" height="662" alt="Example 1c (1)" src="https://github.com/user-attachments/assets/dfdcd8a5-77bb-46a1-b324-1d6010a348fd" />
  <img width="303" height="512" alt="Example 1c (2)" src="https://github.com/user-attachments/assets/566b8dba-429d-48ff-87ea-5662e3be4cd8" />


- "Do Superhosts have a higher median nightly price than non-Superhosts? Show the results by city (see Example 2a in midwest_airbnb_chat).
<img width="436" height="475" alt="Example 2a (1)" src="https://github.com/user-attachments/assets/2771479f-129c-43ae-b2ac-32ad4ac4f28f" />
<img width="337" height="552" alt="Example 2a (2)" src="https://github.com/user-attachments/assets/65d5742e-7ae4-413c-8d74-9ed107ebec25" />
<img width="295" height="327" alt="Example 2a (3)" src="https://github.com/user-attachments/assets/6a135f70-40e4-49de-a2f1-68a444e2cd43" />
<img width="286" height="347" alt="Example 2a (4)" src="https://github.com/user-attachments/assets/633fdd34-c8bc-4f9d-8b62-53a51017eb92" />


- "What are the 10 most common property types in the dataset? Show the results as a bar chart. (see Example 3a in midwest_airbnb_chat")
  <img width="792" height="173" alt="Example 3a (1)" src="https://github.com/user-attachments/assets/5a9415d7-8d9a-4a6b-a77f-9987837640bc" />
  <img width="1852" height="928" alt="Example 3a (2)" src="https://github.com/user-attachments/assets/c9a67ce1-a9cc-4e12-a1bd-72560d776bde" />



---

## Dataset Information

**Dataset:** `scout_postings` table in `data/scout.db` (1,891 rows, 19 columns)
**Source:** ChatISA Job Scout, which harvested the postings from public job boards between July 29 and August 23, 2026 (the `source` column records the board: `activejobs` or `usajobs`)
**Data dictionary:** `data/data_desc.md` (started in class; you complete it in Assignment 05)
**Query rules for the LLM:** `data/extra_instructions.md` (one starter rule; you add more)

### Key Fields

| Field | Description |
|-------|-------------|
| `title` | Job title as it appeared on the board |
| `company` | Employer name |
| `location_city` | City of the posting (blank for 61 rows) |
| `location_state` | Two-letter state code (blank for 30 rows) |
| `remote` | `1` if the posting is remote, `0` otherwise |
| `category` | `fulltime`, `federal`, or `internship` |

---

## Required Secret

The app calls OpenAI (`gpt-5.6-luna (reasoning off)`) through [ellmer](https://ellmer.tidyverse.org/), so it needs one environment variable:

```bash
export OPENAI_API_KEY="your-api-key-here"
```

On Hugging Face Spaces, add it under **Settings > Variables and secrets** as a secret named `OPENAI_API_KEY`. Never commit the key; `.Renviron` is listed in `.gitignore` for that reason.

---

## Running Locally

**With R (4.6.0, querychat 0.3.0):**
```r
# from inside apps/job_scout_chat/
shiny::runApp(".", port = 7860)
```

**With Docker:**
```bash
docker build -t job_scout_chat .
docker run --rm -p 7860:7860 -e OPENAI_API_KEY=$OPENAI_API_KEY job_scout_chat
```

Then open http://localhost:7860.

---

## Technology Stack

- **[Shiny](https://shiny.posit.co/)** - Web application framework for R
- **[querychat](https://github.com/posit-dev/querychat)** - Natural language data querying
- **[ellmer](https://ellmer.tidyverse.org/)** - LLM client for R
- **[RSQLite](https://rsqlite.r-dbi.org/)** - SQLite driver for R

---

## Course Information

This application was developed for **ISA 401** at **Miami University**. The polished version of the same idea, built on BLS wage data, is the [OEWS Jobs Explorer](https://huggingface.co/spaces/fmegahed/querychat_demo).
