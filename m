Return-Path: <linux-rdma+bounces-3917-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EEE9385D4
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jul 2024 20:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18FF32811F2
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jul 2024 18:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED77D168492;
	Sun, 21 Jul 2024 18:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="DZG7ORp9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9DF1EB27;
	Sun, 21 Jul 2024 18:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721587886; cv=none; b=UfSVgbeoOX+U3EU6jRPA29LKfRqQsADwoVw1EaEwKJ7hyFdbOlE4ryM3GoYDckmY0+qEB3flrG5Wq+bA92CcSdSHFj8h1ApZhmZNOgJUqX6Q5JtjT5Iuvf6enV1WJPvnwtUdtmY53mDPYCU+YxeWhgQtIIhUaOlIb2rKIfdUfYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721587886; c=relaxed/simple;
	bh=QV7Z7Dgz2cbHCnbdSbMO++Aw71Fq/tm61ZB+qVEdwLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EW8eoSJarcwqapGxOocSuIbNSSRdHrma6UeAN78/m/FnnR3cF8Hd2D9N9QBwtiXOoiim0P1nY53RAvk2V/QwibMMZsr16DyoEoqD2o9zSvOKOQLTbkPObJpNymX0TBgVNlVG8Z8Sg1+Wvz/yak6v1qyJtffe1qSDdroAFGxArEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=DZG7ORp9; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 48400220;
	Sun, 21 Jul 2024 20:50:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1721587842;
	bh=QV7Z7Dgz2cbHCnbdSbMO++Aw71Fq/tm61ZB+qVEdwLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DZG7ORp9d12kdlX/2GcgX7SMvcEgFhtQi70Oda1pezFs3f0HWu+7KTI/FVfFC+LPr
	 1ujzzGuVT6T5KbFdPYDeHr2MCSgLyyIRYj7tZSN23mKG87FoGA+USc4mXFL3gPa0sh
	 eCc//Q/q+w34jMQWVq706Ae2jZWSPR0ZiPAADnew=
Date: Sun, 21 Jul 2024 21:51:05 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240721185105.GC23783@pendragon.ideasonboard.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <ZozUJepl9_gnKnlv@infradead.org>
 <668d92f68916f_102cc2947b@dwillia2-xfh.jf.intel.com.notmuch>
 <20240710130514.GQ107163@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240710130514.GQ107163@nvidia.com>

On Wed, Jul 10, 2024 at 10:05:14AM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 09, 2024 at 12:43:50PM -0700, Dan Williams wrote:
> 
> > A "Command Effects Log" seems like that starting point, with trust that
> > cynical abuses of that contract have a higher cost than benefit, and
> > trust that the protocol limits the potential damage of such abuse.
> 
> I've taken the view that companies are now very vigilant about
> security and often have their own internal incentives and procedures
> to do secure things.
> 
> If someone does a cynical security breaking thing and deploys it to a
> wide user base they are likely to be caught by a security researcher
> and embarassed with a CVE and a web site with a snappy name.

That may be the case in the server world, and for protocols such as
NVMe. My experience in the media world differs. I've seen too many
horrors to list them all here, so I'll only mention one of the worst
examples coming to my mind, of an (BSP) driver taking a physical address
from unpriviledged userspace and giving it to a DMA engine without any
filtering. I think this was mostly to be blamed on the developer not
knowing better, there was no malicious intent.

In general, can we trust closed-source firmwares when they document the
side effects of pass-through commands ? Again, I think the answer
differs between different classes of devices, the security culture is
not uniform across the whole IT industry.

> Not 100% of course, but it is certainly not a wild west of people just
> doing whatever they want.
> 
> The other half of this bargin is we have to be much clearer about what
> the security model is and what is security breaking. Like Christoph I
> often have conversations with people who don't understand the basics
> of how the Linux security models should work and are doing device-side
> work that has to fit into it.

-- 
Regards,

Laurent Pinchart

