Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919634933DA
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jan 2022 04:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351325AbiASD6R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jan 2022 22:58:17 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:57348 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344750AbiASD6R (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Jan 2022 22:58:17 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V2F8mvx_1642564694;
Received: from 30.43.72.229(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V2F8mvx_1642564694)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 19 Jan 2022 11:58:15 +0800
Message-ID: <9f8ab769-271e-32da-1357-7b316d34dc93@linux.alibaba.com>
Date:   Wed, 19 Jan 2022 11:58:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH rdma-next v2 08/11] RDMA/erdma: Add connection management
 (CM) support
Content-Language: en-US
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>
Cc:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "KaiShen@linux.alibaba.com" <KaiShen@linux.alibaba.com>,
        "tonylu@linux.alibaba.com" <tonylu@linux.alibaba.com>
References: <BYAPR15MB26310055D86455FC7088EDB699589@BYAPR15MB2631.namprd15.prod.outlook.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <BYAPR15MB26310055D86455FC7088EDB699589@BYAPR15MB2631.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 1/18/22 10:49 PM, Bernard Metzler wrote:
> 

<...>

>> +		cm_id = cep->listen_cep->cm_id;
>> +
>> +		event.ird = cep->dev->attrs.max_ird;
>> +		event.ord = cep->dev->attrs.max_ord;
> 
> Provide to the user also the negotiated  IRD/ORD of the
> reply. Things may have changed upon peer's request.
> See current siw code for the details.
> 

IRD/ORD in ERDMA hardware is fixed, no need to negotiate them in MPA
request/reply now. For this reason, we didn't follow siw with MPA v2.

>> +	} else {
>> +		cm_id = cep->cm_id;
>> +	}
>> +
>> +	if (reason == IW_CM_EVENT_CONNECT_REQUEST ||
>> +	    reason == IW_CM_EVENT_CONNECT_REPLY) {
>> +		u16 pd_len = be16_to_cpu(cep->mpa.hdr.params.pd_len);
>> +
> 
> Does erdma support MPA protocol version 2, and enhanced connection
> setup protocol? In that case, some private data contain protocol
> information and must be hidden to the user.
> 

Now we follow MPA v1. And due to specially network environment in Cloud
VPC, we extend the MPA v1: We exchange information with a extend header,
which followed with original MPA v1 header.

>> +		if (pd_len) {
>> +			event.private_data_len = pd_len;
>> +			event.private_data = cep->mpa.pdata;
>> +			if (cep->mpa.pdata == NULL)
>> +				event.private_data_len = 0;
>> +		}
>> +
>> +		getname_local(cep->sock, &event.local_addr);
>> +		getname_peer(cep->sock, &event.remote_addr);
>> +	}
>> +

<...>

