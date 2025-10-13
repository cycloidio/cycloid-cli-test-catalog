push:
    git add .
    git commit -m update
    git push origin stacks
    cy comp delete -p fbh -e test -c test-e2e
    cy comp create --update -p fbh -e test -c test-e2e -s cli-tests:stack-e2e-stackforms -u default
