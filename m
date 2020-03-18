Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A79F6189808
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 10:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgCRJjj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 05:39:39 -0400
Received: from mail-am6eur05on2081.outbound.protection.outlook.com ([40.107.22.81]:13696
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727443AbgCRJjj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Mar 2020 05:39:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ir3mIixVZf1ab4sS2s24lxVINoMFJrXD7Demj5Hf6M0y8aGkxfzP50Wx8Qc4DxkIfbKBYdz+/5WfG6kkZPba0jfOGfv9kNp5+Gg3mIFaNz9zOEUjnGBdDQYJ7lCb4A/av1iNnlcGK8gZdX0hubFCxtDbDEG/T+VO5elMzz1C7IZZ7szsjeCBhCQzu6FSWPKSn+CgB5YeU9uTwiMKZ0KVQ6WHbNfDAxkn15HxLgRyRO18qAHpFKTGHAew5nSWoyvvaZt5PCzTv5uBeb4bD2nHpPqMyoHLN6h6m5chfjzz7JjJBwZifkWSU8FYyp5M+YZbwryeOTHjJkbzW0ynrf3uMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7Sm69Ceh0+hq5hyeMYdVuP5YKwc0JPmBc2p8EwwGvo=;
 b=lHfHQbmfwW0+TZKKLsLGyx5rFHoBbHKXufQOoaiTaKQPeKeWsZiimOvfnkNVoiAnvKp1WX1jMFrj0Ze1SrNaQ7fddfV4bZcXDKUI9Dohw8jCmN3xLGftCm7BmefhPojzOO+4Glbv6XZG02dFujGzqYip13t48EToTGlHLdTzwsgcA/4ly0psTPYyvPMfBYG3FDR716j8MkD4v4ZDtkQRBNepPxtcU2p/4aUQGN3/oTW2PZC+u4awK+poyhxhJuO8C+OFA0JXqV2vnm8UT/2PPNfValHVED9hqrjw9dJzDDw3lf/XyMEJYL3plpIKjRFOs2JkkWVYXytf5UUl2rUTeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=redhat.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7Sm69Ceh0+hq5hyeMYdVuP5YKwc0JPmBc2p8EwwGvo=;
 b=QDOhVidBnHnTUUNBY8qM8EMOeOwlGsFtphv2oTLnyqTugo+AbdrAVUh5P1nqdrZBkrjffJpSb8lxoCQti1Cf2V4/Nht+9G0ggEJJlgHSl4tH7o4jH2PSOCwb2rbSLIxW6pg5jT+25mo/aDsnYArPgQPrpOtiEHiaygJ/fjQvHWc=
Received: from DBBPR09CA0019.eurprd09.prod.outlook.com (2603:10a6:10:c0::31)
 by AM7PR05MB7073.eurprd05.prod.outlook.com (2603:10a6:20b:1a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Wed, 18 Mar
 2020 09:39:33 +0000
Received: from DB5EUR03FT006.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:c0:cafe::40) by DBBPR09CA0019.outlook.office365.com
 (2603:10a6:10:c0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.19 via Frontend
 Transport; Wed, 18 Mar 2020 09:39:33 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT006.mail.protection.outlook.com (10.152.20.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2814.13 via Frontend Transport; Wed, 18 Mar 2020 09:39:33 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Wed, 18 Mar 2020 11:39:31
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Wed,
 18 Mar 2020 11:39:31 +0200
Received: from [172.27.15.134] (172.27.15.134) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Wed, 18 Mar 2020 11:39:29
 +0200
Subject: Re: [PATCH 3/5] nvmet-rdma: use SRQ per completion vector
To:     Leon Romanovsky <leonro@mellanox.com>
CC:     <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <hch@lst.de>,
        <loberman@redhat.com>, <bvanassche@acm.org>,
        <linux-rdma@vger.kernel.org>, <kbusch@kernel.org>,
        <jgg@mellanox.com>, <dledford@redhat.com>, <idanb@mellanox.com>,
        <shlomin@mellanox.com>, <oren@mellanox.com>,
        <vladimirk@mellanox.com>
References: <20200317134030.152833-1-maxg@mellanox.com>
 <20200317134030.152833-4-maxg@mellanox.com> <20200318065355.GQ3351@unreal>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <1c551706-0938-61b4-793a-fa751b0d4f94@mellanox.com>
Date:   Wed, 18 Mar 2020 11:39:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200318065355.GQ3351@unreal>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.27.15.134]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251;IPV:;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(396003)(136003)(39860400002)(199004)(46966005)(54906003)(186003)(6636002)(47076004)(16526019)(2616005)(107886003)(37006003)(4326008)(8936002)(6862004)(31686004)(81166006)(16576012)(26005)(316002)(2906002)(31696002)(30864003)(36756003)(86362001)(478600001)(81156014)(53546011)(8676002)(356004)(6666004)(5660300002)(70586007)(336012)(70206006)(21314003)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM7PR05MB7073;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 117a5d72-315c-4913-a849-08d7cb20441f
X-MS-TrafficTypeDiagnostic: AM7PR05MB7073:
X-Microsoft-Antispam-PRVS: <AM7PR05MB7073D9E53E27FD147C334F9CB6F70@AM7PR05MB7073.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03468CBA43
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p1cUmJyPuMT3Z4F/scjowxXclCq5axu1NIFDi1B2cKRhk9+KSpNTM5aW196EesiAWcazakeEKwleV/8mjGUv4Jqs342ZqmFrTG8qCsies4CueNQMxtrguBqYBIo++fSdbQUwf+y0bZY17inBKQ0cQsAhNkJsSLtcZr/yyEPzx2kzkH9bHnrEmMPM2v4W556+O6dw1fHg8p4IQQb71BreYIonkAHWpmlBj0X2XAUmNbEk+8r9OD82PF55JOJ+6UKUjZzPomF0UVzBcyK5rG+9D2A94jdClvm8oSjsgPQtvArcPTSd/RJskiDqNCFYFV4fBTVOXIZ11eNTofm8XZAWyzqXz7e8+inE8nDRYpngeB+gE1eSDFmVUAgkrkZ6AvcNqmx55LMknzZcfAo5uOPYNl3mpJ0SxU8fjm7dMYeXgYCi3jJ4ZxJjOKH/UJDVUP0/WnkNjhJpF/CI3P+Hva/O4j4IUo92IP6t3oX4+thq7IvX5vcWbCSdhVizNDOcx7HtNR87oPWWPmlAQeact21DJvo/nXumn3Sl9FCCY9nvJt62tKnpvQBMolH4gn0pazcF
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 09:39:33.5959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 117a5d72-315c-4913-a849-08d7cb20441f
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.251];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR05MB7073
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 3/18/2020 8:53 AM, Leon Romanovsky wrote:
> On Tue, Mar 17, 2020 at 03:40:28PM +0200, Max Gurtovoy wrote:
>> In order to save resource allocation and utilize the completion
>> locality in a better way (compared to SRQ per device that exist today),
>> allocate Shared Receive Queues (SRQs) per completion vector. Associate
>> each created QP/CQ with an appropriate SRQ according to the queue index.
>> This association will reduce the lock contention in the fast path
>> (compared to SRQ per device solution) and increase the locality in
>> memory buffers. Add new module parameter for SRQ size to adjust it
>> according to the expected load. User should make sure the size is >= 256
>> to avoid lack of resources.
>>
>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
>> ---
>>   drivers/nvme/target/rdma.c | 204 +++++++++++++++++++++++++++++++++------------
>>   1 file changed, 153 insertions(+), 51 deletions(-)
>>
>> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
>> index 04062af..f560257 100644
>> --- a/drivers/nvme/target/rdma.c
>> +++ b/drivers/nvme/target/rdma.c
>> @@ -18,6 +18,7 @@
>>   #include <asm/unaligned.h>
>>
>>   #include <rdma/ib_verbs.h>
>> +#include <rdma/srq_set.h>
>>   #include <rdma/rdma_cm.h>
>>   #include <rdma/rw.h>
>>
>> @@ -31,6 +32,8 @@
>>   #define NVMET_RDMA_MAX_INLINE_SGE		4
>>   #define NVMET_RDMA_MAX_INLINE_DATA_SIZE		max_t(int, SZ_16K, PAGE_SIZE)
>>
>> +struct nvmet_rdma_srq;
>> +
>>   struct nvmet_rdma_cmd {
>>   	struct ib_sge		sge[NVMET_RDMA_MAX_INLINE_SGE + 1];
>>   	struct ib_cqe		cqe;
>> @@ -38,7 +41,7 @@ struct nvmet_rdma_cmd {
>>   	struct scatterlist	inline_sg[NVMET_RDMA_MAX_INLINE_SGE];
>>   	struct nvme_command     *nvme_cmd;
>>   	struct nvmet_rdma_queue	*queue;
>> -	struct ib_srq		*srq;
>> +	struct nvmet_rdma_srq   *nsrq;
>>   };
>>
>>   enum {
>> @@ -80,6 +83,7 @@ struct nvmet_rdma_queue {
>>   	struct ib_cq		*cq;
>>   	atomic_t		sq_wr_avail;
>>   	struct nvmet_rdma_device *dev;
>> +	struct nvmet_rdma_srq   *nsrq;
>>   	spinlock_t		state_lock;
>>   	enum nvmet_rdma_queue_state state;
>>   	struct nvmet_cq		nvme_cq;
>> @@ -97,17 +101,24 @@ struct nvmet_rdma_queue {
>>
>>   	int			idx;
>>   	int			host_qid;
>> +	int			comp_vector;
>>   	int			recv_queue_size;
>>   	int			send_queue_size;
>>
>>   	struct list_head	queue_list;
>>   };
>>
>> +struct nvmet_rdma_srq {
>> +	struct ib_srq            *srq;
>> +	struct nvmet_rdma_cmd    *cmds;
>> +	struct nvmet_rdma_device *ndev;
>> +};
>> +
>>   struct nvmet_rdma_device {
>>   	struct ib_device	*device;
>>   	struct ib_pd		*pd;
>> -	struct ib_srq		*srq;
>> -	struct nvmet_rdma_cmd	*srq_cmds;
>> +	struct nvmet_rdma_srq	**srqs;
>> +	int			srq_count;
>>   	size_t			srq_size;
>>   	struct kref		ref;
>>   	struct list_head	entry;
>> @@ -119,6 +130,16 @@ struct nvmet_rdma_device {
>>   module_param_named(use_srq, nvmet_rdma_use_srq, bool, 0444);
>>   MODULE_PARM_DESC(use_srq, "Use shared receive queue.");
>>
>> +static int srq_size_set(const char *val, const struct kernel_param *kp);
>> +static const struct kernel_param_ops srq_size_ops = {
>> +	.set = srq_size_set,
>> +	.get = param_get_int,
>> +};
>> +
>> +static int nvmet_rdma_srq_size = 1024;
>> +module_param_cb(srq_size, &srq_size_ops, &nvmet_rdma_srq_size, 0644);
>> +MODULE_PARM_DESC(srq_size, "set Shared Receive Queue (SRQ) size, should >= 256 (default: 1024)");
>> +
> Why do you need this? Do you expect users to change this parameter for
> every different workload?

No. I want to help users to control their memory consumption that is 
very important in systems/storage-nodes with limited resources, instead 
of setting a values that might be over-consuming for them.

>
>
>>   static DEFINE_IDA(nvmet_rdma_queue_ida);
>>   static LIST_HEAD(nvmet_rdma_queue_list);
>>   static DEFINE_MUTEX(nvmet_rdma_queue_mutex);
>> @@ -139,6 +160,17 @@ static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
>>
>>   static const struct nvmet_fabrics_ops nvmet_rdma_ops;
>>
>> +static int srq_size_set(const char *val, const struct kernel_param *kp)
>> +{
>> +	int n = 0, ret;
>> +
>> +	ret = kstrtoint(val, 10, &n);
>> +	if (ret != 0 || n < 256)
>> +		return -EINVAL;
>> +
>> +	return param_set_int(val, kp);
>> +}
>> +
>>   static int num_pages(int len)
>>   {
>>   	return 1 + (((len - 1) & PAGE_MASK) >> PAGE_SHIFT);
>> @@ -462,8 +494,8 @@ static int nvmet_rdma_post_recv(struct nvmet_rdma_device *ndev,
>>   		cmd->sge[0].addr, cmd->sge[0].length,
>>   		DMA_FROM_DEVICE);
>>
>> -	if (cmd->srq)
>> -		ret = ib_post_srq_recv(cmd->srq, &cmd->wr, NULL);
>> +	if (cmd->nsrq)
>> +		ret = ib_post_srq_recv(cmd->nsrq->srq, &cmd->wr, NULL);
>>   	else
>>   		ret = ib_post_recv(cmd->queue->cm_id->qp, &cmd->wr, NULL);
>>
>> @@ -841,30 +873,82 @@ static void nvmet_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
>>   	nvmet_rdma_handle_command(queue, rsp);
>>   }
>>
>> -static void nvmet_rdma_destroy_srq(struct nvmet_rdma_device *ndev)
>> +static void nvmet_rdma_destroy_srq(struct nvmet_rdma_srq *nsrq)
>> +{
>> +	nvmet_rdma_free_cmds(nsrq->ndev, nsrq->cmds, nsrq->ndev->srq_size, false);
>> +	rdma_srq_put(nsrq->ndev->pd, nsrq->srq);
>> +
>> +	kfree(nsrq);
>> +}
>> +
>> +static void nvmet_rdma_destroy_srqs(struct nvmet_rdma_device *ndev)
>>   {
>> -	if (!ndev->srq)
>> +	int i;
>> +
>> +	if (!ndev->srqs)
>>   		return;
>>
>> -	nvmet_rdma_free_cmds(ndev, ndev->srq_cmds, ndev->srq_size, false);
>> -	ib_destroy_srq(ndev->srq);
>> +	for (i = 0; i < ndev->srq_count; i++)
>> +		nvmet_rdma_destroy_srq(ndev->srqs[i]);
>> +
>> +	rdma_srq_set_destroy(ndev->pd);
>> +	kfree(ndev->srqs);
>> +	ndev->srqs = NULL;
>> +	ndev->srq_count = 0;
>> +	ndev->srq_size = 0;
>>   }
>>
>> -static int nvmet_rdma_init_srq(struct nvmet_rdma_device *ndev)
>> +static struct nvmet_rdma_srq *
>> +nvmet_rdma_init_srq(struct nvmet_rdma_device *ndev)
>>   {
>> -	struct ib_srq_init_attr srq_attr = { NULL, };
>> +	size_t srq_size = ndev->srq_size;
>> +	struct nvmet_rdma_srq *nsrq;
>>   	struct ib_srq *srq;
>> -	size_t srq_size;
>>   	int ret, i;
>>
>> -	srq_size = 4095;	/* XXX: tune */
>> +	nsrq = kzalloc(sizeof(*nsrq), GFP_KERNEL);
>> +	if (!nsrq)
>> +		return ERR_PTR(-ENOMEM);
>>
>> -	srq_attr.attr.max_wr = srq_size;
>> -	srq_attr.attr.max_sge = 1 + ndev->inline_page_count;
>> -	srq_attr.attr.srq_limit = 0;
>> -	srq_attr.srq_type = IB_SRQT_BASIC;
>> -	srq = ib_create_srq(ndev->pd, &srq_attr);
>> -	if (IS_ERR(srq)) {
>> +	srq = rdma_srq_get(ndev->pd);
>> +	if (!srq) {
>> +		ret = -EAGAIN;
>> +		goto out_free_nsrq;
>> +	}
>> +
>> +	nsrq->cmds = nvmet_rdma_alloc_cmds(ndev, srq_size, false);
>> +	if (IS_ERR(nsrq->cmds)) {
>> +		ret = PTR_ERR(nsrq->cmds);
>> +		goto out_put_srq;
>> +	}
>> +
>> +	nsrq->srq = srq;
>> +	nsrq->ndev = ndev;
>> +
>> +	for (i = 0; i < srq_size; i++) {
>> +		nsrq->cmds[i].nsrq = nsrq;
>> +		ret = nvmet_rdma_post_recv(ndev, &nsrq->cmds[i]);
>> +		if (ret)
>> +			goto out_free_cmds;
>> +	}
>> +
>> +	return nsrq;
>> +
>> +out_free_cmds:
>> +	nvmet_rdma_free_cmds(ndev, nsrq->cmds, srq_size, false);
>> +out_put_srq:
>> +	rdma_srq_put(ndev->pd, srq);
>> +out_free_nsrq:
>> +	kfree(nsrq);
>> +	return ERR_PTR(ret);
>> +}
>> +
>> +static int nvmet_rdma_init_srqs(struct nvmet_rdma_device *ndev)
>> +{
>> +	struct ib_srq_init_attr srq_attr = { NULL, };
>> +	int i, ret;
>> +
>> +	if (!ndev->device->attrs.max_srq_wr || !ndev->device->attrs.max_srq) {
>>   		/*
>>   		 * If SRQs aren't supported we just go ahead and use normal
>>   		 * non-shared receive queues.
>> @@ -873,31 +957,44 @@ static int nvmet_rdma_init_srq(struct nvmet_rdma_device *ndev)
>>   		return 0;
>>   	}
>>
>> -	ndev->srq_cmds = nvmet_rdma_alloc_cmds(ndev, srq_size, false);
>> -	if (IS_ERR(ndev->srq_cmds)) {
>> -		ret = PTR_ERR(ndev->srq_cmds);
>> -		goto out_destroy_srq;
>> -	}
>> +	ndev->srq_size = min(ndev->device->attrs.max_srq_wr,
>> +			     nvmet_rdma_srq_size);
>> +	ndev->srq_count = min(ndev->device->num_comp_vectors,
>> +			      ndev->device->attrs.max_srq);
>>
>> -	ndev->srq = srq;
>> -	ndev->srq_size = srq_size;
>> +	ndev->srqs = kcalloc(ndev->srq_count, sizeof(*ndev->srqs), GFP_KERNEL);
>> +	if (!ndev->srqs)
>> +		return -ENOMEM;
>>
>> -	for (i = 0; i < srq_size; i++) {
>> -		ndev->srq_cmds[i].srq = srq;
>> -		ret = nvmet_rdma_post_recv(ndev, &ndev->srq_cmds[i]);
>> -		if (ret)
>> -			goto out_free_cmds;
>> +	srq_attr.attr.max_wr = ndev->srq_size;
>> +	srq_attr.attr.max_sge = 2;
>> +	srq_attr.attr.srq_limit = 0;
>> +	srq_attr.srq_type = IB_SRQT_BASIC;
>> +	ret = rdma_srq_set_init(ndev->pd, ndev->srq_count, &srq_attr);
>> +	if (ret)
>> +		goto err_free;
>> +
>> +	for (i = 0; i < ndev->srq_count; i++) {
>> +		ndev->srqs[i] = nvmet_rdma_init_srq(ndev);
>> +		if (IS_ERR(ndev->srqs[i]))
>> +			goto err_srq;
>>   	}
>>
>>   	return 0;
>>
>> -out_free_cmds:
>> -	nvmet_rdma_free_cmds(ndev, ndev->srq_cmds, ndev->srq_size, false);
>> -out_destroy_srq:
>> -	ib_destroy_srq(srq);
>> +err_srq:
>> +	while (--i >= 0)
>> +		nvmet_rdma_destroy_srq(ndev->srqs[i]);
>> +	rdma_srq_set_destroy(ndev->pd);
>> +err_free:
>> +	kfree(ndev->srqs);
>> +	ndev->srqs = NULL;
>> +	ndev->srq_count = 0;
>> +	ndev->srq_size = 0;
>>   	return ret;
>>   }
>>
>> +
>>   static void nvmet_rdma_free_dev(struct kref *ref)
>>   {
>>   	struct nvmet_rdma_device *ndev =
>> @@ -907,7 +1004,7 @@ static void nvmet_rdma_free_dev(struct kref *ref)
>>   	list_del(&ndev->entry);
>>   	mutex_unlock(&device_list_mutex);
>>
>> -	nvmet_rdma_destroy_srq(ndev);
>> +	nvmet_rdma_destroy_srqs(ndev);
>>   	ib_dealloc_pd(ndev->pd);
>>
>>   	kfree(ndev);
>> @@ -953,7 +1050,7 @@ static void nvmet_rdma_free_dev(struct kref *ref)
>>   		goto out_free_dev;
>>
>>   	if (nvmet_rdma_use_srq) {
>> -		ret = nvmet_rdma_init_srq(ndev);
>> +		ret = nvmet_rdma_init_srqs(ndev);
>>   		if (ret)
>>   			goto out_free_pd;
>>   	}
>> @@ -977,14 +1074,8 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
>>   {
>>   	struct ib_qp_init_attr qp_attr;
>>   	struct nvmet_rdma_device *ndev = queue->dev;
>> -	int comp_vector, nr_cqe, ret, i;
>> +	int nr_cqe, ret, i;
>>
>> -	/*
>> -	 * Spread the io queues across completion vectors,
>> -	 * but still keep all admin queues on vector 0.
>> -	 */
>> -	comp_vector = !queue->host_qid ? 0 :
>> -		queue->idx % ndev->device->num_comp_vectors;
>>
>>   	/*
>>   	 * Reserve CQ slots for RECV + RDMA_READ/RDMA_WRITE + RDMA_SEND.
>> @@ -992,7 +1083,7 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
>>   	nr_cqe = queue->recv_queue_size + 2 * queue->send_queue_size;
>>
>>   	queue->cq = ib_alloc_cq(ndev->device, queue,
>> -			nr_cqe + 1, comp_vector,
>> +			nr_cqe + 1, queue->comp_vector,
>>   			IB_POLL_WORKQUEUE);
>>   	if (IS_ERR(queue->cq)) {
>>   		ret = PTR_ERR(queue->cq);
>> @@ -1014,8 +1105,8 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
>>   	qp_attr.cap.max_send_sge = max(ndev->device->attrs.max_sge_rd,
>>   					ndev->device->attrs.max_send_sge);
>>
>> -	if (ndev->srq) {
>> -		qp_attr.srq = ndev->srq;
>> +	if (queue->nsrq) {
>> +		qp_attr.srq = queue->nsrq->srq;
>>   	} else {
>>   		/* +1 for drain */
>>   		qp_attr.cap.max_recv_wr = 1 + queue->recv_queue_size;
>> @@ -1034,7 +1125,7 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
>>   		 __func__, queue->cq->cqe, qp_attr.cap.max_send_sge,
>>   		 qp_attr.cap.max_send_wr, queue->cm_id);
>>
>> -	if (!ndev->srq) {
>> +	if (!queue->nsrq) {
>>   		for (i = 0; i < queue->recv_queue_size; i++) {
>>   			queue->cmds[i].queue = queue;
>>   			ret = nvmet_rdma_post_recv(ndev, &queue->cmds[i]);
>> @@ -1070,7 +1161,7 @@ static void nvmet_rdma_free_queue(struct nvmet_rdma_queue *queue)
>>   	nvmet_sq_destroy(&queue->nvme_sq);
>>
>>   	nvmet_rdma_destroy_queue_ib(queue);
>> -	if (!queue->dev->srq) {
>> +	if (!queue->nsrq) {
>>   		nvmet_rdma_free_cmds(queue->dev, queue->cmds,
>>   				queue->recv_queue_size,
>>   				!queue->host_qid);
>> @@ -1182,13 +1273,22 @@ static int nvmet_rdma_cm_reject(struct rdma_cm_id *cm_id,
>>   		goto out_destroy_sq;
>>   	}
>>
>> +	/*
>> +	 * Spread the io queues across completion vectors,
>> +	 * but still keep all admin queues on vector 0.
>> +	 */
>> +	queue->comp_vector = !queue->host_qid ? 0 :
>> +		queue->idx % ndev->device->num_comp_vectors;
>> +
>>   	ret = nvmet_rdma_alloc_rsps(queue);
>>   	if (ret) {
>>   		ret = NVME_RDMA_CM_NO_RSC;
>>   		goto out_ida_remove;
>>   	}
>>
>> -	if (!ndev->srq) {
>> +	if (ndev->srqs) {
>> +		queue->nsrq = ndev->srqs[queue->comp_vector % ndev->srq_count];
>> +	} else {
>>   		queue->cmds = nvmet_rdma_alloc_cmds(ndev,
>>   				queue->recv_queue_size,
>>   				!queue->host_qid);
>> @@ -1209,10 +1309,12 @@ static int nvmet_rdma_cm_reject(struct rdma_cm_id *cm_id,
>>   	return queue;
>>
>>   out_free_cmds:
>> -	if (!ndev->srq) {
>> +	if (!queue->nsrq) {
>>   		nvmet_rdma_free_cmds(queue->dev, queue->cmds,
>>   				queue->recv_queue_size,
>>   				!queue->host_qid);
>> +	} else {
>> +		queue->nsrq = NULL;
> I have no idea if it right or not, but the logic seems strange.
> If queue->nsrq exists, you nullify the pointer, is it done on purpose?

Yes. nsrq is a pointer taken from ndev->srqs and was allocated by the 
device.


>
> Thanks
>
>>   	}
>>   out_free_responses:
>>   	nvmet_rdma_free_rsps(queue);
>> --
>> 1.8.3.1
>>
