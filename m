Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA87A3F1F1A
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Aug 2021 19:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbhHSR27 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Aug 2021 13:28:59 -0400
Received: from mail-mw2nam12on2086.outbound.protection.outlook.com ([40.107.244.86]:55041
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231561AbhHSR27 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Aug 2021 13:28:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ngw/K82bRT9J2KDYhxHsawcPJbDK3u+BXJBAFs8UnrqiTAAaWo6xgJVi5NfxPaRO6gqzg1zPRiUCZbcqyrF4IFHniJ1clLkqg7AHSu381fKPbcRRMg1ZFNNwDe5dq2rcjjVKM6hz43YORxJRQRASTtMS21BHfbdQQW68M6kcPReK+rr9N2Gz8umqeIuT5y8LrPfLERFA9rkvuxv3jcaIjx8cHmaBWBbtflUGY98aC1fnT6PTuVtT1akstsxPIdS5FYrvI8qrNchLe1ZsCdlUoHdN1DQbR1co57BwsgC29Lby37boI5RGlyDjexAHmHtpvxFmVNmiG2nqBnmktp10xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCZn0DvGZlbcU4XELModb2J4C9OfzoojQYtuCkNcvLI=;
 b=lTFuIOOMET1nCsYvNlKpvzthwy/aoE3beC46g9JOrcLGDqz6Id8tUMhqqVFVt4Mq1ZcPr3Xur0bNRG8hHS90vqJRlHRjcjMHGY2CMEPx61puUXRVowQVzX9kj5T0g6kiOkIzzPBM2//0QqSWrJD7+v7xhEAhnjSu5ZK4LzODTklcGPzI3zJcFr4d6wXIWUlvU0g0FnZUoeLuvZho+jliiQ/fdd8y2NbOpXPdGwjYiBWZ3xTJjBSpqCHVIXX73w3ahpgex/pnzDbs/V1CL5VOSc2t5UquNhNAuBXdf4Bd1gX09BFIEzIxhDjU8X+Ce/+jpoFjBbzlRnPb6huF+wi1yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCZn0DvGZlbcU4XELModb2J4C9OfzoojQYtuCkNcvLI=;
 b=Z8nfGwHZx/h0pCqamOiBAGgofz1yCsAOs36uhXr/xnWITSDHOZvY6bT27G0l+07WzmCcvncb03bs0LKPIy7qelcIjIfFeSvsXyItYKhk/Ovj/6gbprnWbG7S4c4dIcn/r9sC8h71stuUL662iKtUSfP8TigB0uIHkvg9JzUc0LlhYe3hkslOr+evPmu6TM/lxngTA68Ib0sKCXvrt7FAJJ+XZ/jQKdOAqEAF5bNgbpb00lnjkqkBo3xtA+CxCrtfaE35Ca3BTUXTbgmU0vDvdBjRyWvO4qOiTJULnJivuyC0S8uLCNhRvmrgBKyJ7OXPczxtSjuAKRHXc/7IQnMz+w==
Authentication-Results: marvell.com; dkim=none (message not signed)
 header.d=none;marvell.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 17:28:21 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 17:28:21 +0000
Date:   Thu, 19 Aug 2021 14:28:19 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Prabhakar Kushwaha <pkushwaha@marvell.com>
Cc:     linux-rdma@vger.kernel.org, dledford@redhat.com,
        mkalderon@marvell.com, davem@davemloft.net, kuba@kernel.org,
        smalin@marvell.com, aelior@marvell.com, prabhakar.pkin@gmail.com,
        malin1024@gmail.com
Subject: Re: [PATCH for-next] qedr: Move variables reset to
 qedr_set_common_qp_params()
Message-ID: <20210819172819.GA354838@nvidia.com>
References: <20210811051650.14914-1-pkushwaha@marvell.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811051650.14914-1-pkushwaha@marvell.com>
X-ClientProxiedBy: YT3PR01CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::21) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT3PR01CA0041.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:82::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 17:28:21 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mGlpz-001UJs-6A; Thu, 19 Aug 2021 14:28:19 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b38d95aa-a7e6-43db-be3e-08d96336bd9b
X-MS-TrafficTypeDiagnostic: BL0PR12MB5506:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5506C6C043ED6F7BD3484CAFC2C09@BL0PR12MB5506.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6IqwMGLKisw5BRFwfr5FVub6ZC3T5YQC8dbo0vWEIqu8GKqIZMtf/IrD4YBofBMBlcHQENyf8p1TOVTP3XHWds2zBYJUoHMIPCIpkXPxH2MNKSN0nN1cZjp37YxODi5xZ+fNKE8KmeDsqzUagRy7bu/oToPj32Pk/wvOyPFoc7hjR7PBYokPixRWm1YnuG3xPeRxVG39FG9RDPW6PtknhjKr0rsHyPGdTGOAvQ56f9o5rf0DiuacsTdaMMWGU4ifg9hu5WNjsw0kOkXs294MxOBy5wkTowDS7MCpboQHggMu7ONdcEQCOc7t5AQEVhNLwK4138oAqES/Q4NH/dkkqvEkCanJ0bIO/RmLz9/dfQzfQUDEOmwEU7Weqriw7SIxhY9c2VTpkV0koTJR691MwchlpEhDgCsOuMY6wdVBSo8KDKtKAbfSmv2N3qzcCim9kzwhU9FplUv3IJUWZ7CTOqJ34Pcvuxepik+8brN4o8FQ/FMoI9vy0zC41ZW/DBxexYf4Uw5czM58+pPmYI2PUiUSq6vYSyyXwG5c6O86IBJo3kQ9190WHDvhTQNKCQQit0rYhkISqG4zaO1pBtfH5W4YL+cUVZYkYs+Und6Qa+TIuLmskC/dJR4RhP0KuZo4nRaNnp6GCM0SVl3q1d2r1ruYqjwapI926YChVrYyWrK+gFTAEViwA5GryMFjsjk9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(66946007)(9746002)(9786002)(33656002)(2906002)(83380400001)(1076003)(86362001)(38100700002)(6916009)(7416002)(316002)(5660300002)(4744005)(8936002)(508600001)(4326008)(186003)(66556008)(66476007)(426003)(26005)(8676002)(2616005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/giQBfsZ6n3UHTl7giY4cdob4Sh2TLq2iPI3OIam5b9GWRBGGrf71EHUUnx1?=
 =?us-ascii?Q?xGBVNuV1XhzT9DFyGZOg2uYB4cmUfnV1OE/EXD2cBaiBYqiERydqGewzd5f3?=
 =?us-ascii?Q?lfW2l1f0dpKa4e7v8jH9TyGIPWX/tjqkVTxzLbuZ1emG3aU75ZgJroFtckbj?=
 =?us-ascii?Q?M2hRr73wEp5VCmY0bxjGA2bobPATl9BbHKG7HCPQ4ajCRn0TQOftWkheWI0/?=
 =?us-ascii?Q?FdCcwHevpHYa4hO9aBmiEhYNg//2oCIfgWrO38hs7HWj34oHlDfG0yUC7MkD?=
 =?us-ascii?Q?L55eE70t6Yql5gO5zmtjlkb6daMy/QkRHhOwAT1VlC6dflAoJoAcjUyQWhJF?=
 =?us-ascii?Q?ENi9qbwBhAoJZ/YVokN88Ifg+l/+41usBUfjqibK7EpiS75WKzDQ99FOyd4P?=
 =?us-ascii?Q?Ga/ZT8tcgKOD07kjnPGGYV3OMCzbDGGQfyl36R5aCqX9A1ZksApygWemlTj/?=
 =?us-ascii?Q?Xv0Kr/i4qRxGqrsbQuIjlXbd7n2VvtsqbXGWQx/Jwa/jFdXF78yxcGvtamn8?=
 =?us-ascii?Q?Tth+IK9Bvj4wd/1spdqrwM/eieywyz0zeT91VBCmTmrxomJddjgo4eHflOC7?=
 =?us-ascii?Q?knDXt2tsuu3241oCYEVrV+GziBoEDr5H1s/Q9c8Dujqz5G8KFJxO/2IA64jf?=
 =?us-ascii?Q?i5+ZPeV0v3WIUfA0/YfZtCdqQUmao0yEU5Gp50N5YI7LVOqNGTGo7taBCv2I?=
 =?us-ascii?Q?92Y1h5xzY8/L7d6QiBzg3e2z470TUx32Eu7GL/KrUhmDT9RW+5YDVlbgZNfZ?=
 =?us-ascii?Q?wfPrac4uwGlGSNVKjVPtRkgcl/dKKE0TRUmUBqUgdlAMIL1vDnFY0XtL1Ctu?=
 =?us-ascii?Q?4bOiL86JqHOW1K9UnGbl77ngtCqjcZO3mGNMEI8muvunVdEcmiL23le3neu0?=
 =?us-ascii?Q?BtI2OeCXvhxqb+RyX86EqF7vwpbfktVsMOTVpfcPzIw3WqaGYWprcj0zCRlA?=
 =?us-ascii?Q?8VxyMei5ZBOte5tkoG/XJ4aUfKxH53PrjJntC29iuz71E/rrMLu8tWLkBjuS?=
 =?us-ascii?Q?HFS28qcLEakl/iOMMSGEKJUT5TpcsbW00g/EbyG3zEjvd0g4mhlGBPcailO5?=
 =?us-ascii?Q?qVEbYP/OS0mGbJhmLiBzHRrNCFYLSwYftAwJA5nSAzGjwEjgF9DRzwCZzRr5?=
 =?us-ascii?Q?4LbFa5twflnWGHpax1ClH/QmkhMKE93rAoMcC5oMRM7IE6jEpUViekz7Lrc9?=
 =?us-ascii?Q?eNABUhm8OY6ysMCRTPQxtp284QX1WCjYuDjtYlmB5s0iBzwanNJX8bsccsuU?=
 =?us-ascii?Q?rl/Fw9PuuOBv0EIwJxJJ5l4dfRWF1Eevi6x1xIPzO5gLU0OZpbqIzufi+e3U?=
 =?us-ascii?Q?cCd5+KdvrPotzWIMHOhFt2K6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b38d95aa-a7e6-43db-be3e-08d96336bd9b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 17:28:21.2091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxQW2iC1S64he+uj1xQyQevwlpH1ljofFeWMgvh1cZVgLe3h2ohhwGT6LMmln6lN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5506
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 11, 2021 at 08:16:50AM +0300, Prabhakar Kushwaha wrote:
> Qedr code is tightly coupled with existing both INIT transitions.
> Here, during first INIT transition all variables are reset and
> the RESET state is checked in post_recv() before any posting.
> 
> Commit dc70f7c3ed34 ("RDMA/cma: Remove unnecessary INIT->INIT
> transition") exposed this bug.
> 
> So moving variables reset to qedr_set_common_qp_params() and also
> avoid RESET state check for post_recv().
> 
> Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
> Signed-off-by: Ariel Elior <aelior@marvell.com>
> Signed-off-by: Shai Malin <smalin@marvell.com>
> Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
> ---
>  drivers/infiniband/hw/qedr/verbs.c | 32 +++++++++++++-----------------
>  1 file changed, 14 insertions(+), 18 deletions(-)

Applied to for-next, thanks

Jason
