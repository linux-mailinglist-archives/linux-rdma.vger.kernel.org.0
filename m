Return-Path: <linux-rdma+bounces-13894-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFEABE3A93
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 15:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD6371A655A4
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 13:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CF11F582C;
	Thu, 16 Oct 2025 13:20:32 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1EA1E32D7
	for <linux-rdma@vger.kernel.org>; Thu, 16 Oct 2025 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760620832; cv=none; b=QS34r7lcj0hFL/yR+B2FahXMqp5UXJ/2MrbFUHo/daXk9YXe5oyHCtr9zwxkPCfYMAQk7h4u/HjPQjeJCxkDpLnRnNkqxZHcNcJnHVV2c9r1QsQAmi+DCr5VqvrNI8qZ2Pr9EItwJFNZuSD/Qw6n+z488wlEVoocp2GR4uvNOgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760620832; c=relaxed/simple;
	bh=uujRavuvQIgdonQP4g2L0pc50jIfelMH3PHbYaHonjc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uo69UdVoB1bZxTvlcsSI+qkiSeasCYpGTb6DvQs4+e20kSkJji9OHRFpC7Z9NS84YEItwBBdiyoxKQxJyoqJWIFDYIfKXI3VL0/z/xijm1n1yyZAyK9cN2k8s7Oob2ReSa6CUyXnvAWcMiNRmcuiNTqdlHRoDy9IN9N1RhPtS00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4cnT7y55Dcz12LDs;
	Thu, 16 Oct 2025 21:19:42 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 2C82D140257;
	Thu, 16 Oct 2025 21:20:27 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Oct 2025 21:20:26 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH v2 for-next 6/8] RDMA/hns: Add delayed work for bonding
Date: Thu, 16 Oct 2025 21:20:21 +0800
Message-ID: <20251016132023.3043538-7-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251016132023.3043538-1-huangjunxian6@hisilicon.com>
References: <20251016132023.3043538-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100018.china.huawei.com (7.202.181.17)

When conditions are met, schedule a delayed work in bond event handler
to perform bonding operation according to the bond state. In the case
of changing slave number or link state, re-set the netdev for the bond
ibdev after the modification is complete, since these two operations
may not call hns_roce_set_bond_netdev() in hns_roce_init().

The delayed work will be paused when there is a driver reset or exit
to avoid concurrency.

Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_bond.c  | 308 +++++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_bond.h  |   5 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |  13 +-
 3 files changed, 325 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_bond.c b/drivers/infiniband/hw/hns/hns_roce_bond.c
index e09fe7ef16ee..0604ee55011e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_bond.c
+++ b/drivers/infiniband/hw/hns/hns_roce_bond.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2025 Hisilicon Limited.
  */
 
+#include <net/lag.h>
 #include <net/bonding.h>
 #include "hns_roce_device.h"
 #include "hns_roce_hw_v2.h"
@@ -133,6 +134,32 @@ bool hns_roce_bond_is_active(struct hns_roce_dev *hr_dev)
 	return false;
 }
 
+static void hns_roce_bond_get_active_slave(struct hns_roce_bond_group *bond_grp)
+{
+	struct net_device *net_dev;
+	u32 active_slave_map = 0;
+	u8 active_slave_num = 0;
+	bool active;
+	u8 i;
+
+	for (i = 0; i < ROCE_BOND_FUNC_MAX; i++) {
+		net_dev = bond_grp->bond_func_info[i].net_dev;
+		if (!net_dev || !(bond_grp->slave_map & (1U << i)))
+			continue;
+
+		active = (bond_grp->tx_type == NETDEV_LAG_TX_TYPE_ACTIVEBACKUP) ?
+			 net_lag_port_dev_txable(net_dev) :
+			 (ib_get_curr_port_state(net_dev) == IB_PORT_ACTIVE);
+		if (active) {
+			active_slave_num++;
+			active_slave_map |= (1U << i);
+		}
+	}
+
+	bond_grp->active_slave_num = active_slave_num;
+	bond_grp->active_slave_map = active_slave_map;
+}
+
 static void hns_roce_slave_uninit(struct hns_roce_bond_group *bond_grp,
 				  u8 func_idx)
 {
@@ -227,11 +254,14 @@ static struct hns_roce_die_info *alloc_die_info(int bus_num)
 		return NULL;
 	}
 
