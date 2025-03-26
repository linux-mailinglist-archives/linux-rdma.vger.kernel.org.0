Return-Path: <linux-rdma+bounces-8970-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C684A7169B
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Mar 2025 13:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A0B819A032D
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Mar 2025 12:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8E81E32C5;
	Wed, 26 Mar 2025 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZWnw3c3x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3011E1E18
	for <linux-rdma@vger.kernel.org>; Wed, 26 Mar 2025 12:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742991644; cv=none; b=ZtAuXO0dn8NNm8dC9PWXHeZ3XA/4obunLtlHhbRYfwMGkYBXRD8bIYjCi1WibzpFMogSzCF167YKYU0wTlB6KbsGX0DuJRKA26N57gCfQz8i3rB7abY2xrsYpEDR1Na/ECtmOwxYZnoZLJ694Zzm2tc2J7maK4P+iucyiPDvVJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742991644; c=relaxed/simple;
	bh=fDGZt+SqyiAW6zCfVM1bGeXtRYL5+861efZwXKZVyjc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NQajiM/6CdAGiRCjnGpgTAFPkBh9O9BBY2clGRB0fEDoJrQOW3Z2yw3kI4cGj85OE/LNffu9YhmBfr+KsIzBmcLYg56/i6Ws8gh7mxuTGzf24WzvomUKB04F2/Ccy6YIWWP39gcCw8TqJq9GWdz0zItJu5EfFgI9rR1CpZxJaz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZWnw3c3x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742991641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fDGZt+SqyiAW6zCfVM1bGeXtRYL5+861efZwXKZVyjc=;
	b=ZWnw3c3x2f4EyLXMQC0Qkc4NC5YUhVLm65WPQvoiGOM6rc0VyJ1ThCs5vhrjHTnYRm16IM
	tKjeQbsNkU4/SNXcwbL451aeHMALfU8DLeQSP9MPRERhANBJ4eSJrqWxAnqI5Ma3bRnzM2
	Bbas4JehS05adalCVXo8GcYSN7f0yno=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-e1BWm7jCNPqldA8V2fF00w-1; Wed, 26 Mar 2025 08:20:40 -0400
X-MC-Unique: e1BWm7jCNPqldA8V2fF00w-1
X-Mimecast-MFC-AGG-ID: e1BWm7jCNPqldA8V2fF00w_1742991639
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac3e0c13278so548520266b.1
        for <linux-rdma@vger.kernel.org>; Wed, 26 Mar 2025 05:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742991639; x=1743596439;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDGZt+SqyiAW6zCfVM1bGeXtRYL5+861efZwXKZVyjc=;
        b=i6jvxVtJULEi25swBHPnw7d3g84P9j3N2dvA57v7v7N7GsoaING5FysuXMHquVL06S
         oCLe4x+xp+31VICh7yQObXZiXiLB49N8txSsLOQQ7fAIjlYXFnFcUlH3FLwQ0zSnuqc4
         TzYnhvZG01QGLknbFMmtB+gxl715hmRoNUV20AxAwcrJhr6sspXUnj9/NLUwbYGIatHY
         sD0UK/8vvO3BaRZDmO8Nl+J1PMZc3oQromKvRnP/eRTN0WuezPCDD4wBl9NtmYGdj3Ix
         8Lfv6gYQr3bL//Qlsw8g50tiZbZJTwmNGVVl3h1qbyrE/J3rxl0jRVE/OqiuozwJMAsx
         TQGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX8xrgkrqnRDYT4Tc1aFU0wUjFmcRoqmGvhtVAWDaHKpVtclxvdIzISKxrw0ozjueUfQzMtlTTRoln@vger.kernel.org
X-Gm-Message-State: AOJu0YyWoe2ejHeLuD4rES3TAOwBpDtj/YofIQFQu4IZUAYs/k3esbeu
	QQOpSnmdswVEoR0MArKbYAhoYsIvR04jn7DsTj+xZNkCd67JX/JIvfs3lGxvR1uIx9lyOfYorRp
	WK/VwJCVnq/ZlokZmDxizVbypuIIaPmJoKxKZDkEhRqf4aS7fKV1p2C54HzE=
X-Gm-Gg: ASbGncv65Tdzoz2pgyTnKV9sOM3/fdK8Xq2ERjWHY8zCGPqAwqZQy72BNrPwPlojnyu
	k8MrbqaRZ6ICEuXcu4gBfjhBOiXmaJOYIBlJoDT0Ww+bmvmsrcivNdXQzz6yn8gaxLIjtrEMTHN
	2mfMOag475618BBzNRUaDvlftcorTtkkvbBO2MRs3shmp4Pd9tFhtNrh2rpJgA4mkp3Y8ZN6tkG
	pwFQVg1Ef2L13ySOsE08zSVVv5cEb1Gy7es4/v8IAqRC8yrciI8sUCWqtkz8iTqnds782ydshg9
	1wQTxJ2kIavZaj9JpPyw5rKI6iW75KSsMJ0Tr2PQ
X-Received: by 2002:a17:906:c105:b0:ac1:fab4:a83 with SMTP id a640c23a62f3a-ac3f22aec3fmr1934592166b.25.1742991639131;
        Wed, 26 Mar 2025 05:20:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXpD8SKp1cf90maKHi6um2LlX8ejsXAgc5A98IWT9wYQriYmqy8j/0VlxO8lFqKGic1FYQjQ==
X-Received: by 2002:a17:906:c105:b0:ac1:fab4:a83 with SMTP id a640c23a62f3a-ac3f22aec3fmr1934588766b.25.1742991638698;
        Wed, 26 Mar 2025 05:20:38 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efb65701sm1003437266b.122.2025.03.26.05.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 05:20:38 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4474318FCA84; Wed, 26 Mar 2025 13:20:37 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon
 Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mina
 Almasry <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, Pavel Begunkov
 <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Qiuling Ren <qren@redhat.com>, Yuying Ma
 <yuma@redhat.com>
Subject: Re: [PATCH net-next v3 0/3] Fix late DMA unmap crash for page pool
In-Reply-To: <20250326044855.433a0ed1@kernel.org>
References: <20250326-page-pool-track-dma-v3-0-8e464016e0ac@redhat.com>
 <20250326044855.433a0ed1@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 26 Mar 2025 13:20:37 +0100
Message-ID: <874izgq8yy.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 26 Mar 2025 09:18:37 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> This series fixes the late dma_unmap crash for page pool first reported
>> by Yonglong Liu in [0]. It is an alternative approach to the one
>> submitted by Yunsheng Lin, most recently in [1]. The first two commits
>> are small refactors of the page pool code, in preparation of the main
>> change in patch 3. See the commit message of patch 3 for the details.
>
> Doesn't apply, FWIW,

Ugh, sorry about that; rebased yesterday before reposting, but forgot to
do so this morning :/

> maybe rebase/repost after Linus pull net-next, in case something
> conflicts on the MM side

As in, you want to wait until after the merge window? Sure, can do.

-Toke


