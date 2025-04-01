Return-Path: <linux-rdma+bounces-9059-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2038CA776EC
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 10:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2C7F16A107
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 08:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DE81EB9EF;
	Tue,  1 Apr 2025 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NLPc3rfr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172F21EB5EA
	for <linux-rdma@vger.kernel.org>; Tue,  1 Apr 2025 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743497544; cv=none; b=YTSvmjOFlvAAwGrzXkjeCvFnC7SrZtpKP0Qj6F5tjI50ZqzRJXg4u1p0KDIdm6ceSC+S2TMutZa1QeByg0cXTBIXj3v8VfuF9rWOicB6ZEpAZiJaNHWxEUSSf9eTe+MujprMDdOqeqJ0M14Eit9FG5eNv5eQ1kHkiT+rBBJfSWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743497544; c=relaxed/simple;
	bh=fNkQvYlNaa3cqbrVMNrNNj9EdtzcFO71fUGvPTgiinQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SFgAplBsHJsQOqZi/B3yy5CG1Oz9ZSgmoNrO4dd28QvIP6zSeSGGSQJdd5suqFo0+yGPLWeB3ye2IHSEGOLJlJ9BPiCLdLBgbpJVFOgyuRBbrQC0oeu4ceP//i5CI4ZJl+eOrlyyG0x1wL24mAk6ZP2x3nenHWS26h4kLv3ysYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NLPc3rfr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743497541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iTrzmKHOhipGTrVn6hOCwktriFPfHqZi1ySNcTDYp58=;
	b=NLPc3rfre9vYg5w5F37cOvnPKPmGANzxPFjV2R5Sc7NMc1MsIgCf54CAajnxRDko6jUvSE
	EdTvsx3RZl+sHXG9GEtkMME1jL3pB7kN0RETLd9vlvZgaqNIee3V4hZ88+q17lVhUWsF7w
	lUDMksQZIJiXMKXeNy57iIaw9wQruak=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-d2ttIykAM96xsee-ztQ6jw-1; Tue, 01 Apr 2025 04:52:20 -0400
X-MC-Unique: d2ttIykAM96xsee-ztQ6jw-1
X-Mimecast-MFC-AGG-ID: d2ttIykAM96xsee-ztQ6jw_1743497540
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3912e4e2033so2256756f8f.0
        for <linux-rdma@vger.kernel.org>; Tue, 01 Apr 2025 01:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743497540; x=1744102340;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iTrzmKHOhipGTrVn6hOCwktriFPfHqZi1ySNcTDYp58=;
        b=quGJLQzLzkzg6XMQ7kW42SVzTHWw1qFu4EXpkpPcuZr71ZEPyMtxUMR0WUyHCql8Zk
         K0xXsR1jaIdH6AMlnlnQEz2TqAgTDuHVg9dOMoSX6WSFz5mEb8jFgbJ4M+5651AISIka
         myJimW1cAhKm8YdGD6q7rX7QIpl6tJ6J3VYZFNdnW7kC3+Hg5Z259p00X80xnlIvEK80
         LqXbxafNPlNIoW8RY4etaNGmqLjMVjwaexpf7UgGjeKxBbrtXpQPpUWQFTArRSkXQHxv
         QnjcA68o3tozT/sE/8NTL1P8FD/7krtOxKGOozeSXchub79/wOk37W3DkMXXXLXTmlLe
         4RDw==
X-Forwarded-Encrypted: i=1; AJvYcCX+QawWFOkeHstqigIBIJzJ9RV5x/JiOHhBc3lBhis+4mZoKX275KNmE7vtPFYxhJ1kqvfWvIklcbyh@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8BnDUpwb2chgJ6ZoqTNuXydQ/xnXmmCXxEPL3mJlaJ76puDEu
	Ab0obayYVTI7/K91HW5oQjTb1++sZm0ZAZLTbWQCtPZlafbDedUVfN9IgTaZbVu0PY6C9Zr22/T
	nDv6865qmqk91NP02bk4eC1aazZkmGmEFIl5aTbDGle5tn6IctvFB/X/jP00=
X-Gm-Gg: ASbGncudOl4sdCYcqHrozZTRgIY5avTolaPXai1cudfeNaltpGHAXo5Leh+4zkEQee1
	Kc8x5O2+2v8F4SblsOE7Cao/k3LjtPPG5ATyh45Sqw/+9tYqFCuevno27l8kA2otvCc0y1+YE9u
	U0V/kFuU59ENDPaSC4qXFEznbydWdBBzN4oodAM9EdTlPx796cTjY0F7rKwwEinV0OpBsSgiwkC
	ed0GCnTju4NQeGPiKkW7WKks0TpAatHG1XtWIQtG0LMxyLuYjYen58/llm4nPPu0adbP9UViH8t
	MRcIw0oWut5Cs80/BZ3qkU+Uvdob81Ac/q9rYoASIC9lMA==
X-Received: by 2002:a5d:6daf:0:b0:391:1222:b444 with SMTP id ffacd0b85a97d-39c120db3f4mr8036370f8f.20.1743497539704;
        Tue, 01 Apr 2025 01:52:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFIwIsFXgnFgUnvUf7GiB0Qo92O2pFQl8WkobeyI6QhVmQ5/bHplaSDVAbQLHpuaV2qU/iLQ==
X-Received: by 2002:a5d:6daf:0:b0:391:1222:b444 with SMTP id ffacd0b85a97d-39c120db3f4mr8036337f8f.20.1743497539288;
        Tue, 01 Apr 2025 01:52:19 -0700 (PDT)
Received: from [192.168.88.253] (146-241-68-231.dyn.eolo.it. [146.241.68.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b7a4351sm13751264f8f.98.2025.04.01.01.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 01:52:18 -0700 (PDT)
Message-ID: <38b9af46-0d03-424d-8ecc-461b7daf216c@redhat.com>
Date: Tue, 1 Apr 2025 10:52:17 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Mina Almasry <almasrymina@google.com>, Yonglong Liu
 <liuyonglong@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>,
 Pavel Begunkov <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Qiuling Ren <qren@redhat.com>,
 Yuying Ma <yuma@redhat.com>
References: <20250328-page-pool-track-dma-v5-0-55002af683ad@redhat.com>
 <20250328-page-pool-track-dma-v5-2-55002af683ad@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250328-page-pool-track-dma-v5-2-55002af683ad@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/28/25 1:19 PM, Toke Høiland-Jørgensen wrote:
> @@ -463,13 +462,21 @@ page_pool_dma_sync_for_device(const struct page_pool *pool,
>  			      netmem_ref netmem,
>  			      u32 dma_sync_size)
>  {
> -	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev))
> -		__page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
> +	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev)) {

Lacking a READ_ONCE() here, I think it's within compiler's right do some
unexpected optimization between this read and the next one. Also it will
make the double read more explicit.

Thanks,

Paolo


