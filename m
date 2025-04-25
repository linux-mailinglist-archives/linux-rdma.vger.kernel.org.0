Return-Path: <linux-rdma+bounces-9804-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD850A9CCFA
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 17:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5D121BC5414
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 15:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D61F2749C3;
	Fri, 25 Apr 2025 15:29:55 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE14288C82;
	Fri, 25 Apr 2025 15:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745594995; cv=none; b=OvSBcL9EjRWj9/vT4nD5C4nIIvXYgEl1dilEZAH8aZw9F7cw7ooLmZr/Fu0FTHz0hLHJWvYxNjVnlrd5oBtvacZbb090zKQj6FYOTHaaFWDPow/jXVc67KPZ6YiQlLT3ZAVwZv2QIjv61RCVC/Ccg0Eo574EgNYUr25Cm3pvYY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745594995; c=relaxed/simple;
	bh=cahLZq44VuAeI8eyMNQhM5Md4TaATk4bH8HMgLN22nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3PWaQfOyxk/sHglSex4GpIf+Ab0n8tD65jRH6XryH0B7+GLdOpH4t+c/d51wIMDeYwaqkenFC5SjDwtGHJKai6+K2RsDbWhzscfGlbs6Fb9iSD3NjpNuu/qIPud2rCPdT46lsVZRNxBuxtDz7jYcN6tao2MhSA5PP1DnzM4w6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id D9D471568; Fri, 25 Apr 2025 10:29:49 -0500 (CDT)
Date: Fri, 25 Apr 2025 10:29:49 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Jason Gunthorpe <jgg@nvidia.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Message-ID: <20250425152949.GA611176@mail.hallyn.com>
References: <87msc6khn7.fsf@email.froward.int.ebiederm.org>
 <CY8PR12MB71955CC99FD7D12E3774BA54DCBA2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250423164545.GM1648741@nvidia.com>
 <CY8PR12MB7195D5ED46D8E920A5281393DC852@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250424141347.GS1648741@nvidia.com>
 <CY8PR12MB7195F2A210D670E07EC14DE9DC842@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250425132930.GB1804142@nvidia.com>
 <PH8PR12MB720834D2635090B376790F30DC842@PH8PR12MB7208.namprd12.prod.outlook.com>
 <20250425140642.GC610516@mail.hallyn.com>
 <PH8PR12MB720830D473CE31DB24BF36A5DC842@PH8PR12MB7208.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH8PR12MB720830D473CE31DB24BF36A5DC842@PH8PR12MB7208.namprd12.prod.outlook.com>

On Fri, Apr 25, 2025 at 03:05:06PM +0000, Parav Pandit wrote:
> 
> 
> > From: Serge E. Hallyn <serge@hallyn.com>
> > Sent: Friday, April 25, 2025 7:37 PM
> > 
> > On Fri, Apr 25, 2025 at 01:54:07PM +0000, Parav Pandit wrote:
> > >
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > Sent: Friday, April 25, 2025 7:00 PM
> > > >
> > > > On Fri, Apr 25, 2025 at 01:14:35PM +0000, Parav Pandit wrote:
> > > >
> > > > > 1. In uobject creation syscall, I will add the check
> > > > >current->nsproxy->net- user_ns capability using ns_capable().
> > > > > And we don't hold any reference for user ns.
> > > >
> > > > This is the thing that makes my head ache.. Is that really the right
> > > > way to get the user_ns of current?
> > >
> > > > Is it possible that current has multiple user_ns's?
> > > I don't think so.
> > >
> > > > We
> > > > are picking nsproxy because ib_dev has a net namespace affiliation?
> > > >
> > > Yes.
> > >
> > > After ruling out file's user ns, I believe there are two user ns.
> > >
> > > 1. current_user_ns()
> > > 2. current->nsproxy->net->user_ns.
> > >
> > > In most cases #1 and #2 should be same to my knowledge.
> > >
> > > When/if user wants to do have nested user ns, and don't want to create a
> > new net ns, #2 can be of use.
> > > For example,
> > > a. Process1 starts in user_ns_1 which created net_ns_1 b. rdma device
> > > is in net_ns_1 c. Process1 unshare and moves to user_ns_2.
> > > d. For some reason user_ns_2 does not have the cap.
> > 
> > (d) is important.  "user_ns_2 does not have the cap" is imprecise.  Process1
> > after the unshare does have the cap against user_ns_2.  It does not have it
> > against user_ns_1, and since net_ns_1->user_ns == user_ns_1, that means it
> > loses privilege over net_ns_1.  Which is what we need.  Because otherwise, an
> > unprivileged user could simply unshare the user_ns, be root there, and now
> > tweak networking.
> >
> Effectively, since process_1 lost the privilege in user_ns_1 after step #c, 
> if user wants to tweak networking, it must have a rdma device in net_ns_2, created by the user_ns_2.
> Right?

Right.

