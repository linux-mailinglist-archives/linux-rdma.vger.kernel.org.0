Return-Path: <linux-rdma+bounces-19911-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EL6nG3+W+GkowwIAu9opvQ
	(envelope-from <linux-rdma+bounces-19911-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 14:52:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E94614BD40B
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 14:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79C24301AB85
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 12:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBF03D7D60;
	Mon,  4 May 2026 12:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="pbcrdKtP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1743D7D72
	for <linux-rdma@vger.kernel.org>; Mon,  4 May 2026 12:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777899085; cv=none; b=C2YqhPQOiw2uP33YepjCGGpIc2Zaf7u5MZgBDXji2DzxMMOuk2W3iDgFiCYbJimpxvPLLNaqHgxaghgqSnyd+Y4rXqYwPyLOml14xXt+RRbnLY3HF6odaGsRp6A4FKCqj68miQBFAtIyGl6qjzWLYLEVg5Yamc8MLndWMqMBfZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777899085; c=relaxed/simple;
	bh=bh8BlOwgPUu9tdNtDkaB8EAw+hga3yhykmkwr4iAe9w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUGsteypDJqqL3m+0L5qgf6N8nWAXPtngwE2pbvx0IRiAKSujD0WqBNZ9cldtfm3CeyFayXkQgV8PMsAu5NZWehN1HsOW9ITL9vIBJgaR36EMgcegJI77gL/W+YFi3n4FsCwInNhWO6tD3TsnmLMWIVDdRmYcQlDwK9o0mRjTSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=pbcrdKtP; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1777899083; x=1809435083;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7PWby+vXmAFsMvbdhzcg0CfvjM9dyM7XZeoId45cmVA=;
  b=pbcrdKtPKUwwofUlvcpLLOTwmnGRFRpM31pNY+fX8ardZp4nlAPEwOOO
   1foXkyvQk0oZZwZ+Y1wPWyS8iMtMd3cfX2VDAf/sorTn6d0xuGv4St0q8
   WHBVihrsQtPzeBKA/9UQLmgoaCMOw6VfVrWWiNlABuQB46qikgLpKxsw5
   tG48l7mPURIwqz6bEvZCyqIcm09gnx/CPh1G6OOsd+qDsFPcD1aGLF50d
   Z0nW1eAfxi2FWUv63geHIA7yhQoYTv3hRZUKqfhfNRhStO29Iwh0d3Net
   Ol5sCNm94KdKmdTE9z1LdZSbIasjEu8C2Oj2MF5amAS+pNo7oNZd5JaNa
   g==;
X-CSE-ConnectionGUID: pCNqhLnZRuuWWXTfTLlT7Q==
X-CSE-MsgGUID: 4mBZUe6lSJ+5mkpD+DM31g==
X-IronPort-AV: E=Sophos;i="6.23,215,1770595200"; 
   d="scan'208";a="18663538"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 12:51:20 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:28844]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.224:2525] with esmtp (Farcaster)
 id a6422941-1d32-490e-87b5-5038fa270805; Mon, 4 May 2026 12:51:19 +0000 (UTC)
X-Farcaster-Flow-ID: a6422941-1d32-490e-87b5-5038fa270805
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 4 May 2026 12:51:19 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Mon, 4 May 2026
 12:51:17 +0000
Date: Mon, 4 May 2026 12:51:09 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: Sean Hefty <shefty@nvidia.com>
CC: Doug Ledford <doug.ledford@hpe.com>, Jason Gunthorpe <jgg@nvidia.com>,
	"leon@kernel.org" <leon@kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "sleybo@amazon.com" <sleybo@amazon.com>,
	"matua@amazon.com" <matua@amazon.com>, "gal.pressman@linux.dev"
	<gal.pressman@linux.dev>, Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next v2 1/5] RDMA/core: Add Completion Counters
 support
Message-ID: <20260504125109.GA36751@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
References: <20260416212327.18191-1-mrgolin@amazon.com>
 <20260416212327.18191-2-mrgolin@amazon.com>
 <2bfaa4cc-8e4f-43ad-a483-36ac1ae3caea@hpe.com>
 <20260430121833.GA30363@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
 <d3994658-d679-4205-8b59-a6888bcbc144@hpe.com>
 <CH8PR12MB9741AC2B68E736EC5D2C9C93BD352@CH8PR12MB9741.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CH8PR12MB9741AC2B68E736EC5D2C9C93BD352@CH8PR12MB9741.namprd12.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D033UWC003.ant.amazon.com (10.13.139.217) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Queue-Id: E94614BD40B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19911-lists,linux-rdma=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]

