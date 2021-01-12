Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFAD42F3316
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Jan 2021 15:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbhALOjF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Jan 2021 09:39:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:56424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbhALOjF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 Jan 2021 09:39:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E183D20771;
        Tue, 12 Jan 2021 14:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610462304;
        bh=/+TO0V946bI56guDMyc3LjAhDC0JejiP8ooVdPIrl4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=THx5fJ/dkXlArCPNjLkX4O8RcTplr7mtjL0MAAB8Sm4xRTo2VbqTU7XjwYSfvI5oh
         cGHb/HFyOIVXbDuKTV1h6iBgpMJA+3xkgZbZOZTZzIrLSu+0OcsZbzy9skwEjOQAlI
         kTWfE4Ao49KbpXvAnbAGVB9urVfMaZz8aoc9u2if1e0PP1yar7mZeuqwLz6imxqZQx
         J37xzvgvamtULJh6y9RJIBNdi0cDLxES9HR171UWVZg79Y/mtMiZWYKCANTQznnzgp
         TsjlvsDu2tIl2eWy28cmM0Yj5g2YNw/vmO7jw4agWitPcLK+E3E9WCNTIzwItFcfIB
         XyxgjZDqA0SqA==
Date:   Tue, 12 Jan 2021 14:38:19 +0000
From:   Will Deacon <will@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     iommu@lists.linux-foundation.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        baolu.lu@linux.intel.com, logang@deltatee.com, hch@lst.de,
        murphyt7@tcd.ie, robin.murphy@arm.com
Subject: Re: performance regression noted in v5.11-rc after c062db039f40
Message-ID: <20210112143819.GA9689@willie-the-truck>
References: <D81314ED-5673-44A6-B597-090E3CB83EB0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D81314ED-5673-44A6-B597-090E3CB83EB0@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

[Expanding cc list to include DMA-IOMMU and intel IOMMU folks]

