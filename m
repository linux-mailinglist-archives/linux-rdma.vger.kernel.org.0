Return-Path: <linux-rdma+bounces-9797-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 423D7A9CAF3
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 15:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83FB01BC79AD
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 13:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F5724EABD;
	Fri, 25 Apr 2025 13:59:30 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C8A1E871;
	Fri, 25 Apr 2025 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745589570; cv=none; b=anH7VdEmwB8ggq7aVwn7wqmPJc+J5fyCd+XOi70g7dphA4EhDgFEZYbMKmUDbZYcIiv3pQnanNCcvNaWjQ9ejcwR1TkiVP7cI7tZ3RDTrejJ55dpCK6pG2soejWI9CEmEhGCFOlEg6ikW+g+iBoDQqYW+hSkSwPD4elo6udeZyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745589570; c=relaxed/simple;
	bh=JIMy8NhGVbf/kBo6vA6fCBd2yh+49q39jIVG9+0mC+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mU/x9tirmnnq1egFnnbNmH1rhxOkxKTQoVCVf8T/OnYpcOH8xCY5Pu9exRvjzzHeK6/LpuUZMXGsDEAV29XU1Wpr6Jx0mt9ux94KlYByO6Jop0yC9r9OTkdorrKu+gClmKaz+x0VCibDZokHZ7Kxulkl1xNY+QZFbSaYAx7TxGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 86A9218AF; Fri, 25 Apr 2025 08:59:19 -0500 (CDT)
Date: Fri, 25 Apr 2025 08:59:19 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Message-ID: <20250425135919.GA610516@mail.hallyn.com>
References: <20250422162943.GA589534@mail.hallyn.com>
 <CY8PR12MB71955B492640B228145DB9CFDCBA2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250423144649.GA1743270@nvidia.com>
 <87msc6khn7.fsf@email.froward.int.ebiederm.org>
 <CY8PR12MB71955CC99FD7D12E3774BA54DCBA2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250423164545.GM1648741@nvidia.com>
 <CY8PR12MB7195D5ED46D8E920A5281393DC852@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250424141347.GS1648741@nvidia.com>
 <CY8PR12MB7195F2A210D670E07EC14DE9DC842@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250425132930.GB1804142@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425132930.GB1804142@nvidia.com>

On Fri, Apr 25, 2025 at 10:29:30AM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 25, 2025 at 01:14:35PM +0000, Parav Pandit wrote:
> 
> > 1. In uobject creation syscall, I will add the check current->nsproxy->net->user_ns capability using ns_capable().
> > And we don't hold any reference for user ns.
> 
> This is the thing that makes my head ache.. Is that really the right
> way to get the user_ns of current? Is it possible that current has
> multiple user_ns's? We are picking nsproxy because ib_dev has a net
> namespace affiliation?

It's making my head ache too, but I think for slightly different reason.
If the device is not going to be tied to a network or user namespace yet,
as I believe Parav is saying, than what on earth are we checking caps for
at all?  With capable(CAP_NET_X) it makes sense since that is system wide.
But if the check is going to be against a namespace, then it seems
meaningless.  AFAICS I can just create a new userns and a new empty netns,
create the resource with the privilege I have, then use that resource from
the init_net_ns/init_user_ns.

Even if there will be subsequent checks when using it, the question remains
what was the point of the check at creation time.

IMO either the net or the user_ns needs to be stashed at creation time,
because that's the thing to which access has been granted.

> > This will be only done for the selected objects who need cap enforcement.
> > Can we proceed with this for user ns cap enforcement?
> > 
> > 2. For net ns protection in exclusive mode, few enforcements to be done for 
> > ib device modify_qp, sysfs, gid query. This will be a separate, unrelated patch(es) to user ns.
> > 
> > 3. Do not enforce things in shared net ns mode.
> > 
> > For #1 and #2, will send two different patch set.
> > 
> > Does this path look ok?
> 
> Yes
> 
> Jason

