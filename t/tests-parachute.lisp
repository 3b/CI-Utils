(uiop:define-package :tests-parachute
  (:use :cl
        :ci-utils
        :parachute))
(in-package :tests-parachute)


(define-test :travis-tests
  (true (member :travis-ci *features*))
  (false (member :circleci *features*))
  (is eq :travis-ci (platform))
  (is string= (uiop:getenv "TRAVIS_BRANCH") (branch))
  (is eq (uiop:getenvp "TRAVIS_PULL_REQUEST_BRANCH")
      (pull-request-p)))

(define-test :circleci-tests
  (true (member :circleci *features*))
  (false (member :travis-ci *features*))
  (is eq :circleci (platform))
  (is string= (uiop:getenv "CIRCLE_BRANCH") (branch))
  (is eq (uiop:getenvp "CIRCLE_PULL_REQUEST")
      (pull-request-p)))

(define-test :appveyor-tests
  (true (member :appveyor *features*))
  (false (member :circleci *features*))
  (is eq :appveyor (platform))
  (is string= (uiop:getenv "APPVEYOR_REPO_BRANCH") (branch))
  (is eq (uiop:getenvp "APPVEYOR_PULL_REQUEST_NUMBER")
      (pull-request-p)))

(define-test :gitlab-ci-tests
  (true (member :gitlab-ci *features*))
  (false (member :circleci *features*))
  (is eq :gitlab-ci (platform))
  (is string= (uiop:getenv "CI_COMMIT_REF_NAME") (branch))
  (is eq (uiop:getenvp "CI_MERGE_REQUEST_ID")
      (pull-request-p)))

(define-test :bitbucket-pipelines-tests
  (true (member :bitbucket-pipelines *features*))
  (false (member :circleci *features*))
  (is eq :bitbucket-pipelines (platform))
  (is string= (uiop:getenv "BITBUCKET_BRANCH") (branch))
  (is eq (uiop:getenvp "BITBUCKET_PR_ID")
      (pull-request-p)))

(define-test :azure-pipelines-tests
  (true (member :azure-pipelines *features*))
  (false (member :circleci *features*))
  (is eq :azure-pipelines (platform))
  (is string= (uiop:getenv "BUILD_SOURCEBRANCHNAME") (branch))
  (is eq (uiop:getenvp "SYSTEM_PULLREQUEST_PULLREQUESTID")
      (pull-request-p)))

(define-test :github-actions-tests
  (true (member :github-actions *features*))
  (false (member :circleci *features*))
  (is eq :github-actions  (platform))
  (is string= (subseq (uiop:getenv "GITHUB_REF") 11) (branch))
  (is eq (string= "pull_request" (uiop:getenvp "GITHUB_EVENT_NAME"))
      (pull-request-p)))

(define-test :base-tests
  (true (member :ci *features*))
  (false (member :unknown-ci *features*))
  (true (cip))
  (is equal (uiop:getcwd) (truename (build-dir))))


(define-test :user-tests
  (false (member :ci *features*))
  (false (member :unknown-ci *features*))
  (false (member :travis-ci *features*))

  (false (cip))
  (false (platform))
  (is equal (uiop:getcwd) (build-dir))
  (false (pull-request-p))
  (false (branch)))


(define-test :coveralls-tests
  (true (member :coveralls *features*))
  (is equal '("t" "test-launcher.txt") (ci-utils/coveralls:coverage-excluded))
  (true (ci-utils/coveralls:coverallsp)))

(define-test :noncoveralls-tests
  (false (member :coveralls *features*))
  (false (ci-utils/coveralls:coverallsp)))

(define-test :failing-tests
  (false t)
  (true nil)
  (is = 1 2))

(define-test :error-tests
  (true (error "error!")))