>> +				     &rcvd);
>> +		cep->mpa.bytes_rcvd += rcvd;
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	pd_len = be16_to_cpu(hdr->params.pd_len);
>> +	pd_rcvd = cep->mpa.bytes_rcvd - sizeof(struct mpa_rr) -
>> sizeof(struct erdma_mpa_ext);
>> +	to_rcv = pd_len - pd_rcvd;
>> +
>> +	if (!to_rcv) {
> 
> Maybe add a comment why this logic gets executed here. I assume
> it checks if the peer sent more than the MPA + private data length
> within the MPA handshake, which is not allowed.
> 

OK, will add.

>> +		u32 word;
>> +
>> +		ret = __recv_mpa_hdr(cep, 0, (char *)&word, sizeof(word),
>> &rcvd);
>> +		if (ret == -EAGAIN && rcvd == 0)
>> +			return 0;
>> +
>> +		if (ret)
>> +			return ret;
>> +
>> +		return -EPROTO;
>> +	}
>> +
>> +	if (!cep->mpa.pdata) {
>> +		cep->mpa.pdata = kmalloc(pd_len + 4, GFP_KERNEL);
>> +		if (!cep->mpa.pdata)
>> +			return -ENOMEM;
>> +	}
>> +
>> +	rcvd = ksock_recv(s, cep->mpa.pdata + pd_rcvd, to_rcv + 4,
>> MSG_DONTWAIT);
>> +	if (rcvd < 0)
>> +		return rcvd;
>> +
>> +	if (rcvd > to_rcv)
>> +		return -EPROTO;
>> +
>> +	cep->mpa.bytes_rcvd += rcvd;
>> +
>> +	if (to_rcv == rcvd)
>> +		return 0;
>> +
>> +	return -EAGAIN;
>> +}
>> +
>> +/*
>> + * erdma_proc_mpareq()
>> + *
>> + * Read MPA Request from socket and signal new connection to IWCM
>> + * if success. Caller must hold lock on corresponding listening CEP.
>> + */
>> +static int erdma_proc_mpareq(struct erdma_cep *cep)
>> +{
>> +	struct mpa_rr *req;
>> +	int ret;
>> +
>> +	ret = erdma_recv_mpa_rr(cep);
>> +	if (ret)
>> +		return ret;
>> +
>> +	req = &cep->mpa.hdr;
>> +
>> +	if (__mpa_rr_revision(req->params.bits) != MPA_REVISION_EXT_1)
>> +		return -EPROTO;
>> +
>> +	if (memcmp(req->key, MPA_KEY_REQ, MPA_KEY_SIZE))
>> +		return -EPROTO;
>> +
>> +	memcpy(req->key, MPA_KEY_REP, 16);
>> +
>> +	if (req->params.bits & MPA_RR_FLAG_MARKERS)
>> +		goto reject_conn;
>> +
>> +	if (req->params.bits & MPA_RR_FLAG_CRC) {
>> +		if (!mpa_crc_required && mpa_crc_strict)
>> +			goto reject_conn;
>> +
>> +		if (mpa_crc_required)
>> +			req->params.bits |= MPA_RR_FLAG_CRC;
>> +	}
>> +
>> +	cep->state = ERDMA_EPSTATE_RECVD_MPAREQ;
>> +
>> +	/* Keep reference until IWCM accepts/rejects */
>> +	erdma_cep_get(cep);
>> +	ret = erdma_cm_upcall(cep, IW_CM_EVENT_CONNECT_REQUEST, 0);
>> +	if (ret)
>> +		erdma_cep_put(cep);
>> +
>> +	return ret;
>> +
>> +reject_conn:
>> +	req->params.bits &= ~MPA_RR_FLAG_MARKERS;
>> +	req->params.bits |= MPA_RR_FLAG_REJECT;
>> +
>> +	if (!mpa_crc_required && mpa_crc_strict)
>> +		req->params.bits &= ~MPA_RR_FLAG_CRC;
>> +
>> +	kfree(cep->mpa.pdata);
>> +	cep->mpa.pdata = NULL;
>> +	erdma_send_mpareqrep(cep, NULL, 0);
>> +
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static int erdma_proc_mpareply(struct erdma_cep *cep)
>> +{
>> +	struct erdma_qp_attrs qp_attrs;
>> +	struct erdma_qp *qp = cep->qp;
>> +	struct mpa_rr *rep;
>> +	int ret;
>> +
>> +	ret = erdma_recv_mpa_rr(cep);
>> +	if (ret != -EAGAIN)
>> +		erdma_cancel_mpatimer(cep);
>> +	if (ret)
>> +		goto out_err;
>> +
>> +	rep = &cep->mpa.hdr;
>> +
>> +	if (__mpa_rr_revision(rep->params.bits) != MPA_REVISION_EXT_1) {
>> +		ret = -EPROTO;
>> +		goto out_err;
>> +	}
>> +	if (memcmp(rep->key, MPA_KEY_REP, MPA_KEY_SIZE)) {
>> +		ret = -EPROTO;
>> +		goto out_err;
>> +	}
>> +	if (rep->params.bits & MPA_RR_FLAG_REJECT) {
>> +		erdma_cm_upcall(cep, IW_CM_EVENT_CONNECT_REPLY, -ECONNRESET);
>> +		return -ECONNRESET;
>> +	}
>> +
>> +	if ((rep->params.bits & MPA_RR_FLAG_MARKERS) ||
>> +	    (mpa_crc_required && !(rep->params.bits & MPA_RR_FLAG_CRC)) ||
>> +	    (mpa_crc_strict && !mpa_crc_required && (rep->params.bits &
>> MPA_RR_FLAG_CRC))) {
>> +		erdma_cm_upcall(cep, IW_CM_EVENT_CONNECT_REPLY, -
>> ECONNREFUSED);
>> +		return -EINVAL;
>> +	}
>> +
>> +	memset(&qp_attrs, 0, sizeof(qp_attrs));
>> +	qp_attrs.irq_size = cep->ird;
>> +	qp_attrs.orq_size = cep->ord;
>> +	qp_attrs.state = ERDMA_QP_STATE_RTS;
>> +
>> +	down_write(&qp->state_lock);
>> +	if (qp->attrs.state > ERDMA_QP_STATE_RTR) {
>> +		ret = -EINVAL;
>> +		up_write(&qp->state_lock);
>> +		goto out_err;
>> +	}
>> +
>> +	qp->qp_type = ERDMA_QP_ACTIVE;
>> +	qp->cc_method = __mpa_ext_cc(cep->mpa.ext_data.bits) == qp->dev-
>>> cc_method ?
>> +		qp->dev->cc_method : COMPROMISE_CC;
>> +	ret = erdma_modify_qp_internal(qp, &qp_attrs,
>> +				       ERDMA_QP_ATTR_STATE |
>> +				       ERDMA_QP_ATTR_LLP_HANDLE |
>> +				       ERDMA_QP_ATTR_MPA);
>> +
>> +	up_write(&qp->state_lock);
>> +
>> +	if (!ret) {
>> +		ret = erdma_cm_upcall(cep, IW_CM_EVENT_CONNECT_REPLY, 0);
>> +		if (!ret)
>> +			cep->state = ERDMA_EPSTATE_RDMA_MODE;
>> +
>> +		return 0;
>> +	}
>> +
>> +out_err:
>> +	erdma_cm_upcall(cep, IW_CM_EVENT_CONNECT_REPLY, -EINVAL);
>> +	return ret;
>> +}
>> +
>> +static void erdma_accept_newconn(struct erdma_cep *cep)
>> +{
>> +	struct socket *s = cep->sock;
>> +	struct socket *new_s = NULL;
>> +	struct erdma_cep *new_cep = NULL;
>> +	int ret = 0;
>> +
>> +	if (cep->state != ERDMA_EPSTATE_LISTENING)
>> +		goto error;
>> +
>> +	new_cep = erdma_cep_alloc(cep->dev);
>> +	if (!new_cep)
>> +		goto error;
>> +
>> +	if (erdma_cm_alloc_work(new_cep, 6) != 0)
> 
> Why '6'? Please add a comment.
> 


OK.

Because, we add two work type to support non-blocking iw_connect, so we 
change it from 4 -> 6.

>> +		goto error;
>> +
>> +	/*
>> +	 * Copy saved socket callbacks from listening CEP
>> +	 * and assign new socket with new CEP
>> +	 */
>> +	new_cep->sk_state_change = cep->sk_state_change;
>> +	new_cep->sk_data_ready = cep->sk_data_ready;
>> +	new_cep->sk_error_report = cep->sk_error_report;

<...>

>> +	erdma_cep_set_free(cep);
>> +	return 0;
>> +
>> +error_disasssoc:
> 
> better 'error_disassoc'?
> 

Wrong spell, will fix.

>> +	kfree(cep->private_storage);
>> +	cep->private_storage = NULL;
>> +	cep->pd_len = 0;
>> +
>> +	erdma_socket_disassoc(s);

<...>

>> +struct erdma_cep {
>> +	struct iw_cm_id *cm_id;
>> +	struct erdma_dev *dev;
>> +	struct list_head devq;
>> +	spinlock_t lock;
>> +	struct kref ref;
>> +	int in_use;
>> +	wait_queue_head_t waitq;
>> +	enum erdma_cep_state state;
>> +
>> +	struct list_head listenq;
>> +	struct erdma_cep *listen_cep;
>> +
>> +	struct erdma_qp *qp;
>> +	struct socket *sock;
>> +
>> +	struct erdma_cm_work *mpa_timer;
>> +	struct list_head work_freelist;
>> +
>> +	struct erdma_mpa_info mpa;
>> +	int ord;
>> +	int ird;
>> +	int pd_len;
>> +	void *private_storage;
> 
> Maybe private_data or pdata would be a better name,
> since it holds users private data.
> 

It's better, will change.

Thanks,
Cheng Xu
