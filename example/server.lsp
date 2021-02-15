(import "tcpip")
;; Please compile tcpip.lsp in library before. 


(defun server ()
  (let ((s (create (class socket)))
        (c nil)
        (msg ""))
    (setf (socket-ip s) "127.0.0.1")
    (setf (socket-n s) 5000)
    (create-server s)
    (setq c (server-accept s))
    (while (not (string= msg "end"))
           (setq msg (socket-recieve c))
           (print msg)
           (socket-send c msg))
    (socket-close s)))

(defun client ()
  (let ((s (create (class socket)))
        (msg ""))
    (setf (socket-ip s) "127.0.0.1")
    (setf (socket-n s) 5000)
    (client-connect s)
    (while (not (string= msg "end"))
           (setq msg (read))
           (socket-send s msg)
           (setq msg (socket-recieve s))
           (print msg))
    (socket-close s)))