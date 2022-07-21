Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FFE57C70D
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jul 2022 11:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbiGUJDj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jul 2022 05:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiGUJDj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jul 2022 05:03:39 -0400
Received: from m12-14.163.com (m12-14.163.com [220.181.12.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 827B042AC8;
        Thu, 21 Jul 2022 02:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=yPFnU
        jkTMZqkKR12zaen98dH3MRV2XVo5tCZdpubB3Y=; b=pHk0xPjBGclNhTKknCG+H
        0zm48SsZtf5iiWTwxfzK8UhlcBjqOHlQF675dHUvE9Vb5xPJGvwFsWUSDlaQvhDy
        lYsioYu1FN6sMOjcfb6jyhWdeV2aaJbSlr6jA0S6s7KOR2uEEjpnzaq8qfU9eosW
        9vloYW3qdoovnZS6qc8hLg=
Received: from localhost.localdomain (unknown [223.104.68.234])
        by smtp10 (Coremail) with SMTP id DsCowAA3HcZdFtlibOrcOQ--.128S2;
        Thu, 21 Jul 2022 17:03:28 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] IB/ipoib: Fix typo 'the the' in comment
Date:   Thu, 21 Jul 2022 17:03:23 +0800
Message-Id: <20220721090323.50751-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowAA3HcZdFtlibOrcOQ--.128S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWUWr1kGw43Wry5KrW3Wrg_yoWfKFb_Wa
        1UJFZ7uw1qkryqkwn0qFs3XF9ayw4jgw1UZa4qgr95Aa4UWF13Wrn2vF4Fqr1UCanrKa47
        ZFyfCwn5ur4xWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRiGQ67UUUUU==
X-Originating-IP: [223.104.68.234]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiRwBFZFc7YwQGZgAAsN
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_ib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ib.c b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
index f7995519bbc8..ed25061fac62 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_ib.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
@@ -1109,7 +1109,7 @@ static bool ipoib_dev_addr_changed_valid(struct ipoib_dev_priv *priv)
 	 * if he sets the device address back to be based on GID index 0,
 	 * he no longer wishs to control it.
 	 *
-	 * If the user doesn't control the the device address,
+	 * If the user doesn't control the device address,
 	 * IPOIB_FLAG_DEV_ADDR_SET is set and ib_find_gid failed it means
 	 * the port GUID has changed and GID at index 0 has changed
 	 * so we need to change priv->local_gid and priv->dev->dev_addr
-- 
2.25.1

