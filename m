Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF9451FC81
	for <lists+linux-rdma@lfdr.de>; Mon,  9 May 2022 14:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbiEIMVr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 May 2022 08:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbiEIMVo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 May 2022 08:21:44 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CB7240AF
        for <linux-rdma@vger.kernel.org>; Mon,  9 May 2022 05:17:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVUvN5+5yMUqkofWRAg563Tm275JVXziWYQrydRa5Kb3SKkUaEItXgkPpkLz0ClKAifm+N3RCHxyhAhPwiM0bVRUo7Cu48ViBO/mW22Wm5ZP27yXxlxqwrYH1ewYaN0W4db2K+Xtoj5l14eqfIazxLxIrHTbg3AmhSd8kVV5GGE4h5Xg9F9asfHsdaxcyxXKDVLiSBO6puHZiKXtUg4Xo7/p5NPTmqqVLf/XQ/kVzfbA6UMsphKcKJK7ZWfjl2FUU/B/MWbYr34Jh7etLlyYFNBK45DotSE3AIWhzq/lqgrx0iLrlYHvoWT2GSS4WPHgrRoCZTUEBWaxsQx0af+L0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXCiIaS4id5zAOku7t2iqaEdw4rUGO5WB9/ASomTx24=;
 b=HymstINxF9kWDGCr4Tm6UsqxLbeYlwsTBWLkWXzRuRdhmPyHyl3y0312xXFLc/ZiFLVugg7riboOMweLGRmS5UkxUXB0eimeNU7OOVuncuE5vDpr842EHRQLNctT+Rv8ankdTS0QC7ZAMkJH+psrAJ6Ds/eny58ISKIEvw2nmNllXjeKdmJAnGrEebaMQ9DHWIfcNddHfPfnE8d8eZ4O3gwaxgUPy9+wDj1KbSu0P51mqshHk3iLtUCQRMy1hogjjp7EbfgCTpKuXd+CJ3yXa1OHK6JSPtW0SI5nR6gOa+EDtwKclZHhIpn6Hs8dqE2WMy6wr1ps8TxRlPbitPoJoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXCiIaS4id5zAOku7t2iqaEdw4rUGO5WB9/ASomTx24=;
 b=qNDC5CFTKQsmo6tpJexkdYQ9ny6qCQePxZf68TSd2VUuHfhDYVe3ggkOSPx3QpCA9Od8NH3uuAHIbOOuc9W7qg2M+WzxXrWItbV+zgLrhUX77gMIK5lvO32PVIJvMx90ZFqljLBkx6ce8+sGaOqaJhd4d7UwIFVCx2HYlDJw3+98t7PxYQyA3xRfd+g/0RpSBSWV84xvrl8RPaMcwWxFAfnqHqb3KucS20KrKzVJXbQTBxXfjimRocULPM4SEqBLwru58y8gNhLMHTxwHbV4h7TmnaeqUs0/iT4stz+CeyE9Hg6WYHMOdGWuLbupyYiHBsALBOj/m2UxS/Zj9VmEZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB3468.namprd12.prod.outlook.com (2603:10b6:5:38::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 12:17:46 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 12:17:46 +0000
Date:   Mon, 9 May 2022 09:17:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v14 10/10] RDMA/rxe: Cleanup rxe_pool.c
Message-ID: <20220509121744.GA844501@nvidia.com>
References: <20220421014042.26985-1-rpearsonhpe@gmail.com>
 <20220421014042.26985-11-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421014042.26985-11-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR20CA0054.namprd20.prod.outlook.com
 (2603:10b6:208:235::23) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17a909ee-132d-4ca8-fb23-08da31b5ecc8
