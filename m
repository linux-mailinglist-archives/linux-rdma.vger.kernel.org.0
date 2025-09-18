Return-Path: <linux-rdma+bounces-13338-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A374B55FBE
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Sep 2025 11:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 042FBA0719D
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Sep 2025 09:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5712EA49A;
	Sat, 13 Sep 2025 09:06:36 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8E82EA491
	for <linux-rdma@vger.kernel.org>; Sat, 13 Sep 2025 09:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757754395; cv=none; b=tSnevoaLZFe1lPN0DX2UL7hUd5vjgSi7nho43GDwZ6vj1g67xrZHk6xP7RgQN2fpjiMFOZSAAMIGi7vInUk4YgN9x4CPH8gCIt8/meR9CCF76So0jP6nt0Sky5jwa+nAYQ21sjrF4Z0MxW/A+Q/bkPn+cBPyGF3RRrmy0TBLzRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757754395; c=relaxed/simple;
	bh=4zRI1UfmRp2zlYnTXOPoSRcQx9Khgo/bU0+DA15if1Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OOyo91IEfZbOpXsMTuVfvV4ClJiT3q4MT0JAtc0YR6Fj0Zihi0kkYUSy7xZh5/48qgqMP1X1tAS9PsIqX582NPGHyrd8FbuOceWCb8yjy8DUJf8xSxFp12TEkIYpWhvsa6XaG2mVRKYqUV9ns5bHw3gDJlUvzvEMbu4x+bdmvQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cP54V6rV1z14MrH;
	Sat, 13 Sep 2025 17:06:02 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 860221402EA;
	Sat, 13 Sep 2025 17:06:17 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 13 Sep 2025 17:06:16 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-next 4/8] RDMA/hns: Add bonding cmds
Date: Sat, 13 Sep 2025 17:06:11 +0800
Message-ID: <20250913090615.212720-5-huangjunxian6@hisilicon.com>
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

Add three bonding cmds to configure bonding settings to HW.

Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_bond.h  | 20 ++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 73 ++++++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 15 +++++
 3 files changed, 108 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_bond.h b/drivers/infiniband/hw/hns/hns_roce_bond.h
index a11de04c42e9..84c94cbc397d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_bond.h
+++ b/drivers/infiniband/hw/hns/hns_roce_bond.h
@@ -14,6 +14,17 @@
 
 #define BOND_ID(id) BIT(id)
 
