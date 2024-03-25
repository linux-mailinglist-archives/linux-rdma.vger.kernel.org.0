Return-Path: <linux-rdma+bounces-1556-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B5588B471
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 23:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C58A71F635C7
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 22:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907537FBDB;
	Mon, 25 Mar 2024 22:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TLMprQLF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6E17F7E5
	for <linux-rdma@vger.kernel.org>; Mon, 25 Mar 2024 22:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711406832; cv=none; b=IVLwYry8GsHYBVRck/cLLGN+PhsYXXveUU1EM8D/D9St577ejIV9pTnAGR+od7bMLkD1cmYZUDk9l0oXT/0RfcqzUPK28cmOnLM1RLgJF8wmz6p/id5S+yxOWYO2md6a/1NZDBUiP/rIv1klZnRkFwJiH394fuAXcP+mTexd1NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711406832; c=relaxed/simple;
	bh=GKS0Tf6qp+BZ9KFCahLUmOaP97KsUUjEX2vETGsJmws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMP2QxPdcbT1Q1QkYbjMkrMQ6EWEGWtAiZ8TiN1pq+BFU2BJmdtl7AreD/Gx8HsamguzBFiC6g6Km8CZ2Jk+HVbYedmYMVwxif9T30wPvMGRok2TZzwjFRnDPuJLSrU2Aemxz9oERKOynphSQ3Axms2R+Nrefp7rZGkkcl+ETiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TLMprQLF; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-430c4d0408eso28785811cf.3
        for <linux-rdma@vger.kernel.org>; Mon, 25 Mar 2024 15:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1711406828; x=1712011628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MlPMTJaNGiZjUvi6saKf2R4Fpag5/u1oxV37EUoykZM=;
        b=TLMprQLFoU0fsfiXEsQ49dVFY0jaX8bOVIkyRiQE0z0vPv3TV3PTU3206uoZ9xCDtd
         JSqu7YLYqf3mtyeIrT4dZ+jmC5QcOzTh5YIadjrXkhmdccSU208K+Toqc9IDrmp0TFeA
         kp/9w/EaZ0JoiSJKcWLHl0YQmLDBoz4cvh0hSIeyn4PrYZTGHWc5NrWCKqFYpWmQprad
         hvEMUgDq0e/iqpeoma2FF+IqHaZ1GDpskBCcc05H59LcCZrN9znMdBMx45KyPPdh/5nN
         SD+vqEf85qM7dWslNxnsVFzjGEH5WTnT5OLnGkdw//x5lP4Jo33NGvFANuY+7+5oZEYT
         gJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711406828; x=1712011628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlPMTJaNGiZjUvi6saKf2R4Fpag5/u1oxV37EUoykZM=;
        b=Al5VmbQxdaksMz4ubim9FClMXjp4sbl48GKzQim09rSZm4n9CEdZAWoaP2ZlWFPfKV
         tB6PDveeUTmfACkwaAJZ8sNgB3X7f3Lcshs4Ti0+VY/HxXNFJRYfQ7rE6DvLjt5oeckA
         asdQ3AQZMn5kMgLQRj9JaB0NXRirwdbHIFXNp2ktALLoeZYRN0GZMZf2CtUvNzd5bz40
         VZsA2NNyCoU/gaHwVulx9zaQJBJHQnuoYB3dT1m4+9yU9rhk8XhP5FMpd9Xxpr9thGCY
         yYc9XrxdO/xOsp3xC5IS2SqZGKVjSyei0BEbVRNUVKIzljr1S768UA2gpquegTUOhtsu
         BURw==
X-Forwarded-Encrypted: i=1; AJvYcCVovBA3SuE3A6Ovf31T8pUDpSg4+KJF64MR6Z0IXoCKJCR+3mU0e84hv06N8XRAckRjkPk+kRUmN2f2EBoOupMpgtU3c+MWjtZZMA==
X-Gm-Message-State: AOJu0YxVNRoj5YJKPIE8v1GCqDPYL9ptCPkMFs5hM3+HhiG/LN0dRsEh
	kZlYhJuRjG6BXUN8QbBSNrn+2ZI2TuTIxwvDngpzsDed68pLN2r6xGA/gtSEo04=
X-Google-Smtp-Source: AGHT+IGDPiepzyYCbNq3PzR9FEl5rqH5RJZULTTzRDmX08wdPkssFOKZgU0ofAN2KeN76EJt1Kopyw==
X-Received: by 2002:ac8:5a8c:0:b0:431:621d:46ed with SMTP id c12-20020ac85a8c000000b00431621d46edmr2407680qtc.28.1711406827783;
        Mon, 25 Mar 2024 15:47:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id cr10-20020a05622a428a00b00430a44f49dasm3048635qtb.7.2024.03.25.15.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 15:47:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rot5u-001VXC-N0;
	Mon, 25 Mar 2024 19:47:06 -0300
Date: Mon, 25 Mar 2024 19:47:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] RDMA/cm: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <20240325224706.GB8419@ziepe.ca>
References: <ZgHdZ15cQ7MIHsGL@neat>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgHdZ15cQ7MIHsGL@neat>

On Mon, Mar 25, 2024 at 02:24:07PM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> ready to enable it globally.
> 
> Use the `struct_group_tagged()` helper to separate the flexible array
> from the rest of the members in flexible `struct cm_work`, and avoid
> embedding the flexible-array member in `struct cm_timewait_info`.
> 
> Also, use `container_of()` to retrieve a pointer to the flexible
> structure.
> 
> So, with these changes, fix the following warning:
> drivers/infiniband/core/cm.c:196:24: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/infiniband/core/cm.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> index bf0df6ee4f78..80c87085499c 100644
> --- a/drivers/infiniband/core/cm.c
> +++ b/drivers/infiniband/core/cm.c
> @@ -182,18 +182,21 @@ struct cm_av {
>  };
>  
>  struct cm_work {
> -	struct delayed_work work;
> -	struct list_head list;
> -	struct cm_port *port;
> -	struct ib_mad_recv_wc *mad_recv_wc;	/* Received MADs */
> -	__be32 local_id;			/* Established / timewait */
> -	__be32 remote_id;
> -	struct ib_cm_event cm_event;
> +	/* New members must be added within the struct_group() macro below. */
> +	struct_group_tagged(cm_work_hdr, hdr,
> +		struct delayed_work work;
> +		struct list_head list;
> +		struct cm_port *port;
> +		struct ib_mad_recv_wc *mad_recv_wc;	/* Received MADs */
> +		__be32 local_id;			/* Established / timewait */
> +		__be32 remote_id;
> +		struct ib_cm_event cm_event;
> +	);
>  	struct sa_path_rec path[];
>  };

I didn't look, but does it make more sense to break out the path side
into its own type and avoid the struct_group_tagged? I seem to
remember only one thing used it.

Jason

