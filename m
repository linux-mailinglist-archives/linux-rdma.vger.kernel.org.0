Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD9A1C5351
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2020 12:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgEEKa2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 May 2020 06:30:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3797 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728709AbgEEKa2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 5 May 2020 06:30:28 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8927FD416E451DA41F3D;
        Tue,  5 May 2020 18:30:25 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Tue, 5 May 2020 18:30:16 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 2/3] RDMA/hns: Extend capability flags for HIP08_C
Date:   Tue, 5 May 2020 18:30:06 +0800
Message-ID: <1588674607-25337-3-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1588674607-25337-1-git-send-email-liweihang@huawei.com>
References: <1588674607-25337-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

12 bits is not enough for HIP08_C, so extend a new field in length of 16
bits for it.

Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 2 ++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 3 +++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index c38ebce..6ecdd7dd 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -210,6 +210,8 @@ enum {
 	HNS_ROCE_OPCODE_RDMA_WITH_IMM_RECEIVE	= 0x07,
 };
 
+#define HNS_ROCE_CAP_FLAGS_EX_SHIFT 12
+
 enum {
 	HNS_ROCE_CAP_FLAG_REREG_MR		= BIT(0),
 	HNS_ROCE_CAP_FLAG_ROCE_V1_V2		= BIT(1),
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 2a8c389..500b4c3 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1786,6 +1786,9 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 	caps->flags = roce_get_field(resp_c->cap_flags_num_pds,
 				     V2_QUERY_PF_CAPS_C_CAP_FLAGS_M,
 				     V2_QUERY_PF_CAPS_C_CAP_FLAGS_S);
+	caps->flags |= le16_to_cpu(resp_d->cap_flags_ex) <<
+		       HNS_ROCE_CAP_FLAGS_EX_SHIFT;
+
 	caps->num_cqs = 1 << roce_get_field(resp_c->max_gid_num_cqs,
 					    V2_QUERY_PF_CAPS_C_NUM_CQS_M,
 					    V2_QUERY_PF_CAPS_C_NUM_CQS_S);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 82dd9f6..dc10506 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -1648,7 +1648,7 @@ struct hns_roce_query_pf_caps_c {
 struct hns_roce_query_pf_caps_d {
 	__le32 wq_hop_num_max_srqs;
 	__le16 srq_depth;
-	__le16 rsv;
+	__le16 cap_flags_ex;
 	__le32 num_ceqs_ceq_depth;
 	__le32 arm_st_aeq_depth;
 	__le32 num_uars_rsv_pds;
-- 
2.8.1

