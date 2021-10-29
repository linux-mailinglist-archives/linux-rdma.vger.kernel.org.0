Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88DFA440067
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Oct 2021 18:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhJ2Qet (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Oct 2021 12:34:49 -0400
Received: from mail-mw2nam10on2071.outbound.protection.outlook.com ([40.107.94.71]:61537
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229623AbhJ2Qeq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 29 Oct 2021 12:34:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chltYDcMlwFSBFH57a2PkC82/qhqtDBw/ztdJ+8d/y5V/j616rcjMFuXMN+880OkOSlF8odAYz6sPqr1PjO4mBWnSjguNslX9AvtYdaXLoVVeZmhp/QHWFtgEQQZ6gAWgq3PV/ys4MbJLfO4i7oyHyHwmorL0mGvNsiVND1B2Sm6U3oxdv1tPfpaJTyKrfovyLfC8s8YGHPLgQWThX9aCXZxq8/kD8lwNKAt/scP21B+tHZpfssVwrcZ3Q6OU5+CpQmAhot444Tqawj4bE8umdZLse073TM7nDZ9hlFuHq82wTytz3jSBXj/HLxBLRQwAdFDf36AlQz9/CT3xKEfxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHpbADW1SE60UaMfZy80JipG8HApmiguittAm3x1HHM=;
 b=OSEjnsMuNoSruLrchtXg3YwfXdd3pLP61DSY1i5qMaCdh2KKAjBXWF2xQX+M7iXi3OnJ+G9DaGlK3a1WV+S7jZ+lAggqtw4wHsDl5M/jpo9SQklFei+r0VroRfBKMbW3QV0q2T7+cCaLZ7R/mEXNjpEJ0Zula2Lcf7jgrkPjOMtxNGrf4iuST06TiyTgScxHOF9Tw9/A90hm9nyWIVRlVPEm0UTyAJ7J84laoBF9ZAUQgsBK5wEj1Bb7GG694verSWsheftc2t6BwDRXyDXYubKffZmr00ZLSLblRxebytMD4mYRa1EHooGjIhSCPIHHghPgr8/T5GhYHepM3ECsoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHpbADW1SE60UaMfZy80JipG8HApmiguittAm3x1HHM=;
 b=RzR/DNZUeMOMbk/+ZUtBGnSPzepOAHt/1Arrok1zboYBaATh83LJOEb9UEkwBPdmqDheOg5de1VB70uS1W/V94hKN4okKRDvp5KguPAW8MORTCkpMQyb7eaRUGGqFww0E+jDhWe9ZBRSaBn0dL83XuRV7pA85UeGLQXFXRH2qe6nXM/fHh+2ehsKBHI2ygyKz/Aw/F+MgNcoXOU4n+B18lLP2aZV2/TNN+UvQLQy3ucLgkWYe8FKWMunAE+vXYFLV1f7HrBAqgF5OdhbDur76PDj7qlOHJg000v7wN8+W4uOIkLgqwHLpPvN3iUJhlmSfXBViau/VaTm1X5QPIoeZQ==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 16:32:16 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 16:32:16 +0000
Date:   Fri, 29 Oct 2021 13:32:15 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-next] RDMA/bnxt_re: Use helper function to set GUIDs
Message-ID: <20211029163215.GA851638@nvidia.com>
References: <20211028094359.160407-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028094359.160407-1-kamalheib1@gmail.com>
X-ClientProxiedBy: BL1P223CA0007.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::12) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Fri, 29 Oct 2021 16:32:15 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mgUnf-003ZYo-1p; Fri, 29 Oct 2021 13:32:15 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56e596d2-c783-433b-1dae-08d99af9ab27
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51740230603AADF3DB9AFAF1C2879@BL1PR12MB5174.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RmzVjpZXaaayy7qGgBbBaFDdwP/lr5T0MRFswucgfVRPUgn97fdWAj9P1vnGoC7LXbwCzf/QcCQYhg9EKaJ3LOYXQql+9awcjXQ3CJFHQ/7n4aaAMcwe/9MCLvlkwy65JwOrwlZUEv2Kd1Mpq/aViBMw6aV/4IcCKl4lT4T4wG+rhlOpE4JoyNVnyYHYPsNFEgTrO2UGqBdiyINKgY6b5dSHO4EnbQUZTmDdrYhTgN11DbT9Qqxa3wM7dW0rE41sIZNCjfvaFVhYkGxonEmiUubJ+qxj84FP9zzf+cWWg/6z9h+NfI5E4IQ26yEP1aoYC21zVt/wYEa+OaLMBkkNipsEfIdOUzpxudouC1lZY28Af4o7GsKKjvoY5X8yK/qf2LmQnXyollgk6zn0xL6/7sUimCBkdSdrrlUbST5vlYclBRUfDnT0dyK3WviOiLEKJ0tHPgwDkEL0mMJRHyAvZDa04BMi7OM9rOw8hhwX2AmvpSl9uJ3fJnYwgm4J6/RbgEywDI+cujB4FPgS2+3Tkb+Cy2Vv/zcVTUy8j+gLwG6pQPaqctJTW04TkliAzYutc5/F/sHGpKF+ZMPyoAIslyl5qOAeuMV1XgvKiUbMJRsC4ahAwC8s8ZPRoNLe459RjVkd86O/mFh1R4OcniUszGHlSUrmmVmC8BHO7nj+tyJdHOneO0bqxI7eTW2kXB+AF2GYkEub3wCTTWHYSO2Sfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(186003)(316002)(4326008)(66946007)(66556008)(6916009)(426003)(26005)(83380400001)(33656002)(5660300002)(8676002)(38100700002)(86362001)(1076003)(4744005)(2906002)(36756003)(9746002)(9786002)(508600001)(2616005)(8936002)(54906003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JuX+ANZA9r0N0vV9p7bifAVVv/5qdoPeRGD8UdXgf8E7OK/6AldcsRAV24Bm?=
 =?us-ascii?Q?AOB12sFQXrFej9r3EagtH9lkmUfTnPsKk5cm0LJdbvK2a01ioE8alSbP13zX?=
 =?us-ascii?Q?3iSFz91Dr7v6wiWjaD0/S7yxKH/Bz5QXBGvm4WZXGqUoAgAosWaF2N2XTTy7?=
 =?us-ascii?Q?dEvbWDM5pjlyq+ky3XUINKs/7t2EtdcyK6Bjvr+PxaNjDcbNczVDM+DK1CVM?=
 =?us-ascii?Q?yMToCah8odHcismf1ng8HOcNmGD0AYlHuJWE8Qdr95B9tmJA2j4acGomxmfr?=
 =?us-ascii?Q?ovMlfl6tgc/gKxSh+T2/sF4HeEgExR+ifkPvGJjh9PDFZaJGDLyHqS6rZdqF?=
 =?us-ascii?Q?hyxhUo/lOPmKc2WisEgmULK++R6zhIHg1nA9a88d8sBaLrhWArpnxWdoJVyR?=
 =?us-ascii?Q?n3qm5InzhaDDMTcIUsn37SDYKs+nXeGLhH0XcvvdUX3feA4tuOQG5+/fYBAF?=
 =?us-ascii?Q?r4dSQk2XT3/bfwIUhBcJ0LIFQR94sNiewYG445BWKs/yjHo5TwuACFntaVrr?=
 =?us-ascii?Q?ZWYAMgORl7c7ym65VsubTZ/iECo522zbwDVAooVP5PhD54zryUCNcwd/sHkC?=
 =?us-ascii?Q?ndZuC3QSWF1gg0qoGB+uA/xzze4dB6yxDn5mo4GrEr2xKirqU3V52qlFC5Ee?=
 =?us-ascii?Q?2HnNsmLK1kyFo4N12JUeMj0dVNVt9Wp2EGqAj8pOBIyC6KqbXyxiLivaxpYb?=
 =?us-ascii?Q?diKyFEm32zxCEaGDWWw6nivo738+3QIxIqot6a/cZz2ijiLSNfeVCLVSIPTR?=
 =?us-ascii?Q?7hbxa7BkLrQ5l/Uw25pjmVkYWicgtAN08j7jNnp5u0TVoFTQJnQrTu6KKDdO?=
 =?us-ascii?Q?2Sqb3Bf/NoxKlfxUtiyqIs46boyAGTbgT82BAszOrJdF/Gg+fDZjpDrkdC1W?=
 =?us-ascii?Q?vGeVuMq0XU7ggZu2CYb8jFmO/WKZFk2lQOe3U2Y7I/VJcEca0wYlY4KnPJ7Y?=
 =?us-ascii?Q?7d+gfpTVz/CYnvQ7r6U5EYjUwlrp8usFq5x1NGNW2vxBHHdGAnOnXUfPpXwt?=
 =?us-ascii?Q?SkbdUHoJskTNphpoK9cApTnNa0W1LO53e+XS71xLUW9+hMjUle4BOYQcqqd1?=
 =?us-ascii?Q?6RPU+bXlmRZ+wePx2Kink+OwhNWi79Jxh4ID1F9TRwkOE8UVechsHeSi9LN1?=
 =?us-ascii?Q?p1MKoJfA+h7zzLC0dHd7RSn2o47lYfLt3i4VK0N89vv7+rh71y4q3Ay9tlcj?=
 =?us-ascii?Q?iRfDtfO632V3E5+FFE8YxKz0DGuTe7YFyiJDMTUWHHbVRidM7GcdzSMxiyPT?=
 =?us-ascii?Q?Jcvkf4RENSNHl0u+dgEhN7boU/L01jJwDIzTP1iSsn+AyUhi6aFsheZiGXog?=
 =?us-ascii?Q?8+3RHYQg/wUqdU9sH7060R987q4MVeq+mvEbdJ5qOkZDDwTGaifoOW2QNilE?=
 =?us-ascii?Q?0Rmsgt0PUn3v5V5e6F7xo/xK0xpX0YEZjNiAj+9CFtmswr30IbrKF3roo5W3?=
 =?us-ascii?Q?OVj6IhzkJ7sJQ6DyUJxXK5eyYzDyU56K1SXzt7Lrrx5KAE4RnY77gLm1hIZv?=
 =?us-ascii?Q?cGWqTKL9J4WIDe/ok2fRUxqgTI6J+1WUVhA6mlLMnOPMWrUhpCuTYKQottDm?=
 =?us-ascii?Q?H1G9XVgBU8mN09j18lo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e596d2-c783-433b-1dae-08d99af9ab27
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 16:32:16.0160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DI08NAwi/H2MBR+g9HwDYSw8cdnbP0pholDsiJcazCDTEVzoaSTypHSdblX+tq3w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5174
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 28, 2021 at 12:43:59PM +0300, Kamal Heib wrote:
> Use addrconf_addr_eui48() helper function to set the GUIDs and remove
> the driver specific version.
> 
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c  |  5 +++--
>  drivers/infiniband/hw/bnxt_re/main.c      |  2 +-
>  drivers/infiniband/hw/bnxt_re/qplib_res.c | 17 -----------------
>  drivers/infiniband/hw/bnxt_re/qplib_res.h |  1 -
>  4 files changed, 4 insertions(+), 21 deletions(-)

Applied to for-next, thanks

Jason
