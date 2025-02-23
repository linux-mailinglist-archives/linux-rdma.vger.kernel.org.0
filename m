Return-Path: <linux-rdma+bounces-8019-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AE6A40E19
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Feb 2025 11:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19466179164
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Feb 2025 10:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB332046A4;
	Sun, 23 Feb 2025 10:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gObmbY6y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B4517BEB6;
	Sun, 23 Feb 2025 10:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740306912; cv=none; b=YjRv6FGjsdK4hKyFlXn1fjIHMVqviI/zfGPyCvUUDfz5Kv9uoMZMF+uWNwWa3FaJxdQWmBRTHhy5ytaAKKhnDZZv5/pQi6fT2HRHztNOBZeWmFHS+3gIfP0H09nVUCgdnkLcw9vHYNKKZBVv87zGFuiULwA3NKxVkHjMZLSxtIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740306912; c=relaxed/simple;
	bh=IJm6rHOJi8FrGZmeJVr9UoACe4px4E8zhgBAJfIRwkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QSONxXpqIj4ZKlPWAyJvHaz4xLkE6zdMKDYXx9qd7Iv1UeIngXBP+KQW8SdKqgmAzn69FT3EA2xMyt3yUoCIkZd+rkqibc2OuGj1dqSUGbn58XtGmFEAnho/SGKLwNmp3178rdqVcX4wcoPlUa4b4tl46cX2kfVaa2Ac13ZrC6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gObmbY6y; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-439ac3216dcso18039455e9.1;
        Sun, 23 Feb 2025 02:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740306909; x=1740911709; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p74GTJrQJLe0H7g9VKvdKMnLIGPstXj8P9z1VuXPAak=;
        b=gObmbY6yW08FQvhc6N+E34mLUtQLfcDV2KcOBzoUEvT1UYpBwunB3RxzmT679sq/Lj
         4NsZbAsbQl2rC4vHwg0tjsxPhfqsH0lwiUjhjjdVzsFEAiLODAR6ZEdwulepqjRcGaRg
         osD7ADGDW9Xl/xgTqF3JNIRsHcHUlzJxjHNmx2ip0yamp6v4p7P2wGkZLP7jn0YyPTuN
         BpupXsD3hjdhkrGRKtru9kGR2ZEa23GOESjnlz7+Yes+kfsRoTcYKEmr50zum6NH14cn
         4WQgrvjnunYRtgWaWStYw5Ek9kSFfX4oMujiG4ynNz1R1SVqvJs76fB+4opHsur8l7/f
         /Fjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740306909; x=1740911709;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p74GTJrQJLe0H7g9VKvdKMnLIGPstXj8P9z1VuXPAak=;
        b=tSXr10cGBkRo8QN3HPzhKkZ2QbR7QU4r3a/rXxT0/XQ4YAQhJg7wg+tMocScZVsry3
         9sR1NgbHbv2CSQZYe/fyBPucqnspWNaF1PNCnd0MCbi6dO717CUqYMIgezB0hQfvYCGD
         ChyhdoHWzK9yfW3T+QRnMbDw6oCHTyWm6pPqPkHkAHJeJdIS+GcOwl6ZkIRalHO8RcpP
         idtRkjtGemo2T1FYf9CvTj8dfBK1++xwHE7Wq67kZsoPOw+LKu94xQDSlgLWS4CPw+2U
         RKntSLTaKZgRZpMggiVOX81mLH9B0LFHt/nRvUtFZ3sNsX8G0q/xCWtFxIA2j0wno39g
         F6fg==
X-Forwarded-Encrypted: i=1; AJvYcCUcr5OyUNzT/ZBRrQpNN8skULsBQz5Im9ZgMLrEEQqEnytdZflcNpHu8vI3r5e0xNIEPgLxVSnb@vger.kernel.org, AJvYcCVPV/e9B22g15+lFh2A1pwjHCQ6FqisXKFSegucF6E576EXCTk+gCNPJaZl7CZ4czZrpxbVdwo8lkelwg0=@vger.kernel.org, AJvYcCXU8JDrBc46yLy9Rkzv82dlf9Q1akw4rw4yKmHjtPvK/JwhwmQLr/IZkUvRA2yy8RxzPlsfg5IkaZP+yA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwaWyougewB/osd3yOjTkw62MTZJhZtCyTX5bsydvz0IZEi5Oo
	UCViNMgVWCLTSA0ICQCqXFzI3lcpSj1EmqGvlrJEj9GOPAM/gUjz
X-Gm-Gg: ASbGncvgLmETIgW9ZPXMGK915988iscbHzV8HDqnEF1c6UebVSAELZcQN4kV4Lmih7i
	F5Dm0wDZiKteBHCd4yaUfjj1drAjJucP/0imWy1YSJ47hP9oQ/qVuUVRpPNn7VqyoQtBBYeTBwi
	dqzCDt5C1z6Zbt6HyLoZvJN6980tRgg9hV6DOeCufpVZdWQSXuslNkuLiSXSPCsy4W9FBklfhGH
	41Dips4Ems6aiYEKRxHic/BINnj6++zO2sEr16peRHalIRTIjQUyrGGrGv0FHVORjv0wHFpp+gJ
	rZArOwLMirZRUm0sys4GkI9RTsXIZ7x8BdYNI2SkmIsI4jA=
X-Google-Smtp-Source: AGHT+IE4CGLSGVjXiBxTteudghviaP0EFvuF/JTxIwneasR2BdEtf+xCW8FsL3fnKJ/w9EOTwaQY9A==
X-Received: by 2002:a5d:6d08:0:b0:38f:4531:3989 with SMTP id ffacd0b85a97d-38f7085e028mr8009512f8f.51.1740306908847;
        Sun, 23 Feb 2025 02:35:08 -0800 (PST)
Received: from [172.27.49.198] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5923sm28836719f8f.74.2025.02.23.02.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Feb 2025 02:35:08 -0800 (PST)
Message-ID: <9ec62114-f92a-4db4-a929-9d3d53e144e4@gmail.com>
Date: Sun, 23 Feb 2025 12:35:04 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH net-next] net/mlx5: Use secs_to_jiffies() instead
 of msecs_to_jiffies()
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Yevgeny Kliteynik <kliteyn@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Itamar Gozlan <igozlan@nvidia.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, Saeed Mahameed
 <saeed@kernel.org>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250221085350.198024-3-thorsten.blum@linux.dev>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250221085350.198024-3-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/02/2025 10:53, Thorsten Blum wrote:
> Use secs_to_jiffies() and simplify the code.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Saeed Mahameed <saeed@kernel.org>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Resend with "net-next" in the title as suggested by Jacob and Saeed.
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
> index 3dbd4efa21a2..19dce1ba512d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
> @@ -220,7 +220,7 @@ static int hws_bwc_queue_poll(struct mlx5hws_context *ctx,
>   			      bool drain)
>   {
>   	unsigned long timeout = jiffies +
> -				msecs_to_jiffies(MLX5HWS_BWC_POLLING_TIMEOUT * MSEC_PER_SEC);
> +				secs_to_jiffies(MLX5HWS_BWC_POLLING_TIMEOUT);

secs_to_jiffies() is expanded to a significantly simpler code than 
msecs_to_jiffies().

LGTM.

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>


>   	struct mlx5hws_flow_op_result comp[MLX5HWS_BWC_MATCHER_REHASH_BURST_TH];
>   	u16 burst_th = hws_bwc_get_burst_th(ctx, queue_id);
>   	bool got_comp = *pending_rules >= burst_th;


