Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D17555138
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jun 2022 18:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359098AbiFVQWo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jun 2022 12:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiFVQWn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Jun 2022 12:22:43 -0400
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEF53F32F;
        Wed, 22 Jun 2022 09:22:38 -0700 (PDT)
X-QQ-mid: bizesmtp64t1655914938t9kqy4jl
Received: from ubuntu.localdomain ( [106.117.78.84])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 23 Jun 2022 00:22:14 +0800 (CST)
X-QQ-SSF: 01000000008000B0C000B00A0000000
X-QQ-FEAT: HDjpALELSmETtlnwlmCv20mwYqf3PQC+7nPRVP9xCe+MRa0YT0sCgssZkWuy3
        r8Mz0u7A351cqayt+y3nSnY5o0TWNyKpeHZtnEHMz5DSu4Qp0oD/4HOldrOdv0L+zaPBTFX
        gcbMLkB2QeH/mvUpX+UNFHRORFgnEg101u11D5e75UwhDwWhVhXKtHLUFohNJGIat8QDeMm
        r/qd4Ponc86QIS+T8mjowlP0IZxH4FC5qgCq3PcWnrucheSseoUIbl9Ih2DNsZDn6siR0UT
        iZAczSJWnYAeizbMEew6fZHUeEqKzEu9PP7gum2+CpHPCnXJ87sz2zG6/nXdi/OisnUrtLK
        W205B2j
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     jiangjian@cdjrlc.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/core: drop unexpected word 'is' in the comments
Date:   Thu, 23 Jun 2022 00:22:13 +0800
Message-Id: <20220622162213.13959-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

there is an unexpected word 'is' in the comments that need to be dropped

file: drivers/infiniband/core/rdma_core.c
line: 71

* access locks, since only a single one of them is is allowed

changed to:

* access locks, since only a single one of them is allowed

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/infiniband/core/rdma_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index 94d83b665a2f..29b1ab1d5f93 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -68,7 +68,7 @@ static int uverbs_try_lock_object(struct ib_uobject *uobj,
 	 * In exclusive access mode, we check that the counter is zero (nobody
 	 * claimed this object) and we set it to -1. Releasing a shared access
 	 * lock is done simply by decreasing the counter. As for exclusive
-	 * access locks, since only a single one of them is is allowed
+	 * access locks, since only a single one of them is allowed
 	 * concurrently, setting the counter to zero is enough for releasing
 	 * this lock.
 	 */
-- 
2.17.1

