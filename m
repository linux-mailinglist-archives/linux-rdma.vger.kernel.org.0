Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADF8727037
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jun 2023 23:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbjFGVFs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Jun 2023 17:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236792AbjFGVFL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Jun 2023 17:05:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FF62709
        for <linux-rdma@vger.kernel.org>; Wed,  7 Jun 2023 14:04:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C087649CB
        for <linux-rdma@vger.kernel.org>; Wed,  7 Jun 2023 21:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69391C433B3;
        Wed,  7 Jun 2023 21:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686171879;
        bh=SCPGQDaiOmgv4WfRu3mWoyJB1OIsY/K3JEmAQ5RxAxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ai2ieABfR4pZ0vXRIOQX1GGXYXiqT3Kt76ntXgBnZJIOZZRkmaOsr7sxppodWDRUa
         JSbPU8CU856HOqI+Wkk+Y6ZzMIjfB3HD2e1ZJFTiUljJqTGl3awPyRHDjnTqxw/a0j
         sof+81R2TEtvBMCuTmQBUEY2GZkTMyJeMJ4LvcxbFaXNuSEVrz3WucKh8bpaN8Yc6E
         3WBvxZJ+6QwLb3LVKpTyn8/Zj1ZsKi9iMiolT8DyANIWTxn/FvZ/w1mBJxpJ7k4VvX
         G167wwTCUX9BwAUpMy1gDHO3Wjk3ajr+Aqm6KSI1v03TuDZ5vGX0EnZWHKY4tuuGCI
         ddwtPJT2aiUew==
From:   Saeed Mahameed <saeed@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
        Tariq Toukan <tariqt@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-rdma@vger.kernel.org, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [net-next V2 10/14] net/mlx5e: Remove RX page cache leftovers
Date:   Wed,  7 Jun 2023 14:04:06 -0700
Message-Id: <20230607210410.88209-11-saeed@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607210410.88209-1-saeed@kernel.org>
References: <20230607210410.88209-1-saeed@kernel.org>
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

From: Tariq Toukan <tariqt@nvidia.com>

Remove unused definitions left after the removal
of the RX page cache feature.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 8e999f238194..ceabe57c511a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -594,13 +594,6 @@ struct mlx5e_mpw_info {
 
 #define MLX5E_MAX_RX_FRAGS 4
 
-/* a single cache unit is capable to serve one napi call (for non-striding rq)
- * or a MPWQE (for striding rq).
- */
-#define MLX5E_CACHE_UNIT (MLX5_MPWRQ_MAX_PAGES_PER_WQE > NAPI_POLL_WEIGHT ? \
-			  MLX5_MPWRQ_MAX_PAGES_PER_WQE : NAPI_POLL_WEIGHT)
-#define MLX5E_CACHE_SIZE	(4 * roundup_pow_of_two(MLX5E_CACHE_UNIT))
-
 struct mlx5e_rq;
 typedef void (*mlx5e_fp_handle_rx_cqe)(struct mlx5e_rq*, struct mlx5_cqe64*);
 typedef struct sk_buff *
-- 
2.40.1

