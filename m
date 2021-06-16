Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1BA3AA763
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jun 2021 01:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbhFPXXa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Jun 2021 19:23:30 -0400
Received: from mail-co1nam11on2070.outbound.protection.outlook.com ([40.107.220.70]:56160
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234533AbhFPXX3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Jun 2021 19:23:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRPsBixB+adgrrjkWY/SaBDqoIDMOEL7PXA2d9gHlI5St/BAUWhn+JwcwOlhrCr5d5XK8A/Pp+4QuRZAJX28VBEqv+26T/rEaNcg0iewiSoM29EJclB3y9DygAo0ojchRR6uwXTuwM5TycTgs0KgI9NxjKWoXDV1Ey/ufyWwvgDB7TUjWJRsEUXyX15iVHcKn7RshYDLkt1yxX6NHLI+KOfz4478qerzlfMZFS1ulYkiwg4SHh06U0HnHIJe4pv1y3oryTkXNRggbBtelcR+AabYTQuLipkepdOWohWTFjfiDmOO1bonTTmDlKeZvCOptsxeJxuqkF17RY/v6uncKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEH7vrukvdw2EGp4HZxrdOB79WcAZ4wYr35S7S7tpnQ=;
 b=ZCe+U0IbcVu+Jnf/jGdkZd6PPwoCLdvkbsM3ulCIArxDssxKmy2UCafrkmQIUqUWcXAraCSjhJ7PinKqITR7D3lwsbQYTYlc6joVv56QEyMSygIPt1LKFMuGlVbnvZOVM8abfAHaTTIYGY+UyjF0T6QDNLcPP05WDOUbr4irmXFrzJneV+UtdRYU5nOxEWzMRtTMKZY1p28TYhnbfnmKfei7ws6kHJIl5c2h1crfxcflzIMsKx09f9MGy3RJ+iMb3fC7TNIujEevBN1hh/GfOjkCxZDfGeD6wcsg4R0hiLVi5UbHZ0GKD/LlJt+rwFFrJkLmEQYJSumzpr3szJJSaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEH7vrukvdw2EGp4HZxrdOB79WcAZ4wYr35S7S7tpnQ=;
 b=mw+jM1TrQZSKw2GqSLLPjK35n70M1k+2dX4xJevgCnIVwtyK8tYLtGjICsAqXfw/vwLWQ9WtMAg4dOB84lf0WfcfmDBei9dBicLqGqNetrf5zVyLFYYqyo32s8qpwFyYxXbsgd+5M3yDjfb/O2xAb2CzzC0Boo5nWsxV9DQ7WUgWDyLpmw/edAkNOMFzsxDmhZvQGcMizkGbzC2YbqWMxVolTQ6+RMKTWRh9YCCiwXII4qfUyiIIDyZucme1rGflobJWkjswbOiZE7SRVDqOIJma3OT16wug93NV4Q4/m4QCoLZkqBHQs8nbSRDFbYwyagU6f3xegdeCcCnTQS5S8A==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5062.namprd12.prod.outlook.com (2603:10b6:208:313::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Wed, 16 Jun
 2021 23:21:21 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.019; Wed, 16 Jun 2021
 23:21:21 +0000
Date:   Wed, 16 Jun 2021 20:21:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/rxe: Fix qp reference counting for atomic
 ops
Message-ID: <20210616232120.GA1888697@nvidia.com>
References: <20210604230558.4812-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604230558.4812-1-rpearsonhpe@gmail.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0266.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::31) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0266.namprd13.prod.outlook.com (2603:10b6:208:2ba::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9 via Frontend Transport; Wed, 16 Jun 2021 23:21:21 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lteqW-007vLU-FT; Wed, 16 Jun 2021 20:21:20 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80105df1-2719-4b34-90c5-08d9311d738a
X-MS-TrafficTypeDiagnostic: BL1PR12MB5062:
X-Microsoft-Antispam-PRVS: <BL1PR12MB50623AB51659BF43B783C635C20F9@BL1PR12MB5062.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hiAgdaPwjghmalte1u+QalhA/6LP0kPVQ5X7MhJhT0nitJsIKOVWFq4k3+a8iwNFs7mzCL1kG3Cevtoq9rzJ+tyh1A68E58a746xjSedjq2T0adR27MNhwb42tuulrkTRqqSXbjvYpS0P5HlTfgEdM9ArIOxqzLvmxHssRKW80hDHYkciiIJgQoQ2bWdF2aBMGf9aKhVzhmBhAsVizyh+6L5PZ6JRDbEmmxuLCmBEetPMlin6AKo7bRySuOGoJz1haOgbF6uc0ZuxVWlOVqfoAcWh46f774/Iuhgc89rEacJgiZ7gvlomi6FzGbnM/9s/m99YONBkf695m6mWnmJ++Zsl0cI8Nf+f0CtjSgSgYqdfe6aoppPzcoFJDI8Nvk21R8P/pkM/bJGDnfSsNF3GhPDpek9/Rzezcyv7rf4nT+kDwK3vJe3dWPc4TTsxtCBn4R5KWOOU5mDBojFtgvBHKWrkxxZokfE176CjCO6qa4ZAaq46J1Ncrk01tEdrI/DpOcIjLiWXYgiq8w8ra1OD5tZAZYGGPFR8FySi0miYickaMZZ/jHqxs6/KMYeu49Syxk3gJ3c7uuBEdp2QEhNguZzOdIDaR3H04YydzQT7gA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(66556008)(66476007)(38100700002)(86362001)(426003)(66946007)(186003)(8676002)(83380400001)(33656002)(4326008)(316002)(6916009)(2616005)(5660300002)(8936002)(9746002)(26005)(9786002)(36756003)(478600001)(1076003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K2tbntL3SNTJzNM7wROfGA2SWQhqL0wU2TAARc3VyJth+iZwTwuTjjI7c3aU?=
 =?us-ascii?Q?dN0w3SskrZjFwpSou+qxuPvyW9MiVAk4h6RSmJnHRWAFwX7FOTi0y5cVbIDW?=
 =?us-ascii?Q?LG7n1tB6YA/viPHWZTxTy1iwziYe4PUOS16TDGQ5r4vMBKMG/pll9LvGkbA7?=
 =?us-ascii?Q?QKszXZB2I82oiktIbNghYqxBIcILq1GD8UgGsG/NBmAd456Mjc7r+54lCTBF?=
 =?us-ascii?Q?nNMUkv4eDGyM66cAl61MIajyR1GEQfTCScY+DnZEF4esLVb9PQ8buop8yedG?=
 =?us-ascii?Q?Cn5rB6SaS6c5U8ZisMwoHl+NPQXzXpjyW12R7/iGbubpXgm8XrZ7ml+cLpmZ?=
 =?us-ascii?Q?nPKenpxhBUvJfRTobKtfqKkRvxDXzHK4jDcgn1eTtDHjPpaXAJnG6+x2Jdrz?=
 =?us-ascii?Q?p7TtXZyza+tkkA3HU8xTOoMGH3sI3WnWqm/aKrGyFs2e6AiAuVhA5O+7GIid?=
 =?us-ascii?Q?V7fTDXSprTJFb98C9aXVe6VWa0pIo4Bp1WqOi18pB5jXy7KmZqHcK1eN3dnn?=
 =?us-ascii?Q?cEl20Cmw3/XFPupTsw2agrejnDfPhmCSbIjw7VrYX4WZTdVmMFqLZulu564O?=
 =?us-ascii?Q?iFQX7iBTP+pQyK2vHKF1aqUJZElJYmJJcD904wvstP38x5VFQVDuRILGFVsu?=
 =?us-ascii?Q?FOF6VOfV7v9qSUfXOyswnQt3I4cPuRGoirdWTtBAyh4BLTyGRE5vmwZBmzOi?=
 =?us-ascii?Q?wjeSCHtkVkMuWLV38bwLsnZtIe9eSbTiwm76+SYccid30vpv41/6WWkrr0oO?=
 =?us-ascii?Q?jnOXwiim4XpDSpXl01Sd6n/XNrmYGicw9zKV1kzWKUWIzYefc1UEyZVx60VT?=
 =?us-ascii?Q?fu/22Q+8DJCJUHN63TJEMKkAzjfADGus+uVdDaHv7IOqhtgHJ3l5VjkMlyBM?=
 =?us-ascii?Q?rgnUUJURPXjqN+cXXzpKR7i6LhogYm4UD3tTArWaQ8tL0cXD0Q8h/BUHxXSz?=
 =?us-ascii?Q?v0ZG7fmDLFLfhmT5UQoyT3YIKXiKMj4/eaasoRTzsa152Qz6yXaxbldItflv?=
 =?us-ascii?Q?YB8kgEhTTRiCtM0x37L8PuwnPi08JGy2nB1IWMRiwIOg3K2Jkn4Y1rM/AxrW?=
 =?us-ascii?Q?nVrRnOT+Lgr0NRG0PdxWYf+cDy3qRXyrr1ib7/O/89O5JBCAoTixqF9SB1S+?=
 =?us-ascii?Q?o55wzwko/1rYHcgtyFISovtdCTbhgShRGWpexSoSdw0QA3pS53JRy0hgX/Vj?=
 =?us-ascii?Q?ex8pNOf4G62SvS3zJus5WzFU4ml/58obJtYaxF2nqtKTXDFIMw38ZEGyg3lr?=
 =?us-ascii?Q?QVAx/5KeRrzjeLIuPG+PAarO2tscsZOPYUHXERf67ifXNVdTCh6UAOgkgI2G?=
 =?us-ascii?Q?ulGBZE6h3qs/vEjjHKF2xPkP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80105df1-2719-4b34-90c5-08d9311d738a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 23:21:21.4478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5KEbuA0lUHfrdLlLJx2DXyCpkIRpayPdyOijDR4eUZsZeMglepSdpFjxqW7CnJI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5062
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 04, 2021 at 06:05:59PM -0500, Bob Pearson wrote:
> Currently the rdma_rxe driver attempts to protect atomic responder
> resources by taking a reference to the qp which is only freed when the
> resource is recycled for a new read or atomic operation. This means that
> in normal circumstances there is almost always an extra qp reference
> once an atomic operation has been executed which prevents cleaning up
> the qp and associated pd and cqs when the qp is destroyed.
> 
> This patch removes the call to rxe_add_ref() in send_atomic_ack() and the
> call to rxe_drop_ref() in free_rd_atomic_resource(). If the qp is
> destroyed while a peer is retrying an atomic op it will cause the
> operation to fail which is acceptable.
> 
> Reported-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> Fixes: 86af61764151 ("IB/rxe: remove unnecessary skb_clone")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_qp.c   | 1 -
>  drivers/infiniband/sw/rxe/rxe_resp.c | 2 --
>  2 files changed, 3 deletions(-)

Applied to for-next, thanks

Jason
