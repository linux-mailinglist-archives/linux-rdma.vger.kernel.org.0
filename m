Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 799A3113720
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2019 22:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbfLDVgM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Dec 2019 16:36:12 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:3166 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbfLDVgI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Dec 2019 16:36:08 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5de826c30000>; Wed, 04 Dec 2019 13:36:03 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 04 Dec 2019 13:36:07 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 04 Dec 2019 13:36:07 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Dec
 2019 21:36:04 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 4 Dec 2019 21:36:04 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5de826c40005>; Wed, 04 Dec 2019 13:36:04 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
CC:     Ira Weiny <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH v2 2/2] IB/umem: use get_user_pages_fast() to pin DMA pages
Date:   Wed, 4 Dec 2019 13:36:03 -0800
Message-ID: <20191204213603.464373-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204213603.464373-1-jhubbard@nvidia.com>
References: <20191204213603.464373-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575495363; bh=wK/7Zcr9JkY1oVaBb+a1odFvVDUbZPXG7o4esu8lpZI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=ptXEQ04xcPn8GdBQs2rp1XVY1OuF77GjHPSFFgY17UMuAVXRuuciVJqui9dCSv87B
         yCbOSxw7VjnSJQGnrVsT1Xq5Wqzv4+IqtS9m8ZPYl8LmZw6MkaTA5hLyDoM0xHXNPO
         Av16EWu/XC/kClF+whWx+5CFr/TIxNY7i2Se1qYu2a6jWWeRXdqPqg3uus4rEBVfaS
         i+8V/puwLz7IlHI2zyKxfZlWG0cjzbtmv0aDISe02uxsmQUApNlguxclaR436XBAyk
         7gYqtM6Sg/CovzDx0g3o8qQgztOvXDyXdmH1W1G4A4gb863I1mfGx+WrBqJHiFIclE
         Pb9Y3ZnPvGwUQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

And get rid of the mmap_sem calls, as part of that. Note
that get_user_pages_fast() will, if necessary, fall back to
__gup_longterm_unlocked(), which takes the mmap_sem as needed.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/infiniband/core/umem.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.=
c
index 7a3b99597ead..214e87aa609d 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -266,16 +266,13 @@ struct ib_umem *ib_umem_get(struct ib_udata *udata, u=
nsigned long addr,
 	sg =3D umem->sg_head.sgl;
=20
 	while (npages) {
-		down_read(&mm->mmap_sem);
-		ret =3D get_user_pages(cur_base,
-				     min_t(unsigned long, npages,
-					   PAGE_SIZE / sizeof (struct page *)),
-				     gup_flags | FOLL_LONGTERM,
-				     page_list, NULL);
-		if (ret < 0) {
-			up_read(&mm->mmap_sem);
+		ret =3D get_user_pages_fast(cur_base,
+					  min_t(unsigned long, npages,
+						PAGE_SIZE /
+						sizeof(struct page *)),
+					  gup_flags | FOLL_LONGTERM, page_list);
+		if (ret < 0)
 			goto umem_release;
-		}
=20
 		cur_base +=3D ret * PAGE_SIZE;
 		npages   -=3D ret;
@@ -283,8 +280,6 @@ struct ib_umem *ib_umem_get(struct ib_udata *udata, uns=
igned long addr,
 		sg =3D ib_umem_add_sg_table(sg, page_list, ret,
 			dma_get_max_seg_size(context->device->dma_device),
 			&umem->sg_nents);
-
-		up_read(&mm->mmap_sem);
 	}
=20
 	sg_mark_end(sg);
--=20
2.24.0

