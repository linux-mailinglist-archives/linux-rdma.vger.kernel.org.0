Return-Path: <linux-rdma+bounces-13337-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20579B55FBF
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Sep 2025 11:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D62CB586A6D
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Sep 2025 09:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE002EAD10;
	Sat, 13 Sep 2025 09:06:35 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FCD2EA484
	for <linux-rdma@vger.kernel.org>; Sat, 13 Sep 2025 09:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757754395; cv=none; b=KFFX8vygl+IZ1G12r+cxC80ck4B2BsohCbNYi9WLpWqMAShuesZAIK6MRBP0wSQUEAoLR2nV31ifmtOeOCLPdOn9dnJvaay9WufvAvO8c5ruoCWvV1B2ETo6tweyc3WEP7uxuQjp4W9vOji6ya5eFz/wwxHGv+8Xf8i8uKf45jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757754395; c=relaxed/simple;
	bh=wyAbbALBJrGy5iknpp/SyKu/dSs+RGwhLb5GGXKPnNc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fnhix+8VK8DbjQ2dbh391u/b+hlg4NCjGfozqaGAAZxflqufyDcCl8w+9JZ8JshN+scsdv8oVGis7R8DddlmL61Q71pWfMlRzIYlpiFd6RfII4JXxXzqhgQUVhjeIpd2SWT6OvHRfqlXVa0CwDkkj5owEUhrP5EMstkpulH+7+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cP50C0SjRz13MsF;
	Sat, 13 Sep 2025 17:02:19 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 2E5E1140137;
	Sat, 13 Sep 2025 17:06:17 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 13 Sep 2025 17:06:16 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-next 3/8] RDMA/hns: Add bonding event handler
Date: Sat, 13 Sep 2025 17:06:10 +0800
Message-ID: <20250913090615.212720-4-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250913090615.212720-1-huangjunxian6@hisilicon.com>
References: <20250913090615.212720-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100018.china.huawei.com (7.202.181.17)

Register netdev notifier for two bonding events NETDEV_CHANGEUPPER
and NETDEV_CHANGELOWERSTATE.

In NETDEV_CHANGEUPPER event handler, check some rules about the HW
constraints when trying to link a new slave to the masteri, and
store some bonding information from the notifier. In unlinking case,
simply check the number of the rest slaves to decide whether the
bond is still supported.

In NETDEV_CHANGELOWERSTATE event handler, not much is done. It
simply sets the bond state when the bond is ready, which will be
used later.

Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_bond.c | 306 ++++++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_bond.h |  26 ++
 2 files changed, 332 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_bond.c b/drivers/infiniband/hw/hns/hns_roce_bond.c
index 859da5af5e09..5fee44bcf81d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_bond.c
+++ b/drivers/infiniband/hw/hns/hns_roce_bond.c
@@ -9,6 +9,21 @@
 
 static DEFINE_XARRAY(roce_bond_xa);
 
+static struct hns_roce_dev *hns_roce_get_hrdev_by_netdev(struct net_device *net_dev)
+{
+	struct ib_device *ibdev =
+		ib_device_get_by_netdev(net_dev, RDMA_DRIVER_HNS);
+	struct hns_roce_dev *hr_dev;
+
+	if (!ibdev)
+		return NULL;
+
+	hr_dev = container_of(ibdev, struct hns_roce_dev, ib_dev);
+	ib_device_put(ibdev);
+
+	return hr_dev;
+}
+
 static struct net_device *get_upper_dev_from_ndev(struct net_device *net_dev)
 {
 	struct net_device *upper_dev;
@@ -124,6 +139,279 @@ static int remove_bond_id(int bus_num, u8 bond_id)
 	return 0;
 }
 
