Return-Path: <linux-rdma+bounces-13732-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FE7BAB780
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Sep 2025 07:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 848BD1691C8
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Sep 2025 05:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BE026FDB2;
	Tue, 30 Sep 2025 05:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WThhG8A6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CE786323
	for <linux-rdma@vger.kernel.org>; Tue, 30 Sep 2025 05:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759210136; cv=none; b=JxsIkmJ0FZtBaK+y+A28wYgfRSvELXrjRHbiRO6U0wy5aGjEGv5T/r6pPZ0TJYmJMAd7ke6ZndRsIzkpHEZ7AB0GTKKXd6s9qWGwxTK3TWYhMHTn/dy5LdfXvbt8Q8LThf6KK8d9GJ6fKGhmG5vzfCGSrzaPLd8y+ptwcbamOOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759210136; c=relaxed/simple;
	bh=cu4heVIxO6/Gw30m2J8LhrzxQEa4oV8ULkQnVzcdOX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jIjAQiyZ51ceXXYUY78YkwL4uOrUjWsOshqd/Zt6zYiL2CE9VLK6IqgchDtKb425mV/Hg4o1/0qAxcDIu0LTrHJkwwp4elDPdmYzxL7JtaaFTRGvIgFdBy4O6kgt4jalslWtXAyVVvUsLq2aufiXrcXTr8/7+jYvmlEcECco2XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WThhG8A6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e47cca387so34771825e9.3
        for <linux-rdma@vger.kernel.org>; Mon, 29 Sep 2025 22:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759210133; x=1759814933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iXNttZqPfS4fimtYdIOocfzVnEBcLheGLZV8R8gaHeg=;
        b=WThhG8A6sWS1yiiF3oXVOl9DhJUASL9Y6pjVkDU9s9eiti3BvTL5o2LgJCX84kd93H
         pIp6X45xVXi0j1kq47d3nQgn+H1IyhIDhQV7NiT6fil0fZNgx0FlPJ0KiSH/xRLZvFWu
         LFxdToF+sn3zHhHfk0uKok3O/+OfPymBNOmhZdqmhq8qgXV0lixtsvbtrpg22GWi59vR
         4wkI5yhOBoMB7an6tnKfHwPyCVVpg7bS25zrreBERz64xyDExc0Tku6Aw3u8vPPmllNU
         Y/ZNpM7h4IBNL+ERrkqgch+ZnH1HHR73JKGxxtIC3gVE61PgSzgZQv1inrVfuZvECKZf
         o1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759210133; x=1759814933;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iXNttZqPfS4fimtYdIOocfzVnEBcLheGLZV8R8gaHeg=;
        b=RIZda41khpSJojaem+ZLi21AZiBeAhutxlqyBSi9sBu8XXJfI9UbgYT35d6UIag58X
         JZm8zRrgbTnQRZeYHtz2nMEtksqUFLMsXuVoErS5HjIrRuirPmQHcPswa0DHFGBKGxE+
         BSyswjgk75cVMxBji1ukURYS+0rpwMydOv78xDWrjJ7N7UB5Vz4djy63O3p/efNTGKWa
         4VNhntvgCmgZUFgb1+3aSZJTXEE17rvX2px2wvVZ8/PMJZ7XInW2qkK5iSIQYTMISsok
         HMSsq+tsvyCIcwyDsqqMSQPnjFNek3bWEh/bSjVad2z49+7ZxoQ8omPunLtvT7Ylgcnd
         fp6A==
X-Forwarded-Encrypted: i=1; AJvYcCWtWrKvzJLhYFscmLuZpiwzsZv5iU6mS8hu6ajx9cn6czkoryRNr+N7Qc9BxOfqOg9k78YttNm0N0bb@vger.kernel.org
X-Gm-Message-State: AOJu0YxyNLUxk6Tfrw0DbVx3x3D2ACMRq/bXJ+OPzcqi+T7YoqiPJA3F
	cJQ4Cukig/SxjPhBD/3lgejPFHcPbJGbqp5jFuneUqFW9ipxIODF2JaD
