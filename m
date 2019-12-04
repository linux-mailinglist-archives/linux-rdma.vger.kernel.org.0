Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE2B11371C
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2019 22:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfLDVgG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Dec 2019 16:36:06 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:3151 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbfLDVgF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Dec 2019 16:36:05 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5de826c10000>; Wed, 04 Dec 2019 13:36:01 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 04 Dec 2019 13:36:05 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 04 Dec 2019 13:36:05 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Dec
 2019 21:36:04 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 4 Dec 2019 21:36:04 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5de826c40003>; Wed, 04 Dec 2019 13:36:04 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
CC:     Ira Weiny <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 1/2] mm/gup: allow FOLL_FORCE for get_user_pages_fast()
Date:   Wed, 4 Dec 2019 13:36:02 -0800
Message-ID: <20191204213603.464373-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204213603.464373-1-jhubbard@nvidia.com>
References: <20191204213603.464373-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575495361; bh=D5FKf6o88yrnam68mO83xEuXphYTA3McnnbS0GFu5aA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=eCFl7oV6N1zFHWhmaXu9MCkZmrub7KXbOYWLH/D/jUkygF0DtjswPT2qe+aARAZFH
         jalNYGfDUmDPJZcLuaNkfZQs5g8cxMa8gn/wgOSGkjteGuJH6rxi6NZuRw1Vlaqb2E
         7uzMo7yCYyx1ZuotG2ThIsFANYlKuS2hdorpsuhz/r8JOAo/QWLOsWH+ytGPxUtk/8
         Ge1jG58RtT9eRllOlBhF4qIJXXoZlK8xvAZ47WoMzWeGx9KoUM3NYZ65MgiySrtka4
         w41lEaiz0oliyAhaKRxPeLlCM2bWfLxMhWhwnoW+cxAjJU3TqbQlXWqq9wKural0c/
         P45ahLYmbnzlA==
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
index 7646bf993b25..5244b8090440 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2415,7 +2415,8 @@ int get_user_pages_fast(unsigned long start, int nr_p=
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

