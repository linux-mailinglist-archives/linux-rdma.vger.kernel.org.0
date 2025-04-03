Return-Path: <linux-rdma+bounces-9144-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 298CAA7A978
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Apr 2025 20:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7F2189976B
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Apr 2025 18:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23657151992;
	Thu,  3 Apr 2025 18:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRXVjO2b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310FE24CEE8;
	Thu,  3 Apr 2025 18:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743705141; cv=none; b=iwQZCuQR/ndOqh6MAB7xyAz0LPj9yJysCaN7p188jz1Zh98CFACaYTlRIVUH3JM2fdPbCfzNuqhkPTIgS145WPBOTjZ+nL319KrJzLXHo5rYkT+i9tjzWHsuyI04YVb3ktjuDL5SoSLRpzFoJlWBi21vEBgQ6cqCrFus5raiYng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743705141; c=relaxed/simple;
	bh=oYSOgbE2T0F5zKIQaRgihuLpcmjBkxqOSl5cApaGi38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AzT3dmlSQ37MDl3vKi+8ekt+HV0N80Q/JYhR2+I8Ma6/5/NXuLj5K3BrTLJieTGTKzM28NxjhlGFcaj4ezQm6wHCW0tx8NLv+Q3JCxAIdM+cVyeqqDcr0PaannFGkzMTK0pgut0rH1hL9snykntziKs1oKAekVNX0HEMG2GHyG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRXVjO2b; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cf680d351so13490135e9.0;
        Thu, 03 Apr 2025 11:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743705138; x=1744309938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W+2VbAG4hh+12ycsguwdRu57K4kt6OAXOvTs23LZ8oU=;
        b=ZRXVjO2b5CahGR05P/I+tUp1UeNjnx8JqL9NAgQw3IJ/IYgp8xiz89MQHd/c0+PeH4
         XlhadJygUNjzyqhf1fPtfnR9Izd4vVAiFrhxm+wJ0Wucyzlxz5MFrJwN1usfGZIdFCUi
         22iWDfuu9aiyOoZh2EYWugMULaf1m9KafnRViPbs6DtWmwkREbDLCjCRkDd9fz7L5mHO
         5LEfVImCC2zUCWubwITo7sOou3YMv6cKkVR6mXuCH7C4MHvjPOX6raXjqVk7O3PR41ts
         qMhTtEAjI7WFT228HjL0LqejdldfO8SduyNFwLsB0x12UWQuLOfhdGaimqX63APPRVoZ
         xM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743705138; x=1744309938;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W+2VbAG4hh+12ycsguwdRu57K4kt6OAXOvTs23LZ8oU=;
        b=FsgBmx34xAaZEL0jVHG9V3mh40r9ysa8t5W9zzyQ3ImC/pohgZozjN0/xMv6XzpHfK
         MSTfzVpOkXgyW9altj0qBhwmSmk9nNl9R+qbnTNSRcnqQdfoFEgH2imxCaQ/tbLZptQu
         uad+TeyBPE7PM8trncJBMrcbP4ahZdpVsSOMHQpX0xkA9kiOU+xMoeEsjRPjjYcK5B1p
         /VEId4t69iNYYsEhzCYCcQimA+8HK5LjU0UrYJjMVH1ROr52bbMeeV/mdO0lotiEGhC+
         PwaRZeVcnWBOi8Iw/hxaWttgeWN05mKKZOpeb/3jCto7HwR7CEg2dXIUTfgd3yZmYjHH
         mqYA==
X-Forwarded-Encrypted: i=1; AJvYcCVgd7/cLzDr5jr/cYvAurkc4tDwiuX+zgEqGJ9kq0pX8QkIB1S0y0PHQfS5AnJy7gyp7/mk2ypTwDxWEYQ=@vger.kernel.org, AJvYcCWBI+p2Wl9ZWvFjx1wDeZye8CFMEhdIQi8twdSF/+KmsNnFRZDvPhunDb46Y7t/LMN3T0QKYkFBG0IHlg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGagDPq3f7cO39fKFpUIxkf3RSQro1Fs1DEEhNP4d03JdZ45HX
	yI/hCCyKotgU3Ef4mDY1cxfO/SKay8TFpZLhPk9cviXiwcGvn5iC
