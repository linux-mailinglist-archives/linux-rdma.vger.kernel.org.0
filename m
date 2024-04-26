Return-Path: <linux-rdma+bounces-2108-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDEF8B3D34
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 18:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5869B23FD4
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 16:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EE216F907;
	Fri, 26 Apr 2024 16:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M48z22oo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2CD16F8FB;
	Fri, 26 Apr 2024 16:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714150250; cv=none; b=TQoFtzVUwQSKtAoUNsRY4M+7TpVZZJantfGZV0F11WFTWNFMH/4MPQzlUEd4gAyDeu6v+f/NuPyPhPB45U/73I8/8eblScZHgYIAehsGGWpWy/nepEKpGfu6DGArw2yCKb37nqdMd5/RHN3yHcGb8pxqNloSKHRVicNCPzr1P4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714150250; c=relaxed/simple;
	bh=9RDrXvSasKycJHJViFt5YDDzkM2h9dWKKRAgXSN7z9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFump++/h3eio930wXhyffyX0w/8U3go4VO2IBB1OvL+8x7vg1RnMtujTpzyhzAuFSskBHimA1ZrU3U1MIeUXueJYmyyo/ML89VkEQ8YVIDk8ZQxwW6kX+fcCxjrS6x0uRz//mDMIAvjIrnAzuLOqoqpFwrfXyRr1g2QlLtzvWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M48z22oo; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714150249; x=1745686249;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9RDrXvSasKycJHJViFt5YDDzkM2h9dWKKRAgXSN7z9M=;
  b=M48z22ooxlYkByJuWYpFeKUeXsCqijuzu0ob1taH0jlVkLQ+LdvPlSyT
   rkRp/9krfQlKibngiX5HGUNh7pHPXdkigb4Lyiexxiy093R6AiuF/8ZP0
   veOv8zr7eccSMExwGOS1Ukjvv59LHBOO4wMik1TojtPsIc8ILLc+DIi99
   f0C1uwvdH6qRl48Gru4ra1h5PYwGwBTXFc/n9HMVWYx3qiTjx0uKpl+BA
   C1pY7X+2oaOnEzKAg/3AYJWmD51SEl0FBX9HtWz3WyFowmXh0LgxXHB3t
   vCDPM0kgON36xtGLyhYBoNuzkxMkYNuyoy9VGhDmksiKaJf2nbcSun1bj
   Q==;
X-CSE-ConnectionGUID: TzJcEIfyQ5SR/T1OSe9dVQ==
X-CSE-MsgGUID: 0WLnfdC+TWWKNbrBPYIkrg==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="9743203"
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="9743203"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 09:50:46 -0700
X-CSE-ConnectionGUID: zr6cUZq5RnSnQqO2KOTbDQ==
X-CSE-MsgGUID: mzXkwXr+QEu+hKDBQVF2zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="62952547"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 09:50:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s0OmX-00000001OZT-3a7a;
	Fri, 26 Apr 2024 19:50:41 +0300
Date: Fri, 26 Apr 2024 19:50:41 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Long Li <longli@microsoft.com>,
	Ajay Sharma <sharmaajay@microsoft.com>
Subject: Re: [PATCH v1 1/1] RDMA/mana_ib: Fix compilation error
Message-ID: <ZivbYdt2HxDpMxC5@smile.fi.intel.com>
References: <20240423204258.3669706-1-andriy.shevchenko@linux.intel.com>
 <20240426163719.GA334984@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426163719.GA334984@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 26, 2024 at 01:37:19PM -0300, Jason Gunthorpe wrote:
> On Tue, Apr 23, 2024 at 11:42:58PM +0300, Andy Shevchenko wrote:
> > The compilation with CONFIG_WERROR=y is broken:
> > 
> > .../hw/mana/device.c:88:6: error: variable 'ret' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
> > 	if (!upper_ndev) {
> > 	    ^~~~~~~~~~~
> > 
> > Fix this by assigning the ret to -ENODEV in respective condition.
> > 
> > Fixes: 8b184e4f1c32 ("RDMA/mana_ib: Enable RoCE on port 1")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/infiniband/hw/mana/device.c | 1 +
> >  1 file changed, 1 insertion(+)
> 
> This was fixed in

Hmm... The below patch had been sent _after_ mine. What's wrong with mine patch?

> commit f88320b698ad099a2f742adfb9f87177bfffe0c5
> Author: Konstantin Taranov <kotaranov@microsoft.com>
> Date:   Tue Apr 23 07:15:51 2024 -0700
> 
>     RDMA/mana_ib: Fix missing ret value

-- 
With Best Regards,
Andy Shevchenko



