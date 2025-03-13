Return-Path: <linux-rdma+bounces-8640-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C01EA5ED9E
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 09:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615B3189DE4B
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 08:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DD225FA31;
	Thu, 13 Mar 2025 08:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oy9Ydscb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD9F1FBE89;
	Thu, 13 Mar 2025 08:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741853240; cv=none; b=bSwIm2MO92l9r84DNFU/5kqaKksxcj6iFppdq+l88k0QI+xtZfecR0Gh2J1RGrl+4/BqhgZOxx1Fnu5iZqsmaIpocR0xu/ChUrz1gpA/StiJnmn4GYST0Lmk+BRDhV7sAUWKw9r7rgYNL10qg2KOpD2xQ75p/6RfkFRDMmMcgjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741853240; c=relaxed/simple;
	bh=AnQdXNSMT7o7yQZ2TjQSBLykcghF2OWM1Qj32bi/UQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JD31pfPDBmtgN2h0Xq5sBhWAC3nUnH9WC8NnMvirIafIFgFLAKQOYf+CZaNf2LnivxtQxYZYjWJfkpuEJ2uoI5V4iFkMQ2gePNdyjgd7E1Es1OwIK5WsFFU36F6jm6jokUR02/gH6TIPnE7S4PYX9c5ID93YWuSWH55nYmL+3A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oy9Ydscb; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac29af3382dso111815966b.2;
        Thu, 13 Mar 2025 01:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741853235; x=1742458035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a0fTcyiiClZN7GKZcM5x5s8tHses1BA754IzjfcZUfw=;
        b=Oy9YdscbkgKtxLbYEZD0m8PX59cnoeGET4B1UT0rlRq5bgP8OvRhiiJJGeTVxZg2Vr
         XjPxrvVCuCFtjPp03BV+VA7tbrJ+CxU7lQ5zJO0d0JR+FDWviNKQYNUq5oWfS2DyJBf9
         oM9r0FzyemrkjnMbaejNy7lvFxDbsKYhmmEvDUYa5ZdqrPTw6jeI3OeH4WblCLEOBeCq
         ZFTvLKOb9JbbQ1czCu0Ru5xExbp+9NbJbC+haFtsbB477LYKPT/jT2rDVQEDwj1wA7Gk
         TUI8fqGr0TuTj/O7hzws2lgpYY9CJA/pb00sntHPM+huxd7qXKN23tSdrdJRaoHXgd/v
         RAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741853235; x=1742458035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a0fTcyiiClZN7GKZcM5x5s8tHses1BA754IzjfcZUfw=;
        b=gFAiqwEwe1BzWJB7D4dcKxt2Dyrd6qfggQMLlsK+TJnxD9ojB5Dc18xFsgeZkVSRpH
         LK25/kRYD0Cd4ZDP/jNPl/bim8TlBZutFhlqjLNOXVl0mS5qTSmSdxl0s60qTU4IjaqY
         5PngrPzWR0A7CjozQPSdbobWR+9GlgSWqlCBefjawuW7DCaiatM2N8espMGsiaGLJtr6
         1spZkGFQo61LqW4Og4KZrHm8fG+UdosWshT9B7kpzRabNCJpaD9QTuWQyYLOQvfMel7x
         Aa0UZ8D3CheuFLmeV3TUMa2Z4ChNtMyZSbtxGfyLWBCIgN7bQewhhnygnVFgt3pRY/7C
         8ltQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjg4tbWco+oqmLipuaQQWUIl/90lU3kaYzybRbp8T4uIYr7+oWC+isCUinhcltT3CWoCzwfskbPLiGGlA=@vger.kernel.org, AJvYcCW/ckbtovTwxO9DceIW7lBtbDNXy3hL3tjCN3hHdO80NYvw9hS6kG5yLv7p89xLmNewnFjVhtpQ@vger.kernel.org, AJvYcCXL1jqolIdngZ0BGATUA85p2uIoYlguinSxRM9F1D5PldfGJvFZwZGzHGyKLZUMXwOBGsG+suZ+GSmnkw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0J19yl6FRoxCrk/uthAqmESIzv6XowQ3HfsO6+6OUMd7YZL7N
	as2PcKA82P9MiBgjMun3j9FDJCnlVDE5ByCLtIJY1Hz3nMGVbaIg03CmzA==
X-Gm-Gg: ASbGncsxeMfvphJ+nEZgVeIjS5p6YaeBCVZIMnDFVcdUsCldYJcGs6TeLeiM38282dY
	yzngiiW4m7c5nMQTJU+VHip9bUr3zLuR6E/eNMTelsPZFZ49hwlGF/w55xpErYMwVFgsFzZFBWc
	f3zxrPmM825VZCNUZMMwv5TFoHcA5S7M0qmStwspddWzFAn0YOSJhf06KifBCGjXLjYLZRWWcUj
	zDLUdA/LtHpKDZQw6Jqud33wg/imdThC9LtnCir6VkbEuTJUHOv8Lo2nSNo65zEBqA1CCYS2C2v
	FxMKIfyeYbfbP3KdBUI1P9Rijs10SttQTZhJJI/cJDw/z8aeHlKXQ5m3EAlRT4X9Fg==
X-Google-Smtp-Source: AGHT+IHfoEtyTJ+DcJm71sMd6fkWRqhkLPldXyAkyawyzTHA/K58PyuAovR5fwdqPSDWFgqqccSneg==
X-Received: by 2002:a17:907:34d5:b0:ac2:cdcb:6a85 with SMTP id a640c23a62f3a-ac2cdcb7301mr749578266b.22.1741853234675;
        Thu, 13 Mar 2025 01:07:14 -0700 (PDT)
Received: from [172.27.56.126] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147e7f11sm50762766b.42.2025.03.13.01.07.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 01:07:14 -0700 (PDT)
Message-ID: <f30ee793-6538-4ec8-b90d-90e7513a5b3c@gmail.com>
Date: Thu, 13 Mar 2025 10:07:09 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [pull-request] mlx5-next updates 2025-03-10
To: Jakub Kicinski <kuba@kernel.org>
Cc: patchwork-bot+netdevbpf@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 leon@kernel.org, saeedm@nvidia.com, gal@nvidia.com, mbloch@nvidia.com,
 moshe@nvidia.com, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, leonro@nvidia.com, ychemla@nvidia.com,
 Tariq Toukan <tariqt@nvidia.com>
References: <1741608293-41436-1-git-send-email-tariqt@nvidia.com>
 <174168972325.3890771.16087738431627229920.git-patchwork-notify@kernel.org>
 <9960fce1-991e-4aa3-b2a9-b3b212a03631@gmail.com>
 <20250312212942.56d778e7@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250312212942.56d778e7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/03/2025 22:29, Jakub Kicinski wrote:
> On Tue, 11 Mar 2025 22:50:24 +0200 Tariq Toukan wrote:
>>> This pull request was applied to bpf/bpf-next.git (net)
>>
>> Seems to be mistakenly applied to bpf-next instead of net-next.
> 
> The bot gets confused. You should probably throw the date into the tag
> to make its job a little easier.

It did not pull the intended patch in this PR:
f550694e88b7 net/mlx5: Add IFC bits for PPCNT recovery counters group

Anything wrong with the PR itself?
Or it is bot issue?

> In any case, the tag pulls 6 commits
> for me now.. (I may have missed repost, I'm quite behind on the ML
> traffic)

How do we get the patch pulled?
It's necessary for my next feature in queue...

