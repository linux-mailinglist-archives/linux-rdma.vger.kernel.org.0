Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9742D723893
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jun 2023 09:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236052AbjFFHNT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Jun 2023 03:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236002AbjFFHMw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Jun 2023 03:12:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A8310CE
        for <linux-rdma@vger.kernel.org>; Tue,  6 Jun 2023 00:12:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D994262DEC
        for <linux-rdma@vger.kernel.org>; Tue,  6 Jun 2023 07:12:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373EAC433A1;
        Tue,  6 Jun 2023 07:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686035569;
        bh=+x5l76jEigP+jfedcLp5qK2IoJnrnOHNChSi6eV9RfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IrgKQQpqxIZrCMsUIkh3jIwC0AgzFWUqmt68RTr11pmhbycnT26ekJsgkShOXWcPV
         DqjKOpQzjzJjgqSDmPRjjOjcs3TAFHI3QnhVtS9Xg9Ni3f0ynzOcwTKr7pnB1+LjW5
         qCBIntCuZyWVr7ByCFTTkjOu/qe8S5tmplkb4NgJNu3bVu0WIneOqSrnRjZxdB3z2Q
         4JsrTHIG0WK1WDwFlMfKwCwpHPmwPOLA+s553vIrcq/Kb0Eir29i3k2W+UJ0sNks16
         chSspSehQgDlx/kixzh6bmwBCjBQU1FR7CK8OZ/CGW8WwGYdy1lpCVpv5YIrOpq+1P
         5P9ve7/YF1e8w==
From:   Saeed Mahameed <saeed@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
        Tariq Toukan <tariqt@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [net-next 15/15] net/mlx5e: simplify condition after napi budget handling change
Date:   Tue,  6 Jun 2023 00:12:19 -0700
Message-Id: <20230606071219.483255-16-saeed@kernel.org>
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

