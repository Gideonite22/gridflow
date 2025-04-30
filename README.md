# GridFlow

## Project Overview
GridFlow is a decentralized energy distribution network leveraging the Stacks blockchain for transparent, secure energy trading and grid management. The platform enables peer-to-peer energy trading with a comprehensive marketplace system, automated settlement, and secure metering infrastructure.

### Key Features
- Decentralized energy grid participant registration and management
- Peer-to-peer energy trading marketplace with real-time pricing
- Fungible energy tokens for standardized trading units
- Smart meter integration with verification system
- Secure grid operations and maintenance
- Automated trade settlement and dispute resolution

### Project Description
GridFlow revolutionizes energy distribution by providing a decentralized platform for energy trading and grid management. By leveraging the Stacks blockchain, GridFlow offers a transparent, secure, and efficient system for energy distribution. The platform combines participant registration, energy trading, tokenization, and metering to create a complete ecosystem for decentralized energy markets.

## Contract Architecture

### energy-grid-registry.clar
The core registration and access control system for GridFlow participants. Enhanced with trading metadata support.

**Data Structures**:
- `grid-participants`: Stores participant information including trading capabilities
- `pending-registrations`: Manages registration requests
- `participant-metadata`: Enhanced trading statistics and reputation data

**Public Functions**:
- `register-participant`: Register new grid participants
- `approve-registration`: Approve pending registrations
- `update-participant-info`: Update participant information
- `remove-participant`: Remove participants from the system
- `update-reputation-score`: Modify participant reputation based on trading history
- `record-energy-transaction`: Log completed energy trades

### energy-trading.clar
The marketplace contract enabling peer-to-peer energy trading.

**Key Features**:
- Energy listing management
- Dynamic pricing mechanisms
- Automated trade settlement
- Escrow system for secure transactions
- Dispute resolution system

**Public Functions**:
- `create-energy-listing`: List energy for sale
- `purchase-energy`: Buy listed energy
- `place-bid`: Bid on auction-style listings
- `finalize-auction`: Complete auction-style sales
- `confirm-delivery`: Verify energy delivery
- `settle-payment`: Process payment after delivery
- `open-dispute`: Initiate dispute resolution

### energy-token.clar
A SIP-010 compliant fungible token representing standardized energy units.

**Features**:
- Fungible energy unit representation
- Standard token operations (transfer, mint, burn)
- Role-based minting and burning permissions
- Integration with trading system

**Key Functions**:
- `mint`: Create new energy tokens
- `burn`: Remove tokens from circulation
- `transfer`: Transfer tokens between participants
- `get-balance`: Check token holdings

### energy-metering.clar
Smart meter integration and verification system.

**Features**:
- Smart meter registration and management
- Energy reading verification
- Dispute resolution for readings
- Production/consumption tracking

**Key Functions**:
- `register-meter`: Add new smart meters
- `submit-energy-reading`: Record meter readings
- `verify-reading`: Validate submitted readings
- `file-dispute`: Contest incorrect readings
- `resolve-dispute`: Settle reading disputes

## Installation & Setup

1. Ensure you have Clarinet installed on your system.
2. Clone the GridFlow repository: `git clone https://github.com/gridflow/gridflow.git`
3. Navigate to the project directory: `cd gridflow`
4. Install the project dependencies: `npm install`
5. Run the Clarinet development environment: `clarinet dev`

## Usage Guide

### Participant Registration
```clarity
(register-participant 'ABCD1234 PARTICIPANT-TYPE-PRODUCER "location-data")
```

### Energy Trading
```clarity
;; List energy for sale
(create-energy-listing u1000 u500 PRICING-FIXED u0)

;; Purchase energy
(purchase-energy u1)

;; Place bid (for auction listings)
(place-bid u1 u550)
```

### Energy Token Operations
```clarity
;; Transfer energy tokens
(transfer u100 tx-sender 'RECIPIENT none)

;; Check balance
(get-balance 'ADDRESS)
```

### Smart Meter Integration
```clarity
;; Register a smart meter
(register-meter 0x1234 METER-TYPE-PRODUCER "location")

;; Submit reading
(submit-energy-reading 0x1234 block-height u100 0xSIGNATURE)
```

## Security Considerations

- **Role-Based Access Control**: Strict permissions for critical operations
- **Escrow System**: Secure trade settlement with funds in escrow
- **Verified Meters**: Only registered and verified meters can submit readings
- **Dispute Resolution**: Formal process for handling disputes
- **Multi-Stage Settlement**: Phased completion of trades with verification steps

## Examples

### Complete Trading Cycle
```clarity
;; 1. Create energy listing
(create-energy-listing u1000 u500 PRICING-FIXED u0)

;; 2. Purchase energy
(purchase-energy u1)

;; 3. Confirm delivery
(confirm-delivery u1)

;; 4. Settle payment
(settle-payment u1)
```

### Meter Reading Verification
```clarity
;; 1. Submit reading
(submit-energy-reading 0x1234 block-height u100 0xSIGNATURE)

;; 2. Verify reading
(verify-reading 0x1234 block-height true "Verification notes")
```

### Token Operations
```clarity
;; Mint tokens to producer
(mint u1000 'PRODUCER_ADDRESS)

;; Transfer tokens
(transfer u100 tx-sender 'CONSUMER_ADDRESS none)
```

The enhanced GridFlow system provides a complete solution for decentralized energy trading, from participant registration to final settlement, with robust security measures and dispute resolution mechanisms.