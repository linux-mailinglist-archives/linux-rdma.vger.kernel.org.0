Return-Path: <linux-rdma+bounces-9612-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7EEA94801
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Apr 2025 15:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48DB43B344E
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Apr 2025 13:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC3B1E8328;
	Sun, 20 Apr 2025 13:49:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4561547F5;
	Sun, 20 Apr 2025 13:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745156969; cv=none; b=cfNRbE49gmiIE0vGdmNIq4pLNoqNUuIt8GmOiL99FPF8ja4Habi+R7lqb+tvne78eSuWkYja2xdyE9rDNeYd50yadYZgJp7gWigBlWIWz0bG5+qGHqM4CaAccKmgrm2KdolXYcqpkaZ7JYI+eCrPzXdCPGH/oAk3IH0tkNtw97g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745156969; c=relaxed/simple;
	bh=DLCRum1j+uHsCNSbtRf4xnepYYS1d+9YpIjX/kzl8OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIGwd0uWf10s+UAJkc1dbkHjuAg9wJ47RL6r8yivo9w27evez2FseWb9f8ooYc76lnWbjAqgRiK/ubaqHxQfaFxr2iym2If13v/g6lZsQLCMfOpAjcWO+rSwGp0vy4vTeNHaT9U6TcEYc5MsC1JSihxXComp1BiC6EJtOg3Ps9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 1D85220D; Sun, 20 Apr 2025 08:41:44 -0500 (CDT)
Date: Sun, 20 Apr 2025 08:41:44 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "sergeh@kernel.org" <sergeh@kernel.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Message-ID: <20250420134144.GA575032@mail.hallyn.com>
References: <CY8PR12MB7195C6D8CCE062CFD9D0174CDCDE2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250318112049.GC9311@nvidia.com>
 <87ldt2yur4.fsf@email.froward.int.ebiederm.org>
 <20250318225709.GC9311@nvidia.com>
 <CY8PR12MB7195B7FAA54E7E0264D28BAEDCA92@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250404151347.GC1336818@nvidia.com>
 <20250406141501.GA481691@mail.hallyn.com>
 <CY8PR12MB7195987AD22775DBBA7FD3B5DCAA2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <Z_PlWIj3N2L6nPaD@lei>
 <CY8PR12MB7195E57FD82E93DB34976CA0DCB92@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB7195E57FD82E93DB34976CA0DCB92@CY8PR12MB7195.namprd12.prod.outlook.com>

On Sun, Apr 20, 2025 at 12:30:37PM +0000, Parav Pandit wrote:
> 
> 
> > From: sergeh@kernel.org <sergeh@kernel.org>
> > Sent: Monday, April 7, 2025 8:17 PM
> > 
> > On Mon, Apr 07, 2025 at 11:16:35AM +0000, Parav Pandit wrote:
> > > > From: Serge E. Hallyn <serge@hallyn.com>
> > > > Sent: Sunday, April 6, 2025 7:45 PM
> > > >
> > > > On Fri, Apr 04, 2025 at 12:13:47PM -0300, Jason Gunthorpe wrote:
> > > > > On Fri, Apr 04, 2025 at 02:53:30PM +0000, Parav Pandit wrote:
> > > > > > To summarize,
> > > > > >
> > > > > > 1. A process can open an RDMA resource (such as a raw QP, raw
> > > > > > flow entry, or similar 'raw' resource) through the fd using
> > > > > > ioctl(), if it has the
> > > > appropriate capability, which in this case is CAP_NET_RAW.
> > > > > > This is similar to a process that opens a raw socket.
> > > > > >
> > > > > > 2. Given that RDMA uses ioctl() for resource creation, there
> > > > > > isn't a security concern surrounding the read()/write() system calls.
> > > > > >
> > > > > > 3. If process A, which does not have CAP_NET_RAW, passes the
> > > > > > opened fd to another privileged process B, which has
> > > > > > CAP_NET_RAW, process B
> > > > can open the raw RDMA resource.
> > > > > > This is still within the kernel-defined security boundary,
> > > > > > similar to a raw
> > > > socket.
> > > > > >
> > > > > > 4. If process A, which has the CAP_NET_RAW capability, passes
> > > > > > the file
> > > > descriptor to Process B, which does not have CAP_NET_RAW, Process B
> > > > will not be able to open the raw RDMA resource.
> > > > > >
> > > > > > Do we agree on this Eric?
> > > > >
> > > > > This is our model, I consider it uAPI, so I don't belive we can
> > > > > change it without an extreme reason..
> > > > >
> > > > > > 5. the process's capability check should be done in the right
> > > > > > user
> > > > namespace.
> > > > > > (instead of current in default user ns).
> > > > > > The right user namespace is the one which created the net namespace.
> > > > > > This is because rdma networking resources are governed by the
> > > > > > net
> > > > namespace.
> > > > >
> > > > > This all makes my head hurt. The right user namespace is the one
> > > > > that is currently active for the invoking process, I couldn't
> > > > > understand why we have net namespaces refer to user namespaces :\
> > > >
> > > > A user at any time can create a new user namespace, without creating
> > > > a new network namespace, and have privilege in that user namespace,
> > > > over resources owned by the user namespace.
> > > >
> > >
> > > > So if a user can create a new user namespace, then say "hey I have
> > > > CAP_NET_ADMIN over current_user_ns, so give me access to the RDMA
> > > > resources belonging to my current_net_ns", that's a problem.
> > > >
> > > > So that's why the check should be ns_capable(device->net->user-ns,
> > > > CAP_NET_ADMIN) and not ns_capable(current_user_ns,
> > CAP_NET_ADMIN).
> > > >
> > > Given the check is of the process (and hence user and net ns) and not
> > > of the rdma device itself, Shouldn't we just check,
> > >
> > > ns_capable(current->nsproxy->user_ns, ...)
> > >
> > > This ensures current network namespace's owning user ns is consulted.
> > 
> > No, it does not.  If I do
> > 
> > unshare -U
> > 
> > then current->nsproxy->user_ns is not my current network namespace's
> > owning user ns.
> >
> It should be current->nsproxy->net->user_ns.
> This ensures that it is always current network namespace's owning user ns is considered.
> Right?
> 
> Sorry for the late response.
> I wasn't well for few days followed by backlog.

Hi,

That will depend on exactly what you're checking permissions for.
It looks like ib_uverbs_ex_create_flow() gets passed a
uverbs_attr_bundle pointer that has a context which holds the
thing you're actually checking permissions towards?  And I'm
assuming that that thing is actually a file?  So again, if the
task can create the "thing" first, then unshare its network
namespace, then cause this permission to be checked, or if
it can accept a file over unix socket or whatever that someone
else opened, then current->nsproxy->net->user_ns may *not* be
relevant.  If, however, the flow, later on, will ensure that
any actions are only relevant in the current network namespace,
then you are correct.

I just can't tell in this flow.  I"ll try to find some time to
track it down more.

-serge

