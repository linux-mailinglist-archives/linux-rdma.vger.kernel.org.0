Return-Path: <linux-rdma+bounces-9798-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E59A9CB01
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 16:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 022124C4895
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 14:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E882E24C07A;
	Fri, 25 Apr 2025 14:01:48 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D37813633F;
	Fri, 25 Apr 2025 14:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745589708; cv=none; b=ePVxNtz21sF2vdlRH2MfDFFW4R2MnUNSV+pwxk9zBQG6ztXy9eUTAnNYVHazoH6Zs2oEZQ+9jyahAMFp2aJ9ZyfK6ydIEBUXdM+5bAaH84Hvb/2VOs1+xgfBlq8wyxJoPuDazjhtCBiuoPIAr5b6psk0+MsDP2TTFykMHK/L8bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745589708; c=relaxed/simple;
	bh=w64cYSt00r5022eV674KzPKerX5xhkTxo7l086cssQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smB7u/EdX4bjvRpjqUZMbuT9PUdoUSW2q9ZqD1jkccDrqmVjJq8/MxSzdINAf8tAs7E2soQrqmXZwCmvJgwFVl5fHzzKTPh6iGLQVJ1W6aQhHUkMZ00KaOGHB6vROEoQQ+Lv44ndXcXSUbzG5bug3llYJQjUWL7dLK+0V9HKE/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 2EB501568; Fri, 25 Apr 2025 09:01:44 -0500 (CDT)
Date: Fri, 25 Apr 2025 09:01:44 -0500
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
Message-ID: <20250425140144.GB610516@mail.hallyn.com>
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

It's not that "current has multiple user_ns's", it's that the various
resources, including other namespaces, which current has or belongs
to have associated namespaces.

current_user_ns() is the user namespace to which current belongs.
But if you want to check if it can have privilege over a resource,
you have to check whether current has ns_capable(resource->userns, CAP_X).

-serge

