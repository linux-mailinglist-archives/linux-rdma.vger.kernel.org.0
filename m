Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5482B26D761
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Sep 2020 11:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgIQJIQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Sep 2020 05:08:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:50630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbgIQJIP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 17 Sep 2020 05:08:15 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D62CD20795;
        Thu, 17 Sep 2020 09:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600333694;
        bh=71PMMX4XGwzhcDucaMkdKJC5uGHv8NBRfWU+pcx17cw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ol5WmhOvI9rTFHgy8Vm01a+xGvI5mfTv9WBhdwoiPyKDHFLe79b8dV4Xg94ovNSEm
         s9uxKgsVD6kfIu4LtqFnl7Ad+hw1A3xZll7LH8LyHueKNgIMhX6DA30mCajLlPMYz4
         astP5egLtpksNLrkl+aUOBY16OorzupdIFOwmpj4=
Date:   Thu, 17 Sep 2020 12:08:10 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] RDMA/mlx5: fix type warning of sizeof in
 __mlx5_ib_alloc_counters()
Message-ID: <20200917090810.GB869610@unreal>
References: <20200917082926.GA869610@unreal>
 <20200917091008.2309158-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917091008.2309158-1-liushixin2@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 17, 2020 at 05:10:08PM +0800, Liu Shixin wrote:
> sizeof() when applied to a pointer typed expression should give the
> size of the pointed data, even if the data is a pointer.
>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  drivers/infiniband/hw/mlx5/counters.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/hw/mlx5/counters.c b/drivers/infiniband/hw/mlx5/counters.c
> index 145f3cb40ccb..aeeb14ecb3ee 100644
> --- a/drivers/infiniband/hw/mlx5/counters.c
> +++ b/drivers/infiniband/hw/mlx5/counters.c
> @@ -456,12 +456,12 @@ static int __mlx5_ib_alloc_counters(struct mlx5_ib_dev *dev,
>  		cnts->num_ext_ppcnt_counters = ARRAY_SIZE(ext_ppcnt_cnts);
>  		num_counters += ARRAY_SIZE(ext_ppcnt_cnts);
>  	}
> -	cnts->names = kcalloc(num_counters, sizeof(cnts->names), GFP_KERNEL);
> +	cnts->names = kcalloc(num_counters, sizeof(*cnts->names), GFP_KERNEL);

This change is correct.

>  	if (!cnts->names)
>  		return -ENOMEM;
>
>  	cnts->offsets = kcalloc(num_counters,
> -				sizeof(cnts->offsets), GFP_KERNEL);
> +				sizeof(*cnts->offsets), GFP_KERNEL);

This is not.


>  	if (!cnts->offsets)
>  		goto err_names;
>
> --
> 2.25.1
>
