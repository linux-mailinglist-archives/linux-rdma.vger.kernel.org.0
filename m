Return-Path: <linux-rdma+bounces-9835-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15041A9E392
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Apr 2025 16:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F2467AB60F
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Apr 2025 14:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E3613633F;
	Sun, 27 Apr 2025 14:31:09 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAA3440C;
	Sun, 27 Apr 2025 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745764268; cv=none; b=lHQhvZruXYtGaVh0rknE54JS7PaAuGPfy3p26+CKTPcaUR7/um/8NFp27bxXbzq+uWD32ign8wMyM31Jn/fsgBbpsseLMhgl8mUyGESQFPxmCdiRyPaDPE14w4CiL0M2MUr/E0anFXE5JszNblb0gZ+3ISIK7dBu/vrXrASmsW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745764268; c=relaxed/simple;
	bh=bYfd+KEj6odgTjCh3IeEijxIjewlcPFewJK9LEdoVYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOTs9WW0qB9w86XN04AR10HN1OiqnDxmj5rNgYN5tEc6ndWpNo++eGh4irN4ox+ifxM+dkltfrNJY3sAdgBDy+4VwXz3eH1vuaBNXRHenMhJAe6+ygSB46rlXSMQyBrfCZcB1Kjwn+DHsMX8SNSovV/O5bjTCcrfN1UKFU6wpus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 90020E3F; Sun, 27 Apr 2025 09:30:58 -0500 (CDT)
Date: Sun, 27 Apr 2025 09:30:58 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Parav Pandit <parav@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Message-ID: <20250427143058.GA622212@mail.hallyn.com>
References: <CY8PR12MB7195D5ED46D8E920A5281393DC852@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250424141347.GS1648741@nvidia.com>
 <CY8PR12MB7195F2A210D670E07EC14DE9DC842@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250425132930.GB1804142@nvidia.com>
 <20250425140144.GB610516@mail.hallyn.com>
 <20250425142429.GC1804142@nvidia.com>
 <87h62ci7ec.fsf@email.froward.int.ebiederm.org>
 <20250425162102.GA2012301@nvidia.com>
 <875xisf8ma.fsf@email.froward.int.ebiederm.org>
 <20250425183529.GB2012301@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425183529.GB2012301@nvidia.com>

On Fri, Apr 25, 2025 at 03:35:29PM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 25, 2025 at 12:34:21PM -0500, Eric W. Biederman wrote:
> > > What about something like CAP_SYS_RAWIO? I don't think we would ever
> > > make that a per-userns thing, but as a thought experiment, do we check
> > > current->XXX->user_ns or still check ibdev->netns->XX->user_ns?
> > >
> > 
> > Oh.  CAP_SYS_RAWIO is totally is something you can have.  In fact
> > the first process in a user namespace starts out with CAP_SYS_RAWIO.
> > That said it is CAP_SYS_RAWIO with respect to the user namespace.
> > 
> > What would be almost certainly be a bug is for any permission check
> > to be relaxed to ns_capable(resource->user_ns, CAP_SYS_RAWIO).
> 
> So a process "has" it but the kernel never accepts it?

Capabilities are targeted at some resource.  Sometimes the resource is
global, or always belongs to the initial user namespace.  In the case
of rawio, if ever "device namespaces" became acceptable, then it could
in fact become namespaced for some resources.

-serge

