Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C189647FAD4
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Dec 2021 08:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbhL0H7Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Dec 2021 02:59:25 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:41481 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231146AbhL0H7Z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Dec 2021 02:59:25 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V.soHDc_1640591962;
Received: from 30.43.106.107(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V.soHDc_1640591962)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 27 Dec 2021 15:59:23 +0800
Message-ID: <2f95fdfc-8c3d-924d-27da-b4b05f935c00@linux.alibaba.com>
Date:   Mon, 27 Dec 2021 15:59:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH rdma-core 2/5] RDMA-CORE/erdma: Add userspace verbs
 implementation
Content-Language: en-US
To:     Devesh Sharma <devesh.s.sharma@oracle.com>,
        "leon@kernel.org" <leon@kernel.org>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@mellanox.com" <jgg@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "KaiShen@linux.alibaba.com" <KaiShen@linux.alibaba.com>
References: <20211224065522.29734-1-chengyou@linux.alibaba.com>
 <20211224065522.29734-3-chengyou@linux.alibaba.com>
 <CO6PR10MB5635B8902D89993CF61EA989DD429@CO6PR10MB5635.namprd10.prod.outlook.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <CO6PR10MB5635B8902D89993CF61EA989DD429@CO6PR10MB5635.namprd10.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 12/27/21 2:29 PM, Devesh Sharma wrote:
> 
> 

<...>

>> +	++page->used;
>> +
>> +	for (i = 0; !page->free[i]; ++i)
>> +		;/* nothing */
> Why?

page->free[i] is a 64bits bitmap, all zeros means the corespoding
entries are all used, then we need to traverse next. If stopped, then
we get a valid entry to use.

>> +
>> +	j = ffsl(page->free[i]) - 1;
>> +	page->free[i] &= ~(1UL << j);
>> +
>> +	db_records = page->page_buf + (i * bits_perlong + j) *
>> +ERDMA_DBRECORDS_SIZE;
>> +
>> +out:
>> +	pthread_mutex_unlock(&ctx->dbrecord_pages_mutex);
>> +
>> +	return db_records;
>> +}
>> +
>> +void erdma_dealloc_dbrecords(struct erdma_context *ctx, uint64_t
>> +*dbrecords) {
>> +	struct erdma_dbrecord_page *page;
>> +	int page_mask = ~(ctx->page_size - 1);
>> +	int idx;
>> +
>> +	pthread_mutex_lock(&ctx->dbrecord_pages_mutex);
>> +	for (page = ctx->dbrecord_pages; page; page = page->next)
>> +		if (((uintptr_t)dbrecords & page_mask) == (uintptr_t)page-
>>> page_buf)
>> +			break;
>> +
>> +	if (!page)
>> +		goto out;
>> +
>> +	idx = ((void *)dbrecords - page->page_buf) /
>> ERDMA_DBRECORDS_SIZE;
>> +	page->free[idx / (8 * sizeof(unsigned long))] |=
>> +		1UL << (idx % (8 * sizeof(unsigned long)));
>> +
>> +	if (!--page->used) {
>> +		if (page->prev)
>> +			page->prev->next = page->next;
>> +		else
>> +			ctx->dbrecord_pages = page->next;
>> +		if (page->next)
>> +			page->next->prev = page->prev;
>> +
>> +		free(page->page_buf);
>> +		free(page);
>> +	}
>> +
>> +out:
>> +	pthread_mutex_unlock(&ctx->dbrecord_pages_mutex);
>> +}

<...>

