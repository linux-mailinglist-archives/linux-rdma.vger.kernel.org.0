Return-Path: <linux-rdma+bounces-7654-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8C6A30E1F
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2025 15:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12E3164165
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2025 14:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E968F24E4B8;
	Tue, 11 Feb 2025 14:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UD/OWmqW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E1626BD81;
	Tue, 11 Feb 2025 14:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739283771; cv=none; b=fd34rmy1BXaSglRk26EvlJBqODUWd/vUqnT7WdSlvmtDmFcagMgF7+lObFBcvf8LWUCLWwvW0b48OGF1D2ccKwuLngJWmOZTtgS7MT9FWZQutzs2wLnlXZY372bK3YBqqaSsOyvcI5dxLZ0vK0lt8Ekf1kof9P6XW8wE2rC81CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739283771; c=relaxed/simple;
	bh=OUhgdP9vJ7yBpdmvGUWXWCSwPdO7QzKG6dIbWGIzX7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=au3K0K/pzk5lFxR8gPAZEdLL349mfmnXtSpI5DrTwaBXOW0gWdL+qjahwW3WMlEFoKxHAekuy9aOOBvG5oEG67ke+zWoG6RYoLFhKgYPFude4s22cOTXZryZ3ML0HVtzMKT+qs/KJutrraD+AeiD9GAO3kBjNv8t0kTxMpLRXNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UD/OWmqW; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38ddfee3ba9so1832597f8f.2;
        Tue, 11 Feb 2025 06:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739283768; x=1739888568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z4joTWDJrseyEaJ20/Gmy5iaLoJYodzT47fHE8eiEpk=;
        b=UD/OWmqWnE2nz7wmqwn7m7X/Qtpdrg9IklzzchtyafzBwvIanamO7+iwUobhmMDpuy
         IEfuuW9y09x+OIOz9iT4XlBYnf61g0dF2rPi3uHcJ3Kh7BIeuUB94kh4pC92UDEZxudv
         iQMuBTbaEISjERZ8o7APGCIaula6RSSkCHqTWM7wnkzaGVGEIGbQ6Z/kjKXAb0J3hytf
         NP08jn1DiQLBdUnwdvFQiyWMTW9tEF2QydzuNTKC7/XdYNxYluKr90aQuEDgC9sONN7x
         9sySekC9gTeQj55QwkWg5fgnjkdpUbBzf6zK+bjsa6DM+pfKSygOsccx9m/shgz538Iu
         qhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739283768; x=1739888568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4joTWDJrseyEaJ20/Gmy5iaLoJYodzT47fHE8eiEpk=;
        b=H9aBEn3ipFyT17iGQHgn0+i/VAx9OH+KhmRH7vBTruqjUiKsF+xyjiKtcDeZbaGJTj
         rJvdlMOp02jnSTLOjbDZqSv1AfKjz7e7VXmYHQq//i/WIhJ5SHGfzRGzgqvbNE31bAd2
         lqzfiZQJTqP10V9qWvVPTpWIL8PkH5qSzcFfvgp59bUmrKINDw9F7MHDWDa8KQT8Cl3U
         mlidgwDXMgHdD3qQT8tDSv+6CyvlhZWoVBah+Qx5HQhM4Ug+tFj9KFCOzSa2IKmB3YJb
         GOiK7x/6WmUVgMNzW89kR8b6ktMfh5yXWFY8mv6IIWLtKyIVslzVUbbaG0EIi8ILbbsa
         CsHA==
