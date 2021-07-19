Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCFB3CD047
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jul 2021 11:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbhGSIdI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Jul 2021 04:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbhGSIdI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Jul 2021 04:33:08 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C94DC061762
        for <linux-rdma@vger.kernel.org>; Mon, 19 Jul 2021 01:14:52 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 75-20020a9d08510000b02904acfe6bcccaso17505818oty.12
        for <linux-rdma@vger.kernel.org>; Mon, 19 Jul 2021 02:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NM1ey87s1oOoYTLKdHdwLNFs9e04BtubPW73sRAQ2+o=;
        b=PN+eGfykzNaPkw02xybqqZx+f5FLZARt2n4vKn/kKMOcdev7xmxwJrZw3Dkfos6RqA
         o7BRqz7s0Fz1QS6mqe7y5mALVtmmW4UWgdRjfkaSaS40UdY67ccLSgPpEWAwKUBHguHr
         4Y0f5WS5R2S683PCT3epE9YQ5fukIBVUkR0clf2MhrZdTxJ40HPjvfViVoaoIOK9Enlo
         LwwPjKBdgREEAKfVJ5i2gZaX51yEarDtqpqYCm8m5zfPhvbiFVjWUk80OqQjTmANqTLX
         yNGd2bX3Koo8lMxhcTZC6xsGbf1RKmpU9rmeHhd5yBi+tqON+kZp6togAUiPqhc486c3
         +M5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NM1ey87s1oOoYTLKdHdwLNFs9e04BtubPW73sRAQ2+o=;
        b=udxCbRKyg2uZiLJEoGfpvwJzMcPPOYgQKwpvZ2YXhEi89DgcLNq0XBr2M9nqcv2Orm
         GzNzQfrmA7LISOG2Nj7l7Vi3QAARULKZ4tZmX6YylgjCtjTTjZYSWf3gQHUU/K6kPvd0
         wLNOfZ0tzHUyg6lyre8HPMV9iDBm95zaJjyL/UzjV2SefCeiu4Izg4Vre+OdCgs254C4
         OZT/AGIGz7CeqjcmEOGP9auV7PVZR+xBioE9yiZIwXtzA0xIFD2EcyOtO8fCMJvd9wMR
         OJwvXHnUIHOzsk+cGGa+VALl6nRYaD7Xufv0sKgqf+6KNBaUW6W+OUqYJzPTHEX8RysR
         Tz/A==
X-Gm-Message-State: AOAM530LrzwG5j7cYkIvzEa4v2RmGus8jF+m6Zi9xJuKJ1FzfyuM1GIE
        UOP6JWoBI+Z+xV+joArvICDDaM0KQfgb6j/fxC9GzcXEjNs=
X-Google-Smtp-Source: ABdhPJyu/iO7hH5PmSHFfG/mrSn/dOdGt/pXXZlRdRmaqfYqB/fIULv/5R3z4Z1i1zSVREYWFbODuFxlczO26Kj2csc=
X-Received: by 2002:a05:6830:4104:: with SMTP id w4mr6088874ott.59.1626682384767;
 Mon, 19 Jul 2021 01:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210714083516.456736-1-Rao.Shoaib@oracle.com>
 <20210714083516.456736-2-Rao.Shoaib@oracle.com> <CAD=hENdhJJghv2GNh3V7ndyoJ8eRej8g2TeoDFn6F4T+n2cTHA@mail.gmail.com>
 <1f764b55-77d4-8332-858e-fb9e8bd9abcd@oracle.com> <CAD=hENcEZ6MFrivYoBmbiBEcCjFbg-6yFQJ6TrLSNQVkDs+2_A@mail.gmail.com>
 <8eba2b02-36c5-e14c-3503-0e1cfeea4dd9@oracle.com> <CAD=hENf5an1Vz-vKUoCPwOazB4KfXMrjyZx1MgamVZo8j0HTtg@mail.gmail.com>
 <74c62daa-9f20-cb51-ff6a-fb7def78b444@oracle.com> <2b8a485d-d9bb-1579-613c-c32f580f3f2a@oracle.com>
 <CAD=hENccPzsoDw-5FZ1fyokiPyi66s+TkBWGsPXCMvtP+eUG=A@mail.gmail.com> <57235c86-0ed8-f75b-55ee-2a20b750340d@oracle.com>
