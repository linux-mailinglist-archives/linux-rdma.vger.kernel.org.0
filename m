Return-Path: <linux-rdma+bounces-2032-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8178AFBD8
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Apr 2024 00:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4120A1F2312C
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Apr 2024 22:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FCE1DDC5;
	Tue, 23 Apr 2024 22:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Z2EZZIQf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F43C10949
	for <linux-rdma@vger.kernel.org>; Tue, 23 Apr 2024 22:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713911937; cv=none; b=O6sFPr7EoDEXwGvd1HrTVA5AYuAcaS+2xWsUp9g07PNP4QVfH4uMwm9xfq43z2wcRbDpLx3YsF1PAJiUB4FIbR/DqG9eBZZwCgzghAtu6dA4eTPU6JFj/hxBhYI+dI3uOXXJTSft8IYfRCV+VY3orDR0BB7q1h3LzXHEUy1FK+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713911937; c=relaxed/simple;
	bh=1pROOLzvYgFAvQOqlCQuvejs2/LA2hfbPAZih2dmTp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVvaHqnmvPS/hgjf+m/ZZWzv3OzllP7G2mldPolA3C1dLHqT8q9q12LKOMa1PX1V80IeHzHiMWMfAhFYfIJq1yKS1KQcMoFOVa8EXhBTLQTQID2XRm847ZwOW5a9UXNp9PHHkNJ2eHHhk7Egx2cBeeDASSLRGK1li/gnXLKyE64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Z2EZZIQf; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ee13f19e7eso5652817b3a.1
        for <linux-rdma@vger.kernel.org>; Tue, 23 Apr 2024 15:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1713911935; x=1714516735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v116oTmF2G8tcjqnmi5BBeYNjLNRAfDLk4IJTFjyTNc=;
        b=Z2EZZIQfKJl5veU9/FKQRNrsROGQAwHhfKOGdjl0uGmkEbVYHhn2Idk24Uyy92xKFF
         5U9shcqNd5kU1zsC1oIJmCggdXDVSh5ADv1L+3IVt2M6rVjj5yC03qHvEDwmN5rI/rzt
         gxo4pLdUpgBepTx87tEzZT53khZltihCDRRL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713911935; x=1714516735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v116oTmF2G8tcjqnmi5BBeYNjLNRAfDLk4IJTFjyTNc=;
        b=ngTsm7MbM6PRUg6L26I7B6b1L/JxAL/kLFtWmn48W4QzBCR02SBHE9zEyp+ARQtDtb
         5A+EayjYoKqSmATtQm0gNs6OpPYKHglEu3+yReEVRMP4ubtl1OHutILEnQPCSOpuNq9U
         xhgMIVA53XDU06e2k/9THMK5nfUjCQIqsUURKSHaSDYliL5veDR4sxrAlyyd/aWPmO5X
         lAZclePrNcAk1P13TJkWqjXItechKCFtiLOlLGSeOKHIlUA6Sk+Qm/B1HbVRyJwxeTP8
         /BD2+yoFjKQABUDvAIKHs2C2WdvgT00UpCF0cyyD4i2VgggWzAGf/9fuctflMCHK/QLC
         kEzA==
X-Forwarded-Encrypted: i=1; AJvYcCWEQeDo46/G77MHDwMoPOm++7jUEqYARoHOoZEiTls7+wCx0c53vS+Ib2qb8upPHPtxWsz5uLtEEaQaRhB6zgvhRij61tiQcOE3PA==
X-Gm-Message-State: AOJu0Ywl0emCGxKhULMxSWjZjhbuEULaCvClCQkBtum24yfg7uOvH0N/
	uRPsQ3q9O3yY0lpvlpxqD27Xw//x9ZYSq5+B1LrFWrv9MY9SwSadyghx5bTfYQs=
