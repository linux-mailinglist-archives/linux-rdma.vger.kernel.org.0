Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD99567A7C
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Jul 2022 01:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiGEXCS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Jul 2022 19:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiGEXCQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Jul 2022 19:02:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D7F186C8
        for <linux-rdma@vger.kernel.org>; Tue,  5 Jul 2022 16:02:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EAF87B81A53
        for <linux-rdma@vger.kernel.org>; Tue,  5 Jul 2022 23:02:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB78C341D0;
        Tue,  5 Jul 2022 23:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657062133;
        bh=izNugGZMhJ/GfuzadwaQToO1AjIs0aysSHFgrWobP5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SQdlsa0PlJZE6lqlRv7ERjq3evTf6fEGAMpfvkcUnfruwz54UhNR8GCVL82jeLyiw
         YChk3PmxuQZrUZhuOr7IqoxCoMgfC551sss18xPKY2ODrYt+QTq5Bvhl0N0hK0f9xa
         u2zd+fpPsgWiExN9FV73k3pNsWPFfSNptcUOyZdXQyByY4kIo4cdgscQ/f7esiviZu
         Eq7PNhgm4iBgeGXgNaqWqeJW566dSlYoDm8da2hG17ECwPrDS67GdLw8Tpo6fWCSUi
         2jANnP2ZJPCmwwyASjZALLgyA5R3UlkRBIZwRMd9VpT0NZdL3tgrT8MZ85dzOVqFrZ
         Y0K6mntj8xN7Q==
From:   Jakub Kicinski <kuba@kernel.org>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH rdma-next 3/3] ipoib: switch to netif_napi_add_weight()
Date:   Tue,  5 Jul 2022 16:02:08 -0700
Message-Id: <20220705230208.924408-4-kuba@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220705230208.924408-1-kuba@kernel.org>
References: <20220705230208.924408-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

We want to remove the weight argument from the basic
netif_napi_add() API and just default to 64.
Switch ipoib to the new API for explicitly specifing
the weight.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jgg@ziepe.ca
CC: leon@kernel.org
CC: linux-rdma@vger.kernel.org
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 2a8961b685c2..a4904371e2db 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -1664,8 +1664,10 @@ static void ipoib_napi_add(struct net_device *dev)
 {
 	struct ipoib_dev_priv *priv = ipoib_priv(dev);
 
-	netif_napi_add(dev, &priv->recv_napi, ipoib_rx_poll, IPOIB_NUM_WC);
-	netif_napi_add(dev, &priv->send_napi, ipoib_tx_poll, MAX_SEND_CQE);
+	netif_napi_add_weight(dev, &priv->recv_napi, ipoib_rx_poll,
+			      IPOIB_NUM_WC);
+	netif_napi_add_weight(dev, &priv->send_napi, ipoib_tx_poll,
+			      MAX_SEND_CQE);
 }
 
 static void ipoib_napi_del(struct net_device *dev)
-- 
2.36.1

