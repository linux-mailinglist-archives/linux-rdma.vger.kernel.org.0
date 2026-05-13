Return-Path: <linux-rdma+bounces-20620-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMUfKaAKBWo1RwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20620-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 01:34:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 183C453C0C0
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 01:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6199301F49F
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 23:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2098E3C1F41;
	Wed, 13 May 2026 23:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="g5N+L9Vf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150E33655F5
	for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 23:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778715291; cv=none; b=XUKecT/RdZKJKg9bb+6TPSHcd6SbdnJIaZHsz0neMDHXr2jo/vpqyG/+cG4tfQuGq6VEMQJyvCcLVZCiUfEt0JU6YNpO2uJADX47cJBl9dM9ZB3Y8f3O/hPVOiUHMNc5SckuSFe3L1tY3SwPyLVHLi9SF2fGd4x7DL6SCW92QFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778715291; c=relaxed/simple;
	bh=2PxqC60T3SXprCNNVswrESjE6ywXLrFQ2wTFxZSoLDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2p/dhqZequOnLAKhae14tswiwwQJf8GyXP9A3GpGksX0rrdew2YKJGseXUTRfOt6ElX2z5hVZEWxOFjweIbOfnLAvID5yBt/V7VV2ORt3XfwOdIwY/M2DmG0WZofYDG10djKw5Fkrtlkwi5nAx9reFxw7nHLm5PFiqVfHV4NIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=g5N+L9Vf; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50e614fdb42so57279901cf.3
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 16:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778715289; x=1779320089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nq8nAEVCBVeS3MITszvnGtA0frJcxXLRk3P6LIRDU1o=;
        b=g5N+L9Vfm3w89+xKKK5BzgrbI+J68YZj9giwBAXQmwiSyr5CaGrylT/e3bCr4fNzFh
         EeQxWCgxQ7UaaghMEVy9CgNS+4PHgeBI5uddnJuhtGv2hchVRUkaQcOCJ1pMWs08QVwF
         0J/IuWeNEPZ3V3fIWl1/tsWz+WHk14LnjwUaNqdmub1yZQ2SFMLJsPTPvn6dFryOxMrJ
         Fty8nVDOANgMNthkD63GI1YrXgF5k4xyCTwCGuD7akl1/NVLzRvPwrSUpXtzPoYNSkFy
         FtkD8xLOz7zI9MrTfhdojLIzILDFY3Gi24MCmiOrcWdTsKMYWo41Xe1/eaPvqAjUhS8m
         NQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778715289; x=1779320089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nq8nAEVCBVeS3MITszvnGtA0frJcxXLRk3P6LIRDU1o=;
        b=kQf35P8o7SNzEiGyVv6veXvRVMO4kvBk23N8dmncx9ByXACd8mFzg0RCPzWEsRMA+R
         7XjrUd9q2BT0OdanoWdGTYIRLELAIUEXUESfa5ECB9CH793ZVnvgg1C5U2OyYpc27aIj
         2trXBzVKtvCTP5GanVIzUCVrl7ZrqKk9QF8cMB/zTP6oYqDeC0Y0vvMUJkj9zEta3T+L
         sUrfDu9lbi7mmMoRJAIks+6P9n5fUnnpvcLRR38VySMgaIiL8E+IeTvgauZ1TEXq3pTv
         OSh5Tu7ptyi9OJDeo6y4DMtx/9lO5N3wLJkq8V5neyD0puIp4GoxRk5hwjSd0AAxCJaM
         7Spw==
X-Gm-Message-State: AOJu0Yxz17PxYyRrMWL7sD6uB5BCi1zlyBtoLL9q9PJ+B6spkmM/Y199
	F1OcA2G0XP08oTZidx+i8XLJbAEiZCzFbxnM0tZRUGMab/iGwoO7ENOJpig5FfHy2KA=
X-Gm-Gg: Acq92OGN7gg7GNlFYJAjmARKaYziFkMctCqJfYrwvWBwQpVpLey0HufObSYPKaLAqpe
	QHjy2E14+mSJz7PRY29Non0h7LIOmaTPNcZUmQsO2+HpoLVKeaB2QCkhJ6FNrg1/vY42Dk2YFjs
	HyshOc3Vx8hRcpuHcjhsu7LfEFPEIoEvx3NTHc4HSKiV+kLu3PXNu7/6zkPI7BjbMuZmVV45rLt
	4zJFyvbalEqjW/8MVBBs9P767yIij/vEk7vFPF3iv8Dj+9gdf40O603T42gXVo5KRk+vT4kgAVk
	KdKP0Sly6njehX+5oU1AljKxVwsfHVZ+LvmvkXCIjYgKco/BuFtmFuk3sqwRP41MGuazCtHNgPx
	2Ik/LqzBjH3IkmBznTPcTtYqBvrc1oFVwbrUniyRbWZZV1nd1qZEQclj9WaYOeSxI7UbceZjQDH
	McR0Rj5Dr8Y9EK2dA3Ef6jADDO+H/wKjAl7K+H4ft25IqZo7l4R+t4vrY66Hdk7crVrhTGNpIN5
	iDyo34U6D5+y5HJdLMp9DoPdvA=
