Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2D83CD446
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jul 2021 14:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbhGSLWk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Jul 2021 07:22:40 -0400
Received: from mail-dm6nam12on2041.outbound.protection.outlook.com ([40.107.243.41]:63072
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230493AbhGSLWi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Jul 2021 07:22:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROi4J+XVt1aQtnWEamaeZiZJDW8EufZ9fZlzfSrjNQym8QNdt1DNKyS79Vhfb/pVbtA/Y2Gkle8P+9vhHi3gLcsMF3pV7/doxSJ17CLRQQ5dHKaOZCP+8P1xyzFDUAvyQctnCLDX6O36Z/9fNR+pM9+h/lbX9/8m+7NvQinFsHAM0ZAkNeAQbD9RtIlgAsr+ZZwqatala9cobhVJky71QMb9otF5bHKvvTo9LMtFAcskNcfy8LNmahUrRjk06a2hdFgHSPNVX9t35YIPhpIy6+y8QmtCyNDS+rCext7RTlJPLTP2l/QENTZwjKqRIHjEB16SrI6guMIjXmiuyz+Baw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oz9X+XHtAjN+JPf7hcqVpGxhkkELjAZK2sfuWKFuv20=;
 b=Cn+cKsCHnE13N4O+dr4yz7DxjSUm/Bhkdijd6cVDEW6dkIfwVFPH+FukcX3OEovNkbzRjQnecvaV0TU9p08+9u2PfazV5oG+iwg2/CMzqor7TZctjeklOVTTH0eKOI7ka5hlA0Q5U2IEUjQaYbZrHCjt/5S+XiLVMW+Rf6pFzA3xS7GkPU5bW6Mu+52Le38QvZHWPVqEpSbb5YXNf6I0b7lgFnkf1PJobNq6PjXlX1ZeIhzBpfuWUVvEVfnjLTYa7Rcg2Qm4tYVHzMfGigLEM764n2g5WAoLlbm1+nn/mvH5tF4fatRx6AUXI3EPJ0pJZZjKyQUtzhN85IQxcwoUQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oz9X+XHtAjN+JPf7hcqVpGxhkkELjAZK2sfuWKFuv20=;
 b=grYH8XBTST4GtEymda6yLHNmfHT0Bgn5V0wsjZYjSBQp4cV6w3o86Ke9UWb/wNd8CO89yqkkBTXs83hsMna5SfTxFgzum5Fo3fLeBZ15117Y8HUXSBDC3cG1ZsdIu1aGe7fiCBJbqFZ8zCm2bM071626bP0hDP+Pe5rrUNRVCFcWf5r5Dn7SQ90Yv6sU5qZKZpvUjVZQS9JLSwFQH1UzOPNAlBG04UAp7D4pwk+IyVkOggdGmUkYNvRoVontATPnlvkxfhSjZYbkvs6BKhKeUsVDYxjemgve5nd6rjzA0okm5gunZIgQUVVI33Ed7D1HN7vMLmTXJ0jWZI2JwmB5Ow==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5048.namprd12.prod.outlook.com (2603:10b6:208:30a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24; Mon, 19 Jul
 2021 12:03:17 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 12:03:17 +0000
Date:   Mon, 19 Jul 2021 09:03:16 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2 1/5] RDMA/rxe: Change user/kernel API to
 allow indexing AH
Message-ID: <20210719120316.GO543781@nvidia.com>
References: <20210718212703.21471-1-rpearsonhpe@gmail.com>
 <20210718212703.21471-2-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210718212703.21471-2-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:208:23d::31) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR06CA0026.namprd06.prod.outlook.com (2603:10b6:208:23d::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Mon, 19 Jul 2021 12:03:17 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m5RzQ-004Npu-9o; Mon, 19 Jul 2021 09:03:16 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8b5e858-c3e0-4bfe-2b64-08d94aad31c3
X-MS-TrafficTypeDiagnostic: BL1PR12MB5048:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5048265F1E18399532C858A0C2E19@BL1PR12MB5048.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 05wfTvx2ufJUAM8JekbsYra2mxYXBxPrtHDCbW8f1QDDTnTen+LXN1wA3MYY4TEYIBJM16uCQ3jSd2ZIs0OBWBngdUMV+S1+0O7+VaOL0aeLPZvu2qZg4z1pbmcQJhqmpI522SNaCKfric2kNmRBJ5fESIs9FWrKwIxEzsaof52xDEdZ3N6SQqKmtld2HVJYfw3S5bbhAbNKoH+8cc/t/3Qp0q2akl6h2lVWB2Kvn3pBdYTtTdFaUQcdgU+wwC6lGWIeiBPvAn3bQLQdjOk2DT2qdqPwJGm9q6SL3aiv8mDUbbXT4oP1vK2sEcHwy+2Vn8ptitDvtcYdeONmDieURJHrRk0Anh2CMp81ARonw9TP8Z7AE372piiVziRFbDPOotM5HzTnT6IZjgCWxW+g0Ed64eba8m/kNnFXlESMk37+vPs2VJ8lsvqsFkY00SCAvZhPXlnLIvtUpwte5bGdusK3WHx5gbM0NjdpFdhMqYo9ccMHHiMWpT4TPO8KkxfI214GSC7qeGHxedMtZalTVR+5KSwbruqkh3Pa8vNFSpJ/xSeNe/rpi2Gd8JAOXBrSlekQKbPxF+jTVdFwIikJjDLhETbjNzKcHkVQSRO1Qk0YJOj2iAl8CpUxOB5U/m+lm2c4kXjFwgG6kVRFS0Eqipm5b0UduFMrz8fZE4r8jwkKulJQujpsvnBZ95FiK8+K8+LKF5xDLnbp0p78f5Wh4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(4326008)(8936002)(66476007)(66556008)(1076003)(5660300002)(66946007)(9746002)(2616005)(83380400001)(2906002)(9786002)(478600001)(6916009)(186003)(316002)(426003)(38100700002)(33656002)(8676002)(26005)(36756003)(86362001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n/ERggMgXy/WSVvaKt0MfxFoVx2ZCVcZ1imSlq5HrLMMbA+Td7umyqQPMiXF?=
 =?us-ascii?Q?vgfGnntGSe5HzM6krCdlwxAoOlzAismsy/TIE4jnkTAZ/CCPb3LerrbgMtoF?=
 =?us-ascii?Q?gKr+xFtfW7d727d7JyywLyXF8dZtlJFc7LsZSacaApqOpYMejtQauRqrvJRu?=
 =?us-ascii?Q?vJ6UCJdBcn1kCyBRl3gPVoxiFbSPplG0MmbNNWBMZq6OVGxqT3I/J3G7UXFf?=
 =?us-ascii?Q?7a9rzXgOSDmIh6flgcBb1p6UFxKimff8NTUqNSnMpyg53mkW6WeFX7t1GJo9?=
 =?us-ascii?Q?FwBa9PwjquyMMU0Bg2XK/GeOBVxC11B2PrE+Fgr0+WmWgVLvJiCSwz++sLqM?=
 =?us-ascii?Q?9ev3sLgH8PyVKFJQ9lnrzvsJPN+P0aSXKlzhenUITOBsbtsXcjWEBHhdItBw?=
 =?us-ascii?Q?qQnC1KWSaaBoCKOSfoWdyHVgruuaM5ayIPfWrNAP1pmTgIPifdMrgcUaBGbW?=
 =?us-ascii?Q?PVvDCVk7kkpP3Rh+6aE7M8Qd/XGou0FAiW2j4DVDEecQ/sd5aaYrqZb3/jQJ?=
 =?us-ascii?Q?8wifGsdx16N633CjSwL3UkNIM0velmmWS4tqeK1TaMhCiGIaImvumYzPlJkF?=
 =?us-ascii?Q?CdOnyT2wFLjjiDNZFG+EZYSOqAMHl4jpukM4Auty/R41Mo+T1tdLH7oEK+bx?=
 =?us-ascii?Q?OUk7XtiWr5xoS4iYF4OaomDK3E/VQajFQRHLYIq2sknT4NWnJLXqFYKZVXSx?=
 =?us-ascii?Q?YSA2/gUXTPZKnSsVzYJRkXb63kjV/bkKAS75IzJ1p93kEn8Hm2h1tq+amQfB?=
 =?us-ascii?Q?jdrnWSzMQr2zduXhmSMrn+KpB5iMT5Cygl5IslNEUSLXX4FLnjCtuLbObNVv?=
 =?us-ascii?Q?uHw0zpS7HMJFqVDW+1qhQ3Yfr/2l/b7Xl6DsZ9mG6eM3r7IZOVe/EptYKR2i?=
 =?us-ascii?Q?+yby6DkPBpGZUfVxgqE8Ep/i0r2wJ5Bck2Oqypz5tS+OltvqaIUppcLiJPho?=
 =?us-ascii?Q?2a1RrVMCxAW830a3CltyS8fGuCGGJNG+ZP5GLJJa9iMUrsAB75a71V5j4eUT?=
 =?us-ascii?Q?ynQRYsVbeDNQkMp6tsSBqthjmFRZxXCFb9r4bCStka12r1IWveF9PpD2R0cL?=
 =?us-ascii?Q?+AJT5EF1m6y6IRsUuxEoR6aT60uec6i/F5+qqFTSOyVfOzf0F+bfsRHg8+MB?=
 =?us-ascii?Q?C6JzRmfzf7tc5RZPtQ32QkvIe673h9caUNLhYStCXbIuxmIcbQrkMcczV+1X?=
 =?us-ascii?Q?MzQmAevRceYvtkD7SROqGsBkyPB/3W0oh+uSaT3IgIlunBvRrbNtgdJfOhMN?=
 =?us-ascii?Q?U/pYzpzWJ7eFw/rqB6Jd2RqpoOqYskCtmREyszVUeoibCesA5tSfie/99RBT?=
 =?us-ascii?Q?UZY9fFS9oHErfUMY9nym6IXV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b5e858-c3e0-4bfe-2b64-08d94aad31c3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 12:03:17.6946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDsxjNwUCRvKEvk2wb93TBX3ZLrXr0IE6cSDiZ1HzEQlfRUtUcXeeuQWGaT7uO9J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5048
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jul 18, 2021 at 04:27:00PM -0500, Bob Pearson wrote:
> Make changes to rdma_user_rxe.h to allow indexing AH objects, passing
> the index in UD send WRs to the driver and returning the index to the rxe
> provider. This change will allow removing handling of the AV in the user
> space provider.
> 
> In order to preserve ABI compatibility for old kernel and/or rdma-core
> code keep the AV in the WQE at the same offset but move to the UD specific
> part of the work request since that is the only case that uses it.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> v2:
>   Moved AV from rxe_send_wqe to rxe_wr.
> 
>  drivers/infiniband/sw/rxe/rxe_av.c    |  2 +-
>  drivers/infiniband/sw/rxe/rxe_verbs.c |  3 ++-
>  include/uapi/rdma/rdma_user_rxe.h     | 10 +++++++++-
>  3 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_av.c b/drivers/infiniband/sw/rxe/rxe_av.c
> index da2e867a1ed9..85580ea5eed0 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_av.c
> @@ -107,5 +107,5 @@ struct rxe_av *rxe_get_av(struct rxe_pkt_info *pkt)
>  	if (qp_type(pkt->qp) == IB_QPT_RC || qp_type(pkt->qp) == IB_QPT_UC)
>  		return &pkt->qp->pri_av;
>  
> -	return (pkt->wqe) ? &pkt->wqe->av : NULL;
> +	return (pkt->wqe) ? &pkt->wqe->wr.wr.ud.av : NULL;
>  }
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index c223959ac174..4176fffa7fdc 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -605,7 +605,8 @@ static void init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
>  	if (qp_type(qp) == IB_QPT_UD ||
>  	    qp_type(qp) == IB_QPT_SMI ||
>  	    qp_type(qp) == IB_QPT_GSI)
> -		memcpy(&wqe->av, &to_rah(ud_wr(ibwr)->ah)->av, sizeof(wqe->av));
> +		memcpy(&wqe->wr.wr.ud.av, &to_rah(ud_wr(ibwr)->ah)->av,
> +		       sizeof(struct rxe_av));
>  
>  	if (unlikely(ibwr->send_flags & IB_SEND_INLINE))
>  		copy_inline_data_to_wqe(wqe, ibwr);
> diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
> index e283c2220aba..ad7da77dca04 100644
> +++ b/include/uapi/rdma/rdma_user_rxe.h
> @@ -98,6 +98,10 @@ struct rxe_send_wr {
>  			__u32	remote_qpn;
>  			__u32	remote_qkey;
>  			__u16	pkey_index;
> +			__u16	reserved;
> +			__u32	ah_num;

I'd leave this as pad[5] until the later patch when you can swap in
ah_hum/pad[4]

> @@ -168,6 +171,11 @@ struct rxe_recv_wqe {
>  	struct rxe_dma_info	dma;
>  };
>  
> +struct rxe_create_ah_resp {
> +	__u32 ah_num;
> +	__u32 reserved;
> +};

This hunk should be moved to the later patch

Jason
