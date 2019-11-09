Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05EA6F5CDF
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Nov 2019 03:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfKICEh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Nov 2019 21:04:37 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11858 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfKICEg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Nov 2019 21:04:36 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dc61e7b0000>; Fri, 08 Nov 2019 18:03:39 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 08 Nov 2019 18:04:36 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 08 Nov 2019 18:04:36 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 9 Nov
 2019 02:04:35 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 9 Nov 2019 02:04:35 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dc61eb30001>; Fri, 08 Nov 2019 18:04:35 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     Ira Weiny <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 1/1] IB/umem: use get_user_pages_fast() to pin DMA pages
Date:   Fri, 8 Nov 2019 18:04:34 -0800
Message-ID: <20191109020434.389855-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191109020434.389855-1-jhubbard@nvidia.com>
References: <20191109020434.389855-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1573265019; bh=OfPuBk6olU3MoNwmZys6CkrWe8KKo43aWZvKoB9Ueds=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=Yal3sUdhjhXJKGI9v/QcstThY1ZGZNuomrRuspmHPsnPrzCP6ZiXUjXzKJ1culPY8
         gFO5jRAbwoLsuP4HhjQanYzZavjZkxxzy8LILug7sgqhmU0Fi1GKCFbeQ06ok5hfj/
         rsjEhXP6xYVhq1VD9ygdSXRBhaO1HkhbrEa7jL7CqR9jR5Rm8AsxDna/zGkjkUk+8i
         bu3KkFfgo95HuJAPbRt3+WmE/74NNPIyB9b4S+25VqC2BO1jFYb/HGwXeTzpgWyqSK
         cnfYpV91jXkvObcof+MjHbiS9E9by2SyPkTnQKG92p5fh2bz1JyoQ7Vfpgq0JTIm0x
         cmnGFlXFX12bQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

And get rid of the mmap_sem calls, as part of that. Note
that get_user_pages_fast() will, if necessary, fall back to
__gup_longterm_unlocked(), which takes the mmap_sem as needed.

Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/infiniband/core/umem.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.=
c
index 24244a2f68cc..3d664a2539eb 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -271,16 +271,13 @@ struct ib_umem *ib_umem_get(struct ib_udata *udata, u=
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
@@ -288,8 +285,6 @@ struct ib_umem *ib_umem_get(struct ib_udata *udata, uns=
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

