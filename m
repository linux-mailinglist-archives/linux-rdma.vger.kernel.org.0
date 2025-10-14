Return-Path: <linux-rdma+bounces-13859-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D861ABD9724
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Oct 2025 14:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 96B1D4F4CC9
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Oct 2025 12:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1640C313558;
	Tue, 14 Oct 2025 12:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtSc4LB7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F2524338F
	for <linux-rdma@vger.kernel.org>; Tue, 14 Oct 2025 12:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760446174; cv=none; b=KwiBMExT316fYmEHVsvdTguowHj2bfdhwICnK1dsnyTURzN/Mv0yfGmmY/LgMJqtGlZOZkM2fRh5jw6Avm3yc0HEiuoPmkCLMCqbdIAEqf57MIq70hjWIQPTvcE+4akkyEnMeqQDSX5tX7i51uzFxMzsiquiUtE1oLa+Mbl/YvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760446174; c=relaxed/simple;
	bh=v6U7DLGCjYxoj5ENGgqW08NtBhbBHu0yt05+ofF8WwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TaHipoGpVDejxzX9aI/TdONCR4J23FbkNcA/JCmjkRQ3gyujeSod+ELOn7czVfNvzWFn5NXfw6VC6OSYgwIsbQfmR7n/xmdPuFrZco1JRJExKJ6TmV1RX3V4AISxhP5RWbyyoKmUouI3Y9QhKsoeYeI1x7O5eT4vkEV5Xl/I7nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtSc4LB7; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e61ebddd6so57207415e9.0
        for <linux-rdma@vger.kernel.org>; Tue, 14 Oct 2025 05:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760446171; x=1761050971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0xSNdK/UPhiag6fJGs/Gpb+fa/gGbLtGUzql412YrQM=;
        b=gtSc4LB7OA7bRkzqTj38aPPkoYheXqePmcWvS0BDT7u3+FjqbaVOnCg0bQgDzuWVDX
         i4xiwLOO8eaiJt4ApuZwEvYB4CW/QGH6CAj3ySVxgGUc7PV03bgXViF20i75GGUMZrgR
         6ssv7ZYr26cbCr8IgsfIbRNEA+dTAv/e9m3kHbPwamAhXFrIjfcdYO/bSiq6OCpGZr+5
         YmaEEt6ywKIA8U/pTMbEUHPG+NqHITas0i6Q0sNYAR47Z918J4SzCvMgSLuw2hME1HCn
         5zhQIuN0eSSfrlJQz3Dceg3VDf4MffJYdfsMUB2HjejhcSOSKbtRU1eNs0mS1VobWXLg
         BccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760446171; x=1761050971;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0xSNdK/UPhiag6fJGs/Gpb+fa/gGbLtGUzql412YrQM=;
        b=W1FjHUEJBP0ov/TtMWWDv467qOsyh+RlVsqeyFCVxcM5VSZZmj0uxqk+DCUCfTD6XC
         5oXYYnPhukAHoXoWKU0G/sTrq8JYWBQVyTmUt1N/VlIb2/quhCftklXPLoQMblnvsL00
         lqgAsvwyI/IcJPFbAIQHhLS73XBwYEJeSkG3pVNh3YqN2Pms6F/EIQZZOXchz/TsWemo
         XeouCfYcehXl0WF8QxCowOpJibso4LeIwQnBsKeFW4nEBohRRj0MmBAZWdFNG651SiLT
         Et9iFMLeDE1JaQOVXgYvl0s9W/fSMiCaIvJgOoDKzqN8tUiTxP0xbm6W8Dq4xxt19lCg
         V1/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWxeqMjF5s5hoGvylElEU5f/DfEWxQuxvDJxaykp4jI222YJrk2TSLQuSKp7M56fbXYJW9a82imbVNH@vger.kernel.org
X-Gm-Message-State: AOJu0YzIHhUIfUYIoxL6MKLvdcHRgkqEJGKp2blcilEps5WZ0rUE3ICf
	T+wNCcl8U7xroUTRgCxELpVVIi03HUQ09ruBnKrAJnhWeJsvYX8SQi5Z
X-Gm-Gg: ASbGncvquSPMGlOSozLiLb7DU5UBffFrFCubcqQK5q+ym/z1kttuPoXMSi+GgbCHM55
	aU1tj4FNezWs/qp4BtSoppnneYbwtx0s7egzNzlWzD3Z7Kfk0PfyyvpwHfZgd6AocUb5ZGOwNSz
	74FBWO+m2cFGGNHCOvCWygjmXkM2yqRE7eGjQxi7O0ILSQPBDnWz4FMPVTLcDql5S3VhFJY+ocF
	Cvkr0zjgYyXu15JE2UEI45O6lBnXEB3p0Zw7ShVYqZXWFop4m73tsfjsDSOWZZuf3pz6edc6IqW
	mXXA9SUkA2EiigsLgAmhtpxcblEtdE7k6oEfOEcLC+48OeYmR/MulUqBZ7852hKFPJcRlkNFiay
	9OyUWO95IMzsTV2kXWvsRUd+/rhJP37NWkwiaPsu4uCiSamna9bAJ3B1iR0yU/HXv/tE+Smkgex
	7QRMCfCuwAC5tth/mxmKw=
