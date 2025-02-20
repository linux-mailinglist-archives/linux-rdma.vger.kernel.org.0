Return-Path: <linux-rdma+bounces-7912-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CEEA3E472
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 20:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F38516FC27
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 18:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DEA2641DF;
	Thu, 20 Feb 2025 18:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bUGHchtp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFB32641DE
	for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2025 18:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077782; cv=none; b=e4ISIzbQGqzZ5FG1WbeAveAqAeq46/jaDMbPFuRT0SjOHPVSy19ITbZJ+EqFIE/h144IG8Hb4x7PRBwQ+/VVJvYeGS8JkK3EFo2i+mA0Geqks0mz6pqJ1Zzl92pWXGR3AD4yZfRYehHVOaj+Gbd70rmL8R3IHcAMFghAfFPe950=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077782; c=relaxed/simple;
	bh=ps9j0Wix5FxOg6J4lOpwhIo0pwUPZtapGIIm3Ker8C8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=XBMASTO+9IiRWbYeVkfbvLwb1toZq7PfZqn2Jw+AGSYAPuR+T9T/9yLvidpZRZHvwblLZyvi+q2vF2xcAxBxoZt1zCUZA2/jXWqaWEoBdTAdxdDbraZrnkIvm3kVUsbHNszX88xyX+0xr5NxEmmrZbMdmvkP+JODJ83BC+jc3E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bUGHchtp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220d601886fso20261525ad.1
        for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2025 10:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1740077780; x=1740682580; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tif6h+vIQ6/biBxnmUJxR84piPWX45JJ651sYhwJ4MA=;
        b=bUGHchtplBXLKm8Rk3lJo84LP25Yj4pfjWc7sMUIBtgO8w7ZhoV0/di4HrhBAt6qbD
         LwE4rcicn4EQnf/tndGKWC3h357DwLjSRyrKKz0LZ/r4XgxrD28jzDLtySI1YL8+/9ha
         yWqmbC9q7KkVOCIu4wdA91gsxB7gjZsb6Re4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740077780; x=1740682580;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tif6h+vIQ6/biBxnmUJxR84piPWX45JJ651sYhwJ4MA=;
        b=Mu75OpQgThfFQH3GBVC9oJgE/7ZTpWRtiVSTWnpao1HuQc2KNac3Ra7WWVTorErf9Q
         Zxp91U+W4srN7/JCNVLl2FrjacWzZGwMTJTncGsinBuTiSirn+5se849QetadRyqpq4G
         R2ldcwPnQtk9UFoEn2D9oYKBPtiIe8B/f8IA8Ds8qNLYEUBq9xMxLEiDPFssK5dGqFt/
         j2jx3zGGkJJN4VPIMHziS7xP4DRV0gbyfBT+WtPnt59EHfU0aLIKWxZ9dcVwUcz7zisn
         M0b5eB7/J36v4lJ9Wtcxsa5exDFl5X4l14G1ZEkxLh2ptSsHtN31iDqBaJ3gsszitFcY
         RxQQ==
X-Gm-Message-State: AOJu0Yx8fwJ3rO0NgRDcDq4uqnDAHaV9s26FZGqaKfpY5TWG0Ih0SXXT
	1zq/9PDhOErNa21Na/vyQe4Y/5CZtjZyHklq7nEESZ2aOP3gRu1dcAzAGawkiw==
X-Gm-Gg: ASbGncsz+OjXn/+uxsJ/PyIIxtspH9t4R04vU9uW9ltLDvJcvrmN707sUsh7WBu4zrK
	uJ83I71dnrHdvKJKDcWkYFgTilXBgNDYbDHC1gLnk999gWh6SLTKbPvfZDczNWt8UoFnWhX4FEC
	mq5nLuGK2MgdqUObrb8knpYCHGmKhQuN4owimgTSThLbKFSithxEGL/81mwUVkDaHgYPEySz3Lv
	Ky8PSnSof4EiAJG/G6eWE8m9qQx38H5nFswmxD6fg6FCSE0RPLcacTGVaeaH2T8tdPsgsxFtBEA
	UATeGEyaEn+v5Vq6lr451f+NUImNshuBbl9m0mIraXTH4drxflxePx8IrBthrr1ohkbdFuo=
X-Google-Smtp-Source: AGHT+IFw4WLUXvlZeVZ7DNjlcwoAVhBgMp/91u56hwsVYXz4XkQ5BCYpHuWdsyyiEkUv1s+GRqSPCw==
X-Received: by 2002:a05:6a21:6b0f:b0:1ee:c093:e23c with SMTP id adf61e73a8af0-1eef3db70e6mr504945637.41.1740077780108;
        Thu, 20 Feb 2025 10:56:20 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-addee79a984sm9572262a12.32.2025.02.20.10.56.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Feb 2025 10:56:19 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	abeni@redhat.com,
	horms@kernel.org,
	michael.chan@broadcom.com,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-next 8/9] RDMA/bnxt_re: Dump the HW context information
