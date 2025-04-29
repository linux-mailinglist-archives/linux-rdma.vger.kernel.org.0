Return-Path: <linux-rdma+bounces-9924-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E11AA096E
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Apr 2025 13:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787AF16B7C8
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Apr 2025 11:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579F22C10AC;
	Tue, 29 Apr 2025 11:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qb5AL2d/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ED21FFC4F;
	Tue, 29 Apr 2025 11:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745925817; cv=none; b=IBFU+YwdGTAzrbfJKfgY6K4gL5oZkEgDJcBw8PJg6M4H+k3r8/x372HM5tZD2HKhE60RFdCVC4FIUcXFHo+T/pUtMnP8Bksqyl0gZTqeO/UEuc1l9JAnkC3WM/JH7qR/c+vBGdfjZVdIvMmQnx9F+OAa+kWn/mh905EISECEfz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745925817; c=relaxed/simple;
	bh=ZaACI4uc7FoYi8HueqmWpcR7iEQtfmo0xIZ9yivuGDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OnySs17l2XFPXHctfn48Ac2ZqxSD6E9JzZxgYfZ/Ofk+ng9rgwQqdEfqkT4D86CDQywpA68cictynyiWxH6zY90sHfKDVm8UBijfAXg30pxmwgXjn03YrMkueJVmWJ/Udm1hI/1uECE2msAf0Ovey3QwJ+8xtjyPtMVCUduB8Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qb5AL2d/; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso39439215e9.2;
        Tue, 29 Apr 2025 04:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745925814; x=1746530614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=enRMFP1jlisurkqMhlaiJRbAzlhVsmC7ZkoRkqihn6k=;
        b=Qb5AL2d/LgydMr4yVaw9gss8y0gnvFZ0qTNrVA+Fyks3/9qKPo2+hot6tYD5iwbjYJ
         2SIOoGUDeK11JqUpB+lQcyZ1WtUPe9hjKy39oH8VHHJ84ioX4yhA78Cw1ZU45nUuSCM2
         ccVwk+WF0ddFcdV60w2ykPA+oEMP8fKq4EdyYjbywO2pw+kom0rKz2uTNLvV3pKQ57II
         NE1U335yW2oLM3DCbP61DDBM5aOwc3Ujh/UXKBEYBJ7gkcUMT4I/A8Y80Qy4jfylQuTb
         rfYWODsRn0xg6JGwbZDw+LXnGhVO6qDZ9HgWTlIY55RJ2GQmN9eqBnVVevP/qQFoTLmN
         v6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745925814; x=1746530614;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=enRMFP1jlisurkqMhlaiJRbAzlhVsmC7ZkoRkqihn6k=;
        b=u3Q71RgwyBOvn2nkjl/6ivw16Yzo0wJT7aKzfeePBHjXUgDog+N/h4aVhLM489rCLL
         3eCKsH6sh8Qz+eIGFi2XYAJkrZ8GMwd2vF46lYfuPoS15pWXiL2vjtBbwS2YT8cfV1SB
         npdeXAB3HDLkj8LQkEvcIxZnymKauIr7/lWsL9dA+S/CzLI0ysFow6pAaVbsAhyEHUY8
         zgJ6JiF8WchI445SNdL5szSWkcl1qURYS4ssaXHTfgTGp/Y0JeHE7EMqWhkNq6GhmiRZ
         mmfPLaJHvaAayh7lKts19JCYREpFm1hxOsf5lZ8tThNAgZOTv4mOqhZZdIOuJ2Txd3Lg
         Xd0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUttdFVsCt8eCp1Mg4bt+6ZLoCoBxBL2izeN3XtrhkSHLvsaAqjqqVVaA29+Sc2/0wsDy3BAM1YcJZdnA==@vger.kernel.org, AJvYcCVDMFyJbfznL9NTCH/RodeMKqjN7/H2lyBDmI3q46lyi15blmfY2UR8IJt0fFduhTeLuJdLNOh7N7nnasrE0Ys=@vger.kernel.org, AJvYcCWr75alvlMA9O7sihDIJW3LN5oj4yJHf7AHbsNinRolRpiDv8S+cGXEgDw0aQUq2iScrMo0cCnC@vger.kernel.org, AJvYcCXQIvGTDAzHwHmfxnWi8Cjdi0uBrRWcjEe9HomlPe10Bt7QSz6MxnOGiRpuzi/VoWzG3ue56XYYGDX00o6/@vger.kernel.org
