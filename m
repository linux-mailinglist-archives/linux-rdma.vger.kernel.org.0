Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78C2922C5A
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2019 08:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730823AbfETGyw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 May 2019 02:54:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfETGyw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 May 2019 02:54:52 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9177B20815;
        Mon, 20 May 2019 06:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558335292;
        bh=V7OWthnbqm4xP6GESeCMH5VWjyWmMJy0FY4LfcCtjUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EXt/u3hG2mJYCvHfUCPagWOn/9mJo+gMlhN69Ap+HuO2ecQ6RnbvGoWUAR1ixRAKQ
         qpso+rnATW7YPUAatSyEH+aKfscVsxOTEodDTE+WPddF7BjHr2oF/cO6D9ddoJvL2e
         JZWBkUBRPHBt4sD2spITiFVtzhxdnPgPjwpMx+TU=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Gal Pressman <galpress@amazon.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Glenn Streiff <gstreiff@neteffect.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH rdma-next 04/15] RDMA/efa: Remove check that prevents destroy of resources in error flows
Date:   Mon, 20 May 2019 09:54:22 +0300
Message-Id: <20190520065433.8734-5-leon@kernel.org>
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

There are two possible execution contexts of destroy flows in EFA.
One is normal flow where user explicitly asked for object release
and another error unwinding.

In normal scenario, RDMA/core will ensure that udata is supplied
according to KABI contract, for now it means no udata at all.

In unwind flow, the EFA driver will receive uncleared udata from
numerous *_create_*() calls, but won't release those resources
due to extra checks.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 6d6886c9009f..4999a74cee24 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -436,12 +436,6 @@ void efa_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	struct efa_dev *dev = to_edev(ibpd->device);
 	struct efa_pd *pd = to_epd(ibpd);

-	if (udata->inlen &&
-	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
-		ibdev_dbg(&dev->ibdev, "Incompatible ABI params\n");
-		return;
-	}
-
 	ibdev_dbg(&dev->ibdev, "Dealloc pd[%d]\n", pd->pdn);
 	efa_pd_dealloc(dev, pd->pdn);
 }
@@ -459,12 +453,6 @@ int efa_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	struct efa_qp *qp = to_eqp(ibqp);
 	int err;

-	if (udata->inlen &&
-	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
-		ibdev_dbg(&dev->ibdev, "Incompatible ABI params\n");
-		return -EINVAL;
-	}
-
 	ibdev_dbg(&dev->ibdev, "Destroy qp[%u]\n", ibqp->qp_num);
 	err = efa_destroy_qp_handle(dev, qp->qp_handle);
 	if (err)
@@ -865,12 +853,6 @@ int efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 	struct efa_cq *cq = to_ecq(ibcq);
 	int err;

-	if (udata->inlen &&
-	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
-		ibdev_dbg(&dev->ibdev, "Incompatible ABI params\n");
-		return -EINVAL;
-	}
-
 	ibdev_dbg(&dev->ibdev,
 		  "Destroy cq[%d] virt[0x%p] freed: size[%lu], dma[%pad]\n",
 		  cq->cq_idx, cq->cpu_addr, cq->size, &cq->dma_addr);
@@ -1556,12 +1538,6 @@ int efa_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	struct efa_mr *mr = to_emr(ibmr);
 	int err;

-	if (udata->inlen &&
-	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
-		ibdev_dbg(&dev->ibdev, "Incompatible ABI params\n");
-		return -EINVAL;
-	}
-
 	ibdev_dbg(&dev->ibdev, "Deregister mr[%d]\n", ibmr->lkey);

 	if (mr->umem) {
--
2.20.1

