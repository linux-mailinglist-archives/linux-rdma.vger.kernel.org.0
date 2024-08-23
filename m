Return-Path: <linux-rdma+bounces-4503-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2A595C6F7
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 09:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2633AB21A12
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 07:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DF314037D;
	Fri, 23 Aug 2024 07:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="A9WRhfNl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A585613D635
	for <linux-rdma@vger.kernel.org>; Fri, 23 Aug 2024 07:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724399475; cv=none; b=BMpgWraB6bu+thtXoCM46UiP4a3mk9u//T1YseWBhp1Ni+ceb/TgfGS1gUZxHJWCNlLgKt+sNhVxk4NZAqkxT4LfERX46pxV9XGdU0bONP6jDh8W75n47/OeFhE1LE6OP3qGM4qhMJNi0OnpdTcCgRPrQH4tEcrhzfjsmducSSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724399475; c=relaxed/simple;
	bh=E9tBNIv20W9VMIxsRNaGKcU3HzppGjyEj/zxRGeq+EU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r0tw3YR96JhGXicjjCP43TXjBJgDxYOjiiCy02QkSRIVRY5m0tUZwQ8Lu/MpDDAse3dPVQqfsAxNSuBqAsY+S/31piMWSGcDnLJPDUgD+DQQb+3DZEcjvlYCYAr6kJ6xcMgrcHol2ErE7DSu+0oKXKbKXPHXUJsC3LLwZjPiBVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=A9WRhfNl; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724399464; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=7J1VEBiRlVh31m5C1XJjnqvs7H1YW9A3Er5xclysqDQ=;
	b=A9WRhfNlxGN9jFu2VLWE6F6t1qqqhW8FflTL8Q7+x5aIixAvc28MysCUy1x7P7KMTPcYzKNoXUN/tl0DcXIJAYcpNAjG4A1vG9ICUczGe17P25WsRt3+r/wHzkWf7jD1c8m2biAfWrrq0KN5bvNWyabeydryfp7S9q4QGWRaKA0=
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0WDSj-TL_1724399463)
          by smtp.aliyun-inc.com;
          Fri, 23 Aug 2024 15:51:03 +0800
From: Cheng Xu <chengyou@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	KaiShen@linux.alibaba.com
Subject: [PATCH for-next 2/4] RDMA/erdma: Refactor the initialization and destruction of EQ
Date: Fri, 23 Aug 2024 15:50:56 +0800
Message-Id: <20240823075058.89488-3-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240823075058.89488-1-chengyou@linux.alibaba.com>
References: <20240823075058.89488-1-chengyou@linux.alibaba.com>
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
 drivers/infiniband/hw/erdma/erdma_cmdq.c | 26 ++------
 drivers/infiniband/hw/erdma/erdma_eq.c   | 83 +++++++++++++-----------
 drivers/infiniband/hw/erdma/erdma_main.c |  4 +-
 4 files changed, 55 insertions(+), 61 deletions(-)

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
index 84ccdd8144c9..227c742c43df 100644
--- a/drivers/infiniband/hw/erdma/erdma_eq.c
+++ b/drivers/infiniband/hw/erdma/erdma_eq.c
@@ -80,25 +80,53 @@ void erdma_aeq_event_handler(struct erdma_dev *dev)
 	notify_eq(&dev->aeq);
 }
 
-int erdma_aeq_init(struct erdma_dev *dev)
+int erdma_eq_common_init(struct erdma_dev *dev, struct erdma_eq *eq, u32 depth)
 {
-	struct erdma_eq *eq = &dev->aeq;
-
-	eq->depth = ERDMA_DEFAULT_EQ_DEPTH;
+	u32 buf_size = depth << EQE_SHIFT;
 
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
+	eq->ci = 0;
+	eq->depth = depth;
+
+	return 0;
+
+err_free_qbuf:
+	dma_free_coherent(&dev->pdev->dev, buf_size, eq->qbuf,
+			  eq->qbuf_dma_addr);
+
+	return -ENOMEM;
+}
+
+void erdma_eq_destroy(struct erdma_dev *dev, struct erdma_eq *eq)
+{
+	dma_pool_free(dev->db_pool, eq->dbrec, eq->dbrec_dma);
+	dma_free_coherent(&dev->pdev->dev, eq->depth << EQE_SHIFT, eq->qbuf,
+			  eq->qbuf_dma_addr);
+}
+
+int erdma_aeq_init(struct erdma_dev *dev)
+{
+	struct erdma_eq *eq = &dev->aeq;
+	int ret;
+
+	ret = erdma_eq_common_init(dev, &dev->aeq, ERDMA_DEFAULT_EQ_DEPTH);
+	if (ret)
+		return ret;
 
 	eq->db = dev->func_bar + ERDMA_REGS_AEQ_DB_REG;
-	eq->dbrec = dma_pool_zalloc(dev->db_pool, GFP_KERNEL, &eq->dbrec_dma);
-	if (!eq->dbrec)
-		goto err_out;
 
 	erdma_reg_write32(dev, ERDMA_REGS_AEQ_ADDR_H_REG,
 			  upper_32_bits(eq->qbuf_dma_addr));
@@ -108,12 +136,6 @@ int erdma_aeq_init(struct erdma_dev *dev)
 	erdma_reg_write64(dev, ERDMA_AEQ_DB_HOST_ADDR_REG, eq->dbrec_dma);
 
 	return 0;
-
-err_out:
-	dma_free_coherent(&dev->pdev->dev, eq->depth << EQE_SHIFT, eq->qbuf,
-			  eq->qbuf_dma_addr);
-
-	return -ENOMEM;
 }
 
 void erdma_aeq_destroy(struct erdma_dev *dev)
@@ -234,32 +256,21 @@ static int erdma_ceq_init_one(struct erdma_dev *dev, u16 ceqn)
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
@@ -283,9 +294,7 @@ static void erdma_ceq_uninit_one(struct erdma_dev *dev, u16 ceqn)
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


