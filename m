Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD29D7981BB
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Sep 2023 08:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbjIHGGJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Sep 2023 02:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjIHGGJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Sep 2023 02:06:09 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE311BD3
        for <linux-rdma@vger.kernel.org>; Thu,  7 Sep 2023 23:06:04 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VrbMIKA_1694153161;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VrbMIKA_1694153161)
          by smtp.aliyun-inc.com;
          Fri, 08 Sep 2023 14:06:01 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: [PATCH for-rc] RDMA/erdma: Fix NULL pointer access in regmr_cmd
Date:   Fri,  8 Sep 2023 14:05:59 +0800
Message-Id: <20230908060559.80203-1-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix the crash of regmr_cmd called by erdma_ib_alloc_mr. The reason is
that mr->mem.mtt is not initialized but it is accessed in regmr_cmd.

The call trace information:

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 <...>
 RIP: 0010:regmr_cmd+0x170/0x1c0 [erdma]
 <...>
Call Trace:
 ? __die+0x20/0x70
 ? page_fault_oops+0x66/0x150
 ? do_user_addr_fault+0x61/0x660
 ? exc_page_fault+0x65/0x140
 ? asm_exc_page_fault+0x22/0x30
 ? regmr_cmd+0x170/0x1c0 [erdma]
 ? preempt_count_add+0x70/0xa0
 ? _raw_spin_lock_irqsave+0x19/0x50
 ? _raw_spin_unlock_irqrestore+0x1b/0x40
 ? erdma_alloc_idx+0x51/0x90 [erdma]
 erdma_get_dma_mr+0xa3/0x120 [erdma]
 __ib_alloc_pd+0xeb/0x1c0 [ib_core]

Fixes: 7244b4aa4221 ("RDMA/erdma: Refactor the storage structure of MTT entries")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/3d140c1d-524a-4dbe-a51c-aee4f7ecafdb@moroto.mountain/
Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_verbs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index dcccb6015232..a7c2cbbbd9b9 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -133,8 +133,8 @@ static int create_qp_cmd(struct erdma_ucontext *uctx, struct erdma_qp *qp)
 static int regmr_cmd(struct erdma_dev *dev, struct erdma_mr *mr)
 {
 	struct erdma_pd *pd = to_epd(mr->ibmr.pd);
+	u32 mtt_level = ERDMA_MR_MTT_0LEVEL;
 	struct erdma_cmdq_reg_mr_req req;
-	u32 mtt_level;
 
 	erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_RDMA, CMDQ_OPCODE_REG_MR);
 
@@ -147,10 +147,9 @@ static int regmr_cmd(struct erdma_dev *dev, struct erdma_mr *mr)
 			req.phy_addr[0] = sg_dma_address(mr->mem.mtt->sglist);
 			mtt_level = mr->mem.mtt->level;
 		}
-	} else {
+	} else if (mr->type != ERDMA_MR_TYPE_DMA) {
 		memcpy(req.phy_addr, mr->mem.mtt->buf,
 		       MTT_SIZE(mr->mem.page_cnt));
-		mtt_level = ERDMA_MR_MTT_0LEVEL;
 	}
 
 	req.cfg0 = FIELD_PREP(ERDMA_CMD_MR_VALID_MASK, mr->valid) |
-- 
2.31.1

