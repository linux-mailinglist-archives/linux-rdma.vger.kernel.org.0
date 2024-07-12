Return-Path: <linux-rdma+bounces-3846-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E215D92F90F
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2024 12:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 518E3B2349F
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2024 10:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366BC158DC1;
	Fri, 12 Jul 2024 10:37:32 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819A114B978;
	Fri, 12 Jul 2024 10:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720780652; cv=none; b=Zyd3hjuHqgbC2M3B63b84ezv2XteNyFID9G5WfTGqqkVcEmnj4ioj0fQ2Bbb9GeOKofVRHTef0N5k0oFP/c5JHQNv6MjU6qhPfns/gTF3jR21ryrbOl6UM760OV7kJxmijEm9gTp1YS+njZzEH/rljXEk42mmMt3y8cOJSCUB30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720780652; c=relaxed/simple;
	bh=YaczT6mneoVMpKwMgJbp7Rg47TMAqdRTX0u8weR9avY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KctPJ5m0BVDCTLGzeEqP/ZyMwlBXu7NR5cdmhPCzZPOP/cja8GblHVmYAaSNXEAO/2hy1LeZUPNoMHpiWRo5+dfT9qFQke8NGsRIU4ZNQ/gJsZLukHXO9WeVAme0w+GD+xpsFmLFB3d58xHN8pud6x3PPuogqcTGz4eAmOv0bJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WL7LG3yc9z6JB4b;
	Fri, 12 Jul 2024 18:36:22 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 69B0B1400D9;
	Fri, 12 Jul 2024 18:37:26 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 12 Jul
 2024 11:37:26 +0100
Date: Fri, 12 Jul 2024 11:37:25 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: James Bottomley <James.Bottomley@hansenpartnership.com>,
	<ksummit@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <jgg@nvidia.com>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240712113725.00004cdb@Huawei.com>
In-Reply-To: <66900a0b9770d_1a7742942c@dwillia2-xfh.jf.intel.com.notmuch>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
	<3b9631cf12f451fc08f410255ebbba23081ada7c.camel@HansenPartnership.com>
	<668db67196ca3_1bc8329416@dwillia2-xfh.jf.intel.com.notmuch>
	<20240710142238.00007295@Huawei.com>
	<66900a0b9770d_1a7742942c@dwillia2-xfh.jf.intel.com.notmuch>
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
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 11 Jul 2024 09:36:27 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
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
> > will surprise remove someone else's memory). For those I'm not sure
> > fwctl gets us anywhere - but we still need a solution (Subject to
> > config gates etc as typically this is BMCs not hosts).
> > Maybe fwctl eventually ends up with levels of 'safety' (beyond the
> > current read vs write vs write_full, or maybe those are enough).  
> 
> It is not clear to me that fwctl needs more levels of safety vs the
> local subsystem config options controlling what can and can not be sent
> over the channel. The CXL backend for fwctl adds the local "command
> effects" level of safety.
> 
> For the "Linux as BMC" case the security model is external to the
> kernel, right? Which means it does not present a protocol that the
> kernel can reason about.

The security model is indeed external, but I'd like a Linux BMC
config to allow turning off the protections but still using the
same fundamental interfaces as we normally use for the safe stuff.
I don't want
1) The CXL IOCTLs
2) FWCTL
3) Yet another interface.

> 
> Unless and until someone develops an authorization model for BMC nodes
> to join a network topology I think that use case is orthogonal to the
> primary in-band use case for fwctl.

Use case wise I agree this isn't the current primary in-band use case
for fwctl, hence the rat hole introductory comment.

> 
> It is still useful there to avoid defining yet another transport, but a
> node that has unfettered access to wreak havoc on the network is not the
> kernel's problem.

As long as I can enable it via a sensible interface (and don't need to
spin another) that is fine by me.

> 
> > Complexities such as message tunneling to multiple components are also
> > going to be fun, but we want the non destructive bits of those to work
> > as part of the safe set, so we can get telemetry from downstream devices.
> > 
> > Good to cover the debug and telemetry usecase, but it still leaves us with
> > gaping holes were we need to solve the permissions problem, perhaps that
> > is layered on top of fwctl, perhaps something else is needed.  
> 
> But that's more a CXL switch-management command security protocol
> problem than fwctl, right? In other words, as far as I understand, there
> is no spec provided permission model for switch management that Linux
> could enforce, so it's more in the category of build a kernel that can
> pass any payload and hope someone else has solved the problem of
> limiting what damage that node can inflict.

Two separate things here.

For tunneling, there is plenty that will map to fwctl because it's just
a transport question.  The tunnel command itself has a CEL that says
it might eat babies so we'd need to check the relevant CEL for the
destination to make sure they were just as safe as non tunneled version.
So it's just an implementation detail, be it a fiddly one.

For destructive options sure it's a config problem. But I do want
to be able to lock down the kernel on the BMC but still allow the
discructive command. Lock down is protecting and restricting the BMC
not the other hosts in this use case. 

> 
> > So if fwctl is adopted, I do want the means to use it for the highly
> > destructive stuff as well!  Maybe that's a future discussion.
> >   
> > > Where CXL has a Command Effects Log that is a reasonable protocol for
> > > making decisions about opaque command codes, and that CXL already has a
> > > few years of experience with the commands that *do* need a Linux-command
> > > wrapper.  
> > 
> > Worth asking if this will incorporate unknown but not vendor defined
> > commands.  There is a long tail of stuff in the spec we haven't caught up
> > with yet.  Or you thinking keep this for the strictly vendor defined stuff?  
> 
> Long term, yes, it should be able to expand to any command code family.
> Short term, to get started, the CXL "Feature" facility at least conveys
> whether opcodes are reads or writes, independent of their side effects,
> and are scoped to be "settings".
> 
> There is still the matter of background commands need to support
> cancellation to avoid indefinite background-command-slot monopolization,
> and there are still commands that need kernel coordination. So, I see
> fwctl command support arriving in stages.

Makes sense.  Tunneled access to CXL features should be an a good explorative
feature to do reasonably soon.

Jonathan



