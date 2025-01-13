export PYTHONSTARTUP=~/.pythonrc

activate() {
  # Activate a virtual environment
  local cwd
  local venv

  cwd="$PWD"
  venv=${1:-venv}

  while [[ $PWD != '/' ]]; do
    if [[ -d $venv ]]; then
      >&2 echo "Activating $PWD/$venv"
      source "./$venv/bin/activate"
      cd $cwd
      return 0
    fi
    cd ..
  done

  >&2 echo "No $venv directory found"
  return 1
}
