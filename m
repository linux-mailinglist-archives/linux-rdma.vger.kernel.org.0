Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEC66D17B
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jul 2019 18:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfGRQFe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Jul 2019 12:05:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:57530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbfGRQFd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 18 Jul 2019 12:05:33 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2E02217F4;
        Thu, 18 Jul 2019 16:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563465932;
        bh=NTfEQn6ujRMGGe4nsqCrie0K2di/JmSK8NMHbsIkG8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j23Zly4xSGlv4uCOZK0hh7d1lVL8X0CUcYrB2GE7sZiqUloM3B+tjznvwtwipQonG
         KXx1znhhKv+C/aasJftbXmtYXmTT1wpjwiCrOCRukyUaGDNkvQZ76smxALU31zpEDF
         jbqPAUlckZso/Oisl5rKDh29QTq3Ora5v6TYENQU=
Date:   Thu, 18 Jul 2019 19:05:25 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Shamir Rabinovitch <srabinov7@gmail.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, monis@mellanox.com,
        parav@mellanox.com, danielj@mellanox.com, kamalheib1@gmail.com,
        markz@mellanox.com, swise@opengridcomputing.com,
        shamir.rabinovitch@oracle.com, johannes.berg@intel.com,
        willy@infradead.org, michaelgur@mellanox.com, markb@mellanox.com,
        yuval.shaia@oracle.com, dan.carpenter@oracle.com,
        bvanassche@acm.org, maxg@mellanox.com, israelr@mellanox.com,
        galpress@amazon.com, denisd@mellanox.com, yuvalav@mellanox.com,
        dennis.dalessandro@intel.com, will@kernel.org, ereza@mellanox.com,
        jgg@mellanox.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 03/25] RDMA/nldev: ib_pd can be pointed by multiple
 ib_ucontext
Message-ID: <20190718160525.GP10130@mtr-leonro.mtl.com>
References: <20190716181200.4239-1-srabinov7@gmail.com>
 <20190716181200.4239-4-srabinov7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716181200.4239-4-srabinov7@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 16, 2019 at 09:11:38PM +0300, Shamir Rabinovitch wrote:
