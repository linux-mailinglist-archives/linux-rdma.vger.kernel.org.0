Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C30394931
	for <lists+linux-rdma@lfdr.de>; Sat, 29 May 2021 01:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhE1Xng (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 19:43:36 -0400
Received: from mail-dm3nam07on2044.outbound.protection.outlook.com ([40.107.95.44]:19296
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229559AbhE1Xng (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 May 2021 19:43:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9mHqVJ4yp6OuH0uXeghyMSDt24LHevkjpek8kyBaDmNYSwacx1ODvdFyH1DCOapCbi+Ow9qvJ4+KFZJE5HHsDLwq7+HJu18QxwyByU6DZqgwYG1kh4qJcFmyAwafr5lJtJaRlUggAXAV/u543Zite4iFs6bqqR8ZqeB6se9Gqsxd5EErR5kcIulR8ihJIiiOycuYPFgyxpCHpQfwzcxrRWnhVFkM62B4NKsRB6qV5+9M3oWM4dR41BTBHnHq40YPN0BaXA+lWpa0Fhex768JbWSPzsIQRNl374lQBV0z4iDDi6OMAVcLqsE5qY03/n3Ko57S/zIXmk72xuho6UrtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qj0DJzhVjop94eZGwwbXhamODQcG38BQg4e8Pl52yTM=;
 b=m1L561V6Rov2k/r+zNy+VwsF5pxE6RFJ6QJHkI/45YRBENhW0hWnbRBXSNgoUJd0wscjoK8GThr8uVp2P9RGfK+cgNOWXsEDhUhmZ7kLThjeWeZ6JK/YV4OXXcv/ounQLNMOvEXILTto5X51Fk2d98dOcmeFfkiL0OPObib9SBMXEAJKZ4H2dFmVZhSMB78pjnV+WMveVbUWOiIvhDE0L9RS9jmruzglms2U66LCsC/aNoJqowMcgyzBGWw3YiyYo68PSAVxgU+xqZgFW2wgMpsllS7OdDqLx4ylGJKBncpdvSA0yv7uc0tvXZPa0x2etOpIsYPmW4JvoAaCOOYL/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qj0DJzhVjop94eZGwwbXhamODQcG38BQg4e8Pl52yTM=;
 b=G+sYLjoER8Bav45AkkZv8Dbh8j+R8Mvcm61sD158m20Wl7wZ29ANPeBgxElXtFuPbN4vylmn5uGaBmVU1G6Lp18uOPxwcRno39YYGxG+83F6QXHekJXiaRH8TOiURnnNXPVFg9qebAWNb0S1SNHYNc9XeYkNxUywOjicYKSE8k/u+V69+/ih9BHY23qMU/R4buT6PNWpIRGA00pphEA/l9619DYGq2CvL0xBXOs6cQnDNZ00RZUag72jgYd8Ov+Y4lkKGwVbJr7jKFnRUWce4NEDOjwONtRVyORJmamjKoSjOKG122hy66UdzjqvNA3iBNiLLPO3gK0F6PsDqi8nMQ==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5159.namprd12.prod.outlook.com (2603:10b6:208:318::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Fri, 28 May
 2021 23:41:59 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.023; Fri, 28 May 2021
 23:41:59 +0000
Date:   Fri, 28 May 2021 20:41:58 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] IB/ipoib: use DEVICE_ATTR_*() macro
Message-ID: <20210528234158.GA3874396@nvidia.com>
References: <20210526132753.3092-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526132753.3092-1-yuehaibing@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::16) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR07CA0006.namprd07.prod.outlook.com (2603:10b6:208:1a0::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 23:41:59 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lmm74-00GFvE-9o; Fri, 28 May 2021 20:41:58 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83a756e0-9488-42a0-efc6-08d922322fa5
X-MS-TrafficTypeDiagnostic: BL1PR12MB5159:
X-Microsoft-Antispam-PRVS: <BL1PR12MB515904F1FE22108A5F2D4E47C2229@BL1PR12MB5159.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t2bAk/OEuielAXzeRyc2Ph0pqx26Gdi/Heh3C2zOzdWk3gFg6+OyzgEM+HMa/3A4Y3+PKAVAIH0Wzk7MAj0VwcXOJBBVWkxAUtJjAStYZRKDOLC2PdLxzASRA0bpFDosmN1h3EvVdYm8UW8/hfS5QlQMPOqD9quHcMS5ppdsUeUM8ZqfZh7y+9q52pCsKEALo2gbJ1mya5J+T9d+Wyo3TpXb5AYC7J4ac0jUuEVJ5IqMLWdgV6viR/5t9MYnJ2AcCW9UGSFnnY5h6ZFvIsZYfUvFZFbDZ7cUWjHokKquaaedgqbIFjXlJ3SxkOZdm1c44QpEDZ3X8JxV5UgLSKPjPbO6dP0mWqd0CEHI0RvDRwnnTGYWsn2t9oG7kmO42flcxtq3RuyR5ugZnXJlyT70MowjTAkd0xnVMGRdZ2NZuOVe7uuuvthjNvPjbX5UtV/VqlrH+h32DMK/dFhwlsWbgtX+qQWCMw1q6zlUuPIYTHw00ZfqUUKIr0cVOjFkJbqpRmUkM0Oe5a2QQ0WyKsy3J7kpmP8R0coeA4KidB08r7av8UGebUZJHmEE9kwVQhEbE0oHXbJ3bXOl3NLNqb0Yr5drZiyd0L6ji/Qt2SG3uzU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(39860400002)(346002)(396003)(86362001)(83380400001)(8676002)(6916009)(316002)(2616005)(186003)(2906002)(426003)(1076003)(66556008)(66476007)(66946007)(26005)(5660300002)(33656002)(38100700002)(9786002)(9746002)(478600001)(4326008)(4744005)(36756003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?z+WwiIWTFTpKk91S7+51ThJXsnWzVca3f2evW5yARjLOSu9Hr7q6hjP/ULBR?=
 =?us-ascii?Q?yt7URfxpXc8PUKL4Qms9FefoRB863vvMF/Mf2Wt2Pa0EiqX0iXYwjcFvZvS3?=
 =?us-ascii?Q?V0+DC1kh17JjtjWflDHaxp0BnwrZKKJuhSbP22mHIz6vm0V+cQFNdfuxNeKI?=
 =?us-ascii?Q?aAg53dYSzGiwIlbw5fTiuKuP5SFqMN11SLuKJM/jtlduEzPVEi+O1Snhc1E5?=
 =?us-ascii?Q?kf1YtCeR4xge4Zoku+v9c0LY0yDFAcDl+WCxCU+4NCXcjNgBQ+24SPGH7eag?=
 =?us-ascii?Q?p4EYP/WS4/fsW7fWwLRwTmFAG8l1EGCdxpzf1IVIPojnhTHpNNsMKfi2+doe?=
 =?us-ascii?Q?n+LImGOwAQejftc3QqhRomimKoc0PIbGOmRtsfQih5lS78hWnWIXYBQZ/fi/?=
 =?us-ascii?Q?oBt3oEON+jSvG+nPUdOhYznhpPXEXYbvdSRKF/IgkM7kPN3qmz52XLulvRTm?=
 =?us-ascii?Q?IaJvyKqj6gj1VyqtcDiR3Oc/w3FgWDPQ2DjZSqLjyB4Eme3nL+fp7Ho/Ww6K?=
 =?us-ascii?Q?WBVn8V/2kmglL07LdzspzNt3gZpxopwtp9W6Ym1tfpFiIjIBH+Slkel3g0Mq?=
 =?us-ascii?Q?X9TCtL/PxtlijH07OH4NivItIn4QvdRdNwtdQB1Gu6NVU2fCCExaxUMjU5yk?=
 =?us-ascii?Q?qHXGBqLrqqucoYllQcUa5bIB9lS/BTJJN2OPC1ApLEvI14NxSBttSk85CzfP?=
 =?us-ascii?Q?rDrwgyBN0CJSm+UKZsyrK6u9nKuFP6hE0Vqge9VBTRSmsHhqt3bwx182yIMk?=
 =?us-ascii?Q?JE7vy4729sgpiWXySlk0XcgLU4htHoAky7UaYK9/1TBOebUgo7CXwT37T4F8?=
 =?us-ascii?Q?9hv9KBHg7UlmvetbW0BlnOiL6r+yGc02Ywe+Q5G6c/EH41nqE1g2uoTqXAtb?=
 =?us-ascii?Q?pKNeoOq7mOtRB907ZU9qNHLq0LQbR02I1r478adv5PLVtccupav8qPo9ByWV?=
 =?us-ascii?Q?DmXYYytm2RM5neffHP/Jauxz9Wdzir3RTg5UTqxvkJtiX9zHKrKChlCzCMuO?=
 =?us-ascii?Q?W0mLs4dYPM7JKPjjfiKibdtGpZeHdax2g+ZnVJnY3zc57zHTzRVKpmY1Mh1E?=
 =?us-ascii?Q?Pq2umod8W43/PIr3uUc0XLISP7pVFPPqD2J4dD+KGPNb5fdAeCNzFysiha4L?=
 =?us-ascii?Q?9yWYZRMzEUtfk1RPDdZwE1zU73jVKp6ACI6ZxwNiZYRZeueN1jUqdcrYzIen?=
 =?us-ascii?Q?iDCPDaeKVGddEzRNuqLE4J3ZpGzPt628NkYLqDeOazjeBDCoRSIhslQiJIUF?=
 =?us-ascii?Q?r/XsdiCwxXifxIXUFmWXx8M6q9FK1OCSGOUs5fGxZ9Ztnb+7hONHjPQCrcIz?=
 =?us-ascii?Q?RsaNNMLiGmPmijluyGj1M+z8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a756e0-9488-42a0-efc6-08d922322fa5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 23:41:59.4571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpCykqR9JIGnY3R4gq7YJE/Trp1A5GtmbqDU6tl9MU9vPimNUdiSs42cCFJ4p9cx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5159
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 26, 2021 at 09:27:53PM +0800, YueHaibing wrote:
> Use DEVICE_ATTR_*() helper instead of plain DEVICE_ATTR,
> which makes the code a bit shorter and easier to read.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/infiniband/ulp/ipoib/ipoib_cm.c   | 10 ++++----
>  drivers/infiniband/ulp/ipoib/ipoib_main.c | 28 +++++++++++------------
>  drivers/infiniband/ulp/ipoib/ipoib_vlan.c |  6 ++---
>  3 files changed, 21 insertions(+), 23 deletions(-)

Applied to for-next. I touched it with clang-format to fix the spacing
issues.

Thanks,
Jason
