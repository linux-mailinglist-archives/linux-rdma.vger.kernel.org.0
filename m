Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11A140B6FE
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Sep 2021 20:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhINSeB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Sep 2021 14:34:01 -0400
Received: from mail-dm6nam10on2063.outbound.protection.outlook.com ([40.107.93.63]:1600
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231593AbhINSeA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Sep 2021 14:34:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LENlp7+ez7uJKXEVatdyzyOYlx8hLEcgioheSs587WUu5uXvP3gth2icikw0ZEVYkKMeqvXBJXV4V7TseA6f8gUrqrBHqLOvDo8UNYSTeywViyHzX+NEGfi+1HMUV7mUuSE7rP9Nrer7KpkXX0ZwZjMKHBNSdxueUXpyGqmiP3UDEZ5YGnsX47WPso8w9S3iO6VIqrnf64lOj605TvILuE1yzAr/5H5D7ZWkVOgjk1uU5qTYAP9oO0+gHVhd6b7Diwd57FUsURwF0+cAzfpePReZG0DKfPrNZxn/1SnhlLdYuDJOccC6O18dgkUnG5NnGMBVPKiIFlswKcRKvJqSxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=G21iq4/YDN04vBy09Qn/vFQni4xcDpDeSjVnldzMvC4=;
 b=fAa0jf6a+ngo4ByTRmCDWOwIZWCQdNik4fexDReB5PvVfhCH7oig5BshXTc1wPVw8s2JF5KTGJAclIx3uthXiuZeACFTfFYhYfxtzH8GgMHaGRcqk9tqo0AdrGp73xz+ZTOULbKK7e3VzmTJBzeIWiw4ugUzKohTrwQxHUugBoBtQUEE4CA1v6Ty+CfC1IdIpqm4WfeZtdhMoGNq5QU/sdtXiefpXWV2ptYnFKEDBWPM5tIHrh+nFHPFdirOUjhHLhyvMY1v8yljqaAkozu8/dxf68Mwch2rAR+5Z0Ui2CBb/EJkj9A32rjoeUus67061Olw1qDBCWJzlyt5FocVug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G21iq4/YDN04vBy09Qn/vFQni4xcDpDeSjVnldzMvC4=;
 b=KQihU1guPn0mcYcRTdXe1ZYJ2+H90gwNF8zImoFKDv3exi4ADZKKfIzGJVN+zCmjnCiP+V7ErgDvyUq5bb5ucxBswR3/qzDXk+rBdBUzdp32mCU4UC4LRTohYVJn33tjptFanq6bMmHG3yYO8P+duMplmfhFJjEFtB15z0N5QIc2TxV+dCJv6mq26H2bYNBqRVqgfKgZHmtzWoGcHQyqLi1NTQvEs0517TTxjvOyANDk/J8N8LEMs7+IJoljG9f20m6aSVCL6x81oTp2FkXX0/XwWvTILa0lGmXr4VdQkpFAyL3DB03kOIRQxu8ItgI/Hq5PtEqpnG4nJ8sCLb79hA==
Authentication-Results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5064.namprd12.prod.outlook.com (2603:10b6:208:30a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Tue, 14 Sep
 2021 18:32:41 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 18:32:41 +0000
Date:   Tue, 14 Sep 2021 15:32:40 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, rpearsonhpe@gmail.com,
        zyjzyj2000@gmail.com, leon@kernel.org
Subject: Re: [PATCH v2 1/5] RDMA/rxe: Remove unnecessary check for
 qp->is_user/cq->is_user
Message-ID: <20210914183240.GA136302@nvidia.com>
References: <20210902084640.679744-1-yangx.jy@fujitsu.com>
 <20210902084640.679744-2-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902084640.679744-2-yangx.jy@fujitsu.com>
X-ClientProxiedBy: MN2PR16CA0004.namprd16.prod.outlook.com
 (2603:10b6:208:134::17) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR16CA0004.namprd16.prod.outlook.com (2603:10b6:208:134::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 18:32:41 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mQDEW-000ZUB-AQ; Tue, 14 Sep 2021 15:32:40 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99fddbcc-92cb-4d59-d07c-08d977ae096e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5064:
X-Microsoft-Antispam-PRVS: <BL1PR12MB506413A07019C0D236A4778AC2DA9@BL1PR12MB5064.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BVlAjoKTmYT7K76b4uGxZWSjpwVOGfVl+0Lgig7oiRVHHzii5c0UKOjo4h08I81mIeaOlEV/lhoEm/IaHVeftlCK2qTyXrCO5m0314kGOVYsNymrGTh6NH+YIrYocTAa/RnxXwOo3otv4WWIKlyYJazteBFuadd43oxbPDmKAZsLVMI/ZYUNalpQ+fBc6nAXzZnJ2HiC4W+ocL2jOgVluSaNAW07HZRtZRmQnsPorTWevaB7eSHkkTyCqyQWt8S7u1VxrPpNKBlk/sLGHyVFunWb6exakquD96Zy9rpGd+mDQcyzLhjMrYNdQIVPLHgQY4vEOglufwNEvMxZaZvKlNhOaYNaGdsmKA3wLmvK7nEJlQ9ykCyaUFat8ofYyCLBVvdFfUyWGYXr1/IO4JeBNAKEwmR61etl9daX1YcccUXi14BPwezAQwh3cuxd4hN63OEVEAwI+B4j7FndthekqgVFGuqOIgGUdCFA/LNCd9XHcTkWPGGeua9s3cmxkCRFcXAvbHrLn7qADCHrgGXvsAbHGhEaMLt05pwLao2n7/VbWsmvWVSAeKI7UI2QMI9Vrjt1rjz1Z5p3gQDk1DN++zJh5bDvPbwxn/S3wLcp9Be6S8phNTrNb8EA4lcP69cpKqk9R5Wgn51nE8VrX/fD/OdKAJRPpRc/hFJuVwyz4IbcGOy+ukUc2RUsD3uCF2Ad
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(33656002)(426003)(2616005)(9786002)(9746002)(2906002)(8936002)(186003)(26005)(316002)(6916009)(4326008)(66476007)(8676002)(66556008)(66946007)(478600001)(86362001)(1076003)(83380400001)(5660300002)(38100700002)(36756003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IYJ5c2oDpJrg1qrGvkQfRUJNVfOsc40jBHnkWBB8IeY3GCxNAXUkVBgd/nMF?=
 =?us-ascii?Q?hWNxz29NvBVY0PHmMnNfswn8k9MS9d23ku0KjI+4dqv8oWSUAM32ywRvnvk3?=
 =?us-ascii?Q?zEYoUIptvehQktpTAKY/SQuECq4XRkSBNom0HdSwg7GDtXWs1rH84FQwu9RS?=
 =?us-ascii?Q?JQwTCARi2jah2RfWWoIvUO0jAa72gGF6f/TkJCvUIP04TNT7/emrZpnPvTwB?=
 =?us-ascii?Q?GQg/6Eeu9qvE05WNYkSzYYhIgs4a6pMMxuNlYF8jZc7u9bqSIhrWlPvwy71R?=
 =?us-ascii?Q?A/SDgjOoLfgnMB2tg2eTf69jrmAIXkb9CTt1Gnyo95ZqVkzGc07JkI5Q3CnK?=
 =?us-ascii?Q?CjhjXonJ19Gx7F5rI+n280RIXrZvHCirUjhisPMB5Wgkkp6vPPiynaku7JJr?=
 =?us-ascii?Q?+4phdMLeK7vUB8cUNuiRkWk2iRaDZMUa0xHP7HoFKwOZ3kif33wK+KKPloVm?=
 =?us-ascii?Q?RoLFkBCk7+++iet/GQFqC/FXrRZRaZCLuK468oURZgYD7PsU8Hh+/Z1EXwxi?=
 =?us-ascii?Q?rKRV5P3FbO0lwKt5UHnzvBkCPY436U3fgQrKx42DzB09T05cbO5fjiZDBkd4?=
 =?us-ascii?Q?CtorTWHu4XXfBpa/IDlr9jaB9PqGwKr+rKm82a4w07MVRaT9XG66mpY8QNbZ?=
 =?us-ascii?Q?wjHG0c+2Ehrr5eNBlABwy+NEhyjWTIKpxikjQOKsEHipdpVjeyeyZVuEkv+3?=
 =?us-ascii?Q?+OjAnHikKVf1chKy95OybKSpu00OVevf9r1EcZnr8KVFaKCvg3HLElhCX8AG?=
 =?us-ascii?Q?hLXi5MRUOWGassRMicabbRZwN9oll45RWJMmQ71jcRfLLlzzcsfu/bwWwyTI?=
 =?us-ascii?Q?rG1S+BLLaxVpj/km+webp0wDxorlLR+FaOdrwQfLqJi9HsmQdqw01bWGeVWj?=
 =?us-ascii?Q?JZjji55M2TTdhQZYOoBKj0jUb+cknGCIaKGHVPQqX5nUZky9QOjtT7eIkvUZ?=
 =?us-ascii?Q?QI4QhW6lNmrAhOIpvVASfze1FZyBNUxM7UHzv3Cw8Rn1UH8lzkHDFfYg6r8b?=
 =?us-ascii?Q?PEgdlDNkj+aPyWwPCrvoRf48Q8wH4QOCUzgoQwcabrz2/LC1wUQgvM4eAKZm?=
 =?us-ascii?Q?FYDXGrhJbUg+sb0WgKljKV0wtiPi+UQOEj2vTlQQX+WfHY5iWtDMOWVHZQxU?=
 =?us-ascii?Q?HKz3sl3f/IONRtwyRf1sSepSr7/ud291qzUQANPrCdfsed+8MSy+s+3UqwID?=
 =?us-ascii?Q?cVG0nyMGLY4LnVvttZFWTwU2dQsEJ113D+dBN1F9ZB+Fggd7f7tOFrdCFREr?=
 =?us-ascii?Q?fe/lE1rDe2tI0Q8ejC/J3kIdQcduhycH6M2AdT5NBQC/wAXBzqz0ns4ArN7C?=
 =?us-ascii?Q?zf0e7ME3CcZETnZcEaWWBj6M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99fddbcc-92cb-4d59-d07c-08d977ae096e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 18:32:41.7471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z1dRMIVaZYogAtYd0sAsea+RzHuASy0wJk+LyiPY0IO/RMjdS2HitAjBo1nG2no2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5064
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 02, 2021 at 04:46:36PM +0800, Xiao Yang wrote:
> 1) post_one_send() always processes kernel's send queue.
> 2) rxe_poll_cq() always processes kernel's completion queue.
> 
> Fixes: 5bcf5a59c41e ("RDMA/rxe: Protext kernel index from user space")
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 29 ++++++---------------------
>  1 file changed, 6 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index c223959ac174..cdded9f64910 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -632,7 +632,6 @@ static int post_one_send(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
>  	struct rxe_sq *sq = &qp->sq;
>  	struct rxe_send_wqe *send_wqe;
>  	unsigned long flags;
> -	int full;
>  
>  	err = validate_send_wr(qp, ibwr, mask, length);
>  	if (err)
> @@ -640,27 +639,16 @@ static int post_one_send(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
>  
>  	spin_lock_irqsave(&qp->sq.sq_lock, flags);
>  
> -	if (qp->is_user)
> -		full = queue_full(sq->queue, QUEUE_TYPE_FROM_USER);
> -	else
> -		full = queue_full(sq->queue, QUEUE_TYPE_KERNEL);
> -
> -	if (unlikely(full)) {
> +	if (unlikely(queue_full(sq->queue, QUEUE_TYPE_KERNEL))) {
>  		spin_unlock_irqrestore(&qp->sq.sq_lock, flags);
>  		return -ENOMEM;
>  	}
>  
> -	if (qp->is_user)
> -		send_wqe = producer_addr(sq->queue, QUEUE_TYPE_FROM_USER);
> -	else
> -		send_wqe = producer_addr(sq->queue, QUEUE_TYPE_KERNEL);
> +	send_wqe = producer_addr(sq->queue, QUEUE_TYPE_KERNEL);
>  
>  	init_send_wqe(qp, ibwr, mask, length, send_wqe);
>  
> -	if (qp->is_user)
> -		advance_producer(sq->queue, QUEUE_TYPE_FROM_USER);
> -	else
> -		advance_producer(sq->queue, QUEUE_TYPE_KERNEL);
> +	advance_producer(sq->queue, QUEUE_TYPE_KERNEL);
>  
>  	spin_unlock_irqrestore(&qp->sq.sq_lock, flags);

This bit looks OK
  
> @@ -852,18 +840,13 @@ static int rxe_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc)
>  
>  	spin_lock_irqsave(&cq->cq_lock, flags);
>  	for (i = 0; i < num_entries; i++) {
> -		if (cq->is_user)
> -			cqe = queue_head(cq->queue, QUEUE_TYPE_TO_USER);
> -		else
> -			cqe = queue_head(cq->queue, QUEUE_TYPE_KERNEL);
> +		cqe = queue_head(cq->queue, QUEUE_TYPE_KERNEL);
>  		if (!cqe)
>  			break;
>  
>  		memcpy(wc++, &cqe->ibwc, sizeof(*wc));
> -		if (cq->is_user)
> -			advance_consumer(cq->queue, QUEUE_TYPE_TO_USER);
> -		else
> -			advance_consumer(cq->queue, QUEUE_TYPE_KERNEL);
> +
> +		advance_consumer(cq->queue, QUEUE_TYPE_KERNEL);
>  	}

But why is this OK?

It is used here:

	.poll_cq = rxe_poll_cq,

Which is part of:

static int ib_uverbs_poll_cq(struct uverbs_attr_bundle *attrs)
[..]

		ret = ib_poll_cq(cq, 1, &wc);

That is used called?

Jason
