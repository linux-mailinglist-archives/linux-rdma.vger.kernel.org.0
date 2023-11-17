Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CC67EEC8F
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Nov 2023 08:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjKQHUF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Nov 2023 02:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQHUE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 17 Nov 2023 02:20:04 -0500
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE388194;
        Thu, 16 Nov 2023 23:20:00 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VwYll-M_1700205588;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VwYll-M_1700205588)
          by smtp.aliyun-inc.com;
          Fri, 17 Nov 2023 15:19:58 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     saeedm@nvidia.com
Cc:     leon@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] net/mlx5: DR, Use swap() instead of open coding it
Date:   Fri, 17 Nov 2023 15:19:47 +0800
Message-Id: <20231117071947.112856-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Swap is a function interface that provides exchange function. To avoid
code duplication, we can use swap function.

./drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c:1254:50-51: WARNING opportunity for swap().

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7580
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 .../net/ethernet/mellanox/mlx5/core/steering/dr_action.c  | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
index e3ec559369fa..6f9790e97fed 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
@@ -1170,7 +1170,6 @@ mlx5dr_action_create_mult_dest_tbl(struct mlx5dr_domain *dmn,
 				   bool ignore_flow_level,
 				   u32 flow_source)
 {
-	struct mlx5dr_cmd_flow_destination_hw_info tmp_hw_dest;
 	struct mlx5dr_cmd_flow_destination_hw_info *hw_dests;
 	struct mlx5dr_action **ref_actions;
 	struct mlx5dr_action *action;
@@ -1249,11 +1248,8 @@ mlx5dr_action_create_mult_dest_tbl(struct mlx5dr_domain *dmn,
 	 * one that done in the TX.
 	 * So, if one of the ft target is wire, put it at the end of the dest list.
 	 */
-	if (is_ft_wire && num_dst_ft > 1) {
-		tmp_hw_dest = hw_dests[last_dest];
-		hw_dests[last_dest] = hw_dests[num_of_dests - 1];
-		hw_dests[num_of_dests - 1] = tmp_hw_dest;
-	}
+	if (is_ft_wire && num_dst_ft > 1)
+		swap(hw_dests[last_dest], hw_dests[num_of_dests - 1]);
 
 	action = dr_action_create_generic(DR_ACTION_TYP_FT);
 	if (!action)
-- 
2.20.1.7.g153144c

