Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CB05551FE
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jun 2022 19:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377145AbiFVRK2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jun 2022 13:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377185AbiFVRKG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Jun 2022 13:10:06 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB7B41F92;
        Wed, 22 Jun 2022 10:09:18 -0700 (PDT)
X-QQ-mid: bizesmtp65t1655917739tqdibqz3
Received: from ubuntu.localdomain ( [106.117.78.84])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 23 Jun 2022 01:08:56 +0800 (CST)
X-QQ-SSF: 01000000008000B0C000B00A0000000
X-QQ-FEAT: CvwPx4T1dTRa7wtBmMRhUTreQ88vtJIr9GAKw8jZirbfLlewBelqrgQlH2PDo
        pBc4n3w1OnsLXEhPZiLQq9HC4/9ddMJxEDoIVIjXuoEbqe9kx+skfQQOQl/5Ua1aHiRoM4C
        gSqa98N0dr8QSQzBj0sHRo6mF2yoJCfhRURAyktllSrMavzYFVUn1YSQrdY+i2hGj903TIP
        DJsiywJeuX/1jQLjClsqpRj2c5fpBS1rqvjOHRxTFopRy+g26BN1ohA7JPQgN+xEQaAfAyg
        EdtXDtFhJJLKbcEZPLLCtf0PZFpnXD1Wq0jHKjMX2M8f5+rcHxf0fl0xmWWeFDHpIu1bD7E
        73Wb7PV
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] RDMA/core: Correct typos in comments
Date:   Thu, 23 Jun 2022 01:08:53 +0800
Message-Id: <20220622170853.3644-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

there is an unexpected word 'is' in the comments that need to be dropped

file - drivers/infiniband/core/rdma_core.c
line - 71

/* work and stuff was only created when the device is is hot-state */

changed t0:

/* work and stuff was only created when the device is hot-state */

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

