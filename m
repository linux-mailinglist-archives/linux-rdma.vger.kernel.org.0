Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD8C263237
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Sep 2020 18:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbgIIQhK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Sep 2020 12:37:10 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:25807 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730949AbgIIQgG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 9 Sep 2020 12:36:06 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5904720000>; Thu, 10 Sep 2020 00:36:02 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Wed, 09 Sep 2020 09:36:02 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Wed, 09 Sep 2020 09:36:02 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Sep
 2020 16:36:01 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 9 Sep 2020 16:36:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHjhMwTn56UHoVNZVpihMJ2nX9sszC28U/4yvGjqSQkrCnVMmrw3QOQcddDmhC9emV7wXCTNO/MbEb5ySQGn97yLPZsFlOkKFtzMArP5AhjuzbcegMFwzzEUKxYNlMny8hII0ftVQH4s8gFN81aLTMTXJGsv37pYp5mdWEQUZ2GgwNH6Ikqz6H/QB4oV8uf4OWMwM2jfnBShjp5NA/6+5c2gVFrcB7hwESa/D1Xo6FJe+P9ta1PXWehqBPRG23gHGyJU1Zzk3MITnWDPNARk4q3m7MINnuY5Plhr3VSKbruTBTGVb0tQNyt0Asx6C6wJpopQKJAHssM5MNBPGj8dsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xPXOYy1PzkCR8P6SPzim2QxerqN5BRox8t6/RMzuZ8=;
 b=H5fE5t9CIqY9BVBQnQ1BuhR5Qq9w1BHuS3w18dKo7WiubjKQeNDsdIU9SaJoldsUv7uxvf3ineEXBNqc7bEQ1RvjIbEyek24VIC1HVJT5j2eTPUaeoyD0Q1jXSOn/Zatf2/FOSdhCQbm+ki4LyYewXlhMLnmTvHch8FmOJLmwKr33mOgtbRzQOsZDwKnt/iVIw1yl3h1xdBZH6Ss8HSTV6cnHb0odj7YqyL1NvIEZPSOT5e/ILpeXv+7aQdXOBcECFgRQ/rGrJ+hpiK3F4DPpL9+K8MkIz7OJ37s/KdNP5zG2q8UnX1ogz011w8VLPYxzgi8RFQd6ghpfuQkIsuNhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: cloud.ionos.com; dkim=none (message not signed)
 header.d=none;cloud.ionos.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2582.namprd12.prod.outlook.com (2603:10b6:4:b5::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 9 Sep
 2020 16:35:58 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 16:35:58 +0000
Date:   Wed, 9 Sep 2020 13:35:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
CC:     <danil.kipnis@cloud.ionos.com>, <jinpu.wang@cloud.ionos.com>,
        <linux-rdma@vger.kernel.org>, <dledford@redhat.com>,
        <leon@kernel.org>, kernel test robot <rong.a.chen@intel.com>
Subject: Re: [PATCH v4] RDMA/rtrs-srv: Incorporate ib_register_client into
 rtrs server init
Message-ID: <20200909163556.GA882483@nvidia.com>
References: <20200907103106.104530-1-haris.iqbal@cloud.ionos.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200907103106.104530-1-haris.iqbal@cloud.ionos.com>
X-ClientProxiedBy: MN2PR13CA0033.namprd13.prod.outlook.com
 (2603:10b6:208:160::46) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR13CA0033.namprd13.prod.outlook.com (2603:10b6:208:160::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.5 via Frontend Transport; Wed, 9 Sep 2020 16:35:57 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kG34e-003haX-LA; Wed, 09 Sep 2020 13:35:56 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4859463b-039c-467f-fad2-08d854de6e0c
X-MS-TrafficTypeDiagnostic: DM5PR12MB2582:
X-Microsoft-Antispam-PRVS: <DM5PR12MB258204C5F5AD0EB542E50AAFC2260@DM5PR12MB2582.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XtH441FTnVeUSP//51WgrVrzPp2pUzi6MQNStEHM4YnsE19H7105JXCwPm2214PoCptR9gK2KVE+ocwAGpwjwWHu3XH4MtQUu1sJ6QYo6/BjuSESvZQZYSLVSLfJLWsKp90H6+rhOW143MukWNwrnzxIDOxfaQAsvhx8osnLcVlkeRYNNvim9Pt7L1QU1D9CZQiIytOTRiPA6z/F/WjC9HPLPaUlp+7QaJfoPiy7uKgCrh2ngnKZ/6xC2oV7wIsJSsNLm5foannbgrPNGTtsfA3O/LoRdiXqNJeXulHV2/Qrs7ONMHr/8YI26nNKs8LL5eZ/ZGbd/upj57mWKx5AK9X4yHI+1pSptkZ1vm8EsNJ6aEJdNxNDruQvoSjjvHF4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(45080400002)(66556008)(66476007)(66946007)(186003)(36756003)(83380400001)(5660300002)(26005)(8936002)(316002)(2906002)(4326008)(8676002)(33656002)(6916009)(2616005)(86362001)(426003)(9786002)(1076003)(478600001)(9746002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: BOQw6pWZtM7+IjT10VwUvHts6jpaZk6BhY8lVET3fMkspoZnEZj3O8/POeIBXPrvHICBh52KzqcUD1lVfLiGr+SvrEtGZOXESIhiqn3U3aVcHQmccOQClVHxnc4PbS8JnIjA7xF4Ml64b2qozn5TjzkB52/lo8LNPdT7ZlApjPoNBZtPX3954l5rfy6XhWhCg7Tn/iIaaHwVQyWjROfXXamDm9fgQNQVRbfj3SA/MSaTFfalOHz/db6s8QWDdX2CFkiXA0xlPGRngMlOrPVfK9yAHJqe3sHg+SQByQd5NnKvAGbmh8MM5+I5CLQlgYTkOCbYoCOas/Hq+xlZz/KsITOMhqLutAIXUn7AP0YvgCHgw0tGQNzrMol3Ww+8/x6UX/J4fwCz5dwFVxZBeUf5C60qoD11j2q+oUJHZ5M5ShTNct+mZEmHFe6LIWh3Toexq6usUt6sugyrRgDbBNqUndz0uySrUGv9vEZ1oi9iDEPmhi3LJKpckN5rvcpGRn6L4tVCsUdtvWDxEjWR+LcYyKz628ZK2LM3Lps612SnaIVfkcDwo6Kc93+sk2u60roinF1a5O3TggtNpdZbmdM6N8QNK4iX6HTLESLl8XGQ0/ZWozj84k4Z8X8X44PnCsfCOAkEO60xw6X6npB9f6DLzw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4859463b-039c-467f-fad2-08d854de6e0c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 16:35:58.3969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELakuzlL6E7nnyPMLinBd5+sSLjO0Rr8PwfdtEqefocl68wMrU479r5ZwUFvj5LW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2582
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599669362; bh=5xPXOYy1PzkCR8P6SPzim2QxerqN5BRox8t6/RMzuZ8=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=MVe1QclcmIumQ+q5rGDFYsWrCj9H6Qm2Oo3jT6WIkm6ILAddZ9wzlDmUcDv1KC6MN
         r4E5PJ5ng/m4/9/RdUEYUDtZyH2Z2T8wsj2Zek0ZcVZ9K8YLdTkYigeFMKOP70ECnH
         sVpc2NN2Q7vbmTSsD/X09wY6789VfsLnoe9qQVZT2rC2hQIb84FOcsEJom3R6Vr4qO
         LEIA+UfUaoo6raCA9Uic0FBTKyyr+8fp6fcmaRZ5Qw6AP5hwLFvhNnljhA29aOv1fo
         1gUA1Y734ErGxs0CWf4dglXyotvkJYSLo6gPiI9101tgIb9V2WTdkZC2TqlvvfXYfN
         F9Sj2IiEcL40g==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 07, 2020 at 04:01:06PM +0530, Md Haris Iqbal wrote:
> The rnbd_server module's communication manager (cm) initialization depends
> on the registration of the "network namespace subsystem" of the RDMA CM
> agent module. As such, when the kernel is configured to load the
> rnbd_server and the RDMA cma module during initialization; and if the
> rnbd_server module is initialized before RDMA cma module, a null ptr
> dereference occurs during the RDMA bind operation.
> 
> Call trace below,
> 
> [    1.904782] Call Trace:
> [    1.904782]  ? xas_load+0xd/0x80
> [    1.904782]  xa_load+0x47/0x80
> [    1.904782]  cma_ps_find+0x44/0x70
> [    1.904782]  rdma_bind_addr+0x782/0x8b0
> [    1.904782]  ? get_random_bytes+0x35/0x40
> [    1.904782]  rtrs_srv_cm_init+0x50/0x80
> [    1.904782]  rtrs_srv_open+0x102/0x180
> [    1.904782]  ? rnbd_client_init+0x6e/0x6e
> [    1.904782]  rnbd_srv_init_module+0x34/0x84
> [    1.904782]  ? rnbd_client_init+0x6e/0x6e
> [    1.904782]  do_one_initcall+0x4a/0x200
> [    1.904782]  kernel_init_freeable+0x1f1/0x26e
> [    1.904782]  ? rest_init+0xb0/0xb0
> [    1.904782]  kernel_init+0xe/0x100
> [    1.904782]  ret_from_fork+0x22/0x30
> [    1.904782] Modules linked in:
> [    1.904782] CR2: 0000000000000015
> [    1.904782] ---[ end trace c42df88d6c7b0a48 ]---
> 
> All this happens cause the cm init is in the call chain of the module init,
> which is not a preferred practice.
> 
> So remove the call to rdma_create_id() from the module init call chain.
> Instead register rtrs-srv as an ib client, which makes sure that the
> rdma_create_id() is called only when an ib device is added.
> 
> Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> Change in v4:
> 	Add mutex lock to prevent the add/remove of ib device from racing
> Change in v3:
> 	Remove RDMA init error check while rtrs server open
> 	Remove -1 assignment for ib_dev_count on RDMA init error
> Change in v2:
>         Use only single variable to track number of IB devices and failure
>         Change according to kernel coding style
> 
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 77 +++++++++++++++++++++++++-
>  drivers/infiniband/ulp/rtrs/rtrs-srv.h |  7 +++
>  2 files changed, 81 insertions(+), 3 deletions(-)

Applied to for-next with Leon's remark

Thanks,
Jason
