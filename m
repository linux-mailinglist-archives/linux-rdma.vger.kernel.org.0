Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFFE49B028
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jan 2022 10:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445785AbiAYJ0t (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jan 2022 04:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1456303AbiAYJKd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Jan 2022 04:10:33 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92B1C0604F0;
        Tue, 25 Jan 2022 00:58:08 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id z19so18685238lfq.13;
        Tue, 25 Jan 2022 00:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8Z89KhtPznBNKbInalcABWm1t5bnSwvzS/YGLbYIzIk=;
        b=JlsbwdQUfJ2fHuxZTa0t5iwlQrlvXvi3lpYI+EOBqdB532tYrU+6r0OZbzO+974csc
         oZQDCFGrseqGNYBbCBXrcT/JRw5fzTLLASPeZy8fWSOt7Lo2HDXggKQSmbW6vhuNguoL
         vYbbTwn1QcdJwkSZc21fUDXKrWXI4FBxTih9aEQbJIHZ2tlvnKm5BWgHRJW43h7cjWJJ
         EOHVg1Npv8aWs26D/F2eEICYXimjKJ2cructMq3mbObHhoxHwIzAFZFXwygdSnjlEHAo
         IhaFdon42UMY8RY5OulPhcaVpJhdvjukFtPnnazzhWgIEODKwBiIipdMZK+OAygSZBkp
         xE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8Z89KhtPznBNKbInalcABWm1t5bnSwvzS/YGLbYIzIk=;
        b=kC6vX3UbBmbZts012zSuB2N4zA9tA6zjKQXKOwplUg4fuHKeFukbMB13ziaGM4f1qH
         beFE/FiUDpZx/jyL8MBmjZhXTk5VX9Q3bHEwarM0ywAW+V+re41w4UU49DDDtV65Xf3I
         cMaBOSIq0R1n9FHcOnL+DCZ33XL4vs6Q0i2SPYKmXNBWyAk3iQnT2F0JrsgFoTqwxhh5
         3dF8+QuiV/DCWM7tC+OjJmqy5jT+uPO60hnSzPaN614XTvjPcLOIbeW7f0bdc3y2N+Z3
         wEVUmD4AAb8PPi0IjeKy9HftSC4MBx8nfpu2rPHXGn13YQhjwvl4+Aqj3pwaROLX9N6A
         xLNg==
X-Gm-Message-State: AOAM531YPKfx5iSrwDRJzS2yrQ9Zipm+Hm4XNnAx9wageBDcPLjEFgFY
        BfTnaxk6YAKLBQqhKcRabLo47A997XZaGW7ClL4=
X-Google-Smtp-Source: ABdhPJyOILQHlqdzitxnFdBsSDDOr/ZlRBG0ulVpUBvrs8nFF0Hc5eetsP65cmQNFCZbAMmYGHuZ1Hljkhl+lVCM8v0=
X-Received: by 2002:a05:6512:374f:: with SMTP id a15mr16184719lfs.571.1643101086848;
 Tue, 25 Jan 2022 00:58:06 -0800 (PST)
MIME-Version: 1.0
References: <20220125085041.49175-1-lizhijian@cn.fujitsu.com>
In-Reply-To: <20220125085041.49175-1-lizhijian@cn.fujitsu.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 25 Jan 2022 16:57:55 +0800
Message-ID: <CAD=hENcPq1HPAE0DSbVa8N3NKuP0DjC=JoyQsvfwp4u1KPEpjw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/9] RDMA/rxe: Add RDMA FLUSH operation
To:     Li Zhijian <lizhijian@cn.fujitsu.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, aharonl@nvidia.com,
        Leon Romanovsky <leon@kernel.org>, tom@talpey.com,
        tomasz.gromadzki@intel.com, LKML <linux-kernel@vger.kernel.org>,
        mbloch@nvidia.com, liangwenpeng@huawei.com,
        Xiao Yang <yangx.jy@fujitsu.com>, y-goto@fujitsu.com,
        Bob Pearson <rpearsonhpe@gmail.com>, dan.j.williams@intel.com,
        Xiao Yang <yangx.jy@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 25, 2022 at 4:45 PM Li Zhijian <lizhijian@cn.fujitsu.com> wrote=
