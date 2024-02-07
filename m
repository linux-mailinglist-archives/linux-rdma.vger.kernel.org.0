Return-Path: <linux-rdma+bounces-948-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CCB84C7E1
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 10:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 516B81C23DEF
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 09:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8172E224DA;
	Wed,  7 Feb 2024 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+Vul9bq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3221624B2F;
	Wed,  7 Feb 2024 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707299383; cv=none; b=KZ5ocmu+BqCe3I4EyOLKDgCKPvsdRAPejqUtCWLRkoR9bij84YmPXDUNaZdpkdUrPF1ENcT6Iq3lPPX6Bf169w8IIoEdADzXCJ0moR9C5seIbohssheOplIuIKxXunOj2ORD0+2FRk1p28PxQalUyPtBzqX9E7qQoSNx5OP0mHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707299383; c=relaxed/simple;
	bh=iaPJLCw/Xy+KGXqtOa/G1rsYICV+i+x8OmFlAgHnp7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaTra8wYXIPw387ys7PU0sDj8Etbu9cnuGffySuzvU8amtQQUd01XiDfjUblrAY9NWWTDbOIs4kth97LBOlJY91J+VESL77PdkjbvUgvQQbpbOgSpwsbGZZItaxdkSPFduRaBIvZcB9sj08YXPKOXUwe0damvAFZrmjA8OpcaCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+Vul9bq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE59C433C7;
	Wed,  7 Feb 2024 09:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707299383;
	bh=iaPJLCw/Xy+KGXqtOa/G1rsYICV+i+x8OmFlAgHnp7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J+Vul9bqfemWsLYL963wUa4MjMJGapEgDfRHrT1NByLcjIGeELuDwCbLITaom9AeY
	 Rep4tYFuHlv8iNYCJzFdvw1OC3COym1wVptqJrVnDEtoa5Gm0pzpF4baL+3J9sHmTf
	 08WM61TGPbzR4Qa2Qo61alnOcUu8mYArqElhk5XbaaZ0pVaxl63jL0sPoFZAKvp1IQ
	 E9KMiYavIim0MtCaPZ+KTNbMxVgMHDGJliuL4zcZrdDdeE2wMJTTq1Y05UJuSLfusQ
	 JR15HUZ6Ym3oJMQQc8JqsjdXntvOuefg78Uarl5/EsFdDPWmEu5zs4xKFadGdLFCgX
	 KurQ3rTSg6C1w==
Date: Wed, 7 Feb 2024 09:48:08 +0000
From: Simon Horman <horms@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mlx5: remove redundant assignment to variable
 object_range
Message-ID: <20240207094808.GO1104779@kernel.org>
References: <20240206165815.2420951-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206165815.2420951-1-colin.i.king@gmail.com>

On Tue, Feb 06, 2024 at 04:58:15PM +0000, Colin Ian King wrote:
> The variable object_range to log_header_modify_argument_granularity
> is being assigned a value that is never read, the following statement
> assigns object_range to the max of log_header_modify_argument_granularity
> and DR_ICM_MODIFY_HDR_GRANULARITY_4K, so clearly the initial
> assignment is redundant. Remove it.
> 
> Cleans up clang-scan build warning:
> drivers/net/ethernet/mellanox/mlx5/core/steering/dr_arg.c:42:2: warning:
> Value stored to 'object_range' is never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thanks Colin,

Reviewed-by: Simon Horman <horms@kernel.org>

