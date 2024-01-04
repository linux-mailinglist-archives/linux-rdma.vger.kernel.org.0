Return-Path: <linux-rdma+bounces-541-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A91EC8249E5
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jan 2024 21:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 528081C23F8A
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jan 2024 20:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D63528E13;
	Thu,  4 Jan 2024 20:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EDN+RBGP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2089.outbound.protection.outlook.com [40.107.95.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E83B2C197
	for <linux-rdma@vger.kernel.org>; Thu,  4 Jan 2024 20:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8xCyFZkExlv5+Gls2feTTnGVXEF9wJiKJ8zPAJJkQ5dFnjTGEFpagj2GH+jgKwyDCys5Lp8awayUsBgk5pQjwyDJUSSWHzz4XgfA8dRrxkfr/OWj3vtUCqDShSrn9tY7Jhv+Kzo59QPAbx5j9cN4c8mSmvY0SI+25EBgLuIsJw2/eGIG9Dk2RBFPKu1EE5YspVGfpoEl0beJfIqnZCny9eVjpmalNlHMeSyfQAbmBBcrw5tequjvzzi/FzHemng/kJAQ3+p+120pyQUbNSq3gl5n2ClL5zhE0E4IwaSmQ09LxTk3Erl90kkNn4wMgOciY+wHUMMysPf7Z5zqYSzuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYXDNr6mhEcrWKXF3L0gFNdI4fXNq/130EODaUfjSHw=;
 b=gTU/YUYWYl8DHMuVZE81M0BXxpicv/PDiOHYxk0L2zQdEFtG/s1uu19kYxpaIACzck2UvB6fs0RQ8pQhjbB4jzFvzU1SOMGYoR8QcG0FcbJh19jYWWk6AXIBJakdREluhe8LC/8cmGmt+lXmDNymiI4ln6Gj4xGOeji6trc5UDhI7ucyXIHrM6soteZM9SemBOoWr8JEZN5+fjA3EQ329q3TlA5zpn0YFiJ+uVCgl9owYGZY9xyATaI4WWRvKg3RS+vTgQ8gCq9L5zZJU6Q0ln9fCajzKJlEvQ7pnTsl1qA4JZASbSNsDlYvf4iqJowkC8OPoFznfIfyG8pBL2OIbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYXDNr6mhEcrWKXF3L0gFNdI4fXNq/130EODaUfjSHw=;
 b=EDN+RBGPa5Jk5oupMj00GDTgoFX6YKksk4cWhwPBFAjJl1tL0LA8tjNIQ0F82hROCxK3nkHq3wX5Wr79Zh/V7YYvLxpYF+UCZxY8WnM71LTOYhPDJR0wGTfxugWfhsY9jXP5PlyJqe3InBi4OHtH1ewTsNSUJDfpDKsmvz2m6YZpLAYcwDcSS2r8XfPDnCxIA8Pk441MWNiYdhuWSMnxHRo9AvE4eKN9oB7mP/ryO4ASYmA0f38D1YQ+012QVD2a0+HPcj+jycrNAirUQbzVO51CDohSJ/iPfiJWVAZSo8O+Oea6Ll2ExHCZXCINulNV7t6rOxJJTdXZWm+0L68MWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB6871.namprd12.prod.outlook.com (2603:10b6:806:25f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 20:58:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7159.015; Thu, 4 Jan 2024
 20:58:39 +0000
Date: Thu, 4 Jan 2024 16:58:38 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sergey Gorenko <sergeygo@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-rdma@vger.kernel.org,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH] IB/iser: Prevent invalidating wrong MR
Message-ID: <20240104205838.GA318306@nvidia.com>
References: <20231219072311.40989-1-sergeygo@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219072311.40989-1-sergeygo@nvidia.com>
X-ClientProxiedBy: MN2PR11CA0028.namprd11.prod.outlook.com
 (2603:10b6:208:23b::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: e4675a0b-d081-48ed-fd25-08dc0d67ecf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V1rNwx67vnr53O3w1OhUY6drCMy+5nYd3ihjPU0gW0oN0BOPJmpvMItUGwDODMLPCZiTu7qyD+f/ri8sYeG70FTYZ2S9jvv2NQ3zBsduQiTORTINVAMG1skm7Oyo1UITpCb3JGapDascbH7ls/yeWU2mXmnA2/O16DduulYkbellmZ+6bfT1HvOR+Ec/y36VKrB0wLPgbDIYbt99xsuqPWElcJrd/vJ1/On4pThw+DGDAR2ILdlqGIOMf8ysnfcPD/zdixPpwIDKmj3qwL+nDhe0DI+JuXCbYq2Q2YN/X5RmHJXtTpvtCPUBGFoipyzUkLykQ85caKXMzpHt5/5LRe2k4++CVjaCB7r/O3ql67z8R/yChvUxzu+1Ze7Jkl3s9PsP2JAEcUx1+W2lIqQa+92PZQnIO1HAhbZYdRWFlX5DIIu6bSRvR0WHgoWSQphDdH8f+xe/mGIHLMKFeiKNKKu20+0LUEnMIqMvdmI94f6lwTlH7zvAVkNZxUG7AREQmesVbuDayc46RX7YBc/JHM9tfn3+yGEiJGQnQzwzaZ27lhw4BeWyHelF8Oo20yVvOP/gQN6iJSjJ2HKiMiLd+D1bzx3jmMSMpf3rL8exahLZUI1pFnRVb366niw8Bmwy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(366004)(346002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(36756003)(38100700002)(86362001)(1076003)(107886003)(26005)(2616005)(41300700001)(83380400001)(6636002)(316002)(66556008)(66946007)(66476007)(478600001)(6512007)(33656002)(6486002)(6506007)(54906003)(37006003)(5660300002)(8676002)(8936002)(6862004)(2906002)(4326008)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DN5mgk/pXMoIbaGXdBAhR/WdsMVvNtv/e8m15tpT5zyYlDSxQt6cU+nNn6v2?=
 =?us-ascii?Q?xY+7ZNIaYquetf3zzug5/KhM8vHtGu9cjmm+c7Xg0iqv+qSGT5POhpfYywjA?=
 =?us-ascii?Q?vtvS1lCjYlrAeYNTGnIyKInTJVYz30EQKUjHq6U6kDRH/yvl1MoRrIdY/X3d?=
 =?us-ascii?Q?xSLWjcqciFrZV4KnuSVCtV4/oTLgi0McBmQNGBCNSoCZOZpnneqRB3FHoaUW?=
 =?us-ascii?Q?vxSM0kuaIZblNveTs135d+2amf6LWxLRi3H8xYeGDycurUnDJR+HTO3P7ZTE?=
 =?us-ascii?Q?/K1EuzRwrrcDFEzPZGs3V+kKbsn6K52pHbYqD2mTljX0jO8/XWOJxAsn/fJU?=
 =?us-ascii?Q?O27LfZbk0aFpZURnM74PRh2YO7980mEw7DMQCgRZMvxXjNZJB5gEZ5vp8L8y?=
 =?us-ascii?Q?SKHVv515DtnsVPU2q3OxNYFZy6d+56OJeu9RT96MfKxqxew/hYzgfAgZHLjf?=
 =?us-ascii?Q?8z5f8/eHM04F3FDKHbxeq34+ts7b6VoZp1dtCON5b8yj18IlXwhJWYxB74Tl?=
 =?us-ascii?Q?Cw/LsCe1rgpEghnuZTKW4Cfyld0yv0xcrJA+CBM8+mVm7gZn+7OBgxCSevKT?=
 =?us-ascii?Q?a/kyJQsRHWVKqisBEIar6k8826HatFpNneSR4LM5tNH10iTCjxgiC9r53rtT?=
 =?us-ascii?Q?EPIlkIxrJy07SBrOV1UZmRgw49FK7upOGEB1ZzhYW7Se0pwZlQZ9W/uvSnnp?=
 =?us-ascii?Q?qF0Lcmn56ODNEY0ljU2OcrR7SAdf8ugdlbVGmRYHy08Fst2JmgyvSOdzyEBR?=
 =?us-ascii?Q?2vrK3peqH9PxSQVewodA5dEB9mYOYXa682vT0okGbswp9FBBtIqn1besYW25?=
 =?us-ascii?Q?tUElJE/peenJF9RlGTIgYvPP77NBGSuqRyl/2RtAX+AKIjPr91untRpcr7rK?=
 =?us-ascii?Q?xzCdAtuuuesWor9ecdVpodWbTcqZxvXTcanPFsB+dAHpJ6gf3WH13wdRKYNn?=
 =?us-ascii?Q?KhYi29Vcb3Y1zh2ZjYkgoYHxxPiYn2PqxgNtneDE3UeXjmg4rkBVE2C7p5r5?=
 =?us-ascii?Q?74psOHTFsh4iFS97Xi3SB2gEZurHW9x0j/Lue7Zgu436U0SxCZDMAwyxCOPZ?=
 =?us-ascii?Q?r62MVLOaVf/lSkY8eu1BZSYgaZ0FInvg1uz9Ci+/KlFYNZcTbfotXLVptTmN?=
 =?us-ascii?Q?euCutuUF9dM6rNCTE7ZH/hajM5K7rY98RGQopeQMaLFVFuwuYQLAv/b1HSqa?=
 =?us-ascii?Q?eK2I6QJ+gRJu8L7AGd5Ard4JTXL+7TDoB+kDWDwiHC0rBgAXQTHVHqfD2fyA?=
 =?us-ascii?Q?eWiLv/OIIiVNKEPsOd2ORWVGq2mKRPNZRKk+plqaz/e9ZEjkipkujg+NJ1ji?=
 =?us-ascii?Q?Bl+NCX8BTrOUrhOvAgKI79yVky3NRJ+hkVeaFWfhjqpkwb3zAHWJaVS6+zOD?=
 =?us-ascii?Q?EXh5BAD0m5Yah6WH/lfGLwsCHSFXUI9ksbPZ1kST4xtah8ba7KWbCNl8m1lT?=
 =?us-ascii?Q?gI9mZhtnAKAO0WgiHL4+C+UCmGocA3iafFPap+ac9+vK56afdwIqrck+j5ns?=
 =?us-ascii?Q?dTUEk65WVcDmWQlhCshGpTCg0zpjb7Z14s2ig8r5asVYCx9VtWleJ4efs62a?=
 =?us-ascii?Q?rf1lkhBTXMGUx31dloDCm8QjtQN6t09XitGl6XGK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4675a0b-d081-48ed-fd25-08dc0d67ecf6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 20:58:39.1183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SGW407Cj7DIjjvAZT57RWQVnJkXsJnux/btAwQjxIHeFQDpPA4gqVINWuxVy8RkT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6871

On Tue, Dec 19, 2023 at 09:23:11AM +0200, Sergey Gorenko wrote:
> The iser_reg_resources structure has two pointers to MR but only one
> mr_valid field. The implementation assumes that we use only *sig_mr when
> pi_enable is true. Otherwise, we use only *mr. However, it is only
> sometimes correct. Read commands without protection information occur
> even when pi_enble is true. For example, the following SCSI commands
> have a Data-In buffer but never have protection information: READ
> CAPACITY (16), INQUIRY, MODE SENSE(6), MAINTENANCE IN. So, we use
> *sig_mr for some SCSI commands and *mr for the other SCSI commands.
> 
> In most cases, it works fine because the remote invalidation is applied.
> However, there are two cases when the remote invalidation is not
> applicable.
>  1. Small write commands when all data is sent as an immediate.
>  2. The target does not support the remote invalidation feature.
> 
> The lazy invalidation is used if the remote invalidation is impossible.
> Since, at the lazy invalidation, we always invalidate the MR we want to
> use, the wrong MR may be invalidated.
> 
> To fix the issue, we need a field per MR that indicates the MR needs
> invalidation. Since the ib_mr structure already has such a field, let's
> use ib_mr.need_inval instead of iser_reg_resources.mr_valid.
> 
> Fixes: b76a439982f8 ("IB/iser: Use IB_WR_REG_MR_INTEGRITY for PI handover")
> Acked-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Sergey Gorenko <sergeygo@nvidia.com>
> ---
>  drivers/infiniband/ulp/iser/iscsi_iser.h     | 2 --
>  drivers/infiniband/ulp/iser/iser_initiator.c | 5 ++++-
>  drivers/infiniband/ulp/iser/iser_memory.c    | 8 ++++----
>  drivers/infiniband/ulp/iser/iser_verbs.c     | 1 -
>  4 files changed, 8 insertions(+), 8 deletions(-)

Applied to for-next, thanks

Jason

