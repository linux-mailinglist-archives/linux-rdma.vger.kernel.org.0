Return-Path: <linux-rdma+bounces-11918-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B4AAFACF9
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 09:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B27EE18979B0
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 07:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B9728003A;
	Mon,  7 Jul 2025 07:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJitShrA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BF627F019;
	Mon,  7 Jul 2025 07:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751872901; cv=none; b=Ez4tstii6c17HkEb9B8I7CNfNTSX2EgylOg8VnvrBVazoZByHS1bCJhFlDkpGhta92H17nVyqd4P7Gp00EKD67El55Xz1P7cNJkPtd6if77J2/xXGfHXyBshRKrpiqLAjRZu5driodw+sGmE3OfKm3hZbPWqJ984dAAW1w/c3XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751872901; c=relaxed/simple;
	bh=Tqrxaf8t756E8EVWDsGNzCk1d4o7iofq8FADaSeASks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6eKDJ2L2KptYj4tvrsWJbb23kVGnT7w3Ly+hrHAYTZreLEdrlGctjAq7tfj1qwEtdROkElzvh1HTnbru+bo0+XmU0iXJV46zDDtnZT1aMnDK1uMV8LUXXjpnn11DMBgjr9or8nivLoMQ//N1eRVdMveJ6H1lyseJkzLEHmSXqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJitShrA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89757C4CEE3;
	Mon,  7 Jul 2025 07:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751872901;
	bh=Tqrxaf8t756E8EVWDsGNzCk1d4o7iofq8FADaSeASks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XJitShrAZtSYAU7TL0LPjb6yKeGuWJS8qyRPiD5ntRiocMfbqualW+a8wp0KJ8Y50
	 zju/7VfmkBXOMXu3LugmJonPg8ya+dmLeYZ6UFVfWKN/mnrdWpMlggQvJRYMHi7+2V
	 EB/93l6iQTmYEfjalcvIwi+gA0tn+VoBpfXqe1A5odSoaExTVzJ5MLrdSqVChZhZDf
	 P1Igz8hz+dy5q8/GrR1WLRmkfd0Ljtk9Mr35cg/jOrrjNRqPv1jCG0XVim/ktvfXc+
	 1+Z5TgYjEBT9tncovWuWW1V8aO0EnfRkWx8zX2X1pWydAxhMjl9urGnjkE21Ixg1fz
	 UhLE++1rh0QNg==
Date: Mon, 7 Jul 2025 10:21:37 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, shannon.nelson@amd.com,
	brett.creeley@amd.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
	andrew+netdev@lunn.ch, allen.hubbe@amd.com, nikhil.agarwal@amd.com,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Boyer <andrew.boyer@amd.com>
Subject: Re: [PATCH v3 10/14] RDMA/ionic: Register device ops for control path
Message-ID: <20250707072137.GU6278@unreal>
References: <20250624121315.739049-1-abhijit.gangurde@amd.com>
 <20250624121315.739049-11-abhijit.gangurde@amd.com>
 <20250701103844.GB118736@unreal>
 <20250702131803.GB904431@ziepe.ca>
 <20250702180007.GK6278@unreal>
 <bb0ac425-2f01-b8c7-2fd7-4ecf9e9ef8b1@amd.com>
 <20250704170807.GO6278@unreal>
 <15b773a4-424b-4aa9-2aa4-457fbbee8ec7@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15b773a4-424b-4aa9-2aa4-457fbbee8ec7@amd.com>

On Mon, Jul 07, 2025 at 10:57:13AM +0530, Abhijit Gangurde wrote:
> 
> On 7/4/25 22:38, Leon Romanovsky wrote:
> > On Thu, Jul 03, 2025 at 12:49:30PM +0530, Abhijit Gangurde wrote:
> > > On 7/2/25 23:30, Leon Romanovsky wrote:
> > > > On Wed, Jul 02, 2025 at 10:18:03AM -0300, Jason Gunthorpe wrote:
> > > > > On Tue, Jul 01, 2025 at 01:38:44PM +0300, Leon Romanovsky wrote:
> > > > > > > +static void ionic_flush_qs(struct ionic_ibdev *dev)
> > > > > > > +{
> > > > > > > +	struct ionic_qp *qp, *qp_tmp;
> > > > > > > +	struct ionic_cq *cq, *cq_tmp;
> > > > > > > +	LIST_HEAD(flush_list);
> > > > > > > +	unsigned long index;
> > > > > > > +
> > > > > > > +	/* Flush qp send and recv */
> > > > > > > +	rcu_read_lock();
> > > > > > > +	xa_for_each(&dev->qp_tbl, index, qp) {
> > > > > > > +		kref_get(&qp->qp_kref);
> > > > > > > +		list_add_tail(&qp->ibkill_flush_ent, &flush_list);
> > > > > > > +	}
> > > > > > > +	rcu_read_unlock();
> > > > > > Same question as for CQ. What does RCU lock protect here?
> > > > > It should protect the kref_get against free of qp. The qp memory must
> > > > > be RCU freed.
> > > > I'm not sure that this was intension here. Let's wait for an answer from the author.
> > > As Jason mentioned, It was intended to protect the kref_get against free of
> > > cq and qp
> > > in the destroy path.
> > How is it possible? IB/core is supposed to protect from accessing verbs
> > resources post their release/destroy.
> > 
> > After you answered what RCU is protecting, I don't see why you would
> > have custom kref over QP/CQ/e.t.c objects.
> > 
> > Thanks
> The RCU protected kref here is making sure that all the hw events are
> processed before destroy callback returns. Similarly, when driver is
> going for ib_unregister_device, it is draining the pending WRs and events.

I asked why do you have kref in first place? When ib_unregister_device
is called all "pending MR" already supposed to be destroyed.

Thansk

> 
> Thanks,
> Abhijit
> 
> 

