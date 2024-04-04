Return-Path: <linux-rdma+bounces-1782-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8F6898C9D
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Apr 2024 18:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31E091F2985C
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Apr 2024 16:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60451F94D;
	Thu,  4 Apr 2024 16:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+mYQyYs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876FE1C6A4
	for <linux-rdma@vger.kernel.org>; Thu,  4 Apr 2024 16:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712249468; cv=none; b=tDzRT2aNfTmUHnIjzEIzzkrfqMPdxgAEoQDv9rZxID7KF4M9NZXY99QES3avoPwJcI43Bdbqh/fL1Yy8XJGvzvVch9oVFE9CnK6u7CjH2rqkMaD4J6Bt5TuU2QyVOyYeOP7tagVcbR0vuZJ/TxoQC0R7t+gzTL2YMHzFRSbCaYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712249468; c=relaxed/simple;
	bh=fcdFxfXPzU4ROOGBojkSXroqFmMWeOndFj2lfGPRChw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLntf1YSTRxMPT55rDxDkSNfEKZy5w7Duw/7Lk8qxxmCjLM34Mko+kE3/CbQIpnZnjY+uOGbjEUKvqmxan9U0VJJ2gTsLxBXFoWjW1mEOhPBHXx8Zw0ignehr7gFfibcqsXSlHCpWiW/y6e6Ky4U5MB6RUFGn+VzPs060OQBywQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+mYQyYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1912C433F1;
	Thu,  4 Apr 2024 16:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712249468;
	bh=fcdFxfXPzU4ROOGBojkSXroqFmMWeOndFj2lfGPRChw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D+mYQyYsLSgbFpE3Go8oEtyQwZvPA978nEozTUW2Pv0mMbPzgIoybJME+nQYh9AEI
	 DZzRBce9B/MMxfFH/FKQlVeqvIsLuVniOPfCrxs2KMsKBdvGf5MHJH2L9rfTKzLWPC
	 B7nmmGOzllTfUcaZZydsSNeHMjnvdlRkttFl/Ynd8wx9/LIo+9lqkq5L9OFeCyqRm+
	 bSsxeuepaM4jvGrymyR9dTg9Xu6oneSm+dfhRTt0mZGxskZW5Kvkq16AdGYgujw4AG
	 1TGy34XdgkxkoYCdCapkEI+aQ9a7qoTQdwdYrTeTNcIrOMjtVyFnezt5aPezJBp3+/
	 VFUG0ymzoeFyg==
Date: Thu, 4 Apr 2024 19:51:03 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Michael Guralnik <michaelgur@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] IB/core: Add option to limit user mad receive
 list
Message-ID: <20240404165103.GW11187@unreal>
References: <70029b5f256fbad6efbb98458deb9c46baa2c4b3.1712051390.git.leon@kernel.org>
 <20240404140113.GJ1723999@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404140113.GJ1723999@nvidia.com>

On Thu, Apr 04, 2024 at 11:01:13AM -0300, Jason Gunthorpe wrote:
> On Tue, Apr 02, 2024 at 12:50:21PM +0300, Leon Romanovsky wrote:
> > From: Michael Guralnik <michaelgur@nvidia.com>
> > 
> > ib_umad is keeping the received MAD packets in a list that is not
> > limited in size. As the extraction of packets from this list is done
> > from user-space application, there is no way to guarantee the extraction
> > rate to be faster than the rate of incoming packets. This can cause to
> > the list to grow uncontrollably.
> > 
> > As a solution, let's add new ysfs control knob for the users to limit
> > the number of received MAD packets in the list.
> > 
> > Packets received when the list is full would be dropped. Sent packets
> > that are queued on the receive list for whatever reason, like timed out
> > sends, are not dropped even when the list is full.
> > 
> > Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  .../ABI/stable/sysfs-class-infiniband         | 12 ++++
> >  drivers/infiniband/core/user_mad.c            | 63 ++++++++++++++++++-
> >  2 files changed, 72 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/ABI/stable/sysfs-class-infiniband b/Documentation/ABI/stable/sysfs-class-infiniband
> > index 694f23a03a28..0ea9d590ab0e 100644
> > --- a/Documentation/ABI/stable/sysfs-class-infiniband
> > +++ b/Documentation/ABI/stable/sysfs-class-infiniband
> > @@ -275,6 +275,18 @@ Description:
> >  		=============== ===========================================
> >  
> >  
> > +What:		/sys/class/infiniband_mad/umad<N>/max_recv_list_size
> > +Date:		January, 2024
> > +KernelVersion:	v6.9
> > +Contact:	linux-rdma@vger.kernel.org
> > +Description:
> > +		(RW) Limit the size of the list of MAD packets waiting to be
> > +		     read by the user-space agent.
> > +		     The default value is 0, which means unlimited list size.
> > +		     Packets received when the list is full will be silently
> > +		     dropped.
> 
> I'm really not keen on this as a tunable, when we get to future
> designs it may be hard to retain this specific behavior.
> 
> Why do we need a tunable? Can we just set it to something large and be
> done with it?

I don't know which value to set to be large enough from one side and
small enough to do not cause to OOM while host gets MAD packets.

Thanks

> 
> Jason
> 

