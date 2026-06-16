Return-Path: <linux-rdma+bounces-22291-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L5E8FcWkMWoKowUAu9opvQ
	(envelope-from <linux-rdma+bounces-22291-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 21:32:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE91694F82
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 21:32:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=PLqYOvK8;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22291-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22291-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 62F803028268
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 19:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554863DBD57;
	Tue, 16 Jun 2026 19:32:17 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029573655E0
	for <linux-rdma@vger.kernel.org>; Tue, 16 Jun 2026 19:32:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781638337; cv=none; b=MVekJa/xg9ffIOFRyDuJOHn260OTDiuuC8ryzas0gFyPrW2AFmy4B/ks5foqBLHyMk+FKv6wO/v6TqGRUMpBykx7sll4zMhIYiUotic20Sox1PwBoNipbCfk+akHJJsMNeTc9LjHm8tMWVUW6prSFDApQ/HBlkDZmkgwuuHZICw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781638337; c=relaxed/simple;
	bh=umzOEVd5KhXRl6OUpVzdtOR4mGmTIbBctFgS2t65P+0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPtuyr9RW2WF9dnhEslxB8y4k5WSxLMxBjTZ07I8xmrY7pG91/e09l6qkYzO0/VTuvnmpjyoe9op8ZUyUQVqO0HT+y5FXmcbMEkgER4Ok7ZZRTCfNCYZ1NJmoDXzDqMHhGsJ/pRZjYku6hip/UnZaxQJ3UMvCiNnRDrAdYulTBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=PLqYOvK8; arc=none smtp.client-ip=44.246.68.102
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1781638335; x=1813174335;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YOJJ2HZXEqd8krXG5cuYRAntnJorhIwzeqbUcfFpQPI=;
  b=PLqYOvK8/RBfkoN4FqAm8HCBsOBZE5C6GgJOxSoeL2uXlmdE2piXhrc3
   5MMtT5JQhmQzjRqxIgOs2wR32vUCl9thQPpRG2Xbf27CcQLowzao5Eahx
   eY6CnYOsEK+IpDk14UBS0vfdH/RJZxKt9wkKUm0KtXj5BemDDQ/Ol0mSd
   JSyS36Wui1pCkxiQKXt//fWViXvtSsz05UcfquJ+A7Ps3R/NHOHe9OGyO
   njNcs/MoZXE7j9xun59TbMrD4kyFsw8OL1kgZdiEPXisDTouWKEltskZ9
   ++3i2nC3GJaf2gLXbf0/OfdBUwCwAw1vRPyz/d8VwdwnDg9A4KxDqZCx/
   w==;
X-CSE-ConnectionGUID: Y0X9julkSBuP2fWKeGxfVA==
X-CSE-MsgGUID: vR+TWzGgRheGC1+ITiWCaA==
X-IronPort-AV: E=Sophos;i="6.24,208,1774310400"; 
   d="scan'208";a="21906463"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 19:32:13 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:23376]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.233:2525] with esmtp (Farcaster)
 id 154ae96c-eea3-4375-805a-79015b5d6174; Tue, 16 Jun 2026 19:32:13 +0000 (UTC)
X-Farcaster-Flow-ID: 154ae96c-eea3-4375-805a-79015b5d6174
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 16 Jun 2026 19:32:12 +0000
Received: from dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com
 (10.253.69.224) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Tue, 16 Jun 2026
 19:32:11 +0000
Date: Tue, 16 Jun 2026 19:31:58 +0000
From: Yonatan Nachum <ynachum@amazon.com>
To: Leon Romanovsky <leon@kernel.org>
CC: <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>, <mrgolin@amazon.com>,
	<sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>
