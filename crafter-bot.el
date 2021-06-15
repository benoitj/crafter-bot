;;; private.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2021 Benoit Joly
;;
;; Author: Benoit Joly <https://github.com/benoitj>
;; Maintainer: Benoit Joly <benoit@benoitj.ca>
;; Homepage: https://github.com/benoit/private
;; Package-Requires: ((emacs "24.3"))

;; Copyright (C) 2021 by Benoit Joly
;;
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:

(provide 'crafter-bot)

(defvar bot-commands '("version"))

(dolist (command bot-commands)
  (if (file-exists-p (concat "lib/commands/" command ".el"))
      (load-file (concat "lib/commands/" command ".el"))))

(defvar erc-nick "crafter-bot")
(defvar erc-robot-command-prefix-pattern ",")

(load-file "lib/erc-robot.el")
(require 'erc)

(add-hook 'erc-server-PRIVMSG-functions 'erc-robot-remote t)
(add-hook 'erc-send-completed-hook 'erc-robot-local t)

(setq crafter-urls '(("wiki" . "https://wiki.systemcrafters.cc")
                     ("wiki-gh" . "https://github.com/SystemCrafters/wiki-site")))

;; TODO need to split this into modular functions. possibly self adding
;; themselves when calling a function/loading
(setq erc-robot-commands
       '(
 	("help" t (lambda (args)
 		  (concat "commands available: "
 			  (mapconcat
 			   (lambda (e)
 			     (car e))
 			   erc-robot-commands " "))))
 	("hello" t (lambda (args) "hello to you too !"))
 	("ping" t (lambda (args) "ping... ping... pong"))
 	("echo" t (lambda (args) args))
        ;; TODO: we probably want to split this and, return all knows urls keys when no
        ;; args, and have ways for admins to add urls (ie: links db not hardcoded
        ;; but as data)
 	("url" t (lambda (args) (if (string-blank-p args) (cdr (assoc args crafter-urls)) (concat "urls available: "))))
        ("kudos" t (lambda (args) (concat "Hey " args ", thanks for being awesome!")))
        ("version" t commands/version)))




(add-to-list 'erc-modules 'autojoin)

(setq erc-autojoin-channels-alist
          '(("libera.chat" "#systemcrafters")))

(if (getenv "BOT_PASSWORD") (message "a password was set"))

(erc-tls :server "irc.libera.chat" :port 6697
      :nick erc-nick :password (getenv "BOT_PASSWORD") )


;;; crafter-bot.el ends here
