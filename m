Return-Path: <linux-rdma+bounces-13336-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3907CB55FBB
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Sep 2025 11:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6FDE1B26D8E
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Sep 2025 09:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0631F2EAB61;
	Sat, 13 Sep 2025 09:06:30 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4DD2EA173
	for <linux-rdma@vger.kernel.org>; Sat, 13 Sep 2025 09:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757754389; cv=none; b=ZkI3C3GcDoyptVC3pbKWMmQ0TiXcIHPLSf65bl+s39xaqN/EcIX8jHzLP5kHquRgxs268SBObLTsW5U6+yWCWzsMAc3pNZzbD6CEKNyyksdeD7oAu1wCra+3clUdZW1LfaMhr3mAKClZF+QePk0q1Tpkm8DuQHVpG1RuzFE8FTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757754389; c=relaxed/simple;
	bh=TiMu1cR8V7FRKuFhtcuvbWSa9n05TXhBCCgy0q4pj6U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BYXwxBN1PjIH9KjCPNcIkvHdf1heRgsyZT9nzhJSfb4uhHyHSbqyhsQmi2KL9C3Vd3yvJjJ6mi7w4E7z/3EKnm98pmbf31q/lTrUA2sukCifhSXV22n1p/O+l/X4tJ3HHqLV1mpTWE9F4u+6Qlsxnt+L1ANqoX6PegsHvkTMcIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cP4zT5btwzQlMp;
	Sat, 13 Sep 2025 17:01:41 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id D0CE414027A;
	Sat, 13 Sep 2025 17:06:17 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 13 Sep 2025 17:06:17 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-next 5/8] RDMA/hns: Implement bonding init/uninit process
Date: Sat, 13 Sep 2025 17:06:12 +0800
Message-ID: <20250913090615.212720-6-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250913090615.212720-1-huangjunxian6@hisilicon.com>
References: <20250913090615.212720-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100018.china.huawei.com (7.202.181.17)

Implement hns_roce_slave_init() and hns_roce_slave_uninit() for device
init/uninit in bonding cases. The former is used to initialize a slave
ibdev (when the slave is unlinked from a bond) or a bond ibdev, while
the latter does the opposite. Most of the process is the same as
regular device init/uninit, while some bonding‑specific steps below are
also added.

In bond device init flow, choose one slave to re-initialize as the
main_hr_dev of the bond, and it will be the only device presented for
multiple slaves. During registration, set and active netdev to the
ibdev based on the link state of the slaves. When this main_hr_dev
slave is being unlinked while the bond is still valid, choose a new
slave from the rest and initialize it as the new bond device.

In uninit flow, add a bond cleanup process, restore all the other
slaves and clean up bond resource. This is only for the case where
the port of main_hr_dev is directly removed without unlinking it
from bond.

Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_bond.c   | 178 ++++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_bond.h   |   6 +
 drivers/infiniband/hw/hns/hns_roce_device.h |   3 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  41 ++++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   5 +
 drivers/infiniband/hw/hns/hns_roce_main.c   |  67 ++++++--
 6 files changed, 283 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_bond.c b/drivers/infiniband/hw/hns/hns_roce_bond.c
index 5fee44bcf81d..d6fce23501b4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_bond.c
+++ b/drivers/infiniband/hw/hns/hns_roce_bond.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2025 Hisilicon Limited.
  */
 
+#include <net/bonding.h>
 #include "hns_roce_device.h"
 #include "hns_roce_hw_v2.h"
 #include "hns_roce_bond.h"
@@ -71,6 +72,143 @@ struct hns_roce_bond_group *hns_roce_get_bond_grp(struct net_device *net_dev,
 	return NULL;
 }
 
