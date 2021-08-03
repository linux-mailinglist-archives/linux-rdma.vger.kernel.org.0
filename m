Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971353DF45A
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Aug 2021 20:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237241AbhHCSLP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Aug 2021 14:11:15 -0400
Received: from mail-mw2nam12on2044.outbound.protection.outlook.com ([40.107.244.44]:56673
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237196AbhHCSLO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Aug 2021 14:11:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMyNewGBw181D+tYwWaqAxyt+DyIReY/maY28KD73IuOEoOoys5/yaLRsrt/Gun6fJ6Ml8XOmMNWnmvMj4wmdHZVCY4/ttDzHrHlRJzzMKjpJ6XxmUbhzKkbYEE0kP6OhOWsAlD0y5gEcjbFkwapwf+PDiU1hmEZzXuEwkHjYu/u7PzESfDN/JyJjvGdfYs3CuLFICyvngDMW934/5aB6jSlcXdSHHBOZnJ2Q49wKg5Cho1JgZldwDci25c9tBAwl0Z2I+U5Bh9/v4vlugZ//Zj6098AmYj85ZSKUO4j+vmVdUQ+MCb1jSjPuU4TSxrfxyZ8pg12YzyZOBgxx/G9vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gPwMZ9qnosT2EZ6A8syvG6vo8NYQtW0eBjJZE2Jxn8=;
 b=nOlWNdSC0hYxbyuKUWzn9lYk96NQd8L1YXBxrwckEG4XNCoSVNgEH54sfLBw+tC6Ifz82I6/VJUlTnA1bickqCAe+fWFW81iUq7F9u3RJ+yjP8kxYqMg51R4D22NdiG6Z5K7tdREXVBbiL6f4sY1tXzkvOEdokVXHFyj3SCJB6rW36D8i2ctVB0VbCW9oIk1KmRxCOzg7fmjlmdq4l/iI8UYlufHM69FgyLwdX7A5ztupy3keZgmMqC3kHiqUqw2/6AUQhVxiLMEQVCdg5Sy4UKlt3ANC5o6MdRBbfbnEtqhTrxzf4tBpFyFQxokJ0IWWGRP8ng5APcAAkCsJiP/EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gPwMZ9qnosT2EZ6A8syvG6vo8NYQtW0eBjJZE2Jxn8=;
 b=APPPApdNZcL3M/ui/lQKRb7DPqiY48ahZ7isZPZc25+khaW5JgX0dhesr26upz1iBuuCnTbtbpx2S0XXgYqtOWlroX0JmkzzBzVii0jk25UJqY1/vL/Og+hsAtIDYZFLkEOqaYAnaDLt5I8rFYzpJOTnAHC18q5J+yoWYNHjQ4ESZ73wvUp1LFm16/hNWOaEGsjIx9PrQmDCtUVRjy/etI7AORvjjPQJeU/REoirtmblUzerDSIekzNFrmVR0/icIiIo/nSLBNus+I4IzVmxnDe786kPFu2VExOKvXfWcsNSuZ2TVDDwuI84Bcex2cG0nreo0mLDfMoWx134+v7qlA==
Received: from BN9PR03CA0025.namprd03.prod.outlook.com (2603:10b6:408:fa::30)
 by BN9PR12MB5147.namprd12.prod.outlook.com (2603:10b6:408:118::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 3 Aug
 2021 18:11:01 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fa:cafe::ef) by BN9PR03CA0025.outlook.office365.com
 (2603:10b6:408:fa::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21 via Frontend
 Transport; Tue, 3 Aug 2021 18:11:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4373.18 via Frontend Transport; Tue, 3 Aug 2021 18:11:01 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 3 Aug
 2021 18:11:00 +0000
Received: from localhost (172.20.187.6) by DRHQMAIL107.nvidia.com (10.27.9.16)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 3 Aug 2021 18:11:00
 +0000
Date:   Tue, 3 Aug 2021 21:10:56 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Mark Zhang <markz@mellanox.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH rdma-next v1 0/7] Separate user/kernel QP creation logic
Message-ID: <YQmGsMPyLQ2decBD@unreal>
References: <cover.1626857976.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1626857976.git.leonro@nvidia.com>
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72dd0bab-c664-4177-f924-08d956aa0d3a
X-MS-TrafficTypeDiagnostic: BN9PR12MB5147:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5147B8CD80D26D48B821076EBDF09@BN9PR12MB5147.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xNeO/SJSjPTlH+jPeyGKcmRE+Fc/U7QZBxebs5NZCfpo9zGcX69Y+SaFOA1Vw+Z0z7J215emgATZ1SB+MvzISk8R949ZGNn73+n1wgxWY+rr7YobjKxRNWRmSeGGNlTmYFIMcoVHamBGMkwymWZOaLPKIJg55kGobmh+8ak7TNj6ZSQrO44N5LyCu6NiMKB/E8J663wXzaoAyBOvu2WKidPb1YTK0FaqkImd5wu2h2BWuNNEa0k1U1mxvmJJzZR2+gsdVIYq4GrKtKsmGiuOW+4+wMYo1Ub62TamDOfbfik6YJMolLwGJ+zJaZ4cVMbsQaA6h/DstqWfT46/G5lU9BbvREa4pvY3989h6Ai2qSnQjtg4VwjbQE5bcPcrj8w+iKz2VlhcaY8q+L7ySyZB3EF4GMmkAAUivlZ7lmSUKM5j3WVF4X6mL7Xo9L3CitnkIo21bRQ06coNJY2hFGvBfviees3lWZXXADxWL27iQLNYnBpwSDCC2hWUMevgNevA2o+CzIi5NNcrFqgEFsiSJnD2CRB9UyqH0+21nTyoOuirQOFlknpbxtdPNDQs+n5KGMra5gq93zYT6Q3QukpYfP5PH/R55eHtjq/Dd2leTXxGPljGwWad+64T+gs8WjhOPfk3rwGVq+jLKSnrf8xK+gbbawz9xKqYWqXhK7FUOiDQ8715vS5mWXovYyGIkKKrNAnl4YzSlr8BYCikhzxboXts5CilnJRnsF7d+LrvLVnye60ttwlJpgC3vMhGLiMG8wmJpiOtFdgfPOBV7s0tszvMWjBRAeZ2jM9pGQE++so=
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(7916004)(39860400002)(346002)(376002)(136003)(396003)(46966006)(36840700001)(6636002)(9686003)(36860700001)(2906002)(33716001)(478600001)(966005)(47076005)(426003)(110136005)(54906003)(6666004)(5660300002)(4326008)(82310400003)(356005)(36906005)(70206006)(7636003)(86362001)(82740400003)(316002)(16526019)(186003)(8676002)(8936002)(336012)(83380400001)(70586007)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 18:11:01.4334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72dd0bab-c664-4177-f924-08d956aa0d3a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5147
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 21, 2021 at 12:07:03PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Changelog:
> iv1:
>  * Fixed typo: incline -> inline/
>  * Dropped ib_create_qp_uverbs() wrapper in favour of direct call.
>  * Moved kernel-doc to the actual ib_create_qp() function that users will use.
> v0: https://lore.kernel.org/lkml/cover.1626846795.git.leonro@nvidia.com
> 
> ---------------------------------------------------------------------------
> Hi,
> 
> The "QP allocation" series shows clearly how convoluted the create QP
> flow and especially XRC_TGT flow, where it calls to kernel verb just
> to pass some parameters as NULL to the user create QP verb.
> 
> This series is a small step to make clean XRC_TGT flow by providing
> more clean user/kernel create QP verb separation.
> 
> It is based on the "QP allocation" series.
> 
> Thanks
> 
> Leon Romanovsky (7):
>   RDMA/mlx5: Delete not-available udata check
>   RDMA/core: Delete duplicated and unreachable code
>   RDMA/core: Remove protection from wrong in-kernel API usage
>   RDMA/core: Reorganize create QP low-level functions
>   RDMA/core: Configure selinux QP during creation
>   RDMA/core: Properly increment and decrement QP usecnts
>   RDMA/core: Create clean QP creations interface for uverbs
> 
>  drivers/infiniband/core/core_priv.h           |  59 +----
>  drivers/infiniband/core/uverbs_cmd.c          |  31 +--
>  drivers/infiniband/core/uverbs_std_types_qp.c |  29 +--
>  drivers/infiniband/core/verbs.c               | 208 +++++++++++-------
>  drivers/infiniband/hw/mlx5/qp.c               |   3 -
>  include/rdma/ib_verbs.h                       |  16 +-
>  6 files changed, 157 insertions(+), 189 deletions(-)

Jason,

Can we progress with this series too?

Thanks

> 
> -- 
> 2.31.1
> 
