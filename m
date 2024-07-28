Return-Path: <linux-rdma+bounces-4041-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C3A93E5C6
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jul 2024 17:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98839B21260
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jul 2024 15:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CD252F62;
	Sun, 28 Jul 2024 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EV4pJhfw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8805B3FE55;
	Sun, 28 Jul 2024 15:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722179790; cv=none; b=oNSgDgDGQUXPuDM6jc0ZqMPCb68SFtxCSa9BMRUB/SWyU31QUK82mBfYALbOKd2hj5ky1FFMMlI2g23L6wkhb2NeNBCrU6UqsgNoLiXFs2/nMnDQBgFhzHnY6G+fHrQmE3Nsd/vVQqfkRsho3eBpwKofHFa9k4lyUlJe/ICKzpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722179790; c=relaxed/simple;
	bh=mwMxZbCgroPb8q3wcXbtPcje/2bO9KTKEIIY9SBR37o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXkq9oYbGq3iNyelqH/xzUmEjH5On0e6adso4+IoiCacMT32ofXA49Jm6S5wLAP7/vyvUpuPzf0Pkr/wlE/ob7MqwmkTqg3ch9ZhtBWmmvGhEVBBMBcKct6JsjR5/fD+vnSN2ft8ylQAuIoYzIKbnQDdDumjjyU3N+pb4s8d1kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EV4pJhfw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9532C116B1;
	Sun, 28 Jul 2024 15:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722179790;
	bh=mwMxZbCgroPb8q3wcXbtPcje/2bO9KTKEIIY9SBR37o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EV4pJhfwGMeNhllO6F2W1oISau2BfQ4E2mnL/DpQ5uH1jZS1YSUzE1XVnuq9L9Zo0
	 K7RoM/o8shefX9gqLPIy8u+r5L4Uu85M85+NIm8jbLmxLbLG7tDDWw/Kod4w7KGL7c
	 08TYzpzma8/rt0Trsobil6CNalYiNgh3wk5rYfTM=
Date: Sun, 28 Jul 2024 17:16:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <2024072802-amendable-unwatched-e656@gregkh>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <20240726142731.GG28621@pendragon.ideasonboard.com>
 <66a43c48cb6cc_200582942d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240728111826.GA30973@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240728111826.GA30973@pendragon.ideasonboard.com>

On Sun, Jul 28, 2024 at 02:18:26PM +0300, Laurent Pinchart wrote:
> Hi Dan,
> 
> On Fri, Jul 26, 2024 at 05:16:08PM -0700, Dan Williams wrote:
> > Laurent Pinchart wrote:
> > > I know this is a topic proposed for the maintainers summit, but given
> > > the number of people who seem to have an opinion and be interested in
> > > dicussing it, would a session at LPC be a better candidate ? I don't
> > > expect the maintainer summit to invite all relevant experts from all
> > > subsystems, that would likely overflow the room.
> > > 
> > > The downside of an LPC session is that it could easily turn into a
> > > heated stage fight, and there are probably also quite a few arguments
> > > that can't really be made in the open :-S
> > 
> > A separate LPC session for a subsystem or set of subsystems to explore
> > local passthrough policy makes sense, but that is not the primary
> > motivation for also requesting a Maintainer Summit topic slot. The
> > primary motivation is discussing the provenance and navigation of
> > cross-subsystem NAKs especially in an environment where the lines
> > between net, mem, and storage are increasingly blurry at the device
> > level.
> 
> Would there be enough space at the maintainers' summit for all the
> relevant people to join the discussion ?

Who exactly would you consider the "relevant people" here?  It's been a
wide-ranging conversation/thread :)

thanks,

greg k-h

