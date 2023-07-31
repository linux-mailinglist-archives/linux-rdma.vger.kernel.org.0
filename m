Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA2A7689BA
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 03:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjGaB7W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 30 Jul 2023 21:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGaB7W (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 30 Jul 2023 21:59:22 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD77D7;
        Sun, 30 Jul 2023 18:59:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VoX5LFV_1690768756;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VoX5LFV_1690768756)
          by smtp.aliyun-inc.com;
          Mon, 31 Jul 2023 09:59:17 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        leon@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] RDMA/irdma: Fix one kernel-doc comment
Date:   Mon, 31 Jul 2023 09:59:15 +0800
Message-Id: <20230731015915.34867-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove description of @free_hwcqp in irdma_destroy_cqp().
to silence the warning:

drivers/infiniband/hw/irdma/hw.c:580: warning: Excess function parameter 'free_hwcqp' description in 'irdma_destroy_cqp'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6028
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/infiniband/hw/irdma/hw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index eaf196985f49..7cbdd5433dba 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -571,7 +571,6 @@ static void irdma_destroy_irq(struct irdma_pci_f *rf,
 /**
  * irdma_destroy_cqp  - destroy control qp
  * @rf: RDMA PCI function
- * @free_hwcqp: 1 if hw cqp should be freed
  *
  * Issue destroy cqp request and
  * free the resources associated with the cqp
-- 
2.20.1.7.g153144c

