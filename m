Return-Path: <linux-rdma+bounces-9649-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CAEA9552F
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 19:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D1281895BB6
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 17:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35611DE8A8;
	Mon, 21 Apr 2025 17:22:47 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B234F3596D;
	Mon, 21 Apr 2025 17:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745256167; cv=none; b=QkKeWpQynJN4MwUuKvhB7RrCz2v0big/pRdMTs4bTjN2DOOCz8aVJvLCBoJbxuEoN60OcX6EK5flFoCHcxh8DIhLuCHYttiW44vdjoEoTjuELf2lyjkgTkujMscQHPc7HWdowFR4v2Z7QnfySViuHEQXmJuvynksWtYey4v595U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745256167; c=relaxed/simple;
	bh=fP+W/vIgFBy+IEp5u2LmhOpmrpySu4SezCI2Fv2z23k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ff8CarXRPVRhtID4KKWmf7F5DpexRbpXmB0U3MHtUVhieoocwFm3BIBrYJb+A/1YKlwzY8f3reMIf4UH3ufSCAZ0uVKeGEu32ELtVxfZejcobA++14gtP/pzJy65sGZ65nIatuiGxZ/PbsoVcLyJf0YDo+lqH67eQRbnZmvHsmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 4B264A9F; Mon, 21 Apr 2025 12:22:36 -0500 (CDT)
Date: Mon, 21 Apr 2025 12:22:36 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Jason Gunthorpe <jgg@nvidia.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Message-ID: <20250421172236.GA583385@mail.hallyn.com>
References: <20250317193148.GU9311@nvidia.com>
 <CY8PR12MB7195C6D8CCE062CFD9D0174CDCDE2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250318112049.GC9311@nvidia.com>
 <87ldt2yur4.fsf@email.froward.int.ebiederm.org>
 <20250318225709.GC9311@nvidia.com>
 <CY8PR12MB7195B7FAA54E7E0264D28BAEDCA92@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250421031320.GA579226@mail.hallyn.com>
 <CY8PR12MB7195E4A0C6E019F10222B543DCB82@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250421130024.GA582222@mail.hallyn.com>
 <CY8PR12MB71955204622F18B2C3437BCBDCB82@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB71955204622F18B2C3437BCBDCB82@CY8PR12MB7195.namprd12.prod.outlook.com>

On Mon, Apr 21, 2025 at 01:33:45PM +0000, Parav Pandit wrote:
> 
> 
> > From: Serge E. Hallyn <serge@hallyn.com>
> > Sent: Monday, April 21, 2025 6:30 PM
> > 
> > On Mon, Apr 21, 2025 at 11:04:57AM +0000, Parav Pandit wrote:
> > >
> > > > From: Serge E. Hallyn <serge@hallyn.com>
> > > > Sent: Monday, April 21, 2025 8:43 AM
> > > >
> > > > On Fri, Apr 04, 2025 at 02:53:30PM +0000, Parav Pandit wrote:
> > > > > Hi Eric, Jason,
> > > >
> > > > Hi,
> > > >
> > > > I'm jumping back up the thread as I think this email best details
> > > > the things I'm confused about :)  Three questions below in two different
> > stanzas.
> > > >
> > > > > To summarize,
> > > > >
> > > > > 1. A process can open an RDMA resource (such as a raw QP, raw flow
> > > > > entry, or similar 'raw' resource) through the fd using ioctl(), if
> > > > > it has the
> > > > appropriate capability, which in this case is CAP_NET_RAW.
> > > >
> > > > Why does it need CAP_NET_RAW to create the resource, if the resource
> > > > won't be usable by a process without CAP_NET_RAW later anyway?
> > > Once the resource is created, and the fd is shared (like a raw socket fd), it
> > will be usable by a process without CAP_NET_RAW.
> > > Is that a concern? If yes, how is it solved for raw socket fd? It appears to me
> > that it is not.
> > >
> > > > Is that legacy
> > > > for the read/write (vs ioctl) case?
> > > No.
> > >
> > > > Or is it to limit the number of opened resources?  Or some other
> > > > reason?
> > > >
> > > The resource enables to do raw operation, hence the capability check of the
> > process for having NET_RAW cap.
> > 
> > Ok, so it seems to me that
> > 
> > 1. the create should check ns_capable(current->nsproxy->net->user_ns,
> > CAP_NET_RAW) 
> I believe this is sufficient as this create call happens through the ioctl().
> But more question on #3.
> 
> > 2. the read/write are a known escape, eventually to be
> > removed?
> Write should be deprecated eventually.
> Jason mentioned that write() can be compiled out of kernel.
> I guess it needs new compile time config flag around [1].
> 
> [1] https://elixir.bootlin.com/linux/v6.14.3/source/drivers/infiniband/core/uverbs_main.c#L1037
> 
> > 3. the ioctl should check file_ns_capable(attrs->ufile->filp->f_cred->user_ns,
> > CAP_NET_RAW)
> > 
> > Two notes about (3).  First, note that it's different from what you had.
> > It explicitly checks that the caller has CAP_NET_RAW against the net
> > namespace that was used to open the file.  
> How is the net namespace linked in #3?
> Is it because when file was opened, the rdma device was accessible in a given net ns?
> But again the net ns explicitly not accessed in #3.

I'll have to look around and see if we can deduce the netns from elsewhere,
the device perhaps.  But IIUC the file's user_ns should be the one for
which we checked that it has CAP_NET_RAW over the actual net->user_ns,
so if you have CAP_NET_RAW in that user_ns, then you're good.  Where it
*could* get wonky is if the opener was in a parent userns of the net->userns.
In that case the file's userns will be sufficient to access the net, but
we could end up denying access from a privileged process in its child
user_ns, that is, potentially, the net->userns.

> > Second, I'm suggesting this
> > because Jason does keep saying that ioctl is supposed to solve the missing
> > permission check.  
> I don't understand how ioctl() is replacement to capability ns_capable() check.

I'm assuming the ioctl system call handler does the check.  I'll double-check.

> Do you mean to delete the capable() call itself?
> I likely misunderstood..
> 
> > If it really is felt that no permission check should be
> > needed, that's a different discussion.  I've just been trying to figure out where
> > the state should be tracked.
> > 
> > -serge

