Return-Path: <linux-rdma+bounces-5587-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 612CD9B3B38
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2024 21:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844BB1C220D9
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2024 20:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D721DFDBC;
	Mon, 28 Oct 2024 20:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p0yWTmjH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ADF18EFC9;
	Mon, 28 Oct 2024 20:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730146759; cv=none; b=kqsoClMjMxRzJkiY9dGZMFnjq5bTbmrZe5dk+G7+kPrY2BOfhZ03aOtWAwDteVMogl413JkPc9jSOMy8RHldwrR/Nnf97ylP+QPZXy+Lnc0u4ayeNOyfJSN3oLKTOV0vqQQ//Qo4MsK5hkNtSZibDmwW58NR2bk8ayc9md9gJBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730146759; c=relaxed/simple;
	bh=RbYkSlujsGnfrrSc/RXoJgq2re22jesjHYy+grYlGKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kCnePH5LE1A6tsX5s54jeAzewn4EYpbF67eEGzHLeOT4DGMLCmM1nC8Y0VbwopK8zxDeMIoXj3gQOF37Ehw8KUS9CG8mbhQZmc8vNda3zUACXfQudTAK/zd04JKLYqnwkSiekdokejZ1Mi8Wn/Kj0w1PihJSN0QZ1VxY8pUX9L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p0yWTmjH; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e6580d85-2c57-4ca1-9846-7af831bfceb7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730146753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iC0SyFOBqKv7K1vchCcjd076apOvYvJHYgGggSyFBm4=;
	b=p0yWTmjHcIwu4+3h0AQH5/1Mntgl5HjnN1rnP11QngAyl3yw51C5T+0w2MHaavjswa0UQh
	ihZwR7sucib2780r3J/j0196fOThxPfcml4Ze4p/be4Jw4OJGatvTHiF5exeSEGqlGsnj+
	7mPolsSdCRztgpcC45iPQz+6v3dGYkU=
Date: Mon, 28 Oct 2024 21:19:10 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next v8 0/6] On-Demand Paging on SoftRoCE
To: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "leon@kernel.org" <leon@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
References: <20241009015903.801987-1-matsuda-daisuke@fujitsu.com>
 <ac2d7fcc-024f-4913-949f-11cbe5d09f63@linux.dev>
 <OS3PR01MB9865DCDAEDDA8187267429AFE54A2@OS3PR01MB9865.jpnprd01.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <OS3PR01MB9865DCDAEDDA8187267429AFE54A2@OS3PR01MB9865.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/10/28 8:59, Daisuke Matsuda (Fujitsu) 写道:
