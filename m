Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4C377D303
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Aug 2023 21:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239488AbjHOTJK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Aug 2023 15:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239401AbjHOTIm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Aug 2023 15:08:42 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20618.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::618])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE931FF2
        for <linux-rdma@vger.kernel.org>; Tue, 15 Aug 2023 12:08:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMTmi+EKkH97NqFwlahCLZawcpyy026QRM0I9AEEATYcqbRtB6Issmlt0FY4TLJYG2kqHV+0sFzdkUG5CgVzZUM/3oFyaEOaYlXBTp8XNEQq1P1hbiMX1uCuLJlhMxhiI5NnKYGhHEq/ErVHo7g1FNfLuVun/19md/PjtkYCVsi4FLVhw8ij18c7XEuQ62Xj/IzgPL+rCaK2R28SLwCUaKU/68dm4tZtHb4mjME6Hx5128EQuNHVEXxYNrPr597W9drp8D57lbh9EUDVGCb5eDOsU5/aNnblNikLtF3AzYQMGq9dTyStnqtfyO0FrfowFPv15ktukxYngW48sP9HsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fO6zUdw1IpyNjV66wMkMH7tERmHh5uenFyYiCvUGI2s=;
 b=nf+e6mWxZJIs6E/3pLJdJCJvgxuojFDXL5Mpf+4MiKFX0W+ny23jv9Hxh8htXzkKHgC6Iu4uR7Yxw6dQrtAqCKhIAR3aAnCpaoIbakwHC0jrC84vIvMlswH0idcAJdShtYFsNe6zJ40opaoKccTkHHvXwwDveDmgMlLz/X2uhozHfc3AawIdtvbeMsRmMKkiXwouyDpo8wB5+9QiYxyaxlgAa30VP7SZoH8oWpWRdM7nluOvQIhd5VHBThpsykEgWYKzuKBgaTNR/uhU7wfyDQ55/OwT/z9Df8h+/A4qDNZyRj1wd+IxLXCLCzVFxYRm+Tch7V6TkCpBGQHQQ7AP7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fO6zUdw1IpyNjV66wMkMH7tERmHh5uenFyYiCvUGI2s=;
 b=N03de/cvh3M2XC5Xen/IF0gZ3mXryfoywyfVm5tHfn1fQfr8t6JU4H+3yLp41nQMFHs91jTmQTSwNi3KG8wX/d8sNC4uEs0kP3ccmlk2FEhxVkkzo3de0KSmh+jlG4uuMGvNFIGT+SN9oq+sJs3t3QAXOgialyQkF/Fb1OddnnEPVqsGrWb4ehvsqi8Dj8DEFFZnPVhCOHANrDKKhwnL2jNKYOHPEjjtQ9CWdPqJfXg4wRBSriLg+bu0GNnm9Sgne4wUcDYvvNX9s/O9lyDmsKSmpzLWXOVs0SPAr80jSteZHajOGMwiWaeYXTTeEXq6x7yJpa7NsHBh1druKB/zeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB5027.namprd12.prod.outlook.com (2603:10b6:610:e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 19:07:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 19:07:47 +0000
Date:   Tue, 15 Aug 2023 16:07:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org, jhack@hpe.com
Subject: Re: [PATCH for-next v3 10/10] RDMA/rxe: Enable sg code in rxe
Message-ID: <ZNvNAH4CIyIelZl/@nvidia.com>
References: <20230727200128.65947-1-rpearsonhpe@gmail.com>
 <20230727200128.65947-11-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727200128.65947-11-rpearsonhpe@gmail.com>
X-ClientProxiedBy: SJ0PR05CA0165.namprd05.prod.outlook.com
 (2603:10b6:a03:339::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB5027:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fe37243-5208-4373-a285-08db9dc2e9a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3yWdwqUA55rGdur7aXFZkRfj4L3PPezkyvQcLXUjiZk2Xtg2QPZ9uTvZOzLBEa/BqVgfAFjcEvtogEf1GmQLQcDtRVJwOBq9DnYwThowMEPZvCAZyeRIkGw2QTGmoSwH22Wq6tx9jPlE8Z7miNSdatH8ak985BBWFoaEAxATfU8KISxNK8lNfCl2D/G2eEl4RD1mrvSKXEPoxW0tDbA6lPYhsZ3eUUtshPN1Hu0L6Zr72vRO+iFWnGKZCU/ZnmfWxOgsgqxAjlo4h/3vOSDgjP2qSB3BDHf7jnZmdApEYSzThLg521Aw67rhRwOcL78EEwSIyNGfoiyU/mUKfQURFPwPGUsdrdDGuCPGX9CyL+CKA5+qO9MUanLbUOwEd8vBZH5pkn1t5nohgOBNDrafZJdQGoDAMF267YvV1zSRe34KZ1GpUejYguKp+WgFClH5dKeVNHkksN6B7CN1AxH/diJWXj8hjqhWjOBZ0dd3cCF/4dQvRfkYvxNZtX9oFrsotxaS8phF7Cm/UO7obulF9+NDQMdxGC9BUYPqphVUeyBcW9MIi1WpbMqUoLA317rh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199024)(1800799009)(186009)(2906002)(4744005)(5660300002)(8936002)(38100700002)(36756003)(6506007)(41300700001)(66946007)(26005)(8676002)(4326008)(6666004)(316002)(86362001)(478600001)(6486002)(2616005)(83380400001)(66556008)(66476007)(6916009)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pY7GokiP1QmB52DmNNRzbP3NZmwLDRCv5rMAZCG5y2FlORqrcnLARReyUFDK?=
 =?us-ascii?Q?6mw/Qk+Li5ByFjPgUWeGv4XjveNUl3n9mX/By7r7pmv9MAaoNwvkGgtjj931?=
 =?us-ascii?Q?whFRwFYNsmCsdABv0m+En+LbvgnwqNXQDrT7VYsXDPhgrGiaYCIciBUovGQn?=
 =?us-ascii?Q?ypj1ewD9GSCAJGknYOJY5C053Pq8Dawo610CaPmcxcyb4X0TnJ7RqdNfjQYy?=
 =?us-ascii?Q?Sgw4SPF+sbk1yvxc0oFGBq5L33dunYVw6esH7Y9PEIrxoW/77r6VgFKNhsUb?=
 =?us-ascii?Q?WmMydZbs1SAOiRA/pjsCHrWYYmaN8mgjjT+HDKdalnd6RHLSuygy7FrpjFhL?=
 =?us-ascii?Q?yhVzbmImQnDoUnylj2/eVkEb3AOm1jHDS6phtd4LNrGKsbePYIqnFj+2HCFA?=
 =?us-ascii?Q?oaWpMZBm6I//TG42pjva+5gQtBodtL4bn4TK3MvbV/uE/HA3llSlR0hawrNr?=
 =?us-ascii?Q?nkQqe2Jih2lhrExb0MZZQYuV3eYM9vnf4Pm626bTpWLi+AZSuARavn1XPt9r?=
 =?us-ascii?Q?kS20FbL5hx/p3+EKpWS8h6s3Znt559s44ouxmfchQeDb9XecePcZtCNKDGv6?=
 =?us-ascii?Q?jytbkT9v+ERhMIiOT6DcaaGA/HL5PCvj00cCZjEdH0TSEbcMZL1J9Hb5zeu6?=
 =?us-ascii?Q?hMvrua2NpfiFjAglek8mlwLRI+6gF7trdt5YFYgL2514ujOz9Shq2U1Vg8qk?=
 =?us-ascii?Q?PoCsWW1sT3h825hQmumJa0OlEvr+iJ8JqOz1OKXFulOcJeik3Qk7NChzBv1T?=
 =?us-ascii?Q?r20O2YcnDs4SfNt1USipHoEHP9T8jigheFQkoXHv51A4gtfm3AVEey/XMtdM?=
 =?us-ascii?Q?up+pni5m8MzFXI6knI8p2hmPLwaPd5bBQMb80vxNQGA9TnFNBIZ7uICQNhph?=
 =?us-ascii?Q?SEvgBtJxJxPKHjMe4YHGDkYK0tdn1RRmAlEk4Hpeu8JDrZWFR4sArXRMefKJ?=
 =?us-ascii?Q?SVO7MciywLv4/ce0o+bFSuVo0wUXGwqX9u0df6csv2POIfkTgSN1gu7I68qq?=
 =?us-ascii?Q?Utrn+FVNxVSt8khhNm3boTOlu5ZsKAT9FjGcN8EnAoZmFhyZndov84Ro0g5c?=
 =?us-ascii?Q?XWGcXILQZ0eV7rxCKVEcd7nlgXbBA0FOaR3/MEZdDYeW3DgrhjusdazO/i1T?=
 =?us-ascii?Q?jKXCgvBzhTxlJbtv57NOzuT3fxRxsKkO4+hcmJQvh12p9CNqTzlD6tLOgYa4?=
 =?us-ascii?Q?6mZ/8u5PyiY9PBl1h05TDfFTrKDodDTqVU9z9eTotY1EQUb+qnwRZW8qIsuw?=
 =?us-ascii?Q?EFJDk0Ds8dOeLT4ZJkFGP611bNuS+gnyUpcskbMY8yyE2Gc/U9auA3TkzwbR?=
 =?us-ascii?Q?+2RlCy+lisOoAHyrHuaerYwGjVAANZflqhUd+98ndc/uBU9i6a9nAVvZXeec?=
 =?us-ascii?Q?cIwSDbyvVCPCh0kAPU0C+bwqVYJgjb2W+nChJ6627slifWIT6IyP6NPJqmZ3?=
 =?us-ascii?Q?lmO6x+7F+P2q2ht004qJuv0aBvkl8PN37mVCNI/DkkU7kzalTNC1wruZG41D?=
 =?us-ascii?Q?i2KhnxsGC71vz8dNxmtZSe5OxSipbgMoy6A5Ns2Ajq3E5eDlaQt8H/ZSmr4z?=
 =?us-ascii?Q?4pWoCDr6zTBbkyiRF8KSqWQsJmSa6rdqjFAJcDf1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe37243-5208-4373-a285-08db9dc2e9a2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 19:07:47.3317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pzdKKX/sm/16Q2me3PEalpjL+/ElxF4E64/wQCuVsjn+sgD/i9J7vg7xT2zyDlhE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5027
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 27, 2023 at 03:01:29PM -0500, Bob Pearson wrote:
> Make changes to enable sg code in rxe.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe.c     | 4 ++--
>  drivers/infiniband/sw/rxe/rxe_req.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> index 800e8c0d437d..b52dd1704e74 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -14,9 +14,9 @@ MODULE_DESCRIPTION("Soft RDMA transport");
>  MODULE_LICENSE("Dual BSD/GPL");
>  
>  /* if true allow using fragmented skbs */
> -bool rxe_use_sg;
> +bool rxe_use_sg = true;
>  module_param_named(use_sg, rxe_use_sg, bool, 0444);
> -MODULE_PARM_DESC(use_sg, "Support skb frags; default false");
> +MODULE_PARM_DESC(use_sg, "Support skb frags; default true");

I would like to avoid the module option - is it necessary? Shouldn't
frags always be better?

Jason
