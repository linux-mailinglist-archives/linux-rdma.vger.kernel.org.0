Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8996C270930
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Sep 2020 01:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgIRXkP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Sep 2020 19:40:15 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:17376 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgIRXkP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 18 Sep 2020 19:40:15 -0400
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f65455b0000>; Sat, 19 Sep 2020 07:40:11 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Sep
 2020 23:40:11 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 18 Sep 2020 23:40:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QT8UOrFN76J+GZbSnEJXjWZQJktKLmSiexUGxdSIC0ASnKvJK07WuLDwwuOO/bYzZ73Oa2R2fpXLcjFUtNJZJwoGw0TPYcy4KmJrgcIQRV7x3Mp2t1L7O5oCWcHSRNSJ22/JOX0kF3i0zE6HWJ3PiWflvkSaMgMfdnxHCAaIYo3+xv3QXAyuqZXP+HCjg2bIZC1BeB50lPSnNGvVlCWL9tJqLJ15VBZ0Ft5EKmRLYY8DVOqKmJ8CxG1QyKLRIffa0pmjHRVpkcZeDj53gceWAfcyOOHrJ+udD5Wca6H1SBACkg6daOpJk4uicfjGpAPLlF3I2cHcty6uoN03HkkN4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJeEynlZ7QjHD7GWt68GoqEWH23aMyNmvm9+IbrWN1g=;
 b=lA9rwyoS8TSsrdTWmwiMhu6Ns5LD4T0P/cvfb63NuJIWNB+8mWwEdpw2SR4wy3XOmb+PxAHCi2R0LGh3F060eDOU0fenrE4vXITjVfwSGZ5jdzRWaKsxRfHHU+G8TkckqFrxBHBGKbdHXkMEuWErjuscQ9oecOl2p940spjYXZnG+RAL6YEKgJYTfTXvX9U/9RaMToM6D1nQO3x1VIYa+RncsqdhvA628vjcwugsfhakqcvEWyexocD6ic7bucXKYDE6zuX673ELjjNyaOOCrUMm+ykxyAauaeqzZqM4N8pZGZNwGuCThswodzTldOfpVRUKJtAXLSIhVtKTdzcwFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (10.255.76.76) by
 DM6PR12MB4041.namprd12.prod.outlook.com (10.141.184.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Fri, 18 Sep 2020 23:40:08 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Fri, 18 Sep 2020
 23:40:08 +0000
Date:   Fri, 18 Sep 2020 20:40:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <zyjzyj2000@gmail.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next v5 07/12] rdma_rxe: Add support for
 ibv_query_device_ex
Message-ID: <20200918234007.GG3699@nvidia.com>
References: <20200918211517.5295-1-rpearson@hpe.com>
 <20200918211517.5295-8-rpearson@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200918211517.5295-8-rpearson@hpe.com>
