Return-Path: <linux-rdma+bounces-14440-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2622C52021
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 12:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92F6018E2917
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 11:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBB630EF9B;
	Wed, 12 Nov 2025 11:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjVdOQYk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167CF2F3621
	for <linux-rdma@vger.kernel.org>; Wed, 12 Nov 2025 11:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762947037; cv=none; b=p223P6o/aYwooK1b4S03t8J5HrKeiZqrVoyx1xeGmFAXIuZTjxlFIPNtZ14l7f1TQTeS2lswUnwTqL9TH8ny57s1QzGgt4RTfwqrZNwh0hfMt7MTxNKvOd27+qs/oiWqvRJ/QDt0TnSIRXjPyKROUlPKYcwA3d39zuADV2AkXMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762947037; c=relaxed/simple;
	bh=iTAh58xsSTK/DPrCrA9XXO9oOUT/gyUSwdPtMZDZRY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=STvXr1VDi7jlEm6VGs2IA7ttLxO6l2P02kUu7I4TCLOEbufUrPwEGAi4ynqwuIM4YKdbQdNu8glS4yrq6YYl4YIbKMdAGXIVF/KE5hzZ9SlgYvGn5D9FGBTJsOBVXMmPhNQ9PQYgL4JPy8km1Q4pQOHE4BkkOMeErWHKR6lY8LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjVdOQYk; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4711810948aso4731905e9.2
        for <linux-rdma@vger.kernel.org>; Wed, 12 Nov 2025 03:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762947034; x=1763551834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l/oUH46h86/olGMZU+XghYpDhfAZ96DwWr356lECM4A=;
        b=BjVdOQYkNn1GugyEtpXSuZbkJ+6NMebvOiOl+vQATSk4DKzy9dP0IzIfF7t7DTxIc0
         h79Cayo4rd1tZHnm3UF6iP16NquA/XmQD1sqR08B0brtBRUm4ITnOXvc+1xwtwV2k7jX
         IqISyf0r5iDNq2JTyIpuefvmlX6xXMDkd9TrEWPtwqTgWsn4oyqRRTyIYNo4RHtFR6mP
         09DYULt2CWaTGcv8PemxgkCUZjwV0kIiNzt5YSy402YM+Flyd34wvMhjIH7WNREJLZoB
         3ZNkEHdsDRfFf3C6aBNo8t5pZGT8AXJXDZZepxyvwuUsqBbgn11CFPp+iptlcxfzy8jr
         FszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762947034; x=1763551834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l/oUH46h86/olGMZU+XghYpDhfAZ96DwWr356lECM4A=;
        b=K9yq2iJFvbPUSzGzZbCJLmvM6xJCZJgcqAzvdLQOLUcegee4Q5LoxWlfgFGbAFlrtc
         +MAYwIqlKZkWV3hcWeSXvvGGZ9/ltIMxjhGkM8KPDPB2p69wU3a1j8h616KflGp0OIMo
         daxux/X/gWcjn5SnqKHq3wHKxoYwz++qhfVLpyMRzh7LI3au/0DczdszyCDB3RGB+S/f
         9QUXkFUdWPgz003iL9mEgoqemGxaf7rPbeWz/dHK7Il8MEZJOUpJp008DiRFZg5PvYLP
         iTUQR25jDre8YX1YHCCTy8PUnz3Ne1hqsTxyHQkwuxf+5KFuiOaRFwCvBrsH4af/6gfC
         Y8sw==
X-Forwarded-Encrypted: i=1; AJvYcCUN/qHoNMvvavN9q5tWNfpcsV8MrlOaFQ5tugx1PVyxnjcEQFtSwW/NjgwiusrwpAQgMZrySamklAzx@vger.kernel.org
X-Gm-Message-State: AOJu0YyvXQ6NwHeaj0fYeEx4CNHlgofqfnoSf8yY7IK200ykaryBM/XS
	Q7rHhl4bRjBsZUzvKdfy+s3M8T3r1GjNWSn4nwuOzNdPF35E6HQn/6PO
X-Gm-Gg: ASbGncviOaAekFbUVR3/7qJd9YFRxDoTPLDBa0Oz2I9emoPBrWYgCV5WrYVAB1G1bUh
	U325frRQ0w0Tuk/r0oTePLMMekRD2KKQf9Ush8FE7EfkHvUvicq87NJK/btHHah591/MxF3wO7K
	pYzQErZw3LBOOflLGzh8wlev7B7kx8wcUpXG2GXZ23PCS+UauzlgR4i36rhwR9W7bsWiHSUSPQE
	NoGh+Kz8MAH+bT1H/FM2XVTpCYNDsgxTN9zlHOfeIMwOE+/iZykexNfIulktQA34mXR4mm54/QA
	cE8uc1jsKVVpH9zP5gyzQOS341ZR5ASNymqTF7LsSvnBf/mYfzJm1IiXRMfLNmgKe2ZygGLe9GI
	O8HAc3p55fmo2G3AubMIA/RjhRKNxIQrFMncMqhEbNkLDEjd3jimR9xMq9dtthVjYbraXjckS8y
	aSMR8FKcQe71Li70TsSM2I3Io=
X-Google-Smtp-Source: AGHT+IFzZn82+HqmV7Z5oaduLfvBaDy2CYnyKKDWs/rhY5yLhynN3LzPM9CdU2cQ0vUhoC+2FQjWgA==
X-Received: by 2002:a05:600c:4f93:b0:477:bcb:24cd with SMTP id 5b1f17b1804b1-47787095d98mr24817395e9.22.1762947034215;
        Wed, 12 Nov 2025 03:30:34 -0800 (PST)
Received: from [10.125.200.88] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e2ad4csm31122115e9.1.2025.11.12.03.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 03:30:33 -0800 (PST)
Message-ID: <89e33ec4-051d-4ca5-8fcd-f500362dee91@gmail.com>
Date: Wed, 12 Nov 2025 13:30:32 +0200
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
 <874iqzldvq.fsf@toke.dk>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <874iqzldvq.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/11/2025 12:54, Toke Høiland-Jørgensen wrote:
> Tariq Toukan <tariqt@nvidia.com> writes:
> 
>> Hi,
>>
>> This series significantly improves the latency of channel configuration
>> operations, like interface up (create channels), interface down (destroy
>> channels), and channels reconfiguration (create new set, destroy old
>> one).
> 
> On the topic of improving ifup/ifdown times, I noticed at some point
> that mlx5 will call synchronize_net() once for every queue when they are
> deactivated (in mlx5e_deactivate_txqsq()). Have you considered changing
> that to amortise the sync latency over the full interface bringdown? :)
> 
> -Toke
> 
> 

Correct!
This can be improved and I actually have WIP patches for this, as I'm 
revisiting this code area recently.

