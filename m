Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545F146C36F
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Dec 2021 20:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236193AbhLGTWc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Dec 2021 14:22:32 -0500
Received: from mail-mw2nam12on2083.outbound.protection.outlook.com ([40.107.244.83]:28193
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231804AbhLGTWb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 Dec 2021 14:22:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKeEiQHr3AiRYgHGYSuetoaBinxxphQ5a/CZL38dg4imcW4UtQm479/4nBVU+IkIzS6PNRnoQ6rx2IOeKLZE9e3l3xO1WqOsa05/1oS7RkieMDBEDxnkzeqlUAanRxf9TYNGd8+JyidYkJx/hiiJiYvxeRBdfUkPxadbvZJmkNDDNDLjtUdLb0evWh0PWMWrlJPC01qC1zT2Y1UqRQ9vPe6nVn8AkNr92+o8OEqi5jPm51gt2qZ9eSWNRQ8YUFu1GwZRQD6/gAyDEJDc/BHGqtZ7pSGWaP4tzqESem4eOFyKYT209slLHaiKm7eoIWDk3G6MTSvzmORwnvxeWG5I8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOO1WCE2syngi9w08Rci2UFdbTk3u71nNfrfv7rtUM4=;
 b=lwf7ka/ywTXdBOdR1ZWXKamZ9gSVPGhasyA6xIst+U57PynkzqQtgfcjcygt+7kUBZZWRQ4xnDZQwqkOR3CGJt+NYsmxflCb505YbzABKXxs6krayaGabfz4ST4wKtYKQAEb1QDUgx/P1fM4l4O2VTi+bzGtxlAFrzqgbKWFF1n8TQSItah0UQMEe5lD91/LWA3crW/V2JIV/ug8b/WtLSJy9V22lvvBTGhgXQlYiTIXSkf/54Kg/OduTJpmxVd9GYihkicbiohGP7FIz+y+ziHWqSBKPWrYvn+tUIa0psPJcu415xptWPYP2caJDFyOx+A2Ol7XhiIfvXsSSESH8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOO1WCE2syngi9w08Rci2UFdbTk3u71nNfrfv7rtUM4=;
 b=tYspkPmCafNKQwKvam9TqQubRGXPuOtOxaoGgcYkqAimzo/52YssZVNfHhUhV3momBkMm2CaBvc9a3ZHpd1MkokdFb8vk9GXgrDG5bEXah5kRzXaJDTcHlTcEYZkhXGhXsh8xhOhbxKtBN+aoeAGSwUT+Xeh5ncuDtHLRdmKURm8CgVPqu6tNh7vdsXHISlGJmFDt//qx5Uw63O0VcWVCBvs0uURzTpa4IEfK/J6iOrgW7rdWya51TbK5IaItcWMTfgSlQO6AOGjV7B7L4AASU4os402crgIgJpFpii9xDRk/Po8BkQZFYuKycgZrvE1jNY16TeaMywWbnOHEU3iYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5111.namprd12.prod.outlook.com (2603:10b6:208:31b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14; Tue, 7 Dec
 2021 19:19:00 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%5]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 19:18:59 +0000
Date:   Tue, 7 Dec 2021 15:18:57 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v6 3/8] RDMA/rxe: Cleanup pool APIs for keyed
 objects
Message-ID: <20211207191857.GI6385@nvidia.com>
References: <20211206211242.15528-1-rpearsonhpe@gmail.com>
 <20211206211242.15528-4-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206211242.15528-4-rpearsonhpe@gmail.com>