:
>
> Hey folks,
>
> I wanna thank all of you for the kind feedback in my previous RFC.
> Recently, i have tried my best to do some updates as per your comments.
> Indeed, not all comments have been addressed for some reasons, i still
> wish to post this new one to start a new discussion.
>
> Outstanding issues:
> - iova_to_addr() without any kmap/kmap_local_page flows might not always
>   work. # existing issue.
> - responder should reply error to requested side when it requests a
>   persistence placement type to DRAM ?
> -------
>
> These patches are going to implement a *NEW* RDMA opcode "RDMA FLUSH".
> In IB SPEC 1.5[1][2], 2 new opcodes, ATOMIC WRITE and RDMA FLUSH were
> added in the MEMORY PLACEMENT EXTENSIONS section.
>
> FLUSH is used by the requesting node to achieve guarantees on the data
> placement within the memory subsystem of preceding accesses to a
> single memory region, such as those performed by RDMA WRITE, Atomics
> and ATOMIC WRITE requests.
>
> The operation indicates the virtual address space of a destination node
> and where the guarantees should apply. This range must be contiguous
> in the virtual space of the memory key but it is not necessarily a
> contiguous range of physical memory.
>
> FLUSH packets carry FLUSH extended transport header (see below) to
> specify the placement type and the selectivity level of the operation
> and RDMA extended header (RETH, see base document RETH definition) to
> specify the R_Key VA and Length associated with this request following
> the BTH in RC, RDETH in RD and XRCETH in XRC.

Thanks. Would you like to add some test cases in the latest rdma-core
about this RDMA FLUSH operation?

Thanks a lot.
Zhu Yanjun

