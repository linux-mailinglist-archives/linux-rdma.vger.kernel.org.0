Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9943C2AA0A2
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Nov 2020 00:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgKFXCI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Nov 2020 18:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728984AbgKFXCI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Nov 2020 18:02:08 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126E2C0613CF
        for <linux-rdma@vger.kernel.org>; Fri,  6 Nov 2020 15:02:08 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id j14so2842750ots.1
        for <linux-rdma@vger.kernel.org>; Fri, 06 Nov 2020 15:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mg9AOq8WW4NJR2c/Rp03Zik5skUnaXxKqf9eVJYc0UM=;
        b=F31+1QiZoexkM/TNMt1Guto0YkyhboxYamjvE6acKZ7Q0NrEN+tbzawDrFR7Wt32jq
         i392vqWlXmRNxWSNW2Sxxj77pCERlPCWXBz2Snnys2ovQTbalkbWozNb5EScn4+sKJgL
         D7ZFcp55f40VBXzei9NI/0zYmlZMdsCv7lKk9FEV+dKP2wYX8wI6MqXyVrEqKgxjzdnv
         eQ8DZYwGiJDQNebyLFhYBKplfz2uultNVAMu8qC5w/C2V9WUF7680BGaIlWCKdG5lfAp
         gFBJNFifV5RSsoJStEvmCZeuhKjkhPe6swrP3bvwitLGvHxpzNcSrPiSXArZfQcCqJYI
         UlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mg9AOq8WW4NJR2c/Rp03Zik5skUnaXxKqf9eVJYc0UM=;
        b=WcBA4UQ7IVE+AaKAIM2/c2fHGDFq02WGnIo6wI9QEv7IISwwQId2JUgs7nR6GEp/Xp
         x71+cDXWAGZTVma5IdLZUXX/ZJ5k8RkBA1+QHP2wtbOTA5NLzJDov/rNwowS63HL/Oaj
         Lja9mMXoUMHj3ZXzcNaEIGM6qDj5p33zls3oP+DdSyd6p5j1uigBJGisu3evCXbzjhNW
         rRUsIRMnvYuUPRYg73YAuS8f3yYnP0lumV4CmYEMDXhC1t4NQSYm6c1BHR7P+yRZfYBA
         RH3mDISVkJhUVAajoa0w3ky2Vh/c3x2w3RUkmM4QvvSJODYw+gfzmU+SLk8YNOjeLVQz
         QaiA==
X-Gm-Message-State: AOAM533StKTA+Bb8h1OrCdXfKsrPiZTqfV1KNDlcfsXpKKBmQMqebVq+
        M/9uUVML9MNziQHBDEN5di7SFXNJrXw=
X-Google-Smtp-Source: ABdhPJyVDwK9XYoyjmYLkyYE2Q9OzTPx++0cqchfV70lZd6cVk6FhVVNpYzdHGrpAMIqo2nJRm9E5g==
X-Received: by 2002:a05:6830:128b:: with SMTP id z11mr2730934otp.83.1604703727426;
        Fri, 06 Nov 2020 15:02:07 -0800 (PST)
Received: from localhost (2603-8081-140c-1a00-f960-8e80-5b89-d06d.res6.spectrum.com. [2603:8081:140c:1a00:f960:8e80:5b89:d06d])
        by smtp.gmail.com with ESMTPSA id h1sm631294oti.78.2020.11.06.15.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 15:02:07 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH 4/4] Providers/rxe: Implement ibv_create_qp_ex verb
Date:   Fri,  6 Nov 2020 17:01:22 -0600
Message-Id: <20201106230122.17411-5-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201106230122.17411-1-rpearson@hpe.com>
References: <20201106230122.17411-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add ibv_create_qp_ex verb.
Add WQ operations in verbs_qp struct.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 providers/rxe/rxe-abi.h   |   2 +
 providers/rxe/rxe.c       | 664 ++++++++++++++++++++++++++++++++++++--
 providers/rxe/rxe.h       |  10 +-
 providers/rxe/rxe_queue.h |  21 ++
 4 files changed, 667 insertions(+), 30 deletions(-)

diff --git a/providers/rxe/rxe-abi.h b/providers/rxe/rxe-abi.h
index 08bdb546..aa7700ed 100644
--- a/providers/rxe/rxe-abi.h
+++ b/providers/rxe/rxe-abi.h
@@ -47,6 +47,8 @@ DECLARE_DRV_CMD(urxe_create_cq_ex, IB_USER_VERBS_EX_CMD_CREATE_CQ,
 		rxe_create_cq_cmd, rxe_create_cq_resp);
 DECLARE_DRV_CMD(urxe_create_qp, IB_USER_VERBS_CMD_CREATE_QP,
 		empty, rxe_create_qp_resp);
