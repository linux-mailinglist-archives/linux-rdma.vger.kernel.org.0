Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A17141764D
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Sep 2021 15:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237924AbhIXN4L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Sep 2021 09:56:11 -0400
Received: from mail-bn8nam11on2080.outbound.protection.outlook.com ([40.107.236.80]:12545
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231510AbhIXN4L (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Sep 2021 09:56:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdpvEC+QNMkFOFrf92O0pXLqvIujSDviJu6FZtO2x871ghpN1k/Xl+66LMO5P1Jq3uAgf99IWmqE8KyI6BVD2hYpMImaboZuPL6DaYZGNbmHu/RupkuWdD2UMZkk+AgGf9AQEyG3IjMCQog0RxgcrQJwbXuC/MGlTdq2pxyTama77yxWsoHchb56IFj1NNJ+BKiJT9yt0luUubNMOTP+9jWxLYA58tnPekarkqO0PRZLY5Cv4kiQmD6MWvoZ+ew3xv5Lmh9U2dahgmW1gtoe75bZBkXoottHtr4ycxWZRcvptXiGIwQIFKsjfCYXjuLdRX/1pJVcfM0o+KECEISJpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=4BZKUshu7rxiFWqDHcrshzqk45SOQmQ99nfusfnmjag=;
 b=LlLz+QEZQvwKgVVPr6IPQzpUk6OoOr2rO9VtEPxlAiOZebkGl2/3G2BiAKmHTwWtJ4EJjLaAtzWZ5B84DHBtemk1mP4orZsIuwFkMWevYWlrJDd1kGQNLT+kEsklaNYQ98X1zNpP7xKDQL7CuAVey+aVJCbuv3erl91pvTrDJJ4bXNbpat1zHQBvKMmG2ldN6KOAwRm5uQl/O5gvHCVMaNiH+ifmQdwsqh5adhGQ4ukZZlmuXUjJcGM08GVES/NI7H1apPuGQT7FrE97B1iDidWyF9aVDyj1y/nfOTtHC6Ob7u6NIGKI9iTwiek9KpYbGxUk0sxhAU2cgrOaEZQvZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BZKUshu7rxiFWqDHcrshzqk45SOQmQ99nfusfnmjag=;
 b=NKJ7X1t5b8uwyc0eg7D48l59PeDn2jGKPEQeR4EtR0kT3d961J249hqYYXWYWMj/Z5OFmZ1dRyN5VQeItAlycmAckPHX4kWsNHMgTn6hXq4qrNAh6TnToOiAMSMlCsG0h/8H/urYEY9knPoKoTe7pEiqIy2ZvZlRKAsf0sX1QmB7AG9RzWhJprccXHMr4gfM485ktaNEU/6+1dL4VXGA8NLRslqIX2PuxVGDMJGQRDOdF7vHAER1skMFuLKS7GYFQqJlrwaM3knGWVCVweG5wQICzWZ9fd/eacFWM8JBL9yHH5KPpb+7LO0wRpDEE6ceOqRmGHGznrcTgCFOduNIvg==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Fri, 24 Sep
 2021 13:54:36 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 13:54:36 +0000
Date:   Fri, 24 Sep 2021 10:54:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        bvanassche@acm.org, mie@igel.co.jp, rao.shoaib@oracle.com
Subject: Re: [PATCH for-rc v4 0/5] RDMA/rxe: Various bug fixes.
Message-ID: <20210924135435.GA1235759@nvidia.com>
References: <20210914164206.19768-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914164206.19768-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL1P221CA0021.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::17) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Fri, 24 Sep 2021 13:54:36 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mTlet-005BUO-Jn; Fri, 24 Sep 2021 10:54:35 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c6de8cb-dc45-45da-c281-08d97f62d886
X-MS-TrafficTypeDiagnostic: BL1PR12MB5269:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52694C924C5A43965E85254CC2A49@BL1PR12MB5269.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:105;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O52yf9mR3fXD9vBOqp1rjvRT55/ZL7o1M/5440QeZ54+32lT+udDahRiPMMSSFdk2xssU3IeUC9pFrJXdgThVrdjOU5GKfktj+ZjDiPbli+eoArzpp2QwZuEzZ/gnN04iZyuF8TZvCwHYIC/StGYllyH2F29mzwOqyEdT+HLL069aLA9yfho8ICPxtC62nUz7sYVuYv5/zpmTfWgVk7NBLCDEXQUCUJ8k3L1YThVqcTMhLAEC1HQpSsPn532jMnfHh/atlpp9X6FneBghD4R4HIUlDUfwWwxaIBybz/rm9WqY7bpse+WKALGekex6EN0Ei2tbflsErKlDFCIZqrYIOPJMdkJjHMHLkdpneGEH99ArKc6vdNk7Jotw5/nvALGreGnX1qc+IheOdDRlSTcQV08O0uyV1Ir7fFJxGWm2S736jX8yoUlXqkQ+ZFKFLum2U2CLmg/dTzrXcCA8syF2faLOy6J5Owi0mKYPMLuIDzx5dnwHJrTD8pplcnda/xaogaSfa653zJE/pzqfpQa8lG6cwaW5s32b+WW2i9L57zuCEzPF/qQVgB7rnFMPlLdo9PNQPkDFlOpA9SotOtN/AsA4y1hE/xKcTuad5or14xn+WqjtvFrhq5F4EqOMj9q3FUBcOi+Gk9QU4amAZFusQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(86362001)(186003)(508600001)(26005)(316002)(4326008)(9746002)(38100700002)(8936002)(5660300002)(426003)(66556008)(33656002)(8676002)(9786002)(66946007)(66476007)(36756003)(83380400001)(6916009)(2906002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t3w7+oO689zkQXEMtOi5TD8Q3umrd6gIbPX2z9hYM0d6c9nkCf53gD2Dfk9F?=
 =?us-ascii?Q?Iz07eYuDU1lHv8d/tBxxgiP2mmPoop+UnPezNY3wu2HpYVL1y0wYatIegUWx?=
 =?us-ascii?Q?Fu1cA18QmP4ChRm5bKxu2RuyBTfgl3U8RzA3+RPyATNSn/ATzlujHwQzz/AH?=
 =?us-ascii?Q?fu7yTmyksbZ27SnluwBWERE4lXYLuIyEqDG/SrCpdzyDwiljM8U/1srpwqDj?=
 =?us-ascii?Q?c1wKucsEKIFsNkaNiBb+iVZmcjPHmDZTE2UQnqVTm2Og93TFtdCn9A3/Plv4?=
 =?us-ascii?Q?03YLDK/IG1LyHaBuTFFxdnBp6O0YnGFT7+ZUWaNbDloiwof44RUjIAN1Sa51?=
 =?us-ascii?Q?RTwPwq8TXhcbnipc2SD70aK7drsoP12ImzFGxTEYD/A0Dk7eWIJqo5EzxWIJ?=
 =?us-ascii?Q?52rbBQbbxW7tC8R2/l631wf+1KDLEJLw+QmUJl1Srd3ZlimM19pvuTu/0tb5?=
 =?us-ascii?Q?9TTVI3HUnHF4VHCJlKxKcA1GOihETTRoPCdSxO511fzzWtLixba6sC1SNPjR?=
 =?us-ascii?Q?NVEcolfnDVtxDNgFH2dVD+qAkjr+PZexgXUvqNQVkLeihxXMcF7IJyeEsDh3?=
 =?us-ascii?Q?FY1TSE0zAdjR3QVonrkGABdsWBoM/aT8M5ZAUkpIwmc1/uy4BTe4DY1BkAhx?=
 =?us-ascii?Q?CzOKNWYrOQ7L4/JSFmSts0IJ4WXHIq2kPv+NQgTfQR9hJ31DfL0a1Rc7S0y9?=
 =?us-ascii?Q?MMI7vxXMDe/OJfrGaciBeEr0TSxqqGgGV28rr+yhE5uHazAzs+j0ZPb6OX0k?=
 =?us-ascii?Q?G4RScQWDfLT6jtd59oD/58/9WU5W2iR752ZOtmA3Sj4DOT5kKV9QrIvPodhI?=
 =?us-ascii?Q?7CxzrL3EzIjHXT+8pyABjPPISaoIvkYW0zf4cWwginsYBSKAuJ7l0qj/mWeZ?=
 =?us-ascii?Q?VPCqK6wtGgEPvn1mXaNdGUgXyHI3Bi/W35UA8az20ja1yVnoO8sbZ5BRH8c5?=
 =?us-ascii?Q?UjpOr7EdFb380gF+JYjLVy45nuYGs8du7upOJzR0s5qytXzmfoL9bT6ozke+?=
 =?us-ascii?Q?OiKqavv7FMVuFGgPNM+BTjy08O9ii9ODbE0m4OynnaJoi2B2akO8Zyn99SB4?=
 =?us-ascii?Q?A4gjerkvCiz7Vkj3SDW3jWxAwjZPpiJAVX3BPsIzJh5j1t2bzcOouq0TUK6t?=
 =?us-ascii?Q?hx5vcEsxikzdGiOmXF8zNUZSz7SsuCSDgHaWCcjWaTxInpXqEwiY4gfBoilV?=
 =?us-ascii?Q?F5wvkVwKL9Y4x12gCDfOevb1Hnvx3zLqbwRipWV/8s/RjTw3Ht8X1gmtSXJL?=
 =?us-ascii?Q?av/XKx8RDVZHBHekn+jS6OAWSHOO3KFmK9gxf22StCeLLaDOndt6xemEx+0E?=
 =?us-ascii?Q?iO/NmcMst17r6QaY5QM1t38i?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6de8cb-dc45-45da-c281-08d97f62d886
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 13:54:36.7810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mcc4Dv3xq6ST3CbpiAKJYcP60V12NDiwGwYMQMOlqhRb50rUiXme+Tk8eXiB7UWe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5269
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 14, 2021 at 11:42:02AM -0500, Bob Pearson wrote:
> This series of patches implements several bug fixes and minor
> cleanups of the rxe driver. Specifically these fix a bug exposed
> by blktest.
> 
> They apply cleanly to both
> commit 1b789bd4dbd48a92f5427d9c37a72a8f6ca17754 (origin/for-rc)
> commit 6a217437f9f5482a3f6f2dc5fcd27cf0f62409ac (origin/for-next)
> 
> The first patch is a rewrite of an earlier patch.
> It adds memory barriers to kernel to kernel queues. The logic for this
> is the same as an earlier patch that only treated user to kernel queues.
> Without this patch kernel to kernel queues are expected to intermittently
> fail at low frequency as was seen for the other queues.
> 
> The second patch cleans up the state and type enums used by MRs.
> 
> The third patch separates the keys in rxe_mr and ib_mr. This allows
> the following sequence seen in the srp driver to work correctly.
> 
> 	do {
> 		ib_post_send( IB_WR_LOCAL_INV )
> 		ib_update_fast_reg_key()
> 		ib_map_mr_sg()
> 		ib_post_send( IB_WR_REG_MR )
> 	} while ( !done )
> 
> The fourth patch creates duplicate mapping tables for fast MRs. This
> prevents rkeys referencing fast MRs from accessing data from an updated
> map after the call to ib_map_mr_sg() call by keeping the new and old
> mappings separate and atomically swapping them when a reg mr WR is
> executed.
> 
> The fifth patch checks the type of MRs which receive local or remote
> invalidate operations to prevent invalidating user MRs.
> 
> v3->v4:
> Two of the patches in v3 were accepted in v5.15 so have been dropped
> here.
> 
> The first patch was rewritten to correctly deal with queue operations
> in rxe_verbs.c where the code is the client and not the server.
> 
> v2->v3:
> The v2 version had a typo which broke clean application to for-next.
> Additionally in v3 the order of the patches was changed to make
> it a little cleaner.
> 
> Bob Pearson (5):
>   RDMA/rxe: Add memory barriers to kernel queues
>   RDMA/rxe: Cleanup MR status and type enums
>   RDMA/rxe: Separate HW and SW l/rkeys
>   RDMA/rxe: Create duplicate mapping tables for FMRs
>   RDMA/rxe: Only allow invalidate for appropriate MRs

applied to for-next, this is a little too complicated for for-rc, and
no fixes lines

Thanks,
Jason
