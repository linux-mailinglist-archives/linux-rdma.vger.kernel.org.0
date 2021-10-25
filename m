Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9543C439AA2
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Oct 2021 17:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbhJYPmn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Oct 2021 11:42:43 -0400
Received: from mail-dm6nam11on2043.outbound.protection.outlook.com ([40.107.223.43]:15328
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231686AbhJYPmm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 Oct 2021 11:42:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UH4bAOHfYTwgbuEfg9zUNrF649Ejma7qq68BWrol13AfC8XQaNXZiOqNTesbs+gnK/Y6sSHPXw5mzGP1Jp/3MAdW/wc9gUMeE9OmsHwerbAfxHZkIxIcTbcLoIHFyfXxmibO23/SDNBa2BzzdqLZSvK+Ohkfb975R+RAMf3sLkZJJX+5dZUQD20klH/n4N5Dje/3Cen05Fn7rMD9n1S8Jr/iH8EGOvS0tkTMqCjfo2XyOArl5AXM2YUl9dZc0U9wygwiGoY0/dTtyUCXS6NYRS1/PTN4L9cbwTq7yf6Stn7zMzstlEAEsL5wPZGrYlsi8NexJfgryRwUSmRl6QYqLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feUYiMAYGu1WiDbLSE1DGYhjpW5B4olWOnhIZ6SSztY=;
 b=cz9UR59VfR95c0KssCHWq9Uup9onvgSnDJjkz+VPb0sC+QaU/Ko129SMQpZBrcScIYXE2znGcaH/JC4LYqIOd2597R6JBiuy3NBZF84d8cOibi8jBDytdn4Yc+lnnll9Bsf5stG5Zc3VgBXaEusmc5NzJiXKGl1oZ1VkjG/aDJo0jxFvsRovkiY80Xb1DFZRJA8WJ6TeDVIjrtt2fA/3Jr5uMd3paNBlSae7edV/Z8agdjZt+Pconho0KFb+S59RQFTXiPEVsKHHSxOjW6VOOnMdCTFX63cXHY1ZoNwBsp11TADtFViLxSJhXFRq+QZ9RvCqA0o6C0Q2a4MkhHTwmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feUYiMAYGu1WiDbLSE1DGYhjpW5B4olWOnhIZ6SSztY=;
 b=c7TlIZIk+EK1i9ofaihTNEhtCIBMktg/OfxrRWQJuMtELifv/xa0eHfeehak/iXF9PHgijCE4j4v5IOSfsTLoFUpB857cL0PX15UBHjtvCvHljqo2NmNRjxsySsPUkNGGmyTauW5BDg3rRXhFUpmQX+mRUX2Qpr9T1H84YxIQn38aJOv+LZq6zMX4dxx60D2HW4mMA7medRB6VM4oZ/UdtQNpKLdFYKnHQlf+uu7W21EWsN4yDiS46upqJHVtXWrCBelGUjYqpMXyZzcKY5YvsX+aG9P7lbO3598200+HbTn1IecKUkr2Q3b9ZlYZyfnVFtoTHJIReB/mebPblZDXQ==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5302.namprd12.prod.outlook.com (2603:10b6:208:31d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Mon, 25 Oct
 2021 15:40:19 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 15:40:18 +0000
Date:   Mon, 25 Oct 2021 12:40:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next 3/6] RDMA/rxe: Save object pointer in pool
 element
Message-ID: <20211025154017.GZ2744544@nvidia.com>
References: <20211010235931.24042-1-rpearsonhpe@gmail.com>
 <20211010235931.24042-4-rpearsonhpe@gmail.com>
 <20211020232051.GA28606@nvidia.com>
 <394c9270-77bb-1195-9422-bd2d5715e2bd@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <394c9270-77bb-1195-9422-bd2d5715e2bd@gmail.com>
X-ClientProxiedBy: CH2PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:610:4e::12) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR02CA0002.namprd02.prod.outlook.com (2603:10b6:610:4e::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.22 via Frontend Transport; Mon, 25 Oct 2021 15:40:18 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mf25B-001W3u-KH; Mon, 25 Oct 2021 12:40:17 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbc94cf0-8b12-44e7-4ff0-08d997cdbf95
X-MS-TrafficTypeDiagnostic: BL1PR12MB5302:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5302CE81CDDF2265208C427BC2839@BL1PR12MB5302.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i+jnoq70ryAtl8kaU46ZjSytuJJHjoM6+QudsGEcJFC4SkA/FBKyZq/9WwzFq8F/WHDa1K4WoBnC3eg12NchlBi74Xi34Js1a27Mmb8v869LEEM/7v1E2/dYFhciq3KiI8PGu6Ig0aXulniJv2qnVRXYzI7XKZKptQLkdvx92pCKEf+hDIy1UDIzFAa0abMrXjtva0xudvDx5R07INxsEpDskc/ue9d9SjMGbVfpNKtu+YIrNOjDya28yBqk4xpRd2dGuNunYwgnL7wYAPM5GHiIla7a/ZgRLRaUgK+oTCdqBepTA8A9IE/xRSib1y6HaZXvaTgwkpVfpnPzS0zKBRrN2Y3noB2Wfhnq6dLeHHzD5Im7e44SsTPSjXG9X8uvWeC1+HHvwYEysJee/1v5tfQb3BYfb//3lBHMRYgmChdN9a0aBZnqXD+YGcQ2AghtQoTJpxqL+Z6t8eIRueMEMji9oTWRqBJ/Z5bnKP3hnFX0fOCffoTqyYiS9n5xISC8t8dSjkPvYd1+s1WCBvvdAbkUYo6de3wzKplVFINAh9FQ8MZjWK6vAw5wNPSEej1D0AzbVkDNztUlaE/2OPiPZUTQiuFqJaCQCkNACXCjylcxfigmNUqug3O0RpatZ/tqGG2oOFe+8X55NTubkHaKZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(33656002)(2616005)(83380400001)(6916009)(316002)(186003)(9786002)(4326008)(8676002)(36756003)(508600001)(66476007)(2906002)(66556008)(26005)(86362001)(8936002)(426003)(5660300002)(38100700002)(53546011)(54906003)(9746002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/iYSy//8w3uwt3PhLrCVqkn3MneDIvuYhue1wjgwbshFmbH0ya9sG6OiEmvE?=
 =?us-ascii?Q?BX5SSxWgHhfANTrOLUHiZegF/I3MQ7yT3j3ma7RPRdnbghb2L9SO1fsC4SGB?=
 =?us-ascii?Q?QaW1Cn1ChT4eeQoB67ik1hwUv8y68ynqWsG4k0CYbooknMbsQ4tXJAwb9c68?=
 =?us-ascii?Q?7XEsurLsxj65OA1/cQtBbYYY6Kc9htbJxUJAzwFW4xDUmv601In/H/9zteUV?=
 =?us-ascii?Q?bmmiU/WCuVuBrw47EXd79NYfpysD8kstcfqhc1q8bozYb6g/DU/OfXlIuBpv?=
 =?us-ascii?Q?hG4V6H9X7Jb6rGbcZsC7LZ3RSPorVDhN8/U4FH7ucJinV0h+Dkxiq3cgGKo0?=
 =?us-ascii?Q?6ySWO/GNoeo/hunxKt0dU2ofJLltI4uqeyI2HoPdK6VF/sJTvTj28tgn9D6l?=
 =?us-ascii?Q?Sgz09Rb6Tx0T5TEHMskIZFUoliCQsSGlF86RwMJ19TqDQ6xGt0313tpmW2Gl?=
 =?us-ascii?Q?owoHApVpBEnvC/UzGvlxb2NKavWtKHkk2W8dofY1n7ACLs/KIFE7BXeR9lqz?=
 =?us-ascii?Q?1ahTQ42w8GgjrruuctsjoS33BxqJqkuoMdVtNDHn4Bk8Ui56E2TabkeZAAZb?=
 =?us-ascii?Q?K4xZ00ysrkLH2sF18fjSiYfNl+1uj+hRDWqVRUiBoDBkcucPfQHZrv/5mLLD?=
 =?us-ascii?Q?E4oAvhzBBNTaYcta00e/WoWQEtzIYOozjGev8/EDuf0/evDfxbiib7Yd/SBh?=
 =?us-ascii?Q?AwsJHl2I71irZGht9ihVHK7lYQSpmujpDDT2cQKczrBM0gbNSi4YFVBbfcsp?=
 =?us-ascii?Q?dlxMIduL4U/NinV8pEh6sK40CDuL8oJWKyYSeoUACPM8+lsphu2VNYuf+Wzg?=
 =?us-ascii?Q?uvJ+RHZUzq5vpA8zTi5Lxsntzv2sQkiA5qqy9uCBOQpdG4QD0Z0y96dXpGG4?=
 =?us-ascii?Q?uzZQew+emAMytMaWg1GaiFiNLgL3OQo1+wITDLaM7ZEba5CarEIOn/peRAdz?=
 =?us-ascii?Q?7Kcv0uF9+D8ebXWngvSs+lfnmmIpiWTDOEq4R5Lg4q4t/Dc1A7vuO4kHZfp1?=
 =?us-ascii?Q?EV23rSV2gHurr1b3Bivqap/IKgAHGMHgLhSzWDnyhev6yhLa76javO5eM8or?=
 =?us-ascii?Q?a+M7Nen7QohPKvEvIZScWWCPXSjuCKEq8h3LBfh8vHQHqGc3Oe2MrUImnRT2?=
 =?us-ascii?Q?/5xOMvQ7k+B45qp5JbY9E8YF0FlvaDgIij4TbmzjutH1n9yq7ItCB//09VYZ?=
 =?us-ascii?Q?A1FRz5GyQSOETcWtII3baIJX0dEwMAuMUdEDRXVZYBfyXxj+LtcwvgyV8fTj?=
 =?us-ascii?Q?Z6hQH6nhOYPfjdYeLfDYgh+nb6uAGjeSPy35L3WFe+3sr6o8Dh4a275XdNuX?=
 =?us-ascii?Q?HPIxglDDX+nAfLiwwetoTc24tBigJmDtQ1C2k9W7vW5OXNZVe9NoxU7bC9c7?=
 =?us-ascii?Q?Ww7jWO8KJpmyIQY/dqHlKyFjuwryvqNRwPMFove0CBPDSr5THWPyxvZdaGBL?=
 =?us-ascii?Q?lReD0JkzGX3E6Gv5pzLeuwGfpPHqViUwZjT87cpqOMRp9jVln1fDePn1r//5?=
 =?us-ascii?Q?UKGFQM/cqEzAVR/wkSMEd2ozfycO41HaCi3AtaS8DOK2jLEZqEgGTTCcxBrY?=
 =?us-ascii?Q?zlEFuLbXzMYjdjVTdvE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc94cf0-8b12-44e7-4ff0-08d997cdbf95
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 15:40:18.9004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: asogFyT3uWeFD8mGhPX4Pqv9Paej31UBlQHAXLqajnytvu93SJzjNL8biqnUcHDg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5302
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 21, 2021 at 12:21:15PM -0500, Bob Pearson wrote:
> On 10/20/21 6:20 PM, Jason Gunthorpe wrote:
> > On Sun, Oct 10, 2021 at 06:59:28PM -0500, Bob Pearson wrote:
> >> In rxe_pool.c currently there are many cases where it is necessary to
> >> compute the offset from a pool element struct to the object containing
> >> the pool element in a type independent way. By saving a pointer to the
> >> object when they are created extra work can be saved.
> >>
> >> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> >>  drivers/infiniband/sw/rxe/rxe_pool.c | 16 +++++++++-------
> >>  drivers/infiniband/sw/rxe/rxe_pool.h |  1 +
> >>  2 files changed, 10 insertions(+), 7 deletions(-)
> > 
> > This would be better to just add a static_assert or build_bug_on that
> > the offsetof() the rxe_pool_entry == 0. There is no reason for these
> > to be sprinkled at every offset
> > 
> > Then you don't need to do anything at all
> > 
> > Jason
> > 
> I think you missed something. Once upon a time all the rxe objects had the local
> pool entry struct followed by the ib_xx struct and then anything else needed locally.
> As Leon has been moving the allocations to rdma-core he had to make the ib_xx struct 
> first followed by the pool element.

Oh, I forgot that we were forcing the ib_xx to be at the start already

Jason
