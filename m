Return-Path: <linux-rdma+bounces-3946-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E94BD93B81B
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2024 22:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B20F3B22505
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2024 20:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D85132492;
	Wed, 24 Jul 2024 20:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ZcNps47e";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ZcNps47e"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFB04AEF6;
	Wed, 24 Jul 2024 20:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721853445; cv=none; b=irk7nABfOSOuhn+Cj30wyZM9pG3UAPy1ANzN8+qYN4hEv9kvQQ9cl+DfhLwSSfFXdcCXedNa9ifuNXeHydfXCRkirkblRXCgImZU6bNXLpOEjqZiuFcQ54MVUpesa4Wnr2e0zVbAUtETXOXNHRCXEIWi/bX6wFwgYV2EU9TSiyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721853445; c=relaxed/simple;
	bh=lPZvqySYXn0Ih/XTQwAHKD1AQY0p+922RJESktRa07s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YbZ2U52erzHoyGlmD2Fp8Lbx3u+a9XXDhdmIiFb9q4NRpmgC4PiJcyIxQTiLDh3vIQT/uGNJhJxqM3nUV/6FixFkVXgpiwglgXvENYKVPsFLNuY+cJ33GnT9kz1VMxL3F7ka5Gkk03EK/zDdrRnD41DXjf/FskIQFODdYKOZfq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=ZcNps47e; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=ZcNps47e; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1721853443;
	bh=lPZvqySYXn0Ih/XTQwAHKD1AQY0p+922RJESktRa07s=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=ZcNps47eri30xAk1Tju9WWaFYf3akmDYtLb32+G5m/O4Lk3zpSUL0gbmCVR30VgdP
	 yuf5V7oV17But2SQmo+j69gHNcqTM4jJsnWTAdTZHNYgelQ5Q0bEqtlzCNYuTGb7HS
	 zNk+ZWw6URN4qIHekyPhmzpA3fFwZ7uw+uAsM29A=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 8CD2812868A3;
	Wed, 24 Jul 2024 16:37:23 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id ZP4tu15uyvwQ; Wed, 24 Jul 2024 16:37:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1721853443;
	bh=lPZvqySYXn0Ih/XTQwAHKD1AQY0p+922RJESktRa07s=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=ZcNps47eri30xAk1Tju9WWaFYf3akmDYtLb32+G5m/O4Lk3zpSUL0gbmCVR30VgdP
	 yuf5V7oV17But2SQmo+j69gHNcqTM4jJsnWTAdTZHNYgelQ5Q0bEqtlzCNYuTGb7HS
	 zNk+ZWw6URN4qIHekyPhmzpA3fFwZ7uw+uAsM29A=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::db7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B23201286899;
	Wed, 24 Jul 2024 16:37:22 -0400 (EDT)
Message-ID: <a75782218f34ae3cff725cbcfb321527f6aa2e14.camel@HansenPartnership.com>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Jiri Kosina <jikos@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
  ksummit@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-rdma@vger.kernel.org,  netdev@vger.kernel.org, jgg@nvidia.com
Date: Wed, 24 Jul 2024 16:37:21 -0400
In-Reply-To: <20240724200012.GA23293@pendragon.ideasonboard.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
	 <nycvar.YFH.7.76.2407231320210.11380@cbobk.fhfr.pm>
	 <1e82a5c97e915144e01dd65575929c15bc0db397.camel@HansenPartnership.com>
	 <20240724200012.GA23293@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2024-07-24 at 23:00 +0300, Laurent Pinchart wrote:
[...]
> What I get from the discussions I've followed or partcipated in over
> the years is that the main worry of free software communities is
> being forced to use closed-source userspace components, whether that
> would be to make the device usable at all, or to achieve decent level
> of performance or full feature set. We've been through years of
> mostly closed-source GPU support, of printer "windrivers", and quite
> a few other horrors. The good news is that we've so far overcome lots
> (most) of those challenges. Reverse engineering projects paid off,
> and so did working hand-in-hand with industry actors in multiple ways
> (both openly and behind the scenes). One could then legitimately ask
> why we're still scared.

I don't think I am.  We're mostly fully capable of expounding at length
on the business rationale for being open if the thing they're hiding
isn't much of a differentiator anyway (or they're simply hiding it to
try to retain some illusion of control), so we shouldn't have any fear
of being able to make our case in language business people understand.

I also think this fear is partly a mindset problem on our part.  We
came out of the real fight for openness and we do embrace things like a
licence that forces open code (GPL) and symbols that discourage
proprietary drivers (EXPORT_SYMBOL_GPL), so we've somewhat drunk the
FSF coolaid that if we don't stand over manufacturers every second and
force them they'll slide back to their old proprietary ways.  However,
if you look at the entirely permissive ecosystem that grew up after we
did (openstack, docker, kubernetes, etc.) they don't have any such fear
and yet they still have large amounts of uncompelled openness and give
back.

> I can't fully answer that question, but there are two points that I
> think are relevant. Note that due to my background and experience,
> this will be heavily biased towards consumer and embedded hardware,
> not data centre-grade devices. Some technologies from the latter
> however have a tendency to migrate to the former over time, so the
> distinction isn't necessarily as relevant as one may consider.
> 
> The first point is that hardware gets more complicated over time, and
> in some markets there's also an increase in the number of vendors and
> devices. There's a perceived (whether true or not) danger that we
> won't be able to keep up with just reverse engineering and a
> development model relying on hobyists. Getting vendors involved is
> important if we want to scale.

Yes, but there are lots of not very useful complex devices being
produced every day that fail to capture market share.  Not having
reverse engineered drivers for them is no real loss.  If a device does
gain market share, it gains a huge pool of users some of whom become
interested in reverse engineering, so I think market forces actually
work in our favour: we get reverse engineering mostly where the devices
are actually interesting and capture market share.  It's self scaling.

> Second, I think there's a fear of regression. For some categories of
> devices, we have made slow but real progress to try and convince the
> industry to be more open. This sometimes took a decade of work,
> patiently building bridges and creating ecosystems brick by brick.
> Some of those ecosystems are sturdy, some not so. Giving pass-through
> a blank check will likely have very different effects in different
> areas. I don't personally believe it will shatter everything, but I'm
> convinced it carries risk in areas where cooperation with vendors is
> in its infancy or is fragile for any other reason.

I also think we're on the rise in this space.  Since most cloud
workloads are on Linux, there's huge market pressure on most "found in
the cloud" devices (like accelerators and GPUs) to have an easy to
consume Linux story.  Nvidia is a case in point.  When it only cared
about fast games on some other OS, we get shafted with a proprietary
graphics drivers.  Now it's under pressure to be the number one AI
accelerator provider for the cloud it's suddenly wondering about open
source drivers to make adoption easier.

> Finally, let's not forget that pass-through APIs are not an all or
> nothing option. To cite that example only, DRM requires GPU drivers
> to have an open-source userspace implementation to merge the kernel
> driver, and the same subsystems strongly pushes for API
> standardization for display controllers. We can set different rules
> for different cases.

I certainly think we can afford to experiment here, yes.

James


