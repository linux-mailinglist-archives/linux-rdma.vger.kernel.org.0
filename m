Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4D9922C62
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2019 08:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbfETGzS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 May 2019 02:55:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730826AbfETGzR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 May 2019 02:55:17 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A35CF2085A;
        Mon, 20 May 2019 06:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558335316;
        bh=4syLfPyrglRastVJjRrckek9UzvmzJsTagWOGkMQJko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e/lCiEcnH15huJPePMKTvzWt0S0So2UDiuJzn78dGpuT2tPEtaMUxGj2JIg6X9eoS
         DwlJAGF7Anx84r4D/0/1z/oyFd3O/spRLfTEEOqISBtghcHbUFQr+MzqkLSrp0Ogr3
         zJyfYoPQug4lPbl5FcmbbrXWULO4xAvJuWjuul2E=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Glenn Streiff <gstreiff@neteffect.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH rdma-next 12/15] RDMA/cxgb3: Delete and properly mark unimplemented resize CQ function
Date:   Mon, 20 May 2019 09:54:30 +0300
Message-Id: <20190520065433.8734-13-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520065433.8734-1-leon@kernel.org>
References: <20190520065433.8734-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Resize CQ implementation was guarded by undeclared "notyet" define
while cxgb3 was added to the kernel. Twelve years later, this call
is still unimplemented, so safely delete it and fix improper return
error code in case .resize_cq() in not implemented.

Fixes: b038ced7b370 ("RDMA/cxgb3: Add driver for Chelsio T3 RNIC")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/cxgb3/cxio_hal.c      | 14 -----
 drivers/infiniband/hw/cxgb3/cxio_hal.h      |  1 -
 drivers/infiniband/hw/cxgb3/iwch_provider.c | 65 ---------------------
 3 files changed, 80 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb3/cxio_hal.c b/drivers/infiniband/hw/cxgb3/cxio_hal.c
index 69ef63ea72d8..37ee93824349 100644
--- a/drivers/infiniband/hw/cxgb3/cxio_hal.c
+++ b/drivers/infiniband/hw/cxgb3/cxio_hal.c
@@ -187,20 +187,6 @@ int cxio_create_cq(struct cxio_rdev *rdev_p, struct t3_cq *cq, int kernel)
 	return (rdev_p->t3cdev_p->ctl(rdev_p->t3cdev_p, RDMA_CQ_SETUP, &setup));
 }
 