X-MS-TrafficTypeDiagnostic: DM6PR12MB3468:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB34681D5E37EB0265904A4D83C2C69@DM6PR12MB3468.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +MC6TQleeliNnz4rWfxREnme3tV6TP9YQWcLBAzhoYkcjmw2hKx80O9M0h4iiNWqLArfceOwYHBM/+0NlZUcI38dP0rHYUwGTcjCJkmH9JPgg2mMnC9Zff1mzXY6ozVVEBxqaS7sUmxkQMRzYmXfo1Csu50YmOkUePsKG3YE4N8RXc2YX6p+oO0kaFxAdXbWVTtttmCyENPlsk/cHQgi/U7VvL48IzffRqsQZy953XGhd++KxjGiw8zo0lYFXvjm8BJDIqQxafckx0wRbG1/l2Xp6t4V4Bk/LUZg90Da1NvxLfcIU2YsC8TQhnCiyQMFPS5ozJs+/lm5mqBHkU3UYjybI2anU18YOrglPZfz3/zrlXjU3cs3btGUbPnFZQOm3iziqnKjzXaof/yh1oHGjjF+WmZXJyTkY84b59aFgimfxOtzFA7Eg7+baBmgkbU8VrZtNYc4AM0Z0FIvpMK1Btm9xNZQ05sLD9IgHWlfJLROSIc4YzfBmAOAGQ4LeIgHFL9ZuwsYVu4EdP3h6K+N8O8mrTe1rpLREZfYkXkq5UUpsU0iv4yAprnXK1TJ8df+Xf8O3mWESes3cDVFpSBlkj3l47vNxFPC+2eDvdTIN516Q2rgefrGlnyL86dkycZZ6g44Sql4/tTcOPhwGgYua6MgxItfOsehMX5PHodmS63ONxqqJa0+5tOwiyYABPNnti/+WlUVcLRKFb0zd3tWhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(186003)(6512007)(26005)(8936002)(1076003)(8676002)(4326008)(66476007)(66556008)(66946007)(36756003)(5660300002)(33656002)(6916009)(316002)(558084003)(2906002)(38100700002)(6486002)(6506007)(508600001)(86362001)(83380400001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BG5kkwa/3lICWcbC19/KvGt7dHqlFgFItlNGpJed30Pg4epdviyYpaVi0Q72?=
 =?us-ascii?Q?aV46dCLYYXAzBIVmJEW7/+oNPGgXyK0dBhsXSpwJcf9CHkYIgbor843CRy4C?=
 =?us-ascii?Q?3j0IytibIUp5hiD7P2x4ogCl2R/NaZ2cevk0VNGKINvUqP35GteKzRoAp7gL?=
 =?us-ascii?Q?rcPU06vzRpLbkpzDrixhTKwzZpQwWZIJZe/Oy6II8htp8pR0hOkDC7EfiM3l?=
 =?us-ascii?Q?Uu8zUPEfjyc6ezj0KTBNz4SIWxosVCsskRhBPf8gjbuKYnYombhwIbZIQQbS?=
 =?us-ascii?Q?jS2a859aybzwWhBQbDvshnzz/9hxzIbe1ZhnmDEsUBkCY5HYr+HOP2aB0weG?=
 =?us-ascii?Q?apleGECzX5Ht6Xxbv40AtwfuxkX/8BzZ7CDss81hu8oNak0OrOgvBMXiNicO?=
 =?us-ascii?Q?t5bVqfTb8uwfTSaiK5ACIWiWRnRu9TA8Xu1xCdS7Rpc+XkR61TJBI3ngotWd?=
 =?us-ascii?Q?QdePAEYucihU0MLb74RQnJ2jc05eSu66RZX6bPtjX3Vc6wJ+X0bu3SjFHThR?=
 =?us-ascii?Q?ix8KPmF4zO0N/p0Cy55HTOxbGk5uqguJjhD1L2uvqDCcvTcyk3fyjDVUUvhv?=
 =?us-ascii?Q?z4vA4FLT4cxr/vDW1Q97FRjywYK0Zxdjsw+vpOHLCZVT3TGsLvTGIupAN9GC?=
 =?us-ascii?Q?9cYHKpIzEzLuihO5YeDJmtiqjS7zlSw111nxmPxWNa1wpnAVGv2bfXQw3HbQ?=
 =?us-ascii?Q?dM3T+WXup/ZVVT7fNdnIowPlK7zUw7qyrG8ZEGj0Z4iIXGSBEdj5R3QUrYHS?=
 =?us-ascii?Q?hOgTD9UHAqaZ7mIcJHKHcK04+gIHXZ5eB7oNrmx8mCWI0DpW+yyD3ADAT6D7?=
 =?us-ascii?Q?Gpn9PMTj3Dp0CU9hwB2BqwPFVdCPaVbm/sCdE180ASll4zHssYhfZ8A18SkW?=
 =?us-ascii?Q?VyiCxtj0BfEI12dT4YJZlgqKU4ebCxR4NgafYOMwtBrp02CXRxOpztAOPl13?=
 =?us-ascii?Q?hYIz3SM/Y4mrKxdbkMbL7e1udv1fklXW7LiAVuDIESvoMYOWoIu+JPwTPeV+?=
 =?us-ascii?Q?DvJqZtdA1Er9MYUpE1V0orcRoccpZOTLajmfHP/SPRO0BIQkKT9kuX1Dj1ud?=
 =?us-ascii?Q?9fyko9EHuhJj1ubwak8xx7TSmHucWc7dDpvBEZiNIeDoXTxNG8aFuDJJNikb?=
 =?us-ascii?Q?GJt5s61rqelKZWSh+FCnvpZLLXjSn/0pFBxzU7DHYA1FnZAKmtr/HjfCCBOc?=
 =?us-ascii?Q?y5DCOkshRI8U6zqX5P7V7qR7drVHUqWfF1dcciaOiBNZbtWGCF8stNSi45Aj?=
 =?us-ascii?Q?zCnIY6pC2CMZnKykKmsN4TxhLnrQpt0ER3TrBKh/iLyZccAds0t5XIs6XrtD?=
 =?us-ascii?Q?hXZZel4gYFvUY5TsWbTpnyQv37pip2EOcVmg163CietHHYVh/WqGnpwzZIOi?=
 =?us-ascii?Q?xQl/vQEcgL8JVDF+XYrybBmAVuyUD/lD17GGSmhPiMScLn1Hy4FvVP/d4Wge?=
 =?us-ascii?Q?zddeXkTYtG3NccO6ZlTOjxg/cWL9hP3YDkbO5NpdNnV1AxgyA7SXU/z+3J6r?=
 =?us-ascii?Q?11ccNGDVhGoBZA4jMWOMndg3TtKGElzTDGGdChH0ZeVpLa7KgfOOkYH/3iXt?=
 =?us-ascii?Q?3pSSFJHFSdxaASqJmP5MRftAjtQ6APkXjEwt9hz5XuQNJgq5uWVbtDxb4xO1?=
 =?us-ascii?Q?4e3rk/t2WmjntwpQ7e1juQ9mqHvHb8JfB8U2FjScVLj5chg6Xdh58OpSYZqk?=
 =?us-ascii?Q?+ItJKwJUkp8aGnrOqAb/DdThw661w/emBCrdJmQmYpuyzT/GNKsmwhFEV+2s?=
 =?us-ascii?Q?gcLOiImpeg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a909ee-132d-4ca8-fb23-08da31b5ecc8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 12:17:45.9657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+imH1wG5JKKcf5Y7nbD08fecNRa2gbpHPMlC3eNqs8gSqYlbCa8h6ipfdwJgD3d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3468
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 20, 2022 at 08:40:43PM -0500, Bob Pearson wrote:
> Minor cleanup of rxe_pool.c. Add document comment headers for
> the subroutines. Increase alignment for pool elements.
> Convert some printk's to WARN-ON's.

Seems like the commit message is old..

Jason
