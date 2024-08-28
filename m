Return-Path: <linux-rdma+bounces-4602-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EE3961F16
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 08:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AD7F1C216E2
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 06:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8FC1552FA;
	Wed, 28 Aug 2024 06:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kNjfQ3ri"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62691552ED
	for <linux-rdma@vger.kernel.org>; Wed, 28 Aug 2024 06:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724825397; cv=none; b=qJadrqM06kz2CQ0fytWQzZysQzMPG1wrTQS4fBrFOAp15PCclSY6N+TlQriPTBo8VeHp+iFFP0okX82YkLUgeerGkXCudBWJahXSsZHbvgUb7vz1H/yLqjK1+qsc9Q8n3lURibCaGYwAdt8cJ3AW9mVlfHmt59nkfVO/+8tQWlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724825397; c=relaxed/simple;
	bh=6bMqRlo4FCpluhTpxFmj78/vmFLXamt5olGAR+6n67s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ix5+uvLJ6Y7tznEn39F9Sh+Nfg6aZwUI2Mdg6RXBXLiiObTRtkPPQPdU4gW82DumVN+/M6+IST/VWbHpEMEphAI2liCpthTq2QnO63hd+/a+klMhiAxSbYZE50/br6rRBfgLwHlP5zi7UUVbZ/iJXmSR6WwKPNX3OTCk5YvjgbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kNjfQ3ri; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724825387; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=8NmTxMOks52GN+L0KbXgVvPlIkLFFlYcNgNhZu6UynY=;
	b=kNjfQ3riudIz3VcB80gfq4w257vSVGRggpt0EEadLEygIpR9x6uAwXQ8hgheu+aCaMddrHIBx9fGpY+uzn7YJp/5L0tO7xjUIjNlfpSJC6mReq1jSiDkngUDEph7gjjnUOYtPMVccG0nzSfW1kJZSPQ0qZ6pb/BrS02haxXRiHg=
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0WDok9MO_1724825386)
          by smtp.aliyun-inc.com;
          Wed, 28 Aug 2024 14:09:47 +0800
From: Cheng Xu <chengyou@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	KaiShen@linux.alibaba.com
Subject: [PATCH for-next v2 2/4] RDMA/erdma: Refactor the initialization and destruction of EQ
Date: Wed, 28 Aug 2024 14:09:42 +0800
Message-Id: <20240828060944.77829-3-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240828060944.77829-1-chengyou@linux.alibaba.com>
References: <20240828060944.77829-1-chengyou@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We extracted the common parts of the initialization/destruction
process to make the code cleaner.

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma.h      |  3 +-
 drivers/infiniband/hw/erdma/erdma_cmdq.c | 26 ++-----
 drivers/infiniband/hw/erdma/erdma_eq.c   | 91 ++++++++++++------------
 drivers/infiniband/hw/erdma/erdma_main.c |  4 +-
 4 files changed, 54 insertions(+), 70 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma.h b/drivers/infiniband/hw/erdma/erdma.h
index b5c258f77ca0..f3b648dcf4b6 100644
--- a/drivers/infiniband/hw/erdma/erdma.h
+++ b/drivers/infiniband/hw/erdma/erdma.h
@@ -275,7 +275,8 @@ void notify_eq(struct erdma_eq *eq);
 void *get_next_valid_eqe(struct erdma_eq *eq);
 
 int erdma_aeq_init(struct erdma_dev *dev);
-void erdma_aeq_destroy(struct erdma_dev *dev);
+int erdma_eq_common_init(struct erdma_dev *dev, struct erdma_eq *eq, u32 depth);
+void erdma_eq_destroy(struct erdma_dev *dev, struct erdma_eq *eq);
 
 void erdma_aeq_event_handler(struct erdma_dev *dev);
 void erdma_ceq_completion_handler(struct erdma_eq_cb *ceq_cb);
diff --git a/drivers/infiniband/hw/erdma/erdma_cmdq.c b/drivers/infiniband/hw/erdma/erdma_cmdq.c
index 43ff40b5a09d..a3d8922d1ad1 100644
--- a/drivers/infiniband/hw/erdma/erdma_cmdq.c
+++ b/drivers/infiniband/hw/erdma/erdma_cmdq.c
@@ -158,20 +158,13 @@ static int erdma_cmdq_eq_init(struct erdma_dev *dev)
 {
 	struct erdma_cmdq *cmdq = &dev->cmdq;
 	struct erdma_eq *eq = &cmdq->eq;
+	int ret;
 
-	eq->depth = cmdq->max_outstandings;
-	eq->qbuf = dma_alloc_coherent(&dev->pdev->dev, eq->depth << EQE_SHIFT,
-				      &eq->qbuf_dma_addr, GFP_KERNEL);
-	if (!eq->qbuf)
-		return -ENOMEM;
-
-	spin_lock_init(&eq->lock);
-	atomic64_set(&eq->event_num, 0);
+	ret = erdma_eq_common_init(dev, eq, cmdq->max_outstandings);
+	if (ret)
+		return ret;
 
 	eq->db = dev->func_bar + ERDMA_REGS_CEQ_DB_BASE_REG;
-	eq->dbrec = dma_pool_zalloc(dev->db_pool, GFP_KERNEL, &eq->dbrec_dma);
-	if (!eq->dbrec)
-		goto err_out;
 
 	erdma_reg_write32(dev, ERDMA_REGS_CMDQ_EQ_ADDR_H_REG,
 			  upper_32_bits(eq->qbuf_dma_addr));
@@ -181,12 +174,6 @@ static int erdma_cmdq_eq_init(struct erdma_dev *dev)
 	erdma_reg_write64(dev, ERDMA_CMDQ_EQ_DB_HOST_ADDR_REG, eq->dbrec_dma);
 
 	return 0;
-
-err_out:
-	dma_free_coherent(&dev->pdev->dev, eq->depth << EQE_SHIFT, eq->qbuf,
-			  eq->qbuf_dma_addr);
-
-	return -ENOMEM;
 }
 
 int erdma_cmdq_init(struct erdma_dev *dev)
