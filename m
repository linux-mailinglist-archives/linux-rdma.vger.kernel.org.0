Return-Path: <linux-rdma+bounces-23260-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 46ZQBZJDV2o8IQEAu9opvQ
	(envelope-from <linux-rdma+bounces-23260-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 10:23:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 521B075BD54
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 10:23:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=USoR8eU3;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23260-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23260-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D03B301BA6A
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 08:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C8D3CCFAF;
	Wed, 15 Jul 2026 08:23:19 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2003644A4
	for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2026 08:23:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784103798; cv=none; b=XZ2AvFmml+sTj+MGtpuQ/+UlaVSkqHjMRi+VpjpEjTdVMqBLQS15amv9ByULVALT+fnpFkgJUYUWf4Q+PnrpN/e1F3fFd4Stp/aWOMmNsJ4BmUX/fWkIAjGhF+o3Kwh0CUVvLgQQgd5u6T+NBxKjiuMnig8rmP34gFQjtZM1kQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784103798; c=relaxed/simple;
	bh=+yBiwYsDCaFrykmcJte+gpnU5qUq6P7KjJr4GQPLQIo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j5YHX+b/9A8s0zZOC61Rk9tzEm8IYT+U7aNEYGq3Iktuw+OJLzoVJVOSjELOODGQYXyJYS85RIRNw4odCBLmc0zzIMi9oPI9ZtEPhbgu079GL2sorjB84scdRYyf1DSfPqgi1XTZsg6+/vprooOsLk3QsP/kqulnAFAxJ1Aypck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=USoR8eU3; arc=none smtp.client-ip=91.218.175.172
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784103794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yWiQvOiX+Bg27MtnHGvpBDMG36SjZtJuIrt7mr7Z8kI=;
	b=USoR8eU3YnBFK2C3Zw8/+jGfZI+pyTqZ0OqWKFsjWrXhT08MaDgYmkss0psvEWMbnAs1PS
	FDX6r7w84TXGae+N2+kUeu1R7LlLECeE/xsj7KlnxQAvdRU82lDsrehKJH/hvLSpLsG0Vy
	fXh5Y74087L/xLaLxMpXmwk2jRkfeZc=
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: jgg@ziepe.ca,
	leon@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	chenguang.zhao@linux.dev,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	dtatulea@nvidia.com,
	shayd@nvidia.com,
	moshe@nvidia.com,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH rdma-next v3] RDMA/mlx5: quiesce CQ polling before device shutdown on reboot
Date: Wed, 15 Jul 2026 16:23:07 +0800
Message-Id: <20260715082307.1593915-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-23260-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[chenguang.zhao@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-rdma@vger.kernel.org,m:netdev@vger.kernel.org,m:chenguang.zhao@linux.dev,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:dtatulea@nvidia.com,m:shayd@nvidia.com,m:moshe@nvidia.com,m:zhaochenguang@kylinos.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenguang.zhao@linux.dev,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 521B075BD54

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

On reboot -f with NFS over RDMA, mlx5 shutdown can tear the device
down while ib-comp-wq still polls live CQs, leading to UAF in
wr_cqe->done().

Mark the device shutting down before teardown, flush completion
workqueues so in-flight pollers observe the flag, skip SYS_ERROR
completion delivery, and make poll/arm CQ a no-op under the CQ lock
while shutting down.

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
changelog:
 - Fix the race on MLX5_INTERFACE_STATE_SHUTTING_DOWN: set the
   flag, then flush ib-comp / mlx5_ib event workqueues via an
   mlx5_ib quiesce hook before fast_unload/teardown.
 - Check shutting-down under cq->lock in mlx5_ib_poll_cq/arm_cq.
 - Export ib_comp_wq and ib_comp_unbound_wq so modular mlx5_ib
   can flush them.

v2:
 https://lore.kernel.org/all/20260714075558.1420384-1-chenguang.zhao@linux.dev/

v1:
 https://lore.kernel.org/all/20260702073422.279820-1-chenguang.zhao@linux.dev/

 drivers/infiniband/core/device.c              |  2 ++
 drivers/infiniband/hw/mlx5/cq.c               | 11 ++++++++++
 drivers/infiniband/hw/mlx5/main.c             | 20 +++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/health.c  |  3 +++
 .../net/ethernet/mellanox/mlx5/core/main.c    | 10 ++++++++++
 .../mellanox/mlx5/core/sf/dev/driver.c        |  3 +++
 include/linux/mlx5/driver.h                   | 11 ++++++++++
 7 files changed, 60 insertions(+)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index b8193e077a74..6c3377bd53df 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -56,7 +56,9 @@ MODULE_DESCRIPTION("core kernel InfiniBand API");
 MODULE_LICENSE("Dual BSD/GPL");
 
 struct workqueue_struct *ib_comp_wq;
+EXPORT_SYMBOL_GPL(ib_comp_wq);
 struct workqueue_struct *ib_comp_unbound_wq;
+EXPORT_SYMBOL_GPL(ib_comp_unbound_wq);
 struct workqueue_struct *ib_wq;
 EXPORT_SYMBOL_GPL(ib_wq);
 static struct workqueue_struct *ib_unreg_wq;
diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index 49b4bf148a4a..5d951c186cb3 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -619,6 +619,10 @@ int mlx5_ib_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc)
 	int npolled;
 
 	spin_lock_irqsave(&cq->lock, flags);
