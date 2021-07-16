Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518AE3CB152
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jul 2021 06:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhGPEKa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Jul 2021 00:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhGPEKa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Jul 2021 00:10:30 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8929C06175F
        for <linux-rdma@vger.kernel.org>; Thu, 15 Jul 2021 21:07:35 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id t4-20020a05683014c4b02904cd671b911bso510043otq.1
        for <linux-rdma@vger.kernel.org>; Thu, 15 Jul 2021 21:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PQcFDGDuap2TcC5QsFARpF5BffQICv+X+HMasKvzH1M=;
        b=bz1zTpI0px0hk2weiYxe/vzkeWweKrDXaDMdtzD5KgQpR75PTTTSPGC1b/vMId0CvZ
         8bteCmBZwGV7tYC/RuBunFzVSi5uOkRKDo0REBFMk3tagzxmY9bKROsuIIIT1DJNc4rb
         RgjWc3PROadZgSi1PdctKe3PW81N9hqamRplECmSAFbmS1zMoWObcEAv4NZxSvi7TT1n
         GiWUVaMoFruyJMO1mqOzIdu4/ZuuB0NW7ZhBKRtVdWVeIU6I4+p3bDgQWc2kbD66ZUDG
         fnGQ8rsCkLmap7iCeukd9XsNp3wmwoFRm11GSYAaOwjusPVqOfzTE5qxsSPR0dOQ7VkG
         OB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PQcFDGDuap2TcC5QsFARpF5BffQICv+X+HMasKvzH1M=;
        b=Hx3LYg+EmyTmM6wDJ/x2BQPje3Uw9E1DK9XjSTar64ySJDdDhaDqv1bIRKcN1bCa1a
         mLYPTOEHYpS8YV0DRh9UaBfGCVSzpQfKNGWgUZhAAP7QMjc5TufP7CEew4Ev0QBeboga
         NdigrtUNcTktGL8SmdGHrvI6F5m7S/G8V+dx92/BIqoX6063WrgMUIbYcstTYtWHkq+/
         EFjboID5r+nHNIl8q4eb6fEejWbE1kl9fS68TiOtAHKhrR5XzdqkDV4ao2fV2uHHCKp+
         JJSS0cLM4N6p59VaqOOyCuIUOoTZiezB9DdQa2UTchWNhedealh1btnuUbo5mXvuMI34
         FGcw==
X-Gm-Message-State: AOAM5336a/jqQHT70TDKwgaHz3f7AZHYSE7aY6/Mhwp0w5SJLtY79n/n
        3buJejwo/rxhIXXXERaIHjYrFn/MHsX4ccUuSRI=
X-Google-Smtp-Source: ABdhPJy5T3czuRE3pvthud6FPZx3n7rGe63cI1fcHhDHfFXc4a8UAQ5FVyRCdEXwxM8euZp8R6kv4q7ZR0SzkwCCvPM=
X-Received: by 2002:a05:6830:108b:: with SMTP id y11mr6538905oto.53.1626408455376;
 Thu, 15 Jul 2021 21:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210714083516.456736-1-Rao.Shoaib@oracle.com>
 <20210714083516.456736-2-Rao.Shoaib@oracle.com> <CAD=hENdhJJghv2GNh3V7ndyoJ8eRej8g2TeoDFn6F4T+n2cTHA@mail.gmail.com>
 <1f764b55-77d4-8332-858e-fb9e8bd9abcd@oracle.com>
In-Reply-To: <1f764b55-77d4-8332-858e-fb9e8bd9abcd@oracle.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Fri, 16 Jul 2021 12:07:24 +0800
Message-ID: <CAD=hENcEZ6MFrivYoBmbiBEcCjFbg-6yFQJ6TrLSNQVkDs+2_A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] RDMA/rxe: Bump up default maximum values used via uverbs
To:     Shoaib Rao <rao.shoaib@oracle.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 16, 2021 at 12:44 AM Shoaib Rao <rao.shoaib@oracle.com> wrote:
>
> Following is a link
>
> https://marc.info/?l=linux-rdma&m=162395437604846&w=2
>
> Or just search for my name in the archive.
>
> Do you see any issues with this value?

After this commit is applied, I confronted the following problem
"
[  639.943561] rdma_rxe: unloaded
[  679.717143] rdma_rxe: loaded
[  691.721055] rdma_rxe: not enough indices for max_elem
"
Not sure if this problem is introduced by this commit. Please help to
check this problem.
Thanks a lot.

