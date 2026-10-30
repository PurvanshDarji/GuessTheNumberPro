#!/bin/bash
# ============================================================
#  STARTER KIT – L15 Guess The Number Pro
#  Student: PURVANSH DARJI  Roll: C44  Div: G
#  Run:  bash setup_guessgame.sh
#  It creates ~/linux_project/guessgame with folders, sample data and scripts.
# ============================================================
P="$HOME/linux_project/guessgame"
if [ -d "$P" ]; then echo "Folder $P already exists. Rename or delete it first."; exit 1; fi
mkdir -p "$P"/lib "$P"/data "$P"/reports "$P"/backups "$P"/logs
cd "$P" || exit 1

# sample data: data/highscores.txt
cat > 'data/highscores.txt' <<'KIT_DATA_0'
name,attempts,level,date
ARYAN,5,Hard,2026-10-26
KIT_DATA_0

cat > lib/functions.sh <<'KIT_FUNCS'
#!/bin/bash
# lib/functions.sh – all functions for Guess The Number Pro
DATA="data/highscores.txt"

LOG="logs/activity.log"

# write one line to the activity log
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') | $*" >> "$LOG"
}

# check the data file / folder exists before using it
check_data() {
    if [ ! -e "$DATA" ]; then
        echo "Data not found: $DATA"
        return 1
    fi
}

show_help() {
    echo "Usage: ./main.sh            -> open the menu"
    echo "       ./main.sh --help     -> show this help"
    echo "       ./main.sh --backup   -> backup data/ now"
    echo "       ./main.sh --cron     -> run the scheduled (crontab) task"
}

view_data() {
    check_data || return
    if [ -d "$DATA" ]; then ls -l "$DATA"; else cat -n "$DATA" | more; fi
}

do_backup() {
    f="backups/data_$(date +%Y%m%d_%H%M%S).tar.gz"
    tar -czf "$f" data/
    echo "Backup saved: $f ($(du -h "$f" | cut -f1))"
    log "backup created $f"
}

view_log() {
    if [ -f "$LOG" ]; then tail -n 15 "$LOG"; else echo "No activity yet."; fi
}

# ------------------------------------------------------------
# FEATURE 1: Choose difficulty with case (Easy/Medium/Hard)
# Commands you can use: $RANDOM, while, case, sort -n, head
# ------------------------------------------------------------
feature_1() {
    echo "== Choose difficulty with case (Easy/Medium/Hard) =="
    echo "TODO: write the code for this feature (see your project guide, Step 3)."
    # ---- example to start from (remove the # and change it) ----
    # read -p "Search for: " word
    # grep -i "$word" "$DATA" || echo "Nothing found"
    # # or show selected columns: awk -F',' '{ print $1, $2 }' "$DATA"
    log "feature_1 used"
}

# ------------------------------------------------------------
# FEATURE 2: Random number using $RANDOM
# Commands you can use: $RANDOM, while, case, sort -n, head
# ------------------------------------------------------------
feature_2() {
    echo "== Random number using RANDOM =="
    echo "TODO: write the code for this feature (see your project guide, Step 4)."
    # ---- example to start from (remove the # and change it) ----
    # read -p "Search for: " word
    # grep -i "$word" "$DATA" || echo "Nothing found"
    # # or show selected columns: awk -F',' '{ print $1, $2 }' "$DATA"
    log "feature_2 used"
}

# ------------------------------------------------------------
# FEATURE 3: Hints: too high / too low in a loop
# Commands you can use: $RANDOM, while, case, sort -n, head
# ------------------------------------------------------------
feature_3() {
    echo "== Hints: too high / too low in a loop =="
    echo "TODO: write the code for this feature (see your project guide, Step 5)."
    # ---- example to start from (remove the # and change it) ----
    # read -p "Search for: " word
    # grep -i "$word" "$DATA" || echo "Nothing found"
    # # or show selected columns: awk -F',' '{ print $1, $2 }' "$DATA"
    log "feature_3 used"
}

# ------------------------------------------------------------
# FEATURE 4: Save name + attempts to high scores
# Commands you can use: $RANDOM, while, case, sort -n, head
# ------------------------------------------------------------
feature_4() {
    echo "== Save name + attempts to high scores =="
    echo "TODO: write the code for this feature (see your project guide, Step 6)."
    # ---- example to start from (remove the # and change it) ----
    # out="reports/report_$(date +%Y-%m-%d).txt"
    # {
    #     echo "===== Guess The Number Pro report – $(date) ====="
    #     tail -n +2 "$DATA" | sort
    # } > "$out"
    # echo "Report saved to $out"
    log "feature_4 used"
}

