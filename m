Return-Path: <linux-rdma+bounces-7835-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B32A3BE17
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 13:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A0F71893D5C
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 12:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C621E131B;
	Wed, 19 Feb 2025 12:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SE+Bpsw3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA451E0E0A;
	Wed, 19 Feb 2025 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739968263; cv=none; b=bvpvxqtfZcLv0pwuJ3G1YML2xFHGkscAwXpt2L1blpRvkzpmqTfegXFm2CseEDd5qZmOG6Woo33VkfbEaTNdWTNj7iQwlGgb/RL2hShc/UVDLNdi85APSROXfQhBCLqFbqNWFav4gyjYIjePwz0ssam82dn1RHDnhry3rOFJZy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739968263; c=relaxed/simple;
	bh=N127fdTUboMPXuJ362+JGpLt7EcgMa+g6C8TmK2MXBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwSDsPY/08L8h3/0t7owGfEc2ZLy3OX0chARpF16AZq4Yg2PNwPVAFO6gsHyXX5vwFdPoxGsV3ABlJ0ot2ioBiL5Dv6ff8fzFe/Hb86U7nVWbKvgETbpTiNpQNfHMZTjCK0y3yHwCqK4J+j1EuXgY2H8nYTJEI0MKDW23L9jGyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SE+Bpsw3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D688DC4CED1;
	Wed, 19 Feb 2025 12:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739968262;
	bh=N127fdTUboMPXuJ362+JGpLt7EcgMa+g6C8TmK2MXBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SE+Bpsw3ZkRmPo8/ZeJCgBP7lN7a+beE2wSqBGg5xUslnPJ4Bm3pPK+1ZRYf/FrVU
	 r3yPik7sW/eYuCsNbplRwS7jdVDHN7m//uQG23yajxfsaDyiUCW+YwFXJvO3R7nv/L
	 6+7wSBxGWQMGfP2341pGY+j23H90kr1VstsdzzGrfwGAB4MLiAkKIftt3dE6x9F1Zy
	 7Gm/WqtilJT/EsxRp5ftv6x90f1npyRC8tRPHfXM/NvvJD61iSQlUxObr2B8U8j3vv
	 pSo8x4VDq+e83n1xlhOt3peJ/lYQBgZOyvhxqk6dY7xp49conQm3bOpMiuuJpGy8TR
	 42b8JJCBXwrBA==
Date: Wed, 19 Feb 2025 14:30:57 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: jgg@ziepe.ca, sd@queasysnail.net, phaddad@nvidia.com,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mlx5: Add check for get_macsec_device()
Message-ID: <20250219123057.GF53094@unreal>
References: <20250218100200.2535141-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218100200.2535141-1-haoxiang_li2024@163.com>

On Tue, Feb 18, 2025 at 06:02:00PM +0800, Haoxiang Li wrote:
> Add check for the return value of get_macsec_device() in
> mlx5r_del_gid_macsec_operations() to prevent null pointer
> dereference.
> 
> Fixes: 58dbd6428a68 ("RDMA/mlx5: Handles RoCE MACsec steering rules addition and deletion")
> Cc: stable@vger.kernel.org

Definitely not.

> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  drivers/infiniband/hw/mlx5/macsec.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/mlx5/macsec.c b/drivers/infiniband/hw/mlx5/macsec.c
> index 3c56eb5eddf3..623b0a58f721 100644
> --- a/drivers/infiniband/hw/mlx5/macsec.c
> +++ b/drivers/infiniband/hw/mlx5/macsec.c
> @@ -354,6 +354,11 @@ void mlx5r_del_gid_macsec_operations(const struct ib_gid_attr *attr)
>  		}
>  	}
>  	macsec_device = get_macsec_device(ndev, &dev->macsec.macsec_devices_list);

At this stage macsec_device is valid.

> +	if (!macsec_device) {
> +		dev_put(ndev);
> +		mutex_unlock(&dev->macsec.lock);
> +		return;
> +	}
>  	mlx5_macsec_del_roce_rule(attr->index, dev->mdev->macsec_fs,
>  				  &macsec_device->tx_rules_list, &macsec_device->rx_rules_list);
>  	mlx5_macsec_del_roce_gid(macsec_device, attr->index);
> -- 
> 2.25.1
> 

