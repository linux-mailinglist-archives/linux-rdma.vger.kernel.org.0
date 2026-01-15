Return-Path: <linux-rdma+bounces-15594-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65832D263C0
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jan 2026 18:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6AC863040F7C
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jan 2026 17:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B3B3BFE29;
	Thu, 15 Jan 2026 17:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mt1r2nl5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60283BF2FF
	for <linux-rdma@vger.kernel.org>; Thu, 15 Jan 2026 17:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497068; cv=none; b=mH86aDxzyNtD1HpHaRP3jcGcqMxV6oV4pjlIqP80EyUao0nBjiW3DVTu+dg0GtFHefvHDfFdN1wRmANkAfnyv48X4ggbrQMc67JtE7eZmaxYhi/BXxvk5tcsJ8iHSNy80ZzJa25IQiq6/SDmc4EIpMLEobHiZaaoAZmA6erYwRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497068; c=relaxed/simple;
	bh=z5fuYqtywwL6KOIHKbWzEHmAdjuqly6oA3cwR7sT8v0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CJvHGtjp/8mwF8IC51iD7j+bQ7mZ7AlKAENBgzl6DQ+2KR4FuP1WO46UP8Rmu6/VEB1nAxVx0I/juZSvwSq4S5URrPHrDC8d3tRehuAqGJ7Ujb/lYaT/KiAwG+w2EAlU8gRaqg+BpISozogfZGwduB+tAbIqSc0IAfIeElR4ieE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mt1r2nl5; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-432d256c2a9so1152940f8f.3
        for <linux-rdma@vger.kernel.org>; Thu, 15 Jan 2026 09:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768497063; x=1769101863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/9zIIkhhFGJW7c5euU+uczxwuqnCR/g7cOorqaRVjc8=;
        b=mt1r2nl5+IcwV4rIclf6O+vfsoItttvYMAwELjX7wAw87RRtgoOW4yjf89VreUeVMN
         DUvrtR/D70+SBDc9heH/xdBvKbODGU113itq08ukub4tw+xmUGwWcQhvsS/yavKIjx8y
         PASkfYCvUsV604SnIoRkl5iKxMvUsKrbTugd7YH3ahhdIWQQnwHQ1c0NgQjcQgRbKuv2
         7EhanVPn/TK/MhaAGM941iuLfLGdB+n9VQzBnIWd0wo7hXd3PVboAUZARPbzFlr0f3XW
         mTrXKtW8TsgnMgSgjAIi7VeQPc9k6LrWVpOEBn+lZbb7YXfAaBO7VVSecu2OIE4EI6IW
         MwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768497063; x=1769101863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/9zIIkhhFGJW7c5euU+uczxwuqnCR/g7cOorqaRVjc8=;
        b=Zx6UEYd5emCQ25k7wIA9qM5y18IEo/AhcgPKCdprrNLp8KshFHT726+Ymxw5kaNOF8
         Y7mP/TsWd3px16PK+iaulujPT+lnptKoIR/4xb/X8j+RVVwi3LLzUdrOh8TJBEyiwYRd
         ygUHHpY/m9Ra327FgGmf3UQpuf5duSbeAWbB9Nn5DfOFS7LH0+F9yBCEb30ce862JRj4
         M1HftYurs8grWSYdvDqC6xKGP8VY4ioVapWSjh4wpY9OTr2EFwbWZUzXqISOP2MCAxQ8
         u9zl5aXxF8vsnsLP49/xKUy8gnf4WKeFE7hLdGoo+YCC2c7GEzgmxzGnp/T7F2YS3K37
         d1cA==
X-Forwarded-Encrypted: i=1; AJvYcCWqjDxYlh1VvZlEoOCf/jYLDJ1LvCXO53/zsPP1fbxK/BC2YV4FxN47L8ZON67jfMJeUl2LoUutZhXQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwFT+rmuh2hBuRnZyhoiO+9CNlVo7peY4/xRDKcd0+LzgV9DRiT
	dJ2D3B9FZg5eNytdGgLT7KuZky0+GWoHzpZz82p65ylIozoh6OygRbrQ
