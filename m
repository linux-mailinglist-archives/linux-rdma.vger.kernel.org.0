Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FB15B2CC3
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Sep 2022 05:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiIIDLX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Sep 2022 23:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiIIDK4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Sep 2022 23:10:56 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3553A1203F8;
        Thu,  8 Sep 2022 20:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1662692866; i=@fujitsu.com;
        bh=KqH0qMOY/QV2NY8U003UTxbeC9Dt3ODQKO+v+AQdZAo=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=RJrmv40L7XdTbG6ABTl6LiaKxmtd1p1IThsLitStm8MImLTWcLGLWCO10jy2Q8RcK
         NTxk6EFEJWX1NdSa0CaMMZ+xwBnMkOXI6xSPQmIuVcjU7GfMd3WUlEsUtfL/uEJuC7
         fwb0n9U+Jo0k5XMC0tNj8bNzTgzbWKIqMNAZTSe2FQH3PP8vSwuHm3MO9ZGVXv2J8N
         JyliA6KsJHGrQcw5uewnpB9totl7dM8oq7igF0zh4DQFvNXWMSRqAIEPJ1bqLVWpZ6
         VX8OPoV6JLHVXziQL6ns+/G3qw3Q0/NBUlJRyDSQcNY2N2NP3cF9rtUZsS9vOqC8f1
         h3GN1TUaTqFfw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRWlGSWpSXmKPExsViZ8ORpMu4Tir
  Z4GqrucWVf3sYLTZteMJicXnXHDaLZ4d6WSxW/vjDavFl6jRmi/PH+tkd2D12zrrL7vFi80xG
  j97md2wenzfJBbBEsWbmJeVXJLBm/Ju5iLXgiEfF6zsfWBsYN9h0MXJxCAlsZJS4332PCcJZw
  iQxY3IbG4SzlVHi97lvQA4nB6+AncSqu9tYQGwWARWJlns32SHighInZz4Bi4sKREg8fDQJzB
  YWcJZYPeUqK4jNLCAucevJfLANIgITGCXmruxjB3GYBVoYJR7M72UCqRIC2rB40SRGEJtNQEP
  iXstNMJtTwF5izcTbzBCTLCQWvznIDmHLS2x/OwcsLiGgKHGk8y8LhF0h0Tj9EBOErSZx9dwm
  5gmMwrOQHDsLyVGzkIydhWTsAkaWVYxWSUWZ6RkluYmZObqGBga6hoamukDSyFgvsUo3US+1V
  Lc8tbhE11AvsbxYL7W4WK+4Mjc5J0UvL7VkEyMwBlOKGap3MP7v/al3iFGSg0lJlPfiCqlkIb
  6k/JTKjMTijPii0pzU4kOMMhwcShK8U9YC5QSLUtNTK9Iyc4DpACYtwcGjJMLbB5LmLS5IzC3
  OTIdInWLU5fi28eReZiGWvPy8VClxXutVQEUCIEUZpXlwI2Cp6RKjrJQwLyMDA4MQT0FqUW5m
  Car8K0ZxDkYlYd73a4Cm8GTmlcBtegV0BBPQEVsDxUGOKElESEk1ME2ttGzjeHNli1DDw+UMq
  6LORckaLSzOXu4p43glUe7+Lak9pyoXLL+2Rffr7ASdnru997MuT9OuP+cx8Wxw2cGjrzdtr1
  92oCbjpIv1mijdqsZPegd6nl/anb5EzkFoyUbleJ9pKvKdfoHCOhNfpx76+1/sgVzqn26HSNU
  d7/hLbzYcPL69Znly3ye9J7uPpD/iL/bSdBDcEraQW8L+W/wGSxfXJMGbURaPPu4q+St59jjb
  EmfD/mhvUZH0vNyXlbuZ3R40m/uq22se3/DZ58epWV65eYWvjgXz2+94oP2DN0idt6Xl+4wrm
  3WPM6hG3ludaPalsNBiYu/axZpyemd0rl2pmhf60/PqtueVLUosxRmJhlrMRcWJAKl4SyvIAw
  AA
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-16.tower-587.messagelabs.com!1662692865!634669!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 13182 invoked from network); 9 Sep 2022 03:07:45 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-16.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 9 Sep 2022 03:07:45 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 72FDA1AF;
        Fri,  9 Sep 2022 04:07:45 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 6717F1AB;
        Fri,  9 Sep 2022 04:07:45 +0100 (BST)
