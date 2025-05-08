Return-Path: <linux-rdma+bounces-10172-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E84D5AB0564
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 23:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D3C91C042A4
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 21:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCB3221F1A;
	Thu,  8 May 2025 21:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEIlSdoq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8966915A848;
	Thu,  8 May 2025 21:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746739861; cv=none; b=iGc9he20/5RJK7Eejhs7VmdhGfOoOb9QdTShgmuGDKRFeGKtQAUsYmXVPgRdd6z0YYJev8TSP5ty0/O6BXVwrKO6Xm/3yp11hmNq7o39XdZo9+J3hcmIV93d2Rd1NJTHGV2N7G9ttph7T+VZBFRh63SugflP1cWn6O7TZq/1+2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746739861; c=relaxed/simple;
	bh=JTHLtY0ld8a6BH5xxbR1r5sxYQvJPYy22w1ADwLVN04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dXZeLkwbCxv71zNVKAnUtp7sbbnvCYNbioteUX0e2ehQkGSOPNPVOGWidYjGesd/z1rLC00l5Iy4dMA9axD0Cyn26ggL0C7kSYRQUTJfvCLqonV61B/oq3eJFPqgUkPmB5vX/JGImOdDiOFEj3Wwr1U+j3he/NtQ+BMgW3QpvGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEIlSdoq; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-acec5b99052so252016466b.1;
        Thu, 08 May 2025 14:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746739858; x=1747344658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bsh/GPZb/TiZg30RyOqrw2DkOqfcNkWV+XjxsFUC3/A=;
        b=gEIlSdoqha38XQqFzSkTf/9LDDYWOGAaZCrMJoSTv6tsDJo2C2eEHHrAh35DAQoW44
         PGokWCt6ZLl3EsTTt4ZibcHluDK/AaphAHITDdNjeJ1zwjjfplsq38fApwWq87UzSoel
         uRvl0hTlRMCGlO+mXr1y/Buwcw8qNjXuj6eR96IaBJRTErBf2KpwjWHZuVSPIPezoWdO
         d5TnUgwBxnrCHqQStz78N2KUIMyvyYWn9JOHXDAblckh6+hXOCcGkwFT4hTVp6yC1jDO
         1G8ohJUnyUklY3+buKNgj0csc5ouSb1uZJjsyB3oXQMxHa9WzDGPK/TDb3wL2niRa00H
         tijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746739858; x=1747344658;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bsh/GPZb/TiZg30RyOqrw2DkOqfcNkWV+XjxsFUC3/A=;
        b=sLDPQzb4dqml1llHoYfW0rWY/6NbPwZYGZc6tLxJiBQw8s3cq3qPnMeLZCitzZ+3YE
         P9WF4QPhN9HJ331JqO7Je0dsHP7x5b5PDEjf0g8SlZS4mPNStAVDW2OhaAWll0aj4Tjk
         E+GILBtJatpD0FQ6V6YdxmGvPitl6p75FRx0RM6YVxZRfUQn28U8OBtqM2VMKEuGbk/3
         Sj6ZGHnptFB37oeDHhuUiiNpASHdt/Wc4MvMIx/cwIVdtoGjupR07GtnJGKKGjdAegJE
         ujvBRxMgFTRC9VLpYWVRqkND3TScUkjzDTJtLe6Tr/ihpIYn4hBqSWeRQJ65GDYxlw78
         13/A==
X-Forwarded-Encrypted: i=1; AJvYcCX7B7rEr1/bKN0D7l3qTdeOTnHtFx9j2ASjq1AKVf13vN0FSTKE/C9wn+FJONgIBX9alyUzJy6Gw3Lxlg==@vger.kernel.org, AJvYcCXZcBucIkEqMcwPCHVNGHcMzwwBC6s8IxpwBCFOg2KsZIIYf6Qny2cp109jBNHy1rRCJ2Bmn1XkTZQGPiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVTMshFH8rk9tZFVFMcIS89VMcYwAg0cb1j+5AoHVckbH2XbbW
	M6L/JFNopDqsCZ2XLztqqrnwIFCWMr/NKwA5UnuBpDsJs6O+OD6+
X-Gm-Gg: ASbGncsPfyelbirD0cEBuh9lyDNAPEv+yGRZPXKORYQ+EMAbBbS6lmW7DXW61lzFfwk
	wdRYYNI9VHdCCidAeGwnnFQY8NVqMuCxqlLxK3O+gnebLYLLc0jWYfx+GMRADcbYX8sWTyU7cjr
	tPEmjyFgogGRketoWF5r0U8RhrxWXkaOMTDJ4lc0vSOA/G45Q/CJmIrlKmKVabUp3xwWjR/VTWw
	5UA1/Gjg8vBqWfEp5gFXOgb1Nobr1O1wwK7Z1oazRhYCbEAIA9acYxBgNg8KVq2I4uip89bt+Sb
	rfu8lkEMZn7Xw61I4MPgI84cChnwZs2VIe+1JGrxCw+dFz2mqUluUqoq0Kd3
