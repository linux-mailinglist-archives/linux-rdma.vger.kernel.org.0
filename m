Return-Path: <linux-rdma+bounces-12043-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBBCB00B4D
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 20:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34D9C3A5B11
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 18:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C5E2F50B6;
	Thu, 10 Jul 2025 18:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qObU1zue"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1FC2F2C74
	for <linux-rdma@vger.kernel.org>; Thu, 10 Jul 2025 18:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752171986; cv=none; b=En6s0+ReucmWdE9nMFR0nJY1z98Lm1v6OcVLKRhsnUfPjNCzBQeMN/+qEK8ysuR2x1V6t264nCNR05pkeUapTfr07fRfmWdTAdRmjwOD/kWClGe89ANy16Dj3e6iTPqLCn7mdDL4LIBFXIU9ZKcyRKwmOP7LppImg/swV7Ka3hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752171986; c=relaxed/simple;
	bh=DQ/y57eCcvCivMqXieykxCIkDza/1dPM5uPabJRz16o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5vmrD6cQHVE58occKxLcoPIJOTMyhyX22LCshyZYKzxiPn0XcH43++sUeAE6U2opVYRtGzzODtqBkTNCeYAf7IPR1AInUOZZhqkvOnoiShPEq7kUixpds3srTZ6fFv/b+o/zPM2Xf8E5Vi0WuS6MuaLmGBP7BzV7HFjK8BDQdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qObU1zue; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso1518a12.1
        for <linux-rdma@vger.kernel.org>; Thu, 10 Jul 2025 11:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752171983; x=1752776783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpVeUDzlloshth7hyY4uUrRygX8GK+L0hY7EdHxCTWk=;
        b=qObU1zuerGhbYWlfulILtsMApJEO572cb99Ey657M5ZIW5FJn9qSNnybTUmZwPXmoo
         6P1pcpOL17ZItstd3CjuuSqb+erRZa4J7rQHM4ORASF5f11JNxKu0xDSlD/J1YA71gHW
         fRONoNj2vmMzTagcuqJ8ulV5PLMfLTdVZdq9OlnKV82aY69cKtL9CZ7kzUANxH271wGA
         P/Hks07foD1XCHZENTyruReqQLmOfQkLM1ii2gdSVPyMb9nohjNE0lRXOR4A/JvkN58F
         LwP+GaUG6r4NOEEdxPUCvO054zG9vCYleh3rFncue61UmbDCdFOBqnJEfIScIY/iHIC5
         JcDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752171983; x=1752776783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YpVeUDzlloshth7hyY4uUrRygX8GK+L0hY7EdHxCTWk=;
        b=SkDTdYylonC4xmju4nZZ6FB6Qm7uuffGkpzdTKqL54iMwE2Z5EH6NGXTbzFFl6tJ3l
         fW6tWVeIBadVVfM7op/5LuGLe0pBvOKj65sxcpM59qWTPBJWpFs4wzv2YO7NDcXKxeS6
         TUeCoJ86OLKX/rUKo0sovaY5nc0d3gYG6/r1mQNDBxMNI2+PsekFDV7fK2r+he+n4FPW
         X0UAEVzaZ1lgwErx+TP5KCn6AYsu+B3EXKBp1DBGddGAGeRImeAjLGc2sjS0zYKoWmZr
         Ia2hDPQ/XvhYVKAsxEdUlMLyiKPmMQsF1noE8WJz34z9pLnrSlJdxtgB4yXrqTy1sn0U
         tfNg==
X-Forwarded-Encrypted: i=1; AJvYcCXDNlFXrYfr1pYpHULURsoQ30FAfSkWKsm+HJyRQrQJPu6QlqQUFTEwY3oW7JpNoJk1jPCZdA+/4cef@vger.kernel.org
X-Gm-Message-State: AOJu0YwEe3hKiVulczwJcIdvI9o00sT+C1L3oFo373ojQJA/jCkCKGOb
	DOdfVbASiw3aDOrkyxQkLgpV7U+HNOEbAO5RHPkUVVBu+vfTW975ZgzC4lvnxUV0a/AUuMCHL9W
	JlpAaOQszV/MqhyNphs2yOYgdTmFco4ZHKkwMcrym
