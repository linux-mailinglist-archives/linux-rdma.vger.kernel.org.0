Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8477231B44
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jul 2020 10:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgG2Ie0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Jul 2020 04:34:26 -0400
Received: from mail-eopbgr150047.outbound.protection.outlook.com ([40.107.15.47]:63546
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727902AbgG2IeZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 29 Jul 2020 04:34:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YV198EiMomTcl/ILjrvNJOqc/HOnAfYHriHUDFn6SHlzrPgq8LGwlVEm/B1LyaQ9FCVceRjctp2ozOrOlWED73iuBtsKnyRWu1xw0/XS5f8r/YNlUAVc/socUkENJ+mXs9hKQLUmOj9HhWVzen1wwcQn3qqPCj0CVipOsonKTDXj4g/hCNVEL6fqSAstnKFi8np6FHogpsYEY5L1u32Zm/eosqTWYb9eYiCOn89AvNWNqT7GUj3Tk4MGlL3Av/MusJKKhwRYRyLeMBe4vR7xSY6jbKUMB8NNTQ7Knd6OElVAoN4v6B8dB2krdFnX1YpV1NEIMe26yxIPH+hqvFAGhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNgOsKgCsB0wV0uhUwCSaI24Vq9p+Jp1Ao464nGe+Nc=;
 b=oI2R2nAM/ymkPW2Lc9EtXL3NkKfoo/rUedIiU8TXRcVJtqhgvZFhc0SsvGzfC9vPz6hlJsdw2Q3Qw28TMQporKbQMnbdjFjfy8TResqBdTxfCW4AN91wxoJzCCnTqCBYlLIt0nHq1nPxvj/2n6kNEbYj/0h5jRiudCH/TiHRN3dAnyu6qIntS9aJvcc01UADH4OXuqGPGsmpGAjMvWK/2p4ICyTr/W9SkF5STxfoZ1PmNgmOhhLGCZyxx0KCorhybAjThTVsHyVEEcxXzDjxE8FyvDi5j6pO+pbVWe59F2UNqGjaRn5lLxSQLSfyTgTjJDgCR4FsaFdPNxHjQAB/ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNgOsKgCsB0wV0uhUwCSaI24Vq9p+Jp1Ao464nGe+Nc=;
 b=IZJlkia3FIVpq23W4XBFXJZfRjVT/3L1zcmHUX67U8O6XLeMDd9Hvv9iF60wE5PcZvNslogQbYhW54Lq1tXYu5nlBEB9T2HNoICchG77xt1TUxgByDz+iXoT4X8NPxEguJE4+AcmR+vWA66d9qNPuWVNWT1tcKKCx/yUKLMaqik=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM4PR0501MB2738.eurprd05.prod.outlook.com (2603:10a6:200:5a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Wed, 29 Jul
 2020 08:34:20 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::4065:87d7:1f28:26c3]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::4065:87d7:1f28:26c3%6]) with mapi id 15.20.3216.033; Wed, 29 Jul 2020
 08:34:20 +0000
Subject: Re: [PATCH 1/3] IB/iser: use new shared CQ mechanism
To:     sagi@grimberg.me, yaminf@mellanox.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, leon@kernel.org, bvanassche@acm.org
Cc:     israelr@mellanox.com, oren@mellanox.com, jgg@mellanox.com,
        idanb@mellanox.com
