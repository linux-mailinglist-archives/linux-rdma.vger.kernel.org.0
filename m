Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC63B357FD6
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 11:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbhDHJso (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 05:48:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:42058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229751AbhDHJsn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Apr 2021 05:48:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84ED061159;
        Thu,  8 Apr 2021 09:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617875312;
        bh=M6uU75HFiXagiEBzznBnP0YmePuu1H7tseKUsQ9JVYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D0Syg1JN6b5G+toD+cle/xGgxhnxDES0vt1IeJw+MbqxGCPUQtaEQUrh2egylpZ1z
         vhA1Of0XLTX8k9BeyVHrq0lSJjl7DDeSoZUH0ys+BVxykHq2KX1i5e734g+9elsxtP
         gDOdD56luOGRj0UWvLi2tM1YFnz1dWNv3b5sABHH+3s5htzuOrDHMUwvJdl6v4O/cw
         Me/gVFXsSxel7x85P+sKObCO/eQYwHdTdr9qBHoxZAe8qICh4XA2TBjLTyoOnZQHqm
         FNYBSIwACqe/Ovk1M2ZILcg1LYnjFkqvmPWN/DSjPONeX7ndZb6ZfIsquFMevoWCk+
         di34HLw33IAsw==
Date:   Thu, 8 Apr 2021 12:48:28 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org,
        dledford@redhat.com, jgg@ziepe.ca
Subject: Re: [PATCH v3] RDMA/ipoib: print a message if only child interface
 is UP
Message-ID: <YG7RbOo/N1TeoqJB@unreal>
References: <20210408093215.24023-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408093215.24023-1-jinpu.wang@ionos.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 08, 2021 at 11:32:15AM +0200, Jack Wang wrote:
> When "enhanced IPoIB" enabled for CX-5 devices, it requires
> the parent device to be UP, otherwise the child devices won't
> work.
> 
> This add a debug message to give admin a hint, if only child interface
> is UP, but parent interface is not.
> 
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/infiniband/ulp/ipoib/ipoib_main.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
> index e16b40c09f82..df6329abac1d 100644
> --- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
> +++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
> @@ -164,8 +164,13 @@ int ipoib_open(struct net_device *dev)
>  			dev_change_flags(cpriv->dev, flags | IFF_UP, NULL);
>  		}
>  		up_read(&priv->vlan_rwsem);
> -	}
> +	} else if (priv->parent) {
> +		struct ipoib_dev_priv *ppriv = ipoib_priv(priv->parent);
>  
> +		if (!test_bit(IPOIB_FLAG_ADMIN_UP, &ppriv->flags))
> +			ipoib_dbg(priv, "parent device %s is not up, so child device may be not functioning.\n",
> +				  ppriv->dev->name);


I personally would use stronger language than that.

Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Thanks

> +	}
>  	netif_start_queue(dev);
>  
>  	return 0;
> -- 
> 2.25.1
> 