On Thu, Apr 30, 2026 at 10:33:55PM +0000, Sean Hefty wrote:
> > >>> Add core infrastructure for Completion Counters, a light-weight
> > >>> alternative to polling CQ for tracking operation completions.
> > >>>
> > >>> Define the UVERBS_OBJECT_COMP_CNTR ioctl object with create,
> > >>> destroy, set, inc and read methods for both success and error
> > >>> counters. Add a QP attach method on the QP object to associate a
> > >>> completion counter with a queue pair.
> > >>>
> > >>> The create handler constructs umem from user-provided VA or dmabuf
> > >>> for each counter, following the CQ buffer pattern.
> > >>
> > >> Description here doesn't match implementation.  The umem or dmabuf is
> > >> optional, while this reads that they are the only two options.
> > >> If neither is passed in, then the counter is on the hardware and the
> > >> read operation is used to get the value (as per the code anyway).
> > >
> > > Thanks, I'll make that path more clear in the commit message.
> > >>
> > >> Which raises a different scenario our hardware enables.  We can pass
> > >> in a umem on create, but that doesn't mean the counter exists in
> > >> umem, it exists on the device and it is copied to umem.  If you copy
> > >> it on every counter update, that kills PCI-e usage, so we have an
> > >
> > > Why would it load PCIe more than writing CQEs into a CQ?
> > 
> > You don't necessarily signal every single completion, but updating umem with
> > every single counter update has that effect.  It's just unnecessary PCI-e
> > bandwidth consumed.  And it happens to be in addition to any other CQE
> > updates, etc.  From our experience, it adds up when you have lots of counters.
> > Writing every update out for 1,000s of counters doesn't scale well.  So while
> > the API works well for you as it is, no doubt if we show up in a few months
> > with our hardware wanting to do something similar, we will be told "you
> > should use the official interface for this", so we need this interface to be
> > acceptable to our use patterns also.
> > 
> > >> option to use a trigger to only update on a periodic basis (but then
> > >> user space authors start polling on the umem location and killing CPU
> > >> cycles, so this option is not preferred), or there is a wait option
> > >> where you can set the target and then in your app use a wait call to
> > >> wait for the count to be reached (we've found this is about the only
> > >> performant way to implement these counters).
> > >>
> > >> Also, we don't really attach counters to QPs.  That isn't usually
> > >> what we care about counting.  Given that our EPs are not connected,
> > >> counters on it are usually only useful for recv operations where you
> > >> can get aggregate data for a given EP.  For send, it is often that we
> > >> really want counters on a per-flow basis knowing that we have many
> > >> flows that go through that one EP (soon to be QP).  So, for us, we
> > >> create a counter, then during our send operations, if we want a
> > >> specific transfer to be included in a specific counter, it's flagged
> > >> in the command we send to the hardware for that send operation.
> > >> That implies that a proper place to hang a list of counters is
> > >> probably off of an AH instead of a QP for us.
> > >>
> > >> I think we can extend this API to suit our needs, relax some of the
> > >> current restrictions/assumptions, and be good.  But, as this is a
> > >> user visible API, if it's taken as-is, I would suggest that the
> > >> rdma-core portion be marked as experimental until we've made the
> > >> changes needed for our hardware in order to avoid user API churn.
> > >>
> > >> These changes could be summed up as:
> > >>
> > >> 1) Make qp attachment optional
> > >
> > > The attachment is already a separate call that can be avoided.
> > 
> > Yes. but the code that tells the user whether or not it is supported will refuse
> > to recognize the feature without the attach_qp function pointer being
> > registered.  So, while it may be optional to attach the qp, the routine to attach
> > it to a qp is not optional.  I was referring to that.  I mean, we could make a
> > stub, but it would likely just return -EOPNOTSUPP or somesuch.  And, the API
> > as it stands, doesn't have any way to consume a counter without attaching it
> > to a QP.  In our case, we will be needing to add an extension to the already
> > extended AH that we will need for UET and in that we will attach the counter
> > handle to specific data transfer commands and that's how our counters will
> > get updated.  For this patchset to truly make attaching the counter to a qp
> > optional, you would need to add another way to consume it. So you say it's
> > optional in this patchset, but it's really not as far as I can tell.
> > 
> > >> 2) Extend create verb to differentiate between on-card counter with
> > >> umem target and in-umem counter
> > >
> > > Can you elaborate on the extension you have on your mind? This seems
> > > to me as a totally driver-device level implementation detail. EFA for
> > > instance has device level counters that are being synced into the
> > > provided memory on each update. Others may choose a different sync
> > > strategy.
> > 
> > Allow me to backtrack and rephrase somewhat.  My original comment was
> > brought out by the man pages that say, in a nutshell, the counter resides in
> > umem but you can't modify it directly, you must use the accessor functions to
> > modify it.  This implies to readers that the actual counter is in umem.  I think
> > that's inaccurate.  As you say, you sync the counter to umem.  The counter
> > resides on the device.  This is really why they have to use the accessors,
> > otherwise any direct updates would just get overwritten later.
> > 
> > So allow me to rephrase as: Remove the wording in the man pages that the
> > counter is in umem (as it really isn't), then add some optional create flags for
> > sync method and frequency. With the counters really being on the device and
> > synced to umem, optional sync triggers makes sense.
> > Doing it on every update could be the default, but I can also see doing a sync
> > on: timer interval, count interval, specific trigger event of another sort, etc.  Or,
> > conversely, just be prepared for us to bring the optional sync triggers as an
> > extension to the base API later.
> > 
> > >> 3) Extend create verb to pass in optional trigger or wait capability
> > >> to perform limited umem updates based upon passed in option
> > >
> > > I think this can be vendor specific extension rather than a common
> > > interface. Providers that want to support this mode can easily add
> > > their own "update frequency" attribute in create ioctl or introduce a
> > > "sync" verb that will do what's needed for the sequential read to
> > > return an up-to-date value.
> > 
> > It's actually a useful API (from experience), so I would prefer it didn't have to
> > be vendor specific, aka we don't want people having to custom code to our
> > hardware for something generally useful.  I wouldn't say it should be required
> > from all vendors, but I'm reluctant to make it vendor specific instead of just an
> > optional extension to the base API.
> > I am, however, perfectly happy to provide the extension to the base API as
> > opposed to requiring it be part of the initial patchset.
> > 
> > >> 4) Modify read operation so that it can either return the value
> > >> directly or just trigger an async update of a buffer backed counter
> > >> (especially useful if the umem counter is on a GPU, is set for a
> > >> triggered update, and you just want to force an immediate async
> > >> update)
> > >
> > > See my suggestion above. I think what you describe here should be a
> > > separate command.
> > 
> > We can add a flush command.  Same deal as read, only instead of returning
> > the value to the caller, it flushes it to whatever the destination is supposed to
> > be.  Or, the semantics of read could be modified such that a read also triggers a
> > flush if there is a known umem or gpu mem target for the counter.  Either way,
> > although I think I might prefer the flush variant.
> 
> I agree with most of what Doug said.  To be more specific, this is my current thought: 
> 
> Define counter group: 1 to N counters to size X (e.g. u32, u64)
> 
> 1. A counter group is associated with a MR on creation.
> 2. A flush operation writes 1 or more values from a counter group to the MR.
>    Provider flushes the entire group or selectively flushes 1 value
>    Depends on implementation and higher-level SW semantic
>    Flush may be a no-op
> 3. Future: flush takes parameters to control when the write is required
>    Take-away is that these are flush parameters, not counter attributes
> 
> I expect flush to be handled by the userspace verbs provider, so it may not need a kernel ABI at this time or be standardized.
> 
> 
> A libibverbs API aligned with libfabric would look like this:
> 
> Define completion counter: a success + error counter pair
> 
> ibv_create_compcntr(ctx, attr, &cntr)
> ibv_read_cntr(cntr, &val)
> ibv_read_err_cntr(cntr, &val)
> 
> To support different HW, I was suggesting the kernel use a different construct, a counter group (previously called a counter array).  There's only 1 MR per counter group.  If required, it is the provider's responsibility to allocate multiple groups and piece them together (Jason's suggestion).
> 
> The read_cntr() API suggests that the provider owns the MR for the counter group.  Allowing direct user access to the MR implies the user knows how to interpret the value(s) being written, so I don't think a user provided MR makes sense.
> 
> - Sean

I'll try to answer you both here.

I feel like a lot of the confusion comes from the option to pass
user-provided memory for completion counter usage. Although this
option didn't force any specific device implementation or dictate
how/when count values are written to that memory, I've removed this
support from the common libibverbs interface. Additionally, following
the discussion in [1], I'm going to move buffer attributes and umem
ownership to drivers in a way that can later be converted to use
core helpers once we have them.

Similarly, counter flush and update frequency isn't supported by all
HW vendors (including EFA), and I didn't plan to add it at this
stage. That said, I do want to make sure we are not closing the door
on those features and that the interfaces can be extended to support
them.

Here's how I see possible future extensions:

At the Completion Counter level, an optional flush command can be
added and can translate to a nop when not required for a given HW.
As Sean suggested, it can take additional params or flags to allow
more fine-grained control over the operation.

If for performance reasons one would like to "place" multiple
Completion Counters together and flush their values with a single
operation, we can introduce the following interface:

ibv_create_comp_cntr_group()
ibv_flush_comp_cntr_group()

And extend ibv_create_comp_cntr() with an optional comp_cntr_group
param.

As I see it, a single Completion Counter is always a pair of success
and error counts.

I can't see anything in the code that is blocking the possibility
of supporting attach to an AH in the future.

Michael

[1] https://lore.kernel.org/all/jpobfdsuuj4wmrqkxzpjmfjxgz6vn2m6a6wy666yfapv6hzytj@6g5qrelixuwe/


