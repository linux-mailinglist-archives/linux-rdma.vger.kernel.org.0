Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9B355A1FE
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jun 2022 21:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiFXTic (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jun 2022 15:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiFXTic (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jun 2022 15:38:32 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A0348884
        for <linux-rdma@vger.kernel.org>; Fri, 24 Jun 2022 12:38:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXy5PtCAiR8FnAzRidAWtbNWFVIUzbA3uhkeh6a+70IahbUwHWQ189qvIAJxsR717wv3hbNR7hH0VReAlC0Q30UKUUJAX0TP04RSlQJKPfbkVaTIQIPu7T2HgWy7Skr4tl1/pO2iQ0jrN/skBaaY1XcMgHEoVhuZ/FAqR/0exJi07tAScE/bCHGj87c6bauE7nbAK7TDB3WHiKI0XuHIrp9dFRuZ9asOXLwR6HJhwURnA2ZuTjvfxcLeK0WbJR7zriClIG/i0lkIIU+dF8oSoV8Siwg6N+IKPe8bPTr6A28IXYB2rh7T4APRwxz7AO9mC+1RgdTQoWd+EjVobOGY8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1w8u8wRtuyyTy0ctnG5AjCFrYzw1+sO6BzWTBA45UpA=;
 b=I/AIV90g3CP8xaW9LBh9F5RD5jZZK+cQwsV3An0GgLoJDmdDCHqr+jyjlmy6YmFVVMF+WgE5ni2xwzfgI/f6HotmV3kHvp8wC3HgJUVdz8G/oWYcomfmur36uv8zRfRzXDgMC5KX7hpoi6fC628/FigoathGHFnfBkh4yanV5crN7eI3XRBTim5wbJsKYr9TQjtN36C4lk56Pv8i5d1ngLjNN3jpA+WaTTusj67bFBga7x13WmXiM156Yd+S9XmXayrleDTVaEUrxzxfyKogikVXOIq57EvKbahcTEUfsbsEZ3YiediFyZRtaizevZJGu5wlcE2A0MaZ7FUi2Qb7VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1w8u8wRtuyyTy0ctnG5AjCFrYzw1+sO6BzWTBA45UpA=;
 b=G1rq85opzdfvX+38iFIEDYT9DWtswIssKfwvB3UiS3mblnBcHK9t//9DvndrFd60yS9AZZOZySikcUyquY8xD9BCfJCnVKaNUtMBrJvzia/RAHXKg31iLsAnl64IU+Rc0EbgodBwkpMMHMrfg+1pPAEJYR6X0VguDUMJXCifCcY5FG6g29P0LcSHV5QYijoUE2lRwbf5b3p8+4IlQEGAZdJMMdeh5rVF7XG/HCh5w0sXGMmI4gkAsZJNT1cW7WFouuWm6OxNsf6oFmVLmnLGnxEUXVHWmuELOWJ5rEPpJlSmg9JfRHr3Y7zbf/udXqNqnbCLJu9Hok7BzT4BDeEIKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SN6PR12MB4670.namprd12.prod.outlook.com (2603:10b6:805:11::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Fri, 24 Jun
 2022 19:38:28 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5373.016; Fri, 24 Jun 2022
 19:38:28 +0000
Date:   Fri, 24 Jun 2022 16:38:26 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     sagi@grimberg.me, linux-rdma@vger.kernel.org, sergeygo@nvidia.com,
        leonro@nvidia.com, oren@nvidia.com, israelr@nvidia.com
Subject: Re: [PATCH 1/1] IB/iser: drain the entire QP during destruction flow
Message-ID: <20220624193826.GA240524@nvidia.com>
References: <20220615082839.26328-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615082839.26328-1-mgurtovoy@nvidia.com>
X-ClientProxiedBy: BL0PR0102CA0011.prod.exchangelabs.com
 (2603:10b6:207:18::24) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f3bedc9-97b8-4191-f5e8-08da56191c60
X-MS-TrafficTypeDiagnostic: SN6PR12MB4670:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JocJCFXFmxcKUwqYCfof2pMu0UFw6+GT7pam27CoDCiH+bhe/fTwuYfAnZmcOurMmvjz9df1dOcxRm8qyQ/29YtYXPqqHzmfIsCNRiKm7b140DkG0fd6Au4EcTkRgf4kgKYJ0uKhnF5oYOPPKtpQahTqTwKiY8Ng87/Q5by3YAkvXnutiRjwHeHwE/Xr/JCuvRHv8D0xujfb8c8cMgTImTUIGaJKsA14/ZGeSnkAftlUDYH+hFHQRYIULMTrvB4mukohH/jEOH5mWsBldVa9BmAfbj3d2jk74pvIXfazZA3zBRIkPARWb9BAJSdKNz3zFdsjS9UglTMk+uvpbLqfAd0DGMF1YCaz6XPFqjka8D7ZELSai2hbsd+7tEJ5gl/X4TTcTGCt5pjUSKDEgGSQhso59uJ6K7Wc1xD87gTlEe373vbDvGnwZ5Dg9Y0L/apwiaBpAEV7YJmhKOX3h9XZkuuywx3rG/FMJf3yFF54EgZP3vzutSI4bcezkYkk6KaHmw0uDGeSoe7TOkRt0CQ8G2WzVHtsmd6ct54n2ty4hmzhbHSZS/2FUPbwU0Uwv5ADUbsj0pAr00601v9EceUhzZcfUv5ydAqU85wWuOVP7qtKMrz8oNiUQscUqIxrrNw4p8C500qQIuKfmS45jKICCTAlmjP3Znv7qiQzDGGawaypFpiV8cm9o4LLaqx8EXYOx8Gw3HRZF8QsbKPfc0iW2X5GkxTnU2F4CrtJ6Bpp00NU21UqdEwjHblPN9vyQmbXMKkvU8GG12/IEF3CSg3T+M9zN4W57GtWDvH06+7MUMI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(41300700001)(6506007)(6512007)(1076003)(33656002)(5660300002)(4744005)(186003)(2616005)(83380400001)(6636002)(6486002)(38100700002)(107886003)(478600001)(66556008)(6862004)(37006003)(26005)(316002)(8936002)(2906002)(66476007)(66946007)(4326008)(36756003)(8676002)(86362001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iWWPk2b9uzC+JLxKqWohxkKWx1TFT5uTS1EAnglSg1Md6PRaY/0mTMnqrAyj?=
 =?us-ascii?Q?QXDWUnvpfYyk8HpoIZhS03TUXEgF1R5650E8mOhzD7j8oT8IlNynL8fveqQM?=
 =?us-ascii?Q?hco6XRkFGXMgAHoDc5uPw7Ox1NuwrhwJV2YcdjtmxiKw15d9mMrEKyILiPzN?=
 =?us-ascii?Q?UcpLDQZC3e5iyOvzWBz8L/TZyW1keJEvXTTzPi2aIldVr7l8WdHiYarTz23D?=
 =?us-ascii?Q?G24k6ZuS0QV08BZIUMR2aA/asw110CWENYX+sO5NO0YgBqEt2jy63nWp33OD?=
 =?us-ascii?Q?YV/eRF8i6JixQMmt7rY8BCu5ZVDsXt920hGqq24kfl6lIevDCj6WJO9c1DtA?=
 =?us-ascii?Q?cOSqrkqHnLOwjDSkZJSo6Vk01/yOcQt3rKQRMWJQk1Rbx2qofrvnSqy69MCJ?=
 =?us-ascii?Q?FnHYg56EXrroLXoWUq6m7rfyX9Xvq0ln6fTt7mw9sdLneQGJd/NoGQrU/YYl?=
 =?us-ascii?Q?fxO1VvpiiPZNWqe5+bDl9lBwYLnAJE/snnthyqp2YuVrEX7mp5AABU+1LScu?=
 =?us-ascii?Q?JAnvtUacZx/wZ0GcJvK7pQHMskQMyAldA6wK31zPvrY9mj7eb914iIBLmFLT?=
 =?us-ascii?Q?M7ZaXNzqqwmmDBV7xp4WmpJ783UPQi4Gt6nqmabgaEwk3ZuWb99Ofz+t7vue?=
 =?us-ascii?Q?It9BR7YS4bAzkdOLACrrnJO/gxxO2G7FGYrP554wmP8xAkyPUDFydPW+e95+?=
 =?us-ascii?Q?JQoyKXy0u0fXDd6LbLnrQE7710TKlzaLcG5ko2CSbBICi9z1oOQhS+2Uh+Zb?=
 =?us-ascii?Q?AI6wMqIN9xC7disd3p8jT3J3CAbjoCOTWlM8x5maaTmeDvNP77dXXomVnfk+?=
 =?us-ascii?Q?Ztwubq/vhmcCZtB8PPzsToKh2GJlJjJ5oe/TIdJtrWK8KR5wQgm9Bze5klko?=
 =?us-ascii?Q?NrHK0y8ApJDS5TGXYhvYBW7HWKOhVUEAIg80Ap1AZLH2YrLLguSZ9PAELC0m?=
 =?us-ascii?Q?eIrXQ/EUeZ3iEIPwq8f8i+iIKX3PS4czojFO5osiBu0oPe6lrG5ySK5Oq1mo?=
 =?us-ascii?Q?/MxKo2UibBfztXgs30sYAAdRA7xf+yXNUI0Ftmn8mvXh+QvACOi7EMsDPZ+w?=
 =?us-ascii?Q?8WZGJuHWcWn35RJ10cLBmzfz+24EQc7Si5rEtEy6bi5uuulpyDVkbkFIwUNj?=
 =?us-ascii?Q?R1/oQ+D9TxituvIlv1LnA05IjNmSIdogWLg+oiUnykVLhGkHrEmTQAuw9XD2?=
 =?us-ascii?Q?FPIkf2bCRy81/j7VRdHyf/eYHZ4W9Pj7JLoOFwk2x/rei/y7yAAkyh9s1/Dl?=
 =?us-ascii?Q?iccMzSexDmQepfqZ4v0gTHKiP1KVqcf41BX33PMHm2ghee0NKLsePzn6TQhX?=
 =?us-ascii?Q?yeNewoCCDutgpXZo5CWbqLmKg9ClRqoH/eC64wKVQuJuEGPrcVNHxof3l94V?=
 =?us-ascii?Q?u1ZGbT8eF1N1C4+n4jhlkSon/dHMvRoQ4ljrIT/BUA8uMr6gpHV9oaaFfdcn?=
 =?us-ascii?Q?+iom/V+QFrE5XIbtY8FIBDDEfY0Pyl+wdE8vgnuztYhq53GyohPzQfx8DCSp?=
 =?us-ascii?Q?VVl/pnxWEyuu7kL2dRAdFhmCV60VefM9ztSBGUN6cTqLOT2ESCqgoGM4sJGm?=
 =?us-ascii?Q?f36M/TUJA7sQ8sHt4UNbKh2kiilrdQ9SGdaoax/A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3bedc9-97b8-4191-f5e8-08da56191c60
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 19:38:27.7883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8P/rcK9bBpR0IsNJJ6X4yyqsj6f0vAuxaJe00/FlMR/fv6LwotYKeFQK+l/cNli
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4670
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 15, 2022 at 11:28:39AM +0300, Max Gurtovoy wrote:
> It's important to drain both the sq and the rq to make sure all WRs were
> flushed before destroying the QP.
> 
> Reviewed-by: Sergey Gorenko <sergeygo@nvidia.com>
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  drivers/infiniband/ulp/iser/iser_verbs.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
