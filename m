Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 267A2398C4
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jun 2019 00:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbfFGWcM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 18:32:12 -0400
Received: from mga01.intel.com ([192.55.52.88]:17597 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728749AbfFGWcM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 7 Jun 2019 18:32:12 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2019 15:32:11 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga008.jf.intel.com with ESMTP; 07 Jun 2019 15:32:10 -0700
Date:   Fri, 7 Jun 2019 15:33:24 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH v2 hmm 02/11] mm/hmm: Use hmm_mirror not mm as an
 argument for hmm_range_register
Message-ID: <20190607223324.GD14559@iweiny-DESK2.sc.intel.com>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-3-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606184438.31646-3-jgg@ziepe.ca>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 06, 2019 at 03:44:29PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> Ralph observes that hmm_range_register() can only be called by a driver
> while a mirror is registered. Make this clear in the API by passing in the
> mirror structure as a parameter.
> 
> This also simplifies understanding the lifetime model for struct hmm, as
> the hmm pointer must be valid as part of a registered mirror so all we
> need in hmm_register_range() is a simple kref_get.
> 
> Suggested-by: Ralph Campbell <rcampbell@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
> v2
> - Include the oneline patch to nouveau_svm.c
> ---
>  drivers/gpu/drm/nouveau/nouveau_svm.c |  2 +-
>  include/linux/hmm.h                   |  7 ++++---
>  mm/hmm.c                              | 15 ++++++---------
>  3 files changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
> index 93ed43c413f0bb..8c92374afcf227 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_svm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
> @@ -649,7 +649,7 @@ nouveau_svm_fault(struct nvif_notify *notify)
>  		range.values = nouveau_svm_pfn_values;
>  		range.pfn_shift = NVIF_VMM_PFNMAP_V0_ADDR_SHIFT;
>  again:
> -		ret = hmm_vma_fault(&range, true);
> +		ret = hmm_vma_fault(&svmm->mirror, &range, true);
>  		if (ret == 0) {
>  			mutex_lock(&svmm->mutex);
>  			if (!hmm_vma_range_done(&range)) {
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index 688c5ca7068795..2d519797cb134a 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -505,7 +505,7 @@ static inline bool hmm_mirror_mm_is_alive(struct hmm_mirror *mirror)
>   * Please see Documentation/vm/hmm.rst for how to use the range API.
>   */
>  int hmm_range_register(struct hmm_range *range,
> -		       struct mm_struct *mm,
> +		       struct hmm_mirror *mirror,
>  		       unsigned long start,
>  		       unsigned long end,
>  		       unsigned page_shift);
> @@ -541,7 +541,8 @@ static inline bool hmm_vma_range_done(struct hmm_range *range)
>  }
>  
>  /* This is a temporary helper to avoid merge conflict between trees. */
> -static inline int hmm_vma_fault(struct hmm_range *range, bool block)
> +static inline int hmm_vma_fault(struct hmm_mirror *mirror,
> +				struct hmm_range *range, bool block)
>  {
>  	long ret;
>  
> @@ -554,7 +555,7 @@ static inline int hmm_vma_fault(struct hmm_range *range, bool block)
>  	range->default_flags = 0;
>  	range->pfn_flags_mask = -1UL;
>  
> -	ret = hmm_range_register(range, range->vma->vm_mm,
> +	ret = hmm_range_register(range, mirror,
>  				 range->start, range->end,
>  				 PAGE_SHIFT);
>  	if (ret)
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 547002f56a163d..8796447299023c 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -925,13 +925,13 @@ static void hmm_pfns_clear(struct hmm_range *range,
>   * Track updates to the CPU page table see include/linux/hmm.h
>   */
>  int hmm_range_register(struct hmm_range *range,
> -		       struct mm_struct *mm,
> +		       struct hmm_mirror *mirror,
>  		       unsigned long start,
>  		       unsigned long end,
>  		       unsigned page_shift)
>  {
>  	unsigned long mask = ((1UL << page_shift) - 1UL);
> -	struct hmm *hmm;
> +	struct hmm *hmm = mirror->hmm;
>  
>  	range->valid = false;
>  	range->hmm = NULL;
> @@ -945,15 +945,12 @@ int hmm_range_register(struct hmm_range *range,
>  	range->start = start;
>  	range->end = end;
>  
> -	hmm = hmm_get_or_create(mm);
> -	if (!hmm)
> -		return -EFAULT;
> -
>  	/* Check if hmm_mm_destroy() was call. */
> -	if (hmm->mm == NULL || hmm->dead) {
> -		hmm_put(hmm);
> +	if (hmm->mm == NULL || hmm->dead)
>  		return -EFAULT;
> -	}
> +
> +	range->hmm = hmm;

I don't think you need this assignment here.  In the code below (right after
the mutext_lock()) it is set already.  And looks like it remains that way after
the end of the series.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> +	kref_get(&hmm->kref);
>  
>  	/* Initialize range to track CPU page table updates. */
>  	mutex_lock(&hmm->lock);
> -- 
> 2.21.0
> 
