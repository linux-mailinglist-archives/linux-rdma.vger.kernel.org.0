Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694B9630858
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Nov 2022 02:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiKSBW5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Nov 2022 20:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiKSBWk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Nov 2022 20:22:40 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BB22EE;
        Fri, 18 Nov 2022 16:23:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ur8Twm3LepJ/UmI+pntTxfJ81i0j1Cclf/T1j7qzfR+4IxkC0dXOCV1WYhmwwRMzz40wCGcHn4OSacEYEa4rfx5+UiM6Z6i391Y2X9+SIKXJFX55e6QOhLGLVxzKIwfGuxX5rXCr4nCV3pGr3F+0iiWeciUptD7tOKB1JvbpTsJ+miCXM+4M98t8n9iiFGDG4noxWYenKc/DGKhXDo0GbEcx4nXzpoN2BjAsGBjaJrM2KdV1ty+YeR/OZ64gV34YF8Fl1bjIoFj25auiofyt22yYuVCUzN/mPThyRJdQRbo2AEc8JPQvEjS2PWpjfCqaEodffQNn2BAgHkCfmi+IcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCaAwhkZVHM4knu+5z2xZNv5M9penT1/jyiv4vlLkXQ=;
 b=Yr4Kk7KTt1AzirZSlbr0NBjTgh3lfCrmTw4hcXMOVuxZK8MoCjIefjcvZnRE0X8gAeygNn/Bhl2lkFooot37tLggwj9lWvvtzbtfz3GwOBZluLRlNnv+ximZ/HUqjE877P6+MWtpJ6JHoAoj+ouN8tnRT7mesJYxVKKvoXDk0oPj3tmDjMoauH5b8QWoPGAPeE7pCCvS12SFm8ePlr8Dh/A92d/V+/gbJu0xXUNCoc39H+yjr1HgpcEgoMfdl2dLoWHFE7LAHOAIKQ3vDGCtTgs4OienHjctQt40K+y39bXjA3rrBpmnyAGlcamY4PZPYyIdZKkFHIYJXwZFhwTBvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCaAwhkZVHM4knu+5z2xZNv5M9penT1/jyiv4vlLkXQ=;
 b=tnUQFwcLrYkYnCUC0wXzdQTSoO98F+MlfFqdzhXIcJNtTqutPCCNmmoru5CrIwihdFhv6uGF8n9x9d7YrIGeba1mtBr5zLNmjMcH4sIr1zjJjFfjEvR9JwXnp9bJi+swd5WtvB/5U+Za71Xbwqo+dJOhpm2EtN4rb4WWbuLfNrkLkVqaNgIAzfZtaPG8QlUJJdwvm5pLbN1QEB2T/7nc5dPXo1bgSislYOerO5YwFBjtHANG05LPR6NywJ+F8xlY5tWUX7nT6B6Y4D1Gt5ByghoZ2sc+75RlIzL2lI4eD7zJdn2pYwrNUkcMJi5GzcQz4TUxUPJ761rWLgx5cO4v2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CO6PR12MB5395.namprd12.prod.outlook.com (2603:10b6:303:13a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Sat, 19 Nov
 2022 00:23:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Sat, 19 Nov 2022
 00:23:22 +0000
Date:   Fri, 18 Nov 2022 20:23:21 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Haoyue Xu <xuhaoyue1@hisilicon.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 for-rc 0/2] Fix sge_num bug
Message-ID: <Y3gh+am3+KRMzbMk@nvidia.com>
References: <20221108133847.2304539-1-xuhaoyue1@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108133847.2304539-1-xuhaoyue1@hisilicon.com>
X-ClientProxiedBy: MN2PR10CA0026.namprd10.prod.outlook.com
 (2603:10b6:208:120::39) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CO6PR12MB5395:EE_
