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

(add-to-list 'load-path "/home/crafter-bot/bot/lib")
(require 'erc-robot)
(require 'erc)

(add-hook 'erc-server-PRIVMSG-functions 'erc-robot-remote t)
(add-hook 'erc-send-completed-hook 'erc-robot-local t)
 (setq erc-robot-commands
       '(
 	("cmds" t (lambda (args)
 		  (concat "commands available: "
 			  (mapconcat
 			   (lambda (e)
 			     (car e))
 			   erc-robot-commands " "))))
 	("hello" t (lambda (args) "hello to you too !"))
 	("ping" t (lambda (args) "pong"))
 	("echo" t (lambda (args) args))
	; only i'm allowed to talk to my doctor !
 	("version" t (lambda (args) (erc-version)))))


(add-to-list 'erc-modules 'autojoin)

(setq erc-autojoin-channels-alist
          '(("libera.chat" "#systemcrafters")))

(erc-tls :server "irc.libera.chat" :port 6697
      :nick "crafter-bot" :password (getenv "BOT_PASSWORD") )


;;; crafter-bot.el ends here
