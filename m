Return-Path: <linux-rdma+bounces-10721-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD18AC3D66
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 11:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EFF5188F9FA
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 09:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A118E1F4639;
	Mon, 26 May 2025 09:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G8ceGO8y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62B61F4282
	for <linux-rdma@vger.kernel.org>; Mon, 26 May 2025 09:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748253282; cv=none; b=tu96LC88DteMsxyPx8tBZ6XiqLrkBo2BpLpw04uApIXKIL58BM9jk99lI0rZCaQnLc9GUszxm0Xb6O+qFi/ccWQDE+Uthi8YCjLvKzVzbLbbVY9NKZPFtnROi6Rtmt5yIDv4B56xFDXUwQW2qo4pT9BxPZVn2njPUXFYg5A4vfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748253282; c=relaxed/simple;
	bh=kD211Oy2EHW/gbr+iQCEUkM/lwARmu9Fp6jVXRBFF74=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LAQNyQ1OzzWG97GH3AF/5pRQtg5yMPaKkGLDZRTVNi+zHNJxLz9w5H0FsI3LANu6oabFFhlhOyI7Nx2prvdlG5FVqoyVAj4KeGoYL9EZL5CSzxKmeCIT/oj/nJZ8wO7q3ieV9AX6KhhwN+RbHLCmLyNx0kGn2vsmGQxYLDmnrro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G8ceGO8y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748253279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rbkf5SXMEt07fFLjzJMCpshPrtgBoRho3TpNiZRvX78=;
	b=G8ceGO8yUeTK7smI23EMaY43TYqWTOrYshsnH5WY3crGjAbIsg8CXkVEtRRNBR5si6UmWa
	WawQTibg5vQQjJHSda1vSfQOtFMgTz8LbLgcSsxRAazRZmDjnasN4c4lG3Q6rmE5/FqKd6
	tu0tN0pXS/0pcwmcH/7xj1cC1QRGPdo=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-iaIv3sYqM1K8Fy8IeEGSZQ-1; Mon, 26 May 2025 05:54:37 -0400
X-MC-Unique: iaIv3sYqM1K8Fy8IeEGSZQ-1
X-Mimecast-MFC-AGG-ID: iaIv3sYqM1K8Fy8IeEGSZQ_1748253276
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-551fca29263so878192e87.2
        for <linux-rdma@vger.kernel.org>; Mon, 26 May 2025 02:54:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748253276; x=1748858076;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rbkf5SXMEt07fFLjzJMCpshPrtgBoRho3TpNiZRvX78=;
        b=UeICsLX8Y1RxaNuib+GU2HBz2bgl+wZnvUNBCoS/HKxlofp51ETULgC3jpUOvQAub6
         kVpKyi5Pe4Q5v9tSrCs5MGMUKkwM5wKNKoPxVBnVdwXqlQ9R+J9VXPOjwvy1S4ObMMke
         52jASMW3UfR/XzPgaqiYGcJtXmuNxYSRW/UcLC0rUoK+VyM2XDUXUmRl8sbKdAVkPrba
         IJxxjzYfrK0n9Tkunn9/Vd20WSll2g/dAdHBIZgBK6hL8RbHUTIqr9CH9oHswOPE8Q38
         qYWfUNQLFIStD+cL5ApH6//sInrfgJsNAxeQXr5SQ6Y/QN5wpVP5OwyWLSeFb/AxOUSN
         8BKg==
X-Forwarded-Encrypted: i=1; AJvYcCUng579tn710t/+ez/y3gxNVv3jeyYl7iubkIXwaI5Jr2LZANc1UIsn/9Er3i+fainA1u8DR9Ksol3J@vger.kernel.org
X-Gm-Message-State: AOJu0YzyrNzOFycsWlWOwv4QU4fK9cM7fHAhpyrhPdV8HJ+LvpOuJgkD
	EPBXenJVkidlkIK+RtVN3YXwsxsd7n6zr03MEnYymwxAR9FcUkN30kDUHD4iaeKVoHZaKnGpG6r
	R2AA4aXSc1QT1OWM/OPDgMibM2MnzdVuFmrJ9o4pN/W1g/GzBD8cR8Gd+ymCfHQxS2Rw8UUk=
X-Gm-Gg: ASbGncu5Uz5J3w7o7uO7idOuPDQ9NdMbwbOI9pAf7kbqPUhr8J1nK4wNyydkosHh+Ul
	Ia6QsqpTaUfhpfsmh0I6N+lSx5ts/o1jJjvIZRi+oVy/PxhvbM8xiEZ7pjZrX41C/2yOdx9tyGY
	O84rLQnXDSTEOdbNFc5yhudzRNs+D6xLzLloEhqIgyPC5fDtVIL/F7L7BaIDEkD/Z7PpTosmoUr
	lcNKsAGxmFtG1kKwUkHFVsRq1sfmVWRM1KbRlH1lMQhI8mwjSJfnuYy3oLWAoGg5SIkmJMurk5I
	3yRAZDz/
X-Received: by 2002:a05:6512:4150:b0:552:20e1:ee25 with SMTP id 2adb3069b0e04-55220e1ef6amr937497e87.55.1748253275974;
        Mon, 26 May 2025 02:54:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkPECe1NVeXWiPUcDqM4DGhgBrZ5f5uYScFTI8314epzyCSBb2KXwKVqpiQCkibcuen2wvqA==
