Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D27F53EBDB
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jun 2022 19:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237140AbiFFMdx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jun 2022 08:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237141AbiFFMdv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jun 2022 08:33:51 -0400
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3F362D4;
        Mon,  6 Jun 2022 05:33:45 -0700 (PDT)
X-QQ-mid: bizesmtp82t1654518803tsg12c24
Received: from localhost.localdomain ( [111.9.5.115])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 06 Jun 2022 20:33:14 +0800 (CST)
X-QQ-SSF: 01000000002000C0H000B00A0000000
X-QQ-FEAT: oL/cO9MxQnNSoE5dwibh5Q8a7uGey0p7VEuvzpAgvjo/nRrUZ3kB5FmtGlIYv
        GVIb9DehZKx5wbML+DUWwIGkuhLLvYfWBJZVZbhDJZYptx1oKoVb2kwbZlfIBGxPOzlxHtR
        qOOWIenu5KaN67z6NIbtwzhzpL23pXtW2D77rD6SfXuKBzONbZRTreK9IeOV+Ob+NbPsTxy
        2TrIgTu3FCYKutDKK4jlz2Y36KUweUS5eprctygPXXYb/SQCAO313vFQ40lZwEFgRIX93FF
        6xXJ6gZVwuVMd27Fy19tSu/mDoddeOCnGbGiIWV//jnznD1Qafv1f6T2HwsXk8kGV3snrIU
        0WDzM2rubahaKJChw6yaXmGEXfnrawIPhounmjq
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        leon@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH v2] RDMA/hw/hfi1/pio_copy: Fix syntax errors in comments
Date:   Mon,  6 Jun 2022 20:33:12 +0800
Message-Id: <20220606123312.29053-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Delete the redundant word 'and'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---

Changes since v1
*Change commit log

 drivers/infiniband/hw/hfi1/pio_copy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/pio_copy.c b/drivers/infiniband/hw/hfi1/pio_copy.c
index 136f9a99e1e0..7690f996d5e3 100644
--- a/drivers/infiniband/hw/hfi1/pio_copy.c
+++ b/drivers/infiniband/hw/hfi1/pio_copy.c
@@ -172,7 +172,7 @@ static inline void jcopy(u8 *dest, const u8 *src, u32 n)
 }
 
 /*
- * Read nbytes from "from" and and place them in the low bytes
+ * Read nbytes from "from" and place them in the low bytes
  * of pbuf->carry.  Other bytes are left as-is.  Any previous
  * value in pbuf->carry is lost.
  *
-- 
2.36.1

