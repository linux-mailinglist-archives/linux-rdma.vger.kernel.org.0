Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF49075D221
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jul 2023 20:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjGUS4S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jul 2023 14:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjGUS4R (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Jul 2023 14:56:17 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCB430E4;
        Fri, 21 Jul 2023 11:56:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTj6AUwSSGNvV3jzaW7+6eZuFe1Aeqhg3P29YEKmmI0a8ozFIEalMTvPpUVcKqCQ5Q3hg9BpbAJneIxscUBtzNKOPUyxObP4l08gLccs0FeLsRCwRRIVHOT7Ao6tgnLnFAdW+9/bIOpvdbIrJ+DV72DNm6srjr5rrTy3TBmxez8V64wQ+syLOA4q1ZI06YNf06ngslWXURHnn7UlwygnPxK1MMz4g5r8s+DlsX68SMCE1LFeOi0VbWJXuTXLGt7MVuMxzwPUvJOno5aWKQgslYswbkfwV4q6Yqz7I7TKpPzw0HbybocOl3302Wta75Cm8MSNo56bPI0Xnp4kODouDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUUZkO7qPZfwXD2/ypatms61vbENkp+4c1w9GlWJYpk=;
 b=B8QDgtFucdawCU9DND/TYe0PQBr+oTSBungTj6iRTdzALXf6dBPjWt+WT+r3XoRzaMx5rspYlK+TETfMjFjQM8YlIHGd60lemqc+LLf2uz3WwG78D1YE0/70fbCUDSFhN1ncWqmF5XPmn9kjbhlgNohH8z9q02jSkShfxKrQqyeHQY5rRc0XxBFhAwp7WgbstqZRNzItReqxQPo9qSxXGEm8zybgKSseU+5s/H0sKORauAVCzX5eYpyy17X6sx0Dfxg3ZJ8E5BGdPXHUb42eXlR9MRSdZkdJgIoUDGiNwMr4Qpr1O9JkGnSKecQkOw4aXXiLzPZWOEwLKw9pptkDZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUUZkO7qPZfwXD2/ypatms61vbENkp+4c1w9GlWJYpk=;
 b=YZvUjnLCOVqbzx9LkQcgL4OuExbLgw/ueXnNhYEWIYid7y+dyhoulf8l5HoP+wkVpq9iq0eCXXvXm7HTBP5Rq003xaoC1RlXKC4QUhYQ9+8ce/luFqw6pyUyzo+iu0gMafiZQrmTIHMocMDEWrktybwpVuxeW3ASN+kF9HW4HnAdq/oq0VwlmPsZVA/8vWOhlg0vi+G+SsbfAcsAk68X5boZTdtOYFXNoMJTGSW35J+NoniVUmPShDUpFC45tTfS6/TYiGAK2KuoSoK9K9Qe1lTkdVDZkVQSyN3wvDiWVtfdGMjbNUBBvekdBg8/+lcirMfZu85e87b1TTl3nFVzaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Fri, 21 Jul
 2023 18:56:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6609.025; Fri, 21 Jul 2023
 18:56:14 +0000
Date:   Fri, 21 Jul 2023 15:56:11 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Cheng Xu <chengyou@linux.alibaba.com>,
        kernel-janitors@vger.kernel.org, keescook@chromium.org,
        christophe.jaillet@wanadoo.fr, kuba@kernel.org,
        Kai Shen <kaishen@linux.alibaba.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/24] RDMA/erdma: use vmalloc_array and vcalloc
Message-ID: <ZLrUyxqhTY5y8gAG@nvidia.com>
References: <20230627144339.144478-1-Julia.Lawall@inria.fr>
 <20230627144339.144478-6-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627144339.144478-6-Julia.Lawall@inria.fr>
