Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D775E72CB63
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jun 2023 18:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbjFLQWt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jun 2023 12:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbjFLQWs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jun 2023 12:22:48 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB60E41;
        Mon, 12 Jun 2023 09:22:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAsD2yd2MKdtI5duIE51GdktDkxcs/70q8IvhTxWFn6Th1PTCNeaTGUxpyiNdjPBHrH/UfB6fccySBesAgQVcXPWqN8zfFdzWoE31YFF3i4Djw/TzkM7O16FEf2WdtVPWGCX3jPtnPsRYwMYRnOjE3SGkYOn28KPEnI/M/4K4eh6g1+C/Wv1ItOEM7Hc2IHWv0kVgHobLGJiVHtrMDrQmCFAkyLcABPILlsUecV6tuNj2r+Adp2MPjLRzIg6G277lHl2pHhFDwDPX6bocqEGCYUZTViMd7Tey+0YGAkWDYH8xFfF+T0/TYCX2+I8UG/3o8qVQKmgW0ZGFwPgOV3/vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBOGna6D8jk8THva8I4u4uHZC+mCg9M5FqPpG/bkdCE=;
 b=KMRCqAVXnYS+x3AMX4eKR98N7DQDRoFmP6JBVnKfvMwLxGrDjfkZVOg80R9fxzcM/ZDZ7EZ/bayOhyBrErQmjyPr7A54+iaWDH8tnxyc0mLCO9ZRuVJXgL5jG1aC46QrT6uCyDDPOOVTlia3GyL33/gC5pZZ5jTqRbn0OV+qZbjJpvPw6/17z6ykL5Ec0Rcc0pivfTDG7rvvJODznMu7mgqI3JqmgSVPAmEJgTz17mt9ttsy8DPmkEDr3SD90bAxejAWGRO6HI13eZtOrib8gO9f1+SRB2utcLzlJ2Cji5ztPdFOxTwxFurejflYwJBRnhe+9+CvWh7/oiyo68v++Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBOGna6D8jk8THva8I4u4uHZC+mCg9M5FqPpG/bkdCE=;
 b=GR8vJxi/xVUjL5nD/smJtHCDkpEykMb2earPG0xxl9jXLSpsDbCn6AChfGfpPwA88sZYogR8pwyWen1pykMVOZjMWzcV/oXEGee5N62IiOHqLrAMiTV/srRgy341rrsAZvj1L56JXr9jnPPfPjo0L/zrS9rzywMLyC7GCMLz2w3uEkfPc1ZPr0ENiXBZlkYgayGZ4OSJNucSpEjaTp5jJMC1NAgucbzfiWrpfKR0b85/e3xpVnzystJJODLhBOdVCJJc7KWLbJy0tMv+Tghmb7NS1YAqTtTmraK6Np2ouLswIUqUPMUVL4Kizhl1PrcBxPDwv1GkXBTAMAcfCBJc5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5096.namprd12.prod.outlook.com (2603:10b6:208:316::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 16:22:44 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 16:22:44 +0000
Date:   Mon, 12 Jun 2023 13:22:43 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, leonro@nvidia.com,
        zyjzyj2000@gmail.com, linux-kernel@vger.kernel.org,
        rpearsonhpe@gmail.com, yangx.jy@fujitsu.com, lizhijian@fujitsu.com,
        y-goto@fujitsu.com
Subject: Re: [PATCH for-next v5 6/7] RDMA/rxe: Add support for
 Send/Recv/Write/Read with ODP
Message-ID: <ZIdGU709e1h5h4JJ@nvidia.com>
References: <cover.1684397037.git.matsuda-daisuke@fujitsu.com>
 <25d903e0136ea1e65c612d8f6b8c18c1f010add7.1684397037.git.matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25d903e0136ea1e65c612d8f6b8c18c1f010add7.1684397037.git.matsuda-daisuke@fujitsu.com>
X-ClientProxiedBy: BLAPR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:208:32b::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5096:EE_
X-MS-Office365-Filtering-Correlation-Id: 25064ba2-94d7-4061-ac5b-08db6b6140bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x7tgcqff0nWjY00+Jx3sPkWZMnTOQQl1NZNWJRiNz/EbHqSGPNtJc2cWU83wRvvrMcjwlQAFMRyfl7c7+MLTySkOqTcuHq4ulOMlg/cMoikURcL4UCelKn3LRoWNhUpqawRO7Jn+jfwzZuzqO0Lg+i9No+JxD76WVl2ef1/WOQ1meFVEEeaBxtg7K6r4VO8fee9KwIWzIybDVrmcuOAinHWj4KOb5uMRtjvyWYGbaEiENq/Bdga0nnv0X/deWV+P1XbJzwVwtL1e2dg1roMuYjiZE7EB7htA//ZqD+3jJ5nxv+6D1KRcCxCnS+Q32ZrKazmmYoDtHEkiJdSFbu+PaK1FlJkCyAI7SKKei+Ri1g7UMLCATe64JYnCaHeKCkX3CJ2D+usA+16dh98jo3ig/UV5acZMugN9UVCrLjiC0O8CIOmb1AI2fzo1T7XrFo4HxOwudjkkWN9SnciVvddlGnwlNTL9lVkeKRifwEIJhAFN0ws/skFD+ogZTZu8Ej2jeXM1QitNMg1m9ft1w8bkHv4Bnchjb6zuoDftDw+S6zXFHKPaNF1papzoqf6UqIst
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199021)(6486002)(478600001)(83380400001)(6512007)(186003)(6506007)(26005)(2616005)(36756003)(38100700002)(86362001)(66476007)(4326008)(66556008)(66946007)(6916009)(41300700001)(316002)(2906002)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GrLmOc3LZ3lALydO5VTnVrk98EoF7U7lj/FPMa3YBvTctdAzG50fPUEW84zB?=
 =?us-ascii?Q?3w6t3WUGbKFXXwPraq9oNKIAN6H1NmMnz7gGhIOiBotOOa2ALV63dLe6qiFy?=
 =?us-ascii?Q?GG215lQvZFG0Y4FRixVMW5EJd4Vb+Iu/7HPKvZuUOdp9QJwWulrmCEXzeISU?=
 =?us-ascii?Q?DTrBnNbyM5gP2VvxCx73rhio07ueHyQq28dHLD0EhFEEA7LPYa12dLp2ymEB?=
 =?us-ascii?Q?VXWOMCZ3h9/xK61KcmOP7fI3cO3RQ5EuAxMNeLQMPV2z2NjZSvRv/aztZQ3/?=
 =?us-ascii?Q?aprORsHRwSQtUmz5xpoz6bJeAzr8d3GzOsXSd8m+X3vy65/OcEyrjEqgUELD?=
 =?us-ascii?Q?VYzOYEsn278HBun77wDsbQ0wBSI3SPtFdoMvYH9+tn9Dl+sEnBBJaGRMsc6v?=
 =?us-ascii?Q?1FTHZmiBZYdmPALLsseqOIaEmRJUlJuunz2MS047KIeXgn/zDUFjCiUzcI88?=
 =?us-ascii?Q?nYwe9CSgOYiw/bX5TMTuS2pCLzlF6DiKsLrO+ZMgKOcNEJ5CFRuw+GCSi1gf?=
 =?us-ascii?Q?8qe3GHfFZZvbMuBde4MaOwIm2VSlgCWH4zW6xJtz5Et9n1IO7HhLkkw98LKn?=
 =?us-ascii?Q?jiORodSbEWalIlOQHm99Pfh1hpnmZiAyoYbu68xt73bxKgD7iq2JunnF/i3f?=
 =?us-ascii?Q?g/Bexph46Q/jpIqgIXYZGSP/eBqLmuEp2xqHk89xWlHAD5/g2RaZXPM7dr5T?=
 =?us-ascii?Q?wkPcWozCHqO+0+U5dFD97YB4CEjmtZ7Xz99Wx7nSJl2k0HRZJgq0+3jJsoFh?=
 =?us-ascii?Q?haxwIV2roC9JJjkXbnJ9lKu62ONmTgZPllxa802ekp3Tz6HTAGc1FeEvpqaT?=
 =?us-ascii?Q?blUMltLsuFDgcgLrkqWpFYTEEAalqBvLGjxng8nuhRFI6zwINfqxUETpqycz?=
 =?us-ascii?Q?DgbaFzswPHK8cU4pMzmMvr8LivmOLmLN4B1aekRnJMSwKp1pG+9Oq46j8V1Q?=
 =?us-ascii?Q?40IdCGRmCwMmd8QShbfiOfTvE3jSHUVxJRmHqPaWY9FjHhINu5eJETLOV3It?=
 =?us-ascii?Q?vecdQ1gPUVI0+xWHn7MYscSn9JmT75f6odcylRsLwYFGckTfhk5+jTEB5pIw?=
 =?us-ascii?Q?ZfFeSx/3joNe9ciaqjby7p7XKSO0n9bIIovzkYx3iriXSdPL5z5dVgqelMUv?=
 =?us-ascii?Q?126g7VhImX0VLlRE4Eb9B+dnrponQxu0gYrItsXS4lX212Wi8/zKJjbCklO3?=
 =?us-ascii?Q?Hok4VhtnwoOySlBEZRTektKCND0agqRoPh0Auf5tTF7RgatCZO0IC6MhLf9C?=
 =?us-ascii?Q?x0mc1X/EOKQwfHCxaV1Wqzp6ZDwsHW1u4Pufk+ZgWNLzeURRkL75D2b1dEzQ?=
 =?us-ascii?Q?8KvLYvFyuKNcGu/TDFZleShEoOuhoyf2fIpoU4XjPjybsGc1HWQ8+co8tD9i?=
 =?us-ascii?Q?lVuLUG2gQ+4rX/WKJwc5SkuaQ5Aj7xl/SLBY0HZtdfSCxo8kQOQ8IQrCPzX3?=
 =?us-ascii?Q?aMuHxwwGdf2f68ngzhyG/k5x/7TUBhY1gxZxihZ/qynjQuyn3Hkyz7lUm9BQ?=
 =?us-ascii?Q?YP6rrePomvR/veJOSUaCU0aroMx5nAwyr0CWLhaZbRO+KVY26MHbbDDMTwRq?=
 =?us-ascii?Q?3J9jsNHedNDG7x+2yDw/OKgwWVH5w5cMZVLXLXUK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25064ba2-94d7-4061-ac5b-08db6b6140bf
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 16:22:44.6332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eoMbosVB61pJkG4EskozNn/C3sSTP0UOGCSJfINmlS6H0rUjHAkXUEu6wW0f5CIj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5096
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 18, 2023 at 05:21:51PM +0900, Daisuke Matsuda wrote:

