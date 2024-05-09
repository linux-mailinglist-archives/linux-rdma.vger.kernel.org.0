Return-Path: <linux-rdma+bounces-2371-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 873F18C0E0E
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 12:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15EE01F21E49
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 10:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1528814B082;
	Thu,  9 May 2024 10:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxmUVVIu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42818D528;
	Thu,  9 May 2024 10:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715249780; cv=none; b=sO+R/vu5cKbSivdboQifYV4BBMLj+38bdsFJS7ba5CslO2oXhNj9UDziUiYKqFBPGW7bd06Urui1e0tB8qmwWlKywCApuLFDIPDEyv4o0kMsoQl/snbpnpUkArGmTmSMSYqU7mmZtEloZOHKgee+Fs4DFxUE2lNcDrgUsrkPgCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715249780; c=relaxed/simple;
	bh=881zudWU6qfyucZG14Pc4Iu4wKaVIbgiMZki3Pu9CRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T1jQmk+HMsAFO93ZUwGsSQtYIcoUDvsiQ6wiCByHrYeOOP5lHhXGLf6+f/lGN2U3FPf0S4MaxVI2xrJamUJXvopjdOcV+eK+tpouJT2O2OF5OzSo8AmBIlkhky1/PikGWrG0O2RThKw6dke8YbhK4HorufZ9Erb++y5Y/tnVfuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxmUVVIu; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a5a1054cf61so161414266b.1;
        Thu, 09 May 2024 03:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715249777; x=1715854577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5I6sdfeuhGDQZEJYpwbwlRvLcoIJyVZFCXAeHmKIg6Q=;
        b=RxmUVVIuw8gB2wvTb3DD7gEcMwpzhLX7cpI6vBeP+GPp+yuboH2udiL1Ah5eWtADDm
         O9BS1TxqoZWxU3SlqTVy/b4w/ftsbrjvprB5c+eem4bgdqQtM6tmrPcUHWiPrWxdfpeI
         gWSA3ywx4PNJo1o3o6UXyajQK5LC9fxDAzAWEqteJw35o97SDRvKTGnZfWeflSoy6exq
         X9V3ZA1gxHMqpfE8ur6SJz/u9zAB/oHuLIBzqD4fySw0z8YQOlQxZVplTeKUmq+/8hb3
         TZmY7abJYNsTfEusTr9gibifJM6TlApTwdjRYwkkrnEaRxmWhuMRlNbNwZg7bSpbckHZ
         VYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715249777; x=1715854577;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5I6sdfeuhGDQZEJYpwbwlRvLcoIJyVZFCXAeHmKIg6Q=;
        b=t9xfnpW5xSvor6OhbPLQvsqm0BrVG/urVttWKJkEM+iI6i4wtMCao3zNFRkeD7CiRi
         iX4LXAaxCZ5xwaWNOO7XXeVai8jWWgLbI0OZqR7x6HGNdQUvL3TM9cchvxPd+0puhKtH
         un6qgxH/FC+lmHXgW6w+I3M89BqbNSx4PPhpHniC6Ig9izHa3m87Y5JW95lTGCDAvaTQ
         3Adoz2IYQLTR3YrgkdYRGU6rS60oedtLIVFN9uYQ35I+hF+xHOk8ykfr0c8axyqYW0F/
         9UtF5nLbM4+l1tkscr5yHABFxBf6oac7Ohz23Tuul3az5+tzIcdKLPqDfIedV9KkJ3M/
         24hw==
X-Forwarded-Encrypted: i=1; AJvYcCUr3NOs21By4VhoNADb+6X/GYHdiAHfFI6GIaNGkBEF+LQZPzmui2agj22YGqhXc34EzYDqbbqLPWjALMw0idfcqERPiVYA5eVEZyN7BGXNAMa2QJQ8kh7rnfmh/eNh41U3Wav13BH+sWP4Em7y1IPSxFgsfLlMedlM66ezTwX9LA==
X-Gm-Message-State: AOJu0YwQSaef48JVuutKv06rqVXlvxftonviyuThMkBrQIP/BLsQ+n1u
	QjUEbBq0XG8ges/xn3g+w+BxmVi+YKqYmQq7lBPnxfefOoyfPryil5vdHg==
