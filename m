Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F6B3DBA06
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 16:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239013AbhG3OGf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Jul 2021 10:06:35 -0400
Received: from mail-mw2nam12on2049.outbound.protection.outlook.com ([40.107.244.49]:44352
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239042AbhG3OGd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 30 Jul 2021 10:06:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrgEToKi6tZIclXz16evTatdPTXsz/NvFBa8/swlKf4efMHfxlEM3+Kox8G9/2CVmFYlrdLq72+YR1zHpvfaFBfBVnKb9mfpIJI+JGtESjdXvSAIr2kOUcnA2ZcJ9PaBLLmKJXIosONMg5Kho8lRhu/w8K26A4HJRiYyTvxk75wlN7+5FfwlcEaN30ts2/N4rsNdzgPFY6HdD4doxGE2pkSBC4tU1/lV2Qx9JmJW0seQm35wH0KvaNcFJaS2T4eADzCqITMaTNAEihyYZ6k/kU/AEUok0VexbJlNyi8fYUjYuS9vUkbFJfOjI4Z4eRMViqtnnmz/LSBfd7ziACd1uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fa6ZbcI62hs8/ypDo7mepX3iUxZBYfb4Pl5U+5q2k4g=;
 b=CfZc4qGs8focjRA/uaIeMq+GepHLx4ZROVwsAEY36E1jClNgojbs/DO/Q96V2Tu24tn2rJ1N3dJXLa3P18d9ZLc4jGLGfpMYO6W1jSH41ao3Y/O9O1uOTu3UgwEAYvGSh4aeFGvepx8JZUw5Bc9wMD/6OxCnAvGqSYVMXQOpfPYWocaaMg5kfbi2+O2ST1ghVUNVM5MUV4QBT1QuaD61W59C/Sbo5gQI4chzp5AP1t+Ue7ZJ2piHMzDSXaNUI/Sh2sCjMyPcaIhFVOo47AMAxf2AoTk3OnwZZiG+MbzWGTPaE+94CZ2ZHTveVNpd9b13frZULpfzievJGaOomWuXIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fa6ZbcI62hs8/ypDo7mepX3iUxZBYfb4Pl5U+5q2k4g=;
 b=YJ0Ok5g72GmneK1b4nxAgpc1oy63Oi0tXzZxQLM531pdlIuy7r4LySBh7S7y2bfiR78ciN1WM/VU1CJ2g9b/pDUaD/lRo3PhbsB+ijnuB1YI+D+j9lcOkpqtoClmV4o7RvppckTiI6PjKR33R2yI2Brv0uHASxwFr0aQa4a0GSVxEKM02+J2JT2o6qt3Nce18BvpoA3oAZYPpuXgDorYpVbs4cKJtPlM4YJeuzBQuBNmnGoEitUoipWxLeyLDhlQczWaQ4mjJsq3mswWdnwQzwTMgXd5yq7aYsDPH9eKzIjBS1Ro9IKqu9Y18Xqc+sf8519kttEawm+sxd0ZZxeaow==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5128.namprd12.prod.outlook.com (2603:10b6:208:316::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20; Fri, 30 Jul
 2021 14:06:26 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4373.025; Fri, 30 Jul 2021
 14:06:26 +0000
Date:   Fri, 30 Jul 2021 11:06:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v3 0/2] attempt at two small fixups
Message-ID: <20210730140624.GA2559559@nvidia.com>
References: <20210715160303.142451.38503.stgit@awfm-01.cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715160303.142451.38503.stgit@awfm-01.cornelisnetworks.com>
X-ClientProxiedBy: YT1PR01CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::28) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0059.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20 via Frontend Transport; Fri, 30 Jul 2021 14:06:26 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m9T9c-00Ajry-UM; Fri, 30 Jul 2021 11:06:24 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b85bdbe6-6cf1-41ba-c3bc-08d95363384c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5128:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5128B853D3E5F52782463A5CC2EC9@BL1PR12MB5128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qpcOaB5z3n0DYr571s9WzrLs97GjRNQJ/TV5iaQKusbDHmYCT2d+tU634CxxDf/Vos4iTrYPnXquIsDL1BN31dQ5Htk2EFji88FR6KKCM+Ck9Gk78NmpmwfHfQDlepnnIxPdM5nBfxhHcdAr0VaJFGmyC18f7QKRz3G1HHgzi/2bbJFb6BcUsauRcWHs05Vbdb0CVQIpJtndUtKSHdggrccphcQ4YEXf1peZQyipHdvjFSZGpWg9lEtHmGriUmeTURPIHLqbMK8nW4y7HKpDJj16j6z71vEMxjpkUzKR2IwqD9L/nQ0L7U6Iy+30UTDPSprrmL0Wz3zhdAHQgHNgEb+gCUAJl/bhZ81/OxcUlw5uF50Ikb7p86tEZ+w7W11mb+e/Uz4AcQDGnJCJmDO8QIUcNwcwrtDwTgo31/B1IHNsevOTLx2UiWsSOePb15jBEJIo09yiIhwEJmWq9TrPwC2MhMADVGjtSqsjLVpA/wAro85FVkw+hwPiU+/zwjCjYxz49LY7tPHg+HsMPembGXEwO86Auz14vnwAlhpsZCYmh/5/+f5+N1tLIbDgwr4zMq8wIUV4V5LytffXfjmfwMZbbGA+sczg7nSpSaFW8dE1Zf9hLvid4YCU7DOFoEQgJ3GQrWuy4NzXiChlgNnMnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(136003)(376002)(39860400002)(186003)(4744005)(36756003)(33656002)(316002)(8936002)(66946007)(426003)(26005)(66476007)(66556008)(2906002)(4326008)(6916009)(38100700002)(86362001)(9786002)(5660300002)(8676002)(478600001)(1076003)(2616005)(9746002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pWOvraAdTn3Bw52cd+2JmCInVQhHcl29uJBSyHnUdPyTo1vKag9XCKYjI3rt?=
 =?us-ascii?Q?Si1itERJcO4CAr94euX6ULpIvwLtZxKF0cjivWvSVQwPg2HMWCZRdZVDHJtM?=
 =?us-ascii?Q?+EIWERpSYhh26OZQ8/xxbkbjwaS38EmGz67Mo/4hkWTxoKRycK0D49GP7Zo0?=
 =?us-ascii?Q?tAjPjZSKrJgP+YLCxOYOKaBISAmmQ6y1QvrhIy9b9/GXrZ1MxNy/IUvoQ7GA?=
 =?us-ascii?Q?BpEtHe7bGoT1/4c7nhCeSXH4RMP1yuzUDAjD7nerLhHNeXOwuIzHtWuGJrQ1?=
 =?us-ascii?Q?+jPkVwxZAuWLMnjp7L1YHlOHPPVZes+hHFQAcVNqNSu21x1bjLwPBO/q16+d?=
 =?us-ascii?Q?FGakoUqrgJN4VixJTD/lZofxuAcL+o3Py4k6IIqyoI4o7DE7vgeSkIfpY/NE?=
 =?us-ascii?Q?Xp//Ud48eTWo6LB/KaqxcxAwSv7KG7xu1PoMJjaYC/IwhAAGn8kI/69Ftep0?=
 =?us-ascii?Q?RAaBb4cO6XlxLM0rDfG9qI+Fn036a5oNWySme5M2BojA8VsKL+sQrPlJjI38?=
 =?us-ascii?Q?GsoEFMz+6/bCwZhLte8l2P6nTl19oz5hpkf1WAzlmCqOtyUJXvT1pOKSZU4B?=
 =?us-ascii?Q?Z1SeMyfPhyLkmBXop9sKJrVrJ9jgTJrkFfB+ETiwW46cKHViec0Vndqui4ut?=
 =?us-ascii?Q?qOzvBk+PUvxVLnPHfRAk5m5jFyy2PxHa0o74lf9i+XnPgcxUJ4sZpWZE9Hcy?=
 =?us-ascii?Q?xJ/i2nOyxEvJbLucOaCdfrEiHVZ4LBYpMfFUE2MF5scX1zXTS33atWOptBVP?=
 =?us-ascii?Q?sVzPnRIJ9ovBOr/cqA8ckMfgYPpXykEta2Wyu0mqtAvMrq/IrhLofPnAS5yX?=
 =?us-ascii?Q?03rGqKM9Srkct1uiZqU+Xb7MeKI02ZD25uLtqqwgyplnlU7aCihZACXDmniu?=
 =?us-ascii?Q?1mleTewYJxYXFaYVTMgk7MkXxgcZe9Pvd/lTr5GB79Ty61B5dxYnh4svVkhT?=
 =?us-ascii?Q?nG6Sk0tZCVLJCb1PwsJ3d7Q5NjSQ3B1PYUHfokqkWH+81KLm0ueSth6IgpCz?=
 =?us-ascii?Q?zMOdKlQETTYKHNkR+mewxaeDEvd4AqdwjK1ZQiWIoxKDpaPtY+a9weniOyep?=
 =?us-ascii?Q?yJMo1p+K5jcLIAJ+GaRI28/08h0sfljp0W82sGKjSjSQv7acRgEAqMol1nnw?=
 =?us-ascii?Q?SnoZ41+MO/E7eMuUo7wyWxUQGddAzLnkLVGvG0xuyD2LR+Tf66ygjeGIItCY?=
 =?us-ascii?Q?e6FJ+MX1YY9pKJnisQdhIvjKTofG5JQSJ5gZNnAwKNgF53fslvkWPvOfzPzY?=
 =?us-ascii?Q?PKOzEZFS2jZv8/ny2IYKTRfdDvJNMaAT5MfOFceqQJv/gWbW7Y5TvX0m1Ic/?=
 =?us-ascii?Q?AK0VPRgPqwiahpoNplTv8qsr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b85bdbe6-6cf1-41ba-c3bc-08d95363384c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 14:06:26.5041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gSIHPbRKgZe6NNHWNiguVKxoL2Uue67gLJEE2MAY00Eo8fQQF8kzjGs+s+CwYErk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5128
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 15, 2021 at 12:04:34PM -0400, Dennis Dalessandro wrote:
> Fix up the fixes line in the one patch. These are good for next, not necessary
> for RC. 
> 
> Mike Marciniszyn (2):
>       IB/hfi1: Indicate DMA wait when txq is queued for wakeup
>       IB/hfi1: Adjust pkey entry in index 0

Applied to for-next, thanks

Jason
