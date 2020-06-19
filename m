Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A45200893
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2020 14:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732884AbgFSMYw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Jun 2020 08:24:52 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:25766 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732980AbgFSMYp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Jun 2020 08:24:45 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eecae880000>; Fri, 19 Jun 2020 20:24:40 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Fri, 19 Jun 2020 05:24:40 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Fri, 19 Jun 2020 05:24:40 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 19 Jun
 2020 12:24:35 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 19 Jun 2020 12:24:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l646lrU8jhJoj3KO5/qRfGv274fX1U8v+mz6wHf4sfgZqGHhtN2b6Nimc1bVEBfSo2ve7lc999+menY42ey79fPk/x7avgYcmtl9kEU6X5vKt0O40rIDt0NIN9mL/0PiEAxmV3iT2QwD0KsjebNtvnp6qh+Jl8toM+MKQOZGWN7AjvZFEVV52/caCzFPyreWcfTtCMPg8uYClgEeEwD7i70CNrNBr0zYYJbENnB5pj1/T1wrX7205QPc2jatLB1lbRpMGA6XQF7IkP7FUOeRPFQg0srVQ7pJ0RdC/ZQ8h43HZfhKDzG8wHDBssckBAla1x3MjtVWlbXKfebNuxr3Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMjsf6SU3aNOljpBWeDfL95al3UN1h0Pf4CqEWHbQkw=;
 b=DcctrW0y0wKczGv7ZZGKR+UEebCBesAXgC8lwqVu6IjHchd2MIRCb73G2nPZ5wRKkLtCk2t7R6EFhYKhipYFJqYUpt+Ulem/VkTcdhG0wxS238HQYz2FHOPuyUjSPnSadD0c7d031xIXnXfjr+3FvqguWe7HAIhsieJrU3HtmpOwSlMQSZDsLKZRt8wpXrZXRX6wws2PCB8w68LcdsQzk0LuoQAkMtyL3AKp0EOHt4QCsB/HcpJKixFTTONfEzKBkuqr1ymBDqR7kKxSNJ2f1t2ox4qmHH/q+9lIlRpbyfQbZ4OEfX7+rsePX4MgNXbvHRRu3jy0siBx2ajb4S805g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1146.namprd12.prod.outlook.com (2603:10b6:3:73::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 12:24:32 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 12:24:32 +0000
Date:   Fri, 19 Jun 2020 09:24:30 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Guo Fan <guofan5@huawei.com>
CC:     <leon@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] IB/mad: fix possible memory leak in
 ib_mad_post_receive_mads()
Message-ID: <20200619122430.GA2562811@mellanox.com>
References: <20200612063824.180611-1-guofan5@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200612063824.180611-1-guofan5@huawei.com>
X-NVConfidentiality: public
X-ClientProxiedBy: MN2PR15CA0016.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR15CA0016.namprd15.prod.outlook.com (2603:10b6:208:1b4::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 12:24:31 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jmG4M-00AkiG-3x; Fri, 19 Jun 2020 09:24:30 -0300
X-NVConfidentiality: public
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4e9f720-5084-46cb-36cd-08d8144bb7bd
X-MS-TrafficTypeDiagnostic: DM5PR12MB1146:
X-Microsoft-Antispam-PRVS: <DM5PR12MB114683DF0EA78494FF63D61EC2980@DM5PR12MB1146.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QQFvPXIjbSoobrjiGHgN79R9r6yCmkkVTd7ATHgA5SOidzCFg9ILRAl6aPTc9BedVTK18yYiYMSdkNOnD0THehKxYEs5Sd7YNWD1N+ZZe7T3o8nIq/jGDHaXqcI2ETO6fzCZsgSChenuovVIdcfXnxfsecXgSHTzKlXL1seBI7UC+mlIiOZyJGM6eOwjbsheo1fzcGiXj2onWDUkDUvvJ1ecWPP2um6qVk1pl7Ypz9+2TLxrlGZb5CsLP3W33RSS9wHKfuePzbbtdgDA/hE/2X30cl1/HjYY6tVVy3z5MHkKPfLxgGSBdMw/oz65/xsW6/e+ErC/IG24w0eVaddP7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(366004)(376002)(396003)(136003)(39860400002)(4326008)(1076003)(426003)(2906002)(186003)(4744005)(8936002)(9786002)(9746002)(36756003)(316002)(33656002)(5660300002)(26005)(66476007)(66946007)(6916009)(9686003)(66556008)(8676002)(86362001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 3pgWskPjdXEJr7zCEOCS454u4eESqs3h2LBqnvIFPhqJ0HqbmXa4dNNZF6d2CEXmfCs4Ko2O+uJ5b0/qJjNlCoKfoFp1CfRQqusC1YixK2x24TRRccR1bUNYD+6tk3Huz3A3GUv7KxwCk0h8QXtwd1pja9SI1I1B+7E8g9ng+yni0Gq1Dmt3Yv8MA4ko8pahiHRs8SKOk4cDiNAawyvGMjxOORmfggKi15WSgMwXZ/r6VSB1FN22T8Kx2zxLm+WKzSnenjRgskcfBTiOeMpCN7r21UQGU70Uu7zkcX+m3NoQF+6M6vALTzEPHssKz4+UJMkq37y1Qp2tgrMTzEFg3qT0S0iqMD2YxQ82uUS3KfXPosWFAnFmVfmd6pkkG+0907UNxmWzbIsa3IuzY4FrpTX+UOCYBb+YI4YXsyXwoJIiB8jWNH1nwoIR+9vGSK5RJlMm1N+jFUbDXBIcrsXYDptP37uAw9ZXB0INOedC3nA=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e9f720-5084-46cb-36cd-08d8144bb7bd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 12:24:31.9253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0mis2LjVCK5644F9sLHbBkNtq2LlL3zWpDy1AXuY4FmioxWDQyy/0XOYik6Ugle/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1146
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592569480; bh=tMjsf6SU3aNOljpBWeDfL95al3UN1h0Pf4CqEWHbQkw=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-NVConfidentiality:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-NVConfidentiality:
         X-Originating-IP:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-Forefront-PRVS:X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=IAborRMc0UohlvNr3Y3kJfMkL7Y+33EokU0Hsb+sLAXpZ/ncOkGqn+Kmnf2f2d4Jj
         1r+7Mft0t4HRPn+VkoOXq45+J3SRSVQWlXSENsjmPkc6OAm6aW+bMhy74xQWYnlpNB
         pX13OOLS3GtBky98ECsL4HaXJ4pztGVNKUVino0Ch79CYBXuBVfuwD8iribmho6JfL
         GLZPMLW9P52a5BU2UP2RWRc+JeO/67mel94Zu5+8QyBoJVDX4VXA6MCE9pagsRCnR6
         RUvdM2G7BrSVv1NoKiiEwLpsX4NvE8QTdyyicskdzxhoK8GZwU5J9+8qLXpYNADIX6
         UkIsGjJS5J7vA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 12, 2020 at 02:38:24PM +0800, Guo Fan wrote:
> From: Fan Guo <guofan5@huawei.com>
> 
> If ib_dma_mapping_error() returns non-zero value, ib_mad_post_receive_mads
> will jump out of loops and return -ENOMEM without freeing mad_priv. We fix
> this memory-leak problem by freeing mad_priv in this case.
> 
> Fixes: 2c34e68f4261 ("IB/mad: Check and handle potential DMA mapping errors")
> Signed-off-by: Fan Guo <guofan5@huawei.com>
> ---
>  drivers/infiniband/core/mad.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-rc, thanks

Jason
