Return-Path: <linux-rdma+bounces-16888-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /bqiCuXokGkadwEAu9opvQ
	(envelope-from <linux-rdma+bounces-16888-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Feb 2026 22:28:05 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B50A713D685
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Feb 2026 22:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA5593076E5D
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Feb 2026 21:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA7130DD00;
	Sat, 14 Feb 2026 21:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caJJOp4j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F27F3090C1;
	Sat, 14 Feb 2026 21:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104323; cv=none; b=qJ8g7UBzhzfjZe48aKFi9KPeMnZJGHfPSjSU2oDEa2NH0JU2zAUWyyyoDTESZUPYYLR9sz1RNUKV1f+9EX9WO0RNVbQEllpoPub70ZGALVPO+S6zO6x4wURcFICdqcXVQ9InS9uDwizk4dbHgNaCRIItPGrXO+6exgxAawiHabE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104323; c=relaxed/simple;
	bh=HNsIIUiNfMcrVXGaTxbgUw3HY9PSkBjZ42JbycFGdt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l0yxUDBySc3GvVAJFjrD7IEN4/fGalNyjoYJytLgNxaKiUFVgnaG1Wf5r2EVacmz5yQ7OQZbSxWDzP+4ju4GSCYOg6elbUc8Pr0yl6az9L2Z96JzWz6plLWP+LzCYICILZZU0l7ukvxywmWEP44y6euIgMRv0g0q764lfnoax7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caJJOp4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183FBC19422;
	Sat, 14 Feb 2026 21:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771104323;
	bh=HNsIIUiNfMcrVXGaTxbgUw3HY9PSkBjZ42JbycFGdt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=caJJOp4jgcuE8lQYjBZkLH56mw4XeyDSLXdulLpETeLjXZX8n0CNM058qL36d5tTD
	 IMeflfNc0GVS21dATaKXiKopBjDNJVhptJ5zBvrwWuzUskOHwOF0zXZ+P4N+qg7dfc
	 ZjMQPuS4PJkOTU7Lj2BoMUYivJ4oVeukj3VtDoOAl0+9UZWXj0kcTlyxZEGwrzOkTH
	 8UXBNrWy8H3I4eZmPxquko1F0yznKZ7VO+XIBp96TTb6+HHrTkR2Iyq3PUTD3/uigm
	 95a0I76V0I27UwZW0pTYJG2Tj9XEataKjmHhg9gcYqupuwgknq400Hzts2rheTuAZH
	 8BU7Nxi1KdRZw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
	Allison Henderson <allison.henderson@oracle.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com
Subject: [PATCH AUTOSEL 6.19-5.10] net/rds: Clear reconnect pending bit
Date: Sat, 14 Feb 2026 16:22:42 -0500
Message-ID: <20260214212452.782265-17-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260214212452.782265-1-sashal@kernel.org>
References: <20260214212452.782265-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16888-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: B50A713D685
X-Rspamd-Action: no action

From: Håkon Bugge <haakon.bugge@oracle.com>

[ Upstream commit b89fc7c2523b2b0750d91840f4e52521270d70ed ]

When canceling the reconnect worker, care must be taken to reset the
reconnect-pending bit. If the reconnect worker has not yet been
scheduled before it is canceled, the reconnect-pending bit will stay
on forever.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
Link: https://patch.msgid.link/20260203055723.1085751-6-achender@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

### 3. BUG MECHANISM — CLEAR AND CRITICAL

Now the full picture is clear:

**The flow:**
1. `rds_queue_reconnect()` at line 138 sets `RDS_RECONNECT_PENDING` and
   queues the delayed work.
2. `rds_connect_worker()` (the worker function) at line 173 clears
   `RDS_RECONNECT_PENDING` when it runs.
3. `rds_conn_path_connect_if_down()` at line 911 uses
   `test_and_set_bit(RDS_RECONNECT_PENDING, ...)` — if the bit is
   already set, it returns without queuing work, trusting that a
   reconnect is already pending.

**The bug:**
In `rds_conn_shutdown()`, `cancel_delayed_work_sync()` cancels the
queued worker. If the worker hadn't started yet, it never runs
`clear_bit(RDS_RECONNECT_PENDING, ...)`. The bit stays set. Then when
`rds_conn_path_connect_if_down()` is later called (e.g., when trying to
send data), `test_and_set_bit` finds the bit already set and skips
queuing — **forever**. The connection can never reconnect.

This is a **permanent connection failure** bug — once triggered, the RDS
connection path is effectively dead until the system is rebooted or the
module is reloaded.

### 4. CLASSIFICATION

- **Bug type:** State corruption / logic bug leading to permanent loss
  of network connectivity
- **Severity:** HIGH — RDS is used in production Oracle RAC clusters and
  RDMA-based environments
- **Trigger:** Race between shutdown and reconnect scheduling —
  realistic in production with network flaps

### 5. SCOPE AND RISK

- **Change size:** 1 functional line (plus 1 blank line) — extremely
  small and surgical
- **Files changed:** 1 file (`net/rds/connection.c`)
- **Risk of regression:** Very low — `clear_bit` is idempotent. If the
  worker already ran and cleared the bit, clearing it again is harmless.
  If the worker didn't run, this is the correct fix.
- **The fix is placed correctly:** After `cancel_delayed_work_sync()`
  guarantees the worker won't run, and before `rds_queue_reconnect()`
  which will set the bit again if needed.

### 6. STABLE KERNEL CRITERIA

- **Obviously correct:** Yes — the logic is straightforward and well-
  explained
- **Fixes a real bug:** Yes — permanent loss of RDS connectivity
- **Important issue:** Yes — affects network reliability for RDS users
  (Oracle, RDMA environments)
- **Small and contained:** Yes — 1 line in 1 file
- **No new features:** Correct — purely a bug fix
- **No new APIs:** Correct

### 7. DEPENDENCY CHECK

This fix is self-contained. It only adds a `clear_bit()` call after an
existing `cancel_delayed_work_sync()` call. The `RDS_RECONNECT_PENDING`
flag and the surrounding code have been in the kernel for a long time.
This should apply cleanly to any stable tree that has the RDS subsystem.

### Conclusion

This is a textbook stable backport candidate: a tiny, obviously correct,
one-line fix for a serious bug (permanent connection failure) in
networking code used in production environments. The fix has zero risk
of regression due to the idempotent nature of `clear_bit`, and the bug
mechanism is clearly explained and verified through code analysis.

**YES**

 net/rds/connection.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index ad8027e6f54ef..dbfea6fa11260 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -429,6 +429,8 @@ void rds_conn_shutdown(struct rds_conn_path *cp)
 	 * to the conn hash, so we never trigger a reconnect on this
 	 * conn - the reconnect is always triggered by the active peer. */
 	cancel_delayed_work_sync(&cp->cp_conn_w);
+
+	clear_bit(RDS_RECONNECT_PENDING, &cp->cp_flags);
 	rcu_read_lock();
 	if (!hlist_unhashed(&conn->c_hash_node)) {
 		rcu_read_unlock();
-- 
2.51.0


