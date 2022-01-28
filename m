Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330E44A003C
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jan 2022 19:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239540AbiA1Sj7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jan 2022 13:39:59 -0500
Received: from mail-bn7nam10on2059.outbound.protection.outlook.com ([40.107.92.59]:8033
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236970AbiA1Sj6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jan 2022 13:39:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/5QmjJrtl/fzVWQv7g2ZR9CdkseRK/W1dxftgzJojmecEdfFhsVOmxKuHMTG3aoTpp937UVo6jhSlnS9M67dgLVXYT46Aulfyqi6Evyuqx4192fyVYgkgPHwyTeDRJcG8yyD3Q3DwHuQTLkmhuDXEUdlPeuA8Zu5jXsbGoFG/eiG5qopCTMcEp1+89aMMym6zBKXWS0cc8mDW7cVDa0p3gb5+vjGKoLbbHwUjtpFZg6Pze554j+MMyniRVgu6gg4FZ2y2Rov05hA6QDhLhunMU+3L14XTwFTD2prW4RPIxmpACJ7TAzrazgmuO3TNbp/1FO11er4ZshHoZ2BSAf9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GaYGwvA6bE2LGsHxjWto296/0GuCCPZDqJOEwWE1nlc=;
 b=bNI7beRGkDvDuPqnAwJhblSfYP1As3dLtQJwbll8hPJD01xX3DeAzhZT+c+SiWHLDETm7jjn1WeYXu119D42yGH6PTkIbuc1swwnIOZo2qLYSSHci3xjSks62ld21MvJhC0L+dPQz1PUVmXjO2x1Jztx2EP9GWKNNNitef3FnvacL9DXu6Y6XLKEweN7fhRnjjMcH9hdYE3rvKTxOGOEtxkvGUuIMg6tKr13MM/X0Wmr8Vfjl5luzQCyVfPNg0s1hqJWhOSGgmtMB3CdNtFISZrIguiQKdu5PD1Cb9g6jeqte+lCqpa4AgCul8PYCNsAijroyyxdLBx/6gF+RABl0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GaYGwvA6bE2LGsHxjWto296/0GuCCPZDqJOEwWE1nlc=;
 b=Dak6hRWr5AnYqY9MITOhYNSGH5VuKJVRQRwBoZv47/ndSF0iMsA9kGn4P1b70yWfBFIc98Q6GfsEBYUvvH0SUXyHJjbtUPZtTr1bzVC4+NIK+4NC4eI8+2FS7xsGpjN6QjH1dnfzmmw3NPhSyyxwDiORRqgYflC3imUMdz7DmdIn163tLbrXG87PbyrlQU0y76bk9NSSBsTXu7U50qGU1MjMRCy/soJEF70yk2cMD7NzbW/huZ3j0TmpjVhcAPTgQdoTsKwErqGse5dG+xZIN2S5DuNE+CcJrU9M7Yh/vj/d06Rx9RSdumKW839EGD3ptpl15URqPeS5maoHOIQp4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB4989.namprd12.prod.outlook.com (2603:10b6:208:38::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 18:39:57 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4930.020; Fri, 28 Jan 2022
 18:39:57 +0000
Date:   Fri, 28 Jan 2022 14:39:55 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [RFC PATCH v9 18/26] RDMA/rxe: Convert mca read locking to RCU
Message-ID: <20220128183955.GG1786498@nvidia.com>
References: <20220127213755.31697-1-rpearsonhpe@gmail.com>
 <20220127213755.31697-19-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127213755.31697-19-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL1PR13CA0166.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::21) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c04e7a4e-8686-414c-9c47-08d9e28d9503
X-MS-TrafficTypeDiagnostic: MN2PR12MB4989:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4989A124A3155B15EBD80C75C2229@MN2PR12MB4989.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FA9KH+nTjzo6sSaw38fuxrmXoK9T9drIo4xnZzW7PssBEdqcv7nbJkLwkHLc+GqflWENCjowDiOlWKftaM/dwgtEp9us0nTnmO2bI1go62SGOIQ0uca1i3WVB58XkZlIpNB5LG9kCPiQDkDyd6ktYVt8jRTBuqh39mS2QBV7oaAFhC5sh+52kTjTwHxyJqUVg2pfNMfCzN6GwC7c9rTEYIGcUYkQjndUEuKjrMks80YyktePWZL2B43q8x1yOHZ0pxpk/OcxpiZqB4jSSnOZwjIJD0dc1VX0OTcjut57+6AkVgR5LlxaFDeiiiUSXIZXHdwYQnECDgn7qCIZ8jMasq0WV51FkaYsKgYV7ktBkhOPfBg78EpCDYtVo7XRoPWDJovQDeg8dO8XoJ+0+QxXkNOG94E7GKZ95IPF4U2aDni0paTTjZNlMqX6gWX2U9mC+lISxv7yHMt3Q7NL3HRKZhhLoXCDn7IaqO5UPbGblaZKukl7fIN3OiIpnBTqa5tiAKwlfLDR9uGvN1bGVZKOTok7NhfkEIgAJ8UUyxaHa6dp0awB4SBrDLYr8ndwwp6m0QJTLhYsQstZ38pofJ/L05FxsI/tc/jVuPtlqGzRnWYQslXYIPIuvcFeF6EhqFXrabnUnH+CNcdgkT7aON+8Yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(1076003)(6486002)(6512007)(186003)(316002)(36756003)(2906002)(83380400001)(5660300002)(26005)(6506007)(6916009)(33656002)(86362001)(38100700002)(66556008)(66946007)(66476007)(8936002)(8676002)(4326008)(508600001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eQvghDN6JkKNtopKAtq59G8EyT23rUqTOHrdVeRq5nHsLKqHu1CTf8n7MTyV?=
 =?us-ascii?Q?hejQRk9PFqnqrsonJ9za7LPcVOpdkbIYYRS2HHREaRoIV2R5ai0c7250Fcoj?=
 =?us-ascii?Q?Bf5hBRs2iUodJntL6lsSl0DER3tzklUMJulHj5NV9j+o5tfUcRg5QqUBOzVV?=
 =?us-ascii?Q?mXG11Wzwu/ZyxPmMuNaBKL9eqz1tCCjcTrpzg4pI2jZCymRiYMdfnshFj4se?=
 =?us-ascii?Q?8ym8TdorJlJmDNkDEAAaIiVPaDKKNswZ+mOE5WlVNvZ69da7OoD0UgTMiQRQ?=
 =?us-ascii?Q?mkwUVaDCXTt3H+bdRb0aLO7agiU0sct3uJSCxSiUu+8t5ZY50n604GhfHJcJ?=
 =?us-ascii?Q?sxavEpcDDfGWwxwoNfK0IBeo5doiXIzBIuSwzE7HWhbX1F5RUWDEJBIyy1gp?=
 =?us-ascii?Q?CYx6kx66sA+alBVgNfuLHm7tBYZM9JZa1DRWBA0mlRIE7G52Xtyj4+iMQlCs?=
 =?us-ascii?Q?5Q2sVzBAF5uk+A7JP199fpI8wv/7A9DOE2wKEFIKPV7F2RoNDBV7FHoMO2GK?=
 =?us-ascii?Q?zfRCruBmWnHZvrHc2ecZOrQMf0DZ1iKxv/IVfz0sM7eQqEvWCQjdzKwVn0MV?=
 =?us-ascii?Q?6wv6clf6uHaK3CHM3d7j/sV3ozj6LG6kora8KWLFRyuI5OF7B5a/yYaVYfo7?=
 =?us-ascii?Q?5H1UN1fUshMN7GqM7nb3N1/H7/jXXQB5RBREAPgrpm3MCGBifspngGzl3LNc?=
 =?us-ascii?Q?Ey4J+v8+R5zOAdo+B/X2fsgmjBI1csHaCik8JbUOSqiJBJG8DrpfvETnoi3k?=
 =?us-ascii?Q?RY6u52EoulNJW9WgQDgT5htFm0bAVULrKgIPYIahTMa31Yi/UkFKcnmah1mM?=
 =?us-ascii?Q?5NjQu/tjdRUgqZ6DTnA8CKEZ+SlGf9WiI/3EAqy3g5GZD5BpAVw7gPK7B0ij?=
 =?us-ascii?Q?IuK13DAjs/lpeCpd1StJIPkKXAGbwADA6n6UAv6AmJLuKF3Fa7TvIPD0BEq2?=
 =?us-ascii?Q?YINIqmtF29dxCXfTDjXVSvRP0uvPK9rVI1K0RlhJRDePVSDKy6/9HXHXFLNt?=
 =?us-ascii?Q?DnMXS23pX2qdrS6FIKIo/53gqDUQDAMJRgMKEXXDKuoxYPtfvNhejlm01qm6?=
 =?us-ascii?Q?5I3fNsABwpTmU1Qv4rvDfOXl6djmPMLNmCJkGKcD7mAo948gQmGtXwQD23YR?=
 =?us-ascii?Q?mqSPqhNJaD2L8WlKXSjDEKvXuiy564uqyHR9X705UTWCIESmj7S9y9B+S/Vm?=
 =?us-ascii?Q?wRJkdA1xVUljA99qSlOs+517AMNLlmVCGSscwJQpPydTXESZxEeI6pZuP6wv?=
 =?us-ascii?Q?yAuYtLqMMRWWHd+gvZC6fnojwmLhsAAQ7r7M0H2TDYZIwI+2V0E5BAW+xxR5?=
 =?us-ascii?Q?EpTGqdGohJTMGc60S3qCXG+gk229Rq3eP0ONJwRWi4UE8ghUohA7EVZm+R/i?=
 =?us-ascii?Q?OeShxeiOYvcOK/uYRXAtsTZGeVaIKob3EdlKhgtE9uFx/ZsALfN5L/VY9opA?=
 =?us-ascii?Q?qxyiP5+wEq3TnJH/8/7KpSVSQGzMedWkdiA/881QapVKrOlSNG0ptL3JCsMd?=
 =?us-ascii?Q?U4gvUSeye3PWniIi5iyEtzONdF5IKOrrARqnu0/aasG9ajv6uNtCpYGnibWC?=
 =?us-ascii?Q?7Qnz8I3p8BXlZrUXaUI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c04e7a4e-8686-414c-9c47-08d9e28d9503
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 18:39:56.9975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q4grEwNmndhP5SnynUjKqoYHgtKqukIYj3hxPBbA3FRErZf0ilWslKXUbhh6KjEo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4989
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 27, 2022 at 03:37:47PM -0600, Bob Pearson wrote:
>  /**
> - * __rxe_init_mca - initialize a new mca holding lock
> + * __rxe_init_mca_rcu - initialize a new mca holding lock
>   * @qp: qp object
>   * @mcg: mcg object
>   * @mca: empty space for new mca
> @@ -280,7 +281,7 @@ void rxe_cleanup_mcg(struct kref *kref)
>   *
>   * Returns: 0 on success else an error
>   */
> -static int __rxe_init_mca(struct rxe_qp *qp, struct rxe_mcg *mcg,
> +static int __rxe_init_mca_rcu(struct rxe_qp *qp, struct rxe_mcg *mcg,
>  			  struct rxe_mca *mca)

There is nothing "rcu" about this function..

> @@ -324,14 +325,14 @@ static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
>  	int err;
>  
>  	/* check to see if the qp is already a member of the group */
> -	spin_lock_bh(&rxe->mcg_lock);
> -	list_for_each_entry(mca, &mcg->qp_list, qp_list) {
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(mca, &mcg->qp_list, qp_list) {
>  		if (mca->qp == qp) {
> -			spin_unlock_bh(&rxe->mcg_lock);
> +			rcu_read_unlock();
>  			return 0;
>  		}
>  	}
> -	spin_unlock_bh(&rxe->mcg_lock);
> +	rcu_read_unlock();

Ok..

> @@ -340,16 +341,19 @@ static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
>  
>  	spin_lock_bh(&rxe->mcg_lock);
>  	/* re-check to see if someone else just attached qp */
> -	list_for_each_entry(mca, &mcg->qp_list, qp_list) {
> +	rcu_read_lock();

Do not hold the RCU if you are holding the write side spinlock. All
mutations o fthe list must hold mcg_lock.

> +	list_for_each_entry_rcu(mca, &mcg->qp_list, qp_list) {
>  		if (mca->qp == qp) {
> +			rcu_read_unlock();
>  			kfree(new_mca);
>  			err = 0;
>  			goto done;
>  		}
>  	}
> +	rcu_read_unlock();
>  
>  	mca = new_mca;
> -	err = __rxe_init_mca(qp, mcg, mca);
> +	err = __rxe_init_mca_rcu(qp, mcg, mca);
>  	if (err)
>  		kfree(mca);

Which looks since the list_add is still inside the spinlock

>  done:
> @@ -359,21 +363,23 @@ static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
>  }
>  
>  /**
> - * __rxe_cleanup_mca - cleanup mca object holding lock
> + * __rxe_cleanup_mca_rcu - cleanup mca object holding lock
>   * @mca: mca object
>   * @mcg: mcg object
>   *
>   * Context: caller must hold a reference to mcg and rxe->mcg_lock
>   */
> -static void __rxe_cleanup_mca(struct rxe_mca *mca, struct rxe_mcg *mcg)
> +static void __rxe_cleanup_mca_rcu(struct rxe_mca *mca, struct rxe_mcg *mcg)

Also not rcu, list_del must hold the write side spinlock.

>  {
> -	list_del(&mca->qp_list);
> +	list_del_rcu(&mca->qp_list);
>  
>  	atomic_dec(&mcg->qp_num);
>  	atomic_dec(&mcg->rxe->mcg_attach);
>  	atomic_dec(&mca->qp->mcg_num);
>  
>  	rxe_drop_ref(mca->qp);
> +
> +	kfree_rcu(mca, rcu);

OK

>  }
>  
>  /**
> @@ -386,22 +392,29 @@ static void __rxe_cleanup_mca(struct rxe_mca *mca, struct rxe_mcg *mcg)
>  static int rxe_detach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
>  {
>  	struct rxe_dev *rxe = mcg->rxe;
> -	struct rxe_mca *mca, *tmp;
> +	struct rxe_mca *mca;
> +	int ret;
>  
>  	spin_lock_bh(&rxe->mcg_lock);
> -	list_for_each_entry_safe(mca, tmp, &mcg->qp_list, qp_list) {
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(mca, &mcg->qp_list, qp_list) {

As before, don't hold the rcu when holding the write side lock

>  		if (mca->qp == qp) {
> -			__rxe_cleanup_mca(mca, mcg);
> -			if (atomic_read(&mcg->qp_num) <= 0)
> -				kref_put(&mcg->ref_cnt, __rxe_cleanup_mcg);
> -			spin_unlock_bh(&rxe->mcg_lock);
> -			kfree(mca);
> -			return 0;
> +			rcu_read_unlock();
> +			goto found;
>  		}
>  	}
> +	rcu_read_unlock();
> +	ret = -EINVAL;
> +	goto done;
> +found:
> +	__rxe_cleanup_mca_rcu(mca, mcg);
> +	if (atomic_read(&mcg->qp_num) <= 0)
> +		kref_put(&mcg->ref_cnt, __rxe_cleanup_mcg);

This is confusing, why an atomic and a refcount with an atomic? Isn't
qpnum == 0 the same as list_empty(qp_list) ?

> diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
> index 357a6cea1484..7f2ea61a52c1 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_recv.c
> @@ -267,13 +267,13 @@ static void rxe_rcv_mcast_pkt(struct sk_buff *skb)
>  	qp_array = kmalloc_array(nmax, sizeof(qp), GFP_KERNEL);
>  
>  	n = 0;
> -	spin_lock_bh(&rxe->mcg_lock);
> -	list_for_each_entry(mca, &mcg->qp_list, qp_list) {
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(mca, &mcg->qp_list, qp_list) {
>  		qp_array[n++] = mca->qp;
>  		if (n == nmax)
>  			break;
>  	}
> -	spin_unlock_bh(&rxe->mcg_lock);
> +	rcu_read_unlock();
>  	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);

I have no idea how this works, what keeps 'qp' valid and prevents it
from being free'd once we leave the locking? Remember the mca can be
in concurrent progress to free so qp is just garbage under RCU at this
point.

Jason