@@ -247,10 +234,7 @@ void erdma_cmdq_destroy(struct erdma_dev *dev)
 
 	clear_bit(ERDMA_CMDQ_STATE_OK_BIT, &cmdq->state);
 
-	dma_free_coherent(&dev->pdev->dev, cmdq->eq.depth << EQE_SHIFT,
-			  cmdq->eq.qbuf, cmdq->eq.qbuf_dma_addr);
-
-	dma_pool_free(dev->db_pool, cmdq->eq.dbrec, cmdq->eq.dbrec_dma);
+	erdma_eq_destroy(dev, &cmdq->eq);
 
 	dma_free_coherent(&dev->pdev->dev, cmdq->sq.depth << SQEBB_SHIFT,
 			  cmdq->sq.qbuf, cmdq->sq.qbuf_dma_addr);
diff --git a/drivers/infiniband/hw/erdma/erdma_eq.c b/drivers/infiniband/hw/erdma/erdma_eq.c
index 84ccdd8144c9..c277c8f9233c 100644
--- a/drivers/infiniband/hw/erdma/erdma_eq.c
+++ b/drivers/infiniband/hw/erdma/erdma_eq.c
@@ -80,50 +80,62 @@ void erdma_aeq_event_handler(struct erdma_dev *dev)
 	notify_eq(&dev->aeq);
 }
 
