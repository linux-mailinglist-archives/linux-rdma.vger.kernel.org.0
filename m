Return-Path: <linux-rdma+bounces-7983-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE96DA3FD89
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 18:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A4727A4960
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 17:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823762505C5;
	Fri, 21 Feb 2025 17:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ot26TuVR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947392505BC
	for <linux-rdma@vger.kernel.org>; Fri, 21 Feb 2025 17:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740159136; cv=none; b=DRCzHEIPT7aRQsopwi9Z8GQobgnhj5RpKY9+LUNznnZ7pul+F4eeii90aQlAistdsBt9W0SvsrKOzhV2OdFZpBGtdtzrPgdct9ni5ffyk5eLdfQGdbOPYIR1AKw5DPFdi3++s3G04iuDHFdhXiMTD4YTdxuJfl4cgpIf3Yrd678=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740159136; c=relaxed/simple;
	bh=wiwjaEXln8VJcT/w8f2zAyE4zwgZUG43fKsu/Fe8uBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fOoL4Rz4Ch+O/lS8+dhhyPTOm2bLdGFDNT4msEbnfvuT5Idu1waTXv8JJRluDzeuPLM01/rI7RRIE2gijFvGnwnEJFyr6fSzjo8alb6VrMIX8pPKhmRAFHXDCz9ZNlq7kO8LFPT0NRzFOTVgA4AI1jEtcrN6DC/KujHmXBWjhFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ot26TuVR; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5dee07e51aaso4448844a12.3
        for <linux-rdma@vger.kernel.org>; Fri, 21 Feb 2025 09:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740159133; x=1740763933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wiwjaEXln8VJcT/w8f2zAyE4zwgZUG43fKsu/Fe8uBE=;
        b=Ot26TuVRnP6A9j0GqW5C3MTEDtMKUz6g89FwbWWNQsHtISUaU+/LP4fdEuUfXuFxxt
         ltn5YkUg5SJMwGW3e5qY1Haw0MdquGNlXlbgHLPrQ8JIwuqQRax/ovnLcK41sfKKdaUM
         hbcwlu7IXuZajAyGarFtpv9w0Mqph1anlufdaAJ3f6j4WLM3Md4D6vUTVdjJ+R9ex2Yf
         aYUGZ99+2dNW7USD0stLGZtidGrN3OM5Xzr1sFpHoXlbTEBFhUBMBBMzy6n76pV7ymMJ
         7qP+HkMPWwzc6DwCtS6FbKaEKnxFEgjbtiFWb5+u8KbU7fJ5hxZIuC2i98t+E2xcZhan
         GmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740159133; x=1740763933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wiwjaEXln8VJcT/w8f2zAyE4zwgZUG43fKsu/Fe8uBE=;
        b=j9OIsLl/QThKpsfeBAZxOLJQYt7ElLIgdR8hbRD6WBaYxUDhgotMmL9T3TiX4jObZ3
         kVNe1ZK6LYharN4uJ4zSsL/SxE9fX7H5A2Ow+/wYCn+RqSitn8U0oqqU4barPqYojrU9
         /+SInHY5Q99fD0K3sCMde8DPq547W5EDpgkkULoqx3DMGwNcvt5VR797H+bkpiPkKXyo
         mXSPEyZPRiXbtVXsdy7r5JXOrHrwBVMA9S1iBVz0HPQqkEfQQLQhlXOfIYPH3y/8wEq0
         llZH0Ybjard9GKkGNL6kbRfQTdiJaaXRNVKn5k/Ax2fE9Y9BWaRDooiDSIljNJHq8Eo9
         IFyA==
X-Forwarded-Encrypted: i=1; AJvYcCVOzsgddZFmrwnKLfDEuZjcyyFgH6dDnv29k7P4h6emnq5+fUutD2N5VRPkzDMZ/qIdR2VsTxmpHQKL@vger.kernel.org
X-Gm-Message-State: AOJu0YxRU6X5s0oiCw7qzJkhiNzta0xnk2F2V5I7B8qvn9ewb6chqmzY
	yVGau/N2Pg0Ueiutt+o1WSN6jbeSUE5CcIDIwTp4kKApF/gJuFQlczKSwFFjD7IekHyWi4IjKva
	Gu4EbLJL6aiTRwENV0W2mqwWCKRgGMMFXTg5OflIseNfKZ89buyGyWDQ=
