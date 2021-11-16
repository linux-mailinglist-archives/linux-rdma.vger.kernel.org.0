Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9594538D9
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Nov 2021 18:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239106AbhKPRzP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Nov 2021 12:55:15 -0500
Received: from mail-sn1anam02on2067.outbound.protection.outlook.com ([40.107.96.67]:64641
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239065AbhKPRzP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 16 Nov 2021 12:55:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLYtF/oq2Jh9iDn/zJxcSLf5Tt2TQZHNqhxSxzs51f6pwik4HHJgoUvYxqkbfeZGyBpswYzXl+5LwnlBeEHShrCSrkqVk36cawK36g4juYMW90EYxHbm/K5gYqYWpuT/cOFNZI7G8PWvUZMH8D5KRg3nKbKmIryA8WWDHAM+XefdQ3qUvgavManbIUB0gQ7kcyUsaD6tH8Ltu05LKQmjVUVn6pnla2J2yc/v4p1qCdHxwMzTidVD5y+GQ1TE4LR66Vxvu86q4kicX3R1rxpX4cQXppzPgr0J31Y0SDAl6hd34qbh+u6KSzAPm/U4EJLGYStcr8i/KiEz3kW7cIcETQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ggIYJ9MCrY2XrxexguLXEOyQsI4c8r44UbSbx+8C1U=;
 b=NjKyLjp88nLGSg71Ll5w1cek9mvhAc7WT3K3qgfyQn3ujwWLS6zUpzzYHUk+fhvRHNUxGsMG8gK6Mkr6DN92SRvyIXg9CYUjaGLF8n7fFTzDeevvJ3wGVTsEUznTozglKS+Q2k3AihuAW3ncMXeEOLA1IwmqDIILPbayLnlUaT1z8W6cgpY4LPL/f4bRdFvtXThApHV+3UnIMjT07bcSrzZWE5JP62yHY3Ad7I0aOdes/b+W125qrRykqtjA31vIjl8A89kTtb+uW+CygMSMM63iFWqszRYX422nxNyH2mUpgjrPg2uZal7TyHPjcroIZTT2t3Edlw/s8O2l4+fUtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ggIYJ9MCrY2XrxexguLXEOyQsI4c8r44UbSbx+8C1U=;
 b=Rx37WHDZdM2BFoN6JeEka0Pq6bGrt5vOcHXErzIgpJzsf7uykNZAAzdwnyzIG94gTV+CIjuTKOns8JSkoO8YI/BADtuLbZet2Ktjbe88fzEB/R0D5ZvyddPqEauMgM5RAtl7uFCoDKNK92ux6jSBwYRRJNdaGQ4oqAPi4V3a7ZXTKIOE0/ZIgw8ZAYBRayyK/6fMqyoPSitpr8UDrU+vswvXOMS9qEaDuz5R+/zoaImKBP6KhYtW/geZXdeTpNFhnfMfqD7iNuq1t2x0y3AA0HWrXT/MuhKyypSiS36KrxfoZpnlVb6xZHzM0/zpWfuDxlWhY7mAZ11qCRhc5byoPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Tue, 16 Nov
 2021 17:52:16 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 17:52:16 +0000
Date:   Tue, 16 Nov 2021 13:52:14 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc] RDMA/netlink: Annotate unused function that is
 needed for compilation check
