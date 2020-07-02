Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA64212640
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2020 16:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbgGBO0n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jul 2020 10:26:43 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7991 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729271AbgGBO0m (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Jul 2020 10:26:42 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efdee950000>; Thu, 02 Jul 2020 07:26:29 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 02 Jul 2020 07:26:41 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 02 Jul 2020 07:26:41 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 2 Jul
 2020 14:26:36 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 2 Jul 2020 14:26:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOszU+ess7wnSYG6F6dVEJLGvqrEIx/gYKYmkHWAPGeKzaXbvdAnPS8LHqdxvyqQjZuYtUpA+Zp/JirQoH7SFJc4Sjs0BEZkz0DhbWzi4c4uBuK9Iv5WGUskZNGPbLVK8DxInTZLY/xI6k33yEKABrolKhFrmRkn3Cu7iy1L2DkkydYyjbm0fDRyKmW68FcnoYgQMlB5oNSKX3BZM/nyKPAz683jKps3JKj/SjOhvILbsMOWmNQvXeHs3QiIeQbPLH68OhFY9XlghfY6LkKpfc2N59SVDfAUDS0zGjJ1iFHuoZZSfVwzP8JXy19+Wp5f2D4k6yZWTINZ3c34sFVRHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPcb6Z/DeqSOgJMdQJbXrMeiNC5bIhPcA5zCqUkWVdY=;
 b=G7zPJWttTvAd7TswUuHSIsB7qTfH40cMQWw71scXzAZdmvTkXxGmkxrp9TclzJiZO0KALBqMuMrhCFBKeU0t2FIo4O9BOqlv2+rB9PUoUfptqZWt081KE/rRSpXr3vQxYwq/bOs5BOGXpiP205L4OMILzjRwbccQcl7E2KN8eKcVhhb4trkpQZL+J5TLz8epRPy/jZNe8BekkIaN0YYM9D7VJzdebnQKiSfRiHL+CND5y+KrFr6dPflBFeuHv/zWGhsOsabNYyzusr1Fo8ou9pjM6QiDtDSdyaupnUWnIfy+pT/YqtroLCOY33UZJxPPs/fND/kCSFY5IZNXT94zHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4578.namprd12.prod.outlook.com (2603:10b6:5:2a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Thu, 2 Jul
 2020 14:26:35 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3153.027; Thu, 2 Jul 2020
 14:26:35 +0000
Date:   Thu, 2 Jul 2020 11:26:29 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-rdma@vger.kernel.org>, Maor Gottlieb <maorg@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Fix legacy IPoIB QP initialization
Message-ID: <20200702142629.GB702824@nvidia.com>
References: <20200630122147.445847-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200630122147.445847-1-leon@kernel.org>
X-ClientProxiedBy: BL0PR01CA0022.prod.exchangelabs.com (2603:10b6:208:71::35)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (193.47.165.251) by BL0PR01CA0022.prod.exchangelabs.com (2603:10b6:208:71::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21 via Frontend Transport; Thu, 2 Jul 2020 14:26:35 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jr0AX-002wqh-DQ; Thu, 02 Jul 2020 11:26:29 -0300
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f428baf6-0dbe-4d78-af05-08d81e93ec88
X-MS-TrafficTypeDiagnostic: DM6PR12MB4578:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4578D61EF34DAB73102F88F3C26D0@DM6PR12MB4578.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X2as+fXw0F8lNZ/YWYRSzQ9qx/afoJiAHS1eNLiV/dlOAr1R2YiQ82W5L4UNWos+xUtRTv3uegrYwvv0qdWMgOYPyZqbGPVso1JufxC4NZqhuwGVnYw/iUKDo3W/HsrBj8nSOhm/OGKbDcwZX50tGWLxrJLeBAgxTPmR4AwB2OeItI9sMRC/eMej4eefaHRk1SF/046GcOamSj5o+prY2JyxBwUqJwAIEuCitZXIGLbse1XkZeBTy4ysysGpM1w/5Knpvk1CYVgD9XT5SsDoY7+JNQSFNjf4Y4vdxjIwt2InGNSqmr1bg69JMERz6/IJc0oW+wtsKer9rm6n1IpeoUcfMFfixQFd6yqVtvvLPR5zCBMEF43ybIkqmeGoB/P/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(26005)(9746002)(4326008)(9786002)(2906002)(316002)(33656002)(478600001)(1076003)(2616005)(426003)(8676002)(8936002)(86362001)(66946007)(54906003)(4744005)(66476007)(186003)(66556008)(5660300002)(6916009)(36756003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: h6TAi3d2D/p3EHcwc74BRsKWkfA+Y/Jahz3GNMH1R9Vf5I1jlzhgVs4QRGCum+5+tYdR0u6Ii11Pr/X4bXoDlQmaguWFS7ANweYxkWsc4f6rm1OyGS0RYCf+AvPIOF+c+/VI3tHAhsDvScnWsJ6hd6Q0kfi3PJqhhaFonKS52jsjfrmaPWXr7bjf/zq6SKRm/bYFet4O20IQv326fSC0AnzHwbo2Zvb2XACevXLYrt0mOmpgczDn0i5wi0J9ed4b50eoQYegZ6BrTMfmXAzPhLyHgd8LxjXRx4j7nBWUQEYX/BbjxhdFCgVQqrjfdbioDGdEeGdNnFoSEZmWdwINBv+clwzNYmIDZT/D/XW1xihGaARXzmo7wYSiCRdv9E8NLFtL2FMGdDjpjH/uSNlre/krg1O8cXxesiClibAiXJnATPIU6PNLbAoKZ99YRkEaOz/deg5LO5nWNi7wjJKUCrCCwpjZNsSfyAQa0WzTQAILIf2jABWt2G+52LCIQIWw
X-MS-Exchange-CrossTenant-Network-Message-Id: f428baf6-0dbe-4d78-af05-08d81e93ec88
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 14:26:35.1351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ERzFX9uX0iwlOSl0Qvt5yqAhyiFdGbowYtSKc7zRZoxml8bXtvyb4rvZGFrm91W3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4578
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593699989; bh=UPcb6Z/DeqSOgJMdQJbXrMeiNC5bIhPcA5zCqUkWVdY=;
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
        b=fwEoP9Df+zkKpG5FP2DnNiJti3flzECzlXcUn7LbkURn0bRg7dna+F4ppl9c+d4az
         MgVicf7J4i/f0e/r0A3Yk3MU7yyHXvrNFt29xQP/RQb1FI0f3utMbgIwsVjGKlnyEE
         BNKSg98Mb4BohsmcJAVqYWUluE0eE7NVVAiyZz9iVl5PxvgzZedMGmO+XspwROh/JV
         YSiTdLLHPH9icmRWKcxh1TlhfeFqzyQkkJUzYj/YhBtHcHndtlK7cwfZQZiK0Liftb
         5Vep2zWrvRRyMRFcryPjO4uKc3M1lY/oL3gyxIv3jg/9DBSSGemXEYVYvWbNZzZkkE
         1NZRGk3lNK2BA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 30, 2020 at 03:21:47PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Legacy IPoIB sets IB_QP_CREATE_NETIF_QP QP create flag and because
> mlx5 doesn't use this flag, the process_create_flags() failed to
> create IPoIB QPs.
> 
> Fixes: 2978975ce7f1 ("RDMA/mlx5: Process create QP flags in one place")
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/qp.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied to for-rc, thanks

Jason
