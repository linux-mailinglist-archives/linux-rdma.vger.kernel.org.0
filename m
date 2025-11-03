Return-Path: <linux-rdma+bounces-14199-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF6DC2BAE1
	for <lists+linux-rdma@lfdr.de>; Mon, 03 Nov 2025 13:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D633A4F0751
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Nov 2025 12:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6471230E840;
	Mon,  3 Nov 2025 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K1NT6mGN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="m3IxmIyC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FBB30CDAB
	for <linux-rdma@vger.kernel.org>; Mon,  3 Nov 2025 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762172687; cv=none; b=JqzfKGJ70Pt1DKTRvzqf7pEYA5zqRBI7h8PWU+Fa7cwTT5XAFEHhRzHb/Rn3HYsRTGpkA39bpu78Xf9Xb5o0gL8C112wG3WrE6GdNo7AF4Eej7X3cGPPOqG4aak18k+w/C6SRc4WQ1AlqfoJPmPC7t6BGCkbEMXfDpXQWSTgJ5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762172687; c=relaxed/simple;
	bh=0sL3Sqt4pPtcdmPcFr1YF4MWNWB4MKnWEylQFPolhFs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C/EyDq9+Z+j+5WF+W/xs8JXJ+lm34BABUjyPeOclCR+J71KFle0OrUWwck4x+B9LNEJwyXAxAje+vUs8tMH4fFbJDeVb/paButt39SHQU9Cp9ZSxdGqoqox5pnkpuk7Vr48XlrEP4k/F/G65xtfAqNISVk8y7WS79+7paeIOzM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K1NT6mGN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=m3IxmIyC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762172684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GjVp41+JcRNlhKhJQBn7GbDkB8mn6fWxcVLv0a89y4U=;
	b=K1NT6mGNNof/Q5pobPO0rhIiv5DEWcaPTwXaF4ungMPM9ox4T36JwtuDuV4ZpIIITvoRGF
	efOQZ8SR5aQQHXbohGQLehGLUhVi70PVcs9wJZZRhDjO6Hmm5Wbr78nfdAK4KO5+fcVwgP
	RUSRPSewj0lcNuHLYnsYGrXcwIaRR9E=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-c3azIWcqPgufA6-6Zn3CtQ-1; Mon, 03 Nov 2025 07:24:43 -0500
X-MC-Unique: c3azIWcqPgufA6-6Zn3CtQ-1
X-Mimecast-MFC-AGG-ID: c3azIWcqPgufA6-6Zn3CtQ_1762172682
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b70a978cd51so248194366b.3
        for <linux-rdma@vger.kernel.org>; Mon, 03 Nov 2025 04:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762172682; x=1762777482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GjVp41+JcRNlhKhJQBn7GbDkB8mn6fWxcVLv0a89y4U=;
        b=m3IxmIyCpZtxOZ6ZnC9IsL+UpdHCeEAFO+a+UgYr6U67L+yQgbEpqsUMhU2hEFo3N5
         f2PGIned76BiMzzo/XMQYMrQ693HF1wYbrj7Dd8cC94bzEt0ONtOHSiWfI6ZlJWjZdnj
         eveZv1xsS1+kiqLlAAcVuk6ufAJSEJO40OK38pQXw2qHPlTZ3rLDcCaljO17r9wIVl++
         t4qZZuUHfNjEB67HM4pQTBsd5Bsr8bPsGXYxb6gQOeB083j/MBFAj4Qrwib+YWxtKofo
         s5oDMqMYVnYfjx5d2pvpr00oyBg4sXFQupEjsQsXYbaL67K+gjr/Dje8NtVDck3Uh2rx
         jWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762172682; x=1762777482;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GjVp41+JcRNlhKhJQBn7GbDkB8mn6fWxcVLv0a89y4U=;
        b=WvKs3aPuqeeh6hvKnSxDjRIj6IV5YPCmCiTGShQT/8h/0Zc2oRqx0cfGqM+fNw2Bib
         3UHSSu/yMcnRJ9fkoOp5tpA+JemlXKrYsrEITWDnF95ZXTSs6fZuLU6oURaCSQxzwPKX
         fXieViot8Qs22YTZr9XeaQugd1OBiPDXwJYjMzL9T3XClBcI/oS9Fe1y7pffzfnOVwzC
         o9HBKgHDupJfUoCaqLcLAHjzl1OceaG6LmNziju1/nWevpNLrJA48n4E9aQL1KIAErQc
         5odRnkt8dTCxJrzz/j9v9tngJpVPoSJd5kEwJKOqzvywNLlzpwZfSGRfhfQCgjR6pu4B
         VXbw==
