Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20612CB1D6
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Dec 2020 01:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgLBAzY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Dec 2020 19:55:24 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:8948 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727240AbgLBAzX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 1 Dec 2020 19:55:23 -0500
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc6e5d10000>; Wed, 02 Dec 2020 08:54:41 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Dec
 2020 00:54:37 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 2 Dec 2020 00:54:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQq4jt45947yhNOuFHvh9BfOu7igxRiXcsVHTFknr/21nXg/Q44N5rpl0YYqMes6321outRI+xKnYoiI7pQbWbC0UkGjQfV0dZ0FUEtdcsKL1ii+4fzkonQZ6GGBaHMBC1rJtLkap7/uFswY8cNy0dY4RWl2UcXUrURohG3UGkWhq1kjpoRk+GdpY9HQl59ldWPr/JO6O1pc1SsB3Fy0o57tc+//ovZ4Fja3RtHWhQ2Qjl73o+4AU47Wqom8jFWx2/DsFSWz8Ede/VKDV8pFZxhC75W6UXx2qb0O5F/O8nSof6YiXhQ5VyahTKopU764o6qQalzkWvuUo183c9DMQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmVOfaxzaRrLEtPsnkJr3pGTaLlAVslMOxz7oxbms1o=;
 b=HPF+RGxedUIEpGzRI8mFAiq4LoEqHuy1R2v4PwhHsdxeyn+Bml6GWmEomlI36z1lpluqC4naVh4fsI9JqxbFdpee9mK4FTLS/dnNmTqDJxP74hG1anzIaeVaokgSdvvFaiOrS72ovNPqYsEbMgLqlkddnQd4Sr3RWmPp4M0cVCaIESY8GiPAR/+aC0oauA5ym/VWYJ9rdTra+/Nt6oi5PBfUT/2+lVDmp5IIRyA/UJU6EYtdW7GDBtvOT3DMHIV6L36LGvdklPGlLr6QG0AJuMlxqqLbgRFs8aHckc7OBQRhprWAIvVbzE8ZtF567ih72mSp5H+YPrk8Y89uOmhFIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2440.namprd12.prod.outlook.com (2603:10b6:4:b6::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 2 Dec
 2020 00:54:34 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3611.031; Wed, 2 Dec 2020
 00:54:34 +0000
Date:   Tue, 1 Dec 2020 20:54:31 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alok Prasad <palok@marvell.com>
CC:     <dledford@redhat.com>, <michal.kalderon@marvell.com>,
        <ariel.elior@marvell.com>, <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        Igor Russkikh <irusskikh@marvell.com>
Subject: Re: [PATCH v2,for-rc] RDMA/qedr: iWARP invalid(zero) doorbell
 address fix.
Message-ID: <20201202005431.GA1142498@nvidia.com>
References: <20201127163251.14533-1-palok@marvell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201127163251.14533-1-palok@marvell.com>
X-ClientProxiedBy: BL1PR13CA0053.namprd13.prod.outlook.com
 (2603:10b6:208:257::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0053.namprd13.prod.outlook.com (2603:10b6:208:257::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.6 via Frontend Transport; Wed, 2 Dec 2020 00:54:33 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kkGPf-004nDv-W1; Tue, 01 Dec 2020 20:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606870481; bh=JmVOfaxzaRrLEtPsnkJr3pGTaLlAVslMOxz7oxbms1o=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=NqETOjFpLBv58KCGJDtAOuw+gVRIqxZHjJUnZJGMB53fq2q45olgh1WV6f3D1A2QW
         uUqpz1ctO4Wnyz1lyQ4nEDbpfw0rvBDNz4AZjz52wjlEdNdUL3tw2tg8t+EK7pDtUm
         XrAoSaOAZawk/uBAfPgBEuXgXXdPHwp4+12cKlfKNfAq8ZySqLAHa5VXvlvC7Uu77l
         7jL50xwQjgFptI79ghefRwqcpVZmppS6y4n3wZ5Ekq19CIVOnJr6/P6jg7ZoO/0szs
         AhK0mNynkHRyVgt2LywUQR240OwHv4Wiuub87bqzHdrsJbQnNe38KVliaHNVFN28Lk
         rEXYpdXJrI6EQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 27, 2020 at 04:32:51PM +0000, Alok Prasad wrote:
> This patch fixes issue introduced by a previous commit
> where iWARP doorbell address wasn't initialized, causing
> call trace when any RDMA application wants to use this
> interface.
> 
> Below call trace is generated which using rping with the
> iWARP interface.
> 
> ==========================================================
> [  325.698218] Illegal doorbell address: 0000000000000000. Legal range for doorbell addresses is [0000000011431e08..00000000ec3799d3]
> [  325.752691] WARNING: CPU: 11 PID: 11990 at drivers/net/ethernet/qlogic/qed/qed_dev.c:93 qed_db_rec_sanity.isra.12+0x48/0x70 [qed]
> ....
> [  325.807824]  hpsa scsi_transport_sas [last unloaded: crc8]
> [  326.263195] CPU: 11 PID: 11990 Comm: rping Tainted: G S                5.10.0-rc1 #29
> [  326.299616] Hardware name: HP ProLiant DL380 Gen9/ProLiant DL380 Gen9, BIOS P89 01/22/2018
> [  326.337657] RIP: 0010:qed_db_rec_sanity.isra.12+0x48/0x70 [qed]
> ...
> [  326.451186] RSP: 0018:ffffafc28458fa88 EFLAGS: 00010286
> [  326.475309] RAX: 0000000000000000 RBX: ffff8d0d4c620000 RCX: 0000000000000000
> [  326.508079] RDX: ffff8d10afde7d50 RSI: ffff8d10afdd8b40 RDI: ffff8d10afdd8b40
> [  326.540849] RBP: ffffafc28458fe38 R08: 0000000000000003 R09: 0000000000007fff
> [  326.573671] R10: 0000000000000001 R11: ffffafc28458f888 R12: 0000000000000000
> [  326.606521] R13: 0000000000000000 R14: ffff8d0d43ccbbd0 R15: ffff8d0d48dae9c0
> [  326.639406] FS:  00007fbd5267e740(0000) GS:ffff8d10afdc0000(0000) knlGS:0000000000000000
> [  326.677896] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  326.704634] CR2: 00007fbd4f258fb8 CR3: 0000000108d96003 CR4: 00000000001706e0
> [  326.737465] Call Trace:
> [  326.748839]  qed_db_recovery_add+0x6d/0x1f0 [qed]
> [  326.770705]  qedr_create_user_qp+0x57e/0xd30 [qedr]
> [  326.793350]  qedr_create_qp+0x5f3/0xab0 [qedr]
> [  326.813750]  ? lookup_get_idr_uobject.part.12+0x45/0x90 [ib_uverbs]
> [  326.842565]  create_qp+0x45d/0xb30 [ib_uverbs]
> [  326.862998]  ? ib_uverbs_cq_event_handler+0x30/0x30 [ib_uverbs]
> [  326.890237]  ib_uverbs_create_qp+0xb9/0xe0 [ib_uverbs]
> [  326.913855]  ib_uverbs_write+0x3f9/0x570 [ib_uverbs]
> [  326.936679]  ? security_mmap_file+0x62/0xe0
> [  326.955889]  vfs_write+0xb7/0x200
> [  326.971088]  ksys_write+0xaf/0xd0
> [  326.986314]  ? syscall_trace_enter.isra.25+0x152/0x200
> [  327.009948]  do_syscall_64+0x2d/0x40
> [  327.026752]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> ==============================================================
> 
> Fixes: 06e8d1df46ed ("RDMA/qedr: Add support for user mode XRC-SRQ's")
> Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
> Signed-off-by: Igor Russkikh <irusskikh@marvell.com>
> Signed-off-by: Alok Prasad <palok@marvell.com>
> ---
> v2 (from [1]):
>  - Added call trace in commit message.
> [1] https://patchwork.kernel.org/project/linux-rdma/patch/20201127090832.11191-1-palok@marvell.com/
> ---
>  drivers/infiniband/hw/qedr/verbs.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Applied to for-rc, thanks

Jason
