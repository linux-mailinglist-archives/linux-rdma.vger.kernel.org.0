Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DD64FE2E0
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Apr 2022 15:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354860AbiDLNmU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Apr 2022 09:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356012AbiDLNmR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Apr 2022 09:42:17 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8333630F
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 06:39:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRekseSL/jaY50+lM14b1d/b4J8qsCJsEh0cltyZ/KIk8LI6XrzYeUDoQNUlpK+2xjqsedzKRur0eg3d3EdvUlaBM9XUzYEmcRrfNxY0pGTZHyqkc1DQ1KknqZ3VV6rR+Hlenumj0s/L4cZt1tTe2hFzui1UljBkgdCM3pL9/2LTzsddWcRPv2wewhHNUSuvuxuuUeXFbzAIh+PdcK1N/a6M4MU9NYs6nzDtr4LSWRXU/4HhMLrlwQwxjapjXVql9qHF6IHl0BEg/zCxkv3lF4oKIhma6/mYrGmjbl4hMbVm2SaRAm+9Hw+e1mFXlkxgoA8cNyX3XvAEnpo6zW7hKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOXcO+mjd3u9Ey4Sih8vJ1C1sbDZYdC6damO12Lf840=;
 b=dAMeIy3aMKEvRWVaBnCYehACY7QERMH/lXdbjuG9EK/8ILpdJydUnsil2ZN5gNU0ERlO4GiGumqTnxmgz8MOvDDZBnNhiqtIBdGzo8n7WBRVIimyr3Dn7x85rCqqjaIGzOWRXIEd2K2TeEQqisl2OC4aPUZHqczB8VVT+1eQSenw0l9yW4clMSWArVFgvhelz4lyCxQfujvm26vsu98YMnWn61WZUWrUgVaFP78XPhBC7rkUAhCEOiPjUBiZN5Hk2fAteXS+7JZe++Qt+okFeRotC241BfUUpb4N741mayXJ+j6t8WbLnrdt34kN0RAivbEIccJ1iy3qDEXu704mNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOXcO+mjd3u9Ey4Sih8vJ1C1sbDZYdC6damO12Lf840=;
 b=mho8BDbBIgY3MiDu/oGY1BTowo7l9k0JusV3jT4H7c/bC88sxjXCOY/cLbSyKIcVPEgOfjijFaBm2RgO4pPSRo43pSgRJtmtIlkXp8yfSrE38qGdbUJIm66l4grAKJcY+W/FMPXPrQYuPUjRQedhZ5sFFJ/TjOE8pisvwuh9bsZwEyPjT3GrtWAkmIFbiNfEGzoum3Y5kMxJT4tAkgtRs8eKgaDN2J21N7jqvJwpxwlyAZ1IlsYLCDkjYPES+cjj5b0vzetimHtx7dgyrc06XWKs2hVGsm6qtjzNIQDVCfKXiGnA2zDRpYfH6KnzwshNvfpN27EWb1/+iVLDQJMBUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by PH7PR12MB5925.namprd12.prod.outlook.com (2603:10b6:510:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Tue, 12 Apr
 2022 13:39:48 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c911:71b5:78e6:3a38]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c911:71b5:78e6:3a38%8]) with mapi id 15.20.5144.029; Tue, 12 Apr 2022
 13:39:48 +0000
Date:   Tue, 12 Apr 2022 10:39:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>
Cc:     "Pearson, Robert B" <robert.pearson2@hpe.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix "Replace red-black trees by
 xarrays"
Message-ID: <20220412133946.GH2120790@nvidia.com>
References: <20220410223939.3769-1-rpearsonhpe@gmail.com>
 <ec1de70c-aa84-7c3a-af6c-4a04c5002d1e@acm.org>
 <6296dc52-1298-6a52-a4fb-2c6fe04ab151@gmail.com>
 <20220411113836.GD2120790@nvidia.com>
 <PH7PR84MB1488692D33B6CA7445569DA3BCEA9@PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM>
 <20220411160217.GA4139526@nvidia.com>
 <4314cea9-b5c4-b0e6-60f3-b3a91abce505@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4314cea9-b5c4-b0e6-60f3-b3a91abce505@linux.dev>
