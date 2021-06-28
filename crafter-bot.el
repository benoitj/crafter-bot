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

(add-to-list 'load-path "lib")
(add-to-list 'load-path "lib/commands")

(defvar erc-bot-nick (getenv "BOT_NICK"))
(defvar erc-bot-irc-server (getenv "BOT_IRC_SERVER"))
(defvar erc-bot-irc-port (getenv "BOT_IRC_PORT"))
(defvar erc-bot-password (getenv "BOT_PASSWORD"))
(defvar erc-bot-channel (getenv "BOT_CHANNEL"))

(defvar erc-robot-command-prefix-pattern ",")

(require 'erc-robot)
(require 'erc)

(add-hook 'erc-server-PRIVMSG-functions 'erc-robot-remote t)
(add-hook 'erc-send-completed-hook 'erc-robot-local t)

(setq crafter-urls '(("wiki" . "https://wiki.systemcrafters.cc")
                     ("wiki-gh" . "https://github.com/SystemCrafters/wiki-site")))

;; TODO need to split this into modular functions. possibly self adding
;; themselves when calling a function/loading
(setq erc-robot-commands
       '(("url" t (lambda (args) (if (string-blank-p args) (cdr (assoc args crafter-urls)) (concat "urls available: "))))))

(require 'cmd-basic)
(require 'version)

(add-to-list 'erc-modules 'autojoin)

;; TODO move this to a sane place
(defun erc-bot/get-domain (fqdn)
  "Calculates the domain in a 2nd level form.
FQDN is the fully qualified domain, which can be 2nd level or more."
  (let ((string fqdn))
    (when (string-match "\\([^.]+\\.[^.]+\\)$" string)
      (match-string 1 string))))


(setq erc-autojoin-channels-alist
      (list (list (erc-bot/get-domain erc-bot-irc-server) erc-bot-channel)))

;;(message erc-autojoin-channels-alist)

(if (getenv "BOT_PASSWORD") (message "a password was set"))

(erc-tls :server erc-bot-irc-server :port erc-bot-irc-port
      :nick erc-bot-nick :password erc-bot-password)

;;; crafter-bot.el ends here
