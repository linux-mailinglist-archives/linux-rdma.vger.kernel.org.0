Return-Path: <linux-rdma+bounces-15312-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B9ACF5DA4
	for <lists+linux-rdma@lfdr.de>; Mon, 05 Jan 2026 23:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66BEB309D6D8
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jan 2026 22:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CB03101B8;
	Mon,  5 Jan 2026 22:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9yriTIz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A2B30214B;
	Mon,  5 Jan 2026 22:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767652536; cv=none; b=IOOV1iYb9z28F/CapBc/fnv7usjgdu6r5EeXgWu8koY74DBr61U5JpWpXx4JJ1Uep+wYiLEaidGwRcp4JFngcsv/KaR3uC4mB9W9TyjtTwq/AXLARJBletDC6eYBSRgTpCvgnHEIaQf7oGrGXoKxMg40DTeCWZeTMff3FKuSQD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767652536; c=relaxed/simple;
	bh=+kM/GmtIbqwQHLHwaHV1Ua9/YznqzafHBGOpDlPW/ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcY3yebjUp+YusAUjB16I+hHsXLW2f3Null6U5i/tx76r72csCRoUqRVrIjWO9DrvCwU/JuPqlTisVFmazGsIMM2ZVAocIZzP4sdUn5IuLtQYOyHx+uQcKIFPNvH9r2d4lbJVTS+w/ePhs6DrU4+9Q5qRhI+aQAWVvELW24nPgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9yriTIz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68272C19422;
	Mon,  5 Jan 2026 22:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767652536;
	bh=+kM/GmtIbqwQHLHwaHV1Ua9/YznqzafHBGOpDlPW/ZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C9yriTIzDSmqY9ZQbkBkLTBwW9dlznAujNenik8XKRMgOHKlcP9XJhWPdNB79M1l9
	 SmBCyk2b3VMEtOShaHEFArQ6uaL0tlsVbLfuavfz/M7cqsx6ek89xzLSn2gHWnSAlP
	 GK5n3jjxvs3A9YJoCDJyDkyVp6etZAicJ1uwY9Xddd1gTmN6uEwEIpdLse2g+/e5i8
	 zfLUEoFmR/luUTrpRsq55iF/hldzzC+yYTmAauAIFsJHyzFNdoCGcBJk1W/n81/4b7
	 dwVAfSXV3WoTjkwPUzUm+n0f1kAsZai/I4kWHFUUUXgS9OyvcYlLpuZUh0IH/ewaK1
	 GZNVNiNgmAv/g==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	rds-devel@oss.oracle.com,
	kuba@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	allison.henderson@oracle.com
Subject: [PATCH net-next v4 2/2] net/rds: Give each connection path its own workqueue
Date: Mon,  5 Jan 2026 15:35:32 -0700
Message-ID: <20260105223532.167452-3-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260105223532.167452-1-achender@kernel.org>
References: <20260105223532.167452-1-achender@kernel.org>
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
 net/rds/connection.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index dc7323707f450..3743940423c83 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -269,7 +269,11 @@ static struct rds_connection *__rds_conn_create(struct net *net,
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
@@ -278,6 +282,9 @@ static struct rds_connection *__rds_conn_create(struct net *net,
 		ret = trans->conn_alloc(conn, GFP_ATOMIC);
 	if (ret) {
 		rcu_read_unlock();
+		for (i = 0; i < npaths; i++)
+			if (conn->c_path[i].cp_wq != rds_wq)
+				destroy_workqueue(conn->c_path[i].cp_wq);
 		kfree(conn->c_path);
 		kmem_cache_free(rds_conn_slab, conn);
 		conn = ERR_PTR(ret);
@@ -471,6 +478,11 @@ static void rds_conn_path_destroy(struct rds_conn_path *cp)
 	WARN_ON(work_pending(&cp->cp_down_w));
 
 	cp->cp_conn->c_trans->conn_free(cp->cp_transport_data);
+
+	if (cp->cp_wq != rds_wq) {
+		destroy_workqueue(cp->cp_wq);
+		cp->cp_wq = NULL;
+	}
 }
 
 /*
-- 
2.43.0


