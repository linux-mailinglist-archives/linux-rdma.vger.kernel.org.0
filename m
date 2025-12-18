Return-Path: <linux-rdma+bounces-15066-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD86CCB87A
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 12:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 401C0300C150
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 11:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B4A3148B3;
	Thu, 18 Dec 2025 11:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FelHrbQL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7012EDD5D
	for <linux-rdma@vger.kernel.org>; Thu, 18 Dec 2025 11:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766055945; cv=none; b=PaYqFew32hxA8NgeTcWWctSqj2KHSXPxvaKD9iTk31W1qyMrsBQHscjqJk6zN3uPQUuOaGH9YUgJDSelsoKjZ4MH06R/PsRYKvgjEhlAUNcHHt12rvY3BMD8vrf7XV8GVCjH0G5M9xSETXozHWPJZXuisMP0+pikFBoFojsoWSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766055945; c=relaxed/simple;
	bh=h3ZC/RuhXgR3ZPLee6QKXin6sxuebHRmcV4+nyImDTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZTHzkvyBaeR3T/QREibWmtRn6IXuP243Y3X3C05QIGEYz/3drxDtjmDYHlkCAlkYq88QkhJ/hKuvdJRBDWVsz0sVqwXqeRXp/rLa00Njeg4ZYqZhXKymHrbSLPzsKCm6ygjQXd4k3mzf7t5clsk4LtuuRYb6aY3F1wr6KtUEc7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FelHrbQL; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42e2e3c0dccso271480f8f.2
        for <linux-rdma@vger.kernel.org>; Thu, 18 Dec 2025 03:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766055942; x=1766660742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3ZC/RuhXgR3ZPLee6QKXin6sxuebHRmcV4+nyImDTA=;
        b=FelHrbQL3rC/08aYzxXNVQdi0CCoEVWav/ey7XvF6e9czJX/f66K2QXXjwX981w5dr
         W/R4LUwOrzprYLHoPyFqKCmvM3AA85alKkQNrQwBTL9gb0VjV+PeMPKcuUB1+RIMbUg0
         FU40kkx4VrpRsoXOiX1CugngzEzM2qOQTYHh4t+iWYpMRakNb/8+y1K4UkNn87btpght
         zcLTqGS30jes0AyieFHbG/DeP3DFIQ9ERp68j89mrAXvvXWfwC6DIoWQU80iGjMHEgwD
         MzXhgDYgkxrpNEACRYvtlTdJ6UBeQ+fRkEWbEODa+JDCWN6retcc8+U75+AY2MEMFHGf
         evDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766055942; x=1766660742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h3ZC/RuhXgR3ZPLee6QKXin6sxuebHRmcV4+nyImDTA=;
        b=SeknOqdI1yspKNTqnAY0CqgOqUSuHIqIu3La/kVYJHyhPCbLG+2N1Hb/U0mVLssB0s
         Y7RPJKxGZ8xC46J/d3xXY0+JvpVk6jgakj2Dyd71fDZ6u8B88tx6Ai8qTG7jt+FnohRG
         fmKhuk02dGH/wCHwEWdkS31vW0P3wLZpMolgJyAwcEsOvfUj7B4KGW4PRjGYn9444yAJ
         H08ri5tnJuY/FlysEbUT+7Lah4fJMAjd5G3GGOnUFnY79dBHDSWgwE45RKdMUYrspxma
         BRaW8izJt1MeY5M3AWt3773y701yQaWmexO1mS6gpcPBlRQDjOH/eaQ/NZAxSRvhCyg0
         KmkA==
X-Forwarded-Encrypted: i=1; AJvYcCWG0OXPM9EVlNR5qhPM5W+yJjMvnsdwA5GtR777z/+BpGlMausV8/oeo9c4PVozS1E2Uclgadm4cwbZ@vger.kernel.org
X-Gm-Message-State: AOJu0YymqKQrgSMWEEcFF3VIU+5+alYicIWIRWVwohRAp06OUGtEJWUY
	KD3U2iT8UOs+OLcd3ElqnThkiQZIYzZZ7PzJWLtm1NVnBujurGYkMK3HBZmwEWgyZTXPKz8sGH2
	XFeriWofMOliF1r+HMd+HAgW0rbXKuFFtM21kho6f
X-Gm-Gg: AY/fxX5+xI9E+TQVJn9vcscFCjxocczhR8Pj2Rq8FRzkp94nwpACe1TbjCgW+H+ASzb
	7cFETPFrL9eRfN5wLYjfcOztVnhhnI2ImfGJxibcsb+Qh4h5xNr8YSbfiHPlta510rjY2pZT6SY
	EserWkGbTUXaEoaytCcWkVD6wIOOMq+/3IE56DEeYxKvuaouzCijtXIUbU0hXKIYshZm/cUGN9S
	yFKu5YRkkfK9rKCH0grne1z/v+9Oq8g7c8fA/vLy58uCuXWn6LeQLVhDN87nXz+Vog2uMlibauN
	FS2wNc+y8Vo6OgLPzq3jvk25Nw==
X-Google-Smtp-Source: AGHT+IGXVDKrZjp+NvvA5/qC7WPXryh3eP96No0VLbAfD0dfrQ2PK6CbEoMBAf1PoLDqcVLWFCtzxrT0EkYfUfCTixI=
X-Received: by 2002:a05:6000:4009:b0:430:f5dc:d34d with SMTP id
 ffacd0b85a97d-430f5dcd49dmr17076013f8f.52.1766055941437; Thu, 18 Dec 2025
 03:05:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aTV1KYdcDGvjXHos@redhat.com> <aTV1dc-I5vAw6i0n@redhat.com>
In-Reply-To: <aTV1dc-I5vAw6i0n@redhat.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 18 Dec 2025 12:05:29 +0100
X-Gm-Features: AQt7F2onwZDT6I3RNp-8EABXxVlAZANhhJ-GMV1t61Vpqe-l1BJnOF3T8fFh0Lw
Message-ID: <CAH5fLgjWQ2+eG=DV-m-1ybfs_Mu1UM2Zj0z8LvU4BbE0m9NXvA@mail.gmail.com>
Subject: Re: [PATCH 2/7] android/binder: use same_thread_group(proc->tsk,
 current) in binder_mmap()
To: Oleg Nesterov <oleg@redhat.com>
Cc: Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Rob Herring <robh@kernel.org>, 
	Steven Price <steven.price@arm.com>, =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Liviu Dudau <liviu.dudau@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 7, 2025 at 1:40=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> With or without this change the checked condition can be falsely true
> if proc->tsk execs, but this is fine: binder_alloc_mmap_handler() checks
> vma->vm_mm =3D=3D alloc->mm.
>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