# ------------------------------------------------------------
# FEATURE 5: Show top 5 high scores
# Commands you can use: $RANDOM, while, case, sort -n, head
# ------------------------------------------------------------
feature_5() {
    echo "== Show top 5 high scores =="
    echo "TODO: write the code for this feature (see your project guide, Step 7)."
    # ---- example to start from (remove the # and change it) ----
    # # example: count rows per value of column 2
    # tail -n +2 "$DATA" | cut -d',' -f2 | sort | uniq -c | sort -nr | head -5
    # # example: top 5 rows by column 2 (attempts)
    # tail -n +2 "$DATA" | sort -t',' -k2 -nr | head -5
    log "feature_5 used"
}

# ------------------------------------------------------------
# CRON TASK: Every day at 9 AM, write the current top 5 high scores to hall_of_fame.txt
# Runs when crontab calls:  ./main.sh --cron
# ------------------------------------------------------------
cron_task() {
    # TODO: write the code for the scheduled task here (Step 10 of your guide)
    echo "$(date '+%Y-%m-%d %H:%M') cron task ran" >> reports/cron_output.txt
    log "cron task ran"
}
KIT_FUNCS

cat > main.sh <<'KIT_MAIN'
#!/bin/bash
# main.sh – L15 Guess The Number Pro
# Menu-driven shell script (while loop + case)
cd "$(dirname "$0")" || exit 1
source lib/functions.sh

case "$1" in
    --help)   show_help; exit 0 ;;
    --backup) do_backup; exit 0 ;;
    --cron)   cron_task; exit 0 ;;
esac

while true; do
    echo
    echo '========== GUESS THE NUMBER PRO =========='
    echo '1) Choose difficulty with case (Easy/Medium/Hard)'
    echo '2) Random number using $RANDOM'
    echo '3) Hints: too high / too low in a loop'
    echo '4) Save name + attempts to high scores'
    echo '5) Show top 5 high scores'
    echo "6) View data"
    echo "7) Backup data (tar.gz)"
    echo "8) View activity log"
    echo "0) Exit"
    read -p "Choose an option: " ch
    case "$ch" in
        1) feature_1 ;;
        2) feature_2 ;;
        3) feature_3 ;;
        4) feature_4 ;;
        5) feature_5 ;;
        6) view_data ;;
        7) do_backup ;;
        8) view_log ;;
        0) echo "Bye!"; break ;;
        *) echo "Invalid choice, try again." ;;
    esac
done
KIT_MAIN

cat > README.md <<'KIT_README'
# L15 – Guess The Number Pro

**Student:** PURVANSH DARJI | **Roll:** C44 | **Division:** G | **Enrollment:** 24004501210337

## Problem
Create a number guessing game with difficulty levels, attempt limits and a high-score file.

## Who will use it
Players who want a quick terminal game with a hall of fame.

## Folder structure
- main.sh – menu (run with ./main.sh)
- lib/functions.sh – all functions
- data/ – data files
- reports/ – reports created by the script
- backups/ – tar.gz backups
- logs/ – activity.log and cron.log

## Features
1. Choose difficulty with case (Easy/Medium/Hard)
2. Random number using $RANDOM
3. Hints: too high / too low in a loop
4. Save name + attempts to high scores
5. Show top 5 high scores

## How to run
    cd ~/linux_project/guessgame
    ./main.sh
    ./main.sh --help

## Crontab task
Every day at 9 AM, write the current top 5 high scores to hall_of_fame.txt

    0 9 * * * /bin/bash $HOME/linux_project/guessgame/main.sh --cron >> $HOME/linux_project/guessgame/logs/cron.log 2>&1

## Commands used
$RANDOM, while, case, sort -n, head

## What I learned
(write 3-5 lines here)
KIT_README

chmod +x main.sh lib/functions.sh
touch logs/activity.log
echo
echo "Starter kit ready!  Folder: $P"
ls -R "$P"
echo
echo "Next:  cd ~/linux_project/guessgame  &&  ./main.sh"
