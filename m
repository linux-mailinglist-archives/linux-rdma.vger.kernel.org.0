Return-Path: <linux-rdma+bounces-6844-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E17A02E0D
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 17:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9656A18847E5
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 16:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3AA1DFD86;
	Mon,  6 Jan 2025 16:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOeYQxOB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D301DF977;
	Mon,  6 Jan 2025 16:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736181729; cv=none; b=mPjVYu4mTwfv5/V1Ktocs0QCDNgH2Hc++IBUvQx+FZdUuGA9SsyQVj3w3ni+tjnxEros05uMc9P1DS/cY/7Bud6dvxnpjO14ahGZzqN0SMWInGYmXV4G1q7iCCtuG+ssD58/ewI0dH2p7Rdx7hQr2rtGRY6BGqFim4advWmjzNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736181729; c=relaxed/simple;
	bh=Y8fYE1YFF8k0KskaUUCPy3tiBp5tshWng+TrJSW92qk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HUChTz7G8uDNJmwWX4VtZ7jYono4e0YOecpkfIWzzwnJmfCvBcv+G90XzGm8tLNw/WTA+Ry/X3cTAgAbzQXUTQC2yC0K56gwttelrruZKiUSrFLtnaDRVlVK/HkAn+gsmnVZG8nvYRvxM4HZAnkUmGyMVh3LsF415v8PyeIiItw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOeYQxOB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D6CC4CED6;
	Mon,  6 Jan 2025 16:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736181728;
	bh=Y8fYE1YFF8k0KskaUUCPy3tiBp5tshWng+TrJSW92qk=;
	h=From:To:Cc:Subject:Date:From;
	b=HOeYQxOBsTjPnrmM8veIXCcYUMln2riVu23+RXIevPOjH5ADwriuENfk027Uvk4OD
	 oWF91RbuclEbiEZZ+WRaGgjq9YxwaSX76Q67g4GZRSa0Qve60vvQkmBeubep+uSHp3
	 GCqlUKtzLyVGRjkb8TSsHMxTjSVgZTFW7dUqghIcTpSSI9axAEjfXOoHkdVPRsfR0K
	 HD4eOaR/C+ESf98npFfenRP+wbINrjiQKujiY4bSlwYrgXUEPOY9yKnXNVAk+Kjhfd
	 PXvypz5N4LXIXYkBjpmETaOEnmPym8okPZs/+5OprztZGPYG5HjQ7Bhgl0JJ16JSBy
	 DHxvMga73DMfQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hongguang Gao <hongguang.gao@broadcom.com>,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 1/2] RDMA/bnxt_re: Fix to export port num to ib_query_qp
Date: Mon,  6 Jan 2025 11:42:04 -0500
Message-Id: <20250106164206.1122310-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.69
Content-Transfer-Encoding: 8bit

From: Hongguang Gao <hongguang.gao@broadcom.com>

[ Upstream commit 34db8ec931b84d1426423f263b1927539e73b397 ]

Current driver implementation doesn't populate the port_num
field in query_qp. Adding the code to convert internal firmware
port id to ibv defined port number and export it.

Reviewed-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Hongguang Gao <hongguang.gao@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Link: https://patch.msgid.link/20241211083931.968831-5-kalesh-anakkur.purayil@broadcom.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 1 +
 drivers/infiniband/hw/bnxt_re/ib_verbs.h | 4 ++++
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 1 +
 drivers/infiniband/hw/bnxt_re/qplib_fp.h | 1 +
 4 files changed, 7 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index df5897260601..5f6b1d7278da 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -2214,6 +2214,7 @@ int bnxt_re_query_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 	qp_attr->retry_cnt = qplib_qp->retry_cnt;
 	qp_attr->rnr_retry = qplib_qp->rnr_retry;
 	qp_attr->min_rnr_timer = qplib_qp->min_rnr_timer;
+	qp_attr->port_num = __to_ib_port_num(qplib_qp->port_id);
 	qp_attr->rq_psn = qplib_qp->rq.psn;
 	qp_attr->max_rd_atomic = qplib_qp->max_rd_atomic;
 	qp_attr->sq_psn = qplib_qp->sq.psn;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 98baea98fc17..ef910e6e2ccb 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -245,6 +245,10 @@ void bnxt_re_dealloc_ucontext(struct ib_ucontext *context);
 int bnxt_re_mmap(struct ib_ucontext *context, struct vm_area_struct *vma);
 void bnxt_re_mmap_free(struct rdma_user_mmap_entry *rdma_entry);
 
+static inline u32 __to_ib_port_num(u16 port_id)
+{
+	return (u32)port_id + 1;
+}
 
 unsigned long bnxt_re_lock_cqs(struct bnxt_re_qp *qp);
 void bnxt_re_unlock_cqs(struct bnxt_re_qp *qp, unsigned long flags);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index b624c255eee6..00df8360dcd8 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -1451,6 +1451,7 @@ int bnxt_qplib_query_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	qp->dest_qpn = le32_to_cpu(sb->dest_qp_id);
 	memcpy(qp->smac, sb->src_mac, 6);
 	qp->vlan_id = le16_to_cpu(sb->vlan_pcp_vlan_dei_vlan_id);
+	qp->port_id = le16_to_cpu(sb->port_id);
 bail:
 	dma_free_coherent(&rcfw->pdev->dev, sbuf.size,
 			  sbuf.sb, sbuf.dma_addr);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index 5d4c49089a20..0e0df5083ed3 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -297,6 +297,7 @@ struct bnxt_qplib_qp {
 	u32				dest_qpn;
 	u8				smac[6];
 	u16				vlan_id;
+	u16				port_id;
 	u8				nw_type;
 	struct bnxt_qplib_ah		ah;
 
-- 
2.39.5


