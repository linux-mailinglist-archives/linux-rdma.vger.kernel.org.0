Return-Path: <linux-rdma+bounces-14822-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5229C93724
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Nov 2025 04:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 806CB3A8934
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Nov 2025 03:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B756021423C;
	Sat, 29 Nov 2025 03:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6U3LJLB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6704513A86C;
	Sat, 29 Nov 2025 03:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764386366; cv=none; b=gP0WYjU8OHJ7XpGp7CY+mwayTDg2HPMXY89UVfOTkoZBMCSbpvYYEF40rRO9uWhLmWxllN/u4ATyJHOhxPgBUl+y746RRnzWPiSMzcj4Y3WO4PE3EDfMdXlj8rp9A9p//wAZC+BctEVtUWUH0PRXmXkwWKcEc6ELaOdWmD7Bjx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764386366; c=relaxed/simple;
	bh=EunAViohAbOvwY2TpFSbpDzuVwwbE2/f+ExqeA+MhXA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WJS9SPFgc/rmYuuAbojnJRsVIdofs7d0C46dT0jSVha9XcjIYM+mz8VCl7tiTv1f0OMDZdXleJGB30zhJtya3jn615wiMgXVAcw7j6TiNCcd2NSaFxXTY358Rsb6lTHhsryAZtImT+HM1zRnTTvteiAvQY0GoBPfGlAOu37i0O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6U3LJLB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2969C4CEF1;
	Sat, 29 Nov 2025 03:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764386365;
	bh=EunAViohAbOvwY2TpFSbpDzuVwwbE2/f+ExqeA+MhXA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a6U3LJLBkmBeIliJLAI6XNK4Ce4bf2JSTRGYd/GzBUVgg8oSkHJcnsM9hV72P1WSU
	 2v/mFAZcjCNPeHsekXq1MAePGPWJ8IEV14IphY9JV9gwXtH38jsx7EIh9zChh+le/X
	 byCNQjxjwh4o2z9YnRsN9hjmIb5blE8VLG5WuLrvWBklwNQuLzTJ0SxNY6yZYy/zik
	 9tAX55Q2iV4cMOnryaxpm8Qr3MM6oYwhDon4SiQd7wt4+u4gEXFNF7FOBQWwAXCWpE
	 aC49Y6J3ShaQDe+5dJ6+Smnz3azBorwkejy3q7o0vLAQY++TJYVOboBEJCDa6ZdR5o
	 NbHRrCn1Sdxzg==
Date: Fri, 28 Nov 2025 19:19:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Donald Hunter
 <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Mark Bloch
 <mbloch@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, Gal Pressman
 <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Carolina Jubran
 <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Jiri Pirko
 <jiri@nvidia.com>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH net-next V4 02/14] documentation: networking: add shared
 devlink documentation
Message-ID: <20251128191924.7c54c926@kernel.org>
In-Reply-To: <hidhx467pn6pcisuoxdw3pykyvnlq7rdicmjksbozw4dtqysti@yd5lin3qft4q>
References: <1764101173-1312171-1-git-send-email-tariqt@nvidia.com>
	<1764101173-1312171-3-git-send-email-tariqt@nvidia.com>
	<20251127201645.3d7a10f6@kernel.org>
	<hidhx467pn6pcisuoxdw3pykyvnlq7rdicmjksbozw4dtqysti@yd5lin3qft4q>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Nov 2025 12:00:13 +0100 Jiri Pirko wrote:
> >> +Shared devlink instances allow multiple physical functions (PFs) on the same
> >> +chip to share an additional devlink instance for chip-wide operations. This
> >> +should be implemented within individual drivers alongside the individual PF
> >> +devlink instances, not replacing them.
> >> +
> >> +The shared devlink instance should be backed by a faux device and should
> >> +provide a common interface for operations that affect the entire chip
> >> +rather than individual PFs.  
> >
> >If we go with this we must state very clearly that this is a crutch and
> >_not_ the recommended configuration...  
> 
> Why "not recommented". If there is a usecase for this in a dirrerent
> driver, it is probably good to utilize the shared instance, isn't it?
> Perhaps I'm missing something.

Having a single instance seems preferable from user's point of view.

> >... because presumably we could use this infra to manage a single
> >devlink instance? Which is what I asked for initially.  
> 
> I'm not sure I follow. If there is only one PF bound, there is 1:1
> relationship. Depends on how many PFs of the same ASIC you have.

I'm talking about multi-PF devices. mlx5 supports multi-PF setup for
NUMA locality IIUC. In such configurations per-PF parameters can be
configured on PCI PF ports.

> >Why can't this mutex live in the core?  
> 
> Well, the mutex protect the list of instances which are managed in the
> driver. If you want to move the mutex, I don't see how to do it without
> moving all the code related to shared devlink instances, including faux
> probe etc. Is that what you suggest?

Multiple ways you can solve it, but drivers should have to duplicate
all the instance management and locking. BTW please don't use guard().

