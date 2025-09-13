Return-Path: <linux-rdma+bounces-13330-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D036B55FB4
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Sep 2025 11:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935961B26BE6
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Sep 2025 09:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC192EA47D;
	Sat, 13 Sep 2025 09:06:28 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E45A2C0F75
	for <linux-rdma@vger.kernel.org>; Sat, 13 Sep 2025 09:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757754388; cv=none; b=eLp4a2AId+bqztl+2a/Dr3TTMz/qg81ylevSWO9gUR6zh3teQ7tXweW2+i2Etk51b882JIxtM2wgr87KVOYUQZWQXEfFNvVVlidKDNYKbb9Xw9atJEfWaTudNwKiCkUr+rmQahVyk3N22AqiPuQlromnyB+vRCam7wD7YvPugWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757754388; c=relaxed/simple;
	bh=h6AhfgB5Hfvfms0r47Jn8KnZQE3pfAs5niEFipMPwNc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uuW75p64NY+38l5hl7Jtp2OZ5/VnKDBEjIgEABWG5JBIuEq7m0uJnkO3m7FklGswL/Fym9OUsHET8p2h+pBTLOk6dZYBR+xtN1why5HAG9a04t1y4JV+ppPltfsb0i0qRqZ1/uPj1VizpqJLppEPOeJL6TsR9ejANsxXRahIX8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cP4zW0PPnzdd5B;
	Sat, 13 Sep 2025 17:01:43 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id CF5641401F4;
	Sat, 13 Sep 2025 17:06:16 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 13 Sep 2025 17:06:16 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-next 2/8] RDMA/hns: Initialize bonding resources
Date: Sat, 13 Sep 2025 17:06:09 +0800
Message-ID: <20250913090615.212720-3-huangjunxian6@hisilicon.com>
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

Allocate bond_grp resources for each card when the first device in
this card is registered. Block the initialization of VF when its PF
is a bonded slave, as VF is not supported in this case due to HW
constraints.

Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/Makefile          |   4 +-
 drivers/infiniband/hw/hns/hns_roce_bond.c   | 185 ++++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_bond.h   |  38 ++++
 drivers/infiniband/hw/hns/hns_roce_device.h |   1 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  38 ++++
 drivers/infiniband/hw/hns/hns_roce_main.c   |  11 ++
 6 files changed, 276 insertions(+), 1 deletion(-)
 create mode 100644 drivers/infiniband/hw/hns/hns_roce_bond.c
 create mode 100644 drivers/infiniband/hw/hns/hns_roce_bond.h

diff --git a/drivers/infiniband/hw/hns/Makefile b/drivers/infiniband/hw/hns/Makefile
index baf592e6f21b..d07ef02c5231 100644
--- a/drivers/infiniband/hw/hns/Makefile
+++ b/drivers/infiniband/hw/hns/Makefile
@@ -4,11 +4,13 @@
 #
 
 ccflags-y :=  -I $(srctree)/drivers/net/ethernet/hisilicon/hns3
+ccflags-y +=  -I $(srctree)/drivers/net/ethernet/hisilicon/hns3/hns3pf
+ccflags-y +=  -I $(srctree)/drivers/net/ethernet/hisilicon/hns3/hns3_common
 ccflags-y +=  -I $(src)
 
 hns-roce-hw-v2-objs := hns_roce_main.o hns_roce_cmd.o hns_roce_pd.o \
 	hns_roce_ah.o hns_roce_hem.o hns_roce_mr.o hns_roce_qp.o \
 	hns_roce_cq.o hns_roce_alloc.o hns_roce_db.o hns_roce_srq.o hns_roce_restrack.o \
-	hns_roce_debugfs.o hns_roce_hw_v2.o
+	hns_roce_debugfs.o hns_roce_hw_v2.o hns_roce_bond.o
 
 obj-$(CONFIG_INFINIBAND_HNS_HIP08) += hns-roce-hw-v2.o
