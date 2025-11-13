Return-Path: <linux-rdma+bounces-14460-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9E6C57136
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Nov 2025 12:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 680354E91A1
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Nov 2025 10:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF30A33469C;
	Thu, 13 Nov 2025 10:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQ3gJ3CK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F91B3321D0
	for <linux-rdma@vger.kernel.org>; Thu, 13 Nov 2025 10:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763031589; cv=none; b=pIJwfHI8gtiSzayTCksrZ98hcZUNc2BXGPG9koJjbCg+DVUWbMuK8BExi1BB6jhwiSiAhjaeXD9iUP5744rcVHPDm4xAw4zCqPU/AbeqjLwhJEXtvSESH6OKRfno+YdSSyc5mQjV8jazDx6pj3Y0wPZSMc4n4/lli9/dfruPqQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763031589; c=relaxed/simple;
	bh=ugZFlfc+l2S+0zWCSf1PxybsJPWJGmiF5NzWiKPgTzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mCDsXlfjErXt0zMpA07WT8GZZX/r0I0ijRyK880WAUMdRCVaB9hJoMmjyxH0sMcyIfsORmp2y+TkGgpp3AqgjSeRU83rXIDnfia4qGt0NPqnu2jamFnVmiSsNKpBjAKXzop7+Vq0WTF6Zkyjwe1NICu2cmS+o4cHixMIB6DJuAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQ3gJ3CK; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4711810948aso4608045e9.2
        for <linux-rdma@vger.kernel.org>; Thu, 13 Nov 2025 02:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763031586; x=1763636386; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DEJC7gRTebDUaxwAOnQ9BV9gIzheu37nMO4ePUyMYEM=;
        b=iQ3gJ3CK+EvoGocot/Chl1ETCyQHG6GXKwpS32/w52vYJtH8PF+c+cxZV/V6Y1PWxe
         qQBxxItLa7wBBe1zZ9JtuCwAePN8hF0IEfGpf7mwgZHswAUr5F5z5W2+oHO8d/5u8Kqn
         ZcpzG3QzVsMaDloGTcuam0H7i2Vx7Tf3pNPAOErn3+NNfXOeDcu5CkOla0vCNq6j0eRq
         kb7ALrEYpAPxkYAqzmZhzie7mwW91sUlFc0t5W5GEqiI2Wu+s3s92KmvLriUjGRIAv08
         Sp/gVpLYzBsC4LCG1dy2lrfz5a117+bAMyb8ZQCcKJw3j3+ZsX69A4qprDhlEiWVh4NE
         qEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763031586; x=1763636386;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DEJC7gRTebDUaxwAOnQ9BV9gIzheu37nMO4ePUyMYEM=;
        b=oS1r7EQ11mIxTSEgy8vl1UaDyFv6LVz0vyIk435KBu5WroX9JdvWDA3352HRbNoejw
         85Q4vPHvPVR/T7cBfFUdO90YBKqg6meqSiyZxDprklZTAnmISeF0ZbUaLJMetmPwSJKg
         PCGXlrp23snRkLGZV2QaUgPheJdcnL4rZ6EzQmgnMPCI541xj7GElihVLh/Gq+Cyze+H
         I+OHIPPHUHJ8/Gr33zSia9OGUAwAlf8tGK/Qk/QWwCso0C7P8RTHCJiC81PaXRdlJ6wv
         Hg0bVX3II+oe2ffLFBWGvGu/BhLrNtj8UsoEbtgG7zG2VvYRpCrrZ01zd3kjWzvZsG1X
         FtXw==
X-Forwarded-Encrypted: i=1; AJvYcCV4nsTsHcMe/XGFRe3VawqSkmN8e3zWsCb+NLYnpbg6pWZqgDllVdaqMCi3lHm9mu4zD/YHtWhdd/G0@vger.kernel.org
X-Gm-Message-State: AOJu0YyztBV4Ap7llSfMbOIbdTFrDq5CivZx2ESo/J+pKEEUujQ3vXlB
	9gtmW8Kzd32Tq6h1cR/u92QGy7/25AK/XjkSOL+FrXnmQ/gJmHBZVgvV
