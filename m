Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF61D174AAB
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Mar 2020 02:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbgCABdq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 29 Feb 2020 20:33:46 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40808 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgCABdq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 29 Feb 2020 20:33:46 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so2750333plp.7;
        Sat, 29 Feb 2020 17:33:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=RE+/wkxBr0hZusUR7iv1SCQQ71srK/J8e6DrsaIe50M=;
        b=lvEYahSNUs1rm9aHE8YD0oGk0kwC5af5saX9GgV3D6K4RDD0DLUqLx6CZqq/X1ujKe
         tRiuHXcggCqX1f+vpzX5E+9Up6bbjj8cFspPjvtqGuev9SyVvSHfAOelK2ntrDc0Wjfy
         2ZtBiIJ1aP0fEObv/MASyAMweYxjH+LUodYP9pLDQt5IWd6Ln8LDgvjKVKMcRVXpAeFP
         xN1hewn4TjPMg5iE52T5Goq8CQLdNWj6F5nAlrMb3cRO9mAzyGG+42LLIMC51EIFf1XS
         jm+xXQ3+1ZzrDqvNFKkuM0knXAyBaWBpEBP7nJr686xaHd87nHEJ4faXTulO+StCcw9c
         Es0Q==
X-Gm-Message-State: APjAAAU9WFYXsJSce/NMmBDJHYfaUdk8QKeguuac3wbUn2uCZPfSNDic
        VJg2Yk7uYDEEhsbMQ4xEXZ8=
X-Google-Smtp-Source: APXvYqxi4XIPjtlQloZ6edbGezMrg56BHpybqfvISNina1pWhWK0kuZ5yrpuZ+Eqw4QLzwnWol0ZDQ==
X-Received: by 2002:a17:90a:7784:: with SMTP id v4mr13234462pjk.134.1583026424034;
        Sat, 29 Feb 2020 17:33:44 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:bd83:6f94:8c5:942d? ([2601:647:4000:d7:bd83:6f94:8c5:942d])
        by smtp.gmail.com with ESMTPSA id x26sm16232923pfq.55.2020.02.29.17.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Feb 2020 17:33:42 -0800 (PST)
Subject: Re: [PATCH v9 06/25] RDMA/rtrs: client: main functionality
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, jgg@ziepe.ca,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de, pankaj.gupta@cloud.ionos.com
References: <20200221104721.350-1-jinpuwang@gmail.com>
 <20200221104721.350-7-jinpuwang@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <c3c8fbcc-0028-9b23-8eff-3b5f1f60e652@acm.org>
Date:   Sat, 29 Feb 2020 17:33:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221104721.350-7-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-02-21 02:47, Jack Wang wrote:
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(sess, &clt->paths_list, s.entry)
> +		connected |= (READ_ONCE(sess->state) == RTRS_CLT_CONNECTED);
> +	rcu_read_unlock();

Are the parentheses around the comparison necessary?

> +static struct rtrs_permit *
> +__rtrs_get_permit(struct rtrs_clt *clt, enum rtrs_clt_con_type con_type)
> +{
> +	size_t max_depth = clt->queue_depth;
> +	struct rtrs_permit *permit;
> +	int cpu, bit;
> +
> +	/* Combined with cq_vector, we pin the IO to the the cpu it comes */

This comment is confusing. Please clarify this comment. All I see below
is that preemption is disabled. I don't see pinning of I/O to the CPU of
the caller.

> +	cpu = get_cpu();
> +	do {
> +		bit = find_first_zero_bit(clt->permits_map, max_depth);
> +		if (unlikely(bit >= max_depth)) {
> +			put_cpu();
> +			return NULL;
> +		}
> +
> +	} while (unlikely(test_and_set_bit_lock(bit, clt->permits_map)));
> +	put_cpu();
> +
> +	permit = GET_PERMIT(clt, bit);
> +	WARN_ON(permit->mem_id != bit);
> +	permit->cpu_id = cpu;
> +	permit->con_type = con_type;
> +
> +	return permit;
> +}

Please remove the blank line before "} while (...)".

> +void rtrs_clt_put_permit(struct rtrs_clt *clt, struct rtrs_permit *permit)
> +{
> +	if (WARN_ON(!test_bit(permit->mem_id, clt->permits_map)))
> +		return;
> +
> +	__rtrs_put_permit(clt, permit);
> +
> +	/*
> +	 * Putting a permit is a barrier, so we will observe
> +	 * new entry in the wait list, no worries.
> +	 */
> +	if (waitqueue_active(&clt->permits_wait))
> +		wake_up(&clt->permits_wait);
> +}
> +EXPORT_SYMBOL(rtrs_clt_put_permit);

The comment in the above function is not only confusing but it also
fails to explain why it is safe to guard wake_up() with a
waitqueue_active() check. How about changing that comment into the
following:

rtrs_clt_get_permit() adds itself to the &clt->permits_wait list before
calling schedule(). So if rtrs_clt_get_permit() is sleeping it must have
added itself to &clt->permits_wait before __rtrs_put_permit() finished.
Hence it is safe to guard wake_up() with a waitqueue_active() test.