In-Reply-To: <57235c86-0ed8-f75b-55ee-2a20b750340d@oracle.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 19 Jul 2021 16:12:53 +0800
Message-ID: <CAD=hENc_gsbi+vJC1rP50yjzBVPRE1F5hWVFbs_iZC_9D+pjkg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] RDMA/rxe: Bump up default maximum values used via uverbs
To:     Shoaib Rao <rao.shoaib@oracle.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 19, 2021 at 12:20 PM Shoaib Rao <rao.shoaib@oracle.com> wrote:
>
>
> On 7/18/21 7:25 PM, Zhu Yanjun wrote:
> > On Mon, Jul 19, 2021 at 7:00 AM Shoaib Rao <rao.shoaib@oracle.com> wrote:
> >> Thanks for reporting the issue. I was able to reproduce the issue and
> >> have fixed it. Kindly try gain.
> > Do you make tests with rdma-core?
> >
> > IMHO, it is important to make tests with rdma-core before the commit
> > is sent to the community.
>
> Yes I did. However the issue shows up only when I configure an interface
> not just when module is loading.  Anyways, my apologies.

Thanks.
In my test environment, it can pass rdma-core tests.
But in this commit, a lot of default maximum values are changed.
Not sure if this will cause other issues.

Please wait for others' comments.

Thank you
Zhu Yanjun

