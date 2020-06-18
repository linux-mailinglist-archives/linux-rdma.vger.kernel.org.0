Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A858A1FF27F
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2020 14:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729943AbgFRM7c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Jun 2020 08:59:32 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:59438 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729945AbgFRM7b (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 18 Jun 2020 08:59:31 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eeb652e0000>; Thu, 18 Jun 2020 20:59:27 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Thu, 18 Jun 2020 05:59:27 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Thu, 18 Jun 2020 05:59:27 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 18 Jun
 2020 12:56:19 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 18 Jun 2020 12:56:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOplJ8hX3zpyhJgJVVvD5APJWGRgA8tRG82aYtbysCrKdxe6Of9c3c0/9sK1AzWzSNdSTMZIxBy9PEsn29xU/0OtmlY8ywU9spEcgANhQzEpqCk+gyJWgAYqmQs5wueo1qfpEd/qgS6AQb/6OVV4vG/2k/CGHRWThs9bOHNakDnBlK54D5zHiU9SvV7maVApEMLDp1Dt9xla4eYEr6Z1d0jQ93MtTI6BX4u7g1o6gB85irIgIG8EPw1vM/Qnu6COvgonQdkMjummzrqvhQqqKR43Cqd9UztodqXRdCA5EJd1aXlmopdqLk4ELTJgsud9d5k0t9QWVokNYZWvF2SELQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zK3csZmYc8cD842rlLVgn0eb6qxS3POb8bgp4bBoSmw=;
 b=MQ0s57jxfVux6/yWLc5sDx3Aqf2ehHj6QBNuWGQs+OxCy54HX55uLKf48zUjh7UWdGiFvoiAqlxlSY2RIiiA0320zhwz7bsI4JA9QvJnWQ6jlVGxyJFIgDm+0lriBcgYwrrA+VdspahjB5rxJThChHmf4y7R0B4bxozlC3NqN6QO5TJuq90h1+8GFfMokQcH/YARxd0AfGn1NvsnQDMqj+GgKYpf1NqeRU/o/sTy/lKQhL5mpuKgqU1tZDBRKH3iBH0x4dLFz4OKq/1OuQdTWbbJ3swIg/QFoshKxecFjGDc1rEQMAAuI4mkXUWyDwB0g9cuRK6RNPJAIB1CBM+lIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1338.namprd12.prod.outlook.com (2603:10b6:3:71::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 12:56:16 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 12:56:16 +0000
Date:   Thu, 18 Jun 2020 09:56:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Mark Zhang <markz@mellanox.com>,
        Haggai Eran <haggaie@mellanox.com>,
        <linux-rdma@vger.kernel.org>, "Maor Gottlieb" <maorg@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA/cma: Protect bind_list and listen_list
 while finding matching cm id
Message-ID: <20200618125613.GA2405869@mellanox.com>
References: <20200616104304.2426081-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200616104304.2426081-1-leon@kernel.org>
X-NVConfidentiality: public
X-ClientProxiedBy: YT1PR01CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Thu, 18 Jun 2020 12:56:15 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jlu5V-00A5tV-QX; Thu, 18 Jun 2020 09:56:13 -0300
X-NVConfidentiality: public
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 326042ea-7f82-40a5-4390-08d81386fc65
X-MS-TrafficTypeDiagnostic: DM5PR12MB1338:
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR12MB1338B2C4173C897D7E994F51C29B0@DM5PR12MB1338.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dUz+OBNqw5ywaSNLCEYxuxzpyJBgtrS/RP5Ow1PyZhzNyfsnkGJPaESOZmn+eQZFuhLuvQX7s38PD2+n67YyA9m8XPZRG2JEQgyHhIaSO48S/2fUj/k1E3a+/HenoiWrVMutSFbX6UEiKa5bnLQzULtiORxyCezU9u11q715AbFPPVjxV+GuT1oauFncm6ZXOMaPdEamgwIwTATbyUHRF+r1IAHjpH1oog/lsgDI0B76oGdp9WlGW4pexu2d4JbjRrC8+GS+tZVm3pvSQha8gb8W6I2Eqd1qF/REH2lLr8bkdVLS5iUcJFIPGTo2Jd5TgynPitZiPG66vHMHiVgLMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(366004)(346002)(396003)(136003)(376002)(4326008)(1076003)(478600001)(426003)(45080400002)(316002)(186003)(26005)(9746002)(54906003)(9786002)(9686003)(6916009)(86362001)(66476007)(8676002)(8936002)(33656002)(36756003)(83380400001)(2906002)(66556008)(66946007)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: t4aUh0T5MtR9UD0a6v9Y7WLI5MCRTvr5nwsQttys4ROZAP5RLfVLDXivByYiFOii2NNfwEYFNuZgzjD8yJ2lqQl1TQqvGfdsVxC/pCkybJY1I/Zax3VNf7oaoSzkVXkpIFqOHc8eAeo3ITAkHsPRfkehzYN6O20DSkg5iwbO3qI1ZQZ00xNZlPFzF3c6kNkRQJjXHcwXV28TYm+WD3jq3STujkXEIF23gOtsrQFXPYOKdOZbxcbACcUDIdGWloTKz/fH5Nu8Xa6paPGnZfsM1TDsFzxvCir6VlQqb8kNwYR8IKlg+5VMzd1tk4tAPVLNr9b9BaizvWwqINzG45cBooAEiNiWYPnxq+OBxf8jYAwaFIJqI2oO6PWCrZb39T6FMw9rPOyQfT84raLCyIIe+8qh1PoFF2zJXCAexzezYN8Lat/kMHctkaxxqa9qtPY6YsDJY1SYeuyEPmwok2zv4scnVSDM6auZKkSPyPOT3/KrC/awzSJVJeAPPRlkF56w
X-MS-Exchange-Transport-Forked: True
X-MS-Exchange-CrossTenant-Network-Message-Id: 326042ea-7f82-40a5-4390-08d81386fc65
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 12:56:16.2290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zkKCqEMSwNHNFX0S5WRg4/xWIh2Am+4N/bdUBCnH1AHEzo0hyJPTA/Z4cwXVeKQe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1338
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592485167; bh=zK3csZmYc8cD842rlLVgn0eb6qxS3POb8bgp4bBoSmw=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-NVConfidentiality:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-NVConfidentiality:
         X-Originating-IP:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-LD-Processed:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-Forefront-PRVS:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:X-MS-Exchange-Transport-Forked:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=Iu5a04Xfq09N/h5ZUtF1aCoeCeIbAUor2YP0Z1xJBcHuj16jatPCbVvdE1EYcqZvM
         IhFRjLoYu5W8CKUid+dWpSYnYKbp0Ntn1kJ7QkfponDaqHbMRuI6YIv1Q4hU54rxjr
         YZiY0ODDTpMT5i9qI04ygAg7jxs7EG52OBXHeJXOCV8ietoUZOH8BUKZRYQk0U0xgv
         MdSxRUiQb76GDiSiDp+Ar+xzPVvtPxse79nzQAuKfzutoQiDMkfzuJD2k47OrxhH4h
         yZ9XNhw759joNOsx6jQP8EO0/Lj4xHhJJVzCT3Z5R5rKLQptUT1nFTrGImYtrLO9zi
         aHvqi7DhkVJ5Q==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 16, 2020 at 01:43:04PM +0300, Leon Romanovsky wrote:
> From: Mark Zhang <markz@mellanox.com>
> 
> Add missing lock when the bind_list and listen_list must be accessed
> with lock. In addition add lockdep asserts to verify that lock is held.
> 
> [14127.352448] general protection fault: 0000 [#1] SMP NOPTI
> [14127.356017] CPU: 226 PID: 126135 Comm: kworker/226:1 Tainted: G OE 4.12.14-150.47-default #1 SLE15
> [14127.363169] Hardware name: Cray Inc. Windom/Windom, BIOS 0.8.7 01-10-2020
> [14127.368545] Workqueue: ib_cm cm_work_handler [ib_cm]
> [14127.373185] task: ffff9c5a60a1d2c0 task.stack: ffffc1d91f554000
> [14127.379151] RIP: 0010:cma_ib_req_handler+0x3f1/0x11b0 [rdma_cm]
> [14127.382316] RSP: 0018:ffffc1d91f557b40 EFLAGS: 00010286
> [14127.385693] RAX: deacffffffffff30 RBX: 0000000000000001 RCX: ffff9c2af5bb6000
> [14127.391431] RDX: 00000000000000a9 RSI: ffff9c5aa4ed2f10 RDI: ffffc1d91f557b08
> [14127.396263] RBP: ffffc1d91f557d90 R08: ffff9c340cc80000 R09: ffff9c2c0f901900
> [14127.401531] R10: 0000000000000000 R11: 0000000000000001 R12: deacffffffffff30
> [14127.410279] R13: ffff9c5a48aeec00 R14: ffffc1d91f557c30 R15: ffff9c5c2eea3688
> [14127.418274] FS: 0000000000000000(0000) GS:ffff9c5c2fa80000(0000) knlGS:0000000000000000
> [14127.427259] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [14127.432108] CR2: 00002b5cc03fa320 CR3: 0000003f8500a000 CR4: 00000000003406e0
> [14127.438461] Call Trace:
> [14127.441557] ? rdma_addr_cancel+0xa0/0xa0 [ib_core]
> [14127.447922] ? cm_process_work+0x28/0x140 [ib_cm]
> [14127.454877] cm_process_work+0x28/0x140 [ib_cm]
> [14127.458933] ? cm_get_bth_pkey.isra.44+0x34/0xa0 [ib_cm]
> [14127.464246] cm_work_handler+0xa06/0x1a6f [ib_cm]
> [14127.470069] ? __switch_to_asm+0x34/0x70
> [14127.477089] ? __switch_to_asm+0x34/0x70
> [14127.484283] ? __switch_to_asm+0x40/0x70
> [14127.491010] ? __switch_to_asm+0x34/0x70
> [14127.495557] ? __switch_to_asm+0x40/0x70
> [14127.498530] ? __switch_to_asm+0x34/0x70
> [14127.502205] ? __switch_to_asm+0x40/0x70
> [14127.508609] ? __switch_to+0x7c/0x4b0
> [14127.512301] ? __switch_to_asm+0x40/0x70
> [14127.516245] ? __switch_to_asm+0x34/0x70
> [14127.518631] process_one_work+0x1da/0x400
> [14127.522672] worker_thread+0x2b/0x3f0
> [14127.527426] ? process_one_work+0x400/0x400
> [14127.534769] kthread+0x118/0x140
> [14127.538181] ? kthread_create_on_node+0x40/0x40
> [14127.544509] ret_from_fork+0x22/0x40
> [14127.548842] Code: 00 66 83 f8 02 0f 84 ca 05 00 00 49 8b 84 24 d0 01 00 00 48 85 c0 0f 84 68 07 00 00 48 2d d0 01
> 00 00 49 89 c4 0f 84 59 07 00 00 <41> 0f b7 44 24 20 49 8b 77 50 66 83 f8 0a 75 9e 49 8b 7c 24 28
> [14127.573512] Modules linked in: squashfs lz4_decompress loop rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace sunrpc fscache 8021q garp mrp stp llc af_packet iscsi_ibft iscsi_boot_sysfs rdma_ucm(OEX) ib_ucm(OEX) rdma_cm(OEX) iw_cm(OEX) configfs ib_ipoib(OEX) ib_cm(OEX) ib_umad(OEX) mlx5_fpga_tools(OEX) mlx4_en(OEX) mlx4_ib(OEX) mlx4_core(OEX) mlx5_ib(OEX) ib_uverbs(OEX) edac_mce_amd kvm_amd ib_core(OEX) kvm irqbypass crc32_pclmul crc32c_intel ghash_clmulni_intel pcbc aesni_intel aes_x86_64 crypto_simd glue_helper cryptd pcspkr mlx5_core(OEX) mlxfw(OEX) devlink vfio_mdev(OEX) igb vfio_iommu_type1 ptp vfio ahci mdev(OEX) libahci xhci_pci pps_core xhci_hcd i2c_algo_bit libata mlx_compat(OEX) ccp dca usbcore i2c_piix4 shpchp pcc_cpufreq acpi_cpufreq button sg scsi_mod efivarfs autofs4
> 
> Fixes: 4c21b5bcef73 ("IB/cma: Add net_dev and private data checks to RDMA CM")
> Signed-off-by: Mark Zhang <markz@mellanox.com>
> Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/cma.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Applied to for-rc, thanks

Jason
