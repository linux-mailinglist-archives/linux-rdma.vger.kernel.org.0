Return-Path: <linux-rdma+bounces-10733-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEA8AC438F
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 19:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8CB017850D
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 17:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040DD23D2BC;
	Mon, 26 May 2025 17:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBDvkXWI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5880B2A1A4;
	Mon, 26 May 2025 17:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748281993; cv=none; b=H1b5suVcWMx9W74BiDI+TMS6PdRqQrIU6GKkVXOYCrtl3M9apN7mT/sQC34I2lWCN65VAmlsf0JbSOwg0005l1RQ1ozcbUma1OO4MDq79anT7/bG7+yf7RLWA6QTnEwQbWApe7ippgT13TUHUiXNgZRy2crVP6SynxZ0JFJ9WbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748281993; c=relaxed/simple;
	bh=nNrK6YYKXxNt5ah8SdqHu4+Qazda+8qswns2KblJlu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOv+3CNBiuot4EA7YC4iapHFMfu5uIB7Ficv5xVbvw4nCpQ69MqQn/L7zdFC95Fc0v0M/mzSGIADXhKrvdighybLTPtqdqvR3Si2BN1RiIw3xXozCkaPF7hAub2dcA37Yc3WEUY4z2IRnSnntdW2pTwD8B9PoccpBywpXv0YjgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBDvkXWI; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-73502b47f24so1369950a34.3;
        Mon, 26 May 2025 10:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748281991; x=1748886791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulsmYMmE1xUbmctzUeDHmMIiGFwac4tdbygToyXWamg=;
        b=EBDvkXWI7fU4amtRettdaLX7HVARA4gv8TC+jisz5081wKno72VsuJ1YM7y3NmNIve
         HL5EAkuOE9d2hTAL7CRjeVF2LhDWN6fKRa8yu3hJpaHyxWd8Em3UTb/fxMBTWQxrbqdz
         H8EWN52CA06e5sXyLxgRaD3u9uWG7sJP0Y9QKsBSkvwUobjUmWacnBpAx3+sbug0jE79
         HY1QUDWSH2WX3kCVdFnuPLuICg58rh/UjxiSvOQ3NKl3sV6Dy/Oep+y9f3CE1gL6uGM4
         fzd4bhMSCECp7L71I05lU8pvweQEizz+a52n4LGaiPM+Nxah1ftmSf5xUP79S42Hg47X
         I48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748281991; x=1748886791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ulsmYMmE1xUbmctzUeDHmMIiGFwac4tdbygToyXWamg=;
        b=nZ12000CZNVt6+215q7OUPVIyzfxwpaiy09fWP5jlQk5nkf7zRD37PL+zxFTX83CQY
         fE/7CIzVGbpeKIIxXUYdT9bOJihq1qYArDDEG9meTbKrYc22XWVSukDmm8id0CR8Qbma
         j5OakBF+HeZaAQdB3O16BuT/FqFjtg457ripYuvfk3uIwOd+s/7Vv95aHjnniygPvzEB
         E5rGM9U7mJtOfl+ZnSfdYkEEXe1kLmsthvKBF0hyG5bm9EGEQ+DTKoIiP1ELugNb+oQH
         xga7OkKD/qcpoWed+J4/fu3G12QBWjNyjIu/uSX61Gt/NXesOfix28f5kQXy9I9nXTFf
         xaZA==
X-Forwarded-Encrypted: i=1; AJvYcCWu57R38OSaGDRUBUh/ohHyXwRO5AwG1XWH0aLK2LGn+2E5m+8vYeIoaxWs6eRBtYZ+OwvY0Cjnd99rI8s=@vger.kernel.org, AJvYcCXd5QlEgdzjV8ww/P0obuoxCwvJxyHZTf2KOHBWadl1zuUNnzMx3aTrrJCCQ/R1NEmL69dUsMZUp63XNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yww/1Qp8TJ/1exLUo0W0EqLKUCjfJITWQfIcLA0kUs/mXf4neq8
	gueGGj7+vkeR6dwC48BKzMfb7v6YQOGuFV69gAyf0IwPujWi6EjUNVPp97GEWhCkUCTY2LlLPA+
	UkmpoHYV5/8IUVXs9dgvxrjRn77tLeKs=
