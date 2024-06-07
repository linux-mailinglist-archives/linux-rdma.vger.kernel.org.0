Return-Path: <linux-rdma+bounces-2980-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3007C8FFD92
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 09:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA756285FA6
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 07:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859D515A86B;
	Fri,  7 Jun 2024 07:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJHjTh5G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38331C2AF;
	Fri,  7 Jun 2024 07:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717746842; cv=none; b=DsmDfEnlM/eOrzqje1Odmp0MMq+msMTR2TvH05oUmEsl9nFbpSM26vECs9xJzylEGNQjXI6IxfAhr1/PrkVVulOWyUD8rImtuGwZ3ayiBW8V+dp390fk30wx3km2pjnM25WO2SzfMLyxxBUrvkHt0/6olpZk7jWrjAx+NxxOnn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717746842; c=relaxed/simple;
	bh=RwvpPr3bZtIcVDK98m1UdTQjpXUECPEIZKoMiKr39p0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mA9PXQj4dHX/eyT4vddBgC87gewK7LYcPwN3CCU+7NMcDbXOaN3hDHQCm1z9lmcLR+IKUCBDzxadCLRoldy/eEFIn+HqBjr1zXgsTCCY4tWQ9Ie81vanxVzxdqIswfFjj8R+a5sdOsfg3kYsjdjHYtesps9UnnpmMRKvU1+hPv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJHjTh5G; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4210aa00c94so16996225e9.1;
        Fri, 07 Jun 2024 00:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717746839; x=1718351639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fGtrfVkEldm/Tp2dI+OgyNdoMT3uZ1fT1eSIIAagWZs=;
        b=dJHjTh5GTEP3lKzTgZ4TdN2SrNET8hy+3VkWY2ttFXBT1If0/vCCx3BMb82iV7YHtT
         9rJh363kTKGElk8POTd52qwn9KEexHZF4WW1/P2snYuMP0EqFvRMX7NN1XOwky829D5S
         5kRiNf0LORY5PnZZaQSwuudGafKYCSDLx76gSQ+hAxZB1oWHel+uSpkTF+xxjddLieK2
         t/nJxQTWK4PjOmtLNYsO2KsH3rAlKtWIQ8zTZwKhOKPaPuHOFYkWk/Y9SGQMkcCDdAZ1
         A+vCf3GCa+zWjyEAeNKKljC2bnLFBzm8mpWzJ5pGga1/Rc/2kn5oH8jVJhCgv06eQdtx
         iOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717746839; x=1718351639;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fGtrfVkEldm/Tp2dI+OgyNdoMT3uZ1fT1eSIIAagWZs=;
        b=mYrZBA/h2/cgTGlKpAbbYnTXTDYwgQPvbuIq5lHp1IBQ8Mjy7ET2mL2Fls2uhF2nLE
         Ihfe2mFCc7LA8Cee+feZmTtfHpMoN3Bu3mQpvj5d4Do1bHlh+fgvKceylt4ZXeCNYNvL
         uKpXiUDQK/o0XHrwKktkLgFqXlhyUZxizcx1o0BK0BndQ4UyVniaCDyo5xQjWoFY5M5+
         iDB162QmKK55EHIghL8acpoNheRBDPfB3v7ybxK/Y3d9JFLV0n3dHjvYigAjogjP2W+Q
         MLFLGVMIpKttAnua7tCCitqYvqKOGvfrs49EWZHGKVLo3ZrETUEwZhtsNCNLpfBXg2op
         Raqw==
X-Forwarded-Encrypted: i=1; AJvYcCXe6/e//5sLAjuOFFNEh+vy0WZTMXXlimg8gnNO3CJilTf77q4hbkj0h+g3AyXidIeDi94pfLd/vBgTH0IZvZtnBaml2PxMBHHrrykPIh0WBkAgtbwhbP5VnwMFm8xrki0deBlRolisuLi1p7u4rBm9JtOyyzRSB7yEe1yUfxuyrA==
X-Gm-Message-State: AOJu0YwvefY7Y42+RsXsFXjE81X+Ej/fRpRh4OobtGPTp2BGKDqCadfg
	9+74MDy+MxYXdiQfuyc04M7VQ5rfA+/Hb8reXNpFqeslCqkUbSH3
X-Google-Smtp-Source: AGHT+IH9c8AhBKZVNPTxzNO5koOgJy0uwn1cRU8GIz8p1fKKNqcTqAlSgDII6tUtqjHRN/9kit8feQ==
X-Received: by 2002:a5d:55c9:0:b0:355:1ae:cec3 with SMTP id ffacd0b85a97d-35efee32edcmr1187216f8f.60.1717746838697;
        Fri, 07 Jun 2024 00:53:58 -0700 (PDT)
