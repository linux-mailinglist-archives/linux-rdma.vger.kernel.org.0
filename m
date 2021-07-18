Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1F83CC826
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Jul 2021 09:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhGRICb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Jul 2021 04:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbhGRICa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 18 Jul 2021 04:02:30 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF48C061762
        for <linux-rdma@vger.kernel.org>; Sun, 18 Jul 2021 00:59:33 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id a17-20020a4ad5d10000b0290263c143bcb2so2202247oot.7
        for <linux-rdma@vger.kernel.org>; Sun, 18 Jul 2021 00:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2mTZG+zQKe2qHgNA1rCc1Zx7jQvgptY0PK2fTRFIDYc=;
        b=I+ga6YMXmj/1mWpUXgnZDW6iTtDvOxjIZYWlT4gN91GeDLkMXzeIf14ayznJbFKO9V
         sYk2Ut67XaJ4U5B8pqzW5L7RSH8E7Z93CJAFEQYeXanEFhD35TX8jO1gj5KWgG40LGkg
         CJ95xvcj1QBfoqebVUufmfc7K3shxskVwx2OW9QGNDWxo6NwRl3PlkH7X5ASdFDXriqK
         BdSi2Z6kDlHqdS7AkzHEc28uPp5MHV05kmGPfMQRO/IgjdkaS/rLZ7kKkHzIGC0+aJFf
         iXL/W+xf2CBq4a5qUH5MIxVpnEjlHwcw6ugfDc1BRTGHZ1ThegyuAC03pEZXD2yZAbnR
         Npyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2mTZG+zQKe2qHgNA1rCc1Zx7jQvgptY0PK2fTRFIDYc=;
        b=UBoilmAYeAbvz/zEsJsI05crXRJiCJXE/L3rrfNX+/R1gWs0yb/nbLetVbA8vNJ53D
         g679oH3yekLvcynmypd9jCt1N+ugJIq9rAg8dhSoYOAPdW+y3NqAgvSfMfqqfEDXWiEI
         Bvob5kibsJPOwC+9VFRVbJ7rBQZXKWSbp66zn+n+Fd6CGzDTb0bNWaUVLAKKb0KNulYW
         KfW1tSHWkerQBt8rdxVf4JlmqZ7xfgBMPkSS94WoWfsS8i807F1WEFFOQgzOzuzDnjBj
         cbkettDDBKyRrzFEek/VqhPgKMMBiXhlUlAOulMcHvYSIgFLTR8MhIwgTA4SyqBmBC+L
         3nCw==
X-Gm-Message-State: AOAM532I73VmXfhV6+syg7QfVJhho68RSli6eVmwmeve81FM5XuESfZX
        AZh/hdaxLI1EaB/yCBz1iYdEhtBB8mnrDAhC46g=
X-Google-Smtp-Source: ABdhPJxHOlqlRz2JqJD3HtEK5t/ko/QzOouBKPam/YsMbx3ZnbWgo0eN60KUaa9YizMBgB9/ucK6bMeewIUWrXPooHY=
X-Received: by 2002:a4a:97ed:: with SMTP id x42mr13546582ooi.49.1626595172614;
 Sun, 18 Jul 2021 00:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210714083516.456736-1-Rao.Shoaib@oracle.com>
 <20210714083516.456736-2-Rao.Shoaib@oracle.com> <CAD=hENdhJJghv2GNh3V7ndyoJ8eRej8g2TeoDFn6F4T+n2cTHA@mail.gmail.com>
 <1f764b55-77d4-8332-858e-fb9e8bd9abcd@oracle.com> <CAD=hENcEZ6MFrivYoBmbiBEcCjFbg-6yFQJ6TrLSNQVkDs+2_A@mail.gmail.com>
 <8eba2b02-36c5-e14c-3503-0e1cfeea4dd9@oracle.com>