Zhu Yanjun
>
> Shoaib
>
> On 7/14/21 10:02 PM, Zhu Yanjun wrote:
> > On Wed, Jul 14, 2021 at 4:36 PM Rao Shoaib <Rao.Shoaib@oracle.com> wrote:
> >> From: Rao Shoaib <rshoaib@ca-dev141.us.oracle.com>
> >>
> >> In our internal testing we have found that the
> >> current maximum are too smalls. Ideally there should
> >> be no limits but currently maximum values are reported
> >> via ibv_query_device, so we have to keep maximum values
> >> but they have been made suffiently large.
> >>
> >> Resubmitting after fixing an issue reported by test robot.
> >>
> >> Reported-by: kernel test robot <lkp@intel.com>
> >>
> >> Signed-off-by: Rao Shoaib <rshoaib@ca-dev141.us.oracle.com>
> >> ---
> >>   drivers/infiniband/sw/rxe/rxe_param.h | 26 ++++++++++++++------------
> >>   1 file changed, 14 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
> >> index 742e6ec93686..092dbff890f2 100644
> >> --- a/drivers/infiniband/sw/rxe/rxe_param.h
> >> +++ b/drivers/infiniband/sw/rxe/rxe_param.h
> >> @@ -9,6 +9,8 @@
> >>
> >>   #include <uapi/rdma/rdma_user_rxe.h>
> >>
> >> +#define DEFAULT_MAX_VALUE (1 << 20)
> > Can you let me know the link in which the above value is discussed?
> >
> > Thanks,
> > Zhu Yanjun
> >
> >> +
> >>   static inline enum ib_mtu rxe_mtu_int_to_enum(int mtu)
> >>   {
> >>          if (mtu < 256)
> >> @@ -37,7 +39,7 @@ static inline enum ib_mtu eth_mtu_int_to_enum(int mtu)
> >>   enum rxe_device_param {
> >>          RXE_MAX_MR_SIZE                 = -1ull,
> >>          RXE_PAGE_SIZE_CAP               = 0xfffff000,
> >> -       RXE_MAX_QP_WR                   = 0x4000,
> >> +       RXE_MAX_QP_WR                   = DEFAULT_MAX_VALUE,
> >>          RXE_DEVICE_CAP_FLAGS            = IB_DEVICE_BAD_PKEY_CNTR
> >>                                          | IB_DEVICE_BAD_QKEY_CNTR
> >>                                          | IB_DEVICE_AUTO_PATH_MIG
> >> @@ -58,40 +60,40 @@ enum rxe_device_param {
> >>          RXE_MAX_INLINE_DATA             = RXE_MAX_WQE_SIZE -
> >>                                            sizeof(struct rxe_send_wqe),
> >>          RXE_MAX_SGE_RD                  = 32,
> >> -       RXE_MAX_CQ                      = 16384,
> >> +       RXE_MAX_CQ                      = DEFAULT_MAX_VALUE,
> >>          RXE_MAX_LOG_CQE                 = 15,
> >> -       RXE_MAX_PD                      = 0x7ffc,
> >> +       RXE_MAX_PD                      = DEFAULT_MAX_VALUE,
> >>          RXE_MAX_QP_RD_ATOM              = 128,
> >>          RXE_MAX_RES_RD_ATOM             = 0x3f000,
> >>          RXE_MAX_QP_INIT_RD_ATOM         = 128,
> >>          RXE_MAX_MCAST_GRP               = 8192,
> >>          RXE_MAX_MCAST_QP_ATTACH         = 56,
> >>          RXE_MAX_TOT_MCAST_QP_ATTACH     = 0x70000,
> >> -       RXE_MAX_AH                      = 100,
> >> -       RXE_MAX_SRQ_WR                  = 0x4000,
> >> +       RXE_MAX_AH                      = DEFAULT_MAX_VALUE,
> >> +       RXE_MAX_SRQ_WR                  = DEFAULT_MAX_VALUE,
> >>          RXE_MIN_SRQ_WR                  = 1,
> >>          RXE_MAX_SRQ_SGE                 = 27,
> >>          RXE_MIN_SRQ_SGE                 = 1,
> >>          RXE_MAX_FMR_PAGE_LIST_LEN       = 512,
> >> -       RXE_MAX_PKEYS                   = 1,
> >> +       RXE_MAX_PKEYS                   = 64,
> >>          RXE_LOCAL_CA_ACK_DELAY          = 15,
> >>
> >> -       RXE_MAX_UCONTEXT                = 512,
> >> +       RXE_MAX_UCONTEXT                = DEFAULT_MAX_VALUE,
> >>
> >>          RXE_NUM_PORT                    = 1,
> >>
> >> -       RXE_MAX_QP                      = 0x10000,
> >> +       RXE_MAX_QP                      = DEFAULT_MAX_VALUE,
> >>          RXE_MIN_QP_INDEX                = 16,
> >> -       RXE_MAX_QP_INDEX                = 0x00020000,
> >> +       RXE_MAX_QP_INDEX                = 0x00040000,
> >>
> >> -       RXE_MAX_SRQ                     = 0x00001000,
> >> +       RXE_MAX_SRQ                     = DEFAULT_MAX_VALUE,
> >>          RXE_MIN_SRQ_INDEX               = 0x00020001,
> >>          RXE_MAX_SRQ_INDEX               = 0x00040000,
> >>
> >> -       RXE_MAX_MR                      = 0x00001000,
> >> +       RXE_MAX_MR                      = DEFAULT_MAX_VALUE,
> >>          RXE_MAX_MW                      = 0x00001000,
> >>          RXE_MIN_MR_INDEX                = 0x00000001,
> >> -       RXE_MAX_MR_INDEX                = 0x00010000,
> >> +       RXE_MAX_MR_INDEX                = 0x00040000,
> >>          RXE_MIN_MW_INDEX                = 0x00010001,
> >>          RXE_MAX_MW_INDEX                = 0x00020000,
> >>
> >> --
> >> 2.27.0
> >>
