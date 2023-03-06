Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E8C6AB62F
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Mar 2023 07:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjCFGCq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Mar 2023 01:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjCFGCp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Mar 2023 01:02:45 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D491C593
        for <linux-rdma@vger.kernel.org>; Sun,  5 Mar 2023 22:02:42 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id i34so33790992eda.7
        for <linux-rdma@vger.kernel.org>; Sun, 05 Mar 2023 22:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678082560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyPfBNx8LPIGmYs/NMBy7TrzoJMIbpZ0pZ6dTRCeHlM=;
        b=p7MsSXrW4J/3GMlaGGadxi/wSLJWQkO9PXKfT9+GwsWUzEQkfLes/86CIjyCsnP76n
         pr/UCFN5gB18NUFEUEK7MyPrfz1eEdGYmkbWHhEVEe2/F9GZO+Y8pOI9ls9Wc+o2qeDb
         mkBXPTZufVZiWUeAH6X3ICxKL87TsxuVDiFoxoDCH7F1sSz5G8tUqsJd1fClkb1MpW0v
         u/yzJEBd2ulfzndEf3Pjv63eGVdXxhtnpqs9kmBBqoSShcEGs/Vn7Hu4qv8qbzD6s0A6
         axsZWw7CNds1ij4T/aU11VLZLPR76fwiH9WHLR7gcS4/cTwmKsMQ7buYRbniZAdjWQO5
         PtjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678082560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UyPfBNx8LPIGmYs/NMBy7TrzoJMIbpZ0pZ6dTRCeHlM=;
        b=hUWiESvhH7crhx7I2ozUDsxa+fbg0P8sgOOsJKtb41j5P8ZEW5zJGgH5LNxH9oLxNs
         HJn7Xc6ApIhgzfskBUWB33mPMxjP5RtEzxfIgPkSiPfAmQiIHUubMxpmeVQeJ7eSmWag
         Ls+6x2bCpEY3TyPCmHal+mmOhNYESvbT9W7264NeT2jNdOk3bl0QCHYr/N9M1T2muBXV
         YoCWYC5VlnsKYS3Dexp6uYg3ig1AFRWHhbDhrFoRb7Iv1VD92vB0SLUSdbI44cj0o9sG
         vA6BawXovQpZMyibRAL4ASLk31NBs0x79bngrcRfVi0U6Nv7uN6YhqRAgxL6WWENfGwv
         SzPA==
X-Gm-Message-State: AO0yUKUyMVIoMCCDUTDlCXxKTvgOnQ7r4B2buMevq0R5PekuHOe60XyV
        qiXfMDkLl+MJvLGcpHaHc1GTsk7qRj6rXPAiGO4=
X-Google-Smtp-Source: AK7set9hKFKKBvilHH/VAPxI+f3fRvsfi0EjQ/7GhFGM2K9VpNdvvkPuo0oK0rsokTyF1mEDXMRBxPWoFA7vKt+mACE=
X-Received: by 2002:a17:906:a01a:b0:8f5:2e0e:6dc5 with SMTP id
 p26-20020a170906a01a00b008f52e0e6dc5mr4710622ejy.0.1678082560626; Sun, 05 Mar
 2023 22:02:40 -0800 (PST)
MIME-Version: 1.0
References: <20230301031038.10851-1-rpearsonhpe@gmail.com> <20230301031038.10851-2-rpearsonhpe@gmail.com>
In-Reply-To: <20230301031038.10851-2-rpearsonhpe@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 6 Mar 2023 14:02:28 +0800
Message-ID: <CAD=hENexoV2gMvOKqmOH+jB=2b67eLkpCUH4aqgSHi+dDDGNzg@mail.gmail.com>
Subject: Re: [PATCH for-next v3 1/4] RDMA/rxe: Replace exists by rxe in rxe.c
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, jhack@hpe.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 1, 2023 at 11:10=E2=80=AFAM Bob Pearson <rpearsonhpe@gmail.com>=
 wrote:
>
> 'exists' looks like a boolean. This patch replaces it by the
> normal name used for the rxe device, 'rxe', which should be a
> little less confusing. The second rxe_dbg() message is
> incorrect since rxe is known to be NULL and this will cause a
> seg fault if this message were ever sent. Replace it by pr_debug
> for the moment.
>
> Fixes: c6aba5ea0055 ("RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe.c")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>

Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>

Zhu Yanjun

> ---
>  drivers/infiniband/sw/rxe/rxe.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/=
rxe.c
> index 136c2efe3466..a3f05fdd9fac 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -175,7 +175,7 @@ int rxe_add(struct rxe_dev *rxe, unsigned int mtu, co=
nst char *ibdev_name)
>
>  static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
>  {
> -       struct rxe_dev *exists;
> +       struct rxe_dev *rxe;
>         int err =3D 0;
>
>         if (is_vlan_dev(ndev)) {
> @@ -184,17 +184,17 @@ static int rxe_newlink(const char *ibdev_name, stru=
ct net_device *ndev)
>                 goto err;
>         }
>
> -       exists =3D rxe_get_dev_from_net(ndev);
> -       if (exists) {
> -               ib_device_put(&exists->ib_dev);
> -               rxe_dbg(exists, "already configured on %s\n", ndev->name)=
;
> +       rxe =3D rxe_get_dev_from_net(ndev);
> +       if (rxe) {
> +               ib_device_put(&rxe->ib_dev);
> +               rxe_dbg(rxe, "already configured on %s\n", ndev->name);
>                 err =3D -EEXIST;
>                 goto err;
>         }
>
>         err =3D rxe_net_add(ibdev_name, ndev);
>         if (err) {
> -               rxe_dbg(exists, "failed to add %s\n", ndev->name);
> +               pr_debug("failed to add %s\n", ndev->name);
>                 goto err;
>         }
>  err:
> --
> 2.37.2
>
