Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF0901263E3
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2019 14:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfLSNqz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Dec 2019 08:46:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:42468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbfLSNqy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Dec 2019 08:46:54 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB3862146E;
        Thu, 19 Dec 2019 13:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576763214;
        bh=KvuAOUW/odbDstYc5juVDpIOPTsOC0GL38VCt7xGbCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ACgYtm5daWJQhEYsKJ/SV4xQ4uZhizhxicIM+S+5d1SZLvHSd4rnaQ2vNqHVyG4Mb
         ftmXW3DXdHVOq145wWMgW1F3CxMlaXi0ppitRraC3pUozNdIp9UNJlheHE1cVebdiJ
         J0VjuOsrPWWgYEcFhYsEC2LiJ1c0xz5ktxE6UjpM=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Aviad Yehezkel <aviadye@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-rc 2/3] IB/core: Fix ODP get user pages flow
Date:   Thu, 19 Dec 2019 15:46:45 +0200
Message-Id: <20191219134646.413164-3-leon@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191219134646.413164-1-leon@kernel.org>
References: <20191219134646.413164-1-leon@kernel.org>
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

