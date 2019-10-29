Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53DFAE8DF0
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 18:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390752AbfJ2RUA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 13:20:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42174 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390744AbfJ2RUA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Oct 2019 13:20:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id a15so2263979wrf.9
        for <linux-rdma@vger.kernel.org>; Tue, 29 Oct 2019 10:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+7k6Tgo7zdAI3sdkV2vUab4Qg2cErY2tDGH+QpqLC8g=;
        b=kMvDAfqNMsgwLVSlQz2HGv5SXkrMFIA/sC5PQVA0qHCk2uNpr3vgteNY32KO6XolN9
         jrYaAZAZBspll0O/IT//xBGYiWDFZD8KU1uPmY2vK3KPsyhTb7mzyGHCGTLByQgbXpOx
         OeloXmN2vq/6bG5ZHNwG845uL6ZvA2Sdmd4uYMZ4E+4NJ7wccdnycw840yvcV4FBt6VL
         /xrA8JLUiBY/5hX+ugxid7ZLni4gqfgl/j7jRF06f5phYKlyiq6OI+yIzaRotZfKsIyc
         R7JU0GMg+/jruClJEMts6SYQJZeL4C+Qp1GS1gxReNthE6HvcZsnnoBEcT3avouO/n1H
         WYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=+7k6Tgo7zdAI3sdkV2vUab4Qg2cErY2tDGH+QpqLC8g=;
        b=D2Xu/1BwYb28of9oBY4/Q5vniZw1rnGyEuKA1LM8X0sauhU+nGvLWm/OhY5GKDb5dr
         fdAw/rYofM7Mn68cqlZAZ9MKWB5tg0lzUdUCCO739hR3b58mACdbdaZeJPoCwzP/DWkz
         +iy3wqnJyO8RyiNKLopNNo49oF3UCPeixU11JLbH1amNw/NLfesWGkGDlad+BcgIx44e
         BBNJXQic+5Jouu8Dx7tqvC1E1TrwHWBsSoGsJxx7YEmub0cCazgaquBBbv8PBiOZt4Y8
         vDT1YEwd+cr2TOU4BSozEV9nyKqMFyy2v1V56cywdm/93KdXnBIGnqcR98a1HcjgKAdz
         ZxIA==
X-Gm-Message-State: APjAAAVfFaRpXRo30FqCZ5l5leJws4mjZvHGBwJzZXzCboJLhxpHCren
        1HG4oLCXdKs3g2UzqNQoM4g=
X-Google-Smtp-Source: APXvYqyE7qwpgL7KV62AOaDM+oFRQdWcTDjdZKuljhwWYaRRqCfiSc2s9/fNi7ZWZZwXl8hUkkgUgA==
X-Received: by 2002:adf:ef0a:: with SMTP id e10mr20205293wro.234.1572369597497;
        Tue, 29 Oct 2019 10:19:57 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id f8sm3544088wmb.37.2019.10.29.10.19.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 10:19:56 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH v2 12/15] drm/amdgpu: Call find_vma under mmap_sem
To:     "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     Juergen Gross <jgross@suse.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Petr Cvek <petrcvekcz@gmail.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-13-jgg@ziepe.ca>
 <a368d1bf-ba69-bb63-2bfd-b674acc2f19b@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <cd0507d9-80b9-34fc-1cd3-12d90ee65c21@gmail.com>
