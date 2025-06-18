Return-Path: <linux-rdma+bounces-11436-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7422ADF6F0
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Jun 2025 21:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70B2F7ACA7A
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Jun 2025 19:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AA6219311;
	Wed, 18 Jun 2025 19:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8OIBT8N"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E24D207A0B;
	Wed, 18 Jun 2025 19:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750275339; cv=none; b=Xk3JuzZ2Bd86hfcnv0B+A8EM+uCfw2sAYJKFWjDBULRswSMGTPDQsjXt1w7CdKYYFNz+X3bV5VIQZ5RdFAEhdfqV7+kcYrjpF+5t0VbFnG3X/euS/5k8YBykB0bV8zXdgdoBPvY6fMiKlPEKwvY26bQWCmtdyuNzPoMUpi1NEP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750275339; c=relaxed/simple;
	bh=Oq3JGXDg4/RffqIR7BnqyuExU4A9MAiKStZgvUK7wRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2Obnjh+0DgMH+34ssCxvP1eQr14fC1ppQmiwLGB2DMcDi8Tr0xlN2skTjFDMKFLJtUdb4V2ZRwZRXyy5fzMUqxlRN0c1dCc4tdxYRKgPDRzjwm22OKr/w80aAH/lnwt1j1tcJu9/BgiELF0bG6vvfym1lPCRTShStNer/Eh7uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8OIBT8N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E87EC4CEEF;
	Wed, 18 Jun 2025 19:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750275339;
	bh=Oq3JGXDg4/RffqIR7BnqyuExU4A9MAiKStZgvUK7wRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e8OIBT8NHIXcNrYcJd+HihUHGfBkBRXXlXtWRzNqh33GE2UUrY8L4iZtjheBtkzPa
	 iiR2QVw0ent62AS9O5vVOaJ9SKFyMps3J5DpG0nckVF7NcSFKXrS/w8xhzL3PM4oVI
	 l3XgO1RjfKra77MK9gdG1ZH9L9tcSTw04iSP6EPRpCVPmOSAuGQ9mBwvND54+SS5Aq
	 CPSwzUKFAfM1C8sejyg6ulIrWjbCAMxMWx4FuOD9nUiASaZgvpO4e4JC23HpxPF2iP
	 rC4xalMpmXjiW81lWtuVjSuOGhczA/nWSKubvevA/OgcduCKIs+wqKqzvHPBIkR5hb
	 DFPcaP6nU3mdQ==
Date: Wed, 18 Jun 2025 12:35:37 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Mark Bloch <markb@mellanox.com>, Paul Blakey <paulb@mellanox.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH RFC net] net/mlx5: Avoid NULL dereference in dest_is_valid
Message-ID: <aFMVCY2_TqjAp_Aj@x130>
References: <20250618-mlx5-dest-v1-1-db983334259a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250618-mlx5-dest-v1-1-db983334259a@kernel.org>

On 18 Jun 19:27, Simon Horman wrote:
>Elsewhere in dest_is_valid it is assumed that dest may be NULL.
It can't be null, so we need to remove other checks elsewhere.
see below:

>But the line updated by this patch dereferences dest unconditionally.
>This seems to be inconsistent.
>
>Flagged by Smatch.
>Compile tested only.
>
>Fixes: ff189b435682 ("net/mlx5: Add ignore level support fwd to table rules")
>Signed-off-by: Simon Horman <horms@kernel.org>
>---
>I am posting this as an RFC as I am not completely sure this change is
>necessary. F.e. an invariant that I'm unaware of may preclude dest
>from being NULL in this case.
>---
> drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
>index a8046200d376..7eeab93a1aa9 100644
>--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
>+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
>@@ -2041,7 +2041,8 @@ static bool dest_is_valid(struct mlx5_flow_destination *dest,
> 		    ft->type != FS_FT_NIC_TX)
> 			return false;
>
>-		if (dest->type == MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE &&
>+		if (dest &&

dest can't be null is it is always taken from entries of an array of
mlx5_flow_destination.

2 solutions:
   1. remove other `if (dest && ...` checks in this function, 
      to not confuse smatch.
   2. pass dest as value. there's only one caller of this function. 
      it is a 40B struct, don't know what the perf impact on flow rule
      insertion rate.

I prefer solution 1.

>+		    dest->type == MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE &&
> 		    ft->type != dest->ft->type)
> 			return false;
> 	}
>
>

