Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D1F4157E1
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Sep 2021 07:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhIWFgb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Sep 2021 01:36:31 -0400
Received: from mail-sn1anam02on2057.outbound.protection.outlook.com ([40.107.96.57]:9875
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229645AbhIWFg3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Sep 2021 01:36:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=By4QU4nUO5DVMLdDR48Tx70Xr1Ms7pacVSg6GSV4m/N+ZZ7YvIYHUqXA+564Z1QergLcgcHGm3JJcz+sUZOv7m8NYM33PTxWtpbnHUc6idNCxw43eqG6vD7X7wl8GQItvS1YH8j5Z1brkBe8k+dOVdKNK6jFPaojIlvre0hrQHtMtQH6UdgEhf3BzaPJ0dPjzEBNGMkRng2nZMZ8XpyvtZA9VmMB9JRoBWAMf9g4R4XiWrt6LrG5dnlTzPDSTuqVwiuMI+s7/CbXPwy82+jnGpgnBNdH2gM9VzYoYqD6I4kjYD4hiPLchvmHOgxLf2vSXJ3ifgxnJvWSkCTSjAQlWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=8ZLMkyoasqNaRk3ZJuuzBIPUctuPXS37wKMBa7/+ePI=;
 b=a2GoTFV6hoCqDzYxxbJen5uX3f2I0Ot3Gk2GZukIUvnzgfeYqnte3ryrAF883qpOryZYXiYuz+4dgeGiK9P9KMEx+shc69DzYc1BZB0dVvDq7A251kwN0w1AhSzEW0osRxrnZdt7tWjZ9A4aKXhBd0I0hhhQzwIM9lc9AdGscJ+iGQKv2s/xHorMfUy0xJmvz3ZnlPa/BWYYd8t9oXM6ClCFiDjhVNjOlLLcElUwozhblAKqYBRBJSUsa8J8SHbIJvEQHoLYFjEOV4NcyQ6I0uwnKdm7SZlHAQf6n6jd5DFQ2R+3LjcYuID9PR9gM5E/E3RSWiX7toJSmBEY8WapbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZLMkyoasqNaRk3ZJuuzBIPUctuPXS37wKMBa7/+ePI=;
 b=XTDRqmhu2iP687pANXeTnHYfRWNPz6930A2QmTukKqJgHbSXk9sFLOvvEtdh9QM+ShBncUaK7tMKM9tkRIUADbtLxyzo1OGYCvOUFJFTMvvpfejq6PBKECIX+mJcdWgD7tfUORKIBUVQ3ipWFG05usp9dnhb1elO8ExbAjAU3T7N/S6AvJruB5gwpZ2rBbaPtf1KxfNkSoQy4T3E3g0WgjostcJmpM5e/5xd9ucn0Mm29qwqXdjq7F2fVVJxKdsjmGxVSGIMDbUZzc8N/K1nO7CBy5nxFLzeMpmtKuQaUqbOCCfVURn4K+oub8oZpzwuVkQKOUHt9YzJY0jgQLGMsw==
Received: from MWHPR20CA0012.namprd20.prod.outlook.com (2603:10b6:300:13d::22)
 by CY4PR1201MB0181.namprd12.prod.outlook.com (2603:10b6:910:1f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 05:34:57 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:13d:cafe::45) by MWHPR20CA0012.outlook.office365.com
 (2603:10b6:300:13d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Thu, 23 Sep 2021 05:34:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 05:34:56 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep
 2021 05:34:56 +0000
Received: from localhost (172.20.187.6) by DRHQMAIL107.nvidia.com (10.27.9.16)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep 2021 05:34:55
 +0000
Date:   Thu, 23 Sep 2021 08:34:51 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Christian Benvenuti <benve@cisco.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        <linux-rdma@vger.kernel.org>, Nelson Escobar <neescoba@cisco.com>
Subject: Re: [PATCH rdma-rc] RDMA/usnic: Lock VF with mutex instead of
 spinlock
Message-ID: <YUwR+zEzr4gqtlHG@unreal>
References: <2a0e295786c127e518ebee8bb7cafcb819a625f6.1631520231.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2a0e295786c127e518ebee8bb7cafcb819a625f6.1631520231.git.leonro@nvidia.com>
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e74789f-4123-4d25-a146-08d97e53e0df
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0181:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB01819699F5BB758A7725642CBDA39@CY4PR1201MB0181.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g5JUx0OvD9In5F4aYi416tb/+G7Pmu8x479DLZzXSa/dtJL2GEsuspMF9EUehmKAMxF4pDnxKVV0ofTbFLTn0GwcvkYg86+xuOA/PY1SYPqAt3iKDrXqSxiIsO6gQhULeWiGVF4lLgySxyJyPXRpTLGg/mz3DReeYQa+/0lEKJi5FDpixyj2T7p4FoZGrFUMIbOx4x3m2JqBNSN7xFwqPcNwqsZL7BJNaQ2HdO3R0AYtX9N7Xq2RX9aUPxOIcNcVcUfiGLryskzLDtbgSXvgEyJarGDba75TkwGumFQuYgzhDpbs9zjy6XfE1CAyceg5zrR7nMaRwuNLHokZclZF4cZrOgUQYzb9ZORA5DZHGgA8bBmfpqV0xI4gmfioIUJGtbNdYzcF3XYO3pWJzoEODldNSn/92VtG5ed+8vI1T0+/38SYv7bSHcDOIPEFrFWdM54dCTBngq7+CXwXr5qD8H04yWcfCY3vjFd040cNu+COuw9Ztc/kSPJiImqCadgXzB4otYuuSxCJ6OeZY8b6ruFnCmWf8fs1mZxqoS5qhYvS2poGOSbslpoULQbZvZx2Z+k49a1F25e7onYyxW8ttIY3D4Gepup4+l/xb03o+SUWuPPngUkVq9rpf+mHd+4yPG2SBbgo/uuK5foh5w8xBaCQWliInQBuXkPK1BSIlITVfgVYywNhWA1BRdLqRtp7Px0Atqbf6WM/CenX/fa6f+hXD7auy6nyUv/XjpPqRvs=
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(7916004)(46966006)(36840700001)(8676002)(2906002)(110136005)(6636002)(16526019)(70586007)(4326008)(426003)(4744005)(86362001)(316002)(36860700001)(70206006)(54906003)(83380400001)(6666004)(82310400003)(47076005)(186003)(26005)(508600001)(356005)(9686003)(36906005)(8936002)(33716001)(5660300002)(336012)(7636003)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 05:34:56.8644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e74789f-4123-4d25-a146-08d97e53e0df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0181
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 13, 2021 at 11:04:42AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Usnic VF doesn't need lock in atomic context to create QPs, so it is safe
> to use mutex instead of spinlock. Such change fixes the following smatch
> error.
> 
> Smatch static checker warning:
> 
>    lib/kobject.c:289 kobject_set_name_vargs()
>     warn: sleeping in atomic context
> 
> Fixes: 514aee660df4 ("RDMA: Globally allocate and release QP memory")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/usnic/usnic_ib.h       |  2 +-
>  drivers/infiniband/hw/usnic/usnic_ib_main.c  |  2 +-
>  drivers/infiniband/hw/usnic/usnic_ib_verbs.c | 16 ++++++++--------
>  3 files changed, 10 insertions(+), 10 deletions(-)

Jason?

Thanks
