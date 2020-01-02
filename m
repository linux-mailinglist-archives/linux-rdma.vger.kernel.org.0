Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 409A012EBA1
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jan 2020 23:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgABWDX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jan 2020 17:03:23 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43415 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgABWDX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Jan 2020 17:03:23 -0500
Received: by mail-pl1-f196.google.com with SMTP id p27so18314866pli.10;
        Thu, 02 Jan 2020 14:03:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kz3Q4nY7tDz0dXtvQqDZBIa/vT2VSoxfQCPK0m28+2w=;
        b=mpVhVjsy5cK8zjhiab8HzhdAJC5zXYb45Yj4W/zsIUEiC6zE564oIOGWY9Jtu+6F4Q
         95jSXoISAkJPaHdFPOOGrgfgp0nlNgssLo1qRf7veo9IQWE28K1oSXxVfmQwYXBwPDSy
         hJ2ck92739DQ7mrRcj/ESDDpUXhxxapS39vIm7kWBxH9e7/PUIuYTxFHj+S4nC/VpkU3
         Mq2pApHjl1M7NPrTAA9f1BfnVnDCPTAlF64T+GMPl1BEzOymy5mqaEUd7kS6vhojXzXg
         5ez1mxFGkV7DFsfRw16TOnhJCG9UyICL59w9CT0hHkh3jRJhJ/3xzUCSi29F6vbKFugR
         atiw==
X-Gm-Message-State: APjAAAVVGydbr7cTz8aQQcveaBTdBKQDIUrQUGg7RKkOv9sEDTtU1ljP
        cLQSzRmXfdOvmSODTeLcwy0=
X-Google-Smtp-Source: APXvYqxI+D8idjq+HD6U4nP0Wy+WRCxxUvpZYjA8fulSYVMPOGBO5Jxr0p2vQmigzgnsU1LCkaH8NQ==
X-Received: by 2002:a17:90b:30d7:: with SMTP id hi23mr23041571pjb.5.1578002602930;
        Thu, 02 Jan 2020 14:03:22 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id h3sm18731729pfo.132.2020.01.02.14.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2020 14:03:22 -0800 (PST)
Subject: Re: [PATCH v6 10/25] rtrs: server: main functionality
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de
References: <20191230102942.18395-1-jinpuwang@gmail.com>
 <20191230102942.18395-11-jinpuwang@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <3fa42a11-5a85-f585-fed8-e8a2c0d7a249@acm.org>
Date:   Thu, 2 Jan 2020 14:03:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191230102942.18395-11-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/30/19 2:29 AM, Jack Wang wrote:
> +MODULE_DESCRIPTION("RTRS Server");

Please expand the "RTRS" abbreviation in the module description.

> +static void rtrs_srv_get_ops_ids(struct rtrs_srv_sess *sess)
> +{
> +	atomic_inc(&sess->ids_inflight);
> +}
> +
> +static void rtrs_srv_put_ops_ids(struct rtrs_srv_sess *sess)
> +{
> +	if (atomic_dec_and_test(&sess->ids_inflight))
> +		wake_up(&sess->ids_waitq);
> +}
> +
> +static void rtrs_srv_wait_ops_ids(struct rtrs_srv_sess *sess)
> +{
> +	wait_event(sess->ids_waitq, !atomic_read(&sess->ids_inflight));
> +}

So rtrs_srv_wait_ops_ids() returns without grabbing any synchronization 
object? What guarantees that ids_inflight is not increased after 
wait_event() has returned and before rtrs_srv_wait_ops_ids() returns?

> +	/*
> +	 * From time to time we have to post signalled sends,
> +	 * or send queue will fill up and only QP reset can help.
> +	 */
> +	flags = atomic_inc_return(&id->con->wr_cnt) % srv->queue_depth ?
> +			0 : IB_SEND_SIGNALED;

Should "signalled" perhaps be changed into "signaled"?

How can posting a signaled send prevent that the send queue overflows? 
Isn't that something that can only be guaranteed by tracking the number 
of WQE's in the send queue?

> +/**
> + * send_io_resp_imm() - response with empty IMM on failed READ/WRITE requests or
> + *                      on successful WRITE request.
> + * @con		the connection to send back result
> + * @id		the id associated to io
> + * @errno	the error number of the IO.
> + *
> + * Return 0 on success, errno otherwise.
> + */

Should "response ... on" perhaps be changed into "respond ... to"? 
Should "associated to" perhaps be changed into "associated with"?

> +static int map_cont_bufs(struct rtrs_srv_sess *sess)

A comment that explains what "cont" in this function name means would be 
welcome.

