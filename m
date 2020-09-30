Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98E227E53F
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Sep 2020 11:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbgI3Jfl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Sep 2020 05:35:41 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38856 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728800AbgI3Jfl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 30 Sep 2020 05:35:41 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4DC24B9E052EBED74954;
        Wed, 30 Sep 2020 17:35:38 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Wed, 30 Sep 2020 17:35:29 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 2/3] RDMA/hns: Add new interfaces to set/clear/read fields in QPC
Date:   Wed, 30 Sep 2020 17:34:11 +0800
Message-ID: <1601458452-55263-3-git-send-email-liweihang@huawei.com>
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

For a field in extended QPC, there are four newly added interfaces:
- hr_reg_set(arr, field) can set all bits to 1,
- hr_reg_clear(arr, field) can clear all bits to 0,
- hr_reg_write(arr, field, val) can write a new value,
- hr_reg_read(arr, field) can read the value.
'arr' is the array name of extended QPC, and 'field' is the global bit
offset of the whole array.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_common.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_common.h b/drivers/infiniband/hw/hns/hns_roce_common.h
index f5669ff..ab2386d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_common.h
+++ b/drivers/infiniband/hw/hns/hns_roce_common.h
@@ -53,6 +53,32 @@
 #define roce_set_bit(origin, shift, val) \
 	roce_set_field((origin), (1ul << (shift)), (shift), (val))
 
+#define hr_reg_set(arr, field)                                                 \
+	((arr)[(field) / 32] |=                                                \
+	 cpu_to_le32((field##_W) +                                             \
+		     BUILD_BUG_ON_ZERO((field) / 32 >= ARRAY_SIZE(arr))))
+
+#define hr_reg_clear(arr, field)                                               \
+	((arr)[(field) / 32] &=                                                \
+	 ~cpu_to_le32((field##_W) +                                            \
+		      BUILD_BUG_ON_ZERO((field) / 32 >= ARRAY_SIZE(arr))))
+
+#define hr_reg_write(arr, field, val)                                          \
+	do {                                                                   \
+		BUILD_BUG_ON((field) / 32 >= ARRAY_SIZE(arr));                 \
+		(arr)[(field) / 32] &= ~cpu_to_le32(field##_W);                \
+		(arr)[(field) / 32] |= cpu_to_le32(                            \
+			((u32)(val) << ((field) % 32)) & (field##_W));         \
+	} while (0)
+
+#define hr_reg_read(arr, field)                                                \
+	(((le32_to_cpu((arr)[(field) / 32]) & (field##_W)) >> (field) % 32) +  \
+	 BUILD_BUG_ON_ZERO((field) / 32 >= ARRAY_SIZE(arr)))
+
+#define V3_GENMASK(h, l)                                                       \
+	GENMASK(((h) + BUILD_BUG_ON_ZERO(((h) / 32) != ((l) / 32))) % 32,      \
+		((l) + BUILD_BUG_ON_ZERO((h) < (l))) % 32)
+
 #define ROCEE_GLB_CFG_ROCEE_DB_SQ_MODE_S 3
 #define ROCEE_GLB_CFG_ROCEE_DB_OTH_MODE_S 4
 
-- 
2.8.1

