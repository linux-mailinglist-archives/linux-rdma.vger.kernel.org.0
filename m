Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7FD544473
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jun 2022 09:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbiFIHIX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Jun 2022 03:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239635AbiFIHIU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Jun 2022 03:08:20 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793C3211AA0;
        Thu,  9 Jun 2022 00:08:17 -0700 (PDT)
Received: from localhost.localdomain ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 25976wDx024268-25976wE2024268
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 9 Jun 2022 15:07:05 +0800
From:   Dongliang Mu <dzm91@hust.edu.cn>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rxe: fix xa_alloc_cycle() error return value check again
Date:   Thu,  9 Jun 2022 15:06:56 +0800
Message-Id: <20220609070656.1446121-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Dongliang Mu <mudongliangabcd@gmail.com>

Currently rxe_alloc checks ret to indicate error, but 1 is also a valid
return and just indicates that the allocation succeeded with a wrap.

Fix this by modifying the check to be < 0.

Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 1cc8e847ccff..e9f3bbd8d605 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -167,7 +167,7 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 
 	err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
 			      &pool->next, GFP_KERNEL);
-	if (err)
+	if (err < 0)
 		goto err_cnt;
 
 	return 0;
-- 
2.25.1

