;;; lsp-common-test.el --- unit tests for lsp-io.el -*- lexical-binding: t -*-

;; Copyright (C) 2017  Lukas Fuermetz <fuermetz@mailbox.org>.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Code:

(require 'ert)
(require 'lsp)

(ert-deftest lsp--path-to-uri ()
  (let ((lsp--uri-file-prefix "file:///"))
    (should (equal (lsp--path-to-uri "c:/Users/?/") "file:///c:/Users/%3F/")))
  (let ((lsp--uri-file-prefix "file://"))
    (should (equal (lsp--path-to-uri "/root/file/hallo welt") "file:///root/file/hallo%20welt"))))

(ert-deftest lsp--path-to-uri ()
  (let ((lsp--uri-file-prefix "file:///")
        (system-type 'windows-nt))
    (should (equal (lsp--uri-to-path "file:///c:/Users/%7B%7D/") "c:/users/{}/")))
  (let ((lsp--uri-file-prefix "file://"))
    (should (equal (lsp--uri-to-path "/root/%5E/%60") "/root/^/`"))))

(ert-deftest lsp-common-test--path-to-uri-custom-schemes ()
  (let* ((client (make-lsp--client :uri-handlers (ht ("custom" (lambda (_) "file-path")))))
         (lsp--cur-workspace (make-lsp--workspace :client client)))
    (should (equal (lsp--uri-to-path "custom://file-path") "file-path"))))

(ert-deftest lsp-common-test--unexpected-scheme ()
  (should-error (lsp--uri-to-path "will-fail://file-path")
                :type 'lsp-file-scheme-not-supported))

(ert-deftest lsp--uri-to-path--handle-utf8 ()
  (let ((lsp--uri-file-prefix "file:///")
        (system-type 'windows-nt))
    (should (equal (lsp--uri-to-path "file:///c:/Users/%E4%BD%A0%E5%A5%BD/") "c:/users/你好/")))
  (let ((lsp--uri-file-prefix "file://"))
    (should (equal (lsp--uri-to-path "/root/%E4%BD%A0%E5%A5%BD/%E8%B0%A2%E8%B0%A2") "/root/你好/谢谢"))))

(ert-deftest lsp-byte-compilation-test ()
  (let ((byte-compile-error-on-warn t))
    (cl-assert (byte-compile-file (save-excursion
                                    (find-library "lsp-mode")
                                    (buffer-file-name)))
               t
               "Failed to byte-compile")
    (cl-assert (byte-compile-file (save-excursion
                                    (find-library "lsp-clients")
                                    (buffer-file-name)))
               t
               "Failed to byte-compile")))

(ert-deftest lsp--find-session-folder ()
  (cl-assert (string= "/folder/"
                      (lsp-find-session-folder
                       (make-lsp-session :folders '("/folder/"))
                       "/folder/file"))
             t
             "failed to find the proper root")
  (cl-assert (string= "/folder/nested-project"
                      (lsp-find-session-folder
                       (make-lsp-session :folders '("/folder/"
                                                    "/folder/nested-project"))
                       "/folder/nested-project/file-in-nested-project"))
             t
             "failed to find nested project")
  (cl-assert (null (lsp-find-session-folder
                    (make-lsp-session :folders '("/folder/"))
                    "/foo"))
             t
             "Should not find any root."))
;;; lsp-common-test.el ends here
