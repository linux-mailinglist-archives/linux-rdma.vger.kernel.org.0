Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552693B23CE
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jun 2021 01:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhFWXJQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Jun 2021 19:09:16 -0400
Received: from mail-bn1nam07on2041.outbound.protection.outlook.com ([40.107.212.41]:61190
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229850AbhFWXJN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 23 Jun 2021 19:09:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6//le3ZGwaXxUhsr5jbIhb7PydO4NPWH7ziooHvZwQabpYaE3C5DsYcbrQY6guEjdFnGdR47rfSXufeGXmVWcQmOcPwYA6ci5W6luxKV2HXZHtDLLIwqcLEwwjNZ3mSysJSOTO/rsGd3HuF0QWaxEMYPj0oQ2BcqMwm5zLONV7JGAZ3xe63NNeXs6zalvfRntmrC0FYlS4fs1kaMqhvzEqmPSYd7i3bb/LOuaNwtHruhnLaDlmV/Ffe6yxeNFI227Ik3C1TYEGXyf7FtGcHgeorAiZgvGi84B66njdBdp6ka8aUXcAseV3GuRRbqUMA1rNBhSTqSPPBoWAHd9mbeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Gq7HGin61xdSlvVX5O/H3jAp1QLfLG2OvF9kIJj8PE=;
 b=h+D3T/X2JT7/4sS2Na5rnMjIxTqtfAOjN9CyoNOQDRy0ZUPBPUbVQ+OSjM/dor7L4cz5bShHBOv8ixmtKRkq4rCQPg1san0lgYsgOcWUo/hhzXZJvmueBmK47JmWqcifdq1GzWP9BXR+XVamzXwvhSefZ/xgQ1G1qltrtPEbH1kH/vp22dgRvkcI7POE1hAx/hmFgTcua6BVZ6ih5Jni/A+jE7bBQpWd5tlu6O0/mQp22yRiZ+FLCYTt52LQ0nEwYm9hyqRPWa4x7VK1WgnMOw70sdPvBD23LgAxfieN62X2XV5zzQVyW4tYeoJ6ePPvL/4ajBEOvhKeGoY8rwFN8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Gq7HGin61xdSlvVX5O/H3jAp1QLfLG2OvF9kIJj8PE=;
 b=WFA3PdNat7ug/38fXTYH+UtPPLQYukAsthYRrBt8XvRlThqkQpsgIZI8QwaUWDm9gwYDRiUiFxMUtVd3Oa99bdnl/gMYMgyMTI2Rhd4DQDg0Wf6GrwaYuOzWL+1/KDjyvZoAuhhXVjRnyfMic7LVtTvKyFuVf3+z0VjLNFDcJxDk+zOiQfxvPyH/+XgeJvjrvQCnOEe7HpVVhBD/e5Gaape+2XZwtKL9dhGAfVMoOyzPN6cAXfkvMIJL95jNsJunUsiRIH0wKPBzW8Lm0wjjlGsAQ44TKrysIvaM0xjLIvE6yxdaom0UJ5qp8nc/+A+cX8/aDlwJZv34meZkpEjNFw==
Received: from DM5PR18CA0050.namprd18.prod.outlook.com (2603:10b6:3:22::12) by
 MN2PR12MB3023.namprd12.prod.outlook.com (2603:10b6:208:c8::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18; Wed, 23 Jun 2021 23:06:53 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:22:cafe::e6) by DM5PR18CA0050.outlook.office365.com
 (2603:10b6:3:22::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19 via Frontend
 Transport; Wed, 23 Jun 2021 23:06:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4264.18 via Frontend Transport; Wed, 23 Jun 2021 23:06:53 +0000
Received: from [172.27.1.217] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 23 Jun
 2021 23:06:49 +0000
Subject: Re: [PATCH v2 rdma-next] RDMA/mlx5: Enable Relaxed Ordering by
 default for kernel ULPs
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Avihai Horon <avihaih@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Tom Talpey <tom@talpey.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Keith Busch <kbusch@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Honggang LI <honli@redhat.com>
References: <b7e820aab7402b8efa63605f4ea465831b3b1e5e.1623236426.git.leonro@nvidia.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <9c5b7ae5-8578-3008-5e78-02e77e121cda@nvidia.com>
Date:   Thu, 24 Jun 2021 02:06:46 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b7e820aab7402b8efa63605f4ea465831b3b1e5e.1623236426.git.leonro@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c824555d-f549-436f-c16f-08d9369b973c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3023:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3023895C1A6079BA47C80BDBDE089@MN2PR12MB3023.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ffKCoWA0RuUkwST0cWRRYL8VB5mX5dyVUDXcIobrxKnbN91UGE3c+75X1kGNJ6C7HXMN3/SLOeRqCtHtslnBPwg5y4mddjS4H6QSWDv3B4grLmt5Looax7UdY/mSOHqLf9H5V2AuMdHSYji2jLb7Y7fdZue/CeStqvvbPI/Mzxh03W1txpgEeLVE1RVWQYZOWNk1g2FSHtxVAhKq3D9Muk+yQ+5QjIJ4I1Unb6PnzPtKYHl98JOWjy+IHpUzbPLOBs9XS5YP0y9LGjQl3BwxQ0u2Af9FRSNCWdKkSTy2XnjOCctO3aWbsbV7hY4yOS5QIKXli35j+Mf2xnzDK9T353bQBijChioAmeqgbrIkS9I7GDda+JltnsFOSPgnQOYawVyqwiBidDps6A0wi7ddFTN5HfYlOn61zBApzzwnT0o7aerFebwJt7C5jaNtKvG+5mzdupzH55Q+DSO/rLwlFv/5t/aNDCkKv8oSlTKLg1ZYFs0lBembaG+IL+ATrbaBtHgUGmGihP6EcejlOejCV84YXgBeOkmbzc+YDzm9KInc6HKuYQw7th7hT+5hzvKNQVcT+Jv5+NgeZDw5Pe+oXbPqBH1Do5z02JdFkd2P9kh7s2ZOjJJAs0W9wmXkTRjFSRQwW72v0jziqYOmZUXXB6JH8LsMgs93T0Y7DqGLZDsg/2qJqAeTGrCT9qnGgSyOw4n4BPfTbJ1vefGk06icQ/mwtYIa9ffcpi8baFVB0ajA6BCAlQFBJy75XHDJKvsvcIrDrLv+mmZJ19k2/b7u4klj34SXUJ1jL/r9AWvKT32M4G12BZort1JCRCfaX939B8ZLVFJSu7oafCUK+WTqUK7Wa7iWhaqmprP84EXZ90c=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(46966006)(36840700001)(426003)(336012)(8936002)(82310400003)(36756003)(2616005)(36860700001)(8676002)(7416002)(5660300002)(31696002)(4326008)(6666004)(26005)(6636002)(2906002)(70206006)(86362001)(70586007)(54906003)(316002)(36906005)(16576012)(47076005)(31686004)(186003)(110136005)(966005)(16526019)(82740400003)(83380400001)(7636003)(53546011)(478600001)(356005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 23:06:53.3768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c824555d-f549-436f-c16f-08d9369b973c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3023
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/9/2021 2:05 PM, Leon Romanovsky wrote:
> From: Avihai Horon <avihaih@nvidia.com>
>
> Relaxed Ordering is a capability that can only benefit users that support
> it. All kernel ULPs should support Relaxed Ordering, as they are designed
> to read data only after observing the CQE and use the DMA API correctly.
>
> Hence, implicitly enable Relaxed Ordering by default for kernel ULPs.
>
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> Changelog:
> v2:
>   * Dropped IB/core patch and set RO implicitly in mlx5 exactly like in
>     eth side of mlx5 driver.
> v1: https://lore.kernel.org/lkml/cover.1621505111.git.leonro@nvidia.com
>   * Enabled by default RO in IB/core instead of changing all users
> v0: https://lore.kernel.org/lkml/20210405052404.213889-1-leon@kernel.org
> ---
>   drivers/infiniband/hw/mlx5/mr.c | 10 ++++++----
>   drivers/infiniband/hw/mlx5/wr.c |  5 ++++-
>   2 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
> index 3363cde85b14..2182e76ae734 100644
> --- a/drivers/infiniband/hw/mlx5/mr.c
> +++ b/drivers/infiniband/hw/mlx5/mr.c
> @@ -69,6 +69,7 @@ static void set_mkc_access_pd_addr_fields(void *mkc, int acc, u64 start_addr,
>   					  struct ib_pd *pd)
>   {
>   	struct mlx5_ib_dev *dev = to_mdev(pd->device);
> +	bool ro_pci_enabled = pcie_relaxed_ordering_enabled(dev->mdev->pdev);
>   
>   	MLX5_SET(mkc, mkc, a, !!(acc & IB_ACCESS_REMOTE_ATOMIC));
>   	MLX5_SET(mkc, mkc, rw, !!(acc & IB_ACCESS_REMOTE_WRITE));
> @@ -78,10 +79,10 @@ static void set_mkc_access_pd_addr_fields(void *mkc, int acc, u64 start_addr,
>   
>   	if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write))
>   		MLX5_SET(mkc, mkc, relaxed_ordering_write,
> -			 !!(acc & IB_ACCESS_RELAXED_ORDERING));
> +			 acc & IB_ACCESS_RELAXED_ORDERING && ro_pci_enabled);
>   	if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read))
>   		MLX5_SET(mkc, mkc, relaxed_ordering_read,
> -			 !!(acc & IB_ACCESS_RELAXED_ORDERING));
> +			 acc & IB_ACCESS_RELAXED_ORDERING && ro_pci_enabled);

Jason,

If it's still possible to add small change, it will be nice to avoid 
calculating "acc & IB_ACCESS_RELAXED_ORDERING && ro_pci_enabled" twice.