+static bool is_dev_bond_supported(struct hns_roce_bond_group *bond_grp,
+				  struct net_device *net_dev)
+{
+	struct hns_roce_dev *hr_dev = hns_roce_get_hrdev_by_netdev(net_dev);
+
+	if (!hr_dev) {
+		if (bond_grp &&
+		    get_netdev_bond_slave_id(net_dev, bond_grp) >= 0)
+			return true;
+		else
+			return false;
+	}
+
+	if (!(hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_BOND))
+		return false;
+
+	if (hr_dev->is_vf || pci_num_vf(hr_dev->pci_dev) > 0)
+		return false;
+
+	if (bond_grp->bus_num != get_hr_bus_num(hr_dev))
+		return false;
+
+	return true;
+}
+
+static bool check_slave_support(struct hns_roce_bond_group *bond_grp,
+				struct net_device *upper_dev)
+{
+	struct net_device *net_dev;
+	u8 slave_num = 0;
+
+	rcu_read_lock();
+	for_each_netdev_in_bond_rcu(upper_dev, net_dev) {
+		if (is_dev_bond_supported(bond_grp, net_dev)) {
+			slave_num++;
+			continue;
+		}
+		rcu_read_unlock();
+		return false;
+	}
+	rcu_read_unlock();
+
+	return (slave_num > 1 && slave_num <= ROCE_BOND_FUNC_MAX);
+}
+
+static void hns_roce_attach_bond_grp(struct hns_roce_bond_group *bond_grp,
+				     struct hns_roce_dev *hr_dev,
+				     struct net_device *upper_dev)
+{
+	bond_grp->upper_dev = upper_dev;
+	bond_grp->main_hr_dev = hr_dev;
+	bond_grp->bond_state = HNS_ROCE_BOND_NOT_BONDED;
+	bond_grp->bond_ready = false;
+}
+
+static bool lowerstate_event_filter(struct hns_roce_bond_group *bond_grp,
+				    struct net_device *net_dev)
+{
+	struct hns_roce_bond_group *bond_grp_tmp;
+
+	bond_grp_tmp = hns_roce_get_bond_grp(net_dev, bond_grp->bus_num);
+	return bond_grp_tmp == bond_grp;
+}
+
+static void lowerstate_event_setting(struct hns_roce_bond_group *bond_grp,
+				     struct netdev_notifier_changelowerstate_info *info)
+{
+	mutex_lock(&bond_grp->bond_mutex);
+
+	if (bond_grp->bond_ready &&
+	    bond_grp->bond_state == HNS_ROCE_BOND_IS_BONDED)
+		bond_grp->bond_state = HNS_ROCE_BOND_SLAVE_CHANGESTATE;
+
+	mutex_unlock(&bond_grp->bond_mutex);
+}
+
+static bool hns_roce_bond_lowerstate_event(struct hns_roce_bond_group *bond_grp,
+					   struct netdev_notifier_changelowerstate_info *info)
+{
+	struct net_device *net_dev =
+		netdev_notifier_info_to_dev((struct netdev_notifier_info *)info);
+
+	if (!netif_is_lag_port(net_dev))
+		return false;
+
+	if (!lowerstate_event_filter(bond_grp, net_dev))
+		return false;
+
+	lowerstate_event_setting(bond_grp, info);
+
+	return true;
+}
+
+static bool is_bond_setting_supported(struct netdev_lag_upper_info *bond_info)
+{
+	if (!bond_info)
+		return false;
+
+	if (bond_info->tx_type != NETDEV_LAG_TX_TYPE_ACTIVEBACKUP &&
+	    bond_info->tx_type != NETDEV_LAG_TX_TYPE_HASH)
+		return false;
+
+	if (bond_info->tx_type == NETDEV_LAG_TX_TYPE_HASH &&
+	    bond_info->hash_type > NETDEV_LAG_HASH_L23)
+		return false;
+
+	return true;
+}
+
+static void upper_event_setting(struct hns_roce_bond_group *bond_grp,
+				struct netdev_notifier_changeupper_info *info)
+{
+	struct netdev_lag_upper_info *bond_upper_info = NULL;
+	bool slave_inc = info->linking;
+
+	if (slave_inc)
+		bond_upper_info = info->upper_info;
+
+	if (bond_upper_info) {
+		bond_grp->tx_type = bond_upper_info->tx_type;
+		bond_grp->hash_type = bond_upper_info->hash_type;
+	}
+}
+
+static bool check_unlinking_bond_support(struct hns_roce_bond_group *bond_grp)
+{
+	struct net_device *net_dev;
+	u8 slave_num = 0;
+
+	rcu_read_lock();
+	for_each_netdev_in_bond_rcu(bond_grp->upper_dev, net_dev) {
+		if (get_netdev_bond_slave_id(net_dev, bond_grp) >= 0)
+			slave_num++;
+	}
+	rcu_read_unlock();
+
+	return (slave_num > 1);
+}
+
+static bool check_linking_bond_support(struct netdev_lag_upper_info *bond_info,
+				       struct hns_roce_bond_group *bond_grp,
+				       struct net_device *upper_dev)
+{
+	if (!is_bond_setting_supported(bond_info))
+		return false;
+
+	return check_slave_support(bond_grp, upper_dev);
+}
+
+static enum bond_support_type
+	check_bond_support(struct hns_roce_bond_group *bond_grp,
+			   struct net_device *upper_dev,
+			   struct netdev_notifier_changeupper_info *info)
+{
+	bool bond_grp_exist = false;
+	bool support;
+
+	if (upper_dev == bond_grp->upper_dev)
+		bond_grp_exist = true;
+
+	if (!info->linking && !bond_grp_exist)
+		return BOND_NOT_SUPPORT;
+
+	if (info->linking)
+		support = check_linking_bond_support(info->upper_info, bond_grp,
+						     upper_dev);
+	else
+		support = check_unlinking_bond_support(bond_grp);
+
+	if (support)
+		return BOND_SUPPORT;
+
+	return bond_grp_exist ? BOND_EXISTING_NOT_SUPPORT : BOND_NOT_SUPPORT;
+}
+
+static bool upper_event_filter(struct netdev_notifier_changeupper_info *info,
+			       struct hns_roce_bond_group *bond_grp,
+			       struct net_device *net_dev)
+{
+	struct net_device *upper_dev = info->upper_dev;
+	struct hns_roce_bond_group *bond_grp_tmp;
+	struct hns_roce_dev *hr_dev;
+	u8 bus_num;
+
+	if (!info->linking ||
+	    bond_grp->bond_state != HNS_ROCE_BOND_NOT_ATTACHED)
+		return bond_grp->upper_dev == upper_dev;
+
+	hr_dev = hns_roce_get_hrdev_by_netdev(net_dev);
+	if (!hr_dev)
+		return false;
+
+	bus_num = get_hr_bus_num(hr_dev);
+	if (bond_grp->bus_num != bus_num)
+		return false;
+
+	bond_grp_tmp = hns_roce_get_bond_grp(net_dev, bus_num);
+	if (bond_grp_tmp && bond_grp_tmp != bond_grp)
+		return false;
+
+	return true;
+}
+
+static bool hns_roce_bond_upper_event(struct hns_roce_bond_group *bond_grp,
+				      struct netdev_notifier_changeupper_info *info)
+{
+	struct net_device *net_dev =
+		netdev_notifier_info_to_dev((struct netdev_notifier_info *)info);
+	struct net_device *upper_dev = info->upper_dev;
+	enum bond_support_type support = BOND_SUPPORT;
+	struct hns_roce_dev *hr_dev;
+	int slave_id;
+
+	if (!upper_dev || !netif_is_lag_master(upper_dev))
+		return false;
+
+	if (!upper_event_filter(info, bond_grp, net_dev))
+		return false;
+
+	mutex_lock(&bond_grp->bond_mutex);
+	support = check_bond_support(bond_grp, upper_dev, info);
+	if (support == BOND_NOT_SUPPORT) {
+		mutex_unlock(&bond_grp->bond_mutex);
+		return false;
+	}
+
+	if (bond_grp->bond_state == HNS_ROCE_BOND_NOT_ATTACHED) {
+		hr_dev = hns_roce_get_hrdev_by_netdev(net_dev);
+		if (!hr_dev) {
+			mutex_unlock(&bond_grp->bond_mutex);
+			return false;
+		}
+		hns_roce_attach_bond_grp(bond_grp, hr_dev, upper_dev);
+	}
+
+	/* In the case of netdev being unregistered, the roce
+	 * instance shouldn't be inited.
+	 */
+	if (net_dev->reg_state >= NETREG_UNREGISTERING) {
+		slave_id = get_netdev_bond_slave_id(net_dev, bond_grp);
+		if (slave_id >= 0) {
+			bond_grp->bond_func_info[slave_id].net_dev = NULL;
+			bond_grp->bond_func_info[slave_id].handle = NULL;
+		}
+	}
+
+	if (support == BOND_SUPPORT) {
+		bond_grp->bond_ready = true;
+		if (bond_grp->bond_state != HNS_ROCE_BOND_NOT_BONDED)
+			bond_grp->bond_state = HNS_ROCE_BOND_SLAVE_CHANGE_NUM;
+	}
+	mutex_unlock(&bond_grp->bond_mutex);
+	if (support == BOND_SUPPORT)
+		upper_event_setting(bond_grp, info);
+
+	return true;
+}
+
+static int hns_roce_bond_event(struct notifier_block *self,
+			       unsigned long event, void *ptr)
+{
+	struct hns_roce_bond_group *bond_grp =
+		container_of(self, struct hns_roce_bond_group, bond_nb);
+	bool changed = false;
+
+	if (event == NETDEV_CHANGEUPPER)
+		changed = hns_roce_bond_upper_event(bond_grp, ptr);
+	if (event == NETDEV_CHANGELOWERSTATE)
+		changed = hns_roce_bond_lowerstate_event(bond_grp, ptr);
+
+	return NOTIFY_DONE;
+}
+
 int hns_roce_alloc_bond_grp(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_bond_group *bgrps[ROCE_BOND_NUM_MAX];
@@ -142,6 +430,10 @@ int hns_roce_alloc_bond_grp(struct hns_roce_dev *hr_dev)
 			goto mem_err;
 		}
 