>> +static void __erdma_alloc_dbs(struct erdma_qp *qp, struct erdma_context
>> +*ctx) {
>> +	uint32_t qpn = qp->id;
>> +
>> +	if (ctx->sdb_type == ERDMA_SDB_PAGE) {
>> +		/* qpn[4:0] as the index in this db page. */
>> +		qp->sq.db = ctx->sdb + (qpn & 31) * ERDMA_SQDB_SIZE;
>> +	} else if (ctx->sdb_type == ERDMA_SDB_ENTRY) {
>> +		/* for type 'ERDMA_SDB_ENTRY', each uctx has 2 dwqe,
>> totally takes 256Bytes. */
>> +		qp->sq.db = ctx->sdb + ctx->sdb_offset * 256;
> Generally we use macros to define hard-coded integers. E.g 256 should use a macro.

OK, will fix.

>> +	} else {
>> +		/* qpn[4:0] as the index in this db page. */
>> +		qp->sq.db = ctx->sdb + (qpn & 31) * ERDMA_SQDB_SIZE;
>> +	}
>> +
>> +	/* qpn[6:0] as the index in this rq db page. */
>> +	qp->rq.db = ctx->rdb + (qpn & 127) * ERDMA_RQDB_SPACE_SIZE; }
>> +
>> +struct ibv_qp *erdma_create_qp(struct ibv_pd *pd, struct
>> +ibv_qp_init_attr *attr) {
>> +	struct erdma_cmd_create_qp cmd = {};
>> +	struct erdma_cmd_create_qp_resp resp = {};
>> +	struct erdma_qp *qp;
>> +	struct ibv_context *base_ctx = pd->context;
>> +	struct erdma_context *ctx = to_ectx(base_ctx);
>> +	uint64_t *db_records  = NULL;
>> +	int rv, tbl_idx, tbl_off;
>> +	int sq_size = 0, rq_size = 0, total_bufsize = 0;
>> +
>> +	memset(&cmd, 0, sizeof(cmd));
>> +	memset(&resp, 0, sizeof(resp));
> No need of memset due to declaration step.

OK, will fix.

>> +
>> +	qp = calloc(1, sizeof(*qp));
>> +	if (!qp)
>> +		return NULL;
>> +
>> +	sq_size = roundup_pow_of_two(attr->cap.max_send_wr *
>> MAX_WQEBB_PER_SQE) << SQEBB_SHIFT;
>> +	sq_size = align(sq_size, ctx->page_size);
>> +	rq_size = align(roundup_pow_of_two(attr->cap.max_recv_wr) <<
>> RQE_SHIFT, ctx->page_size);
>> +	total_bufsize = sq_size + rq_size;
>> +	rv = posix_memalign(&qp->qbuf, ctx->page_size, total_bufsize);
>> +	if (rv || !qp->qbuf) {
>> +		errno = ENOMEM;
>> +		goto error_alloc;
>> +	}

<...>

>> +
>> +int erdma_destroy_qp(struct ibv_qp *base_qp) {
>> +	struct erdma_qp *qp = to_eqp(base_qp);
>> +	struct ibv_context *base_ctx = base_qp->pd->context;
>> +	struct erdma_context *ctx = to_ectx(base_ctx);
>> +	int rv, tbl_idx, tbl_off;
>> +
>> +	pthread_spin_lock(&qp->sq_lock);
>> +	pthread_spin_lock(&qp->rq_lock);
> Why to hold these?

Here, we are destroying the qp resources, such as the queue buffers.
we want to avoid race condition with post_send and post_recv.

>> +
>> +	pthread_mutex_lock(&ctx->qp_table_mutex);
>> +	tbl_idx = qp->id >> ERDMA_QP_TABLE_SHIFT;
>> +	tbl_off = qp->id & ERDMA_QP_TABLE_MASK;
>> +
>> +	ctx->qp_table[tbl_idx].table[tbl_off] = NULL;
>> +	ctx->qp_table[tbl_idx].refcnt--;
>> +
>> +	if (ctx->qp_table[tbl_idx].refcnt == 0) {
>> +		free(ctx->qp_table[tbl_idx].table);
>> +		ctx->qp_table[tbl_idx].table = NULL;
>> +	}
>> +
>> +	pthread_mutex_unlock(&ctx->qp_table_mutex);
>> +
>> +	rv = ibv_cmd_destroy_qp(base_qp);
>> +	if (rv) {
>> +		pthread_spin_unlock(&qp->rq_lock);
>> +		pthread_spin_unlock(&qp->sq_lock);
>> +		return rv;
>> +	}
>> +	pthread_spin_destroy(&qp->rq_lock);
>> +	pthread_spin_destroy(&qp->sq_lock);
>> +
>> +	if (qp->db_records)
>> +		erdma_dealloc_dbrecords(ctx, qp->db_records);
>> +
>> +	if (qp->qbuf)
>> +		free(qp->qbuf);
>> +
>> +	free(qp);
>> +
>> +	return 0;
>> +}
>> +

<...>

>> +
>> +int erdma_post_send(struct ibv_qp *base_qp, struct ibv_send_wr *wr,
>> +struct ibv_send_wr **bad_wr) {
>> +	struct erdma_qp *qp = to_eqp(base_qp);
>> +	uint16_t sq_pi;
>> +	int new_sqe = 0, rv = 0;
>> +
>> +	*bad_wr = NULL;
>> +
>> +	if (base_qp->state == IBV_QPS_ERR) {
> Post_send is allowed in Error state. Thus the check is redundant.

Does this have specification? We didn't find the description in IB
specification.
ERDMA uses iWarp, and in this specification (link: [1]), it says that
two actions should be taken: "post wqe, and then flush it" or "return
an immediate error" when post WR in ERROR state. After modify qp to err,
our hardware will flush all the wqes, thus for the newly posted wr, we
return an error immediately.
Also, I review other providers' implementation, ocrdma/efa/bnxt_re also
don't allow post_send in ERROR state. Does this can have a little
difference depended on different HCAs?

Thanks,
Cheng Xu

[1] 
https://datatracker.ietf.org/doc/html/draft-hilland-rddp-verbs-00#section-6.2.4



>> +		*bad_wr = wr;
>> +		return -EIO;
>> +	}
>> +
>> +	pthread_spin_lock(&qp->sq_lock);
>> +
>> +	sq_pi = qp->sq.pi;
>> +
>> +	while (wr) {
>> +		if ((uint16_t)(sq_pi - qp->sq.ci) >= qp->sq.depth) {
>> +			rv = -ENOMEM;
>> +			*bad_wr = wr;
>> +			break;
>> +		}
>> +

<...>

>> --
>> 2.27.0
