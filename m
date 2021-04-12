Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C369735BB53
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Apr 2021 09:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237129AbhDLHwU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Apr 2021 03:52:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237110AbhDLHwT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Apr 2021 03:52:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5549E6135A;
        Mon, 12 Apr 2021 07:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618213922;
        bh=b6caykMxiAq91PMve97bmZcXOnTtbI521lJxug83BD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N9kF2HgmJqyH3wBfJZCe0kB56HDll4Qahf/AfoZjU6AM2eiBwOiUvXeC6gQu7STKQ
         tI3mxfCzswwx1TXLaqgt4oeBvLhrDjfy4bzJHARa7zxDu6rsYVNLGj57yQFiRWONEq
         ZJ40ZBP/YR1NF6cGzmxMIi+Z+5amDPQIQWK+IKXQfLemAF4wouZ+GrhawNwIBQLl6d
         rG7gnodiOOF3jE8LJVCcqYChkRdUSfyXOSrIN6ZmrKG6XnRmpXv85LcgABrl0D1Qz9
         5g/mRJSuT0e1+1aqoq2j+HgDJicJU3OBAQI148IO5BSSZT3d3/WWjS4K2T+FwyYeaP
         Lwt9wgmHllANg==
Date:   Mon, 12 Apr 2021 10:51:40 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH for-next v3] RDMA/nldev: Add copy-on-fork attribute to
 get sys command
Message-ID: <YHP8DBn2lImpOUMZ@unreal>
References: <20210412064150.40064-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412064150.40064-1-galpress@amazon.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 12, 2021 at 09:41:50AM +0300, Gal Pressman wrote:
> The new attribute indicates that the kernel copies DMA pages on fork,
> hence libibverbs' fork support through madvise and MADV_DONTFORK is not
> needed.
> 
> The introduced attribute is always reported as supported since the
> kernel has the patch that added the copy-on-fork behavior. This allows
> the userspace library to identify older vs newer kernel versions.
> Extra care should be taken when backporting this patch as it relies on
> the fact that the copy-on-fork patch is merged, hence no check for
> support is added.
> 
> Don't backport this patch unless you also have the following series:
> 70e806e4e645 ("mm: Do early cow for pinned pages during fork() for ptes")
> and 4eae4efa2c29 ("hugetlb: do early cow when page pinned on src mm").
> 
> Fixes: 70e806e4e645 ("mm: Do early cow for pinned pages during fork() for ptes")
> Fixes: 4eae4efa2c29 ("hugetlb: do early cow when page pinned on src mm")
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
> PR was sent:
> https://github.com/linux-rdma/rdma-core/pull/975
> 
> Changelog -
> v2->v3: https://lore.kernel.org/linux-rdma/21317d2c-9a8e-0dd7-3678-d2933c5053c4@amazon.com/
> * Remove check if copy-on-fork attribute was provided from nldev_set_sys_set_doit()
> 
> v1->v2: https://lore.kernel.org/linux-rdma/20210405114722.98904-1-galpress@amazon.com/
> * Remove nla_put_u8() return value check
> * Add commit hashes to commit message and code comment
> ---
>  drivers/infiniband/core/nldev.c  | 11 +++++++++++
>  include/uapi/rdma/rdma_netlink.h |  2 ++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> index b8dc002a2478..4889e06a581a 100644
> --- a/drivers/infiniband/core/nldev.c
> +++ b/drivers/infiniband/core/nldev.c
> @@ -146,6 +146,7 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
>  	[RDMA_NLDEV_ATTR_UVERBS_DRIVER_ID]	= { .type = NLA_U32 },
>  	[RDMA_NLDEV_NET_NS_FD]			= { .type = NLA_U32 },
>  	[RDMA_NLDEV_SYS_ATTR_NETNS_MODE]	= { .type = NLA_U8 },
> +	[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK]	= { .type = NLA_U8 },
>  };
>  
>  static int put_driver_name_print_type(struct sk_buff *msg, const char *name,
> @@ -1697,6 +1698,16 @@ static int nldev_sys_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
>  		nlmsg_free(msg);
>  		return err;
>  	}
> +
> +	/*
> +	 * Copy-on-fork is supported.
> +	 * See commits:
> +	 * 70e806e4e645 ("mm: Do early cow for pinned pages during fork() for ptes")
> +	 * 4eae4efa2c29 ("hugetlb: do early cow when page pinned on src mm")
> +	 * for more details. Don't backport this without them.
> +	 */
> +	nla_put_u8(msg, RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK, 1);
> +

Nit, it is good to write here that we don't check nla_put_u8() on purpose.

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
