Return-Path: <linux-rdma+bounces-9673-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C103A96C3F
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Apr 2025 15:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01B4C7A6747
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Apr 2025 13:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C9328136F;
	Tue, 22 Apr 2025 13:14:40 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D37720C490;
	Tue, 22 Apr 2025 13:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745327679; cv=none; b=fzyI0iCidPwNJCmXSRZn0diZ3SYYeWkBf9kP4KEK6RZvu6ttY/VfOgXZDPq+4V9Oc7Ab06bXtwasyeczpHfY4pYCg/xnybn0johl2Jtwb8yQ/Er3LSNcJ3L2PmPNhGWbFDqarL9D20wkUU6Dh8LFck2OSsNkP7VfeZOQTLdnMgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745327679; c=relaxed/simple;
	bh=SuCyOEailZA9fhsZw85JkpSQD5jDz5qBD9X1wpxcvBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdArjWylsdiZhdGEFGBzbaOVm22+KCzPTmtalpH1B0eUoEhO0NanUKueWTwRT74b8mjJPcMGZIfmPhGB0bRtFN91El6GkRK+vVdsEUtZzxkCUO1emuENRriGvYqEefx3QLTLwVqhlxI/Ahs4YjaQs9SqhUYjcV8AHPUfG1c+GsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 5EAAB4A4; Tue, 22 Apr 2025 08:14:33 -0500 (CDT)
Date: Tue, 22 Apr 2025 08:14:33 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Parav Pandit <parav@nvidia.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Message-ID: <20250422131433.GA588503@mail.hallyn.com>
References: <20250318112049.GC9311@nvidia.com>
 <87ldt2yur4.fsf@email.froward.int.ebiederm.org>
 <20250318225709.GC9311@nvidia.com>
 <CY8PR12MB7195B7FAA54E7E0264D28BAEDCA92@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250421031320.GA579226@mail.hallyn.com>
 <CY8PR12MB7195E4A0C6E019F10222B543DCB82@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250421130024.GA582222@mail.hallyn.com>
 <CY8PR12MB71955204622F18B2C3437BCBDCB82@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250421172236.GA583385@mail.hallyn.com>
 <20250422124640.GI823903@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422124640.GI823903@nvidia.com>

Hi Jason,

On Tue, Apr 22, 2025 at 09:46:40AM -0300, Jason Gunthorpe wrote:
> On Mon, Apr 21, 2025 at 12:22:36PM -0500, Serge E. Hallyn wrote:
> > > > 1. the create should check ns_capable(current->nsproxy->net->user_ns,
> > > > CAP_NET_RAW) 
> > > I believe this is sufficient as this create call happens through the ioctl().
> > > But more question on #3.
> 
> I think this is the right one to use everywhere.

It's the right one to use when creating resources, but when later using
them, since below you say that the resource should in fact be tied to
the creator's network namespace, that means that checking
current->nsproxy->net->user_ns would have nothing to do with the
resource being used, right?

> > > > 3. the ioctl should check file_ns_capable(attrs->ufile->filp->f_cred->user_ns,
> > > > CAP_NET_RAW)
> > > > 
> > > > Two notes about (3).  First, note that it's different from what you had.
> > > > It explicitly checks that the caller has CAP_NET_RAW against the net
> > > > namespace that was used to open the file.  
> > > How is the net namespace linked in #3?
> > > Is it because when file was opened, the rdma device was accessible in a given net ns?
> > > But again the net ns explicitly not accessed in #3.
> > 
> > I'll have to look around and see if we can deduce the netns from elsewhere,
> > the device perhaps.  But IIUC the file's user_ns should be the one for
> > which we checked that it has CAP_NET_RAW over the actual net->user_ns,
> > so if you have CAP_NET_RAW in that user_ns, then you're good.  Where it
> > *could* get wonky is if the opener was in a parent userns of the net->userns.
> > In that case the file's userns will be sufficient to access the net, but
> > we could end up denying access from a privileged process in its child
> > user_ns, that is, potentially, the net->userns.
> 
> We should never be taking any security check from the struct file.
> 
> All security checks are only done on current in rdma, the context of
> the file opener must contribute nothing. The file opener could have
> had more privilege than the child process somehow, and that extra
> privilege should not leak into the child.
> 
> Even in goofy cases like passing a FD between processes with different
> net namespaces, the expectation is that objects can be created
> relative to net namespace of the process calling the ioctl, and then
> accessed by the other process in the other namespace.

So when earlier it was said that uverbs was switching from read/write
to ioctl so that permissions could be checked, that is not actually
the case?  The intent is for a privileged task to create the
resource and be able to pass it to any task in any namespace with any
or no privilege and have that task be able to use it with the
opener's original privilege, just as with read/write?

> Objects should and do become bound to the net namespaces that created
> them, just not the FD.

I was trying last night to track down where the uverb ioctls are doing 
permission checks, but failing to find it.  I see where the
pbundle->method_elm->handler gets dereferenced, but not where those
are defined.

