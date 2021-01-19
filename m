Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2142FAE59
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jan 2021 02:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbhASBcP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 20:32:15 -0500
Received: from mga05.intel.com ([192.55.52.43]:23492 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729202AbhASBcP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 18 Jan 2021 20:32:15 -0500
IronPort-SDR: trPIllxqoauWYRb8GRKax0QqGt+huMnYp0NPGIUyLPDyB8Kh7ce2C+lMy8731umJRGYcKGCwcr
 lOe9QwrXHMBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9868"; a="263672598"
X-IronPort-AV: E=Sophos;i="5.79,357,1602572400"; 
   d="scan'208";a="263672598"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 17:30:23 -0800
IronPort-SDR: xieIIy1MAjiyB5ACzBHt+gKBxzO+1t0Gd1OijsBdvNjQlWna/U5cEAjLn9dguxRHm0rus/jywJ
 BcQs2UNry+8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,357,1602572400"; 
   d="scan'208";a="466508451"
Received: from allen-box.sh.intel.com (HELO [10.239.159.28]) ([10.239.159.28])
  by fmsmga001.fm.intel.com with ESMTP; 18 Jan 2021 17:30:13 -0800
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        Will Deacon <will@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>, logang@deltatee.com,
        Christoph Hellwig <hch@lst.de>, murphyt7@tcd.ie
Subject: Re: performance regression noted in v5.11-rc after c062db039f40
To:     Chuck Lever <chuck.lever@oracle.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <D81314ED-5673-44A6-B597-090E3CB83EB0@oracle.com>
 <20210112143819.GA9689@willie-the-truck>
 <607648D8-BF0C-40D6-9B43-2359F45EE74C@oracle.com>
 <e83eed0d-82cd-c9be-cef1-5fe771de975f@arm.com>
 <D6B45F88-08B7-41B5-AAD2-BFB374A42874@oracle.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <0f7c344a-00b6-72bc-5c39-c6cdc571211b@linux.intel.com>
Date:   Tue, 19 Jan 2021 09:22:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <D6B45F88-08B7-41B5-AAD2-BFB374A42874@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Chuck,

On 1/19/21 4:09 AM, Chuck Lever wrote:
> 
> 
>> On Jan 18, 2021, at 1:00 PM, Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2021-01-18 16:18, Chuck Lever wrote:
>>>> On Jan 12, 2021, at 9:38 AM, Will Deacon <will@kernel.org> wrote:
>>>>
>>>> [Expanding cc list to include DMA-IOMMU and intel IOMMU folks]
>>>>
>>>> On Fri, Jan 08, 2021 at 04:18:36PM -0500, Chuck Lever wrote:
>>>>> Hi-
>>>>>
>>>>> [ Please cc: me on replies, I'm not currently subscribed to
>>>>> iommu@lists ].
>>>>>
>>>>> I'm running NFS performance tests on InfiniBand using CX-3 Pro cards
>>>>> at 56Gb/s. The test is iozone on an NFSv3/RDMA mount:
>>>>>
>>>>> /home/cel/bin/iozone -M -+u -i0 -i1 -s1g -r256k -t12 -I
>>>>>
>>>>> For those not familiar with the way storage protocols use RDMA, The
>>>>> initiator/client sets up memory regions and the target/server uses
>>>>> RDMA Read and Write to move data out of and into those regions. The
>>>>> initiator/client uses only RDMA memory registration and invalidation
>>>>> operations, and the target/server uses RDMA Read and Write.
>>>>>
>>>>> My NFS client is a two-socket 12-core x86_64 system with its I/O MMU
>>>>> enabled using the kernel command line options "intel_iommu=on
>>>>> iommu=strict".
>>>>>
>>>>> Recently I've noticed a significant (25-30%) loss in NFS throughput.
>>>>> I was able to bisect on my client to the following commits.
>>>>>
>>>>> Here's 65f746e8285f ("iommu: Add quirk for Intel graphic devices in
>>>>> map_sg"). This is about normal for this test.
>>>>>
>>>>> 	Children see throughput for 12 initial writers 	= 4732581.09 kB/sec
>>>>> 	Parent sees throughput for 12 initial writers 	= 4646810.21 kB/sec
>>>>> 	Min throughput per process 			=  387764.34 kB/sec
>>>>> 	Max throughput per process 			=  399655.47 kB/sec
>>>>> 	Avg throughput per process 			=  394381.76 kB/sec
>>>>> 	Min xfer 					= 1017344.00 kB
>>>>> 	CPU Utilization: Wall time    2.671    CPU time    1.974    CPU utilization  73.89 %
>>>>> 	Children see throughput for 12 rewriters 	= 4837741.94 kB/sec
>>>>> 	Parent sees throughput for 12 rewriters 	= 4833509.35 kB/sec
>>>>> 	Min throughput per process 			=  398983.72 kB/sec
>>>>> 	Max throughput per process 			=  406199.66 kB/sec
>>>>> 	Avg throughput per process 			=  403145.16 kB/sec
>>>>> 	Min xfer 					= 1030656.00 kB
>>>>> 	CPU utilization: Wall time    2.584    CPU time    1.959    CPU utilization  75.82 %
>>>>> 	Children see throughput for 12 readers 		= 5921370.94 kB/sec
>>>>> 	Parent sees throughput for 12 readers 		= 5914106.69 kB/sec
>>>>> 	Min throughput per process 			=  491812.38 kB/sec
>>>>> 	Max throughput per process 			=  494777.28 kB/sec
>>>>> 	Avg throughput per process 			=  493447.58 kB/sec
>>>>> 	Min xfer 					= 1042688.00 kB
>>>>> 	CPU utilization: Wall time    2.122    CPU time    1.968    CPU utilization  92.75 %
>>>>> 	Children see throughput for 12 re-readers 	= 5947985.69 kB/sec
>>>>> 	Parent sees throughput for 12 re-readers 	= 5941348.51 kB/sec
>>>>> 	Min throughput per process 			=  492805.81 kB/sec
>>>>> 	Max throughput per process 			=  497280.19 kB/sec
>>>>> 	Avg throughput per process 			=  495665.47 kB/sec
>>>>> 	Min xfer 					= 1039360.00 kB
>>>>> 	CPU utilization: Wall time    2.111    CPU time    1.968    CPU utilization  93.22 %
>>>>>
>>>>> Here's c062db039f40 ("iommu/vt-d: Update domain geometry in
>>>>> iommu_ops.at(de)tach_dev"). It's losing some steam here.
>>>>>
>>>>> 	Children see throughput for 12 initial writers 	= 4342419.12 kB/sec
>>>>> 	Parent sees throughput for 12 initial writers 	= 4310612.79 kB/sec
>>>>> 	Min throughput per process 			=  359299.06 kB/sec
>>>>> 	Max throughput per process 			=  363866.16 kB/sec
>>>>> 	Avg throughput per process 			=  361868.26 kB/sec
>>>>> 	Min xfer 					= 1035520.00 kB
>>>>> 	CPU Utilization: Wall time    2.902    CPU time    1.951    CPU utilization  67.22 %
>>>>> 	Children see throughput for 12 rewriters 	= 4408576.66 kB/sec
>>>>> 	Parent sees throughput for 12 rewriters 	= 4404280.87 kB/sec
>>>>> 	Min throughput per process 			=  364553.88 kB/sec
>>>>> 	Max throughput per process 			=  370029.28 kB/sec
>>>>> 	Avg throughput per process 			=  367381.39 kB/sec
>>>>> 	Min xfer 					= 1033216.00 kB
>>>>> 	CPU utilization: Wall time    2.836    CPU time    1.956    CPU utilization  68.97 %
>>>>> 	Children see throughput for 12 readers 		= 5406879.47 kB/sec
>>>>> 	Parent sees throughput for 12 readers 		= 5401862.78 kB/sec
>>>>> 	Min throughput per process 			=  449583.03 kB/sec
>>>>> 	Max throughput per process 			=  451761.69 kB/sec
>>>>> 	Avg throughput per process 			=  450573.29 kB/sec
>>>>> 	Min xfer 					= 1044224.00 kB
>>>>> 	CPU utilization: Wall time    2.323    CPU time    1.977    CPU utilization  85.12 %
>>>>> 	Children see throughput for 12 re-readers 	= 5410601.12 kB/sec
>>>>> 	Parent sees throughput for 12 re-readers 	= 5403504.40 kB/sec
>>>>> 	Min throughput per process 			=  449918.12 kB/sec
>>>>> 	Max throughput per process 			=  452489.28 kB/sec
>>>>> 	Avg throughput per process 			=  450883.43 kB/sec
>>>>> 	Min xfer 					= 1043456.00 kB
>>>>> 	CPU utilization: Wall time    2.321    CPU time    1.978    CPU utilization  85.21 %
>>>>>
>>>>> And here's c588072bba6b ("iommu/vt-d: Convert intel iommu driver to
>>>>> the iommu ops"). Significant throughput loss.
>>>>>
>>>>> 	Children see throughput for 12 initial writers 	= 3812036.91 kB/sec
>>>>> 	Parent sees throughput for 12 initial writers 	= 3753683.40 kB/sec
>>>>> 	Min throughput per process 			=  313672.25 kB/sec
>>>>> 	Max throughput per process 			=  321719.44 kB/sec
>>>>> 	Avg throughput per process 			=  317669.74 kB/sec
>>>>> 	Min xfer 					= 1022464.00 kB
>>>>> 	CPU Utilization: Wall time    3.309    CPU time    1.986    CPU utilization  60.02 %
>>>>> 	Children see throughput for 12 rewriters 	= 3786831.94 kB/sec
>>>>> 	Parent sees throughput for 12 rewriters 	= 3783205.58 kB/sec
>>>>> 	Min throughput per process 			=  313654.44 kB/sec
>>>>> 	Max throughput per process 			=  317844.50 kB/sec
>>>>> 	Avg throughput per process 			=  315569.33 kB/sec
>>>>> 	Min xfer 					= 1035520.00 kB
>>>>> 	CPU utilization: Wall time    3.302    CPU time    1.945    CPU utilization  58.90 %
>>>>> 	Children see throughput for 12 readers 		= 4265828.28 kB/sec
>>>>> 	Parent sees throughput for 12 readers 		= 4261844.88 kB/sec
>>>>> 	Min throughput per process 			=  352305.00 kB/sec
>>>>> 	Max throughput per process 			=  357726.22 kB/sec
>>>>> 	Avg throughput per process 			=  355485.69 kB/sec
>>>>> 	Min xfer 					= 1032960.00 kB
>>>>> 	CPU utilization: Wall time    2.934    CPU time    1.942    CPU utilization  66.20 %
>>>>> 	Children see throughput for 12 re-readers 	= 4220651.19 kB/sec
>>>>> 	Parent sees throughput for 12 re-readers 	= 4216096.04 kB/sec
>>>>> 	Min throughput per process 			=  348677.16 kB/sec
>>>>> 	Max throughput per process 			=  353467.44 kB/sec
>>>>> 	Avg throughput per process 			=  351720.93 kB/sec
>>>>> 	Min xfer 					= 1035264.00 kB
>>>>> 	CPU utilization: Wall time    2.969    CPU time    1.952    CPU utilization  65.74 %
>>>>>
>>>>> The regression appears to be 100% reproducible.
>>> Any thoughts?
>>> How about some tools to try or debugging advice? I don't know where to start.
>>
>> I'm not familiar enough with VT-D internals or Infiniband to have a clue why the middle commit makes any difference (the calculation itself is not on a fast path, so AFAICS the worst it could do is change your maximum DMA address size from 48/57 bits to 47/56, and that seems relatively benign).
> 
> Thanks for your response. Understood that you are not responding
> about the middle commit (c062db039f40).
> 
> However, that's a pretty small and straightforward change, so I've
> experimented a bit with that. Commenting out the new code there, I
> get some relief:
> 
> 	Children see throughput for 12 initial writers 	= 4266621.62 kB/sec
> 	Parent sees throughput for 12 initial writers 	= 4254756.31 kB/sec
> 	Min throughput per process 			=  354847.75 kB/sec
> 	Max throughput per process 			=  356167.59 kB/sec
> 	Avg throughput per process 			=  355551.80 kB/sec
> 	Min xfer 					= 1044736.00 kB
> 	CPU Utilization: Wall time    2.951    CPU time    1.981    CPU utilization  67.11 %
> 
> 
> 	Children see throughput for 12 rewriters 	= 4314827.34 kB/sec
> 	Parent sees throughput for 12 rewriters 	= 4310347.32 kB/sec
> 	Min throughput per process 			=  358599.72 kB/sec
> 	Max throughput per process 			=  360319.06 kB/sec
> 	Avg throughput per process 			=  359568.95 kB/sec
> 	Min xfer 					= 1043968.00 kB
> 	CPU utilization: Wall time    2.912    CPU time    2.057    CPU utilization  70.62 %
> 
> 
> 	Children see throughput for 12 readers 		= 4614004.47 kB/sec
> 	Parent sees throughput for 12 readers 		= 4609014.68 kB/sec
> 	Min throughput per process 			=  382414.81 kB/sec
> 	Max throughput per process 			=  388519.50 kB/sec
> 	Avg throughput per process 			=  384500.37 kB/sec
> 	Min xfer 					= 1032192.00 kB
> 	CPU utilization: Wall time    2.701    CPU time    1.900    CPU utilization  70.35 %
> 
> 
> 	Children see throughput for 12 re-readers 	= 4653743.81 kB/sec
> 	Parent sees throughput for 12 re-readers 	= 4647155.31 kB/sec
> 	Min throughput per process 			=  384995.69 kB/sec
> 	Max throughput per process 			=  390874.09 kB/sec
> 	Avg throughput per process 			=  387811.98 kB/sec
> 	Min xfer 					= 1032960.00 kB
> 	CPU utilization: Wall time    2.684    CPU time    1.907    CPU utilization  71.06 %
> 
> I instrumented the code to show the "before" and "after" values.
> 
> The value of domain->domain.geometry.aperture_end on my system
> before this commit (and before the c062db039f40 code) is:
> 
> 144,115,188,075,855,871 = 2^57

domain->domain.geometry.aperture_end makes no sense before c062db039f40.

> 
> The c062db039f40 code sets domain->domain.geometry.aperture_end to:
> 
> 281,474,976,710,655 = 2^48

Do you mind posting the cap and ecap of the iommu used by your device?

You can get it via sysfs, for example:

/sys/bus/pci/devices/0000:00:14.0/iommu/intel-iommu# ls
address  cap  domains_supported  domains_used  ecap  version

> 
> Fwiw, this system uses the Intel C612 chipset with Intel(R) Xeon(R)
> E5-2603 v3 @ 1.60GHz CPUs.
> 

Can you please also hack a line of code to check the return value of
iommu_dma_map_sg()?

> 
> My sense is that "CPU time" remains about the same because the problem
> isn't manifesting as an increase in instruction path length. Wall time
> goes up, CPU time stays the same, the ratio of those (ie, utilization)
> drops.

Best regards,
baolu
