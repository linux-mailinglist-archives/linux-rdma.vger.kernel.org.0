Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5747EA685
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Nov 2023 00:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjKMXBY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Nov 2023 18:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKMXBX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Nov 2023 18:01:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9BC1B5
        for <linux-rdma@vger.kernel.org>; Mon, 13 Nov 2023 15:01:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5398BC433C7;
        Mon, 13 Nov 2023 23:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699916480;
        bh=zvXd7pFUQNTRC+R6e2nxdu7t0YyF3Z07Sc/sSGBOShU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kKxfCmre5BnuVHNIFxfAQH4lJMWeI/3HU9+1YE2t5WZdAyyjGyGJqys6a9CE2GhNs
         NIuxqzGQRUhHm2biHXUngFZ3mlY81S2Qv4vELAHsWoy2jJI5+UXC1mBOm1dfSQjNKQ
         PEnb/tKUcl2Q+MKusS7YHps6+TVaAhrw/P7UNFsUbDchFrHqA1DG2V6oosRn8oZOs5
         RYn7KX1zljcvoXivNLIEjcmlkeKE5x5r4ovs8LnY/OgQL5E0OYt4770J18Y1nbXvNy
         SFu0p/1N0XAmg/ec1T2x9kQS0qTKlBjAZHy7s2dzZ7zYS0+oBfnqUe1VZmirQXJcRR
         recB1SM7lkwbQ==
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
Subject: [net-next 05/14] net/mlx5: Annotate struct mlx5_flow_handle with __counted_by
Date:   Mon, 13 Nov 2023 15:00:42 -0800
Message-ID: <20231113230051.58229-6-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113230051.58229-1-saeed@kernel.org>
References: <20231113230051.58229-1-saeed@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

As found with Coccinelle[1], add __counted_by for struct mlx5_flow_handle.

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
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
index 4aed1768b85f..78eb6b7097e1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
@@ -181,7 +181,7 @@ struct mlx5_flow_rule {
 
 struct mlx5_flow_handle {
 	int num_rules;
-	struct mlx5_flow_rule *rule[];
+	struct mlx5_flow_rule *rule[] __counted_by(num_rules);
 };
 
 /* Type of children is mlx5_flow_group */
-- 
2.41.0

