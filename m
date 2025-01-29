Return-Path: <linux-rdma+bounces-7309-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E161BA22289
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jan 2025 18:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54BBF165882
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jan 2025 17:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E081DF997;
	Wed, 29 Jan 2025 17:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jXtAT6em"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18E11FC8;
	Wed, 29 Jan 2025 17:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738170584; cv=none; b=mOh6mYyRO1nltOTAxj1pneG2zk2LClVKoIpzIpu/n5wmqC3mPqrkp6ROjh8Mf/TTFfU9A5fd0CjmI1CkjhjYelke+SgHAvLj7Ma31U/WBmrBZ0LXVM387IQDfWWdb8wQK9diAAGtj3xhZnSwuIxeu+u1a46qXXeIuw3KvF2Yd5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738170584; c=relaxed/simple;
	bh=ck45ob/5XYTRoa4Ra4aF7dzK7GMrFfYCQgn6nhLfZYE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f379EWWpiLiBHlE7R2g9kuWNrQ1vRZoRDZ58EhHqyJpsW2bq7s/z9NOwsUW1SoezAeyTCSp8KI2iIO5OssXxcjlTQdaSPeEGX/N4jFGdWXnyeXdVXY6+miAJ+sD/LVSr8eejJZt1aTU8BbqlMeS0tyCnWAx31bObpZBNoEWzmQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jXtAT6em; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738170583; x=1769706583;
  h=message-id:subject:from:to:date:in-reply-to:references:
   content-transfer-encoding:mime-version;
  bh=ck45ob/5XYTRoa4Ra4aF7dzK7GMrFfYCQgn6nhLfZYE=;
  b=jXtAT6emIcg+U6Jdm36gU+arta0aj+mhrDxgG1y6HNsyrE0QgY/Go5Ic
   mUUuZZh50h7aY6WmAisxIRZA/0afIOK78GwAUa5AN9SmHB22LQBYYTAgp
   HzONHCy4d5WGWvXWRkRDYr2i7Mzs9TecdN4Grj/Hqjb/seKqtZCV4rkpb
   9F70qYEUKTY8uEPQgG6WzY3O0OTPkUaz5RzdJFRQ5IPMaphO0M0sroI8U
   AQjpoTsRtrgTMqG6nOZY7MHDf5LHVXalKftOie0f3uZAXeSjHSJXDHem5
   yTmyuJN3DdZmuvTcQH/FCyU4AGx3uZGL8SiZFQ31j0X8SoHJlTn97X2ag
   A==;
X-CSE-ConnectionGUID: NWW9mfMJRyekWmoZeAY/dQ==
X-CSE-MsgGUID: JVa/JhKkSymyrPCKgYRaMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="38578385"
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="38578385"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 09:09:43 -0800
X-CSE-ConnectionGUID: FYvkuhm9TKmr6QSfpBFjrw==
X-CSE-MsgGUID: YPByyfzlRqKeIk8k2ZIu8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108945025"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO [10.245.246.222]) ([10.245.246.222])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 09:09:37 -0800
Message-ID: <4dd3822a2ab98ce0cc6e2d8849e7133ac6ced0b1.camel@linux.intel.com>
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
Date: Wed, 29 Jan 2025 18:09:35 +0100
In-Reply-To: <20250129134757.GA2120662@ziepe.ca>
References: <20241201103659.420677-1-ymaman@nvidia.com>
	 <20241201103659.420677-2-ymaman@nvidia.com>
	 <7282ac68c47886caa2bc2a2813d41a04adf938e1.camel@linux.intel.com>
	 <20250128132034.GA1524382@ziepe.ca>
	 <de293a7e9b4c44eab8792b31a4605cc9e93b2bf5.camel@linux.intel.com>
	 <20250128151610.GC1524382@ziepe.ca>
	 <b78d32e13811ef1fa57b0535749c811f2afb4dcd.camel@linux.intel.com>
	 <20250128172123.GD1524382@ziepe.ca> <Z5ovcnX2zVoqdomA@phenom.ffwll.local>
	 <20250129134757.GA2120662@ziepe.ca>
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

On Wed, 2025-01-29 at 09:47 -0400, Jason Gunthorpe wrote:
> On Wed, Jan 29, 2025 at 02:38:58PM +0100, Simona Vetter wrote:
>=20
> > > The pgmap->owner doesn't *have* to fixed, certainly during early
> > > boot before
> > > you hand out any page references it can be changed. I wouldn't be
> > > surprised if this is useful to some requirements to build up the
> > > private interconnect topology?
> >=20
> > The trouble I'm seeing is device probe and the fundemantal issue
> > that you
> > never know when you're done. And so if we entirely rely on pgmap-
> > >owner to
> > figure out the driver private interconnect topology, that's going
> > to be
> > messy. That's why I'm also leaning towards both comparing owners
> > and
> > having an additional check whether the interconnect is actually
> > there or
> > not yet.
>=20
> Hoenstely, I'd rather invest more effort into being able to update
> owner for those special corner cases than to slow down the fast path
> in hmm_range_fault..

Just a comment on the performance concern here. This can be crafted in
a way that only if the driver provides a callback, there is a (small)
hit. If there is no callback at that point, we're looking at a
migration to ram. If there is a callback it's typically followed by an
address computation and page-table setup. Compared to those, the
callback performance impact is probably unmeasureable.

/Thomas

