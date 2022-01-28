Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF4A49FE3E
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jan 2022 17:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiA1Qmq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jan 2022 11:42:46 -0500
Received: from mail-dm6nam11on2072.outbound.protection.outlook.com ([40.107.223.72]:46240
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245657AbiA1Qmi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jan 2022 11:42:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JojszGhTEslSpolhxsi8iY2CINjR8TthU/lME5VDP2pQwJkXcxuzA7oxZcm8adh76cq94v/X1pG4A5hP7YD8Z2lmpyC3m0JGHVXyNS4Q9Yg+BpT9d3zQXR5ygxRAsyw/Q9OJlGb8gXHrs15CENIPGJ9szUWrlH5WQOTUkeb9DdD6VyXUArryGEjZxtAS1jBH7W+YGADVp3DtHAxKjEA895Y/ND3/O71wL6317wD8wXO7FBY5aB2ae5YveHqd/ckkM+711Hlf+kJUZ33Dr6gNmeRyGeKJ6+gOHZAS5ouzvDRHxqIZi80Uz//i43wmO+JJnPhVEOnMi1CmuTOn/hnNqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMz1+t+Z/TrH0xnwQsgcNFxmq+e5cYJGssOTJeEtINo=;
 b=f/zJIq9fyRlxhFRR7H5ao6vxBEz9ckqByhpShgPFWAsPnprbq/zBg+YuDVokNowt4O4wQQBIL8RQQatoK2Y2VSvyj53UN2WvlGNbxfcNBSYsyacYu8XMIQMEw4suJHeWnWIO3Ia8gOMiGhfugW+aV3m+7e80Cgqb881TMH8CG3c1oJYnhTN/GxXF2KClemC50xp0r0imkQSv6urDzFMDcYYaMRH1YnCHX1IyH8uwxVmdggmvPZIpW0MZFSlygJxyg6qZgj6EYCfJ+zSJEIQivx8BYMsJlSizdMfLdv45HXiGWqdBzYliiz1uofiiUCY85eCEmI8aszmjFuMZbpvtOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMz1+t+Z/TrH0xnwQsgcNFxmq+e5cYJGssOTJeEtINo=;
 b=VTFiulZE/6+0IoVT+Po0sH5J++mNG4rWi/lC3gW2LfPiNyKh8gQhBYe4KQ9pmsuhdlHsxsJWEoGMKT7dP9jMuM0IDmuQkuyX4eAoQCawR6G6rJMN79/TBV5v0GbG2f8dcvaK71UDLQUrmhDutGMv0V1cZy/ZepoRgaKtELXulUSef8hToBf5XaCkN69BLgs8CHBzlEQ4gFkAJlNlLcj4WE9+RVIpeGq6i3lt7H8KidawZtzJcusvjuKpUqtIkOH4UWQfofvrzl6dOUD2K+S8usaU2MlPp4HXx784pFdBM/KPpVel5DFHHSxNOrTiq+fj1Zu9ML/xGhOPGUC2qnRYuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB4796.namprd12.prod.outlook.com (2603:10b6:5:16a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 16:42:37 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4930.020; Fri, 28 Jan 2022
 16:42:37 +0000
Date:   Fri, 28 Jan 2022 12:42:36 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [RFC PATCH v9 04/26] RDMA/rxe: Enforce IBA o10-2.2.3
Message-ID: <20220128164236.GB1786498@nvidia.com>
References: <20220127213755.31697-1-rpearsonhpe@gmail.com>
 <20220127213755.31697-5-rpearsonhpe@gmail.com>
 <20220128125319.GC84788@nvidia.com>
 <14f2d91e-729d-6be0-a2c7-0175db27d293@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14f2d91e-729d-6be0-a2c7-0175db27d293@gmail.com>
X-ClientProxiedBy: MN2PR01CA0016.prod.exchangelabs.com (2603:10b6:208:10c::29)
 To MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cf8c7fa-baae-46bc-20d3-08d9e27d3133
X-MS-TrafficTypeDiagnostic: DM6PR12MB4796:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4796A048237F0B9E98AFB265C2229@DM6PR12MB4796.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vsb2eunKgESOSIjpWFX2zOuPonBFMbAHgNfnMHNWEt/gFLKUbf+4pnGtMyR7rnjIHLu/wm3N6vPpZK2Cf/tFhQTKy3a4mK/CgQS5jOkkKGv6Iwty22Wp0UC21JSSBORnTNB1SaU/dkM2LAGfOZwSVK/Bi15Ey9OqWSAOkJf8U9QnWO1mnN/8ez5w8JmCNPO7uIwQ7gIC9dj3RYlzf1FmeQz8ZZbWchbxoPCYvEs/Li+ThNCq/4a+MTr5vBhYelyhWWxzWqtD6dv6hF9hZW7BpwlSD+Ek/WDfTWYazL/qH5UNTb+0D3z4rT5+wtrKl8+uUJcZMprUellenuOjcHmbdaB5RmA1YGHrSue3IZdPbu2/ImILdjG9s4m7mLq7lHYk+By+vVQ/yEbhCEGcy9NF2eYAR+MOUXj0D9g8RjjlYvdalzd64N940e2kIkcpTwc8vD09VLdePHg6WHMItAdt4CeG8CQEIVQaS1mCOeVWwTr39opuOoK89FTEY06hBt+/pzWw8Wkc8Y2KOEzIshwFwwjstZAcM9ElYo0AePlPdrz0dqZuPG/61kh9gsKE7GleAWCbE4THzigr87T3T6KRvNyPyNYUpYr705KyZGOErNOwQ3q7PglABU3yIx22LnJflFsYtYJHSfpDjOMox5OWSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(66556008)(8676002)(316002)(508600001)(8936002)(5660300002)(66946007)(86362001)(66476007)(6512007)(6486002)(83380400001)(6916009)(186003)(26005)(1076003)(36756003)(38100700002)(6506007)(2616005)(33656002)(2906002)(53546011)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VO8lSIyMo77dYWT3GxSTpEFDtTNXJ4kyHl1vvlEA4MG0UnQ/91i3OFDIA9Rw?=
 =?us-ascii?Q?TLJIYVfmCrSregpOG7B44GcQ77duiqlxjezVVakSp7gBxOhWhwHgTRdc1PSx?=
 =?us-ascii?Q?aeRkpgqJ3ZA0tU9lbNayr8ncoWwR5poCEQY0RUP0jAv1mtXtviU+U5ksgtTb?=
 =?us-ascii?Q?knz863revhZKI0IjMSKe7z/UdY6Gaq3l/O2ZtZG6ZInSWtiw/Do5wshJXdEU?=
 =?us-ascii?Q?YtKlLADHXJ7KYDjCBzRPgEhx1zHJy1YsEzSM0s31h+vwoiDJgbqqmXuSoT5o?=
 =?us-ascii?Q?zhefmvKr5hXdPynoaz2WSGgF/qqCXB8zqP8oZuBxTLUxO2NfB/jiyDyF4Poh?=
 =?us-ascii?Q?HoNNBJ1rkN8BnnIzEmD/uW7R9OjnFumM68R48/3VOgDHZowb0AqA1pF61mP6?=
 =?us-ascii?Q?Iit8RVV6SZIxVIHXojtE8NWPR+Fgyyb1LFJV6P2/3gGA3wAnCGuSb8hg5PWa?=
 =?us-ascii?Q?DN78aq6/JL/Eg5RrAO3sr4qBLnIoi3TX5E3xZopyR3/2ubxUOdBcKePMY5IZ?=
 =?us-ascii?Q?guWOPWIfnlKkT4i/g4Oh1hcCrZ9LlXw+aTMJGyAAlQwSIHKYDDeN+fWHRZME?=
 =?us-ascii?Q?P7XCgXRW1CgMs3TwTDv7ZG166degrQWjs5/M7nL4p4QyOBEtER6Qe+e1j0pD?=
 =?us-ascii?Q?6HfInh+x/YKzlyHT6AF2LUC2BefBdfI/TeWFabQhJsKYiykdjIje5JP6G80F?=
 =?us-ascii?Q?r6pArNEoqC7k24A1bYWKsURBvZ4A7G0tSSRYEtJNmBB5QOx1YbGkJjH8oBK/?=
 =?us-ascii?Q?7kyGYdK/vNf9rIAk799QwyAH+DdazZwbDI366t6xQt9uXSeBdll0Z1E543b0?=
 =?us-ascii?Q?Z0S+R3t9/rE/EtMefNzj5h1D+X9WLJ098LDSfCF0/dKoEa3ZzJ9swCHKT8Mt?=
 =?us-ascii?Q?1qiLaQAxAQKHOXodtkfVrC4dXFK6umfyj18wkXKycyf2FtWYH4C++f77uoA0?=
 =?us-ascii?Q?5ekMmVan3xPosCqjV4fWZnfBSZP26/CP8qYPCYTF/qsdVkbSmujnAOJBhcuu?=
 =?us-ascii?Q?bwr/xoyGdAC5d6jDu2ZTSx2S0EU9w46cGv6F29fPG19zeH4oD4zFHEvrZADI?=
 =?us-ascii?Q?2Px3gzZaSqvEbqgWlqFA1MqCUOD+XJN06rKwwG1+a8+0jsIFFltJ022/cb+7?=
 =?us-ascii?Q?zcMsdljkaT+ZRHJtJNapc51/qDmlwMXphQXZjk8rkbd/LUf6v333xeJqbgRr?=
 =?us-ascii?Q?z17ieO88Y+8z1u7FzkR2i1vw878pVsXX0goIFCPuNoP/PLMq3kj9i1epcirN?=
 =?us-ascii?Q?gSJQ0BUd7mYAoyDV+MeDWwQGpj+8FIi8SEAykHIySgfGpkmdIqjDEfmtIF4D?=
 =?us-ascii?Q?oCvpRuz38/FoEP5v5C0FpxPyyI37f3CrRst6PW33tznj95KIJwnayNIHUlj9?=
 =?us-ascii?Q?ZJrQbuONoGCZ9mK2xtIPqncgV0D/++sueQ6ndUFjlWZPLMFeBcmrHWdhMbzs?=
 =?us-ascii?Q?hqpqE7i2fOEI7fSH4Ay6b9jLaZ7s3p9t9AzvGNuVCVtorSlZAlYphmxBstDx?=
 =?us-ascii?Q?QV/xEr/6K9LPI/j0LdRKi4PvEXCpeYNNlk13581PMJ9/ZzisRyiffxUn3CDr?=
 =?us-ascii?Q?ktfFAoOs9gy84wj+BKw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf8c7fa-baae-46bc-20d3-08d9e27d3133
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 16:42:37.5109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LdHqB0A9DfQoGLtpPO9HUf1Ac0aEGSP+BzNNRiyH2OsHlq3j2F13NXV3zGtIvcP0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4796
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 28, 2022 at 10:18:45AM -0600, Bob Pearson wrote:
> On 1/28/22 06:53, Jason Gunthorpe wrote:
> > On Thu, Jan 27, 2022 at 03:37:33PM -0600, Bob Pearson wrote:
> >> Add code to check if a QP is attached to one or more multicast groups
> >> when destroy_qp is called and return an error if so.
> > 
> > The core code already does some of this anyhow..
> > 
> >> diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
> >> index 949784198d80..34e3c52f0b72 100644
> >> +++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
> >> @@ -114,6 +114,7 @@ static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
> >>  	grp->num_qp++;
> >>  	elem->qp = qp;
> >>  	elem->grp = grp;
> >> +	atomic_inc(&qp->mcg_num);
> > 
> > eg what prevents qp from being concurrently destroyed here?
> > 
> > The core code because it doesn't allow a multicast group to be added
> > concurrently with destruction of a QP.
> > 
> >> +int rxe_qp_chk_destroy(struct rxe_qp *qp)
> >> +{
> >> +	/* See IBA o10-2.2.3
> >> +	 * An attempt to destroy a QP while attached to a mcast group
> >> +	 * will fail immediately.
> >> +	 */
> >> +	if (atomic_read(&qp->mcg_num)) {
> >> +		pr_warn_once("Attempt to destroy QP while attached to multicast group\n");
> >> +		return -EBUSY;
> > 
> > Don't print
> > 
> > But yes, I think drivers are expected to do this, though most likely
> > this is already happening for other reasons and this is mearly
> > protective against bugs.
> > 
> > Jason
> 
> The real reason for this patch becomes apparent in the next one or two. With this no longer an issue half the complexity of rxe_mcast goes away. I'll get rid of the print.
> Personally I find them helpful when debugging user code. Maybe a
> pr_debug?

Sure

Jason
