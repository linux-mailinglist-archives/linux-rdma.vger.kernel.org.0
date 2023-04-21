Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D37D6EB498
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Apr 2023 00:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbjDUWUu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Apr 2023 18:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjDUWUs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Apr 2023 18:20:48 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197F89C
        for <linux-rdma@vger.kernel.org>; Fri, 21 Apr 2023 15:20:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZMlZGGyO/jwpy7UThjnoFTUOz1PLWeqf2RcL0vU3N9gRn03U90FHpwi/BuXob+bIgGCOpHP0HNUkcaT0WLoczz2qFFnDAB8Bm9UA56t1dBfXvuE1A/Kde+K6a5RHq0c+uSjcQudRlPXakXv+twRHxCPUNsFllPcCdlFhIzKFkxGJ/2bbWZhN839NMp/LKdKfAsnQxNH6OdYxj35+j7WLrBOs0H+aiiTOdrRrda8boevZFglVf70a5vK4PW/+rVwVHouk3TzDsneiR7aYJEFh7MfIgm4X+GyDkSBomKIFbdVgQG3SqHr3S7kvkhGN1dHt81jAPFXHfRyL8v3yEaifA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+c7CNogm03MDZnn+N2F2nZH5xUbNpNvpLhlodU9xP8=;
 b=iS3NRBu5W4X62dlwqz7BBF0bfDOOd17DTy7wcnFE+l4Lh46LOJzIoe3RHGMmFnrTJ5EJUA7plu4FOmiHUYBvrNL/1IcP0rpKaxCF2VaYpUZcTdSutZjsr3W6PTHxnW2L2MLmVrWDrL7EC7pIC3Xc5ey3eLoCKJwam9zp60iW0Ro9uvf4XPFFb0NqqEuqMPHW2DtKd+5kFRitnB/kFIFJ0XD9XR4Ni0WHiUclFLu06tHNGiQbIirX6jwRtEsS1u51nsj5Ub60u3CNr+Z0pURcFDMlV+RE2e+v87EGaPU0O9CPSTAitOMhKRt0ItbmElGX8C6mbquymTAMCJ/G5zq4lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+c7CNogm03MDZnn+N2F2nZH5xUbNpNvpLhlodU9xP8=;
 b=Vu7ZQFnairsLCTPOXmYGq/R2ZMPCd2aalDKB+GSTYbaGD/V2v18TcBwtUJbtmvUzhBl0AVrmiwIA70m1eaYDODDHwy79XKrfwjgPLK+PV255LqaqcJ1qauvwLjjHpnV1gA5sjipBAkqZMBcKh+sJGa8qWJlDSunFGvyLAyC0nTB5U5a8faJV5joHEZrJrEP0Cf5BxiT7+F310FOAUaET/2LwK+pqZK65nSFYsxmVhNLOw4D++ngUwwFS3IWTjpe1AT7PCfoWmy+HFFlcl9TJfZ49mDYfTIUZfPISfjyfBJ4PX/gz37Dno999ziATjQw0sXKbUaNDWTZWjpBEI/mK7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Fri, 21 Apr
 2023 22:20:44 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6319.020; Fri, 21 Apr 2023
 22:20:44 +0000
Date:   Fri, 21 Apr 2023 19:20:42 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     ynachum@amazon.com
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, sleybo@amazon.com,
        matua@amazon.com, mrgolin@amazon.com,
        Firas Jahjah <firasj@amazon.com>
Subject: Re: [PATCH] RDMA/efa: Add rdma write capability to device caps
Message-ID: <ZEMMOl+xJ1NOq9Np@nvidia.com>
References: <20230404154313.35194-1-ynachum@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404154313.35194-1-ynachum@amazon.com>
X-ClientProxiedBy: BL0PR02CA0068.namprd02.prod.outlook.com
 (2603:10b6:207:3d::45) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6043:EE_
