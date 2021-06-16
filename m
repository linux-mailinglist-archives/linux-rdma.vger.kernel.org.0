Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2CD3AA415
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jun 2021 21:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbhFPTQX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Jun 2021 15:16:23 -0400
Received: from mail-co1nam11on2066.outbound.protection.outlook.com ([40.107.220.66]:47936
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232377AbhFPTQX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Jun 2021 15:16:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9DqgB3fR9Vvs9mDM5gP0R8V62d2YqvMN2BBZc36wJs0N4B8HZw3EDc1nx4I61dN2T216dpxHGy9ygLaZS8/YNlZxxN2lIO4sEsIBccmJekt2nw3FASS/V4e6l5BO83fDw0/3OaFiJqgG3GdHVLJl+sPKkdDS83gxiXeBxF/ssYGGRTHK3cT+oS2iZVBTA4khzesHnCSc0rxYhKo1rNUYp0ToOAhjkWnTUhJ2TnT/2wKApKBSyqk9RI1ZAmMaNXh7zBhK9wzXWqjNXrLzGDuMQwh8/oSv3j0j8Vm7V3RWvK2LhozYM32p58P7n5TWb9Z4jxQ2qyJKJV7A6vdUfs8PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLkUKmkvz+T6vKKAHlKFy69itV1hkil1/EBH6gyoVek=;
 b=AXloornZyWUmgDQym7xikMk5BXre87pkRjvk1HpWJ2T6Bge9is9IGQHPS6pm1Tk1ibhXAUW6y8GYbcIZ3fR5s0FrLXi78+kpacCj+A2AJC0swbWdSI3/IKqFHyFirWlYBI+4mn3k95NT3qihyNQXKe2W87fjZmUFy85R1U9bR6uqxhBNZaD0jDHgQVUeCnMi5nuZJtjF3qc6xMPixrIAtaefu7o+MDAgbBK9qqVed4wssNZxGXY94gmbwes0WoXFT53CxK/7kygjGFrcuLe3f+0FFrRcs1j3GjRqQCJBzqn8dJLq97vX0WwWXCH5dYHUuIRFLnHa77AhSS/5tcQR2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLkUKmkvz+T6vKKAHlKFy69itV1hkil1/EBH6gyoVek=;
 b=pwHxgc1xUFwt4t/7YT/zCPMUc2PuGUC8qEIBQF3lwFJn7JyNmSZYzcYhhDFHMNlFdt9JJZ5zqA15M2k3jHQ1Re0fHnFMcPbffK02ZBP70aRGBL/FhR9nj32oAzSoGDXBh7hFl99DYKFcWno9rzD3WwW1Wt7YsDbFaJyHTcDVQnDTW5CpmotHymtWS5OJlFEhggXAZ6zqs16ZR5BtkdxDzpVJsgvXIY/7QoZoD91sWdb7I4m9w5M/pyiGZe8FQlzggJvYlJHr9YX6xfebyp8HSn73eEEoCapj8S7AhmxD6yy2k1mMCW8eM3OlnPoqaWqAKfPGrceyw/9vtUqImRiGZQ==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) by
 DM4PR12MB5134.namprd12.prod.outlook.com (2603:10b6:5:391::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.16; Wed, 16 Jun 2021 19:14:15 +0000
Received: from DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::18b7:5b87:86c1:afdb]) by DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::18b7:5b87:86c1:afdb%8]) with mapi id 15.20.4242.019; Wed, 16 Jun 2021
 19:14:15 +0000
