Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D7176A00F
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 20:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjGaSLZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 14:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbjGaSLY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 14:11:24 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E32E7B
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 11:11:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pa7X7WiVwpvm71EIiQr5jM5cGt5MY4KaOSPtEdrOqcHTqH9fyw99V4/t+XmEzlqqmbdI0CzN2Mahf6Een+Rqyw4XLDyRNfph017W40lb5QB9g0T+TgLDWjIhaS9WaTvqr+92/a+6vd9eMLNJ0gftpk6mm8CCrIclx4NvV2ugPE3ggeCQhoe69zOCn3wu9tmqLyb1/aagOYKwI+daUPtiUPaIP0k0eqzcHL1sIQrDbAso6Hd3yXbCXuzsAUWS6M0fu+DVZcZra1CgY7+fDfLYbXpoHFwAOG7drJzwy+Uoz8yL6o59lu6ySJLXNKymH/oiRsos36aBglpGaaB3sdZuNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLbC+h7Q34vqtTGxRApo90ZxH2USDUf62dw5zyCzEvI=;
 b=P4ob9/X9d90KqVeud1UAXhW3W66p0R5N8NLysSHpBMx1CYo6GMAg1wC2bxZCWYmBn+sGzKerNkYX0oVN+4tUJeZGncXSq8/pVJtO5pFHQnMtoi2iDE1XXOzVXFAytrl1stg7c/kmWTDl4sx66Sbywi97In5hYQQlVrdelYP6wk0EiAsmuBmCuwSbEVjSlSp1xWKAbXgLq4v95kvFhFLVqW24Vclt9tCOcrWJspLhLC6Bbyn8GDGCHMoYFpRaREXtNlaAVG/rBLMUr2NfeRvZSc01bcSo2Kx3/xbTb1yiaxMhfhmSUGbV946AReQPiws2cd92kiYR45uGd4wPGiuWkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLbC+h7Q34vqtTGxRApo90ZxH2USDUf62dw5zyCzEvI=;
 b=elKuuABO9UT48vIYiM20NF8xOJDR7NTn+rG8p7HwnHRW5BvpEAccj/GNTwDS2OT9ZSPyGbMiuINGAamSFDYXegyIQqw3wIjW9KBIC/GgsZsaPa8x6Nbh8UNywQLgdpqwXjssGWSs6cxDZ6bt+Bxi8ksQXh5JSJtBsGYXq45ELrXHuyypEmC/umF8C/9x2wfmaQvwqmthPS4apl5Hp6y6TKO39TXlvj/hu6nStMmlXUQOVocA3Lw7QUMe8Svui7vgVaV4i/0Y+Afz3QD3gV0eN0TlFkfYWmOF9QXG+/sbVez0Jog8mXfYBZjsth7hJK5dKS8pBFTs5JjS5u325IS1tQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB8170.namprd12.prod.outlook.com (2603:10b6:806:32c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Mon, 31 Jul
 2023 18:11:20 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 18:11:20 +0000
Date:   Mon, 31 Jul 2023 15:11:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 3/9] RDMA/rxe: Fix freeing busy objects
Message-ID: <ZMf5RRowWoO5MkD5@nvidia.com>
References: <20230721205021.5394-1-rpearsonhpe@gmail.com>
 <20230721205021.5394-4-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721205021.5394-4-rpearsonhpe@gmail.com>
