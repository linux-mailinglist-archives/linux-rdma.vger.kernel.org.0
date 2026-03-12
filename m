Return-Path: <linux-rdma+bounces-18078-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFH6OFGMsmkQNgAAu9opvQ
	(envelope-from <linux-rdma+bounces-18078-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 10:50:09 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1935B26FDE2
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 10:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4A7B3059F3A
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 09:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EF63B9DAA;
	Thu, 12 Mar 2026 09:49:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from outbound.baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5FB383C92;
	Thu, 12 Mar 2026 09:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773308969; cv=none; b=rNWoFojRhghBeM5Ji9If6GFWetpieAq3/lOBhVUvj1lPcQAo9PLB/ubPK9lHGaspD0A1pdxUWBH+xTl53RUwlwWPjvoIjYibENWrlOv1v0yMwI7LTxFlFqEtPQj7h5HU2r6t4VmJzpe3VF+EsS/6hkfTO0yvth0fxkd3/BBMbxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773308969; c=relaxed/simple;
	bh=9zzaRHUCwzTeSCMncUs1wTkXFJ7kgqhf0+bHT3pePj0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RCoDq1Xg/UK22vmA5GR2oxKC6teffwKodahCmR55nm5VHOEboMnb7ZI84hSCsjrlpwtL1Z7yOKQKJjnVJUT4PAiC2BF1u4RSfaHAVyXD9+kq/cKp2Hfhf1BKZwOKz/1latTZIg4vanGnZJwndXNRnI/jur4HPwpf2Jb3wngLrtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Li RongQing <lirongqing@baidu.com>, "Paul E . McKenney"
	<paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
CC: liyongkang <liyongkang01@baidu.com>
Subject: [PATCH][net-next] net/mlx5: Expedite notifier unregistration during device teardown
Date: Thu, 12 Mar 2026 05:48:04 -0400
Message-ID: <20260312094804.2744-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc2.internal.baidu.com (172.31.3.12) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM
X-Spamd-Result: default: False [3.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[baidu.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-18078-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lirongqing@baidu.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1935B26FDE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Li RongQing <lirongqing@baidu.com>

During device hot-unplug, the mlx5 driver expects quickly unregister
notification chains. The standard atomic_notifier_chain_unregister()
calls synchronize_rcu(), which introduces significant latency and
can become a bottleneck during mass resource cleanup.

Introduce atomic_notifier_chain_unregister_expedited() to leverage
synchronize_rcu_expedited(), and use it significantly reducing wait
times in the following paths:
 - Event Queue (EQ) notifier chain
 - Firmware event notifier chain
 - IRQ notifier chain

This acceleration ensures faster teardown during hot-unplug events.

Co-developed-by: liyongkang <liyongkang01@baidu.com>
Signed-off-by: liyongkang <liyongkang01@baidu.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c      |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/events.c  |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c |  2 +-
 include/linux/notifier.h                          |  2 ++
 kernel/notifier.c                                 | 24 +++++++++++++++++++++++
 5 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index 22a6371..03ae6ed 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -1244,6 +1244,6 @@ int mlx5_eq_notifier_unregister(struct mlx5_core_dev *dev, struct mlx5_nb *nb)
 {
 	struct mlx5_eq_table *eqt = dev->priv.eq_table;
 
-	return atomic_notifier_chain_unregister(&eqt->nh[nb->event_type], &nb->nb);
+	return atomic_notifier_chain_unregister_expedited(&eqt->nh[nb->event_type], &nb->nb);
 }
 EXPORT_SYMBOL(mlx5_eq_notifier_unregister);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/events.c b/drivers/net/ethernet/mellanox/mlx5/core/events.c
index 4d7f35b..753cb15 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/events.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/events.c
@@ -436,7 +436,7 @@ int mlx5_notifier_unregister(struct mlx5_core_dev *dev, struct notifier_block *n
 {
 	struct mlx5_events *events = dev->priv.events;
 
-	return atomic_notifier_chain_unregister(&events->fw_nh, nb);
+	return atomic_notifier_chain_unregister_expedited(&events->fw_nh, nb);
 }
 EXPORT_SYMBOL(mlx5_notifier_unregister);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index e051b9a..826685d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -356,7 +356,7 @@ int mlx5_irq_detach_nb(struct mlx5_irq *irq, struct notifier_block *nb)
 {
 	int err = 0;
 
-	err = atomic_notifier_chain_unregister(&irq->nh, nb);
+	err = atomic_notifier_chain_unregister_expedited(&irq->nh, nb);
 	mlx5_irq_put(irq);
 	return err;
 }
diff --git a/include/linux/notifier.h b/include/linux/notifier.h
index 01b6c9d..156d958 100644
--- a/include/linux/notifier.h
+++ b/include/linux/notifier.h
@@ -159,6 +159,8 @@ extern int blocking_notifier_chain_register_unique_prio(
 
 extern int atomic_notifier_chain_unregister(struct atomic_notifier_head *nh,
 		struct notifier_block *nb);
+extern int atomic_notifier_chain_unregister_expedited(struct atomic_notifier_head *nh,
+		struct notifier_block *nb);
 extern int blocking_notifier_chain_unregister(struct blocking_notifier_head *nh,
 		struct notifier_block *nb);
 extern int raw_notifier_chain_unregister(struct raw_notifier_head *nh,
diff --git a/kernel/notifier.c b/kernel/notifier.c
index 2f9fe7c..c6552e7 100644
--- a/kernel/notifier.c
+++ b/kernel/notifier.c
@@ -198,6 +198,30 @@ int atomic_notifier_chain_unregister(struct atomic_notifier_head *nh,
 EXPORT_SYMBOL_GPL(atomic_notifier_chain_unregister);
 
 /**
+ *	atomic_notifier_chain_unregister_expedited - Remove notifier from an atomic notifier chain
+ *	@nh: Pointer to head of the atomic notifier chain
+ *	@n: Entry to remove from notifier chain
+ *
+ *	Removes a notifier from an atomic notifier chain and forcefully
+ *	accelerates the RCU grace period.
+ *
+ *	Returns zero on success or %-ENOENT on failure.
+ */
+int atomic_notifier_chain_unregister_expedited(struct atomic_notifier_head *nh,
+		struct notifier_block *n)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&nh->lock, flags);
+	ret = notifier_chain_unregister(&nh->head, n);
+	spin_unlock_irqrestore(&nh->lock, flags);
+	synchronize_rcu_expedited();
+	return ret;
+}
+EXPORT_SYMBOL_GPL(atomic_notifier_chain_unregister_expedited);
+
+/**
  *	atomic_notifier_call_chain - Call functions in an atomic notifier chain
  *	@nh: Pointer to head of the atomic notifier chain
  *	@val: Value passed unmodified to notifier function
-- 
2.9.4


