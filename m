Return-Path: <linux-rdma+bounces-13045-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBF4B40D6C
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Sep 2025 20:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5F8164FA3
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Sep 2025 18:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC656341ADA;
	Tue,  2 Sep 2025 18:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7F/tT6y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6B719F12A;
	Tue,  2 Sep 2025 18:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756839368; cv=none; b=bpqJR9sOTzugux9TQjczFhoCe+tzO/uWmHNJ4dPRK1aSjAHB6cWjXJKUE/AnXvqePKR4WaaXSsSBGWAQbrXmxnslUDJ2xOe8+6r5eTmr8+u19ynYYPgCjGxe1rme6B9S2j/aE6YWeqbQXX8sbHOGSvda0mxGE4EHYxxcItcSXv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756839368; c=relaxed/simple;
	bh=YTKxsfW0Yr5gDhS1iDA/vpuPyuxHk2F2mqFRLf8Kv8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMTZo8rzN0ThaJPmaR12sl61Lr4nZwLkVspu+BQ/wOteN4Lcyysztg3fh22o6p4JKgWDb1ha3Cq0ORe1G8LAsVDd3mFO+uTBmnBEr3CmQSyHx7wFyNnzeuMIcfWoErERL5jH/GrmsZoV46asfmSNQOrft9IRFARpyxPfVhCerlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7F/tT6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBB7C4CEED;
	Tue,  2 Sep 2025 18:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756839367;
	bh=YTKxsfW0Yr5gDhS1iDA/vpuPyuxHk2F2mqFRLf8Kv8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X7F/tT6y0ljtU46rQx5ypDmPe8ONbxMaaY4gPA3sXQaEamRW7Y33WoOA7vj7Zng8c
	 IF0chkHTXJyZOh7zXfPYdw+we+1sYvEo5cWqL5Ij/pYCJ5orV7oIBuDItqplp813ze
	 T8a34hnkTq4K93ZuRuJP9LKp9vQpe2h7zvEMExmS1KzTSdm54ZGoSXYq7qjvvUSp0W
	 DzN9qyrzH1eYUWplN6Ho3RIaj45JyocR21fPASQUAdjvbQz7QQhFOhALS0R2kBUZO3
	 Kjz9CyVRcFujsv4szzjzXlKXp/sPK9DnajYLNuH3vxo7hgqUniU+QMOJHDUduecPuV
	 WWiyXEnlmKhJg==
Date: Tue, 2 Sep 2025 11:56:06 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Mingrui Cui <mingruic@outlook.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mlx5e: Make DEFAULT_FRAG_SIZE relative to page size
Message-ID: <aLc9xknpad29kSnH@x130>
References: <MN6PR16MB5450CAF432AE40B2AFA58F61B706A@MN6PR16MB5450.namprd16.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <MN6PR16MB5450CAF432AE40B2AFA58F61B706A@MN6PR16MB5450.namprd16.prod.outlook.com>

On 02 Sep 21:00, Mingrui Cui wrote:
>When page size is 4K, DEFAULT_FRAG_SIZE of 2048 ensures that with 3
>fragments per WQE, odd-indexed WQEs always share the same page with
>their subsequent WQE. However, this relationship does not hold for page
>sizes larger than 8K. In this case, wqe_index_mask cannot guarantee that
>newly allocated WQEs won't share the same page with old WQEs.
>
>If the last WQE in a bulk processed by mlx5e_post_rx_wqes() shares a
>page with its subsequent WQE, allocating a page for that WQE will
>overwrite mlx5e_frag_page, preventing the original page from being
>recycled. When the next WQE is processed, the newly allocated page will
>be immediately recycled.
>
>In the next round, if these two WQEs are handled in the same bulk,
>page_pool_defrag_page() will be called again on the page, causing
>pp_frag_count to become negative.
>
>Fix this by making DEFAULT_FRAG_SIZE always equal to half of the page
>size.
>
>Signed-off-by: Mingrui Cui <mingruic@outlook.com>
CC:  Dragos Tatulea <dtatulea@nvidia.com>

Dragos is on a mission to improve page_size support in mlx5.

Dragos, please look into this, I am not sure making  DEFAULT_FRAG_SIZE
dependant on PAGE_SIZE is the correct way to go,
see mlx5e_build_rq_frags_info()

I believe we don't do page flipping for > 4k pages, but I might be wrong,
anyway the code also should throw a warn_on: 

/* The last fragment of WQE with index 2*N may share the page with the
  * first fragment of WQE with index 2*N+1 in certain cases. If WQE
  * 2*N+1
  * is not completed yet, WQE 2*N must not be allocated, as it's
  * responsible for allocating a new page.
  */
if (frag_size_max == PAGE_SIZE) {
	/* No WQE can start in the middle of a page. */
	info->wqe_index_mask = 0;
} else {
	/* PAGE_SIZEs starting from 8192 don't use 2K-sized fragments,
	 * because there would be more than MLX5E_MAX_RX_FRAGS of
	 * them.
	 */
	WARN_ON(PAGE_SIZE != 2 * DEFAULT_FRAG_SIZE);
	/* Odd number of fragments allows to pack the last fragment of
	 * the previous WQE and the first fragment of the next WQE
	 * into
	 * the same page.
	 * As long as DEFAULT_FRAG_SIZE is 2048, and
	 * MLX5E_MAX_RX_FRAGS
	 * is 4, the last fragment can be bigger than the rest only
	 * if
	 * it's the fourth one, so WQEs consisting of 3 fragments
	 * will
	 * always share a page.
	 * When a page is shared, WQE bulk size is 2, otherwise
	 * just 1.
	 */
	info->wqe_index_mask = info->num_frags % 2;
}

Looking at the above makes me think that this patch is correct, but a more
careful look is needed to be taken, a Fixes tag is also required and target
'net' branch.

Thanks,
Saeed.

>---
> drivers/net/ethernet/mellanox/mlx5/core/en/params.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
>index 3cca06a74cf9..d96a3cbea23c 100644
>--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
>+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
>@@ -666,7 +666,7 @@ static void mlx5e_rx_compute_wqe_bulk_params(struct mlx5e_params *params,
> 	info->refill_unit = DIV_ROUND_UP(info->wqe_bulk, split_factor);
> }
>
>-#define DEFAULT_FRAG_SIZE (2048)
>+#define DEFAULT_FRAG_SIZE (PAGE_SIZE / 2)
>
> static int mlx5e_build_rq_frags_info(struct mlx5_core_dev *mdev,
> 				     struct mlx5e_params *params,
>-- 
>2.43.0
>
>

