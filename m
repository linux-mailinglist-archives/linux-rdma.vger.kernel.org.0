Return-Path: <linux-rdma+bounces-3822-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7635592E557
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 13:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05184B226C2
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 11:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777981591E2;
	Thu, 11 Jul 2024 11:00:39 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8969C15A4B7;
	Thu, 11 Jul 2024 11:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720695639; cv=none; b=aowg6z5kBqQ8qRp0xlIzFimn91DgC4yORKLyoDS2qIx2E5uvRk+QvZEULT7pv5/Vj1bawqc09dY1BHsQmGKt/FWjx2iPOQn5J5lIZOcOzsuJghRfENTddYGixWYNQ62fnyco6S5KUnUPQv/nZaZU3TcOGtL4JwP/lBl89ZTqSUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720695639; c=relaxed/simple;
	bh=d+wMvdLVf+YR9DIyh4LVaJL8/YmjqFApmIjGfxbQ41E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BVNam3T+Qsz2Fw7SlMfMSpfftKS3chNSsRRSc9kwB6GYrejNWsGMrtYpxQPrb4BOar5UIh5H+hmxFZIN6Zh07LbBrVnYQRACAmHxcd2fV3r37kzv65mRfI0KUx/l+Bhb/duCLNKLJykpY7FIIu0qEIANT6BUWavKgPLCsL4cxyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WKWt71LLrz67Q86;
	Thu, 11 Jul 2024 18:58:23 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E8AB1400C9;
	Thu, 11 Jul 2024 19:00:28 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 11 Jul
 2024 12:00:27 +0100
Date: Thu, 11 Jul 2024 12:00:27 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: James Bottomley <James.Bottomley@hansenpartnership.com>,
	<ksummit@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <jgg@nvidia.com>,
	<admiyo@os.amperecomputing.com>, Jeremy Kerr <jk@codeconstruct.com.au>, "Matt
 Johnston" <matt@codeconstruct.com.au>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240711120027.000079b2@Huawei.com>
In-Reply-To: <20240710142238.00007295@Huawei.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
	<3b9631cf12f451fc08f410255ebbba23081ada7c.camel@HansenPartnership.com>
	<668db67196ca3_1bc8329416@dwillia2-xfh.jf.intel.com.notmuch>
	<20240710142238.00007295@Huawei.com>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 10 Jul 2024 14:22:38 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Tue, 9 Jul 2024 15:15:13 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > James Bottomley wrote:  
> > > > The upstream discussion has yielded the full spectrum of positions on
> > > > device specific functionality, and it is a topic that needs cross-
> > > > kernel consensus as hardware increasingly spans cross-subsystem
> > > > concerns. Please consider it for a Maintainers Summit discussion.    
> > > 
> > > I'm with Greg on this ... can you point to some of the contrary
> > > positions?    
> > 
> > This thread has that discussion:
> > 
> > http://lore.kernel.org/0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com
> > 
> > I do not want to speak for others on the saliency of their points, all I
> > can say is that the contrary positions have so far not moved me to drop
> > consideration of fwctl for CXL.  
> 
> I was resisting rat holing. Oh well...

To throw another 'fun' one in there.  For anything integrated with the host
there is a proposal to provide a MCTP via PCC (ACPI described mailbox). [1]
I don't think it makes sense to rule that out as it's logically no
different from MCTP in general (e.g. a host controller for PCI VDM, or
I2C etc)

Anyone who has a suitable firmware can do whatever they like with that
and the interfaces is exposed directly to userspace. Adam, perhaps you can
describe your use case a little?  Is it applicable to general server distros?

We might suggest distributions don't enable MCTP but does that
actually get us anywhere?  Anyhow, I suspect there are other similar routes, but
this one happens to be under review at the moment.

[1] https://lore.kernel.org/all/20240702225845.322234-1-admiyo@os.amperecomputing.com/

> 
> For a 'subset' of CXL.  There are a wide range of controls that are highly
> destructive, potentially to other hosts (simplest one is a command that
> will surprise remove someone else's memory). For those I'm not sure
> fwctl gets us anywhere - but we still need a solution (Subject to
> config gates etc as typically this is BMCs not hosts).
> Maybe fwctl eventually ends up with levels of 'safety' (beyond the
> current read vs write vs write_full, or maybe those are enough).
> 
> Complexities such as message tunneling to multiple components are also
> going to be fun, but we want the non destructive bits of those to work
> as part of the safe set, so we can get telemetry from downstream devices.
> 
> Good to cover the debug and telemetry usecase, but it still leaves us with
> gaping holes were we need to solve the permissions problem, perhaps that
> is layered on top of fwctl, perhaps something else is needed.
> 
> So if fwctl is adopted, I do want the means to use it for the highly
> destructive stuff as well!  Maybe that's a future discussion.
> 
> 
> > 
> > Where CXL has a Command Effects Log that is a reasonable protocol for
> > making decisions about opaque command codes, and that CXL already has a
> > few years of experience with the commands that *do* need a Linux-command
> > wrapper.  
> 
> Worth asking if this will incorporate unknown but not vendor defined
> commands.  There is a long tail of stuff in the spec we haven't caught up
> with yet.  Or you thinking keep this for the strictly vendor defined stuff?
> 
> > 
> > Some open questions from that thread are: what does it mean for the fate
> > of a proposal if one subsystem Acks the ABI and another Naks it for a
> > device that crosses subsystem functionality? Would a cynical hardware
> > response just lead to plumbing an NVME admin queue, or CXL mailbox to
> > get device-specific commands past another subsystem's objection?
> > 
> > My reconsideration of the "debug-build only" policy for CXL
> > device-specific commands was influenced by a conversation with a distro
> > developer where they asserted, paraphrasing: "at what point is a device
> > vendor incentivized to ship an out-of-tree module just to restore their
> > passthrough functionality?. At that point upstream has lost out on
> > collaboration and distro kernel ABI has gained another out-of-tree
> > consumer."
> > 
> > So the tension is healthy, but it has diminishing returns past a certain
> > point.
> >   
> 
> 
> 


