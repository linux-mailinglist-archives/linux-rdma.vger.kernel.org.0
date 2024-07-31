Return-Path: <linux-rdma+bounces-4133-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06662942E7C
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2024 14:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A58A528B882
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2024 12:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF5D1AE868;
	Wed, 31 Jul 2024 12:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="opOe/IP0";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="opOe/IP0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1BB1A7F73;
	Wed, 31 Jul 2024 12:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722429221; cv=none; b=H3AGediuCRReelljFEROTeyK4s5633COF4v7R1i2Ayp4LGewQcgpXb5tQ9dGF3emnUg3Q/PWD2665Aoav/L6ZEWYZBLecfC1f+WDCEivmXoG58eZgtsEikUz4uFDm2gwEjFw4308vJ8LKxBw685xFPOMXUDhsQ5/2i2DIXkFWjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722429221; c=relaxed/simple;
	bh=npCRQEKKKNARWr4F6MeBVonySJrS4QMdFa5PvgYGsto=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QBb1bsB1IJeYl9x55S/3ZbcWRb7EuklheHNDz2gEZWnez6ckI+X/7QQuKB684TrJpUFQT8asIBf3wS/MQjhgB0v3crlWqwEO4USeHs6shq3eHdMOXhuzInXNeOTsyIWR9h/haAGVl+iPrnQ7gVROYyaj/g1GJRkCJ8fKjg5yqoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=opOe/IP0; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=opOe/IP0; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1722429218;
	bh=npCRQEKKKNARWr4F6MeBVonySJrS4QMdFa5PvgYGsto=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=opOe/IP0IAIkBf+g+kwWSs+yrU75eLtdPNymwZ4XTKXRMaKRKNjIZwtJdhxEogl8J
	 AX+akHI03VASOqBH+Ej3QvivVUxez1Q+q+o+P39AbkDrcvgFLJP89p+JB3Yuqaz1vW
	 +P09N9CSJDvWRBTv36/O4PR1pnCah/NP/MyMmydg=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9C6491287028;
	Wed, 31 Jul 2024 08:33:38 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id QShGja78F46T; Wed, 31 Jul 2024 08:33:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1722429218;
	bh=npCRQEKKKNARWr4F6MeBVonySJrS4QMdFa5PvgYGsto=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=opOe/IP0IAIkBf+g+kwWSs+yrU75eLtdPNymwZ4XTKXRMaKRKNjIZwtJdhxEogl8J
	 AX+akHI03VASOqBH+Ej3QvivVUxez1Q+q+o+P39AbkDrcvgFLJP89p+JB3Yuqaz1vW
	 +P09N9CSJDvWRBTv36/O4PR1pnCah/NP/MyMmydg=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::db7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id BCF6D1286F62;
	Wed, 31 Jul 2024 08:33:37 -0400 (EDT)
Message-ID: <206bf94bb2eb7ca701ffff0d9d45e27a8b8caed3.camel@HansenPartnership.com>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dan Williams
 <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
 linux-cxl@vger.kernel.org,  linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, jgg@nvidia.com
Date: Wed, 31 Jul 2024 08:33:36 -0400
In-Reply-To: <2024072909-stopwatch-quartet-b65c@gregkh>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
	 <20240726142731.GG28621@pendragon.ideasonboard.com>
	 <66a43c48cb6cc_200582942d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	 <20240728111826.GA30973@pendragon.ideasonboard.com>
	 <2024072802-amendable-unwatched-e656@gregkh>
	 <2b4f6ef3fc8e9babf3398ed4a301c2e4964b9e4a.camel@HansenPartnership.com>
	 <2024072909-stopwatch-quartet-b65c@gregkh>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-07-29 at 08:10 +0200, Greg KH wrote:
> On Sun, Jul 28, 2024 at 11:49:44AM -0400, James Bottomley wrote:
> > On Sun, 2024-07-28 at 17:16 +0200, Greg KH wrote:
> > > On Sun, Jul 28, 2024 at 02:18:26PM +0300, Laurent Pinchart wrote:
> > > > Hi Dan,
> > > > 
> > > > On Fri, Jul 26, 2024 at 05:16:08PM -0700, Dan Williams wrote:
> > > > > Laurent Pinchart wrote:
> > > > > > I know this is a topic proposed for the maintainers summit,
> > > > > > but given the number of people who seem to have an opinion
> > > > > > and be interested in dicussing it, would a session at LPC
> > > > > > be a better candidate ? I don't expect the maintainer
> > > > > > summit to invite all relevant experts from all subsystems,
> > > > > > that would likely overflow the room.
> > > > > > 
> > > > > > The downside of an LPC session is that it could easily turn
> > > > > > into a heated stage fight, and there are probably also
> > > > > > quite a few arguments that can't really be made in the open
> > > > > > :-S
> > > > > 
> > > > > A separate LPC session for a subsystem or set of subsystems
> > > > > to explore local passthrough policy makes sense, but that is
> > > > > not the primary motivation for also requesting a Maintainer
> > > > > Summit topic slot. The primary motivation is discussing the
> > > > > provenance and navigation of cross-subsystem NAKs especially
> > > > > in an environment where the lines between net, mem, and
> > > > > storage are increasingly blurry at the device level.
> > > > 
> > > > Would there be enough space at the maintainers' summit for all
> > > > the relevant people to join the discussion ?
> > > 
> > > Who exactly would you consider the "relevant people" here?  It's
> > > been a wide-ranging conversation/thread :)
> > 
> > This is a bit of a trick question, since there seem to be three
> > separate but intertwined things here
> > 
> >    1. What to do about cross subsystem NAKs (as in how far does one
> >       subsystem have the ability to NAK something another does
> > because
> >       they fear it will impact them ... passthrough being only one
> >       example).
> >    2. Industry education to help manufacturers making bad decisions
> >       about openness and APIs make better ones that actually
> > benefit
> >       their business in the long run.
> >    3. Standards for open drivers (i.e. is passthrough always evil).
> > 
> > 1. is definitely Maintainer Summit material.
> 
> And to ask again, who do you should participate in this?

Well it's a generic process issue, so the usual suspects at the
Maintainer Summit will do, the question being how do we resolve
disagreements between subsystems that think code in one impacts
another. The answer could be what we already have: resolve it on a case
by case basis, in which case see below, but it would be interesting to
see if something better can come out.  If nothing does then no harm
done and if something comes out no-one likes then the Maintainers won't
follow it anyway.

For the specific issue of discussing fwctl, the Plumbers session would
be better because it can likely gather all interested parties.

> > 2. was something the LF used to help us with but seems to have
> > foundered of late (I think on the general assumption that CNCF gets
> > it right, so we can stop pushing)
> 
> Based on the number of meetings and trips I keep having with
> different companies over the past years, 2. is not something that the
> LF is no longer doing, as they fund me doing this all the time. 
> Including visiting and educating your current employer about these
> very issues recently :)

I didn't say it was something you were no longer doing, I said it was
something the LF is no longer helping us do.  You doing this is great,
but you're just one person.  To scale this we need go to resources for
helping the person dealing with it on the mailing list get up the
management chain when these problems arise.  Plus probably a list of
go-to resources who're used to explaining the business end of open
source to corporate executives, just in case the person dealing with
the patches doesn't have the time or doesn't want to.

Regards,

James


