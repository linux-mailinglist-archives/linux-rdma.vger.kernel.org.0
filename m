Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E081D314490
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Feb 2021 01:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhBIAHI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Feb 2021 19:07:08 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:18595 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhBIAHF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 Feb 2021 19:07:05 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6021d1ff0001>; Mon, 08 Feb 2021 16:06:23 -0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb
 2021 00:06:22 +0000
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb
 2021 00:06:20 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 9 Feb 2021 00:06:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kL2v8gIiRX+PVk8a37y2yUscvH5jjIAgPmHHWjTByrPPos+mwSJH9wm1W7G4/te7ZpMd8PwtfwHtT2UZOg0VGtso1MxYvwdfauuzJMjh0WhgIorK/LkRDcD7+MWBr88FnXj2KPVCEBXm1A8COKZgdByucxFGrIXKkehWm7bGutINuIhPq+ZDSZbdzacQWvp8riq8HSNrHfw0Q7gwb+3V7/M4hhnhRb/6D/pCT0JX6cUIRAvIo/ByyYakZ1WX6qvxZVlBBYZwH50wpi19taQd0BXZChvEV+rMz+XxiJX8sWMt+m0ceFAjlLcFbhoj6R08OFEZfw3dmUiyw0ZHC1I3Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9+G0x4+Wr0PXwVcNJtJ0Ds3Tvd1Tk67ArWc9s+EVHQ=;
 b=e3nFhEvD7q62gWQOG0qzZBEl8p/sB02kocAaQbtq6RUCDTm3b68mUZLfPIe2tMvPVCRkGkfkqrkHbbQRQkWVsb35y+hP/w3W8UoeFWmmB4jH2/7xJs+OGpqgjp5U1cEJ5LRwSTVh1WDeFbIwVzVGviWd4Rhu4YO5jZC+TCbLUuBuDhLkyF0SGo1LbUOxqK+GHuFqDaAgtfKwPN5ptQ24q2X4EYvK/NjWnzHUTmNpUfyHBkzg5TDWZXMHgHTvKOb52rlWX3XwllwAhAkJ2Si7jsfp1FA13K4HJxJf4SkTERA3oGawcLglJPeGDJakIQrAieVK+ud1Wx2p2jBLFFXgIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3020.namprd12.prod.outlook.com (2603:10b6:5:11f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Tue, 9 Feb
 2021 00:06:18 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 00:06:18 +0000
Date:   Mon, 8 Feb 2021 20:06:16 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
CC:     <linux-rdma@vger.kernel.org>, Bernard Metzler <bmt@zurich.ibm.com>,
        "Doug Ledford" <dledford@redhat.com>
Subject: Re: [PATCH for-rc] RDMA/siw: Fix calculation of tx_valid_cpus size
Message-ID: <20210209000616.GA1231095@nvidia.com>
References: <20210201112922.141085-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210201112922.141085-1-kamalheib1@gmail.com>
X-ClientProxiedBy: MN2PR15CA0065.namprd15.prod.outlook.com
 (2603:10b6:208:237::34) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR15CA0065.namprd15.prod.outlook.com (2603:10b6:208:237::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Tue, 9 Feb 2021 00:06:17 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l9GXo-005AHE-CA; Mon, 08 Feb 2021 20:06:16 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612829183; bh=A9+G0x4+Wr0PXwVcNJtJ0Ds3Tvd1Tk67ArWc9s+EVHQ=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=T3ZSsJIeja4PiBZTO148xmai6jXZa2YoVsSihWJCEBG7YQb3Wf0wO8XFTZf8dnHJB
         Lxxatwa3NtlCdDqyC2MSHEfPnDxU1bneuRSRgjs/tR/YnVCLwkEoXbLx6QjyCUhhqc
         bA+AdGqZLL3BTb4A42COK+VYOSF/r5UwTg+s32W0A1O9H6EZL3YciumqZjVEUgiIpB
         APe+8hL+nojqxPGo17Oh8eUGQTEP5eP7dYwwR3txALo8OGihWJPb5lW963BKL8bBs+
         EvGX0byRq2IkdQ5wWkKt/7CUKhEd04FtpgxavMZULsxA6hZ0PMFiNpz7y0veHgEal9
         hRjkv8YGn6gRQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 01, 2021 at 01:29:22PM +0200, Kamal Heib wrote:
> The size of tx_valid_cpus was calculated under the assumption that the
> numa nodes identifiers are continuous, which is not the case in all
> archs as this could lead to the following panic when trying to access an
> invalid tx_valid_cpus index, avoid the following panic by using
> nr_node_ids instead of num_online_nodes() to allocate the tx_valid_cpus
> size.
> 
> Kernel attempted to read user page (8) - exploit attempt? (uid: 0)
> BUG: Kernel NULL pointer dereference on read at 0x00000008
> Faulting instruction address: 0xc0080000081b4a90
> Oops: Kernel access of bad area, sig: 11 [#1]
> LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA PowerNV
> Modules linked in: siw(+) rfkill rpcrdma ib_isert iscsi_target_mod ib_iser libiscsi scsi_transport_iscsi ib_srpt target_core_mod ib_srp scsi_transport_srp ib_ipoib rdma_ucm sunrpc ib_umad rdma_cm ib_cm iw_cm i40iw ib_uverbs ib_core i40e ses enclosure scsi_transport_sas ipmi_powernv ibmpowernv at24 ofpart ipmi_devintf regmap_i2c ipmi_msghandler powernv_flash uio_pdrv_genirq uio mtd opal_prd zram ip_tables xfs libcrc32c sd_mod t10_pi ast i2c_algo_bit drm_vram_helper drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec drm_ttm_helper ttm drm vmx_crypto aacraid drm_panel_orientation_quirks dm_mod
> CPU: 40 PID: 3279 Comm: modprobe Tainted: G        W      X --------- ---  5.11.0-0.rc4.129.eln108.ppc64le #2
> NIP:  c0080000081b4a90 LR: c0080000081b4a2c CTR: c0000000007ce1c0
> REGS: c000000027fa77b0 TRAP: 0300   Tainted: G        W      X --------- ---   (5.11.0-0.rc4.129.eln108.ppc64le)
> MSR:  9000000002009033 <SF,HV,VEC,EE,ME,IR,DR,RI,LE>  CR: 44224882  XER: 00000000
> CFAR: c0000000007ce200 DAR: 0000000000000008 DSISR: 40000000 IRQMASK: 0
> GPR00: c0080000081b4a2c c000000027fa7a50 c0080000081c3900 0000000000000040
> GPR04: c000000002023080 c000000012e1c300 000020072ad70000 0000000000000001
> GPR08: c000000001726068 0000000000000008 0000000000000008 c0080000081b5758
> GPR12: c0000000007ce1c0 c0000007fffc3000 00000001590b1e40 0000000000000000
> GPR16: 0000000000000000 0000000000000001 000000011ad68fc8 00007fffcc09c5c8
> GPR20: 0000000000000008 0000000000000000 00000001590b2850 00000001590b1d30
> GPR24: 0000000000043d68 000000011ad67a80 000000011ad67a80 0000000000100000
> GPR28: c000000012e1c300 c0000000020271c8 0000000000000001 c0080000081bf608
> NIP [c0080000081b4a90] siw_init_cpulist+0x194/0x214 [siw]
> LR [c0080000081b4a2c] siw_init_cpulist+0x130/0x214 [siw]
> Call Trace:
> [c000000027fa7a50] [c0080000081b4a2c] siw_init_cpulist+0x130/0x214 [siw] (unreliable)
> [c000000027fa7a90] [c0080000081b4e68] siw_init_module+0x40/0x2a0 [siw]
> [c000000027fa7b30] [c0000000000124f4] do_one_initcall+0x84/0x2e0
> [c000000027fa7c00] [c000000000267ffc] do_init_module+0x7c/0x350
> [c000000027fa7c90] [c00000000026a180] __do_sys_init_module+0x210/0x250
> [c000000027fa7db0] [c0000000000387e4] system_call_exception+0x134/0x230
> [c000000027fa7e10] [c00000000000d660] system_call_common+0xf0/0x27c
> Instruction dump:
> 40810044 3d420000 e8bf0000 e88a82d0 3d420000 e90a82c8 792a1f24 7cc4302a
> 7d2642aa 79291f24 7d25482a 7d295214 <7d4048a8> 7d4a3b78 7d4049ad 40c2fff4
> ---[ end trace 813d4c362755dcfc ]---
> 
> Fixes: bdcf26bf9b3a ("rdma/siw: network and RDMA core interface")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>
> Tested-by: Yi Zhang <yi.zhang@redhat.com>
> ---
>  drivers/infiniband/sw/siw/siw_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, I think we are done for the -rcs now

Thanks

Jason
