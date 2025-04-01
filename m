Return-Path: <linux-rdma+bounces-9062-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6997A77797
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 11:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8F4E1887BA6
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 09:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6DA1EF080;
	Tue,  1 Apr 2025 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A1QF+/mA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E4A1EF087
	for <linux-rdma@vger.kernel.org>; Tue,  1 Apr 2025 09:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743499221; cv=none; b=YvW3bJS9I1G0JMtdz1390GK4sUmv178+EAhhgh4bnT2YN9XRxjfDGOsrGxiqoRQD9GlyqJ+EMJb25Ra5wlZNJTTiWKkZZWyaWKK7rBROOXwxy94FoVKI8EPQd8YMJMleUA3wJHuR3hnsZZaUd08VNV08se+pVLPbE9jARAs/7XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743499221; c=relaxed/simple;
	bh=gX/0To/6YtBCqwy2SgsC4Ii7GnI2MAJKI9nklFY1vT0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tg56sS2Sy4wpAjol/yT5fKt54JgPgDhZGB3Ic1c+EgI8t3FjRS306g8zlcvn7CMK8ms4B8xpMoIuezZNwnAfxI4x4/68rsWebhajdcHcvfyDU7ZQEkGqf2VKwYH790w8zc+BVpT1zsenyJuHK4a0lzSmYLZNtwMY8ZIjLZSrH6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A1QF+/mA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743499219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=heGA+8Yin7XsohFnbU8J4lLXr8jl9xDIj/NCrhpNVe4=;
	b=A1QF+/mAvXMSRDXxgt9lWuCEg87Qdv+cyWKC83a/smkAsHb+DTxuq4jxUUQ1OF2iPghsPL
	gEtJiaijirqwOps85PT0UFX2h62Q3HxylHvdm6Ly72UtnLjr0euh4p0MRQWcWq+0bBh5Ea
	/9QXniezb3vPSE2fqNjFbaVwdFQiQsY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-J923sKKQPv27fiXcT7uyXQ-1; Tue, 01 Apr 2025 05:20:17 -0400
X-MC-Unique: J923sKKQPv27fiXcT7uyXQ-1
X-Mimecast-MFC-AGG-ID: J923sKKQPv27fiXcT7uyXQ_1743499216
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5499a93f894so3334186e87.1
        for <linux-rdma@vger.kernel.org>; Tue, 01 Apr 2025 02:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743499216; x=1744104016;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=heGA+8Yin7XsohFnbU8J4lLXr8jl9xDIj/NCrhpNVe4=;
        b=hC+UknyAr6kVhTzC/YroG1QIbt/1vfUOmqLw440wWAhZMjD2Q1mnTdcNYxIP+yZxcG
         lQoELuSwCtUob7kA39vnzPnwf2CKfvHY/9nKpfvN4RN1liK41SITkAew9pncxoJAq7BM
         dD+obx0SEk1zn8VG11D8jcAoY4XofFjCz9n4msDJ/oJy1xyo64ayn6RuV39WFP0mgmLN
         rQ7800QdN1IMOLJHXg1T98BmA5KcyPvjgV8OI61CDEq1cnTjQOmul1v4tCXN3om6U+JR
         lMtBAs/0bL3zjPRXwlzkToaod8zb/4lMynytnvownxIcKZg7utUQjHN41MSEcCBQxPyX
         nkNg==
X-Forwarded-Encrypted: i=1; AJvYcCWUN0gCo6FUt1qtG5ikoNQaiDm2RuHWoObZXBz9QL9f0E6t743KKyV8FKUMUDcis8LhC+rN7Ia34qnu@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Du4mFJqn4QYCBXah0NomGcHOLNhnwouHtV4cG4ne+QrbQa6z
	gbUwDpBxH6ROcwdHqij2+MfxdSryXaiPo8UbklqTnxkFFcLb2aA2gn6O1ny2WYbd6hsH1fwkqKZ
	bLAt+Vrh6IpiibvkLh46PkNBgvQoHVzIDixmrXQWie2Qlyd7zevVmnELwDec=
X-Gm-Gg: ASbGncs57mBaQgd/sRbtAwCPnnuYyHOSpsDV/uodRaddTsPY7/NivsCLzpUL6ihtkyM
	IBAOGenmpKi80vOGiBuDtHUeWRtmj9omQFkgxxU7sA6+almBcP9j9+8B4A8ZKvBOVPZQsJoDmu1
	Z0BoWlE5WJDGJJdSyVpKLdN0rgE26XlTvpgwL8aIEzFDz7Ht9vUvPzCECfrHyGGomRBKleNGe9X
	LusWQ75xRxpHj/y4CaYSAd3haT5C8qoMZXFmGSw0TXo8RBJsHTsTEARXlp/qVw8qg+4WdQzLZYs
	l8orVhNFiDwukiRDzCGPS5/fIWU1Sdo/yXRMjIYC
X-Received: by 2002:a05:6512:3f04:b0:54b:117f:686e with SMTP id 2adb3069b0e04-54b117f6902mr3637417e87.27.1743499216256;
        Tue, 01 Apr 2025 02:20:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmmFffSwB8Z29FU4ImF8MFszvFBnxPrac+wWziJPyVeOFUs+I7ScJdTpfzV4RapF89FKPnIA==
X-Received: by 2002:a05:6512:3f04:b0:54b:117f:686e with SMTP id 2adb3069b0e04-54b117f6902mr3637402e87.27.1743499215879;
        Tue, 01 Apr 2025 02:20:15 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54b094c1db9sm1297217e87.78.2025.04.01.02.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 02:20:15 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0BCA518FD259; Tue, 01 Apr 2025 11:12:36 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mina Almasry
 <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>, Yunsheng
 Lin <linyunsheng@huawei.com>, Pavel Begunkov <asml.silence@gmail.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Qiuling Ren <qren@redhat.com>, Yuying Ma
 <yuma@redhat.com>
Subject: Re: [PATCH net-next v5 2/2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
In-Reply-To: <38b9af46-0d03-424d-8ecc-461b7daf216c@redhat.com>
References: <20250328-page-pool-track-dma-v5-0-55002af683ad@redhat.com>
 <20250328-page-pool-track-dma-v5-2-55002af683ad@redhat.com>
 <38b9af46-0d03-424d-8ecc-461b7daf216c@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 01 Apr 2025 11:12:35 +0200
Message-ID: <87y0wkmeik.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni@redhat.com> writes:

> On 3/28/25 1:19 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> @@ -463,13 +462,21 @@ page_pool_dma_sync_for_device(const struct page_po=
ol *pool,
>>  			      netmem_ref netmem,
>>  			      u32 dma_sync_size)
>>  {
>> -	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev))
>> -		__page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
>> +	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev)) {
>
> Lacking a READ_ONCE() here, I think it's within compiler's right do some
> unexpected optimization between this read and the next one. Also it will
> make the double read more explicit.

Right, good point; will respin!

-Toke


