Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 486AAEA229
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Oct 2019 17:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfJ3Q70 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Oct 2019 12:59:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:32970 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfJ3Q70 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Oct 2019 12:59:26 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9UGuWWH108547;
        Wed, 30 Oct 2019 16:58:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=keEeUnYROMUeA95knhT+FHD4/E7a1Ew6FHXEch8uzww=;
 b=D1JqQda86dNVGPCQ4AUxb9fjj0QImKbpnU4eXnAq4WKhYhIzGpDbxQPM21NnRfkDSd3q
 GMq2yw4MLnwF8r4yxGrvyWKTS1QGywHwz9Eyqw+QMfJKvP5TQyEdju2DI5xLYQaB5o6z
 q9tb7fptCGUyuQe3aIshog8URVKWfsrb8RBspmlEbJpgW14dlFsRlJZU1sTVn+gh7RY+
 IDpHzotWRV3WUp40BHtSwPtRwPJZujcKjBl/eFBe9OPkQUVHq4rmBgNgsY9PjJxmFLs/
 LV8pmJR+ureH1dB94B1cx7Dxisj4B014VgKDrV4gIKW/c0G0ibxOYatufRDqlocmu1bi JQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2vxwhfdpwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 16:58:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9UGrciw067506;
        Wed, 30 Oct 2019 16:56:32 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2vxwj72q6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 16:56:31 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9UGuOon011005;
        Wed, 30 Oct 2019 16:56:24 GMT
Received: from bostrovs-us.us.oracle.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Oct 2019 09:56:24 -0700
Subject: Re: [PATCH v2 09/15] xen/gntdev: use mmu_range_notifier_insert
To:     Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Petr Cvek <petrcvekcz@gmail.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        nouveau@lists.freedesktop.org, xen-devel@lists.xenproject.org,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@mellanox.com>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-10-jgg@ziepe.ca>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <0355257f-6a3a-cdcd-d206-aec3df97dded@oracle.com>
Date:   Wed, 30 Oct 2019 12:55:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20191028201032.6352-10-jgg@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910300151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910300151
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/28/19 4:10 PM, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
>
> gntdev simply wants to monitor a specific VMA for any notifier events,
> this can be done straightforwardly using mmu_range_notifier_insert() over
> the VMA's VA range.
>
> The notifier should be attached until the original VMA is destroyed.
>
> It is unclear if any of this is even sane, but at least a lot of duplicate
> code is removed.

I didn't have a chance to look at the patch itself yet but as a heads-up
--- it crashes dom0.

-boris


