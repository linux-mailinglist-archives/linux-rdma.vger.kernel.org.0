Return-Path: <linux-rdma+bounces-9403-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41104A87C86
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 11:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092D91894AD6
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 09:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0572267B77;
	Mon, 14 Apr 2025 09:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeFMNTrG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDAD257AC8;
	Mon, 14 Apr 2025 09:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744624553; cv=none; b=BytuB0d3W+g8KwQX5sHVVUN0P6i/E6Apqig2iQXIMxi8ckT0Zc7XhCtNlJvthFXY+xHvU5zMmfQeJgb/tXfdBd6HcR5OCtsSjgLwW4w0NlhJp5tcsZLx66ESjpevh3gxz4UswP6C21Eys/PstGoxYFdx4kxQl1c0lOK/BXu+5MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744624553; c=relaxed/simple;
	bh=BxQDXbrr6/3VNuxRublanubI90mINpkM8IVhaRSWG+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dq7OivDhN8IaX6B5tcnYCS1VrhzwLmcGM+DZdI7rMHhMv7Fayyju4vsRDRzyQpO1pdyscGaFLsqPVJQ5tQEuf2tyG0NBRq/LSZNT3hciIRnrWhU5AkxHzaYjUYvyU5BdRLX2HRBY/Gaxc/kRoRK/CcirVCkdUYJtiIw4rFBDmU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeFMNTrG; arc=none smtp.client-ip=209.85.208.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f195.google.com with SMTP id 38308e7fff4ca-30c416cdcc0so37225681fa.2;
        Mon, 14 Apr 2025 02:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744624550; x=1745229350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GyxVfRSD+vy0gY4dSBjLNFJ9RxQsx9R+owScmKqVvVo=;
        b=TeFMNTrGBHX/dfvlijyHeI+uulVTsWLYe2OsK7bMGPCybJdQlrumsgcF2SYg34gvjs
         N5Gg7cE7iU0B02Ogb26q0Y0dcgNb9vxXax5U2oSPN7RcjYNQff+ELvDZo3+GmZWgzavv
         h7BTv55ppyk/vtXllI/FWACLKAxf9lHVub+9v8RCmtsNWVWTwXKBVkYducmn0wxq6AjQ
         9zL2w4Vhs8Db9WiYtrzQ9wlFbtr2XS+Bk0WPMQlbHGtqmjsx+mxJLuXsx/b2VLz3NMoB
         OBp/Ek//TsNT8NWMfnxG6hr7l7sGvFE37Fsefs/Zleiv7bUTAb5iIgIx0VotzcvBpJrz
         dckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744624550; x=1745229350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GyxVfRSD+vy0gY4dSBjLNFJ9RxQsx9R+owScmKqVvVo=;
        b=FNgI58R0aEPBrZdb8e9pYJ2Tt1A0if1r/XYXjkdr2M7DiprSEDHYgZmDLJOO9gv83d
         cJc0ROTZZe28tR0PBSqfrpk0RAPfxy/4iNr0qmZoA5lz34b7jBxuAdctou5abjwQSeR9
         L8dZXNlWj4uCWozjyDmB7BQjoSI4mqkUCysyXQcRUtZyd0l08pnEVl9kHOF5HVCZXzFy
         WqgyUh8BqIGpq08LNxmPEsAcPtHCyEapq4pZvprxmjskWdJ5bgCTq34a7Gv/uP+rvVAd
         xroM/L2sK1sxEco8R+zv52yHEzn2llHRhClLDQ9T2kgJoiY3h2CPmPr/ui3YijMlQ6sB
         AK9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJAyxmbsCAWjPm/AzfUN5Jffyj+DEXSrvoHZrAMZ3VMt8SbDeVw05LGI/xbiVN6V3r5Qyo96nsTW+FQA==@vger.kernel.org, AJvYcCX4C+0jMTCmh087ESltoCrNmpLYdH+hh0B+n8fjAtSuESYpGRAgtxgcNmQp5QvITf62jvLoZ9cU@vger.kernel.org, AJvYcCXHB6D8GnWeCqQvdOwpcK6GQoQFtwOFXCU+prBLhn4Q4SsSS8Tu8IxCZTOQJxpkKLP2nD2Yepdpwj6LNxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGk5CTrnaJGw+clLBjU7xTxA2rBwjFYTGYBdAlLKXrGPz01Lh4
	AkSr5RYc7ablfHvlTUqjRhZbAPHXmf/MkEKjXZ3W7GuGo+dynD4E5g1wt5qp3HzFafrphoS0GTI
	ni0XVtphePhjrdBuF1aOAP2CEJftpPKUUiXN7yQ==
