Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB5057330D
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Jul 2022 11:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiGMJmT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Jul 2022 05:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236169AbiGMJmS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Jul 2022 05:42:18 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCB1F5D76
        for <linux-rdma@vger.kernel.org>; Wed, 13 Jul 2022 02:42:17 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VJDAXU._1657705334;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VJDAXU._1657705334)
          by smtp.aliyun-inc.com;
          Wed, 13 Jul 2022 17:42:15 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com,
        chengyou@linux.alibaba.com, tonylu@linux.alibaba.com
Subject: [PATCH for-next v13 01/11] RDMA: Add ERDMA to rdma_driver_id definition
Date:   Wed, 13 Jul 2022 17:42:02 +0800
Message-Id: <20220713094212.30943-2-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220713094212.30943-1-chengyou@linux.alibaba.com>
References: <20220713094212.30943-1-chengyou@linux.alibaba.com>
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

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 include/uapi/rdma/ib_user_ioctl_verbs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdma/ib_user_ioctl_verbs.h
index 3072e5d6b692..7dd56210226f 100644
--- a/include/uapi/rdma/ib_user_ioctl_verbs.h
+++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
@@ -250,6 +250,7 @@ enum rdma_driver_id {
 	RDMA_DRIVER_QIB,
 	RDMA_DRIVER_EFA,
 	RDMA_DRIVER_SIW,
+	RDMA_DRIVER_ERDMA,
 };
 
 enum ib_uverbs_gid_type {
-- 
2.27.0

