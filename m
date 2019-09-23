Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 782ADBBE24
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2019 23:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503183AbfIWVvs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Sep 2019 17:51:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40377 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387520AbfIWVvs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Sep 2019 17:51:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10so8770384pgj.7;
        Mon, 23 Sep 2019 14:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ea09ZjN1fmlsXEBEkl3FdseadDMq9uoMpI8GdwxgyT4=;
        b=ACL1aF/ft7iNT//Hnpythx1/AU9GQC68/45MbNNnk8CNSuqrNNUqReP88tiFZ14MLm
         Mo1v+Wy0I8avxBgo4RtcLobw9yeD7OWKJcYKcXUuDi5cBHs0a/dqgyVrAs5dmL3h8FP6
         SxvC5DdbRcXCBQkqZ6tACtxiNVhNuY4ydl8R0+wr3A8JSQSznvsG3ja1nx6EE5F5zPrA
         7hoA0EmgfU6WI1ArmRcTC2dwT0GAFDdG8XaoqZ7XFTfke2HiFtTaJN9r7dXvc1EiKZMa
         1PNfcR48VbJNhy37Cnrgppwkkm+HSKkn4AiYh4GVmC8hqIzxnOOBSzRvSRaDSG8kyGcN
         AmJg==
X-Gm-Message-State: APjAAAXn17SbcFVUSekkL1VoMbP7oWuYSkfAHPDSRqmltaX1xBCbS4Xb
        QREmLwT/Az2WuRElEkP2g4A=
X-Google-Smtp-Source: APXvYqzK16cyhfKcUzdsINdWdVmiv6Yj4AXrMEHluUymgurUNS8oLf1PA2QtDdhZM1hu9+t8opwtcw==
X-Received: by 2002:aa7:955d:: with SMTP id w29mr1949355pfq.60.1569275505820;
        Mon, 23 Sep 2019 14:51:45 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 196sm18690773pfz.99.2019.09.23.14.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 14:51:44 -0700 (PDT)
Subject: Re: [PATCH v4 06/25] ibtrs: client: main functionality
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        Jack Wang <jinpu.wang@cloud.ionos.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-7-jinpuwang@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <d0bc1253-4f3d-981b-97f1-e44900fffb44@acm.org>
Date:   Mon, 23 Sep 2019 14:51:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190620150337.7847-7-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/20/19 8:03 AM, Jack Wang wrote:
> +static const struct ibtrs_ib_dev_pool_ops dev_pool_ops;
> +static struct ibtrs_ib_dev_pool dev_pool = {
> +	.ops = &dev_pool_ops
> +};

Can the definitions in this file be reordered such that the forward 
declaration of dev_pool_ops can be removed?

> +static void ibtrs_rdma_error_recovery(struct ibtrs_clt_con *con);
> +static int ibtrs_clt_rdma_cm_handler(struct rdma_cm_id *cm_id,
> +				     struct rdma_cm_event *ev);
> +static void ibtrs_clt_rdma_done(struct ib_cq *cq, struct ib_wc *wc);
> +static void complete_rdma_req(struct ibtrs_clt_io_req *req, int errno,
> +			      bool notify, bool can_wait);
> +static int ibtrs_clt_write_req(struct ibtrs_clt_io_req *req);
> +static int ibtrs_clt_read_req(struct ibtrs_clt_io_req *req);

Please also remove these forward declarations.

> +bool ibtrs_clt_sess_is_connected(const struct ibtrs_clt_sess *sess)
> +{
> +	return sess->state == IBTRS_CLT_CONNECTED;
> +}

Is it really useful to introduce a one line function for testing the 
session state?

> +static inline struct ibtrs_tag *
> +__ibtrs_get_tag(struct ibtrs_clt *clt, enum ibtrs_clt_con_type con_type)
> +{
> +	size_t max_depth = clt->queue_depth;
> +	struct ibtrs_tag *tag;
> +	int cpu, bit;
> +
> +	cpu = get_cpu();
> +	do {
> +		bit = find_first_zero_bit(clt->tags_map, max_depth);
> +		if (unlikely(bit >= max_depth)) {
> +			put_cpu();
> +			return NULL;
> +		}
> +
> +	} while (unlikely(test_and_set_bit_lock(bit, clt->tags_map)));
> +	put_cpu();
> +
> +	tag = GET_TAG(clt, bit);
> +	WARN_ON(tag->mem_id != bit);
> +	tag->cpu_id = cpu;
> +	tag->con_type = con_type;
> +
> +	return tag;
> +}

