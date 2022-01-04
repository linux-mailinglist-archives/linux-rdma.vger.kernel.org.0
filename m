Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5795483C12
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jan 2022 07:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbiADGwu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jan 2022 01:52:50 -0500
Received: from out0.migadu.com ([94.23.1.103]:19656 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233043AbiADGwt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Jan 2022 01:52:49 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1641279168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C/vs2/kpUCSa19VMN4BSkGDf+cLA7qeHaue2fPAiblQ=;
        b=DtVm7W6jlm9rH5Hb26lk6sLoeTuki0lAIgxNU8BYHpy3A/0UAburgqzq8/azXhKUOZZQlr
        4dKjpph3J2ah1nnPk6eCIl0bleGhyU0HFnjvh8f0H0RnuZfQuZFE9lCZ9YdGeTkJphUGXh
        c4PzPcP1uis3CPIWbPvsDjpg+oj41n0=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCHv2 for-next 3/5] RDMA/rtrs-clt: Rename rtrs_clt_sess to
 rtrs_clt_path
To:     Jack Wang <jinpu.wang@ionos.com>, linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com,
        Vaishali Thakkar <vaishali.thakkar@ionos.com>
References: <20220103133339.9483-1-jinpu.wang@ionos.com>
 <20220103133339.9483-4-jinpu.wang@ionos.com>
Message-ID: <0bf78ddd-b8b6-3a00-4a5a-1f499703a72a@linux.dev>
Date:   Tue, 4 Jan 2022 14:52:35 +0800
MIME-Version: 1.0
In-Reply-To: <20220103133339.9483-4-jinpu.wang@ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 1/3/22 9:33 PM, Jack Wang wrote:

[ .. ]

> -static int post_recv_sess(struct rtrs_clt_sess *sess)
> +static int post_recv_path(struct rtrs_clt_path *clt_path)

How about rename it to post_recv_clt_path to make it obviously if you
has the same change to post_recv_sess in rtrs-srv.c?

[ ... ]

> @@ -1378,13 +1383,14 @@ static int alloc_sess_reqs(struct rtrs_clt_sess *sess)
>   		if (!req->sge)
>   			goto out;
>   
> -		req->mr = ib_alloc_mr(sess->s.dev->ib_pd, IB_MR_TYPE_MEM_REG,
> -				      sess->max_pages_per_mr);
> +		req->mr = ib_alloc_mr(clt_path->s.dev->ib_pd,
> +				      IB_MR_TYPE_MEM_REG,
> +				      clt_path->max_pages_per_mr);
>   		if (IS_ERR(req->mr)) {
>   			err = PTR_ERR(req->mr);
>   			req->mr = NULL;
>   			pr_err("Failed to alloc sess->max_pages_per_mr %d\n",

s/sess/clt_path/

> -			       sess->max_pages_per_mr);
> +			       clt_path->max_pages_per_mr);
>   			goto out;
>   		}
>   

[ ... ]

> -static int create_con(struct rtrs_clt_sess *sess, unsigned int cid)
> +static int create_con(struct rtrs_clt_path *clt_path, unsigned int cid)

Could you rename it to create_clt_con? Because the function name appears
in both client and server.

>   {
>   	struct rtrs_clt_con *con;
>   
> @@ -1601,28 +1609,28 @@ static int create_con(struct rtrs_clt_sess *sess, unsigned int cid)
>   	/* Map first two connections to the first CPU */
>   	con->cpu  = (cid ? cid - 1 : 0) % nr_cpu_ids;
>   	con->c.cid = cid;
> -	con->c.path = &sess->s;
> +	con->c.path = &clt_path->s;
>   	/* Align with srv, init as 1 */
>   	atomic_set(&con->c.wr_cnt, 1);
>   	mutex_init(&con->con_mutex);
>   
> -	sess->s.con[cid] = &con->c;
> +	clt_path->s.con[cid] = &con->c;
>   
>   	return 0;
>   }
>   

[ ... ]

> -static inline bool xchg_sessions(struct rtrs_clt_sess __rcu **rcu_ppcpu_path,
> -				 struct rtrs_clt_sess *sess,
> -				 struct rtrs_clt_sess *next)
> +static inline bool xchg_sessions(struct rtrs_clt_path __rcu **rcu_ppcpu_path,
> +				 struct rtrs_clt_path *clt_path,
> +				 struct rtrs_clt_path *next)

