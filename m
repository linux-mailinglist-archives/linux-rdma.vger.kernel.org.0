Return-Path: <linux-rdma+bounces-4052-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E94C93ED2F
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 08:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E33441F21DF5
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 06:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0228C83CD6;
	Mon, 29 Jul 2024 06:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="moqZAd/O"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2DA7E1;
	Mon, 29 Jul 2024 06:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722233425; cv=none; b=UxA4mtxS+YQf654tThSjziMsxUdMj2Shty/D3LD28j3jxZCW+t1YR/tkvWDfx5TWoxb6A9HyVnvUM/9H5lPM6eBq52toxYMLC1qLhDXWkKnMHm9QRQw95yZ6wxa5mTdhJ381LLq3yDKQTcxuZDV6FuWmliRJF1fCtd0ScOsTTEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722233425; c=relaxed/simple;
	bh=v8r0oj5pxZ/f1A2KMLBc/ks194Mzk+Lfe5T2JFsUn7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmRYfRDvhhbFuqgD+L6CI0iHemFokaksX6y4cSTCfrOCmgBR2+nGc7uljFDhYZusUMW7eRPHH1EGvRanwYJN1JPVAIbnnJrUf6LqgkQWQGkdkfjT8btf3jsJQU0RBxMs+nsAqKjzez0dVu8u8+68CjyKwCg8bfDxWeSuBEDrBV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=moqZAd/O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85718C32786;
	Mon, 29 Jul 2024 06:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722233425;
	bh=v8r0oj5pxZ/f1A2KMLBc/ks194Mzk+Lfe5T2JFsUn7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=moqZAd/O37KHuwsIWKtDuCE9PjAq3oWyuRUdvZAhCjcAvgPgu9LrRpMqzSJKA7YAH
	 BAARQYeCwFR50p1D5YkrsRDEJiOFqH9M9PfDjk5teZ/YTSP7Pplhe36fBX9HUwY4AT
	 ust6C5KTYgozcmulR6zVkacC2nlZIWBDjFNMOeKM=
Date: Mon, 29 Jul 2024 08:10:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <2024072909-stopwatch-quartet-b65c@gregkh>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <20240726142731.GG28621@pendragon.ideasonboard.com>
 <66a43c48cb6cc_200582942d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240728111826.GA30973@pendragon.ideasonboard.com>
 <2024072802-amendable-unwatched-e656@gregkh>
 <2b4f6ef3fc8e9babf3398ed4a301c2e4964b9e4a.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b4f6ef3fc8e9babf3398ed4a301c2e4964b9e4a.camel@HansenPartnership.com>

On Sun, Jul 28, 2024 at 11:49:44AM -0400, James Bottomley wrote:
> On Sun, 2024-07-28 at 17:16 +0200, Greg KH wrote:
> > On Sun, Jul 28, 2024 at 02:18:26PM +0300, Laurent Pinchart wrote:
> > > Hi Dan,
> > > 
> > > On Fri, Jul 26, 2024 at 05:16:08PM -0700, Dan Williams wrote:
> > > > Laurent Pinchart wrote:
> > > > > I know this is a topic proposed for the maintainers summit, but
> > > > > given the number of people who seem to have an opinion and be
> > > > > interested in dicussing it, would a session at LPC be a better
> > > > > candidate ? I don't expect the maintainer summit to invite all
> > > > > relevant experts from all subsystems, that would likely
> > > > > overflow the room.
> > > > > 
> > > > > The downside of an LPC session is that it could easily turn
> > > > > into a heated stage fight, and there are probably also quite a
> > > > > few arguments that can't really be made in the open :-S
> > > > 
> > > > A separate LPC session for a subsystem or set of subsystems to
> > > > explore local passthrough policy makes sense, but that is not the
> > > > primary motivation for also requesting a Maintainer Summit topic
> > > > slot. The primary motivation is discussing the provenance and
> > > > navigation of cross-subsystem NAKs especially in an environment
> > > > where the lines between net, mem, and storage are increasingly
> > > > blurry at the device level.
> > > 
> > > Would there be enough space at the maintainers' summit for all the
> > > relevant people to join the discussion ?
> > 
> > Who exactly would you consider the "relevant people" here?  It's been
> > a wide-ranging conversation/thread :)
> 
> This is a bit of a trick question, since there seem to be three
> separate but intertwined things here
> 
>    1. What to do about cross subsystem NAKs (as in how far does one
>       subsystem have the ability to NAK something another does because
>       they fear it will impact them ... passthrough being only one
>       example).
>    2. Industry education to help manufacturers making bad decisions
>       about openness and APIs make better ones that actually benefit
>       their business in the long run.
>    3. Standards for open drivers (i.e. is passthrough always evil).
> 
> 1. is definitely Maintainer Summit material.

And to ask again, who do you should participate in this?

> 2. was something the LF used to help us with but seems to have
> foundered of late (I think on the general assumption that CNCF gets it
> right, so we can stop pushing)

Based on the number of meetings and trips I keep having with different
companies over the past years, 2. is not something that the LF is no
longer doing, as they fund me doing this all the time.  Including
visiting and educating your current employer about these very issues
recently :)

So don't fall into the "because it's not done in a loud way it must not
be happening" trap here please.

thanks,

greg k-h

