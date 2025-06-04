Return-Path: <linux-rdma+bounces-10981-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CDFACE10C
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 17:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0974A3A84B9
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 15:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC59D29117B;
	Wed,  4 Jun 2025 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lYzCSoQM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018C6290D80
	for <linux-rdma@vger.kernel.org>; Wed,  4 Jun 2025 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749050072; cv=none; b=HBpWBUQW+s0Fg+8ME2XiO0qYUqL9Gst9M6+vho6L47cso9FEIf6jb3wmrVeM5scrFBYSdc1HmlW6Hb4g+F/D46X28WSDOlC7MTP/aTcXS9fNbUodpoT78PIr+VF/SA8OtlWwHaYEqld6+EpjouqOkxcbkcLTg/6I6EIoq/oHHVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749050072; c=relaxed/simple;
	bh=Vz9j+gRU9u8lCxApmtclw2M381IMN+MeB6Q2Te9JwCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uG7Shx/0YRIP2OLRqj0wY4wZVc3ZlNzPEdZXlki/+xtqmWqIJxuJ9AlXJpUL8ntagwsMLXRQqhgwHgU4dhlV/pNFVXQ9Fjm4mIvXzjVqhM1ktOoYUpCFpYyhOulvPkoSSjH4Pwh10qPdwwcXcDzgUDcDASUX1SKqwerVd/5lts0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lYzCSoQM; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a58ef58a38so248201cf.0
        for <linux-rdma@vger.kernel.org>; Wed, 04 Jun 2025 08:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749050070; x=1749654870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utxbGnGIbzF8mH+ke5le74ATfkvfWNo9bI2IYs+ukk0=;
        b=lYzCSoQMcqvJ6myfaxuhILu7NMmHb563kKHRdGsqsWaVwIJpGGPnR+17TNIBmWM5N0
         2ZEy0+oyZYlYzi0S4KCF2BKnluIzUL/uYRhSIY+7Jw94zYiMWfKMcWDHNV/ili9VO+aT
         cGS+AV9wPGW8Zylfh/Cl3ByB7fJr2DBWXF6Nk4qE9Fz2Cek56xA1boOXHlbAnpb3F0xH
         Gbiy8nCQmuKSPv4bBc49fycOSeVQeuV6/YHdMkk6zEEPtztWBvtLocl0S0OmAGEgFGc/
         JZUKFLQ4x+nWXe8OWYSsBorRgtn5MPl9jGTYeqTG0KkbRa3ZOiwQD3aJj48K8frzCmG3
         UAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749050070; x=1749654870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utxbGnGIbzF8mH+ke5le74ATfkvfWNo9bI2IYs+ukk0=;
        b=LWHfE1dq4AMumUOE9q8/j8pb4PqVkxOM6HDItYqfk1+q55i/Q3je1r65O/hvrn8QA5
         qeCVhyBiLPKhefnFZqY072sR/3+DtRktD8P1pSRGliIAOa8k+GtX+YRjB60OLeipPRrT
         /pKYYaGMi/tWHvdsoi5GyoQaNrog7URvwRQfbwiDhBcNWy/hpxeXI4Hy1joqNbuKGrB3
         ie1Hox/bcaeKZFQ49m0Y6vR/2QPTsOfY/q3zYJL3O8B1u1kmDOq7zKLSTP5qFDm6jZv4
         L6e9MeDkLrFjLI012KdKmTJccM/BQpVERf2xtM18rdv5uSvrnoxmowXt1t9bM9U9z9Fv
         h0Qg==
X-Forwarded-Encrypted: i=1; AJvYcCV6YoPtRpPRZZFnTuU04NkzW/sg1CIP8tWmbqOikN3yHGabjQxrY8RJM+Omr0mCP9CoM4crhy6c1hxs@vger.kernel.org
X-Gm-Message-State: AOJu0YwdoGUr2uc0IDGVVKDDloNLgwSE50/XHdCX44x2qaWAFVD6oTOr
	Lk6lJQiu1VOGnWBYaNmPz4vEWjCsOC70YXGTAtJV70sYLod24FiDW3EklLWto2HUgsLlnzayrDe
	p4ublSvEaG9h85+BjA3Kak72XVLEH/RujlP1X2bo6