X-Gm-Gg: ASbGncv/MkFdxCcoa6mVkB79VYg8xCdfV7WnAQ0eSDabwG4wjYdWs+Yod0+9z4OXSxr
	+VKV3l2GQXNkTbVcZKn6ovt8/wbylRcp4sajxkpoiAGgR4dLVTRMLoO7PoWK+f2hb8y+h4gLDYz
	YrLZkIlC6MLC3mQK4A58E0KKIS1WRoamk1cVwzMsRQQmdaLpoEqnxmuOwyydwJDS6KfBCeR8o9f
	YQuhvmWSGtjvVFiV90BFMw4bqqyiYUfqhW66dukQ0C6j8tG3nvrj8lXSI9oy+wrOXIr9XHuO+yM
	SKR/GwIgbxriRQNjUwAuPyFHiz9yoUlkkelcajugIhYOz5FTweVaywhSbdROTJ3VhKefWzQNeXK
	FBeZAIhb6O2K/1tIMXk28mAaZjPEx9pBLuoad8kl2qvhUl68DA2WQSQFbU3GZVrx3Jn6EDyz4td
	frNmbS5MCoiDMp2uhseNqd
X-Google-Smtp-Source: AGHT+IFCpVKEMNGa1TiGFz1du/mkrAjFihX7xaQjFh0qLSpjr6GgH+cPEzn+8D8uBc5acStTR7O0cA==
X-Received: by 2002:a05:600c:4694:b0:477:7f4a:44ae with SMTP id 5b1f17b1804b1-477870bf2fdmr57386475e9.39.1763031586191;
        Thu, 13 Nov 2025 02:59:46 -0800 (PST)
Received: from [10.158.36.109] ([72.25.96.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b513sm3255195f8f.30.2025.11.13.02.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 02:59:45 -0800 (PST)
Message-ID: <60c0b805-92e9-48c0-a4dc-5ea071728b3d@gmail.com>
Date: Thu, 13 Nov 2025 12:59:43 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/6] net/mlx5e: Speedup channel configuration
 operations
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
 William Tu <witu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Nimrod Oren <noren@nvidia.com>, Alex Lazar <alazar@nvidia.com>
References: <1762939749-1165658-1-git-send-email-tariqt@nvidia.com>
 <874iqzldvq.fsf@toke.dk> <89e33ec4-051d-4ca5-8fcd-f500362dee91@gmail.com>
 <87ms4rjjm0.fsf@toke.dk>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <87ms4rjjm0.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/11/2025 18:33, Toke Høiland-Jørgensen wrote:
> Tariq Toukan <ttoukan.linux@gmail.com> writes:
> 
>> On 12/11/2025 12:54, Toke Høiland-Jørgensen wrote:
>>> Tariq Toukan <tariqt@nvidia.com> writes:
>>>
>>>> Hi,
>>>>
>>>> This series significantly improves the latency of channel configuration
>>>> operations, like interface up (create channels), interface down (destroy
>>>> channels), and channels reconfiguration (create new set, destroy old
>>>> one).
>>>
>>> On the topic of improving ifup/ifdown times, I noticed at some point
>>> that mlx5 will call synchronize_net() once for every queue when they are
>>> deactivated (in mlx5e_deactivate_txqsq()). Have you considered changing
>>> that to amortise the sync latency over the full interface bringdown? :)
>>>
>>> -Toke
>>>
>>>
>>
>> Correct!
>> This can be improved and I actually have WIP patches for this, as I'm
>> revisiting this code area recently.
> 
> Excellent! We ran into some issues with this a while back, so would be
> great to see this improved.
> 
> -Toke
> 

Can you elaborate on the test case and issues encountered?
To make sure I'm addressing them.

