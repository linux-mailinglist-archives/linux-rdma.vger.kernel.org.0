Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7F56D14A7
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Mar 2023 03:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjCaBGj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Mar 2023 21:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjCaBGj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Mar 2023 21:06:39 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97C7CA19;
        Thu, 30 Mar 2023 18:06:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vf09vE6_1680224794;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Vf09vE6_1680224794)
          by smtp.aliyun-inc.com;
          Fri, 31 Mar 2023 09:06:35 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     jgg@ziepe.ca
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] RDMA/cma: Remove NULL check before dev_{put, hold}
Date:   Fri, 31 Mar 2023 09:06:33 +0800
Message-Id: <20230331010633.63261-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The call netdev_{put, hold} of dev_{put, hold} will check NULL,
so there is no need to check before using dev_{put, hold},
remove it to silence the warnings:

./drivers/infiniband/core/cma.c:713:2-9: WARNING: NULL check before dev_{put, hold} functions is not needed.
./drivers/infiniband/core/cma.c:2433:2-9: WARNING: NULL check before dev_{put, hold} functions is not needed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4668
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/infiniband/core/cma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 6b9563d4f23c..93a1c48d0c32 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -709,8 +709,7 @@ cma_validate_port(struct ib_device *device, u32 port,
 	}
 
 	sgid_attr = rdma_find_gid_by_port(device, gid, gid_type, port, ndev);
-	if (ndev)
-		dev_put(ndev);
+	dev_put(ndev);
 	return sgid_attr;
 }
 
@@ -2429,8 +2428,7 @@ static int cma_ib_req_handler(struct ib_cm_id *cm_id,
 	mutex_unlock(&listen_id->handler_mutex);
 
 net_dev_put:
-	if (net_dev)
-		dev_put(net_dev);
+	dev_put(net_dev);
 
 	return ret;
 }
-- 
2.20.1.7.g153144c

