Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0D02125EF
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2020 16:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgGBOQ3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jul 2020 10:16:29 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:28265 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729474AbgGBOQ2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 Jul 2020 10:16:28 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efdec380000>; Thu, 02 Jul 2020 22:16:24 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Thu, 02 Jul 2020 07:16:24 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Thu, 02 Jul 2020 07:16:24 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 2 Jul
 2020 14:16:24 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 2 Jul 2020 14:16:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGdpuOawtbmDISObHlQQ/g0EOEjVoo+HG7OFlKGlUPw/9fFbLeEveA/UsRGe8XDZsF2mUVTyhAszrrI5ApV4T/+sMDqxlLm9FVhwtd/Wl1iSYgOPPe3S8r7Y7dmXB1VbzZmCCL8NHBMKl5N+BF5sED+2Xyq8bbxsQ+6jGDurBt5Wq6ybYIgo1ypxnaeudEAams1ed7g+B0yFUJYDr4l1ZS+hPvOL0fvJsifMW7b1Sj02QoQa3tvE+o3vuF3/BmpVaU9BDemcUpYkNn7faTiNZLnM3STlJRkkI/wtolY6r3ALfS0WRKbd2Y+XzXix9HnxwvJK9WSK/DSRx81+7KsFSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qoBrjD7FKoWGtXqHAL/ltxYIjms8nmcij03Ys1YSk+s=;
 b=ItVkcPXgy+QAmUPFzRXh7DoYNoV3kZ4haK2b95rwEiH10xy9Pi+4KIfw0dHKdNVyLXAKw4RXjkbaSAapIOlduwAXvSwWm7BcmownY/tfiVb6RRDRxzBHHtMoVn83VCHpcTkuB+sVUDicbCU6bi51I3E5sJbpUoa2BSxHMo8XM2hVH7/qNZsj01xgKaIo7T34gx8pA4rD7fID2HJvStqfhuyNVbDKJ6WLNafrDCeoZ2S+jElqPS9uQVIpEUUZTuJZtVy0l8pA2tBKXms8G179gjPnMi+UM63M4utq3CX4xzHnMAADKwEy5XB9l+uLILRO6KQ72uz2Gae4UVfUX7lUNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2860.namprd12.prod.outlook.com (2603:10b6:5:186::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Thu, 2 Jul
 2020 14:16:21 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3153.027; Thu, 2 Jul 2020
 14:16:21 +0000
Date:   Thu, 2 Jul 2020 11:16:16 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
CC:     <linux-rdma@vger.kernel.org>, Doug Ledford <dledford@redhat.com>,
        Kamal Heib <kheib@redhat.com>
Subject: Re: [PATCH for-next] RDMA/ipoib: Fix ABBA deadlock with
 ipoib_reap_ah()
Message-ID: <20200702141616.GA698336@nvidia.com>
References: <20200625174219.290842-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200625174219.290842-1-kamalheib1@gmail.com>
X-ClientProxiedBy: MN2PR15CA0024.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::37) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (193.47.165.251) by MN2PR15CA0024.namprd15.prod.outlook.com (2603:10b6:208:1b4::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23 via Frontend Transport; Thu, 2 Jul 2020 14:16:21 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jr00e-002vgB-AI; Thu, 02 Jul 2020 11:16:16 -0300
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7eccc7f-76aa-452c-bc56-08d81e927e9b
X-MS-TrafficTypeDiagnostic: DM6PR12MB2860:
X-Microsoft-Antispam-PRVS: <DM6PR12MB286081AE8BF52212976EA272C26D0@DM6PR12MB2860.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IRYKpJA48H04ghSDrtFPzFFBJ/Wkz+id3Xb43DIdYjOYe6hbIgTEPMSE8XiZDvv9upkKNPIQ2Vq0Rgd+z+Mwdl2YkCPmA0y6ouEWiXCwHkWFzKr/HE+7zqoJhLYT3HKWiyMwlc/gxnM5wMbqz/+g4dnVnREKEmlSHwoJ7jOZ0Sz98Ynfn70Ksjma3JmSDy9UrlQpfhgrpIMPm5j2aAWvrM9k97Y2jQwloZCvHr+2DHS8tdRvp5lkcgPpXIe4V4uJwO5JHX5UK/cQkM4qLsYfYQEHXsXYh1E8b/F95oKWaCImKkTfVMKHEoIZN9fO6G6SnICW2Le1dRyA9LtIvzvWQ3Vg4+MYbgdtE530URvli0hIHrpmgZ2Zp06LAWpg4Gnd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(4326008)(186003)(2616005)(9746002)(83380400001)(9786002)(66476007)(66946007)(54906003)(66556008)(36756003)(426003)(1076003)(6916009)(33656002)(8936002)(26005)(86362001)(316002)(2906002)(8676002)(5660300002)(478600001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 9vP+oBwpX5r1+t6OBgofXTd1ft6hpu/7qQcLDyt1p5+adDs5mKDmpdBlvJvCUAeBUU0MQwu2p3edaK+Nz6a72ZUKWubtz09hP9UFVrMzooezUA0NCNzFing3SEjPcm2BbxHj4yW3KW7GSCBV3NV5Nn+SWTxtA9RnftZ8LWmsZxyj2do0h5tjlK8MDIcFwmizCjmQQJvzteEzIiynwVJUrSIOnzP6HgpVg1Oi3x+3oy8HF9gxMY+BtSS2NdStGNu9rCJurC62ySNfQY0DKK2i8EEBV4N5hd21teiCzz5hXX7zVgqME5DgCI6J/1ujB0BNTu6c1bU1PAY/WuQ3h3PL9iSv0vlZYb7Yf7YeqPYhwOP38RRMtKxV42azQ5NIOrlyS0TSCBdrRtNVO7xnJauia0Uf95Gy5qaNfOcA/eCDasq7t+aDmIYqJjxpEgphfkGivSCuUx2Gcd3EIVLjbDACnfkPmS3HUNHOvJKWO4A9aGdFfwoX+2J8llV0YOv/NXTZ
X-MS-Exchange-CrossTenant-Network-Message-Id: e7eccc7f-76aa-452c-bc56-08d81e927e9b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 14:16:21.3038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: veglXsUUZV5azfMQz5M6d08oJBnnrKjL0iGbc01so8KGQeLZ1K6IHVwFtLLGxfmd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2860
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593699384; bh=qoBrjD7FKoWGtXqHAL/ltxYIjms8nmcij03Ys1YSk+s=;
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
        b=M4xampXqth7n/rPn/GjA+zsH40PdHrsPhtM9U+ZWFaHN0mymsMwBMiF43cWpJEeAm
         sW24ZW+rGh8KkaTb82Lu0QuXmJcapoXHrGcEVqffOtGT+fzZfY3sAGoxP5qEsC3ocr
         BeUe+aqLfv2ZWuDGt3KCtup74gni0nDVjKfVgJcgErwtoYPjvemJkev/R4cAgMMzFD
         XmH18bGd99VtkqXBdSu1f8IrF1KmvZhw1P6qkgdk8acGGYQCa2Kekou1+9HEprbj6u
         c2OvUBAjx5mi6i9kuL/0tGRBxVOte3Fy7ENXBfhEVwXZdKzCHHUaLfi8G8O4oNITv4
         u5f6SwgF2N1Lg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 25, 2020 at 08:42:19PM +0300, Kamal Heib wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> ipoib_mcast_carrier_on_task() insanely open codes a rtnl_lock() such that
> the ony time flush_workqueue() can be called is if it also clears
> IPOIB_FLAG_OPER_UP.
> 
> Thus the flush inside ipoib_flush_ah() will deadlock if it gets unlucky
> enough, and lockdep doesn't help us to find it early:
> 
>           CPU0               CPU1          CPU2
>    __ipoib_ib_dev_flush()
>       down_read(vlan_rwsem)
> 
>                          ipoib_vlan_add()
>                            rtnl_trylock()
>                            down_write(vlan_rwsem)
> 
> 				      ipoib_mcast_carrier_on_task()
> 					 while (!rtnl_trylock())
> 					      msleep(20);
> 
>       ipoib_flush_ah()
> 	flush_workqueue(priv->wq)
> 
> Clean up the ah_reaper related functions and lifecycle to make sense:
> 
>  - Start/Stop of the reaper should only be done in open/stop NDOs, not in
>    any other places
> 
>  - cancel and flush of the reaper should only happen in the stop NDO.
>    cancel is only functional when combined with IPOIB_STOP_REAPER.
> 
>  - Non-stop places were flushing the AH's just need to flush out dead AH's
>    synchronously and ignore the background task completely. It is fully
>    locked and harmless to leave running.
> 
> Which ultimately fixes the ABBA deadlock by removing the unnecessary
> flush_workqueue() from the problematic place under the vlan_rwsem.
> 
> Fixes: efc82eeeae4e ("IB/ipoib: No longer use flush as a parameter")
> Reported-by: Kamal Heib <kheib@redhat.com>
> Tested-by: Kamal Heib <kheib@redhat.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/ulp/ipoib/ipoib_ib.c   | 65 ++++++++++-------------
>  drivers/infiniband/ulp/ipoib/ipoib_main.c |  2 +
>  2 files changed, 31 insertions(+), 36 deletions(-)

Applied to for-next, thanks

Jason
