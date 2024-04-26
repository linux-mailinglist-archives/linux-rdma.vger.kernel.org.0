Return-Path: <linux-rdma+bounces-2113-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B15A8B3D75
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 19:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD0B41C24560
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 17:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D03A15B0FB;
	Fri, 26 Apr 2024 17:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nicMT+aJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DD9159912;
	Fri, 26 Apr 2024 17:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714150850; cv=none; b=SPxPe/C2jKT0fo+cBxI9oSGoJXH8U+Q/Mrt7MO20x84OyDx2mVx49lkhEsqn9XIPtFBsep2q+IKqmnlVLRNd3Am6EsbXjtE7EtLbu3Zs3tp1Cbtw8d6UnRJ/UZvegq4Q27NbmmQkg31OWhw5gHyKFO3DSZkdiSYmgEP2uE56z68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714150850; c=relaxed/simple;
	bh=tAzT0APZ1gO3qIoBSFeSsXtVfHovkqASueptZpGwCMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKNx1yLi/sXbxZPzviONKJlBKj2QA9RHaR5Vt9n8GX9C6MoWwdPqv0ai8OO3ZWu5IFDxhsKqpfREf+ly+IgKtwLQBD+gCWt/BEGMbxdtkZy4yVfkw5gt+XAtmsSTkZl8hfdl1pCEnm2mCO4QNHkp3pVK/wdgYf4NJXiC8C17jbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nicMT+aJ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714150850; x=1745686850;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tAzT0APZ1gO3qIoBSFeSsXtVfHovkqASueptZpGwCMs=;
  b=nicMT+aJTRZM9BGEIiGx6PdiXawSWUjQ7Dm1ex8EArEWL45WTR+xiZ3e
   ir2HNNp3QS8/D1CzeHW1rc56l1LIS6ySPpNtie1e3RTP1l7v/uX5OUgTe
   RtQttfbb4kYKqjTCAFWP7vWay7BsbPZP4c2mLlPbjGVxbl9ABNQPevSyz
   R40bCIwtZuDmJzPD8jf0LAW8G0MOlftiTlUR8FA1PtgDoVbqPgwpjNFet
   yuri6vL0+GOfEc7QsPKASB+dN/KfrGqsJtkWbl2l9JzCtdJzMcAaNieFC
   86j+RX64NyFLKp3wHCFJhS+C3WcAMq731e+5wLp7BOXIhAvs+lsJ6JsFb
   w==;
X-CSE-ConnectionGUID: 9C32My+PRG6u1/1VoIxmBg==
X-CSE-MsgGUID: 4aOMSoDPRwm0CqllrIh8sw==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="10056659"
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="10056659"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 10:00:48 -0700
X-CSE-ConnectionGUID: Nx/4jGLtSSa0MLZrtjk5lg==
X-CSE-MsgGUID: XxN58ixGR6WpwMcoOG6Opw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="30286732"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 10:00:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1s0OwF-00000001Osy-05jM;
	Fri, 26 Apr 2024 20:00:43 +0300
Date: Fri, 26 Apr 2024 20:00:42 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Konstantin Taranov <kotaranov@linux.microsoft.com>,
	kotaranov@microsoft.com, sharmaajay@microsoft.com,
	longli@microsoft.com, leon@kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: fix missing ret value
Message-ID: <ZivduvnNzGnoAXAs@smile.fi.intel.com>
References: <1713881751-21621-1-git-send-email-kotaranov@linux.microsoft.com>
 <20240423150315.GA891022@nvidia.com>
 <Zivb7qs4gSywzVsL@smile.fi.intel.com>
 <20240426165815.GA2876951@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426165815.GA2876951@dev-arch.thelio-3990X>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 26, 2024 at 09:58:15AM -0700, Nathan Chancellor wrote:
> On Fri, Apr 26, 2024 at 07:53:02PM +0300, Andy Shevchenko wrote:
> > On Tue, Apr 23, 2024 at 12:03:15PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Apr 23, 2024 at 07:15:51AM -0700, Konstantin Taranov wrote:
> > > > From: Konstantin Taranov <kotaranov@microsoft.com>
> > > > 
> > > > Set ret to -ENODEV when netdev_master_upper_dev_get_rcu
> > > > returns NULL.
> > > > 
> > > > Fixes: 8b184e4f1c32 ("RDMA/mana_ib: Enable RoCE on port 1")
> > > > Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> > > > ---
> > > >  drivers/infiniband/hw/mana/device.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > 
> > > Applied to for-next, thanks
> > 
> > So, what's wrong with my patch that had been sent _before_ this one?
> 
> Was it?
> 
> This patch:
> 
>   $ date -d 'Tue, 23 Apr 2024 07:15:51 -0700' -u
>   Tue Apr 23 02:15:51 PM UTC 2024
> 
> Your patch: https://lore.kernel.org/20240423204258.3669706-1-andriy.shevchenko@linux.intel.com/
> 
>   $ date -d 'Tue, 23 Apr 2024 23:42:58 +0300' -u
>   Tue Apr 23 08:42:58 PM UTC 2024
> 
> Seems like this one beat yours by six hours?

Repeating myself from another thread:

"""
Oh, my... Sorry, I missed PM, it was mine sent after that one!
I guess time for weekend.
"""

Sorry for the noise and have a nice weekend!

-- 
With Best Regards,
Andy Shevchenko



