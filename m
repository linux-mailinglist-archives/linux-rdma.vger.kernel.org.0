Return-Path: <linux-rdma+bounces-3937-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A41939F46
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2024 13:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F841C22057
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2024 11:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF70614F9D4;
	Tue, 23 Jul 2024 11:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFmxf8PO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD0314A0AE
	for <linux-rdma@vger.kernel.org>; Tue, 23 Jul 2024 11:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721732614; cv=none; b=I9HaoBbCiqGHvZpAvkMipSv28BxqvhF3Ga149Cgzx9d5dTti+WPj7Y8k/nm3cfuYdtX/PufbL7B1f25tgl4WMVEcCv8sgnOdLv+QfN1QW1+faHN9aY/16azGFlT+7fL4QgEyIvYQrqaxJbBZXGQyCGiHQg92gztISKpZiX2oxzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721732614; c=relaxed/simple;
	bh=OOYTAc0WoZeRWU6IrWBLljNUtPQtZJ/KFGIhwGS8JGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G4P9T9Sk52qqlnZ6NczPwR5LrCMKeVwmbs9ZfoRocxGHNSiJzL1M5kpTKSteVKXfrVqqQtnmLMYcsR5t6Fc1hPqZOnUaj5pcbGn8lN1f/bV3aTE8JF6zuIHJR0bqm36CKxCCr5w/Sv570+jlfqBJlNlEDEvmzfAPZA4x9fZoZAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VFmxf8PO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721732611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CG0TDjV60g77He2sGPyPmAEOzJNVXOyb6cTctysXaN0=;
	b=VFmxf8PORVHXrpsqM4ltJ3s2pzk4wRztrymqsXv3TlV3/EU7ND2XTc1l/ADpOMqKJ89J8B
	yvhQTsvekt/C+/FEhrYrEsBvczEON2QisqeYvfzv0nqnQwRzY63XxDHtvo593o0F1adxH5
	SRJoY3VkPB4kUClj6s1pQOiZFAZavus=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-fGngH7FaNkuXI3aZnwq9tw-1; Tue, 23 Jul 2024 07:03:28 -0400
X-MC-Unique: fGngH7FaNkuXI3aZnwq9tw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5a29c8de0f9so377336a12.2
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jul 2024 04:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721732607; x=1722337407;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CG0TDjV60g77He2sGPyPmAEOzJNVXOyb6cTctysXaN0=;
        b=A5/LY7f1/A8PD/v3kCa9vU6EU3jUPPBtbMGHGq1nYOvfAgK2fihqou8+Vc5QpDYdf7
         LAP8QQnUEQpbyWEW3FTJoPEUA2l+421wFjZs5Y2dWyTmPKQtqZTEWKd0Uie4+bizs4nw
         wmEfKwJK5W+dXI08n1h6rnJzm4c7+8C2iZP/pM6s/b6eE8PQ2uIwP+iH68ekV8z9RTua
         tPD4xb9LFXOs3nE5NhkAgkfhF5W27X4mUqYqEOA/vtO+qlhgOWDxC02em58TC9pCyWH7
         h9dVy66BmPvsrcIEgNhshCTocwhts3bDEtaP4lLG0fOQPX31uYnjfhRVxRW8YgE68j+k
         lBPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD/Qsg6pSPjNPKpik+6Jf1M9EnlW4PjeXeZ3z8Wpze3qVqNNfjgogVnVvLw8DkYheLRgdVhw+PLnVyPDwUog7/Il1OiQ8em6nEuw==
X-Gm-Message-State: AOJu0YziivmLv+QNhV2lfPBYRSmRhYdVNghkrdP10HCVncuxD/3fjxgo
	tBuaWXOMoO2vTk0hUiW7XilkMNKJwhP4GI+gdYSGnrBfNYRe50rJK1IThPH74QwBrIKZjjLYJY0
	dMgEHGwEq+VKRR5mSIuVlR/thUawZwFusAwaXmO04xx8/sO7IymGV6BOle8g=
