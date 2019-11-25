Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 642B31085FC
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Nov 2019 01:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfKYAhT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 24 Nov 2019 19:37:19 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:1272 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbfKYAhS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 24 Nov 2019 19:37:18 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ddb22390000>; Sun, 24 Nov 2019 16:37:13 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 24 Nov 2019 16:37:18 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 24 Nov 2019 16:37:18 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 25 Nov
 2019 00:37:18 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 25 Nov 2019 00:37:17 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ddb223c0001>; Sun, 24 Nov 2019 16:37:17 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
CC:     Ira Weiny <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/2] mm/gup: allow FOLL_FORCE for get_user_pages_fast()
Date:   Sun, 24 Nov 2019 16:37:14 -0800
Message-ID: <20191125003715.516290-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191125003715.516290-1-jhubbard@nvidia.com>
References: <20191125003715.516290-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574642233; bh=c0hsBmTWs/DCh8sZSVD4lwxTW7w8qPOlfijarw+0SPw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=C3XjKp+5tEXTpqvGSjUMb07BVXy5aZjWWk0sCbXYiRd3TsYjCDgr05K9dhv/+O9Zq
         afYSEwsQ0Xv0D+31UV54scwr4bJqxdMo7vk5xOh7/LPc4WFHaVVfySl4xw8l5DGV/q
         u0RaI0dQG2fbnCFI+sGoSdd7setc9e6bakHa+m7m6M6OxMwYozMSktUTgPj34qVlH3
         xKIaACLaXMAq4onwufOGumPaLfIBi9xW8nhuQA9u9zar9YWUkaY4ij5WDXPvriEISm
         JEQUgFLKijANSqiNAiPUmsbuTk0Bymthb5qmdNyt+nqQqS6sSaVh0nWhQDyB8I8KVz
         SE1vJuymnJWLQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Commit 817be129e6f2 ("mm: validate get_user_pages_fast flags") allowed
only FOLL_WRITE and FOLL_LONGTERM to be passed to get_user_pages_fast().
This, combined with the fact that get_user_pages_fast() falls back to
"slow gup", which *does* accept FOLL_FORCE, leads to an odd situation:
if you need FOLL_FORCE, you cannot call get_user_pages_fast().

There does not appear to be any reason for filtering out FOLL_FORCE.
There is nothing in the _fast() implementation that requires that we
avoid writing to the pages. So it appears to have been an oversight.

Fix by allowing FOLL_FORCE to be set for get_user_pages_fast().

Fixes: 817be129e6f2 ("mm: validate get_user_pages_fast flags")
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/gup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index 8f236a335ae9..745b4036cdfd 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2401,7 +2401,8 @@ int get_user_pages_fast(unsigned long start, int nr_p=
ages,
 	unsigned long addr, len, end;
 	int nr =3D 0, ret =3D 0;
=20
-	if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM)))
+	if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM |
+				       FOLL_FORCE)))
 		return -EINVAL;
=20
 	start =3D untagged_addr(start) & PAGE_MASK;
--=20
2.24.0

