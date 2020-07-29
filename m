Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8083A2323BC
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jul 2020 19:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgG2Ruc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Jul 2020 13:50:32 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:14080 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgG2Rub (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Jul 2020 13:50:31 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f21b6b90000>; Wed, 29 Jul 2020 10:49:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 29 Jul 2020 10:50:31 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 29 Jul 2020 10:50:31 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 29 Jul
 2020 17:50:31 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.56) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 29 Jul 2020 17:50:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAn7rw6Cx3Kx0ygDFazmnzh05J8Fzqu7QDZ+KD9RFcBG6B4A4Cz7GKfGAb+3FUKhYaZJfoEZeAUoyjym5XWw8/XVDrjDx0dh2UCxURtGw8R79HqcBu7+wEP6dpY79Le0451qVwmW7JXaC1DuTe/AFxN99c9ZGymfD/HMC/rEDHcAlZgT9BJonN14Sc7udAgJDin1cfXnJPjJmznynwyOp+am1PvjWYqQJ3z97p0Bb2kvzuq6CMhvibiR/KiNjPLczveIHW0Am3VFS/2GFCIaQrxGG56ye13QJoHqRt24QZZLQGZFwzkJY7spwzjlkchJrDpBkafwYor0BDfficmyeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ho87PTluUL2oBJeGRkY+Tl7/qptW7p3vNZh5wLfv29I=;
 b=ZEhDacfuxUKnwObcCyVOsBlMzNnNfFH4IgAjI4eYklv2Z5vh22cQQZdag+KicjIx3vJHNvfJfd7pCuTzXVKm9Poy4tEBRxeQRRySrzWS9XGgwx+c/j+3hHRePJTDIJM08/YpZ5X2HDxL33ZY94Pz/fusz6Utv7U6tR0FeW/CDfBL64ChHoeCjl+x02jqRYewRbDxEGppLMT7f3p1UPr7c0ULfn1kJtuMFUPlIWhQ3EuFaqD0GkkMA5ll/9VFSgL/x5Xo6odjHPZQ+PQTA7dnmwjSP6wOT6mQZvsyu8BA6hyFIHk9i1aFp5sr5ancU2ot1/h7y5G3qYoCrBUPVVfF7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3929.namprd12.prod.outlook.com (2603:10b6:5:148::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Wed, 29 Jul
 2020 17:50:30 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3216.034; Wed, 29 Jul 2020
 17:50:29 +0000
Date:   Wed, 29 Jul 2020 14:50:28 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v1] RDMA/include: Replace license text with
 SPDX tags
