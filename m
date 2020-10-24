Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAD6297A77
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Oct 2020 05:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759231AbgJXDIw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Oct 2020 23:08:52 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2173 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1759236AbgJXDIv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 23 Oct 2020 23:08:51 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0DF153719DB3C9AD1325;
        Sat, 24 Oct 2020 11:08:48 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Sat, 24 Oct 2020 11:08:38 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 2/2] RDMA/hns: Add support for filling GMV table
Date:   Sat, 24 Oct 2020 11:07:16 +0800
Message-ID: <1603508836-33054-3-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1603508836-33054-1-git-send-email-liweihang@huawei.com>
References: <1603508836-33054-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add a interface to fill GMV(SGID/SMAC/VLAN) table for HIP09, all of above
source address information is stored as an entry in GMV table. The users
just need to provide the index to the hardware when POST SEND.

Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 107 +++++++++++++++++++++--------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  31 +++++++++
 drivers/infiniband/hw/hns/hns_roce_main.c  |   9 ++-
 3 files changed, 116 insertions(+), 31 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index d6b04fd..b3f1428 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2688,14 +2688,27 @@ static int hns_roce_v2_chk_mbox(struct hns_roce_dev *hr_dev,
 	return 0;
 }
 
-static int hns_roce_config_sgid_table(struct hns_roce_dev *hr_dev,
-				      int gid_index, const union ib_gid *gid,
-				      enum hns_roce_sgid_type sgid_type)
+static void copy_gid(void *dest, const union ib_gid *gid)
+{
+#define GID_SIZE 4
+	const union ib_gid *src = gid;
+	__le32 (*p)[GID_SIZE] = dest;
+	int i;
+
+	if (!gid)
+		src = &zgid;
+
+	for (i = 0; i < GID_SIZE; i++)
+		(*p)[i] = cpu_to_le32(*(u32 *)&src->raw[i * sizeof(u32)]);
+}
+
+static int config_sgid_table(struct hns_roce_dev *hr_dev,
+			     int gid_index, const union ib_gid *gid,
+			     enum hns_roce_sgid_type sgid_type)
 {
 	struct hns_roce_cmq_desc desc;
 	struct hns_roce_cfg_sgid_tb *sgid_tb =
 				    (struct hns_roce_cfg_sgid_tb *)desc.data;
-	u32 *p;
 
 	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_CFG_SGID_TB, false);
 
@@ -2704,19 +2717,54 @@ static int hns_roce_config_sgid_table(struct hns_roce_dev *hr_dev,
 	roce_set_field(sgid_tb->vf_sgid_type_rsv, CFG_SGID_TB_VF_SGID_TYPE_M,
 		       CFG_SGID_TB_VF_SGID_TYPE_S, sgid_type);
 
-	p = (u32 *)&gid->raw[0];
-	sgid_tb->vf_sgid_l = cpu_to_le32(*p);
+	copy_gid(&sgid_tb->vf_sgid_l, gid);
+
+	return hns_roce_cmq_send(hr_dev, &desc, 1);
+}
 
