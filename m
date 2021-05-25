Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1CD390CAA
	for <lists+linux-rdma@lfdr.de>; Wed, 26 May 2021 01:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhEYXEg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 19:04:36 -0400
Received: from mail-bn8nam11on2054.outbound.protection.outlook.com ([40.107.236.54]:24739
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230103AbhEYXEg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 May 2021 19:04:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnuR3HfF1iHYZG48mDZ7AmkH6bTC2acxmYMVtedS7LWVAWQaQaNdcel/RnqmoR4EGI0lI8JJkcks0tgDWK8E8VWywm6/ZKYjQkP+8IEw+aFqwsdlZ/CWes5qekb6T7QKJmJJhruBqncNdDchJhWke1SLIUPhBSrgQvwuq4xMxLQ1OXHyk9FVe/oTtBnHNH5/nFpuW/HMWBScFdW8roztH4oFdl1giJeuEkzngzD9rROkLgMiqbpBkw62E7OvTKs37lfRx/8Bxxj9nSqwvJFt5JfXcndPwa9DGs4tvkP2PKwr2yF2Y8USAdTOSs0VRKaHn1R1CtB19MXCYKR3w21gYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNwZlrPZy2+V5CDYlXFqjImWWPfZXm7Ne3LWU7mNKrI=;
 b=WA9qVvkvCYHLwM7CyZT+DZZa1xAOtQndELbKzav8gIPMj4m3LpLXnyBw2XF7JuB2Xrb/0mUwV7avdZLFJjAAB2dPlLdUAMR9qOyle5iQOAH9zIuC0RKsZx8GlfePHVkEivbr4tuyElvX8bZdK3W8pb7i3G5qEqVt0I6kOxnN1TuHh4TDvFReC0S8qDA+8tRwgVm2WFOiCBFRWhsb9KChmXr3yBIDdnubDU5YS5+E+x02skELK+no4+/pfoyrIJ+s4kVaBegmIMwLNuYAQMTbrB5UkhcNFstKoRWopZXAT0e4pToI9BCxf7oyVeTzU/VR+AKwXhpyyzdJu/lP61Qazw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNwZlrPZy2+V5CDYlXFqjImWWPfZXm7Ne3LWU7mNKrI=;
 b=ub5MT2YPneBjrK8RcYLza/6LHSN66MDKx/efsj4X1UzoXe4Qf2oAuZYKmWLaD6UYTsxYACZBM3OwHAxg1gTjtw+G+Ne5um+dlNDheA7PgdxrjeNjcskxc9LjHxYR35ve6FNEL40GeOmjMlSZEHSlfJ/9S8Vl04LWh3u1mV8jufZFDmA6HxnGz1UTu1VZ8WvQtT7VJJMRrLRtpCDzD1cM4QFowLbs41vWr3s2z62ZTXwPq5VI7jzQw9+BzLpC2WiicHV8qRV/du97Rz/0OnWno6m6u2V8g7yiGVqoySsQ/WsZ9ddYFq2oSSKevrEroL+FwXuzAFXQshUSaIbTkBRNjg==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5048.namprd12.prod.outlook.com (2603:10b6:208:30a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Tue, 25 May
 2021 23:03:05 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.020; Tue, 25 May 2021
 23:03:05 +0000
Date:   Tue, 25 May 2021 20:03:03 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyj2020@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/rxe: Fix memory ordering problem for
 resize cq
Message-ID: <20210525230303.GK1002214@nvidia.com>
References: <20210525201111.623970-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525201111.623970-1-rpearsonhpe@gmail.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YT1PR01CA0110.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::19) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0110.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27 via Frontend Transport; Tue, 25 May 2021 23:03:04 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1llg4l-00Eej1-2v; Tue, 25 May 2021 20:03:03 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f06a86d-9ab5-47ec-013b-08d91fd14102
X-MS-TrafficTypeDiagnostic: BL1PR12MB5048:
X-Microsoft-Antispam-PRVS: <BL1PR12MB50486F113AEE5F4B353392F5C2259@BL1PR12MB5048.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fDTJk7x8LPI78x7Zu0mBVh3vjOa0JFnnOeWkRL35nUiMRmRv83YG2X2eEWyYHqHX4grub3acg1mCsi0rT1MLG6t5GzuRizSA90b6Ki0RtnyZhfUmoZk8ZdfVyo1KJWtAnhlkafjlhevPFBHqR/FafUmZgY0ap9VDH4CKexpOM4khOcRafXLLPXodUi64wz/1gB952bPoZo0pYY9jgn+VkPoi/Tl+zRBpXFPYon5+b1CBdb588aOS2a5w9YobDUnWuO3XtOS9qt9bQKpnZdhGiN/W3H9gde8NXkKONRRAwE6p0qqQExTXezsg9axLCg3sw7n2ttMEMP4kKfjaBQn8nE0sHT2NAZoRe4LgvH9c8chqb7hdYJRCHoMdKZG+0+iflK/jHhPTjWlFhsODwidfw6HGxExifBGVCWMuyBe+rAyv/wGc6LxyXCHlyv8ocj7SB/ueZi/in+my09YIy/yfrxfpKgu6r/jtzbFQG2OzTcm60T/j6HXVADcgUwFD5kZRwZcCpPHQESquz12ygRLRPntibcQ+imx9iV9DhGRqN0/ve360s1Krzj04LVDElcp5q3PhF8AZz3zwxubtm7fGocK6mPa5l8KoM4C2gyC72cs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(376002)(366004)(39850400004)(186003)(4326008)(66946007)(316002)(2616005)(2906002)(26005)(9746002)(426003)(8936002)(38100700002)(1076003)(66476007)(66556008)(5660300002)(8676002)(9786002)(86362001)(83380400001)(33656002)(478600001)(6916009)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?DySJlJJ1pm3WgrIt+6yN8BglkNooqXabXKWPl+edvNaWuWwdBKAOrJj4a52W?=
 =?us-ascii?Q?8IdRzSc62YAE3gH9fO9cBj48MNOW/0dIbUE/wafkiOeL1ZJIhCHYwzb3R6Ed?=
 =?us-ascii?Q?vRupcuhDK0n/fyjapNdE6l5WC4M+LZp8LB2TtDzsmsckFco3YKJglypj/TNU?=
 =?us-ascii?Q?WpnVtmhO5cLpXrZyI830rpw70crSXAv9wN+xtefodq8PwcfnbpwBHwcp1Lrd?=
 =?us-ascii?Q?+nbx0hSQjPW0zMbckO1+8rz4ocd3Zi1dq/5isEnj1C45nO2uZleMonYGUnrn?=
 =?us-ascii?Q?E4h9rRIVzRxSNIoHaglKVTiryEdjAv2ZT2tXoPSTUZIxZNlg7LmKGVAec6Gh?=
 =?us-ascii?Q?URUq8tmqOx2F3GRVXovwja6tKRW/Kv5tmEIjeg7SxFufAhpCr7ZCnlQRIcf3?=
 =?us-ascii?Q?b+dK2BHKq/smMJIzSelGKXsV2AbKxIMdbrb3rANTLzfciXXKYT807+Nt5IAU?=
 =?us-ascii?Q?aKfuGK35O3/2MRtjG2mj2XvMznSVOdvRhzpegjdLw1Jip0qQmmsVG7TZlJMc?=
 =?us-ascii?Q?4b0KYplt4dnkIxkMD3nIkQJRCxAPZtjtxSp3Cc8mNeDkwu8/WRc0sR8DXCPH?=
 =?us-ascii?Q?IPrs5Kgz6bFMdnq4ECLXjxj8MhxmUIAyGT8i7zm2a96Z5f1umix6RPe3UoSn?=
 =?us-ascii?Q?/91oKFZ+C9BGFKdXWWy6Kp+Xu3TO4asb8bnDPL7OOaRQUMgnfuqG9Mqn1BIT?=
 =?us-ascii?Q?kPp340kcoYWs79j2sZbwV5aoCzAU65qorCqkEmDVA0hrL+5ViufUe5EAE3UN?=
 =?us-ascii?Q?f382smn5GMiDUfMVYbEZWO2522rRc2lwZ47n4spyLt2EfSwrjMfZkWomf6OA?=
 =?us-ascii?Q?SJlY/2yJ4nVDqw4KDDmZtR/CqgOzvGs9h8G09dg4pBdIMvXSgmKu2URLEp88?=
 =?us-ascii?Q?pWsHEcIrA5+luapKWF54gM+o3NdIsAWHMRJKVI+BqL6hKqnpOnKMVGd63v69?=
 =?us-ascii?Q?BB3nEAsuYXNLGZYiAfEpWNlJaiqTVyQ6xYQc8MymdWV5Oxz4RGdBp5OfF5Jm?=
 =?us-ascii?Q?R+OpJhs7J8JhbBrd/jkZX0ifr+EifJzfR4/PbI1Xum3lBoojoNSkVjxEO9cq?=
 =?us-ascii?Q?wBVwazgTmScmHDFyktmZ6zlVvdSEXtKqNTzY5R0ViMl6d7Y/y1WBjR6Wp4HQ?=
 =?us-ascii?Q?a7mnIsC/DC8DN/4Z7o9L5uYuiG2HEeicGheHcR3B+0/mpTTW4kVWwwacIVCn?=
 =?us-ascii?Q?uoN/PLJjFBvVQU5NP9KgFT4WerbXSu3c2E/8GksW9qbzybEvtpuQRiVh/ZKk?=
 =?us-ascii?Q?l63hr4zCEPrYkvvtl1y3OwdeNrm3Iohv+Eu6Hss5P1Ov80XOjQ0QGG3sFZrK?=
 =?us-ascii?Q?1QhRhZ1KBaJEY+kgw7HUUH5O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f06a86d-9ab5-47ec-013b-08d91fd14102
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 23:03:04.9629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rkdiXdb/fohIj1d3QF5VODnTA4Dz2mZc3462sVfPr18Tyn5HbdwHeWa2wzTinAq+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5048
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 25, 2021 at 03:11:12PM -0500, Bob Pearson wrote:
> The rxe driver has recently begun exhibiting failures in the python
> tests that are due to stale values read from the completion queue
> producer or consumer indices. Unlike the other loads of these shared
> indices those in queue_count() were not protected by smp_load_acquire().
> 
> This patch replaces loads by smp_load_acquire() in queue_count().
> The observed errors no longer occur.
> 
> Reported-by: Zhu Yanjun <zyj2020@gmail.com>
> Fixes: d21a1240f516 ("RDMA/rxe: Use acquire/release for memory ordering")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>  drivers/infiniband/sw/rxe/rxe_queue.h | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_queue.h b/drivers/infiniband/sw/rxe/rxe_queue.h
> index 2902ca7b288c..5cb142282fa6 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_queue.h
> @@ -161,8 +161,22 @@ static inline unsigned int index_from_addr(const struct rxe_queue *q,
>  
>  static inline unsigned int queue_count(const struct rxe_queue *q)
>  {
> -	return (q->buf->producer_index - q->buf->consumer_index)
> -		& q->index_mask;
> +	u32 prod;
> +	u32 cons;
> +	u32 count;
> +
> +	/* make sure all changes to queue complete before
> +	 * changing producer index
> +	 */
> +	prod = smp_load_acquire(&q->buf->producer_index);
> +
> +	/* make sure all changes to queue complete before
> +	 * changing consumer index
> +	 */
> +	cons = smp_load_acquire(&q->buf->consumer_index);
> +	count = (prod - cons) % q->index_mask;
> +
> +	return count;
>  }

It doesn't quite make sense to load both?

Only the one written by userspace should require a load_acquire, the
one written by the kernel should already be locked somehow with a
kernel lock or there is a different problem

But yes, this does look like a bug to me

Jason