X-Gm-Gg: ASbGnctQrUwrLZdTv6l/05ZbKG9HbSzPMOzupbQnpnwqPPT+emVcY+z6h4D+l0Mrnkx
	xaljRw4KeCau4FKpJlCes+fZVbBEBdHb7yJHbeTNFMdEjfeDwRdPWkkKGX68hv1Jzvg8HzMmdfc
	w6bPDOl3wcrDbiTkXF100LxBqEdNIbsR+Gt9EvKHCWeL0YnP5P5Idnep0glO3sT21SlTYrjCT1u
	DuaE1HVchJBR23JXVwweQaWh+zULBpvE8aUT+hJnUmr8QUmv/lYyqwQl0bZZ5lCoZKj5pH0uBYy
	Pwxuh1xk/41ur+FE5jZp6XeKRPojl0vz9JHEOyFlTspCO0/A8xqnI1M10DEKvF9xI/i3KlNU8Vu
	Z0kTXaM9Kb9f9HlKW2xR9TBF5vSiHxULA3F69ikuQSM5NKcLEaVSQm0BRdWi4U02XHneX2nNp2H
	UxOO4/
X-Google-Smtp-Source: AGHT+IGb3PutgcRprkBVcOIXuROwg6xDK7bl4CHZArC1beRvEwCGAdWq53tdEC1ZYQ/78X1RYv37bw==
X-Received: by 2002:a05:600c:1394:b0:46e:1f92:49aa with SMTP id 5b1f17b1804b1-46e329c6355mr178605095e9.15.1759210132717;
        Mon, 29 Sep 2025 22:28:52 -0700 (PDT)
Received: from [10.221.203.31] ([165.85.126.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e56f76b21sm38121075e9.19.2025.09.29.22.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 22:28:52 -0700 (PDT)
Message-ID: <c5846bcd-0f78-4b9d-b765-529f4c985edb@gmail.com>
Date: Tue, 30 Sep 2025 08:28:51 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] Revert "net/mlx5e: Update and set Xon/Xoff upon MTU
 set"
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, saeedm@nvidia.com, leon@kernel.org,
 tariqt@nvidia.com, mbloch@nvidia.com, alazar@nvidia.com,
 linux-rdma@vger.kernel.org
References: <20250929181529.1848157-1-kuba@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250929181529.1848157-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29/09/2025 21:15, Jakub Kicinski wrote:
> This reverts commit ceddedc969f0532b7c62ca971ee50d519d2bc0cb.
> 
> Commit in question breaks the mapping of PGs to pools for some SKUs.
> Specifically multi-host NICs seem to be shipped with a custom buffer
> configuration which maps the lossy PG to pool 4. But the bad commit
> overrides this with pool 0 which does not have sufficient buffer space
> reserved. Resulting in ~40% packet loss. The commit also breaks BMC /
> OOB connection completely (100% packet loss).
> 
> Revert, similarly to commit 3fbfe251cc9f ("Revert "net/mlx5e: Update and
> set Xon/Xoff upon port speed set""). The breakage is exactly the same,
> the only difference is that quoted commit would break the NIC immediately
> on boot, and the currently reverted commit only when MTU is changed.
> 
> Note: "good" kernels do not restore the configuration, so downgrade isn't
> enough to recover machines. A NIC power cycle seems to be necessary to
> return to a healthy state (or overriding the relevant registers using
> a custom patch).
> 
> Fixes: ceddedc969f0 ("net/mlx5e: Update and set Xon/Xoff upon MTU set")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Thanks for your revert.
We'll post fixed versions when ready.

> CC: saeedm@nvidia.com
> CC: leon@kernel.org
> CC: tariqt@nvidia.com
> CC: mbloch@nvidia.com
> CC: alazar@nvidia.com
> CC: linux-rdma@vger.kernel.org
> ---

