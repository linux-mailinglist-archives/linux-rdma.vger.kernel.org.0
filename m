Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6CF76A064
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 20:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjGaS2K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 14:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbjGaS2B (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 14:28:01 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E7E1725;
        Mon, 31 Jul 2023 11:27:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idTQD3aHpZyhnwX3wUQV9MfFrcOse/0QB+87p2qEC+Q/iZ0/z4zdntmezvnpbYQiFsE8bUR174UrwZkZMhCqC0SY2P+EKtKRChwqxC/TlKsQ7cLcNIX8lqKcPZ8I4k6GCCyaFu6G8lnyFWpksKS9+mPDMIc3HPP435+MHX1Gmc3GVQfXPkrINdbXGo8QTmU+m40WQtYsU2BhQ9a/UkPZoyS0fxp9l3S2v3k6h6xfmsB6qr2G5J3IrFU807dOB2a6/H+EffoCvEUJZMWL5O/A8dAq/ZYMEAf7/1TeuPgp6HILRH4RJjb6u9zjvZbPKtG2ppI2y9/bRMrGO7APcMJx6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DRxDl8YvrdwjMLt35tbwqseA5FIwOqc/u43lVEhD54=;
 b=h8zohfuyI6gHc7wAxm+62Gut96+IJ46Ri9DMln3kyCbN6pclaWaz1UFw5XfDEvWtfesE2IZbLk5LHfTy9l3Po7xvXonRqXpTlala6fsNVhd3Zr6IRUM7G12v65X7LRSthSL4FkNpzgVh3krvKF4d98Y9xTaPXFzSU2Uep804SDbS/WKYQspUmM+s21ElyY5zc52IJBJBquHRuXx0vwRMYv18VFypWJWDHv9aW31Yw/Kh3DFsY6rjQJ43llcKDC0ItiJlpc9ufXEAmHaMZ4HXowdoizEbqIu8udBO1CEBFrBIJfpPRysag6RT6BAsoQ+vPypB/fty+6bfX6G51dW0mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DRxDl8YvrdwjMLt35tbwqseA5FIwOqc/u43lVEhD54=;
 b=uq+aR6Hjgz1nSJxbTrmhB2IPXSFMQWm1JhbEvwNjiHUx9C/rW+VGY+Fqh/LGCb7l2Nflt40SRfU1fI2lrd1DNBk9oPjzlzqaY0NX8BxPFKJdt6xvpM58ZF43j9tqluwwIGhCNaiOzDjDTjyqsZurvACkwIEcoD3mMT1DCDWYbEYByyMqsJvrcIv9KvCqKyTtbYiOUfyjzFLQ3lOubrq8KWeG7aNcjQKfa5us/jucss8TwHcTvDhlcRaNhDT19WQNpFFMOXaNfW+heaEXUgkMNwct9NgvNI1bPUBjXZZGqmtR8ZKjx5pgqpwSB0TyDS2+FuuLkXuunrBp9YBXKE4vYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB7409.namprd12.prod.outlook.com (2603:10b6:806:29c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 18:27:56 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 18:27:56 +0000
Date:   Mon, 31 Jul 2023 15:27:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     xuhaoyue1@hisilicon.com, huangjunxian6@hisilicon.com,
        leon@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] RDMA/hns: Remove unused function declarations
Message-ID: <ZMf9Kq4bCVXuMKK/@nvidia.com>
References: <20230731135916.32392-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731135916.32392-1-yuehaibing@huawei.com>
X-ClientProxiedBy: BYAPR21CA0007.namprd21.prod.outlook.com
 (2603:10b6:a03:114::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB7409:EE_
X-MS-Office365-Filtering-Correlation-Id: f89ae24e-deef-4527-8ef9-08db91f3dc88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HfgncIf9vuDK0/eTaD/VqZ0pmG7/be/LickmxKUsSOo5iFWdq9XPHUhDUG2QQBzVHHfc/eD/TmXuOyIctO7qRSMmAZ4Lf3C8BxaWWbCeMqy7xEH5W8LSv95J5bQP3s++e+xU3uVpt0fw2NpbKhbxZffRCYuc28qQfedSoBVJEy7CdGcefuFbSr0voZ30n3WJF8aR1ULJsqgdXB5jMwII/ovIFJJqUWZ5sB+wKeUPPGkuJr0icTEjLOFnh+4Zs1k7OM5LExYf5TcCWYF4X5y/vFj7i36PZ6rLsEVxBLSnj7qLBtCRwi01P6UfxhFwY6qJO8MsbYs8sJlGYomM7VputLAtEX/ZS3W9qvwnc62IA8MQPKUwHDIuGK9pK80Kv+fahQCY0PjBVrNGeltxV+i7Qi5uiL26vQJBjA709TMTLV51bqcV4coPFSONsyi2yfli80Ahmmt5LplOaJGg1IIVXPDGVS31DDmiEUtBdGb1rHbcBz9w888vnk+wiOT3F0J/kHC6edFzjyWbtURCcMsvbfu4gDt2Hem+TYt1iEtiCSbV35+i3E/9R4XsQgfRut8A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(451199021)(6512007)(6486002)(36756003)(2616005)(6506007)(26005)(83380400001)(186003)(66946007)(66556008)(41300700001)(38100700002)(66476007)(86362001)(316002)(5660300002)(6916009)(4326008)(8676002)(8936002)(2906002)(478600001)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7AcpWoH1YBYKhodWKQp94ryFqXIMEdIJnK3TH5K683xIqtmhbHVZwg0s7xDp?=
 =?us-ascii?Q?2iwssG/xH/isGFy4eq7G9G5s7q37jpOI7DZunBNb+C5IAFLEzk5eYToXfcwu?=
 =?us-ascii?Q?S0S/fN4/Ayf1FzEG4QmZppqkInqHkyzWDW/YaoelasezfQMXKA2r4it6zfEL?=
 =?us-ascii?Q?klm2uGtPRqJl+t5fFk9t5Eby/ZfiFLJPbVkn4aGaUOAmLsJVTVaYH5jTO3nj?=
 =?us-ascii?Q?Vy4OoA3V4SziCd+MYIwSvPGJkJzmZuYUEnt7li9suZ6AtWeOzXpnXLFeH6B+?=
 =?us-ascii?Q?SrZwPIvYZOcWyBAX/6QmYFnivTVeYy4QS379qIcFFuzGTR9pVQgRNp7MG/WL?=
 =?us-ascii?Q?R+sVyteUJLyZOrEk37ByS0fsB50JjGR10f19n3Csj0oVdOHvKCHE5pBazClv?=
 =?us-ascii?Q?Nr8TttKxGo9jyE7rBy3ix3Pu2Qf3DaHFyHi55ZfdJWUgb16qUCCtBo2z3dqv?=
 =?us-ascii?Q?eW+qGdtaaxJJJ4NKHG4CL60+mVDdApFkZiK6XMGv+nRZ4tJZSqcCKUMJVKwL?=
 =?us-ascii?Q?mnCkYJ7dtuQ2TwG3uIEjjHxUYzSJV4lGpFB8xFAPauD05jwW2iS2Dz9k+FZY?=
 =?us-ascii?Q?sdkCapv7R3ov6aNUr2iJRSaztImo0H00fmQC5UtVcswjxker+RmdbuVpRRrn?=
 =?us-ascii?Q?QaNRJ+NmgYjjbw6GF/RbLxR7nqPDMWIXdqXFvGjFTFrPWrmDBj2vaoEQYFJa?=
 =?us-ascii?Q?bfFaJxZrvl26kpe0vU54FKVkNgfX0a0NtMmLstU0HbXzTclUN0V02MGzDkQM?=
 =?us-ascii?Q?9PW+XfJ1h+tYsxx3uf+weOfF8YuJ8KbgmtAxGKE6YK1xHzjrTc7uj8/P4HYB?=
 =?us-ascii?Q?pAJTX7KDcnhqm+k/zxEMuZ+dEcoj1kvet7DdDzxHjInaCBrFqx0TkU51H6FK?=
 =?us-ascii?Q?tBeoQ4pZxi7Aucb5QwfAbeVALTBDle5WhQAN3cLaclZMpoGcLZ/SCQjRwOpQ?=
 =?us-ascii?Q?HCJk06jpOqKrPXsVPQmsjx1NqN6GZfCN8AAx3ne4n300CoMLnKILwyeNnL+P?=
 =?us-ascii?Q?gQQ4Mmy/fvjT/RONR2gI5CPLlB7imS0346l+RQp2bHHo/ptDuCb20ggsyq/b?=
 =?us-ascii?Q?Az12VQ4/co/DU188nyup6Q1mVEJGSS085xES57CN6k3OHYZkj37XlBWl8asQ?=
 =?us-ascii?Q?VN08eWGpzCs+nZH1OiBluoSFELW1JYUxM/WbaKhu5aqSohc/7btFcCFfPegg?=
 =?us-ascii?Q?T0GzKL9eqzo564/g0kDEpQTabDvkSPGs8IxLBslqyCPw6XckMicaB32ar3k6?=
 =?us-ascii?Q?4L94fijAnQaIqP6YVW5KY0LigL4tgGzyc56KclsnrR4iKmuMqQn6q2eYsWYw?=
 =?us-ascii?Q?qUu+8B+NDIAXHMXsglukvOKJn/akgx7mNaK3JPaGM6Lp/rtsgYCPy0ToCBiK?=
 =?us-ascii?Q?ONloExY+cx21TevNXI8aAmnK8njg9UDq2nj9pBjtz25eIEvWcsemZkFc4o5q?=
 =?us-ascii?Q?D8vpiVfb7JS9VtNAWkIvzfuhOeQ1vwNgdh3S5699LUnHiIZlsDVlmzqh0Qes?=
 =?us-ascii?Q?uClX7YIptvFD2n8V9datjelN6FekS/h2j56IEFB6+havojbOfmtayjaTWPWP?=
 =?us-ascii?Q?klWqf7S+QQ/EQEaQ9RMztJzcyvXvkOXvBcdbrpt+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f89ae24e-deef-4527-8ef9-08db91f3dc88
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 18:27:56.8171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OmrpdrdEqnW9Rgb/pXZgbOpadB1im63UgJTzDaMTagQzI2c159lI/B3P2psSAsuL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7409
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 31, 2023 at 09:59:16PM +0800, Yue Haibing wrote:
> commit b16f8188472e ("RDMA/hns: Refactor eq code for hip06")
> left behind hns_roce_cleanup_eq_table().
> And commit 773f841ab1ae ("RDMA/hns: Avoid filling sgid index when modifying QP to RTR")
> leave hns_get_gid_index() unused.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_device.h | 2 --
>  1 file changed, 2 deletions(-)

Applied to for-next, thanks

Jason
