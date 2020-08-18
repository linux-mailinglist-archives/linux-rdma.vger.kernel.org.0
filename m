Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D7A248BAF
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Aug 2020 18:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgHRQdg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 12:33:36 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6632 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgHRQdd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Aug 2020 12:33:33 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f3c02a20002>; Tue, 18 Aug 2020 09:32:34 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 18 Aug 2020 09:33:32 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 18 Aug 2020 09:33:32 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Aug
 2020 16:33:32 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 18 Aug 2020 16:33:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrFMeuJr36zf5Nq9qxxpLytOHBduavdg81UgPNDX4sp9ENY9EAAT2najW8UnVns4STOGNORgY741wOQsXPzxxxulywnhr7aBkb2Pm4XBnNbMe0IRjvqaHu5P5qr+gG4PNiTi8a2FB6naYcG6XCpHW38eSqQT8LFYIsMHnH33//K7zOYPJjcO0jUXGi56/kQyXFLM27UobAESn3I81H9Iv/a49rDNj5gnpQwmXxgz7fM3Lt2D8pV+WeQFNi1ng1MQQXKhmNMZxATNi7mKeecThvdMohbs1e5ZLiUSo2cbkhF/OB0QqLYYannzAG4sOk98DtIdU0p1PeeE1UyPFb5S/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPUrImA0zgXG0Qp8LWe0Z0/mmmTGNiasTBYIRKR/Vk4=;
 b=NcWrRJzRvh3f7M3QWx6bd9khyAVaBNwdYxQeOEJCBmoU7VDk9O8GBVJttybQJFCatjBXAb9tbgSjL3YYmGXDy1fFX3a+/hOF9Q+YvtyPKe2krOqAEMjPoMarb5gHvpMxhIaaXFginLyP8+hGzNIEnouWCA7o+UH/o4pGImxyiMScZPOOj1swOp8NYe/kDq4zXNkaU+Udyixg125gLkwlqBdKLInnreSAt+o4ua2mceVCKNKKv6/5FrAaR5d7vXPqicwHIdrjdixR680QiYoZHAV8w/oPjidri+bXV8cUGIXw2LYPMsIYkZ0t1gUdtRlO8lFOd+HWsMoWqTkPjElOsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Tue, 18 Aug
 2020 16:33:31 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3283.028; Tue, 18 Aug 2020
 16:33:31 +0000
Date:   Tue, 18 Aug 2020 13:33:29 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Colin King <colin.king@canonical.com>
CC:     Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/usnic: fix spelling mistake "transistion" ->
 "transition"
Message-ID: <20200818163329.GB1990081@nvidia.com>
References: <20200805141459.23069-1-colin.king@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200805141459.23069-1-colin.king@canonical.com>
X-ClientProxiedBy: MN2PR01CA0041.prod.exchangelabs.com (2603:10b6:208:23f::10)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR01CA0041.prod.exchangelabs.com (2603:10b6:208:23f::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Tue, 18 Aug 2020 16:33:31 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k84YD-008Liy-VM; Tue, 18 Aug 2020 13:33:29 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbeb5680-0ff7-4e31-ebf5-08d84394717d
X-MS-TrafficTypeDiagnostic: DM6PR12MB2939:
X-Microsoft-Antispam-PRVS: <DM6PR12MB29391232464CCFF90D7EC73EC25C0@DM6PR12MB2939.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Unkcrj55MIE37uKNr7xt6bpItrfuLZebMJpO8lBhCVU7MxudOjrITn1gLX+uzBouNGH+K9Wljlblq+yGr16I4wJz3UWrI8R4A8HGvDLyJjm/YJ/lmuTJbsGgbCC4k6dcZnBcSeCo2bAH36rqoKXADVAuh8EC79WHcab63xVXJJDdplZQyU7OPWNFGezBQf0WWYEP++PoMn4qV/7yodlw1o2AuCF1jQ6DG36nodKS0c6tMAgHrxx9g+0AzEzEUCltNCfbLBLDmH8fR/3h2hqP/NXsS59mZIalDbzQeAoNn+WIRpUFZ9chpk0vCYUVxv9GiedYjZfMSTFz4sL8z/rMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(66946007)(33656002)(9746002)(9786002)(83380400001)(478600001)(2906002)(8936002)(426003)(2616005)(6916009)(316002)(8676002)(186003)(66476007)(66556008)(1076003)(4744005)(36756003)(54906003)(5660300002)(86362001)(26005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 1FnHRWfa4cwRqaRbke8tVHwK8B4UrP58rJ15TzR4sqa2mJo0NMHdAB7/sJ7FfW3tkcPxMkKpUHpf7C5iUNdgjcLNb3bLFglRVu5nPExaFMRhX1MuU68ALmqCjptJv8cMyvpHmjjVaz31uD3OA7Uf8DQUtVrTn53J7NHTx9i6oChixLR7KgAi+pCs4yXiFZgs1ushaL7IC3ejoF+FwnQns5dQn3pVQzTuxJHrGrf1r8IpAlGAnJYOl+9kjMm8RW1ssg9rrtoM3R0enwnFkF7G62g+kvHXjEBCY2zbK+wCvNQItJRO7ZDEjAmDiQlqVysyXOnBTVmgc384/W32e8aM8HNfc0/TE/LYfp+aB01gT9iLwCpuVKbcrfnFKCnIgC+8sfBbJWyBkTq/skHUE/gJv6IHQ0nT7tdN0cK9z/q5LtjTT9yo3wJ7DFpVu75y0h+ITx8X/Z/do9L2WsviEMViuNN4TXW0jw1YtpGh11EwySJHmK9v3RZh5Doq/xf0zfoHDNd/ooh1W4pe+ZXejkXr6SB6e4Qp5C3noBv8HqqNGpXx5KDWnufyXa85shaOD1bfyz23hh3mB0tZ2ZlH8+ONupbI8aK7IIi1m7AAq18qbkWW0gU48b5aUskkXkoefQ2I6wcjAB/DGUDeixgCuDL1BA==
X-MS-Exchange-CrossTenant-Network-Message-Id: dbeb5680-0ff7-4e31-ebf5-08d84394717d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 16:33:31.6131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wDuyUYkXLWiDr/q/z1X3d50wdwpKgp0LNdJbi6ahu96pSVCw7fYyihuF8Ysbsuuq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2939
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1597768354; bh=fPUrImA0zgXG0Qp8LWe0Z0/mmmTGNiasTBYIRKR/Vk4=;
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
        b=Lsk3QIIS9yQhBoCn4ykDIQ9okP0AKfRBvNNBDg0Ze7ASENYjEjCbQx2rGJ22JMgHp
         r43789Zsz30EbVmAFmmq6/sTA4Lmm3WS6W+iUJa/UUH2Kh8+7tUw/7tMJPBOWX9TN4
         4PQDxqB96TS+zETwEwtqpQ64yckwEZNAQY3R79ULBIy2ll66q5HaDm/ZObedfR9oiU
         h50sy9KN5u6uHKZIy6JvtY/ICJ5k+gfdxICjowPZm5dxaxntOiE+u0eX9SGGZr1YZM
         KvAAmwMoQzPYdJ2jA9vI42TjJ5Vn1/Ru/QJ7UXGjUyFQa+Q50rdQ/5FxXn//YX1+Y2
         PNQD9/OiV6QUg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 05, 2020 at 03:14:59PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a usnic_err error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/infiniband/hw/usnic/usnic_ib_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
