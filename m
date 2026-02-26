Return-Path: <linux-rdma+bounces-17240-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFRHBqKVoGllkwQAu9opvQ
	(envelope-from <linux-rdma+bounces-17240-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 19:49:06 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDB51ADFE4
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 19:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 659FE3153F28
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 18:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AA0376479;
	Thu, 26 Feb 2026 18:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="druWqrCz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDB1279DC3;
	Thu, 26 Feb 2026 18:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772130501; cv=none; b=hzFtwRlB/V/hcBWG5Bih/0Lql/ZmKbzyr+K3aCvnO436+4MR1GJEnwH2efUdAmGHJBVWAofOhK5JIeHL/8GNJOjROsoBP8ain3cqOiBUrBefW1itB2v0FebDwNQeer+PnitsZfeqTbW0dbxHo5fvZGNe3LQ7izg/0GQkW+hzGoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772130501; c=relaxed/simple;
	bh=3jmRZFBM98cGrM/uRNbk9jMOctp6O6rnRyO6DDW02I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLKImFULR+5z+4qj7s1gtSsJQZclbyoCFto4cE9Yd1yRs1gwkjnIjV+xCVpoI+S+SGeevKLGeXRB4FUmb/aTem/RlXdshBA7lQbj62aQlLkoaOfHaZvO5pkWDBLvmnjFQffq/RyWgVusGdKZh5Ab5aHNvQijwXLLAzQ+hNVi1JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=druWqrCz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82532C116C6;
	Thu, 26 Feb 2026 18:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772130501;
	bh=3jmRZFBM98cGrM/uRNbk9jMOctp6O6rnRyO6DDW02I8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=druWqrCzeK9PpzRHzwuSXRGB1fBDl9t8kZeAJQwgJkfwIIqWb8TJ+AKf44oijWywu
	 6O7v1up3vBaOdMJ409Q4foA9gn67jnjqNLqozU1/b5VawEEhsn435iRARdYXT0kzVW
	 I9hIJf5JyqGpU6eQL8LUCBrmfuyi3izPWidu8/o0hzX4ItcQ3+IQbxEhkBE5TeCAxw
	 O06pikC+TmrXvYcYJISaFhHH5RVwbfMX5oNJ5MtykI7xnnXo1rZ+Hu714Ojhd+ig/I
	 B27tFhRq2OhVqhQhVNadEtsDVmdnnaN1IAmxJ66soCd4EFJXsJbArh/l1BCjca98PF
	 jNqmBLGL832VQ==
Date: Thu, 26 Feb 2026 20:28:16 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Edward Srouji <edwards@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Michael Guralnik <michaelgur@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next v4 02/11] IB/core: Introduce FRMR pools
Message-ID: <20260226182816.GK12611@unreal>
References: <20260226-frmr_pools-v4-0-95360b54f15e@nvidia.com>
 <20260226-frmr_pools-v4-2-95360b54f15e@nvidia.com>
 <20260226141143.GJ12611@unreal>
 <48c7be0a-0dcc-48c3-92dd-6cdc390adc44@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48c7be0a-0dcc-48c3-92dd-6cdc390adc44@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17240-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7BDB51ADFE4
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 07:39:08PM +0200, Edward Srouji wrote:
> 
> 
> On 2/26/2026 4:11 PM, Leon Romanovsky wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Thu, Feb 26, 2026 at 03:52:07PM +0200, Edward Srouji wrote:
> > > From: Michael Guralnik <michaelgur@nvidia.com>
> > > 
> > > Add a generic Fast Registration Memory Region pools mechanism to allow
> > > drivers to optimize memory registration performance.
> > > Drivers that have the ability to reuse MRs or their underlying HW
> > > objects can take advantage of the mechanism to keep a 'handle' for those
> > > objects and use them upon user request.
> > > We assume that to achieve this goal a driver and its HW should implement
> > > a modify operation for the MRs that is able to at least clear and set the
> > > MRs and in more advanced implementations also support changing a subset
> > > of the MRs properties.
> > > 
> > > The mechanism is built using an RB-tree consisting of pools, each pool
> > > represents a set of MR properties that are shared by all of the MRs
> > > residing in the pool and are unmodifiable by the vendor driver or HW.
> > > 
> > > The exposed API from ib_core to the driver has 4 operations:
> > > Init and cleanup - handles data structs and locks for the pools.
> > > Push and pop - store and retrieve 'handle' for a memory registration
> > > or deregistrations request.
> > > 
> > > The FRMR pools mechanism implements the logic to search the RB-tree for
> > > a pool with matching properties and create a new one when needed and
> > > requires the driver to implement creation and destruction of a 'handle'
> > > when pool is empty or a handle is requested or is being destroyed.
> > > 
> > > Later patch will introduce Netlink API to interact with the FRMR pools
> > > mechanism to allow users to both configure and track its usage.
> > > A vendor wishing to configure FRMR pool without exposing it or without
> > > exposing internal MR properties to users, should use the
> > > kernel_vendor_key field in the pools key. This can be useful in a few
> > > cases, e.g, when the FRMR handle has a vendor-specific un-modifiable
> > > property that the user registering the memory might not be aware of.
> > > 
> > > Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
> > > Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
> > > Signed-off-by: Edward Srouji <edwards@nvidia.com>
> > > ---
> > >   drivers/infiniband/core/Makefile     |   2 +-
> > >   drivers/infiniband/core/frmr_pools.c | 319 +++++++++++++++++++++++++++++++++++
> > >   drivers/infiniband/core/frmr_pools.h |  48 ++++++
> > >   include/rdma/frmr_pools.h            |  37 ++++
> > >   include/rdma/ib_verbs.h              |   8 +
> > >   5 files changed, 413 insertions(+), 1 deletion(-)
> > 
> > <...>
> > 
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > 
> > <...>
> > 
> > > +EXPORT_SYMBOL(ib_frmr_pools_init);
> > 
> > It is odd to see these two lines together. Either update the SPDX license to
> > 'GPL-2.0 OR Linux-OpenIB', as we do for uverbs, and keep EXPORT_SYMBOL() as is,
> > or keep the current SPDX-License-Identifier and switch to EXPORT_SYMBOL_GPL().
> > 
> 
> Ugh, I missed that.
> BTW, we already have the same inconsistency in other core files such as
> cq.c, mr_pools.c, rw.c, and more...

These files are intentionally licensed as GPL-2. They are intended for
in-kernel verbs users (ULPs) and are internal to the kernel.

> Let's replace the license with 'GPL-2.0 OR Linux-OpenIB' to stay consistent
> with the rest of the RDMA core, where all exported symbols are used under
> the dual license.
> Do you need me to send v5 for this?

No, I'll fix.

> 
> > Thanks
> 