+	if (mlx5_core_is_shutting_down(mdev)) {
+		spin_unlock_irqrestore(&cq->lock, flags);
+		return 0;
+	}
 	if (mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR) {
 		/* make sure no soft wqe's are waiting */
 		if (unlikely(!list_empty(&cq->wc_list)))
@@ -654,6 +658,10 @@ int mlx5_ib_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags)
 	int ret = 0;
 
 	spin_lock_irqsave(&cq->lock, irq_flags);
+	if (mlx5_core_is_shutting_down(mdev)) {
+		spin_unlock_irqrestore(&cq->lock, irq_flags);
+		return 0;
+	}
 	if (cq->notify_flags != IB_CQ_NEXT_COMP)
 		cq->notify_flags = flags & IB_CQ_SOLICITED_MASK;
 
@@ -661,6 +669,9 @@ int mlx5_ib_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags)
 		ret = 1;
 	spin_unlock_irqrestore(&cq->lock, irq_flags);
 
+	if (mlx5_core_is_shutting_down(mdev))
+		return ret;
+
 	mlx5_cq_arm(&cq->mcq,
 		    (flags & IB_CQ_SOLICITED_MASK) == IB_CQ_SOLICITED ?
 		    MLX5_CQ_DB_REQ_NOT_SOL : MLX5_CQ_DB_REQ_NOT,
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 02809114fc79..dfc805892684 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -84,6 +84,13 @@ static LIST_HEAD(mlx5_ib_dev_list);
  */
 static DEFINE_MUTEX(mlx5_ib_multiport_mutex);
 
+static void mlx5_ib_shutdown_quiesce(void)
+{
+	flush_workqueue(ib_comp_wq);
+	flush_workqueue(ib_comp_unbound_wq);
+	flush_workqueue(mlx5_ib_event_wq);
+}
+
 struct mlx5_ib_dev *mlx5_ib_get_ibdev_from_mpi(struct mlx5_ib_multiport_info *mpi)
 {
 	struct mlx5_ib_dev *dev;
@@ -2976,6 +2983,9 @@ static void mlx5_ib_handle_internal_error(struct mlx5_ib_dev *ibdev)
 	unsigned long flags_cq;
 	unsigned long flags;
 
+	if (mlx5_core_is_shutting_down(ibdev->mdev))
+		return;
+
 	INIT_LIST_HEAD(&cq_armed_list);
 
 	/* Go over qp list reside on that ibdev, sync with create/destroy qp.*/
@@ -3200,6 +3210,9 @@ static void mlx5_ib_handle_sys_error_event(struct work_struct *_work)
 	struct mlx5_ib_dev *ibdev = work->dev;
 	struct ib_event ibev;
 
+	if (mlx5_core_is_shutting_down(ibdev->mdev))
+		goto out;
+
 	ibev.event = IB_EVENT_DEVICE_FATAL;
 	mlx5_ib_handle_internal_error(ibdev);
 	ibev.element.port_num = (u8)(unsigned long)work->param;
@@ -3222,10 +3235,15 @@ static int mlx5_ib_sys_error_event(struct notifier_block *nb,
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
@@ -5529,6 +5547,7 @@ static int __init mlx5_ib_init(void)
 	if (ret)
 		goto drv_err;
 
+	mlx5_rdma_shutdown_quiesce = mlx5_ib_shutdown_quiesce;
 	return 0;
 
 drv_err:
@@ -5547,6 +5566,7 @@ static int __init mlx5_ib_init(void)
 
 static void __exit mlx5_ib_cleanup(void)
 {
+	mlx5_rdma_shutdown_quiesce = NULL;
 	mlx5_data_direct_driver_unregister();
 	auxiliary_driver_unregister(&mlx5r_driver);
 	auxiliary_driver_unregister(&mlx5r_mp_driver);
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
index 643b4aac2033..51de0b4570aa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -2186,12 +2186,22 @@ static int mlx5_try_fast_unload(struct mlx5_core_dev *dev)
 	return 0;
 }
 
+void (*mlx5_rdma_shutdown_quiesce)(void);
+EXPORT_SYMBOL_GPL(mlx5_rdma_shutdown_quiesce);
+
 static void shutdown(struct pci_dev *pdev)
 {
 	struct mlx5_core_dev *dev  = pci_get_drvdata(pdev);
 	int err;
 
 	mlx5_core_info(dev, "Shutdown was called\n");
+	set_bit(MLX5_INTERFACE_STATE_SHUTTING_DOWN, &dev->intf_state);
+	/*
+	 * Ensure in-flight CQ pollers observe SHUTTING_DOWN before
+	 * fast_unload tears the device down.
+	 */
+	if (mlx5_rdma_shutdown_quiesce)
+		mlx5_rdma_shutdown_quiesce();
 	set_bit(MLX5_BREAK_FW_WAIT, &dev->intf_state);
 	mlx5_drain_fw_reset(dev);
 	mlx5_drain_health_wq(dev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
index 4391ef0bab5d..d9735e492971 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
@@ -111,6 +111,9 @@ static void mlx5_sf_dev_shutdown(struct auxiliary_device *adev)
 	struct mlx5_sf_dev *sf_dev = container_of(adev, struct mlx5_sf_dev, adev);
 	struct mlx5_core_dev *mdev = sf_dev->mdev;
 
+	set_bit(MLX5_INTERFACE_STATE_SHUTTING_DOWN, &mdev->intf_state);
+	if (mlx5_rdma_shutdown_quiesce)
+		mlx5_rdma_shutdown_quiesce();
 	set_bit(MLX5_BREAK_FW_WAIT, &mdev->intf_state);
 	mlx5_drain_health_wq(mdev);
 	mlx5_unload_one(mdev, false);
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index b1871c0821d0..d81d13169828 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -653,8 +653,14 @@ enum mlx5_device_state {
 enum mlx5_interface_state {
 	MLX5_INTERFACE_STATE_UP = BIT(0),
 	MLX5_BREAK_FW_WAIT = BIT(1),
+	MLX5_INTERFACE_STATE_SHUTTING_DOWN = BIT(2),
 };
 
+/* Optional hook installed by mlx5_ib to flush CQ poll work after the
+ * SHUTTING_DOWN flag is set and before teardown continues.
+ */
+extern void (*mlx5_rdma_shutdown_quiesce)(void);
+
 enum mlx5_pci_status {
 	MLX5_PCI_STATUS_DISABLED,
 	MLX5_PCI_STATUS_ENABLED,
@@ -1220,6 +1226,11 @@ static inline bool mlx5_core_is_pf(const struct mlx5_core_dev *dev)
 	return dev->coredev_type == MLX5_COREDEV_PF;
 }
 
+static inline bool mlx5_core_is_shutting_down(struct mlx5_core_dev *dev)
+{
+	return test_bit(MLX5_INTERFACE_STATE_SHUTTING_DOWN, &dev->intf_state);
+}
+
 static inline bool mlx5_core_is_vf(const struct mlx5_core_dev *dev)
 {
 	return dev->coredev_type == MLX5_COREDEV_VF;
-- 
2.25.1