> +static int rtrs_post_send_rdma(struct rtrs_clt_con *con,
> +				struct rtrs_clt_io_req *req,
> +				struct rtrs_rbuf *rbuf, u32 off,
> +				u32 imm, struct ib_send_wr *wr)
> +{
> +	struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
> +	enum ib_send_flags flags;
> +	struct ib_sge sge;
> +
> +	if (unlikely(!req->sg_size)) {
> +		rtrs_wrn(con->c.sess,
> +			 "Doing RDMA Write failed, no data supplied\n");
> +		return -EINVAL;
> +	}
> +
> +	/* user data and user message in the first list element */
> +	sge.addr   = req->iu->dma_addr;
> +	sge.length = req->sg_size;
> +	sge.lkey   = sess->s.dev->ib_pd->local_dma_lkey;
> +
> +	/*
> +	 * From time to time we have to post signalled sends,
> +	 * or send queue will fill up and only QP reset can help.
> +	 */
> +	flags = atomic_inc_return(&con->io_cnt) % sess->queue_depth ?
> +			0 : IB_SEND_SIGNALED;
> +
> +	ib_dma_sync_single_for_device(sess->s.dev->ib_dev, req->iu->dma_addr,
> +				      req->sg_size, DMA_TO_DEVICE);
> +
> +	return rtrs_iu_post_rdma_write_imm(&con->c, req->iu, &sge, 1,
> +					    rbuf->rkey, rbuf->addr + off,
> +					    imm, flags, wr);
> +}

I don't think that posting a signalled send from time to time is
sufficient to prevent send queue overflow. Please address Jason's
comment from January 7th: "Not quite. If the SQ depth is 16 and you post
16 things and then signal the last one, you *cannot* post new work until
you see the completion. More SQ space *ONLY* becomes available upon
receipt of a completion. This is why you can't have an unsignaled SQ."

See also https://lore.kernel.org/linux-rdma/20200107182528.GB26174@ziepe.ca/

> +static void rtrs_clt_init_req(struct rtrs_clt_io_req *req,
> +				     struct rtrs_clt_sess *sess,
> +				     rtrs_conf_fn *conf,
> +				     struct rtrs_permit *permit, void *priv,
> +				     const struct kvec *vec, size_t usr_len,
> +				     struct scatterlist *sg, size_t sg_cnt,
> +				     size_t data_len, int dir)
> +{
> +	struct iov_iter iter;
> +	size_t len;
> +
> +	req->permit = permit;
> +	req->in_use = true;
> +	req->usr_len = usr_len;
> +	req->data_len = data_len;
> +	req->sglist = sg;
> +	req->sg_cnt = sg_cnt;
> +	req->priv = priv;
> +	req->dir = dir;
> +	req->con = rtrs_permit_to_clt_con(sess, permit);
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
> +}

It is hard to verify whether the above function initializes all fields
of 'req' or not. Consider changing the 'req' member assignments into
something like *req = (struct rtrs_clt_io_req){ .permit = permit, ... };

> +static int rtrs_post_rdma_write_sg(struct rtrs_clt_con *con,
> +				    struct rtrs_clt_io_req *req,
> +				    struct rtrs_rbuf *rbuf,
> +				    u32 size, u32 imm)
> +{
> +	struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
> +	struct ib_sge *sge = req->sge;
> +	enum ib_send_flags flags;
> +	struct scatterlist *sg;
> +	size_t num_sge;
> +	int i;
> +
> +	for_each_sg(req->sglist, sg, req->sg_cnt, i) {
> +		sge[i].addr   = sg_dma_address(sg);
> +		sge[i].length = sg_dma_len(sg);
> +		sge[i].lkey   = sess->s.dev->ib_pd->local_dma_lkey;
> +	}
> +	sge[i].addr   = req->iu->dma_addr;
> +	sge[i].length = size;
> +	sge[i].lkey   = sess->s.dev->ib_pd->local_dma_lkey;
> +
> +	num_sge = 1 + req->sg_cnt;
> +
> +	/*
> +	 * From time to time we have to post signalled sends,
> +	 * or send queue will fill up and only QP reset can help.
> +	 */
> +	flags = atomic_inc_return(&con->io_cnt) % sess->queue_depth ?
> +			0 : IB_SEND_SIGNALED;
> +
> +	ib_dma_sync_single_for_device(sess->s.dev->ib_dev, req->iu->dma_addr,
> +				      size, DMA_TO_DEVICE);
> +
> +	return rtrs_iu_post_rdma_write_imm(&con->c, req->iu, sge, num_sge,
> +					    rbuf->rkey, rbuf->addr, imm,
> +					    flags, NULL);
> +}

Same comment here. Posting a signalled send from time to time is not
sufficient to prevent send queue overflow.

