Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5E85A45AA
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Aug 2022 11:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiH2JEW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Aug 2022 05:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiH2JEV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Aug 2022 05:04:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77A45A3CF
        for <linux-rdma@vger.kernel.org>; Mon, 29 Aug 2022 02:04:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 640B0B80D8C
        for <linux-rdma@vger.kernel.org>; Mon, 29 Aug 2022 09:04:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1E5C433D6;
        Mon, 29 Aug 2022 09:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661763858;
        bh=sRA2qeVyjq+B/DC7ye2lGpGZIMh3TdZBZNBy95Wnsyo=;
        h=From:To:Cc:Subject:Date:From;
        b=qtrp8QflUGXjeWfLiv70iexDggkKYdwRpAHXCk+LN7oJZLmf9nuNkZcddA0qo2N9r
         caCGhOeKqDFw5xpUWPxwwFPPCKn7fNRBr4gpBa84OQCDBDTgcouu/YIdhF2F/VOpYt
         Lsd++4o7hDoNTNdWFC1LletlCWro/bYTBsVrjlQSid2rRkRuN98SN5Dku59rL9bjSS
         hUPRPJytkpwD6ERf8lZGvNzUswnOIFnR/tIDs4Hs7ctrc3BQ2/gRKtJNA8rv2WrbwG
         g+tHkIqSAMf+wJ3sgiQ8rFQrrhNL0pYzO895vYXHn4qV7olM26XH81WPnnOhbs9IPL
         5DMdnkI1q0i+Q==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Bodong Wang <bodong@mellanox.com>,
        Erez Shitrit <erezsh@nvidia.com>, linux-rdma@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH rdma-next] IB/mlx5: Support querying eswitch functions from DEVX
Date:   Mon, 29 Aug 2022 12:04:12 +0300
Message-Id: <4265925178ab3224dc1d3e3784bb312d808edca5.1661763785.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.37.2
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

From: Bodong Wang <bodong@mellanox.com>

Query eswitch functions returns information of the external host
PF(if it exists). It can be used to check if DEVX is running on ECPF.

Reviewed-by: Erez Shitrit <erezsh@nvidia.com>
Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Bodong Wang <bodong@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/devx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index d617f3ff9779..c8c345d90e0f 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -907,6 +907,7 @@ static bool devx_is_whitelist_cmd(void *in)
 	case MLX5_CMD_OP_QUERY_HCA_CAP:
 	case MLX5_CMD_OP_QUERY_HCA_VPORT_CONTEXT:
 	case MLX5_CMD_OP_QUERY_ESW_VPORT_CONTEXT:
+	case MLX5_CMD_OP_QUERY_ESW_FUNCTIONS:
 		return true;
 	default:
 		return false;
@@ -962,6 +963,7 @@ static bool devx_is_general_cmd(void *in, struct mlx5_ib_dev *dev)
 	case MLX5_CMD_OP_QUERY_CONG_PARAMS:
 	case MLX5_CMD_OP_QUERY_CONG_STATISTICS:
 	case MLX5_CMD_OP_QUERY_LAG:
+	case MLX5_CMD_OP_QUERY_ESW_FUNCTIONS:
 		return true;
 	default:
 		return false;
-- 
2.37.2

