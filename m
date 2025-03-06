Return-Path: <linux-rdma+bounces-8412-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06438A5479D
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 11:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C82C1893B5C
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 10:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78B91FECAD;
	Thu,  6 Mar 2025 10:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJJOykxW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F173C17B50B;
	Thu,  6 Mar 2025 10:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256569; cv=none; b=Ewsb8luMHmwaWoBr7sYfQchUJwAiy0fR06Zy/HeDTdJru7h34PF80vEH1u321lKrlNbH5Gqrh2KFCyrsjq+tylG5HIHeAKeVcEYBQxKOx8GIGHtNfPtIhRGErtTu+OSwk2x1i5v5q2usJf+j5yrnu8FDR4Vd37/+B8GtIX9waHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256569; c=relaxed/simple;
	bh=dbZ0E1GNcBxXUTODl8emioS7ET+7E9dEUdCnHzsbcNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V3dDR5nPEoMCkcgihbpWpWmKnidmD6uhCm+oICYCN63UqDQSD5wWN6deWreNJNq8Az/WRah80imk9uVDVNQtiJZIGekNQjBTdEit2QAY4GagREqGYDcRtpftcXYJ6XjdvDCMgRG5+HJr+rknfdRh0zRpNDfWua2IVsbLGHG5nJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJJOykxW; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-390e3b3d3f4so253193f8f.2;
        Thu, 06 Mar 2025 02:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741256566; x=1741861366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LhCXxA18Th0XNXZFbIzYAuAo+9GhU/EjpObfWH1V3fE=;
        b=MJJOykxWgu6+XvZTvWUYkR7/OweWB1ilUh5RqQe16fWEOCi0kjfW3CIt5vIvrqCrg3
         rZjaaQDxKIuo62GGAtrjTiBRXMDPYSlGEIpQCApluhHD0C3ItxEFn9Y2cMsiL8YazmR2
         rsgmRjP+SbAi1bYSVWjd76Kearnr0NUfqql7kNiZlM0b78zbfWlqgjo7cWW+kw0fAo/2
         8HU4cd5j5JH/mEq3RpFc9muQbjNYKigUNCqX5Zfne2BnP1QprMu3ag2Jz5agdD5Wln63
         YxfhhfZOYqPi0224vnRVKq8Os3VrjW66uFcc+izrWAbR1l2Qw+2p3UdV57FDe2iDc3sY
         bwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741256566; x=1741861366;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LhCXxA18Th0XNXZFbIzYAuAo+9GhU/EjpObfWH1V3fE=;
        b=PM4VexDuVxqpY9+pD3umRTBDgeHmgTeSlqrQ8KwVF64H4vafJKYN3Ngn9IgAp5W8WY
         QTTkc7vZJ07zO6Zbn9HH7uUSU194Qdbb055TK2etV1Ks8KUfPN8fz5nSKLb+gV4XPK3R
         hiAqrq2iBsHZHQFuCEhGTZ8bCLAFKyLwGgHW+ETI9n0ifKAZOvOGL8s7fgmW0xF1xP1G
         1W4uvfoseYecXJtB0wwoSFiegsXLducJdrvOHD3kzXsVyA3uJixXkigApCPBTo3pasGr
         rJw1t3sGcJpQfUW6YumeKweWevwoTospVweUJ+H1HrJGfjxkZugEmoiI+YjU4kCsSfKj
         Us/w==
X-Forwarded-Encrypted: i=1; AJvYcCWxir+YR6kowiZ+soqM5DXgADhOT5w+aFHsIQFgjjBw6XKp5GNP/labTgeD5swO3eB9W8rq5vA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8uMg4G9z9GiNEAWfDGEUJ8PFos5JAu/0/sZY9uRyJhD2cIMDQ
	O4cp454R+ujJrfQ1LcV+sTjuCE956LF2dgTY4/v2/bvE5J1Wz9AE
X-Gm-Gg: ASbGnctidTz4kVLCX4yWVPV0rRRmD07IvdO461ZGrMPAfSBcHAqUqrToSAG8KG20469
	Ylj2FdYE0n28wfm1ldlzSD5jOtWx+G9Vpd1CKlF989/LnDMBg4uWwX+xnzZnK5lIC31qMgIaMZj
	MH5+hqsWtg0wvCFNfd1cYbcH/IKEud0lmgaft5whO51P4V9V0GVkBc0hC3pWoHnsb6A+MhqZX9B
	Q5OorhCfBSzk9aFF1jrJHtQyQfTopXfEjElwxvUQmE0mRhwcucJa570WbZ+O1nLNfwAUU7ZI84i
	UTFcFxxN8VVXgX9D3c2dWYI8VyhdQpYxpbJR13cuqUmH0seLA6u8Zeekadyosiv9vw==
X-Google-Smtp-Source: AGHT+IF4AzrCxWiFr1WYWa2IqVH792GXytyLRn/cm2jMVGP07ilIyEVRndHgLBLnWAHQFQaBU5ZEGQ==
X-Received: by 2002:a05:6000:1845:b0:391:2e97:577a with SMTP id ffacd0b85a97d-3912e9759f6mr469442f8f.55.1741256565988;
        Thu, 06 Mar 2025 02:22:45 -0800 (PST)
Received: from [172.27.49.130] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfca1sm1550323f8f.22.2025.03.06.02.22.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 02:22:45 -0800 (PST)
Message-ID: <3452446f-602f-4756-a65d-ec02d95c767b@gmail.com>
Date: Thu, 6 Mar 2025 12:22:42 +0200
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

After a ring is created for the first time, we start exposing its stats 
forever.

So after your interface is up for the first time, you should be able to 
see the following per-ring stats with respective indices in ethtool -S.

pp_alloc_fast
pp_alloc_slow
pp_alloc_slow_high_order
pp_alloc_empty
pp_alloc_refill
pp_alloc_waive
pp_recycle_cached
pp_recycle_cache_full
pp_recycle_ring
pp_recycle_ring_full
pp_recycle_released_ref

Obviously, depending on CONFIG_PAGE_POOL_STATS.

