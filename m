Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4CC57D86D
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Jul 2022 04:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbiGVCTJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jul 2022 22:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGVCTH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jul 2022 22:19:07 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D9DE0D;
        Thu, 21 Jul 2022 19:19:02 -0700 (PDT)
X-QQ-mid: bizesmtp74t1658456323t263i4pq
Received: from harry-jrlc.. ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 22 Jul 2022 10:18:34 +0800 (CST)
X-QQ-SSF: 0100000000000030C000000A0000020
X-QQ-FEAT: hoArX50alxFrHxhGqacyHs8iJf7DmSpXceBzrUtMZ4UOpex/yR9Rg777FXWxY
        NIwMsZPvPUAXYB2iFT1GEI96vm9DmqznW+qGSx1mJijFXzN5vXDZgx/3whZ9UU/m/+0VLzr
        mOtsty8ZzxWZkBpXoDsf3I6XWmSwpX9DsR6GS/qinX9DxaNpaHsSJQhAi5PzPncQMVzM5eS
        rO/RWq4L2YSpKGNxDDFuXCUAkOWcKjAVyZ/eO+Pg9FNWz7lYhQV1zSg5tVT4zfqEbCpF9nd
        256DDgjHjCuWPgUWICe4cH8K6HTrsjv8SADfzBbQuNxo05vjsoLeRbuEXvInpecl41xL8Bu
        66UFWFc4fo1laTjhA4t2uwqciCevxurSIEKcFLb/tO9IRKpkos=
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] RDMA: Fix comment typo
Date:   Fri, 22 Jul 2022 10:18:33 +0800
Message-Id: <20220722021833.15669-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The double `get' is duplicated in line 4607, remove one.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 include/rdma/ib_verbs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index b0bc9de5e9a8..c2966792b2fe 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4603,7 +4603,7 @@ static inline enum rdma_ah_attr_type rdma_ah_find_type(struct ib_device *dev,
 
 /**
  * ib_lid_cpu16 - Return lid in 16bit CPU encoding.
- *     In the current implementation the only way to get
+ *     In the current implementation the only way to
  *     get the 32bit lid is from other sources for OPA.
  *     For IB, lids will always be 16bits so cast the
  *     value accordingly.
-- 
2.30.2

