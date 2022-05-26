Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C9B534FC2
	for <lists+linux-rdma@lfdr.de>; Thu, 26 May 2022 15:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243131AbiEZNJx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 May 2022 09:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbiEZNJw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 May 2022 09:09:52 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA43CFE23;
        Thu, 26 May 2022 06:09:50 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VESWNV3_1653570587;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VESWNV3_1653570587)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 26 May 2022 21:09:47 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     haris.iqbal@ionos.com
Cc:     jinpu.wang@ionos.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] RDMA/rtrs-clt: Fix one kernel-doc comment
Date:   Thu, 26 May 2022 21:09:45 +0800
Message-Id: <20220526130945.98601-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add the description of @pathname and remove @sessname in rtrs_clt_open()
kernel-doc comment to remove warnings found by running scripts/kernel-doc,
which is caused by using 'make W=1'.

drivers/infiniband/ulp/rtrs/rtrs-clt.c:2809: warning: Function parameter
or member 'pathname' not described in 'rtrs_clt_open'
drivers/infiniband/ulp/rtrs/rtrs-clt.c:2809: warning: Excess function
parameter 'sessname' description in 'rtrs_clt_open'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index c2c860d0c56e..9809c3883979 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2785,7 +2785,7 @@ static void free_clt(struct rtrs_clt_sess *clt)
 /**
  * rtrs_clt_open() - Open a path to an RTRS server
  * @ops: holds the link event callback and the private pointer.
- * @sessname: name of the session
+ * @pathname: name of the path to an RTRS server
  * @paths: Paths to be established defined by their src and dst addresses
  * @paths_num: Number of elements in the @paths array
  * @port: port to be used by the RTRS session
-- 
2.20.1.7.g153144c

