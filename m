Return-Path: <linux-rdma+bounces-15665-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD70D39247
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Jan 2026 03:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F31F302CBB3
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Jan 2026 02:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B6321ABC1;
	Sun, 18 Jan 2026 02:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYEjvSiK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1A1218AAB;
	Sun, 18 Jan 2026 02:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768704555; cv=none; b=UaEgiZVE0wHTt7TwBx6Eh3Myih92xcm/fikc5Kp/LasTNNoAtNgUBC+Cia2v6gWgcXATw/95a4ACXXVzPQ+Z9Ug0TNikzok5II3FJjXstTAt8JDjUI7hqzV8VrDpkcG0PrsB9NFCkvArwHegngDuxtKq5F+Q8J9T6r1pHUS0M3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768704555; c=relaxed/simple;
	bh=Nkps7cuMMzO7w/ZB91Fr1Lof39MTbmYWcS2q/PeV9hM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=teD99dHc1kD9YGlGD/+44o/qFRSnabHyZ7huUIVF/Bd4XS9R2mF2N7OKjphVlUjaSHvcayqgv30rbUCBC3kqPxnhcU/6jCjI76dUYJnYIzIobgskrN/W1INkuYRzVJSoRiIk7r53NV08Y8OzwE7EB3TbDFygEtzP53TMsuMdt+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYEjvSiK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930BAC19422;
	Sun, 18 Jan 2026 02:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768704555;
	bh=Nkps7cuMMzO7w/ZB91Fr1Lof39MTbmYWcS2q/PeV9hM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VYEjvSiKgTMebUNBuuwAKuswsIM+Chug1MnOi8KS1/kkPGdQfRtAlJvXc+A+Mri6m
	 nHEZTvEfjXCpuEBefgtZv+ndjxPCS2IIWKLkRD6lanKSLkdOanchuMsQzsBqsjEMr8
	 8R5aBYxmoDiekIkzJoNGIjDML58U3F+Bl+I86G3X/WQkaHQ3yDqPXsFRvd6hRVtPFn
	 JNf++k6irYET3wiR03QcfzYnZnwm2I2bbIaRxX0/QyPjeBuXpGcGQiTFn3CdRT4q0d
	 pWFaSOuwhni5imwhh6P1Tfy1MDXOhdR0HvodAoRsHMAMUxE+qGVDCXyMbtcOMIalVT
	 HMGGUFoKk6aUA==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	rds-devel@oss.oracle.com,
	kuba@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	allison.henderson@oracle.com
Subject: [PATCH net-next v1 2/3] net/rds: No shortcut out of RDS_CONN_ERROR
Date: Sat, 17 Jan 2026 19:49:10 -0700
Message-ID: <20260118024911.1203224-3-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118024911.1203224-1-achender@kernel.org>
References: <20260118024911.1203224-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gerd Rausch <gerd.rausch@oracle.com>

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

Fixes: 9c79440e2c5e ("RDS: TCP: fix race windows in send-path quiescence by rds_tcp_accept_one()")
Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/connection.c | 2 ++
 net/rds/tcp_listen.c | 5 -----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index e920c685e4f2..4a9d80d56f56 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -395,6 +395,8 @@ void rds_conn_shutdown(struct rds_conn_path *cp)
 		if (!rds_conn_path_transition(cp, RDS_CONN_UP,
 					      RDS_CONN_DISCONNECTING) &&
 		    !rds_conn_path_transition(cp, RDS_CONN_ERROR,
+					      RDS_CONN_DISCONNECTING) &&
+		    !rds_conn_path_transition(cp, RDS_CONN_RESETTING,
 					      RDS_CONN_DISCONNECTING)) {
 			rds_conn_path_error(cp,
 					    "shutdown called in state %d\n",
diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index 820d3e20de19..27b6107ddc28 100644
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
2.43.0


