Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B48557804
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jun 2022 12:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiFWKii (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Jun 2022 06:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiFWKii (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Jun 2022 06:38:38 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA60473A8;
        Thu, 23 Jun 2022 03:38:34 -0700 (PDT)
X-QQ-mid: bizesmtp83t1655980634t4p80waa
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 23 Jun 2022 18:37:10 +0800 (CST)
X-QQ-SSF: 01000000008000B0C000D00A0000000
X-QQ-FEAT: z8a0vINfhrv78jzEWZpM5dp3suNsGFUiFRS9/zONYZ+w5+MHtQsNJP2MG3OZC
        T+UIg2yQHa9bMWuv3i0IbcBiIArss/C4uQvQsTczHq5lCyvgwDKIZveAU+dq5JJ7v962YG2
        QbwOojUCPMEjN6c5t26cKbSBHw64+mPD6BsOYuGOTVz0GjgLjZrv5OXPMi0dQyiapp5BH09
        QFrDCXvvB4RZqAgr4FVadKE9QastHkr4x2cwzthX/DMOTkbYH4aOpbv/ZdcsBy64sqMMzRR
        9m3GZtKdFoprDf1L2KekuvdDIXMHAnXA7YHdezfU8p6oxpB9X5NgBickH+k/sqmXLYGDk28
        9MHtR1aXcP4MuiE1U18vpHdb0kqvEvlRvtMzxS7
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     selvin.xavier@broadcom.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] RDMA/bnxt_re: drop unexpected word 'for' in comments
Date:   Thu, 23 Jun 2022 18:37:08 +0800
Message-Id: <20220623103708.43104-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

there is an unexpected word 'for' in the comments that need to be dropped

file - drivers/infiniband/hw/bnxt_re/bnxt_re.h
line - 176

	/* QP for for handling QP1 packets */

changed to:

	/* QP for handling QP1 packets */

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 79401e6c6aa9..785c37cae3c0 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -173,7 +173,7 @@ struct bnxt_re_dev {
 	/* Max of 2 lossless traffic class supported per port */
 	u16				cosq[2];
 
-	/* QP for for handling QP1 packets */
+	/* QP for handling QP1 packets */
 	struct bnxt_re_gsi_context	gsi_ctx;
 	struct bnxt_re_stats		stats;
 	atomic_t nq_alloc_cnt;
-- 
2.17.1

