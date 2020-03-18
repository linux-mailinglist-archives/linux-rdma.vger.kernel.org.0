Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29BDB18960A
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 07:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgCRGyM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 02:54:12 -0400
Received: from mail-eopbgr10066.outbound.protection.outlook.com ([40.107.1.66]:5899
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727004AbgCRGyL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Mar 2020 02:54:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHnq+kVhFGnUEcDawMQ4rXYEqZ2aUb385RwKvfRFP7KCk/Njd13FK4xqdRl9luHCO1OGxAxD2HIYzwcvMrd8OYq9QbTfCP7Dr5UdEqCt5wXDAWPc+ZSHXkwffFrG2wQrAAgemnoRyvm8Qa30og9FRqqUO64D5YIQUa3AjX8yIeUOdfa0DQWkt79zsNNrAw3Dh8nLrxjhCxUgK5zS6jbArfVTbvsDGZU8F2Tc8owNVVG4lx60CDEjvPhdWs07aYix66EXDbHpS6wWitmqJB9Fa/JJF2+CKMvsmiEs0i3puMHmWvFS1UazgVnSTFWdWK8SdymM64UI/q7ZhUAIVjvX4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kyAfmRvZnTYHz8UcV11hZPEC6TDUg/L9OU0qLVzhzE=;
 b=d1Vu4FaM1vT9i57N3TI7M16CHyNOIBnKCYV/gkFHwe9N34JecE8psWQawvZjKU/dhh0ZIYIXEM8XoXxT7LAIDKu/KnmK7Bc5OpTFzqwKChKXDfZPzkkpDOD5pz68+y97NeSZgMR0U96FRONV6dcQ6xgYwjL72MrO4tslx/uap+R5p2LA4//IUYBs0MyFUGU52Iuo463Ekqe7QqiXyYPnpNEob3uNMtt7TYxzQsnkhisYWUH/Td6RQxk5xDKfWZhhNYhWm79Mv+eufFDayaBgcSdT10f2KnOmKH48rWK/hwbJU+2O7mvcX/Wz3dRH3KJXBNRlJ9+aAy1kPTlCMmjFIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kyAfmRvZnTYHz8UcV11hZPEC6TDUg/L9OU0qLVzhzE=;
 b=snyBK6Ie0XwC7+GL11zLCGA7cxz2k7gMXSxvdmd7fOgVusJaxgfCGXwbyAe3lZA3U+zj0go6ky9T/CVczpYr35H+h0ytj+hzpcVHiO5av0vCvRUjWa+ETya9xtfP/cS1gS6b+0mc5FRu4YjDGtbCHNTd+QnGLLOWFT6akxeSLKo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (20.179.5.215) by
 AM6PR05MB4200.eurprd05.prod.outlook.com (52.135.160.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.22; Wed, 18 Mar 2020 06:53:58 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c99f:9130:561f:dea0]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c99f:9130:561f:dea0%3]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 06:53:58 +0000
Date:   Wed, 18 Mar 2020 08:53:55 +0200
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        loberman@redhat.com, bvanassche@acm.org,
        linux-rdma@vger.kernel.org, kbusch@kernel.org, jgg@mellanox.com,
        dledford@redhat.com, idanb@mellanox.com, shlomin@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com
Subject: Re: [PATCH 3/5] nvmet-rdma: use SRQ per completion vector
Message-ID: <20200318065355.GQ3351@unreal>
References: <20200317134030.152833-1-maxg@mellanox.com>
 <20200317134030.152833-4-maxg@mellanox.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317134030.152833-4-maxg@mellanox.com>
X-ClientProxiedBy: PR3P189CA0022.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:52::27) To AM6PR05MB6408.eurprd05.prod.outlook.com
 (2603:10a6:20b:b8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2a00:a040:183:2d::393) by PR3P189CA0022.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:52::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.21 via Frontend Transport; Wed, 18 Mar 2020 06:53:57 +0000
