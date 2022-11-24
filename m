Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCE9637109
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Nov 2022 04:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiKXDaZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Nov 2022 22:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKXDaV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Nov 2022 22:30:21 -0500
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EC0D06D5
        for <linux-rdma@vger.kernel.org>; Wed, 23 Nov 2022 19:30:20 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VVZ939h_1669260617;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VVZ939h_1669260617)
          by smtp.aliyun-inc.com;
          Thu, 24 Nov 2022 11:30:18 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: [PATCH for-rc] RDMA/erdma: Fix a typo in annotation
Date:   Thu, 24 Nov 2022 11:30:16 +0800
Message-Id: <20221124033016.64181-1-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

A non-UTF-8 character was wrongly put in annotation, which should be
removed.

Fixes: bee85e0e31ec ("RDMA/erdma: Add main include file")
Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/erdma/erdma.h b/drivers/infiniband/hw/erdma/erdma.h
index bb23d897c710..35726f25a989 100644
--- a/drivers/infiniband/hw/erdma/erdma.h
+++ b/drivers/infiniband/hw/erdma/erdma.h
@@ -219,7 +219,7 @@ struct erdma_dev {
 	DECLARE_BITMAP(sdb_page, ERDMA_DWQE_TYPE0_CNT);
 	/*
 	 * We provide max 496 uContexts that each has one SQ normal Db,
-	 * and one directWQE db。
+	 * and one directWQE db.
 	 */
 	DECLARE_BITMAP(sdb_entry, ERDMA_DWQE_TYPE1_CNT);
 
-- 
2.27.0

