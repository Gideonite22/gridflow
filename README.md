# GridFlow

## Project Overview
GridFlow is a decentralized energy distribution network leveraging the Stacks blockchain for transparent, secure energy trading and grid management.

### Key Features
- Decentralized energy grid participant registration and management
- Transparent, blockchain-based energy trading
- Secure grid operations and maintenance

### Project Description
GridFlow aims to revolutionize the energy distribution industry by providing a decentralized platform for energy grid participants to register, trade energy, and manage grid operations. By leveraging the Stacks blockchain, GridFlow offers a transparent, secure, and tamper-resistant system for energy distribution, enabling efficient and trustworthy energy trading and grid management.

## Contract Architecture

### energy-grid-registry.clar
The `energy-grid-registry` contract is the main smart contract for GridFlow's energy grid participant registration and management system. It provides the following functionality:

**Data Structures**:
- `grid-participants`: A map that stores information about registered energy grid participants, including their principal address, energy production/consumption details, and grid role.
- `pending-registrations`: A map that stores information about pending grid participant registration requests.

**Public Functions**:
- `register-participant`: Allows an energy grid participant to register with the system, providing their details and requesting grid access.
- `approve-registration`: Enables an authorized grid operator to approve a pending registration request.
- `update-participant-info`: Allows a registered grid participant to update their information, such as energy production/consumption details or grid role.
- `remove-participant`: Enables an authorized grid operator to remove a registered grid participant from the system.

**Permissions and Authentication**:
- The `register-participant` function can be called by any principal.
- The `approve-registration` and `remove-participant` functions can only be called by authorized grid operators.
- The `update-participant-info` function can only be called by the associated grid participant.

## Installation & Setup

To set up the GridFlow project, follow these steps:

1. Ensure you have Clarinet installed on your system.
2. Clone the GridFlow repository: `git clone https://github.com/gridflow/gridflow.git`.
3. Navigate to the project directory: `cd gridflow`.
4. Install the project dependencies: `npm install`.
5. Run the Clarinet development environment: `clarinet dev`.

## Usage Guide

### Registering a Grid Participant
To register as a new grid participant, call the `register-participant` function, providing your principal address and grid details:

```javascript
(register-participant 'ABCD1234 100 "producer")
```

This will add your registration request to the `pending-registrations` map, awaiting approval from an authorized grid operator.

### Approving a Registration Request
Grid operators can approve pending registration requests by calling the `approve-registration` function, passing the principal address of the requesting participant:

```javascript
(approve-registration 'ABCD1234)
```

This will move the participant from the `pending-registrations` map to the `grid-participants` map, granting them access to the energy grid.

### Updating Participant Information
Registered grid participants can update their information, such as energy production/consumption details or grid role, by calling the `update-participant-info` function:

```javascript
(update-participant-info 'ABCD1234 200 "consumer")
```

### Removing a Participant
Grid operators can remove a registered participant from the system by calling the `remove-participant` function, passing the principal address of the participant:

```javascript
(remove-participant 'ABCD1234)
```

This will remove the participant from the `grid-participants` map, revoking their access to the energy grid.

## Testing

The GridFlow project includes a comprehensive test suite for the `energy-grid-registry` contract, located in the `/workspace/tests/energy-grid-registry_test.ts` file. These tests cover all major functionalities and edge cases, ensuring the contract's behavior meets the expected requirements.

To run the tests, use the Clarinet CLI:

```
clarinet test
```

The test suite includes the following key scenarios:

1. Successful participant registration and approval
2. Participant information update
3. Participant removal by authorized grid operator
4. Handling of invalid or unauthorized function calls

## Security Considerations

The GridFlow project has several security measures in place to ensure the integrity and reliability of the energy grid management system:

**Permissions and Authorization**:
- The `approve-registration` and `remove-participant` functions can only be called by authorized grid operators, ensuring that only trusted parties can manage grid participants.
- The `update-participant-info` function can only be called by the associated grid participant, preventing unauthorized updates to participant information.

**Data Validation**:
- The contract includes various assertions to validate input data, such as ensuring principal addresses are valid and grid role values are within the expected range.
- The contract also performs checks to prevent duplicate registrations and ensure that only registered participants can update their information or be removed from the system.

**Transparency and Auditability**:
- By leveraging the Stacks blockchain, all grid participant registrations, updates, and removals are recorded on the distributed ledger, providing a transparent and auditable history of grid management activities.

## Examples

### Participant Registration
```javascript
(register-participant 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM 100 "producer")
```

Expected response:
```
(ok (tuple (participant-info (tuple (principal 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM) (energy-production 100) (grid-role "producer"))) (registration-status pending)))
```

### Participant Approval
```javascript
(approve-registration 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM)
```

Expected response:
```
(ok (tuple (participant-info (tuple (principal 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM) (energy-production 100) (grid-role "producer"))) (registration-status approved)))
```

### Participant Information Update
```javascript
(update-participant-info 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM 200 "consumer")
```

Expected response:
```
(ok (tuple (participant-info (tuple (principal 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM) (energy-consumption 200) (grid-role "consumer"))) (registration-status approved)))
```

### Participant Removal
```javascript
(remove-participant 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM)
```

Expected response:
```
(ok true)
```