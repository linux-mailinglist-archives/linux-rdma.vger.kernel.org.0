Return-Path: <linux-rdma+bounces-6485-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0458F9EFAF4
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 19:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0501888832
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 18:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEE9223316;
	Thu, 12 Dec 2024 18:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmBZBJS1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA5F13D52E;
	Thu, 12 Dec 2024 18:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734028329; cv=none; b=P8aqcpQllClBQnU1NqqVmD2Qvylq08jthK0F4za9NIKkhLUepH1Aa6cv/iWzK45xhvSgHJQykcNweDsnYM73ELAcvbguEg+8ejepdswa+aFQqcwGe+m5N3nOJ3TX5ui4joiCbs6SuV80d81FcWQMyOG9/TqH4uvwPOA5j+SkzHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734028329; c=relaxed/simple;
	bh=v5OFhyt5ZbqfNsLBv6mYpAWj6yYkHzAbdZOgrHO+VTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VyiW7VBrK21hf485uQHVGm6mR/4Z+oc+LLvVcMttmtzP6kR5PyypIleqg2Hs41y58FFtnFIhqKJcwo17qUylS4nA7YyY15WWwRxB0cGgjWxxyVpAzEJg9KhCPXk6E67Gv4Vwf55D2cZFbJIVvEwGyv0sxIfmJghacUudIOsm4rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmBZBJS1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43623f0c574so6879795e9.2;
        Thu, 12 Dec 2024 10:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734028326; x=1734633126; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SLPXRVWKbDazqkS8IFoT/M0UALwj1qpLRM3RyZHx7Bs=;
        b=AmBZBJS1I2Ve9aBYdKC3m9ll7UjTsRKesDsRVFU0oU0Spkcie2bsyaPe0f5mJGOpWh
         mgOUCBkoyqGtpRkmmq+sU39ehOIsDpujBDTER7XpXu8ZbXI2h0sqOeBgt7vAx3UJ1PTW
         QXGdkqVg5voQg9r/u7jHZPJtffETj93xvHHpWZox5W5TbrAro00Rg/v5ZmBGwNCSlm2U
         VkxdeiZbBDoc5PFDOKh3Hd2WEOctM03qoO+1CeGPk+serLo5X6/b2OptVN1RnfETty31
         3OhemWc2NjrgeN+SiuHTLrZcjTcH4GdWFTjeh+XkzERdq9mN28kfDTDkgD3AfWuUFh+l
         zGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734028326; x=1734633126;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SLPXRVWKbDazqkS8IFoT/M0UALwj1qpLRM3RyZHx7Bs=;
        b=d8bFmLwclw+GsTM7vowhh08Wz9O0zgM8HYl+LV+Wse58d5xysSoFniibOMciOXXrFF
         bcw0XjSvMEBIFOYy9aEeZs4UlRA72IKjyEaBH+nI6X8nPI9IIx6Hcs20SVCE43qZJvcb
         if4mKUo7flHzpuAT15qQhknzUHOOn03DEn5UijnHHSm+qWTDustxqH7Av7Ynkw5kE9+f
         ZpdhkJWbkTzy6RouMTXQA7Y7as8oFrxhyAbsgB48kt8WZpmOpvbQ5s70sURc7gddEli0
         5LoCNheGSQrRJ21yKv+SH8uZoZ7+rnfw122vKdKScTFgtftgW8S1phyRpXaSqirv+Ozt
         8Vyg==
X-Forwarded-Encrypted: i=1; AJvYcCVFI7uwiZsAnEN43AHCzSrV9vyNOYNBtFpNbrWpUPdFHs9wL72fHW6btZLVyb6u8x64Ayj0Nykz@vger.kernel.org, AJvYcCWlK63jWkb5dbHK1C4/n3mmc4iZdQWDpxdSI2ftVnSYerP+R8np9PjjVYr0Ngh8PFuuJTR+4GLk4nfD@vger.kernel.org
X-Gm-Message-State: AOJu0YyeifPh5egFDOAprKOsLAEbliL7ruF6u+XGmn06qgh766vl83M8
	MTzr4/WVphcGTMigpU601+OJ2Nas06t01W0+Khs1KZJmF4gMzT9O
X-Gm-Gg: ASbGncuU3iOdBrrFf/HwiMFfZC8lQsW0t6FACE9eQSdXqbFhCAGM1d6M+Y3maPZAnK6
	QOCEzCTGRIElDe728JtrBz2XAQQQAn7OHD6NpY8KcBRxS0IW/U0H8xv2S/IrI5Y2eYvOkGYp7/A
	Te+1dWftTdvDox44LMUmnALBMWHcSuZW3ex7Zm+U/YCRU+STu6LNdzQim84oqYYlJXEVg/sY1CB
	PDysmttTR2fGCdCpXl8A7QdJE6Pu7aeOiTZ15Sdq34rOprrlUVVCJ5S3hDpkZUajOyeoVXtonr3
	Mw==