X-ClientProxiedBy: BL0PR1501CA0035.namprd15.prod.outlook.com
 (2603:10b6:207:17::48) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR1501CA0035.namprd15.prod.outlook.com (2603:10b6:207:17::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend Transport; Fri, 18 Sep 2020 23:40:08 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kJPz5-001tau-82; Fri, 18 Sep 2020 20:40:07 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72145de0-9224-43c3-8090-08d85c2c2d82
X-MS-TrafficTypeDiagnostic: DM6PR12MB4041:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4041296BD23C819C46AAB8CAC23F0@DM6PR12MB4041.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gOwPWhqPAxjwchg9ZBZP6t+u4stbgCF1k13PUKQStAfioZip6dJJBUITNMfOZ0pGqJHVBKb/SOwC7FKJ15O5dB4ILEXTqKIrX3HD/y3Q2U9pDvZ7KtBg4LqXDMJXDDgoHtth6DrzL7OSkKZsbAoC28Oq++SxvYp+2vzn2lAwa8JWwsph1YSc1FUuwpOJheXwsLbG1F/FHL+5g2BNr0X1zef2S4pzlLMvE/0Z0O1iAmuW//SD4xcknN8XncMu1Kv7k/nqpi7H3J4eWkGwtoUyuyNFiDnlpt1ALnr4lK1g4oU6MV/a2VVDexlhCyIRvBq+7x3WSVL6PuKMo0Qt5BkU7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(8936002)(316002)(83380400001)(33656002)(186003)(8676002)(86362001)(1076003)(36756003)(2906002)(5660300002)(9786002)(66946007)(6916009)(26005)(4326008)(66476007)(9746002)(66556008)(426003)(478600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: rMS6kuCtURB7lWeuwQqhFIKeq2YquFqPHvfX/33Xj8ps16SDjzB+SOBwVM5wL/xfB2IdssGgurwAqf+P1aZyfpMFx28wBe5HyUiPobA472imHcBCMKBzZc3tlSwDel0oWK4Ntn0OMlfCQCtUHJ0zmzbOUWSZcF6W+3MNycZIS0CIbayyY41IIlSuMWrTrSdhpAiMz5VpE2XsDixx4pvsKlqljQvtyLw1S2Fu2JQCDGvVyPA2/nFUANyIyfx7ofkqlwpBcntVdgDtbI+FeQkYXAj1/AC2ZBLkdGzJFly7pbj4pgeUzielNKn43X1gHpa5lPJzQaZa4BOEjSetBhh8uKK1OGzCQtmZbH/QvZdk7semD7Nb6zLsCLX9GKCxFD+SDQnigpDAfWf/HoMwbWoEOpVDKzyv1hGeUsmOXqynNoAGPFTCx1ntkUlsJSjTRXe+bfkjZ9GEywBoT4upZcdMtJTpzuyIBamBw3w+W2UGAf/fW5ATjNPfRqUBOfjQG1PVWy/I/QaKyV6868tCug5YqUg+kWdNuo58ALdLn0WNA/MqyZSQ9vYNxp3cT68K2UY5eUxy03Z1r0RtC7dOIRxuMwzQiOmieM2rA4hSjRNd1ieHYn36HyhM+H3l+Wjcq0KCwdlucRnZYahC/c2Nphy4DA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 72145de0-9224-43c3-8090-08d85c2c2d82
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 23:40:08.6937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0zNISCAdERfYK/Ow3JpaPSgRVvzCwPgosNzEdeNdWKJZJEslhX+aLZT2S1ua421
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600472411; bh=hJeEynlZ7QjHD7GWt68GoqEWH23aMyNmvm9+IbrWN1g=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
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
        b=NC5GZilLjtSNWlwo3IaI6V546IEZbsMNYIRgXq9jkBISv1dSkqQ9TLaJtI81VV1Cp
         hUXsJ2zP5JF8vrxQT23XjIwNKHFRiDn4nAsto6kEBkA0iIVZ8Pgolzjz6pddAp6JLK
         NvZlQBkFk6IOSM1q48gWc7lzpXtHQ1PTVybn7iv3utu2kOZgZBT6arar0Mq3yYzhxW
         vPHhm9bSUEq8764UeTE3r54Ig4plMYlFNrfyjrgNjhIdOyRz/d3A7jiMHJxxmCcGEh
         u5a/tQGEu5CruiOTXHzlrlEh+0bfR/2C1s5iqohO16CVsCyQSPGC3VDdC0AMa0mFXu
         cO/4zwdJdjOog==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 18, 2020 at 04:15:12PM -0500, Bob Pearson wrote:
> Add code to initialize new struct members in
> ib_device_attr as place holders.
> 
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
>  drivers/infiniband/sw/rxe/rxe.c       | 101 ++++++++++++++++++--------
>  drivers/infiniband/sw/rxe/rxe_verbs.c |   7 +-
>  2 files changed, 75 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> index fab291245366..8d2be78e72ef 100644
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -38,40 +38,77 @@ void rxe_dealloc(struct ib_device *ib_dev)
>  /* initialize rxe device parameters */
>  static void rxe_init_device_param(struct rxe_dev *rxe)
>  {
> -	rxe->max_inline_data			= RXE_MAX_INLINE_DATA;

What actually changed here? Isn't dev_attr zero initialized?

>  /* initialize port attributes */
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 21582507ed32..a77f2e0ef68f 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -1149,7 +1149,8 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
>  	dma_coerce_mask_and_coherent(&dev->dev,
>  				     dma_get_required_mask(&dev->dev));
>  
> -	dev->uverbs_cmd_mask = BIT_ULL(IB_USER_VERBS_CMD_GET_CONTEXT)
> +	dev->uverbs_cmd_mask =
> +	      BIT_ULL(IB_USER_VERBS_CMD_GET_CONTEXT)
>  	    | BIT_ULL(IB_USER_VERBS_CMD_CREATE_COMP_CHANNEL)
>  	    | BIT_ULL(IB_USER_VERBS_CMD_QUERY_DEVICE)
>  	    | BIT_ULL(IB_USER_VERBS_CMD_QUERY_PORT)
> @@ -1184,6 +1185,10 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
>  	    | BIT_ULL(IB_USER_VERBS_CMD_DEALLOC_MW)
>  	    ;
>  
> +	dev->uverbs_ex_cmd_mask =
> +	      BIT_ULL(IB_USER_VERBS_EX_CMD_QUERY_DEVICE)
> +	    ;

Hurm, I don't even know why we have this bit, did you see a reason?

Jason
