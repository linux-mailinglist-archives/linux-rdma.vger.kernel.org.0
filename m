Return-Path: <linux-rdma+bounces-3832-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C95DC92ED63
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 19:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F3421F23DCC
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 17:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC78116D4F0;
	Thu, 11 Jul 2024 17:01:07 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B7220317;
	Thu, 11 Jul 2024 17:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720717267; cv=none; b=F1vXlxlNrMeM0ommOspcsdGMfr1exn8iWbg08XvEYM8+RtvzX2XYm5CXd0so/yn9qcg1h13ywrgmJUr3fV02nw/v4fXah1dp3xOyjnqYqJRmarv7LCGWoArgQViEcaEeDMx2UA5bJbRCgRGVtgxTx7kuoocOEWQ0FMHb+Bh6PpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720717267; c=relaxed/simple;
	bh=TJqqmH2f1xidSJ79t4DedVf877VvyONDb9Qm3RqAPsw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a0BtpnEKYgI55l7Kb69wTgcA9c7NMrlt7OmrMq6+46MaZ8N3abwalaPPtko1gjdOX2D+N4u+8YSFusQr6mo92Nc/lRFyA4CfvR2DA1btxfB5JrzFDUELDm71VIi7JXmCu7FFNs1zhlQ0zHy2HOe5iBJWIZWI1sZoNBKKVyjrLi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WKgvN40pbz6J9qG;
	Fri, 12 Jul 2024 01:00:00 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5AA52140B2A;
	Fri, 12 Jul 2024 01:01:02 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 11 Jul
 2024 18:01:01 +0100
Date: Thu, 11 Jul 2024 18:01:00 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Dan Williams <dan.j.williams@intel.com>, James Bottomley
	<James.Bottomley@hansenpartnership.com>, <ksummit@lists.linux.dev>,
	<linux-cxl@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240711180100.00006b96@Huawei.com>
In-Reply-To: <20240711150559.GF1482543@nvidia.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
	<3b9631cf12f451fc08f410255ebbba23081ada7c.camel@HansenPartnership.com>
	<668db67196ca3_1bc8329416@dwillia2-xfh.jf.intel.com.notmuch>
	<20240710142238.00007295@Huawei.com>
	<20240711150559.GF1482543@nvidia.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 11 Jul 2024 12:05:59 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Jul 10, 2024 at 02:22:38PM +0100, Jonathan Cameron wrote:
> > On Tue, 9 Jul 2024 15:15:13 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >   
> > > James Bottomley wrote:  
> > > > > The upstream discussion has yielded the full spectrum of positions on
> > > > > device specific functionality, and it is a topic that needs cross-
> > > > > kernel consensus as hardware increasingly spans cross-subsystem
> > > > > concerns. Please consider it for a Maintainers Summit discussion.    
> > > > 
> > > > I'm with Greg on this ... can you point to some of the contrary
> > > > positions?    
> > > 
> > > This thread has that discussion:
> > > 
> > > http://lore.kernel.org/0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com
> > > 
> > > I do not want to speak for others on the saliency of their points, all I
> > > can say is that the contrary positions have so far not moved me to drop
> > > consideration of fwctl for CXL.  
> > 
> > I was resisting rat holing. Oh well...
> > 
> > For a 'subset' of CXL.  There are a wide range of controls that are highly
> > destructive, potentially to other hosts (simplest one is a command that
> > will surprise remove someone else's memory).  
> 
> I don't know alot of CXL, but from talking with Dan and reading these
> posts it seems to me that CXL turn into a network, with switches and
> multi-node and then somehow hid some kind of 'raw packet' interface to
> communicate node-to-node. But never added any kind of node level
> authorization? ie trust the nodes not to hurt each other?

You can't actually communicate node to node in the sense of host
to host.  You can just unplug stuff on another other host
(I guess that's a low bandwith comms channel...)
Data access should not be possible in general (ignoring shared
memory which is unrelated to the control path).
Control plane for the nasty stuff should all be in control
of one entity in the system - termed a fabric manager.

> 
> Sounds sketchy to me :)

Yes. The model is with the intent that this is only exposed by
hardware to a BMC / Fabric Manager - so security is by wiring.
The reason it's exposed on a PCI upstream port on a switch is that
there are designs where the Fabric manager is 'just another host'.
It's probably not running general software but that Fabric Manager
is running Linux too.  This isn't hugely different to not wiring
your MCTP management interface directly to the host such that the
OS can mess with it.

> 
> > So if fwctl is adopted, I do want the means to use it for the highly
> > destructive stuff as well!  Maybe that's a future discussion.  
> 
> With that kind of security model you probably have to trust the
> userspace, even in a lockdown kernel.

Agreed - but if we put infrastructure in place I want it to support
this as well.

> 
> ie can userspace replace the CXL HW that has the command interface
> with VFIO and then do anything with nothing more than CAP_SYS_ADMIN
> and root?

Yes if the wiring put that special PCI function on your PCI hierarchy.

> 
> If so it is not unreasonable that a fwctl interface has a similar
> level of protection.
> 
> > > Where CXL has a Command Effects Log that is a reasonable protocol for
> > > making decisions about opaque command codes, and that CXL already has a
> > > few years of experience with the commands that *do* need a Linux-command
> > > wrapper.  
> > 
> > Worth asking if this will incorporate unknown but not vendor defined
> > commands.  There is a long tail of stuff in the spec we haven't caught up
> > with yet.  Or you thinking keep this for the strictly vendor defined stuff?  
> 
> I would allow as much as possible in fwctl that meets the defined
> functional limitations and security model.
> 
> There is security merit in saying userspace will run, parse and
> convert to output complex commands if it can safely do so. From an end
> user perspective running a common tool to view the output is generally
> always preferred anyhow, and the typical user doesn't really care if
> the tool trundles through sysfs or does something else.

Fair enough.  A bit of potential duplication won't be too painful
(fwctl vs stuff that we know is safe enough for a 'normal' interface).

Thanks,

Jonathan
> 
> Jason


