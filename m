Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6014F117F
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Apr 2022 10:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245350AbiDDJAL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Apr 2022 05:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235945AbiDDJAK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Apr 2022 05:00:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C233BA4D
        for <linux-rdma@vger.kernel.org>; Mon,  4 Apr 2022 01:58:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 580A1611E0
        for <linux-rdma@vger.kernel.org>; Mon,  4 Apr 2022 08:58:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4415CC340EE;
        Mon,  4 Apr 2022 08:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649062694;
        bh=NfT6Qn535A1/iKirs09BQOj287UZljjGAEfRtW3B3Mg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gk1BmQwNYoX55ylEYs/ma5UpVbJ1nrC1keCyY7L+xIMAx5Km6ALCUcBymgtkJem55
         6AP//FrooXGVv5ySb7AQZL5Im1ACOf59c2u4qYqGrr9OKpj+qO2TMeaiH958DCYLxv
         7GcEJPPlRfTXZq24ujCuUSJHz7PnBo0vtHBx1lhHdGTE8qAddTRTpCNfUIqa1lPivv
         L68jA35uhc8D3I1VtB7WyuhX7R1qF2cOArWwglLyGnTWMmTUwtWh6fqDSU4qrFUZrK
         EzwtqLTNY+Gco6X4uP5MD9TtXbTigtFI6IENRbNorGZea1p6OVNAL1aov1+14gJJgP
         nO+wm6chhFULA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>,
        Shay Drory <shayd@nvidia.com>
Subject: [PATCH rdma-rc v1 2/3] RDMA/mlx5: Add a missing update of cache->last_add
Date:   Mon,  4 Apr 2022 11:58:04 +0300
Message-Id: <c99f076fce4b44829d434936bbcd3b5fc4c95020.1649062436.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649062436.git.leonro@nvidia.com>
References: <cover.1649062436.git.leonro@nvidia.com>
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

From: Aharon Landau <aharonl@nvidia.com>

Update cache->last_add when returning an MR to the cache so that the
cache work won't remove it.

Fixes: b9358bdbc713 ("RDMA/mlx5: Fix locking in MR cache work queue")
Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 45b0680377ec..32ef67e9a6a7 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -627,6 +627,7 @@ static void mlx5_mr_cache_free(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 {
 	struct mlx5_cache_ent *ent = mr->cache_ent;
 
+	WRITE_ONCE(dev->cache.last_add, jiffies);
 	spin_lock_irq(&ent->lock);
 	list_add_tail(&mr->list, &ent->head);
 	ent->available_mrs++;
-- 
2.35.1

