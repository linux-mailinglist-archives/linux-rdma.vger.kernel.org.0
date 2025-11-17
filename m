Return-Path: <linux-rdma+bounces-14553-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B80EC6619A
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 21:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id BAE6329895
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 20:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A0E33E375;
	Mon, 17 Nov 2025 20:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIl4bzvf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F7633FE08;
	Mon, 17 Nov 2025 20:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763411025; cv=none; b=h1kSvoSuvgsbFdvqU8JqczFlweYLmHtObmiiloxJg3AupYDSat4Ij0AzJ+6ZVHxrJIxEz/RLkdxw7oprQQflEarf04w+B1/q1Z5Yg6Oi6JLbkqb/7oGhG6d382xPRywf+4sARCXcos8vXXS+jIB0x3CQ92SfTcMLHKEIHOI3d0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763411025; c=relaxed/simple;
	bh=KJGTqMuDz6xP/mTvVlxoU8bI1ZdHW8l4XaOr+Fh62JM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iq9JkkQ+/6ob407slClJrx1UulUF+w5dkxdnDr1j0AJSvCu7Mv7wQRW57uvzlg30rPGdPEvMPHC3mYc1ux9DqkLCjQe/8u9gGK2vVSsnZx2u1RSbIJiuDuqgaKH41YvnEJg2FEHMvFzkZUwCA56X1lMgnakCo3Ip3kH8BlfuSio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIl4bzvf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DA2C4AF0D;
	Mon, 17 Nov 2025 20:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763411023;
	bh=KJGTqMuDz6xP/mTvVlxoU8bI1ZdHW8l4XaOr+Fh62JM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IIl4bzvfJhOdlQYB+MG1VYfDXutr+g+R7zVsxx/2xB6lA6oLx2rfqkQEoQAwOQP4+
	 isfBJO+5CAr2HGyKkbNgvo0Zu+k7/blH0T4R6tGxnWC08+EZD87VmnR4URCQ0//aqZ
	 mbXjzRdujKK98bcY7emCW/f4GoICi49JbKr5z+cjKFetiPpz15zj3pBKz3CUXrsCm3
	 cm8S9nXqrDQCWktCj/jXDn3Wk2DXf0GkaHAjbsZBkdpyT4mobu1TVE9i5HAWicXE60
	 bxgmI0TEeTSSmcTAijldzGKXXLA7PV6CKr4Oty6VsF84fOAZr2PXmDlfkm8DELORUj
	 bbRNAZZ4Z242A==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Cc: achender@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	rds-devel@oss.oracle.com,
	kuba@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v2 2/2] net/rds: Give each connection its own workqueue
Date: Mon, 17 Nov 2025 13:23:38 -0700
Message-ID: <20251117202338.324838-3-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251117202338.324838-1-achender@kernel.org>
References: <20251117202338.324838-1-achender@kernel.org>
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
node_nr_active flex array.  While an RDS/IB connection
totals only ~5 MBytes.

So we're getting a signficant performance gain
(90% of connections fail over under 3 seconds vs. 40%)
for a less than 0.02% overhead.

RDS doesn't even benefit from the additional rescue workers:
of all the reasons that RDS blocks workers, allocation under
memory pressue is the least of our concerns. And even if RDS
was stalling due to the memory-reclaim process, the work
executed by the rescue workers are highly unlikely to free up
any memory. If anything, they might try to allocate even more.

By giving each connection its own workqueues, we allow RDS
to better utilize the unbound workers that the system
has available.

Signed-off-by: Somasundaram Krishnasamy <somasundaram.krishnasamy@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/connection.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index dc7323707f450..dcb554e10531f 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -269,7 +269,15 @@ static struct rds_connection *__rds_conn_create(struct net *net,
 		__rds_conn_path_init(conn, &conn->c_path[i],
 				     is_outgoing);
 		conn->c_path[i].cp_index = i;
-		conn->c_path[i].cp_wq = rds_wq;
+		conn->c_path[i].cp_wq = alloc_ordered_workqueue(
+						"krds_cp_wq#%lu/%d", 0,
+						rds_conn_count, i);
+		if (!conn->c_path[i].cp_wq) {
+			while (--i >= 0)
+				destroy_workqueue(conn->c_path[i].cp_wq);
+			conn = ERR_PTR(-ENOMEM);
+			goto out;
+		}
 	}
 	rcu_read_lock();
 	if (rds_destroy_pending(conn))
@@ -471,6 +479,9 @@ static void rds_conn_path_destroy(struct rds_conn_path *cp)
 	WARN_ON(work_pending(&cp->cp_down_w));
 
 	cp->cp_conn->c_trans->conn_free(cp->cp_transport_data);
+
+	destroy_workqueue(cp->cp_wq);
+	cp->cp_wq = NULL;
 }
 
 /*
-- 
2.43.0


