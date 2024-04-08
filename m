Return-Path: <linux-rdma+bounces-1830-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 253D489B98A
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 09:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D513628304C
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 07:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16DE2BB0A;
	Mon,  8 Apr 2024 07:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ra9z44Hb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C375741AAB;
	Mon,  8 Apr 2024 07:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712563081; cv=none; b=n+80KOv8ZNST4QjmWWhZw2VsdxIMOiXL+AmlPyRzJQCDobwaPiysDrDUjzht1e0m5Bz8N5ss9TslbP/DA0tDTmJd0RpWeiVTGRlmfyaOrKxR0e/oF8DpGBrq+PMyWKtnmBvAs/m547UdVzZRTgOAqEreeUY4qx7YxSvkAfd+Mr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712563081; c=relaxed/simple;
	bh=+uhqzDy5qlOrUvU/nqA86Tiln4pr6ByiMdPtGfHtXDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W8iv9DgXo6AOZoTeKSNQ6GqenFbTNr3PJxmGUzBD4MQnbVaq/7FofKADUOfmY0xC2cNlh6Nzc+9AqXpaPWNclJlpU00+wvjFWfSU3mSSgwq4pxr2meOpZg8+bUuUNZT84IbTnPQl3ppbMk/e5V5eN0UB/f+OyCwFng4ddcxVfUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ra9z44Hb; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4156c4fe401so26409585e9.1;
        Mon, 08 Apr 2024 00:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712563078; x=1713167878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6GNCcC4q4ot9rAXB3AfHhuJRy/iSMjoV2pWrDvWnFG4=;
        b=Ra9z44HbCvzkwIDYjGaIRMCezp0hubEi3XHWFn8+kwwNRv76rXRciVtZXzbWbR+I8v
         p5HwfQjAzLfV1iLksGkQDhfzu0FY63mljH85+SDAX81YzrLeB3oYlK32c/tRwX8abyCt
         TE/+/8/ZbbAUzH+VXFi4Rf+UWIFUAx5wN8d+cyPOcJIAOmHVVTEWPJA74nT3jqySHZ6q
         zZpN2xAc7eaDMjo4D71Lbg3q3SRdcS+ps0LeDCIez/B3jw3rU5bjsY7A2Yxf3/cFNx5c
         5+jqsthZHicxrvVtNlv307f552uAgmy5GgaEZCU11IXvrvkKDGfUhvlbsP8RFGjyc0rn
         ayqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712563078; x=1713167878;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6GNCcC4q4ot9rAXB3AfHhuJRy/iSMjoV2pWrDvWnFG4=;
        b=d4/t1UFi8pO00bNmFTQAA7SujtHMwoYfHdwPX4YoEd9Du8rDf3hfUUEuHcftZq6e5A
         dTw6yXrJGYkR+dgvoUAUyMMyeh1CXnJ9kQqv05pDSdbLWjxtXBM31M3h+l7Tq6D2Rvvx
         jXAZdqO6Rui89VssS5wxtlbso0HqznqA2nFhM808Q5IQ/OIAfy2fnwbH0rQfv1LfL2yZ
         lTVN6vAL0MCVE6fYF0Jn34nevoROZOLMraGKGsIXxVWC5jfoPaKlVFXa5khFbcgh0SQ5
         iU7o0YjDwYx0SmFmIj1qVX7jVHCcRYl4uvM7woa0lzAQ7YDY8yo/4nRgo6QBkHAF4Zh3
         2Pyg==
X-Forwarded-Encrypted: i=1; AJvYcCWlC8YINlgCkEZkOrE5mNRQfiqotG8BBZzrofs8Sq71/ORjcZZv2/yrb4e3zbCdrENfPaxrWjTvFOSMfFwnnIuuH0wNKW4KkB5iXcpJH2mQeGMMZ+YQx/M089O3Fu8F62GhKJUsX4AdMnZN+jEoWiU8SrNWAlYnBiB5s2L1ODMLfg==
X-Gm-Message-State: AOJu0YyIQVn8j+52Isa8H2CuYWJK2DTYgF29v+1bmrfN2bO/Vtwugr67
	MdtCe9OWYC/0O6EOlaUTRVts13FiPMUE3wRqE4eexjGHZ+nbrW8Q
X-Google-Smtp-Source: AGHT+IGeUCoflEgvEgJmyU4pUqwrvkM+YE15LAqZPJ29rbICVFCtmDJ+0sAHUmqbvwjYksqKVjjdiA==
X-Received: by 2002:a05:600c:3c84:b0:414:8c0d:8e53 with SMTP id bg4-20020a05600c3c8400b004148c0d8e53mr6123358wmb.8.1712563077996;
        Mon, 08 Apr 2024 00:57:57 -0700 (PDT)
Received: from [10.158.37.53] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id j15-20020a05600c190f00b004162b7af645sm14821951wmq.10.2024.04.08.00.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 00:57:57 -0700 (PDT)
Message-ID: <5a82fd99-a344-4a60-8ee1-baeb7c851596@gmail.com>
Date: Mon, 8 Apr 2024 10:57:06 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [v4] net/mlx5: fix possible stack overflows
To: Arnd Bergmann <arnd@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms@kernel.org>,
 Jiri Pirko <jiri@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>,
 Alex Vesker <valex@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240408074142.3007036-1-arnd@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20240408074142.3007036-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/04/2024 10:41, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A couple of debug functions use a 512 byte temporary buffer and call another
> function that has another buffer of the same size, which in turn exceeds the
> usual warning limit for excessive stack usage:
> 
> drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c:1073:1: error: stack frame size (1448) exceeds limit (1024) in 'dr_dump_start' [-Werror,-Wframe-larger-than]
> dr_dump_start(struct seq_file *file, loff_t *pos)
> drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c:1009:1: error: stack frame size (1120) exceeds limit (1024) in 'dr_dump_domain' [-Werror,-Wframe-larger-than]
> dr_dump_domain(struct seq_file *file, struct mlx5dr_domain *dmn)
> drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c:705:1: error: stack frame size (1104) exceeds limit (1024) in 'dr_dump_matcher_rx_tx' [-Werror,-Wframe-larger-than]
> dr_dump_matcher_rx_tx(struct seq_file *file, bool is_rx,
> 
> Rework these so that each of the various code paths only ever has one of
> these buffers in it, and exactly the functions that declare one have
> the 'noinline_for_stack' annotation that prevents them from all being
> inlined into the same caller.
> 
> Fixes: 917d1e799ddf ("net/mlx5: DR, Change SWS usage to debug fs seq_file interface")
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Link: https://lore.kernel.org/all/20240219100506.648089-1-arnd@kernel.org/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> [v4] Resend with Reviewed-by after the merge window closed
> [v3] no changes, sending again without a second patch
> [v2] no changes, just based on patch 1/2 but can still be applied independently
> ---
>   .../mellanox/mlx5/core/steering/dr_dbg.c      | 82 +++++++++----------
>   1 file changed, 41 insertions(+), 41 deletions(-)
> 

Acked-by: Tariq Toukan <tariqt@nvidia.com>

Thanks for your patch.


