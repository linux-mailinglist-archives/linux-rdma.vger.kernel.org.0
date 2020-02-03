Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3823E150176
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2020 06:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgBCFf3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Feb 2020 00:35:29 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:33483 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbgBCFf2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Feb 2020 00:35:28 -0500
Received: by mail-il1-f193.google.com with SMTP id s18so11561341iln.0
        for <linux-rdma@vger.kernel.org>; Sun, 02 Feb 2020 21:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0SHVnZMjrX3Jw9PKxItgQ/VRvGaJfmaxIMFbc3BTqm8=;
        b=NYjKcGPJ2fx7ndiVntNjBXOCtwLP9qH06gHtOGeTVJ46k6a5T1lWOFMkVKiMAuYIyZ
         xfQuibpcJkkEwwignFrWTdX6MhqgO8f5nw6Ef1+sC4RfTyZ98dwPBX1mtjAz9m/CF/ud
         lspgW6mSMFHWOov9/V75MyIrHAG/b87S1zV+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0SHVnZMjrX3Jw9PKxItgQ/VRvGaJfmaxIMFbc3BTqm8=;
        b=T27KKdwAuVz5VW+l4n5tC8nbAb9Yz8YN+1AqgylvquzJmvlN3QLcqfDLV01sPA3DoI
         8gOLzz2jGz7uUyP5U0F/gwcraLv3oNEf2EaclcNuF+Bmilp9FoPG1nFJ7QWSKhrfmN0r
         bHRmIZl4sUKI+uU/1r28kZiYQgRtJiaecDISJL4aXxfrkLvNNG5T4vhskr5fCOWgf3Sk
         rXRI8Mlna3EC0bNqTpj4Frk2ypjU7bwG59/hsJdyalCxJ18tc2fJBT5/Pun1Tvn5Yo2m
         s8S3vwQg1LyZ8K/G0iIQIELQ/9gYTD7m4Wf3eC2ugX/xZo+Med+WNIztLHy8tIn0wkJH
         hRAw==
X-Gm-Message-State: APjAAAWNwjIOqzuKwrxDxowVmPdQG5kEZZOwXcFXj7GjaMrvVYuKgmOA
        9T0MGuHQlefRweAaw1Yl5+vd+NwJ+qtLuHZlHIAi7zcH
X-Google-Smtp-Source: APXvYqzANtcXXoyCKSW85ErhMsmzCscxM8gckDsoVLJD0DWPjq5A4EzTaLO3Vcmgm34+YWuiNiqiFFtYv2QmPKlxVG8=
X-Received: by 2002:a92:9ac5:: with SMTP id c66mr21560752ill.232.1580708127988;
 Sun, 02 Feb 2020 21:35:27 -0800 (PST)
MIME-Version: 1.0
References: <1580493621-31006-1-git-send-email-devesh.sharma@broadcom.com>
In-Reply-To: <1580493621-31006-1-git-send-email-devesh.sharma@broadcom.com>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Mon, 3 Feb 2020 11:04:51 +0530
Message-ID: <CANjDDBi=V2+DcK2u+YPiFfyYV+O4qxUbxUWvLpgWEH6JCDm6Vg@mail.gmail.com>
Subject: Re: [PATCH v2] rdma-core/libibverbs: display gid type in ibv_devinfo
To:     linux-rdma <linux-rdma@vger.kernel.org>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 31, 2020 at 11:30 PM Devesh Sharma
<devesh.sharma@broadcom.com> wrote:
>
> It becomes difficult to make out from the output of ibv_devinfo
> if a particular gid index is RoCE v2 or not.
>
> Adding a string to the output of ibv_devinfo -v to display the
> gid type at the end of gid.
>
> Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
> ---
>  libibverbs/examples/devinfo.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/libibverbs/examples/devinfo.c b/libibverbs/examples/devinfo.c
> index bf53eac..4094ea0 100644
> --- a/libibverbs/examples/devinfo.c
> +++ b/libibverbs/examples/devinfo.c
> @@ -162,8 +162,18 @@ static const char *vl_str(uint8_t vl_num)
>         }
>  }
>
> +static const char *gid_type_str(enum ibv_gid_type type)
> +{
> +       switch (type) {
> +       case 0: return "IB/RoCE v1";
> +       case 1: return "RoCE v2";
> +       default: return "invalid value";
> +       }
> +}
> +
>  static int print_all_port_gids(struct ibv_context *ctx, uint8_t port_num, int tbl_len)
>  {
> +       enum ibv_gid_type type;
>         union ibv_gid gid;
>         int rc = 0;
>         int i;
> @@ -175,8 +185,17 @@ static int print_all_port_gids(struct ibv_context *ctx, uint8_t port_num, int tb
>                                port_num, i);
>                         return rc;
>                 }
> +
> +               rc = ibv_query_gid_type(ctx, port_num, i, &type);
> +               if (rc) {
> +                       rc = 0;
> +                       type = 0x2;
> +                       fprintf(stderr, "Failed to query gid type to port %d, index %d\n",
> +                               port_num, i);
> +               }
> +
>                 if (!null_gid(&gid))
> -                       printf("\t\t\tGID[%3d]:\t\t%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x\n",
> +                       printf("\t\t\tGID[%3d]:\t\t%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x, %s\n",
>                                i,
>                                gid.raw[ 0], gid.raw[ 1],
>                                gid.raw[ 2], gid.raw[ 3],
> @@ -185,7 +204,8 @@ static int print_all_port_gids(struct ibv_context *ctx, uint8_t port_num, int tb
>                                gid.raw[ 8], gid.raw[ 9],
>                                gid.raw[10], gid.raw[11],
>                                gid.raw[12], gid.raw[13],
> -                              gid.raw[14], gid.raw[15]);
> +                              gid.raw[14], gid.raw[15],
> +                              gid_type_str(type));
>         }
>         return rc;
>  }
> --
> 1.8.3.1
I will send out v3 as one more change is requested by Parav.
>
