Return-Path: <linux-rdma+bounces-15877-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBBSMiu7cWkNLwAAu9opvQ
	(envelope-from <linux-rdma+bounces-15877-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 06:52:43 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D166212D
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 06:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C318C3A7A9A
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 05:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF42B354ACA;
	Thu, 22 Jan 2026 05:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jy+B0xur"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BB6350299;
	Thu, 22 Jan 2026 05:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769061136; cv=none; b=utf4Ur8ChUJBXJxoEMh4WvqRFGN4PcJLSaJbLY/QX0qag9uH+YXFA6J4IxTZBMiOKCX+TL0BsWSVxWFrGG5/8eJ2zKdJiSyxW/EkYOQGHMzHhS7SufRWFoKKZRolp8pzGqR4wB3MBqQfFx4BwXoKwSbKWVOzgB7TjtflBW1k/hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769061136; c=relaxed/simple;
	bh=A51onBPTCUGqSZM8w4oSVuZY0G13lgMnDtm9L+z2txc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aqg8s/OubaWZoH3dvbjE2D38nGpczS4JlTfTwX3xWtO/FYFQbg82B9mk8CoV4XtPgtMcTHn/Pz73MbEWHfRUGkaKj61Tm/ONrKQnMNf37PhSIq1mbJtOc++3OGqy/HbF2JpS+h5chfWB1XjPHqsnlWR/6LbUHrwidWgcYBN7niQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jy+B0xur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF29C19422;
	Thu, 22 Jan 2026 05:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769061136;
	bh=A51onBPTCUGqSZM8w4oSVuZY0G13lgMnDtm9L+z2txc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jy+B0xurw6UftuW/3QeUgEN0/aht+5ZuZzWsB6zE+64Je4e3YbuS1FYM4TaLIKn2j
	 dBHmuBx9c7KbmA7GQ4qvHF7paN5UIiwbhImpMO0zJfN8StBxL+zkaFy0N+TkT55jUK
	 XjDL3Bsy3tcqs3a9hG2WiIYxQaWLwcRFJBE30GAjx/XjmCo+HEUtlCe+AVO15nqLPl
	 +50DIdge3/OcFFMok63fmQXt978M8g/rPbmBlvGsXynttqqhjEBtNjBK+EMcVMhyJp
	 lio6F2Lp0kqcBDTZiSsxWx6x2hCj+/jVnK6iJIe6yfouhCQvaOcfULlQ/+EGq+mHmG
	 Axe0jzXMpvV+w==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	rds-devel@oss.oracle.com,
	kuba@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	allison.henderson@oracle.com
Subject: [PATCH net-next v2 1/2] net/rds: No shortcut out of RDS_CONN_ERROR
Date: Wed, 21 Jan 2026 22:52:12 -0700
Message-ID: <20260122055213.83608-2-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260122055213.83608-1-achender@kernel.org>
References: <20260122055213.83608-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15877-lists,linux-rdma=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: B1D166212D
X-Rspamd-Action: no action

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

Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/connection.c | 2 ++
 net/rds/tcp_listen.c | 5 -----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index e920c685e4f29..4a9d80d56f56e 100644
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
2.43.0


