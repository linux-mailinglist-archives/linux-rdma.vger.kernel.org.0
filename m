Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0BF585E1F
	for <lists+linux-rdma@lfdr.de>; Sun, 31 Jul 2022 10:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbiGaI3S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 31 Jul 2022 04:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGaI3R (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 31 Jul 2022 04:29:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AD811161
        for <linux-rdma@vger.kernel.org>; Sun, 31 Jul 2022 01:29:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97669B80C95
        for <linux-rdma@vger.kernel.org>; Sun, 31 Jul 2022 08:29:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFA6C433D7;
        Sun, 31 Jul 2022 08:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659256154;
        bh=hHrJ6KAVfAIQXJeRMDPn58DHW3V3C0hTFUXUT+/yLug=;
        h=From:To:Cc:Subject:Date:From;
        b=d4myckAEHqovS3/4jU/vLjhz8CZY8PSLFH2SG5bOGYkpNNQygaDjZmOl8MeFXFnPE
         MBVzx/jbWipLMehfNIoRSrRvHYa7lAidrs9zcYZvLqTEu/aj7+i54MQJgDeuPtoegB
         uosXXgML+Ng3vHu2hPSAlWZXfZZ0ki4n+F0XMTMZ/WL0GFSoI6FGX2nIYTvprcoKPN
         wywnI16FGoYCZR2KdVxqDPstgo13aNM85xwO2vIvuZKr1Ele6mVHgCJER7uztintuy
         BYmCtPOZF5gWNYsgfDYJqueD0taK0Foe0X83bnODQhiFrHye13QgoFvakDcA2yGovf
         /MGElJ4BH5rPw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>, Itay Aveksis <itayav@nvidia.com>,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/mlx5: Add missing check for return value in get namespace flow
Date:   Sun, 31 Jul 2022 11:29:08 +0300
Message-Id: <7b9ceda217d9368a51dc47a46b769bad4af9ac92.1659256069.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@nvidia.com>

Add missing check for return value when calling to
mlx5_ib_ft_type_to_namespace, even though it can't really fail
in this specific call.

Fixes: 52438be44112 ("RDMA/mlx5: Allow inserting a steering rule to the FDB")
Reviewed-by: Itay Aveksis <itayav@nvidia.com>
Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/fs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
index 691d00c89f33..490ec308e309 100644
--- a/drivers/infiniband/hw/mlx5/fs.c
+++ b/drivers/infiniband/hw/mlx5/fs.c
@@ -2078,12 +2078,10 @@ static int mlx5_ib_matcher_ns(struct uverbs_attr_bundle *attrs,
 		if (err)
 			return err;
 
-		if (flags) {
-			mlx5_ib_ft_type_to_namespace(
+		if (flags)
+			return mlx5_ib_ft_type_to_namespace(
 				MLX5_IB_UAPI_FLOW_TABLE_TYPE_NIC_TX,
 				&obj->ns_type);
-			return 0;
-		}
 	}
 
 	obj->ns_type = MLX5_FLOW_NAMESPACE_BYPASS;
-- 
2.37.1

