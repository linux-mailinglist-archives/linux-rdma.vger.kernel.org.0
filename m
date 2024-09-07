Return-Path: <linux-rdma+bounces-4808-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A36B970224
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Sep 2024 14:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50992283CC5
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Sep 2024 12:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF41415B10A;
	Sat,  7 Sep 2024 12:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="loIIogrp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE081DFCF
	for <linux-rdma@vger.kernel.org>; Sat,  7 Sep 2024 12:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725711131; cv=none; b=T/iWxFTRvTOOlKB6B+U81P/+eKQKCfTaq5Fph2V4crxpXjgy8MF+RyR35xQek9ppZ4wpkXKIs3V7Q1Mork/4EQ8A1c1mgnShVTJdy8KouMbd85g0ykx1cPkHF0pS3N8GM2FxJESEqS7/rhWUlTcjaZzvwjCwRhJmiN0JwAIbli8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725711131; c=relaxed/simple;
	bh=KJ399UOI0Wdiv5eE0UhZrvxHLTIAQhQQPvmKq5Hu7JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1W3TglJFrp8gT9LG7/wpGggiNpt+hU2uhtOjTjJYTOF30FF5beMwdzhUosBI+4A0lGTSCLce3gDrn3pWOm2PxCqJzSMF6Hx/2SS+LDHP4gXzviI6M9aXMQWBpDyGMEfMtJOyjSYNg5bE37f/TNoNKm4P8pqJWm3wQaEXabst+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=loIIogrp; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6c3552ce7faso26770406d6.1
        for <linux-rdma@vger.kernel.org>; Sat, 07 Sep 2024 05:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1725711128; x=1726315928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qIk+dP3X9sflyyjWYrNOlRzvjymaxZ0BwT+e1OMyylk=;
        b=loIIogrpy7nrYBiPGBi2d1M3AHjtMrwoLxCfdxMaOWpKicehIbcLNWWsf0AckEHlJe
         3r1SX6lwwiIK7uMZSPui0TVdW7iruueu2dALah019x5I/lJcyFA3JsMyDY5s83MLMD7z
         wMY989iDl8daKTk3EGTxPzsfgwrvnxuILMZF6UebqpClfCEvx1zkhzzKC8F9m3vJr9dJ
         Nn3BDUO/tu+zfQrr1u7LAgXjRlFiOvzKvrNLffi/+LKYC22yj95LtwsW9DKZmq/vzh+M
         /JbzLzrEqbUvZMtAqjp4MOg7PdQbe61crgCs2K7zaVaWc7mp6k43ifTZvqQ7CpcWfFDp
         XgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725711128; x=1726315928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIk+dP3X9sflyyjWYrNOlRzvjymaxZ0BwT+e1OMyylk=;
        b=PMYAzr85SGV1DWIwLtSu73Qf7ee4Uzl1qPuBMLk9tu3Hl59zc9oFnu9ZcV/YC3bMkF
         oyCjiQ4/irfoPN1JtxxqZsWjKUfgkdp/NQ8l2A/VpCsCddIi5xp0vqg6TLNm7Z/WKgUv
         vZ7tpis4ZZR1h3geCfBQhkvgku4Dfbi1vC8t4r2jOF1b+MUO82AeU9upCD0tZcafjliK
         yH0j2kcUXeBnvNjJhp0a6Rkbn4Qq6rhilDpFlA8d8Wdgt6o8VJ4O8cnlAypa/kU6W6Z3
         mLYdkrmHtn12QociehOUt4a11XHywtj1rCXcieaZwbSXqDcfnMogY/k/iaHL6jhDrieT
         jdvg==
X-Forwarded-Encrypted: i=1; AJvYcCW1DGEjJaPFrYGHqjA7k/71w5+RADt79tEWXJX6qxhkAYqQNi5Dg/HNaR8Ncb19YR8tK8ueGqaibsxt@vger.kernel.org
X-Gm-Message-State: AOJu0YxnBERLmZuFrBDyB7/wMZM4i2wB3/SaE2np8a222CP51koOoovu
	lMe22rMvgD6wXz50Z50Oy2zAE6gnF0ltGGgOHRPqNfJfWVQIlhuPVE4sx9ylxx28mHK/2nGeIky
	l
X-Google-Smtp-Source: AGHT+IGJu+1xkqqBw4YXIoVjgG9lBWSbDHS+BxHN/Rvx1jZzb2l1o7Z3TkAbgHq3jyO8sHe0U5NV4g==
X-Received: by 2002:a05:6214:438a:b0:6c3:5c75:d2b1 with SMTP id 6a1803df08f44-6c5282faac1mr103618346d6.5.1725711128495;
        Sat, 07 Sep 2024 05:12:08 -0700 (PDT)
Received: from ziepe.ca ([24.114.87.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53474d867sm4109576d6.83.2024.09.07.05.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 05:12:07 -0700 (PDT)
Received: from jgg by NV-9X0Z6D3. with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1smuIR-0001Nn-MJ;
	Sat, 07 Sep 2024 09:12:07 -0300
Date: Sat, 7 Sep 2024 09:12:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 for-next 1/2] RDMA/core: Provide
 rdma_user_mmap_disassociate() to disassociate mmap pages
Message-ID: <ZtxDF7EMY13tYny2@ziepe.ca>
References: <20240905131155.1441478-1-huangjunxian6@hisilicon.com>
 <20240905131155.1441478-2-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905131155.1441478-2-huangjunxian6@hisilicon.com>

On Thu, Sep 05, 2024 at 09:11:54PM +0800, Junxian Huang wrote:

> @@ -698,11 +700,20 @@ static int ib_uverbs_mmap(struct file *filp, struct vm_area_struct *vma)
>  	ucontext = ib_uverbs_get_ucontext_file(file);
>  	if (IS_ERR(ucontext)) {
>  		ret = PTR_ERR(ucontext);
> -		goto out;
> +		goto out_srcu;
>  	}
> +
> +	mutex_lock(&file->disassociation_lock);
> +	if (file->disassociated) {
> +		ret = -EPERM;
> +		goto out_mutex;
> +	}

What sets disassociated back to false once the driver reset is
completed?

I think you should probably drop this and instead add a lock and test
inside the driver within its mmap op. While reset is ongoing fail all
new mmaps.

>  	/*
>  	 * Disassociation already completed, the VMA should already be zapped.
>  	 */
> -	if (!ufile->ucontext)
> +	if (!ufile->ucontext || ufile->disassociated)
>  		goto out_unlock;

Is this needed? It protects agains fork, but since the driver is still
present I wonder if it is OK

> @@ -822,6 +837,8 @@ void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
>  	struct rdma_umap_priv *priv, *next_priv;
>  
>  	lockdep_assert_held(&ufile->hw_destroy_rwsem);
> +	mutex_lock(&ufile->disassociation_lock);
> +	ufile->disassociated = true;

I think this doesn't need the hw_destroy_rwsem anymore since you are
using this new disassociation_lock instead. It doesn't make alot of
sense to hold the hw_destroy_rwsem for read here, it was ment to be
held for write.

Jason

