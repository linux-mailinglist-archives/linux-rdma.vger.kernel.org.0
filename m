Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC34553503E
	for <lists+linux-rdma@lfdr.de>; Thu, 26 May 2022 15:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347370AbiEZNzC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 May 2022 09:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347128AbiEZNzB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 May 2022 09:55:01 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA43562E5;
        Thu, 26 May 2022 06:55:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PrtP8b6IHDhiGL/g7z91dTsg3TX5aOoaIX1RYoLIIThHhgwiSEDiC4Rq2ydYusgjZFpHwIjOp98cXYNzLivsvJgDzBcZ7G+jidpzhVD3HEuChsQ9UYdlMHR7R87u4wffs0YBcXh3U559hjadrV9e+6qTFHNGxpBlbkP+KCioAjlum3IUo8WgaXrhNFhTRDwwTDYi7wMQKlYwPdHdiqX1xuWRwRVNryqI4xuf6mn5ssWhBZmraXOEDGtoM04nnDTxAK64BigZaWJDyRgvo/FAWfBNNV7QJfO7Hr+kVrH4T+ptQa5DytdNRTEgX1N0yiFI0FjNo/fyL7IO6gB9IXkBJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BoAxY5wk0pf2Lhc4LP0WiaGuF3JE9xJCyIs7479quh4=;
 b=OxH/12RCqIkv1UWObx/pUlrD+XjDLcBeQRsZL8WUJhnwXC4RMxIkBTtaGo/k/LOo0OeACOPAFIGXd/pqbI5L6VAi+iTYU4hHj7MuEITsST5gukjUVg25cW7grxLzPa5cYhRpx6jzBNhAirbRuDJ3alZQdnQDeY4933baavimnaFVc+697ygvIzPtBvlVQZ/p4TqVBek3sYeCEizdDiUg1hwVctu+5axSFsA30S8qN2YSp+1/uN9yb6BcDXhwAxBtIDAWTRLFnw0gajAlImOeAmGYfWKO0svIg/HlCKaLuE7dDg2u46upF3jQArkk8Hr8kTBNq7WuEazJDgckMiwaQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BoAxY5wk0pf2Lhc4LP0WiaGuF3JE9xJCyIs7479quh4=;
 b=suZGpQgEUmi5ZL3FyNMlKQFBqeO2Uoo8z9W/lNpQS8IAfI5DkfNjuRQUEnPILDr4BVduZ8dolAMado0ZEbqfjFaAHJzKr3JwAhA59Pi5PsLkn1iOyJNQzV2RCUlKviTsd1T5fB68d5fOKVT+KFxyk7wPPnGeFIDZMLuKT70qHQsFY/ZeA8gyNo+bUxyOK+YTgC1GWir3u/E5+gDpJooGxAhivNOQY3dhKbD2le81J5+IGJHDfwhN/LwWk5H/CLi4t8DTxkyBxNtnJRY8BOrSWOYZO9EhLRsf+sSMzEoukrnslepLNIdv4moguS0DF9fpPmelczDIv1mHCXmfYIRmNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BYAPR12MB3415.namprd12.prod.outlook.com (2603:10b6:a03:d5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 13:54:58 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%7]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 13:54:58 +0000