X-Google-Smtp-Source: AGHT+IGoUGOOarSp00OMRYWhOXW34mYrkF25elYJu4oLZtBIvtZyX2JSTRSEbwHePA1SLut/vaU6wQ==
X-Received: by 2002:a05:600c:c091:b0:46e:59bd:f7d3 with SMTP id 5b1f17b1804b1-46fae33dffamr97594825e9.20.1760446171042;
        Tue, 14 Oct 2025 05:49:31 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:7ec0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb489194dsm238775265e9.12.2025.10.14.05.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 05:49:29 -0700 (PDT)
Message-ID: <eadd2a9a-1c48-4329-a021-1b7c8d8b86ff@gmail.com>
Date: Tue, 14 Oct 2025 13:50:45 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 00/24][pull request] Queue configs and large
 buffer providers
To: Mina Almasry <almasrymina@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Joshua Washington
 <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>,
 Jian Shen <shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>,
 Jijie Shao <shaojijie@huawei.com>, Sunil Goutham <sgoutham@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep
 <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Alexander Duyck <alexanderduyck@fb.com>,
 kernel-team@meta.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Damato <joe@dama.to>, David Wei <dw@davidwei.uk>,
 Willem de Bruijn <willemb@google.com>, Breno Leitao <leitao@debian.org>,
 Dragos Tatulea <dtatulea@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>
References: <cover.1760364551.git.asml.silence@gmail.com>
 <20251013105446.3efcb1b3@kernel.org>
 <CAHS8izOupVhkaZXNDmZo8KzR42M+rxvvmmLW=9r3oPoNOC6pkQ@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izOupVhkaZXNDmZo8KzR42M+rxvvmmLW=9r3oPoNOC6pkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/14/25 05:41, Mina Almasry wrote:
> On Mon, Oct 13, 2025 at 10:54 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Mon, 13 Oct 2025 15:54:02 +0100 Pavel Begunkov wrote:
>>> Jakub Kicinski (20):
>>>    docs: ethtool: document that rx_buf_len must control payload lengths
>>>    net: ethtool: report max value for rx-buf-len
>>>    net: use zero value to restore rx_buf_len to default
>>>    net: clarify the meaning of netdev_config members
>>>    net: add rx_buf_len to netdev config
>>>    eth: bnxt: read the page size from the adapter struct
>>>    eth: bnxt: set page pool page order based on rx_page_size
>>>    eth: bnxt: support setting size of agg buffers via ethtool
>>>    net: move netdev_config manipulation to dedicated helpers
>>>    net: reduce indent of struct netdev_queue_mgmt_ops members
>>>    net: allocate per-queue config structs and pass them thru the queue
>>>      API
>>>    net: pass extack to netdev_rx_queue_restart()
>>>    net: add queue config validation callback
>>>    eth: bnxt: always set the queue mgmt ops
>>>    eth: bnxt: store the rx buf size per queue
>>>    eth: bnxt: adjust the fill level of agg queues with larger buffers
>>>    netdev: add support for setting rx-buf-len per queue
>>>    net: wipe the setting of deactived queues
>>>    eth: bnxt: use queue op config validate
>>>    eth: bnxt: support per queue configuration of rx-buf-len
>>
>> I'd like to rework these a little bit.
>> On reflection I don't like the single size control.
>> Please hold off.
>>
> 
> FWIW when I last looked at this I didn't like that the size control
> seemed to control the size of the allocations made from the pp, but
> not the size actually posted to the NIC.
> 
> I.e. in the scenario where the driver fragments each pp buffer into 2,
> and the user asks for 8K rx-buf-len, the size actually posted to the
> NIC would have actually been 4K (8K / 2 for 2 fragments).
> 
> Not sure how much of a concern this really is. I thought it would be
> great if somehow rx-buf-len controlled the buffer sizes actually
> posted to the NIC, because that what ultimately matters, no (it ends
> up being the size of the incoming frags)? Or does that not matter for
> some reason I'm missing?

Maybe we should just make a rule that if hardware doesn't support
the given size, qops should fail, but ultimately the userspace
should be able to handle it either way as gro is packing not
100% reliably.

-- 
Pavel Begunkov


