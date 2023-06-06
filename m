Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F0872388F
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jun 2023 09:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236035AbjFFHNF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Jun 2023 03:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236034AbjFFHMt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Jun 2023 03:12:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3B310C1
        for <linux-rdma@vger.kernel.org>; Tue,  6 Jun 2023 00:12:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3069A62DE6
        for <linux-rdma@vger.kernel.org>; Tue,  6 Jun 2023 07:12:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8A7C433AC;
        Tue,  6 Jun 2023 07:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686035566;
        bh=5NlsN7pLzXpaNjECSFG1IUoDb5w06ZzIaeCY1eBb3Qg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VY8zBCcSj6wYBDs3aVT+1hc4MRXerQEdikJvVi5uqw6FUc9nQVDcKLE0ubYRzfP3L
         C5FWpJ4xOKsR3e+Egc5u17ep9Wu83Q9RnVqrWCqV840awfS4hYWdxAapAONxBByd71
         TFUToCc9WZrJksWbHbzS98EC7QzasNul//rjwvyqg7eVG2XdYx3qFelG22/7nsSIrs
         fh2D+PtLlOerAz1U+bVrIp3QM30eXW9E6lDyuxURoyId73LHzViTOPAvf+VyfruGBX
         sQXMJy/0edbH/Pd058BmLTMR/oxyhJjBT+9nSRH8vNh0jQEn9ffb7dgLQSW4GYVeLp
         9GpkiJW+ITCkg==
From:   Saeed Mahameed <saeed@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
        Tariq Toukan <tariqt@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-rdma@vger.kernel.org, Jiri Pirko <jiri@nvidia.com>
Subject: [net-next 13/15] net/mlx5: Skip inline mode check after mlx5_eswitch_enable_locked() failure
Date:   Tue,  6 Jun 2023 00:12:17 -0700
Message-Id: <20230606071219.483255-14-saeed@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606071219.483255-1-saeed@kernel.org>
References: <20230606071219.483255-1-saeed@kernel.org>
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

From: Jiri Pirko <jiri@nvidia.com>

Commit bffaa916588e ("net/mlx5: E-Switch, Add control for inline mode")
added inline mode checking to esw_offloads_start() with a warning
printed out in case there is a problem. Tne inline mode checking was
done even after mlx5_eswitch_enable_locked() call failed, which is
pointless.

Later on, commit 8c98ee77d911 ("net/mlx5e: E-Switch, Add extack messages
to devlink callbacks") converted the error/warning prints to extack
setting, which caused that the inline mode check error to overwrite
possible previous extack message when mlx5_eswitch_enable_locked()
failed. User then gets confusing error message.

Fix this by skipping check of inline mode after
mlx5_eswitch_enable_locked() call failed.

Fixes: bffaa916588e ("net/mlx5: E-Switch, Add control for inline mode")
Fixes: 8c98ee77d911 ("net/mlx5e: E-Switch, Add extack messages to devlink callbacks")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 29de4e759f4f..eafb098db6b0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2178,6 +2178,7 @@ static int esw_offloads_start(struct mlx5_eswitch *esw,
 				   "Failed setting eswitch to offloads");
 		esw->mode = MLX5_ESWITCH_LEGACY;
 		mlx5_rescan_drivers(esw->dev);
+		return err;
 	}
 	if (esw->offloads.inline_mode == MLX5_INLINE_MODE_NONE) {
 		if (mlx5_eswitch_inline_mode_get(esw,
@@ -2187,7 +2188,7 @@ static int esw_offloads_start(struct mlx5_eswitch *esw,
 					   "Inline mode is different between vports");
 		}
 	}
-	return err;
+	return 0;
 }
 
 static void mlx5_esw_offloads_rep_mark_set(struct mlx5_eswitch *esw,
-- 
2.40.1

