Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDF22778AD
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Sep 2020 20:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgIXSqt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Sep 2020 14:46:49 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:1744 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727753AbgIXSqt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Sep 2020 14:46:49 -0400
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6ce9950000>; Fri, 25 Sep 2020 02:46:45 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 24 Sep
 2020 18:46:44 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 24 Sep 2020 18:46:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntFXdYpx1NoCYlDIqwhwIXAQrHkmpZmn3zwEFdOnfj0sCpNXjcI+dca3sxCPEgEUc9KBh/QyZJ3G3UjtolP0zlm8XYRTm10CFsnYiM+C9h0mO0AAV7zM60219q8e5DrpznL7zW1qcsNurrHP3SxgHz3VsEFAwXudaV457ECVwrZ2mo3gewmRouE3w+8zcwz3ff04jJkwv3OyRq7fgNiKyIJygkWJAasWsydIF+0Uckx1dIl7IX5G6UPQI3M5E3VxjjHRdsR0TAhHbpjeBFXJ8Gg1Mq3oT1y3IfqBPZXX2ZxoJsv4AWHPFU9cxgAMXB3T/3ASSP+H5L8iP96kGJGcEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BORE4f0tm1cElK5F0pbeukAzcAs30J/+2gj4TIaAUQU=;
 b=kbUh1+EUjnjBoylupXLIVqgw9RqfHRNRQd5DyqCO2kHvc5kX/Yw4TQVsSkkSvFmFHypEk/yvV2hxQlZpGMDK9XR8bGoFkwPh/Lo6GMvkC8oAx4h59fOpwks6/2lCcybGfGhYC952f49td2FW9qXhw9GxhpBsoc5QjlJ8szidxHmjGTJD/9mhvkBtfA0vxDPi1KAGritYWGusxTUBF3ZQlPxsW35iccwuHpFmKRBkIFfEOFIYXQnsx0KvQJIEIusT0LwU5VUux6zFsUMe+9rmX+JykV4EJ9glpy3DYxZxEs4b5Le7iW+W1r9FSyK/The5cAgJV2qyaAOL26D+4lBKMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2811.namprd12.prod.outlook.com (2603:10b6:5:45::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Thu, 24 Sep
 2020 18:46:42 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3412.020; Thu, 24 Sep 2020
 18:46:42 +0000
Date:   Thu, 24 Sep 2020 15:46:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH v4 for-next 0/4] RDMA/hns: Extend some capabilities for
 HIP09
