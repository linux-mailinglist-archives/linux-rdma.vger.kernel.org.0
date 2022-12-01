Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8046B63E665
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Dec 2022 01:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiLAAWB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Nov 2022 19:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiLAAV6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Nov 2022 19:21:58 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A159337
        for <linux-rdma@vger.kernel.org>; Wed, 30 Nov 2022 16:21:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcyliVsQPx+/W8Kl0NKpCLNVHWx8f1SrPQUGnzZIhgtnC1CKek0hJ/kUjP2ADdU5Ww7d5/c9AQPjHUOiBYRLqlVIbZypwxmpoQzaDNMF3HVQ/cP3Ck3/6GZzXqPgEQ49gO/WnlTfo70tnQHgPoWbezb4Jap/1+Nr/HrQ4s2+WMsdXOXNdcLg5USMB0qKJBh5i14q5k6VzDIyudaHx71qqWMAdEJpDtx2MY+3tGORfAa9bhYbFB/6gYCr2XDFZExVi+15C5va4W92LosHFQqPBrZSfKDyElaxPmmmSW9ViOCEt5oDh/lzWRG9Gn3hVNUyXQS+BitC/3HU9KVv33Pouw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feGYNdV6R6xyhOUFbiKXYW6diH4JKIIit7s4Vvteofw=;
 b=m2bKYFRm5TXCAfuCplLqMMJf0jT/or/u3atw4Te2+/ESJVDqGP2qOFaYs7nx0hPihfwIy5HB4IP2Y9Ps4YJIvN9F+ifs/y6CoClyyJRHbqG/uwhYcCvB/LH4ITKAD3OqUdlIIFVqGR8+4QIIIAif93o5KMl+swObsVDWLRGS12vlKs4FiUxsk8c3BsmknnX25H5ooi4YgNN57jjav0mrHNIma/3rndho/NJvN7APFKO6oPfxY4KBBCTtfuvjFeiBmJTwC0C5fK67RL2p1P6j7ce8bXLBWcmHS0T87Qdt7RejGm1Cn2BJCjBw2XKyVVRZbljtdCuUGzpO8TboqKgAzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feGYNdV6R6xyhOUFbiKXYW6diH4JKIIit7s4Vvteofw=;
 b=Wy1N2pPHABiM+CUOqJV//KF5WhPs60yyiRL9Lq5O1GzXZBKUiBFTiWDsSDXd0SAe9gRVYx/RaksaxEBivb7OUrJqeYt9b6IgJn8eXXKJWG3QrD4KcmKVD5nS79EQRO1WenpjCk3Il2uYXNDBVUZjbKfL4kLXalVKDC/4MZG4QkzoksPIv/fyuK+GzNPPUsIBdKvoNpxVQLQWYAk/i1WacCKHdK/DVAPosB7NkHK8SpwO3UIpr3K1b3FL8yydptLmbwuM+32yqtWB1yj1YSJPHPlvUz0VW/3oNkFgGBV5stDcsMRZimBcMgG4X7bDMWQDbUwJxt+FD2t48x6POBwKBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7977.namprd12.prod.outlook.com (2603:10b6:806:340::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 00:20:55 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 00:20:55 +0000
Date:   Wed, 30 Nov 2022 20:20:54 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2 06/18] RDMA/rxe: Add rxe_add_frag() to
 rxe_mr.c
Message-ID: <Y4fzZk7D9GgLNhy9@nvidia.com>
References: <20221031202805.19138-1-rpearsonhpe@gmail.com>
 <20221031202805.19138-6-rpearsonhpe@gmail.com>
 <Y3/Bqa7obMROAtr8@nvidia.com>
 <7ebc82bd-3d1c-e2d3-be4f-2e5c95073a65@gmail.com>
 <Y4fo6tknpuCveRgq@nvidia.com>
 <fd788906-6e40-8109-f6a1-5f281361c68c@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd788906-6e40-8109-f6a1-5f281361c68c@gmail.com>
