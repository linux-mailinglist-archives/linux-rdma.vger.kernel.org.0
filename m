Return-Path: <linux-rdma+bounces-15067-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C1CCCB8E6
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 12:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE3B630F9D51
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 11:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508B531A805;
	Thu, 18 Dec 2025 11:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R1rStvbO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB369318146
	for <linux-rdma@vger.kernel.org>; Thu, 18 Dec 2025 11:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766055994; cv=none; b=VjeuIA2X95DYun7LWG5asgKq0BLDWym42/xKeEUL0HY7P3PKUPF8HBnQ1hCebKCKbNshLYXabITmGMn1tNXH5hj735e7lc6V/Z+GaHl0XTc977XailZWL4yRfuUjJzfuP9YBs48UTnpR9ZcquT4DKGrdBWiD1gPifDeCwIDunRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766055994; c=relaxed/simple;
	bh=YdmSp98VOpb4w/1T9TrcnGT6vsEQNrGtK2z/qAxMy0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n7cpzOwJCrH9xkUZXJI6GrgokjpLGCt0DNy+OGWv2+SG5IfiBOc4gSn+iR+WpKDj5G4qzPhk++acIsglGJYBavaWaCaJ84fozX332mvqML4o5bJFK9/y5iZAl55PVyP/tYrjeTiXGtTpFZyXEUgKJ0GHl9+mPW/5MUNp/p1QYsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R1rStvbO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47a8195e515so4343005e9.0
        for <linux-rdma@vger.kernel.org>; Thu, 18 Dec 2025 03:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766055989; x=1766660789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdmSp98VOpb4w/1T9TrcnGT6vsEQNrGtK2z/qAxMy0I=;
        b=R1rStvbOQr7NSeZh4jY52XZ9TB7IioGPAQfJaZpIwuJOFmpU/F/IZ95KQ76/zXVMk9
         7Yxdn2c18SGxPHCmJ3qAOWBmBZdrvEtaFg72nchPjiKuUMs5eK2cMBdNq4w/IOPXCB4v
         mzVzrkQunocXzAAxtQUu7sH4LwetduVJXUONeSpvVfPRW9lvWUxGfE6FVrFtF3OER0h+
         Ac0JRvJ5k7blRXFgtXiX7qo9MTGSspytwDOqkc7LV9T2IyXJPbl1wyhAIa31NhUyg5pX
         yFibzmySo7nPrycOgG1M8g2cyVgNY+ECaSF424ueFbOktrFEabSaExPdH5mBH3yF4XX6
         UeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766055989; x=1766660789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YdmSp98VOpb4w/1T9TrcnGT6vsEQNrGtK2z/qAxMy0I=;
        b=Vp15BA7Dhq3glct4WufWh0MOsNVOBOCxK+95jiSXGUsuIBsoqqvHZ88sh2MBKOTtO5
         U5lVKQfSkXI2Epdg7CPhNFPRivPZYypVDm4mrLPU6TVt928lw6VaYL+Mu2ssq7SX3K91
         ZwIjB5l5fRnDfZYdBMEipBEVUgDqMu4TCRpwCBpKHunRKps5FIZXxFTA6oL7xrzYxlkB
         Nn1ad/z3goHH2g1Ghm95cu24/O8nLE/WxyVrMu4PK2ctg4SYzajl/kjj7/Hhjq+ze+lM
         JmZjxr5xCPhWPT5fCr9OKABNQJvf8z/nnMEoAXpBhGWq98TmEE5QfiaNo2OLpGEMD/Q2
         mEPA==
X-Forwarded-Encrypted: i=1; AJvYcCUGpvNmu7mxx9Pqi4UYTEzxddOG2Z6i1WmGbacTN3UAqM4Vii9zXv2hWs2sSCkKicj0n/fOHlqiCJJu@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq7Tf5+mu14f094Kfvq6pdxd9I7xQDYE+5tnYBuRC8Z8h75IvG
	O25OJXpoJyk5syibzBKBcmBTcWfEN1WFdXfRy6Js9PvUYDTwx6igmF/A0I3Lw70AYZfBBhpvR9A
	TfHO5N+7EN4pEo34+N6fOJ7SRq2wxpbHWLfYQnk4l
X-Gm-Gg: AY/fxX5I3i/NPGdEhvIvOHiq+evIwDMceKI2kKtTegcJDWXXh+D4OSZ+EBX06MbSDRj
	MbcLpp6pjQsRwk+Vc5BkzqaoFD51/mfIAqamJmIOpxVnvlHfd44Xqn3q+tySOlJAVv53PoLU5D9
	7aXFyW8PUhQMnEzXyUL68WFMFTmo1w3fU0OXNPw68QhUq396aI9d3z3Exeo1ljVqlRWYSz+xEi2
	/ZwEqhJtHbtb66StyVz9//vBTB+njF8GS7d5DrCpU9tANh/0a79bW5TGMr5BMMIMBFGTuN2V+VF
	QAaxeG4dg7KWCRKeJqPAosFp0A==
X-Google-Smtp-Source: AGHT+IHUVbI/1P7zakDM7Wi5UCm2XC9PsUzzgUmoBdz1wcDrZw0JyEjKaERyGFb8Dk6P9ewUvmrPIJy5bf6RJ2inAko=
X-Received: by 2002:a05:6000:2311:b0:431:266:d150 with SMTP id
 ffacd0b85a97d-4310266d59dmr10262959f8f.44.1766055988640; Thu, 18 Dec 2025
 03:06:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aTV1KYdcDGvjXHos@redhat.com> <aTV1aJVZ8B8_n2LE@redhat.com>
In-Reply-To: <aTV1aJVZ8B8_n2LE@redhat.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 18 Dec 2025 12:06:16 +0100
X-Gm-Features: AQt7F2oOZgjISObSjjmOs0kcLH0arkernyhqWoUniY0Q3NRwv2tC-Isq-vwEzQQ
Message-ID: <CAH5fLgiYyfrwvmPyVGYD=sbsyY_2G5Z3mbfNRDa4uC2PS6iQTQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] android/binder: don't abuse current->group_leader
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

On Sun, Dec 7, 2025 at 1:39=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> Cleanup and preparation to simplify the next changes.
>
> - Use current->tgid instead of current->group_leader->pid
>
> - Use the value returned by get_task_struct() to initialize proc->tsk
>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

