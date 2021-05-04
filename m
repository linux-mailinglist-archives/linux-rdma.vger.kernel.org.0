Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7199F372BCB
	for <lists+linux-rdma@lfdr.de>; Tue,  4 May 2021 16:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhEDOQt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 May 2021 10:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbhEDOQt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 May 2021 10:16:49 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37386C061574
        for <linux-rdma@vger.kernel.org>; Tue,  4 May 2021 07:15:54 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id j75so3149786oih.10
        for <linux-rdma@vger.kernel.org>; Tue, 04 May 2021 07:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b5pEtWDSZv9orIX6bJUqYYKj3MKnAmA6++YbLBoJ2sA=;
        b=syMW3Xr3wPSTkOWHq5MawmW/Dxi0o1NNiPlo8AluSfSHpUQzWmtaDX5XvOSmGbewvD
         wR3dSVXc3Ka+n2dVRsLo9BXV+rknXFdii1NVFznE3QpBbuQzcPFyoL2kCF/CtOeKUba6
         r1hwIe3Fr4RnJ81Zn2qNWAz2yi0NbcPLmoKTM8K4r6w2gCYwRBlC1D6Fev+PZc/uBwvz
         TfX2JlNLMOUjR2vy5OCb/E2BloGEOxSRVOmGCs6C4odQ9IKC0IAlOeiDbY9p0lqoRBJx
         16IuahL6QGBZ1pMqCvYOJEBpHgRrx1cmxz90N7yM0MiybCd+1aIeoCWbdk6JcTQDpnZb
         erww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b5pEtWDSZv9orIX6bJUqYYKj3MKnAmA6++YbLBoJ2sA=;
        b=Tbwprg+1tgu+wtK/ApU/jH2pp4rYkDK5CxF6+CwX8z/BLt60eEhfO4ubh8pv1nlJVP
         O9cFXv0OZYCgTNj3+2kmgCaRIJrtUEqwcRz4z/kCXRw2PDu7OCpaOBuH9FECUXQwzDPt
         Zptr4jcxESfq9hxRjhoh03GlZpnczgLHljfk6CgvghliGg82XVIpAFqepQ0pKIDeniEP
         fKewVnhv5kP04pgQPnjKwF/n7rI/H8d7kctiJJqcGTHVQ56NO1PCxo7TERuotxL7Dsl5
         wI2biMTg/NO2kkpqOnFD4wg3YZusNuG0NTu8LkGmzC8uwNvQM6TYm5cuRsR+vzTG4ROJ
         WHhA==
X-Gm-Message-State: AOAM531QsE+KimsIrjZscfwc4u9Z1NQunpn+l8VgkSVQV/6tjTQSBS7a
        eGF1RJFSWIBWYk1CkHerJlAmrE9TpVdcMugK+EA=
X-Google-Smtp-Source: ABdhPJz1h9rZOWcQbpitcB7xlBDgoF1lQLa4m0pdgR9o7QChVezDR/cP7jgtypFwknWAForNNleFD9ETecuiSwOpldM=
X-Received: by 2002:aca:1103:: with SMTP id 3mr2397331oir.169.1620137753698;
 Tue, 04 May 2021 07:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <1620128784-3283-1-git-send-email-haakon.bugge@oracle.com>
In-Reply-To: <1620128784-3283-1-git-send-email-haakon.bugge@oracle.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 4 May 2021 22:15:42 +0800
Message-ID: <CAD=hENfQX=oCsAsbvsp5SXLYUD6vxRszBZ8SpjkgYzrziPWz_g@mail.gmail.com>
Subject: Re: [PATCH for-next] IB/core: Only update PKEY and GID caches on
 respective events
To:     =?UTF-8?B?SMOla29uIEJ1Z2dl?= <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 4, 2021 at 7:50 PM H=C3=A5kon Bugge <haakon.bugge@oracle.com> w=
rote:
>
> Both the PKEY and GID tables in an HCA can hold in the order of
> hundreds entries. Reading them are expensive. Partly because the API
> for retrieving them only returns a single entry at a time. Further, on
> certain implementations, e.g., CX-3, the VFs are paravirtualized in
> this respect and have to rely on the PF driver to perform the
> read. This again demands VF to PF communication.
>
> IB Core's cache is refreshed on all events. Hence, filter the refresh
> of the PKEY and GID caches based on the event received being
> IB_EVENT_PKEY_CHANGE and IB_EVENT_GID_CHANGE respectively.
>

