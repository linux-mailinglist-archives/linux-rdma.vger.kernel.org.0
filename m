Return-Path: <linux-rdma+bounces-7383-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C1BA2660B
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2025 22:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B50053A3F13
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2025 21:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF2020F07C;
	Mon,  3 Feb 2025 21:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHA/tLpU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A15D78F54;
	Mon,  3 Feb 2025 21:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738619377; cv=none; b=qzabtnbcdI/sVMrktpms9P0vpZedHIgjpUxWkfDC18o2F+GQY73kap7RSMmMXdYW59hJUVc0oQHr5XI/b/I5UOTQjv2S/KTEY8DGDm2RgUm0eVXbCTCOJgd768fVCP4Y9eYUDZgqJrXTgvgQI7K6uLmTcbeSH18sq5rlWb+4gp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738619377; c=relaxed/simple;
	bh=giYmMvQGmodVIsBV2FyAzuHCM2XEumayECjAxk6wMks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yt0L8UpMaAZk4pJEpAVQw0TG/9Xb/hF9AJcRQ6+xWoPng7IPsZDAIvKeBwOfOPxAEyZVX55/Amr71RFkqEOT9ez6OJ3EUtrHHDTTTA4UtUnt6cxPum/IKf/MHIOZ+GS2L7dB52X2eZ7iN7SjgptaWCxaFC87olytq8QCee2zMic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHA/tLpU; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4361e89b6daso34062875e9.3;
        Mon, 03 Feb 2025 13:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738619374; x=1739224174; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uwrjox93lk/WUq0j2CCvg8TL+f+jeBTC8HvZULmrJqA=;
        b=LHA/tLpUTGEaA3uEs/RXiVds+eKVH9Yjda9+kUSlH2EQJYmbBxdMK9TlFNZStJRFUM
         jOKGL3zolvQAEUzoD9rOjlW++hi44YgKzWw67Rjxa56Tv2+7n7uvqGWGkxoVaR8zP8c7
         18mdJ5wx7o9uVTcJOJNsOBTrjpVU7g74RGNtuwIEeUjByhR3H8Pqr0/+71VUAXBrO9AY
         E09D7AS2wp+FB33fOe95N/U/Rft4Bd374uCVuKX+8ow5xfjSQR7ePmhlgMTz61zWe0mp
         TXiHZo6Gpqbh3VfJyJEquiDsQUC9+GDcMWF1upL2Z/tVD9UceWp3Mz+wbmfGfn0FLRHQ
         HUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738619374; x=1739224174;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uwrjox93lk/WUq0j2CCvg8TL+f+jeBTC8HvZULmrJqA=;
        b=YBYhqwOy46rGPqMU9D8zyxPMD9u5d1PkV13QCmP1tr4B+dB1p4eawceRdhuVeiqJOq
         lctZFbXY4/AAZRv/S7WYRX5rULBnnal4cPGKOPFeDFzNwenCcswDlFyDyloJBToQDFmR
         HyxLD0yjXX8pJD+N52rksRrsK49dhd2dntQstqBKgRk94pLQ/dxbsr3G5iqrJXmkCPF5
         jgu17/2gzpay/ydCUJcwumzibB323fFdaUpCKGjTPpfEydC+prRnPn9YwUkoXxkZYlpP
         DM09JIpMM/aq1Yc6r7D3FqPIOhQtYCpeSOp84WCQMXAeFK5Biky1oSF++Cw/RCblTd3l
         SdBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsBY5M9YUW373xuchmphexUA/679XF2gYHV/hlmHNUZ0VJJ5t7u37KWvwbEfpHcZkNCi8tVAV5x6RjpBE=@vger.kernel.org, AJvYcCUvyGAMcxfbp6nz9XrN9JWT2ATMKaC5igANI+uJBKcE/sjjna0I+exM09COirgs1rOaUEOO5tjH1JUK0A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ1unnVNLx8Qywr8N0FvgiK9hhoF79jZnpqqVXoH9f1ZVIOyTF
	yaVwqpT+c7jYZ5TvY/t4IFTd3UhtZVydmlKmuvgyqeQXBO54Wmto
X-Gm-Gg: ASbGncumyQm7coxp+ja2mBWhZ1GZ2qWwOR7kI/IbPwlHaoJfhiaas0ckEN7ZHe+8CIz
	lu2dbsSsjL5l9K6+WQ7iI7vfJnwQoZGxxwmlw0LmrM66KLLg734LROc8X30ShMg520anPDqZZGV
	pUTI+U4cjJCU9MZ4y0ediNo8goEWP9j4z8KtjEJ21W1JfX7VS+5Im3vqexhMJsuTDSTpZoou1mh
	N9Bf7OzLRqEq1y2mTBZZKPke7caMu6AYvTfNV8qIt74Al4L3eczcBXkob9+rMwgq6xBQR28Ov2F
	fuNI84ni1dF8PSgkpTt9pe1r86y9CMzdnIs3
X-Google-Smtp-Source: AGHT+IHigCdk9E3B1PblZOV5CluGEjbP+FByJtxOd06EfeqC8yMdoTWguI7Nxy/xEc3QX2T6/Qh3HQ==
X-Received: by 2002:a05:600c:c87:b0:434:f1e9:afb3 with SMTP id 5b1f17b1804b1-438e0d879fdmr168579395e9.3.1738619373757;
        Mon, 03 Feb 2025 13:49:33 -0800 (PST)
Received: from [172.27.33.160] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc2f73asm205018125e9.24.2025.02.03.13.49.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 13:49:33 -0800 (PST)
Message-ID: <8dafbbcb-2d29-4c1a-8afe-1c5fad3db3f1@gmail.com>
Date: Mon, 3 Feb 2025 23:49:31 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5: Remove unused mlx5dr_domain_sync
To: linux@treblig.org, leon@kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250203185958.204794-1-linux@treblig.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250203185958.204794-1-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/02/2025 20:59, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> mlx5dr_domain_sync() was added in 2019 by
> commit 70605ea545e8 ("net/mlx5: DR, Expose APIs for direct rule managing")
> but hasn't been used.
> 
> Remove it.
> 
> mlx5dr_domain_sync() was the only user of
> mlx5dr_send_ring_force_drain().
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>   .../mlx5/core/steering/sws/dr_domain.c        | 24 --------------
>   .../mellanox/mlx5/core/steering/sws/dr_send.c | 33 -------------------
>   .../mlx5/core/steering/sws/dr_types.h         |  1 -
>   .../mellanox/mlx5/core/steering/sws/mlx5dr.h  |  2 --
>   4 files changed, 60 deletions(-)
> 

Thanks for your patch.

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Tariq.

