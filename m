Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC93814B57E
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jan 2020 14:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgA1N4U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jan 2020 08:56:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:42802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbgA1N4U (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 Jan 2020 08:56:20 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEA972173E;
        Tue, 28 Jan 2020 13:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580219779;
        bh=tPB30AduGp5no6BUPgfVc+JowWLfls1Pwp9SLp4lz60=;
        h=From:To:Cc:Subject:Date:From;
        b=mFVXxHGbt1wV54rOpoA1NvvPI9M+NkfHfWsf2c0DAVRENrMRH+YCZ0anTDWa4lBxc
         f08bc0lw9WbJpp8NMFUphzx9bImwpNv+fxu8+K9wzcb3mx+eH30sqFP6MWC8bsg5Dg
         zWSX8EgfZPTUHhCWP4Xa3kgjkABZd7bmymQl9bV8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Gal Pressman <galpress@amazon.com>
Cc:     Artemy Kovalyov <artemyko@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH rdma-rc] RDMA/umem: Fix ib_umem_find_best_pgsz()
Date:   Tue, 28 Jan 2020 15:56:12 +0200
Message-Id: <20200128135612.174820-1-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Artemy Kovalyov <artemyko@mellanox.com>

Except for the last entry, the ending iova alignment sets the maximum
possible page size as the low bits of the iova must be zero when
starting the next chunk.

Fixes: 4a35339958f1 ("RDMA/umem: Add API to find best driver supported page size in an MR")
Signed-off-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/umem.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 933dc1aeed5f..82455a1392f1 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -166,10 +166,13 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
 		 * for any address.
 		 */
 		mask |= (sg_dma_address(sg) + pgoff) ^ va;
-		if (i && i != (umem->nmap - 1))
-			/* restrict by length as well for interior SGEs */
-			mask |= sg_dma_len(sg);
 		va += sg_dma_len(sg) - pgoff;
+		/* Except for the last entry, the ending iova alignment sets
+		 * the maximum possible page size as the low bits of the iova
+		 * must be zero when starting the next chunk.
+		 */
+		if (i != (umem->nmap - 1))
+			mask |= va;
 		pgoff = 0;
 	}
 	best_pg_bit = rdma_find_pg_bit(mask, pgsz_bitmap);
--
2.24.1

