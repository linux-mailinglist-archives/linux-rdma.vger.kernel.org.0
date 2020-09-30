Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9E027E541
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Sep 2020 11:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgI3Jfl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Sep 2020 05:35:41 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38860 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725836AbgI3Jfk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 30 Sep 2020 05:35:40 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 52FF17E631B9931BF86C;
        Wed, 30 Sep 2020 17:35:38 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Wed, 30 Sep 2020 17:35:28 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 1/3] RDMA/hns: Add support for CQ stash
Date:   Wed, 30 Sep 2020 17:34:10 +0800
Message-ID: <1601458452-55263-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1601458452-55263-1-git-send-email-liweihang@huawei.com>
References: <1601458452-55263-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

Stash is a mechanism that uses the core information carried by the ARM AXI
bus to access the L3 cache. It can be used to improve the performance by
increasing the hit ratio of L3 cache. CQs need to enable stash by default.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 1 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 3 +++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 6d2acff..87d3e57 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -221,6 +221,7 @@ enum {
 	HNS_ROCE_CAP_FLAG_FRMR                  = BIT(8),
 	HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL		= BIT(9),
 	HNS_ROCE_CAP_FLAG_ATOMIC		= BIT(10),
+	HNS_ROCE_CAP_FLAG_STASH			= BIT(17),
 };
 
 #define HNS_ROCE_DB_TYPE_COUNT			2
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 6d30850..154afc0 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -3059,6 +3059,9 @@ static void hns_roce_v2_write_cqc(struct hns_roce_dev *hr_dev,
 		       V2_CQC_BYTE_8_CQE_SIZE_S, hr_cq->cqe_size ==
 		       HNS_ROCE_V3_CQE_SIZE ? 1 : 0);
 
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_STASH)
+		roce_set_bit(cq_context->byte_8_cqn, V2_CQC_BYTE_8_STASH_S, 1);
+
 	cq_context->cqe_cur_blk_addr = cpu_to_le32(to_hr_hw_page_addr(mtts[0]));
 
 	roce_set_field(cq_context->byte_16_hop_addr,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 29c9dd4..cfa8caa 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -315,6 +315,8 @@ struct hns_roce_v2_cq_context {
 #define V2_CQC_BYTE_8_CQE_SIZE_S 27
 #define V2_CQC_BYTE_8_CQE_SIZE_M GENMASK(28, 27)
 
+#define V2_CQC_BYTE_8_STASH_S 31
+
 #define	V2_CQC_BYTE_16_CQE_CUR_BLK_ADDR_S 0
 #define V2_CQC_BYTE_16_CQE_CUR_BLK_ADDR_M GENMASK(19, 0)
 
-- 
2.8.1

