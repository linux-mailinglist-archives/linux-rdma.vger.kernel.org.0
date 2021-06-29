Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B853B7A99
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jun 2021 01:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbhF2XLC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Jun 2021 19:11:02 -0400
Received: from mail-sn1anam02on2089.outbound.protection.outlook.com ([40.107.96.89]:50126
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231952AbhF2XKw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Jun 2021 19:10:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFqqtMIQJc/poPWFoL5PCxXIOz4oKgljSnJgrU1zK45xCoiyOJJPHjg7NMqYvmL3zHysqgxNKKJknFepYA4GKUbix9Ksso2dSHQh83vkOCns9zAkMq3Hpgricwt2kDTmzrxtl3GUA4kZ31Qs8i+eKcIT0GaS1bOqr5TdoXV1znKwm94pI+l+gte+6TBU75Ag2BWdk4PzfoDUOD9u+Yz0kcb/4RZIaIh6R+WoiVIYQN7+ozEed2TnlCE74BJEmB/pEPNx5TZAOi6wINW9TbEb3TP0WrKiMT1YMFC0/z38yEThKVbAzn0nG013ckfS2P6JUMOUt1KVxA3iwVKW+C/4mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjno58Xbn8BDQL8wko4Rnl3kabEv9FukfUU3m/hXLE4=;
 b=FUzTljKCxnOER2ChA1gtMtIOQ0r9T5OHaC5JYYkDq7DGCaRo9cY6wj1cewzmmkSQqY/eUu0zJk2nKDmWZsPi5UeaO84dGa2jZEvxzcUmfd5J1jsuclLvSxwtMg/af+UbvtibkVJ6WYEJkwyorPegYVYwd42RWXZoMYOyI/qXa2hZEOquE86i02kdxKn9Y8cy5LSJRBejV1xl3Snyd0OPDOkadEhkjN0Ossbww9UbpqwTQkb/Brhe3uNV/2TBpA+TSAhh6ukv7I7nONdWU+ONNaZvG1BWzujm+Mf10AH9ElDaIWwvzVkWVZdNKmnM3zdknkWYlj/Kf6ac/6+5zqavbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjno58Xbn8BDQL8wko4Rnl3kabEv9FukfUU3m/hXLE4=;
 b=kXqEj85HFjx2EP+sJDO94xOsy2725nCR6EdDnVY7d3SoJgZ7ftzTXdc9Zhl22j8CbPiJONVRE1Gp4RnL4pxJTKtl0AvQYvpE2L8/XLN5mIYjiWQIaly6IqB5YImNPhD2yVVvlRyn5vCyV7/q/LjSqjxaWMz2fDYYBOAF/+nQMA44bsE9FSlQHKfiZDeIn5IagnVIIQI+YgI55LtFEtalhZIdXoPjcLCXffc3sBL50YmVIBH2lT94Sl5yB57ptteCPlHh3dh5SfGXozRJi1VCgYczjaCDv6LT2gbz8g/+9UEHHX0B0MXCEenJrFb9Wqx9V4Bk74ZzHTVj5MPb6t4pig==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5064.namprd12.prod.outlook.com (2603:10b6:208:30a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Tue, 29 Jun
 2021 23:08:23 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.027; Tue, 29 Jun 2021
 23:08:23 +0000
Date:   Tue, 29 Jun 2021 20:08:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next v1 0/2] SG fix together with update to RDMA umem
Message-ID: <20210629230823.GC278274@nvidia.com>
References: <cover.1624955710.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1624955710.git.leonro@nvidia.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:208:256::24) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0019.namprd13.prod.outlook.com (2603:10b6:208:256::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.14 via Frontend Transport; Tue, 29 Jun 2021 23:08:23 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lyMq7-001ARZ-2t; Tue, 29 Jun 2021 20:08:23 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbc809fb-4839-4cb7-2b73-08d93b52cb86
X-MS-TrafficTypeDiagnostic: BL1PR12MB5064:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB50646648E3FAA2AEDEB5AE7CC2029@BL1PR12MB5064.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YL1Awq3jNa/r6giE5l0EUMihiD0fpkM1bVxzl17tfccPQKWyZ+KFJujq/ED/luBMscMBuVriZ/hlTA4Fo2iEkjqoQfACgLX/M3KsGUAyLoh4XMs9evtYYZVtTr19weOZiahptJ+ShavqGw5LlsjGsMbT3O5Xzl/MVc8XyB6GmDqOqceR/VHIHvZx4Lmyc+mmFv4Jad3PApNcL3aa5PVmhcKYS8uRzXbJm1OaHqSJGZenAvAU7QFtFnJ2M52wH4zY7za9snO9JG/xfw5NB1hdRthh7bNkI7xNVnefX6SV2tPjxK3PK6VUWBy5dkwwpPQNj9wc1bwKDNUG4PXKwgvCzcC7E8CoQETq8fBWx5wuePBI/CTwc+qrRzjwncGtGLJjzoxiEj2UKdUbxqvEbN4MGQ1FuD4XUtCdBdV8IbIjJAyCLQhms3N46gfC9FVGYzHMRjYoIsS+FiZ/p8hwsbA/A2FCAJgVwqLa9VNj3af+MsmMRloMbOajwdZv2M8FIz3Uo0lMiM+epkp4XB7vTaf4DxlNxKTbUxRKI6RGYGSUpwVpcpT0sgfQY6nZ5VXMMPhegkjqgcwTWqeCi0YKK16vtWQtOpFUQcamWTmxwlCsxAzx04iYVDfsxnRviUIzcMflgybNmgsmYRRoiUDoFORRtjIq0vdq9aGqR2kmXqPYAjbAZxzH+n0vItgRrv1VAAqe4VEkGcLLXDNLZ1JyZt5E124pn3xg7mRojq4Qyv49EYF9U2cs1HukUkGVbXrZReU8QaqjLQClgBXEz84PrcfwLhHO3POCAcVB6R61Q7KT1+L/ELG3r735sWBVyVx0MKai
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(15650500001)(4326008)(8936002)(38100700002)(966005)(316002)(8676002)(9786002)(9746002)(26005)(478600001)(6916009)(54906003)(186003)(2906002)(36756003)(2616005)(4744005)(426003)(5660300002)(66946007)(86362001)(66476007)(66556008)(1076003)(83380400001)(33656002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NyH+lrdXzo/RNhSfdcCsKVcCer81KtdY1A3+zSWnHGVWjp2NYJAcoIiDaRvK?=
 =?us-ascii?Q?3qfm9LeCPe6CdQ2YyQZ27v0ZSB/hhDepl0oMeOnXSpIE7Cjhw1C3hVvE7qei?=
 =?us-ascii?Q?Un0+pfPjPGvTehXtiWhGP/AR2Oz7nWSwhHzC4W/czfFdy/AOlnLGz03zU0ix?=
 =?us-ascii?Q?9gZGJOF0sWR5929/U9bi4vXTP2K3TgPibP5W6UVw3Ehyce+/knXvrW8+PVVH?=
 =?us-ascii?Q?wKSbo/iASjs27n8B4nVmhoPc/l1eT7VtIsxR9o8TvIRjsTuOmyDxNQRkfkz6?=
 =?us-ascii?Q?FBiFC5Ef0eAvI/ndsWOUr9q050wowE81Sv+t96FKo1mi4ywMv4K/xfSxx6//?=
 =?us-ascii?Q?tRwh0N2M6oS5EbYIcBR1YE/Giu8D4fWETjQoasViuo6L0jq7bqKpApL31QOK?=
 =?us-ascii?Q?2RFnmRzgjXhlwMfvvfOrqKK6nxPw5g6+wbGNYtDvvp9PvrUgid3N+6ROpVk8?=
 =?us-ascii?Q?2gwJkBasinXjgTrH+fAPYx0dZcLOc6W9250qDnjac8YwLBpgDs7uOQTShdt7?=
 =?us-ascii?Q?Ks5BsCAB4UGGgMU47tkPvFGaWxctpQNjgoPaIcbHgy5Gg0o+VXwXm8YHyBm3?=
 =?us-ascii?Q?COole4qWr+derFw9irCOuSBAuMntBw2m27fvpF8+hHtCzPQ0GzSrHZkwIGw8?=
 =?us-ascii?Q?G4sROuD64/sHsevnLY1llp3VzYbeKSx5MtcccMkk2ufAKqvuJPLHFt1wb4Bv?=
 =?us-ascii?Q?tLeXf8o3RAGWIj0vua26pIHSC1I0hpBwrs5YM+QUlkrJ1AjFd6iQvZoETqCi?=
 =?us-ascii?Q?CI5nOvHonmuDHDzvBiv5uqnYh/FbqGKs9dMsCgQJqgTAVJhk8mBSUlBvgxB0?=
 =?us-ascii?Q?luzI/rPQvTOvLZxTRWjTuzAEv/gVLCQDQp9FPjog8PIU8/Hgkh8DrggrP0Gq?=
 =?us-ascii?Q?IVEMem6GSYFDw+W+txtMTs3rJWjxD/INqWCFYlCsAnQIIFlM22HlxjN8fP4V?=
 =?us-ascii?Q?W0xfMKUb3bjEbUsIfeSIceFye/6CUikwkQZOFDBrsrm0AeP4VjHoaLd5Q/Py?=
 =?us-ascii?Q?U0JmpGhhi7nCZhy8zxMYY+0EwsEHF0yRhQnFEwWl8IWUVz/Gpmbzl27dQ5wh?=
 =?us-ascii?Q?FfXXhgK/xYuyilG/CQTObdcb0lkkO1+ABeClb8YCM5ESjKnBEQqf9erSLIi1?=
 =?us-ascii?Q?kiBYNrsz3CKmTbnP/FWlNTTWFL210pCoC++t3RZHCl9vPSqdB+/THL9RpKRr?=
 =?us-ascii?Q?TqnjcZSUn9m82pOGuwpghwsvGXuhVEyDRL70KtobdHFTMJnJutkzItnXyHGT?=
 =?us-ascii?Q?AnHTj6DZM4vU03alxhStaz+wlR/BOcdBwro0Jz8vIrRbXgFvC3YpfhVUwiM/?=
 =?us-ascii?Q?XDARbbpZn6/2bwaOTyYO7Pns?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc809fb-4839-4cb7-2b73-08d93b52cb86
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 23:08:23.8596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mHqtdUXwmbSQlLah3AKZmsBBkGwSvfVFBs4nDYdARBSDGPthYBx2umqtzsqiLSFA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5064
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 29, 2021 at 11:40:00AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Changelog:
> v1:
>  * Fixed sg_page with a _dma_ API in the umem.c
> v0: https://lore.kernel.org/lkml/cover.1624361199.git.leonro@nvidia.com
> 
> Maor Gottlieb (2):
>   lib/scatterlist: Fix wrong update of orig_nents
>   RDMA: Use dma_map_sgtable for map umem pages

Though I would have liked to see some ack, I think fixing the semantic
bug here is important enough. Yell quick if there is any concern as
my PR will go tomorrow.

Applied to for-next.

Thanks,
Jason
