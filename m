Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504E647B880
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Dec 2021 03:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbhLUCtQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Dec 2021 21:49:16 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:52739 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233727AbhLUCtP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Dec 2021 21:49:15 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V.IQ3SD_1640054953;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V.IQ3SD_1640054953)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Dec 2021 10:49:14 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, chengyou@linux.alibaba.com,
        tonylu@linux.alibaba.com
Subject: [PATCH rdma-next 10/11] RDMA/erdma: Add the ABI definitions
Date:   Tue, 21 Dec 2021 10:48:57 +0800
Message-Id: <20211221024858.25938-11-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20211221024858.25938-1-chengyou@linux.alibaba.com>
References: <20211221024858.25938-1-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 include/uapi/rdma/erdma-abi.h | 49 +++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 include/uapi/rdma/erdma-abi.h

diff --git a/include/uapi/rdma/erdma-abi.h b/include/uapi/rdma/erdma-abi.h
new file mode 100644
index 000000000000..6bcba10c1e41
--- /dev/null
+++ b/include/uapi/rdma/erdma-abi.h
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
+	u64 db_record_va;
+	u64 qbuf_va;
+	u32 qbuf_len;
+	u32 rsvd0;
+};
+
+struct erdma_uresp_create_cq {
+	u32 cq_id;
+	u32 num_cqe;
+};
+
+struct erdma_ureq_create_qp {
+	u64 db_record_va;
+	u64 qbuf_va;
+	u32 qbuf_len;
+	u32 rsvd0;
+};
+
+struct erdma_uresp_create_qp {
+	u32 qp_id;
+	u32 num_sqe;
+	u32 num_rqe;
+	u32 rq_offset;
+};
+
+struct erdma_uresp_alloc_ctx {
+	u32 dev_id;
+	u32 pad;
+	u32 sdb_type;
+	u32 sdb_offset;
+	u64 sdb;
+	u64 rdb;
+	u64 cdb;
+};
+
+#endif
-- 
2.27.0

