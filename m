Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D79643FF08
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Oct 2021 17:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhJ2PId (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Oct 2021 11:08:33 -0400
Received: from mail-co1nam11on2072.outbound.protection.outlook.com ([40.107.220.72]:44065
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229623AbhJ2PIc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 29 Oct 2021 11:08:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b032+1ObYMgBOiBqrwnz8F7JKs5Zsivwp4CxNDKBcW4eHp4Vuvm8FUZqO9WVnUVKqCbbB9OqSKnZVGpTF7gI5R+VtLRP4foWKCg4tbFT/nHUlV0FGBZE6URfYm3vKpudOdLoKt9WSAdCjko2SqGuifdI0DCla106nFFeNTF5/BEkRp2Ph4cLGRLrA5FmkWrl6JRCYJfm3dv9/8LbCmYi9M0uHVmTJjN4KiIWiELpkgp3GwFp5B/Fo0zkvcyI9KFh5N/hzawh1gJXj0cNFUNCfSjlW9aizTRb0cCY3jZ2Gx1aKPrIPuXZz1gseWWCB8Ywb8HxDGALpQq+Xmzo7ROsrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzJ7HpyjCzSRzCYY/aJ78AOCKa1aeIDaa4Hcpy+AVn4=;
 b=epzgaR8y36tmBfeOLYDuNLuPAvQYudmznECvX3rk3XIdr9P/UbUR/rDYlVCtFicuKxdnRBUB3jIHuAWQtVoRJPPs0MMvG9uP9G5bEhNwc+NUUg3wTITeXu+zzjXdyhwr34AyzzOFBT9xpaelGKMfU+7b22doGYCreKLcJKKIJzyHo70IB/kCgwKsQ4ctmcYZqcPYg04aZR9XPYtfOKL1ToBIjTXyLRqxnm7dtGYzpIfcrIKHYolKZHdr8tQei+T31lbKSc85UkFOBAFMobsINXH1+bZ3rmsb/rkmL2Y5NTWw5YF0X3jFAecqUKkxK2pUAY2bDoR9DSnnTPyaSzWxvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzJ7HpyjCzSRzCYY/aJ78AOCKa1aeIDaa4Hcpy+AVn4=;
 b=mORWz7D6QYnRCACyEL2xqIBztNJEyEKLB2xiWmOkm6nROb+alIxxzxn/S2304OKZwrZN1A6oAN4TFXJtkSJ82fQ4dFflWzolOLnGAjJ8M0qaPrxAVfGXNVVNvRrdT9rs7aHx/+1FdXd+Agpv5IArCmznJK9Gd7F9l5JGLGH71jrj29gAQ+VE24rDRBiQes48Ml6B+qzAisTsW6TNLCHYjATFc1UmxBPI3YSgBFoC6nEuNRJKp+Xk/EaiF12CKOlethYb3fnhzjpNI92GKYjWyNBDZU6s7y0zfrw7/wudynrzPWT5u9PWSTU8U7WNIgwPrIVefxFUckct9Vr05kTPMw==
Authentication-Results: marvell.com; dkim=none (message not signed)
 header.d=none;marvell.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5221.namprd12.prod.outlook.com (2603:10b6:208:30b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 15:06:02 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 15:06:01 +0000
Date:   Fri, 29 Oct 2021 12:06:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alok Prasad <palok@marvell.com>
Cc:     dledford@redhat.com, michal.kalderon@marvell.com,
        ariel.elior@marvell.com, linux-rdma@vger.kernel.org,
        smalin@marvell.com, aelior@marvell.com, alok.prasad7@gmail.com,
        Prabhakar Kushwaha <pkushwaha@marvell.com>
Subject: Re: [v3,for-rc] RDMA/qedr: qedr crash while running rdma-tool
Message-ID: <20211029150600.GA834869@nvidia.com>
References: <20211027184329.18454-1-palok@marvell.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027184329.18454-1-palok@marvell.com>
X-ClientProxiedBy: BL1PR13CA0359.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::34) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0359.namprd13.prod.outlook.com (2603:10b6:208:2c6::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.5 via Frontend Transport; Fri, 29 Oct 2021 15:06:01 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mgTSC-003VCk-18; Fri, 29 Oct 2021 12:06:00 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 560f27ea-d7f3-48b9-ca0a-08d99aed9ec5
X-MS-TrafficTypeDiagnostic: BL1PR12MB5221:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5221AB7D234C9F41D6183F47C2879@BL1PR12MB5221.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3rR+OZJbMuMeg2kJfzUhz+jUWYKnVR0TXa0q0LXmKjgcvILxi60+NX/8fGaQGRnSUZfd5zrxtH5eMV7QiEXXsPPte7qZzxzjjupQ2I5f7SAZiviPniJLUOhKp4ayIxEKeKvwcYSwFoOnzt65f/XnIsUniNU/bYp646qErFXhiIVHted04pEVG07fD1ltR2E6+wo6YZzFqeNIbeGLVMWISp3orlMz0Nm3wcx04xsiP+Wogq52dJQcjc1a2Qjc91Eq7pK2G3W2rfaqXy213Av0+Me/LIQJX1VIHsEjHP/wvZ4eJXxSB7dFaCyCedoYrMqNB31vBC6vKGtYW1ryTx+klSoEE0RDCiXhiIxNMK4JOhP24ptfKPlQsWscN60+Rmj6N5Q1bGlnp6hT5RPjDGzbcvZK3vVMQ5FGPvbIUzem7OZpH8bwjngBCFvkqsBb8rPczey6n4KYBT9YL7yoQD/MpKc7ag1GhCDoKi68+PWmQwt7SNJRZfFL5yxYcrRVQL0GKd2ityPnJ5QAG/Czu2NHUHk37BHCfTVTKslg9RQWnuVwr5BDK7DbpBVz1dknkv1Qb7hTRtNB3XNnLflnVW5HrdLfBaemlYw9jmFHNFYm0BZ6VSZUML1J78m4fSLI0vWm+HdtnnG4s1bABG0sO++8rhHt6aQqMNjfhPysF18rnofiNfCz4J/CBWFg/iAVG6yreOTLJXCbGZgI5Hp295v/ng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(9786002)(83380400001)(1076003)(9746002)(6916009)(4326008)(316002)(38100700002)(508600001)(66556008)(36756003)(186003)(33656002)(2906002)(66946007)(8676002)(26005)(8936002)(2616005)(426003)(66476007)(86362001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?scD9qEl/ixJn+BgRbojrPIICaCXUoBnyXyrGJ/Z1S6QTIzhV1KRppeyRpZWY?=
 =?us-ascii?Q?Yi/3LIbsFt2mj/lHDBZaD+rw1MuxkPnidGbvqgr6F12nLXTJHxevIKuZYCrd?=
 =?us-ascii?Q?KbkWSc9+lXfJI5YxPk/5P6xPNUMsQmY2ySx89lnmrgAjxzKATbB03i7aYSVs?=
 =?us-ascii?Q?l4A26TM0mA1jl/xfbDmdUXUbHhc5dEF1YNX24SCv5OzEu5FCJJ0RrOnYFJYH?=
 =?us-ascii?Q?GH1cZ7oqU9fYxVHoWNCbUdj3zfWjhM8evWF4FzcKenVUi40VSzlyEhkl4kJl?=
 =?us-ascii?Q?91PGE+t0QKR/CZfM7ND3lnfldEWVI/n7o217GfjgEAHfvwn+lhJ/ODfOwUmx?=
 =?us-ascii?Q?ESAXCoSC2CAHwYpwhz77a6Qf7T1oshTFDm5ZzcWIthoLhz8F/aozzNjvlLB+?=
 =?us-ascii?Q?NCDe3Ewcw4D0kpVXL8HXTd6mhBcl3uvly31ZHVazQxTr8oWFpOQ6+PHduqg9?=
 =?us-ascii?Q?bT1XxL52KxA5OdOK2hTzBRx2h+bx/Wtv9X5vPaU6+49Ys8dFuZvjfs4TULe9?=
 =?us-ascii?Q?qY+vSZCKvwFV5qKFf0dIKX/xcgvTcD/Xu2++4EtItU4+bPofEUBrLyAPYpUp?=
 =?us-ascii?Q?5+cJbhMhs/GtT6mRi8FCSq/9HXNh9kuedQyiulqkxcKa8R2aQ5h9TjyUfta2?=
 =?us-ascii?Q?OUr/Vz6rIVFmVhvakzzu3STd5Yn1K3znff6rMyIJ8+yOZR2zhUhtSzAEUtUL?=
 =?us-ascii?Q?K/k/biHkHR4NMO/Ri6L6pLnPTO3aqRnoAuy8v/tRdtk0jdy5bd90KEthRRAM?=
 =?us-ascii?Q?bmfXukoPTYYu0B2CNpeGJbrrZqxZpVmFIX/qeHJS5nhvd6W6ntqm1CdOTCwE?=
 =?us-ascii?Q?cU6jlR/TS0JH9cQrYjhCjGVJlhwSpKuMLTsljwqc1xtzAGkR3S50OT0GqIxx?=
 =?us-ascii?Q?LvHFqF4tHYzpXGWF7kGmJogFXNjgjdtZUK0A/3PeozpSzdqS8H6qvKvNShPS?=
 =?us-ascii?Q?VIftUePmgBW4piwqBX8pKeq5+gqEkIY4ir3vD7KxMk87AyCFLP4JB1R3Uv2H?=
 =?us-ascii?Q?oOj06nA+DzE259POusiNvaAbqaLbHBA1fgNDP0vXVyBXXoXe2EBWy9sw03OI?=
 =?us-ascii?Q?YwFCJ9lLiIkoJp5f5rMXOkMtYc3Qm7y6X5p9xtZno3q2RgX7s+19dNBwKyFj?=
 =?us-ascii?Q?Yt6dOiGj3vSnzGCIYZ9zVbbks3/tULSlZHiSIICpJkc34w1p6w6zedBo8maA?=
 =?us-ascii?Q?4R3PRtfbmc30HuiqMzjarEFtjs+NmRLYECZ2TuLl+LzdPpSZG3iOXN6uENyY?=
 =?us-ascii?Q?psxLuh5/4JOkixCEOpjVIgL51Dfnt+C7HQ5dT6URblvUwbW1uNgMPPAlagQV?=
 =?us-ascii?Q?KS0Q0tBt5f4gpZRfxo12XoLPsok3PzWetIMIwnMPCHCvkWpsZryk8tCf4F2w?=
 =?us-ascii?Q?Fq+6MSYmbedRn3N1L558VukhArrNgGro9lIplHsceXiZAeOVuhKpf2R4NTuW?=
 =?us-ascii?Q?xM/3CT/vYvzd4XuQIHk3lDinJ16DlWa51ofo7sYSX3rVakezDXAFpbSsc8Va?=
 =?us-ascii?Q?nDzTZ5whcSn6dPaqBRhY2Nx3BZOjjSoo8+T37iUUwJ121YIaOXUn52qWMzqs?=
 =?us-ascii?Q?nA0AMlDp2T3yoTnesX4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 560f27ea-d7f3-48b9-ca0a-08d99aed9ec5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 15:06:01.6671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6ssbwsXFxUZ4n134DTWdIFI3tUFY8A3jz3cNSO955ynrlwhKx9Zd24JCyGLr3xS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5221
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 27, 2021 at 06:43:29PM +0000, Alok Prasad wrote:
> This patch fixes crash caused by querying qp.
>     Also corrects the state of gsi qp.
> 
>     Below call trace is generated while using iproute2 utility
>     "rdma res show -dd qp" on rdma interface.
>     ======================================================================
>     [  302.569794] BUG: kernel NULL pointer dereference, address: 0000000000000034
>     ..
>     [  302.570378] Hardware name: Dell Inc. PowerEdge R720/0M1GCR, BIOS 1.2.6 05/10/2012
>     [  302.570500] RIP: 0010:qed_rdma_query_qp+0x33/0x1a0 [qed]
>     [  302.570861] RSP: 0018:ffffba560a08f580 EFLAGS: 00010206
>     [  302.570979] RAX: 0000000200000000 RBX: ffffba560a08f5b8 RCX: 0000000000000000
>     [  302.571100] RDX: ffffba560a08f5b8 RSI: 0000000000000000 RDI: ffff9807ee458090
>     [  302.571221] RBP: ffffba560a08f5a0 R08: 0000000000000000 R09: ffff9807890e7048
>     [  302.571342] R10: ffffba560a08f658 R11: 0000000000000000 R12: 0000000000000000
>     [  302.571462] R13: ffff9807ee458090 R14: ffff9807f0afb000 R15: ffffba560a08f7ec
>     [  302.571583] FS:  00007fbbf8bfe740(0000) GS:ffff980aafa00000(0000) knlGS:0000000000000000
>     [  302.571729] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     [  302.571847] CR2: 0000000000000034 CR3: 00000001720ba001 CR4: 00000000000606f0
>     [  302.571968] Call Trace:
>     [  302.572083]  qedr_query_qp+0x82/0x360 [qedr]
>     [  302.572211]  ib_query_qp+0x34/0x40 [ib_core]
>     [  302.572361]  ? ib_query_qp+0x34/0x40 [ib_core]
>     [  302.572503]  fill_res_qp_entry_query.isra.26+0x47/0x1d0 [ib_core]
>     [  302.572670]  ? __nla_put+0x20/0x30
>     [  302.572788]  ? nla_put+0x33/0x40
>     [  302.572901]  fill_res_qp_entry+0xe3/0x120 [ib_core]
>     [  302.573058]  res_get_common_dumpit+0x3f8/0x5d0 [ib_core]
>     [  302.573213]  ? fill_res_cm_id_entry+0x1f0/0x1f0 [ib_core]
>     [  302.573377]  nldev_res_get_qp_dumpit+0x1a/0x20 [ib_core]
>     [  302.573529]  netlink_dump+0x156/0x2f0
>     [  302.573648]  __netlink_dump_start+0x1ab/0x260
>     [  302.573765]  rdma_nl_rcv+0x1de/0x330 [ib_core]
>     [  302.573918]  ? nldev_res_get_cm_id_dumpit+0x20/0x20 [ib_core]
>     [  302.574074]  netlink_unicast+0x1b8/0x270
>     [  302.574191]  netlink_sendmsg+0x33e/0x470
>     [  302.574307]  sock_sendmsg+0x63/0x70
>     [  302.574421]  __sys_sendto+0x13f/0x180
>     [  302.574536]  ? setup_sgl.isra.12+0x70/0xc0
>     [  302.574655]  __x64_sys_sendto+0x28/0x30
>     [  302.574769]  do_syscall_64+0x3a/0xb0
>     [  302.574884]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>     =====================================================================
> 
> Signed-off-by: Ariel Elior <aelior@marvell.com>
> Signed-off-by: Shai Malin <smalin@marvell.com>
> Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
> Signed-off-by: Alok Prasad <palok@marvell.com>
> ---
>  drivers/infiniband/hw/qedr/verbs.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)

Applied to for-rc, I added a fixes line

Jason
