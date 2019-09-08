Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8D60ACB76
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Sep 2019 10:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfIHIHc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 8 Sep 2019 04:07:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbfIHIHc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 8 Sep 2019 04:07:32 -0400
Received: from localhost (unknown [77.137.95.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE7B620854;
        Sun,  8 Sep 2019 08:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567930051;
        bh=ROToltyCXdQRA1OdVl3fYxBtFlviqXBGKGUL7H1tyoE=;
        h=From:To:Cc:Subject:Date:From;
        b=uQ/xEA+dU4WHYAQEj80AZdWPu1QLJnvJw22Y6FvvpMK3dMBSzn5UzUw8wrz6iLx01
         GxtH4OaHCkjDJilth+Twtg1dBMBWB2/3g4+x96ICSt6kcwcRACB5YKZ4IzTlWIhmIC
         tC3ByFLwhFsifCJyjsnyWCPeGPl6KA63lDjh2Q2M=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH rdma-next] RDMA/odp: Add missing cast for 32 bit
Date:   Sun,  8 Sep 2019 11:07:26 +0300
Message-Id: <20190908080726.30017-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

length is a size_t which is unsigned int on 32 bit:

../drivers/infiniband/core/umem_odp.c: In function 'ib_init_umem_odp':
../include/linux/overflow.h:59:15: warning: comparison of distinct pointer types lacks a cast
   59 |  (void) (&__a == &__b);   \
      |               ^~
../drivers/infiniband/core/umem_odp.c:220:7: note: in expansion of macro 'check_add_overflow'

Fixes: 204e3e5630c5 ("RDMA/odp: Check for overflow when computing the umem_odp end")
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/umem_odp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 32fb0b579dec..bd01c77aeef0 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -293,7 +293,7 @@ static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
 		umem_odp->interval_tree.start =
 			ALIGN_DOWN(umem_odp->umem.address, page_size);
 		if (check_add_overflow(umem_odp->umem.address,
-				       umem_odp->umem.length,
+				       (unsigned long)umem_odp->umem.length,
 				       &umem_odp->interval_tree.last))
 			return -EOVERFLOW;
 		umem_odp->interval_tree.last =
-- 
2.20.1