+static int hns_roce_set_bond_netdev(struct hns_roce_bond_group *bond_grp,
+				    struct hns_roce_dev *hr_dev)
+{
+	struct net_device *active_dev;
+	struct net_device *old_dev;
+	int i, ret = 0;
+
+	if (bond_grp->tx_type == NETDEV_LAG_TX_TYPE_ACTIVEBACKUP) {
+		rcu_read_lock();
+		active_dev =
+			bond_option_active_slave_get_rcu(netdev_priv(bond_grp->upper_dev));
+		rcu_read_unlock();
+	} else {
+		for (i = 0; i < ROCE_BOND_FUNC_MAX; i++) {
+			active_dev = bond_grp->bond_func_info[i].net_dev;
+			if (active_dev &&
+			    ib_get_curr_port_state(active_dev) == IB_PORT_ACTIVE)
+				break;
+		}
+	}
+
+	if (!active_dev || i == ROCE_BOND_FUNC_MAX)
+		active_dev = get_hr_netdev(hr_dev, 0);
+
+	old_dev = ib_device_get_netdev(&hr_dev->ib_dev, 1);
+	if (old_dev == active_dev)
+		goto out;
+
+	ret = ib_device_set_netdev(&hr_dev->ib_dev, active_dev, 1);
+	if (ret) {
+		dev_err(hr_dev->dev, "failed to set netdev for bond.\n");
+		goto out;
+	}
+
+	if (bond_grp->tx_type == NETDEV_LAG_TX_TYPE_ACTIVEBACKUP) {
+		if (old_dev)
+			roce_del_all_netdev_gids(&hr_dev->ib_dev, 1, old_dev);
+		rdma_roce_rescan_port(&hr_dev->ib_dev, 1);
+	}
+out:
+	dev_put(old_dev);
+	return ret;
+}
+
+bool hns_roce_bond_is_active(struct hns_roce_dev *hr_dev)
+{
+	struct net_device *net_dev = get_hr_netdev(hr_dev, 0);
+	struct hns_roce_bond_group *bond_grp;
+	u8 bus_num = get_hr_bus_num(hr_dev);
+
+	bond_grp = hns_roce_get_bond_grp(net_dev, bus_num);
+	if (bond_grp && bond_grp->bond_state != HNS_ROCE_BOND_NOT_BONDED &&
+	    bond_grp->bond_state != HNS_ROCE_BOND_NOT_ATTACHED)
+		return true;
+
+	return false;
+}
+
+static void hns_roce_slave_uninit(struct hns_roce_bond_group *bond_grp,
+				  u8 func_idx)
+{
+	struct hnae3_handle *handle;
+
+	handle = bond_grp->bond_func_info[func_idx].handle;
+	if (handle->priv)
+		hns_roce_bond_uninit_client(bond_grp, func_idx);
+}
+
+static struct hns_roce_dev
+	*hns_roce_slave_init(struct hns_roce_bond_group *bond_grp,
+			     u8 func_idx, bool need_switch);
+
+static int switch_main_dev(struct hns_roce_bond_group *bond_grp,
+			   u8 main_func_idx)
+{
+	struct hns_roce_dev *hr_dev;
+	struct net_device *net_dev;
+	u8 i;
+
+	bond_grp->main_hr_dev = NULL;
+	hns_roce_bond_uninit_client(bond_grp, main_func_idx);
+
+	for (i = 0; i < ROCE_BOND_FUNC_MAX; i++) {
+		net_dev = bond_grp->bond_func_info[i].net_dev;
+		if ((bond_grp->slave_map & (1U << i)) && net_dev) {
+			/* In case this slave is still being registered as
+			 * a non-bonded PF, uninit it first and then re-init
+			 * it as the main device.
+			 */
+			hns_roce_slave_uninit(bond_grp, i);
+			hr_dev = hns_roce_slave_init(bond_grp, i, false);
+			if (hr_dev) {
+				bond_grp->main_hr_dev = hr_dev;
+				break;
+			}
+		}
+	}
+
+	if (!bond_grp->main_hr_dev)
+		return -ENODEV;
+
+	return 0;
+}
+
+static struct hns_roce_dev
+	*hns_roce_slave_init(struct hns_roce_bond_group *bond_grp,
+			     u8 func_idx, bool need_switch)
+{
+	struct hns_roce_dev *hr_dev = NULL;
+	struct hnae3_handle *handle;
+	u8 main_func_idx;
+	int ret;
+
+	if (need_switch) {
+		main_func_idx = PCI_FUNC(bond_grp->main_hr_dev->pci_dev->devfn);
+		if (func_idx == main_func_idx) {
+			ret = switch_main_dev(bond_grp, main_func_idx);
+			if (ret == -ENODEV)
+				return NULL;
+		}
+	}
+
+	handle = bond_grp->bond_func_info[func_idx].handle;
+	if (handle) {
+		if (handle->priv)
+			return handle->priv;
+		/* Prevent this device from being initialized as a bond device */
+		if (need_switch)
+			bond_grp->bond_func_info[func_idx].net_dev = NULL;
+		hr_dev = hns_roce_bond_init_client(bond_grp, func_idx);
+		if (!hr_dev)
+			BOND_ERR_LOG("failed to init slave %u.\n", func_idx);
+	}
+
+	return hr_dev;
+}
+
 static struct hns_roce_die_info *alloc_die_info(int bus_num)
 {
 	struct hns_roce_die_info *die_info;
@@ -194,6 +332,35 @@ static void hns_roce_attach_bond_grp(struct hns_roce_bond_group *bond_grp,
 	bond_grp->bond_ready = false;
 }
 
+static void hns_roce_detach_bond_grp(struct hns_roce_bond_group *bond_grp)
+{
+	mutex_lock(&bond_grp->bond_mutex);
+
+	bond_grp->upper_dev = NULL;
+	bond_grp->main_hr_dev = NULL;
+	bond_grp->bond_ready = false;
+	bond_grp->bond_state = HNS_ROCE_BOND_NOT_ATTACHED;
+	bond_grp->slave_map = 0;
+	memset(bond_grp->bond_func_info, 0, sizeof(bond_grp->bond_func_info));
+
+	mutex_unlock(&bond_grp->bond_mutex);
+}
+
+void hns_roce_cleanup_bond(struct hns_roce_bond_group *bond_grp)
+{
+	int ret;
+
+	ret = bond_grp->main_hr_dev ?
+	      hns_roce_cmd_bond(bond_grp, HNS_ROCE_CLEAR_BOND) : -EIO;
+	if (ret)
+		BOND_ERR_LOG("failed to clear RoCE bond, ret = %d.\n", ret);
+	else
+		ibdev_info(&bond_grp->main_hr_dev->ib_dev,
+			   "RoCE clear bond finished!\n");
+
+	hns_roce_detach_bond_grp(bond_grp);
+}
+
 static bool lowerstate_event_filter(struct hns_roce_bond_group *bond_grp,
 				    struct net_device *net_dev)
 {
@@ -489,3 +656,14 @@ void hns_roce_dealloc_bond_grp(void)
 		}
 	}
 }