X-Gm-Gg: ASbGncsE1Dlpj7/mC0D2k0/wa2VdOJ4skim8L0LxpD4qBJEi3r10sHhne9tJwnWD8fG
	omiA/slUwwzsQUHI3a9ERHmv6jVYH++29A98aQDGk3yvOe3k0LiTS5CgrUVep5D2h0KZXKEcQhn
	T0kt1arcvrMuL/EpySZYIYGWrOgOTlzBhUzWErTyw1ATk=
X-Google-Smtp-Source: AGHT+IFs0D7+cR9FJaHXuX1a5FrjxV5JqlnkXYUx55jl/OJ/Qe7INh47qfrrlQwWDcHo7WCZkTdOme/8CNgKYnu3Cio=
X-Received: by 2002:a05:6808:320a:b0:401:e963:e973 with SMTP id
 5614622812f47-40646873007mr5662803b6e.30.1748281991290; Mon, 26 May 2025
 10:53:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524144328.4361-1-dskmtsd@gmail.com> <CAEz=LcsmU0A1oa40fVnh_rEDE+wxwfSo0HpKFa_1BzZGzGG71g@mail.gmail.com>
 <20250525060549.GV7435@unreal>
In-Reply-To: <20250525060549.GV7435@unreal>
From: Greg Sword <gregsword0@gmail.com>
Date: Tue, 27 May 2025 01:52:58 +0800
X-Gm-Features: AX0GCFuljsHn80Jjc9veZAmLVsJvzdAbnaH6AeX0CUeYQlehRiYzjnxqsm4TxUY
Message-ID: <CAEz=Lcu3KtR5vNK5KbUcUzziit7z=rJofNQjVB-FA=35jiAseQ@mail.gmail.com>
Subject: Re: [PATCH for-next v3] RDMA/core: Avoid hmm_dma_map_alloc() for
 virtual DMA devices
To: Leon Romanovsky <leon@kernel.org>
Cc: Daisuke Matsuda <dskmtsd@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, jgg@ziepe.ca, zyjzyj2000@gmail.com, 
	hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 25, 2025 at 2:05=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Sun, May 25, 2025 at 05:27:23AM +0800, Greg Sword wrote:
> > On Sat, May 24, 2025 at 10:43=E2=80=AFPM Daisuke Matsuda <dskmtsd@gmail=
.com> wrote:
> > >
> > > Drivers such as rxe, which use virtual DMA, must not call into the DM=
A
> > > mapping core since they lack physical DMA capabilities. Otherwise, a =
NULL
> > > pointer dereference is observed as shown below. This patch ensures th=
e RDMA
> > > core handles virtual and physical DMA paths appropriately.
>
> <...>
>
> > > +EXPORT_SYMBOL(ib_dma_virt_map_alloc);
> > >  #endif /* CONFIG_INFINIBAND_VIRT_DMA */
> > >
> >
> > Your ODP patches have caused significant issues, including system
> > instability. The latest version of your patches has led to critical
> > failures in our environment. Due to these ongoing problems, we have
> > decided that our system will no longer incorporate your patches going
> > forward.
>
> Please be civil and appreciate the work done by other people. Daisuke
> invested a lot of effort to implement ODP which is very non-trivial part
> of RDMA HW.
>
> If you can do it better, just do it, we will be happy to merge your
> patches too.
>
> At the end, we are talking about -next branch, which has potential to be
> unstable, so next time provide detailed bug report to support your claims=
.
>
> In addition, it was me who broke RXE.

Is it an Honor?

>
> Thanks

