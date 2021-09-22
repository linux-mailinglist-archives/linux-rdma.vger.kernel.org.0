Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F552414B08
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Sep 2021 15:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbhIVNuv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Sep 2021 09:50:51 -0400
Received: from smtp181.sjtu.edu.cn ([202.120.2.181]:53874 "EHLO
        smtp181.sjtu.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbhIVNuu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Sep 2021 09:50:50 -0400
Received: from proxy02.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
        by smtp181.sjtu.edu.cn (Postfix) with ESMTPS id 7113C1008CBC0;
        Wed, 22 Sep 2021 21:49:16 +0800 (CST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by proxy02.sjtu.edu.cn (Postfix) with ESMTP id 4ED9C200B574F;
        Wed, 22 Sep 2021 21:49:16 +0800 (CST)
X-Virus-Scanned: amavisd-new at 
Received: from proxy02.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy02.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nGkeTN7hz__Y; Wed, 22 Sep 2021 21:49:16 +0800 (CST)
Received: from guozhi-ipads.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
        (Authenticated sender: qtxuning1999@sjtu.edu.cn)
        by proxy02.sjtu.edu.cn (Postfix) with ESMTPSA id 3BE1A200B5750;
        Wed, 22 Sep 2021 21:49:01 +0800 (CST)
From:   Guo Zhi <qtxuning1999@sjtu.edu.cn>
To:     mike.marciniszyn@cornelisnetworks.com,
        dennis.dalessandro@cornelisnetworks.com, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guo Zhi <qtxuning1999@sjtu.edu.cn>
Subject: [PATCH] infiniband hfi1: fix misuse of %x in ipoib_tx.c
Date:   Wed, 22 Sep 2021 21:48:57 +0800
Message-Id: <20210922134857.619602-1-qtxuning1999@sjtu.edu.cn>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Pointers should be printed with %p or %px rather than
cast to (unsigned long long) and printed with %llx.
Change %llx to %p to print the pointer.

Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
---
 drivers/infiniband/hw/hfi1/ipoib_tx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/ipoib_tx.c b/drivers/infiniband/hw/hfi1/ipoib_tx.c
index e74ddbe4658..15b0cb0f363 100644
--- a/drivers/infiniband/hw/hfi1/ipoib_tx.c
+++ b/drivers/infiniband/hw/hfi1/ipoib_tx.c
@@ -876,14 +876,14 @@ void hfi1_ipoib_tx_timeout(struct net_device *dev, unsigned int q)
 	struct hfi1_ipoib_txq *txq = &priv->txqs[q];
 	u64 completed = atomic64_read(&txq->complete_txreqs);
 
-	dd_dev_info(priv->dd, "timeout txq %llx q %u stopped %u stops %d no_desc %d ring_full %d\n",
-		    (unsigned long long)txq, q,
+	dd_dev_info(priv->dd, "timeout txq %p q %u stopped %u stops %d no_desc %d ring_full %d\n",
+		    txq, q,
 		    __netif_subqueue_stopped(dev, txq->q_idx),
 		    atomic_read(&txq->stops),
 		    atomic_read(&txq->no_desc),
 		    atomic_read(&txq->ring_full));
-	dd_dev_info(priv->dd, "sde %llx engine %u\n",
-		    (unsigned long long)txq->sde,
+	dd_dev_info(priv->dd, "sde %p engine %u\n",
+		    txq->sde,
 		    txq->sde ? txq->sde->this_idx : 0);
 	dd_dev_info(priv->dd, "flow %x\n", txq->flow.as_int);
 	dd_dev_info(priv->dd, "sent %llu completed %llu used %llu\n",
-- 
2.33.0

