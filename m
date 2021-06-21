Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208323AE2E9
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 07:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbhFUF4A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 01:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhFUF4A (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Jun 2021 01:56:00 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E397C061574
        for <linux-rdma@vger.kernel.org>; Sun, 20 Jun 2021 22:53:46 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id he7so26654134ejc.13
        for <linux-rdma@vger.kernel.org>; Sun, 20 Jun 2021 22:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q5bXPaqmBwIoabJmXLGVr4RYXtam5ir9ZN5A2rRLSgI=;
        b=PleOQRUdqY7Z8x0zCO1+zdG63jCAR+Uz6qoV6MrIqYnoI0WBAGwQEXtWrD3wY29l+L
         tNA27ecRpg9PKkKqQzi/s2XUKYm1HnpVQQHe76jn0CkTJNGgSDdFmCjTVBDWnaQIfmy1
         ZbgMiPykLLSQUuBy3yauFT9NpYB8fyhXbn0xFBUr0EFTAhq0DqbUgVZlWhK+Rl6xxYPg
         STLiswuByFJhfVpmdu/WYhWaYMYWU3gj6RD29MSka6IPgLqh/TbJWlWsRGEv4Ja8bc9a
         1BcZw40NPlNU7+oOPOgyLAPtBQg2tqw/9xM46JuJlnqBYotR0DhIAs0tRkan5F8drqlI
         BMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q5bXPaqmBwIoabJmXLGVr4RYXtam5ir9ZN5A2rRLSgI=;
        b=g3LlH0HUB3lv/g+5IkNpJ6FcqYA4s0tTGoxkWqmJhrSA0TKIpqTA4PGd6ta9PreXiS
         5/wREbaaFY2YpjfpPTmlL3V9QeJ8iAR+DPCGAsJM6J1GZjJb8eyrfqN46qEEuEi2fuc4
         VlmQAvxX48Ok3KujWLaJJfTEX9NlWIjF6QrJiXK3IZYSTFaXiFKMYG+0EmOc264HSEpI
         XmiBHGLlBed/3JO6h6oXesSWa1aJANedyyNE7pEv9OPL4hOOAN5DgvQZ5mOyxOk5zEgK
         DVUVvi9L7m9Q4indgfLYLgHK8s/p8+5li+qkITGw3fXAaYlYHsLmJrlD+rY3SQWG6FoE
         e+RA==
X-Gm-Message-State: AOAM531krhjRsgeQKxpsFSpeC8yIG19nt68CLuKePBdlbmsf9iu1r81/
        ziE4/yWA5DQpXztH2jmB1TJpZIhkvklMNA==
X-Google-Smtp-Source: ABdhPJz3NbJCQ2a//c26TFZNSwGMUkuFQFgb2jNvXNSKI1PKV2e+vIMBWEfPVs0qvP9Q7R0DbRl5aw==
X-Received: by 2002:a17:906:3ed0:: with SMTP id d16mr22414785ejj.16.1624254824917;
        Sun, 20 Jun 2021 22:53:44 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:49f3:be00:dc22:f90e:1d6c:a47])
        by smtp.gmail.com with ESMTPSA id i18sm1919617edc.7.2021.06.20.22.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 22:53:44 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, axboe@kernel.dk, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, Jack Wang <jinpu.wang@cloud.ionos.com>,
        Dima Stepanov <dmitrii.stepanov@ionos.com>
Subject: [PATCH resend for-next 2/5] RDMA/rtrs-clt: Write path fast memory registration
Date:   Mon, 21 Jun 2021 07:53:37 +0200
Message-Id: <20210621055340.11789-3-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210621055340.11789-1-jinpu.wang@ionos.com>
References: <20210621055340.11789-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

With fast memory registration in write path, we can reduce
the memory consumption by using less max_send_sge, support IO bigger
than 116 KB (29 segments * 4 KB) without splitting, and it also
make the IO path more symmetric.

To avoid some times MR reg failed, waiting for the invalidation to finish
before the new mr reg. Introduce a refcount, only finish the request
when both local invalidation and io reply are there.

Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Dima Stepanov <dmitrii.stepanov@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 100 ++++++++++++++++++-------
 drivers/infiniband/ulp/rtrs/rtrs-clt.h |   1 +
 2 files changed, 74 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 6b078e0df1fd..87edcec3e9e3 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -412,6 +412,7 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
 				req->inv_errno = errno;
 			}
 
