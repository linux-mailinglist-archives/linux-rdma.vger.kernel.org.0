Return-Path: <linux-rdma+bounces-20667-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPpHJB19BWrWXgIAu9opvQ
	(envelope-from <linux-rdma+bounces-20667-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 09:43:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EADB853EEC8
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 09:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A483D3037DCB
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 07:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395453D75B0;
	Thu, 14 May 2026 07:43:18 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBFA397E64;
	Thu, 14 May 2026 07:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778744598; cv=none; b=lEfEvL1ETAn7QZHKFKvhnfZNxS+AJT93/B0QmI9hbrLc7X79TvmQnY7zOswYq0tUXtFdf5FfpyR2fmFWzk17TNgowKhHi+pvBgmrPoKKpmTsyLf70G8fB+3KvcoooD+TczFTAWRy8/kNEF/ooGNy9lpKclyviTn65ngy5SxAMIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778744598; c=relaxed/simple;
	bh=lr6YOB0Ycpxsk0yj2Q0cfacRXzbNvU4VD8F7JGtBNvY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qi6sM/f1LjAMqAL4T6+8cvO9uKNY783qiuwii4ZA7Bmcy5ai878gGVPWdZOGuLnV+AJGljvDFGzslIU/EuAip34RibZQTwDfiwMVh4KUxdVBVIHA0u+IWGiqtHIQWNwZ7qAcvHIe5ocU3vvJYGLoAlLY17BHuMPfcz09W5U3Kt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=hygon.cn; spf=fail smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4gGMkN00sVzVcBG;
	Thu, 14 May 2026 15:42:52 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4gGMkL25DgzVcBG;
	Thu, 14 May 2026 15:42:50 +0800 (CST)
Received: from cncheex03.Hygon.cn (unknown [172.23.18.113])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 466E9AE2C;
	Thu, 14 May 2026 15:42:42 +0800 (CST)
Received: from SH-JV3KG14.Hygon.cn (172.19.24.96) by cncheex03.Hygon.cn
 (172.23.18.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 14 May
 2026 15:42:48 +0800
From: Yi Li <liyi@hygon.cn>
To: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yi Li
	<liyi@hygon.cn>
Subject: [PATCH] net/mlx5: Update mlx5_irq.mask when IRQ affinity changes
Date: Thu, 14 May 2026 15:42:08 +0800
Message-ID: <20260514074208.23353-1-liyi@hygon.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cncheex05.Hygon.cn (172.23.18.115) To cncheex03.Hygon.cn
 (172.23.18.113)
X-Rspamd-Queue-Id: EADB853EEC8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[hygon.cn : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20667-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.867];
	FROM_NEQ_ENVFROM(0.00)[liyi@hygon.cn,linux-rdma@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

mlx5_irq.mask is used for:
1) Setting IRQ affinity_hint in mlx5_irq_alloc()
2) Determining mlx5e_channel.cpu in mlx5e_open_channel(), which in turn
   decides the NUMA node for queue allocations.

When a user modifies IRQ affinity, mlx5_irq.mask remains unchanged.
Consequently even if mlx5e_open_channel() is invoked again, queues are
still allocated on the original NUMA node instead of the newly
preferred one.

Fix this by registering an irq_set_affinity_notifier to update
mlx5_irq.mask when /proc/irq/N/smp_affinity is modified.
Therefore subsequent queue allocations reflect the updated affinity.

Signed-off-by: Yi Li <liyi@hygon.cn>
---
 .../net/ethernet/mellanox/mlx5/core/pci_irq.c  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index e051b9a939ee..501496159aa2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -35,6 +35,7 @@ struct mlx5_irq {
 	int refcount;
 	struct msi_map map;
 	u32 pool_index;
+	struct irq_affinity_notify af_notify;
 };
 
 struct mlx5_irq_table {
@@ -158,6 +159,9 @@ static void mlx5_system_free_irq(struct mlx5_irq *irq)
 	struct cpu_rmap *rmap;
 #endif
 
+	if (irq->af_notify.notify)
+		irq_set_affinity_notifier(irq->map.virq, NULL);
+
 	/* free_irq requires that affinity_hint and rmap will be cleared before
 	 * calling it. To satisfy this requirement, we call
 	 * irq_cpu_rmap_remove() to remove the notifier
@@ -252,6 +256,16 @@ static void irq_set_name(struct mlx5_irq_pool *pool, char *name, int vecidx)
 	snprintf(name, MLX5_MAX_IRQ_NAME, "mlx5_comp%d", vecidx);
 }
 
+static void mlx5_irq_affinity_changed(struct irq_affinity_notify *notify,
+				      const cpumask_t *mask)
+{
+	struct mlx5_irq *irq = container_of(notify, struct mlx5_irq, af_notify);
+
+	cpumask_copy(irq->mask, mask);
+}
+
+static void mlx5_irq_affinity_notifier_release(struct kref *ref) {}
+
 struct mlx5_irq *mlx5_irq_alloc(struct mlx5_irq_pool *pool, int i,
 				struct irq_affinity_desc *af_desc,
 				struct cpu_rmap **rmap)
@@ -307,6 +321,10 @@ struct mlx5_irq *mlx5_irq_alloc(struct mlx5_irq_pool *pool, int i,
 	if (af_desc) {
 		cpumask_copy(irq->mask, &af_desc->mask);
 		irq_set_affinity_and_hint(irq->map.virq, irq->mask);
+
+		irq->af_notify.notify  = mlx5_irq_affinity_changed;
+		irq->af_notify.release = mlx5_irq_affinity_notifier_release;
+		irq_set_affinity_notifier(irq->map.virq, &irq->af_notify);
 	}
 	irq->pool = pool;
 	irq->refcount = 1;
-- 
2.53.0



