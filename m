Return-Path: <linux-rdma+bounces-14306-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5F3C413E3
	for <lists+linux-rdma@lfdr.de>; Fri, 07 Nov 2025 19:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE543ADF7C
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Nov 2025 18:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3604B338F39;
	Fri,  7 Nov 2025 18:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLUnu4ZV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819963271EC
	for <linux-rdma@vger.kernel.org>; Fri,  7 Nov 2025 18:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762539224; cv=none; b=t/NnX2j2mXsC1kQ1X8lovF/umFVREeetpM3dKh/7uCWXMO5/IdDTdnc9K0FRaf7QCskvlI28qCZfty9nLRDJnzttIOyY+l1v1AbVBvx70vJD3ZLP83rZN5T8O2k+AyVeb+kVHOsrVxNWBsGcxN754N06jEQaNEWa/y+L72o6DDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762539224; c=relaxed/simple;
	bh=9sh+7gKZnu+G9v/dh397O3r/GNLHc2HTT/eEqyQCuKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qYJoyniBmmd4fD8Nn3AUoCRBkcgocgIZ8DeOR7wtYmQqi+7kr74hmFhmDW2iFf+t4jRwM6Kr9o2jsIVXnu4lImOpbDAqyRClesFVHzZyfH0JIkxyrQaP+bwrWzsRSGIKw6EVB/1RSANUEm/BgxCl3IRz+j5TSYiBS0CwXKTBbGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLUnu4ZV; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b550eff972eso644882a12.3
        for <linux-rdma@vger.kernel.org>; Fri, 07 Nov 2025 10:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762539222; x=1763144022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycx0Q+pL77eWatZeqNGTS924eNL4q/k8Nowo0Bt2oYw=;
        b=mLUnu4ZVoeQfGOofF+XyUCndP+C61xEy1u2DWZuMHQtkW4VwMtSuU8EfjiqMgTVSlK
         BjL8TSDdvbxdWxXSNp0wDKSJUAIT/hQl8iX8k1qTDTiHOXZu0tXZTVdX0NjV/ijWplGL
         gD0vUqXKUSpGoy/Ncvg53NhZDcwH/ZNS+osuOMqUa+/5ltce7OZFINObgB6KgxrU2+ar
         16ka1JvFWWQsn0IBE6LP6CxjmdfUk+pn7cHC2QD0L9JjI6S9T1nvFYQHHZSq3xB5xC1m
         aObqs/kojCl3mFNSB1/G612JCNkyvLb7OovNDrBD9gLVrjn3fQTRLgtCmTUbrlqDRUpo
         E3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762539222; x=1763144022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ycx0Q+pL77eWatZeqNGTS924eNL4q/k8Nowo0Bt2oYw=;
        b=h+sT+OSmjHvdbNb7SzUEjg1FY5Iw5Fh0DKQZU7Cw88xsxFhOdvTJFWjl09Cw97kvkN
         q7TFY1n5OqaN4K28oDZPzdwU+k9nXR+Y7DI25hzh7TdDcGmwhcGkXIBzDaJkl2Au+c0J
         EovQLBI3grcLkqgIj/NljyKCaSkHlns3q2vqJrACQoO4hMuwkodNGK27cz6Ve1tWub6h
         qBL4I960DsUHNv1eWMONEdjYueMYW87MvMty801CXZyuD+V3sUyxnDr7kp/gQ/cNBxG3
         X3LXRJb/lj8m5SRgwc3QqMK3PKt2Tse+iSCid4EUYsVHUminV8ecE7HeEkqsfs+LIkxD
         lafQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVSLOmNd0mXQwyDucRrvZIZ4qXVfRQGAnMgvoLosHUf3DIIgG/SIHHkx9T+/hSCBm+qgvP53JtieGm@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn1Cdd6KQJstLCGAVNnj+pgvzfTNZPLrgoGy+Bkz7SmpvG753d
	xJsVF8qIkfv2xR2WBqlXh/8G6Ubw8lJPCBTViNizVJTj5AYTexwLhNQhd0wikYoLXXNbgoKgOtp
	RTHqsT3fFkfNW9gkw5mXGb1zjAMYyLyw=
X-Gm-Gg: ASbGncvgzf+DMC//HXb1mYAyBNGI2d3/fFwP6VE3fO6t6serA22zNJEScY5zoFM1J/e
	e837QlFlm91y0+84e7AOkA7yRsX3xqCUYedNBU24s0gRy8CjDOEcBKFOmKHSn8SSHrD9JI1I1VA
	fwgipaVhM7TEuTiW4TrcKN6y/juXxWpWLZ4spfAZxLv4+LfiHhzkiLQMQNICQAU1+4qLnPuE8YO
	HMJ7jd3ACeDXRRh1eMGs/KBd0EijAnFuIntXWt/XMry1Ft64UBQgdYH3JQL
