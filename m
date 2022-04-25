Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E518950E41A
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Apr 2022 17:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242648AbiDYPOg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Apr 2022 11:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242637AbiDYPOf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Apr 2022 11:14:35 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAEA82332
        for <linux-rdma@vger.kernel.org>; Mon, 25 Apr 2022 08:11:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciSbgBgHQtvDW/VTQRxyFBAadCWN0O3iixIhUnrjb6CDhMkqItEDoGeJBbi3VyraYwTxEVekfOV8/Qq9Xow2rGNm4XzczudlAJPKkOiSvbhq40qCNRyPkSKGcnza6OeA7QV8q2mkCYUCRhYd2AGrfPZ8VFxAw5uZfx4zjx7jgxkpDxE9Yh5xwfY/E8/tsaD/Ia2t6wzxsDiJuXiDmVsWH3shi7aY7U7lDf704mMtGMkaqoLcTWeLK5DkPWIFC+R+VlVUVF1H+UTmLd1xiRGkYhAfd6JVJRlK4NUNtPUh6LKxPn9+6T1NkkiP4Uzbg4fQk5acAkiS6n2DSnacyaMKOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOrW8+O7xdbnnBoKrW6MjfRZqXyGTLnFnBwzfiCiiu8=;
 b=N9Q4mnfmKV5SZWbKyV56OrQlXOD4U4OKh2II581YDC4plM03NXfF/Z6KKCb/bvXpQ+hUTmgzigNpH4UOuLqjqY6FV7BlmpSNhH6tTuCcN2BPLcmVL+cv4ppGjquhBUjpHlEnmhW+g6w0mQ9+RKIc4GB66lpKhY49UMZDbfD5C4SpbKUO9vKZNcr/o83NaNbPexwJA+W+IaVjhkEecj9GH4/2fxFw/tbBnArPM4/ZmzrjxVgJDAR92U6x4hMXfzIFs6la7+jn2d594PGFsYZU//ywpbwe5DS0xBHfUCyi6rH/E1FSoBbr4G+qzjCtuCwe4bSpDpT3zjyjrc8Z2QcXGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOrW8+O7xdbnnBoKrW6MjfRZqXyGTLnFnBwzfiCiiu8=;
 b=DkfZz+9kI1L4kpl5ohR4EFId51IOfjRod97c+e/6Fioe2KxgkuNr2m98aoCShQdWDI0mXMbkR/3fQ37pqyxBEExCTeDVxHkdrl4hOravIl8Zf8/AeAAhsSs2G3zBfkCWu0q559y2uBK/9HwO9GBCaQlvbwLRA0GTj+cB+uPkh9H5zPgEQOvlF+FyPD2N9SRgRHMjZJ16hAZonjxZvLe+9OkFdI17V15DPynu4kdYwTDXwybNrV9dlq2387kJENfx1GSCaEjZ50Ny4QaqnO+OkPwqDoTCmkJwCIRvT9Bu9cb2vHs9JEgk9Usdw1fnrMMvvk0VBi0nPgMnNhbqBcEQyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY4PR1201MB2500.namprd12.prod.outlook.com (2603:10b6:903:d0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 15:11:29 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 15:11:29 +0000
Date:   Mon, 25 Apr 2022 12:11:28 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: Re: [PATCH rdma-next 09/12] RDMA/mlx5: Move creation and free of
 translation tables to umr.c
Message-ID: <20220425151128.GA2210175@nvidia.com>
References: <cover.1649747695.git.leonro@nvidia.com>
 <1d93f1381be82a22aaf1168cdbdfb227eac1ce62.1649747695.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d93f1381be82a22aaf1168cdbdfb227eac1ce62.1649747695.git.leonro@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0222.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::17) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2b39110-942a-44b5-4fa9-08da26cddff1
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2500:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2500895A93C1D0D414CA6FF4C2F89@CY4PR1201MB2500.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lIcYW/srI1DpXQotNCLczhIfr7AeZomzNCBCFIoko8g7nUHkbUwz8KvYLdR5I/csu9PCmNNabZOftR/nVaZiMqf/1eAt6HoWCwBH71UqEuLCOdMUSmJMylRUyFVv00HjAf++qCdFCLTt083K5dv7DgE2JnhAUIVWTHb+gcxEMjU9WjtcRJsS7kzblH/zjcXujh7mAlGqDAsuJ5KL81BY7l/9NKvJfqVN2FXU5YXWAPVdn4zLEc/HiV4fvTYwYRk5IyLcQ3hd0Jd++hmWhCUSacQwnO4hD3+nxM5Bwe5GOXI7+XXecZdE3mGtaQRSL5ipgtq9EFcT3HbAudZEbPkYRLqHwq9r2KtwyOu1KtAo/cP8mY8sO+yqQZs17WzE9haz6pZxZnsj/ZrY0Eeo/56hBhj7r8x1+l1cSkoqLZRyVL9Tfe7fQhamUkMzjKpVNfLnhUFZBeNbewKZUVhVCt5kXvHYRoW0bjUmkm6+D1m5VrO4GfreFInvwj5tkdg19wOlNRcf5fujKQ2VbIrfVzdPUp+A898OFztTAFfn6ziqav4GUUlgsK/Qx/L72dPjQo9zgujYwpUZLz+1aeqidNeNSVhqjahINHCimN3Ad+/yq1aOioAFygwzWgGus2NcwBKyRhSuEiwS8Z3l0ef6KBq6tA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(2906002)(5660300002)(558084003)(107886003)(186003)(8936002)(1076003)(2616005)(36756003)(26005)(6512007)(508600001)(6486002)(33656002)(4326008)(316002)(54906003)(6916009)(38100700002)(66946007)(66556008)(66476007)(8676002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5StAuObaep2vS9tq9peow66QjFQ0ZjzH00Qh9JD4VkN7nvIJtDnVETLhma7Q?=
 =?us-ascii?Q?WJPqkByZvo13F8No04UazUZWV4+L938i0ZqKfuoduMqKDVLNvn/3EV/93ooG?=
 =?us-ascii?Q?IRY9O9z4sAs/1JPfx2gY0t6fUrqhRz8ElRIPA4ejvnhukqAzwwVqrCITUVig?=
 =?us-ascii?Q?o3K726wmc/ilTuEU4CYGJxdTzt3VVh9ODFAt0W7wK7Xjedr2ZAMvNwBZsB/Z?=
 =?us-ascii?Q?5cDPCiMitv5GM/1nYaiZKaPIBj84ThNeny1C9U96s67Ze1gYw7eK9d2oTW5j?=
 =?us-ascii?Q?L2cfdDLZONOHA2WIXfMdiLIpmt3q7QtBlxQssFEEBgd68JlFBqae1+7/5IR0?=
 =?us-ascii?Q?gdJpy+B/0rxJvZMA2UQ4sgYJalcS86mRd2XSdU0s0aTp6e0ZOt2TgAtgwcnO?=
 =?us-ascii?Q?Vfq9fF9dWUpL6zoMz+HbZI1/cZxXDwQ1q0iAybpQzfTC0M9Gzam5zSf4ZlZP?=
 =?us-ascii?Q?Df7u8ooaLY8RrDu1d8l4e3AODK4b6aVvB77T2BL0n2nWSzu2wWy+hv+O51Gv?=
 =?us-ascii?Q?To1rfj/U3qUrIo2ZdxNYJPZhn7dzPYxMRHo6mDMYHQ0qaYiasUJHsC08twgj?=
 =?us-ascii?Q?2KhvIjeAnzxWUsj/fVXA/xDJJ4PX2+VzfFlkQ7tAVp3znjBGbTclqlZFZti7?=
 =?us-ascii?Q?wjO7NE08dgOSqPgRCBMbIeMUjp4CbKCJdhVXKLXHZMkAPeRqTvzQLMPksJGp?=
 =?us-ascii?Q?aYYov7lB78in/MJNyK+rWFKApr8PwDrNUi1HWuQbekFJYLL2mVOYHXNDhJnZ?=
 =?us-ascii?Q?Jt8nkpxv0Muq3+L29XB7Y6Gv3qAtNPXBRt8107mDfnbZLpcuU0O+gzdj2Ava?=
 =?us-ascii?Q?eZg24DhRQyV+XwI+31AsPq8YAEUslTQ0j3lDQpcqbEgjhpWnUAw3JO9sKgrd?=
 =?us-ascii?Q?cUPbI85am+1D9AXXwV601qxyDl1edJuwsEavpbY1KYaBavBFix6zf9ret1lJ?=
 =?us-ascii?Q?zBMsJ5K4O6LAR0J6sxpLg7+I8j+ebkMhgKCDFalvEKJgpkI82PLkCwi/a4ic?=
 =?us-ascii?Q?cTb5PmG1cORzCFLGNZbYzqGIZAqZDF+j4aE5hlWA+oAGfwtrlzkbEchJonM7?=
 =?us-ascii?Q?ECyx5IuIuhKsomhz42Fajgsgxi/qqwBtB//vx7xcEIDbCsd6px+ZgG8CJtI4?=
 =?us-ascii?Q?z+iDyUweyd50B+s+xJE8Wy4ugilSdEvx6ifO0K9O91ofZ4PntAwrQ7bG/KLv?=
 =?us-ascii?Q?LThrkM6gQaEYe8DIIUY9yJhw7qnqgfwUFMJahR5zA91CKkTXr2xJt18OSANN?=
 =?us-ascii?Q?nVEg7LdEnd7LY9MKveYhdBzOA9FYZElB+VT6LrDM9qvMBylyoCbmY1PbQciF?=
 =?us-ascii?Q?gHh2usriwytiqBKgt521gTc0yHGMW9LnYigbJpNQGixtvtSzxVdv7O0R8qZD?=
 =?us-ascii?Q?MXJ8AdnGqN6twUCKFsSXRnkVx0cqJOZ7eJz4JZyNsftZKk9jViO3kQC04/to?=
 =?us-ascii?Q?HwxjBTHHyV870AQ4GlCR/+QqOyO6REN1hIzx+f6NMa16cV2VakeRMuflTXfm?=
 =?us-ascii?Q?bkI9H/znBvDawlWZVDkdGi3z7LpGLtbI8HqnQ8H6lFvZFCuM2KMVnSV4+tWb?=
 =?us-ascii?Q?7JhmKYPahCE+zLkI35InbpCuVTzEz68++oRnVREsttD2gi00Po9giSEC0nf/?=
 =?us-ascii?Q?1gacAv/vh6G9nPpiAhI6CcD05J8HEUotaXZUsK882tDlFVZdMRF9WPLjHC6E?=
 =?us-ascii?Q?jo8uR/DWeAD6AkW73xyHlHaXe8cS68neAN3+EcM1dyWQIHdF9/Y7/6aA182H?=
 =?us-ascii?Q?Ys0ZWkhXcg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b39110-942a-44b5-4fa9-08da26cddff1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 15:11:29.6287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W09FQIWYT+F9eFHTQ3ZkxPFRHeqobWdNqbUZQntEXiCKTW/l5AvTI2FnE0bQU+Xo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2500
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 12, 2022 at 10:24:04AM +0300, Leon Romanovsky wrote:

> +void mlx5r_umr_free_xlt(void *xlt, size_t length)
> +{

This should be made static in this patch, not in the later one

Jason
