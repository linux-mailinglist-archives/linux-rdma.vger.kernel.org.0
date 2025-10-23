Return-Path: <linux-rdma+bounces-14019-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6A5C017CE
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 15:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6509B1897A27
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 13:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3EC309EE8;
	Thu, 23 Oct 2025 13:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bd5itopO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34F428E00;
	Thu, 23 Oct 2025 13:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761226266; cv=none; b=M0LvKUY/10q5p2FDgg3EUHcH6Ls13MagYEIrAt+8tzljLE7kLIP/I3GEnC0xRKDCKqFcG2uI4A3nfMxA1Cl+6Skcf3bySlUicdljjCtKcosuMgCoV57mpfu7nS2ndEn8QRam+aHe2v7YQquQ0D5VUvKoH/72+82yXR2IVIkQajU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761226266; c=relaxed/simple;
	bh=XqRmK0MZlaU2At8JXpDWFcOda0194aVh/uzRd9dH8N4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBFLeCrYafQrAZ0hlykdx+lKSm/G8Fkcx1daw/BPJSyRatEY0TUcPWO/YP6C3t06s25YP3lw9gnfXEKLuypdIQY6TF3TJjrAuDz3yqY9jAJMBfpVj0PvG93xvMRRNditx6IFYhCPmCDjmPliO4XtF/ET5qSFsl/F2xMut5tGXiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bd5itopO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460F6C4CEF7;
	Thu, 23 Oct 2025 13:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761226265;
	bh=XqRmK0MZlaU2At8JXpDWFcOda0194aVh/uzRd9dH8N4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bd5itopOM5mU+dW25Uowyeuwa/21vubCtI88fOy4p8KUXzYul7gbmYPsFiH75z7si
	 dRdg2o+bTpw7rxytFwP5zQWIhFn3xmhyNnw+15+EWSBIZsq87v6BzTVa8xU3GKH3hb
	 q0veKio2usvtduYIaGdOD5UH/RBwuOKDOuMxBrIwePrashNT/Y4xrAIjdyBHxrz4xQ
	 N969lkKG3RBgSbn/YJicpvym8WRGpNc6/SjtijoZBXdcyvoFFUlgLAcWIwJ16d5ES7
	 OMHi2hPfSocFUxCevYpu/Ud/N2a5gYS3CcqaFpmfTuqVSjiGUSrKC5rzS82FORfq/3
	 8Kq8uaFisOMsw==
Date: Thu, 23 Oct 2025 14:31:00 +0100
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
	Carolina Jubran <cjubran@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next 2/7] net/mlx5e: Use TIR API in
 mlx5e_modify_tirs_lb()
Message-ID: <aPouFMQsE48tkse9@horms.kernel.org>
References: <1761201820-923638-1-git-send-email-tariqt@nvidia.com>
 <1761201820-923638-3-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1761201820-923638-3-git-send-email-tariqt@nvidia.com>

On Thu, Oct 23, 2025 at 09:43:35AM +0300, Tariq Toukan wrote:

...

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
> index 376a018b2db1..fad6b761f622 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
> @@ -250,43 +250,30 @@ void mlx5e_destroy_mdev_resources(struct mlx5_core_dev *mdev)
>  int mlx5e_modify_tirs_lb(struct mlx5_core_dev *mdev, bool enable_uc_lb,
>  			 bool enable_mc_lb)

...

>  	list_for_each_entry(tir, &mdev->mlx5e_res.hw_objs.td.tirs_list, list) {
> -		tirn = tir->tirn;
> -		err = mlx5_core_modify_tir(mdev, tirn, in);
> +		err = mlx5e_tir_modify(tir, builder);
>  		if (err)
>  			break;
>  	}
>  	mutex_unlock(&mdev->mlx5e_res.hw_objs.td.list_lock);
>  
> -	kvfree(in);
> +	mlx5e_tir_builder_free(builder);
>  	if (err)
>  		mlx5_core_err(mdev,
>  			      "modify tir(0x%x) enable_lb uc(%d) mc(%d) failed, %d\n",
> -			      tirn,
> +			      mlx5e_tir_get_tirn(tir),

Sorry, for not noticing this before sending my previous email.

Coccinelle complains about the line above like this:

.../en_common.c:276:28-31: ERROR: invalid reference to the index variable of the iterator on line 265

I think this is a false positive because the problem only occurs if
the list iteration runs to completion. But err guards against
tir being used in that case.

But, perhaps, to be on the safe side, it would be good practice
to stash tir somewhere?

>  			      enable_uc_lb, enable_mc_lb, err);
>  
>  	return err;
> -- 
> 2.31.1
> 
> 

