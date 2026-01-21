Return-Path: <linux-rdma+bounces-15833-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LxDCIHmcGk+awAAu9opvQ
	(envelope-from <linux-rdma+bounces-15833-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 15:45:21 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD7B5897C
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 15:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A970840BC92
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 14:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02994ADD92;
	Wed, 21 Jan 2026 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="H8UzsxhU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACCB4ADD86
	for <linux-rdma@vger.kernel.org>; Wed, 21 Jan 2026 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769003807; cv=none; b=shg7jOAkX57JBr/Ygap9wT4ZnEdEWQdVvMIur/vUbtI2f3vVfBwaiRl0ULj8x8C/mmqXxzyWr6wXDG/DazzdvhkEkq1OZJsXYL2fqOloMD3jHPzhsTrQwPOvU4GLMLr0cQGbaGXyZ/jrFrDnAZhZJ/kknbH4c6MxRCvRfEvzKpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769003807; c=relaxed/simple;
	bh=Yx9d+72s+3PAs53j871MkFNTMAXeIK1rMQQP5/r8Bm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zph/9NsYEI4kXFZPn8iIcs3tG5NljjKis5E2A0KuS7yYD6QiVUagjEWRfuKCnHLzPsBr9VZtmN2QP8Acd8CA8/lO7rx41OKUqizHE79P4eBlQeB/vb3+aZLD/9Rml6kSc3WiVfvE9+lBycbC0U71cvzhRGrWxKS+c+gQ4zXdvtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=H8UzsxhU; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c6b16bd040so488947585a.1
        for <linux-rdma@vger.kernel.org>; Wed, 21 Jan 2026 05:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769003804; x=1769608604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Avz0zhItUvROQy3aeBayHRvtD6/6o32+NQiPJhA08ug=;
        b=H8UzsxhUFbFGHNp9wMFiBbuYWaCHVH2tYwneO0Wwkd/2zjLrtAazD6c43qjJ4gEjxL
         2OI3Z96r7eB+SIXEJ+CuZ0nhSzPH1EPa7kb6Y1LsJMfBuoD/UDEaqYUa+v638b+Y3GtX
         VTLnqZoBwiOMdp3DMAqilhMtU7u4WTiRlNIcuyh0bwJA813FiqgOyoFwK1Mf5ru/8tTB
         Pa4XV9l/KcTNjw66f9eNHjqvAupeQ3OVFXmo1KKBgvmbcajT+Uo9fCbyXhChBXSCAT06
         RfQ7Hmp+VZIro9lyEFEDfsTkYxoysoLWTPmnt+BO7W4drlESQ4v4ObS3+tJl1wSrwUa9
         +3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769003804; x=1769608604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Avz0zhItUvROQy3aeBayHRvtD6/6o32+NQiPJhA08ug=;
        b=UK5LjAUWLf1HSs2Xve4k7BPHuiRjvv1QymP6qAoymPyCm7FVxz+Gj8WaHnRVGUMKO3
         scfZP11YgtJy7DydObvekfjAQhx8KrLmUVmqjY5BFo1HczT5rx+CNSdP/B1mPWFuo83n
         aZWjYQsJiwWwi2nOfMnzsvYOLvCuPDgHLRe97MHH75s9v7UKXUdUNGuUzV35m2Da8tj/
         tIx4tQgvOd4R9KzaeOiuZv7duuegKF6UGigRJgNzsAwsOo277GuMxew79wM25lwtxeGU
         Fus6WC704BZUm4N0Z6iLQDjIIt7L5i8tSgR3p9LEDUVWNpG0n02xNte61l+jvQmbC9LS
         utoA==
X-Forwarded-Encrypted: i=1; AJvYcCUSOez7fb3VzTQPdEw/ENk+xZayqxOjslFgUB8LWTXusqWFLMKC/yrhp6vFZP+hNir5SZoHMWobh00V@vger.kernel.org
X-Gm-Message-State: AOJu0YyWuwsSAThvkHFB1cIiBZhDVdoZWaVHPMt9n4e2dT4FauwD5lBZ
	KGtusW0h88IeZ4HdUlVX4pIJX3S4U+WB0sPuPvkTFw3za7/nlrLfhPSfb2pPxcr90sLfCQ1+LPg
	XHoiF
X-Gm-Gg: AZuq6aIZQKgZOlwqhyZYo/JFsxfO/6AtSXkivQTrIAh/rHlRGolOtW5fnPI46EvB0nD
	ETQam/OS9y8LP7mphuZza9vvRTtYr58dpBGmDZC/8rjN6F4fLWZD+Nuq5RNChZHgSlnHqvzJg+o
	Ekn3MaaqFzJazRRvPxLZ35JvmRpppWuPU/gf4SOhS9KzXLOobOTYdW9YEbXsdnqOfL6o+DDk2c8
	y6sqt5J2sJzoviZvdpHa+/KCBOlsx8YeDxMmSwY3rKRcPhTY6d0aOxkAu1WmZ+g3aJKLzUn9X8H
	jeKrEkRWSfSneH1uje+qh1jXizg/G/yrVuDuXyc1O2KYobR6itsm8a0fZFXmUH7yV5jDplLpa36
	U7Kk/03ou5B0aVITFRGDVo3u23XTBQCYYhu68kyGvTn4gxckpcGWRCGjQKwwTSDvCW6IE1Ij78I
	buAsmiLK7M5g1kwzY1EwP6F7TCAazJ2uM5H2ubviRzWN8nkpmobDayVkqi6ld/A11ffjc=
X-Received: by 2002:a05:620a:1013:b0:8c6:a814:726b with SMTP id af79cd13be357-8c6a814748dmr1789323485a.75.1769003804452;
        Wed, 21 Jan 2026 05:56:44 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6a9d97sm125563246d6.34.2026.01.21.05.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 05:56:43 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1viYhP-00000006E7g-1MyT;
	Wed, 21 Jan 2026 09:56:43 -0400
Date: Wed, 21 Jan 2026 09:56:43 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Edward Srouji <edwards@nvidia.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next 1/2] RDMA/uverbs: Add DMABUF object type and
 operations
Message-ID: <20260121135643.GA961572@ziepe.ca>
References: <20260108-dmabuf-export-v1-0-6d47d46580d3@nvidia.com>
 <20260108-dmabuf-export-v1-1-6d47d46580d3@nvidia.com>
 <20260120181520.GS961572@ziepe.ca>
 <20260121083246.GV13201@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121083246.GV13201@unreal>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15833-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[ziepe.ca];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:mid,ziepe.ca:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: BDD7B5897C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 10:32:46AM +0200, Leon Romanovsky wrote:
> > > +static int uverbs_dmabuf_attach(struct dma_buf *dmabuf,
> > > +				struct dma_buf_attachment *attachment)
> > > +{
> > > +	struct ib_uverbs_dmabuf_file *priv = dmabuf->priv;
> > > +
> > > +	if (!attachment->peer2peer)
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	if (priv->revoked)
> > > +		return -ENODEV;
> > 
> > This should only be checked in map
> 
> I disagree with word "only", the more accurate word is "too". There is
> no need to allow new importer attach if this exporter is marked as
> revoked.

It must check during map, during attach as well is redundant and a bit
confusing.

> > This should also eventually call the new revoke testing function Leon
> > is adding
> 
> We will add it once my series will be accepted.

It should also refuse pinned importers with an always fail pin op
until we get that done. This is a case like VFIO where the lifecycle
is more general and I don't want to accidently allow things that
shouldn't work.

Jason

