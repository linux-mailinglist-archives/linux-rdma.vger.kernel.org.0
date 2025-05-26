Return-Path: <linux-rdma+bounces-10711-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E45AC39C8
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 08:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 190137A444A
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 06:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5711D799D;
	Mon, 26 May 2025 06:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2riJsD5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBB9139E;
	Mon, 26 May 2025 06:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748240673; cv=none; b=EOlsXw45u6Zci4Iv7UQvSIUPHsOA9lXfBmIo+AiGf9JROwmz6RBgs0eyqGBqMdJXoSFFWaGET8NOGYGASH2W504FEj2/L61szf7yUAsYThz3ecpKbgebRi4lDafPfj8WCGKXxv4tNxsY9UpX08C0OS4i6XKuNphMwlRJ8FyvAps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748240673; c=relaxed/simple;
	bh=Jmoezrr5h/P7wPGqx0AJl73cVmfIFhZWVmXprIqJtl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qX+N7lvPPaXyyqs4lEqXuLBWLrQ6YsZFeipGxcrhZ/b4U6QHNzCiXH6F4jxfc439ZtGip63t8hNGCw/q2JNUA3cGdyJ4JJmw2lvn9Cu2JHjU3QWnxEolFuFkgr6Z56e1R2byATEQYIdyHmR1Q3HVC4Skn1KeA8XnNEw3M/z4bZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2riJsD5; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a4cad7d6bdso1153135f8f.0;
        Sun, 25 May 2025 23:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748240670; x=1748845470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aSeQTqMyac5qdBtfUXvRWyS7yp4apIVtXkHajbYHhso=;
        b=N2riJsD56hcHJa7b/m1gaRy0Ujnw2eSyET1OZrXXB8+lAMhJoMaN5vREFFSi0JFtVz
         S2c1/zR3R6GubG/CheLBSbKovf8od+0/gp0XVFXvbkn0HmU9U8peOsrTmmRVf9XZrMGx
         wdvDV+HGPfac9d/uL+dk45elbw4nBE+zy7AjEz3Ece/d1+y251ZngyORe+Ckyj7Ip5Dz
         NQRJnTsSCWP9tiljtQUMi0qM/58vwPEJYQ1iRsEmQBoCBAi7JJq/DzKPbLqqmFSR8in/
         Dbeuu1OoqgL8Ytzl0YM4J2ywWzyBjtsigAmBSQDHj2cWhdalcexOigUSR8d1IKcjMGZM
         DFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748240670; x=1748845470;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aSeQTqMyac5qdBtfUXvRWyS7yp4apIVtXkHajbYHhso=;
        b=Dh+UfipZK7E3IGSl/Te5FyREJuevOeCwAYmybplaa8riv0kbj4ZLch+wAHZsO9qo/H
         XlYyvDL/amvUr7DE+E4PqL8AZriAPnHSKrk5CRyc04NQ3aRy5wOplYukjL5PZh05ryQG
         Ijyuy18oXxeaM6HEL8quiPmm2dfHLKISZs17OpkgfC6HgSR6OREjTXog/t4aWvbpjVzn
         6D+P2STZ4nyTz5pnUUV07wbtGhkDqbLEjmJdw4HbSx3cf9JYy2x/skW3GfRacNmjhghc
         CUOLFDmrUNquUdKeMkYywSkr412jFEHA5zYM0Rj1A9rwbWlGCCZbq8Gkv0b/VhQxHqYG
         E2PQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkl5SpKMTJZLsVUgeFjjJczOljOd7BOZ4fpE+RRZGkk+stveesJxfe4lxDXXhS6d29r/p37a3mfJOeiJBu@vger.kernel.org, AJvYcCW39vhysG7EgEX5fMaU7EJHNoA4tJ3ef2Jl8ZDjorQ5scWaELQ3pY+Sf3Uqyg5cCuUGb/eMp5JB@vger.kernel.org, AJvYcCWmw3A95oH75J5dTi2LDpgmXvZyfXO3ln0ru5mt8YFG/5DQurObrGU2dEmOn+kn++xqNWXwgVzx43zOxiShwis=@vger.kernel.org, AJvYcCXvUtv9LWiLuFf4qeHWv2RAvXyXdfcoozrYQKg4F5z6FKStmj6N7pxIs3sQp2Zdtv8YXlXoXTTpJtiQ5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUIkUoI+mWP/IYzw+D/AOSIvyad+cv2ciPsfJHorvnKlQr9DMN
	N9EeYgqEfWg7fus1i/GnTSPdb4e//qMEVU8k7KwH2MspR/F/UHS4dZ2W
X-Gm-Gg: ASbGnctOIIhH5rXTt2aGCtQ6zqVP1ufUAtU9POEyNhsk2wMbYXEW8tf1YHmRU5G22+o
	UkY2UDOqIcwooGK9tXibNyEd1b+drRWWVdoIK2x/qzKgNdCMr0i7IBrfMFFHzFLT6eNB6ohuMFV
	nXjs7hD5ITg4wUuEfxp+T//UH82yV01TDvBpxfI024TbGDkSEtqFr4BWFV/ZD9yJVlH2ksbLUMY
	V/uDUPM3bt9BF8BzUYfvV3NzjyrOWNsJdImgC9Y8J6aExf9f0pMJirl4jmD5fy1s73vmMVMHB43
	o+KJ8QYG7CvQ17CPSDmhEEQsy3rbePqfGl9quo6GVNawCVtFNaApYiOVfosi+Bg2u0WoBUfoEB+
	SN2Y=
X-Google-Smtp-Source: AGHT+IG83ayY7ljjao4k1jwTiu4cQ4ZxKzux3pzwGzFHq9ha2mxPe82gctnuizexlUDn/mwQ8xOrtA==
X-Received: by 2002:a05:6000:2503:b0:3a4:cec5:b59c with SMTP id ffacd0b85a97d-3a4cec5b7f0mr5640039f8f.25.1748240670113;
        Sun, 25 May 2025 23:24:30 -0700 (PDT)
Received: from [10.80.1.87] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6f062c7sm233179025e9.14.2025.05.25.23.24.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 May 2025 23:24:29 -0700 (PDT)
Message-ID: <c452671a-f0b4-4738-a4f9-f73c134fe804@gmail.com>
Date: Mon, 26 May 2025 09:24:27 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5: HWS, Fix an error code in
 mlx5hws_bwc_rule_create_complex()
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Yevgeny Kliteynik <kliteyn@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Vlad Dogaru <vdogaru@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <aDCbjNcquNC68Hyj@stanley.mountain>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <aDCbjNcquNC68Hyj@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23/05/2025 19:00, Dan Carpenter wrote:
> This was intended to be negative -ENOMEM but the '-' character was left
> off accidentally.  This typo doesn't affect runtime because the caller
> treats all non-zero returns the same.
> 
> Fixes: 17e0accac577 ("net/mlx5: HWS, support complex matchers")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   .../net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c  | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c
> index 5d30c5b094fc..70768953a4f6 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c
> @@ -1188,7 +1188,7 @@ int mlx5hws_bwc_rule_create_complex(struct mlx5hws_bwc_rule *bwc_rule,
>   			      GFP_KERNEL);
>   	if (unlikely(!match_buf_2)) {
>   		mlx5hws_err(ctx, "Complex rule: failed allocating match_buf\n");
> -		ret = ENOMEM;
> +		ret = -ENOMEM;
>   		goto hash_node_put;
>   	}
>   

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>


