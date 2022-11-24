Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7D8637F7F
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Nov 2022 20:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiKXTQJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Nov 2022 14:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiKXTQI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Nov 2022 14:16:08 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341B68757C
        for <linux-rdma@vger.kernel.org>; Thu, 24 Nov 2022 11:16:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhYSFsBu8o8Gda9wtC3BM9sFI88Ms+vzYF/swplmhiKzpdgDAeVK6g2SC9RTsv8E0g/gCQeDisEX4ZY7uGldUpilZ50cyVaE+KOxG26w/v+7cVPT9SIObonIZZVdayzyhSYlHncvnIS8ZlGppu3vBgd3l+R1rTNe6UqAkI6riJTUh6JFQa+Wpp1oZmT7mJMa7ShOjcqMvRMApyh+ptqRCLW+II5Ua6jM3+h9XKRhSnugB6JHdj0qB0qJcv4U7N2RGtbHxOw6qS1Vii+cjVAk1lsHhxAngm4YbjLobctrFPtw4gV9gn6CqKzD//EsMZZiV4qoXSPJOCXIZKku2GxQ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcepuPbf87hMKUuqH8qlZIOXTb4+pcv6yQecsN9HB9c=;
 b=hjGYr5WXqt1bSXwvy9Infiq/6VC0wLRpl57xJ/htWgt7oLjailYHI7EMlESgijDPJGP+/GeOugQPsD37hXJQ+OgMeGAjXfD2HC4DT+dxiNLNGNZr5BeQEE6CI/rP/Oc74/bR3WsjkOVrzqPsR6ObQoPvzelyPhq9Dz3K39gzFCGd+E4oSF8apE98wuHC08m8UwO/Wlnucul7Ottat1nbSvLzBXw6qC9Y1sgDFk+xZljpRokzbPP0Y3x3MZRTTDRlKfnrtSMHQ2nf9pYKeo1Cu2Qf4uGH8uT5hYPkmGgONTtuBDa5gJZjkVjp8Mlqwlcz++cXbQ2f7IZCvCLaT5fvCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcepuPbf87hMKUuqH8qlZIOXTb4+pcv6yQecsN9HB9c=;
 b=Citn7OljH8vkBz2t9YiocvhMeOWVcwubMXyEThz6gchu0OOTw4JLi8H+FsZh1+Jwg9yaqJG6/163sMFzslf/QvqToETtobkVfzFwp4yo9HhA768qUNnp1AXMjkahDVAqAty+IyPhgs/lDoRGrQTYiH6nkWwLXa++bSikRS/fCBrb8Ric8IiFtt9dHg8F18Ei89Wssf23AyWM3XDy+2duvfKHJTBuzSLjEadtr747SbMyuPqcEskQZvV9soYkDmw3E40h6UTomwZWMxdk2lm+bk1FE2PrmPf1NOXOGii8OatBEK5QJ/AGtb/mTI9zhYOl/bN9onbeK6WqAIWCvx6a0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB6487.namprd12.prod.outlook.com (2603:10b6:8:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 19:16:06 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5834.015; Thu, 24 Nov 2022
 19:16:06 +0000
Date:   Thu, 24 Nov 2022 15:16:05 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2 09/18] RDMA/rxe: Add routine to compute
 number of frags for dma
