Return-Path: <linux-rdma+bounces-16691-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cM/+FrgjimnqHgAAu9opvQ
	(envelope-from <linux-rdma+bounces-16691-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Feb 2026 19:13:12 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD661136C7
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Feb 2026 19:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAA053014505
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Feb 2026 18:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E44738A71C;
	Mon,  9 Feb 2026 18:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AbH3+lvh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FEB38A2A4
	for <linux-rdma@vger.kernel.org>; Mon,  9 Feb 2026 18:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770660786; cv=none; b=tYh0SP9XsRIp6UYlDI98/clw7MypSHQM25OLwRCp6j5Gnmr84FwwMAI0dGj0ue5P5eUGcRt0SIHBNu+OEnJNOc1ULc9GOMhxUOdFs3qxl+iNlwdTpOJxNoaE7Ro6rN5rYCQeb9kV6RAWEu+110MguLCw9Tbs8wIk8gRi2qXEk4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770660786; c=relaxed/simple;
	bh=PeEEdOtlWgGbz3Jd1O6AJXyAdP02Oo5lyj4NDiwFBIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvab8GBYemnjFsUhEJH3fIs5/b6C0rgb9RzvPmfN9f0HPtWhD8D4D+beueMkr1MCXmqipORZ2rp8rt9QePeJigRT73Nj1X4SrwoaNLoh0ZlMsf+/2KQwHChXJrj64KcTijLjOnS2lbJ4jedfc0n8yuzbcynnk9hLSqa+Nqw2LJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AbH3+lvh; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c59bce68a1so3230685a.0
        for <linux-rdma@vger.kernel.org>; Mon, 09 Feb 2026 10:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770660785; x=1771265585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gj5UuRmjNHB03u99WDJiaFn+Q1sTfKxV+46xet6mPYw=;
        b=AbH3+lvhP+aCORsv+XB1KhdCwpglgXrHZjqVkU+at4UulhW31gAR4Awws1C6o1J+mk
         JDXBHUW/sit5R1Kj5WFCo/oUPlZPyo3Yx4SnpcKMu4ImkFpNYQXh+KcuDQOQejf4l/Qv
         EJdxMLnr7Ec+N6WGwOXyknd4938ooiOd+8c7r6QvG9695qbM4ooG7Tl+frmQUSEImYEY
         sRgHqqrgEfwKF1EETl1aReDnQFvMk0vo9/d3MvtU5sMbbiKVIfNGooHYmOdDKnqmXNYU
         Sgg5JCFvw5n5hpXjHlP9F/udM7pk2R5sQGFLZg/t9I/c8cYX+7xFnJteVmVEd+sC4vDt
         ckFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770660785; x=1771265585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gj5UuRmjNHB03u99WDJiaFn+Q1sTfKxV+46xet6mPYw=;
        b=FaYT2gaSucmGECxKlztBcL7QuF4haXaJEwfM0nP34IJf73MxmbaeodoE70DlTvN9hb
         VRR0EsAmAv2Ew02mIJquU7fzrAwgpK2F2HofbGHZQPt9z782jLhn+a+6hh7ksLqyh1IK
         2ANVpaKhezIVtsv2DiEV35ibB13a6L1RgX45JItpMdAkqAKvx1qIVIU8Z8PAb9CQE3+M
         pOyBVqSkkgkkLCvlwo+hIx9ghbGZrOhAp0+EsBu8QiWi1Y/Ju/NG/q/OZudjNE0uwZMS
         lRvKluZZ4EOWjox1fs5OdxyCJw6a9ye9KWMT/8Pd5yPiTQsuce/RHJAOeWVHqKxgNmXg
         LHww==
X-Forwarded-Encrypted: i=1; AJvYcCWsgvGn9OQGKky6rS8oF5yGe6tB5TsQwnKMFztmnsxzOGSJHH7S16Mt/rww/dBIZr3BVC3bl8dAZvPq@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4vJqWVqZhqtfi+dxCs1ui22jBcLc7BAIqfzqN8KuM++Q6Pvuh
	2zV39RCcf7iMCZg+cqSb6Qa3aQvkl6eaG2FvlUhOHN2M1pxlwbHaloIfmu5AIrrA4Dc=
X-Gm-Gg: AZuq6aLwcKvStAuMEgS3UXfw1JJy3uZR82kjWCVy/mDiNiRV2cDOkvRnNC8eNKtNaFc
	l7ccfcdF/KTQvd64AkEai3VtUilCbGXh2+qtN7a/3Qcq8G8LjldXWvmMdtChP8vUTeG1BOkrLVH
	UB+uYo/gIH4ofDXrjjQyAebQCLpKuSANScgSX/7iNO0s6/aoe1JgsK1zfgRQHUt8jQt39gT8+P7
	7o8O2Up7C7U7Mg0sy0uQh7gUxtzGVBwNkx3prC9iaoDocdUgRu/zZ+js/cN4Cz9mI8f0yAivtWC
	SWVYg6/zJC5XVqljU6Q2HppgSi5vm7rzbwroopvEcBeXI1lK39/sODXrunPHvZqgQ6btnniy+Cl
	Uw7+kwgX+LReLP7asVAQ8ve//Dbp7+thYi/Ex95FNUgeJXY+rti9CT9d9dZfTE3zhQCaQGuDq0g
	f5m1J6Wsvp6ouJzTg+TiR861G4QXQhmIQMtFc5WuBYLnt7MxVO2f0ngHOVY1OwPeqJA12ZWKE26
	z1URQ==
X-Received: by 2002:a05:620a:3909:b0:8ca:358a:d636 with SMTP id af79cd13be357-8caf1acd680mr1662509285a.87.1770660784822;
        Mon, 09 Feb 2026 10:13:04 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-896f79d34bcsm39740876d6.0.2026.02.09.10.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 10:13:04 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vpVkt-0000000EmNV-2zIP;
	Mon, 09 Feb 2026 14:13:03 -0400
Date: Mon, 9 Feb 2026 14:13:03 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Yochai Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [RFC 0/2] Retrieve tph from dmabuf for PCIe P2P memory access
Message-ID: <20260209181303.GB943673@ziepe.ca>
References: <20260209175317.1713406-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209175317.1713406-1-zhipingz@meta.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-16691-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CBD661136C7
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 09:53:10AM -0800, Zhiping Zhang wrote:
> Currently, the steering tag can be used for a CPU on the motherboard; the
> ACPI check is in place to query and obtain the supported tph settings. Here
> we intend to use the tph info to improve RDMA NIC memory access on a vfio-based
> accelerator device via PCIe peer-to-peer. When an applicantion register a
> RDMA memory region with DMABUF for the RDMA NIC to access the device memory,
> the tph associated with the memory region can be retrieved and used to set the
> steering tag / process hint (ph). The tph contains additional instructions
> or hints to the GPU or accelerator device for advanced memory operations,
> such as, read cache selection.
> 
> Note this RFC is for the discussion on the direction and is not intended to be
> a complete implementation. Once the direction is agreed on, we will work on the
> implementation or a real patch set.

you didn't cc the DRM people who really need to look at any changes to
the dmabuf contract.

Jason

