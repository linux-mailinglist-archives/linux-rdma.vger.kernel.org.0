Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB73D40BC1B
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Sep 2021 01:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbhINXTT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Sep 2021 19:19:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231177AbhINXTS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Sep 2021 19:19:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FF0860F6F;
        Tue, 14 Sep 2021 23:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631661480;
        bh=TeUjkgBTP3sIQTSJGSHh8y4gzMkgC/DCqfJ9lAa3qbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TUvaEMttlfNNCHy6tpgKOeuH7BFlZBKjmuy43ZnslGKnQD54P/kZBLmIHMNJOsfoQ
         C1+RUCYBpjwFpIdwNV+BRmzSJGu93IgR/vvhDwXPOUS6iIZ26rcMBMs85Rkv6hegFi
         UVj8ly2Una/zT0M9k3jKIbfGmsUXhx+kECDEfXs2Mbu8fePce6BXB9Szh/u4rnKMif
         joib5onQV05NLYcMwiO6SItHpg4/8b8f920rS1k6goONL08SbyDiatYJGFhtKKbBGQ
         T3+XBK66uBd/jdsDRXoQISEk05u2juNtSK+NX8DbIIOkV1liUPlQClRgXj0Rv5asxQ
         I3XvwRDqVFG6w==
Date:   Wed, 15 Sep 2021 02:17:56 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Tao Liu <thomas.liu@ucloud.cn>, dledford@redhat.com,
        haakon.bugge@oracle.com, shayd@nvidia.com, avihaih@nvidia.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.liu@ucloud.com
Subject: Re: [PATCH] RDMA/cma: Fix listener leak in rdma_cma_listen_on_all()
 failure
Message-ID: <YUEtpNgI+Z8ksQjC@unreal>
References: <20210913093344.17230-1-thomas.liu@ucloud.cn>
 <20210914195444.GA156389@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914195444.GA156389@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 14, 2021 at 04:54:44PM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 13, 2021 at 05:33:44PM +0800, Tao Liu wrote:
