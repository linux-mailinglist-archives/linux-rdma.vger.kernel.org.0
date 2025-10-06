Return-Path: <linux-rdma+bounces-13790-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3B2BBF102
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Oct 2025 21:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C71393C0188
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Oct 2025 19:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8685A2DAFDE;
	Mon,  6 Oct 2025 19:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRc23EC1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395B92D2385;
	Mon,  6 Oct 2025 19:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759777739; cv=none; b=DlDIMbDXnD1OAPUV9RUFSZK+CtnQ3pBLjxX7njaY6VeLT67MO9i90/h1V1hRPsmp6U+EhaAX4vOuPsWodS2TFq/I1DzFad62waiVvGgisL9Q6uP34vlfE4jFRoew5DxC3VOveYgUutN/w61ICqnZxrNIGRkrvF8+NrqW1Z49up0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759777739; c=relaxed/simple;
	bh=JXfU8bWkOolKdCb1cb9vA0EU4NBq1e8S2Tlws9I7JHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVuWhtiHggU0xkDnk63EdVyhAh9CTnZDp/Ufnj2b7tAJWzEjyyjXroKz022lHypULoW2PVvimC0W+t6uUz0XzrrYMgeNOv8NfDH0zT0J+kqopbN5saP5iKkNc8o1d0t4Y/O8AEZ6/Dx3n0per6u3SuJBESkQ3GcfmiNbYk2kJzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRc23EC1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8BCC4CEF5;
	Mon,  6 Oct 2025 19:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759777738;
	bh=JXfU8bWkOolKdCb1cb9vA0EU4NBq1e8S2Tlws9I7JHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CRc23EC1JbirO285FpjGjoy3wAg5uDE1ktJk6CZcou0dgi/ajb5QuijxozBZVOMDm
	 rYcmnPMxbcfNgd1JUbdfZmbEqCpspbMmO+Jv30CM5NJoZBC7Knt37TQr0xpycwXBMq
	 3esEJd/tbl8Nx6TNkIkXsGg7igQiuA4ojwF+Ov/SkU601iQZMjAxNWjL38425+3mzG
	 32CkRXKGwXKF4JhpJcXYsAkLFwRTxlKckABopZ3wXbb+nTW+Fk/78rjACndWxwVYj4
	 i4zlwbqFuX9KMTe7KJvQsKbH1jM8DZm8ofdZIiP+sAgLLwVdiX60S1gnBY3pnodoH5
	 YxvKz4k+CR60w==
Date: Mon, 6 Oct 2025 12:08:51 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Simon Horman <horms@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mlx5: fix pre-2.40 binutils assembler error
Message-ID: <20251006190851.GB2406882@ax162>
References: <20251006115640.497169-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006115640.497169-1-arnd@kernel.org>

On Mon, Oct 06, 2025 at 01:56:34PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Old binutils versions require a slightly stricter syntax for the .arch_extension
> directive and fail with the extra semicolon:
> 
> /tmp/cclfMnj9.s:656: Error: unknown architectural extension `simd;'
> 
> Drop the semicolon to make it work with all supported toolchain version.
> 
> Link: https://lore.kernel.org/all/20251001163655.GA370262@ax162/
> Reported-by: Paolo Abeni <pabeni@redhat.com>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Fixes: fd8c8216648c ("net/mlx5: Improve write-combining test reliability for ARM64 Grace CPUs")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  drivers/net/ethernet/mellanox/mlx5/core/wc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/wc.c b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
> index c281153bd411..05e5fd777d4f 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/wc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
> @@ -266,7 +266,7 @@ static void mlx5_iowrite64_copy(struct mlx5_wc_sq *sq, __be32 mmio_wqe[16],
>  	if (cpu_has_neon()) {
>  		kernel_neon_begin();
>  		asm volatile
> -		(".arch_extension simd;\n\t"
> +		(".arch_extension simd\n\t"
>  		"ld1 {v0.16b, v1.16b, v2.16b, v3.16b}, [%0]\n\t"
>  		"st1 {v0.16b, v1.16b, v2.16b, v3.16b}, [%1]"
>  		:
> -- 
> 2.39.5
> 

