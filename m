Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE995B3427
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Sep 2022 11:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiIIJik (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Sep 2022 05:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbiIIJib (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Sep 2022 05:38:31 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68302A2AA3
        for <linux-rdma@vger.kernel.org>; Fri,  9 Sep 2022 02:38:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VP8vGWM_1662716306;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VP8vGWM_1662716306)
          by smtp.aliyun-inc.com;
          Fri, 09 Sep 2022 17:38:26 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: [PATCH for-next 3/4] RDMA/erdma: Make hardware internal opcodes invisible to driver
Date:   Fri,  9 Sep 2022 17:38:21 +0800
Message-Id: <20220909093822.33868-4-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220909093822.33868-1-chengyou@linux.alibaba.com>
References: <20220909093822.33868-1-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Some opcodes are used in hardware internally, and driver does not care
about them. So, we change them to reserved opcodes in driver.

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_cq.c | 1 -
 drivers/infiniband/hw/erdma/erdma_hw.h | 8 ++++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_cq.c b/drivers/infiniband/hw/erdma/erdma_cq.c
index 2f7390de35d7..58e0dc5c75d1 100644
--- a/drivers/infiniband/hw/erdma/erdma_cq.c
+++ b/drivers/infiniband/hw/erdma/erdma_cq.c
@@ -59,7 +59,6 @@ static const enum ib_wc_opcode wc_mapping_table[ERDMA_NUM_OPCODES] = {
 	[ERDMA_OP_RECV_IMM] = IB_WC_RECV_RDMA_WITH_IMM,
 	[ERDMA_OP_RECV_INV] = IB_WC_RECV,
 	[ERDMA_OP_WRITE_WITH_IMM] = IB_WC_RDMA_WRITE,
-	[ERDMA_OP_INVALIDATE] = IB_WC_LOCAL_INV,
 	[ERDMA_OP_RSP_SEND_IMM] = IB_WC_RECV,
 	[ERDMA_OP_SEND_WITH_INV] = IB_WC_SEND,
 	[ERDMA_OP_REG_MR] = IB_WC_REG_MR,
diff --git a/drivers/infiniband/hw/erdma/erdma_hw.h b/drivers/infiniband/hw/erdma/erdma_hw.h
index b210c49c669f..3004cf3ac481 100644
--- a/drivers/infiniband/hw/erdma/erdma_hw.h
+++ b/drivers/infiniband/hw/erdma/erdma_hw.h
@@ -450,13 +450,13 @@ enum erdma_opcode {
 	ERDMA_OP_RECV_IMM = 5,
 	ERDMA_OP_RECV_INV = 6,
 
-	ERDMA_OP_REQ_ERR = 7,
-	ERDMA_OP_READ_RESPONSE = 8,
+	ERDMA_OP_RSVD0 = 7,
+	ERDMA_OP_RSVD1 = 8,
 	ERDMA_OP_WRITE_WITH_IMM = 9,
 
-	ERDMA_OP_RECV_ERR = 10,
+	ERDMA_OP_RSVD2 = 10,
+	ERDMA_OP_RSVD3 = 11,
 
-	ERDMA_OP_INVALIDATE = 11,
 	ERDMA_OP_RSP_SEND_IMM = 12,
 	ERDMA_OP_SEND_WITH_INV = 13,
 
-- 
2.27.0

