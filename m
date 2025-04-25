Return-Path: <linux-rdma+bounces-9799-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 338A2A9CB19
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 16:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B65A4E2ECA
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 14:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81510252914;
	Fri, 25 Apr 2025 14:06:48 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF5118DF8D;
	Fri, 25 Apr 2025 14:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745590008; cv=none; b=nPGKF5h+j3W6b3aarCvFK10LtE+c6wbcZfqOr9irAWiF53avtewzomJa7EskesTTp/wNk+dWQK3FkK0U560FghTVjm+oFbaosrYEbShCTTuPPksbqI/P3MllCMRAN/A9LawBrfmgzTpEdRbMINrNm/A7UeLCuHKGpzHsGEvjTFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745590008; c=relaxed/simple;
	bh=wXyoLMr08KlATGSloYX71GpnuF8QWJr2EehJzhVeZKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuZcZQ4jr24dETSAJJRrTFTOiXF5ShWVCRm8ZBIdM0kzfJW96XzcBqBrd1hv4hygnHb3OZW2Lutx15o0Es84fK6X14Eemj4Ky1tTHn54thpDebR04cbYTf7GYfIofzdWvDa/hFM65AUF8i3GfRPh9L5mn1B4jmZTXX6i5Cy2Yvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 4973D1AA1; Fri, 25 Apr 2025 09:06:42 -0500 (CDT)
Date: Fri, 25 Apr 2025 09:06:42 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Message-ID: <20250425140642.GC610516@mail.hallyn.com>
References: <CY8PR12MB71955B492640B228145DB9CFDCBA2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250423144649.GA1743270@nvidia.com>
 <87msc6khn7.fsf@email.froward.int.ebiederm.org>
 <CY8PR12MB71955CC99FD7D12E3774BA54DCBA2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250423164545.GM1648741@nvidia.com>
 <CY8PR12MB7195D5ED46D8E920A5281393DC852@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250424141347.GS1648741@nvidia.com>
 <CY8PR12MB7195F2A210D670E07EC14DE9DC842@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250425132930.GB1804142@nvidia.com>
 <PH8PR12MB720834D2635090B376790F30DC842@PH8PR12MB7208.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH8PR12MB720834D2635090B376790F30DC842@PH8PR12MB7208.namprd12.prod.outlook.com>

On Fri, Apr 25, 2025 at 01:54:07PM +0000, Parav Pandit wrote:
> 
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Friday, April 25, 2025 7:00 PM
> > 
> > On Fri, Apr 25, 2025 at 01:14:35PM +0000, Parav Pandit wrote:
> > 
> > > 1. In uobject creation syscall, I will add the check current->nsproxy->net-
> > >user_ns capability using ns_capable().
> > > And we don't hold any reference for user ns.
> > 
> > This is the thing that makes my head ache.. Is that really the right way to get
> > the user_ns of current? 
> 
> > Is it possible that current has multiple user_ns's? 
> I don't think so.
> 
> > We
> > are picking nsproxy because ib_dev has a net namespace affiliation?
> > 
> Yes.
> 
> After ruling out file's user ns, I believe there are two user ns.
> 
> 1. current_user_ns() 
> 2. current->nsproxy->net->user_ns.
> 
> In most cases #1 and #2 should be same to my knowledge.
> 
> When/if user wants to do have nested user ns, and don't want to create a new net ns, #2 can be of use.
> For example,
> a. Process1 starts in user_ns_1 which created net_ns_1
> b. rdma device is in net_ns_1
> c. Process1 unshare and moves to user_ns_2.
> d. For some reason user_ns_2 does not have the cap.

(d) is important.  "user_ns_2 does not have the cap" is imprecise.  Process1
after the unshare does have the cap against user_ns_2.  It does not have
it against user_ns_1, and since net_ns_1->user_ns == user_ns_1, that
means it loses privilege over net_ns_1.  Which is what we need.  Because
otherwise, an unprivileged user could simply unshare the user_ns, be root
there, and now tweak networking.

This all stems from the original requirements for user namespaces, which
were (off top of my head)

* unprivileged users must be able to create user namespaces
* root in a user namespace must be privileged over its resources
* root in a user namespace must have no privilege over any other resources
* user namespaces must nest

> By current UTS and other namespace semantics, since rdma device belongs to net ns, net ns's creator user ns to be considered.
> 
> I am unsure if doing #1 breaks any existing model.
> I like to get Eric/Serge's view also, if we should consider #1 or #2.

