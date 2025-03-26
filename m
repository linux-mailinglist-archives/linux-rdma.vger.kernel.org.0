Return-Path: <linux-rdma+bounces-8959-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87070A71071
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Mar 2025 07:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8290B3B4B67
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Mar 2025 06:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04D4188A0E;
	Wed, 26 Mar 2025 06:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8lt7XRO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0141F5383;
	Wed, 26 Mar 2025 06:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742969586; cv=none; b=fra7zlxkkHa3L8jhzfDQzQVAayAns3QrrdR+XT980e7Gz0XqneIVFjvrAutbBP4hUMZ4zj4aVf/yLS0ne77bKh+lavlg7FMxdTiqkbgu7hEBCfyZqUMWVJewwB8d9blXMgCaOCjSiHYfG81uQIxgrSgTfaAibzZaW/R7A1tu/Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742969586; c=relaxed/simple;
	bh=txTzL2mhqhikibCqrU7LgF55lTKwKgl5EG6fOmSyzzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M/YmFb8PF0uSbsIus24snmosKxjtV2T/O5j5OpsuqMg8mvIjxXM1q4lOIXOpp5LIrEei2FGGsJyC+GlwCPM7SB4CxSsMA/ErRKMsC8uEBlN6D/ierHYAPOasdDoKRB7na0jD7/Y9Qb79hqQ31ofmGPA5ArikDLXpngZDy2Q7wl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8lt7XRO; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39133f709f5so3394306f8f.0;
        Tue, 25 Mar 2025 23:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742969583; x=1743574383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qh5szxCrEAebk5GiCm8Dt2jH6xOERyFSJuhaK1L/FGQ=;
        b=j8lt7XROtANGNcqA5zW/rOJ2l7e3uQofcx0Kz4ZMStV0dFKSpI33wWLTF0J1bWaIdo
         iG+O3HvFpegCF8NNVlO6VBycX7GNFeIdVE2VQJYktYrwQr1WAMwiCTRmHouSTWsJTL8S
         QbtOSPrF82aw/rpprhXzXYYvUIqK324akbsj6eU5a10IzI9pGaDWlq0lJsBSc22u2T7+
         e9tC6jEtBnNIySdreQ2UwWmAVvHAVdAi+VswXIVUnA995JhmnWr7O2I++f8liXDXcBTt
         lY5tmRcCxBLomh2Oif2e1Nm5LsqpEhukIgs/olhA5SpqRkGEBmpbyrDLjwDacI6jeGA2
         aC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742969583; x=1743574383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qh5szxCrEAebk5GiCm8Dt2jH6xOERyFSJuhaK1L/FGQ=;
        b=Mpyvjf/W/bAUgE2pXxIwmauhPxBIWC8xj7Xz5KZMwcVCUu0NUpGnhMgpbxiRj6U8Mj
         6sYPiWNI5w+/bN4viEYeRcHCCdpEy3GD5g+SlvMVhv5anH+UOvoTwCfcP4NQO71L6jv0
         jazeFeYtjh2XmEjbxQ/Sg3qEoIOPTxpzOv5vHis1TOtldzx8OOsb6uy3+H6Xk2hvnkqP
         4L3+0K8dHfJkh3Gk1PIupn8/lV1jKua/p8Tnmqezu45C54MhguMc5x3azYfmX3SaNcH/
         wvn76NaxxBrLk5COgMOBMFQ1pXNi/QkWuUjegEd22xKtww1GC45PzH8IByE9vUADYRwp
         LGkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTTQVOahk++I9Dimy6Ib5mq6bBpOAyrBDgpChecWTVGdUovUl3ue5oKG4VPD8IT9ZSwsAkInYTmtZxaA==@vger.kernel.org, AJvYcCXvakRQHW+qnQ4lk9MuHXOpPa2KWNyP7sSn/jrXwdIcA/K+8FbJK/ywHwaTgSYUHOPyH1DgR04jG4Hx4Qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaWebH2Zs4qNyg51P3Q/HQGdDo07z0TRGqaEj20c0Ie9f4wd9u
	s3dM0yPTYUi2jR0Lqhs1SIpZbLFKGyxI9kFl/l/it+BXJX8zsthi
X-Gm-Gg: ASbGnctGh5OS6Zkp2r+WhBy8K7sdSVYq55lL2ZMEoa71Ha2f1y7qMw1W9ZxNn0KjnFS
	ZFu4jXBD7uaeEL2RXKEZiVCQ6fQ8Oozi/zqKvjp6zXzwF58sZL78oguEdJwc4VHvBv9Etc3HDHr
	teLWBmxxGi01ZBWcfnUZmIzpau4iwP1dIoKMR+PAJyPDsd57IpH6OGtEM4d05DsJpdraGdis34F
	2K99fWFtZL5DuioXpqSUeijjxdgYWV3Hx71wnVnzY61b6EdyKe2yA31NoKNQeKq2Zy2DsfjCjQN
	OmJ8PR9p/hKOiavlN3+QAtAFpUHcxsfEFyLc3B/3vFeFgx7pC0dUhH0LNx4DDA==
X-Google-Smtp-Source: AGHT+IGbpx7mTUHQIYPmGKwz6J0qSyb+Q2qehyaUkSxFmr7Z272S/gKD9iq5r+TYNGyoJa7ZTVs91Q==
X-Received: by 2002:a05:6000:2d84:b0:391:40bd:6222 with SMTP id ffacd0b85a97d-3997f8fd7camr10604910f8f.22.1742969582886;
        Tue, 25 Mar 2025 23:13:02 -0700 (PDT)
Received: from [10.80.1.87] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9b55cdsm15905675f8f.52.2025.03.25.23.13.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 23:13:02 -0700 (PDT)
Message-ID: <91285e69-91d6-4845-8381-46b55cb98d22@gmail.com>
Date: Wed, 26 Mar 2025 08:13:00 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: DR, remove redundant object_range assignment
To: Qasim Ijaz <qasdev00@gmail.com>, saeedm@nvidia.com, leon@kernel.org,
 tariqt@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, kliteyn@nvidia.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250324194159.24282-1-qasdev00@gmail.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250324194159.24282-1-qasdev00@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/03/2025 21:41, Qasim Ijaz wrote:
> The initial assignment of object_range from
> pool->dmn->info.caps.log_header_modify_argument_granularity is
> redundant because it is immediately overwritten by the max_t() call.
> 
> Remove the unnecessary assignment.
> 
> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_arg.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_arg.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_arg.c
> index 01ed6442095d..c2218dc556c7 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_arg.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_arg.c
> @@ -39,9 +39,6 @@ static int dr_arg_pool_alloc_objs(struct dr_arg_pool *pool)
>   
>   	INIT_LIST_HEAD(&cur_list);
>   
> -	object_range =
> -		pool->dmn->info.caps.log_header_modify_argument_granularity;
> -
>   	object_range =
>   		max_t(u32, pool->dmn->info.caps.log_header_modify_argument_granularity,
>   		      DR_ICM_MODIFY_HDR_GRANULARITY_4K);

Acked-by: Tariq Toukan <tariqt@nvidia.com>

Thanks for your patch.
This is net-next material. Please specify target branch in future 
submissions.

Regards,
Tariq

