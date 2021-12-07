Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5082D46C200
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Dec 2021 18:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240137AbhLGRq6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Dec 2021 12:46:58 -0500
Received: from mail-dm6nam10on2085.outbound.protection.outlook.com ([40.107.93.85]:59360
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234634AbhLGRqv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 Dec 2021 12:46:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0TL54aEAzUDr5ub+34cwMF0HOkPK5vzQwb/aTojKqORZc9OomRIZ4JH2Ubtf05uP2wHW96nlJ32idMuuanWEdmDI3qgu6ZE0pGAr+5LIKEffhtdoU+KRdYUfKjpcfKeyxv3JAaxLAPU3OyGKP3Ye2mEZOPA2sBKnutrqk0BDMAiWIeHyYUOpIlmoV+a4ZeZO0VWdmxttQBmIAjHv15yCDiAkdC29oW1D7hUDHHQ/RKLPhOmTHpH80rWgMuehBvCTKxcZ9j7F0Su71nydGwvpXgTo6sefMk/5U/y4euwW6bw4GnYES/9j0DR73KKfq+/dYZe9XVo05GIgJlsaT90gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qp2beV4Qqmk8k0tp7V3XimU/LYMUkm4Na+RzzV8K3dM=;
 b=hxCPjejoSJXgZwY6BpvcGDHEbM+CtZy+BKiIb+k3PUk/T+s5Henaz0iqN8prq1jc3dgVqm4JMe8z+FRR65pwcHISb+YfqSJPfUgMwlDUk9KqGOSM9aKPMlgUb1BpHb11cmIXWkbFXVrfk0OnefXGs0dBLVrVLsz39h68dpZtYIC2kunjEM8zQawcis+RMz6NmdcOkR7fe5q+f5hdLRwrpV93QfFTQmJ6w8jrN3HpGbTptLCSMPJwTPbxz6ZxYtpTmo/qkPart+Ykuoz3HItkppz5cwH+azzb4hQoVarwuRqZkORAnA2PFF1/N6Z7ZD1NsobHyOb7748uMoqhf+/92Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qp2beV4Qqmk8k0tp7V3XimU/LYMUkm4Na+RzzV8K3dM=;
 b=HE5yOY02N6R2qbbe7Ub/obSYEIFrYsH29oWnTKV81Y9imCOgPbWKF9qsKhtQLg1tMXt60Ff6ioGuuL4EOqGNuT0IQxWTn6sS6IToCUCQTQyxeJqWVUug5PhXwjKbEir0rl1lOKLZTDeasczkED/iRNBf0+ppqGnnw1wqL4azqmG7ogpNHxhtwG/hXeomIPoiBK1Uo5rmbJGSqXxBwhzQqAz3iz5Cz7WBtCb0kEB2YapzRNA1vgPeo8rvNLzStKMX1UKOm6QEdhRs9NGftMQ+aEP0a75gf0t32VIJqYd6AufjUSfpX+WfbswXqb7W9bmUodts+PfbHLQW0ix1cJQOCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5160.namprd12.prod.outlook.com (2603:10b6:208:311::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19; Tue, 7 Dec
 2021 17:43:19 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%5]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 17:43:19 +0000
Date:   Tue, 7 Dec 2021 13:43:18 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc 0/4] Some more RC fixes for 5.16
Message-ID: <20211207174318.GA58584@nvidia.com>
References: <20211129191510.101968.6259.stgit@awfm-01.cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129191510.101968.6259.stgit@awfm-01.cornelisnetworks.com>
X-ClientProxiedBy: BL0PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:208:2d::23) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR03CA0010.namprd03.prod.outlook.com (2603:10b6:208:2d::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend Transport; Tue, 7 Dec 2021 17:43:19 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mueUo-000FFY-5s; Tue, 07 Dec 2021 13:43:18 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e70940f-1f37-41e7-046c-08d9b9a90e58
X-MS-TrafficTypeDiagnostic: BL1PR12MB5160:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB516092D4E72EAA20C0B0BA91C26E9@BL1PR12MB5160.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4PKECZdABLpMqbUlAgvJj84se+R2QUcCQUXHgmUffnSfTJKqnfznxWjVU956y7IZuoAruFHsj+65R0L6gZnubGUw9VMJmXLBfmol6RccTT898TGXhaiA5oWYe3vDlW1INpJOt9kLvkuBJGF4XOHIt1y7OpiN4Ld/FYNIGoWh+ydkWMHCx9qVs8e026WxrdYc3lp9nHACTO6x7k5q2jI0iIVopklZJh3m+TdMQwW5qELS9PtCYg1agsqccYeCVbPQnkVNWk8th8U07GEyK4GS7JD4fpNUao5EjHNIFc6roIrj59EL90QzeEa4Cx1bgyoxI+NLgm562ioqnUox4KtWq6p4o8a/IYERoK+UdtZ7WbNzjbmDXgdG8iCK4cKHbH+o80z8N3UMioQxyLfTJZdLL29rmoSsa3Gj4Q4etNMpdSV+HWdNbtSzq/V2MVcRvjWkW/m441fxpu9pYn/qaasRHbssYG0W2pfDwaAk7N4LcovPP8JvmJ8dKj+C9+QdkgbWD7Sb8v2Y+DQEJxRt6vBsV8pWYvo6Kw5ttef/zlsNW3QLeQenI+ahabKAeXWHOcfxRcd/0Ht2SVENr6A6U9GMLD/4Kl4CtJN/bs2sDEUj+GGnM0CgM/gWkzt1hytlAI52jQioI2rXTHoDOD5I8+AgLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(186003)(5660300002)(8676002)(4326008)(8936002)(33656002)(9746002)(9786002)(26005)(426003)(508600001)(38100700002)(6916009)(86362001)(2906002)(83380400001)(316002)(36756003)(4744005)(1076003)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UbC1TckDXAY38U8CjVfNx5rwvnO15doe5gxVq5gQ4lrSMPV/119qzbo8ZPCp?=
 =?us-ascii?Q?xucKTBdHHh+QBeknR8ZjT0Nx6AQ26felQQ514jmtcHWFvNCoYrCJpubCbYYv?=
 =?us-ascii?Q?BRYNbPGF1yETVWwWmZ04IQb0Wbe8LkZuEOElUYpKjsl3b0vlWEKtGm5OQ+jR?=
 =?us-ascii?Q?jBepsS+LGc0AXuAehsMCZSMCYiZLGX56SllMcVJdLBGWA/LKtWzrGWWd9Y4+?=
 =?us-ascii?Q?I03VuzSG2xmcL876UHDs4x28BUKPe08xR48enr6wEWV3krSeMlbK/FY+QR+H?=
 =?us-ascii?Q?wjvcO9LJznpp6WVsqXZlhdLRHLgPPtajwRRrVbFvrGg4jPL1gzWTQPef9Vuf?=
 =?us-ascii?Q?NHQkxJCrXiMNon1+nmE/F4NuB3jWlpdDvTeWvoVOA3kKBCeIP8SC39vBEcHz?=
 =?us-ascii?Q?dq2BmXfzUkayA4rAs0H8Zih0ldM/G7fm7JrqDy0TKxm0i5tb7hJbrQzmDMVD?=
 =?us-ascii?Q?Jv3EumIi26vbNxryEdgaZ8JIExbLQyVXPuat5L23tTNilzZIyEZK0cWnfZLQ?=
 =?us-ascii?Q?tJMsxf1yJTrjA+ahnesSeb8+GaXyqzSk3QC6AeXS+hN9iq10/nu/PO3uH2+v?=
 =?us-ascii?Q?mdh0L1ZqvQ/cLRGHzdq8HEnbZ9YC1t6jGiHkBA3Q1plZKEruytQNa7ufaFat?=
 =?us-ascii?Q?rCzv2NbLMQOUElZMuo/T/s2lmEDCvg10xN4KUUqPgO8ygp5JM1PS7LXPQAGa?=
 =?us-ascii?Q?/nMGz2JLVV6IEYQuUXdqNz81FLAHMves7X8Xo9m3uA5JgvtP6LOHYDEwgu91?=
 =?us-ascii?Q?sVubKTfOy5/q35JrF9+ne5bNfRMBkHWa4ZHAN6Dwo4WoWVF3fLTn6CnRyfka?=
 =?us-ascii?Q?TRfEX8XVVvM6TeziIO7NxNdig0r7poSjI2pv2r0v+6arEvSjxYlawo/eo4rq?=
 =?us-ascii?Q?stm+/+h7NDG0bZNKYgBPJnltGac0UiSGkss8JCTJ7H7tsTJn6vufv2jFuxlT?=
 =?us-ascii?Q?t6rtHzmWhvBdKU8TtcYq+kaukjGBxoDns+wUTPljhPAC0+b15SP85fSdPC4g?=
 =?us-ascii?Q?Sy9em/lDpgSZnanO5mKaKnT+dfn4XHaHp3ojgDAX4HpnDp/ne/uDeoF5w+i7?=
 =?us-ascii?Q?oOK1yStQA3JOuvZbXvKQq3EsQCkf/jNVGmmji41HBB43aeNwuYgNTiGUaP+j?=
 =?us-ascii?Q?n+vnzGVQ0O2PseLSp/hzeg2lmF7SX1hvmGLoNKgjgn8gGTKEk68Hfg2S2S9x?=
 =?us-ascii?Q?iFUQyFe1FbQJyk3xoaxYgxaqHddM6tdxxNbtWjfm2Iv0Zg7MLymk97T4EkGQ?=
 =?us-ascii?Q?s+A7qeoW9wVo0OffX6qwf4BPn2llWRQVsm8MhfM3Y0g1q1h9ifwO/qvLw8s+?=
 =?us-ascii?Q?CMxDyMySw792ObW70+g4lbIeOO06TgrFj/sLV5tBrYR6oauqxxjo7deyyWbI?=
 =?us-ascii?Q?OobL18f/3bn5dkCFJrGBwOL6EbGsTfHQukxOOZrF2Jy4/NqlIWTcnGLev4sx?=
 =?us-ascii?Q?Ug8Y6lBoYJleq1bPH0eGCaVdZG2WLER6JELmsgwwg+uwY00kkIDWI2B/5YcP?=
 =?us-ascii?Q?ntWyiqZs3bUK/qz2NVj7+kxZjGN/cFUAqZD+j8kGeyGLWBuI8QooH2WFHarL?=
 =?us-ascii?Q?CNkmfhBAjz+YdoPu9bA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e70940f-1f37-41e7-046c-08d9b9a90e58
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 17:43:19.2302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 80q+qjQnVjSZFaoaQafLMv/HBpjIvJInCZd6JUA+ncLz6u2wfz+Z/yewpjLueuxB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5160
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 29, 2021 at 02:19:47PM -0500, Dennis Dalessandro wrote:
> Here's a few more fixes from Mike. Two of the issues were found through code
> inspection while working on the panics. The BUG is a long standing issue but
> just now surfaces in 5.16. He has marked 3 of the 4 as stable so we'd like to
> get into the RC if possible.
> 
> ---
> 
> Mike Marciniszyn (4):
>       IB/hfi1: Correct guard on eager buffer deallocation
>       IB/hfi1: Insure use of smp_processor_id() is preempt disabled
>       IB/hfi1: Fix early init panic
>       IB/hfi1: Fix leak of rcvhdrtail_dummy_kvaddr

Applied to for-rc, thanks

Jason
