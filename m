Return-Path: <linux-rdma+bounces-7395-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04C0A26E81
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 10:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671AD161A17
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 09:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43989207DE0;
	Tue,  4 Feb 2025 09:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gEA6NivY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59CF20766E;
	Tue,  4 Feb 2025 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738661561; cv=none; b=LrMD7t0ao81sjUwUk/p7VnlrwoQBZJdi7XMH/GlmSSQbiJBtp3lYgKZZhyWdUQfsRC3cV3P9M77ASE9YrNbjbem/PoCLSvdy4AGJsIWFnXdUuAbUM14qL274cVH1+ruRinrKb4PnEtnKfUMWk28d0ONDcTkeDMUFjOALkMKsly0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738661561; c=relaxed/simple;
	bh=afC03Ee5hYfBovzmOOaQQ63aQs98FWYrDWq0Cfbx4RI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cjUwwWNKgFoC1mN//WlcW0IE4nvxZXVAzK4XlSP2GQ8NuFBtkFJYb3yESBkul79sjGkpNSbft4wgmVxF5E1Yx/Q1PwyNI38qRiASB70zN/aPTNYN5Ai3mPW6sEVnNGv7KIYh+qFd9ORoxLa2qfTX0zIasr1Kik30Hgy4cC7p/5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gEA6NivY; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738661560; x=1770197560;
  h=message-id:subject:from:to:date:in-reply-to:references:
   content-transfer-encoding:mime-version;
  bh=afC03Ee5hYfBovzmOOaQQ63aQs98FWYrDWq0Cfbx4RI=;
  b=gEA6NivYYSqql33BfJi+IqI5kvZ1lQrpEpzCtl4K3MI/GrEKM0rKBY2J
   ycU1/Q8CrXasfmUzKFQrkpLW/WNT8CtZ/z9WWSNwuZxOOfeDOrC4a9ZIo
   48PVzbzRVyk5Zb+ngVBz9Xu55zHzXi6gIUFNQMyuuuFsZXvffGri/kMif
   QJzajLu63iiYMhQFLQhb5+AYe7Pnr7O07RU4rokrLtMcMm7a2yPMbv7+j
   OO8e7A08sgFSLuxhg2szWFAinnAPRbG5VT9WX0azq1M2/mJoxsCr019jJ
   rnaVxtMM0RLfGf1fCpkfuk51SQkxGto1gIiPSofkUdwkSb7aJIyUPDmXo
   Q==;
X-CSE-ConnectionGUID: 7x9uh/hHR/G7oQZeoau83Q==
X-CSE-MsgGUID: QJ/uSoThSXSyNdEsC/gLRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="43100957"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="43100957"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 01:32:39 -0800
X-CSE-ConnectionGUID: zfYHGJSsSyC0q1C1d5OGAQ==
X-CSE-MsgGUID: ByXkmf1TR56RDx03kwQdlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110998417"
Received: from lfiedoro-mobl.ger.corp.intel.com (HELO [10.245.246.144]) ([10.245.246.144])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 01:32:35 -0800
Message-ID: <7b7a15fb1f59acc60393eb01cefddf4dc1f32c00.camel@linux.intel.com>
Subject: Re: [RFC 1/5] mm/hmm: HMM API to enable P2P DMA for device private
 pages
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Yonatan Maman <ymaman@nvidia.com>, 
	kherbst@redhat.com, lyude@redhat.com, dakr@redhat.com, airlied@gmail.com, 
	simona@ffwll.ch, leon@kernel.org, jglisse@redhat.com,
 akpm@linux-foundation.org, 	GalShalom@nvidia.com,
 dri-devel@lists.freedesktop.org, 	nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 	linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, linux-tegra@vger.kernel.org
