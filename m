Return-Path: <linux-rdma+bounces-16889-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLPAOOjokGkOdwEAu9opvQ
	(envelope-from <linux-rdma+bounces-16889-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Feb 2026 22:28:08 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A0513D69D
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Feb 2026 22:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C7EFB302F05C
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Feb 2026 21:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAAD3115AE;
	Sat, 14 Feb 2026 21:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTLEWEMu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED27299931;
	Sat, 14 Feb 2026 21:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104402; cv=none; b=LQ9MSEWKdTC32d9hbpRF2N/uOc7H9pFd3xr+bpLy5TKuQ/DoqycTEfBrdCtp9cpiyYFnlEvI4/159xoWoXmc61YhSC7cOAzPRTV+A23mr3NXNwBteYULI//sJFyxnGDA6D0WPxuZAKHjDVBRCl2kBoQ2q6SC9WnimyFnFMkWRTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104402; c=relaxed/simple;
	bh=UvLkX+9xD15Cd+k7HNmOmDR5vZ0py8+hHcUu0AeJ0Ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KRwdvBHC0ikzsVqVqst2UaqeTT1jVx9TCKq6iEKylKcAXD8FUJ2zMO6qOmqRM3uiYtoUvmNbyDl4czlMOdqy5TOQeqWE4XNoIVk63g5bq+BlZLXgFE4GxS6JrfLGY9UcP32st1zqt5OKKW2AcH6dVr9DBBvgVrZtzdK3aUI77sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTLEWEMu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8C3C19422;
	Sat, 14 Feb 2026 21:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771104402;
	bh=UvLkX+9xD15Cd+k7HNmOmDR5vZ0py8+hHcUu0AeJ0Ag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WTLEWEMuxRo0VvWu/3VAdoQgsDhnrKDANfOLvfHlQr/Jp7J7qr7oQ2SISvMTBcGHX
	 S5mNsz1rlZZv2vmH/nwWNYHO1z5H6GSZbvl/Bh8rLm9knXVhluHKT2Cl+I1L3aPdC0
	 gkVdz0YcS/0iM/PlxhEPeRTFEvmlMPRyG4ug5GIW3t6FGeDvKO0gzAnBCL85ljpKsm
	 EACgJTeoS7tUpmU3p39ugkoc4hXv4LFk7lBmFH5zR5uDgcYvmmYlllafxSoHw0xMyt
	 VSG9aX2+nsV9iEQrfeLEP4b56ggt7ocUY53s1QS6shP6cQ2TUDH2GG/Vq3KL9pl2OX
	 Mrkv3DyWFvgKw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Gerd Rausch <gerd.rausch@oracle.com>,
	Allison Henderson <allison.henderson@oracle.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com
Subject: [PATCH AUTOSEL 6.19-5.10] net/rds: No shortcut out of RDS_CONN_ERROR
Date: Sat, 14 Feb 2026 16:23:29 -0500
Message-ID: <20260214212452.782265-64-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260214212452.782265-1-sashal@kernel.org>
References: <20260214212452.782265-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16889-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 89A0513D69D
X-Rspamd-Action: no action

From: Gerd Rausch <gerd.rausch@oracle.com>

[ Upstream commit ad22d24be635c6beab6a1fdd3f8b1f3c478d15da ]

RDS connections carry a state "rds_conn_path::cp_state"
and transitions from one state to another and are conditional
upon an expected state: "rds_conn_path_transition."

There is one exception to this conditionality, which is
"RDS_CONN_ERROR" that can be enforced by "rds_conn_path_drop"
regardless of what state the condition is currently in.

But as soon as a connection enters state "RDS_CONN_ERROR",
the connection handling code expects it to go through the
shutdown-path.

The RDS/TCP multipath changes added a shortcut out of
"RDS_CONN_ERROR" straight back to "RDS_CONN_CONNECTING"
via "rds_tcp_accept_one_path" (e.g. after "rds_tcp_state_change").

A subsequent "rds_tcp_reset_callbacks" can then transition
the state to "RDS_CONN_RESETTING" with a shutdown-worker queued.

That'll trip up "rds_conn_init_shutdown", which was
never adjusted to handle "RDS_CONN_RESETTING" and subsequently
drops the connection with the dreaded "DR_INV_CONN_STATE",
which leaves "RDS_SHUTDOWN_WORK_QUEUED" on forever.

So we do two things here:

a) Don't shortcut "RDS_CONN_ERROR", but take the longer
   path through the shutdown code.

