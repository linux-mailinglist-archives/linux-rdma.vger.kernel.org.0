Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB884AF213
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Feb 2022 13:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbiBIMsu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Feb 2022 07:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbiBIMst (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Feb 2022 07:48:49 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E7D8C0613CA
        for <linux-rdma@vger.kernel.org>; Wed,  9 Feb 2022 04:48:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9B88ED1;
        Wed,  9 Feb 2022 04:48:51 -0800 (PST)
Received: from [10.57.70.89] (unknown [10.57.70.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1F5F3F73B;
        Wed,  9 Feb 2022 04:48:50 -0800 (PST)
Message-ID: <4501e9b1-47b4-970d-dfce-325687f64b91@arm.com>
Date:   Wed, 9 Feb 2022 12:48:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Error when running fio against nvme-of rdma target (mlx5 driver)
Content-Language: en-GB
To:     Martin Oliveira <Martin.Oliveira@eideticom.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc:     Kelly Ursenbach <Kelly.Ursenbach@eideticom.com>,
        "Lee, Jason" <jasonlee@lanl.gov>,
        Logan Gunthorpe <Logan.Gunthorpe@eideticom.com>
References: <MW3PR19MB42505C41C2BA3F425A5CB606E42D9@MW3PR19MB4250.namprd19.prod.outlook.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <MW3PR19MB42505C41C2BA3F425A5CB606E42D9@MW3PR19MB4250.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2022-02-09 02:50, Martin Oliveira wrote:
> Hello,
> 
> We have been hitting an error when running IO over our nvme-of setup, using the mlx5 driver and we are wondering if anyone has seen anything similar/has any suggestions.
> 
> Both initiator and target are AMD EPYC 7502 machines connected over RDMA using a Mellanox MT28908. Target has 12 NVMe SSDs which are exposed as a single NVMe fabrics device, one physical SSD per namespace.
> 
> When running an fio job targeting directly the fabrics devices (no filesystem, see script at the end), within a minute or so we start seeing errors like this:
> 
> [  408.368677] mlx5_core 0000:c1:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x002f address=0x24d08000 flags=0x0000]
> [  408.372201] infiniband mlx5_0: mlx5_handle_error_cqe:332:(pid 0): WC error: 4, Message: local protection error
> [  408.380181] infiniband mlx5_0: dump_cqe:272:(pid 0): dump error cqe
> [  408.380187] 00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [  408.380189] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [  408.380191] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [  408.380192] 00000030: 00 00 00 00 a9 00 56 04 00 00 01 e9 00 54 e8 e2
> [  408.380230] nvme nvme15: RECV for CQE 0x00000000ce392ed9 failed with status local protection error (4)
> [  408.380235] nvme nvme15: starting error recovery
> [  408.380238] nvme_ns_head_submit_bio: 726 callbacks suppressed
> [  408.380246] block nvme15n2: no usable path - requeuing I/O
> [  408.380284] block nvme15n5: no usable path - requeuing I/O
> [  408.380298] block nvme15n1: no usable path - requeuing I/O
> [  408.380304] block nvme15n11: no usable path - requeuing I/O
> [  408.380304] block nvme15n11: no usable path - requeuing I/O
> [  408.380330] block nvme15n1: no usable path - requeuing I/O
> [  408.380350] block nvme15n2: no usable path - requeuing I/O
> [  408.380371] block nvme15n6: no usable path - requeuing I/O
> [  408.380377] block nvme15n6: no usable path - requeuing I/O
> [  408.380382] block nvme15n4: no usable path - requeuing I/O
> [  408.380472] mlx5_core 0000:c1:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x002f address=0x24d09000 flags=0x0000]
> [  408.391265] mlx5_core 0000:c1:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x002f address=0x24d0a000 flags=0x0000]
> [  415.125967] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
> [  415.131898] nvmet: ctrl 1 fatal error occurred!
> 
> Occasionally, we've seen the following stack trace:

FWIW this is indicative the scatterlist passed to dma_unmap_sg_attrs() 
was wrong - specifically it looks like an attempt to unmap a region 
that's already unmapped (or was never mapped in the first place). 
Whatever race or data corruption issue is causing that is almost 
certainly happening much earlier, since the IO_PAGE_FAULT logs further 
imply that either some pages have been spuriously unmapped while the 
device was still accessing them, or some DMA address in the scatterlist 
was already bogus by the time it was handed off to the device.

Robin.

