Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51F8E3943F
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 20:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbfFGSYt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 14:24:49 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17045 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731210AbfFGSYt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 14:24:49 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cfaabef0000>; Fri, 07 Jun 2019 11:24:47 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 07 Jun 2019 11:24:47 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 07 Jun 2019 11:24:47 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Jun
 2019 18:24:44 +0000
Subject: Re: [PATCH v2 hmm 02/11] mm/hmm: Use hmm_mirror not mm as an argument
 for hmm_range_register
To:     Jason Gunthorpe <jgg@ziepe.ca>, Jerome Glisse <jglisse@redhat.com>,
        "John Hubbard" <jhubbard@nvidia.com>, <Felix.Kuehling@amd.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        Jason Gunthorpe <jgg@mellanox.com>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-3-jgg@ziepe.ca>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <4a391bd4-287c-5f13-3bca-c6a46ff8d08c@nvidia.com>
Date:   Fri, 7 Jun 2019 11:24:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190606184438.31646-3-jgg@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559931887; bh=xt8hRcHzLeQkLBeS1/P3+kfd7HxoS8TOq54zYdn437c=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Jzl10aMIEyNyvMJQOea9/cem8BK3fdX7N7BBW39ZQ2ZTnhr3i9Bg45PYwohda1UY9
         LkcU8MB8OKdUMSj8b6yUghIjjinGIugW4aSBllEIx7TVCfwzbApXGQL3P9ClD/AN2z
         Yv3rNjAyUFe/mSLyYvWlzlYj8psKbq2qMRJzEB+cKi7ZRC9AQCwhtNhX/CDYSmifhd
         OgQAo1Xs1VMOWXccxd1U6MRqnzkHVOsG3cy4I45UtG8jiXu1hu6emUv1Z1CwQxFrGP
         /0qhySFwJdt1mao3BY0IXnmpWfz2Fu3UMQQ3D0H/L5X1ETwrAIQVgVzM8gB201RZnz
         ZlKK89hwVr+aw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/6/19 11:44 AM, Jason Gunthorpe wrote:
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

You might CC Ben for the nouveau part.
CC: Ben Skeggs <bskeggs@redhat.com>

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>


> ---
> v2
> - Include the oneline patch to nouveau_svm.c
> ---
>   drivers/gpu/drm/nouveau/nouveau_svm.c |  2 +-
>   include/linux/hmm.h                   |  7 ++++---
>   mm/hmm.c                              | 15 ++++++---------
>   3 files changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
> index 93ed43c413f0bb..8c92374afcf227 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_svm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
> @@ -649,7 +649,7 @@ nouveau_svm_fault(struct nvif_notify *notify)
>   		range.values = nouveau_svm_pfn_values;
>   		range.pfn_shift = NVIF_VMM_PFNMAP_V0_ADDR_SHIFT;
>   again:
> -		ret = hmm_vma_fault(&range, true);
> +		ret = hmm_vma_fault(&svmm->mirror, &range, true);
>   		if (ret == 0) {
>   			mutex_lock(&svmm->mutex);
>   			if (!hmm_vma_range_done(&range)) {
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index 688c5ca7068795..2d519797cb134a 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -505,7 +505,7 @@ static inline bool hmm_mirror_mm_is_alive(struct hmm_mirror *mirror)
>    * Please see Documentation/vm/hmm.rst for how to use the range API.
>    */
>   int hmm_range_register(struct hmm_range *range,
> -		       struct mm_struct *mm,
> +		       struct hmm_mirror *mirror,
>   		       unsigned long start,
>   		       unsigned long end,
>   		       unsigned page_shift);
> @@ -541,7 +541,8 @@ static inline bool hmm_vma_range_done(struct hmm_range *range)
>   }
>   
>   /* This is a temporary helper to avoid merge conflict between trees. */
> -static inline int hmm_vma_fault(struct hmm_range *range, bool block)
> +static inline int hmm_vma_fault(struct hmm_mirror *mirror,
> +				struct hmm_range *range, bool block)
>   {
>   	long ret;
>   
> @@ -554,7 +555,7 @@ static inline int hmm_vma_fault(struct hmm_range *range, bool block)
>   	range->default_flags = 0;
>   	range->pfn_flags_mask = -1UL;
>   
> -	ret = hmm_range_register(range, range->vma->vm_mm,
> +	ret = hmm_range_register(range, mirror,
>   				 range->start, range->end,
>   				 PAGE_SHIFT);
>   	if (ret)
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 547002f56a163d..8796447299023c 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -925,13 +925,13 @@ static void hmm_pfns_clear(struct hmm_range *range,
>    * Track updates to the CPU page table see include/linux/hmm.h
>    */
>   int hmm_range_register(struct hmm_range *range,
> -		       struct mm_struct *mm,
> +		       struct hmm_mirror *mirror,
>   		       unsigned long start,
>   		       unsigned long end,
>   		       unsigned page_shift)
>   {
>   	unsigned long mask = ((1UL << page_shift) - 1UL);
> -	struct hmm *hmm;
> +	struct hmm *hmm = mirror->hmm;
>   
>   	range->valid = false;
>   	range->hmm = NULL;
> @@ -945,15 +945,12 @@ int hmm_range_register(struct hmm_range *range,
>   	range->start = start;
>   	range->end = end;
>   
> -	hmm = hmm_get_or_create(mm);
> -	if (!hmm)
> -		return -EFAULT;
> -
>   	/* Check if hmm_mm_destroy() was call. */
> -	if (hmm->mm == NULL || hmm->dead) {
> -		hmm_put(hmm);
> +	if (hmm->mm == NULL || hmm->dead)
>   		return -EFAULT;
> -	}
> +
> +	range->hmm = hmm;
> +	kref_get(&hmm->kref);
>   
>   	/* Initialize range to track CPU page table updates. */
>   	mutex_lock(&hmm->lock);
> 
