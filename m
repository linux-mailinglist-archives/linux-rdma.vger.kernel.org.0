Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD7E46F2D9
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Dec 2021 19:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242083AbhLISUy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Dec 2021 13:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237501AbhLISUw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Dec 2021 13:20:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C707C061746;
        Thu,  9 Dec 2021 10:17:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5573FB825F3;
        Thu,  9 Dec 2021 18:17:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9742AC004DD;
        Thu,  9 Dec 2021 18:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639073836;
        bh=5WzgwuFREHai1LZ5Fq/7JGMVg+y6UKpM33QWtTaDVw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cfk0MVT1xKw7fkymLlas0hLesF6lRPvFZEy2xSspQlEisOd3xLXx7JzD15NZJ9Whn
         ENxP284SzeMKE8g5DFAG33LIDaT0IrCNK83MXmMvr2nJErj5JEJrb34F8Tdh4c3OAC
         1iCVGLy+oIadLF17OSPQwfSLonFl/WbzTdqgJ19PWiH4nNb4MSfTWNtpIaOK2l81wO
         QN0vokt8kVUKK4YkcFvrqte8hph/9W2SOzEgH7CTcJWXzSsLqQVgYbn4MAvqBNkRs0
         Nm5gzRruoVj+Jm300AvxssG0mRgedF6gOy7NYBOiufylKK1UruBH2AGlWWxzcxajrE
         Nb79xuLqVSjNQ==
Date:   Thu, 9 Dec 2021 20:17:11 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Avihai Horon <avihaih@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markzhang@nvidia.com>
Subject: Re: [PATCH rdma-next v1 1/3] RDMA/core: Modify rdma_query_gid() to
 return accurate error codes
Message-ID: <YbJIJ7Lh95v8xAad@unreal>
References: <cover.1639055490.git.leonro@nvidia.com>
 <1f2b65dfb4d995e74b621e3e21e7c7445d187956.1639055490.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f2b65dfb4d995e74b621e3e21e7c7445d187956.1639055490.git.leonro@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 09, 2021 at 03:16:05PM +0200, Leon Romanovsky wrote:
> From: Avihai Horon <avihaih@nvidia.com>
> 
> Modify rdma_query_gid() to return -ENOENT for empty entries. This will
> make error reporting more accurate and will be used in next patches.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> Reviewed-by: Mark Zhang <markzhang@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/cache.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
> index 0c98dd3dee67..edddcca62ece 100644
> --- a/drivers/infiniband/core/cache.c
> +++ b/drivers/infiniband/core/cache.c
> @@ -955,7 +955,7 @@ int rdma_query_gid(struct ib_device *device, u32 port_num,
>  {
>  	struct ib_gid_table *table;
>  	unsigned long flags;
> -	int res = -EINVAL;
> +	int res;
>  
>  	if (!rdma_is_port_valid(device, port_num))
>  		return -EINVAL;
> @@ -963,9 +963,15 @@ int rdma_query_gid(struct ib_device *device, u32 port_num,
>  	table = rdma_gid_table(device, port_num);
>  	read_lock_irqsave(&table->rwlock, flags);
>  
> -	if (index < 0 || index >= table->sz ||
> -	    !is_gid_entry_valid(table->data_vec[index]))
> +	if (index < 0 || index >= table->sz) {
> +		res = -EINVAL

Jason,

I made stupid mistake here, and missed ";".
Can you fix it locally?

Thanks

>  		goto done;
> +	}
> +
> +	if (!is_gid_entry_valid(table->data_vec[index])) {
> +		res = -ENOENT;
> +		goto done;
> +	}
>  
>  	memcpy(gid, &table->data_vec[index]->attr.gid, sizeof(*gid));
>  	res = 0;
> -- 
> 2.33.1
> 