+		mutex_init(&bond_grp->bond_mutex);
+
+		bond_grp->bond_ready = false;
+		bond_grp->bond_state = HNS_ROCE_BOND_NOT_ATTACHED;
 		bond_grp->bus_num = bus_num;
 
 		ret = alloc_bond_id(bond_grp);
@@ -151,16 +443,28 @@ int hns_roce_alloc_bond_grp(struct hns_roce_dev *hr_dev)
 			goto alloc_id_err;
 		}
 
+		bond_grp->bond_nb.notifier_call = hns_roce_bond_event;
+		ret = register_netdevice_notifier(&bond_grp->bond_nb);
+		if (ret) {
+			ibdev_err(&hr_dev->ib_dev,
+				  "failed to register bond nb, ret = %d.\n", ret);
+			goto register_nb_err;
+		}
 		bgrps[i] = bond_grp;
 	}
 
 	return 0;
 
+register_nb_err:
+	remove_bond_id(bond_grp->bus_num, bond_grp->bond_id);
 alloc_id_err:
+	mutex_destroy(&bond_grp->bond_mutex);
 	kvfree(bond_grp);
 mem_err:
 	for (i--; i >= 0; i--) {
+		unregister_netdevice_notifier(&bgrps[i]->bond_nb);
 		remove_bond_id(bgrps[i]->bus_num, bgrps[i]->bond_id);
+		mutex_destroy(&bgrps[i]->bond_mutex);
 		kvfree(bgrps[i]);
 	}
 	return ret;
