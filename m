Return-Path: <linux-rdma+bounces-2109-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 228EE8B3D3B
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 18:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54EA41C22B1E
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 16:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF27156C6A;
	Fri, 26 Apr 2024 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E4EzyH2i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A4A1DFED;
	Fri, 26 Apr 2024 16:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714150389; cv=none; b=gxqUSc1w3Yvnr2XbGpMo226XUsovjKspbJ+RxBU0mlikvBNrnTW/Mg2YR87BKlzm9R+cHHrkSWvSis4gXesFLsh+DHKXoPKMHi6plGX2z+u398pJYlaXkWDEeEmJv+dBHrM/D3odfj86Mkdw+Vu1oX90enLZ0sEBz6VPIS6/OWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714150389; c=relaxed/simple;
	bh=veQ+dhE8G1BdzaaEA/HYxIrWBiGfNwdrNrQ2IFkCquU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9nTfXTwxtaRXWsT6wLzR0d7RkqDFrdBTgF46FpzCnzxx+s9JGzhqxWewLvuxK9KIXmNgQ93T/6S8jD649fmT1n2A0YXQNcNZB0qJMnRtPy7l9iY3GlkodXKhiKj12FTJMPxudkbWW8gg0zFjdA/txqRKwk3uRdqrsjGNm3wbzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E4EzyH2i; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714150388; x=1745686388;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=veQ+dhE8G1BdzaaEA/HYxIrWBiGfNwdrNrQ2IFkCquU=;
  b=E4EzyH2ih2HB/eS20c6OlyVcevLq/687EBKvNpZeMCQLdqc9W+6AwyWP
   cUdmQTjPiwKlwFeh9kS+FwswHFR0vwJIb0nyWBF27g/gfW6SRpgtjpalD
   K7y3c+/QKGdZEjtOu2TGMjrYlP8i5g8ZYYGtRG1bD3B7YnKrOcpNTKlnk
   WqfwQ4Mi69sE9d6AWl1l1ro1wyfNRkY+RPugaHB7GU2vjryvpP2/AhLox
   ChDlXNVINvH5IajrS8lUznx4Fw65c5WJiF1rQR5K1x8KdcH+CF+Om6Y+l
   FLr4dGpUvZgTvFguxOtpni1upnAoiaqse+W/u7hsw0hsVMTxNM37KMQ1m
   Q==;
X-CSE-ConnectionGUID: +BmqvzZaRB+gSkPFih7EWw==
X-CSE-MsgGUID: g48AtrXJS32wmkGcAPTw+A==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="10055857"
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="10055857"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 09:53:08 -0700
X-CSE-ConnectionGUID: 153tFidVRoqD87XFi/qplw==
X-CSE-MsgGUID: /LXoW1lLRhiDGJLBRfHgjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="30283579"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 09:53:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1s0Ooo-00000001Odb-2I7z;
	Fri, 26 Apr 2024 19:53:02 +0300
Date: Fri, 26 Apr 2024 19:53:02 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Konstantin Taranov <kotaranov@linux.microsoft.com>, nathan@kernel.org,
	kotaranov@microsoft.com, sharmaajay@microsoft.com,
	longli@microsoft.com, leon@kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: fix missing ret value
Message-ID: <Zivb7qs4gSywzVsL@smile.fi.intel.com>
References: <1713881751-21621-1-git-send-email-kotaranov@linux.microsoft.com>
 <20240423150315.GA891022@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423150315.GA891022@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 23, 2024 at 12:03:15PM -0300, Jason Gunthorpe wrote:
> On Tue, Apr 23, 2024 at 07:15:51AM -0700, Konstantin Taranov wrote:
> > From: Konstantin Taranov <kotaranov@microsoft.com>
> > 
> > Set ret to -ENODEV when netdev_master_upper_dev_get_rcu
> > returns NULL.
> > 
> > Fixes: 8b184e4f1c32 ("RDMA/mana_ib: Enable RoCE on port 1")
> > Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> > ---
> >  drivers/infiniband/hw/mana/device.c | 1 +
> >  1 file changed, 1 insertion(+)
> 
> Applied to for-next, thanks

So, what's wrong with my patch that had been sent _before_ this one?
At bare minimum I would like to see an explanation.

-- 
With Best Regards,
Andy Shevchenko



