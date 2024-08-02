Return-Path: <linux-rdma+bounces-4185-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5D1945D42
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Aug 2024 13:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58F7DB2217E
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Aug 2024 11:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F225F1E2865;
	Fri,  2 Aug 2024 11:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="kTWl68we"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58341E2122
	for <linux-rdma@vger.kernel.org>; Fri,  2 Aug 2024 11:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722598074; cv=none; b=exojbVRJJAHLWh4td3iglaEd5PZe5ff8uFCDey1VaRHl1j3uuiCzdn50W7Bi6qI8oxi1s5TKTU/0/Gm412V1ujBDQMODsSh8ADBZSGeuU0dqJ8a+UWRRhULgBDr54+6sqsu9fPMLkWiEWhVCparj0LL82e8xYPPV9DrG41THwsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722598074; c=relaxed/simple;
	bh=BE7dpG8W2PpOKUlssqTXhlePO4gl/CQaWw0AeimD9y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnEd2sJVAo0OAcZXg/stml8ns1uOIJ3vsYQc93sVuySrfuFeSV7PJ9BrK3RLRUMuw51HRogT6L75jMfelEaneZLWoQSVpFhjE3kwK3hkKBVbNmvD201V6fntHiBf4i7mTbL+Zrf4cSm/3zVIsRz2RDjngxBqDKfDBXiTf98Cyrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=kTWl68we; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so12489545e9.2
        for <linux-rdma@vger.kernel.org>; Fri, 02 Aug 2024 04:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1722598070; x=1723202870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=chN/5IqC5/jQjFOqjkhbCXjZQHoVidazye4I/EM8vkk=;
        b=kTWl68wedmlpbnpxUW1ltHUuJHXQftgtls2Smo05lXtV3V9+3ayUXxSW9RM+b4GouV
         PHJ3vc85V6PH8/jND8E535KkIzSXtY1qPUahm4bNZ14uBCZrPBH66XAM9ZPiOBbpAyjh
         WGcdxFV7GuZu6KMawkBSmtkE8jg2FwScsSGfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722598070; x=1723202870;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=chN/5IqC5/jQjFOqjkhbCXjZQHoVidazye4I/EM8vkk=;
        b=Gm+aD9BVqBCsCuEG9hQm1w9c3zrRQ2Mtv0EwsB2QyvLVWdeemc7DuNPOvtYggIn12X
         AU2KAVAoJQV7lrfYLor0xgQyxE2KN4cqfHYwiHf+yoGB9bZJisXToKuDQA+jO6sbivIK
         qCHXIHG5kjnMEXpRp4n3Qf+p5GMBlLLgdTceVCRFyFdidkQ5vOThY6BKRcMRg6a25M1t
         af3rb2QKIA2r0shwsGrkCFo8QyT77xgzzJLvykU0t7+PJDvVkLSM7DuCrzdqGZPn/rML
         2+1umH5+NPs4yDS+MTm6jrNZ/C9yXEkKG66eBSDbDoQwXIdV6hLirhIF5lmqoYO639dF
         sSbA==
X-Forwarded-Encrypted: i=1; AJvYcCW+hK0lhLRFPSeyOPrx655UGNRPyJQYtIl+hDOW1WRjUnmUdLO2v3j272idwJGR62WrNakyKv6OLCXcQ7WnkqYgAlb2A3jIjIct1g==
X-Gm-Message-State: AOJu0YwbZJU5q2F7XCk1GGB78byTGDQh8qoiL1IkQNYNsKs09GfZdiD3
	UzHTxhjKiIwHwO4M2anq+pf4gnYiGY2qaMkNTe/rrtJf2Ngz2dDYKERn8RuTM9U=
X-Google-Smtp-Source: AGHT+IH7hcdVBDXCsRevDN59P0EtrOCoyykAhwY0K0NGMZXYks/7iPTFXtJU/BBOxs8N4RGobZG6mA==
X-Received: by 2002:a05:600c:5102:b0:428:52a:3580 with SMTP id 5b1f17b1804b1-428e6af4b58mr18796515e9.3.1722598069823;
        Fri, 02 Aug 2024 04:27:49 -0700 (PDT)
Received: from LQ3V64L9R2 ([62.30.8.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e3c0b7sm29576275e9.23.2024.08.02.04.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 04:27:49 -0700 (PDT)
Date: Fri, 2 Aug 2024 12:27:46 +0100
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, dxu@dxuuu.xyz, ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com, donald.hunter@gmail.com,
	gal.pressman@linux.dev, tariqt@nvidia.com,
	willemdebruijn.kernel@gmail.com, saeedm@nvidia.com, leon@kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 03/12] eth: mlx5: allow disabling queues when
 RSS contexts exist
Message-ID: <ZqzCsvm8DW6PeKDQ@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	dxu@dxuuu.xyz, ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com,
	donald.hunter@gmail.com, gal.pressman@linux.dev, tariqt@nvidia.com,
	willemdebruijn.kernel@gmail.com, saeedm@nvidia.com, leon@kernel.org,
	linux-rdma@vger.kernel.org
References: <20240802001801.565176-1-kuba@kernel.org>
 <20240802001801.565176-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802001801.565176-4-kuba@kernel.org>

On Thu, Aug 01, 2024 at 05:17:52PM -0700, Jakub Kicinski wrote:
> Since commit 24ac7e544081 ("ethtool: use the rss context XArray
> in ring deactivation safety-check") core will prevent queues from
> being disabled while being used by additional RSS contexts.
> The safety check is no longer necessary, and core will do a more
> accurate job of only rejecting changes which can actually break
> things.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: saeedm@nvidia.com
> CC: tariqt@nvidia.com
> CC: leon@kernel.org
> CC: linux-rdma@vger.kernel.org
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> index 36845872ae94..0b941482db30 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> @@ -445,7 +445,6 @@ int mlx5e_ethtool_set_channels(struct mlx5e_priv *priv,
>  	unsigned int count = ch->combined_count;
>  	struct mlx5e_params new_params;
>  	bool arfs_enabled;
> -	int rss_cnt;
>  	bool opened;
>  	int err = 0;
>  
> @@ -499,17 +498,6 @@ int mlx5e_ethtool_set_channels(struct mlx5e_priv *priv,
>  		goto out;
>  	}
>  
> -	/* Don't allow changing the number of channels if non-default RSS contexts exist,
> -	 * the kernel doesn't protect against set_channels operations that break them.
> -	 */
> -	rss_cnt = mlx5e_rx_res_rss_cnt(priv->rx_res) - 1;
> -	if (rss_cnt) {
> -		err = -EINVAL;
> -		netdev_err(priv->netdev, "%s: Non-default RSS contexts exist (%d), cannot change the number of channels\n",
> -			   __func__, rss_cnt);
> -		goto out;
> -	}
> -
>  	/* Don't allow changing the number of channels if MQPRIO mode channel offload is active,
>  	 * because it defines a partition over the channels queues.
>  	 */
> -- 
> 2.45.2

Reviewed-by: Joe Damato <jdamato@fastly.com>

