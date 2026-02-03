Return-Path: <linux-rdma+bounces-16396-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIGCIRiDgWlNGwMAu9opvQ
	(envelope-from <linux-rdma+bounces-16396-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 06:09:44 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B02B0D494F
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 06:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE4063007A7A
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 05:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CBE359707;
	Tue,  3 Feb 2026 05:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZeKsi1kM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C01355805
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 05:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770095377; cv=none; b=Uwm3TIhN07uKcoFpWCJPYPTRslzSHMzDq1zCC4xDEjneR9pUWRAdBTDqIrVJQma99/uJt1UTYWJerpIXTMoWCGYeK1XnFIBQbbo9acNCkCC1dCiI/+ET4wVpaGu+rQFrUBAXmdUZCo6KRZFJ4DWoScTtLmBSg2lx0Pzo8oH1UP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770095377; c=relaxed/simple;
	bh=LIAEYNy5SiwA5+U64w0Z2DcRH49QoYKOZ9KhB5bgV2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=USETiBBRiLvo2n0ArZMsatIxycpKBpG2Qz4ksyyPowQngryy2aFTRk+rReLdNeAB1yS5PKqXTcCRmB01SrlWxz+nbdHmIRVD2kmDRrqXiJ37ti9yU7ydFlneoooporgnxIT25BVVaSeGa9IHA4yTKjXClJiEJA95zL799ccND90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZeKsi1kM; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2a9057b2ec3so10275175ad.2
        for <linux-rdma@vger.kernel.org>; Mon, 02 Feb 2026 21:09:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770095375; x=1770700175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WIU9VfeAb8b/BNyYd/8Aa3Fs9PqfMwO9pAcQ56zbZVo=;
        b=NUTcKYlxxu8hGEZFfuVNBvqVKWTjma15kqm1a5/IT1/qlFEbqm7cipN+ALIhXXw0lP
         3ZXP7DPNnj3ZnxFD+zw+ixgIFgLANve/SMUCR+cktrwiPOBHrdVq+K3xsO/Eu+PUlmMi
         j1M+3dV/qh6MWzHBgJoCS2r6cPB6Ax4zTXfs7IUTW3L39QPn4QqqEJOWEuNENF2Z+KTb
         EWIQ09/Tg/rrWK9mRaMP7qCasnqC9jTbNuBSOJUz5hgNi+cTyjchJyKNyA8xaYCubqBK
         DqU9sFN9c9e54hoJMmiaNFhV+7yhrgDR7jd0YqXdkJFIMgsdBJETAq66Ip2t3BLGajG0
         IxVw==
X-Gm-Message-State: AOJu0YyX5pys+7b1tQppoi71bXfZxkX/dqTclvOWnmam19gmP9+lo84C
	DYsygrSu7lXIurtFkfT2k87HwKxlznsT+8W7Sn6HaMgREGb0PuE9NKxFPy7ExUujOjcw5dZfWTa
	OoLZqLKxjqbDBjg8XtO1cRYlnAUc4LC/e4e5bO31ncmn3C/6J1pYthVNn6M5DvOF1UGBxPRXwdK
	w439K2dYPKLeTfNyushZv06M+gFH1CPR8bGfB20ce7qv6q8NFMoyZKRgYSLIkkdLEL9mvFpT5X2
	VXw7sh+UBgNPFlmAi3/5atkIetU
X-Gm-Gg: AZuq6aLqz7fdvIw8Ugq9LYxETp9ZlU6TgiGzfVUC9z4kePLLX+zZEY+pErGHEhhrz1l
	WWvqGckOOO/k9HOFnOB4gOi7R1B9xweDnRFE9MKij3eIJNePgwsvjBn58AbPhTcnBNlPTksa6ha
	vycWW4hlOWk3KPW2FUlncGT9VPLv39KpjPZy9VfUsYrUI3rPteu7bhBQhSFJwewKYDyAjvtjxI0
	qG5Or076jD02POGTa1YZyx138R+rGoX31IxLJbVY+Rrf4EwJkBiFXxrLmdsww4QNo21y3yxK5Mk
	6idHqRTWvO1yWnycVO7RKrLjv2C1zod6IF9kKNmcGYeTrtxrA2s9g4gnM7wGtrLJyCYR7SdQgX1
	fXtLFtd/DCY1D/hWQxtwyJBNxeBLBGgHypAmL01ahSRnPNPBbJEosbpBgcs9IDWvuvxNnvGfRp7
	8dB4ueetEXLPecGkpqx2hTWiLqTG06NiG9xo/dQI9rlPyuH9DoEhTmYwqU8aI=
X-Received: by 2002:a17:902:f544:b0:2a0:fb1c:143d with SMTP id d9443c01a7336-2a8d9592938mr120582965ad.1.1770095374939;
        Mon, 02 Feb 2026 21:09:34 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a88b413275sm24145685ad.14.2026.02.02.21.09.34
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Feb 2026 21:09:34 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34c2f670a06so5435774a91.3
        for <linux-rdma@vger.kernel.org>; Mon, 02 Feb 2026 21:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770095373; x=1770700173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIU9VfeAb8b/BNyYd/8Aa3Fs9PqfMwO9pAcQ56zbZVo=;
        b=ZeKsi1kMS9eC3TcEfIurCMOnqdQuMyqoBODXKs5B4gsZN9tcp6gomWddlamklctNc4
         /HXWSUlm6ly6LwJ0TpKHoZADKMH1hduE90TwvsszONAqfKmTu02ApvR14R9uBrwmFp18
         e7iAZ3xjgvnAAzjs5+HV4bLe3KAXNxLUzy2Ng=
X-Received: by 2002:a17:90a:da8b:b0:321:9366:5865 with SMTP id 98e67ed59e1d1-3543b4018d0mr13156239a91.33.1770095372723;
        Mon, 02 Feb 2026 21:09:32 -0800 (PST)
X-Received: by 2002:a17:90a:da8b:b0:321:9366:5865 with SMTP id 98e67ed59e1d1-3543b4018d0mr13156221a91.33.1770095372270;
        Mon, 02 Feb 2026 21:09:32 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3547b1306c5sm621948a91.15.2026.02.02.21.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 21:09:31 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v10 6/6] RDMA/bnxt_re: Direct Verbs: Support QP verbs
