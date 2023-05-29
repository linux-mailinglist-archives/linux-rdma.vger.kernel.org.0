Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30FC714651
	for <lists+linux-rdma@lfdr.de>; Mon, 29 May 2023 10:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjE2IfH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 May 2023 04:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbjE2IfG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 May 2023 04:35:06 -0400
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75BBAC
        for <linux-rdma@vger.kernel.org>; Mon, 29 May 2023 01:35:04 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 3YLEqMBiidqvJ3YLEqNSes; Mon, 29 May 2023 10:35:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1685349302;
        bh=AugTDYeUrgYVPU+UhwnDyYDQ1NS0yzyFbGk6wtykwr8=;
        h=From:To:Cc:Subject:Date;
        b=Fy9a4XVTNFNs6Oz3bZxhAdqcmQ3HJaQc8jhkHb31k1p2J0kMFRF9y51tPBkti4Me/
         UwJ4GLS63q9pb/md+lydpgA/Cekhiu0HHY9lv2ig8OcsW1e9WHbpq9MrMhYRNf+5wE
         BUcE0/+6wrp3BvFsm07/p+EprzX68DAFWLw8ayglqEXTFV3gIkCewyVJqi0sw9ZFMi
         16qpwnYrtprS7MRvMYweOwi+8q6yqBLBFv/Ud0NQMGYYAJwIpTspccE2o2WHda/V4O
         krXzPyZQ6kW0cu/gSYxMzrc1lM6ndVvi9/J33kqxDbue6MJIGwBHrAr4Vf5h/VLRKt
         v7TD8aFYZABdw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 29 May 2023 10:35:02 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH net-next] net/mlx5e: Remove a useless function call
Date:   Mon, 29 May 2023 10:34:59 +0200
Message-Id: <fc535be629990acef5e2a3dfecd64a5f9661fd25.1685349266.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

'handle' is known to be NULL here. There is no need to kfree() it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc/post_act.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/post_act.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/post_act.c
index 0290e0dea539..4e923a2874ae 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/post_act.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/post_act.c
@@ -112,10 +112,8 @@ mlx5e_tc_post_act_add(struct mlx5e_post_act *post_act, struct mlx5_flow_attr *po
 	int err;
 
 	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
-	if (!handle) {
-		kfree(handle);
+	if (!handle)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	post_attr->chain = 0;
 	post_attr->prio = 0;
-- 
2.34.1