+	mutex_init(&die_info->die_mutex);
+
 	return die_info;
 }
 
 static void dealloc_die_info(struct hns_roce_die_info *die_info, u8 bus_num)
 {
+	mutex_destroy(&die_info->die_mutex);
 	xa_erase(&roce_bond_xa, bus_num);
 	kfree(die_info);
 }
@@ -280,6 +310,168 @@ static int remove_bond_id(int bus_num, u8 bond_id)
 	return 0;
 }
 
+static void hns_roce_set_bond(struct hns_roce_bond_group *bond_grp)
+{
+	struct hns_roce_dev *hr_dev;
+	int ret;
+	int i;
+
+	for (i = ROCE_BOND_FUNC_MAX - 1; i >= 0; i--) {
+		if (bond_grp->slave_map & (1 << i))
+			hns_roce_slave_uninit(bond_grp, i);
+	}
+
+	mutex_lock(&bond_grp->bond_mutex);
+	bond_grp->bond_state = HNS_ROCE_BOND_IS_BONDED;
+	mutex_unlock(&bond_grp->bond_mutex);
+	bond_grp->main_hr_dev = NULL;
+
+	for (i = 0; i < ROCE_BOND_FUNC_MAX; i++) {
+		if (bond_grp->slave_map & (1 << i)) {
+			hr_dev = hns_roce_slave_init(bond_grp, i, false);
+			if (hr_dev) {
+				bond_grp->main_hr_dev = hr_dev;
+				break;
+			}
+		}
+	}
+
+	if (!bond_grp->main_hr_dev) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	hns_roce_bond_get_active_slave(bond_grp);
+
+	ret = hns_roce_cmd_bond(bond_grp, HNS_ROCE_SET_BOND);
+
+out:
+	if (ret) {
+		BOND_ERR_LOG("failed to set RoCE bond, ret = %d.\n", ret);
+		hns_roce_cleanup_bond(bond_grp);
+	} else {
+		ibdev_info(&bond_grp->main_hr_dev->ib_dev,
+			   "RoCE set bond finished!\n");
+	}
+}
+
+static void hns_roce_clear_bond(struct hns_roce_bond_group *bond_grp)
+{
+	u8 main_func_idx = PCI_FUNC(bond_grp->main_hr_dev->pci_dev->devfn);
+	struct hns_roce_dev *hr_dev;
+	u8 i;
+
+	if (bond_grp->bond_state == HNS_ROCE_BOND_NOT_BONDED)
+		goto out;
+
+	bond_grp->bond_state = HNS_ROCE_BOND_NOT_BONDED;
+	bond_grp->main_hr_dev = NULL;
+
+	hns_roce_slave_uninit(bond_grp, main_func_idx);
+
+	for (i = 0; i < ROCE_BOND_FUNC_MAX; i++) {
+		hr_dev = hns_roce_slave_init(bond_grp, i, false);
+		if (hr_dev)
+			bond_grp->main_hr_dev = hr_dev;
+	}
+
+out:
+	hns_roce_cleanup_bond(bond_grp);
+}
+
+static void hns_roce_slave_changestate(struct hns_roce_bond_group *bond_grp)
+{
+	int ret;
+
+	hns_roce_bond_get_active_slave(bond_grp);
+
+	ret = hns_roce_cmd_bond(bond_grp, HNS_ROCE_CHANGE_BOND);
+
+	mutex_lock(&bond_grp->bond_mutex);
+	if (bond_grp->bond_state == HNS_ROCE_BOND_SLAVE_CHANGESTATE)
+		bond_grp->bond_state = HNS_ROCE_BOND_IS_BONDED;
+	mutex_unlock(&bond_grp->bond_mutex);
+
+	if (ret)
+		ibdev_err(&bond_grp->main_hr_dev->ib_dev,
+			  "failed to change RoCE bond slave state, ret = %d.\n",
+			  ret);
+	else
+		ibdev_info(&bond_grp->main_hr_dev->ib_dev,
+			   "RoCE slave changestate finished!\n");
+}
+
+static void hns_roce_slave_change_num(struct hns_roce_bond_group *bond_grp)
+{
+	int ret;
+	u8 i;
+
+	for (i = 0; i < ROCE_BOND_FUNC_MAX; i++) {
+		if (bond_grp->slave_map & (1U << i)) {
+			if (i == PCI_FUNC(bond_grp->main_hr_dev->pci_dev->devfn))
+				continue;
+			hns_roce_slave_uninit(bond_grp, i);
+		} else {
+			hns_roce_slave_init(bond_grp, i, true);
+			if (!bond_grp->main_hr_dev) {
+				ret = -ENODEV;
+				goto out;
+			}
+			bond_grp->bond_func_info[i].net_dev = NULL;
+			bond_grp->bond_func_info[i].handle = NULL;
+		}
+	}
+
+	hns_roce_bond_get_active_slave(bond_grp);
+
+	ret = hns_roce_cmd_bond(bond_grp, HNS_ROCE_CHANGE_BOND);
+
+out:
+	if (ret) {
+		BOND_ERR_LOG("failed to change RoCE bond slave num, ret = %d.\n", ret);
+		hns_roce_cleanup_bond(bond_grp);
+	} else {
+		mutex_lock(&bond_grp->bond_mutex);
+		if (bond_grp->bond_state == HNS_ROCE_BOND_SLAVE_CHANGE_NUM)
+			bond_grp->bond_state = HNS_ROCE_BOND_IS_BONDED;
+		mutex_unlock(&bond_grp->bond_mutex);
+		ibdev_info(&bond_grp->main_hr_dev->ib_dev,
+			   "RoCE slave change num finished!\n");
+	}
+}
+
+static void hns_roce_bond_info_update_nolock(struct hns_roce_bond_group *bond_grp,
+					     struct net_device *upper_dev)
+{
+	struct hns_roce_v2_priv *priv;
+	struct hns_roce_dev *hr_dev;
+	struct net_device *net_dev;
+	int func_idx;
+
+	bond_grp->slave_map = 0;
+	rcu_read_lock();
+	for_each_netdev_in_bond_rcu(upper_dev, net_dev) {
+		func_idx = get_netdev_bond_slave_id(net_dev, bond_grp);
+		if (func_idx < 0) {
+			hr_dev = hns_roce_get_hrdev_by_netdev(net_dev);
+			if (!hr_dev)
+				continue;
+			func_idx = PCI_FUNC(hr_dev->pci_dev->devfn);
+			if (!bond_grp->bond_func_info[func_idx].net_dev) {
+				priv = hr_dev->priv;
+				bond_grp->bond_func_info[func_idx].net_dev =
+					net_dev;
+				bond_grp->bond_func_info[func_idx].handle =
+					priv->handle;
+			}
+			ib_device_put(&hr_dev->ib_dev);
+		}
+
+		bond_grp->slave_map |= (1 << func_idx);
+	}
+	rcu_read_unlock();
+}
+
 static bool is_dev_bond_supported(struct hns_roce_bond_group *bond_grp,
 				  struct net_device *net_dev)
 {
@@ -332,6 +524,50 @@ static bool check_slave_support(struct hns_roce_bond_group *bond_grp,
 	return (slave_num > 1 && slave_num <= ROCE_BOND_FUNC_MAX);
 }
 
+static void hns_roce_bond_work(struct work_struct *work)
+{
+	struct delayed_work *delayed_work = to_delayed_work(work);
+	struct hns_roce_bond_group *bond_grp =
+		container_of(delayed_work, struct hns_roce_bond_group,
+			     bond_work);
+	enum hns_roce_bond_state bond_state;
+	bool bond_ready;
+
+	mutex_lock(&bond_grp->bond_mutex);
+	bond_ready = check_slave_support(bond_grp, bond_grp->upper_dev);
+	hns_roce_bond_info_update_nolock(bond_grp, bond_grp->upper_dev);
+	bond_state = bond_grp->bond_state;
+	bond_grp->bond_ready = bond_ready;
+	mutex_unlock(&bond_grp->bond_mutex);
+
+	ibdev_info(&bond_grp->main_hr_dev->ib_dev,
+		   "bond work: bond_ready - %d, bond_state - %d.\n",
+		   bond_ready, bond_state);
+
+	if (!bond_ready) {
+		hns_roce_clear_bond(bond_grp);
+		return;
+	}
+
+	switch (bond_state) {
+	case HNS_ROCE_BOND_NOT_BONDED:
+		hns_roce_set_bond(bond_grp);
+		/* In set_bond flow, we don't need to set bond netdev here as
+		 * it has been done when bond_grp->main_hr_dev is registered.
+		 */
+		return;
+	case HNS_ROCE_BOND_SLAVE_CHANGESTATE:
+		hns_roce_slave_changestate(bond_grp);
+		break;
+	case HNS_ROCE_BOND_SLAVE_CHANGE_NUM:
+		hns_roce_slave_change_num(bond_grp);
+		break;
+	default:
+		return;
+	}
+	hns_roce_set_bond_netdev(bond_grp, bond_grp->main_hr_dev);
+}
+
 static void hns_roce_attach_bond_grp(struct hns_roce_bond_group *bond_grp,
 				     struct hns_roce_dev *hr_dev,
 				     struct net_device *upper_dev)
@@ -346,6 +582,7 @@ static void hns_roce_detach_bond_grp(struct hns_roce_bond_group *bond_grp)
 {
 	mutex_lock(&bond_grp->bond_mutex);
 
+	cancel_delayed_work(&bond_grp->bond_work);
 	bond_grp->upper_dev = NULL;
 	bond_grp->main_hr_dev = NULL;
 	bond_grp->bond_ready = false;
@@ -591,6 +828,9 @@ static int hns_roce_bond_event(struct notifier_block *self,
 	if (event == NETDEV_CHANGELOWERSTATE)
 		changed = hns_roce_bond_lowerstate_event(bond_grp, ptr);
 
+	if (changed)
+		schedule_delayed_work(&bond_grp->bond_work, HZ);
+
 	return NOTIFY_DONE;
 }
 
@@ -613,6 +853,7 @@ int hns_roce_alloc_bond_grp(struct hns_roce_dev *hr_dev)
 		}
 
 		mutex_init(&bond_grp->bond_mutex);
+		INIT_DELAYED_WORK(&bond_grp->bond_work, hns_roce_bond_work);
 
 		bond_grp->bond_ready = false;
 		bond_grp->bond_state = HNS_ROCE_BOND_NOT_ATTACHED;
@@ -645,6 +886,7 @@ int hns_roce_alloc_bond_grp(struct hns_roce_dev *hr_dev)
 mem_err:
 	for (i--; i >= 0; i--) {
 		unregister_netdevice_notifier(&bgrps[i]->bond_nb);
+		cancel_delayed_work_sync(&bgrps[i]->bond_work);
 		remove_bond_id(bgrps[i]->bus_num, bgrps[i]->bond_id);
 		mutex_destroy(&bgrps[i]->bond_mutex);
 		kvfree(bgrps[i]);
@@ -665,6 +907,7 @@ void hns_roce_dealloc_bond_grp(void)
 			if (!bond_grp)
 				continue;
 			unregister_netdevice_notifier(&bond_grp->bond_nb);
+			cancel_delayed_work_sync(&bond_grp->bond_work);
 			remove_bond_id(bond_grp->bus_num, bond_grp->bond_id);
 			mutex_destroy(&bond_grp->bond_mutex);
 			kvfree(bond_grp);
@@ -682,3 +925,68 @@ int hns_roce_bond_init(struct hns_roce_dev *hr_dev)
 
 	return hns_roce_set_bond_netdev(bond_grp, hr_dev);
 }
+
+void hns_roce_bond_suspend(struct hnae3_handle *handle)
+{
+	u8 bus_num = handle->pdev->bus->number;
+	struct hns_roce_bond_group *bond_grp;
+	struct hns_roce_die_info *die_info;
+	int i;
+
+	die_info = xa_load(&roce_bond_xa, bus_num);
+	if (!die_info)
+		return;
+
+	mutex_lock(&die_info->die_mutex);
+
+	/*
+	 * Avoid duplicated processing when calling this function
+	 * multiple times.
+	 */
+	if (die_info->suspend_cnt)
+		goto out;
+
+	for (i = 0; i < ROCE_BOND_NUM_MAX; i++) {
+		bond_grp = die_info->bgrps[i];
+		if (!bond_grp)
+			continue;
+		unregister_netdevice_notifier(&bond_grp->bond_nb);
+		cancel_delayed_work_sync(&bond_grp->bond_work);
+	}
+
+out:
+	die_info->suspend_cnt++;
+	mutex_unlock(&die_info->die_mutex);
+}
+
+void hns_roce_bond_resume(struct hnae3_handle *handle)
+{
+	u8 bus_num = handle->pdev->bus->number;
+	struct hns_roce_bond_group *bond_grp;
+	struct hns_roce_die_info *die_info;
+	int i, ret;
+
+	die_info = xa_load(&roce_bond_xa, bus_num);
+	if (!die_info)
+		return;
+
+	mutex_lock(&die_info->die_mutex);
+
+	die_info->suspend_cnt--;
+	if (die_info->suspend_cnt)
+		goto out;
+
+	for (i = 0; i < ROCE_BOND_NUM_MAX; i++) {
+		bond_grp = die_info->bgrps[i];
+		if (!bond_grp)
+			continue;
+		ret = register_netdevice_notifier(&bond_grp->bond_nb);
+		if (ret)
+			dev_err(&handle->pdev->dev,
+				"failed to resume bond notifier(bus_num = %u, id = %u), ret = %d.\n",
+				bus_num, bond_grp->bond_id, ret);
+	}
+
+out:
+	mutex_unlock(&die_info->die_mutex);
+}
diff --git a/drivers/infiniband/hw/hns/hns_roce_bond.h b/drivers/infiniband/hw/hns/hns_roce_bond.h
index 3ef7d28379cc..98c295d78ca1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_bond.h
+++ b/drivers/infiniband/hw/hns/hns_roce_bond.h
@@ -72,11 +72,14 @@ struct hns_roce_bond_group {
 	enum netdev_lag_hash hash_type;
 	struct mutex bond_mutex;
 	struct notifier_block bond_nb;
+	struct delayed_work bond_work;
 };
 
 struct hns_roce_die_info {
 	u8 bond_id_mask;
 	struct hns_roce_bond_group *bgrps[ROCE_BOND_NUM_MAX];
+	struct mutex die_mutex;
+	u8 suspend_cnt;
 };
 
 struct hns_roce_bond_group *hns_roce_get_bond_grp(struct net_device *net_dev,
@@ -86,5 +89,7 @@ void hns_roce_dealloc_bond_grp(void);
 void hns_roce_cleanup_bond(struct hns_roce_bond_group *bond_grp);
 bool hns_roce_bond_is_active(struct hns_roce_dev *hr_dev);
 int hns_roce_bond_init(struct hns_roce_dev *hr_dev);
+void hns_roce_bond_suspend(struct hnae3_handle *handle);
+void hns_roce_bond_resume(struct hnae3_handle *handle);
 
 #endif
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 5b1297bd0d20..a0088ec95281 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -7204,14 +7204,20 @@ static int hns_roce_hw_v2_init_instance(struct hnae3_handle *handle)
 static void hns_roce_hw_v2_uninit_instance(struct hnae3_handle *handle,
 					   bool reset)
 {
+	/* Suspend bond to avoid concurrency */
+	hns_roce_bond_suspend(handle);
+
 	if (handle->rinfo.instance_state != HNS_ROCE_STATE_INITED)
-		return;
+		goto out;
 
 	handle->rinfo.instance_state = HNS_ROCE_STATE_UNINIT;
 
 	__hns_roce_hw_v2_uninit_instance(handle, reset, true);
 
 	handle->rinfo.instance_state = HNS_ROCE_STATE_NON_INIT;
+
+out:
+	hns_roce_bond_resume(handle);
 }
 
 struct hns_roce_dev
@@ -7251,6 +7257,9 @@ static int hns_roce_hw_v2_reset_notify_down(struct hnae3_handle *handle)
 {
 	struct hns_roce_dev *hr_dev;
 
+	/* Suspend bond to avoid concurrency */
+	hns_roce_bond_suspend(handle);
+
 	if (handle->rinfo.instance_state != HNS_ROCE_STATE_INITED) {
 		set_bit(HNS_ROCE_RST_DIRECT_RETURN, &handle->rinfo.state);
 		return 0;
@@ -7281,6 +7290,7 @@ static int hns_roce_hw_v2_reset_notify_init(struct hnae3_handle *handle)
 	if (test_and_clear_bit(HNS_ROCE_RST_DIRECT_RETURN,
 			       &handle->rinfo.state)) {
 		handle->rinfo.reset_state = HNS_ROCE_STATE_RST_INITED;
+		hns_roce_bond_resume(handle);
 		return 0;
 	}
 
@@ -7300,6 +7310,7 @@ static int hns_roce_hw_v2_reset_notify_init(struct hnae3_handle *handle)
 		dev_info(dev, "reset done, RoCE client reinit finished.\n");
 	}
 
+	hns_roce_bond_resume(handle);
 	return ret;
 }
 
-- 
2.33.0


