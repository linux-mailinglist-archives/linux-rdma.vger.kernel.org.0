Return-Path: <linux-rdma+bounces-5920-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FF49C3DDC
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Nov 2024 13:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 351E61C2179D
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Nov 2024 12:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FA217C227;
	Mon, 11 Nov 2024 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuvNKBFg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEA4199943;
	Mon, 11 Nov 2024 12:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731326405; cv=none; b=kkFeR0pqV1OIFOlWuuL0ckfxRGsShCpcrXw4VtJbiXZQ7AQtjSXK4Acc0Wza1UGm9N4cwfRLpiTSqQ6UDh7zVVOBUb1t0vy0jCPfZ4u6u7eiT7FafpfAO9G+WZ/OsV4XmpwgrPqyYy2mXumVk3KpKBZ8F5uDNgKHXDGEtX7xm7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731326405; c=relaxed/simple;
	bh=aeOsBBfNgbMgQSr1NnwyxTSfx3+qg+WQGpKzj08cjqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hiFWMWObBu+XAmUY4k/p74OUSAkHZz0Vey6qhOInWaS2GQmSSDX1vry5rKzDmYiOuOSHyt1e6qPd9oItQdpft2IHo+Jt7myFkjIWTzW9EwIu8JMn0FoRfCy77ZvXh0qKuRPB4k5jTRn1kUkT7rHXmt8AZ7w3Jj8h2162ZNUprzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuvNKBFg; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so188542266b.0;
        Mon, 11 Nov 2024 04:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731326402; x=1731931202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ERz2Qab/QZHhmp5ujVARsacqaYheTwZvXRQSx29cBsY=;
        b=iuvNKBFg8P3JMe5bizOeWjTKqe87+Bw8aoDThhHn9dRsqMNmQSio73UGNjZQan6Wng
         dgpwJyLv3cw0q/R4aYaVV1InSi+7JPbMWLf2z0Sqf965WNFLl/tJVAe1No2G98GTRQAF
         OZO5xup74bOBK0reGayY2ZLl3LTKI/DSLgqgNsrXevLOFlWF0nT7nD6KtySWVUdq6DVP
         8r+1x6OUpnxBwytXMwsEDEjzrDZPP6XbtCPUUbDRV5hD00QFANOnc5CUzH4WQduhudkp
         vWbSAFmAs/eDYoxDNkjTJ6NmT1cKFqlACka8yHBc31mnXNq30rGq1f0NNPEPj1rXMbbn
         zNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731326402; x=1731931202;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ERz2Qab/QZHhmp5ujVARsacqaYheTwZvXRQSx29cBsY=;
        b=A1KTHZnrNhd3/ZStLvQGX9X8N8gEOkmGmNDJKTSikmN9pfVUlaNJvR8kbZqpOhOjl1
         Sufils/Yqgh/SswOhi3/5VLi9XKPUZYWA93gfw9bhV3km9G3pP4qGRUbB/REfqT+T45v
         sI2rK/LcoItQd+xjJSBTdemh0B3+vGEBppNgPdJYiXKHHUUL0OxvHVg/BLB+LVzA5+GN
         4GgbAP1OHn2/CDU9w6Di0mV9dR3HUaEvc/doU14byKm7FNwpGlNH9IAHkerNwet14ofo
         A4ts3p1236/yRGF+CIPW7Himqs8Huy3pJdJ6YHHcaBpsMFDhPBBPD+vsjmPyY+7mJM3l
         /QQA==
X-Forwarded-Encrypted: i=1; AJvYcCVCv1VKkmw7teADE7fp6aRpOOydZcrMIsN6cdNqkzIjSmjOZsQYRNuYo2eznN1ISYMfFmMxKkvBiuUYkA==@vger.kernel.org, AJvYcCVUt2++MR0kpkspqS3SJJ5jngJ1FrGzZdO308P9psyG+a8FPhR9vfGLx9SCuSW3c0E1xhL3ntSsiSDFnUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOD09wMDKD0IAgLaTCr8MIi0HgMGNBJIWaHNvlfxSTk8p3iNdK
	uFPHD3/fo/HdYPhKnxSwh2q/rm+GqnsxxKeg3ZlGWZOy3UAgbpEq
X-Google-Smtp-Source: AGHT+IElto91yI/s7EETqqUQ6isEerHA+zumw4wYVTzMGHsiInbZsOqOX2Jy0VD1W+4Ay5TlSktDLA==
X-Received: by 2002:a17:907:94c1:b0:a9e:d417:c725 with SMTP id a640c23a62f3a-a9eefebd49emr1221025466b.3.1731326400309;
        Mon, 11 Nov 2024 04:00:00 -0800 (PST)
Received: from [172.27.51.98] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0dee5e6sm584993166b.137.2024.11.11.03.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 04:00:00 -0800 (PST)
Message-ID: <f1a56268-f1d5-4204-be34-5c7a1749bcd9@gmail.com>
Date: Mon, 11 Nov 2024 13:59:57 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] mlx5/core: relax memory barrier in
 eq_update_ci()
To: Parav Pandit <parav@nvidia.com>,
 Caleb Sander Mateos <csander@purestorage.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <ZyxMsx8o7NtTAWPp@x130>
 <20241107183054.2443218-1-csander@purestorage.com>
 <CY8PR12MB7195A03D0F6C66D906354549DC5D2@CY8PR12MB7195.namprd12.prod.outlook.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <CY8PR12MB7195A03D0F6C66D906354549DC5D2@CY8PR12MB7195.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/11/2024 12:46, Parav Pandit wrote:
> 
>> From: Caleb Sander Mateos <csander@purestorage.com>
>> Sent: Friday, November 8, 2024 12:01 AM
>>
>> The memory barrier in eq_update_ci() after the doorbell write is a significant
>> hot spot in mlx5_eq_comp_int(). Under heavy TCP load, we see 3% of CPU
>> time spent on the mfence instruction.
>>
>> 98df6d5b877c ("net/mlx5: A write memory barrier is sufficient in EQ ci
>> update") already relaxed the full memory barrier to just a write barrier in
>> mlx5_eq_update_ci(), which duplicates eq_update_ci(). So replace mb() with
>> wmb() in eq_update_ci() too.
>>
>> On strongly ordered architectures, no barrier is actually needed because the
>> MMIO writes to the doorbell register are guaranteed to appear to the device in
>> the order they were made. However, the kernel's ordered MMIO primitive
>> writel() lacks a convenient big-endian interface.
>> Therefore, we opt to stick with __raw_writel() + a barrier.
>>
>> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
>> ---
>> v2: keep memory barrier instead of using ordered writel()
>>
>>   drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h
>> b/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h
>> index 4b7f7131c560..b1edc71ffc6d 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h
>> @@ -70,11 +70,11 @@ static inline void eq_update_ci(struct mlx5_eq *eq, int
>> arm)
>>   	__be32 __iomem *addr = eq->doorbell + (arm ? 0 : 2);
>>   	u32 val = (eq->cons_index & 0xffffff) | (eq->eqn << 24);
>>
>>   	__raw_writel((__force u32)cpu_to_be32(val), addr);
>>   	/* We still want ordering, just not swabbing, so add a barrier */
>> -	mb();
>> +	wmb();
>>   }
>>
>>   int mlx5_eq_table_init(struct mlx5_core_dev *dev);  void
>> mlx5_eq_table_cleanup(struct mlx5_core_dev *dev);  int
>> mlx5_eq_table_create(struct mlx5_core_dev *dev);
>> --
>> 2.45.2
> 
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> 

Acked-by: Tariq Toukan <tariqt@nvidia.com>


