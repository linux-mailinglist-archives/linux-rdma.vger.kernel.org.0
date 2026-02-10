Return-Path: <linux-rdma+bounces-16700-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yF6RM6X2imn2OwAAu9opvQ
	(envelope-from <linux-rdma+bounces-16700-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 10:13:09 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 870D1118B0B
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 10:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79EDB3040337
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 09:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC1C33FE23;
	Tue, 10 Feb 2026 09:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ht8GB0EK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0C033FE06;
	Tue, 10 Feb 2026 09:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770714758; cv=none; b=SBY8qXbwLntq7o9PKo2RwZXnNRS3sGcaf/N3or7i0l4Lsrx/JlS0CN/LKm8Kn0B+FQddfpbuQ3l1bWOjygKqKLYn5B6qNSR0gtfAPhzfhqY8MyZL8MkOO9BXNwTW+pypsj6/et0LVSmdoI99zCeBoahaI60TPmmLjc+QSAoK474=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770714758; c=relaxed/simple;
	bh=T8JBfOnZzFhkiZV7pzIixHwRITgR9Z74q5/j9dykHss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0BKOHLy/S6jkvY+94pQ4VB/oI7X6yVpw3mFEN8iyPuqyVo4k0FwrEyO9oXiqvyTAi1zEssrumPlzDbRV55SrKDJf153h11AsLhAXBZnpYwoNQae8zeDU5aKNNIxSDnv5zcDGmd5mVt1M7H7FIWRkrf8nl0XjKs0eSHxE5wGBHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ht8GB0EK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C81C2BC86;
	Tue, 10 Feb 2026 09:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770714758;
	bh=T8JBfOnZzFhkiZV7pzIixHwRITgR9Z74q5/j9dykHss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ht8GB0EKsjMgrwaAyg0rPEml1+g15bWpKPI3ZSRmBigfRe60wk2U9hGraQQp/F3NK
	 z2gP9fCmcush+TPESnxdxJqJDISLjvyVJx4wH6kdrV3uerdZ7UkCEZO6yozXjvppjp
	 K9hCfRYxHB8fFXb+CfhWM8ML2aajwI55MraENKMtWkZupsLp/pXpmQ6Ayukk4Bfrem
	 i4OWdYiANjlDlyLxCupCuUxDC4c0JgjmpgG4w8S75kROrsa8c7emfUCa4hD4OCReM9
	 1eh21NBVtHRfq2CuQDoGVtfWTE3O8UsXqmkjR3oSjFcPciWbpoiQ9pD1sOC60hk1Ii
	 dFuF6gFRxgvcA==
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
Subject: [PATCH net-next v3 2/4] net/rds: Refactor __rds_conn_create for blocking transport cleanup
Date: Tue, 10 Feb 2026 02:12:33 -0700
Message-ID: <20260210091235.1817860-3-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210091235.1817860-1-achender@kernel.org>
References: <20260210091235.1817860-1-achender@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16700-lists,linux-rdma=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,syzbot.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 870D1118B0B
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

Reported-by: syzbot+ci858e84e8400d24b3@syzkaller.appspotmail.com
Link: https://ci.syzbot.org/series/1a5ef180-c02c-401d-9df7-670b18570a55
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


