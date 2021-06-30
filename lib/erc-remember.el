;;; erc-remember.el --- Remember people on IRC -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2021 Benoit Joly
;;
;; Author: Benoit Joly <https://github.com/benoitj>
;; Maintainer: Benoit Joly <benoit@benoitj.ca>
;; Created: June 28, 2021
;; Modified: June 28, 2021
;; Package-Requires: ((emacs "27.0"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;
;;
;;; Code:
(require 'erc)
(require 'bbdb)
(require 'bbdb-com)

(defun erc-remember--on-join (_ parsed)
  (let* ((sender (erc-parse-user (erc-response.sender parsed)))
         (nick (nth 0 sender)))
    (unless (string= nick (erc-current-nick))
      (let* ((channel (erc-response.contents parsed))
             (finger-host (concat (nth 1 sender) "@" (nth 2 sender))))
        (erc-remember--get-or-create-user nick channel)))))

(defun erc-remember--get-or-create-user (nick channel)
  (let* ((ircnick (cons 'irc-nick (concat "^" (regexp-quote nick))))
         (name nick)
         (entry (or (bbdb-search (bbdb-records) :name ircnick)
                     (when t
                       (bbdb-create-internal :name name)))))
         (progn
           (bbdb-record-set-xfield entry "last-seen" (current-time-string))
           (bbdb-save)

           )
             ))




;;;###autoload (autoload 'erc-remember-mode "erc-remember")
(define-erc-module remember nil
  "Records and remember people in ERC mode. Useful for creating bots with memory."
  ((add-hook 'erc-server-JOIN-functions 'erc-remember--on-join t))
  ((remove-hook 'erc-server-JOIN-functions 'erc-remember--on-join)))
;;  ((add-hook 'erc-server-311-functions 'erc-bbdb-whois t)
;;   (add-hook 'erc-server-JOIN-functions 'erc-bbdb-JOIN t)
;;   (add-hook 'erc-server-NICK-functions 'erc-bbdb-NICK t)
;;   (add-hook 'erc-server-376-functions 'erc-bbdb-init-highlighting-hook-fun t))
;;  ((remove-hook 'erc-server-311-functions 'erc-bbdb-whois)
;;   (remove-hook 'erc-server-JOIN-functions 'erc-bbdb-JOIN)
;;   (remove-hook 'erc-server-NICK-functions 'erc-bbdb-NICK)
;;   (remove-hook 'erc-server-376-functions 'erc-bbdb-init-highlighting-hook-fun)))


(provide 'erc-remember)
;;; erc-remember.el ends here