Now, it is used to exchange paths instead of sessions, right?

>   {
> -	struct rtrs_clt_sess **ppcpu_path;
> +	struct rtrs_clt_path **ppcpu_path;
>   
>   	/* Call cmpxchg() without sparse warnings */
>   	ppcpu_path = (typeof(ppcpu_path))rcu_ppcpu_path;
> -	return sess == cmpxchg(ppcpu_path, sess, next);
> +	return clt_path == cmpxchg(ppcpu_path, clt_path, next);
>   }

[ ... ]

> @@ -2375,31 +2387,32 @@ static int init_conns(struct rtrs_clt_sess *sess)
>   static void rtrs_clt_info_req_done(struct ib_cq *cq, struct ib_wc *wc)
>   {
>   	struct rtrs_clt_con *con = to_clt_con(wc->qp->qp_context);
> -	struct rtrs_clt_sess *sess = to_clt_sess(con->c.path);
> +	struct rtrs_clt_path *clt_path = to_clt_path(con->c.path);
>   	struct rtrs_iu *iu;
>   
>   	iu = container_of(wc->wr_cqe, struct rtrs_iu, cqe);
> -	rtrs_iu_free(iu, sess->s.dev->ib_dev, 1);
> +	rtrs_iu_free(iu, clt_path->s.dev->ib_dev, 1);
>   
>   	if (wc->status != IB_WC_SUCCESS) {
> -		rtrs_err(sess->clt, "Sess info request send failed: %s\n",
> +		rtrs_err(clt_path->clt, "*Sess*  info request send failed: %s\n",

Path info, same as below.

[ ... ]

>   	if (wc->status != IB_WC_SUCCESS) {
> -		rtrs_err(sess->clt, "Sess info response recv failed: %s\n",
> +		rtrs_err(clt_path->clt, "Path info response recv failed: %s\n",
>   			  ib_wc_status_msg(wc->status));
>   		goto out;
>   	}
>   	WARN_ON(wc->opcode != IB_WC_RECV);
>   
>   	if (wc->byte_len < sizeof(*msg)) {
> -		rtrs_err(sess->clt, "Sess info response is malformed: size %d\n",
> +		rtrs_err(clt_path->clt, "Path info response is malformed: size %d\n",
>   			  wc->byte_len);
>   		goto out;
>   	}

[ ... ]

> @@ -2533,33 +2548,34 @@ static int rtrs_send_sess_info(struct rtrs_clt_sess *sess)
>   	/* Prepare for getting info response */
>   	err = rtrs_iu_post_recv(&usr_con->c, rx_iu);
>   	if (err) {
> -		rtrs_err(sess->clt, "rtrs_iu_post_recv(), err: %d\n", err);
> +		rtrs_err(clt_path->clt, "rtrs_iu_post_recv(), err: %d\n", err);
>   		goto out;
>   	}
>   	rx_iu = NULL;
>   
>   	msg = tx_iu->buf;
>   	msg->type = cpu_to_le16(RTRS_MSG_INFO_REQ);
> -	memcpy(msg->sessname, sess->s.sessname, sizeof(msg->sessname));
> +	memcpy(msg->sessname, clt_path->s.sessname, sizeof(msg->sessname));

Pls check if it is pathname.

[ ... ]


>   /**
> - * init_sess() - establishes all session connections and does handshake
> - * @sess: client session.
> + * init_pathi() - establishes all path connections and does handshake

s/init_pathi/init_path, maybe it would be better to call it 
init_clt_path here.

> + * @clt_path: client path.
>    * In case of error full close or reconnect procedure should be taken,
>    * because reconnect or close async works can be started.
>    */
> -static int init_sess(struct rtrs_clt_sess *sess)
> +static int init_path(struct rtrs_clt_path *clt_path)

[ ... ]

> -	if (sess->reconnect_attempts >= clt->max_reconnect_attempts) {
> +	if (clt_path->reconnect_attempts >= clt->max_reconnect_attempts) {
>   		/* Close a*session*  completely if max attempts is reached */

I guess it is close a path now.

> -		rtrs_clt_close_conns(sess, false);
> +		rtrs_clt_close_conns(clt_path, false);
>   		return;
>   	}

[ ... ]

Thanks,
Guoqing