Missing Fixes?

Zhu Yanjun

> Signed-off-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
> ---
>  drivers/infiniband/core/cache.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/ca=
che.c
> index 5c9fac7..531ae6b 100644
> --- a/drivers/infiniband/core/cache.c
> +++ b/drivers/infiniband/core/cache.c
> @@ -1472,10 +1472,14 @@ static int config_non_roce_gid_cache(struct ib_de=
vice *device,
>  }
>
>  static int
> -ib_cache_update(struct ib_device *device, u8 port, bool enforce_security=
)
> +ib_cache_update(struct ib_device *device, u8 port, enum ib_event_type ev=
ent,
> +               bool reg_dev, bool enforce_security)
>  {
>         struct ib_port_attr       *tprops =3D NULL;
> -       struct ib_pkey_cache      *pkey_cache =3D NULL, *old_pkey_cache;
> +       struct ib_pkey_cache      *pkey_cache =3D NULL;
> +       struct ib_pkey_cache      *old_pkey_cache =3D NULL;
> +       bool                       update_pkey_cache =3D (reg_dev || even=
t =3D=3D IB_EVENT_PKEY_CHANGE);
> +       bool                       update_gid_cache =3D (reg_dev || event=
 =3D=3D IB_EVENT_GID_CHANGE);
>         int                        i;
>         int                        ret;
>
> @@ -1492,14 +1496,16 @@ static int config_non_roce_gid_cache(struct ib_de=
vice *device,
>                 goto err;
>         }
>
> -       if (!rdma_protocol_roce(device, port)) {
> +       if (!rdma_protocol_roce(device, port) && update_gid_cache) {
>                 ret =3D config_non_roce_gid_cache(device, port,
>                                                 tprops->gid_tbl_len);
>                 if (ret)
>                         goto err;
>         }
>
> -       if (tprops->pkey_tbl_len) {
> +       update_pkey_cache &=3D !!tprops->pkey_tbl_len;
> +
> +       if (update_pkey_cache) {
>                 pkey_cache =3D kmalloc(struct_size(pkey_cache, table,
>                                                  tprops->pkey_tbl_len),
>                                      GFP_KERNEL);
> @@ -1524,9 +1530,10 @@ static int config_non_roce_gid_cache(struct ib_dev=
ice *device,
>
>         write_lock_irq(&device->cache_lock);
>
> -       old_pkey_cache =3D device->port_data[port].cache.pkey;
> -
> -       device->port_data[port].cache.pkey =3D pkey_cache;
> +       if (update_pkey_cache) {
> +               old_pkey_cache =3D device->port_data[port].cache.pkey;
> +               device->port_data[port].cache.pkey =3D pkey_cache;
> +       }
>         device->port_data[port].cache.lmc =3D tprops->lmc;
>         device->port_data[port].cache.port_state =3D tprops->state;
>
> @@ -1558,7 +1565,7 @@ static void ib_cache_event_task(struct work_struct =
*_work)
>          * the cache.
>          */
>         ret =3D ib_cache_update(work->event.device, work->event.element.p=
ort_num,
> -                             work->enforce_security);
> +                             work->event.event, false, work->enforce_sec=
urity);
>
>         /* GID event is notified already for individual GID entries by
>          * dispatch_gid_change_event(). Hence, notifiy for rest of the
> @@ -1631,7 +1638,7 @@ int ib_cache_setup_one(struct ib_device *device)
>                 return err;
>
>         rdma_for_each_port (device, p) {
> -               err =3D ib_cache_update(device, p, true);
> +               err =3D ib_cache_update(device, p, 0, true, true);
>                 if (err)
>                         return err;
>         }
> --
> 1.8.3.1
>
