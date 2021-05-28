Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881F7394935
	for <lists+linux-rdma@lfdr.de>; Sat, 29 May 2021 01:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhE1XoL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 19:44:11 -0400
Received: from mail-bn8nam12on2077.outbound.protection.outlook.com ([40.107.237.77]:24033
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229549AbhE1XoK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 May 2021 19:44:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnSKBsNWkktNUxmhavFm5LvwMCtr6ayotHE9G0Qua0is8jXOjU7ioRVn8auhGrNw0AplOKVHW8dWf1NDd2GFFfYcvpCxnfBdGd0N2jLeRoo2P5aYY6o1Xt9nvzF4ZsNdJbGaj4/6C/Pq5fS4KNRKubN9qKVT55ABO4CfRB/vRqWeSWtgnW/99U+MkG/oPEpkYm2P7GdIAvgmBjkH70fhcwXtbV4zeteSJ9xk3rOQrMlHxAKYqU5YNw0fL9kE61tuD5aouD6yaqu9ENuzp04wQhJXgDqeW83a7IWIlnXmTH+MVfARVWIeBu2uVddXDBu2CtJWzvAMh+YO+IMNaItSPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLmjvlO1MTD6wssDJKXmepYd9W+CdRRsYZOAP57KeCk=;
 b=G9JSmRVUYcoTkoK+YSWDWAAv5Kv3+gPYElDptUpfJ9GvWyj9AdOY8p+Saqvs51bkqJLGOmGfimDeQSpDCTXN3x+B3osaBoklmRjXCYOUFoWefh4hCQ4lh8qt3SO71hGlsanXDGKD7H30zwhYQOywqshtICYyUVp0cZmLao0rlQR4Gjr0H54eDN0dFK1D9qulgJirGVjc8dTZs27NXWIohXfwHK/riEAK75GlUwOVwkX8IPpWyNoRxAhNjHA+GsaJwKz08OmU5uyY6CnIAg2m1jvS6ICbxbHDJpNQiKG8PioXVa6jSuw0AkPyZbK+Q+Bb2W0apn0n9CkLuk4q8YXqTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLmjvlO1MTD6wssDJKXmepYd9W+CdRRsYZOAP57KeCk=;
 b=R+4tl6yoT4Wl7NP+59zZ8UGR6u9KygV167UFxTMKIGGUtVeGvYTshEryFK7x3evMwYTwA4ArkTyBxcuE7kREsn0to8Ls6pVkIToMSL9pHCvHZaj/Vc9H1IGOP6a+GWwWpNeL5DIt5E0jSiJjlWzaEvgqFPPoRQQ/T4042jaeBNijinlHjMAIUmD43pg9I74gaWRoYDqacYiVjRVthxxugXva9h6UvsREEdBbmwo/4NUFvtsbkWPLOp5s1MYsdLW4WljwqHAuJSNaSolbQ9JBXDFksJdWkTw1tQSMptTX0JKx3rOeB1xSJMxi1ajJtUECw7aCyy2mZKSS3E3xzhJCYA==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5159.namprd12.prod.outlook.com (2603:10b6:208:318::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Fri, 28 May
 2021 23:42:34 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.023; Fri, 28 May 2021
 23:42:34 +0000
Date:   Fri, 28 May 2021 20:42:33 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     bvanassche@acm.org, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 -next] RDMA/srp: use DEVICE_ATTR_*() macro
Message-ID: <20210528234233.GC3874396@nvidia.com>
References: <20210528125750.20788-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528125750.20788-1-yuehaibing@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0288.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::23) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0288.namprd13.prod.outlook.com (2603:10b6:208:2bc::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.9 via Frontend Transport; Fri, 28 May 2021 23:42:33 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lmm7d-00GFw6-8w; Fri, 28 May 2021 20:42:33 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f43b774c-7443-4ab2-1b0b-08d922324451
X-MS-TrafficTypeDiagnostic: BL1PR12MB5159:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51594E777C149126565F5C45C2229@BL1PR12MB5159.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tsPJhuQTF1pMo3YMoRgC/eZC7uObjY6IygGROlRRBeEx1L85oMBZo/JbKUN8dVV2XEtfHveip4l52wkjcnnsu7cf3vImkvURpYvOgGJY9GUqpU0CK8+9+2bc19W1lYScbEMO+DKpd9XXqoJsZlAJPItfrvNZkh3+9XU4kkVdGcdvINwNElTr/N80W22ZdST+u8qF+bOk8gCyxe0Q8+fQqKOepDCA0e/btkXYTWKU6Q0OVGp4Ga/kBbgTby0CJP3cAr905iwttAhRrFseZ9hibcs9Yu0/+dtt1UfbohMylWQauPmgDjk7HOu/wlrILc1ACqc3EOmfQ9Atr5xuqg5MXXY1EIusRGS96NkBIsgKD8Id0hRQkhU0kfZEkH+VYdnfRtc1ue1XAhqKZoDb6n0vdaPsLhgq8HtZQvI9QJPsHmlkDrmbO6nL1VlSADaFKZZ8vrRqXFrTz/HIOjVY/lfUVSTM5AmCnsnXGgkqT1nt7iANZI0pRdCqfxZDREHFH4S7Gmn9xSxaMu1cw9DC/jGajiwjdcevHSmxKQXH5KAAhfnDvHvHRaUfp3+aiyGYBjWt4MQbY6ebv3kmVr9BvaJF5WN3jUu/jfzWpM6biRdFcB8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(39860400002)(346002)(396003)(86362001)(83380400001)(8676002)(6916009)(316002)(2616005)(186003)(2906002)(426003)(1076003)(66556008)(66476007)(66946007)(26005)(5660300002)(33656002)(38100700002)(9786002)(9746002)(478600001)(4326008)(4744005)(36756003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?i2Umf3w6ryISKCz9x8BjUk3IjfOlqR/tgLF0ZUmjkTM07oGldEBzmM269DHT?=
 =?us-ascii?Q?Eb8K9asXfOhGliIagY/cQuHGy7zc6+nRF2h/Fzi5Ze8dP0qfXPU33pCNAH7E?=
 =?us-ascii?Q?ZBWZovWaolx0rSxUXu1zhBvQw1NPjoIMKLkkxV0asBzUGsNh0I/d6Legjxq5?=
 =?us-ascii?Q?GM+fUFeEDWFUfG+FSw7ACW92iGyDKgtuaTkuGUZ0k4dOg78Eifp2Et6leDV+?=
 =?us-ascii?Q?UdJfbyIpH8JhlGWnKF0XVEFj5thbsHE5ZYFGOvbFoQyu0FR4GJkBRTXXeSq4?=
 =?us-ascii?Q?7ESQ9D5MheNbKJP8A5RBRrXD36uqnfa3NxAuwkXuHhj5GPN4mJOaPg+5PCQm?=
 =?us-ascii?Q?1OTYfJJp2taP6p0qlUnocqbGdmV8DY7pp9+yKaVN9eRzs3FfTernJ6w2N1Yq?=
 =?us-ascii?Q?nSHzllNYadL8psPXlj+8oJSPKaq8i0Lnj37+QLAW6gyX0UUClo+lOrOBaJVV?=
 =?us-ascii?Q?pKRyVKNaRsJ2lX5yRr6RWiaPYGgMJ6chuRTfP6iKyQv756rk99i4wE7Csg8Y?=
 =?us-ascii?Q?LWtC1FoQwtJrJtRIf/OHc7dTtnjepEZ6Gk+Uzxjj7e9A1yU62h3YA59jD5Ko?=
 =?us-ascii?Q?vqgRETAEN3x/hpFKRXzjL5BSbujZXnT+xS5EfNiFPHMWixr6lcEV9ZeTu8gZ?=
 =?us-ascii?Q?ErhZYVSmzWSJ6r/vmSvcHij/AVXxMpBfbQGKnQZ/nYjxbaiFFTHWQqjPsLCH?=
 =?us-ascii?Q?KLZhGmbdIb3SIUkGpdeity7YIY0tzZ10wg4+KfhO40Tie2QUivewr1rIoetS?=
 =?us-ascii?Q?2mZrqoc8LL58tAjVGPjdCAjoy3A7yZYt3m2wqj66DebyUb8M2E48iXHvus3E?=
 =?us-ascii?Q?IoFP/VYjNsxJ3IHUPSSM7K1wp6P8IMa165vUIZODWdhlr8iE8q9Y6nBtZpkw?=
 =?us-ascii?Q?y9y6t07cbmzEsuBaJoqfkIzdWM73Iuin+POHVh6mZLe6aPYDHq5AATRzErJw?=
 =?us-ascii?Q?Q1KDfmt8A1Q+2kt0PynsFT6lYnRI2cSKLxG0y9Qt4FCVCUOabBsb+JE4lXOL?=
 =?us-ascii?Q?IIdjAkRM3YPEm6IJF7RUPO1ohzpbslODdmGyK5XXM6kpFCCgDTR866IlLjT8?=
 =?us-ascii?Q?2si13hfZIoXerOwn7FvmjdEClZFB8gEDE/3hdCVJzjFRp+Lg0ywzDlAKRQ+Q?=
 =?us-ascii?Q?cZmVeeu0Wd0ac7QDTd9IEpi4680opSO4HxtBfmdPSbcDyyHIkKmJI8sMx08L?=
 =?us-ascii?Q?jt9UTC3xkE7AzQch1nkYeAM1RVImRDi4MROAPPv9EdInUdXf0Mp3y0Mu+prQ?=
 =?us-ascii?Q?kT61nU6034gqQrGGMrFs1IIZz2RrcxfMt+oRTWhmxlEPzT1+o6XbMl5xSVrY?=
 =?us-ascii?Q?WNruPjC9KXoA6X1/rMnj0BE3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f43b774c-7443-4ab2-1b0b-08d922324451
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 23:42:34.1104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fiHYshrufFQ30wtz6Tjn/5h7zxPhiqL38CjRwvmzBOG8asmRempNOLxszGlLDSB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5159
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 28, 2021 at 08:57:50PM +0800, YueHaibing wrote:
> Use DEVICE_ATTR_*() helper instead of plain DEVICE_ATTR,
> which makes the code a bit shorter and easier to read.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v3: rearrange attrs
> v2: convert show_port device attr
> 
>  drivers/infiniband/ulp/srp/ib_srp.c | 109 ++++++++++++++++------------
>  1 file changed, 62 insertions(+), 47 deletions(-)

Applied to for-next, again with clang-format

Thanks,
Jason