> +static inline int sockaddr_cmp(const struct sockaddr *a,
> +			       const struct sockaddr *b)
> +{
> +	switch (a->sa_family) {
> +	case AF_IB:
> +		return memcmp(&((struct sockaddr_ib *)a)->sib_addr,
> +			      &((struct sockaddr_ib *)b)->sib_addr,
> +			      sizeof(struct ib_addr));
> +	case AF_INET:
> +		return memcmp(&((struct sockaddr_in *)a)->sin_addr,
> +			      &((struct sockaddr_in *)b)->sin_addr,
> +			      sizeof(struct in_addr));
> +	case AF_INET6:
> +		return memcmp(&((struct sockaddr_in6 *)a)->sin6_addr,
> +			      &((struct sockaddr_in6 *)b)->sin6_addr,
> +			      sizeof(struct in6_addr));
> +	default:
> +		return -ENOENT;
> +	}
> +}

The memcmp() return value can be used to sort values. Since that is not 
the case for the sockaddr_cmp() return value, please document this. 
Additionally, it seems like a comparison of a->sa_family and 
b->sa_family is missing?

> +static int rtrs_rdma_do_accept(struct rtrs_srv_sess *sess,
> +				struct rdma_cm_id *cm_id)
> +{
> +	struct rtrs_srv *srv = sess->srv;
> +	struct rtrs_msg_conn_rsp msg;
> +	struct rdma_conn_param param;
> +	int err;
> +
> +	memset(&param, 0, sizeof(param));
> +	param.rnr_retry_count = 7;
> +	param.private_data = &msg;
> +	param.private_data_len = sizeof(msg);
> +
> +	memset(&msg, 0, sizeof(msg));
> +	msg.magic = cpu_to_le16(RTRS_MAGIC);
> +	msg.version = cpu_to_le16(RTRS_PROTO_VER);
> +	msg.errno = 0;
> +	msg.queue_depth = cpu_to_le16(srv->queue_depth);
> +	msg.max_io_size = cpu_to_le32(max_chunk_size - MAX_HDR_SIZE);
> +	msg.max_hdr_size = cpu_to_le32(MAX_HDR_SIZE);
> +
> +	if (always_invalidate)
> +		msg.flags = cpu_to_le32(RTRS_MSG_NEW_RKEY_F);
> +
> +	err = rdma_accept(cm_id, &param);
> +	if (err)
> +		pr_err("rdma_accept(), err: %d\n", err);
> +
> +	return err;
> +}

Please use a designated initializer list instead of memset() followed by 
initialization of multiple structure members.

> +static int rtrs_srv_rdma_init(struct rtrs_srv_ctx *ctx, unsigned int port)
> +{
> +	struct sockaddr_in6 sin = {
> +		.sin6_family	= AF_INET6,
> +		.sin6_addr	= IN6ADDR_ANY_INIT,
> +		.sin6_port	= htons(port),
> +	};
> +	struct sockaddr_ib sib = {
> +		.sib_family			= AF_IB,
> +		.sib_addr.sib_subnet_prefix	= 0ULL,
> +		.sib_addr.sib_interface_id	= 0ULL,
> +		.sib_sid	= cpu_to_be64(RDMA_IB_IP_PS_IB | port),
> +		.sib_sid_mask	= cpu_to_be64(0xffffffffffffffffULL),
> +		.sib_pkey	= cpu_to_be16(0xffff),
> +	};

A minor comment: structure members that are zero do not have to be 
initialized explicitly. The compiler does that automatically.

> +struct rtrs_srv_ctx *rtrs_srv_open(rdma_ev_fn *rdma_ev, link_ev_fn *link_ev,
> +				     unsigned int port)
> +{
> +	struct rtrs_srv_ctx *ctx;
> +	int err;
> +
> +	ctx = alloc_srv_ctx(rdma_ev, link_ev);
> +	if (unlikely(!ctx))
> +		return ERR_PTR(-ENOMEM);
> +
> +	err = rtrs_srv_rdma_init(ctx, port);
> +	if (unlikely(err)) {
> +		free_srv_ctx(ctx);
> +		return ERR_PTR(err);
> +	}
> +	/* Do not let module be unloaded if server context is alive */
> +	__module_get(THIS_MODULE);
> +
> +	return ctx;
> +}
> +EXPORT_SYMBOL(rtrs_srv_open);

Isn't it inconvenient for users if module unloading is prevented while 
one or more connections are active? This requires users to figure out 
how to trigger a log out if they want to unload a kernel module. 
Additionally, how are users expected to prevent that the client relogins 
after the server has told them to log out and before the server kernel 
module is unloaded?

Thanks,

Bart.
