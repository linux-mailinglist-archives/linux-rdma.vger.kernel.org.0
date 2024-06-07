Return-Path: <linux-rdma+bounces-2978-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 699E28FFD57
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 09:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8164283564
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 07:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDBF155C9E;
	Fri,  7 Jun 2024 07:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVmhyIzO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A655B154C17;
	Fri,  7 Jun 2024 07:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717746045; cv=none; b=lGoCZ+bUpgu8USR9Fo7Ot9a7frVmtWCG8bloMbWkWUKmHaPTOH09G3O33xxpnV1guLZcsUOG/PhlN2EOB2uGWqjCszAoD667eOD+KOmmp9qXJYy9ZhQf/kjrYpDQjK19K0Xa1H7GgP/9DyJLi3ugB1E8O0Q3n7FVfzJ8ErpX7SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717746045; c=relaxed/simple;
	bh=Gm3qXYT7sPdPu6m611tvaJ8w9yI0dFVyI6RzRJF+Wls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K6KcsscjmEmb8qSqpjLhEDn0HRAKhF3OF2JMgQvFkMGnAkGYh4OJWKam8dHsnDzjc/Wdj+rAY/DDjtl7pe0Egsg/2Y1GQKbpH+NSi01D6iqJZS9BfAVafwqxnhsQn11V/aGzl6+Qx/0xjSIQjz1RMUnKLhxakKFmz+r2VHrN5DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVmhyIzO; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52bbf73f334so178657e87.2;
        Fri, 07 Jun 2024 00:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717746042; x=1718350842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AS72jLuSxBJ0gHW3RNFPmyDKK389zQityL0CcC1+x9A=;
        b=RVmhyIzOCdbRYr4jOZjChMeW8rFDoiET8bTmfs9uOne2caYcP2MTTINqLQu6UN91+H
         X+RVSQ5myYvW6COLrdtA0DlyxzQwEKPEJg3RgP2Dq4l8vOAwCQ9eFJwPGf4atcQeat7H
         UOjTqEgl/eo0glQ5o2rjDAdDd3/Kq4cME++QgM9HM8+VPLMxnFHQ6jENmP9a3vVKa6OC
         O9O/7mXZ7sZHGM0cVViykEc//vE7oiltFNShCGlYfYROiFVD9tSqOfKheUG3h984M4lN
         q0it7qRN6mNiM4B4UhG+9iq4u+C60hKYD6b78Q70Rkp0+HqHsfaTzD+g9LiMEZoHCjZC
         Qvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717746042; x=1718350842;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AS72jLuSxBJ0gHW3RNFPmyDKK389zQityL0CcC1+x9A=;
        b=LL4mR5x5sFvFZr1BM+XVqIKbxRlsel6/k/og2fvx6uJkzKWGSGjsSbcV+HRBhCF7cR
         gkZKA8yzaPzU35Va/KWfCjAlcJxWgC0aFhfR067+wTgx23L5B7Q2f9dcM/NUfE6IVnIA
         X2QMx2gsfRK8lCxIGzB4b945nwu+WbD/ii9q9gMxpzuR7dvidxmLv6lcSYgdU5owFhu9
         zzNhwIa36XhGZPV4s1r9K1G9B4PTKNMXxyLCSR0Hnd2UvoEMU8HUSbIg6aQ6h3Z0RXY7
         xipcu/KlyIt8i+6D09/3HYc4RqbrllsGILM4z6iAo8C3i9Ejqp5RDqPedCoNfM2IDYvC
         vXGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQUd0Ob2/PTr4YepiLFrUhA9A+EjE7IQzD62XDuX6q0PXbCZWNp8jMmIgJ37KIus4i3Gwcwpbo+iJmoAG8ly0Dktu4uc5OiVnhljYEqvR3vcOPTfsfPxhtO0mMCgWOrNZsG3PnkHUiKdYNVUk/j4RRFenWkLr2+zFEW7IK34TvXg==
