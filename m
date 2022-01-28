Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED78C49FC26
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jan 2022 15:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346463AbiA1Ov4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jan 2022 09:51:56 -0500
Received: from mail-mw2nam12on2077.outbound.protection.outlook.com ([40.107.244.77]:44842
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349509AbiA1Ovk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jan 2022 09:51:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OURFkXNaOmu8CJsB3jCDIhOjZAZcGg5rWJ8JXjIQZdzQPc5XuxNl3yZ2FJApJUDHgolVEfn6AVFNELZf0Bq9mwz0WjSqVR6o3zY39tXMH5Ka/QI0F6ihlchvLqrBjm10VcJAlGHiCpgmdLJCU5INLEsSSnY93r61nEgJD6Z4yWYroY83xUIbAAhnnTvoa5M1YIMMA98veT6PzIZzC5FT/JKNb2FkI3bLGc2TY4yDsOF1QmIYg9xewNJA/mTZC36ljoCACXSCjGDnMtomFgYGSQHW+EZ0Oqc/W/1Fm3QgD9fKIumJHA0/lHrNnXpV17aihCuuoTHuqQDSsvnwq2SGfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uLlQImqcQyiJ9ym5TkYbjF34H7KITOewLOCzpKlNvc=;
 b=f6nsd/BRrtDYnUFrlBQTfTI14rEwy2KO2dOw+9ecpIRrqNIA0xKvNkcf6Cl9dEZY1JW2yPRwb9ryhtSI7mRnQuFv1rdJ8Ea3mrlE7euCBYscS77sLcC//Co5Ju+lVcfZxQdNcsBPD1PD+PcmAZjRbonLARKbcnMO3p8mr/PKbBvy/+28rHEO08elR2mwRVFEhApRjKXIy0CnaXDeQmsF8PPlzQ456S2FAS4v8VMNOrlaQpVd+TGUz2QAEmbiokCgddp9QZdnZwjWptlQ7FOX8o5C7v53u0+CiuOFdLsFychZ1HmVD1axr8fa7taVw2cWMtJOK6z7NAoPLjJhpxNbgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uLlQImqcQyiJ9ym5TkYbjF34H7KITOewLOCzpKlNvc=;
 b=KZLyJ3EJjdbmNGGGqmDm8RYg/kkB2qerqQ9/TFsWcBvallYA8EVY+I9wp1aX5mhm0eI22WWpUmYFaeLdfGWTysdXtoUrT4kfTAoq9jJfSGLOH1TexdicUwXIgvgm/DAvUQ1Zp2aAjTN4ao6VtauPkqvHxyShkcl1S6koaCjdXS1u3k1s56CrUWttNlicFHYBrmBdjjbZnV0Q9HJfR8Iz3HGwf/qzPq7b0JsFmOr5by05xl4Rwb+e2pqfipUz/R93H04KWp+s0wfxVE8LaznCYqCz7F1Ynkej/PGaaZE3sM34j6+0KP/Hdg2UCpL0x0jjDh6tCIwg4scbBqyC1zVZ7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MW3PR12MB4362.namprd12.prod.outlook.com (2603:10b6:303:5d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 14:51:39 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4930.020; Fri, 28 Jan 2022
 14:51:39 +0000
Date:   Fri, 28 Jan 2022 10:51:37 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Bryan Tan <bryantan@vmware.com>, Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/pvrdma: Remove useless DMA-32 fallback configuration
Message-ID: <20220128145137.GA1792367@nvidia.com>
References: <10c29cb45d14fb8ed89cf1308c4a9a7d445c52eb.1641717275.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10c29cb45d14fb8ed89cf1308c4a9a7d445c52eb.1641717275.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: MN2PR12CA0022.namprd12.prod.outlook.com
 (2603:10b6:208:a8::35) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38f2596b-613f-427e-d877-08d9e26db059
X-MS-TrafficTypeDiagnostic: MW3PR12MB4362:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB43629AFFF3C506FC8DF295A6C2229@MW3PR12MB4362.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sKlTvBug3MVDITEEj7MzhdR3wKTYNpK0ExfWh1jEnL5h26+pdLBKWOOtKl2ipQvY8BPAGfxh9lzA8uhO9qoa8SGbCOPwxNmdSgr3YIcsBc02XR4rY+fLheGDZN66PytnksOHMJQnvWjKyEB65wrNBKulVS4vVNjHOmsRqLsvmiuwfKhStOEZM0hsUD8Yud2echXestDfevL/V5vVt6v98OIlWbzJeOIJtgiPY+1VOXfDW8ykgcODtjwDCdT//FPvpjmnBg3l2NXRX7UZkZRvpRx1MRdMsKabj5IFbj/4roGZnmAtFLg/ln9HGK4Iy8sDLjAbzVw7ARqexvvw2ycL8ELtf+z0KhNVofQqfBe/u478IVVfHj2/Wc25x/AYEXZcq0RnWt1jVihcsFd493m2Wew4qnWUkabpDodWwwLvPzzA+Tt+o/2GWiqUsHwyiU3mGKtKXTYVOyOVBs3x5mHZIpCZMC8SBqjODX5xq2tOI1Gg6jSdoNDjH5H88hhV7igOfEEbAQTvy6TSiQ8PD8mvnMPiVIsO3Cf78EMn+3c1JXEzS5n0LXTzHCiMdiLgoZ7Tla/JXQ9Mse8n3Llsm6Cdae4FAA2nHrBJgw8/L4ulkdFOwLKMD4TQF2yuhXUBxB2fGUNX5VkOWgvi7IgqUGMvKD3G7ro/liOcsB5+Xo2SBlGhsy65LbIh2PXum9vMFfRIIALlYRPx3AbOsuBFvsFPOn8pRyg03q4sle+emzjIikg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(5660300002)(6512007)(33656002)(26005)(508600001)(186003)(4744005)(1076003)(966005)(6486002)(2616005)(86362001)(6916009)(54906003)(2906002)(38100700002)(4326008)(8676002)(8936002)(66476007)(6506007)(66946007)(66556008)(36756003)(83380400001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DEu/+bJhnKe6hRCRM2OeoCtRIOuWGFIQ+f6y6RL9HjGLpaTGqZmjKN2tjEjs?=
 =?us-ascii?Q?mINsKbKPNMi9ikuKUkdoItT6K2RKIusVnKL/GZo3Jv8a6tMX/35WHPKIQH1B?=
 =?us-ascii?Q?07RkihoyLfYZiU8eqAqw5qUQXmwmeG2+wuxsj+sq+QdlZf2CijFmlppAnqOD?=
 =?us-ascii?Q?u5uVPhh4CSaCav2kTy/zqtiy8osysYw8Isbcgsc1t7WHY4AmBHF4mv6ps5Nx?=
 =?us-ascii?Q?ZF1udaLvf6dAd1j0o7vGZq/tHXWaEN4OQsT0cVL1YDPuCxgl+e4U4eRJp1l7?=
 =?us-ascii?Q?P3DIA1+th5MZmsjWibdBlkrYXoxYPfcGJR2SX5A8xKcu8uFYZnyBki4aKaCe?=
 =?us-ascii?Q?RTzKUQve/qNNb+4v63fZNfD6J5xrypJtxpiKdP9Aq2XTzjWm7ngwYThEydTf?=
 =?us-ascii?Q?wN5IJoMhwPSK54lpMGCCf1XaArZ8Y5SVu4Rxf0gsY3GBzk5Cf/rrzBXXgi0B?=
 =?us-ascii?Q?yLSnBGSJyUbf9ArBzcR83QE3Qsvwohp1JrPqAATkUMWSLkLA6P+e0RZ1bvwG?=
 =?us-ascii?Q?laud314tDAbzdetd5aUpgKKFeQ/lrAl19Lb3xwt6ZHOrIe1GffyDCn7+6AtE?=
 =?us-ascii?Q?Tlg6v0K4gPxFV0hozpiTLfYPk+3aDaDdcRg7spJHe3sB04uMB63tcBwXIiX5?=
 =?us-ascii?Q?zBnFYTRfx6ZnJgiGrESH3uDCllhm0PlmvOLZLYwhn/UHpJze484LVXhUoKZb?=
 =?us-ascii?Q?b/f4yxrM7O8VWT7GGrgGlvhmxLNlddBX9PrHDQTEgjJmXyBO9GZ+y3uqar6X?=
 =?us-ascii?Q?Qjp9+AHW7rCCcETQfpZQU5HGo/3Et4bipuBAysPO6t3TcDKDLzjNIEYEHxs0?=
 =?us-ascii?Q?Yh/SQMUI2mtC9NoJO3GuOdNzh4k2crY3D17sGtvntt5oDa3743A9wu+BRs4V?=
 =?us-ascii?Q?hEezRxHW0nMsuzHPP01LbUjKFvGd9H3XBdpkgIw0ep72ZZTcXHzqlnsnsbWn?=
 =?us-ascii?Q?SN2mKVBffBSm7H655T1wCt2H6FSu/jGGu/PkLP26dteDwKxh6cLWgi0Dz1uv?=
 =?us-ascii?Q?w5srXMFnZxtE3O65XAoRx1YlIDxiumF2GDEDjkBF0hhe8e9e3OFlxEKr3Oq3?=
 =?us-ascii?Q?7HjGQJ15AaOTpY/ET/5U93BEE1+LhRS8v1TYn4zOnCTV6jsqYj0etrhHALT9?=
 =?us-ascii?Q?vplsoC6XzPoik8HhR0WBe/VxPl/sOE88/voVR6aCvxh2Mqay1Kt2F67tMH81?=
 =?us-ascii?Q?3q6gCF/0BbWan/eWnvOOswiH1rKd9znNwqRGThrof8rG1MxSZ+yiYRAG1SdQ?=
 =?us-ascii?Q?AJ/jC26cxif9D7hIsRef1TJoVieUPxp1S42S/QG87vmkWcBczB5R38s8R87g?=
 =?us-ascii?Q?ecGkSFYl92W8oE52crWQXEMiDdhlTql3ny+LXQZxrDGsT5NqN9cggGK9PNCQ?=
 =?us-ascii?Q?WHueSQQmk8KK2mUGXJiardUo0m+b/4maiERiw/kSfm5FY7gOAp6HAmEas1os?=
 =?us-ascii?Q?NJ1LniKyCyXQuQKrXzVj2yJ90+yEW03qMgNvsaudMvstSPmQRp9RQRYbyqgl?=
 =?us-ascii?Q?yszuJC+mDzDgBunS10Kdw2KPYrmylj56kWEZxzBFDp5ZtACfdZZabPmUj7Gq?=
 =?us-ascii?Q?GmPAQVH8LDrquYmTbVM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f2596b-613f-427e-d877-08d9e26db059
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 14:51:38.9500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sDBzrHkAY9Pa4Q7cGXnRfALK19T+4NoAl9AHklaa9uYy+zJA+5NkNBglOG38QR19
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4362
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jan 09, 2022 at 09:35:18AM +0100, Christophe JAILLET wrote:
> As stated in [1], dma_set_mask() with a 64-bit mask never fails if
> dev->dma_mask is non-NULL.
> So, if it fails, the 32 bits case will also fail for the same reason.
> 
> Simplify code and remove some dead code accordingly.
> 
> [1]: https://lkml.org/lkml/2021/6/7/398
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Applied to for-next, thanks

Jason
