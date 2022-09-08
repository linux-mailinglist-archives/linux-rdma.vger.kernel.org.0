Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378BC5B1E82
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Sep 2022 15:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbiIHNS7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Sep 2022 09:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbiIHNSu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Sep 2022 09:18:50 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6A9AFAE2;
        Thu,  8 Sep 2022 06:18:49 -0700 (PDT)
X-QQ-mid: bizesmtp78t1662643112teydyx0p
Received: from localhost.localdomain ( [182.148.14.0])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 08 Sep 2022 21:18:31 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: 6PjtIMncaiyXNGc4fwYlHrnnhUznxL4+eXyDLVZhKkuikOs6HmA9CMLNXPN9R
        nSr1+QKwJkj00w559/Ss/A3Ix7sX8dVGB1t/F7WbSHZ+WnGolYYRRFa7kzkeh0MZZY+Syr2
        admvzBdwnrESF3g3/XSF1EOzTpOzo19LcotZbI4HwNZtjgi0XahaF9+aU1nhTfoNJj48d7k
        iG26p2DNkG/mtMw529lwyugsFDClrv6oteAIlI7kY8b70nBPcszpGyg8zXJ28J/uZVoWWMe
        NWAAV2A217c+hs/ejKWWx5rBZ4FinsRRQHIgdKkouQAner671D1oBAU72YlIxY1uGZpURLK
        oTd8a8FGGibVUAmdPe5rKGtRduo9S8PrOC/UOSEC/GYf6DMaBisRRFkQ2Wiyg==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] hw/hfi1: fix repeated words in comments
Date:   Thu,  8 Sep 2022 21:18:24 +0800
Message-Id: <20220908131824.41106-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Delete the redundant word 'to'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/infiniband/hw/hfi1/chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index f1245c94ae26..ebe970f76232 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -8753,7 +8753,7 @@ static int do_8051_command(struct hfi1_devdata *dd, u32 type, u64 in_data,
 
 	/*
 	 * When writing a LCB CSR, out_data contains the full value to
-	 * to be written, while in_data contains the relative LCB
+	 * be written, while in_data contains the relative LCB
 	 * address in 7:0.  Do the work here, rather than the caller,
 	 * of distrubting the write data to where it needs to go:
 	 *
-- 
2.36.1

