Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A0C61642E
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Nov 2022 15:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiKBOAZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Nov 2022 10:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiKBOAY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Nov 2022 10:00:24 -0400
X-Greylist: delayed 569 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Nov 2022 07:00:21 PDT
Received: from mxus.zte.com.cn (mxus.zte.com.cn [20.112.44.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED0C63AE
        for <linux-rdma@vger.kernel.org>; Wed,  2 Nov 2022 07:00:20 -0700 (PDT)
Received: from mxhk.zte.com.cn (unknown [192.168.250.138])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxus.zte.com.cn (FangMail) with ESMTPS id 4N2Svt3LQgz9tyVb
        for <linux-rdma@vger.kernel.org>; Wed,  2 Nov 2022 21:50:50 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4N2Svp52fSz5PkGn;
        Wed,  2 Nov 2022 21:50:46 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2A2DobUS088110;
        Wed, 2 Nov 2022 21:50:37 +0800 (+08)
        (envelope-from zhang.songyi@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 2 Nov 2022 21:50:40 +0800 (CST)
Date:   Wed, 2 Nov 2022 21:50:40 +0800 (CST)
X-Zmail-TransId: 2af9636275b06d0fc8ef
X-Mailer: Zmail v1.0
Message-ID: <202211022150403300510@zte.com.cn>
Mime-Version: 1.0
From:   <zhang.songyi@zte.com.cn>
To:     <saeedm@nvidia.com>
Cc:     <leon@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <kliteyn@nvidia.com>,
        <shunh@nvidia.com>, <rongweil@nvidia.com>, <valex@nvidia.com>,
        <zhang.songyi@zte.com.cn>, <netdev@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jiang.xuexin@zte.com.cn>, <xue.zhihong@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIG5ldC9tbHg1OiByZW1vdmUgcmVkdW5kYW50IHJldCB2YXJpYWJsZQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2A2DobUS088110
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at 10-207-168-7 with ID 636275B9.001 by FangMail milter!
X-FangMail-Envelope: 1667397050/4N2Svt3LQgz9tyVb/636275B9.001/192.168.250.138/[192.168.250.138]/mxhk.zte.com.cn/<zhang.songyi@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 636275B9.001/4N2Svt3LQgz9tyVb
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From 74562e313cf9a1b96c7030f27964f826a0c2572d Mon Sep 17 00:00:00 2001
From: zhang songyi <zhang.songyi@zte.com.cn>
Date: Wed, 2 Nov 2022 20:48:08 +0800
Subject: [PATCH linux-next] net/mlx5: remove redundant ret variable

Return value from mlx5dr_send_postsend_action() directly instead of taking
this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_send.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_send.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_send.c
index a4476cb4c3b3..fd2d31cdbcf9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_send.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_send.c
@@ -724,7 +724,6 @@ int mlx5dr_send_postsend_action(struct mlx5dr_domain *dmn,
                struct mlx5dr_action *action)
 {
    struct postsend_info send_info = {};
-   int ret;

    send_info.write.addr = (uintptr_t)action->rewrite->data;
    send_info.write.length = action->rewrite->num_of_actions *
@@ -734,9 +733,7 @@ int mlx5dr_send_postsend_action(struct mlx5dr_domain *dmn,
        mlx5dr_icm_pool_get_chunk_mr_addr(action->rewrite->chunk);
    send_info.rkey = mlx5dr_icm_pool_get_chunk_rkey(action->rewrite->chunk);

-   ret = dr_postsend_icm_data(dmn, &send_info);
-
-   return ret;
+   return dr_postsend_icm_data(dmn, &send_info);
 }

 static int dr_modify_qp_rst2init(struct mlx5_core_dev *mdev,
--
2.15.2
