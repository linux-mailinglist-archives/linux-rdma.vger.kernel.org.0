Return-Path: <linux-rdma+bounces-8184-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C8FA47A62
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2025 11:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8432E3B38A1
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2025 10:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0206A22839A;
	Thu, 27 Feb 2025 10:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijhtaovO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0148021C18F;
	Thu, 27 Feb 2025 10:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740652489; cv=none; b=r6fWML+xDfvUlM2cBqp5Nb40J0brW6WaIZ5VgINz9rsBbQRGlOsMIB7GyrEC1Tw7EY4xUEgOya1/FhhCs9qMwgYjZ6IeUwMzjA1R4JyRHHCt2BvLbjtqwh6gc0T6wZFOTNZUnOf0z801/8Of5FiQi18foNl4TdFWICVD0lo2ILY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740652489; c=relaxed/simple;
	bh=YJKmHFUcVEtxuOOaxd/RpiuUqI9ez1eSLQC9p5kpvjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ovz0R2/8QQ5WQ8mv681hitG0rHDgfACc36WSFeJoHZEGHf7tpdP+tRFhdwAz6tLJA59Vy/qjhIGimf/fqxUePqioX2P3Uf4DFxWetW1XanW2LlQpExmx+8YhICn17kGKdrW2DPYqyzu4S222jMk4Z8ewOk670Fj7YX6GOnDp5AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijhtaovO; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5ded6c31344so966558a12.1;
        Thu, 27 Feb 2025 02:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740652486; x=1741257286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8F+iHOkiCbQfBJ8Gfn9W0Ck6s4OTNsybtRyz6gEBB30=;
        b=ijhtaovOUqX4y8Jq0PL+uBHv6gUur6ai1CH4FMTtmd8ktoqeEh2/MhNUDb0mdEsJZr
         ogZaJum8IiRyOWgZn8TtZgkF6qama5xIaSaGECAuAEJWY3VyzWLgbaOziSzGnGt1EJaE
         uoQ2+r1w1jyI1wY1Z3mzPtcXW0rzeA6/BjPkuxaB4DfjoV7yg2yrjJ/GBUHmtQhkyonG
         nN3/bQgNnOTBQgIyViYrongx6UXqWosET8ADY9tN2mvEKv4WpY6VJOrxEEuf38BXR7HO
         mbW9ihJErb9O7LrDIMEj4h3lPs3u1iqPF4psYFd2W3SZK5smUTCwjsmR75/y9nfaNs91
         LYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740652486; x=1741257286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8F+iHOkiCbQfBJ8Gfn9W0Ck6s4OTNsybtRyz6gEBB30=;
        b=L1nTY3nytVlL51IOA7Ae85T4jBlrbzeMJ7bO0dKh+eO8U2LPXO4n75g5I4edhh9cHd
         YSWCfYVaig//2ZW9+EL2X4u7G0dny8g40m/dRZ+w8FtlfCJIaumV743ryxWLjJajBZoE
         1gIgKhSwINhl7cn0bGObgghXqu9B5IlcvXJ8mXkpneJoOyJC4JYqJfyG85Whm6hDXBeT
         XASNKwi4ILVVotmw1KV4I+lawa8vT/WYiMugaRXQrUSziUy7MBg3vgOBwlzMKyy28qum
         F8QdybuM0xb7m54v7nx4iq8v3AN9b9R/p8FF36LDAde/NqZO8gXigmsPyAZfFAyEP7KN
         y+1A==
X-Forwarded-Encrypted: i=1; AJvYcCULlBD0JK25b23IufI+1YQ1atuPj7IogEW9N+liBl30F6KnavM42Wc1rMqHnjTHOHI68sGKTF+Kq/EY9Xo=@vger.kernel.org, AJvYcCWYDLltmP8T8GA5JRKEihd2wADL4lDxVQHrzDTQR8VB4HbtTMjHBXvpTsl29jmLyw5tQnT6UHGC0+Pnvw==@vger.kernel.org, AJvYcCWmwdWuK4xhCRNyQ71kxiAKOO0Vee8ye4j3Lv2FFSMzQOnM+mpOLOPn6pdullBiUSJh/x2w2Dru@vger.kernel.org
X-Gm-Message-State: AOJu0YzPKva88GCKQhc2zfiy3gS95UGn/ZjXlYMlmhp/4afPWSwudZob
	Jvr5qF61hOYbzXjVIWB0AVNpvghT91NTIH5LD9Mov/Y7dDOsDtoz
