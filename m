Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A2D4C7773
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Feb 2022 19:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236333AbiB1SVP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Feb 2022 13:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238874AbiB1SVC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Feb 2022 13:21:02 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A5E1DA6C;
        Mon, 28 Feb 2022 09:58:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdx/rZUW7TqnJv7e0p16hAF0ZEDSGvlfpi5iQN411XajQ/w/1ftdf8rpFSiAyAYfKo3cZIvjWwLGvx9EUYqYcQ8RB5N8WfFZyP9dMc9QytzQpZuf8Anuv2vhcV+yWaA/We7Vqp+eNRSDLYpVR7PGYLa8Uhu2s3sZnbivIwz70xQqlT1NjIjex17zax8OlwJz4TmBU59MH/Iih387GvYgqW12HeG5p5T1GS/L4ieh7FXVo/015h4E6Au1OIXCijiYVKmZegdpFNyTagHcE8KenpYBoVd5CPOZz5Zu5Bi7RreXXvuG/Nh558bu2qC+ReiCFZp70ofna6SmwY05govd6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Md4W9zyS56qAKTXg93vuovAPw7eQvgFxxwLjtnrlXLM=;
 b=TPe99VtGiRCOdzt9xArLx1C1+u6mfHhf2tDqJ6QGqj1EZI5Z9ktF71bVNoSjFYRktV9FKny3nVncWkSnHGVLHU9lu4G1IjXa5qjyR8Na62jkNvYaCylwjs9kkF6vinMy+aRcFsM1K/wHewFC3CtzZqdgt9/A5YEgRtKlYdfQtlQWjtSA7HnRxczKUxoJFGcnVc7wAxvmXJyl/7bfmCZgi5ZqYqv9lugW6RKopWw37fKsdDoQbI2f8/l54BdLSpuD9m1Cn4lpnYDnB49OGE8FXW74XO5gxRkrKxr7D373ZLtlzlNDsRmHOK0lN2A8IBf3x+N+Zq5dLUVftOR6+i8dGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Md4W9zyS56qAKTXg93vuovAPw7eQvgFxxwLjtnrlXLM=;
 b=SdDwSch1EI7jWb04gPxq31gbSHIpFsBgWOccldx3lYGNTvJRrBA2uSV8Vua6Ui3sid3u9CigV8gp8K7YI3gA9Azx7h/i9bgaE6swtqrCw28OrEe8FvOFAnTGWXfMiFEjZ8EmXSrHFGrLr6K8tiCOYTIDDvnCIlt8l0hlPx6rpQL7uzs5eYVQ3e5aFEFx2hwqxz8gcW6S1fDAGmcuiPrSootl3HYARAjgjcd7SCMlrVCk0qZn2igN8+/h1KvNCmEva6CB8D8UHtrO8CgYUwAKqkssB1w04UHzNYkMWEMUOhRws6DHf0xCGsu+/krfbC3TZfJmqByRYm88O592m6HsTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.18; Mon, 28 Feb
 2022 17:57:59 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 17:57:59 +0000
