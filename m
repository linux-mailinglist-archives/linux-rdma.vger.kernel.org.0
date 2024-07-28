Return-Path: <linux-rdma+bounces-4043-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D7F93E5ED
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jul 2024 17:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56EFD2817AC
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jul 2024 15:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0F953363;
	Sun, 28 Jul 2024 15:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="F+zgkV2T"
X-Original-To: linux-rdma@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C9C1B86DC;
	Sun, 28 Jul 2024 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722180894; cv=none; b=T4r30OJ4Fid7TICiBYjismF7x28aph7DMyp6YrdsWPtHlbZ4Frcup03Rt68TMpuU/ULCM0pBK/VnI2QmbnYaz7rjaOIPSaj20+C82Nmq3FmQ27SLbSJEXd01ax9QLQiq9SUoRS3aw5kQeX3mIBZt2zi2cO83hSqQEuQEGWJA3l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722180894; c=relaxed/simple;
	bh=D1lUrAtb/CiSAh3bACZv4z+JPkzu0VurNf42xLUy0g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTR4kj+GU3Ybo9RicO5ONlUF1QM3R9l79kIVpWMmPHc3BcZWdpGWXHNrZ4L+JkOXyve/Z4cBzhHpPTAoyk2Ow8nUvvhMQm8UUku9D9oZKxbGQ2gYvSZ6VhGy/PhoAV/SY4Ub2zvLTn57EozqzMwMT+eOiv7+S1GfXF7jDIEsYlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=F+zgkV2T; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 67C728DB;
	Sun, 28 Jul 2024 17:34:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1722180845;
	bh=D1lUrAtb/CiSAh3bACZv4z+JPkzu0VurNf42xLUy0g8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F+zgkV2TJGybLZVK00CfOVcntfmornTt7n6ih4Jgb6n0qY+SwB8+dQ/ZnCQ3qmzQQ
	 YskzX0cAPv45krsD/XsPRD07OEyVgcen2ONH8jkJDP+1Ty9l83QaWQOt1O8OsZsJRN
	 J8GHeXut/JMsOEhAkqKgsCDF7mG0+zSXGCFUC1No=
Date: Sun, 28 Jul 2024 18:34:32 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240728153432.GE30973@pendragon.ideasonboard.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <20240726142731.GG28621@pendragon.ideasonboard.com>
 <66a43c48cb6cc_200582942d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240728111826.GA30973@pendragon.ideasonboard.com>
 <2024072802-amendable-unwatched-e656@gregkh>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024072802-amendable-unwatched-e656@gregkh>

On Sun, Jul 28, 2024 at 05:16:28PM +0200, Greg KH wrote:
> On Sun, Jul 28, 2024 at 02:18:26PM +0300, Laurent Pinchart wrote:
> > On Fri, Jul 26, 2024 at 05:16:08PM -0700, Dan Williams wrote:
> > > Laurent Pinchart wrote:
> > > > I know this is a topic proposed for the maintainers summit, but given
> > > > the number of people who seem to have an opinion and be interested in
> > > > dicussing it, would a session at LPC be a better candidate ? I don't
> > > > expect the maintainer summit to invite all relevant experts from all
> > > > subsystems, that would likely overflow the room.
> > > > 
> > > > The downside of an LPC session is that it could easily turn into a
> > > > heated stage fight, and there are probably also quite a few arguments
> > > > that can't really be made in the open :-S
> > > 
> > > A separate LPC session for a subsystem or set of subsystems to explore
> > > local passthrough policy makes sense, but that is not the primary
> > > motivation for also requesting a Maintainer Summit topic slot. The
> > > primary motivation is discussing the provenance and navigation of
> > > cross-subsystem NAKs especially in an environment where the lines
> > > between net, mem, and storage are increasingly blurry at the device
> > > level.
> > 
> > Would there be enough space at the maintainers' summit for all the
> > relevant people to join the discussion ?
> 
> Who exactly would you consider the "relevant people" here?  It's been a
> wide-ranging conversation/thread :)

I'd say the maintainers of the related subsystems/drivers, or the
relevant open-source stacks, as well as the people who are pushing for a
change, and overall the main stakeholders who took part in the
discussions so far. I don't think it would be very nice to discuss this
topic and make a decision behind closed doors while excluding some of
those people from the process.

I have opinions on the overall topic, but mostly related to cameras, so
I wouldn't consider myself as relevant when it comes to net/mem/storage,
mlx5 or fwctl in particular.

-- 
Regards,

Laurent Pinchart

