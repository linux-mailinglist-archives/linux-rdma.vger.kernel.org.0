Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44ED6BBF15
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2019 01:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391195AbfIWXt7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Sep 2019 19:49:59 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46515 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729276AbfIWXt7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Sep 2019 19:49:59 -0400
Received: by mail-pg1-f195.google.com with SMTP id a3so36525pgm.13;
        Mon, 23 Sep 2019 16:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=302FuroD8y8OvcqP+8mZl8BRSarRV544xPnJHh41H7A=;
        b=W4zgBX4cDG3dQ1uwPwXf1sj+gRMls1AW2U0X8Ygq0E24teXlT+Yp4PJMcZ3toWdy2R
         ekQ29Lvim7IYUfhfRA922xRdMB+aW/P1Th5h4IJmkNZ5Uh0SzLkacIkRY8SYOJQjRhok
         mEjYtDIdSC+ex5JLfE7yPOJWisoVqmv3RvOhXLWCrdJH04nTH4qgzAFdaiYobpnxYEb1
         xfWh8SrnsEl5ExRjKIYrq1XDpUk/PbMt1/qLSUtdaeWbm0jlX8uLDelrAsaznnP1ctH0
         TfM6q71ui56O+qXnKXlOvsCSqKrzoFy82oCOCbuJXBFJBiO6YS8krdzDY6XeSrIWmRNR
         gYMw==
X-Gm-Message-State: APjAAAXGzZQmPmnTiqPIBzhjmWbVBUQJXt8xNL9IxKhVZ10owvwAkG4b
        syETq67Mn6Fc3JmBtgIwZtk=
X-Google-Smtp-Source: APXvYqz83RUW7lXd64Uy1Zj3bTxUK/B3TP/iMieEp5Vs1HubmBqaoXOs+f1mYEPRKwujLKJDSjqoOg==
X-Received: by 2002:a63:66c4:: with SMTP id a187mr92874pgc.85.1569282596551;
        Mon, 23 Sep 2019 16:49:56 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id r11sm23222842pgn.67.2019.09.23.16.49.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 16:49:55 -0700 (PDT)
Subject: Re: [PATCH v4 10/25] ibtrs: server: main functionality
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-11-jinpuwang@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <ab36427b-a737-9544-fbe8-cd53c0780994@acm.org>
Date:   Mon, 23 Sep 2019 16:49:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190620150337.7847-11-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/20/19 8:03 AM, Jack Wang wrote:
> +module_param_named(max_chunk_size, max_chunk_size, int, 0444);
> +MODULE_PARM_DESC(max_chunk_size,
> +		 "Max size for each IO request, when change the unit is in byte"
> +		 " (default: " __stringify(DEFAULT_MAX_CHUNK_SIZE_KB) "KB)");

Where can I find the definition of DEFAULT_MAX_CHUNK_SIZE_KB?

> +static char cq_affinity_list[256] = "";

No empty initializers for file-scope variables please.

> +	pr_info("cq_affinity_list changed to %*pbl\n",
> +		cpumask_pr_args(&cq_affinity_mask));

Should this pr_info() call perhaps be changed into pr_debug()?