> +		memset(&rwr, 0, sizeof(rwr));
> +		rwr.wr.next = NULL;
> +		rwr.wr.opcode = IB_WR_REG_MR;
> +		rwr.wr.wr_cqe = &fast_reg_cqe;
> +		rwr.wr.num_sge = 0;
> +		rwr.mr = req->mr;
> +		rwr.key = req->mr->rkey;
> +		rwr.access = (IB_ACCESS_LOCAL_WRITE |
> +			      IB_ACCESS_REMOTE_WRITE);

How about changing the above code into rwr = (struct ib_reg_wr){.wr = {
... }, ... };?

> +static int rtrs_rdma_route_resolved(struct rtrs_clt_con *con)
> +{
> +	struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
> +	struct rtrs_clt *clt = sess->clt;
> +	struct rtrs_msg_conn_req msg;
> +	struct rdma_conn_param param;
> +
> +	int err;
> +
> +	memset(&param, 0, sizeof(param));
> +	param.retry_count = 7;
> +	param.rnr_retry_count = 7;
> +	param.private_data = &msg;
> +	param.private_data_len = sizeof(msg);
> +
> +	/*
> +	 * Those two are the part of struct cma_hdr which is shared
> +	 * with private_data in case of AF_IB, so put zeroes to avoid
> +	 * wrong validation inside cma.c on receiver side.
> +	 */
> +	msg.__cma_version = 0;
> +	msg.__ip_version = 0;
> +	msg.magic = cpu_to_le16(RTRS_MAGIC);
> +	msg.version = cpu_to_le16(RTRS_PROTO_VER);
> +	msg.cid = cpu_to_le16(con->c.cid);
> +	msg.cid_num = cpu_to_le16(sess->s.con_num);
> +	msg.recon_cnt = cpu_to_le16(sess->s.recon_cnt);
> +	uuid_copy(&msg.sess_uuid, &sess->s.uuid);
> +	uuid_copy(&msg.paths_uuid, &clt->paths_uuid);
> +
> +	err = rdma_connect(con->c.cm_id, &param);
> +	if (err)
> +		rtrs_err(clt, "rdma_connect(): %d\n", err);
> +
> +	return err;
> +}

Please use structure assignment instead of memset() followed by a series
of member assignments.

> +static inline bool xchg_sessions(struct rtrs_clt_sess __rcu **rcu_ppcpu_path,
> +				 struct rtrs_clt_sess *sess,
> +				 struct rtrs_clt_sess *next)
> +{
> +	struct rtrs_clt_sess **ppcpu_path;
> +
> +	/* Call cmpxchg() without sparse warnings */
> +	ppcpu_path = (typeof(ppcpu_path))rcu_ppcpu_path;
> +	return (sess == cmpxchg(ppcpu_path, sess, next));
> +}

Did checkpatch report for the above code that "return is not a function"?

> +static void rtrs_clt_add_path_to_arr(struct rtrs_clt_sess *sess,
> +				      struct rtrs_addr *addr)
> +{
> +	struct rtrs_clt *clt = sess->clt;
> +
> +	mutex_lock(&clt->paths_mutex);
> +	clt->paths_num++;
> +
> +	/*
> +	 * Firstly increase paths_num, wait for GP and then
> +	 * add path to the list.  Why?  Since we add path with
> +	 * !CONNECTED state explanation is similar to what has
> +	 * been written in rtrs_clt_remove_path_from_arr().
> +	 */
> +	synchronize_rcu();
> +
> +	list_add_tail_rcu(&sess->s.entry, &clt->paths_list);
> +	mutex_unlock(&clt->paths_mutex);
> +}

At least in the Linux kernel keeping track of the number of elements in
a list is considered bad practice. What prevents removal of the
'paths_num' counter?

> +static void rtrs_clt_dev_release(struct device *dev)
> +{
> +	struct rtrs_clt *clt  = container_of(dev, struct rtrs_clt, dev);
> +
> +	kfree(clt);
> +}

Please surround the assignment operator with only a single space at each
side.

> +int rtrs_clt_remove_path_from_sysfs(struct rtrs_clt_sess *sess,
> +				     const struct attribute *sysfs_self)
> +{
> +	struct rtrs_clt *clt = sess->clt;
> +	enum rtrs_clt_state old_state;
> +	bool changed;
> +
> +	/*
> +	 * That can happen only when userspace tries to remove path
> +	 * very early, when rtrs_clt_open() is not yet finished.
> +	 */
> +	if (!clt->opened)
> +		return -EBUSY;
> +
> +	/*
> +	 * Continue stopping path till state was changed to DEAD or
> +	 * state was observed as DEAD:
> +	 * 1. State was changed to DEAD - we were fast and nobody
> +	 *    invoked rtrs_clt_reconnect(), which can again start
> +	 *    reconnecting.
> +	 * 2. State was observed as DEAD - we have someone in parallel
> +	 *    removing the path.
> +	 */
> +	do {
> +		rtrs_clt_close_conns(sess, true);
> +	} while (!(changed = rtrs_clt_change_state_get_old(sess,
> +							    RTRS_CLT_DEAD,
> +							    &old_state)) &&
> +		   old_state != RTRS_CLT_DEAD);

Did checkpatch ask not to use an assignment in the while-loop condition?

Thanks,

Bart.
