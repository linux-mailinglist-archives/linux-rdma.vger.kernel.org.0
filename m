Return-Path: <linux-rdma+bounces-7412-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019DDA283DF
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 06:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B3863A1A98
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 05:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829B221D5A8;
	Wed,  5 Feb 2025 05:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RXWby6lE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7105217BEBF;
	Wed,  5 Feb 2025 05:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738734596; cv=none; b=Fcp9Ju7FkJfoBxzz6Voo6JGPBXEIefNtWdkxoZgXRIHn0fq46eAtv8oyUvv6skTwTK/WmbtVvx+NbR9Kz9jOGa6GEoGbFT2sk92mfZF2hxVyd75nohuEGmfXTMHAmGidwO7pnrBfoIwHbzDDpeoz1laqAI0XlgEDVOpOl5S2kQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738734596; c=relaxed/simple;
	bh=6FCcamG8Wjf7SqTLaIpI+rsdYWLuV9WO2iqz6eaYxWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAMb2bOiVJq89Gn0k5CdJYtXxeiR5XvTXXrgU26tN/tYKBduYbtKmtRUCKdbcuhqQG6XJfXt63GFZJjlTjURYCMNjwTfVW9cHDZaYtBLAMM54jG2+S4zT/9waThxYVtuqXWCP0r4ZPgDo88bFCMGk5acP29QmuEX2SttTiCF3Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RXWby6lE; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738734594; x=1770270594;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6FCcamG8Wjf7SqTLaIpI+rsdYWLuV9WO2iqz6eaYxWU=;
  b=RXWby6lE4YhllZ97U1TywjgyJqhnLFhQIK5ji9qQ1EUh0Gtj5aCRCc5i
   8HJ05UGkFP0TDJoWTV7mUb5/hP7TjBQK2Eipxbct4NZvWkJONH0QYWgFn
   T+acfiM0uy2XGpGDzGIYGyvjIjVsXKqtkbOpaT0zWq2gWYvzM8DDh/rko
   +C5zYkC70VTbi/U+apt/as47/noNnazzOzHlEFY7kQQ5gNXHOYOZYN+4K
   TkAMzUbSZ5hShv+rh5Y6rrjNrrmGrd27Fml36LPt+Zr9jqP83kvAeJqor
   mFpfsbj0qIJtYFhVA0T+LoVzjQ1VGpVU1+OnIWmbTnYtqZrPV69lSaetn
   g==;
X-CSE-ConnectionGUID: ZGb3qUbaSnWrP9pVh0SSLA==
X-CSE-MsgGUID: sh3fVD9BTn+TIRJ6N+sRHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="56820493"
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="56820493"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 21:49:53 -0800
X-CSE-ConnectionGUID: bBXfaBWeQiCEHPA9ZVbhvQ==
X-CSE-MsgGUID: HmPN/8lsR1mzy5H6LE9Vgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="110786395"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 21:49:48 -0800
Date: Wed, 5 Feb 2025 06:46:20 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch,
	netdev@vger.kernel.org, sridhar.samudrala@intel.com,
	jacob.e.keller@intel.com, pio.raczynski@gmail.com,
	konrad.knitter@intel.com, marcin.szycik@intel.com,
	nex.sw.ncis.nat.hpm.dev@intel.com, przemyslaw.kitszel@intel.com,
	jiri@resnulli.us, horms@kernel.org, David.Laight@aculab.com,
	pmenzel@molgen.mpg.de, mschmidt@redhat.com,
	tatyana.e.nikolova@intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 0/9][pull request] ice: managing MSI-X in driver
Message-ID: <Z6L7LPIxHXPz2/ih@mev-dev.igk.intel.com>
References: <20250203210940.328608-1-anthony.l.nguyen@intel.com>
 <20250204144252.686a466e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204144252.686a466e@kernel.org>

On Tue, Feb 04, 2025 at 02:42:52PM -0800, Jakub Kicinski wrote:
> On Mon,  3 Feb 2025 13:09:29 -0800 Tony Nguyen wrote:
> > Now changing queues using ethtool is also changing MSI-X. If there is
> > enough MSI-X it is always one to one. When there is not enough there
> > will be more queues than MSI-X. There is a lack of ability to set how
> > many queues should be used per MSI-X. Maybe we should introduce another
> > ethtool param for it? Sth like queues_per_vector?
> 
> It's probably okay for today. AFAIU ethtool channels basically
> correspond to IRQs. As the queue API matures we'll have
> the ability to allocate more queues for "channel" == IRQ / event
> queue.
> 

Ok, thanks for explanation.

> > The following are changes since commit c2933b2befe25309f4c5cfbea0ca80909735fd76:
> >   Merge tag 'net-6.14-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> > and are available in the git repository at:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE
> 
> Tony, the patches in your tree are missing your SoB, and I suspect 
> you may need the same PR to get pulled into RDMA, so I'm not applying
> from the list... Please respin.
> -- 
> pw-bot: cr