X-Gm-Gg: ASbGncslEy/1vcVHxx4ZRBdwW457IgXtuCDQWPsBwcLGuErZnDRviZglypHt5/t2EI3
	IEqKhxivwD+U+s3XnngVIm830JJPHrt1MTrQhV6Kv9Rd8EfCiPJ8r8g6uTlViPby2DpNLMird7Y
	tf0nxkIyEu5Jynqte22CRk
X-Google-Smtp-Source: AGHT+IFcLrIXePHb9OODaAWFiueffLRxnDGpGlApmshNTbsxY3gHU7X/CBaD4f10RNuc6L3qennzhlvjDKtmXNdscgs=
X-Received: by 2002:a05:651c:144a:b0:30d:626e:d004 with SMTP id
 38308e7fff4ca-31049a1addcmr38254561fa.20.1744624549583; Mon, 14 Apr 2025
 02:55:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411022916.44698-1-bsdhenrymartin@gmail.com>
 <20250411022916.44698-2-bsdhenrymartin@gmail.com> <Z/ip4y2qSYcn93U/@mev-dev.igk.intel.com>
In-Reply-To: <Z/ip4y2qSYcn93U/@mev-dev.igk.intel.com>
From: henry martin <bsdhenrymartin@gmail.com>
Date: Mon, 14 Apr 2025 17:55:38 +0800
X-Gm-Features: ATxdqUGPEffiamL1jfKYGLULBzhz4RN1uaLQvNQGrt5fccbUfnmPN_Ave18wxnA
Message-ID: <CAEnQdOpfJAaQN+D-Wxff13v+gMS5PR8J1TPWCGtKww41=Xt-UA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] net/mlx5: Fix null-ptr-deref in mlx5_create_{inner_,}ttc_table()
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, 
	netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, amirtz@nvidia.com, 
	ayal@nvidia.com, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> There is ttc =3D kvzalloc() before. I think you should call kvfree(ttc)
> before returning. It looks like the same leak is already when
> params->ns_type is unknown.

Thanks for the review and the helpful suggestions!

I've addressed the kvfree(ttc) memory leak issue and updated the logic
accordingly in both code paths. The updated patch has been sent out as v4.

Regards,
Henry


Michal Swiatkowski <michal.swiatkowski@linux.intel.com> =E4=BA=8E2025=E5=B9=
=B44=E6=9C=8811=E6=97=A5=E5=91=A8=E4=BA=94 13:34=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Apr 11, 2025 at 10:29:16AM +0800, Henry Martin wrote:
> > Add NULL check for mlx5_get_flow_namespace() returns in
> > mlx5_create_inner_ttc_table() and mlx5_create_ttc_table() to prevent
> > NULL pointer dereference.
> >
> > Fixes: 137f3d50ad2a ("net/mlx5: Support matching on l4_type for ttc_tab=
le")
> > Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> > ---
> > V2 -> V3: No functional changes, just gathering the patches in a series=
.
> > V1 -> V2: Add a empty line after the return statement.
> >
> >  drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c b/dri=
vers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
> > index eb3bd9c7f66e..18cc6960a5c1 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
> > @@ -655,6 +655,9 @@ struct mlx5_ttc_table *mlx5_create_inner_ttc_table(=
struct mlx5_core_dev *dev,
> >       }
> >
> >       ns =3D mlx5_get_flow_namespace(dev, params->ns_type);
> > +     if (!ns)
> > +             return ERR_PTR(-EOPNOTSUPP);
>
> There is ttc =3D kvzalloc() before. I think you should call kvfree(ttc)
> before returning. It looks like the same leak is already when
> params->ns_type is unknown.
>
> > +
> >       groups =3D use_l4_type ? &inner_ttc_groups[TTC_GROUPS_USE_L4_TYPE=
] :
> >                              &inner_ttc_groups[TTC_GROUPS_DEFAULT];
> >
> > @@ -728,6 +731,9 @@ struct mlx5_ttc_table *mlx5_create_ttc_table(struct=
 mlx5_core_dev *dev,
> >       }
> >
> >       ns =3D mlx5_get_flow_namespace(dev, params->ns_type);
> > +     if (!ns)
> > +             return ERR_PTR(-EOPNOTSUPP);
>
> The same here.
>
> > +
> >       groups =3D use_l4_type ? &ttc_groups[TTC_GROUPS_USE_L4_TYPE] :
> >                              &ttc_groups[TTC_GROUPS_DEFAULT];
> >
> > --
> > 2.34.1

