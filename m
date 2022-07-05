Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A97567A7A
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Jul 2022 01:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbiGEXCR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Jul 2022 19:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiGEXCQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Jul 2022 19:02:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C700186C4
        for <linux-rdma@vger.kernel.org>; Tue,  5 Jul 2022 16:02:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6FD2B81A49
        for <linux-rdma@vger.kernel.org>; Tue,  5 Jul 2022 23:02:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA8CC341CE;
        Tue,  5 Jul 2022 23:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657062133;
        bh=5kbgVomMAGpyYs52SXNju5YosWNFO0hC1IHMJKnbBWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K7unN78v8H6bfvy4XLBExJPbUoGKcjQnerf1v3Ys4rplKgJrcjAEqFdk3F+aNZX7s
         Vl/MJIgZVCyA4abyCa6fWxz2Q8wllT1q14DeULpUmVzHzqCnsZ93qI6yfPYc0Th5ZF
         2o7h4O57NuLqT/6n5pVM2Fq7k4Y1jSNfSVJ6wVwNnhpzdMlMCz1ABOnw1ViyNfHE2B
         K6Gs03EvT3wO+9UffYx3ojErVhHZQogDTt29dOc2mXMbfEZylj6a/jzlmKJ5Zrfyab
         swqDr+UMXKqIqvauW/stkD//FzYetAZIQAUO8abCutbE6Zv7+I4KGtOT0hCTl6VMnl
         Dpc7n0BijKgGA==
From:   Jakub Kicinski <kuba@kernel.org>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        dennis.dalessandro@cornelisnetworks.com
Subject: [PATCH rdma-next 2/3] IB/hfi1: switch to netif_napi_add_weight()
Date:   Tue,  5 Jul 2022 16:02:07 -0700
Message-Id: <20220705230208.924408-3-kuba@kernel.org>
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

Since we'll remove the last argument from netif_napi_add()
soon switch this RDMA driver to netif_napi_add_weight()
for now to avoid cross-tree patches.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: dennis.dalessandro@cornelisnetworks.com
CC: jgg@ziepe.ca
CC: leon@kernel.org
CC: linux-rdma@vger.kernel.org
---
 drivers/infiniband/hw/hfi1/netdev_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/netdev_rx.c b/drivers/infiniband/hw/hfi1/netdev_rx.c
index 03b098a494b5..3dfa5aff2512 100644
--- a/drivers/infiniband/hw/hfi1/netdev_rx.c
+++ b/drivers/infiniband/hw/hfi1/netdev_rx.c
@@ -216,7 +216,7 @@ static int hfi1_netdev_rxq_init(struct hfi1_netdev_rx *rx)
 		 * right now.
 		 */
 		set_bit(NAPI_STATE_NO_BUSY_POLL, &rxq->napi.state);
-		netif_napi_add(dev, &rxq->napi, hfi1_netdev_rx_napi, 64);
+		netif_napi_add_weight(dev, &rxq->napi, hfi1_netdev_rx_napi, 64);
 		rc = msix_netdev_request_rcd_irq(rxq->rcd);
 		if (rc)
 			goto bail_context_irq_failure;
-- 
2.36.1