Date: Tue,  3 Feb 2026 10:30:49 +0530
Message-ID: <20260203050049.171026-7-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260203050049.171026-1-sriharsha.basavapatna@broadcom.com>
References: <20260203050049.171026-1-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16396-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B02B0D494F
X-Rspamd-Action: no action

The following Direct Verbs have been implemented, by enhancing the
driver specific udata in existing verbs.

QP Direct Verbs:
----------------
- CREATE_QP:
  Create a QP using the specified udata (struct bnxt_re_qp_req).
  The driver registers a new device op 'create_qp_umem' that is
  used to process QP memory allocated by the userspace application.
  The driver maps/pins the SQ/RQ user memory and registers it
  with the hardware.

- DESTROY_QP:
  Unmap SQ/RQ user memory and destroy the QP.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Co-developed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Co-developed-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/dv.c       | 316 +++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 118 +++++++--
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |  15 ++
 drivers/infiniband/hw/bnxt_re/main.c     |   1 +
 include/uapi/rdma/bnxt_re-abi.h          |  11 +
 5 files changed, 435 insertions(+), 26 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/dv.c b/drivers/infiniband/hw/bnxt_re/dv.c
index 4d7534abcff1..305c7f4bc9c4 100644
--- a/drivers/infiniband/hw/bnxt_re/dv.c
+++ b/drivers/infiniband/hw/bnxt_re/dv.c
@@ -399,6 +399,9 @@ static int bnxt_re_dv_dbr_cleanup(struct ib_uobject *uobject,
 	struct bnxt_re_dbr_obj *obj = uobject->object;
 	struct bnxt_re_dev *rdev = obj->rdev;
 
+	if (atomic_read(&obj->usecnt))
+		return -EBUSY;
+
 	rdma_user_mmap_entry_remove(&obj->entry->rdma_entry);
 	bnxt_qplib_free_uc_dpi(&rdev->qplib_res, &obj->dpi);
 	return 0;
@@ -580,11 +583,324 @@ int bnxt_re_dv_create_cq(struct bnxt_re_dev *rdev, struct ib_udata *udata,
 	return ret;
 };
 
+static int bnxt_re_dv_init_qp_attr(struct bnxt_re_qp *qp,
+				   struct bnxt_re_ucontext *cntx,
+				   struct ib_qp_init_attr *init_attr,
+				   struct bnxt_re_qp_req *req,
+				   struct bnxt_re_dbr_obj *dbr_obj)
+{
+	struct bnxt_qplib_dev_attr *dev_attr;
+	struct bnxt_qplib_qp *qplqp;
+	struct bnxt_re_cq *send_cq;
+	struct bnxt_re_cq *recv_cq;
+	struct bnxt_re_dev *rdev;
+	struct bnxt_qplib_q *rq;
+	struct bnxt_qplib_q *sq;
+	struct bnxt_re_pd *pd;
+	struct ib_pd *ib_pd;
+	u32 slot_size;
+	int qptype;
+
+	rdev = qp->rdev;
+	qplqp = &qp->qplib_qp;
+	dev_attr = rdev->dev_attr;
+
+	/* Setup misc params */
+	qplqp->is_user = true;
+	ib_pd = qp->ib_qp.pd;
+	pd = container_of(ib_pd, struct bnxt_re_pd, ib_pd);
+	qplqp->pd = &pd->qplib_pd;
+	qplqp->qp_handle = (u64)qplqp;
+	qplqp->sig_type = false;
+	qptype = __from_ib_qp_type(init_attr->qp_type);
+	if (qptype < 0)
+		return qptype;
+	qplqp->type = (u8)qptype;
+	qplqp->wqe_mode = rdev->chip_ctx->modes.wqe_mode;
+	ether_addr_copy(qplqp->smac, rdev->netdev->dev_addr);
+	qplqp->dev_cap_flags = dev_attr->dev_cap_flags;
+	qplqp->cctx = rdev->chip_ctx;
+
+	if (init_attr->qp_type == IB_QPT_RC) {
+		qplqp->max_rd_atomic = dev_attr->max_qp_rd_atom;
+		qplqp->max_dest_rd_atomic = dev_attr->max_qp_init_rd_atom;
+	}
+	qplqp->mtu = ib_mtu_enum_to_int(iboe_get_mtu(rdev->netdev->mtu));
+	if (dbr_obj)
+		qplqp->dpi = &dbr_obj->dpi;
+	else
+		qplqp->dpi = &cntx->dpi;
+
+	/* Setup CQs */
+	if (!init_attr->send_cq)
+		return -EINVAL;
+	send_cq = container_of(init_attr->send_cq, struct bnxt_re_cq, ib_cq);
+	qplqp->scq = &send_cq->qplib_cq;
+	qp->scq = send_cq;
+
+	if (!init_attr->recv_cq)
+		return -EINVAL;
+	recv_cq = container_of(init_attr->recv_cq, struct bnxt_re_cq, ib_cq);
+	qplqp->rcq = &recv_cq->qplib_cq;
+	qp->rcq = recv_cq;
+
+	if (!init_attr->srq) {
+		/* Setup RQ */
+		slot_size = bnxt_qplib_get_stride();
+		rq = &qplqp->rq;
+		rq->max_sge = init_attr->cap.max_recv_sge;
+		rq->wqe_size = req->rq_wqe_sz;
+		rq->max_wqe = (req->rq_slots * slot_size) /
+				req->rq_wqe_sz;
+		rq->max_sw_wqe = rq->max_wqe;
+		rq->q_full_delta = 0;
+		rq->sg_info.pgsize = PAGE_SIZE;
+		rq->sg_info.pgshft = PAGE_SHIFT;
+	}
+
+	/* Setup SQ */
+	sq = &qplqp->sq;
+	sq->max_sge = init_attr->cap.max_send_sge;
+	sq->wqe_size = req->sq_wqe_sz;
+	sq->max_wqe = req->sq_slots; /* SQ in var-wqe mode */
+	sq->max_sw_wqe = sq->max_wqe;
+	sq->q_full_delta = 0;
+	sq->sg_info.pgsize = PAGE_SIZE;
+	sq->sg_info.pgshft = PAGE_SHIFT;
+
+	return 0;
+}
+
+static int bnxt_re_dv_init_user_qp(struct bnxt_re_dev *rdev,
+				   struct bnxt_re_ucontext *cntx,
+				   struct bnxt_re_qp *qp,
+				   struct ib_qp_init_attr *init_attr,
+				   struct bnxt_re_qp_req *req,
+				   struct ib_umem *sq_umem, struct ib_umem *rq_umem)
+{
+	struct bnxt_qplib_sg_info *sginfo;
+	struct bnxt_qplib_qp *qplib_qp;
+	int rc;
+
+	qplib_qp = &qp->qplib_qp;
+	qplib_qp->qp_handle = req->qp_handle;
+
+	/* SQ */
+	sginfo = &qplib_qp->sq.sg_info;
+	rc = bnxt_re_dv_setup_umem(rdev, sq_umem, sginfo);
+	if (rc)
+		return rc;
+
+	qp->sumem = sq_umem;
+	/* SRQ */
+	if (init_attr->srq) {
+		struct bnxt_re_srq *srq;
+
+		srq = container_of(init_attr->srq, struct bnxt_re_srq, ib_srq);
+		qplib_qp->srq = &srq->qplib_srq;
+		goto done;
+	}
+
+	/* RQ */
+	sginfo = &qplib_qp->rq.sg_info;
+	rc = bnxt_re_dv_setup_umem(rdev, rq_umem, sginfo);
+	if (rc)
+		goto rqfail;
+
+	qp->rumem = rq_umem;
+done:
+	qplib_qp->is_user = true;
+	return 0;
+rqfail:
+	/* Note: sq_umem and rq_umem will be freed by uverbs handler,
+	 * since DV QP creation happens through devop->create_qp_mem().
+	 */
+	qplib_qp->sq.sg_info.umem = NULL;
+	return rc;
+}
+
+static int
+bnxt_re_dv_qp_init_msn(struct bnxt_re_dev *rdev, struct bnxt_re_qp *qp,
+		       struct bnxt_re_qp_req *req)
+{
+	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
+	struct bnxt_qplib_qp *qplib_qp = &qp->qplib_qp;
+
+	if (req->sq_npsn > dev_attr->max_qp_wqes ||
+	    req->sq_psn_sz > sizeof(struct sq_psn_search_ext))
+		return -EINVAL;
+
+	qplib_qp->is_host_msn_tbl = true;
+	qplib_qp->msn = 0;
+	qplib_qp->psn_sz = req->sq_psn_sz;
+	qplib_qp->msn_tbl_sz = req->sq_psn_sz * req->sq_npsn;
+	return 0;
+}
+
+static void bnxt_re_dv_init_qp(struct bnxt_re_dev *rdev,
+			       struct bnxt_re_qp *qp)
+{
+	u32 active_qps, tmp_qps;
+
+	spin_lock_init(&qp->sq_lock);
+	spin_lock_init(&qp->rq_lock);
+	INIT_LIST_HEAD(&qp->list);
+	mutex_lock(&rdev->qp_lock);
+	list_add_tail(&qp->list, &rdev->qp_list);
+	mutex_unlock(&rdev->qp_lock);
+	atomic_inc(&rdev->stats.res.qp_count);
+	active_qps = atomic_read(&rdev->stats.res.qp_count);
+	if (active_qps > rdev->stats.res.qp_watermark)
+		rdev->stats.res.qp_watermark = active_qps;
+
+	/* Get the counters for RC QPs */
+	tmp_qps = atomic_inc_return(&rdev->stats.res.rc_qp_count);
+	if (tmp_qps > rdev->stats.res.rc_qp_watermark)
+		rdev->stats.res.rc_qp_watermark = tmp_qps;
+}
+
+int bnxt_re_dv_create_qp(struct bnxt_re_dev *rdev, struct ib_udata *udata,
+			 struct ib_qp_init_attr *init_attr,
+			 struct bnxt_re_qp *re_qp, struct bnxt_re_qp_req *req,
+			 struct ib_umem *sq_umem, struct ib_umem *rq_umem)
+{
+	struct bnxt_re_dbr_obj *dbr_obj = NULL;
+	struct bnxt_re_cq *send_cq = NULL;
+	struct bnxt_re_cq *recv_cq = NULL;
+	struct bnxt_re_qp_resp resp = {};
+	struct uverbs_attr_bundle *attrs;
+	struct bnxt_re_ucontext *uctx;
+	int ret;
+
+	uctx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
+	if (init_attr->send_cq) {
+		send_cq = container_of(init_attr->send_cq, struct bnxt_re_cq, ib_cq);
+		re_qp->scq = send_cq;
+	}
+
+	if (init_attr->recv_cq) {
+		recv_cq = container_of(init_attr->recv_cq, struct bnxt_re_cq, ib_cq);
+		re_qp->rcq = recv_cq;
+	}
+
+	attrs = rdma_udata_to_uverbs_attr_bundle(udata);
+	if (!attrs)
+		return -EINVAL;
+
+	if (uverbs_attr_is_valid(attrs, BNXT_RE_CREATE_QP_ATTR_DBR_HANDLE)) {
+		dbr_obj = uverbs_attr_get_obj(attrs, BNXT_RE_CREATE_QP_ATTR_DBR_HANDLE);
+		if (IS_ERR(dbr_obj))
+			return PTR_ERR(dbr_obj);
+		atomic_inc(&dbr_obj->usecnt);
+		re_qp->dbr_obj = dbr_obj;
+	}
+
+	re_qp->rdev = rdev;
+	ret = bnxt_re_dv_init_qp_attr(re_qp, uctx, init_attr, req, dbr_obj);
+	if (ret)
+		goto dbr_rel;
+
+	ret = bnxt_re_dv_init_user_qp(rdev, uctx, re_qp, init_attr, req,
+				      sq_umem, rq_umem);
+	if (ret)
+		goto dbr_rel;
+
+	ret = bnxt_re_dv_qp_init_msn(rdev, re_qp, req);
+	if (ret)
+		goto dbr_rel;
+
+	ret = bnxt_re_setup_qp_hwqs(re_qp, true);
+	if (ret)
+		goto dbr_rel;
+
+	ret = bnxt_qplib_create_qp(&rdev->qplib_res, &re_qp->qplib_qp);
+	if (ret) {
+		ibdev_err(&rdev->ibdev, "Failed to create HW QP");
+		goto free_hwq;
+	}
+
+	resp.qpid = re_qp->qplib_qp.id;
+	resp.rsvd = 0;
+	ret = ib_copy_to_udata(udata, &resp, sizeof(resp));
+	if (ret)
+		goto free_qplib;
+
+	re_qp->ib_qp.qp_num = re_qp->qplib_qp.id;
+	bnxt_re_dv_init_qp(rdev, re_qp);
+	re_qp->is_dv_qp = true;
+	return 0;
+
+free_qplib:
+	bnxt_qplib_destroy_qp(&rdev->qplib_res, &re_qp->qplib_qp);
+free_hwq:
+	bnxt_qplib_free_qp_res(&rdev->qplib_res, &re_qp->qplib_qp);
+dbr_rel:
+	/* Note: sq_umem and rq_umem will be freed by uverbs handler,
+	 * since DV QP creation happens through devop->create_qp_mem().
+	 */
+	if (dbr_obj)
+		atomic_dec(&dbr_obj->usecnt);
+	return ret;
+}
+
+int bnxt_re_dv_destroy_qp(struct bnxt_re_qp *qp)
+{
+	struct bnxt_re_dev *rdev = qp->rdev;
+	struct bnxt_qplib_qp *qplib_qp = &qp->qplib_qp;
+	struct bnxt_qplib_nq *scq_nq = NULL;
+	struct bnxt_qplib_nq *rcq_nq = NULL;
+	int rc;
+
+	mutex_lock(&rdev->qp_lock);
+	list_del(&qp->list);
+	atomic_dec(&rdev->stats.res.qp_count);
+	if (qp->qplib_qp.type == CMDQ_CREATE_QP_TYPE_RC)
+		atomic_dec(&rdev->stats.res.rc_qp_count);
+	mutex_unlock(&rdev->qp_lock);
+
+	rc = bnxt_qplib_destroy_qp(&rdev->qplib_res, qplib_qp);
+	if (rc)
+		ibdev_err_ratelimited(&rdev->ibdev,
+				      "id = %d failed rc = %d",
+				      qplib_qp->id, rc);
+
+	bnxt_qplib_free_qp_res(&rdev->qplib_res, qplib_qp);
+	bnxt_re_qp_free_umem(qp);
+
+	/* Flush all the entries of notification queue associated with
+	 * given qp.
+	 */
+	scq_nq = qplib_qp->scq->nq;
+	rcq_nq = qplib_qp->rcq->nq;
+	bnxt_re_synchronize_nq(scq_nq);
+	if (scq_nq != rcq_nq)
+		bnxt_re_synchronize_nq(rcq_nq);
+
+	if (qp->dbr_obj)
+		atomic_dec(&qp->dbr_obj->usecnt);
+	return 0;
+}
+
+ADD_UVERBS_ATTRIBUTES_SIMPLE(
+	bnxt_re_qp_create,
+	UVERBS_OBJECT_QP,
+	UVERBS_METHOD_QP_CREATE,
+	UVERBS_ATTR_IDR(BNXT_RE_CREATE_QP_ATTR_DBR_HANDLE,
+			BNXT_RE_OBJECT_DBR,
+			UVERBS_ACCESS_READ,
+			UA_OPTIONAL));
+
+const struct uapi_definition bnxt_re_create_qp_defs[] = {
+	UAPI_DEF_CHAIN_OBJ_TREE(UVERBS_OBJECT_QP, &bnxt_re_qp_create),
+	{},
+};
+
 const struct uapi_definition bnxt_re_uapi_defs[] = {
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_ALLOC_PAGE),
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_NOTIFY_DRV),
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_GET_TOGGLE_MEM),
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_DBR),
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_DEFAULT_DBR),
+	UAPI_DEF_CHAIN(bnxt_re_create_qp_defs),
 	{}
 };
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index dea80cea64a3..8f631184c5db 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -967,7 +967,7 @@ static void bnxt_re_del_unique_gid(struct bnxt_re_dev *rdev)
 		dev_err(rdev_to_dev(rdev), "Failed to delete unique GID, rc: %d\n", rc);
 }
 