> On Fri, Oct 18, 2024 4:07 PM Zhu Yanjun wrote:
>> 在 2024/10/9 3:58, Daisuke Matsuda 写道:
>>> This patch series implements the On-Demand Paging feature on SoftRoCE(rxe)
>>> driver, which has been available only in mlx5 driver[1] so far.
>>>
>>> This series has been blocked because of the hang issue of srp 002 test[2],
>>> which was believed to be caused after applying the commit 9b4b7c1f9f54
>>> ("RDMA/rxe: Add workqueue support for rxe tasks"). My patches are dependent
>>> on the commit because the ODP feature requires sleeping in kernel space,
>>> and it is impossible with the former tasklet implementation.
>>>
>>> According to the original reporter[3], the hang issue is already gone in
>>> v6.10. Additionally, tasklet is marked deprecated[4]. I think the rxe
>>> driver is ready to accept this series since there is no longer any reason
>>> to consider reverting back to the old tasklet.
>>>
>>> I omitted some contents like the motive behind this series from the cover-
>>> letter. Please see the cover letter of v3 for more details[5].
>>>
>>> [Overview]
>>> When applications register a memory region(MR), RDMA drivers normally pin
>>> pages in the MR so that physical addresses are never changed during RDMA
>>> communication. This requires the MR to fit in physical memory and
>>> inevitably leads to memory pressure. On the other hand, On-Demand Paging
>>> (ODP) allows applications to register MRs without pinning pages. They are
>>> paged-in when the driver requires and paged-out when the OS reclaims. As a
>>> result, it is possible to register a large MR that does not fit in physical
>>> memory without taking up so much physical memory.
>>>
>>> [How does ODP work?]
>>> "struct ib_umem_odp" is used to manage pages. It is created for each
>>> ODP-enabled MR on its registration. This struct holds a pair of arrays
>>> (dma_list/pfn_list) that serve as a driver page table. DMA addresses and
>>> PFNs are stored in the driver page table. They are updated on page-in and
>>> page-out, both of which use the common interfaces in the ib_uverbs layer.
>>>
>>> Page-in can occur when requester, responder or completer access an MR in
>>> order to process RDMA operations. If they find that the pages being
>>> accessed are not present on physical memory or requisite permissions are
>>> not set on the pages, they provoke page fault to make the pages present
>>> with proper permissions and at the same time update the driver page table.
>>> After confirming the presence of the pages, they execute memory access such
>>> as read, write or atomic operations.
>>>
>>> Page-out is triggered by page reclaim or filesystem events (e.g. metadata
>>> update of a file that is being used as an MR). When creating an ODP-enabled
>>> MR, the driver registers an MMU notifier callback. When the kernel issues a
>>> page invalidation notification, the callback is provoked to unmap DMA
>>> addresses and update the driver page table. After that, the kernel releases
>>> the pages.
>>>
>>> [Supported operations]
>>> All traditional operations are supported on RC connection. The new Atomic
>>> write[6] and RDMA Flush[7] operations are not included in this patchset. I
>>> will post them later after this patchset is merged. On UD connection, Send,
>>> Recv, and SRQ-Recv are supported.
>>>
>>> [How to test ODP?]
>>> There are only a few resources available for testing. pyverbs testcases in
>>> rdma-core and perftest[8] are recommendable ones. Other than them, the
>>> ibv_rc_pingpong command can also be used for testing. Note that you may
>>> have to build perftest from upstream because old versions do not handle ODP
>>> capabilities correctly.
>>
>> Thanks a lot. I have tested these patches with perftest. Because ODP (On
>> Demand Paging) is a feature, can you also add some testcases into rdma
>> core? So we can use rdma-core to make tests with this feature of rxe.
> 
> I added Read/Write/Atomics tests two years ago.
> Cf. https://github.com/linux-rdma/rdma-core/pull/1229
> 
> Each of ODP testcases causes page invalidation so that RDMA traffic
> access triggers ODP page-in flow.
> 
> Currently, 7 testcases below can pass on rxe ODP v8 implementation.
>    test_odp_rc_atomic_cmp_and_swp
>    test_odp_rc_atomic_fetch_and_add
>    test_odp_rc_mixed_mr
>    test_odp_rc_rdma_read
>    test_odp_rc_rdma_write
>    test_odp_rc_traffic
>    test_odp_ud_traffic
> The rest 11 tests are just skipped because of lack of capabilities.

Thanks. Run rdma-core, the above tests can also work successfully in my 
test environment.
I am fine with this.

Zhu Yanjun