Date:   Wed, 16 Jun 2021 16:14:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     liweihang <liweihang@huawei.com>
Cc:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH rdma-core 4/4] libhns: Add support for direct wqe
Message-ID: <20210616191413.GO1002214@nvidia.com>
References: <1622194379-59868-1-git-send-email-liweihang@huawei.com>
 <1622194379-59868-5-git-send-email-liweihang@huawei.com>
 <20210604145005.GA405010@nvidia.com>
 <efc5283d762542f6a4add9329744c4ee@huawei.com>
 <20210611113124.GO1002214@nvidia.com>
 <3fa07c87b91047a79402a9871e4e932a@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fa07c87b91047a79402a9871e4e932a@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR18CA0001.namprd18.prod.outlook.com
 (2603:10b6:208:23c::6) To DM6PR12MB5520.namprd12.prod.outlook.com
 (2603:10b6:5:208::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR18CA0001.namprd18.prod.outlook.com (2603:10b6:208:23c::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Wed, 16 Jun 2021 19:14:15 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ltazN-007kfl-OV; Wed, 16 Jun 2021 16:14:13 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 906ab825-0ad6-4cbc-6ca8-08d930faeea1
X-MS-TrafficTypeDiagnostic: DM4PR12MB5134:
X-Microsoft-Antispam-PRVS: <DM4PR12MB51343C28F8A6C46F1803785CC20F9@DM4PR12MB5134.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yijdkKqN9xCDdqXNABUX7gXgGxn8daKcvc5a7yyY2JdEzctewcevMFwP0x5vTRQywWD5xQRLOuNnmbgNXrYX3BlNlWyXBltqPb8rA7oYajgsyUMG2huFCtrIRWpD3tvalvLgojGBl9inwmK/F7xcGY+5xJ/GTrLT4DevlC9c5JLQlVpJp51RfTf6mXcNTXxpPBiVITn54fGoCd7YFGZLKs1Que/awBN4wmtH1KeetYVJmcfYSQFQWluoVi/wF7nOd1UVOrxe6hq8qMh30aBrwckvQu9eW2TFFVo9wYAVCxvqWcNNCvhXO8+7Dm4fwpw2XDG6D9BFTJcjKPnAXcw6cmq1UH41EgaZl4GwU+jX/YJg37g2ku4tQ82g5RTrj8Y5JNJaOo4a61sM6pSioVrYn/17u1enFo7W5Nml11MoGnuAp6CZDv4U9I7KkK1JrIvohP9f5U3rf2s0e3fknEeXvoYoI5fgUbEL1HjVP1sSy9oS1kOc+9nGp4DludpdUbIyz0OIR04+9pj0tCMtSHoHtPu0GX3Cn9vYzbqWXvEMr1J3QrQsm+pL4CYEjo3PfUs2uB+/HABCEeHR2d5ujPr54yN+HcDCBQ0ubULH/B+wMlA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5520.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(8936002)(8676002)(4326008)(33656002)(36756003)(83380400001)(26005)(6916009)(478600001)(1076003)(5660300002)(38100700002)(66476007)(86362001)(66946007)(4744005)(426003)(9786002)(9746002)(316002)(186003)(54906003)(66556008)(2906002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rGi4UXKSzz0R1f3SNsMxR8qISroSMQxTaPBPZsN975Ruf0diVFXLLRMZA6kr?=
 =?us-ascii?Q?wCtjgc+eacDMjbtsV+Y/4ZMs16WwkX567b8LNaCm6287+uZlm5E9h0L/2s4n?=
 =?us-ascii?Q?EuJia/Zb8thrg9Bzq//XO8RZPwM9LivdjnW59DCCdvgG99McJ/+Fd6HaqgC0?=
 =?us-ascii?Q?ndQ9PNULMgMt8n0P8oPhtkb43dlWdxsNpWs5Bv1ahHB2IXzPjPGUadpAO1TZ?=
 =?us-ascii?Q?U7pSSnE4zD0aKBp73YtPdjlWSUKkdxI/0hXUQV2Ev9BOxm5IXjD9MiYbb+Qp?=
 =?us-ascii?Q?6VtWnGDwRBgxTKI1yFsYKIGFugHf6OWdDYbMONrZeu416TX511R9aJl2xK+C?=
 =?us-ascii?Q?CJ3PB117hstZll8BOQfHwQbseRo57UnvmeAEKojO75dCLttPizOzM60mBBiX?=
 =?us-ascii?Q?YheiOfn1RDAZKmBqoi1oj9te1MorDVGhKZpvoQYDyoi2zoevwyFvWJSKdt+Q?=
 =?us-ascii?Q?w1RalDz/L720ynY3bHxB7PTtqfvsV+TDoh1rkIu0+O6QqhuCDJc4M88vV7ku?=
 =?us-ascii?Q?yS0PIflrytwMyh0LH1fZL+gzcWQiBj4ckPveT3sHeL3Dg5PU6APbb0vcr+H9?=
 =?us-ascii?Q?Vb9Bqkg2HUSayKPXRnHuxhlHPxB3eHJ1GFlkGlu5K9e13HJOuU0cjervAZzK?=
 =?us-ascii?Q?KEOW/mIzhaEz8k7phnhX6ekqV5iSSJk0KEwSEPOtLzuA9wzJq0oYVO7t6KN6?=
 =?us-ascii?Q?51ownfK3MIhRgelHUiDqUfdru5BLF+tPqUhvk/A11eQ274bT1jCrvGqcjqoZ?=
 =?us-ascii?Q?BTuvfpjvKxPg40tq2QCFFmXRca4E0osiOqhQeshkgQjwzDuuiu81kq+n8Jvh?=
 =?us-ascii?Q?Eexlj8iVNUE8wFQqfBkgyZH0vvnsXajoJXw26S2nJ1nOa+7N1aKQ7Pmgh3uw?=
 =?us-ascii?Q?5ZFmniQN9u86w2BbZGHcHUIK4a/x/pIaEdg5SJEQ60J/OYxrWrSyk4WxGDzn?=
 =?us-ascii?Q?HRrNDOldsGF/XxRa9/5pdm/ESU/UimqzHxEzMLKzZ96+VzU29mW54xj2XiOV?=
 =?us-ascii?Q?t9MXQUorM+dUfgoj965+hdUk/JOgotuYzcuh4OVVthzwfX6PvfN9l28/+5L6?=
 =?us-ascii?Q?AIJUyogi1HTmQxr3XCBBDBb1j6P5eYLxCh3TRMxKFqISSP2eubIGWM0cyKwI?=
 =?us-ascii?Q?Tq/9Sashe9Gl61Pp+Lwgca+ZfCjY65F69760iMyb6I2F7LOVMDXPrjFXpJZX?=
 =?us-ascii?Q?5/v/rFzkundFiC9Lqxw8lph+OfsMIXrjR6dfrOnoVPm0JBsqeXchdlZhmh3g?=
 =?us-ascii?Q?BiytnirjGGCnGO+d/wck+leCveKBAu1mXu1GCTp1kHTfr7AIl2Uimrhmb/dI?=
 =?us-ascii?Q?50tehbcWd/v8eEjpEO3ad1j5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 906ab825-0ad6-4cbc-6ca8-08d930faeea1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5520.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 19:14:15.4633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fXiS/iWyeDhvwB3+PwoYQyQYYBy4cc+2IiQ+p+J4IUdRj446BYXXFjflAZ4xa71H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5134
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 16, 2021 at 09:55:45AM +0000, liweihang wrote:

> If there is still any issues in this process, could you please tell us where to
> add the barrier? Thank you :)

I don't know ARM perfectly well, but generally look at

 1) Do these special stores barrier with the spin unlock protecting
    the post send? Allowing them to leak out will get things out of
    order

 2) ARM MMIO stores are not ordered, so that DB store the ST4 store
    are not guaranteed to execute in program order without a barrier.
    The spinlock is not a MMIO barrier

You could ignore some of this when the DB rings were basically
idempotent, but if you are xfering data it is more tricky. This is why
we always see a barrier after a WC store to put all future MMIO
strongly in order with the store.

Jason
