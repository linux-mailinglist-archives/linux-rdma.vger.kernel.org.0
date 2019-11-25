Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1BC71085FD
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Nov 2019 01:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfKYAhY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 24 Nov 2019 19:37:24 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11570 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbfKYAhX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 24 Nov 2019 19:37:23 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ddb22460001>; Sun, 24 Nov 2019 16:37:26 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 24 Nov 2019 16:37:23 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 24 Nov 2019 16:37:23 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 25 Nov
 2019 00:37:18 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 25 Nov 2019 00:37:18 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ddb223d0000>; Sun, 24 Nov 2019 16:37:17 -0800
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
Subject: [PATCH 2/2] IB/umem: use get_user_pages_fast() to pin DMA pages
Date:   Sun, 24 Nov 2019 16:37:15 -0800
Message-ID: <20191125003715.516290-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191125003715.516290-1-jhubbard@nvidia.com>
References: <20191125003715.516290-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574642246; bh=Xm1W60RRjaqCw/WDtR4CeZEieNi50IPMMXG+SsZWaD0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=QnuK8T09DZm9oGk8aNwnChqISSD87+GLkQ5vgYHhKquLbwD+UnBWhZryr723Im/ol
         zTBlI4+3mAO1p7atiiyhuuC8On5JFff4m70gKh1K1RjhU58ORNb6Hx20Jaxt341eYx
         9B1wGP0bgqL1G1BeIkLF4oLKzIWMgF9FD1CnsJW3SZxksSRw0JsGhFfgwurTHdK6Qf
         aIXa9k+heaIrI5HXF9AGfrSEaIxk8LY2RH/LI9Przyl7dFcIWjNAJioMQJwLVpZrYV
         VfV1vRLW6uQJ9RoQkETvft8BjQ4m42sCnD5TdZUPXSmc7Me/69b/H8Fwst6dRluYB+
         zhKQHij6ivh3A==
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

