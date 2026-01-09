Return-Path: <linux-rdma+bounces-15419-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD8DD0C7D3
	for <lists+linux-rdma@lfdr.de>; Fri, 09 Jan 2026 23:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0F9F304D496
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jan 2026 22:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7E7342511;
	Fri,  9 Jan 2026 22:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozCS9+Qa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26501DED40;
	Fri,  9 Jan 2026 22:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767998929; cv=none; b=Pj0NPtrGA/i9tF5OBvec8bzvhIDeiebU4u7HvzwmgDeSw/Lq01kHFKbNgnVTQrf9y57ImtpulSYImnkoRDiVxbDzymWjs7uCnMiHZYM5u6aEjwPkUe6ja7dpTTsxA+EEtm09nkB1FF/DHapWlbMQMDr0VJYb3iB6242By5ymQWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767998929; c=relaxed/simple;
	bh=rfjs+4eO/pfFU9aLnoH93R/W3RzQ4/iFc6yYQgpU3/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FxeBtPxSO+mwJ0sas4//5jOz9GsA6tJE/PJIzHVvUvTgMV85lBzwvfhLo9NjskENwcNN5YlTvd2CpP7skUNd6beXdYe6gI43QON20hBZoFhDVdAl62xG0mwaQAOFb6opYYeLJwEWVelLIFoVdSwLkPiDEimGXbj7M4xwAV1a4GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozCS9+Qa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C31C19421;
	Fri,  9 Jan 2026 22:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767998926;
	bh=rfjs+4eO/pfFU9aLnoH93R/W3RzQ4/iFc6yYQgpU3/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ozCS9+QamXWmoYWaf0FtEM7N3V9bzaZGCISS7JX9+potu/oMmcMewZkJJnDQDo+gx
	 VTmDD77WHUdgNH7P3xcAgDGgfbov4LWLjMepEAcGW0OkTCGS3W71Xn/VCB24fpDljD
	 eLwnyf5gTJnZsUItip/YcNfsrXc31sJcZsjerz/787GCji07QQKNqJpIbJ+PzsPLWI
	 cZxvH0nWxeZqV0j5yRdWvj0aDKhA7KhpmCe4NKoEB9Dqj23KITfV49o/Hi7TNZcfmA
	 wyddMft1ULuSEin6g0FlzV7FThyrxE67VDTasrHPmJBe3FwgXCqGXu/EYfjuDTk7vU
	 jmdUZkEVUAiDw==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	rds-devel@oss.oracle.com,
	kuba@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	allison.henderson@oracle.com
Subject: [PATCH net-next v5 2/2] net/rds: Give each connection path its own workqueue
Date: Fri,  9 Jan 2026 15:48:43 -0700
Message-ID: <20260109224843.128076-3-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109224843.128076-1-achender@kernel.org>
References: <20260109224843.128076-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Allison Henderson <allison.henderson@oracle.com>

RDS was written to require ordered workqueues for "cp->cp_wq":
Work is executed in the order scheduled, one item at a time.

If these workqueues are shared across connections,
then work executed on behalf of one connection blocks work
scheduled for a different and unrelated connection.

Luckily we don't need to share these workqueues.
While it obviously makes sense to limit the number of
workers (processes) that ought to be allocated on a system,
a workqueue that doesn't have a rescue worker attached,
has a tiny footprint compared to the connection as a whole:
A workqueue costs ~900 bytes, including the workqueue_struct,
pool_workqueue, workqueue_attrs, wq_node_nr_active and the
node_nr_active flex array.  Each connection can have up to 8
(RDS_MPATH_WORKERS) paths for a worst case of ~7 KBytes per
connection.  While an RDS/IB connection totals only ~5 MBytes.

So we're getting a signficant performance gain
(90% of connections fail over under 3 seconds vs. 40%)
for a less than 0.02% overhead.

RDS doesn't even benefit from the additional rescue workers:
of all the reasons that RDS blocks workers, allocation under
memory pressue is the least of our concerns. And even if RDS
was stalling due to the memory-reclaim process, the work
executed by the rescue workers are highly unlikely to free up
any memory. If anything, they might try to allocate even more.

By giving each connection path its own workqueues, we allow
RDS to better utilize the unbound workers that the system
has available.

Signed-off-by: Somasundaram Krishnasamy <somasundaram.krishnasamy@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/connection.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index dc7323707f45..e920c685e4f2 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -169,6 +169,7 @@ static struct rds_connection *__rds_conn_create(struct net *net,
 	struct rds_connection *conn, *parent = NULL;
 	struct hlist_head *head = rds_conn_bucket(laddr, faddr);
 	struct rds_transport *loop_trans;
+	struct rds_conn_path *free_cp = NULL;
 	unsigned long flags;
 	int ret, i;
 	int npaths = (trans->t_mp_capable ? RDS_MPATH_WORKERS : 1);
@@ -269,7 +270,11 @@ static struct rds_connection *__rds_conn_create(struct net *net,
 		__rds_conn_path_init(conn, &conn->c_path[i],
 				     is_outgoing);
 		conn->c_path[i].cp_index = i;
-		conn->c_path[i].cp_wq = rds_wq;
+		conn->c_path[i].cp_wq =
+			alloc_ordered_workqueue("krds_cp_wq#%lu/%d", 0,
+						rds_conn_count, i);
+		if (!conn->c_path[i].cp_wq)
+			conn->c_path[i].cp_wq = rds_wq;
 	}
 	rcu_read_lock();
 	if (rds_destroy_pending(conn))
@@ -278,7 +283,7 @@ static struct rds_connection *__rds_conn_create(struct net *net,
 		ret = trans->conn_alloc(conn, GFP_ATOMIC);
 	if (ret) {
 		rcu_read_unlock();
-		kfree(conn->c_path);
+		free_cp = conn->c_path;
 		kmem_cache_free(rds_conn_slab, conn);
 		conn = ERR_PTR(ret);
 		goto out;
@@ -301,7 +306,7 @@ static struct rds_connection *__rds_conn_create(struct net *net,
 		/* Creating passive conn */
 		if (parent->c_passive) {
 			trans->conn_free(conn->c_path[0].cp_transport_data);
-			kfree(conn->c_path);
+			free_cp = conn->c_path;
 			kmem_cache_free(rds_conn_slab, conn);
 			conn = parent->c_passive;
 		} else {
@@ -328,7 +333,7 @@ static struct rds_connection *__rds_conn_create(struct net *net,
 				if (cp->cp_transport_data)
 					trans->conn_free(cp->cp_transport_data);
 			}
-			kfree(conn->c_path);
+			free_cp = conn->c_path;
 			kmem_cache_free(rds_conn_slab, conn);
 			conn = found;
 		} else {
@@ -343,6 +348,13 @@ static struct rds_connection *__rds_conn_create(struct net *net,
 	rcu_read_unlock();
 
 out:
+	if (free_cp) {
+		for (i = 0; i < npaths; i++)
+			if (free_cp[i].cp_wq != rds_wq)
+				destroy_workqueue(free_cp[i].cp_wq);
+		kfree(free_cp);
+	}
+
 	return conn;
 }
 
@@ -470,6 +482,11 @@ static void rds_conn_path_destroy(struct rds_conn_path *cp)
 	WARN_ON(delayed_work_pending(&cp->cp_conn_w));
 	WARN_ON(work_pending(&cp->cp_down_w));
 
+	if (cp->cp_wq != rds_wq) {
+		destroy_workqueue(cp->cp_wq);
+		cp->cp_wq = NULL;
+	}
+
 	cp->cp_conn->c_trans->conn_free(cp->cp_transport_data);
 }
 
-- 
2.43.0


