Return-Path: <linux-rdma+bounces-3771-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCC992BDB0
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 17:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2FC71C2397E
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 15:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2079019D899;
	Tue,  9 Jul 2024 15:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="dNWNUutl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB2D19CD11
	for <linux-rdma@vger.kernel.org>; Tue,  9 Jul 2024 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720537288; cv=none; b=ZssKrVz0yyklJxKhWi7LBtXm1zTqcef/XbTCXdiMksBBxZBcBzhOlE2GepgjN/p2kLr3jgofgnSP0olz4bhM9ZY8lbiNIzBiEGvE7QAYDvwJJYDd7aDtLnYvXzRgBjq1Wlvp0YfRyDdvOWLuAQ3+YJSHk8B5RAL2xlbde8A+KYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720537288; c=relaxed/simple;
	bh=c0KoLXoRQKOE+iw7pZVO9/OP4bNiSGfP3rLJ7YXxCd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QTyJs7OWr1wd37pKE0Ns1DK6NUhg1o4aSuZ0jrA7+9KzCIGaXa+ARxqX6B5FOhNcR0FKQgiY39/exNEqTg4agrxK7Cgd/h43sxm6Kw11+Wrq7XTnqvWFq81r6J0u65sKQNEr7H2E48YDyCFPhwYHQVNe+0dyBz1aYjBI2vRSjck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=dNWNUutl; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-58b0dddab8cso7789889a12.0
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jul 2024 08:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1720537282; x=1721142082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBXPBGTYOojItKAzX7jkgiz3uyYlSKioXedMWKxUIW0=;
        b=dNWNUutll4jdsxGrtO/Wsw0xadz4TCSmkCHTV6RGnc8HuGcqEfUY68pYxtRMLmgMDF
         B1jpRmqn0XJUGAQNX9N61axbHreZi+hrTg4NcQnLbygNMARXDAnMGGKCK0DzQWMAYLQT
         WGXCnsmOxTbWaEDm9dB4uf563cyHCRXdj8uHE/HalxFWtRlzCEm2WqEeLzmGhPhEP+w+
         imlRUd6ieq7a8n9tH3/ibmh/5hmJykYLedHUHo2586yHL2Gqp86keNVsbH7Q7MQT/YNl
         87vtiYyC/3VlVlUDxpT3e+HVEgI3NZPdJqog2ox5Zhk7O4lqTAHNEEKDoEfooBQBoe3q
         QRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720537282; x=1721142082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yBXPBGTYOojItKAzX7jkgiz3uyYlSKioXedMWKxUIW0=;
        b=tH4bXluQVCW7w9imnMCEau5hGeFqDEuQFhgQhpYFHSU256q9cVuXXl+vc4MAHf016Y
         kQ3FnyOZ7WzVdzuhZc/jaut1mza6cTc3dwxQLAwH+A4O5uf7VAWbI574ftQldRyUN1Es
         v9vGciJu3Tx8ttVS3lglaggJiudivXgbOxioHTTZ9C+lXJJvBiIflcI2e5oLI4Bf8uay
         AvP4Z0WEtcMJn0DCpZoDzRQlCFzyfZa4yY8Krdzo7v+27Hf/3bBh9qhmeT7hVLjn4lar
         qeTbP0ZISLkyNI1S7iDztRqFqUj84n4wNAOBtLeCbH5tYiSVzXl6Cs87Pn3dYz85mHmk
         8kMw==
X-Gm-Message-State: AOJu0Yx7G2hVG/cVCJDBAppenzEFxnK3edo4jOWWHEaOocXjtERysDY6
	6T10rG/9Px+c//BwqUzWLaAWaSQeXjWhye9Ce2Elal1m5ITi2AOXcvGp14UpGm/xCrf+6RtVRMw
	S
X-Google-Smtp-Source: AGHT+IFTXd9d/plY2kD+hBHfpwW3y2c32FIynIbEXS35LPP21Pn+EC9Sx7dtspDACaaklXmfzPtvMQ==
X-Received: by 2002:aa7:da0f:0:b0:57a:2ccb:b3f2 with SMTP id 4fb4d7f45d1cf-594bb18046cmr1624859a12.16.1720537282623;
        Tue, 09 Jul 2024 08:01:22 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:1436:4f00:2ca:d136:a29a:bb96])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bc4e80c6sm1166172a12.46.2024.07.09.08.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 08:01:21 -0700 (PDT)
