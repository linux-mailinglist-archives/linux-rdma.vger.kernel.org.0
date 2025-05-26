Return-Path: <linux-rdma+bounces-10716-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D65AAAC3BD2
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 10:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9612D3A5C25
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 08:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CCA1EF080;
	Mon, 26 May 2025 08:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dZnka8DP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0071E7C05
	for <linux-rdma@vger.kernel.org>; Mon, 26 May 2025 08:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748248840; cv=none; b=kBNk4biVQpFvy1Wjf13kofZkArb96kWwen6ui9vTPO9YOiu4NtPnTQLQDQ+zDjUR4cRzSD34rah8yxpcDRV7zoh8FodvTXdOngdG+WzwNa/HwMYscbtHkIbkJIKouBD3Ti8if42AOu/Ype9q3uVeDNkg7pxXdbSE2oTdOgci2Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748248840; c=relaxed/simple;
	bh=rwTtRZWCBpccCiljfC4gt2cz8aSV2o9lUsihGbkmj+0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FjGDTftfMMvmo16Jz9Zh6a2h1VPQjg+JCw6g0b8U1+XShCbqYLZH39iqNJpPfzZMKkIyrBbCsqOE2OqQT48nWAKQ1zSCpv90DDEHcPQmB4VBXJt3V26rH4s+5NK8COfBRs4JBhTcHPzBuG+50eHDtAdBAiexLwMugu/jHR0Rd/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dZnka8DP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748248838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BORtL2zM0qRE1V/C8MwfA7aWdB6U+L7cFknUtojSlEg=;
	b=dZnka8DPJyVtHA35RhO9pMOw3qeahr59YaWY017N5jyklD5cW8YlqnvpKpf1KmwhFIyvhZ
	8T8af0AkH5cnJmwFSFuA5MAvVkgIZRmq40Hvg8UvSVWRwAvP6klNQbSHpA7514zRwoc34G
	ZCl/nI1W7gw9hG0okGMlsRa/t9tkM5k=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-cCOk-IDlNNmfheC9eWTnMg-1; Mon, 26 May 2025 04:40:34 -0400
X-MC-Unique: cCOk-IDlNNmfheC9eWTnMg-1
X-Mimecast-MFC-AGG-ID: cCOk-IDlNNmfheC9eWTnMg_1748248833
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-550eb7606c1so1075006e87.0
        for <linux-rdma@vger.kernel.org>; Mon, 26 May 2025 01:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748248833; x=1748853633;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BORtL2zM0qRE1V/C8MwfA7aWdB6U+L7cFknUtojSlEg=;
        b=PO6CogGAVyVTdhwmIAFc1Lygj1F0wfIdiexrWAFhKAXkxRbMUtSTJeerY/AJmDJOuX
         w0SPdBd1tS6KrQgzbbvO+JugP4m9Iml4mcT1SoSRtYVnUHTbfj7ftCRWEsXjUOlvyPxC
         uU6V6i1aSZvmuLL0doVHmGkmouYtaGcqVac+hgX0zFRDSJ+CG9qRyuV2CdcJgpCR5nSG
         MetpgbedEUztE2nn0+Cj9fU5xPCy3BemoeZKaXhS59bHs6h7z0sjLAa88VnsU6PD3QAd
         BmlEB9aiMT2Y9PcQqlv2BxtozWklrRquulW2jamtoG64eCQVfq9603euwXnj07LLZM1H
         c9aA==
X-Forwarded-Encrypted: i=1; AJvYcCXDQyzSXSxdB1XQu1Q55UTXLbUj2B3EqhW4JKWdV6ddGTflOSV1uoAo7A1+qm1RBB9tZJd27rBrzv4V@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8TLKVSuEmx00ElIMqwv1Xx/sfEXDqFCjDBsRvyASKr5mhPFFn
	mcWCE4R0LEH73B/tqFt9oXM7ToR/bVz/Ccyog2u109SSK+m/a0Qpt/7yf5cffBAez9KpKsxWAy7
	dc0Vyj3KF4W0uqzlcDLXOQd6lnYzPqeAAzcJAtrLEpF8ROPHCsG1m/qh2pOfn614=
X-Gm-Gg: ASbGncu52TMHfhXleP2atii6HclFvW4XbPHIg7JIxZpHb4NKEYS+YgZQ1Qk/i8ViLTB
	tUBEsVLZfBwTh+w6+kk4KwOjBWqO/F8vE/+AmI+yw/WQqbtO+kM8Rcf8JKpFNLvHcJPydQ0P2KI
	EknYQZiJeLT4lDrXw9LZus/eMg5MfZf5oF/2qcuqNg6ZZ5vDSft4zhTnJT0Ybndqlfw7uwQuBDS
	C053OgNFljxtDL2XbTH/zwnzEDuSoRzSs60WY+GPCuErLIlPJDU8jyV2C54sPDWc44WjzzF1PpZ
	cuzCDPzZ
