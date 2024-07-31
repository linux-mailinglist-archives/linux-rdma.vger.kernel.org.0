Return-Path: <linux-rdma+bounces-4134-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B186942EE4
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2024 14:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 140C9284CFE
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2024 12:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02391AE85E;
	Wed, 31 Jul 2024 12:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="wjiFSQYp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6A21A4B42;
	Wed, 31 Jul 2024 12:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722429978; cv=none; b=nCHSrKetgxqctiPJipyQeFTT4N71Cz0U/R0a+QRWmlICn7PphquxNreu16kAf877wyfqLDYUYnTy/ssynobpfJQF2KCtXaeHbgWYdgjnwUFGyGu8URZ5yCJZKCh+L60rqj/5jPpNy88AuuM6U9xaRR8WLymk+eutFcSQRRBp8C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722429978; c=relaxed/simple;
	bh=HMGXPhfPgu/3KQGe1W+Os3i7lsRIRce2NeE4Om/FZdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5fH0JoDfioHlYEnvElabWKaMU/viQ4SkOAlzZdzxAk97sJ2bGd56YS7AK3Gd2xoDn7PNdJ4AUA46qgPDSzg74PeiWvgBIAmhz4ZswPZlv6evYHrfFAon/+xfqNGnIxhlyeJFhk5lv77uJtw1c+XdTWfEyIGysqYLaAIzUkKakQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=wjiFSQYp; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2CDE4268;
	Wed, 31 Jul 2024 14:45:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1722429927;
	bh=HMGXPhfPgu/3KQGe1W+Os3i7lsRIRce2NeE4Om/FZdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wjiFSQYpXCMjmFlEUmgQ3vjw7s55JqiXg5bYW6CVdMxqr5Fq4VvMl5ZCj7nmC/jIV
	 xuJYptfVj2wvMmrWkRfo7uP7PbVzSUmFOO6Ji+DvB979R2CJ88fnUbGjBOczRIBtPK
	 9ZcCNxR7jdkDhkwrGq5BrRAPd99XrbFM7KAjQwDo=
Date: Wed, 31 Jul 2024 15:45:54 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240731124554.GW8146@pendragon.ideasonboard.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <20240726142731.GG28621@pendragon.ideasonboard.com>
 <66a43c48cb6cc_200582942d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240728111826.GA30973@pendragon.ideasonboard.com>
 <2024072802-amendable-unwatched-e656@gregkh>
 <2b4f6ef3fc8e9babf3398ed4a301c2e4964b9e4a.camel@HansenPartnership.com>
 <2024072909-stopwatch-quartet-b65c@gregkh>
 <206bf94bb2eb7ca701ffff0d9d45e27a8b8caed3.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <206bf94bb2eb7ca701ffff0d9d45e27a8b8caed3.camel@HansenPartnership.com>

On Wed, Jul 31, 2024 at 08:33:36AM -0400, James Bottomley wrote:
> On Mon, 2024-07-29 at 08:10 +0200, Greg KH wrote:
> > On Sun, Jul 28, 2024 at 11:49:44AM -0400, James Bottomley wrote:
> > > On Sun, 2024-07-28 at 17:16 +0200, Greg KH wrote:
> > > > On Sun, Jul 28, 2024 at 02:18:26PM +0300, Laurent Pinchart wrote:
> > > > > On Fri, Jul 26, 2024 at 05:16:08PM -0700, Dan Williams wrote:
> > > > > > Laurent Pinchart wrote:
> > > > > > > I know this is a topic proposed for the maintainers summit,
> > > > > > > but given the number of people who seem to have an opinion
> > > > > > > and be interested in dicussing it, would a session at LPC
> > > > > > > be a better candidate ? I don't expect the maintainer
> > > > > > > summit to invite all relevant experts from all subsystems,
> > > > > > > that would likely overflow the room.
> > > > > > > 
> > > > > > > The downside of an LPC session is that it could easily turn
> > > > > > > into a heated stage fight, and there are probably also
> > > > > > > quite a few arguments that can't really be made in the open
> > > > > > > :-S
> > > > > > 
> > > > > > A separate LPC session for a subsystem or set of subsystems
> > > > > > to explore local passthrough policy makes sense, but that is
> > > > > > not the primary motivation for also requesting a Maintainer
> > > > > > Summit topic slot. The primary motivation is discussing the
> > > > > > provenance and navigation of cross-subsystem NAKs especially
> > > > > > in an environment where the lines between net, mem, and
> > > > > > storage are increasingly blurry at the device level.
> > > > > 
> > > > > Would there be enough space at the maintainers' summit for all
> > > > > the relevant people to join the discussion ?
> > > > 
> > > > Who exactly would you consider the "relevant people" here?  It's
> > > > been a wide-ranging conversation/thread :)
> > > 
> > > This is a bit of a trick question, since there seem to be three
> > > separate but intertwined things here
> > > 
> > >    1. What to do about cross subsystem NAKs (as in how far does one
> > >       subsystem have the ability to NAK something another does because
> > >       they fear it will impact them ... passthrough being only one
> > >       example).
> > >    2. Industry education to help manufacturers making bad decisions
> > >       about openness and APIs make better ones that actually benefit
> > >       their business in the long run.
> > >    3. Standards for open drivers (i.e. is passthrough always evil).
> > > 
> > > 1. is definitely Maintainer Summit material.
> > 
> > And to ask again, who do you should participate in this?
> 
> Well it's a generic process issue, so the usual suspects at the
> Maintainer Summit will do, the question being how do we resolve
> disagreements between subsystems that think code in one impacts
> another. The answer could be what we already have: resolve it on a case
> by case basis, in which case see below, but it would be interesting to
> see if something better can come out.  If nothing does then no harm
> done and if something comes out no-one likes then the Maintainers won't
> follow it anyway.
> 
> For the specific issue of discussing fwctl, the Plumbers session would
> be better because it can likely gather all interested parties.
> 
> > > 2. was something the LF used to help us with but seems to have
> > > foundered of late (I think on the general assumption that CNCF gets
> > > it right, so we can stop pushing)
> > 
> > Based on the number of meetings and trips I keep having with
> > different companies over the past years, 2. is not something that the
> > LF is no longer doing, as they fund me doing this all the time. 
> > Including visiting and educating your current employer about these
> > very issues recently :)
> 
> I didn't say it was something you were no longer doing, I said it was
> something the LF is no longer helping us do.  You doing this is great,
> but you're just one person.  To scale this we need go to resources for
> helping the person dealing with it on the mailing list get up the
> management chain when these problems arise.  Plus probably a list of
> go-to resources who're used to explaining the business end of open
> source to corporate executives, just in case the person dealing with
> the patches doesn't have the time or doesn't want to.

Having spent the last 5 years having these kind of discussions with
camera vendors, I can tell it's a time consuming job. It's wearisome,
rewarding at times when your message gets through, and depressing when
you experience set backs. Not only could we do with more people and
resources to help with this work, but coordinating the efforts to ensure
vendors won't go back and forth due to contradicting messages would also
help.

-- 
Regards,

Laurent Pinchart

