Return-Path: <linux-rdma+bounces-23182-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LhDrMJfrVWrNvwAAu9opvQ
	(envelope-from <linux-rdma+bounces-23182-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 09:56:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC077521CB
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 09:56:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=Wo371wp4;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23182-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23182-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 165123011A5F
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 07:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7AF3E1D04;
	Tue, 14 Jul 2026 07:56:04 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BF03F210C
	for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2026 07:56:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784015764; cv=none; b=daQIKsccH5K0S5vR84yUh1FVw2CgFWCGevXyf2gSldQvGAg/8VyEcR8mUP6qReDrNGj/RxcNWYsEHsqZ8jjHlF1iUkvu+zwoqSeCPKVBYO4eCqpcwoscYhO3StNArH3UyxxO0gQ2k8AePPtUCKY8QCAiN7g21FZ3MseoPeSW7Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784015764; c=relaxed/simple;
	bh=mulvhTCe7dHE9wfxj7MjbGJtwKROwRLTZrQjguvcJWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DYqoIZi4LekeyfOQqOW4rkoC7JNi0HfRlTfrKZ1xpZ6sg8soKfBQuDHXb5hHTx7xUZ0/FjqztNb5Ug8Q5ucHOOfI7vHTxL7AsBKHGQNxzn3yaiotvxPEULt52jhuNKk2IZwPL1y18VoHD/j8PF81Ptjb+tbjLZk4E+zLYHpuKW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wo371wp4; arc=none smtp.client-ip=91.218.175.178
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784015750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QfbaPE2qlPGSNlqfzxGPAsE50t0yUtiDQHijkOK6WWc=;
	b=Wo371wp45LnZd7dV80czFAEebfJ0HGAJr0BgmPFjn/skXNWLvt44wTBVcf9QCGbGhCkGg5
	HpY99WQbJgG9lHCrtpRyk9DUgY7Bv91U72r6Js7HE+zgI8drEsLy/LQTVTQ91ZKoly0ARp
	Kn7WS7BdvlfZyYSjJgjaBXnUAUXiFxM=
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: leon@kernel.org,
	jgg@ziepe.ca,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	chenguang.zhao@linux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH v2] RDMA/core: quiesce CQ polling before device shutdown on reboot
Date: Tue, 14 Jul 2026 15:55:58 +0800
Message-Id: <20260714075558.1420384-1-chenguang.zhao@linux.dev>
In-Reply-To: <20260702073422.279820-1-chenguang.zhao@linux.dev>
References: <20260702073422.279820-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23182-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-rdma@vger.kernel.org,m:netdev@vger.kernel.org,m:chenguang.zhao@linux.dev,m:zhaochenguang@kylinos.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[chenguang.zhao@linux.dev,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenguang.zhao@linux.dev,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,kylinos.cn:email,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9BC077521CB

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

On reboot -f with NFS over RDMA, mlx5 shutdown can tear the device
down while ib-comp-wq still polls live CQs, leading to UAF in
wr_cqe->done().
Mark the device shutting down before teardown, and skip CQ poll/arm
and SYS_ERROR completion delivery while that flag is set.

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
1. Set the SHUTTING_DOWN flag at the mlx5 PCI/SF shutdown entry.

2. Skip SYS_ERROR notifications during shutdown to avoid the
   internal error path re-arming CQs.

3. Make mlx5_ib_poll_cq / mlx5_ib_arm_cq return immediately while
   that flag is set, so completions are no longer delivered.

 drivers/infiniband/hw/mlx5/cq.c                       |  6 ++++++
 drivers/infiniband/hw/mlx5/main.c                     | 11 +++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/health.c      |  3 +++
 drivers/net/ethernet/mellanox/mlx5/core/main.c        |  1 +
 .../net/ethernet/mellanox/mlx5/core/sf/dev/driver.c   |  1 +
 include/linux/mlx5/driver.h                           |  6 ++++++
 6 files changed, 28 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index 49b4bf148a4a..584445e6d2fc 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -618,6 +618,9 @@ int mlx5_ib_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc)
 	int soft_polled = 0;
 	int npolled;
 
+	if (mlx5_core_is_shutting_down(mdev))
+		return 0;
+
 	spin_lock_irqsave(&cq->lock, flags);
 	if (mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR) {
 		/* make sure no soft wqe's are waiting */
@@ -653,6 +656,9 @@ int mlx5_ib_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags)
 	unsigned long irq_flags;
 	int ret = 0;
 
