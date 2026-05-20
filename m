Return-Path: <linux-rdma+bounces-21023-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMZvJJlaDWrBwQUAu9opvQ
	(envelope-from <linux-rdma+bounces-21023-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 08:54:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB285887EC
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 08:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 17CEB30360A3
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 06:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CE9366052;
	Wed, 20 May 2026 06:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="piDO65Dv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB303364EB1
	for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 06:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779260051; cv=none; b=ays4oqmJTtcGaWAJqO1nQiHAqt00uB6W1i0ytdaL0Id6ULQhXKcvEt4KtboY2dJLErI8OF+HDeT6rpXOw5Vg1+KEnmK0m+3OdtT8MmPe/tJexilDB9A3ZZj6fm07N+ULWv01joGrP4y1VdTUxaXoeOot9tnz5v+EmZZN6b7N7gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779260051; c=relaxed/simple;
	bh=nPLSiLrIG2ACBQq7bQMgflAqavH3aKjM83DcRBi+QHg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFYhtiy4LtNgqOCRHVzSiJHUOET0Nj5aag4+WQFbSG0/uLtY07BvkbX91qWqY0251k5m5+B6AEqZtHyN2X3aTTR49FWeDf7QIfOXEBMrudZtmwwHm0jrTNoNRj7qgw7T3+HwGNsvu/w2D+CndsLegVoMWsqxKHNpoQ/m0SlKMXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=piDO65Dv; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1779260049; x=1810796049;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=aDglfnosEVBuMUuu5co3QY7KHvg+hVmnPzbZihN8x/k=;
  b=piDO65DvO717BIz62pDoNb3k09o1ut6aCwbqlby2iSedfO0+zQZedf+A
   tojxDQEJRc6atWW6gF03SG2rrrCz7AIfkwreXi77OXabEX90e+zNPcLNA
   QKwTxRClgE1AyusJqkYjv7dIzDOemuo/1LXFGGfBQ3tJKXMsHeCSPDcCc
   p5O0aZW6MRg4V8HijdN2EwNWpg4BvMY5BSoSByyBkHICahlbcsf6KPO1b
   FLWhWJ2VDd3fByvijSzS64qGb+tRD8V0KovODABgrbp2qxKzzZ+P2Wy1h
   Y93ZsaCNlsiVnEJGbV+woHSvB3A0T2sOvYoA3NwefnwsdGCPSJ1oGUn2n
   w==;
X-CSE-ConnectionGUID: oUrhXS23QfCgSl6rFfMghA==
X-CSE-MsgGUID: IQV3I2jFQFW/TrUB3jKzow==
X-IronPort-AV: E=Sophos;i="6.23,243,1770595200"; 
   d="scan'208";a="20047107"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:53:54 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:28730]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.235:2525] with esmtp (Farcaster)
 id 72d965af-3d22-4a11-8bf4-38b4d93ede97; Wed, 20 May 2026 06:53:53 +0000 (UTC)
X-Farcaster-Flow-ID: 72d965af-3d22-4a11-8bf4-38b4d93ede97
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 20 May 2026 06:53:53 +0000
Received: from dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com
 (10.253.69.224) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Wed, 20 May 2026
 06:53:51 +0000
Date: Wed, 20 May 2026 06:53:31 +0000
From: Yonatan Nachum <ynachum@amazon.com>
To: Leon Romanovsky <leon@kernel.org>
CC: <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>, <mrgolin@amazon.com>,
	<sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>, "Firas
 Jahjah" <firasj@amazon.com>
Subject: Re: [PATCH for-next v2 1/2] RDMA/efa: Add initialization of AH cache
 rhashtable
Message-ID: <20260520065331.GA1721@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
References: <20260512061121.2177521-1-ynachum@amazon.com>
 <20260512061121.2177521-2-ynachum@amazon.com>
 <20260519130755.GV33515@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260519130755.GV33515@unreal>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21023-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma];
	FROM_NEQ_ENVFROM(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3BB285887EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 04:07:55PM +0300, Leon Romanovsky wrote:
> On Tue, May 12, 2026 at 06:11:20AM +0000, Yonatan Nachum wrote:
> > New EFA devices don't support the creation of multiple address handles
> > to the same remote on the same PD.
> > To overcome this limitation, introduce an AH cache rhashtable which will
> > store the refcounts of the same AH creation on the same PD and will
> > allow the driver to manage AH reuse. The hashtable key is the
> > combination of PD and GID. Add initialization and teardown logic for the
> > rhashtable.
> > 
> > Reviewed-by: Firas Jahjah <firasj@amazon.com>
> > Reviewed-by: Michael Margolin <mrgolin@amazon.com>
> > Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
> > ---
> >  drivers/infiniband/hw/efa/Makefile       |  4 +--
> >  drivers/infiniband/hw/efa/efa_ah_cache.c | 30 ++++++++++++++++++++
> >  drivers/infiniband/hw/efa/efa_ah_cache.h | 36 ++++++++++++++++++++++++
> >  drivers/infiniband/hw/efa/efa_com.c      | 12 +++++++-
> >  drivers/infiniband/hw/efa/efa_com.h      |  5 +++-
> >  5 files changed, 83 insertions(+), 4 deletions(-)
> >  create mode 100644 drivers/infiniband/hw/efa/efa_ah_cache.c
> >  create mode 100644 drivers/infiniband/hw/efa/efa_ah_cache.h
> 
> <...>
> 
> > +struct efa_ah_cache_entry {
> > +	struct efa_ah_cache_key key;
> > +	u16 ah;
> > +	bool initialized;
> 
> If this variable is present, it indicates that the reference count is being  
> used incorrectly. In the uninitialized state, the refcount must be 0.
> 
> Thanks

The refcount and initialized track two separate properties of the entry:

- refcount represents the number of active users that hold a reference
  to this cache entry. It is incremented on every create_ah call and
  decremented on every destroy_ah call for the same (PD, GID).

- initialized indicates whether the entry holds a valid AH number from
  the device. An entry exists in the hashtable and can be referenced
  before the device command completes, and also after a successful
  device destroy (when the entry is recycled for a new create).

These two properties are independent — an entry can be referenced by
multiple users while not yet holding a valid AH, and conversely an entry
can transition from initialized to uninitialized while still being
referenced.

Using refcount=0 to represent the uninitialized state would conflate
entry lifetime tracking with device state.

Thanks

