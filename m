Return-Path: <linux-rdma+bounces-5178-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D965998CDDB
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2024 09:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005B01C21609
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2024 07:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC94194ACF;
	Wed,  2 Oct 2024 07:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KNVes14/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41046194A66
	for <linux-rdma@vger.kernel.org>; Wed,  2 Oct 2024 07:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727854684; cv=none; b=GuHkY9T3ruuuufqkiwqH+voRknD2LRqdDrWzK5fXtYHuh/TJzlmvOmK7p/9hDgye4UEy+ReWLHhEqsgkTt2zW42GPCsYlFGmL0B7JPf2pgBiUwWKuHlFhz5Um6pN+yT2tGhPVN6ZMuQJUFDLkoIa3j0taW2G9givB6196TBAlW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727854684; c=relaxed/simple;
	bh=WE+06bxezNDAqpcu2ZttnmMzwPNs3mFTLb9xN/v5LS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IT7naVj2loNGYLVTwQuIOVtn7QVsgg17bABttEl/KQYsRCkivRBwcgWg/SBjsE90q9V4bpjADEjwuOrefx/RIk/ByBLRcSIc2B8qWY01BzxbFpHRszYO+KQHhNit9OZ3uvGvtkKrLInTq9ZaMH5Ow9xCbOWmyefB3z2jW+oc4Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KNVes14/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727854681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j08eYaNn2uqZATIiA0jZfTZrfzeBz+jlQCTj6GcTpN8=;
	b=KNVes14/3JJRBoN+munY7ry+URfle+5VKEkhjArwd9GY5WxZ9uS3phiI5WVOkkasuAM0+N
	Kz9JS2wbb0y8GSdBTt9NMFJSM6KQVlJ03s94EdOpB2Tzu2FaykBb/tZTMUHoxeeiJaoJl+
	bzGQS3d0cqbDQh6fOj3OgU7AihfV65A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-KVYept_HMmSGeu176BjjDA-1; Wed, 02 Oct 2024 03:37:59 -0400
X-MC-Unique: KVYept_HMmSGeu176BjjDA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb9e14ab6so48855435e9.3
        for <linux-rdma@vger.kernel.org>; Wed, 02 Oct 2024 00:37:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727854678; x=1728459478;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j08eYaNn2uqZATIiA0jZfTZrfzeBz+jlQCTj6GcTpN8=;
        b=iHKOFWtYhksdm5+yx8euiYWgFUL3rsBi9u37PNbs3iQdNVag0wbkrpnpOHyZqWNDjG
         UcOleMr4hDfJxzolrR9wcqQSjl+rFDDR7uHJSjIFac0VnlMPoWeGQ66PWerW/v5w+rhn
         uAj7mVxu4i1ik0qjPfK2QXFu9PsD0PvjBJykwAhNOMoqHUvbPvyKug4wfsQvp0ri+Vxw
         PZWPDbT5cx70LAHcCbhP6Bav1zt6qcst62c6dqE6E4m1MtDMVFjQxt1Fr3ELyOPg/wZZ
         6LizY7u4RHEjGCOIzqDocbUepER4VEaSVP0RFcrAEGqiw+VlrNzv8mMGSPPZ4k52ZSXB
         TH4g==
X-Forwarded-Encrypted: i=1; AJvYcCVh5u0ohmwYFozU/d71/4jkJjvRBZcxFTlVZDAh+WRwBrlmjAo63jpRyTOVXSyNmLDJ9eiaO3M7KVSb@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4ZkVID9z++WyfqRzgdm5SiUR9bxejTfpXcQnDrqJVJnKEjWfP
	oWgCF1EvNMOHZznGJzeupJGLabD+A6QkW0ej5hvSuB7fJo8dvlTt6CXiqa/4uO7kdmmBk6QjIqb
	i+iI68+gJKbplSDkx5KAMQOk+qSUnixNvsK6w5bfOAv6jpH0twMS9ci2KGjw=
X-Received: by 2002:a05:600c:1549:b0:42c:b4f1:f281 with SMTP id 5b1f17b1804b1-42f778ffef3mr14810215e9.34.1727854678270;
        Wed, 02 Oct 2024 00:37:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEexnVZvq0noKxS76pRMj9/ZaTG1nDs7t0bSMBHW4+0LcSgagoa/Bz8vlb6jQ6CnVv6cUGFfw==
X-Received: by 2002:a05:600c:1549:b0:42c:b4f1:f281 with SMTP id 5b1f17b1804b1-42f778ffef3mr14809895e9.34.1727854677827;
        Wed, 02 Oct 2024 00:37:57 -0700 (PDT)
Received: from [192.168.88.248] (146-241-47-72.dyn.eolo.it. [146.241.47.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f7a01fc92sm10806665e9.36.2024.10.02.00.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 00:37:57 -0700 (PDT)
Message-ID: <4316fa2d-8dd8-44f2-b211-4b2ef3200d75@redhat.com>
Date: Wed, 2 Oct 2024 09:37:54 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] page_pool: fix IOMMU crash when driver has
 already unbound
To: Yunsheng Lin <yunshenglin0825@gmail.com>,
 Yunsheng Lin <linyunsheng@huawei.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: liuyonglong@huawei.com, fanghaiqing@huawei.com, zhangkun09@huawei.com,
 Robin Murphy <robin.murphy@arm.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>,
 Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, Eric Dumazet <edumazet@google.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Felix Fietkau <nbd@nbd.name>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-mm@kvack.org, davem@davemloft.net, kuba@kernel.org
References: <20240925075707.3970187-1-linyunsheng@huawei.com>
 <20240925075707.3970187-3-linyunsheng@huawei.com>
 <4968c2ec-5584-4a98-9782-143605117315@redhat.com>
 <33f23809-abec-4d39-ab80-839dc525a2e6@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <33f23809-abec-4d39-ab80-839dc525a2e6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 10/2/24 04:34, Yunsheng Lin wrote:
> On 10/1/2024 9:32 PM, Paolo Abeni wrote:
>> Is the problem only tied to VFs drivers? It's a pity all the page_pool
>> users will have to pay a bill for it...
> 
> I am afraid it is not only tied to VFs drivers, as:
> attempting DMA unmaps after the driver has already unbound may leak
> resources or at worst corrupt memory.
> 
> Unloading PFs driver might cause the above problems too, I guess the
> probability of crashing is low for the PF as PF can not be disable
> unless it can be hot-unplug'ed, but the probability of leaking resources
> behind the dma mapping might be similar.

Out of sheer ignorance, why/how the refcount acquired by the page pool 
on the device does not prevent unloading?

I fear the performance impact could be very high: AFICS, if the item 
array become fragmented, insertion will take linar time, with the quite 
large item_count/pool size. If so, it looks like a no-go.

I fear we should consider blocking the device removal until all the 
pages are returned/unmapped ?!? (I hope that could be easier/faster)

/P


