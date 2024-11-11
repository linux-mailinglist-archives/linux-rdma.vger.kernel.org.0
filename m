Return-Path: <linux-rdma+bounces-5919-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5782B9C3DD9
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Nov 2024 13:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5D23B241B9
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Nov 2024 11:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF86199FC9;
	Mon, 11 Nov 2024 11:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5syxAM7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C23719995E;
	Mon, 11 Nov 2024 11:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731326386; cv=none; b=rpZdqMasw6zxraVZFeQmkx2+iBXo0CyCu6qcyy4CNVyFlGAKy3VJyqog8UNZl/Na2oi0mIhP5WkRRLWuomtXlHGIZT/4DM2hc8uxYhPGnxzutGQTYP4CWQZaQtrRsx7dXg6plt5AugDw/PT5CAc50g2iRRBzBnkCHzIbWRCbfJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731326386; c=relaxed/simple;
	bh=KNU4wY5wjmSygjsz8VFqZf/kfLQiRGmzqRW7gpjXsQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Akf8pUvKjwycHaThZvesbwQRJqAqPVarXSCVfKwzibhPVplmT1W89b23t9wHCHSvTgWpPwm2M6vYJjsKEnqLxbj0QF4L015qQJIvD+nPNSRFUn6cwSDueeisGwRA7iMSqQQvuL0uYDJ62V3DscuqwUN7cbQDoVtJna8B5XrLw9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5syxAM7; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a99eb8b607aso651503366b.2;
        Mon, 11 Nov 2024 03:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731326383; x=1731931183; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4KXooGMOhmi1Th3JVflxn1LYQFUXTjJHyv8htJbwU4E=;
        b=H5syxAM7OtSiBApwZpzfTbP+L21TtjzL6Xzszir6w4ztYsSeeDFn+fMSjOJ4cYTkD9
         kA0UoC0EPkYvXmjlDoUZY2mIkcH4ep6fdLR9BEY5s/pcTPNxir2m+lrYEinf0EgN4X/f
         KfygUMDrh2zXJFonyIkjJki8E7hEf1YzpAeoJU0LxAy8LGyuSQq+I6DhAKmC9ZKCkWLj
         36H2xb13W/ySMyHA+3HhUz944KsX4bTI/r5tAundXcfOpzYGmcd8Fkd7de0yRXndbFR8
         eGpfISX5xyquo5AobWESgysSGXs0mvtdOcV4WVWZt87tzIglHGOHxS5vWu6SfpD3nZIK
         uF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731326383; x=1731931183;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4KXooGMOhmi1Th3JVflxn1LYQFUXTjJHyv8htJbwU4E=;
        b=IR7CiQAO7A7FJdmGOEuZUMG0qrc+OASrmhSXzazmblHpgCV86dcCrhjBI0XfrmXzi/
         oDSWzqOyD7xwCokWpimEvst9nb17DNw04r51+DQt+DxZbiNCOzWltAQhNItaFZxCUjOE
         o305obyye8XIiVo8QjfkKUuRicAzKf/aMlU6x8ntpVaxk2x3LLZ/eUl2iFptw5l0aUCF
         A3Gwg3G1tpU1EfSPiri5u1DeP1RwuV+C5ZY0/vMQQ+wmgcwDUFXtFqWJ0UcXEedOUevY
         7VlNpnTver+vrmCNAk+U923d8Tv2BId+TfkLz6d1esz14CuwgABli4/w/pf1q3sJoDHz
         73mg==
X-Forwarded-Encrypted: i=1; AJvYcCVjvQiJ2YiluS6ugDpMCInrzDGB4eFnTDu3GkZdrB7BNyQ5FM2NZM4PnEo4OctJcU3H3W5rGzDzKJ/IlG8=@vger.kernel.org, AJvYcCWO0iSwgTvAAixsxmp9AIx2rlYV0+KdT/KXt0vBQ7m9IEan9RhqMm12Yt/Glwyf/L7XHn+TjlK8DaLvNA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFD+3QKgmH9KcoayTB/1lEGjgsh0k1iAvcyqatVNOsX94wI66d
	Gjw3wX91+24JRlakK1mx6wPNSVbkulalkZMOZ8iN5RiXBoQpCdQ1
X-Google-Smtp-Source: AGHT+IF00jAtfRc2EUX+k3JSZj7csi0+1+brLEMrWXf/8w0U7/FZXLloGHMckhc11kzEm58d/QUUAQ==
X-Received: by 2002:a17:907:7b86:b0:a9d:e01e:ffa9 with SMTP id a640c23a62f3a-a9eeff449femr1173865766b.33.1731326382147;
        Mon, 11 Nov 2024 03:59:42 -0800 (PST)
Received: from [172.27.51.98] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0e2e41bsm586296566b.191.2024.11.11.03.59.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 03:59:41 -0800 (PST)
Message-ID: <aabb11f4-74ea-4e57-a085-3448e64a2d07@gmail.com>
Date: Mon, 11 Nov 2024 13:59:37 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] mlx5/core: deduplicate
 {mlx5_,}eq_update_ci()
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
 <20241107183054.2443218-2-csander@purestorage.com>
 <CY8PR12MB71954BBB822554D67F08A1CBDC5D2@CY8PR12MB7195.namprd12.prod.outlook.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <CY8PR12MB71954BBB822554D67F08A1CBDC5D2@CY8PR12MB7195.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/11/2024 12:49, Parav Pandit wrote:
> 
>> From: Caleb Sander Mateos <csander@purestorage.com>
>> Sent: Friday, November 8, 2024 12:01 AM
>>
>> The logic of eq_update_ci() is duplicated in mlx5_eq_update_ci(). The only
>> additional work done by mlx5_eq_update_ci() is to increment
>> eq->cons_index. Call eq_update_ci() from mlx5_eq_update_ci() to avoid
>> the duplication.
>>
>> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
>> ---
>>   drivers/net/ethernet/mellanox/mlx5/core/eq.c | 9 +--------
>>   1 file changed, 1 insertion(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
>> b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
>> index 859dcf09b770..078029c81935 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
>> @@ -802,19 +802,12 @@ struct mlx5_eqe *mlx5_eq_get_eqe(struct mlx5_eq
>> *eq, u32 cc)  }  EXPORT_SYMBOL(mlx5_eq_get_eqe);
>>
>>   void mlx5_eq_update_ci(struct mlx5_eq *eq, u32 cc, bool arm)  {
>> -	__be32 __iomem *addr = eq->doorbell + (arm ? 0 : 2);
>> -	u32 val;
>> -
>>   	eq->cons_index += cc;
>> -	val = (eq->cons_index & 0xffffff) | (eq->eqn << 24);
>> -
>> -	__raw_writel((__force u32)cpu_to_be32(val), addr);
>> -	/* We still want ordering, just not swabbing, so add a barrier */
>> -	wmb();
>> +	eq_update_ci(eq, arm);
>>   }
>>   EXPORT_SYMBOL(mlx5_eq_update_ci);
>>
>>   static void comp_irq_release_pci(struct mlx5_core_dev *dev, u16 vecidx)  {
>> --
>> 2.45.2
> 
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> 

Acked-by: Tariq Toukan <tariqt@nvidia.com>