X-Google-Smtp-Source: AGHT+IFFUFeKNH7UjQgWxAMlS+k/djxBAsHPA9H+ubZBXi3ipyMUElpaci6boohgp6n9bbHug0ab1/fv2/9Hl1zSYE0=
X-Received: by 2002:a17:902:d485:b0:295:7b8c:6622 with SMTP id
 d9443c01a7336-297e5412e9emr643855ad.11.1762539221759; Fri, 07 Nov 2025
 10:13:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107041002.2091584-1-kriish.sharma2006@gmail.com> <20251107153733.GA1859178@ziepe.ca>
In-Reply-To: <20251107153733.GA1859178@ziepe.ca>
From: Kriish Sharma <kriish.sharma2006@gmail.com>
Date: Fri, 7 Nov 2025 23:43:30 +0530
X-Gm-Features: AWmQ_bkYmNN1Ow00_1J_Au4KiZUVKCYmWRJkOuHhbjGjJ9ysQoELaf0ZI9PBhdY
Message-ID: <CAL4kbRMM=dt_PUUjJKwE5QJVLTJONGBSntg_b0vDbbgxpBoiDg@mail.gmail.com>
Subject: Re: [PATCH] RDMA/core: Fix uninitialized gid in ib_nl_process_good_ip_rsep()
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>, Vlad Dumitrescu <vdumitrescu@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Edward Srouji <edwards@nvidia.com>, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jason,

Thanks for the insight. I=E2=80=99ll dig deeper into the handling inside
ib_nl_is_good_ip_resp() and follow up with an updated analysis or
patch.

Regards,
Kriish

On Fri, Nov 7, 2025 at 9:07=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Fri, Nov 07, 2025 at 04:10:02AM +0000, Kriish Sharma wrote:
> > KMSAN reported a use of uninitialized memory in hex_byte_pack()
> > via ip6_string() when printing %pI6 from ib_nl_handle_ip_res_resp().
> > If the LS_NLA_TYPE_DGID attribute is missing, 'gid' remains
> > uninitialized before being used in pr_info(), leading to a
> > KMSAN uninit-value report.
> >
> > Reported-by: syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D938fcd548c303fe33c1a
> > Fixes: ae43f8286730 ("IB/core: Add IP to GID netlink offload")
> > Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
> > ---
> >  drivers/infiniband/core/addr.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/a=
ddr.c
> > index 61596cda2b65..4c602fcae12f 100644
> > --- a/drivers/infiniband/core/addr.c
> > +++ b/drivers/infiniband/core/addr.c
> > @@ -99,7 +99,7 @@ static inline bool ib_nl_is_good_ip_resp(const struct=
 nlmsghdr *nlh)
> >  static void ib_nl_process_good_ip_rsep(const struct nlmsghdr *nlh)
> >  {
> >       const struct nlattr *head, *curr;
> > -     union ib_gid gid;
> > +     union ib_gid gid =3D {};
> >       struct addr_req *req;
> >       int len, rem;
> >       int found =3D 0;
>
> This doesn't seem right.
>
> We have this as the only caller:
>
>         if (ib_nl_is_good_ip_resp(nlh))
>                 ib_nl_process_good_ip_rsep(nlh);
>
> And ib_nl_is_good_ip_resp() does:
>
>         ret =3D nla_parse_deprecated(tb, LS_NLA_TYPE_MAX - 1, nlmsg_data(=
nlh),
>                                    nlmsg_len(nlh), ib_nl_addr_policy,
>                                    NULL);
>
> static const struct nla_policy ib_nl_addr_policy[LS_NLA_TYPE_MAX] =3D {
>         [LS_NLA_TYPE_DGID] =3D {.type =3D NLA_BINARY,
>                 .len =3D sizeof(struct rdma_nla_ls_gid),
>                 .validation_type =3D NLA_VALIDATE_MIN,
>                 .min =3D sizeof(struct rdma_nla_ls_gid)},
> };
>
> So I expect the nla_parse_deprecated() to fail if this:
>
>         nla_for_each_attr(curr, head, len, rem) {
>                 if (curr->nla_type =3D=3D LS_NLA_TYPE_DGID)
>                         memcpy(&gid, nla_data(curr), nla_len(curr));
>         }
>
> Doesn't find a DGID.
>
> So how can gid be uninitialized?
>
> The fix to whatever this is should be in ib_nl_is_good_ip_resp().
>
> Jason

