Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1067E37A4AE
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 12:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhEKKhs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 06:37:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229892AbhEKKhs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 06:37:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59523615FF;
        Tue, 11 May 2021 10:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620729402;
        bh=iCwCQzeBxnPwWxyhinRtYJkB1sfSkl6qO8qDvw0ZQO8=;
        h=From:To:Cc:Subject:Date:From;
        b=XnhL6csMuWFtiWEWUZ4vgXc6NU3TJTkXcKQbgyaFonBegnJxgzy78BcxKJulMxl1f
         qL/AgUDGdDKpohj+/r7atMB/VhqaaNTCBu5k53DiBW99xXYiWnyoXUKtmDpYZChwmB
         I1u4kU+j8x2owZrSYWpLDX4ooOOCokiPnCKVy99Iv6DFH8zcVY/BKL4dxvKLz1Ghy8
         pkZ3LI+h0U6O+CxSffp3O3IG8vB8aiHV6kMf1yIux2+kOiuKV+5NlDT5buDTPUOpCw
         PafDBow0rVVionHo72Ty2UqbLuh09oEBKW2RYbY9y+CnnPusUaOJI7zp6xZZgEsZvJ
         G5FZ+RwYA7SdQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Subject: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists allocations
Date:   Tue, 11 May 2021 13:36:36 +0300
Message-Id: <c34a864803f9bbd33d3f856a6ba2dd595ab708a7.1620729033.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The rdmavt QP has fields that are both needed for the control and data
path. Such mixed declaration caused to the very specific allocation flow
with kzalloc_node and SGE list embedded into the struct rvt_qp.

This patch separates QP creation to two: regular memory allocation for
the control path and specific code for the SGE list, while the access to
the later is performed through derefenced pointer.

Such pointer and its context are expected to be in the cache, so
performance difference is expected to be negligible, if any exists.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Hi,

This change is needed to convert QP to core allocation scheme. In that
scheme QP is allocated outside of the driver and size of such allocation
is constant and can be calculated at the compile time.

Thanks
---
 drivers/infiniband/sw/rdmavt/qp.c | 13 ++++++++-----
 include/rdma/rdmavt_qp.h          |  2 +-
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index 9d13db68283c..4522071fc220 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -1077,7 +1077,7 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
 	int err;
 	struct rvt_swqe *swq = NULL;
 	size_t sz;
-	size_t sg_list_sz;
+	size_t sg_list_sz = 0;
 	struct ib_qp *ret = ERR_PTR(-ENOMEM);
 	struct rvt_dev_info *rdi = ib_to_rvt(ibpd->device);
 	void *priv = NULL;
@@ -1125,8 +1125,6 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
 		if (!swq)
 			return ERR_PTR(-ENOMEM);
 
-		sz = sizeof(*qp);
-		sg_list_sz = 0;
 		if (init_attr->srq) {
 			struct rvt_srq *srq = ibsrq_to_rvtsrq(init_attr->srq);
 
@@ -1136,10 +1134,13 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
 		} else if (init_attr->cap.max_recv_sge > 1)
 			sg_list_sz = sizeof(*qp->r_sg_list) *
 				(init_attr->cap.max_recv_sge - 1);
-		qp = kzalloc_node(sz + sg_list_sz, GFP_KERNEL,
-				  rdi->dparms.node);
+		qp = kzalloc(sizeof(*qp), GFP_KERNEL);
 		if (!qp)
 			goto bail_swq;
+		qp->r_sg_list =
+			kzalloc_node(sg_list_sz, GFP_KERNEL, rdi->dparms.node);
+		if (!qp->r_sg_list)
+			goto bail_qp;
 		qp->allowed_ops = get_allowed_ops(init_attr->qp_type);
 
 		RCU_INIT_POINTER(qp->next, NULL);
@@ -1327,6 +1328,7 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
 
 bail_qp:
 	kfree(qp->s_ack_queue);
+	kfree(qp->r_sg_list);
 	kfree(qp);
 
 bail_swq:
@@ -1761,6 +1763,7 @@ int rvt_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	kvfree(qp->r_rq.kwq);
 	rdi->driver_f.qp_priv_free(rdi, qp);
 	kfree(qp->s_ack_queue);
+	kfree(qp->r_sg_list);
 	rdma_destroy_ah_attr(&qp->remote_ah_attr);
 	rdma_destroy_ah_attr(&qp->alt_ah_attr);
 	free_ud_wq_attr(qp);
diff --git a/include/rdma/rdmavt_qp.h b/include/rdma/rdmavt_qp.h
index 8275954f5ce6..2e58d5e6ac0e 100644
--- a/include/rdma/rdmavt_qp.h
+++ b/include/rdma/rdmavt_qp.h
@@ -444,7 +444,7 @@ struct rvt_qp {
 	/*
 	 * This sge list MUST be last. Do not add anything below here.
 	 */
-	struct rvt_sge r_sg_list[] /* verified SGEs */
+	struct rvt_sge *r_sg_list /* verified SGEs */
 		____cacheline_aligned_in_smp;
 };
 
-- 
2.31.1