-static void bnxt_re_qp_free_umem(struct bnxt_re_qp *qp)
+void bnxt_re_qp_free_umem(struct bnxt_re_qp *qp)
 {
 	ib_umem_release(qp->rumem);
 	ib_umem_release(qp->sumem);
@@ -984,6 +984,9 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 	unsigned int flags;
 	int rc;
 
+	if (qp->is_dv_qp)
+		return bnxt_re_dv_destroy_qp(qp);
+
 	bnxt_re_debug_rem_qpinfo(rdev, qp);
 
 	bnxt_qplib_flush_cqn_wq(&qp->qplib_qp);
@@ -1029,7 +1032,7 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 	return 0;
 }
 
-static u8 __from_ib_qp_type(enum ib_qp_type type)
+u8 __from_ib_qp_type(enum ib_qp_type type)
 {
 	switch (type) {
 	case IB_QPT_GSI:
@@ -1265,7 +1268,7 @@ static int bnxt_re_qp_alloc_init_xrrq(struct bnxt_re_qp *qp)
 	return rc;
 }
 
-static int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp)
+int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp, bool is_dv_qp)
 {
 	struct bnxt_qplib_res *res = &qp->rdev->qplib_res;
 	struct bnxt_qplib_qp *qplib_qp = &qp->qplib_qp;
@@ -1279,12 +1282,17 @@ static int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp)
 	hwq_attr.res = res;
 	hwq_attr.sginfo = &sq->sg_info;
 	hwq_attr.stride = bnxt_qplib_get_stride();
