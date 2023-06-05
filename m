Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D43722327
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jun 2023 12:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbjFEKOj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Jun 2023 06:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjFEKOh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Jun 2023 06:14:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7885A118
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 03:14:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F053E62214
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 10:14:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6B3C433A0;
        Mon,  5 Jun 2023 10:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685960066;
        bh=QfSq/8HGnCI9pJaK2B2ezUlX+KtyUbZYG96XddVGVRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WOakJVRCz/AegkEKgyDofqt/y1zbK1eNpXeB66aXedDX5VNakAEPlKYaxNAQUY1LZ
         jSfkXFCHrRGTqeMvUwli0V6bK/K/hAYmcVLIpJ499AXH6eqX0DHCjrPe6UNTMOvjYi
         LtCu8qU2SH7EB+gGDY0vQpWGDCagqaTAnmOofiqvX0iFMWRjC0cv924/sFPZyvj+gd
         KjcZaek2rlktwcfhyhgBsSd4kk8YBLGKWCi6J83dK8zxiVYyOfMIyDi+hlylWe0TkM
         yf2g+SQMHxYz1Gua/5lJ482zKW/O8Wfh5X7jMr6UjhIXOOs+NSUNgGxHmwmEJXpG53
         vLw/iDZ/h8GRQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Patrisious Haddad <phaddad@nvidia.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH rdma-next v2 1/4] net/mlx5: Nullify qp->dbg pointer post destruction
Date:   Mon,  5 Jun 2023 13:14:04 +0300
Message-Id: <1677e52bb642fd8d6062d73a5aa69083c0283dc9.1685953497.git.leon@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685953497.git.leon@kernel.org>
References: <cover.1685953497.git.leon@kernel.org>
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

From: Patrisious Haddad <phaddad@nvidia.com>

Nullifying qp->dbg is a preparation for the next patches
from the series in which mlx5_core_destroy_qp() could actually fail,
and then it can be called again which causes a kernel crash, since
qp->dbg was not nullified in previous call.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/debugfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c b/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c
index bb95b40d25eb..b08b5695ee45 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c
@@ -513,11 +513,11 @@ EXPORT_SYMBOL(mlx5_debug_qp_add);
 
 void mlx5_debug_qp_remove(struct mlx5_core_dev *dev, struct mlx5_core_qp *qp)
 {
-	if (!mlx5_debugfs_root)
+	if (!mlx5_debugfs_root || !qp->dbg)
 		return;
 
-	if (qp->dbg)
-		rem_res_tree(qp->dbg);
+	rem_res_tree(qp->dbg);
+	qp->dbg = NULL;
 }
 EXPORT_SYMBOL(mlx5_debug_qp_remove);
 
-- 
2.40.1