@@ -178,7 +482,9 @@ void hns_roce_dealloc_bond_grp(void)
 			bond_grp = die_info->bgrps[i];
 			if (!bond_grp)
 				continue;
+			unregister_netdevice_notifier(&bond_grp->bond_nb);
 			remove_bond_id(bond_grp->bus_num, bond_grp->bond_id);
+			mutex_destroy(&bond_grp->bond_mutex);
 			kvfree(bond_grp);
 		}
 	}
diff --git a/drivers/infiniband/hw/hns/hns_roce_bond.h b/drivers/infiniband/hw/hns/hns_roce_bond.h
index 61c52135588e..a11de04c42e9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_bond.h
+++ b/drivers/infiniband/hw/hns/hns_roce_bond.h
@@ -14,15 +14,41 @@
 
 #define BOND_ID(id) BIT(id)
 
+enum bond_support_type {
+	BOND_NOT_SUPPORT,
+	/*
+	 * bond_grp already exists, but in the current
+	 * conditions it's no longer supported
+	 */
+	BOND_EXISTING_NOT_SUPPORT,
+	BOND_SUPPORT,
+};
+
+enum hns_roce_bond_state {
+	HNS_ROCE_BOND_NOT_ATTACHED,
+	HNS_ROCE_BOND_NOT_BONDED,
+	HNS_ROCE_BOND_IS_BONDED,
+	HNS_ROCE_BOND_SLAVE_CHANGE_NUM,
+	HNS_ROCE_BOND_SLAVE_CHANGESTATE,
+};
+
 struct hns_roce_func_info {
 	struct net_device *net_dev;
+	struct hnae3_handle *handle;
 };
 
 struct hns_roce_bond_group {
 	struct net_device *upper_dev;
+	struct hns_roce_dev *main_hr_dev;
 	u8 bond_id;
 	u8 bus_num;
 	struct hns_roce_func_info bond_func_info[ROCE_BOND_FUNC_MAX];
+	bool bond_ready;
+	enum hns_roce_bond_state bond_state;
+	enum netdev_lag_tx_type tx_type;
+	enum netdev_lag_hash hash_type;
+	struct mutex bond_mutex;
+	struct notifier_block bond_nb;
 };
 
 struct hns_roce_die_info {
-- 
2.33.0


