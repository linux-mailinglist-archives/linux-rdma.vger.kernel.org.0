Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260D643420F
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Oct 2021 01:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhJSXai (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Oct 2021 19:30:38 -0400
Received: from mail-dm6nam11on2061.outbound.protection.outlook.com ([40.107.223.61]:43392
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229554AbhJSXai (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 Oct 2021 19:30:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5QNwFLQ2QefVvwu7JQFvcWks2oCep2+/a6Ziu115BKOTM247DM0aU4yRgyoPVakDlHO70TtvJnMms6Q4aNc3JlTtzJLpWq0HK2gk8G7IQdvHHkNqipk35aT9gBEtIDT04QPXQHWUxpsmscg19Xrp6NCpLcs1QCChcFYSXTFod/b3RifmcznkpDj/w+dtC9ZyFSrdoAyu7AMAW+b0PHOyvGvbnwBBCU+x3Xkxcn7QxX1zfUc9PHPYCq8ZjG/QVsAgDgSDaRW+m8o53+v0HX9ONGJpwmAa0ZI5WG5MtgtXIiCEPLxiYPjFe7vIc4FzPYczZz8epIIlXoMfrk+6BQ6Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQrtT2PTm1fv869ckx2PFRCI9W1VV17F7d5SLxpBp+M=;
 b=OfZ0N68bCN2hubqDhypQF5ymen3+uj01dm1CHuG+e9hO5KL/6f2WF9DQBAUxgqQjL0hAcmBg1kaylPxBQRQCuPKJZFrhN527cgWPj3jIoUa7nGOF0qvekwrUS6FTHSQueWuOtz9J0cIRuO7yeAc6/uNTFe4HTL8FXBzRLgRns4lR1Zjag6vHxGx9cWp5JL8T+aLCWkixyoduJ76iHf2Q4Vonyo3YcdjSTrNAH4gdzbvPEaiULe7FTwfScELSWvFVjMypr/J0QRPnRF7ovu25D2aNRUUNsB9tzpwqkVHrfGgkqyKHJDqRDdzgaqcMBisw5QQVLz8ChuUU8Tkbf7Oqzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQrtT2PTm1fv869ckx2PFRCI9W1VV17F7d5SLxpBp+M=;
 b=MCqwS/+BLNmsMZOAeXRdpaRx/UVRKMfv0MPPch5tXiyQONfFMJ68dXxP4ScU+3fqyDcOUXxBuYGujG4DTt5wWn+q1QRQTZahfmxET1Y7cJOY0xadp88LTDk8PbvTRe5KlAi0uWeERRp6U19fAnyc157oHX9UyyaBIP92+oe56O2QInCaQvOU2g5tamtP4DTucbYCRmUJaA26GNk/6OoLyc6oPHlVjPduJJrGloVnr0MIAUFamKhnpMy2negtEoUCR789JHmjOgrQN2+ZVaYAU6u3ACC6St6plWcFECKviKKZTMWEXvDvs0ViQBCL/x8Dmc4srTqNW61IcLxYvC2i4w==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) by
 DM6PR12MB5550.namprd12.prod.outlook.com (2603:10b6:5:1b6::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.16; Tue, 19 Oct 2021 23:28:24 +0000
Received: from DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::3817:44ce:52ad:3c0b]) by DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::3817:44ce:52ad:3c0b%5]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 23:28:24 +0000
Date:   Tue, 19 Oct 2021 20:28:22 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Aharon Landau <aharonl@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH rdma-rc v1] RDMA/mlx5: Don't set desc_size in user mr
Message-ID: <20211019232822.GB4135767@nvidia.com>
References: <a4846a11c9de834663e521770da895007f9f0d30.1634642730.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4846a11c9de834663e521770da895007f9f0d30.1634642730.git.leonro@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0397.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::12) To DM6PR12MB5520.namprd12.prod.outlook.com
 (2603:10b6:5:208::9)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0397.namprd13.prod.outlook.com (2603:10b6:208:2c2::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.8 via Frontend Transport; Tue, 19 Oct 2021 23:28:23 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mcyWs-00HLvN-IH; Tue, 19 Oct 2021 20:28:22 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66b16350-73ac-48d7-7b88-08d9935824fc
X-MS-TrafficTypeDiagnostic: DM6PR12MB5550:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB55501D7233F2FE1116BB4B7DC2BD9@DM6PR12MB5550.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QPPtR41nGLc/vWkWy7s7WHd1NuN3RBqf/RGmkhFBzbzwA8snNWMeK7equBx0LX1geXAgMCMHI/YnnWcudLGMpvCokGkVOEWqK/ldVLeMczUSC6Y3LCvEeqm3gYTvToLdLCfV5xOKFLGVQXmHNuAQ+9dEtduruTp75Rr8mg+9FhCakGeuGGczGrV9jIWahrRbt6igrSc6g61RKDfnal1OrI7TAMqqy+6MFwscCFgp2NEjasNo6RLFi05/avRrG8FyBDEo5vzk4Ag8fzdnID+51Lp+g9hPwEQRt9P0V1w0VGRcS/lTFzro1izlOkEj3EavVYSG6rB74V+m6NXE7sCQ9OWMnfX4W2NifXy6baDjGCacUzNesRJNdN1/F9VI4NOTEH9hufyQvt3yRxBHAhxzfJAH0kiqwhSzLx/OncHRriNm1sqArxLDepqNLaEBJ05gIhhjwWu06nD7QhSYF/PQR6rzQ+Vk5z7z8Fd5ApTHgspsoOODjR2U13+Ys/PC3/Kdrca2BLuCyuKFUmcC3x+0aT7aByXO700qDiSjCXzXj8FBWJFzuhAQr42xccNo4v1lcYXiO46qV7zVXFQK4x5AZ3fiBPn+ITT+zuqYvcRAzWZwfE+yriiM/s1p0PiowLHZnQGUYWvnuONZmaG9apJ5bjqMXEGv4qphcIlbZPSrVNJqkCQUX13AEznLzW2SphctdUG3Sv6kFblRQbEMg5uYjje8ur5LMbOIRcpn7/v2BUg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5520.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(86362001)(966005)(2616005)(107886003)(426003)(9746002)(9786002)(38100700002)(1076003)(36756003)(6916009)(508600001)(5660300002)(66556008)(66476007)(33656002)(8676002)(4326008)(186003)(26005)(8936002)(316002)(66946007)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uB61BfP236zb6sMnKYyAQfeQO3SSq9KxDE//pk9bjdZZLlF2Juv7jrrmbslf?=
 =?us-ascii?Q?eM8Ch8QpUmT9SFl/PjydanBUSaA5fPyexiHvOTnHGSukgeS+7J1VjVix4md6?=
 =?us-ascii?Q?onRKV+u3pjB3kr6wboA/E5D8C/Giq38HrWjOyGjScAt4kt4/0N2ywzqQlJQ+?=
 =?us-ascii?Q?JZXzMMlOT4piloLh6ZIebX44ulwc9DBiK5Q2LE/tHm/VBHfGEyaVjh9D+a6W?=
 =?us-ascii?Q?MXUcungfuWrMaSKBL81Xbrt1mQcHGLYGZ9GfYXa/at6vn4MgI9yzaY8PjNAd?=
 =?us-ascii?Q?4tgNmngafP7Kh4IqkXQGH0mpJ0Y2zuXwZVmQPzfTO2PkrUGOsHcMIZYytgaI?=
 =?us-ascii?Q?G69oTdJeku5t2HxhWsBVuadCwaDJXSYujI5GZR7kT3NjMvwcHk2RXLQeLu/o?=
 =?us-ascii?Q?MFTx+h2ean158soL7o5nd01Ik+a+864Ak2T7KU0EAfVRL5L0vgu14pY8jyRW?=
 =?us-ascii?Q?DrQTWOK5oGt/8QbgC5Mu7uB6kSk6G+ZdcmeVXYwGY2JU2FbIhnkxeMIleQh/?=
 =?us-ascii?Q?DdM749VIke5XYw8vhpvSepH49zqIoPHc5u9cgTQzYCpAw6uDkFTFWbSRaJVn?=
 =?us-ascii?Q?sc0Yh/UquuKAEqV6m4Fcs/WHDu29F1BiFnOiYrTOql7i1wEH/BqIUC0VHpBO?=
 =?us-ascii?Q?HmGFM7dCeGl7RIwFHVVxtXvoddpbgnBDcExbI35FBOElzOlpy8dwtByzl3ZV?=
 =?us-ascii?Q?DKhRLSx8klVmo3Ct8bbuATOx3NFWQw3PmC7YyXP8lBEO4Jzls0m1y0WRQ4BH?=
 =?us-ascii?Q?fF79V18p+atHAbETOF1tDryI3AyjzYeU0+MBo6Jm0O1XNhG8EMEYBWShniA6?=
 =?us-ascii?Q?IsWwuFgtjDxUWDC+wnn3SzLRUKwnrtWKPDxYB7jzaKm4HMUQaNHNTdxlCZxc?=
 =?us-ascii?Q?KgdgnIYZ+nRx0dKc/NPfFk+gvm+macLIFOg64zxYuNTkBZ2tvha11kkxilmI?=
 =?us-ascii?Q?xmMQAhRFdiWZRcN1UMeiS+pMj2zJeAf9Gmb9dzpzIdsjZ1q641vOpVih4q7Y?=
 =?us-ascii?Q?AVN4XbVXNBiAIi/3HmMtcr1PJDsSmFZNG+svcPLbFRYWHrJFRRxLnVbczW4h?=
 =?us-ascii?Q?oRy3SVx2rEqnx3q+jrllhikDzCJtfVqItdvDbAAGD1xdvnKu6hvq++BHpnaP?=
 =?us-ascii?Q?VEUiShm96BFA7siFnwNodvj++fBfZht95zp56W1837C5gPsS3aq96B5HGH9F?=
 =?us-ascii?Q?wIW0098zbSpK9wDuLoh/2LJT887bRA/0z8w0uUzxPROMLsdhcmeowEsAwlav?=
 =?us-ascii?Q?SQEGVNAKVtv/sHKxprF12R5XeYyac17uA0g+EuR668BRhktPmbQVAEzsivfr?=
 =?us-ascii?Q?QeRwWix2xYQ0RKwnNgOGhJCq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b16350-73ac-48d7-7b88-08d9935824fc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5520.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 23:28:23.8638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BhI9cMCActoWNNZP33WLXL1/c9RI6SW7wjcEb0gxtPK/nuB+mrQzOI6IxMAD7Ehg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5550
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 19, 2021 at 02:30:10PM +0300, Leon Romanovsky wrote:
> From: Aharon Landau <aharonl@nvidia.com>
> 
> reg_create() is used for user MRs only and should not set desc_size at
> all. Attempt to set it causes to the following trace:
> 
> BUG: unable to handle page fault for address: 0000000800000000
> PGD 0 P4D 0
> Oops: 0000 [#1] SMP PTI
> CPU: 5 PID: 890 Comm: ib_write_bw Not tainted 5.15.0-rc4+ #47
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> RIP: 0010:mlx5_ib_dereg_mr+0x14/0x3b0 [mlx5_ib]
> Code: 48 63 cd 4c 89 f7 48 89 0c 24 e8 37 30 03 e1 48 8b 0c 24 eb a0 90 0f 1f 44 00 00 41 56 41 55 41 54 55 53 48 89 fb 48 83 ec 30 <48> 8b 2f 65 48 8b 04 25 28 00 00 00 48 89 44 24 28 31 c0 8b 87 c8
> RSP: 0018:ffff88811afa3a60 EFLAGS: 00010286
> RAX: 000000000000001c RBX: 0000000800000000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000800000000
> RBP: 0000000800000000 R08: 0000000000000000 R09: c0000000fffff7ff
> R10: ffff88811afa38f8 R11: ffff88811afa38f0 R12: ffffffffa02c7ac0
> R13: 0000000000000000 R14: ffff88811afa3cd8 R15: ffff88810772fa00
> FS:  00007f47b9080740(0000) GS:ffff88852cd40000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000800000000 CR3: 000000010761e003 CR4: 0000000000370ea0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  mlx5_ib_free_odp_mr+0x95/0xc0 [mlx5_ib]
>  mlx5_ib_dereg_mr+0x128/0x3b0 [mlx5_ib]
>  ib_dereg_mr_user+0x45/0xb0 [ib_core]
>  ? xas_load+0x8/0x80
>  destroy_hw_idr_uobject+0x1a/0x50 [ib_uverbs]
>  uverbs_destroy_uobject+0x2f/0x150 [ib_uverbs]
>  uobj_destroy+0x3c/0x70 [ib_uverbs]
>  ib_uverbs_cmd_verbs+0x467/0xb00 [ib_uverbs]
>  ? uverbs_finalize_object+0x60/0x60 [ib_uverbs]
>  ? ttwu_queue_wakelist+0xa9/0xe0
>  ? pty_write+0x85/0x90
>  ? file_tty_write.isra.33+0x214/0x330
>  ? process_echoes+0x60/0x60
>  ib_uverbs_ioctl+0xa7/0x110 [ib_uverbs]
>  __x64_sys_ioctl+0x10d/0x8e0
>  ? vfs_write+0x17f/0x260
>  do_syscall_64+0x3c/0x80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Fixes: a639e66703ee ("RDMA/mlx5: Zero out ODP related items in the mlx5_ib_mr")
> Signed-off-by: Aharon Landau <aharonl@nvidia.com>
> Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> v1:
>  * Added Jason's hunk to initialize implicit_children.
> v0: https://lore.kernel.org/all/f60a002566ae19014659afe94d7fcb7a10cfb353.1634033956.git.leonro@nvidia.com
> ---
>  drivers/infiniband/hw/mlx5/mr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
