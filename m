Return-Path: <linux-rdma+bounces-9060-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B242A776F6
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 10:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 543F83AAA3E
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 08:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6D31EB9E8;
	Tue,  1 Apr 2025 08:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xa1b5g3B"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9491EB5D5
	for <linux-rdma@vger.kernel.org>; Tue,  1 Apr 2025 08:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743497767; cv=none; b=VIHjbT53hLBZ86fab0fVoChv2GH5s1jGmsX5LF9U4Mzkaj4Qe3Soqe466VNLQ7Ni4L7SXLvffn0KpTPezRyh/u/JSYFK57pbMXkiCIgF5L7ebpdRTXa2TvMNbgObWMMLIt2YloWh98BYlLdgm4cDLDF3f43rFL3KDBpw4+3zduY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743497767; c=relaxed/simple;
	bh=tV7GHmfr5Si8SRiqwT6boi3Gj3jsFs4R9lIa/PbtSKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iwX7ltSns4H7ZYmo/Q/mXXcZkvunCK9REfyYSm51K3MKs87VjD4EraSswCPmmK58/pmVPaUfCMU3l/b9NthBiMYT0KtZ8VSSzMOF8cSdFIMfZ7qddWkw/52SCx9fZL8utURqdDw72zIp0pLVUr5VmIRlWNjGAGG6LUaXc1rTLj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xa1b5g3B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743497765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/EOGpZgMMwI61gNswk7Hqy4zEoEqDiKfuBQe+kGOmzE=;
	b=Xa1b5g3BriYlUA5VNSoObwldecuYJmbPxvW+fI6QgxRaN3T2RbHY22klk0qX064bGWF6Rn
	SEHx6iEeBhwbvu+24L36vR2OJ2Rz42he3E3LxY3Qyo1NtNZQoNYwUmEj5bBiUuyVQYVhOv
	WTn9YJCswgrpSms3VJ3wrX4PMLGvfbE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-bIAsyvHkNWuUy_vQjQf6OA-1; Tue, 01 Apr 2025 04:56:03 -0400
X-MC-Unique: bIAsyvHkNWuUy_vQjQf6OA-1
X-Mimecast-MFC-AGG-ID: bIAsyvHkNWuUy_vQjQf6OA_1743497763
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3913aaf1e32so3047090f8f.0
        for <linux-rdma@vger.kernel.org>; Tue, 01 Apr 2025 01:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743497763; x=1744102563;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/EOGpZgMMwI61gNswk7Hqy4zEoEqDiKfuBQe+kGOmzE=;
        b=fPWcNgYL0corWAIUdz01QmveZJBXAHsoW3E97lZ1nABArC12yqCZgALvjMgT4Mdvk4
         +PYnPCmsBT6afneSDRT1dannPlYau8+nlggG1wzcENrY1cIrnQi6wMZrH4v3GDuP61by
         y1HjBCc3csw5o1DTXLjS/RjcOdwNTyaJPkoqTsnkjYRBv929hdhyOL6c4sdwoBx3tcNf
         nRIQjgFjq6ZMm/jl8sslge0T+kxzl+/y+AOIRTICIz+4H5EkbJit55J1lBzTnYN6vPJx
         eM98l42Xa/4QdAUSZUz7zKmVtCHMnNsjNVlUQ5ioz4QDxfqbRxBSSGWPvdrdU6aKnubj
         kkcw==
X-Forwarded-Encrypted: i=1; AJvYcCWjlGEWAve0N/iSDDQOIJlJWwbVtIh3ErhfEJTn0i7kXOnZmC8fCCSxxBzjFkku+s2kkF2VlcY3pBuc@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf6EobrFVe0L1Dasn7ch/xVZYloPsPmPiLOyMQWPr73hgtgOwv
	lr+f1a+MkNHiPuThLDahFwJv7fP9QNHqPC2mC+6sjO36AIT6Bny0yS8My/u3SYcmHEyvlFxN5d9
	S2dJwYxMQRQfGJkFJE5pAqWwscR8M1SJYxbSJcI4tnSoSj2gtQuGxcsWJYoA=
