;;; cmd-basic.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2021 Benoit Joly
;;
;; Author: Benoit Joly <https://github.com/benoitj>
;; Maintainer: Benoit Joly <benoit@benoitj.ca>
;; Created: June 14, 2021
;; Modified: June 14, 2021
;; Version: 0.0.1
;; Keywords: Symbol’s value as variable is void: finder-known-keywords
;; Homepage: https://github.com/benoit/cmd-basic
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:

(provide 'cmd-basic)

(defun cmd-basic/help (args)
  "Help command listing all registered commands."
  (concat "commands available: "
 	  (mapconcat
 	   (lambda (e)
 	     (car e))
 	   erc-robot-commands " ")))

(add-to-list 'erc-robot-commands '("help" t cmd-basic/help))
(add-to-list 'erc-robot-commands '("hello" t (lambda (args) "hello to you too !")))
(add-to-list 'erc-robot-commands '("ping" t (lambda (args) "ping... ping... pong")))
(add-to-list 'erc-robot-commands '("echo" t (lambda (args) args)))
(add-to-list 'erc-robot-commands '("kudos" t (lambda (args) (concat "Hey " args ", thanks for being awesome!"))))

;;; cmd-basic.el ends here
