Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92A1756DC7
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jul 2023 21:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjGQT4h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jul 2023 15:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGQT4f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Jul 2023 15:56:35 -0400
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B080F1BE7
        for <linux-rdma@vger.kernel.org>; Mon, 17 Jul 2023 12:56:11 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id LUK5qOYC7Bp2FLUK5qxFRQ; Mon, 17 Jul 2023 21:55:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1689623758;
        bh=4YAwP+0IebCJzWu8q4z7IgX7pVQZaDGiqk8B5XyDXic=;
        h=From:To:Cc:Subject:Date;
        b=KTDNknVSqCSWDbhFb//j0yR90QyYkfnGzthyyuJCcN+tsB/lv676W38cwOlukZoDd
         AoWIg9nNYIsrUNZLD0rTTDay5ldWLQq1gubP0OsqXb9jP8XNLx6C8SQl6Om807RyW7
         mcNoWXMAgVfGPzsM4dZ7FNMqd4BSdnbgou1RhmS+n5DtYqaWVFxOAPO5kZ1Cz2ITNS
         NBzJZw01E5NIFRDIecCfZjCVxzIGmtihVhkO7JRwkxj5xpiBILUsartnvsH2rLFne4
         TJfYrE52V7zU/rsFNn3rKASXw2KZmACcwAw0xivwyovqM+6pBwNAI7TgqKV2TA6/R3
         gI1U+bt8JVmQA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 17 Jul 2023 21:55:58 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-rdma@vger.kernel.org
Subject: [PATCH] RDMA/rxe: Fix an error handling path in rxe_bind_mw()
Date:   Mon, 17 Jul 2023 21:55:56 +0200
Message-Id: <43698d8a3ed4e720899eadac887427f73d7ec2eb.1689623735.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

All errors go to the error handling path, except this one. Be consistent
and also branch to it.

Fixes: 02ed253770fb ("RDMA/rxe: Introduce rxe access supported flags")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
/!\ Speculative /!\

   This patch is based on analysis of the surrounding code and should be
   reviewed with care !

/!\ Speculative /!\
---
 drivers/infiniband/sw/rxe/rxe_mw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index d8a43d87de93..d9312b5c9d20 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -199,7 +199,8 @@ int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 
 	if (access & ~RXE_ACCESS_SUPPORTED_MW) {
 		rxe_err_mw(mw, "access %#x not supported", access);
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		goto err_drop_mr;
 	}
 
 	spin_lock_bh(&mw->lock);
-- 
2.34.1