X-ClientProxiedBy: BY5PR20CA0009.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: 261bfe46-7be7-41bd-7bb8-08db8a1c2807
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6qXc0ZJDQ9Y3YUG0LNbaVl3Q7IZ/X5xN0lM73zAz0wSQYKP7mps4VUboaw1aiGDgLAI7Qfm6e0Mft3+pHO7GFqakDBgtwIuAM6J+Ec3shuCNORVheo5wFPNW0suv0V60dl3b/QBvsE02QWBya8OHHZkVkaF7cY4mZbOcgFcaO+nexXwYd26k8RI4LdJTnoRV+7O1b+7P+dY6wCOGWCqneJDtwTJVvT5KcwRO0bsldG2NYuk1m+nEjbVjTYg/PX4me21QR2PL2V2CP3v6+e7kF/pqCSNXpdbC6vnUsHf9IaPCZOt0UZ4KweGPNR6qcYtE0fz4GZOmhpNgtFWRcpPJLicW16X6jNdkLqfMbQwe2iSyf97JL2ItDTLPeUZwxG0M5oq79vHNmElu26X9sF6FYSPC72TjwlKnE7GiMH2wqqcvfzh34OtzXQgZ9UYUGORX/vVv+d7SkOkk0AHiyAhSHn14W1qiJerUhBZvZg9djv5PIL9+Q8lqAQYYxSLxttaPUZwhA7v2B4fm/cd4Uk46Tto5eCMbhJmVRc4jYjOKtaqYhu6j2kRdLJm3dn6WFs23
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199021)(86362001)(2906002)(8936002)(5660300002)(6916009)(8676002)(4326008)(83380400001)(41300700001)(7416002)(316002)(2616005)(66556008)(54906003)(38100700002)(66946007)(36756003)(186003)(6506007)(26005)(6512007)(66476007)(478600001)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8Nyoet3e63494lfv7zu1aFav+tlYkZKk1D1sX+gCCAk2CNcDvYknl1yYFTrn?=
 =?us-ascii?Q?X1SVDNDzxCIlfCwF0xidkwwIFBsskb7bcGmQL74DAeSBLuduFRQaSTBlk6Ad?=
 =?us-ascii?Q?kGRBtsxZZt6dsTTUeGykX0L0l6sHpakETlmvs96w408g0PTI6J1zh9ptgaQw?=
 =?us-ascii?Q?/mrb9FxZ8Q6VhNF8W0tr+T/Zvicxx6gGFun7XTHsMado6U9MG5YL/bywILy9?=
 =?us-ascii?Q?YSXgB8K5CJtIRS4cmI6k3ly5X+2ONDkK5flxeM9gxJ5V7eKfZqEUyjE+HAsL?=
 =?us-ascii?Q?SZ2+sv3AtheuxnT6TGxqUj4lko04nqcwntU2P3Aj//ncTuzhRyErqJvvJ86n?=
 =?us-ascii?Q?+7vuUK5rZWYVNsM/ti58gupGTepDXZ+4gsRgpbsGzWANnKXNpXqXMW+TNKta?=
 =?us-ascii?Q?ytHNSp6hol0fcG4emdglNJv+ZOzWvmuLP/SkLllYqrnHMThFE0GnfOpcJdpG?=
 =?us-ascii?Q?JlsY0SKJduRe7AzArPcs0DkC5DVECIFv0ypWbdYY4hDKpGK74n/odhR9iMTw?=
 =?us-ascii?Q?eXoe+35o5uSTseb9sYmRVTKcbuedQk7nVPrkPLYIr97BlZj6MiZlkzj7jj+U?=
 =?us-ascii?Q?+5tIQ254o+5tvmOqnOgaXaLQGklOmSP7/itt+7u7V6eYDgIYjc/biOlkZ4w3?=
 =?us-ascii?Q?YcgHUDdjv4JwjnTREedgiL4CcpLtQIG1XVV21QiTawaa3G7+JbcHIQeHsUD/?=
 =?us-ascii?Q?8ALtRybbcD/7NCZm2BFepDOoScYmxwRVVARSGjEQYO1qWXKHm6f0GAV/HMt9?=
 =?us-ascii?Q?ejZcrCmAEgWbrQCcT4YPvBmy6k4XhuFNP6PqcgzNna2nDdMovXfp4AUJwLbP?=
 =?us-ascii?Q?Pp2Nel3ndZaTpKbUfeChM93Jack32QRwcK5msj1n2A1Mc/pTwudD12OGBNja?=
 =?us-ascii?Q?uBfolU5Rb6Rh+rIvhWX5J8zsEH/FYUDtcrY3/TF6xGh7mhhCX1HXSkwlgx1v?=
 =?us-ascii?Q?CPXF29ml5ry9uLlIaCFyXoK10hQkW4Bi3ZACGcK8rLfWiAovfkFpu5W/F7jz?=
 =?us-ascii?Q?lK/lwOkYBgthFePDiE183DXBIe0EsXC2LBg3byd2y0tzqFtf4y8NDTj4+sDL?=
 =?us-ascii?Q?XDiCn5+50Qq24QN1Jlr8DvmRoj9xv5oBnxFoX4s1IQoRTWJjcD1vZEqF8dbd?=
 =?us-ascii?Q?iSbPK1LwHgJ8rA3NTt6hGQN9yk3r79K+o8zmOTRzb5PMUtaw/AlXG8w4WkDV?=
 =?us-ascii?Q?L0omEH8Pn+GGrYVbwLsGiE74ciJuYU8FzByf8embXG9icI4bwwMrWwFVxn5m?=
 =?us-ascii?Q?BPBy5d+hvIFVTZqRiFsS+9IShTrriqiLfIJODsjfMcxz4z4VuZHEGVHbF3ZT?=
 =?us-ascii?Q?lMVaCTK60TOO0UqnnN0Qzv+Bke4CwLXpTeF0L2Cb10V4sVMTYfJyOry2tQrx?=
 =?us-ascii?Q?fx1ld3YtubK7Yj8WbV7EbJYm1RuLM5584A+2iTsYIkbcz7kr/QCwjpsqs4dP?=
 =?us-ascii?Q?Ezloog7I5wo5TCPPxItymvEN5EIPBXqdjw4I9fAaXWW9TLaYnC4rgg933pPR?=
 =?us-ascii?Q?+viBvWJZ91SanVO+QjymbSsNXegz6J+ARrDLLupVRYeBnDa+M/hjZi7QKbdg?=
 =?us-ascii?Q?Vay+NtN0KRhbIqWTpOg2TBtnNh+FuARGiExBQCDn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 261bfe46-7be7-41bd-7bb8-08db8a1c2807
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 18:56:14.1413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pvg/2bJqyCH8kn9ze7nTMAElCWBgmQtlfF0SERYqzSKy6s73z8QaYG4pMxe8gnoe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5748
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 27, 2023 at 04:43:20PM +0200, Julia Lawall wrote:
> Use vmalloc_array and vcalloc to protect against
> multiplication overflows.
> 
> The changes were done using the following Coccinelle
> semantic patch:
> 
> // <smpl>
> @initialize:ocaml@
> @@
> 
> let rename alloc =
>   match alloc with
>     "vmalloc" -> "vmalloc_array"
>   | "vzalloc" -> "vcalloc"
>   | _ -> failwith "unknown"
> 
> @@
>     size_t e1,e2;
>     constant C1, C2;
>     expression E1, E2, COUNT, x1, x2, x3;
>     typedef u8;
>     typedef __u8;
>     type t = {u8,__u8,char,unsigned char};
>     identifier alloc = {vmalloc,vzalloc};
>     fresh identifier realloc = script:ocaml(alloc) { rename alloc };
> @@
> 
> (
>       alloc(x1*x2*x3)
> |
>       alloc(C1 * C2)
> |
>       alloc((sizeof(t)) * (COUNT), ...)
> |
> -     alloc((e1) * (e2))
> +     realloc(e1, e2)
> |
> -     alloc((e1) * (COUNT))
> +     realloc(COUNT, e1)
> |
> -     alloc((E1) * (E2))
> +     realloc(E1, E2)
> )
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> ---
> v2: Use vmalloc_array and vcalloc instead of array_size.
> This also leaves a multiplication of a constant by a sizeof
> as is.  Two patches are thus dropped from the series.
> 
>  drivers/infiniband/hw/erdma/erdma_verbs.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to rdma for-next along with

[v2,19/24] RDMA/bnxt_re: use vmalloc_array and vcalloc
[v2,14/24] RDMA/siw: use vmalloc_array and vcalloc
[v2,05/24] RDMA/erdma: use vmalloc_array and vcalloc

Thanks,
Jason
