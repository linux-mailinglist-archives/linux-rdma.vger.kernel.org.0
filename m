Return-Path: <linux-rdma+bounces-12013-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE518AFF7B3
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 05:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BDF21C47EEA
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 03:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A60280331;
	Thu, 10 Jul 2025 03:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P7CyLBsN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081E6236A73
	for <linux-rdma@vger.kernel.org>; Thu, 10 Jul 2025 03:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752119418; cv=none; b=qdXqAApMTDpZrnHVQbc1ZF3AVaZR+owJcAyC1IWrnwr9+jNsWSv7918eCx+vzQdDxJRFjO/Xo9LiGq6/gU9lffMcZGHFq2jympmN1h8S3+YjCASxDZWmR3qq/MCo/JuAWmHnssds9v2XpzSd3ctG+ksiw5QNg5WzuJrhH7lmHf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752119418; c=relaxed/simple;
	bh=t373X14yQpeEmybtxZ7sfZV+qU9m5FFM/9cMW/8a82o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kcLcdua1yeSTqbWdEIpf3we5cs3eRLfM07tCfdwmNMki9T6KBq9XbtN8vPXGNySzsPc8j7A7ZBtSFvCz6Qhl+gVwEV9zGu6qixEawLl3xihqe5zODf3wmEBomQLYSlnM15rzettizl76s8uTxeMiGdvzrwCsM4wcD0yKA9Wm7Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P7CyLBsN; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752119403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HwpBnebAtAp5VJXjYPwI3xSmswhp4pqKWbFbvnOGbis=;
	b=P7CyLBsNGfM2Wr3EJGaUyyssO4sXLn3QcEkJKR/hwtpaTX2RU70dP6ib6uSEbOUXVE2CAE
	kNzn+uPxHestITweG+XR97ucxjVq8u5iHMhtUlreqeB39C4fp4vbX2YR3gZaEEkp64ltPU
	uQYX/nIFLpuJ9wVbJWJebzcSJ9A97uM=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH rdma-next 1/1] net/mlx5: Fix build -Wframe-larger-than warnings
Date: Thu, 10 Jul 2025 05:49:48 +0200
Message-Id: <20250710034948.34179-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When building, the following warnings will appear.
"
pci_irq.c: In function ‘mlx5_ctrl_irq_request’:
pci_irq.c:494:1: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]

pci_irq.c: In function ‘mlx5_irq_request_vector’:
pci_irq.c:561:1: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]

eq.c: In function ‘comp_irq_request_sf’:
eq.c:897:1: warning: the frame size of 1080 bytes is larger than 1024 bytes [-Wframe-larger-than=]

irq_affinity.c: In function ‘irq_pool_request_irq’:
irq_affinity.c:74:1: warning: the frame size of 1048 bytes is larger than 1024 bytes [-Wframe-larger-than=]
"

These warnings indicate that the stack frame size exceeds 1024 bytes in
these functions.

