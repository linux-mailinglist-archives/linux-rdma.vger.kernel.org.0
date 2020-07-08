Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8FC6219444
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2020 01:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgGHX0f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jul 2020 19:26:35 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:47060 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgGHX0e (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 Jul 2020 19:26:34 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0656270001>; Thu, 09 Jul 2020 07:26:31 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Wed, 08 Jul 2020 16:26:31 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Wed, 08 Jul 2020 16:26:31 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Jul
 2020 23:26:23 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 8 Jul 2020 23:26:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPlASdoF8gSptMyieYn4WqmSDhgXKptPTXNDXQfujpkK2/KeBFo7V77RC3gTfMDcVvj2u8F9oLtTps8YedL4N61+bCqvKkdaOGfL5qZd7pn+FgQ543FxH0rmX5w9yJ2awAJvGEq02P+be8qxDMrnr0qqOpxCdsSaxEF4phkwOWg1oTmsQSEKAO5OOxT9yMcESmUXGNd4NdoshrURDro0bXDaT60C+RNibBUvhU+NNhNVfERuCW2CQ+2OkcoabQfpk5uYtbOd0bYNJqVBz+SzYqpboj9AscDfmGYgwkRO86jk7tyShD4+WEEayKjAXnr0/m7LawZlY6IcAw9ios0LnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2vM2CAf9YENjnLoRZi/8Dm6yHfzhUVS+6T46ecRo8s=;
 b=TE3T0ix9wWS1Sqoi6aICf/7atVjjHsMX3Nmg5/ro8OG0Brb7FV9KOPLZr8Pg3kDlTvgqANTUH/XKK3RKViZ7bPR5H5CWO9Y/Qz+p8rcmztg6vEYE7bfdm/R94HNyqHN+pip3m9ZC0Rf2BLFQxSPxSJuj6azMksHGdHzFBP7KKnqkcBqgvoaWoSAN+YsLv2T3PVTfBAJLQ+80enEyYrxOs1mNxCmtypqdL3yieTV47bGXENzjscmuNSZ0iZMGuh7Vb7XkEtBYhPtPPkMb87cM+pglfFvZZukj/ukvosnFm7X0msaGkT5n2JPc2rQsnrzKncH3dKGBbrN26s3sf3O1uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2486.namprd12.prod.outlook.com (2603:10b6:4:b2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Wed, 8 Jul
 2020 23:26:21 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3153.030; Wed, 8 Jul 2020
 23:26:21 +0000
Date:   Wed, 8 Jul 2020 20:26:19 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Aya Levin <ayal@mellanox.com>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>,
        Matthew Wilcox <willy@infradead.org>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH rdma-rc 0/3] Fixes to mlx5_ib driver
Message-ID: <20200708232619.GA1753748@nvidia.com>
References: <20200707110612.882962-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200707110612.882962-1-leon@kernel.org>
X-ClientProxiedBy: YT1PR01CA0135.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::14) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0135.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22 via Frontend Transport; Wed, 8 Jul 2020 23:26:20 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jtJSF-007MQN-Ka; Wed, 08 Jul 2020 20:26:19 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 835f69df-f7f4-4621-e5b5-08d823965289
X-MS-TrafficTypeDiagnostic: DM5PR12MB2486:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2486FD55535F75D73083ADAFC2670@DM5PR12MB2486.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RLwTCX7dIrzmtb3xV7yd++AIwczoH8BTbRiTN611NYgDKj+MBsSeyLYSUYYx2BdzD54vu/0TPpJjwz3LBuVQm0zjWSwjDfVX12+QizJjQqKHxI/ljoO8H3CeJjpEmHD3w5oqcZtA7Uocilw1Iyyy6QHNt1DNPWFJIjgWeAhbHr0J4nlinTAHIcTDD9tZT2tt1L2ciu6Lb+U2tqPs/cLeWl9p/g4bY25VAf9GWoho2s8ZcLVvi348McASGfS4N+7Ns1kXTIrP+tE7OiXxh3vDno5oB00cFx1JHZONkOishrDscOh7gbR6t0avbeMoAsWH/hmSPunSL/SMWEa3B0AeAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(2616005)(8936002)(316002)(1076003)(33656002)(66556008)(66476007)(9786002)(9746002)(66946007)(4326008)(186003)(36756003)(2906002)(26005)(478600001)(54906003)(7416002)(86362001)(6916009)(83380400001)(5660300002)(426003)(4744005)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: J4ntQ7L6PU3DcUXP2mdY3n6osOAqbPK75CySOWJm1M4suy2btSxW4C0l/f/6NU7XZqAll/9J+UpknN+H0TaFkPmcYGqJARk4DoAUkm0ywc2YhDpXGCDDKl3Vbk1wZm9N5ed4wQ1z0jUK1u7jw3lo4Ah0z3CJ//3iPpPX2xOQ68xrge0x0AN/9GBPdVlCcFWNJwQwbBYzf0bz5+8xGVlTr9uKKtq6Q++bELWeDrnqUcnYCveGz5uq020ncXmF1LiDtFvh7KssH0xRpupZqo7HK8c6lK9K+XbRizX8LrPNyDifNCxJJcRW4yCofdtDc86YPoqGNGQiBKagvVQNgBqmCBHRI4MOSE8Q6KYLexYyJyTHKgj5TKe88buWe8OFplf4aQHaWChrfZCqPKgTqBMX5MiImxx07EypfAaJ44z1jCSF640cZm1okB+ZiOVTxOdubT2Ryauw3I9P5UzBNAI+qYr4b1P5UhUn8lxAT+Pip8aNVSl2B+uqWsVFLUFnj86P
X-MS-Exchange-CrossTenant-Network-Message-Id: 835f69df-f7f4-4621-e5b5-08d823965289
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 23:26:21.2009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsuS2ibPHzBx74NozFiM2PIhPDCpNGhZ3Wj6HgWovl8AvMLVyTRkCmNNoYZH/MYs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2486
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594250791; bh=b2vM2CAf9YENjnLoRZi/8Dm6yHfzhUVS+6T46ecRo8s=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=ZQ5VP3yH0aqUauE55he3dpph61D7uaEozpXrp70D/597FQb2kx4ym3Is3MKoY7eaY
         DfTSmEB7mIQiAYri9fG3y3ygQ/ZVdjXPc6A4tkUw6xOfOp61gLM2E9V3Lad5vZupLU
         dQdD85MXB4Is1oSGpuoawJnnWt6rpa+r5+KR2LtWzde6SpAZHvfrJrhIKlz+EIV4m4
         Xt5BokxzFmwuVf1Xa+QfL6UWHhF14ZPX2w4v/f4MGAQ7g9AA4D0hjqM4mwWbLQ8egH
         IkDy0Eg9MNwQcFm68Nzmo87H6uRlLXJlnPs8MUXLmleGeWJN+nut5nxkGvMSjNSj+9
         El/AeGhNAWSmA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 07, 2020 at 02:06:09PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Hi,
> 
> This is patchset of independent fixes to mlx5_ib driver.
> 
> Thanks
> 
> Aya Levin (1):
>   IB/mlx5: Fix 50G per lane indication
> 
> Leon Romanovsky (1):
>   RDMA/mlx5: Set PD pointers for the error flow unwind

Applied to for-rc

> Maor Gottlieb (1):
>   RDMA/mlx5: Use xa_lock_irqsave when access to SRQ table

This one need resending

Thanks,
Jason