-	hwq_attr.depth = bnxt_qplib_get_depth(sq, wqe_mode, true);
 	hwq_attr.aux_stride = qplib_qp->psn_sz;
-	hwq_attr.aux_depth = (qplib_qp->psn_sz) ?
-		bnxt_qplib_set_sq_size(sq, wqe_mode) : 0;
-	if (qplib_qp->is_host_msn_tbl && qplib_qp->psn_sz)
+	if (!is_dv_qp) {
+		hwq_attr.depth = bnxt_qplib_get_depth(sq, wqe_mode, true);
+		hwq_attr.aux_depth = (qplib_qp->psn_sz) ?
+				bnxt_qplib_set_sq_size(sq, wqe_mode) : 0;
+		if (qplib_qp->is_host_msn_tbl && qplib_qp->psn_sz)
+			hwq_attr.aux_depth = qplib_qp->msn_tbl_sz;
+	} else {
+		hwq_attr.depth = sq->max_wqe;
 		hwq_attr.aux_depth = qplib_qp->msn_tbl_sz;
+	}
 	hwq_attr.type = HWQ_TYPE_QUEUE;
 	rc = bnxt_qplib_alloc_init_hwq(&sq->hwq, &hwq_attr);
 	if (rc)
@@ -1295,10 +1303,16 @@ static int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp)
 		      CMDQ_CREATE_QP_SQ_LVL_SFT);
 	sq->hwq.pg_sz_lvl = pg_sz_lvl;
 
