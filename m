Return-Path: <linux-rdma+bounces-7402-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F92A27463
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 15:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 033AE1885518
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 14:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB48213259;
	Tue,  4 Feb 2025 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FhMByyFo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F39F17F7;
	Tue,  4 Feb 2025 14:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738679397; cv=none; b=E+SgYFjBM6N0C/Zo3Pq93FoZqVIQjrrGZ1720E+dQXOgmkCJ7f+LGandT7CW8XdgY/loarh8y/t6f0uGT1rzy7c+SJ0wmnvcdOw0jQ2iRjlDW9RS/SWhUx4oRLFgPy7mkdK4vr942rU5IKuW4moGuqrXZx2wqxL4terxHCVyJ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738679397; c=relaxed/simple;
	bh=lAbL/0l6KMc7nqVP2DUrdeWeqlThU/+Tdw9u/t7yoPg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=liz0GVRv+0j13MiPJbw8N9GGp8jUY01THLZ4OTYlmT/eyir71EKRkJ3qaTHncLwR+rgMx71Bp8qBEoO2K4OJKA/ny+mFI1bmma0iSv2nw0c2ECoxlj1huhWJS/L4kFy7Xj9iZec0a+wj3iGezGrSnmA0iX/Yr0Qofo2u0m5UgMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FhMByyFo; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738679396; x=1770215396;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=lAbL/0l6KMc7nqVP2DUrdeWeqlThU/+Tdw9u/t7yoPg=;
  b=FhMByyFoSk9DbXgpZOSNi9qW4kWdPsrmb19WIfKOLkGYQJczJguYvwbW
   6mS/cAR/oj8XRHk6rOvwsvVfLIUfxqZ+hVcE9By1MsDQ9ahMeOtoHiWri
   zgiIkigH00SfQdwM/p/zhH7OuFLzYJ/zI6kmRM+oXKMFwWjPg7YKxTn6r
   jYzO5kD3WvK36byvXa7jOMYqJGfjU2yxiUKEtIaDDjib3pijawtHeIU51
   yi2ZuVMdK3vVw7bhyPbJvCOtV9MnIUuotX8lSX2K8KRMEwvwJ5H8jZrdW
   boQWfzix1WZtdASnQfjQoJQpi2QH0zsO/lquxE32UK6xicVkNNGk/tt04
   g==;
X-CSE-ConnectionGUID: VE2auqLKTIC9LmDVaD/lCQ==
X-CSE-MsgGUID: VWQ7zcA1S+yjfEAR3/TxAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39238441"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="39238441"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 06:29:55 -0800
X-CSE-ConnectionGUID: RN6d+SumTOSsCLPg3AdQww==
X-CSE-MsgGUID: kC63yfL0SO+G5fseY8Womg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="147807634"
Received: from lfiedoro-mobl.ger.corp.intel.com (HELO [10.245.246.144]) ([10.245.246.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 06:29:51 -0800
Message-ID: <3e96aef8009be69858a69d3e49a2bd7fc7d06f5f.camel@linux.intel.com>
Subject: Re: [RFC 1/5] mm/hmm: HMM API to enable P2P DMA for device private
 pages
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Yonatan Maman <ymaman@nvidia.com>, kherbst@redhat.com, lyude@redhat.com,
 	dakr@redhat.com, airlied@gmail.com, simona@ffwll.ch, leon@kernel.org, 
	jglisse@redhat.com, akpm@linux-foundation.org, GalShalom@nvidia.com, 
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, 	linux-tegra@vger.kernel.org
Date: Tue, 04 Feb 2025 15:29:48 +0100
In-Reply-To: <20250204132615.GI2296753@ziepe.ca>
References: <20250128172123.GD1524382@ziepe.ca>
	 <Z5ovcnX2zVoqdomA@phenom.ffwll.local> <20250129134757.GA2120662@ziepe.ca>
	 <Z5tZc0OQukfZEr3H@phenom.ffwll.local> <20250130132317.GG2120662@ziepe.ca>
	 <Z5ukSNjvmQcXsZTm@phenom.ffwll.local> <20250130174217.GA2296753@ziepe.ca>
	 <Z50BbuUQWIaDPRzK@phenom.ffwll.local> <20250203150805.GC2296753@ziepe.ca>
	 <7b7a15fb1f59acc60393eb01cefddf4dc1f32c00.camel@linux.intel.com>
	 <20250204132615.GI2296753@ziepe.ca>
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

On Tue, 2025-02-04 at 09:26 -0400, Jason Gunthorpe wrote:
> On Tue, Feb 04, 2025 at 10:32:32AM +0100, Thomas Hellstr=C3=B6m wrote:
> >=20
>=20
> > 1) Existing users would never use the callback. They can still rely
> > on
> > the owner check, only if that fails we check for callback
> > existence.
> > 2) By simply caching the result from the last checked dev_pagemap,
> > most
> > callback calls could typically be eliminated.
>=20
> But then you are not in the locked region so your cache is racy and
> invalid.

I'm not sure I follow? If a device private pfn handed back to the
caller is dependent on dev_pagemap A having a fast interconnect to the
client, then subsequent pfns in the same hmm_range_fault() call must be
able to make the same assumption (pagemap A having a fast
interconnect), else the whole result is invalid?

>=20
> > 3) As mentioned before, a callback call would typically always be
> > followed by either migration to ram or a page-table update.
> > Compared to
> > these, the callback overhead would IMO be unnoticeable.
>=20
> Why? Surely the normal case should be a callback saying the memory
> can
> be accessed?

Sure, but at least on the xe driver, that means page-table repopulation
since the hmm_range_fault() typically originated from a page-fault.


>=20
> > 4) pcie_p2p is already planning a dev_pagemap callback?
>=20
> Yes, but it is not a racy validation callback, and it already is
> creating a complicated lifecycle problem inside the exporting the
> driver.

Yeah, I bet there are various reasons against a callback. I just don't
see the performance argument being a main concern.=20

>=20
> Jason

/Thomas



