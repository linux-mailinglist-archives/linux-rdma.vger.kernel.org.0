Return-Path: <linux-rdma+bounces-4307-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F4994E08B
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Aug 2024 10:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA07F1C20E34
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Aug 2024 08:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEC3219FC;
	Sun, 11 Aug 2024 08:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHjGlFkB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3D61C6B4
	for <linux-rdma@vger.kernel.org>; Sun, 11 Aug 2024 08:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723365514; cv=none; b=XDPFp5XC1Ka3YAGe5lPSa9VtbTTu/cjCETHFpaVxEcI5wr2ZuYGyxHKIGtFR/QUC50EndluV4E9TkZK2JZOsN0rKqJpfLsZV0bLC56bEGlWGMysvs0xETIXc4ynoawp658ewn7/aVZqPMLQpHUQcQ/2dxANVEh++OMX6s2YaY5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723365514; c=relaxed/simple;
	bh=wmTFfUsozGHRZ3LgUMKz60baPoH3jgjVgWIy1DFRb8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gboV0HE3kvnNocfaWYZONhScSfZGrlg58kQDcRdy26pMl17LhFD9V8tsqc1LW03lRRK8MVvrVB4uct+9OsoYAbF1dc5xKnT4WUFTP2kg8bFhDZvsuravX435CON4lOxcYRIsZ6olPeMhkG3aDZHJmc9E5YCA8bE4oVVEF7rco2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHjGlFkB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9070FC4AF0C;
	Sun, 11 Aug 2024 08:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723365514;
	bh=wmTFfUsozGHRZ3LgUMKz60baPoH3jgjVgWIy1DFRb8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sHjGlFkBWE/3XTA6pjlEHFgEv5jN+Rm/m2aDE/DLnfMK7XOWgArJ2XKz5tXeq3uy/
	 XYHA8f0SquNd0esEamkBHaJCCK5Bdods5irhfVmzIZtlqVSL+lFdzmfBdK3ok5X7Rp
	 DmJ4H+01V5tBb84UX/w4MkULuPeCCEoi7Acgzip8WSHNT+5yzG056GPVx1ViLfIP1t
	 HmunQcqqx2cM+9VTeU7md3qCicGSjmy0cKfC9TxExUa22wQ/VNuox3irI7lS9h+2F1
	 e8pGU2PHvZvBfmYvM7RRgpos58Ij1dxU8enA57dQ/e1EQ2Ites/UKJ9FaRi0eXtKNj
	 YkPzBzGuPgJtw==
Date: Sun, 11 Aug 2024 11:38:30 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Md Haris Iqbal <haris.iqbal@ionos.com>
Cc: linux-rdma@vger.kernel.org, bvanassche@acm.org, jgg@ziepe.ca,
	jinpu.wang@ionos.com,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: Re: [PATCH for-next 01/13] RDMA/rtrs-srv: Make rtrs_srv_open fail if
 its a second call
Message-ID: <20240811083830.GB5925@unreal>
References: <20240809131538.944907-1-haris.iqbal@ionos.com>
 <20240809131538.944907-2-haris.iqbal@ionos.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809131538.944907-2-haris.iqbal@ionos.com>

On Fri, Aug 09, 2024 at 03:15:26PM +0200, Md Haris Iqbal wrote:
> Do not allow opening RTRS server if it is already in use and print
> proper error message.

1. How is it even possible? I see only one call to rtrs_srv_open() and
it is happening when the driver is loaded.
2. You already print an error message, why do you need to add another
one?

Thanks

> 
> Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 27 +++++++++++++++++++++++---
>  drivers/infiniband/ulp/rtrs/rtrs-srv.h |  1 +
>  2 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> index 1d33efb8fb03..fb67b58a7f62 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -2174,9 +2174,18 @@ struct rtrs_srv_ctx *rtrs_srv_open(struct rtrs_srv_ops *ops, u16 port)
>  	struct rtrs_srv_ctx *ctx;
>  	int err;
>  
> +	mutex_lock(&ib_ctx.rtrs_srv_ib_mutex);
> +	if (ib_ctx.srv_ctx) {
> +		pr_err("%s: Already in use.\n", __func__);
> +		ctx = ERR_PTR(-EEXIST);
> +		goto out;
> +	}
> +
>  	ctx = alloc_srv_ctx(ops);
> -	if (!ctx)
> -		return ERR_PTR(-ENOMEM);
> +	if (!ctx) {
> +		ctx = ERR_PTR(-ENOMEM);
> +		goto out;
> +	}
>  
>  	mutex_init(&ib_ctx.ib_dev_mutex);
>  	ib_ctx.srv_ctx = ctx;
> @@ -2185,9 +2194,11 @@ struct rtrs_srv_ctx *rtrs_srv_open(struct rtrs_srv_ops *ops, u16 port)
>  	err = ib_register_client(&rtrs_srv_client);
>  	if (err) {
>  		free_srv_ctx(ctx);
> -		return ERR_PTR(err);
> +		ctx = ERR_PTR(err);
>  	}
>  
> +out:
> +	mutex_unlock(&ib_ctx.rtrs_srv_ib_mutex);
>  	return ctx;
>  }
>  EXPORT_SYMBOL(rtrs_srv_open);
> @@ -2221,10 +2232,16 @@ static void close_ctx(struct rtrs_srv_ctx *ctx)
>   */
>  void rtrs_srv_close(struct rtrs_srv_ctx *ctx)
>  {
> +	mutex_lock(&ib_ctx.rtrs_srv_ib_mutex);
> +	WARN_ON(ib_ctx.srv_ctx != ctx);
> +
>  	ib_unregister_client(&rtrs_srv_client);
>  	mutex_destroy(&ib_ctx.ib_dev_mutex);
>  	close_ctx(ctx);
>  	free_srv_ctx(ctx);
> +
> +	ib_ctx.srv_ctx = NULL;
> +	mutex_unlock(&ib_ctx.rtrs_srv_ib_mutex);
>  }
>  EXPORT_SYMBOL(rtrs_srv_close);
>  
> @@ -2282,6 +2299,9 @@ static int __init rtrs_server_init(void)
>  		goto out_dev_class;
>  	}
>  
> +	mutex_init(&ib_ctx.rtrs_srv_ib_mutex);
> +	ib_ctx.srv_ctx = NULL;
> +
>  	return 0;
>  
>  out_dev_class:
> @@ -2292,6 +2312,7 @@ static int __init rtrs_server_init(void)
>  
>  static void __exit rtrs_server_exit(void)
>  {
> +	mutex_destroy(&ib_ctx.rtrs_srv_ib_mutex);
>  	destroy_workqueue(rtrs_wq);
>  	class_unregister(&rtrs_dev_class);
>  	rtrs_rdma_dev_pd_deinit(&dev_pd);
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> index 5e325b82ff33..4924dde0a708 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> @@ -127,6 +127,7 @@ struct rtrs_srv_ib_ctx {
>  	u16			port;
>  	struct mutex            ib_dev_mutex;
>  	int			ib_dev_count;
> +	struct mutex		rtrs_srv_ib_mutex;
>  };
>  
>  extern const struct class rtrs_dev_class;
> -- 
> 2.25.1
> 

