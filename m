Return-Path: <linux-rdma+bounces-3991-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A7393C7BA
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 19:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF9F3B219DF
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 17:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938BD19E7E2;
	Thu, 25 Jul 2024 17:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUdpgeVf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3560219D889;
	Thu, 25 Jul 2024 17:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721929074; cv=none; b=tqS4V8cZ0v6sivgkQmehCx5Z7DrcqaLOblGsAZ8snaebEtF3SHKML04XAXAJUQxOPfGL7qW6PRXnCyOE/6UEF/8Wp9T6Zwuhn33jcQROiDG+S/gpKfgJD3WaaYwkSo8gAUSrkVBJkfpXnG71U/N+Fz3HSsv7Ybl19qugiyYRMvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721929074; c=relaxed/simple;
	bh=kYShI7202uUqTsxcN5MLRjtETtPxifWaKs6rENWee6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6fU67Hc5KbWpvmCi9aw+Thsyb5blAS1+gJxm+HXfUMuGIx+ShTj0ieu86aCYyZJPBS18XjIR8fuTun89IRZdv2sQ8EcfuNNCPCNCZkBvu0pQzdWgh2oaY20ZI6MUmX2yWJ9UXk3ZQd6cApBT5gNlwJObGSQCM6NEGf80gqRn/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUdpgeVf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03AC5C116B1;
	Thu, 25 Jul 2024 17:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721929073;
	bh=kYShI7202uUqTsxcN5MLRjtETtPxifWaKs6rENWee6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OUdpgeVf4TqbnNYWNppOKDILDNSQAaEdVDXpl2EsTyNzhhGygo/kFj/d+wI+sscM0
	 USrlUhS2r1Z3JgL0W+t6bgswvscmjwi2r+WJGLVpHPhHOSqU8jVRv4d/hfXcB+49hv
	 VhsPsAVnDbAp5uNRKhMtFX11+udtP3xbLd1exGD3u58jg95lUExGERgvPLnVugRxF6
	 A86ORSKdm8/OeZl+s9lw6mTw+yLcw16vsYwhb8mSTcXkvxgUxTacl92hDF9sW4C4Sn
	 br+/bjXtGotEsrmnGZyKDRgMFYtANjuysqTBR/ot/hdxsMCI4Iti1pJAiQTZy49E7+
	 LGiAhS9mV5kHg==
Date: Thu, 25 Jul 2024 20:37:47 +0300
From: Leon Romanovsky <leon@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Mark Brown <broonie@kernel.org>,
	Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jiri Kosina <jikos@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240725173747.GH7022@unreal>
References: <nycvar.YFH.7.76.2407231320210.11380@cbobk.fhfr.pm>
 <1e82a5c97e915144e01dd65575929c15bc0db397.camel@HansenPartnership.com>
 <20240724200012.GA23293@pendragon.ideasonboard.com>
 <CAPybu_0SN7m=m=+z5hu_4M+STGh2t0J-hFEmtDTgx6fYWKzk3A@mail.gmail.com>
 <20240725122315.GE7022@unreal>
 <CAPybu_1XsNq=ExrO+8XLqnV_KvSaqooM=yNy5iuzcD=-k5CdGA@mail.gmail.com>
 <20240725132035.GF7022@unreal>
 <1d7a4437-d072-42c4-b5fe-21e097eb5b9c@sirena.org.uk>
 <20240725141856.GG7022@unreal>
 <b30aa2afd015a4f957a6c0b2353ef7b99716d240.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b30aa2afd015a4f957a6c0b2353ef7b99716d240.camel@HansenPartnership.com>

On Thu, Jul 25, 2024 at 10:22:48AM -0400, James Bottomley wrote:
> On Thu, 2024-07-25 at 17:18 +0300, Leon Romanovsky wrote:
> > On Thu, Jul 25, 2024 at 02:29:36PM +0100, Mark Brown wrote:
> > > On Thu, Jul 25, 2024 at 04:20:35PM +0300, Leon Romanovsky wrote:
> > > > On Thu, Jul 25, 2024 at 03:02:13PM +0200, Ricardo Ribalda Delgado
> > > > wrote:
> > > 
> > > > > As a user, and as an open source Distro developer I have a
> > > > > small hint.  But you could also ask users what they think about
> > > > > not being able to use their notebook's cameras. The last time
> > > > > that I could not use some basic hardware from a notebook with
> > > > > Linux was 20 years ago.
> > > 
> > > > Lucky you, I still have consumer hardware (speaker) that doesn't
> > > > work with Linux, and even now, there is basic hardware in my
> > > > current laptop (HP docking station) that doesn't work reliably in
> > > > Linux.
> > > 
> > > FWIW for most audio issues (especially built in stuff) with laptops
> > > if you report it upstream it'll generally be relatively easy to
> > > quirk. Unfortunately it's idiomatic for ACPI systems to quirk off
> > > DMI information for almost everything which means a constant stream
> > > of per system quirks for subsystems like audio.
> > 
> > It is Jabra USB speaker. One day, I will have time to debug it :).
> 
> Those actually do work with Linux.  It's the speakers Plumbers has
> provided to BoF/Hack sessions that needed remote attendees.  There was
> a pulseaudio issue a while ago that any Mic/Speaker combination that
> exported HFP instead of HSP didn't work, but that's fixed upstream (but
> you might need to upgrade your pulseaudio).

I don't want to hijack this thread, but I tried now my two Jabra
speakers (one is used and another is brand new which I got from IT)
and both don't work on my FC40 laptop.

Thanks

> 
> James
> 
> 

