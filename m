Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E9F4F9BEA
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Apr 2022 19:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237717AbiDHRpH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Apr 2022 13:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235216AbiDHRpG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Apr 2022 13:45:06 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D911327FC7
        for <linux-rdma@vger.kernel.org>; Fri,  8 Apr 2022 10:43:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wnv/VQgKGx3iTFP5W3Zmm/jsqt9lM68A+Ww51K9Myw4bi8o7L/B5MnAmedejNlZx5DPH8/ISB8Wr1Om6jEMEmDvlsA0OD1yUVzoYw8l/ZaZ/8kI9uLKZHUUyrzILapVGZeb7YC6YwQIv2f5sDFN7FsQ2F3QSXSbFMNnZQ+hPDzAhCnJVx+DjjiMTRS94FyzdUGpJf5HX2ztbsgCcJiQ/WdAD9u05hv65wzTapXatprUv3IGkVajF1bY3nUcOZN6kFRfboe8i3HNhMnjvZZlpG8YxlSCoTT04LBUFC8hOwLgj8y8Ej/boSKhLB3JyhZ2INw6WGX7zMtkG8zRzgdaajA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wF1OA3/LEJ95VfnS9CTvz6jnJEJv7d1oI/eSlKyvukg=;
 b=K1hRYi5oix/kOXG6Y1GrvbSsUVt/7Eae3Rs5lakYjZNAbwR7clNVpOb9Ac9AwhmH8GBnyFjwzLAM1FXTkePY+gz/2VPHlAFb51jy3Xv12GFOkQWuiPTowVP26+JU8ldWWHaUcWAfvOmJHdPHMBU6Auc9LGaUQHowOTP5wOSrW9FUzSev3oQtS1NnXajbyvgfkDfzROXpEZB71N9h6OwDD946BhIaNe+fg6roqZAUb/uAHxUv+eLfhMIpKLJ6axqVUUM4ELNK4Ma1U7t4jHL6Tg1+MjE7rKpnSI3nDBdUek+hy81j0FdDAqdd61TnOSC8lkIv9PhZhWXrAf0cZyGGeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wF1OA3/LEJ95VfnS9CTvz6jnJEJv7d1oI/eSlKyvukg=;
 b=bPViZa7zeDIOL0dlmx1jmYqzflkn8hEBcqOTYm6uusNMPn6lQFLSYpeo9BDjd13Z3ldBgsVynKs48yUNvwuFTwBXv18Yf9Mw74Mqrygn/X2wk9tgHgXzv/oTf+akfjXme9d6zXgt1gFbFwhnkRwiEDh15H57qg+cIXFUNOlQLuheL3JStkZTE6AZJ798DScvIaCFA1vrZFgw3NMdzyS58xvUW5Tvf1Z7Ml0M3gOLBgsSSwueCVJVHR2xvaj6vrsHygspcCS/YdKq7XgLSMXS6MciyCwgGse3Uk1fijVcjXYymDLDgZN5E6CSg3HOAq51KRd13uY+y8P7fBJqCcsXJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN7PR12MB2834.namprd12.prod.outlook.com (2603:10b6:408:31::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 17:43:00 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%6]) with mapi id 15.20.5144.026; Fri, 8 Apr 2022
 17:43:00 +0000
Date:   Fri, 8 Apr 2022 14:42:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/rxe: Remove support for SMI QPs from
 rdma_rxe