Subject: Re: [PATCH for-next v4 0/2] RDMA/efa: Add AH cache for AH reuse
Message-ID: <20260616193158.GA35672@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
References: <20260608071620.1909543-1-ynachum@amazon.com>
 <20260614071229.GA29713@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
 <20260616175033.GQ327369@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260616175033.GQ327369@unreal>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D043UWA001.ant.amazon.com (10.13.139.45) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[amazon.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22291-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com:mid];
	FORGED_SENDER(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@nvidia.com,m:linux-rdma@vger.kernel.org,m:mrgolin@amazon.com,m:sleybo@amazon.com,m:matua@amazon.com,m:gal.pressman@linux.dev,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DEE91694F82

On Tue, Jun 16, 2026 at 08:50:33PM +0300, Leon Romanovsky wrote:
> On Sun, Jun 14, 2026 at 07:12:29AM +0000, Yonatan Nachum wrote:
> > On Mon, Jun 08, 2026 at 07:16:18AM +0000, Yonatan Nachum wrote:
> > > Changelog:
> > > v4:
> > >  * Use kzalloc_obj for AH cache entry allocation instead of kzalloc
> > > v3: https://lore.kernel.org/all/20260607161753.1607559-1-ynachum@amazon.com/
> > >  * Address Sashiko comments in:
> > >    https://sashiko.dev/#/patchset/20260512061121.2177521-1-ynachum%40amazon.com
> > > v2: https://lore.kernel.org/all/20260512061121.2177521-1-ynachum@amazon.com/
> > >  * Zero-initialize AH cache key on cache lookup.
> > > v1: https://lore.kernel.org/all/20260510083035.458081-1-ynachum@amazon.com/
> > > 
> > > -------------------------------------------------------------------------
> > > New EFA devices don't support the creation of multiple AHs to the same
> > > remote on the same PD. To overcome this limitation, introduce an AH
> > > cache that manages AH reuse transparently.
> > > 
> > > The cache uses an rhashtable keyed by (PD, GID) to track active address
> > > handles with refcounts. On create AH, the driver returns an existing AH
> > > number if one is already cached, or creates a new one and caches it. On
> > > destroy AH, the driver only issues the device destroy command when the
> > > last reference is dropped.
> > > 
> > > A per-entry mutex serializes concurrent device commands on the same
> > > cache entry, preventing create-before-destroy races on the device.
> > > 
> > > Yonatan Nachum (2):
> > >   RDMA/efa: Add initialization of AH cache rhashtable
> > >   RDMA/efa: Add AH cache handling on create and destroy AH
> > > 
> > >  drivers/infiniband/hw/efa/Makefile       |   4 +-
> > >  drivers/infiniband/hw/efa/efa_ah_cache.c | 163 +++++++++++++++++++++++
> > >  drivers/infiniband/hw/efa/efa_ah_cache.h |  42 ++++++
> > >  drivers/infiniband/hw/efa/efa_com.c      |  12 +-
> > >  drivers/infiniband/hw/efa/efa_com.h      |   3 +
> > >  drivers/infiniband/hw/efa/efa_com_cmd.c  |  73 +++++++---
> > >  drivers/infiniband/hw/efa/efa_com_cmd.h  |   1 +
> > >  drivers/infiniband/hw/efa/efa_verbs.c    |   9 +-
> > >  8 files changed, 281 insertions(+), 26 deletions(-)
> > >  create mode 100644 drivers/infiniband/hw/efa/efa_ah_cache.c
> > >  create mode 100644 drivers/infiniband/hw/efa/efa_ah_cache.h
> > > 
> > > -- 
> > > 2.50.1
> > >
> > 
> > Hi, kind reminder.
> > This series blocks merging EFAv4 device ID and we would want it to land
> > for the next merge window if possible.
> 
> It is not possible.
> 
> The use of entry->lock together with a refcount and an "initialize"
> flag suggests that the refcount is not being used correctly.
> 
> I would expect a single ah_cache lock, with the refcount tracking the
> number of users of the entry.
> 
> Thanks.

A global AH cache lock would serialize all AH commands for any PD-GID
combination, including the ones that go to the device.
The per-entry mutex allows different entries to issue device commands in
parallel while only serializing operations on the same entry.

The initialized flag is needed because the entry must exist in the
hashtable before the device command completes, so concurrent threads
targeting the same PD-GID find it and wait on the per-entry mutex.

I am open to simplifying to a single globlal lock if you prefer, but it
comes at the performance cost of serializing all AH commands.