+	if (mlx5_core_is_shutting_down(mdev))
+		return 0;
+
 	spin_lock_irqsave(&cq->lock, irq_flags);
 	if (cq->notify_flags != IB_CQ_NEXT_COMP)
 		cq->notify_flags = flags & IB_CQ_SOLICITED_MASK;
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 02809114fc79..265c95129fad 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2976,6 +2976,9 @@ static void mlx5_ib_handle_internal_error(struct mlx5_ib_dev *ibdev)
 	unsigned long flags_cq;
 	unsigned long flags;
 
+	if (mlx5_core_is_shutting_down(ibdev->mdev))
+		return;
+
 	INIT_LIST_HEAD(&cq_armed_list);
 
 	/* Go over qp list reside on that ibdev, sync with create/destroy qp.*/
@@ -3200,6 +3203,9 @@ static void mlx5_ib_handle_sys_error_event(struct work_struct *_work)
 	struct mlx5_ib_dev *ibdev = work->dev;
 	struct ib_event ibev;
 
+	if (mlx5_core_is_shutting_down(ibdev->mdev))
+		goto out;
+
 	ibev.event = IB_EVENT_DEVICE_FATAL;
 	mlx5_ib_handle_internal_error(ibdev);
 	ibev.element.port_num = (u8)(unsigned long)work->param;
@@ -3222,10 +3228,15 @@ static int mlx5_ib_sys_error_event(struct notifier_block *nb,
 				   unsigned long event, void *param)
 {
 	struct mlx5_ib_event_work *work;
+	struct mlx5_ib_dev *ibdev;
 
 	if (event != MLX5_DEV_EVENT_SYS_ERROR)
 		return NOTIFY_DONE;
 
+	ibdev = container_of(nb, struct mlx5_ib_dev, sys_error_events);
+	if (mlx5_core_is_shutting_down(ibdev->mdev))
+		return NOTIFY_OK;
+
 	work = kmalloc_obj(*work, GFP_ATOMIC);
 	if (!work)
 		return NOTIFY_DONE;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/health.c b/drivers/net/ethernet/mellanox/mlx5/core/health.c
index aeeb136f5ebc..d9cc42c4c310 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
@@ -202,6 +202,9 @@ static void enter_error_state(struct mlx5_core_dev *dev, bool force)
 		mlx5_cmd_flush(dev);
 	}
 
+	if (mlx5_core_is_shutting_down(dev))
+		return;
+
 	mlx5_notifier_call_chain(dev->priv.events, MLX5_DEV_EVENT_SYS_ERROR, (void *)1);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 643b4aac2033..078114bfb357 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -2192,6 +2192,7 @@ static void shutdown(struct pci_dev *pdev)
 	int err;
 
 	mlx5_core_info(dev, "Shutdown was called\n");
+	set_bit(MLX5_INTERFACE_STATE_SHUTTING_DOWN, &dev->intf_state);
 	set_bit(MLX5_BREAK_FW_WAIT, &dev->intf_state);
 	mlx5_drain_fw_reset(dev);
 	mlx5_drain_health_wq(dev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
index 4391ef0bab5d..6f8242bfb455 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
@@ -111,6 +111,7 @@ static void mlx5_sf_dev_shutdown(struct auxiliary_device *adev)
 	struct mlx5_sf_dev *sf_dev = container_of(adev, struct mlx5_sf_dev, adev);
 	struct mlx5_core_dev *mdev = sf_dev->mdev;
 
+	set_bit(MLX5_INTERFACE_STATE_SHUTTING_DOWN, &mdev->intf_state);
 	set_bit(MLX5_BREAK_FW_WAIT, &mdev->intf_state);
 	mlx5_drain_health_wq(mdev);
 	mlx5_unload_one(mdev, false);
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index b1871c0821d0..a9efc37cd254 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -653,8 +653,14 @@ enum mlx5_device_state {
 enum mlx5_interface_state {
 	MLX5_INTERFACE_STATE_UP = BIT(0),
 	MLX5_BREAK_FW_WAIT = BIT(1),
+	MLX5_INTERFACE_STATE_SHUTTING_DOWN = BIT(2),
 };
 
+static inline bool mlx5_core_is_shutting_down(struct mlx5_core_dev *dev)
+{
+	return test_bit(MLX5_INTERFACE_STATE_SHUTTING_DOWN, &dev->intf_state);
+}
+
 enum mlx5_pci_status {
 	MLX5_PCI_STATUS_DISABLED,
 	MLX5_PCI_STATUS_ENABLED,
-- 
2.25.1


