Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB4E6C0C74
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Mar 2023 09:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjCTIrF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Mar 2023 04:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjCTIrE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Mar 2023 04:47:04 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F4F11C
        for <linux-rdma@vger.kernel.org>; Mon, 20 Mar 2023 01:47:03 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VeEwJsX_1679302019;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VeEwJsX_1679302019)
          by smtp.aliyun-inc.com;
          Mon, 20 Mar 2023 16:47:00 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: [PATCH for-rc 2/4] RDMA/erdma: Update default EQ depth to 4096 and max_send_wr to 8192
Date:   Mon, 20 Mar 2023 16:46:50 +0800
Message-Id: <20230320084652.16807-3-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20230320084652.16807-1-chengyou@linux.alibaba.com>
References: <20230320084652.16807-1-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Max EQ depth of hardware is 32K, the current default EQ depth is too small
for some applications, so change the default depth to 4096.
Max send WRs the hardware can support is 8K, but the driver limits the
value to 4K. Remove this limitation.

Fixes: be3cff0f242d ("RDMA/erdma: Add the hardware related definitions")
Fixes: db23ae64caac ("RDMA/erdma: Add verbs header file")
Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_hw.h    | 2 +-
 drivers/infiniband/hw/erdma/erdma_verbs.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_hw.h b/drivers/infiniband/hw/erdma/erdma_hw.h
index 5d3a541db941..37ad1bb1917c 100644
--- a/drivers/infiniband/hw/erdma/erdma_hw.h
+++ b/drivers/infiniband/hw/erdma/erdma_hw.h
@@ -441,7 +441,7 @@ struct erdma_reg_mr_sqe {
 };
 
 /* EQ related. */
-#define ERDMA_DEFAULT_EQ_DEPTH 256
+#define ERDMA_DEFAULT_EQ_DEPTH 4096
 
 /* ceqe */
 #define ERDMA_CEQE_HDR_DB_MASK BIT_ULL(63)
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.h b/drivers/infiniband/hw/erdma/erdma_verbs.h
index e0a993bc032a..131cf5f40982 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.h
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.h
@@ -11,7 +11,7 @@
 
 /* RDMA Capability. */
 #define ERDMA_MAX_PD (128 * 1024)
-#define ERDMA_MAX_SEND_WR 4096
+#define ERDMA_MAX_SEND_WR 8192
 #define ERDMA_MAX_ORD 128
 #define ERDMA_MAX_IRD 128
 #define ERDMA_MAX_SGE_RD 1
-- 
2.31.1

