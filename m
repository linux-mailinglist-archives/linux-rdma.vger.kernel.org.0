Return-Path: <linux-rdma+bounces-22286-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZXYbI/SMMWqdmQUAu9opvQ
	(envelope-from <linux-rdma+bounces-22286-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 19:50:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32858693889
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 19:50:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CC6Yq4o+;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22286-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22286-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A5B3930338FC
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 17:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47895472771;
	Tue, 16 Jun 2026 17:50:40 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E333D34AD
	for <linux-rdma@vger.kernel.org>; Tue, 16 Jun 2026 17:50:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781632240; cv=none; b=kpm5GNCAY/VI5dryHJdmbo3MIr6MUnYuHOIPgMVp7ohvwyiXjAHnt1Sfh7LXRONnM0mmcrX2mmWd99SuJ6nY+KDIzRlURCKs+9NplRmlW7rHozandyewhwmyDl6jEdBRIPZogK7CH205g5F3ZGP6oq+CN5qBwTHcDo2CRpiRAhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781632240; c=relaxed/simple;
	bh=GTYEIxMVmxl0XLgOummXCbQCddXUsKfoRTcdeJpng/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gV553P/y/8NEKnO4YGnmrWK2GbTSyyTJ2cQzRI48P/oSWhjvwS42jmC1sAHIzDy2wRx6mG2lYsdlZ4cyR1/5DJ2Rjni9sKboeEVqeUs8B5WXyV6VmoCRPr4ZVAFNgc7XnHUaShz4Juc8Y5aDrUqPUzHbDpafjDitvBrgDdIwGH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CC6Yq4o+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F224A1F000E9;
	Tue, 16 Jun 2026 17:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781632238;
	bh=m1XA83wDzRlM1YkkW63+kwCWIQ82YPW0y9il5tGC9iA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CC6Yq4o+tAQK8RYJZOARVvo07iVK8DmVxZOYCqy5XQGVikJBdkdnDVhHpf51rMx7h
	 mgvciHL/NvVrEDhtoDSoSIFrAqoHhP0I/AOtT54gEuI7nbhDaCUrOCkk5g/FZS+kSl
	 QCuDf7ZbsJ1dIuGmgviDvjiXVFkWYKnCPIg6fVhGSVPlKDIyLFfchrZOmYUfktRrI2
	 nBf/mQ7gzyVYdd/8XyXBI8BPgnJ1jSwaJA/X0nd8vOeDPY5kid2u6XS43oT5MJSI2K
	 Iwgtti2JIghTwzooqsQ5QbeVrjH7Wywb9bMJ6NoNnPMtelfsN2xURIXrtFZTXwnni4
	 2fhisOy0SvTvg==
Date: Tue, 16 Jun 2026 20:50:33 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Yonatan Nachum <ynachum@amazon.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, mrgolin@amazon.com,
	sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev
Subject: Re: [PATCH for-next v4 0/2] RDMA/efa: Add AH cache for AH reuse
Message-ID: <20260616175033.GQ327369@unreal>
References: <20260608071620.1909543-1-ynachum@amazon.com>
 <20260614071229.GA29713@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614071229.GA29713@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ynachum@amazon.com,m:jgg@nvidia.com,m:linux-rdma@vger.kernel.org,m:mrgolin@amazon.com,m:sleybo@amazon.com,m:matua@amazon.com,m:gal.pressman@linux.dev,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22286-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32858693889

On Sun, Jun 14, 2026 at 07:12:29AM +0000, Yonatan Nachum wrote:
> On Mon, Jun 08, 2026 at 07:16:18AM +0000, Yonatan Nachum wrote:
> > Changelog:
> > v4:
> >  * Use kzalloc_obj for AH cache entry allocation instead of kzalloc
> > v3: https://lore.kernel.org/all/20260607161753.1607559-1-ynachum@amazon.com/
> >  * Address Sashiko comments in:
> >    https://sashiko.dev/#/patchset/20260512061121.2177521-1-ynachum%40amazon.com
> > v2: https://lore.kernel.org/all/20260512061121.2177521-1-ynachum@amazon.com/
> >  * Zero-initialize AH cache key on cache lookup.
> > v1: https://lore.kernel.org/all/20260510083035.458081-1-ynachum@amazon.com/
> > 
> > -------------------------------------------------------------------------
> > New EFA devices don't support the creation of multiple AHs to the same
> > remote on the same PD. To overcome this limitation, introduce an AH
> > cache that manages AH reuse transparently.
> > 
> > The cache uses an rhashtable keyed by (PD, GID) to track active address
> > handles with refcounts. On create AH, the driver returns an existing AH
> > number if one is already cached, or creates a new one and caches it. On
> > destroy AH, the driver only issues the device destroy command when the
> > last reference is dropped.
> > 
> > A per-entry mutex serializes concurrent device commands on the same
> > cache entry, preventing create-before-destroy races on the device.
> > 
> > Yonatan Nachum (2):
> >   RDMA/efa: Add initialization of AH cache rhashtable
> >   RDMA/efa: Add AH cache handling on create and destroy AH
> > 
> >  drivers/infiniband/hw/efa/Makefile       |   4 +-
> >  drivers/infiniband/hw/efa/efa_ah_cache.c | 163 +++++++++++++++++++++++
> >  drivers/infiniband/hw/efa/efa_ah_cache.h |  42 ++++++
> >  drivers/infiniband/hw/efa/efa_com.c      |  12 +-
> >  drivers/infiniband/hw/efa/efa_com.h      |   3 +
> >  drivers/infiniband/hw/efa/efa_com_cmd.c  |  73 +++++++---
> >  drivers/infiniband/hw/efa/efa_com_cmd.h  |   1 +
> >  drivers/infiniband/hw/efa/efa_verbs.c    |   9 +-
> >  8 files changed, 281 insertions(+), 26 deletions(-)
> >  create mode 100644 drivers/infiniband/hw/efa/efa_ah_cache.c
> >  create mode 100644 drivers/infiniband/hw/efa/efa_ah_cache.h
> > 
> > -- 
> > 2.50.1
> >
> 
> Hi, kind reminder.
> This series blocks merging EFAv4 device ID and we would want it to land
> for the next merge window if possible.

It is not possible.

The use of entry->lock together with a refcount and an "initialize"
flag suggests that the refcount is not being used correctly.

I would expect a single ah_cache lock, with the refcount tracking the
number of users of the entry.

Thanks.

> 
> I reviewed the last Sashiko comment and it's not relevant since on
> destroy AH failure, we keep the entry in the hashtable.
> 
> Thanks
>  

