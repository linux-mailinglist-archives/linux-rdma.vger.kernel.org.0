Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A141F36A765
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Apr 2021 15:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhDYNEa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 25 Apr 2021 09:04:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229688AbhDYNEa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 25 Apr 2021 09:04:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 376DB61360;
        Sun, 25 Apr 2021 13:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619355830;
        bh=SlHzui/IXNs3I0iMECo2Xdyzv72vCl8Gukhb8hYsLko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZQ78ix/XwnD82A2FybloMvnthLgyzr9EoxPahHoe2UCWcsJusTId2u95/WwhIMY6r
         uXHhWRZ/z++UiTiJ2GfPf2VpTtQTNeNz7fUNuhpKwEYMI9riHxecwRiMpUV5Tx2LGa
         KMJEt9fHcdQXQNF+mYb5QluLkYDeBJOkZ8vQ+Rjq+2eG1YTv602o3NLRIKWzIopPKD
         GMj5Wu52mBwb/UXInbGsnw4scvewPv8azGP1EsO14jSs5JwTXEPWXU1QexNCkSc6gA
         jHfRBsPFonzrg0XdQAGykbp8hVr9jhM9ArnlNV4MSJD3pEZQaTTk9Y5gegAN/P6+I3
         og0NUWHlL25pw==
Date:   Sun, 25 Apr 2021 16:03:47 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, Shay Drory <shayd@nvidia.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/restrack: Delay QP deletion till all
 users are gone
Message-ID: <YIVosxurbZGlmCOw@unreal>
References: <9ba5a611ceac86774d3d0fda12704cecc30606f9.1618753038.git.leonro@nvidia.com>
 <20210420123950.GA2138447@nvidia.com>
 <YH7Ru5ZSr1kWGZoa@unreal>
 <20210420152541.GC1370958@nvidia.com>
 <YH+yGj3cLuA5ga8s@unreal>
 <20210422142939.GA2407382@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422142939.GA2407382@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 22, 2021 at 11:29:39AM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 21, 2021 at 08:03:22AM +0300, Leon Romanovsky wrote:
> 
> > I didn't understand when reviewed either, but decided to post it anyway
> > to get possible explanation for this RDMA_RESTRACK_MR || RDMA_RESTRACK_QP
> > check.
> 
> I think the whole thing should look more like this and we delete the
> if entirely.

I have mixed feelings about this approach. Before "destroy can fail disaster",
the restrack goal was to provide the following flow:
1. create new memory object - rdma_restrack_new()
2. create new HW object - .create_XXX() callback in the driver
3. add HW object to the DB - rdma_restrack_del()
....
4. wait for any work on this HW object to complete - rdma_restrack_del()
5. safely destroy HW object - .destroy_XXX()

I really would like to stay with this flow and block any access to the
object that failed to destruct - maybe add to some zombie list.

The proposed prepare/abort/finish flow is much harder to implement correctly.
Let's take as an example ib_destroy_qp_user(), we called to rdma_rw_cleanup_mrs(),
but didn't restore them after .destroy_qp() failure.

Thanks

> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index 2b9ffc21cbc4ad..479b16b8f6723a 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -1860,6 +1860,7 @@ static void _destroy_id(struct rdma_id_private *id_priv,
>  				iw_destroy_cm_id(id_priv->cm_id.iw);
>  		}
>  		cma_leave_mc_groups(id_priv);
> +		rdma_restrack_del(&id_priv->res);
>  		cma_release_dev(id_priv);
>  	}
>  
> @@ -1873,7 +1874,6 @@ static void _destroy_id(struct rdma_id_private *id_priv,
>  	kfree(id_priv->id.route.path_rec);
>  
>  	put_net(id_priv->id.route.addr.dev_addr.net);
> -	rdma_restrack_del(&id_priv->res);
>  	kfree(id_priv);
>  }
>  
> diff --git a/drivers/infiniband/core/counters.c b/drivers/infiniband/core/counters.c
> index 15493357cfef09..1808bc2533f155 100644
> --- a/drivers/infiniband/core/counters.c
> +++ b/drivers/infiniband/core/counters.c
> @@ -176,6 +176,8 @@ static void rdma_counter_free(struct rdma_counter *counter)
>  {
>  	struct rdma_port_counter *port_counter;
>  
> +	rdma_restrack_del(&counter->res);
> +
>  	port_counter = &counter->device->port_data[counter->port].port_counter;
>  	mutex_lock(&port_counter->lock);
>  	port_counter->num_counters--;
> @@ -185,7 +187,6 @@ static void rdma_counter_free(struct rdma_counter *counter)
>  
>  	mutex_unlock(&port_counter->lock);
>  
> -	rdma_restrack_del(&counter->res);
>  	kfree(counter->stats);
>  	kfree(counter);
>  }
> diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
> index 433b426729d4ce..3884db637d33ab 100644
> --- a/drivers/infiniband/core/cq.c
> +++ b/drivers/infiniband/core/cq.c
> @@ -339,11 +339,15 @@ void ib_free_cq(struct ib_cq *cq)
>  		WARN_ON_ONCE(1);
>  	}
>  
> +	rdma_restrack_prepare_del(&cq->res);
>  	rdma_dim_destroy(cq);
>  	trace_cq_free(cq);
>  	ret = cq->device->ops.destroy_cq(cq, NULL);
> -	WARN_ONCE(ret, "Destroy of kernel CQ shouldn't fail");
> -	rdma_restrack_del(&cq->res);
> +	if (WARN_ON(ret)) {
> +		rdma_restrack_abort_del(&cq->res);
> +		return;
> +	}
> +	rdma_restrack_finish_del(&cq->res);
>  	kfree(cq->wc);
>  	kfree(cq);
>  }
> diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
> index 94d83b665a2fe0..f57234ced93ca1 100644
> --- a/drivers/infiniband/core/rdma_core.c
> +++ b/drivers/infiniband/core/rdma_core.c
> @@ -854,6 +854,8 @@ static void ufile_destroy_ucontext(struct ib_uverbs_file *ufile,
>  	struct ib_ucontext *ucontext = ufile->ucontext;
>  	struct ib_device *ib_dev = ucontext->device;
>  
> +	rdma_restrack_prepare_del(&ucontext->res);
> +
>  	/*
>  	 * If we are closing the FD then the user mmap VMAs must have
>  	 * already been destroyed as they hold on to the filep, otherwise
> @@ -868,9 +870,8 @@ static void ufile_destroy_ucontext(struct ib_uverbs_file *ufile,
>  	ib_rdmacg_uncharge(&ucontext->cg_obj, ib_dev,
>  			   RDMACG_RESOURCE_HCA_HANDLE);
>  
> -	rdma_restrack_del(&ucontext->res);
> -
>  	ib_dev->ops.dealloc_ucontext(ucontext);
> +	rdma_restrack_finish_del(&ucontext->res);
>  	WARN_ON(!xa_empty(&ucontext->mmap_xa));
>  	kfree(ucontext);
>  
> diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
> index 033207882c82ce..8aa1dae40f38a7 100644
> --- a/drivers/infiniband/core/restrack.c
> +++ b/drivers/infiniband/core/restrack.c
> @@ -315,11 +315,49 @@ int rdma_restrack_put(struct rdma_restrack_entry *res)
>  }
>  EXPORT_SYMBOL(rdma_restrack_put);
>  
> -/**
> - * rdma_restrack_del() - delete object from the reource tracking database
> - * @res:  resource entry
> - */
> -void rdma_restrack_del(struct rdma_restrack_entry *res)
> +void rdma_restrack_prepare_del(struct rdma_restrack_entry *res)
> +{
> +	struct rdma_restrack_entry *old;
> +	struct rdma_restrack_root *rt;
> +	struct ib_device *dev;
> +
> +	if (!res->valid)
> +		return;
> +
> +	dev = res_to_dev(res);
> +	rt = &dev->res[res->type];
> +
> +	if (!res->no_track) {
> +		old = xa_cmpxchg(&rt->xa, res->id, res, XA_ZERO_ENTRY,
> +				 GFP_KERNEL);
> +		WARN_ON(old != res);
> +	}
> +
> +	/* Fence access from all concurrent threads, like netlink */
> +	rdma_restrack_put(res);
> +	wait_for_completion(&res->comp);
> +}
> +EXPORT_SYMBOL(rdma_restrack_prepare_del);
> +
> +void rdma_restrack_abort_del(struct rdma_restrack_entry *res)
> +{
> +	struct rdma_restrack_entry *old;
> +	struct rdma_restrack_root *rt;
> +	struct ib_device *dev;
> +
> +	if (!res->valid || res->no_track)
> +		return;
> +
> +	dev = res_to_dev(res);
> +	rt = &dev->res[res->type];
> +
> +	kref_init(&res->kref);
> +	old = xa_cmpxchg(&rt->xa, res->id, XA_ZERO_ENTRY, res, GFP_KERNEL);
> +	WARN_ON(old != res);
> +}
> +EXPORT_SYMBOL(rdma_restrack_abort_del);
> +
> +void rdma_restrack_finish_del(struct rdma_restrack_entry *res)
>  {
>  	struct rdma_restrack_entry *old;
>  	struct rdma_restrack_root *rt;
> @@ -332,24 +370,22 @@ void rdma_restrack_del(struct rdma_restrack_entry *res)
>  		}
>  		return;
>  	}
> -
> -	if (res->no_track)
> -		goto out;
> +	res->valid = false;
>  
>  	dev = res_to_dev(res);
> -	if (WARN_ON(!dev))
> -		return;
> -
>  	rt = &dev->res[res->type];
> -
>  	old = xa_erase(&rt->xa, res->id);
> -	if (res->type == RDMA_RESTRACK_MR || res->type == RDMA_RESTRACK_QP)
> -		return;
> -	WARN_ON(old != res);
> +	WARN_ON(old != NULL);
> +}
> +EXPORT_SYMBOL(rdma_restrack_finish_del);
>  
> -out:
> -	res->valid = false;
> -	rdma_restrack_put(res);
> -	wait_for_completion(&res->comp);
> +/**
> + * rdma_restrack_del() - delete object from the reource tracking database
> + * @res:  resource entry
> + */
> +void rdma_restrack_del(struct rdma_restrack_entry *res)
> +{
> +	rdma_restrack_prepare_del(res);
> +	rdma_restrack_finish_del(res);
>  }
>  EXPORT_SYMBOL(rdma_restrack_del);
> diff --git a/drivers/infiniband/core/restrack.h b/drivers/infiniband/core/restrack.h
> index 6a04fc41f73801..87a670334acabe 100644
> --- a/drivers/infiniband/core/restrack.h
> +++ b/drivers/infiniband/core/restrack.h
> @@ -27,6 +27,9 @@ int rdma_restrack_init(struct ib_device *dev);
>  void rdma_restrack_clean(struct ib_device *dev);
>  void rdma_restrack_add(struct rdma_restrack_entry *res);
>  void rdma_restrack_del(struct rdma_restrack_entry *res);
> +void rdma_restrack_prepare_del(struct rdma_restrack_entry *res);
> +void rdma_restrack_finish_del(struct rdma_restrack_entry *res);
> +void rdma_restrack_abort_del(struct rdma_restrack_entry *res);
>  void rdma_restrack_new(struct rdma_restrack_entry *res,
>  		       enum rdma_restrack_type type);
>  void rdma_restrack_set_name(struct rdma_restrack_entry *res,
> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> index 2b0798151fb753..2e761a7eb92847 100644
> --- a/drivers/infiniband/core/verbs.c
> +++ b/drivers/infiniband/core/verbs.c
> @@ -346,13 +346,16 @@ int ib_dealloc_pd_user(struct ib_pd *pd, struct ib_udata *udata)
>  	 */
>  	WARN_ON(atomic_read(&pd->usecnt));
>  
> +	rdma_restrack_prepare_del(&pd->res);
>  	ret = pd->device->ops.dealloc_pd(pd, udata);
> -	if (ret)
> +	if (ret) {
> +		rdma_restrack_abort_del(&pd->res);
>  		return ret;
> +	}
>  
> -	rdma_restrack_del(&pd->res);
> +	rdma_restrack_finish_del(&pd->res);
>  	kfree(pd);
> -	return ret;
> +	return 0;
>  }
>  EXPORT_SYMBOL(ib_dealloc_pd_user);
>  
> @@ -1085,19 +1088,22 @@ int ib_destroy_srq_user(struct ib_srq *srq, struct ib_udata *udata)
>  	if (atomic_read(&srq->usecnt))
>  		return -EBUSY;
>  
> +	rdma_restrack_prepare_del(&srq->res);
>  	ret = srq->device->ops.destroy_srq(srq, udata);
> -	if (ret)
> +	if (ret) {
> +		rdma_restrack_abort_del(&srq->res);
>  		return ret;
> +	}
> +	rdma_restrack_finish_del(&srq->res);
>  
>  	atomic_dec(&srq->pd->usecnt);
>  	if (srq->srq_type == IB_SRQT_XRC)
>  		atomic_dec(&srq->ext.xrc.xrcd->usecnt);
>  	if (ib_srq_has_cq(srq->srq_type))
>  		atomic_dec(&srq->ext.cq->usecnt);
> -	rdma_restrack_del(&srq->res);
>  	kfree(srq);
>  
> -	return ret;
> +	return 0;
>  }
>  EXPORT_SYMBOL(ib_destroy_srq_user);
>  
> @@ -1963,31 +1969,33 @@ int ib_destroy_qp_user(struct ib_qp *qp, struct ib_udata *udata)
>  		rdma_rw_cleanup_mrs(qp);
>  
>  	rdma_counter_unbind_qp(qp, true);
> -	rdma_restrack_del(&qp->res);
> +	rdma_restrack_prepare_del(&qp->res);
>  	ret = qp->device->ops.destroy_qp(qp, udata);
> -	if (!ret) {
> -		if (alt_path_sgid_attr)
> -			rdma_put_gid_attr(alt_path_sgid_attr);
> -		if (av_sgid_attr)
> -			rdma_put_gid_attr(av_sgid_attr);
> -		if (pd)
> -			atomic_dec(&pd->usecnt);
> -		if (scq)
> -			atomic_dec(&scq->usecnt);
> -		if (rcq)
> -			atomic_dec(&rcq->usecnt);
> -		if (srq)
> -			atomic_dec(&srq->usecnt);
> -		if (ind_tbl)
> -			atomic_dec(&ind_tbl->usecnt);
> -		if (sec)
> -			ib_destroy_qp_security_end(sec);
> -	} else {
> +	if (ret) {
> +		rdma_restrack_abort_del(&qp->res);
>  		if (sec)
>  			ib_destroy_qp_security_abort(sec);
> +		return ret;
>  	}
>  
> -	return ret;
> +	rdma_restrack_finish_del(&qp->res);
> +	if (alt_path_sgid_attr)
> +		rdma_put_gid_attr(alt_path_sgid_attr);
> +	if (av_sgid_attr)
> +		rdma_put_gid_attr(av_sgid_attr);
> +	if (pd)
> +		atomic_dec(&pd->usecnt);
> +	if (scq)
> +		atomic_dec(&scq->usecnt);
> +	if (rcq)
> +		atomic_dec(&rcq->usecnt);
> +	if (srq)
> +		atomic_dec(&srq->usecnt);
> +	if (ind_tbl)
> +		atomic_dec(&ind_tbl->usecnt);
> +	if (sec)
> +		ib_destroy_qp_security_end(sec);
> +	return 0;
>  }
>  EXPORT_SYMBOL(ib_destroy_qp_user);
>  
> @@ -2050,13 +2058,16 @@ int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
>  	if (atomic_read(&cq->usecnt))
>  		return -EBUSY;
>  
> +	rdma_restrack_prepare_del(&cq->res);
>  	ret = cq->device->ops.destroy_cq(cq, udata);
> -	if (ret)
> +	if (ret) {
> +		rdma_restrack_abort_del(&cq->res);
>  		return ret;
> +	}
>  
> -	rdma_restrack_del(&cq->res);
> +	rdma_restrack_finish_del(&cq->res);
>  	kfree(cq);
> -	return ret;
> +	return 0;
>  }
>  EXPORT_SYMBOL(ib_destroy_cq_user);
>  
> @@ -2126,16 +2137,19 @@ int ib_dereg_mr_user(struct ib_mr *mr, struct ib_udata *udata)
>  	int ret;
>  
>  	trace_mr_dereg(mr);
> -	rdma_restrack_del(&mr->res);
> +	rdma_restrack_prepare_del(&mr->res);
>  	ret = mr->device->ops.dereg_mr(mr, udata);
> -	if (!ret) {
> -		atomic_dec(&pd->usecnt);
> -		if (dm)
> -			atomic_dec(&dm->usecnt);
> -		kfree(sig_attrs);
> +	if (ret) {
> +		rdma_restrack_abort_del(&mr->res);
> +		return ret;
>  	}
>  
> -	return ret;
> +	rdma_restrack_finish_del(&mr->res);
> +	atomic_dec(&pd->usecnt);
> +	if (dm)
> +		atomic_dec(&dm->usecnt);
> +	kfree(sig_attrs);
> +	return 0;
>  }
>  EXPORT_SYMBOL(ib_dereg_mr_user);
>  