diff --git a/drivers/infiniband/hw/hns/hns_roce_bond.c b/drivers/infiniband/hw/hns/hns_roce_bond.c
new file mode 100644
index 000000000000..859da5af5e09
--- /dev/null
+++ b/drivers/infiniband/hw/hns/hns_roce_bond.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2025 Hisilicon Limited.
+ */
+
+#include "hns_roce_device.h"
+#include "hns_roce_hw_v2.h"
+#include "hns_roce_bond.h"
+
+static DEFINE_XARRAY(roce_bond_xa);
+
+static struct net_device *get_upper_dev_from_ndev(struct net_device *net_dev)
+{
+	struct net_device *upper_dev;
+
+	rcu_read_lock();
+	upper_dev = netdev_master_upper_dev_get_rcu(net_dev);
+	rcu_read_unlock();
+
+	return upper_dev;
+}
+
+static int get_netdev_bond_slave_id(struct net_device *net_dev,
+				    struct hns_roce_bond_group *bond_grp)
+{
+	int i;
+
+	for (i = 0; i < ROCE_BOND_FUNC_MAX; i++)
+		if (net_dev == bond_grp->bond_func_info[i].net_dev)
+			return i;
+
+	return -ENOENT;
+}
+
+struct hns_roce_bond_group *hns_roce_get_bond_grp(struct net_device *net_dev,
+						  u8 bus_num)
+{
+	struct hns_roce_die_info *die_info = xa_load(&roce_bond_xa, bus_num);
+	struct hns_roce_bond_group *bond_grp;
+	int i;
+
+	if (!die_info)
+		return NULL;
+
+	for (i = 0; i < ROCE_BOND_NUM_MAX; i++) {
+		bond_grp = die_info->bgrps[i];
+		if (!bond_grp)
+			continue;
+		if (get_netdev_bond_slave_id(net_dev, bond_grp) >= 0)
+			return bond_grp;
+		if (bond_grp->upper_dev &&
+		    bond_grp->upper_dev == get_upper_dev_from_ndev(net_dev))
+			return bond_grp;
+	}
+
+	return NULL;
+}
+
+static struct hns_roce_die_info *alloc_die_info(int bus_num)
+{
+	struct hns_roce_die_info *die_info;
+	int ret;
+
+	die_info = kzalloc(sizeof(*die_info), GFP_KERNEL);
+	if (!die_info)
+		return NULL;
+
+	ret = xa_err(xa_store(&roce_bond_xa, bus_num, die_info, GFP_KERNEL));
+	if (ret) {
+		kfree(die_info);
+		return NULL;
+	}
+
+	return die_info;
+}
+
+static void dealloc_die_info(struct hns_roce_die_info *die_info, u8 bus_num)
+{
+	xa_erase(&roce_bond_xa, bus_num);
+	kfree(die_info);
+}
+
+static int alloc_bond_id(struct hns_roce_bond_group *bond_grp)
+{
+	u8 bus_num = bond_grp->bus_num;
+	struct hns_roce_die_info *die_info = xa_load(&roce_bond_xa, bus_num);
+	int i;
+
+	if (!die_info) {
+		die_info = alloc_die_info(bus_num);
+		if (!die_info)
+			return -ENOMEM;
+	}
+
+	for (i = 0; i < ROCE_BOND_NUM_MAX; i++) {
+		if (die_info->bond_id_mask & BOND_ID(i))
+			continue;
+
+		die_info->bond_id_mask |= BOND_ID(i);
+		die_info->bgrps[i] = bond_grp;
+		bond_grp->bond_id = i;
+
+		return 0;
+	}
+
+	return -ENOSPC;
+}
+
+static int remove_bond_id(int bus_num, u8 bond_id)
+{
+	struct hns_roce_die_info *die_info = xa_load(&roce_bond_xa, bus_num);
+
+	if (bond_id >= ROCE_BOND_NUM_MAX)
+		return -EINVAL;
+
+	if (!die_info)
+		return -ENODEV;
+
+	die_info->bond_id_mask &= ~BOND_ID(bond_id);
+	die_info->bgrps[bond_id] = NULL;
+	if (!die_info->bond_id_mask)
+		dealloc_die_info(die_info, bus_num);
+
+	return 0;
+}
+
+int hns_roce_alloc_bond_grp(struct hns_roce_dev *hr_dev)
+{
+	struct hns_roce_bond_group *bgrps[ROCE_BOND_NUM_MAX];
+	struct hns_roce_bond_group *bond_grp;
+	u8 bus_num = get_hr_bus_num(hr_dev);
+	int ret;
+	int i;
+
+	if (xa_load(&roce_bond_xa, bus_num))
+		return 0;
+
+	for (i = 0; i < ROCE_BOND_NUM_MAX; i++) {
+		bond_grp = kvzalloc(sizeof(*bond_grp), GFP_KERNEL);
+		if (!bond_grp) {
+			ret = -ENOMEM;
+			goto mem_err;
+		}
+
+		bond_grp->bus_num = bus_num;
+
+		ret = alloc_bond_id(bond_grp);
+		if (ret) {
+			dev_err(hr_dev->dev,
+				"failed to alloc bond ID, ret = %d.\n", ret);
+			goto alloc_id_err;
+		}
+
+		bgrps[i] = bond_grp;
+	}
+
+	return 0;
+
+alloc_id_err:
+	kvfree(bond_grp);
+mem_err:
+	for (i--; i >= 0; i--) {
+		remove_bond_id(bgrps[i]->bus_num, bgrps[i]->bond_id);
+		kvfree(bgrps[i]);
+	}
+	return ret;
+}
+
+void hns_roce_dealloc_bond_grp(void)
+{
+	struct hns_roce_bond_group *bond_grp;
+	struct hns_roce_die_info *die_info;
+	unsigned long id;
+	int i;
+
+	xa_for_each(&roce_bond_xa, id, die_info) {
+		for (i = 0; i < ROCE_BOND_NUM_MAX; i++) {
+			bond_grp = die_info->bgrps[i];
+			if (!bond_grp)
+				continue;
+			remove_bond_id(bond_grp->bus_num, bond_grp->bond_id);
+			kvfree(bond_grp);
+		}
+	}
+}
diff --git a/drivers/infiniband/hw/hns/hns_roce_bond.h b/drivers/infiniband/hw/hns/hns_roce_bond.h
new file mode 100644
index 000000000000..61c52135588e
--- /dev/null
+++ b/drivers/infiniband/hw/hns/hns_roce_bond.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2025 Hisilicon Limited.
+ */
+
+#ifndef _HNS_ROCE_BOND_H
+#define _HNS_ROCE_BOND_H
+
+#include <linux/netdevice.h>
+#include <net/bonding.h>
+
+#define ROCE_BOND_FUNC_MAX 4
+#define ROCE_BOND_NUM_MAX 2
+
+#define BOND_ID(id) BIT(id)
+
+struct hns_roce_func_info {
+	struct net_device *net_dev;
+};
+
+struct hns_roce_bond_group {
+	struct net_device *upper_dev;
+	u8 bond_id;
+	u8 bus_num;
+	struct hns_roce_func_info bond_func_info[ROCE_BOND_FUNC_MAX];
+};
+
+struct hns_roce_die_info {
+	u8 bond_id_mask;
+	struct hns_roce_bond_group *bgrps[ROCE_BOND_NUM_MAX];
+};
+
+struct hns_roce_bond_group *hns_roce_get_bond_grp(struct net_device *net_dev,
+						  u8 bus_num);
+int hns_roce_alloc_bond_grp(struct hns_roce_dev *hr_dev);
+void hns_roce_dealloc_bond_grp(void);
+
+#endif
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 5ae37832059f..cc1402fc8943 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -154,6 +154,7 @@ enum {
 	HNS_ROCE_CAP_FLAG_SDI_MODE		= BIT(14),
 	HNS_ROCE_CAP_FLAG_STASH			= BIT(17),
 	HNS_ROCE_CAP_FLAG_CQE_INLINE		= BIT(19),
+	HNS_ROCE_CAP_FLAG_BOND                  = BIT(21),
 	HNS_ROCE_CAP_FLAG_SRQ_RECORD_DB         = BIT(22),
 };
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 64bca08f3f1a..e918c1c99d17 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -43,11 +43,13 @@
 #include <rdma/ib_umem.h>
 #include <rdma/uverbs_ioctl.h>
 