+
+int hns_roce_bond_init(struct hns_roce_dev *hr_dev)
+{
+	struct net_device *net_dev = get_hr_netdev(hr_dev, 0);
+	struct hns_roce_bond_group *bond_grp;
+	u8 bus_num = get_hr_bus_num(hr_dev);
+
+	bond_grp = hns_roce_get_bond_grp(net_dev, bus_num);
+
+	return hns_roce_set_bond_netdev(bond_grp, hr_dev);
+}
diff --git a/drivers/infiniband/hw/hns/hns_roce_bond.h b/drivers/infiniband/hw/hns/hns_roce_bond.h
index 84c94cbc397d..3ef7d28379cc 100644
--- a/drivers/infiniband/hw/hns/hns_roce_bond.h
+++ b/drivers/infiniband/hw/hns/hns_roce_bond.h
@@ -14,6 +14,9 @@
 
 #define BOND_ID(id) BIT(id)
 
+#define BOND_ERR_LOG(fmt, ...)				\
+	pr_err("HNS RoCE Bonding: " fmt, ##__VA_ARGS__)
+
 enum {
 	BOND_MODE_1,
 	BOND_MODE_2_4,
@@ -80,5 +83,8 @@ struct hns_roce_bond_group *hns_roce_get_bond_grp(struct net_device *net_dev,
 						  u8 bus_num);
 int hns_roce_alloc_bond_grp(struct hns_roce_dev *hr_dev);
 void hns_roce_dealloc_bond_grp(void);
+void hns_roce_cleanup_bond(struct hns_roce_bond_group *bond_grp);
+bool hns_roce_bond_is_active(struct hns_roce_dev *hr_dev);
+int hns_roce_bond_init(struct hns_roce_dev *hr_dev);
 
 #endif
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index cc1402fc8943..0add49d9664b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -179,6 +179,7 @@ enum hns_roce_instance_state {
 	HNS_ROCE_STATE_INIT,
 	HNS_ROCE_STATE_INITED,
 	HNS_ROCE_STATE_UNINIT,
+	HNS_ROCE_STATE_BOND_UNINIT,
 };
 
 enum {
@@ -1304,7 +1305,7 @@ void hns_roce_flush_cqe(struct hns_roce_dev *hr_dev, u32 qpn);
 void hns_roce_srq_event(struct hns_roce_dev *hr_dev, u32 srqn, int event_type);
 void hns_roce_handle_device_err(struct hns_roce_dev *hr_dev);
 int hns_roce_init(struct hns_roce_dev *hr_dev);
-void hns_roce_exit(struct hns_roce_dev *hr_dev);
+void hns_roce_exit(struct hns_roce_dev *hr_dev, bool bond_cleanup);
 int hns_roce_fill_res_cq_entry(struct sk_buff *msg, struct ib_cq *ib_cq);
 int hns_roce_fill_res_cq_entry_raw(struct sk_buff *msg, struct ib_cq *ib_cq);
 int hns_roce_fill_res_qp_entry(struct sk_buff *msg, struct ib_qp *ib_qp);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index d3c1ad04afd7..4c43e930e0d0 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -7173,7 +7173,7 @@ static int __hns_roce_hw_v2_init_instance(struct hnae3_handle *handle)
 }
 
 static void __hns_roce_hw_v2_uninit_instance(struct hnae3_handle *handle,
-					   bool reset)
+					   bool reset, bool bond_cleanup)
 {
 	struct hns_roce_dev *hr_dev = handle->priv;
 
@@ -7185,7 +7185,7 @@ static void __hns_roce_hw_v2_uninit_instance(struct hnae3_handle *handle,
 	hr_dev->state = HNS_ROCE_DEVICE_STATE_UNINIT;
 	hns_roce_handle_device_err(hr_dev);
 
-	hns_roce_exit(hr_dev);
+	hns_roce_exit(hr_dev, bond_cleanup);
 	kfree(hr_dev->priv);
 	ib_dealloc_device(&hr_dev->ib_dev);
 }
@@ -7241,7 +7241,40 @@ static void hns_roce_hw_v2_uninit_instance(struct hnae3_handle *handle,
 
 	handle->rinfo.instance_state = HNS_ROCE_STATE_UNINIT;
 
-	__hns_roce_hw_v2_uninit_instance(handle, reset);
+	__hns_roce_hw_v2_uninit_instance(handle, reset, true);
+
+	handle->rinfo.instance_state = HNS_ROCE_STATE_NON_INIT;
+}
+
+struct hns_roce_dev
+	*hns_roce_bond_init_client(struct hns_roce_bond_group *bond_grp,
+				   int func_idx)
+{
+	struct hnae3_handle *handle;
+	int ret;
+
+	handle = bond_grp->bond_func_info[func_idx].handle;
+	if (!handle || !handle->client)
+		return NULL;
+
+	ret = hns_roce_hw_v2_init_instance(handle);
+	if (ret)
+		return NULL;
+
+	return handle->priv;
+}
+
+void hns_roce_bond_uninit_client(struct hns_roce_bond_group *bond_grp,
+				 int func_idx)
+{
+	struct hnae3_handle *handle = bond_grp->bond_func_info[func_idx].handle;
+
+	if (handle->rinfo.instance_state != HNS_ROCE_STATE_INITED)
+		return;
+
+	handle->rinfo.instance_state = HNS_ROCE_STATE_BOND_UNINIT;
+
+	__hns_roce_hw_v2_uninit_instance(handle, false, false);
 
 	handle->rinfo.instance_state = HNS_ROCE_STATE_NON_INIT;
 }
@@ -7310,7 +7343,7 @@ static int hns_roce_hw_v2_reset_notify_uninit(struct hnae3_handle *handle)
 	handle->rinfo.reset_state = HNS_ROCE_STATE_RST_UNINIT;
 	dev_info(&handle->pdev->dev, "In reset process RoCE client uninit.\n");
 	msleep(HNS_ROCE_V2_HW_RST_UNINT_DELAY);
-	__hns_roce_hw_v2_uninit_instance(handle, false);
+	__hns_roce_hw_v2_uninit_instance(handle, false, false);
 
 	return 0;
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 82cec4b38c92..285fe0875fac 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -1478,6 +1478,11 @@ struct hns_roce_bond_info {
 	__le32 hash_policy;
 };
 
+struct hns_roce_dev
+	*hns_roce_bond_init_client(struct hns_roce_bond_group *bond_grp,
+				   int func_idx);
+void hns_roce_bond_uninit_client(struct hns_roce_bond_group *bond_grp,
+				 int func_idx);
 int hns_roce_v2_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata);
 int hns_roce_cmd_bond(struct hns_roce_bond_group *bond_grp,
 		      enum hns_roce_bond_cmd_type bond_type);
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 7fa25586ccd8..f7ef563d8239 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -614,9 +614,41 @@ static int hns_roce_get_hw_stats(struct ib_device *device,
 	return num_counters;
 }
 
-static void hns_roce_unregister_device(struct hns_roce_dev *hr_dev)
+static void
+	hns_roce_unregister_bond_cleanup(struct hns_roce_dev *hr_dev,
+					 struct hns_roce_bond_group *bond_grp)
 {
+	struct net_device *net_dev;
+	int i;
+
+	/* To avoid the loss of other slave devices when main_hr_dev
+	 * is unregistered, re-initialize the remaining slaves before
+	 * the bond resources cleanup.
+	 */
+	bond_grp->bond_state = HNS_ROCE_BOND_NOT_BONDED;
+	for (i = 0; i < ROCE_BOND_FUNC_MAX; i++) {
+		net_dev = bond_grp->bond_func_info[i].net_dev;
+		if (net_dev && net_dev != get_hr_netdev(hr_dev, 0))
+			hns_roce_bond_init_client(bond_grp, i);
+	}
+
+	hns_roce_cleanup_bond(bond_grp);
+}
+
+static void hns_roce_unregister_device(struct hns_roce_dev *hr_dev,
+				       bool bond_cleanup)
+{
+	struct net_device *net_dev = get_hr_netdev(hr_dev, 0);
 	struct hns_roce_ib_iboe *iboe = &hr_dev->iboe;
+	struct hns_roce_bond_group *bond_grp;
+	u8 bus_num = get_hr_bus_num(hr_dev);
+	int i;
+
+	if (bond_cleanup && hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_BOND) {
+		bond_grp = hns_roce_get_bond_grp(net_dev, bus_num);
+		if (bond_grp)
+			hns_roce_unregister_bond_cleanup(hr_dev, bond_grp);
+	}
 
 	hr_dev->active = false;
 	unregister_netdevice_notifier(&iboe->nb);
@@ -746,6 +778,8 @@ static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
 	ib_set_device_ops(ib_dev, &hns_roce_dev_ops);
 	ib_set_device_ops(ib_dev, &hns_roce_dev_restrack_ops);
 
+	dma_set_max_seg_size(dev, SZ_2G);
+
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_BOND) {
 		ret = hns_roce_alloc_bond_grp(hr_dev);
 		if (ret) {
@@ -755,17 +789,26 @@ static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
 		}
 	}
 
-	for (i = 0; i < hr_dev->caps.num_ports; i++) {
-		net_dev = get_hr_netdev(hr_dev, i);
-		if (!net_dev)
-			continue;
-
-		ret = ib_device_set_netdev(ib_dev, net_dev, i + 1);
-		if (ret)
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_BOND &&
+	    hns_roce_bond_is_active(hr_dev)) {
+		ret = hns_roce_bond_init(hr_dev);
+		if (ret) {
+			dev_err(dev, "failed to init bond!\n");
 			return ret;
+		}
+		ret = ib_register_device(ib_dev, "hns_bond_%d", dev);
+	} else {
+		for (i = 0; i < hr_dev->caps.num_ports; i++) {
+			net_dev = get_hr_netdev(hr_dev, i);
+			if (!net_dev)
+				continue;
+
+			ret = ib_device_set_netdev(ib_dev, net_dev, i + 1);
+			if (ret)
+				return ret;
+		}
+		ret = ib_register_device(ib_dev, "hns_%d", dev);
 	}
-	dma_set_max_seg_size(dev, SZ_2G);
-	ret = ib_register_device(ib_dev, "hns_%d", dev);
 	if (ret) {
 		dev_err(dev, "ib_register_device failed!\n");
 		return ret;
@@ -1165,10 +1208,10 @@ int hns_roce_init(struct hns_roce_dev *hr_dev)
 	return ret;
 }
 
-void hns_roce_exit(struct hns_roce_dev *hr_dev)
+void hns_roce_exit(struct hns_roce_dev *hr_dev, bool bond_cleanup)
 {
 	hns_roce_unregister_debugfs(hr_dev);
-	hns_roce_unregister_device(hr_dev);
+	hns_roce_unregister_device(hr_dev, bond_cleanup);
 
 	if (hr_dev->hw->hw_exit)
 		hr_dev->hw->hw_exit(hr_dev);
-- 
2.33.0


