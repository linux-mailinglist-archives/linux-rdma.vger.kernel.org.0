Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8035222C60
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2019 08:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbfETGzN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 May 2019 02:55:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730826AbfETGzN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 May 2019 02:55:13 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A9F520815;
        Mon, 20 May 2019 06:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558335312;
        bh=Ea8uYp4MqwMqSHvj5D3p/n+HPENfX033cl9bmhrVHsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QYT+LwVLB8J3OFNLlc+0s1uiilmNSTESqDw0RQghfN6Pk6APpqxAH2DvSoRJL1xk/
         FlLUfJ99Bt0ef9300WoCNSA074WXyc6p1zvIFjiiCDqnOIkbaR4gz05nFrBO8F4Koe
         lEPO/K6G5gL/4drsaNdbGS3xusFa5ZC8w7Kj75hc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Glenn Streiff <gstreiff@neteffect.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH rdma-next 11/15] RDMA/cxgb3: Don't expose DMA addresses
Date:   Mon, 20 May 2019 09:54:29 +0300
Message-Id: <20190520065433.8734-12-leon@kernel.org>
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

DMA addresses like all other kernel addresses should be printed with
special %p* formatter. It is needed to allow control of exposure of
such information through dedicated knob.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/cxgb3/cxio_hal.c      |  6 +++---
 drivers/infiniband/hw/cxgb3/iwch_provider.c | 14 +++++++-------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb3/cxio_hal.c b/drivers/infiniband/hw/cxgb3/cxio_hal.c
index 90c0d2db5177..69ef63ea72d8 100644
--- a/drivers/infiniband/hw/cxgb3/cxio_hal.c
+++ b/drivers/infiniband/hw/cxgb3/cxio_hal.c
@@ -563,9 +563,9 @@ static int cxio_hal_init_ctrl_qp(struct cxio_rdev *rdev_p)
 	wqe->sge_cmd = cpu_to_be64(sge_cmd);
 	wqe->ctx1 = cpu_to_be64(ctx1);
 	wqe->ctx0 = cpu_to_be64(ctx0);
-	pr_debug("CtrlQP dma_addr 0x%llx workq %p size %d\n",
-		 (unsigned long long)rdev_p->ctrl_qp.dma_addr,
-		 rdev_p->ctrl_qp.workq, 1 << T3_CTRL_QP_SIZE_LOG2);
+	pr_debug("CtrlQP dma_addr %pad workq %p size %d\n",
+		 &rdev_p->ctrl_qp.dma_addr, rdev_p->ctrl_qp.workq,
+		 1 << T3_CTRL_QP_SIZE_LOG2);
 	skb->priority = CPL_PRIORITY_CONTROL;
 	return iwch_cxgb3_ofld_send(rdev_p->t3cdev_p, skb);
 err:
diff --git a/drivers/infiniband/hw/cxgb3/iwch_provider.c b/drivers/infiniband/hw/cxgb3/iwch_provider.c
index be8b329b4cb8..c7c1ee1375e2 100644
--- a/drivers/infiniband/hw/cxgb3/iwch_provider.c
+++ b/drivers/infiniband/hw/cxgb3/iwch_provider.c
@@ -204,9 +204,8 @@ static struct ib_cq *iwch_create_cq(struct ib_device *ibdev,
 		}
 		insert_mmap(ucontext, mm);
 	}
-	pr_debug("created cqid 0x%0x chp %p size 0x%0x, dma_addr 0x%0llx\n",
-		 chp->cq.cqid, chp, (1 << chp->cq.size_log2),
-		 (unsigned long long)chp->cq.dma_addr);
+	pr_debug("created cqid 0x%0x chp %p size 0x%0x, dma_addr %pad\n",
+		 chp->cq.cqid, chp, (1 << chp->cq.size_log2), &chp->cq.dma_addr);
 	return &chp->ibcq;
 }
 
@@ -915,10 +914,11 @@ static struct ib_qp *iwch_create_qp(struct ib_pd *pd,
 		insert_mmap(ucontext, mm2);
 	}
 	qhp->ibqp.qp_num = qhp->wq.qpid;
-	pr_debug("%s sq_num_entries %d, rq_num_entries %d qpid 0x%0x qhp %p dma_addr 0x%llx size %d rq_addr 0x%x\n",
-		 __func__, qhp->attr.sq_num_entries, qhp->attr.rq_num_entries,
-		 qhp->wq.qpid, qhp, (unsigned long long)qhp->wq.dma_addr,
-		 1 << qhp->wq.size_log2, qhp->wq.rq_addr);
+	pr_debug(
+		"%s sq_num_entries %d, rq_num_entries %d qpid 0x%0x qhp %p dma_addr %pad size %d rq_addr 0x%x\n",
+		__func__, qhp->attr.sq_num_entries, qhp->attr.rq_num_entries,
+		qhp->wq.qpid, qhp, &qhp->wq.dma_addr, 1 << qhp->wq.size_log2,
+		qhp->wq.rq_addr);
 	return &qhp->ibqp;
 }
 
-- 
2.20.1

