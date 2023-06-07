Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EC5727039
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jun 2023 23:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbjFGVFt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Jun 2023 17:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236908AbjFGVFO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Jun 2023 17:05:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49891721
        for <linux-rdma@vger.kernel.org>; Wed,  7 Jun 2023 14:04:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95066649E4
        for <linux-rdma@vger.kernel.org>; Wed,  7 Jun 2023 21:04:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F56C4331E;
        Wed,  7 Jun 2023 21:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686171884;
        bh=+x5l76jEigP+jfedcLp5qK2IoJnrnOHNChSi6eV9RfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PlyRi4egE7WcLCeYsXKBDXKkCCNpShyLc063sG6Cw7H0MBCp9cVtbF+m1Vg1FSUOg
         3RDim0Fs7km0dhD8Xlx1kX7KPp/Ty1yoEoFek95kfhdH697MkgTXFdDtZnRA4dU3Ut
         /RaRbeWqRgvOY0WtjRKtLW3nGWRlVUHKTWchFypVwg5o5owFXt6qNXAK5lkJXbrrCR
         A7+YH1tMwdQhs5a7B/iAYEIJaOOLhSKzLw8DddOkeJPD9rdZJhHFG+kw8Z2ve2GvMI
         UIQX4oI9p12hQbDltvhDK4owz2AlhCyutDQzliikOcme9tx/hY/USQDpgSQ+Oc1+Ud
         3n/c9hnIDF+NQ==
From:   Saeed Mahameed <saeed@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
        Tariq Toukan <tariqt@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [net-next V2 14/14] net/mlx5e: simplify condition after napi budget handling change
Date:   Wed,  7 Jun 2023 14:04:10 -0700
Message-Id: <20230607210410.88209-15-saeed@kernel.org>
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

From: Jakub Kicinski <kuba@kernel.org>

Since recent commit budget can't be 0 here.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
index fbb2d963fb7e..a7d9b7cb4297 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -207,7 +207,7 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
 		}
 		ch_stats->aff_change++;
 		aff_change = true;
-		if (budget && work_done == budget)
+		if (work_done == budget)
 			work_done--;
 	}
 
-- 
2.40.1

