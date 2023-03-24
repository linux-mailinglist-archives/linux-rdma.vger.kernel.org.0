Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1C26C7F5F
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Mar 2023 15:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjCXOBC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Mar 2023 10:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjCXOA2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Mar 2023 10:00:28 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20622.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::622])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2CD1EFC0
        for <linux-rdma@vger.kernel.org>; Fri, 24 Mar 2023 07:00:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvEv3bFtTglXPocgUjyyTCJcqmYCC9lUbs/CUnhEtojgnf0XjgwoVSVRmF+eCDo9Cqbs2ePnvCkI6xs878ZJ1u5slE0vpUIetZyUV0W1MWAi6nsU5ottdFKcuWUBaZ+d5ggeXcncPlCXX2LwbflEocxAdEDuL4h32W+uvjBsu895hi3WAqW18rsHJZqM1NWAbeQtVamxBaew9mTXKVc75X8fR2qYllF0oFgR7vnoKH3m4v+URNIbj/V5pgWwOSj1HaGSqOkuf8dh5Hgx77MQBddwYH7Qsel+tvySm5tlhE/MJ+849fJj9oyIl/1phvSL48L7FSfUkVVNwe7mxzaDAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBwr1QMmZS4poiZKJUSu7o1q7R1TSVwf1yQUsDCuteI=;
 b=i0HqbG8Kr0C4i28HhYZ7hIuDd0MCELYEZt9jTB0ABb326fa34SCOoDxhmcFX7YsSd2pLzdoe6bPJRhVhrqDU13iZgP5dIhsLxZfiOW22Skj8r03AOoInJTGNUMfz0h0u0Ce9A2EKayIyLpAU7aV7m0b55KOZ/ys3hHOHLuZgRvUI0vjbtLS01Oh//EWDAn/2E93/gujFQuvl+6MWgjD/fJyMlxrNhV//lVtTpnP6CpuMCkVoW/9F5u35yAc2EVvbltkhvKMOUPyjBDJfasjAXBpuu+N2zCDl0L9jG4/vp5HQdh3ZaJ5CSQsvzdVQFjquOIZJjbWRpWb7jyG0WUOA4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBwr1QMmZS4poiZKJUSu7o1q7R1TSVwf1yQUsDCuteI=;
 b=ffP08Xv11VfHgT1pqhP9k1GTPxVYNM6iMvccj6jZ61YkQsUpat4RS283chQ/6AEqdbgnV64k5eyoiN+KMq9U23eW0J+qd+dQaAOFygzhR9Nf+rz2K2tUjUVqIsdi2yJaIc2GAfK2zEVXW+8Qda/PLoKPnMLl500NiOpTWN3Z3s+tV/cikmq3Txba+84GY4volMqYW0mIpDwn4mP53UCYjFW2wXQnR7E8G23MwHwYTE0H6G8BiQ+45N0Z68eWe4tyEk17jW03Y8hhQXCD5iIKHBuyqTtHNH8VMs9CvFeZPOPYKuHyQJg2axSNmMoji33bWj042XCsFJyQSqKdhFbzRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB7735.namprd12.prod.outlook.com (2603:10b6:208:421::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 13:59:58 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Fri, 24 Mar 2023
 13:59:58 +0000
Date:   Fri, 24 Mar 2023 10:59:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Bernard Metzler <BMT@zurich.ibm.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/rxe: Pass a pointer to virt_to_page()
Message-ID: <ZB2s3GeaN/FBpR5K@nvidia.com>
References: <20230324103252.712107-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324103252.712107-1-linus.walleij@linaro.org>
X-ClientProxiedBy: YT4PR01CA0325.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: bab8d81a-7897-4eab-26d3-08db2c700dd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bruf9ARdADNtoMCNKATPM5kRjVkqPHWm2MqLGrt54IffG8y8Rga01GDqj0WsO6Tsk8jqb8TZ3QhspC8MWKWPAhz/nZqnmo/Azak/zfOb6pnBWb3mjlbvkfdiK+JiTZESlf4T6+Bd74ff4CiC3dAhmXak4Wv11h0KBAH6x8fOaUbzu57KOoUza2LvfhxtC4SlGgUTG0aKWfP7tZJOCLo4zxJ9+pg2ew8PJofO13+PwyvutxkuI0xjBys5Yd7383luyUFZa3jnul5xk4SQ6ClE+cpf5xdFPG/Dh3l4/vXPxN98MweMToErCdagCeE8uvvNO5wkL651lN8A6u9FoCoJLc5WPUT0ffW7y/Gs2PB5JYJyh2jN7kRKZ8RUE5YBMqnJ6RxaUg7uaN9fMS0iNCMDhFP0/QVvdEwvpzD+RXP23pRKM8gqQdPp+06WKW1YAA7TmzGFAWm6Lr/gfBeVD/pY0yHllKetGlksEkQv6BJMJovUh0fCYzKFHGGMQUAQHlj6I8Twt+c7rXt/w2zrBmWopEuhPKJSkxe5YEtJxVNhafxZq+YnhxcAKWr+VmMqcSER
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(451199018)(36756003)(4326008)(66556008)(6916009)(8676002)(86362001)(8936002)(66476007)(41300700001)(66946007)(316002)(6486002)(478600001)(54906003)(5660300002)(2906002)(38100700002)(83380400001)(2616005)(6506007)(26005)(6512007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qYqTLr0BrlwAubQHwI5OCeo7xla6+k+CAxwVe/G6Aaa9SmABHUuzO+CeJxcH?=
 =?us-ascii?Q?j8RxG9oqKv5lPAmO7ntDvgnxQlMoCy/4I9JYvmO9x5TzbE8n7feDsHWCZt5/?=
 =?us-ascii?Q?MMhbzsmMmNmkFz8idt4acuIg6F1qgu/xsAciI58R6bK8VcFDAXpywYQNYVkx?=
 =?us-ascii?Q?0Y/+fVGZDkoTblIZ2fXsCbE/FLQo3mqMTGvFKZ9/xx1ABiSnfoEsJLRPQxsB?=
 =?us-ascii?Q?hUg69aE9VsReh67UnhTLGFVaA+6vX+jlyMB2mEMriusIhGfQQ9Pi9/wKMZCL?=
 =?us-ascii?Q?Xfaol54R8LM19GBF800YxwmKsX/Ges/s8MkhopVmrhSAHzUZpi6Ds2ihh9qi?=
 =?us-ascii?Q?nECAilUOj/rJSDrDr5X3bF2oOrYiXGZMeEhyB311IZNYTPLUe1esPHxf+xSQ?=
 =?us-ascii?Q?siXLWyJxcRQoSHFAxjRcwFcbMMQ3leCVGQrZ+LhGuWQjbu39fTlFg5oTGsF9?=
 =?us-ascii?Q?LxZwFj8ASaxW4w7G3PgjYGNGAeOJw4ARf22UzOV5wXx4S2csRqGlfQK5LokY?=
 =?us-ascii?Q?SvtiJ8mTdXA8DsWxvAZ3QK5BNupiDLKfkngIKWiZopVYuqyQFvJixSAgHqIN?=
 =?us-ascii?Q?KjXmEalF8E9Yz/h+a8DvgUv+uG31Mya17kNBUUb0JkpbIRpOGAoqzUml1Y5+?=
 =?us-ascii?Q?+SuCKiGEsWg/y//M56WCBJwKXoBcOtTmDzzXsxrkyLVWgqPlQ1InrphcKWF+?=
 =?us-ascii?Q?ZIEtLUSbXBa3LrV37ZViKwDSLDEzJAZR1XFz4Bc9jLaJNQQry/IL8Af9QVhR?=
 =?us-ascii?Q?YvF3/D4gkQK2Q0DxY3p1uUuooMmH3CZoDeZvYwxa6JBNASv6L/euJ0TgtHJX?=
 =?us-ascii?Q?3PV4pqJSElZVj3P/aeRXwDcaRJ04D4mglQyK//2Ms1MvvR9fqKVKRokAKbBJ?=
 =?us-ascii?Q?10l3RgJGLm2heyHWjOu6MKbtMDtAyrvLQE9/S6ybrnKsMwOHlUUkj8XgJ0q/?=
 =?us-ascii?Q?jk1Qj45CnQTS5wOuiBXpNx0XqJxahJdVQBR1GRbNXJMJ8WCVCW2TrsEIjzcm?=
 =?us-ascii?Q?bfWir/CXB5pSQ3pq5AKK1nmYzRvCIFncY7w4W9O1kVFImpIYrV7IHLXByn10?=
 =?us-ascii?Q?Wurt5EEHjJKbUZJlulQVN50G0FHDnccZHjCztnzBCT2B+zwIyTgu9wg+XdVh?=
 =?us-ascii?Q?pPMrbVyJcGxvSomt0nnv+t7tPPtuvJJf4oxV7NHM2TrDqyyRZQaINaOw6taf?=
 =?us-ascii?Q?duHyQIJLoepcX7744zcQm5Hk0Sa/cK5f8aL4gNzvs4cDyqyfbH3fJSOHnboJ?=
 =?us-ascii?Q?hHddCVSHPpZBtT7dMicwT2MWrNhyIHWsndTl8EpAyN8jZISWvPlOHEGswZnl?=
 =?us-ascii?Q?4o6iAsnJwUmDFPVI2Dd/Ey6vVi+IxXi3TRbY8vf13qi26TxkDUfIKfDUq7a7?=
 =?us-ascii?Q?UyN40jIKcuxRWtlTrS8HGIEgIBLmZG9kumUBVewdsJf3xe4QvmRpsvJKAFAq?=
 =?us-ascii?Q?seNOl3b9yegguNhmccal/UxZAOfEcUH8NKebriOJA6PVrZ4PFRgdo9xaAQZ2?=
 =?us-ascii?Q?TNqgjyfuE1mPAGVlVxPo65VzdCMoai6/Wq0i4fwSzjQnphnwXlaloUg3vp8Z?=
 =?us-ascii?Q?0o2R5fuo9IpJHsHO6y+/OhjjYxoKaAlkxm8qLHyR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bab8d81a-7897-4eab-26d3-08db2c700dd4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 13:59:58.4586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YIZYB8OBjACaBZTPtntXavqurn8zPZhB2rnxmP/j82j6i9MxeALVScqlUPm0xvv5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7735
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 24, 2023 at 11:32:52AM +0100, Linus Walleij wrote:
> Like the other calls in this function virt_to_page() expects
> a pointer, not an integer.
> 
> However since many architectures implement virt_to_pfn() as
> a macro, this function becomes polymorphic and accepts both a
> (unsigned long) and a (void *).
> 
> Fix this up with an explicit cast.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/infiniband/sw/rxe/rxe_mr.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index b10aa1580a64..5c90d83002f0 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -213,7 +213,7 @@ int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr)
>  static int rxe_set_page(struct ib_mr *ibmr, u64 iova)
>  {

All these functions have the wrong names, they are kva not IOVA.


> @@ -288,7 +288,7 @@ static void rxe_mr_copy_dma(struct rxe_mr *mr, u64 iova, void *addr,
>  	u8 *va;

>  	while (length) {
> -		page = virt_to_page(iova & mr->page_mask);
> +		page = virt_to_page((void *)(iova & mr->page_mask));
>  		bytes = min_t(unsigned int, length,
>  				PAGE_SIZE - page_offset);

This is actually a bug, this function is only called on IB_MR_TYPE_DMA
and in that case 'iova' is actually a phys addr

So iova should be called phys and the above should be:

		page = pfn_to_page(phys >> PAGE_SHIFT);

> @@ -488,7 +488,7 @@ int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
>  
>  	if (mr->ibmr.type == IB_MR_TYPE_DMA) {
>  		page_offset = iova & (PAGE_SIZE - 1);
> -		page = virt_to_page(iova & PAGE_MASK);
> +		page = virt_to_page((void *)(iova & PAGE_MASK));

These masks against PAGE_MASK are not needed, virt_to_page does them
already.

>  	} else {
>  		unsigned long index;
>  		int err;
> @@ -545,7 +545,7 @@ int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
>  
>  	if (mr->ibmr.type == IB_MR_TYPE_DMA) {
>  		page_offset = iova & (PAGE_SIZE - 1);
> -		page = virt_to_page(iova & PAGE_MASK);
> +		page = virt_to_page((void *)(iova & PAGE_MASK));

pfn_to_page here as well

Jason
