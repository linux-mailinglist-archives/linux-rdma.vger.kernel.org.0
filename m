Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2785747EC50
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Dec 2021 07:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351625AbhLXGza (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Dec 2021 01:55:30 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:47162 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351621AbhLXGza (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Dec 2021 01:55:30 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V.bvQR2_1640328927;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V.bvQR2_1640328927)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 24 Dec 2021 14:55:27 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     leon@kernel.org
Cc:     dledford@redhat.com, jgg@mellanox.com, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, chengyou@linux.alibaba.com
Subject: [PATCH rdma-core 4/5] RDMA-CORE/erdma: Add the application interface
Date:   Fri, 24 Dec 2021 14:55:21 +0800
Message-Id: <20211224065522.29734-5-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20211224065522.29734-1-chengyou@linux.alibaba.com>
References: <20211224065522.29734-1-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add the application interface to rdma-core, and make rdma-core can
recogize erdma provider.

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 kernel-headers/rdma/erdma-abi.h           | 49 +++++++++++++++++++++++
 kernel-headers/rdma/ib_user_ioctl_verbs.h |  1 +
 libibverbs/verbs.h                        |  1 +
 providers/erdma/erdma_abi.h               | 21 ++++++++++
 4 files changed, 72 insertions(+)
 create mode 100644 kernel-headers/rdma/erdma-abi.h
 create mode 100644 providers/erdma/erdma_abi.h

diff --git a/kernel-headers/rdma/erdma-abi.h b/kernel-headers/rdma/erdma-abi.h
new file mode 100644
index 00000000..e3ceef30
--- /dev/null
+++ b/kernel-headers/rdma/erdma-abi.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
+/*
+ * Copyright (c) 2020-2021, Alibaba Group.
+ */
+
+#ifndef __ERDMA_USER_H__
+#define __ERDMA_USER_H__
+
+#include <linux/types.h>
+
+#define ERDMA_ABI_VERSION       1
+
+struct erdma_ureq_create_cq {
+	__u64 db_record_va;
+	__u64 qbuf_va;
+	__u32 qbuf_len;
+	__u32 rsvd0;
+};
+
+struct erdma_uresp_create_cq {
+	__u32 cq_id;
+	__u32 num_cqe;
+};
+
+struct erdma_ureq_create_qp {
+	__u64 db_record_va;
+	__u64 qbuf_va;
+	__u32 qbuf_len;
+	__u32 rsvd0;
+};
+
+struct erdma_uresp_create_qp {
+	__u32 qp_id;
+	__u32 num_sqe;
+	__u32 num_rqe;
+	__u32 rq_offset;
+};
+
+struct erdma_uresp_alloc_ctx {
+	__u32 dev_id;
+	__u32 pad;
+	__u32 sdb_type;
+	__u32 sdb_offset;
+	__u64 sdb;
+	__u64 rdb;
+	__u64 cdb;
+};
+
+#endif
diff --git a/kernel-headers/rdma/ib_user_ioctl_verbs.h b/kernel-headers/rdma/ib_user_ioctl_verbs.h
index 3072e5d6..7dd56210 100644
--- a/kernel-headers/rdma/ib_user_ioctl_verbs.h
+++ b/kernel-headers/rdma/ib_user_ioctl_verbs.h
@@ -250,6 +250,7 @@ enum rdma_driver_id {
 	RDMA_DRIVER_QIB,
 	RDMA_DRIVER_EFA,
 	RDMA_DRIVER_SIW,
+	RDMA_DRIVER_ERDMA,
 };
 
 enum ib_uverbs_gid_type {
diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
index 36b41425..c2165ec1 100644
--- a/libibverbs/verbs.h
+++ b/libibverbs/verbs.h
@@ -2221,6 +2221,7 @@ extern const struct verbs_device_ops verbs_provider_rxe;
 extern const struct verbs_device_ops verbs_provider_siw;
 extern const struct verbs_device_ops verbs_provider_vmw_pvrdma;
 extern const struct verbs_device_ops verbs_provider_all;
+extern const struct verbs_device_ops verbs_provider_erdma;
 extern const struct verbs_device_ops verbs_provider_none;
 void ibv_static_providers(void *unused, ...);
 
diff --git a/providers/erdma/erdma_abi.h b/providers/erdma/erdma_abi.h
new file mode 100644
index 00000000..d95cbf34
--- /dev/null
+++ b/providers/erdma/erdma_abi.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 or OpenIB.org BSD (MIT) See COPYING file */
+/*
+ * Authors: Cheng Xu <chengyou@linux.alibaba.com>
+ * Copyright (c) 2020-2021, Alibaba Group.
+ */
+
+#ifndef __ERDMA_ABI_H__
+#define __ERDMA_ABI_H__
+
+#include <infiniband/kern-abi.h>
+#include <rdma/erdma-abi.h>
+#include <kernel-abi/erdma-abi.h>
+
+DECLARE_DRV_CMD(erdma_cmd_alloc_context, IB_USER_VERBS_CMD_GET_CONTEXT,
+		empty, erdma_uresp_alloc_ctx);
+DECLARE_DRV_CMD(erdma_cmd_create_cq, IB_USER_VERBS_CMD_CREATE_CQ,
+		erdma_ureq_create_cq, erdma_uresp_create_cq);
+DECLARE_DRV_CMD(erdma_cmd_create_qp, IB_USER_VERBS_CMD_CREATE_QP,
+		erdma_ureq_create_qp, erdma_uresp_create_qp);
+
+#endif
-- 
2.27.0