> 
> Please let me know if you have any suggestions for improvement.
> 
> Thanks,
> Daisuke Matsuda
> 
>>
>> That is, add some testcases in run_tests.py, so use run_tests.py to
>> verify this (ODP) feature on rxe.
>>
>> Thanks,
>> Zhu Yanjun
>>
>>>
>>> The latest ODP tree is available from github:
>>> https://github.com/ddmatsu/linux/tree/odp_v8
>>>
>>> [Future work]
>>> My next work is to enable the new Atomic write[6] and RDMA Flush[7]
>>> operations with ODP. After that, I am going to implement the prefetch
>>> feature. It allows applications to trigger page fault using
>>> ibv_advise_mr(3) to optimize performance. Some existing software like
>>> librpma[9] use this feature. Additionally, I think we can also add the
>>> implicit ODP feature in the future.
>>>
>>> [1] Understanding On Demand Paging (ODP)
>>> https://enterprise-support.nvidia.com/s/article/understanding-on-demand-paging--odp-x
>>>
>>> [2] [bug report] blktests srp/002 hang
>>> https://lore.kernel.org/linux-rdma/dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u/T/
>>>
>>> [3] blktests failures with v6.10-rc1 kernel
>>> https://lore.kernel.org/linux-block/wnucs5oboi4flje5yvtea7puvn6zzztcnlrfz3lpzlwgblrxgw@7wvqdzioejgl/
>>>
>>> [4] [00/15] ethernet: Convert from tasklet to BH workqueue
>>> https://patchwork.kernel.org/project/linux-rdma/cover/20240621050525.3720069-1-allen.lkml@gmail.com/
>>>
>>> [5] [PATCH for-next v3 0/7] On-Demand Paging on SoftRoCE
>>> https://lore.kernel.org/lkml/cover.1671772917.git.matsuda-daisuke@fujitsu.com/
>>>
>>> [6] [PATCH v7 0/8] RDMA/rxe: Add atomic write operation
>>> https://lore.kernel.org/linux-rdma/1669905432-14-1-git-send-email-yangx.jy@fujitsu.com/
>>>
>>> [7] [for-next PATCH 00/10] RDMA/rxe: Add RDMA FLUSH operation
>>> https://lore.kernel.org/lkml/20221206130201.30986-1-lizhijian@fujitsu.com/
>>>
>>> [8] linux-rdma/perftest: Infiniband Verbs Performance Tests
>>> https://github.com/linux-rdma/perftest
>>>
>>> [9] librpma: Remote Persistent Memory Access Library
>>> https://github.com/pmem/rpma
>>>
>>> v7->v8:
>>>    1) Dropped the first patch because the same change was made by Bob Pearson.
>>>    cf. https://github.com/torvalds/linux/commit/23bc06af547f2ca3b7d345e09fd8d04575406274
>>>    2) Rebased to 6.12.1-rc2
>>>
>>> v6->v7:
>>>    1) Rebased to 6.6.0
>>>    2) Disabled using hugepages with ODP
>>>    3) Addressed comments on v6 from Jason and Zhu
>>>      cf. https://lore.kernel.org/lkml/cover.1694153251.git.matsuda-daisuke@fujitsu.com/
>>>
>>> v5->v6:
>>>    Fixed the implementation according to Jason's suggestions
>>>      cf. https://lore.kernel.org/all/ZIdFXfDu4IMKE+BQ@nvidia.com/
>>>      cf. https://lore.kernel.org/all/ZIdGU709e1h5h4JJ@nvidia.com/
>>>
>>> v4->v5:
>>>    1) Rebased to 6.4.0-rc2+
>>>    2) Changed to schedule all works on responder and completer to workqueue
>>>
>>> v3->v4:
>>>    1) Re-designed functions that access MRs to use the MR xarray.
>>>    2) Rebased onto the latest jgg-for-next tree.
>>>
>>> v2->v3:
>>>    1) Removed a patch that changes the common ib_uverbs layer.
>>>    2) Re-implemented patches for conversion to workqueue.
>>>    3) Fixed compile errors (happened when CONFIG_INFINIBAND_ON_DEMAND_PAGING=n).
>>>    4) Fixed some functions that returned incorrect errors.
>>>    5) Temporarily disabled ODP for RDMA Flush and Atomic Write.
>>>
>>> v1->v2:
>>>    1) Fixed a crash issue reported by Haris Iqbal.
>>>    2) Tried to make lock patters clearer as pointed out by Romanovsky.
>>>    3) Minor clean ups and fixes.
>>>
>>> Daisuke Matsuda (6):
>>>     RDMA/rxe: Make MR functions accessible from other rxe source code
>>>     RDMA/rxe: Move resp_states definition to rxe_verbs.h
>>>     RDMA/rxe: Add page invalidation support
>>>     RDMA/rxe: Allow registering MRs for On-Demand Paging
>>>     RDMA/rxe: Add support for Send/Recv/Write/Read with ODP
>>>     RDMA/rxe: Add support for the traditional Atomic operations with ODP
>>>
>>>    drivers/infiniband/sw/rxe/Makefile    |   2 +
>>>    drivers/infiniband/sw/rxe/rxe.c       |  18 ++
>>>    drivers/infiniband/sw/rxe/rxe.h       |  37 ----
>>>    drivers/infiniband/sw/rxe/rxe_loc.h   |  39 ++++
>>>    drivers/infiniband/sw/rxe/rxe_mr.c    |  34 +++-
>>>    drivers/infiniband/sw/rxe/rxe_odp.c   | 282 ++++++++++++++++++++++++++
>>>    drivers/infiniband/sw/rxe/rxe_resp.c  |  18 +-
>>>    drivers/infiniband/sw/rxe/rxe_verbs.c |   5 +-
>>>    drivers/infiniband/sw/rxe/rxe_verbs.h |  37 ++++
>>>    9 files changed, 419 insertions(+), 53 deletions(-)
>>>    create mode 100644 drivers/infiniband/sw/rxe/rxe_odp.c
>>>
> 


