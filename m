Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083B2279847
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Sep 2020 12:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgIZKTw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 26 Sep 2020 06:19:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgIZKTw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 26 Sep 2020 06:19:52 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5047238E2;
        Sat, 26 Sep 2020 10:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601115591;
        bh=bMdFIvyyykWKfMtPATdd3vC2Lj0nbT3EO89EcdB5gy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xx7cUf5a0zpuvVhaD1IPizGzKfIkiUftV0E7W+Ma2xJJM08E3bqtDP+FrmoojpNTk
         dkKl1VEdd8GvfSmv4ouCoUKGkBnopT2FSPaRNz7nk+FYMqYC2mgJgxGIfismjJH4AQ
         yKtDQPbFa3wYR4d7rqYOFx5x45Si4LSgsW5WPD8w=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v3 3/9] RDMA/restrack: Store all special QPs in restrack DB
Date:   Sat, 26 Sep 2020 13:19:32 +0300
Message-Id: <20200926101938.2964394-4-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200926101938.2964394-1-leon@kernel.org>
References: <20200926101938.2964394-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Special QPs (SMI and GSI) have different rules in regards of their QP
numbers. While all other QP numbers are unique per-device, the QP0 and QP1
are created per-port as requested by IBTA.

In multiple port devices, the number of SMI and GSI QPs with be equal
to the number ports.

[leonro@vm ~]$ rdma dev
0: ibp0s9: node_type ca fw 4.4.9999 node_guid 5254:00c0:fe12:3455 sys_image_guid 5254:00c0:fe12:3455
[leonro@vm ~]$ rdma link
0/1: ibp0s9/1: subnet_prefix fe80:0000:0000:0000 lid 13397 sm_lid 49151 lmc 0 state ACTIVE physical_state LINK_UP
0/2: ibp0s9/2: subnet_prefix fe80:0000:0000:0000 lid 13397 sm_lid 49151 lmc 0 state UNKNOWN physical_state UNKNOWN

Before:
[leonro@mtl-leonro-l-vm ~]$ rdma res show qp type SMI,GSI
link ibp0s9/1 lqpn 0 type SMI state RTS sq-psn 0 comm [ib_core]
link ibp0s9/1 lqpn 1 type GSI state RTS sq-psn 0 comm [ib_core]

After:
[leonro@vm ~]$ rdma res show qp type SMI,GSI
link ibp0s9/1 lqpn 0 type SMI state RTS sq-psn 0 comm [ib_core]
link ibp0s9/1 lqpn 1 type GSI state RTS sq-psn 0 comm [ib_core]
link ibp0s9/2 lqpn 0 type SMI state RTS sq-psn 0 comm [ib_core]
link ibp0s9/2 lqpn 1 type GSI state RTS sq-psn 0 comm [ib_core]

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/core_priv.h |  2 ++
 drivers/infiniband/core/restrack.c  | 11 +++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index e84b0fedaacb..7c4752c47f80 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -347,6 +347,8 @@ static inline struct ib_qp *_ib_create_qp(struct ib_device *dev,
 	qp->srq = attr->srq;
 	qp->rwq_ind_tbl = attr->rwq_ind_tbl;
 	qp->event_handler = attr->event_handler;
+	qp->qp_type = attr->qp_type;
+	qp->port = attr->port_num;
 
 	atomic_set(&qp->usecnt, 0);
 	spin_lock_init(&qp->mr_lock);
diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
index e26a3213f500..e0a41c867002 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -235,8 +235,15 @@ void rdma_restrack_add(struct rdma_restrack_entry *res)
 		/* Special case to ensure that LQPN points to right QP */
 		struct ib_qp *qp = container_of(res, struct ib_qp, res);
 
-		ret = xa_insert(&rt->xa, qp->qp_num, res, GFP_KERNEL);
-		res->id = ret ? 0 : qp->qp_num;
+		WARN_ONCE(qp->qp_num >> 24 || qp->port >> 8,
+			  "QP number 0x%0X and port 0x%0X", qp->qp_num,
+			  qp->port);
+		res->id = qp->qp_num;
+		if (qp->qp_type == IB_QPT_SMI || qp->qp_type == IB_QPT_GSI)
+			res->id |= qp->port << 24;
+		ret = xa_insert(&rt->xa, res->id, res, GFP_KERNEL);
+		if (ret)
+			res->id = 0;
 	} else if (res->type == RDMA_RESTRACK_COUNTER) {
 		/* Special case to ensure that cntn points to right counter */
 		struct rdma_counter *counter;
-- 
2.26.2