Message-ID: <20220408174259.GC3644319@nvidia.com>
References: <20220407185416.16372-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407185416.16372-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:208:160::24) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bad15126-96d1-4b57-213a-08da19873978
X-MS-TrafficTypeDiagnostic: BN7PR12MB2834:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB28349230531E08819F00634CC2E99@BN7PR12MB2834.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gs4pjoz8b+oe3hi8tRu3Q1h/yx1AGkP9kL0eoaStjC75GnGtkxZW3cnTo9VCEkU9h5wucJupoKcCVBxZLYmWH8bHcmo0GXhEl04vdrw+MVIVSZYPss4jEwWGn7ifqdXfD5QhZVy+5kTtKZtlhQM2dAwJLp1EISMG0QPZb4wSGwT6m4mylt/VK0Uujeb9eEzbHe/3thJHOVBz1Bj+HbvSvTyAE6y+Q7i7EALv3asljNcmyhKMwmNQ7OY08lY8xc92itrBC3Q/yLvs9Obba94s6i2RFqIWcgQg6sSCJNcyOLuJA82mhxm3kKKRkFGNmd0YmZMBGFFIf24O02iVn7qYQjqDXpzdBks8ckZYSoOx5qq076npoVQek3zyxgBlfnfyS1bVYmu19xez5TywkyFTbzESeNYXX0Hxpv8mo/V8GjoEo5klYZn9nxHbwF8easOIaVPDoNwjLXgRVpwcS6Gky0sXvZbYZJ6KfMAOKdxXhIDkjkMXsOXngtdMTgTgHEcisy5Y38DQ92aJfkX2MwyzjJ8WVIV+7Awh0SeDXdGDMId+r6OUqAbrT4pDZbMjfsh5Fy9UXk2VS6t0jhXesjIZTIZmJFj0f3GmfsnbzTOtqW4xjQmKl8oETlFcK9cp9JTzog0S6S+Pr0su4kDXSCH2/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(66946007)(66556008)(316002)(36756003)(8676002)(66476007)(4326008)(5660300002)(38100700002)(6916009)(186003)(26005)(2616005)(86362001)(508600001)(1076003)(6506007)(2906002)(33656002)(6486002)(83380400001)(8936002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GNJtColGgXXLedaWIViVarZ/vzTo3TIABjwCTSam0+prDYNMOfVVWUlVsK2q?=
 =?us-ascii?Q?zxbffw06boRr+H9s/GXGNDKi4ljxpZu3IFho0dca9JUIh/cpARqkRNkKDEGu?=
 =?us-ascii?Q?fUgVISDr9z0PVa2/n/XjrSM/soTlENDCAdJdzO7zfLhDOdXEpIpS5gRMmPFh?=
 =?us-ascii?Q?d0OCluma7fO5EGZ0hqTT0yIOzpbGoTwiJYqp6RV/C4RNLwQPlG9yp5YRu3+V?=
 =?us-ascii?Q?uHFMQ8F0Fydm4P0vxpzN2ws46ug4NLWteBUnu0SfIP/8l+YbqxD2SLpwjIPl?=
 =?us-ascii?Q?JdNuK7ziK/mJinC04MtoKHj6sD+brbZuJtL7iOKzY3M27QpDsyEySRZfBoSV?=
 =?us-ascii?Q?iwPyr/clDn8FE2NH3xG7XeAkJwqgQBeTuv7n4DhLqfVNpXP2JbmhjyhLbWsC?=
 =?us-ascii?Q?wMVwcY0XIpdh3fcQOUbXgc1+kwpl0Q5roRbE1KCxgUi12AOvfqfiwSOhnkp3?=
 =?us-ascii?Q?0xqDmjjFvWVT+p160dPvM00PytZSDX1pW6cdCtMBRlWeUNQ6AB0N1M3aO9P+?=
 =?us-ascii?Q?fAXbDkE2YJFJciGr87b5iUSgUfWdeeaXeXuOYPr0j78RcGUaGxSoYDL4iixo?=
 =?us-ascii?Q?orNgTcftAjSz4DpCg4xlPpJ0dYb3keO6ncac1JEYSI4IzqUBn3b0V3ypWAvC?=
 =?us-ascii?Q?6XOSAFWQC1NRn8tFrK0L5BYXrbtFm9uiKpy54CQJKKg8CI8qm26HdsDL9D5h?=
 =?us-ascii?Q?2d2ZxWrAnM9b9sGVFEs/jPV3NWw91c3ws0iv5378uT3n0LVPIVARhUUqoYvr?=
 =?us-ascii?Q?Oth7yrtqCgpG9JN0ozCgpd1mKzjQpbsSwEKNk+tJPvueOj0+x9M1LCsvyqB1?=
 =?us-ascii?Q?ozkAd1Fkj3mGJerSXuUx0rDjiRsSxIxT4xWjrWq6fJ/nCY4qMp3Y1HVnoEp1?=
 =?us-ascii?Q?4HieA4cmruioV1ME9FkwcY1kQ9fyKOq5i+cilgaPK37BdIR5UbXx8qKtXkrw?=
 =?us-ascii?Q?9OXHLyQUNKXwpfX9AGFoIIenD8rvzfwtFx1TpOzukYWZPvi0JKkOTQEKuItY?=
 =?us-ascii?Q?7k3J2kprW+4aVYPsKP5vVPym6uADOzPjVZT5d3fFtkWghYuOiwVK+0yt9hiH?=
 =?us-ascii?Q?tI11R2TUdo4LFJ7GzpEOHrHI6RCI6pobYehmXd9qJSouh3UYXHSKaVF4NYp9?=
 =?us-ascii?Q?7kpUNzdsHgtK9d5KyGl8caw35ymw7A+2AOtlVhbpwSBrpLwgAekhq9lLi3kX?=
 =?us-ascii?Q?WsfNUBbjbHP9YP3w4X8WN0xn7FQWL75G5/+/s6mme1A20NgSd2sXIVxqKDRf?=
 =?us-ascii?Q?q50hWsUwXpyl4laYEea1hFioTF646depp3CNCZjbco5aE6VM97TjBLyz8H/V?=
 =?us-ascii?Q?4u1v2LKFu4Xy4EiugeXHMVlbOA7wbjefUisL1y9BrpUfG+Ix2UG2kH026bPM?=
 =?us-ascii?Q?66VfbqsqkHN6oY7F09L6OWvSaNsj2KfsDgd9gSutcGfMMnjAW6hI34/n+1P5?=
 =?us-ascii?Q?mj7phBPxwZM0b1iC2WvXgJ+F7CGQydWOoBZ4F61r/0evW16xBUtwisOlImTF?=
 =?us-ascii?Q?wB1Q+mQvYapAgvQgikm/kYV+pNWbAPwgbQWkRSMR1gx2iw1j6qawq1YcVoJF?=
 =?us-ascii?Q?9iG7rHNPINyJDqMiplUAgvSiUU46dRwoB1VtjeqKENiyTEVPzp51bmwnLVB/?=
 =?us-ascii?Q?wK/Z9hQCrsgOFV7VygiwHZBmWYKQYPKQysXRIShdZ+ULraepOt3K0ZwDL/sE?=
 =?us-ascii?Q?YUOHSL9XGi2YQcKaGExT4H/keQphOnyo0XBQmAeoGKoV7WRcRZtC/c87fQzG?=
 =?us-ascii?Q?4KWxhrWvsQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad15126-96d1-4b57-213a-08da19873978
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 17:43:00.3205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hlz+Mf/W3nJiqNt9j6c2zrcJfzuJ3N7CrckSvheOVVxPrfR8mQpH8JQ6vAsWRp/T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2834
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

On Thu, Apr 07, 2022 at 01:54:17PM -0500, Bob Pearson wrote:
> Currently the rdma_rxe driver supports SMI type QPs in a few places
> which is incorrect. RoCE devices never should support SMI QPs.
> This commit removes SMI QP support from the driver.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_opcode.c |  2 --
>  drivers/infiniband/sw/rxe/rxe_qp.c     | 14 +-------------
>  drivers/infiniband/sw/rxe/rxe_recv.c   |  1 -
>  drivers/infiniband/sw/rxe/rxe_req.c    |  1 -
>  drivers/infiniband/sw/rxe/rxe_resp.c   |  2 --
>  drivers/infiniband/sw/rxe/rxe_verbs.c  |  1 -
>  drivers/infiniband/sw/rxe/rxe_verbs.h  |  1 -
>  7 files changed, 1 insertion(+), 21 deletions(-)

Applied to for-next, thanks

Jason