> +/* umem mutex must be locked before entering this function. */
> +static int rxe_odp_map_range(struct rxe_mr *mr, u64 iova, int length, u32 flags)
> +{
> +	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
> +	const int max_tries = 3;
> +	int cnt = 0;
> +
> +	int err;
> +	u64 perm;
> +	bool need_fault;
> +
> +	if (unlikely(length < 1)) {
> +		mutex_unlock(&umem_odp->umem_mutex);
> +		return -EINVAL;
> +	}
> +
> +	perm = ODP_READ_ALLOWED_BIT;
> +	if (!(flags & RXE_PAGEFAULT_RDONLY))
> +		perm |= ODP_WRITE_ALLOWED_BIT;
> +
> +	/*
> +	 * A successful return from rxe_odp_do_pagefault() does not guarantee
> +	 * that all pages in the range became present. Recheck the DMA address
> +	 * array, allowing max 3 tries for pagefault.
> +	 */
> +	while ((need_fault = rxe_is_pagefault_neccesary(umem_odp,
> +							iova, length, perm))) {
> +		if (cnt >= max_tries)
> +			break;

I don't think this makes sense..

You need to make this work more like mlx5 does, you take the spinlock
on the xarray, you search it for your index and whatever is there
tells what to do. Hold the spinlock while doing the copy. This is
enough locking for the fast path.

If there is no index present, or it is not writable and you need
write, then you unlock the spinlock and prefetch the missing entry and
try again, this time also holding the mutex so there isn't a race.

You shouldn't probe into parts of the umem to discover information
already stored in the xarray then do the same lookup into the xarray.

IIRC this also needs to keep track in the xarray on a per page basis
if the page is writable.

Jason