What is the role of the get_cpu() and put_cpu() calls in this function? 
How can it make sense to assign the cpu number to tag->cpu_id after 
put_cpu() has been called?

> +static inline void ibtrs_clt_init_req(struct ibtrs_clt_io_req *req,
> +				      struct ibtrs_clt_sess *sess,
> +				      ibtrs_conf_fn *conf,
> +				      struct ibtrs_tag *tag, void *priv,
> +				      const struct kvec *vec, size_t usr_len,
> +				      struct scatterlist *sg, size_t sg_cnt,
> +				      size_t data_len, int dir)
> +{
> +	struct iov_iter iter;
> +	size_t len;
> +
> +	req->tag = tag;
> +	req->in_use = true;
> +	req->usr_len = usr_len;
> +	req->data_len = data_len;
> +	req->sglist = sg;
> +	req->sg_cnt = sg_cnt;
> +	req->priv = priv;
> +	req->dir = dir;
> +	req->con = ibtrs_tag_to_clt_con(sess, tag);
> +	req->conf = conf;
> +	req->need_inv = false;
> +	req->need_inv_comp = false;
> +	req->inv_errno = 0;
> +
> +	iov_iter_kvec(&iter, READ, vec, 1, usr_len);
> +	len = _copy_from_iter(req->iu->buf, usr_len, &iter);
> +	WARN_ON(len != usr_len);
> +
> +	reinit_completion(&req->inv_comp);
> +	if (sess->stats.enable_rdma_lat)
> +		req->start_jiffies = jiffies;
> +}

A comment that explains what "req" stands for would be welcome. Since 
this function copies the entire payload, I assume that it is only used 
for control messages and not for reading or writing data from a block 
device?

> +static int ibtrs_clt_failover_req(struct ibtrs_clt *clt,
> +				  struct ibtrs_clt_io_req *fail_req)
> +{
> +	struct ibtrs_clt_sess *alive_sess;
> +	struct ibtrs_clt_io_req *req;
> +	int err = -ECONNABORTED;
> +	struct path_it it;
> +
> +	do_each_path(alive_sess, clt, &it) {
> +		if (unlikely(alive_sess->state != IBTRS_CLT_CONNECTED))
> +			continue;
> +		req = ibtrs_clt_get_copy_req(alive_sess, fail_req);
> +		if (req->dir == DMA_TO_DEVICE)
> +			err = ibtrs_clt_write_req(req);
> +		else
> +			err = ibtrs_clt_read_req(req);
> +		if (unlikely(err)) {
> +			req->in_use = false;
> +			continue;
> +		}
> +		/* Success path */
> +		ibtrs_clt_inc_failover_cnt(&alive_sess->stats);
> +		break;
> +	} while_each_path(&it);
> +
> +	return err;
> +}

Also for this function, a comment that explains the purpose of this 
function would be welcome.

> +static void fail_all_outstanding_reqs(struct ibtrs_clt_sess *sess)
> +{
> +	struct ibtrs_clt *clt = sess->clt;
> +	struct ibtrs_clt_io_req *req;
> +	int i, err;
> +
> +	if (!sess->reqs)
> +		return;
> +	for (i = 0; i < sess->queue_depth; ++i) {
> +		req = &sess->reqs[i];
> +		if (!req->in_use)
> +			continue;
> +
> +		/*
> +		 * Safely (without notification) complete failed request.
> +		 * After completion this request is still usebale and can
> +		 * be failovered to another path.
> +		 */
> +		complete_rdma_req(req, -ECONNABORTED, false, true);
> +
> +		err = ibtrs_clt_failover_req(clt, req);
> +		if (unlikely(err))
> +			/* Failover failed, notify anyway */
> +			req->conf(req->priv, err);
> +	}
> +}

What guarantees that this function does not call complete_rdma_req() 
while complete_rdma_req() is called from the regular completion path?

