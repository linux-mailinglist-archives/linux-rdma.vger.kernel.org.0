Return-Path: <linux-rdma+bounces-9325-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B5FA8409D
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 12:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C319E0203
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 10:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3762C280CE5;
	Thu, 10 Apr 2025 10:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2HEP5S7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ADA3596F
	for <linux-rdma@vger.kernel.org>; Thu, 10 Apr 2025 10:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744280469; cv=none; b=NgE6shGo++OpRNdRtO7DIjuPYInAQIX/VbKTQtPZJ08jrApNHbdgayceH6bRLR3g1S5PgqEkGV2xSPptRAwgp7k4oUJKex91UszCJLG8vF5r5xxr+LaX9Rurm7sJ3ZHZVNdyo6YT+Bethb2vMLDMPpZoSzM2A4g08rjj8DxlZ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744280469; c=relaxed/simple;
	bh=92JUKxqvz4DOLXtgZ9JCA4V7OtLOo0pA+kZxODRygU8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AG2wYxnvb/0B6jlSJbsmrNrmG9bpxKLjE82If1L7QX4JOrKYhJiox7GfTvdbUSD7O/GTe9skDxsoTG6f5lzar6hFBwNFWng760C1KekkDJaqPR0cx9nWymHGquXEMDhEnv9qnWCBLE5hIe3LNTaF+pB8Btej0v7f1xhmONGdD3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X2HEP5S7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744280465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gj0ddO5JcHA3x6pElFgDxfTHr6tMQmqLYvn6SHOTRag=;
	b=X2HEP5S79mRFkizkDG1skujBBxafhGjqJB/7fFaDShefDDRv84NoScd0ynDHT5t3v9dXze
	DvyZBPesdKZBl9EL8NwNQZcZtPMtiqdJrEeeZ2YoXE0VsooKmxSk52/4bVMLXxcdZIKR7H
	bsg3wUW5HKSUZqhP/Xt/DtW6CpCl98A=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-c0baTEROPkyPEvtyTOoLIQ-1; Thu, 10 Apr 2025 06:21:04 -0400
X-MC-Unique: c0baTEROPkyPEvtyTOoLIQ-1
X-Mimecast-MFC-AGG-ID: c0baTEROPkyPEvtyTOoLIQ_1744280463
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-30bf4297559so5243051fa.2
        for <linux-rdma@vger.kernel.org>; Thu, 10 Apr 2025 03:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744280463; x=1744885263;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gj0ddO5JcHA3x6pElFgDxfTHr6tMQmqLYvn6SHOTRag=;
        b=V7FwuSsLmlyU4F//bT8rwJ3yax1VjE32SZlY7sdvqPWjm+kmq8Hf0ukR7C4aGBcIJA
         +k0l59kM+4gX+tDZkoOS1bYcI8c00+qjlhL/bKE5zHpJSeN6uXuauAJyNIZgozXlrXmo
         r3TCtxwAvdU+LrRWysH6C33Ln/yqfgipRiJLwNlQ6EqRK0/Lwe/vMErs1SH23vNyQR74
         2uexNSMCLxBqgUgGbRHhnNXnbizTblUFYhsKUf/XGpPzdbTX4ds+clKKvMxEUCf+zT6X
         eYdAxXYS5OTJ0dKLXC+6a5fRju5t8hTt2vO2XTnfiIqqA6KCmla1Khrfq53SCetAPrK7
         YvNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMHo9xwXHtMD4IWy/wkibybl8e5ekGcgp+1vDJH/4RzUUj/pNCOJHK5+TkcI1i096VXIKvUAWhdMXn@vger.kernel.org
X-Gm-Message-State: AOJu0YwjlUpjQhRedIuukuqmQ3v1GZBlAbGR/CczwQVE0HthucBBJHTb
	EmgnmRYbV/W0FTW4xVX7Ed7o3rDaXQ6vEFpTaVgbrnRseQH/lrmHpuQZoGVWk21w0wGA3lIWNI+
	nITnCwPzho5e0g0T4hGtoqISEH1sKGVDz7TJ4VZNL8rjHKaXFQ59BUDr8Za0=
X-Gm-Gg: ASbGncuLk2G3iKdAdJfoOtHI2TO1Oak2XRp6cDZ6FabD0Qv7a+xvUMXmgcVP45qxQ+o
	mNE1m5+0y9nZvW6rxLx7pvp0zjXdUDSOTys0A/ZDyzbEMf/uDLu6A0+j8BpirkPpjFVXSQScaeS
	F6qWh6P8z6hIT75yIbnPneW1ZBxzbq7+EdMWecjK7QA0t3+xg4rEnbGueETeeUo5bVAGzDncCrj
	nFoHy2YxDPBhXIlLHZmjnwDa3bCiFMPXTycjzsTa6srJ5iy0elgQaJ75CIYqD4YTs4vOt+U5mbI
	pe7OtMOu/6w8U0MTDbYhtg4qdBGMaTMS/mc1
X-Received: by 2002:a05:651c:1515:b0:30b:9813:b004 with SMTP id 38308e7fff4ca-3103ed4f35dmr5955771fa.34.1744280462778;
        Thu, 10 Apr 2025 03:21:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE17WxZoyH3rbLK0N6NfIbsSGtSK/hr9dYY0iDg1GJ6hNCoga/XB9dPSda2f4ZShTnw6cWIwg==
X-Received: by 2002:a05:651c:1515:b0:30b:9813:b004 with SMTP id 38308e7fff4ca-3103ed4f35dmr5955491fa.34.1744280462404;
        Thu, 10 Apr 2025 03:21:02 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f46623c2bsm4318581fa.111.2025.04.10.03.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 03:21:01 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 7F5E21992272; Thu, 10 Apr 2025 12:21:00 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Zi Yan <ziy@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mina Almasry
 <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>, Yunsheng
 Lin <linyunsheng@huawei.com>, Pavel Begunkov <asml.silence@gmail.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH net-next v9 1/2] page_pool: Move pp_magic check into
 helper functions
In-Reply-To: <D92K7SAU1A06.1APBVXB2AK2HW@nvidia.com>
References: <20250409-page-pool-track-dma-v9-0-6a9ef2e0cba8@redhat.com>
 <20250409-page-pool-track-dma-v9-1-6a9ef2e0cba8@redhat.com>
 <D92K7SAU1A06.1APBVXB2AK2HW@nvidia.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 10 Apr 2025 12:21:00 +0200
Message-ID: <877c3suxkj.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Zi Yan" <ziy@nvidia.com> writes:

> On Wed Apr 9, 2025 at 6:41 AM EDT, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Since we are about to stash some more information into the pp_magic
>> field, let's move the magic signature checks into a pair of helper
>> functions so it can be changed in one place.
>>
>> Reviewed-by: Mina Almasry <almasrymina@google.com>
>> Tested-by: Yonglong Liu <liuyonglong@huawei.com>
>> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>  drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c |  4 ++--
>>  include/linux/mm.h                               | 20 +++++++++++++++++=
+++
>>  mm/page_alloc.c                                  |  8 ++------
>>  net/core/netmem_priv.h                           |  5 +++++
>>  net/core/skbuff.c                                | 16 ++--------------
>>  net/core/xdp.c                                   |  4 ++--
>>  6 files changed, 33 insertions(+), 24 deletions(-)
>>
>
> LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

Great, thanks!

-Toke


