Return-Path: <linux-rdma+bounces-14995-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 575E3CBD4F6
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Dec 2025 11:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4204300AB26
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Dec 2025 10:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48694329C62;
	Mon, 15 Dec 2025 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SifOzwV1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC97E296BBF
	for <linux-rdma@vger.kernel.org>; Mon, 15 Dec 2025 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765793236; cv=none; b=JJ5/7f+eqF03f6dkgpJ51tCFddWH+qAojWXUMPVI3/3lYWiQYKv+xjFbuejcnIAcRx1fSQsV4qGVhL8IjvBeiUjfx2WDR7GXI02FxqL3c6y5AN29VPo7Sd3C4f+WOcOIY69AQGEq38Z0eyZ78XQrvQNBWJXGv5FeUX1j5CYGnFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765793236; c=relaxed/simple;
	bh=nbhomQvDmc2WWDf53DCglKd5Zl3VxU84NeqBx/L0fgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZlCLsZk6TaaM0CeXaI8pcstQzPUOI0r6GK1zHI1+NGNeUKcMm+vfuh8ybWwkHcpflXkGyuZzFVSCLzOo8+AJJMHzUfD32+ccAuxtAC66QLW9EPzMc1CoJXjZZrk1HYLJ8qHhECFcgNo9sVOT7c9yv7Y5aCpMk0YOVnrGrwzyxlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SifOzwV1; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7baf61be569so3881625b3a.3
        for <linux-rdma@vger.kernel.org>; Mon, 15 Dec 2025 02:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765793233; x=1766398033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSKpCvg/uYgrOa0A/iyr6y8xb+KW9R2SOkoEVIfpqEg=;
        b=SifOzwV1qMVEuLa0Sy0kHofrzJQcDWmc7gIPD8Wv3HL3k13/BUlCXtMvtRmY6sRLZk
         StYTuLwpLQV+fOA3C0Hr2bTtvBRso+BdJzuGnqGfOUBtuWiDwmatKlW87ycH18l5VDTE
         IapsaOte/zR6Bncsj+FrAkXISKefao5Vpm/c68Q55JdYWqhVvGEtFYVnBRm+LQzxaeZS
         nhsq7LD+1Xyim/5qyQ8hvqMYscJieCB4X8FjQnNYCQ7xs4fg5lPyBjCznIWOXDISfzm0
         xnrCapk/rmClsHG2Ka8qHt69ftdLLXsKrFTl0Cp1yNx4wZISuMRy45Ialp3OoPCnWKje
         Auvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765793233; x=1766398033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wSKpCvg/uYgrOa0A/iyr6y8xb+KW9R2SOkoEVIfpqEg=;
        b=KsSOjkgwngFvK9dTaRvzMBEEX+UuRlmhYo+UNw1srGevnMV5gE8+G7y1ixLVbvDPDx
         lc9la0tKCWpFCrXnl9EomW7ZQd6Z1+KGY0quqFOEa42mU84CI/ylvtlRuQ5ZGaQxRKr2
         9pTlnRhAXlKdGxnOrE9mfPIsofT75S08gBdGBpfoL2y5p7CMdHdy4Br4WCcr7C1f1RYi
         iZ3qtTWyxD38N6aWtnQreo0Bp7QaBqeC20fFVD99ovqoax53fq2nJcRwMGFlkidMmSrx
         KMUVOyA9p0EkZMap13Py1Adf+QPKmRTcScQJhRxXKUQIwavJG48hdWJrEEk8g6Vbjlja
         Z1og==
X-Forwarded-Encrypted: i=1; AJvYcCXZz1YaUY15Y8IEmnXgKXPL1z4bAerbnpWjpxRnqSD23gBy9CVcoBccsNPE9xyAmWD2U8iDL26cgIAB@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfmh5ICL5XnUIgEq2q2YXTaB417HQ0uBxRaWEZCbm6jb2MM3II
	kqpKtThsMTJRt3wyYoU8k+xb0CKDBYHGD6yIJ70Pu2zW/EMTdh7pg6hjSzdiwSgbKZj9V/3+dyG
	UrxjlJJhaZvkpiBKoKIXPwduS4q2LCHc=
X-Gm-Gg: AY/fxX4V98v4Pp11nNBUbGJEYBOSswC0KsDpiAVAH+ohWmWnVunrdGx8uQ8LVTmEFT0
	/UiL6CeJ9uisU6YffLfzFo26OTHR9HmfD/JWBPA4SMr8WOqGD8y+xHrCKqmHWS9BOOjyATiDxFz
	ycW9ilcDhlS8S+uug/FOZ3Na6Xyck1rKGubymVVTZa/K5OB4FSapYyV0d14RcwBquyBLfpR365l
	6e49LtfffWd7hEcp9Wwc6uuw4J3PYSa+tExQquWbhl+8EBXZlUXiUpYW4vyJ1waTKVwjGA=
