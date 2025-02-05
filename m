Return-Path: <linux-rdma+bounces-7418-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 877CFA28508
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 08:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CBDD7A3666
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 07:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B1B2288EC;
	Wed,  5 Feb 2025 07:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lDg08iKy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A146138F82;
	Wed,  5 Feb 2025 07:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738741448; cv=none; b=YRkq6FUAP+eO1QpBGPn0loLDeAdqdHMXM8+2SBboB7WzD3fJmHhWsR0DGFnGQ9+zX0GhpryFk8icSTZzRs54eY2u1Ox/k3wo9HKvovdhS1TIocygL4VF+8IM4CUG1u8FsXnfL9u8bNpEGjZm4b2/veeVqbsNB5aVomCUTxIkIl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738741448; c=relaxed/simple;
	bh=BpS67GaUajKjTHome07KNAXrLsWfOkTNDhao5HwLCWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dY5OONn5kCZEegwJOHGOXWoTDYR7r7VKKNQWGDdtfp7ot7FgKzQeBC6rOxJYxGXaAYJ6m+ZKcCcPyXj5M+hdmz/pPfyXxE0r1J7X6EWy2yb7ooXVTaYZgR6IeCGNrhSfXNKSItU+VqFiq16mkna+krUD2CsjZRyAeKPnx0msfLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lDg08iKy; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738741446; x=1770277446;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BpS67GaUajKjTHome07KNAXrLsWfOkTNDhao5HwLCWU=;
  b=lDg08iKys6ZLRZXzX6u8/8cKW51/BnCp9E0pdm3k0S/tpFxIYhrkYI2m
   sRdtq4awgeyrU5JoJF+3dJ2u4+0pNpfkatYvBU9humH7Yq0O0eip+A3Jt
   z/pSKAoksvp90niZn1q8KfTVz94Fiv3oaxiOLSdZzWkb73zSKuefLllcC
   tQSypg8JZJCE+/ErId9lut4tXa237R1gEc/YRX+mM6Gea+jfC3GJK4iV9
   0cGD38y28HGZQxxMliENkreAvPqECDyoIebv0Td4NbOACSw7jyzjD51B/
   zTWHagXmXeRSvEbn+c7SGx5b9fVTbmUwfRvG9MSLtz3T9nh0v2rkxATmL
   Q==;
X-CSE-ConnectionGUID: kX3WqZdfTAS7HxtUEygSFw==
X-CSE-MsgGUID: RZSCYPepT+GBYEy08wSBLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="26897131"
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="26897131"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 23:44:06 -0800
X-CSE-ConnectionGUID: uBtXFELbQ+aSQJdQFlcA9g==
X-CSE-MsgGUID: +zH4Yxk7QnmuVDaXzGls7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="110712993"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 23:44:01 -0800
Date: Wed, 5 Feb 2025 08:40:28 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	andrew+netdev@lunn.ch, netdev@vger.kernel.org,
	sridhar.samudrala@intel.com, jacob.e.keller@intel.com,
	pio.raczynski@gmail.com, konrad.knitter@intel.com,
	marcin.szycik@intel.com, nex.sw.ncis.nat.hpm.dev@intel.com,
	przemyslaw.kitszel@intel.com, jiri@resnulli.us, horms@kernel.org,
	David.Laight@aculab.com, pmenzel@molgen.mpg.de, mschmidt@redhat.com,
	tatyana.e.nikolova@intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	corbet@lwn.net, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next 2/9] ice: devlink PF MSI-X max and min parameter
Message-ID: <Z6MV7KY81S+/bGGY@mev-dev.igk.intel.com>
References: <20250203210940.328608-1-anthony.l.nguyen@intel.com>
 <20250203210940.328608-3-anthony.l.nguyen@intel.com>
 <20250203214808.129b75e5@pumpkin>
 <Z6GuSJCshbWlkiLu@mev-dev.igk.intel.com>
 <20250204184121.168eaba2@pumpkin>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204184121.168eaba2@pumpkin>

On Tue, Feb 04, 2025 at 06:41:21PM +0000, David Laight wrote:
> On Tue, 4 Feb 2025 07:06:00 +0100
> Michal Swiatkowski <michal.swiatkowski@linux.intel.com> wrote:
> 
> > On Mon, Feb 03, 2025 at 09:48:08PM +0000, David Laight wrote:
> > > On Mon,  3 Feb 2025 13:09:31 -0800
> > > Tony Nguyen <anthony.l.nguyen@intel.com> wrote:
> > >   
> > > > From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > > > 
> > > > Use generic devlink PF MSI-X parameter to allow user to change MSI-X
> > > > range.
> > > > 
> > > > Add notes about this parameters into ice devlink documentation.
> ....
> > > Don't those checks make it difficult to set the min and max together?
> > > I think you need to create the new min/max pair and check they are
> > > valid together.
> > > Which probably requires one parameter with two values.
> > >   
> > 
> > I wanted to reuse exsisting parameter. The other user of it is bnxt
> > driver. In it there is a separate check for min "max" and max "max".
> > It is also problematic, because min can be set to value greater than
> > max (here it can happen when setting together to specific values).
> > I can do a follow up to this series and change this parameter as you
> > suggested. What do you think?
> 
> Changing the way a parameter is used will break API compatibility.
> Perhaps you can get the generic parameter validation function to
> update a 'pending' copy, and then do the final min < max check after
> all the parameters have been processed before actually updating
> the live limits.
> 
> The other option is just not to check whether min < max and just
> document which takes precedence (and not use clamp()).
> 
> It may even be worth saving the 'live limits' as 'hi << 16 | lo' so
> that then can be accessed atomically (with READ/WRITE_ONCE) to avoid
> anything looking at the limits getting confused.
> (Although maybe that doesn't matter here?)
> 
> 	David

Right, I though it is better to have any additional validation for min >
max cases, but it looks like it is more problematic. I can drop it to
algin with the bnxt solution.

Thanks,
Michal

> 
> > 
> > Thanks,
> > Michal

