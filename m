Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E164A637F64
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Nov 2022 20:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiKXTKi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Nov 2022 14:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKXTKh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Nov 2022 14:10:37 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E50D663C7
        for <linux-rdma@vger.kernel.org>; Thu, 24 Nov 2022 11:10:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGySRHQIysMjURnbac5Qu+DWr28MjZMUcBzZczsicptunDD4wser7WRgAJ15fvmVMtmhTo/NxHxTxbh3RaJ1rEDDRXakyDRnU3RIjIRihu1XhGF8Sq8ZmlIHfYhbscaQzGXOzXEv1l+QXNIGCLw43W9saspFaq1Q9b9h3S9u29d6PWB8wLV8fQR0M3k0Wv2EnJ1CgcwDlEJykR6co9VDhx5hpTW5Jh0k8JDWf4RPEKlzkfF5THoYwHSDanf7bsG1LPEWp7pajb+s1PSg7gewGKJoQ5/BoS83zRwC3hW2JgIdgAyc6qRo0SFL0ffQPxr5Cv94DNtKECc+RXYm3uPF8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMEIYGBQeeo7+/tugYUK7634MrEtnABkTOXLulk3jUY=;
 b=fQkF5Gs5tFg/lMppUe35EzT58/CHR9oG+uI/3J2/3IqGVH66cpN6exYD7qUOtNtqZ0yiYuvrMmDE1HSeWSLnjdRgH4rDEZXm+s/3QbEevGhCBV4B1MwLWtZJkPvFMiBxCzLB1ehBTsx//TpYWqXnEqQub21V97dt0rZfprdtUqmsen/PYxqJYlzTvmOS2NkxZrtJwCS7J4aoVp2D25uJVouWBnDpe3vyCKtRQ7zXearOAmEWMySRsfcTcepPXACYaxfWAMbasW1oUW9/8nZ7kQGNH/ErGukBr2eGXL79wJs42a5cZ8Nsk6LeTiNQ63PkagGfDkmig/xLXRsOeTTkQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMEIYGBQeeo7+/tugYUK7634MrEtnABkTOXLulk3jUY=;
 b=LT3CMcXImGLBE8lfmt0B+a7SHkJ1gic1pgUxqGAT+2lfw5CjFIiLzmoNw5wdQTWnONSsqQj6qNIsFby5S8tm0IAUl3vw3bHk93jCYlgpWR9c6xePrRJ6rWjhRX7K6ogLDZgxft035lVhyaAbnMTwj5OwDnUnN6hF/WQLhrF6Iin7phOnFFoYtNs/ayAsGhBRoheivsKOeRnd5nfIpxyRVZTtf0lDBAZjBGiCq8sohEoskzNhOE+FsekvrNcYfTJy+AqjxEUQp/Pyn+oUcOCSNmg5Qy8mDk3vgye6hroNWiTvlLbmYcCiC9893maGZNCJybNJrfzxocvC35nFWt72Fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB6487.namprd12.prod.outlook.com (2603:10b6:8:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 19:10:34 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5834.015; Thu, 24 Nov 2022
 19:10:34 +0000
Date:   Thu, 24 Nov 2022 15:10:33 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2 06/18] RDMA/rxe: Add rxe_add_frag() to
 rxe_mr.c