+	if (qplib_qp->srq)
+		goto done;
+
 	hwq_attr.res = res;
 	hwq_attr.sginfo = &rq->sg_info;
 	hwq_attr.stride = bnxt_qplib_get_stride();
-	hwq_attr.depth = bnxt_qplib_get_depth(rq, qplib_qp->wqe_mode, false);
+	if (!is_dv_qp)
+		hwq_attr.depth = bnxt_qplib_get_depth(rq, qplib_qp->wqe_mode, false);
+	else
+		hwq_attr.depth = rq->max_wqe * 3;
 	hwq_attr.aux_stride = 0;
 	hwq_attr.aux_depth = 0;
 	hwq_attr.type = HWQ_TYPE_QUEUE;
@@ -1311,6 +1325,7 @@ static int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp)
 		      CMDQ_CREATE_QP_RQ_LVL_SFT);
 	rq->hwq.pg_sz_lvl = pg_sz_lvl;
 
+done:
 	if (qplib_qp->psn_sz) {
 		rc = bnxt_re_qp_alloc_init_xrrq(qp);
 		if (rc)
@@ -1379,7 +1394,7 @@ static struct bnxt_re_qp *bnxt_re_create_shadow_qp
 	qp->qplib_qp.rq_hdr_buf_size = BNXT_QPLIB_MAX_GRH_HDR_SIZE_IPV6;
 	qp->qplib_qp.dpi = &rdev->dpi_privileged;
 
-	rc = bnxt_re_setup_qp_hwqs(qp);
+	rc = bnxt_re_setup_qp_hwqs(qp, false);
 	if (rc)
 		goto fail;
 
@@ -1676,7 +1691,7 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 
 	bnxt_re_qp_calculate_msn_psn_size(qp);
 
-	rc = bnxt_re_setup_qp_hwqs(qp);
+	rc = bnxt_re_setup_qp_hwqs(qp, false);
 	if (rc)
 		goto free_umem;
 
@@ -1803,29 +1818,63 @@ static int bnxt_re_add_unique_gid(struct bnxt_re_dev *rdev)
 	return rc;
 }
 
