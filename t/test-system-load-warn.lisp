(defpackage :ci-utils-test-system-load-warn
  (:use :cl))
(in-package :ci-utils-test-system-load-warn)

(eval-when (:compile-toplevel)
  (warn "compilation warning!"))