> [ 1158.152464] kernel BUG at drivers/iommu/amd/io_pgtable.c:485!
> [ 1158.427696] invalid opcode: 0000 [#1] SMP NOPTI
> [ 1158.432228] CPU: 51 PID: 796 Comm: kworker/51:1H Tainted: P           OE     5.13.0-eid-athena-g6fb4e704d11c-dirty #14
> [ 1158.443867] Hardware name: GIGABYTE R272-Z32-00/MZ32-AR0-00, BIOS R21 10/08/2020
> [ 1158.451252] Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
> [ 1158.456884] RIP: 0010:iommu_v1_unmap_page+0xed/0x100
> [ 1158.461849] Code: 48 8b 45 d0 65 48 33 04 25 28 00 00 00 75 1d 48 83 c4 10 4c 89 f0 5b 41 5c 41 5d 41 5e 41 5f 5d c3 49 8d 46 ff 4c 85 f0 74 d6 <0f> 0b e8 1c 38 46 00 66 66 2e 0f 1f 84 00 00 00 00 00 90 0f 1f 44
> [ 1158.480589] RSP: 0018:ffffabb520587bd0 EFLAGS: 00010206
> [ 1158.485812] RAX: 0001000000061fff RBX: 0000000000100000 RCX: 0000000000000027
> [ 1158.492938] RDX: 0000000030562000 RSI: ffff000000000000 RDI: 0000000000000000
> [ 1158.500071] RBP: ffffabb520587c08 R08: ffffabb520587bd0 R09: 0000000000000000
> [ 1158.507202] R10: 0000000000000001 R11: 000ffffffffff000 R12: ffff9984abd9e318
> [ 1158.514326] R13: ffff9984abd9e310 R14: 0001000000062000 R15: 0001000000000000
> [ 1158.521452] FS:  0000000000000000(0000) GS:ffff99a36c8c0000(0000) knlGS:0000000000000000
> [ 1158.529540] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1158.535286] CR2: 00007f75b04f1000 CR3: 00000001eddd8000 CR4: 0000000000350ee0
> [ 1158.542419] Call Trace:
> [ 1158.544877]  amd_iommu_unmap+0x2c/0x40
> [ 1158.548653]  __iommu_unmap+0xc4/0x170
> [ 1158.552344]  iommu_unmap_fast+0xe/0x10
> [ 1158.556100]  __iommu_dma_unmap+0x85/0x120
> [ 1158.560115]  iommu_dma_unmap_sg+0x95/0x110
> [ 1158.564213]  dma_unmap_sg_attrs+0x42/0x50
> [ 1158.568225]  rdma_rw_ctx_destroy+0x6e/0xc0 [ib_core]
> [ 1158.573201]  nvmet_rdma_rw_ctx_destroy+0xa7/0xc0 [nvmet_rdma]
> [ 1158.578944]  nvmet_rdma_read_data_done+0x5c/0xf0 [nvmet_rdma]
> [ 1158.584683]  __ib_process_cq+0x8e/0x150 [ib_core]
> [ 1158.589398]  ib_cq_poll_work+0x2b/0x80 [ib_core]
> [ 1158.594027]  process_one_work+0x220/0x3c0
> [ 1158.598038]  worker_thread+0x4d/0x3f0
> [ 1158.601696]  kthread+0x114/0x150
> [ 1158.604928]  ? process_one_work+0x3c0/0x3c0
> [ 1158.609114]  ? kthread_park+0x90/0x90
> [ 1158.612783]  ret_from_fork+0x22/0x30
> 
> We first saw this on a 5.13 kernel but could reproduce with 5.17-rc2.
> 
> We found a possibly related bug report [1] that suggested disabling the IOMMU could help, but even after I disabled it (amd_iommu=off iommu=off) I still get errors (nvme IO timeouts). Another thread from 2016[2] suggested that disabling some kernel debug options could workaround the "local protection error" but that didn't help either.
> 
> As far as I can tell, the disks are fine, as running the same fio job targeting the real physical devices works fine.
> 
> Any suggestions are appreciated.
> 
> Thanks,
> Martin
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=210177
> [2]: https://lore.kernel.org/all/6BBFD126-877C-4638-BB91-ABF715E29326@oracle.com/
> 
> fio script:
> [global]
> name=fio-seq-write
> rw=write
> bs=1M
> direct=1
> numjobs=32
> time_based
> group_reporting=1
> runtime=18000
> end_fsync=1
> size=10G
> ioengine=libaio
> iodepth=16
> 
> [file1]
> filename=/dev/nvme0n1
> 
> [file2]
> filename=/dev/nvme0n2
> 
> [file3]
> filename=/dev/nvme0n3
> 
> [file4]
> filename=/dev/nvme0n4
> 
> [file5]
> filename=/dev/nvme0n5
> 
> [file6]
> filename=/dev/nvme0n6
> 
> [file7]
> filename=/dev/nvme0n7
> 
> [file8]
> filename=/dev/nvme0n8
> 
> [file9]
> filename=/dev/nvme0n9
> 
> [file10]
> filename=/dev/nvme0n10
> 
> [file11]
> filename=/dev/nvme0n11
> 
> [file12]
> filename=/dev/nvme0n12
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