-int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
-		      struct ib_udata *udata)
+static u64 bnxt_re_qp_cmask_supported = BNXT_RE_QP_REQ_MASK_DV_QP_ENABLE;
+
+int bnxt_re_create_qp_umem(struct ib_qp *ib_qp,
+			   struct ib_qp_init_attr *qp_init_attr,
+			   struct ib_umem *sq_umem, struct ib_umem *rq_umem,
+			   struct uverbs_attr_bundle *attrs)
 {
-	struct bnxt_qplib_dev_attr *dev_attr;
-	struct bnxt_re_ucontext *uctx;
-	struct bnxt_re_qp_req ureq;
-	struct bnxt_re_dev *rdev;
+	struct bnxt_re_qp *qp = container_of(ib_qp, struct bnxt_re_qp, ib_qp);
+	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ib_qp->device, ibdev);
+	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
+	struct ib_udata *udata = &attrs->driver_udata;
+	struct bnxt_re_ucontext *uctx = NULL;
+	struct bnxt_re_qp_req req = {};
 	struct bnxt_re_pd *pd;
-	struct bnxt_re_qp *qp;
 	struct ib_pd *ib_pd;
 	u32 active_qps;
 	int rc;
 
+	/* Get ucontext only if attrs->context is valid (userspace path) */
+	if (attrs->context)
+		uctx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
+
 	ib_pd = ib_qp->pd;
 	pd = container_of(ib_pd, struct bnxt_re_pd, ib_pd);
 	rdev = pd->rdev;
 	dev_attr = rdev->dev_attr;
-	qp = container_of(ib_qp, struct bnxt_re_qp, ib_qp);
 
