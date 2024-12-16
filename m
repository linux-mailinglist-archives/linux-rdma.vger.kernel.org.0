Return-Path: <linux-rdma+bounces-6540-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4589F30E6
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Dec 2024 13:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789EE1885DEC
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Dec 2024 12:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38392204F87;
	Mon, 16 Dec 2024 12:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAc9WZMy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D99204C2C;
	Mon, 16 Dec 2024 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734353448; cv=none; b=dn4AC+QG/ewjdodGMWkDMwrHrPRjoaLwmhwkK5msTFU+Ug1wiRtSlM01bRWJXJgr1juXHe9ndDOqQom0iY66pn0EdtpX9UVmuogsUKQL9hHxhZWMedEm2ZzPNvKsrFlyy2EPf3uhcWRvIfYljRr2nr8Hcog9JLYXOVI/nR5pkcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734353448; c=relaxed/simple;
	bh=FP1RQUFT30Y48osYV5GpsXLGPmcKPbZTf0DgsnftIkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=taZCizLmCC0uhFCksT95cgLxJA+ZTQ147I+sw2AIMidQqsdBNf7rpQ93bMHGheBmBQECZykjopZZ2FCOxZd2pH9tN8VQGh1m0E8f4sX5xWlz7MC/pzSFvpIrheK4oOCaMDQXj7qSjfKkd/pHiMrU+HJdEVjn0vrcEoC3aCG9nMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAc9WZMy; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-436341f575fso26359195e9.1;
        Mon, 16 Dec 2024 04:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734353445; x=1734958245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D78KVqFVG0ACpGF7l0OwybNIa2oNhxCk6SeYnQ/G6Jk=;
        b=YAc9WZMycW8NvT7750k7O4NhUk+AtKohhJK3QctusTAuxIgP/m6bpLDT4G2D6d52QF
         4VZo4LovEadQMB0zs9szrlYMN62o7/xOmvwGAX4qluMVo4GTVdebcvaE8Ec8E2uk6tJ2
         68jgMxL9P2Ugu7vsfY8/sGgx+0h+MuGVGF1KONQZnnj48KbcsG9IN3CbnhtqWyvIT5tl
         geIYxn5rxT6awJ1KwgCpj3fHo6RUWlxsXGchJFTiMZcBp1T3ZkuwwEC37RqZlqn0i1Op
         ZsQ7rO0O2576ulOfHrdcn1A2il6rOBT1vG8/FdI84RBd1xwfOIsOXuNTHJw5/dPqqmAY
         1QdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734353445; x=1734958245;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D78KVqFVG0ACpGF7l0OwybNIa2oNhxCk6SeYnQ/G6Jk=;
        b=DBF+McKfKci+o/VvwIkQAA7YzACrFv3qyu4/+N8TYVS694FIcRPO09yHH0jzta2k8l
         fxw0+yNAGjunzVFR7DHTRLqI1VqbdIV6wvJa5bTU/YohuUbQMmr3BPImDBcOkxo2WIGM
         Fd5+MKweCL85EkoO1rB8MfKJIrQbJeRVoBS8x+QFof5pftt8jLmkoi92qRlp2OxX0eVL
         /GnJgbtYmjTtW/QZ8+Q9443A+zhcj6SyE0DYAk1UTFoVg/VlExBKpQzu5gcmE+RYwpac
         D8KkIiXNgl1OH60Nbza1pGPW1fjpdvDZp2jY6S7t01Bn8IxktxA00KLpg2rAIydr/qN/
         c8RA==
X-Forwarded-Encrypted: i=1; AJvYcCUayaJdjMvjv9iKPrAJujR6QB2mO0dgkv/EVSqEU/Nmbn9E4MmuVF/8x73MmDn+SKc7nPJ4Zis/zPNg@vger.kernel.org, AJvYcCUbtSGwaG8c3isBtx8wZBFzmfRHjnWzdBvXWB+4yGsk4cQDLadJ25Mluir1lKxk8aP278MbTpQx@vger.kernel.org
X-Gm-Message-State: AOJu0YzUWiSlyXQSBQ6SFFLALsVkFn4t4v+RkI8Kll/DGZ81SFlUtWwH
	vDbhHC8CiZUv1nMgXE9KsWrEU1w/QYQ+ZDVvfF9ten6K92nD7jUg
