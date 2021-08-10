Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E700F3E296F
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Aug 2021 13:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245443AbhHFLWF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Aug 2021 07:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240437AbhHFLV7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Aug 2021 07:21:59 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0585C061799
        for <linux-rdma@vger.kernel.org>; Fri,  6 Aug 2021 04:21:43 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id hw6so14540749ejc.10
        for <linux-rdma@vger.kernel.org>; Fri, 06 Aug 2021 04:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J09doIaV8dHfqEO0/QYoSy2bryrIokomcBOC29NrbS0=;
        b=VhFg4KYHY9ZIqLTPOaxxgVz23QH6I0qeXaXa1cLIqDw9ReAkMzF793/r1etb0cVlJE
         81/23Lt1NDenceLFyvNc2dmEDODZ4mGF5oEad3Yg0ci0rXmN7zzvsulGeKYatUXqPopj
         cfE9vQKoKMovmujyomK5YgjdKOdrzKTYdYuAPIsp/ps7YrFnGfeYnX8EkwNAJJ/8zWJF
         QBChQPa9KgMiVxEbEGfu4Qp5UvUqCLt6fBxljrwndyyMgMUM8Sgjpd1uYHsrlg3aef1t
         XPWbrDLKmcZ4JOGHSq+0+Q43cDCvwqQMCT/RzKpXhyXLgbRLY+Q1W39CGMEXnTGRLqu9
         YaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J09doIaV8dHfqEO0/QYoSy2bryrIokomcBOC29NrbS0=;
        b=PSvM3hqO4isYCIYn0/rRJMNPKlzGd4opqr/3PxXRVbYCD01IqBumJM/PY7F2AdNWmA
         9GX/3MT8/LAk/gVF39aLKFKEgzTOOR4r/o4EqnYwMPs/iOlQewirlGNfURyOQbijW8lM
         ANTAgkpQshwdb2BRhQwfYJxvE0TNFaPdZcLKCGUhrxDS7dYGpDMKAiJSAFZ9GkTlklJ+
         U6d8uhR8NSIh2oXVE3ARnbZxUlowxXoEXR43MN29O6/fuCGTALQitfRyyzOWH5Q8AIQ3
         5XMFrdVrJ+L7lnOBNBJ0nDix6XZtHjbRU784rPtl9myKrPG7xtPmSMsQddUhdbfoY//3
         QGUQ==
X-Gm-Message-State: AOAM531rIlZNZaCok1WKMRpUwKfnoEQxnNWf5CIj8j7zG339AhC79PCL
        08QDp8WZiN0CUig1z5DRBMQuOd4qzsTpaA==
X-Google-Smtp-Source: ABdhPJyfmdo1UXlompJAwawcbq32HlSzoXWSofUQ6pelHCCTZL4ZRNC6VsMi8Dp7BeYg2b9bnw6n8A==
X-Received: by 2002:a17:907:b11:: with SMTP id h17mr9353588ejl.93.1628248902188;
        Fri, 06 Aug 2021 04:21:42 -0700 (PDT)
Received: from nb01533.pb.local ([2001:1438:4010:2540:9e61:8a1a:7868:3b15])
        by smtp.gmail.com with ESMTPSA id q11sm2794729ejb.10.2021.08.06.04.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 04:21:41 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH v2 for-next 4/6] RDMA/rtrs: Remove all likely and unlikely
Date:   Fri,  6 Aug 2021 13:21:10 +0200
Message-Id: <20210806112112.124313-5-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210806112112.124313-1-haris.iqbal@ionos.com>
References: <20210806112112.124313-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@ionos.com>

The IO performance test with fio after swapping the likely
and unlikely macros in all if-statement shows no difference.
They do not help for the performance of rtrs.

Thanks to Haakon Bugge for the test scenario.

The fio test did random read on 32 rnbd devices and 64 processes.
Test environment:
- Intel(R) Xeon(R) Gold 6130 CPU @ 2.10GHz
- 376G memory
- kernel version: 5.4.86
- gcc version: gcc (Debian 8.3.0-6) 8.3.0
- Infiniband controller: Mellanox Technologies MT27800 Family
[ConnectX-5]

Test result:
- before swapping:       IOPS=829k, BW=3239MiB/s
- after swapping:        IOPS=829k, BW=3238MiB/s
- remove all (un)likely: IOPS=829k, BW=3238MiB/s

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c |   2 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 126 +++++++++----------
 drivers/infiniband/ulp/rtrs/rtrs-srv.c       |  74 ++++++-----
 3 files changed, 99 insertions(+), 103 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
index 26bbe5d6dff5..b660c96a3039 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
@@ -20,7 +20,7 @@ void rtrs_clt_update_wc_stats(struct rtrs_clt_con *con)
 
 	cpu = raw_smp_processor_id();
 	s = this_cpu_ptr(stats->pcpu_stats);
