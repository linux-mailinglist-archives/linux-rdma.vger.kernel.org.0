Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7ED673D563
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jun 2023 02:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjFZAgj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 25 Jun 2023 20:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjFZAgi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 25 Jun 2023 20:36:38 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A744AE43;
        Sun, 25 Jun 2023 17:36:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VltjHIZ_1687739793;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VltjHIZ_1687739793)
          by smtp.aliyun-inc.com;
          Mon, 26 Jun 2023 08:36:33 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     leon@kernel.org, Markus.Elfring@web.de
Cc:     selvin.xavier@broadcom.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next v2] RDMA/bnxt_re: Remove duplicated include in bnxt_re/main.c
Date:   Mon, 26 Jun 2023 08:36:32 +0800
Message-Id: <20230626003632.60435-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

./drivers/infiniband/hw/bnxt_re/main.c: ib_verbs.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5588
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---

--change in v2:
add a more appropriate subject.

 drivers/infiniband/hw/bnxt_re/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 1e5b60f9269e..b42166fe7454 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -66,7 +66,6 @@
 #include <rdma/bnxt_re-abi.h>
 #include "bnxt.h"
 #include "hw_counters.h"
-#include "ib_verbs.h"
 
 static char version[] =
 		BNXT_RE_DESC "\n";
-- 
2.20.1.7.g153144c

