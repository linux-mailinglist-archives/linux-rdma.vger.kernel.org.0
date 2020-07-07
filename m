Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32CEA21755A
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 19:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgGGRmW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 13:42:22 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14833 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbgGGRmW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jul 2020 13:42:22 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f04b3930001>; Tue, 07 Jul 2020 10:40:35 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 07 Jul 2020 10:42:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 07 Jul 2020 10:42:21 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Jul
 2020 17:42:16 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.54) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 7 Jul 2020 17:42:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4w7MVbJHwUPpgWm5wkHogYZt7wlAGjYwBpWjJvU6y3LXq6LFaP4BXzWnC7kTYYKHcrAXpklyCeaVJ9HkY41xmI+gw4y58rxazHVDWOdpQIXx0bvhSBa09R8MIMMlB9+WF1nujkMwZZgDa7xeIXOX4J/MPpajIpVusfZZvwSiQBZeI779rfeCV2wWarFI/u8p43zgOnlLBLm3Q4o0QoQW91ye+gmY/E4ozMg3oD0iHkI8ADp0rNEd+6HvRQF2ZbfLqjoBR5GHGX70MQdaJEYfurVZKoyfA/ANgBklbdwBS9IR9xcBPxFL64ZdCttKucV3K1h2V7L4CJDhpnsoKHsXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdlcqmDyGw/FyngFq+8wXQBr17ypoGE14YqiGKaP3fk=;
 b=eJyI1DYwAjdFZjjIbwmcDDkAjMFoMNupCAEyaMVhMZjv5GNS7bvlDthnu+945XOoh/mWhFesi88Sx1jgLByWI0+dCLp789Wj0ZJXXrTpkj8K6AZirKtm6Vd3GCLeEpy9i61ifmKK4dh6KyxwPRv4MAPkyRp14Qdwv3KXR6lUJxQrqdNYmPvza7X0xy+7TAq6GTn6n7uqAd7t1Eax6v+anpBATk7lvkcvch8l47ITyoaw4aKQMuvJUgQh3qjOWDqaf+YUXjOQCsHrdUFaccad9M8z4ZegyCvZssNQVJxBWDokR9Ialbw4G2jDTs23bASN797yAOTiCG1TSOvrI51cLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3307.namprd12.prod.outlook.com (2603:10b6:5:15d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Tue, 7 Jul
 2020 17:42:14 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 17:42:14 +0000
Date:   Tue, 7 Jul 2020 14:42:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: Re: [PATCH rdma-next 0/6] Cleanup mlx5_ib main file
Message-ID: <20200707174213.GA1397024@nvidia.com>
References: <20200702081809.423482-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200702081809.423482-1-leon@kernel.org>
X-ClientProxiedBy: MN2PR17CA0006.namprd17.prod.outlook.com
 (2603:10b6:208:15e::19) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR17CA0006.namprd17.prod.outlook.com (2603:10b6:208:15e::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.24 via Frontend Transport; Tue, 7 Jul 2020 17:42:14 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jsrbh-005rt5-6j; Tue, 07 Jul 2020 14:42:13 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a8715dc-3e77-41d8-0283-08d8229d15c1
X-MS-TrafficTypeDiagnostic: DM6PR12MB3307:
X-Microsoft-Antispam-PRVS: <DM6PR12MB33079ABF0281A75BD00DECCBC2660@DM6PR12MB3307.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UMEsjU7Yax6XE1aUjMmGq0J5FQyzIGzrjXbvhBSRbCaD+kj1PpquBx8jN87o530oQyQ1gHKEuzJR/tRl0CYc7DPHLvI20f8DLnIQUx7KC9pdDy13SlY/scjttwmgWssKAQ6mxZU10YcR2FQliZWThF/A5EHtRT7EOarHtXr2AXX0zp5w/pO07ze8E9t/IKwXvkRJMCRv1+b79P1JG7xiVQZUcT1NEjrDvUJ0HQaf0FeAp3wrKdkz9pCcxikwSPRKKQsDOVogCW10dN3ZHRzI9cNaI+y654IxvZ8MKCrIEo/4ApPqDG32Aa8Wa7HUm2t5w+xowyA4zppLoh4XdI9NM4A1xnU596/GRSueOHlNu4iBXN+qg9W7C3vIyCviPPGNJ6kHDGVGs0YA41OgUwgOYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(316002)(86362001)(1076003)(54906003)(36756003)(83380400001)(426003)(66946007)(66476007)(6916009)(8936002)(2616005)(186003)(26005)(5660300002)(8676002)(66556008)(478600001)(33656002)(2906002)(4326008)(966005)(9746002)(4744005)(9786002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: +08wdR0U60GUzauIUhp2EFLI0Mx6VCi4pURgaK6yItNSw4XvqV48/rNFRu7fkRAdo5LYSfYqJ+8dZadX8wf3qLyec6NGiiZyKfVVncsbKhPI6irdNHGJfoT9Lry3beqpxGArAVHFNXRFelhhSn4SKW6x3FRzbUjWwUr6h6eKN8/bVwVCRm4sISYrG8+dNEui+VIK2pcU80/bcYOW1pFK/zCVTRBZZS55hQ9a3yz17MGvu9GyoEpYPoMUK0UP76i7mL1qXmSfcwVxy9iHpcbPI3oIZoDbR8JWbn9yaFlBLAlWuS8N1Zx3SXTL9IQBWGZqWuRnqzUbHD7Wy14UAeD6UNFm9PAitMhFjwmwotyI8G47OYxpoMSJGGVgrRpixHB0nH/KMX/dcUWMKOlQiVU2ypNhaQWH6wEknxpS+c7ocZ9+uPuglDkRk0T+ESv/kS51v4BGeggVW4azax6FICE224mIvGhiHUm4pja1Bkx1HI0=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8715dc-3e77-41d8-0283-08d8229d15c1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2020 17:42:14.5224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Bt16LrQf3Nqo/Gyo2pS62bojW7g0YID6U3YChLYoIgHDHSZf3jzDyvB2AsWXqbV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3307
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594143635; bh=OdlcqmDyGw/FyngFq+8wXQBr17ypoGE14YqiGKaP3fk=;
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
        b=bO15WCWEXMM0hYgNqdic1kiX/hphzneE+LNCsvfjGdi8HRJR1XWmpStnZoEZqumvd
         nzUOMBfBv28thqspqWQqohV5npwoUgOo4Gby6IGFaLZpLpUSnxquPeDAMiXxTQYz/7
         psmKynRPDmk4DSIjRtvk0v0DQSY+9sYJYuoJTywf/aooI7DVE2XEdHTTt3bWmO9d6i
         3116MNeoPAntf25HLbefauElxWGc7/PhBLgT24o0YJli5JEmQwKkf9PRJNI8dNgeSd
         6FY6dDsSRh96MNBDBNJCLtReq/yOi6DsyCntbvVlMnZ4JIlHL+GPwJV+F4CpPCRCl9
         znxbrJSNqKT1Q==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 02, 2020 at 11:18:03AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Over the years, the main.c file grew above all imagination and was >8K
> LOC of the code. This caused to a huge burden while I started to work on
> ib_flow allocation patches.
> 
> This series implements long standing "internal" wish to move flow logic
> from the main to separate file.
> 
> Based on
> https://lore.kernel.org/linux-rdma/20200630101855.368895-4-leon@kernel.org
> 
> Thanks
> 
> Leon Romanovsky (6):
>   RDMA/mlx5: Limit the scope of mlx5_ib_enable_driver function
>   RDMA/mlx5: Separate restrack callbacks initialization from main.c
>   RDMA/mlx5: Separate counters from main.c
>   RDMA/mlx5: Separate flow steering logic from main.c
>   RDMA/mlx5: Cleanup DEVX initialization flow
>   RDMA/mlx5: Delete one-time used functions

Applied to for-next, thanks

Jason
