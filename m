Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D9C3947F4
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 22:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhE1Ubf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 16:31:35 -0400
Received: from mail-dm3nam07on2069.outbound.protection.outlook.com ([40.107.95.69]:53024
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229492AbhE1Ubf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 May 2021 16:31:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCYvuXPTFx7u+oee8UD0S4o/KPyFyPwEqk3XUZRTMtH7KtuM/60/iRq2SHhJhbkOgXmrMIgJrwD2SYycNqQsE1zDms7wTxkKSVXLynuEafxw5X2CpZx9EDvD4nR41pyXoiHt/khUUV2DW6YaswAmvCnHH5lEP0nGqvOAAJTKzi0+zQTm11IyjolnJypRTODr1V3OeqOya8h8dbiaVeoS7iPYGb1vr5/PV4LTNzH55eqSP5Vl0B8PI0luQh/AvsJwFCInJycsnS0k+VSmiev3HItFzPq6OZ7fPD+bP7o0xJpe52VJofWff4bwk4P8TvlTlGDJBnU2kz0OWjxu/7aB3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyxFCJKK61wTadma6wPAMpyRMfL7qR33V+kPAHZuZfw=;
 b=TnZ4R5AGNSlCrbTzbbhcd0nMsdoAzrNsaN7sw8e3/UGI0hfNIV6qagNohFzLC1uCDRkjySvqPIa9E/YgFljZiptEknon3SiO+xFSbxUjrcl3SwUwco7UcVXbQm9+NYPjAfudvdkQ6cbIrWFxFY0cBoBmXcMHEVS0mafkl9GlzZIxtcf137la128pGuKEaC/AZc10fJ8L6wZEaTc4vI0mFs/rTEvpdIUnGYZpzSEk781e/2ATzRADaPmyjZDrZjC1Y0IP8PEusNKbb/5LPDj2zbAFy5mJpkkEI2BGRLj0McuUcKrocYdTZ5BU/h4oxpJXItkqImQ3RP9GXFUD2SkEng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyxFCJKK61wTadma6wPAMpyRMfL7qR33V+kPAHZuZfw=;
 b=hM/D8/I8js+OHr0hXeBu7OAr7fYGikVtTDhP4T5Nz6+lGOSleuXJAXBRZyCpkvTV9khdXQqkdEtXZSoRdQwVtqe561Wd6mU9G8El1gFPwdTAsjWUsXqq89kVwSF6AjKZ5WB/0wMFX0siUqB/dloC6fl9LvaedmwKAY0HOlFGF7BU9/6jPGIuqcxcGNQhcSihcsvp/nJeLoa4jt/5f+m+io/lPEF/V5Aza2lpuKgYvotcXV/TqR+DbK+fmAMqirjes6LM8m1Tus1j4sGUt0y+qesPSp7VbhLaN/EHT9Xf4Yr9f2FiEuUtbX/rq4UCjSPFLCQJ8MAt69rUuSVi/SNcdQ==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Fri, 28 May
 2021 20:29:59 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.023; Fri, 28 May 2021
 20:29:59 +0000
Date:   Fri, 28 May 2021 17:29:58 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v3 0/3] Fix memory ordering errors in queues
Message-ID: <20210528202958.GS1002214@nvidia.com>
References: <20210527194748.662636-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527194748.662636-1-rpearsonhpe@gmail.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0037.namprd13.prod.outlook.com
 (2603:10b6:208:257::12) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0037.namprd13.prod.outlook.com (2603:10b6:208:257::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.12 via Frontend Transport; Fri, 28 May 2021 20:29:59 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lmj7G-00G4JL-3d; Fri, 28 May 2021 17:29:58 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ebc22bb-a8ca-40e8-4160-08d922175d08
X-MS-TrafficTypeDiagnostic: BL1PR12MB5269:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5269205893F8D2300B282635C2229@BL1PR12MB5269.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kcSL4KXGyQ3CFb6JqDpojgw89lCFCVkGGApfxDHHVOxgI3wfKzcTr6WchG3ujpOXXPtePIwvTj7dtt0aflNbpDyD78ZneykuruKnNaxnYHp1AM8LIfaIRyb+kAbXGeZw1gsygH6VRLsea/inrBDO3mZ473GhDZWm4ySKd/Nn5Lef6bbenkmniFzIReEvO5wTVESEV4nEeX8VUbSEQ70VEdgWCRRBNSNgYA8UyB2ngl5sLdr47X/ZJfhX+oB9yFPwioDgfhbm2HvOT5c9V6pgJWEN9gy7+lJcfx1EDyOuOFIgI8iJ1oES7ro3D8IMA5p9yz2zPM4m3dTFWIOGZj+3XLMuuLLZ+py73WZ1HzGhO00v80MxU8Yb2yw+aOeRSWdnE8aKD4uwzao92j82QA6GNZm3OS+ZCUkP21M4elxR1XaMfEm8yObZR+Rc9bYUUF703T0JgsbcQb6J8EZ+yr3CNsyl2XO+UtwQyX1Xj5w/KyQ8n5vifalasMaG8eeEfYWHsEOEzDp+sjkx8CD9rpHCDSuSekYJHtdp1Pz54NSD0ZFNSTpCmPzbklGeYFtKu0S7XRqhutsZGtYbj1bueRghZ4KEC4mIUMLTMPCDjqtg1D8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(4326008)(2906002)(8936002)(83380400001)(5660300002)(33656002)(36756003)(26005)(426003)(478600001)(86362001)(2616005)(4744005)(8676002)(38100700002)(1076003)(186003)(316002)(9786002)(6916009)(66946007)(9746002)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?50qgKQ8DTPsQFsKLA26FnAKFtDrYIP1O9mTPBn4FQkVwEx2Jq6lGznTgFACZ?=
 =?us-ascii?Q?9LWJnzro5cSNsJZOxnbOT4KMSs4cKN+Hm1hbCd60ZchDepbsJi5BGmT3qdPq?=
 =?us-ascii?Q?qLttT/EcLnlV/ClPX7VSyu3x7nkcUTl39ZiP0FF/wfIxbYO6cojw+ewqhDHA?=
 =?us-ascii?Q?15+1GG9tzW1HrS13FIYXKLvDjkA8KqEcTEpokM/pcow7TSNsRjdA2Qu9pm1H?=
 =?us-ascii?Q?LDDwRiPw/4nG0HQp4mwiq/HDa1JtjIzM9sP4LehDFgo/m05nEk7v6wLXePgW?=
 =?us-ascii?Q?F2yETLRKMTQkP7CnR4GDO0YaZ0D4JwMfSDSq8G9DxOOP+2aZNoHuta1rkwQj?=
 =?us-ascii?Q?lc/OewWAm4hCpklgGmEWV0aPWy14MtpX84PhjBK62V5opZULLP72RLS89IPh?=
 =?us-ascii?Q?7xhZ9677xYBInTz0lQisGhnzSg3Lw6vnhcna9aohjGVNtRw+HaGGs5KgNXhY?=
 =?us-ascii?Q?q5lgo8PK7DwoplYjeTZbUVpGoSy2W6xjTcPuaP9Fb8pjJgnoOr5RB9Rcujz0?=
 =?us-ascii?Q?QCPf03FgQvg1Mh9/tqLE3E2Fzm9QXVb9l/P9C9IdQu/ESmrvX6RxxnFMWx90?=
 =?us-ascii?Q?+dgHg3mYawT18/n8x4Tl2/8ZxTmGQap8mBfNH4DOt4L6jB99/L7i0kjlhEXM?=
 =?us-ascii?Q?Y/tkePynF5qitjFbVP02/ny7RoA3BU/lBBVPq4b4TPuW5fL4mRdNyUrT+LoA?=
 =?us-ascii?Q?v5I9lv6RRI1mj0fRSluYb/yfCTFudzeCAkDnOtgBA/dhfUAbFjfsKWFK2VjG?=
 =?us-ascii?Q?kuSvYrEAMQgl0hDmTZJmpMDZ9tCTf5RwQiS8513gwYForBX6+Hm61COad281?=
 =?us-ascii?Q?4PmYN/r9wpiqF3Tyh1PwuPMI/wmnQ5x+AUBdmSGvURh+ZXCuGFffXvl4QYrJ?=
 =?us-ascii?Q?MpKEUCbkPd/+Jq8Q6gXwvGeE/kX2gMfdIWzKWNRHnZTQBNHDcAKXzSVNpKtc?=
 =?us-ascii?Q?gUpU605Y9pNbWUxtsBzRSrYdfjIws9x6JFaRZBI9zLDEDUvHObJrWmoLcgW0?=
 =?us-ascii?Q?JEZ7m2g2tVHjOtsc4sPAcmcMjXSJmbx2YI3HQ9wnx1BwYjpRpei2/pR4Utvw?=
 =?us-ascii?Q?cdnOER875xyucCaOL6bIQ81ZHbMyt+iqOYoEnE/2MdbizZPjIU4qXcqn7Ntq?=
 =?us-ascii?Q?BXDvFTcRLBPXYs9prYUvayKK9ZsHRgRYU/T2nGq9d3Y6gK4nuiHnKajPZIO/?=
 =?us-ascii?Q?ZWdW+2k0qvFc4eKbDE0f6MvhebEdfcuMXEgCNbYlMv+/95fsNaMo5s2PtXOh?=
 =?us-ascii?Q?JMKdOfFmna6ZLmbR8lV8y0r6Ld2Njxag+736ZqTSB56l7M/aTz0nBsh5UVgl?=
 =?us-ascii?Q?j+5mkE/U9No9toLCrMb08N23?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ebc22bb-a8ca-40e8-4160-08d922175d08
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 20:29:59.1185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LhcF/7cjtvZg3NV2JqfwYKXfkDk3vEgZQsBvZbeQFQHrG9uYzd6bjufZXWN3W87c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5269
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 27, 2021 at 02:47:45PM -0500, Bob Pearson wrote:
> These patches optimize the memory ordering in rxe_queue.h so
> that user space and not kernel space indices are protected for loads
> with smp_load_acquire() and stores with smp_store_release(). The
> original implementation of this did not apply to all index references
> which has recently caused test case errors traced to stale memory loads.
> These patches fix those errors and also protect kernel indices from
> malicious modification by user space.

I didn't read it carefully, but I think this captures the basic
solution

Jason