In-Reply-To: <8eba2b02-36c5-e14c-3503-0e1cfeea4dd9@oracle.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Sun, 18 Jul 2021 15:59:21 +0800
Message-ID: <CAD=hENf5an1Vz-vKUoCPwOazB4KfXMrjyZx1MgamVZo8j0HTtg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] RDMA/rxe: Bump up default maximum values used via uverbs
To:     Shoaib Rao <rao.shoaib@oracle.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jul 17, 2021 at 2:09 AM Shoaib Rao <rao.shoaib@oracle.com> wrote:
>
>
> On 7/15/21 9:07 PM, Zhu Yanjun wrote:
>
> On Fri, Jul 16, 2021 at 12:44 AM Shoaib Rao <rao.shoaib@oracle.com> wrote:
>
> Following is a link
>
> https://urldefense.com/v3/__https://marc.info/?l=linux-rdma&m=162395437604846&w=2__;!!ACWV5N9M2RV99hQ!f9TPWtgUxambtSeQ_L3h-IH7CW3SifyiumB3kjc2v_w6Ec_WYVtjWyusEtgQ60iw$
>
> Or just search for my name in the archive.
>
> Do you see any issues with this value?
>
> After this commit is applied, I confronted the following problem
> "
> [  639.943561] rdma_rxe: unloaded
> [  679.717143] rdma_rxe: loaded
> [  691.721055] rdma_rxe: not enough indices for max_elem
> "
> Not sure if this problem is introduced by this commit. Please help to
> check this problem.
> Thanks a lot.
>
> Zhu Yanjun
>
> I do not see the issue.
>
> [root@ca-dev66 rxe]# lsmod | grep rdma_rxe
> rdma_rxe              126976  0
> ip6_udp_tunnel         16384  1 rdma_rxe
> udp_tunnel             20480  1 rdma_rxe
> ib_uverbs             147456  3 rdma_rxe,rdma_ucm,mlx5_ib
> ib_core               364544  10 rdma_cm,ib_ipoib,rdma_rxe,rds_rdma,iw_cm,ib_umad,rdma_ucm,ib_uverbs,mlx5_ib,ib_cm
>
> I am using gdb to dump the values
>
> (gdb) ptype RXE_MAX_INLINE_DATA
> type = enum rxe_device_param {RXE_MAX_MR_SIZE = -1,
>     RXE_PAGE_SIZE_CAP = 4294963200, RXE_MAX_QP_WR = 1048576,
>     RXE_DEVICE_CAP_FLAGS = 137466362998, RXE_MAX_SGE = 32,
>     RXE_MAX_WQE_SIZE = 720, RXE_MAX_INLINE_DATA = 512, RXE_MAX_SGE_RD = 32,
>     RXE_MAX_CQ = 1048576, RXE_MAX_LOG_CQE = 15, RXE_MAX_PD = 1048576,
>     RXE_MAX_QP_RD_ATOM = 128, RXE_MAX_RES_RD_ATOM = 258048,
>     RXE_MAX_QP_INIT_RD_ATOM = 128, RXE_MAX_MCAST_GRP = 8192,
>     RXE_MAX_MCAST_QP_ATTACH = 56, RXE_MAX_TOT_MCAST_QP_ATTACH = 458752,
>     RXE_MAX_AH = 1048576, RXE_MAX_SRQ_WR = 1048576, RXE_MIN_SRQ_WR = 1,
>     RXE_MAX_SRQ_SGE = 27, RXE_MIN_SRQ_SGE = 1,
>     RXE_MAX_FMR_PAGE_LIST_LEN = 512, RXE_MAX_PKEYS = 64,
>     RXE_LOCAL_CA_ACK_DELAY = 15, RXE_MAX_UCONTEXT = 1048576, RXE_NUM_PORT = 1,
>     RXE_MAX_QP = 1048576, RXE_MIN_QP_INDEX = 16, RXE_MAX_QP_INDEX = 262144,
>     RXE_MAX_SRQ = 1048576, RXE_MIN_SRQ_INDEX = 131073,
>     RXE_MAX_SRQ_INDEX = 262144, RXE_MAX_MR = 1048576, RXE_MAX_MW = 4096,
>     RXE_MIN_MR_INDEX = 1, RXE_MAX_MR_INDEX = 262144, RXE_MIN_MW_INDEX = 65537,
>     RXE_MAX_MW_INDEX = 131072, RXE_MAX_PKT_PER_ACK = 64,
>     RXE_MAX_UNACKED_PSNS = 128, RXE_INFLIGHT_SKBS_PER_QP_HIGH = 64,
>     RXE_INFLIGHT_SKBS_PER_QP_LOW = 16, RXE_NSEC_ARB_TIMER_DELAY = 200,
>     RXE_VENDOR_ID = 16777215}
>
> It is possible that you are changing some values.


I git clone the source code from
https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git again.
And the first 3 commits are as below. One is your commit.
"
6163ad3208c8 (HEAD -> for-next) RDMA/rxe: Bump up default maximum
values used via uverbs
8c1b4316c3fa (origin/for-next, origin/HEAD) RDMA/efa: Split hardware
stats to device and port stats
916071185b17 MAINTAINERS: Update maintainers of HiSilicon RoCE
"

And when I tried to add a new rxe0,
"
error: Invalid argument
"
And the dmesg logs are as below:

# dmesg
"
[   70.782302] e1000: enp0s8 NIC Link is Up 1000 Mbps Full Duplex,
Flow Control: RX
[   70.782744] IPv6: ADDRCONF(NETDEV_CHANGE): enp0s8: link becomes ready
[   79.467652] rdma_rxe: loaded
[   79.468348] rdma_rxe: not enough indices for max_elem
[   79.468356] rdma_rxe: failed to add enp0s8
"

Please follow my steps to reproduce this problem again.

Zhu Yanjun

