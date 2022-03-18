Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0166D4DE09B
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Mar 2022 19:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239922AbiCRSBz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Mar 2022 14:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239877AbiCRSBw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Mar 2022 14:01:52 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3774798F5D
        for <linux-rdma@vger.kernel.org>; Fri, 18 Mar 2022 11:00:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXLZaAFW2TSvn5Y+ETHR4VYcIhg/c4oQF6BWzUOGlZrx7A0T+eZ9PwfBmlXf4gTe3lzHDxwq+Id/Ba7AkO/iwx1boHv2qb9WdoZddY53CJCAfKMvlSOmb4SCv43bCHFJPb6cgfcio6Y/pehg6shaeWdxvw537Intul/I1fEr+bPtwwrpqV6Y9JbXjyG+oVATAJC9ATlYMglW7umfbmc4YhHFqB9qUc0ONfw4HiBZ2KFqdyaOvwQ7Q2hYJLzPvX2wBiAUqxzxaR2tKTRByl9GDz8J1Gb9T+2JHgroqiHEPfq1ULQOe/rm5yfPiIFvXdWo12oiYy8hmvV60zD/BuruCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eumjg2UpM7z7u3/ciahQsXVON5MunnG+ooWjBrV3ZfU=;
 b=dIR/3ujbKVqvXDC/5O/1k1mH61usM79H+BHZqX9e94aYjtT+GP32gMtw21s8sXgODKXNlgG5EMM/E5vUtyhL/bDxguwiDqjfm9rKEvSLQWPs7UqrK0rfC1xm7GePsaA2+M/tx8+pxls9sXSLmQFHfCBbMwBECPcWmgv3b84LxIoLFUPvlqZvzb0YCZrSi7eT5iPuAzO6McqS8Cw4WtyiNfcXsPhyEXZaRORqVFiwlv8DjMDfilk8BI7ZVdeh8Zzn3FnQcGymz/g2odH0tVGpX/+ZYz7x7MjyNLTs9fccEGJV/lVEAduqVIoTaQNLLvx5bA5/uRK/Wvr6l+bW3AtxWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eumjg2UpM7z7u3/ciahQsXVON5MunnG+ooWjBrV3ZfU=;
 b=sZR+9uqZFGfyDFcOGRtkqqxnaiO6bpPZJN0Bz4Nz/IRfXNjLx8tOZHhHroFAMYyBcfDKZ+p4kX86uX3B8JhWElo61UcbqHOdo4pRhFZXsQvSVh3YYDJYIN9Kyb8bZPDxEeE5n+hfKeJB06SQhO4+RVaLBOzv8pYec6Qkx+Re1bm+i85VcBl7phKkii8+xi/TAf9HmwhINpy+JnlZOaHAgOBp5mPAnsOCWMxS70p+xu6qocsYtkX756GdUB2P9XimkXgyzH5BLSxurdxza6fuXDlOEjVb4gxwr6K0e3o5/icGBqYFlhTGEpl7Sr1WumLcbqfDMW4JR1bVn/9zfStdAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BY5PR12MB4161.namprd12.prod.outlook.com (2603:10b6:a03:209::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 18:00:31 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%5]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 18:00:31 +0000
Date:   Fri, 18 Mar 2022 15:00:29 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v12 01/11] RDMA/rxe: Replace #define by enum
Message-ID: <20220318180029.GW11336@nvidia.com>
References: <20220318015514.231621-1-rpearsonhpe@gmail.com>
 <20220318015514.231621-2-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318015514.231621-2-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR08CA0018.namprd08.prod.outlook.com
 (2603:10b6:208:239::23) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28c497c5-3a8b-4a7a-a9f6-08da09093110
