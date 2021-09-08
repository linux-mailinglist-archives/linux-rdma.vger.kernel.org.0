Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8DD40390E
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Sep 2021 13:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbhIHLpe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Sep 2021 07:45:34 -0400
Received: from mail-bn7nam10on2046.outbound.protection.outlook.com ([40.107.92.46]:22112
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240201AbhIHLpb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 Sep 2021 07:45:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZc98nwrXMruyUfI4J7gDv2kRvm5bopea74gFU09NiqvV26z0p+vwFIatht1LhnI0Do1zTOrGAxHCLoFg5h607eBONeUmocjEyV/6H4F2NUDms2gatIyDV15CrS8K1e5yzL7ZBlRrkWCnPSJBTaq3DBu3rDFoOIl0i3FAJahnno9Z3isIIH9DB5qJ3BZP9pnGIOekfbCH8H6Rq/tUZikQG+RJ+POZyFpO0VELHYDDaKc1Uf51bNyB9+JLbh2fhKY0R1bL3BqNcR8Q9e/t5iko2iXnuvIzB35JeJmpBbEdylvuszfltIrxJ5d3x/17NmwBKlDD6Wpxbi5cjtsDrRjNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=slk+C7WDm1MdbytXLJh4tkICgjkRSmM4XV0kLMkSrSk=;
 b=fmOWq+Jxt4zztD6fadlcb4b0aZI3chVCww2p1fuLyNJsiKXSbAjPMCokSsmAksBl+p0dKVGuwjWutwFnCXK9HPQ8T9DHH8S/oniRpjFTwdxejw3xX1FWJMC82NTvOvf+FO/S5D6jHhTbamFAz3Fnx3m86HN9x3XaQ2v4JsiEB9UfZ7fNM7/tVO8JiyA/hOm1bAWIdfy6wPLx89vA8+ULfwIMpqx39+oQPVLcKA8aSxuiP6WzS873GCVT/XYc5H7s9ZbAKNoUgLtBzitQMegqIsrQG4ISsVKVUXkvgLHxv6YESDIrpdVHh7O21Igv7DLWId9A6IGdAUAIALkUsvxlhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slk+C7WDm1MdbytXLJh4tkICgjkRSmM4XV0kLMkSrSk=;
 b=RKfk4WVKPNDbQ81+QuhSQDjC6BWBLY+9G57GOMX+eP59G9BWhYphz45X2zH2WwuwXr4yqLiGp+cYSKfAIGhJM9pnCZwV20vkZ/3z2izeurqwKPy1vLAIUUh3pHQKEF9zP6Uyiw12A5Sdbt0r7Aflhn78XaHqlA7Ty/rr8gXc6jYWqQiv7oX9RqKQPw+IyF0cNGKUuR09lR+rXgA8hVkUeLJcLyw8O2tcpgZjw6e4S3xp15MtjGryB3TFFVpWaYvmjAjUFPO6G0NBnDiDEYSn/6ttx3C0SI6NA5BWG1xWELJggNpj1evjs+TJDaz30DyHSut80lzTyGRFLJlGdLmrXw==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20; Wed, 8 Sep
 2021 11:44:21 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4500.014; Wed, 8 Sep 2021
 11:44:21 +0000
Date:   Wed, 8 Sep 2021 08:44:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        kernel test robot <lkp@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/qib: Fix null pointer subtraction compiler warning
Message-ID: <20210908114420.GA3190597@nvidia.com>
References: <0-v1-43ae3c759177+65-qib_type_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-43ae3c759177+65-qib_type_jgg@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0097.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::12) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0097.namprd13.prod.outlook.com (2603:10b6:208:2b9::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.8 via Frontend Transport; Wed, 8 Sep 2021 11:44:21 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mNw04-00DO27-Pe; Wed, 08 Sep 2021 08:44:20 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4dce700-0930-4dbc-c8dd-08d972bdffe1
X-MS-TrafficTypeDiagnostic: BL1PR12MB5334:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB533465328BB3E8297F171262C2D49@BL1PR12MB5334.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1VXZK98Q49ePOG7tBSmmJ10ksFJOYw9rnLhJfSizXlpQxIesrkTJlyckEDdY4oB7Nwy4WxXctzjY6/Yf8sE2fyNMfeg51EO5DXgwQZEt8BYzskYY1fjCvk0++yzLLQ72oVdIAxq4l0qCeKrIGjnwDgrCSxmZjFJrEp2T8hJO6H+BEiIYC96LzSdpZAG65GtSOihYavmV3BDAVvz3tc/NALKLMXWyMS+cJjkztcQm5gJRTybRxmgbrAX1scUCYM4gwCOaddqrpWE+nM0ENgk+Zd2AhixAATHAlC0IHoOREWh2mOCNpU/uB9pt1//EnCq1r2ADH1O6+ullhmg+y0sPjnaN+6l9HiXhcH3GfqpmB6U/P5zjmObMikUcjGcHLoXdFlF5eTBxtAzc4EnyMC8Ox16y8hcc62lDDXil5Di3jbGtvXu5HlWPxcp7uFhva+aux0CBFXfnKMIGbmIoDBx19vpYZtHTTcYXydhTm6bKIEayZ65OkJMvvhXHcgR3mjag9Om52Hj5vVyVIYq65ctsOhHeDS2/k/23mm0wQ0C1fjO0YMOgIQ4IDUqeqzSsAv8zyFAi6VwztWyuPRBeZkvzaDDhpPJ/19twhEdmKVItXx7MIqgOnFiu7A9lQxoPs0CLMYyevcljjlpadqDpDvtJ7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(9746002)(66556008)(186003)(9786002)(86362001)(66476007)(26005)(478600001)(66946007)(2906002)(54906003)(83380400001)(426003)(316002)(33656002)(36756003)(2616005)(1076003)(8676002)(4744005)(38100700002)(4326008)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?udPjR6iIDrkev6nyLWiwkkqteT74GiicBCPdXNpKdQf2n7nW8YRyzMpVMKjU?=
 =?us-ascii?Q?7jN1b0HTMcVTabPHvBsTR0C6mY8RsHB1lpcA8Fy9JfyxnEUbB7rQo8GTqodD?=
 =?us-ascii?Q?5rzip/B1jEmH6up42+TYJtcArS3yRb+OFXhWAmhrbLZ8J1DeSzSIlmjB+8e1?=
 =?us-ascii?Q?xOzud4ys8q6AlemAtCvkgzIqM+7ZwEJrAmUL05BlqWhh3YFVarKnH+iWuMf8?=
 =?us-ascii?Q?p88vKyslXhEZEC7d6rQ+VdlSP51u1rGE0YtafIEF7sMQUkkaGsA+jYnIF/Sh?=
 =?us-ascii?Q?NvFJjE6RttfrlOhlLFfFqOQ9claXzLNvxJquJDpMZbEzPn+LXZ8xvNfRvITc?=
 =?us-ascii?Q?Ya/L9y3dzIYUNmHzu/cfFBwxWG9q9+d8KqLfQflxkmrIkEguWfmEZs5wKjkX?=
 =?us-ascii?Q?GGQ1j+qZEo9GyTOpfXIId+RpNliC4uPc0X2XEjPFtOLhnm9NYtr1HOcEggPr?=
 =?us-ascii?Q?XpazgkbYiJHBaTNEV5G/JvQOkkA9BxPpqYJ1rVTVr6dpFuHTM8rkDRy7AvK0?=
 =?us-ascii?Q?ckcmeuJG6tKl3by+qE5ecdoVqaDhW8N2ivp3Ux3SusT6sf/k6R0pMjvM/aSa?=
 =?us-ascii?Q?XyV6d45CuxiYFh/QAwKC2P22u9HzXLm74ic5/Vtka2CS04Ppz0Pm4lGuRz8q?=
 =?us-ascii?Q?mslPaPbpjMq/dOW9X9kC6mxLjt5zoh0jMvBwnSkEgdVQ9OmT44DcIo8zciO1?=
 =?us-ascii?Q?PMXBE3yOgZ1Ocy5kHOyX+8k1V3cCMQAaeSdV013EVT+1hmGcvzK9JnsOgk61?=
 =?us-ascii?Q?wHSa0xbechs7aYmEXgkJsODGkvyHGB6hrdmWlUDtvU9hDwP3QFg4t0f9aVs/?=
 =?us-ascii?Q?0dE7eI8QabjE8IIQ3NfVQ5sWhsgP+6WAMpT7TtXOcNYZ1bISRzjOFkwAi2Ms?=
 =?us-ascii?Q?B+LWvJi5xbfM6fCvyUC+ivPom1UXMzTk8+1RnSkIaseJtBn/XnDZjxRQ9Z+g?=
 =?us-ascii?Q?0PDYA02P7mVejcUIXzDWg/8a0mwiYyZWgqa7O9xK0vRZzwpGBomd8wn8OzjK?=
 =?us-ascii?Q?gsHP+WtMebRvzQHPcaJPFn+3VDiwLOwvcReaR0PxIMvUClT6CiJ+NdeACWeW?=
 =?us-ascii?Q?Yp92CN4wmtcJ+4MzGq5iNPuropP7wnW8IpCMlFvNjZ4OG0q9NbsNF88o8qfD?=
 =?us-ascii?Q?eJo95o4N2+z8RZakiowaVrXfy1+ibmAg+0KuPKG9FmkXzIGveT5iiX9e3zg1?=
 =?us-ascii?Q?VqbAE27yaAOeTqPBbofBgHwTy/kSddyrWjLTtdRTy4whSFEVMhfttmAGLOcV?=
 =?us-ascii?Q?Tgd5xUavswqGn/Sr+4kWo6PXggx+fqg82aJXpd1aupqT+cS+Hu30xdH154r/?=
 =?us-ascii?Q?2PGvgKiXUt/m5IV9/DW9P/sa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4dce700-0930-4dbc-c8dd-08d972bdffe1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 11:44:21.9129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7UC/KgdIkLE+U6s0EdUJ5DR0B0k1GPCZRoxXgyKIMkZzcCCmfU6Wy3/gYZZRu23z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5334
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 03, 2021 at 10:07:28AM -0300, Jason Gunthorpe wrote:
> >> drivers/infiniband/hw/qib/qib_sysfs.c:411:1: warning: performing pointer subtraction with a null pointer has undefined behavior
> +[-Wnull-pointer-subtraction]
>    QIB_DIAGC_ATTR(rc_resends);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/infiniband/hw/qib/qib_sysfs.c:408:51: note: expanded from macro 'QIB_DIAGC_ATTR'
>                    .counter = &((struct qib_ibport *)0)->rvp.n_##N - (u64 *)0,    \
> 
> Use offsetof and accomplish the type check using static_assert.
> 
> Fixes: 4a7aaf88c89f ("RDMA/qib: Use attributes for the port sysfs")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> ---
>  drivers/infiniband/hw/qib/qib_sysfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied to for-rc

Jason