> > rdma_cma_listen_on_all() just destroy listener which lead to an error,
> > but not including those already added in listen_list. Then cm state
> > fallbacks to RDMA_CM_ADDR_BOUND.
> > 
> > When user destroys id, the listeners will not be destroyed, and
> > process stucks.
> > 
> >  task:rping state:D stack:   0 pid:19605 ppid: 47036 flags:0x00000084
> >  Call Trace:
> >   __schedule+0x29a/0x780
> >   ? free_unref_page_commit+0x9b/0x110
> >   schedule+0x3c/0xa0
> >   schedule_timeout+0x215/0x2b0
> >   ? __flush_work+0x19e/0x1e0
> >   wait_for_completion+0x8d/0xf0
> >   _destroy_id+0x144/0x210 [rdma_cm]
> >   ucma_close_id+0x2b/0x40 [rdma_ucm]
> >   __destroy_id+0x93/0x2c0 [rdma_ucm]
> >   ? __xa_erase+0x4a/0xa0
> >   ucma_destroy_id+0x9a/0x120 [rdma_ucm]
> >   ucma_write+0xb8/0x130 [rdma_ucm]
> >   vfs_write+0xb4/0x250
> >   ksys_write+0xb5/0xd0
> >   ? syscall_trace_enter.isra.19+0x123/0x190
> >   do_syscall_64+0x33/0x40
> >   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > 
> > Fixes: c80a0c52d85c ("RDMA/cma: Add missing error handling of listen_id")
> > Signed-off-by: Tao Liu <thomas.liu@ucloud.cn>
> > Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> >  drivers/infiniband/core/cma.c | 22 +++++++++++++++-------
> >  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> I'd like to see a bit more than this, I reworked the patch slightly
> into this below. It is in for-rc so let me know if it busted up. Thanks
> 
> From a17a1faf5d3e2e19a75397dfd740dbde06f054c3 Mon Sep 17 00:00:00 2001
> From: Tao Liu <thomas.liu@ucloud.cn>
> Date: Mon, 13 Sep 2021 17:33:44 +0800
> Subject: [PATCH] RDMA/cma: Fix listener leak in rdma_cma_listen_on_all()
>  failure
> 
> If cma_listen_on_all() fails it leaves the per-device ID still on the
> listen_list but the state is not set to RDMA_CM_ADDR_BOUND.
> 
> When the cmid is eventually destroyed cma_cancel_listens() is not called
> due to the wrong state, however the per-device IDs are still holding the
> refcount preventing the ID from being destroyed, thus deadlocking:
> 
>  task:rping state:D stack:   0 pid:19605 ppid: 47036 flags:0x00000084
>  Call Trace:
>   __schedule+0x29a/0x780
>   ? free_unref_page_commit+0x9b/0x110
>   schedule+0x3c/0xa0
>   schedule_timeout+0x215/0x2b0
>   ? __flush_work+0x19e/0x1e0
>   wait_for_completion+0x8d/0xf0
>   _destroy_id+0x144/0x210 [rdma_cm]
>   ucma_close_id+0x2b/0x40 [rdma_ucm]
>   __destroy_id+0x93/0x2c0 [rdma_ucm]
>   ? __xa_erase+0x4a/0xa0
>   ucma_destroy_id+0x9a/0x120 [rdma_ucm]
>   ucma_write+0xb8/0x130 [rdma_ucm]
>   vfs_write+0xb4/0x250
>   ksys_write+0xb5/0xd0
>   ? syscall_trace_enter.isra.19+0x123/0x190
>   do_syscall_64+0x33/0x40
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Ensure that cma_listen_on_all() atomically unwinds its action under the
> lock during error and reorganize how destroy_id works to be directly
> sensitive to the listen list not indirectly through the state and some
> other random collection of variables.
> 
> Fixes: c80a0c52d85c ("RDMA/cma: Add missing error handling of listen_id")
> Link: https://lore.kernel.org/r/20210913093344.17230-1-thomas.liu@ucloud.cn
> Signed-off-by: Tao Liu <thomas.liu@ucloud.cn>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/core/cma.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index 86ee3b01b3ee47..be6beee1dd4c5e 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -1746,16 +1746,17 @@ static void cma_cancel_route(struct rdma_id_private *id_priv)
>  	}
>  }
>  
> -static void cma_cancel_listens(struct rdma_id_private *id_priv)
> +static void _cma_cancel_listens(struct rdma_id_private *id_priv)
>  {
>  	struct rdma_id_private *dev_id_priv;
>  
> +	lockdep_assert_held(&lock);
> +
>  	/*
>  	 * Remove from listen_any_list to prevent added devices from spawning
>  	 * additional listen requests.
>  	 */
> -	mutex_lock(&lock);
> -	list_del(&id_priv->list);
> +	list_del_init(&id_priv->list);
>  
>  	while (!list_empty(&id_priv->listen_list)) {
>  		dev_id_priv = list_entry(id_priv->listen_list.next,
> @@ -1768,6 +1769,20 @@ static void cma_cancel_listens(struct rdma_id_private *id_priv)
>  		rdma_destroy_id(&dev_id_priv->id);
>  		mutex_lock(&lock);
>  	}
> +}
> +
> +static void cma_cancel_listens(struct rdma_id_private *id_priv)
> +{
> +	/*
> +	 * During _destroy_id() it is not possible for this value to transition
> +	 * from empty to !empty, test it outside to lock to avoid taking a
> +	 * global lock on every destroy. Only listen all cases will have
> +	 * something to do
> +	 */
> +	if (list_empty(&id_priv->list))
> +		return;

IMHO, it is better do not do such check outside of the lock without real
gain. It is too subtle to rely on _destroy_id() behaviour.

Thanks

> +	mutex_lock(&lock);
> +	_cma_cancel_listens(id_priv);
>  	mutex_unlock(&lock);
>  }
>  
> @@ -1781,10 +1796,6 @@ static void cma_cancel_operation(struct rdma_id_private *id_priv,
>  	case RDMA_CM_ROUTE_QUERY:
>  		cma_cancel_route(id_priv);
>  		break;
> -	case RDMA_CM_LISTEN:
> -		if (cma_any_addr(cma_src_addr(id_priv)) && !id_priv->cma_dev)
> -			cma_cancel_listens(id_priv);
> -		break;
>  	default:
>  		break;
>  	}
> @@ -1855,6 +1866,7 @@ static void cma_leave_mc_groups(struct rdma_id_private *id_priv)
>  static void _destroy_id(struct rdma_id_private *id_priv,
>  			enum rdma_cm_state state)
>  {
> +	cma_cancel_listens(id_priv);
>  	cma_cancel_operation(id_priv, state);
>  
>  	rdma_restrack_del(&id_priv->res);
> @@ -2579,7 +2591,7 @@ static int cma_listen_on_all(struct rdma_id_private *id_priv)
>  	return 0;
>  
>  err_listen:
> -	list_del(&id_priv->list);
> +	_cma_cancel_listens(id_priv);
>  	mutex_unlock(&lock);
>  	if (to_destroy)
>  		rdma_destroy_id(&to_destroy->id);
> -- 
> 2.33.0
> 
