Return-Path: <linux-rdma+bounces-14126-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E0CC1BCED
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Oct 2025 16:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9391A226E8
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Oct 2025 15:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C19E34FF69;
	Wed, 29 Oct 2025 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ct932OGc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DEB34F48F;
	Wed, 29 Oct 2025 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753084; cv=none; b=pb4NapTrgGzAJPYzsejlGofk/BMGp8j5MHuWsYobJPxRqFJDMIO34qlSxQt/11ILmwcbc/5lsovBrG/AG5cpTAoTjutr/yaR/wCRfcCLh1hPEWS9Cj63MfN6S4rMdIfvhuwcU/mp0pkJbg/MdVYigQJQYjQ8Od9smNoH8fy4j+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753084; c=relaxed/simple;
	bh=fAuh1ZwrVRzJE7F0Hieu4U/dY1Mamd78vSjATD3RjTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bp3FIr7KUW7MfFNpIzegSHYEuyapYs8DfvQl3dNZIszC3NwLji/IecTtVItI+XNlxB3XR3Lvnivv8q6JSTivAOu/VLfKB0nICOuXMB0ijP/tbK4LD+AsyVk3VE6zPadiWlT/lFCdasoe+0u2aJm3rpGdWDM/7cu7JYgBXkBXoJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ct932OGc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA20C4CEF8;
	Wed, 29 Oct 2025 15:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761753083;
	bh=fAuh1ZwrVRzJE7F0Hieu4U/dY1Mamd78vSjATD3RjTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ct932OGcYnA90PQtTCRe+3JADI10FmwzWcWl3iIZwSB4TMO7KkhIFtRgNgYBEm0mA
	 8wPojx5aDL73UK55MsaDTWlICVu77IEaYz4Ia5Zfzk/8LGFMoPwqVG/+78afpNs7sm
	 bVZxo2/I2xljEFekECwXBVEHko2CNojiVlU2VdkDfn8e0X5yTdKmf3mAPgGqh+tUTO
	 DZY0H3chQpLmCILKN4vOP3qriu7Qo/qkfBNub+kGXjb6UVNinJC5Njda44bMduqAkw
	 QWUR2TNGbLLDNbJ7VNUF5nQLJWZpckU7MjEVo8yCR1jtq3pmI/dCKmpPmWJPls1FlW
	 4WT4DECKDza0Q==
Date: Wed, 29 Oct 2025 15:51:18 +0000
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net 1/3] net/mlx5e: SHAMPO, Fix header mapping for 64K
 pages
Message-ID: <aQI39mMN-YADabUB@horms.kernel.org>
References: <1761634039-999515-1-git-send-email-tariqt@nvidia.com>
 <1761634039-999515-2-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1761634039-999515-2-git-send-email-tariqt@nvidia.com>

On Tue, Oct 28, 2025 at 08:47:17AM +0200, Tariq Toukan wrote:
> From: Dragos Tatulea <dtatulea@nvidia.com>
> 
> HW-GRO is broken on mlx5 for 64K page sizes. The patch in the fixes tag
> didn't take into account larger page sizes when doing an align down
> of max_ksm_entries. For 64K page size, max_ksm_entries is 0 which will skip
> mapping header pages via WQE UMR. This breaks header-data split
> and will result in the following syndrome:
> 
> mlx5_core 0000:00:08.0 eth2: Error cqe on cqn 0x4c9, ci 0x0, qn 0x1133, opcode 0xe, syndrome 0x4, vendor syndrome 0x32
> 00000000: 00 00 00 00 04 4a 00 00 00 00 00 00 20 00 93 32
> 00000010: 55 00 00 00 fb cc 00 00 00 00 00 00 07 18 00 00
> 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 4a
> 00000030: 00 00 3b c7 93 01 32 04 00 00 00 00 00 00 bf e0
> mlx5_core 0000:00:08.0 eth2: ERR CQE on RQ: 0x1133
> 
> Furthermore, the function that fills in WQE UMRs for the headers
> (mlx5e_build_shampo_hd_umr()) only supports mapping page sizes that
> fit in a single UMR WQE.
> 
> This patch goes back to the old non-aligned max_ksm_entries value and it
> changes mlx5e_build_shampo_hd_umr() to support mapping a large page over
> multiple UMR WQEs.
> 
> This means that mlx5e_build_shampo_hd_umr() can now leave a page only
> partially mapped. The caller, mlx5e_build_shampo_hd_umr(), ensures that

It's not particularly important, but I think the caller is
mlx5e_alloc_rx_hd_mpwqe().

> there are enough UMR WQEs to cover complete pages by working on
> ksm_entries that are multiples of MLX5E_SHAMPO_WQ_HEADER_PER_PAGE.
> 
> Fixes: 8a0ee54027b1 ("net/mlx5e: SHAMPO, Simplify UMR allocation for headers")
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 34 +++++++++----------
>  1 file changed, 16 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> index 1c79adc51a04..77f7a1ca091d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -679,25 +679,24 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
>  	umr_wqe = mlx5_wq_cyc_get_wqe(&sq->wq, pi);
>  	build_ksm_umr(sq, umr_wqe, shampo->mkey_be, index, ksm_entries);
>  
> -	WARN_ON_ONCE(ksm_entries & (MLX5E_SHAMPO_WQ_HEADER_PER_PAGE - 1));
> -	while (i < ksm_entries) {
> -		struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, index);
> +	for ( ; i < ksm_entries; i++, index++) {

Also, if you have to respin for some reason, I would move the
initialisation of i to 0 from it's declaration to the for loop.

...