X-Gm-Gg: ASbGnctqueAWQbTpTKT6mBkr8X9ahhAcYcbcuCNVI06/JC2pAG3IwqTt9GPMU5oyaOX
	UaYQQ8SFK3xEWsLCvsfPdb4XPulQR8ANqv1Pbjx11nPX9DccWaohcG6tZFCVSsJXh1qj1O93X8a
	M/tMp3GxG2/e4Tb9n62SEx7AL2GThbEFTTn2kJUBPS4E+ntTJPFBckn34zESOuDA4D3qS5FhOpK
	y3jTLjAYqtNEcdOJ3AKhVHMB7t20kPrm1Y2OcxkqFiMV+bx+scorx8riwox2PEv/JOs9gzHIeHZ
	ONhO+eeMeI0bbjuLrITRmWkDdRcKjqh60+6Spsl64KKD3g==
X-Received: by 2002:a05:6000:2913:b0:391:122c:8b2 with SMTP id ffacd0b85a97d-39c120e1566mr10357901f8f.31.1743497762667;
        Tue, 01 Apr 2025 01:56:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPPFEHn5QvMX8T7Toc4UY1OJQWioAVuAJM2JZ1z1ZDDcbJGmm1kVkDwd+dzHOwCnzyaJepwA==
X-Received: by 2002:a05:6000:2913:b0:391:122c:8b2 with SMTP id ffacd0b85a97d-39c120e1566mr10357860f8f.31.1743497762256;
        Tue, 01 Apr 2025 01:56:02 -0700 (PDT)
Received: from [192.168.88.253] (146-241-68-231.dyn.eolo.it. [146.241.68.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b79e141sm13581555f8f.77.2025.04.01.01.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 01:56:01 -0700 (PDT)
Message-ID: <7488e6cf-e68b-4404-aaa9-f4892b2ff94b@redhat.com>
Date: Tue, 1 Apr 2025 10:56:00 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Mina Almasry <almasrymina@google.com>, Yonglong Liu
 <liuyonglong@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>,
 Pavel Begunkov <asml.silence@gmail.com>, Matthew Wilcox
 <willy@infradead.org>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-mm@kvack.org, Qiuling Ren
 <qren@redhat.com>, Yuying Ma <yuma@redhat.com>
References: <20250328-page-pool-track-dma-v5-0-55002af683ad@redhat.com>
 <20250328-page-pool-track-dma-v5-2-55002af683ad@redhat.com>
 <aaf31c50-9b57-40b7-bbd7-e19171370563@intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aaf31c50-9b57-40b7-bbd7-e19171370563@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/31/25 6:35 PM, Alexander Lobakin wrote:
> From: Toke Høiland-Jørgensen <toke@redhat.com>
> Date: Fri, 28 Mar 2025 13:19:09 +0100
> 
>> When enabling DMA mapping in page_pool, pages are kept DMA mapped until
>> they are released from the pool, to avoid the overhead of re-mapping the
>> pages every time they are used. This causes resource leaks and/or
>> crashes when there are pages still outstanding while the device is torn
>> down, because page_pool will attempt an unmap through a non-existent DMA
>> device on the subsequent page return.
> 
> [...]
> 
>> @@ -173,10 +212,10 @@ struct page_pool {
>>  	int cpuid;
>>  	u32 pages_state_hold_cnt;
>>  
>> -	bool has_init_callback:1;	/* slow::init_callback is set */
>> +	bool dma_sync;			/* Perform DMA sync for device */
> 
> Have you seen my comment under v3 (sorry but I missed that there was v4
> already)? Can't we just test the bit atomically?

My understanding is that to make such operation really atomic, we will
need to access all the other bits within the same bitfield with atomic
bit ops, leading to a significant code churn (and possibly some overhead).

I think that using a full bool field is a better option.

Thanks,

Paolo