X-MS-Office365-Filtering-Correlation-Id: 873d4fd0-a76c-439f-984f-08dac9c44472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BP4KsyMyp6TjFf8sJLUZ8490x2QYrm3Rxq2KZ3t7WIgU8q18m3mbVIWkBVLjSy7bjSGQLIZhvw0DK7ZWyDl9IIyy/bLXeDdk/PGh4wOzYVZLVCes6mzwwvsszWLuDztU4GpAfvACpjJzfudZisCyglz8BEeDGrKwFf8/9A+IL4Y7w3Pw/wAK8uVHztBu8U6Rk0zCFRHAveNc6onfEDxLTy34vHHn1xxqNkuBr2CtX9whk2hEwDJlHNJJZPGGYmJApjPQhC7SsL1eJHKvl01WVGygLwGvFzmGChM+zqxcXcrBhJvNa5YXVNxeixVIlfrPeN4ZqvhHPAcbgmOxJsgsIG1EiQ4RWG4uPTbVjUytSnoyUbnUg7VDV1bswrxNsbTCDO3XuoktzVKvBlC0wIF/8On1oWS9OAicWmxaX7RMwZpPkX3wFQuShHgvZ2jatQbowQL7xU7yNDNEfoLqeSgouuzVGUHScn48vW6DiFHD29JTenN75P7FXPdoud5MgD1TAjSEAhPj/qy9whxH0Fs/myVYraztOOVUh/zKwb3PHkdfqlT//JOdKRF5DLLuMagnAd2KgtDiRLt13DpdpdQGnsyNWnj/Puln9Pe59WAXbIc5g81yOh/FPtripoquNm8I3xVC7kc+ha2JVqa41IBbehGzFW/sQ9CuyjSPvAa10K3mdnga99OFchIN+cqASM6WBpjqiIJpzx/HguUUlplVmdED/908VzfVZiovQ+q5BxY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199015)(36756003)(83380400001)(86362001)(38100700002)(26005)(2906002)(6512007)(186003)(2616005)(966005)(6486002)(6506007)(478600001)(66556008)(41300700001)(8936002)(4744005)(316002)(66476007)(4326008)(8676002)(6916009)(5660300002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PE+6VCn8D9Srv8tGkdSXX+ZWkArX3DSmFvU68EuajyI1QY8FAAPtEYTGBGQ9?=
 =?us-ascii?Q?xolfhN69E+s/10debWNnT8Wt2gv24evucVDyAOTpvKeKSG15ERri75eywzji?=
 =?us-ascii?Q?9F4Rg5p9WYmSxy5kwn9oAeQY4btKagbk7FkzcMS+AECbSr105EusDNFYBcov?=
 =?us-ascii?Q?EIoL8dvoqIsl20z8KrW+hg1usRujnxHQqs4joK2ulTKIl9SRodb+j2CriYzg?=
 =?us-ascii?Q?bYTM8c4lTcW2kW5+HlaaCvSvDt1NqI1O7jP8BaobV4+5vQHlNj7s3fHHgDpv?=
 =?us-ascii?Q?2SkDLJGLQd/3ZGrDlsG0O9bna3l9lBzuJunGuwfKEY5SHchvQcr5XcfFhPEJ?=
 =?us-ascii?Q?IkHI4nW45jyToElEEpRymVT9L/IRE4mxGhYGAGKI70umvY1TsMgdr0oLB+iU?=
 =?us-ascii?Q?gU+br2+MOly0uso7tonZnSuBVAcKtKxKaFKjD4O2da8jTTEdxvJMLc5/FXHJ?=
 =?us-ascii?Q?gPTUfWxq1t6FebU/Vbgl1XY2W3mahWPHX+ciy5Y12iU6h8fByZdmtfWPq2pL?=
 =?us-ascii?Q?SfMywpjYsoxdLA2cQ8Ib2z1sI7vHqlWyhON1F50mmqQUhCyYFwJyTeb+XtK3?=
 =?us-ascii?Q?pgq2jbxb0C+WtwCmpTRxVQSfW+GL0IN26VkrwCfQACjMB6Pq84S8pamPlw5W?=
 =?us-ascii?Q?6MVhIoTwS890KyphVLLG0xKdeLTROJv4vrme1t5BOH6D17oJkA4yoHDY1N61?=
 =?us-ascii?Q?qFO7ZPfUH3+qnUNAR3ZueMqvcX/3Dd6AquRa35U2umkJ/VaY4uLlDBnNPjKd?=
 =?us-ascii?Q?rExZY+2mD3O/GNUa9Fp3U9YnboDLO7EfG13u6NZRiAtTXwgB/LzuzDOk2b5B?=
 =?us-ascii?Q?DNm3YrU5DwpAEbE1bJzvG3t4zlyrWPcC5y1PIAwVeRcih1XQ4DSuHrM54jZJ?=
 =?us-ascii?Q?5FYwueQOCwMAwzCiGNPtx/9Ri2yLsbErprhchGxNJS861VkGO2AezsJhsC4i?=
 =?us-ascii?Q?6ndJUCX29XvCT+fCINjx4Dky4w3HDgYTARj6gPcLh50FAt/NlYLDTNomKZMx?=
 =?us-ascii?Q?gQON7Sj8lNqjGmeplDl2VGxzNUqAZHdYRQlP2viFdycke5GwUui1S228etIj?=
 =?us-ascii?Q?KoJq87RN2ZcnnDvIYGCVccGWzR7bxmTpJ2DEr5y+My1uf/BDkQDL8d2U7vgD?=
 =?us-ascii?Q?Zw8XXfkz9UM0ByYeIyS7sIHzgVtZvXv0A+XgPLjutBrJqUTGYO0OEs6+VsXw?=
 =?us-ascii?Q?Mzk0EOVMNHWpyhy9EX94jauC740ZP8PUov650IA0qgNo51y4zbyymA8i4Gue?=
 =?us-ascii?Q?rO4dJGVDoSwQyho5BklRR3eVDeccz5D/DYMq0j37atKTmP/YCJZSN+JGkmhg?=
 =?us-ascii?Q?vHq3ENarg7oKS+wifHmbkN7d+yd5opsFjpiJZLYhHPpEtp/YjDxQjVjcB040?=
 =?us-ascii?Q?Gc4q6IQH1uRH9lHNwwBlE6FQBm1siqQmjPd9VYufNruXzXSbY6RMOW8zvMYS?=
 =?us-ascii?Q?RLXCypgJhXhXTTQFYU0wz6vurwN8s99ZPF/Tr0fC4Y+KMqdNsXkpf9WxFCnM?=
 =?us-ascii?Q?HnC/hhvuTKmyl2USEojDzy4v3DF35Dr3B3kzp4uqJn5gW3pDiqqHSbAEYwkU?=
 =?us-ascii?Q?PTFIVwsmx7IJ+n9fFEY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 873d4fd0-a76c-439f-984f-08dac9c44472
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2022 00:23:22.6573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/tLYhRqW+/wLpZGMGQgLYjZmKWLyCFOlw1o9Z7O8QUtSsSpKI/XcmFZ5V4TCGi/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5395
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 08, 2022 at 09:38:45PM +0800, Haoyue Xu wrote:
> The patchset mainly fixes the sge_num bug relates to sq_inline.
> 
> Changes since v2:
> 1. Move the refactor rq_inline and new CQE inline patches to go 
> into for-next after this bugfix apply.
> 2. Change the commit message to better explain the bug.
> V2 Link: https://patchwork.kernel.org/project/linux-rdma/cover/20221026095054.2384620-1-xuhaoyue1@hisilicon.com/
> 
> Luoyouming (2):
>   RDMA/hns: Fix ext_sge num error when post send
>   RDMA/hns: Fix the problem of sge nums

It is still not clear what the bugs are from the commit messages, and
the second is a bit big, so I put this in for-next

Thanks,
Jason
