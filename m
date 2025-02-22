Return-Path: <linux-rdma+bounces-7999-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA448A4061A
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Feb 2025 08:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81B8F701AC7
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Feb 2025 07:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D9020013E;
	Sat, 22 Feb 2025 07:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BzBGvyM4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5A278F4E
	for <linux-rdma@vger.kernel.org>; Sat, 22 Feb 2025 07:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740209938; cv=none; b=en1Z4F15CUY8AI7fJcqXUS2gLFTnxFyl4qavkcxijK1oZNlnrryNGrnaYQvh5U9TFVhgNOZaBHXNTS+TaDXeqG9CVNsqBhFVX8o7gxVIBN/E/lPI858W0qt9BJDZyU526C5qRf+8ugP0Egqlw24EfKxGsnJEm+xACSUf3ntXKb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740209938; c=relaxed/simple;
	bh=AF6NhaCUmMh5rcmemvC/zjRFOfeAvWRid01k7iANftE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UcYXL0tbJKo+6VrqrUmXhiSOAXzY9XwolGRS5aHRrwptVQ0Gy3vyeq2qOBmnobLXGQBFXeKD0spIFxKkaxQgHvIpnDxGzlZpND+QZv15aV8kXH8MAYuvtZtFhYmO4PVGJI+3tCWfuJzA/U1VwH0AQA4JXOm+kgf5iExlPAabudo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BzBGvyM4; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e0373c7f55so4344207a12.0
        for <linux-rdma@vger.kernel.org>; Fri, 21 Feb 2025 23:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740209934; x=1740814734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AF6NhaCUmMh5rcmemvC/zjRFOfeAvWRid01k7iANftE=;
        b=BzBGvyM44EeFZu8uDHG9VvnX6IbQl2cKvYHRj1Rj1mQkWiubRDl4YzxaxLdX7PfbL9
         CTbEc1Py/30boe9h2O3je59ClKeJ7TN+2pMyIoh5PpZ9Cgl1cRxHylzpMYLranIpWKof
         i91rMH2rNUkuRC4z/KknnE3hOOw2fecSKDp7E+Chl9B53/HF6J5rgci8WIy/uZTdS78E
         nBe3f7odWvTX2Hnu9o9dQ+8N0248qiBy+t/mJrVGT+UPZomRi4/z74FQmCkltGK4ucYa
         qMnEOREqkQU3SjUcivLvYnoEo1RQiaD11y6sGruoX7VSmtLWo9kO0jXBLU6PrRP9orxg
         Ibjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740209934; x=1740814734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AF6NhaCUmMh5rcmemvC/zjRFOfeAvWRid01k7iANftE=;
        b=iosPhqlQ+Kckd6lxeRJ5lIBzlPnA2iwtJCAe0CaJFd6x0JSZhXYBT/BTtRPd+2C9am
         BjBhrYYVOfL/O7dTRRi/WM8vyDO4d24L0eTBIEdFBcS4ODv41vaGu0uLGbgxlKaU2qA/
         2Uy70XiJmWwFheKmdv+zITJzOZCL7JrG5/cslmRt/mEH4jH50VET0TltNOJim2DoaN/V
         wh/ZIVWuZLsJXCsrIhQxJIIjcChpVZBLCX+pO9mWuUxUOhTJ/En26JoRgDqTsKmpNSYH
         hsWYxI6E5nwbNT3WU4b3XwSxXB+4+x7RIxuujtbt2Ye6YrsYqR6FN1sPjyiZbsISBttp
         6FOA==
X-Forwarded-Encrypted: i=1; AJvYcCUZMBuWQd1OKuFbd+CLOrzO8693n731mF6X4+FN9ht5sqqIH+8aKLmrHk0ubY+gsGDnHTB+2t3J70P5@vger.kernel.org
X-Gm-Message-State: AOJu0Yyflvvt+TxpIPDAVb4IA3lTXW1IBTs5v0//bMifvsUEw8jP9XJH
	kc88OeA6TuiXKJN6tpoHFg9Nm7BHLiPsBihAAg40oBnNahOxULp/2RUrBAMHWfrOSFuEZPddTE2
	J6YQ18wz0Rawwnwtu0xbwrD41meqjAZ4MLIGe
X-Gm-Gg: ASbGncsE33uKEFJn4Hshz5L88rxzwKcrLciWJDSgXlVuiQnRxGh+1TtC35/NeISikzE
	jlQM2xRbJtHCdXT2bm51OmnAHdbqmNXvkMAJ8anhTJ8Uu4mLcznCkZ/54KS/h6+5Pt8Ff5JRDWY
	d98jtuF0U=
