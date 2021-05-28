Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1319394925
	for <lists+linux-rdma@lfdr.de>; Sat, 29 May 2021 01:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhE1Xg2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 19:36:28 -0400
Received: from mail-dm3nam07on2047.outbound.protection.outlook.com ([40.107.95.47]:17409
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229500AbhE1Xg1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 May 2021 19:36:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgE2hi3/fHZ7WTJyyXSZWhmHaLSO6O9HR4NSjZHgcAPfLGwSYjO/Ldz67cgqu1Lg/tmbo3uruZEp8uEXAaxoQZVOBChBzqp4SjWOLEIyucu2HFalRrP7LhLZGoXp1zAInnYRfqCQcDqrc4XJapw3M9BBIWN6SypSov8Pw5syGAF/+14ftawJ27Yrc9rzxBhPxqOuRoc2PYwitS0wRAXKqTGRY8f87zW33eVp1NrnknyMcnyWsiybX/VYD8tGImjMsLFiz2cMX+1m6HmF2je484VPByhjUC99YzD21cqYiL/5jMGilBDBi7ecOXZ5hjq3ZWNGeF/R8SHWa6uGl/HDnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiIEZxr6rpwf3RKNWcCl7xPI6jF3Z+voPCYqqZd22/A=;
 b=L6VZ2BahRxnHRfVgwBH+wG1b1k4i/XF+4oKn0s6DNQwSpbYcP3EkaOS0s8o0/h+NbcvF6IqsmygBBuSAQVVf+UWTq3w8bV4jQistW5TxOIMwKRNIn8Q1mx9F75WSpZQKXOL0h0e8h66JVd9NTE2HHFWVePzLpaj258bv5t1msKQAfLCL1whmC5FH6M6W3qvpcjDPni+q8S45cQH6w0PyizuUc0tnIgcfn2HVve7GBQKu22WdrXllFx6rgt1Ui0c6QXTdHJ0i8hHD9Q+9lGJ5OH7dmUF+sX56XNoGAYzjo1ajlaBuihKK/56WA0F/ik9msUn4JlHx2GLpGWmypM1flg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiIEZxr6rpwf3RKNWcCl7xPI6jF3Z+voPCYqqZd22/A=;
 b=rbJMgM/L8WrlpWyuWu5nrt2uLmfd3lzRRLqYS62VYPNj/SL07omZ8r9AC6CADPOgjBQMTUtVjI2CAkJeqejCl8Hyc2IbvaGM1F60no5v2q0rdyObsUvqrFSVuNoNUuiliV8pS3QwVYjGJkoXdshH5etuX7/lm8Pmq+TywBdgFcjqDG3Xfs3oVH4TvvkNm8Dvm4SGFySCWp3DNqlpAXjBeZSGvmy3var/9N+taoPRfBMN+CyG8V+/oojb4TxzmZy7YgL/J0RoaftZ6kXUPt5qb3hsScV/D2pG887K/dN+YS+9+lIofjTt0SJPQR8o6gVAepV1LzDlgMtQf3Z6OY2CbQ==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5159.namprd12.prod.outlook.com (2603:10b6:208:318::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Fri, 28 May
 2021 23:34:50 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.023; Fri, 28 May 2021
 23:34:50 +0000
Date:   Fri, 28 May 2021 20:34:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, Xi Wang <wangxi11@huawei.com>,
        Yixing Liu <liuyixing1@huawei.com>
Subject: Re: [PATCH for-next] RDMA/hns: Refactor capability configuration
 flow of VF
Message-ID: <20210528233449.GB3862344@nvidia.com>
References: <1621860428-58009-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621860428-58009-1-git-send-email-liweihang@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BLAP220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::16) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BLAP220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 23:34:50 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lmm09-00GCoT-Ik; Fri, 28 May 2021 20:34:49 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69485d3d-9ec5-4e6b-8c5f-08d922313012
X-MS-TrafficTypeDiagnostic: BL1PR12MB5159:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5159308DEF13DACDCF499E49C2229@BL1PR12MB5159.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IFxL9rIJGaktu46JpCXYjfH2cHihvirKpNTQzo164R0v1RlzvZGNorTwQFqS/rGLkHAi2ccnSRpNOxU8vgNwDfgPzyFy1bSk3QRKtsRhGTdmLrSeHWaUxspwlRqUUBfqHwaqJEDbVnbvIg1lVjhrs2tGG59xFa2KNT/EBEx3MLR+2v+RhJ3p1p94rSJkplEVqI1ksVHFCHUAV46FBPF9Ci0GZXoDZ/FWrLaj7reHkHswCNivMyLd5A9V9VyIi2X2nvmls7D7LMpR0MfyOziLhlfA1QkEbmrQ+oicytW8zYUZTF2TXnjUzYbFE84/FubEcHtqw5lt8Inx4/76Qdi/ZrADnUqPADsI+NmNveemnhU61MlFUL/SRj7eYWRJwGdhAwvdm6fYto3kOmm3JFfHxNe11Jrrpz7NhyaL+BRrDrrSUkQDUHApzEICdY5elm7xS0Bi3QVgJbgWwzzTsrTV7xyhMMLDTfpB9avcn/wV4vCFatQnoek8+Q9sOM/lYP2fjfHDqLW0/y6IzgoOb7YTtdCenkykywihCoFZV2CcjOBDSCkV8hQDgrknQwhhX6nSApfMvFqonmNjDwMkdijjI+W2OD/VYr1DP+xGIFr720k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(39860400002)(346002)(396003)(86362001)(83380400001)(8676002)(6916009)(316002)(2616005)(186003)(2906002)(426003)(1076003)(66556008)(66476007)(66946007)(26005)(5660300002)(33656002)(38100700002)(9786002)(9746002)(54906003)(478600001)(4326008)(4744005)(36756003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1h2kS5prIg9Fl8YT9hHNe3ArzGbm7Hc5VuRFVWqjHoc/sTlPi+YN9LhEwrvJ?=
 =?us-ascii?Q?qsRM39hh+3fKtaVhrJiH5J3HBxJrtByUE7eb4HbINbB5EWs+ZY3080S6IFB2?=
 =?us-ascii?Q?RCPdl1FAUqhvi1D45guxeyAWfREFCqCz/C2Bt6TrCqGc0aqULukkf311YawD?=
 =?us-ascii?Q?VyMP7wyfQ+sEHQiyn/ExuAQ0IZb96kqn58Eq6Qggv0c0K+sQDavZsddw7nXY?=
 =?us-ascii?Q?RW4yrB5Vym09uqRAR/8/BddzOryaEcYdcJa57QrlgStf+0EmHA3Uvtwk9gFi?=
 =?us-ascii?Q?ZnSza5PdOtPJb8gjuXlzu7uvfOKNBBSqFsC9/AV8B3nqlCUJXDtvlrXGjDnU?=
 =?us-ascii?Q?Ffn5+66ATPW5gQBveIEuiBHAn8nV/yV8nEWDo8jfSORXdDkehDymsaBT4be0?=
 =?us-ascii?Q?diXqh9QzXg8MBdlUXCUxHRWnuOELg3XApOFc8lYbRXUNYknL55BjSyCMWhkR?=
 =?us-ascii?Q?X+QxkVbVoMp69HHs9ejK26x4vChfiEHODh0eO64fwWd3Xyq4F+ankWrmz3ks?=
 =?us-ascii?Q?uIicWFTsoklZAfhOcfOqVOAmUr2jCtmWU24kSS+WKpGkHPG62cewkSJ4Kl4R?=
 =?us-ascii?Q?YK9N8eFGWBQ3m+fxMQHbNC2ny2qR8xFG1ilZk5PThpFR9JBiHe/BhOJQ+1cq?=
 =?us-ascii?Q?Pdk7hKuXGxlxwV8h+h5qdbwZH+nZoDgMl7+oF4RXGwQwVov04Mdus5AXEKSu?=
 =?us-ascii?Q?LB366hHgWzPu+90nseRjbOwindXupu6t4/b9fp+S4FjLxJa1GNQiejg5g3h6?=
 =?us-ascii?Q?iRtOc87u8D3uXJQfQ9IRT9ThJWLQWfd3W4Z6vV0Dgu80ngpCxWbuurArzYOT?=
 =?us-ascii?Q?0229wRr2EL17SBWr1bzWr1DvAhyMI3dx3V3p2v6OoiEQfQZ8fO4Ny1kTzsd1?=
 =?us-ascii?Q?DSLgxzKSI3d7oZzcuBaXt45gDM2IUU8FgWsLxb04Q3igMEaq783u6eNmQfAs?=
 =?us-ascii?Q?ljShIVwIQ+9kzX8nDdz9GldvN7DdTZ5uZh65ADcL3u1aBb2Su30GYtNo8huY?=
 =?us-ascii?Q?TttWcApz9ej2zgw2cbKDCORcOc7j1ztdgoKiiBQn+5KwFbszcK78DXPGdXPe?=
 =?us-ascii?Q?2NFkaOFoL1wK23XAjHDWXkQZv10ZANsPW47GY9bjJpmYjMryk2Bf1107nMpJ?=
 =?us-ascii?Q?4hEstsaM6Srvd59V/Azifg+H+hHprh+zAC18tGkQF/5PKT+j7Lu4APM8AzoI?=
 =?us-ascii?Q?5bz7jKPW7wT42ZXOCrIMf3mzeLe7G8TLsqmLYGgKoRotFJVFeMsPqvu0y3tC?=
 =?us-ascii?Q?+8Ibcpm31kV+o1B+l0WfyIr8AFwYDGHZY36D/nxKlDosqcX7QhT4WvpvWbsN?=
 =?us-ascii?Q?sDhq7l8NioZwrQ4BVgA3ONlU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69485d3d-9ec5-4e6b-8c5f-08d922313012
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 23:34:50.6303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KajKAonVodZMizvE/K1cv/HsUvDaKaFCksmYuXeWCOop0arKl4YK8IP0fVyeN4/k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5159
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 24, 2021 at 08:47:08PM +0800, Weihang Li wrote:
> From: Xi Wang <wangxi11@huawei.com>
> 
> The capbability configurations of PFs and VFs are coupled. Decoupling them
> by abstracting some functions and reorganizing the configuration process.
> 
> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 300 +++++++++++++++--------------
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h |   2 +-
>  2 files changed, 156 insertions(+), 146 deletions(-)

Applied to for-next, thanks

Jason