X-Gm-Gg: ASbGncspp9OOtPjBJp+tJ8osuy/KdXSgA86DrAAtitFlX3ccSBHyF46SwjLnit8F7iB
	hIijO4HJiOEmzgngh4+9GeRo65IOzuDeNx3A72zag/GYwMHuW3k4QCzgjYvVglmDnsWTYg2HW2L
	LCqkyfD+n4fCpHkWuv0BOgrOuzhFPGJ0/jE9x+0Jjcv4WpHzrMew3jPt+Ot8Q0JpynXMfvDre1
X-Google-Smtp-Source: AGHT+IG7WUENSnzjQt1432tk0/IC2xUBgjIJ6p1wfQtTmthhSrBkIabqQdFzCkGqvNujLDVYjt6N/VZKebcP/XvFGPs=
X-Received: by 2002:a05:622a:5513:b0:477:9a4:d7ea with SMTP id
 d75a77b69052e-4a5a60d620fmr3781231cf.13.1749050069321; Wed, 04 Jun 2025
 08:14:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604025246.61616-1-byungchul@sk.com> <20250604025246.61616-3-byungchul@sk.com>
In-Reply-To: <20250604025246.61616-3-byungchul@sk.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 4 Jun 2025 08:14:18 -0700
X-Gm-Features: AX0GCFvbLYsMxCrveTLh5QRMe579FQstUyFi0HWrz3vr2pOTHdyUzOaCmMQ3Mp4
Message-ID: <CAJuCfpFCtGFRip72x8HadTfuv_2d+e19qZ2xJowaLa6V9JOGHA@mail.gmail.com>
Subject: Re: [RFC v4 02/18] netmem: introduce netmem alloc APIs to wrap page
 alloc APIs
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	almasrymina@google.com, ilias.apalodimas@linaro.org, harry.yoo@oracle.com, 
	hawk@kernel.org, akpm@linux-foundation.org, davem@davemloft.net, 
	john.fastabend@gmail.com, andrew+netdev@lunn.ch, asml.silence@gmail.com, 
	toke@redhat.com, tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, 
	saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, rppt@kernel.org, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 7:53=E2=80=AFPM Byungchul Park <byungchul@sk.com> wr=
ote:
>
> To eliminate the use of struct page in page pool, the page pool code
> should use netmem descriptor and APIs instead.
>
> As part of the work, introduce netmem alloc APIs allowing the code to
> use them rather than the existing APIs for struct page.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  net/core/netmem_priv.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
> index cd95394399b4..32e390908bb2 100644
> --- a/net/core/netmem_priv.h
> +++ b/net/core/netmem_priv.h
> @@ -59,4 +59,18 @@ static inline void netmem_set_dma_index(netmem_ref net=
mem,
>         magic =3D netmem_get_pp_magic(netmem) | (id << PP_DMA_INDEX_SHIFT=
);
>         __netmem_clear_lsb(netmem)->pp_magic =3D magic;
>  }
> +
> +static inline netmem_ref alloc_netmems_node(int nid, gfp_t gfp_mask,
> +                                           unsigned int order)
> +{
> +       return page_to_netmem(alloc_pages_node(nid, gfp_mask, order));
> +}
> +
> +static inline unsigned long alloc_netmems_bulk_node(gfp_t gfp, int nid,
> +                                                   unsigned long nr_netm=
ems,
> +                                                   netmem_ref *netmem_ar=
ray)
> +{
> +       return alloc_pages_bulk_node(gfp, nid, nr_netmems,
> +                       (struct page **)netmem_array);
> +}

Note: if you want these allocations to be reported in a separate line
inside /proc/allocinfo you need to use alloc_hooks() like this:

static inline unsigned long alloc_netmems_bulk_node_noprof(gfp_t gfp, int n=
id,
                                                   unsigned long nr_netmems=
,
                                                   netmem_ref *netmem_array=
)
{
       return alloc_pages_bulk_node_noprof((gfp, nid, nr_netmems,
                       (struct page **)netmem_array);
}

#define alloc_netmems_bulk_node(...) \
        alloc_hooks(alloc_netmems_bulk_node_noprof(__VA_ARGS__))



>  #endif
> --
> 2.17.1
>

