Return-Path: <linux-rdma+bounces-3944-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D75293B7BB
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2024 22:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C51C1C23F33
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2024 20:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623A615F41F;
	Wed, 24 Jul 2024 20:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="OrYYKkvD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B3DEED8;
	Wed, 24 Jul 2024 20:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721851235; cv=none; b=KLRG2VQucmI7dlzhMXfM6B6O+OBAY/fklDvRqyBRT7INUsUEGyea2jgM0Np/7oHQR3Q9iY7TdfY7hV2nMEewsQ/iXW+6e/eTO0twaJ5LYoGSMyBkVe/rYOpgAiEqcmUJH9s7BwlTq3sAwJBxNH33Vlf7kczwwcqBL+tkt5WuUsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721851235; c=relaxed/simple;
	bh=yqHeutwAuHZ84NcqwpxXXX61SqhtOingAlT+nU/ZtBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvLM5m5w85UvswSr8GF+cJmHBhfcgCB1apw1ekJMuq4tGur3F2Y+OAggS28/KHkQAormUw/BJa7V6CjvE3aPJlFCw9fqUk5fzdnKoguN8ifhpgYvb3guwh4br0fkemYme+uQQNdrsJmy+3Mlxq51/Lv+/rr63W9ccbXXLAdief4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=OrYYKkvD; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (85-76-97-131-nat.elisa-mobile.fi [85.76.97.131])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3D880566;
	Wed, 24 Jul 2024 21:59:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1721851188;
	bh=yqHeutwAuHZ84NcqwpxXXX61SqhtOingAlT+nU/ZtBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OrYYKkvDqEjm36nJehszCSZ+jU5ljXXz8DRZCc+HNQQLJ2B4tiGpGqgjTQ6mTOC/y
	 RqKaHsuWMfdyyNOpp2HdqQjFYU3Gtv6fGJ9HL03+K4PWNCbVSGQKgEqrRL+kfiRv56
	 mtU6w2rbyRcL9xIJ4bYFZC0ABndxwX1rSw0NhzHU=
Date: Wed, 24 Jul 2024 23:00:12 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Jiri Kosina <jikos@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	ksummit@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240724200012.GA23293@pendragon.ideasonboard.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <nycvar.YFH.7.76.2407231320210.11380@cbobk.fhfr.pm>
 <1e82a5c97e915144e01dd65575929c15bc0db397.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1e82a5c97e915144e01dd65575929c15bc0db397.camel@HansenPartnership.com>

On Tue, Jul 23, 2024 at 07:36:24AM -0400, James Bottomley wrote:
> On Tue, 2024-07-23 at 13:20 +0200, Jiri Kosina wrote:
> > On Mon, 8 Jul 2024, Dan Williams wrote:
> > 
> > > 2/ Device passthrough, kernel passing opaque payloads, is already
> > > taken for granted in many subsystems. USB and HID have "raw"
> > > interfaces
> > 
> > Just as a completely random datapoint here: after I implemented
> > hidraw inteface long time ago, I was a little bit hesitant about
> > really merging it, because there was a general fear that this would
> > shatter the HID driver ecosystem, making it difficult for people to
> > find proper drivers  for their devices, etc.
> 
> The problem with hidraw is that userspace has to understand the device
> to use it, but a lot of HID devices (keyboards, mice, serial ports,
> etc.) want to fit into an existing ecosystem so they have to have a
> kernel driver to avoid having to update all the user applications. 
> However, entirely new devices don't have the existing ecosystem
> problem.
> 
> > Turns out that that didn't happen. Drivers for generic devices are
> > still implemented properly in the kernel, and hidraw is mostly used
> > for rather specific, one-off solutions, where the vendor's business
> > plan is "ship this one appliance and forget forever", which doesn't
> > really cause any harm to the whole ecosystem.
> 
> That's not entirely true.  FIDO tokens (the ones Konstantin is
> recommending for kernel.org access) are an entire class of devices that
> use hidraw and don't have a kernel driver.  There's an array of
> manufacturers producing them, but the CTAP specification and its
> conformance is what keeps a single user mode driver (which is now
> present as a separate implementation in all web browsers and the
> userspace libfido2) for all of them.  Fido is definitely not a one off,
> but on the other hand, not having a kernel driver doesn't seem to harm
> the ecosystem and they can get away with it because there was no
> existing device type for them to fit into (except, as you say, an array
> of incompatible and short lived USB key tokens which annoyed everyone
> by having usability limits due to the oneoffness).

While "userspace drivers" often cause allergic reactions, I think I
won't cause a controversy if I say that we are all used to them in
certain areas. My heart rate will increase if someone proposes replacing
a USB webcam driver with a libusb-based solution, but I don't lose sleep
over the fact that my GPU is mostly controlled by code in Mesa.

What I get from the discussions I've followed or partcipated in over the
years is that the main worry of free software communities is being
forced to use closed-source userspace components, whether that would be
to make the device usable at all, or to achieve decent level of
performance or full feature set. We've been through years of mostly
closed-source GPU support, of printer "windrivers", and quite a few
other horrors. The good news is that we've so far overcome lots (most)
of those challenges. Reverse engineering projects paid off, and so did
working hand-in-hand with industry actors in multiple ways (both openly
and behind the scenes). One could then legitimately ask why we're still
scared.

I can't fully answer that question, but there are two points that I
think are relevant. Note that due to my background and experience, this
will be heavily biased towards consumer and embedded hardware, not data
centre-grade devices. Some technologies from the latter however have a
tendency to migrate to the former over time, so the distinction isn't
necessarily as relevant as one may consider.

The first point is that hardware gets more complicated over time, and in
some markets there's also an increase in the number of vendors and
devices. There's a perceived (whether true or not) danger that we won't
be able to keep up with just reverse engineering and a development model
relying on hobyists. Getting vendors involved is important if we want to
scale.

Second, I think there's a fear of regression. For some categories of
devices, we have made slow but real progress to try and convince the
industry to be more open. This sometimes took a decade of work,
patiently building bridges and creating ecosystems brick by brick. Some
of those ecosystems are sturdy, some not so. Giving pass-through a blank
check will likely have very different effects in different areas. I
don't personally believe it will shatter everything, but I'm convinced
it carries risk in areas where cooperation with vendors is in its
infancy or is fragile for any other reason.

Finally, let's not forget that pass-through APIs are not an all or
nothing option. To cite that example only, DRM requires GPU drivers to
have an open-source userspace implementation to merge the kernel driver,
and the same subsystems strongly pushes for API standardization for
display controllers. We can set different rules for different cases.

-- 
Regards,

Laurent Pinchart

