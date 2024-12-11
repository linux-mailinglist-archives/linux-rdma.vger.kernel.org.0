Return-Path: <linux-rdma+bounces-6425-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9139EC78E
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 09:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A664188C5D6
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 08:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8450A1DC9A1;
	Wed, 11 Dec 2024 08:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iAkD5c6u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99E08489
	for <linux-rdma@vger.kernel.org>; Wed, 11 Dec 2024 08:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733906655; cv=none; b=W30NnKjZkJocbJmPT7LbN6cHxcl2X5kByQFSH90PbYAuzUsBw0Eof2SPrFJob1fgimtIz739WCjjz8jZslE+eUnzMxnXJ5wvGiVubZVr5BBIc6FJelTkIZN5aJOu8IVnk+bULPt2BSfo+4RlOzh0QxY7CChkl3wss3lEAymZPGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733906655; c=relaxed/simple;
	bh=JO+OpSU8MvmQ1UWMUbgmZAFK7dV9bjSJcvWIKMqTzTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6RFQvq2r+4ftUEwF7ppjtufHxoEmNnRvocr2RjkW/u4Z8hRekQPzgc/I7VDAAo8Zao0kEK+gPw2Kgav0x+NKzleLjlNcUzS/wrxCrKtM5BHjGdi3DsyuUZsoZkcto6Fz/kf5yNK0s71q7Zp6YKsYOXe5YarGctJ8ky6wKtHO2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iAkD5c6u; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-728eccf836bso528380b3a.1
        for <linux-rdma@vger.kernel.org>; Wed, 11 Dec 2024 00:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733906653; x=1734511453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJOo8gP747NtNeOZi4XrtYcBlguXNINF6EUthHmxZCU=;
        b=iAkD5c6uQDENnBuORCQ25gMUIr7R/zD6rNaTcpxPrYSMxlPldK818BJqsLvorb28d9
         6G3isu0Kjd6hYJiWbLDcO/VXZGP0fXavg1OR5fVDw4Mix1fMJlnXetaf7yC6EphoB6es
         a7hqwuJOVmhz1B6qgm7hKCQugESrSx/begH2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733906653; x=1734511453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJOo8gP747NtNeOZi4XrtYcBlguXNINF6EUthHmxZCU=;
        b=NQ/zjVe2i9K5TOAuK6/lC9XJedZl9F6mpks6kIQm7GKFwPC5Q/xwASRtpg2OG55oZp
         82UgMNqRJAko5cYIcWT59d8MmgkZaUMiuJaF8aTgIKPaaBc3iqPRoHZVgjZFUpsiZitT
         4Vinf5vs27HFIP6XvMSvwJPM2GE3J7lh2Fse+SK3xb3Qp3faA1nl/fEyg68x6Yw3j67j
         YkTRkQTHH9RSDL7aLIRM58vmV5rLw5XRv24rYliuLVfjp1ndQL3XUlamI5VoN7sTZ1Jp
         miMEIzf6BBaLQYaBTeScc82z5be0V/2oCuCJzMbTp349Dm3lOze7+aZlUfjpDOFCcRqO
         7svA==
X-Gm-Message-State: AOJu0Yy/GWmOJPBtl8ASBFsPnnGn4yB09uHlhlntEaVOZYldv1XaoYLi
	mN/05gRGgKyOwRywerV1wUO8seFmhhh4l1hp/04ZTki+YqqK0Xkw8fCAq+4P4g==
X-Gm-Gg: ASbGncsBaIIdhVxQk2g9rH9AV16MQ1NX4E/kXE/8flSpPNDKsTQCrQabCHHN5CZkxpc
	8JjkXE3I/93Gk0AaxxTsumbLeEi7YOhYtEB2nhRtLadqt9v2nCHSRVKiDL8ME4MalDJgq5WfbnL
	QRRvDcIUj6h2ThQj1fUefHnzDzbB8DIzD1Khui3DlcAgb+tLEAK59dSn9hfYGE3Tb8tcpuh2HF3
	l7s6kn1VQsvKU0nItKK7fArefqaeOmPV3T0weU6JwO/f10teQZt3lwalvnmsYC3LNFFE4b+azjt
	vWSnVeKD6cLTOJNxYawPhUt9Hk/uBKnI2JwonTKaY8LlcGB8d7jhdQOw
