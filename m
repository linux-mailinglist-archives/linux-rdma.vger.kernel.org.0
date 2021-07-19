Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96ABB3CCC3C
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jul 2021 04:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbhGSC25 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Jul 2021 22:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbhGSC24 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 18 Jul 2021 22:28:56 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C310BC061762
        for <linux-rdma@vger.kernel.org>; Sun, 18 Jul 2021 19:25:57 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id a132so8245156oib.6
        for <linux-rdma@vger.kernel.org>; Sun, 18 Jul 2021 19:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7mSOJtMLbU0+TdXajK1Kt6ukYZAjO+M8oADd/tcavLs=;
        b=YTaIwhFss4wARkUWmcyARGNX4J8PrQDp7woxpat/gP/dURexKpNZ+q+GTkEJ2bgqxs
         ttGa6GuXLrBS4Qw3wOfY/lsYWj9THcYpTLVtaPLS4wMiou1oZFFJq+SXoXi+POQpXKfX
         CYjLVqW8wDjuYbMso40zsNhDx7YLt53GO9OTs1iGF/aLdsFFl/UmErL1dOgSkKQ4mbWJ
         W5a84re9EKNPiQQ4H8g3gUOY7GgAXw0c029z9xGKA/HrpLKyG4+lxHYqO3XhoeBB9hnQ
         jB2F9d0cXRrLaz6HfO7pcnzhbp3OUqfRNJr3hKukZHnyBdiseXvoOMrzVdG1ZqplIRID
         ZsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7mSOJtMLbU0+TdXajK1Kt6ukYZAjO+M8oADd/tcavLs=;
        b=W95G1tf223J2+5IPzUtFmz8ufKJBY9JDMJLGKdYF8cCUNgIzCschn1sN3Y13qhnFBI
         XTsNjwjOVnhsAURVol7pxhPvF8p/MjvZBFApjtrhljawj3IlLSg3iOOrVqaYtBk+4Nx/
         Vsqw1BSahVM6gFNIzbt/1WHIDmG5taqSLsedmrwEn5Kp/J3Q1Fk1KJnOrcGxxz7WAAld
         xOZ1kmG5m0xh4NtFrRLDZc/VBqyExD8F1L3eCjxtl4ikxfdCPNOySWbI7sNCZGJCAkWK
         1xlgruUHlCJbYwJK1Dd7qQh4r3JsevBu1cFCD8amVc1Lb2gFGZnb+VSgSqYFMh7XL76w
         ZDeg==
X-Gm-Message-State: AOAM5322NstHfp8szg7O5SKWnYblRHQRJnGjhxMB16F6hZ5BdUmI2he5
        pCCrkFDNvoeLHVb58MH3Z6BSNCZ42UyYFpNZOk0=
X-Google-Smtp-Source: ABdhPJxbjOOL1i9OUICihP5JXthMxUnlMeDeCLXxMqITot4Cf9TH/fnVdzYxu0Wzc3QvZYYki7bKF0nDnSQi069e930=
X-Received: by 2002:a05:6808:bc2:: with SMTP id o2mr201737oik.163.1626661557147;
 Sun, 18 Jul 2021 19:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210714083516.456736-1-Rao.Shoaib@oracle.com>
 <20210714083516.456736-2-Rao.Shoaib@oracle.com> <CAD=hENdhJJghv2GNh3V7ndyoJ8eRej8g2TeoDFn6F4T+n2cTHA@mail.gmail.com>
 <1f764b55-77d4-8332-858e-fb9e8bd9abcd@oracle.com> <CAD=hENcEZ6MFrivYoBmbiBEcCjFbg-6yFQJ6TrLSNQVkDs+2_A@mail.gmail.com>
 <8eba2b02-36c5-e14c-3503-0e1cfeea4dd9@oracle.com> <CAD=hENf5an1Vz-vKUoCPwOazB4KfXMrjyZx1MgamVZo8j0HTtg@mail.gmail.com>
 <74c62daa-9f20-cb51-ff6a-fb7def78b444@oracle.com> <2b8a485d-d9bb-1579-613c-c32f580f3f2a@oracle.com>
In-Reply-To: <2b8a485d-d9bb-1579-613c-c32f580f3f2a@oracle.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 19 Jul 2021 10:25:46 +0800
Message-ID: <CAD=hENccPzsoDw-5FZ1fyokiPyi66s+TkBWGsPXCMvtP+eUG=A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] RDMA/rxe: Bump up default maximum values used via uverbs
To:     Shoaib Rao <rao.shoaib@oracle.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 19, 2021 at 7:00 AM Shoaib Rao <rao.shoaib@oracle.com> wrote:
>
> Thanks for reporting the issue. I was able to reproduce the issue and
> have fixed it. Kindly try gain.