X-ClientProxiedBy: MN2PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:208:160::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7977:EE_
X-MS-Office365-Filtering-Correlation-Id: cd3e2a45-7d86-4c82-6308-08dad331e97d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +5hWGEjGxT1/IkFE9a38DNI6nzpRL4ZweqGnyyXc613JMiUNAT9EkBbd1MwMjUEI4pj41y3KofpK38Rei3Dm50xq7tp5ctRUt1YjGbt/+0haAD3RwaFltkJi7Krvi1gHv/v+/f8ePVbPOuer/L4+on5wTSckMAwKG0c/cUmj7m6e4UbcTqeGTFtmVVZHGglFwj6QkGnxWC9LWRUENIrDvzSIyPlUTpSE4/IimlGXw8xe+Qr7eTLtWduMloWsGqb7F98hKNEiNC2GY+GkrMMTVU5wrxmn4Z/aF0DppAslutfIApCY90RLx23GwDDSEVzjFFjgO4YGc7y2Zvn4O7/xsxL7Rf5oavTuRwlAiJj5ZuwrU81TXdHy5a4bytIit19S0XlpEQQzKBRaU9rOehoM+oWa5cT3Um3gq7KfISrmguD26/ziSTDoYegLp+L15opmFL76KF6QQCBkkAfiNmRskt8ecnbxvu1voVg2QtAKfO6di3uE5GZzTj8VknnnRLSVxW/1g9m/RP0gKZ6gYXxZTozBNi4g5Tx/pefQfcK+m+GbAcy+dIyhN4T/TtP5BRCViGWSrVAelxKMcK6KteDWCjJf2op08MNAzjN5virsaj965adng29uUWHDM0oTmQ3rf2ZbYaSXhh8LNdUaW6VGwzlF9W67awgE/j2443Hk0LGVji8/slM+5wo4eOhOMPrFg+1oR97/99t07SIFliafnHNYj1rKd3iqeVXeYr2MkKk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(451199015)(66476007)(36756003)(4326008)(8936002)(66556008)(66946007)(8676002)(316002)(6506007)(2906002)(6916009)(186003)(2616005)(83380400001)(966005)(86362001)(6486002)(478600001)(38100700002)(53546011)(6512007)(26005)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pe8mCdZ0Lic/4wWTyrukHguPQbEfDvZ5AMzzhC8gPfFWcPl6TxgRHnYd1Zbj?=
 =?us-ascii?Q?zJ2vXlnKhsRzmFyxGWtJyv6UyJgp4t0HcWXAaG9BxJKCaKqYqY8Hi450NFtu?=
 =?us-ascii?Q?R4Xq8vu3btmC97OctWRKZvvyc8jqH2/FyvF573WjuRSugHXJRW8wc+tQ0z2Y?=
 =?us-ascii?Q?nuxf+A98FtTzqGhhBqhGPTyGjyPEkU0HHbE+ue8wjsxn0DMTBVUPMl4wLN1l?=
 =?us-ascii?Q?zM8LfGUBsrYHb/FA2yqh7N8AA9pqMDm6giSoT37Cr+eFpCJtecjFIHUS5hnr?=
 =?us-ascii?Q?N35TCK61CGjwQYk1ysDk82kXnbtLHOUNrHDbWOBGTeki899N/4i93uRwVBLG?=
 =?us-ascii?Q?7++ZcOzqyvt2LeInhGMnUTwRlOdL92rjGyBOwaX8xjVia1Y9M3pbE+ej1zLH?=
 =?us-ascii?Q?e+LsIiGDcn10zzucd0QtI8QSA2ii9WvQ2yy7l+iKm6C1ZS/iaGC4Y+1u7yCL?=
 =?us-ascii?Q?3L9oACtZGNBIDVXaeQ/mkbU+iNnXt99MSTRxiANKaXekffeqsYX6pMVv0axZ?=
 =?us-ascii?Q?GPP+o42yTjjlai8QEwSbAZflNJpF2KoHFggWNnT1HcnPqsWkpukocG8HmVAs?=
 =?us-ascii?Q?m1NivKQPJ8hrsLNg9peIlvG0lZRNwcACbwNaVXzg0BdIIWfurJDJ57iIO0jI?=
 =?us-ascii?Q?4Dl26UOBTYKeRoTT+QJhl1aCGWZ5gisKwMTCZzd8g7A/f4ihd2dwCIsBSxmR?=
 =?us-ascii?Q?a+UAtI+aOTIVCTXOasj3bGD8tZz6OAa/fYIOM25Jl1j9yKJKFWEDGCR5226F?=
 =?us-ascii?Q?X6oBuZr3BXzkaI7npTdCSyjI1ABsG4S4P28P5+zqv917iZQLctKQjcO/mdrx?=
 =?us-ascii?Q?MgJQIwF+F/uo2AJfkWICgIezAninivAr1By5nDqiiZIX0ny4xUqRNKhUwW1h?=
 =?us-ascii?Q?vCbvbZM+LCr9hRcfEBrmckmZBHgTcBeoaZpTWfRBYJSuiVV1SOY14386DNpT?=
 =?us-ascii?Q?zK3AkAHD3mN3R0YcXOp51GWYzRn3yNxiInmYUO5m7t4Y2XytlvXH9AwCwWFm?=
 =?us-ascii?Q?XrpnrFde58eVcy4PX8DOakvjrYmfeMIIo2WXQNLvpgmwNI50sxGpebrL7cfm?=
 =?us-ascii?Q?smiVVej0v6Pl33VwZmjU4SX3mwjfxMCRwswLMrYvirVmSw9RuL6qETytDoU5?=
 =?us-ascii?Q?eT82oHR8myKrVucGWJcYSOj6UqRFs2KVP+7VlmkBU2w7ChxfMu4pal9KVnBv?=
 =?us-ascii?Q?EQqk2HM4qxIlip783RoAp0TSPwHrCiCFTH3r4h8msbu92Us3dNNorxBUY4zZ?=
 =?us-ascii?Q?63HrrB1sHIgaIuUeiOAfV/+jiY+pgwGJVOPwePeZlxGEPFYz594StHSN5n3l?=
 =?us-ascii?Q?P17C0FoiEAyKL3tm5LrNc/tINdF9WA9x6ohL7d4W5GZpiDoFzxBM+eAWlCjr?=
 =?us-ascii?Q?ylwKI/91/Ul6Ps1oDYqvBoh3c5MajwF/om4FhqpJpbL7mPXRmZnxsCXFPr5A?=
 =?us-ascii?Q?tnPYCQ/+crzk1XNIJUr5zwxcaP7YycPb5L6za7F7Y2oRepik3fp3drSpYCwD?=
 =?us-ascii?Q?6NxRvTJeg/ANhxJvuqcdN56vYd37eVicoygpqIT9M4Aweb39EIRPpZbjQUbR?=
 =?us-ascii?Q?Yv+dQr5XbOCL8RU6EI0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3e2a45-7d86-4c82-6308-08dad331e97d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 00:20:55.1606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /CuH3uznC4SWpqwnr08Oifm3l8dxuiKhCZoSi/Gg/MN3GyPr8stEtQiLluZeUF6T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7977
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 30, 2022 at 06:16:53PM -0600, Bob Pearson wrote:
> On 11/30/22 17:36, Jason Gunthorpe wrote:
> > On Wed, Nov 30, 2022 at 02:53:22PM -0600, Bob Pearson wrote:
> >> On 11/24/22 13:10, Jason Gunthorpe wrote:
> >>> On Mon, Oct 31, 2022 at 03:27:55PM -0500, Bob Pearson wrote:
> >>>> +int rxe_add_frag(struct sk_buff *skb, struct rxe_phys_buf *buf,
> >>>> +		 int length, int offset)
> >>>> +{
> >>>> +	int nr_frags = skb_shinfo(skb)->nr_frags;
> >>>> +	skb_frag_t *frag = &skb_shinfo(skb)->frags[nr_frags];
> >>>> +
> >>>> +	if (nr_frags >= MAX_SKB_FRAGS) {
> >>>> +		pr_debug("%s: nr_frags (%d) >= MAX_SKB_FRAGS\n",
> >>>> +			__func__, nr_frags);
> >>>> +		return -EINVAL;
> >>>> +	}
> >>>> +
> >>>> +	frag->bv_len = length;
> >>>> +	frag->bv_offset = offset;
> >>>> +	frag->bv_page = virt_to_page(buf->addr);
> >>>
> >>> Assuming this is even OK to do, then please do the xarray conversion
> >>> I sketched first:
> >>>
> >>> https://lore.kernel.org/linux-rdma/Y3gvZr6%2FNCii9Avy@nvidia.com/
> >>
> >> I've been looking at this. Seems incorrect for IB_MR_TYPE_DMA which
> >> do not carry a page map but simply convert iova to kernel virtual
> >> addresses.
> > 
> > There is always a struct page involved, even in the kernel case. You
> > can do virt_to_page on kernel addresses

> Agreed but there isn't a page map set up for DMA mr's. You just get the whole kernel
> address space. So the call to rxe_mr_copy_xarray() won't work. There isn't an
> xarray to copy to/from. Much easier to just leave the DMA mr code in place since
> it does what we want very simply. Also you have to treat the DMA mr separately for
> atomic ops.

You mean the all physical memory MR type? It is true, but you still
have to add the kmap and so on. It should be a similar function that
assumes the IOVA is a physical address is a kernel mapped address and
does virt_to_page/etc instead of the xarray loop.

Jason
