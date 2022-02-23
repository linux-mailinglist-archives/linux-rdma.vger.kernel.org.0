Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582BB4C1CA5
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Feb 2022 20:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244542AbiBWTw5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Feb 2022 14:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244556AbiBWTw5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Feb 2022 14:52:57 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2C24C40D
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 11:52:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=InU1jN340zBHG/xHJA2jkme065jbHLn8nEqAPwvUIX9McF37W4lyykTNb6zW/Avs2G6jg5fv21w3/Ll8Y2tvPIOVv/NVpj14HqPsAreoRp1a8e6k+9D+ozpK4l5H4YrZyJkhT2otSWHsLoUsTDoFwLYbn5hSrDAm019gBZ1yVxYA1BN6dtdDQ9KKt3ftpgbd4Ii6r11gO4MxBpUnKEZwUjOsuJnYojx7H0xXfFR1wBTfwCG6AiO35F3dmpN1t3O6/ETZmJen1hI9GKAL0jzQQAqJLOraa4RKB1/KuP4uhaTq5z/9GWxG9J1dL9vmOCK5XdW6URJAN7kXb+CoLYQzng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VbtUo4kHi582C6fdYnR7eP7nysoCZE49+w7abn0NxQ=;
 b=mym0BSr1BOWguAHB8/CCnT8JXh5XIF2Rr/GTk4RYuF/IasBKfgxz4ch5HW+GycosC95g99dlPJ93SRjDn8xxlAsbPrjSdxYTGQzmAU4ELTr7Bp5Zn3UY2Vqdm5D3z/A52JN1PuDgi+S+bN4sp/ytbJTopxo/Ea9zbTZyiYzpwnInVbMYO4R1jv6j31RNyIDG2n0w/mXoBSslrVVc0KqUBb6jh/lwbtfEJ41wuj1jiZ3JzL2fNO/9QiJPqOCOjTwAyfbHAnnCK0KkvBrb+Hp263nUHoRaUxalrmcOUf0bN0RLMkfkQivCzys7S6cgXKUtih4prPJ3GsyP5xTtOXpP9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VbtUo4kHi582C6fdYnR7eP7nysoCZE49+w7abn0NxQ=;
 b=CMXYpx9t3px4CJAdngF5ldITxnMPHzc2s5kOq7fWsdV2tF48PNO64rlIilqKubMJd8zqLVFC7JFYN660BVlHsqxyI5EOnRrig1OKO3VTv58EYkmL4w0J+VaGDa3lBW/rJnq/Zs+uOkVtnr+RBL5RTfohk477i42WFm82FmXYG15AmuGiZhPlVIjH5re9c0HAnT3EEO6GPmBhC31z7FuFhtT9En25CrcnWUYsYZu6OYZ7X7q2mJfbSCWw/AURbERyhumZW833io9o/tJ0Epw3vcSII73yiZqdCsXHvN+euFHWcCCKzqpxrTQRS6FyQr3WQmOzohFPEAMGtSVK2SNVyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN9PR12MB5178.namprd12.prod.outlook.com (2603:10b6:408:11b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Wed, 23 Feb
 2022 19:52:24 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.5017.022; Wed, 23 Feb 2022
 19:52:24 +0000
Date:   Wed, 23 Feb 2022 15:52:22 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v12 6/6] RDMA/rxe: Convert mca read locking to
 RCU
Message-ID: <20220223195222.GA420650@nvidia.com>
References: <20220218003543.205799-1-rpearsonhpe@gmail.com>
 <20220218003543.205799-7-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218003543.205799-7-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL1PR13CA0308.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::13) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 617269f3-76dc-45b0-8acd-08d9f70602d2
