Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9030611371E
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2019 22:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfLDVgI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Dec 2019 16:36:08 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:3149 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbfLDVgG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Dec 2019 16:36:06 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5de826c00000>; Wed, 04 Dec 2019 13:36:00 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 04 Dec 2019 13:36:04 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 04 Dec 2019 13:36:04 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Dec
 2019 21:36:04 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 4 Dec 2019 21:36:04 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5de826c40002>; Wed, 04 Dec 2019 13:36:04 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
CC:     Ira Weiny <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 0/2] IB/umem: use get_user_pages_fast() to pin DMA pages
Date:   Wed, 4 Dec 2019 13:36:01 -0800
Message-ID: <20191204213603.464373-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575495361; bh=Nnc1MC2/LMUzNv7k8FsJhkVnIIlePIHcyFpDrOinfto=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=OwenzducFKmfsuvf5HLZY+As5/XTqa/6XBIa+n8pLfv5mttxQ+V1yvNFPbiA/qx93
         WBxiaXr8MsNomOAVZYqsTI9HRKZ+8M6QG+rBEoz+RELZcCsfn/WWIFWThWj7kYk9M1
         Vr9H/49oqEcTUc2rEIObV2Ko/E1DQVtnTyUQTUEGrL0yI6jDp7uk9M/um8y2viyxt0
         VOmWWnZahe9xzuyx4rAcJTUrZYjdDtOw4+EADjFH3EQ3tVuqF9r8ZUHbmL4pH2d9ti
         +ymLDMHGiiK+hRkVVqEZLlyWItKUPf52CZbMGZKSW1hLVajRKs3dIW+1CJCXvUU9qu
         shKiLnXHQ8F2A==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

The reason I'm posting this is to request a review for patch 1. Once
everything seems OK, these two patches are going to be part of a larger
set (again, destined for linux-mm) that introduces FOLL_PIN and renames
some get_user_pages() cases to pin_user_pages(). I'm doing this a little
before -rc1, because it's a small and easy thing to get out of the way
early.

These are ultimately destined to go in via linux-mm (as opposed to
linux-rdma), in order to change some names in just one kernel release
cycle.

The first version of this patchset only had the IB/umem changes
(patch 2), and I also lacked a runtime Infiniband test, so
Leon Romanovsky reported a failure [1]. Patch 1 fixes that failure.

Since v1, I have (finally!) set up a basic two-node Infiniband system,
and as a result, I've reproduced the failure that Leon saw, via a
trivial run of "ib_write_bw", and confirmed that it's fixed in this
new patchset. Sorry it took me so long to do that; I am going to vaguely
blame "OFED" for the delay. :)

Entertaining IB side note: Jason: sure enough, as you mentioned, the
OFED installation did in fact hopelessly mangle my system. Once I went
back to a clean distro installation without all those OFED goodies,
everything Just Worked on the first try. Much simpler to understand,
too. ha.

This applies to today's linux.git: commit aedc0650f913 ("Merge tag
'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm").

[1] https://lore.kernel.org/r/20191124100724.GH136476@unreal

John Hubbard (2):
  mm/gup: allow FOLL_FORCE for get_user_pages_fast()
  IB/umem: use get_user_pages_fast() to pin DMA pages

 drivers/infiniband/core/umem.c | 17 ++++++-----------
 mm/gup.c                       |  3 ++-
 2 files changed, 8 insertions(+), 12 deletions(-)

--=20
2.24.0