References: <20200722135629.49467-1-maxg@mellanox.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <b922a13b-592b-0c03-bd0e-c7b6c7d4a54e@mellanox.com>
Date:   Wed, 29 Jul 2020 11:34:11 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200722135629.49467-1-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::12) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.10] (93.172.65.141) by FR2P281CA0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.10 via Frontend Transport; Wed, 29 Jul 2020 08:34:19 +0000
X-Originating-IP: [93.172.65.141]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 842a3192-f7c0-43ec-d42d-08d8339a3064
X-MS-TrafficTypeDiagnostic: AM4PR0501MB2738:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4PR0501MB273893C7776D76869A43E61BB6700@AM4PR0501MB2738.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:549;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: erxAwQlImN9hsZiJnagmt4pToMD2mTSBYjRcAFhi/2+az8kpJOQmbaErkyCGUcid0rdE/qRcxPHd7RA+vwlGV8JBO1N8O/eJKNs9sd8UEEi4C9LePG8OzJCGKlw6B5TbfRKLpeIPgpTPYUkCywtg75vhLFpCPAWVgAE+3QE4C2GVXNL7umOWNuiEkRou8LG9xPoN+FHlSglOmkS0nbS7dOLvrxrl9C1sWNKOkcUGDbHa8vhfrnXkwVveorrLZZyJcdBASFcuCq7f1aNL2PksbOy8Nyq/h2od0inNVxfG+FENLPx0eGU2jCTJV0ykwmLUReE2CJO0rwvF+sbEO8hwxVmo3uw1Bdsum1fQuU62MyMK9ljSnQ6PERUvinTonSpj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB5810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(4326008)(478600001)(8936002)(16526019)(107886003)(5660300002)(66556008)(186003)(16576012)(26005)(2616005)(956004)(31696002)(36756003)(86362001)(66476007)(6666004)(52116002)(53546011)(8676002)(31686004)(2906002)(66946007)(316002)(6486002)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: mfG+ZzpiMoycYSrAk0WaOEgPSp9nafTJQD3j42RxZuR/LpHJbW5srswzXwWUbvxwJbwc5gGFd25sPQONAS/kd3nct8bIjnfjhOgxJbuXRFDedVvU9WBUCvhnPUCygnJNFyVSznTiLaLI7lr6aL87hxkhIdnYJatqxeUrsd5uGD6iSu0aqBHK4qhbgVNHgqPyiQS2mo8ZbmsEOq6Hyd1qjgLHzemtl74lz1i1txb+QlfvRuoikQhtfvVxT41X1FcrHeU92G2N/mUjKoXt4krGCN1FUZnN3Q/9AZ+cP6vh9mv7StRX1+AuxCEFHIPHD+mmVTIEj1ytiHZWse1PY/HOQCdChEXjLPvzVPwS0iItubwReMFeuWbaNH5G1m/5AKQ2sacdlaymeA6ZHHGqX1Oo3anXYCxqeYA3YvjclgD/fwX+KcbhENo06HPJae92EEHNyKo+98Du2Wk+7SH/rj35sdyYzVKSjtKWYJVOW7kror1Wx+oWZVJ6Kl5ooCWR9kcE
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 842a3192-f7c0-43ec-d42d-08d8339a3064
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB5810.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 08:34:20.4938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FYBq3/j4+N3X9+g6Pa3YmYhfQFlmogMf3cpPAEgStUXy532sbxiQnAHjSmqqOOCPcN9/l2CZ9expGB+DRSG/fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0501MB2738
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Jason/Leon,

can you please pull this to "for-kernel-5.9" branch please ?

Or do we need more reviews on this series ?