X-MS-TrafficTypeDiagnostic: BN9PR12MB5178:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5178E3D49B6B4CF28A9310FEC23C9@BN9PR12MB5178.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C7sbXwSRJtXq6iU32pTQkZotWNV/kKC7y3+DhFD7i8axLweujctUdNPH6yLc6FGkXZ9rZALHj6uG1UEMZbT+rWelmqj1rGUXyPtjUe+TPFITvFsr2b8ssXQYsBzxE8+7YTiIpZLr6WYY2FGENNt1hpZCrTJJnl44cY8G6nkZajYXSQMTEkV5vIFCWhxvC+9lUYTTJzzafHgyZK89g6zb/hMfzfYplfBwmmrna220nWUT0aAA6g09gkfy4rr/y1VAladmMBqoloXX9Ysf/5jnttRPObg+kPXnPz9oCzm5wKRWCbEU072NHCjIGUrsHWBZFjW+mfwIWyx+SyZ1KbD020SE7gbwAxBPS4RfoCVF4spi3O9iTraOd/5LzotjJFR+MFQcoz/3iQb5BeKbIJmx1w1VZrriMkeAD8wlER3SZgyvS9ro9dWeL1PKk/fvmhwlirvQBbFLZTlFayAt7SpF/YflMQ5+myOSiU6Sa/PC3mqF1NqZdvndCumzLs0ZSfRJ1H+uJykVuk76hth242n7GS9+QbqQaqIz/hkB489iauW3zWTmI6NJPyv2RfFQPDLCr5fLd3Y0T4EmiTuG8BFeEK0rU8MXZyZs800HRZZ21NWim35maj+Rc9Voh5bs2tPrWTQJMJhj4TpSg8iRUI6VC7GrMv1aBoLnCpEAWajLJhy0AhKES0ib/GHyUBKF8wUU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(66946007)(6512007)(66556008)(508600001)(66476007)(26005)(6486002)(6916009)(1076003)(316002)(86362001)(2616005)(8676002)(6506007)(83380400001)(4326008)(38100700002)(5660300002)(8936002)(33656002)(2906002)(36756003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EmB2gvF1Cb+ZBLVh3DkPaeRx26YiOadDT/RsnyIbaDsDKmJcNeO85o4Z5636?=
 =?us-ascii?Q?tAYu6od7wbiy2v/ZpG7n0Bi+UF8dg/d3mZrwWiOpmWBHkwKpbLPyzwoc3IGl?=
 =?us-ascii?Q?SIpva0Yfym8wEFo5Ps933YQ6BU72+NL4Gt6E6EKNwfsMkX/9BTl9gXii9wfK?=
 =?us-ascii?Q?eDoqC/jeyx8KSj7CXwzAzXPYf5B/8cI/9CfSKVrz2Jsz4eXzi7gIg5F0y4Nl?=
 =?us-ascii?Q?rInr/9xdry8+fY63OBse4a41jneh5NWwwKhyzZyGwetOjFJgoMvHliqx43Io?=
 =?us-ascii?Q?PDLpb1bNxb70m0nN7plqOirG8U827Ya/noH+ADPYU8/YlzaF6fq8OYGLNLFV?=
 =?us-ascii?Q?9vQDnZcv5BU4Tmxqy70IaNdAEq6Bqd+yDbohaoYhxe8ztCOPHMqi1Ay0/q1f?=
 =?us-ascii?Q?pxFbdGqunN+tM6nyLQwhSwx6qYiiJtrqLx9ocyJGbcJayXKlpe7ckiXLnmfL?=
 =?us-ascii?Q?4YbK97AHxwSDDfhNHV3VdGhpvthvbtEy3WLxmyGvVrjlQB1l6c/1h9N3keg/?=
 =?us-ascii?Q?P0kxRLlm8Px6BBfXeidyNfDtlU3ntTw8JpBk5S2NSqh5m4wRCES5KkPfO6b0?=
 =?us-ascii?Q?YpQo4nWo+o01ksvuqYEghczgh8asP81KRzwYsAuXCBSKLF1aK5i+jcOMfz9b?=
 =?us-ascii?Q?3jKbQ8zce1HjXPCtRVYWxJ3sRHGIB7JPvzqzAAMKauz7IY72k9YGzUh2CvCy?=
 =?us-ascii?Q?GpziBByLIHsLlVRI/Ll5WFRCJwQ5l8ZrfOf4uu3lV4V9MQbfbrIQ9JnjerlD?=
 =?us-ascii?Q?GZvp1aPmP/XSztKRQOVPt9/xZAF+RNHq0zPqjnRmwj/aTajMKkqipkptGz41?=
 =?us-ascii?Q?Lmnivl51xlB8puGOxmnQ1Lt44bYbVS8lRY91GIKhVCWHPlJUxLvRmYDZT3nw?=
 =?us-ascii?Q?v1F6RKwYGc6E9rALUTkZ6ttAdWtomOEvKrTtXN8qK7j9kqI0Osk4rhFbAjjm?=
 =?us-ascii?Q?KJQ71BoZsgCLmyfojINX2lrZQ5cPcgdizmTt2DPdkFngM0cGoDggPI7/BeD/?=
 =?us-ascii?Q?xZruD+9chLPTk5afnDi0szwUJKV9yB4mWw+KMyfBDaPNrFH8FWt1W4pi90dS?=
 =?us-ascii?Q?KYjKV402Mb19Y/+VtlKfCWxM/uAnt8M6Ufx1Q1+i9APyUgDQXD0fwuAkQOB0?=
 =?us-ascii?Q?mBA0Pa/Ntdxw1Yt1oPttWD35enGfb6KikP/Ceko/nkmYN56b+Z4hKftH7ujx?=
 =?us-ascii?Q?5SClyg+GwgwgK6SvHIpCh29vC/47YpExvAm53HrDdbLBjulkpxc4h8glu23i?=
 =?us-ascii?Q?ryD6WKh7vmbVWbN3IsI7yzszwfemC9tIlDdpui9CXiWnwHKOqjJMF1Matgh/?=
 =?us-ascii?Q?piEJP60gBIMLkKHOxymMcDSkUFfusICCkbMtpNwkukQ8YgkRbzRKZHBfZsiL?=
 =?us-ascii?Q?ioNaLJ1GhZzQsCb7NfWz08JubbD+d4vRI5MTmupBFyezt2Y8nGFeBT+lls/K?=
 =?us-ascii?Q?aOFoUW7Rd361npp+/1pyz56fF4oNLIBCULrhMeWizcxNbh5DxjmBmBQCiOpw?=
 =?us-ascii?Q?RpVPpoMzchKujGK5AO+UxXK5N24YPqTzd3nYawLhSXDa3rs8C8AUBIKcTXI+?=
 =?us-ascii?Q?Pm0AEfKucy/+1nxsWrA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 617269f3-76dc-45b0-8acd-08d9f70602d2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 19:52:24.0115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vV3oqxa03DQtLbCqWYYge+LOoSgMp9FYss/a2Z3TBR4OnHcHbmMYxBB86kARUnJf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5178
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 17, 2022 at 06:35:44PM -0600, Bob Pearson wrote:
> Replace spinlock with rcu read locks for read side operations
> on mca in rxe_recv.c and rxe_mcast.c.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>  drivers/infiniband/sw/rxe/rxe_mcast.c | 97 +++++++++++++++++----------
>  drivers/infiniband/sw/rxe/rxe_recv.c  |  6 +-
>  drivers/infiniband/sw/rxe/rxe_verbs.h |  2 +
>  3 files changed, 67 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
> index 349a6fac2fcc..2bfec3748e1e 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
> @@ -17,6 +17,12 @@
>   * mca is created. It holds a pointer to the qp and is added to a list
>   * of qp's that are attached to the mcg. The qp_list is used to replicate
>   * mcast packets in the rxe receive path.
> + *
> + * The highest performance operations are mca list traversal when
> + * processing incoming multicast packets which need to be fanned out
> + * to the attached qp's. This list is protected by RCU locking for read
> + * operations and a spinlock in the rxe_dev struct for write operations.
> + * The red-black tree is protected by the same spinlock.
>   */
>  
>  #include "rxe.h"
> @@ -288,7 +294,7 @@ static void rxe_destroy_mcg(struct rxe_mcg *mcg)
>  }
>  
>  /**
> - * __rxe_init_mca - initialize a new mca holding lock
> + * __rxe_init_mca_rcu - initialize a new mca holding lock
>   * @qp: qp object
>   * @mcg: mcg object
>   * @mca: empty space for new mca
> @@ -298,8 +304,8 @@ static void rxe_destroy_mcg(struct rxe_mcg *mcg)
>   *
>   * Returns: 0 on success else an error
>   */
> -static int __rxe_init_mca(struct rxe_qp *qp, struct rxe_mcg *mcg,
> -			  struct rxe_mca *mca)
> +static int __rxe_init_mca_rcu(struct rxe_qp *qp, struct rxe_mcg *mcg,
> +			      struct rxe_mca *mca)
>  {

This isn't really 'rcu', it still has to hold the write side lock

>  	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
>  	int n;
> @@ -322,7 +328,10 @@ static int __rxe_init_mca(struct rxe_qp *qp, struct rxe_mcg *mcg,
>  	rxe_add_ref(qp);
>  	mca->qp = qp;
>  
> -	list_add_tail(&mca->qp_list, &mcg->qp_list);
> +	kref_get(&mcg->ref_cnt);
> +	mca->mcg = mcg;
> +
> +	list_add_tail_rcu(&mca->qp_list, &mcg->qp_list);

list_add_tail gets to be called rcu because it is slower than the
non-rcu safe version.

> -static void __rxe_cleanup_mca(struct rxe_mca *mca, struct rxe_mcg *mcg)
> +static void __rxe_destroy_mca(struct rcu_head *head)
>  {
> -	list_del(&mca->qp_list);
> +	struct rxe_mca *mca = container_of(head, typeof(*mca), rcu);
> +	struct rxe_mcg *mcg = mca->mcg;
>  
>  	atomic_dec(&mcg->qp_num);
>  	atomic_dec(&mcg->rxe->mcg_attach);
> @@ -394,6 +404,19 @@ static void __rxe_cleanup_mca(struct rxe_mca *mca, struct rxe_mcg *mcg)
>  	kfree(mca);

> +/**
> + * __rxe_cleanup_mca_rcu - cleanup mca object holding lock
> + * @mca: mca object
> + * @mcg: mcg object
> + *
> + * Context: caller must hold a reference to mcg and rxe->mcg_lock
> + */
> +static void __rxe_cleanup_mca_rcu(struct rxe_mca *mca, struct rxe_mcg *mcg)
> +{
> +	list_del_rcu(&mca->qp_list);
> +	call_rcu(&mca->rcu, __rxe_destroy_mca);
> +}

I think this is OK now..

> +
>  /**
>   * rxe_detach_mcg - detach qp from mcg
>   * @mcg: mcg object
> @@ -404,31 +427,35 @@ static void __rxe_cleanup_mca(struct rxe_mca *mca, struct rxe_mcg *mcg)
>  static int rxe_detach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
>  {
>  	struct rxe_dev *rxe = mcg->rxe;
> -	struct rxe_mca *mca, *tmp;
> -	unsigned long flags;
> +	struct rxe_mca *mca;
> +	int ret;
>  
> -	spin_lock_irqsave(&rxe->mcg_lock, flags);
> -	list_for_each_entry_safe(mca, tmp, &mcg->qp_list, qp_list) {
> -		if (mca->qp == qp) {
> -			__rxe_cleanup_mca(mca, mcg);
> -
> -			/* if the number of qp's attached to the
> -			 * mcast group falls to zero go ahead and
> -			 * tear it down. This will not free the
> -			 * object since we are still holding a ref
> -			 * from the caller
> -			 */
> -			if (atomic_read(&mcg->qp_num) <= 0)
> -				__rxe_destroy_mcg(mcg);
> -
> -			spin_unlock_irqrestore(&rxe->mcg_lock, flags);
> -			return 0;
> -		}
> +	spin_lock_bh(&rxe->mcg_lock);
> +	list_for_each_entry_rcu(mca, &mcg->qp_list, qp_list) {
> +		if (mca->qp == qp)
> +			goto found;
>  	}
>  
>  	/* we didn't find the qp on the list */
> -	spin_unlock_irqrestore(&rxe->mcg_lock, flags);
> -	return -EINVAL;
> +	ret = -EINVAL;
> +	goto done;
> +
> +found:
> +	__rxe_cleanup_mca_rcu(mca, mcg);
> +
> +	/* if the number of qp's attached to the
> +	 * mcast group falls to zero go ahead and
> +	 * tear it down. This will not free the
> +	 * object since we are still holding a ref
> +	 * from the caller
> +	 */

Fix the word wrap

Would prefer to avoid the found label in the middle of the code.

> +	rcu_read_lock();
> +	list_for_each_entry_rcu(mca, &mcg->qp_list, qp_list) {
>  		/* protect the qp pointers in the list */
>  		rxe_add_ref(mca->qp);

The other approach you could take is to als kref_free the qp and allow
its kref to become zero here. But this is fine, I think.

Jason
