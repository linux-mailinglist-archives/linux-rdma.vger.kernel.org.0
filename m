Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 900B0151D7F
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2020 16:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbgBDPmT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Feb 2020 10:42:19 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:39631 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgBDPmT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Feb 2020 10:42:19 -0500
Received: by mail-il1-f196.google.com with SMTP id f70so16256225ill.6
        for <linux-rdma@vger.kernel.org>; Tue, 04 Feb 2020 07:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nyryLWCuTr3Xzh5zyohvD8Q3PeuHAmnOO2P7mCDRGD8=;
        b=K0V9eKjmOMyDPT0Lzu6YnrtvJh0LQ5z3DiQhihKtmnIk5P5pKnLRQTFjjZp9A6JZkw
         6DruxadtKQf3MqNUDzpdX9eb9oCKLjUuMPu16VcyNG+wNHY6kaOs+DeDIMsJtDhX0ynw
         kHMctiltx0/AbzqQzOEcPOpsXEUwKvhb3qjUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nyryLWCuTr3Xzh5zyohvD8Q3PeuHAmnOO2P7mCDRGD8=;
        b=uTxAA+L0US0PkWE084zcarVl1NZokcs9fthFflQpJZhoYUqLjA20tyNZzYEZwsNaXy
         IrniM543lEuhXGgBTCwXoiP+41wwCzVQCcXIb3BmeNnnmVw7uDWyYL39KpcACsGo94jr
         RMf8C0NduvSDZNUmJCBoEzeV7R2K7SEzqxp3gHxsgjai+zYb3QB0izCSczkXvlagClKI
         G09SUaYE9wVPr0GK75Vei/3wqIejjkaZapV1vt3GL0yy8bZXKij3aPqSkzsJwWXi05BV
         IncPYGUpDZyRWCZej67heO9KXFu+S2IS5ESIoogOAd1qSVX/4t7p2OuvZkTXPQqOqDc6
         x2tw==
X-Gm-Message-State: APjAAAVYOLKU4ye90P50512CCVVvrtVJyBRw+smR5vKwvi3OKUxOSQWt
        QRILHHcgj9iNUVn6FZjwFqcR8zX3IkWw6XIWaxMEfOGj
X-Google-Smtp-Source: APXvYqwJLJiX3MahQ9sLriVmvJbaAVvvbC6uvgl+9m5PtmtlL1A8tHSz3i2ujJCBu+vrbDafX+YBQjG0mgx0dNxqOcM=
X-Received: by 2002:a92:9ac5:: with SMTP id c66mr29450831ill.232.1580830937654;
 Tue, 04 Feb 2020 07:42:17 -0800 (PST)