X-ClientProxiedBy: YT3PR01CA0131.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::7) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by YT3PR01CA0131.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:83::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend Transport; Tue, 7 Dec 2021 19:18:59 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mufzN-000WMZ-OR; Tue, 07 Dec 2021 15:18:57 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43a84162-db65-4fa9-43d1-08d9b9b66bfb
X-MS-TrafficTypeDiagnostic: BL1PR12MB5111:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5111A1C81B85598696445834C26E9@BL1PR12MB5111.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UPYWxrXX4qJ39WZ4Ut7z++hVH+Qnxfaz6Iyjt1Eb3JGg2095EE9ua3ARSKKtjk32uVKyTJVaVa4ZNvRqHU3VULfjBkcF70/4rYWX80nEaLj5o/S0VXe2Z0iU1ogL9fkJNjG9il0P33hlcVjSvcS2d9hQulht7mXNzrUHd/fq8gbuBpggUIiI9CfaH77rV/hlGy70t5DzVZQmxYz+c5S2J1BktM0Q9fV3W0q3uLIcFubjGbiWbHK/Nna2w4uO68OjNjU8zGxRwMbsqN/RkMcoT9WRVRaMn8J4ewH6uURik0G996N+J9sONcF72qZm3+de+y0g+v/hS/g/tV+6uJfbm8y6PcPC7uZk3S0c8lLzjXZB0rHn8eOcWzMiRO0AgybEkNCO2OhIIDv4iIdLM50S8Hd9MN5V2wtldUSJZjBhwxoSC93tBayKG6LEXapW+dHMvkQrz49yyrzxpyT+BobtIXi5/pX0C9IohAQabLx+YgrY2loOJoVk0GWHcEoayPigapladDTjIRTsN1cZMSRjVbYcEvs2yz6cgDd7hvXtxsjJn2Ip/Sw5RIO0qAAF3kEXGV3AIVlaBIa8NTOvFGYjNzC77OZOxy+/nSZAAJoUeLQQ7C7ZIll8VJaQLdK5x8otg3nuRmXqfZciKrz0OFmxxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(66476007)(66556008)(83380400001)(2616005)(8676002)(66946007)(5660300002)(8936002)(426003)(1076003)(508600001)(33656002)(2906002)(186003)(38100700002)(86362001)(26005)(4326008)(9786002)(9746002)(316002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RB+2g9Pm6o08wJmYq4Cy+xYHdHlXsW2ol5abylRO0l7hGmQq6eCAlmvVRBNN?=
 =?us-ascii?Q?O4mrl1jQjwf+XfUpzpYFs0BWSPp6WoNLvuJ4HbfGSa5L+hiMhCu0T9EV+ZiF?=
 =?us-ascii?Q?KkO+KUNKTbJAzdFwIrQM5mpjqfTGWIgIa9wg9oVPAeO437rFmu1iCiUKgAsc?=
 =?us-ascii?Q?4kUXcEOc2kNlQPoCVNThNcfess0Ni3UkgqALKqIlqKIX5Gsb9y55J/d7r+QP?=
 =?us-ascii?Q?X7E87PxliTit7uXAzK64B5FXc9nxp8M2O6s0v9K4/nogKOQ59Mm9TWY/XpBg?=
 =?us-ascii?Q?gnNIycuOnQ3//hntvb6lvwRooGFabbKCdS0vl0QHwhzRTxdmaGCqHOxD6O7M?=
 =?us-ascii?Q?2eO8n3GHnBChnYKL6jB5vkI46cn3lRgSAO/oWHPz0pUinwY5NiOD13fOzbLk?=
 =?us-ascii?Q?hno8T+dKck53usuQBwz3cbkmMlX8H3cxrh/Q/4CPGrJHxyLHPIGHwIkVRYde?=
 =?us-ascii?Q?HaNO3gKQGuurnHWxZQY/2nfPVEMU6hTG2dsa2jT2ZEWXnuSNCeUAA5c8c+L8?=
 =?us-ascii?Q?IoFvzmGmdLyq7awzrDIm/CWonEz+R0U1L8AMtS+RYVegJXWVsVQiUtX1uPXs?=
 =?us-ascii?Q?ELW6Kfgg7Drlf8XzssX8l6lu878FYnGfQk1CBPysCcIwMJqL3DWUPvLeH7PM?=
 =?us-ascii?Q?X8MOeTleQNkGA28ITLwwA05oCqPEztMySnKc9c0/+5kYP4VvTzG8vcmV4HK3?=
 =?us-ascii?Q?gg+XvgNvaq7J8fsNSGtIv4mqopLcJb4AYjKY4qt6ZkKGXvh748GYB44Fj4u2?=
 =?us-ascii?Q?RH5rOYlBpin29+BpLKtJaYJkVZHVo4DsfvEw4g3pG09YTH9d3sq3eMTsQI3Y?=
 =?us-ascii?Q?8+gwpNPTqkcn/V3YS2CN+GYWlMlXCxFJxH2uh0/XDqnOV59RhYTSvOm6ATdS?=
 =?us-ascii?Q?on+2SBdVtWiO9qPbO00OGremZYZPn0KYI0jDPRH7MQCRpTT7oP5Sc0cfDLZ1?=
 =?us-ascii?Q?ncQzkCXBqQCnBbu9FqJrF0yHF/SJdns4Ut2ORt15nMR4Cny2tBdlyIV4IOFG?=
 =?us-ascii?Q?30Mh9YzHauLPQv79DbIMKtf9uNzPH8aE/VWZKanThNm7xQcWLlHf1guhXyLE?=
 =?us-ascii?Q?OIt4Kwz+YxlaXDVQVdvsHufojafnhMFoocHFtAViUrvTfWlF1QtGDDZgauvU?=
 =?us-ascii?Q?BiNYs3rl6miP1H/qOPAbKMoon14VFv45OkzjDiyVqF9hYUzbnD7N0ZktIgvr?=
 =?us-ascii?Q?3tLCfTem2e+1BjF9uwgfgq1pjh9HdeQRnyh6jrP79OZ1mmvcucO8inMlXo7k?=
 =?us-ascii?Q?sXkUBLOm/HtSF+hUeR3qeeOc7lcpY2oJMXb5lCpUporQFtcF8Pp0FY91oY0q?=
 =?us-ascii?Q?r31fTl9pFLNRg+WNil7Of9JoBofIVJwuDWF2BPZ8hY5Vu04jyp1bCK+IOwl8?=
 =?us-ascii?Q?6dNMgjjOyaH5kzOLh1dNpZsmQ3kL74O5Y+7Cj/4RfRDlc7aLAqIuRwxPo+0v?=
 =?us-ascii?Q?jV9KTvyd9mYDTO15Vq/idxSbVensderct03H/AlhYAlV6M5DVCBmWvnGg5un?=
 =?us-ascii?Q?mXLa8jbRGyJJvplm85ElgIZTek6CnLAqQ51sr5KNY1Ot67aexBIoJfTl3fvv?=
 =?us-ascii?Q?hwXsgYC8OKp3rHtNqFw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a84162-db65-4fa9-43d1-08d9b9b66bfb
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 19:18:59.7857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ShqAIQ0p3DrOx8De7H9qvIit1+8DfH2atfF3FSBZ3G96wlaiZVlSI4Mkno2pJsHw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5111
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 06, 2021 at 03:12:38PM -0600, Bob Pearson wrote:
> +/**
> + * rxe_pool_add_key() - lookup or add object with key in pool
> + * @pool: the object pool
> + * @key: the key
> + *
> + * Returns: If object matching key is present in pool return
> + *	    its address and take a reference else allocate a
> + *	    new object to pool with key and return its address
> + *	    with one reference.
> + */
> +void *rxe_pool_add_key(struct rxe_pool *pool, void *key)
> +{
> +	void *obj;
> +
> +	rxe_pool_lock_bh(pool);
> +	obj = __rxe_get_key(pool, key);
> +	if (obj)
> +		goto done;
> +
> +	obj = __rxe_alloc(pool, GFP_ATOMIC);

Really try hard to avoid GFP_ATOMIC:

	rxe_pool_lock_bh(pool);
	obj = __rxe_get_key(pool, key);
        rxe_pool_unlock_bh(pool);
	if (obj)
	   return obj;

	obj = __rxe_alloc(pool, GFP_KERNEL);
	if (!obj)
	   return NULL;

	rxe_pool_lock_bh(pool);
	old_obj = __xa_cmpxchg(&pool->xarray.xa, key, NULL, entry, GFP_KERNEL);
	if (xa_is_err(old_obj))
           kfree(obj)
	   return NULL;

 	if (old_obj) {
	   kfree(obj);
	   obj = old_obj;
        }
        kref_get(old_obj)
        rxe_pool_unlock_bh(pool);
	return obj;       

If it is very rare that this function would collide the index then
forget the first lookup and use the cmpxchg

> +void rxe_elem_release(struct kref *kref)
> +{
> +	struct rxe_pool_elem *elem =
> +		container_of(kref, struct rxe_pool_elem, ref_cnt);
> +	struct rxe_pool *pool = elem->pool;
> +
> +	if (pool->flags & RXE_POOL_INDEX)
> +		__xa_erase(&pool->xarray.xa, elem->index);
> +
> +	if (pool->flags & RXE_POOL_KEY)
> +		rb_erase(&elem->key_node, &pool->key.tree);

It is a bit jarring to see these as not exclusive ?

Jason