X-Google-Smtp-Source: AGHT+IFl9ni5fXcOe/h7T5lh5KkuVW/hGDXieMDOuI0kK4uW/u/LkItXm6/7E1qJGDz94F3qrZbuXdp9I7gS057vhX0=
X-Received: by 2002:a05:7022:5f14:b0:11b:9386:a3c0 with SMTP id
 a92af1059eb24-11f34c2fa11mr4636821c88.43.1765793232798; Mon, 15 Dec 2025
 02:07:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251209072305.3955121-1-islituo@gmail.com> <54b9911b-3d6a-4d8b-8818-f78ba3ae2a01@nvidia.com>
In-Reply-To: <54b9911b-3d6a-4d8b-8818-f78ba3ae2a01@nvidia.com>
From: Tuo Li <islituo@gmail.com>
Date: Mon, 15 Dec 2025 18:07:02 +0800
X-Gm-Features: AQt7F2q6czk3JTNbLYt2iTE0IxcYmHTJUGqnSokq48PD6XEVlwrzfS5EhinihOM
Message-ID: <CADm8Tem9M4w_JgVbLU+raMVUgkMWD+JMoN_-piH3cQtrHCyH7g@mail.gmail.com>
Subject: Re: [PATCH] IB/mlx5: Fix a possible null-pointer dereference in set_roce_addr()
To: Michael Gur <michaelgur@nvidia.com>
Cc: leon@kernel.org, jgg@ziepe.ca, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Mon, Dec 15, 2025 at 5:42=E2=80=AFPM Michael Gur <michaelgur@nvidia.com>=
 wrote:
>
>
> On 12/9/2025 9:23 AM, Tuo Li wrote:
> > The pointer gid is checked at the beginning of set_roce_addr(). However=
,
> > if it is NULL, the function continues execution and may dereference gid
> > when calling mlx5_core_roce_gid_set():
> >
> >    return mlx5_core_roce_gid_set(..., gid->raw, ...)
> >
> > This can lead to a null-pointer dereference. To prevent this, add an el=
se
> > branch that return -EINVAL when gid is NULL, and remove the redundant g=
id
> > check in the IB_GID_TYPE_ROCE_UDP_ENCAP case.
>
> Can you reproduce this?
>
> Theoretically, gid->raw is translated to NULL+0 which is undefined
> behavior and static analyzers can complain, but it seems compilers just
> translate to NULL which leads us to the expected behavior.
>
> > Signed-off-by: Tuo Li <islituo@gmail.com>
> > ---
> >   drivers/infiniband/hw/mlx5/main.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/=
mlx5/main.c
> > index 40284bbb45d6..d68a58d249d4 100644
> > --- a/drivers/infiniband/hw/mlx5/main.c
> > +++ b/drivers/infiniband/hw/mlx5/main.c
> > @@ -645,6 +645,8 @@ int set_roce_addr(struct mlx5_ib_dev *dev, u32 port=
_num,
> >               ret =3D rdma_read_gid_l2_fields(attr, &vlan_id, &mac[0]);
> >               if (ret)
> >                       return ret;
> > +     } else {
> > +             return -EINVAL;
> >       }
>
> This breaks the gid deletion, we should still call mlx5_core with NULL
> gid for it to update the table.
>
> >
> >       switch (gid_type) {
> > @@ -653,7 +655,7 @@ int set_roce_addr(struct mlx5_ib_dev *dev, u32 port=
_num,
> >               break;
> >       case IB_GID_TYPE_ROCE_UDP_ENCAP:
> >               roce_version =3D MLX5_ROCE_VERSION_2;
> > -             if (gid && ipv6_addr_v4mapped((void *)gid))
> > +             if (ipv6_addr_v4mapped((void *)gid))
> >                       roce_l3_type =3D MLX5_ROCE_L3_TYPE_IPV4;
> >               else
> >                       roce_l3_type =3D MLX5_ROCE_L3_TYPE_IPV6;

I have rechecked the code. In this case, accessing the first member of a
NULL pointer is safe. Moreover, mlx5_core_roce_gid_set() also checks
gid->raw before using it, so an early return is not necessary.

Thanks for your feedback, and sorry for any inconvenience caused.

