Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCDC3F8907
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Aug 2021 15:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237433AbhHZNdk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Aug 2021 09:33:40 -0400
Received: from mail-bn1nam07on2046.outbound.protection.outlook.com ([40.107.212.46]:32736
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230288AbhHZNdk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 26 Aug 2021 09:33:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwZUZpnJG2wP5td26w0l5x/14bRYVZFHdboyJCNTo0bz7607sWEMp1TajvZUZlvgmt18SBfdruCVl40e0siYozQqF9d1JieYu/IAIXZ/eVFF61uX+1caVZ0Hch8a9Q5aYKypRph4J3FHSakmsyv19OESgrB3RMlvF5B7h0Ml7+pC40Ne+kfOH+kuPdPcMTKh7RhrkIO2XOwLNtu7rHMemvpfqs2zNiCeQKVYM67fGq4wiiKn9yBNbCoRNhaawwyUHVmqF5yePC2SpjQ5UTMBHiWTd62Q7t7eoZhz9GbCVhCf5eUvwC0EqHmGi8oVOHn3ATuN+JBUMw0JZTseR1Prjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2l+BhjLkifEadZ2QArG7sQCTFOaghDOir6/cmJ8rp0=;
 b=fzglrhGIu7iFAf5GR4YctYWwd6ek3MCm7ApH0Fo6NCmB4Wd/+eU0UfoTP7BY9OPCjYglpb/zLFVTo0o6OQP1mqgjqqVKWxIBhpHFJ+qX7zAQD+3s8Ipr0++0x8fz7MxT7QfSq5TQdfZI5uT4MWyk27yM5K/rKTi/RXo1c3j6z4fXpmIq03xWxUpp2LDvQYVJdxEu9rQpBkcF3+RhiakFB4clt6WwluUhKywThEnk0TPTOgA/2GIsCrlG/kLKJHEisGqjdfO0OMyVgiS5L4NRaVOUsNwf53y3CCJ68gJ21Q7yS1jza9JeExkHYvtVf2E/27Pn9rA7nFVWVgTji1vYSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2l+BhjLkifEadZ2QArG7sQCTFOaghDOir6/cmJ8rp0=;
 b=UudItEfRJl2vPemXbPMYfb2Qyj6f6wHx3hWfdDOnEeYGOtnGDYZEkbqqUjrUXNyG5HikSnvjVge1JUC+IwWpZZmxwbnOkaf+Sg07c7NUzF6Z/OqnIEngpY4eSgis0LAzIZ3RxLXOIxiuwlTd7LG3zuwBeoPz1R3ozb4EPKVDay9lnoEaT06Ft1VXW1yJou8H0c/SWWrTqO/dcRCgUCpF2/0xf/MJ76B4s8j1AewIKxSBlHIK9i0fVpekvDV1cWtjzfWnUTR+4tu03Nser6O6BYyZiAlGKwECkQyHne5T1CMCwMF7eCmRNUH/Gfmeak2yXAH7LYgAWRPMj+0NAixiCQ==
Authentication-Results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5301.namprd12.prod.outlook.com (2603:10b6:208:31f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 26 Aug
 2021 13:32:46 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.027; Thu, 26 Aug 2021
 13:32:45 +0000
Date:   Thu, 26 Aug 2021 10:32:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yasunori Goto <y-goto@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH] RDMA/core: EPERM should be returned when # of pined
 pages is over ulimit
Message-ID: <20210826133244.GQ1721383@nvidia.com>
References: <20210818082702.692117-1-y-goto@fujitsu.com>
 <20210819231053.GA390234@nvidia.com>
 <f784a0c6-27b7-5e30-b3ba-e1f4ebe95399@fujitsu.com>
 <e3cb3dee-9c32-8024-1396-8dfd975a7b23@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3cb3dee-9c32-8024-1396-8dfd975a7b23@fujitsu.com>
X-ClientProxiedBy: MN2PR17CA0019.namprd17.prod.outlook.com
 (2603:10b6:208:15e::32) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR17CA0019.namprd17.prod.outlook.com (2603:10b6:208:15e::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Thu, 26 Aug 2021 13:32:45 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mJFUq-005J8u-CF; Thu, 26 Aug 2021 10:32:44 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77ba7f79-d874-465a-3b84-08d96895fd08
X-MS-TrafficTypeDiagnostic: BL1PR12MB5301:
X-Microsoft-Antispam-PRVS: <BL1PR12MB53013C30DFE6D91E4D2ECCBCC2C79@BL1PR12MB5301.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /kdF/vlOP8Ns2RTr+ESpFdrajDNkR6OEVDfzXn3z31AWZXGF6JZj1w3ewVzNyueWRH9SeRKCb0N9I+lBvp7M4Qc9Wfk2bbbklPbtumtyCM5T5c0oXg18H+5VB6TRZrrfcts+gkDY9LdEnZUb+lTLv2YWpHS+S3TNPp5IRhdHd70sGoWThGFhbgRoCUyXtk0mI47mebeVFGnhKMfYEYtDbb6kJg4DE4ErKxeuZng8WhQJ+S6FHnuJ3jiE1+xgFfWfFH9COdWeZgwwdGmDPhgCGyZ55BUl/iMVDHyKviT2y4QqRftvhQA6TWSrjee9YSoDsMg/phU57FSJjk1mnaUc+wfQDANsVaEY/KW8oByIlWLrFAQymKl0hrFD2o6lyB+qQwyvvgnAx7Q57NiielEbRYcr4X/lSZfSJBlEBtM5vvdyEGN1Zflq/jPwBTxzgjuZKjf87RFUpvdKPczYyVDwV16C0g7e5oDcq4/FdjUrE/CQX38gH+d/ji4/cMLGUaY9RaLQtcL6WP8KFKUyDtOK5Z8x3QpLHmKhw5ztX2nQbdYBgny3yx/Q+T49+LO3uhK0PUFsI8jsOI25KaoQ2h9VmJkIcfXDV1vulQ1Fil6LnTpFMs9ERqSkJnk1M+mNMwb86JlFnBDcFCbn3qjmEop8lA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(186003)(426003)(2616005)(83380400001)(478600001)(86362001)(4744005)(1076003)(33656002)(26005)(38100700002)(8676002)(9786002)(6916009)(66476007)(9746002)(316002)(36756003)(2906002)(5660300002)(8936002)(66946007)(4326008)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zaMCIUdWIwUgbujh/oEzpJoVxurMvSXJp5ixseZ2cG6RMb11QbnndeDibuWy?=
 =?us-ascii?Q?SnnzHlyTHCi6m0UGEJ+XPkq0Wp4E/W7BmKe5os65gYTCC2Zh0yM1aO0d+Jpu?=
 =?us-ascii?Q?ExISjuqbvYDdQC9vKmWPY/DHpK1w3AwrpVv91f7QyoIzf9rdLhmZFn9F269b?=
 =?us-ascii?Q?soYKssxssuyhBZk22Y6YrhY1TBowp1ixgxcejA9mYdjknwRseT8JbEcwe1sl?=
 =?us-ascii?Q?FSL1NNaL1TFaZpAMJWhBkT6Vbi/1thpqUSyMj0c3yF0YzR/zImgXaN81W9hm?=
 =?us-ascii?Q?rFRfDy4+abbj11DPk01/qGfusMS4aNq+nB8B13PMUVnZ2nrCDf1u6DjrADFU?=
 =?us-ascii?Q?Ma8s0NDNQzdz/IQfcd6ov5By2TGJg2lxG8NkFugzy8/uM9lLu1kLv0xcq6ED?=
 =?us-ascii?Q?Wv+Y4261v+aqV0Qwu5S+AHqlXfUS8EhV8FuY2mwsEV2urxP5KRZOdwlrdbUp?=
 =?us-ascii?Q?qHF7PQy7ZN3XgsxLwTQob+pvt+gILFr2XjW4RKKfGrChzv6eo5HWMapwSWXt?=
 =?us-ascii?Q?Pde1a1XuQ5Q0DkpaHZ2EHPtFhiFRDsbNQEvdEAIhvQJd2xfiKZEhsRSTzWTp?=
 =?us-ascii?Q?9RwYPRDXHIuorYXsIqPb2gfnG1PYWt+/eemnT0Z80ysAxF/08V8Kr1/I6ni7?=
 =?us-ascii?Q?eBlWNVXTnk0NVFulxwdJW5k//SYzquzKxHIYX/77NHUCCsG6rXPrO52y2wto?=
 =?us-ascii?Q?CFxyKYbt/aEQAUJKaUgF7TCuBXCvQ2dvMmQgbMl39dSiuWvBO7DIO446cmu+?=
 =?us-ascii?Q?J8w0Akt7JHSGxTnReXXCa9yGOe2VhSp/rQxKnTtuJ4xDnmGbFBkbVmFGsB3z?=
 =?us-ascii?Q?q1K8W7Q6fz5MRuXXkiKLzn90hk/kyRAtac62RFqwWZH9x884Gbl5cN6jnQPk?=
 =?us-ascii?Q?cbZyRY294sGJjW+Ym//xxIdxNrhrobU6auNto1GlxDCM9U0y31FnLAkxjRvZ?=
 =?us-ascii?Q?jOmcnU23RgAUvbkEKVIvtQ3ajZ6q4cOHGx5eklJkxjZp48ypcrEetuglRaEI?=
 =?us-ascii?Q?dSkNgX5bEFFc0OX++nCooueioD9VEcLnFfdSx3f0D7w9BVTNKmDTOOfasktp?=
 =?us-ascii?Q?QoWumpCW+JqXW4SZLv5fJgyeTbmX04rbjXhjuR1Tg0KPjlYebmBsye0A86Yt?=
 =?us-ascii?Q?5Pb+9L0XuPKU5ZktZHxUu0YLJ0yMsq6VDV56DwbVjJjh1MmL1ByVWkongTFn?=
 =?us-ascii?Q?FK6s7vpX7G+opxly9ULvmFm5qNf1d6hgZCGH61RmrE9UJBj65SzVYymlf61q?=
 =?us-ascii?Q?TgQzOrv6JFzfjW6vqWDMojmM6Z+oBmcrB+YpQzymb6gU/wh25AeN6+gBmiwt?=
 =?us-ascii?Q?AecDKiKruDTY6u2G94vvu9z+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ba7f79-d874-465a-3b84-08d96895fd08
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 13:32:45.5899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ddejatB77ESB5SIN8pV+y4q7Y/EG+TpCBC3xYhCehJse20tIKi+c4GmkSoUZnEU/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5301
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 20, 2021 at 05:45:54PM +0900, Yasunori Goto wrote:

> static struct page **sev_pin_memory(struct kvm *kvm, unsigned long uaddr,
>    :
>    :
>         if (locked > lock_limit && !capable(CAP_IPC_LOCK)) {
>                 pr_err("SEV: %lu locked pages exceed the lock limit of
> %lu.\n", locked, lock_limit);
>                 return ERR_PTR(-ENOMEM);
>         }
> 
> I think it is better than nothing. How do you think?

Unprivileged user space should not be allowed to cause the kernel to
print messages.

Jason
