Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927404970FD
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Jan 2022 11:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236163AbiAWKo5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Jan 2022 05:44:57 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52760 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236161AbiAWKo4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Jan 2022 05:44:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F27DB80B7C;
        Sun, 23 Jan 2022 10:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB22BC340E2;
        Sun, 23 Jan 2022 10:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642934693;
        bh=pyDajiwE9H/hMuG0OdqxWBJSTqPj5yScibwvEC+C9ow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VTnWbfEosgbgoaV55XeHT1SEN/6KSnoW3+mDSmvhZWYcl9s2IqbDEC9chQyBWaz+K
         4vqUu9QsTbJu9weaL3CNpDHh6IhdYO4vPWmlpgUUMsLNqZTIJ86VgGd716FdQ5MSZA
         jtcO/hjowHmYDNrEL4Cj6aEI+s22S7h3GJ2c3H3C8RMj+uZ2kK8Zlz39Me540ceCUI
         zLcYfP4jRoTNijKZHYKSFZ9D1eZHnr+CmXbBBxqSF4gGVAAesbjVfoJhZcECuJDILu
         0suNsAmu8hdH4YtRfOM1BUWukjf7ZW7Gxrb/9POkWycfOY6o9NDuZ3saCL1w7J13iY
         QnLFBf9MqM31Q==
Date:   Sun, 23 Jan 2022 12:44:49 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/rtrs: Fix double free in alloc_clt
Message-ID: <Ye0xoRrzREjEmqGp@unreal>
References: <20220120103714.32108-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120103714.32108-1-linmq006@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 20, 2022 at 10:37:14AM +0000, Miaoqian Lin wrote:
> Callback function rtrs_clt_dev_release() in put_device()
> calls kfree(clt); to free memory. We shouldn't call kfree(clt) again.
> 
> Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index 7c3f98e57889..61723f48fbd4 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -2741,7 +2741,7 @@ static struct rtrs_clt_sess *alloc_clt(const char *sessname, size_t paths_num,
>  	err = device_register(&clt->dev);
>  	if (err) {
>  		put_device(&clt->dev);
> -		goto err;
> +		goto err_free_cpu;
>  	}
>  
>  	clt->kobj_paths = kobject_create_and_add("paths", &clt->dev.kobj);
> @@ -2764,6 +2764,9 @@ static struct rtrs_clt_sess *alloc_clt(const char *sessname, size_t paths_num,
>  err:
>  	free_percpu(clt->pcpu_path);
>  	kfree(clt);
> +	clt->pcpu_path = NULL;

Like Jinpu said, it will crash, you are trying to access clt after kfree.

Thanks

> +err_free_cpu:
> +	free_percpu(clt->pcpu_path);
>  	return ERR_PTR(err);
>  }
>  
> -- 
> 2.17.1
> 