-int erdma_aeq_init(struct erdma_dev *dev)
+int erdma_eq_common_init(struct erdma_dev *dev, struct erdma_eq *eq, u32 depth)
 {
-	struct erdma_eq *eq = &dev->aeq;
+	u32 buf_size = depth << EQE_SHIFT;
 
-	eq->depth = ERDMA_DEFAULT_EQ_DEPTH;
-
-	eq->qbuf = dma_alloc_coherent(&dev->pdev->dev, eq->depth << EQE_SHIFT,
-				      &eq->qbuf_dma_addr, GFP_KERNEL);
+	eq->qbuf = dma_alloc_coherent(&dev->pdev->dev, buf_size,
+				      &eq->qbuf_dma_addr,
+				      GFP_KERNEL | __GFP_ZERO);
 	if (!eq->qbuf)
 		return -ENOMEM;
 
+	eq->dbrec = dma_pool_alloc(dev->db_pool, GFP_KERNEL | __GFP_ZERO,
+				   &eq->dbrec_dma);
+	if (!eq->dbrec)
+		goto err_free_qbuf;
+
 	spin_lock_init(&eq->lock);
 	atomic64_set(&eq->event_num, 0);
 	atomic64_set(&eq->notify_num, 0);
-
-	eq->db = dev->func_bar + ERDMA_REGS_AEQ_DB_REG;
-	eq->dbrec = dma_pool_zalloc(dev->db_pool, GFP_KERNEL, &eq->dbrec_dma);
-	if (!eq->dbrec)
-		goto err_out;
-
-	erdma_reg_write32(dev, ERDMA_REGS_AEQ_ADDR_H_REG,
-			  upper_32_bits(eq->qbuf_dma_addr));
-	erdma_reg_write32(dev, ERDMA_REGS_AEQ_ADDR_L_REG,
-			  lower_32_bits(eq->qbuf_dma_addr));
-	erdma_reg_write32(dev, ERDMA_REGS_AEQ_DEPTH_REG, eq->depth);
-	erdma_reg_write64(dev, ERDMA_AEQ_DB_HOST_ADDR_REG, eq->dbrec_dma);
+	eq->ci = 0;
+	eq->depth = depth;
 
 	return 0;
 
-err_out:
-	dma_free_coherent(&dev->pdev->dev, eq->depth << EQE_SHIFT, eq->qbuf,
+err_free_qbuf:
+	dma_free_coherent(&dev->pdev->dev, buf_size, eq->qbuf,
 			  eq->qbuf_dma_addr);
 
 	return -ENOMEM;
 }
 
-void erdma_aeq_destroy(struct erdma_dev *dev)
+void erdma_eq_destroy(struct erdma_dev *dev, struct erdma_eq *eq)
 {
-	struct erdma_eq *eq = &dev->aeq;
-
+	dma_pool_free(dev->db_pool, eq->dbrec, eq->dbrec_dma);
 	dma_free_coherent(&dev->pdev->dev, eq->depth << EQE_SHIFT, eq->qbuf,
 			  eq->qbuf_dma_addr);
+}
 
-	dma_pool_free(dev->db_pool, eq->dbrec, eq->dbrec_dma);
+int erdma_aeq_init(struct erdma_dev *dev)
+{
+	struct erdma_eq *eq = &dev->aeq;
+	int ret;
+
+	ret = erdma_eq_common_init(dev, &dev->aeq, ERDMA_DEFAULT_EQ_DEPTH);
+	if (ret)
+		return ret;
+
+	eq->db = dev->func_bar + ERDMA_REGS_AEQ_DB_REG;
+
+	erdma_reg_write32(dev, ERDMA_REGS_AEQ_ADDR_H_REG,
+			  upper_32_bits(eq->qbuf_dma_addr));
+	erdma_reg_write32(dev, ERDMA_REGS_AEQ_ADDR_L_REG,
+			  lower_32_bits(eq->qbuf_dma_addr));
+	erdma_reg_write32(dev, ERDMA_REGS_AEQ_DEPTH_REG, eq->depth);
+	erdma_reg_write64(dev, ERDMA_AEQ_DB_HOST_ADDR_REG, eq->dbrec_dma);
+
+	return 0;
 }
 
 void erdma_ceq_completion_handler(struct erdma_eq_cb *ceq_cb)
@@ -234,32 +246,21 @@ static int erdma_ceq_init_one(struct erdma_dev *dev, u16 ceqn)
 	struct erdma_eq *eq = &dev->ceqs[ceqn].eq;
 	int ret;
 
-	eq->depth = ERDMA_DEFAULT_EQ_DEPTH;
-	eq->qbuf = dma_alloc_coherent(&dev->pdev->dev, eq->depth << EQE_SHIFT,
-				      &eq->qbuf_dma_addr, GFP_KERNEL);
-	if (!eq->qbuf)
-		return -ENOMEM;
-
-	spin_lock_init(&eq->lock);
-	atomic64_set(&eq->event_num, 0);
-	atomic64_set(&eq->notify_num, 0);
+	ret = erdma_eq_common_init(dev, eq, ERDMA_DEFAULT_EQ_DEPTH);
+	if (ret)
+		return ret;
 
 	eq->db = dev->func_bar + ERDMA_REGS_CEQ_DB_BASE_REG +
 		 (ceqn + 1) * ERDMA_DB_SIZE;
-
-	eq->dbrec = dma_pool_zalloc(dev->db_pool, GFP_KERNEL, &eq->dbrec_dma);
-	if (!eq->dbrec) {
-		dma_free_coherent(&dev->pdev->dev, eq->depth << EQE_SHIFT,
-				  eq->qbuf, eq->qbuf_dma_addr);
-		return -ENOMEM;
-	}
-
-	eq->ci = 0;
 	dev->ceqs[ceqn].dev = dev;
+	dev->ceqs[ceqn].ready = true;
 
 	/* CEQ indexed from 1, 0 rsvd for CMDQ-EQ. */
 	ret = create_eq_cmd(dev, ceqn + 1, eq);
-	dev->ceqs[ceqn].ready = ret ? false : true;
+	if (ret) {
+		erdma_eq_destroy(dev, eq);
+		dev->ceqs[ceqn].ready = false;
+	}
 
 	return ret;
 }
@@ -283,9 +284,7 @@ static void erdma_ceq_uninit_one(struct erdma_dev *dev, u16 ceqn)
 	if (err)
 		return;
 
-	dma_free_coherent(&dev->pdev->dev, eq->depth << EQE_SHIFT, eq->qbuf,
-			  eq->qbuf_dma_addr);
-	dma_pool_free(dev->db_pool, eq->dbrec, eq->dbrec_dma);
+	erdma_eq_destroy(dev, eq);
 }
 
 int erdma_ceqs_init(struct erdma_dev *dev)
diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
index 9199058a0b29..d1cb488e7ad4 100644
--- a/drivers/infiniband/hw/erdma/erdma_main.c
+++ b/drivers/infiniband/hw/erdma/erdma_main.c
@@ -359,7 +359,7 @@ static int erdma_probe_dev(struct pci_dev *pdev)
 	erdma_cmdq_destroy(dev);
 
 err_uninit_aeq:
-	erdma_aeq_destroy(dev);
+	erdma_eq_destroy(dev, &dev->aeq);
 
 err_uninit_comm_irq:
 	erdma_comm_irq_uninit(dev);
@@ -392,7 +392,7 @@ static void erdma_remove_dev(struct pci_dev *pdev)
 	erdma_ceqs_uninit(dev);
 	erdma_hw_reset(dev, false);
 	erdma_cmdq_destroy(dev);
-	erdma_aeq_destroy(dev);
+	erdma_eq_destroy(dev, &dev->aeq);
 	erdma_comm_irq_uninit(dev);
 	pci_free_irq_vectors(dev->pdev);
 	erdma_device_uninit(dev);
-- 
2.31.1