-	p = (u32 *)&gid->raw[4];
-	sgid_tb->vf_sgid_ml = cpu_to_le32(*p);
+static int config_gmv_table(struct hns_roce_dev *hr_dev,
+			    int gid_index, const union ib_gid *gid,
+			    enum hns_roce_sgid_type sgid_type,
+			    const struct ib_gid_attr *attr)
+{
+	struct hns_roce_cmq_desc desc[2];
+	struct hns_roce_cfg_gmv_tb_a *tb_a =
+				(struct hns_roce_cfg_gmv_tb_a *)desc[0].data;
+	struct hns_roce_cfg_gmv_tb_b *tb_b =
+				(struct hns_roce_cfg_gmv_tb_b *)desc[1].data;
 
-	p = (u32 *)&gid->raw[8];
-	sgid_tb->vf_sgid_mh = cpu_to_le32(*p);
+	u16 vlan_id = VLAN_CFI_MASK;
+	u8 mac[ETH_ALEN] = {};
+	int ret;
 
-	p = (u32 *)&gid->raw[0xc];
-	sgid_tb->vf_sgid_h = cpu_to_le32(*p);
+	if (gid) {
+		ret = rdma_read_gid_l2_fields(attr, &vlan_id, mac);
+		if (ret)
+			return ret;
+	}
 
-	return hns_roce_cmq_send(hr_dev, &desc, 1);
+	hns_roce_cmq_setup_basic_desc(&desc[0], HNS_ROCE_OPC_CFG_GMV_TBL, false);
+	desc[0].flag |= cpu_to_le16(HNS_ROCE_CMD_FLAG_NEXT);
+
+	hns_roce_cmq_setup_basic_desc(&desc[1], HNS_ROCE_OPC_CFG_GMV_TBL, false);
+
+	copy_gid(&tb_a->vf_sgid_l, gid);
+
+	roce_set_field(tb_a->vf_sgid_type_vlan, CFG_GMV_TB_VF_SGID_TYPE_M,
+		       CFG_GMV_TB_VF_SGID_TYPE_S, sgid_type);
+	roce_set_bit(tb_a->vf_sgid_type_vlan, CFG_GMV_TB_VF_VLAN_EN_S,
+		     vlan_id < VLAN_CFI_MASK);
+	roce_set_field(tb_a->vf_sgid_type_vlan, CFG_GMV_TB_VF_VLAN_ID_M,
+		       CFG_GMV_TB_VF_VLAN_ID_S, vlan_id);
+
+	tb_b->vf_smac_l = cpu_to_le32(*(u32 *)mac);
+	roce_set_field(tb_b->vf_smac_h, CFG_GMV_TB_SMAC_H_M,
+		       CFG_GMV_TB_SMAC_H_S, *(u16 *)&mac[4]);
+
+	roce_set_field(tb_b->table_idx_rsv, CFG_GMV_TB_SGID_IDX_M,
+		       CFG_GMV_TB_SGID_IDX_S, gid_index);
+
+	return hns_roce_cmq_send(hr_dev, desc, 2);
 }
 
 static int hns_roce_v2_set_gid(struct hns_roce_dev *hr_dev, u8 port,
@@ -2726,23 +2774,24 @@ static int hns_roce_v2_set_gid(struct hns_roce_dev *hr_dev, u8 port,
 	enum hns_roce_sgid_type sgid_type = GID_TYPE_FLAG_ROCE_V1;
 	int ret;
 
-	if (!gid || !attr)
-		return -EINVAL;
-
-	if (attr->gid_type == IB_GID_TYPE_ROCE)
-		sgid_type = GID_TYPE_FLAG_ROCE_V1;
-
-	if (attr->gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP) {
-		if (ipv6_addr_v4mapped((void *)gid))
-			sgid_type = GID_TYPE_FLAG_ROCE_V2_IPV4;
-		else
-			sgid_type = GID_TYPE_FLAG_ROCE_V2_IPV6;
+	if (gid) {
+		if (attr->gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP) {
+			if (ipv6_addr_v4mapped((void *)gid))
+				sgid_type = GID_TYPE_FLAG_ROCE_V2_IPV4;
+			else
+				sgid_type = GID_TYPE_FLAG_ROCE_V2_IPV6;
+		} else if (attr->gid_type == IB_GID_TYPE_ROCE) {
+			sgid_type = GID_TYPE_FLAG_ROCE_V1;
+		}
 	}
 
-	ret = hns_roce_config_sgid_table(hr_dev, gid_index, gid, sgid_type);
+	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09)
+		ret = config_gmv_table(hr_dev, gid_index, gid, sgid_type, attr);
+	else
+		ret = config_sgid_table(hr_dev, gid_index, gid, sgid_type);
+
 	if (ret)
-		ibdev_err(&hr_dev->ib_dev,
-			  "failed to configure sgid table, ret = %d!\n",
+		ibdev_err(&hr_dev->ib_dev, "failed to set gid, ret = %d!\n",
 			  ret);
 
 	return ret;
@@ -4483,7 +4532,9 @@ static int hns_roce_v2_set_path(struct ib_qp *ibqp,
 				 IB_GID_TYPE_ROCE_UDP_ENCAP);
 	}
 
-	if (vlan_id < VLAN_N_VID) {
+	/* Only HIP08 needs to set the vlan_en bits in QPC */
+	if (vlan_id < VLAN_N_VID &&
+	    hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08) {
 		roce_set_bit(context->byte_76_srqn_op_en,
 			     V2_QPC_BYTE_76_RQ_VLAN_EN_S, 1);
 		roce_set_bit(qpc_mask->byte_76_srqn_op_en,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 65204e7..1409d05 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -243,6 +243,7 @@ enum hns_roce_opcode_type {
 	HNS_ROCE_OPC_CLR_SCCC				= 0x8509,
 	HNS_ROCE_OPC_QUERY_SCCC				= 0x850a,
 	HNS_ROCE_OPC_RESET_SCCC				= 0x850b,
+	HNS_ROCE_OPC_CFG_GMV_TBL			= 0x850f,
 	HNS_ROCE_OPC_CFG_GMV_BT				= 0x8510,
 	HNS_SWITCH_PARAMETER_CFG			= 0x1033,
 };
@@ -1602,6 +1603,36 @@ struct hns_roce_cfg_gmv_bt {
 #define CFG_GMV_BA_H_S 0
 #define CFG_GMV_BA_H_M GENMASK(19, 0)
 
+struct hns_roce_cfg_gmv_tb_a {
+	__le32 vf_sgid_l;
+	__le32 vf_sgid_ml;
+	__le32 vf_sgid_mh;
+	__le32 vf_sgid_h;
+	__le32 vf_sgid_type_vlan;
+	__le32 resv;
+};
+
+#define CFG_GMV_TB_SGID_IDX_S 0
+#define CFG_GMV_TB_SGID_IDX_M GENMASK(7, 0)
+
+#define CFG_GMV_TB_VF_SGID_TYPE_S 0
+#define CFG_GMV_TB_VF_SGID_TYPE_M GENMASK(1, 0)
+
+#define CFG_GMV_TB_VF_VLAN_EN_S 2
+
+#define CFG_GMV_TB_VF_VLAN_ID_S 16
+#define CFG_GMV_TB_VF_VLAN_ID_M GENMASK(27, 16)
+
+struct hns_roce_cfg_gmv_tb_b {
+	__le32	vf_smac_l;
+	__le32	vf_smac_h;
+	__le32	table_idx_rsv;
+	__le32	resv[3];
+};
+
+#define CFG_GMV_TB_SMAC_H_S 0
+#define CFG_GMV_TB_SMAC_H_M GENMASK(15, 0)
+
 #define HNS_ROCE_QUERY_PF_CAPS_CMD_NUM 5
 struct hns_roce_query_pf_caps_a {
 	u8 number_ports;
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 78112fa..4478d78 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -33,6 +33,7 @@
 #include <linux/acpi.h>
 #include <linux/of_platform.h>
 #include <linux/module.h>
+#include <linux/pci.h>
 #include <rdma/ib_addr.h>
 #include <rdma/ib_smi.h>
 #include <rdma/ib_user_verbs.h>
@@ -61,7 +62,10 @@ int hns_get_gid_index(struct hns_roce_dev *hr_dev, u8 port, int gid_index)
 static int hns_roce_set_mac(struct hns_roce_dev *hr_dev, u8 port, u8 *addr)
 {
 	u8 phy_port;
-	u32 i = 0;
+	u32 i;
+
+	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09)
+		return 0;
 
 	if (!memcmp(hr_dev->dev_addr[port], addr, ETH_ALEN))
 		return 0;
@@ -90,14 +94,13 @@ static int hns_roce_add_gid(const struct ib_gid_attr *attr, void **context)
 static int hns_roce_del_gid(const struct ib_gid_attr *attr, void **context)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(attr->device);
-	struct ib_gid_attr zattr = {};
 	u8 port = attr->port_num - 1;
 	int ret;
 
 	if (port >= hr_dev->caps.num_ports)
 		return -EINVAL;
 
-	ret = hr_dev->hw->set_gid(hr_dev, port, attr->index, &zgid, &zattr);
+	ret = hr_dev->hw->set_gid(hr_dev, port, attr->index, NULL, NULL);
 
 	return ret;
 }
-- 
2.8.1

