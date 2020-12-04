Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF3A2CEC5E
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Dec 2020 11:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgLDKnK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Dec 2020 05:43:10 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8690 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbgLDKnK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Dec 2020 05:43:10 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CnTlz4TctzkkC6;
        Fri,  4 Dec 2020 18:41:51 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Fri, 4 Dec 2020 18:42:19 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 03/11] RDMA/hns: Do shift on traffic class when using RoCEv2
Date:   Fri, 4 Dec 2020 18:40:28 +0800
Message-ID: <1607078436-26455-4-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1607078436-26455-1-git-send-email-liweihang@huawei.com>
References: <1607078436-26455-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The high 6 bits of traffic class in GRH is DSCP (Differentiated Services
Codepoint), the driver should shift it before the hardware gets it when
using RoCEv2.

Fixes: 606bf89e98ef ("RDMA/hns: Refactor for hns_roce_v2_modify_qp function")
Fixes: fba429fcf9a5 ("RDMA/hns: Fix missing fields in address vector")
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_ah.c     |  2 +-
 drivers/infiniband/hw/hns/hns_roce_device.h |  8 ++++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 10 +++-------
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_ah.c b/drivers/infiniband/hw/hns/hns_roce_ah.c
index b09ef33..c9a44db 100644
--- a/drivers/infiniband/hw/hns/hns_roce_ah.c
+++ b/drivers/infiniband/hw/hns/hns_roce_ah.c
@@ -77,7 +77,7 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 	ah->av.flowlabel = grh->flow_label;
 	ah->av.udp_sport = get_ah_udp_sport(ah_attr);
 	ah->av.sl = rdma_ah_get_sl(ah_attr);
-	ah->av.tclass = grh->traffic_class;
+	ah->av.tclass = get_tclass(grh);
 
 	memcpy(ah->av.dgid, grh->dgid.raw, HNS_ROCE_GID_SIZE);
 	memcpy(ah->av.mac, ah_attr->roce.dmac, ETH_ALEN);
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index a5c6bb0..c7044f7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1157,6 +1157,14 @@ static inline u32 to_hr_hem_entries_shift(u32 count, u32 buf_shift)
 	return ilog2(to_hr_hem_entries_count(count, buf_shift));
 }
 
+#define DSCP_SHIFT 2
+
+static inline u8 get_tclass(const struct ib_global_route *grh)
+{
+	return grh->sgid_attr->gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP ?
+	       grh->traffic_class >> DSCP_SHIFT : grh->traffic_class;
+}
+
 int hns_roce_init_uar_table(struct hns_roce_dev *dev);
 int hns_roce_uar_alloc(struct hns_roce_dev *dev, struct hns_roce_uar *uar);
 void hns_roce_uar_free(struct hns_roce_dev *dev, struct hns_roce_uar *uar);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 8d37067..7a0c1ab 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4596,15 +4596,11 @@ static int hns_roce_v2_set_path(struct ib_qp *ibqp,
 	roce_set_field(qpc_mask->byte_24_mtu_tc, V2_QPC_BYTE_24_HOP_LIMIT_M,
 		       V2_QPC_BYTE_24_HOP_LIMIT_S, 0);
 
-	if (is_udp)
-		roce_set_field(context->byte_24_mtu_tc, V2_QPC_BYTE_24_TC_M,
-			       V2_QPC_BYTE_24_TC_S, grh->traffic_class >> 2);
-	else
-		roce_set_field(context->byte_24_mtu_tc, V2_QPC_BYTE_24_TC_M,
-			       V2_QPC_BYTE_24_TC_S, grh->traffic_class);
-
+	roce_set_field(context->byte_24_mtu_tc, V2_QPC_BYTE_24_TC_M,
+		       V2_QPC_BYTE_24_TC_S, get_tclass(&attr->ah_attr.grh));
 	roce_set_field(qpc_mask->byte_24_mtu_tc, V2_QPC_BYTE_24_TC_M,
 		       V2_QPC_BYTE_24_TC_S, 0);
+
 	roce_set_field(context->byte_28_at_fl, V2_QPC_BYTE_28_FL_M,
 		       V2_QPC_BYTE_28_FL_S, grh->flow_label);
 	roce_set_field(qpc_mask->byte_28_at_fl, V2_QPC_BYTE_28_FL_M,
-- 
2.8.1

