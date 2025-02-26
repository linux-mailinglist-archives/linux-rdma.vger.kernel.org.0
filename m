Return-Path: <linux-rdma+bounces-8170-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D39A46A20
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 19:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CA5C16C8C3
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 18:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30F8235BF5;
	Wed, 26 Feb 2025 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="by4ovl24"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A910723535E;
	Wed, 26 Feb 2025 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740595777; cv=none; b=SXjAirYlUsHRgwQo8HmXKoUbOnLLgiRnXY379A3rxzmdbmLn1ld9MsQbTd1TL9rrzpA+FwfVpElXoX/aZQq6BY5sagQ1KXZL+oinzRtY5/agf0cvNojQ5xH+C9Rj8Jd4oBof5cD1mf2IaqcKBoml3CLjlnImq9lgerxhUSKKaks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740595777; c=relaxed/simple;
	bh=xGnAoCtrL4SJxvd4YJG63aFaBi2DqwKPVCV7akM3pFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmeoMdbj6ONvkwOPwwBpAwy63V4GxyGD0WKosmwf2rzEnUnct0mRkVF5HVafUQd9YeVfXANtDAHCXVPDNdWVOOfO/p1pQkvjLBQGbbjv2u2KZFCcxgnWDxOKyqaqrbGv+8ZUrrdcgu5JLiiZJGyRd4V8rAwFMOsfu5Foa27Y4ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=by4ovl24; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206F5C4CED6;
	Wed, 26 Feb 2025 18:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740595777;
	bh=xGnAoCtrL4SJxvd4YJG63aFaBi2DqwKPVCV7akM3pFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=by4ovl240vLVWQyD8uL0FQuBbuOPuubKpd1l4EsFrQPf6TvekfMl3mkUVrqovgoB2
	 65UrsVFWYoBK70Lin1NrOo7cduddfUieSwrovzGXsYDhQX7KD1BRtRFmVrq9dlWnWh
	 iMGxE5SSikvEPXtllFEQY19BF+8fcSY/WrmdOeLi4UrZKUneLwA3rbJ9MueLyNILsP
	 xaKFJ+U/iEWXKnjPrCDJEuV1tmH8+OjG993E9OzExkF1gy5BMe3V7tJdJc0vbOP7TI
	 pGzPoGngA0bSD0mVLDlVCArEKK9TCgtYL4W/2A+N5RP9LLoaIOWZpzdPYGxZ9x5W60
	 7nrpAkN1Mmqug==
Date: Wed, 26 Feb 2025 10:49:35 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3][next] net/mlx5e: Avoid a hundred
 -Wflex-array-member-not-at-end warnings
Message-ID: <Z79iP0glNCZOznu4@x130>
References: <Z76HzPW1dFTLOSSy@kspp>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z76HzPW1dFTLOSSy@kspp>

On 26 Feb 13:47, Gustavo A. R. Silva wrote:
>-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>getting ready to enable it, globally.
>
>So, in this particular case, we create a new `struct mlx5e_umr_wqe_hdr`
>to enclose the header part of flexible structure `struct mlx5e_umr_wqe`.
>This is, all the members except the flexible arrays `inline_mtts`,
>`inline_klms` and `inline_ksms` in the anonymous union. We then replace
>the header part with `struct mlx5e_umr_wqe_hdr hdr;` in `struct
>mlx5e_umr_wqe`, and change the type of the object currently causing
>trouble `umr_wqe` from `struct mlx5e_umr_wqe` to `struct
>mlx5e_umr_wqe_hdr` --this last bit gets rid of the flex-array-in-the-middle
>part and avoid the warnings.
>
>Also, no new members should be added to `struct mlx5e_umr_wqe`, instead
>any new members must be included in the header structure `struct
>mlx5e_umr_wqe_hdr`. To enforce this, we use `static_assert()`, ensuring
>that the memory layout of both the flexible structure and the newly
>created header struct remain consistent.
>
>The next step is to refactor the rest of the related code accordingly,
>which means adding a bunch of `hdr.` wherever needed.
>
>Lastly, we use `container_of()` whenever we need to retrieve a pointer
>to the flexible structure `struct mlx5e_umr_wqe`.
>
>So, with these changes, fix 125 of the following warnings:
>
>drivers/net/ethernet/mellanox/mlx5/core/en.h:664:48: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>
>Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>---
>Changes in v3:
> - Update error message in the assertion.
> - Also, this part is intentionally left as-is (to keep the assertion
>   as close as possible to the flex struct):
>
>| CHECK: Please use a blank line after function/struct/union/enum declarations
>| #63: FILE: drivers/net/ethernet/mellanox/mlx5/core/en.h:249:
>| };
>| +static_assert(offsetof(struct mlx5e_umr_wqe, inline_mtts) == sizeof(struct mlx5e_umr_wqe_hdr),
>
>Changes in v2:
> - Split the header members of `struct mlx5e_umr_wqe` into a
>   separate `struct mlx5e_umr_wqe_hdr`, and refactor the code
>   accordingly. (Jakub)
> - Update the changelog text.
> - Link: https://lore.kernel.org/linux-hardening/Z76FE8oZO2Ssuj9T@kspp/
>
>v1:
> - Link: https://lore.kernel.org/linux-hardening/Z6GCJY8G9EzASrwQ@kspp/
>
> drivers/net/ethernet/mellanox/mlx5/core/en.h  | 10 +++++++--
> .../ethernet/mellanox/mlx5/core/en/xsk/rx.c   |  6 ++---
> .../net/ethernet/mellanox/mlx5/core/en_main.c |  8 ++++---
> .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 22 +++++++++----------
> 4 files changed, 27 insertions(+), 19 deletions(-)
>
>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
>index 979fc56205e1..90de40521029 100644
>--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
>+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
>@@ -232,16 +232,22 @@ struct mlx5e_rx_wqe_cyc {
> 	DECLARE_FLEX_ARRAY(struct mlx5_wqe_data_seg, data);
> };
>
>-struct mlx5e_umr_wqe {
>+struct mlx5e_umr_wqe_hdr {
> 	struct mlx5_wqe_ctrl_seg       ctrl;
> 	struct mlx5_wqe_umr_ctrl_seg   uctrl;
> 	struct mlx5_mkey_seg           mkc;
>+};
>+
>+struct mlx5e_umr_wqe {
>+	struct mlx5e_umr_wqe_hdr hdr;

You missed or ignored my comment on v0, anyway:

Can we have struct mlx5e_umr_wq_hdr defined anonymously within
mlx5e_umr_wqe? Let's avoid namespace pollution.



