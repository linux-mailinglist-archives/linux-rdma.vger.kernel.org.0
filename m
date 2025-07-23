Return-Path: <linux-rdma+bounces-12408-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0863CB0E9F9
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 07:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 447BF160297
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 05:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D4D242D97;
	Wed, 23 Jul 2025 05:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JB3p/PlO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3CD13A265;
	Wed, 23 Jul 2025 05:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753247594; cv=none; b=rHebC5jRSHyJVUwBpo4mbrry4y9PGOnMJQMMGeSOG+erNhgwGo94pumrBuNFlgOwqDJ/B04T5wQOWVCsDGuSCWtfhQdIuWqesqDZJ366low4LIkKj6XZ1yyPlWPf1muIjmiHyEPCIDCtXmmqLBLeCVP73lFlqqaXycDjpkE49KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753247594; c=relaxed/simple;
	bh=BbpAI5hMND9SVUkOBsOlvkpudPTkU9pgxy330nfWcwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=crCC1QnFNGzfcza4+TlwZTzBq5g4a7BxzfzK6TgCyXnihp2YSRq7ijbzDRIh9kODa0zA0VEMCLlBlcJ6+vQuqhMolT5+b1+VUcd3hyXQANRa7UPImadV8elHf9J3M7AbwWrS+yahdXh1b/yDY5WmJmV+FnYiBxsumM8JYozYTLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JB3p/PlO; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a53359dea5so2975048f8f.0;
        Tue, 22 Jul 2025 22:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753247590; x=1753852390; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DE32jbDd/HioTLS9+9HLoYHJ9pucJMqlemZ36gAqlqE=;
        b=JB3p/PlOEKtaI+7b12lrkaAMQ7kQKPup8kIF/GSmioiG9LX5E+RL8lYpyr6pfZf0u7
         vlQqdt4y0D8rU3/zf3kKB0c27LSwlN1bDFpJwHzC72HzVESnnUcXLX1ACiZjGx5wKXna
         sB/Uf4IWlMcfB4pgKvOXwf2BeaiVVkXqTLu7JD15QuuYDc4j4dz2TXMf/9bCFddjScPE
         iFXoRWP+zkstDcOJGE5Dx2pG2giHb0i5XoYgsRixlaWmIyCclM92xbgqTUcBhVPEKwFx
         IEslLME+u3vvh1SVKSn3DaX0iHzxiiRe4Th8k+0qPrWwkPioZwt7dSO15s5lQCYebhoZ
         H36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753247590; x=1753852390;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DE32jbDd/HioTLS9+9HLoYHJ9pucJMqlemZ36gAqlqE=;
        b=PqWXE48s4OLk3CfkvhYl5yBpqgjQLMkTNKp0vS2M1OTm7Ukrbanz7/pAchBOOYJNVr
         uouzQJv61fFd6glCK0z3sotUubraF3BFD72IQi8lYUYUa9XaxY2S70wgorUbaAHR3nzp
         QYNne9epoVdk+V15Pj4Fm1902n4m7UwxRGxqJD9AvtVUqfeELL/Nbo2mAbzlcN/gQoP/
         iSkOGwA7F4i16WFWepEsDskuO3n4SkyV1/yWU1YE+quJLH64r7CXnIy5grbt5S8Eg3ak
         4vRyhMKGLr9S4s9KGf69NJY6+ylrdw0h2MCOqZ3+3IHKkMGbefFMMHZ/3anR9iDGbdqe
         9UhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVapH3YwkwCXuDEuUjNoo774CsWRBkFe2Cw7q4EOEhDfTWMbhUerd2OqW1BQnKoNDwlAnrNLKAF@vger.kernel.org, AJvYcCXGCTRiUl7LmY5iTPlrvR2VFBk6BZc1jEB5DYBQP5f+zCXSuq7QimH/GRMH3hWQmb+qtbQ2Yui2YZwd@vger.kernel.org
X-Gm-Message-State: AOJu0YzyL99T6OPefdWiHG3N2iPbDPRPMjxMX4edhWFvlNkQkJft0HgN
	lw3dA8hKXE1x35I9ok2DNipAPyR5JoO3867JxE6klOLyrsPIVMDq24ml
