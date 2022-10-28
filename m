Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8060861194A
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Oct 2022 19:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiJ1R26 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 13:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJ1R26 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 13:28:58 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702191FAE69
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 10:28:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6tj1RA07Ov+JgPXv8uUqifHmRy9AmlTI4Wl1HbHXaxF+WVwfaV5aSjwKrjAVjuWNAdsBqRak/2BemMI80AB7FI+9D5dVqGvoigwdmxwGmZOBXk4AlqYc8DriMIfUH8GcG/WSM5cyWiULQHbwHsNWHmgdSHjGSBf4+4moh2wy1KSUNo6+tVEtKDbNVZM0TVj0asxoxTcCMTT6AKFqxXPLdVEXB6TycwvOIxURnWY9bSDb1HPFhvK+BiQNdJfzNCWAjHyWRTkGjOA7FkCAQj9M7aacUFZuSdtIjHytwNvGcuX+Zif+VldSgZO5lkXgdmgjK3gEwWOpbaJrxCZRh6FCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hFlzJ1J6EKmx0MtPAKAF/RSBCjO7hSO9H36IODzQZs=;
 b=U88trhhJA6F81Fn8zKriaZTCjjeyXUDFGkETfSYc9gAoAqXD2N+Ug787UXYeGwWDJn5T7U+FjLoRRYJZwAVcMSg8Ah4G6GlNaySSEsmudvxpUNFqH6+9ush4Oo0NnHoVcTPUc/oz0jg616Uf9uyPKqh5loqFeaOs0KCMA5JF7YW1PalhjwmPHqfTOQ1Ozsk/ITnjHbvHEDpE6axKc5QS9PGOAmSEXi0umQ7+vTj1GEBEMlXktFiNgx+ars9qPwsfrVTS+2SHsmSrAkU8/AO66Ejh1pXHxLwlopSw97td/9M4QwGtFORlbM3gPIeu/s6P3YCBcoMofiK3OLWyy81dsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hFlzJ1J6EKmx0MtPAKAF/RSBCjO7hSO9H36IODzQZs=;
 b=Lcri2GF1vwRAHvDD+nMpSjGy7f8dSmMPZPueCy5zaFgILGaSVkqSjzZ+Hzrt0Sn81VqaphXJ1BhycNLsf6A6xE5y5bleLnvw6EUjv5rAPGZgnSN6rcCJARJqBpj/zA8s7UFIXwB09L1feYbsQB/eA6izRgHaj/FA1bCbtLyVIhWJjJsy06GaEbH74FEvUC1VypVhQk/t5DbWlNymVbMyBK1pJ8qrPp7XAGcTYHwG10SQ7P2LUtEwH2R5BdyXifu0CWmKamz+CGr8msmWFUq2hYp8ZeENHMIbDbafLKBamPEEhem6FYrn4MaLU/re5bzeiM5PjYzUOJB9NikTaZTx5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7211.namprd12.prod.outlook.com (2603:10b6:510:206::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Fri, 28 Oct
 2022 17:28:55 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 17:28:55 +0000
Date:   Fri, 28 Oct 2022 14:28:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/rxe: Convert spinlock to memory barrier
Message-ID: <Y1wRVlJS76Onp2vm@nvidia.com>
References: <20221006163859.84266-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006163859.84266-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:208:d4::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7211:EE_
X-MS-Office365-Filtering-Correlation-Id: e05aaaea-6ac9-4cb5-3a39-08dab909e3d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HYgqXw+vpIEp6MTnrYMlw4cmreQxXVXZ+eVc5N8ud3vFxyxDvuK7qV3suxSG205S61WU9/yfnOTxCt4ZCMEWqg1jof1gBOtNUn1Ff6uwg4UjM6nLLlbYJAkFrrdDERkZLPGj5kEnEO6ZZ69cI6uWJvN5+sAKFDAbmY9kt56ewPdDV4iIhiBVF+jPOgbBq+Z4sq7Oh38n3+aMFUbC8XAejKMODV+pSJmglR9jdkUuYE/Bqz4fm1vRt4UxsBBV2UZfss2d9FIUl6Yp4f4u5uyh18Am1i47Kj2FSwVv8jyaw7zGqYSgaUsjbt3yoaetOYEL0nlm1mEkwumD/EWWp4pEvQVvEiofHLyiP/Xjt2x+MQOzDztqWecgdnbdraIQUalq/6uVp3dWKxcL2pCjmoD06zpy747lvFV1oYDOlQUcraUDMBj/21iKnn3wEPmqPaO5zPisDFiTy+wTvboF5cY4+7KXJ2Ek0PRraxBFJDceYPjE5KhJhRdR5putKmNnI1Tehp10M13nkNkvDjpylPYFtvzalsxXnulqTViefc8MUBoYtlsyDqLUA0fYJDrQb5DNVffJpVA7oQsShJesKgqPP9zLyO7GMK4a1M71klxkyZr6F0jdQ8hewDAPNGCMblQsdZlfOBOshzlX3ebA+sfYRQ7sREIlBGZX6wjz+3NND1d2bAMKSLdp+HBlKT8tiy83483llBOsFWil2rDbQ/rOAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199015)(478600001)(6916009)(83380400001)(66556008)(2906002)(36756003)(4326008)(6486002)(41300700001)(66946007)(38100700002)(8936002)(66476007)(316002)(8676002)(6512007)(2616005)(5660300002)(186003)(86362001)(26005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CNFBjzMIrmjX9Y0PUkcuAScehOb64XfTzpYIJbVCJdwA/fZ5qc9dePyiolTQ?=
 =?us-ascii?Q?Xet3FTNQgVjH5ZuqHJeKPeJXnmLchAx9QkkPB64W5KqdI+vaM0BcV9BmtPzs?=
 =?us-ascii?Q?q9J6CqeUsPe/8I2Lmu0ukncjOpmlDEbb5J3Fry7A8iwK4rFS82KdqSxIc1tB?=
 =?us-ascii?Q?/c+m3/grdpI5caNgqE5vXhY73UDgjshGEKOLlSrDeHBPpAiKQgujYywiL2ku?=
 =?us-ascii?Q?RWiHAMLic0d6Dju5FX6+neUQssks3S+D0dAgmDnPpgYhGo38kCuGmaTYs6xP?=
 =?us-ascii?Q?Gu1KgEs7Tsg7c77VoYEMueITEvNY03khCGgbYYHTFDa+wy5+iIHNS2fy2UZE?=
 =?us-ascii?Q?vcXVXQIGyRGuQJX+HEMnfDBX5wropzJtGZuQelkPpVol/h9PnXFyVtM89iSE?=
 =?us-ascii?Q?hegWelnDN1auJ3x9JWO6RSWOV7hF3mmBdql161Yvi7aq5ZbSQS58VzPDsSfa?=
 =?us-ascii?Q?Rar9mPqcLBhlwucd5cpbU3eReUmSlMUaYXNT3mixxg6PCEwvSUUhbGxjdlPt?=
 =?us-ascii?Q?nfAE53V4QX0a7o9fgqMbguzK/EOeqVMj+iSy6zAygkx15amoKOgcMdm4yH0x?=
 =?us-ascii?Q?o/ebKsPbvie7fNYuuOuNKLyp9pxASyOuPdSORnqKTlZUVekfPM/rYTFPaXkU?=
 =?us-ascii?Q?X9KS5r1OceN6e2W+f/+y8HBBGqAW422xzgJtCxUCwjK1uAFx7zNAdegLBuk7?=
 =?us-ascii?Q?XzT8ACg2rz8AUrmKu8HFnl2g6Qs9c65DcQPo07yJ6uxD1AKCngHAH94baKry?=
 =?us-ascii?Q?6LyXr2XrLcIic3GECSkhkyEiCF8NTtMBAq+wl83QAQzbxBNkx9TlLmBijKx4?=
 =?us-ascii?Q?8wyuQa/IgeojU0dBngdxxDs9NSLnOTf1OYggc6JP5IvIiW2IP1ib3wuqIf6E?=
 =?us-ascii?Q?4N9g9RsMCkC9FIx774uNILLo4PoqytYGtmO1kzxmLw6nPe6QmJdtrCJ+vzxj?=
 =?us-ascii?Q?s4cphAh0nWsmuQxisUzhg2re1VJquP7vE2a7UP6pvUQzLwSCOoe2gzQ6b7+D?=
 =?us-ascii?Q?s2v3Px6hGCWc1EtK12McVOFfh15/y5YV55EppQe5vgpM7c7qtJyQmqAJXPOP?=
 =?us-ascii?Q?ij15lcEy6KP8b/DXlOcMH1ID+LIOlAQuNNqtWGwIoCCPXdj6gimd9uE7C7mG?=
 =?us-ascii?Q?uP+mL/4zjFfkTMw8YSc3SruKmQ9tA7DmVCV+9MQ81FCr/UoFYy7YJtltKIUJ?=
 =?us-ascii?Q?1Iq6qb6mRBQYjDuwVPQc5dK+MQE+jGhMfCm7LYHXHC5pQ6ebrovF61ePpuxc?=
 =?us-ascii?Q?SVfxXLMBvgBnF4ji8y7C/nsKfIrtHHNKiattewze55tMgTlVdn++oLo2SSTr?=
 =?us-ascii?Q?W5JosTeXNx6aGSD1Qwefne67dYOkZ64n2tC6ta90CRcVbMZAh4LlxSUnDRLH?=
 =?us-ascii?Q?9I/AQelfEiehOjBb9CVSkKGVv2lWlSje5bcY9l/bQcB/CjafcopWHarTrCwO?=
 =?us-ascii?Q?oGWr1nkfDi/MqnBDnIwl95s/Wyh3R5gxbht+qbyuMg1Z04Dm05Q3ZYJbx8HM?=
 =?us-ascii?Q?7+9604Q8K3eIb7qd53AXfJUBIl6hUxQRNP2mHqkb9cR1xY7TrO1Z58BT8pxe?=
 =?us-ascii?Q?KwMyTjnjelJKsNrowE4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e05aaaea-6ac9-4cb5-3a39-08dab909e3d8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 17:28:55.5726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N876FKDgpjx1o501GSnFpsSgQWhHzdcSeTHwHyjPbRnBFjKhzn9BmnlShBzvnvT+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7211
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 06, 2022 at 11:39:00AM -0500, Bob Pearson wrote:
> Currently the rxe driver takes a spinlock to safely pass a
> control variable from a verbs API to a tasklet. A release/acquire
> memory barrier pair can accomplish the same thing with less effort.

The only reason it seems like this is because it is already completely
wrong. Everyone time I see one of these 'is dying' things it is just a
racy mess.

The code that sets it to true is rushing toward freeing the memory.

Meaning if you observe it to be true, you are almost certainly about
to UAF it.

You can see how silly it is because the tasklet itself, while sitting
on the scheduling queue, is holding a reference to the struct rxe_cq -
so is_dying is totally pointless.

The proper way to use something like 'is_dying' is part of the tasklet
shutdown sequence.

First you prevent new calls to tasklet_schedule(), then you flush and
kill the tasklet. is_dying is an appropriate way to prevent new calls,
when wrapped around tasklet_schedule() under a lock.

Please send a patch properly managing to clean up the tasklets for the
cq, not this.

Jason


> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_cq.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
> index b1a0ab3cd4bd..76534bc66cb6 100644
> --- a/drivers/infiniband/sw/rxe/rxe_cq.c
> +++ b/drivers/infiniband/sw/rxe/rxe_cq.c
> @@ -42,14 +42,10 @@ int rxe_cq_chk_attr(struct rxe_dev *rxe, struct rxe_cq *cq,
>  static void rxe_send_complete(struct tasklet_struct *t)
>  {
>  	struct rxe_cq *cq = from_tasklet(cq, t, comp_task);
> -	unsigned long flags;
>  
> -	spin_lock_irqsave(&cq->cq_lock, flags);
> -	if (cq->is_dying) {
> -		spin_unlock_irqrestore(&cq->cq_lock, flags);
> +	/* pairs with rxe_cq_disable */
> +	if (smp_load_acquire(&cq->is_dying))
>  		return;
> -	}
> -	spin_unlock_irqrestore(&cq->cq_lock, flags);
>  
>  	cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
>  }
> @@ -143,11 +139,8 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
>  
>  void rxe_cq_disable(struct rxe_cq *cq)
>  {
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&cq->cq_lock, flags);
> -	cq->is_dying = true;
> -	spin_unlock_irqrestore(&cq->cq_lock, flags);
> +	/* pairs with rxe_send_complete */
> +	smp_store_release(&cq->is_dying, true);
>  }
>  
>  void rxe_cq_cleanup(struct rxe_pool_elem *elem)
> 
> base-commit: cbdae01d8b517b81ed271981395fee8ebd08ba7d
