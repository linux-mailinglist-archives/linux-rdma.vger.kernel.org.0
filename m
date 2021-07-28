Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637293D8D59
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jul 2021 13:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbhG1L7j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Jul 2021 07:59:39 -0400
Received: from mail-bn8nam08on2047.outbound.protection.outlook.com ([40.107.100.47]:59037
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234647AbhG1L7i (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 28 Jul 2021 07:59:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NcUs59fdcoumPPQqLLwES3K/GZFEGUvjuwPMa4+be8JDrYYAXZxpsl1ma1EUUZ1vvQQrbRml6+gGW8p5qY5pecciDpIN0AFMYdO6hVxyRzV/DcKTUNGRj00Cwf8G+7SlLq2zkSbRkNB2rXwYTigS7Qhe4aPkkpQzuvzRvUUUaZ/yL5DLIHpB2XoBFUF7n32ES7wFmcEA0VZ09nmlWvuitprjGp6qQ0J+O2PE1denmzJDZZtr7Q+2+hFKVu9AeEkm8WPD6mZnOK59jVA4V5ReGlz2L1LpGahFfr9ayNSw3dDzDnP6wQuP/Wg4u9jc+4VVQiyTX+grRtBY4s2c7Gw0Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuMyel7Jz/nYkcHivdbF4Z7UZrOeB4xN4Gev5khD798=;
 b=KpAWhaViQ2a8FAMJcSX4mqIiMi/aMsLlxa7HUMYb1PdxxKXZMz7rg1Gm0LMqOuF5buSqqCCFpEZj+4Gdi2m1WuYslHFx2RysLXgA8tH1jr6cQjI9eIxJLrCjpviQxuAuIim0UulFx+o4Ova8pQ2FDuJfWAXI3mX/OzxNo71HMd22oHHdFEzciV/6guCqLFEmH333qC2keBBVv5YheomZhxkemA0k7fSUwUSFFawl9DFVROz7QZbXqGU03hixyVZ/R8YYnSyEcAxoDQrSv1ZQsm1eRRqyKrEVFoZ/LjdZuOp8bIL1zeuixJXtcOVcVo7WEqD+9ppU3d5QdCTkJgW0Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuMyel7Jz/nYkcHivdbF4Z7UZrOeB4xN4Gev5khD798=;
 b=baJbR/6Ja/uEBA7Y7WkoQtI/d+6GxWfQg02xhCxuuCDnkZMc/U56pAN38aTPnY1yTzRigbEZtziWx55du/lAapOCxIIgdAyTkl2zk5OjGSGmF1C9xzTlzFf4Y/86bbMC6HLyaJvCRQN2to/ZWwr3cf44WQYFm5KG0zl7XvdOMHU8cuarF93wLQt7Xj+tXQe9sQVl3rbmDCaxrnlzpIbTaG2XMj6xljfyxeBe0PWk5aCtRrv0gz5EDEdaRhzF8k3j1a5Cs8eFT8C9ltrJm6GsQq7jhguSmnThV7wUL/hWF6aqn+TD2yhT7evMPzZO+HBGJdyBn3/m6TDhWs2P4/iZnQ==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5222.namprd12.prod.outlook.com (2603:10b6:208:31e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Wed, 28 Jul
 2021 11:59:35 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4373.019; Wed, 28 Jul 2021
 11:59:35 +0000
Date:   Wed, 28 Jul 2021 08:59:33 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] docs: Fix infiniband uverbs minor number
Message-ID: <20210728115933.GP1721383@nvidia.com>
References: <a1213ef6064911aa3499322691bc465482818a3a.1626936170.git.leonro@nvidia.com>
 <YPrJorr7r9Kd2IzA@unreal>
 <YQFFJgMXFSN8IcjC@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQFFJgMXFSN8IcjC@unreal>
X-ClientProxiedBy: YT1PR01CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::16)
 To BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Wed, 28 Jul 2021 11:59:34 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m8iDl-009cNZ-1T; Wed, 28 Jul 2021 08:59:33 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cc63e7e-608b-4295-251e-08d951bf2ada
X-MS-TrafficTypeDiagnostic: BL1PR12MB5222:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5222CD6EAE50D220DF6CDBF5C2EA9@BL1PR12MB5222.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PrS5ytj+0k/A2MIet3KrXUXUXpMWH8wyRcgGDTj+sSFmHJZ0t4UFScxcmpprwMjBPizCl9U4VFSs3nNA3//5VonqgEHqp/lPrPQ5JOL/fMHZ4yUkGKFIusi3J3Nv1S8xG6FmTbRD1JCwZbPTCUNAodSicx83TCUPUwa6Np3irJSsW10jec+Q/dJR1RO8KgiE8T06IFVCE0gNRIFiCGot8d7WenlVRHiW1Z2yQOOO5VrIYDDqGzeuMWQSHYxv4MZZfAvAeS5CMFBnvNe0pIu7Gkj+WBqihGNhqnwAJAT4rBcXGl2WkjsQjniRgZoMOn8/ldJ93g9o56dg7UiKqWPm9/Qm4q9Lon7qketXWzkDeCliNGHKqPexvi0NQNb4afAKqzAdgv+B101xI05mZGMD5WSZgtBgI5wlBZMObMpy6viO13+66/a4Rh0R/BCKZWVluWRYA0MoH+I36s1LBdsvYhm6KeMzF3sm3vokn3TYJHdk5tHyeMsGNL70mWFPim7rShAnQL2tmgninXmBIK6P/zjBuEysf9qH5zM1IdZWCLkgaiSc1WRJ01vPxcAv2kz4j1q6QxF85BFYsjixGkNZu311h4JDay2WR/n4SWTdZ+6LrBvqqHunqxyOiOXt34ehmmQOJnZDCjuGpTDplVEhBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(36756003)(38100700002)(2906002)(66946007)(186003)(6916009)(26005)(2616005)(426003)(86362001)(9786002)(1076003)(4326008)(478600001)(66556008)(66476007)(9746002)(558084003)(316002)(33656002)(54906003)(8936002)(5660300002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5R8RESTdLa4VXefOXhQh8huygDVwoXsoz3OVkPrmj/0DQpx4IIb3snDL+sxP?=
 =?us-ascii?Q?/Ea6mf1GzX80C/d3AnyYT7hAnxPpS2IhDn/JfAJEUv1eQHECpyPRX0c/H6fm?=
 =?us-ascii?Q?TBDa1rm7rGh2xYSzy/FS4k/laisE4Vcrk4Gp4vdp53u8UUXZHNOAn0o9b7Uz?=
 =?us-ascii?Q?AD5u9rdLd20SxkLPHrHv0hcz5HbgYX+jeoT4tfxVTaIFcdvGAkflzuM5l1fB?=
 =?us-ascii?Q?1LWyiyl4x2kK4RkFRiaNqKXK7TQUGUCDN7Fp6tS9seNAtugd1FFAWfFf2Gcd?=
 =?us-ascii?Q?WIS1zRTEO0BkGd7dWZYZW6R0Yy6cqnJu4mtZQzIogoQp/MeHRkd2hnpJRyjG?=
 =?us-ascii?Q?+vKg0e/YA/B0jC6Le6aj74iBccMoBtHdGW5V+rZFRdRLT4ZfpwA1Xs5oXycd?=
 =?us-ascii?Q?30cibNfhpzh80ibIUF0DqccfuMPmdYxoDv743djZVQMpGekyFhjukQ/ZvxU6?=
 =?us-ascii?Q?VmnB86uqfMai9DOcjqDTt+MWUNWqjMUjeEp4f2psS8DsUjNoQ+84PL9jMTNS?=
 =?us-ascii?Q?jcPqV96ULQGpVB4eJ62SBvpEwPvC3JaV1TlDx98dtpoKN/ySOQYvv/BozUgU?=
 =?us-ascii?Q?Ff1X9gRrJAIoVw3xpDgMWJMJcGXS3v4Ol6lCQGOze+qsVKQIdPKISiYxrwYB?=
 =?us-ascii?Q?wkm/D89ZOhaAo2b3fpnI3HJJ+s4hbu89CBNt216Tz0gOdn3r43B29iDTvTta?=
 =?us-ascii?Q?63dpd/XWRSWoA1iOQq216rllqmjOhda2NEGxXNzI4Bb30Ptq4TWHuAf0jJva?=
 =?us-ascii?Q?oJqWTR84W9mL1PkFK6otPbfXER9bzsp7KlFLAbRdnVdgyOa3cWY/yvoH/IBl?=
 =?us-ascii?Q?nZOdsyDNb55O1JOesMswVcdZarQRkBz3xultri04wu507XUJ8d9m7Qiq5oHZ?=
 =?us-ascii?Q?lr0yHRAkd2tkGNm46iCSiAHth64QKed6wN0gzagQmZCQJQl1dKb5s1xoE/Jh?=
 =?us-ascii?Q?yhXaxc9djteKoo9A9U1qyoOdngI3TriwPjQm4ThgTxIwaZQQYdvfgZReHYIp?=
 =?us-ascii?Q?iDBshL2JwZs0GgmrXG1+bnbb6KcvxKLbt/YOyDkl5zPmU/JlNUHRuOATwuy3?=
 =?us-ascii?Q?berbznsqJsTq/hozyDWEAN77h4UQDb9NqW9b8M3TuU8pjRcM05pI8gGXrcGV?=
 =?us-ascii?Q?B+3vDz+pmxixxQv4uBAxyjJjAa5Tiu43DzmCLLdfdFOSemSg2nzZEXQYu/Nl?=
 =?us-ascii?Q?VJiS2RTHme3C9b9pRtIqHyd38M2lA+lp/roWjQx3mmSh1F+svDbnJSShuV5x?=
 =?us-ascii?Q?rA6dmDTdMq99EhFx60oY4s8y/gjhM38P1TD7VHBjE23ygFxn1B1oga+ZAX8B?=
 =?us-ascii?Q?3a3mbXefxmqiL4MPtK/Qt5LL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc63e7e-608b-4295-251e-08d951bf2ada
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 11:59:35.1428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GxZ/tG2tqLnbpWfC78HGNw7J8NzP1ASct7CDUYCvX4JAl7wB/5dirhmQjFo/ife/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5222
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 28, 2021 at 02:53:10PM +0300, Leon Romanovsky wrote:
> Jason ????

I don't know what happened here, but it is not in patchworks

The patch looks fine unless there are remarks from the docs people -
please get it in patchworks

Jason
