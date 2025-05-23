Return-Path: <linux-rdma+bounces-10615-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66662AC1F0C
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 10:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D88F71BC63BE
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 08:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14996212F94;
	Fri, 23 May 2025 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N62MAUSW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6F51AAA29
	for <linux-rdma@vger.kernel.org>; Fri, 23 May 2025 08:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747990723; cv=none; b=N/qgOTxlo+Rdkioa0gYxTbWzaYw/Cs24p4pueX1NC3kjQ8ScdKHH4byUAaJ2xWbXBv1oM4j7I4rCgiuBcfpIaDpg555lbs6HO5K1E8lH4kpqjWP84Ylf2KbR8V6jSul9cnic2E8GAIg3c2viLzzvGNC290lRArXmqu6yO6YES3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747990723; c=relaxed/simple;
	bh=zDRzq9Tfty91GtEb71CtKU6V6XsJ8Gw0d9DOAy5jhc8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DbiZv8vFdw5a21tKYcmsNvt/LgwqbO5H6fSkl6qN756XO4EBj8otmTRn1O+PqkCOlRhoJ/GgG3RF1wDVEn0PPcrT3t8RDhmf2iH8ceGU6ziZb7QHTM3xSGNoYeSjC+2W46YE0tRSztRolOJZI1b14sTxWxqUYp4wfsOV69tOOMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N62MAUSW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747990721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6J/RUYS6OBOPvuZyXgo5WgF2pNpessZJIoWwbAcSf0A=;
	b=N62MAUSWPqMvB9zMaUDQUYlVbYDGBrEmdZc2fcaWsEhRSAPj0XjfRdLFMPFIEHQvoXyz5n
	OxDDHRTJDRqKaDM2Ax/cQeMjhGlHe7+N74gKmcDVwH3ontyxEotFaycuXqPXem9RUFZKPx
	xuGQNo0GdfCyLkqHpp/B1HFkA3UvS2k=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-Cco283EFNAyElLOPLNmZrA-1; Fri, 23 May 2025 04:58:39 -0400
X-MC-Unique: Cco283EFNAyElLOPLNmZrA-1
X-Mimecast-MFC-AGG-ID: Cco283EFNAyElLOPLNmZrA_1747990718
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-551ebc1bf86so3586252e87.3
        for <linux-rdma@vger.kernel.org>; Fri, 23 May 2025 01:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747990717; x=1748595517;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6J/RUYS6OBOPvuZyXgo5WgF2pNpessZJIoWwbAcSf0A=;
        b=ktzvTZeLBYKYbpKvt3/mYW0uIprAQo1KnzFPVuWARHuVtmHvhUhXeYD8h1rq9Kw78Q
         V6YLHwrPHtingD6wgDeNPoC5oqtEte+UOfzoPb3pzwRx1csPD82jq52b80ahPUil86dN
         6H0LDv8b7TEYeuMtoL96lpAsAPDge9V8IM3C6piphWSHwUZ3YXfrbGlyRbk6TolYZ+vn
         jeMmAtnknMFBVV5pyF0U2IVRzZDk70YfETE03tq+sz4V4mLjEHER8j4KjKqWs07bz8xa
         qgV00SYsg1l2N0IQ8JKbloe6oQHz8CmlXMgf4ttB+N8jaJEeUqk6pAFGibbiMJrqqaU9
         RPgg==
X-Forwarded-Encrypted: i=1; AJvYcCViEt1DxSS6tTqV/QZdXqih+gS7yO3IHiaY4W688PL7Y0hxbzFqiwqoHHmOe1W8hOaA2jT694IPx5gD@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo8q3iJhE4UH8j6auVqQFf3IpsUKRBOivoiWo9LvwKW8IxKssX
	za0d1v10bQtphSJkcFAvbmQ60z7jrwFfoUE5V+NSyQFpz+l0FNu74O8fkAPPa4bjIu5h33mEQpr
	tRd8GCQMcarZbFSQf2luOr2YQC4+z+ge/6SjhkcwD0+9rIDs3kyvh8pGEMi23oOY=
X-Gm-Gg: ASbGnctcX86xijOAs4l3AYVwTwypTQZOnmLbCN7lUdQQneSNs5vWR50h/JnkHVNReSA
	1YAt6/0LOt2HpTNcYmYsk1pNS1fklX4k51IXPxODkmx0JhOrxcIIlVuGRnQF3ory+IEjV1JsFJn
	wPqneD/kmFQW899BbohAjB1jDQ5NaJr1zjB2Cf6NiN0n0VYPgpMUyvKIsAbTHwfY/9JkpoEKlnf
	1WE7GyWakimGnnAtwrJAJbDii0ZQ7TCKaBapK4gL1T+kem69327Yn7NNoi05ri+uQiKKkrei1Hj
	ZfXmgFD+ycpjgG3uPZko8RzfErrQcjITMSF1
X-Received: by 2002:a05:6512:3083:b0:552:31c:d27f with SMTP id 2adb3069b0e04-55216e18aa5mr550267e87.6.1747990717438;
        Fri, 23 May 2025 01:58:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGupqC+46X0tt6Ygg6tbBTVVOo7BQlw5aLij8Bq0jPcx2TjqKILidIf2WS35eedcHMuDdsdg==
X-Received: by 2002:a05:6512:3083:b0:552:31c:d27f with SMTP id 2adb3069b0e04-55216e18aa5mr550242e87.6.1747990716968;
        Fri, 23 May 2025 01:58:36 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e702e03dsm3786008e87.195.2025.05.23.01.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 01:58:36 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D7C101AA3B8A; Fri, 23 May 2025 10:58:33 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, asml.silence@gmail.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
 leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Subject: Re: [PATCH 12/18] page_pool: use netmem APIs to access
 page->pp_magic in page_pool_page_is_pp()
In-Reply-To: <20250523032609.16334-13-byungchul@sk.com>
References: <20250523032609.16334-1-byungchul@sk.com>
 <20250523032609.16334-13-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 23 May 2025 10:58:33 +0200
Message-ID: <87ecwfn1om.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Byungchul Park <byungchul@sk.com> writes:

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
> @@ -4312,10 +4312,7 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
>  #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
>  
>  #ifdef CONFIG_PAGE_POOL
> -static inline bool page_pool_page_is_pp(struct page *page)
> -{
> -	return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> -}
> +bool page_pool_page_is_pp(struct page *page);

Here you're turning an inline function into a function call, which has
performance implications. Please try to avoid that.

-Toke


