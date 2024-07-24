Return-Path: <linux-rdma+bounces-3948-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9E793B868
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2024 23:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B86D283862
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2024 21:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B2913B5B6;
	Wed, 24 Jul 2024 21:10:04 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C84513B2B0;
	Wed, 24 Jul 2024 21:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721855404; cv=none; b=G6GnGSoAiSJcZ0UBOHNGH5zTtIoB4zqmQyjC/rbn20WhZIfWxXArS3/L0cclvrQXLvvTrYFV143XMpHMlBcJuze+3bm4yDIqesNXL8wDIL3aYy384ZfhNbzkDluYICpzhei065txvTktmilrM+n71k33oYyJw5n6i+i7SLpPwKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721855404; c=relaxed/simple;
	bh=iecHcjgY45N2onErv+rBPVHXu+Da7UgJDK2xSAz9nR4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fnz39EvTtLZf+dCtCX9zrfcb6aABnouePxeMgGoXURqxT+Oj1l/r8ySwZovf69sNXg9IPZ/7s1JNyDftNHOdvAajiwIPr0iiURwRborcTMGP+lG64yhoDJtr8zu+/8IZtKw2GQhDcnIASynjK4zzb55RLpJzN2xguT1Lcwuks2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFB9C32781;
	Wed, 24 Jul 2024 21:10:02 +0000 (UTC)
Date: Wed, 24 Jul 2024 17:10:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Jiri Kosina
 <jikos@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 ksummit@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240724171021.05fbbadd@gandalf.local.home>
In-Reply-To: <a75782218f34ae3cff725cbcfb321527f6aa2e14.camel@HansenPartnership.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
	<nycvar.YFH.7.76.2407231320210.11380@cbobk.fhfr.pm>
	<1e82a5c97e915144e01dd65575929c15bc0db397.camel@HansenPartnership.com>
	<20240724200012.GA23293@pendragon.ideasonboard.com>
	<a75782218f34ae3cff725cbcfb321527f6aa2e14.camel@HansenPartnership.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jul 2024 16:37:21 -0400
James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> > The first point is that hardware gets more complicated over time, and
> > in some markets there's also an increase in the number of vendors and
> > devices. There's a perceived (whether true or not) danger that we
> > won't be able to keep up with just reverse engineering and a
> > development model relying on hobyists. Getting vendors involved is
> > important if we want to scale.  
> 
> Yes, but there are lots of not very useful complex devices being
> produced every day that fail to capture market share.  Not having
> reverse engineered drivers for them is no real loss.  If a device does
> gain market share, it gains a huge pool of users some of whom become
> interested in reverse engineering, so I think market forces actually
> work in our favour: we get reverse engineering mostly where the devices
> are actually interesting and capture market share.  It's self scaling.

I agree with this. If a small vendor with low market share has a
proprietary device where they could easily port to Linux via a pass
through, they may do that. But if they don't have that, and require
engineering resources to port to Linux, they will not bother. As they would
only care about the Windows market. So the device becomes useless for the
Linux system. There's not enough Linux users to make a small vendor care
about losing us. That just shrinks the number of devices that are available
to Linux.

My guess is that vendors want to write one piece of code. If it they only
need to modify a small portion to get it to another OS, they would do that.
But if it takes more effort than that, there's not enough cost incentive to
bother.

For devices with a larger market share, it would make it more worth their
while to open source their work, otherwise there's more incentive for us to
reverse engineer it anyway.

-- Steve