Message-ID: <Y3/Bqa7obMROAtr8@nvidia.com>
References: <20221031202805.19138-1-rpearsonhpe@gmail.com>
 <20221031202805.19138-6-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031202805.19138-6-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL1PR13CA0086.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: f2bda01e-b577-4f7d-7262-08dace4f9024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bUDZ6yG+i5w4lpBeo1PH6kSlWZtLXHMUpf4//GRLtaAP6ELgkFlT+XpZ3GTIy/QcDC2eCejN2melMtZaPLnm46FWjmykg/MnRSWgGZZF4+4EW7db+xKA9AL4AptTEQ/I4SFcYHJ2W6+8QQ6sFb3ZTOmWxR0KVKFWThfIFLOuPu7SSuIougDL3U6Qw3CTggqswqpO8Z7i9aMEVJuefgTMoECTCpdI96X1DdVyC4xBuh6zWINFa5/MKFeARuWTNO9R8Z/OjnpmRwcv3z0AmMd/zc+J3RLAQYlt8tr2dILFPZH7Sdp8nycaOignhOM/Y/DmJ0koWcDzwZ3P1xV0n3/dId0WZZ4jM2NInFB4skgRq/PAp5hn1ZWFk1kM4V+gIdrUBSRHvPZxFbCvUYYHM6TYVGsoZj2//OVfgVJe++TMeNL89DwqPaNL8xpjZ3VYIDhkOjx7YlhOhvG/mAm+3wwSJ8fkkf72jAzr4VsJrcidbXpBACqE51OWyAUZduI9qwO+Ii+BT7qtTsgYoAqgUxfzI8DTWf6ud5aWWXoZd5sQFSAZs85i4gCrG78FtVsPE8vEtSBV38qew3xcQ96NvnmpM8aTRZVwkChMjLCzuXFM0cmHaS3CkSu/1FsKLViWwX2iAR1J9dkbMrHTkXnu2Rhjg8wj6PtU/F2YD7YBXppAzeSqgzl9Pfe9YuxrMrky7rq5/Cork7m+nvu32UO9GxzgPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(451199015)(966005)(6486002)(5660300002)(8936002)(478600001)(4744005)(6512007)(316002)(66476007)(26005)(6916009)(66946007)(6506007)(36756003)(41300700001)(186003)(86362001)(2616005)(4326008)(8676002)(66556008)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bzOk7MSeq0utmiLR3UYQZw5L87/pKnvfYFjWqJLIely5JRTG0NJvsPhJCrVB?=
 =?us-ascii?Q?6gZXSKs9+OAxa5tumyxgC0pl52zJWtll28aVEXBsrSLim9uTY95JO88GgwOU?=
 =?us-ascii?Q?vYv2wr4W5bITCG/dB+bTBwruRPbawdDl/6Y69/ZdQl8J0FEGNUJd6nTkT4fO?=
 =?us-ascii?Q?OYTXku9E8P49kQJ1VCMnZQB2ab339xj/sdIvlfHTfE1FH7IBjJ0wkjc6N1Og?=
 =?us-ascii?Q?vf4Vo7HkEQU6suLr26LrEfGqlHBjRQTFcM6U3sKAi7NlTc3u6315K4Vnya7i?=
 =?us-ascii?Q?se8l2OsiPhOT+uy5pAcx5KEX8SaPu92zm9nXKjRmMrOx6A1/ECb3PI9FwHsc?=
 =?us-ascii?Q?6KPg7ZUztes+GXXFfbxK9WDyeiyPv7s0zZTiKjUPTLNUyIcFlsF9YvDs6pfd?=
 =?us-ascii?Q?ojtBFF0bCNlThAnBCvFFizv3GSeXRHriRRLvBZbcnpkf3XHVbOGth9EHNAvr?=
 =?us-ascii?Q?fF1qFhKvYnldu8EQNOU2g2ytOovzHx6Uu8/q53sILUzddQGWe+HN/e+I32ox?=
 =?us-ascii?Q?vLo/bhAabeMz2NPHHCWWwZZCUphvoJRJkyQFncUoxJsCM/P4W75UmzbkKcwK?=
 =?us-ascii?Q?kjG7KUl97g+MI63D67+VXSaR8EWOtIO4SKdsNoo2J6Q+CD80oOwnX3/Ckq4L?=
 =?us-ascii?Q?fRkTsv1ccVGa+DB2VtAjQRs64Xpt4X3aBflHKfnzq9SxFpK4YLRXnjsF1dmz?=
 =?us-ascii?Q?qFhOPUp0cVQD2P34logqq811X7RstIzAUyLmRdMruACd0ib4IVbYmh+JwcHk?=
 =?us-ascii?Q?QookBCAzu+9Q2D40C3x1enquj8dd7SbLWtRAkcZHW++srg6FA7YJ+oHD1Mti?=
 =?us-ascii?Q?uVqE6pcSs7J3jVwVJ3FIZVX8CM7JqdHVWc9hhETDYaEvo/ONsw3ydVVWG9wy?=
 =?us-ascii?Q?TIzsLVQ6mgUMUiCHf0cte3+IeE+yPBYnLRIBhVkWeOzZLlQTWymieiHuxt2g?=
 =?us-ascii?Q?8bHwj4A+lihteCjOsz0nhT9/amVaBS1QkymM+j2PRZoQ7nYV9uyqRz/78qZX?=
 =?us-ascii?Q?zvjKF9SWJqYLxFGoTMf7Oj4tjAmOt0R1pJLKxkCz0TWiR7j+okhW1VhQN28L?=
 =?us-ascii?Q?XpP3k8+Z6lSUE48Mi3kV3Rpt/FDWeFZ2zNzG770nX8MeRz7xfmBvNqDYYIoZ?=
 =?us-ascii?Q?0vLntzxwWji1jxoBNnoENnHipWGVaoTvzDKNjqHYBp9fexj+u+8rlyiKECgI?=
 =?us-ascii?Q?8lsYv6xRv592TXvzV9Jbo9dsV7xI/oncIX0f41Uidw9LlSjeHdKgOYVphAj7?=
 =?us-ascii?Q?ni9dhajZDeODRF9lcMQujCLaKl/Gc+OkoCQmJiaTdRZbdie4z9KwQSbuBptS?=
 =?us-ascii?Q?iqDVfxBAaWvQKHf4vqbcOmwXhJRxscZatCHhnETz6/j6dURN4kWeZXOWd8UJ?=
 =?us-ascii?Q?WbnHcsaVMn0tRvc7cBKQH/HWhaJ+xlMVCLmgSRNN4HrMw/9Gj4qRvI8CJDxs?=
 =?us-ascii?Q?5Io3X/deudLDsvbKk8d5rfE//8QWUnzR4GvuszT9PL/vg38Z5OiPI16GcdmC?=
 =?us-ascii?Q?jC5gTl0cAxYsJz6s+qGagutgHSsSW3BQwU8mpQGgNrx0cDYPBVbk+KDl2I04?=
 =?us-ascii?Q?eGs1drhNEunSenyOFrw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2bda01e-b577-4f7d-7262-08dace4f9024
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 19:10:34.3485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jdx9o0np6EF3Vw7YdXooBMT9vQt/IwWJiLnRIuN9AAsjVPIDNhefVxDgdndoGoxT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6487
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 31, 2022 at 03:27:55PM -0500, Bob Pearson wrote:
> +int rxe_add_frag(struct sk_buff *skb, struct rxe_phys_buf *buf,
> +		 int length, int offset)
> +{
> +	int nr_frags = skb_shinfo(skb)->nr_frags;
> +	skb_frag_t *frag = &skb_shinfo(skb)->frags[nr_frags];
> +
> +	if (nr_frags >= MAX_SKB_FRAGS) {
> +		pr_debug("%s: nr_frags (%d) >= MAX_SKB_FRAGS\n",
> +			__func__, nr_frags);
> +		return -EINVAL;
> +	}
> +
> +	frag->bv_len = length;
> +	frag->bv_offset = offset;
> +	frag->bv_page = virt_to_page(buf->addr);

Assuming this is even OK to do, then please do the xarray conversion
I sketched first:

https://lore.kernel.org/linux-rdma/Y3gvZr6%2FNCii9Avy@nvidia.com/

And this operation is basically a xa_for_each loop taking 'struct page
*' off of the MR's xarray, slicing it, then stuffing into the
skb. Don't call virt_to_page()

*However* I have no idea if it is even safe to stuff unstable pages
into a skb. Are there other examples doing this? Eg zero copy tcp?

Jason
