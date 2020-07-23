Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7DC022B2D3
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jul 2020 17:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgGWPnK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Jul 2020 11:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgGWPnK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Jul 2020 11:43:10 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129D9C0619DC
        for <linux-rdma@vger.kernel.org>; Thu, 23 Jul 2020 08:43:10 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id y22so5362461oie.8
        for <linux-rdma@vger.kernel.org>; Thu, 23 Jul 2020 08:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uA0NQ6InLul4YoY9vYTzqFsW0bXKKj9fR6iGQjupKqM=;
        b=hkLgkD00lL9N/sjxCuMTWhUdyvXjCRUqmzBs3vLfH1U/Belb024xIP90ahp+6mdUez
         xVp1AJTKfKqttL2h4+i9LjsxPpZX3jflKRwnMGSS7XJ4ffcv+5ub0WRLQAtRwcgWXBhz
         9nwfVa96yvNIkrkBWdAYyOMOELFEsuDTEkN4iPrrtcoDr1iGLeasDVGOcONY2q9FahP5
         LEemhWiq3hoO0e8A+UWJs4sWKYP7uTPaZ6tigcnGHI07oM51/W+nXbW1lvHdmot8hx5J
         8rYtSK+BxtQmhHeIF/BmfnEDgN4mC5M6y2+9iNqZgRrCkdR2DiRNWeqnoyg6ofl2zMhb
         iHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uA0NQ6InLul4YoY9vYTzqFsW0bXKKj9fR6iGQjupKqM=;
        b=lci7RRmIve4idIr4y/w81xRC1NVUTPRG4JZIzWi+2ashGI9UIj0J5nhZRUXTN08sWO
         woCe47c/i0TuR0agZHj8DKoyLRXCqa/MKu1cy8j1RVzXzZgJDl7xMCifkvZJJ3UK49ZO
         SYySSt/Sealb4ABscpKpHZfYYIwI3bnajUFMMfejzgh5SjeqU8R/pyusdBdEtFeAsYAx
         j8YVbo0c9he3d54lSetz4VTQH2XbLf6RIv4W09JMwPsdtWeLjg0ZXweTLa8h6po/xZGG
         lNY+ej674tbD9WZAWTTHMnKW4oMLwRrzWW9/t/dlNXpp/nhETBjtahplecBJtc7iK//U
         aMjg==
X-Gm-Message-State: AOAM533gxoRlD6X4iGcehegINDHayC2wvk8QC46g6rFQNWU3D6e7/0V9
        Cc6VBQ/GAm0Q7WVFo+9C+JOjB+R/M4KFduUqP5c=
X-Google-Smtp-Source: ABdhPJw4Iwa91XMBiSPQ5eDxPVeRZFEl7fmRUlbSRoBYcrgX6RDomzEvWGunxSUSzZmPIp4PZEBoT9WQx9s2U4eD6Wc=
X-Received: by 2002:aca:bed5:: with SMTP id o204mr4051350oif.169.1595518987961;
 Thu, 23 Jul 2020 08:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <D1A472F9-6618-41A2-9CA8-B5231BD03D63@bytedance.com>
In-Reply-To: <D1A472F9-6618-41A2-9CA8-B5231BD03D63@bytedance.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Thu, 23 Jul 2020 23:42:56 +0800
Message-ID: <CAD=hENdG_0hdcRQk+sH6HyuOROM-U9_n2QahipgmOdESQDso3g@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: fix retry forever when rnr_retry >= 7
To:     Fan Yang <yangfan.fan@bytedance.com>
Cc:     Zhu Yanjun <yanjunz@mellanox.com>, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 23, 2020 at 9:28 PM Fan Yang <yangfan.fan@bytedance.com> wrote:
>
> Currently when an error occurs and the completion state becomes
> COMPST_RNR_RETRY, qp->comp.rnr_retry is only decreased when
> qp->comp.rnr_retry !=3D 7.
>
> If the user happens to config the rnr retry count to be >=3D 7, the
> driver will retry forever, instead of exposing IB_WC_RNR_RETRY_EXC_ERR.

Please read the following from IB specification

"

The RNR NAK retry counter is decremented each time the responder returns

an RNR NAK. If the requester=E2=80=99s RNR NAK retry counter is zero, and
an RNR NAK packet is received, an RNR NAK retry error occurs. Each
time an RNR NAK is cleared (i.e., an acknowledge message other than
an RNR NAK is returned), the retry counter is reloaded. An exception to
the following is if the RNR NAK retry counter is set to 7. This value indic=
ates

infinite retry and the counter is not decremented.

"


>
> ---
>  drivers/infiniband/sw/rxe/rxe_comp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw=
/rxe/rxe_comp.c
> index 4bc88708b355..16c1870b6482 100644
> --- a/drivers/infiniband/sw/rxe/rxe_comp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
> @@ -745,8 +745,7 @@ int rxe_completer(void *arg)
>
>                 case COMPST_RNR_RETRY:
>                         if (qp->comp.rnr_retry > 0) {
> -                               if (qp->comp.rnr_retry !=3D 7)
> -                                       qp->comp.rnr_retry--;
> +                               qp->comp.rnr_retry--;
>
>                                 qp->req.need_retry =3D 1;
>                                 pr_debug("qp#%d set rnr nak timer\n",
> --
> 2.27.0
>
>
