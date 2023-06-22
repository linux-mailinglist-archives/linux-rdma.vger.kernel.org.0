Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB340739E34
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jun 2023 12:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjFVKPt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Jun 2023 06:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjFVKPj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Jun 2023 06:15:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9421B4;
        Thu, 22 Jun 2023 03:15:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2BA7616CB;
        Thu, 22 Jun 2023 10:15:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4208C433C0;
        Thu, 22 Jun 2023 10:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687428932;
        bh=ddwNq7oMVHZRi+PxOrJpIvndAOCIW9Xj14GqlgpwMA0=;
        h=From:To:Cc:Subject:Date:From;
        b=AfDR9xsGjodZLtdc65RB5nqBaVJu06rRUp21I7Hw3wetmfaWPNi5vdgNf3cKJBu8H
         wMZFvpAjv3u2x+bNi7eJ8BvWZWlyz/JE98CtHOH6xXFwIKcDSHvB7mezD7Gf7nIDud
         UX3pVYcs3yx6tjdW/kJIxuu7k5MF2OPL6AKGmdG/0pEoOYr5B1npe5I2VelDSACJdK
         MvgcTNwzAnG0s8LZVrTalK5QshnpzfVoPY/dXX8dZEi8olKSURfIUwzlzm1Aw4sMMf
         oIPXM+hczyzpELBKEMapdd7lRZO4iUzlWI2X31WaWhvwIEGX1Y3cnc9svGRVYLlGtc
         VTVqaOnaQ6XdA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Tariq Toukan <tariqt@nvidia.com>,
        Maxim Mikityanskiy <maxtram95@gmail.com>,
        Adham Faris <afaris@nvidia.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] mlx5: avoid integer overflow warning for large page size
Date:   Thu, 22 Jun 2023 12:15:02 +0200
Message-Id: <20230622101525.3321642-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Build testing with 'make LLVM=1 W=1' shows a warning about a
condition that is always true on configurations with 64KB
pages:

drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c:32:22: error: result of comparison of constant 65536 with expression of type 'u16' (aka 'unsigned short') is always false [-Werror,-Wtautological-constant-out-of-range-compare]

Change the condition in a way that lets clang know this
is intentional.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
index 36826b5824847..b9f62e531bd4c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
@@ -29,7 +29,8 @@ bool mlx5e_validate_xsk_param(struct mlx5e_params *params,
 			      struct mlx5_core_dev *mdev)
 {
 	/* AF_XDP doesn't support frames larger than PAGE_SIZE. */
-	if (xsk->chunk_size > PAGE_SIZE || xsk->chunk_size < MLX5E_MIN_XSK_CHUNK_SIZE) {
+	if ((PAGE_SIZE < U16_MAX && xsk->chunk_size > PAGE_SIZE)
+	    || xsk->chunk_size < MLX5E_MIN_XSK_CHUNK_SIZE) {
 		mlx5_core_err(mdev, "XSK chunk size %u out of bounds [%u, %lu]\n", xsk->chunk_size,
 			      MLX5E_MIN_XSK_CHUNK_SIZE, PAGE_SIZE);
 		return false;
-- 
2.39.2

