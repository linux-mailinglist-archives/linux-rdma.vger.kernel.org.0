Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F122FFAD8
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Jan 2021 04:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbhAVDKS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 22:10:18 -0500
Received: from mga04.intel.com ([192.55.52.120]:26711 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbhAVDKR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Jan 2021 22:10:17 -0500
IronPort-SDR: I9G1h0vuhc7k77WjRu1lu58gtnJwrZKtldKq44EvbsFj+jrZcj14DHaQfSLq+s18ZsQLHUeRPf
 FDtTFTLFxg6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="176809806"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="176809806"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 19:08:29 -0800
IronPort-SDR: 6CIrpZM9pDecYu2RuY0Xsy9icPJznw6ouOjEA9n1L+XeLhnAEYmCnlyJs7VtOJSbRruB17I5xj
 6Z0BchqHlzqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="467701308"
Received: from allen-box.sh.intel.com (HELO [10.239.159.28]) ([10.239.159.28])
  by fmsmga001.fm.intel.com with ESMTP; 21 Jan 2021 19:08:26 -0800
Cc:     baolu.lu@linux.intel.com,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "logang@deltatee.com" <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
        "murphyt7@tcd.ie" <murphyt7@tcd.ie>, isaacm@codeaurora.org
Subject: Re: performance regression noted in v5.11-rc after c062db039f40
To:     Chuck Lever <chuck.lever@oracle.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <D81314ED-5673-44A6-B597-090E3CB83EB0@oracle.com>
 <20210112143819.GA9689@willie-the-truck>
 <607648D8-BF0C-40D6-9B43-2359F45EE74C@oracle.com>
 <e83eed0d-82cd-c9be-cef1-5fe771de975f@arm.com>
 <3568C74A-A587-4464-8840-24F7A93ABA06@oracle.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <990a7c1e-e8c0-a6a8-f057-03b104cebca3@linux.intel.com>
Date:   Fri, 22 Jan 2021 11:00:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3568C74A-A587-4464-8840-24F7A93ABA06@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

+Isaac

On 1/22/21 3:09 AM, Chuck Lever wrote:
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
>>
>> With the last commit, though, at least part of it is likely to be the unfortunate inevitable overhead of the internal indirection through the IOMMU API. There's a coincidental performance-related thread where we've already started pondering some ideas in that area[1] (note that Intel is the last one to the party here; AMD has been using this path for a while, and it's all that arm64 systems have ever known). I'm not sure if there's any difference in the strict invalidation behaviour between the IOMMU API calls and the old intel_dma_ops, but I suppose that might be worth quickly double-checking as well. I guess the main thing would be to do some profiling to see where time is being spent in iommu-dma and intel-iommu vs. just different parts of intel-iommu before, and whether anything in particular stands out beyond the extra call overhead currently incurred by iommu_{map,unmap}.
> 
> I did a function_graph trace of the above iozone test on a v5.10 NFS
> client and again on v5.11-rc. There is a substantial timing difference
> in dma_map_sg_attrs. Each excerpt below is for DMA-mapping a 120KB set
> of pages that are part of an NFS/RDMA WRITE operation.
> 
> v5.10:
> 
> 1072.028308: funcgraph_entry:                   |  dma_map_sg_attrs() {
> 1072.028308: funcgraph_entry:                   |    intel_map_sg() {
> 1072.028309: funcgraph_entry:                   |      find_domain() {
> 1072.028309: funcgraph_entry:        0.280 us   |        get_domain_info();
> 1072.028310: funcgraph_exit:         0.930 us   |      }
> 1072.028310: funcgraph_entry:        0.360 us   |      domain_get_iommu();
> 1072.028311: funcgraph_entry:                   |      intel_alloc_iova() {
> 1072.028311: funcgraph_entry:                   |        alloc_iova_fast() {
> 1072.028311: funcgraph_entry:        0.375 us   |          _raw_spin_lock_irqsave();
> 1072.028312: funcgraph_entry:        0.285 us   |          __lock_text_start();
> 1072.028313: funcgraph_exit:         1.500 us   |        }
> 1072.028313: funcgraph_exit:         2.052 us   |      }
> 1072.028313: funcgraph_entry:                   |      domain_mapping() {
> 1072.028313: funcgraph_entry:                   |        __domain_mapping() {
> 1072.028314: funcgraph_entry:        0.350 us   |          pfn_to_dma_pte();
> 1072.028315: funcgraph_entry:        0.942 us   |          domain_flush_cache();
> 1072.028316: funcgraph_exit:         2.852 us   |        }
> 1072.028316: funcgraph_entry:        0.275 us   |        iommu_flush_write_buffer();
> 1072.028317: funcgraph_exit:         4.213 us   |      }
> 1072.028318: funcgraph_exit:         9.392 us   |    }
> 1072.028318: funcgraph_exit:       + 10.073 us  |  }
> 1072.028323: xprtrdma_mr_map:      mr.id=115 nents=30 122880@0xe476ca03f1180000:0x18011105 (TO_DEVICE)
> 1072.028323: xprtrdma_chunk_read:  task:63879@5 pos=148 122880@0xe476ca03f1180000:0x18011105 (more)
> 
> 
> v5.11-rc:
> 
> 57.602990: funcgraph_entry:                   |  dma_map_sg_attrs() {
> 57.602990: funcgraph_entry:                   |    iommu_dma_map_sg() {
> 57.602990: funcgraph_entry:        0.285 us   |      iommu_get_dma_domain();
> 57.602991: funcgraph_entry:        0.270 us   |      iommu_dma_deferred_attach();
> 57.602991: funcgraph_entry:                   |      iommu_dma_sync_sg_for_device() {
> 57.602992: funcgraph_entry:        0.268 us   |        dev_is_untrusted();
> 57.602992: funcgraph_exit:         0.815 us   |      }
> 57.602993: funcgraph_entry:        0.267 us   |      dev_is_untrusted();
> 57.602993: funcgraph_entry:                   |      iommu_dma_alloc_iova() {
> 57.602994: funcgraph_entry:                   |        alloc_iova_fast() {
> 57.602994: funcgraph_entry:        0.260 us   |          _raw_spin_lock_irqsave();
> 57.602995: funcgraph_entry:        0.293 us   |          _raw_spin_lock();
> 57.602995: funcgraph_entry:        0.273 us   |          _raw_spin_unlock_irqrestore();
> 57.602996: funcgraph_entry:        1.147 us   |          alloc_iova();
> 57.602997: funcgraph_exit:         3.370 us   |        }
> 57.602997: funcgraph_exit:         3.945 us   |      }
> 57.602998: funcgraph_entry:        0.272 us   |      dma_info_to_prot();
> 57.602998: funcgraph_entry:                   |      iommu_map_sg_atomic() {
> 57.602998: funcgraph_entry:                   |        __iommu_map_sg() {
> 57.602999: funcgraph_entry:        1.733 us   |          __iommu_map();
> 57.603001: funcgraph_entry:        1.642 us   |          __iommu_map();
> 57.603003: funcgraph_entry:        1.638 us   |          __iommu_map();
> 57.603005: funcgraph_entry:        1.645 us   |          __iommu_map();
> 57.603007: funcgraph_entry:        1.630 us   |          __iommu_map();
> 57.603009: funcgraph_entry:        1.770 us   |          __iommu_map();
> 57.603011: funcgraph_entry:        1.730 us   |          __iommu_map();
> 57.603013: funcgraph_entry:        1.633 us   |          __iommu_map();
> 57.603015: funcgraph_entry:        1.605 us   |          __iommu_map();
> 57.603017: funcgraph_entry:        2.847 us   |          __iommu_map();
> 57.603020: funcgraph_entry:        2.847 us   |          __iommu_map();
> 57.603024: funcgraph_entry:        2.955 us   |          __iommu_map();
> 57.603027: funcgraph_entry:        2.928 us   |          __iommu_map();
> 57.603030: funcgraph_entry:        2.933 us   |          __iommu_map();
> 57.603034: funcgraph_entry:        2.943 us   |          __iommu_map();
> 57.603037: funcgraph_entry:        2.928 us   |          __iommu_map();
> 57.603040: funcgraph_entry:        2.857 us   |          __iommu_map();
> 57.603044: funcgraph_entry:        2.953 us   |          __iommu_map();
> 57.603047: funcgraph_entry:        3.023 us   |          __iommu_map();
> 57.603050: funcgraph_entry:        1.645 us   |          __iommu_map();
> 57.603052: funcgraph_exit:       + 53.648 us  |        }
> 57.603052: funcgraph_exit:       + 54.178 us  |      }
> 57.603053: funcgraph_exit:       + 62.953 us  |    }
> 57.603053: funcgraph_exit:       + 63.567 us  |  }
> 57.603059: xprtrdma_mr_map:      task:60@5 mr.id=4 nents=30 122880@0xd79cc0e2f18c0000:0x00010501 (TO_DEVICE)
> 57.603060: xprtrdma_chunk_read:  task:60@5 pos=148 122880@0xd79cc0e2f18c0000:0x00010501 (more)
> 

I kind of believe it's due to the indirect calls. This is also reported
on ARM.

https://lore.kernel.org/linux-iommu/1610376862-927-1-git-send-email-isaacm@codeaurora.org/

Maybe we can try changing indirect calls to static ones to verify this
problem.

Best regards,
baolu
