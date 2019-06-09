Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0FF3ABAC
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Jun 2019 21:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbfFITpS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 Jun 2019 15:45:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:64007 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbfFITpR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 9 Jun 2019 15:45:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jun 2019 12:45:16 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga006.jf.intel.com with ESMTP; 09 Jun 2019 12:45:16 -0700
Date:   Sun, 9 Jun 2019 12:46:32 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        Jason Gunthorpe <jgg@mellanox.com>, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: Re: [RFC] mm/hmm: pass mmu_notifier_range to
 sync_cpu_device_pagetables
Message-ID: <20190609194632.GB19825@iweiny-DESK2.sc.intel.com>
References: <20190608001452.7922-1-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190608001452.7922-1-rcampbell@nvidia.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 07, 2019 at 05:14:52PM -0700, Ralph Campbell wrote:
> HMM defines its own struct hmm_update which is passed to the
> sync_cpu_device_pagetables() callback function. This is
> sufficient when the only action is to invalidate. However,
> a device may want to know the reason for the invalidation and
> be able to see the new permissions on a range, update device access
> rights or range statistics. Since sync_cpu_device_pagetables()
> can be called from try_to_unmap(), the mmap_sem may not be held
> and find_vma() is not safe to be called.
> Pass the struct mmu_notifier_range to sync_cpu_device_pagetables()
> to allow the full invalidation information to be used.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>

I don't disagree with Christoph or Jason but since I've been trying to sort out
where hmm does and does not fit any chance to remove a custom structure is a
good simplification IMO.  So...

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
> 
> I'm sending this out now since we are updating many of the HMM APIs
> and I think it will be useful.
> 
> 
>  drivers/gpu/drm/nouveau/nouveau_svm.c |  4 ++--
>  include/linux/hmm.h                   | 27 ++-------------------------
>  mm/hmm.c                              | 13 ++++---------
>  3 files changed, 8 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
> index 8c92374afcf2..c34b98fafe2f 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_svm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
> @@ -252,13 +252,13 @@ nouveau_svmm_invalidate(struct nouveau_svmm *svmm, u64 start, u64 limit)
>  
>  static int
>  nouveau_svmm_sync_cpu_device_pagetables(struct hmm_mirror *mirror,
> -					const struct hmm_update *update)
> +					const struct mmu_notifier_range *update)
>  {
>  	struct nouveau_svmm *svmm = container_of(mirror, typeof(*svmm), mirror);
>  	unsigned long start = update->start;
>  	unsigned long limit = update->end;
>  
> -	if (!update->blockable)
> +	if (!mmu_notifier_range_blockable(update))
>  		return -EAGAIN;
>  
>  	SVMM_DBG(svmm, "invalidate %016lx-%016lx", start, limit);
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index 0fa8ea34ccef..07a2d38fde34 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -377,29 +377,6 @@ static inline uint64_t hmm_pfn_from_pfn(const struct hmm_range *range,
>  
>  struct hmm_mirror;
>  
> -/*
> - * enum hmm_update_event - type of update
> - * @HMM_UPDATE_INVALIDATE: invalidate range (no indication as to why)
> - */
> -enum hmm_update_event {
> -	HMM_UPDATE_INVALIDATE,
> -};
> -
> -/*
> - * struct hmm_update - HMM update information for callback
> - *
> - * @start: virtual start address of the range to update
> - * @end: virtual end address of the range to update
> - * @event: event triggering the update (what is happening)
> - * @blockable: can the callback block/sleep ?
> - */
> -struct hmm_update {
> -	unsigned long start;
> -	unsigned long end;
> -	enum hmm_update_event event;
> -	bool blockable;
> -};
> -
>  /*
>   * struct hmm_mirror_ops - HMM mirror device operations callback
>   *
> @@ -420,7 +397,7 @@ struct hmm_mirror_ops {
>  	/* sync_cpu_device_pagetables() - synchronize page tables
>  	 *
>  	 * @mirror: pointer to struct hmm_mirror
> -	 * @update: update information (see struct hmm_update)
> +	 * @update: update information (see struct mmu_notifier_range)
>  	 * Return: -EAGAIN if update.blockable false and callback need to
>  	 *          block, 0 otherwise.
>  	 *
> @@ -434,7 +411,7 @@ struct hmm_mirror_ops {
>  	 * synchronous call.
>  	 */
>  	int (*sync_cpu_device_pagetables)(struct hmm_mirror *mirror,
> -					  const struct hmm_update *update);
> +				const struct mmu_notifier_range *update);
>  };
>  
>  /*
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 9aad3550f2bb..b49a43712554 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -164,7 +164,6 @@ static int hmm_invalidate_range_start(struct mmu_notifier *mn,
>  {
>  	struct hmm *hmm = container_of(mn, struct hmm, mmu_notifier);
>  	struct hmm_mirror *mirror;
> -	struct hmm_update update;
>  	struct hmm_range *range;
>  	unsigned long flags;
>  	int ret = 0;
> @@ -173,15 +172,10 @@ static int hmm_invalidate_range_start(struct mmu_notifier *mn,
>  	if (!kref_get_unless_zero(&hmm->kref))
>  		return 0;
>  
> -	update.start = nrange->start;
> -	update.end = nrange->end;
> -	update.event = HMM_UPDATE_INVALIDATE;
> -	update.blockable = mmu_notifier_range_blockable(nrange);
> -
>  	spin_lock_irqsave(&hmm->ranges_lock, flags);
>  	hmm->notifiers++;
>  	list_for_each_entry(range, &hmm->ranges, list) {
> -		if (update.end < range->start || update.start >= range->end)
> +		if (nrange->end < range->start || nrange->start >= range->end)
>  			continue;
>  
>  		range->valid = false;
> @@ -198,9 +192,10 @@ static int hmm_invalidate_range_start(struct mmu_notifier *mn,
>  	list_for_each_entry(mirror, &hmm->mirrors, list) {
>  		int rc;
>  
> -		rc = mirror->ops->sync_cpu_device_pagetables(mirror, &update);
> +		rc = mirror->ops->sync_cpu_device_pagetables(mirror, nrange);
>  		if (rc) {
> -			if (WARN_ON(update.blockable || rc != -EAGAIN))
> +			if (WARN_ON(mmu_notifier_range_blockable(nrange) ||
> +				    rc != -EAGAIN))
>  				continue;
>  			ret = -EAGAIN;
>  			break;
> -- 
> 2.20.1
> 
