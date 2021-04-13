Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A001F35E9A7
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Apr 2021 01:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348791AbhDMXWc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Apr 2021 19:22:32 -0400
Received: from mail-bn8nam11on2086.outbound.protection.outlook.com ([40.107.236.86]:65249
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230123AbhDMXWb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Apr 2021 19:22:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBZy7oigbJaYmgFf52wowqps3NZkS00282jRfkLz4Jo+98BxNkrR8XCpu4FolHtjs7AUDC2J4oZx3C/U+33FR4t+KljHXid5zBKksfXcPc1nS4UW0LVWxZGMK6NwvkwnwT8AIsM2FOwEgHeA6pqjh165v/2zE01eLRhU/PySUDqBLP6oLv+poZNs4IDhUSyi/URbNQurdtelhbSFg7k3X5sl0LBlVK4Oh8tuzKB9z7W4o5TCXBUKHaLNsgrsJ6ru8LbS9EyuN7YZBhyJR1AInKPBhuq/ME64XfoSYKLDnci1yM/RGHOK5znEcxj+skbnuIxLUaax/aMKfqaUX1cV6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWQyKz1cB0HYVvTuJ7TELKN9JsZ4pd0Q3O+IsJX1OVA=;
 b=ICKk95JA8tzu2oU5RuAH9aZFAdAOQftIEJTr03AUBH9fmAr8rAoIa+xmA6YFM/Zbrs59/P6v0Cqmj4tAlzm74UDJXksk4VhtqzOP7aoM9zFAJwEno/Ob0h44WZL6zXdhETUG6rNxfAUx6ULjWODjvZAN6419P6980yglO5q8YUZvyqBpvp5POKjUsHKa6uMkx1EsrUuqXt4EA42Qhq+CiQx0LG8a2d7Mp5MJ/fMVFoka1+Na57Jx7P1tKyfDtfN9RufqZKrcuIvWrkhDSYKiYCEsVYDqvCRjbSk5dNQBdEl4i9pHY1tbAvJtdAYbvG7PhFoxNmqHUahCvzSDExDmCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWQyKz1cB0HYVvTuJ7TELKN9JsZ4pd0Q3O+IsJX1OVA=;
 b=lkFRCTSXMnhlNTtBhP+dVad9RMBRXdhin0JFwNrg9GZPYQ5iEMjK05UuV8c5PbQRCNYZ463dO2f5xlJUW0VqCbxsyFQDc4E+VUeDOQutj6cYQQd8Vxt5aslPIkBZVDx9WtvHmFnPnV6ucJ1ViDeEAD6C5g3sCBPZUpNaZnAnW6j0lNMMt+GpgW+kxoaKDxnW66vUJ+qo4ldP5+pCHh7Yxn32uDR/BKC8ZY+8ez8NdgVO+pjdvA4C9RAqOhzZ+nTLnkHAVhTKLCYvhdglWFIL6zKudy2bMeztCiMzqo/QbRCgDiQjkCcounXFAOT6LvUn8Gh/afb4q73TczVkSdQuwA==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Tue, 13 Apr
 2021 23:22:10 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 23:22:10 +0000
Date:   Tue, 13 Apr 2021 20:22:08 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     xyzxyz2000@gmail.com, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next 0/9] RDMA/rxe: Implement memory windows
Message-ID: <20210413232208.GA1386736@nvidia.com>
References: <20210408214040.2956-1-rpearson@hpe.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408214040.2956-1-rpearson@hpe.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:208:2d::35) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR03CA0022.namprd03.prod.outlook.com (2603:10b6:208:2d::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Tue, 13 Apr 2021 23:22:09 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lWSMC-005ozw-NE; Tue, 13 Apr 2021 20:22:08 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22c0e43a-1ede-4a2b-79c1-08d8fed2f604
X-MS-TrafficTypeDiagnostic: DM6PR12MB4451:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4451E86D2EA320B8FDE700EAC24F9@DM6PR12MB4451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lvigDAexAz3/3fNtnTIZRpaH+kb4cB6BlziYmoO/a5vq0qMnu06H+eBZ+lKda+n/0Hj3u+prZ10CEa3NReEam9EvkXcgAVbNpQpg6WdxM9sASJmUNCfMBlfa4SKqXPqsBDCgTRnl2zaPX+yFWiWUU3yoJTT78sfaFFyQLwNenNABfyKJwTJyS9vdsVPno2uBpI7Btu2mbegzXC5Z5fOB2nK9opoCwd5cayflSvSpFH1ePSacwmZMYibqfxKaxY7LyZWIfjDdIPCehjhHSV9nkMpvwU2wTEddxim3poffyEBJpkYcR2TU146H6wHn2zcK6ZMhmdH71lpPFI6Q5PL0uhT5fOevDX+1/9OskCPOFlgfe57vcssoKEQ10CUFqQQMbBFBa0tpWFSPlbiZso4TrKDud5NI4qph1iT9LlYGc31uDuZ9aZivbSLCm6/Ih7CP/K7YaVduipa7TcZcyVOZHdMg1DMw0w5kJettLBsNMGExvPZU+0NLXP+CaQnYeFFkL5Btv29LoxEQoKIJWInIjKRsfrrWzOCUuOfErs04wkjR0cYH7cwpooNbtCwIvYwo6pejEcmg56SZJZp3YBXZEQkV/ak8X6Kis6POkL+Grsg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(38100700002)(9746002)(316002)(2906002)(478600001)(186003)(36756003)(66946007)(86362001)(9786002)(2616005)(8676002)(4326008)(8936002)(66556008)(33656002)(1076003)(6916009)(426003)(5660300002)(26005)(66476007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?W9q0orgU8KVN9Yi+dkW8bbYZBjfn6zAdz8ayF3PoRh3uTnyb++grkehG7QTx?=
 =?us-ascii?Q?jtMgh1aLDl82RvtipPI+xJi9jYENffheLE5bFKYNkYXmRzlxX+hXeeN95Zun?=
 =?us-ascii?Q?y4dDUdMKdKMWQe5ZP5fJvYDdbl2z+js7lBIcrakAT/5DHNVHfVZH9nlYQRJO?=
 =?us-ascii?Q?Ufvjd261sVXIBVeKWIPmSSxer23Thm3hP69eGiBLhaLq+SGEvI3mMY5kqmmf?=
 =?us-ascii?Q?97ooQcJwBnAL4QxdwyZtVhwOXajRljFdiZmYUv8CQGFdbHrIyIPuhZEIbEt+?=
 =?us-ascii?Q?a183loLip9wAQ1Kzez0/e/ocytoVWjo0KXGswi+0Kw2Dt5Btsohv1p4ki8Yi?=
 =?us-ascii?Q?Q1YK08gqh/Ru9j9Qx/Ae24x4tFuYwuO6J6MNEO0uqA+7pVRXqI2LnaC3WwHI?=
 =?us-ascii?Q?N+qc4VbnLDkG3m+AG4R/K+XsGrHyyOOuq0Dsn/ZNj+fhUz/WokL/KRqT7KC4?=
 =?us-ascii?Q?oE0U2lSzqnZ4AFaPadp0P/8vMsTcJGc77mYBE6TElYZSHjoDUsxrarevcCxm?=
 =?us-ascii?Q?Ha6gqqegdnJTNmW4HEUu6Bn5ESrgEKazNx+ThnHPbdLkYkHN3SnzjZL+BUUB?=
 =?us-ascii?Q?TTt3Jgv4Zfg4GWryS7ozJLJrZR3FrJ0yqSsX1CNbAiRJAu6URNMvOJWvSIiW?=
 =?us-ascii?Q?XQtWHIepu9GrafESZnKZdtZuPztBhTnWIXxF5kWnXtNbcDbo3LvZaAfoS46+?=
 =?us-ascii?Q?QEMg0iEJYzhf8LX+qxPL1E2pUSjKUgr3Izj+1tt2GAsOGp+/LsjdthKcXZF/?=
 =?us-ascii?Q?OXTzbjP7aYsHErJ0Sb7zP3EiMpFbDon/la9fk3Xlb6m/nf/ymdIeLqNGV0Mq?=
 =?us-ascii?Q?B1BW1Z4RtAm5oCJHu6avUbqCaRO/egcRCIFAvhbncsg78AK6Mfhcr/sVhBfU?=
 =?us-ascii?Q?HX5w/xmdVL5k/HL2se9mGj73gFbksPdByS4VmLzyNEiMbz4wfQMxvVque6WW?=
 =?us-ascii?Q?TqPTM3vpKTa3uMUiiJs5SGyfkq/cwNiAxEKw7il1yQ5EHONekaaq23vQcrBe?=
 =?us-ascii?Q?NcGxJvWxdAyivZbSfhjAeloqSm9LZ8ouX7lXIycfRAYeLPHoZnXCUqgMVxB/?=
 =?us-ascii?Q?2Z+FvM4kmKsrDLDITx2PFmX/OXM5swmySmQ2Qe6hAN6XDkn6yegJAntsMvIe?=
 =?us-ascii?Q?WVj1dy9PWzatrnKq8fBopWLVx/cH+dlzjsY8bUEPtciH6dzcCo2yX6a3s0i4?=
 =?us-ascii?Q?PrO/J2YdPndIZJLvoM7OBx56X3h+MBnLkCUixmpnEIfYROgGgNxvWdbmNMoo?=
 =?us-ascii?Q?7d3hUFaXjK6T+J3Gh3AYnR29JmgotDHz5UVaCCzcpHUldJF6tGAknMlBWCBA?=
 =?us-ascii?Q?3I2RunHbBuqXN4unQgL08R9WDe7xsiKpB5XEA9StK9P5DA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c0e43a-1ede-4a2b-79c1-08d8fed2f604
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 23:22:10.1238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lTS5QHFoIO1oztigHVDIOMlrDC1kdfNIpjg+KlN2dWw/FQahEQ5X1VVfxyP0jIeu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4451
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 08, 2021 at 04:40:32PM -0500, Bob Pearson wrote:
> This series of patches implement memory windows for the rdma_rxe
> driver. This is a shorter reimplementation of an earlier patch
> set. They apply to and depend on the current for-next linux rdma
> tree.
> 
> Bob Pearson (9):
>   RDMA/rxe: Add bind MW fields to rxe_send_wr
>   RDMA/rxe: Return errors for add index and key
>   RDMA/rxe: Enable MW object pool
>   RDMA/rxe: Add ib_alloc_mw and ib_dealloc_mw verbs
>   RDMA/rxe: Replace WR_REG_MASK by WR_LOCAL_OP_MASK
>   RDMA/rxe: Move local ops to subroutine
>   RDMA/rxe: Add support for bind MW work requests
>   RDMA/rxe: Implement invalidate MW operations
>   RDMA/rxe: Implement memory access through MWs
> 
>  drivers/infiniband/sw/rxe/Makefile     |   1 +
>  drivers/infiniband/sw/rxe/rxe.c        |   1 +
>  drivers/infiniband/sw/rxe/rxe_comp.c   |   1 +
>  drivers/infiniband/sw/rxe/rxe_loc.h    |  29 +-
>  drivers/infiniband/sw/rxe/rxe_mr.c     |  79 ++++--
>  drivers/infiniband/sw/rxe/rxe_mw.c     | 356 +++++++++++++++++++++++++
>  drivers/infiniband/sw/rxe/rxe_opcode.c |  11 +-
>  drivers/infiniband/sw/rxe/rxe_opcode.h |   3 +-
>  drivers/infiniband/sw/rxe/rxe_param.h  |  19 +-
>  drivers/infiniband/sw/rxe/rxe_pool.c   |  45 ++--
>  drivers/infiniband/sw/rxe/rxe_pool.h   |   8 +-
>  drivers/infiniband/sw/rxe/rxe_req.c    | 102 ++++---
>  drivers/infiniband/sw/rxe/rxe_resp.c   | 110 +++++---
>  drivers/infiniband/sw/rxe/rxe_verbs.c  |   5 +-
>  drivers/infiniband/sw/rxe/rxe_verbs.h  |  38 ++-
>  include/uapi/rdma/rdma_user_rxe.h      |  34 ++-
>  16 files changed, 691 insertions(+), 151 deletions(-)
>  create mode 100644 drivers/infiniband/sw/rxe/rxe_mw.c

I think the uapi file could be tidied enough with some #ifdef
__KERNEL__, but the series doesn't apply anyhow:

Auto-merging drivers/infiniband/sw/rxe/rxe_resp.c
CONFLICT (content): Merge conflict in drivers/infiniband/sw/rxe/rxe_resp.c

Jason
