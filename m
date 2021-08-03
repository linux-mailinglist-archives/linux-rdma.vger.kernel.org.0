Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0663DF4B6
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Aug 2021 20:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238766AbhHCS0z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Aug 2021 14:26:55 -0400
Received: from mail-dm6nam12on2042.outbound.protection.outlook.com ([40.107.243.42]:47200
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238736AbhHCS0z (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Aug 2021 14:26:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBi92FosBgTGqtGMM0sO7CzX1kF3Ql2REvHEX0LXgPW6Fko1OdiFU8Q4QNqnEc4UkSNM/+ZP3ZLkGBxrp/8yib0g1OLHXM8tIxTXxZNhQtTRii2vtowUjnd8dfs2n0U5jZMgQLpn78S5JHNJ/Tdsh1aKApU8juCIFMtKnt1d+w1kqt1rxoiwxKdOrsts8ZsO3zrRb4+HOIFJLMzmMjvpofIXj1k9rw6hyjj7K+Xt/l1MHJEDe1boj8Rbgc+hJxhXLNbDk/8CIk9A/0iE78iir64n8dfE9Z8LfYUGMl7pastCSpIopM8OXjx6BotvKvILgwLr9XIws/Ypl9yLKwmKfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZw2knmT7VJwlwbSWWkbYtY6+sI47uTDSqGUHFt2Qvc=;
 b=nobRTr1rdb//JzQ7c1qXtiDM2+0FWKDS+xl9WxVdLyA+IXTVhhm2W2Zur2OLNtTL4HXz5eWWENqCN/ZzUotQG5F6sVAC5+iZlJQLJJpSGjofyJQUZEgBZgDLUa1zu6h+OJfy+1XbqqRXvpMsz6HyaZBDUGM1VNx/rDQcLQo5OBvgd6KpV4uRqA/jJ1Gp0FDF8utdnv0tV4x8tOZuX63qGfAOWg9bHAjcUHi5Ve5+6b9snrxVAqH2ls3CiLLsDtFUA66kN/wfoGCJ+u9BX859X1SbpCG4wYDF5u6sjZhUMTsUvXI5JXLV5HIp5rsFiLM7521kQro7q3+LNtiAkYbnSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZw2knmT7VJwlwbSWWkbYtY6+sI47uTDSqGUHFt2Qvc=;
 b=uNTLawPZf68Jt+HLzfKcGO4GCt8/Y6XjyX2iGZMldbs/Ge6thMwNp5nUj8MOO+dSpbKlexv3mvYPItXUmycHC/X76z6SjeKOTbJwTON0mxqrgPa3WOkJR+WOLAGpB9Hcu+PhCVLhewRMwsSDh/vlCcw2OaMLscXEVL8qJ9Y8s2WgFCvc3KsfKtSu57ZHFN43adYsS/BVm2ukpB4A4NrI/H//Tpf2D0edKG3ESWGp1aoV3gGoAD01ItdAuY+vLg4JiU5ziFWra+B14TANPLT/rHu3tMPXLcRKIiSbmxnBdQ38A2KHE4CGxg3EKqPK7zmGxfUUOcyoQJ009rT774875Q==
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5301.namprd12.prod.outlook.com (2603:10b6:208:31f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20; Tue, 3 Aug
 2021 18:26:42 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 18:26:42 +0000
Date:   Tue, 3 Aug 2021 15:26:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markz@mellanox.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH rdma-next v1 0/7] Separate user/kernel QP creation logic
Message-ID: <20210803182641.GF1721383@nvidia.com>
References: <cover.1626857976.git.leonro@nvidia.com>
 <YQmGsMPyLQ2decBD@unreal>
 <20210803181312.GD1721383@nvidia.com>
 <YQmIRgF7UOZLSX9W@unreal>
 <YQmJHvUBYXjr0cwD@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQmJHvUBYXjr0cwD@unreal>
X-ClientProxiedBy: MN2PR19CA0059.namprd19.prod.outlook.com
 (2603:10b6:208:19b::36) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR19CA0059.namprd19.prod.outlook.com (2603:10b6:208:19b::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Tue, 3 Aug 2021 18:26:41 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mAz7h-00CEug-0j; Tue, 03 Aug 2021 15:26:41 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df14efa3-112a-4700-3976-08d956ac3dbd
X-MS-TrafficTypeDiagnostic: BL1PR12MB5301:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5301AC0B08B8430D986AB796C2F09@BL1PR12MB5301.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W6aaLHBmvGD6A+vU17yuIKbZc8r2A5i58kSUhLC4pTB66FP8K8PqiFn9gzyWDEaTVGpfkp6ufkIdFq8VexCibX5cAi9rXrzYn8V2oHtMcMeePsl01ahznsexT2ohsh1Dvp6GQIa6C91P8CnWw5eUtPG8yXK55VRZg0xRGfQl/tpy7vqq2p94ga3Dol2SIxueX2cqEyuWRWJasK62egVi8yP1XrEWTNWlP5oZsGDNAQ8BK6onTzR1DMrISB4FaBwvw2Eq8GMnn0fDmyqDO0Ed5RJuWf7FKEh3fKkwuP+qhBRB1aNM/I+GrpgJkpSD4xdPH2wKHepAXmyjPKlnA3aUr/QTfitvdbl9yDcLKnwBsCZJF73rwPdgoVEX2/sMJh5gB3fTgVL1WaoWVjfNPyllkJkChAhfSPYQ42A4XWzd7F8N5ccFNpbeL3O3FAio9x7a7HqJpwN1QbAuWfLEH1XjRUI+ECCNW1qeviTEfobVSKc8XUfMTfOO0rOjML5NSMrrQ87lxEcNb4oVs6rQutGniqnT7s3is063DDHMPzO7pCN3wKKBp3iOQkII1UR4hO6gIpOPwNqGlFelyhqnQFpyyB6pzD1YHFZGhZY9Dzh02nq9/8wG/rWGMsx1K3mMGkfflgMGaaWUHBtqRhJkwGPkDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(558084003)(426003)(8676002)(26005)(5660300002)(6636002)(86362001)(478600001)(316002)(66556008)(66946007)(9786002)(66476007)(9746002)(186003)(2616005)(37006003)(8936002)(2906002)(33656002)(54906003)(38100700002)(36756003)(4326008)(1076003)(6862004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1h+wXJws1jNZeu1TWfLxEpqdrQfXI7Wxu0Ea56DlehA6sphCkZ/0BpsqN2sM?=
 =?us-ascii?Q?siySUf4L1yvzNhaTnV/yYb+Q6g2Dut/zAEaCoOBhrL/DiE2/qefIaRoxDla+?=
 =?us-ascii?Q?oygfOy+YIXvYITrV0PcimUBAnItL5j23OIH+xfo/tFez59+utCYU2fvXRoeG?=
 =?us-ascii?Q?k+2uvVnxu7yxVuVV3jNBZK8elqj6mR+lfIAaE8/XPKBnyGhLvdtYwBrO+gSG?=
 =?us-ascii?Q?/JzqqVYXa+LVrOQnZkmMw/H3RdIxhQIIUlXRqOHyFA28N1ATZJdoblMHmFqK?=
 =?us-ascii?Q?dQzwUOJWJsniwo6Lsou/3nJWfRHqL9tm6q75bRfImT1TpY/sxuHaUVehoi6o?=
 =?us-ascii?Q?Z2Qw/a4xaUU5G0qAyz51Sh83agYMhAZPWowZYEh1EgfYdZPS/LqCa3YqP9Ds?=
 =?us-ascii?Q?one5JZ1BjJy/Ag6dQrcCsWhvEcVYO5gFWzwKshIZagakG8h5FJFKINwVZecJ?=
 =?us-ascii?Q?rzVSpsTsY9SGMZu3c9e9fuRH/y5bxIHHUDdhxkW9mO2HQgPVXqY2QJfMpOtq?=
 =?us-ascii?Q?qlLTJCz/t9gVWlIHCMmwkv9XXcH6Gnf9XOboKDYE5+AVOyFe4BMVajMIstU6?=
 =?us-ascii?Q?M7t8ASDgp2Jdbyi1lxXLfgpc3UL8VFr7pwQgcBis8xsIBu7clX0kboQhLhFR?=
 =?us-ascii?Q?Br/FmpoHkSkljxTe6SdvQkSI49p5/cgVcPguRKHcVlMLXeUM1qH+3mGYO/H5?=
 =?us-ascii?Q?SPgoM+qPYucq3mfnhMW0Bb+z9HZBSL9sC8zlsLaI1zKHZEmVmGo1Z44LvZKr?=
 =?us-ascii?Q?a9ClLsrDN8IqIuqaPETkWFqZg7QeeL7ZY/mevkAe5Cx5S/VxhYtM2d+Acfht?=
 =?us-ascii?Q?OGCNvIKWfTcCMJaDPystxbBjRWzsig9fLzGpIzkNqtmKawmF8FSaK3O+A9Kt?=
 =?us-ascii?Q?84H9X86w3/uJGVgo+dTswDYx2oaNAbhM2OglGjpc762lCvLbljSD4Ff4raYi?=
 =?us-ascii?Q?mzbTLlRYqD/oI+HI1WseYjQZhfqdxaaUs5IbJjpIheJ646KblDs+Mi1t3Osf?=
 =?us-ascii?Q?eV5eFz8LhFCG1WoXAQ8sVXEpJeJKA1LBWbDPTJuvoQVfPI3W7XkGouFAsBwk?=
 =?us-ascii?Q?yn3r8rB4HmvXi9nQ2DAPhO+SZL6/fo9BkeiLTmySW88XPsIW0I4684mTbMOq?=
 =?us-ascii?Q?2HTIzgM4+wog2FlrWwBDbSNkzFZnPhy+/seDINGyiNiOrIYEnmmJ5sqLFnxi?=
 =?us-ascii?Q?StbDhMBkqXC8vfvhsoLZbd04OmWriMYu6EfVVNJQDL+5DvfofFXnwdPa/0kS?=
 =?us-ascii?Q?6Zu940UNpKt4OoqchjvBARgZfG0RbxcwwpOB5hC3E6LDfd74I0XwahkiT0mS?=
 =?us-ascii?Q?O0trOj8CemyQ72LCo923c3lG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df14efa3-112a-4700-3976-08d956ac3dbd
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 18:26:42.2060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ajbSca8ousr9nOorv9fF7d2oXcPZgW1ghCYqyXZpTCj5G1TX2FKQGBMeFsAshvN9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5301
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 03, 2021 at 09:21:18PM +0300, Leon Romanovsky wrote:
> > > > Can we progress with this series too?
> > > 
> > > It doesn't apply, can you resend it quickly?
> > 
> > Why?
> > 
> > It is in my tree and it was on top of QP allocation patches.
> 
> I resent the series.

That one applied

Jason