+enum {
+	BOND_MODE_1,
+	BOND_MODE_2_4,
+};
+
+enum hns_roce_bond_hashtype {
+	BOND_HASH_L2,
+	BOND_HASH_L34,
+	BOND_HASH_L23,
+};
+
 enum bond_support_type {
 	BOND_NOT_SUPPORT,
 	/*
@@ -32,6 +43,12 @@ enum hns_roce_bond_state {
 	HNS_ROCE_BOND_SLAVE_CHANGESTATE,
 };
 
+enum hns_roce_bond_cmd_type {
+	HNS_ROCE_SET_BOND,
+	HNS_ROCE_CHANGE_BOND,
+	HNS_ROCE_CLEAR_BOND,
+};
+
 struct hns_roce_func_info {
 	struct net_device *net_dev;
 	struct hnae3_handle *handle;
@@ -40,6 +57,9 @@ struct hns_roce_func_info {
 struct hns_roce_bond_group {
 	struct net_device *upper_dev;
 	struct hns_roce_dev *main_hr_dev;
+	u8 active_slave_num;
+	u32 slave_map;
+	u32 active_slave_map;
 	u8 bond_id;
 	u8 bus_num;
 	struct hns_roce_func_info bond_func_info[ROCE_BOND_FUNC_MAX];
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index e918c1c99d17..d3c1ad04afd7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1431,6 +1431,79 @@ static int hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 	return ret;
 }
 
+static enum hns_roce_opcode_type
+	get_bond_opcode(enum hns_roce_bond_cmd_type bond_type)
+{
+	switch (bond_type) {
+	case HNS_ROCE_SET_BOND:
+		return HNS_ROCE_OPC_SET_BOND_INFO;
+	case HNS_ROCE_CHANGE_BOND:
+		return HNS_ROCE_OPC_CHANGE_ACTIVE_PORT;
+	case HNS_ROCE_CLEAR_BOND:
+		return HNS_ROCE_OPC_CLEAR_BOND_INFO;
+	default:
+		WARN(true, "Invalid bond type %d!\n", bond_type);
+		return HNS_ROCE_OPC_SET_BOND_INFO;
+	}
+}
+
+static enum hns_roce_bond_hashtype
+	get_bond_hashtype(enum netdev_lag_hash netdev_hashtype)
+{
+	switch (netdev_hashtype) {
+	case NETDEV_LAG_HASH_L2:
+		return BOND_HASH_L2;
+	case NETDEV_LAG_HASH_L34:
+		return BOND_HASH_L34;
+	case NETDEV_LAG_HASH_L23:
+		return BOND_HASH_L23;
+	default:
+		WARN(true, "Invalid hash type %d!\n", netdev_hashtype);
+		return BOND_HASH_L2;
+	}
+}
+
+int hns_roce_cmd_bond(struct hns_roce_bond_group *bond_grp,
+		      enum hns_roce_bond_cmd_type bond_type)
+{
+	enum hns_roce_opcode_type opcode = get_bond_opcode(bond_type);
+	struct hns_roce_bond_info *slave_info;
+	struct hns_roce_cmq_desc desc = {};
+	int ret;
+
+	slave_info = (struct hns_roce_bond_info *)desc.data;
+	hns_roce_cmq_setup_basic_desc(&desc, opcode, false);
+
+	slave_info->bond_id = cpu_to_le32(bond_grp->bond_id);
+	if (bond_type == HNS_ROCE_CLEAR_BOND)
+		goto out;
+
+	if (bond_grp->tx_type == NETDEV_LAG_TX_TYPE_ACTIVEBACKUP) {
+		slave_info->bond_mode = cpu_to_le32(BOND_MODE_1);
+		if (bond_grp->active_slave_num != 1)
+			ibdev_warn(&bond_grp->main_hr_dev->ib_dev,
+				   "active slave cnt(%u) in Mode 1 is invalid.\n",
+				   bond_grp->active_slave_num);
+	} else {
+		slave_info->bond_mode = cpu_to_le32(BOND_MODE_2_4);
+		slave_info->hash_policy =
+			cpu_to_le32(get_bond_hashtype(bond_grp->hash_type));
+	}
+
+	slave_info->active_slave_cnt = cpu_to_le32(bond_grp->active_slave_num);
+	slave_info->active_slave_mask = cpu_to_le32(bond_grp->active_slave_map);
+	slave_info->slave_mask = cpu_to_le32(bond_grp->slave_map);
+
+out:
+	ret = hns_roce_cmq_send(bond_grp->main_hr_dev, &desc, 1);
+	if (ret)
+		ibdev_err(&bond_grp->main_hr_dev->ib_dev,
+			  "cmq bond type(%d) failed, ret = %d.\n",
+			  bond_type, ret);
+
+	return ret;
+}
+
 static int config_hem_ba_to_hw(struct hns_roce_dev *hr_dev,
 			       dma_addr_t base_addr, u8 cmd, unsigned long tag)
 {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index e64a04d6f85b..82cec4b38c92 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -35,6 +35,7 @@
 
 #include <linux/bitops.h>
 #include "hnae3.h"
+#include "hns_roce_bond.h"
 
 #define HNS_ROCE_V2_MAX_RC_INL_INN_SZ		32
 #define HNS_ROCE_V2_MTT_ENTRY_SZ		64
@@ -228,6 +229,9 @@ enum hns_roce_opcode_type {
 	HNS_ROCE_OPC_CFG_GMV_BT				= 0x8510,
 	HNS_ROCE_QUERY_RAM_ECC				= 0x8513,
 	HNS_SWITCH_PARAMETER_CFG			= 0x1033,
+	HNS_ROCE_OPC_SET_BOND_INFO                      = 0x8601,
+	HNS_ROCE_OPC_CLEAR_BOND_INFO                    = 0x8602,
+	HNS_ROCE_OPC_CHANGE_ACTIVE_PORT                 = 0x8603,
 };
 
 #define HNS_ROCE_OPC_POST_MB_TIMEOUT 35000
@@ -1465,7 +1469,18 @@ struct hns_roce_sccc_clr_done {
 	__le32 rsv[5];
 };
 
+struct hns_roce_bond_info {
+	__le32 bond_id;
+	__le32 bond_mode;
+	__le32 active_slave_cnt;
+	__le32 active_slave_mask;
+	__le32 slave_mask;
+	__le32 hash_policy;
+};
+
 int hns_roce_v2_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata);
+int hns_roce_cmd_bond(struct hns_roce_bond_group *bond_grp,
+		      enum hns_roce_bond_cmd_type bond_type);
 
 static inline void hns_roce_write64(struct hns_roce_dev *hr_dev, __le32 val[2],
 				    void __iomem *dest)
-- 
2.33.0


