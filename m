Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA54254801
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Aug 2020 16:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbgH0MZr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Aug 2020 08:25:47 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:16659 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbgH0MYd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Aug 2020 08:24:33 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f47a4660002>; Thu, 27 Aug 2020 05:17:42 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 27 Aug 2020 05:18:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 27 Aug 2020 05:18:25 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 27 Aug
 2020 12:18:25 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 27 Aug 2020 12:18:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoWzCwto8f4pKjZxDf0pYnMdADxxZw28CoySMYysa4e3XBIMYvmjlSKWwZD5CWHLtFqWKXhu5BDE3S/LbRJPnKHgznCehyUqzOEBC7G7l6Mukf5eLiHmziME3YWUnDl6YNuZsT/gj8ptY4f7U8UeOoCoh5wk7crej0lkMJ6mF7l1/LMXnHSiJGgYAEyoLpMgaqNFuRa+yA/MqjAAvlgJOQ2kR9peDIAHnkQbiSOG1R/oPTkWs1oHW4Z6pOS8bZQa58ND0/oq6EFtI7+le6yRZrYBi+lbEIBr1Gwq2SKTXJQOf1OSIGyD2CcJkCmjprvQ0z1PVlHnnDrvzJb1HsTY5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39TUr70QBYxxQ3lojpz1FTb0Ndkjd9hlFuKFJqsu8pk=;
 b=R+cYq5Jrf7/gHM6aGzOoRMwhI9v1yBxuFdPmGL4BgLA3iZs0F+xzLlY11sT2Vsc+MHRFpaqv98jNEGggW7/MGRDpWpics8hweAvdh15qtk83aVkcNBr3oMBxtYRP/TKAOCZZffugQBmCXmrTtn9amIzoNSrwkTKnnQBV77qL2uEv9w7SjKeB0wumQhFjruWbgqpAA2hu0cjfcIQpd2N2s5ONcWlaPKJCPuV8fjsX+jFSfYKYuVqjhVflk+yi/mMtQxSDFUEC3hGITzaOAKRq53gLn8GsWUnwtpXJofEr0yeoNX3BoU0P3X7zd569x2Jx2Hg7iYyvg0IGMe8nA9Bohw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1146.namprd12.prod.outlook.com (2603:10b6:3:73::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 27 Aug
 2020 12:18:24 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 12:18:23 +0000
Date:   Thu, 27 Aug 2020 09:18:22 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
CC:     <linux-rdma@vger.kernel.org>, Doug Ledford <dledford@redhat.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: Re: [PATCH v4 for-rc] RDMA/rxe: Fix panic when calling
 kmem_cache_create()
Message-ID: <20200827121822.GA4014126@nvidia.com>
References: <20200825151725.254046-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200825151725.254046-1-kamalheib1@gmail.com>
X-ClientProxiedBy: BL0PR01CA0018.prod.exchangelabs.com (2603:10b6:208:71::31)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BL0PR01CA0018.prod.exchangelabs.com (2603:10b6:208:71::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.20 via Frontend Transport; Thu, 27 Aug 2020 12:18:23 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kBGrG-00GqHA-Bf; Thu, 27 Aug 2020 09:18:22 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2c8b4f6-890f-492d-cfb7-08d84a834b2e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1146:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1146AD8405A47551727FD43EC2550@DM5PR12MB1146.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f6stH+d4dY85Px/ph5FeWx3ETuyvNklEMlHZ6N5T/ZvQjrWsQYoDPbblDmqKmwjFWnob6nxoSpGGk4npkMAO9Q8X5acnRXyIiNWHJ51vDH2gkxWz2WSxVJF3FdgxjmbpeY+yc/Lgsb17t4hzN3sgazlBQzACHJowQHiHsHAXHlKIypSDewCIeu8gXgtmgQkR9wSE/6CKYv4bNzwy+1p6Xf0a874aAV5UdWJAim85L91URebCWNQzaZ1E394JhZsHtXP3DUX6t6xRAI96N96VoHpYYAEwO7nHyt8oLGYu6RCd58hs9ggmTpmSlMk78Wizv9vGThXC6fzBYncyu73cdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(8936002)(426003)(54906003)(6916009)(5660300002)(2616005)(186003)(26005)(1076003)(4326008)(9746002)(36756003)(9786002)(33656002)(316002)(66476007)(86362001)(2906002)(66946007)(478600001)(107886003)(66556008)(83380400001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: OjHgUd9keKZyV8lFz6SqEbgBKdOJOnfQzsP8NUSOpbPdMsN0ICUG+YZW51HchVQV68CkMHBCZeZTLt4Z+8A11EReV4pRJ2Gp15HPZpu/VNkn2IS0TXup/OHbF9UB7bZ8EWupzE82wyazr1UilrscPxJ+14RlOZyhz0F1qYbGzJsBWkkD0zO2MT81KHtYbcjsMi5RBFnkplGuqtys03F8X1axYcSYXiKVL2qRjYdqAx+//aAT3I7/J/cw/ET6TS19E1ENjuoX/ki3BrxhADDUfkj+2Rb60RscZLOXQ6IM12bqGUzj0mOFzLx/JP1Iqs9R3gCLgNkCy+ViidYorFbp799i4yNv8faJLdO9mH9G31Y17DwNE/ZlAHVPj69vS7pmpukIqEoPnC9eAhnbly8mxdiu3Kp+3Feu4U9nlD2xVpw59YkjVCOf7yD2nLH0mlhjNq6GbHNpbX/SXO1z+X0gNVHqrbWcv9qdpfUzsIT81EbvuM/kC6re3Xlz+nEVrZK29xTv5O5K+0erdHJq5ACvaRebC/WmjrKmnxnSWnHa/d534TZeb14TefqQAAJqxbyxYyuyRL0+w3mRHm6xCF5MhrZYpBccQVePe2GkEhbJHy3SCIcsTfo4mcBMVsNYQla1v28wEwyLBi22wG24ITDMaQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c8b4f6-890f-492d-cfb7-08d84a834b2e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 12:18:23.8053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V5tAhnFo2eT8Un3AD9c1QS/XCw9QxqBp1k45iDqYrHm3LGycC8XBZjSLtYQciVhm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1146
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598530662; bh=39TUr70QBYxxQ3lojpz1FTb0Ndkjd9hlFuKFJqsu8pk=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=A14AGN4MqklDRphu7DiUGIN1zfY5fmBGpDI0P+OUnQzmlJKxIEbtJT+c0ZVwJUgAk
         OXoE1PK9K/8K+0fvSf0eudsqHNVpsNZBnDNbY2P5d6y2lE6OUlFDz4hT2RG/gkubCC
         uQGcYFwGMaWbzlgWmJcd+aH8a3HbEDb+qXHi4MLXSacvSfEvmFN5fIQN+bmZoo7nKC
         SGumz60FpQUlzxjCpRSLMaifkQwHI4r+bJAO+i8gFdqVJu8kZXkZcEoWQ448wTAbSX
         wR2Bk7vkmROHKumtGHYZnQTOwDtvGfbAteXUDfAycBUSIEYYmUqfQR81I2E4+n1rqM
         WeAHwaFedt4Og==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 25, 2020 at 06:17:25PM +0300, Kamal Heib wrote:
> To avoid the following kernel panic when calling kmem_cache_create()
> with a NULL pointer from pool_cache(), Block the rxe_param_set_add()
> from running if the rdma_rxe module is not initialized.
> 
>  BUG: unable to handle kernel NULL pointer dereference at 000000000000000b
>  PGD 0 P4D 0
>  Oops: 0000 [#1] SMP NOPTI
>  CPU: 4 PID: 8512 Comm: modprobe Kdump: loaded Not tainted 4.18.0-231.el8.x86_64 #1
>  Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 10/02/2018
>  RIP: 0010:kmem_cache_alloc+0xd1/0x1b0
>  Code: 8b 57 18 45 8b 77 1c 48 8b 5c 24 30 0f 1f 44 00 00 5b 48 89 e8 5d 41 5c 41 5d 41 5e 41 5f c3 81 e3 00 00 10 00 75 0e 4d 89 fe <41> f6 47 0b 04 0f 84 6c ff ff ff 4c 89 ff e8 cc da 01 00 49 89 c6
>  RSP: 0018:ffffa2b8c773f9d0 EFLAGS: 00010246
>  RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000005
>  RDX: 0000000000000004 RSI: 00000000006080c0 RDI: 0000000000000000
>  RBP: ffff8ea0a8634fd0 R08: ffffa2b8c773f988 R09: 00000000006000c0
>  R10: 0000000000000000 R11: 0000000000000230 R12: 00000000006080c0
>  R13: ffffffffc0a97fc8 R14: 0000000000000000 R15: 0000000000000000
>  FS:  00007f9138ed9740(0000) GS:ffff8ea4ae800000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 000000000000000b CR3: 000000046d59a000 CR4: 00000000003406e0
>  Call Trace:
>   rxe_alloc+0xc8/0x160 [rdma_rxe]
>   rxe_get_dma_mr+0x25/0xb0 [rdma_rxe]
>   __ib_alloc_pd+0xcb/0x160 [ib_core]
>   ib_mad_init_device+0x296/0x8b0 [ib_core]
>   add_client_context+0x11a/0x160 [ib_core]
>   enable_device_and_get+0xdc/0x1d0 [ib_core]
>   ib_register_device+0x572/0x6b0 [ib_core]
>   ? crypto_create_tfm+0x32/0xe0
>   ? crypto_create_tfm+0x7a/0xe0
>   ? crypto_alloc_tfm+0x58/0xf0
>   rxe_register_device+0x19d/0x1c0 [rdma_rxe]
>   rxe_net_add+0x3d/0x70 [rdma_rxe]
>   ? dev_get_by_name_rcu+0x73/0x90
>   rxe_param_set_add+0xaf/0xc0 [rdma_rxe]
>   parse_args+0x179/0x370
>   ? ref_module+0x1b0/0x1b0
>   load_module+0x135e/0x17e0
>   ? ref_module+0x1b0/0x1b0
>   ? __do_sys_init_module+0x13b/0x180
>   __do_sys_init_module+0x13b/0x180
>   do_syscall_64+0x5b/0x1a0
>   entry_SYSCALL_64_after_hwframe+0x65/0xca
>  RIP: 0033:0x7f9137ed296e
> 
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe.c       | 4 ++++
>  drivers/infiniband/sw/rxe/rxe.h       | 2 ++
>  drivers/infiniband/sw/rxe/rxe_sysfs.c | 5 +++++
>  3 files changed, 11 insertions(+)

Can you send a PR to rdma-core to delete rxe_cfg as well? In
preperation to remove the module parameters

Applied to for-rc

Thanks,
Jason