Received: from [10.167.226.45] (10.167.226.45) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 9 Sep 2022 04:07:40 +0100
Message-ID: <f4da3894-488b-fc6a-fa04-482f1354865a@fujitsu.com>
Date:   Fri, 9 Sep 2022 11:07:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 0/7] RDMA/rxe: On-Demand Paging on SoftRoCE
Content-Language: en-US
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
        <linux-rdma@vger.kernel.org>, <leonro@nvidia.com>,
        <jgg@nvidia.com>, <zyjzyj2000@gmail.com>
CC:     <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <rpearsonhpe@gmail.com>, <yangx.jy@fujitsu.com>,
        <y-goto@fujitsu.com>
References: <cover.1662461897.git.matsuda-daisuke@fujitsu.com>
From:   Li Zhijian <lizhijian@fujitsu.com>
In-Reply-To: <cover.1662461897.git.matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.45]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Daisuke

Great job.

I love this feature, before starting reviewing you patches, i tested it with QEMU(with fsdax memory-backend) migration
over RDMA where it worked for MLX5 before.

This time, with you ODP patches, it works on RXE though ibv_advise_mr may be not yet ready.


Thanks
Zhijian


On 07/09/2022 10:42, Daisuke Matsuda wrote:
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
>    IB/mlx5: Change ib_umem_odp_map_dma_single_page() to retain umem_mutex
>    RDMA/rxe: Convert the triple tasklets to workqueues
>    RDMA/rxe: Cleanup code for responder Atomic operations
>    RDMA/rxe: Add page invalidation support
>    RDMA/rxe: Allow registering MRs for On-Demand Paging
>    RDMA/rxe: Add support for Send/Recv/Write/Read operations with ODP
>    RDMA/rxe: Add support for the traditional Atomic operations with ODP
>
>   drivers/infiniband/core/umem_odp.c    |   6 +-
>   drivers/infiniband/hw/mlx5/odp.c      |   4 +-
>   drivers/infiniband/sw/rxe/Makefile    |   5 +-
>   drivers/infiniband/sw/rxe/rxe.c       |  18 ++
>   drivers/infiniband/sw/rxe/rxe_comp.c  |  42 +++-
>   drivers/infiniband/sw/rxe/rxe_loc.h   |  11 +-
>   drivers/infiniband/sw/rxe/rxe_mr.c    |   7 +-
>   drivers/infiniband/sw/rxe/rxe_net.c   |   4 +-
>   drivers/infiniband/sw/rxe/rxe_odp.c   | 329 ++++++++++++++++++++++++++
>   drivers/infiniband/sw/rxe/rxe_param.h |   2 +-
>   drivers/infiniband/sw/rxe/rxe_qp.c    |  68 +++---
>   drivers/infiniband/sw/rxe/rxe_recv.c  |   2 +-
>   drivers/infiniband/sw/rxe/rxe_req.c   |  14 +-
>   drivers/infiniband/sw/rxe/rxe_resp.c  | 175 +++++++-------
>   drivers/infiniband/sw/rxe/rxe_resp.h  |  44 ++++
>   drivers/infiniband/sw/rxe/rxe_task.c  | 152 ------------
>   drivers/infiniband/sw/rxe/rxe_task.h  |  69 ------
>   drivers/infiniband/sw/rxe/rxe_verbs.c |  16 +-
>   drivers/infiniband/sw/rxe/rxe_verbs.h |  10 +-
>   drivers/infiniband/sw/rxe/rxe_wq.c    | 161 +++++++++++++
>   drivers/infiniband/sw/rxe/rxe_wq.h    |  71 ++++++
>   21 files changed, 824 insertions(+), 386 deletions(-)
>   create mode 100644 drivers/infiniband/sw/rxe/rxe_odp.c
>   create mode 100644 drivers/infiniband/sw/rxe/rxe_resp.h
>   delete mode 100644 drivers/infiniband/sw/rxe/rxe_task.c
>   delete mode 100644 drivers/infiniband/sw/rxe/rxe_task.h
>   create mode 100644 drivers/infiniband/sw/rxe/rxe_wq.c
>   create mode 100644 drivers/infiniband/sw/rxe/rxe_wq.h
>

