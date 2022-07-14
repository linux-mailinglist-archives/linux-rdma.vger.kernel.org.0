Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C375C5744F7
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Jul 2022 08:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbiGNGPi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Jul 2022 02:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiGNGPh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Jul 2022 02:15:37 -0400
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8854122532;
        Wed, 13 Jul 2022 23:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=mzTq4
        k3RFbV4JfE/JzliP1pvt1svDx3HGsgwfN7XyH0=; b=cRAfla81ldZRBhBfGEX77
        DO2qbBdF4YYqfW55G2oc0d4knZTEBw8d53J8u9fujRXIPZe7xVTCeWNpXFJSmNE5
        WuDESlpgBbVbKlqeBPHS+0OwYuU+LHq3tfOCmnfowOc7aFEtMTo2XV6BYkWuFZYX
        TttXfHYBKFnxtd5qlKULvE=
Received: from localhost.localdomain (unknown [123.112.69.106])
        by smtp4 (Coremail) with SMTP id HNxpCgCnxs5qtM9ivPnrOQ--.60480S4;
        Thu, 14 Jul 2022 14:15:17 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     mkalderon@marvell.com, aelior@marvell.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] RDMA/qedr: Fix potential memory leak in __qedr_alloc_mr()
Date:   Thu, 14 Jul 2022 14:15:05 +0800
Message-Id: <20220714061505.2342759-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgCnxs5qtM9ivPnrOQ--.60480S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr1fuFyxKryrGFWrKF47CFg_yoW8WFWDpF
        43Gr90vr45Xa1DWwn8Awn7ZFWfCa18Ka909r9Fv3savas8try09F18K347ZrykJFZ5Gr4f
        Zr18Aw45CF409rJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRDCz_UUUUU=
X-Originating-IP: [123.112.69.106]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiPhU+jFxBtQusqQAAs-
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

__qedr_alloc_mr() allocates a memory chunk for "mr->info.pbl_table" with
init_mr_info(). When rdma_alloc_tid() and rdma_register_tid() fail, "mr"
is released while "mr->info.pbl_table" is not released, which will lead
to a memory leak.

We should release the "mr->info.pbl_table" with qedr_free_pbl() when error
occurs to fix the memory leak.

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 drivers/infiniband/hw/qedr/verbs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 03ed7c0fae50..d745ce9dc88a 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -3084,7 +3084,7 @@ static struct qedr_mr *__qedr_alloc_mr(struct ib_pd *ibpd,
 		else
 			DP_ERR(dev, "roce alloc tid returned error %d\n", rc);
 
-		goto err0;
+		goto err1;
 	}
 
 	/* Index only, 18 bit long, lkey = itid << 8 | key */
@@ -3108,7 +3108,7 @@ static struct qedr_mr *__qedr_alloc_mr(struct ib_pd *ibpd,
 	rc = dev->ops->rdma_register_tid(dev->rdma_ctx, &mr->hw_mr);
 	if (rc) {
 		DP_ERR(dev, "roce register tid returned an error %d\n", rc);
-		goto err1;
+		goto err2;
 	}
 
 	mr->ibmr.lkey = mr->hw_mr.itid << 8 | mr->hw_mr.key;
@@ -3117,8 +3117,10 @@ static struct qedr_mr *__qedr_alloc_mr(struct ib_pd *ibpd,
 	DP_DEBUG(dev, QEDR_MSG_MR, "alloc frmr: %x\n", mr->ibmr.lkey);
 	return mr;
 
-err1:
+err2:
 	dev->ops->rdma_free_tid(dev->rdma_ctx, mr->hw_mr.itid);
+err1:
+	qedr_free_pbl(dev, &mr->info.pbl_info, mr->info.pbl_table);
 err0:
 	kfree(mr);
 	return ERR_PTR(rc);
-- 
2.25.1

