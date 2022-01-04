Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24870483C10
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jan 2022 07:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbiADGu6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jan 2022 01:50:58 -0500
Received: from out2.migadu.com ([188.165.223.204]:32598 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233043AbiADGu6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Jan 2022 01:50:58 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1641279056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RzVgYGKIVPBoj0bOJ5At56kYRQ8EZM8yC9PKOOtjECU=;
        b=dW7ITugLYZ4rvpZFsIEayxgehiMUMsxRMglfLl81wDItM32J1Y29uxx1bsxNIOtmAykYjR
        zIfkEMAuCHTTf+dkiAAHh02N+kipwC9VCWCpENn27CgqnRQrQHzNxWJ+EQtrCdntyN/ULJ
        cXLCDXQtzaJssimFJegCuH2YbpCriO8=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCHv2 for-next 2/5] RDMA/rtrs-srv: Rename rtrs_srv_sess to
 rtrs_srv_path
To:     Jack Wang <jinpu.wang@ionos.com>, linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com,
        Vaishali Thakkar <vaishali.thakkar@ionos.com>
References: <20220103133339.9483-1-jinpu.wang@ionos.com>
 <20220103133339.9483-3-jinpu.wang@ionos.com>
Message-ID: <a80f9ee4-051b-e3dd-8f1f-e087987407d8@linux.dev>
Date:   Tue, 4 Jan 2022 14:50:49 +0800
MIME-Version: 1.0
In-Reply-To: <20220103133339.9483-3-jinpu.wang@ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 1/3/22 9:33 PM, Jack Wang wrote:

> --- a/drivers/block/rnbd/rnbd-srv.c
> +++ b/drivers/block/rnbd/rnbd-srv.c
> @@ -269,9 +269,9 @@ static int create_sess(struct rtrs_srv *rtrs)
>   	char sessname[NAME_MAX];

It is pathname with the change.

>   	int err;
>   
> -	err = rtrs_srv_get_sess_name(rtrs, sessname, sizeof(sessname));
> +	err = rtrs_srv_get_path_name(rtrs, sessname, sizeof(sessname));
>   	if (err) {
> -		pr_err("rtrs_srv_get_sess_name(%s): %d\n", sessname, err);
> +		pr_err("rtrs_srv_get_path_name(%s): %d\n", sessname, err);
>   
>   		return err;
>   	}

[ ... ]

> -void close_sess(struct rtrs_srv_sess *sess)
> +void close_path(struct rtrs_srv_path *srv_path)

I guess close_srv_path is better if it has counterpart in rtrs-clt.c.

[ ... ]

