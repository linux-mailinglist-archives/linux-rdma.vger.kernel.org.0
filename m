Return-Path: <linux-rdma+bounces-9637-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08493A95149
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 15:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E560B18936C9
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 13:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABCE264A9E;
	Mon, 21 Apr 2025 13:00:30 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF7027450;
	Mon, 21 Apr 2025 13:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745240430; cv=none; b=fJhm33Gad1bndEFtFvGcpcfbcRXDf2QdicQFhXWcksf2rB8qXZ6Qvnvc2dOUDn7whyZxVzEF5r5A0mt5NSfGSE4PcFXv38RI1doe3BXmLf8DyhO7eK4GGp4ctLpb8CXvlPAWpXoiLIQ8whLQnlpKMsCAoOV+CGtVQNsvxEMNA6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745240430; c=relaxed/simple;
	bh=aXdgcgmaKhXuwAZt6FT8109q9UqhM6nSsCnSOGiWAIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1WQo91QjnsTTDDjiESL4rAasldtQKt1w5O4rIbTu51jXfjPRJL6DikxblGKt04ve2+pIiHUlqnX37TBt7gxvcL8FBeWtLxz1uUIggQfDAIFG6fJMy5lstkstbLyZWtq1Z9iFqH8EKpuOKD9L50Gyw7NTqm9tXOhy6W32DXhqNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 52545A9F; Mon, 21 Apr 2025 08:00:24 -0500 (CDT)
Date: Mon, 21 Apr 2025 08:00:24 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Jason Gunthorpe <jgg@nvidia.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Message-ID: <20250421130024.GA582222@mail.hallyn.com>
References: <20250313050832.113030-1-parav@nvidia.com>
 <20250317193148.GU9311@nvidia.com>
 <CY8PR12MB7195C6D8CCE062CFD9D0174CDCDE2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250318112049.GC9311@nvidia.com>
 <87ldt2yur4.fsf@email.froward.int.ebiederm.org>
 <20250318225709.GC9311@nvidia.com>
 <CY8PR12MB7195B7FAA54E7E0264D28BAEDCA92@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250421031320.GA579226@mail.hallyn.com>
 <CY8PR12MB7195E4A0C6E019F10222B543DCB82@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB7195E4A0C6E019F10222B543DCB82@CY8PR12MB7195.namprd12.prod.outlook.com>

On Mon, Apr 21, 2025 at 11:04:57AM +0000, Parav Pandit wrote:
> 
> > From: Serge E. Hallyn <serge@hallyn.com>
> > Sent: Monday, April 21, 2025 8:43 AM
> > 
> > On Fri, Apr 04, 2025 at 02:53:30PM +0000, Parav Pandit wrote:
> > > Hi Eric, Jason,
> > 
> > Hi,
> > 
> > I'm jumping back up the thread as I think this email best details the things I'm
> > confused about :)  Three questions below in two different stanzas.
> > 
> > > To summarize,
> > >
> > > 1. A process can open an RDMA resource (such as a raw QP, raw flow
> > > entry, or similar 'raw' resource) through the fd using ioctl(), if it has the
> > appropriate capability, which in this case is CAP_NET_RAW.
> > 
> > Why does it need CAP_NET_RAW to create the resource, if the resource won't
> > be usable by a process without CAP_NET_RAW later anyway?  
> Once the resource is created, and the fd is shared (like a raw socket fd), it will be usable by a process without CAP_NET_RAW.
> Is that a concern? If yes, how is it solved for raw socket fd? It appears to me that it is not.
> 
> > Is that legacy
> > for the read/write (vs ioctl) case?  
> No.
> 
> > Or is it to limit the number of opened
> > resources?  Or some other reason?
> > 
> The resource enables to do raw operation, hence the capability check of the process for having NET_RAW cap.

Ok, so it seems to me that

1. the create should check ns_capable(current->nsproxy->net->user_ns, CAP_NET_RAW)
2. the read/write are a known escape, eventually to be removed?
3. the ioctl should check file_ns_capable(attrs->ufile->filp->f_cred->user_ns, CAP_NET_RAW)

Two notes about (3).  First, note that it's different from what you had.
It explicitly checks that the caller has CAP_NET_RAW against the net
namespace that was used to open the file.  Second, I'm suggesting this
because Jason does keep saying that ioctl is supposed to solve the
missing permission check.  If it really is felt that no permission
check should be needed, that's a different discussion.  I've just been
trying to figure out where the state should be tracked.

-serge

