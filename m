Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0EA6C0C76
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Mar 2023 09:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjCTIrI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Mar 2023 04:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjCTIrH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Mar 2023 04:47:07 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5890C11C
        for <linux-rdma@vger.kernel.org>; Mon, 20 Mar 2023 01:47:05 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VeEvyys_1679302022;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VeEvyys_1679302022)
          by smtp.aliyun-inc.com;
          Mon, 20 Mar 2023 16:47:02 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: [PATCH for-rc 4/4] RDMA/erdma: Defer probing if netdevice can not be found
Date:   Mon, 20 Mar 2023 16:46:52 +0800
Message-Id: <20230320084652.16807-5-chengyou@linux.alibaba.com>
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

ERDMA device may be probed before its associated netdevice, returning
-EPROBE_DEFER allows OS try to probe erdma device later.

Fixes: d55e6fb4803c ("RDMA/erdma: Add the erdma module")
Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
index 5dc31e5df5cb..4a29a53a6652 100644
--- a/drivers/infiniband/hw/erdma/erdma_main.c
+++ b/drivers/infiniband/hw/erdma/erdma_main.c
@@ -56,7 +56,7 @@ static int erdma_netdev_event(struct notifier_block *nb, unsigned long event,
 static int erdma_enum_and_get_netdev(struct erdma_dev *dev)
 {
 	struct net_device *netdev;
-	int ret = -ENODEV;
+	int ret = -EPROBE_DEFER;
 
 	/* Already binded to a net_device, so we skip. */
 	if (dev->netdev)
-- 
2.31.1