X-Gm-Message-State: AOJu0YzQwjIjyi6XPI4ej/oDlvQA9mfs1n1usazs7QAbhqUqcgGF3gBe
	b8Vgt8QmVUYDonkMOD6UvovHTOFsd5rUkS3dI8yWKoKgez6at1ts
X-Gm-Gg: ASbGncui01xrc3SCdxFdW2JCvCkYVybogYj7ZsCKYJ6Z0qHHYFcmQjK2AyqGVveKE4b
	Bk7W6FH6VRY68a2oV/UOpUCD0r+wwTw46KYk69zn3HdQDzJ388PpqwVDub6RCV+IDjhBCdjOd5y
	vo6lBV7Xt/ECaKAR8TGXcFdoCIjKrEu6a34j552lH0X9fj6bHvsknvegXZatr7LwzCqsYvouTja
	+WZkE0bM/3LTPL6yYDnmVZJv2GHV5xSKNrzuKqo4Tn+Fge+aJyFVtnaDXGZBgaac5ihExSAlKZf
	mCq5Lk76gF3K3sCmaHTqGvvDR5E9sMOsE84gC7gwojhuoEJ3sOWZA3+ZTB4nLw==
X-Google-Smtp-Source: AGHT+IF3ez3RvSlwwNz2iFhvs7yuu6LPcQghwcJs7BvAS2GzjMT+coF7zcPbbGeD44XcuYjlawqZCg==
X-Received: by 2002:a05:6000:2212:b0:39e:cbe0:4f3c with SMTP id ffacd0b85a97d-3a08a348367mr2147937f8f.8.1745925813206;
        Tue, 29 Apr 2025 04:23:33 -0700 (PDT)
Received: from [172.27.34.251] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a07a7c39a0sm10754303f8f.101.2025.04.29.04.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 04:23:32 -0700 (PDT)
Message-ID: <c805775c-9729-4090-9d09-eec9b14874e6@gmail.com>
Date: Tue, 29 Apr 2025 14:23:30 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx4_core: Adjust allocation type for buddy->bits
To: Kees Cook <kees@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250426060757.work.865-kees@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250426060757.work.865-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/04/2025 9:07, Kees Cook wrote:
> In preparation for making the kmalloc family of allocators type aware,
> we need to make sure that the returned type from the allocation matches
> the type of the variable being assigned. (Before, the allocator would
> always return "void *", which can be implicitly cast to any pointer type.)
> 
> The assigned type is "unsigned long **", but the returned type will be
> "long **". These are the same size allocation (pointer size) but the
> types do not match. Adjust the allocation type to match the assignment.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Tariq Toukan <tariqt@nvidia.com>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: <netdev@vger.kernel.org>
> Cc: <linux-rdma@vger.kernel.org>
> ---
>   drivers/net/ethernet/mellanox/mlx4/mr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/mr.c b/drivers/net/ethernet/mellanox/mlx4/mr.c
> index d7444782bfdd..698a5d1f0d7e 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/mr.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/mr.c
> @@ -106,7 +106,7 @@ static int mlx4_buddy_init(struct mlx4_buddy *buddy, int max_order)
>   	buddy->max_order = max_order;
>   	spin_lock_init(&buddy->lock);
>   
> -	buddy->bits = kcalloc(buddy->max_order + 1, sizeof(long *),
> +	buddy->bits = kcalloc(buddy->max_order + 1, sizeof(*buddy->bits),
>   			      GFP_KERNEL);
>   	buddy->num_free = kcalloc(buddy->max_order + 1, sizeof(*buddy->num_free),
>   				  GFP_KERNEL);

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Thanks.