X-Google-Smtp-Source: AGHT+IHQvMuJCDoH7Bs9mWvrUVeR5FXNog6hLVAgx/pJfBFrMIGxgzNimQ4Xt+0VHn69QHSLo+ILeQ==
X-Received: by 2002:a17:906:f58a:b0:ad1:fd0f:a0b5 with SMTP id a640c23a62f3a-ad219101a0cmr99666666b.30.1746739857311;
        Thu, 08 May 2025 14:30:57 -0700 (PDT)
Received: from [172.27.55.78] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2192cf5casm46220266b.2.2025.05.08.14.30.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 14:30:56 -0700 (PDT)
Message-ID: <39c21e55-4aeb-4935-ab8a-759d97662ec3@gmail.com>
Date: Fri, 9 May 2025 00:30:54 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5: support software TX timestamp
To: Stanislav Fomichev <stfomichev@gmail.com>,
 Jason Xing <kerneljasonxing@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, leon@kernel.org,
 Carolina Jubran <cjubran@nvidia.com>
References: <20250506215508.3611977-1-stfomichev@gmail.com>
 <1a1ab6eb-9bfc-4298-ba1e-a6f4229ce091@gmail.com>
 <CAL+tcoDu0NdZQ+QmqL9mF8VNj+4cPLgmy1maAucAc7JkKOjm6A@mail.gmail.com>
 <aBzaK8I0hA31ba_4@mini-arch>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <aBzaK8I0hA31ba_4@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 08/05/2025 19:22, Stanislav Fomichev wrote:
> On 05/08, Jason Xing wrote:
>> Hi Tariq,
>>
>> On Thu, May 8, 2025 at 2:30 PM Tariq Toukan <ttoukan.linux@gmail.com> wrote:
>>>
>>>
>>>
>>> On 07/05/2025 0:55, Stanislav Fomichev wrote:
>>>> Having a software timestamp (along with existing hardware one) is
>>>> useful to trace how the packets flow through the stack.
>>>> mlx5e_tx_skb_update_hwts_flags is called from tx paths
>>>> to setup HW timestamp; extend it to add software one as well.
>>>>
>>>> Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
>>>> ---
>>>>    drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 1 +
>>>>    drivers/net/ethernet/mellanox/mlx5/core/en_tx.c      | 1 +
>>>>    2 files changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
>>>> index fdf9e9bb99ac..e399d7a3d6cb 100644
>>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
>>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
>>>> @@ -1689,6 +1689,7 @@ int mlx5e_ethtool_get_ts_info(struct mlx5e_priv *priv,
>>>>                return 0;
>>>>
>>>>        info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
>>>> +                             SOF_TIMESTAMPING_TX_SOFTWARE |
>>>>                                SOF_TIMESTAMPING_RX_HARDWARE |
>>>>                                SOF_TIMESTAMPING_RAW_HARDWARE;
>>>>
>>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
>>>> index 4fd853d19e31..f6dd26ad29e5 100644
>>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
>>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
>>>> @@ -341,6 +341,7 @@ static void mlx5e_tx_skb_update_hwts_flags(struct sk_buff *skb)
>>>>    {
>>>>        if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
>>>>                skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
>>>> +     skb_tx_timestamp(skb);
>>>
>>> Doesn't this interfere with skb_tstamp_tx call in the completion flow
>>> (mlx5e_consume_skb)?
>>
>> skb_tstamp_tx() only takes care of hardware timestamp in this case.
>>
>>>
>>> What happens if both flags (SKBTX_SW_TSTAMP / SKBTX_HW_TSTAMP) are set
>>> Is it possible?
>>
>> If only these two are set, only hardware timestamp will be passed to
>> the userspace because of the SOF_TIMESTAMPING_OPT_TX_SWHW limit in
>> __skb_tstamp_tx().
>>
>> If users expect to see both timestamps, then
>> SOF_TIMESTAMPING_OPT_TX_SWHW has to be set.
> 
> Right, skb_tx_timestamp does nothing and bails out if it detects
> SKBTX_IN_PROGRESS. And skb_tstamp_tx in mlx5e_consume_skb handles
> only (and will trigger only for) HW tstamp case.

I see.
Patch LGTM, except for the function name nit, pointed out in an earlier 
comment.
We could remove the "hw" from function name mlx5e_tx_skb_update_hwts_flags.