X-Received: by 2002:a17:907:9714:b0:a79:a1b2:1a5e with SMTP id a640c23a62f3a-a7a420b8f79mr397238266b.10.1721732607618;
        Tue, 23 Jul 2024 04:03:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEPlHAKH81TEBLznH9C53oe8ITsSDPLiHU5eE2F64XzAAmhKtDgdv28xYCROtzjI27l2T9gQ==
X-Received: by 2002:a17:907:9714:b0:a79:a1b2:1a5e with SMTP id a640c23a62f3a-a7a420b8f79mr397236266b.10.1721732607162;
        Tue, 23 Jul 2024 04:03:27 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:173f:4f10::f71? ([2a0d:3344:173f:4f10::f71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a8beef9cdsm92164066b.89.2024.07.23.04.03.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 04:03:26 -0700 (PDT)
Message-ID: <9552840d-b431-4e0b-b79f-e7a90431b709@redhat.com>
Date: Tue, 23 Jul 2024 13:03:24 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7] net/mlx5: Reclaim max 50K pages at once
To: Anand Khoje <anand.a.khoje@oracle.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: saeedm@mellanox.com, leon@kernel.org, tariqt@nvidia.com,
 edumazet@google.com, kuba@kernel.org, davem@davemloft.net,
 rama.nichanamatlu@oracle.com, manjunath.b.patil@oracle.com
References: <20240722134633.90620-1-anand.a.khoje@oracle.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240722134633.90620-1-anand.a.khoje@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/22/24 15:46, Anand Khoje wrote:
> In non FLR context, at times CX-5 requests release of ~8 million FW pages.
> This needs humongous number of cmd mailboxes, which to be released once
> the pages are reclaimed. Release of humongous number of cmd mailboxes is
> consuming cpu time running into many seconds. Which with non preemptible
> kernels is leading to critical process starving on that cpu’s RQ.
> On top of it, the FW does not use all the mailbox messages as it has a
> limit of releasing 50K pages at once per MLX5_CMD_OP_MANAGE_PAGES +
> MLX5_PAGES_TAKE device command. Hence, the allocation of these many
> mailboxes is extra and adds unnecessary overhead.
> To alleviate this, this change restricts the total number of pages
> a worker will try to reclaim to maximum 50K pages in one go.
> 
> Our tests have shown significant benefit of this change in terms of
> time consumed by dma_pool_free().
> During a test where an event was raised by HCA
> to release 1.3 Million pages, following observations were made:
> 
> - Without this change:
> Number of mailbox messages allocated was around 20K, to accommodate
> the DMA addresses of 1.3 million pages.
> The average time spent by dma_pool_free() to free the DMA pool is between
> 16 usec to 32 usec.
>             value  ------------- Distribution ------------- count
>               256 |                                         0
>               512 |@                                        287
>              1024 |@@@                                      1332
>              2048 |@                                        656
>              4096 |@@@@@                                    2599
>              8192 |@@@@@@@@@@                               4755
>             16384 |@@@@@@@@@@@@@@@                          7545
>             32768 |@@@@@                                    2501
>             65536 |                                         0
> 
> - With this change:
> Number of mailbox messages allocated was around 800; this was to
> accommodate DMA addresses of only 50K pages.
> The average time spent by dma_pool_free() to free the DMA pool in this case
> lies between 1 usec to 2 usec.
>             value  ------------- Distribution ------------- count
>               256 |                                         0
>               512 |@@@@@@@@@@@@@@@@@@                       346
>              1024 |@@@@@@@@@@@@@@@@@@@@@@                   435
>              2048 |                                         0
>              4096 |                                         0
>              8192 |                                         1
>             16384 |                                         0
> 
> Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Acked-by: Saeed Mahameed <saeedm@nvidia.com>

## Form letter - net-next-closed

The merge window for v6.11 and therefore net-next is closed for new
drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after July 29th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


