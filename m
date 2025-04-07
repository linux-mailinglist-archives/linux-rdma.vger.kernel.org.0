Return-Path: <linux-rdma+bounces-9189-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BF2A7E2B4
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 16:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5193C189E718
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 14:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337361DE3DE;
	Mon,  7 Apr 2025 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pztw6+Ex"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E312F1DDA3B;
	Mon,  7 Apr 2025 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744037213; cv=none; b=aDf9StpoQp5Sp1H+v5cASxkA/3kVUmQ8m5oApJm53H7ddVHR+fRRa7oc9iGvlJNAChsvmA+J/mJGZIFaKyaVGIcobvAT377bsetw2Lu2K3/XBt6Pw9FY96X75lsk2WGnfHNDlYQ5XzNeQ48/w4IIwPKMhIGxzj+BaELMZYRAgt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744037213; c=relaxed/simple;
	bh=p1eVAzG+8xOim4ZgZnOK2ftUMMgt+j3kY6EUzbCT8r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpqyXiz8TFQofZ7ZcgdAhyGGWpkfFepjgP8a/5A1SglnHlBEvseNgHa4d0D8iB+xL4/uAXDhjBMWMvRwdRb2tmJfpbB2PUemRb7mOAXWj7rIkIGuFsKT+wB07mgmY481q4DsQYGN9u9Ax6aJxk/82NJ+BukrewrkCa6nwhXaeKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pztw6+Ex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37843C4CEDD;
	Mon,  7 Apr 2025 14:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744037212;
	bh=p1eVAzG+8xOim4ZgZnOK2ftUMMgt+j3kY6EUzbCT8r0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pztw6+ExuTkPDHHv4WZIuSCUCEUI47SWBRG2g6zJ8fo4hT1zGSKY+zt8XDn02Yhia
	 pQZ/FI3CXyMMJIi6ih0uCPMjJ1h3E3ao+dbc8aJZYMI3l5+iOEXo+4jI8n9rtuncyZ
	 pcIuioa1e2BkKw5gNj0uj4Bt4A5as7AvyJX1DKiPULTr2iQgYJeAjHzrONNRCI/ebF
	 p2C4lwahClCKOyZAO06S8yQR79WiAgRqkxCFGJ7XzZcfqrr2Sk09MfGF5EPEHQWgn6
	 CYQwM6pWqSB7ONJ2KYJWOPW586CuLzByFAwyvEJwSa749SR8oF5XGiQ++vnwVhRe2O
	 XS849ey0Vhu8Q==
Date: Mon, 7 Apr 2025 14:46:48 +0000
From: sergeh@kernel.org
To: Parav Pandit <parav@nvidia.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Jason Gunthorpe <jgg@nvidia.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Message-ID: <Z_PlWIj3N2L6nPaD@lei>
References: <20250313050832.113030-1-parav@nvidia.com>
 <20250317193148.GU9311@nvidia.com>
 <CY8PR12MB7195C6D8CCE062CFD9D0174CDCDE2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250318112049.GC9311@nvidia.com>
 <87ldt2yur4.fsf@email.froward.int.ebiederm.org>
 <20250318225709.GC9311@nvidia.com>
 <CY8PR12MB7195B7FAA54E7E0264D28BAEDCA92@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250404151347.GC1336818@nvidia.com>
 <20250406141501.GA481691@mail.hallyn.com>
 <CY8PR12MB7195987AD22775DBBA7FD3B5DCAA2@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB7195987AD22775DBBA7FD3B5DCAA2@CY8PR12MB7195.namprd12.prod.outlook.com>

On Mon, Apr 07, 2025 at 11:16:35AM +0000, Parav Pandit wrote:
> > From: Serge E. Hallyn <serge@hallyn.com>
> > Sent: Sunday, April 6, 2025 7:45 PM
> > 
> > On Fri, Apr 04, 2025 at 12:13:47PM -0300, Jason Gunthorpe wrote:
> > > On Fri, Apr 04, 2025 at 02:53:30PM +0000, Parav Pandit wrote:
> > > > To summarize,
> > > >
> > > > 1. A process can open an RDMA resource (such as a raw QP, raw flow
> > > > entry, or similar 'raw' resource) through the fd using ioctl(), if it has the
> > appropriate capability, which in this case is CAP_NET_RAW.
> > > > This is similar to a process that opens a raw socket.
> > > >
> > > > 2. Given that RDMA uses ioctl() for resource creation, there isn't a
> > > > security concern surrounding the read()/write() system calls.
> > > >
> > > > 3. If process A, which does not have CAP_NET_RAW, passes the opened
> > > > fd to another privileged process B, which has CAP_NET_RAW, process B
> > can open the raw RDMA resource.
> > > > This is still within the kernel-defined security boundary, similar to a raw
> > socket.
> > > >
> > > > 4. If process A, which has the CAP_NET_RAW capability, passes the file
> > descriptor to Process B, which does not have CAP_NET_RAW, Process B will
> > not be able to open the raw RDMA resource.
> > > >
> > > > Do we agree on this Eric?
> > >
> > > This is our model, I consider it uAPI, so I don't belive we can change
> > > it without an extreme reason..
> > >
> > > > 5. the process's capability check should be done in the right user
> > namespace.
> > > > (instead of current in default user ns).
> > > > The right user namespace is the one which created the net namespace.
> > > > This is because rdma networking resources are governed by the net
> > namespace.
> > >
> > > This all makes my head hurt. The right user namespace is the one that
> > > is currently active for the invoking process, I couldn't understand
> > > why we have net namespaces refer to user namespaces :\
> > 
> > A user at any time can create a new user namespace, without creating a new
> > network namespace, and have privilege in that user namespace, over
> > resources owned by the user namespace.
> >
>  
> > So if a user can create a new user namespace, then say "hey I have
> > CAP_NET_ADMIN over current_user_ns, so give me access to the RDMA
> > resources belonging to my current_net_ns", that's a problem.
> > 
> > So that's why the check should be ns_capable(device->net->user-ns,
> > CAP_NET_ADMIN) and not ns_capable(current_user_ns, CAP_NET_ADMIN).
> >
> Given the check is of the process (and hence user and net ns) and not of the rdma device itself,
> Shouldn't we just check,
> 
> ns_capable(current->nsproxy->user_ns, ...)
> 
> This ensures current network namespace's owning user ns is consulted.

No, it does not.  If I do

unshare -U

then current->nsproxy->user_ns is not my current network namespace's
owning user ns.

-serge

