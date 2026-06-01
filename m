Return-Path: <linux-rdma+bounces-21597-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eACXCQzWHWq6fAkAu9opvQ
	(envelope-from <linux-rdma+bounces-21597-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 20:57:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 30572624520
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 20:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0DAA23015A93
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jun 2026 18:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF5135CB7B;
	Mon,  1 Jun 2026 18:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="g8VwfbQ6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0689A351C2E
	for <linux-rdma@vger.kernel.org>; Mon,  1 Jun 2026 18:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780339722; cv=none; b=UbtWp/mw41cQ2cnQkj8BPvS3YBcrOF9aaTH5Jq/eNP6yI5G99j7YH7oYzofGF/OxcmHaAPMY57VOEBMtAJHpBI0T8X96YN38KihxRV9NByn7azraLRAoNnJtYH8TNbkwZ2So0/qWl5os6u5g/zQbdd/FuvMJKlUbPAIvUHx4I8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780339722; c=relaxed/simple;
	bh=dpwh9EurGC8PWJHM2nwOEMbtuDAWOKFskADoJMJikXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NV5ftDgEc6QZcmQ6BD62OMyn+MU8n6qf87YvY9ipabAzrtfz4PGmBIhKrxW8L5ducBoK19ZGwJOM7t/+FefDFbuOl+GLfTmzd3WsDJsaWTrrz7UmOFrsPuvDcau8I28UF6H1UPqBjtf4yoS0aQFkxdHE22pf43wL4wdSC9696rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=g8VwfbQ6; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-91563382bcfso126840085a.0
        for <linux-rdma@vger.kernel.org>; Mon, 01 Jun 2026 11:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780339720; x=1780944520; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZOVGBJ+B1pIGsdNReY7mg4M6+73TAYZ+OPVziP9NXJE=;
        b=g8VwfbQ6/OQdI+ssi72qB/rPbqUxNqrG0AwhNoH/u/48EizSI2O4Hxjc9PC9FiFhle
         gYaxDuKwklcxwE0R62QrehCjGP4mXnCKCN3rnL5qe1NSzg4geZWep8jezMiDHrUBngID
         v5bwNcXovAurH+sb4zbeyZbeIN6hQMN6OJb1xp3qn1Xt+16aIU+bvuVU+gCMvpn6NOuT
         daXS6fCOsUo8SdGhK16F/tUJ3UvyLJQ7r2MpXAZNEhd+kqVZDJgIaKZOwqTHJHHhWYcl
         /x/yIWCza/NV861UVCqG0H3T1y/6cI/tCPloRGkfJ3irllFEcNi9N+OAxS8MV4Xcxpsa
         dnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780339720; x=1780944520;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOVGBJ+B1pIGsdNReY7mg4M6+73TAYZ+OPVziP9NXJE=;
        b=k/ZOut2AUxDLcf+c68Vt0zhwjN3tBD4HvSUgMyeJ8qVi2CZEX65K0Hz+HCmu8kN2fC
         ZUNoU7/lGE6a0mktvj3gqF+sH7CjfUR+H+Yggl7+Po3hoec7aIf4mNqioaPH51XfUgE4
         wu9rrxl7NTr0/BEr4xG3P/5UbBisvJfNT51fuO+mYx4CsW2lnpixa00JsacaHlb6T91j
         7zhamIXWiSihWHNDoth24fRwFiR0qEmPxIXP53lhgAjJfJgCaDOfTVOM3+pnSetCClp6
         iA7PX+aD0CfMWb5/i+4G6W0vLyYqusEhG72syiBHvmx7X4ez807Tt5MVv/LVzP/qeroT
         eNSA==
X-Forwarded-Encrypted: i=1; AFNElJ8bhP59LoLRp929Iqkh2Fgza5gH6QbXqrz/uusFk643bQXeAnRwih5u/7cF3lCtMo4FKhT322koIqam@vger.kernel.org
X-Gm-Message-State: AOJu0YwPplxvTULcgSEO5PJYIaFb2qtXGj6r6MCm3fhI6/jMHVaV/VDQ
	reEljo4L12L+nRqE9Vfa73+y/fb3fbJ2doKA65kZG79JRsItLBuxDF2kdJ2x2N5vxOs=
X-Gm-Gg: Acq92OGLRKlmBxUKSpCB+kDT7YU9IFHLtBHDjGd6LOLn+k129xPrsZ2GnLOv5/a8osv
	CeMVNRu4kpV2gDcra0rEPDd1hQ1yK3d2Pg8NpyMoRq8qz8TTUc2goWAKj1VNP7YiJhTmdAYk60q
	YHYMkKcnXyP32veNLlK1x6x7CrhL1Yi70IfBcHzIeaDcl3FQiCNy0nY5KZGbwzqLzTf62xio2pK
	EXi9aS8a1Y+/aHxTO0N8MaOjhyfG2SDEaPh2qWlfRPY6YafUFo+RcTJ34BYcm5Pq6WiDWz3Qb+S
	VGAIMXjoCVnHMiD41CdLfvT5NXpa+7z36+FBoQrP1FCjOJwCrUy9Ahl5k2ZEJJG0bhXcugOlUmZ
	qu3mDnOyRWgjqZnO2/78x47uJ9I5y2dAYVz5Ue9kyY2x9BFMnfDANiwGvqkcpqAQIrRPT5aIS0D
	E9o1fRtv4eEeh+EFurOIn9Yubkr3Rf76R6qTVdfLDRNS/X8SXCDdBCSo7nmqb4sNdU1ohh03G/A
	3rzzg9Bj+mijt4k
X-Received: by 2002:a05:620a:630f:20b0:912:1206:ddd1 with SMTP id af79cd13be357-9153d93b157mr1356674885a.1.1780339720004;
        Mon, 01 Jun 2026 11:48:40 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9153262f45dsm1098180085a.41.2026.06.01.11.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 11:48:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wU7gk-00000002GHG-3uxy;
	Mon, 01 Jun 2026 15:48:38 -0300
Date: Mon, 1 Jun 2026 15:48:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Zhiping Zhang <zhipingz@meta.com>, Alex Williamson <alex@shazbot.org>,
	Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
Message-ID: <20260601184838.GE2487554@ziepe.ca>
References: <20260527123634.GK2487554@ziepe.ca>
 <a5ff1930-e9fb-43f5-82ab-9875d7a28421@amd.com>
 <CAH3zFs2KALuHXReLZG_uoqvBBWvBzU6rHKakmt6HBV7PZEsD=w@mail.gmail.com>
 <71302a7a-6b9f-40da-af81-b1862dbd637a@amd.com>
 <CAH3zFs036sr93duQKx613pCyOYw4t0_x_TdSza1xBCaEmqijyA@mail.gmail.com>
 <8d9bb0b7-182d-4930-b683-d5d24da6b2ab@amd.com>
 <20260529201130.GU2487554@ziepe.ca>
 <190a1eeb-bd70-4b7b-93a4-60e14f0d6c7e@amd.com>
 <20260601174734.GB2487554@ziepe.ca>
 <dedd8e8f-118c-4ee5-9552-cd2220dbdd23@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dedd8e8f-118c-4ee5-9552-cd2220dbdd23@amd.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21597-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: 30572624520
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 01, 2026 at 08:17:15PM +0200, Christian König wrote:
> On 6/1/26 19:47, Jason Gunthorpe wrote:
> > On Mon, Jun 01, 2026 at 11:59:55AM +0200, Christian König wrote:
> >>>> When you have a complete open source driver stack which utilizes
> >>>> VFIO passthrough as the interface to communicate with the kernel
> >>>> drivers then we can eventually talk about that.
> >>>
> >>> That decision is not up to dmabuf
> >>
> >> Yes it is. This is the DMA-buf API which is added here.
> > 
> > It is a DMA-buf kernel API that is added, I think it is overreaching
> > to try to veto a VFIO uAPI that calls it..
> 
> Well as long as that is a private interface between VFIO and mlx5 I
> have no objection at all.

Well, as you know, we are using dmabuf to mediate many of these
connections now.

I don't mind a "private" interface as a starting point, but it does
need to discoverable and negotiated without weird module dependencies
or symbol_gets.

> But when it starts to affect DMA-buf I need to make sure that it
> works for everybody. And without even being able to test it that
> becomes really tricky.

They should have an argument how it can be used for CPU backed memory,
IMHO.

> > This exposes a PCI SIG defined TPH capability in a reasonable simple
> > VFIO uAPI that can be re-used by any other device that happens to
> > support TPH on inbound MMIO. The uAPI has sensible general semantics
> > based around the PCI spec.
> 
> That it's implementing an official PCI spec is a good argument.
> 
> But on the other hand looking at the spec it's not really specifying
> much since everything is architecture specific.

Yeah, spec doesn't say what TPH does when it is received. It is
intended as an opaque channel between the source and target.

Even on the CPU DRAM side we make an opaque call into ACPI and the
BIOS returns back the right value to use for the CPU. The whole thing
is agressively opaque as to what the values mean to any particular
device.

So I don't have an issue with VFIO supplying a value for MMIO it
owns, it fits the general architecture.

> > Anyone can repeat the demonstration Meta outlined in their cover
> > letter: Use this new VFIO uAPI, import the DMABUF to mlx5, use a PCI
> > analyzer and you will see the PCI SIG defined TPH bits set the way the
> > VFIO uAPI says they should be set.
> > 
> > There is nothing uniquely tied to Meta's device here, or unusable by
> > someone else's devices. Arguably this is actually a mlx5 feature to
> > allow VFIO to control its TPH generation HW.
> 
> Would it be possible to demonstrate the functionality with some FPGA
> implementing an PCIe endpoint?

Sure, you don't even need a special endpoint, any endpoint that
doesn't explode when it receives a TPH is fine to illustrate that mlx5
is emitting it correctly.

A fpga reference board with an out of the box PCIe IP demo is likely
entirely sufficient, and you can use a FPGA logic analyzer to inspect
the packets.

Though keep in mind mlx5 is formally supporting TPH in a growing
number of kernel contexts, so we do test and verify our device is
working properly as an initiator. So I wouldn't advocate anyone
actually use their time on FPGA :)

> Doesn't needs to be anything funky, just the ability to exercise
> this for basically everybody who can spend a few $ on the HW.

Topologically you also probably need a PCIe switch as the CPU P2P
likely discards the header.

Jason