X-Gm-Gg: ASbGncvZXOA0NW2MPFFXOt+ok0bIJhjNQ0tDzb0FpWASzxXolmqVLlMUqjwwQ7NfByY
	MdhaqqDyF2wGd/lXAJZNairnkDAfmMssAkYGNmNA4tb/0vtqqt7W/kGninTZYQYRXWBS6u33OG9
	+EqC95has=
X-Google-Smtp-Source: AGHT+IFv+VLoUyXYz/aYKIMWe4HWau0AE/qSIwd7soF6AstpZPqV0F7nIOyL3lcgybbPJG0kbtlQYw9wULGA6JihJwM=
X-Received: by 2002:a05:6402:2548:b0:5db:e7eb:1b34 with SMTP id
 4fb4d7f45d1cf-5e0b70f07d4mr4074284a12.13.1740159132654; Fri, 21 Feb 2025
 09:32:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220175612.2763122-1-jmoroni@google.com> <838a95a2-f286-4f94-8667-2da8ba330c47@linux.dev>
In-Reply-To: <838a95a2-f286-4f94-8667-2da8ba330c47@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 21 Feb 2025 18:32:01 +0100
X-Gm-Features: AWEUYZmtznFGUsGZaEeJmGh-Fc_xv6rBew_U_xJzCHRugptD7zODm927UErzwL0
Message-ID: <CANn89iKSUZxfCm9rqEykZtzEAsu1F0dpooh1iih_RwRMHjpGNg@mail.gmail.com>
Subject: Re: [PATCH] IB/cm: use rwlock for MAD agent lock
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Jacob Moroni <jmoroni@google.com>, jgg@ziepe.ca, leon@kernel.org, markzhang@nvidia.com, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 6:04=E2=80=AFPM Zhu Yanjun <yanjun.zhu@linux.dev> w=
rote:
>
> On 20.02.25 18:56, Jacob Moroni wrote:
> > In workloads where there are many processes establishing
> > connections using RDMA CM in parallel (large scale MPI),
> > there can be heavy contention for mad_agent_lock in
> > cm_alloc_msg.
> >
> > This contention can occur while inside of a spin_lock_irq
> > region, leading to interrupts being disabled for extended
> > durations on many cores. Furthermore, it leads to the
> > serialization of rdma_create_ah calls, which has negative
> > performance impacts for NICs which are capable of processing
> > multiple address handle creations in parallel.
>
> In the link:
> https://www.cs.columbia.edu/~jae/4118-LAST/L12-interrupt-spinlock.html
> "
> ...
> spin_lock() / spin_unlock()
>
> must not lose CPU while holding a spin lock, other threads will wait for
> the lock for a long time
>
> spin_lock() prevents kernel preemption by ++preempt_count in
> uniprocessor, that=E2=80=99s all spin_lock() does
>
> must NOT call any function that can potentially sleep
> ex) kmalloc, copy_from_user
>
> hardware interrupt is ok unless the interrupt handler may try to lock
> this spin lock
> spin lock not recursive: same thread locking twice will deadlock
>
> keep the critical section as small as possible
> ...
> "
> And from the source code, it seems that spin_lock/spin_unlock are not
> related with interrupts.
>
> I wonder why "leading to interrupts being disabled for extended
> durations on many cores" with spin_lock/spin_unlock?
>
> I am not against this commit. I am just obvious why
> spin_lock/spin_unlock are related with "interrupts being disabled".

Look at drivers/infiniband/core/cm.c

spin_lock_irqsave(&cm_id_priv->lock, flags);

-> Then call cm_alloc_msg() while hard IRQ are masked.

