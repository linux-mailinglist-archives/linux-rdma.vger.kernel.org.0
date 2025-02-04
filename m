Return-Path: <linux-rdma+bounces-7406-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC80A27DFA
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 23:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF13C18874E7
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 22:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147E721B199;
	Tue,  4 Feb 2025 22:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SdO8o5t8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8A621A449;
	Tue,  4 Feb 2025 22:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738706518; cv=none; b=LVstRVTUIfYPbVeS91BSw9ypJhGJafZQPzEymDyT9KaXeNLlG66NL6t3XAwAdkB3lD9b8d28rixZz5yFgtzZLYMBF13PW56VViJq6SU9t3x6eWckMoBb42IuBQhYN3Wy2m33MXMSArey+/NCYFrvbzHgFrRZaQ987SBwLAc94fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738706518; c=relaxed/simple;
	bh=lbPHclbARFkQmvsu0zJqrdw8H+4xG9Vq8ZiG/BDW7Jo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c2EcO/yKPn1u8zy4BaPeGI6CBXmKlDn4N/+yw+x60ymM2MHWDDtpuN1X7i6892W3AMc0A87UQDyxdqYSzNiXrmv7kdrs7eX/Tzp28ZJL7PdyoX+YLAGLS1dmXqL8eDYuv4235T/9k63k9rKOdPvgKgfJjWOFhEE6K0joJVME4Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SdO8o5t8; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738706517; x=1770242517;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=lbPHclbARFkQmvsu0zJqrdw8H+4xG9Vq8ZiG/BDW7Jo=;
  b=SdO8o5t8l25nWlUS7nRVK96gD06y5ImWdrlIRyj6biZZVYr2V8sVqGuL
   Tn9Iomr8JyF3p3eZimWCMD10jwov8R20ndKXh7cdvyAPG0SDufnBFZtcn
   Ycq8+jF2K8gWtTv8jK/wcxlRUEDsMdfaFNm0vROumUvkTWMaZzKAyua38
   B2MDNmE3eD+iip6J+dwF7xNsNOZ+QX21Qyhrs/MQoTo2vn8F3CRxP9RKl
   lhLjJETaIfqsBFbXhhesBfZwgBB8zWYrMoCeu8VOfT2qrfVYbASSyjlMj
   hsIrFiugFuMFTFoysx2bML+DtydZrQJem8CBYOH8Ly18Fax5pZ+Pn5+ka
   w==;
X-CSE-ConnectionGUID: etr2uh17TgG7yOsIH2xKXQ==
X-CSE-MsgGUID: ASXSxsQJR/a2AsWhJhjDLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39517117"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="39517117"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 14:01:55 -0800
X-CSE-ConnectionGUID: NAx9oX9yRyOex+aeBj7lDg==
X-CSE-MsgGUID: DNsEcHZsSNySIyoK+sYkqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="111263801"
Received: from lfiedoro-mobl.ger.corp.intel.com (HELO [10.245.246.144]) ([10.245.246.144])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 14:01:28 -0800
Message-ID: <60b7e29853cb33d45d10101e494c7ddbe6a5abd6.camel@linux.intel.com>
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
Date: Tue, 04 Feb 2025 23:01:25 +0100
In-Reply-To: <20250204191601.GK2296753@ziepe.ca>
References: <20250129134757.GA2120662@ziepe.ca>
	 <Z5tZc0OQukfZEr3H@phenom.ffwll.local> <20250130132317.GG2120662@ziepe.ca>
	 <Z5ukSNjvmQcXsZTm@phenom.ffwll.local> <20250130174217.GA2296753@ziepe.ca>
	 <Z50BbuUQWIaDPRzK@phenom.ffwll.local> <20250203150805.GC2296753@ziepe.ca>
	 <7b7a15fb1f59acc60393eb01cefddf4dc1f32c00.camel@linux.intel.com>
	 <20250204132615.GI2296753@ziepe.ca>
	 <3e96aef8009be69858a69d3e49a2bd7fc7d06f5f.camel@linux.intel.com>
	 <20250204191601.GK2296753@ziepe.ca>
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

On Tue, 2025-02-04 at 15:16 -0400, Jason Gunthorpe wrote:
> On Tue, Feb 04, 2025 at 03:29:48PM +0100, Thomas Hellstr=C3=B6m wrote:
> > On Tue, 2025-02-04 at 09:26 -0400, Jason Gunthorpe wrote:
> > > On Tue, Feb 04, 2025 at 10:32:32AM +0100, Thomas Hellstr=C3=B6m wrote=
:
> > > >=20
> > >=20
> > > > 1) Existing users would never use the callback. They can still
> > > > rely
> > > > on
> > > > the owner check, only if that fails we check for callback
> > > > existence.
> > > > 2) By simply caching the result from the last checked
> > > > dev_pagemap,
> > > > most
> > > > callback calls could typically be eliminated.
> > >=20
> > > But then you are not in the locked region so your cache is racy
> > > and
> > > invalid.
> >=20
> > I'm not sure I follow? If a device private pfn handed back to the
> > caller is dependent on dev_pagemap A having a fast interconnect to
> > the
> > client, then subsequent pfns in the same hmm_range_fault() call
> > must be
> > able to make the same assumption (pagemap A having a fast
> > interconnect), else the whole result is invalid?
>=20
> But what is the receiver going to do with this device private page?
> Relock it again and check again if it is actually OK? Yuk.

I'm still lost as to what would be the possible race-condition that
can't be handled in the usual way using mmu invalidations + notifier
seqno bump? Is it the fast interconnect being taken down?

/Thomas


>=20
> > > > 3) As mentioned before, a callback call would typically always
> > > > be
> > > > followed by either migration to ram or a page-table update.
> > > > Compared to
> > > > these, the callback overhead would IMO be unnoticeable.
> > >=20
> > > Why? Surely the normal case should be a callback saying the
> > > memory
> > > can
> > > be accessed?
> >=20
> > Sure, but at least on the xe driver, that means page-table
> > repopulation
> > since the hmm_range_fault() typically originated from a page-fault.
>=20
> Yes, I expect all hmm_range_fault()'s to be on page fault paths, and
> we'd like it to be as fast as we can in the CPU present case..
>=20
> Jason