>
> Shoaib
>
> >
> > Zhu Yanjun
> >
> >> Regards,
> >>
> >> Shoaib
> >>
> >>
> >> On 7/18/21 12:46 PM, Shoaib Rao wrote:
> >>> Your urls are garbled, so I can not make any sense out of them.
> >>>
> >>> [root@ca-dev141 linux]# git remote --v
> >>> origin
> >>> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git__;!!ACWV5N9M2RV99hQ!dGmB_LFQF6at31F0sVXbfyjtAlgNTWzBEaIER13mVG0ZAWBomLdmWXUe6DxoVFcz$
> >>> (fetch)
> >>> origin
> >>> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git__;!!ACWV5N9M2RV99hQ!dGmB_LFQF6at31F0sVXbfyjtAlgNTWzBEaIER13mVG0ZAWBomLdmWXUe6DxoVFcz$  (push)
> >>>
> >>> [root@ca-dev141 linux]# git show 8c1b4316c3fa
> >>> fatal: ambiguous argument '8c1b4316c3fa': unknown revision or path not
> >>> in the working tree.
> >>>
> >>> [root@ca-dev141 linux]# git log --grep='RDMA/efa: Split hardware'
> >>> [root@ca-dev141 linux]#
> >>>
> >>> [root@ca-dev141 linux]# git describe
> >>> v5.14-rc1-17-gc06676b5953b
> >>>
> >>> You need to do a little bit more work on your end and tell me which
> >>> value rxe is complaining about. Also provide a kernel version that you
> >>> are using as I have provided above.
> >>>
> >>> Shoaib
> >>>
> >>> On 7/18/21 12:59 AM, Zhu Yanjun wrote:
> >>>> On Sat, Jul 17, 2021 at 2:09 AM Shoaib Rao <rao.shoaib@oracle.com>
> >>>> wrote:
> >>>>> On 7/15/21 9:07 PM, Zhu Yanjun wrote:
> >>>>>
> >>>>> On Fri, Jul 16, 2021 at 12:44 AM Shoaib Rao <rao.shoaib@oracle.com>
> >>>>> wrote:
> >>>>>
> >>>>> Following is a link
> >>>>>
> >>>>> https://urldefense.com/v3/__https://marc.info/?l=linux-rdma&m=162395437604846&w=2__;!!ACWV5N9M2RV99hQ!f9TPWtgUxambtSeQ_L3h-IH7CW3SifyiumB3kjc2v_w6Ec_WYVtjWyusEtgQ60iw$
> >>>>>
> >>>>>
> >>>>> Or just search for my name in the archive.
> >>>>>
> >>>>> Do you see any issues with this value?
> >>>>>
> >>>>> After this commit is applied, I confronted the following problem
> >>>>> "
> >>>>> [  639.943561] rdma_rxe: unloaded
> >>>>> [  679.717143] rdma_rxe: loaded
> >>>>> [  691.721055] rdma_rxe: not enough indices for max_elem
> >>>>> "
> >>>>> Not sure if this problem is introduced by this commit. Please help to
> >>>>> check this problem.
> >>>>> Thanks a lot.
> >>>>>
> >>>>> Zhu Yanjun
> >>>>>
> >>>>> I do not see the issue.
> >>>>>
> >>>>> [root@ca-dev66 rxe]# lsmod | grep rdma_rxe
> >>>>> rdma_rxe              126976  0
> >>>>> ip6_udp_tunnel         16384  1 rdma_rxe
> >>>>> udp_tunnel             20480  1 rdma_rxe
> >>>>> ib_uverbs             147456  3 rdma_rxe,rdma_ucm,mlx5_ib
> >>>>> ib_core               364544  10
> >>>>> rdma_cm,ib_ipoib,rdma_rxe,rds_rdma,iw_cm,ib_umad,rdma_ucm,ib_uverbs,mlx5_ib,ib_cm
> >>>>>
> >>>>> I am using gdb to dump the values
> >>>>>
> >>>>> (gdb) ptype RXE_MAX_INLINE_DATA
> >>>>> type = enum rxe_device_param {RXE_MAX_MR_SIZE = -1,
> >>>>>       RXE_PAGE_SIZE_CAP = 4294963200, RXE_MAX_QP_WR = 1048576,
> >>>>>       RXE_DEVICE_CAP_FLAGS = 137466362998, RXE_MAX_SGE = 32,
> >>>>>       RXE_MAX_WQE_SIZE = 720, RXE_MAX_INLINE_DATA = 512,
> >>>>> RXE_MAX_SGE_RD = 32,
> >>>>>       RXE_MAX_CQ = 1048576, RXE_MAX_LOG_CQE = 15, RXE_MAX_PD = 1048576,
> >>>>>       RXE_MAX_QP_RD_ATOM = 128, RXE_MAX_RES_RD_ATOM = 258048,
> >>>>>       RXE_MAX_QP_INIT_RD_ATOM = 128, RXE_MAX_MCAST_GRP = 8192,
> >>>>>       RXE_MAX_MCAST_QP_ATTACH = 56, RXE_MAX_TOT_MCAST_QP_ATTACH =
> >>>>> 458752,
> >>>>>       RXE_MAX_AH = 1048576, RXE_MAX_SRQ_WR = 1048576, RXE_MIN_SRQ_WR
> >>>>> = 1,
> >>>>>       RXE_MAX_SRQ_SGE = 27, RXE_MIN_SRQ_SGE = 1,
> >>>>>       RXE_MAX_FMR_PAGE_LIST_LEN = 512, RXE_MAX_PKEYS = 64,
> >>>>>       RXE_LOCAL_CA_ACK_DELAY = 15, RXE_MAX_UCONTEXT = 1048576,
> >>>>> RXE_NUM_PORT = 1,
> >>>>>       RXE_MAX_QP = 1048576, RXE_MIN_QP_INDEX = 16, RXE_MAX_QP_INDEX =
> >>>>> 262144,
> >>>>>       RXE_MAX_SRQ = 1048576, RXE_MIN_SRQ_INDEX = 131073,
> >>>>>       RXE_MAX_SRQ_INDEX = 262144, RXE_MAX_MR = 1048576, RXE_MAX_MW =
> >>>>> 4096,
> >>>>>       RXE_MIN_MR_INDEX = 1, RXE_MAX_MR_INDEX = 262144,
> >>>>> RXE_MIN_MW_INDEX = 65537,
> >>>>>       RXE_MAX_MW_INDEX = 131072, RXE_MAX_PKT_PER_ACK = 64,
> >>>>>       RXE_MAX_UNACKED_PSNS = 128, RXE_INFLIGHT_SKBS_PER_QP_HIGH = 64,
> >>>>>       RXE_INFLIGHT_SKBS_PER_QP_LOW = 16, RXE_NSEC_ARB_TIMER_DELAY = 200,
> >>>>>       RXE_VENDOR_ID = 16777215}
> >>>>>
> >>>>> It is possible that you are changing some values.
> >>>> I git clone the source code from
> >>>> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git__;!!ACWV5N9M2RV99hQ!efPsL9fikzm6Ob1-zsmbsAzPkfqRpxYkp9oJXF9csPOJgoei9njj8RmA5IyuH447$
> >>>> again.
> >>>> And the first 3 commits are as below. One is your commit.
> >>>> "
> >>>> 6163ad3208c8 (HEAD -> for-next) RDMA/rxe: Bump up default maximum
> >>>> values used via uverbs
> >>>> 8c1b4316c3fa (origin/for-next, origin/HEAD) RDMA/efa: Split hardware
> >>>> stats to device and port stats
> >>>> 916071185b17 MAINTAINERS: Update maintainers of HiSilicon RoCE
> >>>> "
> >>>>
> >>>> And when I tried to add a new rxe0,
> >>>> "
> >>>> error: Invalid argument
> >>>> "
> >>>> And the dmesg logs are as below:
> >>>>
> >>>> # dmesg
> >>>> "
> >>>> [   70.782302] e1000: enp0s8 NIC Link is Up 1000 Mbps Full Duplex,
> >>>> Flow Control: RX
> >>>> [   70.782744] IPv6: ADDRCONF(NETDEV_CHANGE): enp0s8: link becomes ready
> >>>> [   79.467652] rdma_rxe: loaded
> >>>> [   79.468348] rdma_rxe: not enough indices for max_elem
> >>>> [   79.468356] rdma_rxe: failed to add enp0s8
> >>>> "
> >>>>
> >>>> Please follow my steps to reproduce this problem again.
> >>>>
> >>>> Zhu Yanjun
> >>>>
> >>>>> Shoaib
> >>>>>
> >>>>> Shoaib
> >>>>>
> >>>>> On 7/14/21 10:02 PM, Zhu Yanjun wrote:
> >>>>>
> >>>>> On Wed, Jul 14, 2021 at 4:36 PM Rao Shoaib <Rao.Shoaib@oracle.com>
> >>>>> wrote:
> >>>>>
> >>>>> From: Rao Shoaib <rshoaib@ca-dev141.us.oracle.com>
> >>>>>
> >>>>> In our internal testing we have found that the
> >>>>> current maximum are too smalls. Ideally there should
> >>>>> be no limits but currently maximum values are reported
> >>>>> via ibv_query_device, so we have to keep maximum values
> >>>>> but they have been made suffiently large.
> >>>>>
> >>>>> Resubmitting after fixing an issue reported by test robot.
> >>>>>
> >>>>> Reported-by: kernel test robot <lkp@intel.com>
> >>>>>
> >>>>> Signed-off-by: Rao Shoaib <rshoaib@ca-dev141.us.oracle.com>
> >>>>> ---
> >>>>>     drivers/infiniband/sw/rxe/rxe_param.h | 26
> >>>>> ++++++++++++++------------
> >>>>>     1 file changed, 14 insertions(+), 12 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_param.h
> >>>>> b/drivers/infiniband/sw/rxe/rxe_param.h
> >>>>> index 742e6ec93686..092dbff890f2 100644
> >>>>> --- a/drivers/infiniband/sw/rxe/rxe_param.h
> >>>>> +++ b/drivers/infiniband/sw/rxe/rxe_param.h
> >>>>> @@ -9,6 +9,8 @@
> >>>>>
> >>>>>     #include <uapi/rdma/rdma_user_rxe.h>
> >>>>>
> >>>>> +#define DEFAULT_MAX_VALUE (1 << 20)
> >>>>>
> >>>>> Can you let me know the link in which the above value is discussed?
> >>>>>
> >>>>> Thanks,
> >>>>> Zhu Yanjun
> >>>>>
> >>>>> +
> >>>>>     static inline enum ib_mtu rxe_mtu_int_to_enum(int mtu)
> >>>>>     {
> >>>>>            if (mtu < 256)
> >>>>> @@ -37,7 +39,7 @@ static inline enum ib_mtu eth_mtu_int_to_enum(int
> >>>>> mtu)
> >>>>>     enum rxe_device_param {
> >>>>>            RXE_MAX_MR_SIZE                 = -1ull,
> >>>>>            RXE_PAGE_SIZE_CAP               = 0xfffff000,
> >>>>> -       RXE_MAX_QP_WR                   = 0x4000,
> >>>>> +       RXE_MAX_QP_WR                   = DEFAULT_MAX_VALUE,
> >>>>>            RXE_DEVICE_CAP_FLAGS            = IB_DEVICE_BAD_PKEY_CNTR
> >>>>>                                            | IB_DEVICE_BAD_QKEY_CNTR
> >>>>>                                            | IB_DEVICE_AUTO_PATH_MIG
> >>>>> @@ -58,40 +60,40 @@ enum rxe_device_param {
> >>>>>            RXE_MAX_INLINE_DATA             = RXE_MAX_WQE_SIZE -
> >>>>>                                              sizeof(struct
> >>>>> rxe_send_wqe),
> >>>>>            RXE_MAX_SGE_RD                  = 32,
> >>>>> -       RXE_MAX_CQ                      = 16384,
> >>>>> +       RXE_MAX_CQ                      = DEFAULT_MAX_VALUE,
> >>>>>            RXE_MAX_LOG_CQE                 = 15,
> >>>>> -       RXE_MAX_PD                      = 0x7ffc,
> >>>>> +       RXE_MAX_PD                      = DEFAULT_MAX_VALUE,
> >>>>>            RXE_MAX_QP_RD_ATOM              = 128,
> >>>>>            RXE_MAX_RES_RD_ATOM             = 0x3f000,
> >>>>>            RXE_MAX_QP_INIT_RD_ATOM         = 128,
> >>>>>            RXE_MAX_MCAST_GRP               = 8192,
> >>>>>            RXE_MAX_MCAST_QP_ATTACH         = 56,
> >>>>>            RXE_MAX_TOT_MCAST_QP_ATTACH     = 0x70000,
> >>>>> -       RXE_MAX_AH                      = 100,
> >>>>> -       RXE_MAX_SRQ_WR                  = 0x4000,
> >>>>> +       RXE_MAX_AH                      = DEFAULT_MAX_VALUE,
> >>>>> +       RXE_MAX_SRQ_WR                  = DEFAULT_MAX_VALUE,
> >>>>>            RXE_MIN_SRQ_WR                  = 1,
> >>>>>            RXE_MAX_SRQ_SGE                 = 27,
> >>>>>            RXE_MIN_SRQ_SGE                 = 1,
> >>>>>            RXE_MAX_FMR_PAGE_LIST_LEN       = 512,
> >>>>> -       RXE_MAX_PKEYS                   = 1,
> >>>>> +       RXE_MAX_PKEYS                   = 64,
> >>>>>            RXE_LOCAL_CA_ACK_DELAY          = 15,
> >>>>>
> >>>>> -       RXE_MAX_UCONTEXT                = 512,
> >>>>> +       RXE_MAX_UCONTEXT                = DEFAULT_MAX_VALUE,
> >>>>>
> >>>>>            RXE_NUM_PORT                    = 1,
> >>>>>
> >>>>> -       RXE_MAX_QP                      = 0x10000,
> >>>>> +       RXE_MAX_QP                      = DEFAULT_MAX_VALUE,
> >>>>>            RXE_MIN_QP_INDEX                = 16,
> >>>>> -       RXE_MAX_QP_INDEX                = 0x00020000,
> >>>>> +       RXE_MAX_QP_INDEX                = 0x00040000,
> >>>>>
> >>>>> -       RXE_MAX_SRQ                     = 0x00001000,
> >>>>> +       RXE_MAX_SRQ                     = DEFAULT_MAX_VALUE,
> >>>>>            RXE_MIN_SRQ_INDEX               = 0x00020001,
> >>>>>            RXE_MAX_SRQ_INDEX               = 0x00040000,
> >>>>>
> >>>>> -       RXE_MAX_MR                      = 0x00001000,
> >>>>> +       RXE_MAX_MR                      = DEFAULT_MAX_VALUE,
> >>>>>            RXE_MAX_MW                      = 0x00001000,
> >>>>>            RXE_MIN_MR_INDEX                = 0x00000001,
> >>>>> -       RXE_MAX_MR_INDEX                = 0x00010000,
> >>>>> +       RXE_MAX_MR_INDEX                = 0x00040000,
> >>>>>            RXE_MIN_MW_INDEX                = 0x00010001,
> >>>>>            RXE_MAX_MW_INDEX                = 0x00020000,
> >>>>>
> >>>>> --
> >>>>> 2.27.0
> >>>>>