Date:   Mon, 28 Feb 2022 13:57:58 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/core: Remove unnecessary statements
Message-ID: <20220228175758.GA608324@nvidia.com>
References: <20220223074901.201506-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223074901.201506-1-yajun.deng@linux.dev>
X-ClientProxiedBy: BL1P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::10) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b82eed02-4dbb-42a5-df5b-08d9fae3db5f
X-MS-TrafficTypeDiagnostic: MW2PR12MB4667:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB46677B04045F2674298812ECC2019@MW2PR12MB4667.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PMTvciuPmcXEQ0cm2+vl05uovmNzP9uOxxGunou9CXcj2uLvNFuDnu7psYWTziQrd2QabT7ChS+yaOUJIzMnXxg0yNTX9wNGKeWkyfDiksD0l5d6BfNo9ctJi0bV6tPb1YR6MwFMRdOAXyBkd/RYeKyHCIkkRhW5ZaVr3i9Ozcl5W1jp+Mof2sGM2MlPjp8UXsMAF/a584vfwxwCVcpcrFCk412cj7OV6VL0Su9e8GppkrQLeM6dqBpF/MeUDTQV73d3dW1SgUNZiwyl0bn0ARetYBmpCW27KfG4w5TP9Wqv7E1DXynHiME0DT7YT/ppaIgGuQbN0pe0aSnRNXPDHTw3TOVttak8jO9Eb23wiBnCw6rZQZFKh2LxpFRxKXl3sKIO3TQgCn5DAs+KGKeNtSp4/M9m3J3vuQgM01Zx1gEpxuEIPVuhoGrlxMTdk/AaPSVKgBNQh3sncZN2xLyXPMTbOSVCBrUCN74vAX8Dq5t703zm0kUY/+FdVVTdJyDJbe9akCPMh0KJ7hd6PAW9SXYh1ysvuWwJHpjY8EaN0E7PyMh7dkR2e63z/3g6Hrp2Iw4CAzuYEZLPwDE0MlEd1mSlNM77gIWz9DwcRiHmPwRYxHe3cY9L+msTgbIa/mlnHztCR8ZBsv+oPSX75l4qYRjUakfUXGxqOAvkrN1xWFdcDqXBhSc1F2PZWV2NXkyd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(86362001)(38100700002)(8936002)(8676002)(316002)(4326008)(36756003)(6506007)(66476007)(33656002)(66556008)(6486002)(5660300002)(2906002)(508600001)(6512007)(83380400001)(2616005)(1076003)(4744005)(26005)(6916009)(186003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3MHiAv/NdtR9/nlYY8u1ORbMQMVpQ0lIubdPUqNr5x5E9aM9aMSnzxpaJ5iH?=
 =?us-ascii?Q?IE3HNujm3LrYqjsRKqYWyKuetJ0ULu+8msssmbQtN6rNUZOrxTZa9J0erOXK?=
 =?us-ascii?Q?MEs/omCozwokQpSXeOeKy8j4KNPFzuxAL73kOlIABPrpA1M26vBtoboUuWaa?=
 =?us-ascii?Q?IjBO3EALlicCgdi2znqKnxpvRw3TZ9prhLzC8ceoMaJ4HUh+qbfuOYuGxOFr?=
 =?us-ascii?Q?KqUvEeacweY3akhABDqYUJySJtSq7yqc1RY2zGxXXad8SVVc6SxzfUehPKN6?=
 =?us-ascii?Q?EF8G1RvjgVeYm2WxOnbbOVJGClZtf/YGYa/oBWcfJUPtvY9OYHZewDJntJ4i?=
 =?us-ascii?Q?509rLgUfMJicZo3pWxLz16Bwm7gChl74GgqrP0kV0F/QqRC4T+ZzNT8aOQIB?=
 =?us-ascii?Q?UePXp2tzi8Ay8fUwprXTYobEtvcb1XkjJCzk/xDpkqfl23qeWpVL6lox1StV?=
 =?us-ascii?Q?Kj5qaURzsnDLly/MptwYXzwtcRaGoTOMyFs0ig1LxUvBxd/A6/6cmk7wXS8y?=
 =?us-ascii?Q?Tuh3HA+YLL6LYxZAdX/9wXxwM2s6V7XuJkb3GB7IMBk1a5283MAHSTZ8u1uF?=
 =?us-ascii?Q?GmoGhgj69UaYhdMaCdtvsqncCeXlVTO9Ad+EJQtY45jn71wuILDermyYnuud?=
 =?us-ascii?Q?T44uaDXxDnbfQ1E0GWfhl+L+HTxhGejp30B42HZSFCflOywCO7dythkz3XNM?=
 =?us-ascii?Q?gGfIPbZM8jGRHmT5yCwjpLdsObOnpcmMu+0ohfsXNjMupPlXqlUYS4MztpVt?=
 =?us-ascii?Q?+laPgb8SpWrgPKQCEotv90DdL7dJ27oyuqi22BLJyAvxWoHepkeHKKUMIK+I?=
 =?us-ascii?Q?JL0KyHoV13SnWbVbr3nB30yYDV1Xk5F/MVOjrmIXPqVBCGQ6n90a4e2Qkk4N?=
 =?us-ascii?Q?3paZKmUxYS2b/8IV46iHggg+Ji7gFXyaKq6zW4SEapNIsUpel+Qbe+arsenh?=
 =?us-ascii?Q?mVTmHEDwIuPgnsxMCRmev/s6OynEi6THYYPvsOOywCK7G2DwyXKJrws++R7i?=
 =?us-ascii?Q?hIPbZM/rD8IosBCToRF5kLYWkburi/4LRy2wfgfRqjGq4Cj85g/rG3UDsGjs?=
 =?us-ascii?Q?ygmdskBWC+wq0UsIS2dbkqxeFMScMYOK+xIh1Ar78THyANSKT1yP/DiM7m6N?=
 =?us-ascii?Q?32MFZ0nTG5tKbSK3DR8sO9vzywfQM9ZkrL9D4whXG7AlaIFDf+J/qGhezsri?=
 =?us-ascii?Q?M9leWa4BM9HoNlb7aTHUk39wMoOxqBAoi52PusxvBvypASWQgUdA1GUOR1h2?=
 =?us-ascii?Q?QSWvMfXRde8TtM6AKU2NS7JKzHC3xWLlYJgOaVNFIdvL9JghYfXEY5l8l9ZH?=
 =?us-ascii?Q?rAvEjEgurAhmwgtj3A9ZA2+QMN/bpixdpkFvqW3jBnWb/qpqaQJNfjwqOwfh?=
 =?us-ascii?Q?rLKdRir2wG4AxWFgt6hsC/ok0t5jyQJfAHIO7xQSno2bevO+uW6a8BNkzb0G?=
 =?us-ascii?Q?V7VCu7fNrW9+jj5Gq0hBjKSv3nGk6fCoFB4dGsxnnmGdAP7B8QuQIF5p11j8?=
 =?us-ascii?Q?DEpGgy/LLehVu9VOaYlX5Ccb2+QV6y2VARQGVq8sxVL2qp/jeSLZWM2hjOXi?=
 =?us-ascii?Q?/ReFrkZYBb6PZlc7Lrc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b82eed02-4dbb-42a5-df5b-08d9fae3db5f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 17:57:59.5430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2SvPjamkawKxShpR4KDhNVehF2OwP00b8l/QvmhpsiAdYIa7yxZlIIMOUgXNIPo9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB4667
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 23, 2022 at 03:49:01PM +0800, Yajun Deng wrote:
> The rdma_zalloc_drv_obj() in __ib_alloc_pd() would zero pd, it unnecessary
> add NULL to the object in struct pd.
> 
> The uverbs_free_pd() already return busy if pd->usecnt is true, there is
> no need to add a warning.
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
>  drivers/infiniband/core/verbs.c | 7 -------
>  1 file changed, 7 deletions(-)

Applied to for-next, with Leon's note added

Thanks,
Jason
