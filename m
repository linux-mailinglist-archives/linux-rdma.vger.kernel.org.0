Return-Path: <linux-rdma+bounces-11437-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA5CADF72C
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Jun 2025 21:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3CDF189F4CB
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Jun 2025 19:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149EB219313;
	Wed, 18 Jun 2025 19:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZC2lGdXy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C206516B3B7;
	Wed, 18 Jun 2025 19:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750276202; cv=none; b=AWgJMk9XLpjTfmVgLY/NUhQ6UhU8Em3p28xMVdTA5xV2EPdoCLQX6uYVIPLq/veB9HdwoIJQ0h0VEjXXmQBY9+39XdrpCzlftQRAhJghCB02/modqeQFx+Py1pJ3aln+93Brk6Uy3nkHO345KLI54iRV0PYrh4XBoTY4zd4Z45o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750276202; c=relaxed/simple;
	bh=551ZRiS709YGVkR9GB27TMLoTidFpls8oAqnusFPDR4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FLXlopUzGMiMgiYwMKKhVSMTCInKF2h+ISvqvenxXEg1MO1GQGe7e0ExT6/6KZbmdj2fz899dTFujvDMYMPYB/OttaJRvmoMiitiZAVXoAW0sXhWyIvT9Bs8BqLYurdrFkjB+u9XNqx/jgRcN+sbWpH+VOawOQsrUHUAwB7ap9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZC2lGdXy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2408C4CEE7;
	Wed, 18 Jun 2025 19:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750276202;
	bh=551ZRiS709YGVkR9GB27TMLoTidFpls8oAqnusFPDR4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZC2lGdXyHBOJ/tVA9IxNYPIrCJFHRTwQOb0An39CdNr88ObDzCLXoQxEezqMHQU7l
	 HOwMD6d8ilV9ua6dgojlbdW9rdlSdIR+nAEvfowcdlh3va3ctnjOPY8rNO0wN4Rn5i
	 pCoeqUN5kKfDF3g3IaMnkh7jnmobrt3zHk0oX64iouKJ5uAtEMi4e4ywN7olM50I5X
	 G22Bx1dIkS1fAPq7SXNgAqCNtaUx+kLjQAuMhMaCGXYH0q7uEn4P1X8EnT9/CVfqQb
	 8SC8CloGlTubkd8xc+1NySOHh8IcTIptT93fWrBEjBK0cUMv4oue+EYd1p4qKWjUAk
	 t1aU9jCfZ1cFg==
Date: Wed, 18 Jun 2025 20:49:57 +0100
From: Simon Horman <horms@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>, Saeed Mahameed <saeed@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Mark Bloch <markb@mellanox.com>, Paul Blakey <paulb@mellanox.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH RFC net] net/mlx5: Avoid NULL dereference in dest_is_valid
Message-ID: <20250618194957.GB1699@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFMVCY2_TqjAp_Aj@x130>
 <4f115511-5739-416d-a687-6b25a21fdd56@nvidia.com>

On Wed, Jun 18, 2025 at 10:35:25PM +0300, Mark Bloch wrote:
> 
> 
> On 18/06/2025 21:27, Simon Horman wrote:
> > Elsewhere in dest_is_valid it is assumed that dest may be NULL.
> > But the line updated by this patch dereferences dest unconditionally.
> > This seems to be inconsistent.
> > 
> > Flagged by Smatch.
> > Compile tested only.
> > 
> > Fixes: ff189b435682 ("net/mlx5: Add ignore level support fwd to table rules")
> > Signed-off-by: Simon Horman <horms@kernel.org>
> > ---
> > I am posting this as an RFC as I am not completely sure this change is
> > necessary. F.e. an invariant that I'm unaware of may preclude dest
> > from being NULL in this case.
> 
> _mlx5_add_flow_rules() does:
>         for (i = 0; i < dest_num; i++) {
>                 if (!dest_is_valid(&dest[i], flow_act, ft))
>                         return ERR_PTR(-EINVAL);
>         }
> 
> so indeed dest must be valid inside dest_is_valid().\
> No defensive programming for this as all the callers are part of mlx5
> driver and they shouldn't pass dest_num that doesn't match how many
> dests are passed.
> 
> If anything I would drop the other checks for dest inside that function.
> I'll add that to my TODO list.
> 
> Thanks!

...

On Wed, Jun 18, 2025 at 12:35:37PM -0700, Saeed Mahameed wrote:
> On 18 Jun 19:27, Simon Horman wrote:

...

> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
> > index a8046200d376..7eeab93a1aa9 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
> > @@ -2041,7 +2041,8 @@ static bool dest_is_valid(struct mlx5_flow_destination *dest,
> > 		    ft->type != FS_FT_NIC_TX)
> > 			return false;
> > 
> > -		if (dest->type == MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE &&
> > +		if (dest &&
> 
> dest can't be null is it is always taken from entries of an array of
> mlx5_flow_destination.
> 
> 2 solutions:
>   1. remove other `if (dest && ...` checks in this function,      to not
> confuse smatch.
>   2. pass dest as value. there's only one caller of this function.      it
> is a 40B struct, don't know what the perf impact on flow rule
>      insertion rate.
> 
> I prefer solution 1.


Thanks Saeed and Mark for your quick response,
and sorry for the false positive.

I agree that removing the other dest checks makes sense.
And of course there is no urgency for that on my side.

