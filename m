Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F38975E292
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Jul 2023 16:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjGWOV1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Jul 2023 10:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGWOV1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Jul 2023 10:21:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F024695
        for <linux-rdma@vger.kernel.org>; Sun, 23 Jul 2023 07:21:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E6A760DB6
        for <linux-rdma@vger.kernel.org>; Sun, 23 Jul 2023 14:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF6BC433C9;
        Sun, 23 Jul 2023 14:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690122082;
        bh=BI9q0oQ3F2zajfAEZ2XfaVeT4DE8QyWsy5SeaYJjzSg=;
        h=From:To:Cc:Subject:Date:From;
        b=BYlIl7bN+74VQcCTtlyR9aByDzhaQTJkaCBobHu+bOqvSfm6iL5d9ryk1O//xd2Cc
         J0somtCcVDWzjwvIw+Wtz41yQw1nwKxeXmYWI2GgBlhCz4aB+ujIGLKVlEXryJQ4I4
         5vJChCYf8K3kZTgsYeSDAa2/k+mqaqDOHvIDV0wAMf/ImHzrPEcG6SkvwyhbU1294J
         xY+vti6+5E39d5kPawKAntxLKkH4+OvF6uT3/W6/aBY452BRj2kLsq3yIDweJgEl95
         mn8WcmP82kSq+Mtxi2Uzpct3ZpC+jzLMkrqz1XPrwS2LCid8H4/8sajhvZTRF74ke2
         I0isWQkG6vV1g==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Shetu Ayalew <shetu@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH rdma-next v1] IB/mlx5: Add HW counter called rx_dct_connect
Date:   Sun, 23 Jul 2023 17:21:14 +0300
Message-ID: <01cd24cd7f591734741309921fdc01fc770d84a8.1690121941.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
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

From: Shetu Ayalew <shetu@nvidia.com>

The rx_dct_connect counter shows the number of received connection
requests for the associated DCTs.

Signed-off-by: Shetu Ayalew <shetu@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Changelog:
v1:
 * Moved rx_dct_connect from retrans_q_cnts section to basic_q_cnts section.
v0: https://lore.kernel.org/all/6d2313eedc567fc29f5ba53c197d5678962bb43a.1689757404.git.leon@kernel.org
---
 drivers/infiniband/hw/mlx5/counters.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/counters.c b/drivers/infiniband/hw/mlx5/counters.c
index 93257fa5aae8..8300ce622835 100644
--- a/drivers/infiniband/hw/mlx5/counters.c
+++ b/drivers/infiniband/hw/mlx5/counters.c
@@ -27,6 +27,7 @@ static const struct mlx5_ib_counter basic_q_cnts[] = {
 	INIT_Q_COUNTER(rx_write_requests),
 	INIT_Q_COUNTER(rx_read_requests),
 	INIT_Q_COUNTER(rx_atomic_requests),
+	INIT_Q_COUNTER(rx_dct_connect),
 	INIT_Q_COUNTER(out_of_buffer),
 };
 
@@ -46,6 +47,7 @@ static const struct mlx5_ib_counter vport_basic_q_cnts[] = {
 	INIT_VPORT_Q_COUNTER(rx_write_requests),
 	INIT_VPORT_Q_COUNTER(rx_read_requests),
 	INIT_VPORT_Q_COUNTER(rx_atomic_requests),
+	INIT_VPORT_Q_COUNTER(rx_dct_connect),
 	INIT_VPORT_Q_COUNTER(out_of_buffer),
 };
 
-- 
2.41.0

