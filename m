Return-Path: <linux-rdma+bounces-7976-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F60A3FC47
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 17:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22362189ECD0
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 16:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE33207A2E;
	Fri, 21 Feb 2025 16:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U1dqvkyl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B751E7C09
	for <linux-rdma@vger.kernel.org>; Fri, 21 Feb 2025 16:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156663; cv=none; b=IqYlVrVMXjiZtL/Kb2JD2IRPjCSHnL55TkqztLVqbxFyExGPB2dhjGq9OmM+fQ+CvA/00G06GCAR6AFnXzjPtTgxmIl27V0WGe5p81OhHbSx7Va8tppcC9n44YZPp4rTG5Fk27d8wb6/AlJpDZZFuczNyRwUb/mjV1PMMq9Q+Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156663; c=relaxed/simple;
	bh=fe5r8rDXuSumleegD/cgdA/fVxNyGOEa6OjcZcVXIno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ff/DAsykQo6tTWr+7M4Q/2grwICpdONLTvl1Ug9RJAPOG4zz64o2jAc40nM3gohtXc2cjKH67zSYQigIcI/n38qJUPaEymii6TR5iKZqOUpWWPXwBhVB5cYGCPLGrDCGpE8T0XZkmNy441OXPy6Hf6HtvehayU1ZDELCWXx63BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U1dqvkyl; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5ded1395213so3995592a12.2
        for <linux-rdma@vger.kernel.org>; Fri, 21 Feb 2025 08:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740156660; x=1740761460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8cR6mG40ntMfQZM4rr0PsbmE1XoQvv39RVUwmIBH8Q=;
        b=U1dqvkyl+ZuKNlRjT1NsAI2qs5JUlxptewAGqDIBLtQqow6Y6ES3oOtw36cdDUerWZ
         e40z6UpKfUmuGPwiGOgTPY6B3UqjV9xyHAKlft0locQTv/x6S/zTkn7Su8DtxKR/7iWu
         WQjvQESwYQ/E1dbsZgdYyF2MxkaOydockiVIXxjte5YrVAg3C0c3bHofW8EZk1sZ2laQ
         4v9myh8FMqhZG9xD1w58SErPuvOvXk5MuudYI2fiUoXJvR0C54tG8ZodQYVFh59AoMLT
         nzNd6ryKTT6JQkgTk9daNYdj4HK+EulEExnBTOLOHdA4s8AW7JSeLq71Dq3dkiFf0jz8
         9jdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740156660; x=1740761460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J8cR6mG40ntMfQZM4rr0PsbmE1XoQvv39RVUwmIBH8Q=;
        b=s2GM2g7WAvld7OBaWn7/3bvMij9+bIv1qwrc/CsqR5m+VFrgC5ct3RSh20zxm0hM5F
         qkG2Wub6xTJkV2NNlbtj2H3VtJdxtVGfYHtYHO475m/VeD8TFV7ceKl7rzW3I4ztvheX
         vlr19PlzGLID2eacKsIlXG+TRlbEP2yoXRGsN8OPozDiM/DNGDIJkFM5p3TEEeblp0b+
         reWT+fKzPf8x02ZfsXcqBrEgMiR++XF071njmJM1A+3mwOpVxVyiuYpP9N3odMuHWOWF
         nd18me7+vhXSaRYdCCZlw3AMozuV9OGMRQtaykTqFWynqab9UB/dAd6fZG3y/aA9ZJ4G
         9Oqg==
X-Forwarded-Encrypted: i=1; AJvYcCVxXfDsYJNwAKm9aQCgl78ptUFch1UuRA35V9zeFtuRd7qE8c3pqxwsSXY316KisqR34sXydU1Bz1/9@vger.kernel.org
X-Gm-Message-State: AOJu0YxQDsOzqRZ6oGCnfxuwOoKGVOK/kBK7WhRrQZ+yIfjgY5kAUh83
	rqlvxwlTue5nRoSaXykAbiVzleRHnWwftjPvAeLhkuFUDlNIES1IpnKa3lgJDX7m55CnGaIyMMu
	wdRf5O+DzwfI4p0hDxoD3/tyGgjFUa8DS/nrS6cCKwUk/8C6xngeN
X-Gm-Gg: ASbGncsytE4T7VXZI+YgVPLIxx0fr6Ouf6a5QOweE/W3NhgWjGokFyu1IF5D6fdRoou
	lWxthVyWdcNOROddMNHufcEKzKGyaf7kYeaKi5tUY/qpXGpuPGqCuL2RZ0pJ3EDX1Mu40YJ2YXQ
	PizdcDBKQ=
X-Google-Smtp-Source: AGHT+IFiA7NA4rDpsXpFHRvrdI3P5o7UJpu1Wz3P5+CcKuR7SMwZwhWidgnrQvBpE7m+P1XhYCE3L9GY3kqqHrPihQ8=
X-Received: by 2002:a05:6402:2692:b0:5dc:7b59:445b with SMTP id
 4fb4d7f45d1cf-5e0b72438d1mr4053232a12.28.1740156659677; Fri, 21 Feb 2025
 08:50:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220175612.2763122-1-jmoroni@google.com>
In-Reply-To: <20250220175612.2763122-1-jmoroni@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 21 Feb 2025 17:50:47 +0100
X-Gm-Features: AWEUYZntvKV8dY8AlegfaHlUB2n3HY0x7zaip4BySxnqLjoWhNZrWF2I34HQl7I
Message-ID: <CANn89i+vf_-Wh8txmLThe5v2o+=W-6noNrGgjqyns0fEw+6Rdw@mail.gmail.com>
Subject: Re: [PATCH] IB/cm: use rwlock for MAD agent lock
To: Jacob Moroni <jmoroni@google.com>
Cc: jgg@ziepe.ca, leon@kernel.org, markzhang@nvidia.com, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 6:56=E2=80=AFPM Jacob Moroni <jmoroni@google.com> w=
rote:
>
> In workloads where there are many processes establishing
> connections using RDMA CM in parallel (large scale MPI),
> there can be heavy contention for mad_agent_lock in
> cm_alloc_msg.
>
> This contention can occur while inside of a spin_lock_irq
> region, leading to interrupts being disabled for extended
> durations on many cores. Furthermore, it leads to the
> serialization of rdma_create_ah calls, which has negative
> performance impacts for NICs which are capable of processing
> multiple address handle creations in parallel.
>
> The end result is the machine becoming unresponsive, hung
> task warnings, netdev TX timeouts, etc.
>
> Since the lock appears to be only for protection from
> cm_remove_one, it can be changed to a rwlock to resolve
> these issues.
>
> Reproducer:
>
> Server:
>   for i in $(seq 1 512); do
>     ucmatose -c 32 -p $((i + 5000)) &
>   done
>
> Client:
>   for i in $(seq 1 512); do
>     ucmatose -c 32 -p $((i + 5000)) -s 10.2.0.52 &
>   done
>
> Fixes: 76039ac9095f5ee5 ("IB/cm: Protect cm_dev, cm_ports and mad_agent w=
ith kref and lock")
> Signed-off-by: Jacob Moroni <jmoroni@google.com>

SGTM, thanks.

Acked-by: Eric Dumazet <edumazet@google.com>

RCU could probably be used here, if we expect the
read_lock()/read_unlock() operations to happen in a fast path.