> +static bool __ibtrs_clt_change_state(struct ibtrs_clt_sess *sess,
> +				     enum ibtrs_clt_state new_state)
> +{
> +	enum ibtrs_clt_state old_state;
> +	bool changed = false;
> +
> +	old_state = sess->state;
> +	switch (new_state) {

Please use lockdep_assert_held() inside this function to verify at 
runtime that session state changes are serialized properly.

> +static enum ibtrs_clt_state ibtrs_clt_state(struct ibtrs_clt_sess *sess)
> +{
> +	enum ibtrs_clt_state state;
> +
> +	spin_lock_irq(&sess->state_wq.lock);
> +	state = sess->state;
> +	spin_unlock_irq(&sess->state_wq.lock);
> +
> +	return state;
> +}

Please remove this function and read sess->state without holding 
state_wq.lock.

> +static void ibtrs_clt_hb_err_handler(struct ibtrs_con *c, int err)
> +{
> +	struct ibtrs_clt_con *con;
> +
> +	(void)err;
> +	con = container_of(c, typeof(*con), c);
> +	ibtrs_rdma_error_recovery(con);
> +}

Can "(void)err" be left out?

Can the declaration and assignment of 'con' be merged into a single line 
of code?

> +static int create_con(struct ibtrs_clt_sess *sess, unsigned int cid)
> +{
> +	struct ibtrs_clt_con *con;
> +
> +	con = kzalloc(sizeof(*con), GFP_KERNEL);
> +	if (unlikely(!con))
> +		return -ENOMEM;
> +
> +	/* Map first two connections to the first CPU */
> +	con->cpu  = (cid ? cid - 1 : 0) % nr_cpu_ids;
> +	con->c.cid = cid;
> +	con->c.sess = &sess->s;
> +	atomic_set(&con->io_cnt, 0);
> +
> +	sess->s.con[cid] = &con->c;
> +
> +	return 0;
> +}

The code to map a connection ID to onto a CPU occurs multiple times. Has 
it been considered to introduce a function for that mapping? Although 
one-line inline functions are not recommended in general, such a 
function will also make it easier to experiment with other mapping 
approaches, e.g. mapping hypertread siblings onto the same connection ID.

> +static inline bool xchg_sessions(struct ibtrs_clt_sess __rcu **rcu_ppcpu_path,
> +				 struct ibtrs_clt_sess *sess,
> +				 struct ibtrs_clt_sess *next)
> +{
> +	struct ibtrs_clt_sess **ppcpu_path;
> +
> +	/* Call cmpxchg() without sparse warnings */
> +	ppcpu_path = (typeof(ppcpu_path))rcu_ppcpu_path;
> +	return (sess == cmpxchg(ppcpu_path, sess, next));
> +}

This looks suspicious. Has it been considered to protect changes of 
rcu_ppcpu_path with a mutex and to protect reads with an RCU read lock?

> +static void ibtrs_clt_add_path_to_arr(struct ibtrs_clt_sess *sess,
> +				      struct ibtrs_addr *addr)
> +{
> +	struct ibtrs_clt *clt = sess->clt;
> +
> +	mutex_lock(&clt->paths_mutex);
> +	clt->paths_num++;
> +
> +	/*
> +	 * Firstly increase paths_num, wait for GP and then
> +	 * add path to the list.  Why?  Since we add path with
> +	 * !CONNECTED state explanation is similar to what has
> +	 * been written in ibtrs_clt_remove_path_from_arr().
> +	 */
> +	synchronize_rcu();
> +
> +	list_add_tail_rcu(&sess->s.entry, &clt->paths_list);
> +	mutex_unlock(&clt->paths_mutex);
> +}

synchronize_rcu() while a mutex is being held? Really?

> +static void ibtrs_clt_close_work(struct work_struct *work)
> +{
> +	struct ibtrs_clt_sess *sess;
> +
> +	sess = container_of(work, struct ibtrs_clt_sess, close_work);
> +
> +	cancel_delayed_work_sync(&sess->reconnect_dwork);
> +	ibtrs_clt_stop_and_destroy_conns(sess);
> +	/*
> +	 * Sounds stupid, huh?  No, it is not.  Consider this sequence:
> +	 *
> +	 *   #CPU0                              #CPU1
> +	 *   1.  CONNECTED->RECONNECTING
> +	 *   2.                                 RECONNECTING->CLOSING
> +	 *   3.  queue_work(&reconnect_dwork)
> +	 *   4.                                 queue_work(&close_work);
> +	 *   5.  reconnect_work();              close_work();
> +	 *
> +	 * To avoid that case do cancel twice: before and after.
> +	 */
> +	cancel_delayed_work_sync(&sess->reconnect_dwork);
> +	ibtrs_clt_change_state(sess, IBTRS_CLT_CLOSED);
> +}

The above code looks suspicious to me. I think there should be an 
additional state change at the start of this function to prevent that 
reconnect_dwork gets requeued after having been canceled.

> +static void ibtrs_clt_dev_release(struct device *dev)
> +{
> +	/* Nobody plays with device references, so nop */
> +}

That comment sounds wrong. Have you reviewed all of the device driver 
core code and checked that there is no code in there that manipulates 
struct device refcounts? I think the code that frees struct ibtrs_clt 
should be moved from free_clt() into the above function.

Bart.
