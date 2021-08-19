Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5DB3F1BC7
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Aug 2021 16:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240560AbhHSOlY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Aug 2021 10:41:24 -0400
Received: from mail-bn7nam10on2071.outbound.protection.outlook.com ([40.107.92.71]:60225
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240591AbhHSOlX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Aug 2021 10:41:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6sB1ii2AhbolnZAIIkMfh7KkCmCRu9NzjpGQJp1+e9+7tGqqwSH2vgeS9zZjfmaEcut6HeEK++nXmCrQaS/baEjawiKUZnUnRjGzHyWaLcMPrwj0F3iM3624jL0j+60LOuE1Ne9RIvezsiBA5Kc7OjL9hlfi8I8wMYb5d42sTg40bMiJW39Xs3YHVtgVzXYSweKujv1kEIOmfDvEFABLDsw9yrj+uhJq9E/dAPvDhf2UuprrOt0k/3FlLtItYkIfZ+6YkkjsXn02pYjTwc6nBipf03uzHRr2DjdeBD6bfIp/csLpX2NMealRC5esWtIMsAqw4V5fW7Em69cyGuHAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLjwhUFQHopNvfiAlFXVuG1kzVntjgPg5/0qEEqG9ZY=;
 b=Wmw58y9mxXQZ7i0vja5cz9AQNQ1mP/S/+CQtLAgJAlKc1AHNC0Q5loZCIxLUXiupnRMpODNx+uJyEPj/GjudW1ZSVauAKOf/xor8bV4iSodbxi1QPi+9Vhbd9c1Lz2d9UzJtU03mOzBarUEk4OOqzk3cbnsiGUg5fwOVWIq2sAO7BSM8Adc6BjMyFFo/tCUj1uxzaUYwWQedCuvRHRbc3GLGHxyT85CaMrS0CrFky+w7ohmh2MDd2yc0f0DFncbI39neDQabcMBiNaUyOVU6VhQ/GL2YIpp3AnTXCiTt63NV5pJPUc1qxeP8Lpiyi7GTtScHzxrZJUIERGjCPfG3iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLjwhUFQHopNvfiAlFXVuG1kzVntjgPg5/0qEEqG9ZY=;
 b=GYlXD5iFQ+uJieCzCD6B+VZubsNeFzhlNBU6bAEfkk0FDyrEBXYpJk7xclYaXB8pnrTHwGF/1oh/x0Uzt8i04f99Bk1orkAiTZA+99pGdN3zyyCh0b+zoOGhnzGXPiTbdQVYlvelCrBzA0a9/XZN1ZC7QPZgm6ichHGoJHfsGxB3JAcCt4wVRFa1oIExed4CBgCIXGVWqF4FGmn7UgxZFmaDkGigg2iZZe+//QhuJWWEVwZ8+COqoJ15Txb7sJsZOeeNQUYB8jSHS8cUXZtZyx7yXFn/pDyLve3e78FskjMYWXxDoHpV8npxGvvoNFXbyY6TQN7DzurwD6ED7p7sxw==
Authentication-Results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5064.namprd12.prod.outlook.com (2603:10b6:208:30a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 14:40:46 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 14:40:46 +0000
Date:   Thu, 19 Aug 2021 11:40:43 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     mike.marciniszyn@cornelisnetworks.com,
        dennis.dalessandro@cornelisnetworks.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/hfi1: stop using seq_get_buf in
 _driver_stats_seq_show
Message-ID: <20210819144043.GA331177@nvidia.com>
References: <20210810151711.1795374-1-hch@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810151711.1795374-1-hch@lst.de>
X-ClientProxiedBy: BYAPR11CA0107.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::48) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by BYAPR11CA0107.namprd11.prod.outlook.com (2603:10b6:a03:f4::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 14:40:45 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mGjDn-001OAL-7W; Thu, 19 Aug 2021 11:40:43 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2843cadd-3e24-4404-da22-08d9631f5429
X-MS-TrafficTypeDiagnostic: BL1PR12MB5064:
X-Microsoft-Antispam-PRVS: <BL1PR12MB506455FB55C92ECD72797EA4C2C09@BL1PR12MB5064.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HtKSxg62vysfLq1mLfv1WqszwR27OjiRFOppHQLSsNuWUtcsLEZOyqEbbbke+gzwhqT6OMtCaEfuk0x6EMS4Qtv/eYosTjZkq0BRw8IptwtTkMOGdg5uRX7HlBXwyhyNYjtyMWPSZtsj9gYuKPeJBpNS8vkRNHo6pofzKMS97z6As5wdz3oVCxN0cHwRmDJis3qxPV3mh9S9yQr1YCr2lh+0yJLfe8iPDfCE3WmrUML+ohIGv41rSgsHQG/fmnvwPHxsAnqGHEGBryIm2jtd7Gn0+totKqK+nowX/+5skwDrKNf+jNcU7OrcIDMn1fjA8xiBvm/334HwxiEY+JvZROe0K9WTRW927kPoxaAhSvlw98cak+UQX8cWcNL1YzIkrSZadXbP03RV+E1FA/ryivxBAAAxxzzRCDU/uHVguPoCNmootqqZshsCBsrWAnmgqJZnOp3GV6KFYlZYR6i6/SJyo1fq6ASnftnZZ3qQp7ZQEr4PG91eVFSjdvgzXnvnlEFI1t3k6Eh4hVDxD/NjlzjlINVPImI746AwUydJJD2YiQuSFNCzS6BS4C3x4/gLULgKYYT+uYtYFFrc2mYcLK9znzux12oS53ts3O8GF+VjIQD+Se1pXyBVAqrfPiwWQtAeZr6A6uyxMOSDIZSXfIsRmjMjLAf7T0KxhgOed0+1Exvxp2o+dxf+cLnB1DasW9MPTvBiazBRwcJGNQZkvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(6916009)(2616005)(4744005)(1076003)(83380400001)(8936002)(426003)(316002)(5660300002)(4326008)(8676002)(186003)(33656002)(26005)(9786002)(9746002)(2906002)(478600001)(66556008)(66476007)(66946007)(38100700002)(86362001)(36756003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LeWaBtcZjlikKbiXV8hhtUJ0OMbditWwTbCZj0tlLYa47pM2S22gY+kZYX4F?=
 =?us-ascii?Q?ne83PWVi6HXiabBeabMcW6egBn5O1kkAfQw/QZuivjBeYKEGdXfS8XjDdUSA?=
 =?us-ascii?Q?aXq4N+foFI0dM+8Ie9mkA0z6TN3+obTZfrQW1vXXKoTPoV3Far0nIhXbssPq?=
 =?us-ascii?Q?vktRScfCnmoYF3FSY8FRomg9ME+a6gSyuvS4r/PmeVRHCOSbPQS/KcrMFRmE?=
 =?us-ascii?Q?9BoJI4Bw6UhRyptsOfkTdfa/7ajznZsc7Wyqspx2SE3AUSQuvXmPnbs6eoBD?=
 =?us-ascii?Q?//iNV0nGJKy5Igntin6VNbt5lkwkGreh76J1SfozyNH8wS8Dr7uqeiUnitrQ?=
 =?us-ascii?Q?Qb2jxEaaX8dXTem3xHhk0myiTr0dnNMxuoc2vToZOK+jhUjv3xRsC+8IXpzs?=
 =?us-ascii?Q?Fx0U1Bfn3YomwWH+fb4Oc5rDezT2b27U7qSI8AOBj1WfoiCMDiPp8qe9qhWh?=
 =?us-ascii?Q?PIPFQxiX6a8ncu0vEhXn2Z/+dzsO30wgkOVritqjjWseN1NZVILpFIg0EY/h?=
 =?us-ascii?Q?j09xva+RWih7TzJ0U/EHeRinvu6aj/lnnO3hA4SBmpPe2H4IwPH+//zFA6QC?=
 =?us-ascii?Q?OTYNPHNDkLuwVuiTm6uxnBdUYIjUUFbuioXRobAQMB5R8sARWUtHQ5/ayvfi?=
 =?us-ascii?Q?b1/rU9ddf0ACEKgQRjWxwhA/SdTWxgvzZ1h3Y209XLfSAUMFGKHVSqM3fB+h?=
 =?us-ascii?Q?HPvKvqK7mZP50XJTnWt/x1VilIs/0bmo8blZQWhI62w4+y2NmoZLaiXmLwyk?=
 =?us-ascii?Q?L8Y/DSC9hwlKvL3IbO9EIjVbExpSrOJwi5UGTS45GxqKB3frrGuguKEiWIlg?=
 =?us-ascii?Q?Ry7s6cIHlh6b2Jx+6gQdhyQ9EBgcWQLEvxemLsJRlrdSz39h7G/hnf1DXw1n?=
 =?us-ascii?Q?mNvXcS8uw+NUWtT8ZFFDEFsG50oqLdhSY+Ve1xXjJzlGWNbWDcyIxgRg9hYW?=
 =?us-ascii?Q?5BwetALQ/XtYdCA7DIXdqp5QfllzSYGiO2Z/xQv2KNyEZGDfwFiGmKx/jyxk?=
 =?us-ascii?Q?B89bIaiuLts9jAC25k+6fgRq0xam7Xn7MxxeFarnfo+lKABmGYmZDdLn6JTX?=
 =?us-ascii?Q?7G5AZnAPifUQWsUI46Jn+iNdKnsdrW1N9E0tI4fuzzvUoxwwCBbQGPzvR6AJ?=
 =?us-ascii?Q?aGWs7/qY9YHMQ0x7SiRoHIyIlUAKmOfKhxW5TcPgS8B7FPayUGBBYlU2KU2V?=
 =?us-ascii?Q?RPgWty2VJszXA0clv8v1QOGXHwxe8YyJfkSynzU5KGSMjd0e/ajA0G0UmcbX?=
 =?us-ascii?Q?gft77kigSBU3mneDS/1fxwZtmG9FclXQNGkmBoWFlU8qw/ckXdeTb8nLN3YV?=
 =?us-ascii?Q?7aceG0T8zX6VW5eG9BAUukLN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2843cadd-3e24-4404-da22-08d9631f5429
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 14:40:46.0265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8ZynDfjOrkVbBHLZY3YOEU6C5Tn8rB8vrbBk7beWWPhyBu1ZJtK8mLHZso34ofA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5064
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 10, 2021 at 05:17:11PM +0200, Christoph Hellwig wrote:
> Just use seq_write to copy the stats into the seq_file buffer instead
> of poking holes into the seq_file abstraction.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> Tested-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> ---
>  drivers/infiniband/hw/hfi1/debugfs.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)

Applied to for-next, thanks

Jason