X-Google-Smtp-Source: AGHT+IFKm8dFeKHTx6sWWFxm9MrFf3naXL6aZ59huxIUKNrPdiep+ncOyjwbUnW526jrZm80z8G/xg==
X-Received: by 2002:a50:8d17:0:b0:571:bed1:3a36 with SMTP id 4fb4d7f45d1cf-5731da9adbdmr4789496a12.38.1715249777220;
        Thu, 09 May 2024 03:16:17 -0700 (PDT)
Received: from [172.27.51.192] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bed2059sm543028a12.56.2024.05.09.03.16.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 03:16:16 -0700 (PDT)
Message-ID: <32495a72-4d41-4b72-84e7-0d86badfd316@gmail.com>
Date: Thu, 9 May 2024 13:16:15 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/1] mlx5: Add netdev-genl queue stats
To: Joe Damato <jdamato@fastly.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>, Zhu Yanjun
 <zyjzyj2000@gmail.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, saeedm@nvidia.com, gal@nvidia.com,
 nalramli@fastly.com, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Leon Romanovsky <leon@kernel.org>,
 "open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>
References: <ZjUwT_1SA9tF952c@LQ3V64L9R2> <20240503145808.4872fbb2@kernel.org>
 <ZjV5BG8JFGRBoKaz@LQ3V64L9R2> <20240503173429.10402325@kernel.org>
 <ZjkbpLRyZ9h0U01_@LQ3V64L9R2>
 <8678e62c-f33b-469c-ac6c-68a060273754@gmail.com>
 <ZjwJmKa6orPm9NHF@LQ3V64L9R2> <20240508175638.7b391b7b@kernel.org>
 <ZjwtoH1K1o0F5k+N@ubuntu> <20240508190839.16ec4003@kernel.org>
 <ZjxtejIZmJCwLgKC@ubuntu>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <ZjxtejIZmJCwLgKC@ubuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/05/2024 9:30, Joe Damato wrote:
> On Wed, May 08, 2024 at 07:08:39PM -0700, Jakub Kicinski wrote:
>> On Thu, 9 May 2024 01:57:52 +0000 Joe Damato wrote:
>>> If I'm following that right and understanding mlx5 (two things I am
>>> unlikely to do simultaneously), that sounds to me like:
>>>
>>> - mlx5e_get_queue_stats_rx and mlx5e_get_queue_stats_tx check if i <
>>>    priv->channels.params.num_channels (instead of priv->stats_nch),
>>
>> Yes, tho, not sure whether the "if i < ...num_channels" is even
>> necessary, as core already checks against real_num_rx_queues.
>>
>>>    and when
>>>    summing mlx5e_sq_stats in the latter function, it's up to
>>>    priv->channels.params.mqprio.num_tc instead of priv->max_opened_tc.
>>>
>>> - mlx5e_get_base_stats accumulates and outputs stats for everything from
>>>    priv->channels.params.num_channels to priv->stats_nch, and
>>
>> I'm not sure num_channels gets set to 0 when device is down so possibly
>> from "0 if down else ...num_channels" to stats_nch.
> 
> Yea, you were right:
> 
>    if (priv->channels.num == 0)
>            i = 0;
>    else
>            i = priv->channels.params.num_channels;
>    
>    for (; i < priv->stats_nch; i++) {
> 
> Seems to be working now when I adjust the queue count and the test is
> passing as I adjust the queue count up or down. Cool.
> 

I agree that get_base should include all inactive queues stats.
But it's not straight forward to implement.

A few guiding points:

Use mlx5e_get_dcb_num_tc(params) for current num_tc.

txq_ix (within the real_num_tx_queues) is calculated by c->ix + tc * 
params->num_channels.

The txqsq stats struct is chosen by channel_stats[c->ix]->sq[tc].

It means, in the base stats you should include SQ stats for:
1. all SQs of non-active channels, i.e. ch in [params.num_channels, 
priv->stats_nch), tc in [0, priv->max_opened_tc).
2. all SQs of non-active TCs in active channels [0, 
params.num_channels), tc in [mlx5e_get_dcb_num_tc(params), 
priv->max_opened_tc).

Now I actually see that the patch has issues in mlx5e_get_queue_stats_tx.
You should not loop over all TCs of channel index i.
You must do a reverse mapping from "i" to the pair/tuple [ch_ix, tc], 
and then access a single TXQ stats by priv->channel_stats[ch_ix].sq[tc].

> Adding TCs to the NIC triggers the test to fail, so there's still some bug
> in how I'm accumulating stats from the hw TCs.