X-Originating-IP: [2a00:a040:183:2d::393]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 635ef51e-e853-4dae-7161-08d7cb0921b0
X-MS-TrafficTypeDiagnostic: AM6PR05MB4200:|AM6PR05MB4200:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB42004E37D7D6DDD57EDE0061B0F70@AM6PR05MB4200.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 03468CBA43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(199004)(6636002)(5660300002)(33656002)(81166006)(6862004)(107886003)(8676002)(81156014)(8936002)(33716001)(66946007)(52116002)(86362001)(6496006)(9686003)(4326008)(6486002)(66476007)(66556008)(30864003)(478600001)(2906002)(316002)(186003)(1076003)(16526019)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4200;H:AM6PR05MB6408.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: piBYFQodVnp0NMXecQQKCoL+Bu1Ykwpx/cW5LSJlsFpM+Ikau+/2YUBy6mGpGvO720H3eLZglfa8hqZKi5wT5xrEM6+ukJzylgqEOVtQDjJqYQJbV/959Vzo1s3v+2uPMu06ggiRRCwlf2rHCHbVJMTDg8Oo/DJBIthIh0ey7dz9N0klZPEUVi8uCJNGH4mB9RIA4zK73/+HmHG2+jx/bJ1SOABGS5lHPVepL/0tnOkllOaWl4WEJzdns7NoUE8OZpWECgN21n2xBNthYpdvH9+9uRgelrqKlt0L6qAeCAzy/GCNpU/1PIwdOIPUCWJgbiXKfelwMCLbespzg7K4DJHVmlkNYNa2EKsoxxLCfK+vM+ZJJrQOvL8ozLPb/jaEdj6dykrkIeuENVkhb+cmoO3DKYl3Ehyt3a+aATUQgyJPG6wb43u4fSXXjBDCCOHGFtYz8WaK+oD10rqXNe8+vdf/0H0cyKtwFO2xMEEznJE=
X-MS-Exchange-AntiSpam-MessageData: OifVJGDOuG3eQoYrNHAs0LcOgIzw3AoYQGc2rmKYkI1ODpZkhJyDd+Nr7fgKJ2VLvhtQzTUW8HBpTbqXsOVsPcvZzNveqM3T6LySFnSbafVYCkqEqyZYOzlDwG8sRda4RNbohcWBjIApdndrinEHdYaV+tVWztGSF29N6ewWWYc=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 635ef51e-e853-4dae-7161-08d7cb0921b0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 06:53:57.9268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aKhKTnrXWHlUU33V5Wc0voqXANWe7Ox7GS0JszUN/5LRjYGlQiE/75ikBP+Vq0tiMSnZBSaiaizH036K8EgcvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4200
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 17, 2020 at 03:40:28PM +0200, Max Gurtovoy wrote:
> In order to save resource allocation and utilize the completion
> locality in a better way (compared to SRQ per device that exist today),
> allocate Shared Receive Queues (SRQs) per completion vector. Associate
> each created QP/CQ with an appropriate SRQ according to the queue index.
> This association will reduce the lock contention in the fast path
> (compared to SRQ per device solution) and increase the locality in
> memory buffers. Add new module parameter for SRQ size to adjust it
> according to the expected load. User should make sure the size is >= 256
> to avoid lack of resources.
>
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> ---
>  drivers/nvme/target/rdma.c | 204 +++++++++++++++++++++++++++++++++------------
>  1 file changed, 153 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 04062af..f560257 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -18,6 +18,7 @@
>  #include <asm/unaligned.h>
>
>  #include <rdma/ib_verbs.h>
> +#include <rdma/srq_set.h>
>  #include <rdma/rdma_cm.h>
>  #include <rdma/rw.h>
>
> @@ -31,6 +32,8 @@
>  #define NVMET_RDMA_MAX_INLINE_SGE		4
>  #define NVMET_RDMA_MAX_INLINE_DATA_SIZE		max_t(int, SZ_16K, PAGE_SIZE)
>
> +struct nvmet_rdma_srq;
> +
>  struct nvmet_rdma_cmd {
>  	struct ib_sge		sge[NVMET_RDMA_MAX_INLINE_SGE + 1];
>  	struct ib_cqe		cqe;
> @@ -38,7 +41,7 @@ struct nvmet_rdma_cmd {
>  	struct scatterlist	inline_sg[NVMET_RDMA_MAX_INLINE_SGE];
>  	struct nvme_command     *nvme_cmd;
>  	struct nvmet_rdma_queue	*queue;
> -	struct ib_srq		*srq;
> +	struct nvmet_rdma_srq   *nsrq;
>  };
>
>  enum {
> @@ -80,6 +83,7 @@ struct nvmet_rdma_queue {
>  	struct ib_cq		*cq;
>  	atomic_t		sq_wr_avail;
>  	struct nvmet_rdma_device *dev;
> +	struct nvmet_rdma_srq   *nsrq;
>  	spinlock_t		state_lock;
>  	enum nvmet_rdma_queue_state state;
>  	struct nvmet_cq		nvme_cq;
> @@ -97,17 +101,24 @@ struct nvmet_rdma_queue {
>
>  	int			idx;
>  	int			host_qid;
> +	int			comp_vector;
>  	int			recv_queue_size;
>  	int			send_queue_size;
>
>  	struct list_head	queue_list;
>  };
>
> +struct nvmet_rdma_srq {
> +	struct ib_srq            *srq;
> +	struct nvmet_rdma_cmd    *cmds;
> +	struct nvmet_rdma_device *ndev;
> +};
> +
>  struct nvmet_rdma_device {
>  	struct ib_device	*device;
>  	struct ib_pd		*pd;
> -	struct ib_srq		*srq;
> -	struct nvmet_rdma_cmd	*srq_cmds;
> +	struct nvmet_rdma_srq	**srqs;
> +	int			srq_count;
>  	size_t			srq_size;
>  	struct kref		ref;
>  	struct list_head	entry;
> @@ -119,6 +130,16 @@ struct nvmet_rdma_device {
>  module_param_named(use_srq, nvmet_rdma_use_srq, bool, 0444);
>  MODULE_PARM_DESC(use_srq, "Use shared receive queue.");
>
> +static int srq_size_set(const char *val, const struct kernel_param *kp);
> +static const struct kernel_param_ops srq_size_ops = {
> +	.set = srq_size_set,
> +	.get = param_get_int,
> +};
> +
> +static int nvmet_rdma_srq_size = 1024;
> +module_param_cb(srq_size, &srq_size_ops, &nvmet_rdma_srq_size, 0644);
> +MODULE_PARM_DESC(srq_size, "set Shared Receive Queue (SRQ) size, should >= 256 (default: 1024)");
> +

Why do you need this? Do you expect users to change this parameter for
every different workload?


>  static DEFINE_IDA(nvmet_rdma_queue_ida);
>  static LIST_HEAD(nvmet_rdma_queue_list);
>  static DEFINE_MUTEX(nvmet_rdma_queue_mutex);
> @@ -139,6 +160,17 @@ static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
>
>  static const struct nvmet_fabrics_ops nvmet_rdma_ops;
>
> +static int srq_size_set(const char *val, const struct kernel_param *kp)
> +{
> +	int n = 0, ret;
> +
> +	ret = kstrtoint(val, 10, &n);
> +	if (ret != 0 || n < 256)
> +		return -EINVAL;
> +
> +	return param_set_int(val, kp);
> +}
> +
>  static int num_pages(int len)
>  {
>  	return 1 + (((len - 1) & PAGE_MASK) >> PAGE_SHIFT);
> @@ -462,8 +494,8 @@ static int nvmet_rdma_post_recv(struct nvmet_rdma_device *ndev,
>  		cmd->sge[0].addr, cmd->sge[0].length,
>  		DMA_FROM_DEVICE);
>
> -	if (cmd->srq)
> -		ret = ib_post_srq_recv(cmd->srq, &cmd->wr, NULL);
> +	if (cmd->nsrq)
> +		ret = ib_post_srq_recv(cmd->nsrq->srq, &cmd->wr, NULL);
>  	else
>  		ret = ib_post_recv(cmd->queue->cm_id->qp, &cmd->wr, NULL);
>
> @@ -841,30 +873,82 @@ static void nvmet_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
>  	nvmet_rdma_handle_command(queue, rsp);
>  }
>
> -static void nvmet_rdma_destroy_srq(struct nvmet_rdma_device *ndev)
> +static void nvmet_rdma_destroy_srq(struct nvmet_rdma_srq *nsrq)
> +{
> +	nvmet_rdma_free_cmds(nsrq->ndev, nsrq->cmds, nsrq->ndev->srq_size, false);
> +	rdma_srq_put(nsrq->ndev->pd, nsrq->srq);
> +
> +	kfree(nsrq);
> +}
> +
> +static void nvmet_rdma_destroy_srqs(struct nvmet_rdma_device *ndev)
>  {
> -	if (!ndev->srq)
> +	int i;
> +
> +	if (!ndev->srqs)
>  		return;
>
> -	nvmet_rdma_free_cmds(ndev, ndev->srq_cmds, ndev->srq_size, false);
> -	ib_destroy_srq(ndev->srq);
> +	for (i = 0; i < ndev->srq_count; i++)
> +		nvmet_rdma_destroy_srq(ndev->srqs[i]);
> +
> +	rdma_srq_set_destroy(ndev->pd);
> +	kfree(ndev->srqs);
> +	ndev->srqs = NULL;
> +	ndev->srq_count = 0;
> +	ndev->srq_size = 0;
>  }
>
> -static int nvmet_rdma_init_srq(struct nvmet_rdma_device *ndev)
> +static struct nvmet_rdma_srq *
> +nvmet_rdma_init_srq(struct nvmet_rdma_device *ndev)
>  {
> -	struct ib_srq_init_attr srq_attr = { NULL, };
> +	size_t srq_size = ndev->srq_size;
> +	struct nvmet_rdma_srq *nsrq;
>  	struct ib_srq *srq;
> -	size_t srq_size;
>  	int ret, i;
>
> -	srq_size = 4095;	/* XXX: tune */
> +	nsrq = kzalloc(sizeof(*nsrq), GFP_KERNEL);
> +	if (!nsrq)
> +		return ERR_PTR(-ENOMEM);
>
> -	srq_attr.attr.max_wr = srq_size;
> -	srq_attr.attr.max_sge = 1 + ndev->inline_page_count;
> -	srq_attr.attr.srq_limit = 0;
> -	srq_attr.srq_type = IB_SRQT_BASIC;
> -	srq = ib_create_srq(ndev->pd, &srq_attr);
> -	if (IS_ERR(srq)) {
> +	srq = rdma_srq_get(ndev->pd);
> +	if (!srq) {
> +		ret = -EAGAIN;
> +		goto out_free_nsrq;
> +	}
> +
> +	nsrq->cmds = nvmet_rdma_alloc_cmds(ndev, srq_size, false);
> +	if (IS_ERR(nsrq->cmds)) {
> +		ret = PTR_ERR(nsrq->cmds);
> +		goto out_put_srq;
> +	}
> +
> +	nsrq->srq = srq;
> +	nsrq->ndev = ndev;
> +
> +	for (i = 0; i < srq_size; i++) {
> +		nsrq->cmds[i].nsrq = nsrq;
> +		ret = nvmet_rdma_post_recv(ndev, &nsrq->cmds[i]);
> +		if (ret)
> +			goto out_free_cmds;
> +	}
> +
> +	return nsrq;
> +
> +out_free_cmds:
> +	nvmet_rdma_free_cmds(ndev, nsrq->cmds, srq_size, false);
> +out_put_srq:
> +	rdma_srq_put(ndev->pd, srq);
> +out_free_nsrq:
> +	kfree(nsrq);
> +	return ERR_PTR(ret);
> +}
> +
> +static int nvmet_rdma_init_srqs(struct nvmet_rdma_device *ndev)
> +{
> +	struct ib_srq_init_attr srq_attr = { NULL, };
> +	int i, ret;
> +
> +	if (!ndev->device->attrs.max_srq_wr || !ndev->device->attrs.max_srq) {
>  		/*
>  		 * If SRQs aren't supported we just go ahead and use normal
>  		 * non-shared receive queues.
> @@ -873,31 +957,44 @@ static int nvmet_rdma_init_srq(struct nvmet_rdma_device *ndev)
>  		return 0;
>  	}
>
> -	ndev->srq_cmds = nvmet_rdma_alloc_cmds(ndev, srq_size, false);
> -	if (IS_ERR(ndev->srq_cmds)) {
> -		ret = PTR_ERR(ndev->srq_cmds);
> -		goto out_destroy_srq;
> -	}
> +	ndev->srq_size = min(ndev->device->attrs.max_srq_wr,
> +			     nvmet_rdma_srq_size);
> +	ndev->srq_count = min(ndev->device->num_comp_vectors,
> +			      ndev->device->attrs.max_srq);
>
> -	ndev->srq = srq;
> -	ndev->srq_size = srq_size;
> +	ndev->srqs = kcalloc(ndev->srq_count, sizeof(*ndev->srqs), GFP_KERNEL);
> +	if (!ndev->srqs)
> +		return -ENOMEM;
>
> -	for (i = 0; i < srq_size; i++) {
> -		ndev->srq_cmds[i].srq = srq;
> -		ret = nvmet_rdma_post_recv(ndev, &ndev->srq_cmds[i]);
> -		if (ret)
> -			goto out_free_cmds;
> +	srq_attr.attr.max_wr = ndev->srq_size;
> +	srq_attr.attr.max_sge = 2;
> +	srq_attr.attr.srq_limit = 0;
> +	srq_attr.srq_type = IB_SRQT_BASIC;
> +	ret = rdma_srq_set_init(ndev->pd, ndev->srq_count, &srq_attr);
> +	if (ret)
> +		goto err_free;
> +
> +	for (i = 0; i < ndev->srq_count; i++) {
> +		ndev->srqs[i] = nvmet_rdma_init_srq(ndev);
> +		if (IS_ERR(ndev->srqs[i]))
> +			goto err_srq;
>  	}
>
>  	return 0;
>
> -out_free_cmds:
> -	nvmet_rdma_free_cmds(ndev, ndev->srq_cmds, ndev->srq_size, false);
> -out_destroy_srq:
> -	ib_destroy_srq(srq);
> +err_srq:
> +	while (--i >= 0)
> +		nvmet_rdma_destroy_srq(ndev->srqs[i]);
> +	rdma_srq_set_destroy(ndev->pd);
> +err_free:
> +	kfree(ndev->srqs);
> +	ndev->srqs = NULL;
> +	ndev->srq_count = 0;
> +	ndev->srq_size = 0;
>  	return ret;
>  }
>
> +
>  static void nvmet_rdma_free_dev(struct kref *ref)
>  {
>  	struct nvmet_rdma_device *ndev =
> @@ -907,7 +1004,7 @@ static void nvmet_rdma_free_dev(struct kref *ref)
>  	list_del(&ndev->entry);
>  	mutex_unlock(&device_list_mutex);
>
> -	nvmet_rdma_destroy_srq(ndev);
> +	nvmet_rdma_destroy_srqs(ndev);
>  	ib_dealloc_pd(ndev->pd);
>
>  	kfree(ndev);
> @@ -953,7 +1050,7 @@ static void nvmet_rdma_free_dev(struct kref *ref)
>  		goto out_free_dev;
>
>  	if (nvmet_rdma_use_srq) {
> -		ret = nvmet_rdma_init_srq(ndev);
> +		ret = nvmet_rdma_init_srqs(ndev);
>  		if (ret)
>  			goto out_free_pd;
>  	}
> @@ -977,14 +1074,8 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
>  {
>  	struct ib_qp_init_attr qp_attr;
>  	struct nvmet_rdma_device *ndev = queue->dev;
> -	int comp_vector, nr_cqe, ret, i;
> +	int nr_cqe, ret, i;
>
> -	/*
> -	 * Spread the io queues across completion vectors,
> -	 * but still keep all admin queues on vector 0.
> -	 */
> -	comp_vector = !queue->host_qid ? 0 :
> -		queue->idx % ndev->device->num_comp_vectors;
>
>  	/*
>  	 * Reserve CQ slots for RECV + RDMA_READ/RDMA_WRITE + RDMA_SEND.
> @@ -992,7 +1083,7 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
>  	nr_cqe = queue->recv_queue_size + 2 * queue->send_queue_size;
>
>  	queue->cq = ib_alloc_cq(ndev->device, queue,
> -			nr_cqe + 1, comp_vector,
> +			nr_cqe + 1, queue->comp_vector,
>  			IB_POLL_WORKQUEUE);
>  	if (IS_ERR(queue->cq)) {
>  		ret = PTR_ERR(queue->cq);
> @@ -1014,8 +1105,8 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
>  	qp_attr.cap.max_send_sge = max(ndev->device->attrs.max_sge_rd,
>  					ndev->device->attrs.max_send_sge);
>
> -	if (ndev->srq) {
> -		qp_attr.srq = ndev->srq;
> +	if (queue->nsrq) {
> +		qp_attr.srq = queue->nsrq->srq;
>  	} else {
>  		/* +1 for drain */
>  		qp_attr.cap.max_recv_wr = 1 + queue->recv_queue_size;
> @@ -1034,7 +1125,7 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
>  		 __func__, queue->cq->cqe, qp_attr.cap.max_send_sge,
>  		 qp_attr.cap.max_send_wr, queue->cm_id);
>
> -	if (!ndev->srq) {
> +	if (!queue->nsrq) {
>  		for (i = 0; i < queue->recv_queue_size; i++) {
>  			queue->cmds[i].queue = queue;
>  			ret = nvmet_rdma_post_recv(ndev, &queue->cmds[i]);
> @@ -1070,7 +1161,7 @@ static void nvmet_rdma_free_queue(struct nvmet_rdma_queue *queue)
>  	nvmet_sq_destroy(&queue->nvme_sq);
>
>  	nvmet_rdma_destroy_queue_ib(queue);
> -	if (!queue->dev->srq) {
> +	if (!queue->nsrq) {
>  		nvmet_rdma_free_cmds(queue->dev, queue->cmds,
>  				queue->recv_queue_size,
>  				!queue->host_qid);
> @@ -1182,13 +1273,22 @@ static int nvmet_rdma_cm_reject(struct rdma_cm_id *cm_id,
>  		goto out_destroy_sq;
>  	}
>
> +	/*
> +	 * Spread the io queues across completion vectors,
> +	 * but still keep all admin queues on vector 0.
> +	 */
> +	queue->comp_vector = !queue->host_qid ? 0 :
> +		queue->idx % ndev->device->num_comp_vectors;
> +
>  	ret = nvmet_rdma_alloc_rsps(queue);
>  	if (ret) {
>  		ret = NVME_RDMA_CM_NO_RSC;
>  		goto out_ida_remove;
>  	}
>
> -	if (!ndev->srq) {
> +	if (ndev->srqs) {
> +		queue->nsrq = ndev->srqs[queue->comp_vector % ndev->srq_count];
> +	} else {
>  		queue->cmds = nvmet_rdma_alloc_cmds(ndev,
>  				queue->recv_queue_size,
>  				!queue->host_qid);
> @@ -1209,10 +1309,12 @@ static int nvmet_rdma_cm_reject(struct rdma_cm_id *cm_id,
>  	return queue;
>
>  out_free_cmds:
> -	if (!ndev->srq) {
> +	if (!queue->nsrq) {
>  		nvmet_rdma_free_cmds(queue->dev, queue->cmds,
>  				queue->recv_queue_size,
>  				!queue->host_qid);
> +	} else {
> +		queue->nsrq = NULL;

I have no idea if it right or not, but the logic seems strange.
If queue->nsrq exists, you nullify the pointer, is it done on purpose?

Thanks

>  	}
>  out_free_responses:
>  	nvmet_rdma_free_rsps(queue);
> --
> 1.8.3.1
>
