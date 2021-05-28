Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C68393FBE
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 11:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234926AbhE1JUy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 05:20:54 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2446 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235640AbhE1JUx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 05:20:53 -0400
Received: from dggeml765-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FrzZc1pL3z66vd;
        Fri, 28 May 2021 17:16:24 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggeml765-chm.china.huawei.com (10.1.199.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 17:19:17 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 17:19:17 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, "Xi Wang" <wangxi11@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 1/2] RDMA/hns: Refactor hns uar mmap flow
Date:   Fri, 28 May 2021 17:19:04 +0800
Message-ID: <1622193545-3281-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622193545-3281-1-git-send-email-liweihang@huawei.com>
References: <1622193545-3281-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Classify the uar address by wrapping the uar type and start page as offset
for hns rdma io mmap.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_main.c | 27 ++++++++++++++++++++++++---
 include/uapi/rdma/hns-abi.h               |  4 ++++
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 6c6e82b..00dbbf1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -338,12 +338,23 @@ static void hns_roce_dealloc_ucontext(struct ib_ucontext *ibcontext)
 	hns_roce_uar_free(to_hr_dev(ibcontext->device), &context->uar);
 }
 
-static int hns_roce_mmap(struct ib_ucontext *context,
-			 struct vm_area_struct *vma)
+/* command value is offset[15:8] */
+static inline int hns_roce_mmap_get_command(unsigned long offset)
+{
+	return (offset >> 8) & 0xff;
+}
+
+/* index value is offset[63:16] | offset[7:0] */
+static inline unsigned long hns_roce_mmap_get_index(unsigned long offset)
+{
+	return ((offset >> 16) << 8) | (offset & 0xff);
+}
+
+static int mmap_uar(struct ib_ucontext *context, struct vm_area_struct *vma)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(context->device);
 
-	switch (vma->vm_pgoff) {
+	switch (hns_roce_mmap_get_index(vma->vm_pgoff)) {
 	case 0:
 		return rdma_user_mmap_io(context, vma,
 					 to_hr_ucontext(context)->uar.pfn,
@@ -370,6 +381,16 @@ static int hns_roce_mmap(struct ib_ucontext *context,
 	}
 }
 
+static int hns_roce_mmap(struct ib_ucontext *uctx, struct vm_area_struct *vma)
+{
+	switch (hns_roce_mmap_get_command(vma->vm_pgoff)) {
+	case HNS_ROCE_MMAP_REGULAR_PAGE:
+		return mmap_uar(uctx, vma);
+	default:
+		return -EINVAL;
+	}
+}
+
 static int hns_roce_port_immutable(struct ib_device *ib_dev, u32 port_num,
 				   struct ib_port_immutable *immutable)
 {
diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
index 42b1776..18529d7 100644
--- a/include/uapi/rdma/hns-abi.h
+++ b/include/uapi/rdma/hns-abi.h
@@ -94,4 +94,8 @@ struct hns_roce_ib_alloc_pd_resp {
 	__u32 pdn;
 };
 
+enum {
+	HNS_ROCE_MMAP_REGULAR_PAGE,
+};
+
 #endif /* HNS_ABI_USER_H */
-- 
2.7.4

