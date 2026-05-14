Return-Path: <linux-rdma+bounces-20694-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gI4KCtS8BWpZaAIAu9opvQ
	(envelope-from <linux-rdma+bounces-20694-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 14:15:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AE45417AE
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 14:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EFE243067EC6
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 12:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFA13CAA53;
	Thu, 14 May 2026 12:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="T4EHx3mx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E63E3C9EED
	for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 12:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778760854; cv=none; b=XAXSZV7MHeRlZcpt5OwGZlWZGhb4UKBB+XpsZzHAnhad3Uslp3LBQV2SB5o3r8oJMDSEmGjvF288jT7b1pKB67SHLpNAuMN5eedzTGfEkO3M8dLt0xKHLByrVBGCJdlM96e+1gSHZqliVSNGJ2afIl6PCDmBUPvEWK3OyqqqA48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778760854; c=relaxed/simple;
	bh=R6sGZF7vzTwTYdla5S2B+rw5X9Bbxny3sNjidz6ghO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDUdv6IP6O72nndmQ96BL1aVCe40rEBDXifRbO5ZN4vv3Honv8l7gV38c5MwVF5M/kedBnIvf2T2zQ3Uh6LY+jgtOviiXR6BfGMYGrNyv6nieYo9mF9bUJ+cSpN+7B/JUKJiiVXr4Tsb04Fx7EJUXAkF7/IsLYSY9XiPfnVXyfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=T4EHx3mx; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8bb4e8a5240so86357376d6.1
        for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 05:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778760852; x=1779365652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/MT0eJslCDNYE32pK1HudZRBK2yJc5vJCuALbEocNuU=;
        b=T4EHx3mxT1rSGC54UaaGrM4Tz158dzhf1/N5f1WsFV2JqPbjXtFGDMID+J6yKmboo2
         P8SoS89+gnuybFxQCtXz/ZhLaUvh7Cj1BRRpaR38p0ggSlyscsTP+xG8NvPIXCuo5AIi
         D7SczbHNyeHmtDKZrh9RGwBDizVMaZ1NRoyG7nf4+jSHy7LydY/6djgQpqlLZlllqHl5
         MGjNbylcfiBVZP1IqjnEDnv+aSeClC0Ykn/7yFEzakhzgVTeAZFd/mii/6nRzu5cybYh
         YV/9CarlnZHfIfAL+D3+NuaeC1GA0agLDned/P+pU6SVB7AnptxTZ0DNYJJ/pdKGKZGF
         pPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778760852; x=1779365652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MT0eJslCDNYE32pK1HudZRBK2yJc5vJCuALbEocNuU=;
        b=FLylV7b2KgMB4ji/cNSxOkr08n04wyq9ph8PkaGskNPie1p/bDQ8dIxWysuXxS+8Ot
         wDGj/x0WllBpTymL2UYqa6oinQWyaYA+L4UmwMmPVf4YQ0s8UuENOHfECROGWxul+8a0
         gfAyyese9XnYNd1bjA8JfdO1Pb0mMxgrN/bA7hvjVKCq11sjAiXTsMd3iGX03EIZ9uGL
         DkVQuQ8dftj4QHc/ea93NeGyIANR5/KKHd+3eotFeVHUOZ/I4CmSpnKQ6JtOEK22v0nh
         +q9IQjDN+7YwVGMGDqk5KpAWKu0+/zS+itFwgy5lkfjx41FmxHd/79GcVDhwkKEJ1xzs
         1djA==
X-Gm-Message-State: AOJu0YySJKrfOaiGqaoAJQ/GSh0v2CyZksaUtD7bqstylO/Z1Ml2ncmW
	ldAJMbJUusDyXGaYVPBkm7upTbNcF8Qk5kBVq7tq9F4y0Ndmldbp7hPOcZh5f8/sZe0=
X-Gm-Gg: Acq92OFGGAhbpSwr1zE6SUVrgIerFiTVjG+SscIEee1/Q2UtX//b3grCyrYTxosnnff
	iO4qf2OvvBMpF4xYJHGyS2ixjFqk5Mhoy3BVRXb9v4FUgbS1L//6iLtZMkNItMuYDZ0ICDW9RZB
	P4PcyjGcQKLypxehU3qHSKNSB3dVkfsbEx0RPWkIv4L3dSbThkxswW2d3e07LCTQloGUNJHwyFO
	TNA28qi2okfx5S+Jz5S5Aw2KTLRi4hBAka7z/7YyWcga82Y26EhpG3eoFCjNe1ph1e+kb9jkF4k
	f+wpqgblI0EyRRj8ylrIBderiSmfZtk7azmfI8qnTXFdOx3mH/XuSDTewMG6240AilceBGxYftI
	oJfiJxEeZDAKNO1tr3xQXt5qkHzDKIWTTCGYj2G8Scy77bPfvHpvT9GOV0mcLngw/WnpKtsxu6d
	1nyRgtbwKbPlnqwtbb1Y4UPELSd8IK7seQbebDefvWgDrusPnuG7c9EcuUfXUX0J/t1uMNLbI+S
	ERfESzW2zYebtLe
X-Received: by 2002:a05:6214:3481:b0:8c4:3588:ae19 with SMTP id 6a1803df08f44-8c7bdd7e54cmr113425866d6.48.1778760851418;
        Thu, 14 May 2026 05:14:11 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c908d1d2e7sm21799806d6.16.2026.05.14.05.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 05:14:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wNUx8-000000059Qi-1Led;
	Thu, 14 May 2026 09:14:10 -0300
Date: Thu, 14 May 2026 09:14:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, mrgolin@amazon.com,
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com,
	mbloch@nvidia.com, yanjun.zhu@linux.dev, marco.crivellari@suse.com,
	roman.gushchin@linux.dev, phaddad@nvidia.com, lirongqing@baidu.com,
	ynachum@amazon.com, huangjunxian6@hisilicon.com,
	kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com,
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com,
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v3 03/17] RDMA/core: Introduce generic buffer
 descriptor infrastructure for umem
