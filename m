Return-Path: <linux-rdma+bounces-11858-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9436BAF6D37
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 10:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C26179705
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 08:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2902D23B9;
	Thu,  3 Jul 2025 08:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScPQvkH4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB412D1F45;
	Thu,  3 Jul 2025 08:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751532067; cv=none; b=RPmxIciPhBxEaPllPywSygb7XJ0lw82McmbbA9iX/RAkilCLPwL1EPZzx2ngRk+5g+1q2FUmKzDBzB1SO6WpmHx9gWNWRNXfVzbECksvd4s+2EWzl3SWe3zDAdJ9zd9ZvnHdC4YH5XkZGbge+HMfaeLpqSRmnJvH3M0eF1ZbG1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751532067; c=relaxed/simple;
	bh=peM33uQ7bGFE0YgDKvteYoMtVSvEv8DTebgD98gtmeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Leq9GGbsF8OsX7d3cPFR80ActkmFL21Hpq7PnsrXkvN2Ka75GjhwlUqwiPt6UgW3nWqCfvs1DcfqqPAEO0HDTyu1t5XT+85T6mEth3Rbvmhs+KoIHSubilneNkmlF2qDjNQrhawbAMWwb4gNyFpfPAiBlKR5jSVAbdGxgRj1Mv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScPQvkH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABF8C4CEEB;
	Thu,  3 Jul 2025 08:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751532067;
	bh=peM33uQ7bGFE0YgDKvteYoMtVSvEv8DTebgD98gtmeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ScPQvkH4QOqe1f96gFYMPSGOwirUmjoeMLPfXyo+RE5eqjOm6VpW5/OMAsDJpUR6P
	 5mgUzZKYWoF3f7jhmJXW25yTYHzGkDfhrETkDTY6FxiSQO8Ll0dcdD7xYL6NNxVblV
	 jd1baNs2Fri4yAdgkokNQ3DFa9BISlQa86j27z/6B43EFMNuwg6B892C2rJFCAMnnJ
	 6fuAv3s/YttnTgzzABzBUenGSNCtdgatkPJsovEcimq/Pts8yhaSLXfk2+rGyaMt1+
	 4ctq9z7c33tVJHXWJw6rJHbXyAfuXoeHZH6R4yE+/sXDQZIaUmMidk9roUbHR2pHft
	 hM3JVTfnXiE4A==
Date: Thu, 3 Jul 2025 11:41:02 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	corbet@lwn.net, jgg@ziepe.ca, andrew+netdev@lunn.ch,
	allen.hubbe@amd.com, nikhil.agarwal@amd.com,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Boyer <andrew.boyer@amd.com>
Subject: Re: [PATCH v3 09/14] RDMA/ionic: Create device queues to support
 admin operations
Message-ID: <20250703084102.GN6278@unreal>
References: <20250624121315.739049-1-abhijit.gangurde@amd.com>
 <20250624121315.739049-10-abhijit.gangurde@amd.com>
 <20250701102409.GA118736@unreal>
 <23018193-6db4-c0be-05a8-ed68853bd2ff@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23018193-6db4-c0be-05a8-ed68853bd2ff@amd.com>

On Thu, Jul 03, 2025 at 12:29:45PM +0530, Abhijit Gangurde wrote:
> 
> On 7/1/25 15:54, Leon Romanovsky wrote:
> > On Tue, Jun 24, 2025 at 05:43:10PM +0530, Abhijit Gangurde wrote:
> > > Setup RDMA admin queues using device command exposed over
> > > auxiliary device and manage these queues using ida.
> > > 
> > > Co-developed-by: Andrew Boyer <andrew.boyer@amd.com>
> > > Signed-off-by: Andrew Boyer <andrew.boyer@amd.com>
> > > Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
> > > Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
> > > Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> > > ---
> > > v2->v3
> > >    - Fixed lockdep warning
> > >    - Used IDA for resource id allocation
> > >    - Removed rw locks around xarrays

<...>

> > 
> > > +		list_for_each_entry_safe(wr, wr_next, &aq->wr_prod, aq_ent) {
> > > +			INIT_LIST_HEAD(&wr->aq_ent);
> > > +			aq->q_wr[wr->status].wr = NULL;
> > > +			wr->status = aq->admin_state;
> > > +			complete_all(&wr->work);
> > > +		}
> > > +		INIT_LIST_HEAD(&aq->wr_prod);
> > <...>
> > 
> > > +	if (do_reset)
> > > +		/* Reset device on a timeout */
> > > +		ionic_admin_timedout(bad_aq);
> > I wonder why RDMA driver resets device and not the one who owns PCI.
> 
> RDMA driver is requesting the reset via eth driver which holds the
> privilege.

I wonder if the one who owns CMD interface should decide and reset device
and not the clients.

> 

<...>

> > > +	old_state = atomic_cmpxchg(&dev->admin_state, IONIC_ADMIN_ACTIVE,
> > > +				   IONIC_ADMIN_PAUSED);
> > > +	if (old_state != IONIC_ADMIN_ACTIVE)
> > In all these places you are mixing enum_admin_state and atomic_t for
> > same values, but different variable. Please chose or atomic_t or enum.
> 
> admin_state within the admin queues is protected by the spinlock,
> hence it is used as enum_admin_state. However device's admin_state
> is used as as atomic to avoid reset race of reset.

The issue is in mixing types.

> 

<...>

> > > +
> > > +	if (!cq) {
> > Is it possible?
> 
> Possible when HCA goes bad.

Do you have errata for that? Generally speaking, kernel is not written
to be protected from broken HW. The overall assumption is that HW works
correctly.

Thanks

