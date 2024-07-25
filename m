Return-Path: <linux-rdma+bounces-3990-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE5493C404
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 16:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AEB22821D3
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 14:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF71619D082;
	Thu, 25 Jul 2024 14:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="u/X0eQ1H";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="u/X0eQ1H"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27C619D069;
	Thu, 25 Jul 2024 14:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721917376; cv=none; b=hBLXufyiOf7sh9VRwf0wM55Z2M6ISRzyimNYDhkfdlBZjrptXVOO60+BeKKP9wauRTB8oHMM+lWDgQVS8eTcBR/hkA+YvR6mkvDFJ8wKOLunByqDUOcAxo1+gcNeX7uNpmtHAmP0LgSK4KfaxktvJ/n0aaers6cFTSxvK+Xv3Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721917376; c=relaxed/simple;
	bh=xUgO7Iu5hO0VH4UChsh+uJ17qK41c/Xo+v6jHAUVaE8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pVulmG6TerU+gYDJfWbEbsvFhroIA27IB7vTHwdNidiZf2xgIYc5LcuLX7OwdEV5ysWtHwctc1Nm4b0g5fV1dNxzCzdH8nlxZU1IqVd+LVDXgv2o+4RLF9U623FjhzOXC8kvA5HEY62RvFiZNXecACwlG6Iqe0/jKfuGIwQq67g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=u/X0eQ1H; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=u/X0eQ1H; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1721917372;
	bh=xUgO7Iu5hO0VH4UChsh+uJ17qK41c/Xo+v6jHAUVaE8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=u/X0eQ1Hmjnuwja7U2KchiDEKAPgBouF26V7cX1lnFCGLmYROECpvd+2KAScbFO5C
	 XxGAdcWEY0TFH7FXoFthT015FOVWuvSHhOhnvyEU7sSIQvLFTcK3mUdcSrrXE5E1HY
	 yuHyjuiUiYxHuWXT6ASktOCRlQ0hp7/mGJhArkmA=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 7C4591286D3E;
	Thu, 25 Jul 2024 10:22:52 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id aDPQOuPVEomv; Thu, 25 Jul 2024 10:22:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1721917372;
	bh=xUgO7Iu5hO0VH4UChsh+uJ17qK41c/Xo+v6jHAUVaE8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=u/X0eQ1Hmjnuwja7U2KchiDEKAPgBouF26V7cX1lnFCGLmYROECpvd+2KAScbFO5C
	 XxGAdcWEY0TFH7FXoFthT015FOVWuvSHhOhnvyEU7sSIQvLFTcK3mUdcSrrXE5E1HY
	 yuHyjuiUiYxHuWXT6ASktOCRlQ0hp7/mGJhArkmA=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::db7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 217F512867C0;
	Thu, 25 Jul 2024 10:22:51 -0400 (EDT)
Message-ID: <b30aa2afd015a4f957a6c0b2353ef7b99716d240.camel@HansenPartnership.com>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Leon Romanovsky <leon@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Jiri Kosina <jikos@kernel.org>, Dan
 Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
 linux-cxl@vger.kernel.org,  linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, jgg@nvidia.com
Date: Thu, 25 Jul 2024 10:22:48 -0400
In-Reply-To: <20240725141856.GG7022@unreal>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
	 <nycvar.YFH.7.76.2407231320210.11380@cbobk.fhfr.pm>
	 <1e82a5c97e915144e01dd65575929c15bc0db397.camel@HansenPartnership.com>
	 <20240724200012.GA23293@pendragon.ideasonboard.com>
	 <CAPybu_0SN7m=m=+z5hu_4M+STGh2t0J-hFEmtDTgx6fYWKzk3A@mail.gmail.com>
	 <20240725122315.GE7022@unreal>
	 <CAPybu_1XsNq=ExrO+8XLqnV_KvSaqooM=yNy5iuzcD=-k5CdGA@mail.gmail.com>
	 <20240725132035.GF7022@unreal>
	 <1d7a4437-d072-42c4-b5fe-21e097eb5b9c@sirena.org.uk>
	 <20240725141856.GG7022@unreal>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2024-07-25 at 17:18 +0300, Leon Romanovsky wrote:
> On Thu, Jul 25, 2024 at 02:29:36PM +0100, Mark Brown wrote:
> > On Thu, Jul 25, 2024 at 04:20:35PM +0300, Leon Romanovsky wrote:
> > > On Thu, Jul 25, 2024 at 03:02:13PM +0200, Ricardo Ribalda Delgado
> > > wrote:
> > 
> > > > As a user, and as an open source Distro developer I have a
> > > > small hint.  But you could also ask users what they think about
> > > > not being able to use their notebook's cameras. The last time
> > > > that I could not use some basic hardware from a notebook with
> > > > Linux was 20 years ago.
> > 
> > > Lucky you, I still have consumer hardware (speaker) that doesn't
> > > work with Linux, and even now, there is basic hardware in my
> > > current laptop (HP docking station) that doesn't work reliably in
> > > Linux.
> > 
> > FWIW for most audio issues (especially built in stuff) with laptops
> > if you report it upstream it'll generally be relatively easy to
> > quirk. Unfortunately it's idiomatic for ACPI systems to quirk off
> > DMI information for almost everything which means a constant stream
> > of per system quirks for subsystems like audio.
> 
> It is Jabra USB speaker. One day, I will have time to debug it :).

Those actually do work with Linux.  It's the speakers Plumbers has
provided to BoF/Hack sessions that needed remote attendees.  There was
a pulseaudio issue a while ago that any Mic/Speaker combination that
exported HFP instead of HSP didn't work, but that's fixed upstream (but
you might need to upgrade your pulseaudio).

James


