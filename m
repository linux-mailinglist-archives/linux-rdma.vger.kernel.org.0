Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5C8D127FDD
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2019 16:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfLTPvV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Dec 2019 10:51:21 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40971 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbfLTPvU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Dec 2019 10:51:20 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so9874808wrw.8;
        Fri, 20 Dec 2019 07:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pAgRONZTzPmjdJnTZLYRDoN1dIGAD24eZpRUdYYBTfU=;
        b=cGvpDHz5EvxuaOn9jJ8wuxavVEcidzMilTwTtYJL3+XzgYSZ+6NywG2qG0f3FAyJ13
         dNbiX6Ys00Y82Y9Lr0GOaS19hUQ4zy75ALWZ8pjccGORFJgvn2kCiJG4ydxyU/sOCLWf
         xliejD2f0DqwFbxU9iYwtPPmAGQtS1bVZn/sYWkMQGNr3wNQj5+uEYFNU6yOieE04cQl
         xsZ5ajbEoSwZ57hUHs5MZpvwa2ZfHxi95YnsmrOyxeoHd0IApMNm2adubLew5s0M9YZ0
         kjLB0J6BlNeGrlBDm01+FsIX2NVMsH4IfnblcKGtWrrQE23T6dJF7KUjTS8YqE5sDygC
         9Jdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pAgRONZTzPmjdJnTZLYRDoN1dIGAD24eZpRUdYYBTfU=;
        b=p/LkSZ4cE7+4f7xUfrJuY9un5MejJiDbnYIi9KNkjGk3UG2yT2UuJXiZ3hJ9KG5DkX
         EJ5m1ClTkCa05lunXA1Hfgu9dyLzjd4DAEfO2AZGcOy9T5oK6e4/cV4MN+WkzFZxzCkg
         J5Akqm/MYSwHyD9Y5WPbyFYGP9C01B3HAmcJRszh4JQO2ctkvN5dtO0jAjEWeSsFRJKV
         rks0OQVOH159v4mUnD41U3dzaIR3bPp/7frXoeU4VQ0pV1YbIGtCMbx8ojj48Q9YHNPr
         wnrovOZzZnt9LkuGYsbZJisEAM8kwvOQW6yLJPx4aLWB9cBvYMpWQmhlPt9QnA+yxmRP
         jA/w==
X-Gm-Message-State: APjAAAUMOtM74X9c+juybR3Ztcy8YjlpNYFv3377XHUaFBLYTKDgtbZE
        iDFuj8cD2y/X5V9+J1/tmipHQtddrSE=
X-Google-Smtp-Source: APXvYqzG8+l4z4CuuKZDkgoSYTnYfdvEXBD5cZ+cvpXYQVhDQ8dw40XNR4CoPWc24S4VrAMi7hc9Bw==
X-Received: by 2002:adf:e78a:: with SMTP id n10mr16673279wrm.62.1576857077097;
        Fri, 20 Dec 2019 07:51:17 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4972:cc00:b9e0:6ef7:286d:4897])
        by smtp.gmail.com with ESMTPSA id u14sm10372139wrm.51.2019.12.20.07.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 07:51:16 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de
Subject: [PATCH v5 04/25] rtrs: core: lib functions shared between client and server modules
Date:   Fri, 20 Dec 2019 16:50:48 +0100
Message-Id: <20191220155109.8959-5-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220155109.8959-1-jinpuwang@gmail.com>
References: <20191220155109.8959-1-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

This is a set of library functions existing as a rtrs-core module,
used by client and server modules.

Mainly these functions wrap IB and RDMA calls and provide a bit higher
abstraction for implementing of RTRS protocol on client or server
sides.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs.c | 646 +++++++++++++++++++++++++++++
 1 file changed, 646 insertions(+)
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs.c

diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
new file mode 100644
index 000000000000..34f4f641a935
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -0,0 +1,646 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * InfiniBand Transport Layer
+ *
+ * Copyright (c) 2014 - 2017 ProfitBricks GmbH. All rights reserved.
+ * Authors: Fabian Holler <mail@fholler.de>
+ *          Jack Wang <jinpu.wang@profitbricks.com>
+ *          Kleber Souza <kleber.souza@profitbricks.com>
+ *          Danil Kipnis <danil.kipnis@profitbricks.com>
+ *          Roman Penyaev <roman.penyaev@profitbricks.com>
+ *          Milind Dumbare <Milind.dumbare@gmail.com>
+ *
+ * Copyright (c) 2017 - 2018 ProfitBricks GmbH. All rights reserved.
+ * Authors: Danil Kipnis <danil.kipnis@profitbricks.com>
+ *          Roman Penyaev <roman.penyaev@profitbricks.com>
+ *
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ * Authors: Roman Penyaev <roman.penyaev@profitbricks.com>
+ *          Jinpu Wang <jinpu.wang@cloud.ionos.com>
+ *          Danil Kipnis <danil.kipnis@cloud.ionos.com>
+ */
+
+/* Copyright (c) 2019 1&1 IONOS SE. All rights reserved.
+ * Authors: Jack Wang <jinpu.wang@cloud.ionos.com>
+ *          Danil Kipnis <danil.kipnis@cloud.ionos.com>
+ *          Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
+ *          Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
+ */
+#undef pr_fmt
+#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
+
+#include <linux/module.h>
+#include <linux/inet.h>
+
+#include "rtrs-pri.h"
+#include "rtrs-log.h"
+
+MODULE_DESCRIPTION("RTRS Core");
+MODULE_LICENSE("GPL");
+
+struct rtrs_iu *rtrs_iu_alloc(u32 queue_size, size_t size, gfp_t gfp_mask,
+				struct ib_device *dma_dev,
+				enum dma_data_direction dir,
+				void (*done)(struct ib_cq *cq,
+					     struct ib_wc *wc))
+{
+	struct rtrs_iu *ius, *iu;
+	int i;
+
+	WARN_ON(!queue_size);
+	ius = kcalloc(queue_size, sizeof(*ius), gfp_mask);
+
+	if (unlikely(!ius))
+		return NULL;
+	for (i = 0; i < queue_size; i++) {
+		iu = &ius[i];
+		iu->buf = kzalloc(size, gfp_mask);
+		if (unlikely(!iu->buf))
+			goto err;
+
+		iu->dma_addr = ib_dma_map_single(dma_dev, iu->buf, size, dir);
+		if (unlikely(ib_dma_mapping_error(dma_dev, iu->dma_addr)))
+			goto err;
+
+		iu->cqe.done  = done;
+		iu->size      = size;
+		iu->direction = dir;
+	}
+
+	return ius;
+
+err:
+	rtrs_iu_free(ius, dir, dma_dev, i);
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(rtrs_iu_alloc);
+
+void rtrs_iu_free(struct rtrs_iu *ius, enum dma_data_direction dir,
+		   struct ib_device *ibdev, u32 queue_size)
+{
+	struct rtrs_iu *iu;
+	int i;
+
+	if (!ius)
+		return;
+
+	for (i = 0; i < queue_size; i++) {
+		iu = &ius[i];
+		ib_dma_unmap_single(ibdev, iu->dma_addr, iu->size, dir);
+		kfree(iu->buf);
+	}
+	kfree(ius);
+}
+EXPORT_SYMBOL_GPL(rtrs_iu_free);
+
+int rtrs_iu_post_recv(struct rtrs_con *con, struct rtrs_iu *iu)
+{
+	struct rtrs_sess *sess = con->sess;
+	struct ib_recv_wr wr;
+	const struct ib_recv_wr *bad_wr;
+	struct ib_sge list;
+
+	list.addr   = iu->dma_addr;
+	list.length = iu->size;
+	list.lkey   = sess->dev->ib_pd->local_dma_lkey;
+
+	if (WARN_ON(list.length == 0)) {
+		rtrs_wrn(con->sess,
+			  "Posting receive work request failed, sg list is empty\n");
+		return -EINVAL;
+	}
+
+	wr.next    = NULL;
+	wr.wr_cqe  = &iu->cqe;
+	wr.sg_list = &list;
+	wr.num_sge = 1;
+
+	return ib_post_recv(con->qp, &wr, &bad_wr);
+}
+EXPORT_SYMBOL_GPL(rtrs_iu_post_recv);
+
+int rtrs_post_recv_empty(struct rtrs_con *con, struct ib_cqe *cqe)
+{
+	struct ib_recv_wr wr;
+	const struct ib_recv_wr *bad_wr;
+
+	wr.next    = NULL;
+	wr.wr_cqe  = cqe;
+	wr.sg_list = NULL;
+	wr.num_sge = 0;
+
+	return ib_post_recv(con->qp, &wr, &bad_wr);
+}
+EXPORT_SYMBOL_GPL(rtrs_post_recv_empty);
+
+int rtrs_post_recv_empty_x2(struct rtrs_con *con, struct ib_cqe *cqe)
+{
+	struct ib_recv_wr wr_arr[2], *wr;
+	const struct ib_recv_wr *bad_wr;
+	int i;
+
+	memset(wr_arr, 0, sizeof(wr_arr));
+	for (i = 0; i < ARRAY_SIZE(wr_arr); i++) {
+		wr = &wr_arr[i];
+		wr->wr_cqe  = cqe;
+		if (i)
+			/* Chain backwards */
+			wr->next = &wr_arr[i - 1];
+	}
+
+	return ib_post_recv(con->qp, wr, &bad_wr);
+}
+EXPORT_SYMBOL_GPL(rtrs_post_recv_empty_x2);
+
+int rtrs_iu_post_send(struct rtrs_con *con, struct rtrs_iu *iu, size_t size,
+		       struct ib_send_wr *head)
+{
+	struct rtrs_sess *sess = con->sess;
+	struct ib_send_wr wr;
+	const struct ib_send_wr *bad_wr;
+	struct ib_sge list;
+
+	if ((WARN_ON(size == 0)))
+		return -EINVAL;
+
+	list.addr   = iu->dma_addr;
+	list.length = size;
+	list.lkey   = sess->dev->ib_pd->local_dma_lkey;
+
+	memset(&wr, 0, sizeof(wr));
+	wr.next       = NULL;
+	wr.wr_cqe     = &iu->cqe;
+	wr.sg_list    = &list;
+	wr.num_sge    = 1;
+	wr.opcode     = IB_WR_SEND;
+	wr.send_flags = IB_SEND_SIGNALED;
+
+	if (head) {
+		struct ib_send_wr *tail = head;
+
+		while (tail->next)
+			tail = tail->next;
+		tail->next = &wr;
+	} else {
+		head = &wr;
+	}
+
+	return ib_post_send(con->qp, head, &bad_wr);
+}
+EXPORT_SYMBOL_GPL(rtrs_iu_post_send);
+
+int rtrs_iu_post_rdma_write_imm(struct rtrs_con *con, struct rtrs_iu *iu,
+				 struct ib_sge *sge, unsigned int num_sge,
+				 u32 rkey, u64 rdma_addr, u32 imm_data,
+				 enum ib_send_flags flags,
+				 struct ib_send_wr *head)
+{
+	const struct ib_send_wr *bad_wr;
+	struct ib_rdma_wr wr;
+	int i;
+
+	wr.wr.next	  = NULL;
+	wr.wr.wr_cqe	  = &iu->cqe;
+	wr.wr.sg_list	  = sge;
+	wr.wr.num_sge	  = num_sge;
+	wr.rkey		  = rkey;
+	wr.remote_addr	  = rdma_addr;
+	wr.wr.opcode	  = IB_WR_RDMA_WRITE_WITH_IMM;
+	wr.wr.ex.imm_data = cpu_to_be32(imm_data);
+	wr.wr.send_flags  = flags;
+
+	/*
+	 * If one of the sges has 0 size, the operation will fail with an
+	 * length error
+	 */
+	for (i = 0; i < num_sge; i++)
+		if (WARN_ON(sge[i].length == 0))
+			return -EINVAL;
+
+	if (head) {
+		struct ib_send_wr *tail = head;
+
+		while (tail->next)
+			tail = tail->next;
+		tail->next = &wr.wr;
+	} else {
+		head = &wr.wr;
+	}
+
+	return ib_post_send(con->qp, head, &bad_wr);
+}
+EXPORT_SYMBOL_GPL(rtrs_iu_post_rdma_write_imm);
+
+int rtrs_post_rdma_write_imm_empty(struct rtrs_con *con, struct ib_cqe *cqe,
+				    u32 imm_data, enum ib_send_flags flags,
+				    struct ib_send_wr *head)
+{
+	struct ib_send_wr wr;
+	const struct ib_send_wr *bad_wr;
+
+	memset(&wr, 0, sizeof(wr));
+	wr.wr_cqe	= cqe;
+	wr.send_flags	= flags;
+	wr.opcode	= IB_WR_RDMA_WRITE_WITH_IMM;
+	wr.ex.imm_data	= cpu_to_be32(imm_data);
+
+	if (head) {
+		struct ib_send_wr *tail = head;
+
+		while (tail->next)
+			tail = tail->next;
+		tail->next = &wr;
+	} else {
+		head = &wr;
+	}
+
+	return ib_post_send(con->qp, head, &bad_wr);
+}
+EXPORT_SYMBOL_GPL(rtrs_post_rdma_write_imm_empty);
+
+static void qp_event_handler(struct ib_event *ev, void *ctx)
+{
+	struct rtrs_con *con = ctx;
+
+	switch (ev->event) {
+	case IB_EVENT_COMM_EST:
+		rtrs_info(con->sess, "QP event %s (%d) received\n",
+			   ib_event_msg(ev->event), ev->event);
+		rdma_notify(con->cm_id, IB_EVENT_COMM_EST);
+		break;
+	default:
+		rtrs_info(con->sess, "Unhandled QP event %s (%d) received\n",
+			   ib_event_msg(ev->event), ev->event);
+		break;
+	}
+}
+
+static int create_cq(struct rtrs_con *con, int cq_vector, u16 cq_size,
+		     enum ib_poll_context poll_ctx)
+{
+	struct rdma_cm_id *cm_id = con->cm_id;
+	struct ib_cq *cq;
+
+	cq = ib_alloc_cq(cm_id->device, con, cq_size,
+			 cq_vector, poll_ctx);
+	if (IS_ERR(cq)) {
+		rtrs_err(con->sess, "Creating completion queue failed, errno: %ld\n",
+			  PTR_ERR(cq));
+		return PTR_ERR(cq);
+	}
+	con->cq = cq;
+
+	return 0;
+}
+
+static int create_qp(struct rtrs_con *con, struct ib_pd *pd,
+		     u16 wr_queue_size, u32 max_sge)
+{
+	struct ib_qp_init_attr init_attr = {NULL};
+	struct rdma_cm_id *cm_id = con->cm_id;
+	int ret;
+
+	init_attr.cap.max_send_wr = wr_queue_size;
+	init_attr.cap.max_recv_wr = wr_queue_size;
+	init_attr.cap.max_recv_sge = 1;
+	init_attr.event_handler = qp_event_handler;
+	init_attr.qp_context = con;
+#undef max_send_sge
+	init_attr.cap.max_send_sge = max_sge;
+
+	init_attr.qp_type = IB_QPT_RC;
+	init_attr.send_cq = con->cq;
+	init_attr.recv_cq = con->cq;
+	init_attr.sq_sig_type = IB_SIGNAL_REQ_WR;
+
+	ret = rdma_create_qp(cm_id, pd, &init_attr);
+	if (unlikely(ret)) {
+		rtrs_err(con->sess, "Creating QP failed, err: %d\n", ret);
+		return ret;
+	}
+	con->qp = cm_id->qp;
+
+	return ret;
+}
+
+int rtrs_cq_qp_create(struct rtrs_sess *sess, struct rtrs_con *con,
+		       u32 max_send_sge, int cq_vector, u16 cq_size,
+		       u16 wr_queue_size, enum ib_poll_context poll_ctx)
+{
+	int err;
+
+	err = create_cq(con, cq_vector, cq_size, poll_ctx);
+	if (unlikely(err))
+		return err;
+
+	err = create_qp(con, sess->dev->ib_pd, wr_queue_size, max_send_sge);
+	if (unlikely(err)) {
+		ib_free_cq(con->cq);
+		con->cq = NULL;
+		return err;
+	}
+	con->sess = sess;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rtrs_cq_qp_create);
+
+void rtrs_cq_qp_destroy(struct rtrs_con *con)
+{
+	if (con->qp) {
+		rdma_destroy_qp(con->cm_id);
+		con->qp = NULL;
+	}
+	if (con->cq) {
+		ib_free_cq(con->cq);
+		con->cq = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(rtrs_cq_qp_destroy);
+
+static void schedule_hb(struct rtrs_sess *sess)
+{
+	queue_delayed_work(sess->hb_wq, &sess->hb_dwork,
+			   msecs_to_jiffies(sess->hb_interval_ms));
+}
+
+void rtrs_send_hb_ack(struct rtrs_sess *sess)
+{
+	struct rtrs_con *usr_con = sess->con[0];
+	u32 imm;
+	int err;
+
+	imm = rtrs_to_imm(RTRS_HB_ACK_IMM, 0);
+	err = rtrs_post_rdma_write_imm_empty(usr_con, sess->hb_cqe, imm,
+					      IB_SEND_SIGNALED, NULL);
+	if (unlikely(err)) {
+		sess->hb_err_handler(usr_con);
+		return;
+	}
+}
+EXPORT_SYMBOL_GPL(rtrs_send_hb_ack);
+
+static void hb_work(struct work_struct *work)
+{
+	struct rtrs_con *usr_con;
+	struct rtrs_sess *sess;
+	u32 imm;
+	int err;
+
+	sess = container_of(to_delayed_work(work), typeof(*sess), hb_dwork);
+	usr_con = sess->con[0];
+
+	if (sess->hb_missed_cnt > sess->hb_missed_max) {
+		sess->hb_err_handler(usr_con);
+		return;
+	}
+	if (sess->hb_missed_cnt++) {
+		/* Reschedule work without sending hb */
+		schedule_hb(sess);
+		return;
+	}
+	imm = rtrs_to_imm(RTRS_HB_MSG_IMM, 0);
+	err = rtrs_post_rdma_write_imm_empty(usr_con, sess->hb_cqe, imm,
+					      IB_SEND_SIGNALED, NULL);
+	if (unlikely(err)) {
+		sess->hb_err_handler(usr_con);
+		return;
+	}
+
+	schedule_hb(sess);
+}
+
+void rtrs_init_hb(struct rtrs_sess *sess, struct ib_cqe *cqe,
+		   unsigned int interval_ms, unsigned int missed_max,
+		   rtrs_hb_handler_t *err_handler,
+		   struct workqueue_struct *wq)
+{
+	sess->hb_cqe = cqe;
+	sess->hb_interval_ms = interval_ms;
+	sess->hb_err_handler = err_handler;
+	sess->hb_wq = wq;
+	sess->hb_missed_max = missed_max;
+	sess->hb_missed_cnt = 0;
+	INIT_DELAYED_WORK(&sess->hb_dwork, hb_work);
+}
+EXPORT_SYMBOL_GPL(rtrs_init_hb);
+
+void rtrs_start_hb(struct rtrs_sess *sess)
+{
+	schedule_hb(sess);
+}
+EXPORT_SYMBOL_GPL(rtrs_start_hb);
+
+void rtrs_stop_hb(struct rtrs_sess *sess)
+{
+	cancel_delayed_work_sync(&sess->hb_dwork);
+	sess->hb_missed_cnt = 0;
+	sess->hb_missed_max = 0;
+}
+EXPORT_SYMBOL_GPL(rtrs_stop_hb);
+
+static int rtrs_str_gid_to_sockaddr(const char *addr, size_t len,
+				     short port, struct sockaddr_storage *dst)
+{
+	struct sockaddr_ib *dst_ib = (struct sockaddr_ib *)dst;
+	int ret;
+
+	/*
+	 * We can use some of the I6 functions since GID is a valid
+	 * IPv6 address format
+	 */
+	ret = in6_pton(addr, len, dst_ib->sib_addr.sib_raw, '\0', NULL);
+	if (ret == 0)
+		return -EINVAL;
+
+	dst_ib->sib_family = AF_IB;
+	/*
+	 * Use the same TCP server port number as the IB service ID
+	 * on the IB port space range
+	 */
+	dst_ib->sib_sid = cpu_to_be64(RDMA_IB_IP_PS_IB | port);
+	dst_ib->sib_sid_mask = cpu_to_be64(0xffffffffffffffffULL);
+	dst_ib->sib_pkey = cpu_to_be16(0xffff);
+
+	return 0;
+}
+
+/**
+ * rtrs_str_to_sockaddr() - Convert rtrs address string to sockaddr
+ * @addr:	String representation of an addr (IPv4, IPv6 or IB GID):
+ *              - "ip:192.168.1.1"
+ *              - "ip:fe80::200:5aee:feaa:20a2"
+ *              - "gid:fe80::200:5aee:feaa:20a2"
+ * @len:        String address length
+ * @port:	Destination port
+ * @dst:	Destination sockaddr structure
+ *
+ * Returns 0 if conversion successful. Non-zero on error.
+ */
+static int rtrs_str_to_sockaddr(const char *addr, size_t len,
+				 short port, struct sockaddr_storage *dst)
+{
+	if (strncmp(addr, "gid:", 4) == 0) {
+		return rtrs_str_gid_to_sockaddr(addr + 4, len - 4, port, dst);
+	} else if (strncmp(addr, "ip:", 3) == 0) {
+		char port_str[8];
+		char *cpy;
+		int err;
+
+		snprintf(port_str, sizeof(port_str), "%u", port);
+		cpy = kstrndup(addr + 3, len - 3, GFP_KERNEL);
+		err = cpy ? inet_pton_with_scope(&init_net, AF_UNSPEC,
+						 cpy, port_str, dst) : -ENOMEM;
+		kfree(cpy);
+
+		return err;
+	}
+	return -EPROTONOSUPPORT;
+}
+
+int sockaddr_to_str(const struct sockaddr *addr, char *buf, size_t len)
+{
+	int cnt;
+
+	switch (addr->sa_family) {
+	case AF_IB:
+		cnt = scnprintf(buf, len, "gid:%pI6",
+			&((struct sockaddr_ib *)addr)->sib_addr.sib_raw);
+		return cnt;
+	case AF_INET:
+		cnt = scnprintf(buf, len, "ip:%pI4",
+			&((struct sockaddr_in *)addr)->sin_addr);
+		return cnt;
+	case AF_INET6:
+		cnt = scnprintf(buf, len, "ip:%pI6c",
+			  &((struct sockaddr_in6 *)addr)->sin6_addr);
+		return cnt;
+	}
+	cnt = scnprintf(buf, len, "<invalid address family>");
+	pr_err("Invalid address family\n");
+	return cnt;
+}
+EXPORT_SYMBOL(sockaddr_to_str);
+
+int rtrs_addr_to_sockaddr(const char *str, size_t len, short port,
+			   struct rtrs_addr *addr)
+{
+	const char *d;
+	int ret;
+
+	d = strchr(str, ',');
+	if (!d)
+		d = strchr(str, '@');
+	if (d) {
+		if (rtrs_str_to_sockaddr(str, d - str, 0, addr->src))
+			return -EINVAL;
+		d += 1;
+		len -= d - str;
+		str  = d;
+
+	} else {
+		addr->src = NULL;
+	}
+	ret = rtrs_str_to_sockaddr(str, len, port, addr->dst);
+
+	return ret;
+}
+EXPORT_SYMBOL(rtrs_addr_to_sockaddr);
+
+void rtrs_ib_dev_pool_init(enum ib_pd_flags pd_flags,
+			    struct rtrs_ib_dev_pool *pool)
+{
+	WARN_ON(pool->ops && (!pool->ops->alloc ^ !pool->ops->free));
+	INIT_LIST_HEAD(&pool->list);
+	mutex_init(&pool->mutex);
+	pool->pd_flags = pd_flags;
+}
+EXPORT_SYMBOL(rtrs_ib_dev_pool_init);
+
+void rtrs_ib_dev_pool_deinit(struct rtrs_ib_dev_pool *pool)
+{
+	WARN_ON(!list_empty(&pool->list));
+}
+EXPORT_SYMBOL(rtrs_ib_dev_pool_deinit);
+
+static void dev_free(struct kref *ref)
+{
+	struct rtrs_ib_dev_pool *pool;
+	struct rtrs_ib_dev *dev;
+
+	dev = container_of(ref, typeof(*dev), ref);
+	pool = dev->pool;
+
+	mutex_lock(&pool->mutex);
+	list_del(&dev->entry);
+	mutex_unlock(&pool->mutex);
+
+	if (pool->ops && pool->ops->deinit)
+		pool->ops->deinit(dev);
+
+	ib_dealloc_pd(dev->ib_pd);
+
+	if (pool->ops && pool->ops->free)
+		pool->ops->free(dev);
+	else
+		kfree(dev);
+}
+
+int rtrs_ib_dev_put(struct rtrs_ib_dev *dev)
+{
+	return kref_put(&dev->ref, dev_free);
+}
+EXPORT_SYMBOL(rtrs_ib_dev_put);
+
+static int rtrs_ib_dev_get(struct rtrs_ib_dev *dev)
+{
+	return kref_get_unless_zero(&dev->ref);
+}
+
+struct rtrs_ib_dev *
+rtrs_ib_dev_find_or_add(struct ib_device *ib_dev,
+			 struct rtrs_ib_dev_pool *pool)
+{
+	struct rtrs_ib_dev *dev;
+
+	mutex_lock(&pool->mutex);
+	list_for_each_entry(dev, &pool->list, entry) {
+		if (dev->ib_dev->node_guid == ib_dev->node_guid &&
+		    rtrs_ib_dev_get(dev))
+			goto out_unlock;
+	}
+	if (pool->ops && pool->ops->alloc)
+		dev = pool->ops->alloc();
+	else
+		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (IS_ERR_OR_NULL(dev))
+		goto out_err;
+
+	kref_init(&dev->ref);
+	dev->pool = pool;
+	dev->ib_dev = ib_dev;
+	dev->ib_pd = ib_alloc_pd(ib_dev, pool->pd_flags);
+	if (IS_ERR(dev->ib_pd))
+		goto out_free_dev;
+
+	if (pool->ops && pool->ops->init && pool->ops->init(dev))
+		goto out_free_pd;
+
+	list_add(&dev->entry, &pool->list);
+out_unlock:
+	mutex_unlock(&pool->mutex);
+	return dev;
+
+out_free_pd:
+	ib_dealloc_pd(dev->ib_pd);
+out_free_dev:
+	if (pool->ops && pool->ops->free)
+		pool->ops->free(dev);
+	else
+		kfree(dev);
+out_err:
+	mutex_unlock(&pool->mutex);
+	return NULL;
+}
+EXPORT_SYMBOL(rtrs_ib_dev_find_or_add);
-- 
2.17.1