X-ClientProxiedBy: MN2PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:208:120::36) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 132be45a-fa66-46d1-53e9-08da1c89e969
X-MS-TrafficTypeDiagnostic: PH7PR12MB5925:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5925C73EF7C2A7655A33EB18C2ED9@PH7PR12MB5925.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bd86KoBmGovMrj+uOM43gdkjR2WK4TU8ExnRkmFpZfzO/9jTbV7jSrxBeRkW77lRlv/8Mf7PdtM81QYArFmB8nwUkN+Ortn1eIKDj1EVtrL8zHad3q13DBfJjypc/n9/19G105g8iGFXSgL7buma0rkmlJHuhcpPxPnlA+FeqiePS5iNRxwJRPNbuId8Z3DUXMhtkax3f4IKh04s9gNBeClz4gV0eowudGc+QHXPJySRKbTkDBBe3NjeqZUghLzBiRGK7oulXnZXiSVovGf/zYZIL/27HmcilNNguX6FjvhQ1bB2KWbYJ0Oh/uLd/LfSdaq0QUVr8gL7ORdqhj/6iMVaBjC4z//XZRG5i6cvDVR8GcXsyfg914hD3ZNJxng3c/DCRe5GvArY8AdFVvk99GgbSxZsXMioFHYUi53rlPo7tz9Pl8VS7jjnUrZnX0b3nrrn+l2GBPX0yFu3vVV9d7Z7s4WEFT4avEnPXFamyil9XfDtaaTB5qBQylT0my+dPSb6mvpUK3+oyFF68p89eG+Z47nHpP0t31oaO9ifBejpLYo457KKdgb/98uzODqRbGELqzbNcyVlVAloWLAARMKuq9a3JIF7cZ29GzsvR3cLR3n5mrA5V4aSrmISj0C6wIOGnYnxiZMU5dmcCUMnT8fY0Xmzzc0No2c0+RqSC+VSmd67SGCuoZSFVOKLnr2ip7tMAarMqzPJq9UTrxoBAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(508600001)(6486002)(2906002)(54906003)(6916009)(38100700002)(316002)(8936002)(83380400001)(33656002)(5660300002)(4326008)(6512007)(8676002)(36756003)(66946007)(66556008)(66476007)(86362001)(1076003)(2616005)(186003)(26005)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enpqcG5DajRMcjd1aytNeGdqOXA5eHBwcmkzK3pHSjdnUjNBVThtTlk2Q29y?=
 =?utf-8?B?aVZiU3J2Q1hDVGcxcXZpeVlIMU9jM2x3STRoTjJ4YklzZWxkdnZpZ1NOTi9E?=
 =?utf-8?B?U3FkQ3oxVGZsY0NsZVpQQi9qUTNKai9xaXpVdnNWelEzR2FsVTV0ZW96QXBU?=
 =?utf-8?B?ajEvdjBTcmJNTkg1S2kycklqTFdTOGZrQmFxWWRwNzhqZEJabjM5Q0VndUhl?=
 =?utf-8?B?YTlTNFVSc1AzbFZiYnZSMlVIbmxHbzczaDNoMUNRTkRRSFZMdU14ZFY1bEx4?=
 =?utf-8?B?RXVQWURJODZ0TW1tR1ZsRGthdmhaUURPOHdRL1dwYm9oRlFuMVh3bVRmU0Vj?=
 =?utf-8?B?TlB1Mlc3ZE5hYUJkbGdMaEtPbEZ6RTdzS3lSZ3Iwb0xoZ3d2djA3Q2pMYzFs?=
 =?utf-8?B?TURmTGdUVExNYTA1Vm5yVnJyNkdEYmtvRzNyUVo1SGcxVUdhRzNmekhsRGQ3?=
 =?utf-8?B?VDlpUk5kL1NDbkNSTjhIYkVLZS9VSXZvVk5rcEcxRldoNGJhdmphWTFXZkZi?=
 =?utf-8?B?VnNadHU5ZDdCV2xTTDR4cVlQcSt4ckpjSit2MGlhTkVHN3BjdUxzcXo2ajQy?=
 =?utf-8?B?Tmd3WVVkMjJQZ0k5aHRBRHA4bzAyUjJ6OGN5Mm1nOGtGL3RMNTNEd3J5SHBB?=
 =?utf-8?B?MnJQZmdDS3hOWFAxbzR4QlBmYTUyS0hYSm5zdEh4bEV5U1hvZ1FXZTlmelJK?=
 =?utf-8?B?OUsybGh6QkhDb1puSWh6L1lKenRrZVpRcXVaK1BkdjhzUFFUN0l1YlB2VVlS?=
 =?utf-8?B?dVY0KzA4bFBFcFByanF5bElUQzlNaERRSzhoK0hjNzM3OGhoa2M0UjZpTUV4?=
 =?utf-8?B?SlZFR3JGMEFmNXZKNU52a1NwcWNKUHh0SnJLY3duKzRNb1R6OS9lS1VKRHFL?=
 =?utf-8?B?QWlMLy9FQlpjQ3VneEhySEdVM0FIRHFDc0ljdHJyM0pCdk9TQzh5T2lWc1VQ?=
 =?utf-8?B?TGtkbzEzTE1WTzlPckR5anBXcytlYnoxaGFiMlowaTVUWExvVG9TenhjR05l?=
 =?utf-8?B?M3RPQnAvZWJ0ZlVVTGlVWjh3T3ZrVkFGam96a2ZpUnhkNHVtcTdHZUJwa05G?=
 =?utf-8?B?MlA4RVc4UWxhYkYweXcxSk8zbzUrRjVEZ0dGZjAwNHJLWkxJZFZRWks0M1Rr?=
 =?utf-8?B?T3hvRnk4Q211S0RQbzNKeGEvcW0yZ2RVaFdxeDNPbnJ4d3RyVmVWMGl5VUQr?=
 =?utf-8?B?dGhwMVdGSGVYQkh0TU5sL2JyUkV4NWswR2xyQ1grRk5KclR2SHNHdXN3V28y?=
 =?utf-8?B?ZHhScG9GZnJIYy9nMGdFNGVCbCt3cCtpbVlkVDI5VEpmT1RRMS9BcjM0OS82?=
 =?utf-8?B?YWsyanAzWi9MTnZ3dCtMcTAwbjNEbDhTZUV0b0ZJYWhVSUZ0YVErblFJc2Ra?=
 =?utf-8?B?dW1XeUU3SnozV1lZVmgzOHNKUjFSczFpZGJjQUJNaVYvOU1rMThCRnhZc3F2?=
 =?utf-8?B?Vld5WFFuMkVoOWNFcThrclo5ZlUveWZBZEdoWkQyV3h4QU1vUFBOa2Ziam1u?=
 =?utf-8?B?ankzZytDd1Z4OVRnaE5PZFlKZllTUHJLdUdqakZpUTdNaFU1d3hBYmF6ZEtx?=
 =?utf-8?B?dTJsakxXREZEdnpCRjY1eGpzaGVpb3BSZ1ZMM3N4MmhGVXpsMTd4UmpHS1NU?=
 =?utf-8?B?ejEvbi9UMDhtZGZvc21LOHNHSDhhNFgxek1SR1NZYTBoSVQxTTFFbEc5UHRP?=
 =?utf-8?B?UkpCcmtGQUl5aXU1SFNTblJhTURPRFJWcTQ4bFJ2UGZhOFhRK08rZmpNRmFP?=
 =?utf-8?B?ZngyajhlOTZPS2JtQi9IanRGQ0d5b1IrYkFYSUsxOVlKL2RuL0tyR0xJdnNy?=
 =?utf-8?B?c3I5ZGJya2QxMVM1em9BNFc4T2owYjRaL0E5K3YyQTI1emptekFxSHhuMEZu?=
 =?utf-8?B?UHdlL2F6U2VPTEIvaDlmTStuZjhRYTJCUFk3NERGN2szbGdLM25uUThReGta?=
 =?utf-8?B?MENzVkRvMFZodm9yZURFblQ2UU1YRlo1RW9iNmhtTTBWVEVjWGNyQmRzQ0Fu?=
 =?utf-8?B?b0dQZVNwUk9TQkZ0KzByMUhpRDJmdllnaG14dk56MERLaEJhZWpRN0hBY3E1?=
 =?utf-8?B?SVl4enRqdDZ5S3JMVDdPUXNVWGtLNFRRQ1dWQ2hSNTBnRVdiYXhVVGtDeElL?=
 =?utf-8?B?TDExV0hWVFFHWG9zUmVhN0VSYjlNY04vQjJ1WXIvSnIvbWZkWWNIenJDazBD?=
 =?utf-8?B?NzF3cm9pMTNwUENNM0xONDEwUlhDTDluTXpZYjlHUEQyZmQ3R3JaOS9Jd1k4?=
 =?utf-8?B?SG11TVc4ekozd09ZRFkwMWlwS3lVaWR0WFJtSHhIK0dzWU81OUhGRkthY0Ja?=
 =?utf-8?B?V25ZbGxwYVVNNW9WZThCbTdaaFRBM3M1Tm5VRU5pSlJkQUxWZzZ4Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 132be45a-fa66-46d1-53e9-08da1c89e969
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 13:39:47.9687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ih5+cAX54Ef4AZLfpBcf6ZUxcH1OtfXg4dVTp+NTJE8dmRQXm1EUwzdGqwY/QWl+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5925
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 12, 2022 at 09:32:25PM +0800, Yanjun Zhu wrote:
> 在 2022/4/12 0:02, Jason Gunthorpe 写道:
> > On Mon, Apr 11, 2022 at 03:52:23PM +0000, Pearson, Robert B wrote:
> > > 
> > > > Yes, you cannot use irq_save variants here. You have to know your calling context is non-atomic already and use the irq wrapper.
> > > 
> > > Not sure why. If you call irqsave in a non-atomic context doesn't it
> > > behave the same as irq? I.e. flags = 0.  xarray provides
> > > xa_lock_xxx() for people to use. Are you saying I have to call
> > > xa_alloc_cyclic_xxx() instead which is the same thing?
> > 
> > The xa_lock is a magic thing, when you call a __xa_*(.., GFP_KERNEL)
> > type function then it will unlock and relock the xa_lock internally.
> > 
> > Thus you cannot wrapper an irqsave lock across the GFP_KERNEL call
> > sites because XA doesn't know the 'flags' to be able to properly
> > unlock it.
> > 
> > > The problem is I've gotten gun shy about people calling into the
> > > verbs APIs in strange contexts. The rules don't seem to be written
> > > down. If I could be certain that no one ever is allowed to call a
> > > verbs API in an interrupt then this is correct but how do I know
> > > that?
> > 
> > rxe used GFP_KERNEL so it already has assumed it is a process context.
> Got it.
> 
> __xa_alloc_cyclic(..., GFP_NOWAIT) will unlock xa lock internally. But it
> does not handle flags. So the irq is still disabled. Because GFP_NOWAIT is
> used in __xa_alloc_cyclic, it will not sleep.
> 
> __xa_alloc_cyclic will lock xa lock and return to xa_unlock_irqrestore.
> 
> So the following code should be OK?
> 
>         xa_lock_irqsave(&pool->xa, flags);
>         err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
>                                 &pool->next, GFP_NOWAIT);
>         xa_unlock_irqrestore(&pool->xa, flags);

No, use GFP_KERNEL an use the proper irq or bh version of
xa_alloc_cyclic.

save is only required if you don't know the contex you are in, and
here we know we are in a process context.

Jason