+#include "hclge_main.h"
 #include "hns_roce_common.h"
 #include "hns_roce_device.h"
 #include "hns_roce_cmd.h"
 #include "hns_roce_hem.h"
 #include "hns_roce_hw_v2.h"
+#include "hns_roce_bond.h"
 
 #define CREATE_TRACE_POINTS
 #include "hns_roce_trace.h"
@@ -2270,6 +2272,9 @@ static int hns_roce_query_caps(struct hns_roce_dev *hr_dev)
 	caps->flags |= le16_to_cpu(resp_d->cap_flags_ex) <<
 		       HNS_ROCE_CAP_FLAGS_EX_SHIFT;
 
+	if (hr_dev->is_vf)
+		caps->flags &= ~HNS_ROCE_CAP_FLAG_BOND;
+
 	caps->num_cqs = 1 << hr_reg_read(resp_c, PF_CAPS_C_NUM_CQS);
 	caps->gid_table_len[0] = hr_reg_read(resp_c, PF_CAPS_C_MAX_GID);
 	caps->max_cqes = 1 << hr_reg_read(resp_c, PF_CAPS_C_CQ_DEPTH);
@@ -7025,6 +7030,33 @@ static void hns_roce_hw_v2_get_cfg(struct hns_roce_dev *hr_dev,
 	priv->handle = handle;
 }
 