Date:   Thu, 26 May 2022 10:54:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, leon@kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] RDMA/rtrs-clt: Fix one kernel-doc comment
Message-ID: <20220526135456.GA2960870@nvidia.com>
References: <20220526130945.98601-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526130945.98601-1-yang.lee@linux.alibaba.com>
X-ClientProxiedBy: BL1PR13CA0082.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::27) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e34bcbd-997a-45f5-6a8f-08da3f1f5202
X-MS-TrafficTypeDiagnostic: BYAPR12MB3415:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB34157CBEAA6C5E5E068B24BEC2D99@BYAPR12MB3415.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Z4hY8TeGbL/jS4qvMMPJaO82zfIuVKBJvTymf9nIUHI0fp1pb8Xye9oJ4wZ6wYO2akW9ivbuT4Iof08wfuhcsZJf/hRAZJlgex6sVfOoY/kK/yRxoEwvS0HAuF08rarvdJzH34ZzvR20GjJwWzioA1vudWaF+ym4IPuCJROPPu09sd5WKaxBH6129XrCanisC9anNbzONRGaqtK2jfRAw+UHWTC5IOP2zQLpCoYU5tLFmyx+XPOViZqO67pmeLfZ8Qd4aTsDY+KOu9Re6Z7iPeQBWcGAXyZibF1UmKTN00rmTQCvh1cWhf/PkDEFIm8fAbe5xjNXipW4ts4lFwzP4RapgUBuBCYOu0Kw1M3pyoj9V3FEWK8a/8FXTCT+B6j2M7FifEtAKoLapiwDHp+iM/RbSscjMuZ9wbDyTXHBap95dovdjsPmcbQJWlFp7Zs7NWWkGh9HnhsBCMYmdISb33GYAT+XcBu7YxsdJnSNVIF88r0j4LVq4hHyV0fqKC8ud72vO5crx02Bh9UnjOqQmk6duOsahTcHoyKDITijAPRqaLCGgcM/ii/FPYyL2O3Ez8E+RHFwgBdJG/ImUpNj533Oqh8jakEzVIvDD1sEBUjWV4a02OY/oabAR1ZOgUkyUmV94plT6Puot4bNjMx3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(8936002)(6916009)(86362001)(66556008)(66476007)(38100700002)(66946007)(4326008)(8676002)(316002)(1076003)(2906002)(6512007)(4744005)(2616005)(26005)(6506007)(83380400001)(508600001)(36756003)(186003)(33656002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pi+oyuK0sEJATFtdxlYz3sVVBVqFpvG8w2egKyMlh/gropv84imZf7TdPEka?=
 =?us-ascii?Q?vX7OPOVJzoS5FKt/OE/MNPxLYOMkguKRPDca7ehbLtoDJbkweg+uCWS7+QP/?=
 =?us-ascii?Q?rdr/2J4k44UbIRqVdLPU4Q2awF8MlfqBaghuqeEOAXi6hukE51P/4jHElzG5?=
 =?us-ascii?Q?KgqxFkCNYcjDmSicomvgUP5XJbTtfLTtmJhiwpTwtU7QCN9FocSGpJBus2KP?=
 =?us-ascii?Q?p4DJcrREVa4Gi3CYaL/kBiY0y9D9yoRtLrXWr9UlixZLbiVVmfqxITYr6qzi?=
 =?us-ascii?Q?rL7eXg4AdDV0XitZ4Cwa39MG226krBYKyXBPUgOtk3hBxYIMmzpQ47Cr3oYA?=
 =?us-ascii?Q?GMKj2hJoFOP+pkHoN8tnSmmBNf3Kj6vr8PCXGObnqB697R5vWqrpZAdHQ61d?=
 =?us-ascii?Q?7JaUhpz69bPkQty//O21OutgaP3Qre00G56XHnJlFonCtQ1FlfOt0DPDF0fR?=
 =?us-ascii?Q?moXJ/i5xLT5RYhAyintrTYcVoa+3f7OmXc4sIKFnoKqm4ckTZu8nxmo3CIB3?=
 =?us-ascii?Q?O7BiZ3tdvZ14oW3ROevl2BncI8S6Dw8MRNuPE+dOZexK6ysRgV9d7q7n7sU4?=
 =?us-ascii?Q?vJKwLfgNAKFhZxXdmXRf6/7WlmKFTXmzOcj8AfR+flmoqiq1oT9KLmr2BphO?=
 =?us-ascii?Q?IMfwBcaqk1swJolVxxje/tZNWrnM35ra9rCeZ9B0QXtDjz886BM7iMVn90DW?=
 =?us-ascii?Q?qXlOEdT1ALYO5WGR2TAG7A/t0gLJnpY4ie5PObVjgc2/JcLrGhljsKj+w1S/?=
 =?us-ascii?Q?a0KEK/+sb7Fm2LCYCO2v4byzPf+2g/F/CM5dAItRgmRdA5hDMPjpAG0oJism?=
 =?us-ascii?Q?ibnq4bwqRm/mL5zfU5Vt1XVQjlOUQrwAJ/2yD8JB07gD/+Wd+luL6CbgXhAT?=
 =?us-ascii?Q?USEaXrGOyBszrGWYDpD/Gb5ZKBPnj+ES/ySKcQQRn+os+aA/d/3Vvab4A+Mh?=
 =?us-ascii?Q?CPDLsEUclk9WRnsatdVDbG3ulI6PanbGTwpX9eFBcBsdQ8Rkhns8G27yFi5f?=
 =?us-ascii?Q?wsEo25ToWFe6EWTO1yiGBA+PXdSp5kd/CAg/ECFeoBp0qY/2cEaBeQDiZxWK?=
 =?us-ascii?Q?AIPd5WLrfvRGFMCzV/EG0/ZCGUSFtnJA//EJSFl2IvoSYJcFAB4yqfdBML99?=
 =?us-ascii?Q?jv1es7nOArA5qGuBXwpLJOZEy9uX7Wswz+p53eF1dGNgFs2SkyXb2sRFOnuA?=
 =?us-ascii?Q?10moR/fPkVKME8Zxn1q5pOk1NRhLkqRQ71at+K3nyKS3gZq3mm4fnRY1EqOl?=
 =?us-ascii?Q?+k56OajDVenxQjdiPCbgMli/q60B3ZwIKRkYMjZmfkr6yZuYquER1ramhQIo?=
 =?us-ascii?Q?HexKMKbVa9d44Hy6BhDHlDwDG9LZ6fmyU2L1+UmPKjFUptVeficZM3uRiS/0?=
 =?us-ascii?Q?Jp8RES6stDG35vqzjQMXOk+jJjkdRp+YE+nR/DGV3iX/VFTisW1t/ZxVUKHv?=
 =?us-ascii?Q?5FI8taBpqqX5DnNWqXns5fdETHA2e1Opi32RxdLwoX9fEKlbcAC4iRKNDCM2?=
 =?us-ascii?Q?a6lbZWKn2hB5HtUUj7gAZdLisf58lrnmxNFWxnNpnajApCuB1cKrbqlGLc8j?=
 =?us-ascii?Q?50LWMdzFrHhd5bkL0OcUT7HFZMzt8CdUMq8rxMjM8I6JzsaCycmy8hFVi/GE?=
 =?us-ascii?Q?gmc5QhYxA4ob+F9XB8T+eLQabSuvj/5Oo0f6sacSwLQQzziBRKpKPj12+jQx?=
 =?us-ascii?Q?9+d2VR8NQD/VtL5FZ7Rff9KyCdUp9U8AHBP9b0v48YrTtEsMEJnJKYvE0ntr?=
 =?us-ascii?Q?Qp3nyeWf6w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e34bcbd-997a-45f5-6a8f-08da3f1f5202
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 13:54:58.1740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2auUjbOSI7pjBbxGpNURYVSTLqPsse5/V9i4Yp5jM99ZH6BFCbukcxrHpaGMihb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3415
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 26, 2022 at 09:09:45PM +0800, Yang Li wrote:
> Add the description of @pathname and remove @sessname in rtrs_clt_open()
> kernel-doc comment to remove warnings found by running scripts/kernel-doc,
> which is caused by using 'make W=1'.
> 
> drivers/infiniband/ulp/rtrs/rtrs-clt.c:2809: warning: Function parameter
> or member 'pathname' not described in 'rtrs_clt_open'
> drivers/infiniband/ulp/rtrs/rtrs-clt.c:2809: warning: Excess function
> parameter 'sessname' description in 'rtrs_clt_open'
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
