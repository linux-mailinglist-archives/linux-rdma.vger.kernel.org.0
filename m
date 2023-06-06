Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F17A723882
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jun 2023 09:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236060AbjFFHMz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Jun 2023 03:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235906AbjFFHMd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Jun 2023 03:12:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04015E7F
        for <linux-rdma@vger.kernel.org>; Tue,  6 Jun 2023 00:12:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7027962DA6
        for <linux-rdma@vger.kernel.org>; Tue,  6 Jun 2023 07:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DE7C433D2;
        Tue,  6 Jun 2023 07:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686035550;
        bh=LvJ3Nqcwx2ubTY72fUCes0Oz3BY+iZ9j20J0IG69fCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cZUhdFYvNzdOuokcbi7lpllfMb+RBoR41UkANJsb1/b5Jf1kz4SCveTA4cTfnwW+e
         KFcERgf9+pBd8WeRNFsgGnxHEk3v28fz+3Ohgp4PtENGTS8V/XZCg2/yCiYWDObE0C
         qYhNrDw8EJatfWtP8p5halQGcKUdzN+ewshKcV4G3IG3lky8AGzET97QLD9GdwEf6c
         zcGeQGqiACnSfD97WFz1YQ1KK3x78xkDCxA6zwW0UzU3xdLyqHHK9juvvsfCQicEoI
         M8QEQgGNh9uaJe3yxUeXu5ubza25d1c7agKaMdnQfz+7wlN+HvSItCMYKUNFMq+sip
         iJ9db1mwcClgg==
From:   Saeed Mahameed <saeed@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
        Tariq Toukan <tariqt@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-rdma@vger.kernel.org, Shay Drory <shayd@nvidia.com>,
        Mark Bloch <mbloch@nvidia.com>
Subject: [net-next 01/15] RDMA/mlx5: Free second uplink ib port
Date:   Tue,  6 Jun 2023 00:12:05 -0700
Message-Id: <20230606071219.483255-2-saeed@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606071219.483255-1-saeed@kernel.org>
References: <20230606071219.483255-1-saeed@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Shay Drory <shayd@nvidia.com>

The cited patch introduce ib port for the slave device uplink in
case of multiport eswitch. However, this ib port didn't perform
anything when unloaded.
Unload the new ib port properly.

Fixes: 27f9e0ccb6da ("net/mlx5: Lag, Add single RDMA device in multiport mode")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/infiniband/hw/mlx5/ib_rep.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/ib_rep.c b/drivers/infiniband/hw/mlx5/ib_rep.c
index ddcfc116b19a..a4db22fe1883 100644
--- a/drivers/infiniband/hw/mlx5/ib_rep.c
+++ b/drivers/infiniband/hw/mlx5/ib_rep.c
@@ -126,7 +126,7 @@ mlx5_ib_vport_rep_unload(struct mlx5_eswitch_rep *rep)
 	    !mlx5_lag_is_master(mdev)) {
 		struct mlx5_core_dev *peer_mdev;
 
-		if (rep->vport == MLX5_VPORT_UPLINK)
+		if (rep->vport == MLX5_VPORT_UPLINK && !mlx5_lag_is_mpesw(mdev))
 			return;
 		peer_mdev = mlx5_lag_get_peer_mdev(mdev);
 		vport_index += mlx5_eswitch_get_total_vports(peer_mdev);
@@ -146,6 +146,9 @@ mlx5_ib_vport_rep_unload(struct mlx5_eswitch_rep *rep)
 		struct mlx5_core_dev *peer_mdev;
 		struct mlx5_eswitch *esw;
 
+		if (mlx5_lag_is_shared_fdb(mdev) && !mlx5_lag_is_master(mdev))
+			return;
+
 		if (mlx5_lag_is_shared_fdb(mdev)) {
 			peer_mdev = mlx5_lag_get_peer_mdev(mdev);
 			esw = peer_mdev->priv.eswitch;
-- 
2.40.1