Do you make tests with rdma-core?

IMHO, it is important to make tests with rdma-core before the commit
is sent to the community.

Zhu Yanjun

>
> Regards,
>
> Shoaib
>
>
> On 7/18/21 12:46 PM, Shoaib Rao wrote:
> > Your urls are garbled, so I can not make any sense out of them.
> >
> > [root@ca-dev141 linux]# git remote --v
> > origin
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > (fetch)
> > origin
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git (push)
> >
> > [root@ca-dev141 linux]# git show 8c1b4316c3fa
> > fatal: ambiguous argument '8c1b4316c3fa': unknown revision or path not
> > in the working tree.
> >
> > [root@ca-dev141 linux]# git log --grep='RDMA/efa: Split hardware'
> > [root@ca-dev141 linux]#
> >
> > [root@ca-dev141 linux]# git describe
> > v5.14-rc1-17-gc06676b5953b
> >
> > You need to do a little bit more work on your end and tell me which
> > value rxe is complaining about. Also provide a kernel version that you
> > are using as I have provided above.
> >
> > Shoaib
> >
> > On 7/18/21 12:59 AM, Zhu Yanjun wrote:
> >> On Sat, Jul 17, 2021 at 2:09 AM Shoaib Rao <rao.shoaib@oracle.com>
> >> wrote:
> >>>
> >>> On 7/15/21 9:07 PM, Zhu Yanjun wrote:
> >>>
> >>> On Fri, Jul 16, 2021 at 12:44 AM Shoaib Rao <rao.shoaib@oracle.com>
> >>> wrote:
> >>>
> >>> Following is a link
> >>>
> >>> https://urldefense.com/v3/__https://marc.info/?l=linux-rdma&m=162395437604846&w=2__;!!ACWV5N9M2RV99hQ!f9TPWtgUxambtSeQ_L3h-IH7CW3SifyiumB3kjc2v_w6Ec_WYVtjWyusEtgQ60iw$
> >>>
> >>>
> >>> Or just search for my name in the archive.
> >>>
> >>> Do you see any issues with this value?
> >>>
> >>> After this commit is applied, I confronted the following problem
> >>> "
> >>> [  639.943561] rdma_rxe: unloaded
> >>> [  679.717143] rdma_rxe: loaded
> >>> [  691.721055] rdma_rxe: not enough indices for max_elem
> >>> "
> >>> Not sure if this problem is introduced by this commit. Please help to
> >>> check this problem.
> >>> Thanks a lot.
> >>>
> >>> Zhu Yanjun
> >>>
> >>> I do not see the issue.
> >>>
> >>> [root@ca-dev66 rxe]# lsmod | grep rdma_rxe
> >>> rdma_rxe              126976  0
> >>> ip6_udp_tunnel         16384  1 rdma_rxe
> >>> udp_tunnel             20480  1 rdma_rxe
> >>> ib_uverbs             147456  3 rdma_rxe,rdma_ucm,mlx5_ib
> >>> ib_core               364544  10
> >>> rdma_cm,ib_ipoib,rdma_rxe,rds_rdma,iw_cm,ib_umad,rdma_ucm,ib_uverbs,mlx5_ib,ib_cm
> >>>
> >>> I am using gdb to dump the values
> >>>
> >>> (gdb) ptype RXE_MAX_INLINE_DATA
> >>> type = enum rxe_device_param {RXE_MAX_MR_SIZE = -1,
> >>>      RXE_PAGE_SIZE_CAP = 4294963200, RXE_MAX_QP_WR = 1048576,
> >>>      RXE_DEVICE_CAP_FLAGS = 137466362998, RXE_MAX_SGE = 32,
> >>>      RXE_MAX_WQE_SIZE = 720, RXE_MAX_INLINE_DATA = 512,
> >>> RXE_MAX_SGE_RD = 32,
> >>>      RXE_MAX_CQ = 1048576, RXE_MAX_LOG_CQE = 15, RXE_MAX_PD = 1048576,
> >>>      RXE_MAX_QP_RD_ATOM = 128, RXE_MAX_RES_RD_ATOM = 258048,
> >>>      RXE_MAX_QP_INIT_RD_ATOM = 128, RXE_MAX_MCAST_GRP = 8192,
> >>>      RXE_MAX_MCAST_QP_ATTACH = 56, RXE_MAX_TOT_MCAST_QP_ATTACH =
> >>> 458752,
> >>>      RXE_MAX_AH = 1048576, RXE_MAX_SRQ_WR = 1048576, RXE_MIN_SRQ_WR
> >>> = 1,
> >>>      RXE_MAX_SRQ_SGE = 27, RXE_MIN_SRQ_SGE = 1,
> >>>      RXE_MAX_FMR_PAGE_LIST_LEN = 512, RXE_MAX_PKEYS = 64,
> >>>      RXE_LOCAL_CA_ACK_DELAY = 15, RXE_MAX_UCONTEXT = 1048576,
> >>> RXE_NUM_PORT = 1,
> >>>      RXE_MAX_QP = 1048576, RXE_MIN_QP_INDEX = 16, RXE_MAX_QP_INDEX =
> >>> 262144,
> >>>      RXE_MAX_SRQ = 1048576, RXE_MIN_SRQ_INDEX = 131073,
> >>>      RXE_MAX_SRQ_INDEX = 262144, RXE_MAX_MR = 1048576, RXE_MAX_MW =
> >>> 4096,
> >>>      RXE_MIN_MR_INDEX = 1, RXE_MAX_MR_INDEX = 262144,
> >>> RXE_MIN_MW_INDEX = 65537,
> >>>      RXE_MAX_MW_INDEX = 131072, RXE_MAX_PKT_PER_ACK = 64,
> >>>      RXE_MAX_UNACKED_PSNS = 128, RXE_INFLIGHT_SKBS_PER_QP_HIGH = 64,
> >>>      RXE_INFLIGHT_SKBS_PER_QP_LOW = 16, RXE_NSEC_ARB_TIMER_DELAY = 200,
> >>>      RXE_VENDOR_ID = 16777215}
> >>>
> >>> It is possible that you are changing some values.
> >>
> >> I git clone the source code from
> >> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git__;!!ACWV5N9M2RV99hQ!efPsL9fikzm6Ob1-zsmbsAzPkfqRpxYkp9oJXF9csPOJgoei9njj8RmA5IyuH447$
> >> again.
> >> And the first 3 commits are as below. One is your commit.
> >> "
> >> 6163ad3208c8 (HEAD -> for-next) RDMA/rxe: Bump up default maximum
> >> values used via uverbs
> >> 8c1b4316c3fa (origin/for-next, origin/HEAD) RDMA/efa: Split hardware
> >> stats to device and port stats
> >> 916071185b17 MAINTAINERS: Update maintainers of HiSilicon RoCE
> >> "
> >>
> >> And when I tried to add a new rxe0,
> >> "
> >> error: Invalid argument
> >> "
> >> And the dmesg logs are as below:
> >>
> >> # dmesg
> >> "
> >> [   70.782302] e1000: enp0s8 NIC Link is Up 1000 Mbps Full Duplex,
> >> Flow Control: RX
> >> [   70.782744] IPv6: ADDRCONF(NETDEV_CHANGE): enp0s8: link becomes ready
> >> [   79.467652] rdma_rxe: loaded
> >> [   79.468348] rdma_rxe: not enough indices for max_elem
> >> [   79.468356] rdma_rxe: failed to add enp0s8
> >> "
> >>
> >> Please follow my steps to reproduce this problem again.
> >>
> >> Zhu Yanjun
> >>
> >>> Shoaib
> >>>
> >>> Shoaib
> >>>
> >>> On 7/14/21 10:02 PM, Zhu Yanjun wrote:
> >>>
> >>> On Wed, Jul 14, 2021 at 4:36 PM Rao Shoaib <Rao.Shoaib@oracle.com>
> >>> wrote:
> >>>
> >>> From: Rao Shoaib <rshoaib@ca-dev141.us.oracle.com>
> >>>
> >>> In our internal testing we have found that the
> >>> current maximum are too smalls. Ideally there should
> >>> be no limits but currently maximum values are reported
> >>> via ibv_query_device, so we have to keep maximum values
> >>> but they have been made suffiently large.
> >>>
> >>> Resubmitting after fixing an issue reported by test robot.
> >>>
> >>> Reported-by: kernel test robot <lkp@intel.com>
> >>>
> >>> Signed-off-by: Rao Shoaib <rshoaib@ca-dev141.us.oracle.com>
> >>> ---
> >>>    drivers/infiniband/sw/rxe/rxe_param.h | 26
> >>> ++++++++++++++------------
> >>>    1 file changed, 14 insertions(+), 12 deletions(-)
> >>>
> >>> diff --git a/drivers/infiniband/sw/rxe/rxe_param.h
> >>> b/drivers/infiniband/sw/rxe/rxe_param.h
> >>> index 742e6ec93686..092dbff890f2 100644
> >>> --- a/drivers/infiniband/sw/rxe/rxe_param.h
> >>> +++ b/drivers/infiniband/sw/rxe/rxe_param.h
> >>> @@ -9,6 +9,8 @@
> >>>
> >>>    #include <uapi/rdma/rdma_user_rxe.h>
> >>>
> >>> +#define DEFAULT_MAX_VALUE (1 << 20)
> >>>
> >>> Can you let me know the link in which the above value is discussed?
> >>>
> >>> Thanks,
> >>> Zhu Yanjun
> >>>
> >>> +
> >>>    static inline enum ib_mtu rxe_mtu_int_to_enum(int mtu)
> >>>    {
> >>>           if (mtu < 256)
> >>> @@ -37,7 +39,7 @@ static inline enum ib_mtu eth_mtu_int_to_enum(int
> >>> mtu)
> >>>    enum rxe_device_param {
> >>>           RXE_MAX_MR_SIZE                 = -1ull,
> >>>           RXE_PAGE_SIZE_CAP               = 0xfffff000,
> >>> -       RXE_MAX_QP_WR                   = 0x4000,
> >>> +       RXE_MAX_QP_WR                   = DEFAULT_MAX_VALUE,
> >>>           RXE_DEVICE_CAP_FLAGS            = IB_DEVICE_BAD_PKEY_CNTR
> >>>                                           | IB_DEVICE_BAD_QKEY_CNTR
> >>>                                           | IB_DEVICE_AUTO_PATH_MIG
> >>> @@ -58,40 +60,40 @@ enum rxe_device_param {
> >>>           RXE_MAX_INLINE_DATA             = RXE_MAX_WQE_SIZE -
> >>>                                             sizeof(struct
> >>> rxe_send_wqe),
> >>>           RXE_MAX_SGE_RD                  = 32,
> >>> -       RXE_MAX_CQ                      = 16384,
> >>> +       RXE_MAX_CQ                      = DEFAULT_MAX_VALUE,
> >>>           RXE_MAX_LOG_CQE                 = 15,
> >>> -       RXE_MAX_PD                      = 0x7ffc,
> >>> +       RXE_MAX_PD                      = DEFAULT_MAX_VALUE,
> >>>           RXE_MAX_QP_RD_ATOM              = 128,
> >>>           RXE_MAX_RES_RD_ATOM             = 0x3f000,
> >>>           RXE_MAX_QP_INIT_RD_ATOM         = 128,
> >>>           RXE_MAX_MCAST_GRP               = 8192,
> >>>           RXE_MAX_MCAST_QP_ATTACH         = 56,
> >>>           RXE_MAX_TOT_MCAST_QP_ATTACH     = 0x70000,
> >>> -       RXE_MAX_AH                      = 100,
> >>> -       RXE_MAX_SRQ_WR                  = 0x4000,
> >>> +       RXE_MAX_AH                      = DEFAULT_MAX_VALUE,
> >>> +       RXE_MAX_SRQ_WR                  = DEFAULT_MAX_VALUE,
> >>>           RXE_MIN_SRQ_WR                  = 1,
> >>>           RXE_MAX_SRQ_SGE                 = 27,
> >>>           RXE_MIN_SRQ_SGE                 = 1,
> >>>           RXE_MAX_FMR_PAGE_LIST_LEN       = 512,
> >>> -       RXE_MAX_PKEYS                   = 1,
> >>> +       RXE_MAX_PKEYS                   = 64,
> >>>           RXE_LOCAL_CA_ACK_DELAY          = 15,
> >>>
> >>> -       RXE_MAX_UCONTEXT                = 512,
> >>> +       RXE_MAX_UCONTEXT                = DEFAULT_MAX_VALUE,
> >>>
> >>>           RXE_NUM_PORT                    = 1,
> >>>
> >>> -       RXE_MAX_QP                      = 0x10000,
> >>> +       RXE_MAX_QP                      = DEFAULT_MAX_VALUE,
> >>>           RXE_MIN_QP_INDEX                = 16,
> >>> -       RXE_MAX_QP_INDEX                = 0x00020000,
> >>> +       RXE_MAX_QP_INDEX                = 0x00040000,
> >>>
> >>> -       RXE_MAX_SRQ                     = 0x00001000,
> >>> +       RXE_MAX_SRQ                     = DEFAULT_MAX_VALUE,
> >>>           RXE_MIN_SRQ_INDEX               = 0x00020001,
> >>>           RXE_MAX_SRQ_INDEX               = 0x00040000,
> >>>
> >>> -       RXE_MAX_MR                      = 0x00001000,
> >>> +       RXE_MAX_MR                      = DEFAULT_MAX_VALUE,
> >>>           RXE_MAX_MW                      = 0x00001000,
> >>>           RXE_MIN_MR_INDEX                = 0x00000001,
> >>> -       RXE_MAX_MR_INDEX                = 0x00010000,
> >>> +       RXE_MAX_MR_INDEX                = 0x00040000,
> >>>           RXE_MIN_MW_INDEX                = 0x00010001,
> >>>           RXE_MAX_MW_INDEX                = 0x00020000,
> >>>
> >>> --
> >>> 2.27.0
> >>>
