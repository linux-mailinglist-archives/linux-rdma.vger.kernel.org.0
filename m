Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560877ECD84
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Nov 2023 20:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbjKOThA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Nov 2023 14:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234564AbjKOTg6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Nov 2023 14:36:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D820019F
        for <linux-rdma@vger.kernel.org>; Wed, 15 Nov 2023 11:36:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741F6C433C9;
        Wed, 15 Nov 2023 19:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700077015;
        bh=etudxdGtBrISOhVFfZeRsNdQQI6GSAO3tH9FQxYSOVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c5HI3W3HdXbedmLCntujT1NdzxmTAC5K2A9OCDY+T1qT1JF3uKOd9UD4kmllfZbNh
         LYpUXJgLESPLcFG/D+J3HLtYweokLPsgoHbTL28yhldLXG3jTRtTH8DFHGeDT5XWtO
         CeqSBEl1UiU9QLmnD8cUTwSOvJ6UW28UQW7BykvIi1n3W6UMwm+ht4ZYrzh+Id2VIS
         ONrJaB5n5YlE/lcDd2IrSLl29lyhphPGka2JawLOSJvRc6yH5vfS9LUQwfnRY5xq08
         CvYXT9LgpZQ5/eq/ArG0vbBR/tAFjCyu5e3V2/0QMhfeqkLaYddIOptvHXuw6Cx8Ws
         72IUdpeMZ5tHg==
From:   Saeed Mahameed <saeed@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
        Tariq Toukan <tariqt@nvidia.com>,
        Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [net-next V2 04/13] net/mlx5: Annotate struct mlx5_fc_bulk with __counted_by
Date:   Wed, 15 Nov 2023 11:36:40 -0800
Message-ID: <20231115193649.8756-5-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115193649.8756-1-saeed@kernel.org>
References: <20231115193649.8756-1-saeed@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct mlx5_fc_bulk.

Cc: Saeed Mahameed <saeedm@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Cc: linux-rdma@vger.kernel.org
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Justin Stitt <justinstitt@google.com>
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
index 17fe30a4c06c..0c26d707eed2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
@@ -539,7 +539,7 @@ struct mlx5_fc_bulk {
 	u32 base_id;
 	int bulk_len;
 	unsigned long *bitmask;
-	struct mlx5_fc fcs[];
+	struct mlx5_fc fcs[] __counted_by(bulk_len);
 };
 
 static void mlx5_fc_init(struct mlx5_fc *counter, struct mlx5_fc_bulk *bulk,
-- 
2.41.0

