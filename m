Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BBD5B1755
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Sep 2022 10:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiIHIlL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Sep 2022 04:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiIHIlJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Sep 2022 04:41:09 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60255A6C49;
        Thu,  8 Sep 2022 01:41:08 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id fs14so12268824pjb.5;
        Thu, 08 Sep 2022 01:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=FghVNLUrlPyYGHP5B09hNKM87kRqbaG5UlXk3YvLVs8=;
        b=ZqCqpwsvRPogljWKpCIYDEXQnQ85aTckwhvWP8dtp4vES3oi+iasDjwQqP6pjLFAag
         k17kF1iZ0nPbQ+KTfpOrOYTmP/Yk9wUAR2EiTMHXT0/tmT1qeWBzKBjBIXKI+zK+58m0
         68op6jRbRtS4vm2zvqE6X3fzM837QV1OtwsR72FV5oou3PmYVej96drcGJaHkArvz4ep
         5j6BpKDqTwWmIHO9cpP8rHjiw2g1eD68PoqFfFolV8UsFK3ZM9iJYH+o86Q/o26PYAdN
         n4UVH3QIXGwadBp0i+RFNS7MJ1/jPrzg6w/Xrb8WfvviHp5MWO8yKHn26MiZOko5LWkZ
         wvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=FghVNLUrlPyYGHP5B09hNKM87kRqbaG5UlXk3YvLVs8=;
        b=NBtJvbhY7Xh5QmlEhIm3+YL0fyLBBoSQ/+HdaAfhm0O0gCGMAlnJrmFQCkY8lmLnNR
         0i5YIPQ0y0RIdBZKEJgvka8FuWGPWt6ikYqPDsHljVS9qP6MkF+dIxZjCqnnTFYsnl0p
         rtkUG4LtN/Q876X74pOd+J7rLfQiUJ08f32b/dGC+gzlbY0RP2jkYzQrG+SBUbDytpWy
         r/4JGGZWc9Loi5HEBobLnTJ9ca3m9hkM5RMs03hqjX1nwSJKh1kHblCq3Xrt4afSIwTf
         tOkjpgPm3w53+Azn29J7Y816IuIEYQFh8efrNgTHKkt8HS8WlVaH2gRcY7EP2Sd/mIuP
         xNzg==
X-Gm-Message-State: ACgBeo1DtEt/abPAO6z4kC45iD4m18z+HBCqYNGvelfBfhUsf6gDOj9d
        rLMyHMuk6qY/mFGmlaKnhlkXPlMnRJt7+zDAyGA=
X-Google-Smtp-Source: AA6agR6ZPzDPp/QIG7ey+4mzj4OSphq9EdL9irvxtru0R/lKMKfO1LhhHDwC0a4Pm34zAO2EwveDvRHhjQKBCBE+iBE=
X-Received: by 2002:a17:902:d4c4:b0:170:9fdb:4a2a with SMTP id
 o4-20020a170902d4c400b001709fdb4a2amr7457794plg.137.1662626467712; Thu, 08
 Sep 2022 01:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662461897.git.matsuda-daisuke@fujitsu.com>
In-Reply-To: <cover.1662461897.git.matsuda-daisuke@fujitsu.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Thu, 8 Sep 2022 16:40:55 +0800
Message-ID: <CAD=hENew09_VowX_c=O+wMBkXNFK1LRV5+TZ+VVHKQA5-itHvg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] RDMA/rxe: On-Demand Paging on SoftRoCE
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, nvdimm@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Xiao Yang <yangx.jy@fujitsu.com>,
        Li Zhijian <lizhijian@fujitsu.com>, y-goto@fujitsu.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 7, 2022 at 10:44 AM Daisuke Matsuda
