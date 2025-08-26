Return-Path: <linux-rdma+bounces-12921-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F315EB3545C
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 08:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 535C01B6597C
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 06:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42B42F6590;
	Tue, 26 Aug 2025 06:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bv9aPILB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136382882D7
	for <linux-rdma@vger.kernel.org>; Tue, 26 Aug 2025 06:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189242; cv=none; b=NIXYsn+W6CvIstyizzKJCOIXJlxgzc3g/z1X7ejxAfrfAlP9tqgDzzflc/znfpc/Eok2oD1rkbK9E1BoAnnfd9pGJQJFvWDQ4A5LFPoHEjhKiIFC9jZy5T9D/SV4mAb196Xfr3uyiHT/Crp0NXRLbBjbrIDa0puM25b3iQGkv/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189242; c=relaxed/simple;
	bh=HHxPkKFO68DwvJQ89HY4caOTXRPrZb045gPytbEKCIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmCsh3ZYU11CfrgIZKnPadQnHgF1CRafRptFpvS/QJ1YGDfzbWj8XrGyTXS9P1zinmZ+UZLL6jGMm7BHNT6ZyKO9nuGE+4q8hHZZMXMZPnFPGemEZRjZNjYeuyTAhCD2pu3heb6Vk0fZSt/UxMSDc4yIKE4p5QULbeE9ufEo53k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bv9aPILB; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-771f69fd6feso703083b3a.1
        for <linux-rdma@vger.kernel.org>; Mon, 25 Aug 2025 23:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756189240; x=1756794040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bga66DR6seDFuWWS/YdTu2FVMkAZbIW1gGlwkMrpsLU=;
        b=T5vVCjsQyvBApKDsJA1WIWvDMkg5cTYgZCGeYQWT98dzoFV8m/Ci5QcseaeejjvBXY
         DXWWAoylIOlAAJuAMZ9UUwKjL+KbfgIxzlt3wB4/TVntarbKaWQPtoHf/kue61n6z4cp
         9ch66kdJLSJGoxnxPwhH/Xa4m6/4eKkfDR2291Gz6dO1qgyJqAhrdFpMDR7C+5sfrIa0
         kGcboUsyjJVS7DW7ezK40df1fuEAnApo3ta0tDiOG5Rt6pKaRj8C+G1axDoliGLtc9wI
         ciViyUsnlhL4osSb2PBab1LwjFIxbVBrL1nwsgpWbXEfpPil8BqOx6BAVDba26uw/hOJ
         lOhA==
X-Gm-Message-State: AOJu0Yyql7ksIQyGesRfzQUXoGZsPTHEgtw37PNelig2odE/X8KGqcv4
	mv6nvc4MSzCPBYWAy9YkSk/A/2Pfxf2GsUaA/zr3HbXQl7QjUqDATGerqVi27QNWAfzc6qWD0zV
	YAsBs336wGIGo4wVwHME7ju6OKmjcrnlI20yMsaRXt+RSxjHL0qX0hSyD6IEwNnzc9vnf1hsrQE
	FLxdUVT9akSW9n7Dhp2H8/AbYoc8XOegshV9+wpUEDibwUnqbqlHw1weHEsUd5LBUUdTg/JDFqI
	Ntfdsik6KATvqNUTqsLAYjkMclrCg==
X-Gm-Gg: ASbGncsw3C7LpKBtOKIPN1EKoiep5Dy6NB0Z5cwRSHYbyXHrslaW7zfAHRtMC7DXbDk
	PSf4i7LdXJMXRptrGt0EcB2AWVcYupU7Z5DIhJxWRSp51NyR2AmZ0Z8tphYfZT0Sc1GF9jOA6vb
	6Wv4ZCvvu4tCHQO1762j2vG5FeIsVOntiv1Jychz6uQP/7tTyCK0EmflxVvfmcf90DrFQNPMlZ9
	NHAgSogjiGhe39m8JIZ8NMk4GI6UBfqKv0N9QRYcHr0xZdLJ65OEhIMz8Zmnklb/Cvy33oy0IVA
	nBz/JprAtW7TSyEEsvCRjKD6wWVPbUsiLd0VR2/3U+qkTNqVSkvYy1IexKjO/lD8unNFQeeNPP4
	555ISYryctytZoHidU6W3VOnYZT7D3jp7iN9Ro8PmDcPEkBJw3iuSxbyVO0CpMMn4CcfXDos/Q2
	tA0ZxbKuaWiu8/
X-Google-Smtp-Source: AGHT+IGSXht5cZiy268D48YQ4OGm9Q27FuDFiC5U+rNIndZI0CQjigHQ6O+1gUt/uKrre5Ilx2GaaIO2+fnX
X-Received: by 2002:a05:6a20:7f8c:b0:243:7617:7f98 with SMTP id adf61e73a8af0-243761784a5mr8215821637.27.1756189240232;
        Mon, 25 Aug 2025 23:20:40 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-b49cb960c55sm652410a12.11.2025.08.25.23.20.39
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Aug 2025 23:20:40 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b49da0156bdso3417643a12.1
        for <linux-rdma@vger.kernel.org>; Mon, 25 Aug 2025 23:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756189238; x=1756794038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bga66DR6seDFuWWS/YdTu2FVMkAZbIW1gGlwkMrpsLU=;
        b=bv9aPILB4mxZ1QpfbZ00Q8ZQEIhPfwyCj5mu015OsFPJl7heCPn1P68rezO90ygrj8
         W0zZHX4ZzR4BrhV+nQLqohMBvecKHPd5VqZ/Ma5MjNtKWF62h59/XAZR+ha/0kO1WSdU
         Qh7VEY/ijlhB0dW0x5K07LkzKjL/eX7NOhszQ=