+			refcount_inc(&req->ref);
 			err = rtrs_inv_rkey(req);
 			if (unlikely(err)) {
 				rtrs_err(con->c.sess, "Send INV WR key=%#x: %d\n",
@@ -427,10 +428,14 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
 
 				return;
 			}
+			if (!refcount_dec_and_test(&req->ref))
+				return;
 		}
 		ib_dma_unmap_sg(sess->s.dev->ib_dev, req->sglist,
 				req->sg_cnt, req->dir);
 	}
+	if (!refcount_dec_and_test(&req->ref))
+		return;
 	if (sess->clt->mp_policy == MP_POLICY_MIN_INFLIGHT)
 		atomic_dec(&sess->stats->inflight);
 
@@ -438,10 +443,9 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
 	req->con = NULL;
 
 	if (errno) {
-		rtrs_err_rl(con->c.sess,
-			    "IO request failed: error=%d path=%s [%s:%u]\n",
+		rtrs_err_rl(con->c.sess, "IO request failed: error=%d path=%s [%s:%u] notify=%d\n",
 			    errno, kobject_name(&sess->kobj), sess->hca_name,
-			    sess->hca_port);
+			    sess->hca_port, notify);
 	}
 
 	if (notify)
@@ -956,6 +960,7 @@ static void rtrs_clt_init_req(struct rtrs_clt_io_req *req,
 	req->need_inv = false;
 	req->need_inv_comp = false;
 	req->inv_errno = 0;
+	refcount_set(&req->ref, 1);
 
 	iov_iter_kvec(&iter, READ, vec, 1, usr_len);
 	len = _copy_from_iter(req->iu->buf, usr_len, &iter);
@@ -1000,7 +1005,7 @@ rtrs_clt_get_copy_req(struct rtrs_clt_sess *alive_sess,
 
 static int rtrs_post_rdma_write_sg(struct rtrs_clt_con *con,
 				   struct rtrs_clt_io_req *req,
-				   struct rtrs_rbuf *rbuf,
+				   struct rtrs_rbuf *rbuf, bool fr_en,
 				   u32 size, u32 imm, struct ib_send_wr *wr,
 				   struct ib_send_wr *tail)
 {
@@ -1012,17 +1017,26 @@ static int rtrs_post_rdma_write_sg(struct rtrs_clt_con *con,
 	int i;
 	struct ib_send_wr *ptail = NULL;
 
-	for_each_sg(req->sglist, sg, req->sg_cnt, i) {
-		sge[i].addr   = sg_dma_address(sg);
-		sge[i].length = sg_dma_len(sg);
-		sge[i].lkey   = sess->s.dev->ib_pd->local_dma_lkey;
+	if (fr_en) {
+		i = 0;
+		sge[i].addr   = req->mr->iova;
+		sge[i].length = req->mr->length;
+		sge[i].lkey   = req->mr->lkey;
+		i++;
+		num_sge = 2;
+		ptail = tail;
+	} else {
+		for_each_sg(req->sglist, sg, req->sg_cnt, i) {
+			sge[i].addr   = sg_dma_address(sg);
+			sge[i].length = sg_dma_len(sg);
+			sge[i].lkey   = sess->s.dev->ib_pd->local_dma_lkey;
+		}
+		num_sge = 1 + req->sg_cnt;
 	}
 	sge[i].addr   = req->iu->dma_addr;
 	sge[i].length = size;
 	sge[i].lkey   = sess->s.dev->ib_pd->local_dma_lkey;
 
-	num_sge = 1 + req->sg_cnt;
-
 	/*
 	 * From time to time we have to post signalled sends,
 	 * or send queue will fill up and only QP reset can help.
@@ -1038,6 +1052,21 @@ static int rtrs_post_rdma_write_sg(struct rtrs_clt_con *con,
 					    flags, wr, ptail);
 }
 
+static int rtrs_map_sg_fr(struct rtrs_clt_io_req *req, size_t count)
+{
+	int nr;
+
+	/* Align the MR to a 4K page size to match the block virt boundary */
+	nr = ib_map_mr_sg(req->mr, req->sglist, count, NULL, SZ_4K);
+	if (nr < 0)
+		return nr;
+	if (unlikely(nr < req->sg_cnt))
+		return -EINVAL;
+	ib_update_fast_reg_key(req->mr, ib_inc_rkey(req->mr->rkey));
+
+	return nr;
+}
+
 static int rtrs_clt_write_req(struct rtrs_clt_io_req *req)
 {
 	struct rtrs_clt_con *con = req->con;
@@ -1048,6 +1077,10 @@ static int rtrs_clt_write_req(struct rtrs_clt_io_req *req)
 	struct rtrs_rbuf *rbuf;
 	int ret, count = 0;
 	u32 imm, buf_id;
+	struct ib_reg_wr rwr;
+	struct ib_send_wr inv_wr;
+	struct ib_send_wr *wr = NULL;
+	bool fr_en = false;
 
 	const size_t tsize = sizeof(*msg) + req->data_len + req->usr_len;
 
@@ -1076,15 +1109,43 @@ static int rtrs_clt_write_req(struct rtrs_clt_io_req *req)
 	req->sg_size = tsize;
 	rbuf = &sess->rbufs[buf_id];
 
+	if (count) {
+		ret = rtrs_map_sg_fr(req, count);
+		if (ret < 0) {
+			rtrs_err_rl(s,
+				    "Write request failed, failed to map fast reg. data, err: %d\n",
+				    ret);
+			ib_dma_unmap_sg(sess->s.dev->ib_dev, req->sglist,
+					req->sg_cnt, req->dir);
+			return ret;
+		}
+		inv_wr = (struct ib_send_wr) {
+			.opcode		    = IB_WR_LOCAL_INV,
+			.wr_cqe		    = &req->inv_cqe,
+			.send_flags	    = IB_SEND_SIGNALED,
+			.ex.invalidate_rkey = req->mr->rkey,
+		};
+		req->inv_cqe.done = rtrs_clt_inv_rkey_done;
+		rwr = (struct ib_reg_wr) {
+			.wr.opcode = IB_WR_REG_MR,
+			.wr.wr_cqe = &fast_reg_cqe,
+			.mr = req->mr,
+			.key = req->mr->rkey,
+			.access = (IB_ACCESS_LOCAL_WRITE),
+		};
+		wr = &rwr.wr;
+		fr_en = true;
+		refcount_inc(&req->ref);
+	}
 	/*
 	 * Update stats now, after request is successfully sent it is not
 	 * safe anymore to touch it.
 	 */
 	rtrs_clt_update_all_stats(req, WRITE);
 
-	ret = rtrs_post_rdma_write_sg(req->con, req, rbuf,
+	ret = rtrs_post_rdma_write_sg(req->con, req, rbuf, fr_en,
 				      req->usr_len + sizeof(*msg),
-				      imm, NULL, NULL);
+				      imm, wr, &inv_wr);
 	if (unlikely(ret)) {
 		rtrs_err_rl(s,
 			    "Write request failed: error=%d path=%s [%s:%u]\n",
@@ -1100,21 +1161,6 @@ static int rtrs_clt_write_req(struct rtrs_clt_io_req *req)
 	return ret;
 }
 
-static int rtrs_map_sg_fr(struct rtrs_clt_io_req *req, size_t count)
-{
-	int nr;
-
-	/* Align the MR to a 4K page size to match the block virt boundary */
-	nr = ib_map_mr_sg(req->mr, req->sglist, count, NULL, SZ_4K);
-	if (nr < 0)
-		return nr;
-	if (unlikely(nr < req->sg_cnt))
-		return -EINVAL;
-	ib_update_fast_reg_key(req->mr, ib_inc_rkey(req->mr->rkey));
-
-	return nr;
-}
-
 static int rtrs_clt_read_req(struct rtrs_clt_io_req *req)
 {
 	struct rtrs_clt_con *con = req->con;
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.h b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
index eed2a20ee9be..e276a2dfcf7c 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
@@ -116,6 +116,7 @@ struct rtrs_clt_io_req {
 	int			inv_errno;
 	bool			need_inv_comp;
 	bool			need_inv;
+	refcount_t		ref;
 };
 
 struct rtrs_rbuf {
-- 
2.25.1

