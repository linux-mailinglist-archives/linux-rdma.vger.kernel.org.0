Return-Path: <linux-rdma+bounces-22335-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YlueJfopM2pE+AUAu9opvQ
	(envelope-from <linux-rdma+bounces-22335-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 01:12:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1639F69CC60
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 01:12:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=mdY0b4Jq;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22335-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22335-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 53E803014AAD
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 23:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E9C3B1006;
	Wed, 17 Jun 2026 23:12:56 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D1B388396
	for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2026 23:12:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781737975; cv=none; b=I+H3HK6Jsc4faK0vSR/xwnSVZFmo8t76XN2FnlzejZziCZDVLZ8CDWXrU5cRndcZdbGZI2SVQDJLodDnNv2eIu9VXFcmUpeLb1vhsHJZHuz5z/GMSrz4JLDlFq9hSgpUMPTRmUb8qUorJXMY7QbgZkkkl0V3IEnUGt23OORLdDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781737975; c=relaxed/simple;
	bh=L+B2SLOMh1NxVe97e0ukVO7/L9L3xhDymEbvawpokjk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wx2q/wSrBWDYVYACrpVRifUA2ywpxrSrKakTD0A+ntw6oXsfGgPPLZzDJFm1N1SLR1FMArAzgxq4sxKiQrekq6WkV7TIuesSvKSAv4lbFmcefZpp+WWJWaug6WgfDkPKIsqA13eO9WbwKM8fbkHmM3AuQnOlLhykN8bNS6ZLyDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=mdY0b4Jq; arc=none smtp.client-ip=44.246.1.125
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1781737974; x=1813273974;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T95Xz90R9sFG0RNJDdhvSbdu9MyELJ7ZqobeMzYntN0=;
  b=mdY0b4Jqe+WI29uCwHLCS/rA9WKveVfII1TzEW2zkEigAryyZmVfscDl
   M1tSiA/5K760HmL8PDWWnZqBYwU5H3hSgJe5mh9sYybRdphUiQPGxZvrV
   vvCufuSwcK8cJ7zEik3Tm5aP/wkwU5TfOEYlJHu0XSOOVZOF/sqx5e+8a
   +SSBgbKDX/oujghMm1VO3VwlhOVXsONPMzzq91HtTNgKhZ/Rt5J+8+f0g
   DdkfKPkz8StqnrexZTT0/Px/3CYK+gwUYj1KECRoe16KVGgFbNnRUoc+q
   3VNafyHLXRD25u2zxNHmvJVskyhvh84+sX7Y5PrH7t0zCLtJGhFQw6I59
   g==;
X-CSE-ConnectionGUID: KfCDOg1YS3OO0BOIFs8BMA==
X-CSE-MsgGUID: GOPW6NVyTyOiECOGBm+Q2g==
X-IronPort-AV: E=Sophos;i="6.24,210,1774310400"; 
   d="scan'208";a="21989666"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 23:12:54 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:3687]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.226:2525] with esmtp (Farcaster)
 id 7fb2e266-cc45-4e0f-8527-9a16e81d8993; Wed, 17 Jun 2026 23:12:54 +0000 (UTC)
X-Farcaster-Flow-ID: 7fb2e266-cc45-4e0f-8527-9a16e81d8993
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 17 Jun 2026 23:12:54 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Wed, 17 Jun 2026
 23:12:52 +0000
Date: Wed, 17 Jun 2026 23:12:43 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: tom sela <tomsela@amazon.com>, <leon@kernel.org>,
	<linux-rdma@vger.kernel.org>, <sleybo@amazon.com>, <matua@amazon.com>,
	<gal.pressman@linux.dev>, Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-rc] RDMA/efa: Propagate destroy AH error
Message-ID: <20260617231243.GA28311@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
References: <20260526073334.24905-1-tomsela@amazon.com>
 <20260602002223.GA644685@nvidia.com>
 <20260608145738.GA43925@dev-dsk-tomsela-1c-ce9cc34e.eu-west-1.amazon.com>
 <20260608152622.GM1962447@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260608152622.GM1962447@nvidia.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D032UWB003.ant.amazon.com (10.13.139.165) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[amazon.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22335-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:tomsela@amazon.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:sleybo@amazon.com,m:matua@amazon.com,m:gal.pressman@linux.dev,m:ynachum@amazon.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1639F69CC60

On Mon, Jun 08, 2026 at 12:26:22PM -0300, Jason Gunthorpe wrote:
> On Mon, Jun 08, 2026 at 02:57:38PM +0000, tom sela wrote:
> > On Mon, Jun 01, 2026 at 09:22:23PM -0300, Jason Gunthorpe wrote:
> > > On Tue, May 26, 2026 at 07:33:34AM +0000, Tom Sela wrote:
> > > > AH destruction currently always returns success, ignoring any error
> > > > from the device. Propagate the actual device error so the caller can
> > > > handle failures appropriately.
> > > 
> > > Callers don't handle failures. Drivers are not permitted to fail
> > > destroy, if they do it probably will trigger a WARN_ON.
> > > 
> > > You can make some of an argument to allow failing destroy for user
> > > objects only, but not like this in general for kernel objects.
> > > 
> > > If your FW fails destroying a kernel object then the device is busted,
> > > you should reset it and succeed to destroy the kernel object anyhow.
> > > 
> > > Jason
> > 
> > 
> > This code is for user objects only. When destroy is called for a
> > user object, the core code handles the failure gracefully and can
> > retry cleanup at a later stage.
> > 
> > Currently we don't have a code path where destroy_ah actually fails
> > in device, but we'd like the error propagation in place for
> > completeness so that if a future FW change can return a transient
> > error, we handle it correctly rather than silently ignoring it.
> > 
> > Would you prefer we explicitly guard this with a check for
> > ibah->uobject (i.e., only propagate the error when it's a user
> > object).
> 
> Do you ever plan to support kverbs on efa?

I believe we eventually will.

> 
> It is still not Ok to propogae all failures even on uobjects, you will
> still trigger a WARN_ON eventually.. It has to succeed under the retry
> logic.

So propagating EBUSY/EAGAIN for userspace objects does make sense?

Michael

> 
> Jason