-#ifdef notyet
-int cxio_resize_cq(struct cxio_rdev *rdev_p, struct t3_cq *cq)
-{
-	struct rdma_cq_setup setup;
-	setup.id = cq->cqid;
-	setup.base_addr = (u64) (cq->dma_addr);
-	setup.size = 1UL << cq->size_log2;
-	setup.credits = setup.size;
-	setup.credit_thres = setup.size;	/* TBD: overflow recovery */
-	setup.ovfl_mode = 1;
-	return (rdev_p->t3cdev_p->ctl(rdev_p->t3cdev_p, RDMA_CQ_SETUP, &setup));
-}
-#endif
-
 static u32 get_qpid(struct cxio_rdev *rdev_p, struct cxio_ucontext *uctx)
 {
 	struct cxio_qpid_list *entry;
diff --git a/drivers/infiniband/hw/cxgb3/cxio_hal.h b/drivers/infiniband/hw/cxgb3/cxio_hal.h
index 074932970d1c..40c029ffa425 100644
--- a/drivers/infiniband/hw/cxgb3/cxio_hal.h
+++ b/drivers/infiniband/hw/cxgb3/cxio_hal.h
@@ -159,7 +159,6 @@ int cxio_hal_cq_op(struct cxio_rdev *rdev, struct t3_cq *cq,
 		   enum t3_cq_opcode op, u32 credit);
 int cxio_create_cq(struct cxio_rdev *rdev, struct t3_cq *cq, int kernel);
 void cxio_destroy_cq(struct cxio_rdev *rdev, struct t3_cq *cq);
-int cxio_resize_cq(struct cxio_rdev *rdev, struct t3_cq *cq);
 void cxio_release_ucontext(struct cxio_rdev *rdev, struct cxio_ucontext *uctx);
 void cxio_init_ucontext(struct cxio_rdev *rdev, struct cxio_ucontext *uctx);
 int cxio_create_qp(struct cxio_rdev *rdev, u32 kernel_domain, struct t3_wq *wq,
diff --git a/drivers/infiniband/hw/cxgb3/iwch_provider.c b/drivers/infiniband/hw/cxgb3/iwch_provider.c
index c7c1ee1375e2..168c05b3e9e5 100644
--- a/drivers/infiniband/hw/cxgb3/iwch_provider.c
+++ b/drivers/infiniband/hw/cxgb3/iwch_provider.c
@@ -209,70 +209,6 @@ static struct ib_cq *iwch_create_cq(struct ib_device *ibdev,
 	return &chp->ibcq;
 }
 
-static int iwch_resize_cq(struct ib_cq *cq, int cqe, struct ib_udata *udata)
-{
-#ifdef notyet
-	struct iwch_cq *chp = to_iwch_cq(cq);
-	struct t3_cq oldcq, newcq;
-	int ret;
-
-	pr_debug("%s ib_cq %p cqe %d\n", __func__, cq, cqe);
-
-	/* We don't downsize... */
-	if (cqe <= cq->cqe)
-		return 0;
-
-	/* create new t3_cq with new size */
-	cqe = roundup_pow_of_two(cqe+1);
-	newcq.size_log2 = ilog2(cqe);
-
-	/* Dont allow resize to less than the current wce count */
-	if (cqe < Q_COUNT(chp->cq.rptr, chp->cq.wptr)) {
-		return -ENOMEM;
-	}
-
-	/* Quiesce all QPs using this CQ */
-	ret = iwch_quiesce_qps(chp);
-	if (ret) {
-		return ret;
-	}
-
-	ret = cxio_create_cq(&chp->rhp->rdev, &newcq);
-	if (ret) {
-		return ret;
-	}
-
-	/* copy CQEs */
-	memcpy(newcq.queue, chp->cq.queue, (1 << chp->cq.size_log2) *
-				        sizeof(struct t3_cqe));
-
-	/* old iwch_qp gets new t3_cq but keeps old cqid */
-	oldcq = chp->cq;
-	chp->cq = newcq;
-	chp->cq.cqid = oldcq.cqid;
-
-	/* resize new t3_cq to update the HW context */
-	ret = cxio_resize_cq(&chp->rhp->rdev, &chp->cq);
-	if (ret) {
-		chp->cq = oldcq;
-		return ret;
-	}
-	chp->ibcq.cqe = (1<<chp->cq.size_log2) - 1;
-
-	/* destroy old t3_cq */
-	oldcq.cqid = newcq.cqid;
-	cxio_destroy_cq(&chp->rhp->rdev, &oldcq);
-
-	/* add user hooks here */
-
-	/* resume qps */
-	ret = iwch_resume_qps(chp);
-	return ret;
-#else
-	return -ENOSYS;
-#endif
-}
-
 static int iwch_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags)
 {
 	struct iwch_dev *rhp;
@@ -1335,7 +1271,6 @@ static const struct ib_device_ops iwch_dev_ops = {
 	.query_port = iwch_query_port,
 	.reg_user_mr = iwch_reg_user_mr,
 	.req_notify_cq = iwch_arm_cq,
-	.resize_cq = iwch_resize_cq,
 	INIT_RDMA_OBJ_SIZE(ib_pd, iwch_pd, ibpd),
 	INIT_RDMA_OBJ_SIZE(ib_ucontext, iwch_ucontext, ibucontext),
 };
-- 
2.20.1

