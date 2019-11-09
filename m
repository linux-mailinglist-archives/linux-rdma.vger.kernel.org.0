Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF73F5CE2
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Nov 2019 03:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfKICEk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Nov 2019 21:04:40 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16412 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfKICEj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Nov 2019 21:04:39 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dc61e7a0002>; Fri, 08 Nov 2019 18:03:38 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 08 Nov 2019 18:04:39 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 08 Nov 2019 18:04:39 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 9 Nov
 2019 02:04:35 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 9 Nov 2019 02:04:35 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dc61eb30000>; Fri, 08 Nov 2019 18:04:35 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     Ira Weiny <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 0/1] IB/umem: use get_user_pages_fast() to pin DMA pages
Date:   Fri, 8 Nov 2019 18:04:33 -0800
Message-ID: <20191109020434.389855-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1573265018; bh=OqJk4HwxLFuiZxdO7FdtWiG3lR2+WoDbxn35lzBPFEw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=YOCyGKxWMrdneUTApO1JO0AD8WOGde1bL/i2yAwWv9uB/2L10471+O5wB9x8Z0fw/
         TpmNgOUBtwduig9BYJ5LfK9tDpHgLYbDqeegbLVsY4krqNGwM7Q4uvSibNlFQdzjQ/
         CZ6bRrmWwfOzM3KDmnDSpJm74cIlI7Nm89IaJa8SnX46RBO0WvJ9dlG0squYSR4AGT
         Fb4HYE4t/Y+1VfG8lpweNGrsEL2MvOnQ/oHyThXUXDsj+qGbS48d21+vj55/jo+Os8
         pAc5nVyWGSsQT8FiD75YWNFQvVRFdiDwFZoHaFYiIE9lHwIvmu8QXlWwvsfL4ixkj9
         LqCoDBxhGIvCw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason, Andrew,

Jason: Here is the change to get_user_pages_fast(), that you requested
during the review of "mm/gup: track dma-pinned pages: FOLL_PIN,
FOLL_LONGTERM" [1].

This is a stand-alone patch that applies to today's 5.4.0-rc6 linux.git.

If anyone could please provide any run-time testing (and of course,
Reviewed-by's), that would be huge. I've compiled and run it, but
bpftrace tells me (as I already knew) that my current anemic IB setup
is not actually exercising this code path.

Andrew: unless instructed otherwise, I plan to also re-post this as part
of the next (v3) version of [1], and hopefully have the whole series go
through your tree. That would avoid merge conflicts, and as I understand
it, there is no particular urgency for this patch, so we might as well
do it the easy way.


John Hubbard (1):
  IB/umem: use get_user_pages_fast() to pin DMA pages

 drivers/infiniband/core/umem.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

--=20
2.24.0

