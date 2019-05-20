Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 337CA2300E
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2019 11:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732007AbfETJSp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 May 2019 05:18:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729598AbfETJSp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 May 2019 05:18:45 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9798720675;
        Mon, 20 May 2019 09:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558343924;
        bh=Ste7t+0PhNI3tpUcBHppHadW3P1aE0n0kTsym2j9uFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X5o6hKUTBd8tlRtAiYy9pN3qzLS01lNNRxqs0mx3LoXW7e8vUX9nqwzqBJwm31A75
         F5g/vtkm82w+cMwfKOsl3IMzePD7HEl0rme+tfeWnYCRUq9zW9xRIflDPGMO+jOrMz
         uTGdvaOXUX/sEon8CeLEWY34fJfhpVCoJasVMnaY=
Date:   Mon, 20 May 2019 12:18:40 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Cc:     dledford@redhat.com, jgg@mellanox.com, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Parav Pandit <parav@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: Re: [PATCH for-next v2 3/4] RDMA/nldev: ib_pd can be pointed by
 multiple ib_ucontext
Message-ID: <20190520091840.GB4573@mtr-leonro.mtl.com>
References: <20190520075333.6002-1-shamir.rabinovitch@oracle.com>
 <20190520075333.6002-4-shamir.rabinovitch@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520075333.6002-4-shamir.rabinovitch@oracle.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 20, 2019 at 10:53:20AM +0300, Shamir Rabinovitch wrote:
> In shared object model ib_pd can belong to 1 or more ib_ucontext.
> Fix the nldev code so it could report multiple context ids.
>
> Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> ---
>  drivers/infiniband/core/nldev.c | 93 +++++++++++++++++++++++++++++++--
>  1 file changed, 88 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> index cbd712f5f8b2..f4cc92b897ff 100644
> --- a/drivers/infiniband/core/nldev.c
> +++ b/drivers/infiniband/core/nldev.c
> @@ -41,6 +41,9 @@
>  #include "core_priv.h"
>  #include "cma_priv.h"
>  #include "restrack.h"
> +#include "uverbs.h"
> +
> +static bool is_visible_in_pid_ns(struct rdma_restrack_entry *res);

Mark needed it too.
https://patchwork.kernel.org/patch/10921419/

>
>  static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
>  	[RDMA_NLDEV_ATTR_DEV_INDEX]     = { .type = NLA_U32 },
> @@ -584,11 +587,80 @@ static int fill_res_mr_entry(struct sk_buff *msg, bool has_cap_net_admin,
>  err:	return -EMSGSIZE;
>  }
>
> +struct context_id {
> +	struct list_head list;
> +	u32 id;
> +};
> +
> +static void pd_context(struct ib_pd *pd, struct list_head *list)
> +{
> +	struct ib_device *device = pd->device;
> +	struct rdma_restrack_entry *res;
> +	struct rdma_restrack_root *rt;
> +	struct ib_uverbs_file *ufile;
> +	struct ib_ucontext *ucontext;
> +	struct ib_uobject *uobj;
> +	unsigned long flags;
> +	unsigned long id;
> +	bool found;
> +
> +	rt = &device->res[RDMA_RESTRACK_CTX];
> +
> +	xa_lock(&rt->xa);
> +
> +	xa_for_each(&rt->xa, id, res) {
> +		if (!is_visible_in_pid_ns(res))
> +			continue;
> +
> +		if (!rdma_restrack_get(res))
> +			continue;
> +
> +		xa_unlock(&rt->xa);
> +
> +		ucontext = container_of(res, struct ib_ucontext, res);
> +		ufile = ucontext->ufile;
> +		found = false;
> +
> +		/* See locking requirements in struct ib_uverbs_file */
> +		down_read(&ufile->hw_destroy_rwsem);
> +		spin_lock_irqsave(&ufile->uobjects_lock, flags);
> +
> +		list_for_each_entry(uobj, &ufile->uobjects, list) {
> +			if (uobj->object == pd) {
> +				found = true;
> +				goto found;
> +			}
> +		}
> +
> +found:		spin_unlock_irqrestore(&ufile->uobjects_lock, flags);
> +		up_read(&ufile->hw_destroy_rwsem);
> +
> +		if (found) {
> +			struct context_id *ctx_id =
> +				kmalloc(sizeof(*ctx_id), GFP_KERNEL);
> +
> +			if (WARN_ON_ONCE(!ctx_id))
> +				goto next;
> +
> +			ctx_id->id = ucontext->res.id;
> +			list_add(&ctx_id->list, list);
> +		}
> +
> +next:		rdma_restrack_put(res);
> +		xa_lock(&rt->xa);
> +	}
> +
> +	xa_unlock(&rt->xa);
> +}
> +
>  static int fill_res_pd_entry(struct sk_buff *msg, bool has_cap_net_admin,
>  			     struct rdma_restrack_entry *res, uint32_t port)
>  {
>  	struct ib_pd *pd = container_of(res, struct ib_pd, res);
>  	struct ib_device *dev = pd->device;
> +	struct context_id *ctx_id;
> +	struct context_id *tmp;
> +	LIST_HEAD(pd_context_ids);
>
>  	if (has_cap_net_admin) {
>  		if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_LOCAL_DMA_LKEY,
> @@ -606,10 +678,14 @@ static int fill_res_pd_entry(struct sk_buff *msg, bool has_cap_net_admin,
>  	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_PDN, res->id))
>  		goto err;
>
> -	if (!rdma_is_kernel_res(res) &&
> -	    nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_CTXN,
> -			pd->uobject->context->res.id))
> -		goto err;
> +	if (!rdma_is_kernel_res(res)) {
> +		pd_context(pd, &pd_context_ids);
> +		list_for_each_entry(ctx_id, &pd_context_ids, list) {
> +			if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_CTXN,
> +				ctx_id->id))

Did it work? You are overwriting RDMA_NLDEV_ATTR_RES_CTXN entry in the
loop. You need to add RDMA_NLDEV_ATTR_RES_CTX and
RDMA_NLDEV_ATTR_RES_CTX_ENTRY to include/uapi/rdma_netlink.h and
open nested table here (inside of PD) with list of contexts.

> +				goto err;
> +		}
> +	}
>
>  	if (fill_res_name_pid(msg, res))
>  		goto err;
> @@ -617,9 +693,16 @@ static int fill_res_pd_entry(struct sk_buff *msg, bool has_cap_net_admin,
>  	if (fill_res_entry(dev, msg, res))
>  		goto err;
>
> +	list_for_each_entry_safe(ctx_id, tmp, &pd_context_ids, list)
> +		kfree(ctx_id);
> +
>  	return 0;
>
> -err:	return -EMSGSIZE;
> +err:
> +	list_for_each_entry_safe(ctx_id, tmp, &pd_context_ids, list)
> +		kfree(ctx_id);
> +
> +	return -EMSGSIZE;
>  }
>
>  static int nldev_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
> --
> 2.20.1
>
