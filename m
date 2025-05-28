Return-Path: <linux-rdma+bounces-10806-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FB5AC6006
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 05:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE9F81BA3A3D
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 03:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CE51E3DD7;
	Wed, 28 May 2025 03:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p0vwD/5X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0325A3F9D2
	for <linux-rdma@vger.kernel.org>; Wed, 28 May 2025 03:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748402631; cv=none; b=Dv6vqHH9jfDbWcHLB3pSB6Od7GHHypnplh5FQJF+UPbWjTupuZsPxWO2dE2xpWL/NsJ1TymUsYpPr0f6PMA4B17+ujbRImwI9G8wfC9OSj7XSV9CHbs5d38m6RnH7VaiO4falneysE28ajusMBkgRKA5aMdts+IDEO2QzArngRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748402631; c=relaxed/simple;
	bh=vqO+Pm/HwIo5j2bH5VUANxqKXpi6ZB2hEzbeH28UmWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l07FwUOANzEr0oWpPFcR+wJqEwOFHGtIZJ9r/XSa6P7l0c6NVc9IPnAWsxSiZQHc80O1Xt1Hka7Y4LkiuDMW+7IC4sPUuREJVA40yrnbkJk9QPfBH/JbHV+jN9l/brxGy3WhtWNHD6PI+21Y1md0beRpHyDad8qCiTA2qkEqjlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p0vwD/5X; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2348ac8e0b4so71505ad.1
        for <linux-rdma@vger.kernel.org>; Tue, 27 May 2025 20:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748402629; x=1749007429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqO+Pm/HwIo5j2bH5VUANxqKXpi6ZB2hEzbeH28UmWo=;
        b=p0vwD/5XFh5llZYeWqF0PTmm2GwywM3CMo5XuibxGx4z5aBU+feF/KYJw7NsnDeLKK
         Q8ySWDV47zStZCcEkuEjvESRXvcFONuczH+Q5Hh1E8UB4mmMUR7Pbi+pRz1/3lLIg0+A
         mrls/9KvgpIOVPva4ETMsqimq0vZCy332ZaY5METQoTcARwUV90jGo9o8h6jxtBk4rLO
         9bpRLtFTPoeFFbBPc27xnmUpcJoiqKJXU6vJwcjxcsLQChvcKJzCzVBN/smFSZYqdO/Z
         NEUQChhzzsoPCxSSHexqktR1BvduQAIcTgGSIXCHGOU1qGxdJkC9hDQrOAqo+/qz13rj
         7ojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748402629; x=1749007429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vqO+Pm/HwIo5j2bH5VUANxqKXpi6ZB2hEzbeH28UmWo=;
        b=OBSzvhFJ5K4CRkUqalG02Kc3ebmvb6MSkC1e0usP+95WH/WsKxdhw8Ujw7jkrz6ZLI
         xH4oW8jMEEB5u5QgzgeDW00oxD6U8Yz8ym/1UR92XnTjZj+7FJ3q3QwrnjcxZ17ckno5
         BRu2EDmdRBGBeUwCmS0dUDBFOrd8Kt+9UAtaIWHyYsSff8ofSDXXQfO7tawa6eXUzE/t
         1418/KZrBW02TQBB5oSf+j3VRugZQTr9t7YZR3iPcTM+8jiXl28hlNt2R9dLSaoqplTt
         M5qJmITQ+nVRFyRjtrfPgvM8ooOUZniTc0fZNH3OgmF+zeMNjjudVuP5R4u5cpSzbKPf
         31Qw==
X-Forwarded-Encrypted: i=1; AJvYcCXdJQ+Apu78AVSlJJL4mLjZK4Fg8VPyT80gf0TNOqoxy4Z1yq5MUECNBUUp160DwBrapIeDpJXVUc8j@vger.kernel.org
X-Gm-Message-State: AOJu0YytG3P5VKQyUGF3UoOt6DLreUecdZ1OEOT9WY0cjzqaXTDNhrbb
	JzCik7iyLhcdOTSvY07UxGrmb9Uuj2v3Te8yRpUsar+cWDLC27VfMMM1FTd+VBdqCmX41cal9ye
	zos8lHLRYeACNxGH6zv6JTpTG0Z2cAm7BDyajRoy8
X-Gm-Gg: ASbGncvC9x+vu4W3jXZCHRMesqxJfqPtAritWrEikE8dwTN30cAtniSDngkzKji0W6m
	URf85ggfgfS698oO1ACK6za2FKHLWW9v1OA290cSfupHDCDRfq0LBhyMboCFg0vjEUYx1ijsI6j
	1I0o0+/4OHeNvBBQZ6drM7rTx0o3bxk+tgPzmREWmqUIvx
X-Google-Smtp-Source: AGHT+IHrCaCboVb+mYd6VODPHySRh2UlXAVZ/QOay+nn+pjpJ//L1jegP3WSxBTh/9vzWlfdXpQUzy+19mVRhyBPxn0=
X-Received: by 2002:a17:903:1b63:b0:21f:2ded:bfc5 with SMTP id
 d9443c01a7336-234c55ab5aamr1578395ad.28.1748402629057; Tue, 27 May 2025
 20:23:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528022911.73453-1-byungchul@sk.com> <20250528022911.73453-11-byungchul@sk.com>
In-Reply-To: <20250528022911.73453-11-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 27 May 2025 20:23:35 -0700
X-Gm-Features: AX0GCFsppSqNuMrfRURYgwM0eiForkoo7rTRScW8zc9A7vZ7d83h17DCjG3kLl0
Message-ID: <CAHS8izMWhqJacD2UKJWGOEFoqcSbeaiEYkkQsiHPKkCNwnOmHw@mail.gmail.com>
Subject: Re: [PATCH v2 10/16] page_pool: rename __page_pool_alloc_pages_slow()
 to __page_pool_alloc_netmems_slow()
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
> Now that __page_pool_alloc_pages_slow() is for allocating netmem, not
> struct page, rename it to __page_pool_alloc_netmems_slow() to reflect
> what it does.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