X-ClientProxiedBy: SJ0PR13CA0134.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: d082f72a-66bc-4ce5-20db-08db91f18aa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7sKpdxFjlUJjeJ2T5p8oDLTmaiINZj0fgSMkTvoSBIFTgvzz2eau3SCnSJu+vPlRCetLQa4kbW7cJIcWPjcjWZkz0svBIiXqpuguD9C0W191As6pdLYD/XhWyy/RWyD2S2igCZtngLh118/ZjkCMtOhKr6QeAzQnvkJQxyq5ouHrUOP6/GuMMremZRRaNwSov2yGMJj4b4rpjjSoxpXTCSssXecdJKZ+6Zpse8IpjfNWtHJSX6xWCqJC+lAxIhKQYfXdi4ZPF555pdkppR86yo15JxTc0Rh12PQu3w836FnA52HfFY0pRu/56uRCWubJfiovF78mkpHoDYQm/1o8wuYAENlBjQdcay+wnlO85woLSDYlpw4kxNeLjS8as+zm5iDS/KxHhQEbMn6uv6r2tmTOaAvgJNFtu1FklPh+m7jHwm+JJKVogoWl3EVL/8K5lkpvvfR17Fb27TExbHFXzAw9xrIWWiCMff40ko5PjUjVTGORW3G/PZsqEJhlntUWuH1F5hBoZoTSE0M0bgAyZYIcMXlt2dEN1uPklq5EE4pUaBLHATGyvi7Gp9NG7mvx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199021)(66476007)(26005)(41300700001)(316002)(6916009)(4326008)(8936002)(8676002)(6506007)(478600001)(66946007)(6512007)(66556008)(36756003)(6486002)(38100700002)(4744005)(2906002)(2616005)(86362001)(6666004)(186003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U+P8eLPwAZcYAGY0jgYUFxQD6PkcDXhh7VvDF4tuCEMpUe42l8NDyziybJDc?=
 =?us-ascii?Q?q3iLl03MpP/M3SjH0rxhj/eHjVwMceZKjYTRzYrbZfD88LukoRly0plylSOm?=
 =?us-ascii?Q?sQQOCplDkSRsM+ZJMgC9cD/uYUUrNx/5uJitRoy6Nzmb9lFBeqxMA3MMNN4K?=
 =?us-ascii?Q?kPDGSeOLqzDTpyzGaizWSWPTau1GNKw05rj7IXlWehBLSBok82pjE3uK4Xp/?=
 =?us-ascii?Q?Jy/DktwudO1417ChyIFGS0DW+HBrzIqIjym7gZjNgdEIBb5Ol/pH8nrzJQxe?=
 =?us-ascii?Q?cRJHH2LHS0CpzbD1vP6ydt59NAoZyhoSUXlN97fEKQGKFMz9jgjUkaCAoHFz?=
 =?us-ascii?Q?lbvKNKlOw5uDXeLxTW4K9Awnp7mSQjekH4bFlNSShDoAEiAfKQ7A8w2qqh/m?=
 =?us-ascii?Q?diFWAnx6eBCweIWlI73NLqgU1pjgYvXFHmAebTUdBccfd2DoQnLRoTQj2ej9?=
 =?us-ascii?Q?dUaMrzzPXHl4SfFb/djWAVTp3ZMWDfgUuTTWbVeazB5+U7naFxrvlfhlcB+x?=
 =?us-ascii?Q?4fERHnalw2tk2dLJvEwRRDhJoi1SubnOzhvRvOfI8m4/6NZWvpJ70TW5Dh9H?=
 =?us-ascii?Q?Dhs6UkivaYmtqGGqfKwgfRIJksAqhaDxdicbobDOdAVxuZNvWxnbAPEBIS8C?=
 =?us-ascii?Q?pDkAmzo9uAo8GvsyQyl9w8D0F8CZvxKJFwi/Eb6irStLgo2g6XAAK8+XzpiY?=
 =?us-ascii?Q?NPfkgMAdcyaXtmaSy3U4rvfIXpawxx5t14DouKF6D9e555kwQIUXeUPIy+ng?=
 =?us-ascii?Q?gGhObbdm//Op6XqWN3xovgCbbIP4FpVv0EEM1NDb8HS/XAOnw9MRyGfI8mtK?=
 =?us-ascii?Q?R2BXdtyshviQCfpnb3p4RIIQF8Kj0ckvljraVqAjlD4fZNEkR+J194i1UwVn?=
 =?us-ascii?Q?vdOPinREqk30xm4wV05lXj0s7yq6yaJrr/K7gKlk4iyP6yeIPqXJKuEloOP7?=
 =?us-ascii?Q?/kiSny0HsoafFqJR8HGEojD/QtY4t4zikr/UXsaXk0NVfqTneSBQOKmJhPI3?=
 =?us-ascii?Q?LkikmDHcldXxL0cQoIzG+IZVYeoJB36RQxFYmr8XgJws/ZcKlCYAQ/yFCLd4?=
 =?us-ascii?Q?rfu0BNBTLWTApNkh9jYGfAALE7XSBnsCEkcx8Vn644ea2PVwMKAlL5LxR5J8?=
 =?us-ascii?Q?1yFoMu1L21wlhGn8bQbKmwdLgmndMxfygB7DuhZkunRlojAP1L7jzhf5QBfx?=
 =?us-ascii?Q?gtjiyPqTf2PJ4x0Mz5YYN79Y7V5xejGBNqZHL6P0Lm9tebYYy0cTbSC0mRmv?=
 =?us-ascii?Q?nGtUFQLlKO1gMFNAA55V8+vGjeVu7ds/I86inbhoumOYaFIVwU05lfCm2Kl3?=
 =?us-ascii?Q?He/znHIpJjzjUKt+n60FacaVOAjwHu39IVkvusA530neGOlBm2Kb8AmZ2mR6?=
 =?us-ascii?Q?fA/0HIoJ0NwxDbnEVNVe9JYJg7woXiLp5KP0zeNLOPdABkTHQuhHvLAGfSzV?=
 =?us-ascii?Q?W7m/HAzi5b87lvSZ/IgY4Yf2yHHqqcMkM1zlMZfOnbVj4t5wINktxC7IpLH3?=
 =?us-ascii?Q?It81n07BudoEyhyeCG5B2SFNiXakdYKZWni/OELfN2u6R7+MfCMx0D03gMBY?=
 =?us-ascii?Q?X21+7UB7uwE+Zgu7+8QAe4/p/bFwHEV/7V7kLRZV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d082f72a-66bc-4ce5-20db-08db91f18aa1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 18:11:20.3292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bHgLZVECnl30BpxfHUEdnZP6CMWZ8lo+Lh66h9WDyUQEdSFvyGADQHvYZ8HEGI7M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8170
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 21, 2023 at 03:50:16PM -0500, Bob Pearson wrote:
> @@ -175,16 +175,17 @@ static void rxe_elem_release(struct kref *kref)
>  {
>  	struct rxe_pool_elem *elem = container_of(kref, typeof(*elem), ref_cnt);
>  
> -	complete(&elem->complete);
> +	complete_all(&elem->complete);
>  }
>  
> -int __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
> +void __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
>  {

You should definately put this one change in its own patch doing just
that.

Jason