Message-ID: <20200924184641.GA108559@nvidia.com>
References: <1600245806-56321-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1600245806-56321-1-git-send-email-liweihang@huawei.com>
X-Originating-IP: [156.34.48.30]
X-ClientProxiedBy: MN2PR12CA0025.namprd12.prod.outlook.com
 (2603:10b6:208:a8::38) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR12CA0025.namprd12.prod.outlook.com (2603:10b6:208:a8::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Thu, 24 Sep 2020 18:46:42 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kLWGP-000SFg-2t; Thu, 24 Sep 2020 15:46:41 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41fcfd64-47f7-488c-c80f-08d860ba2dd5
X-MS-TrafficTypeDiagnostic: DM6PR12MB2811:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2811D1C4D9447776920031ECC2390@DM6PR12MB2811.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pMKdAJb92IMUjdL+x5T+/xahGbIpko4FVZGdCNxGf907mRlqBrFbphBR/DVpOHVQdNyklDxSKKpNYMZUM8kL56XSi/kP5qa4qnjBm13AC8crtan8DtM3oLU+2t+N/XYhGLonLaP1zeJihxBKt4wPJ7yRzXwRYUCD9mNlxSNjpe04Rqh3JUGoYynBx+dTYc/HuSd3PmjbtyX28cR0uT8agqMLzqjr0InRJmWbyvQRZWyD++Sr+S8oUgmQZniocM3JBXyeS+fJzqv+pU3MOy4w2knbYKnH+f/GIKOOtBHbRb/Gr6Qtwojgbot8G3JDwSKVuoH1lS5s08LZrD6DHTXxYkuIgfDheaWt06k6D4GbEI6DtC8qx7Ix1y8nR39SAw/1XqEfxN4TiNJ7r0bCHp1EfVeCrDyCtG5ll8Np17OgS2BO8mD1sZ6tmxxhlQTpDI+Ug77fPbd91h6sbj6ZdaDY/09jr2GferpwYfL35G+ido6FbpqGDWEaj6QeDgCpcBm0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(86362001)(66946007)(1076003)(5660300002)(4326008)(966005)(2616005)(478600001)(9746002)(36756003)(6916009)(9786002)(2906002)(66476007)(66556008)(426003)(316002)(26005)(8936002)(33656002)(8676002)(186003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: kyRWni1f3nvw5LI1N65u7fgCKZGwRDRBSzWFyzFiS5DwmJKTdCJ2FqZn3dE20zVBnzQE/LrQKN2z697OK6xcJujBvU47Wc2oKpxFEb6aQd8frzfDmynPTjkbDqaNdBOqu5S+zPqP842NXHl1EHZhQZmpTwWm18t5Bu4yqHArC+fuBmdNKEb1dpQZOZfh8hIYJD7TWotDIZN7q93whTZOeNy4g4RweqaHmb1KgIql0hrLyCcgDObkDiF8mUzkFOgMFMBfX0ZCNgASVMpOlZpK2NHxZF9dygchsEw1R0/cincD3k2J+U6647F5VDUFulezAsdjQY4oZ6XQdUiwbxqX/lDzXiaNi/NNZlIfPIYl2UUOZ/MiHcn60DCcHhkBW9gbVRkUnVULdu1jL9Rw5+358CKjjJaKK/QJz2LSs5sWGS6sVSSa6hgdzTuSOigWtXhDuRfl50DQmMPiT2d6UZPOxZqffbZ9lUFRBmiFh07m3yQVX7IxZCCmm4K/irMHtGzZleZwRGeNuOBP/kh/qpfd8v0jXXmH0CwscQcnI93R1U1jZIkxWeg+nlDXhAr/UCdSLtU3NVr8J15ehX0pK6309bLT8xe+9hC6wZz/2wT99pHJ+dN6LNSSnOopEX2qdqBIwFAJYcxPGWWo56jVp0lq3Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 41fcfd64-47f7-488c-c80f-08d860ba2dd5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 18:46:42.5032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ekbxcWFhsMmApUOT8wS1dmBU70BBWPktsas87A8J5kIAC6PDCMrqEnG/1s2Qy9O3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2811
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600973205; bh=BORE4f0tm1cElK5F0pbeukAzcAs30J/+2gj4TIaAUQU=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
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
        b=mwVWqeNpVWvZ58zojCSyeFrv7/fiGkqPzjXWIUvDmEIszBkO6yplsdEJ48EQJp2Ri
         rfI6ibefAC3ETR6foU5TJT7+wlF1FR32b2uJPLWg69USI3KZf9nNe0JUfKbcKBjbHF
         IZrRgpuxhUhKXIB6/AQcc7qpqggvSZgN61eYR5f6eNJSUoAwp/3IWvhCb5PZ6NqYSc
         c/bxqjQahwHZLraRGnaRixhhDmEj4UuX7w/Mgvk4MR4fot+ferwyLaq95dc0b/tAzW
         QQ0ZSdZb3dW8sHajSEaAhFb0zZciqSqHl3lUMuUlkKenr+8UoFbTsOt56ZT0a8ewQ1
         wnSqQxF4XjjTg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 16, 2020 at 04:43:22PM +0800, Weihang Li wrote:
> HIP09 supports larger entries/contexts to improve the performance of bus or
> exchange more information with the hardware. The capbilities changes from
> HIP08 to HIP09 is as follows:
> - CEQE: 4B -> 64B
> - AEQE: 16B -> 64B
> - CQE: 32B -> 64B
> - QPC: 256B -> 512B
> - SCCC: 32B -> 64B
> 
> Previous discussions can be found at:
> v3: https://patchwork.kernel.org/cover/11753687/
> v2: https://patchwork.kernel.org/cover/11726269/
> v1: https://patchwork.kernel.org/cover/11718143/
> 
> Changes since v3:
> - Fix comments from Jason in #2 about the length of buffer to copy.
> 
> Changes since v2:
> - Fix comments from Jason about passing cap_flags to the userspace and drop
>   #1 from this series.
> - Add a new patch to support SCCC in size of 64 Bytes.
> 
> Changes since v1:
> - Fix comments from Lang Cheng about redundant comments and type of
>   reserved fields in structure of eqe.
> - Rename some variables.
> 
> Wenpeng Liang (3):
>   RDMA/hns: Add support for EQE in size of 64 Bytes
>   RDMA/hns: Add support for CQE in size of 64 Bytes
>   RDMA/hns: Add support for QPC in size of 512 Bytes
> 
> Yangyang Li (1):
>   RDMA/hns: Add support for SCCC in size of 64 Bytes

Applied to for-next, thanks

Jason
