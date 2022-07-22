Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B4457E86B
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Jul 2022 22:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiGVUiX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Jul 2022 16:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiGVUiW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Jul 2022 16:38:22 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330FEA0250
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jul 2022 13:38:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=citEg+0J+zpt2GUH6H5sUxljDLvmDxUVRUUCfCMsH70ZKWMWL1dFMwOOMmT6KGYzCXKLcdLf16G+BxTLRM9yEZC9fNGa7KfxsqDDtUOh1qYMWbt2LBLYH9lLvPZXHd74biypenXe+0JRGYuNH8ZyjQiDNriXS1fUCvPxEqaJTqo7NKWZa6u4+ffVbbGdbWK1Wjk9UcNG982VJQe230Db3wENlFFXmmH6AGrBVaRQ8xA4ZZOEXbcsdg8vVmc/5Z3liYtHFpkNYGHBViHFNGudD12IIMfLuEF4rUUgDQrjhFmmAFGIwgsfzFgeJHDsvOg/QVbQoboRNvbgw3YPC6DZSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndFUuDfa9FJa0+7hM8mO2OxvrCwFuv9r5FGmBDmXFVU=;
 b=fgjm5vtPzEtolnxnL1X0rtF6yPVaBKc75gkitvfMgS1wBNN+1fHWXHr9ejPkxEm5rf9+Ojy9nskrcPWtJkIAjOzyt2sTMp2BeryEl9tqBztnYpH16lR8ZcvGgslCF/u1f0i02T1br6+0rFNskGGVvGWx8sLPBXrimJyGpPPbfv5u9dfwh/GbZEe8DBhfBMRYorDdUV6S5AxzgDVX3a7KK8Qr/6QWT8a8SdTCdieimGQHGsPY9cRN2vIb9/JFu7ZiE6g6dN0yyIiTE8IjZ2FTQ26BdPBhaeQ9Iq/6sYMEyJGl97Cqxw4jgGcRoXwL215DmlTGk3TtMx2nSrUb6vxqxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndFUuDfa9FJa0+7hM8mO2OxvrCwFuv9r5FGmBDmXFVU=;
 b=f6Hq55rSuecnEcJaurPaNSYBXBE3BNKkzk8ppqbHeTGJiM5CwhIggWV2sHOsz4WWnTh2Itw8+ykdisB/K1vgYH40snOYTvtnRfzpGTUfSwZ8IdsK2poNK4tJqOpNzS1rxPPu2101XyJAf38bI+QqtLzJhcwdAjsUl05UW+BppJLYzbvPs6gnUC0C7hAPHhaoorTsP60VaiQURp9i5J2w55BZn6Cfix2ffQivr+aot3WsYXHtjCfxl2DWKk/8qkalJI0lOLWMmHdLQpAmtxGE86rTsXVwnydO4D9GSvcYd/oayHS+3UKGw+tWewJNABkqpe+pKP3h6yhdMhd9IB8C7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MWHPR12MB1503.namprd12.prod.outlook.com (2603:10b6:301:b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 20:38:19 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5458.018; Fri, 22 Jul 2022
 20:38:19 +0000
Date:   Fri, 22 Jul 2022 17:38:16 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Md Haris Iqbal <haris.phnx@gmail.com>
Cc:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com, leon@kernel.org,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        aleksei.marov@ionos.com, rpearsonhpe@gmail.com
Subject: Re: [PATCH] RDMA/rxe: For invalidate compare according to set keys
 in mr
Message-ID: <20220722203816.GA64457@nvidia.com>
References: <20220707073006.328737-1-haris.phnx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707073006.328737-1-haris.phnx@gmail.com>
X-ClientProxiedBy: MW4PR03CA0270.namprd03.prod.outlook.com
 (2603:10b6:303:b4::35) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08ee6dc2-7353-4c8e-ee91-08da6c221c77
X-MS-TrafficTypeDiagnostic: MWHPR12MB1503:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QqWMWTIL9oSvbIA/awA8+kgRsIqyxIIB/Z4YdM0gje1ZU+Bnplvz1ooAtoXazceaVvdeL6H1GpTGIWGZ6qI5X2TxPH7R4jF4DfSrPMxz9pK6DB2kiwu7QvTnLSpnWr6WqrwhlJYd2jhaXUDVO/eqRVyu8o2VeYexYy+EKp6CvdWkyrrl+akcy+zSjMyzJDISjvErs1cxWDbCIubHCniafJM3R7yz+D44OQf4ygqh54FaikMVtax51HiQ7ZK4B7gM4QA1Fsb4VZmnbLCy8tDeK13S3fOYtMFOmy7lPCJxAAHoF2SC3wo9poNrxOrwKQMJyQ4e/eZONyfGMHGp3mhmhqDb41D8Nw5A745sflsBwiSXMtx+eA8ECu/FWBzORxw2joS/i5Et6t960NYIxTXAl+8yArzbWYwDe99dAanS6yFFH0+jPkpNsd9iGRLOGCG7psz6xHtE1mBE6I2NGdJHooRSjQJP6iNZkw1xzPXbWCFdx3PRsuVivbclbsmiNvibGpEN6JkiY9FzdLiEw5zoiA4IifnqgvscrkAN467OMhbnjIDjUh7rtVet2nMRM790AClWWwOwzeCRV2MkdRm2+xC7hP4zqcQ+xWnkwB4EPiQZUVSHoUR7RzYfv6qEQlKjTFR0YPGfWhj6B22SSflOj5aRv8jKXVA+bTHvAKINpybXN6HyphuIvtKRKsVvfzwCNBLQQkPpcmiAgp/1pFvBCyi7LIZ5GaiTyirCCB6Dkh9k161yGYjvHaViechoYN6S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(38100700002)(83380400001)(66476007)(36756003)(6916009)(66556008)(316002)(8676002)(4326008)(66946007)(6666004)(478600001)(33656002)(6486002)(2906002)(6506007)(41300700001)(86362001)(26005)(6512007)(1076003)(2616005)(5660300002)(4744005)(186003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eZq898IH/bkU2BnJcn+K6iX8TBLVgUCfRDcZxx5de4hSjlRTEBK8pPwXRvE5?=
 =?us-ascii?Q?dvzFi2zOVyt6HFGjJ5+0VvozLrx2j2Mb4um1ymCwxOHHIgvTSc6aVqlAGZHE?=
 =?us-ascii?Q?QdChtdEixUW/QcCVvKuM8zeceUlW1RD+LzbA8aOVsLMH2Glx61qLQUjUgy6+?=
 =?us-ascii?Q?h1MwhSHSI62UOL6YIwu5n9hkn0IFuVB3fpDSHtzVmHCXw1z786AoFC5HNHik?=
 =?us-ascii?Q?c1C2NhGt9lfohhBhFkUx6j3sCjPMPExfbIymrpFh3a1z5VlRw7ZhgWQkOrx+?=
 =?us-ascii?Q?speoPOTZkev3dyY9X3tT6e5O02vO9ZeaeFwmSKjzbVSgoTzxkYgvUE0U0nMN?=
 =?us-ascii?Q?7BxYrKoSsWrIa2Q+xCbq68QFESSQUPH+MwFrIo5mcodCDbvvlxjB+abwFsHt?=
 =?us-ascii?Q?N4aCDbEAuXesqa14kj7C66rUQ0izR2NxorlRMLBn4pTfzHX9HpThDCP06eJX?=
 =?us-ascii?Q?Qxs0L78Rf7lHd9oI82nJaqCJendBBXVyV+19oneiVmlrcyovkUU36oifo7d6?=
 =?us-ascii?Q?1FpK9VUKs/8m2FZ5S7iUuV0PVw38bhn6L5ku48Uef9IRUF/5LpOqIvynMGVh?=
 =?us-ascii?Q?nkEE4285KbtiFTEMO1mVGMlgk26Q+7A6XEFj7o8mSVXzhkbgjAtJ/0rWYvm9?=
 =?us-ascii?Q?LPl2BN+jO12J1G1vJGoxVnD2rQtEnQsq25N8CxXia9c7CtIusx24uzD/ixs1?=
 =?us-ascii?Q?Wcgw5xhLJrQuPDImL8+n/yscWWI39md+1zPAqWEwmfBqRYQZI1Aerc3Nosuv?=
 =?us-ascii?Q?1EJxntqDA8FJLbZvcXusFi8/s1Fe2vQQDUoAKoFkvMpK8wBcf6DgYRYW5qYP?=
 =?us-ascii?Q?o9XY6p8MMwudRzbAoFplfJ4b/rhJAnlB+khHvXRvCjSAFKGz1GC2jJF5iz37?=
 =?us-ascii?Q?9RaAFuJR84nj/EyYo0nKYISCZEcZb0i8gQPUr+5VyCKIS2HtyWb8yFXhGl5s?=
 =?us-ascii?Q?S285pmqgIoJ1hHeXbl64/cTlFWJKuFgiTaKYQ6/0FwUoXz1LwBIQk8hDUpbC?=
 =?us-ascii?Q?pBuZgw8A6fgqCr8wvr3l/xF6G+jxGBU9tba495RCzo6LVqcu2ydDXam0Jii6?=
 =?us-ascii?Q?n67F6yerUVnUbllZ4Kibr3pkxWgNfCULDlq4Ipt91vtoANOI44Y7dT17utrJ?=
 =?us-ascii?Q?7j3gmH8g8QwZJQiSPNtxKLtTwkvtqsc5R9MbOa0zJNX6CsbhlRti9GAHy9iJ?=
 =?us-ascii?Q?zuoOjO9c/Ip+2IuXG05qX23eSKRSTJfgNrVt4yW13f+wZ0F6yJWcDGuc0U/4?=
 =?us-ascii?Q?2/kiyPcTadc13M4nt3YIecBI2PKs6MEVt253iA7/uPddnDeBSk4yOwuCR7pd?=
 =?us-ascii?Q?5tMwisANyBpYsndcX5JRYamAoS4z21CyivkcYsadAT4bMKMeTuc5a/F8M/m8?=
 =?us-ascii?Q?fRVge4of7OP3kzfoHafmI9be8hC59Jpp5/f1/mXrQs9wSHinqsmGMzNGY7Jh?=
 =?us-ascii?Q?jxhKS17afIOEJ9TX4cC5HAXwAxP/BsKwmEEWJcBZMKTI8C+cvrIGf4wVYHCM?=
 =?us-ascii?Q?OccpTWPcQEVrixSdYIS3JoUj4tCI7czVjggzyIrZ49P1OmA+qLRRnJ23Drg2?=
 =?us-ascii?Q?2UwLpbUACfaNFrg6DrU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ee6dc2-7353-4c8e-ee91-08da6c221c77
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 20:38:19.2874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pl9QaZD8QB0b45QjLPjlFyjrclp4HOBSLRUalwoFQFAQg4zUQCbHwKe+QJ451D1/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1503
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 07, 2022 at 09:30:06AM +0200, Md Haris Iqbal wrote:
> The 'rkey' input can be an lkey or rkey, and in rxe the lkey or rkey have
> the same value, including the variant bits.
> 
> So, if mr->rkey is set, compare the invalidate key with it, otherwise
> compare with the mr->lkey.
> 
> Since we already did a lookup on the non-varient bits to get this far,
> the check's only purpose is to confirm that the wqe has the correct
> variant bits.
> 
> Fixes: 001345339f4c ("RDMA/rxe: Separate HW and SW l/rkeys")
> Cc: rpearsonhpe@gmail.com
> Signed-off-by: Md Haris Iqbal <haris.phnx@gmail.com>
> Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_loc.h |  2 +-
>  drivers/infiniband/sw/rxe/rxe_mr.c  | 12 ++++++------
>  2 files changed, 7 insertions(+), 7 deletions(-)

Applied to for-next, thanks

Jason
