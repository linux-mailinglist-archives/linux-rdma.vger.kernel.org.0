Return-Path: <linux-rdma+bounces-9474-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA552A8B42D
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 10:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCF9B1895CA0
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 08:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548E0230D0D;
	Wed, 16 Apr 2025 08:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUunA5Yb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB9D2309BE;
	Wed, 16 Apr 2025 08:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744793011; cv=none; b=BUq4lBZp0YwAWv+cUm/OKI9tOWMZKdwFj2ZnFwFZJlQ+uNuHn7Wh/JTMdXGUMfu3cnDGscwHaVcH6t+vVbkpYpwpWE+kAyyfnsm6VEKsobJckw1kqVpQBfnVEguuBNRYQOXjtjS2NweVKNKDIHX8SY2UC/koZi5BM7eJ3EKDwNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744793011; c=relaxed/simple;
	bh=nyUJtYiUjBjYYSAqTLhcIC3VjH6cvjN+MabNE2Z+0KA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P2fSM+/i5DHmh0RCpqqAeHvsWaZ9eXyUaoUG68vAx/zGrR3xLIT4PTH2rlcd1Z7HBkRr8sybLOE4CprK1QfeToOJrwB2esqBq9g+Ob52OWDsH9yUp65Lh3nRyBrgelFUTn2X7Is/f3fJVbVud0GeCnU+StFOk9Jr+209ubrQFE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUunA5Yb; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso64154955e9.1;
        Wed, 16 Apr 2025 01:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744793007; x=1745397807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Sjiyx/fN+GWyu9km6Rmgf6dDU0MGkyvJNdC+0C4yHI=;
        b=lUunA5Yb/8AR7yEf8CX1exs4MoGrD+1uWbQzVe6VbEg5W7pZjm7pcl/7gEUg9Jdq1X
         /O079IkWh0Q1zR7puqwzAi6WUv5PmocE/yPJVjKob8ipwbRrEH4ZThyMJzxCV6BpS7rb
         /t3+v7pzhBrNt6qlrOu5AUtQC3AfVDNS0NbwrFJPfMS/zQfkx+tE7nprRJhvTX6mXRms
         9lgS+MMpOGI7uxPeAFCXTzyk62oVruLIwJ/1NcWnx6jCt4BtGBym2MxwefFuGzFvu3oY
         GUfZoWFcKbGYm8tl86pcdTumxL6ZY97qkgX/Iy25mz6pReCQRrE1rL9fyJQQjXwGJd5C
         UC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744793007; x=1745397807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Sjiyx/fN+GWyu9km6Rmgf6dDU0MGkyvJNdC+0C4yHI=;
        b=er75Cmq+XcMkThqkId0f/AktKYVLVR41n4MTDZqLWes5QUOPwFSlPZQSaxFGuj3Sc7
         t64uPqFoAvx0vezUsCSk+2b+2pZTOcbjX4idLQbghWBeaG1hELZ6nDFtL9IjwoqscvFR
         EnaKmxZesHYPQsww7RfnMdwknt9pXOW0d7+idsYZYZAtQjpxNfyNue1pkMfwGTiCo6jU
         z1h9gZWs5qSyuTYoi/hROrjrYNYz4UOasFxKZOoP8qZBZ3vZEkB4y5U4geTZqnUKa3xS
         hsytFaftkMUN6VfMgHrxRbEOOlrB1tmTaLuOZbRaWZisNC+ph+gZ9zpXv0fIczOgDcib
         ISjA==
X-Forwarded-Encrypted: i=1; AJvYcCX/bIlfP60lb4fCKh384R3blEK5vMd/kG2UODrDJHSS3V3qPAqSRn6v4C2PO0RiT4LdTMK6d1JoFXQPcw==@vger.kernel.org, AJvYcCXhJ5ss4HMh4rF75rUzBYQAjIqtgJXR0fsotF9PMexoeqY5R8bSdg3Wc8EGQWRMeDCD9kOIri1Ph5h9kUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy+QLC40Ns7zX8u2GBL/W0M1a8dgr+WVEtU+c6hvL/zadGa4hR
	YToX27RwyfjoQEKO3YBsa2rIeytIkebcVThcEe/UzuaN8O9rtCzg