X-Gm-Gg: ASbGnctfJFRj+sAcTYQFZaeDndrSOh/JuGY8fMY3ALV5440EmtjWIOaGO3FND+OaO+U
	S06lDPMqhhFHrzZYsnLAePN1DuPxiSRuHvPFz8KF9M7JQWhNCIi0AkPUzI+XV9Vt4deGjhAV9cK
	Oxhd5t/vOlm7Xu2e+muUVrJl2DQqhhr3qbs51m0X+iepyysnBfw+KCPdbnyfEXFRv2JdQCrCdRY
	+NKOPLCi5VsMSWVtVuFadTVvNmS65egIKuXSWsxBpcYwIpc0ZWLMYfJq2NLKezQErf8Z6X/c305
	9U60I9ngE/y2Rky2kJccjlv8s7p8mRBjDq69Nt+BVNOTrfM=
X-Google-Smtp-Source: AGHT+IHXv8U7mkW1xq4Vnant0P7iLY68e80NUqnP+Id7Fkl+D0OacWn2R65BtGAAnIPruizAgHDIWA==
X-Received: by 2002:a05:6402:2690:b0:5de:a6a8:5ec6 with SMTP id 4fb4d7f45d1cf-5e4455c2f52mr28423477a12.10.1740652485728;
        Thu, 27 Feb 2025 02:34:45 -0800 (PST)
Received: from [172.27.50.139] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c43a6f2bsm878709a12.75.2025.02.27.02.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 02:34:44 -0800 (PST)
Message-ID: <3c8badc3-2f1e-4877-a770-ad133f69f14a@gmail.com>
Date: Thu, 27 Feb 2025 12:34:41 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/4] net/mlx5: Expose crr in health buffer
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shahar Shitrit <shshitrit@nvidia.com>,
 Moshe Shemesh <moshe@nvidia.com>
References: <20250226122543.147594-1-tariqt@nvidia.com>
 <20250226122543.147594-4-tariqt@nvidia.com>
 <Z7/+lxTndCRC6OtE@mev-dev.igk.intel.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <Z7/+lxTndCRC6OtE@mev-dev.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 27/02/2025 7:56, Michal Swiatkowski wrote:
> On Wed, Feb 26, 2025 at 02:25:42PM +0200, Tariq Toukan wrote:
>> From: Shahar Shitrit <shshitrit@nvidia.com>
>>
>> Expose crr bit in struct health buffer. When set, it indicates that
>> the error cannot be recovered without flow involving a cold reset.
>> Add its value to the health buffer info log.
>>
>> Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
>> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> ---
>>   drivers/net/ethernet/mellanox/mlx5/core/health.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/health.c b/drivers/net/ethernet/mellanox/mlx5/core/health.c
>> index 665cbce89175..c7ff646e0865 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
>> @@ -96,6 +96,11 @@ static int mlx5_health_get_rfr(u8 rfr_severity)
>>   	return rfr_severity >> MLX5_RFR_BIT_OFFSET;
>>   }
>>   
>> +static int mlx5_health_get_crr(u8 rfr_severity)
>> +{
>> +	return (rfr_severity >> MLX5_CRR_BIT_OFFSET) & 0x01;
>> +}
>> +
>>   static bool sensor_fw_synd_rfr(struct mlx5_core_dev *dev)
>>   {
>>   	struct mlx5_core_health *health = &dev->priv.health;
>> @@ -442,12 +447,15 @@ static void print_health_info(struct mlx5_core_dev *dev)
>>   	mlx5_log(dev, severity, "time %u\n", ioread32be(&h->time));
>>   	mlx5_log(dev, severity, "hw_id 0x%08x\n", ioread32be(&h->hw_id));
>>   	mlx5_log(dev, severity, "rfr %d\n", mlx5_health_get_rfr(rfr_severity));
>> +	mlx5_log(dev, severity, "crr %d\n", mlx5_health_get_crr(rfr_severity));
>>   	mlx5_log(dev, severity, "severity %d (%s)\n", severity, mlx5_loglevel_str(severity));
>>   	mlx5_log(dev, severity, "irisc_index %d\n", ioread8(&h->irisc_index));
>>   	mlx5_log(dev, severity, "synd 0x%x: %s\n", ioread8(&h->synd),
>>   		 hsynd_str(ioread8(&h->synd)));
>>   	mlx5_log(dev, severity, "ext_synd 0x%04x\n", ioread16be(&h->ext_synd));
>>   	mlx5_log(dev, severity, "raw fw_ver 0x%08x\n", ioread32be(&h->fw_ver));
>> +	if (mlx5_health_get_crr(rfr_severity))
>> +		mlx5_core_warn(dev, "Cold reset is required\n");
> I wonder if it shouldn't be right after the print about crr value to
> tell the user that cold reset is required because of that value.
> 

I think it's fine here, to not interfere the mlx5_log sequence.
Also, in the future we might have multiple cold reset reasons, 
generating the same single print.

I'll keep it as-is.

> Patch looks fine, thanks.
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 

Thanks for your review.


