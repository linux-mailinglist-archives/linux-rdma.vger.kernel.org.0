Return-Path: <linux-rdma+bounces-16087-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDhPOXPgeGkGtwEAu9opvQ
	(envelope-from <linux-rdma+bounces-16087-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 16:57:39 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 499FE973DE
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 16:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38DB0303FDD4
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 15:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22D835D60B;
	Tue, 27 Jan 2026 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hYB+9HYf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E673559F8
	for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769529367; cv=none; b=AFbo1DGzzY0aaJHtwKcWBIxw4RBbuOwVNUa79KOuXi/9XzwCKIBqTjKcJ1YrHomHbhe5lIgIGUE118Fb5Re/qDP5ej4kz+ZvbTkMTw77ShjzhNudq0T85MKNL+fI84pVkzR+3l9Sss+UzC2ZCi8N7/Bp55xo+btzO/07I38yUUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769529367; c=relaxed/simple;
	bh=IZEWYNLsPhoxvs5HUayqFS0qheWOHTK9VA3fb4jAkoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6ivIqm67icIFmW7aqPn4iUhtYLxCK7cbHO32qlkyrwMkgX1E8s6M7kfcTFKDAb6QSwaSxOhrpEo7OzeA58816f44XWx3wfK+9JIydhsyCZP5BHkc/iZazqq9XRkv4hhRF/EVcaiXKxN2M/vx2F2dxC+HFoPlQzi9ZPg2M2LHsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hYB+9HYf; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-894703956b8so88286796d6.1
        for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 07:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769529365; x=1770134165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ek5i5vNOgbbaS298tpHubL/0C6jOVDDNx+iNsyY3imw=;
        b=hYB+9HYfVDto5lbasguHp7NGZNqPKit5oPnZGuc+3yQNWiQ3lQmTti5YTqj4ZHGTg0
         IBzm5YbIAdHgpBe4qHA4x8uxtGP1D0z+VjqMNKo9PvTKBNeRIbLmOE608hxCAZ7Rxsk5
         dttsiEFmrWgW4CyrkgmUFCmdh6Rf/+H5SsVnnY3n2feMpsXgtsmXfvHw6ZPjYZg4Z0k0
         mkX6k7PDWoI7KwiX1T60ccWGp88u3Vo7iqXalAeTUtQLQt498BaIMeytM6nBELhtcFzN
         81HGNXFE800NzO2JLvNlkuIZUiZI9ouu5LqcsKRVJXOTL/0wdXOpbjKYBw1jtTEON/LZ
         NtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769529365; x=1770134165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ek5i5vNOgbbaS298tpHubL/0C6jOVDDNx+iNsyY3imw=;
        b=lwsrsszHyeps5Cwj6Y0kZyQUkzhQRbCagsW/hIVMokHj1QcvZwkLDspguoT8opKR/u
         WarDQtEDevuZiTDIj62olErI2ViC6y/FJxBNEP60bSgJsvJcETvydCEp0Dq2FaRxSY4I
         0/uuNAj8SBz/rsHXiadfnBQsTo9bMzQSBX7iPgxbmgEW+xyrnu/QCfvKQgG3ywc/NAPT
         LuJpyorWQrI5B6hj+5GuLVlO7smSCwsjuz91xY79r2GRhYcWsf2zWs8UOjhla1JqJ6Fr
         jek5lL352Yf/5LiPnVKlnwwLv1PPoYImgCA7K9dLAgZ4eVr60iMTqzylD9hxgZCLX0jP
         aDqg==
X-Forwarded-Encrypted: i=1; AJvYcCUpBFzV3YHGGoTDUoXT3HFRR52rkWQjQ4rLpNwMtGTMNowofk0/dH0cgYuArXYHxIFuB8lVHsW/8fns@vger.kernel.org
X-Gm-Message-State: AOJu0YzD75CLHGhnzAqdPNwH4rD5GG3wIBjjwQjAmEQME2cVMJ7fuOcD
	bwDu/2gtPBCCUr2uAZj8pM30TOLFPp5S4lJiRZJd5F2RjWujmfxLpZ+hF8uJ/k42+cSfs80le0N
	ExHjI
X-Gm-Gg: AZuq6aJPhWkXu6lVPscgAIlTWzQC/GkGLEE+zAnxyE2O+cIflt+TVEVlcD1IYlx5TZx
	y/3yyXnbNbZ+LHV9rUh5dq50an/rjI5zYwahupC6UTQ/Xc3X90hxZ9xUksuT3HHRRPYeo+Fm3TY
	6M7OL4APKi4qyD+8A0qNziOks94Dzk0LDFT8Qf3U/K0ki/EsRotJUYqtdt0ppqMDv+phfO4bcRW
	zelu9wSAoFqCQ/Lkwd7y2JlphcZ6Nm1YcNTO2obazaCxgNC3iuIK+ux6mm+XKD8om4O0lZ3zGOf
	h7Ed3ckPunkBDPCaWx+qam1Upw8oSDUXFdWdCjH//soBVHesNLmZsGVH+ywJmrLfklwAyo+yNA8
	bnri6bgvAv1VDVN3jppYgvy2DHpicaQ7vQQytOmyBzoWHqJOWq/zh2mpkNyrk57goqSLBn4wWjJ
	HxnsEsxLBRFZSFcDRFXnbyXw9bQseAeMmS6HYCcZ7aP3pGY/t8LDCH6ivwjVG7rWw+rB0=
X-Received: by 2002:a05:622a:44e:b0:4f1:e9da:e876 with SMTP id d75a77b69052e-5032f9ffd4cmr26234391cf.62.1769529364997;
        Tue, 27 Jan 2026 07:56:04 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502f7ed650bsm103443751cf.11.2026.01.27.07.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 07:56:04 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vklQB-0000000954w-3zFO;
	Tue, 27 Jan 2026 11:56:03 -0400
Date: Tue, 27 Jan 2026 11:56:03 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v9 4/5] RDMA/bnxt_re: Direct Verbs: Support DBR
 verbs