> +static bool __ibtrs_srv_change_state(struct ibtrs_srv_sess *sess,
> +				     enum ibtrs_srv_state new_state)
> +{
> +	enum ibtrs_srv_state old_state;
> +	bool changed = false;
> +
> +	old_state = sess->state;
> +	switch (new_state) {

Please add a lockdep_assert_held() statement that checks whether calls 
of this function are serialized properly.

> +/**
> + * rdma_write_sg() - response on successful READ request
> + */
> +static int rdma_write_sg(struct ibtrs_srv_op *id)
> +{
> +	struct ibtrs_srv_sess *sess = to_srv_sess(id->con->c.sess);
> +	dma_addr_t dma_addr = sess->dma_addr[id->msg_id];
> +	struct ibtrs_srv *srv = sess->srv;
> +	struct ib_send_wr inv_wr, imm_wr;
> +	struct ib_rdma_wr *wr = NULL;
> +	const struct ib_send_wr *bad_wr;
> +	enum ib_send_flags flags;
> +	size_t sg_cnt;
> +	int err, i, offset;
> +	bool need_inval;
> +	u32 rkey = 0;
> +
> +	sg_cnt = le16_to_cpu(id->rd_msg->sg_cnt);
> +	need_inval = le16_to_cpu(id->rd_msg->flags) & IBTRS_MSG_NEED_INVAL_F;
> +	if (unlikely(!sg_cnt))
> +		return -EINVAL;
> +
> +	offset = 0;
> +	for (i = 0; i < sg_cnt; i++) {
> +		struct ib_sge *list;
> +
> +		wr		= &id->tx_wr[i];
> +		list		= &id->tx_sg[i];
> +		list->addr	= dma_addr + offset;
> +		list->length	= le32_to_cpu(id->rd_msg->desc[i].len);
> +
> +		/* WR will fail with length error
> +		 * if this is 0
> +		 */
> +		if (unlikely(list->length == 0)) {
> +			ibtrs_err(sess, "Invalid RDMA-Write sg list length 0\n");
> +			return -EINVAL;
> +		}
> +
> +		list->lkey = sess->s.dev->ib_pd->local_dma_lkey;
> +		offset += list->length;
> +
> +		wr->wr.wr_cqe	= &io_comp_cqe;
> +		wr->wr.sg_list	= list;
> +		wr->wr.num_sge	= 1;
> +		wr->remote_addr	= le64_to_cpu(id->rd_msg->desc[i].addr);
> +		wr->rkey	= le32_to_cpu(id->rd_msg->desc[i].key);
> +		if (rkey == 0)
> +			rkey = wr->rkey;
> +		else
> +			/* Only one key is actually used */
> +			WARN_ON_ONCE(rkey != wr->rkey);
> +
> +		if (i < (sg_cnt - 1))
> +			wr->wr.next = &id->tx_wr[i + 1].wr;
> +		else if (need_inval)
> +			wr->wr.next = &inv_wr;
> +		else
> +			wr->wr.next = &imm_wr;
> +
> +		wr->wr.opcode = IB_WR_RDMA_WRITE;
> +		wr->wr.ex.imm_data = 0;
> +		wr->wr.send_flags  = 0;
> +	}
> +	/*
> +	 * From time to time we have to post signalled sends,
> +	 * or send queue will fill up and only QP reset can help.
> +	 */
> +	flags = atomic_inc_return(&id->con->wr_cnt) % srv->queue_depth ?
> +			0 : IB_SEND_SIGNALED;
> +
> +	if (need_inval) {
> +		inv_wr.next = &imm_wr;
> +		inv_wr.wr_cqe = &io_comp_cqe;
> +		inv_wr.sg_list = NULL;
> +		inv_wr.num_sge = 0;
> +		inv_wr.opcode = IB_WR_SEND_WITH_INV;
> +		inv_wr.send_flags = 0;
> +		inv_wr.ex.invalidate_rkey = rkey;
> +	}
> +	imm_wr.next = NULL;
> +	imm_wr.wr_cqe = &io_comp_cqe;
> +	imm_wr.sg_list = NULL;
> +	imm_wr.num_sge = 0;
> +	imm_wr.opcode = IB_WR_RDMA_WRITE_WITH_IMM;
> +	imm_wr.send_flags = flags;
> +	imm_wr.ex.imm_data = cpu_to_be32(ibtrs_to_io_rsp_imm(id->msg_id,
> +							     0, need_inval));
> +
> +	ib_dma_sync_single_for_device(sess->s.dev->ib_dev, dma_addr,
> +				      offset, DMA_BIDIRECTIONAL);
> +
> +	err = ib_post_send(id->con->c.qp, &id->tx_wr[0].wr, &bad_wr);
> +	if (unlikely(err))
> +		ibtrs_err(sess,
> +			  "Posting RDMA-Write-Request to QP failed, err: %d\n",
> +			  err);
> +
> +	return err;
> +}

All other RDMA server implementations use rdma_rw_ctx_init() and 
rdma_rw_ctx_wrs(). Please use these functions in IBTRS too.

> +static void ibtrs_srv_hb_err_handler(struct ibtrs_con *c, int err)
> +{
> +	(void)err;
> +	close_sess(to_srv_sess(c->sess));
> +}

Is the (void)err statement really necessary?

> +static int ibtrs_srv_rdma_init(struct ibtrs_srv_ctx *ctx, unsigned int port)
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
> +	struct rdma_cm_id *cm_ip, *cm_ib;
> +	int ret;
> +
> +	/*
> +	 * We accept both IPoIB and IB connections, so we need to keep
> +	 * two cm id's, one for each socket type and port space.
> +	 * If the cm initialization of one of the id's fails, we abort
> +	 * everything.
> +	 */
> +	cm_ip = ibtrs_srv_cm_init(ctx, (struct sockaddr *)&sin, RDMA_PS_TCP);
> +	if (unlikely(IS_ERR(cm_ip)))
> +		return PTR_ERR(cm_ip);
> +
> +	cm_ib = ibtrs_srv_cm_init(ctx, (struct sockaddr *)&sib, RDMA_PS_IB);
> +	if (unlikely(IS_ERR(cm_ib))) {
> +		ret = PTR_ERR(cm_ib);
> +		goto free_cm_ip;
> +	}
> +
> +	ctx->cm_id_ip = cm_ip;
> +	ctx->cm_id_ib = cm_ib;
> +
> +	return 0;
> +
> +free_cm_ip:
> +	rdma_destroy_id(cm_ip);
> +
> +	return ret;
> +}

Will the above work if CONFIG_IPV6=n?

> +static int __init ibtrs_server_init(void)
> +{
> +	int err;
> +
> +	if (!strlen(cq_affinity_list))
> +		init_cq_affinity();

Is the above if-test useful? Can that if-test be left out?

Thanks,

Bart.