> From: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
>
> In shared object model ib_pd can belong to 1 or more ib_ucontext.
> Fix the nldev code so it could report multiple context ids.
>
> Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> Signed-off-by: Shamir Rabinovitch <srabinov7@gmail.com>
> ---
>  drivers/infiniband/core/nldev.c  | 127 +++++++++++++++++++++++++++++--
>  include/uapi/rdma/rdma_netlink.h |   3 +
>  2 files changed, 125 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> index 783e465e7c41..5167228dea1c 100644
> --- a/drivers/infiniband/core/nldev.c
> +++ b/drivers/infiniband/core/nldev.c
> @@ -41,6 +41,7 @@
>  #include "core_priv.h"
>  #include "cma_priv.h"
>  #include "restrack.h"
> +#include "uverbs.h"
>
>  /*
>   * Sort array elements by the netlink attribute name
> @@ -141,6 +142,8 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
>  	[RDMA_NLDEV_ATTR_UVERBS_DRIVER_ID]	= { .type = NLA_U32 },
>  	[RDMA_NLDEV_NET_NS_FD]			= { .type = NLA_U32 },
>  	[RDMA_NLDEV_SYS_ATTR_NETNS_MODE]	= { .type = NLA_U8 },
> +	[RDMA_NLDEV_ATTR_RES_CTX]		= { .type = NLA_NESTED },
> +	[RDMA_NLDEV_ATTR_RES_CTX_ENTRY]		= { .type = NLA_NESTED },
>  };
>
>  static int put_driver_name_print_type(struct sk_buff *msg, const char *name,
> @@ -611,11 +614,84 @@ static int fill_res_mr_entry(struct sk_buff *msg, bool has_cap_net_admin,
>  err:	return -EMSGSIZE;
>  }
>
> +struct context_id {
> +	struct list_head list;
> +	u32 id;
> +};
> +
> +static void pd_context(struct ib_pd *pd, struct list_head *list, int *count)
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
> +		if (!rdma_is_visible_in_pid_ns(res))
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

No WARN_ON on kmalloc failure.

> +
> +			ctx_id->id = ucontext->res.id;
> +			list_add(&ctx_id->list, list);
> +			(*count)++;
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
> +	struct nlattr *table_attr = NULL;
> +	struct nlattr *entry_attr = NULL;
> +	struct context_id *ctx_id;
> +	struct context_id *tmp;
> +	LIST_HEAD(pd_context_ids);
> +	int ctx_count = 0;
>
>  	if (has_cap_net_admin) {
>  		if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_LOCAL_DMA_LKEY,
> @@ -633,10 +709,38 @@ static int fill_res_pd_entry(struct sk_buff *msg, bool has_cap_net_admin,
>  	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_PDN, res->id))
>  		goto err;
>
> -	if (!rdma_is_kernel_res(res) &&
> -	    nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_CTXN,
> -			pd->uobject->context->res.id))
> -		goto err;
> +	if (!rdma_is_kernel_res(res)) {
> +		pd_context(pd, &pd_context_ids, &ctx_count);
> +		if (ctx_count == 1) {

Only suggestion, maybe the better approach will be to print first CTXN always
and other CTXNs as nested after that? It will give an ability to see at
least first PD with old rdmatool. In your case, old rdmatool won't print
CTXNs at all.

Thanks

> +			/* user pd, not shared */
> +			ctx_id = list_first_entry(&pd_context_ids,
> +						  struct context_id, list);
> +			if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_CTXN,
> +					ctx_id->id))
> +				goto err;
> +		} else if (ctx_count > 1) {
> +			/* user pd, shared */
> +			table_attr = nla_nest_start(msg,
> +					RDMA_NLDEV_ATTR_RES_CTX);
> +			if (!table_attr)
> +				goto err;
> +
> +			list_for_each_entry(ctx_id, &pd_context_ids, list) {
> +				entry_attr = nla_nest_start(msg,
> +						RDMA_NLDEV_ATTR_RES_CTX_ENTRY);
> +				if (!entry_attr)
> +					goto err;
> +				if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_CTXN,
> +						ctx_id->id))
> +					goto err;
> +				nla_nest_end(msg, entry_attr);
> +				entry_attr = NULL;
> +			}
> +
> +			nla_nest_end(msg, table_attr);
> +			table_attr = NULL;
> +		}
> +	}
>
>  	if (fill_res_name_pid(msg, res))
>  		goto err;
> @@ -644,9 +748,22 @@ static int fill_res_pd_entry(struct sk_buff *msg, bool has_cap_net_admin,
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
> +	if (entry_attr)
> +		nla_nest_end(msg, entry_attr);
> +
> +	if (table_attr)
> +		nla_nest_end(msg, table_attr);
> +
> +	list_for_each_entry_safe(ctx_id, tmp, &pd_context_ids, list)
> +		kfree(ctx_id);
> +
> +	return -EMSGSIZE;
>  }
>
>  static int fill_stat_counter_mode(struct sk_buff *msg,
> diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
> index 8e277783fa96..7fbbfb07f071 100644
> --- a/include/uapi/rdma/rdma_netlink.h
> +++ b/include/uapi/rdma/rdma_netlink.h
> @@ -525,6 +525,9 @@ enum rdma_nldev_attr {
>  	 */
>  	RDMA_NLDEV_ATTR_DEV_DIM,                /* u8 */
>
> +	RDMA_NLDEV_ATTR_RES_CTX,		/* nested table */
> +	RDMA_NLDEV_ATTR_RES_CTX_ENTRY,		/* nested table */
> +
>  	/*
>  	 * Always the end
>  	 */
> --
> 2.20.1
>