From: Jack Wang <jinpu.wang@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: bvanassche@acm.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	selvin.xavier@broadcom.com,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com
Subject: [PATCH for-next 1/2] bnxt_re: Fix imm_data endianness
Date: Tue,  9 Jul 2024 17:01:18 +0200
Message-Id: <20240709150119.29937-2-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240709150119.29937-1-jinpu.wang@ionos.com>
References: <20240709150119.29937-1-jinpu.wang@ionos.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When map a device between servers with MLX and BCM RoCE nics, RTRS
server complain about unknown imm type, and can't map the device,

After more debug, it seems bnxt_re wrongly handle the
imm_data, this patch fixed the compat issue with MLX for us.

In offlist discussion, Selvin confirm HW is working in little endian
format and all data needs to be converted to LE while providing.

This patch fix the endianness for imm_data

Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 8 ++++----
 drivers/infiniband/hw/bnxt_re/qplib_fp.h | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index e453ca701e87..c5080028247e 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -2479,7 +2479,7 @@ static int bnxt_re_build_send_wqe(struct bnxt_re_qp *qp,
 		break;
 	case IB_WR_SEND_WITH_IMM:
 		wqe->type = BNXT_QPLIB_SWQE_TYPE_SEND_WITH_IMM;
-		wqe->send.imm_data = wr->ex.imm_data;
+		wqe->send.imm_data = cpu_to_le32(be32_to_cpu(wr->ex.imm_data));
 		break;
 	case IB_WR_SEND_WITH_INV:
 		wqe->type = BNXT_QPLIB_SWQE_TYPE_SEND_WITH_INV;
@@ -2509,7 +2509,7 @@ static int bnxt_re_build_rdma_wqe(const struct ib_send_wr *wr,
 		break;
 	case IB_WR_RDMA_WRITE_WITH_IMM:
 		wqe->type = BNXT_QPLIB_SWQE_TYPE_RDMA_WRITE_WITH_IMM;
-		wqe->rdma.imm_data = wr->ex.imm_data;
+		wqe->rdma.imm_data = cpu_to_le32(be32_to_cpu(wr->ex.imm_data));
 		break;
 	case IB_WR_RDMA_READ:
 		wqe->type = BNXT_QPLIB_SWQE_TYPE_RDMA_READ;
@@ -3582,7 +3582,7 @@ static void bnxt_re_process_res_shadow_qp_wc(struct bnxt_re_qp *gsi_sqp,
 	wc->byte_len = orig_cqe->length;
 	wc->qp = &gsi_qp->ib_qp;
 
-	wc->ex.imm_data = orig_cqe->immdata;
+	wc->ex.imm_data = cpu_to_be32(le32_to_cpu(orig_cqe->immdata));
 	wc->src_qp = orig_cqe->src_qp;
 	memcpy(wc->smac, orig_cqe->smac, ETH_ALEN);
 	if (bnxt_re_is_vlan_pkt(orig_cqe, &vlan_id, &sl)) {
@@ -3727,7 +3727,7 @@ int bnxt_re_poll_cq(struct ib_cq *ib_cq, int num_entries, struct ib_wc *wc)
 				 (unsigned long)(cqe->qp_handle),
 				 struct bnxt_re_qp, qplib_qp);
 			wc->qp = &qp->ib_qp;
-			wc->ex.imm_data = cqe->immdata;
+			wc->ex.imm_data = cpu_to_be32(le32_to_cpu(cqe->immdata));
 			wc->src_qp = cqe->src_qp;
 			memcpy(wc->smac, cqe->smac, ETH_ALEN);
 			wc->port_num = 1;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index 4aaac84c1b1b..1fcaba0f680b 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -164,7 +164,7 @@ struct bnxt_qplib_swqe {
 		/* Send, with imm, inval key */
 		struct {
 			union {
-				__be32	imm_data;
+				__le32	imm_data;
 				u32	inv_key;
 			};
 			u32		q_key;
@@ -182,7 +182,7 @@ struct bnxt_qplib_swqe {
 		/* RDMA write, with imm, read */
 		struct {
 			union {
-				__be32	imm_data;
+				__le32	imm_data;
 				u32	inv_key;
 			};
 			u64		remote_va;
@@ -389,7 +389,7 @@ struct bnxt_qplib_cqe {
 	u16				cfa_meta;
 	u64				wr_id;
 	union {
-		__be32			immdata;
+		__le32			immdata;
 		u32			invrkey;
 	};
 	u64				qp_handle;
-- 
2.34.1


