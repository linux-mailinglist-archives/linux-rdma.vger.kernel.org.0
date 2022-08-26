Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39215A29A1
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Aug 2022 16:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344490AbiHZOep (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Aug 2022 10:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344439AbiHZOen (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Aug 2022 10:34:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7901181B2E;
        Fri, 26 Aug 2022 07:34:41 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MDj22065BzlVxb;
        Fri, 26 Aug 2022 22:31:22 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (7.185.36.74) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 22:34:39 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 22:34:39 +0800
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] RDMA/core: remove 'device' argument from rdma_build_skb()
Date:   Fri, 26 Aug 2022 22:32:15 +0800
Message-ID: <20220826143215.18111-1-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

'device' argument is never used since rdma_build_skb()
is introduced, so remove it.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 drivers/infiniband/core/lag.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/lag.c b/drivers/infiniband/core/lag.c
index 7063e41eaf26..c77d7d2559a1 100644
--- a/drivers/infiniband/core/lag.c
+++ b/drivers/infiniband/core/lag.c
@@ -7,8 +7,7 @@
 #include <rdma/ib_cache.h>
 #include <rdma/lag.h>
 
-static struct sk_buff *rdma_build_skb(struct ib_device *device,
-				      struct net_device *netdev,
+static struct sk_buff *rdma_build_skb(struct net_device *netdev,
 				      struct rdma_ah_attr *ah_attr,
 				      gfp_t flags)
 {
@@ -86,7 +85,7 @@ static struct net_device *rdma_get_xmit_slave_udp(struct ib_device *device,
 	struct net_device *slave;
 	struct sk_buff *skb;
 
-	skb = rdma_build_skb(device, master, ah_attr, flags);
+	skb = rdma_build_skb(master, ah_attr, flags);
 	if (!skb)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.33.0