Message-ID: <20260514121410.GY7702@ziepe.ca>
References: <20260504135731.2345383-1-jiri@resnulli.us>
 <20260504135731.2345383-4-jiri@resnulli.us>
 <aftENVgTr8AZVQnT@ziepe.ca>
 <aftL-2sJb4JfyDIs@FV6GYCPJ69>
 <20260512181236.GA175362@ziepe.ca>
 <agTNeYSOyMTbUbNt@FV6GYCPJ69>
 <20260513233447.GU7702@ziepe.ca>
 <agWOldIWkFI3i1xB@FV6GYCPJ69>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agWOldIWkFI3i1xB@FV6GYCPJ69>
X-Rspamd-Queue-Id: 96AE45417AE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20694-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 11:02:45AM +0200, Jiri Pirko wrote:
> >> There's no addr_size because no caller has a user-passed
> >> length distinct from the driver-required minimum.
> >> Drivers either have no length in their legacy ucmd (mlx4/mlx5 CQ, mlx5 QP,
> >> the size is driver-computed from entries*cqe_size etc.) or they
> >> pass ucmd.buf_size which serves as both (vmw_pvrdma, qedr, mlx5
> >> SRQ, ...).
> >
> >This is what I was wondering about, so how does it work when there is
> >a ucmd.buf_size and also a minimum size computed from
> >entries*cqe_size? What does the driver write?
> >
> >I think the driver has to pass in both the minimum size computed from
> >entries*cqe_size and also the uhw exact size? The minimum size is used
> >if the uhw path isn't used to check the other attribute while the uhw
> >exact size is used to pin the memory if the uhw path is used - and it
> >should also be checked against the minimum?
> 
> I asked Claude to check every caller: At the moment of conversion
> none of them would have addr_size != min_size. They split into
> three groups:
> 
>   1) Driver-computed total only (no user-passed length distinct from
>      min). addr_size == min_size by construction:
> 
>        mlx4 CQ/QP/SRQ           entries * cqe_size, qp->buf_size, ...
>        mlx5 CQ/QP/SRQ           entries * cqe_size, rwq->buf_size, ...
>        bnxt_re QP/SRQ/CQ-resize max_wqe * wqe_size, entries * sizeof
>        mana CQ                  cq->cqe * COMP_ENTRY_SIZE
>        hns_roce MTR             mtr_bufs_size(buf_attr)
>        qedr SRQ producer pair   sizeof(struct rdma_srq_producers)
>        all DBR helpers          PAGE_SIZE

OK these make sense

>   2) MR registration / opaque user umem. The user-passed length *is*
>      the request; there's no separate driver minimum. addr_size ==
>      min_size by definition:
> 
>        reg_user_mr in every driver
>        mlx5 devx user umem

MR has to use the exact size passed in the top level system call, so
it probably needs some special helper that does that instead of minimum
 
>   3) User-passed length without a driver minimum cross-check today:
> 
>        vmw_pvrdma CQ/QP/SRQ     derivable min (entries*sizeof, wqe_*),
>                                 not computed in the user path
>        qedr CQ/QP/SRQ           ureq.size, no min computed in wrapper
>        mana WQ, QP raw_sq,
>             QP RC queues        ucmd.{wq,sq}_buf_size, queue_size[],
>                                 no derivable min
>        ionic CQ, QP sq/rq       req_cq->size, sq->size, rq->size,
>                                 no derivable min

Yeah, these are exactly the ones I'd expect to have a second
parameter. Something like ucmd.wq_buf_size should be entirely ignored
if the user passes a new attribute, not silently used as a minimum
check. That logic has to be done in the helper

So you imagine another helper for these four drivers with an
additional parameter?

> Given that, I'd prefer to keep the single size argument for now and
> spell the contract out in the kdoc:
> 
>   @size: minimum required umem length, validated post-pin against any
>          descriptor produced via @attr_id / @legacy_filler; also used
>          as the pin length on the VA fallback path. Callers that have
>          a distinct user-passed length must validate it against their
>          driver minimum before calling.

> If/when a driver actually needs distinct values, splitting into
> addr_size + min_size is mechanical.

Ok, maybe mention in the commit message this has trouble for the four
drivers in group 3

Jason

