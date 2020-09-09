Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1CE262B21
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Sep 2020 10:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgIII6w (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Sep 2020 04:58:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11280 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730140AbgIII6u (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 9 Sep 2020 04:58:50 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9CADD295260F79284669;
        Wed,  9 Sep 2020 16:58:48 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Wed, 9 Sep 2020 16:58:41 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 2/9] RDMA/hns: Add type check in get/set hw field
Date:   Wed, 9 Sep 2020 16:57:27 +0800
Message-ID: <1599641854-23160-3-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1599641854-23160-1-git-send-email-liweihang@huawei.com>
References: <1599641854-23160-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

roce_get_field() and roce_set_field() are only used to set variables in
type of __le32, add checks for type to avoid inappropriate assignments.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_common.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_common.h b/drivers/infiniband/hw/hns/hns_roce_common.h
index f5669ff..bb440af 100644
--- a/drivers/infiniband/hw/hns/hns_roce_common.h
+++ b/drivers/infiniband/hw/hns/hns_roce_common.h
@@ -38,16 +38,18 @@
 #define roce_raw_write(value, addr) \
 	__raw_writel((__force u32)cpu_to_le32(value), (addr))
 
-#define roce_get_field(origin, mask, shift) \
-	(((le32_to_cpu(origin)) & (mask)) >> (shift))
+#define roce_get_field(origin, mask, shift)                                    \
+	(((le32_to_cpu(origin) & (mask)) >> (shift)) +                         \
+	 (BUILD_BUG_ON_ZERO(!__same_type(__le32, (origin)))))
 
 #define roce_get_bit(origin, shift) \
 	roce_get_field((origin), (1ul << (shift)), (shift))
 
-#define roce_set_field(origin, mask, shift, val) \
-	do { \
-		(origin) &= ~cpu_to_le32(mask); \
-		(origin) |= cpu_to_le32(((u32)(val) << (shift)) & (mask)); \
+#define roce_set_field(origin, mask, shift, val)                               \
+	do {                                                                   \
+		BUILD_BUG_ON(!__same_type(__le32, (origin)));                  \
+		(origin) &= ~cpu_to_le32(mask);                                \
+		(origin) |= cpu_to_le32(((u32)(val) << (shift)) & (mask));     \
 	} while (0)
 
 #define roce_set_bit(origin, shift, val) \
-- 
2.8.1

