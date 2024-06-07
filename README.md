# Rankings.fyi Database

## Setup
1. Make a copy of `.env.example` and call it `.env`. Change the env vars.
2. Run `./init.sh`.
3. Run `./connect.sh` to hop into the shell.

## Design Choices
- All string fields are TEXT -> change later to VARCHAR
- Ranking is an INT following the same convention as is on the WaterlooWorks form
    - 0 -> pending
    - 1-10 -> rank
    - 99 -> not interested

## ER Diagram
<img src="assets/ER.png" alt="ER Diagram" style="max-width: 500px;">
