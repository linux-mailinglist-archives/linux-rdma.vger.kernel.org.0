Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2BC4DD9DB
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Mar 2022 13:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbiCRMkP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Mar 2022 08:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiCRMkO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Mar 2022 08:40:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2AE190583
        for <linux-rdma@vger.kernel.org>; Fri, 18 Mar 2022 05:38:55 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KKk8W1PnPzcZyg;
        Fri, 18 Mar 2022 20:38:51 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 20:38:53 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 18 Mar
 2022 20:38:53 +0800
Subject: Re: [PATCH for-next v4 09/12] RDMA/erdma: Add connection management
 (CM) support
To:     Cheng Xu <chengyou@linux.alibaba.com>, <jgg@ziepe.ca>,
        <dledford@redhat.com>
References: <20220314064739.81647-1-chengyou@linux.alibaba.com>
 <20220314064739.81647-10-chengyou@linux.alibaba.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <KaiShen@linux.alibaba.com>, <tonylu@linux.alibaba.com>,
        <BMT@zurich.ibm.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <440248fc-a558-3934-0085-be37f72d889a@huawei.com>
Date:   Fri, 18 Mar 2022 20:38:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20220314064739.81647-10-chengyou@linux.alibaba.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2022/3/14 14:47, Cheng Xu wrote:
> ERDMA's transport procotol is iWarp, so the driver must support CM
> interface. In CM part, we use the same way as SoftiWarp: using kernel
> socket to setup the connection, then performing MPA negotiation in kernel.
> So, this part of code mainly comes from SoftiWarp, base on it, we add some
> more features, such as non-blocking iw_connect implementation.

procotol -> protocol
setup -> set up

