Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33254A5E9D
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Feb 2022 15:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239535AbiBAOxy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Feb 2022 09:53:54 -0500
Received: from mail-dm6nam08on2077.outbound.protection.outlook.com ([40.107.102.77]:43952
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239625AbiBAOxp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 1 Feb 2022 09:53:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ggpw+ySp1UTNbvwdnT9a6LUoipBGtu+J+YmhUuj9KO3t6qWVwOTTSOpDx+iQ9cpTZPHGSKmSxVhHnd/mZ0GIwR0E01y289mVBh1TIvf/VUeqnx13XL5BHv6TuscoxIi7IvNn3cPLDf4J7QxFxt7Iq8zigD/uYUklQH2+4kljO97L5F9QKw8tya+4O0LF7kzGPvH0H4oSwdbDxi0oYO0nwCTxEdMN/LT//RmTNpiQ7yeCZ5cdHvtF3RGEV+K83pyDlhABQiwNfOdXfaFjti4qvXLb82LZYxu7g9B18SFj+F7a89uFuLVCX0Tr0DxLuxaHCcRz3CrqGZKgZgCPsv4nUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eprQG0tjlWDSK6OKG8bYhqcgggw1fIZoFKBgNnteWpY=;
 b=dZAjYhR7fpVejBUrhT91Or3KhjmzckOsprL79seekv3Fdvdubmk2RwqK6HWytnsN+BWaULVjERQ+E07OcYI9Cda7hdxC5FzP5+ZlbPcVjTdjDRvoUcsE4L5jIP7X1AUFL3KD10Hg//VJrJ4rBOqD7WLfDXz5L2ItYF5f8cUALkGrwobXDvuuqr+A7dx7A/sYz2CUWt8E3j9drFp64wVvMIEFUGgMSajcz1Th6kDIeIapeOW7CUlLsbAX/io3IPEqxUYEgzXVzDuB+GBF15d7Q+1xs7ja9X5/PqtsEA8+hezJE2tmKB3wZ0tH3vpK6/vg8Ys2M0SPNQXHrUeNv1zjTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eprQG0tjlWDSK6OKG8bYhqcgggw1fIZoFKBgNnteWpY=;
 b=XagRP+l9m7HUJZb2KF/UiW1ZXwjolUdRP9vyhtybpght87S237lf4pYfsVeHxnm/9x5dtIFYBjNsZPLWXiB5SgyTxWghW6ns9UlSDrBxa3SWWot7tfn2rQzymIWEpPoR53YqeNzIJkCsAI2Bifk9nFXSk+KylNsYQc1rDGXJV605gfYzlDruTxEvRfjnEjjvTe6vBmi8Ze/4mwDsnKmUHzGqeVyGNNt7h84p4UBF9xD+wNeEm9s4W1UwMM1I1qDk7SEku2ZyNmYNhs3Y7v6US5d2Ourrn1YCoxlOR5FAcdY+R5N4hOme70K5Ui8X2qjuv5ZHnWKnJvsLDq6psyBZrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL0PR12MB2436.namprd12.prod.outlook.com (2603:10b6:207:42::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Tue, 1 Feb
 2022 14:53:43 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 14:53:43 +0000
Date:   Tue, 1 Feb 2022 10:53:42 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v10 07/17] RDMA/rxe: Use kzmalloc/kfree for mca
Message-ID: <20220201145342.GI1786498@nvidia.com>
References: <20220131220849.10170-1-rpearsonhpe@gmail.com>
 <20220131220849.10170-8-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131220849.10170-8-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR19CA0044.namprd19.prod.outlook.com
 (2603:10b6:208:19b::21) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b789d65-7292-49b4-d708-08d9e592a45e
X-MS-TrafficTypeDiagnostic: BL0PR12MB2436:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB24362205B491D4188DD1BD79C2269@BL0PR12MB2436.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PykglQG24tMZSADFbAyPugLpliY15rzTKogJKhDBbS4kjNyUZVhIFe8Rew9/XNZsOtPH2XaICYwFSi8LQyVtUAvnAWgeD1iaohHrEod2zs1m1mRxW0uO/PuhFAKWyhetLTyWpynPZLi3nlZOBgkOLAlVmmosPdkEIytZpm6bG3STLjNHBi2BqXgveujT5rTxi3ihQ3wOLQ9imD/jJkE6tqUg4CHRlCgXjVUSvZXFG4ZBTE86+6+WK817oTBxcXsmqXdq3gR8TbA5ql8xP6PvwDvAKq7zZFpA83OUCUJt++BQwp1sBxjeQLxi4t2z9zt0y5WPGQarhUJYEDf6x1aWdg5+kguX9Y7BhBkmqsMTAqHjawUCuW/Zp7bislO68vXXQpQfFeoWYRKl5cHPSjFlqwaBhLlT7zf4/NwbfMFMNaQHw8tPgPFaaN/KaloracnprhxWlcjb61DlDy92kZQzR7DGhClvu0Z2EiqqdJrpE/zegzOw2rJnLZmzEqT1h/zNndX9RIDZo5XAAhOEGLSqPHxoe9so64zRVHL//+fdd8/eqOhmske7H7qpZhVRhlsR2EdcGMoWpqXlONdrFoSSAqPcvNCDhJd7iadt6vM3nE5mp/axgPRwQjfQxD65KKPuWGS4H7YgFG/ZEfO1C6+1mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(36756003)(2616005)(1076003)(2906002)(38100700002)(5660300002)(4326008)(66476007)(66946007)(66556008)(8676002)(8936002)(6512007)(6506007)(508600001)(33656002)(6486002)(83380400001)(186003)(26005)(6916009)(316002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jRRBt9TnG7wOaqqcTG+GJzhn3wblf0lQhpFyQd0UT/0rTtA9qVEY8gbCmcOo?=
 =?us-ascii?Q?nkNS6jiVKGWDXpTM09rzNSrv4E5RBzPaZsR9iN/gU6mcI83GmUyq1qI3V7Q0?=
 =?us-ascii?Q?WoEr2dmo5bMRg4J5a0nJr4Bo8/IFfcN9RqBWj1pGm/rhr5o8vgOxQgSYR5dS?=
 =?us-ascii?Q?aWRRpvbBc1KcWpie4Heq/VwAoBQQA9mL6xZfgGxBx/E71mQPEYaXx0Xp9KDL?=
 =?us-ascii?Q?nhCESLEiN54eQBD7EDxd+L5utwVwwWJU5cmtKB0spW1o0ule3K1CvUVQChL6?=
 =?us-ascii?Q?KOUAxyO/idErkoqvP2zCu6HN/j0+nDPrdw7EktUtjMj9/6ZC9vxq5yEnmcat?=
 =?us-ascii?Q?gJECWdARGZAiXrtfbuegAyjC/Gacx0/bl/VeyIqCxRTrfFJ3bRn8NuKYjmnx?=
 =?us-ascii?Q?45ftqHAjkNVbRt1aOAerjEORZ/cWBG2YXzRj/81RqV0ipAN/Emy4VcnI/5WK?=
 =?us-ascii?Q?n6ZapV5jmKUO31iZCuIfdeJTa1HqjdGQBLOg+mEwD3qJ3ezvkg994mPuLqID?=
 =?us-ascii?Q?lr0D66iSaVt5C261d4BFsYMwmYNbqRyZ1cRMwIxYLMWuqaFHszqVCZnOJQgo?=
 =?us-ascii?Q?CD7sjhXivISkvgqRObSgmte+F+JVAOZm+pWktPaNdj9g26ICBDsPtk9k1yVm?=
 =?us-ascii?Q?ldovBIE6teXraD16mixPrRVXD6hPElFn0b57+HJ94yViyhET7b4oPQZ8EqNq?=
 =?us-ascii?Q?Bu2NpjqjCbXGUIpB1uSpNyyBPhZ4dyMJL7wKgZbAp8//62d2L6n78aBwT6RU?=
 =?us-ascii?Q?NEdc79n5ZojIjAERLAA+jDRBZ5SX09ngoSuzzH4sghV+8VwtiK38dBtfHbvN?=
 =?us-ascii?Q?DLCOcTu71FTOB2tCZyDEru46odB7YhJvdy13r210zohPnwPOdTPlkAsNmaK3?=
 =?us-ascii?Q?NXJwgxHt3cPWZRAul/AgmrflYL6pvH9YyQaYEIqQ1qt169LgpV0ITxjEv3tI?=
 =?us-ascii?Q?EImSPIgorkxSJa91D7afpE3fYmDBBg2wLoFypm9CoqClZjgVSS5AzunwWe9k?=
 =?us-ascii?Q?K8G4OQPd5fv+Sv50AMp5jiS4yFYZ3+s3zcnc4lwJTVoih7SRjNPPRDrTTMxM?=
 =?us-ascii?Q?nDkgL0NvcACVEAZyR+AOXqkbF7A2lTlSQfqGTlF06W0wl+6plpZp9+vujSIn?=
 =?us-ascii?Q?EbNPmQJrWc92WkFsHkVp1SSjQTC1bUcn3QraucdyjrWWhpMZJ6WmPrfSfeYg?=
 =?us-ascii?Q?crh/lzcsizJME5hkNnidTrg7FpEGXGO9IIj99Bgi27SyMOFHbvacA4GjyFaP?=
 =?us-ascii?Q?VWroc7wwaQa8jWBMmHiInX6gvvww2Gv15U9mI52rikEm+rMGo0SoSyCzc2gJ?=
 =?us-ascii?Q?ThsHVbUhPnKt28lP4660iKFQB5r8IVGhwXMGs0QLOKJIITA/1xxYHA/BCQb+?=
 =?us-ascii?Q?KK5h4Hq443dEk84kEw30zPaGTB6CnO97Dj6BO0eJvDnOFiRSx9aywogg3tpK?=
 =?us-ascii?Q?wg5tbEZ9ALNcQiyGxdUC5BW7KlvHooXXZftEdpi2k6tvvGObVP476UPtSojf?=
 =?us-ascii?Q?DC6yLJF9oYDJ5qh7F9KEFYdp6nLcR6w6WB6Rmj7ncVDmW3RGGFzgNUbNhC9D?=
 =?us-ascii?Q?CRtMRmszzj312cCO9o0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b789d65-7292-49b4-d708-08d9e592a45e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 14:53:43.7175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x7fFhLRxnUy5oKa6g8zy5JwSb5isqfGUMFP8yZDIS8LQPGGlDoliR0Yb3yKUuvN3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2436
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 31, 2022 at 04:08:40PM -0600, Bob Pearson wrote:
> Remove rxe_mca (was rxe_mc_elem) from rxe pools and use kzmalloc
> and kfree to allocate and free. Use the sequence
> 
>     <lookup qp>
>     new_mca = kzalloc(sizeof(*new_mca), GFP_KERNEL);
>     <spin lock>
>     <lookup qp again> /* in case of a race */
>     <init new_mca>
>     <spin unlock>
> 
> instead of GFP_ATOMIC inside of the spinlock. Add an extra reference
> to multicast group to protect the pointer in the index that maps
> mgid to group.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>  drivers/infiniband/sw/rxe/rxe.c       |   8 --
>  drivers/infiniband/sw/rxe/rxe_mcast.c | 102 +++++++++++++++-----------
>  drivers/infiniband/sw/rxe/rxe_pool.c  |   5 --
>  drivers/infiniband/sw/rxe/rxe_pool.h  |   1 -
>  drivers/infiniband/sw/rxe/rxe_verbs.h |   2 -
>  5 files changed, 59 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> index fab291245366..c55736e441e7 100644
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -29,7 +29,6 @@ void rxe_dealloc(struct ib_device *ib_dev)
>  	rxe_pool_cleanup(&rxe->mr_pool);
>  	rxe_pool_cleanup(&rxe->mw_pool);
>  	rxe_pool_cleanup(&rxe->mc_grp_pool);
> -	rxe_pool_cleanup(&rxe->mc_elem_pool);
>  
>  	if (rxe->tfm)
>  		crypto_free_shash(rxe->tfm);
> @@ -163,15 +162,8 @@ static int rxe_init_pools(struct rxe_dev *rxe)
>  	if (err)
>  		goto err9;
>  
> -	err = rxe_pool_init(rxe, &rxe->mc_elem_pool, RXE_TYPE_MC_ELEM,
> -			    rxe->attr.max_total_mcast_qp_attach);
> -	if (err)
> -		goto err10;
> -
>  	return 0;
>  
> -err10:
> -	rxe_pool_cleanup(&rxe->mc_grp_pool);
>  err9:
>  	rxe_pool_cleanup(&rxe->mw_pool);
>  err8:
> diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
> index 9336295c4ee2..4a5896a225a6 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
> @@ -26,30 +26,40 @@ static int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid)
>  }
>  
>  /* caller should hold mc_grp_pool->pool_lock */
> -static struct rxe_mcg *create_grp(struct rxe_dev *rxe,
> -				     struct rxe_pool *pool,
> -				     union ib_gid *mgid)
> +static int __rxe_create_grp(struct rxe_dev *rxe, struct rxe_pool *pool,
> +			    union ib_gid *mgid, struct rxe_mcg **grp_p)
>  {
>  	int err;
>  	struct rxe_mcg *grp;
>  
>  	grp = rxe_alloc_locked(&rxe->mc_grp_pool);
>  	if (!grp)
> -		return ERR_PTR(-ENOMEM);
> +		return -ENOMEM;
> +
> +	err = rxe_mcast_add(rxe, mgid);
> +	if (unlikely(err)) {
> +		rxe_drop_ref(grp);
> +		return err;
> +	}
>  
>  	INIT_LIST_HEAD(&grp->qp_list);
>  	spin_lock_init(&grp->mcg_lock);
>  	grp->rxe = rxe;
> +
> +	rxe_add_ref(grp);
>  	rxe_add_key_locked(grp, mgid);
>  
> -	err = rxe_mcast_add(rxe, mgid);
> -	if (unlikely(err)) {
> -		rxe_drop_key_locked(grp);
> -		rxe_drop_ref(grp);
> -		return ERR_PTR(err);
> -	}
> +	*grp_p = grp;

This should return the struct rxe_mcg or an ERR_PTR not use output
function arguments, like it was before

> +	return 0;
> +}
> +
> +/* caller is holding a ref from lookup and mcg->mcg_lock*/
> +void __rxe_destroy_mcg(struct rxe_mcg *grp)
> +{
> +	rxe_drop_key(grp);
> +	rxe_drop_ref(grp);
>  
> -	return grp;
> +	rxe_mcast_delete(grp->rxe, &grp->mgid);
>  }
>  
>  static int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
> @@ -68,10 +78,9 @@ static int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
>  	if (grp)
>  		goto done;
>  
> -	grp = create_grp(rxe, pool, mgid);
> -	if (IS_ERR(grp)) {
> +	err = __rxe_create_grp(rxe, pool, mgid, &grp);
> +	if (err) {
>  		write_unlock_bh(&pool->pool_lock);
> -		err = PTR_ERR(grp);
>  		return err;

This should return the struct rxe_mcg or ERR_PTR too

> @@ -126,7 +143,7 @@ static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
>  				   union ib_gid *mgid)
>  {
>  	struct rxe_mcg *grp;
> -	struct rxe_mca *elem, *tmp;
> +	struct rxe_mca *mca, *tmp;
>  
>  	grp = rxe_pool_get_key(&rxe->mc_grp_pool, mgid);
>  	if (!grp)
> @@ -134,33 +151,30 @@ static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
>  
>  	spin_lock_bh(&grp->mcg_lock);
>  
> +	list_for_each_entry_safe(mca, tmp, &grp->qp_list, qp_list) {
> +		if (mca->qp == qp) {
> +			list_del(&mca->qp_list);
>  			grp->num_qp--;
> +			if (grp->num_qp <= 0)
> +				__rxe_destroy_mcg(grp);
>  			atomic_dec(&qp->mcg_num);
>  
>  			spin_unlock_bh(&grp->mcg_lock);
> +			rxe_drop_ref(grp);

Wwhere did this extra ref come from?

The grp was threaded on a linked list by rxe_attach_mcast, but that
also dropped the extra reference.

The reference should have followed the pointer into the linked list,
then it could be unput here when unthreading it from the linked list.

To me this still looks like there should be exactly one ref, the
rbtree should be removed inside the release function when the ref goes
to zero (under the pool_lock) and doesn't otherwise hold a ref

The linked list on the mca should hold the only ref and when
all the linked list is put back the grp can be released, no need for
qp_num as well.

Jason
