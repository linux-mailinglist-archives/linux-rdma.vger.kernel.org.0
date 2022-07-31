Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7AB585E25
	for <lists+linux-rdma@lfdr.de>; Sun, 31 Jul 2022 10:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiGaIeW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 31 Jul 2022 04:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGaIeW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 31 Jul 2022 04:34:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F74112627;
        Sun, 31 Jul 2022 01:34:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E800A609D0;
        Sun, 31 Jul 2022 08:34:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85C2C433C1;
        Sun, 31 Jul 2022 08:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659256460;
        bh=8QXXfpkC/0m1rjKafHxPZkNrxMHSchHUGWSCxb7xruc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ooJLrlUlRPs3IpHjOPsggXTx/yuzdvtF5RthB1kTeMfdG6tIf1W7ijcO/cCSssv6V
         Ge8ra+XpiNlVZJKVQg4bXk3H8DocDmA8ryEgL+qqnaD1/atwt6/0qJPwkbbqewui6C
         yesuzSYeZ4evOiBk1hCl01ZL+sy2bw1455OMKl03qphswFXFXODXiEZQpisc1oCXg/
         TQ1ZUe8JVK1IGhNWzfgmpqM/By2lvynyOARyRaaig9Zk+VXHj7SeTkbb37Ac47Ab1F
         L4CnfqH0lZitlDTTB+6fWUcqsr7jqWek/uHs1yppBkjIBachPPVF8wldf82PFDBR/K
         7M4wvBKv9IH4Q==
Date:   Sun, 31 Jul 2022 11:34:16 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Sebin Sebastian <mailmesebin00@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] RDMA/mlx5: unchecked return value
Message-ID: <YuY+iGeu+jRJFGki@unreal>
References: <20220730103242.48612-1-mailmesebin00@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220730103242.48612-1-mailmesebin00@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jul 30, 2022 at 04:02:42PM +0530, Sebin Sebastian wrote:
> Unchecked return value warning as reported by Coverity static analyzer
> tool. check the return value of mlx5_ib_ft_type_to_namespace().
> 
> Signed-off-by: Sebin Sebastian <mailmesebin00@gmail.com>
> ---
>  drivers/infiniband/hw/mlx5/fs.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Thanks, I had similar patch in my internal queue.
https://lore.kernel.org/linux-rdma/7b9ceda217d9368a51dc47a46b769bad4af9ac92.1659256069.git.leonro@nvidia.com/T/#u

> 
> diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
> index 691d00c89f33..617e0e9c0c8e 100644
> --- a/drivers/infiniband/hw/mlx5/fs.c
> +++ b/drivers/infiniband/hw/mlx5/fs.c
> @@ -2079,9 +2079,12 @@ static int mlx5_ib_matcher_ns(struct uverbs_attr_bundle *attrs,
>  			return err;
>  
>  		if (flags) {
> -			mlx5_ib_ft_type_to_namespace(
> +			err = mlx5_ib_ft_type_to_namespace(
>  				MLX5_IB_UAPI_FLOW_TABLE_TYPE_NIC_TX,
>  				&obj->ns_type);
> +			if (err)
> +				return err;
> +
>  			return 0;
>  		}
>  	}
> -- 
> 2.34.1
> 
