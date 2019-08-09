Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 423F9876D9
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2019 12:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbfHIKBY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Aug 2019 06:01:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49852 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726152AbfHIKBY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 9 Aug 2019 06:01:24 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CE9A3AAEFD90F4BBB567;
        Fri,  9 Aug 2019 17:45:31 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Fri, 9 Aug 2019 17:45:21 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 9/9] RDMA/hns: Copy some information of AV to user
Date:   Fri, 9 Aug 2019 17:41:06 +0800
Message-ID: <1565343666-73193-10-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1565343666-73193-1-git-send-email-oulijun@huawei.com>
References: <1565343666-73193-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When the driver support UD transport in user mode, it needs to
create the Address Handle(AH) and transfer Address Vector to
The hardware. The Address Vector includes the destination mac
and vlan inforation and it will be generated from the kernel
driver. As a result, we can copy this information to user
through ib_copy_to_udata function.

Signed-off-by: Lijun Ou <oulijun@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_ah.c     | 22 ++++++++++++++++++----
 drivers/infiniband/hw/hns/hns_roce_device.h |  3 ++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  3 ++-
 drivers/infiniband/hw/hns/hns_roce_main.c   |  7 +++++++
 include/uapi/rdma/hns-abi.h                 |  7 +++++++
 5 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_ah.c b/drivers/infiniband/hw/hns/hns_roce_ah.c
index cdd2ac2..eee53be 100644
--- a/drivers/infiniband/hw/hns/hns_roce_ah.c
+++ b/drivers/infiniband/hw/hns/hns_roce_ah.c
@@ -31,6 +31,7 @@
  */
 
 #include <linux/platform_device.h>
+#include <rdma/hns-abi.h>
 #include <rdma/ib_addr.h>
 #include <rdma/ib_cache.h>
 #include "hns_roce_device.h"
@@ -43,13 +44,14 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_attr *ah_attr,
 		       u32 flags, struct ib_udata *udata)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibah->device);
+	struct hns_roce_ib_create_ah_resp resp = {};
 	const struct ib_gid_attr *gid_attr;
 	struct device *dev = hr_dev->dev;
 	struct hns_roce_ah *ah = to_hr_ah(ibah);
 	u16 vlan_tag = 0xffff;
 	const struct ib_global_route *grh = rdma_ah_read_grh(ah_attr);
-	bool vlan_en = false;
-	int ret;
+	u8 vlan_en = 0;
+	int ret = 0;
 
 	gid_attr = ah_attr->grh.sgid_attr;
 	ret = rdma_read_gid_l2_fields(gid_attr, &vlan_tag, NULL);
@@ -60,7 +62,7 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_attr *ah_attr,
 	memcpy(ah->av.mac, ah_attr->roce.dmac, ETH_ALEN);
 
 	if (vlan_tag < VLAN_CFI_MASK) {
-		vlan_en = true;
+		vlan_en = 1;
 		vlan_tag |= (rdma_ah_get_sl(ah_attr) &
 			     HNS_ROCE_VLAN_SL_BIT_MASK) <<
 			     HNS_ROCE_VLAN_SL_SHIFT;
@@ -80,7 +82,19 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_attr *ah_attr,
 
 	memcpy(ah->av.dgid, grh->dgid.raw, HNS_ROCE_GID_SIZE);
 	ah->av.sl_tclass_flowlabel = cpu_to_le32(rdma_ah_get_sl(ah_attr) <<
-						 HNS_ROCE_SL_SHIFT);
+				i		 HNS_ROCE_SL_SHIFT);
+
+       if (udata) {
+               memcpy(resp.dmac, ah_attr->roce.dmac, ETH_ALEN);
+               resp.vlan = vlan_tag;
+               resp.vlan_en = vlan_en;
+               ret = ib_copy_to_udata(udata, &resp,
+                                      min(udata->outlen, sizeof(resp)));
+               if (ret) {
+                       kfree(ah);
+                       return ret;
+               }
+       }
 
 	return 0;
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index be65fce..e703912 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -217,6 +217,7 @@ enum {
 	HNS_ROCE_CAP_FLAG_FRMR                  = BIT(8),
 	HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL		= BIT(9),
 	HNS_ROCE_CAP_FLAG_ATOMIC		= BIT(10),
+	HNS_ROCE_CAP_FLAG_UD			= BIT(11),
 };
 
 enum hns_roce_mtt_type {
@@ -578,7 +579,7 @@ struct hns_roce_av {
 	u8          dgid[HNS_ROCE_GID_SIZE];
 	u8          mac[ETH_ALEN];
 	__le16      vlan;
-	bool	    vlan_en;
+	u8	    vlan_en;
 };
 
 struct hns_roce_ah {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 138e5a8..71166e7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1653,7 +1653,8 @@ static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
 	if (hr_dev->pci_dev->revision == 0x21) {
 		caps->flags |= HNS_ROCE_CAP_FLAG_ATOMIC |
 			       HNS_ROCE_CAP_FLAG_SRQ |
-			       HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL;
+			       HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL |
+			       HNS_ROCE_CAP_FLAG_UD;
 
 		caps->num_qpc_timer	  = HNS_ROCE_V2_MAX_QPC_TIMER_NUM;
 		caps->qpc_timer_entry_sz  = HNS_ROCE_V2_QPC_TIMER_ENTRY_SZ;
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 1bda7a5..ba9594c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -550,6 +550,13 @@ static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
 		if (ret)
 			return ret;
 	}
+
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_UD) {
+		ib_dev->uverbs_cmd_mask |=
+					(1ULL << IB_USER_VERBS_CMD_CREATE_AH) |
+					(1ULL << IB_USER_VERBS_CMD_DESTROY_AH);
+	}
+
 	ret = ib_register_device(ib_dev, "hns_%d");
 	if (ret) {
 		dev_err(dev, "ib_register_device failed!\n");
diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
index eb76b38..6a2d994 100644
--- a/include/uapi/rdma/hns-abi.h
+++ b/include/uapi/rdma/hns-abi.h
@@ -80,4 +80,11 @@ struct hns_roce_ib_alloc_pd_resp {
 	__u32 pdn;
 };
 
+struct hns_roce_ib_create_ah_resp {
+	__u8	dmac[6];
+	__u16	vlan;
+	__u8	vlan_en;
+	__u8	reserved[7];
+};
+
 #endif /* HNS_ABI_USER_H */
-- 
1.9.1

