Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720534B963F
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Feb 2022 04:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbiBQDBu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Feb 2022 22:01:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbiBQDBs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Feb 2022 22:01:48 -0500
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2229F17A99
        for <linux-rdma@vger.kernel.org>; Wed, 16 Feb 2022 19:01:32 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V4fho6b_1645066890;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V4fho6b_1645066890)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Feb 2022 11:01:31 +0800
From:   Cheng Xu <chengyou.xc@alibaba-inc.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, chengyou@linux.alibaba.com,
        tonylu@linux.alibaba.com
Subject: [PATCH for-next v3 11/12] RDMA/erdma: Add the ABI definitions
Date:   Thu, 17 Feb 2022 11:01:15 +0800
Message-Id: <20220217030116.6324-12-chengyou.xc@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220217030116.6324-1-chengyou.xc@alibaba-inc.com>
References: <20220217030116.6324-1-chengyou.xc@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Cheng Xu <chengyou@linux.alibaba.com>

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 include/uapi/rdma/erdma-abi.h | 49 +++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 include/uapi/rdma/erdma-abi.h

diff --git a/include/uapi/rdma/erdma-abi.h b/include/uapi/rdma/erdma-abi.h
new file mode 100644
index 000000000000..cd409b9cfca8
--- /dev/null
+++ b/include/uapi/rdma/erdma-abi.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
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

