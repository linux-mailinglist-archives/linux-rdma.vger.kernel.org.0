Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7A05171BE
	for <lists+linux-rdma@lfdr.de>; Mon,  2 May 2022 16:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238259AbiEBOmQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 May 2022 10:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238156AbiEBOmO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 May 2022 10:42:14 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F2312A98
        for <linux-rdma@vger.kernel.org>; Mon,  2 May 2022 07:38:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiBh9SAli4qoYFV9D3w6MenpLeykEb36uRWLKP+V30tzkEOpHNsWocFcffXeQwUQTjky1q44uvIOgNAMGy6mkDntmBhF95RQasXWqMEh3DFIsOLRVK9ScjgCPYI1oJ9R/OS+uAnmzads3lQgG5J2gb9vmbBr1/fB044Zd8zWDUSoORNeqduAdg+IZluXg8IeEdFvwuBSwK2qk5L/BqFzj/UgrCYILYc1S0X7hf+Vqu4hqseBzRmC+A7XcAnXWe52jSmOL2uZtgytNKCcSstFeSyf5ar7oHJ2ZWWdEyS3xu+MWEaQYqzuUn2/za7F8pdlA/XUZmXriXTcFoWiDy7juA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SBb6m6wHWdTfvlS7Pi+aVUwZKFscFYsKjvFWwr9Xo4=;
 b=GXICS8a9uoHXzmoGE1A56r2YYV+Of3BNVXhIF9dr9tMux2sEw9OXTjujC85aYyr8/BJsup1SHFRNZT+8hlRkLdEMZWz8qOHg4EpDV5oRnzEhyUgK7Sexb7ocSHFxz5veJcXdGVLBRs7D46UJmALMpNz3L0G+WDb5LXvD+ZnOflNQy0FGGM0XXOMwu40C+GPzD4taEA9/ro2p0b4qy9DjHnevBA+7q56mlylEss9OPlkvcx7L7elZGW7EGTiAoJjkNlaxsoo1IXafnphQHiRFvHeR/0a9g4a3E2vETtuU8lzPsAGSBxDixuZvSrWVyOgS5NR87jEx4dTyBWf6gFiUmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SBb6m6wHWdTfvlS7Pi+aVUwZKFscFYsKjvFWwr9Xo4=;
 b=KBzDMx6We6phksqSaYvj4/2yALxD2tVRBVwDClHw/h9D/SOK2yAN1Gt5Pp/QRZwGswvidyDQ0Rz7Glacfgvrt8ATx3QL0AFsUmBx0aAGvGy3S75Qh5loeZlNAm+jVN28DdBamENUW2zBgnZG3acAj+YGMEv5CfogFg03KWH16cIRc0T1GOBYqniOzAcmNYA2FvBf3MGsV3MlgFmW7yjW5rEgaykRUo/cs0zpEvk64Ea9AUorlRdht0hE1sNUvnK8yzH/qzKah32Ww/Kv0iPL3YP+3JpJ2hMB2rAgtgbfiYDgjwbilLfS3AL9hPHOpCQKw0RORsBYOK6+2yJsymDt7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH0PR12MB5220.namprd12.prod.outlook.com (2603:10b6:610:d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Mon, 2 May
 2022 14:38:42 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5206.024; Mon, 2 May 2022
 14:38:42 +0000
Date:   Mon, 2 May 2022 11:38:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc 0/3] irdma fixes
Message-ID: <20220502143841.GA427223@nvidia.com>
References: <20220425181703.1634-1-shiraz.saleem@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425181703.1634-1-shiraz.saleem@intel.com>
X-ClientProxiedBy: MN2PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:208:c0::30) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d178249c-02ef-4ed9-43a0-08da2c497491
X-MS-TrafficTypeDiagnostic: CH0PR12MB5220:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5220B94C9040B6B883FEA7BDC2C19@CH0PR12MB5220.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /TbBaIiOqox4s6nCoM4YuafLMx4PGfcXjaIu/cUZnCEcPBj1q/nIP7I5gblEnguAZ8j4kiBx3XbyxXGcdOSmsZMpOpBbtIIydP7stM7RNe0C7HmGXNQamvlW3x3epCFnF/sx3iMPr9SqAm28krP8fI+jd2trv8V0e5+inHQRdSVxFXVY76bBqmZxrNuD2H2odDN0Kq08J5qNZJrfOt8lHBEQ7IqOYhsM85TkmcSAGosvjuNBxgza+iChoYMLEAGNpFl+f+DfxqLzKeo1aIQ84KitgRn6nB1uuTUGoNAbYfbasB9bMWW6q0m68ZF7XKQKMCTIiP/fBcXP5fVBEDT2UpW6EjK8NTvcsXvS1s+ydIv2JvpTSHngpORSwq7LTbSksFSHDBntCHKAtayF03UkWGnmVlx/mFBb9rQFzwUR4qNdcTmVl8vxXO1vCcC/C3Bzu3yvnsx0YJMl78fMKNQE+f7V9A5d8Yym8y4Jd+Eoi885m/EWlL+eXY7zUoMQXt40ge7VP/zG6D3AqFQLICVjfJyAAUg8lK8OUp7OvWBBPXUaiycAVvtKsyv0ArZUso4a1TAd6H9ocHWg6K+tb0gwnz44PkDzjTE7BpvHhmAbD47YckuWChRjw9PXj195VOkFYc3S5z6t++Mtqfx/6fQdX7nZrh/Tyw2zYgZ/cG2mzTMDLq7zFz8Ah0se7Q2ANzrJ9VE2rQ7wQ4XHVbngJOaSVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4744005)(5660300002)(6506007)(6916009)(2906002)(38100700002)(6512007)(26005)(8936002)(36756003)(33656002)(6486002)(2616005)(1076003)(83380400001)(186003)(508600001)(86362001)(66946007)(316002)(66476007)(66556008)(8676002)(4326008)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?teD3ieSlSHHmpkeryzozmNH4BpPtVU1gmp4M0i/BvXhHfH0KYpkDynhoPMZ4?=
 =?us-ascii?Q?8OAT5tIH6snbPMGxBA0KZdFq3OZwDzzly8GWMwl1D44pM1420SASY3J4UNeR?=
 =?us-ascii?Q?21ugXhePkk7KM9kkwVIV/HP3Wl3UvUz9dsUloGF1V/vBrE0XqmtO7jmwySQR?=
 =?us-ascii?Q?jkjGlf9NJP04R0btixlhkxVxNEt7mZn/h4VApea9XeuK37c9ymzQXjhFReIa?=
 =?us-ascii?Q?e3z4NrOYZH6mwWp1+KR08f6KHc17gpY0lRdrXS22S6++69SXYpKQ0ijTZMPk?=
 =?us-ascii?Q?DxETbZOAu1EsvUG3fdEfPM6Ic17a7OezgJL10+A+3Y2dbsf9h/RKMstHeykU?=
 =?us-ascii?Q?LtH1qpUjqfnJY4Ty8Fj4+tOwWoGJbPEzVn81TVHrJ7DXAolEqvExGmEvApUo?=
 =?us-ascii?Q?s67FLUSYgn5v272lJqRoAZg6uDIQ+Ba4KdDFQOKO3c7dQ0rQm+sPY2TIpQBE?=
 =?us-ascii?Q?wyHtPH37AukGJW9yIQVZ6GcjeVJB8h7Q0Eb61ldxzEijhcuTH9EkyJuB8CUE?=
 =?us-ascii?Q?09L6yVLyOi0QFWzNDRkjmVJ+2nRYgoOmo9Awso58P9CQ3Rd2qYUvdpP8b3yl?=
 =?us-ascii?Q?Dv8buSPcweC7jLIHA8Da7+jKQsDzrQ+7CAg+8GsOtJkTzq0jl9CgczdubzwO?=
 =?us-ascii?Q?M9Ps7J4w9CJUGTz0TdnciYTGqPrPSFbm6hGvDa4+AVcleOK6rHwNaUpaGyl1?=
 =?us-ascii?Q?D9CyTY3B6NTWNwBQ9CVBIsZNFOiqw5Ve2cp2hC2BXanXuRUB+HEUOErbWPHM?=
 =?us-ascii?Q?zBTcY3YSzkkjZiNvs+meFi8QCN9ey1ToGNXcwONgbhpditDCqto83pOh579R?=
 =?us-ascii?Q?g2uDuEHGlpq6P1hNCPaslo7IHdnuHEK34/YwnFI6NNhyxeglZCoXyHZs7SWp?=
 =?us-ascii?Q?oPkm1pMoDBivAOJ4vgJQVAToYZqaz1BWOMYZ83Lov5XJaxgb0AU2wTeNHj2Y?=
 =?us-ascii?Q?zd8zaOi7rpeCdYLoe5KTL228vcFx0koc9Ww0AtrgW5SzgaZiMczPRg1L4Wz5?=
 =?us-ascii?Q?BUxLHGWGhZ49SVlgiGGefZI9+fOGgb1ecLuOBjcfJazEYOg8C6ayz1HGtoNU?=
 =?us-ascii?Q?o43JOv4lZ4QEN5gAQ98R092IAFB6a16lAboKgYNzjq74BQZK0bGb3Dazm7R1?=
 =?us-ascii?Q?TO+4hwIVGMxXJ4dihMyRbWq+8ehqt4KNXaOHzEgeAA/m4NQG/Oa6DmDJ+/Cf?=
 =?us-ascii?Q?N+fVlSQLA0tDvx0qwzXWCX2KSaY6NbSHb1oxTzBHMnS4eeWgM+scfn38pXKM?=
 =?us-ascii?Q?WxCW89nFl9yIFBCJc1LERx+NOGX/+M6PFYmD+nGGVvQF6+oxynqfnKQ0kvpJ?=
 =?us-ascii?Q?poQ8SV/EKXrUda8+zJcVBC+/NZR/rtJz9MczNtm7ZscvDoGuRI2+EtjjOwnF?=
 =?us-ascii?Q?JCtN7mxEcKBylv+S8JWZVxQlpZBVf+iSrgkjcqLHSVKtdlS2DLdDZXIxcetN?=
 =?us-ascii?Q?TkGW3bp4rmZHX8ZA15w6N33pewYihc+noEU90h4CrcLgl5dDSPadfOmV/0Up?=
 =?us-ascii?Q?3zKEEYalNwT3qe6T5sBtidze88BVV4DtvaALF8lSHGytq8RNkmoR6eynn7V5?=
 =?us-ascii?Q?SspFQxvsmgkDule1xe+JH1KDyF/8F5BbyykidcuKHQ2Wpzem1wg9VYIb7cDo?=
 =?us-ascii?Q?g4nhpx2hFQ9mhI4OkU6HPo3ebS/YbeQUVxWblV4UuaOVMCwGMqoYzzrgKtun?=
 =?us-ascii?Q?QRdbOAV2pe+TY39atJnv+ZJR+dUYlTSx6XO3NCPsG9UdKN8RhCuMAw1pw9UH?=
 =?us-ascii?Q?6xxS5fMKpA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d178249c-02ef-4ed9-43a0-08da2c497491
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 14:38:42.8289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5vhRdpi7CSG5t73xWnaTPviRMDm9DcwaBD8pAwexbrcAv7zsa+iNB3kw9npKxzh1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5220
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 25, 2022 at 01:17:00PM -0500, Shiraz Saleem wrote:
> This series contains a few irdma bug fixes for 5.18 cycle.
> 
> Mustafa Ismail (1):
>   RDMA/irdma: Fix possible crash due to NULL netdev in notifier
> 
> Shiraz Saleem (1):
>   RDMA/irdma: Reduce iWARP QP destroy time
> 
> Tatyana Nikolova (1):
>   RDMA/irdma: Flush iWARP QP if modified to ERR from RTR state
> 
>  drivers/infiniband/hw/irdma/cm.c    | 26 +++++++++-----------------
>  drivers/infiniband/hw/irdma/utils.c | 21 +++++++++------------
>  drivers/infiniband/hw/irdma/verbs.c |  4 ++--
>  3 files changed, 20 insertions(+), 31 deletions(-)

Applied to for-rc, thanks

Jason
