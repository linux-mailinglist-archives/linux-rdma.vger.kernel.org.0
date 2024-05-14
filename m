Return-Path: <linux-rdma+bounces-2484-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2422A8C5B76
	for <lists+linux-rdma@lfdr.de>; Tue, 14 May 2024 21:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 555511C20BB3
	for <lists+linux-rdma@lfdr.de>; Tue, 14 May 2024 19:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072E2180A9E;
	Tue, 14 May 2024 19:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/N/kmuT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497551E504;
	Tue, 14 May 2024 19:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715713638; cv=none; b=JkYoPwB6UXKJCgRjvJ+Ogj1j3B/0V9x05mpgoxm/oB0gI+n3Xs8MRTP+HzsLDnOYbqvtd1m9JL2eYJAc74HLWMvs49oJgUIJpFAy5VDYGivp13Sf58ZGSSH3OJ9yyx8246Oiosxzb6290oK5KMfuyaLUga2YJHceHf0g3Onmgp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715713638; c=relaxed/simple;
	bh=OApaGFXz5UPRbxRAK2WugT1zcfKuYHqKyoDQHaiRW2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G952zDfdZ+rW94JF6tDimsLaSTCvlT8K5WV8tGWBAo2pCBNAj4LYH7Af49StHTaHyk50xZZksc7So7Yjhhttcqsp4G1MfshRdG31yiIgjCnQY6pnOwjOjb5ad/LdJPPTPLHHSvIPssEwcjgKL4Ptlreo0lEL0fcTARA6qjYQy7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/N/kmuT; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-420104e5390so33479355e9.1;
        Tue, 14 May 2024 12:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715713635; x=1716318435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9C37JUp/tUGIFgetRggFquZfpmUvmzoZNupVvwtMS08=;
        b=Q/N/kmuTZCHgi/AzRU/HHNeAPBc73sBkQszEFkjhWsPaXcAQZtSUiSt2GqYajxwrax
         PsjOXbBEgcNHkIDRBy4yrPDHDOTp+mfdBCP65HKDkzbIKBH0OWkhQKia8wWbbsEcF8vZ
         TYT0ci6CumsQ4dAN44dIgmhL6EHkp1d7AfXRXYhPU3sb/rAdLesE/IKqxEfpJCMGu137
         cEZpSA03B0MuOiGq3iqMhjT1ud++ougy8BUJbm/hPxnlnCpFME7WK69Ke3b/hzsiF1Ud
         1LVm2mFrIBDiaVZIrsICxry2uwPpQLPnpR1nhLDfZVKevtDiBRlvvMG7CtdhaH7e/m1c
         YTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715713635; x=1716318435;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9C37JUp/tUGIFgetRggFquZfpmUvmzoZNupVvwtMS08=;
        b=cKBgztb3d8Af7N9B4zE0BWH4lDkPCX4bn0d19ibbwveDEiElolKfMtv8YShrFrn6ba
         n6DytZN7ZBfavbhTuMJVGLbw1NoNH15FywWWAQNgg2D9iAy9pSf6jpPL/H3JBzEdGN0i
         cjbpi/r2v2VS4QnWc4/6fS64nLj8hBSXfim2XJFgC8mt6+gmkJG+xqIgMzdRd9iUc9Pp
         mA5/bphNei2/MtHM104A+ijay8vEInaUOH19VMWmOyATGgzeESa4GvJx/NdqSepZu182
         23ol1XRlRJKDBcKXZuMzRzwVyUr9FicOD/LtlsOijVBrFgMyt+Y0cT8hfR5Nx8qAs+es
         YK3A==
X-Forwarded-Encrypted: i=1; AJvYcCVTY8+QVSLU3mKDmK9uVIfm7UI9rE5mGZjMfh/aWoq07WUY/G5OxEDO8CfDlwYr7d6pkz05Ex1RHq/+LJEHXvpU9EJ2p2JllSZv1GV15XywuNeHsdX9BcNrTjJ73sNDrYBHjmrCxFlDitbshqnJKdw59NafG26EkNmH8PQUoclf1g==
X-Gm-Message-State: AOJu0YwkY3IjNruG6Ti2JS3+sseQXa5ZSJxHPrDzBd75zEpyTAN2E7c0
	bfHGI4aUoiWl4GCfCLGnezSYnVna4XyYAHPCXgnSoHpeoeaI5c2b
X-Google-Smtp-Source: AGHT+IFieuF5kHfIADXEBCRvrZT7p5csOnvYzKzG9wCrW48WSlAkIZN/CXeoYGWzQdt30DQQpKv1KQ==
X-Received: by 2002:a05:600c:4f04:b0:420:1508:f0ae with SMTP id 5b1f17b1804b1-4201508f2edmr70658025e9.10.1715713635448;
        Tue, 14 May 2024 12:07:15 -0700 (PDT)
Received: from [172.27.21.185] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4201088fe8csm123126825e9.32.2024.05.14.12.07.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 12:07:15 -0700 (PDT)
Message-ID: <d57d65b5-6ecf-48b3-a6de-4b1e2f5c643b@gmail.com>
Date: Tue, 14 May 2024 22:07:12 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/3] net/mlx4: support per-queue statistics
 via netlink
To: Joe Damato <jdamato@fastly.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca, nalramli@fastly.com,
 Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "open list:MELLANOX MLX4 core VPI driver" <linux-rdma@vger.kernel.org>
References: <20240513172909.473066-1-jdamato@fastly.com>
 <20240513172909.473066-4-jdamato@fastly.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20240513172909.473066-4-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/05/2024 20:29, Joe Damato wrote:
> Make mlx4 compatible with the newly added netlink queue stats API.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> ---
>   .../net/ethernet/mellanox/mlx4/en_netdev.c    | 73 +++++++++++++++++++
>   1 file changed, 73 insertions(+)


Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

