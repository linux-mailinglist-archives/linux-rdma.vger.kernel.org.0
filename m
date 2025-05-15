Return-Path: <linux-rdma+bounces-10358-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1F0AB7DED
	for <lists+linux-rdma@lfdr.de>; Thu, 15 May 2025 08:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 042AD161CBA
	for <lists+linux-rdma@lfdr.de>; Thu, 15 May 2025 06:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE58F296FCF;
	Thu, 15 May 2025 06:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9oPXJU6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F2622D4C6;
	Thu, 15 May 2025 06:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747290191; cv=none; b=EwNHEje7RP1+nyydDp2nRML0LnMHn+B/5t8cAOpP0YCAHxCN7Aa+nJqbZoMBCPi+1rgXU7xv8CwR9XkUKei4/+tMrYS+8BW6uIkMwpfkzh+Xkw00J9av5StxdyiB/2lTUWrk5GunWl2bWt8pfxxDP2hReOvC5s7pTXP2N9YjiCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747290191; c=relaxed/simple;
	bh=FR5qoOS0+vrvZ0hhVirpXp51hgUYilUFfQ3ti+H8NzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZEesJ0nub2xMLOFFjxyX0gBjlfKZnUnY7m5NKJ/I1V5aFoL11uFyNS+iputEFL4Xnf7nEet7hlkOYSGoMq91JkK9IeDg216fMloYSwxg6nczYQo+C+OgihXux/uBVQwvQpoWqlGQV+21hXaCufW2kuzboZoLD5R4t5p1tv9nYIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9oPXJU6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-442ea95f738so3727615e9.3;
        Wed, 14 May 2025 23:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747290188; x=1747894988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mnSk+kKvzNQ3bwp6mK1AlyLoOulm4ArWZ8jPfknR5eY=;
        b=P9oPXJU6YIXZUmuUNgYNAdRFMyZKzm+Dc/JaBXrRHOsgraIyqxqoPM0u4Vt3Xbt6cJ
         SjTxgP3LR0lM13JgibgncwBRWhHRCa66t7AcNACFe6TUqY2uIaASMa1RPOeC5J1rUYPA
         9WRuQG4b0b9/WJ6GhrLYa4Kma5edUPsvK5lgXErHbvKnGeGO5Q6dmd2VL4kvqqzhXKFw
         0jLePAdiTc40dxyX0UTnqWxWmFGcoPRAUV4MhrlBKd8vl+WJsUqQsDoFdOVvLn0cjuHG
         qUW9FR59OGlJie2CExaHDjk5/WAiqit4tFtKpJU+f1P/GjXxV7dEZpeqNE814R97mFsR
         MNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747290188; x=1747894988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mnSk+kKvzNQ3bwp6mK1AlyLoOulm4ArWZ8jPfknR5eY=;
        b=vdY60D7x0+OUP1G0AMkMKR+W4p+S/fir9TIJ2CK9YqHugdptqE0QtB8HQxN1BryV8E
         kPyqsM6zSd4/4p35Uacdr7aAInThT3dXqSrxzHvMZ5LXVivuD1guteXKTtVLu9KAalY1
         5RRFlVUwiFmy7V0GDbUS5DZFrPnqSJ1sffu5WQGxDGnq7KHXHZ+KTxdKqC/MTD/ebFpl
         fAmfj541JJyDM1KotJ8vqtLnhZU+UeoUPNGnsEs6POlgPh+XvZRI5qFihNfGvj0mXpO7
         BweJoyaRVfMk3t/2sCoDLuijd4TRpSnE4CdLkrS3QYCBElUIWZbYuxOJ1p6j2BSNcX2M
         W5Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUV9tm60NAWisqTnT+6vh63n3PoW7gqhF+gxc24pYEj/zwmSWyiyx8Eg3fnq/rQSCgaM+PHj894Q1JXk/s=@vger.kernel.org, AJvYcCX0ixE8d9JUkTrVEo3dFj8cVHiYMpWiy15AlSRTFQHm+DBpd9biYff5g7J88hEr9lz/Nz6id6XKVlBvUA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdPZ6gHPrW+gUFOgcU67VW0O9sY+wJyBGUQ87APpJK4bk3n2SN
	KQGld9vQFAAlf017I36eVeYo/gT9+o3e6qlfzxrYFQp/1DnWfjUw
X-Gm-Gg: ASbGnctlQW/PuGfI+9LT+5KfPeGBg22yruJ9PD6KTChZmjxx5gf1H2H1D7sPZxwhWNY
	dpstkIIcqpMxjazcIrFsPKjRAu2Irt3TmMsC5sp/XmUaUrvA+glI3nd5vw4oW0I0ZRO2/+pL61Z
	FJiLaPgba/mnQJsLU6sIzuYocer03jOA8U71wB8VuqnNx/0wEqB1wuEedLF+jxIe0jWaqhFbG15
	vEiLg9Y5KSElY/1EHh45ER3Atvn1L19ZlerbB+H1TISUuTkct+a6cTzG8ytV2Ygi9sYt0Dk+7eM
	cgWtF6bGhEdC1rEiq3Zfj/U/Wxf0yufUvS1peXNa0ErnhSIq6nxa2zpggZLFeHsa2HMneHxBKwp
	ARs8fH+4=
X-Google-Smtp-Source: AGHT+IGj4TS7tJITPcLt1pcDhqz1LJ4GCh1s9sL3GjU2OZQ0ubdPWiDTqfG1FVleV47vDUcJ8HWQYQ==
X-Received: by 2002:a05:600c:1d95:b0:43d:160:cd97 with SMTP id 5b1f17b1804b1-442f2161391mr49047365e9.25.1747290187401;
        Wed, 14 May 2025 23:23:07 -0700 (PDT)
Received: from [172.27.33.110] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f39e84acsm57588055e9.25.2025.05.14.23.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 23:23:06 -0700 (PDT)
Message-ID: <e2c6c100-c1bb-45f1-a171-2effdd69e409@gmail.com>
Date: Thu, 15 May 2025 09:23:01 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net/mlx5: Use to_delayed_work()
To: Chen Ni <nichen@iscas.ac.cn>, saeedm@nvidia.com, leon@kernel.org,
 tariqt@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250514072419.2707578-1-nichen@iscas.ac.cn>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250514072419.2707578-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/05/2025 10:24, Chen Ni wrote:
> Use to_delayed_work() instead of open-coding it.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
> Changelog:
> 
> v1 -> v2:
> 
> 1. Specify the target tree.
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
> index e53dbdc0a7a1..b1aeea7c4a91 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
> @@ -927,8 +927,7 @@ static void mlx5_cmd_comp_handler(struct mlx5_core_dev *dev, u64 vec, bool force
>   
>   static void cb_timeout_handler(struct work_struct *work)
>   {
> -	struct delayed_work *dwork = container_of(work, struct delayed_work,
> -						  work);
> +	struct delayed_work *dwork = to_delayed_work(work);
>   	struct mlx5_cmd_work_ent *ent = container_of(dwork,
>   						     struct mlx5_cmd_work_ent,
>   						     cb_timeout_work);

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Thanks for your patch.

