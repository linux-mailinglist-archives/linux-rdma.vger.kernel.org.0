Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADD0567A7B
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Jul 2022 01:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiGEXCR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Jul 2022 19:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiGEXCQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Jul 2022 19:02:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87F5183A3
        for <linux-rdma@vger.kernel.org>; Tue,  5 Jul 2022 16:02:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B0D7B81A52
        for <linux-rdma@vger.kernel.org>; Tue,  5 Jul 2022 23:02:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51F0C341CD;
        Tue,  5 Jul 2022 23:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657062133;
        bh=AoHVBBZvBZ9YDTLlwYjl5aU2ZlYe6TapucRcMoW+S8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qw9B0KxytKBrsJyPFrl/1LHrqv1PmGHzxaE147WDeL07TFoQnb4Vak3zGYExNSq6B
         3zH+Jj4ZDf3Uzrv3aCvzwgryQk/pXUKGvuhkPm/Jf7TDwg616nvbnzKoCUy1swAQ1P
         GvmERAxXRRr5Fni+V4jdWQ43ynzFNgOun7BlaUeuNkftnkCJZ9GvJkUSpJJdw4JN0H
         Hb1JRrn4uEasmdXkfqEcnundmQiGWyzBmD7fNyyKpv0yvm3S+rmBRhtsxzvkX4vWWn
         hjgmoZlufI2SBrHM8o9u6o1RBUXGm5UKmrp55YHzgshla9tapEuNBE38HCGfqDzsa2
         Kq98jCWLSxV7Q==
From:   Jakub Kicinski <kuba@kernel.org>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        dennis.dalessandro@cornelisnetworks.com
Subject: [PATCH rdma-next 1/3] IB/hfi1: switch to netif_napi_add_tx()
Date:   Tue,  5 Jul 2022 16:02:06 -0700
Message-Id: <20220705230208.924408-2-kuba@kernel.org>
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

Switch to the new API not requiring the NAPI_POLL_WEIGHT argument.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: dennis.dalessandro@cornelisnetworks.com
CC: jgg@ziepe.ca
CC: leon@kernel.org
CC: linux-rdma@vger.kernel.org
---
 drivers/infiniband/hw/hfi1/ipoib_tx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/ipoib_tx.c b/drivers/infiniband/hw/hfi1/ipoib_tx.c
index d6bbdb8fcb50..5d9a7b09ca37 100644
--- a/drivers/infiniband/hw/hfi1/ipoib_tx.c
+++ b/drivers/infiniband/hw/hfi1/ipoib_tx.c
@@ -742,9 +742,7 @@ int hfi1_ipoib_txreq_init(struct hfi1_ipoib_dev_priv *priv)
 				kzalloc_node(sizeof(*tx->sdma_hdr),
 					     GFP_KERNEL, priv->dd->node);
 
-		netif_tx_napi_add(dev, &txq->napi,
-				  hfi1_ipoib_poll_tx_ring,
-				  NAPI_POLL_WEIGHT);
+		netif_napi_add_tx(dev, &txq->napi, hfi1_ipoib_poll_tx_ring);
 	}
 
 	return 0;
-- 
2.36.1

