Return-Path: <linux-rdma+bounces-9802-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BCEA9CC6A
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 17:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61D0F164F5C
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 15:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE4125E446;
	Fri, 25 Apr 2025 15:06:47 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDFB25D20D;
	Fri, 25 Apr 2025 15:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745593607; cv=none; b=ZeDcwJNhZEgj/ZA6JNfwV7YkrQn27ecz6yGm7zZA1q7D7u4YbZix4UM2nRf5WrzHSpgOMEKXcTgJB4dXtTq6iLOC1J1BI2QAXCZLx/t9Tm4zX9SLmOT0zOkM0jrX4aOOVbJDbuXPlQkXfg8Vr8fi8PFU60J7347QnAs4jp0EYGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745593607; c=relaxed/simple;
	bh=vEoa5dsPn71G1W4c2JGKfGj3GBfZHpQXJMOgeQ8CK1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=neTZL9muGSP9ux72AlJyquSQGY/M7+SwcGSsHBL6jytByz1cNpr3s7u6HhCNYa6Py8e/6sCT9gG5YKeAqofPZI49jyUtEOFA11qA7dSEC5c2V+JOEgBHaftJDysVJ+NT4Tqho/3/3t+Z8W8yuPL/V1tawAYKt9SogkBIxyjmmH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 9BB411AA1; Fri, 25 Apr 2025 10:06:41 -0500 (CDT)
Date: Fri, 25 Apr 2025 10:06:41 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Parav Pandit <parav@nvidia.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Message-ID: <20250425150641.GA610929@mail.hallyn.com>
References: <20250423144649.GA1743270@nvidia.com>
 <87msc6khn7.fsf@email.froward.int.ebiederm.org>
 <CY8PR12MB71955CC99FD7D12E3774BA54DCBA2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250423164545.GM1648741@nvidia.com>
 <CY8PR12MB7195D5ED46D8E920A5281393DC852@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250424141347.GS1648741@nvidia.com>
 <CY8PR12MB7195F2A210D670E07EC14DE9DC842@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250425132930.GB1804142@nvidia.com>
 <20250425140144.GB610516@mail.hallyn.com>
 <20250425142429.GC1804142@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425142429.GC1804142@nvidia.com>

On Fri, Apr 25, 2025 at 11:24:29AM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 25, 2025 at 09:01:44AM -0500, Serge E. Hallyn wrote:
> > On Fri, Apr 25, 2025 at 10:29:30AM -0300, Jason Gunthorpe wrote:
> > > On Fri, Apr 25, 2025 at 01:14:35PM +0000, Parav Pandit wrote:
> > > 
> > > > 1. In uobject creation syscall, I will add the check current->nsproxy->net->user_ns capability using ns_capable().
> > > > And we don't hold any reference for user ns.
> > > 
> > > This is the thing that makes my head ache.. Is that really the right
> > > way to get the user_ns of current? Is it possible that current has
> > > multiple user_ns's? We are picking nsproxy because ib_dev has a net
> > > namespace affiliation?
> > 
> > It's not that "current has multiple user_ns's", it's that the various
> > resources, including other namespaces, which current has or belongs
> > to have associated namespaces.
> 
> That seems like splitting nits. Can I do current->XXX->user_ns and get
> different answers? Sounds like yes?

I don't think it's splitting nits.  current->nsproxy->net_ns->user_ns
is not current's user namespace.

> > current_user_ns() is the user namespace to which current belongs.
> > But if you want to check if it can have privilege over a resource,
> > you have to check whether current has ns_capable(resource->userns, CAP_X).
> 
> So what is the resource here?

That's what I've been trying to get answered :)

> It is definitely not the file descriptor.
> 
> Is it the kernel's struct ib_device? It has a netns that is captured
> at its creation time.

I think that's what you suggested before, and it sounds like the
right answer to me.

