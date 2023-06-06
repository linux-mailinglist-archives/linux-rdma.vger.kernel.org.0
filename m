Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B00B723887
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jun 2023 09:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235898AbjFFHNA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Jun 2023 03:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235941AbjFFHMi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Jun 2023 03:12:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23075E5F
        for <linux-rdma@vger.kernel.org>; Tue,  6 Jun 2023 00:12:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAF836177C
        for <linux-rdma@vger.kernel.org>; Tue,  6 Jun 2023 07:12:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C973BC433B3;
        Tue,  6 Jun 2023 07:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686035557;
        bh=TxslIJuegigARBUmcC/zoGAApJ4huayWW1+6cWeHxpg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a46XpxIYiXm1HK/5xiAAVGj3V5Kv54yVSDcG1UPiHvb3lpsdrY98xLG60bhW1LOrF
         xE4etQwLlMSkromAmrtJ+bJOKh2/jLsI48XuSy8dizogImehSq1rzGvBPMjeTXAZOU
         PXuOMRKxY8yB62m4XnP4fxnI/7j7fpJ/S7eHnEj6ehfi8H+scJYx9UUg0QClF9+xNY
         /7k6F8yWAYcwVS+QEuItr69lU7bakn7XM/0Se4oweWtbKZ2Oib4pYeKVfWSnC7fMJ7
         bhSuIMbA/ac3g9yqm/O3E3yerH4lj8uVZ6USCm3/l5HEvSlfcCHKr6rqfD66mJCAMP
         Mq0KnA+s2zT8g==
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
Subject: [net-next 06/15] net/mlx5: LAG, block multipath LAG in case ldev have more than 2 ports
Date:   Tue,  6 Jun 2023 00:12:10 -0700
Message-Id: <20230606071219.483255-7-saeed@kernel.org>
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

From: Shay Drory <shayd@nvidia.com>

multipath LAG is not supported over more than two ports. Add a check in
order to block multipath LAG over such configurations.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c
index d85a8dfc153d..976caa8e6922 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c
@@ -14,6 +14,7 @@ static bool __mlx5_lag_is_multipath(struct mlx5_lag *ldev)
 	return ldev->mode == MLX5_LAG_MODE_MULTIPATH;
 }
 
+#define MLX5_LAG_MULTIPATH_OFFLOADS_SUPPORTED_PORTS 2
 static bool mlx5_lag_multipath_check_prereq(struct mlx5_lag *ldev)
 {
 	if (!mlx5_lag_is_ready(ldev))
@@ -22,6 +23,9 @@ static bool mlx5_lag_multipath_check_prereq(struct mlx5_lag *ldev)
 	if (__mlx5_lag_is_active(ldev) && !__mlx5_lag_is_multipath(ldev))
 		return false;
 
+	if (ldev->ports > MLX5_LAG_MULTIPATH_OFFLOADS_SUPPORTED_PORTS)
+		return false;
+
 	return mlx5_esw_multipath_prereq(ldev->pf[MLX5_LAG_P1].dev,
 					 ldev->pf[MLX5_LAG_P2].dev);
 }
-- 
2.40.1