>   		rtrs_err_rl(s,
>   			    "Sending I/O response failed,  session %s is disconnected, sess state %s\n",

With the change, the above should print path instead of session.

> -			    kobject_name(&sess->kobj),
> -			    rtrs_srv_state_str(sess->state));
> +			    kobject_name(&srv_path->kobj),
> +			    rtrs_srv_state_str(srv_path->state));
>   		goto out;
>   	}
>   	if (always_invalidate) {
> -		struct rtrs_srv_mr *mr = &sess->mrs[id->msg_id];
> +		struct rtrs_srv_mr *mr = &srv_path->mrs[id->msg_id];
>   
>   		ib_update_fast_reg_key(mr->mr, ib_inc_rkey(mr->mr->rkey));
>   	}
>   	if (atomic_sub_return(1, &con->c.sq_wr_avail) < 0) {
>   		rtrs_err(s, "IB send queue full:*sess*=%s cid=%d\n",
> -			 kobject_name(&sess->kobj),
> +			 kobject_name(&srv_path->kobj),

Ditto.

>   			 con->c.cid);
>   		atomic_add(1, &con->c.sq_wr_avail);
>   		spin_lock(&con->rsp_wr_wait_lock);
> @@ -524,11 +527,11 @@ bool rtrs_srv_resp_rdma(struct rtrs_srv_op *id, int status)
>   
>   	if (err) {
>   		rtrs_err_rl(s, "IO response failed: %d:*sess*=%s\n", err,
> -			    kobject_name(&sess->kobj));
> -		close_sess(sess);
> +			    kobject_name(&srv_path->kobj));
> +		close_path(srv_path);

Ditto.

[ ... ]

> @@ -754,7 +757,7 @@ static bool exist_sessname(struct rtrs_srv_ctx *ctx,
>   			   const char *sessname, const uuid_t *path_uuid)
>   {
>   	struct rtrs_srv *srv;
> -	struct rtrs_srv_sess *sess;
> +	struct rtrs_srv_path *srv_path;
>   	bool found = false;
>   
>   	mutex_lock(&ctx->srv_mutex);
> @@ -767,9 +770,9 @@ static bool exist_sessname(struct rtrs_srv_ctx *ctx,
>   			continue;
>   		}
>   
> -		list_for_each_entry(sess, &srv->paths_list, s.entry) {
> -			if (strlen(sess->s.sessname) == strlen(sessname) &&
> -			    !strcmp(sess->s.sessname, sessname)) {
> +		list_for_each_entry(srv_path, &srv->paths_list, s.entry) {
> +			if (strlen(srv_path->s.sessname) == strlen(sessname) &&
> +			    !strcmp(srv_path->s.sessname, sessname)) {

I am wondering if the sessname should be replaced with pathname, pls 
double check.
Does it make sense to add the definitions about "path" and "session" 
somewhere such
as in README?

[ ... ]

>   
> -static int post_recv_sess(struct rtrs_srv_sess *sess)
> +static int post_recv_sess(struct rtrs_srv_path *srv_path)

post_recv_path?

>   {
> -	struct rtrs_srv *srv = sess->srv;
> -	struct rtrs_path *s = &sess->s;
> +	struct rtrs_srv *srv = srv_path->srv;
> +	struct rtrs_path *s = &srv_path->s;
>   	size_t q_size;
>   	int err, cid;
>   
> -	for (cid = 0; cid < sess->s.con_num; cid++) {
> +	for (cid = 0; cid < srv_path->s.con_num; cid++) {
>   		if (cid == 0)
>   			q_size = SERVICE_CON_QUEUE_DEPTH;
>   		else
>   			q_size = srv->queue_depth;
>   
> -		err = post_recv_io(to_srv_con(sess->s.con[cid]), q_size);
> +		err = post_recv_io(to_srv_con(srv_path->s.con[cid]), q_size);
>   		if (err) {
>   			rtrs_err(s, "post_recv_io(), err: %d\n", err);
>   			return err;

[ .. ]

>   /**
> - * rtrs_srv_get_sess_name() - Get rtrs_srv peer hostname.
> + * rtrs_srv_get_path_name() - Get rtrs_srv peer hostname.
>    * @srv:	Session
>    * @sessname:	Sessname buffer
>    * @len:	Length of sessname buffer
>    */
> -int rtrs_srv_get_sess_name(struct rtrs_srv *srv, char *sessname, size_t len)
> +int rtrs_srv_get_path_name(struct rtrs_srv *srv, char *sessname, size_t len)

The "sessname" argument is actually for path, right?

>   {
> -	struct rtrs_srv_sess *sess;
> +	struct rtrs_srv_path *srv_path;
>   	int err = -ENOTCONN;
>   
>   	mutex_lock(&srv->paths_mutex);
> -	list_for_each_entry(sess, &srv->paths_list, s.entry) {
> -		if (sess->state != RTRS_SRV_CONNECTED)
> +	list_for_each_entry(srv_path, &srv->paths_list, s.entry) {
> +		if (srv_path->state != RTRS_SRV_CONNECTED)
>   			continue;
> -		strscpy(sessname, sess->s.sessname,
> -		       min_t(size_t, sizeof(sess->s.sessname), len));
> +		strscpy(sessname, srv_path->s.sessname,
> +			min_t(size_t, sizeof(srv_path->s.sessname), len));
>   		err = 0;
>   		break;
>   	}
> @@ -1307,7 +1313,7 @@ int rtrs_srv_get_sess_name(struct rtrs_srv *srv, char *sessname, size_t len)
>   
>   	return err;
>   }
> -EXPORT_SYMBOL(rtrs_srv_get_sess_name);
> +EXPORT_SYMBOL(rtrs_srv_get_path_name);

[ ... ]

Thanks,
Guoqing