X-Gm-Gg: AY/fxX7uvHw+Jgt8sy0IYuzo7znlf1o9RUFzQKOjiEDS1jArHdlDE7vCGpQR4oaXLmU
	lH+mKd1J3Nf12ujDYI6lytTurnTAlkvHdsA0z9vafA3MN144F6NhfXUxXuzYDut6c4FBK7QxMan
	R+pTZG/DTkf2SyTsxWSOlhCT3dQ6A/xgcOr3Hb4PNpnQzusTiSbKYHcOXoXOPIsN8Urw10OmPmg
	v1FxLHWb4ZQnZSI5uHz/m3uBnB1CuXa8CF4B6Y0BA5IvLnBzdKppNCnV3bF2b9jyDUhhLKPnSfG
	90UyP45UAHwyb3aMW1l677wh/590Wc7EDaldUysP74JA+QWmPs+KwvIj3sVhBXL1OZBwdN/zm7y
	eHo3XYsORAw2x0vbpZYE0zT6OUs+MdjMquTcBQWh1PVL77X7MoRkdYEFUIvRG7TBf7wYUjG5GK7
	/BcTS3i1orw8XWUEGFmN5iUtfkirDOgqdKxO/iqw30U6Vi7agH3fLxevlAPs5RNMEmB/iCjFLrJ
	GCmea1XUlIvbG0nwtXMwnay8/Jx1LhMfKpFeiDiBchrhpNOJedNFsjHmmipsbtRhA==
X-Received: by 2002:a05:6000:1889:b0:431:9b2:61c4 with SMTP id ffacd0b85a97d-43569bc77b8mr74982f8f.45.1768497062676;
        Thu, 15 Jan 2026 09:11:02 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356996cf42sm104023f8f.20.2026.01.15.09.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 09:11:01 -0800 (PST)
Message-ID: <5c0f28de-41dd-47c6-9b0b-9ea40cbbeab2@gmail.com>
Date: Thu, 15 Jan 2026 17:10:55 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 7/9] eth: bnxt: support qcfg provided rx page
 size
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Joshua Washington <joshwash@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Alexander Duyck <alexanderduyck@fb.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Shuah Khan
 <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Ankit Garg <nktgrg@google.com>, Tim Hostetler <thostet@google.com>,
 Alok Tiwari <alok.a.tiwari@oracle.com>, Ziwei Xiao <ziweixiao@google.com>,
 John Fraker <jfraker@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Mohsin Bashir <mohsin.bashr@gmail.com>, Joe Damato <joe@dama.to>,
 Mina Almasry <almasrymina@google.com>,
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>,
 Samiullah Khawaja <skhawaja@google.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, David Wei
 <dw@davidwei.uk>, Yue Haibing <yuehaibing@huawei.com>,
 Haiyue Wang <haiyuewa@163.com>, Jens Axboe <axboe@kernel.dk>,
 Simon Horman <horms@kernel.org>, Vishwanath Seshagiri <vishs@fb.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org, dtatulea@nvidia.com,
 io-uring@vger.kernel.org
References: <cover.1767819709.git.asml.silence@gmail.com>
 <28028611f572ded416b8ab653f1b9515b0337fba.1767819709.git.asml.silence@gmail.com>
 <20260113193612.2abfcf10@kernel.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260113193612.2abfcf10@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/14/26 03:36, Jakub Kicinski wrote:
> On Fri,  9 Jan 2026 11:28:46 +0000 Pavel Begunkov wrote:
>> @@ -4342,7 +4343,8 @@ static void bnxt_init_ring_struct(struct bnxt *bp)
>>   		if (!rxr)
>>   			goto skip_rx;
>>   
>> -		rxr->rx_page_size = BNXT_RX_PAGE_SIZE;
>> +		rxq = __netif_get_rx_queue(bp->dev, i);
>> +		rxr->rx_page_size = rxq->qcfg.rx_page_size;
> 
> Pretty sure I asked for the netdev_queue_config() helper to make
> a return, instead of drivers poking directly into core state.
> Having the config live in rxq directly is also ugh.

Having a helper would be a good idea, but I went for stashing
configs in the queue as it's simpler, while dynamic allocations
were of no benefit for this series. Maybe there are some further
plans for it, but as you mentioned, it'd be better to do on top.

> But at this stage we're probably better off if you just respin
> to fix the nits from Paolo and I try to de-lobotimize the driver
> facing API. This is close enough.

Ok

-- 
Pavel Begunkov


