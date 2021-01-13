Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5452F41D6
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Jan 2021 03:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbhAMCfA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Jan 2021 21:35:00 -0500
Received: from mga03.intel.com ([134.134.136.65]:55921 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbhAMCfA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 Jan 2021 21:35:00 -0500
IronPort-SDR: xJTnh9IvksdXGxIjk6pqYyluxLfdPHH93E6V94u8CSgbr0iGjGXLciYnrHXE1YzrF3ufofeAV5
 9poT4qThxMaA==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="178231294"
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400"; 
   d="scan'208";a="178231294"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 18:33:12 -0800
IronPort-SDR: s7v1FpbpicY6sME/vNknGfTQibWs3l6WIqZx2K0/Oa/aCxLRN/wxWaqUkou7o+If7RAA2c/8GB
 rTBwM25tcZ6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400"; 
   d="scan'208";a="464743721"
Received: from allen-box.sh.intel.com (HELO [10.239.159.28]) ([10.239.159.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jan 2021 18:33:10 -0800
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-rdma <linux-rdma@vger.kernel.org>, logang@deltatee.com,
        hch@lst.de, murphyt7@tcd.ie, robin.murphy@arm.com
Subject: Re: performance regression noted in v5.11-rc after c062db039f40
To:     Will Deacon <will@kernel.org>, Chuck Lever <chuck.lever@oracle.com>
References: <D81314ED-5673-44A6-B597-090E3CB83EB0@oracle.com>
 <20210112143819.GA9689@willie-the-truck>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <dfd84bd8-37b3-0f7c-6f38-68f68e8f5b0f@linux.intel.com>
Date:   Wed, 13 Jan 2021 10:25:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210112143819.GA9689@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

On 1/12/21 10:38 PM, Will Deacon wrote:
> [Expanding cc list to include DMA-IOMMU and intel IOMMU folks]
> 
> On Fri, Jan 08, 2021 at 04:18:36PM -0500, Chuck Lever wrote:
>> Hi-
>>
>> [ Please cc: me on replies, I'm not currently subscribed to
>> iommu@lists ].
>>
>> I'm running NFS performance tests on InfiniBand using CX-3 Pro cards
>> at 56Gb/s. The test is iozone on an NFSv3/RDMA mount:
>>
>> /home/cel/bin/iozone -M -+u -i0 -i1 -s1g -r256k -t12 -I
>>
>> For those not familiar with the way storage protocols use RDMA, The
>> initiator/client sets up memory regions and the target/server uses
>> RDMA Read and Write to move data out of and into those regions. The
>> initiator/client uses only RDMA memory registration and invalidation
>> operations, and the target/server uses RDMA Read and Write.
>>
>> My NFS client is a two-socket 12-core x86_64 system with its I/O MMU
>> enabled using the kernel command line options "intel_iommu=on
>> iommu=strict".
>>
>> Recently I've noticed a significant (25-30%) loss in NFS throughput.
>> I was able to bisect on my client to the following commits.
>>
>> Here's 65f746e8285f ("iommu: Add quirk for Intel graphic devices in
>> map_sg"). This is about normal for this test.
>>
>> 	Children see throughput for 12 initial writers 	= 4732581.09 kB/sec
>>   	Parent sees throughput for 12 initial writers 	= 4646810.21 kB/sec
>>   	Min throughput per process 			=  387764.34 kB/sec
>>   	Max throughput per process 			=  399655.47 kB/sec
>>   	Avg throughput per process 			=  394381.76 kB/sec
>>   	Min xfer 					= 1017344.00 kB
>>   	CPU Utilization: Wall time    2.671    CPU time    1.974    CPU utilization  73.89 %
>>   	Children see throughput for 12 rewriters 	= 4837741.94 kB/sec
>>   	Parent sees throughput for 12 rewriters 	= 4833509.35 kB/sec
>>   	Min throughput per process 			=  398983.72 kB/sec
>>   	Max throughput per process 			=  406199.66 kB/sec
>>   	Avg throughput per process 			=  403145.16 kB/sec
>>   	Min xfer 					= 1030656.00 kB
>>   	CPU utilization: Wall time    2.584    CPU time    1.959    CPU utilization  75.82 %
>>   	Children see throughput for 12 readers 		= 5921370.94 kB/sec
>>   	Parent sees throughput for 12 readers 		= 5914106.69 kB/sec
>>   	Min throughput per process 			=  491812.38 kB/sec
>>   	Max throughput per process 			=  494777.28 kB/sec
>>   	Avg throughput per process 			=  493447.58 kB/sec
>>   	Min xfer 					= 1042688.00 kB
>>   	CPU utilization: Wall time    2.122    CPU time    1.968    CPU utilization  92.75 %
>>   	Children see throughput for 12 re-readers 	= 5947985.69 kB/sec
>>   	Parent sees throughput for 12 re-readers 	= 5941348.51 kB/sec
>>   	Min throughput per process 			=  492805.81 kB/sec
>>   	Max throughput per process 			=  497280.19 kB/sec
>>   	Avg throughput per process 			=  495665.47 kB/sec
>>   	Min xfer 					= 1039360.00 kB
>>   	CPU utilization: Wall time    2.111    CPU time    1.968    CPU utilization  93.22 %
>>
>> Here's c062db039f40 ("iommu/vt-d: Update domain geometry in
>> iommu_ops.at(de)tach_dev"). It's losing some steam here.
>>
>> 	Children see throughput for 12 initial writers 	= 4342419.12 kB/sec
>>   	Parent sees throughput for 12 initial writers 	= 4310612.79 kB/sec
>>   	Min throughput per process 			=  359299.06 kB/sec
>>   	Max throughput per process 			=  363866.16 kB/sec
>>   	Avg throughput per process 			=  361868.26 kB/sec
>>   	Min xfer 					= 1035520.00 kB
>>   	CPU Utilization: Wall time    2.902    CPU time    1.951    CPU utilization  67.22 %
>>   	Children see throughput for 12 rewriters 	= 4408576.66 kB/sec
>>   	Parent sees throughput for 12 rewriters 	= 4404280.87 kB/sec
>>   	Min throughput per process 			=  364553.88 kB/sec
>>   	Max throughput per process 			=  370029.28 kB/sec
>>   	Avg throughput per process 			=  367381.39 kB/sec
>>   	Min xfer 					= 1033216.00 kB
>>   	CPU utilization: Wall time    2.836    CPU time    1.956    CPU utilization  68.97 %
>>   	Children see throughput for 12 readers 		= 5406879.47 kB/sec
>>   	Parent sees throughput for 12 readers 		= 5401862.78 kB/sec
>>   	Min throughput per process 			=  449583.03 kB/sec
>>   	Max throughput per process 			=  451761.69 kB/sec
>>   	Avg throughput per process 			=  450573.29 kB/sec
>>   	Min xfer 					= 1044224.00 kB
>>   	CPU utilization: Wall time    2.323    CPU time    1.977    CPU utilization  85.12 %
>>   	Children see throughput for 12 re-readers 	= 5410601.12 kB/sec
>>   	Parent sees throughput for 12 re-readers 	= 5403504.40 kB/sec
>>   	Min throughput per process 			=  449918.12 kB/sec
>>   	Max throughput per process 			=  452489.28 kB/sec
>>   	Avg throughput per process 			=  450883.43 kB/sec
>>   	Min xfer 					= 1043456.00 kB
>>   	CPU utilization: Wall time    2.321    CPU time    1.978    CPU utilization  85.21 %
>>
>> And here's c588072bba6b ("iommu/vt-d: Convert intel iommu driver to
>> the iommu ops"). Significant throughput loss.
>>
>> 	Children see throughput for 12 initial writers 	= 3812036.91 kB/sec
>>   	Parent sees throughput for 12 initial writers 	= 3753683.40 kB/sec
>>   	Min throughput per process 			=  313672.25 kB/sec
>>   	Max throughput per process 			=  321719.44 kB/sec
>>   	Avg throughput per process 			=  317669.74 kB/sec
>>   	Min xfer 					= 1022464.00 kB
>>   	CPU Utilization: Wall time    3.309    CPU time    1.986    CPU utilization  60.02 %
>>   	Children see throughput for 12 rewriters 	= 3786831.94 kB/sec
>>   	Parent sees throughput for 12 rewriters 	= 3783205.58 kB/sec
>>   	Min throughput per process 			=  313654.44 kB/sec
>>   	Max throughput per process 			=  317844.50 kB/sec
>>   	Avg throughput per process 			=  315569.33 kB/sec
>>   	Min xfer 					= 1035520.00 kB
>>   	CPU utilization: Wall time    3.302    CPU time    1.945    CPU utilization  58.90 %
>>   	Children see throughput for 12 readers 		= 4265828.28 kB/sec
>>   	Parent sees throughput for 12 readers 		= 4261844.88 kB/sec
>>   	Min throughput per process 			=  352305.00 kB/sec
>>   	Max throughput per process 			=  357726.22 kB/sec
>>   	Avg throughput per process 			=  355485.69 kB/sec
>>   	Min xfer 					= 1032960.00 kB
>>   	CPU utilization: Wall time    2.934    CPU time    1.942    CPU utilization  66.20 %
>>   	Children see throughput for 12 re-readers 	= 4220651.19 kB/sec
>>   	Parent sees throughput for 12 re-readers 	= 4216096.04 kB/sec
>>   	Min throughput per process 			=  348677.16 kB/sec
>>   	Max throughput per process 			=  353467.44 kB/sec
>>   	Avg throughput per process 			=  351720.93 kB/sec
>>   	Min xfer 					= 1035264.00 kB
>>   	CPU utilization: Wall time    2.969    CPU time    1.952    CPU utilization  65.74 %
>>
>> The regression appears to be 100% reproducible.

The commit 65f746e8285f ("iommu: Add quirk for Intel graphic devices in
map_sg") is a temporary workaround. We have reverted it recently (5.11-
rc3). Can you please try the a kernel version after -rc3?

Best regards,
baolu
