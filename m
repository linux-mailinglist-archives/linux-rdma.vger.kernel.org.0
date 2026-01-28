Return-Path: <linux-rdma+bounces-16164-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHIBGA9Aemmr4wEAu9opvQ
	(envelope-from <linux-rdma+bounces-16164-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 17:57:51 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3403A665D
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 17:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E5E9B30022F0
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 16:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9D431618E;
	Wed, 28 Jan 2026 16:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NSvCk+PI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com [209.85.160.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8706925D216
	for <linux-rdma@vger.kernel.org>; Wed, 28 Jan 2026 16:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619463; cv=none; b=psYebTteR378QDST3VvBjCrjvvsS/gSNnh/yjxHAYb+//vL9t0v2G/uN7ae5nzpe1Py71HvWIyGF0I0q0n0PBpzEQ7j9+bXd3lXQcm3IT4Q30rg1KrZqXSSCgUqiF3ImHf/0Dx/W8BnEi6DRSJWU44+FIQaRzfJgryHxCd4V2EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619463; c=relaxed/simple;
	bh=4K4OLHaqM/t/HXgyCFJoyTmAZzqjtCmqUqovtxJuMsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pekmCLYMNVFG73Y+Q87tB7P7QbGe6C9Djaevk85zGV+/0hWjON7BFbkwQ8W28cAZvsiLTuHcRnJ4g1gzHoU3rzLztKTCbyzm4vOUI9m7VnpQV9/STNXj88dp+1Y38GFzzjuWM9sCrrJnwqkKAsAgq/IlC8vai5Grs2S4vdjImxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NSvCk+PI; arc=none smtp.client-ip=209.85.160.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f193.google.com with SMTP id d75a77b69052e-502f101d1cfso69152751cf.1
        for <linux-rdma@vger.kernel.org>; Wed, 28 Jan 2026 08:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769619460; x=1770224260; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x5PPbKkTts0Y3gVIJ6pivviiM6v1XzmJpI/qsHikqnY=;
        b=NSvCk+PIgibHYCb0s3AdIGmdLI4QoBnFvDwKJuBP5DmiVW4yY79sJBf8qYBpOmDO5W
         s8uZeICawl1lVSPl0j34z6nCA3cC8ov0GbfWxFDPCYv1SaI3ci/SCe5k3h8tsfigeUsY
         RvLaI+VQqmAxSVnTJk47FWIRbTEfLfdLiT4oJ7Pa5gNT9oLy5IOaTMH34pLKFzUbPqvy
         KbQGVbRBLnVQ9UsP21MMKtDg6LPsUeLR9BRcU593Nmdr9qhbLnsy5O5phNWpSAojHfip
         oxPPubyWn1/0lV1ho0SvwtUhVoXMzhD3/k7PzFHAWVXpEi1TqTuv/tXK54d994vX3vkm
         9MPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769619460; x=1770224260;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5PPbKkTts0Y3gVIJ6pivviiM6v1XzmJpI/qsHikqnY=;
        b=Rr2r8D8AKnmlXzYaWXWPcu4NyThlpC0FYLxqe6KzTOtAqKQ3hE32vCxGpWk3eQAwJz
         QAm6vsGaCffUwi7zcOH5phF/184Weu8lTYexcHlvb9r2rCVPcSESBEvUJHksIliNerPA
         ROeV7/7kJpBNPoz1WEKzl/4MxB3G7AAYADmVIvPwKewriKkJd62Uu3vY51dzPfX2K+sm
         9laLbXnaBVP98XHTatdylSy9fMiT4d/o5zlXP/OZ8hpnFnPIuY3ilkPYAialqvQiNHGe
         e7XVfIxvqYBqaukMzjjtBYxpn2fLvGXM9iaJqXD6hsAI/EIR41riwRBuH1Y3KpHldu80
         j6Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUrV4L5+eQZ1K6ESh4h75wjWrRNPJsZ9m3iUaAHyaoX7nStrLEDS9eQ8P5b2w2LcbQz/XdsxIuotQEc@vger.kernel.org
X-Gm-Message-State: AOJu0YyoG053LXQ9Z0sDAQ9dOxL1mQmsh/WKqxA811bBVm+qPqgrDJ0q
	RXQxZd7VDK+tXX4JDm2jB3Ig89khiPg5Gfp53xezK6MiGhNTLakQIHM3Z52xT/ny99U=
X-Gm-Gg: AZuq6aL9qFAAlXLkm0IuJ0f1YW1zdlrfMZk7DeXctB4qRWLn9mZwUpwq3ZcOsCHFeqS
	HgfiBghx83OGCxcPDNjde1jKDBE8Cqe9/DXo0xoBVMaJ4ilxOFfaNZESZrrvKje25r0qjxVCOj8
	zu39vdhV7rqlHcSzxjf86cellBJ08gQBqWUxZ6pPy9XPttR3XsvA1gHBUiXeiEWfE1ngaNEzYVO
	0JQOJzH2oDmWr/HC5KUxzb3IrweVSe/KoLjyr2LaQ/9tmcTZWXATiosxa+cqrmlNKPjGTafstLW
	jZe3gAyac2LhmsrZZtKW26kX8Z9DXB4qqtReLcYrufWVDHX6xkI5CHnWoVkiGbgqCDiJ18zpPj3
	7hwa7lXEfepsR2dS6ggAKPevzyeY5SlJUerbfFU87VPtyq5Y31SLkUmvYlLW9xYa3PLWihKBnRV
	4iz+ZWDhA0CzOU5GSIsjiNo44Wyf7H+ZrifAM14kB9q42OKikfQ1ksGxZhFwSs0Swv7zQ=
X-Received: by 2002:a05:622a:592:b0:4e8:a6f8:e3c1 with SMTP id d75a77b69052e-5032f886480mr76621061cf.18.1769619460454;
        Wed, 28 Jan 2026 08:57:40 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d36c85b9sm20499826d6.24.2026.01.28.08.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 08:57:39 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vl8rL-00000009KeE-1DOy;
	Wed, 28 Jan 2026 12:57:39 -0400
Date: Wed, 28 Jan 2026 12:57:39 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Yochai Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [RFC 2/2] Set steering-tag directly for PCIe P2P memory access
Message-ID: <20260128165739.GQ1641016@ziepe.ca>
References: <20260113164923.GQ745888@ziepe.ca>
 <20260124011436.172058-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260124011436.172058-1-zhipingz@meta.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-16164-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F3403A665D
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 05:13:19PM -0800, Zhiping Zhang wrote:
> On Tue, 13 Jan 2026 12:49:23 -0400, Jason Gunthorpe wrote:
> 
> > On Mon, Jan 12, 2026 at 11:43:13PM -0800, Zhiping Zhang wrote:
> > > Got it, thanks for pointing out the security concern! To address this, I
> > > propose that we still pass the TPH value when allocating the dmah, but we add
> > > a verification callback in the reg_mr_dmabuf flow to the dmabuf exporter. This
> > > callback will ensure that the TPH value is correctly linked to the exporting
> > > device’s MMIO, and only the exporter can authorize the TPH/tag association.
> 
> > That still sounds messy because we have to protect CPU memory.
> 
> > I think you should not use dmah possibly and make it so the dmabuf
> entirely supplies the TPH value.
> 
> > Jason
> 
> Thanks Jason.
> 
> We already have an end-to-end workflow around dmah (perftest → rdma-core → kernel)
> to carry the TPH hint, across multiple patch sets. References:
>   https://github.com/linux-rdma/perftest/commit/98bfb3679a1e71ec96df6a6d6c8124ac66ebce25
>   https://github.com/linux-rdma/rdma-core/pull/1623/commits
>   https://lore.kernel.org/all/cover.1752752567.git.leon@kernel.org/
> 
> Given that, I’d like to minimize churn and use the existing dmah-based flow, while
> addressing the CPU-memory protection concern you raised. Would you be open to
> reconsidering this approach?

You would need to initialize the dmah from the dmabuf and then lock it
to only be usable with that dmabuf. It doesn't avoid any dmabuf work,
it just makes the whole flow more convoluted.

Jason

