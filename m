Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328204217D7
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Oct 2021 21:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhJDTp3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Oct 2021 15:45:29 -0400
Received: from mail-dm6nam11on2084.outbound.protection.outlook.com ([40.107.223.84]:46561
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233355AbhJDTp3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 4 Oct 2021 15:45:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgOsH7uKRZWzUQ6tY9QLm9mHLCr1j6ZBLu9JGsx+IYHjawIpPTNj2CCmBMNW7qto/Q4L650qhDFn2IL8C6DfLe9PXEj0jceihRnMF1JrU19mDopn2eYr5VbVYe94aDP/58p47n84Lv4Swm173Fpdw7F3+hETPNeWywScgRs+aHDsAbvMPqZyE+8zDa4FHl29nWR9trhLHVI9qHqtcL6udVlBCKDlmuQN6mpxp1OEx1Zz6gKT0TdHYqYU65N88zWmj4mSHag8omtghsnJC9v4RfqPFRdCUl9/8mSzQ75hZc4oE1NW794dRr34UwL+rD4dm5rVjy2RKaZt5tjnzmXlsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEWNy0pFQ7Ez0DPL4UMupzt61mla88OPR/ottK7srv4=;
 b=XLx68vkRMv5hlw36gR/oTKJnXTCNbRcBgKVMk3igUDGZK5iDpFoIQ7BYKiaMBKwmopI8Ikz4Iv8meyeV4eN+Dr7eW7M7oLHml1xKoSS63xGm7JRKKmNj5ENQTkcAlLURdKh9mVYxBJhVFdIgmKKa/MvGZd1KKuLPemp2xuPUXNnh/WzsbJUHYE130yvc2b1BLF3t0FWAwdz08B5Fx99fI5UIfz3AnhRMB+R9oARR+ecDD+gyFEL4C6jO7EvhcpXO41U6RFv+ZeeWH7uUek7mkDJs4CVvcKI5M2/2+eZHsVe6ZVi835FvhIVJcYS9nrFC/hF4VGFyGsytb3UAGvM4SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEWNy0pFQ7Ez0DPL4UMupzt61mla88OPR/ottK7srv4=;
 b=HOiHHTECIcwiCuPv91qMVNRh0HeRlrAFW/ott/Cli9WhgG/P+jKs8E8m/9x3azTbWjYf8qigNkD1wDKeEZyW06Vc89kmNRDsc47FVApAyu4NrUq9o/okPT0fJD78bAWnsc7YtwPYWHhIgAnYukhWA9wEiyiCqBwNWjW+CJUBK4APGU1VzpnUPFqzs5Usnp16tZhhPsxNwAnseoN5xPyd/TbFcx4wUmeCFuD/SHde/zVvCzNlKKJPWDFldn2vTrYGSTGf/ZjjP9SVkveS23G/lTDVy2jyyVChP+5okIY6BA+I/21fEOK3XiqhJcrQhl1mSWmm2Olsx5EdBjdondir5w==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5078.namprd12.prod.outlook.com (2603:10b6:208:313::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17; Mon, 4 Oct
 2021 19:43:38 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 19:43:38 +0000
Date:   Mon, 4 Oct 2021 16:43:37 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/cma: Split apart the multiple uses of the same list
 heads
Message-ID: <20211004194337.GA2571455@nvidia.com>
References: <0-v1-a5ead4a0c19d+c3a-cma_list_head_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-a5ead4a0c19d+c3a-cma_list_head_jgg@nvidia.com>
X-ClientProxiedBy: MN2PR18CA0020.namprd18.prod.outlook.com
 (2603:10b6:208:23c::25) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR18CA0020.namprd18.prod.outlook.com (2603:10b6:208:23c::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Mon, 4 Oct 2021 19:43:38 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mXTs9-00Amxg-Ed     for linux-rdma@vger.kernel.org; Mon, 04 Oct 2021 16:43:37 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc1fef89-df70-4d2a-a6e2-08d9876f4317
X-MS-TrafficTypeDiagnostic: BL1PR12MB5078:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5078F6C8B7947192D717DAD3C2AE9@BL1PR12MB5078.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: csXWzDgneBIvhMvVND0DDqrMkrmyXBFduURen+EDYPzX6IsMgt9z/CqHox8fvh9idHruuxSoU/g6KC1Q5hkw+h5SjWg6nnMpuB77q/Z8ClJH5oEGvMYj/hoJASV7g01p7z9yBRiF0irAGL2a7eAtWF0uK1IaLy1Rg6AbERFiLsLxKQW1ibq7cPqyblFbwdNXllVDoiOhTV0yCkFfjzGP4R/uxzZKrCBPyO5JNzSS+TZgTYZKynjON86hzqbr9MiscIRt2XvSpdnWpvgOwNZ8xp0GJeG4zzKfvGDW3UDgwq71EKlRhzCodiqhuJMrG/vp7HHpfWX6D8j9RMeM7mSegoX3yuK7OjQjO3tfWJLCrJC8nL+sitgcrvDWXktKoHq7TyZIhAT9X01huYTbSDhFj7uTMHpW0alsaFHhftAHRL4bChDuTV+0WhiA4UygxkibNpfpLseZZ6ThvJbnUWFRUSQ4Ed4Wah46d2ipjbBpc6TxROn4xglj9IMgecq+xH6eVVzWn1fthc6R8vRTmrxOxdK514y91ychUGOC/JB6Y+43B9TkM2OqqFrY2fkchsmYxdWh4jNmGC5zDwnXNkpdNBnVwIkre/hTeN5NHk9aN3otN1KZnKxTmCql76eFFsKZlRAUk4hBmGPJa94WFQp9TA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(2906002)(26005)(38100700002)(66946007)(66476007)(66556008)(508600001)(426003)(8676002)(8936002)(1076003)(36756003)(9786002)(316002)(9746002)(33656002)(2616005)(6916009)(86362001)(186003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+zuiya/RgKTT8qdruQ3ntREXbSRPs7mavmlTgRqbSpMGrgnJ+FDuZKEmpBlz?=
 =?us-ascii?Q?Uj7QgyaxlUW1wdXEX2NLnmxvc0D6Iixom6PLORuflpmE0diZbtDk3HN9wL7o?=
 =?us-ascii?Q?UZlN8IyUgj7a2fuvViu2Va8nuQ8ClAaLPikrR86mg/uzhk5U+zpqF4/T7qb6?=
 =?us-ascii?Q?DVMLSLuTRRuJGYnAaCELqqYEPJWwZQXE2Yk7k5+Zyxcr9dvUbK+kIwKnF0d1?=
 =?us-ascii?Q?aWKgfeRidrgL5wcpvahg3vIfCt1yu/tQPZIrYXe1WVm4vnXM39iQLcHAlqnS?=
 =?us-ascii?Q?Xd+eK4OJLpfC+7X4jYzYFJKMQRlIqyWgVLo2RtE49YiVGM+G862WrXqHdz+4?=
 =?us-ascii?Q?sqXluyTzVDIbXTuyN/EPTCZNDSD9pruoMzYDynZIw+vvlzfneCIcMsIp41jf?=
 =?us-ascii?Q?98CmjnoVd3vjzVEHETTO/MSSmzzDENcEImYiZgZlhP5gPsF/lxq0Sf9+e94r?=
 =?us-ascii?Q?ZwRETr16bgWWa7xjhEJMLqoCzhCZ/Hb0YwRODiiw1qnYNMIh0yqeOtBt0oft?=
 =?us-ascii?Q?2KLkWURQKeafDuOla4ICJ2ciiuUoybNB+ctR+lH08tWWUWK/u3EqLs47dS00?=
 =?us-ascii?Q?H5ckiKNcTqqpUUnlVWsqmxVu34lhlijP9y3KO2BTUHqWhiXGnGIrUc5mQtVD?=
 =?us-ascii?Q?CFFqdVQU0Jg7j32nY2oPjjRuCoYqHzGbFwoysSeF1c22Ibxh+bZsS2/DcIxg?=
 =?us-ascii?Q?zWmU6VobPh8Air823Ymy6sx98vibZ1ilQVx4281Wk0L6jtgleMrGXy62bP9W?=
 =?us-ascii?Q?EKDl0wpdw9HoeoPyG22n3ALtXptJygmKuJYIXkcEdioX0AQH+o11xCLNDDAZ?=
 =?us-ascii?Q?Z0jiktUjGGeRcxRhpu7XL8WTfefKCzH7H7jJrM9btEnzUa6Ll8kh0FrHdfa6?=
 =?us-ascii?Q?8KZAaeAE8dwRT1awP+ZBAQbYO+bSrCEjyxCi/ezaZhmu0o3WynY3SESq60tp?=
 =?us-ascii?Q?9n9RxskYKjpwC31WKSypHEdUnB+8SXUohW5RbRG5m3/CpPUGNGxk2nFGU3+b?=
 =?us-ascii?Q?TMvjWdT+NuOENS29AIKNU0zgZCIntWeBB2wA7itNhIXMuQ+4uKV+pamYvs8I?=
 =?us-ascii?Q?kZj3eZTbWxv2XFeWvLcIPwwGb7zLsqWGsuAObU7hlJGM84unf1t1egXQdS/y?=
 =?us-ascii?Q?Y6aNbYm9b09+LmLRMJlYIWgLjJvdsh9YGSEu6nh3i3Ul9lAwGfQKlbH62Dhx?=
 =?us-ascii?Q?QWfKR3F2wZ5foFXeDOeG1gNyfExBifDaP5tXRrutVVqiZ0YK9AsxKfIqcJYN?=
 =?us-ascii?Q?VYS80ajnbjKQ8mnZlBRigtDnWG6NBXgoNBVIxECYH59gLuH1Zx5CGqe4SQN+?=
 =?us-ascii?Q?M+nH1hOb/P/x/xuK5ZjWOpDsRmbeB3q1Gg7Ae6C+bzqTRA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1fef89-df70-4d2a-a6e2-08d9876f4317
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 19:43:38.7942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fi8jhw7HL6GNPaLPJ7oJaDvIe1UjVbOSqJAVwvphfN3juN9GUxZPykUxVqcz6V7Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5078
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 15, 2021 at 01:25:19PM -0300, Jason Gunthorpe wrote:
> Two list heads in the rdma_id_private are being used for multiple
> purposes, to save a few bytes of memory. Give the different purposes
> different names and union the memory that is clearly exclusive.
> 
> list splits into device_item and listen_any_item. device_item is threaded
> onto the cma_device's list and listen_any goes onto the
> listen_any_list. IDs doing any listen cannot have devices.
> 
> listen_list splits into listen_item and listen_list. listen_list is on the
> parent listen any rdma_id_private and listen_item is on child listen that
> is bound to a specific cma_dev.
> 
> Which name should be used in which case depends on the state and other
> factors of the rdma_id_private. Remap all the confusing references to make
> sense with the new names, so at least there is some hope of matching the
> necessary preconditions with each access.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/core/cma.c      | 34 ++++++++++++++++--------------
>  drivers/infiniband/core/cma_priv.h | 11 ++++++++--
>  2 files changed, 27 insertions(+), 18 deletions(-)

Applied to for-next

Jason
