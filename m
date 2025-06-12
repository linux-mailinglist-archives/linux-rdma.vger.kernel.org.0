Return-Path: <linux-rdma+bounces-11278-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 637A5AD7CF0
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 23:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9565F189198D
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 21:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61922D8794;
	Thu, 12 Jun 2025 21:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="ukyhG9A1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D4B2D542F
	for <linux-rdma@vger.kernel.org>; Thu, 12 Jun 2025 21:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749762547; cv=none; b=YF31xFqgBqXHGs17Bi9rMpQea+SezZZzxDy5hSmkAK2WxXKKTKsTSPvAGDQ5Q7WVJaSpvrVjogRSWOmfH1tfiEss/8ZYPfXweoQ0ZXN4NzXysGTVKuIMLDcxLDhSVaOiCyJCeofb16Im3Q5dDoBCyHJMhLgDUJq4UUAKeeU4j7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749762547; c=relaxed/simple;
	bh=m7oou1dHujPBgqJuAwN9g9R2smh8qT/xltRdemukCJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQhsBM5YG2/H7RgFe6dZRVtiAtxEymg3LGOqitoJbX3/JepevCnhSnAQA1cKeD37xOLnh7uJcFHrHq3GvS1FVN4Klpkh1P7wfRYRqP91taZR3+7wkr6y5XR/7gcQ+BqbcGEQmHjXFDn2w3qlRNbEeJifGBANPSv3LVeEMET0w4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=ukyhG9A1; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a4e742dc97so1725922f8f.0
        for <linux-rdma@vger.kernel.org>; Thu, 12 Jun 2025 14:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1749762544; x=1750367344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hq3+yK1phccQ3oaWkqHGXWvj3PMsQEpv/itLEx5vl2A=;
        b=ukyhG9A1v3TBtjFyrRkK1yVVrZ5yx8Sv8TNvp7e5rfGB3UFSyuIrp/o/NMopv88QtQ
         SbCkcrFscZaYymjZ8TVdUjz66eLoBv0zox5ha/lmqvgKag7cf1o327jh2yhPGvEExfGp
         ESQX1IKzD0Z6gRxDekG5vjQ9Zu/alZM4l/gHOiQldcEmRZlbDbF3W700qehHxu2MLoc+
         6Zg78v3OAw3+wTSo4dOJa1E6Skwxd1Z9FTEerl4VMap2m+phi3gUeWyid/wzGrCm2CW3
         vbK123jXwx5nKh5imfEs+0iH+A30qIM5kSE+4oaf6RjBA+8m7XG5JvFuee0Ir55p8bIC
         bNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749762544; x=1750367344;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hq3+yK1phccQ3oaWkqHGXWvj3PMsQEpv/itLEx5vl2A=;
        b=cG489u3XYfuEki030H+JrrXOVAYFZOY4Ebn3EHT+hpQcr1ZzX8pmcGwIp2yQeP0Z0L
         hvckqwECTV21RD2WnxJ3U9L1D3v6e8hmgXASm6WZLa66bMDeE3UbyOgKw2v3kygDEaD+
         7sylSvv0WEPeYrA1Q49KM3mFTFEFVe7CqNkCw7cG5n5G/gYhRmtg3tYmVUvulefhqJ9U
         +x9O133gET05H6YMpLFo7PxxRR2z53D6/eYPnYaJwfBAVO4gy7OulMF/AwGZSpaHZkHE
         sy1gmA8LZwOYMluPp2f8fJOl6Bnu8Z6BhtBDshgMOHvSOUbmmLCDeKiQ3rg1+01duzJE
         JOaA==
X-Forwarded-Encrypted: i=1; AJvYcCWB1b/OCttkf+xg0XEdZyyDN+qOu+oMUwt+K6LLRZ85RZw6cog/Nfa3xGHMkf7zPslshdRC4d01VL6g@vger.kernel.org
X-Gm-Message-State: AOJu0YxrjlBCfg0HgpIapnfEx/eazZQx0bHHuQJH+w4e8WhGQJcGQWns
	bgKpkg+sdBnYk/Vncob2rW0caittujCBiBss0+zvN3bpQHZwQ9cMNxjWFZcVUoaQRSA=
X-Gm-Gg: ASbGncsJZuDU8iCcidTgbYm9rrto5Oh4KPTivLZU5jDgsHapxteZMdeaxjjLeS/+Tgx
	9Ci7vI5mbtm7DtP6ox1K8dofqDh2afW55nNRVkQF+zD1Qf9TZmy78ITL7kQQr0lZPu/OHNSR43f
	hfA/JNv4wTEO7r0B22CMGMvxkxL8g0xN6rNhrc0F3mBAzlq2U0OtLtTVnWs8vNNHOeAEf9zhCVv
	6ePDCspWbp1dNKS6g4hN5xmJNC/NTJm8oopueE0t5idmBGeJqo4rUsPnh0FvwNfvERZeqsQQGEO
	G/GkASeDOr+2dQOLH2/KDjvsrUk/SkzGX47OVqcBIHXU+zPfNcL1l3GGQlyjHcTv3+k=
X-Google-Smtp-Source: AGHT+IHo3dXHz3hfp/oSpJOLVWdZC25HXQQCxbtTzIPWB8b8q5Ww8A/XoI2b0SmZY5SwEK+xrXw+fA==
X-Received: by 2002:a05:6000:2dc5:b0:3a4:d9d3:b7cc with SMTP id ffacd0b85a97d-3a56a31ca98mr20121f8f.28.1749762544081;
        Thu, 12 Jun 2025 14:09:04 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e25e89fsm30934285e9.33.2025.06.12.14.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 14:09:03 -0700 (PDT)
Date: Fri, 13 Jun 2025 00:09:00 +0300
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	ecree.xilinx@gmail.com, saeedm@nvidia.com, tariqt@nvidia.com,
	leon@kernel.org, linux-rdma@vger.kernel.org,
	linux-net-drivers@amd.com
Subject: Re: [PATCH net-next 3/9] net: ethtool: require drivers to opt into
 the per-RSS ctx RXFH
Message-ID: <aEtB7G5HVX2-jB9H@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, ecree.xilinx@gmail.com,
	saeedm@nvidia.com, tariqt@nvidia.com, leon@kernel.org,
	linux-rdma@vger.kernel.org, linux-net-drivers@amd.com
References: <20250611145949.2674086-1-kuba@kernel.org>
 <20250611145949.2674086-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611145949.2674086-4-kuba@kernel.org>

On Wed, Jun 11, 2025 at 07:59:43AM -0700, Jakub Kicinski wrote:
> RX Flow Hashing supports using different configuration for different
> RSS contexts. Only two drivers seem to support it. Make sure we
> uniformly error out for drivers which don't.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: saeedm@nvidia.com
> CC: tariqt@nvidia.com
> CC: leon@kernel.org
> CC: ecree.xilinx@gmail.com
> CC: linux-rdma@vger.kernel.org
> CC: linux-net-drivers@amd.com
> ---
>  include/linux/ethtool.h                              | 3 +++
>  drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 1 +
>  drivers/net/ethernet/sfc/ethtool.c                   | 1 +
>  net/ethtool/ioctl.c                                  | 8 ++++++++
>  4 files changed, 13 insertions(+)

Reviewed-by: Joe Damato <joe@dama.to>