On 7/22/2020 4:56 PM, Max Gurtovoy wrote:
> From: Yamin Friedman <yaminf@mellanox.com>
>
> Has the driver use shared CQs provided by the rdma core driver.
> Because this provides similar functionality to iser_comp it has been
> removed. Now there is no reason to allocate very large CQs when the driver
> is loaded while gaining the advantage of shared CQs.
>
> Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
> Acked-by: Max Gurtovoy <maxg@mellanox.com>
> ---
>   drivers/infiniband/ulp/iser/iscsi_iser.h |  23 ++-----
>   drivers/infiniband/ulp/iser/iser_verbs.c | 112 +++++++------------------------
>   2 files changed, 29 insertions(+), 106 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.h b/drivers/infiniband/ulp/iser/iscsi_iser.h
> index 1d77c7f..fddcb88 100644
> --- a/drivers/infiniband/ulp/iser/iscsi_iser.h
> +++ b/drivers/infiniband/ulp/iser/iscsi_iser.h
> @@ -300,18 +300,6 @@ struct iser_login_desc {
>   struct iscsi_iser_task;
>   
>   /**
> - * struct iser_comp - iSER completion context
> - *
> - * @cq:         completion queue
> - * @active_qps: Number of active QPs attached
> - *              to completion context
> - */
> -struct iser_comp {
> -	struct ib_cq		*cq;
> -	int                      active_qps;
> -};
> -
> -/**
>    * struct iser_device - iSER device handle
>    *
>    * @ib_device:     RDMA device
> @@ -320,9 +308,6 @@ struct iser_comp {
>    * @event_handler: IB events handle routine
>    * @ig_list:	   entry in devices list
>    * @refcount:      Reference counter, dominated by open iser connections
> - * @comps_used:    Number of completion contexts used, Min between online
> - *                 cpus and device max completion vectors
> - * @comps:         Dinamically allocated array of completion handlers
>    */
>   struct iser_device {
>   	struct ib_device             *ib_device;
> @@ -330,8 +315,6 @@ struct iser_device {
>   	struct ib_event_handler      event_handler;
>   	struct list_head             ig_list;
>   	int                          refcount;
> -	int			     comps_used;
> -	struct iser_comp	     *comps;
>   };
>   
>   /**
> @@ -380,11 +363,12 @@ struct iser_fr_pool {
>    *
>    * @cma_id:              rdma_cm connection maneger handle
>    * @qp:                  Connection Queue-pair
> + * @cq:                  Connection completion queue
> + * @cq_size:             The number of max outstanding completions
>    * @post_recv_buf_count: post receive counter
>    * @sig_count:           send work request signal count
>    * @rx_wr:               receive work request for batch posts
>    * @device:              reference to iser device
> - * @comp:                iser completion context
>    * @fr_pool:             connection fast registration poool
>    * @pi_support:          Indicate device T10-PI support
>    * @reg_cqe:             completion handler
> @@ -392,11 +376,12 @@ struct iser_fr_pool {
>   struct ib_conn {
>   	struct rdma_cm_id           *cma_id;
>   	struct ib_qp	            *qp;
> +	struct ib_cq		    *cq;
> +	u32			    cq_size;
>   	int                          post_recv_buf_count;
>   	u8                           sig_count;
>   	struct ib_recv_wr	     rx_wr[ISER_MIN_POSTED_RX];
>   	struct iser_device          *device;
> -	struct iser_comp	    *comp;
>   	struct iser_fr_pool          fr_pool;
>   	bool			     pi_support;
>   	struct ib_cqe		     reg_cqe;
> diff --git a/drivers/infiniband/ulp/iser/iser_verbs.c b/drivers/infiniband/ulp/iser/iser_verbs.c
> index c1f44c4..699e075 100644
> --- a/drivers/infiniband/ulp/iser/iser_verbs.c
> +++ b/drivers/infiniband/ulp/iser/iser_verbs.c
> @@ -68,59 +68,23 @@ static void iser_event_handler(struct ib_event_handler *handler,
>   static int iser_create_device_ib_res(struct iser_device *device)
>   {
>   	struct ib_device *ib_dev = device->ib_device;
> -	int i, max_cqe;
>   
>   	if (!(ib_dev->attrs.device_cap_flags & IB_DEVICE_MEM_MGT_EXTENSIONS)) {
>   		iser_err("IB device does not support memory registrations\n");
>   		return -1;
>   	}
>   
> -	device->comps_used = min_t(int, num_online_cpus(),
> -				 ib_dev->num_comp_vectors);
> -
> -	device->comps = kcalloc(device->comps_used, sizeof(*device->comps),
> -				GFP_KERNEL);
> -	if (!device->comps)
> -		goto comps_err;
> -
> -	max_cqe = min(ISER_MAX_CQ_LEN, ib_dev->attrs.max_cqe);
> -
> -	iser_info("using %d CQs, device %s supports %d vectors max_cqe %d\n",
> -		  device->comps_used, dev_name(&ib_dev->dev),
> -		  ib_dev->num_comp_vectors, max_cqe);
> -
>   	device->pd = ib_alloc_pd(ib_dev,
>   		iser_always_reg ? 0 : IB_PD_UNSAFE_GLOBAL_RKEY);
>   	if (IS_ERR(device->pd))
>   		goto pd_err;
>   
> -	for (i = 0; i < device->comps_used; i++) {
> -		struct iser_comp *comp = &device->comps[i];
> -
> -		comp->cq = ib_alloc_cq(ib_dev, comp, max_cqe, i,
> -				       IB_POLL_SOFTIRQ);
> -		if (IS_ERR(comp->cq)) {
> -			comp->cq = NULL;
> -			goto cq_err;
> -		}
> -	}
> -
>   	INIT_IB_EVENT_HANDLER(&device->event_handler, ib_dev,
>   			      iser_event_handler);
>   	ib_register_event_handler(&device->event_handler);
>   	return 0;
>   
> -cq_err:
> -	for (i = 0; i < device->comps_used; i++) {
> -		struct iser_comp *comp = &device->comps[i];
> -
> -		if (comp->cq)
> -			ib_free_cq(comp->cq);
> -	}
> -	ib_dealloc_pd(device->pd);
>   pd_err:
> -	kfree(device->comps);
> -comps_err:
>   	iser_err("failed to allocate an IB resource\n");
>   	return -1;
>   }
> @@ -131,20 +95,9 @@ static int iser_create_device_ib_res(struct iser_device *device)
>    */
>   static void iser_free_device_ib_res(struct iser_device *device)
>   {
> -	int i;
> -
> -	for (i = 0; i < device->comps_used; i++) {
> -		struct iser_comp *comp = &device->comps[i];
> -
> -		ib_free_cq(comp->cq);
> -		comp->cq = NULL;
> -	}
> -
>   	ib_unregister_event_handler(&device->event_handler);
>   	ib_dealloc_pd(device->pd);
>   
> -	kfree(device->comps);
> -	device->comps = NULL;
>   	device->pd = NULL;
>   }
>   
> @@ -287,70 +240,57 @@ static int iser_create_ib_conn_res(struct ib_conn *ib_conn)
>   	struct ib_device	*ib_dev;
>   	struct ib_qp_init_attr	init_attr;
>   	int			ret = -ENOMEM;
> -	int index, min_index = 0;
> +	unsigned int max_send_wr, cq_size;
>   
>   	BUG_ON(ib_conn->device == NULL);
>   
>   	device = ib_conn->device;
>   	ib_dev = device->ib_device;
>   
> -	memset(&init_attr, 0, sizeof init_attr);
> +	if (ib_conn->pi_support)
> +		max_send_wr = ISER_QP_SIG_MAX_REQ_DTOS + 1;
> +	else
> +		max_send_wr = ISER_QP_MAX_REQ_DTOS + 1;
> +	max_send_wr = min_t(unsigned int, max_send_wr,
> +			    (unsigned int)ib_dev->attrs.max_qp_wr);
>   
> -	mutex_lock(&ig.connlist_mutex);
> -	/* select the CQ with the minimal number of usages */
> -	for (index = 0; index < device->comps_used; index++) {
> -		if (device->comps[index].active_qps <
> -		    device->comps[min_index].active_qps)
> -			min_index = index;
> +	cq_size = max_send_wr + ISER_QP_MAX_RECV_DTOS;
> +	ib_conn->cq = ib_cq_pool_get(ib_dev, cq_size, -1, IB_POLL_SOFTIRQ);
> +	if (IS_ERR(ib_conn->cq)) {
> +		ret = PTR_ERR(ib_conn->cq);
> +		goto cq_err;
>   	}
> -	ib_conn->comp = &device->comps[min_index];
> -	ib_conn->comp->active_qps++;
> -	mutex_unlock(&ig.connlist_mutex);
> -	iser_info("cq index %d used for ib_conn %p\n", min_index, ib_conn);
> +	ib_conn->cq_size = cq_size;
> +
> +	memset(&init_attr, 0, sizeof(init_attr));
>   
>   	init_attr.event_handler = iser_qp_event_callback;
>   	init_attr.qp_context	= (void *)ib_conn;
> -	init_attr.send_cq	= ib_conn->comp->cq;
> -	init_attr.recv_cq	= ib_conn->comp->cq;
> +	init_attr.send_cq	= ib_conn->cq;
> +	init_attr.recv_cq	= ib_conn->cq;
>   	init_attr.cap.max_recv_wr  = ISER_QP_MAX_RECV_DTOS;
>   	init_attr.cap.max_send_sge = 2;
>   	init_attr.cap.max_recv_sge = 1;
>   	init_attr.sq_sig_type	= IB_SIGNAL_REQ_WR;
>   	init_attr.qp_type	= IB_QPT_RC;
> -	if (ib_conn->pi_support) {
> -		init_attr.cap.max_send_wr = ISER_QP_SIG_MAX_REQ_DTOS + 1;
> +	init_attr.cap.max_send_wr = max_send_wr;
> +	if (ib_conn->pi_support)
>   		init_attr.create_flags |= IB_QP_CREATE_INTEGRITY_EN;
> -		iser_conn->max_cmds =
> -			ISER_GET_MAX_XMIT_CMDS(ISER_QP_SIG_MAX_REQ_DTOS);
> -	} else {
> -		if (ib_dev->attrs.max_qp_wr > ISER_QP_MAX_REQ_DTOS) {
> -			init_attr.cap.max_send_wr  = ISER_QP_MAX_REQ_DTOS + 1;
> -			iser_conn->max_cmds =
> -				ISER_GET_MAX_XMIT_CMDS(ISER_QP_MAX_REQ_DTOS);
> -		} else {
> -			init_attr.cap.max_send_wr = ib_dev->attrs.max_qp_wr;
> -			iser_conn->max_cmds =
> -				ISER_GET_MAX_XMIT_CMDS(ib_dev->attrs.max_qp_wr);
> -			iser_dbg("device %s supports max_send_wr %d\n",
> -				 dev_name(&device->ib_device->dev),
> -				 ib_dev->attrs.max_qp_wr);
> -		}
> -	}
> +	iser_conn->max_cmds = ISER_GET_MAX_XMIT_CMDS(max_send_wr - 1);
>   
>   	ret = rdma_create_qp(ib_conn->cma_id, device->pd, &init_attr);
>   	if (ret)
>   		goto out_err;
>   
>   	ib_conn->qp = ib_conn->cma_id->qp;
> -	iser_info("setting conn %p cma_id %p qp %p\n",
> +	iser_info("setting conn %p cma_id %p qp %p max_send_wr %d\n",
>   		  ib_conn, ib_conn->cma_id,
> -		  ib_conn->cma_id->qp);
> +		  ib_conn->cma_id->qp, max_send_wr);
>   	return ret;
>   
>   out_err:
> -	mutex_lock(&ig.connlist_mutex);
> -	ib_conn->comp->active_qps--;
> -	mutex_unlock(&ig.connlist_mutex);
> +	ib_cq_pool_put(ib_conn->cq, ib_conn->cq_size);
> +cq_err:
>   	iser_err("unable to alloc mem or create resource, err %d\n", ret);
>   
>   	return ret;
> @@ -462,10 +402,8 @@ static void iser_free_ib_conn_res(struct iser_conn *iser_conn,
>   		  iser_conn, ib_conn->cma_id, ib_conn->qp);
>   
>   	if (ib_conn->qp != NULL) {
> -		mutex_lock(&ig.connlist_mutex);
> -		ib_conn->comp->active_qps--;
> -		mutex_unlock(&ig.connlist_mutex);
>   		rdma_destroy_qp(ib_conn->cma_id);
> +		ib_cq_pool_put(ib_conn->cq, ib_conn->cq_size);
>   		ib_conn->qp = NULL;
>   	}
>   
