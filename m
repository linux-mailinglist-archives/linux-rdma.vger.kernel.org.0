Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482163DF496
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Aug 2021 20:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239143AbhHCSVP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Aug 2021 14:21:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239036AbhHCSVI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Aug 2021 14:21:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 833FE600D4;
        Tue,  3 Aug 2021 18:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628014857;
        bh=A8qs1+EE14Px0g+ZzGtR3QzMOJNW0TSJKYn86SBtNTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C90o+AO++LQ27gGKjvY5kIGOod9uGSEczrVwTpyH09yYJMdQi6ELvwAnEUQ4OA0IT
         7/KNdO1yglkSgi2n7yTIN+HWGiiTZus1fM12F6e1jIHHK5PQttNpGaVGc/GIRXeYG9
         5e6AS3d1h6NMsOIqnwtQGbkU/Aa4m2JK9tPqKbgZBzWHa2uezVvCDTO00wd9W7LEfY
         RMwB0OMs21Vyy3DNz/32u51Pz7ARb8QNMojc/I8+v5plwuXPLva1Sp7JhVfcj4Gp6G
         lWEIkrBqt1aDaFbISAlbDe/tVtDNDJYDEGpg3pSzOCweWxb7JzTX6OoDXCQTmU35tH
         mz8WDlIZmGzyQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markz@mellanox.com>
Subject: [PATCH rdma-next v2 2/7] RDMA/core: Delete duplicated and unreachable code
Date:   Tue,  3 Aug 2021 21:20:33 +0300
Message-Id: <1b4c0d1def5f8f6d26839e14d19da950cc4a0b05.1628014762.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628014762.git.leonro@nvidia.com>
References: <cover.1628014762.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The ib_create_named_qp() is kernel verb and no kernel users exist that
use XRC_INI QP. Hence such QP path is not reachable. In addition, delete
duplicated assignments of QP attributes from the initialization structure.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/core_priv.h |  1 +
 drivers/infiniband/core/verbs.c     | 22 ++++------------------
 2 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index fa2e0bbaf8c7..c870adecd3a4 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -341,6 +341,7 @@ _ib_create_qp(struct ib_device *dev, struct ib_pd *pd,
 	qp->srq = attr->srq;
 	qp->event_handler = attr->event_handler;
 	qp->port = attr->port_num;
+	qp->qp_context = attr->qp_context;
 
 	spin_lock_init(&qp->mr_lock);
 	INIT_LIST_HEAD(&qp->rdma_mrs);
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 89c6987cb5eb..635642a3ecbc 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1257,28 +1257,14 @@ struct ib_qp *ib_create_named_qp(struct ib_pd *pd,
 		return xrc_qp;
 	}
 
-	qp->event_handler = qp_init_attr->event_handler;
-	qp->qp_context = qp_init_attr->qp_context;
-	if (qp_init_attr->qp_type == IB_QPT_XRC_INI) {
-		qp->recv_cq = NULL;
-		qp->srq = NULL;
-	} else {
-		qp->recv_cq = qp_init_attr->recv_cq;
-		if (qp_init_attr->recv_cq)
-			atomic_inc(&qp_init_attr->recv_cq->usecnt);
-		qp->srq = qp_init_attr->srq;
-		if (qp->srq)
-			atomic_inc(&qp_init_attr->srq->usecnt);
-	}
-
-	qp->send_cq = qp_init_attr->send_cq;
-	qp->xrcd    = NULL;
+	if (qp_init_attr->recv_cq)
+		atomic_inc(&qp_init_attr->recv_cq->usecnt);
+	if (qp->srq)
+		atomic_inc(&qp_init_attr->srq->usecnt);
 
 	atomic_inc(&pd->usecnt);
 	if (qp_init_attr->send_cq)
 		atomic_inc(&qp_init_attr->send_cq->usecnt);
-	if (qp_init_attr->rwq_ind_tbl)
-		atomic_inc(&qp->rwq_ind_tbl->usecnt);
 
 	if (qp_init_attr->cap.max_rdma_ctxs) {
 		ret = rdma_rw_init_mrs(qp, qp_init_attr);
-- 
2.31.1