X-Gm-Gg: ASbGnct6VjIVqOG/EQyZwgLYPy00L/9NCZpbBthnDrbpdKtv8qkD6EVwh+YR+Rl6MAU
	VsZ/8zJVmCrf4KqDUrxJBf9SF4hUMYUQ4rmMd6yPk+h5/KGx713IJLFTTsdz4wSg1HUY6VY/ORg
	rwlqlbZBTQGqWOpvmqfLTsHb6YLdjsqpgMEoP0ODVZot6FvS77/vicAap3TO+H7IeYOQdu+95VY
	Km1LkWtkcyOVPlsZCopymrjStxW8/fQP6nvkTZ3S9/sQ9WXUwxkQxdSa9J/YU6cj1PvCZ30EpMw
	VDeMPeG3udZczz9ZPrrUKWE8oi64p3MiQGacuP0T7PLCNDIEWd+Btp/gC8FDuAiuIznbfqSPQDQ
	55VhYtarZV8KN4dSU9X2XL7gK3NEaSYj1DL8QLW2Qpfos5h66x6UUYcz5
X-Google-Smtp-Source: AGHT+IEJdmVWNNE0+UDh+k0mmesJ/bJRnK8686ssOI2JDovuehYP5oxZCBAoMPK0qP2PjTktqX9Bng==
X-Received: by 2002:a05:6000:4382:b0:3a5:2b1d:7889 with SMTP id ffacd0b85a97d-3b768f026b5mr1144918f8f.43.1753247590103;
        Tue, 22 Jul 2025 22:13:10 -0700 (PDT)
Received: from [172.27.60.70] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45869183cb2sm10424415e9.1.2025.07.22.22.13.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 22:13:09 -0700 (PDT)
Message-ID: <bd54a7d5-c0bb-4116-93eb-ea2cff8cfe32@gmail.com>
Date: Wed, 23 Jul 2025 08:13:08 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 net-next 1/1] net/mlx5: Fix build -Wframe-larger-than
 warnings
To: Zhu Yanjun <yanjun.zhu@linux.dev>, saeedm@nvidia.com, leon@kernel.org,
 tariqt@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: Junxian Huang <huangjunxian6@hisilicon.com>
References: <20250722212023.244296-1-yanjun.zhu@linux.dev>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250722212023.244296-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 23/07/2025 0:20, Zhu Yanjun wrote:
> When building, the following warnings will appear.
> "
> pci_irq.c: In function ‘mlx5_ctrl_irq_request’:
> pci_irq.c:494:1: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> pci_irq.c: In function ‘mlx5_irq_request_vector’:
> pci_irq.c:561:1: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> eq.c: In function ‘comp_irq_request_sf’:
> eq.c:897:1: warning: the frame size of 1080 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> irq_affinity.c: In function ‘irq_pool_request_irq’:
> irq_affinity.c:74:1: warning: the frame size of 1048 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> "
> 
> These warnings indicate that the stack frame size exceeds 1024 bytes in
> these functions.
> 
> To resolve this, instead of allocating large memory buffers on the stack,
> it is better to use kvzalloc to allocate memory dynamically on the heap.
> This approach reduces stack usage and eliminates these frame size warnings.
> 
> Acked-by: Junxian Huang <huangjunxian6@hisilicon.com>
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
> v3 -> v4: Relocate the kvzalloc call to a more appropriate place following Tariq's advice.
> v2 -> v3: No changes, just send out target net-next;
> v1 -> v2: Add kvfree to error handler;
> 
> 1. This commit only build tests;
> 2. All the changes are on configuration path, will not make difference
> on the performance;
> 3. This commit is just to fix build warnings, not error or bug fixes. So
> not Fixes tag.
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/eq.c  | 22 ++++++----
>   .../mellanox/mlx5/core/irq_affinity.c         | 19 +++++++--
>   .../net/ethernet/mellanox/mlx5/core/pci_irq.c | 40 +++++++++++++------
>   3 files changed, 58 insertions(+), 23 deletions(-)
> 

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Thanks for your patch.

