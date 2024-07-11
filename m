Return-Path: <linux-rdma+bounces-3810-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FB592DEBA
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 05:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67FDF280FFA
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 03:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709B4BA29;
	Thu, 11 Jul 2024 03:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiUTMyDM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57D8E572
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jul 2024 03:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720667333; cv=none; b=CjzOxTdw+dFlRIsvs8muvugWEy/I/6vZtJfTwN4p4xaJxjVETFxKga18BrplEnKA3CSX+5WpCui53MUWJhRGcB3GSriM4X3BrMiJKMFyPwAI7q6srLr34OfxGXEBSnQ/DxOQS2VNIxPF3t4XSSunE40Qy89EZWPSlY+HeC6DQmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720667333; c=relaxed/simple;
	bh=f8bUFPiFxogkALhWTPQVZ+N6FOhxORMzi/Cjvv8//Po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h3qyqdqY92Jd1mNWxWlfj5BA4Bi4zmUI+HIj7ly55cmToHiZun9EcxHxFm/i5v8zKs/XIK6afGnfVQ497uoEoWbSp/GHsHE/jtJpNjUJWkzkLYsEg/qEySRE7b7AodM7aqmj8SNT5hqmgRYYWsTeyY//DicfQQaVZa0fmXzsV98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WiUTMyDM; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2c983d8bdc7so388100a91.0
        for <linux-rdma@vger.kernel.org>; Wed, 10 Jul 2024 20:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720667331; x=1721272131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cWpdBqeDceYc8fqLDdz/uNMSLkWZrKUHU1F07Yulkw=;
        b=WiUTMyDMm8h81LAxzia37RC361/G+hsre+8mviTQRkeh/3E/7IEA0PjXdz7EGw+g0X
         93a6UBO8vr2CeLJMnC15+1dtOA1CPGtA/WGrMDTrzfhq5YCc8a0dqC2YtqK5gDdK8gCa
         sT38/bcH4J8cO6luqH4Y1SGfI3L2tW95imC0X7sonQJmWr4SFshNmEpqeAs7CU9ixkU/
         a7Sr9N7vB/pTq8EVHHi7/RK1TLZaEvhH+dfkIyyRvipjRM63Mk/GnexzYvMb6u6kYmyd
         fHKOkxY1kog+IK2RUaLhm2o7liwtNaQQrM1YiUxvCtBXzFMILG2xIFKnj3CThxWxysr4
         mynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720667331; x=1721272131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7cWpdBqeDceYc8fqLDdz/uNMSLkWZrKUHU1F07Yulkw=;
        b=f0437uFwoj8VM5kWNBQi54eipjcgKhYDFyygwnpxOZj52ci2QKJzKetzxvdElCOyJ2
         gEGk0f6eei3GLSZha/1w0dQD3KwLZXTIyOATUh/FrYTIl/fiRzO7ECcp1vncTtooi6I/
         uS/ctJHEsp4fM7hf1ERa+omOxZxpokC20t+e8d8wwBXnJN8YTr+sURIlSXshi8pGkpwP
         ADBnRCYCXYS1tv5vGmL3YBjblpAAQlgh5xV870kgAT0rnfOb+2KgvCPnv6SqKAlVzraz
         559tNb6CE1MgYrmp9tUJRC51qah4KORxtukvl6tA1GSKwAmptNZIHo9H4iLIknLXyHZy
         QEAQ==
X-Gm-Message-State: AOJu0YxpnPBKcGPifsx097z4x1H4ZUWWu+sPMTKhSVMP8kvRDRqwz/j5
	/Fp6bObXQBMNKPz2CaLiohP4+1bkFkYO/BZFhbMfZ3/RNYOek9VwWfEAXBK3DZOTwKd0pcnV11q
	A4v5EYonp4FAYw+21IvJ5Pwhdn0Z2JQ==
X-Google-Smtp-Source: AGHT+IFrFKVX0lU2q/BiGkrO971pdHiBJysbC2QXXXQQujqFflODRbb2Zwcj1RJOySrVrruCG7M6nHw8scMUiQ+YC50=
X-Received: by 2002:a17:90a:4b46:b0:2c2:df58:bb8c with SMTP id
 98e67ed59e1d1-2ca35c2aa92mr6202617a91.18.1720667331089; Wed, 10 Jul 2024
 20:08:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709150119.29937-1-jinpu.wang@ionos.com> <20240709150119.29937-3-jinpu.wang@ionos.com>
