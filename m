Return-Path: <linux-rdma+bounces-1728-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4E0894DBD
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 10:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E11A71C217DC
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 08:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04055405CF;
	Tue,  2 Apr 2024 08:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XII0Ga5o"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FF58BF6;
	Tue,  2 Apr 2024 08:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712047119; cv=none; b=iTKLUjPhf7QLYWvaA1u7P3B/vIFGHXG/YYEhbzZVGM/hj2F+p6FmuFZT49HGzhAxKh78Y5OVHZgu2w0UoAxeqZhDYve1xiHrQ3CyhaLJXbfD7Ydw2O46J4bqTarVNArtewawnSVVRUO+5K1lU5ptvahEqBa8A5nZOgBCnx/wWQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712047119; c=relaxed/simple;
	bh=2QTJJkBJfOudjF9f8FhQEELqqdByRxvxWBK8+NHb4b8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4p5B83ZxNR+6GsJrGchjJx5qDnCFs/5tpfHFYGSHbtcfw6OnL8QbC6+CVh28qcxz/llZVcwKCBUGSNUxSllyMQ+6YbW+V5EhSEBrzXQ9mW6kbs55Omaug5WFPImT2EhwgC+3pPEUkMLGjOCREK+yxFRkxBGL+mGEKz9sZ6IgQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XII0Ga5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF496C433C7;
	Tue,  2 Apr 2024 08:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712047119;
	bh=2QTJJkBJfOudjF9f8FhQEELqqdByRxvxWBK8+NHb4b8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XII0Ga5oYDoW2nnQnppjresLqDDVdZYrBFueH+DJrzs5nFOC3bB+N310FX6Zcy/Lh
	 Ne7h/2yrnOw1nr+tmKqmpGjVF5sxqgeInuuNIN9LtLOWNPErw7Nt1d43pRLLEEz1iT
	 eyCEHeKVoi2IrKRDhaJlUvPupz+7DM1GOkXCrkCK7PzOezhOpCTZJweaHbWzyGbXLS
	 8wAy+VpJgaVDNsOODwK9eZ1in2srnNN1M0EBSYoG2HmThVRUQ5rc5OFaaaJHXrnpIs
	 8LXzQPdGM6F/t0h7BYZaizArYUmn70YSCm9OCCl58g4NZRd+Zsy1ybLTZpAHMd5RAy
	 hC5jcXeWECqMg==
Date: Tue, 2 Apr 2024 11:38:34 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] RDMA/cm: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <20240402083834.GF11187@unreal>
References: <ZgHdZ15cQ7MIHsGL@neat>
 <20240325224706.GB8419@ziepe.ca>
 <5c0bb827-e5f3-4178-ad46-8ac9b99d7726@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c0bb827-e5f3-4178-ad46-8ac9b99d7726@embeddedor.com>

On Mon, Mar 25, 2024 at 08:57:08PM -0600, Gustavo A. R. Silva wrote:
> 
> 
> On 3/25/24 16:47, Jason Gunthorpe wrote:
> > On Mon, Mar 25, 2024 at 02:24:07PM -0600, Gustavo A. R. Silva wrote:
> > > -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> > > ready to enable it globally.
> > > 
> > > Use the `struct_group_tagged()` helper to separate the flexible array
> > > from the rest of the members in flexible `struct cm_work`, and avoid
> > > embedding the flexible-array member in `struct cm_timewait_info`.
> > > 
> > > Also, use `container_of()` to retrieve a pointer to the flexible
> > > structure.
> > > 
> > > So, with these changes, fix the following warning:
> > > drivers/infiniband/core/cm.c:196:24: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > > 
> > > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > ---
> > >   drivers/infiniband/core/cm.c | 21 ++++++++++++---------
> > >   1 file changed, 12 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> > > index bf0df6ee4f78..80c87085499c 100644
> > > --- a/drivers/infiniband/core/cm.c
> > > +++ b/drivers/infiniband/core/cm.c
> > > @@ -182,18 +182,21 @@ struct cm_av {
> > >   };
> > >   struct cm_work {
> > > -	struct delayed_work work;
> > > -	struct list_head list;
> > > -	struct cm_port *port;
> > > -	struct ib_mad_recv_wc *mad_recv_wc;	/* Received MADs */
> > > -	__be32 local_id;			/* Established / timewait */
> > > -	__be32 remote_id;
> > > -	struct ib_cm_event cm_event;
> > > +	/* New members must be added within the struct_group() macro below. */
> > > +	struct_group_tagged(cm_work_hdr, hdr,
> > > +		struct delayed_work work;
> > > +		struct list_head list;
> > > +		struct cm_port *port;
> > > +		struct ib_mad_recv_wc *mad_recv_wc;	/* Received MADs */
> > > +		__be32 local_id;			/* Established / timewait */
> > > +		__be32 remote_id;
> > > +		struct ib_cm_event cm_event;
> > > +	);
> > >   	struct sa_path_rec path[];
> > >   };
> > 
> > I didn't look, but does it make more sense to break out the path side
> > into its own type and avoid the struct_group_tagged? I seem to
> > remember only one thing used it.
> > 
> 
> I thought about that, but I'd have to change the parameter type of
> `static int cm_timewait_handler(struct cm_work *work)`, and that would
> imply also modifying the internals of function `cm_work_handler()` (and
> then I didn't look much into it). 

So let's try to invest in this direction first before we add obfuscation
with magic words to the code.

Thanks

> So, the `struct_group_tagged()` strategy is in general more cleaner and straightforward.
> 
> --
> Gustavo
> 
> 

