Return-Path: <linux-rdma+bounces-14842-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA1DC95C2F
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Dec 2025 07:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F7754E196A
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Dec 2025 06:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C96238166;
	Mon,  1 Dec 2025 06:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/3M8oGa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AF42405ED;
	Mon,  1 Dec 2025 06:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764569440; cv=none; b=AX4pk3+iVBThe3qqm++QjGulIA1gGZW/q9IeVyp6SQeMIdFyGwx97SmhfMe4uDbwVTbKXZjPP+XbITt/6NE/fU7dl/wHZTVbfivnE4CcFf6Ie4TGk+4PIPV1Z13t7pUS280WyOTVdHxkyJ+7xB2S2xRP4CeHaPo4/fE3Om372eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764569440; c=relaxed/simple;
	bh=nD/uN2nQjuEcCbUGVV7Oea/rGh4tOwXodK7Pjls8eLM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nS2pQSvDAMpDzZSBFi2PNoxotQxXG82UQIYUHGL2j186GQNGtF9gYHnisiB9wUv4No9JCLjkACXrg+hk682Fu5tk9fW/p+KdVYUtlaOmQJWbYQNzLU9ilRrIOPIsrzkNHZiRnDTMD9hlKlvAGW8egsxhiG0V547xYWztWm42dI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/3M8oGa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DEFDC19421;
	Mon,  1 Dec 2025 06:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764569439;
	bh=nD/uN2nQjuEcCbUGVV7Oea/rGh4tOwXodK7Pjls8eLM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=T/3M8oGaSBrcSqR7IBpoJ8LlXjGs1xBAXvu39bTQyYHoyAYdnV3OHPrEWdRfWBP5i
	 xb6/6H6xJkTi+dO++y1wfJIrKwou8NgXObVF6Y8f/uass5rvLwhJyCCkjftEGDKySO
	 eKO9SfYdafy/10geR2pR8WdskQ36cfYHKHzUU5vC3f+EWUUrrAWK7dx0U87mJgDUVe
	 lPpaLBWMGt5YVE2Dbq0sltKyYHBnDMXA2SRL+9Fg2kpkGKcXPe3ql6INPXMDssct5W
	 beeqkATNjuBkLnldeT8VPxB9xOXL0V7TLmwraYZb6YiAVYddQzOg6DHwNQXpN57MpW
	 m7AYtRtFJZ3Rw==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	rds-devel@oss.oracle.com,
	kuba@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	allison.henderson@oracle.com
Subject: [PATCH net-next v3 2/2] net/rds: Give each connection path its own workqueue
Date: Sun, 30 Nov 2025 23:10:36 -0700
Message-ID: <20251201061036.48865-3-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251201061036.48865-1-achender@kernel.org>
References: <20251201061036.48865-1-achender@kernel.org>
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
 net/rds/connection.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index dc7323707f450..cfe6b50db8a6f 100644
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
@@ -471,6 +475,11 @@ static void rds_conn_path_destroy(struct rds_conn_path *cp)
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


