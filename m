Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020A43A04E7
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 22:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbhFHUDM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 16:03:12 -0400
Received: from mail-mw2nam08on2072.outbound.protection.outlook.com ([40.107.101.72]:21889
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234551AbhFHUDL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Jun 2021 16:03:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYPc2quASoMkKggKDBAkRbC6GhE0Tgylvg9mP3cr77niBof9QHjR456ZR9FNAztNLrmunowOObm/lvWcGWvZXNiSAwUHLAvFH34wVpQAJk8l1ns2FYDl0FxC0Jr7RiAnFiRCpJwyCganKtzNSIoYWqT4mF2Hf4mk3B31YjZcBqn0NcGYREbqlyhSDmg3/8RsuVGYyABNK1vWf2XYjdMKmRp6VZLEYzxKLsnmGz0WO3sTvAITnHeGJeBX3eiVVPpRT64grx/+e2HAVikUjryak6NiMbzcA7j2x4whVMTd7zSrqEHJ+NlGN9ppStHBnb6LYgyd4WaZF6bXoXr7qYXnWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYK53XgVYD3tb8WOd0NU4Ni8wQkxcdpZ1sQ6yT14svA=;
 b=I+Gg9NFG2D3Op7nV/7qVbLjEjZ2CKSku+V1ERbZhhCC4gvtIZhXBd0zA4UJxOAsUEMP3ZKKCklSBbjyobntI295/hFG9Jf/utEyQANYS+mX0hSuRl3axmPcOJDerXxfCt4hykP0tQf4tSzhtVkctnRfhchEEoZxcrrcEoekI3vMwnPGVS10RQhYXAdZceyctfkWNnzLCExC+XFXfZiNyx9k/tNYPeInaRwAxENJcmh3x+lKEYv2zTT3VIm3RtqK1FhBg/hLZkAgVjDIPfDKSOqI0U06x11I7lXXXfzjnz7azaNnBeM5aXuXrDHYZ637MgCGrVCaoL9eVKzMDlrwTJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYK53XgVYD3tb8WOd0NU4Ni8wQkxcdpZ1sQ6yT14svA=;
 b=VqhhAEpidXmnTg6wo1pSA+GKsf1NovSml3rDg9/wz9vkMVUcQ6xscKbhlfchNjXKfpU4b+lH8nxjVV2Uc+yvBogIm6o7VizukUNPsAtPCslqqQLbQ6LL7DPSHnWawQYgtsdUh5XEprvdaDnzgscR/FUP3Pxnm2/rtgAC3+KW2yn+5osFpMOpOsDQn28t9cOZu63emO7DfV9C56AwAoPXeoayw+EG+hHwyOqYUvhA896oci6/KHFuOypCsnYLLiREs0pqhniGuuOIOgM9prjrb9Vz58KzR+iV2jt+3FkKC1wqJBlMacZ+Dpx3l2SGNCA2C+RxXFu1UHaZy8+clxmq3w==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5079.namprd12.prod.outlook.com (2603:10b6:208:31a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 20:01:16 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4219.021; Tue, 8 Jun 2021
 20:01:16 +0000
Date:   Tue, 8 Jun 2021 17:01:15 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>, weiyongjun1@huawei.com,
        yuehaibing@huawei.com, yangjihong1@huawei.com, yukuai3@huawei.com,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] RDMA/irdma: Use list_move instead of
 list_del/list_add
Message-ID: <20210608200115.GA991782@nvidia.com>
References: <20210608031041.2820429-1-libaokun1@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608031041.2820429-1-libaokun1@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR15CA0041.namprd15.prod.outlook.com
 (2603:10b6:208:237::10) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR15CA0041.namprd15.prod.outlook.com (2603:10b6:208:237::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend Transport; Tue, 8 Jun 2021 20:01:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lqhuV-004A17-7o; Tue, 08 Jun 2021 17:01:15 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08babce4-d17a-4edb-1e34-08d92ab82c9e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5079:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5079ACD20085098385307195C2379@BL1PR12MB5079.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hnSQtHtX1y5rj/VrQnePjICaJIazasLprKN1j14YtvPf8uAU7nno24CZOKKnHitX8SWD6SdMR+kq/MYmIxyJxNGWNrX+ksrhAZrSR53hM3WnLvm9fzbuTvNjzZpm/NU58eOz/5jX3bQfwIp1Yt7geWn53q5XCE/JXMviMyCn6NAo/XKOwNyE2nCAOlTh7c1q/Qae7Ql6bBQEA7WVwTNh6iOURgY2UOC/mVmaVKO09wYtbxyeEbh2sXPzzybezaqlovBoGTPPhu7GZwBN+3PIRSA9HqbanoQZ3hfBOcKSi+OghKhmG8zX3b7zVrZ6d9U8nBu5icmHQg38KnbU5ObMEp+he1PHRHKpEtpTqo6KLxgntoIU4vkt1qA5Huaz1HcovZEzTTwvAM19LXXqVhpUyN8jJ52Ag/VS8KVo3dSzv7/MM3IhMmYFHLxXUYf8D7DY+3GS19MrI7VX6EJYezWi1hSbRXQYL7biOAmqk05n6PRq3NrVJF3VH4BQkiU9rlDmijKFP33fbSFFITGqpmQBEVdNK/WOwS+l3t98j7OTTJmXIeJThdUf70vtEcocov61uZ8XBa4BQcjnDAPnPVX7tCf3EiC2MEu0TbyeWk8bOtM24gd/TY36e+MHN6pKaaehgoX8sH6mXIOMhV7kOUExnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(186003)(6916009)(26005)(9786002)(36756003)(9746002)(1076003)(66476007)(316002)(66556008)(7416002)(8676002)(426003)(2616005)(33656002)(2906002)(54906003)(38100700002)(5660300002)(4326008)(4744005)(86362001)(83380400001)(478600001)(8936002)(66946007)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5bbR99JZ7o/OX8yRc+R2wlMhml3yuesZeVhsra2HxkxqADk5JeeOL6Ie5jeC?=
 =?us-ascii?Q?L4ng0qhq8yL1xtxQ093XAn1DFlQk6kQRoKOd1h2ee1vdpiCeKHhCoWaoUj+L?=
 =?us-ascii?Q?dIvPxI7jZRccXmGnPMO0yElBUDpbbhuSOI6Yyrwdj5TIeFDQmUGsjkno/lNt?=
 =?us-ascii?Q?Sq0ywDdUySq6hXbme4OW02A6YJ6/b4glNa8dQQ0MMnh9YA5IR/hUJyqhqJmj?=
 =?us-ascii?Q?prABHYO+t1tE22+yamlHTl2OAKTxjL0sIQ+QaCIq7XQNdDx7c2Wvy0db6Yio?=
 =?us-ascii?Q?1mkpr4xkwNV91/a71TrBIHHgRhCIeRFgz9GxnEd0+lQnUCkbI2j9i4xtLaID?=
 =?us-ascii?Q?eA0o2tyJIjDHUxp+IYrXDVNtax5Idb5OnjYmRhdncATPcM2Mg6PQhfF6xdmx?=
 =?us-ascii?Q?I/iAMKP9P8VQx095jaIjNaCWfa0qnIxX+gL8lw/LQwl8NekJd+A+8z5RenIj?=
 =?us-ascii?Q?UOz5NVrt3DQszwl3Q12iafBkoNVeclrWNij8e9iH0czRbtiqOxPymbduaGaX?=
 =?us-ascii?Q?8wd9WNzsE9tQg4cZNV9Y5ccrhMGKmbm6zNBUafq03ez2zKCO6bYcJorVG8+t?=
 =?us-ascii?Q?8s2RZp5t57kReB0Aa6Jyl7XSCyAQTrKkbDG6Fde0Op824wHMdqueiGG/3mOU?=
 =?us-ascii?Q?iNtBdjChxqN0bHDKPyPH3sOkymV9gQMrFd8jQbBbN5jpWMH5l80a74OWLzy/?=
 =?us-ascii?Q?TUQ60/7vgjHhoYx1chRrdYLwZi0KC9Ymrmx8lvghwcv8caELnSjSBXMMjPyr?=
 =?us-ascii?Q?eMczxd05sBTwYdSfPrNQ9hzbGr+F/yqE3qjl0x6yCPIcnM4YWIj3WylqFbgE?=
 =?us-ascii?Q?cGhwi8QZhVhgGKnfrnp4OamLHZFO8haqeyfZwQ+Fv5zlIcgHphq2dVhIKVcF?=
 =?us-ascii?Q?i/MKMJw2BUxx8KqyugM1PPGXq9Tv6N4ey+19j27CzvuFYkqObiFMkgKbHnDn?=
 =?us-ascii?Q?x9kClLpXpW63JKhbiQUdoWP6bgJZHHYuQTN0vdMdpZfJrvCSyx8vFURC6mUZ?=
 =?us-ascii?Q?WeXC1uiFCI0ZflXnWhsa5pjt9R1NAJbYYaLx+XaZkUJZvhAOS3ECZ7biDBda?=
 =?us-ascii?Q?a4ig52Pl0aMurihBNoXBbvYd5nNOJmUWM+Jg8aw4grcxIchzqYhNzmspzA5p?=
 =?us-ascii?Q?qSHoocUqJKp8cwdT8+xMmf+f/6FnHq65O1oRwwkmZ8asZVHQgsernqaYlzq2?=
 =?us-ascii?Q?37oztGX7jW8ZtC+BJmC14YPl/45rkGJ56MJbmdMkGQ/Yzft71KjKD2P7+K1u?=
 =?us-ascii?Q?TNOB4Qn4X246mJ6njI1pkMT+dktjpn/mSS5GCBktHRz01imKLHb7hxioq//S?=
 =?us-ascii?Q?eaHmQHAuFEppbzdZqIlhOt0M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08babce4-d17a-4edb-1e34-08d92ab82c9e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 20:01:16.1968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lqGpLIGTMnI9z3xof70TZXyzKmbxEHbqJBoNxrpyix73b52wBHFWv6E7Tu+kID21
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5079
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 08, 2021 at 11:10:41AM +0800, Baokun Li wrote:
> Using list_move() instead of list_del() + list_add().
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/puda.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to for-next, thanks

Jason