>
> Shoaib
>
> Shoaib
>
> On 7/14/21 10:02 PM, Zhu Yanjun wrote:
>
> On Wed, Jul 14, 2021 at 4:36 PM Rao Shoaib <Rao.Shoaib@oracle.com> wrote:
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
>   drivers/infiniband/sw/rxe/rxe_param.h | 26 ++++++++++++++------------
>   1 file changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
> index 742e6ec93686..092dbff890f2 100644
> --- a/drivers/infiniband/sw/rxe/rxe_param.h
> +++ b/drivers/infiniband/sw/rxe/rxe_param.h
> @@ -9,6 +9,8 @@
>
>   #include <uapi/rdma/rdma_user_rxe.h>
>
> +#define DEFAULT_MAX_VALUE (1 << 20)
>
> Can you let me know the link in which the above value is discussed?
>
> Thanks,
> Zhu Yanjun
>
> +
>   static inline enum ib_mtu rxe_mtu_int_to_enum(int mtu)
>   {
>          if (mtu < 256)
> @@ -37,7 +39,7 @@ static inline enum ib_mtu eth_mtu_int_to_enum(int mtu)
>   enum rxe_device_param {
>          RXE_MAX_MR_SIZE                 = -1ull,
>          RXE_PAGE_SIZE_CAP               = 0xfffff000,
> -       RXE_MAX_QP_WR                   = 0x4000,
> +       RXE_MAX_QP_WR                   = DEFAULT_MAX_VALUE,
>          RXE_DEVICE_CAP_FLAGS            = IB_DEVICE_BAD_PKEY_CNTR
>                                          | IB_DEVICE_BAD_QKEY_CNTR
>                                          | IB_DEVICE_AUTO_PATH_MIG
> @@ -58,40 +60,40 @@ enum rxe_device_param {
>          RXE_MAX_INLINE_DATA             = RXE_MAX_WQE_SIZE -
>                                            sizeof(struct rxe_send_wqe),
>          RXE_MAX_SGE_RD                  = 32,
> -       RXE_MAX_CQ                      = 16384,
> +       RXE_MAX_CQ                      = DEFAULT_MAX_VALUE,
>          RXE_MAX_LOG_CQE                 = 15,
> -       RXE_MAX_PD                      = 0x7ffc,
> +       RXE_MAX_PD                      = DEFAULT_MAX_VALUE,
>          RXE_MAX_QP_RD_ATOM              = 128,
>          RXE_MAX_RES_RD_ATOM             = 0x3f000,
>          RXE_MAX_QP_INIT_RD_ATOM         = 128,
>          RXE_MAX_MCAST_GRP               = 8192,
>          RXE_MAX_MCAST_QP_ATTACH         = 56,
>          RXE_MAX_TOT_MCAST_QP_ATTACH     = 0x70000,
> -       RXE_MAX_AH                      = 100,
> -       RXE_MAX_SRQ_WR                  = 0x4000,
> +       RXE_MAX_AH                      = DEFAULT_MAX_VALUE,
> +       RXE_MAX_SRQ_WR                  = DEFAULT_MAX_VALUE,
>          RXE_MIN_SRQ_WR                  = 1,
>          RXE_MAX_SRQ_SGE                 = 27,
>          RXE_MIN_SRQ_SGE                 = 1,
>          RXE_MAX_FMR_PAGE_LIST_LEN       = 512,
> -       RXE_MAX_PKEYS                   = 1,
> +       RXE_MAX_PKEYS                   = 64,
>          RXE_LOCAL_CA_ACK_DELAY          = 15,
>
> -       RXE_MAX_UCONTEXT                = 512,
> +       RXE_MAX_UCONTEXT                = DEFAULT_MAX_VALUE,
>
>          RXE_NUM_PORT                    = 1,
>
> -       RXE_MAX_QP                      = 0x10000,
> +       RXE_MAX_QP                      = DEFAULT_MAX_VALUE,
>          RXE_MIN_QP_INDEX                = 16,
> -       RXE_MAX_QP_INDEX                = 0x00020000,
> +       RXE_MAX_QP_INDEX                = 0x00040000,
>
> -       RXE_MAX_SRQ                     = 0x00001000,
> +       RXE_MAX_SRQ                     = DEFAULT_MAX_VALUE,
>          RXE_MIN_SRQ_INDEX               = 0x00020001,
>          RXE_MAX_SRQ_INDEX               = 0x00040000,
>
> -       RXE_MAX_MR                      = 0x00001000,
> +       RXE_MAX_MR                      = DEFAULT_MAX_VALUE,
>          RXE_MAX_MW                      = 0x00001000,
>          RXE_MIN_MR_INDEX                = 0x00000001,
> -       RXE_MAX_MR_INDEX                = 0x00010000,
> +       RXE_MAX_MR_INDEX                = 0x00040000,
>          RXE_MIN_MW_INDEX                = 0x00010001,
>          RXE_MAX_MW_INDEX                = 0x00020000,
>
> --
> 2.27.0
>