Received: from [172.27.33.107] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d2f289sm3407491f8f.19.2024.06.07.00.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 00:53:58 -0700 (PDT)
Message-ID: <fd788395-c936-49cf-a85d-d39d1d055131@gmail.com>
Date: Fri, 7 Jun 2024 10:53:55 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v4 2/2] net/mlx5e: Add per queue netdev-genl stats
To: Joe Damato <jdamato@fastly.com>, Jakub Kicinski <kuba@kernel.org>,
 Tariq Toukan <ttoukan.linux@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, nalramli@fastly.com,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 "open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>
References: <20240604004629.299699-1-jdamato@fastly.com>
 <20240604004629.299699-3-jdamato@fastly.com>
 <11b9c844-a56e-427f-aab3-3e223d41b165@gmail.com>
 <ZmIwIJ9rxllqQT18@LQ3V64L9R2> <20240606171942.4226a854@kernel.org>
 <ZmJcEM7brxivyDUV@LQ3V64L9R2>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <ZmJcEM7brxivyDUV@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/06/2024 4:02, Joe Damato wrote:
> On Thu, Jun 06, 2024 at 05:19:42PM -0700, Jakub Kicinski wrote:
>> On Thu, 6 Jun 2024 14:54:40 -0700 Joe Damato wrote:
>>>>> Compare the values in /proc/net/dev match the output of cli for the same
>>>>> device, even while the device is down.
>>>>>
>>>>> Note that while the device is down, per queue stats output nothing
>>>>> (because the device is down there are no queues):
>>>>
>>>> This part is not true anymore.
>>>
>>> It is true with this patch applied and running the command below.
>>> Maybe I should have been more explicit that using cli.py outputs []
>>> when scope = queue, which could be an internal cli.py thing, but
>>> this is definitely true with this patch.
>>>
>>> Did you test it and get different results?
>>
>> To avoid drivers having their own interpretations what "closed" means,
>> core hides all queues in closed state:
>>
>> https://elixir.bootlin.com/linux/v6.10-rc1/source/net/core/netdev-genl.c#L582
>>
>>>> PTP RQ index is naively assigned to zero:
>>>> rq->ix           = MLX5E_PTP_CHANNEL_IX;
>>>>
>>>> but this isn't to be used as the stats index.
>>>> Today, the PTP-RQ has no matcing rxq in the kernel level.
>>>> i.e. turning PTP-RQ on won't add a kernel-level RXQ to the
>>>> real_num_rx_queues.
>>>> Maybe we better do.
>>>> If not, and the current state is kept, the best we can do is let the PTP-RQ
>>>> naively contribute its queue-stat to channel 0.
>>>
>>> OK, it sounds like the easiest thing to do is just count PTP as
>>> channel 0, so if i == 0, I'll in the PTP stats.
>>>
>>> But please see below regarding testing whether or not PTP is
>>> actually enabled or not.
>>
>> If we can I think we should avoid making queue 0 too special.
>> If someone configures steering and only expects certain packets on
>> queue 0 - getting PTP counted there will be a surprise.
>> I vote to always count it towards base.
> 
> I'm OK with reporting PTP RX in base and only in base.
> 
> But, that would then leave PTP TX:
> 

Right, currently there's no consistency between the PTP RX/TX 
accountment in real_num_queues.
I don't want to create more work for you, but IMO in the longterm I 
should follow it up with a patch that adds PTP-RX to real_num_rx_queues.

> PTP TX stats are reported in mlx5e_get_queue_stats_tx because
> the user will pass in an 'i' which refers to the PTP txq. This works
> fine with the mlx5e_get_queue_stats_tx code as-is because the PTP
> txqs are mapped in the new priv->txq2sq_stats array.
> 
> However.... if PTP is enabled and then disabled by the user, that
> leaves us in this state:
> 
>    priv->tx_ptp_opened && !test_bit(MLX5E_PTP_STATE_TX, channels.ptp->state)
> 
> e.g. PTP TX was opened at some point but is currently disabled as
> the bit is unset.
> 
> In this case, when the txq2sq_stats map is built, it'll exclude PTP
> stats struct from that mapping if MLX5E_PTP_STATE_TX is not set.
> 
> So, in this case, the stats have to be reported in base with
> something like this (psuedo code):
>   
>    if (priv->tx_ptp_opened &&
>       ! test_bit(MLX5E_PTP_STATE_TX, channels.ptp->state)) {
>        for (tc = 0; tc < priv->channels.ptp->num_tc; tc++) {

Do not take num_tc from here, this ptp memory might not exist at this point.
Calculate it the regular way with max_opened_tc.

>           tx->packets += ...ptp_stats.sq[tc].packets;
>           tx->bytes += ...ptp_stats.sq[tc].bytes;
>        }
>    }
> 
> Right? Or am I just way off here?

