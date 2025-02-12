Return-Path: <linux-rdma+bounces-7685-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA8AA32B60
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 17:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5314188320E
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 16:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEF4211A02;
	Wed, 12 Feb 2025 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QBZ6iK8p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6370271838;
	Wed, 12 Feb 2025 16:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739377196; cv=none; b=iGZMdN+ZrxgJgKCWCh87bm35QFbW9uEsG1JzTYNsUsxx5OYYuSj5qstMmS//rDLiKJ4aRMQgGSmor9kQSlwlJ/evrbzvE5Yv6l2sM6ZWKML8pVn9jhknkgYMFStJb2jFE8Misd5xhgnX/FGXzUKGA3mrOCNVbRRTGa7rQNYnHwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739377196; c=relaxed/simple;
	bh=YooQ49eFxZ9rqrCHqqERJ682DFV8hTsBzrgI+pX86NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQaKTUvU+rsBicp/d03cy3tkYmkVW4NH7s++nyjsFuP+//aSwXmI/Fhl6gsmGe9wYy4pkGYiFKoFLrAAbbra3LEVc5RIzkXBWFsZctaONyS0frut7o4/r/779Eu5adg97tCQwWPqDEtwtoC2pJasbumGK1AZeYm+1dCON30S+6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QBZ6iK8p; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=z8u8RZ0BEM5Khi2YCcYu2PHEMhRzLUob3BZeK3ZE7L0=; b=QBZ6iK8pAJjvaDMYceeEYUK6pW
	l8CwgsUlWyc9xErhlJHEgtqxxBfd5OdElYNRg8plOfldYDGDKLzvB/VQrY/PtTv6wL4ZrtBFC4DVl
	3bFpWSEnZujBuiXZi/YwSDccN7U/iIhcei22TiWYvwLuWAeafZDpYnUoqSxvyct6VsGg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tiFSY-00DRhO-P9; Wed, 12 Feb 2025 17:19:34 +0100
Date: Wed, 12 Feb 2025 17:19:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Shannon Nelson <shannon.nelson@amd.com>, andrew.gospodarek@broadcom.com,
	aron.silverton@oracle.com, dan.j.williams@intel.com,
	daniel.vetter@ffwll.ch, dave.jiang@intel.com, dsahern@kernel.org,
	gospo@broadcom.com, hch@infradead.org, itayavr@nvidia.com,
	jiri@nvidia.com, Jonathan.Cameron@huawei.com, kuba@kernel.org,
	lbloch@nvidia.com, leonro@nvidia.com, saeedm@nvidia.com,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, brett.creeley@amd.com
Subject: Re: [RFC PATCH fwctl 0/5] pds_fwctl: fwctl for AMD/Pensando core
 devices
Message-ID: <1485cdce-2b19-4686-bdca-25353bc88165@lunn.ch>
References: <20250211234854.52277-1-shannon.nelson@amd.com>
 <7a9d5e34-4a1c-4e91-9a25-805052ffd73e@lunn.ch>
 <20250212144328.GB3844591@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212144328.GB3844591@nvidia.com>

On Wed, Feb 12, 2025 at 10:43:28AM -0400, Jason Gunthorpe wrote:
> On Wed, Feb 12, 2025 at 02:40:45PM +0100, Andrew Lunn wrote:
> 
> > Isn't this even generic for any sort of SR-IOV? Wouldn't you need the
> > same sort of operation for a GPU, or anything with a pool of resources
> > which can be mapped to VFs?
> 
> We've been calling this device profiling in the vfio discussions,
> generally yes the general idea of profiling is common, but the actual
> detail of the profile is very device specific.

This is your poster child for fwctl. You are trying to convince us it
is a way to configure things which are very vendor specific. Yet, as
you point out, the idea of profiling is common. So why start here? It
seems an odd choice. So i would of expected the messaging to be
clearer. You the vendors agree there is no commonality, so explain
that. Take three different vendors cards and list all the parameters
which are needed for profiling with these cards. Really show that
there is no commonality. And maybe take it a step further. Get these
vendors to work together to produce three patchset implementing device
profiling, so we can see there cannot be code sharing. Then you might
have a convincing poster child for fwctl.

Given how contentious fwctl is, i would say vendors need to work
together to show there is nothing in common, at least to start
with.

	Andrew

