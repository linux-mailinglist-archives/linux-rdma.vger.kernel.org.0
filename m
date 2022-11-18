Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8252562FA7D
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Nov 2022 17:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbiKRQle (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Nov 2022 11:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242159AbiKRQlc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Nov 2022 11:41:32 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DDC6C736;
        Fri, 18 Nov 2022 08:41:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FK/IUcw2wNnlawnmjZNAImNfMOpHU9kKdRXCqFZt/YB7gVyjShaEHuzOxBnBBxVV6DXNfweDrcYzvsjbZgAp8po27JwSLFzAyFf9gS3/hiUN6AQltkmTYHeINXr881Fx75M+5KXTxUyrU4SZ0QeMIT4Ypsu98RtZ20dTHkWpKrbmPH/8HJjcOOKoiOr+3xg4qvR6wt5jw10A8kbjonnrU0W/To/dZWnhuxWXTA3iKwO4xhUsWGmPWy3jFVRhMSEiMgfeWk4MOy9QlOj+IdqwWPJlxowyc9cg9aB9qEN5Hk97YtDrgqkHUijrT4xfN3mjw4RAx9Wo0XjV4YdsZTDu0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93Z02d2xldf+UPTa5rJ/5rdBpoU8qvDEvstaBtX4YWE=;
 b=R5tYYJCr6HG/UFPVcfu6JvuM+JXZua39VlXUsdmumaylwi92azRnr0qoUX1Or1o/MApj8y2qEhwMr17WpNTFnGMmPgCVKyKu00lUzkhwLJa05mK3mifiQWPd1f0Gc4qOqGxZ/sA0Uq70YM24t8PaoCKJPqEuF5wCnGpIutWKJ6cidAfoC74zkJ9b+xRY+sFUBBJBcSOeZUZdty/wbNjH2pz891iOSlLdBVF1//bQAoxarUapp0Xxq7vZ+WdjwMm2a5hcaO6NGLr+ODS9jpHN5WG4CinclrUadZEDsiOxYVaLhaBK9CUn2c3SfjiaGrC7NY/A1XQcUoUQtdjymNd5Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93Z02d2xldf+UPTa5rJ/5rdBpoU8qvDEvstaBtX4YWE=;
 b=hkc6jCrGhWpDIZCGq7celJd7ql2ch+mPW9Nc8J9txqwfeJhE1WrePb1/RMIP9VxsYoN/U/jJTMGxTRKWCFqy7D/swEtPnM0ObDMGMFMZwQ7mX/LhvTugscKoHpP/kKmfGZoeRtGbbD2sX6TzR5eJXbp/TaObNSr5larKqjDuVG0dSXPVrABjLg9dDUloyKtykSaw59jsq6qsnnuc6cPsZSjueC7oAKPrP9DYvRxq+jC74K3MiiSJUoJGIwg8hyTDc6CYd9+G7ZxKeWhSAYUBJCnduqylOBU+qwvbecadR5stIpkpCruaA6pIIhuiSmgecAvj7lIAB1oTTaLWEsHirw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB5140.namprd12.prod.outlook.com (2603:10b6:610:bf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Fri, 18 Nov
 2022 16:41:27 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Fri, 18 Nov 2022
 16:41:27 +0000
Date:   Fri, 18 Nov 2022 12:41:26 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [for-next PATCH 2/5] RDMA/rxe: use iova_to_vaddr to transform
 iova for rxe_mr_copy
Message-ID: <Y3e1tsbskwijGZA7@nvidia.com>
References: <1668141030-2-1-git-send-email-lizhijian@fujitsu.com>
 <1668141030-2-3-git-send-email-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1668141030-2-3-git-send-email-lizhijian@fujitsu.com>
X-ClientProxiedBy: MN2PR19CA0034.namprd19.prod.outlook.com
 (2603:10b6:208:178::47) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB5140:EE_
X-MS-Office365-Filtering-Correlation-Id: 433c558b-bc19-4407-61e6-08dac983bca7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FnO0Ubb8NBzKRg11pvig49CooTP2Y1GbSQrYSAV2xpMDcColcVTBO+kttMNQI1mwJWYpked0UtBuYT9/vy9u9K+sFWoaCf7YMZRmBYKc2X3gjoaBOCc9bSYJO30LIqnq1qMOV3KPVoiAaHGvU00zR2fMz71h8WpTvXjIl414mBuSLWNaE8jFvPxe9XL/kZJ3R4RQM5odqgZvO2Vk4W8J5vnkoxDONz9fM09ovHKZSdY2U2yGz5WGYblLHklhH7Dsj/lSrKJFXGXK/FSXHHiw/BIAOiw36AUb1NhDbl4BdVJRzajuu2teH6SkkGXu081q6ZzTYCpCCBeZ4W0E0cU8JF13sWY/o8b6HQJy33rafzDXtdVv8rxC5fDV3HBToho36BHyAPPsz3y8K5bav60y/G7yo8aVoWTict7Sps9XDHRmSinx2PHUx+pB9unDVQoztylQD71WVqDqmSpMat11wHiZA9pUfdzOuxEr7oCsyFKiWS7rKBUxwoENYT7cS4j7QFFXkNDBNLxGBG78F5FjyX1pLCuMM2CZuvDLtPW4kAaT+2w4SOblO2XQN2mvkOP/nxXJvgkR78ud9m/iynQKHZg/1f8JoflJOVi1fbwO2mWp0lqcACmfKZ0XjUH5WxO2AfzFy3bhZtwbf/aBZoqkGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199015)(5660300002)(186003)(8936002)(36756003)(6486002)(6506007)(54906003)(6916009)(316002)(4326008)(26005)(8676002)(6512007)(66476007)(66946007)(66556008)(41300700001)(86362001)(2616005)(2906002)(478600001)(4744005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lNOTL8eN95ggwIOPdyjO4GCO1rlpQHqjp9dRUkbiOYTv9RWPQ2iNm2KFo7Su?=
 =?us-ascii?Q?YVBb0/pWj0gk/ZIhXJMUGhiklSXBzi8RmXZPCSmYPG/R8DnCz/uVzJIpRfYk?=
 =?us-ascii?Q?cXYJ85az32DBkK9hWWExsterU5famiLG+atG1ckSFz6kqGUIyuDKE64n4G9f?=
 =?us-ascii?Q?O9w1FnmXeBLK6HUYdUfEHcceScG7+F2Xq20VMkmuNspvMyjZH05QpG79+1m0?=
 =?us-ascii?Q?a+Cx2nmAiA60INnY9uZf+lqsyXvi203v+DLEmw3ntqyLDVDQJzqNwLZSXrur?=
 =?us-ascii?Q?/s2FoUQouVpJsM6GkPeqVrZ5OuWEFR5aDPpuAZ0IgY+VTVrevUtSE/t5CpI7?=
 =?us-ascii?Q?cIV94LAp9VQZwE9/sL31LYSqxgIG25qVLHz/Sf2iAggLw0hUqW67jX0oayEL?=
 =?us-ascii?Q?pUYfaCmD/79EJ9cz3M5UvEgCiOaZfNx1O0A+XxM/VJyfvxay7xtodbPj4OhF?=
 =?us-ascii?Q?mmBDkCBC/FDbVrMh86IVcNh4b/vKieCIpdIjDJXRFQu3ZxPXnUA+axWIyK+f?=
 =?us-ascii?Q?perl5hVpH0fYI4D+NOHt39JRi7G3AqhiGIE5Q8ITHjyY03Zzw5cwjhso114C?=
 =?us-ascii?Q?0dO+ricl75KxbRaSoVUntlfKE8RZRcoEYh/nAuaRO+gQixmJ/JPJ0NGJvPa5?=
 =?us-ascii?Q?DNzLTRklA3djuB2z+mAjGypqVWCBmlq4PX/CuiZys0v4ru82WASIxG/XYr+B?=
 =?us-ascii?Q?vFuO5GZ+XSdEOx/h/K/41yuJzx1yAXYQG6kj6/4t9j3aiKvoiCMXPjfZiiY3?=
 =?us-ascii?Q?fIt+D1sWfsS6kdOSLYs4rivxIvseZSiwXmyfbB7qVHXyAX4GfBvGpLVqAdAn?=
 =?us-ascii?Q?jXO0adCq3SD04lNbwV6rgCHTAiVMOzjG7h09xolY0xSvIDg3CFo9cH5df3W9?=
 =?us-ascii?Q?vU0QNyUPIdylrN5btxz/pUsXkL7aQCFyqIi7hddoTfqYLVBKU2sDvSg5W39/?=
 =?us-ascii?Q?2jZYTzsOSsvGwjg260MTA1lmNNqyjkFpQuXZBXaTUr8xdNXzev2XPb4ucesH?=
 =?us-ascii?Q?9C4yZuP5U3BnntNK0zV8mblYvUWyYMoxZEaN+6wYg0qNdRWHm1cAw8xVPzOd?=
 =?us-ascii?Q?BvSAUVtJXqoGfwBZ7LNAdw7AO81OMRe3S2NGafjKdYM+vJTRdVVI2yYhgejE?=
 =?us-ascii?Q?i4saRh2qJGL3UgL4puwAL6I5YtHhWvNUo6aS4fz0hdV0ycK/9906/dRuYSTU?=
 =?us-ascii?Q?eSk7hJdgVsrL3nyJI7aaXyfRIy04bYpYYRAhugkgh28hTF7XFIK4h3Im5oZR?=
 =?us-ascii?Q?CGRRZkHCdS2X19OOAic+kHoR+WDSiWHJI8+k3BYwtpLynTsu2mo0v940mNAM?=
 =?us-ascii?Q?qhglY35FZkVvjEtFlMBXP3lJvYzuHXhLz84Nm6QZY/fNqganvNajQX78gHMn?=
 =?us-ascii?Q?DMuMtMXlv7zHcJfpHSRQIfyIvNdcJgHm1x1zii1y7RlvESXBmQ6IamxrcBtd?=
 =?us-ascii?Q?BA8QtPtvr3FznMSv5DWJA2Ge/uIOCpxb20FM43DkM70U7n+07At4s+zECxar?=
 =?us-ascii?Q?aVZjekYbF7f+aXLnelRSrINRv1lceZw3lhXStZxzUJnvqpsewd4OHKeUIbWr?=
 =?us-ascii?Q?NWgi6MPDDvdgZL2Tb6M=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 433c558b-bc19-4407-61e6-08dac983bca7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 16:41:27.1206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7CivUY758VCqRH9gpyZjLU/HrsQFmZs98HDcLbDI3EHWwslv4CV0TXdmYHOAFktt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5140
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 11, 2022 at 04:30:27AM +0000, Li Zhijian wrote:
> Make the code more friendly and readable by using iova_to_vaddr()

But the point of this is to be faster because it knows pages are in a
linear list

As with my previous suggestion, just convert this to an xarray and
then it is a trivial and fast xas_for_each_range() returning struct
pages.

Jason