X-Google-Smtp-Source: AGHT+IEGHLsmQaABjBHlBTn/uv1egtnkZ07GrjK/iTmXONmDhzZZ5VUlyD078C33lvy5LG1A4AatJA==
X-Received: by 2002:a05:6a00:855:b0:725:96b1:d217 with SMTP id d2e1a72fcca58-728ed3c74a8mr3072114b3a.9.1733906652736;
        Wed, 11 Dec 2024 00:44:12 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7273b69ce95sm3653678b3a.66.2024.12.11.00.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 00:44:12 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Hongguang Gao <hongguang.gao@broadcom.com>,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH for-rc 4/5] RDMA/bnxt_re: Fix to export port num to ib_query_qp
Date: Wed, 11 Dec 2024 14:09:30 +0530
Message-ID: <20241211083931.968831-5-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241211083931.968831-1-kalesh-anakkur.purayil@broadcom.com>
References: <20241211083931.968831-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongguang Gao <hongguang.gao@broadcom.com>

Current driver implementation doesn't populate the port_num
field in query_qp. Adding the code to convert internal firmware
port id to ibv defined port number and export it.

Reviewed-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Hongguang Gao <hongguang.gao@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 1 +
 drivers/infiniband/hw/bnxt_re/ib_verbs.h | 4 ++++
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 1 +
 drivers/infiniband/hw/bnxt_re/qplib_fp.h | 1 +
 4 files changed, 7 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index a609e1635a3d..bcb7cfc63d09 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -2325,6 +2325,7 @@ int bnxt_re_query_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 	qp_attr->retry_cnt = qplib_qp->retry_cnt;
 	qp_attr->rnr_retry = qplib_qp->rnr_retry;
 	qp_attr->min_rnr_timer = qplib_qp->min_rnr_timer;
+	qp_attr->port_num = __to_ib_port_num(qplib_qp->port_id);
 	qp_attr->rq_psn = qplib_qp->rq.psn;
 	qp_attr->max_rd_atomic = qplib_qp->max_rd_atomic;
 	qp_attr->sq_psn = qplib_qp->sq.psn;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index ac59f1d73b15..fbb16a411d6a 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -268,6 +268,10 @@ void bnxt_re_dealloc_ucontext(struct ib_ucontext *context);
 int bnxt_re_mmap(struct ib_ucontext *context, struct vm_area_struct *vma);
 void bnxt_re_mmap_free(struct rdma_user_mmap_entry *rdma_entry);
 
+static inline u32 __to_ib_port_num(u16 port_id)
+{
+	return (u32)port_id + 1;
+}
 
 unsigned long bnxt_re_lock_cqs(struct bnxt_re_qp *qp);
 void bnxt_re_unlock_cqs(struct bnxt_re_qp *qp, unsigned long flags);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 5169804e6f12..d8a2a929bbe3 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -1532,6 +1532,7 @@ int bnxt_qplib_query_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	qp->dest_qpn = le32_to_cpu(sb->dest_qp_id);
 	memcpy(qp->smac, sb->src_mac, 6);
 	qp->vlan_id = le16_to_cpu(sb->vlan_pcp_vlan_dei_vlan_id);
+	qp->port_id = le16_to_cpu(sb->port_id);
 bail:
 	dma_free_coherent(&rcfw->pdev->dev, sbuf.size,
 			  sbuf.sb, sbuf.dma_addr);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index 19e279871f10..0660101b5310 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -298,6 +298,7 @@ struct bnxt_qplib_qp {
 	u32				dest_qpn;
 	u8				smac[6];
 	u16				vlan_id;
+	u16				port_id;
 	u8				nw_type;
 	struct bnxt_qplib_ah		ah;
 
-- 
2.43.5


