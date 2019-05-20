Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9AC22C64
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2019 08:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730833AbfETGzY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 May 2019 02:55:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730826AbfETGzX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 May 2019 02:55:23 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BECD0208CA;
        Mon, 20 May 2019 06:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558335323;
        bh=6xqxPkg0NI0+0H/kEWyVGBs4AMWLlFABa69c5rMpNuU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CTdjDVuwlMM1S/hPMqHams4LKcL2DKLcxGWwP/nUbHG9ril/jnRyCsghzEkerly1f
         n5kFD9MQojUblAnK9FaeLISCvC89KrnLeRTP+jBLKGHb6B2ZoxmwjdRrPDkNOk169S
         hay5y3SpjKBFLKyBfD3jJdCeJygsRxJLwtL9kRlM=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Glenn Streiff <gstreiff@neteffect.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH rdma-next 14/15] RDMA/cxgb4: Don't expose DMA addresses
Date:   Mon, 20 May 2019 09:54:32 +0300
Message-Id: <20190520065433.8734-15-leon@kernel.org>
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

Change unconditional print of DMA address to be printed
with special printk format type specifier.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/cxgb4/cq.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/cq.c b/drivers/infiniband/hw/cxgb4/cq.c
index ea4a263e5a58..2319d0f983b0 100644
--- a/drivers/infiniband/hw/cxgb4/cq.c
+++ b/drivers/infiniband/hw/cxgb4/cq.c
@@ -1082,6 +1082,7 @@ struct ib_cq *c4iw_create_cq(struct ib_device *ibdev,
 	chp->rhp = rhp;
 	chp->cq.size--;				/* status page */
 	chp->ibcq.cqe = entries - 2;
+
 	spin_lock_init(&chp->lock);
 	spin_lock_init(&chp->comp_handler_lock);
 	atomic_set(&chp->refcnt, 1);
@@ -1132,9 +1133,9 @@ struct ib_cq *c4iw_create_cq(struct ib_device *ibdev,
 		mm2->len = PAGE_SIZE;
 		insert_mmap(ucontext, mm2);
 	}
-	pr_debug("cqid 0x%0x chp %p size %u memsize %zu, dma_addr 0x%0llx\n",
-		 chp->cq.cqid, chp, chp->cq.size,
-		 chp->cq.memsize, (unsigned long long)chp->cq.dma_addr);
+	pr_debug("cqid 0x%0x chp %p size %u memsize %zu, dma_addr %pad\n",
+		 chp->cq.cqid, chp, chp->cq.size, chp->cq.memsize,
+		 &chp->cq.dma_addr);
 	return &chp->ibcq;
 err_free_mm2:
 	kfree(mm2);
-- 
2.20.1

