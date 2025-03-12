Return-Path: <linux-rdma+bounces-8602-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E661EA5DB92
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 12:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3374179FB9
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 11:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3DD23F367;
	Wed, 12 Mar 2025 11:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTnt6cCW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1953623ED53;
	Wed, 12 Mar 2025 11:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778966; cv=none; b=dazGIHKwsEbdQzMmDEVXiVDWhliVy78dORgmj7SACmRz/8OK+Yr5rklyVs3kj6qy3ez3LhDwctJXzudw4TUlo70XvA/D2OaNN5ItMvWxE3sIoT682c3icC7sfQ8klzr76T5ASGufPtactnI6qLGK5qjdmM/MJsjaAkHKreHccHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778966; c=relaxed/simple;
	bh=X8m4316G0jDZ5cVcpcX1mu6HUGAKasmBGoCf8c6/wsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pasoElae5H5R36kreU3Xig3Kf4mWinW6cW53Yej4bze3T0U5iFaxGilVqYYFz4sJPQj8SnHg/NDQ53E8ObtCDhb+KEibWeGuKkvLooIxr+V5GYAPOYAIZvV/hVxNI0zu4GfOGvzNf9Ecz9HHfBn+wIncbuC1wv703BHm7ZEg87g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTnt6cCW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8963C4CEE3;
	Wed, 12 Mar 2025 11:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741778965;
	bh=X8m4316G0jDZ5cVcpcX1mu6HUGAKasmBGoCf8c6/wsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NTnt6cCW0mQHh2ti50/2U21x5g91lNcNemZBvH2WhSRnt3QXBxrC1co7vd9fMmDaX
	 dPBytZgvnlI+FMjF8Lw+RHgT5E59iqXFI63DL948KJiOgMuzDGs17iykXsls4p6p66
	 JebYI6uEHJ+rxEGQEqKPEqoFPZWGwDbqgggMcY8YVyEZZ460CreSmrwYCXoN2vC3qx
	 rXihxIc+HUnev1ep2OE1N/NNHEz1g+aolFzXYXDoZVJdTRjvjjy4wkwuAnYvD3lIuZ
	 CR48u5Km+HqyP9Nhi0L199oCo2OEELZiVmRx2qVC3RJRdFi3kNzs2LFbqtxEUsmDFG
	 vwVLmApvj33Gg==
Date: Wed, 12 Mar 2025 13:29:21 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Nikolay Aleksandrov <nikolay@enfabrica.net>
Cc: netdev@vger.kernel.org, shrijeet@enfabrica.net, alex.badea@keysight.com,
	eric.davis@broadcom.com, rip.sohan@amd.com, dsahern@kernel.org,
	bmt@zurich.ibm.com, roland@enfabrica.net, winston.liu@keysight.com,
	dan.mihailescu@keysight.com, kheib@redhat.com,
	parth.v.parikh@keysight.com, davem@redhat.com, ian.ziemba@hpe.com,
	andrew.tauferner@cornelisnetworks.com, welch@hpe.com,
	rakhahari.bhunia@keysight.com, kingshuk.mandal@keysight.com,
	linux-rdma@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Message-ID: <20250312112921.GA1322339@unreal>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250308184650.GV1955273@unreal>
 <2f06a40d-2f14-439a-9c95-0231dce5772d@enfabrica.net>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f06a40d-2f14-439a-9c95-0231dce5772d@enfabrica.net>

On Wed, Mar 12, 2025 at 11:40:05AM +0200, Nikolay Aleksandrov wrote:
> On 3/8/25 8:46 PM, Leon Romanovsky wrote:
> > On Fri, Mar 07, 2025 at 01:01:50AM +0200, Nikolay Aleksandrov wrote:
> >> Hi all,
> > 
> > <...>
> > 
> >> Ultra Ethernet is a new RDMA transport.
> > > Awesome, and now please explain why new subsystem is needed when
> > drivers/infiniband already supports at least 5 different RDMA
> > transports (OmniPath, iWARP, Infiniband, RoCE v1 and RoCE v2).
> > 
> 
> As Bernard commented, we're not trying to add a new subsystem, 

So why did you create new drivers/ultraeth/ folder?

> but start a discussion on where UEC should live because it has multiple
> objects and semantics that don't map well to the  current
> infrastructure. For example from this set - managing contexts, jobs and
> fabric endpoints. 

It is just different names which libfabric used to do not use
traditional verbs naming. There is nothing in the stack which prevents
from QP to have same properties as "fabric endpoints" have.

> Also we have the ephemeral PDC connections
> that come and go as needed. There more such objects coming with more
> state, configuration and lifecycle management. That is why we added a
> separate netlink family to cleanly manage them without trying to fit
> a square peg in a round hole so to speak.

Yeah, I saw that you are planning to use netlink to manage objects,
which is very questionable. It is slow, unreliable, requires sockets,
needs more parsing logic e.t.c

To avoid all this overhead, RDMA uses netlink-like ioctl calls, which
fits better for object configurations.

Thanks

