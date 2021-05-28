Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE712394005
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 11:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhE1Jer (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 05:34:47 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5130 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhE1Jer (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 05:34:47 -0400
Received: from dggeml752-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Frztt4PTszYn7m;
        Fri, 28 May 2021 17:30:30 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggeml752-chm.china.huawei.com (10.1.199.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 17:33:10 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 17:33:10 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH rdma-core 2/4] libhns: Refactor hns uar mmap flow
Date:   Fri, 28 May 2021 17:32:57 +0800
Message-ID: <1622194379-59868-3-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622194379-59868-1-git-send-email-liweihang@huawei.com>
References: <1622194379-59868-1-git-send-email-liweihang@huawei.com>
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
for rdma io mmap.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 providers/hns/hns_roce_u.c | 76 ++++++++++++++++++++++++++++++----------------
 providers/hns/hns_roce_u.h | 12 ++++++++
 2 files changed, 61 insertions(+), 27 deletions(-)

diff --git a/providers/hns/hns_roce_u.c b/providers/hns/hns_roce_u.c
index 3b31ad3..2d9c46f 100644
--- a/providers/hns/hns_roce_u.c
+++ b/providers/hns/hns_roce_u.c
@@ -95,16 +95,58 @@ static const struct verbs_context_ops hns_common_ops = {
 	.get_srq_num = hns_roce_u_get_srq_num,
 };
 
-static struct verbs_context *hns_roce_alloc_context(struct ibv_device *ibdev,
-						    int cmd_fd,
-						    void *private_data)
+static off_t get_uar_mmap_offset(unsigned long idx, int page_size, int cmd)
+{
+	off_t offset = 0;
+
+	hns_roce_mmap_set_command(cmd, &offset);
+	hns_roce_mmap_set_index(idx, &offset);
+
+	return offset * page_size;
+}
+
+static int hns_roce_mmap(struct hns_roce_device *hr_dev,
+			 struct hns_roce_context *context, int cmd_fd)
+{
+	int page_size = hr_dev->page_size;
+	off_t offset;
+
+	offset = get_uar_mmap_offset(0, page_size, HNS_ROCE_MMAP_REGULAR_PAGE);
+	context->uar = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+			    MAP_SHARED, cmd_fd, offset);
+	if (context->uar == MAP_FAILED)
+		return -EINVAL;
+
+	offset = get_uar_mmap_offset(1, page_size, HNS_ROCE_MMAP_REGULAR_PAGE);
+
+	if (hr_dev->hw_version == HNS_ROCE_HW_VER1) {
+		/*
+		 * when vma->vm_pgoff is 1, the cq_tptr_base includes 64K CQ,
+		 * a pointer of CQ need 2B size
+		 */
+		context->cq_tptr_base = mmap(NULL, HNS_ROCE_CQ_DB_BUF_SIZE,
+					     PROT_READ | PROT_WRITE, MAP_SHARED,
+					     cmd_fd, offset);
+		if (context->cq_tptr_base == MAP_FAILED)
+			goto db_free;
+	}
+
+	return 0;
+
+db_free:
+	munmap(context->uar, hr_dev->page_size);
+
+	return -EINVAL;
+}
+
+static struct verbs_context *
+hns_roce_alloc_context(struct ibv_device *ibdev, int cmd_fd, void *private_data)
 {
 	struct hns_roce_device *hr_dev = to_hr_dev(ibdev);
 	struct hns_roce_alloc_ucontext_resp resp = {};
 	struct ibv_device_attr dev_attrs;
 	struct hns_roce_context *context;
 	struct ibv_get_context cmd;
-	int offset = 0;
 	int i;
 
 	context = verbs_init_and_alloc_context(ibdev, cmd_fd, context, ibv_ctx,
@@ -154,35 +196,15 @@ static struct verbs_context *hns_roce_alloc_context(struct ibv_device *ibdev,
 	context->max_srq_wr = dev_attrs.max_srq_wr;
 	context->max_srq_sge = dev_attrs.max_srq_sge;
 
-	context->uar = mmap(NULL, hr_dev->page_size, PROT_READ | PROT_WRITE,
-			    MAP_SHARED, cmd_fd, offset);
-	if (context->uar == MAP_FAILED)
-		goto err_free;
-
-	offset += hr_dev->page_size;
-
-	if (hr_dev->hw_version == HNS_ROCE_HW_VER1) {
-		/*
-		 * when vma->vm_pgoff is 1, the cq_tptr_base includes 64K CQ,
-		 * a pointer of CQ need 2B size
-		 */
-		context->cq_tptr_base = mmap(NULL, HNS_ROCE_CQ_DB_BUF_SIZE,
-					     PROT_READ | PROT_WRITE, MAP_SHARED,
-					     cmd_fd, offset);
-		if (context->cq_tptr_base == MAP_FAILED)
-			goto db_free;
-	}
-
 	pthread_spin_init(&context->uar_lock, PTHREAD_PROCESS_PRIVATE);
 
 	verbs_set_ops(&context->ibv_ctx, &hns_common_ops);
 	verbs_set_ops(&context->ibv_ctx, &hr_dev->u_hw->hw_ops);
 
-	return &context->ibv_ctx;
+	if (hns_roce_mmap(hr_dev, context, cmd_fd))
+		goto err_free;
 
-db_free:
-	munmap(context->uar, hr_dev->page_size);
-	context->uar = NULL;
+	return &context->ibv_ctx;
 
 err_free:
 	verbs_uninit_context(&context->ibv_ctx);
diff --git a/providers/hns/hns_roce_u.h b/providers/hns/hns_roce_u.h
index 0d7abd8..3c4b162 100644
--- a/providers/hns/hns_roce_u.h
+++ b/providers/hns/hns_roce_u.h
@@ -357,6 +357,18 @@ static inline struct hns_roce_ah *to_hr_ah(struct ibv_ah *ibv_ah)
 	return container_of(ibv_ah, struct hns_roce_ah, ibv_ah);
 }
 
+/* command value is offset[15:8] */
+static inline void hns_roce_mmap_set_command(int command, off_t *offset)
+{
+	*offset |= (command & 0xff) << 8;
+}
+
+/* index value is offset[63:16] | offset[7:0] */
+static inline void hns_roce_mmap_set_index(unsigned long index, off_t *offset)
+{
+	*offset |= (index & 0xff) | ((index >> 8) << 16);
+}
+
 int hns_roce_u_query_device(struct ibv_context *context,
 			    const struct ibv_query_device_ex_input *input,
 			    struct ibv_device_attr_ex *attr, size_t attr_size);
-- 
2.7.4