-	uctx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
-	if (udata)
-		if (ib_copy_from_udata(&ureq, udata,  min(udata->inlen, sizeof(ureq))))
+	/* At this point, udata (attrs->driver_udata) is always valid,
+	 * since even for the kernel path we would have initialized it in
+	 * bnxt_re_create_qp(). But in kernel path, udata->inlen will be 0,
+	 * so we skip userspace data handling.
+	 */
+	if (udata->inlen) {
+		if (ib_copy_from_udata(&req, udata, min(sizeof(req), udata->inlen)))
 			return -EFAULT;
+		if (req.comp_mask & ~bnxt_re_qp_cmask_supported) {
+			ibdev_dbg(&rdev->ibdev,
+				  "Invalid QP comp_mask: 0x%llx supported: 0x%llx\n",
+				  req.comp_mask, bnxt_re_qp_cmask_supported);
+			return -EOPNOTSUPP;
+		}
+		if (req.comp_mask & BNXT_RE_QP_REQ_MASK_DV_QP_ENABLE) {
+			/* DV QP creation requires umem */
+			if (!sq_umem)
+				return -EINVAL;
+			/* rq_umem is optional if SRQ is used */
+			if (!qp_init_attr->srq && !rq_umem)
+				return -EINVAL;
+
+			return bnxt_re_dv_create_qp(rdev, udata, qp_init_attr, qp, &req,
+						    sq_umem, rq_umem);
+		}
+	}
+
+	/* Standard QP (non-DV): use req.qpsva/qprva */
+	if (sq_umem || rq_umem)
+		return -EINVAL;
 
 	rc = bnxt_re_test_qp_limits(rdev, qp_init_attr, dev_attr);
 	if (!rc) {
@@ -1834,7 +1883,7 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 	}
 
 	qp->rdev = rdev;
-	rc = bnxt_re_init_qp_attr(qp, pd, qp_init_attr, uctx, &ureq);
+	rc = bnxt_re_init_qp_attr(qp, pd, qp_init_attr, uctx, &req);
 	if (rc)
 		goto fail;
 
@@ -1852,7 +1901,7 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 			goto free_hwq;
 		}
 