X-Forwarded-Encrypted: i=1; AJvYcCUtdD8DjzVnOuXwWjuFMecTSVX/qy1gP80hCmRxsGtLT2OwkeWJ+gODmNfgXj/k3VebBAeL0rP3ApeUNDSelGI=@vger.kernel.org, AJvYcCWqsAM746DnISF3PQvKiqkg1cEE1gG4H+HrK70sqAe2yK/yIsr18czT92jGh97+oL4Ig/Ai4FjLA/61Qw==@vger.kernel.org, AJvYcCWrqU9MSNr6hOfXNlOp32SkJMYwl6wOubpX406jIrppqrYa4JnBR9KDPa5uwJFQC4u9xw5mtO3qBBxyG6EH@vger.kernel.org, AJvYcCXOqkdvjv7JmErSEeAlyAoYVDQsjmvz0dibKxxMIfOnPGSzPzRdqqoU9uEA0ZPefDG7IRZ4pthU@vger.kernel.org
X-Gm-Message-State: AOJu0YyOpGjQic7V6rjxQcIQCY9MAmwGlkjcSjPlmeSVqcTkn/jMZYtW
	NPJ82+VjS/vhje/yx3mSehCMh1xpN6WxWjYgkfIGXIumsNMY491w
X-Gm-Gg: ASbGncur3SFy7E/mfPQL7FJsWL8pS4BWcFjwz8a8o26pd2G6R3kYh/2+JBcZltl/I3m
	7jkjjYIgBqnbkrY5Gjr/AGMRKKh3c2OtEZSs0gKMCAwXwwaY2ILTycEDt46Ua0bDx9Peiui6dna
	/JqVmgVaBv3J2I52jMM5xn8ohFUsO0VV7wF7OdE2c2zPBilY1tqE4LvBw/mNWZijfnhlersxnGl
	1/01Ygc+KBkwN0T91ALs08CYuIykOoJrIsWjF9qlmlPht7WRTbK7BegYwNMMnDGvWwvNQJ7DkBx
	w8TN7JD356zeMSVd8VV5WhGfN5w/C1Hft/8V
X-Google-Smtp-Source: AGHT+IE7tyYKAi0vc3JqfyNdKdx4L2EKdtttgjNbGxEtmPQcKD0wJzFlZI1yvIEAqo8r4WCaylqWDQ==
X-Received: by 2002:a05:6000:1569:b0:38d:dce7:86cd with SMTP id ffacd0b85a97d-38ddce78744mr7958245f8f.24.1739283767750;
        Tue, 11 Feb 2025 06:22:47 -0800 (PST)
Received: from [172.27.54.124] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390d94d753sm212084155e9.11.2025.02.11.06.22.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 06:22:47 -0800 (PST)
Message-ID: <d11de4d4-1205-43d0-8a7d-a43d55a4f3eb@gmail.com>
Date: Tue, 11 Feb 2025 16:22:43 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx4_core: Avoid impossible mlx4_db_alloc() order
 value
To: Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Yishai Hadas <yishaih@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250210174504.work.075-kees@kernel.org>
 <3biiqfwwvlbkvo5tx56nmcl4rzbq5w7u3kxn5f5ctwsolxpubo@isskxigmypwz>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <3biiqfwwvlbkvo5tx56nmcl4rzbq5w7u3kxn5f5ctwsolxpubo@isskxigmypwz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/02/2025 2:01, Justin Stitt wrote:
