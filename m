Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5162222B27
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jul 2020 20:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgGPSly (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jul 2020 14:41:54 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:51737 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728400AbgGPSlx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Jul 2020 14:41:53 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f109f6e0000>; Fri, 17 Jul 2020 02:41:50 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Thu, 16 Jul 2020 11:41:50 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Thu, 16 Jul 2020 11:41:50 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 Jul
 2020 18:41:45 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.57) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 16 Jul 2020 18:41:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAedCO4PA6tmV6l6tFld33/0pEbqN7aIrj+kMGmn/K0xg/F32AW3YXsPMQVSU/JaqpEm7qutSSpqY2LvYtpIL5z7pT/TjwK6hIfvFVQ54Amh12jsYPics9pdqONz/RIvAkMoI9d53IfCo/CJ7DRMIq9URwrdCZSmQCkmcEkX43sLQq/2ooi3UfN4WpTnUrxq/p/p6DtMpM9Hj4JbtQmybtMNrujd9u6XvElxFhJ738Px9il7edu5b/kJU6PLV0FITzkgcwBB0qYpSRABnjylYPUp7lDaJioImzdA7vR8rP6ZjhnXkKCvrZZIoj3ZCw5HcZyHbp2ywdE0oPnnEWw/Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWhqucuf0zZfrisGd1zU7Gaz8laCOALtGKkmzxVB3V0=;
 b=Jec/Th5E/P9ZGvbd/1t8rW0Y3Q7e+MkG2UnAbbeCEVU9eJAISLlT1DxwyMSlD3cFqO36gOlDDvtLRv4v+TQISWJCs4pzWUHYouXvjqLWzWL+4Dei4IFztJOcptsN3auB8sbOLkGD173dXZP+gChtkH/m53muyT/rzST7NUpeOqxHY/jlY8bHtB/sVsJRR9juH+G/GdWVy+eFLQR2zpb5z1NvjHTZsAv6NqYZLaq8kQhod5j6Q2R9bpPeG2jlsKoGoy4nJm2V5D0A2LEdsgQyEJ341HBSqzW5pHdGt4Y1O0CyjmY/GTjnsEcg7m61rBgDpIqvDq2EomEi7f9BGoi7kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4498.namprd12.prod.outlook.com (2603:10b6:5:2a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Thu, 16 Jul
 2020 18:41:43 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3174.026; Thu, 16 Jul 2020
 18:41:43 +0000
Date:   Thu, 16 Jul 2020 15:41:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "Leon Romanovsky" <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2][next] IB/hfi1: Remove unnecessary fall-through
 markings
Message-ID: <20200716184141.GA2660905@nvidia.com>
References: <20200709235250.GA26678@embeddedor>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200709235250.GA26678@embeddedor>
X-ClientProxiedBy: MN2PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:208:d4::41) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR04CA0028.namprd04.prod.outlook.com (2603:10b6:208:d4::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Thu, 16 Jul 2020 18:41:43 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jw8pB-00BBkd-Kn; Thu, 16 Jul 2020 15:41:41 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f3e53d3-088d-4fec-618c-08d829b7e2a5
X-MS-TrafficTypeDiagnostic: DM6PR12MB4498:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4498707E7366D2513D1A84FCC27F0@DM6PR12MB4498.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: StLxJhnKYqTxw36GnfGnAbDMMB90gz1whn4IrQ3XGOeZ6zMIK89uSTnk7jDSrjE1WI94t3DTGaCt7ttdx1P5+eA9jNin3ZTm5+7DH0Kw7OD1CNFLBe83qt8EyTLroK3m32rMp1I1CvUTIxgpP+X2GVRnQ0ZdvUrRPUc+KH/sBaKZnrF+MGuqE+lvDbvDTMuDg3YfMwWBemSx5Az5Qh2HrWePL4OZvs9SRPhxqXTwBqsKvnavpSjBzR0o7rKSYyIHA4uzEYUzYR261kIBKXMcbIxFaG5b2/It0XVBT+8gw7HeebqM8fgKQkvwira0SYpcw4xPAltYAD9olvkZVeW8/haWIGGaEdLeC8xsklbDatnXJ/hC/nBj1hHYhCtg6BKyTXh21xeBbCcUYk/LlugfZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(54906003)(966005)(36756003)(4326008)(5660300002)(478600001)(1076003)(316002)(66476007)(33656002)(186003)(83380400001)(9786002)(26005)(4744005)(6916009)(426003)(66556008)(8936002)(9746002)(86362001)(2906002)(66946007)(2616005)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 0SCQmXscmEPEGZAf3EcCwyd3ckj9odJoWRLatzm1lS7cY0JfJfhvVTWkgPyjmmtlD0B4kQ7xtViV3JrAo8uevsNPZBFJ9eL5xtplzgPeLI7EMj+/rsypM4irGSL64JLbO++LcCgC2gFrzLTYKFqx/0C3+B9z7RCLHNBmGFuLf3YfmNcVvRTQfZ3ggBqaWjLhggQxDk8JsA0uNZKbtP/xRDxP7HhVZVLEmcC8Ek1iwWfOkoP58pr3nAHmiBv1M+/sx6bT9Dc1CK/IhA/tyEKrCjwh+pwyixuc3u4AtZ+w0AHHWdQRMZnWZbeqBAGmCcuK2XRHiWeQBCRQzdtv3jUMHz4nYIEIQS20Py3pGTKqpxD8olIDk4B1XK7dXSn2xuM59SUOYjKUlU8HoEYUSX21c3deXNCEfRIIOixkPD2xX/Hvs0+oeyW+84fopcKbkS6VpkK8U9PWy0soAP6IKFJVfn2YHA0fMNnHeLU0xrqO0LE=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3e53d3-088d-4fec-618c-08d829b7e2a5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 18:41:43.4886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPM6fYsqbUJDKMmEliqmDbWem6b3l7zlQLDG81hbnhNcp+4GP7i/K5cLjXgLKFIM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4498
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594924910; bh=PWhqucuf0zZfrisGd1zU7Gaz8laCOALtGKkmzxVB3V0=;
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
        b=GgeJMSBXTvk0jPPtz/4PUIgpWWf093SsPwaPC++gK92atiHzuue2VHj31ykU565wT
         XT2PduMZuqRsF8etHs0l9SasteoXd6NW+KNYzhcnQISVhgenjvcVVl5oPEyzRlVKib
         hNgI41Qh3onM//+GzdX56YiFg7y5kDtg7nNP3WuadednfLgX5r8P/Tt0YZ17K9b9KH
         l3jLeZ5BRK8qbehIfnYzUbYjLlyAXwRRGQyv6gIvKAX4m1bzNpE1Msh1nVWSe5Hbff
         ePaYuYDVvCwymNohkV0TBga70T5Y0Tmz/SvEaPlPoAdGuNWIfuzVtd2QC5CSTpK+jm
         Nb2rFEmTUGIZw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 09, 2020 at 06:52:50PM -0500, Gustavo A. R. Silva wrote:
> Reorganize the code a bit in a more standard way[1] and remove
> unnecessary fall-through markings.
> 
> [1] https://lore.kernel.org/lkml/20200708054703.GR207186@unreal/
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> ---
> Changes in v2:
>  - Remove additional overlooked fall-through markings.
> 
>  drivers/infiniband/hw/hfi1/chip.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)

Applied to for-next, thanks

Jason
