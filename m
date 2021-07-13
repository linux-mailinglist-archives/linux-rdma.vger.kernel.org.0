Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8E83C6C1D
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jul 2021 10:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbhGMInW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Jul 2021 04:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234396AbhGMInW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Jul 2021 04:43:22 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462E4C0613DD
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jul 2021 01:40:31 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id u11so27858586oiv.1
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jul 2021 01:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lQFKALztfahqROoNf2ZbVWZXe8XooFwXpIxWUF6oWnU=;
        b=XEvvpk8gG4BLfUDstMGFbGDYNf3VYzpA2AwmV19oEy/LUhxrXEe9FsDVyR4DQ9eluc
         diDtmkM6OsqQrFraQ4CjbGJ2+n9Zs0Ya4zBwM/W/XKG7Vvwljqgd+nwFktZV/ZoizwIh
         Kdrzso7psBuwRhyk4Q1eH4RDW7hMzIv4h3XRQzDVxx8YB1yqlkpWWQxwRZHvWZkwwF5d
         w83R7+yFZc8puswMzrHvXQcfb1nS85faTJ1DsWTcKAtC7Mo296e5wHeaveT68ViwQFCj
         c0Ars+/5zBJm6fVEkCgBnbV9Gy+OBf7Z4lgS3FNHEX0yy3VxSnTu5AzQa6pkQSxQE3X4
         /DbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lQFKALztfahqROoNf2ZbVWZXe8XooFwXpIxWUF6oWnU=;
        b=PcG/LMXSFAqSt+6opuYFSPvvT/lAW+t5E3s0QRN/4ju0xh2ALrnjv3NHxJ5fJrxAwX
         2VMUcXKK4N1uLmDMwUmxap1yWPDwqRt+wrogq6e7aUI9qNgkne5LoBghv6AOHC7wkcbZ
         eCLPZ+3Yh2s7kODtFvOBjeZHrV2pP1J1pWI3OMj+j83UIbqw3b1QvpwXZKTucbVTJ16E
         lPCJQ/XZTYEOPYPlRhKjmvPxBAwU8xd319LMDm6nrC7F/GHDf5eyN4nCwVylNcEmkcPf
         4sE6ok7PlVxuZW8kDXBg54N6E9aUomQsCb243+RKMq0nDHNM4P+Fttoqq1/x6+fiWELg
         JrDA==
X-Gm-Message-State: AOAM530V0/CfRRdqUnF6fYGKCnouQM48Z9QTbyq6kUKfNGXGgSWtKn6e
        mFxlZwceNAlxP12MtvEgW4Ewku5n6MNUUYcgpBQ=
X-Google-Smtp-Source: ABdhPJxpuzHd8z08MFGPmuzpcP6jbi/93mNZOzJRBvMNQHEIr7/S/ax4dHQCSelCVwUoxArVB4eccZXyfWvG9k83wEQ=
X-Received: by 2002:a05:6808:490:: with SMTP id z16mr4676388oid.89.1626165630725;
 Tue, 13 Jul 2021 01:40:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210713083647.393983-1-Rao.Shoaib@oracle.com>
In-Reply-To: <20210713083647.393983-1-Rao.Shoaib@oracle.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 13 Jul 2021 16:40:19 +0800
Message-ID: <CAD=hENeMRNFjJQa4TmRVsxNf4tuLCEDhYYUE7LZ2Pq1+vE=b6A@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Bump up default maximum values used via uverbs
To:     Rao Shoaib <Rao.Shoaib@oracle.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 13, 2021 at 4:37 PM Rao Shoaib <Rao.Shoaib@oracle.com> wrote:
>
> From: Rao Shoaib <rao.shoaib@oracle.com>
>
> In our internal testing we have found that the
> current maximum are too smalls. Ideally there should
> be no limits but currently maximum values are reported
> via ibv_query_device, so we have to keep maximum values
> but they have been made suffiently large.
>
> Signed-off-by: Rao Shoaib <rao.shoaib@oracle.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_param.h | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
> index 742e6ec93686..66a948adb1e1 100644
> --- a/drivers/infiniband/sw/rxe/rxe_param.h
> +++ b/drivers/infiniband/sw/rxe/rxe_param.h
> @@ -9,6 +9,8 @@
>
>  #include <uapi/rdma/rdma_user_rxe.h>
>
> +#define DEFAULT_MAX_VALUE (1 << 20)

How do you get this DEFAULT_MAX_VALUE? From spec? or others?

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
> +       RXE_MAX_PKEYS                   = DEFAULT_MAX_VALUE,
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