Message-ID: <20260127155603.GF1641016@ziepe.ca>
References: <20260127103109.32163-1-sriharsha.basavapatna@broadcom.com>
 <20260127103109.32163-5-sriharsha.basavapatna@broadcom.com>
 <pynbf5lh5azbblvoygivvzxjcmnvffrtdz5zbjzsg4rccbpvud@277svcow3ra4>
 <20260127141545.GE1641016@ziepe.ca>
 <qkqqa6grjmfbkxalfk25w2gliscr3e4erdwae4zvl2oqncwgyn@brkp7gu3ppy6>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qkqqa6grjmfbkxalfk25w2gliscr3e4erdwae4zvl2oqncwgyn@brkp7gu3ppy6>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-16087-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:email,ziepe.ca:dkim,ziepe.ca:mid,broadcom.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 499FE973DE
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 04:07:41PM +0100, Jiri Pirko wrote:
> Tue, Jan 27, 2026 at 03:15:45PM +0100, jgg@ziepe.ca wrote:
> >On Tue, Jan 27, 2026 at 01:30:03PM +0100, Jiri Pirko wrote:
> >> Tue, Jan 27, 2026 at 11:31:08AM +0100, sriharsha.basavapatna@broadcom.com wrote:
> >> >From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> >> >
> >> >The following Direct Verbs (DV) methods have been implemented in
> >> >this patch.
> >> >
> >> >Doorbell Region Direct Verbs:
> >> >-----------------------------
> >> >- BNXT_RE_METHOD_DBR_ALLOC:
> >> >  This will allow the appliation to create extra doorbell regions
> >> >  and use the associated doorbell page index in DV_CREATE_QP and
> >> >  use the associated DB address while ringing the doorbell.
> >> >
> >> >- BNXT_RE_METHOD_DBR_FREE:
> >> >  Free the allocated doorbell region.
> >> >
> >> >- BNXT_RE_METHOD_GET_DEFAULT_DBR:
> >> >  Return the default doorbell page index and doorbell page address
> >> >  associated with the ucontext.
> >> >
> >> 
> >> Similar to CQ/QP, why this is bnxt specific? I know a little about rdma,
> >> but I believe we use it in mlx5 too, no?
> >
> >mlx5 has a specific thing too, the doorbell has enough fairly hw
> >specific properties and never leaks outside the userspace provider.
> >
> >We consolidated the internal code to manage the mmaps, beyond that
> >there hasn't been a big push to consolidate more.
> 
> I'm a bit lost about what this patchset tries to do. The cover letter
> does not mention dmabuf at all. Not sure why. I understand that create
> cq/qp is enabled to work with user-passed dma-buf info. So that makes me
> assume the same for DBR. I guess I'm wrong.

This series doesn't really clearly explain what it is actually for,
but it is almost certianly about supporting what NCCL calls "GPU
Initiated Networking (GIN)".

To do this you need a couple of components:
 1) "DV" verbs to allow direct access to the underlying HW queues
    under a QP/CQ. This is because you will write a "RDMA provider"
    that runs on the GPU
 2) DMABUF support for QP/CQ because you will use DMABUF to place
    the QP/CQ inside GPU VRAM so that the "RDMA provider" running in
    the GPU can access the rings at full performance
 3) A doorebell ring that is compatible with the GPU, usually meaning
    dedicated doorbell registers because the GPU can't do locking
    coordinated with the CPU.

Of course there are other ways to use these APIs and DV was first
invented for DPDK not NCCL..

Jason