Date: Tue, 04 Feb 2025 10:32:32 +0100
In-Reply-To: <20250203150805.GC2296753@ziepe.ca>
References: <20250128151610.GC1524382@ziepe.ca>
	 <b78d32e13811ef1fa57b0535749c811f2afb4dcd.camel@linux.intel.com>
	 <20250128172123.GD1524382@ziepe.ca> <Z5ovcnX2zVoqdomA@phenom.ffwll.local>
	 <20250129134757.GA2120662@ziepe.ca> <Z5tZc0OQukfZEr3H@phenom.ffwll.local>
	 <20250130132317.GG2120662@ziepe.ca> <Z5ukSNjvmQcXsZTm@phenom.ffwll.local>
	 <20250130174217.GA2296753@ziepe.ca> <Z50BbuUQWIaDPRzK@phenom.ffwll.local>
	 <20250203150805.GC2296753@ziepe.ca>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-03 at 11:08 -0400, Jason Gunthorpe wrote:
> On Fri, Jan 31, 2025 at 05:59:26PM +0100, Simona Vetter wrote:
>=20
> > So one aspect where I don't like the pgmap->owner approach much is
> > that
> > it's a big thing to get right, and it feels a bit to me that we
> > don't yet
> > know the right questions.
>=20
> Well, I would say it isn't really complete yet. No driver has yet
> attempted to use a private interconnect with these scheme. Probably
> it
> needs more work.
>=20
> > A bit related is that we'll have to do some driver-specific
> > migration
> > after hmm_range_fault anyway for allocation policies. With coherent
> > interconnect that'd be up to numactl, but for driver private it's
> > all up
> > to the driver. And once we have that, we can also migrate memory
> > around
> > that's misplaced for functional and not just performance reasons.
>=20
> Are you sure? This doesn't seem to what any hmm_range_fault() user
> should be doing. hmm_range_fault() is to help mirror the page table
> to a secondary, that is all. Migration policy shouldn't be part of
> it,
> just mirroring doesn't necessarily mean any access was performed, for
> instance.
>=20
> And mirroring doesn't track any access done by non-faulting cases
> either.
>=20
> > The plan I discussed with Thomas a while back at least for gpus was
> > to
> > have that as a drm_devpagemap library,=20
>=20
> I would not be happy to see this. Please improve pagemap directly if
> you think you need more things.

These are mainly helpers to migrate and populate a range of cpu memory
space (struct mm_struct) with GPU device_private memory, migrate to
system on gpu memory shortage and implement the migrate_to_vram pagemap
op, tied to gpu device memory allocations, so I don't think there is
anything we should be exposing at the dev_pagemap level at this point?

>=20
> > which would have a common owner (or
> > maybe per driver or so as Thomas suggested).=20
>=20
> Neither really match the expected design here. The owner should be
> entirely based on reachability. Devices that cannot reach each other
> directly should have different owners.

Actually what I'm putting together is a small helper to allocate and
assign an "owner" based on devices that are previously registered to a
"registry". The caller has to indicate using a callback function for
each struct device pair whether there is a fast interconnect available,
and this is expected to be done at pagemap creation time, so I think
this aligns with the above. Initially a "registry" (which is a list of
device-owner pairs) will be driver-local, but could easily have a wider
scope.

This means we handle access control, unplug checks and similar at
migration time, typically before hmm_range_fault(), and the role of
hmm_range_fault() will be to over pfns whose backing memory is directly
accessible to the device, else migrate to system.

Device unplug would then be handled by refusing migrations to the
device (gpu drivers would probably use drm_dev_enter()), and then evict
all device memory after a drm_dev_unplug(). This of course relies on
that eviction is more or less failsafe.

/Thomas

>=20
> > But upfront speccing all this out doesn't seem like a good idea to,
> > because I honestly don't know what we all need.
>=20
> This is why it is currently just void *owner=C2=A0 :)

Again, with the above I think we are good for now, but having
experimented a lot with the callback, I'm still not convinced by the
performance argument, for the following reasons.

1) Existing users would never use the callback. They can still rely on
the owner check, only if that fails we check for callback existence.
2) By simply caching the result from the last checked dev_pagemap, most
callback calls could typically be eliminated.
3) As mentioned before, a callback call would typically always be
followed by either migration to ram or a page-table update. Compared to
these, the callback overhead would IMO be unnoticeable.
4) pcie_p2p is already planning a dev_pagemap callback?
=20
/Thomas

>=20
> Jason