X-MS-TrafficTypeDiagnostic: BY5PR12MB4161:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB416198F4A18C8F2A0A49F2DEC2139@BY5PR12MB4161.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gY6caIYm4+V4DgCHmfIrrOqXVotTz+TD8Pe2ka/HWDgwyjvCSvetNlXuDJTv2fwrV8Jn2ZNTfpnKSXRyXqJttEMHD2L3tR4q3TEQhGzSpMPw9yPcJxL27sHOX7+w+4P4BApa1WhkUbERlbbUfDeS/Wd35/4QIZtLSB5wV6fIC2rinJmvuTNq4xNy4A4v9brH7d4Gv4UeReR+Ug0t2YdrVNydpYdePIBFk2YjkKDCktbezY+2UD0HpFrr3VFzSUOYC0V79ZLYBzLNbI+Iv4o6b1jwQUguu6F1iyNA6/AigdChKhbXIgINg4HpRDoLXxS20nhGpvY9jklync3k3iLrIeOt4G3btItJs2m9n/LsfmKg3MvsxiBdaHspbLFxcK8cLmn4ZTXLf6AaEOpFaFuOy4Dkp/t9zd7xOpo6FZ/TjPpm7caPQYpMFiCwTps3HlW2PC1nCjAQgtZsNy3TkD2gW6UrbYVAz2Ckd1Cm+hcIMxS3pKkS13qoaA0u3kHwDF/4hoPxlmYIXZP26suuncuwwqFQaFtekLi3yigNC3Lq+ZQreocY2hE9kkrqyd2zILcpspz6sazo+Iz2l/B7J9ejRKVHstKAJqdf2gVpyXeTHnP1AaxE3JSQXd8zIDZhRWG+Tbbk3eiHWTi306fkerxDOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(508600001)(38100700002)(2906002)(86362001)(83380400001)(6486002)(36756003)(4326008)(8676002)(66476007)(66946007)(316002)(6512007)(6916009)(1076003)(66556008)(2616005)(186003)(26005)(8936002)(33656002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cj3EZDDYrJHlQdgu+Y9azyYsGS95ahZmDlaaGYrQohfOSDMeu5oG/QIJrc9v?=
 =?us-ascii?Q?m88TlQSWVOxg9fK72Q3ca/2HbD08AOenQls44az0eN3uje9DWS8dMaTPKCsB?=
 =?us-ascii?Q?FGZXtWvcF04nsuTe2GlMFRgOFNnb3d2bKHlqdQJHQpBQKNvz0nmOLbykX9lG?=
 =?us-ascii?Q?ftytTLeRO9O7PEx5fdEd2jIIykAjn/H2bf4Jq0UN+9ur/amJg/5J4/1F4C5R?=
 =?us-ascii?Q?mrI8tVSePI9Uyq2aoJ86G3EUfT25OpCk4zkdfIbumERokcnqFimokN910Tta?=
 =?us-ascii?Q?94dnMVl2jhA8HV7iQHmKJSGRLrFaSnk9vSfMPO7oFPUkxLX+YE6HNR1pfzjK?=
 =?us-ascii?Q?Zss+EAbZXUZSaW7ai+I+NQB3KYf4+7skQbX2fyi5QvoxQeNd5logDJMzwaRY?=
 =?us-ascii?Q?u10R2AfAboMIDLpsyFoxE/8gwtuCOarPifNJ1Gjvut5kSbvJB4o53Dx/P/c9?=
 =?us-ascii?Q?+h1MedgrPFKjeud1VnvwNLtOeq0boBVhCjTSj85SR5rEh1/kO15R2yKzdLwv?=
 =?us-ascii?Q?+bEy46xPekkykUCRSqfs74ULdhkonu43j7LKu+fVb+YAXHHASmVPPSFZn1lg?=
 =?us-ascii?Q?XvxWACrd91Ht8cF5EJe74kdDd15HSl8chxgEtEcHv/I0wSdv2xctFjx6f9E7?=
 =?us-ascii?Q?qsa3VwhRX83jEdSZpeBKHo2jlBFoYxs2YMXmD1mXTHBrXTOlU9um6fkW81MV?=
 =?us-ascii?Q?tEXLMatbeBqkm/yfYn74i1kWijLAfQfwSlcO32z3NDHIF58AEQqLiDo1WCWs?=
 =?us-ascii?Q?4tSAT+WU8fDOe2juRjxrwpVAEYZH0RwXCN9ccUF0D9sEVBt9306Ml3QqMA4g?=
 =?us-ascii?Q?nt4OhIoUfq5XNy5LXTDyWvkhZ2718mtaBEgvXUHV3gbnn2J8geGXGIl99nIb?=
 =?us-ascii?Q?fDleI1VYeNJpP78r5xazTTbsHHAt/x2dhQR/YNSR7WV8HqLZgp8gxBslerUD?=
 =?us-ascii?Q?IIXOYkgYit0OIHOWZnmyb0YS+JnRTuHmfyzsOuvcAZfcS8+rWta8xQ7fd4hD?=
 =?us-ascii?Q?Wb33C/4ZSd6i1dRAw3b8X4WjLwKl1En1ibeWF8+8bvOr54/PWJvGu6wuWSQI?=
 =?us-ascii?Q?lMtpjlvXtJItvbJr+WfozeZGT4TnkIOuS8VPmblRIxFcjlR1z0YWxdTDAQ8m?=
 =?us-ascii?Q?p6Oz8NvoHu+n6K4J0W+KaC8zL3qGmkeB3YhLaUJv73dIIEL8heCXh5j4H+J1?=
 =?us-ascii?Q?HEJsD2OxWt+W+YcE27yy9YjG13cg5qZo88w+MWTCY/BEdDImHQAWSXPCRRF0?=
 =?us-ascii?Q?8OL1Xdg2+XmU0sEs/PpCTUumM8xHHy5ebgQqZD6Lcf+uVE9+IlCKgpwBe3Aq?=
 =?us-ascii?Q?+WB0LcxPxPlrINjVaV0h/P9FLlrAhZvftBvvkxhzrW5rjzV55SptDnO5zZdI?=
 =?us-ascii?Q?V4uHN73dqmBFJTB3NnHEJbCloWX74IPenimsZMTsx+Edh4MO283hHkIO3v0v?=
 =?us-ascii?Q?quQpL60zvBwle/iQ6Yc/nbs1i+MYfL1U?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c497c5-3a8b-4a7a-a9f6-08da09093110
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 18:00:31.0440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fnWdTtMnkCw7GOOrnEDcvZRhVQvHX5v/KAY7AK/IlRsiSH9wh4cO+85D8HW48NJ5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4161
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 17, 2022 at 08:55:04PM -0500, Bob Pearson wrote:
> Currently the #define IB_SRQ_INIT_MASK is used to distinguish
> the rxe_create_srq verb from the rxe_modify_srq verb so that some code
> can be shared between these two subroutines.
> 
> This commit replaces the #define with an enum which extends
> enum ib_srq_attr_mask and makes related changes to prototypes
> to clean up type warnings. The parameter is given a rxe specific
> name.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>  drivers/infiniband/sw/rxe/rxe_loc.h   |  8 ++------
>  drivers/infiniband/sw/rxe/rxe_srq.c   | 10 +++++-----
>  drivers/infiniband/sw/rxe/rxe_verbs.c |  7 ++++---
>  drivers/infiniband/sw/rxe/rxe_verbs.h |  6 ++++++
>  4 files changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index 2ffbe3390668..9067d3b6f1ee 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -159,17 +159,13 @@ void retransmit_timer(struct timer_list *t);
>  void rnr_nak_timer(struct timer_list *t);
>  
>  /* rxe_srq.c */
> -#define IB_SRQ_INIT_MASK (~IB_SRQ_LIMIT)
> -
>  int rxe_srq_chk_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
> -		     struct ib_srq_attr *attr, enum ib_srq_attr_mask mask);
> -
> +		     struct ib_srq_attr *attr, enum rxe_srq_attr_mask
> mask);

It is very old code that is passing around a enum to indicate a
bitfield, this is not the correct way.

Please just change these to unsigned int.

> +enum rxe_srq_attr_mask {
> +	RXE_SRQ_MAX_WR		= IB_SRQ_MAX_WR,
> +	RXE_SRQ_LIMIT		= IB_SRQ_LIMIT,
> +	RXE_SRQ_INIT		= BIT(2),
> +};

But this seems pretty dodgy?

Why not add another parameter, or maybe split the function or
something?

Jason
