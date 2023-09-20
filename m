Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0C27A787C
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 12:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbjITKCW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Sep 2023 06:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbjITKCV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Sep 2023 06:02:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C206BC2
        for <linux-rdma@vger.kernel.org>; Wed, 20 Sep 2023 03:02:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC84CC433C9;
        Wed, 20 Sep 2023 10:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695204135;
        bh=9AB5Xrqd9JGHrc0Re4GbRE58CUZg3MP+CvlPQhDiwRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Di8ftGAb+DkcLq+ZCsvrQcym/rIItRJklzIXx96mejuOCJ1BHuv2/rj/orJu+2yjL
         z/Peh4vGdKKUSmuNBI56ImAxDdFhgRWckFepXvp28snxX1Jf8MnJ7HgnzIgAPEkStC
         v5Xsh/bUfx8scvzPw5UZPBm9TOFjlJy49Wr3xWh2KhqypqnEbFw+iinl5G1c/hY3fJ
         kL0kkeWBaJWbmAPap7apRd65XxDDc7HekjUviD85c1e5dqIBbMUk3anYgTLMYNog2l
         UsauS9bK9isXsHIUmMB5EUk+5Y8IMBZiqiioDTxigmOavz27JXWduYHiwn7+WB8XMm
         5saI2KQZ2J8EQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Shay Drory <shayd@nvidia.com>, Edward Srouji <edwards@nvidia.com>,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>,
        Mark Bloch <mbloch@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-rc 3/3] RDMA/mlx5: Fix NULL string error
Date:   Wed, 20 Sep 2023 13:01:56 +0300
Message-ID: <8638e5c14fadbde5fa9961874feae917073af920.1695203958.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695203958.git.leonro@nvidia.com>
References: <cover.1695203958.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Shay Drory <shayd@nvidia.com>

checkpath is complaining about NULL string, change it to 'Unknown'.

Fixes: 37aa5c36aa70 ("IB/mlx5: Add UARs write-combining and non-cached mapping")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index aed5cdea50e6..555629b798b9 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2084,7 +2084,7 @@ static inline char *mmap_cmd2str(enum mlx5_ib_mmap_cmd cmd)
 	case MLX5_IB_MMAP_DEVICE_MEM:
 		return "Device Memory";
 	default:
-		return NULL;
+		return "Unknown";
 	}
 }
 
-- 
2.41.0

