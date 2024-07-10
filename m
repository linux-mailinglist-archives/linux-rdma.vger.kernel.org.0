Return-Path: <linux-rdma+bounces-3792-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E7992D2AB
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 15:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B842E282A51
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 13:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9707192B9D;
	Wed, 10 Jul 2024 13:22:45 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF65B192B97;
	Wed, 10 Jul 2024 13:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720617765; cv=none; b=D8QWkCgqntNw24tDbeUKvl4nsKSeko2durP2r8c1YlF9mCAomA1Ui7nVbX4fgQ3f96yOQHf7FxJS23iy8F2f3fOTp2MKh6mlpI3AytvNfomlHH7Q2TK1oYvNa4ho1XBb3kmIVsNdfrOmyn2sXWYJ8fM82kJGYqQVEru4pWxBb6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720617765; c=relaxed/simple;
	bh=YIkn0y6FEiK+f/vFbGpK+1hsyO7LvjsSxFuxA7mItqA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t/RXE2/bTYOwgDy+4pezO9BWCmcCLxgGA7OWvBNh95pJoZ3Xo7oFiTE64yusbqmxCwnMWnxcbdCG68gKic+Ujo/z/F7FLT52rFUbg66UI+qgOrQ7IUgCdnK/rEtfsmX//AgglP824fhmvEBSNGrOaAbAofrDylRO9yxAne9JSXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WJz5Q0VZNz689PV;
	Wed, 10 Jul 2024 21:21:14 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A4BA41400DD;
	Wed, 10 Jul 2024 21:22:39 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 10 Jul
 2024 14:22:39 +0100
Date: Wed, 10 Jul 2024 14:22:38 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: James Bottomley <James.Bottomley@hansenpartnership.com>,
	<ksummit@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <jgg@nvidia.com>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240710142238.00007295@Huawei.com>
In-Reply-To: <668db67196ca3_1bc8329416@dwillia2-xfh.jf.intel.com.notmuch>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
	<3b9631cf12f451fc08f410255ebbba23081ada7c.camel@HansenPartnership.com>
	<668db67196ca3_1bc8329416@dwillia2-xfh.jf.intel.com.notmuch>
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
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 9 Jul 2024 15:15:13 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> James Bottomley wrote:
> > > The upstream discussion has yielded the full spectrum of positions on
> > > device specific functionality, and it is a topic that needs cross-
> > > kernel consensus as hardware increasingly spans cross-subsystem
> > > concerns. Please consider it for a Maintainers Summit discussion.  
> > 
> > I'm with Greg on this ... can you point to some of the contrary
> > positions?  
> 
> This thread has that discussion:
> 
> http://lore.kernel.org/0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com
> 
> I do not want to speak for others on the saliency of their points, all I
> can say is that the contrary positions have so far not moved me to drop
> consideration of fwctl for CXL.

I was resisting rat holing. Oh well...

For a 'subset' of CXL.  There are a wide range of controls that are highly
destructive, potentially to other hosts (simplest one is a command that
will surprise remove someone else's memory). For those I'm not sure
fwctl gets us anywhere - but we still need a solution (Subject to
config gates etc as typically this is BMCs not hosts).
Maybe fwctl eventually ends up with levels of 'safety' (beyond the
current read vs write vs write_full, or maybe those are enough).

Complexities such as message tunneling to multiple components are also
going to be fun, but we want the non destructive bits of those to work
as part of the safe set, so we can get telemetry from downstream devices.

Good to cover the debug and telemetry usecase, but it still leaves us with
gaping holes were we need to solve the permissions problem, perhaps that
is layered on top of fwctl, perhaps something else is needed.

So if fwctl is adopted, I do want the means to use it for the highly
destructive stuff as well!  Maybe that's a future discussion.


> 
> Where CXL has a Command Effects Log that is a reasonable protocol for
> making decisions about opaque command codes, and that CXL already has a
> few years of experience with the commands that *do* need a Linux-command
> wrapper.

Worth asking if this will incorporate unknown but not vendor defined
commands.  There is a long tail of stuff in the spec we haven't caught up
with yet.  Or you thinking keep this for the strictly vendor defined stuff?

> 
> Some open questions from that thread are: what does it mean for the fate
> of a proposal if one subsystem Acks the ABI and another Naks it for a
> device that crosses subsystem functionality? Would a cynical hardware
> response just lead to plumbing an NVME admin queue, or CXL mailbox to
> get device-specific commands past another subsystem's objection?
> 
> My reconsideration of the "debug-build only" policy for CXL
> device-specific commands was influenced by a conversation with a distro
> developer where they asserted, paraphrasing: "at what point is a device
> vendor incentivized to ship an out-of-tree module just to restore their
> passthrough functionality?. At that point upstream has lost out on
> collaboration and distro kernel ABI has gained another out-of-tree
> consumer."
> 
> So the tension is healthy, but it has diminishing returns past a certain
> point.
> 