X-MS-Office365-Filtering-Correlation-Id: dc83e9bc-0208-4272-9914-08db42b6a5f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZPbpluecYYL0vBylrUDdRYdZ1kk9b+6KzuSLUm0+SJi08Ckqt1pxe8GRFXwZEQL+hMLsJc84E+TjkAaD3IlCWCeaWEubVxLQMc+90YbV1vsuaE5edSIvw7hDJLoLfucKWLjfVMy/6yqqRTb1LZbon7sNt3hdZkK3q6e0ED37kMNF+MYDGtxtmlT0c+k/YP919zIcR7qjmF9Z7FZmV7nATJlmlPRqZj/NNM11fKVRUbQxDI/ZG2f0wmkNMNVHZ4D4Q7u1HGvHR+THG7w5hi7ZYScxcf0nxqkLjUTe+nC1QGjFQVK6WkWGh678mumKz8Bhgpza6RcALnv+gUAwAZSHSUrMuKgdR3qpmB9bzIHNrkO2jyyQmFaVzCPEy0p/Wxc40FxHNQdV3R6fiOb+ZcySTqyW8gHve84WKNopxIUAbjEV79wyzQGEdsCmEDu0Rm5MeSy12f0PG6ONKcO/P9K7q9Bz4ypP7ljWgYQQqDo6qOgPRp4E+ECwe+cg17o0yIMvJ8I8ZWY7xSMr9VByWG9O+HjbgLfTjsBMtR0/LeGHjA9WKy7DkzySVEbrFCjPS/AqYjTfp/oUCLBLzri4SowQPplX0GTdvH3MdZtv132vamw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(451199021)(2906002)(2616005)(4744005)(478600001)(26005)(86362001)(6506007)(6512007)(6486002)(36756003)(186003)(41300700001)(8936002)(38100700002)(8676002)(4326008)(66946007)(66476007)(83380400001)(6916009)(316002)(66556008)(5660300002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vNuqIMcXp3MRwo9nl/wWMqvEhNpg9Ra6q4EGgfprQGzVXfPBVQ7lOVZbVkYj?=
 =?us-ascii?Q?dtsqq3IN4bmyhFyV7TWETRoZ4k+k9gKdD/phFPL+sdDOQ7ZV7A6GXq1mIcPV?=
 =?us-ascii?Q?mmD0KnDR/W7o8uooQJ7TmqqSe+wePM3smSnTYMOfOkIK/6yr9fRdZL7SGwBR?=
 =?us-ascii?Q?+ejwHaJM8QtSm58dTVA6GMZNvWzXQ17FyLzXgdVVExheNjODQnArDGl2eKe8?=
 =?us-ascii?Q?kgd3ELSN1vOwX2YyXAzkNTpGgi34J33rGQeYV6fEMZqjf91YIED2yZ0D/drr?=
 =?us-ascii?Q?ciUSGGf6nTTltROz83MAI7f8ZFbHD6jQcoh0C+n/zvMxOuXUyPPD2VfExXd/?=
 =?us-ascii?Q?GQavxGo9rhG6x0ohTD/K5DWIOHYGz3KVJYBK5u6vUoxzB7ZmlMFGeBz/FeBe?=
 =?us-ascii?Q?lp7cVM7y6zFWkg1PinL++8ymNmu9pgK8i5dZM+7WLaqpJAO9vwVWwEnc2irD?=
 =?us-ascii?Q?EtgP7xlTRp2x2qFZdd4iD0bqQuNdpmk5I5QVZUF1Dhd3gIZ+sAzIPsb/vS4I?=
 =?us-ascii?Q?JglyXjcBdUkeIPDVmEvgnRST4IDbUsyfABqFtr1P7Y0r5GIFCca4VwyG6lhO?=
 =?us-ascii?Q?tj0EJ+fJEg+eUy4I8TFSa3JuYmo8pLct/7TloEJ0q5o10K9Ph6ePOG1TiWHG?=
 =?us-ascii?Q?rFBZYPDh9MKo1Fwwr7Fbhhpq1PXfj8OSe50aBRC/wSlUVnDI/gkFymBsbxyN?=
 =?us-ascii?Q?Pln7icYMX8KmCs51ANlhomxtdIl+o0Vqo/M6FMKGmD7fIvSQQdXlAgc0TXn3?=
 =?us-ascii?Q?k6VFXFKZSZU4TSK3i1zd0n9lWruRpglAO1DbJrkkrWHJFUUWgTXZoH+wkLQx?=
 =?us-ascii?Q?tnyRGBb+3umHeoXyN3x3X6Q1GAFBWmzCT1Wx8f26SAc54eM588Wy7Ud8Hr1l?=
 =?us-ascii?Q?PLSuUl/ojWqUjl+AHTSdGz2PJCBUD8Oh/hV6lxmttHX3aiPmSNaWUDiO3rC4?=
 =?us-ascii?Q?mlBXKVrBseJPbTW1vqPDFFEVYzDlLywfQOLF5qns4zzZW/CMdt0vpRuEVH/B?=
 =?us-ascii?Q?/BPPUWiFXCM7tDcNaF+cQtonlVkj5E7sklzyBFgwOnJDzU6KagrD83+imZqr?=
 =?us-ascii?Q?foJOJH1V/RV88rcrME3lwYYbvjWRVD8gFcd86xOLYwvw3b4gQBCDJ1LjVipI?=
 =?us-ascii?Q?MPRpVKGXglJnXmM8KrzqyZ7mzZlaxdGWrlAlKLbmFs0ViY/zSDL/yZDSABQK?=
 =?us-ascii?Q?yRgB+MEktlyMHkPN0s7LuC0b9HcgRqsrc0Zq+V7HbPd3Jg+oVUM3wVnB035s?=
 =?us-ascii?Q?M6vrAOGN2BRlFEwSWBgjMkRQ4LJ6YO2QNyUbU1wgWC6fntUJPhgVxZd77HtL?=
 =?us-ascii?Q?FsyLBVX2Khsz0pnTh5H+WqU+GFROsY25Fad7ibeBvRVBnldWzVSyySO5rFCj?=
 =?us-ascii?Q?+oDBEhT5W13pu+2UA6sr+phygWVkH8xA+GUlpZ3KjP5Xg/VT/uXeY6itI02S?=
 =?us-ascii?Q?6LTU6Zm+WtQJ5sNrVv/TOLI/7RBa0+ySbAhnKTcHUQVm1XM2vtYPEFmfN2pq?=
 =?us-ascii?Q?a8vK5Mp6P/CeiWhF9ilyf3UrT3O2OK/lOZGD7Q5nU+utRtngUuoBsHWmBCH9?=
 =?us-ascii?Q?ahDB70WoqtUrGodu7bVxqVlJ+YLSxgYiAsgz6vXn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc83e9bc-0208-4272-9914-08db42b6a5f6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 22:20:44.1224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RDBhcQKjtinn5mjTJhwoyJ4/6k/qfwmJwTyfybA99qXbte2mVt42yZ/+1Ky0w3OO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6043
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 04, 2023 at 03:43:13PM +0000, ynachum@amazon.com wrote:
> From: Yonatan Nachum <ynachum@amazon.com>
> 
> Add rdma write capability that is propagated from the device to
> rdma-core.
> Enable MR creation with remote write permissions according to this
> device capability.
> 
> Reviewed-by: Firas Jahjah <firasj@amazon.com>
> Reviewed-by: Michael Margolin <mrgolin@amazon.com>
> Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
> ---
>  .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 12 ++++--
>  drivers/infiniband/hw/efa/efa_io_defs.h       | 42 +++++++++++++------
>  drivers/infiniband/hw/efa/efa_verbs.c         |  6 ++-
>  include/uapi/rdma/efa-abi.h                   |  1 +
>  4 files changed, 44 insertions(+), 17 deletions(-)

Applied to for-next, thanks

Jason
