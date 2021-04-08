Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2DA357EC0
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 11:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbhDHJLH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 05:11:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229618AbhDHJLG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Apr 2021 05:11:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F30AE6112F;
        Thu,  8 Apr 2021 09:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617873055;
        bh=5dctzSWJ1wyaBdempll19M9OtI+cHdVwObvMPe6anR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dwmm1/HpIjRHKBGLF+S/ZGlfd2xfWThDd8z87fvJ7npCuygftzNxMSBcnWyy6g219
         th9QKwT/qHegh/uU1S7Wr4Re5MiOW1hanE6UN1KBSne0RldZlHCkeOmTOvT3wWEQbZ
         36VgqSnEEh/VhYU2+HjEJeLQCfkorlz3VixcBjTJX0RVuP6R5q57PJyLYdRCKHLKd6
         dWkFZgYR51G4XqA8KBcR/bmjz7DawLurEtDWGEgDLioAskVPiSqCeGK/Xf4hTX6yUX
         caMRxUzdERK2PZeml0pASWtm1ckD2xoD+D8eiX4Sa6g+xOUD+q9FCKk77Gk0nIz+vN
         aXKw5STAoNUwg==
Date:   Thu, 8 Apr 2021 12:10:51 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org,
        dledford@redhat.com, jgg@ziepe.ca
Subject: Re: [PATCH] RDMA/ipoib: print a message if only child interface is UP
Message-ID: <YG7ImyPNyqjWW8k2@unreal>
References: <20210408083435.13043-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408083435.13043-1-jinpu.wang@ionos.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 08, 2021 at 10:34:35AM +0200, Jack Wang wrote:
> When "enhanced IPoIB" enabled for CX-5 devices, it requires
> the parent device to be UP, otherwise the child devices won't
> work.[1]
> 
> This add a debug message to give admin a hint, if only child interface
> is UP, but parent interface is not.
> 
> [1]https://lore.kernel.org/linux-rdma/CAMGffE=3YYxv9i7_qQr3-Uv-NGr-7VsnMk8DTjR0YbX1vJBzXQ@mail.gmail.com/T/#u
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/infiniband/ulp/ipoib/ipoib_main.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
> index e16b40c09f82..782b792985b8 100644
> --- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
> +++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
> @@ -164,8 +164,12 @@ int ipoib_open(struct net_device *dev)
>  			dev_change_flags(cpriv->dev, flags | IFF_UP, NULL);
>  		}
>  		up_read(&priv->vlan_rwsem);
> -	}
> +	} else if (priv->parent) {
> +		struct ipoib_dev_priv *ppriv = ipoib_priv(priv->parent);
>  
> +		if (!test_bit(IPOIB_FLAG_ADMIN_UP, &ppriv->flags))
> +			ipoib_dbg(priv, "parent deivce %s is not up, so child may be not functioning.\n", ((struct ipoib_dev_priv *) ppriv)->dev->name);

Why do you need extra casting? "ppriv" is already "struct ipoib_dev_priv *".

Thanks

> +	}
>  	netif_start_queue(dev);
>  
>  	return 0;
> -- 
> 2.25.1
> 
