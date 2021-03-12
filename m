Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF089338255
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Mar 2021 01:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbhCLAa7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Mar 2021 19:30:59 -0500
Received: from mail-dm6nam10on2067.outbound.protection.outlook.com ([40.107.93.67]:18062
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230452AbhCLAah (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 11 Mar 2021 19:30:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkgbBYXQv5m3enj5eunc4zwmLP3lc8Qc7iPqD9+cBl1c+xkx3d0l6utQbXj54/hOreqOQvJSoWm37oPJnb7aI5dbn4sPdNjtDV6BoTJ111dyvIcfLqzta60ji6b/dkUDFZQsXA8IC79gnDQtfSurQnWq5v1vPv7uUkY8IZ4gt7yU9sYq8mVEty1k6zk1P6amhaBB29A7rB6Sa4wPLOyi1n3XGIanMny5HjOjsEagDmvEWg2Kajo0FsjdFoAf1rc5ijZBQ/rxyFofHHklwOc8ZKaD1ukTym0TWCUPRqS7fQYcQllWTzVg0JGWgQpNd+bJF9DhdygIFrJL0LWWHAoQCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5MWDRBO9an30tyFE2ilplrg+8tPXjH1L8JMY/nvIIs=;
 b=a1GUfTG6sb3hwurKdbh13nzDPkMOsTBQ0vFn0g1cf+XrNS3Nq7SsbqFiwF2y11qadkGmL1fbIBSg5oN85sWHGb8tE0jG/Nrez3vDvHcHAAODym40CUCgspTMLeWDISELWMFkJs4/WASbLA+dtY7YhOVDIaWVrg21C/PqB833RilaXq98vKwD01LQZ6wU7TTPWfF4URdmeSDw+pm5sqn/wQMRUJG8qlQxZfhwrq7Frcuwyx4m6plRwbGbAEgpYGdR+9RSs0CaGkefayz8CjtWETJUoYTvNiTTU4a5/pQaFfgyaPXIPWbAY4ix8QH3tnjpQBYlRQkoT3haMqv0DW+LKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5MWDRBO9an30tyFE2ilplrg+8tPXjH1L8JMY/nvIIs=;
 b=d95Nn5eqUDAhhma/W/6gH1UsdeP+9rs+gYdkKXAu2kQ647+++mN4EsONQa5gZ9hWwQifBBN/jyPP2ORB5X1bm811uAzZ9pHo5Yi4utwvxoyrKt0M0mowE3fRbFgtW6hZhpyyUK/i8nMhyUYE+GjFA6TiPpN+iVkWp0d/49+0ghVuU2xAy/2iWKYn7ir5gMkNs1exveH26IiUquzMIr6ZlVjHbz5HAg7QZ+FomhCA01O4g75yQxWONDak1J7fcXXsv+t9Ln5jRZIfOdxbtCAVOpSqvTpgfYsCIOxUnJhre8VJdYFWXwrx6QnVrQUEIeyGGyRMglnyQnCXsL+OpiaNrA==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB3301.namprd12.prod.outlook.com (2603:10b6:a03:130::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 12 Mar
 2021 00:30:36 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43%6]) with mapi id 15.20.3912.028; Fri, 12 Mar 2021
 00:30:36 +0000
Date:   Thu, 11 Mar 2021 20:30:34 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-rdma@vger.kernel.org, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next 0/3] Support larger than 4K pages in DevX UMEMs
Message-ID: <20210312003034.GC2787233@nvidia.com>
References: <20210304130501.1102577-1-leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304130501.1102577-1-leon@kernel.org>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0060.namprd13.prod.outlook.com
 (2603:10b6:208:257::35) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0060.namprd13.prod.outlook.com (2603:10b6:208:257::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.10 via Frontend Transport; Fri, 12 Mar 2021 00:30:36 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lKVhK-00Bh8Y-H9; Thu, 11 Mar 2021 20:30:34 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 793d2cd7-cb73-4d8d-2380-08d8e4ee0e13
X-MS-TrafficTypeDiagnostic: BYAPR12MB3301:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB33010214BEA136F216BB740CC26F9@BYAPR12MB3301.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1SV06rx0cmikufNiQqY5cyFw8IdO7ALX7uUc5Wbg82DIYoMMijDmmKjps0Mj7nDGdGS2maUSqCbFh5uPl6D5C7qJA72rwTwyx3ngKI1HdnZoMZGU2mrRVQ97jNSxNt8P65mRWxbyrLAy3Q9ArKAL3kQw8wd0LRSmzXywuy82RlCdbMinjnBRMq1yv0OfGvmksvaNzZZZoJMI8jrFKBb3k4qK1EeRdY3mcsG2SlrU29CUOWYImRleTfsRc12EqY9xRQy99HnPY582IJPWdbGDjMSDtzrZ2Y60Qlk5BqStRZjhOsOo2RmO3FXpnGxnda+kTu8mLbRZG4NXfl5BrXnOGTGXwv3Bx0FawUqUV15szIlTeyqkIBoI043XiNCKV8I3PqbtoC2gO3C7hKuNHN4M1WavSLecsAGJX22nw+vY97pBoFgaacGH4EF1jXnGEQcdCX/UPfTvS/C4IFPFaFVoQRT2/PpXILX07Q7Pn5PHPDodrUI+JgU3ypGjFIw9EGhgFjvVDgBid0RxjN2hvVcXxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(83380400001)(107886003)(186003)(478600001)(2616005)(4744005)(8936002)(426003)(316002)(1076003)(54906003)(6916009)(86362001)(5660300002)(26005)(66946007)(9786002)(66476007)(66556008)(4326008)(2906002)(8676002)(36756003)(33656002)(9746002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?AXNkr1yg3tqg2RgUv/A+XB1+Tcyxh+uye1omuy4EHl5JPUW3FqQgAsDWlP4O?=
 =?us-ascii?Q?cugbgXVJaTE2fvlE+iF1CT1sBH/ypJvJJQZYctjVLwTZYbUmW63I0Lrpddm8?=
 =?us-ascii?Q?339fHJLE69Tq5Ry5UOTY22WiAD8VqJE9TwgLM8u13E6ni1GCyZ2E/pYllREF?=
 =?us-ascii?Q?jRxgwVRUrSY9lf8GUEQr962xrHYr2qUPPu85tcnc4Wwbrv7992UbZ8vZXmS9?=
 =?us-ascii?Q?+3L1mzkVtRB+YgEnbl9VNkg/gR1arNKcaJg7K0WX0GAhfUct0vBUbC8rzYBs?=
 =?us-ascii?Q?/PAIJQkwVZ06XvfHIElcdLVT4Ipw72d3YhKY7F5kIxcl/P8GShPnox2miWJH?=
 =?us-ascii?Q?GgNxuXW5BqNi2I0S6x2sGkIA4a1DyPEO5ul3d1UkZV/US0MnSD1jy15IsRPj?=
 =?us-ascii?Q?W0sb+1x/IdBWaPqZi9uzCIXRlPJsPquumc6mR/bGgwFKh0xsEAohKX3D5a/7?=
 =?us-ascii?Q?A9rwOFVhVxNBfHA4le5DxeA1G8fbpz+ZkHhjgRrnchTJtkxteV4xDjXNCSnt?=
 =?us-ascii?Q?6vNmeKoNEinTqB8SeohFQuEFy0XFtMkgXRnxBNTowPL0MTG8OZGdGN+DuboG?=
 =?us-ascii?Q?Idf8fbec3cOXX8luJiIcpOmRVZz/wZjnD7ffdIHJKAGvEwXX9USVv/OQXlA4?=
 =?us-ascii?Q?EPwxloO3dhBkI4/QGY96cleyBGZeIoJHYF36CirEnd0YiQv7Z8nGIcuJPqUG?=
 =?us-ascii?Q?0b6aC9HgRWCHlPsCcQXx62Rk6+oBX81wr5ltLz97T5yg44hxDEVxzHFVKLJ7?=
 =?us-ascii?Q?XvcW7+kuS4HsQy/9W6OkBDN1o74Es5dukxDc+XWZ2SuskhKbpQHveeLdeLOU?=
 =?us-ascii?Q?czdjQVkUvwzbK4cKDePadw0w9wQTWcEQxeHxbJCIqMYnlAQFIFJTvaARrpH7?=
 =?us-ascii?Q?ku8blE1usQNos9VPcP2dajygYvDn9JRdzVxt+I5exqhVFIEAr5w4f1F2PQ6E?=
 =?us-ascii?Q?n4Kv4escXVm+LP8QkOfyUcnRlMutwbDrB40l81VuGLkrWWOKFRYWYM0N+65E?=
 =?us-ascii?Q?tnylG86fJa4XFdo9mhdaU/cIrQ300fD7ZY4f4vOJ6Xy2a1h+T/BaA8eJsd3f?=
 =?us-ascii?Q?13c+SJQ/b9Fx1aplhjBwyBgHoHAc3ZgYKcWsvJ7jn/SF36JDVjGy92VZWWhJ?=
 =?us-ascii?Q?dTt7vvZtTB7ymbuith1RAkXsm5UmeEoDY+deZNRUhdS86weqpdrZs3rROgdF?=
 =?us-ascii?Q?skLQogXPUPBaVW59uSrP6PvIQLE+s7o2pn3h3xzEtlMbjkx4359X74Un83FH?=
 =?us-ascii?Q?aTvbpSM1v803c0GBimuLgmzSCSVfKTyqX2MWaYEaZapIm5TZJ2tr3pf91Vy+?=
 =?us-ascii?Q?V3qP/WYkOBHtp0J3pHrlZv1oomFBPkuEptUR4xDob3KOCg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 793d2cd7-cb73-4d8d-2380-08d8e4ee0e13
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 00:30:36.4508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BxLwT5EzNP1k8k4jyvE1csm0L0ErZ6D3oj+rTGLJk6yROTgkDAU8ZX3oOJYZxb/E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3301
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 04, 2021 at 03:04:58PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Hi,
> 
> This series removes existing limitation from DevX UMEM and allows user
> space to specify the page sizes which it can accept.
> 
> Thanks
> 
> Jason Gunthorpe (1):
>   RDMA/mlx5: Allow larger pages in DevX umem
> 
> Yishai Hadas (2):
>   IB/core: Drop WARN_ON() from ib_umem_find_best_pgsz()
>   IB/core: Split uverbs_get_const/default to consider target type

Applied to for-next, thanks

Jason