-		if (udata) {
+		if (udata->outlen) {
 			struct bnxt_re_qp_resp resp;
 
 			resp.qpid = qp->qplib_qp.id;
@@ -1909,6 +1958,22 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 	return rc;
 }
 
+int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
+		      struct ib_udata *udata)
+{
+	struct uverbs_attr_bundle attrs_wrapper = {};
+	struct uverbs_attr_bundle *attrs;
+
+	if (udata) {
+		attrs = rdma_udata_to_uverbs_attr_bundle(udata);
+	} else {
+		/* Kernel path: use zero-initialized wrapper */
+		attrs = &attrs_wrapper;
+	}
+
+	return bnxt_re_create_qp_umem(ib_qp, qp_init_attr, NULL, NULL, attrs);
+}
+
 static u8 __from_ib_qp_state(enum ib_qp_state state)
 {
 	switch (state) {
@@ -2010,7 +2075,7 @@ static int bnxt_re_init_user_srq(struct bnxt_re_dev *rdev,
 				 struct bnxt_re_srq *srq,
 				 struct ib_udata *udata)
 {
-	struct bnxt_re_srq_req ureq;
+	struct bnxt_re_srq_req ureq = {};
 	struct bnxt_qplib_srq *qplib_srq = &srq->qplib_srq;
 	struct ib_umem *umem;
 	int bytes = 0;
@@ -3284,7 +3349,6 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 
 	bnxt_re_put_nq(rdev, nq);
 	ib_umem_release(cq->umem);
-
 	atomic_dec(&rdev->stats.res.cq_count);
 	kfree(cq->cql);
 	return 0;
@@ -3450,7 +3514,7 @@ int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
 	struct bnxt_qplib_dpi *orig_dpi = NULL;
 	struct bnxt_qplib_dev_attr *dev_attr;
 	struct bnxt_re_ucontext *uctx = NULL;
-	struct bnxt_re_resize_cq_req req;
+	struct bnxt_re_resize_cq_req req = {};
 	struct bnxt_re_dev *rdev;
 	struct bnxt_re_cq *cq;
 	int rc, entries;
@@ -4600,6 +4664,8 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 		}
 		resp.comp_mask |= BNXT_RE_UCNTX_CMASK_DV_CQ_SUPPORTED;
 		uctx->cmask |= BNXT_RE_UCNTX_CAP_DV_CQ_SUPPORTED;
+		resp.comp_mask |= BNXT_RE_UCNTX_CMASK_DV_QP_SUPPORTED;
+		uctx->cmask |= BNXT_RE_UCNTX_CAP_DV_QP_SUPPORTED;
 	}
 
 	rc = ib_copy_to_udata(udata, &resp, min(udata->outlen, sizeof(resp)));
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 1f6817d2a315..bd30101cca80 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -96,6 +96,8 @@ struct bnxt_re_qp {
 	struct bnxt_re_cq	*scq;
 	struct bnxt_re_cq	*rcq;
 	struct dentry		*dentry;
+	bool			is_dv_qp;
+	struct bnxt_re_dbr_obj *dbr_obj; /* doorbell region */
 };
 
 struct bnxt_re_cq {
@@ -191,6 +193,7 @@ enum {
 	BNXT_RE_UCNTX_CAP_POW2_DISABLED = 0x1ULL,
 	BNXT_RE_UCNTX_CAP_VAR_WQE_ENABLED = 0x2ULL,
 	BNXT_RE_UCNTX_CAP_DV_CQ_SUPPORTED = 0x4ULL,
+	BNXT_RE_UCNTX_CAP_DV_QP_SUPPORTED = 0x8ULL,
 };
 
 static inline u32 bnxt_re_init_depth(u32 ent, struct bnxt_re_ucontext *uctx)
@@ -245,6 +248,10 @@ int bnxt_re_post_srq_recv(struct ib_srq *srq, const struct ib_recv_wr *recv_wr,
 			  const struct ib_recv_wr **bad_recv_wr);
 int bnxt_re_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *qp_init_attr,
 		      struct ib_udata *udata);
+int bnxt_re_create_qp_umem(struct ib_qp *ib_qp,
+			   struct ib_qp_init_attr *qp_init_attr,
+			   struct ib_umem *sq_umem, struct ib_umem *rq_umem,
+			   struct uverbs_attr_bundle *attrs);
 int bnxt_re_modify_qp(struct ib_qp *qp, struct ib_qp_attr *qp_attr,
 		      int qp_attr_mask, struct ib_udata *udata);
 int bnxt_re_query_qp(struct ib_qp *qp, struct ib_qp_attr *qp_attr,
@@ -307,7 +314,15 @@ void bnxt_re_unlock_cqs(struct bnxt_re_qp *qp, unsigned long flags);
 struct bnxt_re_user_mmap_entry*
 bnxt_re_mmap_entry_insert(struct bnxt_re_ucontext *uctx, u64 mem_offset,
 			  enum bnxt_re_mmap_flag mmap_flag, u64 *offset);
+u8 __from_ib_qp_type(enum ib_qp_type type);
+int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp, bool is_dv_qp);
+void bnxt_re_qp_free_umem(struct bnxt_re_qp *qp);
 int bnxt_re_dv_create_cq(struct bnxt_re_dev *rdev, struct ib_udata *udata,
 			 struct bnxt_re_cq *re_cq, struct bnxt_re_cq_req *req,
 			 struct ib_umem *umem);
+int bnxt_re_dv_create_qp(struct bnxt_re_dev *rdev, struct ib_udata *udata,
+			 struct ib_qp_init_attr *init_attr,
+			 struct bnxt_re_qp *re_qp, struct bnxt_re_qp_req *req,
+			 struct ib_umem *sq_umem, struct ib_umem *rq_umem);
+int bnxt_re_dv_destroy_qp(struct bnxt_re_qp *qp);
 #endif /* __BNXT_RE_IB_VERBS_H__ */
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 401a481afecc..e38724812cc6 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1336,6 +1336,7 @@ static const struct ib_device_ops bnxt_re_dev_ops = {
 	.create_cq = bnxt_re_create_cq,
 	.create_cq_umem = bnxt_re_create_cq_umem,
 	.create_qp = bnxt_re_create_qp,
+	.create_qp_umem = bnxt_re_create_qp_umem,
 	.create_srq = bnxt_re_create_srq,
 	.create_user_ah = bnxt_re_create_ah,
 	.dealloc_pd = bnxt_re_dealloc_pd,
diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index 4c079d60b43d..621048741a43 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -57,6 +57,7 @@ enum {
 	BNXT_RE_UCNTX_CMASK_POW2_DISABLED = 0x10ULL,
 	BNXT_RE_UCNTX_CMASK_MSN_TABLE_ENABLED = 0x40,
 	BNXT_RE_UCNTX_CMASK_DV_CQ_SUPPORTED = 0x80,
+	BNXT_RE_UCNTX_CMASK_DV_QP_SUPPORTED = 0x100,
 };
 
 enum bnxt_re_wqe_mode {
@@ -125,6 +126,7 @@ struct bnxt_re_resize_cq_req {
 
 enum bnxt_re_qp_mask {
 	BNXT_RE_QP_REQ_MASK_VAR_WQE_SQ_SLOTS = 0x1,
+	BNXT_RE_QP_REQ_MASK_DV_QP_ENABLE = 0x2,
 };
 
 struct bnxt_re_qp_req {
@@ -133,6 +135,15 @@ struct bnxt_re_qp_req {
 	__aligned_u64 qp_handle;
 	__aligned_u64 comp_mask;
 	__u32 sq_slots;
+	__u32 sq_wqe_sz;
+	__u32 sq_psn_sz;
+	__u32 sq_npsn;
+	__u32 rq_slots;
+	__u32 rq_wqe_sz;
+};
+
+enum bnxt_re_create_qp_attrs {
+	BNXT_RE_CREATE_QP_ATTR_DBR_HANDLE = UVERBS_ID_DRIVER_NS_WITH_UHW,
 };
 
 struct bnxt_re_qp_resp {
-- 
2.51.2.636.ga99f379adf


