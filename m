Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD07535D3DB
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Apr 2021 01:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240208AbhDLXVR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Apr 2021 19:21:17 -0400
Received: from mail-dm6nam10on2064.outbound.protection.outlook.com ([40.107.93.64]:65312
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344065AbhDLXVQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Apr 2021 19:21:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bewnC3uz0n1Tso+OBOMcEcTE1ShX8zVuiJAiSgh/xTtQXlbdH1zOcLEAp5llaXBKfy7VgnEAhKHpEUK+3S/iZD/UjDkWQaNOtLxwhq9HW9Xwf+fDHzwg8mHzDEhFj7iG5Jg+UBdT6tTb3+HseSQORS/oeUJvA2ML9SHDIN0SAENdxrSHjM19+w+Ay1nwB9Ph6GCNI3HFGYZY8rloG/gIXomAPOh60k5IwPoHaGEC/G6zmKtjzb4PNnayTi1vf199hxw+N6l+NXuEDHU0Z/UasdbzEgwAl+osPg7fYvKxuPyfE7iBygQNFBI1VFUBHPufe8nYWVl7M1oV3ZVdaDNHJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaOferEUsghAagPRrd/YJfCus4UEbv1NTVhD8Pw6dSE=;
 b=LW0Q2ResA+Or6MF74MLogSLHnc9eJyHsxE1XiXtHCtVzBRbKdtfanLJfQeMZKiT+fBiUHxWRS0nZYx7IqoqB4nDjkxapupLI9EHm5NC8fEsVAQbJ6ZOHXnDk1Qn+qz5y0to6vrE/MNhfOkeGVzn7UzITwq9yZLGnjj8cfUXU6noOC6KRI3LDlH7aJe23MNq9DUktLxrgO4ZFoYP4NUjM6xSVNSrzLT6tURc08qMhRW9RbAkqhUfYBKBiTj4EjPbTvdyaiDS4R/8L+jofgeuEBFMRsjrO4huOuoAjOUgsqUt9pQcpRm8/4uuUv4Dl7praNev7G+xPjINTqNFBkVPdTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaOferEUsghAagPRrd/YJfCus4UEbv1NTVhD8Pw6dSE=;
 b=Z9DAAIPPWIZ2/OLltZIoDA+caRusS92+EBHb5/WgAaAdsZS/ssy7ajDQ3UJjbq3tbeHdD8I/vgIZONAJpGD4FfMGdYAtFbGcle6Cg92I1CEI7QHKHYs3Lf/PuLKV7lAyU1XGJgfHAK/nkuFbUqHUk1VWLPxWSlWWEATJIRgTOuD4vXZbdrwU0e/5XvzEnYF2wbXomJtHRI4YMQ6/mh5pcaltZyqKd0/ijxiJfYtko2UqYjM2H1HV6tdD78UQNbirUojEbyQNHzvWhOh7RGPPNyShi4ur3UABui8u1fJOA6cqmTeDWgxYFhuKydZWLV2fmI/yFt7AFxb2AV2efiFN5A==
Authentication-Results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4810.namprd12.prod.outlook.com (2603:10b6:5:1f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Mon, 12 Apr
 2021 23:20:57 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 23:20:57 +0000
Date:   Mon, 12 Apr 2021 20:20:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gioh Kim <gi-oh.kim@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        dledford@redhat.com, haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: Re: [PATCH for-next] RDMA/rtrs-clt: destroy sysfs after removing
 session from active list
Message-ID: <20210412232055.GA1196603@nvidia.com>
References: <20210412084002.33582-1-gi-oh.kim@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412084002.33582-1-gi-oh.kim@ionos.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR02CA0121.namprd02.prod.outlook.com
 (2603:10b6:208:35::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR02CA0121.namprd02.prod.outlook.com (2603:10b6:208:35::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Mon, 12 Apr 2021 23:20:56 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lW5rT-0051Io-9z; Mon, 12 Apr 2021 20:20:55 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6b2b9ef-50ba-40a8-b4d9-08d8fe099fef
X-MS-TrafficTypeDiagnostic: DM6PR12MB4810:
X-Microsoft-Antispam-PRVS: <DM6PR12MB481067D5C5452BB29B0B222EC2709@DM6PR12MB4810.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2J4vVSvmXrXIiChkR7oWLoDhfs4MfI4M3WNzJStFoOx8TudowyruPXedwlHKk+gm5SYujL3WPfOXo7NLfWWv/7ycDPzIz164S0CiF8gb2uzDGWy7Cv2cnk6IsJfsGNm59otaxebqoER3zSPYPpp6w91ydBqaWxDP60zYNHzdzv3jeGz8nIojXNhr/ZejDL2/1BanDCvxuP3yPrQkJOcAiqbUwVwbpQyUuKyezjDRVPHnzN76Mr9SdxNbFCjwRdqGrk6M84g1lxj+9V4tnYU+8Onfa9ZoOdkcpGjBVf91vKwOIuwi5fV3kJ4ETK5KZw4Av4FcS1Nc/ON0e3bUx9hFuqrn7zhZExhmuOVO0F3sdZZkkDDMEw61LG+h/R5sx7x9eL0jhoIiPSqtpDV4hS9JIoH3S2a14NFKfP9IEn3q31+kBgIFSn24ohQa2KJUZJhScpS6jrsZWTjbJ9z+/7zDpLR8QY6F0hmbWSE8CGYZcy3coRi1UMKK/JoPAXU5CPZJEPq8CXY/lFE7fKfvI8sOh5/UwBSoh9MJuIAutLhu5oHTMJsfzHBc/r6VXeJzxEybrax3hxbdraxEI/RC6pXc6rUUBGRGoWWKRi0IKiNA+xk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(6916009)(83380400001)(5660300002)(33656002)(316002)(36756003)(2906002)(86362001)(9746002)(478600001)(4326008)(2616005)(426003)(8936002)(38100700002)(66556008)(186003)(66946007)(66476007)(1076003)(9786002)(8676002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hAG5y5AcP6290TWGGspLUynFgO29ZMzBqB9h9TKbB8QqvZpKIKLCsG+rps5c?=
 =?us-ascii?Q?Q+7zEILrdWcZNQSN2K6huXgKc4R4YUJBlVgOe8dF6Ig8c9XoxvEdqQLwc5qX?=
 =?us-ascii?Q?bbOQZt6o2V9sRzghqkTZIHV/a3iD1qaXai2A2IGJrUuTQVeQXiq0/N6/Js3X?=
 =?us-ascii?Q?RRVc1zuCSdHmcx7+udurM7QZblyA7ysw/FnnczcoHXUR6EJ5L7h3SBtNYD/e?=
 =?us-ascii?Q?nayQJb6nzDTeBpt1oq+J3c0wQo1yzwkxl2LYmkm7zVqoVCq8LGwBJDlzrSCR?=
 =?us-ascii?Q?jmpXIzupZDwPj8W/n1zLdQvFYnnu7giFNdm8uUCNdpD2FTbLvqr9Dsnc6oEH?=
 =?us-ascii?Q?TI0852MPdo8908qzXx8zZC1ATMOY6MSm4/mFJb45JFd+y8opBL3sNzD3sksO?=
 =?us-ascii?Q?nBOuzBWjosPJf4VpYt7WaxJc55Fo8YV2KsSJtN0i1a4yAGoDZBbSAaMx+gCo?=
 =?us-ascii?Q?Oj7asZw7r/afrMkp0nDx68rI9uU+CVmABs1HpEsbe/dsC0hczevdDl87Ez4e?=
 =?us-ascii?Q?ZIMNDOYffZPOpt8CNry9l/USwFtj7EDMxNVpE6vjvmq/tqkM0o8LHXH2dE4E?=
 =?us-ascii?Q?iraylDVAWGzetcVZrIdHWYwXStyH1KI/g85v7dOBGRdhQGoBXXIa7UZ34bbK?=
 =?us-ascii?Q?9NpwR9prlJQBESD5Cl/7JGntBn8fmSPrN2wtaSHzgEGINpQWUt45gYIMRdOo?=
 =?us-ascii?Q?St7Zl5pxRSMlwsr7agLYrGsekLtk4opP/Qo2FcUofSGsCDcAYT4Qh60Iv9cs?=
 =?us-ascii?Q?GC+4Y7hr7T+3Ka4XfkNgPGqTwBfxeFyVfHvrekK6pflQUQ2YqNvkOAgfp1Xk?=
 =?us-ascii?Q?oJCYDcBzdUcbzMQ28RcOjHN6r62aCaP4zt2KstK0ycobXJLI1cB5qYuqh7FL?=
 =?us-ascii?Q?0FW0Yn+J6lskVDDL9prFi1IHmX0L489KcQxmzgTI65E4W47S9nxCT4Fvt8iu?=
 =?us-ascii?Q?Qbf1OeHkQPhBpp0crHGZY7SOutcNY2csyN+5/lCf/E41yHScw5VYwSv5VBZJ?=
 =?us-ascii?Q?P0F9cvQZTCQWD861MlJoqzUA6QjTmvaqZilYiPxjPxp/eXhiHoqjqqyhDGYw?=
 =?us-ascii?Q?1IY57JQNnTZ6qiXyGBnkySKV5H4cIhHbemYWxErfynAWYKe6nJp7YVvmW+SS?=
 =?us-ascii?Q?duaaBY8fp9m7DlcwKQrkrkX9ruwJGGA/354KPsnKNVcEsPHtN6KjU3BHNkqW?=
 =?us-ascii?Q?RTodBk+vgmd1FpelBd27o+kH66LSPFX9zXkPcpCQiU8ZZ7k+XCgbVPFqOwk5?=
 =?us-ascii?Q?f1uvjHsNfZTYEP0icShr5p/Z3oJGs3Uq9RL5IiyGuWA12VO6q2vA8kI8VMKK?=
 =?us-ascii?Q?ax+DWciHbOlqlqmgo7r8+xzD1NMw/mAA8090XVqloQiFag=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b2b9ef-50ba-40a8-b4d9-08d8fe099fef
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 23:20:56.8650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QrGJwMxLniXHlJVZhkBLtNkRgK80NVayr6bm8i96iUfdmtYozaEKSvmyr5k57sdw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4810
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 12, 2021 at 10:40:02AM +0200, Gioh Kim wrote:
> A session can be removed dynamically by sysfs interface "remove_path"
> that eventually calls rtrs_clt_remove_path_from_sysfs function.
> The current rtrs_clt_remove_path_from_sysfs first removes the sysfs
> interfaces and frees sess->stats object. Second it removes the session
> from the active list.
> 
> Therefore some functions could access non-connected session and
> access the freed sess->stats object even-if they check the session
> status before accessing the session.
> For instance rtrs_clt_request and get_next_path_min_inflight
> check the session status and try to send IO to the session.
> The session status could be changed when they are trying to send IO
> but they could not catch the change and update the statistics information
> in sess->stats object, and generate use-after-free problem.
> (see: "RDMA/rtrs-clt: Check state of the rtrs_clt_sess before reading
> its stats")
> 
> This patch changes the rtrs_clt_remove_path_from_sysfs to remove
> the session from the active session list and then destroy the sysfs
> interfaces.
> 
> Each function still should check the session status because closing
> or error recovery paths can change the status.
> 
> Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
