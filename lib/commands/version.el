;;; version.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2021 Benoit Joly
;;
;; Author: Benoit Joly <https://github.com/benoitj>
;; Maintainer: Benoit Joly <benoit@benoitj.ca>
;; Created: June 13, 2021
;; Modified: June 13, 2021
;; Version: 0.0.1
;; Keywords: Symbol’s value as variable is void: finder-known-keywords
;; Homepage: https://github.com/benoit/version
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:

(provide 'version)

(defvar bot-version "local")

(if (file-exists-p "version.el")
  (load-file "version.el"))


(message (concat "version: " bot-version))


;;; version.el ends here
