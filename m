Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54B82173FC
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 18:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgGGQbo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 12:31:44 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:21420 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbgGGQbo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 Jul 2020 12:31:44 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f04a36e0001>; Wed, 08 Jul 2020 00:31:42 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Tue, 07 Jul 2020 09:31:42 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Tue, 07 Jul 2020 09:31:42 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Jul
 2020 16:31:35 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.53) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 7 Jul 2020 16:31:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1uoiVj4u+cx+KveSPazJTdLYfuIDI9+EqvZ9NYs87mhap78Pl17hsB/Qzn7QhfXxPY3wN3FtNp6ZLxG8UsUrItY18Gol3IeJy4byu4MDuaL8KYE7vbv0wrIFNVp6wniDpeCjl+VquVrmVlZ6kbC7HNR8CDB9xGxirubmWzWuVzjXQ1qsWXHpBaO56PZrGD7TpvfJeDDJLI5LJZUnadIeg4XAKKNmtipF2XA2Tds3U8xYjSdmY11k4aScdI+t66K3PXX5GdUhr8K24pnWVludyE8eeM3KSDeYfOU1qakcuttoWBNCMp5TNRewrAFs8Jj+FhkJjfow4aQTk+7n5v8kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4mtRDOoLoT24o2X/ulDeCRjF6FG48ZYBpgGrC/aBKU=;
 b=JMCD4dSOb/VFljv3yLlN3LRKbPH8VMS1NbEqSMVmB215q2pqYd6v1WE/voTzaBU20yEjNbyDS+F6bOP4XSCwrDGw4mzNAC/QTTN9KfZjJ1+6OLaWmOjlhZvP7mgjRGuWVjOr5l9pqPHEXkohfsR1g6AgxtGD0KRw8XJYh2K3xLk0b/l7b7LlvLjzc+FMUrElao507PFXuNbM9L6bGal4Yr9QnMMtV3ADpDwHeNZBjKyIGfLt9RqoSKn4zy0qIUCBasXG983iMx9ljt4WAEWg43lRHFcFvDKaQH3a50cQuL4zmA4pUD2kuF/F+35+REf6ot3zlZHH4e/XN2SGyh3rTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.29; Tue, 7 Jul
 2020 16:31:29 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 16:31:29 +0000