<matsuda-daisuke@fujitsu.com> wrote:
>
> Hi everyone,
>
> This patch series implements the On-Demand Paging feature on SoftRoCE(rxe)
> driver, which has been available only in mlx5 driver[1] so far.
>
> [Overview]
> When applications register a memory region(MR), RDMA drivers normally pin
> pages in the MR so that physical addresses are never changed during RDMA
> communication. This requires the MR to fit in physical memory and
> inevitably leads to memory pressure. On the other hand, On-Demand Paging
> (ODP) allows applications to register MRs without pinning pages. They are
> paged-in when the driver requires and paged-out when the OS reclaims. As a
> result, it is possible to register a large MR that does not fit in physical
> memory without taking up so much physical memory.
>
> [Why to add this feature?]
> We, Fujitsu, have contributed to RDMA with a view to using it with
> persistent memory. Persistent memory can host a filesystem that allows
> applications to read/write files directly without involving page cache.
> This is called FS-DAX(filesystem direct access) mode. There is a problem
> that data on DAX-enabled filesystem cannot be duplicated with software RAID
> or other hardware methods. Data replication with RDMA, which features
> high-speed connections, is the best solution for the problem.
>
> However, there is a known issue that hinders using RDMA with FS-DAX. When
> RDMA operations to a file and update of the file metadata are processed
> concurrently on the same node, illegal memory accesses can be executed,
> disregarding the updated metadata. This is because RDMA operations do not
> go through page cache but access data directly. There was an effort[2] to
> solve this problem, but it was rejected in the end. Though there is no
> general solution available, it is possible to work around the problem using
> the ODP feature that has been available only in mlx5. ODP enables drivers
> to update metadata before processing RDMA operations.
>
> We have enhanced the rxe to expedite the usage of persistent memory. Our
> contribution to rxe includes RDMA Atomic write[3] and RDMA Flush[4]. With
> them being merged to rxe along with ODP, an environment will be ready for
> developers to create and test software for RDMA with FS-DAX. There is a
> library(librpma)[5] being developed for this purpose. This environment
> can be used by anybody without any special hardware but an ordinary
> computer with a normal NIC though it is inferior to hardware
> implementations in terms of performance.
>
> [Design considerations]
> ODP has been available only in mlx5, but functions and data structures
> that can be used commonly are provided in ib_uverbs(infiniband/core). The
> interface is heavily dependent on HMM infrastructure[6], and this patchset
> use them as much as possible. While mlx5 has both Explicit and Implicit ODP
> features along with prefetch feature, this patchset implements the Explicit
> ODP feature only.
>
> As an important change, it is necessary to convert triple tasklets
> (requester, responder and completer) to workqueues because they must be
> able to sleep in order to trigger page fault before accessing MRs. I did a
> test shown in the 2nd patch and found that the change makes the latency
> higher while improving the bandwidth. Though it may be possible to create a
> new independent workqueue for page fault execution, it is a not very
> sensible solution since the tasklets have to busy-wait its completion in
> that case.
>
> If responder and completer sleep, it becomes more likely that packet drop
> occurs because of overflow in receiver queue. There are multiple queues
> involved, but, as SoftRoCE uses UDP, the most important one would be the
> UDP buffers. The size can be configured in net.core.rmem_default and
> net.core.rmem_max sysconfig parameters. Users should change these values in
> case of packet drop, but page fault would be typically not so long as to
> cause the problem.
>
> [How does ODP work?]
> "struct ib_umem_odp" is used to manage pages. It is created for each
> ODP-enabled MR on its registration. This struct holds a pair of arrays
> (dma_list/pfn_list) that serve as a driver page table. DMA addresses and
> PFNs are stored in the driver page table. They are updated on page-in and
> page-out, both of which use the common interface in ib_uverbs.
>
> Page-in can occur when requester, responder or completer access an MR in
> order to process RDMA operations. If they find that the pages being
> accessed are not present on physical memory or requisite permissions are
> not set on the pages, they provoke page fault to make pages present with
> proper permissions and at the same time update the driver page table. After
> confirming the presence of the pages, they execute memory access such as
> read, write or atomic operations.
>
> Page-out is triggered by page reclaim or filesystem events (e.g. metadata
> update of a file that is being used as an MR). When creating an ODP-enabled
> MR, the driver registers an MMU notifier callback. When the kernel issues a
> page invalidation notification, the callback is provoked to unmap DMA
> addresses and update the driver page table. After that, the kernel releases
> the pages.
>
> [Supported operations]
> All operations are supported on RC connection. Atomic write[3] and Flush[4]
> operations, which are still under discussion, are also going to be
> supported after their patches are merged. On UD connection, Send, Recv,
> SRQ-Recv are supported. Because other operations are not supported on mlx5,
> I take after the decision right now.
>
> [How to test ODP?]
> There are only a few resources available for testing. pyverbs testcases in
> rdma-core and perftest[7] are recommendable ones. Note that you may have to
> build perftest from upstream since older versions do not handle ODP
> capabilities correctly.

ibv_rc_pingpong can also test the odp feature.

