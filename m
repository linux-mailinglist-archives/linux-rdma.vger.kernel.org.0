Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4AD581D56
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Jul 2022 03:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240194AbiG0Btu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Jul 2022 21:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240206AbiG0Bts (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Jul 2022 21:49:48 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81CC37F8D
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jul 2022 18:49:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VKYVUWr_1658886579;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VKYVUWr_1658886579)
          by smtp.aliyun-inc.com;
          Wed, 27 Jul 2022 09:49:40 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com,
        chengyou@linux.alibaba.com, tonylu@linux.alibaba.com
Subject: [PATCH for-next v14 10/11] RDMA/erdma: Add the ABI definitions
Date:   Wed, 27 Jul 2022 09:49:26 +0800
Message-Id: <20220727014927.76564-11-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220727014927.76564-1-chengyou@linux.alibaba.com>
References: <20220727014927.76564-1-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add erdma ABI definitions which will be shared between kernel and
userspace. This commit also fix compile issues reported by lkp.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 include/uapi/rdma/erdma-abi.h | 49 +++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 include/uapi/rdma/erdma-abi.h

diff --git a/include/uapi/rdma/erdma-abi.h b/include/uapi/rdma/erdma-abi.h
new file mode 100644
index 000000000000..fcbaff1d84c3
--- /dev/null
+++ b/include/uapi/rdma/erdma-abi.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/*
+ * Copyright (c) 2020-2022, Alibaba Group.
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
-- 
2.27.0

