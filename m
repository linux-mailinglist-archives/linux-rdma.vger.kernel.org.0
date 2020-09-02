Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB3625B503
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 22:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgIBUDf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 16:03:35 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7956 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIBUDb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Sep 2020 16:03:31 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4ffa640001>; Wed, 02 Sep 2020 13:02:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 02 Sep 2020 13:03:31 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 02 Sep 2020 13:03:31 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Sep
 2020 20:03:30 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 2 Sep 2020 20:03:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYes3gvo/H543pHb+JRfS/N4Q06NoiUlEXMnOT8OXgILf876e+mSD5Ky5B+lqwxWpYubV2yueg8/I9GHnnk5sJrbgeXOPV+ErlwDjuGQbFsXVOf0ivzHXpgq8Y8tG8ddEYFPr8d2o2p/ljiDM9v0Cew9uTYC4t0X4TNkn2GcaW25TYJJzqPhaWWDxRcOfNHx/4TKFZw3mUEeaJfVCuZmsVUXDpX/Fm7DYZuxAmjx1SHpTaiXzkLleRdmR56AAJIcTNjZLdVi0gkY2pv0CCT7Ta8KsjGxOGqZ690CrLDSGW2AKJQhlyz+t0hgKvhTV9vp38S32iKiau+PC1IpDbXceg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/wFUMQLgs7fcjVJiL/P5N5oFiVax7bLuNzfDqkyajU=;
 b=jHl9djW7rWUDO+DCFTc0WMzjgJbxt6Eav8ffu+N6u3Nmp+cb8utBIwAkuo8b1tKm/uJG7UYAK3Mbeim4zHfeHq+oEfzL1NXLgvH8AIwdd9KiQOqsCFgJ7XZiNf2x4tHfkPNvihnmymkkDpum6cFDGWvOIp0B1AMU9PrwJK/b5VMC3Ta8c/bDgPUCXkttmP7MAjf5HhzKKZuEZaRqQ6UuE7lQyE1+73OANKMUhe4oRiRa2Bd92/7t5ZYAm6iASkHVOsX3CvYHmCbn1mkS5ZPVMajII326js8mf31YQfZCBP4PgUNBbFRxKhH0PiK+KPKjFMvk+tdTAj4dHb8OKCU/Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 20:03:30 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 20:03:30 +0000
Date:   Wed, 2 Sep 2020 17:03:28 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
CC:     <linux-rdma@vger.kernel.org>, Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-rc] RDMA/core: Fix reported speed and width
Message-ID: <20200902200328.GB1456344@nvidia.com>
References: <20200902124304.170912-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200902124304.170912-1-kamalheib1@gmail.com>
X-ClientProxiedBy: MN2PR01CA0023.prod.exchangelabs.com (2603:10b6:208:10c::36)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR01CA0023.prod.exchangelabs.com (2603:10b6:208:10c::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Wed, 2 Sep 2020 20:03:29 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDYye-0067hg-AH; Wed, 02 Sep 2020 17:03:28 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47783dee-6865-40b5-657a-08d84f7b4311
X-MS-TrafficTypeDiagnostic: DM5PR12MB1753:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1753619D15B3191B776E7B95C22F0@DM5PR12MB1753.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UMwBT0wAA73oCV8dY+315drt5qtxz/C+/xtq9AziBhLqPaWZ9Ji92E6Rubdy52Qq3JvHHaTvEUrCI/0hTgkbwFwpu7+5COzNzI8wOr7YwcDidGV82SE2PxFFholQTBc7NrQ/g30qzMHVfBqBcOoXdPcnVSf4sYRAiu6J9YSWKkMKmrnBbideQUikVhabcurCXvj3KNhCsKS9I8zDK/ho1Gm7aCdGzPo2C491MUEkb+XRP7V6WwKjM2btRyyONwWuJYc2odKabjp6XjrjdtDI4Dk/Bwb8AqaTSXu5a7ow9kt7lnIIQ0UMva6tFeVkQOvn+md0jGhsHCzAkQtIgamhPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(66476007)(9786002)(4744005)(5660300002)(86362001)(478600001)(9746002)(316002)(2906002)(8936002)(33656002)(66556008)(2616005)(66946007)(6916009)(4326008)(83380400001)(26005)(8676002)(1076003)(426003)(186003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: jFOW6OKzEz+N5Do4Wpd3zZnhgloDkfjV6JqfE+uRnBqUAYN8kSt4mZD9pvIT7XxCFIeuS2LnsK9jWNXWb26Cj5HBwzWePGB7im11N9297ruB/RAFirLR6rLqzdo/9OyrqpRdwU2YmojBOXHTskMtbPeqlhn0lFnrHGtI7vrLvxNmXVDCrf4UZ9PKMegpwbzyjArO/BjCY3+V51JS4gHVNQCgxsufYhFTAQ5a2ISzRlwwjMBYJNEXe4B9Y53Oy+ac7FFmbakL8OMxVKdNNUH0FzTjOxIgMjOODF4xz3Z6Vsve8taxeIRvVzb6C6B7LdcyPt1L2RM8nrnhgXY5RGI4O+NSABBNF+l7WV6Z+ZT0Koy0RWwRXpyzkCxInDAakVUUv3Eud1abbMSE4MJCN6YDcbznqzSVrwrdX/NAVpjNVdZsmP/KO0DfwayOI5nZoiuxCbyIziqemDwKAFRcVdnYCaYa3hp3NaZl7T+a0/7XjLJOFbdwaUdssQbp/Pg3CC5WDQeILkCe98bpRUECaCkzyFXhg4mZ/8+6kxln8RrbENXqhkV9ST9vTLV0vmqfL2VBFLerMmFj3KCmYPbfEwTpvqpc6xrLfjV545zXkfdZ6Bxxpb4v/8a6SsuDjk7l9z48vQC7+pwmSwFH6023TzQtvA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 47783dee-6865-40b5-657a-08d84f7b4311
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 20:03:29.9349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WPOZH5F+SehbdaJYA5WgqN27pH+XA4kB8dvgoq5VEmsO/S6f3/a6tcAsk3rtubTR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1753
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599076964; bh=X/wFUMQLgs7fcjVJiL/P5N5oFiVax7bLuNzfDqkyajU=;
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
        b=qpeGtquHJ9+7yWo+zxbmkRZPu+2v8dmekCG8+aVkc/elagWDp3ktRxJA2O8kPE5OA
         myg5QPAs+RSivJeuKSptthqONO9F2Xu84teEoR97Mfh1oq6G/x+qSEAOrtD4Ai7LSS
         YamvLZcWzaMoOkX/UNC/LyYmbW512NHxXQ8pAw41nYJiEICEDt85jkv50BfBTMPDPj
         5kx3QnXJmv0cdINJtHPCqAUcEXQ4tD8uZLCOgASdJLfYgEE/QTPIwx60Pjtf8gLfKL
         Ba9x1HqYk1UFAiIImkazr9+KGZiL/rOsmpWAOdDueljBL5r//rsIWS7h9o1ntbj44z
         B0lFHOLGtbYew==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 02, 2020 at 03:43:04PM +0300, Kamal Heib wrote:
> When the returned speed from __ethtool_get_link_ksettings() is
> SPEED_UNKNOWN this will lead to reporting a wrong speed and width for
> providers that uses ib_get_eth_speed(), fix that by defaulting the
> netdev_speed to SPEED_1000 in case the returned value from
> __ethtool_get_link_ksettings() is SPEED_UNKNOWN.
> 
> Fixes: d41861942fc5 ("IB/core: Add generic function to extract IB speed from netdev")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/core/verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
