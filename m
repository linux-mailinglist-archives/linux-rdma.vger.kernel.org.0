Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6F81CE06E
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 18:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbgEKQ32 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 12:29:28 -0400
Received: from mail-vi1eur05on2043.outbound.protection.outlook.com ([40.107.21.43]:32032
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729463AbgEKQ31 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 11 May 2020 12:29:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Owp7BFd6TkA7TsJXYPxD0LlinM377i6xlW5drW9WyuepJmXNChB6EQ1LMnjhdGKJLxJ2k2XxYNgFmLh2Qonc+MR8qKA0bTTRKlSlC+c2//7QFsYKusF96yrOqBKG+8ADnJZLSQQMiwC2UNbOee8HOSsGCqbLpL/IH4/ULudm88EmKs5Kq7zUak3BDYQ9t+f/VmFyvhaGlfrXr2DK8Ih7OcHUozbg/+d5qo6TQfZcxxpsLQB1xlvnwRNVh/UAedVbo4gH1LQgGs3pNP0K227toU3lcTcU0U0QUOmxGYBJ1egJC8bpTwcy63pnJRcJx5sxA6AcWI5Q1MrLh91GzSjpcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dJ+CnXCa5fTIDBkUag/i2Xd31LFgoAJjnnEqCafHqQ=;
 b=E1cSUrI3khcwK5esCYSxSl0SLz6iG3xJFOpaHqnrldR2C/SAv24M0d/ioQ4T5J8klBTm9DivydYF8y/RhTjOouAF/eshDy5HXJoSfR8FdyGsQzpFbHhgbJ+P6ymBDYDud1qaV01RAyqI8tlxHd9xof8Lzqxy92N7gSI/2/bm+zWwdKaVF3WuGugiIhEa33EGjkae2XnRGRNaT2k0HLxP9pf6kj9DK5QfcGqqhXiwMlMpSbrlfcvNML78RSQFDMXaUAY2ljVyRZZEJxNXspr3qqiKcACLJVrbjLn4uTERdFrBIYK7i6yTFkHGdG3nSGtmCMtZbGnMzV28ao9NUFFzdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dJ+CnXCa5fTIDBkUag/i2Xd31LFgoAJjnnEqCafHqQ=;
 b=kUfX8SXbhUw2/wsRnJ1oJP+V6aLIbZYdFloPHfEn7+4mjhgezRFsJ9NxBq1Aoqmg5T2pZjTn10RU/jcAEqg2QJ9TMbPXDZQnjQETNSXyl3asS0peFS6qqyIczsQPoVwIyz9Q4iifAFflDttE/kh+mZS4TXoNqTuqcVhM95vQfOM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB5187.eurprd05.prod.outlook.com (2603:10a6:208:eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Mon, 11 May
 2020 16:29:23 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 16:29:23 +0000
Subject: Re: [PATCH 3/4] nvme-rdma: use new shared CQ mechanism
To:     Yamin Friedman <yaminf@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-rdma@vger.kernel.org
References: <1589122557-88996-1-git-send-email-yaminf@mellanox.com>
 <1589122557-88996-4-git-send-email-yaminf@mellanox.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <5cd6dfea-1231-2cf9-bcfa-46018d7443fe@mellanox.com>
Date:   Mon, 11 May 2020 19:29:20 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <1589122557-88996-4-git-send-email-yaminf@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR0701CA0014.eurprd07.prod.outlook.com
 (2603:10a6:200:42::24) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (89.139.203.251) by AM4PR0701CA0014.eurprd07.prod.outlook.com (2603:10a6:200:42::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.11 via Frontend Transport; Mon, 11 May 2020 16:29:22 +0000
X-Originating-IP: [89.139.203.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cb674bbf-7c73-4161-cdad-08d7f5c8769c
X-MS-TrafficTypeDiagnostic: AM0PR05MB5187:|AM0PR05MB5187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB5187CD444046F71EFB268000B6A10@AM0PR05MB5187.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:337;
X-Forefront-PRVS: 04004D94E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4VKEVLL3GPJLb9ycTgMEqywOwSDfcEx/UqZBU2funWtW5cxb5akRts26ufPtMW889vo7bp6HoZHDUqxMiUxb5rMQUdwGraxx11vVV13XzAMGXQUwq1HwMN08e3TOqwAbSpEpAFksam7JU7Xi/tKCjTxAWh2WlgqCXO56xTtRFjDtl+DW3Y5X/Z5wLeTXfGVoNNhSQEXHexfFNyBcOyWPGkD0xw8MSWNecyZSs6MunE0TtvkN++k6bJCc7exgJDnFSPjbvn91HSqaMB7aFRdiAAh+NL+7a58zb1sjg/l5J+r7O1em/HsIuLVhrLJRHbG2fHlAmOVQoCCcJ8ushgjzi18uPWWnHL0ZU4CzckRwWcpPvN46jdqceVgJMzD4hi4A5lgLPdbdIrcRXFuGfS3auY9qPPddgK5jGIRfJ/PuJ8evqTgltnL4w3jIGZyd+vXPX+hb5VuYog3Ax/CcTN9Tc9ZMl+hQePx3AyTLqzFzPDBKmoQPC6YShbpcZsD7Ze9b7afL8kGt0BmRBQCFvkY54LLkzoyrem3bDRQa+HQI4PQ8RNFyCkRQJSrzf3eX7SSV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB5810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(33430700001)(26005)(16526019)(33440700001)(16576012)(186003)(110136005)(956004)(2616005)(36756003)(316002)(53546011)(52116002)(86362001)(2906002)(31696002)(8936002)(8676002)(4326008)(6486002)(5660300002)(31686004)(66946007)(66476007)(478600001)(66556008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: bGeJVOcNYLt42RBQAAiciGds7thhJsrir9pEQt65keefpMo9lVERuA1MjikYhtDWvI5F1kB7wYFLMDdR/QIMLkF+2n4xFvg3A8c5NxyjQ6Ky/FkxpTk90sv0+c2RJ24FKJmjkLccmHoTU3G2+q7vgAJwyRPS/diqHyY5zO2by0EmNuy9OD/P173WxSIsdGy4EJJ+cTHWok1tHgRkQFb5b4OgC/Y+n/SIFOSfYmWdjfMryr2rGnQ8k0XwQXc3LCgKFRqbtPvR0huLLpswA5dzRcGnaGTV3rxH3VAfIpDxY49xPJb5XmLzD2PKfTv1nPy+BbgyX4phdTDjgRZU9QHNufuL84dU5s8yzaLJzLJ2zvbOyltawCbHvKTnEuTAPXECcXDrGWh1EeOQEqvhCCvI4VwsDL3EVa18MGOmwlcrosPj8vGgYHEJLaqV1qoaES5wpDUXSWE/7+lc25C/TtnaJa7M8Qjb30jAMlZdcHw1kgeWpHjh67m1j46eTr6pNcTL
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb674bbf-7c73-4161-cdad-08d7f5c8769c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2020 16:29:23.1544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r4MpwhXRkGWaGlFPBJ823tdzBI0Xv03VMs6ZXJ37S6CXFlFygKF4mJmyGqDSCt6YO7Tkcu7phAFRUGrUSX8Rkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5187
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/10/2020 5:55 PM, Yamin Friedman wrote:
> Has the driver use shared CQs providing ~10%-50% improvement as seen in the
> patch introducing shared CQs. Instead of opening a CQ on each core per NS
> connected, a CQ for each core will be provided by the core driver that will
> be shared between the QPs on that core reducing interrupt overhead.
>
> Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
> Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
> ---
>   drivers/nvme/host/rdma.c | 65 ++++++++++++++++++++++++++++++++----------------
>   1 file changed, 43 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index cac8a93..23eefd7 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -85,6 +85,7 @@ struct nvme_rdma_queue {
>   	struct rdma_cm_id	*cm_id;
>   	int			cm_error;
>   	struct completion	cm_done;
> +	int			cq_size;
>   };
>   
>   struct nvme_rdma_ctrl {
> @@ -261,6 +262,7 @@ static int nvme_rdma_create_qp(struct nvme_rdma_queue *queue, const int factor)
>   	init_attr.qp_type = IB_QPT_RC;
>   	init_attr.send_cq = queue->ib_cq;
>   	init_attr.recv_cq = queue->ib_cq;
> +	init_attr.qp_context = queue;
>   
>   	ret = rdma_create_qp(queue->cm_id, dev->pd, &init_attr);
>   
> @@ -389,6 +391,15 @@ static int nvme_rdma_dev_get(struct nvme_rdma_device *dev)
>   	return NULL;
>   }
>   
> +static void nvme_rdma_free_cq(struct nvme_rdma_queue *queue)
> +{
> +	if (nvme_rdma_poll_queue(queue))
> +		ib_free_cq(queue->ib_cq);
> +	else {
> +		ib_cq_pool_put(queue->ib_cq, queue->cq_size);
> +	}
> +}

somehow I missed it in the internal review:

	if (nvme_rdma_poll_queue(queue))
		ib_free_cq(queue->ib_cq);
	else
		ib_cq_pool_put(queue->ib_cq, queue->cq_size);


> +
>   static void nvme_rdma_destroy_queue_ib(struct nvme_rdma_queue *queue)
>   {
>   	struct nvme_rdma_device *dev;
> @@ -408,7 +419,7 @@ static void nvme_rdma_destroy_queue_ib(struct nvme_rdma_queue *queue)
>   	 * the destruction of the QP shouldn't use rdma_cm API.
>   	 */
>   	ib_destroy_qp(queue->qp);
> -	ib_free_cq(queue->ib_cq);
> +	nvme_rdma_free_cq(queue);
>   
>   	nvme_rdma_free_ring(ibdev, queue->rsp_ring, queue->queue_size,
>   			sizeof(struct nvme_completion), DMA_FROM_DEVICE);
> @@ -422,13 +433,35 @@ static int nvme_rdma_get_max_fr_pages(struct ib_device *ibdev)
>   		     ibdev->attrs.max_fast_reg_page_list_len - 1);
>   }
>   
> +static void nvme_rdma_create_cq(struct ib_device *ibdev,
> +				struct nvme_rdma_queue *queue)
> +{
> +	int comp_vector, idx = nvme_rdma_queue_idx(queue);
> +	enum ib_poll_context poll_ctx;
> +
> +	/*
> +	 * Spread I/O queues completion vectors according their queue index.
> +	 * Admin queues can always go on completion vector 0.
> +	 */
> +	comp_vector = idx == 0 ? idx : idx - 1;
> +
> +	/* Polling queues need direct cq polling context */
> +	if (nvme_rdma_poll_queue(queue)) {
> +		poll_ctx = IB_POLL_DIRECT;
> +		queue->ib_cq = ib_alloc_cq(ibdev, queue, queue->cq_size,
> +					   comp_vector, poll_ctx);
> +	} else {
> +		poll_ctx = IB_POLL_SOFTIRQ;
> +		queue->ib_cq = ib_cq_pool_get(ibdev, queue->cq_size,
> +					      comp_vector, poll_ctx);
> +	}

please add integer as return value here instead of void.

And check the return value in the caller.


> +}
> +
>   static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
>   {
>   	struct ib_device *ibdev;
>   	const int send_wr_factor = 3;			/* MR, SEND, INV */
>   	const int cq_factor = send_wr_factor + 1;	/* + RECV */
> -	int comp_vector, idx = nvme_rdma_queue_idx(queue);
> -	enum ib_poll_context poll_ctx;
>   	int ret, pages_per_mr;
>   
>   	queue->device = nvme_rdma_find_get_device(queue->cm_id);
> @@ -439,22 +472,10 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
>   	}
>   	ibdev = queue->device->dev;
>   
> -	/*
> -	 * Spread I/O queues completion vectors according their queue index.
> -	 * Admin queues can always go on completion vector 0.
> -	 */
> -	comp_vector = idx == 0 ? idx : idx - 1;
> -
> -	/* Polling queues need direct cq polling context */
> -	if (nvme_rdma_poll_queue(queue))
> -		poll_ctx = IB_POLL_DIRECT;
> -	else
> -		poll_ctx = IB_POLL_SOFTIRQ;
> -
>   	/* +1 for ib_stop_cq */
> -	queue->ib_cq = ib_alloc_cq(ibdev, queue,
> -				cq_factor * queue->queue_size + 1,
> -				comp_vector, poll_ctx);
> +	queue->cq_size = cq_factor * queue->queue_size + 1;
> +
> +	nvme_rdma_create_cq(ibdev, queue);

see above.


>   	if (IS_ERR(queue->ib_cq)) {
>   		ret = PTR_ERR(queue->ib_cq);
>   		goto out_put_dev;
> @@ -484,7 +505,7 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
>   	if (ret) {
>   		dev_err(queue->ctrl->ctrl.device,
>   			"failed to initialize MR pool sized %d for QID %d\n",
> -			queue->queue_size, idx);
> +			queue->queue_size, nvme_rdma_queue_idx(queue));
>   		goto out_destroy_ring;
>   	}
>   
> @@ -498,7 +519,7 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
>   out_destroy_qp:
>   	rdma_destroy_qp(queue->cm_id);
>   out_destroy_ib_cq:
> -	ib_free_cq(queue->ib_cq);
> +	nvme_rdma_free_cq(queue);
>   out_put_dev:
>   	nvme_rdma_dev_put(queue->device);
>   	return ret;
> @@ -1093,7 +1114,7 @@ static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
>   static void nvme_rdma_wr_error(struct ib_cq *cq, struct ib_wc *wc,
>   		const char *op)
>   {
> -	struct nvme_rdma_queue *queue = cq->cq_context;
> +	struct nvme_rdma_queue *queue = wc->qp->qp_context;
>   	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
>   
>   	if (ctrl->ctrl.state == NVME_CTRL_LIVE)
> @@ -1481,7 +1502,7 @@ static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
>   {
>   	struct nvme_rdma_qe *qe =
>   		container_of(wc->wr_cqe, struct nvme_rdma_qe, cqe);
> -	struct nvme_rdma_queue *queue = cq->cq_context;
> +	struct nvme_rdma_queue *queue = wc->qp->qp_context;
>   	struct ib_device *ibdev = queue->device->dev;
>   	struct nvme_completion *cqe = qe->data;
>   	const size_t len = sizeof(struct nvme_completion);

with the above small fixes:

Reviewed-by: Max Gurtovoy <maxg@mellanox.com>