In-Reply-To: <20240709150119.29937-3-jinpu.wang@ionos.com>
From: Greg Sword <gregsword0@gmail.com>
Date: Thu, 11 Jul 2024 11:08:40 +0800
Message-ID: <CAEz=LctWiGuHzEcSDQy16_m6havxhLm1mL9zBpi0PafHDv5kew@mail.gmail.com>
Subject: Re: [PATCH for-next 2/2] bnxt_re: Fix inv_key endianness
To: Jack Wang <jinpu.wang@ionos.com>
Cc: linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org, 
	jgg@ziepe.ca, selvin.xavier@broadcom.com, haris.iqbal@ionos.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 11:03=E2=80=AFPM Jack Wang <jinpu.wang@ionos.com> wr=
ote:
>
> Similar like previous patch, this change the endianness for inv_key,
> hw expect LE, so change the type accordingly.

Too bad, the commit log. A lot of errors

>
> Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 6 +++---
>  drivers/infiniband/hw/bnxt_re/qplib_fp.h | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniban=
d/hw/bnxt_re/ib_verbs.c
> index c5080028247e..cdc8ebcf3a76 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -2483,7 +2483,7 @@ static int bnxt_re_build_send_wqe(struct bnxt_re_qp=
 *qp,
>                 break;
>         case IB_WR_SEND_WITH_INV:
>                 wqe->type =3D BNXT_QPLIB_SWQE_TYPE_SEND_WITH_INV;
> -               wqe->send.inv_key =3D wr->ex.invalidate_rkey;
> +               wqe->send.inv_key =3D cpu_to_le32(wr->ex.invalidate_rkey)=
;
>                 break;
>         default:
>                 return -EINVAL;
> @@ -2513,7 +2513,7 @@ static int bnxt_re_build_rdma_wqe(const struct ib_s=
end_wr *wr,
>                 break;
>         case IB_WR_RDMA_READ:
>                 wqe->type =3D BNXT_QPLIB_SWQE_TYPE_RDMA_READ;
> -               wqe->rdma.inv_key =3D wr->ex.invalidate_rkey;
> +               wqe->rdma.inv_key =3D cpu_to_le32(wr->ex.invalidate_rkey)=
;
>                 break;
>         default:
>                 return -EINVAL;
> @@ -2563,7 +2563,7 @@ static int bnxt_re_build_inv_wqe(const struct ib_se=
nd_wr *wr,
>                                  struct bnxt_qplib_swqe *wqe)
>  {
>         wqe->type =3D BNXT_QPLIB_SWQE_TYPE_LOCAL_INV;
> -       wqe->local_inv.inv_l_key =3D wr->ex.invalidate_rkey;
> +       wqe->local_inv.inv_l_key =3D cpu_to_le32(wr->ex.invalidate_rkey);
>
>         if (wr->send_flags & IB_SEND_SIGNALED)
>                 wqe->flags |=3D BNXT_QPLIB_SWQE_FLAGS_SIGNAL_COMP;
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniban=
d/hw/bnxt_re/qplib_fp.h
> index 1fcaba0f680b..813332b2c872 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
> @@ -165,7 +165,7 @@ struct bnxt_qplib_swqe {
>                 struct {
>                         union {
>                                 __le32  imm_data;
> -                               u32     inv_key;
> +                               __le32  inv_key;
>                         };
>                         u32             q_key;
>                         u32             dst_qp;
> @@ -183,7 +183,7 @@ struct bnxt_qplib_swqe {
>                 struct {
>                         union {
>                                 __le32  imm_data;
> -                               u32     inv_key;
> +                               __le32  inv_key;
>                         };
>                         u64             remote_va;
>                         u32             r_key;
> @@ -199,7 +199,7 @@ struct bnxt_qplib_swqe {
>
>                 /* Local Invalidate */
>                 struct {
> -                       u32             inv_l_key;
> +                       __le32          inv_l_key;
>                 } local_inv;
>
>                 /* FR-PMR */
> --
> 2.34.1
>
>