X-Google-Smtp-Source: AGHT+IHsWHEnlGCWT9JemoGt42z///WYOlIZaRPIeOrhR2AhGFIF2p881A9wiCJepCj7RgxMBt4NXXcWx2FdIyHvv1U=
X-Received: by 2002:a05:6402:5248:b0:5dc:8ed9:6bc3 with SMTP id
 4fb4d7f45d1cf-5e0b7236f16mr4998817a12.26.1740209933911; Fri, 21 Feb 2025
 23:38:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220175612.2763122-1-jmoroni@google.com> <838a95a2-f286-4f94-8667-2da8ba330c47@linux.dev>
 <CANn89iKSUZxfCm9rqEykZtzEAsu1F0dpooh1iih_RwRMHjpGNg@mail.gmail.com> <31fe1fe8-0f8f-4781-9ac1-2c0bb347d1b5@linux.dev>
In-Reply-To: <31fe1fe8-0f8f-4781-9ac1-2c0bb347d1b5@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 22 Feb 2025 08:38:42 +0100
X-Gm-Features: AWEUYZllYDSvknN5WRLQ5HS1PnsZoyineiKYG7xf3ZAwDjtXN2H1nvji1yYUb5k
Message-ID: <CANn89i+52deipLpK4jPiQmM4kZk6gfhHBOt91j2vXZCd2GG8DA@mail.gmail.com>
Subject: Re: [PATCH] IB/cm: use rwlock for MAD agent lock
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Jacob Moroni <jmoroni@google.com>, jgg@ziepe.ca, leon@kernel.org, markzhang@nvidia.com, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 7:21=E2=80=AFAM Zhu Yanjun <yanjun.zhu@linux.dev> w=
rote:
>
> =E5=9C=A8 2025/2/21 18:32, Eric Dumazet =E5=86=99=E9=81=93:
> > On Fri, Feb 21, 2025 at 6:04=E2=80=AFPM Zhu Yanjun <yanjun.zhu@linux.de=
v> wrote:
> >>
> >> On 20.02.25 18:56, Jacob Moroni wrote:
> >>> In workloads where there are many processes establishing
> >>> connections using RDMA CM in parallel (large scale MPI),
> >>> there can be heavy contention for mad_agent_lock in
> >>> cm_alloc_msg.
> >>>
> >>> This contention can occur while inside of a spin_lock_irq
> >>> region, leading to interrupts being disabled for extended
> >>> durations on many cores. Furthermore, it leads to the
> >>> serialization of rdma_create_ah calls, which has negative
> >>> performance impacts for NICs which are capable of processing
> >>> multiple address handle creations in parallel.
> >>
> >> In the link:
> >> https://www.cs.columbia.edu/~jae/4118-LAST/L12-interrupt-spinlock.html
> >> "
> >> ...
> >> spin_lock() / spin_unlock()
> >>
> >> must not lose CPU while holding a spin lock, other threads will wait f=
or
> >> the lock for a long time
> >>
> >> spin_lock() prevents kernel preemption by ++preempt_count in
> >> uniprocessor, that=E2=80=99s all spin_lock() does
> >>
> >> must NOT call any function that can potentially sleep
> >> ex) kmalloc, copy_from_user
> >>
> >> hardware interrupt is ok unless the interrupt handler may try to lock
> >> this spin lock
> >> spin lock not recursive: same thread locking twice will deadlock
> >>
> >> keep the critical section as small as possible
> >> ...
> >> "
> >> And from the source code, it seems that spin_lock/spin_unlock are not
> >> related with interrupts.
> >>
> >> I wonder why "leading to interrupts being disabled for extended
> >> durations on many cores" with spin_lock/spin_unlock?
> >>
> >> I am not against this commit. I am just obvious why
> >> spin_lock/spin_unlock are related with "interrupts being disabled".
> >
> > Look at drivers/infiniband/core/cm.c
> >
> > spin_lock_irqsave(&cm_id_priv->lock, flags);
>
> Thanks a lot. spin_lock_irq should be spin_lock_irqsave?

Both spin_lock_irq and spin_lock_irqsave are masking all interrupts.



>
> Follow the steps of reproducer, I can not reproduce this problem on
> KVMs. Maybe I need a powerful host.
>
> Anyway, read_lock should be a lighter lock than spin_lock.
>
> Thanks,
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>
> Zhu Yanjun
>
> >
> > -> Then call cm_alloc_msg() while hard IRQ are masked.
>

