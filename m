Return-Path: <linux-rdma+bounces-18232-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uD8CGvuhuGlygwEAu9opvQ
	(envelope-from <linux-rdma+bounces-18232-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 01:36:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2022A249A
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 01:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E082301F14F
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 00:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F171620C00A;
	Tue, 17 Mar 2026 00:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="mUYmornL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from outbound.baidu.com (mx15.baidu.com [111.202.115.100])
	by smtp.subspace.kernel.org (Postfix) with SMTP id D634720C012;
	Tue, 17 Mar 2026 00:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773707766; cv=none; b=XYn2pcSHSywCjvPptdbf0cnVkAsw3x3IwsMSCvCiUxMrwhtE/F0QSTwDLxHDQYYOLtT0k8uL6TCG+r9dWkG0o4YQyX7rFWs87MyJ+jBbjU9hrtE7f89Gi3HBFOJ8nDIsJzqwzAUnGRp1fIuCX+RaPhdRomDRNlnrX7x8AHdzUcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773707766; c=relaxed/simple;
	bh=JGjqeZTdlr33dtOhAGjHtxR6SyjH3lyit3YVGymEvXg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dDdH0uxZjaqJPQo2AIIgvOd1locBFLvSLjaOkLCa15nxuV3rtxTs68MkPEv+1ScOFA1qDEiDtXyzxEcbprCd9WMXhh928TnUqmpUakONbYOxjyZ+dnCER3ULeo09Xelx2pKBuwYecf/G6rBqty3Jv6fUaBGYhdQnmjliRa2ow4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=mUYmornL; arc=none smtp.client-ip=111.202.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
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
Subject: [PATCH][net-next v2] net/mlx5: Expedite notifier unregistration during device teardown
Date: Mon, 16 Mar 2026 20:35:44 -0400
Message-ID: <20260317003544.2583-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc3.internal.baidu.com (172.31.50.47) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1773707758;
	bh=gRO5j431xX28a4RYWB1D3tcE+WVpePvtAeGMMBX8AlY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=mUYmornL4p0Fjt9evF1Ug+m4BR8Q43JqgVTbj1cpc+8HmlSlvwm3w8+rtUluzWKfW
	 gwTkP8prV5BZmGua1k2ANUqHNRU3hO1qd1Qg2W1tMkMomdcD7u87GV3l/wG9sgXlU9
	 X3ZIlF8FbKs7jw9aXNrOlMoefoTTDLEx18S7VXW3EA/428/7Y0+24jKRTZtt5oFXTl
	 +qmqvfm4hcOVJqG9ApdKGUfGUhWxPDgdQG36ihp2hRsjOJ9vFST/f1QkyX9MhnTZ5x
	 WH4uyK8bSjZXuueyoHnOXZlo7s3MBnjBrhknB/czDwIOCjkK5dv85N6Z5OBcCQEsh1
	 nvaEx9zDA4Daw==
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[baidu.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[baidu.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-18232-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lirongqing@baidu.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[baidu.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4C2022A249A
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

On x86-64 with HZ=1000, 64 networking channels:
- Average teardown time: 3.59s -> 1.9s (47% reduction)
On x86-64 with HZ=250, 64 networking channels:
- Average teardown time: 5.5s -> 1.9s (65% reduction)

Co-developed-by: liyongkang <liyongkang01@baidu.com>
Signed-off-by: liyongkang <liyongkang01@baidu.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
Diff with v1: fix doc warning and add detailed example

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
index 2f9fe7c..9b35822 100644
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
+ *	Return: 0 on success, or -ENOENT on failure.
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


