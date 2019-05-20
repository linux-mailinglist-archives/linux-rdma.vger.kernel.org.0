Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAD3D22C5D
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2019 08:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbfETGzD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 May 2019 02:55:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:39054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730827AbfETGzD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 May 2019 02:55:03 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7AB02081C;
        Mon, 20 May 2019 06:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558335302;
        bh=6mhAaiZq/nIBoo5K/isROKuzfqtcVobJSltjdQGLXhE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bGL51v4wjDRtPW5w0I+GczjQbyDpX6HLzMo9CnD8n/9URUDxQtS4B2hX+qFPhTcdY
         N4zJF4drff7yMDHFHh+QO/ROb1mTl23Z72UYJHAwiWzQAGHAbAwodjC8ilE99LWxFC
         3M04yCZLaAoU0UTm4TlLLBPK4zed73mOFzLWnuT8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Glenn Streiff <gstreiff@neteffect.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH rdma-next 08/15] RDMA/nes: Avoid memory allocation during CQ destroy
Date:   Mon, 20 May 2019 09:54:26 +0300
Message-Id: <20190520065433.8734-9-leon@kernel.org>
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

The memory allocation call can fail and cause to early return
from nes_desotroy_cq() function. This situation will cause to
memory leak of struct nes_cq. Rewrite function to avoid memory
allocation.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/nes/nes_verbs.c | 28 +++++++++++----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/hw/nes/nes_verbs.c b/drivers/infiniband/hw/nes/nes_verbs.c
index fb2d0762c7c8..7ad90665b623 100644
--- a/drivers/infiniband/hw/nes/nes_verbs.c
+++ b/drivers/infiniband/hw/nes/nes_verbs.c
@@ -1641,7 +1641,7 @@ static int nes_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	struct nes_vnic *nesvnic;
 	struct nes_adapter *nesadapter;
 	struct nes_hw_cqp_wqe *cqp_wqe;
-	struct nes_cqp_request *cqp_request;
+	struct nes_cqp_request cqp_request = {};
 	unsigned long flags;
 	u32 opcode = 0;
 	int ret;
@@ -1654,13 +1654,10 @@ static int nes_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	nes_debug(NES_DBG_CQ, "Destroy CQ%u\n", nescq->hw_cq.cq_number);
 
 	/* Send DestroyCQ request to CQP */
-	cqp_request = nes_get_cqp_request(nesdev);
-	if (cqp_request == NULL) {
-		nes_debug(NES_DBG_CQ, "Failed to get a cqp_request.\n");
-		return -ENOMEM;
-	}
-	cqp_request->waiting = 1;
-	cqp_wqe = &cqp_request->cqp_wqe;
+	INIT_LIST_HEAD(&cqp_request.list);
+	init_waitqueue_head(&cqp_request.waitq);
+	cqp_request.waiting = 1;
+	cqp_wqe = &cqp_request.cqp_wqe;
 	opcode = NES_CQP_DESTROY_CQ | (nescq->hw_cq.cq_size << 16);
 	spin_lock_irqsave(&nesadapter->pbl_lock, flags);
 	if (nescq->virtual_cq == 1) {
@@ -1687,30 +1684,28 @@ static int nes_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	if (!nescq->mcrqf)
 		nes_free_resource(nesadapter, nesadapter->allocated_cqs, nescq->hw_cq.cq_number);
 
-	atomic_set(&cqp_request->refcount, 2);
-	nes_post_cqp_request(nesdev, cqp_request);
+	nes_post_cqp_request(nesdev, &cqp_request);
 
 	/* Wait for CQP */
 	nes_debug(NES_DBG_CQ, "Waiting for destroy iWARP CQ%u to complete.\n",
 			nescq->hw_cq.cq_number);
-	ret = wait_event_timeout(cqp_request->waitq, (0 != cqp_request->request_done),
-			NES_EVENT_TIMEOUT);
+	ret = wait_event_timeout(cqp_request.waitq, cqp_request.request_done,
+				 NES_EVENT_TIMEOUT);
 	nes_debug(NES_DBG_CQ, "Destroy iWARP CQ%u completed, wait_event_timeout ret = %u,"
 			" CQP Major:Minor codes = 0x%04X:0x%04X.\n",
-			nescq->hw_cq.cq_number, ret, cqp_request->major_code,
-			cqp_request->minor_code);
+			nescq->hw_cq.cq_number, ret, cqp_request.major_code,
+			cqp_request.minor_code);
 	if (!ret) {
 		nes_debug(NES_DBG_CQ, "iWARP CQ%u destroy timeout expired\n",
 					nescq->hw_cq.cq_number);
 		ret = -ETIME;
-	} else if (cqp_request->major_code) {
+	} else if (cqp_request.major_code) {
 		nes_debug(NES_DBG_CQ, "iWARP CQ%u destroy failed\n",
 					nescq->hw_cq.cq_number);
 		ret = -EIO;
 	} else {
 		ret = 0;
 	}
-	nes_put_cqp_request(nesdev, cqp_request);
 
 	if (nescq->cq_mem_size)
 		pci_free_consistent(nesdev->pcidev, nescq->cq_mem_size,
@@ -1899,7 +1894,6 @@ static int nes_reg_mr(struct nes_device *nesdev, struct nes_pd *nespd,
 	}
 	barrier();
 
-	atomic_set(&cqp_request->refcount, 2);
 	nes_post_cqp_request(nesdev, cqp_request);
 
 	/* Wait for CQP */
-- 
2.20.1

