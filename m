Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290653444A6
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Mar 2021 14:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhCVNDZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Mar 2021 09:03:25 -0400
Received: from mail-dm6nam10hn2207.outbound.protection.outlook.com ([52.100.156.207]:1889
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231674AbhCVNBe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Mar 2021 09:01:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COMn0351I0dC6/6eMRwzCToJTPd1jY5U2xDoKg4NpIByo9sTSxq+c2vnbkF1IJspTNzz6XB8TgrUp8LHkMKoJL8cD1SwP4Y8kX2hH9ZMys2gn4SeNeBYbudDSLT0w3bHu867dbmOxsQslyuAPv1I+1TIaBk3vFd+92NBUsRVGGyoREhsg4241mZ8IXVo3jt6yfNIBsAdc9BOSkfnVycohLQqm3R3bRW7SRbMTjIA+occ/X9NeFK4nDnJcULbbG5CY1IGRWAhbORqgc9NBO9gaxQWjOgYOcGcQvFYD0XkAoA1qGg5cmq9nW/JEqD/LXVXGNMtnaDAB7RGYIelHx786A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l25AIKEfT23hq45IU48kNRyXVpsuSp5w+iU5Q2XWwO8=;
 b=HDf6zsFPA0whQSGCofP7wy64T42LRWtaGQlSDIJy+INNul+37X3lZuS+HZDNauMDvs63FP1LTvRMOoxsIkQ8QajKyfk06e28JSHNIac9LCNJ8NpWGfqpcjiYwff+qcbJ721wjraj9PTR+j+uSUDXcqTRnYQ1IAeLycF1L4ab41wH8Sd8Wgb9AaGLRl6Qm0ZAKmYgpxzTKgJGrGAbDQ+YAiK5DlZI3RWBkRLN9dwuLidwGRdGk7LjJh1lgVAikqjAuE4gEf3pyrw19kfopn+swh7w3DaxSRdZeeTzmKu/gXEWZn5x1kkhtBsGgfV8uxbCzk/NWK3bV4h5WpBs/Ewfaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l25AIKEfT23hq45IU48kNRyXVpsuSp5w+iU5Q2XWwO8=;
 b=i/faXUlDOFzGMKmCrniD5Mrw3cRzTOc5NzWzRQoKzPmXTSIxD3sML1ddQiWgDe4A1qbop1oNHNtSFQzV+AWeYu2AkTIgINV7zGt3X33XRbAxEzYNskNi3nizfOf9GYwSonenyfIY0eg3fJsPB6CR2y2lWKxnh8JvNCxF0t+wPPvJLXzO6RaLMb+NHw4zdjC9BsfNev5Lr0vCkAy+FWJJDCp+vSvhBH/BVHzdaB1Aup7aaTaUhKQ9S8x+f3NvWmsbBd+rA2dd3+z3JnP4/2Fb8YYKJ3Xb+gQdHQxfjVCaIvNyTPipjWbErtyFq6DgBI8qlUd8serjuH+p9gsh6LhXGw==
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB2489.namprd12.prod.outlook.com (2603:10b6:3:e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 13:01:33 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.025; Mon, 22 Mar 2021
 13:01:33 +0000
Date:   Mon, 22 Mar 2021 10:01:31 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Use strscpy instead of strlcpy
Message-ID: <20210322130131.GC247894@nvidia.com>
References: <20210316132416.83578-1-galpress@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316132416.83578-1-galpress@amazon.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH2PR14CA0006.namprd14.prod.outlook.com
 (2603:10b6:610:60::16) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR14CA0006.namprd14.prod.outlook.com (2603:10b6:610:60::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 13:01:33 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lOKBX-0012ZO-Sv; Mon, 22 Mar 2021 10:01:31 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4cb47d3-78de-4ac3-ad4c-08d8ed329e3b
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2489:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2489519166B3049725A7E90AC2659@DM5PR1201MB2489.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AezNfwmTulong/9O23fHQPjPYQlzz/tKjkLmfDscD62P7TK9ZsyJGzFY0BrX?=
 =?us-ascii?Q?lu+r9n6JIK1zlN3m5+ZiT3S9IwGez1h3KFdtxyUCyEc5npsWSilHT2KjRlw8?=
 =?us-ascii?Q?Bff4lZJMs7vumrqhgdhX+m3SZM8YI6XvB1+8NNghwQQW50qzvgtIfY83Bufi?=
 =?us-ascii?Q?YJ+cq+87fR9u1lgYBa5XVY5i/yHC+OjGt0YJOl1WOVDNuF55vf2vvbwI9LrE?=
 =?us-ascii?Q?sFIIO9d1ppCRndcFHWziN3uOqsmnnv2DN763NhujqqyjJ8ONSxcNGnFfW9Wj?=
 =?us-ascii?Q?kaJRQRsW7OG2ri5WKqmLzQtd12Szz1qs1EvIY9yQINfvfafnPUTL1pigRVVV?=
 =?us-ascii?Q?3lZJgYUYAlu+s/9QweLpgEsJyMhLkNKtXAdT6nKSicGKS17vGq5k+PrqlqPL?=
 =?us-ascii?Q?tsIe1YhjyGSs5Kl/Et2GcVESND3+2OURQVyPPV+edKXJdcbOSg2MCw1Y6R0k?=
 =?us-ascii?Q?ckTodgi1h0MBMOmVu0F8r52IvS40UJTnAxIbzAqoGfV4V2QEBNf3TU9mv/Te?=
 =?us-ascii?Q?9GmLgBd7cOrr8/KxgQo2Qvvedw3FSObRjRa6luJvg7yEaY2LKzOVytqs3Ihj?=
 =?us-ascii?Q?BK7gto3YEZlF86qrSy1esE0dLaYwiNKxVjdQXIBlsC9UCBFu6oqVYpkxKHzG?=
 =?us-ascii?Q?n9Evf4kniaT4FYexwnuC5JkODmqxmq0lDBwTtNt8BqHXINoUy6aHyoUGbKU/?=
 =?us-ascii?Q?X+u+NpM0/rToWRHAu93KkWNcSJBF8Iz9+3RC5+dMoNLMhedLRtuZdz8g8vMy?=
 =?us-ascii?Q?/3CKhFHhrN8QJ12O3M4HIMnNgBHtCKTff6s6XBdyE4PSMXtTiy7Np+q69clG?=
 =?us-ascii?Q?epNx2RLpboDOolIaqBSgFXORYDg/p8JVVpVdJTAp+8k8TA0dSqGOwldOngV0?=
 =?us-ascii?Q?qOnUg7ESy5/u+vmu7Fn0oWHA/JGw+NLYZHAiYdzMEiAFL/sQnGHh04nEypDi?=
 =?us-ascii?Q?ytSdZzI5abeSmjHk32zA8yPFGxxVSsigmdXWVPl0xZsEyznKDXedBHogvOQG?=
 =?us-ascii?Q?ogCEi5tX1N6C8v/5VYbu3+zpIA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:OSPM;SFS:(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(6916009)(426003)(8936002)(36756003)(83380400001)(38100700001)(478600001)(4744005)(4326008)(5660300002)(1076003)(9786002)(9746002)(316002)(66946007)(66556008)(66476007)(186003)(54906003)(26005)(33656002)(2906002)(86362001)(2616005)(8676002)(27376004)(156123004);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?s+WLURPGDo1gRlsq9jbK7BCmvYQvC6fD7Zc/nZNKBSD/4Njyq2TvNBeHosPE?=
 =?us-ascii?Q?SEQWmnin+KzYLHSV9vSbcumVLz0T03ecFxonUi55JMyiFonG9+/stQ06ckCE?=
 =?us-ascii?Q?y+Kw85dqv9JcD61IRgF6Tt48FqfJaBnIvweSLPshnzeyPs1Ac8cjPNazywJX?=
 =?us-ascii?Q?nDJI7vvSEEcYClTI6EFJ7sY9DzFbTIT8voMO9Dddx5Aimd6Gf5J1cFt1K+xS?=
 =?us-ascii?Q?A8QTi7ll8pqQ1p10NG06aDfTF9Eh1R+tVo0JBPyr2NP2u/F+QnaxoccUb4WY?=
 =?us-ascii?Q?gV5V8nL1mGuJrTfFvurHsKxWQz2TBLXOs+w+FTikLf6ej9XWSOZF+IysgDZo?=
 =?us-ascii?Q?cCXqclqUi8UaNjh6Fe36cuPnDRRhfJifB6ZQsiFFJJG3SEshuP4QUTg/Ttv/?=
 =?us-ascii?Q?6M2ZwlohRwcsOWdXWtFZY97ju+7FtNVPpwZLAsAD0IZ/j4oKmIc/swyZYRGc?=
 =?us-ascii?Q?jW26odunA/BU+vuXpsrRXPDkZcNYp3y54KmMysueWur14Z9+5LNbZeQxEZYD?=
 =?us-ascii?Q?pmhn92dMUZ+BuD4pBv1tyEMGEhhDUGxWZJwhnlffPwG1mgzn36X8zOCpDPqi?=
 =?us-ascii?Q?J5d1yvYj2oEE9V/JyWvrYmK1Eg21yp2dzmSi32hK/u7i7jy0Xs3DnutLQXPF?=
 =?us-ascii?Q?olhZGYaz1K9ijxRe+0cv5ObJ0LdkcevEbVS+eEZjrpmBFu9CRwiM8Y3GHcNK?=
 =?us-ascii?Q?i5UlMlxwnipwLIOLVr+0J11IwIKjbpJoC7TsTLUIvNDjLQMIxQ2g281m8MaP?=
 =?us-ascii?Q?lWt+petJ8MLDyf/793clu1P8FicQSANJbpCi9+JpCfzAFg9nkKKYwsBWhET1?=
 =?us-ascii?Q?RcsickpLC4Yg3UHou6+Xfj1D1KU+ZfVugxNjGdQwBFwrdCHEUOkRc+3SucIF?=
 =?us-ascii?Q?5zSellcVJXo1mJah61yVDGUB7PalqlBD8xvdJ9RzpRt/b7zd0y3GSpCg7U/k?=
 =?us-ascii?Q?PqB6vUgi2hTY0trJNwWGdt1ipL+i8ciHmM2hH/kdu1BgtGBUJwmXlvga61PK?=
 =?us-ascii?Q?V+oBHq7e2tp7mdde2dLvCdYkGIDd1hbBjDqKAAKMaQJISQNhuLcbPSyJbuzY?=
 =?us-ascii?Q?51U5Un/iio9JQMMxTwApoEoafk2nIxsshM4Hft9wLHyZnWbiPAcOh7DinvoU?=
 =?us-ascii?Q?dUHZYmdDsAZKKmA67t2qRdnhJqXofEL6yeNfLAitwnVeO3KzGsP2SoueLZC3?=
 =?us-ascii?Q?vmV8aVf765X5ISzMhu/AQfneXrJL2tpIft+iUc1Oy5qt6MSi//PhDwDeGpcp?=
 =?us-ascii?Q?YTOBke2cCcIEj9Z32TaPsWjfeDmdOzIot8FXqIve1kKMbehApPLhTlIruQX0?=
 =?us-ascii?Q?X2kbjlqt+/W65kUx6rgagqf5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4cb47d3-78de-4ac3-ad4c-08d8ed329e3b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 13:01:33.4922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R+MrKNPDkWBPJIQb1PzGmlQby6kvMjv7c9dTLbznxcaad9LriL3Ow2xPd/Kbag47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2489
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 16, 2021 at 03:24:16PM +0200, Gal Pressman wrote:
> The strlcpy function doesn't limit the source length, use the preferred
> strscpy function instead.

Why do we need to limit the source length here? Either this is a bug
because the source string is no NULL terminated or it is OK as is?

Jason
