Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E874A40B6FF
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Sep 2021 20:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhINSfQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Sep 2021 14:35:16 -0400
Received: from mail-dm6nam11on2048.outbound.protection.outlook.com ([40.107.223.48]:62561
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229728AbhINSfP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Sep 2021 14:35:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbYIsQbGXpJkIcGeIPveewXBpFgekQ9KFsH7RkqQMzxLM1O0sEfoGz0b9iNIX/X15i688uvIB1molWHLUTaIzCpAIUMJb+7YrYzCLlNWsIvMdGpTFVxkDdPRT5KQNq7kc+pYi9b5mtdQUtojIocIQM97f8ioFidE5NMZGIcYx+pOwB+btR1aIKSpeCO8PmIYOuuUau1W2WdQ0IIzYGtYRlHbwWo0txL9qO0D5y53ywpbUIX1YC/cL8UT+P8XOFa7XxvmSbUfQpS6JmXGuWcAIXChlkt18CP2pv9lde7wsRMtNfCWWG642RYJVD2Dqum18m/MMcsEEL2HbUYe/YNKOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLK/kOhS4agMngTp39d3nKw6aV/zww2rnCm1q1TXymM=;
 b=oFre5qXUwBTBbi6UB+DQjYraWD8YTi+ETNnbcdT5rKz49mtA1Qig2ojpD9tX2pPWVfeiljIzjETUy7rrF4tsXLtqYWCc+At6T3eWwb28KVz20f8NXffIOJ6QhuyiZz90Wtbq0Zo4f5dtdbsTg9578djIKpS+85cyaB8wdBek58mwcOlGFLmTtjFwMZYoGgHDY+KS8ZKBwiyyKsvdiJT0waflpGpyAlr4Ck2H4o5dfJ5tBOfa4zRqhYFl5lVGQoYD2TPdd0wkkm1iUveV5WFx37Haf6W22wmVyZ0QtFPVs8MAmtigL4qO36lO1DCSmsF3Ywtm5aDXRbUTLLUUGcFerg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLK/kOhS4agMngTp39d3nKw6aV/zww2rnCm1q1TXymM=;
 b=UEmvPM611Aemkt/ENpttZqIvDcgTti/KcOnLhOgGq4WLqE7FZZNY0P2UeZZgXXuQkCiB0XR3vx0rx8qU0Qf7AaB15DlOeMHkJlEIalM3KSiFP86mx3iQLaKHEYEVZvwbt8Hm2Rsvsi9b1dWO5Fpgmj2YT0L9n+yABFpUA/za5dPZQtpO0Ssa1vwinQGDvKF9A8EmZ+VH1SYHuC8sY96b8cUsWkeipuQhi0dNxg9zC9246j1jL52v/l+i2LC5h60qWDKfZJSL5W/GewURB7Gw22cuJb4H0V0V9F1NAt1dlv9KicW8u0zJpYhEE1eiPtQv1GLV2sZtYjJSefoFjt900Q==
Authentication-Results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Tue, 14 Sep
 2021 18:33:57 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 18:33:56 +0000
Date:   Tue, 14 Sep 2021 15:33:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, rpearsonhpe@gmail.com,
        zyjzyj2000@gmail.com, leon@kernel.org
Subject: Re: [PATCH v2 3/5] RDMA/rxe: Change the is_user member of struct
 rxe_cq to bool
Message-ID: <20210914183355.GA136464@nvidia.com>
References: <20210902084640.679744-1-yangx.jy@fujitsu.com>
 <20210902084640.679744-4-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902084640.679744-4-yangx.jy@fujitsu.com>
X-ClientProxiedBy: MN2PR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:208:239::14) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR08CA0009.namprd08.prod.outlook.com (2603:10b6:208:239::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 18:33:56 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mQDFj-000ZW3-GO; Tue, 14 Sep 2021 15:33:55 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb23c8b3-6b03-4643-7da5-08d977ae3608
X-MS-TrafficTypeDiagnostic: BL1PR12MB5349:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5349F7049E654BAE21917578C2DA9@BL1PR12MB5349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5oscBp4l4p+tfMlzzvsWjmA625zOqWurzRHES9vLJJxkcILKKlB4XZrVLQTJrRDo5NjkPYoSg8czOOYbusInVJuIiFLps1xxaNlaGwmzk4G4aQWwRaNCcovtHGEHcqUrCw+d7tE0jBAMkUx5PhFBzDMFs7FY/onexDp9RdokhXhunUaAKARyikxXt5eF1j8hGbjRTnRtudpvpPh07XnfxS5O26l6LqoAFRDkUi6jGKvhH09eQ+Jk+vlv6zpwKt1997tJnRKGwXxpXNVPqvgV32tsslWWPvm/6CfJU5M5XPaTHazQy7jpjk0Ctx47HoJ9rCXhbiL48z+UdlVZod5uZ3XRbjL/0gJw8wEirw3f78QzXKbNDc3hFzO+HKAptR/f7hTlWTaSjth7ci0sixLkR77P/HoJ6yxqf1iB52zfEPf6ABuiVI6m4XLsvWTby2JGEldRDltJqXcU21IaqwyDhgeS/W48x+2JuK+Q9/K/Z+AkIVudI/ktzMehZS3iHi4Yux4/XM/iqq6xU9NYkyLsgAhPstWiuN0yMslxSReQPnq6/K+asbjVE9WeXZi9yYd7pEY00K54LQw3B/Ieu1VrHurbXhPA4DeXFNm0AGki4bzs33VK3DpgFOAjG0AzEG7cnM/X1/rSE3i2Vht1wXz3JNmiFpK0Q6u5fcD5UVRf8hJvi3kBV3kqMSMKK09ifwiZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(8676002)(38100700002)(4326008)(9746002)(9786002)(66946007)(5660300002)(8936002)(66476007)(66556008)(478600001)(316002)(426003)(6916009)(1076003)(2906002)(83380400001)(26005)(186003)(2616005)(33656002)(4744005)(36756003)(86362001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hg+1kCxCcDEfG8Hkm6ngUscMytmChDk/lCXWzQFuribZyZ56cBMAd/DZr5EN?=
 =?us-ascii?Q?s9s5s7KqrMJqq1qnPwqksh8tjET485OiWA8r/3QK4bZ4lPMN+vGExvowEigy?=
 =?us-ascii?Q?mIjUYbe00ZEg8gcJpUb9ASQtH4j8KeSiSJCnSfXndl/oxCOCleu6EgZmCpk7?=
 =?us-ascii?Q?6423NQ8NjP2L3qBNRqjzmCdF+lH7r/krkgju/xOnnIUQDJZNc176MRKCAKtH?=
 =?us-ascii?Q?oPwbrZMPT5tXfBDZXLeo9iiEMFDIy/v4dUPZ/LEszEf4CY9FkP4y0gW+Lw+2?=
 =?us-ascii?Q?kBmU1LLuR4zhs1W3gogR18uNBoCknN5e7X7UQmloyS2oNj0blc4zdkG1bex/?=
 =?us-ascii?Q?/rU7xi98ROyNw18U8THk8dwZv5DgRjxWGuhQhrVkniP45OcGPvmld8gEiGj5?=
 =?us-ascii?Q?jqzhyxQHEGxR9uSJkU7AQblDH5vtOD4G+SXE4MGfQZWV1SX7b2qo9CNVBGe+?=
 =?us-ascii?Q?C+29sR9hIpBm99dG8n6UZJpNoADWDSfPfy3mvHMGaJMN2HaWai0HUVklFIXI?=
 =?us-ascii?Q?S0Je08e6khXYKd0HYE2LBm2uLv0BqqzBD7G/9nDu5kAMfI9XHWqh9SgYc+aP?=
 =?us-ascii?Q?0biSltH9O6Dp+H3prpv96kpB8D3oZ7MNIGmH9qmkVr/w3l5PzmDty6Gafdtw?=
 =?us-ascii?Q?7chFc1FZExOjN7ixMZBSWywBixzNzs5qfiqDQA9oawvpk5EpJ/GghCe2yOCR?=
 =?us-ascii?Q?2j6Mp5N+ToGFeBGGaIS50wo8JahdOO9Dhv7eGsNcJP/FBxREDGJJw6quoOWw?=
 =?us-ascii?Q?ySjtrxhyeSJcQEx90M6Aq6cyGc7SuX4dzAvqP4G4YZbU0enT2PwExx7Fb+BZ?=
 =?us-ascii?Q?QUpKo5Hlp+ua0HXF+iTFEYRyeK66eVE2n10JeYYmk38DlDz2B9r3v4JVBg2w?=
 =?us-ascii?Q?e0hblbYa7HlpEBqzM+eSum1N/6r4TokHHhNYOUWiohG6r0HBLhI7WbNj5oX6?=
 =?us-ascii?Q?ybKP0I3d0lCjZi38SVLrAmP7Rb6tbNKkj4bSSKGLGAu6gQiN6EhoZHIts8ut?=
 =?us-ascii?Q?8C963ZPMJLFWvE4DJj+5tGdpCcRz+RYAYgZCQNchJHTv8hS4Uw/rWgpy88lR?=
 =?us-ascii?Q?yO409VzNE1ZDCJVvZR7nFSG9EVeXZ6huG5ACNxy+JsA0NUGoyVqSSNkhw1kD?=
 =?us-ascii?Q?PtGVMnSod4TnToRXKE0IsyI040JiIQyhRv2yd6HREt53dl2yTuHU8nC+jgMY?=
 =?us-ascii?Q?0Fla3d7QjePSQ+3GBIJpILrCbgUkKOxcXkTwasHdbhn5r7cm3zjQJf6SoTcJ?=
 =?us-ascii?Q?xLYizisvcKVJVYcen6I1CGXu4Yz5MvsllCDldrxkfQ0D8Fn/olB/y5lco+f/?=
 =?us-ascii?Q?4IkZoXAPj4k/QgFcnC9dqwER?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb23c8b3-6b03-4643-7da5-08d977ae3608
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 18:33:56.5600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rhAp+IU0na1cB1bconJyYeOJwqiEF0G91j0zHZ1tWA2F1S/cWsFU0yjUPn5/vvVa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 02, 2021 at 04:46:38PM +0800, Xiao Yang wrote:
> Make all is_user members of struct rxe_sq/rxe_cq/rxe_srq/rxe_cq
> has the same type.
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
>  drivers/infiniband/sw/rxe/rxe_cq.c    | 3 +--
>  drivers/infiniband/sw/rxe/rxe_verbs.h | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
> index aef288f164fd..fd655e41d621 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_cq.c
> @@ -81,8 +81,7 @@ int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_cq *cq, int cqe,
>  		return err;
>  	}
>  
> -	if (uresp)
> -		cq->is_user = 1;
> +	cq->is_user = uresp ? true : false;

When you resend this series we don't need any of the ternary
expressions, when things implicitly cast to bool they are converted to
1/0 using the same logic as any other boolean expression. So just
write

cq->is_user = uresp;

Jason
