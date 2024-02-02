Return-Path: <linux-rdma+bounces-861-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE63846A0D
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Feb 2024 09:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9207B238C7
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Feb 2024 08:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD6E17C76;
	Fri,  2 Feb 2024 08:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUtKKFy9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCC917C6F
	for <linux-rdma@vger.kernel.org>; Fri,  2 Feb 2024 08:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706860836; cv=none; b=Dkg4cY96eJexVthj2LfC1amHntXRDOKI0ln/tWY0nhzvQCxKTd5EWa+7GlsDEF42Jon5Ym3OltQD9ac8+KSNwExzUFjH3R8c/c1ahUbiFZbthpLEvY4Ge8RSGFQmsQAIuyKj0l2GgvrR0BdmbrxVJCs1KVqi2L8JyIYIeU7N0wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706860836; c=relaxed/simple;
	bh=Caq3eLgAqhpn1wXLvzdTiZnTIwEVRarPZr4bES88teA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eUFl7vErfblGEsil/+eGdi0XTjy/pP64kSsajIot0dZSJsDoTxV/tC/h5m2f/SwQr/D8J5TiZ78i7fz2irDJMb+yVSmJkSpaQbnb/JvgPXXf+WtIXblz0MqLn0gLOuWvIznt/zb/wOzwhh5yQ2bw2HE45VO0Q1QJksWBtgI9akk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUtKKFy9; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-558f523c072so2638859a12.2
        for <linux-rdma@vger.kernel.org>; Fri, 02 Feb 2024 00:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706860833; x=1707465633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TVqnOdbGuoo0gbOOgrYu3bdr6LAy08hmirvaqp4x6I=;
        b=FUtKKFy96b8B7p2Y8giKZFDtwkVZIFDciW0SqUaUkPma2UaDft+ld8BcgyGktb1skP
         dsm+JygQO/Qj5wUtKuGXCwwMvjF2s3OkCwY2iphrVuLKCqhS45IO1Y7XE37qqKZ2jsBZ
         DMrwLwL8rLcxzTLz6CSI3E3scPmCgZmsPVLX5hdXnXONnvspuslblg1VDEJU7NmaA91e
         i1ycVJn7z7MyGcscSpCy702Xi6eRfOt7aQfzplTPieeYc70UJW5VZg+2Sx4Yjz0v2zx+
         NB/jlkk0K27ALl2oHwSuICD3fiRR8LVZvUwbzi5PYvcOMk+5qE5RvDR6YIPApb+Af+XB
         4G/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706860833; x=1707465633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TVqnOdbGuoo0gbOOgrYu3bdr6LAy08hmirvaqp4x6I=;
        b=QSe/Heyn8C13tGkRe8eR7niPS7Z7AMn12PlwkynI32Yqno5Zn198lWg1utWm7k8PTg
         Mgk8t4S1xY1EfPJHeLAaARF5AtD/7fC0PCptlWk9OdofmekB93nhvKTX4o3gmq5iIJu4
         JIV6Crumkoonh8U5NfQ397iLzW/5URvvgLjprKKRHNePwNycnxtKdvF1srHn2slih6LA
         QvWuZQUJPfkCUr7HYketXpQGLys+p42aF34BvnIsVGNaANzCSLKAKzlZK5mxZNP3fJPv
         1ZHk9g34Q0EXlYgAmfSLK8biu9D9CXXcnGU9vxV/kaD/QzLdPGhjcV6o4R+BAsepQWTh
         my6Q==
X-Gm-Message-State: AOJu0YxxWHYEjNVRpeRgoSXVx7ar1ibrlxe00jfVe1l1dnS8KPGy6QD1
	S/jVa/onghA2oQLnnoldBDhXpIh7h5p0AALmKxLld067sLL+pCZNICHdh3Ryx4bkYjK9h1+9ZCv
	E1Mj/HWm4p3inySNKtqn0eJnVr65MpaEW
X-Google-Smtp-Source: AGHT+IHma0qwltFl0zp/C+voom7pxokXxeH+7bF7PpYOyXHrsXRnFFflIv9PfyRc/aExhPaaqVa3RrvQHaSryj+wNH8=
X-Received: by 2002:a17:907:1110:b0:a35:b808:8f1d with SMTP id
 qu16-20020a170907111000b00a35b8088f1dmr5568451ejb.67.1706860832547; Fri, 02
 Feb 2024 00:00:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201125745.21525-1-guoqing.jiang@linux.dev>
In-Reply-To: <20240201125745.21525-1-guoqing.jiang@linux.dev>
From: Zhu Yanjun <zyjzyj2000@gmail.com>
Date: Fri, 2 Feb 2024 16:00:21 +0800
Message-ID: <CAD=hENe44LMs4uu2ir5sV=WmBdWB3kaumj_1FHsJdeUPK4KCRg@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Remove unused 'iova' parameter from rxe_mr_init_user
To: Guoqing Jiang <guoqing.jiang@linux.dev>
Cc: jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 8:58=E2=80=AFPM Guoqing Jiang <guoqing.jiang@linux.d=
ev> wrote:
>
> This one is not needed since commit 954afc5a8fd8 ("RDMA/rxe:
> Use members of generic struct in rxe_mr").
>

Thanks.
Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>

Zhu Yanjun

> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe_loc.h | 2 +-
>  drivers/infiniband/sw/rxe/rxe_mr.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/=
rxe/rxe_loc.h
> index 4d2a8ef52c85..746110898a0e 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -59,7 +59,7 @@ int rxe_mmap(struct ib_ucontext *context, struct vm_are=
a_struct *vma);
>  /* rxe_mr.c */
>  u8 rxe_get_next_key(u32 last_key);
>  void rxe_mr_init_dma(int access, struct rxe_mr *mr);
> -int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iov=
a,
> +int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
>                      int access, struct rxe_mr *mr);
>  int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr);
>  int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, unsigned int length=
);
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/r=
xe/rxe_mr.c
> index bc81fde696ee..da3dee520876 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -126,7 +126,7 @@ static int rxe_mr_fill_pages_from_sgt(struct rxe_mr *=
mr, struct sg_table *sgt)
>         return xas_error(&xas);
>  }
>
> -int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iov=
a,
> +int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
>                      int access, struct rxe_mr *mr)
>  {
>         struct ib_umem *umem;
> --
> 2.35.3
>

