Return-Path: <linux-rdma+bounces-2485-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8788C5B82
	for <lists+linux-rdma@lfdr.de>; Tue, 14 May 2024 21:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78A6B1C22164
	for <lists+linux-rdma@lfdr.de>; Tue, 14 May 2024 19:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AF718131C;
	Tue, 14 May 2024 19:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGQ3Ifh/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B5A180A88;
	Tue, 14 May 2024 19:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715713701; cv=none; b=VV3ERmmjqUYl/2Y7t2yFhtAIUMPYxfqGka/AenNU2YhTqboSGprlNRH6f82yjbeSWJNhHQwVOGQjfXcM8kfgjmHRy0rLzizlULw5z2PsdBZ73404GGG8FFxZWz76rvsoq3zIGoht9deaMouJZjkKRZk3jT0/GVgBNuWyNmdZhzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715713701; c=relaxed/simple;
	bh=IpGPND/tsqpjm2a8m8Te8+p7Nlut/1u//Hu1RhsO6XY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M5Ap8T6dtilVAlFA1enkef6igTlzXda0CuXZgqKpCyFeKGasdOIYW0B1saaQrz0Y6kvk7RrxN9gNGBqxoW5Zsvv8LDLheTOS8fP1JcWRkgTclDvZ/9mB709sadjQ4s6O+quR03+ZpRsIFMGrAnO3OC2R8tiKk/7KEmoqVHrBk6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGQ3Ifh/; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e3e18c24c1so64125611fa.1;
        Tue, 14 May 2024 12:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715713698; x=1716318498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QWyQ8SrXymIEYoVoLdfE4J6PDjSgrbL7WVMMamjZDdw=;
        b=OGQ3Ifh/5RFKxgNprAG680SWYWc5PwRyIqkdYvIUXAqloNH/k9NCT1/gWCOM7EVacP
         SgNWDEdI4R6K8z09BuZ2o9fT8vU9ndcXQC6p43G7sHdfObkp+Azir6y4LMRMBhpd5l0/
         oRs1m/x1smZkDoJK04rng655fXZEze2R1NBuqVrtj4QlR7aMolijwSNxsjTnIwC/N3Bv
         o6MQja9rf5dDI+qs64OD7Zl81is+eppbx4ns+QZlqUou5IqCB+PczD4a0h+k24D6ZBy3
         P8sc04mlL4ZG7zrXEkYCBfSDR01+MmUqKMf0wjFvcDqMCBNJkEVg2vvRG7Wt1GvnWsYU
         rGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715713698; x=1716318498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QWyQ8SrXymIEYoVoLdfE4J6PDjSgrbL7WVMMamjZDdw=;
        b=ORWQpFipVoS0wdPBK9GpDP2tzsC1k3EorNuCkMbPxk5kr2riG2bbfudmH17sUbEbAD
         jPGrMZbu4w1dRwKt4/CAUcGoY0amNh6qOBl0eyqJFk5XIjKx2NtSJa8VVK+s1GbH2KW0
         BTIk8audaZRGGspQxhH2yRLGKgFFGVjnC8g6ZoocJjY0Mg6Nk81eQVztdMu+Nrql9LYb
         ShyZsf0+hzkp3GnV19tqv2bAlohit9DSPqW8S/qnG43sUNVe8jnn/pIic1Vk2jvBAt9x
         1132FWRw204HCr6xn4Qn0nmCns++RTL4jjr/YrFxjoavwCFoUZevgNCA0Sk1qmcmovLp
         o+tw==
X-Forwarded-Encrypted: i=1; AJvYcCW/nAbHFp8d5BO3TGWFnh2F6ymB4SThlBbBc0KEC7c0RIOzIikFI85asrZb9+3hPVtrAjpw0YIXRvpeEwt+HunxV2c5EZsEzFQk7yfmdBS0EUI3RUoTY+Y0FAl3Eks8/mEyYFDQGZrz3a48TSjGrQ/PJoDmhTbhLjK3AgM30aeyhQ==
X-Gm-Message-State: AOJu0YzbLltTQrCPXOr3q+m0B+6g7dlxd7mv2JeIFkb3LcK3LSRe/o3/
	M8PJ4quzA8Dg8PBEnVGxI4mKFwctxnG6epJZGCACWhsfb5Cttp3wm9DLZg==
X-Google-Smtp-Source: AGHT+IERoXF5/EznzlInP8tMJxYg7eNXAeefxuD+1UW2gx7hk+iAGF0KbuluqTjCKxlFRIxh+Hgd7g==
X-Received: by 2002:a2e:8896:0:b0:2e5:15d0:511c with SMTP id 38308e7fff4ca-2e52028da88mr91508751fa.40.1715713698045;
        Tue, 14 May 2024 12:08:18 -0700 (PDT)
Received: from [172.27.21.185] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4201916e7c6sm66162655e9.12.2024.05.14.12.08.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 12:08:17 -0700 (PDT)
Message-ID: <e9af11f9-1ff0-44ba-a43d-0c345d1b8831@gmail.com>
Date: Tue, 14 May 2024 22:08:14 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/3] net/mlx4: Track RX allocation failures in
 a stat
To: Joe Damato <jdamato@fastly.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca, nalramli@fastly.com,
 Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "open list:MELLANOX MLX4 core VPI driver" <linux-rdma@vger.kernel.org>
References: <20240513172909.473066-1-jdamato@fastly.com>
 <20240513172909.473066-2-jdamato@fastly.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20240513172909.473066-2-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/05/2024 20:29, Joe Damato wrote:
> mlx4_en_alloc_frags currently returns -ENOMEM when mlx4_alloc_page
> fails but does not increment a stat field when this occurs.
> 
> A new field called alloc_fail has been added to struct mlx4_en_rx_ring
> which is now incremented in mlx4_en_rx_ring when -ENOMEM occurs.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> ---
>   drivers/net/ethernet/mellanox/mlx4/en_netdev.c | 1 +
>   drivers/net/ethernet/mellanox/mlx4/en_rx.c     | 4 +++-
>   drivers/net/ethernet/mellanox/mlx4/mlx4_en.h   | 1 +
>   3 files changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

