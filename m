Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E764A356C52
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Apr 2021 14:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241768AbhDGMjm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Apr 2021 08:39:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352298AbhDGMjj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Apr 2021 08:39:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E369611EE;
        Wed,  7 Apr 2021 12:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617799170;
        bh=MbNYP3O2fuqdUVinNSa/jvtpmiBwOxrIr8MwmQfS1dA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oHWYy1CZHUe2GfzNgqT7dtwQnGcVvlObCi9+6T9zzXrcxITQxhcE9X+uW4unbqMvx
         XSnFYSwEunGlUiqtF8kUs6cNXyV0yBY3ShgQcpXSgzgBXHdBIZ4iZNVZYqAR52MKED
         qv5iEEAWgSVum8HGCjFok14EvvKCuoJXudoQkdAirQothBiMNGHnbh76/J1NknrM9H
         l0EV9Q22zHdmjYfsSQShJhD1coyd3Bq6KwVpY3Zx6djykPk4OdMr5aMYvmSB4872jA
         Jwc994w6BCvx/NOBy/YWN63q8+UOyGigwI3nK9xlMggJVI2ljOCgi8fWRhNDL5rQV5
         XL8rDySoOkmNA==
Date:   Wed, 7 Apr 2021 15:39:26 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Xu <peterx@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH for-next v2] RDMA/nldev: Add copy-on-fork attribute to
 get sys command
Message-ID: <YG2n/nDhhQEGefFq@unreal>
References: <20210407101606.80737-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407101606.80737-1-galpress@amazon.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 07, 2021 at 01:16:05PM +0300, Gal Pressman wrote:
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
> Copy-on-fork attribute is read-only, trying to change it through the set
> sys command will result in an error.
> 
> Fixes: 70e806e4e645 ("mm: Do early cow for pinned pages during fork() for ptes")
> Fixes: 4eae4efa2c29 ("hugetlb: do early cow when page pinned on src mm")
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
> PR was sent:
> https://github.com/linux-rdma/rdma-core/pull/975
> 
> Changelog -
> v1->v2: https://lore.kernel.org/linux-rdma/20210405114722.98904-1-galpress@amazon.com/
> * Remove nla_put_u8() return value check
> * Add commit hashes to commit message and code comment
> ---
>  drivers/infiniband/core/nldev.c  | 14 +++++++++++++-
>  include/uapi/rdma/rdma_netlink.h |  2 ++
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> index b8dc002a2478..6b2235926f74 100644
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
>  	nlmsg_end(msg, nlh);
>  	return rdma_nl_unicast(sock_net(skb->sk), msg, NETLINK_CB(skb).portid);
>  }
> @@ -1710,7 +1721,8 @@ static int nldev_set_sys_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
>  
>  	err = nlmsg_parse(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
>  			  nldev_policy, extack);
> -	if (err || !tb[RDMA_NLDEV_SYS_ATTR_NETNS_MODE])
> +	if (err || !tb[RDMA_NLDEV_SYS_ATTR_NETNS_MODE] ||
> +	    tb[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK])

Why do we fail if user supplies RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK?

Thanks
