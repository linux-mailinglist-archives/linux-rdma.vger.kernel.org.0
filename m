Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E856B3F1B9B
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Aug 2021 16:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240329AbhHSObP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Aug 2021 10:31:15 -0400
Received: from mail-dm6nam12on2088.outbound.protection.outlook.com ([40.107.243.88]:20167
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238613AbhHSObO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Aug 2021 10:31:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVJleMPf5ukxaI/VB2ucqM7+ung5yhFvhq9QIQSJTeLDsUHFBOmS2P1U81vlQCEUsVU5wl8bNzKRevyBABLmfBug/eEDlracOxyVysSMjQkxCM7S4wbz/dk0dXKw5WSeDPSUq56BGqjurCBCWkyr09OY8yX7HWVyy2M/UbS6p75mUkE6w5TXEBV3gB9+M/38X2NT7jvaP2A/T1rFQLF2u/z285fjEz3cgdYcxY7SliQoj38PJXQlRUFu0cLxDPHN9AVitNV4NzKye7J3aTlT2k1yLYJ2QqlipOvxGGBZBiFIwLLfsjmlXZH1HO2pPV+Ti2PgTb9yT+Lgkl1pzLej+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AERIsdQ+OSsr1Lm5JwD+TTkU2mN9WsvlDtQ8pPgN9Ms=;
 b=fI/lTw3/6uuTQdEXLlsAZ+tKNeiSPQhKDm++bTfIQWZRb47o7YCgwmfUanKnui9XrQlKRKny0yVziG+HWOBQOCNDVbz2CP/NYspwxe1kCutqySStabAM51jtpvd8Bd+qWJFWWBjMUclsQc9e0PpXdSYH8VG86hwsugS1kL0IhD6do5/Wh3zzV88Ff8XFyWYN1Q2ZbQSz7f+2EiCGmgoXlzd7i+yA5J5rl89KHXDv6zFqTjXpC3bNzi/3hWev38hOTq3UZO7Q3xNsV0S+55+e0YBQfhzPPTLn79MaxxlXawB99F2olRSipjDR+wzG7bwk602uPt4veCrKZKqlLJLn6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AERIsdQ+OSsr1Lm5JwD+TTkU2mN9WsvlDtQ8pPgN9Ms=;
 b=o4qNeW1VXM4oJ/QBwjK6R4Lk1IyclqBhLIgNTXp7/cklbtDqx3XCxLpQm7hCH+fRjFqc03booJTC98wSo9bjcLFMN4Z84Nj9i/gozYjVS8Oru2zo3nsrUw+ng06qO6oZvVs38GoeEX2SYoSH6sF3ZLaogHSSF+zMnly7zYXW2xvVrQnnrwZ031DZG9bOmlAmwQ38n1ob51qCqKEqX7y9oMCovwi42ZdpuJdJ05GrWmiVZv4dQDFBBvyd0rBEZF88OCLXcNSQDdM0FDY0yG1G19d3rbzgnGUSjOW00tcVz+aOZvKn6911MHreYwF9ZlqpotAt853+UoP6f7HWHbdr/A==
Authentication-Results: wanadoo.fr; dkim=none (message not signed)
 header.d=none;wanadoo.fr; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 14:30:37 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 14:30:37 +0000
Date:   Thu, 19 Aug 2021 11:30:34 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/rtrs: Remove a useless kfree
Message-ID: <20210819143034.GA297151@nvidia.com>
References: <9a57c9f837fa2c6f0070578a1bc4840688f62962.1628185335.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a57c9f837fa2c6f0070578a1bc4840688f62962.1628185335.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: BY5PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:a03:180::19) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by BY5PR13CA0006.namprd13.prod.outlook.com (2603:10b6:a03:180::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.6 via Frontend Transport; Thu, 19 Aug 2021 14:30:36 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mGj3y-001FJR-69; Thu, 19 Aug 2021 11:30:34 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce7e21f0-edc0-4827-3576-08d9631de959
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51124B9CBF73EB89E78EB847C2C09@BL1PR12MB5112.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7DPnYQ/ecbZViL7WhmpMeROSG6JaYvZreHc4VhlcD8HUUnxm6JGCKGwTme+qdHeleUPnRd0NiBEXDwb/LvBlwIp1fOCR9CSaDlTV4Evz//2EXz/2iedKQXvB16cDJEpETwLbt2IXYDyho2eskB/ZX8oselp2wOER2jHeKKwze2e+CzOYJ7y34XcjGqRMrVRy46qdNDpTgaN5yIhdX8qREJx/H8ou5h/ezDl+FNZFstGutRbKtxSb94JHjBMcw59QVxL9L2oFpbPg/TOPTK9DAfJeORJcyr9swPS4Ho2211cucLCYMswIk9E7KIoz9HnZIVKhuV1vk5xdiI5HW68bh5q+QeQEfEr+u/TDEtZrSdKq46tU37/Wa0KPc4T9/zcSzwSDr2pV57C5BVWXjInpFICZWpGid2wvPx4C3G83mDOF/p5BBrDww1e9B3D2b2BA/8EPpT0xv1Y6F22J7SmZTj28hH35tQhwm++BOxdiSqz5IXIzBcQ/DOwcnhPabTXm99GZDbZnxwKgGdNikQwKU6/hJARHavom+Ts82nbIjncDug7DlixNvkEuV5prO4kzlsnS+dRLJRIuJlmiDcAjAor3zhAm8zqkmp6mOcCXwX/ZTOuc0WN4QvC2gMwkc67dZz4HYlBZprNuvzQ6OGmzJAX//8ayxSu3MNVA9Yb0mRRsVWMSrhOSNV9ukgRL8Q59AZWEVMSd5uqZRz09eKaOlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(8936002)(9786002)(6916009)(9746002)(5660300002)(426003)(508600001)(36756003)(186003)(86362001)(66556008)(33656002)(4326008)(1076003)(66476007)(4744005)(38100700002)(8676002)(2616005)(66946007)(83380400001)(2906002)(26005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O5+bodcz4qModhPF6ykLFCma7qcCxvfQRnsOsOwFebiRanJ5sFHctHAFyxtl?=
 =?us-ascii?Q?Z0kgWpYVeAvluzBCwDOFUjdg+CrmStRV5lGbetXGMl04ME3yJW2K1G5Kvxis?=
 =?us-ascii?Q?nvYdMdrsHctSebwpZovVhnHbyeaZuY8AobYLMCz1CPiQ5MYlBt7hcF//97k4?=
 =?us-ascii?Q?aSVK3mgrlOq0cZyOTp1s3oUpaapURJv22HTcZOn5dVdhI9ZzYHvxv+lx2Kuh?=
 =?us-ascii?Q?XXC61x555nVb5WJuB+qsR9cvd5WKg8dGbShE0V52Bd28hkdvsrRcN69tfSN5?=
 =?us-ascii?Q?AtX9a51IIzdg1hwIIAeFRs5CspyqzdGmnkVEOuBr5xPlaB26t/mFZ5W1PWpT?=
 =?us-ascii?Q?eL2di436c6hi5CbBEsl374SoIl9X4eJuLYxj5b1fqvZsst/I2uFqU8s9600J?=
 =?us-ascii?Q?c2RNWHe24jPAGnK+NfUglTqTuEPhnySZXWmhOYELN+vFx7HGV2P1cPjbNDkP?=
 =?us-ascii?Q?hpjhPEAsKi1B+GfvmQpgv/Yf3VhMZun0769ymaqRNvr0nhhksuiX3TXM4JTl?=
 =?us-ascii?Q?jbWtgPGiyO0wV/b6vEJ6axBjR05qO7LtIKZ8Rc7b4VLZa2D9dC3Glk2mtJF0?=
 =?us-ascii?Q?gE/gZzXB4CDm2wOvZC7fdLxNQqScMI9oLNj2E1WHtWChvwZetmrpJoqhWWpT?=
 =?us-ascii?Q?pEPOm2rhovy7iJRz50kPRtq2+MTsR6L2qGDXHu/wNSnOlABk5QnUIfyXIuRe?=
 =?us-ascii?Q?cTaDfbuphulSfHWGvb4RnlyeFR7MfStAAa92qy1omVn0TcKKwV4DUjMv/BI/?=
 =?us-ascii?Q?IGF7SO7SCWjiSolwdbBrqvExP8Hj5gRqFaVZ+dnJzxIHZywgKEwN3DUcd9AM?=
 =?us-ascii?Q?eO5iVx0eilI4Jga1sS3I3HSWaJaJYvK/JDZHtd+PnpAbgnAX8ft/XrPRT/Te?=
 =?us-ascii?Q?FJJYEKO/nMf9SiMv66yrb2MFR+nICZhGOnfn9xYnBmBB5j5JRbUA+lW1sUPD?=
 =?us-ascii?Q?hZ6BblLtQPCOz8eZaCj84R7EfnrhawwwCb1g2U+ih+1E4NjZAy0Cr8W87z9E?=
 =?us-ascii?Q?5cY0YNiGzpOGriPbGWU+p+ecM6OBMrBh9DGBpQQDgVW5Y7YGI5D92YGYba01?=
 =?us-ascii?Q?KKOYtDPRMxpYOTb7SkqHm1tX0IIdgSRFCXPEW2qs2V9tlVxxeLLX3ci2lhkg?=
 =?us-ascii?Q?V2JItCYpTTbC4CnimcCsYSLGMXrBJyaAOtnM6gFOJoT0DY7jmt1uqpnqvNSO?=
 =?us-ascii?Q?ZI9r6I5Nl0duQ03nNk2WDFkK341U5bLbJ+ZbVYO+oqgJF0Mob+3i42Noz+hO?=
 =?us-ascii?Q?MNQzJ7Ulp2U1fC7dqRUqeeBWXveLLYUDZvodK7oAbjlChRmuCYOMnBjDLmhM?=
 =?us-ascii?Q?JmFXdSJSytnnNYhYTjqcqvCX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7e21f0-edc0-4827-3576-08d9631de959
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 14:30:37.2194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c3+0ps6UmIWI38V3QH7YNs0/CB/acd1BdnSSWlyqdDSifgpk/sHEAL5KPhTlrDbG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5112
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 05, 2021 at 07:43:36PM +0200, Christophe JAILLET wrote:
> 'sess->rbufs' is known to be NULL here, so there is no point in kfree'ing
> it. It is just a no-op.
> 
> Remove the useless kfree.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Acked-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 1 -
>  1 file changed, 1 deletion(-)

Applied to for-next with a Fixes line, thanks

Jason
