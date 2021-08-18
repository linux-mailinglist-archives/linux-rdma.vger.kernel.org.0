Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300D23EFF34
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Aug 2021 10:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238345AbhHRIfD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Aug 2021 04:35:03 -0400
Received: from esa2.hc1455-7.c3s2.iphmx.com ([207.54.90.48]:57945 "EHLO
        esa2.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238324AbhHRIfB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Aug 2021 04:35:01 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Aug 2021 04:35:01 EDT
IronPort-SDR: eZOYNhwR0QcwmckGAcHN1S7jtL4dKW61EFLfHs6Cz/Adw12ea2cO9bp8tuhDzyx03zjLDPnI0Y
 5r7vFsdHR/Kig7nkqWgj3lAipTkqobTGBUv5WMDF3a2D/ErklBaWFFu5nBU5LL4b/uAKzqKKOZ
 TPTnHWjeZYZQiZYJt/aPqoJXWY0it9wWIK3y9XsV6tQ0SRGNeEgxfYJxmv/kpesX4f6EQDSl7e
 B2rRmk+VqJYWSe6qoxzDFurE5OXIkPEYq62ihctuqxl3xQ7n0PT3a8kZsqoqX5fZVx2NyVzz55
 pTp763m4mGriyN39giynBY+u
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="40636994"
X-IronPort-AV: E=Sophos;i="5.84,330,1620658800"; 
   d="scan'208";a="40636994"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP; 18 Aug 2021 17:27:15 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 42FFC6CCA0
        for <linux-rdma@vger.kernel.org>; Wed, 18 Aug 2021 17:27:14 +0900 (JST)
Received: from m3050.s.css.fujitsu.com (msm.b.css.fujitsu.com [10.134.21.208])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 98EB83918B
        for <linux-rdma@vger.kernel.org>; Wed, 18 Aug 2021 17:27:13 +0900 (JST)
Received: from jegan.fujitsu.com (unknown [10.124.72.187])
        by m3050.s.css.fujitsu.com (Postfix) with ESMTP id 74CA3A7;
        Wed, 18 Aug 2021 17:27:13 +0900 (JST)
From:   Yasunori Goto <y-goto@fujitsu.com>
To:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     y-goto@fujitsu.com
Subject: [PATCH] RDMA/core: EPERM should be returned when # of pined pages is over ulimit
Date:   Wed, 18 Aug 2021 17:27:02 +0900
Message-Id: <20210818082702.692117-1-y-goto@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

When I started to use SoftRoCE, I'm very confused by
ENOMEM error output even if I gave enough memory.

I think EPERM is more suitable for uses to solve error rather than
ENOMEM at here of ib_umem_get() when # of pinned pages is over ulimit.
This is not "memory is not enough" problem, because driver can
succeed to pin enough amount of pages, but it is larger than ulimit value.

The hard limit of "max locked memory" can be changed by limit.conf.
In addition, this checks also CAP_IPC_LOCK, it is indeed permmission check.
So, I think the following patch.

If there is a intention why ENOMEM is used here, please let me know.
Otherwise, I'm glad if this is merged.

Thanks.


---
When # of pinned pages are larger than ulimit of "max locked memory"
without CAP_IPC_LOCK, current ib_umem_get() returns ENOMEM.
But it does not mean "not enough memory", because driver could succeed to
pinned enough pages.
This is just capability error. Even if a normal user is limited
his/her # of pinned pages, system administrator can give permission
by change hard limit of this ulimit value.
To notify correct information to user, ib_umem_get()
should return EPERM instead of ENOMEM at here.

Signed-off-by: Yasunori Goto <y-goto@fujitsu.com>
---
 drivers/infiniband/core/umem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 0eb40025075f..9771134649e9 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -205,7 +205,7 @@ struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
 	new_pinned = atomic64_add_return(npages, &mm->pinned_vm);
 	if (new_pinned > lock_limit && !capable(CAP_IPC_LOCK)) {
 		atomic64_sub(npages, &mm->pinned_vm);
-		ret = -ENOMEM;
+		ret = -EPERM;
 		goto out;
 	}
 
-- 
2.31.1

