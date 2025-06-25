Return-Path: <linux-rdma+bounces-11621-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8673AE7DDE
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 11:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D45D7A35BD
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 09:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6BC29B21D;
	Wed, 25 Jun 2025 09:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRxrJZhz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536AC25A352;
	Wed, 25 Jun 2025 09:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750844730; cv=none; b=nqU/ddi04/wLIkCTevxNqmhCUeDGwEwmX6Pbk+LBvMK2xbdawWAQlZ8HqQewNheA9fEy/Gc5nfuSEwCrKE2G37/zkFSE7hH9+4ua4t8MPKMwSxqnmhGnHcCC7FN6R0X1Pu3UJ/oMk7XT4UuvfLmW7bmFfeAAHVq3NmzvZpLtNFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750844730; c=relaxed/simple;
	bh=DCpaCQv0mu/4Es5IpdSqOmpjx089qY7Khtf3V+uJceY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=loDnbD9b9kE/GJsFZCsorxi90WF8sq6ao0mTa1YIvtGflLZt/y6jiNxDdl+lU/QZyWyjs1Lqp/H/OwldpWXHx0cS1CGNFCuGiucwa5T5qu4jYzJThMZJZDBKBcCGQEdAG7KPl7+5iLyTCLV89G+6pf3CGgeV02vju33IhdwHVPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRxrJZhz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5D8C4CEEA;
	Wed, 25 Jun 2025 09:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750844729;
	bh=DCpaCQv0mu/4Es5IpdSqOmpjx089qY7Khtf3V+uJceY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IRxrJZhz/8jHPEpX740mPyKpGNn20/MK38du80BD5NlPbWT6RwKASOGNow/pqJn2Z
	 Q0mjVeclhQctsmos18i+WT1NyvNMgessHVXY324ukowupt0xgcsp90vaJichGx6715
	 nasLqYHGxPn79ImwNr60QqntJSOuisvARJ9XVyJy2EzqvnFE9KD6U2KsV/NMTkOwni
	 KTqaB5JYo9+pkRgwjrFhbMjHSUyAuWOssGiRml3OqMIsoHPOyw7cz7/O6gbXrGG6ib
	 nGHpkYEqfBhr/UWlD3EWcVzxtpugx2kPTCVuF9VxsprQ/++XJaJgq//to5kLGFAuz5
	 QRgCUBnHtL3kw==
Date: Wed, 25 Jun 2025 10:45:24 +0100
From: Simon Horman <horms@kernel.org>
To: Yevgeny Kliteynik <kliteyn@nvidia.com>
Cc: Mark Bloch <mbloch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, saeedm@nvidia.com,
	gal@nvidia.com, leonro@nvidia.com, tariqt@nvidia.com,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	moshe@nvidia.com, Vlad Dogaru <vdogaru@nvidia.com>
Subject: Re: [PATCH net-next v2 3/8] net/mlx5: HWS, Refactor and export rule
 skip logic
Message-ID: <20250625094524.GN1562@horms.kernel.org>
References: <20250622172226.4174-1-mbloch@nvidia.com>
 <20250622172226.4174-4-mbloch@nvidia.com>
 <20250624183832.GF1562@horms.kernel.org>
 <dff4ea02-4adc-4044-a18a-ee884abc0053@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dff4ea02-4adc-4044-a18a-ee884abc0053@nvidia.com>

On Wed, Jun 25, 2025 at 03:35:52AM +0300, Yevgeny Kliteynik wrote:
> Hi Simon,
> Thanks for reviewing the patches!
> 
> On 24-Jun-25 21:38, Simon Horman wrote:
> > On Sun, Jun 22, 2025 at 08:22:21PM +0300, Mark Bloch wrote:
> > > From: Vlad Dogaru <vdogaru@nvidia.com>
> > > 
> > > The bwc layer will use `mlx5hws_rule_skip` to keep track of numbers of
> > > RX and TX rules individually, so export this function for future usage.
> > > 
> > > While we're in there, reduce nesting by adding a couple of early return
> > > statements.
> > 
> > I'm all for reducing nesting. But this patch has two distinct changes.
> > Please consider splitting it into two patches.
> 
> Not sure I'd send the refactor thing alone - it isn't worth the effort
> IMHO... But since I'm already in here - sure, will sent it in a separate
> patch.

FWIIW, I think the refactor is fine in the context of this patchset.
But I do feel that it being a separate patch within the patchset is best.

...

