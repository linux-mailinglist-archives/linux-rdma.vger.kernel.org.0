Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B1272238C
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jun 2023 12:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjFEKdn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Jun 2023 06:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjFEKdm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Jun 2023 06:33:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263B2A6
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 03:33:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADE4D615DA
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 10:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A630BC4339B;
        Mon,  5 Jun 2023 10:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685961220;
        bh=UV70nQi+5y9J3tXlULJCqEQiGR0HO6Wwylntn9sRpW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wk9kIaDKj4LtLiV8/WhKRL6lgkvG384/Jky9Qk4nODNFkSPvTo26CdPnWKg5Z1fg5
         16DiqX/9SZ/hFqUvMx27czmZoWmm7l/0DQ2Rv+9eNxV7x7qvAsDIOcuTaZEgjRxTKZ
         1amUXXvfWqd4C/UA5yMtZ5rWu/TCShQkzm6Pt4vvuLP1COSqcV1PN+sCLbumO5FxKO
         pDE2ttxjN5/sBI49lk2gqyxTFL33vaBoBIAs3n9E4TPVRUVoD2MU0wiRyUUg7KgRzj
         75ONResCZg9QVs04JtWdbp92zZ0+vfqUYwsgtSNtKB69JcfCfqI+/4Y3A8uTCEvUAo
         2jNeb1MlcmYDQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maher Sanalla <msanalla@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>
Subject: [PATCH rdma-rc 01/10] RDMA/mlx5: Initiate dropless RQ for RAW Ethernet functions
Date:   Mon,  5 Jun 2023 13:33:17 +0300
Message-Id: <2e9d386785043d48c38711826eb910315c1de141.1685960567.git.leon@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685960567.git.leon@kernel.org>
References: <cover.1685960567.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maher Sanalla <msanalla@nvidia.com>

Delay drop data is initiated for PFs that have the capability of
rq_delay_drop and are in roce profile.

However, PFs with RAW ethernet profile do not initiate delay drop data
on function load, causing kernel panic if delay drop struct members are
accessed later on in case a dropless RQ is created.

Thus, stage the delay drop initialization as part of RAW ethernet
PF loading process.

Fixes: b5ca15ad7e61 ("IB/mlx5: Add proper representors support")
Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 5d45de223c43..f0b394ed7452 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4275,6 +4275,9 @@ const struct mlx5_ib_profile raw_eth_profile = {
 	STAGE_CREATE(MLX5_IB_STAGE_POST_IB_REG_UMR,
 		     mlx5_ib_stage_post_ib_reg_umr_init,
 		     NULL),
+	STAGE_CREATE(MLX5_IB_STAGE_DELAY_DROP,
+		     mlx5_ib_stage_delay_drop_init,
+		     mlx5_ib_stage_delay_drop_cleanup),
 	STAGE_CREATE(MLX5_IB_STAGE_RESTRACK,
 		     mlx5_ib_restrack_init,
 		     NULL),
-- 
2.40.1