Date:   Tue, 7 Jul 2020 13:31:28 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Zhu Yanjun <yanjunz@mellanox.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/rxe: Skip dgid check in loopback mode
Message-ID: <20200707163128.GA1381043@nvidia.com>
References: <20200630123605.446959-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200630123605.446959-1-leon@kernel.org>
X-ClientProxiedBy: CH2PR12CA0024.namprd12.prod.outlook.com
 (2603:10b6:610:57::34) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR12CA0024.namprd12.prod.outlook.com (2603:10b6:610:57::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22 via Frontend Transport; Tue, 7 Jul 2020 16:31:29 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jsqVE-005nJj-58; Tue, 07 Jul 2020 13:31:28 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb2a14fc-c4a1-409a-b6e4-08d8229333a1
X-MS-TrafficTypeDiagnostic: DM6PR12MB2812:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2812BD39FB9364472BC44CEDC2660@DM6PR12MB2812.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 0457F11EAF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T1hB5+k0Td3tYodqTFg0LsRJo6OxIbidBw0+tmyNcc8//GO7BV8DdKCc2BLrsRT9fVHzd5hGLTS6CzFvlwXdP+3j8V9e5r1wFC9cABtqkur+2LRXlgbt1YSYAQDglHqP4w2vWKp9AhWF73XCHYKlBpZAxwSgo0gUf81GeNxuAMPOv30S2TjzN+5US49yvmX3A8Y1VNFdSjktFO7Md7mPj2WB6ZBrsIpFpFt7FHpRodHHgibDhwNlsuoLeuVVrx8juYJ5+b7V8Wq2L1Q8kAlXNGo2IgRzwOU0GAyvPdsDLD0T2GMyWq1OvenT67njHqrB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(316002)(54906003)(4326008)(66946007)(66476007)(66556008)(1076003)(2616005)(6916009)(2906002)(86362001)(5660300002)(36756003)(186003)(426003)(33656002)(26005)(8936002)(478600001)(9746002)(83380400001)(9786002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 0vSmXbotkci3+poEm93eovc0hmr8AZ0/3uMhz5yB142Yp6J/BGlgsvkyTNbA6DtB2zGPvJpH3mGqDk+c/HsUwaI52FBdJIeTYq3CRSwAneDmrW3DN4810HfCUGQfHnp8aKuQQ8r3iDgwipgjl2DwK/gHOPUa1djYatJAZaOokMjoNQAiN/otlGJLU/JwhZRi+4fcl72ZMG8f9ECpwfAJCwc9XzRvf6GXW1nqsPkoA8alxfcwDzC9w8OmB3KT41isY3NlT1e33w069w51hcfOsYkqenuZnOkDs4OTiHsy7YoCj2LQ0Sg1r0j1wc32FfJQEk3t2MPU877UhP+PjnzzmhjshHkEmzT6jh4YYe0YNc6W5YPF9pMsa29pGjcBWeLhncjdIdKMa7tDy+e6SNCq8+2Gc+sECb5r6Cj4gjopInWMc46UyRaMSk1dKNGIIEt77RfjlU+BxpOxspiU0Fy9aAqLu3dr6NMqhtleOIzLzp1RQbQbHS9TFD236fjZwNua
X-MS-Exchange-CrossTenant-Network-Message-Id: cb2a14fc-c4a1-409a-b6e4-08d8229333a1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2020 16:31:29.6417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2eq1p3Zln7qw2njdNCxGzXkz8QBoNk0MuJltiqMaRr/00FIRdfFXvN2/92v+foo7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2812
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594139502; bh=G4mtRDOoLoT24o2X/ulDeCRjF6FG48ZYBpgGrC/aBKU=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-Forefront-PRVS:
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
        b=a1jDNEtwVc1N7bFuLmRKD0Mq1iMRsRuneUxxfT990rZyPEK4iXfIv1Kt5J5NjVAL2
         4k5BChx47QQwEFCHTC6W4ycUmoSK0EksQlScPbXIdtliHSBsREbrzsVDxJmmShVKij
         M7/oEQfQ8PHjovnL01jtX91fW4ttUeqk5JQsXwYPf0hqXODw3AO9AwHaLNQEXKHT2L
         tbSfVGzGb6rXbs7SX23winxintIQA30jWgHfNMy/0lLFfS+jfhGXFJpAznjehdfDeV
         jj7enm8O4/dInLs5L8ez7U7lIDDzAli2uztQSmks5sv0buxsHzxaIXOxx2KUcByk0t
         gsqVAsKFoh/Ow==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 30, 2020 at 03:36:05PM +0300, Leon Romanovsky wrote:
> From: Zhu Yanjun <yanjunz@mellanox.com>
> 
> In the loopback tests, the following call trace occurs.
> 
> Call Trace:
>  __rxe_do_task+0x1a/0x30 [rdma_rxe]
>  rxe_qp_destroy+0x61/0xa0 [rdma_rxe]
>  rxe_destroy_qp+0x20/0x60 [rdma_rxe]
>  ib_destroy_qp_user+0xcc/0x220 [ib_core]
>  uverbs_free_qp+0x3c/0xc0 [ib_uverbs]
>  destroy_hw_idr_uobject+0x24/0x70 [ib_uverbs]
>  uverbs_destroy_uobject+0x43/0x1b0 [ib_uverbs]
>  uobj_destroy+0x41/0x70 [ib_uverbs]
>  __uobj_get_destroy+0x39/0x70 [ib_uverbs]
>  ib_uverbs_destroy_qp+0x88/0xc0 [ib_uverbs]
>  ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0xb9/0xf0 [ib_uverbs]
>  ib_uverbs_cmd_verbs+0xb16/0xc30 [ib_uverbs]
> 
> The root cause is that the actual RDMA connection is not created in the
> loopback tests and the rxe_match_dgid will fail randomly.
> 
> To fix this call trace which appear in the loopback tests, skip check
> of the dgid.
> 
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Signed-off-by: Zhu Yanjun <yanjunz@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_recv.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Applied to for-next, thanks

Jason