Date:   Tue, 29 Oct 2019 14:07:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <a368d1bf-ba69-bb63-2bfd-b674acc2f19b@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am 29.10.19 um 17:28 schrieb Kuehling, Felix:
> On 2019-10-28 4:10 p.m., Jason Gunthorpe wrote:
>> From: Jason Gunthorpe <jgg@mellanox.com>
>>
>> find_vma() must be called under the mmap_sem, reorganize this code to
>> do the vma check after entering the lock.
>>
>> Further, fix the unlocked use of struct task_struct's mm, instead use
>> the mm from hmm_mirror which has an active mm_grab. Also the mm_grab
>> must be converted to a mm_get before acquiring mmap_sem or calling
>> find_vma().
>>
>> Fixes: 66c45500bfdc ("drm/amdgpu: use new HMM APIs and helpers")
>> Fixes: 0919195f2b0d ("drm/amdgpu: Enable amdgpu_ttm_tt_get_user_pages in worker threads")
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: David (ChunMing) Zhou <David1.Zhou@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org
>> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> One question inline to confirm my understanding. Otherwise this patch is
>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 37 ++++++++++++++-----------
>>    1 file changed, 21 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index dff41d0a85fe96..c0e41f1f0c2365 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -35,6 +35,7 @@
>>    #include <linux/hmm.h>
>>    #include <linux/pagemap.h>
>>    #include <linux/sched/task.h>
>> +#include <linux/sched/mm.h>
>>    #include <linux/seq_file.h>
>>    #include <linux/slab.h>
>>    #include <linux/swap.h>
>> @@ -788,7 +789,7 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
>>    	struct hmm_mirror *mirror = bo->mn ? &bo->mn->mirror : NULL;
>>    	struct ttm_tt *ttm = bo->tbo.ttm;
>>    	struct amdgpu_ttm_tt *gtt = (void *)ttm;
>> -	struct mm_struct *mm = gtt->usertask->mm;
>> +	struct mm_struct *mm;
>>    	unsigned long start = gtt->userptr;
>>    	struct vm_area_struct *vma;
>>    	struct hmm_range *range;
>> @@ -796,25 +797,14 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
>>    	uint64_t *pfns;
>>    	int r = 0;
>>    
>> -	if (!mm) /* Happens during process shutdown */
>> -		return -ESRCH;
>> -
>>    	if (unlikely(!mirror)) {
>>    		DRM_DEBUG_DRIVER("Failed to get hmm_mirror\n");
>> -		r = -EFAULT;
>> -		goto out;
>> +		return -EFAULT;
>>    	}
>>    
>> -	vma = find_vma(mm, start);
>> -	if (unlikely(!vma || start < vma->vm_start)) {
>> -		r = -EFAULT;
>> -		goto out;
>> -	}
>> -	if (unlikely((gtt->userflags & AMDGPU_GEM_USERPTR_ANONONLY) &&
>> -		vma->vm_file)) {
>> -		r = -EPERM;
>> -		goto out;
>> -	}
>> +	mm = mirror->hmm->mmu_notifier.mm;
>> +	if (!mmget_not_zero(mm)) /* Happens during process shutdown */
> This works because mirror->hmm->mmu_notifier holds an mmgrab reference
> to the mm? So the MM will not just go away, but if the mmget refcount is
> 0, it means the mm is marked for destruction and shouldn't be used any more.

Yes, exactly. That is a rather common pattern, one reference count for 
the functionality and one for the structure.

When the functionality is gone the structure might still be alive for 
some reason. TTM and a couple of other structures use the same approach.

Christian.

>
>
>> +		return -ESRCH;
>>    
>>    	range = kzalloc(sizeof(*range), GFP_KERNEL);
>>    	if (unlikely(!range)) {
>> @@ -847,6 +837,17 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
>>    	hmm_range_wait_until_valid(range, HMM_RANGE_DEFAULT_TIMEOUT);
>>    
>>    	down_read(&mm->mmap_sem);
>> +	vma = find_vma(mm, start);
>> +	if (unlikely(!vma || start < vma->vm_start)) {
>> +		r = -EFAULT;
>> +		goto out_unlock;
>> +	}
>> +	if (unlikely((gtt->userflags & AMDGPU_GEM_USERPTR_ANONONLY) &&
>> +		vma->vm_file)) {
>> +		r = -EPERM;
>> +		goto out_unlock;
>> +	}
>> +
>>    	r = hmm_range_fault(range, 0);
>>    	up_read(&mm->mmap_sem);
>>    
>> @@ -865,15 +866,19 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
>>    	}
>>    
>>    	gtt->range = range;
>> +	mmput(mm);
>>    
>>    	return 0;
>>    
>> +out_unlock:
>> +	up_read(&mm->mmap_sem);
>>    out_free_pfns:
>>    	hmm_range_unregister(range);
>>    	kvfree(pfns);
>>    out_free_ranges:
>>    	kfree(range);
>>    out:
>> +	mmput(mm);
>>    	return r;
>>    }
>>    
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