Message-ID: <20200729175028.GA270873@nvidia.com>
References: <20200719072521.135260-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200719072521.135260-1-leon@kernel.org>
X-ClientProxiedBy: MN2PR01CA0043.prod.exchangelabs.com (2603:10b6:208:23f::12)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR01CA0043.prod.exchangelabs.com (2603:10b6:208:23f::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend Transport; Wed, 29 Jul 2020 17:50:29 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k0qDk-0018Tm-DB; Wed, 29 Jul 2020 14:50:28 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f95e6b51-aa08-475e-9ea6-08d833e7e1ff
X-MS-TrafficTypeDiagnostic: DM6PR12MB3929:
X-Microsoft-Antispam-PRVS: <DM6PR12MB39292A077537D37EC43E36ECC2700@DM6PR12MB3929.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:568;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ARx35D2INNBDwPREyLOigFo8mwHLzV6gCh5+cSmTyx3Xke8I/dxR8Ye16nQTkaCA8Pqjb4nblIVidV3OPJtHx53FA/B5LMb8hNH2pFWFcgtxs3KdGK/t0juY0lo5knlWb31ntZBuWxCje/neTrWtPFQ2U6RIBeBkNThJMq5gNpxBzfOEozZPRNbAX9kJi6AFN7LZAADvjgoK+1ysgwz3nn/VLVo1UmF9dviJwFdjbUk9Zrw8fb0AvpPcl9oKmshhpO+HMQSOzt/xNRpEYafnaNifohQnpxHOrcDn7tSsrL3z1UuxXjRiOnEakdQ0Pp2QZGTUGI6+nDYCR7plX73TyICs8TcSgnOgr8BbRock154c03DBRsIk7y879ASLvW9UZ7+Eb2T2M9sCeh+kkP6xyxhITJZQKyuLTtP47tK3EpIkuB4RIIxzz08OsofphZ9+chq23moavrGwMLHYzQQ3XQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(966005)(66476007)(83380400001)(54906003)(8936002)(66946007)(1076003)(8676002)(66556008)(2906002)(9786002)(186003)(26005)(36756003)(316002)(478600001)(426003)(6916009)(33656002)(86362001)(2616005)(5660300002)(9746002)(4326008)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: je5CrNENLBo8AW2BgAs0F5y1q5GMU8FYaEMwzZ7leuhiGqUcAks9XyhEreXIGgxmJP3MQUmwyLAQNJkxUejDckIzf1/IzHD9MIYde+4FZh1NkeYeLchkOrlSntfYzROj1LjNOZmJVdX74vqxoYbo5UBPWHu4oLh1WYnunYfGYjHjmkY6uQPQ5lrfPMNepphP1QFwio/zU1TRp6iUs3oyy26U5ydJPFmLlU4e7TsaaJL8/nJ2QqXxMnn5S/1pO2BbakCDCgJaKYS9ZwcILFEAGV0JTbg9bmbiwKVDmSv7SbuLnQmj6xEtakwNy00SIoyML6lo+Vnhwae9kXaOMejBGAw7FrrvfP8+0meodcfh4btnUHS80BKqosL+n1k9Sua7kuaAvSe/WDkTVqqu0Rx2yKCagZtfvgtIMNWlyYamy7tvR92mmMxWYDwKrow3A2SNVJaQJ1IZAHJA3rYRZID+GXXm2kVleDHGaidDhKo1Hlo=
X-MS-Exchange-CrossTenant-Network-Message-Id: f95e6b51-aa08-475e-9ea6-08d833e7e1ff
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 17:50:29.6752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gYGGLEfLO+Cj/xinlj70ghyrRPpX0FbxKfYSYSYZ/HTA1ZaYBwvY8LggDK3vJp2/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3929
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596044985; bh=ho87PTluUL2oBJeGRkY+Tl7/qptW7p3vNZh5wLfv29I=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Exchange-Transport-Forked:X-MS-Oob-TLC-OOBClassifiers:
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
        b=CMsNn/+9dE1xYq2z6KNezSgvJl+DyBQqcC+y8FJTraF3PTI5qPBO2rLbFcXTyyjc8
         ovkCaahJBy+hxysDxpAfhkebmYcNafar3WWgvW1iGTfFKeXcQ0xPsqG76ye3h6p/g5
         UwjINM+u9n1e5i+bdH417gl7Pql1w0zLUxpM+W6rBn/s5+YNYcDvDY0xLnow2EfhGA
         5IdmsINcBpUKYyQx1IkGVkncyP2RbFOQ+LHMjxmSOueDYnrPv3N3Q2l+3VSU0J0Gwl
         +GXy8xNcYmLpGbR5WNrs21Jzzh5xQKrYPauDa4FDQ4J4HurosvlVES5UE93GPMq7x5
         eOuJVwh4hYgDg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jul 19, 2020 at 10:25:21AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> The header files in RDMA subsystem are dual licensed and can be
> described by simple SPDX tag, so replace all of them at once
> together with making them use the same coding style for header
> guard defines.
> 
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
> v1;
>  * Used correct SPDX tag (BSD-3-Clause instead of Linux-OpenIB) on
>  relevant Intel's headers.
> v0:
> https://lore.kernel.org/linux-rdma/20200714053523.287522-1-leon@kernel.org
> ---
>  include/rdma/ib.h                 | 31 ++----------------
>  include/rdma/ib_addr.h            | 31 ++----------------
>  include/rdma/ib_cache.h           | 29 +----------------
>  include/rdma/ib_cm.h              |  1 +
>  include/rdma/ib_hdrs.h            | 44 +------------------------
>  include/rdma/ib_mad.h             | 31 ++----------------
>  include/rdma/ib_marshall.h        | 31 ++----------------
>  include/rdma/ib_pack.h            | 29 +----------------
>  include/rdma/ib_pma.h             | 31 ++----------------
>  include/rdma/ib_sa.h              | 29 +----------------
>  include/rdma/ib_smi.h             | 31 ++----------------
>  include/rdma/ib_umem.h            | 29 +----------------
>  include/rdma/ib_umem_odp.h        | 29 +----------------
>  include/rdma/ib_verbs.h           | 31 ++----------------
>  include/rdma/iw_cm.h              | 30 ++---------------
>  include/rdma/iw_portmap.h         | 30 ++---------------
>  include/rdma/opa_addr.h           | 44 +------------------------
>  include/rdma/opa_port_info.h      | 31 ++----------------
>  include/rdma/opa_smi.h            | 31 ++----------------
>  include/rdma/opa_vnic.h           | 49 +++-------------------------
>  include/rdma/rdma_cm.h            | 31 ++----------------
>  include/rdma/rdma_cm_ib.h         | 31 ++----------------
>  include/rdma/rdma_netlink.h       |  2 +-
>  include/rdma/rdma_vt.h            | 50 +++--------------------------
>  include/rdma/rdmavt_cq.h          | 53 +++----------------------------
>  include/rdma/rdmavt_mr.h          | 50 +++--------------------------
>  include/rdma/rdmavt_qp.h          | 50 +++--------------------------
>  include/rdma/uverbs_ioctl.h       | 29 +----------------
>  include/rdma/uverbs_named_ioctl.h | 29 +----------------
>  include/rdma/uverbs_std_types.h   | 29 +----------------
>  include/rdma/uverbs_types.h       | 29 +----------------
>  31 files changed, 59 insertions(+), 946 deletions(-)

Applied to for-next, thanks

Jason
