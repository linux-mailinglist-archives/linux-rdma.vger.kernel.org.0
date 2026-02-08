Return-Path: <linux-rdma+bounces-16671-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJVQDSkhiGmrjQQAu9opvQ
	(envelope-from <linux-rdma+bounces-16671-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Feb 2026 06:37:45 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FB6107EF6
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Feb 2026 06:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E0A3301AA46
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Feb 2026 05:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A5E3451B5;
	Sun,  8 Feb 2026 05:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1DwiFYS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357D0344DB6;
	Sun,  8 Feb 2026 05:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770529039; cv=none; b=AGy6ENBXhu9VMHrBM4BAgj3HvPMJTzhIBPn7KXilpREYjslNeXZoA9lWmsvLcXVE8zepF9osGKBQeSXCy+9Rz+Bs8K6k31sebQpxnsrDAY+p7TX4kBtCLqduivJcpbooJ0kr0wjVnUHNONbZcjhD8TyA08UPnPPx/Pl87E5z/bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770529039; c=relaxed/simple;
	bh=zHqyRY8FBdL4XYgJDEkTBXNjlKxTY6/XfTMs36rzRaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9BaymTyNifyoLctaAEtelXqiD/9Lm7arTB8jnZkeGcuOqDtOEhAYVDAvcnUwCZpU6weWcMqUIdhiRqtKNqDzwB67pxPexQOS+SgfzzxuGiizPE2NNAJrS5Bm5YZeajCUlWTFxM/EShQOj8UzC1sEA2cgw5JCjW9c1M9Yu/e/PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1DwiFYS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6E5C19424;
	Sun,  8 Feb 2026 05:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770529038;
	bh=zHqyRY8FBdL4XYgJDEkTBXNjlKxTY6/XfTMs36rzRaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R1DwiFYSImWuaogC2n03RWR3AbxiDMvD3QWpBufNz7n/EDATOgpcBBIr8whtXwbcH
	 JJxRkmx0vG19G5+FWdcBHqpfhUC16prXc9ooWUWNgF68d4OJNKqgd5wvUzntltFOvZ
	 +4lmC6vnCTZpD4mXT0xXSX6nSZcF3ZVukDEKWD9xiEhRVUu9wA5qh17Rd1LR1ya4gn
	 hywl0vv7jFwatHYDe/4qxfU87xTtmpeTUsPQ/2NFpxutJcdI4DBeoe2tCNay6eYm2g
	 nwDyRHxb9kSrdUTkCdAX4Ej9vS79xSLn7ruYWscMeRcXFzDA3siD0vAHMcdnfZT1LK
	 yf0XcSMI4oL7w==
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
Subject: [PATCH net-next v2 1/4] net/rds: Refactor __rds_conn_create for blocking transport cleanup
Date: Sat,  7 Feb 2026 22:37:13 -0700
Message-ID: <20260208053716.1617809-2-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260208053716.1617809-1-achender@kernel.org>
References: <20260208053716.1617809-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-16671-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C7FB6107EF6
X-Rspamd-Action: no action

The next patch will delegate fanout operations to a background worker,
which requires cancel_work_sync() during connection cleanup.  However,
the error path of __rds_conn_create() currently calls
trans->conn_free() while holding rds_conn_lock (spinlock) and
rcu_read_lock, which creates an atomic context where cancel_work_sync()
cannot sleep.

To avoid this, refactor the error/race paths to defer
trans->conn_free() calls until after locks are released. This allows
transport cleanup functions to perform blocking operations safely.

This patch moves the cp_transport_data cleanup to the 'out:' label
where it runs outside the critical section, after the connection has
been freed from the slab and cannot be accessed by racing threads.

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 net/rds/connection.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index 185f73b01694..695ab7446178 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -170,6 +170,7 @@ static struct rds_connection *__rds_conn_create(struct net *net,
 	struct hlist_head *head = rds_conn_bucket(laddr, faddr);
 	struct rds_transport *loop_trans;
 	struct rds_conn_path *free_cp = NULL;
+	struct rds_transport *free_trans = NULL;
 	unsigned long flags;
 	int ret, i;
 	int npaths = (trans->t_mp_capable ? RDS_MPATH_WORKERS : 1);
@@ -305,7 +306,7 @@ static struct rds_connection *__rds_conn_create(struct net *net,
 	if (parent) {
 		/* Creating passive conn */
 		if (parent->c_passive) {
-			trans->conn_free(conn->c_path[0].cp_transport_data);
+			free_trans = trans;
 			free_cp = conn->c_path;
 			kmem_cache_free(rds_conn_slab, conn);
 			conn = parent->c_passive;
@@ -321,18 +322,7 @@ static struct rds_connection *__rds_conn_create(struct net *net,
 		found = rds_conn_lookup(net, head, laddr, faddr, trans,
 					tos, dev_if);
 		if (found) {
-			struct rds_conn_path *cp;
-			int i;
-
-			for (i = 0; i < npaths; i++) {
-				cp = &conn->c_path[i];
-				/* The ->conn_alloc invocation may have
-				 * allocated resource for all paths, so all
-				 * of them may have to be freed here.
-				 */
-				if (cp->cp_transport_data)
-					trans->conn_free(cp->cp_transport_data);
-			}
+			free_trans = trans;
 			free_cp = conn->c_path;
 			kmem_cache_free(rds_conn_slab, conn);
 			conn = found;
@@ -349,9 +339,23 @@ static struct rds_connection *__rds_conn_create(struct net *net,
 
 out:
 	if (free_cp) {
-		for (i = 0; i < npaths; i++)
+		for (i = 0; i < npaths; i++) {
+			/*
+			 * The trans->conn_alloc call may have allocated
+			 * resources for the cp paths, which will need to
+			 * be freed before freeing cp itself.  We do this here
+			 * so it runs outside the rds_conn_lock spinlock
+			 * and rcu_read_lock section, because conn_free()
+			 * may call cancel_work_sync() which
+			 * can sleep.  free_trans is only set in the
+			 * race-loss paths where conn_alloc() succeeded.
+			 */
+			if (free_trans && free_cp[i].cp_transport_data)
+				free_trans->conn_free
+					(free_cp[i].cp_transport_data);
 			if (free_cp[i].cp_wq != rds_wq)
 				destroy_workqueue(free_cp[i].cp_wq);
+		}
 		kfree(free_cp);
 	}
 
-- 
2.43.0


