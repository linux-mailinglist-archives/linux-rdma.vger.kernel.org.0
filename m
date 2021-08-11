Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09533E91E0
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Aug 2021 14:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhHKMte (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Aug 2021 08:49:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230415AbhHKMt3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 11 Aug 2021 08:49:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78F566056C;
        Wed, 11 Aug 2021 12:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628686144;
        bh=bpylZYuOWSC5OaHJJAvdnfsUs4yPMAA8zho4ncVB7dg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qniE+DSYknL9skSWwx63GA1KYvaTLOmbnwHQsV9P48JPSOsBZ1PsQhaa9S3vnz3ok
         wbxJ1OC4pMUPzHy/fWIB3wAy+RpZ8BSMqSy5Xm1cMr177PT6oJxprfMIkFETFUpKc1
         IEoKGiIp7eFf3NXmTvuXf8+1XVsDA1Usk7Nu8sjx+lE1t/YX790UMQT0Oy3u7hhxfj
         ICq0H2Cm8/nzcmcZB0jrAHl+nn6GL0ggL6z+KZFResbTzwjcTW1ROsxCI/UcqK+pE4
         peeaWB3dMowDCS7c0W/dztRRvI2hy++XP0xlAXeGvClnL4GDGJHe3SmlI9FtQ6x1d0
         bhAPAcqRkBQ9g==
Date:   Wed, 11 Aug 2021 15:49:00 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Tuo Li <islituo@gmail.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: Re: [PATCH] IB/mthca: Fix possible uninitialized-variable access in
 mthca_SYS_EN()
Message-ID: <YRPHPP6mXPbohFHj@unreal>
References: <20210811123415.8200-1-islituo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811123415.8200-1-islituo@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 11, 2021 at 05:34:15AM -0700, Tuo Li wrote:
> The variable out is declared without initialization, and its address is 
> passed to mthca_cmd_imm():
>   ret = mthca_cmd_imm(dev, 0, &out, 0, 0, CMD_SYS_EN, CMD_TIME_CLASS_D);
> 
> In this function, mthca_cmd_wait() or mthca_cmd_poll() will be called with 
> the argument out_param, which is the address of the varialbe out. In these 
> two called functions, mthca_cmd_post() will be called with *out_param, 
> whose value comes from the uninitialized variable out.
>   err = mthca_cmd_post(dev, in_param, out_param ? *out_param : 0, ...)
> 
> In mthca_cmd_post(), mthca_cmd_post_dbell() or mthca_cmd_post_hcr() will 
> be called, in which the value from the uninitialized varialble out may be
> used:
>   __raw_writel((__force u32) cpu_to_be32(out_param >> 32), ptr + offs[3]);
> 
> To fix this possible uninitialized-variable access, initialized out to 0 
> at the begining of mthca_SYS_EN().
> 
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Tuo Li <islituo@gmail.com>
> ---
>  drivers/infiniband/hw/mthca/mthca_cmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Analysis is right, but I don't think that "out" value is important in
this flow.

Thanks

> 
> diff --git a/drivers/infiniband/hw/mthca/mthca_cmd.c b/drivers/infiniband/hw/mthca/mthca_cmd.c
> index bdf5ed38de22..86584982e496 100644
> --- a/drivers/infiniband/hw/mthca/mthca_cmd.c
> +++ b/drivers/infiniband/hw/mthca/mthca_cmd.c
> @@ -635,7 +635,7 @@ void mthca_free_mailbox(struct mthca_dev *dev, struct mthca_mailbox *mailbox)
>  
>  int mthca_SYS_EN(struct mthca_dev *dev)
>  {
> -	u64 out;
> +	u64 out = 0;
>  	int ret;
>  
>  	ret = mthca_cmd_imm(dev, 0, &out, 0, 0, CMD_SYS_EN, CMD_TIME_CLASS_D);
> -- 
> 2.25.1
> 
