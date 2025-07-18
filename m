Return-Path: <linux-rdma+bounces-12286-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C64AB09970
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jul 2025 03:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67FF97BA4CE
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jul 2025 01:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9761A315C;
	Fri, 18 Jul 2025 01:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRUffZBi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A4F1A0BE1;
	Fri, 18 Jul 2025 01:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752803566; cv=none; b=o7sk3+yFJzMfC055roOu2bjmsXS/cSF8tLHXJUX26Tjuhj+lZ7QU7TdvdGoS7T9+trydbou+CKiYMSEPVzoPUBOBf0k6ppfK3H0A94CuhX0OFYWaLjgfJ4Cc180w40fDow6WcBFBgbjQ1Q6SJuh+RaUDdqqk4P4V/fsdvkcxh+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752803566; c=relaxed/simple;
	bh=1cjPQZG49ULYWlm40rtP4WEZcJmw5m9FE/5gQLfKUIA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=diGGV5frH8LUdIngNfrrgB7EYt19SIs1DvS2i9Zw2uDp6s5D+Ip+ZkWLW9PyDY/eAMJ1L9JPcpdsA3sDu72lE7lVCAuYe3D7wd4bWqwlB3nhEbWvujsso9S1Pjjq4LLsIl3NxyA5GoS3W6FVnxGWK1h4Ek2WGXoOu21IUJA5i9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRUffZBi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30E9C4CEE3;
	Fri, 18 Jul 2025 01:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752803565;
	bh=1cjPQZG49ULYWlm40rtP4WEZcJmw5m9FE/5gQLfKUIA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kRUffZBi/nLRcXjM5TX7AGvwwEt2KTuk9Qhnudj6xyNAJ+NIzQ0PFuyI9HvuNwRT2
	 ReQq22zorTaVgw8OEcQFeIT3aVu6AlliVJZUwAkZ/FaWQ7HGl4xW7CtOHObTWn880E
	 snT+hFUSKIBRs/NpQJDxeGpeMc4dki3qrjP5MHmlXiDSIodjUGByVX4VAPRRgEEYIj
	 EvsJ9pbXrlx+z3TeJ4YdA98udVLwGo7K7rCjP3czmnK7xrgtGVvUG2T+Sc4TEEuRu9
	 PKrYb0sO+Ofx3x51qmqFQgYWzQmkbNr4FBw0c+9+oEbK01Oq98bP4DvWK0XuO0LvFE
	 VQ25DsokWnLiA==
Date: Thu, 17 Jul 2025 18:52:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeed@kernel.org>, Gal Pressman
 <gal@nvidia.com>, "Leon Romanovsky" <leon@kernel.org>, Saeed Mahameed
 <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Lama Kayal <lkayal@nvidia.com>
Subject: Re: [PATCH net-next V2 4/6] net/mlx5e: SHAMPO, Cleanup reservation
 size formula
Message-ID: <20250717185242.68891d37@kernel.org>
In-Reply-To: <1752675472-201445-5-git-send-email-tariqt@nvidia.com>
References: <1752675472-201445-1-git-send-email-tariqt@nvidia.com>
	<1752675472-201445-5-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Jul 2025 17:17:50 +0300 Tariq Toukan wrote:
> -	int rsrv_size = BIT(mlx5e_shampo_get_log_rsrv_size(mdev, params)) *
> -		MLX5E_SHAMPO_WQ_BASE_RESRV_SIZE;
>  	u16 num_strides = BIT(mlx5e_mpwqe_get_log_num_strides(mdev, params, xsk));
> -	int pkt_per_rsrv = BIT(mlx5e_shampo_get_log_pkt_per_rsrv(mdev, params));
> +	int pkt_per_rsrv = BIT(mlx5e_shampo_get_log_pkt_per_rsrv(params));
>  	u8 log_stride_sz = mlx5e_mpwqe_get_log_stride_size(mdev, params, xsk);
>  	int wq_size = BIT(mlx5e_mpwqe_get_log_rq_size(mdev, params, xsk));
>  	int wqe_size = BIT(log_stride_sz) * num_strides;
> +	int rsrv_size = MLX5E_SHAMPO_WQ_RESRV_SIZE;

So you fixed placement of rsrv_size for RCT but the change
to pkt_per_rsrv is still breaking the order :(

I'll pick the first 3 patches up, they look unrelated.

