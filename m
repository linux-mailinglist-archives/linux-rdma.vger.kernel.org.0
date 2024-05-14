Return-Path: <linux-rdma+bounces-2483-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B888C5B64
	for <lists+linux-rdma@lfdr.de>; Tue, 14 May 2024 20:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0D011C217DE
	for <lists+linux-rdma@lfdr.de>; Tue, 14 May 2024 18:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F52180A8E;
	Tue, 14 May 2024 18:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEQXshWq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234DE1E88D;
	Tue, 14 May 2024 18:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715712944; cv=none; b=KzLrhH189hnLHfFMQMepMJQNv6UZO2pN0Lurw/DXMCe9Q++cqifX3Ob4KwRQyzsblknZTTvoUMtmOLsEfW659WStwwGlaOuBL/iIiHE2U1QkF8OcubDSAbxoniCzgScj6IXXbKpjvR/aQ+khJfw1FB3td1e0fmbkW2QzlgVh4WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715712944; c=relaxed/simple;
	bh=TxuqIu3e2EFPMV+34yJQkIWnIE1+hACr2KaJ1NiXlmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FrvXG/bIXbOm61uq33LmXcWrNfscx0IYkCZB6p2xGfYXSYeBpStinVXyOgnEnRYw7V4fiRGSRxiHPuBhsYh7sLzUDVui3Ug7x2n1x8O7A+Fb1+0DGodDZjm6zQv3c0GBDxQcaHKrEYciW+uB21bs9udK1FpQ7RfJr2/chQhCy/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEQXshWq; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-34db6a29a1eso4790469f8f.1;
        Tue, 14 May 2024 11:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715712941; x=1716317741; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y7Oo9YahnQFZHzOwJoUrSXdH2NtFloyrj46IdMn32Ao=;
        b=mEQXshWqfzu5sk8VcPOb6PlDcNNhRHihd+l6BYijCZxg7+vNKziYShWjWZirP6wlGt
         u3m54Sgwp74l1Uc54gA1wPFD2Xg4w4XuaicqehN/k2L3Nrzvlwxr5SZDuxlsC3EkPSTm
         xqoDvKLq8xOY7F6GCxIJeJfBTG+om2rCeziJd13PZGe00cYxEnr/qAAwxw1MJS4U8K1t
         zsgoWGVppCgBm8c2VYN15edT4L+S8Z2dv1I3ulHH126tICbxiUnYq9UmH9fiZa/GRUn7
         IChvNIIRoATzkfKS6MFgFueyhZf4Lw/KwjQAzI/4vX0x8lJvvXoa9pyTetXPjQq/F39e
         EtbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715712941; x=1716317741;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7Oo9YahnQFZHzOwJoUrSXdH2NtFloyrj46IdMn32Ao=;
        b=HTIz/L02SYFL80Dm9PzKvdrF4B+uqlmuTBvF/u2O21qftWtVYPV+J6n8xt3FTdByXR
         e4XVySwtV8etXDwhpOuzByi7vLJPzLJMaKGrXibCgjkcpROV6wvCW7cqsbGWpw+x47GO
         p4FR3/pr93iYgMC/DjssdGJEOJwTjIk6fMOZGg5QWcFAYNQzwMu4WuumuNogGoOXhfOq
         IN7nnbuz84Dh6LJ1KuRrjr3IxVOj7y/xW/rGNZzWnyXyb7rxUfqkPPDv+mxayICVNS/e
         5MjZJvmOYk84fKrLj+Ub1/Ht7MAGw2g5v3N0N7/W5OKpu4IIGua/T7ICothSeelVIv7N
         eLTw==
X-Forwarded-Encrypted: i=1; AJvYcCWHB30vLzha5rQbyfc6ZggUQD9C+bTN0tNoUCF+kc47eYfoz2yhqYF1bo54I5gArUjxKOg1tnUnDIOmVA8iirTe3accyzAy+BnF+VQDATMRHmaRBxmzSUo1nHtSvKZjquB89dLaD4gSMmER1t5MR9Ff3OWOKnqQBLLcNhvVZdVntQ==
X-Gm-Message-State: AOJu0YzpmY6GKfGB310ZenH4ft7CVnB2L+ur/o3yDsKLRQySkKkeL9AZ
	dnjsyFmI40/fxGcraQfIl715p4iFSqbt9MYhvNVssLjN1v28Pv4g
X-Google-Smtp-Source: AGHT+IGNkCtzE/Iiz5DXAhHblOEJmpApRQVsn2jigYFY1/Yyg75oBgFXUVZ9vWcrLPC4RxTIW6zxLA==
X-Received: by 2002:adf:e582:0:b0:34d:a738:30b8 with SMTP id ffacd0b85a97d-3504a62ff93mr8418176f8f.12.1715712941303;
        Tue, 14 May 2024 11:55:41 -0700 (PDT)
Received: from [172.27.21.185] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbbc077sm14253552f8f.104.2024.05.14.11.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 11:55:40 -0700 (PDT)
Message-ID: <4a331dcb-5635-46de-9638-1fc32d143721@gmail.com>
Date: Tue, 14 May 2024 21:55:38 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/3] net/mlx4: link NAPI instances to queues
 and IRQs
To: Joe Damato <jdamato@fastly.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca, nalramli@fastly.com,
 Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 "open list:MELLANOX MLX4 core VPI driver" <linux-rdma@vger.kernel.org>
References: <20240513172909.473066-1-jdamato@fastly.com>
 <20240513172909.473066-3-jdamato@fastly.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20240513172909.473066-3-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/05/2024 20:29, Joe Damato wrote:
> Make mlx4 compatible with the newly added netlink queue GET APIs.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Acked-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   drivers/net/ethernet/mellanox/mlx4/en_cq.c   | 14 ++++++++++++++
>   drivers/net/ethernet/mellanox/mlx4/mlx4_en.h |  1 +
>   2 files changed, 15 insertions(+)
> 


Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