X-Received: by 2002:a05:6512:1054:b0:549:7354:e4d1 with SMTP id 2adb3069b0e04-5521cba97e8mr2217309e87.38.1748248832943;
        Mon, 26 May 2025 01:40:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSksxY/4SDl8nPx9ETpT8GNSo1fb9YNjKF6Ytk8769B3WbBYxWl3jw2VybR5HjV+gllf9dmg==
X-Received: by 2002:a05:6512:1054:b0:549:7354:e4d1 with SMTP id 2adb3069b0e04-5521cba97e8mr2217267e87.38.1748248831957;
        Mon, 26 May 2025 01:40:31 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e6f161c7sm5044691e87.24.2025.05.26.01.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 01:40:31 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 5CC4B1AA3EEA; Mon, 26 May 2025 10:40:30 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Byungchul Park <byungchul@sk.com>, Mina Almasry <almasrymina@google.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com,
 kuba@kernel.org, ilias.apalodimas@linaro.org, harry.yoo@oracle.com,
 hawk@kernel.org, akpm@linux-foundation.org, davem@davemloft.net,
 john.fastabend@gmail.com, andrew+netdev@lunn.ch, asml.silence@gmail.com,
 tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 horms@kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 vishal.moola@gmail.com
Subject: Re: [PATCH 12/18] page_pool: use netmem APIs to access
 page->pp_magic in page_pool_page_is_pp()
In-Reply-To: <20250526023624.GB27145@system.software.com>
References: <20250523032609.16334-1-byungchul@sk.com>
 <20250523032609.16334-13-byungchul@sk.com>
 <CAHS8izN6QAcAr-qkFSYAy0JaTU+hdM56r-ug-AWDGGqLvHkNuQ@mail.gmail.com>
 <20250526022307.GA27145@system.software.com>
 <20250526023624.GB27145@system.software.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 26 May 2025 10:40:30 +0200
Message-ID: <87o6vfahoh.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> On Mon, May 26, 2025 at 11:23:07AM +0900, Byungchul Park wrote:
>> On Fri, May 23, 2025 at 10:21:17AM -0700, Mina Almasry wrote:
>> > On Thu, May 22, 2025 at 8:26=E2=80=AFPM Byungchul Park <byungchul@sk.c=
om> wrote:
>> > >
>> > > To simplify struct page, the effort to seperate its own descriptor f=
rom
>> > > struct page is required and the work for page pool is on going.
>> > >
>> > > To achieve that, all the code should avoid accessing page pool membe=
rs
>> > > of struct page directly, but use safe APIs for the purpose.
>> > >
>> > > Use netmem_is_pp() instead of directly accessing page->pp_magic in
>> > > page_pool_page_is_pp().
>> > >
>> > > Signed-off-by: Byungchul Park <byungchul@sk.com>
>> > > ---
>> > >  include/linux/mm.h   | 5 +----
>> > >  net/core/page_pool.c | 5 +++++
>> > >  2 files changed, 6 insertions(+), 4 deletions(-)
>> > >
>> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
>> > > index 8dc012e84033..3f7c80fb73ce 100644
>> > > --- a/include/linux/mm.h
>> > > +++ b/include/linux/mm.h
>> > > @@ -4312,10 +4312,7 @@ int arch_lock_shadow_stack_status(struct task=
_struct *t, unsigned long status);
>> > >  #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
>> > >
>> > >  #ifdef CONFIG_PAGE_POOL
>> > > -static inline bool page_pool_page_is_pp(struct page *page)
>> > > -{
>> > > -       return (page->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
>> > > -}
>> >=20
>> > I vote for keeping this function as-is (do not convert it to netmem),
>> > and instead modify it to access page->netmem_desc->pp_magic.
>>=20
>> Once the page pool fields are removed from struct page, struct page will
>> have neither struct netmem_desc nor the fields..
>>=20
>> So it's unevitable to cast it to netmem_desc in order to refer to
>> pp_magic.  Again, pp_magic is no longer associated to struct page.
>
> Options that come across my mind are:
>
>    1. use lru field of struct page instead, with appropriate comment but
>       looks so ugly.
>    2. instead of a full word for the magic, use a bit of flags or use
>       the private field for that purpose.
>    3. do not check magic number for page pool.
>    4. more?

I'm not sure I understand Mina's concern about CPU cycles from casting.
The casting is a compile-time thing, which shouldn't affect run-time
performance as long as the check is kept as an inline function. So it's
"just" a matter of exposing struct netmem_desc to mm.h so it can use it
in the inline definition. Unless I'm missing something?

-Toke