X-Gm-Gg: ASbGnctfqzr8pZjGVN5e1coofS2jtiJ5+MjGs9tTb1TBz6/YF3lpayiRG/k1ycvEXzf
	zzHVV+/QIckBGaqHZJ5QHWYcWr0xH0t5OMBDzW0rFhcON3zgbVGAkbdBzLarmEPa499vzgTrWYw
	81xz2bfsborI+7GNFnrThndlozFkTq5LbLUHBFgtbualZ8KEuH7Svke76/7r/fWOAO4Vzdax0MG
	aVRy9DqqPX5J63pTNCj0JWXICMp3d1mee2sJyYEzVyYh+EylM2mehWOSZhgBpc8K7KyowZuMTw3
X-Google-Smtp-Source: AGHT+IHMkIcQSUB9r1JV3AbEYokMEYxGraelxBDikdrMFLIvQqJViL1l2t6dQEOAQiwKVNzl7WLOyQ==
X-Received: by 2002:a05:600c:1c07:b0:434:f131:1e71 with SMTP id 5b1f17b1804b1-4362aa36366mr102865405e9.8.1734353444118;
        Mon, 16 Dec 2024 04:50:44 -0800 (PST)
Received: from [10.158.37.53] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362557c57dsm138466865e9.12.2024.12.16.04.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 04:50:43 -0800 (PST)
Message-ID: <08e9146a-7970-40fc-9eee-158bdb4b1938@gmail.com>
Date: Mon, 16 Dec 2024 14:50:41 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/12] net/mlx5: DR, add support for ConnectX-8
 steering
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Leon Romanovsky <leonro@nvidia.com>, netdev@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 linux-rdma@vger.kernel.org, Itamar Gozlan <igozlan@nvidia.com>,
 Yevgeny Kliteynik <kliteyn@nvidia.com>
References: <20241211134223.389616-1-tariqt@nvidia.com>
 <20241211134223.389616-11-tariqt@nvidia.com>
 <20241212173113.GF73795@kernel.org>
 <5b6c8feb-c779-428a-bcca-2febdae5bb0f@gmail.com>
 <20241212171134.52017f1e@kernel.org>
 <1e8c075c-2fd0-4d10-887d-04a5fb15baa2@gmail.com>
 <20241215131218.3d040ad8@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20241215131218.3d040ad8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/12/2024 23:12, Jakub Kicinski wrote:
> On Sun, 15 Dec 2024 08:25:44 +0200 Tariq Toukan wrote:
>>> What do you expect we'll do with this series?
>>>
>>> If you expect it to be set to Awaiting Upstream - could you make sure
>>> that the cover letter has "mlx5-next" in the subject? That will makes
>>> it easier to automate in patchwork.
>>
>> The relevant patches have mlx5-next in their topic.
>> Should the cover letter as well?
>> What about other non-IFC patches, keep them with net-next?
>>
>>> If you expect the series to be applied / merged - LMK, I can try
>>> to explain why that's impossible..
>>
>> The motivation is to avoid potential conflicts with rdma trees.
>> AFAIK this is the agreed practice and is being followed for some time...
>>
>> If not, what's the suggested procedure then?
>> How do you suggest getting these IFC changes to both net and rdma trees?
> 
> You can post just the mlx5-next patches (preferably) or the combined
> set (with mlx5-next in the cover letter tag). Wait a day or two (normal
> review period, like netdev maintainers would when applying to
> net-next). Apply the mlx5-next patches to mlx5-next. Send us a pull
> request with just the mlx5-next stuff.
> 

Done.

> Post the net-next patches which depend on mlx5-next interface changes.
> 
> We can count this as the posting, so feel free to apply patch 1 to
> mlx5-next and send the PR.

Done.

Let me know of any issue.
Thanks for your help.


