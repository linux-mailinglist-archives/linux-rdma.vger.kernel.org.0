Return-Path: <linux-rdma+bounces-1334-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D00687628C
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Mar 2024 11:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE6F1C216B9
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Mar 2024 10:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A4055C2D;
	Fri,  8 Mar 2024 10:59:04 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85BB5577F;
	Fri,  8 Mar 2024 10:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709895544; cv=none; b=V4ALPFL9YTQWLuY3HPJWB8Ta9JMzyLVjtJ9I12PhbbYTCwFx4vUMyyhNKhPT2NMnaeiEpVRxzcsmnE+UtD6uWgaN8OE7mCyUuOpsuDyxXwUp6DJFWb0QUu46zDIa3IW6T5vfHnqIy7xKgV7ihHiOE0xjKsgBXmbY+fYpCLazh48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709895544; c=relaxed/simple;
	bh=BeIyKcml2ylHXdqxTFxuFXes4qJGRrYy8z6L2WHWfMI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S+8LOGQASNkBmQQJzbQAFeIDSvd2gP0EKUghxQtyASMfJn/pLpTY19bp8eihfeswy1NO2GrxbIMuNNrGz/JM2R2FVUWWTC0kYej4SfaTk8eA9JC4wgEN9XdOb/Sngy9AEXlf4WBZht7SSAacCUcf7jd4Qt0BWSxbuZQN0cn/OW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Trjlk1N4cz2Bf7S;
	Fri,  8 Mar 2024 18:56:34 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 131AC1A016C;
	Fri,  8 Mar 2024 18:58:57 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Mar 2024 18:58:56 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-next] RDMA/hns: Support congestion control algorithm parameter configuration
Date: Fri, 8 Mar 2024 18:54:43 +0800
Message-ID: <20240308105443.1130283-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500006.china.huawei.com (7.221.188.68)

From: Chengchang Tang <tangchengchang@huawei.com>

hns RoCE supports 4 congestion control algorithms. Each algorihm
involves multiple parameters. Add port sysfs directory for each
algorithm to allow modifying their parameters.

Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/Makefile          |   2 +-
 drivers/infiniband/hw/hns/hns_roce_device.h |  20 ++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  59 ++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 132 ++++++++
 drivers/infiniband/hw/hns/hns_roce_main.c   |   3 +
 drivers/infiniband/hw/hns/hns_roce_sysfs.c  | 346 ++++++++++++++++++++
 6 files changed, 561 insertions(+), 1 deletion(-)
 create mode 100644 drivers/infiniband/hw/hns/hns_roce_sysfs.c

diff --git a/drivers/infiniband/hw/hns/Makefile b/drivers/infiniband/hw/hns/Makefile
index be1e1cdbcfa8..161615fda3ae 100644
--- a/drivers/infiniband/hw/hns/Makefile
+++ b/drivers/infiniband/hw/hns/Makefile
@@ -8,7 +8,7 @@ ccflags-y :=  -I $(srctree)/drivers/net/ethernet/hisilicon/hns3
 hns-roce-objs := hns_roce_main.o hns_roce_cmd.o hns_roce_pd.o \
 	hns_roce_ah.o hns_roce_hem.o hns_roce_mr.o hns_roce_qp.o \
 	hns_roce_cq.o hns_roce_alloc.o hns_roce_db.o hns_roce_srq.o hns_roce_restrack.o \
-	hns_roce_debugfs.o
+	hns_roce_debugfs.o hns_roce_sysfs.o
 
 ifdef CONFIG_INFINIBAND_HNS_HIP08
 hns-roce-hw-v2-objs := hns_roce_hw_v2.o $(hns-roce-objs)
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index c3cbd0a494bf..d6a9a510f541 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -599,6 +599,7 @@ enum hns_roce_cong_type {
 	CONG_TYPE_LDCP,
 	CONG_TYPE_HC3,
 	CONG_TYPE_DIP,
+	CONG_TYPE_TOTAL,
 };
 
 struct hns_roce_qp {
@@ -952,6 +953,20 @@ struct hns_roce_hw {
 				u64 *stats, u32 port, int *hw_counters);
 	const struct ib_device_ops *hns_roce_dev_ops;
 	const struct ib_device_ops *hns_roce_dev_srq_ops;
+	int (*config_scc_param)(struct hns_roce_dev *hr_dev,
+				enum hns_roce_cong_type algo);
+	int (*query_scc_param)(struct hns_roce_dev *hr_dev,
+			       enum hns_roce_cong_type alog);
+};
+
+#define HNS_ROCE_SCC_PARAM_SIZE 4
+struct hns_roce_scc_param {
+	__le32 param[HNS_ROCE_SCC_PARAM_SIZE];
+	u32 lifespan;
+	unsigned long timestamp;
+	enum hns_roce_cong_type algo_type;
+	struct delayed_work scc_cfg_dwork;
+	struct hns_roce_dev *hr_dev;
 };
 
 struct hns_roce_dev {
@@ -1017,6 +1032,7 @@ struct hns_roce_dev {
 	u64 dwqe_page;
 	struct hns_roce_dev_debugfs dbgfs;
 	atomic64_t *dfx_cnt;
+	struct hns_roce_scc_param *scc_param;
 };
 
 static inline struct hns_roce_dev *to_hr_dev(struct ib_device *ib_dev)
@@ -1152,6 +1168,8 @@ static inline u8 get_tclass(const struct ib_global_route *grh)
 	       grh->traffic_class >> DSCP_SHIFT : grh->traffic_class;
 }
 
