Return-Path: <linux-rdma+bounces-9168-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED8EA7CE70
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Apr 2025 16:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2CB83ADB9D
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Apr 2025 14:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C33D21883F;
	Sun,  6 Apr 2025 14:23:33 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B44D28373;
	Sun,  6 Apr 2025 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743949412; cv=none; b=p6kUpZbpTJXeiKiT4N6YjnZcGanMa0PQvpQ3WrJv7LNv+hHfFc000DQ67aL/mTpCowb74BwIO2pYJVNZl8j/hICmb572UykpWoZ9Dn0mU2vMGJFYxXUXjPK0BAaVgi+tiQhCjUPFHqmZ3qB4EVs30RFiFqMCEu+8b4papk9ZH2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743949412; c=relaxed/simple;
	bh=Sugg6vXRZWEHMje5mnBq1cZ/jDPpChJwmNu+T5NdV1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPe0f96gHKmdb+Xc/opkf3MuZ/KQbff/9u/17nHjKzOzm5UgK2akU74mgUlLkpWKxRAgWmhNS3v9Mz7d8pOYHzMaD7LhfsR2vToRgduSS82fVaek4LcBCfisdkS1aWCLCvnNrGybjNCHqqn2r+HSibfiZDAI8SbnP7Ti3iYJOLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id E809EE01; Sun,  6 Apr 2025 09:15:01 -0500 (CDT)
Date: Sun, 6 Apr 2025 09:15:01 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	"serge@hallyn.com" <serge@hallyn.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Message-ID: <20250406141501.GA481691@mail.hallyn.com>
References: <20250313050832.113030-1-parav@nvidia.com>
 <20250317193148.GU9311@nvidia.com>
 <CY8PR12MB7195C6D8CCE062CFD9D0174CDCDE2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250318112049.GC9311@nvidia.com>
 <87ldt2yur4.fsf@email.froward.int.ebiederm.org>
 <20250318225709.GC9311@nvidia.com>
 <CY8PR12MB7195B7FAA54E7E0264D28BAEDCA92@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250404151347.GC1336818@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404151347.GC1336818@nvidia.com>

On Fri, Apr 04, 2025 at 12:13:47PM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 04, 2025 at 02:53:30PM +0000, Parav Pandit wrote:
> > To summarize,
> > 
> > 1. A process can open an RDMA resource (such as a raw QP, raw flow entry, or similar 'raw' resource)
> > through the fd using ioctl(), if it has the appropriate capability, which in this case is CAP_NET_RAW.
> > This is similar to a process that opens a raw socket.
> > 
> > 2. Given that RDMA uses ioctl() for resource creation, there isn't a security concern surrounding
> > the read()/write() system calls.
> > 
> > 3. If process A, which does not have CAP_NET_RAW, passes the opened fd to another privileged
> > process B, which has CAP_NET_RAW, process B can open the raw RDMA resource.
> > This is still within the kernel-defined security boundary, similar to a raw socket.
> > 
> > 4. If process A, which has the CAP_NET_RAW capability, passes the file descriptor to Process B, which does not have CAP_NET_RAW, Process B will not be able to open the raw RDMA resource.
> > 
> > Do we agree on this Eric?
> 
> This is our model, I consider it uAPI, so I don't belive we can change
> it without an extreme reason..
> 
> > 5. the process's capability check should be done in the right user namespace.
> > (instead of current in default user ns).
> > The right user namespace is the one which created the net namespace.
> > This is because rdma networking resources are governed by the net namespace.
> 
> This all makes my head hurt. The right user namespace is the one that
> is currently active for the invoking process, I couldn't understand
> why we have net namespaces refer to user namespaces :\

A user at any time can create a new user namespace, without creating a
new network namespace, and have privilege in that user namespace, over
resources owned by the user namespace.

So if a user can create a new user namespace, then say "hey I have
CAP_NET_ADMIN over current_user_ns, so give me access to the RDMA
resources belonging to my current_net_ns", that's a problem.

So that's why the check should be ns_capable(device->net->user-ns, CAP_NET_ADMIN)
and not ns_capable(current_user_ns, CAP_NET_ADMIN).

-serge

