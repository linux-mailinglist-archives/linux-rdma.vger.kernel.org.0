Return-Path: <linux-rdma+bounces-14531-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DA8C63C57
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 12:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 294FC4E76BF
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 11:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082AC23EA9D;
	Mon, 17 Nov 2025 11:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I8bYIGgX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Un8PpfQv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4502264DB
	for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 11:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763378463; cv=none; b=rGViRtXy/QyDX3weq4sG9ww6q9oczL0I7YRvhD3I3pJsaNWEABypXPbDNXxGelfzuQsg+J0iueP3VGgsVaPRvGLR/svP0S60sl3y8EN7Dh9ua3ZfqKw5bwQJyE0FNruwJV366U6Wip2EOskkkndgOFCaV3NutGdAzJl1sXPDhK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763378463; c=relaxed/simple;
	bh=dPcOQIPBIBCLa/NKsa8a0L2Mq5wMH471wz/f//gTuWU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CkTyKDJLZREdtL06TPjYgP6pp92t8qA0DlfA0wbsbCCR2BLaNF3aGGDrJWlnfLwV7YGc4sYxvL9JiuLgL/6pMHigw2Zlh9DFHCfR3AiUuNIWcXR/IpPLgiZ9mHbrG+9dZw3l3aZwk8gRR4haZhey6QheRcPWGgUf/WGoO3LZdwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I8bYIGgX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Un8PpfQv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763378459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QVf9LxNdBO8TaOKgZFNSQsuTbNOO3hmBDaXVsTWiiWA=;
	b=I8bYIGgXifOH20wmS9+zXtI6/O28rgITo46ljUCAfuNK9KFeoDV4GFP+ayX56s8zODiBrX
	3Dzkwj3TDLulB8RyEXQhdfjrdXNqxjHfdAf/PgDEA2O2K11s4h88z/g05q2Sz55pRaoFb3
	NQX/2Srd7fH1KA5tXOYfTIbNA/Uc4bA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-UDD8v3uvPBezh0burQVsAw-1; Mon, 17 Nov 2025 06:20:58 -0500
X-MC-Unique: UDD8v3uvPBezh0burQVsAw-1
X-Mimecast-MFC-AGG-ID: UDD8v3uvPBezh0burQVsAw_1763378457
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-640b06fa998so3862781a12.2
        for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 03:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763378457; x=1763983257; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QVf9LxNdBO8TaOKgZFNSQsuTbNOO3hmBDaXVsTWiiWA=;
        b=Un8PpfQvqC5wTzErk38aMO3hEdRvYC+9HtuNTDGBm9eo9yKT41VxFEqSkHgp8wYcnf
         8aQAQoGDUFWK8yN26R0WEYsVQtyGmapOQoHTSi81dPLUDDC6bb2IO9WJdnQxAHMIlIuX
         SJK4J5GZQz/Hq3fbkdDS/Y8Waxb7c7eqBKR9wG7T2mfSFdiLGYd989bXAn0vLTvsC8SL
         bhk3wrqgrmYDyWLgLqUsCJOW6lpgbg3TMTlG8qCGxSrCmY8Ru2F9SC3ir0YU8HoFtzu6
         wq8rR1SU1XpJQR4UMj9DuCQLWS6Lz4Tiz3HXvtBPEEshYksNe8mE3S05vEV4AY2u0gu5
         OH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763378457; x=1763983257;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QVf9LxNdBO8TaOKgZFNSQsuTbNOO3hmBDaXVsTWiiWA=;
        b=pha9qFWvozbdPIvhMBoFXCwhUSV61y7VXWrRzu0bocB6hFuJ1A5spUKmy9/n1ip6mP
         I/xXWzRmhXsVJxIhTK9L/ccgMcHBZGBGKCRVyhwG2ErvYcchh+jFLm0fM7jfJk4NfgPV
         2bJNZgzT0U0q7t2mGU9EF7ZycNqKonoxsKUi5TVHb3LWkq0uD0ovFx3m9SE8lePa3qju
         FkHaSuj7DrRwKKUO/fWAfVR477UxIFqBxSy098T2FBlhI64tUrNM8Za3ldiukodZ2Lux
         0Vsmux2y7+8yTPwC+u5B4WqQgAfpgcAxKrZ0EFu1OVQTAhRCLd3CsmwE6jv8imatzvYV
         P8Nw==
