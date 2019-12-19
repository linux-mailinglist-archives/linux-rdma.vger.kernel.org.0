Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB3DE1263E4
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2019 14:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfLSNq6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Dec 2019 08:46:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:42498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbfLSNq6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Dec 2019 08:46:58 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E77AF2146E;
        Thu, 19 Dec 2019 13:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576763217;
        bh=VsLfTUku33zvot5WYdZcbWRLK6vVEOoRivEr+ORl5z8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OrwxMG5muJIV8GXT4TU3Yc+1VhoszsXk0ySvDTAyT4xGwgsVzaDelFOKh29RHS3Sy
         okeRlBTy6HxsToqZibRYVJuI9Bh5Zhl/LDb+RdRkHzNZp0UO2/0Zr37168XFwutHCa
         RHl7gMDIDgmsDKG/3yM+JaKMwjaOGzvyoyk6M6Qs=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Aviad Yehezkel <aviadye@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-rc 3/3] IB/core: Fix ODP with IB_ACCESS_HUGETLB handling
Date:   Thu, 19 Dec 2019 15:46:46 +0200
Message-Id: <20191219134646.413164-4-leon@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191219134646.413164-1-leon@kernel.org>
References: <20191219134646.413164-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@mellanox.com>

As VMAs for a given range might not be available as part of the
registration phase in ODP, IB_ACCESS_HUGETLB/page_shift must be checked
as part of the page fault flow.

If the application didn't mmap the backed memory with huge pages or
released part of that hugepage area, an error will be set as part of the
page fault flow once be detected.

Fixes: 0008b84ea9af ("IB/umem: Add support to huge ODP")
Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
Reviewed-by: Aviad Yehezkel <aviadye@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/umem_odp.c | 37 +++++++++++++++---------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 2e9ee7adab13..533271897908 100644
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
@@ -403,6 +390,7 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 user_virt,
 	int j, k, ret = 0, start_idx, npages = 0;
 	unsigned int flags = 0, page_shift;
 	phys_addr_t p = 0;
+	struct vm_area_struct **vmas;
 
 	if (access_mask == 0)
 		return -EINVAL;
@@ -415,6 +403,12 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 user_virt,
 	if (!local_page_list)
 		return -ENOMEM;
 
+	vmas = (struct vm_area_struct **)__get_free_page(GFP_KERNEL);
+	if (!vmas) {
+		ret = -ENOMEM;
+		goto out_free_page_list;
+	}
+
 	page_shift = umem_odp->page_shift;
 	page_mask = ~(BIT(page_shift) - 1);
 	off = user_virt & (~page_mask);
@@ -453,7 +447,7 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 user_virt,
 		 */
 		npages = get_user_pages_remote(owning_process, owning_mm,
 				user_virt, gup_num_pages,
-				flags, local_page_list, NULL, NULL);
+				flags, local_page_list, vmas, NULL);
 		up_read(&owning_mm->mmap_sem);
 
 		if (npages < 0) {
@@ -477,6 +471,11 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 user_virt,
 				continue;
 			}
 
+			if ((1 << page_shift) > vma_kernel_pagesize(vmas[j])) {
+				ret = -EFAULT;
+				break;
+			}
+
 			ret = ib_umem_odp_map_dma_single_page(
 					umem_odp, k, local_page_list[j],
 					access_mask, current_seq);
@@ -517,6 +516,8 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 user_virt,
 out_put_task:
 	if (owning_process)
 		put_task_struct(owning_process);
+	free_page((unsigned long)vmas);
+out_free_page_list:
 	free_page((unsigned long)local_page_list);
 	return ret;
 }
-- 
2.20.1

