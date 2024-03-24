Return-Path: <linux-rdma+bounces-1504-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DA7887C90
	for <lists+linux-rdma@lfdr.de>; Sun, 24 Mar 2024 12:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD0941C20A6D
	for <lists+linux-rdma@lfdr.de>; Sun, 24 Mar 2024 11:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3762A14A9F;
	Sun, 24 Mar 2024 11:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vfiqz0zB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA50B28E7
	for <linux-rdma@vger.kernel.org>; Sun, 24 Mar 2024 11:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711280594; cv=none; b=JcsCcMpDL2pVPY8Wtz9y7bj4ypqc+mN/XzGMe2mTNO6OUU4JLNKv7lmYaz0iV8q+9gUu2e4GsLM5SDhkScIoJP0Mtt1HDa+YV1AEknjZ6DiVtPFUGbnLwGhRS6BiP0JLL+l2X1YlEOj9uhmoYvPgfABaKrsuX8wjrA3m6Y3OqQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711280594; c=relaxed/simple;
	bh=Q7U69Dbp+pCMCtTkOKNH1LlIRh95F+T4ckwgg019cJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bypl5YyZt3F3R3eE1JYt+EBywrQzWFhQ+GHv0pbRh9+hW5BXKXJy3BqWXkT4xy56wWiEOACFBeV4brMTxgYr3CT65ZYsQZnkcXBcQ4CMJ4QMlk5FGHCKr8PZpKI/vY/blTe+X78VZAJsR9dgxkUsYQm4SS+GlbKjYfE+ab7lsX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vfiqz0zB; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-29c71c6e20cso2396974a91.2
        for <linux-rdma@vger.kernel.org>; Sun, 24 Mar 2024 04:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711280592; x=1711885392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwmLvRLseeNR0/rnnlQzLulZfh3J6mfQCDXNPoa27NM=;
        b=Vfiqz0zBXLqytvo4MFOp6qW+KYEwjJg8RcBrgkifWTgmQ9PefbHza6Hkx9JIX9dWsq
         nRWPLMvTOs7rDV2wPSUKn7RDihznHFmHAangV7ui/xKaHYSaszcRg6voXOjRcu1IVuCZ
         2HnosHQrpdeRWt/Nkb71NB6ro+OVJa/+sYj2KsstZG3mi4Pp1ibxCKd9WB4+1Jx99XY/
         t6CnesYYYR7Qx9ao68mJY7koVfETQLfXbJVLT2Ec+xWDN5Ld6V8YuJc1lF34jWgzV060
         evG6/mlG9IFg4xuqhhVp5jRPdYMDcS3WtRRCY9/QRtJnOcWMezB0R/BACZ//GQhwJSya
         BLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711280592; x=1711885392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DwmLvRLseeNR0/rnnlQzLulZfh3J6mfQCDXNPoa27NM=;
        b=KBnlS9QCsdDw+CnQTYiGsXSaxtRIMWyCxNF+cAoNE+oWA+1ldFVVF2PPhiHmN83QGK
         BihD5F+PYuvCILbI1KDAk8PuxBaD0JDekr7PJJVzzEXkLlbXl55NeUdnkz5HMymaBdfU
         4ok8q1G9kTMSNWr+Jjf8t/jtNtBAExEnHUvY9zyRXYMmDp80j/m0PtbPhauVsGv+4j7K
         pSHMF2PmHG6coZarmVo9SioX53Olb1bOVeIA+nh0ifITwMxSDQPHw+t1hzMrqFFzZhkG
         C7pM8R0dYOzH/0iz9ZxRhK/bNQFqhbZzdR8QpgtVA1ux8NTw52TcpJOog3qpHzLZp64/
         4tEg==
X-Forwarded-Encrypted: i=1; AJvYcCUfBpJAfs2K3n47Cjj0LWaxzq1is/y2e7E9MRNA/E3PJtnZlqGMJlFyZdmHG/AbPWx3EtBNHLo8cllOoPtFc1z4li2+YCRltXxsXQ==
X-Gm-Message-State: AOJu0YxLNmUm0lYxl8H6V7PbCk5hzs421+/3BK+HfUXnBU/DNWPZyVv7
	DDqHVyKGzfD452/w1J/1Ym+gg+pqaCIiWwb9sTvknMSBGnssYBup3zQqklxteL5chcRQZk8+W95
	3V6+bGqO93OGbTd/Qe+WqHfoIQv8=
X-Google-Smtp-Source: AGHT+IHPA56YVyCgqTkXAMiLWRWffvNxIZVdAC3aDcqTrHrgtxMkpE92F2zo1bEJ/11Drx8ZRHpgDmbSONMU7cK7qxg=
X-Received: by 2002:a17:90a:e392:b0:29d:fe34:fa16 with SMTP id
 b18-20020a17090ae39200b0029dfe34fa16mr3125206pjz.21.1711280592033; Sun, 24
 Mar 2024 04:43:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240323083139.5484-1-yanjun.zhu@linux.dev>
In-Reply-To: <20240323083139.5484-1-yanjun.zhu@linux.dev>
From: Greg Sword <gregsword0@gmail.com>
Date: Sun, 24 Mar 2024 19:43:01 +0800
Message-ID: <CAEz=LcsPB4nQWAqzf0c1YiD7SbEtc-T0ops=wwvpNLH==cQ2Sg@mail.gmail.com>
Subject: Re: [PATCH 1/1] RDMA/rxe: Make pr_fmt work
To: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2024 at 4:32=E2=80=AFPM Yanjun.Zhu <yanjun.zhu@linux.dev> w=
rote:
>
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>
> If the definition of pr_fmt is before the header file. The pr_fmt
> will be overwritten by the header file. So move the definition of
> pr_fmt to the below of the header file.

Awesome. You fix my problem.

>
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/=
rxe.h
> index d8fb2c7af30a..dc2d8dd2f681 100644
> --- a/drivers/infiniband/sw/rxe/rxe.h
> +++ b/drivers/infiniband/sw/rxe/rxe.h
> @@ -7,11 +7,6 @@
>  #ifndef RXE_H
>  #define RXE_H
>
> -#ifdef pr_fmt
> -#undef pr_fmt
> -#endif
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
>  #include <linux/skbuff.h>
>
>  #include <rdma/ib_verbs.h>
> @@ -30,6 +25,11 @@
>  #include "rxe_verbs.h"
>  #include "rxe_loc.h"
>
> +#ifdef pr_fmt
> +#undef pr_fmt
> +#endif
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  /*
>   * Version 1 and Version 2 are identical on 64 bit machines, but on 32 b=
it
>   * machines Version 2 has a different struct layout.
> --
> 2.34.1
>
>

