# WatRank Database

## Setup
1. Make a copy of `.env.example` and call it `.env`. Change the env vars.
2. Make a copy of `.pgpass.example` and call it `.env` and copy it to your root directory.
3. Run `docker compose up -d`
4. Run `./setup.sh` to load sample database.
5. To interact with `psql`, run `psql -h localhost -p 5432 -U <username> -d <database>`

## Design Choices
- Why we only store wat id in users table
- Having OA, InterviewStage (int), and OfferCall as columns
- EmployerRankingEnum
- User ranking convention:
    - -1 -> not interested
    - 0 -> pending
    - 1-10 -> rank

## ER Diagram
<img src="assets/ER.png" alt="ER Diagram" style="max-width: 500px;">
