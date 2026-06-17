Return-Path: <linux-rdma+bounces-22334-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i3E8D4klM2q89wUAu9opvQ
	(envelope-from <linux-rdma+bounces-22334-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 00:54:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D42F69CC09
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 00:54:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=DFGnyshW;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22334-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22334-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E37BB3018AD9
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 22:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374FF3AEF54;
	Wed, 17 Jun 2026 22:53:20 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA64037C11C
	for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2026 22:53:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781736800; cv=none; b=MGKM6+jTz3jxSLAOKkIJDOUB6VGyQFBdXQfAqmQhorOTKbvA9BfRqkeNwVUtap9tijsxKdw4TYd/3s+JKRAACCq246CgiRnrqmMYEHnKyQr93IzWkvJ+BCPHRF7lJUUfeaeG6k7Yh2s+j5Nvf4wjpq6f8lcXPi+ruQ8rERVN25I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781736800; c=relaxed/simple;
	bh=qsJukOqPV2f3PhZ53HLFGQIBSuHQ9quB8JvFQgvTKkE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JO518Ngy8IudTqJiCvJ+PYNVrHz+rBVALBPXD0qP65ykwj+rfCedNflHCN9OsIlkGZsq9f2FHsUUp8vtjXqRJS8r7xe5Wm1D7Y7lpq712pRvpIx8d87pb/MjdulSIGgGTIeN53PLVk73twJpKYa2aBbCWoEzWZtHhE7vbmgiQl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=DFGnyshW; arc=none smtp.client-ip=44.246.1.125
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1781736798; x=1813272798;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bSOKUx2jtIlPUwzU+I7QZdw4fQfrf/kc2i/Ffj8fQDM=;
  b=DFGnyshWRA9ecTJYpDEpDgglmaFLrp9mnbPFdgvQyx5LfHtdGwqF3mOR
   U6jGi6yb9EufmKa0KbKWnD2o29iqFKK9CPybDi1dDFddi/Lk9PbnfL2mg
   P9UBIPmxMLim3cnzKNx0yLcEMf8njDvePaX8DmkBO1WUzlU1BpUyjoWBO
   +ydvSB7z/bep92QQ6dW2aHT17j9blbqNrVSfpmIaUZ73PHBqQr0LzzTnj
   4ZGQHO+ncSLTmXo5fCMG4MyxdNMt7c9nDqHzGcTucMN02v3PaLoOtUAkM
   42xEZmL9XlZAoIkFjiG4S/y6lwesk7TGVp+mwGYOCSysIjEQ9+TFaO01S
   Q==;
X-CSE-ConnectionGUID: fbHqBN7wTamNL5MINbDsOw==
X-CSE-MsgGUID: GyqpC8pnQo29090VIBvPig==
X-IronPort-AV: E=Sophos;i="6.24,210,1774310400"; 
   d="scan'208";a="21988811"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 22:53:15 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:32252]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.253:2525] with esmtp (Farcaster)
 id 91a147cf-45f6-49cb-86b7-76d17c1b07e1; Wed, 17 Jun 2026 22:53:15 +0000 (UTC)
X-Farcaster-Flow-ID: 91a147cf-45f6-49cb-86b7-76d17c1b07e1
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 17 Jun 2026 22:53:15 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Wed, 17 Jun 2026
 22:53:13 +0000
Date: Wed, 17 Jun 2026 22:53:04 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Jason Gunthorpe <jgg@nvidia.com>, Yonatan Nachum <ynachum@amazon.com>,
	<linux-rdma@vger.kernel.org>, <sleybo@amazon.com>, <matua@amazon.com>,
	<gal.pressman@linux.dev>
Subject: Re: [PATCH for-next v4 0/2] RDMA/efa: Add AH cache for AH reuse
Message-ID: <20260617225304.GA3279@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
References: <20260608071620.1909543-1-ynachum@amazon.com>
 <20260614071229.GA29713@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
 <20260616175033.GQ327369@unreal>
 <20260616193158.GA35672@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
 <20260617002145.GB3577711@nvidia.com>
 <20260617122842.GZ327369@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260617122842.GZ327369@unreal>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D033UWC001.ant.amazon.com (10.13.139.218) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[amazon.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22334-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@nvidia.com,m:ynachum@amazon.com,m:linux-rdma@vger.kernel.org,m:sleybo@amazon.com,m:matua@amazon.com,m:gal.pressman@linux.dev,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D42F69CC09

On Wed, Jun 17, 2026 at 03:28:42PM +0300, Leon Romanovsky wrote:
> On Tue, Jun 16, 2026 at 09:21:45PM -0300, Jason Gunthorpe wrote:
> > On Tue, Jun 16, 2026 at 07:31:58PM +0000, Yonatan Nachum wrote:
> > > A global AH cache lock would serialize all AH commands for any PD-GID
> > > combination, including the ones that go to the device.
> > > The per-entry mutex allows different entries to issue device commands in
> > > parallel while only serializing operations on the same entry.
> > > 
> > > The initialized flag is needed because the entry must exist in the
> > > hashtable before the device command completes, so concurrent threads
> > > targeting the same PD-GID find it and wait on the per-entry mutex.
> > 
> > I think it looks so weird because it overloads the refcount in two
> > ways.
> > 
> > The scheme really has two different orthogonal ideas:
> >  - A kref which manages the lifetime of the entry and when the kref
> >    reaches 0 the entry leaves the hash. The entry is basically just the
> >    mutex and a user count. The hash holds a guarenteed singleton
> >    locking point to control the HW object creation order.
> > 
> >  - A user count which counts how many active AH's are using the HW
> >    object, and if it is non-zero then the HW object exists.
> > 
> > The combination of the refcount and initialized is overloading both of
> > these different behaviors, along with the funky refcount logic.
> > 
> > But given the initialized costs as much memory in the struct as
> > another refcount you may as well just replace it with a proper user
> > count.
> > 
> > Then it is alot simpler. 
> >  Global lock, do the search, get the kref, unlock and return.
> >  Local lock, check the usercount == 0 and allocate HW object, incr, unlock.
> > 
> >  Local lock, check the usercount == 1 and dealloc the HW obhect, decr,
> >  unlock. put kref.
> > 
> > Ideally the kref put would only grab the global lock when the refcount
> > is 0, but you have to be able to tolerate multiple 0 kref things in
> > the hashtable for that to work.
> 
> Jason,
> 
> I would suggest that EFA start with the basics. Their command submission
> path has spinlocks, so their claim of “performance degradation” should
> be viewed with an appropriate degree of skepticism.
> 
> Thanks
>

Leon, I appreciate your skepticism about our claims but the spinlock we
hold for the brief period of taking a command context and writing
command buffer has nothing to do with the subject here. How is that in
any way equivalent to serializing all AH commands for a device?

Michael

> > 
> > Jason
> > 
> > 
> > 
> > > 
> > > I am open to simplifying to a single globlal lock if you prefer, but it
> > > comes at the performance cost of serializing all AH commands.
> > > 