X-Received: by 2002:a05:6512:4150:b0:552:20e1:ee25 with SMTP id 2adb3069b0e04-55220e1ef6amr937461e87.55.1748253275480;
        Mon, 26 May 2025 02:54:35 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5532503cd79sm84170e87.207.2025.05.26.02.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 02:54:34 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id BF6291AA3EFC; Mon, 26 May 2025 11:54:33 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Byungchul Park <byungchul@sk.com>
Cc: Mina Almasry <almasrymina@google.com>, willy@infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, ilias.apalodimas@linaro.org,
 harry.yoo@oracle.com, hawk@kernel.org, akpm@linux-foundation.org,
 davem@davemloft.net, john.fastabend@gmail.com, andrew+netdev@lunn.ch,
 asml.silence@gmail.com, tariqt@nvidia.com, edumazet@google.com,
 pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Subject: Re: [PATCH 12/18] page_pool: use netmem APIs to access
 page->pp_magic in page_pool_page_is_pp()
In-Reply-To: <20250526094305.GA29080@system.software.com>
References: <20250523032609.16334-1-byungchul@sk.com>
 <20250523032609.16334-13-byungchul@sk.com>
 <CAHS8izN6QAcAr-qkFSYAy0JaTU+hdM56r-ug-AWDGGqLvHkNuQ@mail.gmail.com>
 <20250526022307.GA27145@system.software.com>
 <20250526023624.GB27145@system.software.com> <87o6vfahoh.fsf@toke.dk>
 <20250526094305.GA29080@system.software.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 26 May 2025 11:54:33 +0200
Message-ID: <87ldqjae92.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> On Mon, May 26, 2025 at 10:40:30AM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Byungchul Park <byungchul@sk.com> writes:
>>=20
>> > On Mon, May 26, 2025 at 11:23:07AM +0900, Byungchul Park wrote:
>> >> On Fri, May 23, 2025 at 10:21:17AM -0700, Mina Almasry wrote:
>> >> > On Thu, May 22, 2025 at 8:26=E2=80=AFPM Byungchul Park <byungchul@s=
k.com> wrote:
>> >> > >
>> >> > > To simplify struct page, the effort to seperate its own descripto=
r from
>> >> > > struct page is required and the work for page pool is on going.
>> >> > >
>> >> > > To achieve that, all the code should avoid accessing page pool me=
mbers
>> >> > > of struct page directly, but use safe APIs for the purpose.
>> >> > >
>> >> > > Use netmem_is_pp() instead of directly accessing page->pp_magic in
>> >> > > page_pool_page_is_pp().
>> >> > >
>> >> > > Signed-off-by: Byungchul Park <byungchul@sk.com>
>> >> > > ---
>> >> > >  include/linux/mm.h   | 5 +----
>> >> > >  net/core/page_pool.c | 5 +++++
>> >> > >  2 files changed, 6 insertions(+), 4 deletions(-)
>> >> > >
>> >> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
>> >> > > index 8dc012e84033..3f7c80fb73ce 100644
>> >> > > --- a/include/linux/mm.h
>> >> > > +++ b/include/linux/mm.h
>> >> > > @@ -4312,10 +4312,7 @@ int arch_lock_shadow_stack_status(struct t=
ask_struct *t, unsigned long status);
>> >> > >  #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
>> >> > >
>> >> > >  #ifdef CONFIG_PAGE_POOL
>> >> > > -static inline bool page_pool_page_is_pp(struct page *page)
>> >> > > -{
>> >> > > -       return (page->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATU=
RE;
>> >> > > -}
>> >> >=20
>> >> > I vote for keeping this function as-is (do not convert it to netmem=
),
>> >> > and instead modify it to access page->netmem_desc->pp_magic.
>> >>=20
>> >> Once the page pool fields are removed from struct page, struct page w=
ill
>> >> have neither struct netmem_desc nor the fields..
>> >>=20
>> >> So it's unevitable to cast it to netmem_desc in order to refer to
>> >> pp_magic.  Again, pp_magic is no longer associated to struct page.
>> >
>> > Options that come across my mind are:
>> >
>> >    1. use lru field of struct page instead, with appropriate comment b=
ut
>> >       looks so ugly.
>> >    2. instead of a full word for the magic, use a bit of flags or use
>> >       the private field for that purpose.
>> >    3. do not check magic number for page pool.
>> >    4. more?
>>=20
>> I'm not sure I understand Mina's concern about CPU cycles from casting.
>> The casting is a compile-time thing, which shouldn't affect run-time
>
> I didn't mention it but yes.
>
>> performance as long as the check is kept as an inline function. So it's
>> "just" a matter of exposing struct netmem_desc to mm.h so it can use it
>
> Then.. we should expose net_iov as well, but I'm afraid it looks weird.
> Do you think it's okay?

Well, it'll be ugly, I grant you that :)

Hmm, so another idea could be to add the pp_magic field to the inner
union that the lru field is in, and keep the page_pool_page_is_pp()
as-is. Then add an assert for offsetof(struct page, pp_magic) =3D=3D
offsetof(netmem_desc, pp_magic) on the netmem side, which can be removed
once the two structs no longer shadow each other?

That way you can still get rid of the embedded page_pool struct in
struct page, and the pp_magic field will just be a transition thing
until things are completely separated...

-Toke


