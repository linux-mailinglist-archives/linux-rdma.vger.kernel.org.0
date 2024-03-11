Return-Path: <linux-rdma+bounces-1384-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9AD877F2E
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Mar 2024 12:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10DCC1F2216F
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Mar 2024 11:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259BA3B2A1;
	Mon, 11 Mar 2024 11:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rWYl6fi6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8184B3B2BE
	for <linux-rdma@vger.kernel.org>; Mon, 11 Mar 2024 11:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710157109; cv=none; b=jr9pvbKfmvDobTPaMwtwVybn/n0l8wFXsDkZDeIW8huRZhenpsPLttHWQKW5S9Nq2TtPw+dDGqSEaIkxWUnVcSqp7CElNF7OovMbXzmCuwbIlOaJdTctT+8Y6pJy5KzwX1lUsgnMlyiU2FsOFd6lR/FfOktwSI3ikXgzPu0DhIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710157109; c=relaxed/simple;
	bh=jt8SkkfQqtfjJK34b4YvX8KxYRZ2Jl6D1zo2Cl05L6I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iE6Tpb3WTcucZ42y/ZTXMMDcTRSuEeAQRLckCWgeacMK1NJQF+2qk9Acx4eB/eenlrO9/kk1mvtebLiuByU/RgEzH3osNC/M3BuejFaQ+Y8Vsxkl3k71ycjTNAIWHUeti+sMBkerMHOcIr7+U0880DRFSARZFxgMS9S0YXyo88w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=alibaba-inc.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rWYl6fi6; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=alibaba-inc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710157105; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=V8K4OJDcFfCwX7P6Fkex6wiWBDY0G7dYGJoDidIYrjA=;
	b=rWYl6fi6H4djgh1xhmeeloCO2p3bzqwPspjxGGuKnElioUPyjAF03gUHIayUcB6ipEE5Dep7cNtbDJyY6FTNOgmOhpeoOSX9xFUOQBGJDyyMFEgm7Wlw+hlwzA/5/hjau9j8uRQKGcq3lUW6MkENkDZoyMSm6YTMqijYM0YQK3E=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=boshiyu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W2Ghvqb_1710157104;
Received: from localhost(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0W2Ghvqb_1710157104)
          by smtp.aliyun-inc.com;
          Mon, 11 Mar 2024 19:38:24 +0800
From: Boshi Yu <boshiyu@alibaba-inc.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	chengyou@linux.alibaba.com,
	KaiShen@linux.alibaba.com
Subject: [PATCH for-next 3/3] RDMA/erdma: Remove unnecessary __GFP_ZERO flag
Date: Mon, 11 Mar 2024 19:38:21 +0800
Message-Id: <20240311113821.22482-4-boshiyu@alibaba-inc.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240311113821.22482-1-boshiyu@alibaba-inc.com>
References: <20240311113821.22482-1-boshiyu@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Boshi Yu <boshiyu@linux.alibaba.com>

The dma_alloc_coherent() interface automatically zero the memory returned.
Thus, we do not need to specify the __GFP_ZERO flag explicitly when we call
dma_alloc_coherent().

Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_cmdq.c | 6 ++----
 drivers/infiniband/hw/erdma/erdma_eq.c   | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_cmdq.c b/drivers/infiniband/hw/erdma/erdma_cmdq.c
index 0ac2683cfccf..43ff40b5a09d 100644
--- a/drivers/infiniband/hw/erdma/erdma_cmdq.c
+++ b/drivers/infiniband/hw/erdma/erdma_cmdq.c
@@ -127,8 +127,7 @@ static int erdma_cmdq_cq_init(struct erdma_dev *dev)
 
 	cq->depth = cmdq->sq.depth;
 	cq->qbuf = dma_alloc_coherent(&dev->pdev->dev, cq->depth << CQE_SHIFT,
-				      &cq->qbuf_dma_addr,
-				      GFP_KERNEL | __GFP_ZERO);
+				      &cq->qbuf_dma_addr, GFP_KERNEL);
 	if (!cq->qbuf)
 		return -ENOMEM;
 
@@ -162,8 +161,7 @@ static int erdma_cmdq_eq_init(struct erdma_dev *dev)
 
 	eq->depth = cmdq->max_outstandings;
 	eq->qbuf = dma_alloc_coherent(&dev->pdev->dev, eq->depth << EQE_SHIFT,
-				      &eq->qbuf_dma_addr,
-				      GFP_KERNEL | __GFP_ZERO);
+				      &eq->qbuf_dma_addr, GFP_KERNEL);
 	if (!eq->qbuf)
 		return -ENOMEM;
 
diff --git a/drivers/infiniband/hw/erdma/erdma_eq.c b/drivers/infiniband/hw/erdma/erdma_eq.c
index 0a4746e6d05c..84ccdd8144c9 100644
--- a/drivers/infiniband/hw/erdma/erdma_eq.c
+++ b/drivers/infiniband/hw/erdma/erdma_eq.c
@@ -87,8 +87,7 @@ int erdma_aeq_init(struct erdma_dev *dev)
 	eq->depth = ERDMA_DEFAULT_EQ_DEPTH;
 
 	eq->qbuf = dma_alloc_coherent(&dev->pdev->dev, eq->depth << EQE_SHIFT,
-				      &eq->qbuf_dma_addr,
-				      GFP_KERNEL | __GFP_ZERO);
+				      &eq->qbuf_dma_addr, GFP_KERNEL);
 	if (!eq->qbuf)
 		return -ENOMEM;
 
@@ -237,8 +236,7 @@ static int erdma_ceq_init_one(struct erdma_dev *dev, u16 ceqn)
 
 	eq->depth = ERDMA_DEFAULT_EQ_DEPTH;
 	eq->qbuf = dma_alloc_coherent(&dev->pdev->dev, eq->depth << EQE_SHIFT,
-				      &eq->qbuf_dma_addr,
-				      GFP_KERNEL | __GFP_ZERO);
+				      &eq->qbuf_dma_addr, GFP_KERNEL);
 	if (!eq->qbuf)
 		return -ENOMEM;
 
-- 
2.39.3


