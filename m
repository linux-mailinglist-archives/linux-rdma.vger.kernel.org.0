Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9973C97FF
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jul 2021 07:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237396AbhGOFFn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Jul 2021 01:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbhGOFFn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 15 Jul 2021 01:05:43 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77B7C06175F
        for <linux-rdma@vger.kernel.org>; Wed, 14 Jul 2021 22:02:50 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id v32-20020a0568300920b02904b90fde9029so4902706ott.7
        for <linux-rdma@vger.kernel.org>; Wed, 14 Jul 2021 22:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CcH7QWFJyXPKcqY0G5on10RSJev+iAoUjznebch/Lk8=;
        b=GzL4YEdn3c1a+sMwTp/7O6lOWRRRy5LKWDvXDP6dMcibgzhNBE0Ga3OhOBY0VqLlIH
         WIssnOSmzvJG5KJelIt+DwqicccjUQ5NyF0/GNmjWwZC/LCoxd9ekaq8pQFa+RU5BGfL
         SjQ7dAeJ+y0VxMCuJZn8QM/PURYFllemmXuUlIe2MYUl1eY2AQQvaPRAv4fqgN+DRWqa
         pHQ/RMeOPFKNJmN70IPxOkWvN8JBbpMFJoHi1mH21Sc70uejbD8rXjGAv8iIUbplNy+0
         McetVh32CAZB7BKqpvbYZJseoEN2N/rrvb0iE1Z4oHvAhxj5wiOlXDHjQXQLp3cojuB3
         k4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CcH7QWFJyXPKcqY0G5on10RSJev+iAoUjznebch/Lk8=;
        b=rLp+GQmjTzNcKv8RaYIIHwixuM7ncosx7zuK8GAw+BmTdVE4lkQTNwmH0RAYPBM/3x
         iJyJ836dp43wYmdR7HLTxTMz7mbNliFMMPG3hF25DbEYigqZgdWNc5e7RUL/PMIn+Ef9
         C72I36B9MTjTswha3d5HlKXzg5EuAFeITx3tsk4sVsrTkQCUydwPh0+N5Oyhg2UjkVcL
         nzMpkptaeSlRkcR2Lijej3ixvANDq8qDavvbd73JY1Jq2ivSGr28jpIF0UggivsMN+n4
         9rUl/HT9R1i+I4NFlfpoxAfE6WGm+MjORckzxRkbrxBpQNkcAJ0gLFX/8Jh+VtjLQRjb
         GgQg==
X-Gm-Message-State: AOAM531CwZyWQRBZXZin3xi9i/Pw3w8g6bGCXp0SYsA+uG/kZjPYRcjj
        eCUSbPiVUbik2j2wb1bB8Axj75M5h8NZ53Wy3Sb+oNd4
X-Google-Smtp-Source: ABdhPJzX7aiu2NEqI/2brIVoaeL2Qe6tKHGol7tvOU2HO/KgioQnloWAQuF67A2upbTAea1TlM5JyTRwOenayxOB1Yg=
X-Received: by 2002:a05:6830:108b:: with SMTP id y11mr1914075oto.53.1626325370296;
 Wed, 14 Jul 2021 22:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210714083516.456736-1-Rao.Shoaib@oracle.com> <20210714083516.456736-2-Rao.Shoaib@oracle.com>
In-Reply-To: <20210714083516.456736-2-Rao.Shoaib@oracle.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Thu, 15 Jul 2021 13:02:39 +0800
Message-ID: <CAD=hENdhJJghv2GNh3V7ndyoJ8eRej8g2TeoDFn6F4T+n2cTHA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] RDMA/rxe: Bump up default maximum values used via uverbs
To:     Rao Shoaib <Rao.Shoaib@oracle.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 14, 2021 at 4:36 PM Rao Shoaib <Rao.Shoaib@oracle.com> wrote:
>
> From: Rao Shoaib <rshoaib@ca-dev141.us.oracle.com>
>
> In our internal testing we have found that the
> current maximum are too smalls. Ideally there should
> be no limits but currently maximum values are reported
> via ibv_query_device, so we have to keep maximum values
> but they have been made suffiently large.
>
> Resubmitting after fixing an issue reported by test robot.
>
> Reported-by: kernel test robot <lkp@intel.com>
>
> Signed-off-by: Rao Shoaib <rshoaib@ca-dev141.us.oracle.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_param.h | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
> index 742e6ec93686..092dbff890f2 100644
> --- a/drivers/infiniband/sw/rxe/rxe_param.h
> +++ b/drivers/infiniband/sw/rxe/rxe_param.h
> @@ -9,6 +9,8 @@
>
>  #include <uapi/rdma/rdma_user_rxe.h>
>
> +#define DEFAULT_MAX_VALUE (1 << 20)

