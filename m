Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 788AD1FF9D
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2019 08:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfEPGif (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 May 2019 02:38:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbfEPGif (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 May 2019 02:38:35 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FE2B2082E;
        Thu, 16 May 2019 06:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557988713;
        bh=DTPtnKF8uErt/xa49TCdR45QUbmz5u9NK4byrX2yBPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pT25qABxadRdRpVAKMSBJbJtc5Vj5Qns4pBmte37qzhTGPVVjJC8wQcP9c5oQb9cL
         uFkqjhIkJAuH2XC4PBnoQUTmXxdYHR+4VI4KEfVbf8M/hln50gS8GiaCjJPZbi9VQ2
         oS7NigoLqfKsBFKiqxa6yE2aHCZYPnPlU0NJ70Yc=
Date:   Thu, 16 May 2019 09:38:30 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Nirranjan Kirubaharan <nirranjan@chelsio.com>
Cc:     dledford@redhat.com, jgg@mellanox.com, linux-rdma@vger.kernel.org,
        bharat@chelsio.com
Subject: Re: [PATCH for-next] iw_cxgb4: Fix qpid leak
Message-ID: <20190516063830.GT5225@mtr-leonro.mtl.com>
References: <ea84bb959151af439b4a40a029ccf0d7c2323b0f.1557917496.git.nirranjan@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea84bb959151af439b4a40a029ccf0d7c2323b0f.1557917496.git.nirranjan@chelsio.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 15, 2019 at 04:01:13AM -0700, Nirranjan Kirubaharan wrote:
> In iw_cxgb4, sometimes scheduled freeing of QPs complete after
> completion of dealloc_ucontext(). So in use qpids stored in ucontext
> gets lost, causing qpid leak. Added changes in dealloc_ucontext(),
> to wait until completion of freeing of all QPs.
>
> Signed-off-by: Nirranjan Kirubaharan <nirranjan@chelsio.com>
> Reviewed-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
>  drivers/infiniband/hw/cxgb4/device.c   | 3 +++
>  drivers/infiniband/hw/cxgb4/iw_cxgb4.h | 2 ++
>  drivers/infiniband/hw/cxgb4/provider.c | 6 +++++-
>  drivers/infiniband/hw/cxgb4/resource.c | 9 +++++++++
>  4 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/hw/cxgb4/device.c b/drivers/infiniband/hw/cxgb4/device.c
> index 4c0d925c5ff5..fad4ca247bc7 100644
> --- a/drivers/infiniband/hw/cxgb4/device.c
> +++ b/drivers/infiniband/hw/cxgb4/device.c
> @@ -775,6 +775,9 @@ void c4iw_init_dev_ucontext(struct c4iw_rdev *rdev,
>  	INIT_LIST_HEAD(&uctx->qpids);
>  	INIT_LIST_HEAD(&uctx->cqids);
>  	mutex_init(&uctx->lock);
> +	uctx->qid_count = 0;
> +	init_completion(&uctx->qid_rel_comp);
> +	complete(&uctx->qid_rel_comp);

This line doesn't make sense to me.

Thanks

>  }
>
>  /* Caller takes care of locking if needed */
> diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
> index 916ef982172e..768532e29538 100644
> --- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
> +++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
> @@ -110,6 +110,8 @@ struct c4iw_dev_ucontext {
>  	struct list_head cqids;
>  	struct mutex lock;
>  	struct kref kref;
> +	struct completion qid_rel_comp;
> +	u32 qid_count;
>  };
>
>  enum c4iw_rdev_flags {
> diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
> index 74b795642fca..bfd541c55c31 100644
> --- a/drivers/infiniband/hw/cxgb4/provider.c
> +++ b/drivers/infiniband/hw/cxgb4/provider.c
> @@ -64,12 +64,16 @@ static void c4iw_dealloc_ucontext(struct ib_ucontext *context)
>  	struct c4iw_dev *rhp;
>  	struct c4iw_mm_entry *mm, *tmp;
>
> -	pr_debug("context %p\n", context);
> +	pr_debug("context %p\n", &ucontext->uctx);
>  	rhp = to_c4iw_dev(ucontext->ibucontext.device);
>
>  	list_for_each_entry_safe(mm, tmp, &ucontext->mmaps, entry)
>  		kfree(mm);
> +
> +	wait_for_completion(&ucontext->uctx.qid_rel_comp);
> +
>  	c4iw_release_dev_ucontext(&rhp->rdev, &ucontext->uctx);
> +	pr_debug("context %p done\n", &ucontext->uctx);
>  }
>
>  static int c4iw_alloc_ucontext(struct ib_ucontext *ucontext,
> diff --git a/drivers/infiniband/hw/cxgb4/resource.c b/drivers/infiniband/hw/cxgb4/resource.c
> index 57ed26b3cc21..e9cc06f8a9ad 100644
> --- a/drivers/infiniband/hw/cxgb4/resource.c
> +++ b/drivers/infiniband/hw/cxgb4/resource.c
> @@ -224,6 +224,10 @@ u32 c4iw_get_qpid(struct c4iw_rdev *rdev, struct c4iw_dev_ucontext *uctx)
>  			list_add_tail(&entry->entry, &uctx->cqids);
>  		}
>  	}
> +	if (uctx->qid_count == 0)
> +		reinit_completion(&uctx->qid_rel_comp);
> +	uctx->qid_count++;
> +
>  out:
>  	mutex_unlock(&uctx->lock);
>  	pr_debug("qid 0x%x\n", qid);
> @@ -246,6 +250,11 @@ void c4iw_put_qpid(struct c4iw_rdev *rdev, u32 qid,
>  	entry->qid = qid;
>  	mutex_lock(&uctx->lock);
>  	list_add_tail(&entry->entry, &uctx->qpids);
> +
> +	uctx->qid_count--;
> +	if (uctx->qid_count == 0)
> +		complete(&uctx->qid_rel_comp);
> +
>  	mutex_unlock(&uctx->lock);
>  }
>
> --
> 1.8.3.1
>