On Fri, Jan 08, 2021 at 04:18:36PM -0500, Chuck Lever wrote:
> Hi-
> 
> [ Please cc: me on replies, I'm not currently subscribed to
> iommu@lists ].
> 
> I'm running NFS performance tests on InfiniBand using CX-3 Pro cards
> at 56Gb/s. The test is iozone on an NFSv3/RDMA mount:
> 
> /home/cel/bin/iozone -M -+u -i0 -i1 -s1g -r256k -t12 -I
> 
> For those not familiar with the way storage protocols use RDMA, The
> initiator/client sets up memory regions and the target/server uses
> RDMA Read and Write to move data out of and into those regions. The
> initiator/client uses only RDMA memory registration and invalidation
> operations, and the target/server uses RDMA Read and Write.
> 
> My NFS client is a two-socket 12-core x86_64 system with its I/O MMU
> enabled using the kernel command line options "intel_iommu=on
> iommu=strict".
> 
> Recently I've noticed a significant (25-30%) loss in NFS throughput.
> I was able to bisect on my client to the following commits.
> 
> Here's 65f746e8285f ("iommu: Add quirk for Intel graphic devices in
> map_sg"). This is about normal for this test.
> 
> 	Children see throughput for 12 initial writers 	= 4732581.09 kB/sec
>  	Parent sees throughput for 12 initial writers 	= 4646810.21 kB/sec
>  	Min throughput per process 			=  387764.34 kB/sec
>  	Max throughput per process 			=  399655.47 kB/sec
>  	Avg throughput per process 			=  394381.76 kB/sec
>  	Min xfer 					= 1017344.00 kB
>  	CPU Utilization: Wall time    2.671    CPU time    1.974    CPU utilization  73.89 %
>  	Children see throughput for 12 rewriters 	= 4837741.94 kB/sec
>  	Parent sees throughput for 12 rewriters 	= 4833509.35 kB/sec
>  	Min throughput per process 			=  398983.72 kB/sec
>  	Max throughput per process 			=  406199.66 kB/sec
>  	Avg throughput per process 			=  403145.16 kB/sec
>  	Min xfer 					= 1030656.00 kB
>  	CPU utilization: Wall time    2.584    CPU time    1.959    CPU utilization  75.82 %
>  	Children see throughput for 12 readers 		= 5921370.94 kB/sec
>  	Parent sees throughput for 12 readers 		= 5914106.69 kB/sec
>  	Min throughput per process 			=  491812.38 kB/sec
>  	Max throughput per process 			=  494777.28 kB/sec
>  	Avg throughput per process 			=  493447.58 kB/sec
>  	Min xfer 					= 1042688.00 kB
>  	CPU utilization: Wall time    2.122    CPU time    1.968    CPU utilization  92.75 %
>  	Children see throughput for 12 re-readers 	= 5947985.69 kB/sec
>  	Parent sees throughput for 12 re-readers 	= 5941348.51 kB/sec
>  	Min throughput per process 			=  492805.81 kB/sec
>  	Max throughput per process 			=  497280.19 kB/sec
>  	Avg throughput per process 			=  495665.47 kB/sec
>  	Min xfer 					= 1039360.00 kB
>  	CPU utilization: Wall time    2.111    CPU time    1.968    CPU utilization  93.22 %
> 
> Here's c062db039f40 ("iommu/vt-d: Update domain geometry in
> iommu_ops.at(de)tach_dev"). It's losing some steam here.
> 
> 	Children see throughput for 12 initial writers 	= 4342419.12 kB/sec
>  	Parent sees throughput for 12 initial writers 	= 4310612.79 kB/sec
>  	Min throughput per process 			=  359299.06 kB/sec
>  	Max throughput per process 			=  363866.16 kB/sec
>  	Avg throughput per process 			=  361868.26 kB/sec
>  	Min xfer 					= 1035520.00 kB
>  	CPU Utilization: Wall time    2.902    CPU time    1.951    CPU utilization  67.22 %
>  	Children see throughput for 12 rewriters 	= 4408576.66 kB/sec
>  	Parent sees throughput for 12 rewriters 	= 4404280.87 kB/sec
>  	Min throughput per process 			=  364553.88 kB/sec
>  	Max throughput per process 			=  370029.28 kB/sec
>  	Avg throughput per process 			=  367381.39 kB/sec
>  	Min xfer 					= 1033216.00 kB
>  	CPU utilization: Wall time    2.836    CPU time    1.956    CPU utilization  68.97 %
>  	Children see throughput for 12 readers 		= 5406879.47 kB/sec
>  	Parent sees throughput for 12 readers 		= 5401862.78 kB/sec
>  	Min throughput per process 			=  449583.03 kB/sec
>  	Max throughput per process 			=  451761.69 kB/sec
>  	Avg throughput per process 			=  450573.29 kB/sec
>  	Min xfer 					= 1044224.00 kB
>  	CPU utilization: Wall time    2.323    CPU time    1.977    CPU utilization  85.12 %
>  	Children see throughput for 12 re-readers 	= 5410601.12 kB/sec
>  	Parent sees throughput for 12 re-readers 	= 5403504.40 kB/sec
>  	Min throughput per process 			=  449918.12 kB/sec
>  	Max throughput per process 			=  452489.28 kB/sec
>  	Avg throughput per process 			=  450883.43 kB/sec
>  	Min xfer 					= 1043456.00 kB
>  	CPU utilization: Wall time    2.321    CPU time    1.978    CPU utilization  85.21 %
> 
> And here's c588072bba6b ("iommu/vt-d: Convert intel iommu driver to
> the iommu ops"). Significant throughput loss.
> 
> 	Children see throughput for 12 initial writers 	= 3812036.91 kB/sec
>  	Parent sees throughput for 12 initial writers 	= 3753683.40 kB/sec
>  	Min throughput per process 			=  313672.25 kB/sec
>  	Max throughput per process 			=  321719.44 kB/sec
>  	Avg throughput per process 			=  317669.74 kB/sec
>  	Min xfer 					= 1022464.00 kB
>  	CPU Utilization: Wall time    3.309    CPU time    1.986    CPU utilization  60.02 %
>  	Children see throughput for 12 rewriters 	= 3786831.94 kB/sec
>  	Parent sees throughput for 12 rewriters 	= 3783205.58 kB/sec
>  	Min throughput per process 			=  313654.44 kB/sec
>  	Max throughput per process 			=  317844.50 kB/sec
>  	Avg throughput per process 			=  315569.33 kB/sec
>  	Min xfer 					= 1035520.00 kB
>  	CPU utilization: Wall time    3.302    CPU time    1.945    CPU utilization  58.90 %
>  	Children see throughput for 12 readers 		= 4265828.28 kB/sec
>  	Parent sees throughput for 12 readers 		= 4261844.88 kB/sec
>  	Min throughput per process 			=  352305.00 kB/sec
>  	Max throughput per process 			=  357726.22 kB/sec
>  	Avg throughput per process 			=  355485.69 kB/sec
>  	Min xfer 					= 1032960.00 kB
>  	CPU utilization: Wall time    2.934    CPU time    1.942    CPU utilization  66.20 %
>  	Children see throughput for 12 re-readers 	= 4220651.19 kB/sec
>  	Parent sees throughput for 12 re-readers 	= 4216096.04 kB/sec
>  	Min throughput per process 			=  348677.16 kB/sec
>  	Max throughput per process 			=  353467.44 kB/sec
>  	Avg throughput per process 			=  351720.93 kB/sec
>  	Min xfer 					= 1035264.00 kB
>  	CPU utilization: Wall time    2.969    CPU time    1.952    CPU utilization  65.74 %
> 
> The regression appears to be 100% reproducible. 
> 
> 
> --
> Chuck Lever
> 
> 
> 
