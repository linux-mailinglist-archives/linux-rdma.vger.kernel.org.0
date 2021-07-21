Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E491E3D0BCB
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jul 2021 12:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235290AbhGUIlo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jul 2021 04:41:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235639AbhGUI0z (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Jul 2021 04:26:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EEF156120A;
        Wed, 21 Jul 2021 09:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626858452;
        bh=CEJyO9Yy4FU8TKYwWIP+VJYoiy0mqOrVsLitic27HE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HKuytsVcsjFrYCOqDzC4ZXEtPz6apdzNdEMD8vpK7ElSsMFuqVMAIxBvu4Ed9pSNj
         JEXUNFqsJDO/erOTTPLpKb2BakayZH/EPoZ7+jT1yslZNDpbvHrElM5IbRx1NNFqN7
         w6JcMSHOm4tbs4NU/47squxnz1SLOaOr62TqRam7CPEsULy5/kT/miDiv4OaFhpspU
         r3r+eT2RA2vu10kIGWkLRQFmm2SV0WONbZwSMctUPT5d8SkWRq/I0h6XBiRI2E1n21
         xCAjSJ5L0XWxoqHeoMG6os/mObZASqXvwUL6QWQ4LSmCbRLn5R934EB2pd8jAafyqm
         Jm8QpnF8rF4vw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markz@mellanox.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH rdma-next v1 2/7] RDMA/core: Delete duplicated and unreachable code
Date:   Wed, 21 Jul 2021 12:07:05 +0300
Message-Id: <ade67ecead1398594dc4129b32f6884387f080f1.1626857976.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626857976.git.leonro@nvidia.com>
References: <cover.1626857976.git.leonro@nvidia.com>
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
index 5dfa1190e3ea..cc54d74930d6 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -342,6 +342,7 @@ _ib_create_qp(struct ib_device *dev, struct ib_pd *pd,
 	qp->rwq_ind_tbl = attr->rwq_ind_tbl;
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

