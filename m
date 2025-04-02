Return-Path: <linux-rdma+bounces-9124-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73511A793DF
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Apr 2025 19:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39057170B47
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Apr 2025 17:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EE31A23A6;
	Wed,  2 Apr 2025 17:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzY+zyLP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78251373;
	Wed,  2 Apr 2025 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743615374; cv=none; b=Dx2dfL2Or9OkbQl9n16D279sVy1z1q0OzTlpe75M/Fn68I57m8VTSJvED3FFoXdWV5ihKtA+kf3oe5BSX2s3TCXXqwjv9CWxCH27aoyr4cVSZtf9eiC2EagCUVvwDfb6wqkOahv6Krzke23oSq9CTmDpeGfizQ15bq6v2JxIbIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743615374; c=relaxed/simple;
	bh=XYepnn+4Z6u72L9tQoVt8YSYl3/VkaS1Sw16suZ3Lnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BIySjB335t3/KbQhMWSoYzaY2vWxgHllAVVXkvYET7I6jkZWt9vQrn0/7wTSETMZfBD1ILlpsnRHRpnASPhraNYVRAba43MHgeNP7xu/wYCL/Zd0BZqESmid9uNiqGOP7zmZ9JNfjYuDZHqevbv7S5Jom+/i6xYIP3Lf3H3+iwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzY+zyLP; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39129fc51f8so72821f8f.0;
        Wed, 02 Apr 2025 10:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743615370; x=1744220170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xJF/yDLwsfW5UrwVXzqdx75NmNQKrLzOg1Gm4WonWkE=;
        b=EzY+zyLPCzD7dvy0BGiC5yBBXyAtKkCJxK8C6VUn52k0ZcXxUSG06cdePOOSdZjaqz
         KeLQgL49kd698JsOuMZw6wutysYHg4jZ5kEFfEI648cTss4tL6ss9yZNi27TbgPntWU3
         2mM3Rqec88xK/BeOQOg323gARIxGGouNnNZwM5MRCBKVLWn88bQeyK+z10l32b4DqhgT
         WpVYq7R4A1krdsiU0A53vHtJh+uYB0W1Ki+elgM/zS1egLw+l4NQSE5NzQLy4ISXSo0h
         z4xUnrIPjF2qSA4yTzj8BRV+utgAGlDS0jilwB1qf+SV8drvMEzdswiZbPB8bSvKohVq
         6rtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743615370; x=1744220170;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xJF/yDLwsfW5UrwVXzqdx75NmNQKrLzOg1Gm4WonWkE=;
        b=eSNba3HDmVMXitTVmHToUNc2W2i1b0suEsrW85/p9N9IwjoksdD0aWOAVXfA3MwfIU
         qSKGK0hyX7Ow7lD4+OPBPPKhMA0uRbRdej95zz2LlF6WrapIrRdqB/A/6j3bPwXlcT/v
         4aMirCYwemzsrJpNagTO7dtbDgAezjGzPPqqmkD5Bt7KJjs3SJVo7jYxyis7nV48tVE/
         bJtrIP3d/PrSCztzhXghetHuMuNcDqHOtjHh2DEfEpDIJrDD9E4qGXJbb5dXaW1KsssY
         Ih+XaaNo1Su+6ey4Q29qUk7GwK7dhmNqgcSc23j7qEfwMEV5rbr/eKpzBpvuosVh4xlS
         Alww==
X-Forwarded-Encrypted: i=1; AJvYcCU+z86DYvLaABM0P3cWUWSI7nfzVf4eUS5Sx8BTVLwSDwySj/AkgWWh9HPw3cAQg9IgDA/z2BJKxvRdVQ==@vger.kernel.org, AJvYcCUs0JR28gWP+IOrQiQ657C7FLry3lswFrMbT6KJRY0J66EBC25Z8jyGrveV9o7OaLfKwlqVf40LaChJ+0M=@vger.kernel.org, AJvYcCVtDhc1xMzfSG7oQsnvjLxD/ym1pbqWmsF3X5ov9vYGWfM5pHhIE+1EFzzRfOkYgYQ0vw+i61cy@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1gStJKRMvKr87U++DHmkLquRxDMmdGh9WJD5VRM+5QwUArK6j
	0c5cLJjYGIcpAN+NKBTxsxXHBgnQIit9TczwzZH42Mz89iF3niRyPMCiMA==
X-Gm-Gg: ASbGncvuNqByKnwFB6xbOAp3Evi7NT9YNho08lLLPsySJN20fODG3gEHZDctT4366EI
	+SiQEwTocxBzWke22sT1gSItOh6FVLMIVoDoLmVZmjKU7Xsi1OVcLGbmSEyChNJbwEipHegvImQ
	vxDOl0f30JWkgPfMCUJ2B41imlYzXlaINhAU9EoKhIEJvF8nocxKQoOeg3BGJ9P35Eob9HeBQ5U
	LaEYCrP+C28puMmVVdouyAWD+1AE4yDLGYLx9a9LWXnWi2xxhv4Sih7XBW5ZU/I75HRj/6Clkj0
	qkDVYBUr+me6q4Z30zqz4yzY4ElA9xDaTLxw7wf486RdeDJUabps5jBbN9UpjlrVdw==
X-Google-Smtp-Source: AGHT+IEKaq5swH+Ld/WaSM+FM2PRUctpPNIAzaLPfh6179lOd77dDsKSDCZuW45hwzdmjqiQ95AdYg==
X-Received: by 2002:a05:6000:4014:b0:391:3f4f:a17f with SMTP id ffacd0b85a97d-39c12114f62mr13489731f8f.42.1743615369806;
        Wed, 02 Apr 2025 10:36:09 -0700 (PDT)
Received: from [172.27.62.155] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b6656afsm17369462f8f.40.2025.04.02.10.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 10:36:09 -0700 (PDT)
Message-ID: <afae7a4b-e39a-4775-89e4-bd967d1fdf4e@gmail.com>
Date: Wed, 2 Apr 2025 20:36:05 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx4_en: Remove the redundant NULL check for the
 'my_ets' object
To: =?UTF-8?B?0JLQsNGC0L7RgNC+0L/QuNC9INCQ0L3QtNGA0LXQuQ==?=
 <a.vatoropin@crpt.ru>, Tariq Toukan <tariqt@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
References: <20250401061439.9978-1-a.vatoropin@crpt.ru>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250401061439.9978-1-a.vatoropin@crpt.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 01/04/2025 9:15, Ваторопин Андрей wrote:
> From: Andrey Vatoropin <a.vatoropin@crpt.ru>
> 
> Static analysis shows that pointer "my_ets" cannot be NULL because it
> points to the object "struct ieee_ets".
> 
> Remove the extra NULL check. It is meaningless and harms the readability
> of the code.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Andrey Vatoropin <a.vatoropin@crpt.ru>
> ---
>   drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c b/drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c
> index 752a72499b4f..be80da03a594 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c
> @@ -290,9 +290,6 @@ static int mlx4_en_dcbnl_ieee_getets(struct net_device *dev,
>   	struct mlx4_en_priv *priv = netdev_priv(dev);
>   	struct ieee_ets *my_ets = &priv->ets;
>   
> -	if (!my_ets)
> -		return -EINVAL;
> -
>   	ets->ets_cap = IEEE_8021QAZ_MAX_TCS;
>   	ets->cbs = my_ets->cbs;
>   	memcpy(ets->tc_tx_bw, my_ets->tc_tx_bw, sizeof(ets->tc_tx_bw));

Thanks for your patch.
You can add my tag when you resend, once the submission window opens.

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

