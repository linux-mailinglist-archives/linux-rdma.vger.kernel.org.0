Return-Path: <linux-rdma+bounces-9405-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 406D5A87DFE
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 12:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 071803B4998
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 10:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661D727817B;
	Mon, 14 Apr 2025 10:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAfQUQ95"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4EF266EF3;
	Mon, 14 Apr 2025 10:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744627772; cv=none; b=gPLPHetTovTPXCooG4KzI56BxwwrErUtNaYK3o3eT3XsSjwyrRp4qwuZlNLO4XIk5nlB2N3rXRY+KWW0dluxUqOFNJVXrcw/IX2TGape3/tniq4C+LeBQpSM56xrk5B4uEB/FjQpvzPwpBm+uBr64Kpoi3EcyRdER1M2L0o6vx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744627772; c=relaxed/simple;
	bh=nej5Rxx/hhW9hddTky4aUeyep3bqcgBIkysf/UdzfYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E2id7Vj2I+wj/lk1DUizaV+7FCC65LNgnUPDVTKEVYdvs8gpC5XPq9v3Oy1YoQ0swmgAPnX4Xm2YreHdHbLnffgLdm6sBplde3zSjYPT8O2e+/XioWrVIwo87FLkNPvm3NY7eBYqyKmQnRzMWVKk0/ZV8hHUI67Nki9OfM1xioI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAfQUQ95; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39c266c1389so2791706f8f.1;
        Mon, 14 Apr 2025 03:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744627769; x=1745232569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xtsqEiOso+3ySVEpPpnY9tocZGrAQf6OsnV8IcNWh6c=;
        b=JAfQUQ95ZBinhpz2U9zyX1AQly7CMGuiKRcgWlH3z4eq30KdxvXVbIZbjlzW9QpVHy
         Tccpp+UdRPPavUGYSlWLypgIBGzle50IqBZiiG+EdvrwoGw+MjbG9cHuTCHoShs4GquV
         wTfjAsfLkVOBxNOA3IrksADszkXPkyJ8T8M8zvLdRKd6ELwmlreEdJ28O8jixWv6AAGC
         VBj3HMq4pS+3kkK9nfhObup6NXZQWSeP0f/YybJi4iJDDHBbllRQJxjsV0YWxWs7SEzo
         TqEyx8p3XgXdOPAaSzs+lE0AHad8/HBwOHwMIOMUKplSA2hByUvxGTyt4tuH4690DPX7
         MTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744627769; x=1745232569;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xtsqEiOso+3ySVEpPpnY9tocZGrAQf6OsnV8IcNWh6c=;
        b=caOOC0YjwoXZCgT8fCnBdJ8zHTirfYLxuEo0yCM2fyexsvwN9Xs6tEQuRBeqAIjiek
         6hMDBNPbQTgJqQNukeGXu1KkRxAohoy8nNB/q8ARNrXTMN4yhmGayj5sGOLa023OSoQF
         +SMcKu4k5A4UNntUNF/M4LUFyHx27iVkRNnyz9kk3jn+xL1k3aUUBL2odaLcqze/eMsL
         W+O9jnC0mvVGvU9pFCjFCmFbkUkrjTA/D0C1G9OfTO4Y0pAA4TzNf7iZST0/0LTlsqwH
         CWqelPYO9HDL0WPm0GqLrxsiqVpjSeZDGwWiqMUAPjOSRdC1nktAg/kcyTEQnD+TWuQU
         1MYw==
X-Forwarded-Encrypted: i=1; AJvYcCV1V+Vp+y+J51MMPYQ5eI/aScRqz54WPSVg8OZoU9ECig7itzo2Za26XC54KPX5sGbcI4Tx4M2GTaJIfrJV9Mg=@vger.kernel.org, AJvYcCV85zKzfYEGVRucjPiaWAJ1g11GsBcDgaE/8Utvf0XxLM1oRVM11++xRy9KLrvKlYidihUNRwvGvFuRKA==@vger.kernel.org, AJvYcCVnoodXbhPDLCjLDqkeAdRUwe5y9FBHQ/na9IrvjCRRHGrKEmPSHi/OA0P63JjYjbmJlAG6W6wA4iR0aeg=@vger.kernel.org, AJvYcCXOzKyB8ElX7lm5buQ1qESI/s31CVwac/IyoRvRJAzSSCA5bkjFOB6B5gvUFkik9WYroBm4cEzZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwaPcVLun0cX0u4yoj5apVnN1eEGQFPRwPv5+cy9UgPNJLar+5i
	FrTcXrlGW22rrAlrAQdf+fOvAuQdD10V1SsBLptB9+zZTt2OVUW/
X-Gm-Gg: ASbGnctUYzbQmJjSU7JvqHUoD/pIEIEPcEcCLuj3cQYO/0Sbr4CzmUDrClKFH1n94SH
	SUoElKPWv6teurKjDxkLIg0Kjk5S4Nw+zlPVOh/3PhdWQON4RrzGjGSfFwOL3XZ07OsZlTbGWis
	iEDL9uDg5XeD880mZlH8IFr272WBHRvrmel+rFdhNAMPRtCz8yyadC7CzB/mPivlr6iuOlrLeZV
	N2j/NznjXeMhX+U+ygMyETj5Ti6Tb1LsQCLV+/ym4EaWls4lPkTNlM08p2VCVF3wwmSCGxjgWFy
	x13B3NFg/+oaPncisIjnRwUBTl2BZqu/09EQv9OpQNzYN+CZ3F1PvEgGkY9/
X-Google-Smtp-Source: AGHT+IH1pMW+2VKVzwJ49w6Ztlv9YMJUN6W45Wwpzz8L92YImh1YeiCHahCGMNa6e6rsSObu5WtiCQ==
X-Received: by 2002:a5d:6da8:0:b0:39c:1424:3246 with SMTP id ffacd0b85a97d-39ea51d3527mr8524313f8f.2.1744627768500;
        Mon, 14 Apr 2025 03:49:28 -0700 (PDT)
Received: from [10.158.37.53] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf445772sm10695726f8f.91.2025.04.14.03.49.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 03:49:28 -0700 (PDT)
Message-ID: <f4a406e2-af98-4762-af44-9089440c0a7f@gmail.com>
Date: Mon, 14 Apr 2025 13:49:24 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 7/7] net/mlx5: Don't use %pK through tracepoints
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Jeff Johnson <jjohnson@kernel.org>, Loic Poulain <loic.poulain@linaro.org>,
 Brian Norris <briannorris@chromium.org>,
 Francesco Dolcini <francesco@dolcini.it>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>
Cc: ath10k@lists.infradead.org, linux-kernel@vger.kernel.org,
 ath11k@lists.infradead.org, ath12k@lists.infradead.org,
 wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org
References: <20250414-restricted-pointers-net-v1-0-12af0ce46cdd@linutronix.de>
 <20250414-restricted-pointers-net-v1-7-12af0ce46cdd@linutronix.de>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250414-restricted-pointers-net-v1-7-12af0ce46cdd@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 14/04/2025 11:26, Thomas Weißschuh wrote:
> In the past %pK was preferable to %p as it would not leak raw pointer
> values into the kernel log.
> Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
> the regular %p has been improved to avoid this issue.
> Furthermore, restricted pointers ("%pK") were never meant to be used
> through tracepoints. They can still unintentionally leak raw pointers or
> acquire sleeping looks in atomic contexts.
> 
> Switch to the regular pointer formatting which is safer and
> easier to reason about.
> There are still a few users of %pK left, but these use it through seq_file,
> for which its usage is safe.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/sf/dev/diag/dev_tracepoint.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>