<...>
> +static void erdma_socket_disassoc(struct socket *s)
> +{
> +	struct sock *sk = s->sk;
> +	struct erdma_cep *cep;
> +
> +	if (sk) {
> +		write_lock_bh(&sk->sk_callback_lock);
> +		cep = sk_to_cep(sk);
> +		if (cep) {
> +			erdma_sk_restore_upcalls(sk, cep);
> +			erdma_cep_put(cep);
> +		} else
> +			WARN_ON_ONCE(1);

If the conditional statement has a branch with curly braces,
then all branches use curly braces.

<...>
> +static void erdma_cep_set_inuse(struct erdma_cep *cep)
> +{
> +	unsigned long flags;
> +retry:
> +	spin_lock_irqsave(&cep->lock, flags);
> +
> +	if (cep->in_use) {
> +		spin_unlock_irqrestore(&cep->lock, flags);
> +		wait_event_interruptible(cep->waitq, !cep->in_use);
> +		if (signal_pending(current))
> +			flush_signals(current);
> +		goto retry;
> +	} else {
> +		cep->in_use = 1;
> +		spin_unlock_irqrestore(&cep->lock, flags);
> +	}
> +}

Using while(cep->inuse){...} instead of goto statement to
implement cep->inuse status check may make the code cleaner.

<...>
> +static int erdma_cm_upcall(struct erdma_cep *cep, enum iw_cm_event_type reason,
> +			   int status)
> +{
> +	struct iw_cm_event event;
> +	struct iw_cm_id *cm_id;
> +
> +	memset(&event, 0, sizeof(event));
> +	event.status = status;
> +	event.event = reason;
> +
> +	if (reason == IW_CM_EVENT_CONNECT_REQUEST) {
> +		event.provider_data = cep;
> +		cm_id = cep->listen_cep->cm_id;
> +
> +		event.ird = cep->dev->attrs.max_ird;
> +		event.ord = cep->dev->attrs.max_ord;
> +	} else {
> +		cm_id = cep->cm_id;
> +	}
> +
> +	if (reason == IW_CM_EVENT_CONNECT_REQUEST ||
> +	    reason == IW_CM_EVENT_CONNECT_REPLY) {
> +		u16 pd_len = be16_to_cpu(cep->mpa.hdr.params.pd_len);
> +
> +		if (pd_len) {
> +			event.private_data_len = pd_len;
> +			event.private_data = cep->mpa.pdata;
> +			if (cep->mpa.pdata == NULL)
> +				event.private_data_len = 0;
> +		}

Using an if-else to assign a value to event.private_data_len
may make the code clearer.

<...>
> +static int erdma_proc_mpareq(struct erdma_cep *cep)
> +{
> +	struct mpa_rr *req;
> +	int ret;
> +
> +	ret = erdma_recv_mpa_rr(cep);
> +	if (ret)
> +		return ret;
> +
> +	req = &cep->mpa.hdr;
> +
> +	if (memcmp(req->key, MPA_KEY_REQ, MPA_KEY_SIZE))
> +		return -EPROTO;
> +
> +	memcpy(req->key, MPA_KEY_REP, 16);

Are "16" and "MPA_KEY_SIZE" equivalent?

<...>
> +static int erdma_proc_mpareply(struct erdma_cep *cep)
> +{
> +	struct erdma_qp_attrs qp_attrs;
> +	struct erdma_qp *qp = cep->qp;
> +	struct mpa_rr *rep;
> +	int ret;
> +
> +	ret = erdma_recv_mpa_rr(cep);
> +	if (ret != -EAGAIN)
> +		erdma_cancel_mpatimer(cep);
> +	if (ret)
> +		goto out_err;
> +
> +	rep = &cep->mpa.hdr;
> +
> +	if (memcmp(rep->key, MPA_KEY_REP, MPA_KEY_SIZE)) {
> +		ret = -EPROTO;
> +		goto out_err;
> +	}

Missing a blank line.

> +	if (rep->params.bits & MPA_RR_FLAG_REJECT) {
> +		erdma_cm_upcall(cep, IW_CM_EVENT_CONNECT_REPLY, -ECONNRESET);
> +		return -ECONNRESET;
> +	}
<...>
> +		if (cep->qp) {
> +			struct erdma_qp *qp = cep->qp;
> +			/*
> +			 * Serialize a potential race with application
> +			 * closing the QP and calling erdma_qp_cm_drop()
> +			 */
> +			erdma_qp_get(qp);
> +			erdma_cep_set_free(cep);
> +
> +			erdma_qp_llp_close(qp);
> +			erdma_qp_put(qp);
> +
> +			erdma_cep_set_inuse(cep);
> +			cep->qp = NULL;
> +			erdma_qp_put(qp);
> +		}

Missing a blank line.

> +		if (cep->sock) {
> +			erdma_socket_disassoc(cep->sock);
> +			sock_release(cep->sock);
> +			cep->sock = NULL;
> +		}
> +
<...>
> +static void erdma_cm_llp_data_ready(struct sock *sk)
> +{
> +	struct erdma_cep *cep;
> +
> +	read_lock(&sk->sk_callback_lock);
> +
> +	cep = sk_to_cep(sk);
> +	if (!cep)
> +		goto out;
> +
> +	switch (cep->state) {
> +	case ERDMA_EPSTATE_RDMA_MODE:
> +	case ERDMA_EPSTATE_LISTENING:
> +		break;
> +	case ERDMA_EPSTATE_AWAIT_MPAREQ:
> +	case ERDMA_EPSTATE_AWAIT_MPAREP:
> +		erdma_cm_queue_work(cep, ERDMA_CM_WORK_READ_MPAHDR);
> +		break;
> +	default:
> +		break;
> +	}

Use if instead of switch-case to reduce code complexity.

if (cep->state == ERDMA_EPSTATE_AWAIT_MPAREQ ||
    cep->state == ERDMA_EPSTATE_AWAIT_MPAREP ||)
	erdma_cm_queue_work(cep, ERDMA_CM_WORK_READ_MPAHDR);

<...>
> +	if (cep->cm_id) {
> +		cep->cm_id->rem_ref(id);
> +		cep->cm_id = NULL;
> +	}

Missing a blank line.

Thanks,
Wenpeng

> +	if (qp->cep) {
> +		erdma_cep_put(cep);
> +		qp->cep = NULL;
> +	}
> +