+DECLARE_DRV_CMD(urxe_create_qp_ex, IB_USER_VERBS_EX_CMD_CREATE_QP,
+		empty, rxe_create_qp_resp);
 DECLARE_DRV_CMD(urxe_create_srq, IB_USER_VERBS_CMD_CREATE_SRQ,
 		empty, rxe_create_srq_resp);
 DECLARE_DRV_CMD(urxe_modify_srq, IB_USER_VERBS_CMD_MODIFY_SRQ,
diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
index 57f0c500..012db800 100644
--- a/providers/rxe/rxe.c
+++ b/providers/rxe/rxe.c
@@ -718,25 +718,638 @@ static int rxe_post_srq_recv(struct ibv_srq *ibvsrq,
 	return rc;
 }
 
-static struct ibv_qp *rxe_create_qp(struct ibv_pd *pd,
-				    struct ibv_qp_init_attr *attr)
+/*
+ * builders always consume one send queue slot
+ * setters (below) reach back and adjust previous build
+ */
+static void wr_atomic_cmp_swp(struct ibv_qp_ex *ibqp, uint32_t rkey,
+			      uint64_t remote_addr, uint64_t compare,
+			      uint64_t swap)
+{
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+	struct rxe_send_wqe *wqe = addr_from_index(qp->sq.queue, qp->cur_index);
+
+	if (check_qp_queue_full(qp))
+		return;
+
+	memset(wqe, 0, sizeof(*wqe));
+
+	wqe->wr.wr_id = ibqp->wr_id;
+	wqe->wr.send_flags = ibqp->wr_flags;
+	wqe->wr.opcode = IBV_WR_ATOMIC_CMP_AND_SWP;
+
+	wqe->wr.wr.atomic.remote_addr = remote_addr;
+	wqe->wr.wr.atomic.compare_add = compare;
+	wqe->wr.wr.atomic.swap = swap;
+	wqe->wr.wr.atomic.rkey = rkey;
+	wqe->iova = remote_addr;
+	wqe->ssn = qp->ssn++;;
+
+	advance_qp_cur_index(qp);
+
+	return;
+}
+
+static void wr_atomic_fetch_add(struct ibv_qp_ex *ibqp, uint32_t rkey,
+				uint64_t remote_addr, uint64_t add)
+{
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+	struct rxe_send_wqe *wqe = addr_from_index(qp->sq.queue, qp->cur_index);
+
+	if (check_qp_queue_full(qp))
+		return;
+
+	memset(wqe, 0, sizeof(*wqe));
+
+	wqe->wr.wr_id = qp->vqp.qp_ex.wr_id;
+	wqe->wr.opcode = IBV_WR_ATOMIC_FETCH_AND_ADD;
+	wqe->wr.send_flags = qp->vqp.qp_ex.wr_flags;
+	wqe->wr.wr.atomic.remote_addr = remote_addr;
+	wqe->wr.wr.atomic.compare_add = add;
+	wqe->wr.wr.atomic.rkey = rkey;
+	wqe->iova = remote_addr;
+	wqe->ssn = qp->ssn++;;
+
+	advance_qp_cur_index(qp);
+
+	return;
+}
+
+static void wr_local_inv(struct ibv_qp_ex *ibqp, uint32_t invalidate_rkey)
+{
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+	struct rxe_send_wqe *wqe = addr_from_index(qp->sq.queue, qp->cur_index);
+
+	if (check_qp_queue_full(qp))
+		return;
+
+	memset(wqe, 0, sizeof(*wqe));
+
+	wqe->wr.wr_id = qp->vqp.qp_ex.wr_id;
+	wqe->wr.opcode = IBV_WR_LOCAL_INV;
+	wqe->wr.send_flags = qp->vqp.qp_ex.wr_flags;
+	wqe->wr.ex.invalidate_rkey = invalidate_rkey;
+	wqe->ssn = qp->ssn++;;
+
+	advance_qp_cur_index(qp);
+
+	return;
+}
+
+static void wr_rdma_read(struct ibv_qp_ex *ibqp, uint32_t rkey,
+			 uint64_t remote_addr)
+{
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+	struct rxe_send_wqe *wqe = addr_from_index(qp->sq.queue, qp->cur_index);
+
+	if (check_qp_queue_full(qp))
+		return;
+
+	memset(wqe, 0, sizeof(*wqe));
+
+	wqe->wr.wr_id = qp->vqp.qp_ex.wr_id;
+	wqe->wr.opcode = IBV_WR_RDMA_READ;
+	wqe->wr.send_flags = qp->vqp.qp_ex.wr_flags;
+	wqe->wr.wr.rdma.remote_addr = remote_addr;
+	wqe->wr.wr.rdma.rkey = rkey;
+	wqe->iova = remote_addr;
+	wqe->ssn = qp->ssn++;;
+
+	advance_qp_cur_index(qp);
+
+	return;
+}
+
+static void wr_rdma_write(struct ibv_qp_ex *ibqp, uint32_t rkey,
+			  uint64_t remote_addr)
+{
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+	struct rxe_send_wqe *wqe = addr_from_index(qp->sq.queue, qp->cur_index);
+
+	if (check_qp_queue_full(qp))
+		return;
+
+	memset(wqe, 0, sizeof(*wqe));
+
+	wqe->wr.wr_id = qp->vqp.qp_ex.wr_id;
+	wqe->wr.opcode = IBV_WR_RDMA_WRITE;
+	wqe->wr.send_flags = qp->vqp.qp_ex.wr_flags;
+	wqe->wr.wr.rdma.remote_addr = remote_addr;
+	wqe->wr.wr.rdma.rkey = rkey;
+	wqe->iova = remote_addr;
+	wqe->ssn = qp->ssn++;;
+
+	advance_qp_cur_index(qp);
+
+	return;
+}
+
+static void wr_rdma_write_imm(struct ibv_qp_ex *ibqp, uint32_t rkey,
+			      uint64_t remote_addr, __be32 imm_data)
+{
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+	struct rxe_send_wqe *wqe = addr_from_index(qp->sq.queue, qp->cur_index);
+
+	if (check_qp_queue_full(qp))
+		return;
+
+	memset(wqe, 0, sizeof(*wqe));
+
+	wqe->wr.wr_id = qp->vqp.qp_ex.wr_id;
+	wqe->wr.opcode = IBV_WR_RDMA_WRITE_WITH_IMM;
+	wqe->wr.send_flags = qp->vqp.qp_ex.wr_flags;
+	wqe->wr.wr.rdma.remote_addr = remote_addr;
+	wqe->wr.wr.rdma.rkey = rkey;
+	wqe->wr.ex.imm_data = (uint32_t)imm_data;
+	wqe->iova = remote_addr;
+	wqe->ssn = qp->ssn++;;
+
+	advance_qp_cur_index(qp);
+
+	return;
+}
+
+static void wr_send(struct ibv_qp_ex *ibqp)
+{
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+	struct rxe_send_wqe *wqe = addr_from_index(qp->sq.queue, qp->cur_index);
+
+	if (check_qp_queue_full(qp))
+		return;
+
+	memset(wqe, 0, sizeof(*wqe));
+
+	wqe->wr.wr_id = qp->vqp.qp_ex.wr_id;
+	wqe->wr.opcode = IBV_WR_SEND;
+	wqe->wr.send_flags = qp->vqp.qp_ex.wr_flags;
+	wqe->ssn = qp->ssn++;;
+
+	advance_qp_cur_index(qp);
+
+	return;
+}
+
+static void wr_send_imm(struct ibv_qp_ex *ibqp, __be32 imm_data)
+{
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+	struct rxe_send_wqe *wqe = addr_from_index(qp->sq.queue, qp->cur_index);
+
+	if (check_qp_queue_full(qp))
+		return;
+
+	memset(wqe, 0, sizeof(*wqe));
+
+	wqe->wr.wr_id = qp->vqp.qp_ex.wr_id;
+	wqe->wr.opcode = IBV_WR_SEND_WITH_IMM;
+	wqe->wr.send_flags = qp->vqp.qp_ex.wr_flags;
+	wqe->wr.ex.imm_data = (uint32_t)imm_data;
+	wqe->ssn = qp->ssn++;;
+
+	advance_qp_cur_index(qp);
+
+	return;
+}
+
+static void wr_send_inv(struct ibv_qp_ex *ibqp, uint32_t invalidate_rkey)
+{
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+	struct rxe_send_wqe *wqe = addr_from_index(qp->sq.queue, qp->cur_index);
+
+	if (check_qp_queue_full(qp))
+		return;
+
+	memset(wqe, 0, sizeof(*wqe));
+
+	wqe->wr.wr_id = qp->vqp.qp_ex.wr_id;
+	wqe->wr.opcode = IBV_WR_SEND_WITH_INV;
+	wqe->wr.send_flags = qp->vqp.qp_ex.wr_flags;
+	wqe->wr.ex.invalidate_rkey = invalidate_rkey;
+	wqe->ssn = qp->ssn++;;
+
+	advance_qp_cur_index(qp);
+
+	return;
+}
+
+static void wr_send_tso(struct ibv_qp_ex *ibqp, void *hdr, uint16_t hdr_sz,
+			uint16_t mss)
+{
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+	struct rxe_send_wqe *wqe = addr_from_index(qp->sq.queue, qp->cur_index);
+
+	if (check_qp_queue_full(qp))
+		return;
+
+	memset(wqe, 0, sizeof(*wqe));
+
+	wqe->wr.wr_id = qp->vqp.qp_ex.wr_id;
+	wqe->wr.opcode = IBV_WR_TSO;
+	wqe->wr.send_flags = qp->vqp.qp_ex.wr_flags;
+	wqe->ssn = qp->ssn++;;
+
+	advance_qp_cur_index(qp);
+
+	return;
+}
+
+static void wr_set_ud_addr(struct ibv_qp_ex *ibqp, struct ibv_ah *ibah,
+			   uint32_t remote_qpn, uint32_t remote_qkey)
+{
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+	struct rxe_ah *ah = container_of(ibah, struct rxe_ah, ibv_ah);
+	struct rxe_send_wqe *wqe = addr_from_index(qp->sq.queue,
+						   qp->cur_index - 1);
+
+	if (qp->err)
+		return;
+
+	memcpy(&wqe->av, &ah->av, sizeof(ah->av));
+	wqe->wr.wr.ud.remote_qpn = remote_qpn;
+	wqe->wr.wr.ud.remote_qkey = remote_qkey;
+
+	return;
+}
+
+static void wr_set_xrc_srqn(struct ibv_qp_ex *ibqp, uint32_t remote_srqn)
+{
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+
+	if (qp->err)
+		return;
+
+	/* TODO when we add xrc */
+
+	return;
+}
+
+
+static void wr_set_inline_data(struct ibv_qp_ex *ibqp, void *addr,
+			       size_t length)
+{
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+	struct rxe_send_wqe *wqe = addr_from_index(qp->sq.queue,
+						   qp->cur_index - 1);
+
+	if (qp->err)
+		return;
+
+	if (length > qp->sq.max_inline) {
+		qp->err = ENOSPC;
+		return;
+	}
+
+	memcpy(wqe->dma.inline_data, addr, length);
+	wqe->dma.length = length;
+	wqe->dma.resid = 0;
+
+	return;
+}
+
+static void wr_set_inline_data_list(struct ibv_qp_ex *ibqp, size_t num_buf,
+				    const struct ibv_data_buf *buf_list)
+{
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+	struct rxe_send_wqe *wqe = addr_from_index(qp->sq.queue,
+						   qp->cur_index - 1);
+	uint8_t *data = wqe->dma.inline_data;
+	size_t length;
+	size_t tot_length = 0;
+
+	if (qp->err)
+		return;
+
+	while(num_buf--) {
+		length = buf_list->length;
+
+		if (tot_length + length > qp->sq.max_inline) {
+			qp->err = ENOSPC;
+			return;
+		}
+
+		memcpy(data, buf_list->addr, length);
+
+		buf_list++;
+		data += length;
+	}
+
+	wqe->dma.length = tot_length;
+
+	return;
+}
+
+static void wr_set_sge(struct ibv_qp_ex *ibqp, uint32_t lkey, uint64_t addr,
+		       uint32_t length)
+{
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+	struct rxe_send_wqe *wqe = addr_from_index(qp->sq.queue,
+						   qp->cur_index - 1);
+
+	if (qp->err)
+		return;
+
+	if (length) {
+		wqe->dma.length = length;
+		wqe->dma.resid = length;
+		wqe->dma.num_sge = 1;
+
+		wqe->dma.sge[0].addr = addr;
+		wqe->dma.sge[0].length = length;
+		wqe->dma.sge[0].lkey = lkey;
+	}
+
+	return;
+}
+
+static void wr_set_sge_list(struct ibv_qp_ex *ibqp, size_t num_sge,
+			    const struct ibv_sge *sg_list)
+{
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+	struct rxe_send_wqe *wqe = addr_from_index(qp->sq.queue,
+						   qp->cur_index - 1);
+	size_t tot_length = 0;
+
+	if (qp->err)
+		return;
+
+	if (num_sge > qp->sq.max_sge) {
+		qp->err = ENOSPC;
+		return;
+	}
+
+	wqe->dma.num_sge = num_sge;
+	memcpy(wqe->dma.sge, sg_list, num_sge*sizeof(*sg_list));
+
+	while(num_sge--)
+		tot_length += sg_list->length;
+
+	wqe->dma.length = tot_length;
+	wqe->dma.resid = tot_length;
+
+	return;
+}
+
+
+static void wr_start(struct ibv_qp_ex *ibqp)
+{
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+
+	pthread_spin_lock(&qp->sq.lock);
+
+	qp->err = 0;
+	qp->cur_index = load_producer_index(qp->sq.queue);
+
+	return;
+}
+
+static int post_send_db(struct ibv_qp *ibqp);
+
+static int wr_complete(struct ibv_qp_ex *ibqp)
 {
-	struct ibv_create_qp cmd;
-	struct urxe_create_qp_resp resp;
-	struct rxe_qp *qp;
 	int ret;
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+
+	if (qp->err) {
+		pthread_spin_unlock(&qp->sq.lock);
+		return qp->err;
+	}
+
+	store_producer_index(qp->sq.queue, qp->cur_index);
+	ret = post_send_db(&qp->vqp.qp);
+
+	pthread_spin_unlock(&qp->sq.lock);
+	return ret;
+}
+
+static void wr_abort(struct ibv_qp_ex *ibqp)
+{
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
 
+	pthread_spin_unlock(&qp->sq.lock);
+	return;
+}
+
+static struct ibv_qp *rxe_create_qp(struct ibv_pd *ibpd,
+			     struct ibv_qp_init_attr *attr)
+{
+ 	struct ibv_create_qp cmd;
+ 	struct urxe_create_qp_resp resp;
+ 	struct rxe_qp *qp;
+ 	int ret;
+ 
 	qp = malloc(sizeof(*qp));
 	if (!qp)
+ 		return NULL;
+ 
+	ret = ibv_cmd_create_qp(ibpd, &qp->vqp.qp, attr, &cmd, sizeof(cmd),
+				&resp.ibv_resp, sizeof(resp));
+ 	if (ret) {
+ 		free(qp);
+ 		return NULL;
+	}
+
+	if (attr->srq) {
+		qp->rq.max_sge = 0;
+		qp->rq.queue = NULL;
+		qp->rq_mmap_info.size = 0;
+	} else {
+		qp->rq.max_sge = attr->cap.max_recv_sge;
+		qp->rq.queue = mmap(NULL, resp.rq_mi.size, PROT_READ | PROT_WRITE,
+				    MAP_SHARED,
+				    ibpd->context->cmd_fd, resp.rq_mi.offset);
+		if ((void *)qp->rq.queue == MAP_FAILED) {
+			ibv_cmd_destroy_qp(&qp->vqp.qp);
+			free(qp);
+			return NULL;
+		}
+
+		qp->rq_mmap_info = resp.rq_mi;
+		pthread_spin_init(&qp->rq.lock, PTHREAD_PROCESS_PRIVATE);
+	}
+
+	qp->sq.max_sge = attr->cap.max_send_sge;
+	qp->sq.max_inline = attr->cap.max_inline_data;
+	qp->sq.queue = mmap(NULL, resp.sq_mi.size, PROT_READ | PROT_WRITE,
+			    MAP_SHARED,
+			    ibpd->context->cmd_fd, resp.sq_mi.offset);
+	if ((void *)qp->sq.queue == MAP_FAILED) {
+		if (qp->rq_mmap_info.size)
+			munmap(qp->rq.queue, qp->rq_mmap_info.size);
+		ibv_cmd_destroy_qp(&qp->vqp.qp);
+		free(qp);
 		return NULL;
+	}
 
-	ret = ibv_cmd_create_qp(pd, &qp->ibv_qp, attr, &cmd, sizeof(cmd),
-				&resp.ibv_resp, sizeof(resp));
+ 	qp->sq_mmap_info = resp.sq_mi;
+ 	pthread_spin_init(&qp->sq.lock, PTHREAD_PROCESS_PRIVATE);
+ 
+	return &qp->vqp.qp;
+}
+
+enum {
+	RXE_QP_CREATE_FLAGS_SUP = 0
+	//	| IBV_QP_CREATE_BLOCK_SELF_MCAST_LB
+	//	| IBV_QP_CREATE_SCATTER_FCS
+	//	| IBV_QP_CREATE_CVLAN_STRIPPING
+	//	| IBV_QP_CREATE_SOURCE_QPN
+	//	| IBV_QP_CREATE_PCI_WRITE_END_PADDING
+		,
+
+	RXE_QP_COMP_MASK_SUP =
+		  IBV_QP_INIT_ATTR_PD
+		| IBV_QP_INIT_ATTR_XRCD
+		| IBV_QP_INIT_ATTR_CREATE_FLAGS
+	//	| IBV_QP_INIT_ATTR_MAX_TSO_HEADER
+	//	| IBV_QP_INIT_ATTR_IND_TABLE
+	//	| IBV_QP_INIT_ATTR_RX_HASH
+		| IBV_QP_INIT_ATTR_SEND_OPS_FLAGS,
+
+	RXE_SUP_RC_QP_SEND_OPS_FLAGS =
+		  IBV_QP_EX_WITH_RDMA_WRITE
+		| IBV_QP_EX_WITH_RDMA_WRITE_WITH_IMM
+		| IBV_QP_EX_WITH_SEND
+		| IBV_QP_EX_WITH_SEND_WITH_IMM
+		| IBV_QP_EX_WITH_RDMA_READ
+		| IBV_QP_EX_WITH_ATOMIC_CMP_AND_SWP
+		| IBV_QP_EX_WITH_ATOMIC_FETCH_AND_ADD
+		| IBV_QP_EX_WITH_LOCAL_INV
+	//	| IBV_QP_EX_WITH_BIND_MW
+		| IBV_QP_EX_WITH_SEND_WITH_INV,
+
+	RXE_SUP_UC_QP_SEND_OPS_FLAGS =
+		  IBV_QP_EX_WITH_RDMA_WRITE
+		| IBV_QP_EX_WITH_RDMA_WRITE_WITH_IMM
+		| IBV_QP_EX_WITH_SEND
+		| IBV_QP_EX_WITH_SEND_WITH_IMM
+	//	| IBV_QP_EX_WITH_BIND_MW
+		| IBV_QP_EX_WITH_SEND_WITH_INV,
+
+	RXE_SUP_UD_QP_SEND_OPS_FLAGS =
+		  IBV_QP_EX_WITH_SEND
+		| IBV_QP_EX_WITH_SEND_WITH_IMM,
+
+	RXE_SUP_XRC_QP_SEND_OPS_FLAGS =
+		RXE_SUP_RC_QP_SEND_OPS_FLAGS,
+};
+
+static int check_qp_init_attr(struct ibv_context *context,
+			      struct ibv_qp_init_attr_ex *attr)
+{
+	if (attr->comp_mask & ~RXE_QP_COMP_MASK_SUP)
+		return EOPNOTSUPP;
+
+	if ((attr->comp_mask & IBV_QP_INIT_ATTR_CREATE_FLAGS) &&
+	    (attr->create_flags & ~RXE_QP_CREATE_FLAGS_SUP))
+		return EOPNOTSUPP;
+
+	if (attr->comp_mask & IBV_QP_INIT_ATTR_SEND_OPS_FLAGS) {
+		switch(attr->qp_type) {
+		case IBV_QPT_RC:
+			if (attr->send_ops_flags & ~RXE_SUP_RC_QP_SEND_OPS_FLAGS)
+				return EOPNOTSUPP;
+			break;
+		case IBV_QPT_UC:
+			if (attr->send_ops_flags & ~RXE_SUP_UC_QP_SEND_OPS_FLAGS)
+				return EOPNOTSUPP;
+			break;
+		case IBV_QPT_UD:
+			if (attr->send_ops_flags & ~RXE_SUP_UD_QP_SEND_OPS_FLAGS)
+				return EOPNOTSUPP;
+			break;
+		case IBV_QPT_RAW_PACKET:
+			return EOPNOTSUPP;
+		case IBV_QPT_XRC_SEND:
+			if (attr->send_ops_flags & ~RXE_SUP_XRC_QP_SEND_OPS_FLAGS)
+				return EOPNOTSUPP;
+			break;
+		case IBV_QPT_XRC_RECV:
+			return EOPNOTSUPP;
+		case IBV_QPT_DRIVER:
+			return EOPNOTSUPP;
+		default:
+			return EOPNOTSUPP;
+		}
+	}
+
+	return 0;
+}
+ 
+static void set_qp_send_ops(struct rxe_qp *qp, uint64_t flags)
+{
+	if (flags & IBV_QP_EX_WITH_ATOMIC_CMP_AND_SWP)
+		qp->vqp.qp_ex.wr_atomic_cmp_swp = wr_atomic_cmp_swp;
+
+	if (flags & IBV_QP_EX_WITH_ATOMIC_FETCH_AND_ADD)
+		qp->vqp.qp_ex.wr_atomic_fetch_add = wr_atomic_fetch_add;
+
+	if (flags & IBV_QP_EX_WITH_LOCAL_INV)
+		qp->vqp.qp_ex.wr_local_inv = wr_local_inv;
+
+	if (flags & IBV_QP_EX_WITH_RDMA_READ)
+		qp->vqp.qp_ex.wr_rdma_read = wr_rdma_read;
+
+	if (flags & IBV_QP_EX_WITH_RDMA_WRITE)
+		qp->vqp.qp_ex.wr_rdma_write = wr_rdma_write;
+
+	if (flags & IBV_QP_EX_WITH_RDMA_WRITE_WITH_IMM)
+		qp->vqp.qp_ex.wr_rdma_write_imm = wr_rdma_write_imm;
+
+	if (flags & IBV_QP_EX_WITH_SEND)
+		qp->vqp.qp_ex.wr_send = wr_send;
+
+	if (flags & IBV_QP_EX_WITH_SEND_WITH_IMM)
+		qp->vqp.qp_ex.wr_send_imm = wr_send_imm;
+
+	if (flags & IBV_QP_EX_WITH_SEND_WITH_INV)
+		qp->vqp.qp_ex.wr_send_inv = wr_send_inv;
+
+	if (flags & IBV_QP_EX_WITH_TSO)
+		qp->vqp.qp_ex.wr_send_tso = wr_send_tso;
+
+	qp->vqp.qp_ex.wr_set_ud_addr = wr_set_ud_addr;
+	qp->vqp.qp_ex.wr_set_xrc_srqn = wr_set_xrc_srqn;
+	qp->vqp.qp_ex.wr_set_inline_data = wr_set_inline_data;
+	qp->vqp.qp_ex.wr_set_inline_data_list = wr_set_inline_data_list;
+	qp->vqp.qp_ex.wr_set_sge = wr_set_sge;
+	qp->vqp.qp_ex.wr_set_sge_list = wr_set_sge_list;
+
+	qp->vqp.qp_ex.wr_start = wr_start;
+	qp->vqp.qp_ex.wr_complete = wr_complete;
+	qp->vqp.qp_ex.wr_abort = wr_abort;
+}
+
+static struct ibv_qp *rxe_create_qp_ex(struct ibv_context *context,
+				struct ibv_qp_init_attr_ex *attr)
+{
+	int ret;
+	struct rxe_qp *qp;
+	struct ibv_create_qp_ex cmd = {};
+	struct urxe_create_qp_ex_resp resp = {};
+	size_t cmd_size = sizeof(cmd);
+	size_t resp_size = sizeof(resp);
+
+	ret = check_qp_init_attr(context, attr);
+	if (ret) {
+		errno = ret;
+		return NULL;
+	}
+
+	qp = calloc(1, sizeof(*qp));
+	if (!qp)
+		return NULL;
+
+	if (attr->comp_mask & IBV_QP_INIT_ATTR_SEND_OPS_FLAGS)
+		set_qp_send_ops(qp, attr->send_ops_flags);
+
+	ret = ibv_cmd_create_qp_ex2(context, &qp->vqp, attr,
+				    &cmd, cmd_size,
+				    &resp.ibv_resp, resp_size);
 	if (ret) {
 		free(qp);
 		return NULL;
 	}
 
+	qp->vqp.comp_mask |= VERBS_QP_EX;
+
 	if (attr->srq) {
 		qp->rq.max_sge = 0;
 		qp->rq.queue = NULL;
@@ -744,10 +1357,9 @@ static struct ibv_qp *rxe_create_qp(struct ibv_pd *pd,
 	} else {
 		qp->rq.max_sge = attr->cap.max_recv_sge;
 		qp->rq.queue = mmap(NULL, resp.rq_mi.size, PROT_READ | PROT_WRITE,
-				    MAP_SHARED,
-				    pd->context->cmd_fd, resp.rq_mi.offset);
+				    MAP_SHARED, context->cmd_fd, resp.rq_mi.offset);
 		if ((void *)qp->rq.queue == MAP_FAILED) {
-			ibv_cmd_destroy_qp(&qp->ibv_qp);
+			ibv_cmd_destroy_qp(&qp->vqp.qp);
 			free(qp);
 			return NULL;
 		}
@@ -759,12 +1371,11 @@ static struct ibv_qp *rxe_create_qp(struct ibv_pd *pd,
 	qp->sq.max_sge = attr->cap.max_send_sge;
 	qp->sq.max_inline = attr->cap.max_inline_data;
 	qp->sq.queue = mmap(NULL, resp.sq_mi.size, PROT_READ | PROT_WRITE,
-			    MAP_SHARED,
-			    pd->context->cmd_fd, resp.sq_mi.offset);
+			    MAP_SHARED, context->cmd_fd, resp.sq_mi.offset);
 	if ((void *)qp->sq.queue == MAP_FAILED) {
 		if (qp->rq_mmap_info.size)
 			munmap(qp->rq.queue, qp->rq_mmap_info.size);
-		ibv_cmd_destroy_qp(&qp->ibv_qp);
+		ibv_cmd_destroy_qp(&qp->vqp.qp);
 		free(qp);
 		return NULL;
 	}
@@ -772,34 +1383,32 @@ static struct ibv_qp *rxe_create_qp(struct ibv_pd *pd,
 	qp->sq_mmap_info = resp.sq_mi;
 	pthread_spin_init(&qp->sq.lock, PTHREAD_PROCESS_PRIVATE);
 
-	return &qp->ibv_qp;
+	return &qp->vqp.qp;
 }
 
-static int rxe_query_qp(struct ibv_qp *qp, struct ibv_qp_attr *attr,
-			int attr_mask,
-			struct ibv_qp_init_attr *init_attr)
+static int rxe_query_qp(struct ibv_qp *ibqp, struct ibv_qp_attr *attr, int attr_mask,
+		 struct ibv_qp_init_attr *init_attr)
 {
 	struct ibv_query_qp cmd;
 
-	return ibv_cmd_query_qp(qp, attr, attr_mask, init_attr,
+	return ibv_cmd_query_qp(ibqp, attr, attr_mask, init_attr,
 				&cmd, sizeof(cmd));
 }
-
-static int rxe_modify_qp(struct ibv_qp *ibvqp,
-			 struct ibv_qp_attr *attr,
-			 int attr_mask)
+ 
+static int rxe_modify_qp(struct ibv_qp *ibqp, struct ibv_qp_attr *attr,
+		  int attr_mask)
 {
 	struct ibv_modify_qp cmd = {};
 
-	return ibv_cmd_modify_qp(ibvqp, attr, attr_mask, &cmd, sizeof(cmd));
+	return ibv_cmd_modify_qp(ibqp, attr, attr_mask, &cmd, sizeof(cmd));
 }
-
-static int rxe_destroy_qp(struct ibv_qp *ibv_qp)
+ 
+static int rxe_destroy_qp(struct ibv_qp *ibqp)
 {
 	int ret;
-	struct rxe_qp *qp = to_rqp(ibv_qp);
+	struct rxe_qp *qp = to_rqp(ibqp);
 
-	ret = ibv_cmd_destroy_qp(ibv_qp);
+	ret = ibv_cmd_destroy_qp(ibqp);
 	if (!ret) {
 		if (qp->rq_mmap_info.size)
 			munmap(qp->rq.queue, qp->rq_mmap_info.size);
@@ -1147,6 +1756,7 @@ static const struct verbs_context_ops rxe_ctx_ops = {
 static const struct verbs_context_ops rxe_ctx_ops_cmd_ex = {
 	.query_device_ex = rxe_query_device_ex,
 	.create_cq_ex = rxe_create_cq_ex,
+	.create_qp_ex = rxe_create_qp_ex,
 };
 
 static struct verbs_context *rxe_alloc_context(struct ibv_device *ibdev,
diff --git a/providers/rxe/rxe.h b/providers/rxe/rxe.h
index e89a781f..51e78347 100644
--- a/providers/rxe/rxe.h
+++ b/providers/rxe/rxe.h
@@ -88,15 +88,19 @@ struct rxe_wq {
 };
 
 struct rxe_qp {
-	struct ibv_qp		ibv_qp;
+	struct verbs_qp		vqp;
 	struct mminfo		rq_mmap_info;
 	struct rxe_wq		rq;
 	struct mminfo		sq_mmap_info;
 	struct rxe_wq		sq;
 	unsigned int		ssn;
+
+	/* new API support */
+	uint32_t		cur_index;
+	int			err;
 };
 
-#define qp_type(qp)		((qp)->ibv_qp.qp_type)
+#define qp_type(qp)		((qp)->vqp.qp.qp_type)
 
 struct rxe_srq {
 	struct ibv_srq		ibv_srq;
@@ -124,7 +128,7 @@ static inline struct rxe_cq *to_rcq(struct ibv_cq *ibcq)
 
 static inline struct rxe_qp *to_rqp(struct ibv_qp *ibqp)
 {
-	return to_rxxx(qp, qp);
+	return container_of(ibqp, struct rxe_qp, vqp.qp);
 }
 
 static inline struct rxe_srq *to_rsrq(struct ibv_srq *ibsrq)
diff --git a/providers/rxe/rxe_queue.h b/providers/rxe/rxe_queue.h
index 1c3c3d5c..246aad83 100644
--- a/providers/rxe/rxe_queue.h
+++ b/providers/rxe/rxe_queue.h
@@ -172,4 +172,25 @@ static inline int check_cq_queue_empty(struct rxe_cq *cq)
 	return (cq->cur_index == producer_index);
 }
 
+static inline void advance_qp_cur_index(struct rxe_qp *qp)
+{
+	struct rxe_queue *q = qp->sq.queue;
+
+	qp->cur_index = (qp->cur_index + 1) & q->index_mask;
+}
+
+static inline int check_qp_queue_full(struct rxe_qp *qp)
+{
+	struct rxe_queue *q = qp->sq.queue;
+	uint32_t consumer_index = atomic_load(&q->consumer_index);
+
+	if (qp->err)
+		goto err;
+
+	if ((qp->cur_index + 1 - consumer_index) % q->index_mask == 0)
+		qp->err = ENOSPC;
+err:
+	return qp->err;
+}
+
 #endif /* H_RXE_PCQ */
-- 
2.27.0