Please add rxe odp test cases in rdma-core.

Thanks a lot.
Zhu Yanjun

>
> [Future work]
> My next work will be the prefetch feature. It allows applications to
> trigger page fault using ibv_advise_mr(3) to optimize performance. Some
> existing software like librpma use this feature. Additionally, I think we
> can also add the implicit ODP feature in the future.
>
> [1] [RFC 00/20] On demand paging
> https://www.spinics.net/lists/linux-rdma/msg18906.html
>
> [2] [RFC PATCH v2 00/19] RDMA/FS DAX truncate proposal V1,000,002 ;-)
> https://lore.kernel.org/nvdimm/20190809225833.6657-1-ira.weiny@intel.com/
>
> [3] [RESEND PATCH v5 0/2] RDMA/rxe: Add RDMA Atomic Write operation
> https://www.spinics.net/lists/linux-rdma/msg111428.html
>
> [4] [PATCH v4 0/6] RDMA/rxe: Add RDMA FLUSH operation
> https://www.spinics.net/lists/kernel/msg4462045.html
>
> [5] librpma: Remote Persistent Memory Access Library
> https://github.com/pmem/rpma
>
> [6] Heterogeneous Memory Management (HMM)
> https://www.kernel.org/doc/html/latest/mm/hmm.html
>
> [7] linux-rdma/perftest: Infiniband Verbs Performance Tests
> https://github.com/linux-rdma/perftest
>
> Daisuke Matsuda (7):
>   IB/mlx5: Change ib_umem_odp_map_dma_single_page() to retain umem_mutex
>   RDMA/rxe: Convert the triple tasklets to workqueues
>   RDMA/rxe: Cleanup code for responder Atomic operations
>   RDMA/rxe: Add page invalidation support
>   RDMA/rxe: Allow registering MRs for On-Demand Paging
>   RDMA/rxe: Add support for Send/Recv/Write/Read operations with ODP
>   RDMA/rxe: Add support for the traditional Atomic operations with ODP
>
>  drivers/infiniband/core/umem_odp.c    |   6 +-
>  drivers/infiniband/hw/mlx5/odp.c      |   4 +-
>  drivers/infiniband/sw/rxe/Makefile    |   5 +-
>  drivers/infiniband/sw/rxe/rxe.c       |  18 ++
>  drivers/infiniband/sw/rxe/rxe_comp.c  |  42 +++-
>  drivers/infiniband/sw/rxe/rxe_loc.h   |  11 +-
>  drivers/infiniband/sw/rxe/rxe_mr.c    |   7 +-
>  drivers/infiniband/sw/rxe/rxe_net.c   |   4 +-
>  drivers/infiniband/sw/rxe/rxe_odp.c   | 329 ++++++++++++++++++++++++++
>  drivers/infiniband/sw/rxe/rxe_param.h |   2 +-
>  drivers/infiniband/sw/rxe/rxe_qp.c    |  68 +++---
>  drivers/infiniband/sw/rxe/rxe_recv.c  |   2 +-
>  drivers/infiniband/sw/rxe/rxe_req.c   |  14 +-
>  drivers/infiniband/sw/rxe/rxe_resp.c  | 175 +++++++-------
>  drivers/infiniband/sw/rxe/rxe_resp.h  |  44 ++++
>  drivers/infiniband/sw/rxe/rxe_task.c  | 152 ------------
>  drivers/infiniband/sw/rxe/rxe_task.h  |  69 ------
>  drivers/infiniband/sw/rxe/rxe_verbs.c |  16 +-
>  drivers/infiniband/sw/rxe/rxe_verbs.h |  10 +-
>  drivers/infiniband/sw/rxe/rxe_wq.c    | 161 +++++++++++++
>  drivers/infiniband/sw/rxe/rxe_wq.h    |  71 ++++++
>  21 files changed, 824 insertions(+), 386 deletions(-)
>  create mode 100644 drivers/infiniband/sw/rxe/rxe_odp.c
>  create mode 100644 drivers/infiniband/sw/rxe/rxe_resp.h
>  delete mode 100644 drivers/infiniband/sw/rxe/rxe_task.c
>  delete mode 100644 drivers/infiniband/sw/rxe/rxe_task.h
>  create mode 100644 drivers/infiniband/sw/rxe/rxe_wq.c
>  create mode 100644 drivers/infiniband/sw/rxe/rxe_wq.h
>
> --
> 2.31.1
>
