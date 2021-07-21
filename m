Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAB23D08A0
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jul 2021 08:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbhGUFcn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jul 2021 01:32:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232468AbhGUFci (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Jul 2021 01:32:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9DF7600EF;
        Wed, 21 Jul 2021 06:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626847995;
        bh=CEJyO9Yy4FU8TKYwWIP+VJYoiy0mqOrVsLitic27HE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=inLjeueoNXyZHCu9I4uoFEeQVHpoaFukdalnk7nln8JKApw0x5xZlG6oUjsWO+9tr
         PcuQNP6P3RfC5o1VYNfH1a/KZpwOrJjXG7gMXBrzdST+a3NrU1DdbSSlmnNjp6j8DM
         cfWGK7YXDcWGlbV90U7seijAdYhBRCjixfO/UUAEiOD3NFw2+CUcTP+Fo8yuN4wkK/
         Nqb+yJNmuCYbt+CSocf2LvuD6+1eoNNIX8JyTNLVAKbqZR+hmVSu3Ych6TAEJZtCWU
         wpToQXy6ii+s4R0mXanURGkKcPk6sdlJRM7h/dD0+NQS3wVoExI2oVlejXcrdnL2ZE
         3gNwRedIuCTqA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markz@mellanox.com>
Subject: [PATCH rdma-next 2/7] RDMA/core: Delete duplicated and unreachable code
Date:   Wed, 21 Jul 2021 09:13:01 +0300
Message-Id: <5f65e3382a54cf2143b8a9ea38998e82ec14475c.1626846795.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626846795.git.leonro@nvidia.com>
References: <cover.1626846795.git.leonro@nvidia.com>
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