> On Mon, Feb 10, 2025 at 09:45:05AM -0800, Kees Cook wrote:
>> GCC can see that the value range for "order" is capped, but this leads
>> it to consider that it might be negative, leading to a false positive
>> warning (with GCC 15 with -Warray-bounds -fdiagnostics-details):
>>
>> ../drivers/net/ethernet/mellanox/mlx4/alloc.c:691:47: error: array subscript -1 is below array bounds of 'long unsigned int *[2]' [-Werror=array-bounds=]
>>    691 |                 i = find_first_bit(pgdir->bits[o], MLX4_DB_PER_PAGE >> o);
>>        |                                    ~~~~~~~~~~~^~~
>>    'mlx4_alloc_db_from_pgdir': events 1-2
>>    691 |                 i = find_first_bit(pgdir->bits[o], MLX4_DB_PER_PAGE >> o);                        |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>        |                     |                         |                                                   |                     |                         (2) out of array bounds here
>>        |                     (1) when the condition is evaluated to true                             In file included from ../drivers/net/ethernet/mellanox/mlx4/mlx4.h:53,
>>                   from ../drivers/net/ethernet/mellanox/mlx4/alloc.c:42:
>> ../include/linux/mlx4/device.h:664:33: note: while referencing 'bits'
>>    664 |         unsigned long          *bits[2];
>>        |                                 ^~~~
>>
>> Switch the argument to unsigned int, which removes the compiler needing
>> to consider negative values.
>>
>> Signed-off-by: Kees Cook <kees@kernel.org>
>> ---
>> Cc: Tariq Toukan <tariqt@nvidia.com>
>> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Cc: Yishai Hadas <yishaih@nvidia.com>
>> Cc: netdev@vger.kernel.org
>> Cc: linux-rdma@vger.kernel.org
>> ---
>>   drivers/net/ethernet/mellanox/mlx4/alloc.c | 6 +++---
>>   include/linux/mlx4/device.h                | 2 +-
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx4/alloc.c b/drivers/net/ethernet/mellanox/mlx4/alloc.c
>> index b330020dc0d6..f2bded847e61 100644
>> --- a/drivers/net/ethernet/mellanox/mlx4/alloc.c
>> +++ b/drivers/net/ethernet/mellanox/mlx4/alloc.c
>> @@ -682,9 +682,9 @@ static struct mlx4_db_pgdir *mlx4_alloc_db_pgdir(struct device *dma_device)
>>   }
>>   
>>   static int mlx4_alloc_db_from_pgdir(struct mlx4_db_pgdir *pgdir,
>> -				    struct mlx4_db *db, int order)
>> +				    struct mlx4_db *db, unsigned int order)
>>   {
>> -	int o;
>> +	unsigned int o;
>>   	int i;
>>   
>>   	for (o = order; o <= 1; ++o) {
> 
>    ^ Knowing now that @order can only be 0 or 1 can this for loop (and
>    goto) be dropped entirely?
> 

Maybe I'm missing something...
Can you please explain why you think this can be dropped?


>    The code is already short and sweet so I don't feel strongly either
>    way.
> 
>> @@ -712,7 +712,7 @@ static int mlx4_alloc_db_from_pgdir(struct mlx4_db_pgdir *pgdir,
>>   	return 0;
>>   }
>>   
>> -int mlx4_db_alloc(struct mlx4_dev *dev, struct mlx4_db *db, int order)
>> +int mlx4_db_alloc(struct mlx4_dev *dev, struct mlx4_db *db, unsigned int order)
>>   {
>>   	struct mlx4_priv *priv = mlx4_priv(dev);
>>   	struct mlx4_db_pgdir *pgdir;
>> diff --git a/include/linux/mlx4/device.h b/include/linux/mlx4/device.h
>> index 27f42f713c89..86f0f2a25a3d 100644
>> --- a/include/linux/mlx4/device.h
>> +++ b/include/linux/mlx4/device.h
>> @@ -1135,7 +1135,7 @@ int mlx4_write_mtt(struct mlx4_dev *dev, struct mlx4_mtt *mtt,
>>   int mlx4_buf_write_mtt(struct mlx4_dev *dev, struct mlx4_mtt *mtt,
>>   		       struct mlx4_buf *buf);
>>   
>> -int mlx4_db_alloc(struct mlx4_dev *dev, struct mlx4_db *db, int order);
>> +int mlx4_db_alloc(struct mlx4_dev *dev, struct mlx4_db *db, unsigned int order);
>>   void mlx4_db_free(struct mlx4_dev *dev, struct mlx4_db *db);
>>   
>>   int mlx4_alloc_hwq_res(struct mlx4_dev *dev, struct mlx4_hwq_resources *wqres,
>> -- 
>> 2.34.1
>>
> 
> Justin
> 


