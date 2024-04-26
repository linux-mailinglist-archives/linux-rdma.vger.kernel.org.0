Return-Path: <linux-rdma+bounces-2110-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123358B3D47
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 18:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C068C28913A
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 16:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21E9157492;
	Fri, 26 Apr 2024 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mY6BCuIo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3169E2B9DB;
	Fri, 26 Apr 2024 16:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714150570; cv=none; b=hp/JhL+VSSMvnW+x6SALxa5bUO2T3md+asV6bFExFf/KvZ+QQCdp0fH3Td50RnapsZ5xeMaXV4EnL7yPggM+ZecgKUEa8Fbq6yI+uNv6dCan2kzwV6kOpT4gKKNHoCYVHD3IgEdyhh6dXgRd+pcEjQMp7eWaRXJOcNp+TpSHE+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714150570; c=relaxed/simple;
	bh=fI4cB/S+NtwgpOy3l6L+Ecgwll4Y2dQBqzwftAOhHZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PtMp9hbV2jd2pRLyZJnhcRQNc/zxUYfJvGjL6dK3e4uj4/+DkWPPQtbzkE1Wjk2utOGV+d+3AQsxTCR6PlqK+3XHPA+2vX23Vs49e67wrnFj0RuYPWDemHEslzViBh5A4lwIE4tG+wClS0Y5sEDXYIHwMN8wZ3wDZ72eaFM5OwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mY6BCuIo; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714150569; x=1745686569;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fI4cB/S+NtwgpOy3l6L+Ecgwll4Y2dQBqzwftAOhHZc=;
  b=mY6BCuIoSSpJ6J9UHwE5FvIZFQq55cB8zdh5/K8E3lduQxqZaGbnm1/t
   LBeRdX5O9oYWrHIHyRbPR8HJNv6I9p5ORqs2sU9TZ8pPF0gDM5aHSodzg
   92lHWBcVgiouvdKvaEhHP16Ph5VwOzJIw7nSo4RbMAL6yuHzPpk0uVvk3
   WQeenhFvegH2gFBLWBaOdFRc+j/mtyZYCYsvdxStV8q+xn86sjgf/fgA4
   pDcjvQLHs9sxtEHaNZxjGI6+lY8m/ubWnhceJYQ2OMsof7z3Yj7Tiy72w
   EjDgeo09DqmRQih9td7nqtfHHvrjkh3kOvBKqsxC7WrJIrr8fTMiHMBw2
   Q==;
X-CSE-ConnectionGUID: ZOnLBFr2R9+9caFRESlEOQ==
X-CSE-MsgGUID: yC5AK/eXRUqZ6wxBJ2hiiw==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="9770181"
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="9770181"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 09:56:09 -0700
X-CSE-ConnectionGUID: fJOhKm6LRDuwqXGOF8aIAw==
X-CSE-MsgGUID: fyD+yvKDShm/GyVoALzuCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="25434053"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 09:56:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s0Ork-00000001Ohd-00Zn;
	Fri, 26 Apr 2024 19:56:04 +0300
Date: Fri, 26 Apr 2024 19:56:03 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Long Li <longli@microsoft.com>,
	Ajay Sharma <sharmaajay@microsoft.com>
Subject: Re: [PATCH v1 1/1] RDMA/mana_ib: Fix compilation error
Message-ID: <Zivco2ZLXHKXSWwU@smile.fi.intel.com>
References: <20240423204258.3669706-1-andriy.shevchenko@linux.intel.com>
 <20240426163719.GA334984@nvidia.com>
 <ZivbYdt2HxDpMxC5@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZivbYdt2HxDpMxC5@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 26, 2024 at 07:50:41PM +0300, Andy Shevchenko wrote:
> On Fri, Apr 26, 2024 at 01:37:19PM -0300, Jason Gunthorpe wrote:
> > On Tue, Apr 23, 2024 at 11:42:58PM +0300, Andy Shevchenko wrote:
> > > The compilation with CONFIG_WERROR=y is broken:
> > > 
> > > .../hw/mana/device.c:88:6: error: variable 'ret' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
> > > 	if (!upper_ndev) {
> > > 	    ^~~~~~~~~~~
> > > 
> > > Fix this by assigning the ret to -ENODEV in respective condition.
> > > 
> > > Fixes: 8b184e4f1c32 ("RDMA/mana_ib: Enable RoCE on port 1")
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > >  drivers/infiniband/hw/mana/device.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > 
> > This was fixed in
> 
> Hmm... The below patch had been sent _after_ mine. What's wrong with mine patch?

Oh, my... Sorry, I missed PM, it was mine sent after that one!
I guess time for weekend.

-- 
With Best Regards,
Andy Shevchenko



