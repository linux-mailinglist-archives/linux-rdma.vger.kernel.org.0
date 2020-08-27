Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01AB0254757
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Aug 2020 16:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgH0Osu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Aug 2020 10:48:50 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2711 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbgH0N7D (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Aug 2020 09:59:03 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f47bc060000>; Thu, 27 Aug 2020 06:58:30 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 27 Aug 2020 06:58:44 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 27 Aug 2020 06:58:44 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 27 Aug
 2020 13:58:43 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 27 Aug 2020 13:58:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nud4Pn/F1GM+zChVODn2Z3+s3IsFs6tbWRV9n790HBkkwRcjhq5d64mOngK2AJu/bwNhYFmCZfH2Z9VBsa4/wvMOVk7tWtBArjHKDYrTNRq5za4Hs/IU2NFaGPGespdEF+brcQXlmUXGl+Ijbdm2b9Wj6O6GXFkw4CpqZj4cHzpSF/4yXb68vLiN9iOAE80/y8Qy4unoaNp7s0tP8RLUPCIxLxjMEsu15o+VuHM57Bqv5b6proRLKW08zBPKnepxJfBNefjbd1/p+yaP5eGtM1MUVHneLwWjbS/AkfQTPv8ozN1DVaZmPZGza6je253vnSlVbrYab5mFHUK2N9CB1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieA0rNMotOPjQKVNmAFtLsJzqZc1nhP62IDnsaMsG/Q=;
 b=DzZqfC023JUmneR4AqMubtPtU5ezmHEEDN2ZTD1iRYctflFSbqS2bfps6Bk8abkqv2b1sEkTVfMfxNweo4dI8KVT/utRnx37jxuExUfkoRYqGM+1LqGE8R+cDgRsRzaOteVqPBqznv6+QxKcgFQP/4KG4AB7WVNp1aGGOwjVRFmy7E/tl6foF9ASCyMfAszdQyPWfmLEROieY5gy0AmrKt6XDJPUv9BwoP1+K8FWpiBpcvlNz1aGr+IW4t7rJfyI8tVflnQfA+BwxmEfJ+iDX/s2+FkhiSeiffLDdWG5DKYxyIcIi7WmRK0tdUx1tPBK8jjcosYqpB4FXTeC/Q+DDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2439.namprd12.prod.outlook.com (2603:10b6:4:b4::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Thu, 27 Aug
 2020 13:58:43 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 13:58:43 +0000
Date:   Thu, 27 Aug 2020 10:58:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <leon@kernel.org>, <zyjzyj2000@gmail.com>,
        <linux-rdma@vger.kernel.org>, Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next] rdma_rxe: address an issue with hardened user
 copy
Message-ID: <20200827135841.GA4033418@nvidia.com>
References: <20200825165836.27477-1-rpearson@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200825165836.27477-1-rpearson@hpe.com>
X-ClientProxiedBy: MN2PR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:208:236::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR05CA0052.namprd05.prod.outlook.com (2603:10b6:208:236::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.10 via Frontend Transport; Thu, 27 Aug 2020 13:58:42 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kBIQL-00GvJY-6B; Thu, 27 Aug 2020 10:58:41 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9aae56b2-1d2b-48b9-67cc-08d84a914eb7
X-MS-TrafficTypeDiagnostic: DM5PR12MB2439:
X-Microsoft-Antispam-PRVS: <DM5PR12MB24396BB868A611A27011329CC2550@DM5PR12MB2439.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rWRM+tWoClskIYsFCK/4m5oXLEExa1/tLEmvMmV0JxvTQ5cGWleutXtUDDqViKPYT4pnfD07EFf5m2/0tktlDUt28cPlEzWImsGfIZv/1ppcGy0nxHBPxd9RMUK6FNZpJN7a2GRWDaqB/dXo31p/+yI0LJCFUYOPUzRW8HmE2vH015qbctJpg5QqmnlEVzdWv5oOR3PVnUOhWGrXr7EjN5ze13QdRy1r2L/1AJ/3jLact1Xs7dE6ikh2tnvwycrdYy40yUDJp22LrxzOSOS5xa01x5mJbOKTDGHYO3EtDpvrEeMYrI923wIzAzGQlYRPNEnjgn8aOGmbW0anB4xbOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(9786002)(9746002)(5660300002)(478600001)(66946007)(66476007)(66556008)(8676002)(86362001)(83380400001)(1076003)(4326008)(316002)(6916009)(8936002)(26005)(33656002)(186003)(36756003)(2616005)(2906002)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: HHaSQdBc+p1x8mM5i+ZRKzwy1EZJmUDYPFaxdan4MsaxF8BCdEP8wAhSrbpLpvTvQI20pmKHaq2sbgbqX4B1AgWTDmrVpyiLUWe0Gi+TtfxAHnGqKCIaC3wVgAYozho2DtTC5EGEiEiLyXvfVu6NEJnwDYmBon0fouPCULFliCWWvgew9YXYLgXGhbPHYzlvvvsTu6WtopLUrdkhdsCZXrdqGRKAcpepHPWdPNc/98YJ52SzsQyimSFlDGjyLDfkCwK/b0fkjGlDteASWq0fDu2Wisol1a42wRn1F5KYgdmGZWKo1JKjh2j3Dc1ehXHZK8nrI+bHXFT3SU5f3e957UMvig4yZ2zkuIBgNa/7SI83vNwU5Vf4UC4Iu6X9Rs6jGmPozJkKe4iSVCUUkk7nYeyUrRT17lwxD9y2th6vwkyeAxkqS6EJ9EaPyYOKfmIiiwnczUfiw9utvRSKIfhiCEymuKBbAK3wKbOj8mfEfULkyXy89Y4YagSHdL2o1OHXD6RQ4GEaXA4nYEp3qQlj686igpYT3f7vfJTRBhZRvomWOwOSZShUtrWeLUA7QXObj/8WepHGyObEUc2YzbObAxrfJ4FBnpgC/9xZBgLz5JnSI2Nt7hDx5ysSO3Aj/TUM7C3BNijYDvIFfCbIwlSGNA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aae56b2-1d2b-48b9-67cc-08d84a914eb7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 13:58:42.9108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZPnk5BDMg2yQmHnD/ZZwYFCritY0I4BcDh8xVVKPa47JpnStcgGmbREkm1mRrho8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2439
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598536710; bh=ieA0rNMotOPjQKVNmAFtLsJzqZc1nhP62IDnsaMsG/Q=;
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
        b=YiqWJ+IsSshoeCq4sAsYILuccEMWcgOeVNHUcD0HHc4jdOQ1tMNqcMPi65fHbnmVL
         vla8mg+CeoB6pyTVVCYvKbTg1WM5yrQhdJImxf2X2gE0Jy7MM/vR+adzgmEDjrHr65
         2YQoUQJoWI4cNsG5JVg0MZGHDR/TYxgWs6ZUtGT8QGSqM0Pek+HkSiQeHME4ITg0JA
         2D5Qbserffx/c+wuOfop0s07cX4yRxJTEhvjIC19SytW4dwFFlhFkd8wZHO6Mtvy/7
         J0oPnjYPCAF2vVR7Vx+AXtm9oRKJmVvEA0uFGlmkVrrzvLPh2OgTfSaAqNRBIjPFNg
         x9kRTzrPURB7A==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 25, 2020 at 11:58:37AM -0500, Bob Pearson wrote:
> Change rxe pools to use kzalloc instead of kmem_cache to allocate
> memory for rxe objects.
> 
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
>  drivers/infiniband/sw/rxe/rxe.c      |  8 ----
>  drivers/infiniband/sw/rxe/rxe_pool.c | 60 +---------------------------
>  drivers/infiniband/sw/rxe/rxe_pool.h |  7 ----
>  3 files changed, 2 insertions(+), 73 deletions(-)

It doesn't apply:

Applying: rdma_rxe: address an issue with hardened user copy
error: sha1 information is lacking or useless (drivers/infiniband/sw/rxe/rxe.c).
error: could not build fake ancestor
Patch failed at 0001 rdma_rxe: address an issue with hardened user copy
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

Pleae generate patches against a v5.x tag or rdma for-next

Jason