X-Gm-Gg: ASbGncvGhSBufVNDA23aj2FxQtPzTKflDzwtw9BbzkCg1dTxagZI9KC535KvLJzTUJ2
	81Ee78V5ecuAch285aUU0us/Bmu6oOi67X0+ZF0aCi5RDVkoEJDS9yDs1z1MJIBYjdtWTEFxJ9w
	ZIjbenRNTUfukoMMmywzdC8hjNjw4bVuj0IKn1d9jsmREC+xpAkN/YYA/r+2sGVhnkqfoO1sk=
X-Google-Smtp-Source: AGHT+IFt7W8JAheHiVqwt4ZBR3CQtXpumX/T7A5/rBmH2QebswkJBxnWs6YN36d9U3n7K42s+O7r2vNQ3sha7Qd9AVA=
X-Received: by 2002:a05:6402:24d3:b0:607:d206:7657 with SMTP id
 4fb4d7f45d1cf-611e687e614mr10195a12.2.1752171982710; Thu, 10 Jul 2025
 11:26:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710082807.27402-1-byungchul@sk.com> <20250710082807.27402-8-byungchul@sk.com>
In-Reply-To: <20250710082807.27402-8-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 10 Jul 2025 11:26:05 -0700
X-Gm-Features: Ac12FXyyC8r-KEBOBjPhKMa8MrPinEu-RU7EeVBu--QTlNg-z0ciuFeVDRS6Ldc
Message-ID: <CAHS8izMo5QLb5CrrdfBnaG_1kWd=D7iQM+2vB0Gm-pbH9tmk1g@mail.gmail.com>
Subject: Re: [PATCH net-next v9 7/8] netdevsim: use netmem descriptor and APIs
 for page pool
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
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com, 
	hannes@cmpxchg.org, ziy@nvidia.com, jackmanb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 1:28=E2=80=AFAM Byungchul Park <byungchul@sk.com> w=
rote:
>
> To simplify struct page, the effort to separate its own descriptor from
> struct page is required and the work for page pool is on going.
>
> Use netmem descriptor and APIs for page pool in netdevsim code.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  drivers/net/netdevsim/netdev.c    | 19 ++++++++++---------
>  drivers/net/netdevsim/netdevsim.h |  2 +-
>  2 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netde=
v.c
> index e36d3e846c2d..ba19870524c5 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -812,7 +812,7 @@ nsim_pp_hold_read(struct file *file, char __user *dat=
a,
>         struct netdevsim *ns =3D file->private_data;
>         char buf[3] =3D "n\n";
>
> -       if (ns->page)
> +       if (ns->netmem)
>                 buf[0] =3D 'y';
>
>         return simple_read_from_buffer(data, count, ppos, buf, 2);
> @@ -832,18 +832,19 @@ nsim_pp_hold_write(struct file *file, const char __=
user *data,
>
>         rtnl_lock();
>         ret =3D count;
> -       if (val =3D=3D !!ns->page)
> +       if (val =3D=3D !!ns->netmem)
>                 goto exit;
>
>         if (!netif_running(ns->netdev) && val) {
>                 ret =3D -ENETDOWN;
>         } else if (val) {
> -               ns->page =3D page_pool_dev_alloc_pages(ns->rq[0]->page_po=
ol);
> -               if (!ns->page)
> +               ns->netmem =3D page_pool_alloc_netmems(ns->rq[0]->page_po=
ol,
> +                                                    GFP_ATOMIC | __GFP_N=
OWARN);

Add page_pool_dev_alloc_netmems helper.


--=20
Thanks,
Mina