X-Received: by 2002:a05:6a20:12c8:b0:240:2371:d003 with SMTP id adf61e73a8af0-24340cd311cmr21911960637.28.1756189238462;
        Mon, 25 Aug 2025 23:20:38 -0700 (PDT)
X-Received: by 2002:a05:6a20:12c8:b0:240:2371:d003 with SMTP id adf61e73a8af0-24340cd311cmr21911931637.28.1756189237935;
        Mon, 25 Aug 2025 23:20:37 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4c04c7522fsm4392543a12.5.2025.08.25.23.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:20:37 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	michael.chan@broadcom.com,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH V2 rdma-next 02/10] RDMA/bnxt_re: Add data structures for RoCE mirror support
Date: Tue, 26 Aug 2025 11:55:14 +0530
Message-ID: <20250826062522.1036432-3-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250826062522.1036432-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250826062522.1036432-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Saravanan Vajravel <saravanan.vajravel@broadcom.com>

Added data structures required for supporting mirroring on
RoCE device.

Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h    | 5 +++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.h   | 5 +++++
 drivers/infiniband/hw/bnxt_re/qplib_fp.h   | 1 +
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h | 1 +
 drivers/infiniband/hw/bnxt_re/qplib_res.h  | 6 ++++++
 5 files changed, 18 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index b5d0e38c7396..1cb57c8246cc 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -172,6 +172,7 @@ struct bnxt_re_dev {
 	struct list_head		list;
 	unsigned long			flags;
 #define BNXT_RE_FLAG_NETDEV_REGISTERED		0
+#define BNXT_RE_FLAG_STATS_CTX3_ALLOC		1
 #define BNXT_RE_FLAG_HAVE_L2_REF		3
 #define BNXT_RE_FLAG_RCFW_CHANNEL_EN		4
 #define BNXT_RE_FLAG_QOS_WORK_REG		5
@@ -229,6 +230,10 @@ struct bnxt_re_dev {
 	struct bnxt_re_dbg_cc_config_params *cc_config_params;
 #define BNXT_VPD_FLD_LEN	32
 	char			board_partno[BNXT_VPD_FLD_LEN];
+	/* RoCE mirror */
+	u16			mirror_vnic_id;
+	union			ib_gid ugid;
+	u32			ugid_index;
 };
 
 #define to_bnxt_re_dev(ptr, member)	\
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index fe00ab691a51..445a28b3cd96 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -164,6 +164,11 @@ struct bnxt_re_user_mmap_entry {
 	u8 mmap_flag;
 };
 
+struct bnxt_re_flow {
+	struct ib_flow		ib_flow;
+	struct bnxt_re_dev	*rdev;
+};
+
 static inline u16 bnxt_re_get_swqe_size(int nsge)
 {
 	return sizeof(struct sq_send_hdr) + nsge * sizeof(struct sq_sge);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index 074c539c69c1..3bd995ced9ca 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -345,6 +345,7 @@ struct bnxt_qplib_qp {
 	u32				msn_tbl_sz;
 	bool				is_host_msn_tbl;
 	u8				tos_dscp;
+	u32				ugid_index;
 };
 
 #define BNXT_RE_MAX_MSG_SIZE	0x80000000
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index ff873c5f1b25..988c89b4232e 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -236,6 +236,7 @@ struct bnxt_qplib_rcfw {
 	atomic_t timeout_send;
 	/* cached from chip cctx for quick reference in slow path */
 	u16 max_timeout;
+	bool roce_mirror;
 };
 
 struct bnxt_qplib_cmdqmsg {
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index 6a13927674b4..12e2fa23794a 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -65,6 +65,7 @@ struct bnxt_qplib_drv_modes {
 	bool db_push;
 	bool dbr_pacing;
 	u32 toggle_bits;
+	u8 roce_mirror;
 };
 
 enum bnxt_re_toggle_modes {
@@ -582,6 +583,11 @@ static inline u8 bnxt_qplib_dbr_pacing_en(struct bnxt_qplib_chip_ctx *cctx)
 	return cctx->modes.dbr_pacing;
 }
 
+static inline u8 bnxt_qplib_roce_mirror_supported(struct bnxt_qplib_chip_ctx *cctx)
+{
+	return cctx->modes.roce_mirror;
+}
+
 static inline bool _is_alloc_mr_unified(u16 dev_cap_flags)
 {
 	return dev_cap_flags & CREQ_QUERY_FUNC_RESP_SB_MR_REGISTER_ALLOC;
-- 
2.43.5


