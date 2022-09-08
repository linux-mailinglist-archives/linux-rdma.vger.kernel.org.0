Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11005B1E8F
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Sep 2022 15:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbiIHNUC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Sep 2022 09:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbiIHNT7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Sep 2022 09:19:59 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A337624085;
        Thu,  8 Sep 2022 06:19:50 -0700 (PDT)
X-QQ-mid: bizesmtp82t1662643175tf9njnvv
Received: from localhost.localdomain ( [182.148.14.0])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 08 Sep 2022 21:19:34 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: 6PjtIMncaizfeBGDbZmTEOU8q7l/5JkBgj5VGJYSj+9yKDvfN/U1cB5zcGdC6
        87RTWIOFDPcuieuyDSLLzHhyKS7B8wYL2F4kBszZREO1RWhzESTFi0BfQQfiXskBD7JyjB0
        R61EICAImRp8YzyHoiYik44QvxTMLxL78mkRT09YSD2eTzC6kIRN/w48TyMt7+e/JNXzY0h
        0xlOqWD/2Pc2Qnl+p17Iu8FqhHGQ4+v0VIuWgtK1rHu/+ddL+NM53VZ8AUpjmZ1fmAahcIy
        RGEAmcK3phniowOLVbds/PaPl3n4QrnOnvWa2kI5WU4J8pUJ4NXgo3DXnhoTTiU5MXnPeii
        ir74uNQJb5HeukFm0vIZQco0dIRBw8b1d2axYrPwbNLENZp7oM=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] hw/hfi1: fix repeated words in comments
Date:   Thu,  8 Sep 2022 21:19:27 +0800
Message-Id: <20220908131927.41729-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_PBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Delete the redundant word 'to'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/infiniband/hw/hfi1/firmware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/firmware.c b/drivers/infiniband/hw/hfi1/firmware.c
index aa15a5cc7cf3..1d77514ebbee 100644
--- a/drivers/infiniband/hw/hfi1/firmware.c
+++ b/drivers/infiniband/hw/hfi1/firmware.c
@@ -1114,7 +1114,7 @@ static void turn_off_spicos(struct hfi1_devdata *dd, int flags)
  * Reset all of the fabric serdes for this HFI in preparation to take the
  * link to Polling.
  *
- * To do a reset, we need to write to to the serdes registers.  Unfortunately,
+ * To do a reset, we need to write to the serdes registers.  Unfortunately,
  * the fabric serdes download to the other HFI on the ASIC will have turned
  * off the firmware validation on this HFI.  This means we can't write to the
  * registers to reset the serdes.  Work around this by performing a complete
-- 
2.36.1