To resolve this, instead of allocating large memory buffers on the stack,
it is better to use kvzalloc to allocate memory dynamically on the heap.
This approach reduces stack usage and eliminates these frame size warnings.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
1. Only build tests;
2. It is not a bug fix. Thus no Fixes tag;
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c  | 16 +++++---
 .../mellanox/mlx5/core/irq_affinity.c         | 15 +++++--
 .../net/ethernet/mellanox/mlx5/core/pci_irq.c | 40 +++++++++++++------
 3 files changed, 51 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index dfb079e59d85..66ce61eee804 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -873,20 +873,26 @@ static int comp_irq_request_sf(struct mlx5_core_dev *dev, u16 vecidx)
 {
 	struct mlx5_irq_pool *pool = mlx5_irq_table_get_comp_irq_pool(dev);
 	struct mlx5_eq_table *table = dev->priv.eq_table;
-	struct irq_affinity_desc af_desc = {};
+	struct irq_affinity_desc *af_desc;
 	struct mlx5_irq *irq;
 
+	af_desc = kvzalloc(sizeof(*af_desc), GFP_KERNEL);
+	if (!af_desc)
+		return -ENOMEM;
+
 	/* In case SF irq pool does not exist, fallback to the PF irqs*/
 	if (!mlx5_irq_pool_is_sf_pool(pool))
 		return comp_irq_request_pci(dev, vecidx);
 
-	af_desc.is_managed = false;
-	cpumask_copy(&af_desc.mask, cpu_online_mask);
-	cpumask_andnot(&af_desc.mask, &af_desc.mask, &table->used_cpus);
-	irq = mlx5_irq_affinity_request(dev, pool, &af_desc);
+	af_desc->is_managed = false;
+	cpumask_copy(&af_desc->mask, cpu_online_mask);
+	cpumask_andnot(&af_desc->mask, &af_desc->mask, &table->used_cpus);
+	irq = mlx5_irq_affinity_request(dev, pool, af_desc);
 	if (IS_ERR(irq))
 		return PTR_ERR(irq);
 
+	kvfree(af_desc);
+
 	cpumask_or(&table->used_cpus, &table->used_cpus, mlx5_irq_get_affinity_mask(irq));
 	mlx5_core_dbg(pool->dev, "IRQ %u mapped to cpu %*pbl, %u EQs on this irq\n",
 		      pci_irq_vector(dev->pdev, mlx5_irq_get_index(irq)),
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
index 2691d88cdee1..929f93853843 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
@@ -47,29 +47,38 @@ static int cpu_get_least_loaded(struct mlx5_irq_pool *pool,
 static struct mlx5_irq *
 irq_pool_request_irq(struct mlx5_irq_pool *pool, struct irq_affinity_desc *af_desc)
 {
-	struct irq_affinity_desc auto_desc = {};
+	struct irq_affinity_desc *auto_desc;
 	struct mlx5_irq *irq;
 	u32 irq_index;
 	int err;
 
+	auto_desc = kvzalloc(sizeof(*auto_desc), GFP_KERNEL);
+	if (!auto_desc)
+		return ERR_PTR(-ENOMEM);
+
 	err = xa_alloc(&pool->irqs, &irq_index, NULL, pool->xa_num_irqs, GFP_KERNEL);
 	if (err)
 		return ERR_PTR(err);
+
 	if (pool->irqs_per_cpu) {
 		if (cpumask_weight(&af_desc->mask) > 1)
 			/* if req_mask contain more then one CPU, set the least loadad CPU
 			 * of req_mask
 			 */
 			cpumask_set_cpu(cpu_get_least_loaded(pool, &af_desc->mask),
-					&auto_desc.mask);
+					&auto_desc->mask);
 		else
 			cpu_get(pool, cpumask_first(&af_desc->mask));
 	}
+
 	irq = mlx5_irq_alloc(pool, irq_index,
-			     cpumask_empty(&auto_desc.mask) ? af_desc : &auto_desc,
+			     cpumask_empty(&auto_desc->mask) ? af_desc : auto_desc,
 			     NULL);
 	if (IS_ERR(irq))
 		xa_erase(&pool->irqs, irq_index);
+
+	kvfree(auto_desc);
+
 	return irq;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index 40024cfa3099..48aad94b0a5d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -470,26 +470,32 @@ void mlx5_ctrl_irq_release(struct mlx5_core_dev *dev, struct mlx5_irq *ctrl_irq)
 struct mlx5_irq *mlx5_ctrl_irq_request(struct mlx5_core_dev *dev)
 {
 	struct mlx5_irq_pool *pool = ctrl_irq_pool_get(dev);
-	struct irq_affinity_desc af_desc;
+	struct irq_affinity_desc *af_desc;
 	struct mlx5_irq *irq;
 
-	cpumask_copy(&af_desc.mask, cpu_online_mask);
-	af_desc.is_managed = false;
+	af_desc = kvzalloc(sizeof(*af_desc), GFP_KERNEL);
+	if (!af_desc)
+		return ERR_PTR(-ENOMEM);
+
+	cpumask_copy(&af_desc->mask, cpu_online_mask);
+	af_desc->is_managed = false;
 	if (!mlx5_irq_pool_is_sf_pool(pool)) {
 		/* In case we are allocating a control IRQ from a pci device's pool.
 		 * This can happen also for a SF if the SFs pool is empty.
 		 */
 		if (!pool->xa_num_irqs.max) {
-			cpumask_clear(&af_desc.mask);
+			cpumask_clear(&af_desc->mask);
 			/* In case we only have a single IRQ for PF/VF */
-			cpumask_set_cpu(cpumask_first(cpu_online_mask), &af_desc.mask);
+			cpumask_set_cpu(cpumask_first(cpu_online_mask), &af_desc->mask);
 		}
 		/* Allocate the IRQ in index 0. The vector was already allocated */
-		irq = irq_pool_request_vector(pool, 0, &af_desc, NULL);
+		irq = irq_pool_request_vector(pool, 0, af_desc, NULL);
 	} else {
-		irq = mlx5_irq_affinity_request(dev, pool, &af_desc);
+		irq = mlx5_irq_affinity_request(dev, pool, af_desc);
 	}
 
+	kvfree(af_desc);
+
 	return irq;
 }
 
@@ -548,16 +554,26 @@ struct mlx5_irq *mlx5_irq_request_vector(struct mlx5_core_dev *dev, u16 cpu,
 {
 	struct mlx5_irq_table *table = mlx5_irq_table_get(dev);
 	struct mlx5_irq_pool *pool = table->pcif_pool;
-	struct irq_affinity_desc af_desc;
+	struct irq_affinity_desc *af_desc;
 	int offset = MLX5_IRQ_VEC_COMP_BASE;
+	struct mlx5_irq *irq;
+
+	af_desc = kvzalloc(sizeof(*af_desc), GFP_KERNEL);
+	if (!af_desc)
+		return ERR_PTR(-ENOMEM);
 
 	if (!pool->xa_num_irqs.max)
 		offset = 0;
 
-	af_desc.is_managed = false;
-	cpumask_clear(&af_desc.mask);
-	cpumask_set_cpu(cpu, &af_desc.mask);
-	return mlx5_irq_request(dev, vecidx + offset, &af_desc, rmap);
+	af_desc->is_managed = false;
+	cpumask_clear(&af_desc->mask);
+	cpumask_set_cpu(cpu, &af_desc->mask);
+
+	irq = mlx5_irq_request(dev, vecidx + offset, af_desc, rmap);
+
+	kvfree(af_desc);
+
+	return irq;
 }
 
 static struct mlx5_irq_pool *
-- 
2.34.1