MIME-Version: 1.0
References: <1580809644-5979-1-git-send-email-devesh.sharma@broadcom.com>
In-Reply-To: <1580809644-5979-1-git-send-email-devesh.sharma@broadcom.com>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Tue, 4 Feb 2020 21:11:40 +0530
Message-ID: <CANjDDBis_z-pFe4ftiQBp+YiKd1yzQfmvUTefGvu+_qx=ZXY2A@mail.gmail.com>
Subject: Re: [PATCH v6] libibverbs: display gid type in ibv_devinfo
To:     linux-rdma <linux-rdma@vger.kernel.org>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 4, 2020 at 3:17 PM Devesh Sharma <devesh.sharma@broadcom.com> wrote:
>
> It becomes difficult to make out from the output of ibv_devinfo
> if a particular gid index is RoCE v2 or not.
>
> Adding a string to the output of ibv_devinfo -v to display the
> gid type at the end of gid.
>
> The output would look something like below:
> $ ibv_devinfo -v -d bnxt_re2
> hca_id: bnxt_re2
>  transport:             InfiniBand (0)
>  fw_ver:                216.0.220.0
>  node_guid:             b226:28ff:fed3:b0f0
>  sys_image_guid:        b226:28ff:fed3:b0f0
>   .
>   .
>   .
>   .
>         phys_state:     LINK_UP (5)
>         GID[  0]:       fe80:0000:0000:0000:b226:28ff:fed3:b0f0, IB/RoCE v1
>         GID[  1]:       fe80:0000:0000:0000:b226:28ff:fed3:b0f0, RoCE v2
>         GID[  1]:       fe80::b226:28ff:fed3:b0f0
>         GID[  2]:       0000:0000:0000:0000:0000:ffff:c0aa:0165, IB/RoCE v1
>         GID[  3]:       0000:0000:0000:0000:0000:ffff:c0aa:0165, RoCE v2
>         GID[  3]:       ::ffff:192.170.1.101
> $
> $
> $
>
> Reviewed-by: Jason Gunthrope <jgg@ziepe.ca>
> Reviewed-by: Leon Romanovsky <leon@kernel.org>
> Reviewed-by: Gal Pressman <galpress@amazon.com>
> Reviewed-by: Parav Pandit <parav@mellanox.com>
> Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
> ---
>  libibverbs/examples/devinfo.c | 60 ++++++++++++++++++++++++++++++++++---------
>  1 file changed, 48 insertions(+), 12 deletions(-)
>
> diff --git a/libibverbs/examples/devinfo.c b/libibverbs/examples/devinfo.c
> index bf53eac..83acc22 100644
> --- a/libibverbs/examples/devinfo.c
> +++ b/libibverbs/examples/devinfo.c
> @@ -40,6 +40,7 @@
>  #include <getopt.h>
>  #include <endian.h>
>  #include <inttypes.h>
> +#include <arpa/inet.h>
>
>  #include <infiniband/verbs.h>
>  #include <infiniband/driver.h>
> @@ -162,12 +163,49 @@ static const char *vl_str(uint8_t vl_num)
>         }
>  }
>
> -static int print_all_port_gids(struct ibv_context *ctx, uint8_t port_num, int tbl_len)
> +#define DEVINFO_INVALID_GID_TYPE       2
> +static const char *gid_type_str(enum ibv_gid_type type)
>  {
> +       switch (type) {
> +       case IBV_GID_TYPE_IB_ROCE_V1: return "IB/RoCE v1";
> +       case IBV_GID_TYPE_ROCE_V2: return "RoCE v2";
> +       default: return "Invalid gid type";
> +       }
> +}
> +
> +static void print_formated_gid(union ibv_gid *gid, int i,
> +                              enum ibv_gid_type type, int ll)
> +{
> +       char gid_str[INET6_ADDRSTRLEN] = {};
> +       char str[20] = {};
> +
> +       if (ll == IBV_LINK_LAYER_ETHERNET) {
> +               sprintf(str, ", %s", gid_type_str(type));
> +               printf("\t\t\tGID[%3d]:\t\t%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x%s\n",
> +                      i, gid->raw[0], gid->raw[1], gid->raw[2],
> +                      gid->raw[3], gid->raw[4], gid->raw[5], gid->raw[6],
> +                      gid->raw[7], gid->raw[8], gid->raw[9], gid->raw[10],
> +                      gid->raw[11], gid->raw[12], gid->raw[13], gid->raw[14],
> +                      gid->raw[15], str);
> +       }
Opps!! this needs a rev in anycase, for IB devices gid won't be
printed at all, my bad!
> +
> +       if (type == IBV_GID_TYPE_ROCE_V2) {
> +               inet_ntop(AF_INET6, gid->raw, gid_str, sizeof(gid_str));
> +               printf("\t\t\tGID[%3d]:\t\t%s\n", i, gid_str);
> +       }
> +}
> +
> +static int print_all_port_gids(struct ibv_context *ctx,
> +                              struct ibv_port_attr *port_attr,
> +                              uint8_t port_num)
> +{
> +       enum ibv_gid_type type;
>         union ibv_gid gid;
> +       int tbl_len;
>         int rc = 0;
>         int i;
>
> +       tbl_len = port_attr->gid_tbl_len;
>         for (i = 0; i < tbl_len; i++) {
>                 rc = ibv_query_gid(ctx, port_num, i, &gid);
>                 if (rc) {
> @@ -175,17 +213,15 @@ static int print_all_port_gids(struct ibv_context *ctx, uint8_t port_num, int tb
>                                port_num, i);
>                         return rc;
>                 }
> +
> +               rc = ibv_query_gid_type(ctx, port_num, i, &type);
> +               if (rc) {
> +                       rc = 0;
> +                       type = DEVINFO_INVALID_GID_TYPE;
> +               }
>                 if (!null_gid(&gid))
> -                       printf("\t\t\tGID[%3d]:\t\t%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x\n",
> -                              i,
> -                              gid.raw[ 0], gid.raw[ 1],
> -                              gid.raw[ 2], gid.raw[ 3],
> -                              gid.raw[ 4], gid.raw[ 5],
> -                              gid.raw[ 6], gid.raw[ 7],
> -                              gid.raw[ 8], gid.raw[ 9],
> -                              gid.raw[10], gid.raw[11],
> -                              gid.raw[12], gid.raw[13],
> -                              gid.raw[14], gid.raw[15]);
> +                       print_formated_gid(&gid, i, type,
> +                                          port_attr->link_layer);
>         }
>         return rc;
>  }
> @@ -614,7 +650,7 @@ static int print_hca_cap(struct ibv_device *ib_dev, uint8_t ib_port)
>                                 printf("\t\t\tphys_state:\t\t%s (%d)\n",
>                                        port_phy_state_str(port_attr.phys_state), port_attr.phys_state);
>
> -                       if (print_all_port_gids(ctx, port, port_attr.gid_tbl_len))
> +                       if (print_all_port_gids(ctx, &port_attr, port))
>                                 goto cleanup;
>                 }
>                 printf("\n");
> --
> 1.8.3.1
>
