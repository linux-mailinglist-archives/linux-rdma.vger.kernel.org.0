Return-Path: <linux-rdma+bounces-17082-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EdxHHbSnGkJLAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17082-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 23:19:34 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B9317E2E2
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 23:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A4303031382
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 22:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146F337AA77;
	Mon, 23 Feb 2026 22:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeRpe5mE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7EE37AA63;
	Mon, 23 Feb 2026 22:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771885160; cv=none; b=qsV2kfEpD/S71BGTtVwScKrr+PhukCtan1OGiU0oPOksi/KmsoUoWBcfwlXECCm9mA61dOXDl4zPJE+8k3Gnl8uF4fj7d1nIckGMJJFSuq7REluNeC/taoj3KTYOBXPVCpV5vkw2B792wN2ZDY/FOTiLmuXcR3I7nhuDfBlV+Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771885160; c=relaxed/simple;
	bh=sD2WR/bKLLG8TZ1aq4FfU33S1wSbubgBlSEM2e7w8ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/zPjxnnO69EM1bxhL0rwktUAiWuCjS5aNymlBGgUSpmeO81jzelZWz7Omj3L1ASkfqG6yOmcOeDsZM96Judk4AlqItZeVpg7KQM7L8ld+Zb1kMShkNbnenEXfrhc1EEoS8UHvwZBe8x05XINQ336wDJpx95QZNuepHNfyBvakA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeRpe5mE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1750BC19421;
	Mon, 23 Feb 2026 22:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771885160;
	bh=sD2WR/bKLLG8TZ1aq4FfU33S1wSbubgBlSEM2e7w8ZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oeRpe5mExcgbVUq80TBks6AkDImuf25PQCpayVpcE3utPZezYurhPXmK2hxxBDcq4
	 rYC80ODzKNrCZ4ybrTrieEFkdYneBNjPMVDtFwSQ0SaRbOxihO8SZvg60kdIWVnC2/
	 1IL+u63vycbfx5kG56NDFO+yDnabtjJNhVzCWuTYyDLGApX5xUw3AXI/F/4Zr35p45
	 rMQi/FmBsdXeS2kk/V97K75d2n/j5PQmZKS8a/sn5DyBhPBWCeb+iJsq9buTw61vSv
	 5VpQ1TaUwO3BJwfIC8fp6anlcVPwj/81j0bZ/v9Xg6wk09H5AUhdvcZAxlAU9cwza0
	 4QRKnS13sYAMQ==
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
Subject: [PATCH net-next v5 1/2] net/rds: Refactor __rds_conn_create for blocking transport cleanup
Date: Mon, 23 Feb 2026 15:19:17 -0700
Message-ID: <20260223221918.2750209-2-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223221918.2750209-1-achender@kernel.org>
References: <20260223221918.2750209-1-achender@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-17082-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 42B9317E2E2
X-Rspamd-Action: no action

The next patch will delegate fanout operations to a background worker,
which adds cancel_work_sync() to rds_tcp_conn_free(). This is called
during a connection cleanup and requires an operations to be blocking.
However, the error path of __rds_conn_create() currently calls
trans->conn_free() while holding rds_conn_lock (spinlock) and
rcu_read_lock, which creates an atomic context where cancel_work_sync()
cannot sleep.

To avoid this, refactor the error/race paths to defer
trans->conn_free() calls until after locks are released at the out:
label. The 'out:' label already runs outside locks because
destroy_workqueue() can sleep. So we extend this pattern to transport
cleanup as well.  This way, connections that "lose" the race are safe
to clean up outside the critical section since they were never added
to the hashtable, and therefore are inaccessible to other threads.

Link: https://ci.syzbot.org/series/1a5ef180-c02c-401d-9df7-670b18570a55
Signed-off-by: Allison Henderson <achender@kernel.org>
---
 net/rds/connection.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index 185f73b01694..804e928da223 100644
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
+			 * after the out: label so it runs outside the
+			 * rds_conn_lock spinlock and rcu_read_lock section,
+			 * since both destroy_workqueue() and conn_free can
+			 * block. The local free_trans pointer is only set in
+			 * the race-loss paths where conn_alloc() succeeded.
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


