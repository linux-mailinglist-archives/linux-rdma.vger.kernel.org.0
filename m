Return-Path: <linux-rdma+bounces-8410-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF56A546EA
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 10:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 195327A9A76
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 09:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F052F209F51;
	Thu,  6 Mar 2025 09:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhIo5Q6I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B90D20AF85;
	Thu,  6 Mar 2025 09:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741254634; cv=none; b=A1GsCvOG9P5sOkastcneOwAL6e7O4suroh55Bx2fVXFJKnImRMq4nFUikTmgucGEmwVKyC07Mt1Bl9to6rhsqrwb0vBI28pVfZYway3tA7LdGbDdCIzVkKstEgmQ/Tk65Ut2VI7vl8QIf8hCvWlWw+y2S3kqJlmpDNABs53cvGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741254634; c=relaxed/simple;
	bh=eIpesmObrZ0L4HIdewr2PrvroaN5yY0jVZ2nNpCzc+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ea8TqUFb42ueOA1+wsdCQtdI40wOWozRS4YUXY+urkOPkSpxtqOLfxVDxsakC7LgKeBwtwy1108QeTNsUZhwQVFtvAeVlPV4yi+E6vqnuM2LMeulxxknriuX0hI1ERxA4gkRE3QRFszkl1JUbhzo4ckwAYVgW3szK6lZxsn5Odo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhIo5Q6I; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43bdc607c3fso2534075e9.3;
        Thu, 06 Mar 2025 01:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741254631; x=1741859431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o8tyc0jAmpZLCohvENRUoCJi064Uu0mWojXRk7xpusM=;
        b=RhIo5Q6ITVMce4ojujPE+2J/cbGV8Qcq2jMAD6RZU5E/9N3+R7OxyOq24SMIxBbIYL
         PNaCBu0kEtU1GvRbC5dZIYNbYc6vb7fOTyvBdk58jhsEwq3HsEbkNK3H/kjAcRoBjgH9
         89ZctKn1v7WMEeU6NGZnu8N5t6u7yt7kBgsRA1er7P/CvkvGgoLHggS2YfFdf951lfFF
         IcIExdCdAyhvnhv+3vcmWHr6IrHGh9bt+8RihAii9eVraJqKVOzizbNSBUKoEPvjStn5
         0gTFHpofnYusiOSc1Da0TymiWytK8vEEnOVB3vh3JoSBO1L4KC4uB/hvhTO/ij5V4gPt
         2u1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741254631; x=1741859431;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o8tyc0jAmpZLCohvENRUoCJi064Uu0mWojXRk7xpusM=;
        b=qx4uOp8tfZ7xTKKX0bjZnPJIxdU8Cs8Z6v1wWTQuoh/gCXDeQtgpOfox+go4qGKRSw
         7cinhZUyTGuzm15cL9IotMkBVu3S8bsZkvFQVFQ16ZksmprZ36+bVWZ5EizqpMAlFj3g
         Lq1A/ZP3YVMsnWbaXhO4sWVwKJ1rLeVEuWr6MDOCfIUCbfys1Kss65qEU9cw7VUyivdc
         TUl+PTlphhk8tcb9C/fncYidQVwI6o92qt/veUf+R4F+gx5Eou85YiEZYm2qxsWRi3gm
         wXQICHvgwHVtWjblamVFfgARomVDs6d8+p3Ra6+HZgghC42d4lnTdhm9/eOPErG/yMfZ
         2a6w==
X-Forwarded-Encrypted: i=1; AJvYcCWhSh479IVt5XppfqlvzxlBtVVhUBN8toOpS47a5Hkgu17iUjfFErSPd9T1BAd5rMa4cFfbUr8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yziox9Igqe2AICvRwenogK7Dtd1G4p9nT01bKtTgJiH3ezICT92
	UzgFFLggiuJxP3xR5O3qdlP2ZAxD2bUhIQsuION1sS2pNC5++YsJZg+LlA==
X-Gm-Gg: ASbGncvPnakgZ2dZsTx48Pk/8mM4FNk4L90DVr+KmFVHu0i63P2n3w2aRBuCZBCzbti
	jKjmKXSFYMv9Jn4fcMV0Ze4zsR/n7ahtbh0O7eciqh5mSUWkWm5Y9JD4ICXQZl9gFvw6nx0qoU9
	TCF5MdJTKnen685T9sSEdbScYqrFAD3YpoenDOFIwIo17xJg0pNMoW39uu/hswyla93Uh0HtdS9
	L1N0oiQ4bD0vKfiWz7loyU53HbLWyDpboIubAcb6Y2AfmVDL1wvaL2s/u8U4qDvraNKOImhO1Ep
	3qpo/gwwHXRoyCEXIC4t2fug1Ms/ewZr+vFiIwO0dveMqOiSp0pic4z90UWL5+nTrQ==
X-Google-Smtp-Source: AGHT+IFFTFJxFegJEwOJDqt5Eo5oe21FvRGic1Equ7xNcRSZs55qJ9m4YxxswohlDS19Js2nxDIkNQ==
X-Received: by 2002:a05:6000:2b0a:b0:391:5f:fa30 with SMTP id ffacd0b85a97d-3911f7700d4mr3720866f8f.28.1741254630808;
        Thu, 06 Mar 2025 01:50:30 -0800 (PST)
Received: from [172.27.49.130] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c1031fdsm1452341f8f.89.2025.03.06.01.50.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 01:50:30 -0800 (PST)
Message-ID: <042d8459-e5be-4935-a688-9fe18b16afa1@gmail.com>
Date: Thu, 6 Mar 2025 11:50:27 +0200
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
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250306083258.0pqISYSF@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/03/2025 10:32, Sebastian Andrzej Siewior wrote:
> On 2025-03-05 21:20:57 [+0100], To Tariq Toukan wrote:
>>> I like the direction of this patch, but we won't give up the per-ring
>>> counters. Please keep them.
>>
>> Hmm. Okay. I guess I could stuff a struct there. But it really looks
>> like waste since it is not used.
>>
>>> I can think of a new "customized page_pool counters strings" API, where the
>>> strings prefix is provided by the driver, and used to generate the per-pool
>>> strings.
>>
>> Okay. So I make room for it and you wire it up ;)
> 
> Could I keep it as-is for now with the removal of the counter from the
> RQ since we don't have the per-queue/ ring API for it now? 

I'm fine with transition to generic APIs, as long as we get no regression.
We must keep the per-ring counters exposed.

>It is not too
> hard it back later on.
> The thing is that page_pool_get_stats() sums up the individual stats
> (from each ring) and it works as intended. To do what you ask for, you I
> would have to add a struct page_pool_stats to each struct mlx5e_rq_stats
> for the per-ring stats (so far so good) but then I would have manually
> merge the stats into one struct page_pool_stats to expose it via
> page_pool_ethtool_stats_get(). Then I am touching it again while
> changing the type of the counters and this is how this patch started.
> 
> Sebastian


