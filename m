Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1DCA1886A0
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2020 14:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgCQN6U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Mar 2020 09:58:20 -0400
Received: from mail-eopbgr80048.outbound.protection.outlook.com ([40.107.8.48]:45889
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726278AbgCQN6T (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 17 Mar 2020 09:58:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4QI2S9tgA5Z4HpyVSAO4I4HLZnb4d6FBqD8jS03snsW+Qdi7C24PK5C03b7J5xWfI2uvrMG6safHKcISCmQ0gMTG3XAwbG68o5aSDvVcY9rQj+1wfs6Oy0yZffV7mqAsFvYra1R7++slszLM5bO7MxhnqxAdFHqzMeymE2/9+2dRnbeb7Y/egQkrimhAa4YQ2amxMWX1zRH6QIze67elm2RsCxp2aeIDuhGIrGScZKSy7cs6tkAhBmNGcnzc3HYYmrCrXG9LGSEcM7ZcVQo9BChYPKDsN9A/h82OATLLky+hrDypR1fRuqND3JbVzPE7ayS+JiL2beAduX5DMyLNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pXMpg5aLo4S4rGgCG/wBcbHbn2jy0ycZgYhkK/7pYA=;
 b=WM/VwyOlek+sBYL7agvjtxWZF+fHJnSfxJNcDBC5h+XeUvzGxyi0EoFlWafDqyS84/0tfFJ+/ZTEy1YmcZtyXb7XtPQQoadm6HPKKSVoEAEqtjUhySWVzpmCHZ1uGroE5PrCezFswnxo1ei7EjnTGu4AFUq9uhohbcWffBMJf64Z0zkMkF/tvd4Cdrn1pU2Cjt6Jz6VosvRAdeEmjpSvzpJT9SPFvxBPydu1TaZBUuocoXs0vn8qtWvNcbPl/SmjX3FaBmgBx94uFydSWZ7YQL9Xabz3Isyz65hSGvzdNIrzRf+8xkPDPnPuNUOQhtbNFOG6S31O+FSD1iHjcZns/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pXMpg5aLo4S4rGgCG/wBcbHbn2jy0ycZgYhkK/7pYA=;
 b=JXn4fX0x3q9K+/xVZ2is8uTi13zZLO4aLz3LyyYwlatAsEcvQTT06b8teiak0ocJ1GKh0BoRxxpsZagEJ0hmXMqgBdmbpDlQakQbH+aDGC0nIluTa1S3EHKudvKALw51y6QLXOzSQxyo+TnEkKqPgJnANPCbJtZZ/Bpx0/CquXQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (20.179.5.215) by
 AM6PR05MB6118.eurprd05.prod.outlook.com (20.179.2.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.16; Tue, 17 Mar 2020 13:58:15 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c99f:9130:561f:dea0]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c99f:9130:561f:dea0%3]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 13:58:15 +0000
Date:   Tue, 17 Mar 2020 15:58:12 +0200
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        loberman@redhat.com, bvanassche@acm.org,
        linux-rdma@vger.kernel.org, kbusch@kernel.org, jgg@mellanox.com,
        dledford@redhat.com, idanb@mellanox.com, shlomin@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com
Subject: Re: [PATCH 5/5] RDMA/srpt: use SRQ per completion vector
Message-ID: <20200317135812.GH3351@unreal>
References: <20200317134030.152833-1-maxg@mellanox.com>
 <20200317134030.152833-6-maxg@mellanox.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317134030.152833-6-maxg@mellanox.com>
X-ClientProxiedBy: AM0PR01CA0056.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:e6::33) To AM6PR05MB6408.eurprd05.prod.outlook.com
 (2603:10a6:20b:b8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2a00:a040:183:2d::393) by AM0PR01CA0056.eurprd01.prod.exchangelabs.com (2603:10a6:208:e6::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.16 via Frontend Transport; Tue, 17 Mar 2020 13:58:14 +0000
X-Originating-IP: [2a00:a040:183:2d::393]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 61fee6e1-f438-46bb-efca-08d7ca7b3cc8
X-MS-TrafficTypeDiagnostic: AM6PR05MB6118:|AM6PR05MB6118:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB61189688E4101A173FF9AD69B0F60@AM6PR05MB6118.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(366004)(199004)(81156014)(81166006)(86362001)(8676002)(6636002)(33656002)(8936002)(6486002)(33716001)(6496006)(186003)(1076003)(52116002)(16526019)(9686003)(66946007)(107886003)(4326008)(66476007)(2906002)(66556008)(6862004)(5660300002)(498600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6118;H:AM6PR05MB6408.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mgoqkPUbcguPs6BQT7tbXIEbb0dfFQCecgVuLOfK3diV9HcxTg+EwgNdqMy2BP6Nr8WtG0Kvc530++iYz/kuPZ5Clnd8PNKuGrfP8RrO2uBuC8PvCwxrG/cvbNpie8AZ8rPeczxuesHP4iq2IQEbNxMZsrunmkyDRogMivv0a0hpjDY4TDziz+PKt0vC33f7V+C7/oybI1GaGz/2d/VxuZLzPKh7L9bMj96CZUEad12l3F6crVVCURVqi8el/uS8WG/DQVXS9Ah2zbNdYwtWZdpDcUqZN4pSrEA6nYqSVwIpkxHotKuwg9c2+JbFOBYF6ZEKncb8Y3XVf89FN/YaJoeXNT0gfbKpJwtxN5rPsdgnY4zxN8U7xloafy5VgRbG+yvsmkezYwSt2w8tqSqb1HyA/nE/fIr4frmAB5B9EdQXi6KE3hxjR/ZN5FrLEYhF
X-MS-Exchange-AntiSpam-MessageData: lZtQ1N9bI7/iZnp3C8v7ygm3WrcTb9KrM0xt6kQMtSxys41ifE5RYjqvEXk4GxM07gew4prChVURqtIvUmsnIuCfhSnno+3Awx1MqpzowjZv21NqfDOqFRynbqh43Zbqf/UHEL1f8R6kiUpDtVKo4jq6vpyqG1Zq1FQZJaVdOxY=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61fee6e1-f438-46bb-efca-08d7ca7b3cc8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 13:58:14.8192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PHChtXJat5XSkYkjSe50I/4l3J3OybJz34e/sbRO1EIt+tniSbQCktvsDTLEbnEwf08gDYe9QnnqEkIDsi4REw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6118
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 17, 2020 at 03:40:30PM +0200, Max Gurtovoy wrote:
> In order to save resource allocation and utilize the completion
> locality in a better way (compared to SRQ per device that exist
> today), allocate Shared Receive Queues (SRQs) per completion vector.
> Associate each created channel with an appropriate SRQ according to the
> completion vector index. This association will reduce the lock
> contention in the fast path (compared to SRQ per device solution) and
> increase the locality in memory buffers.
>
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> ---
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 169 +++++++++++++++++++++++++---------
>  drivers/infiniband/ulp/srpt/ib_srpt.h |  26 +++++-
>  2 files changed, 148 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> index 9855274..34869b7 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -811,6 +811,31 @@ static bool srpt_test_and_set_cmd_state(struct srpt_send_ioctx *ioctx,
>  }
>
>  /**
> + * srpt_srq_post_recv - post an initial IB receive request for SRQ
> + * @srq: SRPT SRQ context.
> + * @ioctx: Receive I/O context pointer.
> + */
> +static int srpt_srq_post_recv(struct srpt_srq *srq, struct srpt_recv_ioctx *ioctx)
> +{
> +	struct srpt_device *sdev = srq->sdev;
> +	struct ib_sge list;
> +	struct ib_recv_wr wr;
> +
> +	BUG_ON(!srq);
> +	list.addr = ioctx->ioctx.dma + ioctx->ioctx.offset;
> +	list.length = srp_max_req_size;
> +	list.lkey = sdev->lkey;
> +
> +	ioctx->ioctx.cqe.done = srpt_recv_done;
> +	wr.wr_cqe = &ioctx->ioctx.cqe;
> +	wr.next = NULL;
> +	wr.sg_list = &list;
> +	wr.num_sge = 1;
> +
> +	return ib_post_srq_recv(srq->ibsrq, &wr, NULL);
> +}
> +
> +/**
>   * srpt_post_recv - post an IB receive request
>   * @sdev: SRPT HCA pointer.
>   * @ch: SRPT RDMA channel.
> @@ -823,6 +848,7 @@ static int srpt_post_recv(struct srpt_device *sdev, struct srpt_rdma_ch *ch,
>  	struct ib_recv_wr wr;
>
>  	BUG_ON(!sdev);
> +	BUG_ON(!ch);
>  	list.addr = ioctx->ioctx.dma + ioctx->ioctx.offset;
>  	list.length = srp_max_req_size;
>  	list.lkey = sdev->lkey;
> @@ -834,7 +860,7 @@ static int srpt_post_recv(struct srpt_device *sdev, struct srpt_rdma_ch *ch,
>  	wr.num_sge = 1;
>
>  	if (sdev->use_srq)
> -		return ib_post_srq_recv(sdev->srq, &wr, NULL);
> +		return ib_post_srq_recv(ch->srq->ibsrq, &wr, NULL);
>  	else
>  		return ib_post_recv(ch->qp, &wr, NULL);
>  }
> @@ -1820,7 +1846,8 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
>  					SRPT_MAX_SG_PER_WQE);
>  	qp_init->port_num = ch->sport->port;
>  	if (sdev->use_srq) {
> -		qp_init->srq = sdev->srq;
> +		ch->srq = sdev->srqs[ch->cq->comp_vector % sdev->srq_count];
> +		qp_init->srq = ch->srq->ibsrq;
>  	} else {
>  		qp_init->cap.max_recv_wr = ch->rq_size;
>  		qp_init->cap.max_recv_sge = min(attrs->max_recv_sge,
> @@ -1878,6 +1905,8 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
>
>  static void srpt_destroy_ch_ib(struct srpt_rdma_ch *ch)
>  {
> +	if (ch->srq)
> +		ch->srq = NULL;
>  	ib_destroy_qp(ch->qp);
>  	ib_free_cq(ch->cq);
>  }
> @@ -3018,20 +3047,75 @@ static struct se_wwn *srpt_lookup_wwn(const char *name)
>  	return wwn;
>  }
>
> -static void srpt_free_srq(struct srpt_device *sdev)
> +static void srpt_free_srq(struct srpt_srq *srq)
>  {
> -	if (!sdev->srq)
> -		return;
>
> -	ib_destroy_srq(sdev->srq);
> -	srpt_free_ioctx_ring((struct srpt_ioctx **)sdev->ioctx_ring, sdev,
> -			     sdev->srq_size, sdev->req_buf_cache,
> +	srpt_free_ioctx_ring((struct srpt_ioctx **)srq->ioctx_ring, srq->sdev,
> +			     srq->sdev->srq_size, srq->sdev->req_buf_cache,
>  			     DMA_FROM_DEVICE);
> +	rdma_srq_put(srq->sdev->pd, srq->ibsrq);
> +	kfree(srq);
> +
> +}
> +
> +static void srpt_free_srqs(struct srpt_device *sdev)
> +{
> +	int i;
> +
> +	if (!sdev->srqs)
> +		return;
> +
> +	for (i = 0; i < sdev->srq_count; i++)
> +		srpt_free_srq(sdev->srqs[i]);
>  	kmem_cache_destroy(sdev->req_buf_cache);
> -	sdev->srq = NULL;
> +	rdma_srq_set_destroy(sdev->pd);
> +	kfree(sdev->srqs);
> +	sdev->srqs = NULL;
>  }
>
> -static int srpt_alloc_srq(struct srpt_device *sdev)
> +static struct srpt_srq *srpt_alloc_srq(struct srpt_device *sdev)
> +{
> +	struct srpt_srq	*srq;
> +	int i, ret;
> +
> +	srq = kzalloc(sizeof(*srq), GFP_KERNEL);
> +	if (!srq) {
> +		pr_debug("failed to allocate SRQ context\n");

Please no to kzalloc prints and no to pr_* prints.

> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	srq->ibsrq = rdma_srq_get(sdev->pd);
> +	if (!srq) {

!srq->ibsrq ????

> +		ret = -EAGAIN;
> +		goto free_srq;
> +	}

Thanks
