Return-Path: <linux-rdma+bounces-864-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7793846F6A
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Feb 2024 12:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BA2B1F2A5C2
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Feb 2024 11:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF08213D506;
	Fri,  2 Feb 2024 11:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1jkFImW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26455C5E6
	for <linux-rdma@vger.kernel.org>; Fri,  2 Feb 2024 11:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874596; cv=none; b=Zdn4qmLblsFZ0Sd2cB167Bbw7PJhLH/AtlMmDLK8+YgsSAst/RPQWWX01xMK+alLlt/PRI3RCo+p/QjzRnlRixNDKRCi3c9BQYJ7uvS0oTdWBSuWQFjUvIcpTrbrzvVjk543Pts5/6mPfzB12i3QHLVWZi5Kvvmk5aw4al4hGo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874596; c=relaxed/simple;
	bh=0v73COBN9g3cEKGP6S4hsms+/p81eqIY+4/Q4ubbOXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pHdGixHV6/fl22BJmENik9XFjPSsuTskFyTM057d5BfW9rudD4eGxZxGB7ti5geMRDOaFhz9Lq0TJ3Efzkgyse0ybWnx6gxoXBHjug0cVr5NG+ui54t38ZHb8s7RzBW19K+cPKFmP+Frz1Lcn6eyNuspk6pNhaKqv8Ay5evxLfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1jkFImW; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a35e65df2d8so271770066b.0
        for <linux-rdma@vger.kernel.org>; Fri, 02 Feb 2024 03:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706874593; x=1707479393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDwHVnQRNnooe6g0DvIUJl/9+E4nWfdPKAbtJ9T0QNs=;
        b=B1jkFImWOkmeph6ZcbAPR4Q7Os4qljsAkIPJgcXLQbemSJetOKxIFXKPaJ8pUKYr2u
         5nKn/kNSuRg0uSuIGtLwkjSFQOdwF1NwrK42KFJEQW7OiF847B1DbAIbNS0LbA34WCbX
         fFf4FU7OqRRFYaOYCBjjUn8Wv/Uglnjd0vcGcMjBTgZRApIyTolaxRyqhmEu0J+A5Jgl
         6KLa1tBDjAkSoNdfT1hdw63KvX2j4KOKnx8BOjpmSEuxFdehv9184LEmYsnnU4EbqXJX
         7zXvkyQ8AJWFVof5JuCYnlT4GFcMm8h6yOzhdBc2NPLncPz46Gtn+nVuvi4IdegUy3eo
         KoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706874593; x=1707479393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDwHVnQRNnooe6g0DvIUJl/9+E4nWfdPKAbtJ9T0QNs=;
        b=wujaxq54Dxr4F0p7298miC2SmwK7jqvG9tJkoVO8K3Dm0wsx5p3kToSbD/Ver0bMSz
         tegVKcvAJ9aJJUx+GlGyhKVO+BOQE1aDocHX/WNH8cRaNgzshZGKR56qEUgWrm91gtVG
         76HD5NAIVxbrq08Gm2G7gRj5K0qr41JxxPUDyihNEvfDn4l6nf4gyr1taw0RgHyKMhhN
         UBQWex3x/n4zVAw9g+6quEUB0tIxPhdkMloY1TJhE32HkAwmm6shnX1k9P85BEKhTHx6
         PtigDJQwwVHNYurVrhgPLfvt6gXpKhIXMW1zIu0ouQduRPw5mEmrV0r9jKi1Zz8dc9tu
         r8cg==
X-Gm-Message-State: AOJu0Ywx4b9Xyya+/PpklA/QBwf2PKHa80eysbfYOsM9BwGy9bUqD9m6
	H3hmqL5PAIg/uN5t8cfy0jzbdPwAXkC6vTE/LulxwFQnqdmeDa4vI6UcnQsBUUrzUApY6Y5Xcdq
	urA8d1+EscOVHkpHhZ2CDHxkjGQae7iRw434=
X-Google-Smtp-Source: AGHT+IHy6H4uuHU78X22tWATIaDo6z2ClDlrqtqG5TGGKFsZ/ocGEKePZUNktJmLtce4Odb/rjLt5cSfvkGbLGx+tgk=
X-Received: by 2002:a17:906:4bcf:b0:a35:fbc4:4c21 with SMTP id
 x15-20020a1709064bcf00b00a35fbc44c21mr1288989ejv.63.1706874592864; Fri, 02
 Feb 2024 03:49:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201125745.21525-1-guoqing.jiang@linux.dev>
In-Reply-To: <20240201125745.21525-1-guoqing.jiang@linux.dev>
From: Zhu Yanjun <zyjzyj2000@gmail.com>
Date: Fri, 2 Feb 2024 19:49:41 +0800
Message-ID: <CAD=hENdNnzqBP1jJj-NHRg_BjsQYh-u2CdCQNn6HF8R87JOgzg@mail.gmail.com>
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

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c
b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 48f86839d36a..04427238fcab 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1278,7 +1278,7 @@ static struct ib_mr *rxe_reg_user_mr(struct
ib_pd *ibpd, u64 start,
        mr->ibmr.pd =3D ibpd;
        mr->ibmr.device =3D ibpd->device;

-       err =3D rxe_mr_init_user(rxe, start, length, iova, access, mr);
+       err =3D rxe_mr_init_user(rxe, start, length, access, mr);
        if (err) {
                rxe_dbg_mr(mr, "reg_user_mr failed, err =3D %d", err);
                goto err_cleanup;

Zhu Yanjun
> --
> 2.35.3
>

