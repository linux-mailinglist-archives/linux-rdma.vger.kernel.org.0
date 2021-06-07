Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E8D39EA53
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 01:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhFGXru (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 19:47:50 -0400
Received: from mail-bn7nam10on2048.outbound.protection.outlook.com ([40.107.92.48]:45056
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230254AbhFGXru (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Jun 2021 19:47:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FS62fizAvnkyrsF6SJuvLR4wK0n8WYn9SMq9B8CbPf187CtqMATdG+gqFbyFKbWYgc75s/aX2loRvrDyE+THeBGrBoAYJMpkhc8d1rzBwNKRo82bmhpXn28LQ1craEP0GMYMufKFgUXXf/D0yDoogWsSZf6/ARsPxJ82hTo+M2UemujlAKvUS/lXs0KyOHy4RiUc4rDGSBpRRK6nPJNB0htfd1Kr+bgU/MOe4u8HjKfi+n0JN7/rqzN0webNIG10JaSL4mhkBbNobHTbG7r7JwVRiXkTKi0bpn2plnOyZEyV7yA+0jvty4hsa4a5ul//1oDTR6D850Tuv6N7o8sPkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTpvMKvQ+ZDdZQdNtk9NY3pZh8h3DAiKUMpXfNKaYrI=;
 b=d0k5EHjmkxRFK1KGS8meF6nU6GlANYye2JXGnaopzFndEwycxyCcK1ZUtuoMEj1/9K9JoXRWjr/4v61ioGXTqRBk9KSxPSVpi/LB5pPKTPwjjFNy5VatreLQFvU7/yF8jxq8efpcpGczVga9eODmxRN/HpVZbvUIv2q/nkgoGj8iOXKl/C3PwyS48Odkm+/8VQvxgUvNO687sRcFc4Ys1GubcOPowGCGQhNn2rJncULOo5REeh/KqusYTVjkS4SDxf7cmAyGkOQxUVdTAJBzyw64pOxT+3OV28t/8sfJyhDSYwWVKiJnzHE9Knf6gBLqQEwATc+ZC48R7JoT6l3rmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTpvMKvQ+ZDdZQdNtk9NY3pZh8h3DAiKUMpXfNKaYrI=;
 b=j+8srdjf1WSTlL5aM33aYDOHJ7Q0ePUMhbIFivt3hDTK8bH/u3lqhmT1HE3vQlwsPBnwPfTzkFZWe91pjRPGrOXwSR/9tcYvFg3Hhx0RMYFpiuxeWMPUhrDfAAGjskLFgisolrlIod/SEmTcjBZMGJmUDVjisKBQR+KACVXA65zUnF2fefdAd1l+Dj3EiIW8z9Q8WRtF6CNkFDNQCL5jJ6nqHQVefkxp7GBsVPhaGJLGvfLiSE9z2QDZDtTzoziHjIxJ4Zeldg6g/4nt2H/sOk8bzUJXrxyqXJibC4R7HrIzUSny5bZ8WnqyzErgGnaahb2b6exWGmd+nXA+cKQnbA==
Authentication-Results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Mon, 7 Jun
 2021 23:45:57 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 23:45:57 +0000
Date:   Mon, 7 Jun 2021 20:45:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/irdma: remove extraneous indentation on a statement
Message-ID: <20210607234556.GB840331@nvidia.com>
References: <20210605130400.25987-1-colin.king@canonical.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210605130400.25987-1-colin.king@canonical.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR02CA0068.namprd02.prod.outlook.com
 (2603:10b6:207:3d::45) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR02CA0068.namprd02.prod.outlook.com (2603:10b6:207:3d::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23 via Frontend Transport; Mon, 7 Jun 2021 23:45:56 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lqOwO-003Wcy-1A; Mon, 07 Jun 2021 20:45:56 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8dd7134-84b9-40b8-5944-08d92a0e6560
X-MS-TrafficTypeDiagnostic: BL1PR12MB5349:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5349E510D62A1626700B6723C2389@BL1PR12MB5349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DwwThds1f0H6PBgDFGKvzbbR6usL80hNtd5o1TV0MpTYumzsz/kKOeLJ4R0YL86NosIJoDWy9Sw6kFB3kApwZHx9+8PW3joFgyYlELmmj8rrhKRmRScewDrrx+p0BNJJVROtHmREB30XKtvWT3h8RGveY1ruh3tCGDdZbH2DY4ILPmQwxJ9tvweYGL1RwoP1lkq099cfIA79w0oQGnoDiuno8ZhfBROEL8O1EI5wTYedV+EX9X3W0rX6JdvQ2Fz7Wx1rtsDIqNdz8VzYwlJV/xgwWbyo3ehbi63l6M/I3v4sk8FW042OCHAkVlA5tvAO54GG5EvZpUbr9SI2O/vhb2jpqj6gYRoPIpJ2FC5xI9iC8OGNNlCJKEqjWw/3fN6IOX+iy62UhpPHRXIO2tHU6Fa/at9hreXVQIy3G21WwPJv7n3gXv8qJGKRnp+r8vdnEIsr7/opKFyuhw6YzG5Zp4ORYVNyl3zOJaS2d+LTeRCf9KjD9Ofb3U5CaNzKPfAc8Y/S/bJ7M+PXG+D9hY6GSLFf0X8SB90nalIdlQM4lN3oRmRyRstfKOPDysFDcsftysAQkD21pJV74EHYkp60zPh5qhBDezAR+zHvHghuvsuxb5tPqYdF2UivED4ea+sWVLjKilzh/29FdGJRJh5W+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(66946007)(426003)(54906003)(5660300002)(4326008)(38100700002)(186003)(83380400001)(9746002)(9786002)(6916009)(1076003)(4744005)(66476007)(8676002)(33656002)(2616005)(66556008)(36756003)(316002)(26005)(2906002)(8936002)(86362001)(478600001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FEZn7YaSP56aVOQGr8SF7yx/a55tCGJJjCdP788hvwPHwleduDbEw//PPCEp?=
 =?us-ascii?Q?hFrTSnrt8+cwIGxO9ucbEA0pkp2Y8IT7cbCWwMMNGLKamvfig/6aAaw/4sZ5?=
 =?us-ascii?Q?BD7yvSQMoOURPFrjIdec10KOWW8JCIL+F0Q0BQQJYh60n//YfujBBFvmilF/?=
 =?us-ascii?Q?iX1DZgwyoe4tlNXi2iUukaAaiKdZ+P83VD725d9d/UNodluJnGZ7sfOwDtI9?=
 =?us-ascii?Q?AtUXE9hz8Nxol2cIWtyPJ21G6a76NL0vSjprPjLr9+/o13WrMzJNbrIM7Juk?=
 =?us-ascii?Q?Jv3tjUmq9K1VVtwJPogXPkjW7kOdvR/CxaouqG+JYx2am0cPOgq84+o4FWx4?=
 =?us-ascii?Q?0PHpfcWFXhPuZpkWhqAiic7HO+gWiR6y7ZlEgAw9C9S0xNtA4UMNZHkIGyTY?=
 =?us-ascii?Q?Rxb/dPXPi6ycpocMffxlKRhwmGu8gRqpqfxTdLuFpkM14QcWIbv7XCCfKPqZ?=
 =?us-ascii?Q?fTP9e6wSPI+D5/Tsf5L4a+1JlBZ7Knk2tOujO9BHvyLw903EuxfFb2FJxOIR?=
 =?us-ascii?Q?Z+RzA2qBzRFqtrAmY/Vgwx9GNFcXRok5PL7ZXrcW+jyLgZQsqNFa8GZYqby/?=
 =?us-ascii?Q?+KRe9rhsVe1cJxStDhxvInNqDQydu4SdcsLe6Yr+uoZY4mK+SEyOLrML55nX?=
 =?us-ascii?Q?EG6mfvLga/S1RcaDADg0skNsuA+tg+wJkMei7ON0WejLJ9yw7TVcMhXFnIws?=
 =?us-ascii?Q?qaUFfrVK9URll89SByiT3z79aCCk7Bx3V6C53fV5wLwix+Gk/AnTzGMXr+Zm?=
 =?us-ascii?Q?P31Q05n8koFD9f7YG+ez1MGfhZEYwSKpxFwWKijalki2CKuBsjYowC/i5m6J?=
 =?us-ascii?Q?KmrihDUgBjfz7VUbM/dKk/eiMEqQ8qeKyY1MCxFcPv9lHsBprA+PAr7xPpzk?=
 =?us-ascii?Q?pbsUDztxeAC6RPmbgAufa7AEh2FrLK8KwlohGAi6D8UDVJAuhgBoLotPjbXv?=
 =?us-ascii?Q?YtjZ71MBPV8hcrgcwjbYKsDvt10be9A4DWPsqajJBEGMZ3NICif3h3dYR6CI?=
 =?us-ascii?Q?Yby12vGBje0ImqPoRo2bStnpSnqlO3tKtthN8U45ytbp7+Zgh1dgHyWgr0WB?=
 =?us-ascii?Q?UuAs6OAioXm7L8WHq1KZiY/OtlcubD9/nQBBfV6b0HeKLo2EFkoE9E0PAJvX?=
 =?us-ascii?Q?EJJUCAe1qYMOyxS+QJtzkI7WqegSbsR1Zb/WQ2YbVsMNQQlfSGAEjS6wzZEg?=
 =?us-ascii?Q?PEJIs0XSOfkfrX7Ibj84u2NIHJjUEDuxG5FyxSH/S2EiGUVAGGpL0xeUBR1q?=
 =?us-ascii?Q?oIV56jNM2ZlIqffnrpm0nvpdMf35aRAXImibc+75vrbszKsB2eR0NY1fh4kl?=
 =?us-ascii?Q?fT37wQ31BAx7uqZMBO3R7qk8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8dd7134-84b9-40b8-5944-08d92a0e6560
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 23:45:56.9542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: olpqwEhBOvzp3taw7gp4m/BDgSW/BMLQAATTgEt+p72EmUDGaENsZvfk8HlDpr+Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jun 05, 2021 at 02:04:00PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> A single statement is indented one level too deeply, clean up the
> code by removing the extraneous tab.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
