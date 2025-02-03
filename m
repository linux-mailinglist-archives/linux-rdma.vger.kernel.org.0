Return-Path: <linux-rdma+bounces-7381-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D824A265EA
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2025 22:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA7677A1AB1
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2025 21:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD8B20FA9A;
	Mon,  3 Feb 2025 21:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcICLaZO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8581E0B9C;
	Mon,  3 Feb 2025 21:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738619047; cv=none; b=cYlEkpcc1TF/MNdTx3xD7TdZauqQpemFkXGfGhsW2K1HDSGAGK4Qgmg+gIKrHn8QFEZEVPAqMH5d6C50LdKId7mPzfuq4ArQFmqUGNvVBMWUzoSRS8EOOcARrwhoOSTaC2HQPLVknu+Uz37F09w3R5AVwV98jApbBl0tGUwlEM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738619047; c=relaxed/simple;
	bh=kG5gWqhky0PrYjjLim/Ns9uwwVtbleCkG73Bv4Qq3fY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IAh7ZB1EQjUHyK2VJtV+nU34HFqxTmSMHKkO8WdKXJdbtPdDiTHxxDKyJl80SzyWkN6WMeutZx7nm481S2yFTBhgZ1VbMmWF4RNNtyQiCAt3Frh7KLWlsCf7SrUt2jWQadd6N4853ro4AlENCUYApr9omZ6RyDycGVYRhkVSALM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZcICLaZO; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab2aea81cd8so883016966b.2;
        Mon, 03 Feb 2025 13:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738619043; x=1739223843; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A1HmWishDsJHQAxosiDTBvuraFyn2SxUqlCZ+p7ZrEE=;
        b=ZcICLaZOmwvOJ0jf60VqNT/drm9clzk9p16gZChO5lcA5sE0kptlAn6Bjp0T3RX+F/
         zY/diSevnfZSzS7ISnVcYi7w0H/zThB2JHXF8P5R9jJ6GQQztpBwNmjaSw2gpH4JhN7i
         yn9rjlZZ+Nh1kGIZCpF/dsr0RSOz7ryIifc1PPQX4rwR9A1zDXo79f/X9xPXMHc3DpGe
         5CzPw37qEl4ts9Oli7Df1Q8xG2q5T/Pe7Ws9mjQAp5YOqGkyEFeujLXjahSZ/GRgOQft
         9mk2psoAPLw1OdTTbmVzVRUVrrwSu+xg344LK1PYQ7O/5Lwv9pKifSj1xSmtlUCa4j8x
         2KLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738619043; x=1739223843;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A1HmWishDsJHQAxosiDTBvuraFyn2SxUqlCZ+p7ZrEE=;
        b=QeoLOfwggwW6aBG3Ve8ODLwky28gLJD3DDBEAPf++v3zq50so6zQIFxwcbkv37fRWc
         yepm/G3WTyoJ5JOybmtaWyztotFispwG4crOBOYz/MaeYnTWeDe9w0Eh8BAcdpns63pK
         WgJERA4K3RTboxVvso1DEWvohHkR/oHx7v7rfeCSBwtXh2bjf8CKxaXOE3w3hiUvuYyT
         aqTxjdAcSF060EzQDZ0iHL7MFZd3Oneae2CKpukfGqknj+17lN4OFbut0KCORTfo75fz
         5qRhTHZJ0UJsYvAzGOKnWOJEDUtZA7ORTtc7NkO6QgCEqPx4+/76ItvVe3xXCb4NottN
         gtew==
X-Forwarded-Encrypted: i=1; AJvYcCV0ilfLDtfmCYAmlb3s7RMHv9nm8aBL+mf5e6VbBiABObjZEbMe1GMty1cp1jKrJ8UcLafCl063zIKccw==@vger.kernel.org, AJvYcCW4dC59pziWmko3/R+WUFazm/Hrc/3MrgTxBM1FNMcZHdMzV0frxCcfvOU54DXNXp/eB55WTCNHZ8fr5lE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTqh7GJCXLP2vRZP3UyXA6xY5JTfrt1aoVyi4N04ppUZX2YJMD
	a1SrRUSkJBTDYL8equgG9yCnqObIfdtnjSXbmQNoxOCstvlAh3+L
X-Gm-Gg: ASbGncv9sCkMeWwY+BjQvmN1uHLYQX1OQ+Oi38FlrndnMxR6GZim+Ebpr4UpDS3mWRG
	2w60HCR5pH73hZ0Y9mdq8zKxGmyJezXICPTJyCajESRWUwUENjGDBlQoBTmUjvWFLZUw/YX5yi/
	gk8gJ0nEBSuN+vyNKhsqVDS26lSTsZyR1Vck3wbGAgxwcpYLFunWvTUmaAQUnX261VoEP+KUmx8
	qVix/en3o7BkAQ4Aw6dChHkBlh7DpFiqeS58+fuFmDd2PhY/6zz+ttBKcQ4uHJyc1Hfi4yv28/O
	bAELQ+b25mgraJmigPjHgNLFnzA82ZYZ+r0H
X-Google-Smtp-Source: AGHT+IFuFbTSACYWjy5kMxtvtZWcUuiEE4RAYNbOEuQxZIzlPSBYkBdx9iOsXO5hO+XoOqvSelIgLQ==
X-Received: by 2002:a17:907:3dab:b0:aa6:7091:1e91 with SMTP id a640c23a62f3a-ab6cfcc6f11mr2852771366b.11.1738619043245;
        Mon, 03 Feb 2025 13:44:03 -0800 (PST)
Received: from [172.27.33.160] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47cfb98sm819589066b.61.2025.02.03.13.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 13:44:02 -0800 (PST)
Message-ID: <f25f3831-8e03-4225-8132-b486d989604e@gmail.com>
Date: Mon, 3 Feb 2025 23:44:00 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] mlx4: Remove unused functions
To: linux@treblig.org, tariqt@nvidia.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, yishaih@nvidia.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>
References: <20250203185229.204279-1-linux@treblig.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250203185229.204279-1-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/02/2025 20:52, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> The last use of mlx4_find_cached_mac() was removed in 2014 by
> commit 2f5bb473681b ("mlx4: Add ref counting to port MAC table for RoCE")
> 
> mlx4_zone_free_entries() was added in 2014 by
> commit 7a89399ffad7 ("net/mlx4: Add mlx4_bitmap zone allocator")
> but hasn't been used. (The _unique version is used)
> 
> Remove them.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
>   drivers/net/ethernet/mellanox/mlx4/alloc.c | 22 ----------------------
>   drivers/net/ethernet/mellanox/mlx4/mlx4.h  |  6 ------
>   drivers/net/ethernet/mellanox/mlx4/port.c  | 20 --------------------
>   include/linux/mlx4/device.h                |  1 -
>   4 files changed, 49 deletions(-)
> 

Thanks for your patch.

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Tariq

