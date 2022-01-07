Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1B64877CC
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jan 2022 13:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238039AbiAGMxO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jan 2022 07:53:14 -0500
Received: from mail-dm6nam08on2058.outbound.protection.outlook.com ([40.107.102.58]:8585
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232347AbiAGMxO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 7 Jan 2022 07:53:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ym0Ta9Vt7pk3eD5UKytJdtP9v1aQ1S8xRYNSiSVlfLKlyi1bOkBjD24REhznJpeDekzX0CwCL4mD4hCC2jzMXtfIMuuLWxkFKtYY9hkgM2RPTUwmN5CWFfE8pXCXYMh49qwGqzfFj/yFe0iCUaVqBqYgIgqr0u5q+RtMGaYCZyOJodG3B8UYIDa3HWixo2igZkOHF+XfOIzWyihcQbh4lXUSvrSsZyGXKnofAonx2TDDQs9VJ1Q45n9ajoY43L37q0DF8mZDzwOS46lbxgur3ZIUQfkYidbuBYKUJKqsgyaNC8EbKQm51R/VFBozZBlbsQAyZMFWToCtBRjvF3Ua9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wdq7830t8wFH5hzmDObJRifJ7O7r8IV2NU+bzoUfGMo=;
 b=fvrZlPXgIEcnbVidnGpSrCh9Tdk+Me+Tn7xpsNRMimcLtvc1lHpBaUiYY+Km9sExxNZbZE0ixmBmJykaue7bcMYyYOEm0357xHUAew6v8+idNV5g6CqQGZaLE4x9qgPU96c7zyeTTFgc/BQ1n+ixD1BRbATTvuNmMz+yl85st2CSHKrm6USSvJsrm1Fu5dNeFhpA3aLL7xN2r2HzNmBOPpX0hOFEP7ISHLzE/HphKwfDIf+CsCvf16VtQr0XFdJG3FQze1shKpkVzuSbMjWjY/yhSL4lbZzJWHCRa8BPgjFGKHgrfXwEkS/9DejToob4IUtfPDEzcU+qQxtzmz+wgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wdq7830t8wFH5hzmDObJRifJ7O7r8IV2NU+bzoUfGMo=;
 b=EahwSrdL73uiblvspFE8XCXeQglA4NAMq7QTBNyh1h0qUEKhCwOve+qt9hpKXRYu936AajbUmkGKQh7E29kq+9bVbzVNN3nW+/mCB5lC64RiYFtpnioFfWIGxBz9E/aSOGUjTgVt7lfmv0WEvaaifQAkOPSAJ7lODdOv54L5KEPSPQFe/a6kbGRLV6g3AmKwQ3euqGBklnZvqcMO1usCYNbzeH23zY7vjybY6MfB8nlb4LMncwmRv0YeaSlC4bBRegyDfQYXwCeyJejFn9/Q/BdS0DEDmZ9s8spjRrgoqhHkwaJm0Hi6VCAOMOCk4646m1ZeuoTyPlqgnUMK1rEn3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5158.namprd12.prod.outlook.com (2603:10b6:208:31c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Fri, 7 Jan
 2022 12:53:12 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 12:53:12 +0000
Date:   Fri, 7 Jan 2022 08:53:11 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH for-next v8 8/8] RDMA/rxe: Add wait for completion to obj
 destruct
Message-ID: <20220107125311.GA3061376@nvidia.com>
References: <20211216233201.14893-1-rpearsonhpe@gmail.com>
 <20211216233201.14893-9-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216233201.14893-9-rpearsonhpe@gmail.com>
X-ClientProxiedBy: YT1PR01CA0091.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::30) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fec34b6-f6ac-485e-7e26-08d9d1dcaa09
X-MS-TrafficTypeDiagnostic: BL1PR12MB5158:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB51580F9A667F87DBF5478263C24D9@BL1PR12MB5158.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9gYHv8d6TPZo3SEZI9nXvWWMtH+crQckFTOTzDqzIVjn6oebD/olX0zrUrJ/u82v0+/qKokcYw06R58HlWf3UBTDcbhPp66T4gvu+aRIkAAYYT/bKtvfEGZIIPfO7QMHOKkqgEVuNOraCPMRlcsCWS19lOwF7oTWDdpf2ElYuuYjgnVhs+4pVGu33MLB2zUBQQ77fRV/cABrIprWrvuwREbJQUszHmndrNfhfkzq8MUyeHvV+bhg5tacl8L6qp1TLp7kERAOXfHOGEZ+ptoTfCoTNgcQclkSfo5ZlMmmBepmSgwPvmo538rBA5dbl1pYDu276+hJK+0/U64eAeXHVFtfMxKDHBuW1Fxyl+QhiPssUPiyWDavuQ9iR8ma1RPgW2I2C8FA/a9+HrD7WqzqN2FUscjIyicIWVV06LyjmrJGXNkw3U21hMkVrsTKcD9LeegTXTrT0SVkoKxx3gx9W7UUUvXi0ndaiYaoQqNL6uw3NBeXmAfLkw8jyUJ49ts10NILzRRdygKKZtJ28GZQpJCalTK5ZmqD/UWRlBjKk67+d32LpeXDqJTbd0bvgCrk0hU77VAxuesnnqLmof4L1LF6lVJs7iSgsOwINw889h39Lc7WtoLCkCG2kZw/4IK/H/b5NvfyyBhhWWazOTNnWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(6486002)(38100700002)(33656002)(66556008)(316002)(83380400001)(1076003)(186003)(508600001)(6506007)(26005)(86362001)(2906002)(2616005)(4326008)(36756003)(6916009)(8676002)(6512007)(66946007)(66476007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MJHCH7JRWTJn6sT95TPJOMdpQi53VUiWhFbi0PgJ0ueOx8mt4S9xbkuVYoO5?=
 =?us-ascii?Q?UPy4x2uFA+Tju0BDCSrz+QBhn4TKx3pJPs0VHDg8ysoZCNQcV8Gld8pcoEgU?=
 =?us-ascii?Q?NX7HrGphPDbX7el37Kqk9NI+1JjokZ9X2v5OYAhJgdZA4twM4h/d6Z80Xpat?=
 =?us-ascii?Q?sp5N7WMHWXMuWnxjR2dwJoYkAmGe1CMYFBbnKQUh5clWhG7B4lxcFEjTZT2V?=
 =?us-ascii?Q?7yBk2zfUCfFNi9wtld7ohhK1/Hg6cmhQX1lU+d3UjMXlqsIxiU8CtBUyyCgG?=
 =?us-ascii?Q?MlchoyoCvtqPSpCCgdbhaPuiIemy7QwuDNvUteHr5nYzlMpz0D8HkYtwVNKT?=
 =?us-ascii?Q?/eTycBOnaEqYgYCC1xiYqBcN7SaAsJrseBnSsSfkYC0QXUrEA1RFlKCkl7GQ?=
 =?us-ascii?Q?E2g9mMYNOOu5i0MhHgIM5FpbdSZOLwqmvdOtp+jy5tXtCWq63XgOWUeNrH+o?=
 =?us-ascii?Q?p9soaDU723yBqmgWhV2CvrwLId0lzTUKeGeNbC8LHCmN0QRsQ36TMdse+laj?=
 =?us-ascii?Q?nDqndVQ9JU9VwrXv6KUEGACZE8ytOH4lOb9Z9kW7dCFoQu5sixbl11uZc4nQ?=
 =?us-ascii?Q?HuUXu0V5UmDgbPzTOonqlrULPAUx/QARb9yDIWof+NuM3HDLa9ZD88X1xd5G?=
 =?us-ascii?Q?UELP5MG60bZXPEx55NrB3g2g8DiEMj9OWB+hblgA+ommITkxEJhY9CCKRzUH?=
 =?us-ascii?Q?W0mhoTXawYhHqGjvczL28k1yVF4ekBSFkA4J+Tv3bk9DMr3N9+76eVfiEx8B?=
 =?us-ascii?Q?oL1g/gtPQgilcpGrjoqbTYqS+K7cbLEvIvMrwc5P0ruKqdnvZeRn/6WVSRum?=
 =?us-ascii?Q?ANt7rv4+i4yyfEfpl0eO0UfAkq9GDJwLq2SNwQWbxNOyt232Kketlktf7sx+?=
 =?us-ascii?Q?452mDBX9oejq/uaQI/IOdYD9izObVhzSoiA+6FbX4Y9NwbfG3V53DKhyLdD4?=
 =?us-ascii?Q?HrH5oDSczf1GtQlyF9trNaJW3bfX5ic5//H/aqBQGdgBoJ5QrIBNNPNPce4p?=
 =?us-ascii?Q?um6zSNuKHPQJraL93CuGssAGYGz2saYe8/8SwZ41Xqf57sMxrhmM7YEBQvPY?=
 =?us-ascii?Q?LvlmHAm2hGflg5XJa4ILsZnpFXH9GsGLiCR4+ng7X8uraU9NlbT1aGVUhya6?=
 =?us-ascii?Q?QCsqORxbCIvz7h08rWIUQk8siB/R0jMOoaA3Ok9cGer3CWXABzX66736Mmwe?=
 =?us-ascii?Q?x46FNylEiLWGPPbmf27fRkuRKDbHD1dt0z4C2OPTsww+9RSSjKKBW5SoBC00?=
 =?us-ascii?Q?Zisn1eXYiNGVLb96sLNv4m2u9hV0wB927hB9JoYTd9kd25vLEh4NyOFuLjuP?=
 =?us-ascii?Q?n69f5FoEVghpmntYSEqaxszm/iC3cKEQLUvJhv/T/NuM1yi8XAWlHxt1mWid?=
 =?us-ascii?Q?Oq3ETMy693Ho6xuHc7XXXY9eS6BS2l5hL0qRRZ/AUizxwKiZeJZjdSMhpBKT?=
 =?us-ascii?Q?UGsnWOM9gXo5X/Cn/eJwyRNBPu4Oyk5Y3XiUz0I1g5LyKOKgywGQeFiMtATA?=
 =?us-ascii?Q?mQyNlNkRodbwx+KV3GJSX3asjdDILueWtcO0jWRkugZdhmBASHV20kuW7BDv?=
 =?us-ascii?Q?eYYhf/I87dYL0u4PzcM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fec34b6-f6ac-485e-7e26-08d9d1dcaa09
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 12:53:12.7280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jUKVgJacQmbpt4JEQfm7jd6SIv7n/eQqTO5k499bVGjyv7FmPkKDiUPHxNrxP6LC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5158
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 16, 2021 at 05:32:02PM -0600, Bob Pearson wrote:
> This patch adds code to wait until pending activity on RDMA objects has
> completed before freeing or returning to rdma-core where the object may
> be freed.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>  drivers/infiniband/sw/rxe/rxe_mcast.c | 10 +++++
>  drivers/infiniband/sw/rxe/rxe_mr.c    |  2 +
>  drivers/infiniband/sw/rxe/rxe_mw.c    |  3 +-
>  drivers/infiniband/sw/rxe/rxe_pool.c  | 31 +++++++++++++-
>  drivers/infiniband/sw/rxe/rxe_pool.h  |  4 ++
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 60 ++++++++++++++++++---------
>  6 files changed, 89 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
> index b935634f86cd..d91c2e30665a 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
> @@ -122,6 +122,11 @@ int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
>  
>  out_drop_ref:
>  	rxe_drop_ref(grp);			/* ref from get_key */
> +	/* when grp ref count drops to zero
> +	 * go ahead and free it
> +	 */
> +	if (grp->elem.complete.done)
> +		rxe_fini(grp);

When using the completion pattern with refcounts there has to be a
designated freer that *always* frees the memory. This is how all the
other users of rxe_fini() are working.

You can't mix the completion pattern with multiple users that can
free, it just becomes racy, eg two threads run the above concurrently,
one will free the grp and the other will use-after-free checking done.

In this case I think you want to just run the kfree from the kref
release.

Jason