Message-ID: <20211116175214.GA2656760@nvidia.com>
References: <4a8101919b765e01d7fde6f27fd572c958deeb4a.1636267207.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a8101919b765e01d7fde6f27fd572c958deeb4a.1636267207.git.leonro@nvidia.com>
X-ClientProxiedBy: CH2PR05CA0016.namprd05.prod.outlook.com (2603:10b6:610::29)
 To BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR05CA0016.namprd05.prod.outlook.com (2603:10b6:610::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.15 via Frontend Transport; Tue, 16 Nov 2021 17:52:15 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mn2cw-00B99m-Am; Tue, 16 Nov 2021 13:52:14 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f19b721c-16a8-43da-0cf6-08d9a929d3a9
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5505782559DF1999B0910DDEC2999@BL0PR12MB5505.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lWXGH3baZC8brfsISMHDLm5xjt2Z2EH6i2cL95Xh1UTiT9/mkHbCoKTbFr4Mi9DmaMgJkL9Wjto/mzf2bY0JDKUuIAxzovi6Iwc47V1mV4WKXY5lsT3ZxDS0ZOa0330BDt53mi97aKssqOGPIK4qBcA7tTuIgWDxd3Yh1umQUcDIr08dzljRMoQRqau+51Im7ON9LcGFz++FZ2OeVs6Evmg/GWLkEqvpF6WPNyZfvhqdGAMwyxMPlot/LHyd9ZmtG17lOI/Vk1RMwLvGMFiM01EgKZCN3Ceu7PXjwRDDywm6yPC/BEw5oZRObUsJjw1kTizb1FLg1H3lss/3fy6bLx8LAuquXXNjJQEuTYd3PvThoRfzLgYl+tTu76mtrAtg22v/gAaE1lgYJomsQEDNj3lJzUtudAuIVtAfNgqmleDnMdoH6hiXI74I/3hSRn9qWwtd1afXlupQPEyaDxJqEJJ7X7UzOR5LklVSlOGx/0dZYjDuritd0x+m64cQFCAtjcndbxfmyeX5VgJbeuIVYlxbkG9nwtH63j1R8nKhHdeE3JkG1C9cma1p4rhzFM3jM0Yv18pUxtQz9vMgID8RvBnKfVZVPJiq/mWTk0BOiARhZGo45CqcU47vxM7mShbV5cAUBJWmoHIYQs4cmV2XBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(426003)(8936002)(66946007)(66476007)(66556008)(8676002)(9746002)(9786002)(186003)(26005)(86362001)(36756003)(1076003)(83380400001)(33656002)(4744005)(54906003)(38100700002)(2616005)(4326008)(6916009)(508600001)(5660300002)(316002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k9wlUF+JM+jNORox3JjVq+qtqfbzXl/7+NwXHr+FSz9y6JEEcXXwubSCXu8c?=
 =?us-ascii?Q?kI40nsDI2GM8oj0JFM/+4jh6dPa9YM33zPkAK8EjxQyyVxYyn9+oV9Ucz7Vn?=
 =?us-ascii?Q?XUIw+hyrZgCC0288Hu/U5J3UUrBfCxRCJf7AAf5/lHemBP9jeSh9BQNx2w1t?=
 =?us-ascii?Q?obHa0v1GgYZy275bgXFwKerZHq9iGicrN4JbTmxnnQPA1EveIFyC6Vd1VNAN?=
 =?us-ascii?Q?G7JbrAqT7ClKrV61mD6iEs0tLHJ7Ny+Ne1Sk18IWN32+iJcj//Q7/C3t7Yj7?=
 =?us-ascii?Q?QSiZHgq0ErlnBPwJJS+dxnn+FMgsGR8dSML+emsqfOF2clCKHLDC9n2GVGbg?=
 =?us-ascii?Q?mOEG/V2B1Y84wvlSPu+cH+Xn5bHoz2yXXhKX8V5CELSljm//Y+K4SO6/B2M1?=
 =?us-ascii?Q?GC3+st6Vzy/7nlkFdIO4DdwtQ7x4EhzoQZQNWshUG6lqsvPCMmbGL0cHZdb5?=
 =?us-ascii?Q?e3eOM/gc9/7Uv2/1waeyYsmQVEMSUFQxHiqhh/mSrkUHLm+HZHVeM4jnlOIr?=
 =?us-ascii?Q?PRdp9PnA1P6k7WGwbaRaohyAt3BweA9/j+UCRa/v8VwRKQXZJy8DxbO/yuiN?=
 =?us-ascii?Q?iPhTU71uIooN8Rzs7NqoNxyFj63oNFT7ASDhrFeYDS9NZxSrammCfNuNPqxg?=
 =?us-ascii?Q?u2qMBmV1Z6EBaLYG269mjUcOWMKm/SDjv8fY2tY8Jj527mb736wHzG9siCrk?=
 =?us-ascii?Q?vo81SXu0fp6s00+poP1RsHfq6pj86zICqDQNZXrgsHQne8wxcXJGqJcy1QPs?=
 =?us-ascii?Q?g7jvo3PlIXQKz2Q15bCYX+nx+5T35qA4yOZnlUnW5Q/I1efYREC8Vx+j1uVp?=
 =?us-ascii?Q?eMqOw8DhjEt7Ti6xZIcBwT9y7ZAZ0d3Lk2SgqR3ENSlXB6dKvrpJUmk9oYHz?=
 =?us-ascii?Q?bTQ7GoJLoIWz822aW/I0iyd4fihBo4WYCkw+6o+ja2oPOWQvJ6ALjJHc6PcE?=
 =?us-ascii?Q?+BiVKl06LTqTxaqFPW1JdWpUq8avzX+ceBtPu42tKVojiHvabGJUvNKg2C4t?=
 =?us-ascii?Q?D9CGEqEOAmrOPH9lARUOgRzH3LNje6t6oGeLG7AsXTPQ41tkEL6ATYiE1PLb?=
 =?us-ascii?Q?RSyW/M+R300EffYlbz4Z5yO6u+QH7gVxJkAxIrn1QCdtXeJoCeIhGnpey0B+?=
 =?us-ascii?Q?ZPkgfHDH3GdmaF1EZgQo7fdedX7z2Ra27d/cO4ouAiPTY1rMq9+9CSBuHgcY?=
 =?us-ascii?Q?BTPBX7cmqX7/5z3h+gM3PsH/CU3DeM/Jr3R+ksaVahnnlqCElp4YM325XEbf?=
 =?us-ascii?Q?1EQ/+ftDdbPqUajq7v+4pgA9zwFAQEyd+nFkUYEJNlf7tgL0jH7QNW2w0Fjw?=
 =?us-ascii?Q?pYdmuCDY55Q6nnMCaQvZZ8cQZJoixTFmu+okH4+R8O7rRwB5KI6qvj9Apsm0?=
 =?us-ascii?Q?cIgDeltn124NS+6YSeZVrRKzX/0ubWFaRbIy0B11AMTD5t3o3CHyK2vG5Veq?=
 =?us-ascii?Q?ncL8cjvC7MGmeualK2DPt2Le54j29LIzqdR9XuyiPcDLIRmVzGmbvB4qfPBL?=
 =?us-ascii?Q?3FAaA0edT/+OyZdvU0Nmz1ZPTiX3YPLtG2oSgTRhf8zsWB3pwz3JT3b+R/dl?=
 =?us-ascii?Q?y0isFDX4zvMdgoHdSd8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f19b721c-16a8-43da-0cf6-08d9a929d3a9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 17:52:16.1740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQOhHdOkGpA5TtF8F1wm8FcyORQ1D9hiw7+4rOA9TkDSHrIjIW7u4u6x6cEKyMYJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5505
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 07, 2021 at 08:40:47AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> >> drivers/infiniband/core/nldev.c:2543:1: warning: unused function '__chk_RDMA_NL_NLDEV'
>    MODULE_ALIAS_RDMA_NETLINK(RDMA_NL_NLDEV, 5);
>    ^
> 
> Fixes: e3bf14bdc17a ("rdma: Autoload netlink client modules")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  include/rdma/rdma_netlink.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
