## Ambiguity 1: Platform Specific behavior detection
**Question**: Android or iOS, how to ditect which platform consume large memory in normal time ?

**Options Considered**:
- Option A: no need to ditect this.
- Option B: save device platform in database.

**Decision**: I chose Option B because, if i want to know the analytics about which operating system manage memory in better way, i can detect it.

**Trade-offs**: Need to add more column but it is absolutely worth it.

**Assumptions**: It will help user to select correct phone.


## Ambiguity 2: Retry mechanism
**Question**: how to handle the retry mechanism at history screen ? because there are two section in that screen. one for analytics and another for history list.

**Options Considered**:
- Option A: pull to refresh for whole page.
- Option B: add separate retry option for each section of the screen.

**Decision**: I chose Option B because, if user do not want to refresh its list but analytics data as well as vise-versa, then user will have option for both.

**Trade-offs**: More code added, but good user experience.

**Assumptions**: It will help user to use each feature of history screen indipendently.