+extern const struct attribute_group *hns_attr_port_groups[];
+
 void hns_roce_init_uar_table(struct hns_roce_dev *dev);
 int hns_roce_uar_alloc(struct hns_roce_dev *dev, struct hns_roce_uar *uar);
 
@@ -1292,4 +1310,6 @@ struct hns_user_mmap_entry *
 hns_roce_user_mmap_entry_insert(struct ib_ucontext *ucontext, u64 address,
 				size_t length,
 				enum hns_roce_mmap_type mmap_type);
+void hns_roce_register_sysfs(struct hns_roce_dev *hr_dev);
+void hns_roce_unregister_sysfs(struct hns_roce_dev *hr_dev);
 #endif /* _HNS_ROCE_DEVICE_H */
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index ba7ae792d279..9d16ccc3d65d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -6689,6 +6689,63 @@ static void hns_roce_v2_cleanup_eq_table(struct hns_roce_dev *hr_dev)
 	kfree(eq_table->eq);
 }
 
+static const enum hns_roce_opcode_type scc_opcode[] = {
+	HNS_ROCE_OPC_CFG_DCQCN_PARAM,
+	HNS_ROCE_OPC_CFG_LDCP_PARAM,
+	HNS_ROCE_OPC_CFG_HC3_PARAM,
+	HNS_ROCE_OPC_CFG_DIP_PARAM,
+};
+
+static int hns_roce_v2_config_scc_param(struct hns_roce_dev *hr_dev,
+					enum hns_roce_cong_type algo)
+{
+	struct hns_roce_scc_param *scc_param;
+	struct hns_roce_cmq_desc desc;
+	int ret;
+
+	if (algo >= CONG_TYPE_TOTAL)
+		return -EINVAL;
+
+	hns_roce_cmq_setup_basic_desc(&desc, scc_opcode[algo], false);
+	scc_param = &hr_dev->scc_param[algo];
+	memcpy(&desc.data, scc_param, sizeof(scc_param->param));
+
+	ret = hns_roce_cmq_send(hr_dev, &desc, 1);
+	if (ret)
+		ibdev_err_ratelimited(&hr_dev->ib_dev,
+				      "failed to configure scc param, opcode: 0x%x, ret = %d.\n",
+				      le16_to_cpu(desc.opcode), ret);
+	return ret;
+}
+
+static int hns_roce_v2_query_scc_param(struct hns_roce_dev *hr_dev,
+				       enum hns_roce_cong_type algo)
+{
+	struct hns_roce_scc_param *scc_param;
+	struct hns_roce_cmq_desc desc;
+	int ret;
+
+	if (hr_dev->pci_dev->revision <= PCI_REVISION_ID_HIP08 || hr_dev->is_vf)
+		return -EOPNOTSUPP;
+
+	if (algo >= CONG_TYPE_TOTAL)
+		return -EINVAL;
+
+	hns_roce_cmq_setup_basic_desc(&desc, scc_opcode[algo], true);
+	ret = hns_roce_cmq_send(hr_dev, &desc, 1);
+	if (ret) {
+		ibdev_err_ratelimited(&hr_dev->ib_dev,
+				      "failed to query scc param, opcode: 0x%x, ret = %d.\n",
+				      le16_to_cpu(desc.opcode), ret);
+		return ret;
+	}
+
+	scc_param = &hr_dev->scc_param[algo];
+	memcpy(scc_param, &desc.data, sizeof(scc_param->param));
+
+	return 0;
+}
+
 static const struct ib_device_ops hns_roce_v2_dev_ops = {
 	.destroy_qp = hns_roce_v2_destroy_qp,
 	.modify_cq = hns_roce_v2_modify_cq,
@@ -6737,6 +6794,8 @@ static const struct hns_roce_hw hns_roce_hw_v2 = {
 	.query_hw_counter = hns_roce_hw_v2_query_counter,
 	.hns_roce_dev_ops = &hns_roce_v2_dev_ops,
 	.hns_roce_dev_srq_ops = &hns_roce_v2_dev_srq_ops,
+	.config_scc_param = hns_roce_v2_config_scc_param,
+	.query_scc_param = hns_roce_v2_query_scc_param,
 };
 
 static const struct pci_device_id hns_roce_hw_v2_pci_tbl[] = {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index df04bc8ede57..3167003c4f94 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -195,6 +195,10 @@ enum {
 /* CMQ command */
 enum hns_roce_opcode_type {
 	HNS_QUERY_FW_VER				= 0x0001,
+	HNS_ROCE_OPC_CFG_DCQCN_PARAM			= 0x1A80,
+	HNS_ROCE_OPC_CFG_LDCP_PARAM			= 0x1A81,
+	HNS_ROCE_OPC_CFG_HC3_PARAM			= 0x1A82,
+	HNS_ROCE_OPC_CFG_DIP_PARAM			= 0x1A83,
 	HNS_ROCE_OPC_QUERY_HW_VER			= 0x8000,
 	HNS_ROCE_OPC_CFG_GLOBAL_PARAM			= 0x8001,
 	HNS_ROCE_OPC_ALLOC_PF_RES			= 0x8004,
@@ -1429,6 +1433,134 @@ struct hns_roce_wqe_atomic_seg {
 	__le64          cmp_data;
 };
 
+#define HNS_ROCE_DCQCN_AI_OFS 0
+#define HNS_ROCE_DCQCN_AI_SZ sizeof(u16)
+#define HNS_ROCE_DCQCN_AI_MAX ((u16)(~0U))
+#define HNS_ROCE_DCQCN_F_OFS (HNS_ROCE_DCQCN_AI_OFS + HNS_ROCE_DCQCN_AI_SZ)
+#define HNS_ROCE_DCQCN_F_SZ sizeof(u8)
+#define HNS_ROCE_DCQCN_F_MAX ((u8)(~0U))
+#define HNS_ROCE_DCQCN_TKP_OFS (HNS_ROCE_DCQCN_F_OFS + HNS_ROCE_DCQCN_F_SZ)
+#define HNS_ROCE_DCQCN_TKP_SZ sizeof(u8)
+#define HNS_ROCE_DCQCN_TKP_MAX 15
+#define HNS_ROCE_DCQCN_TMP_OFS (HNS_ROCE_DCQCN_TKP_OFS + HNS_ROCE_DCQCN_TKP_SZ)
+#define HNS_ROCE_DCQCN_TMP_SZ sizeof(u16)
+#define HNS_ROCE_DCQCN_TMP_MAX 15
+#define HNS_ROCE_DCQCN_ALP_OFS (HNS_ROCE_DCQCN_TMP_OFS + HNS_ROCE_DCQCN_TMP_SZ)
+#define HNS_ROCE_DCQCN_ALP_SZ sizeof(u16)
+#define HNS_ROCE_DCQCN_ALP_MAX ((u16)(~0U))
+#define HNS_ROCE_DCQCN_MAX_SPEED_OFS (HNS_ROCE_DCQCN_ALP_OFS + \
+					HNS_ROCE_DCQCN_ALP_SZ)
+#define HNS_ROCE_DCQCN_MAX_SPEED_SZ sizeof(u32)
+#define HNS_ROCE_DCQCN_MAX_SPEED_MAX ((u32)(~0U))
+#define HNS_ROCE_DCQCN_G_OFS (HNS_ROCE_DCQCN_MAX_SPEED_OFS + \
+					HNS_ROCE_DCQCN_MAX_SPEED_SZ)
+#define HNS_ROCE_DCQCN_G_SZ sizeof(u8)
+#define HNS_ROCE_DCQCN_G_MAX 15
+#define HNS_ROCE_DCQCN_AL_OFS (HNS_ROCE_DCQCN_G_OFS + HNS_ROCE_DCQCN_G_SZ)
+#define HNS_ROCE_DCQCN_AL_SZ sizeof(u8)
+#define HNS_ROCE_DCQCN_AL_MAX ((u8)(~0U))
+#define HNS_ROCE_DCQCN_CNP_TIME_OFS (HNS_ROCE_DCQCN_AL_OFS + \
+					HNS_ROCE_DCQCN_AL_SZ)
+#define HNS_ROCE_DCQCN_CNP_TIME_SZ sizeof(u8)
+#define HNS_ROCE_DCQCN_CNP_TIME_MAX ((u8)(~0U))
+#define HNS_ROCE_DCQCN_ASHIFT_OFS (HNS_ROCE_DCQCN_CNP_TIME_OFS + \
+					HNS_ROCE_DCQCN_CNP_TIME_SZ)
+#define HNS_ROCE_DCQCN_ASHIFT_SZ sizeof(u8)
+#define HNS_ROCE_DCQCN_ASHIFT_MAX 15
+#define HNS_ROCE_DCQCN_LIFESPAN_OFS (HNS_ROCE_DCQCN_ASHIFT_OFS + \
+					HNS_ROCE_DCQCN_ASHIFT_SZ)
+#define HNS_ROCE_DCQCN_LIFESPAN_SZ sizeof(u32)
+#define HNS_ROCE_DCQCN_LIFESPAN_MAX 1000
+
+#define HNS_ROCE_LDCP_CWD0_OFS 0
+#define HNS_ROCE_LDCP_CWD0_SZ sizeof(u32)
+#define HNS_ROCE_LDCP_CWD0_MAX ((u32)(~0U))
+#define HNS_ROCE_LDCP_ALPHA_OFS (HNS_ROCE_LDCP_CWD0_OFS + HNS_ROCE_LDCP_CWD0_SZ)
+#define HNS_ROCE_LDCP_ALPHA_SZ sizeof(u8)
+#define HNS_ROCE_LDCP_ALPHA_MAX ((u8)(~0U))
+#define HNS_ROCE_LDCP_GAMMA_OFS (HNS_ROCE_LDCP_ALPHA_OFS + \
+					HNS_ROCE_LDCP_ALPHA_SZ)
+#define HNS_ROCE_LDCP_GAMMA_SZ sizeof(u8)
+#define HNS_ROCE_LDCP_GAMMA_MAX ((u8)(~0U))
+#define HNS_ROCE_LDCP_BETA_OFS (HNS_ROCE_LDCP_GAMMA_OFS + \
+					HNS_ROCE_LDCP_GAMMA_SZ)
+#define HNS_ROCE_LDCP_BETA_SZ sizeof(u8)
+#define HNS_ROCE_LDCP_BETA_MAX ((u8)(~0U))
+#define HNS_ROCE_LDCP_ETA_OFS (HNS_ROCE_LDCP_BETA_OFS + HNS_ROCE_LDCP_BETA_SZ)
+#define HNS_ROCE_LDCP_ETA_SZ sizeof(u8)
+#define HNS_ROCE_LDCP_ETA_MAX ((u8)(~0U))
+#define HNS_ROCE_LDCP_LIFESPAN_OFS (4 * sizeof(u32))
+#define HNS_ROCE_LDCP_LIFESPAN_SZ sizeof(u32)
+#define HNS_ROCE_LDCP_LIFESPAN_MAX 1000
+
+#define HNS_ROCE_HC3_INITIAL_WINDOW_OFS 0
+#define HNS_ROCE_HC3_INITIAL_WINDOW_SZ sizeof(u32)
+#define HNS_ROCE_HC3_INITIAL_WINDOW_MAX ((u32)(~0U))
+#define HNS_ROCE_HC3_BANDWIDTH_OFS (HNS_ROCE_HC3_INITIAL_WINDOW_OFS + \
+					HNS_ROCE_HC3_INITIAL_WINDOW_SZ)
+#define HNS_ROCE_HC3_BANDWIDTH_SZ sizeof(u32)
+#define HNS_ROCE_HC3_BANDWIDTH_MAX ((u32)(~0U))
+#define HNS_ROCE_HC3_QLEN_SHIFT_OFS (HNS_ROCE_HC3_BANDWIDTH_OFS + \
+					HNS_ROCE_HC3_BANDWIDTH_SZ)
+#define HNS_ROCE_HC3_QLEN_SHIFT_SZ sizeof(u8)
+#define HNS_ROCE_HC3_QLEN_SHIFT_MAX ((u8)(~0U))
+#define HNS_ROCE_HC3_PORT_USAGE_SHIFT_OFS (HNS_ROCE_HC3_QLEN_SHIFT_OFS + \
+						HNS_ROCE_HC3_QLEN_SHIFT_SZ)
+#define HNS_ROCE_HC3_PORT_USAGE_SHIFT_SZ sizeof(u8)
+#define HNS_ROCE_HC3_PORT_USAGE_SHIFT_MAX ((u8)(~0U))
+#define HNS_ROCE_HC3_OVER_PERIOD_OFS (HNS_ROCE_HC3_PORT_USAGE_SHIFT_OFS + \
+					HNS_ROCE_HC3_PORT_USAGE_SHIFT_SZ)
+#define HNS_ROCE_HC3_OVER_PERIOD_SZ sizeof(u8)
+#define HNS_ROCE_HC3_OVER_PERIOD_MAX ((u8)(~0U))
+#define HNS_ROCE_HC3_MAX_STAGE_OFS (HNS_ROCE_HC3_OVER_PERIOD_OFS + \
+					HNS_ROCE_HC3_OVER_PERIOD_SZ)
+#define HNS_ROCE_HC3_MAX_STAGE_SZ sizeof(u8)
+#define HNS_ROCE_HC3_MAX_STAGE_MAX ((u8)(~0U))
+#define HNS_ROCE_HC3_GAMMA_SHIFT_OFS (HNS_ROCE_HC3_MAX_STAGE_OFS + \
+					HNS_ROCE_HC3_MAX_STAGE_SZ)
+#define HNS_ROCE_HC3_GAMMA_SHIFT_SZ sizeof(u8)
+#define HNS_ROCE_HC3_GAMMA_SHIFT_MAX 15
+#define HNS_ROCE_HC3_LIFESPAN_OFS (4 * sizeof(u32))
+#define HNS_ROCE_HC3_LIFESPAN_SZ sizeof(u32)
+#define HNS_ROCE_HC3_LIFESPAN_MAX 1000
+
+#define HNS_ROCE_DIP_AI_OFS 0
+#define HNS_ROCE_DIP_AI_SZ sizeof(u16)
+#define HNS_ROCE_DIP_AI_MAX ((u16)(~0U))
+#define HNS_ROCE_DIP_F_OFS (HNS_ROCE_DIP_AI_OFS + HNS_ROCE_DIP_AI_SZ)
+#define HNS_ROCE_DIP_F_SZ sizeof(u8)
+#define HNS_ROCE_DIP_F_MAX ((u8)(~0U))
+#define HNS_ROCE_DIP_TKP_OFS (HNS_ROCE_DIP_F_OFS + HNS_ROCE_DIP_F_SZ)
+#define HNS_ROCE_DIP_TKP_SZ sizeof(u8)
+#define HNS_ROCE_DIP_TKP_MAX 15
+#define HNS_ROCE_DIP_TMP_OFS (HNS_ROCE_DIP_TKP_OFS + HNS_ROCE_DIP_TKP_SZ)
+#define HNS_ROCE_DIP_TMP_SZ sizeof(u16)
+#define HNS_ROCE_DIP_TMP_MAX 15
+#define HNS_ROCE_DIP_ALP_OFS (HNS_ROCE_DIP_TMP_OFS + HNS_ROCE_DIP_TMP_SZ)
+#define HNS_ROCE_DIP_ALP_SZ sizeof(u16)
+#define HNS_ROCE_DIP_ALP_MAX ((u16)(~0U))
+#define HNS_ROCE_DIP_MAX_SPEED_OFS (HNS_ROCE_DIP_ALP_OFS + HNS_ROCE_DIP_ALP_SZ)
+#define HNS_ROCE_DIP_MAX_SPEED_SZ sizeof(u32)
+#define HNS_ROCE_DIP_MAX_SPEED_MAX ((u32)(~0U))
+#define HNS_ROCE_DIP_G_OFS (HNS_ROCE_DIP_MAX_SPEED_OFS + \
+				HNS_ROCE_DIP_MAX_SPEED_SZ)
+#define HNS_ROCE_DIP_G_SZ sizeof(u8)
+#define HNS_ROCE_DIP_G_MAX 15
+#define HNS_ROCE_DIP_AL_OFS (HNS_ROCE_DIP_G_OFS + HNS_ROCE_DIP_G_SZ)
+#define HNS_ROCE_DIP_AL_SZ sizeof(u8)
+#define HNS_ROCE_DIP_AL_MAX ((u8)(~0U))
+#define HNS_ROCE_DIP_CNP_TIME_OFS (HNS_ROCE_DIP_AL_OFS + HNS_ROCE_DIP_AL_SZ)
+#define HNS_ROCE_DIP_CNP_TIME_SZ sizeof(u8)
+#define HNS_ROCE_DIP_CNP_TIME_MAX ((u8)(~0U))
+#define HNS_ROCE_DIP_ASHIFT_OFS (HNS_ROCE_DIP_CNP_TIME_OFS + \
+					HNS_ROCE_DIP_CNP_TIME_SZ)
+#define HNS_ROCE_DIP_ASHIFT_SZ sizeof(u8)
+#define HNS_ROCE_DIP_ASHIFT_MAX 15
+#define HNS_ROCE_DIP_LIFESPAN_OFS (HNS_ROCE_DIP_ASHIFT_OFS + \
+					HNS_ROCE_DIP_ASHIFT_SZ)
+#define HNS_ROCE_DIP_LIFESPAN_SZ sizeof(u32)
+#define HNS_ROCE_DIP_LIFESPAN_MAX 1000
+
 struct hns_roce_sccc_clr {
 	__le32 qpn;
 	__le32 rsv[5];
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 1dc60c2b2b7a..f0d7bf3f0d67 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -636,6 +636,7 @@ static const struct ib_device_ops hns_roce_dev_ops = {
 	.query_pkey = hns_roce_query_pkey,
 	.query_port = hns_roce_query_port,
 	.reg_user_mr = hns_roce_reg_user_mr,
+	.port_groups = hns_attr_port_groups,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, hns_roce_ah, ibah),
 	INIT_RDMA_OBJ_SIZE(ib_cq, hns_roce_cq, ib_cq),
@@ -1110,6 +1111,7 @@ int hns_roce_init(struct hns_roce_dev *hr_dev)
 		goto error_failed_register_device;
 
 	hns_roce_register_debugfs(hr_dev);
+	hns_roce_register_sysfs(hr_dev);
 
 	return 0;
 
@@ -1143,6 +1145,7 @@ int hns_roce_init(struct hns_roce_dev *hr_dev)
 
 void hns_roce_exit(struct hns_roce_dev *hr_dev)
 {
+	hns_roce_unregister_sysfs(hr_dev);
 	hns_roce_unregister_debugfs(hr_dev);
 	hns_roce_unregister_device(hr_dev);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_sysfs.c b/drivers/infiniband/hw/hns/hns_roce_sysfs.c
new file mode 100644
index 000000000000..4600144dceff
--- /dev/null
+++ b/drivers/infiniband/hw/hns/hns_roce_sysfs.c
@@ -0,0 +1,346 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright (c) 2024 Hisilicon Limited.
+ */
+
+#include <rdma/ib_sysfs.h>
+
+#include "hnae3.h"
+#include "hns_roce_device.h"
+#include "hns_roce_hw_v2.h"
+
+static void scc_param_config_work(struct work_struct *work)
+{
+	struct hns_roce_scc_param *scc_param = container_of(work,
+			struct hns_roce_scc_param, scc_cfg_dwork.work);
+	struct hns_roce_dev *hr_dev = scc_param->hr_dev;
+
+	hr_dev->hw->config_scc_param(hr_dev, scc_param->algo_type);
+}
+
+static void get_default_scc_param(struct hns_roce_dev *hr_dev)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < CONG_TYPE_TOTAL; i++) {
+		hr_dev->scc_param[i].timestamp = jiffies;
+		ret = hr_dev->hw->query_scc_param(hr_dev, i);
+		if (ret && ret != -EOPNOTSUPP)
+			ibdev_warn_ratelimited(&hr_dev->ib_dev,
+					       "failed to get default parameters of scc algo %d, ret = %d.\n",
+					       i, ret);
+	}
+}
+
+static int alloc_scc_param(struct hns_roce_dev *hr_dev)
+{
+	struct hns_roce_scc_param *scc_param;
+	int i;
+
+	scc_param = kvcalloc(CONG_TYPE_TOTAL, sizeof(*scc_param),
+			     GFP_KERNEL);
+	if (!scc_param)
+		return -ENOMEM;
+
+	for (i = 0; i < CONG_TYPE_TOTAL; i++) {
+		scc_param[i].algo_type = i;
+		scc_param[i].hr_dev = hr_dev;
+		INIT_DELAYED_WORK(&scc_param[i].scc_cfg_dwork,
+				  scc_param_config_work);
+	}
+
+	hr_dev->scc_param = scc_param;
+
+	get_default_scc_param(hr_dev);
+
+	return 0;
+}
+
+struct hns_port_cc_attr {
+	struct ib_port_attribute port_attr;
+	enum hns_roce_cong_type algo_type;
+	u32 offset;
+	u32 size;
+	u32 max;
+	u32 min;
+};
+
+static int scc_attr_check(struct hns_roce_dev *hr_dev,
+			  struct hns_port_cc_attr *scc_attr, u32 port_num)
+{
+	if (port_num > hr_dev->caps.num_ports)
+		return -ENODEV;
+
+	if (WARN_ON(scc_attr->size > sizeof(u32)))
+		return -EINVAL;
+
+	if (WARN_ON(scc_attr->algo_type >= CONG_TYPE_TOTAL))
+		return -EINVAL;
+
+	return 0;
+}
+
+static ssize_t scc_attr_show(struct ib_device *ibdev, u32 port_num,
+			     struct ib_port_attribute *attr, char *buf)
+{
+	struct hns_port_cc_attr *scc_attr =
+		container_of(attr, struct hns_port_cc_attr, port_attr);
+	struct hns_roce_dev *hr_dev = to_hr_dev(ibdev);
+	struct hns_roce_scc_param *scc_param;
+	__le32 val = 0;
+	int ret;
+
+	ret = scc_attr_check(hr_dev, scc_attr, port_num);
+	if (ret)
+		return ret;
+
+	scc_param = &hr_dev->scc_param[scc_attr->algo_type];
+
+	memcpy(&val, (void *)scc_param + scc_attr->offset, scc_attr->size);
+
+	return sysfs_emit(buf, "%u\n", le32_to_cpu(val));
+}
+
+static ssize_t scc_attr_store(struct ib_device *ibdev, u32 port_num,
+			      struct ib_port_attribute *attr, const char *buf,
+			      size_t count)
+{
+	struct hns_port_cc_attr *scc_attr =
+		container_of(attr, struct hns_port_cc_attr, port_attr);
+	struct hns_roce_dev *hr_dev = to_hr_dev(ibdev);
+	struct hns_roce_scc_param *scc_param;
+	unsigned long lifespan_jiffies;
+	unsigned long exp_time;
+	__le32 attr_val;
+	u32 val;
+	int ret;
+
+	ret = scc_attr_check(hr_dev, scc_attr, port_num);
+	if (ret)
+		return ret;
+
+	if (kstrtou32(buf, 0, &val))
+		return -EINVAL;
+
+	if (val > scc_attr->max || val < scc_attr->min)
+		return -EINVAL;
+
+	attr_val = cpu_to_le32(val);
+	scc_param = &hr_dev->scc_param[scc_attr->algo_type];
+	memcpy((void *)scc_param + scc_attr->offset, &attr_val,
+	       scc_attr->size);
+
+	/* lifespan is only used for driver */
+	if (scc_attr->offset >= offsetof(typeof(*scc_param), lifespan))
+		return count;
+
+	lifespan_jiffies = msecs_to_jiffies(scc_param->lifespan);
+	exp_time = scc_param->timestamp + lifespan_jiffies;
+
+	if (time_is_before_eq_jiffies(exp_time)) {
+		scc_param->timestamp = jiffies;
+		queue_delayed_work(hr_dev->irq_workq, &scc_param->scc_cfg_dwork,
+				   lifespan_jiffies);
+	}
+
+	return count;
+}
+
+static umode_t scc_attr_is_visible(struct kobject *kobj,
+				   struct attribute *attr, int i)
+{
+	struct ib_port_attribute *port_attr =
+		container_of(attr, struct ib_port_attribute, attr);
+	struct hns_port_cc_attr *scc_attr =
+		container_of(port_attr, struct hns_port_cc_attr, port_attr);
+	u32 port_num;
+	struct ib_device *ibdev = ib_port_sysfs_get_ibdev_kobj(kobj, &port_num);
+	struct hns_roce_dev *hr_dev = to_hr_dev(ibdev);
+
+	if (hr_dev->is_vf ||
+	    !(hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL))
+		return 0;
+
+	if (!(hr_dev->caps.cong_cap & (1 << scc_attr->algo_type)))
+		return 0;
+
+	return 0644;
+}
+
+#define __HNS_SCC_ATTR(_name, _type, _offset, _size, _min, _max) {		\
+	.port_attr = __ATTR(_name, 0644, scc_attr_show,  scc_attr_store),	\
+	.algo_type = _type,							\
+	.offset = _offset,							\
+	.size = _size,								\
+	.min = _min,								\
+	.max = _max,								\
+}
+
+#define HNS_PORT_DCQCN_CC_ATTR_RW(_name, NAME)				\
+	struct hns_port_cc_attr hns_roce_port_attr_dcqcn_##_name =	\
+	__HNS_SCC_ATTR(_name, CONG_TYPE_DCQCN,				\
+			HNS_ROCE_DCQCN_##NAME##_OFS,			\
+			HNS_ROCE_DCQCN_##NAME##_SZ,			\
+			0, HNS_ROCE_DCQCN_##NAME##_MAX)
+
+HNS_PORT_DCQCN_CC_ATTR_RW(ai, AI);
+HNS_PORT_DCQCN_CC_ATTR_RW(f, F);
+HNS_PORT_DCQCN_CC_ATTR_RW(tkp, TKP);
+HNS_PORT_DCQCN_CC_ATTR_RW(tmp, TMP);
+HNS_PORT_DCQCN_CC_ATTR_RW(alp, ALP);
+HNS_PORT_DCQCN_CC_ATTR_RW(max_speed, MAX_SPEED);
+HNS_PORT_DCQCN_CC_ATTR_RW(g, G);
+HNS_PORT_DCQCN_CC_ATTR_RW(al, AL);
+HNS_PORT_DCQCN_CC_ATTR_RW(cnp_time, CNP_TIME);
+HNS_PORT_DCQCN_CC_ATTR_RW(ashift, ASHIFT);
+HNS_PORT_DCQCN_CC_ATTR_RW(lifespan, LIFESPAN);
+
+static struct attribute *dcqcn_param_attrs[] = {
+	&hns_roce_port_attr_dcqcn_ai.port_attr.attr,
+	&hns_roce_port_attr_dcqcn_f.port_attr.attr,
+	&hns_roce_port_attr_dcqcn_tkp.port_attr.attr,
+	&hns_roce_port_attr_dcqcn_tmp.port_attr.attr,
+	&hns_roce_port_attr_dcqcn_alp.port_attr.attr,
+	&hns_roce_port_attr_dcqcn_max_speed.port_attr.attr,
+	&hns_roce_port_attr_dcqcn_g.port_attr.attr,
+	&hns_roce_port_attr_dcqcn_al.port_attr.attr,
+	&hns_roce_port_attr_dcqcn_cnp_time.port_attr.attr,
+	&hns_roce_port_attr_dcqcn_ashift.port_attr.attr,
+	&hns_roce_port_attr_dcqcn_lifespan.port_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group dcqcn_cc_param_group = {
+	.name = "dcqcn_cc_param",
+	.attrs = dcqcn_param_attrs,
+	.is_visible = scc_attr_is_visible,
+};
+
+#define HNS_PORT_LDCP_CC_ATTR_RW(_name, NAME)				\
+	struct hns_port_cc_attr hns_roce_port_attr_ldcp_##_name =	\
+	__HNS_SCC_ATTR(_name, CONG_TYPE_LDCP,				\
+			HNS_ROCE_LDCP_##NAME##_OFS,			\
+			HNS_ROCE_LDCP_##NAME##_SZ,			\
+			0, HNS_ROCE_LDCP_##NAME##_MAX)
+
+HNS_PORT_LDCP_CC_ATTR_RW(cwd0, CWD0);
+HNS_PORT_LDCP_CC_ATTR_RW(alpha, ALPHA);
+HNS_PORT_LDCP_CC_ATTR_RW(gamma, GAMMA);
+HNS_PORT_LDCP_CC_ATTR_RW(beta, BETA);
+HNS_PORT_LDCP_CC_ATTR_RW(eta, ETA);
+HNS_PORT_LDCP_CC_ATTR_RW(lifespan, LIFESPAN);
+
+static struct attribute *ldcp_param_attrs[] = {
+	&hns_roce_port_attr_ldcp_cwd0.port_attr.attr,
+	&hns_roce_port_attr_ldcp_alpha.port_attr.attr,
+	&hns_roce_port_attr_ldcp_gamma.port_attr.attr,
+	&hns_roce_port_attr_ldcp_beta.port_attr.attr,
+	&hns_roce_port_attr_ldcp_eta.port_attr.attr,
+	&hns_roce_port_attr_ldcp_lifespan.port_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ldcp_cc_param_group = {
+	.name = "ldcp_cc_param",
+	.attrs = ldcp_param_attrs,
+	.is_visible = scc_attr_is_visible,
+};
+
+#define HNS_PORT_HC3_CC_ATTR_RW(_name, NAME)				\
+	struct hns_port_cc_attr hns_roce_port_attr_hc3_##_name =	\
+	__HNS_SCC_ATTR(_name, CONG_TYPE_HC3,				\
+			HNS_ROCE_HC3_##NAME##_OFS,			\
+			HNS_ROCE_HC3_##NAME##_SZ,			\
+			0, HNS_ROCE_HC3_##NAME##_MAX)
+
+HNS_PORT_HC3_CC_ATTR_RW(initial_window, INITIAL_WINDOW);
+HNS_PORT_HC3_CC_ATTR_RW(bandwidth, BANDWIDTH);
+HNS_PORT_HC3_CC_ATTR_RW(qlen_shift, QLEN_SHIFT);
+HNS_PORT_HC3_CC_ATTR_RW(port_usage_shift, PORT_USAGE_SHIFT);
+HNS_PORT_HC3_CC_ATTR_RW(over_period, OVER_PERIOD);
+HNS_PORT_HC3_CC_ATTR_RW(max_stage, MAX_STAGE);
+HNS_PORT_HC3_CC_ATTR_RW(gamma_shift, GAMMA_SHIFT);
+HNS_PORT_HC3_CC_ATTR_RW(lifespan, LIFESPAN);
+
+static struct attribute *hc3_param_attrs[] = {
+	&hns_roce_port_attr_hc3_initial_window.port_attr.attr,
+	&hns_roce_port_attr_hc3_bandwidth.port_attr.attr,
+	&hns_roce_port_attr_hc3_qlen_shift.port_attr.attr,
+	&hns_roce_port_attr_hc3_port_usage_shift.port_attr.attr,
+	&hns_roce_port_attr_hc3_over_period.port_attr.attr,
+	&hns_roce_port_attr_hc3_max_stage.port_attr.attr,
+	&hns_roce_port_attr_hc3_gamma_shift.port_attr.attr,
+	&hns_roce_port_attr_hc3_lifespan.port_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group hc3_cc_param_group = {
+	.name = "hc3_cc_param",
+	.attrs = hc3_param_attrs,
+	.is_visible = scc_attr_is_visible,
+};
+
+#define HNS_PORT_DIP_CC_ATTR_RW(_name, NAME)				\
+	struct hns_port_cc_attr hns_roce_port_attr_dip_##_name =	\
+	__HNS_SCC_ATTR(_name, CONG_TYPE_DIP,				\
+			HNS_ROCE_DIP_##NAME##_OFS,			\
+			HNS_ROCE_DIP_##NAME##_SZ,			\
+			0, HNS_ROCE_DIP_##NAME##_MAX)
+
+HNS_PORT_DIP_CC_ATTR_RW(ai, AI);
+HNS_PORT_DIP_CC_ATTR_RW(f, F);
+HNS_PORT_DIP_CC_ATTR_RW(tkp, TKP);
+HNS_PORT_DIP_CC_ATTR_RW(tmp, TMP);
+HNS_PORT_DIP_CC_ATTR_RW(alp, ALP);
+HNS_PORT_DIP_CC_ATTR_RW(max_speed, MAX_SPEED);
+HNS_PORT_DIP_CC_ATTR_RW(g, G);
+HNS_PORT_DIP_CC_ATTR_RW(al, AL);
+HNS_PORT_DIP_CC_ATTR_RW(cnp_time, CNP_TIME);
+HNS_PORT_DIP_CC_ATTR_RW(ashift, ASHIFT);
+HNS_PORT_DIP_CC_ATTR_RW(lifespan, LIFESPAN);
+
+static struct attribute *dip_param_attrs[] = {
+	&hns_roce_port_attr_dip_ai.port_attr.attr,
+	&hns_roce_port_attr_dip_f.port_attr.attr,
+	&hns_roce_port_attr_dip_tkp.port_attr.attr,
+	&hns_roce_port_attr_dip_tmp.port_attr.attr,
+	&hns_roce_port_attr_dip_alp.port_attr.attr,
+	&hns_roce_port_attr_dip_max_speed.port_attr.attr,
+	&hns_roce_port_attr_dip_g.port_attr.attr,
+	&hns_roce_port_attr_dip_al.port_attr.attr,
+	&hns_roce_port_attr_dip_cnp_time.port_attr.attr,
+	&hns_roce_port_attr_dip_ashift.port_attr.attr,
+	&hns_roce_port_attr_dip_lifespan.port_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group dip_cc_param_group = {
+	.name = "dip_cc_param",
+	.attrs = dip_param_attrs,
+	.is_visible = scc_attr_is_visible,
+};
+
+const struct attribute_group *hns_attr_port_groups[] = {
+	&dcqcn_cc_param_group,
+	&ldcp_cc_param_group,
+	&hc3_cc_param_group,
+	&dip_cc_param_group,
+	NULL,
+};
+
+void hns_roce_register_sysfs(struct hns_roce_dev *hr_dev)
+{
+	int ret;
+
+	ret = alloc_scc_param(hr_dev);
+	if (ret)
+		dev_err(hr_dev->dev, "alloc scc param failed, ret = %d!\n",
+			ret);
+}
+
+void hns_roce_unregister_sysfs(struct hns_roce_dev *hr_dev)
+{
+	if (hr_dev->scc_param)
+		kvfree(hr_dev->scc_param);
+}
-- 
2.30.0


