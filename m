Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EBA72388A
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jun 2023 09:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235961AbjFFHNC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Jun 2023 03:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236004AbjFFHMn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Jun 2023 03:12:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3C8E75
        for <linux-rdma@vger.kernel.org>; Tue,  6 Jun 2023 00:12:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 363A762B8C
        for <linux-rdma@vger.kernel.org>; Tue,  6 Jun 2023 07:12:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F339C4339E;
        Tue,  6 Jun 2023 07:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686035561;
        bh=zvaLiiOWfw1gltxm6jsLUMHZFwJP5r5B6KPxuTZZXmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BHYS/1ehOL1tXQ0l2/0CMUGeKRfiMw1guGbqqVy8cmEcnzeGbSRIbV8CjE1Do6clg
         WxOv7J3qQJ3O84heo/ZKEZA+TqVSTbp7cSV+82eAlPXqUJd+Q95zM1TNjKPD9IUUN0
         3fwF2NnlfgrH52BYTQBQIP06GdJHbcJ9FhRJ1fjV9LaGx0MZI/NCSxaDP6zTd5lNlj
         sqaafDKapXvhGQhlEcXPKJGlelRM1X3GIra0g2rmaqXdNVgzqfuXcJXaMGjlqiPxpH
         7+sDm7Oo5H8+zhvh+DFc3AkNrlN97s2wv4YZQrCKYDLHU4tDJzr2yIcDUDuj/Isdwg
         xOsHmE5ccVCoQ==
From:   Saeed Mahameed <saeed@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
        Tariq Toukan <tariqt@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-rdma@vger.kernel.org, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [net-next 09/15] net/mlx5e: RX, Log error when page_pool size is too large
Date:   Tue,  6 Jun 2023 00:12:13 -0700
Message-Id: <20230606071219.483255-10-saeed@kernel.org>
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

From: Dragos Tatulea <dtatulea@nvidia.com>

The page_pool error message is a bit cryptic when the
requested size is too large. Add a message on the driver
side to display how many pages were actually requested.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index a7c526ee5024..579eb8cd928e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -849,6 +849,9 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 		rq->page_pool = page_pool_create(&pp_params);
 		if (IS_ERR(rq->page_pool)) {
 			err = PTR_ERR(rq->page_pool);
+			if (err == -E2BIG)
+				mlx5_core_err(mdev, "requested page_pool size is too large: %u",
+					      pp_params.pool_size);
 			rq->page_pool = NULL;
 			goto err_free_by_rq_type;
 		}
-- 
2.40.1