X-Gm-Gg: ASbGncuNoCS8+NT8mH58VMnqMX0p/OJ7SuhcKaEVcyRKy8engs80sBpj/2SDzm3VmZ8
	w+OOBsRBCNJXJ8fiioErYqo9YbSEVopaCZ0k9kHGV4+xtpWJAi8K1tpUcA6DYZ3ER+omO/pajnM
	zelBHvAcWNUj2FHm+PTmcIpRlaPrDALGvVWgOFGShvw0mVdNw9IKTdRxwPb5UcFhwymqfGnbaSW
	pd3N+Kik4oMJ2zDqZLcFbqqdSzwRW9D0pHYagpQoQomp6AXT3eZkZohTfpbzPX+3xujvJbxgvNC
	y1YNvoLhRYy9OF+VNK5fNwDbDdDbuHMGZ7EBF2usXG4aXAZsfgJguvmaPP0=
X-Google-Smtp-Source: AGHT+IHpy+sYxBz/Oe4uCHlDqUk4DjWqp50J3JpjBoi6v0tNOLkb64P60xE638/sIU0sdirYCxgssw==
X-Received: by 2002:a05:600c:45ce:b0:43d:23fe:e8a6 with SMTP id 5b1f17b1804b1-4405d5fccb7mr8045235e9.5.1744793007111;
        Wed, 16 Apr 2025 01:43:27 -0700 (PDT)
Received: from [10.80.20.47] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf44577dsm16573027f8f.94.2025.04.16.01.43.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 01:43:26 -0700 (PDT)
Message-ID: <1f99c69d-42c2-4093-9c13-c0b137994e30@gmail.com>
Date: Wed, 16 Apr 2025 11:43:23 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] net/mlx5: Fix null-ptr-deref in
 mlx5_create_{inner_,}ttc_table()
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, amirtz@nvidia.com, ayal@nvidia.com,
 Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Henry Martin <bsdhenrymartin@gmail.com>, Mark Bloch <mbloch@nvidia.com>
References: <20250415124128.59198-1-bsdhenrymartin@gmail.com>
 <20250415124128.59198-2-bsdhenrymartin@gmail.com>
 <e0db67c9-8e38-490a-98a2-13c61ef11aa5@nvidia.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <e0db67c9-8e38-490a-98a2-13c61ef11aa5@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/04/2025 16:45, Mark Bloch wrote:
> 
> 
> On 15/04/2025 15:41, Henry Martin wrote:
>> Add NULL check for mlx5_get_flow_namespace() returns in
>> mlx5_create_inner_ttc_table() and mlx5_create_ttc_table() to prevent
>> NULL pointer dereference.
>>
>> Fixes: 137f3d50ad2a ("net/mlx5: Support matching on l4_type for ttc_table")
>> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
>> ---
>>   drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
>> index eb3bd9c7f66e..e48afd620d7e 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
>> @@ -655,6 +655,11 @@ struct mlx5_ttc_table *mlx5_create_inner_ttc_table(struct mlx5_core_dev *dev,
>>   	}
>>   
>>   	ns = mlx5_get_flow_namespace(dev, params->ns_type);
>> +	if (!ns) {
>> +		kvfree(ttc);
>> +		return ERR_PTR(-EOPNOTSUPP);
>> +	}
>> +
>>   	groups = use_l4_type ? &inner_ttc_groups[TTC_GROUPS_USE_L4_TYPE] :
>>   			       &inner_ttc_groups[TTC_GROUPS_DEFAULT];
>>   
>> @@ -728,6 +733,11 @@ struct mlx5_ttc_table *mlx5_create_ttc_table(struct mlx5_core_dev *dev,
>>   	}
>>   
>>   	ns = mlx5_get_flow_namespace(dev, params->ns_type);
>> +	if (!ns) {
>> +		kvfree(ttc);
>> +		return ERR_PTR(-EOPNOTSUPP);
>> +	}
>> +
>>   	groups = use_l4_type ? &ttc_groups[TTC_GROUPS_USE_L4_TYPE] :
>>   			       &ttc_groups[TTC_GROUPS_DEFAULT];
>>   
> 
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> 
> Mark
> 

netdev maintainers,

Note that Mark is covering me while I'm on vacation (for the coming ~10 
days). Please accordingly honor his submissions and replies for mlx5 
content.

In case this mail notification is not sufficient, please let us know 
what extra action is required.

Happy Holidays,
Tariq


