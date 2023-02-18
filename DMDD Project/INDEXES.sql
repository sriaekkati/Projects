create index index_lease on lease(LEASE_ID,
UNIT_ID,
LEASE_AMOUNT,
OWNER_NAME,
MANAGER_CONTACT,
LEASE_START_DATE,
LEASE_END_DATE,
TENANT_ID);

create index index_maintenace on maintenance (MAIN_ID,UNIT_ID,MAIN_AMOUNT,
UNIT_CONTACT,
MAIN_START_DATE,
MAIN_END_DATE,
MAIN_TYPE,
MAIN_DIFF);

create index index_manager on manager (MANAGER_ID,
MANAGER_NAME,
MANAGER_CONTACT,
MANAGER_ADDRESS);

create index index_owner on owner (OWNER_ID,
PROPERTY_ID,
MANAGER_ID,
OWNER_NAME,
OWNER_CONTACT,
OWNER_ADDRESS);

create index index_property on property (PROPERTY_ID,
MANAGER_ID,
UNIT_COUNT,
PROPERTY_OWNER,
PROPERTY_ADDRESS);

create index index_tenants on tenants( TENANT_ID,
TENANT_NAME,
TENANT_ADDRESS,
TENANT_CONTACT);

create index index_unit on unit (UNIT_ID,
TENANT_ID,
OWNER_ID,
MANAGER_ID,
UNIT_RENT,
UNIT_OWNER,
UNIT_ADDRESS);


