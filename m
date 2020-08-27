Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779212545AD
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Aug 2020 15:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgH0NHH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Aug 2020 09:07:07 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:52933 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728870AbgH0Mky (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Aug 2020 08:40:54 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f47a9c50000>; Thu, 27 Aug 2020 20:40:37 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Thu, 27 Aug 2020 05:40:37 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Thu, 27 Aug 2020 05:40:37 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 27 Aug
 2020 12:40:37 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.57) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 27 Aug 2020 12:40:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9BUnUKoQ/QlwfVaFU4Act+VR8E+RhE8XgDGjleje4x5lNudeej5XWsGPzHJzMXRuMczAoRtT8RZrE75sBKSpeHgD9PiPMJMc+LH1XCYkLxHEQWf7Tj91a3XjYrh/NSXj6b3m5fsXrCM9eRjsaFcwz/6m2uEJsp2EsRvrzYl4jZ2k/loxMY4lJZ3IyVfyJbayE8d0HBE/LBeAXpkGkxFnCk9TTx5ZdTFXfTa66JPs1pb4IAm2b55Bd2yjzWx+G+Pl3UUVcn2t2Y4yWVnuPSvI9Jb2HryxCsgABam92+p5qlrJnTTbC6pAp+rJqPtTeFvXSw7DB99SZ92z3LDZOwqmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FcADxo/QNk4AOnXdeXBEf7npT8Vae4NUFCgLJrqHJI=;
 b=JM7NJLc8IFWhj3VXhx6VL1oY2a5X7RrbhKWMuntkLsO/hu7s8FclkhJEKYGajlY5ZapeKoIA28SRiqAYefmFmgHlP/RJJJJQJHbim3W7CebmUjBHfB5OhuF+Tl/9GbPv8Mof9Cn8PvYsAtjABMthGIiAUoViWAEtk49fE3GaJP9T9BJ5fCyf1Pb2DknNHS7EGpxyJjlVcQqJiPUre6vx7iSlNtI+0U30Af7SfkRZ/N880xwuLQIHczupjdBXtHqRM2pfK+NI6uxnkTNyKNHzEi8BgJD4bMebLOsmj3W+9cY+ExZorEcmI2nB+6odTKWkhQsaT6aaAIKFGo0l5kGbLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3209.namprd12.prod.outlook.com (2603:10b6:5:184::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Thu, 27 Aug
 2020 12:40:32 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 12:40:32 +0000
Date:   Thu, 27 Aug 2020 09:40:31 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next 1/4] RDMA/hns: Export hardware capability
 flags to userspace