X-Forwarded-Encrypted: i=1; AJvYcCXNUZ9jH6fX3VaImnHfUu1Fj7EColzSHLzdBXJHMTHBQII5LtI8S3SPaQ3/0e49DszfHQKlOKIwseSf@vger.kernel.org
X-Gm-Message-State: AOJu0YylczZyo8TYYfmGiqT+pue/fMwj2/GIuIhuvMiOISA+nhiHmFGK
	qhoKigUxZKNsV8L3/SLDjRE1WSG5UkmyyC7Z6/wPbVeCn+RFspqoc+TpgTfUklqCRB/fO+o596J
	/JTiZ0oUxCvJIetUnxbWkrZeQi/h1YZsN+0HScP+Q79E++0TKWwmI4vfgYvR2s8g=
X-Gm-Gg: ASbGncs4UGnhQujwuOH9MGxpYf26l8ekL4YWKJNVSuuHy5Sb7gmJQYc3AcWN9KReZ4a
	HZGKCwhKX/4Xgyjj+nlShOC+HK3ceqV4Sjo6Osh0TP30Aq3W5sgeOKez4X7fphdMRSrehncKWrR
	bP7/CbweHXGz3fbGe1NyAn8TRrZKGZSJ9TUS8JCWOwdrWlCcpR8z/5Gw+N/rQVG84i7pMpb25Wd
	SRpy+hlleewABn+qpOaEM2an0f07N7X7hHi0jpMDwiJJeL5HWXZYtgqkyPayz1rRKHXYKZVgVQr
	0K7guIvlARPRLQEiT0MiRKvG5JJT/wlnF4iyzfxPspKtbisX0vQshoU0gFT8QZULlUmdDJNG1zt
	0o2iv/AdnjFNZoRz4pZ06wGk8nw==
X-Received: by 2002:a05:6402:51d0:b0:640:b736:6c15 with SMTP id 4fb4d7f45d1cf-64350e23625mr11703554a12.10.1763378456996;
        Mon, 17 Nov 2025 03:20:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4Wdj00OQMd3S1KCNlU9xBz46Uej0UIJ1gNeKRvwBEkwOcay/vlwA/7tWC70CgNVFMvt+NUw==
X-Received: by 2002:a05:6402:51d0:b0:640:b736:6c15 with SMTP id 4fb4d7f45d1cf-64350e23625mr11703494a12.10.1763378456453;
        Mon, 17 Nov 2025 03:20:56 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a49806csm9992622a12.18.2025.11.17.03.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 03:20:55 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1D7AF329B3D; Mon, 17 Nov 2025 12:20:54 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, horms@kernel.org, jackmanb@google.com,
 hannes@cmpxchg.org, ziy@nvidia.com, ilias.apalodimas@linaro.org,
 willy@infradead.org, brauner@kernel.org, kas@kernel.org,
 yuzhao@google.com, usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
 almasrymina@google.com, asml.silence@gmail.com, bpf@vger.kernel.org,
 linux-rdma@vger.kernel.org, sfr@canb.auug.org.au, dw@davidwei.uk,
 ap420073@gmail.com, dtatulea@nvidia.com
Subject: Re: [RFC mm v6] mm: introduce a new page type for page pool in page
 type
In-Reply-To: <20251117052041.52143-1-byungchul@sk.com>
References: <20251117052041.52143-1-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 17 Nov 2025 12:20:53 +0100
Message-ID: <87o6p0oqga.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Byungchul Park <byungchul@sk.com> writes:

> Currently, the condition 'page->pp_magic == PP_SIGNATURE' is used to
> determine if a page belongs to a page pool.  However, with the planned
> removal of @pp_magic, we should instead leverage the page_type in struct
> page, such as PGTY_netpp, for this purpose.
>
> Introduce and use the page type APIs e.g. PageNetpp(), __SetPageNetpp(),
> and __ClearPageNetpp() instead, and remove the existing APIs accessing
> @pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
> netmem_clear_pp_magic().
>
> Plus, add @page_type to struct net_iov at the same offset as struct page
> so as to use the page_type APIs for struct net_iov as well.  While at it,
> reorder @type and @owner in struct net_iov to avoid a hole and
> increasing the struct size.
>
> This work was inspired by the following link:
>
>   https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com/
>
> While at it, move the sanity check for page pool to on the free path.
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Co-developed-by: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Zi Yan <ziy@nvidia.com>
> ---
> I dropped all the Reviewed-by and Acked-by given for network changes
> since I changed how to implement the part on the request from Jakub.
> Can I keep your tags?  Jakub, are you okay with this change?

LGTM, you can keep mine :)

-Toke


