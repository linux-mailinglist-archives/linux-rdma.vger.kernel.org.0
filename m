Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2692A2FA85D
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jan 2021 19:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407368AbhARSCd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 13:02:33 -0500
Received: from foss.arm.com ([217.140.110.172]:40346 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406494AbhARSBb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 18 Jan 2021 13:01:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC6A931B;
        Mon, 18 Jan 2021 10:00:44 -0800 (PST)
Received: from [10.57.39.58] (unknown [10.57.39.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 420153F719;
        Mon, 18 Jan 2021 10:00:43 -0800 (PST)
Subject: Re: performance regression noted in v5.11-rc after c062db039f40
To:     Chuck Lever <chuck.lever@oracle.com>,
        iommu@lists.linux-foundation.org
Cc:     Will Deacon <will@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, logang@deltatee.com,
        Christoph Hellwig <hch@lst.de>, murphyt7@tcd.ie
References: <D81314ED-5673-44A6-B597-090E3CB83EB0@oracle.com>
 <20210112143819.GA9689@willie-the-truck>
 <607648D8-BF0C-40D6-9B43-2359F45EE74C@oracle.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e83eed0d-82cd-c9be-cef1-5fe771de975f@arm.com>
Date:   Mon, 18 Jan 2021 18:00:43 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <607648D8-BF0C-40D6-9B43-2359F45EE74C@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021-01-18 16:18, Chuck Lever wrote:
> 
> 
>> On Jan 12, 2021, at 9:38 AM, Will Deacon <will@kernel.org> wrote:
>>
>> [Expanding cc list to include DMA-IOMMU and intel IOMMU folks]
>>
>> On Fri, Jan 08, 2021 at 04:18:36PM -0500, Chuck Lever wrote:
>>> Hi-
>>>
>>> [ Please cc: me on replies, I'm not currently subscribed to
>>> iommu@lists ].
>>>
>>> I'm running NFS performance tests on InfiniBand using CX-3 Pro cards
>>> at 56Gb/s. The test is iozone on an NFSv3/RDMA mount:
>>>
>>> /home/cel/bin/iozone -M -+u -i0 -i1 -s1g -r256k -t12 -I
>>>
>>> For those not familiar with the way storage protocols use RDMA, The
>>> initiator/client sets up memory regions and the target/server uses
>>> RDMA Read and Write to move data out of and into those regions. The
>>> initiator/client uses only RDMA memory registration and invalidation
>>> operations, and the target/server uses RDMA Read and Write.
>>>
>>> My NFS client is a two-socket 12-core x86_64 system with its I/O MMU
>>> enabled using the kernel command line options "intel_iommu=on
>>> iommu=strict".
>>>
>>> Recently I've noticed a significant (25-30%) loss in NFS throughput.
>>> I was able to bisect on my client to the following commits.
>>>
>>> Here's 65f746e8285f ("iommu: Add quirk for Intel graphic devices in
>>> map_sg"). This is about normal for this test.
>>>
>>> 	Children see throughput for 12 initial writers 	= 4732581.09 kB/sec
>>> 	Parent sees throughput for 12 initial writers 	= 4646810.21 kB/sec
>>> 	Min throughput per process 			=  387764.34 kB/sec
>>> 	Max throughput per process 			=  399655.47 kB/sec
>>> 	Avg throughput per process 			=  394381.76 kB/sec
>>> 	Min xfer 					= 1017344.00 kB
>>> 	CPU Utilization: Wall time    2.671    CPU time    1.974    CPU utilization  73.89 %
>>> 	Children see throughput for 12 rewriters 	= 4837741.94 kB/sec
>>> 	Parent sees throughput for 12 rewriters 	= 4833509.35 kB/sec
>>> 	Min throughput per process 			=  398983.72 kB/sec
>>> 	Max throughput per process 			=  406199.66 kB/sec
>>> 	Avg throughput per process 			=  403145.16 kB/sec
>>> 	Min xfer 					= 1030656.00 kB
>>> 	CPU utilization: Wall time    2.584    CPU time    1.959    CPU utilization  75.82 %
>>> 	Children see throughput for 12 readers 		= 5921370.94 kB/sec
>>> 	Parent sees throughput for 12 readers 		= 5914106.69 kB/sec
>>> 	Min throughput per process 			=  491812.38 kB/sec
>>> 	Max throughput per process 			=  494777.28 kB/sec
>>> 	Avg throughput per process 			=  493447.58 kB/sec
>>> 	Min xfer 					= 1042688.00 kB
>>> 	CPU utilization: Wall time    2.122    CPU time    1.968    CPU utilization  92.75 %
>>> 	Children see throughput for 12 re-readers 	= 5947985.69 kB/sec
>>> 	Parent sees throughput for 12 re-readers 	= 5941348.51 kB/sec
>>> 	Min throughput per process 			=  492805.81 kB/sec
>>> 	Max throughput per process 			=  497280.19 kB/sec
>>> 	Avg throughput per process 			=  495665.47 kB/sec
>>> 	Min xfer 					= 1039360.00 kB
>>> 	CPU utilization: Wall time    2.111    CPU time    1.968    CPU utilization  93.22 %
>>>
>>> Here's c062db039f40 ("iommu/vt-d: Update domain geometry in
>>> iommu_ops.at(de)tach_dev"). It's losing some steam here.
>>>
>>> 	Children see throughput for 12 initial writers 	= 4342419.12 kB/sec
>>> 	Parent sees throughput for 12 initial writers 	= 4310612.79 kB/sec
>>> 	Min throughput per process 			=  359299.06 kB/sec
>>> 	Max throughput per process 			=  363866.16 kB/sec
>>> 	Avg throughput per process 			=  361868.26 kB/sec
>>> 	Min xfer 					= 1035520.00 kB
>>> 	CPU Utilization: Wall time    2.902    CPU time    1.951    CPU utilization  67.22 %
>>> 	Children see throughput for 12 rewriters 	= 4408576.66 kB/sec
>>> 	Parent sees throughput for 12 rewriters 	= 4404280.87 kB/sec
>>> 	Min throughput per process 			=  364553.88 kB/sec
>>> 	Max throughput per process 			=  370029.28 kB/sec
>>> 	Avg throughput per process 			=  367381.39 kB/sec
>>> 	Min xfer 					= 1033216.00 kB
>>> 	CPU utilization: Wall time    2.836    CPU time    1.956    CPU utilization  68.97 %
>>> 	Children see throughput for 12 readers 		= 5406879.47 kB/sec
>>> 	Parent sees throughput for 12 readers 		= 5401862.78 kB/sec
>>> 	Min throughput per process 			=  449583.03 kB/sec
>>> 	Max throughput per process 			=  451761.69 kB/sec
>>> 	Avg throughput per process 			=  450573.29 kB/sec
>>> 	Min xfer 					= 1044224.00 kB
>>> 	CPU utilization: Wall time    2.323    CPU time    1.977    CPU utilization  85.12 %
>>> 	Children see throughput for 12 re-readers 	= 5410601.12 kB/sec
>>> 	Parent sees throughput for 12 re-readers 	= 5403504.40 kB/sec
>>> 	Min throughput per process 			=  449918.12 kB/sec
>>> 	Max throughput per process 			=  452489.28 kB/sec
>>> 	Avg throughput per process 			=  450883.43 kB/sec
>>> 	Min xfer 					= 1043456.00 kB
>>> 	CPU utilization: Wall time    2.321    CPU time    1.978    CPU utilization  85.21 %
>>>
>>> And here's c588072bba6b ("iommu/vt-d: Convert intel iommu driver to
>>> the iommu ops"). Significant throughput loss.
>>>
>>> 	Children see throughput for 12 initial writers 	= 3812036.91 kB/sec
>>> 	Parent sees throughput for 12 initial writers 	= 3753683.40 kB/sec
>>> 	Min throughput per process 			=  313672.25 kB/sec
>>> 	Max throughput per process 			=  321719.44 kB/sec
>>> 	Avg throughput per process 			=  317669.74 kB/sec
>>> 	Min xfer 					= 1022464.00 kB
>>> 	CPU Utilization: Wall time    3.309    CPU time    1.986    CPU utilization  60.02 %
>>> 	Children see throughput for 12 rewriters 	= 3786831.94 kB/sec
>>> 	Parent sees throughput for 12 rewriters 	= 3783205.58 kB/sec
>>> 	Min throughput per process 			=  313654.44 kB/sec
>>> 	Max throughput per process 			=  317844.50 kB/sec
>>> 	Avg throughput per process 			=  315569.33 kB/sec
>>> 	Min xfer 					= 1035520.00 kB
>>> 	CPU utilization: Wall time    3.302    CPU time    1.945    CPU utilization  58.90 %
>>> 	Children see throughput for 12 readers 		= 4265828.28 kB/sec
>>> 	Parent sees throughput for 12 readers 		= 4261844.88 kB/sec
>>> 	Min throughput per process 			=  352305.00 kB/sec
>>> 	Max throughput per process 			=  357726.22 kB/sec
>>> 	Avg throughput per process 			=  355485.69 kB/sec
>>> 	Min xfer 					= 1032960.00 kB
>>> 	CPU utilization: Wall time    2.934    CPU time    1.942    CPU utilization  66.20 %
>>> 	Children see throughput for 12 re-readers 	= 4220651.19 kB/sec
>>> 	Parent sees throughput for 12 re-readers 	= 4216096.04 kB/sec
>>> 	Min throughput per process 			=  348677.16 kB/sec
>>> 	Max throughput per process 			=  353467.44 kB/sec
>>> 	Avg throughput per process 			=  351720.93 kB/sec
>>> 	Min xfer 					= 1035264.00 kB
>>> 	CPU utilization: Wall time    2.969    CPU time    1.952    CPU utilization  65.74 %
>>>
>>> The regression appears to be 100% reproducible.
> 
> Any thoughts?
> 
> How about some tools to try or debugging advice? I don't know where to start.

I'm not familiar enough with VT-D internals or Infiniband to have a clue 
why the middle commit makes any difference (the calculation itself is 
not on a fast path, so AFAICS the worst it could do is change your 
maximum DMA address size from 48/57 bits to 47/56, and that seems 
relatively benign).

With the last commit, though, at least part of it is likely to be the 
unfortunate inevitable overhead of the internal indirection through the 
IOMMU API. There's a coincidental performance-related thread where we've 
already started pondering some ideas in that area[1] (note that Intel is 
the last one to the party here; AMD has been using this path for a 
while, and it's all that arm64 systems have ever known). I'm not sure if 
there's any difference in the strict invalidation behaviour between the 
IOMMU API calls and the old intel_dma_ops, but I suppose that might be 
worth quickly double-checking as well. I guess the main thing would be 
to do some profiling to see where time is being spent in iommu-dma and 
intel-iommu vs. just different parts of intel-iommu before, and whether 
anything in particular stands out beyond the extra call overhead 
currently incurred by iommu_{map,unmap}.

I'm mildly puzzled by your "CPU time" metric remaining more or less 
constant and the utilisation jumping up and down though, or is that only 
counting time in the userspace workload such that spending more time 
busy in the kernel skews it?

Robin.

[1] 
https://lore.kernel.org/linux-iommu/20210112163307.GA1199965@infradead.org/
