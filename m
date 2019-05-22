Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5FC2695F
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2019 19:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbfEVRs4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 May 2019 13:48:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38036 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728450AbfEVRs4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 22 May 2019 13:48:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B9CB430C1AFB;
        Wed, 22 May 2019 17:48:55 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BFED5C296;
        Wed, 22 May 2019 17:48:54 +0000 (UTC)
Date:   Wed, 22 May 2019 13:48:52 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: Re: [PATCH v4 0/1] Use HMM for ODP v4
Message-ID: <20190522174852.GA23038@redhat.com>
References: <20190411181314.19465-1-jglisse@redhat.com>
 <20190506195657.GA30261@ziepe.ca>
 <20190521205321.GC3331@redhat.com>
 <20190522005225.GA30819@ziepe.ca>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190522005225.GA30819@ziepe.ca>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 22 May 2019 17:48:55 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, May 21, 2019 at 09:52:25PM -0300, Jason Gunthorpe wrote:
> On Tue, May 21, 2019 at 04:53:22PM -0400, Jerome Glisse wrote:
> > On Mon, May 06, 2019 at 04:56:57PM -0300, Jason Gunthorpe wrote:
> > > On Thu, Apr 11, 2019 at 02:13:13PM -0400, jglisse@redhat.com wrote:
> > > > From: Jérôme Glisse <jglisse@redhat.com>
> > > > 
> > > > Just fixed Kconfig and build when ODP was not enabled, other than that
> > > > this is the same as v3. Here is previous cover letter:
> > > > 
> > > > Git tree with all prerequisite:
> > > > https://cgit.freedesktop.org/~glisse/linux/log/?h=rdma-odp-hmm-v4
> > > > 
> > > > This patchset convert RDMA ODP to use HMM underneath this is motivated
> > > > by stronger code sharing for same feature (share virtual memory SVM or
> > > > Share Virtual Address SVA) and also stronger integration with mm code to
> > > > achieve that. It depends on HMM patchset posted for inclusion in 5.2 [2]
> > > > and [3].
> > > > 
> > > > It has been tested with pingpong test with -o and others flags to test
> > > > different size/features associated with ODP.
> > > > 
> > > > Moreover they are some features of HMM in the works like peer to peer
> > > > support, fast CPU page table snapshot, fast IOMMU mapping update ...
> > > > It will be easier for RDMA devices with ODP to leverage those if they
> > > > use HMM underneath.
> > > > 
> > > > Quick summary of what HMM is:
> > > >     HMM is a toolbox for device driver to implement software support for
> > > >     Share Virtual Memory (SVM). Not only it provides helpers to mirror a
> > > >     process address space on a device (hmm_mirror). It also provides
> > > >     helper to allow to use device memory to back regular valid virtual
> > > >     address of a process (any valid mmap that is not an mmap of a device
> > > >     or a DAX mapping). They are two kinds of device memory. Private memory
> > > >     that is not accessible to CPU because it does not have all the expected
> > > >     properties (this is for all PCIE devices) or public memory which can
> > > >     also be access by CPU without restriction (with OpenCAPI or CCIX or
> > > >     similar cache-coherent and atomic inter-connect).
> > > > 
> > > >     Device driver can use each of HMM tools separatly. You do not have to
> > > >     use all the tools it provides.
> > > > 
> > > > For RDMA device i do not expect a need to use the device memory support
> > > > of HMM. This device memory support is geared toward accelerator like GPU.
> > > > 
> > > > 
> > > > You can find a branch [1] with all the prerequisite in. This patch is on
> > > > top of rdma-next with the HMM patchset [2] and mmu notifier patchset [3]
> > > > applied on top of it.
> > > > 
> > > > [1] https://cgit.freedesktop.org/~glisse/linux/log/?h=rdma-odp-hmm-v4
> > > > [2] https://lkml.org/lkml/2019/4/3/1032
> > > > [3] https://lkml.org/lkml/2019/3/26/900
> > > 
> > > Jerome, please let me know if these dependent series are merged during
> > > the first week of the merge window.
> > > 
> > > This patch has been tested and could go along next week if the
> > > dependencies are met.
> > > 
> > 
> > So attached is a rebase on top of 5.2-rc1, i have tested with pingpong
> > (prefetch and not and different sizes). Seems to work ok.
> 
> Urk, it already doesn't apply to the rdma tree :(
> 
> The conflicts are a little more extensive than I'd prefer to handle..
> Can I ask you to rebase it on top of this branch please:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=wip/jgg-for-next
> 
> Specifically it conflicts with this patch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=wip/jgg-for-next&id=d2183c6f1958e6b6dfdde279f4cee04280710e34
> 
> > +long ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp,
> > +			       struct hmm_range *range)
> >  {
> > +	struct device *device = umem_odp->umem.context->device->dma_device;
> > +	struct ib_ucontext_per_mm *per_mm = umem_odp->per_mm;
> >  	struct ib_umem *umem = &umem_odp->umem;
> > -	struct task_struct *owning_process  = NULL;
> > -	struct mm_struct *owning_mm = umem_odp->umem.owning_mm;
> > -	struct page       **local_page_list = NULL;
> > -	u64 page_mask, off;
> > -	int j, k, ret = 0, start_idx, npages = 0, page_shift;
> > -	unsigned int flags = 0;
> > -	phys_addr_t p = 0;
> > -
> > -	if (access_mask == 0)
> > +	struct mm_struct *mm = per_mm->mm;
> > +	unsigned long idx, npages;
> > +	long ret;
> > +
> > +	if (mm == NULL)
> > +		return -ENOENT;
> > +
> > +	/* Only drivers with invalidate support can use this function. */
> > +	if (!umem->context->invalidate_range)
> >  		return -EINVAL;
> >  
> > -	if (user_virt < ib_umem_start(umem) ||
> > -	    user_virt + bcnt > ib_umem_end(umem))
> > -		return -EFAULT;
> > +	/* Sanity checks. */
> > +	if (range->default_flags == 0)
> > +		return -EINVAL;
> >  
> > -	local_page_list = (struct page **)__get_free_page(GFP_KERNEL);
> > -	if (!local_page_list)
> > -		return -ENOMEM;
> > +	if (range->start < ib_umem_start(umem) ||
> > +	    range->end > ib_umem_end(umem))
> > +		return -EINVAL;
> >  
> > -	page_shift = umem->page_shift;
> > -	page_mask = ~(BIT(page_shift) - 1);
> > -	off = user_virt & (~page_mask);
> > -	user_virt = user_virt & page_mask;
> > -	bcnt += off; /* Charge for the first page offset as well. */
> > +	idx = (range->start - ib_umem_start(umem)) >> umem->page_shift;
> 
> Is this math OK? What is supposed to happen if the range->start is not
> page aligned to the internal page size?

range->start is align on 1 << page_shift boundary within pagefault_mr
thus the above math is ok. We can add a BUG_ON() and comments if you
want.

> 
> > +	range->pfns = &umem_odp->pfns[idx];
> > +	range->pfn_shift = ODP_FLAGS_BITS;
> > +	range->values = odp_hmm_values;
> > +	range->flags = odp_hmm_flags;
> >  
> >  	/*
> > -	 * owning_process is allowed to be NULL, this means somehow the mm is
> > -	 * existing beyond the lifetime of the originating process.. Presumably
> > -	 * mmget_not_zero will fail in this case.
> > +	 * If mm is dying just bail out early without trying to take mmap_sem.
> > +	 * Note that this might race with mm destruction but that is fine the
> > +	 * is properly refcounted so are all HMM structure.
> >  	 */
> > -	owning_process = get_pid_task(umem_odp->per_mm->tgid, PIDTYPE_PID);
> > -	if (!owning_process || !mmget_not_zero(owning_mm)) {
> 
> But we are not in a HMM context here, and per_mm is not a HMM
> structure. 
> 
> So why is mm suddenly guarenteed valid? It was a bug report that
> triggered the race the mmget_not_zero is fixing, so I need a better
> explanation why it is now safe. From what I see the hmm_range_fault
> is doing stuff like find_vma without an active mmget??

So the mm struct can not go away as long as we hold a reference on
the hmm struct and we hold a reference on it through both hmm_mirror
and hmm_range struct. So struct mm can not go away and thus it is
safe to try to take its mmap_sem.

Now if we race with a destruction (ie all process that referenced the
mm struct are dead/dying) hmm struct will be marked as dead this is
tested by hmm_mirror_mm_is_alive() and also by hmm_range_snapshot()
(which is call by hmm_range_dma_map()). In other word if mm->mm_users
is zero then hmm will be mark as dead.

Hence it is safe to take mmap_sem and it is safe to call in hmm, if
mm have been kill it will return EFAULT and this will propagate to
RDMA.

As per_mm i removed the per_mm->mm = NULL from release so that it is
always safe to use that field even in face of racing mm "killing".



> 
> > @@ -603,11 +603,29 @@ static int pagefault_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr,
> >  
> >  next_mr:
> >  	size = min_t(size_t, bcnt, ib_umem_end(&odp->umem) - io_virt);
> > -
> >  	page_shift = mr->umem->page_shift;
> >  	page_mask = ~(BIT(page_shift) - 1);
> > +	/*
> > +	 * We need to align io_virt on page size so off is the extra bytes we
> > +	 * will be faulting and fault_size is the page aligned size we are
> > +	 * faulting.
> > +	 */
> > +	io_virt = io_virt & page_mask;
> > +	off = (io_virt & (~page_mask));
> > +	fault_size = ALIGN(size + off, 1UL << page_shift);
> > +
> > +	if (io_virt < ib_umem_start(&odp->umem))
> > +		return -EINVAL;
> > +
> >  	start_idx = (io_virt - (mr->mmkey.iova & page_mask)) >> page_shift;
> > -	access_mask = ODP_READ_ALLOWED_BIT;
> > +
> > +	if (odp_mr->per_mm == NULL || odp_mr->per_mm->mm == NULL)
> > +		return -ENOENT;
> 
> How can this happen? Where is the locking?
> 
> per_mm is supposed to outlive any odp_mr's the refer to it, and the mm
> is supposed to remain grab'd as long as the per_mm exists..

This can not happen removed the test.

> 
> > diff --git a/include/rdma/ib_umem_odp.h b/include/rdma/ib_umem_odp.h
> > index eeec4e53c448..70b2df8e5a6c 100644
> > +++ b/include/rdma/ib_umem_odp.h
> > @@ -36,6 +36,7 @@
> >  #include <rdma/ib_umem.h>
> >  #include <rdma/ib_verbs.h>
> >  #include <linux/interval_tree.h>
> > +#include <linux/hmm.h>
> >  
> >  struct umem_odp_node {
> >  	u64 __subtree_last;
> > @@ -47,11 +48,11 @@ struct ib_umem_odp {
> >  	struct ib_ucontext_per_mm *per_mm;
> >  
> >  	/*
> > -	 * An array of the pages included in the on-demand paging umem.
> > -	 * Indices of pages that are currently not mapped into the device will
> > -	 * contain NULL.
> > +	 * An array of the pages included in the on-demand paging umem. Indices
> > +	 * of pages that are currently not mapped into the device will contain
> > +	 * 0.
> >  	 */
> > -	struct page		**page_list;
> > +	uint64_t *pfns;
> 
> Are these actually pfns, or are they mangled with some shift? (what is range->pfn_shift?)

They are not pfns they have flags (hence range->pfn_shift) at the
bottoms i just do not have a better name for this.

Cheers,
Jérôme

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="0001-RDMA-odp-convert-to-use-HMM-for-ODP-v5.patch"
Content-Transfer-Encoding: 8bit

From 0b429b2ffbec348e283693cb97d7ffce760d89da Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>
Date: Sat, 8 Dec 2018 15:47:55 -0500
Subject: [PATCH] RDMA/odp: convert to use HMM for ODP v5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert ODP to use HMM so that we can build on common infrastructure
for different class of devices that want to mirror a process address
space into a device. There is no functional changes.

Changes since v4:
    - Rebase on top of rdma-next
Changes since v3:
    - Rebase on top of 5.2-rc1
Changes since v2:
    - Update to match changes to HMM API
Changes since v1:
    - improved comments
    - simplified page alignment computation

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Leon Romanovsky <leonro@mellanox.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Artemy Kovalyov <artemyko@mellanox.com>
Cc: Moni Shoua <monis@mellanox.com>
Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc: Kaike Wan <kaike.wan@intel.com>
Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/core/umem_odp.c | 506 +++++++++--------------------
 drivers/infiniband/hw/mlx5/mem.c   |  20 +-
 drivers/infiniband/hw/mlx5/mr.c    |   2 +-
 drivers/infiniband/hw/mlx5/odp.c   | 104 +++---
 include/rdma/ib_umem_odp.h         |  47 +--
 5 files changed, 233 insertions(+), 446 deletions(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index c3b3c523401f..7aca59ac8551 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -46,6 +46,20 @@
 #include <rdma/ib_umem.h>
 #include <rdma/ib_umem_odp.h>
 
+
+static uint64_t odp_hmm_flags[HMM_PFN_FLAG_MAX] = {
+	ODP_READ_BIT,	/* HMM_PFN_VALID */
+	ODP_WRITE_BIT,	/* HMM_PFN_WRITE */
+	ODP_DEVICE_BIT,	/* HMM_PFN_DEVICE_PRIVATE */
+};
+
+static uint64_t odp_hmm_values[HMM_PFN_VALUE_MAX] = {
+	-1UL,	/* HMM_PFN_ERROR */
+	0UL,	/* HMM_PFN_NONE */
+	-2UL,	/* HMM_PFN_SPECIAL */
+};
+
+
 /*
  * The ib_umem list keeps track of memory regions for which the HW
  * device request to receive notification when the related memory
@@ -78,55 +92,24 @@ static u64 node_last(struct umem_odp_node *n)
 INTERVAL_TREE_DEFINE(struct umem_odp_node, rb, u64, __subtree_last,
 		     node_start, node_last, static, rbt_ib_umem)
 
-static void ib_umem_notifier_start_account(struct ib_umem_odp *umem_odp)
-{
-	mutex_lock(&umem_odp->umem_mutex);
-	if (umem_odp->notifiers_count++ == 0)
-		/*
-		 * Initialize the completion object for waiting on
-		 * notifiers. Since notifier_count is zero, no one should be
-		 * waiting right now.
-		 */
-		reinit_completion(&umem_odp->notifier_completion);
-	mutex_unlock(&umem_odp->umem_mutex);
-}
-
-static void ib_umem_notifier_end_account(struct ib_umem_odp *umem_odp)
-{
-	mutex_lock(&umem_odp->umem_mutex);
-	/*
-	 * This sequence increase will notify the QP page fault that the page
-	 * that is going to be mapped in the spte could have been freed.
-	 */
-	++umem_odp->notifiers_seq;
-	if (--umem_odp->notifiers_count == 0)
-		complete_all(&umem_odp->notifier_completion);
-	mutex_unlock(&umem_odp->umem_mutex);
-}
-
 static int ib_umem_notifier_release_trampoline(struct ib_umem_odp *umem_odp,
 					       u64 start, u64 end, void *cookie)
 {
-	/*
-	 * Increase the number of notifiers running, to
-	 * prevent any further fault handling on this MR.
-	 */
-	ib_umem_notifier_start_account(umem_odp);
 	umem_odp->dying = 1;
 	/* Make sure that the fact the umem is dying is out before we release
 	 * all pending page faults. */
 	smp_wmb();
-	complete_all(&umem_odp->notifier_completion);
-	umem_odp->umem.context->invalidate_range(
-		umem_odp, ib_umem_start(umem_odp), ib_umem_end(umem_odp));
+	umem_odp->umem.context->invalidate_range(umem_odp,
+						 ib_umem_start(umem_odp),
+						 ib_umem_end(umem_odp));
 	return 0;
 }
 
-static void ib_umem_notifier_release(struct mmu_notifier *mn,
-				     struct mm_struct *mm)
+static void ib_umem_notifier_release(struct hmm_mirror *mirror)
 {
-	struct ib_ucontext_per_mm *per_mm =
-		container_of(mn, struct ib_ucontext_per_mm, mn);
+	struct ib_ucontext_per_mm *per_mm;
+
+	per_mm = container_of(mirror, struct ib_ucontext_per_mm, mirror);
 
 	down_read(&per_mm->umem_rwsem);
 	if (per_mm->active)
@@ -136,21 +119,22 @@ static void ib_umem_notifier_release(struct mmu_notifier *mn,
 	up_read(&per_mm->umem_rwsem);
 }
 
-static int invalidate_range_start_trampoline(struct ib_umem_odp *item,
-					     u64 start, u64 end, void *cookie)
+static int invalidate_range_trampoline(struct ib_umem_odp *item,
+				       u64 start, u64 end, void *cookie)
 {
-	ib_umem_notifier_start_account(item);
 	item->umem.context->invalidate_range(item, start, end);
 	return 0;
 }
 
-static int ib_umem_notifier_invalidate_range_start(struct mmu_notifier *mn,
-				const struct mmu_notifier_range *range)
+static int ib_sync_cpu_device_pagetables(struct hmm_mirror *mirror,
+			    const struct hmm_update *range)
 {
-	struct ib_ucontext_per_mm *per_mm =
-		container_of(mn, struct ib_ucontext_per_mm, mn);
+	struct ib_ucontext_per_mm *per_mm;
+	int ret;
+
+	per_mm = container_of(mirror, struct ib_ucontext_per_mm, mirror);
 
-	if (mmu_notifier_range_blockable(range))
+	if (range->blockable)
 		down_read(&per_mm->umem_rwsem);
 	else if (!down_read_trylock(&per_mm->umem_rwsem))
 		return -EAGAIN;
@@ -165,39 +149,17 @@ static int ib_umem_notifier_invalidate_range_start(struct mmu_notifier *mn,
 		return 0;
 	}
 
-	return rbt_ib_umem_for_each_in_range(&per_mm->umem_tree, range->start,
+	ret = rbt_ib_umem_for_each_in_range(&per_mm->umem_tree, range->start,
 					     range->end,
-					     invalidate_range_start_trampoline,
-					     mmu_notifier_range_blockable(range),
-					     NULL);
-}
-
-static int invalidate_range_end_trampoline(struct ib_umem_odp *item, u64 start,
-					   u64 end, void *cookie)
-{
-	ib_umem_notifier_end_account(item);
-	return 0;
-}
-
-static void ib_umem_notifier_invalidate_range_end(struct mmu_notifier *mn,
-				const struct mmu_notifier_range *range)
-{
-	struct ib_ucontext_per_mm *per_mm =
-		container_of(mn, struct ib_ucontext_per_mm, mn);
-
-	if (unlikely(!per_mm->active))
-		return;
-
-	rbt_ib_umem_for_each_in_range(&per_mm->umem_tree, range->start,
-				      range->end,
-				      invalidate_range_end_trampoline, true, NULL);
+					     invalidate_range_trampoline,
+					     range->blockable, NULL);
 	up_read(&per_mm->umem_rwsem);
+	return ret;
 }
 
-static const struct mmu_notifier_ops ib_umem_notifiers = {
+static const struct hmm_mirror_ops ib_umem_notifiers = {
 	.release                    = ib_umem_notifier_release,
-	.invalidate_range_start     = ib_umem_notifier_invalidate_range_start,
-	.invalidate_range_end       = ib_umem_notifier_invalidate_range_end,
+	.sync_cpu_device_pagetables = ib_sync_cpu_device_pagetables,
 };
 
 static void add_umem_to_per_mm(struct ib_umem_odp *umem_odp)
@@ -219,7 +181,6 @@ static void remove_umem_from_per_mm(struct ib_umem_odp *umem_odp)
 	if (likely(ib_umem_start(umem_odp) != ib_umem_end(umem_odp)))
 		rbt_ib_umem_remove(&umem_odp->interval_tree,
 				   &per_mm->umem_tree);
-	complete_all(&umem_odp->notifier_completion);
 
 	up_write(&per_mm->umem_rwsem);
 }
@@ -246,11 +207,13 @@ static struct ib_ucontext_per_mm *alloc_per_mm(struct ib_ucontext *ctx,
 
 	WARN_ON(mm != current->mm);
 
-	per_mm->mn.ops = &ib_umem_notifiers;
-	ret = mmu_notifier_register(&per_mm->mn, per_mm->mm);
+	per_mm->mirror.ops = &ib_umem_notifiers;
+	down_write(&mm->mmap_sem);
+	ret = hmm_mirror_register(&per_mm->mirror, per_mm->mm);
+	up_write(&mm->mmap_sem);
 	if (ret) {
 		dev_err(&ctx->device->dev,
-			"Failed to register mmu_notifier %d\n", ret);
+			"Failed to register HMM mirror %d\n", ret);
 		goto out_pid;
 	}
 
@@ -292,11 +255,6 @@ static int get_per_mm(struct ib_umem_odp *umem_odp)
 	return 0;
 }
 
-static void free_per_mm(struct rcu_head *rcu)
-{
-	kfree(container_of(rcu, struct ib_ucontext_per_mm, rcu));
-}
-
 static void put_per_mm(struct ib_umem_odp *umem_odp)
 {
 	struct ib_ucontext_per_mm *per_mm = umem_odp->per_mm;
@@ -325,9 +283,10 @@ static void put_per_mm(struct ib_umem_odp *umem_odp)
 	up_write(&per_mm->umem_rwsem);
 
 	WARN_ON(!RB_EMPTY_ROOT(&per_mm->umem_tree.rb_root));
-	mmu_notifier_unregister_no_release(&per_mm->mn, per_mm->mm);
+	hmm_mirror_unregister(&per_mm->mirror);
 	put_pid(per_mm->tgid);
-	mmu_notifier_call_srcu(&per_mm->rcu, free_per_mm);
+
+	kfree(per_mm);
 }
 
 struct ib_umem_odp *ib_alloc_odp_umem(struct ib_umem_odp *root,
@@ -355,11 +314,9 @@ struct ib_umem_odp *ib_alloc_odp_umem(struct ib_umem_odp *root,
 	mmgrab(umem->owning_mm);
 
 	mutex_init(&odp_data->umem_mutex);
-	init_completion(&odp_data->notifier_completion);
 
-	odp_data->page_list =
-		vzalloc(array_size(pages, sizeof(*odp_data->page_list)));
-	if (!odp_data->page_list) {
+	odp_data->pfns = vzalloc(array_size(pages, sizeof(*odp_data->pfns)));
+	if (!odp_data->pfns) {
 		ret = -ENOMEM;
 		goto out_odp_data;
 	}
@@ -368,7 +325,7 @@ struct ib_umem_odp *ib_alloc_odp_umem(struct ib_umem_odp *root,
 		vzalloc(array_size(pages, sizeof(*odp_data->dma_list)));
 	if (!odp_data->dma_list) {
 		ret = -ENOMEM;
-		goto out_page_list;
+		goto out_pfns;
 	}
 
 	/*
@@ -382,8 +339,8 @@ struct ib_umem_odp *ib_alloc_odp_umem(struct ib_umem_odp *root,
 
 	return odp_data;
 
-out_page_list:
-	vfree(odp_data->page_list);
+out_pfns:
+	vfree(odp_data->pfns);
 out_odp_data:
 	mmdrop(umem->owning_mm);
 	kfree(odp_data);
@@ -419,13 +376,11 @@ int ib_umem_odp_get(struct ib_umem_odp *umem_odp, int access)
 
 	mutex_init(&umem_odp->umem_mutex);
 
-	init_completion(&umem_odp->notifier_completion);
-
 	if (ib_umem_odp_num_pages(umem_odp)) {
-		umem_odp->page_list =
-			vzalloc(array_size(sizeof(*umem_odp->page_list),
+		umem_odp->pfns =
+			vzalloc(array_size(sizeof(*umem_odp->pfns),
 					   ib_umem_odp_num_pages(umem_odp)));
-		if (!umem_odp->page_list)
+		if (!umem_odp->pfns)
 			return -ENOMEM;
 
 		umem_odp->dma_list =
@@ -433,7 +388,7 @@ int ib_umem_odp_get(struct ib_umem_odp *umem_odp, int access)
 					   ib_umem_odp_num_pages(umem_odp)));
 		if (!umem_odp->dma_list) {
 			ret_val = -ENOMEM;
-			goto out_page_list;
+			goto out_pfns;
 		}
 	}
 
@@ -446,8 +401,8 @@ int ib_umem_odp_get(struct ib_umem_odp *umem_odp, int access)
 
 out_dma_list:
 	vfree(umem_odp->dma_list);
-out_page_list:
-	vfree(umem_odp->page_list);
+out_pfns:
+	vfree(umem_odp->pfns);
 	return ret_val;
 }
 
@@ -465,287 +420,126 @@ void ib_umem_odp_release(struct ib_umem_odp *umem_odp)
 	remove_umem_from_per_mm(umem_odp);
 	put_per_mm(umem_odp);
 	vfree(umem_odp->dma_list);
-	vfree(umem_odp->page_list);
-}
-
-/*
- * Map for DMA and insert a single page into the on-demand paging page tables.
- *
- * @umem: the umem to insert the page to.
- * @page_index: index in the umem to add the page to.
- * @page: the page struct to map and add.
- * @access_mask: access permissions needed for this page.
- * @current_seq: sequence number for synchronization with invalidations.
- *               the sequence number is taken from
- *               umem_odp->notifiers_seq.
- *
- * The function returns -EFAULT if the DMA mapping operation fails. It returns
- * -EAGAIN if a concurrent invalidation prevents us from updating the page.
- *
- * The page is released via put_page even if the operation failed. For
- * on-demand pinning, the page is released whenever it isn't stored in the
- * umem.
- */
-static int ib_umem_odp_map_dma_single_page(
-		struct ib_umem_odp *umem_odp,
-		int page_index,
-		struct page *page,
-		u64 access_mask,
-		unsigned long current_seq)
-{
-	struct ib_ucontext *context = umem_odp->umem.context;
-	struct ib_device *dev = context->device;
-	dma_addr_t dma_addr;
-	int remove_existing_mapping = 0;
-	int ret = 0;
-
-	/*
-	 * Note: we avoid writing if seq is different from the initial seq, to
-	 * handle case of a racing notifier. This check also allows us to bail
-	 * early if we have a notifier running in parallel with us.
-	 */
-	if (ib_umem_mmu_notifier_retry(umem_odp, current_seq)) {
-		ret = -EAGAIN;
-		goto out;
-	}
-	if (!(umem_odp->dma_list[page_index])) {
-		dma_addr =
-			ib_dma_map_page(dev, page, 0, BIT(umem_odp->page_shift),
-					DMA_BIDIRECTIONAL);
-		if (ib_dma_mapping_error(dev, dma_addr)) {
-			ret = -EFAULT;
-			goto out;
-		}
-		umem_odp->dma_list[page_index] = dma_addr | access_mask;
-		umem_odp->page_list[page_index] = page;
-		umem_odp->npages++;
-	} else if (umem_odp->page_list[page_index] == page) {
-		umem_odp->dma_list[page_index] |= access_mask;
-	} else {
-		pr_err("error: got different pages in IB device and from get_user_pages. IB device page: %p, gup page: %p\n",
-		       umem_odp->page_list[page_index], page);
-		/* Better remove the mapping now, to prevent any further
-		 * damage. */
-		remove_existing_mapping = 1;
-	}
-
-out:
-	put_page(page);
-
-	if (remove_existing_mapping) {
-		ib_umem_notifier_start_account(umem_odp);
-		context->invalidate_range(
-			umem_odp,
-			ib_umem_start(umem_odp) +
-				(page_index << umem_odp->page_shift),
-			ib_umem_start(umem_odp) +
-				((page_index + 1) << umem_odp->page_shift));
-		ib_umem_notifier_end_account(umem_odp);
-		ret = -EAGAIN;
-	}
-
-	return ret;
+	vfree(umem_odp->pfns);
 }
 
 /**
  * ib_umem_odp_map_dma_pages - Pin and DMA map userspace memory in an ODP MR.
- *
- * Pins the range of pages passed in the argument, and maps them to
- * DMA addresses. The DMA addresses of the mapped pages is updated in
- * umem_odp->dma_list.
- *
- * Returns the number of pages mapped in success, negative error code
- * for failure.
- * An -EAGAIN error code is returned when a concurrent mmu notifier prevents
- * the function from completing its task.
- * An -ENOENT error code indicates that userspace process is being terminated
- * and mm was already destroyed.
  * @umem_odp: the umem to map and pin
- * @user_virt: the address from which we need to map.
- * @bcnt: the minimal number of bytes to pin and map. The mapping might be
- *        bigger due to alignment, and may also be smaller in case of an error
- *        pinning or mapping a page. The actual pages mapped is returned in
- *        the return value.
- * @access_mask: bit mask of the requested access permissions for the given
- *               range.
- * @current_seq: the MMU notifiers sequance value for synchronization with
- *               invalidations. the sequance number is read from
- *               umem_odp->notifiers_seq before calling this function
+ * @range: range of virtual address to be mapped to the device
+ * Returns: -EINVAL some invalid arguments, -EAGAIN need to try again, -ENOENT
+ *          if process is being terminated, number of pages mapped otherwise.
+ *
+ * Map to device a range of virtual address passed in the argument. The DMA
+ * addresses are in umem_odp->dma_list and the corresponding page informations
+ * in umem_odp->pfns.
  */
-int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 user_virt,
-			      u64 bcnt, u64 access_mask,
-			      unsigned long current_seq)
+long ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp,
+			       struct hmm_range *range)
 {
-	struct task_struct *owning_process  = NULL;
-	struct mm_struct *owning_mm = umem_odp->umem.owning_mm;
-	struct page       **local_page_list = NULL;
-	u64 page_mask, off;
-	int j, k, ret = 0, start_idx, npages = 0;
-	unsigned int flags = 0, page_shift;
-	phys_addr_t p = 0;
-
-	if (access_mask == 0)
+	struct device *device = umem_odp->umem.context->device->dma_device;
+	struct ib_ucontext_per_mm *per_mm = umem_odp->per_mm;
+	struct mm_struct *mm = per_mm->mm;
+	unsigned long idx, npages;
+	long ret;
+
+	if (mm == NULL)
+		return -ENOENT;
+
+	/* Only drivers with invalidate support can use this function. */
+	if (!umem_odp->umem.context->invalidate_range)
 		return -EINVAL;
 
-	if (user_virt < ib_umem_start(umem_odp) ||
-	    user_virt + bcnt > ib_umem_end(umem_odp))
-		return -EFAULT;
+	/* Sanity checks. */
+	if (range->default_flags == 0)
+		return -EINVAL;
 
-	local_page_list = (struct page **)__get_free_page(GFP_KERNEL);
-	if (!local_page_list)
-		return -ENOMEM;
+	if (range->start < ib_umem_start(umem_odp) ||
+	    range->end > ib_umem_end(umem_odp))
+		return -EINVAL;
 
-	page_shift = umem_odp->page_shift;
-	page_mask = ~(BIT(page_shift) - 1);
-	off = user_virt & (~page_mask);
-	user_virt = user_virt & page_mask;
-	bcnt += off; /* Charge for the first page offset as well. */
+	idx = (range->start - ib_umem_start(umem_odp)) >> umem_odp->page_shift;
+	range->pfns = &umem_odp->pfns[idx];
+	range->pfn_shift = ODP_FLAGS_BITS;
+	range->values = odp_hmm_values;
+	range->flags = odp_hmm_flags;
 
 	/*
-	 * owning_process is allowed to be NULL, this means somehow the mm is
-	 * existing beyond the lifetime of the originating process.. Presumably
-	 * mmget_not_zero will fail in this case.
+	 * If mm is dying just bail out early without trying to take mmap_sem.
+	 * Note that this might race with mm destruction but that is fine the
+	 * is properly refcounted so are all HMM structure.
+	 *
+	 * This means that per_mm->mm is always a valid pointer as hmm struct
+	 * hold a reference on mm struct and the hmm_mirror struct hold a
+	 * reference on the hmm struct as do the hmm_range struct. Thus at this
+	 * point the mm struct can not be freed from under us and it is safe
+	 * to dereference it and try to take the mmap_sem.
+	 *
+	 * If all process owning the mm struct are dead or dying then HMM will
+	 * catch that and it is safe to call within HMM which will return with
+	 * -EFAULT.
 	 */
-	owning_process = get_pid_task(umem_odp->per_mm->tgid, PIDTYPE_PID);
-	if (!owning_process || !mmget_not_zero(owning_mm)) {
-		ret = -EINVAL;
-		goto out_put_task;
-	}
-
-	if (access_mask & ODP_WRITE_ALLOWED_BIT)
-		flags |= FOLL_WRITE;
-
-	start_idx = (user_virt - ib_umem_start(umem_odp)) >> page_shift;
-	k = start_idx;
-
-	while (bcnt > 0) {
-		const size_t gup_num_pages = min_t(size_t,
-				(bcnt + BIT(page_shift) - 1) >> page_shift,
-				PAGE_SIZE / sizeof(struct page *));
-
-		down_read(&owning_mm->mmap_sem);
-		/*
-		 * Note: this might result in redundent page getting. We can
-		 * avoid this by checking dma_list to be 0 before calling
-		 * get_user_pages. However, this make the code much more
-		 * complex (and doesn't gain us much performance in most use
-		 * cases).
-		 */
-		npages = get_user_pages_remote(owning_process, owning_mm,
-				user_virt, gup_num_pages,
-				flags, local_page_list, NULL, NULL);
-		up_read(&owning_mm->mmap_sem);
-
-		if (npages < 0) {
-			if (npages != -EAGAIN)
-				pr_warn("fail to get %zu user pages with error %d\n", gup_num_pages, npages);
-			else
-				pr_debug("fail to get %zu user pages with error %d\n", gup_num_pages, npages);
-			break;
-		}
+	if (!hmm_mirror_mm_is_alive(&per_mm->mirror))
+		return -EINVAL;
+	down_read(&mm->mmap_sem);
+	mutex_lock(&umem_odp->umem_mutex);
+	ret = hmm_range_dma_map(range, device,
+		&umem_odp->dma_list[idx], true);
+	mutex_unlock(&umem_odp->umem_mutex);
+	npages = ret;
 
-		bcnt -= min_t(size_t, npages << PAGE_SHIFT, bcnt);
-		mutex_lock(&umem_odp->umem_mutex);
-		for (j = 0; j < npages; j++, user_virt += PAGE_SIZE) {
-			if (user_virt & ~page_mask) {
-				p += PAGE_SIZE;
-				if (page_to_phys(local_page_list[j]) != p) {
-					ret = -EFAULT;
-					break;
-				}
-				put_page(local_page_list[j]);
-				continue;
-			}
-
-			ret = ib_umem_odp_map_dma_single_page(
-					umem_odp, k, local_page_list[j],
-					access_mask, current_seq);
-			if (ret < 0) {
-				if (ret != -EAGAIN)
-					pr_warn("ib_umem_odp_map_dma_single_page failed with error %d\n", ret);
-				else
-					pr_debug("ib_umem_odp_map_dma_single_page failed with error %d\n", ret);
-				break;
-			}
-
-			p = page_to_phys(local_page_list[j]);
-			k++;
-		}
-		mutex_unlock(&umem_odp->umem_mutex);
-
-		if (ret < 0) {
-			/*
-			 * Release pages, remembering that the first page
-			 * to hit an error was already released by
-			 * ib_umem_odp_map_dma_single_page().
-			 */
-			if (npages - (j + 1) > 0)
-				release_pages(&local_page_list[j+1],
-					      npages - (j + 1));
-			break;
-		}
-	}
+	/*
+	 * The mmap_sem have been drop if hmm_vma_fault_and_dma_map() returned
+	 * with -EAGAIN. In which case we need to retry as -EBUSY but we also
+	 * need to take the mmap_sem again.
+	 */
+	if (ret != -EAGAIN)
+		 up_read(&mm->mmap_sem);
 
-	if (ret >= 0) {
-		if (npages < 0 && k == start_idx)
-			ret = npages;
-		else
-			ret = k - start_idx;
+	if (ret <= 0) {
+		/* Convert -EBUSY to -EAGAIN and 0 to -EAGAIN */
+		ret = ret == -EBUSY ? -EAGAIN : ret;
+		return ret ? ret : -EAGAIN;
 	}
 
-	mmput(owning_mm);
-out_put_task:
-	if (owning_process)
-		put_task_struct(owning_process);
-	free_page((unsigned long)local_page_list);
-	return ret;
+	umem_odp->npages += npages;
+	return npages;
 }
 EXPORT_SYMBOL(ib_umem_odp_map_dma_pages);
 
-void ib_umem_odp_unmap_dma_pages(struct ib_umem_odp *umem_odp, u64 virt,
-				 u64 bound)
+void ib_umem_odp_unmap_dma_pages(struct ib_umem_odp *umem_odp,
+				 u64 virt, u64 bound)
 {
-	int idx;
-	u64 addr;
-	struct ib_device *dev = umem_odp->umem.context->device;
+	struct device *device = umem_odp->umem.context->device->dma_device;
+	unsigned long idx, page_mask;
+	struct hmm_range range;
+	long ret;
+
+	if (!umem_odp->npages)
+		return;
 
-	virt = max_t(u64, virt, ib_umem_start(umem_odp));
+	bound = ALIGN(bound, 1UL << umem_odp->page_shift);
+	page_mask = ~(BIT(umem_odp->page_shift) - 1);
+	virt &= page_mask;
+
+	virt  = max_t(u64, virt,  ib_umem_start(umem_odp));
 	bound = min_t(u64, bound, ib_umem_end(umem_odp));
-	/* Note that during the run of this function, the
-	 * notifiers_count of the MR is > 0, preventing any racing
-	 * faults from completion. We might be racing with other
-	 * invalidations, so we must make sure we free each page only
-	 * once. */
+
+	idx = ((unsigned long)virt - ib_umem_start(umem_odp)) >> PAGE_SHIFT;
+
+	range.page_shift = umem_odp->page_shift;
+	range.pfns = &umem_odp->pfns[idx];
+	range.pfn_shift = ODP_FLAGS_BITS;
+	range.values = odp_hmm_values;
+	range.flags = odp_hmm_flags;
+	range.start = virt;
+	range.end = bound;
+
 	mutex_lock(&umem_odp->umem_mutex);
-	for (addr = virt; addr < bound; addr += BIT(umem_odp->page_shift)) {
-		idx = (addr - ib_umem_start(umem_odp)) >> umem_odp->page_shift;
-		if (umem_odp->page_list[idx]) {
-			struct page *page = umem_odp->page_list[idx];
-			dma_addr_t dma = umem_odp->dma_list[idx];
-			dma_addr_t dma_addr = dma & ODP_DMA_ADDR_MASK;
-
-			WARN_ON(!dma_addr);
-
-			ib_dma_unmap_page(dev, dma_addr, PAGE_SIZE,
-					  DMA_BIDIRECTIONAL);
-			if (dma & ODP_WRITE_ALLOWED_BIT) {
-				struct page *head_page = compound_head(page);
-				/*
-				 * set_page_dirty prefers being called with
-				 * the page lock. However, MMU notifiers are
-				 * called sometimes with and sometimes without
-				 * the lock. We rely on the umem_mutex instead
-				 * to prevent other mmu notifiers from
-				 * continuing and allowing the page mapping to
-				 * be removed.
-				 */
-				set_page_dirty(head_page);
-			}
-			umem_odp->page_list[idx] = NULL;
-			umem_odp->dma_list[idx] = 0;
-			umem_odp->npages--;
-		}
-	}
+	ret = hmm_range_dma_unmap(&range, NULL, device,
+		&umem_odp->dma_list[idx], true);
+	if (ret > 0)
+		umem_odp->npages -= ret;
 	mutex_unlock(&umem_odp->umem_mutex);
 }
 EXPORT_SYMBOL(ib_umem_odp_unmap_dma_pages);
diff --git a/drivers/infiniband/hw/mlx5/mem.c b/drivers/infiniband/hw/mlx5/mem.c
index fe1a76d8531c..f2d92f0eb3f4 100644
--- a/drivers/infiniband/hw/mlx5/mem.c
+++ b/drivers/infiniband/hw/mlx5/mem.c
@@ -112,16 +112,16 @@ void mlx5_ib_cont_pages(struct ib_umem *umem, u64 addr,
 	*count = i;
 }
 
-static u64 umem_dma_to_mtt(dma_addr_t umem_dma)
+static u64 umem_dma_to_mtt(struct ib_umem_odp *odp, size_t idx)
 {
-	u64 mtt_entry = umem_dma & ODP_DMA_ADDR_MASK;
+	u64 mtt_entry = odp->dma_list[idx];
 
-	if (umem_dma & ODP_READ_ALLOWED_BIT)
+	if (odp->pfns[idx] & ODP_READ_BIT)
 		mtt_entry |= MLX5_IB_MTT_READ;
-	if (umem_dma & ODP_WRITE_ALLOWED_BIT)
+	if (odp->pfns[idx] & ODP_WRITE_BIT)
 		mtt_entry |= MLX5_IB_MTT_WRITE;
 
-	return mtt_entry;
+	return cpu_to_be64(mtt_entry);
 }
 
 /*
@@ -151,15 +151,13 @@ void __mlx5_ib_populate_pas(struct mlx5_ib_dev *dev, struct ib_umem *umem,
 	int entry;
 
 	if (umem->is_odp) {
+		struct ib_umem_odp *odp = to_ib_umem_odp(umem);
+
 		WARN_ON(shift != 0);
 		WARN_ON(access_flags != (MLX5_IB_MTT_READ | MLX5_IB_MTT_WRITE));
 
-		for (i = 0; i < num_pages; ++i) {
-			dma_addr_t pa =
-				to_ib_umem_odp(umem)->dma_list[offset + i];
-
-			pas[i] = cpu_to_be64(umem_dma_to_mtt(pa));
-		}
+		for (i = 0; i < num_pages; ++i)
+			pas[i] = umem_dma_to_mtt(odp, offset + i);
 		return;
 	}
 
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 4d033796dcfc..a8e7ac685ce1 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1605,7 +1605,7 @@ static void dereg_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 		/* Wait for all running page-fault handlers to finish. */
 		synchronize_srcu(&dev->mr_srcu);
 		/* Destroy all page mappings */
-		if (umem_odp->page_list)
+		if (umem_odp->pfns)
 			mlx5_ib_invalidate_range(umem_odp,
 						 ib_umem_start(umem_odp),
 						 ib_umem_end(umem_odp));
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index d0c6f9cc97ef..45438620c0fa 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -255,8 +255,7 @@ void mlx5_ib_invalidate_range(struct ib_umem_odp *umem_odp, unsigned long start,
 		 * estimate the cost of another UMR vs. the cost of bigger
 		 * UMR.
 		 */
-		if (umem_odp->dma_list[idx] &
-		    (ODP_READ_ALLOWED_BIT | ODP_WRITE_ALLOWED_BIT)) {
+		if (umem_odp->pfns[idx] & ODP_READ_BIT) {
 			if (!in_block) {
 				blk_start_idx = idx;
 				in_block = 1;
@@ -577,17 +576,18 @@ static int pagefault_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr,
 			u64 io_virt, size_t bcnt, u32 *bytes_mapped,
 			u32 flags)
 {
-	int npages = 0, current_seq, page_shift, ret, np;
-	bool implicit = false;
 	struct ib_umem_odp *odp_mr = to_ib_umem_odp(mr->umem);
 	bool downgrade = flags & MLX5_PF_FLAGS_DOWNGRADE;
 	bool prefetch = flags & MLX5_PF_FLAGS_PREFETCH;
-	u64 access_mask;
+	unsigned long npages = 0, page_shift, np, off;
 	u64 start_idx, page_mask;
 	struct ib_umem_odp *odp;
-	size_t size;
+	struct hmm_range range;
+	bool implicit = false;
+	size_t size, fault_size;
+	long ret;
 
-	if (!odp_mr->page_list) {
+	if (!odp_mr->pfns) {
 		odp = implicit_mr_get_data(mr, io_virt, bcnt);
 
 		if (IS_ERR(odp))
@@ -600,11 +600,26 @@ static int pagefault_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr,
 
 next_mr:
 	size = min_t(size_t, bcnt, ib_umem_end(odp) - io_virt);
-
 	page_shift = odp->page_shift;
 	page_mask = ~(BIT(page_shift) - 1);
+	/*
+	 * We need to align io_virt on page size so off is the extra bytes we
+	 * will be faulting and fault_size is the page aligned size we are
+	 * faulting.
+	 */
+	io_virt = io_virt & page_mask;
+	off = (io_virt & (~page_mask));
+	fault_size = ALIGN(size + off, 1UL << page_shift);
+
+	if (io_virt < ib_umem_start(odp))
+		return -EINVAL;
+
 	start_idx = (io_virt - (mr->mmkey.iova & page_mask)) >> page_shift;
-	access_mask = ODP_READ_ALLOWED_BIT;
+
+	ret = hmm_range_register(&range, odp_mr->per_mm->mm,
+				 io_virt, io_virt + fault_size, page_shift);
+	if (ret)
+		return ret;
 
 	if (prefetch && !downgrade && !mr->umem->writable) {
 		/* prefetch with write-access must
@@ -614,58 +629,55 @@ static int pagefault_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr,
 		goto out;
 	}
 
+	range.default_flags = ODP_READ_BIT;
 	if (mr->umem->writable && !downgrade)
-		access_mask |= ODP_WRITE_ALLOWED_BIT;
-
-	current_seq = READ_ONCE(odp->notifiers_seq);
-	/*
-	 * Ensure the sequence number is valid for some time before we call
-	 * gup.
-	 */
-	smp_rmb();
-
-	ret = ib_umem_odp_map_dma_pages(to_ib_umem_odp(mr->umem), io_virt, size,
-					access_mask, current_seq);
+		range.default_flags |= ODP_WRITE_BIT;
 
+	ret = ib_umem_odp_map_dma_pages(to_ib_umem_odp(mr->umem), &range);
 	if (ret < 0)
-		goto out;
+		goto again;
 
 	np = ret;
 
 	mutex_lock(&odp->umem_mutex);
-	if (!ib_umem_mmu_notifier_retry(to_ib_umem_odp(mr->umem),
-					current_seq)) {
+	if (hmm_range_valid(&range)) {
 		/*
 		 * No need to check whether the MTTs really belong to
-		 * this MR, since ib_umem_odp_map_dma_pages already
+		 * this MR, since ib_umem_odp_map_dma_pages() already
 		 * checks this.
 		 */
 		ret = mlx5_ib_update_xlt(mr, start_idx, np,
 					 page_shift, MLX5_IB_UPD_XLT_ATOMIC);
-	} else {
+	} else
 		ret = -EAGAIN;
-	}
 	mutex_unlock(&odp->umem_mutex);
 
 	if (ret < 0) {
-		if (ret != -EAGAIN)
+		if (ret != -EAGAIN) {
 			mlx5_ib_err(dev, "Failed to update mkey page tables\n");
-		goto out;
+			goto out;
+		}
+		goto again;
 	}
 
 	if (bytes_mapped) {
-		u32 new_mappings = (np << page_shift) -
-			(io_virt - round_down(io_virt, 1 << page_shift));
+		long new_mappings = (np << page_shift) - off;
+		new_mappings = new_mappings < 0 ? 0 : new_mappings;
 		*bytes_mapped += min_t(u32, new_mappings, size);
 	}
 
 	npages += np << (page_shift - PAGE_SHIFT);
+	hmm_range_unregister(&range);
 	bcnt -= size;
 
-	if (unlikely(bcnt)) {
+	if (unlikely(bcnt > 0)) {
 		struct ib_umem_odp *next;
 
-		io_virt += size;
+		/*
+		 * Next virtual address is after the number of bytes we faulted
+		 * in this step.
+		 */
+		io_virt += fault_size;
 		next = odp_next(odp);
 		if (unlikely(!next || next->umem.address != io_virt)) {
 			mlx5_ib_dbg(dev, "next implicit leaf removed at 0x%llx. got %p\n",
@@ -679,24 +691,18 @@ static int pagefault_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr,
 
 	return npages;
 
-out:
-	if (ret == -EAGAIN) {
-		if (implicit || !odp->dying) {
-			unsigned long timeout =
-				msecs_to_jiffies(MMU_NOTIFIER_TIMEOUT);
-
-			if (!wait_for_completion_timeout(
-					&odp->notifier_completion,
-					timeout)) {
-				mlx5_ib_warn(dev, "timeout waiting for mmu notifier. seq %d against %d. notifiers_count=%d\n",
-					     current_seq, odp->notifiers_seq, odp->notifiers_count);
-			}
-		} else {
-			/* The MR is being killed, kill the QP as well. */
-			ret = -EFAULT;
-		}
-	}
+again:
+	if (ret != -EAGAIN)
+		goto out;
+
+	/* Check if the MR is being killed, kill the QP as well. */
+	if (!implicit || odp->dying)
+		ret = -EFAULT;
+	else if (!hmm_range_wait_until_valid(&range, MMU_NOTIFIER_TIMEOUT))
+		mlx5_ib_warn(dev, "timeout waiting for mmu notifier.\n");
 
+out:
+	hmm_range_unregister(&range);
 	return ret;
 }
 
diff --git a/include/rdma/ib_umem_odp.h b/include/rdma/ib_umem_odp.h
index 479db5c98ff6..e1476e9ebb79 100644
--- a/include/rdma/ib_umem_odp.h
+++ b/include/rdma/ib_umem_odp.h
@@ -36,6 +36,7 @@
 #include <rdma/ib_umem.h>
 #include <rdma/ib_verbs.h>
 #include <linux/interval_tree.h>
+#include <linux/hmm.h>
 
 struct umem_odp_node {
 	u64 __subtree_last;
@@ -47,11 +48,11 @@ struct ib_umem_odp {
 	struct ib_ucontext_per_mm *per_mm;
 
 	/*
-	 * An array of the pages included in the on-demand paging umem.
-	 * Indices of pages that are currently not mapped into the device will
-	 * contain NULL.
+	 * An array of the pages included in the on-demand paging umem. Indices
+	 * of pages that are currently not mapped into the device will contain
+	 * 0.
 	 */
-	struct page		**page_list;
+	uint64_t *pfns;
 	/*
 	 * An array of the same size as page_list, with DMA addresses mapped
 	 * for pages the pages in page_list. The lower two bits designate
@@ -67,14 +68,11 @@ struct ib_umem_odp {
 	struct mutex		umem_mutex;
 	void			*private; /* for the HW driver to use. */
 
-	int notifiers_seq;
-	int notifiers_count;
 	int npages;
 
 	/* Tree tracking */
 	struct umem_odp_node	interval_tree;
 
-	struct completion	notifier_completion;
 	int			dying;
 	unsigned int		page_shift;
 	struct work_struct	work;
@@ -129,11 +127,10 @@ struct ib_ucontext_per_mm {
 	/* Protects umem_tree */
 	struct rw_semaphore umem_rwsem;
 
-	struct mmu_notifier mn;
+	struct hmm_mirror mirror;
 	unsigned int odp_mrs_count;
 
 	struct list_head ucontext_list;
-	struct rcu_head rcu;
 };
 
 int ib_umem_odp_get(struct ib_umem_odp *umem_odp, int access);
@@ -141,9 +138,18 @@ struct ib_umem_odp *ib_alloc_odp_umem(struct ib_umem_odp *root_umem,
 				      unsigned long addr, size_t size);
 void ib_umem_odp_release(struct ib_umem_odp *umem_odp);
 
-int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 start_offset,
-			      u64 bcnt, u64 access_mask,
-			      unsigned long current_seq);
+#define ODP_READ_BIT	(1<<0ULL)
+#define ODP_WRITE_BIT	(1<<1ULL)
+/*
+ * The device bit is not use by ODP but is there to full-fill HMM API which
+ * also support device with device memory (like GPU). So from ODP/RDMA POV
+ * this can be ignored.
+ */
+#define ODP_DEVICE_BIT	(1<<2ULL)
+#define ODP_FLAGS_BITS	3
+
+long ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp,
+			       struct hmm_range *range);
 
 void ib_umem_odp_unmap_dma_pages(struct ib_umem_odp *umem_odp, u64 start_offset,
 				 u64 bound);
@@ -166,23 +172,6 @@ int rbt_ib_umem_for_each_in_range(struct rb_root_cached *root,
 struct ib_umem_odp *rbt_ib_umem_lookup(struct rb_root_cached *root,
 				       u64 addr, u64 length);
 
-static inline int ib_umem_mmu_notifier_retry(struct ib_umem_odp *umem_odp,
-					     unsigned long mmu_seq)
-{
-	/*
-	 * This code is strongly based on the KVM code from
-	 * mmu_notifier_retry. Should be called with
-	 * the relevant locks taken (umem_odp->umem_mutex
-	 * and the ucontext umem_mutex semaphore locked for read).
-	 */
-
-	if (unlikely(umem_odp->notifiers_count))
-		return 1;
-	if (umem_odp->notifiers_seq != mmu_seq)
-		return 1;
-	return 0;
-}
-
 #else /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
 
 static inline int ib_umem_odp_get(struct ib_umem_odp *umem_odp, int access)
-- 
2.20.1


--VbJkn9YxBvnuCH5J--