>
> Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: xen-devel@lists.xenproject.org
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  drivers/xen/gntdev-common.h |   8 +-
>  drivers/xen/gntdev.c        | 180 ++++++++++--------------------------
>  2 files changed, 49 insertions(+), 139 deletions(-)
>
> diff --git a/drivers/xen/gntdev-common.h b/drivers/xen/gntdev-common.h
> index 2f8b949c3eeb14..b201fdd20b667b 100644
> --- a/drivers/xen/gntdev-common.h
> +++ b/drivers/xen/gntdev-common.h
> @@ -21,15 +21,8 @@ struct gntdev_dmabuf_priv;
>  struct gntdev_priv {
>  	/* Maps with visible offsets in the file descriptor. */
>  	struct list_head maps;
> -	/*
> -	 * Maps that are not visible; will be freed on munmap.
> -	 * Only populated if populate_freeable_maps == 1
> -	 */
> -	struct list_head freeable_maps;
>  	/* lock protects maps and freeable_maps. */
>  	struct mutex lock;
> -	struct mm_struct *mm;
> -	struct mmu_notifier mn;
>  
>  #ifdef CONFIG_XEN_GRANT_DMA_ALLOC
>  	/* Device for which DMA memory is allocated. */
> @@ -49,6 +42,7 @@ struct gntdev_unmap_notify {
>  };
>  
>  struct gntdev_grant_map {
> +	struct mmu_range_notifier notifier;
>  	struct list_head next;
>  	struct vm_area_struct *vma;
>  	int index;
> diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
> index a446a7221e13e9..12d626670bebbc 100644
> --- a/drivers/xen/gntdev.c
> +++ b/drivers/xen/gntdev.c
> @@ -65,7 +65,6 @@ MODULE_PARM_DESC(limit, "Maximum number of grants that may be mapped by "
>  static atomic_t pages_mapped = ATOMIC_INIT(0);
>  
>  static int use_ptemod;
> -#define populate_freeable_maps use_ptemod
>  
>  static int unmap_grant_pages(struct gntdev_grant_map *map,
>  			     int offset, int pages);
> @@ -251,12 +250,6 @@ void gntdev_put_map(struct gntdev_priv *priv, struct gntdev_grant_map *map)
>  		evtchn_put(map->notify.event);
>  	}
>  
> -	if (populate_freeable_maps && priv) {
> -		mutex_lock(&priv->lock);
> -		list_del(&map->next);
> -		mutex_unlock(&priv->lock);
> -	}
> -
>  	if (map->pages && !use_ptemod)
>  		unmap_grant_pages(map, 0, map->count);
>  	gntdev_free_map(map);
> @@ -445,17 +438,9 @@ static void gntdev_vma_close(struct vm_area_struct *vma)
>  	struct gntdev_priv *priv = file->private_data;
>  
>  	pr_debug("gntdev_vma_close %p\n", vma);
> -	if (use_ptemod) {
> -		/* It is possible that an mmu notifier could be running
> -		 * concurrently, so take priv->lock to ensure that the vma won't
> -		 * vanishing during the unmap_grant_pages call, since we will
> -		 * spin here until that completes. Such a concurrent call will
> -		 * not do any unmapping, since that has been done prior to
> -		 * closing the vma, but it may still iterate the unmap_ops list.
> -		 */
> -		mutex_lock(&priv->lock);
> +	if (use_ptemod && map->vma == vma) {
> +		mmu_range_notifier_remove(&map->notifier);
>  		map->vma = NULL;
> -		mutex_unlock(&priv->lock);
>  	}
>  	vma->vm_private_data = NULL;
>  	gntdev_put_map(priv, map);
> @@ -477,109 +462,44 @@ static const struct vm_operations_struct gntdev_vmops = {
>  
>  /* ------------------------------------------------------------------ */
>  
> -static bool in_range(struct gntdev_grant_map *map,
> -			      unsigned long start, unsigned long end)
> -{
> -	if (!map->vma)
> -		return false;
> -	if (map->vma->vm_start >= end)
> -		return false;
> -	if (map->vma->vm_end <= start)
> -		return false;
> -
> -	return true;
> -}
> -
> -static int unmap_if_in_range(struct gntdev_grant_map *map,
> -			      unsigned long start, unsigned long end,
> -			      bool blockable)
> +static bool gntdev_invalidate(struct mmu_range_notifier *mn,
> +			      const struct mmu_notifier_range *range,
> +			      unsigned long cur_seq)
>  {
> +	struct gntdev_grant_map *map =
> +		container_of(mn, struct gntdev_grant_map, notifier);
>  	unsigned long mstart, mend;
>  	int err;
>  
> -	if (!in_range(map, start, end))
> -		return 0;
> +	if (!mmu_notifier_range_blockable(range))
> +		return false;
>  
> -	if (!blockable)
> -		return -EAGAIN;
> +	/*
> +	 * If the VMA is split or otherwise changed the notifier is not
> +	 * updated, but we don't want to process VA's outside the modified
> +	 * VMA. FIXME: It would be much more understandable to just prevent
> +	 * modifying the VMA in the first place.
> +	 */
> +	if (map->vma->vm_start >= range->end ||
> +	    map->vma->vm_end <= range->start)
> +		return true;
>  
> -	mstart = max(start, map->vma->vm_start);
> -	mend   = min(end,   map->vma->vm_end);
> +	mstart = max(range->start, map->vma->vm_start);
> +	mend = min(range->end, map->vma->vm_end);
>  	pr_debug("map %d+%d (%lx %lx), range %lx %lx, mrange %lx %lx\n",
>  			map->index, map->count,
>  			map->vma->vm_start, map->vma->vm_end,
> -			start, end, mstart, mend);
> +			range->start, range->end, mstart, mend);
>  	err = unmap_grant_pages(map,
>  				(mstart - map->vma->vm_start) >> PAGE_SHIFT,
>  				(mend - mstart) >> PAGE_SHIFT);
>  	WARN_ON(err);
>  
> -	return 0;
> -}
> -
> -static int mn_invl_range_start(struct mmu_notifier *mn,
> -			       const struct mmu_notifier_range *range)
> -{
> -	struct gntdev_priv *priv = container_of(mn, struct gntdev_priv, mn);
> -	struct gntdev_grant_map *map;
> -	int ret = 0;
> -
> -	if (mmu_notifier_range_blockable(range))
> -		mutex_lock(&priv->lock);
> -	else if (!mutex_trylock(&priv->lock))
> -		return -EAGAIN;
> -
> -	list_for_each_entry(map, &priv->maps, next) {
> -		ret = unmap_if_in_range(map, range->start, range->end,
> -					mmu_notifier_range_blockable(range));
> -		if (ret)
> -			goto out_unlock;
> -	}
> -	list_for_each_entry(map, &priv->freeable_maps, next) {
> -		ret = unmap_if_in_range(map, range->start, range->end,
> -					mmu_notifier_range_blockable(range));
> -		if (ret)
> -			goto out_unlock;
> -	}
> -
> -out_unlock:
> -	mutex_unlock(&priv->lock);
> -
> -	return ret;
> -}
> -
> -static void mn_release(struct mmu_notifier *mn,
> -		       struct mm_struct *mm)
> -{
> -	struct gntdev_priv *priv = container_of(mn, struct gntdev_priv, mn);
> -	struct gntdev_grant_map *map;
> -	int err;
> -
> -	mutex_lock(&priv->lock);
> -	list_for_each_entry(map, &priv->maps, next) {
> -		if (!map->vma)
> -			continue;
> -		pr_debug("map %d+%d (%lx %lx)\n",
> -				map->index, map->count,
> -				map->vma->vm_start, map->vma->vm_end);
> -		err = unmap_grant_pages(map, /* offset */ 0, map->count);
> -		WARN_ON(err);
> -	}
> -	list_for_each_entry(map, &priv->freeable_maps, next) {
> -		if (!map->vma)
> -			continue;
> -		pr_debug("map %d+%d (%lx %lx)\n",
> -				map->index, map->count,
> -				map->vma->vm_start, map->vma->vm_end);
> -		err = unmap_grant_pages(map, /* offset */ 0, map->count);
> -		WARN_ON(err);
> -	}
> -	mutex_unlock(&priv->lock);
> +	return true;
>  }
>  
> -static const struct mmu_notifier_ops gntdev_mmu_ops = {
> -	.release                = mn_release,
> -	.invalidate_range_start = mn_invl_range_start,
> +static const struct mmu_range_notifier_ops gntdev_mmu_ops = {
> +	.invalidate = gntdev_invalidate,
>  };
>  
>  /* ------------------------------------------------------------------ */
> @@ -594,7 +514,6 @@ static int gntdev_open(struct inode *inode, struct file *flip)
>  		return -ENOMEM;
>  
>  	INIT_LIST_HEAD(&priv->maps);
> -	INIT_LIST_HEAD(&priv->freeable_maps);
>  	mutex_init(&priv->lock);
>  
>  #ifdef CONFIG_XEN_GNTDEV_DMABUF
> @@ -606,17 +525,6 @@ static int gntdev_open(struct inode *inode, struct file *flip)
>  	}
>  #endif
>  
> -	if (use_ptemod) {
> -		priv->mm = get_task_mm(current);
> -		if (!priv->mm) {
> -			kfree(priv);
> -			return -ENOMEM;
> -		}
> -		priv->mn.ops = &gntdev_mmu_ops;
> -		ret = mmu_notifier_register(&priv->mn, priv->mm);
> -		mmput(priv->mm);
> -	}
> -
>  	if (ret) {
>  		kfree(priv);
>  		return ret;
> @@ -653,16 +561,12 @@ static int gntdev_release(struct inode *inode, struct file *flip)
>  		list_del(&map->next);
>  		gntdev_put_map(NULL /* already removed */, map);
>  	}
> -	WARN_ON(!list_empty(&priv->freeable_maps));
>  	mutex_unlock(&priv->lock);
>  
>  #ifdef CONFIG_XEN_GNTDEV_DMABUF
>  	gntdev_dmabuf_fini(priv->dmabuf_priv);
>  #endif
>  
> -	if (use_ptemod)
> -		mmu_notifier_unregister(&priv->mn, priv->mm);
> -
>  	kfree(priv);
>  	return 0;
>  }
> @@ -723,8 +627,6 @@ static long gntdev_ioctl_unmap_grant_ref(struct gntdev_priv *priv,
>  	map = gntdev_find_map_index(priv, op.index >> PAGE_SHIFT, op.count);
>  	if (map) {
>  		list_del(&map->next);
> -		if (populate_freeable_maps)
> -			list_add_tail(&map->next, &priv->freeable_maps);
>  		err = 0;
>  	}
>  	mutex_unlock(&priv->lock);
> @@ -1096,11 +998,6 @@ static int gntdev_mmap(struct file *flip, struct vm_area_struct *vma)
>  		goto unlock_out;
>  	if (use_ptemod && map->vma)
>  		goto unlock_out;
> -	if (use_ptemod && priv->mm != vma->vm_mm) {
> -		pr_warn("Huh? Other mm?\n");
> -		goto unlock_out;
> -	}
> -
>  	refcount_inc(&map->users);
>  
>  	vma->vm_ops = &gntdev_vmops;
> @@ -1111,10 +1008,6 @@ static int gntdev_mmap(struct file *flip, struct vm_area_struct *vma)
>  		vma->vm_flags |= VM_DONTCOPY;
>  
>  	vma->vm_private_data = map;
> -
> -	if (use_ptemod)
> -		map->vma = vma;
> -
>  	if (map->flags) {
>  		if ((vma->vm_flags & VM_WRITE) &&
>  				(map->flags & GNTMAP_readonly))
> @@ -1125,8 +1018,28 @@ static int gntdev_mmap(struct file *flip, struct vm_area_struct *vma)
>  			map->flags |= GNTMAP_readonly;
>  	}
>  
> +	if (use_ptemod) {
> +		map->vma = vma;
> +		err = mmu_range_notifier_insert_locked(
> +			&map->notifier, vma->vm_start,
> +			vma->vm_end - vma->vm_start, vma->vm_mm);
> +		if (err)
> +			goto out_unlock_put;
> +	}
>  	mutex_unlock(&priv->lock);
>  
> +	/*
> +	 * gntdev takes the address of the PTE in find_grant_ptes() and passes
> +	 * it to the hypervisor in gntdev_map_grant_pages(). The purpose of
> +	 * the notifier is to prevent the hypervisor pointer to the PTE from
> +	 * going stale.
> +	 *
> +	 * Since this vma's mappings can't be touched without the mmap_sem,
> +	 * and we are holding it now, there is no need for the notifier_range
> +	 * locking pattern.
> +	 */
> +	mmu_range_read_begin(&map->notifier);
> +
>  	if (use_ptemod) {
>  		map->pages_vm_start = vma->vm_start;
>  		err = apply_to_page_range(vma->vm_mm, vma->vm_start,
> @@ -1175,8 +1088,11 @@ static int gntdev_mmap(struct file *flip, struct vm_area_struct *vma)
>  	mutex_unlock(&priv->lock);
>  out_put_map:
>  	if (use_ptemod) {
> -		map->vma = NULL;
>  		unmap_grant_pages(map, 0, map->count);
> +		if (map->vma) {
> +			mmu_range_notifier_remove(&map->notifier);
> +			map->vma = NULL;
> +		}
>  	}
>  	gntdev_put_map(priv, map);
>  	return err;

