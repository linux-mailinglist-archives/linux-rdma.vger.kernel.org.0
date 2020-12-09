Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D68F2D4B1D
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Dec 2020 20:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgLIT6U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Dec 2020 14:58:20 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8460 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgLIT6U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Dec 2020 14:58:20 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd12c330000>; Wed, 09 Dec 2020 11:57:39 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Dec
 2020 19:57:36 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 9 Dec 2020 19:57:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yi9bes/mWwOfo3M0MX623lwMu7tMM2BC0Jqgk24D4bSEncQdqu0P155hZIosOgYbpHpuZoD74bVCVWm+K8FEXXE0wBQ2tMTRcHujPfc5XyQrlI/PpLRlCE9NLADapaYRQM+roy9wuDtdNzobOv11XpdWRs0Qm7WNCla+nzwl249ybd2uN880gWQb3LML0DRrbkwo3gr4okRGRo0fxXymrCdPBLZdJMsVMwKCMkexWpJh4i4bUiMGliyqKOwoEQJpXojqZu5p8l/ytt18H8h9B6taU/VpzZa6CzwUZZC7DmXVNZvWJE2tQuXSpTj0fyoHROMBjh00qj0v3i2frG+FYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/2quZp/ORDvXME8pnQDN+f6Xk4Ka82FZPz49tWZ0Nw=;
 b=l2gffon9byuhJkCsRr/PVaneO0enACngKd8VPVtrSkEK1eYnco08xgE5ZqJGFLSNVzlvhll2xcTBzUyCQglW8f9DVlMkwmgLwsP2PO+oGToaq3c9r85VzwwN21n4P6Kanj1+UXzFg8nmpqF09yoNYUuT46epBHZCCzUFnzRjtqgKv5/cH3FrjJewj2INmsYkC8MJC8uGQFZt9eSpySHoSDbsJXkgnrcBecWebUhxIkaIS2gIDA8xvF0g4gvOqUpLDAsgO8EWWJiUc/x1sf/j3yJ1T70wewKamyCHNOzCP4YsqcA8Nl8Sl5YQ6j4lWzlEi6wBwhovkH9l2BlD6zPnCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3115.namprd12.prod.outlook.com (2603:10b6:5:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Wed, 9 Dec
 2020 19:57:35 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3632.023; Wed, 9 Dec 2020
 19:57:35 +0000
Date:   Wed, 9 Dec 2020 15:57:33 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Amit Matityahu <mitm@nvidia.com>, <linux-rdma@vger.kernel.org>,
        Maor Gottlieb <maorg@nvidia.com>,
        Sean Hefty <sean.hefty@intel.com>
Subject: Re: [PATCH rdma-next] RDMA/cm: Fix an attempt to use non-valid
 pointer when cleaning timewait
Message-ID: <20201209195733.GA1995814@nvidia.com>
References: <20201204064205.145795-1-leon@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201204064205.145795-1-leon@kernel.org>
X-ClientProxiedBy: BLAPR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:208:32d::9) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BLAPR03CA0034.namprd03.prod.outlook.com (2603:10b6:208:32d::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.23 via Frontend Transport; Wed, 9 Dec 2020 19:57:35 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kn5af-008NEI-Px; Wed, 09 Dec 2020 15:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607543859; bh=DSgMYNeRajZsIbJ+dTOczwnYsJaAglFKdMH0gn+EN8o=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=dmiGq5MO9lDVDw3U/xV8igAiuf8zY5mgsiRi+Oc9odlNIlpnta/Mx/sAXmIcc/bmQ
         Bm9z9wIN7t/mOJOiz/E6ho4P0I0zwhZlirmGEMT74a4z3jXx10mfKQVKSOJCVbxXee
         BUz8h6bnAiSLi1oH11NCjoeBP/qDQRbgGg/emI490tRaSG/KRg6hXiCYrXcYnpn/4o
         /YnBZas+u0NUAS3NSFuAWBJmkVxbvrmW+InrVpOiSFUbfgVxS63rVOgOBOmkHQXlMO
         wwSNuefXIlaY+Wb4MG7fQjM/UixYeA1Eb4kIeafMCfMwteQ61nQ32GCtfZ2HuqR5Kx
         370n7JkqexVnQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 04, 2020 at 08:42:05AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> If cm_create_timewait_info() fails, the timewait_info pointer will contai=
n
> an error value and will be used in cm_remove_remote() later.
>=20
> Nullify the cm_id_priv->timewait_info pointer to prevent it.
>=20
> RDX: 0000000000000120 RSI: 00000000200003c0 RDI: 0000000000000003
> RBP: 00007fe1ffcc0c80 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
> R13: 0000000000000000 R14: 000000000076bf00 R15: 00007ffe9d7d49e0
> general protection fault, probably for non-canonical address 0xdffffc0000=
000024: 0000 [#1] SMP KASAN PTI
> KASAN: null-ptr-deref in range [0=C3=970000000000000120-0=C3=970000000000=
000127]
> CPU: 2 PID: 12446 Comm: syz-executor.3 Not tainted 5.10.0-rc5-5d4c0742a60=
e #27
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-=
gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> RIP: 0010:cm_remove_remote.isra.0+0x24/0=C3=97170 drivers/infiniband/core=
/cm.c:978
>=20
> Code: 84 00 00 00 00 00 41 54 55 53 48 89 fb 48 8d ab 2d 01 00 00 e8 7d b=
f 4b fe 48 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 04 02 48=
 89 ea 83 e2 07 38 d0 7f 08 84 c0 0f 85 fc 00 00 00
> RSP: 0018:ffff888013127918 EFLAGS: 00010006
> RAX: dffffc0000000000 RBX: fffffffffffffff4 RCX: ffffc9000a18b000
> RDX: 0000000000000024 RSI: ffffffff82edc573 RDI: fffffffffffffff4
> RBP: 0000000000000121 R08: 0000000000000001 R09: ffffed1002624f1d
> R10: 0000000000000003 R11: ffffed1002624f1c R12: ffff888107760c70
> R13: ffff888107760c40 R14: fffffffffffffff4 R15: ffff888107760c9c
> FS:  00007fe1ffcc1700(0000) GS:ffff88811a600000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b2ff21000 CR3: 000000010f504001 CR4: 0000000000370ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>=20
> Call Trace:
>  cm_destroy_id+0x189/0=C3=9715b0 drivers/infiniband/core/cm.c:1155
>  cma_connect_ib drivers/infiniband/core/cma.c:4029 [inline]
>  rdma_connect_locked+0x1100/0=C3=9717c0 drivers/infiniband/core/cma.c:410=
7
>  rdma_connect+0x2a/0=C3=9740 drivers/infiniband/core/cma.c:4140
>  ucma_connect+0x277/0=C3=97340 drivers/infiniband/core/ucma.c:1069
>  ucma_write+0x236/0=C3=972f0 drivers/infiniband/core/ucma.c:1724
>  vfs_write+0x220/0=C3=97830 fs/read_write.c:603
>  ksys_write+0x1df/0=C3=97240 fs/read_write.c:658
>  do_syscall_64+0x33/0=C3=9740 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>=20
> RIP: 0033:0=C3=97468899
>=20
> Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
>=20
> RSP: 002b:00007fe1ffcc0c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00000000007415a0 RCX: 0000000000468899
> RDX: 0000000000000120 RSI: 00000000200003c0 RDI: 0000000000000003
> RBP: 00007fe1ffcc0c80 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
> R13: 0000000000000000 R14: 000000000076bf00 R15: 00007ffe9d7d49e0
>=20
> Fixes: a977049dacde ("[PATCH] IB: Add the kernel CM implementation")
> Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
> Reported-by: Amit Matityahu <mitm@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/cm.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied to for-rc, thanks

Jason
