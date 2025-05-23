Return-Path: <linux-rdma+bounces-10640-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27021AC287A
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 19:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40E103AF7FC
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 17:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF7C297B97;
	Fri, 23 May 2025 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oEpCZMGZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11BD297B7B
	for <linux-rdma@vger.kernel.org>; Fri, 23 May 2025 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748020892; cv=none; b=Tf6utbeCY+5uSX5KP8drl2GGEP0HgjbGq/ETe0q0eyGbwzsgOTEfhVUyUlaP2Wb6gzR5F2kkgKWW8T274NkY2qAz6FnAEEQhVUPE0Qn7P/+Cfzv8y3dEhlett4ALWBnRlnVCfNuFf4H0TT2Iyj34bFODVcSOtiMyjRWTSDDDBVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748020892; c=relaxed/simple;
	bh=BQIP3osWIZRw7IU3kD1aLl5cw/NxHiXGTkj3yio8VKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQlYB/vgbX/av2RE6wOoTxBDkh2GAdYU/vcgmx0rjM9Hp339nc0wkvZ59xhqLkxnsVpaJQv+GVZLupf6UeKecIbHn/uBzJqBdrs4/u++/BUUKbOxDUZQEFrUvrOddM2hy+XyaJLVbNpbwmD6a5i/SuLtxZ74+QPWPSjRel+Nxug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oEpCZMGZ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-231ba6da557so10745ad.1
        for <linux-rdma@vger.kernel.org>; Fri, 23 May 2025 10:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748020890; x=1748625690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtih47zf1DDRpaty491xvgvfr7R2FPgNSS3Jfeu3Tb4=;
        b=oEpCZMGZtEMlnHjw4F+ow/ibwbbKUB3+IOa+fihdbbc7UczvAiudhxtnN8X0rwVFtM
         0F4rNkiUlKCwvk2OjoYPU+OwjGHBrz3UtA/S7jHd5WRhgfKBBQrnWaH36rPXVkg2Q3/g
         AB8MdaHIShR0A9rxAUJUSIyiSJsIP7Bj/ysbpJyE+SNmT025usZBJA93t6fYgvTfpIk9
         0X7uXx+CFiDVgJ0aeWxwoPTRZauXbrn8Hb9tDLf9P0XymDHdOV/+UpENZgRqq61W8Xa0
         z0L6/ECHekDd4AhT6ZcsxOAirR/UEw5aUjsDh1cqviL+Ph6lwpDCdZRtU3C5r0tR7W3i
         66DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748020890; x=1748625690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtih47zf1DDRpaty491xvgvfr7R2FPgNSS3Jfeu3Tb4=;
        b=ijqv+jNcEkRIyed7fbvQ1NDK50OSZNd1juTYvKIpUV3XVKgqr3joannJbcew73+CU6
         mT+1o4gT6nxCjjMuU7Dnh6CZZLZ/exV3/Y1oCiZTYoOOm6CP3hE6BzScQZdgUD7aeTtH
         dgAGIs2uGmBqmWe2I+SqwVRZQW7+uei97bgKvA3fJQg6oRpgleRmxQqJ4bde3TPyWMvF
         uwnzSWenE3TfU5NP+TyAg1FeGcWcGhtJWLhmVRRWDsmU6QnSjR4R6Y8luzv4EoXZthED
         syvy3ueyEQZLCMVV+kGxgfLc+QzlCaWlNYdP4IiUnLbPFBG3aeEdNlFpE8f1ngjaj2GG
         +R9w==
X-Forwarded-Encrypted: i=1; AJvYcCWcs9rDwkfXrquzVlX8F5i+HnR0w8JS4wg0ik5s7caVNCpSUsmDA0YXaLHAeu4/cI3ooiznSel5EeFx@vger.kernel.org
X-Gm-Message-State: AOJu0YwzOI0eMP/npw29z4c9l1zDkwVnRCxQM6pI3YpUZKWbcEjEhwbe
	8JNV9vAFbOAFzob8xAPRckofaZZ7d/iWhzbZIasy80zGP+ocohEPl2ED4oz9MXY0aKuuaq8k7M4
	lamaAMgJxNDNGLR0kBiq9rgkHAMbJNw/YacEcAkUn
X-Gm-Gg: ASbGnctaQoLAdjeL1bclIvciQ2+f1IrAMgMWFZkDBcBb8wwueK/B0dJTwGJObnbA40/
	AxKqlMaaWRnWFoZaoLzXBRlqzu7l88RPbinjGf9I5kg63TaDasMULMnSt4mE3cTObH6M6oaPBXt
	Mx3g7fOhrFKwaFw5yDW7tWi+S8pgwHIWHjnUViadSPgIO8AgVM9/ki0tcip69X5WV556BdlUs5i
	w==
X-Google-Smtp-Source: AGHT+IH6uGypDsxjqNqq6GSe13hjIu4fqtTlhQ7FXduEvXmZSL8NE0edJn+/pF949ueWwmc6huc8t1yB4vZ6UdiCEdU=
X-Received: by 2002:a17:902:c94c:b0:21b:b3c4:7e0a with SMTP id
 d9443c01a7336-233f343a1demr2947455ad.13.1748020889832; Fri, 23 May 2025
 10:21:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523032609.16334-1-byungchul@sk.com> <20250523032609.16334-13-byungchul@sk.com>
In-Reply-To: <20250523032609.16334-13-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 23 May 2025 10:21:17 -0700
X-Gm-Features: AX0GCFt13q3gircPas-6ILetDX9qRyDvPr7gIiwpBXG0M4D4YVrt7-2ZPVq-CWg
Message-ID: <CAHS8izN6QAcAr-qkFSYAy0JaTU+hdM56r-ug-AWDGGqLvHkNuQ@mail.gmail.com>
Subject: Re: [PATCH 12/18] page_pool: use netmem APIs to access page->pp_magic
 in page_pool_page_is_pp()
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 8:26=E2=80=AFPM Byungchul Park <byungchul@sk.com> w=
rote:
>
> To simplify struct page, the effort to seperate its own descriptor from
> struct page is required and the work for page pool is on going.
>
> To achieve that, all the code should avoid accessing page pool members
> of struct page directly, but use safe APIs for the purpose.
>
> Use netmem_is_pp() instead of directly accessing page->pp_magic in
> page_pool_page_is_pp().
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  include/linux/mm.h   | 5 +----
>  net/core/page_pool.c | 5 +++++
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 8dc012e84033..3f7c80fb73ce 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4312,10 +4312,7 @@ int arch_lock_shadow_stack_status(struct task_stru=
ct *t, unsigned long status);
>  #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
>
>  #ifdef CONFIG_PAGE_POOL
> -static inline bool page_pool_page_is_pp(struct page *page)
> -{
> -       return (page->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
> -}

I vote for keeping this function as-is (do not convert it to netmem),
and instead modify it to access page->netmem_desc->pp_magic.

The reason is that page_pool_is_pp() is today only called from code
paths we have a page and not a netmem. Casting the page to a netmem
which will cast it back to a page pretty much is a waste of cpu
cycles. The page_pool is a place where we count cycles and we have
benchmarks to verify performance (I pointed you to
page_pool_bench_simple on the RFC).

So lets avoid the cpu cycles if possible.

--=20
Thanks,
Mina

