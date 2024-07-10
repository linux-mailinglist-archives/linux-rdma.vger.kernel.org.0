Return-Path: <linux-rdma+bounces-3789-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBF292D174
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 14:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2D431F26079
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 12:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE6D189F31;
	Wed, 10 Jul 2024 12:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="TCjsYYjA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51BC7D412
	for <linux-rdma@vger.kernel.org>; Wed, 10 Jul 2024 12:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720614068; cv=none; b=E6krSkKQMiBiX9WO2BAqQYB1iA6CX/r8J36KEeQqDxky66X+ucVdAmD06KGR4NCd8LWe8ZTsH/J9Xp9/Gt847YRiQqqekilC+acx+OX1U+dG69R8AdUYiHHeBfD4LebQxmGe4TD3KVNOD4Wt7QqNvhzYD3EkaZSxcjomsMXzsis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720614068; c=relaxed/simple;
	bh=QN5qzUQ6u/B4b15wGqcHD8cM6Ask1G/Oc2sU5PGeHIg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FP+ilfUOZIYTkdAFHm/7L4TBoyQi3FqMetetQREpfekBrERC+Lp+0yg+toqiOXluCwr3gIaFyjDuXF0Z9xA4CLWRUVBnU9AuNfhU1Q6f+/IphlKxIgNrcqO2YiS5pGgBhrmsCbtf798YzAP9O5MDoj87lLyemNG2lve06tmohQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=TCjsYYjA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4277a5ed48bso6520855e9.2
        for <linux-rdma@vger.kernel.org>; Wed, 10 Jul 2024 05:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1720614063; x=1721218863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R+1xJCiU5xIFHwcGLz2bWKsSiY17RsxEgFnaH7mPRmI=;
        b=TCjsYYjAWECFhEXq7/SKoJC6lS/K67w73UFvLYEwq2Ko+XXcGm61Cy0KDBr2EX4Brw
         Qxax+4lOeL+AR57aS7F+Pf7dHgsDObbqY+eQZ+vEXYWSkiNf12jOcKToD7Zd6Uy9YaL7
         sHXUZ8fsh1obOYvkSCBIsAxebjD0AvHqv73V604/ybJmR3nC5JZU0dfZ7qXDujMNgR0B
         WdFiyvUiC5oOjUhetGmJqAP/3SDKpH+8UIlGw/2X3v+g5/u+hHfXqCbYeHAFOUtQ8zPo
         XnaXkW+/Uf3GSBJdY+h2YEGl9SU8nGZyyv1x34xLoSq+VLPl9YpqIuQnvyZfiHWJ5JEL
         aIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720614063; x=1721218863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+1xJCiU5xIFHwcGLz2bWKsSiY17RsxEgFnaH7mPRmI=;
        b=JhzTDTHpN3X70TSrFx92OIyqm1B+SwY/UqOzS+ojV4CoTMZt5gwOPGl3flKifhaGHk
         dTVhep2+o+WSUr/M90sSlLRlbr4fX8LC3SeQLF7TO1k5G6BKtVsaTata2PCmRzXczB7C
         rRioRVP9y2P+th3kGGpybgV5xYnJNq1OTIkTkPKFV2sk1DHr+96f210xPD9x4Wxv2ZOW
         BDsPgQoHwwIC0r19XCUQcLfaH8ak6B8bZvHBhMUb9pnlreQlNIONgCwugDCjwYKraEF1
         223VSoCbfswBF4Gin8pNjyRThAi1KxbKfvJEGjtSRa9mjduDGYQtfmAa3a4UyzHKYHWa
         F60g==
X-Gm-Message-State: AOJu0YzB+iOodF+OQSRwDg47EQdJAU1lYYerBjvHCT6xWe5WF0/oVY0L
	nf4G3/1eOiEyfOtpwmt8/I11Ru1n5ocijkSC5LYQJvjRQkDloxMU40CkJ8EHm7RngI80lsZhxqR
	3
X-Google-Smtp-Source: AGHT+IEm7XJ9+3BdWpQBUyqMjbua6MuFnc7t/im6f/kCYQws8WTuoxoRu4483i65udHu8DYxDW7bcA==
X-Received: by 2002:a5d:4442:0:b0:367:97b1:b22a with SMTP id ffacd0b85a97d-367cea67e92mr3232097f8f.20.1720614063402;
        Wed, 10 Jul 2024 05:21:03 -0700 (PDT)
Received: from lb02065.pb.local ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde847b1sm5174956f8f.42.2024.07.10.05.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 05:21:03 -0700 (PDT)
From: Jack Wang <jinpu.wang@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: selvin.xavier@broadcom.com,
	leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com
Subject: [PATCHv2] bnxt_re: Fix imm_data endianness
Date: Wed, 10 Jul 2024 14:21:02 +0200
Message-Id: <20240710122102.37569-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
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

In off list discussion, Selvin confirm HW is working in little endian format
and all data needs to be converted to LE while providing.

This patch fix the endianness for imm_data

Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
v2: address comment from Selvin, drop second patch.
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 8 ++++----
 drivers/infiniband/hw/bnxt_re/qplib_fp.h | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index e453ca701e87..7c757351a016 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -2479,7 +2479,7 @@ static int bnxt_re_build_send_wqe(struct bnxt_re_qp *qp,
 		break;
 	case IB_WR_SEND_WITH_IMM:
 		wqe->type = BNXT_QPLIB_SWQE_TYPE_SEND_WITH_IMM;
-		wqe->send.imm_data = wr->ex.imm_data;
+		wqe->send.imm_data = be32_to_cpu(wr->ex.imm_data);
 		break;
 	case IB_WR_SEND_WITH_INV:
 		wqe->type = BNXT_QPLIB_SWQE_TYPE_SEND_WITH_INV;
@@ -2509,7 +2509,7 @@ static int bnxt_re_build_rdma_wqe(const struct ib_send_wr *wr,
 		break;
 	case IB_WR_RDMA_WRITE_WITH_IMM:
 		wqe->type = BNXT_QPLIB_SWQE_TYPE_RDMA_WRITE_WITH_IMM;
-		wqe->rdma.imm_data = wr->ex.imm_data;
+		wqe->rdma.imm_data = be32_to_cpu(wr->ex.imm_data);
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
index 4aaac84c1b1b..56538b90d6c5 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -164,7 +164,7 @@ struct bnxt_qplib_swqe {
 		/* Send, with imm, inval key */
 		struct {
 			union {
-				__be32	imm_data;
+				u32	imm_data;
 				u32	inv_key;
 			};
 			u32		q_key;
@@ -182,7 +182,7 @@ struct bnxt_qplib_swqe {
 		/* RDMA write, with imm, read */
 		struct {
 			union {
-				__be32	imm_data;
+				u32	imm_data;
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