Message-ID: <Y3/C9WADcXJumcTo@nvidia.com>
References: <20221031202805.19138-1-rpearsonhpe@gmail.com>
 <20221031202805.19138-9-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031202805.19138-9-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL1P223CA0010.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: f74b149a-89e6-458d-c2cc-08dace505651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9xw3iSpcLV/NVN6XnqKyTDiB7bhDOo+QrXD1rmi9SFrmGh2eo00yKq6K1VKqjnCt4cV5Disk4E1PlEutn2KySxcYwsnbYng1Oy6vVrnrkuqNPob5M1wZebRPH274ZRHfgS9SXTco6PT8QMEGncdl9Gj7euvZ/kMVHhwwMfjnkHVkPL/Xu7fZ3BYFxBg4nTTNVnCo2bCLtjwmhYlgcv9HUaZf6R2we9qaLUV8v8qoHTiuVXhYZdzG0b/2P8rPt4lEvrsoCZcgqpCIfaUa7xI8qS0HTS93AvV9yOWr3LE74wJrHRrBmOCdME44LLA8/d8v7xtyBmiyC0PSdNRGjy1JkHY1+ODuHEY8IjahS1PctcMH1TN4/192ILiQ3qDLA0I866XFbkVlb0rBhS0YPHFXJIaO9B2Aibmfm6KaYTOKu1EdDgTKAzyiBX+7Wu9tJjZw3FPLMk5iBKY1Myi3N3d0bNaoG9stj7XmSbu6BTdPen0OBJnpgj91xryvhFAJcLBhQMtwELz5x1/KqgFC/E3lZedhifPo4r6+iz4bJl5WHW/hGTqf/FPqRIzmvqeVGI85hjCi00/gVKM5A9Zm1y+YbTZx3vFBlkI0OC/CRtaK3V4kHRtNhI2qN4/De9v3g8tQDkx63khXyDE/lgFF4PZ85g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(451199015)(6486002)(5660300002)(8936002)(478600001)(4744005)(6512007)(316002)(66476007)(26005)(6916009)(66946007)(6506007)(36756003)(41300700001)(186003)(86362001)(2616005)(4326008)(8676002)(66556008)(2906002)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CIUu++fsPc1NZj6zEdoONjosMPMZSqHMMUVXISlaukDxVH2jR3WFMlMx2BQN?=
 =?us-ascii?Q?lUacupiMCvxjRZZtWR7a74u4FDPsPOxXFKHtbO7L5oDyOgRTQxdUNeWfr8t3?=
 =?us-ascii?Q?X0u/7+hwBa+L7nrKXUos8MJKOwwFH8+jbWpPPWGE8MsHfQEtS2PBEBZ5MKvF?=
 =?us-ascii?Q?bLSpZkJMm0e//d/y5mJW70DS38DsSIYgZhXdFbxXoxyVPfi0gYgl8O1BNAmr?=
 =?us-ascii?Q?Rnlk9C82iy+uD8jwEp8WJOi+S9HyYV0dOsJVtovUePgAN+UC6ICvXhPzDfcx?=
 =?us-ascii?Q?+Yf+3ryH5q52wA6ESs54bKRo9iYb1sbCzHjqBIJIvhBwC6jd9DhL+X/+wt8V?=
 =?us-ascii?Q?9YQmBhDbdOYTeILRXp0zTDjIg8hIPrxMZSb8omm7wboZCW5QLyREH4ED5BX9?=
 =?us-ascii?Q?xHCtnrDLdNWG8Ojd3FNbUo2RMqLM5zYxSBFuGC2x/A5D2iKnvLx//d2HrWRW?=
 =?us-ascii?Q?Td8Mi4HYQYFQmfHu//jo0muCHTN3emShUX47qmd2GCBMfjH/6VByER/6w1pY?=
 =?us-ascii?Q?p4Rpx8JccoGMtm234KOEsonllhenwOFuxfBGVZ0/NXzdfTVRr2d9XS+cYI/+?=
 =?us-ascii?Q?moAGMezHRKg/g62+mR/hbX6bhXgIbGx76Zcl3kTkfGbReV3y1BcdOLX5lQKS?=
 =?us-ascii?Q?CPp9m+cz5xbk+rEE2kfVNq4cVOQ8XmwHRLJrhD5wKMcsNaWYgiecWLVWQwaL?=
 =?us-ascii?Q?fAhOugeVqXWGaXNcSJq20KWhTqKd+7Gq2DmreS3/vX6HVNA5BZPxlZKF/fCs?=
 =?us-ascii?Q?0t3Lpz9ZpWQQmGv0kq0O1agjiTLsbSIfebSEsiK6TYk7HT8Oj4Pmksi66PAe?=
 =?us-ascii?Q?2AKk2myMycUys3CPAsRK1XLJ5uddA3ibL1UXdk2oywdUf9a1xH0KOZdyzKjr?=
 =?us-ascii?Q?fi0COTzt9hOzO2/Pv41ZblpTF3gfLXxPrGbGapxAswCr2On/xamvhLc8rQC6?=
 =?us-ascii?Q?64RztD6NoBte3A+9GtzLXjrv+E/aUumjuu5XMuvTbU1V8/cFQFHmkuTylsOG?=
 =?us-ascii?Q?IxvH86ABw5b3BXoNIhU9zwme3fsTqtIkuAR0y2L1IhI29TDsA2Oza77Aampk?=
 =?us-ascii?Q?OATdFKjjzUHaYIKL/O/TkDHh4+qHaHgkDq/8mumuQsxzowSWCJNmWYV4Vz+K?=
 =?us-ascii?Q?CBmqNjjKYbhLRy+Sig/n5amDDZirMKdIqjO5s4z4j/soAZgLDzSjBnTB2D0U?=
 =?us-ascii?Q?FvG2SEoujUzOXwU1qIMpODbdISYz3zTalvJaS/p5AgBeCJPiCRU9Mt0p+1Pg?=
 =?us-ascii?Q?4G7Wx69K6DSSIM78dg+5NVxh8/iAVMfas/gqqARra2qSKTcVM6mSr3OdA83g?=
 =?us-ascii?Q?vuoGgV5zaSN+BwifTDv0+obwVsuha+XAaXC4bVW+tfVF30iMrh2Ma3+EGbzo?=
 =?us-ascii?Q?bu6bqxZUE2x8hfU1cQ+bNWSaT6Acecj9zGBipKfykGnSMuAfidtXw653c/WM?=
 =?us-ascii?Q?j1kLj1/6pwniOpxtHhLZWXxi4H/zeSHBPSh0BIMTdE6GkkECzI69YJsVQ1bT?=
 =?us-ascii?Q?rcyHBcdZ5qu4pgCdlWBcUFsyCRnoE7ATs7bsiofNPB71iFUxZQtJYVztNy7o?=
 =?us-ascii?Q?4dfM6kwOtYi0w28+f68=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f74b149a-89e6-458d-c2cc-08dace505651
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 19:16:06.8501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zervAGTYPwiV+6kOy3f5yLqkSR71pcs5sFKCAMAJt9+Pvb36LbtdJ91Y/PpSEMQY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6487
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 31, 2022 at 03:27:58PM -0500, Bob Pearson wrote:
> Add routine named rxe_num_dma_frags() to compute the number of skb
> frags needed to copy length bytes from a dma info struct.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_loc.h |  4 +-
>  drivers/infiniband/sw/rxe/rxe_mr.c  | 67 ++++++++++++++++++++++++++++-
>  2 files changed, 69 insertions(+), 2 deletions(-)

I would say this is a nice place to stop and start a new
series. Adding skb frags to MR memory is a self contained feature.

Jason