X-Gm-Message-State: AOJu0YwiTiISmVc9bKFI63DQHOhqO1W0GBMJw/DSq0UkRPAukrxv1u0F
	uV5c17PF0ElsferYHF2pj/450qQ3zNZ6As9x6pRSIelxSqD5PcSF
X-Google-Smtp-Source: AGHT+IE145ugTmfzMkGbBgDc4EskumPPJu4aSr9T8VWy7YFERUgYNQr8opMDit+pmllO3+UDYOOu9w==
X-Received: by 2002:ac2:4a9c:0:b0:52b:844f:dd10 with SMTP id 2adb3069b0e04-52bb9f83a84mr1115177e87.40.1717746041445;
        Fri, 07 Jun 2024 00:40:41 -0700 (PDT)
Received: from [172.27.33.107] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215811d13esm76100585e9.24.2024.06.07.00.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 00:40:41 -0700 (PDT)
Message-ID: <15007808-b5b1-441c-9a20-94195330b245@gmail.com>
Date: Fri, 7 Jun 2024 10:40:38 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v4 2/2] net/mlx5e: Add per queue netdev-genl stats
To: Jakub Kicinski <kuba@kernel.org>, Joe Damato <jdamato@fastly.com>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>, netdev@vger.kernel.org,
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
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20240606171942.4226a854@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 07/06/2024 3:19, Jakub Kicinski wrote:
> On Thu, 6 Jun 2024 14:54:40 -0700 Joe Damato wrote:
>>>> Compare the values in /proc/net/dev match the output of cli for the same
>>>> device, even while the device is down.
>>>>
>>>> Note that while the device is down, per queue stats output nothing
>>>> (because the device is down there are no queues):
>>>
>>> This part is not true anymore.
>>
>> It is true with this patch applied and running the command below.
>> Maybe I should have been more explicit that using cli.py outputs []
>> when scope = queue, which could be an internal cli.py thing, but
>> this is definitely true with this patch.
>>
>> Did you test it and get different results?
> 
> To avoid drivers having their own interpretations what "closed" means,
> core hides all queues in closed state:
> 
> https://elixir.bootlin.com/linux/v6.10-rc1/source/net/core/netdev-genl.c#L582
> 

Oh, so the kernel doesn't even call the driver's 
mlx5e_get_queue_stats_rx/tx callbacks if interface is down. Although our 
driver can easily satisfy the query and provide the stats.

I think the kernel here makes some design assumption about the stats, 
and enforces it on all vendor drivers.
I don't think it's a matter of "closed channel" interpretation, it's 
more about persistent stats.
IMO the kernel should be generic enough to let both designs (persistent 
and non-persistent stats) integrate naturally with this new queue 
netdev-genl stats feature.

>>> PTP RQ index is naively assigned to zero:
>>> rq->ix           = MLX5E_PTP_CHANNEL_IX;
>>>
>>> but this isn't to be used as the stats index.
>>> Today, the PTP-RQ has no matcing rxq in the kernel level.
>>> i.e. turning PTP-RQ on won't add a kernel-level RXQ to the
>>> real_num_rx_queues.
>>> Maybe we better do.
>>> If not, and the current state is kept, the best we can do is let the PTP-RQ
>>> naively contribute its queue-stat to channel 0.
>>
>> OK, it sounds like the easiest thing to do is just count PTP as
>> channel 0, so if i == 0, I'll in the PTP stats.
>>
>> But please see below regarding testing whether or not PTP is
>> actually enabled or not.
> 
> If we can I think we should avoid making queue 0 too special.
> If someone configures steering and only expects certain packets on
> queue 0 - getting PTP counted there will be a surprise.
> I vote to always count it towards base.

+1, let's count PTP RX in the base, especially that it has no matching 
kernel-level rxq.

Another option is to add one more kernel rxq for it (i.e. set 
real_num_rx_queues to num_channels + 1). But, that would be a bigger 
change, we can keep it for a followup discussion.

