Return-Path: <linux-rdma+bounces-13437-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB3CB7F8E9
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 15:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8E4E328336
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 09:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA212641CA;
	Wed, 17 Sep 2025 09:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="G+nDvf96"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vs1-f100.google.com (mail-vs1-f100.google.com [209.85.217.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807EB31BC8E
	for <linux-rdma@vger.kernel.org>; Wed, 17 Sep 2025 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758100675; cv=none; b=Dq/TNhJdoUyar1lF6Q4Z7mFaYseZ6MrigjGGDcSFQHbfSpkKFzYZmtAXeVGfULLMuhQEE/SIcuSuNtGGjQaYreP+F5y9hNze+IfHldsyi2rGU/HY3pOCA/zbVEx5qir3wfp8xFOFAHH8NBoHmZlfeZZp7wigHTGpXSXjyGWwJHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758100675; c=relaxed/simple;
	bh=qm3bg1cLQIgvDbkKFLLfraSKQYjv0Ui9EAjdf1WU5nA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dt75jtqibkUlValDok/kirKNE/XoFbzkWyFinb/EiCCfnsGpUZdeW1FdiYI5OLN4F/hC5Sx6SsDK8epw51cAJD0GqclQXzc8mhP1uZABJ1akpoWSwoYXR1G80JNcFhhzJh+GJSw2WFoy6IEFOzL0bg8zsBl9WGxba/zoeBJKutM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=G+nDvf96; arc=none smtp.client-ip=209.85.217.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f100.google.com with SMTP id ada2fe7eead31-557a2ba1e65so4591892137.2
        for <linux-rdma@vger.kernel.org>; Wed, 17 Sep 2025 02:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758100672; x=1758705472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2QZjl7xUdiHrixmyewVn7wWqGdvkno1wrDDckkMZ74U=;
        b=flui6c/CbbRpR2QyT+hqAxPc+NIoauxXKcqeJvkcKd4qtIu7n54VeIhlMubWH2V2yn
         6O0naTju7K00f9pAk4A98J0ZYXGYZB7PAknS7wpdbIw9KB1QOw/dUIf5Q/Bk3FOTmzKU
         pGLgy+CEwkFIWv01ZPlzBYHxvbi+XhZuNZriP8gJvSdfhM/sYSMSR34YsPpModHAw3Op
         RzbbstLcqTLRRwz7GpY5sHfDRoLmCW6BQtCS4sd3fvkmwYOcMPht11WaJui/coxLbM/8
         7l9uBMgs5nsU9RDEoFA40qovRSWxRUKxZXEL8jfYgsPN3003CWbt7WoTW7cX0GziTmCV
         o+dA==
X-Forwarded-Encrypted: i=1; AJvYcCX8vhBLOFK8MN+/uQMVPxIhZ8BbV5t7gUWzjxSgcle5LuAxgWAdnbfyG4sYT6eQ0Q+7caOjSfd50HyS@vger.kernel.org
X-Gm-Message-State: AOJu0YzluUvitj+5C9+TqT9c7rd66bLzb7iAgbDFNFbS0gwt87okH2Dl
	8UbS4ymhWp3Iwxzi5wMTIObASPVoK646cm0W/nvK4j3pQn42LxWuw8qyup2AvIBNvScdDEeK5R1
	HJNF/mbXxc9/CG0EuhT7z54q2QJLzHYhCzi720VaZRUePE95ahNHrPou4tLlcbFlo8R4hCc5HhY
	0zGC37CEOjUMq6Xg1e9X3IL1sHjxirH9ZbxR+qYmdxGX0ypX5OJ8uUn2YWOhuFGf2QNZhX59Wm2
	yGqozTK9+u9+sg=
X-Gm-Gg: ASbGncsDfXFm1lexSo6d9EBpIqgYHwJDzveEG+2vy00A+EghTo5EwfJqr8jj9M8I1LL
	7DZA4wqZfjimY8uk7k6js4gPNK50qtZQejfm2MKDfy2RUQy1nHkbUEUSHWyNtdjblIXeNcZOCZy
	lNTyPi291SqxS/1h9zisEpsY9pjkLznbzISRWcopf9DR967hbN/lsQwI03rTrBticPck9kHxEAh
	IAl/vdVTPnEiXnFQDnrzOr6/eQGOm+MYEvRPePz8p6VxKz130HSi+GIb8WZ8nQrduYFomy33jVE
	fcIMa1BSQKGHvydzv8+ucepI9QrThgugy5iJ8iwReNj0BAYg0vUrFWVdQjOwKhKGuqG1Eq8X2S3
	eYtbP6IxQxEHDzkUrVx/KletVh2PEZ+sXa6gtZLJtCQoujyANy5UDMxQ+a3hblUP3MAF9zJ3SOy
	Mo
X-Google-Smtp-Source: AGHT+IG1lUWGKik+e7iT0cKc0hVtVmUheFpp6oMKnJrRAHgmgiqozolHQz7QjdiS6EJq4I1GbWiD48RhdTY/
X-Received: by 2002:a05:6102:6b03:b0:524:b9b7:af01 with SMTP id ada2fe7eead31-56d5358087dmr444016137.10.1758100672312;
        Wed, 17 Sep 2025 02:17:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-5609df31506sm654640137.0.2025.09.17.02.17.51
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Sep 2025 02:17:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3234811cab3so6081374a91.3
        for <linux-rdma@vger.kernel.org>; Wed, 17 Sep 2025 02:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758100671; x=1758705471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QZjl7xUdiHrixmyewVn7wWqGdvkno1wrDDckkMZ74U=;
        b=G+nDvf96v9YZO2tY9XgN74lDbLnrKGhttH1Z2AIn12uCl4BH1UOr34qpJi+rX+o/yP
         k9CZrn5xtsMxvAihchVrLlKP/fpjiYL76Xz9CkuPPrWFwkkcJDDgoY3vfPXCyT/VmAZs
         mg1hDo5+36xRnYcF4cxT+3sBG/wI9g3htUnD0=
X-Forwarded-Encrypted: i=1; AJvYcCXBotutWa/lfy3ojIxqra0qothD85Ad65iTl/hVteODAPrfPca2hBXF2lk+RpGYuFHQgVkZdPgCyJxV@vger.kernel.org
X-Received: by 2002:a17:90b:3b43:b0:32e:2798:9064 with SMTP id 98e67ed59e1d1-32ee3f53712mr1779590a91.35.1758100670782;
        Wed, 17 Sep 2025 02:17:50 -0700 (PDT)
X-Received: by 2002:a17:90b:3b43:b0:32e:2798:9064 with SMTP id
 98e67ed59e1d1-32ee3f53712mr1779551a91.35.1758100670350; Wed, 17 Sep 2025
 02:17:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829123042.44459-1-siva.kallam@broadcom.com>
 <20250829123042.44459-3-siva.kallam@broadcom.com> <20250916123412.GZ224143@horms.kernel.org>
In-Reply-To: <20250916123412.GZ224143@horms.kernel.org>
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
Date: Wed, 17 Sep 2025 14:47:38 +0530
X-Gm-Features: AS18NWC1FAX_3F4P8tDVwYa487VwQeeRgPm_3QNeMr2aLN-dKga9hLjkT3q0MYs
Message-ID: <CAMet4B5jDjzbi15f7jNvs31hGgX-pidtC_uvd7+dMjgay4=Law@mail.gmail.com>
Subject: Re: [PATCH 2/8] RDMA/bng_re: Add Auxiliary interface
To: Simon Horman <horms@kernel.org>
Cc: leonro@nvidia.com, jgg@nvidia.com, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, vikas.gupta@broadcom.com, selvin.xavier@broadcom.com, 
	anand.subramanian@broadcom.com, Usman Ansari <usman.ansari@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Tue, Sep 16, 2025 at 6:04=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Aug 29, 2025 at 12:30:36PM +0000, Siva Reddy Kallam wrote:
> > Add basic Auxiliary interface to the driver which supports
> > the BCM5770X NIC family.
> >
> > Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
> > Reviewed-by: Usman Ansari <usman.ansari@broadcom.com>
>
> ...
>
> > diff --git a/drivers/infiniband/hw/bng_re/bng_dev.c b/drivers/infiniban=
d/hw/bng_re/bng_dev.c
>
> ...
>
> > +static int bng_re_add_device(struct auxiliary_device *adev)
> > +{
> > +     struct bnge_auxr_priv *auxr_priv =3D
> > +             container_of(adev, struct bnge_auxr_priv, aux_dev);
> > +     struct bng_re_en_dev_info *dev_info;
> > +     struct bng_re_dev *rdev;
> > +     int rc;
> > +
> > +     dev_info =3D auxiliary_get_drvdata(adev);
> > +
> > +     rdev =3D bng_re_dev_add(adev, auxr_priv->auxr_dev);
> > +     if (!rdev || !rdev_to_dev(rdev)) {
>
> Hi Siva,
>
> Sorry if somehow this is a duplicate, it got stuck in my outbox somehow.
>
> GCC 15.1.0 says:
>
>   .../bng_dev.c: In function 'bng_re_add_device':
>   .../bng_dev.c:54:22: warning: the comparison will always evaluate as 't=
rue' for the address of 'dev' will never be NULL [-Waddress]
>      54 |         if (!rdev || !rdev_to_dev(rdev)) {
>         |                      ^
>   In file included from drivers/infiniband/hw/bng_re/bng_dev.c:8:
>   ./include/rdma/ib_verbs.h:2812:41: note: 'dev' declared here
>    2812 |                 struct device           dev;
>         |
>
> > +             rc =3D -ENOMEM;
> > +             goto exit;
> > +     }
> > +
> > +     dev_info->rdev =3D rdev;
> > +
> > +     return 0;
> > +exit:
> > +     return rc;
> > +}
Hi Simon,
No problem. rdev_to_dev check is not needed. We will fix it in the
next version of the patchset.
Thanks
>
> ...

