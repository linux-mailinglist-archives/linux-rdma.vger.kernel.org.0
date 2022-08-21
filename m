Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F57359B390
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Aug 2022 13:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiHULqv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Aug 2022 07:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiHULqv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 21 Aug 2022 07:46:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9050186FB;
        Sun, 21 Aug 2022 04:46:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89E99B80A08;
        Sun, 21 Aug 2022 11:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B748FC433D6;
        Sun, 21 Aug 2022 11:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661082407;
        bh=DGQUS8eXAZIHm2Ygm52BO8zfyjHBCFCIa+NCARaxGBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dPIkaW5vsgPBT+lcFlQGkA2Y0OqcOfe9s4D6V6djZyS9nUCEaQVnBSNUc9OCrDAR/
         2IVdp2IFwwsKuKbl+4tZI7NSGxeUJ9ClIxFnZZ+DdynWYv0ioonw37BrC5ZAw7HTKL
         Ntb6idMYyLLJyMmtGmITpnqdDghRCqReP7Ez4vIBmj8B2FZyRVqtty3H3wKAiYszau
         6rSf0sMA+OuW9qGw9nI1IHaPT6Eq+oKR3uUwWTMZ47ZuLulqTm5014sF0IG3Y724T9
         ZXYcMIb4GuPmYDkSf3vYPpZZ4JsAMuVX22ZP+LUTkyFx79G9K0zZ+dzwmeanKSk00v
         U4TxuLSMVKIMw==
Date:   Sun, 21 Aug 2022 14:46:43 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Kees Cook <keescook@chromium.org>,
        =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v1 02/19] infiniband/mthca: Fix dma_map_sg error check
Message-ID: <YwIbI3ktmEiLsy6s@unreal>
References: <20220819060801.10443-1-jinpu.wang@ionos.com>
 <20220819060801.10443-3-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220819060801.10443-3-jinpu.wang@ionos.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 19, 2022 at 08:07:44AM +0200, Jack Wang wrote:
> dma_map_sg return 0 on error, in case of error set
> EIO as return code.
> 
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: "Håkon Bugge" <haakon.bugge@oracle.com>
> Cc: linux-rdma@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/infiniband/hw/mthca/mthca_memfree.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mthca/mthca_memfree.c b/drivers/infiniband/hw/mthca/mthca_memfree.c
> index f2734a5c5f26..44fd5fdf64d5 100644
> --- a/drivers/infiniband/hw/mthca/mthca_memfree.c
> +++ b/drivers/infiniband/hw/mthca/mthca_memfree.c
> @@ -189,7 +189,7 @@ struct mthca_icm *mthca_alloc_icm(struct mthca_dev *dev, int npages,
>  						   chunk->npages,
>  						   DMA_BIDIRECTIONAL);
>  
> -				if (chunk->nsg <= 0)
> +				if (!chunk->nsg)
>  					goto fail;
>  			}
>  
> @@ -208,7 +208,7 @@ struct mthca_icm *mthca_alloc_icm(struct mthca_dev *dev, int npages,
>  		chunk->nsg = dma_map_sg(&dev->pdev->dev, chunk->mem,
>  					chunk->npages, DMA_BIDIRECTIONAL);
>  
> -		if (chunk->nsg <= 0)
> +		if (!chunk->nsg)
>  			goto fail;
>  	}
>  
> @@ -482,8 +482,9 @@ int mthca_map_user_db(struct mthca_dev *dev, struct mthca_uar *uar,
>  
>  	ret = dma_map_sg(&dev->pdev->dev, &db_tab->page[i].mem, 1,
>  			 DMA_TO_DEVICE);
> -	if (ret < 0) {
> +	if (!ret) {

This code is not equivalent to original code. mthca didn't count ret == 0
as an error. Most likely, it is a bug, but I don't want to change old and
unmaintained driver without any real need.

Thanks

>  		unpin_user_page(pages[0]);
> +		ret = -EIO;
>  		goto out;
>  	}
>  
> -- 
> 2.34.1
> 
