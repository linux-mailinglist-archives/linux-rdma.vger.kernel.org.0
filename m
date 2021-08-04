Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4823DFC71
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Aug 2021 10:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbhHDIHO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Aug 2021 04:07:14 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:50022 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236089AbhHDIHN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Aug 2021 04:07:13 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AvB1CAq5mbF3wPcJIFQPXwPTXdLJyesId70hD?=
 =?us-ascii?q?6qkRc20wTiX8ra2TdZsguyMc9wx6ZJhNo7G90cq7MBbhHPxOkOos1N6ZNWGIhI?=
 =?us-ascii?q?LCFvAB0WKN+V3dMhy73utc+IMlSKJmFeD3ZGIQse/KpCW+DPYsqePqzJyV?=
X-IronPort-AV: E=Sophos;i="5.84,293,1620662400"; 
   d="scan'208";a="112378081"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 04 Aug 2021 16:06:59 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id ED6DE4D0D49B;
        Wed,  4 Aug 2021 16:06:53 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 4 Aug 2021 16:06:53 +0800
Received: from [192.168.122.212] (10.167.226.45) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Wed, 4 Aug 2021 16:06:53 +0800
Subject: Re: RDMA/rpma + fsdax(ext4) was broken since 36f30e486d
From:   =?UTF-8?B?TGksIFpoaWppYW4v5p2OIOaZuuWdmg==?= 
        <lizhijian@cn.fujitsu.com>
To:     Yishai Hadas <yishaih@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?WWFuZywgWGlhby/mnagg5pmT?= <yangx.jy@fujitsu.com>
References: <8b2514bb-1d4b-48bb-a666-85e6804fbac0@cn.fujitsu.com>
Message-ID: <68169bc5-075f-8260-eedc-80fdf4b0accd@cn.fujitsu.com>
Date:   Wed, 4 Aug 2021 16:06:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <8b2514bb-1d4b-48bb-a666-85e6804fbac0@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-yoursite-MailScanner-ID: ED6DE4D0D49B.A0A37
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

convert to text and send again

2021/8/4 15:55, Li, Zhijian wrote:
>
> Hey all:
>
> Recently, i reported a issue to rpmahttps://github.com/pmem/rpma/issues/1142
> where we found that the native rpma + fsdax example failed in recent kernel.
>
> Below is the bisect log
>
> [lizhijian@yl linux]$ git bisect log
> git bisect start
> # good: [bbf5c979011a099af5dc76498918ed7df445635b] Linux 5.9
> git bisect good bbf5c979011a099af5dc76498918ed7df445635b
> # bad: [2c85ebc57b3e1817b6ce1a6b703928e113a90442] Linux 5.10
> git bisect bad 2c85ebc57b3e1817b6ce1a6b703928e113a90442
> # good: [4d0e9df5e43dba52d38b251e3b909df8fa1110be] lib, uaccess: add failure injection to usercopy functions
> git bisect good 4d0e9df5e43dba52d38b251e3b909df8fa1110be
> # bad: [6694875ef8045cdb1e6712ee9b68fe08763507d8] ext4: indicate that fast_commit is available via /sys/fs/ext4/feature/...
> git bisect bad 6694875ef8045cdb1e6712ee9b68fe08763507d8
> # good: [14c914fcb515c424177bb6848cc2858ebfe717a8] Merge tag 'wireless-drivers-next-2020-10-02' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next
> git bisect good 14c914fcb515c424177bb6848cc2858ebfe717a8
> # good: [6f78b9acf04fbf9ede7f4265e7282f9fb39d2c8c] Merge tag 'mtd/for-5.10' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux
> git bisect good 6f78b9acf04fbf9ede7f4265e7282f9fb39d2c8c
> # bad: [bbe85027ce8019c73ab99ad1c2603e2dcd1afa49] Merge tag 'xfs-5.10-merge-5' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
> git bisect bad bbe85027ce8019c73ab99ad1c2603e2dcd1afa49
> # bad: [9d9af1007bc08971953ae915d88dc9bb21344b53] Merge tag 'perf-tools-for-v5.10-2020-10-15' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux
> git bisect bad 9d9af1007bc08971953ae915d88dc9bb21344b53
> # good: [21c2fe94abb2abe894e6aabe6b4e84a255c8d339] RDMA/mthca: Combine special QP struct with mthca QP
> git bisect good 21c2fe94abb2abe894e6aabe6b4e84a255c8d339
> # good: [dbaa1b3d9afba3c050d365245a36616ae3f425a7] Merge branch 'perf/urgent' into perf/core
> git bisect good dbaa1b3d9afba3c050d365245a36616ae3f425a7
> # bad: [c7a198c700763ac89abbb166378f546aeb9afb33] RDMA/ucma: Fix use after free in destroy id flow
> git bisect bad c7a198c700763ac89abbb166378f546aeb9afb33
> # bad: [5ce2dced8e95e76ff7439863a118a053a7fc6f91] RDMA/ipoib: Set rtnl_link_ops for ipoib interfaces
> git bisect bad 5ce2dced8e95e76ff7439863a118a053a7fc6f91
> # bad: [a03bfc37d59de316436c46f5691c5a972ed57c82] RDMA/mlx5: Sync device with CPU pages upon ODP MR registration
> git bisect bad a03bfc37d59de316436c46f5691c5a972ed57c82
> # good: [a6f0b08dbaf289c3c57284e16ac8043140f2139b] RDMA/core: Remove ucontext->closing
> git bisect good a6f0b08dbaf289c3c57284e16ac8043140f2139b
> # bad: [36f30e486dce22345c2dd3a3ba439c12cd67f6ba] IB/core: Improve ODP to use hmm_range_fault()
> git bisect bad 36f30e486dce22345c2dd3a3ba439c12cd67f6ba
> # good: [2ee9bf346fbfd1dad0933b9eb3a4c2c0979b633e] RDMA/addr: Fix race with netevent_callback()/rdma_addr_cancel()
> git bisect good 2ee9bf346fbfd1dad0933b9eb3a4c2c0979b633e
> # first bad commit: [36f30e486dce22345c2dd3a3ba439c12cd67f6ba] IB/core: Improve ODP to use hmm_range_fault()
>
> Note: some commit have to apply a extra patch to avoid a kernel panic.
> > git cherry-pick d4c5da5 # dax: Fix stack overflow when mounting fsdax pmem device
>
>
> Thanks
> Li
>
>


