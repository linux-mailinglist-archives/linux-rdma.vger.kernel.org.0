Return-Path: <linux-rdma+bounces-8416-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB59A548CE
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 12:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F92A1894DDD
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 11:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25104209F4B;
	Thu,  6 Mar 2025 11:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPxHp4gw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38224209F46;
	Thu,  6 Mar 2025 11:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741259419; cv=none; b=Tfm4r5R/qFcB4iptHvKDDCyFKibsdtqmlYqg7sHmVmq32iTpRyGVBwo1GYK3T9hizzJsqYtr9bAeRFMoXJvNk9/EDqx40prY0wZB7Aivx8vMjktdj96Yuou9W5gFo4KhCgBGMEsTWWzrxFV9LFDAaDQHA3oCUG+EZEGjsjcJbns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741259419; c=relaxed/simple;
	bh=RygwUEhNHPlhbE0HafZjFRQTBG7+a2BwUJgc4oU19CE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h4KmnIKtOOpmOS7zTftqsCi+QLFSV1WjJ6JRK8OgVuaV/dE6eB/nDVy8hHVgE3pX3t50tZ6/hjfz86VlNBqRY52b2q/kdokbfphcpxNwRHTl/wOCtkiD5WxjWYItTjkh12taoj115Q4sY3EvDwutkRdiUZEHhCoNsEeRJaqzkE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPxHp4gw; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-438a39e659cso2739285e9.2;
        Thu, 06 Mar 2025 03:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741259416; x=1741864216; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nEdW2uFJfd1t87imdFoq2TwacwEguGV2HfO/MLrDxwo=;
        b=OPxHp4gwLydO6Jl/ILvbjmxV9JV2rsiSXQUeAI7O29tCMVJ7pbx0TUGX2HlMPi2+OS
         Th9cmuWk8JRS6Z6f7S2zAjqys0KhWCYfl8yEgZFrwb+sNXlJZHGc/nfqINRYM/Wr9BTl
         g5vUyQnpCE5ynVFEfnSHDY11uTl2mmKC4U66z3+lm2yeoXgCNG7zqChQnDAkIKaVcExd
         F+y4KBsiXEIChwy72fSZRN5QlMl0yKfFAfJZkO+odXNzNknH1m5lMZddLvp/1uk51Jmo
         VqabrEqcwqu09BEaukwbKqHz345M0+SzoSZI3aBXFlesm08tLZH5+rt0cfm/aX1Elyfm
         f3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741259416; x=1741864216;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nEdW2uFJfd1t87imdFoq2TwacwEguGV2HfO/MLrDxwo=;
        b=rEJThZSCztEun63rKVweT0GYTpatX6nPocHvIDavxSXyVKw1SJdtaSlxfe5WusyZpz
         74Y5U9E3OQNeT1+I4jWZtkLBqR/wa7VkXx0++lgUzq9OTX7KqiLzpeAJ/Kat1awu+zIM
         ZadNTrwNdaPzKvi/X3WGG/mI4LbeazgmTUezW7DBAvHVYpyX9X2WtnlSOgwYVbUF5rEu
         vp/e23CmuZqkNHKgGImr6jm0AVhoMBzpkxV7YWQ8vR0ut9PxRwJ3F68rKTdHFRIQISJz
         wUDxLOI+X8MZXLXnUAXP8Y35/4y9MAcB3OwHLDKmlqfp/UgfSKnzGsf5YFscNXtJC063
         SPgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEWd/xEzLyaDeExe+qmi+lPH3+a9eceMKuTNwn5jY3cpBHOQFtaWyRcuMI87zRv5ZvkHU6NvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMOYVoGZURQgec9xcvWjpY0yCt3prKIUP8Emh+IYKaeC8xwYYV
	+UZ+L975eNWQgFnLwrU7d7Q2HIH/G6aSfkvzDeoPigQYn0FDmkCj
X-Gm-Gg: ASbGncv2Z8xUb/+9CwRm91S6md9kH6q+mYRtXLZQECYKgzwOug1Af/kCXUgHxmf6/0H
	35uZIc9eAo9Gb7dzx24Mv5iTH8jwoFtgFMDBxQz5aFLYNV5x2rAV/2kohrKbAju/ZEycv8YP7bF
	ZRUZ//S34eCUJ90OjJJr9YS5xlv6EsT8zDglz/59v6rNzQfIki3rN7qdoPH8SN2pRnBII01R6zT
	3jV1Y1NHQ8D+oE9grxEJNqsg8kGR1Tpw4w/EnkxMGzB080go8UdcdgJooU9PmPGHcPE2ioCleQD
	16YD8mgBuYbVrgKPfTqyUl7P2Wm7boroYKmO+XwpDVkHkKeONULCs968HyJpe8coZA==
X-Google-Smtp-Source: AGHT+IGCqiSCYTgS6FIPyvY4yHmJsNicW2x5TXtVbejyezmMi57ab0VsOnOOk5Mh5lvpsHJdDP76LA==
X-Received: by 2002:a05:600c:4747:b0:43b:caac:595d with SMTP id 5b1f17b1804b1-43bd29b3c72mr47827515e9.23.1741259415880;
        Thu, 06 Mar 2025 03:10:15 -0800 (PST)
Received: from [172.27.49.130] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8b04bbsm16693745e9.2.2025.03.06.03.10.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 03:10:15 -0800 (PST)
Message-ID: <59987f5c-daa1-4063-9781-ac50f7eabb6c@gmail.com>
Date: Thu, 6 Mar 2025 13:10:12 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlnx5: Use generic code for page_pool
 statistics.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Joe Damato <jdamato@fastly.com>,
 Leon Romanovsky <leon@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>,
 Tariq Toukan <tariqt@nvidia.com>
References: <20250305121420.kFO617zQ@linutronix.de>
 <8168a8ee-ad2f-46c5-b48e-488a23243b3d@gmail.com>
 <20250305202055.MHFrfQRO@linutronix.de>
 <20250306083258.0pqISYSF@linutronix.de>
 <042d8459-e5be-4935-a688-9fe18b16afa1@gmail.com>
 <20250306095639.HpT1e8jH@linutronix.de>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250306095639.HpT1e8jH@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/03/2025 11:56, Sebastian Andrzej Siewior wrote:
> On 2025-03-06 11:50:27 [+0200], Tariq Toukan wrote:
>> On 06/03/2025 10:32, Sebastian Andrzej Siewior wrote:
>>> Could I keep it as-is for now with the removal of the counter from the
>>> RQ since we don't have the per-queue/ ring API for it now?
>>
>> I'm fine with transition to generic APIs, as long as we get no regression.
>> We must keep the per-ring counters exposed.
> 
> I don't see a regression.
> Could you please show me how per-ring counters for page_pool_stats are
> exposed at the moment? Maybe I am missing something important.
> 

What do you see in your ethtool -S?

In code, you can check this function:

drivers/net/ethernet/mellanox/mlx5/core/en_stats.c ::
static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(channels)