Date: Thu, 20 Feb 2025 10:34:55 -0800
Message-Id: <1740076496-14227-9-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1740076496-14227-1-git-send-email-selvin.xavier@broadcom.com>
References: <1740076496-14227-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kashyap Desai <kashyap.desai@broadcom.com>

Dump the cached HW context information for QP/CQ/SRQ/MRs
when the L2 driver queries using get_dump_data

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 10 ++++-----
 drivers/infiniband/hw/bnxt_re/main.c     | 38 ++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index a1ee6ca..dca435e 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1079,7 +1079,7 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 	struct bnxt_qplib_nq *rcq_nq = NULL;
 	unsigned int flags;
 	void  *ctx_sb_data = NULL;
-	bool do_snapdump;
+	bool do_snapdump = false;
 	u16 ctx_size;
 	int rc;
 
@@ -1087,17 +1087,15 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 	bnxt_re_debug_rem_qpinfo(rdev, qp);
 
 	bnxt_qplib_flush_cqn_wq(&qp->qplib_qp);
-	ctx_size = qplib_qp->ctx_size_sb;
+	ctx_size = rdev->rcfw.qp_ctxm_size;
 	if (ctx_size)
 		ctx_sb_data = vzalloc(ctx_size);
-	do_snapdump = test_bit(QP_FLAGS_CAPTURE_SNAPDUMP, &qplib_qp->flags);
 
 	rc = bnxt_qplib_destroy_qp(&rdev->qplib_res, &qp->qplib_qp, ctx_size, ctx_sb_data);
 	if (rc)
 		ibdev_err(&rdev->ibdev, "Failed to destroy HW QP");
-	else
-		bnxt_re_save_resource_context(rdev, ctx_sb_data,
-					      BNXT_RE_RES_TYPE_QP, do_snapdump);
+	do_snapdump = test_bit(QP_FLAGS_CAPTURE_SNAPDUMP, &qplib_qp->flags);
+	bnxt_re_save_resource_context(rdev, ctx_sb_data,  BNXT_RE_RES_TYPE_QP, do_snapdump);
 
 	vfree(ctx_sb_data);
 	if (rdma_is_kernel_res(&qp->ib_qp.res)) {
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index afde0ef..b2bf0d0 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -506,6 +506,44 @@ static void bnxt_re_start_irq(void *handle, struct bnxt_msix_entry *ent)
 static void bnxt_re_dump_ctx(struct bnxt_re_dev *rdev, u32 seg_id, void *buf,
 			     u32 buf_len)
 {
+	int ctx_index, i;
+	void *ctx_data;
+	u16 ctx_size;
+
+	switch (seg_id) {
+	case BNXT_SEGMENT_QP_CTX:
+		ctx_data = rdev->rcfw.qp_ctxm_data;
+		ctx_size = rdev->rcfw.qp_ctxm_size;
+		ctx_index = rdev->rcfw.qp_ctxm_data_index;
+		break;
+	case BNXT_SEGMENT_CQ_CTX:
+		ctx_data = rdev->rcfw.cq_ctxm_data;
+		ctx_size = rdev->rcfw.cq_ctxm_size;
+		ctx_index = rdev->rcfw.cq_ctxm_data_index;
+		break;
+	case BNXT_SEGMENT_MR_CTX:
+		ctx_data = rdev->rcfw.mrw_ctxm_data;
+		ctx_size = rdev->rcfw.mrw_ctxm_size;
+		ctx_index = rdev->rcfw.mrw_ctxm_data_index;
+		break;
+	case BNXT_SEGMENT_SRQ_CTX:
+		ctx_data = rdev->rcfw.srq_ctxm_data;
+		ctx_size = rdev->rcfw.srq_ctxm_size;
+		ctx_index = rdev->rcfw.srq_ctxm_data_index;
+		break;
+	default:
+		return;
+	}
+
+	if (!ctx_data || (ctx_size * BNXT_RE_MAX_QDUMP_ENTRIES) > buf_len)
+		return;
+
+	for (i = ctx_index; i < BNXT_RE_MAX_QDUMP_ENTRIES + ctx_index; i++) {
+		memcpy(buf, ctx_data + ((i % BNXT_RE_MAX_QDUMP_ENTRIES) * ctx_size),
+		       ctx_size);
+		buf += ctx_size;
+	}
+
 }
 
 /*
-- 
2.5.5