X-Forwarded-Encrypted: i=1; AJvYcCUsj0MhUaMd169WCijXV4ld7FGrWop/tJ2vHZVT2VQUjzv3BFAcInsDvUgFqDl8bKQG5SETwmxY17+L@vger.kernel.org
X-Gm-Message-State: AOJu0YxqIAQVSYXNxyd+quOHxqp1+tGGYV5nxkg+HEiQ29KKT/lNH4yM
	XNwUSjLmc02pZXawyzzEsZhil2y6aqgRbcIHYFdPizAlu4khDrJUSxvEB+EA+7YS7CbaJPIpFZc
	QVqhxhncfxkGFhhKPtbN/c4OF1uhgD/bYe/PhgP0hatWyTunzuRvXyDmgrNftPmk=
X-Gm-Gg: ASbGncufPPDZ6mBj3myra2iUaR8Q0Iet+peX4dnY1BgFPT5Ugc/d5YTX1pZo/7Ga+UN
	DJ7eihemDkZbtMIoEtCET67TLW18LidWuASil+sILtmYHzN0nPJzNAK4LYgSEl6wR5iUHfn9Mcy
	lQbuZx+uQetiL8ezV/GZuXTZdSGuMn/Gs8LV6HpkGA0L3WSFvt0lh5kgat7/Uz3ZYqJFhjlgS1P
	hjyF3eFTONyl38f/pPaT8YshkFfZGzJ0cqMNKCrgs84SrpxHMosqRv5QMFHzVoPZ5JmmjG9SLTQ
	H2mptnfSvqNveyxYir+Wh7dtTHjxQEFPKb1jk6qDp3TkiseoIzAVr3An7MY+AlMcis9bdYf/JxU
	RDDm998Eri/yvsmx9jpRxfJs=
X-Received: by 2002:a17:907:6d20:b0:b70:b83a:73e5 with SMTP id a640c23a62f3a-b70b83a8c35mr359784766b.44.1762172681733;
        Mon, 03 Nov 2025 04:24:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFL2sLtytpLuUcKWCOkoRDcXckWNNb+evONxAWiMkrqYHa0li9xt3zPEufFR+6cGkgmgzhx/A==
X-Received: by 2002:a17:907:6d20:b0:b70:b83a:73e5 with SMTP id a640c23a62f3a-b70b83a8c35mr359778466b.44.1762172681211;
        Mon, 03 Nov 2025 04:24:41 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6407b392d5dsm9676772a12.15.2025.11.03.04.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 04:24:40 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id EE02432844E; Mon, 03 Nov 2025 13:24:39 +0100 (CET)
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
Subject: Re: [RFC mm v5 1/2] page_pool: check nmdesc->pp to see its usage as
 page pool for net_iov not page-backed
In-Reply-To: <20251103075108.26437-2-byungchul@sk.com>
References: <20251103075108.26437-1-byungchul@sk.com>
 <20251103075108.26437-2-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 03 Nov 2025 13:24:39 +0100
Message-ID: <87ms53pam0.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> Currently, the condition 'page->pp_magic =3D=3D PP_SIGNATURE' is used to
> determine if a page belongs to a page pool.  However, with the planned
> removal of ->pp_magic, we will instead leverage the page_type in struct
> page, such as PGTY_netpp, for this purpose.
>
> That works for page-backed network memory.  However, for net_iov not
> page-backed, the identification cannot be based on the page_type.
> Instead, nmdesc->pp can be used to see if it belongs to a page pool, by
> making sure nmdesc->pp is NULL otherwise.
>
> For net_iov not page-backed, initialize it using nmdesc->pp =3D NULL in
> net_devmem_bind_dmabuf() and using kvmalloc_array(__GFP_ZERO) in
> io_zcrx_create_area() so that netmem_is_pp() can check if nmdesc->pp is
> !NULL to confirm its usage as page pool.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