X-Received: by 2002:ac8:5fc9:0:b0:50f:b3d2:6ee3 with SMTP id d75a77b69052e-5162f667d44mr76435931cf.60.1778715288913;
        Wed, 13 May 2026 16:34:48 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c908e1194csm10383306d6.12.2026.05.13.16.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 16:34:48 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wNJ6F-000000047bk-2RRI;
	Wed, 13 May 2026 20:34:47 -0300
Date: Wed, 13 May 2026 20:34:47 -0300
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
Message-ID: <20260513233447.GU7702@ziepe.ca>
References: <20260504135731.2345383-1-jiri@resnulli.us>
 <20260504135731.2345383-4-jiri@resnulli.us>
 <aftENVgTr8AZVQnT@ziepe.ca>
 <aftL-2sJb4JfyDIs@FV6GYCPJ69>
 <20260512181236.GA175362@ziepe.ca>
 <agTNeYSOyMTbUbNt@FV6GYCPJ69>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agTNeYSOyMTbUbNt@FV6GYCPJ69>
X-Rspamd-Queue-Id: 183C453C0C0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20620-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ziepe.ca:email,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 09:18:28PM +0200, Jiri Pirko wrote:
> Tue, May 12, 2026 at 08:12:36PM +0200, jgg@ziepe.ca wrote:
> >On Wed, May 06, 2026 at 04:14:34PM +0200, Jiri Pirko wrote:
> >> Wed, May 06, 2026 at 03:37:57PM +0200, jgg@ziepe.ca wrote:
> >> >On Mon, May 04, 2026 at 03:57:17PM +0200, Jiri Pirko wrote:
> >> >
> >> >> +/**
> >> >> + * ib_umem_get - Canonical on-demand umem getter.
> >> >> + * @device:        IB device.
> >> >> + * @udata:         uverbs udata bundle (may be NULL).
> >> >> + * @attr_id:       per-command UMEM attribute id; consulted if @udata is set.
> >> >> + * @legacy_filler: optional command-specific legacy attr filler.
> >> >> + *                 invoked if @udata is set.
> >> >> + * @va_fallback:   if true, build a VA-typed desc with @addr.
> >> >> + * @addr:          user VA, used if @va_fallback is true.
> >> >> + * @size:          driver-required minimum length.
> >> >> + * @access:        IB access flags forwarded to ib_umem_get_desc().
> >> >> + *
> >> >> + * Return: valid umem on success, ERR_PTR(...) on error, NULL
> >> >> + * if no source produced a buffer (only possible when @va_fallback is false).
> >> >> + */
> >> >> +struct ib_umem *ib_umem_get(struct ib_device *device, struct ib_udata *udata,
> >> >> +			    u16 attr_id,
> >> >> +			    ib_umem_buf_desc_filler_t legacy_filler,
> >> >> +			    bool va_fallback, u64 addr, size_t size, int access)
> >> >
> >> >I didn't try to look at what the drivers actually do, but I'm slightly
> >> >surprised not to see an addr_size here? Is it the case the drivers
> >> >don't have have a uhw->size to go along with their uhw->va?
> >> 
> >> "size_t size". What am I missing?
> >
> >size is the minimum length, not the actual length passed into the
> >system call
> 
> Right, you're correct. Size is the post-pin minimum, and on
> the VA fallback path it serves also as the pin length (we synthesize
> desc.length = size when no attr/legacy filler matched).
> 
> There's no addr_size because no caller has a user-passed
> length distinct from the driver-required minimum.
> Drivers either have no length in their legacy ucmd (mlx4/mlx5 CQ, mlx5 QP,
> the size is driver-computed from entries*cqe_size etc.) or they
> pass ucmd.buf_size which serves as both (vmw_pvrdma, qedr, mlx5
> SRQ, ...).

This is what I was wondering about, so how does it work when there is
a ucmd.buf_size and also a minimum size computed from
entries*cqe_size? What does the driver write?

I think the driver has to pass in both the minimum size computed from
entries*cqe_size and also the uhw exact size? The minimum size is used
if the uhw path isn't used to check the other attribute while the uhw
exact size is used to pin the memory if the uhw path is used - and it
should also be checked against the minimum?

Jason