>
> RC FLUSH:
> +----+------+------+
> |BTH | FETH | RETH |
> +----+------+------+
>
> RD FLUSH:
> +----+------+------+------+
> |BTH | RDETH| FETH | RETH |
> +----+------+------+------+
>
> XRC FLUSH:
> +----+-------+------+------+
> |BTH | XRCETH| FETH | RETH |
> +----+-------+------+------+
>
> Currently, we introduce RC and RD services only, since XRC has not been
> implemented by rxe yet.
> NOTE: only RC service is tested now, and since other HCAs have not
> added/implemented FLUSH yet, we can only test FLUSH operation in both
> SoftRoCE/rxe devices.
>
> The corresponding rdma-core and FLUSH example are available on:
> https://github.com/zhijianli88/rdma-core/tree/rfc
> Can access the kernel source in:
> https://github.com/zhijianli88/linux/tree/rdma-flush
>
> - We introduce is_pmem attribute to MR(memory region)
> - We introduce FLUSH placement type attributes to HCA
> - We introduce FLUSH access flags that users are able to register with
> Below figure shows the valid access flags uses can register with:
> +------------------------+------------------+--------------+
> | HCA attributes         |    register access flags        |
> |        and             +-----------------+---------------+
> | MR attribute(is_pmem)  |global visibility |  persistence |
> |------------------------+------------------+--------------+
> | global visibility(DRAM)|        O         |      X       |
> |------------------------+------------------+--------------+
> | global visibility(PMEM)|        O         |      X       |
> |------------------------+------------------+--------------+
> | persistence(DRAM)      |        X         |      X       |
> |------------------------+------------------+--------------+
> | persistence(PMEM)      |        X         |      O       |
> +------------------------+------------------+--------------+
> O: allow to register such access flag
>
> In order to make placement guarentees, we currently reject requesting a
> persistent flush to a non-pmem.
> The responder will check the remote requested placement types by checking
> the registered access flags.
> +------------------------+------------------+--------------+
> |                        |     registered flags            |
> | remote requested types +------------------+--------------+
> |                        |global visibility |  persistence |
> |------------------------+------------------+--------------+
> | global visibility      |        O         |      x       |
> +------------------------+------------------+--------------+
> | persistence            |        X         |      O       |
> +------------------------+------------------+--------------+
> O: allow to request such placement type
>
> Below list some details about FLUSH transport packet:
>
> A FLUSH message is built upon FLUSH request packet and is responded
> successfully by RDMA READ response of zero size.
>
> oA19-2: FLUSH shall be single packet message and shall have no payload.
> oA19-5: FLUSH BTH shall hold the Opcode =3D 0x1C
>
> FLUSH Extended Transport Header(FETH)
> +-----+-----------+------------------------+----------------------+
> |Bits |   31-6    |          5-4           |        3-0           |
> +-----+-----------+------------------------+----------------------+
> |     | Reserved  | Selectivity Level(SEL) | Placement Type(PLT)  |
> +-----+-----------+------------------------+----------------------+
>
> Selectivity Level (SEL) =E2=80=93 defines the memory region scope the FLU=
SH
> should apply on. Values are as follows:
> =E2=80=A2 b=E2=80=9900 - Memory Region Range: FLUSH applies for all prece=
ding memory
>          updates to the RETH range on this QP. All RETH fields shall be
>          valid in this selectivity mode. RETH:DMALen field shall be
>          between zero and (2 31 -1) bytes (inclusive).
> =E2=80=A2 b=E2=80=9901 - Memory Region: FLUSH applies for all preceding m=
emory up-
>          dates to RETH.R_key on this QP. RETH:DMALen and RETH:VA
>          shall be ignored in this mode.
> =E2=80=A2 b'10 - Reserved.
> =E2=80=A2 b'11 - Reserved.
>
> Placement Type (PLT) =E2=80=93 Defines the memory placement guarantee of
> this FLUSH. Multiple bits may be set in this field. Values are as follows=
:
> =E2=80=A2 Bit 0 if set to '1' indicated that the FLUSH should guarantee G=
lobal
>   Visibility.
> =E2=80=A2 Bit 1 if set to '1' indicated that the FLUSH should guarantee
>   Persistence.
> =E2=80=A2 Bits 3:2 are reserved
>
> [1]: https://www.infinibandta.org/ibta-specification/ # login required
> [2]: https://www.infinibandta.org/wp-content/uploads/2021/08/IBTA-Overvie=
w-of-IBTA-Volume-1-Release-1.5-and-MPE-2021-08-17-Secure.pptx
>
> CC: yangx.jy@cn.fujitsu.com
> CC: y-goto@fujitsu.com
> CC: Jason Gunthorpe <jgg@ziepe.ca>
> CC: Zhu Yanjun <zyjzyj2000@gmail.com
> CC: Leon Romanovsky <leon@kernel.org>
> CC: Bob Pearson <rpearsonhpe@gmail.com>
> CC: Mark Bloch <mbloch@nvidia.com>
> CC: Wenpeng Liang <liangwenpeng@huawei.com>
> CC: Aharon Landau <aharonl@nvidia.com>
> CC: Tom Talpey <tom@talpey.com>
> CC: "Gromadzki, Tomasz" <tomasz.gromadzki@intel.com>
> CC: Dan Williams <dan.j.williams@intel.com>
> CC: linux-rdma@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
>
> V1:
> https://lore.kernel.org/lkml/050c3183-2fc6-03a1-eecd-258744750972@fujitsu=
.com/T/
> or https://github.com/zhijianli88/linux/tree/rdma-flush-rfcv1
>
> Changes log
> V2:
> https://github.com/zhijianli88/linux/tree/rdma-flush
> RDMA: mr: Introduce is_pmem
>   check 1st byte to avoid crossing page boundary
>   new scheme to check is_pmem # Dan
>
> RDMA: Allow registering MR with flush access flags
>   combine with [03/10] RDMA/rxe: Allow registering FLUSH flags for suppor=
ted device only to this patch # Jason
>   split RDMA_FLUSH to 2 capabilities
>
> RDMA/rxe: Allow registering persistent flag for pmem MR only
>   update commit message, get rid of confusing ib_check_flush_access_flags=
() # Tom
>
> RDMA/rxe: Implement RC RDMA FLUSH service in requester side
>   extend flush to include length field. # Tom and Tomasz
>
> RDMA/rxe: Implement flush execution in responder side
>   adjust start for WHOLE MR level # Tom
>   don't support DMA mr for flush # Tom
>   check flush return value
>
> RDMA/rxe: Enable RDMA FLUSH capability for rxe device
>   adjust patch's order. move it here from [04/10]
>
> Li Zhijian (9):
>   RDMA: mr: Introduce is_pmem
>   RDMA: Allow registering MR with flush access flags
>   RDMA/rxe: Allow registering persistent flag for pmem MR only
>   RDMA/rxe: Implement RC RDMA FLUSH service in requester side
>   RDMA/rxe: Set BTH's SE to zero for FLUSH packet
>   RDMA/rxe: Implement flush execution in responder side
>   RDMA/rxe: Implement flush completion
>   RDMA/rxe: Enable RDMA FLUSH capability for rxe device
>   RDMA/rxe: Add RD FLUSH service support
>
>  drivers/infiniband/core/uverbs_cmd.c    |  17 +++
>  drivers/infiniband/sw/rxe/rxe_comp.c    |   4 +-
>  drivers/infiniband/sw/rxe/rxe_hdr.h     |  52 +++++++++
>  drivers/infiniband/sw/rxe/rxe_loc.h     |   2 +
>  drivers/infiniband/sw/rxe/rxe_mr.c      |  37 ++++++-
>  drivers/infiniband/sw/rxe/rxe_opcode.c  |  35 +++++++
>  drivers/infiniband/sw/rxe/rxe_opcode.h  |   3 +
>  drivers/infiniband/sw/rxe/rxe_param.h   |   4 +-
>  drivers/infiniband/sw/rxe/rxe_req.c     |  19 +++-
>  drivers/infiniband/sw/rxe/rxe_resp.c    | 133 +++++++++++++++++++++++-
>  include/rdma/ib_pack.h                  |   3 +
>  include/rdma/ib_verbs.h                 |  30 +++++-
>  include/uapi/rdma/ib_user_ioctl_verbs.h |   2 +
>  include/uapi/rdma/ib_user_verbs.h       |  19 ++++
>  include/uapi/rdma/rdma_user_rxe.h       |   7 ++
>  15 files changed, 355 insertions(+), 12 deletions(-)
>
> --
> 2.31.1
>
>
>
