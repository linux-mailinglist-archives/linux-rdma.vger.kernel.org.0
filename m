Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A36D25B502
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 22:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgIBUDa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 16:03:30 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:63891 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbgIBUDZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Sep 2020 16:03:25 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4ffa8a0000>; Thu, 03 Sep 2020 04:03:22 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Wed, 02 Sep 2020 13:03:22 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Wed, 02 Sep 2020 13:03:22 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Sep
 2020 20:03:17 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.51) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 2 Sep 2020 20:03:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKIKt+JwVTtBetdW2sk7TEWw6q1WqNgy+1ZWh2sCJFP3lvaL3ab5VgSjauZicnh4n4VEQtuYihj013RDc5IoJoDLydQ5huXOIRBkZtfDmucaeNfCTJfjzFnTa3Mox5rKx/2TzqMifjW440raWoNJxfc98FVeNpsivjDxMG9eqSl5vVy0JnbXbjHqmdAs8G0grKyoUimyaqCLxV4K4NMNkZLIIn51ZRKoLsvpsNuy1PqQDFJiI5/YtjVraL19DmmAAD7m7nOpiLpm0bEbvROP6+2IagJFSOkIItbTtTMpbuhAG9nCuiQXVgqDYqTZyub7Kl8JiUqL7Ft6cfTmuxpV2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kYsq0Hg71kxjOURYuF5fAT0KvfzJmVcf7+V61sDCns=;
 b=oBbvmVlkL0Aet9xfuLLPog78x6BPitvlO5+7bXl6CKd7G1801YikP4LPeoHONV2xh3l5wsS/jFhS0ACtyjezoXEECy1CVe9qaxPgFF3wzzqJoPrWIAsX5KfUFt1LhCFaOe7cW3BgJwUurmI0WachRD2ODMO5ZQyDoysCiCJASk2dOqpATCj2GQwobQPGy4ILBR0GKP5oapy1pqDe6ejA6rlC9Y5gaj/5PBRMEX92m5inzCGRYtHQBICnkbwJdu0AHfPXk9ru+EWOiViTt5cfzPtfESoi+D/1xwicA+sLugMkaMUUpjLjjvfdYDztaDUUWfk+lB1K3B5LVbIBWdGqeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4513.namprd12.prod.outlook.com (2603:10b6:5:2ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 20:03:14 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 20:03:14 +0000
Date:   Wed, 2 Sep 2020 17:03:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH for-rc] RDMA/core: Fix unsafe linked list traversal after
 failing to allocate CQ
Message-ID: <20200902200313.GA1456344@nvidia.com>
References: <1598963935-32335-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1598963935-32335-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: BL0PR02CA0084.namprd02.prod.outlook.com
 (2603:10b6:208:51::25) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BL0PR02CA0084.namprd02.prod.outlook.com (2603:10b6:208:51::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Wed, 2 Sep 2020 20:03:14 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDYyP-0067hK-5J; Wed, 02 Sep 2020 17:03:13 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 852ed717-d20f-452d-b9c0-08d84f7b39fd
X-MS-TrafficTypeDiagnostic: DM6PR12MB4513:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4513B6BF3A0E7C604A27DCAFC22F0@DM6PR12MB4513.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M/4VzYIJppPwYwmqDIBhwOyxA4xVFzgDOlBTi2dxxl8MCxNV8AirGJTSjzZlYIA/AMd9UxcZktp8PhFhHqSS3G/XddswrUiKOG/jNTM2y8/tehMOchT4DnJx8AOerfUeWt+Ove0WUfk73Wi9RbGENIMYN+4tQsp+OikjesXq/5qzW/lR6c2aPQ/+nVybEwWySyBeH23ZBIRn1zJjy+AZTIbkm2eDYQIh4fduHTDPJfQrgnOCPwFCPmND2UJeEInQSL1m6VVjTkjAeI4O7Jd9qlHAxzFgj3o34RDkoFoNH+SZN+qK/O1oJ1GpxQOlcacV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39840400004)(346002)(366004)(376002)(186003)(316002)(26005)(426003)(8676002)(4326008)(4744005)(66556008)(66946007)(1076003)(86362001)(5660300002)(36756003)(478600001)(66476007)(2906002)(6916009)(8936002)(9746002)(33656002)(83380400001)(9786002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ZzCnaqSVJs8zYoZGwg0hQkVeXY+Odc7ip9NswLdhq7V9zug0tMSMJiD7e6v3azDbIRt3arBrHEywFntq5ZeCwPbOuz+pguhUbGeWEIqM+hF5+0vkBtzq9ZrJuLjh+VNtWw8lnaBk3xZ7axdmQMqnX9HPzb5rMnOFIgX7Fm2GsaCyQ4KgLYbMvsEFpww0eGa9Dvuejqe5Zf1r7CZafHY9gsE9t0my5qExZSuMzYe5+rdpU5N++BrxCnqrMP/6NVsFYByeji2MXmbMiBab+SXZw4jHujYEBIOX2ASyChmlDb71TflZFlrM6OFoN16ouSjneZ7fiY3C1h27CWLUO8oTtiu08jgmp+0rlLkLC7oudRXBM6+KWGcChVdRQYspG8whe+IpSqrRQ6B4Ob4d7C8snwpo0sENHS1s41NoB+CnPksUqnCfcdc8MFISvb16LMso1ZljJjPSpw0qo2M42kyYBu7EcYYypFt4CfViKIrN/pGGPLbB2qVbyBbliWo3GW2Zwpc4EGa57abKWFhjVDp8pgt6i+vjyQkjv7m5iMMeNvPr3TM9thU14WElx0RhWF7alD0VhYW5IhdRTCfM9jrvlixSXDsVbQfN64M531KdSbPwAWnlqs0ZKcQvXX+ENXTGaZ2Jk+9HE+xIasyUgy0+cw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 852ed717-d20f-452d-b9c0-08d84f7b39fd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 20:03:14.8284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BItiudZ0q5Z2XdpXxGEI7yqXHxgDMdiHLBAXMcCypcy1rqIjoweYVxwsjtzRpNDR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4513
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599077002; bh=1kYsq0Hg71kxjOURYuF5fAT0KvfzJmVcf7+V61sDCns=;
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
        b=gGWKjK8jSkBzS2gcvyepNutBEJfeWjBvT+pm00z+LpKN64VXx9e3iCwCfBR7gahhu
         /GFZsqAo/R1ZxYCMEovYfYwZwfuBFyGLWKzQUyXHCEl3s2/N1+Rqn25Nofgt6US6Zh
         QMEaWppLuDyUxUoReC+8ZBJ+gqUzn+J9OzwDMxRpxnv/WCAw3ZoKAxFlkDuYLJQ0EY
         oatTRIbDxV2/2p03qoofmOV6/2GdiuUUCAaZrWAiJja5PoCfwVPFnZ1hw9KjEc4YRA
         Kl51ZIHPyOlMGnWtgXBc2rX95ADxeT4Oa9bkrPw1lwQK3Vsw65QbLOe1tBzqb4e3HH
         6RsAwCw6Krngg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 01, 2020 at 08:38:55PM +0800, Weihang Li wrote:
> From: Xi Wang <wangxi11@huawei.com>
> 
> It's not safe to access the next CQ in list_for_each_entry() after invoking
> ib_free_cq(), because the CQ has already been freed in current iteration.
> It should be replaced by list_for_each_entry_safe().
> 
> Fixes: c7ff819aefea ("RDMA/core: Introduce shared CQ pool API")
> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/core/cq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-rc, thanks

Jason
