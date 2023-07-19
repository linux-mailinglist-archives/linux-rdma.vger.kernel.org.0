Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F1C759101
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jul 2023 11:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjGSJDe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jul 2023 05:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjGSJCy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jul 2023 05:02:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31F2210D
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jul 2023 02:02:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EB4860DFA
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jul 2023 09:02:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E047AC433C9;
        Wed, 19 Jul 2023 09:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689757367;
        bh=cDNznz1x+Pv+hm4NxAC2Um0aY0OwLCxjN7p56KK4zLw=;
        h=From:To:Cc:Subject:Date:From;
        b=b0rJVFAi800yMDxAeOrJGljnDLd41qTxLJAHM+a4PuSSgLYasaWibp1PNH6F1PHIF
         8og8U6l802wqviIHBH44ixV8pxLIRz/0fIM/l0iYUxurc03O92Y7oVyWu4y7I08uF9
         c5p4WebKNWff+VFaPsDH/s/1jDdjq4WXRZ5GaJDPk+BlgDd7tCK44GBCy2EWfDuRXz
         J1K4AD+bTTpFTs7PXmEh0d7lbVo0aOOtX/8yo9hE3NVyAln0Z8c+h0bPdbzwL7Hme8
         D/8Is6oQoYb1AaYk+oGKsKq0Wzek+r0b2l1BfERTZ33JLalILA5l3pnztVfvPJw1kU
         m4ddHzufecblg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Michael Guralnik <michaelgur@nvidia.com>,
        Artemy Kovalyov <artemyko@nvidia.com>,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc] RDMA/umem: Set iova in ODP flow
Date:   Wed, 19 Jul 2023 12:02:41 +0300
Message-ID: <3d4be7ca2155bf239dd8c00a2d25974a92c26ab8.1689757344.git.leon@kernel.org>
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

From: Michael Guralnik <michaelgur@nvidia.com>

Fixing the ODP registration flow to set the iova correctly.
The calculation in ib_umem_num_dma_blocks() function assumes the iova of
the umem is set correctly.

When iova is not set, the calculation in ib_umem_num_dma_blocks() is
equivalent to length/page_size, which is true only when memory is aligned.
For unaligned memory, iova must be set for the ALIGN() in the
ib_umem_num_dma_blocks() to take effect and return a correct value.

mlx5_ib uses ib_umem_num_dma_blocks() to decide the mkey size to use for
the MR. Without this fix, when registering unaligned ODP MR, a wrong
size mkey might be chosen and this might cause the UMR to fail.

UMR would fail over insufficient size to update the mkey translation:
infiniband mlx5_0: dump_cqe:273:(pid 0): dump error cqe
00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000030: 00 00 00 00 0f 00 78 06 25 00 00 58 00 da ac d2
infiniband mlx5_0: mlx5_ib_post_send_wait:806:(pid 20311): reg umr
failed (6)
infiniband mlx5_0: pagefault_real_mr:661:(pid 20311): Failed to update
mkey page tables

Fixes: f0093fb1a7cb ("RDMA/mlx5: Move mlx5_ib_cont_pages() to the creation of the mlx5_ib_mr")
Fixes: a665aca89a41 ("RDMA/umem: Split ib_umem_num_pages() into ib_umem_num_dma_blocks()")
Signed-off-by: Artemy Kovalyov <artemyko@nvidia.com>
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/umem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 755a9c57db6f..f9ab671c8eda 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -85,6 +85,8 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
 	dma_addr_t mask;
 	int i;
 
+	umem->iova = va = virt;
+
 	if (umem->is_odp) {
 		unsigned int page_size = BIT(to_ib_umem_odp(umem)->page_shift);
 
@@ -100,7 +102,6 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
 	 */
 	pgsz_bitmap &= GENMASK(BITS_PER_LONG - 1, PAGE_SHIFT);
 
-	umem->iova = va = virt;
 	/* The best result is the smallest page size that results in the minimum
 	 * number of required pages. Compute the largest page size that could
 	 * work based on VA address bits that don't change.
-- 
2.41.0

