Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3989E128DF6
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Dec 2019 13:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfLVMrE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 Dec 2019 07:47:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:36968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfLVMrE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 22 Dec 2019 07:47:04 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63137206D3;
        Sun, 22 Dec 2019 12:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577018824;
        bh=IMCjFz54XgbjOgF4MZwha0eYtFH2RArnXMFufZd2UYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K0BptXO5kNdhT0G8NhuBvZjGw7tARGodLk4LFp8A/rX6Wa0BxZ+nG9iVV0IVESO1z
         5zHJ2U1P65YCDVOujFV1fiW3OnRJyoFvVsC+UmsTOMP4VXr+O/5eLG917lqsbxCmE0
         L7sFCo2itS+PzelIff5jq3kmSVlsjPa7QvyxUYFQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-rc v1 3/3] IB/core: Fix ODP with IB_ACCESS_HUGETLB handling
Date:   Sun, 22 Dec 2019 14:46:49 +0200
Message-Id: <20191222124649.52300-4-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191222124649.52300-1-leon@kernel.org>
References: <20191222124649.52300-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@mellanox.com>

As VMAs for a given range might not be available as part of the
registration phase in ODP.

ib_init_umem_odp() considered the expected page shift value that was
previously set and initializes its internals accordingly.

If memory doesn't backed by physical contiguous pages aligned to
hugepage boundary an error will be set as part of the page fault flow
once be detected.

Fixes: 0008b84ea9af ("IB/umem: Add support to huge ODP")
Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/umem_odp.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 2e9ee7adab13..f42fa31c24a2 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -241,22 +241,10 @@ struct ib_umem_odp *ib_umem_odp_get(struct ib_udata *udata, unsigned long addr,
 	umem_odp->umem.owning_mm = mm = current->mm;
 	umem_odp->notifier.ops = ops;
 
-	umem_odp->page_shift = PAGE_SHIFT;
-	if (access & IB_ACCESS_HUGETLB) {
-		struct vm_area_struct *vma;
-		struct hstate *h;
-
-		down_read(&mm->mmap_sem);
-		vma = find_vma(mm, ib_umem_start(umem_odp));
-		if (!vma || !is_vm_hugetlb_page(vma)) {
-			up_read(&mm->mmap_sem);
-			ret = -EINVAL;
-			goto err_free;
-		}
-		h = hstate_vma(vma);
-		umem_odp->page_shift = huge_page_shift(h);
-		up_read(&mm->mmap_sem);
-	}
+	if (access & IB_ACCESS_HUGETLB)
+		umem_odp->page_shift = HPAGE_SHIFT;
+	else
+		umem_odp->page_shift = PAGE_SHIFT;
 
 	umem_odp->tgid = get_task_pid(current->group_leader, PIDTYPE_PID);
 	ret = ib_init_umem_odp(umem_odp, ops);
@@ -266,7 +254,6 @@ struct ib_umem_odp *ib_umem_odp_get(struct ib_udata *udata, unsigned long addr,
 
 err_put_pid:
 	put_pid(umem_odp->tgid);
-err_free:
 	kfree(umem_odp);
 	return ERR_PTR(ret);
 }
-- 
2.20.1