+static bool check_vf_support(struct pci_dev *vf)
+{
+	struct hns_roce_bond_group *bond_grp;
+	struct pci_dev *pf = pci_physfn(vf);
+	struct hnae3_ae_dev *ae_dev;
+	struct hnae3_handle *handle;
+	struct hns_roce_dev *hr_dev;
+	struct hclge_dev *hdev;
+
+	if (pf == vf)
+		return true;
+
+	ae_dev = pci_get_drvdata(pf);
+	hdev = ae_dev->priv;
+	handle = &hdev->vport[0].roce;
+	hr_dev = handle->priv;
+	if (!hr_dev)
+		return false;
+
+	bond_grp = hns_roce_get_bond_grp(get_hr_netdev(hr_dev, 0),
+					 pf->bus->number);
+	if (bond_grp)
+		return false;
+
+	return true;
+}
+
 static int __hns_roce_hw_v2_init_instance(struct hnae3_handle *handle)
 {
 	struct hns_roce_dev *hr_dev;
@@ -7042,6 +7074,11 @@ static int __hns_roce_hw_v2_init_instance(struct hnae3_handle *handle)
 
 	hns_roce_hw_v2_get_cfg(hr_dev, handle);
 
+	if (hr_dev->is_vf && !check_vf_support(hr_dev->pci_dev)) {
+		ret = -EOPNOTSUPP;
+		goto error_failed_roce_init;
+	}
+
 	ret = hns_roce_init(hr_dev);
 	if (ret) {
 		dev_err(hr_dev->dev, "RoCE Engine init failed!\n");
@@ -7260,6 +7297,7 @@ static int __init hns_roce_hw_v2_init(void)
 
 static void __exit hns_roce_hw_v2_exit(void)
 {
+	hns_roce_dealloc_bond_grp();
 	hnae3_unregister_client(&hns_roce_hw_v2_client);
 	hns_roce_cleanup_debugfs();
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 8bca0b10c69e..7fa25586ccd8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -40,6 +40,7 @@
 #include "hns_roce_device.h"
 #include "hns_roce_hem.h"
 #include "hns_roce_hw_v2.h"
+#include "hns_roce_bond.h"
 
 static int hns_roce_set_mac(struct hns_roce_dev *hr_dev, u32 port,
 			    const u8 *addr)
@@ -744,6 +745,16 @@ static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
 	ib_set_device_ops(ib_dev, hr_dev->hw->hns_roce_dev_ops);
 	ib_set_device_ops(ib_dev, &hns_roce_dev_ops);
 	ib_set_device_ops(ib_dev, &hns_roce_dev_restrack_ops);
+
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_BOND) {
+		ret = hns_roce_alloc_bond_grp(hr_dev);
+		if (ret) {
+			dev_err(dev, "failed to alloc bond_grp for bus %u, ret = %d\n",
+				get_hr_bus_num(hr_dev), ret);
+			return ret;
+		}
+	}
+
 	for (i = 0; i < hr_dev->caps.num_ports; i++) {
 		net_dev = get_hr_netdev(hr_dev, i);
 		if (!net_dev)
-- 
2.33.0


