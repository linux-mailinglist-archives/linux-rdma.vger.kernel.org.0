Return-Path: <linux-rdma+bounces-22089-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rnRaGSqjKWpcbAMAu9opvQ
	(envelope-from <linux-rdma+bounces-22089-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 19:47:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF0566C0AA
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 19:47:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=PLyYXZkW;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22089-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22089-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B0E9302D09C
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 17:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF4532B10A;
	Wed, 10 Jun 2026 17:45:14 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE74234D93B
	for <linux-rdma@vger.kernel.org>; Wed, 10 Jun 2026 17:45:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781113514; cv=none; b=Gw5StKE5nQ3njeAAOxbmkjWxx7Cuqf8Adz1eMEoGuDmLCFIEQeVP8bvxqsWqM2foUU8ZThxToyuy0gkOf/FUsW51CCt9wNg8Ll+jD42cGPSgNaQDyXGVCt9NtkUnrWdiI/YR3cpx9ZzeSR2m8glIrAMxBZLSUQIZhYkZP7ayvMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781113514; c=relaxed/simple;
	bh=daQUOE9k5fpWJOqT4xaW+WPhdG1ed6aOPgfvpOaEIEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8Hkf5r55z5Woof5uThartKo/ZCzLVmufoVpDHPa9OvSrQG0ql41nXQxqVvVzrEE1x1EY7amIDY7SXpn+uuZVMFt50ASo+K1cC3pOmyt9dFsUADyXW6udQuT61jnkrAxOL+51atLIJAhAbVcacSRd7lik4cdb3xPeJS1xPO5BKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PLyYXZkW; arc=none smtp.client-ip=209.85.160.176
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5177945a22eso48208781cf.1
        for <linux-rdma@vger.kernel.org>; Wed, 10 Jun 2026 10:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781113512; x=1781718312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TznMgKk0/8JcLdqAZMC+NOYEFrWh7GnGXI72Bh61yhk=;
        b=PLyYXZkWN4EqnSz9utZu0S0wTmxl6zh97ZYsaKCuxGhcgjgEn/eNmbgHer3BbUXn+g
         akbA3Bh+Us787wdUZrR0tMTfoGzsdXaxKQChd69PZvzuNvODZf//rZT0qcRL1q4Ne7hP
         7Ymm8j33Xmy6zRSojb6GJ0fGcAkyvCYcW2ubgPwPtt/n4n1vYUTaAlwSYlDSvWRgubj5
         e3H+Jarek3EvqV8lBOMStNUCClZt9lCeBv5akO5yxFt5d3mU6Jb1IDhO1NPDIh5lLLbN
         X86kXVoXs8nEEKNOSiH2VYXhpQg7s/edIlJGoIMXBKeGJGm8TzZjDWZ3L5kAB1wTAG98
         pxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781113512; x=1781718312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TznMgKk0/8JcLdqAZMC+NOYEFrWh7GnGXI72Bh61yhk=;
        b=R6XYoSc2/bRBbnb/cGetuomutOAtUerTFdiKmljhJBvCT+m090kjWX50JO/6FQtwny
         3JM7ot+naMBwdkteR7iH+kEfgMQAKoTGhAWO6mXf0HD8TvODIyDjY0liIez0JX1+h/VV
         yFQ/8uO0FUx/224Ck++jL9lvj4lk8f1sHXiEizeFK1nF+4Ny6coHk7FD9+MQyPLa/lX2
         dTO7MtKEN2Ibuf6FhTA8RO8AdEINikC4T/gaPoIDa4qVuqQclmxXLpAXEYnjxSCtWO0l
         elq/nBsChLVnKVtyC2ubnD67UpLDGmsshAe4QWy53Jo/PRrTowCGVrZ3FIK+3/rmhK7L
         grcw==
X-Forwarded-Encrypted: i=1; AFNElJ/zGVvT0eMSPWtARBFd3EhlHLWN5m21i1JFPg4NaUbxPIBpFuS+cZ7TDOOnWK633XwWOtPIt8o3b8vz@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6nprIdeMb2aweon8RsuJwRXKwWF88Ab6WK425qUXf0k83myz/
	bx0e3oAl6IWzqkEgu8jCZTYS3HniKV3FzPd2hgxdsDaDYJLya1Ak9Fgjb78OYX67ZrI=
X-Gm-Gg: Acq92OFkOcyP9EP+kro0gD3YuPWSp0x/0UGWsLhDXvBG2J2sC22ZA86dVwotx0Fn8Pk
	XZ0OQpJtQ2OcuqXOCH+1WWX+GPqrlLyoPowYZtwNK+FRWy24IJyIQKjoZlTaksnfiZd6mgGGLht
	V/cZaALaael8brKvgV5psB5KAEx7hgsmk50sGXbFwJX0xwswOyAFkPbmdxWYjhZe3cwDP0f4dO7
	8rIRlTApqlxqIM6EC9ocGHBfPTRELWeYbnljNBaqClXVZy8TEhrCaAajTVTC7HymmQC+03ng79u
	TfWO1j9BRvYYFRx8VjskUTjPVWVJYpSj5IMHKSUxxt9vzATPz35a+1xfDKQMU0MhAz+hPoyx7Vx
	hJMFbxB4gO3D36P7RhJj8x4qOwmrSbzdP/dukZZDulWSTRqshB5oYOb5D0p8T/5OM1rJLWYH+AY
	GHLaWi2FeG8EUuDI+nqVVYhPjYrrUVLbfOhdC7tcCPapBLlzxOfNpJiiLyZ81YyJWqCg1nFYrEr
	DaUsXlRdfdBsQEN
X-Received: by 2002:a05:622a:586:b0:517:76b7:7b3e with SMTP id d75a77b69052e-51795be20f9mr379377021cf.38.1781113511786;
        Wed, 10 Jun 2026 10:45:11 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775c2e2casm218655041cf.9.2026.06.10.10.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 10:45:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wXMzG-00000004Eq8-32fO;
	Wed, 10 Jun 2026 14:45:10 -0300
Date: Wed, 10 Jun 2026 14:45:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Michael Gur <michaelgur@nvidia.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	Edward Srouji <edwards@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>
Subject: Re: [PATCH rdma-next 0/9] FRMR pools fixes
Message-ID: <20260610174510.GR2764304@ziepe.ca>
References: <20260610000145.820592-1-michaelgur@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610000145.820592-1-michaelgur@nvidia.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22089-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:michaelgur@nvidia.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:edwards@nvidia.com,m:yishaih@nvidia.com,m:phaddad@nvidia.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,sashiko.dev:url,ziepe.ca:dkim,ziepe.ca:mid,ziepe.ca:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BBF0566C0AA

On Wed, Jun 10, 2026 at 03:01:36AM +0300, Michael Gur wrote:
> From: Michael Guralnik <michaelgur@nvidia.com>
> 
> This series addresses several bugs in FRMR pool handling.
> 
> Patch 2 fixes incorrect masking of TPH-related bits in the FRMR pool key,
> which caused stale TPH values to be used when creating handles from an
> empty pool.
> 
> Patch 3 fixes set-pinned flow to use the pool key returned from the
> driver build_key callback instead of the raw key supplied by user.
> 
> Patch 8 extends the FRMR pools API with a new drop() operation.
> This allows drivers to update pool state on handle destruction when
> revocation fails, without incorrectly returning the handle to the pool.
> 
> The remaining patches fix error path handling, covering cases where memory
> allocation fails during queue expansion, and where handle creation or
> destruction operations return errors.
> 
> Michael Guralnik (9):
>   RDMA/mlx5: Fix mkey creation error flow rollback
>   RDMA/mlx5: Fix TPH extraction in FRMR pool key
>   RDMA/core: Fix skipped usage for driver built FRMR key
>   RDMA/core: Fix FRMR aging push to queue error flow
>   RDMA/core: Fix FRMR set pinned push error path
>   RDMA/core: Avoid NULL dereference on FRMR bad usage
>   RDMA/core: Fix FRMR handle leak on push failure
>   RDMA/core: Add ib_frmr_pool_drop for unrecoverable handles
>   RDMA/mlx5: Drop FRMR pool handle on UMR revoke failure

These fixes seem OK and Sashiko found two more:

https://sashiko.dev/#/patchset/20260610000145.820592-1-michaelgur%40nvidia.com

Can you send a followup?

I'll pick this up tomorrow

Jason

