Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C085B3541E7
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Apr 2021 13:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbhDEL5P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Apr 2021 07:57:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233778AbhDEL5P (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 5 Apr 2021 07:57:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5340D6139E;
        Mon,  5 Apr 2021 11:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617623829;
        bh=VaZChdTwTjRUDnrHiNeqquFkFX0/bq+NyNobQJydXqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bhAjTKo3f1OQsfsSEnl194//vyVDB/OpRtvBjppLT4/2HlMTKjFxvj6nCnVPVk+tp
         QWHtEFJBqVQFdXdXuvsHm7eVGQ8uUH0sdwhiQHJVg3jdV6aBTg8vZE7kv1VTiIiNH3
         FHVoR9QJjuVTjDcUABwWIeIwjy54CMq3AQ5P1DABwmz04Lm3qh0bacrDZRAg+KpUXC
         mu7QBhHU4lIIkQWTWnNnQKoCKAb6qmxhQ05lRO9eU2TKQZFQOS2ZGihZkQOydAksHY
         k7naO6d/wgLCUX7ebGVgOBpXAPINsxiTpO575113AqiwmAlTwXi8/PxfZEXD9qKHnV
         08TUkJPOBsk3A==
Date:   Mon, 5 Apr 2021 14:57:05 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH for-next] RDMA/nldev: Add copy-on-fork attribute to get
 sys command
Message-ID: <YGr7EajqXvSGyZfy@unreal>
References: <20210405114722.98904-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405114722.98904-1-galpress@amazon.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 05, 2021 at 02:47:21PM +0300, Gal Pressman wrote:
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

Please be more specific, add SHA-1 of that patch and wrote the same
comment near "err = nla_put_u8(msg, RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK,
1);" line.

Thanks

> 
> Copy-on-fork attribute is read-only, trying to change it through the set
> sys command will result in an error.
> 
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
> PR was sent:
> https://github.com/linux-rdma/rdma-core/pull/975
> ---
>  drivers/infiniband/core/nldev.c  | 19 ++++++++++++++-----
>  include/uapi/rdma/rdma_netlink.h |  2 ++
>  2 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> index b8dc002a2478..87c68301c25b 100644
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
> @@ -1693,12 +1694,19 @@ static int nldev_sys_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
>  
>  	err = nla_put_u8(msg, RDMA_NLDEV_SYS_ATTR_NETNS_MODE,
>  			 (u8)ib_devices_shared_netns);
> -	if (err) {
> -		nlmsg_free(msg);
> -		return err;
> -	}
> +	if (err)
> +		goto err_nlmsg_free;
> +
> +	err = nla_put_u8(msg, RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK, 1);
> +	if (err)
> +		goto err_nlmsg_free;

Is it important to have an ability to fail here? Can we simply ignore
failure?

> +
>  	nlmsg_end(msg, nlh);
>  	return rdma_nl_unicast(sock_net(skb->sk), msg, NETLINK_CB(skb).portid);
> +
> +err_nlmsg_free:
> +	nlmsg_free(msg);
> +	return err;
>  }
>  
>  static int nldev_set_sys_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
> @@ -1710,7 +1718,8 @@ static int nldev_set_sys_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
>  
>  	err = nlmsg_parse(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
>  			  nldev_policy, extack);
> -	if (err || !tb[RDMA_NLDEV_SYS_ATTR_NETNS_MODE])
> +	if (err || !tb[RDMA_NLDEV_SYS_ATTR_NETNS_MODE] ||
> +	    tb[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK])
>  		return -EINVAL;
>  
>  	enable = nla_get_u8(tb[RDMA_NLDEV_SYS_ATTR_NETNS_MODE]);
> diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
> index d2f5b8396243..342c9db5b3c1 100644
> --- a/include/uapi/rdma/rdma_netlink.h
> +++ b/include/uapi/rdma/rdma_netlink.h
> @@ -533,6 +533,8 @@ enum rdma_nldev_attr {
>  
>  	RDMA_NLDEV_ATTR_RES_RAW,	/* binary */
>  
> +	RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK,	/* u8 */
> +
>  	/*
>  	 * Always the end
>  	 */
> 
> base-commit: adb76a520d068a54ee5ca82e756cf8e5a47363a4
> -- 
> 2.31.1
> 