b) Add "RDS_CONN_RESETTING" to the expected states in
  "rds_conn_init_shutdown" so that we won't error out
  and get stuck, if we ever hit weird state transitions
  like this again."

Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
Link: https://patch.msgid.link/20260122055213.83608-2-achender@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis of net/rds: No shortcut out of RDS_CONN_ERROR

### 1. COMMIT MESSAGE ANALYSIS

The commit message is detailed and clearly describes a **state machine
bug** in the RDS (Reliable Datagram Sockets) TCP multipath code:

- A connection in `RDS_CONN_ERROR` state was being shortcut directly to
  `RDS_CONN_CONNECTING` via `rds_tcp_accept_one_path`, bypassing the
  required shutdown path.
- This leads to a subsequent transition to `RDS_CONN_RESETTING` with a
  shutdown worker queued.
- `rds_conn_init_shutdown` was never adjusted to handle
  `RDS_CONN_RESETTING`, causing it to drop the connection with
  `DR_INV_CONN_STATE`.
- This leaves `RDS_SHUTDOWN_WORK_QUEUED` set forever, effectively
  **permanently breaking the connection**.

The description of "leaves RDS_SHUTDOWN_WORK_QUEUED on forever" is a
serious consequence — it means the RDS connection gets permanently
stuck, which is essentially a hang/denial of service for RDS users.

### 2. CODE CHANGE ANALYSIS

The fix has two parts:

**Part A: `net/rds/tcp_listen.c` — Remove the shortcut from
RDS_CONN_ERROR**

```c
- if (rds_conn_path_transition(cp, RDS_CONN_DOWN,
- RDS_CONN_CONNECTING) ||
- rds_conn_path_transition(cp, RDS_CONN_ERROR,
- RDS_CONN_CONNECTING)) {
+ if (rds_conn_path_transition(cp, RDS_CONN_DOWN,
+                              RDS_CONN_CONNECTING)) {
```

This removes the problematic shortcut that allowed `RDS_CONN_ERROR` →
`RDS_CONN_CONNECTING` directly, which bypassed the shutdown path. The
comment explaining this shortcut behavior is also removed.

**Part B: `net/rds/connection.c` — Handle RDS_CONN_RESETTING in
shutdown**

```c
 if (!rds_conn_path_transition(cp, RDS_CONN_UP,
                               RDS_CONN_DISCONNECTING) &&
     !rds_conn_path_transition(cp, RDS_CONN_ERROR,
+                              RDS_CONN_DISCONNECTING) &&
+    !rds_conn_path_transition(cp, RDS_CONN_RESETTING,
                               RDS_CONN_DISCONNECTING)) {
```

This adds `RDS_CONN_RESETTING` as an acceptable state to transition from
during shutdown, making the shutdown code more robust against unexpected
state transitions.

### 3. BUG CLASSIFICATION

This is a **state machine bug** that leads to:
- **Connection hang**: RDS connections get permanently stuck with
  `RDS_SHUTDOWN_WORK_QUEUED` set forever
- **Denial of service**: Users of RDS (common in Oracle database
  clusters) lose connectivity
- This is effectively a **deadlock/livelock** in the connection state
  machine

### 4. SCOPE AND RISK ASSESSMENT

- **Files changed**: 2 files
- **Lines changed**: Very small — removing 3 lines from one function,
  adding 2 lines to another
