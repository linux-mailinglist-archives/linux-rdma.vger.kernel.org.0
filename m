Return-Path: <linux-rdma+bounces-9677-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCF5A972C9
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Apr 2025 18:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8763B1DB1
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Apr 2025 16:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6758C29344F;
	Tue, 22 Apr 2025 16:29:50 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59658293449;
	Tue, 22 Apr 2025 16:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745339390; cv=none; b=kxBlFTWwWAW/2mxqCvoyf4+iNuoRWu6zxo3Hi31cVN7pRD4ZzeRq3hKy8OCOUpO48dMb2XnRVoTSi+bbGtCGqjk/QV3cYZ62o/KcxILwlTIC5BGqG4OV5m6ZWE3h7JIQm9QKbah13PQOX6HKiXdeebr3A/QT3WdXeW9vuvVVPe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745339390; c=relaxed/simple;
	bh=EukGHIN1+n05+tQ+74EpnEJVdZ6YLqbhZchKXtA1AMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elAzPlNsNbcZnJTPnji17rlQQVty23QEI+JOwxDdzmJf4iQKYQIhXw+2w7RqUjBLb5pzTGXVSrmdskQ+HyTB/NX6O+arZdp/Dtjh/TGntNbcRbiG6Lw3Cavu5qSGOPZIzM8ngnnIcsyhojEEcOuL05GumNh67opCyM3dPGtYAyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 595ECC10; Tue, 22 Apr 2025 11:29:43 -0500 (CDT)
Date: Tue, 22 Apr 2025 11:29:43 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Parav Pandit <parav@nvidia.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Message-ID: <20250422162943.GA589534@mail.hallyn.com>
References: <20250318225709.GC9311@nvidia.com>
 <CY8PR12MB7195B7FAA54E7E0264D28BAEDCA92@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250421031320.GA579226@mail.hallyn.com>
 <CY8PR12MB7195E4A0C6E019F10222B543DCB82@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250421130024.GA582222@mail.hallyn.com>
 <CY8PR12MB71955204622F18B2C3437BCBDCB82@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250421172236.GA583385@mail.hallyn.com>
 <20250422124640.GI823903@nvidia.com>
 <20250422131433.GA588503@mail.hallyn.com>
 <20250422161127.GO823903@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422161127.GO823903@nvidia.com>

On Tue, Apr 22, 2025 at 01:11:27PM -0300, Jason Gunthorpe wrote:
> On Tue, Apr 22, 2025 at 08:14:33AM -0500, Serge E. Hallyn wrote:
> > Hi Jason,
> > 
> > On Tue, Apr 22, 2025 at 09:46:40AM -0300, Jason Gunthorpe wrote:
> > > On Mon, Apr 21, 2025 at 12:22:36PM -0500, Serge E. Hallyn wrote:
> > > > > > 1. the create should check ns_capable(current->nsproxy->net->user_ns,
> > > > > > CAP_NET_RAW) 
> > > > > I believe this is sufficient as this create call happens through the ioctl().
> > > > > But more question on #3.
> > > 
> > > I think this is the right one to use everywhere.
> > 
> > It's the right one to use when creating resources, but when later using
> > them, since below you say that the resource should in fact be tied to
> > the creator's network namespace, that means that checking
> > current->nsproxy->net->user_ns would have nothing to do with the
> > resource being used, right?
> 
> Yes, in that case you'd check something stored in the uobject.

Perfect, that's exactly the kind of thing I was looking for.  Thanks.

> This happens sort of indirectly, for instance an object may become
> associated with a netdevice and the netdevice is linked to a net
> namespace. Eg we should do route lookups relative to that associated
> net devices's namespaces.
> 
> I'm not sure we have a capable like check like that though.
> 
> > > Even in goofy cases like passing a FD between processes with different
> > > net namespaces, the expectation is that objects can be created
> > > relative to net namespace of the process calling the ioctl, and then
> > > accessed by the other process in the other namespace.
> > 
> > So when earlier it was said that uverbs was switching from read/write
> > to ioctl so that permissions could be checked, that is not actually
> > the case? 
> 
> I don't quite know what you mean here?
> 
> read/write has a security problem in that you can pass a FD to a
> setuid program as its stdout and have that setuid program issue a
> write() to trigger a kernel operation using it's elevated
> privilege. This is not possible with ioctl.
> 
> When this bug was discovered the read/write path started calling
> ib_safe_file_access() which blanket disallows *any* credential change
> from open() to write().
> 
> ioctl removes this excessive restriction and we are back to
> per-process checks.
> 
> > The intent is for a privileged task to create the
> > resource and be able to pass it to any task in any namespace with any
> > or no privilege and have that task be able to use it with the
> > opener's original privilege, just as with read/write?
> 
> Yes. The permissions affiliate with the object contained inside the
> FD, not the FD itself. The FD is just a container and a way to route
> system calls.
> 
> > I was trying last night to track down where the uverb ioctls are doing 
> > permission checks, but failing to find it.  I see where the
> > pbundle->method_elm->handler gets dereferenced, but not where those
> > are defined.
> 
> There are very few permission checks. Most boil down to implicit
> things, like we have a netdevice relative to current's net namespace
> and we need to find a gid table index for that netdevice. We don't
> actually need to do anything special here as the ifindex code
> automatically validates the namespaces and struct net_device * are
> globally unique.
> 
> Similarly with route lookups and things, once we validated the net
> device objects are supposed to remain bound to it.
> 
> The cases like cap_net_raw are one time checks at creation time that
> modify the devices' rules for processing the queues. The devices check
> the creation property of the queue when processing the queue.

Thank you for the detailed explanation.

-serge

