Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383F43CA545
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jul 2021 20:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhGOSWJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Jul 2021 14:22:09 -0400
Received: from mail-bn8nam11on2050.outbound.protection.outlook.com ([40.107.236.50]:13793
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231627AbhGOSWJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 15 Jul 2021 14:22:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qt8O2YkDhdA5pd3Tdvh5V3dfhZCrCBr+I+qAjVuvyVvElUTPxN5fowx+dsFyesYVsHdGNcfiZ1CD63nCnPWMMrwyXD1paM2U19tz7y8E+aBMatoeDxAgRuL6bCzZyCdo1vt978ZDf0EcHftMEout+HaX62So00FzQ4gMaYGMN1WZHSkd7Y2kVo9EkyBYTg1jd4V5yb00dE+bEV7tVY253aZPEnfeRoJ5e7SfofC41OhzyRYrfkGHplGKrgznedfG8o2ANawO8/kuX7Fbj5AIRg88DAE/twPzWDUgxP/y2NtJA9ANS4JwN2DpqQY9KjSGHH+axXdLdg/f2YbP1DoM5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hXRoypdsK1skd0l5wNaO3NTHs/49BQAvTlC21B3fA4=;
 b=er9rs7fWtKHxRQmdRrRw9Qg+p0ogx5vzjhRKK5EQBeffriwzNy27CFpNKXLsBKskbxDLDrlT1DR8YiS9C410da+reHu8Az7gO7Q8k8lYurH6MJFMwZcrmNLhtBZKwzc47C51P/ewoQSiWtY+mVn6xyrk06fjOo0qa2eQARNETaBDj0MfafJvGpL5eStzQ0AVweXLdeAhUG+F4vxNbuMvIeyVk0yv8D/zE9IUIOEkJZ9Db9hBtBYpJwFIcbTItdsXgn7Sc14raZ2WBgQjhjfE2c+4a6bqBbcFGtpwcUZh3EQkl3l85pCTM9HOpgKFUMrVhOvJJuZlbryQy/NllFjoUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hXRoypdsK1skd0l5wNaO3NTHs/49BQAvTlC21B3fA4=;
 b=BOv92dghyFheJQIHWman571BYINa7smB1/mW2IxB2Alkde6SYt9vqxQSTyWs2KcgVHUp3BQGAPwUULgLfsoTMjRBKSNVK4mzoWjV+y1qVXN7wsgTSfxoj8JTIM3BgFIRO5vKbshQaOE4gNiXpBbjyKCUIdGreZZ9ZonI87tbohsKKwzA8SsxDLJdWJ2bbiS3qgnWUmiZObNm9qLj3f3BE7ba+FlYNvQq/Uj8o9k4Jla31OzG+/3g00LU/vdqobQbQ8mTLNmfPZFlFOFLdgKJ44gJOyMGu23PZGIhJho2zrnboUPqgKZS9Ol0a+JJ8CIXpnfAYrL+lsrA3igES+Hefw==
Authentication-Results: linux.dev; dkim=none (message not signed)
 header.d=none;linux.dev; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5047.namprd12.prod.outlook.com (2603:10b6:208:31a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24; Thu, 15 Jul
 2021 18:19:14 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4331.024; Thu, 15 Jul 2021
 18:19:14 +0000
Date:   Thu, 15 Jul 2021 15:19:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     yanjun.zhu@linux.dev
Cc:     zyjzyj2000@gmail.com, yanjun.zhu@intel.com,
        mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        dledford@redhat.com, linux-rdma@vger.kernel.org, leon@kernel.org
Subject: Re: [PATCH 0/3] RDMA/irdma: do some cleanups
Message-ID: <20210715181912.GB673000@nvidia.com>
References: <20210714031130.1511109-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714031130.1511109-1-yanjun.zhu@linux.dev>
X-ClientProxiedBy: YQBPR01CA0102.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::38) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YQBPR01CA0102.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:3::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 18:19:14 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m45x2-002p5v-2i; Thu, 15 Jul 2021 15:19:12 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20ca6df4-3c4e-4d5d-e6c9-08d947bd0d2c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5047:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5047FD009ED29468CA743221C2129@BL1PR12MB5047.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lpoU/jf2+7MT00gCdKRN7SMwF+FzfCdiO3uUD/hZgAKS5udJkwjgjxAfzvchKgLdGj1QlUya1tE2krCljkwXNK4TdeAZOChKxFt8qEHY9uElFOB3SeXbB+1TAYXXyFRH5uaDaX2krXI1znsvScTDmicnuJRN6070lFDbsnzI7IKqgDgy4ukJwaDSHsLBe9PrfTeVkllhoS9LR3wOFY3ImzRlekGErFhaOwpGL8U6b7K2zMNAHiO76/9EsYS9oYJLNFTYoy+SxLEMcZJeGIvJtWZZnkEX18eAm7ecWNZW9KQtf3VJg4lk2TYuIAxjZkaHQx1ng26vPcKmQN36JaLmXRLVGMvDEOWuSxYr1Wk1BmdEN7AGPT/oi0AgaqhTLmdnBbC/OkBzIhDaKdWWdk2rkUViznWILeXMA1qnsoP6T1phIQ5gC0ryH/sH788gkYFjiuQmL8yP8L32hbdbCcrpjQwOPe2Tz4pe0NC+r0EVfCA+SzehcIstYSslP3CIOXJF3C06Ef7VuX6fI7djc4ySOtskT1sLXC3f4iAiRKvrw2O3O2XVB7Ck5lWh8jhZmmyO9p4SnC4n38U8mEXsI7ip/1K8oSNK/v9V+S4hiELYuq1ZY1tj+PZGQP/Ua0Cgqaj0NweQj5c+j2httrpst2irJyXg2s7F0/2DrgUNiur5xAW3i73yOxpTY0r9Guzcr3/c
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(38100700002)(186003)(2906002)(66556008)(316002)(426003)(2616005)(26005)(86362001)(66946007)(4326008)(8676002)(66476007)(4744005)(9786002)(9746002)(36756003)(1076003)(8936002)(5660300002)(6916009)(478600001)(33656002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SIG+yFlNqZ+Oli/2fLTw4qBtJGXGp83uKwMzgxx3FIl1PSi8zeoJrFo+fMB7?=
 =?us-ascii?Q?fSDZJF5BQrM4tNlq25AgJzVDyHBbrOVC8HLtpL5qfEnxjoG29XdNsNdvqazz?=
 =?us-ascii?Q?OLUHtCkD7agm+/PFN6cgHyHFc3c12zcJ7NP9gQgGyB8Ctmu3lLWX5iZPuWuz?=
 =?us-ascii?Q?cl8ukNyH7TXDdYA2RvWRg9gCDvl84dTpE5QRUGc5YLK/p4oNHjp213KPOiTJ?=
 =?us-ascii?Q?Gf48fco1LeA7r47tqH1Ng26eoqyKegvp4TjYBxpnPTelwUjRlS55Pjtwx6hu?=
 =?us-ascii?Q?5fqYZQENJRzA2cqFIv4ZrcnJv7OWgYmhQYU0GdKC8i9gK0p4PxYULgalgfX2?=
 =?us-ascii?Q?iviSOzqKNOWuaQXqTTrgynkUf6bFaEwWUIvEv1WjZwX2ancps+2KmUxej10C?=
 =?us-ascii?Q?4zRUFtM9e4sXP4qMrAklmJzPqb4DuaCp9Rp6LPH82Ky2LMQDBpWSVuAKsD37?=
 =?us-ascii?Q?dVs9wogHb0rA/6N/Mmn1bFsuOxT8MQ8kHaffA1XIW9cDCs/lq9C4Z0ib5VPz?=
 =?us-ascii?Q?3w3iM35V2oS8MCzKdNlHIsMo/82gbs0HRjFvIWm3E4SuO3jKiUHDGQgNhj3k?=
 =?us-ascii?Q?n8wHtqpZRhwoW4EfTP4OD+wCXsdFOeAQOEALR4iVdoJCWjyp0VGwCNEFrtt2?=
 =?us-ascii?Q?hSTiCIDBQkuCMnic5Aq4knqb558/D80XheOTKsNBrPobI0INQr5t8WmpH6hB?=
 =?us-ascii?Q?OVoRj19zrrRB8vuysZXkD/VVqaCopkBO4qTNPnW/wRMz2GuH5sV87XGn19JC?=
 =?us-ascii?Q?VLNf/cNP85iT77hjUk2Q54CLZ0qEXKt+Xq5JzH8jaBgs0AgwMYwSAjmesZ5m?=
 =?us-ascii?Q?//p3RAUD3PPLr9MiaU3+A6SZX/ROiQLGVJHVq8nZYXgrUZos5IyYzLecq4kL?=
 =?us-ascii?Q?AenR4Z96XH5voso7imD93lQPz8DN3A3v81NHXPisDUPZ7iah240C6GwY7LYU?=
 =?us-ascii?Q?PEuK6I9MAeRLJpZ0xsWMKB9jsIZl7mj+3xdUSnEsGPH0YW+iHIh7zxEzoNLi?=
 =?us-ascii?Q?0YrtsKiYEqczgCnkvu/F5pUlq5IH8/KtXVcRkELqLwQDDhIr/2wsyDK/rvyU?=
 =?us-ascii?Q?mHMwG0mhIOYUByp1VYiy0SQMm2Or7s+yHIVgGcrWuPvpUYQXeKujcAuWHc7Y?=
 =?us-ascii?Q?EZCZOUxNCaePMPBZNbZmjntyx51ry2hXQSGRS5eJZbj+eZFdsFGsbxFsnMTs?=
 =?us-ascii?Q?1vAy+bDgWKyPW/F4c9I2fyATRQlpWMW0xyuuIW05tZp0kjxBZ5xl1uYS/R3J?=
 =?us-ascii?Q?rDC8CjMTd5BTEDRgYz2ATLC0Jk1G42HRomDSHgTX/frXra2lQI7aEk76c2wV?=
 =?us-ascii?Q?C5pmvJ+1Wo63XiD9KCDTYuPT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ca6df4-3c4e-4d5d-e6c9-08d947bd0d2c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 18:19:14.7044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2rKJQk7dSc3ksYngaH96Dfy+Zpl22jBwe60yscNgoHCTbMAvQ8SJd96gGXkGHja
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5047
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 13, 2021 at 11:11:27PM -0400, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Since the functions irdma_sc_repost_aeq_entries, irdma_set_hw_rsrc and
> irdma_setup_virt_qp always return 0, remove the returned value check
> and change the returned type to void.
> 
> Zhu Yanjun (3):
>   RDMA/irdma: change the returned type of irdma_sc_repost_aeq_entries to
>     void
>   RDMA/irdma: change the returned type of irdma_set_hw_rsrc to void
>   RDMA/irdma: change returned type of irdma_setup_virt_qp to void

Applied to for-next, thanks

Jason
