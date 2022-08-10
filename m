Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9CD58E4A1
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Aug 2022 03:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiHJBno (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Aug 2022 21:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiHJBn0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Aug 2022 21:43:26 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754FB6FA2A
        for <linux-rdma@vger.kernel.org>; Tue,  9 Aug 2022 18:43:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VLss2AB_1660095801;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VLss2AB_1660095801)
          by smtp.aliyun-inc.com;
          Wed, 10 Aug 2022 09:43:22 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: [PATCH for-rc] RDMA/erdma: Using the key in FMR WR instead of MR structure
Date:   Wed, 10 Aug 2022 09:43:20 +0800
Message-Id: <20220810014320.88026-2-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220810014320.88026-1-chengyou@linux.alibaba.com>
References: <20220810014320.88026-1-chengyou@linux.alibaba.com>
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

RDMA driver should get the MR key from FMR WR, not the MR structure passed
in.

Fixes: 155055771704 ("RDMA/erdma: Add verbs implementation")
Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_qp.c b/drivers/infiniband/hw/erdma/erdma_qp.c
index 72f08171a28a..bc3ec22a62c5 100644
--- a/drivers/infiniband/hw/erdma/erdma_qp.c
+++ b/drivers/infiniband/hw/erdma/erdma_qp.c
@@ -407,7 +407,7 @@ static int erdma_push_one_sqe(struct erdma_qp *qp, u16 *pi,
 			     to_erdma_access_flags(reg_wr(send_wr)->access);
 		regmr_sge->addr = cpu_to_le64(mr->ibmr.iova);
 		regmr_sge->length = cpu_to_le32(mr->ibmr.length);
-		regmr_sge->stag = cpu_to_le32(mr->ibmr.lkey);
+		regmr_sge->stag = cpu_to_le32(reg_wr(send_wr)->key);
 		attrs = FIELD_PREP(ERDMA_SQE_MR_MODE_MASK, 0) |
 			FIELD_PREP(ERDMA_SQE_MR_ACCESS_MASK, mr->access) |
 			FIELD_PREP(ERDMA_SQE_MR_MTT_CNT_MASK,
-- 
2.27.0

