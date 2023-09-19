Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA58E7A5ABF
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Sep 2023 09:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjISHVq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Sep 2023 03:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjISHVq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Sep 2023 03:21:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE126FC
        for <linux-rdma@vger.kernel.org>; Tue, 19 Sep 2023 00:21:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC44BC43397;
        Tue, 19 Sep 2023 07:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695108100;
        bh=8FOnyND6AfudQtEFlUMERYJVJ8Cnduh+nJTQLFp+aJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TePgHpmEIlaOyCKfw8Qj41JDenufTvAd85kOG12/NPO3kiGDoZTIttJHv+VIfvXsK
         pypZByHXtRXcNEgjCL7phb/+t3rbL5F1o50RZH2PE7tNxyWM0bAq46oIF6ofVumlLx
         l7J4D3GZjRUM29k7T5H70rDIB9gpU9xzs1KMZbQcxqGUcjfFo1lzF4NjRX7TcwcpGz
         PEVPv2I5wN3v5swpA9Aaf51oGfqusHoOBLyqs5zSL2OAJxScQz4/8pbawiR3LJDmi1
         8MM9nm7ixVJb9q+q0jfwj99k9DxIoLeaoS2KXnfyluDFaYYYVOrZKLuegVL6xVlNVr
         YXa7cnxQkBl/w==
Date:   Tue, 19 Sep 2023 10:21:36 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Vitaly Mayatskikh <vitaly@enfabrica.net>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     linux-rdma@vger.kernel.org, David Ahern <dsahern@kernel.org>,
        Roland Dreier <roland@enfabrica.net>
Subject: Re: [PATCH] RDMA/core: use rdma_cap_iw_cm() in rdma_resolve_route()
Message-ID: <20230919072136.GB4494@unreal>
References: <20230918142700.12745-1-vitaly@enfabrica.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918142700.12745-1-vitaly@enfabrica.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 18, 2023 at 02:27:00PM +0000, Vitaly Mayatskikh wrote:
> rdma_resolve_route checks for the full rdma_protocol_iwarp support
> before calling cma_resolve_iw_route, while in fact rdma_cap_iw_cm is
> sufficient. This makes it possible to use IW CM for device
> implementing IW Connection Management only, but not the whole iWarp.
> 
> Signed-off-by: Vitaly Mayatskikh <vitaly@enfabrica.net>
> ---
>  drivers/infiniband/core/cma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index c343edf2f664..356da8e625aa 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -3378,7 +3378,7 @@ int rdma_resolve_route(struct rdma_cm_id *id, unsigned long timeout_ms)
>  		if (!ret)
>  			cma_add_id_to_tree(id_priv);
>  	}
> -	else if (rdma_protocol_iwarp(id->device, id->port_num))
> +	else if (rdma_cap_iw_cm(id->device, id->port_num))

I see that rdma_protocol_iwarp() is used in other places in cma.c too,
Don't they need to be updated too?

Also I see that we have check for protocol RoCE in else before the
changed line, shouldn't all cma.c be changed to rdma_cap_*_cm() calls?

  3376         else if (rdma_protocol_roce(id->device, id->port_num)) {

Thanks

>  		ret = cma_resolve_iw_route(id_priv);
>  	else
>  		ret = -ENOSYS;
> -- 
> 2.34.1
> 
