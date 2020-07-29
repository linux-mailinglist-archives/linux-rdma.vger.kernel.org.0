Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060E823234B
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jul 2020 19:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgG2RU6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Jul 2020 13:20:58 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:11093 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2RU5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Jul 2020 13:20:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f21afcc0000>; Wed, 29 Jul 2020 10:20:12 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 29 Jul 2020 10:20:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 29 Jul 2020 10:20:57 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 29 Jul
 2020 17:20:57 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 29 Jul 2020 17:20:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OegV2XwiuHP5m7gsyTiRHbiB6vrTfP7vNG7Vv6WNDI5prsBR0oIfj8LFBUTin0ROqlQ37wHA6HR5HcUGLJUU3yXwFQ76Rd/wlUjTf+s2AxSKDt3ZUbKX61Ru5HTmdaFvZHdKA1VZ2s+elLLy0VTQKvTfpFvz+PFqtQxHmiQkqWR8MPHsOmON/X/jo5R+Pow+I+IWI34W6Pg4ZQdAVJI3hdKZzys5/j511Vs0876MWKzstGsOYk1lwM4T89+x874UrRTipF9BjJ4xm9vXE49RyE+f02RehDW61TY65Tv/QOi0qUU99KWCHR5lgRlYO7IWofhko9RIvdVQvqRu4d+H3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWLJpJ2pwNDkuNIT9+cYHNyIs0Ut6ee3B1es9Te7Z7A=;
 b=UXldvLIHNbxG1nCUUJnvougn/L+rlpX0zYpK+mNOa65eBACn2pB6u9/9Vv35r3fKWEFGrYQRmeLFj0LKqWUutpjV+0rYnn9vqHR1N4EUOtdBMlOaCWyowDIZR/KDcjoxP+SAfwT/IAvbQlnXUHTwAask3tmglT4wUfjbxQlz4y3OkyBmyjkQT7LHsfAUFflyx38EbdRSI+VYct6LkPMTpgH3YeoRzeJXWcyvnGfLETajwMI2oNca71LXxjOCg1r47OkrL9PRa73IrkOH8ynnbqB7RGKkVu99s9N9RFRxQmwg8lowrPhEtO0Zwtid4tVPuUquBFjPO9ej76joXv38PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0105.namprd12.prod.outlook.com (2603:10b6:4:54::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Wed, 29 Jul
 2020 17:20:56 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3216.034; Wed, 29 Jul 2020
 17:20:56 +0000
Date:   Wed, 29 Jul 2020 14:20:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        <linux-rdma@vger.kernel.org>, Maor Gottlieb <maorg@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Allow providing extra scatter CQE QP
 flag
Message-ID: <20200729172054.GA254520@nvidia.com>
References: <20200728120255.805733-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200728120255.805733-1-leon@kernel.org>
X-ClientProxiedBy: BL0PR0102CA0033.prod.exchangelabs.com
 (2603:10b6:207:18::46) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR0102CA0033.prod.exchangelabs.com (2603:10b6:207:18::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend Transport; Wed, 29 Jul 2020 17:20:55 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k0pl8-0014Dm-Js; Wed, 29 Jul 2020 14:20:54 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a802e36b-c0aa-446d-133e-08d833e3c0cf
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0105:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0105942D62561F0E8928AC95C2700@DM5PR1201MB0105.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ljJ6wHi1kB4V612xrRPLOsib5fptd1cjuIiSCapP+7C7QtTduXETwae8n65JqNbuT5HeevsL72YL8i3Ezb2OlLjlcs9WNZOA6NdYE1ql1RebzbypcmoS1jzBEN2je37lDXXug4yq1QsRO6TPB8PBm7jEX96mfpqBLXNDw2kixkgNsnyyccPsm6MJzoqvcSJW00EZSP5WUaH5nsFqppIU7egiGf0ozJLS3Go9KxLuVT0jh9lT0hFKnU7PFWZKbsJ7EX+hs8wBgaVywnlj0Yrhf0TTVbFddWDqEQZtoAvlXU77hFIowaG/xs/MW/agOzlYHHPmBleuOP0SKzQ4Z2zxY+QuTtoSVsgRTwbSy0uCoTnmfhJuobR24F7gJivWl3Gg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(426003)(186003)(4326008)(66946007)(83380400001)(66476007)(66556008)(2616005)(8676002)(2906002)(33656002)(54906003)(4744005)(316002)(5660300002)(107886003)(1076003)(86362001)(478600001)(9786002)(9746002)(6916009)(36756003)(26005)(8936002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: z99PI+XxDtTCYVXDj4bslVwymux9As2HMJRNbL7ZnD/mMHWVwoufo3aW2QTUC2ajvenN5lLu7hzBCSV2gSajE7cKTAgVE9TfcS42l7p9S8n+ffkwTL3LINniybCztykg/hwbKNm4kSXKlbOzMK+7Pfpca4yR+1DmIoPe9BWRpgzei2QZJX9ZFRHBvuwWMzUXDTGhb9rn7Y4Nj1cYLF6swVH/SAnFjwoqgh72xYHW4txwi4x3eekZWQb00eI3jtm0/IMZtvqRUumTIVTHJ8B4AJ4fwfoYb4sUd9ktYyZ5OZxTfyacn3eavq96QusTWdc65eg2DMSjUmPCoE/TAWrnmjX1ATYg2aMQMv9bmFulyYjP9TAC6i/j0I/EVqdzGtssMs5IoweqAt0gkczqZZXUc+9F3TqtR6ywFtBRfhzw9gOJ23uZZlJ0U8TtYZ7BHegTnPzxpdYe787dTrGlGsORwWfJlG4+Z5B/O2Q/t8SaYfRq+9WPLoImhYKIzxSSBB/6VPe/3hM3RZuYWOWznQJDLDQ2L9vp7qIvfGJlfBhXgvralhPa7EXtEoTeTWruRuW7p6jyfNHJq2cfiQzHAU2Px7rODNUmzOjdK4NiDXR7v3LaZMltX8Yr3EArsGtiNw/au3ZsMNHzHViUCEaYOAGeQw==
X-MS-Exchange-CrossTenant-Network-Message-Id: a802e36b-c0aa-446d-133e-08d833e3c0cf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 17:20:56.1682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6uqd2Pelaysyh1zwvCZ+X0e5UnWy6KlHM6o981mGGk3fX3DWsCGSbXgLEwzPz+Hc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0105
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596043212; bh=HWLJpJ2pwNDkuNIT9+cYHNyIs0Ut6ee3B1es9Te7Z7A=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Exchange-Transport-Forked:X-MS-Oob-TLC-OOBClassifiers:
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
        b=ef4W0P8CytebwjCgs5ctzqw7ZmlN2Og1S1FLNPuV/CpLG2+anyr6Rtfn3WhDyLxUW
         SitJ676XU3p6FftWm/J6WZjZ/K46X3SST3odREu1Kdqo6g8RnUUGl3nCuj8/QWkeSY
         EI/0c0HLepLiABEaykeqT+0BIN31FZT4zyvZlt4DfQ6al16yC+mx7RiwG0QkqigN9Y
         W+rkp8E+UeG+7k/MFIIFVLX+N4Hxcp0VU6XBQ0d9GvU2Fki96xXdIQ0Y81Cb674Brk
         UO4zyH2BkmNCuCje8O/5zVHcbo4SkqjR/qDijZB+icrB0ln65VOuCppp5KRuBebn3Y
         drr4w5xo1pI4A==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 28, 2020 at 03:02:55PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Scatter CQE feature relies on two flags MLX5_QP_FLAG_SCATTER_CQE and
> MLX5_QP_FLAG_ALLOW_SCATTER_CQE, both of them can be provided without
> relation to device capability.
> 
> Relax global validity check to allow MLX5_QP_FLAG_ALLOW_SCATTER_CQE QP
> flag.
> 
> Fixes: 90ecb37a751b ("RDMA/mlx5: Change scatter CQE flag to be set like other vendor flags")
> Fixes: 37518fa49f76 ("RDMA/mlx5: Process all vendor flags in one place")
> Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/qp.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)

Applied to for-next, thanks

Jason