X-Google-Smtp-Source: AGHT+IGMn901wx8TYt9AQqDHfU3dkygWZi82tmpZMejTg3zDD+F0hjLw+9GT9DzvcwivByXEHkP6Iw==
X-Received: by 2002:a05:6a00:1911:b0:6ec:fdfe:9bde with SMTP id y17-20020a056a00191100b006ecfdfe9bdemr1132482pfi.25.1713911935171;
        Tue, 23 Apr 2024 15:38:55 -0700 (PDT)
Received: from LQ3V64L9R2 ([74.87.211.242])
        by smtp.gmail.com with ESMTPSA id kt19-20020a056a004bb300b006e6b989514bsm10175499pfb.60.2024.04.23.15.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 15:38:54 -0700 (PDT)
Date: Tue, 23 Apr 2024 12:38:50 -1000
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tariqt@nvidia.com,
	saeedm@nvidia.com
Cc: mkarsten@uwaterloo.ca, gal@nvidia.com, nalramli@fastly.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:MELLANOX MLX4 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next 1/3] net/mlx4: Track RX allocation failures in a
 stat
Message-ID: <Zig4etCiQ6AGlR4H@LQ3V64L9R2>
References: <20240423194931.97013-1-jdamato@fastly.com>
 <20240423194931.97013-2-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423194931.97013-2-jdamato@fastly.com>

On Tue, Apr 23, 2024 at 07:49:28PM +0000, Joe Damato wrote:
> mlx4_en_alloc_frags currently returns -ENOMEM when mlx4_alloc_page
> fails but does not increment a stat field when this occurs.
> 
> struct mlx4_en_rx_ring has a dropped field which is tabulated in
> mlx4_en_DUMP_ETH_STATS, but never incremented by the driver.
> 
> This change modifies mlx4_en_alloc_frags to increment mlx4_en_rx_ring's
> dropped field for the -ENOMEM case.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> ---
>  drivers/net/ethernet/mellanox/mlx4/en_port.c | 4 +++-
>  drivers/net/ethernet/mellanox/mlx4/en_rx.c   | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_port.c b/drivers/net/ethernet/mellanox/mlx4/en_port.c
> index 532997eba698..c4b1062158e1 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_port.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_port.c
> @@ -151,7 +151,7 @@ void mlx4_en_fold_software_stats(struct net_device *dev)
>  {
>  	struct mlx4_en_priv *priv = netdev_priv(dev);
>  	struct mlx4_en_dev *mdev = priv->mdev;
> -	unsigned long packets, bytes;
> +	unsigned long packets, bytes, dropped;

Err, sorry forgot to initialize this to 0 below with the rest of the init.
Will fix this in v2 (and whatever other feedback there is). Apologies on
the error here on my part.

>  	int i;
>  
>  	if (!priv->port_up || mlx4_is_master(mdev->dev))
> @@ -164,9 +164,11 @@ void mlx4_en_fold_software_stats(struct net_device *dev)
>  
>  		packets += READ_ONCE(ring->packets);
>  		bytes   += READ_ONCE(ring->bytes);
> +		dropped += READ_ONCE(ring->dropped);
>  	}
>  	dev->stats.rx_packets = packets;
>  	dev->stats.rx_bytes = bytes;
> +	dev->stats.rx_missed_errors = dropped;
>  
>  	packets = 0;
>  	bytes = 0;
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> index 8328df8645d5..573ae10300c7 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> @@ -82,8 +82,10 @@ static int mlx4_en_alloc_frags(struct mlx4_en_priv *priv,
>  
>  	for (i = 0; i < priv->num_frags; i++, frags++) {
>  		if (!frags->page) {
> -			if (mlx4_alloc_page(priv, frags, gfp))
> +			if (mlx4_alloc_page(priv, frags, gfp)) {
> +				ring->dropped++;
>  				return -ENOMEM;
> +			}
>  			ring->rx_alloc_pages++;
>  		}
>  		rx_desc->data[i].addr = cpu_to_be64(frags->dma +
> -- 
> 2.25.1
> 

