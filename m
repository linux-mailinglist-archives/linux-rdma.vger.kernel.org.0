Return-Path: <linux-rdma+bounces-4044-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D9393E718
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jul 2024 18:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C26E31F23754
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jul 2024 16:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64BB1552EB;
	Sun, 28 Jul 2024 15:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="WFk9FEsu";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="WFk9FEsu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ACF61FC4;
	Sun, 28 Jul 2024 15:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181790; cv=none; b=J5a0qKroBKGXP6uvh3RjqYNjXNWzN4oEOSWp3sP/LZr7wkuO5Xcl6MBT4PXXVaosP5QCm73eO7DlsrA+stMMA0TsmKPyVRnsmmfv+MtrKVyH5sZOI/lM1HhQp4sz9p0N1Yl9W0gTj6clR2E01YgH9sb7uY7J2LxmmLln9MyKjT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181790; c=relaxed/simple;
	bh=0qxRAYG9xkiFfGHAqlEygu7kTF5865d2ZzqhhwVeuSM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lh1pyaGPhaTrIvmmROURphsgYMPHOpEWU+s8EyK0FSRUOb3F9OXp+CKe19NY/GfCeCvHmeTk+SxG5adEZpTNwrtUa8fB9oLs2pUFlBy9d3pgokwBe8aahCZAs1ko5aqmigOxZs6fsCyLqB8wA6/yTClwrLsnXPvalxKnJbAavSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=WFk9FEsu; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=WFk9FEsu; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1722181787;
	bh=0qxRAYG9xkiFfGHAqlEygu7kTF5865d2ZzqhhwVeuSM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=WFk9FEsu41BIruNf5pnwR/+AXJZm23A4NmazTL2OX6mdKkV2tq5em1LHkcTp2Z/z5
	 1W5wO5ZAovj5iPP3aSKWkM7sQwxzq2vzbXUgz9xtUp8v4dyovbn7fGVL4d6qbo4IQX
	 iYA6kCFYaF3xyNo/slyhWN5u6q5VB8CAxhFF6v6c=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 865941281ECE;
	Sun, 28 Jul 2024 11:49:47 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 67CC0ZUaU8jf; Sun, 28 Jul 2024 11:49:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1722181787;
	bh=0qxRAYG9xkiFfGHAqlEygu7kTF5865d2ZzqhhwVeuSM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=WFk9FEsu41BIruNf5pnwR/+AXJZm23A4NmazTL2OX6mdKkV2tq5em1LHkcTp2Z/z5
	 1W5wO5ZAovj5iPP3aSKWkM7sQwxzq2vzbXUgz9xtUp8v4dyovbn7fGVL4d6qbo4IQX
	 iYA6kCFYaF3xyNo/slyhWN5u6q5VB8CAxhFF6v6c=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::db7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id A26541280FF2;
	Sun, 28 Jul 2024 11:49:46 -0400 (EDT)
Message-ID: <2b4f6ef3fc8e9babf3398ed4a301c2e4964b9e4a.camel@HansenPartnership.com>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Greg KH <gregkh@linuxfoundation.org>, Laurent Pinchart
	 <laurent.pinchart@ideasonboard.com>
Cc: Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev, 
 linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org,  jgg@nvidia.com
Date: Sun, 28 Jul 2024 11:49:44 -0400
In-Reply-To: <2024072802-amendable-unwatched-e656@gregkh>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
	 <20240726142731.GG28621@pendragon.ideasonboard.com>
	 <66a43c48cb6cc_200582942d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	 <20240728111826.GA30973@pendragon.ideasonboard.com>
	 <2024072802-amendable-unwatched-e656@gregkh>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 2024-07-28 at 17:16 +0200, Greg KH wrote:
> On Sun, Jul 28, 2024 at 02:18:26PM +0300, Laurent Pinchart wrote:
> > Hi Dan,
> > 
> > On Fri, Jul 26, 2024 at 05:16:08PM -0700, Dan Williams wrote:
> > > Laurent Pinchart wrote:
> > > > I know this is a topic proposed for the maintainers summit, but
> > > > given the number of people who seem to have an opinion and be
> > > > interested in dicussing it, would a session at LPC be a better
> > > > candidate ? I don't expect the maintainer summit to invite all
> > > > relevant experts from all subsystems, that would likely
> > > > overflow the room.
> > > > 
> > > > The downside of an LPC session is that it could easily turn
> > > > into a heated stage fight, and there are probably also quite a
> > > > few arguments that can't really be made in the open :-S
> > > 
> > > A separate LPC session for a subsystem or set of subsystems to
> > > explore local passthrough policy makes sense, but that is not the
> > > primary motivation for also requesting a Maintainer Summit topic
> > > slot. The primary motivation is discussing the provenance and
> > > navigation of cross-subsystem NAKs especially in an environment
> > > where the lines between net, mem, and storage are increasingly
> > > blurry at the device level.
> > 
> > Would there be enough space at the maintainers' summit for all the
> > relevant people to join the discussion ?
> 
> Who exactly would you consider the "relevant people" here?  It's been
> a wide-ranging conversation/thread :)

This is a bit of a trick question, since there seem to be three
separate but intertwined things here

   1. What to do about cross subsystem NAKs (as in how far does one
      subsystem have the ability to NAK something another does because
      they fear it will impact them ... passthrough being only one
      example).
   2. Industry education to help manufacturers making bad decisions
      about openness and APIs make better ones that actually benefit
      their business in the long run.
   3. Standards for open drivers (i.e. is passthrough always evil).

1. is definitely Maintainer Summit material. 2. was something the LF
used to help us with but seems to have foundered of late (I think on
the general assumption that CNCF gets it right, so we can stop pushing)
and 3. is definitely where Plumbers could host a wide ranging debate.

James