Message-ID: <20200827124031.GA4023659@nvidia.com>
References: <1597929469-22674-1-git-send-email-liweihang@huawei.com>
 <1597929469-22674-2-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1597929469-22674-2-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: MN2PR19CA0068.namprd19.prod.outlook.com
 (2603:10b6:208:19b::45) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR19CA0068.namprd19.prod.outlook.com (2603:10b6:208:19b::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 12:40:32 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kBHCh-00GsmK-0b; Thu, 27 Aug 2020 09:40:31 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d37661a7-e9db-4d98-53f3-08d84a866327
X-MS-TrafficTypeDiagnostic: DM6PR12MB3209:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3209BD74B611B1C8E9EC914FC2550@DM6PR12MB3209.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NquWr2zPxrNLtlyWvmdNhrrXxjldIG+hio+CYGev9tWt673UFo2uAmPaYsjbJC6iWl2/nYZI51sht/JlsxP2+Eb8+tnTEbGCIZNtfxfhQ7uK1YqI1azyRaUQU74VBl8QmGZmIgj1raif8w2njvUZR1pHCLJFBC3IscviCdKxD+ucisnC+qJhVOk4d5ewcHBglBW3RgJ9pxm+Ya7no/ejsbS61z+x/ufjWsoNYIzonWWPjkIW+2A1Qp/RGAYsWKQiSZl+9n81HOqmcV6nr5ybsznNz8cBrVTkm31R/bpkCk5llkOD6Uv7OVBxzy84apxTC6koMzWxJRzl3xAPXInFWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(2616005)(426003)(66946007)(66556008)(8936002)(66476007)(478600001)(26005)(36756003)(86362001)(186003)(8676002)(316002)(2906002)(5660300002)(4326008)(83380400001)(6916009)(33656002)(9746002)(1076003)(9786002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: En0xBVo32G4aLRMaWj54pWQj15YiiNqEFO8xK4LU3dGEVpv37lwy1hUehdsDf2/hzgdH7epk52b3JVOpZAm7GMkraD7Bu5g96xSyGyQQVT1kyd/nrasGtn10ZsHqZn0aeWXgmMNxVgro50NnrsfdaZuUmAxIzi87GSosjs7/4iK3xq0ZlR0fj5/T3ZQhmycnwODAlIqIXTaMWfpG/XSsa/zyfQvq3MnTeJYho33GzU6gto/ctnObLPM1LHPJISsyOp4s9WqFwmKjpvFkN7pj3Wz09ivrIP7wafAzM9DhWPO9MhT991RHUKi/vE6MBaAxPHKbYLGh5p6MsB3Z4LVerqhX2OdXVTprRtZ6O/4+UHoISdxSD0aQZ61TK7hV5kDkneD04SPmlmLgfG3c4mcxS/fKy8YYP75zlNFUw559eypJENq9V2QH8a5GM4MDIaCQZV6ei36hUO45oZFnhUpMeMl470fHTYJm65qWSb/BNszp6ORSQW8mo9uE9srd1HvbSm/V+fkO/R66VlvAkA+MK2lxM2ITRzkg0h0H5el7LB75VIELZJywjSBZq+RqHBq2v9s5rgCK02kroeHuuklaEeBgR7vO2//XKHSZ+/gXTcmRwgkn2kh/beB0o2nQPsum+8u0K24+m+eGG9kK1W4JBQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d37661a7-e9db-4d98-53f3-08d84a866327
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 12:40:32.4798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kfQWPDRBditgFqXDwqQURjaem/PBoUwrgZwQVThOWG2SqQ3VzwqCRt1zchSYwyvh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3209
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598532037; bh=8FcADxo/QNk4AOnXdeXBEf7npT8Vae4NUFCgLJrqHJI=;
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
        b=KKsScAqbX6rgydN72d+tHYgAiqzf54qfVH6O2B6/+SDB73GalePh4qU3NkJvEfzt0
         UDDYlH7rfHCQWEsW1TsPlb62Trb3cUd2p07XnFdCotwSueQrwdalImZMgY1hzDCAt3
         sCuhNxdE128tJDnw2h0TM34cZ+aEzvg0L8wYeeSJxmCr7azjJcnYi1bwqgfv2viVnT
         9sKiYUfErlZpFKgfF59WZ9HT9+EHffFo5z327TlPFtv0BnoermAViP0C83v3jzKAI7
         HLDhhS7FD7fBgsF2bwnALl/iHcYFF5+IsSq52PzLCtb/mGrWP8HEiMVWHKU/+e8rpu
         Y2wilb6CRyJQw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 20, 2020 at 09:17:46PM +0800, Weihang Li wrote:
> From: Xi Wang <wangxi11@huawei.com>
> 
> The libhns in userspace for HIP09 will use the hardware's capability to
> enable some features. So export the hardware capablility flags to userspace
> by reusing the reserved fields in structure
> "hns_roce_ib_alloc_ucontext_resp".
> 
> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
>  drivers/infiniband/hw/hns/hns_roce_main.c | 1 +
>  include/uapi/rdma/hns-abi.h               | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
> index 5907cfd..98945df 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_main.c
> @@ -313,6 +313,7 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
>  		return -EAGAIN;
>  
>  	resp.qp_tab_size = hr_dev->caps.num_qps;
> +	resp.cap_flags = (u32)hr_dev->caps.flags;

This makes all the HNS_ROCE_CAP_FLAG_* values uapi, they need to be
moved to the uapi header too.

Or rethink this to only expose what you want to be uapi.

Jason
