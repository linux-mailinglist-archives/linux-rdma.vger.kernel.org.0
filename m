Return-Path: <linux-rdma+bounces-10639-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC51AC285B
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 19:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 714171C06D26
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 17:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275352980B6;
	Fri, 23 May 2025 17:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AwgU7xHF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A3B297A78
	for <linux-rdma@vger.kernel.org>; Fri, 23 May 2025 17:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748020509; cv=none; b=JKbpMfc4OXk37oQkk/ttwc2MVGQUN8grz4DKVjTk/AmDR5qejmZCxWqh4JfFxlY3pin7gLCMQjG+xLGHkIIgJg1SfQ5MUIByvl789wwzAtwrIwY7ab0rrDY77c1nb2lV7MpwjxQhlE+GzBOBN616vQABWK5b9SUWAB2Nr1VItms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748020509; c=relaxed/simple;
	bh=IHS8+BmUXeAp3Xzbk8VRC75jhVDLrcvcJDpOGyFT7GU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Prw+Rfo9VlBtuFcAULOo3VKiQZ/gl8qTzMHRFS0cl3WV9Q6lJkdlcpjDUOzVE2PMD4UmejX6K+j+4WMlEiXM5jha6f9cqHb6sB+K2Yjzg4pMDtTifjuHMV558EDhMSsst0mLwDa7dzcOoCCcU1CsZKmMthSIIszO57HHjt89kbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AwgU7xHF; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-234050cb45bso9335ad.1
        for <linux-rdma@vger.kernel.org>; Fri, 23 May 2025 10:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748020507; x=1748625307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1L0JjzOjlHgjWZPMHxouS8dOF8m0fP7fyoaNhah9J5s=;
        b=AwgU7xHFPElDMpaAU2nPAe0detPN0TBDBZo9r3J8vgltoaJUD6xbW+C4kcqpRTU/H+
         6K4rkF4f2uQt5i+JqWLT0ClCJebaZn20/vB9xGle/iNkNyt8XvReWD6cOdoDCAljwm+s
         NcRAlv24FvVZW04dVKNX2qK5zQsTS1JmpKRoIlu52XbRWD0uUYR7yPdgITxg4iO/0BK4
         sYe3wfRTiWIb5dvpWnqNJIbDojNAk1GRbc21Gu3uttpmR659UGJjyU0fQ81iQwHyXOBa
         DHWBDsexEyVggLoH00S2STn56e0Qy27cIdNRoA4D0baHyJ+ETyoVH5ILg01dG+wF63UD
         oKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748020507; x=1748625307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1L0JjzOjlHgjWZPMHxouS8dOF8m0fP7fyoaNhah9J5s=;
        b=tNF1bHiPo4l1mZ6SYZ36YSSs9sW0LA81edQeSzdhgVKOsTL63B7CkB0kzGq3rd/UF5
         TSFtV9JU2IPzRIEayWKugAVEk+4ywe+OXFFMixFN40hN0mBCkOr7KR3/76M9LR4KxnvU
         /t3KIRRGp5kptgyFGyPbntHYuFhTVfbSbGaW+ydkzOtO+pZYAOgJca171QHxdS/hfwLI
         ZdzPDbc6WD/5KNXvB1j/p7eZOFKaa3WA1JtV2hS+QAib/wFxxggl8aHcsOaSYkIlDNSc
         5S9P+6lWPXia4nsSan1DgT1Of/TcNMvDOFLu+t+sB+UivaANv9phKgxsc0OXYNboKwPz
         rCLA==
X-Forwarded-Encrypted: i=1; AJvYcCVo2nhrkMjl8lwIRHsXvk6pkgCLroj7MZkK6M5l7QDKftQ5e+LkUEJx7jllzynIW59dg5GQLSca5XOK@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7VjLyro1swLaiCv0Q6Isk0ZUvgV59AyrupPDlBf+if8q9i8KT
	srOj6DzTGau4Cwpub6t4iJiTY+S6A0PPHrUOqgsbs7ZnENlWQcmCItBzNUWUlfo0hB9qgjgiisX
	cR0duNMGRZ2EcPZejmOwyNHspliAW6BP4e4FMB4b/
X-Gm-Gg: ASbGncseuEKovH2maMowlkZD5zQe8IRU1qCC3g+fq0pOBnvje3l46WNY6jgERRDwDi/
	HliamfjG5tE9GNVaixIav8JNVwVXDE7u4z3FG8PH2jnts4NfycdLId1tEiYhc25vyqG7fcV4A52
	AsCTcnzCWDUZRKFUHMEu/z9hxJStJG6HCBFHbAxFg7YEpzszB+/7yWImkgMCqUQiaF1KPCMlhEO
	NvCGwm0CfhW
X-Google-Smtp-Source: AGHT+IHKY4+eyOTipL+J4QWHEmhi7z98sbn5GuQRI5Ig+KizZC1qpLnfhveOl7CVrrTaKZsQhRy6NnMNBA8jCy7xQ54=
X-Received: by 2002:a17:903:2348:b0:216:7aaa:4c5f with SMTP id
 d9443c01a7336-233f34df516mr2608055ad.3.1748020506755; Fri, 23 May 2025
 10:15:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523032609.16334-1-byungchul@sk.com> <20250523032609.16334-15-byungchul@sk.com>
In-Reply-To: <20250523032609.16334-15-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 23 May 2025 10:14:54 -0700
X-Gm-Features: AX0GCFuS-_ZvIZXs7vWDJYGmbnFNShYZqaEghvfevVpzOFymPJ1-gQ7S9gnP9aI
Message-ID: <CAHS8izMRDixoLC5p1+h4oxrfVvErXcokR6qC_zuOqBredBBMbA@mail.gmail.com>
Subject: Re: [PATCH 14/18] netmem: use _Generic to cover const casting for page_to_netmem()
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
> The current page_to_netmem() doesn't cover const casting resulting in
> trying to cast const struct page * to const netmem_ref fails.
>
> To cover the case, change page_to_netmem() to use macro and _Generic.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

> ---
>  include/net/netmem.h | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 29c005d70c4f..c2eb121181c2 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -172,10 +172,9 @@ static inline netmem_ref net_iov_to_netmem(struct ne=
t_iov *niov)
>         return (__force netmem_ref)((unsigned long)niov | NET_IOV);
>  }
>
> -static inline netmem_ref page_to_netmem(struct page *page)
> -{
> -       return (__force netmem_ref)page;
> -}
> +#define page_to_netmem(p)      (_Generic((p),                  \
> +       const struct page *:    (__force const netmem_ref)(p),  \
> +       struct page *:          (__force netmem_ref)(p)))
>
>  static inline netmem_ref alloc_netmems_node(int nid, gfp_t gfp_mask,
>                 unsigned int order)
> --
> 2.17.1
>


--=20
Thanks,
Mina

