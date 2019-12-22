Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1788D128DF5
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Dec 2019 13:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfLVMrB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 Dec 2019 07:47:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:36938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfLVMrB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 22 Dec 2019 07:47:01 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 404CE206D3;
        Sun, 22 Dec 2019 12:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577018820;
        bh=J8KD/Odm6wVutt5XBJTIYTgAOuW2IAR2rsKHTGre4A4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xjv0do9LZNrZJr+LQH7buvkS3NpeJcm2Ia7+9fUURWrf2HDPACK2p1sS13aj3TQ/F
         ETLNQJ7rSY4QpkV6uY6kvAuqDPT+nKTXzkyzdpGWK2KO2yWswh5jS+YE6dwH0rqWZh
         IQhBgvQX5QhKBUKHx50J/+LkuyBfwj9xHvs1/JFw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-rc v1 2/3] IB/core: Fix ODP get user pages flow
Date:   Sun, 22 Dec 2019 14:46:48 +0200
Message-Id: <20191222124649.52300-3-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191222124649.52300-1-leon@kernel.org>
References: <20191222124649.52300-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@mellanox.com>

When calling get_user_pages_remote() need to work with granularity of
PAGE_SIZE.

Fix the calculation of how many entries can be read in one call to
consider that.

Fixes: 403cd12e2cf7 ("IB/umem: Add contiguous ODP support")
Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/umem_odp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index e42d44e501fd..2e9ee7adab13 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -440,7 +440,7 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 user_virt,
 
 	while (bcnt > 0) {
 		const size_t gup_num_pages = min_t(size_t,
-				(bcnt + BIT(page_shift) - 1) >> page_shift,
+				ALIGN(bcnt, PAGE_SIZE) / PAGE_SIZE,
 				PAGE_SIZE / sizeof(struct page *));
 
 		down_read(&owning_mm->mmap_sem);
-- 
2.20.1

