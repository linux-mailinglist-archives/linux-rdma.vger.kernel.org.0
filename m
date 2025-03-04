Return-Path: <linux-rdma+bounces-8341-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 546B1A4EFD1
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 23:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3D6F3A9CF1
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 22:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC9F2780FF;
	Tue,  4 Mar 2025 21:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="iBT2le/I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE086205504;
	Tue,  4 Mar 2025 21:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741125509; cv=none; b=agt9f2N+hBEMQJ8RwZm1GC1E5nfy8E/+5kaiYWKlIoVCZLoctDxMewQnaisPfX3VmMbk7A6+91S+m65UFTuuH+v7mHGSaSAD95Wz9H+O45ARj2KvOEhrg5ZvnWcFBJCSZ+SZQDTvsm9nNCvfQjegeY8USoOfLNFCW6JVjVegknI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741125509; c=relaxed/simple;
	bh=TMlksZzv83xFhnmFmHf1x6cC5xuOgA97gfVRTau2XgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byMcJx58nyS977VdXYE6OKvXgLKwKRCVeBHwZChyX2yKLMdyYq2d2srVPiCBnmVrb5rLBgVBKXRcEVarRIYW2P22ujQ7z1VzI3i2x/qaUSpxwXXPQhNRxjVV5ZUhbwixxl+JI8KpFtmNDyfY3mNEx3A88UHOY5hJfXVIsUQctQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=iBT2le/I; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=aW049IGYYYQnkgsaSZDSTSt2lO77sxxRkP5Vk4xaKVA=; b=iBT2le/InmCDpCNj
	EMQAqniv60dz6rEXiNJXv6XBSSJE2/dIjroElmW2OU0niqb843W5smvgaoUVCGgMQbDvPGurXpWh7
	kgZRQ8fUlhzU826+tGHqZWTTzOehHzYKINTeFSBT2donHmaJ2qBRAR/xvkmskoEVX40teBgG6RV4u
	cO+e2sEH5TczKdEa1D6t1/pjNzRJpv17eUcur+RIi3cqClzg/Ni9oR/+Cd8dNFPSbttkPnRUVfBy+
	dd3M5XaGA7aEvWA7gYS3nb+mwuC/c57hfWtGxkrXBqfvny/I4MOEGLZ90CknC0Z7rPxJRV08OBfzw
	DbSZ/6rsgOzqixOV5Q==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tpaHQ-002fS5-1x;
	Tue, 04 Mar 2025 21:58:24 +0000
Date: Tue, 4 Mar 2025 21:58:24 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Bryan Tan <bryan-bt.tan@broadcom.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, vishnu.dasa@broadcom.com,
	leon@kernel.org, bcm-kernel-feedback-list@broadcom.com,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Unwired pvrdma_modify_device ?
Message-ID: <Z8d3gOpQ95vLNuW1@gallifrey>
References: <Z8TWF6coBUF3l_jk@gallifrey>
 <20250303182629.GV5011@ziepe.ca>
 <Z8X4Ax5UCerz9lP8@gallifrey>
 <CAOuBmuZdG7SWWmmhtEF09B5A4O-s+_h_uZnmTOPyKtQJGM9=wA@mail.gmail.com>
 <Z8celFfGXR8P6Mk8@gallifrey>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8celFfGXR8P6Mk8@gallifrey>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 21:58:05 up 300 days,  9:12,  1 user,  load average: 0.02, 0.01,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Dr. David Alan Gilbert (linux@treblig.org) wrote:
> * Bryan Tan (bryan-bt.tan@broadcom.com) wrote:
> > On Mon, Mar 3, 2025 at 6:42 PM Dr. David Alan Gilbert <linux@treblig.org>
> > wrote:
> > > * Jason Gunthorpe (jgg@ziepe.ca) wrote:
> > > > On Sun, Mar 02, 2025 at 10:05:11PM +0000, Dr. David Alan Gilbert wrote:
> > > > > Hi,
> > > > >   I noticed that pvrdma_modify_device() in
> > > > >    drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
> > > > > isn't called anywhere; shouldn't it be wired up in pvrdma_dev_ops ?
> > > > >
> > > > > (I've not got VMWare anywhere to try it on, and don't know the innards
> > > > > of RDMA drivers; so can't really test it).
> > >
> > > Hi Jason,
> > >   Thanks for the reply,
> > >
> > > > Seems probably right
> > > >
> > > > But at this point I'd just delete it unless pvrdma maintainers say
> > > > otherwise in the next week
> > >
> > > OK, lets see if they wake up.
> > >
> > > Dave
> > 
> > Thanks David for bringing this up. You're right, it looks like we
> > never wired it up to pvrdma_dev_ops. Feel free to remove it.
> 
> Hi Bryan,
>   Thanks for the reply - OK, I'll send a patch later to remove it.

Just sent, See 20250304215637.68559-1-linux@treblig.org

Dave

> Dave
> 
> -- 
>  -----Open up your eyes, open up your mind, open up your code -------   
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

