Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E4C75911B
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jul 2023 11:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjGSJFK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jul 2023 05:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjGSJE7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jul 2023 05:04:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79072711
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jul 2023 02:04:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7BDF611F6
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jul 2023 09:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AAC8C433C8;
        Wed, 19 Jul 2023 09:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689757437;
        bh=Bgo2IUQwL9S9EFvZj+Sk6bqqTDrKNfaJwza7aNHlIvA=;
        h=From:To:Cc:Subject:Date:From;
        b=gPwc7FkYHgiIZwaAIj22ff17bvAFH0vqbET1TAZnsAwcYRI6kdqUBbUgY+1y+c3Ma
         elSXh69F3Er24ey54MYy+VIERqKhQlOnwT3wOcGETIregUidWYuGfA8mMtYfQF9eAn
         Lb9BUhqXPsEMeA+wGj/styku2N+7gVPzeotuwbkaJWz1R2WBQscaUtwc31oOXPNh2E
         X52iWv2GRWknuxmXqKMRxdkjofoRmmbbqqQficIha5w7tzqtzjrrl5mhDELdaV1OeT
         DNaNh7pBtiBGMIumUBst1OP9TmhEq5Dq5G2giGd6mZg6l5sREdWVqNBCiOf3KHyZHn
         BmVcQLaOrL1bw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Shetu Ayalew <shetu@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>
Subject: [PATCH rdma-next] IB/mlx5: Add HW counter called rx_dct_connect
Date:   Wed, 19 Jul 2023 12:03:51 +0300
Message-ID: <6d2313eedc567fc29f5ba53c197d5678962bb43a.1689757404.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
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

From: Shetu Ayalew <shetu@nvidia.com>

The rx_dct_connect counter shows the number of received connection
requests for the associated DCTs.

Signed-off-by: Shetu Ayalew <shetu@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/counters.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/mlx5/counters.c b/drivers/infiniband/hw/mlx5/counters.c
index 93257fa5aae8..14af6ff91dfa 100644
--- a/drivers/infiniband/hw/mlx5/counters.c
+++ b/drivers/infiniband/hw/mlx5/counters.c
@@ -40,6 +40,7 @@ static const struct mlx5_ib_counter retrans_q_cnts[] = {
 	INIT_Q_COUNTER(packet_seq_err),
 	INIT_Q_COUNTER(implied_nak_seq_err),
 	INIT_Q_COUNTER(local_ack_timeout_err),
+	INIT_Q_COUNTER(rx_dct_connect),
 };
 
 static const struct mlx5_ib_counter vport_basic_q_cnts[] = {
-- 
2.41.0