X-Google-Smtp-Source: AGHT+IFt8z4HRiHsROj1qa22WlzhwMT+NUV98JNTRGGANTJ5g0Oa0RDnO2ukkUxGGswzgStp0tod1w==
X-Received: by 2002:a05:600c:c11:b0:434:9c1b:b36a with SMTP id 5b1f17b1804b1-4361c37187bmr68103865e9.13.1734028325435;
        Thu, 12 Dec 2024 10:32:05 -0800 (PST)
Received: from [172.27.21.212] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625706caesm24123675e9.32.2024.12.12.10.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 10:32:05 -0800 (PST)
Message-ID: <5b6c8feb-c779-428a-bcca-2febdae5bb0f@gmail.com>
Date: Thu, 12 Dec 2024 20:31:30 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/12] net/mlx5: DR, add support for ConnectX-8
 steering
To: Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Leon Romanovsky <leonro@nvidia.com>, netdev@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 linux-rdma@vger.kernel.org, Itamar Gozlan <igozlan@nvidia.com>,
 Yevgeny Kliteynik <kliteyn@nvidia.com>
References: <20241211134223.389616-1-tariqt@nvidia.com>
 <20241211134223.389616-11-tariqt@nvidia.com>
 <20241212173113.GF73795@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20241212173113.GF73795@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/12/2024 19:31, Simon Horman wrote:
> On Wed, Dec 11, 2024 at 03:42:21PM +0200, Tariq Toukan wrote:
>> From: Itamar Gozlan <igozlan@nvidia.com>
>>
>> Add support for a new steering format version that is implemented by
>> ConnectX-8.
>> Except for several differences, the STEv3 is identical to STEv2, so
>> for most callbacks STEv3 context struct will call STEv2 functions.
>>
>> Signed-off-by: Itamar Gozlan <igozlan@nvidia.com>
>> Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> ---
>>   .../net/ethernet/mellanox/mlx5/core/Makefile  |   1 +
>>   .../mlx5/core/steering/sws/dr_domain.c        |   2 +-
>>   .../mellanox/mlx5/core/steering/sws/dr_ste.c  |   2 +
>>   .../mellanox/mlx5/core/steering/sws/dr_ste.h  |   1 +
>>   .../mlx5/core/steering/sws/dr_ste_v3.c        | 221 ++++++++++++++++++
>>   .../mlx5/core/steering/sws/mlx5_ifc_dr.h      |  40 ++++
>>   .../mellanox/mlx5/core/steering/sws/mlx5dr.h  |   2 +-
>>   7 files changed, 267 insertions(+), 2 deletions(-)
>>   create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v3.c
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
>> index 79fe09de0a9f..10a763e668ed 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
>> @@ -123,6 +123,7 @@ mlx5_core-$(CONFIG_MLX5_SW_STEERING) += steering/sws/dr_domain.o \
>>   					steering/sws/dr_ste_v0.o \
>>   					steering/sws/dr_ste_v1.o \
>>   					steering/sws/dr_ste_v2.o \
>> +					steering/sws/dr_ste_v3.o \
>>   					steering/sws/dr_cmd.o \
>>   					steering/sws/dr_fw.o \
>>   					steering/sws/dr_action.o \
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
>> index 3d74109f8230..bd361ba6658c 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
>> @@ -8,7 +8,7 @@
>>   #define DR_DOMAIN_SW_STEERING_SUPPORTED(dmn, dmn_type)	\
>>   	((dmn)->info.caps.dmn_type##_sw_owner ||	\
>>   	 ((dmn)->info.caps.dmn_type##_sw_owner_v2 &&	\
>> -	  (dmn)->info.caps.sw_format_ver <= MLX5_STEERING_FORMAT_CONNECTX_7))
>> +	  (dmn)->info.caps.sw_format_ver <= MLX5_STEERING_FORMAT_CONNECTX_8))
> 
> A definition for MLX5_STEERING_FORMAT_CONNECTX_8 seems to be missing
> from this patch.
> 

Should be pulled from mlx5-next, as described in the cover letter.

Copying here for your convenience:

It requires pulling 4 IFC patches that were applied to
mlx5-next:
https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/log/?h=mlx5-next


>>   
>>   bool mlx5dr_domain_is_support_ptrn_arg(struct mlx5dr_domain *dmn)
>>   {
> 
> ...
> 


