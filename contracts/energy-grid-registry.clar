;; GridFlow Energy Grid Registry Contract
;; Purpose: Manage participant registration and access control for decentralized energy distribution
;; Version: 1.0.0

;;; Constants for Participant Roles
(define-constant ROLE_PRODUCER u1)
(define-constant ROLE_CONSUMER u2)
(define-constant ROLE_OPERATOR u3)

;;; Error Codes
(define-constant ERR_UNAUTHORIZED u401)
(define-constant ERR_ALREADY_REGISTERED u402)
(define-constant ERR_PARTICIPANT_NOT_FOUND u403)
(define-constant ERR_INVALID_REGISTRATION u404)

;;; Data Structures
;; Participant metadata map
(define-map participants 
  principal 
  {
    role: uint,               ;; Role of the participant
    wallet: principal,        ;; Wallet address
    energy-capacity: uint,    ;; Energy production/consumption capacity
    location: (string-utf8 100), ;; Location details
    status: bool              ;; Active/Inactive status
  }
)

;; Contract owner (administrator)
(define-data-var contract-owner principal tx-sender)

;;; Authorization Checks
(define-private (is-contract-owner (sender principal))
  (is-eq sender (var-get contract-owner))
)

(define-private (is-participant-registered (user principal))
  (is-some (map-get? participants user))
)

;;; Helper Functions
(define-private (validate-registration 
  (wallet principal) 
  (role uint) 
  (energy-capacity uint) 
  (location (string-utf8 100))
)
  (begin
    ;; Validate role
    (asserts! 
      (or 
        (is-eq role ROLE_PRODUCER) 
        (is-eq role ROLE_CONSUMER) 
        (is-eq role ROLE_OPERATOR)
      ) 
      (err ERR_INVALID_REGISTRATION)
    )
    
    ;; Prevent duplicate registrations
    (asserts! (not (is-participant-registered wallet)) 
      (err ERR_ALREADY_REGISTERED)
    )
    
    ;; Additional validation for energy capacity
    (asserts! (> energy-capacity u0) 
      (err ERR_INVALID_REGISTRATION)
    )
    
    (ok true)
  )
)

;;; Public Functions
;; Register a new grid participant
(define-public (register-participant 
  (wallet principal) 
  (role uint) 
  (energy-capacity uint) 
  (location (string-utf8 100))
)
  (begin
    ;; Validate registration details
    (try! (validate-registration wallet role energy-capacity location))
    
    ;; Ensure only the participant can register themselves
    (asserts! (is-eq tx-sender wallet) (err ERR_UNAUTHORIZED))
    
    ;; Add participant to registry
    (map-set participants wallet {
      role: role,
      wallet: wallet,
      energy-capacity: energy-capacity,
      location: location,
      status: true  ;; Default to active status
    })
    
    (ok true)
  )
)

;; Update participant status (can only be done by contract owner)
(define-public (update-participant-status 
  (wallet principal) 
  (new-status bool)
)
  (begin
    ;; Check authorization (only contract owner can update status)
    (asserts! (is-contract-owner tx-sender) (err ERR_UNAUTHORIZED))
    
    ;; Ensure participant exists
    (asserts! (is-participant-registered wallet) (err ERR_PARTICIPANT_NOT_FOUND))
    
    ;; Update participant status
    (map-set participants wallet 
      (merge 
        (unwrap! (map-get? participants wallet) (err ERR_PARTICIPANT_NOT_FOUND))
        { status: new-status }
      )
    )
    
    (ok true)
  )
)

;; Remove a participant from the registry (can only be done by contract owner)
(define-public (remove-participant (wallet principal))
  (begin
    ;; Check authorization
    (asserts! (is-contract-owner tx-sender) (err ERR_UNAUTHORIZED))
    
    ;; Ensure participant exists
    (asserts! (is-participant-registered wallet) (err ERR_PARTICIPANT_NOT_FOUND))
    
    ;; Remove participant
    (map-delete participants wallet)
    
    (ok true)
  )
)

;;; Read-Only Functions
;; Get participant details
(define-read-only (get-participant-details (wallet principal))
  (map-get? participants wallet)
)

;; Check if a participant is active
(define-read-only (is-active-participant (wallet principal))
  (match (map-get? participants wallet)
    participant (get status participant)
    false
  )
)

;; Transfer contract ownership (only current owner can do this)
(define-public (transfer-ownership (new-owner principal))
  (begin
    (asserts! (is-contract-owner tx-sender) (err ERR_UNAUTHORIZED))
    (var-set contract-owner new-owner)
    (ok true)
  )
)