Can you let me know the link in which the above value is discussed?

Thanks,
Zhu Yanjun

> +
>  static inline enum ib_mtu rxe_mtu_int_to_enum(int mtu)
>  {
>         if (mtu < 256)
> @@ -37,7 +39,7 @@ static inline enum ib_mtu eth_mtu_int_to_enum(int mtu)
>  enum rxe_device_param {
>         RXE_MAX_MR_SIZE                 = -1ull,
>         RXE_PAGE_SIZE_CAP               = 0xfffff000,
> -       RXE_MAX_QP_WR                   = 0x4000,
> +       RXE_MAX_QP_WR                   = DEFAULT_MAX_VALUE,
>         RXE_DEVICE_CAP_FLAGS            = IB_DEVICE_BAD_PKEY_CNTR
>                                         | IB_DEVICE_BAD_QKEY_CNTR
>                                         | IB_DEVICE_AUTO_PATH_MIG
> @@ -58,40 +60,40 @@ enum rxe_device_param {
>         RXE_MAX_INLINE_DATA             = RXE_MAX_WQE_SIZE -
>                                           sizeof(struct rxe_send_wqe),
>         RXE_MAX_SGE_RD                  = 32,
> -       RXE_MAX_CQ                      = 16384,
> +       RXE_MAX_CQ                      = DEFAULT_MAX_VALUE,
>         RXE_MAX_LOG_CQE                 = 15,
> -       RXE_MAX_PD                      = 0x7ffc,
> +       RXE_MAX_PD                      = DEFAULT_MAX_VALUE,
>         RXE_MAX_QP_RD_ATOM              = 128,
>         RXE_MAX_RES_RD_ATOM             = 0x3f000,
>         RXE_MAX_QP_INIT_RD_ATOM         = 128,
>         RXE_MAX_MCAST_GRP               = 8192,
>         RXE_MAX_MCAST_QP_ATTACH         = 56,
>         RXE_MAX_TOT_MCAST_QP_ATTACH     = 0x70000,
> -       RXE_MAX_AH                      = 100,
> -       RXE_MAX_SRQ_WR                  = 0x4000,
> +       RXE_MAX_AH                      = DEFAULT_MAX_VALUE,
> +       RXE_MAX_SRQ_WR                  = DEFAULT_MAX_VALUE,
>         RXE_MIN_SRQ_WR                  = 1,
>         RXE_MAX_SRQ_SGE                 = 27,
>         RXE_MIN_SRQ_SGE                 = 1,
>         RXE_MAX_FMR_PAGE_LIST_LEN       = 512,
> -       RXE_MAX_PKEYS                   = 1,
> +       RXE_MAX_PKEYS                   = 64,
>         RXE_LOCAL_CA_ACK_DELAY          = 15,
>
> -       RXE_MAX_UCONTEXT                = 512,
> +       RXE_MAX_UCONTEXT                = DEFAULT_MAX_VALUE,
>
>         RXE_NUM_PORT                    = 1,
>
> -       RXE_MAX_QP                      = 0x10000,
> +       RXE_MAX_QP                      = DEFAULT_MAX_VALUE,
>         RXE_MIN_QP_INDEX                = 16,
> -       RXE_MAX_QP_INDEX                = 0x00020000,
> +       RXE_MAX_QP_INDEX                = 0x00040000,
>
> -       RXE_MAX_SRQ                     = 0x00001000,
> +       RXE_MAX_SRQ                     = DEFAULT_MAX_VALUE,
>         RXE_MIN_SRQ_INDEX               = 0x00020001,
>         RXE_MAX_SRQ_INDEX               = 0x00040000,
>
> -       RXE_MAX_MR                      = 0x00001000,
> +       RXE_MAX_MR                      = DEFAULT_MAX_VALUE,
>         RXE_MAX_MW                      = 0x00001000,
>         RXE_MIN_MR_INDEX                = 0x00000001,
> -       RXE_MAX_MR_INDEX                = 0x00010000,
> +       RXE_MAX_MR_INDEX                = 0x00040000,
>         RXE_MIN_MW_INDEX                = 0x00010001,
>         RXE_MAX_MW_INDEX                = 0x00020000,
>
> --
> 2.27.0
>