-	if (unlikely(con->cpu != cpu)) {
+	if (con->cpu != cpu) {
 		s->cpu_migr.to++;
 
 		/* Careful here, override s pointer */
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index a7b450715eaf..d3e1173e2acd 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -75,9 +75,9 @@ __rtrs_get_permit(struct rtrs_clt *clt, enum rtrs_clt_con_type con_type)
 	 */
 	do {
 		bit = find_first_zero_bit(clt->permits_map, max_depth);
-		if (unlikely(bit >= max_depth))
+		if (bit >= max_depth)
 			return NULL;
-	} while (unlikely(test_and_set_bit_lock(bit, clt->permits_map)));
+	} while (test_and_set_bit_lock(bit, clt->permits_map));
 
 	permit = get_permit(clt, bit);
 	WARN_ON(permit->mem_id != bit);
@@ -115,14 +115,14 @@ struct rtrs_permit *rtrs_clt_get_permit(struct rtrs_clt *clt,
 	DEFINE_WAIT(wait);
 
 	permit = __rtrs_get_permit(clt, con_type);
-	if (likely(permit) || !can_wait)
+	if (permit || !can_wait)
 		return permit;
 
 	do {
 		prepare_to_wait(&clt->permits_wait, &wait,
 				TASK_UNINTERRUPTIBLE);
 		permit = __rtrs_get_permit(clt, con_type);
-		if (likely(permit))
+		if (permit)
 			break;
 
 		io_schedule();
@@ -175,7 +175,7 @@ struct rtrs_clt_con *rtrs_permit_to_clt_con(struct rtrs_clt_sess *sess,
 {
 	int id = 0;
 
-	if (likely(permit->con_type == RTRS_IO_CON))
+	if (permit->con_type == RTRS_IO_CON)
 		id = (permit->cpu_id % (sess->s.irq_con_num - 1)) + 1;
 
 	return to_clt_con(sess->s.con[id]);
@@ -329,7 +329,7 @@ static void rtrs_clt_fast_reg_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct rtrs_clt_con *con = to_clt_con(wc->qp->qp_context);
 
-	if (unlikely(wc->status != IB_WC_SUCCESS)) {
+	if (wc->status != IB_WC_SUCCESS) {
 		rtrs_err(con->c.sess, "Failed IB_WR_REG_MR: %s\n",
 			  ib_wc_status_msg(wc->status));
 		rtrs_rdma_error_recovery(con);
@@ -349,13 +349,13 @@ static void rtrs_clt_inv_rkey_done(struct ib_cq *cq, struct ib_wc *wc)
 		container_of(wc->wr_cqe, typeof(*req), inv_cqe);
 	struct rtrs_clt_con *con = to_clt_con(wc->qp->qp_context);
 
-	if (unlikely(wc->status != IB_WC_SUCCESS)) {
+	if (wc->status != IB_WC_SUCCESS) {
 		rtrs_err(con->c.sess, "Failed IB_WR_LOCAL_INV: %s\n",
 			  ib_wc_status_msg(wc->status));
 		rtrs_rdma_error_recovery(con);
 	}
 	req->need_inv = false;
-	if (likely(req->need_inv_comp))
+	if (req->need_inv_comp)
 		complete(&req->inv_comp);
 	else
 		/* Complete request from INV callback */
@@ -390,7 +390,7 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
 	sess = to_clt_sess(con->c.sess);
 
 	if (req->sg_cnt) {
-		if (unlikely(req->dir == DMA_FROM_DEVICE && req->need_inv)) {
+		if (req->dir == DMA_FROM_DEVICE && req->need_inv) {
 			/*
 			 * We are here to invalidate read requests
 			 * ourselves.  In normal scenario server should
@@ -405,7 +405,7 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
 			 *        should do that ourselves.
 			 */
 
-			if (likely(can_wait)) {
+			if (can_wait) {
 				req->need_inv_comp = true;
 			} else {
 				/* This should be IO path, so always notify */
@@ -416,10 +416,10 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
 
 			refcount_inc(&req->ref);
 			err = rtrs_inv_rkey(req);
-			if (unlikely(err)) {
+			if (err) {
 				rtrs_err(con->c.sess, "Send INV WR key=%#x: %d\n",
 					  req->mr->rkey, err);
-			} else if (likely(can_wait)) {
+			} else if (can_wait) {
 				wait_for_completion(&req->inv_comp);
 			} else {
 				/*
@@ -463,7 +463,7 @@ static int rtrs_post_send_rdma(struct rtrs_clt_con *con,
 	enum ib_send_flags flags;
 	struct ib_sge sge;
 
-	if (unlikely(!req->sg_size)) {
+	if (!req->sg_size) {
 		rtrs_wrn(con->c.sess,
 			 "Doing RDMA Write failed, no data supplied\n");
 		return -EINVAL;
@@ -513,7 +513,7 @@ static void rtrs_clt_recv_done(struct rtrs_clt_con *con, struct ib_wc *wc)
 	iu = container_of(wc->wr_cqe, struct rtrs_iu,
 			  cqe);
 	err = rtrs_iu_post_recv(&con->c, iu);
-	if (unlikely(err)) {
+	if (err) {
 		rtrs_err(con->c.sess, "post iu failed %d\n", err);
 		rtrs_rdma_error_recovery(con);
 	}
@@ -533,7 +533,7 @@ static void rtrs_clt_rkey_rsp_done(struct rtrs_clt_con *con, struct ib_wc *wc)
 
 	iu = container_of(wc->wr_cqe, struct rtrs_iu, cqe);
 
-	if (unlikely(wc->byte_len < sizeof(*msg))) {
+	if (wc->byte_len < sizeof(*msg)) {
 		rtrs_err(con->c.sess, "rkey response is malformed: size %d\n",
 			  wc->byte_len);
 		goto out;
@@ -541,7 +541,7 @@ static void rtrs_clt_rkey_rsp_done(struct rtrs_clt_con *con, struct ib_wc *wc)
 	ib_dma_sync_single_for_cpu(sess->s.dev->ib_dev, iu->dma_addr,
 				   iu->size, DMA_FROM_DEVICE);
 	msg = iu->buf;
-	if (unlikely(le16_to_cpu(msg->type) != RTRS_MSG_RKEY_RSP)) {
+	if (le16_to_cpu(msg->type) != RTRS_MSG_RKEY_RSP) {
 		rtrs_err(sess->clt, "rkey response is malformed: type %d\n",
 			  le16_to_cpu(msg->type));
 		goto out;
@@ -551,8 +551,8 @@ static void rtrs_clt_rkey_rsp_done(struct rtrs_clt_con *con, struct ib_wc *wc)
 		goto out;
 
 	rtrs_from_imm(be32_to_cpu(wc->ex.imm_data), &imm_type, &imm_payload);
-	if (likely(imm_type == RTRS_IO_RSP_IMM ||
-		   imm_type == RTRS_IO_RSP_W_INV_IMM)) {
+	if (imm_type == RTRS_IO_RSP_IMM ||
+	    imm_type == RTRS_IO_RSP_W_INV_IMM) {
 		u32 msg_id;
 
 		w_inval = (imm_type == RTRS_IO_RSP_W_INV_IMM);
@@ -605,7 +605,7 @@ static void rtrs_clt_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 	bool w_inval = false;
 	int err;
 
-	if (unlikely(wc->status != IB_WC_SUCCESS)) {
+	if (wc->status != IB_WC_SUCCESS) {
 		if (wc->status != IB_WC_WR_FLUSH_ERR) {
 			rtrs_err(sess->clt, "RDMA failed: %s\n",
 				  ib_wc_status_msg(wc->status));
@@ -625,8 +625,8 @@ static void rtrs_clt_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 			return;
 		rtrs_from_imm(be32_to_cpu(wc->ex.imm_data),
 			       &imm_type, &imm_payload);
-		if (likely(imm_type == RTRS_IO_RSP_IMM ||
-			   imm_type == RTRS_IO_RSP_W_INV_IMM)) {
+		if (imm_type == RTRS_IO_RSP_IMM ||
+		    imm_type == RTRS_IO_RSP_W_INV_IMM) {
 			u32 msg_id;
 
 			w_inval = (imm_type == RTRS_IO_RSP_W_INV_IMM);
@@ -657,7 +657,7 @@ static void rtrs_clt_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 			err = rtrs_post_recv_empty_x2(&con->c, &io_comp_cqe);
 		else
 			err = rtrs_post_recv_empty(&con->c, &io_comp_cqe);
-		if (unlikely(err)) {
+		if (err) {
 			rtrs_err(con->c.sess, "rtrs_post_recv_empty(): %d\n",
 				  err);
 			rtrs_rdma_error_recovery(con);
@@ -703,7 +703,7 @@ static int post_recv_io(struct rtrs_clt_con *con, size_t q_size)
 		} else {
 			err = rtrs_post_recv_empty(&con->c, &io_comp_cqe);
 		}
-		if (unlikely(err))
+		if (err)
 			return err;
 	}
 
@@ -728,7 +728,7 @@ static int post_recv_sess(struct rtrs_clt_sess *sess)
 		q_size *= 2;
 
 		err = post_recv_io(to_clt_con(sess->s.con[cid]), q_size);
-		if (unlikely(err)) {
+		if (err) {
 			rtrs_err(sess->clt, "post_recv_io(), err: %d\n", err);
 			return err;
 		}
@@ -789,7 +789,7 @@ static struct rtrs_clt_sess *get_next_path_rr(struct path_it *it)
 
 	ppcpu_path = this_cpu_ptr(clt->pcpu_path);
 	path = rcu_dereference(*ppcpu_path);
-	if (unlikely(!path))
+	if (!path)
 		path = list_first_or_null_rcu(&clt->paths_list,
 					      typeof(*path), s.entry);
 	else
@@ -820,10 +820,10 @@ static struct rtrs_clt_sess *get_next_path_min_inflight(struct path_it *it)
 	int inflight;
 
 	list_for_each_entry_rcu(sess, &clt->paths_list, s.entry) {
-		if (unlikely(READ_ONCE(sess->state) != RTRS_CLT_CONNECTED))
+		if (READ_ONCE(sess->state) != RTRS_CLT_CONNECTED)
 			continue;
 
-		if (unlikely(!list_empty(raw_cpu_ptr(sess->mp_skip_entry))))
+		if (!list_empty(raw_cpu_ptr(sess->mp_skip_entry)))
 			continue;
 
 		inflight = atomic_read(&sess->stats->inflight);
@@ -871,10 +871,10 @@ static struct rtrs_clt_sess *get_next_path_min_latency(struct path_it *it)
 	ktime_t latency;
 
 	list_for_each_entry_rcu(sess, &clt->paths_list, s.entry) {
-		if (unlikely(READ_ONCE(sess->state) != RTRS_CLT_CONNECTED))
+		if (READ_ONCE(sess->state) != RTRS_CLT_CONNECTED)
 			continue;
 
-		if (unlikely(!list_empty(raw_cpu_ptr(sess->mp_skip_entry))))
+		if (!list_empty(raw_cpu_ptr(sess->mp_skip_entry)))
 			continue;
 
 		latency = sess->s.hb_cur_latency;
@@ -1063,7 +1063,7 @@ static int rtrs_map_sg_fr(struct rtrs_clt_io_req *req, size_t count)
 	nr = ib_map_mr_sg(req->mr, req->sglist, count, NULL, SZ_4K);
 	if (nr < 0)
 		return nr;
-	if (unlikely(nr < req->sg_cnt))
+	if (nr < req->sg_cnt)
 		return -EINVAL;
 	ib_update_fast_reg_key(req->mr, ib_inc_rkey(req->mr->rkey));
 
@@ -1087,7 +1087,7 @@ static int rtrs_clt_write_req(struct rtrs_clt_io_req *req)
 
 	const size_t tsize = sizeof(*msg) + req->data_len + req->usr_len;
 
-	if (unlikely(tsize > sess->chunk_size)) {
+	if (tsize > sess->chunk_size) {
 		rtrs_wrn(s, "Write request failed, size too big %zu > %d\n",
 			  tsize, sess->chunk_size);
 		return -EMSGSIZE;
@@ -1095,7 +1095,7 @@ static int rtrs_clt_write_req(struct rtrs_clt_io_req *req)
 	if (req->sg_cnt) {
 		count = ib_dma_map_sg(sess->s.dev->ib_dev, req->sglist,
 				      req->sg_cnt, req->dir);
-		if (unlikely(!count)) {
+		if (!count) {
 			rtrs_wrn(s, "Write request failed, map failed\n");
 			return -EINVAL;
 		}
@@ -1149,7 +1149,7 @@ static int rtrs_clt_write_req(struct rtrs_clt_io_req *req)
 	ret = rtrs_post_rdma_write_sg(req->con, req, rbuf, fr_en,
 				      req->usr_len + sizeof(*msg),
 				      imm, wr, &inv_wr);
-	if (unlikely(ret)) {
+	if (ret) {
 		rtrs_err_rl(s,
 			    "Write request failed: error=%d path=%s [%s:%u]\n",
 			    ret, kobject_name(&sess->kobj), sess->hca_name,
@@ -1180,7 +1180,7 @@ static int rtrs_clt_read_req(struct rtrs_clt_io_req *req)
 
 	const size_t tsize = sizeof(*msg) + req->data_len + req->usr_len;
 
-	if (unlikely(tsize > sess->chunk_size)) {
+	if (tsize > sess->chunk_size) {
 		rtrs_wrn(s,
 			  "Read request failed, message size is %zu, bigger than CHUNK_SIZE %d\n",
 			  tsize, sess->chunk_size);
@@ -1190,7 +1190,7 @@ static int rtrs_clt_read_req(struct rtrs_clt_io_req *req)
 	if (req->sg_cnt) {
 		count = ib_dma_map_sg(dev->ib_dev, req->sglist, req->sg_cnt,
 				      req->dir);
-		if (unlikely(!count)) {
+		if (!count) {
 			rtrs_wrn(s,
 				  "Read request failed, dma map failed\n");
 			return -EINVAL;
@@ -1255,7 +1255,7 @@ static int rtrs_clt_read_req(struct rtrs_clt_io_req *req)
 
 	ret = rtrs_post_send_rdma(req->con, req, &sess->rbufs[buf_id],
 				   req->data_len, imm, wr);
-	if (unlikely(ret)) {
+	if (ret) {
 		rtrs_err_rl(s,
 			    "Read request failed: error=%d path=%s [%s:%u]\n",
 			    ret, kobject_name(&sess->kobj), sess->hca_name,
@@ -1288,15 +1288,14 @@ static int rtrs_clt_failover_req(struct rtrs_clt *clt,
 	for (path_it_init(&it, clt);
 	     (alive_sess = it.next_path(&it)) && it.i < it.clt->paths_num;
 	     it.i++) {
-		if (unlikely(READ_ONCE(alive_sess->state) !=
-			     RTRS_CLT_CONNECTED))
+		if (READ_ONCE(alive_sess->state) != RTRS_CLT_CONNECTED)
 			continue;
 		req = rtrs_clt_get_copy_req(alive_sess, fail_req);
 		if (req->dir == DMA_TO_DEVICE)
 			err = rtrs_clt_write_req(req);
 		else
 			err = rtrs_clt_read_req(req);
-		if (unlikely(err)) {
+		if (err) {
 			req->in_use = false;
 			continue;
 		}
@@ -1331,7 +1330,7 @@ static void fail_all_outstanding_reqs(struct rtrs_clt_sess *sess)
 		complete_rdma_req(req, -ECONNABORTED, false, true);
 
 		err = rtrs_clt_failover_req(clt, req);
-		if (unlikely(err))
+		if (err)
 			/* Failover failed, notify anyway */
 			req->conf(req->priv, err);
 	}
@@ -1963,7 +1962,7 @@ static int rtrs_clt_rdma_cm_handler(struct rdma_cm_id *cm_id,
 		break;
 	case RDMA_CM_EVENT_ESTABLISHED:
 		cm_err = rtrs_rdma_conn_established(con, ev);
-		if (likely(!cm_err)) {
+		if (!cm_err) {
 			/*
 			 * Report success and wake up. Here we abuse state_wq,
 			 * i.e. wake up without state change, but we set cm_err.
@@ -2382,7 +2381,7 @@ static void rtrs_clt_info_req_done(struct ib_cq *cq, struct ib_wc *wc)
 	iu = container_of(wc->wr_cqe, struct rtrs_iu, cqe);
 	rtrs_iu_free(iu, sess->s.dev->ib_dev, 1);
 
-	if (unlikely(wc->status != IB_WC_SUCCESS)) {
+	if (wc->status != IB_WC_SUCCESS) {
 		rtrs_err(sess->clt, "Sess info request send failed: %s\n",
 			  ib_wc_status_msg(wc->status));
 		rtrs_clt_change_state_get_old(sess, RTRS_CLT_CONNECTING_ERR, NULL);
@@ -2399,7 +2398,7 @@ static int process_info_rsp(struct rtrs_clt_sess *sess,
 	int i, sgi;
 
 	sg_cnt = le16_to_cpu(msg->sg_cnt);
-	if (unlikely(!sg_cnt || (sess->queue_depth % sg_cnt))) {
+	if (!sg_cnt || (sess->queue_depth % sg_cnt)) {
 		rtrs_err(sess->clt, "Incorrect sg_cnt %d, is not multiple\n",
 			  sg_cnt);
 		return -EINVAL;
@@ -2409,9 +2408,8 @@ static int process_info_rsp(struct rtrs_clt_sess *sess,
 	 * Check if IB immediate data size is enough to hold the mem_id and
 	 * the offset inside the memory chunk.
 	 */
-	if (unlikely((ilog2(sg_cnt - 1) + 1) +
-		     (ilog2(sess->chunk_size - 1) + 1) >
-		     MAX_IMM_PAYL_BITS)) {
+	if ((ilog2(sg_cnt - 1) + 1) + (ilog2(sess->chunk_size - 1) + 1) >
+	    MAX_IMM_PAYL_BITS) {
 		rtrs_err(sess->clt,
 			  "RDMA immediate size (%db) not enough to encode %d buffers of size %dB\n",
 			  MAX_IMM_PAYL_BITS, sg_cnt, sess->chunk_size);
@@ -2429,7 +2427,7 @@ static int process_info_rsp(struct rtrs_clt_sess *sess,
 
 		total_len += len;
 
-		if (unlikely(!len || (len % sess->chunk_size))) {
+		if (!len || (len % sess->chunk_size)) {
 			rtrs_err(sess->clt, "Incorrect [%d].len %d\n", sgi,
 				  len);
 			return -EINVAL;
@@ -2443,11 +2441,11 @@ static int process_info_rsp(struct rtrs_clt_sess *sess,
 		}
 	}
 	/* Sanity check */
-	if (unlikely(sgi != sg_cnt || i != sess->queue_depth)) {
+	if (sgi != sg_cnt || i != sess->queue_depth) {
 		rtrs_err(sess->clt, "Incorrect sg vector, not fully mapped\n");
 		return -EINVAL;
 	}
-	if (unlikely(total_len != sess->chunk_size * sess->queue_depth)) {
+	if (total_len != sess->chunk_size * sess->queue_depth) {
 		rtrs_err(sess->clt, "Incorrect total_len %d\n", total_len);
 		return -EINVAL;
 	}
@@ -2469,14 +2467,14 @@ static void rtrs_clt_info_rsp_done(struct ib_cq *cq, struct ib_wc *wc)
 
 	WARN_ON(con->c.cid);
 	iu = container_of(wc->wr_cqe, struct rtrs_iu, cqe);
-	if (unlikely(wc->status != IB_WC_SUCCESS)) {
+	if (wc->status != IB_WC_SUCCESS) {
 		rtrs_err(sess->clt, "Sess info response recv failed: %s\n",
 			  ib_wc_status_msg(wc->status));
 		goto out;
 	}
 	WARN_ON(wc->opcode != IB_WC_RECV);
 
-	if (unlikely(wc->byte_len < sizeof(*msg))) {
+	if (wc->byte_len < sizeof(*msg)) {
 		rtrs_err(sess->clt, "Sess info response is malformed: size %d\n",
 			  wc->byte_len);
 		goto out;
@@ -2484,24 +2482,24 @@ static void rtrs_clt_info_rsp_done(struct ib_cq *cq, struct ib_wc *wc)
 	ib_dma_sync_single_for_cpu(sess->s.dev->ib_dev, iu->dma_addr,
 				   iu->size, DMA_FROM_DEVICE);
 	msg = iu->buf;
-	if (unlikely(le16_to_cpu(msg->type) != RTRS_MSG_INFO_RSP)) {
+	if (le16_to_cpu(msg->type) != RTRS_MSG_INFO_RSP) {
 		rtrs_err(sess->clt, "Sess info response is malformed: type %d\n",
 			  le16_to_cpu(msg->type));
 		goto out;
 	}
 	rx_sz  = sizeof(*msg);
 	rx_sz += sizeof(msg->desc[0]) * le16_to_cpu(msg->sg_cnt);
-	if (unlikely(wc->byte_len < rx_sz)) {
+	if (wc->byte_len < rx_sz) {
 		rtrs_err(sess->clt, "Sess info response is malformed: size %d\n",
 			  wc->byte_len);
 		goto out;
 	}
 	err = process_info_rsp(sess, msg);
-	if (unlikely(err))
+	if (err)
 		goto out;
 
 	err = post_recv_sess(sess);
-	if (unlikely(err))
+	if (err)
 		goto out;
 
 	state = RTRS_CLT_CONNECTED;
@@ -2528,13 +2526,13 @@ static int rtrs_send_sess_info(struct rtrs_clt_sess *sess)
 			       rtrs_clt_info_req_done);
 	rx_iu = rtrs_iu_alloc(1, rx_sz, GFP_KERNEL, sess->s.dev->ib_dev,
 			       DMA_FROM_DEVICE, rtrs_clt_info_rsp_done);
-	if (unlikely(!tx_iu || !rx_iu)) {
+	if (!tx_iu || !rx_iu) {
 		err = -ENOMEM;
 		goto out;
 	}
 	/* Prepare for getting info response */
 	err = rtrs_iu_post_recv(&usr_con->c, rx_iu);
-	if (unlikely(err)) {
+	if (err) {
 		rtrs_err(sess->clt, "rtrs_iu_post_recv(), err: %d\n", err);
 		goto out;
 	}
@@ -2549,7 +2547,7 @@ static int rtrs_send_sess_info(struct rtrs_clt_sess *sess)
 
 	/* Send info request */
 	err = rtrs_iu_post_send(&usr_con->c, tx_iu, sizeof(*msg), NULL);
-	if (unlikely(err)) {
+	if (err) {
 		rtrs_err(sess->clt, "rtrs_iu_post_send(), err: %d\n", err);
 		goto out;
 	}
@@ -2560,7 +2558,7 @@ static int rtrs_send_sess_info(struct rtrs_clt_sess *sess)
 					 sess->state != RTRS_CLT_CONNECTING,
 					 msecs_to_jiffies(
 						 RTRS_CONNECT_TIMEOUT_MS));
-	if (unlikely(READ_ONCE(sess->state) != RTRS_CLT_CONNECTED)) {
+	if (READ_ONCE(sess->state) != RTRS_CLT_CONNECTED) {
 		if (READ_ONCE(sess->state) == RTRS_CLT_CONNECTING_ERR)
 			err = -ECONNRESET;
 		else
@@ -2572,7 +2570,7 @@ static int rtrs_send_sess_info(struct rtrs_clt_sess *sess)
 		rtrs_iu_free(tx_iu, sess->s.dev->ib_dev, 1);
 	if (rx_iu)
 		rtrs_iu_free(rx_iu, sess->s.dev->ib_dev, 1);
-	if (unlikely(err))
+	if (err)
 		/* If we've never taken async path because of malloc problems */
 		rtrs_clt_change_state_get_old(sess, RTRS_CLT_CONNECTING_ERR, NULL);
 
@@ -2920,7 +2918,7 @@ int rtrs_clt_remove_path_from_sysfs(struct rtrs_clt_sess *sess,
 							&old_state);
 	} while (!changed && old_state != RTRS_CLT_DEAD);
 
-	if (likely(changed)) {
+	if (changed) {
 		rtrs_clt_remove_path_from_arr(sess);
 		rtrs_clt_destroy_sess_files(sess, sysfs_self);
 		kobject_put(&sess->kobj);
@@ -2992,10 +2990,10 @@ int rtrs_clt_request(int dir, struct rtrs_clt_req_ops *ops,
 	rcu_read_lock();
 	for (path_it_init(&it, clt);
 	     (sess = it.next_path(&it)) && it.i < it.clt->paths_num; it.i++) {
-		if (unlikely(READ_ONCE(sess->state) != RTRS_CLT_CONNECTED))
+		if (READ_ONCE(sess->state) != RTRS_CLT_CONNECTED)
 			continue;
 
-		if (unlikely(usr_len + hdr_len > sess->max_hdr_size)) {
+		if (usr_len + hdr_len > sess->max_hdr_size) {
 			rtrs_wrn_rl(sess->clt,
 				     "%s request failed, user message size is %zu and header length %zu, but max size is %u\n",
 				     dir == READ ? "Read" : "Write",
@@ -3010,7 +3008,7 @@ int rtrs_clt_request(int dir, struct rtrs_clt_req_ops *ops,
 			err = rtrs_clt_read_req(req);
 		else
 			err = rtrs_clt_write_req(req);
-		if (unlikely(err)) {
+		if (err) {
 			req->in_use = false;
 			continue;
 		}
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 47775987f91a..12215a78cc58 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -183,7 +183,7 @@ static void rtrs_srv_reg_mr_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct rtrs_sess *s = con->c.sess;
 	struct rtrs_srv_sess *sess = to_srv_sess(s);
 
-	if (unlikely(wc->status != IB_WC_SUCCESS)) {
+	if (wc->status != IB_WC_SUCCESS) {
 		rtrs_err(s, "REG MR failed: %s\n",
 			  ib_wc_status_msg(wc->status));
 		close_sess(sess);
@@ -215,7 +215,7 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
 
 	sg_cnt = le16_to_cpu(id->rd_msg->sg_cnt);
 	need_inval = le16_to_cpu(id->rd_msg->flags) & RTRS_MSG_NEED_INVAL_F;
-	if (unlikely(sg_cnt != 1))
+	if (sg_cnt != 1)
 		return -EINVAL;
 
 	offset = 0;
@@ -228,7 +228,7 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
 	/* WR will fail with length error
 	 * if this is 0
 	 */
-	if (unlikely(plist->length == 0)) {
+	if (plist->length == 0) {
 		rtrs_err(s, "Invalid RDMA-Write sg list length 0\n");
 		return -EINVAL;
 	}
@@ -321,7 +321,7 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
 				      offset, DMA_BIDIRECTIONAL);
 
 	err = ib_post_send(id->con->c.qp, &id->tx_wr.wr, NULL);
-	if (unlikely(err))
+	if (err)
 		rtrs_err(s,
 			  "Posting RDMA-Write-Request to QP failed, err: %d\n",
 			  err);
@@ -361,7 +361,7 @@ static int send_io_resp_imm(struct rtrs_srv_con *con, struct rtrs_srv_op *id,
 		sg_cnt = le16_to_cpu(rd_msg->sg_cnt);
 
 		if (need_inval) {
-			if (likely(sg_cnt)) {
+			if (sg_cnt) {
 				inv_wr.wr_cqe   = &io_comp_cqe;
 				inv_wr.sg_list = NULL;
 				inv_wr.num_sge = 0;
@@ -437,7 +437,7 @@ static int send_io_resp_imm(struct rtrs_srv_con *con, struct rtrs_srv_op *id,
 	imm_wr.wr.ex.imm_data = cpu_to_be32(imm);
 
 	err = ib_post_send(id->con->c.qp, wr, NULL);
-	if (unlikely(err))
+	if (err)
 		rtrs_err_rl(s, "Posting RDMA-Reply to QP failed, err: %d\n",
 			     err);
 
@@ -494,7 +494,7 @@ bool rtrs_srv_resp_rdma(struct rtrs_srv_op *id, int status)
 
 	id->status = status;
 
-	if (unlikely(sess->state != RTRS_SRV_CONNECTED)) {
+	if (sess->state != RTRS_SRV_CONNECTED) {
 		rtrs_err_rl(s,
 			    "Sending I/O response failed,  session %s is disconnected, sess state %s\n",
 			    kobject_name(&sess->kobj),
@@ -506,8 +506,7 @@ bool rtrs_srv_resp_rdma(struct rtrs_srv_op *id, int status)
 
 		ib_update_fast_reg_key(mr->mr, ib_inc_rkey(mr->mr->rkey));
 	}
-	if (unlikely(atomic_sub_return(1,
-				       &con->c.sq_wr_avail) < 0)) {
+	if (atomic_sub_return(1, &con->c.sq_wr_avail) < 0) {
 		rtrs_err(s, "IB send queue full: sess=%s cid=%d\n",
 			 kobject_name(&sess->kobj),
 			 con->c.cid);
@@ -523,7 +522,7 @@ bool rtrs_srv_resp_rdma(struct rtrs_srv_op *id, int status)
 	else
 		err = rdma_write_sg(id);
 
-	if (unlikely(err)) {
+	if (err) {
 		rtrs_err_rl(s, "IO response failed: %d: sess=%s\n", err,
 			    kobject_name(&sess->kobj));
 		close_sess(sess);
@@ -710,7 +709,7 @@ static void rtrs_srv_info_rsp_done(struct ib_cq *cq, struct ib_wc *wc)
 	iu = container_of(wc->wr_cqe, struct rtrs_iu, cqe);
 	rtrs_iu_free(iu, sess->s.dev->ib_dev, 1);
 
-	if (unlikely(wc->status != IB_WC_SUCCESS)) {
+	if (wc->status != IB_WC_SUCCESS) {
 		rtrs_err(s, "Sess info response send failed: %s\n",
 			  ib_wc_status_msg(wc->status));
 		close_sess(sess);
@@ -799,7 +798,7 @@ static int process_info_req(struct rtrs_srv_con *con,
 	size_t tx_sz;
 
 	err = post_recv_sess(sess);
-	if (unlikely(err)) {
+	if (err) {
 		rtrs_err(s, "post_recv_sess(), err: %d\n", err);
 		return err;
 	}
@@ -812,14 +811,14 @@ static int process_info_req(struct rtrs_srv_con *con,
 	strscpy(sess->s.sessname, msg->sessname, sizeof(sess->s.sessname));
 
 	rwr = kcalloc(sess->mrs_num, sizeof(*rwr), GFP_KERNEL);
-	if (unlikely(!rwr))
+	if (!rwr)
 		return -ENOMEM;
 
 	tx_sz  = sizeof(*rsp);
 	tx_sz += sizeof(rsp->desc[0]) * sess->mrs_num;
 	tx_iu = rtrs_iu_alloc(1, tx_sz, GFP_KERNEL, sess->s.dev->ib_dev,
 			       DMA_TO_DEVICE, rtrs_srv_info_rsp_done);
-	if (unlikely(!tx_iu)) {
+	if (!tx_iu) {
 		err = -ENOMEM;
 		goto rwr_free;
 	}
@@ -851,7 +850,7 @@ static int process_info_req(struct rtrs_srv_con *con,
 	}
 
 	err = rtrs_srv_create_sess_files(sess);
-	if (unlikely(err))
+	if (err)
 		goto iu_free;
 	kobject_get(&sess->kobj);
 	get_device(&sess->srv->dev);
@@ -871,7 +870,7 @@ static int process_info_req(struct rtrs_srv_con *con,
 
 	/* Send info response */
 	err = rtrs_iu_post_send(&con->c, tx_iu, tx_sz, reg_wr);
-	if (unlikely(err)) {
+	if (err) {
 		rtrs_err(s, "rtrs_iu_post_send(), err: %d\n", err);
 iu_free:
 		rtrs_iu_free(tx_iu, sess->s.dev->ib_dev, 1);
@@ -894,14 +893,14 @@ static void rtrs_srv_info_req_done(struct ib_cq *cq, struct ib_wc *wc)
 	WARN_ON(con->c.cid);
 
 	iu = container_of(wc->wr_cqe, struct rtrs_iu, cqe);
-	if (unlikely(wc->status != IB_WC_SUCCESS)) {
+	if (wc->status != IB_WC_SUCCESS) {
 		rtrs_err(s, "Sess info request receive failed: %s\n",
 			  ib_wc_status_msg(wc->status));
 		goto close;
 	}
 	WARN_ON(wc->opcode != IB_WC_RECV);
 
-	if (unlikely(wc->byte_len < sizeof(*msg))) {
+	if (wc->byte_len < sizeof(*msg)) {
 		rtrs_err(s, "Sess info request is malformed: size %d\n",
 			  wc->byte_len);
 		goto close;
@@ -909,13 +908,13 @@ static void rtrs_srv_info_req_done(struct ib_cq *cq, struct ib_wc *wc)
 	ib_dma_sync_single_for_cpu(sess->s.dev->ib_dev, iu->dma_addr,
 				   iu->size, DMA_FROM_DEVICE);
 	msg = iu->buf;
-	if (unlikely(le16_to_cpu(msg->type) != RTRS_MSG_INFO_REQ)) {
+	if (le16_to_cpu(msg->type) != RTRS_MSG_INFO_REQ) {
 		rtrs_err(s, "Sess info request is malformed: type %d\n",
 			  le16_to_cpu(msg->type));
 		goto close;
 	}
 	err = process_info_req(con, msg);
-	if (unlikely(err))
+	if (err)
 		goto close;
 
 out:
@@ -936,11 +935,11 @@ static int post_recv_info_req(struct rtrs_srv_con *con)
 	rx_iu = rtrs_iu_alloc(1, sizeof(struct rtrs_msg_info_req),
 			       GFP_KERNEL, sess->s.dev->ib_dev,
 			       DMA_FROM_DEVICE, rtrs_srv_info_req_done);
-	if (unlikely(!rx_iu))
+	if (!rx_iu)
 		return -ENOMEM;
 	/* Prepare for getting info response */
 	err = rtrs_iu_post_recv(&con->c, rx_iu);
-	if (unlikely(err)) {
+	if (err) {
 		rtrs_err(s, "rtrs_iu_post_recv(), err: %d\n", err);
 		rtrs_iu_free(rx_iu, sess->s.dev->ib_dev, 1);
 		return err;
@@ -955,7 +954,7 @@ static int post_recv_io(struct rtrs_srv_con *con, size_t q_size)
 
 	for (i = 0; i < q_size; i++) {
 		err = rtrs_post_recv_empty(&con->c, &io_comp_cqe);
-		if (unlikely(err))
+		if (err)
 			return err;
 	}
 
@@ -976,7 +975,7 @@ static int post_recv_sess(struct rtrs_srv_sess *sess)
 			q_size = srv->queue_depth;
 
 		err = post_recv_io(to_srv_con(sess->s.con[cid]), q_size);
-		if (unlikely(err)) {
+		if (err) {
 			rtrs_err(s, "post_recv_io(), err: %d\n", err);
 			return err;
 		}
@@ -999,13 +998,13 @@ static void process_read(struct rtrs_srv_con *con,
 	void *data;
 	int ret;
 
-	if (unlikely(sess->state != RTRS_SRV_CONNECTED)) {
+	if (sess->state != RTRS_SRV_CONNECTED) {
 		rtrs_err_rl(s,
 			     "Processing read request failed,  session is disconnected, sess state %s\n",
 			     rtrs_srv_state_str(sess->state));
 		return;
 	}
-	if (unlikely(msg->sg_cnt != 1 && msg->sg_cnt != 0)) {
+	if (msg->sg_cnt != 1 && msg->sg_cnt != 0) {
 		rtrs_err_rl(s,
 			    "Processing read request failed, invalid message\n");
 		return;
@@ -1023,7 +1022,7 @@ static void process_read(struct rtrs_srv_con *con,
 	ret = ctx->ops.rdma_ev(srv->priv, id, READ, data, data_len,
 			   data + data_len, usr_len);
 
-	if (unlikely(ret)) {
+	if (ret) {
 		rtrs_err_rl(s,
 			     "Processing read request failed, user module cb reported for msg_id %d, err: %d\n",
 			     buf_id, ret);
@@ -1057,7 +1056,7 @@ static void process_write(struct rtrs_srv_con *con,
 	void *data;
 	int ret;
 
-	if (unlikely(sess->state != RTRS_SRV_CONNECTED)) {
+	if (sess->state != RTRS_SRV_CONNECTED) {
 		rtrs_err_rl(s,
 			     "Processing write request failed,  session is disconnected, sess state %s\n",
 			     rtrs_srv_state_str(sess->state));
@@ -1074,8 +1073,8 @@ static void process_write(struct rtrs_srv_con *con,
 	data_len = off - usr_len;
 	data = page_address(srv->chunks[buf_id]);
 	ret = ctx->ops.rdma_ev(srv->priv, id, WRITE, data, data_len,
-			   data + data_len, usr_len);
-	if (unlikely(ret)) {
+			       data + data_len, usr_len);
+	if (ret) {
 		rtrs_err_rl(s,
 			     "Processing write request failed, user module callback reports err: %d\n",
 			     ret);
@@ -1139,7 +1138,7 @@ static void rtrs_srv_inv_rkey_done(struct ib_cq *cq, struct ib_wc *wc)
 	u32 msg_id, off;
 	void *data;
 
-	if (unlikely(wc->status != IB_WC_SUCCESS)) {
+	if (wc->status != IB_WC_SUCCESS) {
 		rtrs_err(s, "Failed IB_WR_LOCAL_INV: %s\n",
 			  ib_wc_status_msg(wc->status));
 		close_sess(sess);
@@ -1196,7 +1195,7 @@ static void rtrs_srv_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 	u32 imm_type, imm_payload;
 	int err;
 
-	if (unlikely(wc->status != IB_WC_SUCCESS)) {
+	if (wc->status != IB_WC_SUCCESS) {
 		if (wc->status != IB_WC_WR_FLUSH_ERR) {
 			rtrs_err(s,
 				  "%s (wr_cqe: %p, type: %d, vendor_err: 0x%x, len: %u)\n",
@@ -1216,21 +1215,20 @@ static void rtrs_srv_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 		if (WARN_ON(wc->wr_cqe != &io_comp_cqe))
 			return;
 		err = rtrs_post_recv_empty(&con->c, &io_comp_cqe);
-		if (unlikely(err)) {
+		if (err) {
 			rtrs_err(s, "rtrs_post_recv(), err: %d\n", err);
 			close_sess(sess);
 			break;
 		}
 		rtrs_from_imm(be32_to_cpu(wc->ex.imm_data),
 			       &imm_type, &imm_payload);
-		if (likely(imm_type == RTRS_IO_REQ_IMM)) {
+		if (imm_type == RTRS_IO_REQ_IMM) {
 			u32 msg_id, off;
 			void *data;
 
 			msg_id = imm_payload >> sess->mem_bits;
 			off = imm_payload & ((1 << sess->mem_bits) - 1);
-			if (unlikely(msg_id >= srv->queue_depth ||
-				     off >= max_chunk_size)) {
+			if (msg_id >= srv->queue_depth || off >= max_chunk_size) {
 				rtrs_err(s, "Wrong msg_id %u, off %u\n",
 					  msg_id, off);
 				close_sess(sess);
@@ -1242,7 +1240,7 @@ static void rtrs_srv_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 				mr->msg_off = off;
 				mr->msg_id = msg_id;
 				err = rtrs_srv_inv_rkey(con, mr);
-				if (unlikely(err)) {
+				if (err) {
 					rtrs_err(s, "rtrs_post_recv(), err: %d\n",
 						  err);
 					close_sess(sess);
@@ -1270,7 +1268,7 @@ static void rtrs_srv_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 		 */
 		atomic_add(s->signal_interval, &con->c.sq_wr_avail);
 
-		if (unlikely(!list_empty_careful(&con->rsp_wr_wait_list)))
+		if (!list_empty_careful(&con->rsp_wr_wait_list))
 			rtrs_rdma_process_wr_wait_list(con);
 
 		break;
-- 
2.25.1

