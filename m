Return-Path: <linux-rdma+bounces-10798-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4125EAC5FDD
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 05:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F273BEDD1
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 03:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D8A1DE4EF;
	Wed, 28 May 2025 03:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qLuGLAzF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7B313AD38
	for <linux-rdma@vger.kernel.org>; Wed, 28 May 2025 03:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748401934; cv=none; b=SqQwWqPVW4DQddHK65+WN+yBVg+0hDsTsaYlupEL6cLkKa1VjfvsxfJj0inqI88NqrJGHNGA7YwoB2onqQcpgyU0J9Px8rOzI98/sISWgwdUvp1LdnsH4FOgx3/P8xUApKG8U5OUMz1K0etqFc1xX1G79PcyApS0pWHJtCwy3EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748401934; c=relaxed/simple;
	bh=45wv2D7qTveHvG++liQk1FdgOdvStQgyo7K7EgLBQ20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AVKGXBChrwbbEUEHE7kv64Ee+gK88NSnvpQLCyfCaK8LpMi15CD+J+HLZHqpgzdZkBnh486Ba0yBzCWlja5OGigip2yiLn9tnJZpeVq82HPxjrrf8JCIjVrUiLZRgLDgjsC7P69KLrJh/y2x1O0cYDEjszlV52vJvIE2/sxWUkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qLuGLAzF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-231ba6da557so80035ad.1
        for <linux-rdma@vger.kernel.org>; Tue, 27 May 2025 20:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748401932; x=1749006732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hi54XJvxzTpbX0StT38uQRnU2/zb/XVmDK+caARZGHA=;
        b=qLuGLAzFri0ELQo4ug0igeikL8LmDPPfEQYrCmNbU56Tg8RjWHOo8GCx63KdOLC5fb
         94Jn31FyUqWmxqXyNLqYUmxnmjRwO2pQqa0ZZalBFrASW/1pctyQD2t7UllpFpmvNYrt
         y0mwJnzWgd4jTwRFf8njjTLsyOLvIvcxHIQ/Ul0eHEV0u33HJa1R9v7DUTEol/dfaCv9
         XsolPSH5bhIV+A8Xda5ar5qQR1g4R9BqKe9EK8B+ouo8AwtvnLFwFJerameKYWZLZJpd
         1L1CiVHn/Ix2rwsqKjvMl2SmHlnZz0Uz/gvRtZMV1+LLu2nmlHPBrASFWAikRAlKP3AO
         IjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748401932; x=1749006732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hi54XJvxzTpbX0StT38uQRnU2/zb/XVmDK+caARZGHA=;
        b=o7uU1sVwn5FkkhQGiscurwMPA7BbFW932gPOXbRuM8GxQ/pF6QZyygMU9MZYD+dCYs
         JJ7S7mPQlHECMgoIP29WsbMiP0ZX19MTe46vKhfO21GXjj+JHuMWEIPB4TYE8lZ7eiSI
         UHl9escha1LNoynktBjbKD5luaLnelI9Cy3WRCR6yG+C4ymz/d/MaB4S9gtPr5vUGx5e
         bGCeBuRoXDMhVcm3P6jZ5111MfY+joe+DRvSYd17telTPBO+XByPQ7zZLpd+tr1WTHYy
         o0OJYgwynkUCtBbhkYc6RGT7PbdjTzeg45XwsgO5Rq04OwdZCjN7nFUEM5utzjwh+TCU
         7HKw==
X-Forwarded-Encrypted: i=1; AJvYcCUJwDVOC6EZ1wPPUXgoGLmIBghK/ehR0MVpMDQVL5s1fgQwi7mtafconYH67SbZV1U1khZYGzLV4WyM@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk93HaClLBNqFCo8AsuxZ9vjpXvzqOb0rNPyRtJxOSxgCSI4vv
	9g6ycLaO3R6eOq8ewENycz37OOLxqN/j5hf4LYcAVv2Sl30AObPTZ4uvl4vaH8/eA1ukR52vryH
	qqKxtL2d9bpQuD3PGwQ2xT8YGVZMxW4wETv/uFsRA
X-Gm-Gg: ASbGncsmK2KGtyNaEzYIj7U47cTUXF98RW0QaXHrQr/2PxNC5N212tjPU5mtF7pNFSd
	CCrEnzGaxzQ8erjIFIzxHfqVO1a/v19Ol4kAGHeJ0Tcbh9xsVb1D5r6cOsLb6KYdhXI1XhLqdcJ
	8J0T4e68oakpAoIFrwoZOqBzLUYBOn1aztra3UcLXbivFe
X-Google-Smtp-Source: AGHT+IGdqjyzoDtqYIHx/y7YKWzz/qyhFs2l//e3GArH1hU2e1HUWggvHASce0D05SKLzqIW3p6xmhC7Nwpq0Q6Hybk=
X-Received: by 2002:a17:902:d2c7:b0:234:b2bf:e676 with SMTP id
 d9443c01a7336-234cbe28862mr1141045ad.11.1748401931545; Tue, 27 May 2025
 20:12:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528022911.73453-1-byungchul@sk.com> <20250528022911.73453-3-byungchul@sk.com>
In-Reply-To: <20250528022911.73453-3-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 27 May 2025 20:11:58 -0700
X-Gm-Features: AX0GCFvbRHta6TyJPe_xr_2KYS1z9gGCeokku76odClbu09MqRPDqhx2_Gv1QJ4
Message-ID: <CAHS8izOkr96_i1B8o_AWQGgfWSWZVVjHhOShReLZozsxZB6WdQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/16] netmem: introduce netmem alloc APIs to wrap page
 alloc APIs
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

On Tue, May 27, 2025 at 7:29=E2=80=AFPM Byungchul Park <byungchul@sk.com> w=
rote:
>
> To eliminate the use of struct page in page pool, the page pool code
> should use netmem descriptor and APIs instead.
>
> As part of the work, introduce netmem alloc APIs allowing the code to
> use them rather than the existing APIs for struct page.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  include/net/netmem.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index a721f9e060a2..37d0e0e002c2 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -177,6 +177,19 @@ static inline netmem_ref page_to_netmem(struct page =
*page)
>         return (__force netmem_ref)page;
>  }
>
> +static inline netmem_ref alloc_netmems_node(int nid, gfp_t gfp_mask,
> +               unsigned int order)
> +{
> +       return page_to_netmem(alloc_pages_node(nid, gfp_mask, order));
> +}
> +
> +static inline unsigned long alloc_netmems_bulk_node(gfp_t gfp, int nid,
> +               unsigned long nr_netmems, netmem_ref *netmem_array)
> +{
> +       return alloc_pages_bulk_node(gfp, nid, nr_netmems,
> +                       (struct page **)netmem_array);
> +}
> +
>  /**
>   * virt_to_netmem - convert virtual memory pointer to a netmem reference
>   * @data: host memory pointer to convert

Code looks fine to me, but I'm not sure we want to export these
helpers in include/net where they're available to the entire kernel
and net stack. Can we put these helpers in net/core/page_pool.c or at
least net/core/netmem_priv.h?

Also maybe the helpers aren't needed anyway. AFAICT there is only 1
call site in page_pool.c for each, so maybe we can implement this
inline.

--=20
Thanks,
Mina

