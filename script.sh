#!/usr/bin/env bash

(( day               = 1    )) # start with sunday
(( month             = 1    ))
(( year              = 2017 ))
(( stop_on_year      = 2025 ))
(( no_of_commits_min = 1    ))
(( no_of_commits_max = 100   ))

empty_letter_matrix=(
  "0 0 0 0"
  "0 0 0 0"
  "0 0 0 0"
  "0 0 0 0"
  "0 0 0 0"
  "0 0 0 0"
  "0 0 0 0"
)

h_letter_matrix=(
  "0 0 0 0"
  "1 0 0 1"
  "1 0 0 1"
  "1 1 1 1"
  "1 0 0 1"
  "1 0 0 1"
  "0 0 0 0"
)

e_letter_matrix=(
  "0 0 0 0"
  "1 1 1 1"
  "1 0 0 0"
  "1 1 1 0"
  "1 0 0 0"
  "1 1 1 1"
  "0 0 0 0"
)

l_letter_matrix=(
  "0 0 0 0"
  "1 0 0 0"
  "1 0 0 0"
  "1 0 0 0"
  "1 0 0 0"
  "1 1 1 1"
  "0 0 0 0"
)

o_letter_matrix=(
  "0 0 0 0"
  "1 1 1 1"
  "1 0 0 1"
  "1 0 0 1"
  "1 0 0 1"
  "1 1 1 1"
  "0 0 0 0"
)

w_letter_matrix=(
  "0 0 0 0"
  "1 0 0 1"
  "1 0 0 1"
  "1 0 0 1"
  "1 1 1 1"
  "1 0 0 1"
  "0 0 0 0"
)

r_letter_matrix=(
  "0 0 0 0"
  "1 1 1 0"
  "1 0 0 1"
  "1 1 1 0"
  "1 0 1 0"
  "1 0 0 1"
  "0 0 0 0"
)

l_letter_matrix=(
  "0 0 0 0"
  "1 0 0 0"
  "1 0 0 0"
  "1 0 0 0"
  "1 0 0 0"
  "1 1 1 1"
  "0 0 0 0"
)

d_letter_matrix=(
  "0 0 0 0"
  "1 1 1 0"
  "1 0 0 1"
  "1 0 0 1"
  "1 0 0 1"
  "1 1 1 0"
  "0 0 0 0"
)

function git_init() {
  rm -rf .git
  git init .
}

function git_commit() {
  export D=$1
  export M=$2
  export Y=$3

  export GIT_COMMITTER_DATE="$Y-$M-$D 09:09:09"
  export GIT_AUTHOR_DATE="$Y-$M-$D 09:09:09"

  echo $RANDOM > README.md
  git add .

  git commit --date="$Y-$M-$D 09:09:09" -m "Some important change"
}

function no_of_days_in_month() {
  local month=$1
  local year=$2

  if (( year % 4 == 0 )) && (( month == 2 )) ; then # leap year
    echo "29"
    return
  fi

  case $month in
    1|3|5|7|8|10|12 ) echo "31";;
    4|6|9|11 ) echo "30";;
    2 ) echo "28";;
  esac
}

function get_element_of_letter_matrix() {
  local matrix=("${!1}")
  local i=$2
  local j=$3

  local row=${matrix[$i]}
  local element=$(echo $row | awk -v j="$((j+1))" '{print $j}')

  echo $element
}


function test_eq() {
  local desc=$1
  local result=$2
  local expected_result=$3

  if (( result == expected_result )); then
    echo -e "${desc} -- \e[1;32m success \e[0m"
  else
    echo -e "${desc} -- \e[1;31m fail \e[0m -- Result: ${result} ; Expected: ${expected_result}"
  fi
}

function test__no_of_days_in_month() {
  echo -e "\e[1m ${FUNCNAME[0]} \e[0m"

  test_eq "2 2019" $(no_of_days_in_month 2 2019) 28
  test_eq "1 2020" $(no_of_days_in_month 1 2020) 31
  test_eq "2 2020" $(no_of_days_in_month 2 2020) 29
}

function test__run() {
  test__no_of_days_in_month
  read -p "Press enter to continue, or Ctrl+C to break;"
}

(( letter_index = 0 ))
(( row_index    = 0 ))
(( column_index = 0 ))
(( row_max      = 7 ))
(( column_max   = 4 ))

test__run

git_init

while (( year < stop_on_year )); do

  # --------------------
  # Letter drawing
  # --------------------

  letter=()

  if (( letter_index > 25 )); then
    letter_index=0
  fi

  case $letter_index in
    0 ) letter=( "${empty_letter_matrix[@]}" );;
    1 ) letter=( "${empty_letter_matrix[@]}" );;
    2 ) letter=( "${h_letter_matrix[@]}" );;
    3 ) letter=( "${empty_letter_matrix[@]}" );;
    4 ) letter=( "${e_letter_matrix[@]}" );;
    5 ) letter=( "${empty_letter_matrix[@]}" );;
    6 ) letter=( "${l_letter_matrix[@]}" );;
    7 ) letter=( "${empty_letter_matrix[@]}" );;
    8 ) letter=( "${l_letter_matrix[@]}" );;
    9 ) letter=( "${empty_letter_matrix[@]}" );;
    10 ) letter=( "${o_letter_matrix[@]}" );;
    11 ) letter=( "${empty_letter_matrix[@]}" );;
    12 ) letter=( "${empty_letter_matrix[@]}" );;
    13 ) letter=( "${empty_letter_matrix[@]}" );;
    14 ) letter=( "${empty_letter_matrix[@]}" );;
    15 ) letter=( "${w_letter_matrix[@]}" );;
    16 ) letter=( "${empty_letter_matrix[@]}" );;
    17 ) letter=( "${o_letter_matrix[@]}" );;
    18 ) letter=( "${empty_letter_matrix[@]}" );;
    19 ) letter=( "${r_letter_matrix[@]}" );;
    20 ) letter=( "${empty_letter_matrix[@]}" );;
    21 ) letter=( "${l_letter_matrix[@]}" );;
    22 ) letter=( "${empty_letter_matrix[@]}" );;
    23 ) letter=( "${d_letter_matrix[@]}" );;
    24 ) letter=( "${empty_letter_matrix[@]}" );;
    25 ) letter=( "${empty_letter_matrix[@]}" );;
    * ) letter=();;
  esac

  fill_square=0
  if [ ${#letter[@]} -gt 0 ]; then
    fill_square=$(get_element_of_letter_matrix letter[@] $row_index $column_index)
  fi

  # Track position in the letter matrix
  (( row_index ++ ))
  if (( row_index % row_max == 0)); then
    (( row_index = 0 ))
    (( column_index ++ ))
  fi

  if (( column_index != 0 )) && (( column_index % column_max == 0 )); then
    (( column_index = 0 ))
    (( letter_index ++ ))
  fi

  # --------------------
  # Create git commits
  # --------------------

  no_of_commits=0

  case $fill_square in
    0 ) no_of_commits=${no_of_commits_min} ;;
    1 ) no_of_commits=${no_of_commits_max} ;;
  esac

  while (( no_of_commits > 0 )); do
    (( no_of_commits-- ))
    git_commit $day $month $year
  done

  # --------------------
  # Track current day, month, and year
  # --------------------

  (( day ++ ))
  max_days=$(no_of_days_in_month $month $year)
  if (( day > max_days )); then
    (( day = 1 ))
    (( month ++ ))
  fi

  if (( month > 12 )); then
    (( month = 1 ))
    (( year ++ ))
  fi

done
