Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A068A3CC8F8
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Jul 2021 14:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbhGRME1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Jul 2021 08:04:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233610AbhGRMEW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 18 Jul 2021 08:04:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2B7B610D1;
        Sun, 18 Jul 2021 12:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626609684;
        bh=1T2Lt3llebp8CxVs54EHp5DqZdBD5AMfGku58BYeKo0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q7b7uYt34XGEG9ScFw7J3gIUYp1731YJZyO0nT21bAkc72DdrpZZW2f84NKR1jVFR
         PXHFp3a198lCzn9rkbuWSK/E9ewYoWJAxTPGcLiOjFQA2ELW1T//mhQ2vjDcD25QX4
         Rp6xY53K/usdHlB9AW8ln+bFuR8403XSbx+cxyNu6vRsnB8edkilEtIpolpNVEZb4K
         JCh7E3NShuzS4kLnvteFuk1FPwNCACQ+GwRtFwbOGD8bmpOd5ijZqJyXR2B+3iu4iB
         spKcyQaX3qXWi1PoTWdkPkFkLtUlVRXi6c+GFRQ6E3usS+ViWwxbCLinZEBideUPhW
         dKVQ4qi/f3fMg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Gal Pressman <galpress@amazon.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Steve Wise <larrystevenwise@gmail.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        Wenpeng Liang <liangwenpeng@huawei.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-next 7/9] RDMA/rdmavt: Decouple QP and SGE lists allocations
Date:   Sun, 18 Jul 2021 15:00:57 +0300
Message-Id: <9769d1288bb1b132ad33c6dcff648b91a6bb1d2a.1626609283.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626609283.git.leonro@nvidia.com>
References: <cover.1626609283.git.leonro@nvidia.com>
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
 drivers/infiniband/sw/rdmavt/qp.c | 13 ++++++++-----
 include/rdma/rdmavt_qp.h          |  2 +-
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index e9f3d356b361..14900860985c 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -1078,7 +1078,7 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
 	int err;
 	struct rvt_swqe *swq = NULL;
 	size_t sz;
-	size_t sg_list_sz;
+	size_t sg_list_sz = 0;
 	struct ib_qp *ret = ERR_PTR(-ENOMEM);
 	struct rvt_dev_info *rdi = ib_to_rvt(ibpd->device);
 	void *priv = NULL;
@@ -1126,8 +1126,6 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
 		if (!swq)
 			return ERR_PTR(-ENOMEM);
 
-		sz = sizeof(*qp);
-		sg_list_sz = 0;
 		if (init_attr->srq) {
 			struct rvt_srq *srq = ibsrq_to_rvtsrq(init_attr->srq);
 
@@ -1137,10 +1135,13 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
 		} else if (init_attr->cap.max_recv_sge > 1)
 			sg_list_sz = sizeof(*qp->r_sg_list) *
 				(init_attr->cap.max_recv_sge - 1);
-		qp = kzalloc_node(sz + sg_list_sz, GFP_KERNEL,
-				  rdi->dparms.node);
+		qp = kzalloc_node(sizeof(*qp), GFP_KERNEL, rdi->dparms.node);
 		if (!qp)
 			goto bail_swq;
+		qp->r_sg_list =
+			kzalloc_node(sg_list_sz, GFP_KERNEL, rdi->dparms.node);
+		if (!qp->r_sg_list)
+			goto bail_qp;
 		qp->allowed_ops = get_allowed_ops(init_attr->qp_type);
 
 		RCU_INIT_POINTER(qp->next, NULL);
@@ -1328,6 +1329,7 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
 
 bail_qp:
 	kfree(qp->s_ack_queue);
+	kfree(qp->r_sg_list);
 	kfree(qp);
 
 bail_swq:
@@ -1762,6 +1764,7 @@ int rvt_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
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