X-Gm-Gg: ASbGnctZ4Xw1O94L6Gs0JVXv4DyTduc491aExQXfyn8ZxiGTGSRIH4i/dsdg8bdcEFb
	ISec7/LKaD+ei7Xf2RejUAF2OaGO3m1WsBCWrcodWLjtLxRQ3HvF90iZbZRpf+zFWEWcsl0wp4w
	ZKUe42hFxGTKdMOvCaeHSJbScvNfKqFyJOj0YB07yHUbqxxTgbkGfgK3b+7UpEZPiKN8lPJq79Q
	H0FckV3hPsbINZvc/s+BXBra5uIPCZdwcBmTnNYdZZBpbgCG4nXz2ZelfAwXUBY0kJY4REjOW9z
	FVpd7RfvziYKlbZL4NOXPmwh7+UrPKN1QtbN2IyAGz/WuZ4zTRHH5oh0wMVK8wF9pQ==
X-Google-Smtp-Source: AGHT+IGgiRqgZDKhOZADM7Mh+G25jDg+2rg96YfC4/Oqm9d/ZkZEjtND1wzeIXtq4qMNKHz/8JM21A==
X-Received: by 2002:a5d:64e7:0:b0:38d:e0a9:7e5e with SMTP id ffacd0b85a97d-39c2e5f4fe8mr4307153f8f.6.1743705138211;
        Thu, 03 Apr 2025 11:32:18 -0700 (PDT)
Received: from [172.27.62.155] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec366b571sm25367675e9.40.2025.04.03.11.32.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 11:32:17 -0700 (PDT)
Message-ID: <d78fa6dc-5820-46b6-9b7d-0986f9a70da2@gmail.com>
Date: Thu, 3 Apr 2025 21:32:14 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix potential null dereference when enable
 shared FDB
To: =?UTF-8?B?Q2hhcmxlcyBIYW4o6Z+p5pil6LaFKQ==?= <hanchunchao@inspur.com>,
 "przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "saeedm@nvidia.com" <saeedm@nvidia.com>, "leon@kernel.org"
 <leon@kernel.org>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "markzhang@nvidia.com" <markzhang@nvidia.com>,
 "mbloch@nvidia.com" <mbloch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
References: <526e6240c8964fefa80b4bc759c44c04@inspur.com>
 <a23ccc3b-bb4d-4352-bd7e-ab0f3ef82585@gmail.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <a23ccc3b-bb4d-4352-bd7e-ab0f3ef82585@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 03/04/2025 17:03, Tariq Toukan wrote:
> 
> 
> On 03/04/2025 12:52, Charles Han(韩春超) wrote:
>> -ENXIO indicates "No such device or address". I've found that in mlx5/ 
>> core, if mlx5_get_flow_namespace() returns null, it basically returns 
>> -EOPNOTSUPP.
>>
> 
> Please do not top-post.
> 
> +1.
> If namespace is not found it's due to lack of support.
> 
> 
>> -----邮件原件-----
>> 发件人: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> 发送时间: 2025年4月2日 19:02
>> 收件人: Charles Han(韩春超) <hanchunchao@inspur.com>
>> 抄送: netdev@vger.kernel.org; linux-rdma@vger.kernel.org; linux- 
>> kernel@vger.kernel.org; saeedm@nvidia.com; leon@kernel.org; 
>> tariqt@nvidia.com; andrew+netdev@lunn.ch; davem@davemloft.net; 
>> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; 
>> markzhang@nvidia.com; mbloch@nvidia.com
>> 主题: Re: [PATCH] net/mlx5: fix potential null dereference when enable 
>> shared FDB
>>
>> On 4/2/25 11:43, Charles Han wrote:
>>> mlx5_get_flow_namespace() may return a NULL pointer, dereferencing it
>>> without NULL check may lead to NULL dereference.
>>> Add a NULL check for ns.
>>>
>>> Fixes: db202995f503 ("net/mlx5: E-Switch, add logic to enable shared
>>> FDB")
>>> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> 
> Acked-by: Tariq Toukan <tariqt@nvidia.com>
> 

Re-visiting this...
See comment below.

>>> ---
>>>    .../net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 10 ++++++ 
>>> ++++
>>>    drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c       |  5 +++++
>>>    2 files changed, 15 insertions(+)
>>>
>>> diff --git
>>> a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
>>> b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
>>> index a6a8eea5980c..dc58e4c2d786 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
>>> @@ -2667,6 +2667,11 @@ static int esw_set_slave_root_fdb(struct 
>>> mlx5_core_dev *master,
>>>        if (master) {
>>>            ns = mlx5_get_flow_namespace(master,
>>>                             MLX5_FLOW_NAMESPACE_FDB);
>>> +        if (!ns) {
>>> +            mlx5_core_warn(master, "Failed to get flow namespace\n");

Use esw_warn(), for all new instances.