- **Subsystem**: net/rds (RDS networking, widely used in Oracle
  environments)
- **Risk**: LOW — The changes are surgical and well-contained:
  - Part A removes a transition that was causing the bug (conservative
    change)
  - Part B adds defensive handling for an additional state in the
    shutdown path (safe addition)
- **Could this break something?**: Removing the shortcut means
  connections in ERROR state will take the longer path through shutdown.
  This is the correct/expected behavior and should not cause
  regressions.

### 5. USER IMPACT

RDS is used extensively in:
- Oracle RAC (Real Application Clusters) database environments
- High-availability enterprise systems
- Oracle Cloud Infrastructure

A permanently stuck connection is a serious production issue for these
users. The bug is in the multipath code path, which is actively used in
modern RDS deployments.

### 6. STABLE KERNEL CRITERIA

- **Obviously correct**: Yes — the commit message explains the problem
  clearly, and the fix is straightforward state machine correction
- **Fixes a real bug**: Yes — connections getting permanently stuck is a
  real, user-impacting bug
- **Important issue**: Yes — connection hangs in enterprise networking
  code
- **Small and contained**: Yes — minimal changes to 2 files in the same
  subsystem
- **No new features**: Correct — this only fixes state machine
  transitions
- **Tested**: The commit comes from Oracle developers (Gerd Rausch,
  Allison Henderson) who maintain RDS and was accepted by the net
  maintainer (Jakub Kicinski)

### 7. DEPENDENCY CHECK

The fix is self-contained. It modifies existing state transition logic
that has been present since the multipath changes were added. The
`RDS_CONN_RESETTING` state and the relevant functions all exist in
stable kernels that have RDS TCP multipath support.

### Summary

This is a clear bug fix for a state machine issue in RDS TCP multipath
that causes connections to get permanently stuck. The fix is small,
surgical, well-understood, and comes from the RDS subsystem maintainers
at Oracle. It fixes a real production issue (permanent connection hang)
with minimal risk of regression. It meets all stable kernel criteria.

**YES**

 net/rds/connection.c | 2 ++
 net/rds/tcp_listen.c | 5 -----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index 68bc88cce84ec..ad8027e6f54ef 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -382,6 +382,8 @@ void rds_conn_shutdown(struct rds_conn_path *cp)
 		if (!rds_conn_path_transition(cp, RDS_CONN_UP,
 					      RDS_CONN_DISCONNECTING) &&
 		    !rds_conn_path_transition(cp, RDS_CONN_ERROR,
+					      RDS_CONN_DISCONNECTING) &&
+		    !rds_conn_path_transition(cp, RDS_CONN_RESETTING,
 					      RDS_CONN_DISCONNECTING)) {
 			rds_conn_path_error(cp,
 					    "shutdown called in state %d\n",
diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index 820d3e20de195..27b6107ddc28d 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -59,9 +59,6 @@ void rds_tcp_keepalive(struct socket *sock)
  * socket and force a reconneect from smaller -> larger ip addr. The reason
  * we special case cp_index 0 is to allow the rds probe ping itself to itself
  * get through efficiently.
- * Since reconnects are only initiated from the node with the numerically
- * smaller ip address, we recycle conns in RDS_CONN_ERROR on the passive side
- * by moving them to CONNECTING in this function.
  */
 static
 struct rds_tcp_connection *rds_tcp_accept_one_path(struct rds_connection *conn)
@@ -86,8 +83,6 @@ struct rds_tcp_connection *rds_tcp_accept_one_path(struct rds_connection *conn)
 		struct rds_conn_path *cp = &conn->c_path[i];
 
 		if (rds_conn_path_transition(cp, RDS_CONN_DOWN,
-					     RDS_CONN_CONNECTING) ||
-		    rds_conn_path_transition(cp, RDS_CONN_ERROR,
 					     RDS_CONN_CONNECTING)) {
 			return cp->cp_transport_data;
 		}
-- 
2.51.0


