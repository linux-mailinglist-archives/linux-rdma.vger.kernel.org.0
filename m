Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8A125C443
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 17:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbgICPHc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 11:07:32 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18459 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729478AbgICPFh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Sep 2020 11:05:37 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f50f2990000>; Thu, 03 Sep 2020 06:41:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 03 Sep 2020 06:42:33 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 03 Sep 2020 06:42:33 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Sep
 2020 13:42:32 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 3 Sep 2020 13:42:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROALkc5O615wSuyaQwSor3gyBfK+YfMC3F4TICkfZhisMFHxZZ7Y549L1Yoj4e8/wXcUy7poMsJTDiH9ykjBfY8ne7awdGoSRELww4WmgyfwO6ShfdTtUh1J8zP1S8MudFqEGhJckZz/Ya6ZVgNp4orCDUcKCPpw+EGGyfMHoDQC1MOy0BoEpfSgqoLlFb8L0DcJhVjhtY+7lB5ACrNdrQ1CJKmboOG5xyn7kTQETDMoCKzqDDXbJSDEzZpCSo6KJ60JQpvHSe8YMVz66h42I7imXD/tsXchcwashtiAb3Lq4PhPB8e0+U+LuHjXwjIoU2qw/FEdB6WlskKJg8/jCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tugTEMAaUkoKbnwNRZyadqfK3FJPMMX8u+6/ehQvjZ8=;
 b=CfX0lZc3/7aMf/UdPhlioB2oGVlW8O/i7EBMQ+22cQ6Vlj/aAdAzEENSyyQt++j/lQTPrywjEaMzVQiMqvbmNq796C2j42j3KtcuA1gIa7KYxl3g/Dvl2dP3zeL9u4X/PsGcVg1xlMH91fQMnk4JJVSCR2HyfdiACeEY1hYcY5PWIyMe1sjrTKsRrJGAr9h4RFu3K19KPJnhAH2h/4KBxgaSNVhxWS0Vm6h0qtl55sdu1uLSXkMeZhumMSSHQJmpXdBDq+v4b4JAMpEnGL8fdFucYrxLLXNzIY4xBgCnknfxG1Loit4BW/Yoe34FaXgtM51qzvr0+vnNg6MXwpRCSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1147.namprd12.prod.outlook.com (2603:10b6:3:79::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Thu, 3 Sep
 2020 13:42:31 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Thu, 3 Sep 2020
 13:42:31 +0000
Date:   Thu, 3 Sep 2020 10:42:29 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        <linux-rdma@vger.kernel.org>, Or Gerlitz <ogerlitz@mellanox.com>,
        Roland Dreier <roland@purestorage.com>
Subject: Re: [PATCH rdma-next v1 04/10] RDMA/mlx5: Fix potential race between
 destroy and CQE poll
Message-ID: <20200903134229.GA1550019@nvidia.com>
References: <20200830084010.102381-1-leon@kernel.org>
 <20200830084010.102381-5-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200830084010.102381-5-leon@kernel.org>
X-ClientProxiedBy: MN2PR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::11) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR07CA0001.namprd07.prod.outlook.com (2603:10b6:208:1a0::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend Transport; Thu, 3 Sep 2020 13:42:31 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDpVV-006VFC-Lc; Thu, 03 Sep 2020 10:42:29 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aaffdb00-90f4-424f-3c80-08d8500f34a3
X-MS-TrafficTypeDiagnostic: DM5PR12MB1147:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1147E81E7FC8C356941BD4ADC22C0@DM5PR12MB1147.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4mgtFwFhlR7CyKnVDkFCzRFUObVoLDU5ic/JLiahvo25hVRKZnDKM8EALYVaBB2+yT/rGyf8EBA8KJLq6r9pqLhBQrgYGkyHfmpW6ft8n4PCaRmK+Yq/lcuZOoWf+e2GZIx73JqKVyV+2hMZQkBfUOrrEOhZSVS2TOX3/35rTSJStRo7T2CZoxHVD/xlxVM9JRW8IXuiH4EGMtco55OMP4mFvlnfo1HY/5w6527Bh7l0g00qvKq6lKitOgCzOl/rcdVRNcffiAKsC1OGFMg9Py1dJKCLL/DXG/Rk1Ngrusv6YYgKMq2/qprmBhxamN6m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(186003)(316002)(26005)(8676002)(83380400001)(4326008)(5660300002)(4744005)(8936002)(6916009)(478600001)(2616005)(1076003)(9746002)(86362001)(54906003)(2906002)(9786002)(33656002)(36756003)(426003)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: OVy23FpX4yculkXW+Ao8cJFEEH6g+JKAF8+RQfKrRotwrPTxcTZyGOj3w6s22epPqTeyaqiAEw3G3plf9s8QbD9HMcXSzU+bzOSJVEIAobNq7ya16JykVvG9WcTcCxqNI5V3ryXKtyTwNFvz5BJ21E28t0nGhIfFy2RUA7vq60oC7Jdm/rfsCYB0wKcv/XunAkeWm1PL0oU3nhpexvhZpZVpT8gsdbms5X5W8b1gC3n1X5dwhLzlfAZleh5X1g3b451YNRN6UiPmuTVwBIe1ppSyKCzph2IGEvpT03jGEdnXZ9teFauEy9jBoNK8x9UWpkubNo9ZrkP2DnLmTkZZZbNyOaaXSSiJluJHT/nkTqPn7G8stKJm/BYrJknsDod1664B1t0M1VdCJiEnu+paTC7X7klN5ZX8YuvO351RMqvSTQruczMfxCDarX46RKYaLImE9wJYIYJJVjQO5uyALafB8EU1zyu84yc3gy9KnAIicYeP/H78NqFXMtVzrXiglo5jx4crjhY6MXdp+wVD3/CdergjJnvsmIY5DF+nFXS8/X6KCDsNHNw7ws38ps0nLOk/VMS/Sz4MvMA72ZcmBnjgEh0OdXKf0fN0E0C+UwAg3CSpYLxlBKJGgpm1IAf6V0aH6ju1NtKhybORxS5eTg==
X-MS-Exchange-CrossTenant-Network-Message-Id: aaffdb00-90f4-424f-3c80-08d8500f34a3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 13:42:31.6056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YlZbbXD4si2ofqvKH5c+J417H5brrHuxT5sNO0S6rGIK+7SAxSiXt82ehMXQRN2V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1147
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599140505; bh=tugTEMAaUkoKbnwNRZyadqfK3FJPMMX8u+6/ehQvjZ8=;
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
        b=SLwSRlH9gQTjkH8GT0P4kAmNUYqTiseg0IjjcZ0dK6TTwmM1WPXaaeizfw4S8/U/0
         M1McdZWiA3Li7t5AOGXwVsbqH9MOsBKL+s9BrQ5bzngjpz/wuLkv0p1b4l8RdjiWyV
         832IhOwavIasO6ZswMXEQmwl7Wvd0BVILKrnFAEqEWsPbEH1XbNnRzBFhySg2dUtCc
         VHeKg0OoHtUEmUa97dFRIxbYXfvLQtmvmpqcoAFP+eLtY9EdNfEGEtNw8/TU7H+prR
         B1np2X0vsAVMExTZ3hXv7S+NrPqt82S3l7zT1deou4b4K4/AZnNtJjNtZZzUSRhbfA
         zL4+t+pR3xwag==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 30, 2020 at 11:40:04AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> The SRQ can be destroyed right before mlx5_cmd_get_srq is called.
> In such case the latter will return NULL instead of expected SRQ.
> 
> Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/cq.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied to for-next

Thanks,
Jason
