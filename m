Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C0D222311
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jul 2020 14:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgGPM4i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jul 2020 08:56:38 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14890 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbgGPM4f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jul 2020 08:56:35 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f104e0f0000>; Thu, 16 Jul 2020 05:54:39 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 16 Jul 2020 05:56:34 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 16 Jul 2020 05:56:34 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 Jul
 2020 12:56:29 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 16 Jul 2020 12:56:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=do96/Bwb1jA+040YXL92/YTzEcEpwXF+Myiy+6a6/y2TQRjWq/F7I/UT0NiLZvw/SwCCc9wCmWa0sfPsAFXAEz5yvbsSGGZA/DjGZvkYqtAMI+FpdafxiIIQM5zUAhVCNQYqyRoeyeJO2Sk62cYzZFPu3FFchFG6gnjFe8RIioqB3InbovYSqQ0dnHa2BVewVlYiNf9581V0wvNNF3wjoWqmgwMyEPIq/inkyYJHha34ih9oG0TEYsdLXWfU0R4CyD2/o9HMhXZv+oOYL+lg12Rl7eaHk1FHM3nJ2msRmzXhste4rV0aUMMrBV/BUly3A9pdhAtfVhTZtrbOoi/ruw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00WeDnwgvG+2+DsjiJlDNEUD5aXYPsG12z9DDP/6Wfo=;
 b=cKkDzLmNlcUu3WX2DvctLsqhYamxmVW8KQ9vBYUZJv4EUXXIudp0u73d31gkEizUea6+DidZGJ5oRlFxXaQZWxKbu1oTu21WI5U1arLv+JVzX4KirmuEooV/Zq1vAdy9yRX0y7cmhQo2lGfyawckRL+W8JaQDysIlz1wYaXCeGWrp8YpsTHn+2kUpTDCNrl+b6ccFarakn5/U3N7ta5wm2fmpHDKhiZQDI0y2zqZXW6RFrZZQeMNK/z4tag3bhwXwmtYrGQ3g1Skb5O5X/14iBWAKF/dXrTApi8KojklB2YFxNjY2MFrVHlfxUrgDAbkyJdUfct4e2jnEXyBkWhIqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Thu, 16 Jul
 2020 12:56:28 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3174.026; Thu, 16 Jul 2020
 12:56:28 +0000
Date:   Thu, 16 Jul 2020 09:56:26 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH for-rc] RDMA/hns: Fix wrong PBL offset when VA is not
 aligned to PAGE_SIZE
Message-ID: <20200716125626.GB2615760@nvidia.com>
References: <1594726935-45666-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1594726935-45666-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: YTXPR0101CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::49) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTXPR0101CA0036.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Thu, 16 Jul 2020 12:56:28 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jw3R4-00AyUp-RA; Thu, 16 Jul 2020 09:56:26 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28326a7a-09c3-4202-1b80-08d82987a7ba
X-MS-TrafficTypeDiagnostic: DM6PR12MB4235:
X-Microsoft-Antispam-PRVS: <DM6PR12MB42353DAF3D20344C5C62FBF7C27F0@DM6PR12MB4235.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LUIqwPDyZAWpoynm8kJxTNlt/VW81+URROwKe1cXbx3Yenq3CgxW0313sGBm8G4SMLx0DQPiTeSIRFtKKYy+VPNJpR7sFvfWSEpLwMcMt7DQ59R/NPIRL4QmGZcjT3LnPwpMbNweSSyZ1oxgGK1l4wyM3EdxtME4JIZL3GhgLfz2Z0sADb1MtOo3aqRRYua3ImsnAYrZW0mkPrbl+j3hUUetaL6Us0dzhp2kZm48ZNAph7PCTENJUyEEtN1RiaUdS9JpbjcunWeEP+X9cCjib0Oif2blRlVnAZ1NWjcyclHZ3XjEnmfviPH72+hBXZ9wN07tpKqOqDAqpZts1GfvOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(478600001)(66476007)(66556008)(66946007)(4744005)(1076003)(26005)(186003)(83380400001)(86362001)(4326008)(33656002)(5660300002)(2616005)(426003)(2906002)(8676002)(316002)(6916009)(8936002)(9786002)(36756003)(9746002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: EBdnFHbd1Nk0mNrOTqxLdU2WPIjWWfjsCp+Uk0Wz0KhZBGqUJvMgP2safA8k7EwBfFyaUDJV8vLxxGjY3qenNVVN+YPN4opKgt6WVCOeHxRMhu/MBRObfQCQGo0bBAw+ZT4MqsFpVwW8ilOQ+a11KmBO6tImxA3RLCjg/EFa3pyQOZUbQxcIfDYPozauMBIajzjUfAjryKR50C6EtjfAiEh2cexZWxxSR4OTrH5smvg7GuMRLZirL0sB9GbEhGqje8iLV4+CbcqmPd4X4zNaNylQtPqfk8lmYHXwJZpjC+/+dWXZdAqYBYVCW95Q9UF7R7Ws1w/Q2+2b8EgILXx4JyMk8wyQ4DLyWDSZeHEPrnatg5o1y95r5/VZyeAUN3TNRw01EzyAT61OiT0zO/hUWY+zVhvqrdtCusWmAx1mGLIqKwKfkRj0W7xpwqVLvraWr0Sdfyalqf+Wn99pXDHaMS9Dq7HCGVNd2BRdKrmDhb7VUkLIU6WtMKDocDL3i9Qp
X-MS-Exchange-CrossTenant-Network-Message-Id: 28326a7a-09c3-4202-1b80-08d82987a7ba
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 12:56:28.7209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dCLgPpFt248C55C55iwRfUpC1WnZpg2VMwrhzKMwZHRcJWd1T2YP20Sl3fdy65l5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4235
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594904079; bh=00WeDnwgvG+2+DsjiJlDNEUD5aXYPsG12z9DDP/6Wfo=;
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
        b=fkVOowdRTRa8QxEBDLro2L6KM+RjA1ffKVvDDB2GpfduofLykBa/k0z6r8N52jctu
         p8Ag94qk0GRQEFFoRXkaYyfu58ewo/WlAr9ApBNA1zAk9ILYa8vZ/sODsE1awZ4iQE
         ojB2HmK8IpY2ADyoFdAQkQnjMURSDBObNGmXsjkvy+m8+nvlrBTshOyyrj6fehp9DQ
         FCrpAu5937LhdJkzFyJOEJzaOehLUa2VtlaBHHFmpEfx0ZsXg/i1Q08bVxRVr8XTlR
         HyXaLo3dbgr+HbfJvlL5b9A7khXY1f0MLRI1nUkABRzkphFOBGRDJ4BI0QVwbL3ZFt
         FCFST0JL+xVYg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 14, 2020 at 07:42:15PM +0800, Weihang Li wrote:
> From: Xi Wang <wangxi11@huawei.com>
> 
> The ROCEE use "VA % buf_page_size" to caclulate the offset in the PBL's
> first page, the actual PA corresponding to the MR's VA is equal to MR's
> PA plus this offset. The first PA in PBL has already been aligned to
> PAGE_SIZE after calling ib_umem_get(), but the MR's VA may not. If the
> buf_page_size is small than the PAGE_SIZE, this will lead the ROCEE to
> access the wrong memory because the offset is smaller than expected.
> 
> Fixes: 9b2cf76c9f05 ("RDMA/hns: Optimize PBL buffer allocation process")
> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_mr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
