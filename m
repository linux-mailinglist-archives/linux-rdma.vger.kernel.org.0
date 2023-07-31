Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0712876A092
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 20:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjGaSn5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 14:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjGaSn4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 14:43:56 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2056.outbound.protection.outlook.com [40.107.96.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A889E1BCE
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 11:43:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGt1rmaWoSdZeQaaQuY00jfCkWeC1YDy/JRJ7VFxwMEPCek1cO8z6IgqQp2iuOjUDEw1Bj4gCjEL5ns0VpOD9fK3NruwgdrldYfe/2B/ikL0rO7SscQCvLAchwk0tYestiBk+m5yQqFIdvUi8sxU+dumMSQEFL8S9iE0vRLy3J1n9Ws3bTbsgbuqaVmMobenJVFzDzAFaUexnRRS6pW/j83AUbzRyhGYSrUg8toEWexfJ6IcaNTZISyLG8aJCXOujlv2YK5czlPL+6UMcbIAw4yQ87ulfMxwpbUabjzdlF/dUHV/9P9ubEjXJOoELSldI3i3UPOM/FAJBhy+8pnaRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufoIrnrF3GHUVCW5oqVSmfh6e9edHWG+dMqjwLwdcAA=;
 b=OnWfMK88O8zliXnn92tYU3jma1AQHEA/w+RT8yDt/fiF6o5jFWOGNgrZ1Cpj0Mad2BPUSvLyKKAzMTR5tc9sYY3XGUJHWcp/zbegt9w24erJhuVGlnM1qR+y2T+J8VQfIeeyM9acsrR1wCz4J86nsgOSmKbG69tRyokBe0W826LNwFGjxmZNw7iI+hZTdQtAXxBRddvo2vpGsOXnL853XOuWj4mOu6DsqBOB1Qro66WCpxMeSRoIVmi2an12GYiXPGVi8PxNqqKoOsn7BgKdWQwg4u/UGuM9dWLcO0yP6RHqN88fVLofziD51TFNo4SHTcd1HPgW39p0VGuoPWWSyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufoIrnrF3GHUVCW5oqVSmfh6e9edHWG+dMqjwLwdcAA=;
 b=grf1adWH2b254w5dtlO6Jk4ysCy7Aa031Y+KCSSqnE16nn6SXpFNMBXZ4axoSme8mCRY56zD/DXgjRPGbm9tRbF8P049RvgutazBwnzcXKJ0dJ2iLjZ5Ro7OZRd515o8Swk0SP0dHPWjUabOEG3/lv9p9qkS7wAImob7KOQ8qHX2vbfJDq3jEJStdbxq4XtQ80rj4UyTCVOVOagJacWJ/+42TDDt+hHwDYmi3AEm6KN7Zi3uZwOfu8OltfmARl8CK7iy6809XzxwqkXS3yhO1OGfh5N8yZm3GzJ0C++vlfLvQtfJgP9fZ9DoDwhs/KZXphjugdoVZmaH0a9n12NkIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN6PR12MB8542.namprd12.prod.outlook.com (2603:10b6:208:477::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 18:43:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 18:43:49 +0000
Date:   Mon, 31 Jul 2023 15:43:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 8/9] RDMA/rxe: Report leaked objects
Message-ID: <ZMgA4mNoJ9ZhunZP@nvidia.com>
References: <20230721205021.5394-1-rpearsonhpe@gmail.com>
 <20230721205021.5394-9-rpearsonhpe@gmail.com>
 <ZMf6XBIAD0A25csR@nvidia.com>
 <ecd82fc6-0a2d-7dff-496e-5a92d115da8c@gmail.com>
 <ZMf987OeXm7bdBDP@nvidia.com>
 <4aeec08f-bd31-9cac-d121-12da5a20c2ee@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4aeec08f-bd31-9cac-d121-12da5a20c2ee@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN6PR12MB8542:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e4c6a08-8e16-4f5d-a023-08db91f6142d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1J4OSFn6j7sUig10RmzPPileg+AKNjThGw5EvkwQC9CAwot0LH14tz1T3N4UuH/bGDIR8gqirnZVZ3sryJKd3Z9M+4wePtYL9AB49i6bzmYlmoO1LkJ4bEAsxdvgljbH87IflXr1lWRJYws1YP8E9+kzJfO6INjJCIMqVRx31f733mZf3AJSvZ1sykx7f4h3JUYDHxrn62OYaEWbzb+9hstfWzQUG2ZPBunqBe61lyoOpd+bbBSmMpnoFovlWbT9rMaVrCiBN0E2qzc4IIAzG1C9EzQEjuOiLDLC1W/eBmvon/FgTLKvC4HmFbx6a2dtCHpHyp9+bhs5oT113GYQGErI46AKN4p3SGRGmsp8aM8v1GT1qBsQgPEx0wos1GWK1xlzKAzocEdPVMPoFAn8fVlrJ4K7KKDDMKPOCYVnIQcsvZOx2luYEpJ1ukyew+/qC0wGkF+ZGgcxyxdMAga0LSNdvqDSHpbq4lF1ItnBNiIqYX7h0SfOaUWkrsj+QSe/+ew4cgNqRv8oKaZoYe5gzq/XwOOH7ejxoxldVyKtklz3w8fx5sCenWdxC8sU4PLz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(451199021)(6512007)(6486002)(36756003)(53546011)(2616005)(6506007)(26005)(83380400001)(186003)(66946007)(66556008)(41300700001)(38100700002)(66476007)(86362001)(316002)(5660300002)(6916009)(4326008)(8676002)(8936002)(2906002)(6666004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NdoEEgQ80rzNmZLL3vs4NfCswyKI3RAA+qyoWMbdes1q8cYj1RoLaRhUwyxF?=
 =?us-ascii?Q?aetDFkyxbOATKdri5ryZILnBTPrkznbsWKltjgt63sQs3ZYkpi/hfmyFtSEL?=
 =?us-ascii?Q?M+6PhDkrbpCmkQXORS58V53P1DHPEVVVunleNfV4RFAazs5iP6qK7q6+85Ei?=
 =?us-ascii?Q?lo828BRl/c4nMDE2YT4YmZw4yLL6jrZamQQg4DdiPZHElDdWg26FSJObtVje?=
 =?us-ascii?Q?GzabaraDFlKb/+70B4lpee2S96NMS6u2JgzIZTMUzMkPD14n0ysv5iPHGqO1?=
 =?us-ascii?Q?NikVYR+ZFyQ1hFi4QaB1jeC8IVLc07bdO/aaHPj+mHWUfsjN4zZ+L+SFrWP/?=
 =?us-ascii?Q?N31lx+1qv6yoMGMMnycoJW0JlInGmE8hCXPfZ7BfaJEEo+qwgJM0D0oymt5X?=
 =?us-ascii?Q?W3SP3h3ZORtx6EJywQiiUMhlDk1MLZITukUZOo4moebzZy1rVu/g+uehhMPZ?=
 =?us-ascii?Q?esP/gCXQ301pJBsg3YyXg8qb/w4QCA+8NExEozypzeTFNBlb3SD43cxEU5J7?=
 =?us-ascii?Q?o2Bwk83cCHeVPM9jeDvjo9KDT8s1rjCorN5bsECTkmPew8ilQ2MZ/Hlu3Gzj?=
 =?us-ascii?Q?fSrLU7su3nurrkf7U5mBUj+nOg/doX8lQcmNz1UBJZvKb/QlQLZZ6DWG2dP7?=
 =?us-ascii?Q?jHzeSLLjV7/XA69HB1bR1JHe6y9xmj706Rn/lshlRs/SEIn8uKyxDYPHQwHi?=
 =?us-ascii?Q?B2H2XJ/v9Rmp4GgTmAPPuO/lBeXXG7pm05bqX9Zw8RAG1qdHWBrM1Qe6nGxp?=
 =?us-ascii?Q?hYsRuXxsT7RX2AihUT8Om8qf7vgyOzPnOGwWWiLDX1heSkmD5a/jLjE93H77?=
 =?us-ascii?Q?uVRRUXs8zd/ifdJ1Zbd2R4ix3JW2gDRFEHvDSKEnArBkFBOBaHTqn6/tbSlj?=
 =?us-ascii?Q?vxW9smLQWPEP8/euMLzLz0TKMhRg7wObASv+V48MobfBHyiciQnDaQaHbIpU?=
 =?us-ascii?Q?GttcjoegFA/KFSEW2XBdjuS9NCJ2Fyh4yhdvTwS+hLVE3fBXKwAt260q9gR6?=
 =?us-ascii?Q?Z6VAafnqy202cX3eCGIV0FXHvaVHV59d5wC6RG3+xyEG3ikr4T68KDimHYzd?=
 =?us-ascii?Q?+sLY5m1redtF9A1r+SYcNrUMcickkellTcxYB33pL6mTUoLH/Oaar7PnU9HS?=
 =?us-ascii?Q?HElLes+WJgd05bJLmnyzYkAlEqk4iaMoqIejL/Az7x9IEHxJEjrRr1Rc+hDH?=
 =?us-ascii?Q?qfjXRh3mkyNtF3T9Otxbo9KlxJdU6roThiLjIurfNctN2SOfy9rcqNhMUPOT?=
 =?us-ascii?Q?4QlX7JAdLu0+Xeo1pGA65XtQPGMkyCkzzvlem33kPSnOXhYbr4PU5R5lcjjM?=
 =?us-ascii?Q?MO5ASYyIvo6cMRq8ONNqW8G+ekwuo6I+Y//70VBCyi/E01DgsWwgKf6/PYog?=
 =?us-ascii?Q?+FkM6dHIltdDYLeEKoRkm5DSM2h566gOAJy2azUVpv1K9FfkhO+/TpHKOyUH?=
 =?us-ascii?Q?GKL2+FLPVu3etxgdN44ihyUR2gNWuBHIksHiS9lgJGDARyge3Jistwj0oHeT?=
 =?us-ascii?Q?GGVh0vVmGLIlscLAaVcUjVMuVn5Ya0GpdyEzVIbJzZM1+/O0R2n+zBeUOG6K?=
 =?us-ascii?Q?OXXvsa5gn9peciF+omEDEXf4SlBtEZUd188ySlFE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4c6a08-8e16-4f5d-a023-08db91f6142d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 18:43:49.0667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QEQKZHqCjQm28/2GsAfaJ4CcrM+yVrGVIq9JKjBmR0Cdt3X9AfBGVe8P3PJ7NgMH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8542
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 31, 2023 at 01:42:09PM -0500, Bob Pearson wrote:
> On 7/31/23 13:31, Jason Gunthorpe wrote:
> > On Mon, Jul 31, 2023 at 01:23:59PM -0500, Bob Pearson wrote:
> >> On 7/31/23 13:15, Jason Gunthorpe wrote:
> >>> On Fri, Jul 21, 2023 at 03:50:21PM -0500, Bob Pearson wrote:
> >>>> This patch gives a more detailed list of objects that are not
> >>>> freed in case of error before the module exits.
> >>>>
> >>>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> >>>> ---
> >>>>  drivers/infiniband/sw/rxe/rxe_pool.c | 12 +++++++++++-
> >>>>  1 file changed, 11 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> >>>> index cb812bd969c6..3249c2741491 100644
> >>>> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
> >>>> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> >>>> @@ -113,7 +113,17 @@ void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
> >>>>  
> >>>>  void rxe_pool_cleanup(struct rxe_pool *pool)
> >>>>  {
> >>>> -	WARN_ON(!xa_empty(&pool->xa));
> >>>> +	unsigned long index;
> >>>> +	struct rxe_pool_elem *elem;
> >>>> +
> >>>> +	xa_lock(&pool->xa);
> >>>> +	xa_for_each(&pool->xa, index, elem) {
> >>>> +		rxe_err_dev(pool->rxe, "%s#%d: Leaked", pool->name,
> >>>> +				elem->index);
> >>>> +	}
> >>>> +	xa_unlock(&pool->xa);
> >>>> +
> >>>> +	xa_destroy(&pool->xa);
> >>>>  }
> >>>
> >>> Is this why? Just count the number of unfinalized objects and report
> >>> if there is difference, don't mess up the xarray.
> >>>
> >>> Jason
> >> This is why I made the last change but I really didn't like that there was no
> >> way to lookup the qp from its index since we were using a NULL xarray entry to
> >> indicate the state of the qp. Making it explicit, i.e. a variable in the struct
> >> seems much more straight forward. Not sure why you hated the last
> >> change.
> > 
> > Because if you don't call finalize abort has to be deterministic, and
> > abort can't be that if it someone else can access the poitner and, eg,
> > take a reference.
> 
> rxe_pool_get_index() is the only 'correct' way to look up the pointer and
> it checks the valid state (now). Scanning the xarray or just looking up
> the qp is something outside the scope of the normal flows. Like listing
> orphan objects on module exit.

Maybe at this instance, but people keep changing this and it is
fundamentally wrong to store a pointer to an incompletely initialized
memory for other threads to see.

Especially for some minor debugging feature.

Jason
