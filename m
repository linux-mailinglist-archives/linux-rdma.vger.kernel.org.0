Return-Path: <linux-rdma+bounces-571-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 422DC828306
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jan 2024 10:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 693961C24365
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jan 2024 09:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8009233CED;
	Tue,  9 Jan 2024 09:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARHMeoP6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0624B2E650;
	Tue,  9 Jan 2024 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-59879d7a655so269445eaf.3;
        Tue, 09 Jan 2024 01:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704792012; x=1705396812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGj3VBS6MoW4fu1A2Hz+xT69O8k6JDvMgiWikAjhl14=;
        b=ARHMeoP6U9pQD/2SNy/TqNMkPd2YlxGPZ/KRvGI0ZLmRCJtPIquMhhUkaPSBGSETgK
         qDKV2a1+abrqlUAkDeF/VZWfDt/JYI50OqQNNzA7GK98a+AUhChO9QO6l41MxpqMhLXR
         olB3aPNSmL3+OF6vmBiRXDIyIYTmrWnKbcbESZ+P+HVu5Fn4JKLabQUvSVvfd8/+GeK1
         dcsXNIPNVduomWwWjPdNmsk68hEZtW9AM6rr+GQXqj6a86cuiTRW46Gurmlrub3V8k6m
         zp06ydmCBJ9mEi68A7ZIBIv6Tzqv8pGUdzbf8ubhq0+qAG8a9f0f2Ckt39W4uQGg4yA8
         aJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704792012; x=1705396812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGj3VBS6MoW4fu1A2Hz+xT69O8k6JDvMgiWikAjhl14=;
        b=CcYrsWCnoFtRC22tu5iYBf/mVNGXFDjK2Rj/Mftq2xjHkJrLQgkBCgcmVhCqXMLVLm
         1c4cZAQSCprGIVnN93kJEjYonLSqfIshnYZHknIzRl85udZo3KWQX9L4gq6tnS5ImlcL
         E97AF8dSglWypzGZ86Uc4e1oKRuloASVzV0ZS13MWdLGkhIch1191wiDiHaV+95VHYtv
         u3J+yOw+H1sfo/zGc2+qSsGdaM0d+rBPYri92iekBQxy7hqsC+rpmkL5klGMoLFqyrfh
         jz3yj0LX6gy4hpg1oA0KzbE8e+RflJmcl84meja+B/d6keDvO0l0G/LDzh0tWQQ2wazA
         DfGw==
X-Gm-Message-State: AOJu0Yxr35VxHHslvE5nooGlyZ0fz2o9DAJyqwueaVTDF84cMk9+dRJl
	qGepDiImBMjQATV9Z67wF4puRbU6gH5rUwC6Hj4=
X-Google-Smtp-Source: AGHT+IEspE4b7fV8ksJUfRl2T2hPIZvhKOt0XG3EB/T2JUTA+Y6vjLDJX7rv0OcPhEXQasRxE+Tqsq/XqI0Yk7XFoiE=
X-Received: by 2002:a05:6358:338c:b0:173:478:c4a1 with SMTP id
 i12-20020a056358338c00b001730478c4a1mr4286550rwd.39.1704792011920; Tue, 09
 Jan 2024 01:20:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109083253.3629967-1-lizhijian@fujitsu.com> <20240109083253.3629967-2-lizhijian@fujitsu.com>
In-Reply-To: <20240109083253.3629967-2-lizhijian@fujitsu.com>
From: Greg Sword <gregsword0@gmail.com>
Date: Tue, 9 Jan 2024 17:20:00 +0800
Message-ID: <CAEz=LcvphS6QECpHTFhrRoC=FcSbEU4j_XuqJF7ognjJu+uF6Q@mail.gmail.com>
Subject: Re: [PATCH for-next v4 2/2] RDMA/rxe: Remove rxe_info from rxe_set_mtu
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com, jgg@ziepe.ca, 
	leon@kernel.org, linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 4:41=E2=80=AFPM Li Zhijian <lizhijian@fujitsu.com> w=
rote:
>
> commit 9ac01f434a1e ("RDMA/rxe: Extend dbg log messages to err and info")
> newly added this info. But it did only show null device when
> the rdma_rxe is being loaded because dev_name(rxe->ib_dev->dev)
> has not yet been assigned at the moment:
>
> "(null): rxe_set_mtu: Set mtu to 1024"
>
> Remove it to silent this message, check the mtu from it backend link
> instead if needed.
>
> CC: Bob Pearson <rpearsonhpe@gmail.com>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> V4: Remove it rather than re-order rxe_set_mtu() and rxe_register_device(=
)
> ---
>  drivers/infiniband/sw/rxe/rxe.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/=
rxe.c
> index a086d588e159..ae466e72fc43 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -160,8 +160,6 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int nd=
ev_mtu)
>
>         port->attr.active_mtu =3D mtu;
>         port->mtu_cap =3D ib_mtu_enum_to_int(mtu);
> -
> -       rxe_info_dev(rxe, "Set mtu to %d\n", port->mtu_cap);

I'd like to keep this statement so I can tell if the mtu setup was
successful or not.

>  }
>
>  /* called by ifc layer to create new rxe device.
> --
> 2.29.2
>
>

