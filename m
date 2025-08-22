Return-Path: <linux-rdma+bounces-12872-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BACA4B30D21
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Aug 2025 06:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED62D5E88E9
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Aug 2025 04:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D9F23BCFD;
	Fri, 22 Aug 2025 04:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QhP+hDej"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B4D24166E
	for <linux-rdma@vger.kernel.org>; Fri, 22 Aug 2025 04:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755835373; cv=none; b=cynC9gP7c4XBSJn3hpEiEjnOv7+S7f/RYCsM4RsGGR4vGNZqJzHVaaaoqBWIhHAsfhnGT6kDiNv/MTS4aHKwsMk+U/rvTRb9B+p1HtcSHj0uZXkkq96+BGvtAVvGyiG+K6x5UAIRN6B8EFe7HEsxWDsJtfaKuwCByHOlIPBT6MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755835373; c=relaxed/simple;
	bh=HHxPkKFO68DwvJQ89HY4caOTXRPrZb045gPytbEKCIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QayXxRWf3rk5kBsdcI4ZlOQPZgdXR1cKnygYzD5R3vmqKBbamBPOI09Ed5z1DWMVws6lbaThOnp5t/jhRoN49ktVwWIIeeQaC2Q/kOdc4Creu9G15mnkfs+ckzUucPIJAG7YLh6/lRMH9BANs0BvriW0jrQzH5lNHo/FxTyJGdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QhP+hDej; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-70d9d415a2dso1711486d6.1
        for <linux-rdma@vger.kernel.org>; Thu, 21 Aug 2025 21:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755835371; x=1756440171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bga66DR6seDFuWWS/YdTu2FVMkAZbIW1gGlwkMrpsLU=;
        b=dzlG3bVcK/BG5dnpmlTal1zvGBGMTgtUvO9fsAnUe/igcscSPfRwc2vbqDl5sDSjUz
         JkElaGN/Z/ETi4qErYqHH0fNFm4WLhaS8goLa2QnJMB4tyWXHpmbcu8eoyLSkH4tSL0R
         SIEGnnEEmcSyqfU04S9YhgwqFdB/MAm7ftLEpHoYiLmZuKunPvk2VCxUuLwa602SUJa8
         LNUxaDd3vxzZPz9+/DxNFgoDU5uDYU1iCb+Fb+EHPw/qFfVsJzKReAjCB6T0D8o466JK
         PWwF5AgxaCdi6Br2TYXE483rDevtoKIWuT/Cul2GNAKpwefdW4lnaHnUcmA9Gaa9WgXO
         Fmpw==
X-Gm-Message-State: AOJu0YyJqbBCIBjee9QRHkmSggvyb0FIw32F+ZrVi36OSeu6EKsOqO6o
	bS3tkqUdO6CkuZOGf12EWw9jZBDVGA3przcF6mM5lEdLIx5D/w1xLqn5p0C51w8xx0YtU+f+B3P
	LeUbvgyDhs+nR/UjTviAb8Atm6jM+lsw8ksqTfVY8LJyXuNz3DoUeHiC13sbN8Iu6nztnFarDcy
	ayEfoA9cCz8Y6mb63zlanoIAvz90h8oKVrsZJ5EH3ev8dDD7kDEiFuOilFHPv9rf4u/MJncs0RI
	OHMG+Oe1VRmvOu+eHhsSfIe2L6FEA==
X-Gm-Gg: ASbGnct7WBpvX7c9ip7GMtNPLGO2BoNlm9PnCMloC2w5vC4fmIWES7VFx2Fe80TEUJd
	lqoFviu63vBzQNPj+r2JCpniEgTnNpaToCVTiMLDnFS37MP/e+gVewbmmstgqRgb1CTFeqiSqCA
	A3U8JN9XGhl0ExOl4EOr/G/iXdQIRjpvLIoF7GnRLTEtHk65nBi1I0J6oyT1anQoH6iRJ1X0w5r
	5bT1NijobXjxbKr1zHXLIvAhcX3z+KJTOeqvevHfCvJuB00WxWVNSt8QeY6Pulz4OOx0ChvprAK
	V+vC7puuEanNQoG5S76Y9mYGmt9QBCpYl44MnDUQU0qkRdLpfoj6U+MHLOFFBO4T4JiCVvSdZ5R
	e0xrM1UikYYDN2J475aaqM2GxXdyCQj5L3Vt8He2CUP86BEnFjNiO/J81Ni0r0xTjWYIe8DNNiR
	QCIDI9xfkb4SbS
X-Google-Smtp-Source: AGHT+IGcXAP13k/wleRQ21cHKFDsq2RKRZL+HBw6EtZikEYDg/gmd/2jUgJ76dbJjQxCkFbjs18BK8cZ4ivr
X-Received: by 2002:a05:6214:2522:b0:70d:9b31:38cd with SMTP id 6a1803df08f44-70d9b313918mr8111166d6.27.1755835370612;
        Thu, 21 Aug 2025 21:02:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-70ba921e109sm11032816d6.24.2025.08.21.21.02.50
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Aug 2025 21:02:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76e2e591846so1632476b3a.0
        for <linux-rdma@vger.kernel.org>; Thu, 21 Aug 2025 21:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755835369; x=1756440169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bga66DR6seDFuWWS/YdTu2FVMkAZbIW1gGlwkMrpsLU=;
        b=QhP+hDejDz+fcvamUuJEZ/zMgVWRlg9vSXJvMQRt96YrihIYtmEiqpq5eFqWCtsGq1
         HoRFsIYM8HyuBvPv7KkcfJinLQUSoANQAfkMQibiulnFW8XKTwCoZ+JBBB0h7cipDPG3
         Umwqnq80H2A9kQNBQfa7GL8TAMV9cq38KAym0=
X-Received: by 2002:a05:6a00:1786:b0:770:2c33:2708 with SMTP id d2e1a72fcca58-770305bbb85mr1976572b3a.9.1755835369410;
        Thu, 21 Aug 2025 21:02:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:1786:b0:770:2c33:2708 with SMTP id d2e1a72fcca58-770305bbb85mr1976535b3a.9.1755835368931;
        Thu, 21 Aug 2025 21:02:48 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d3abdsm9659814b3a.11.2025.08.21.21.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 21:02:48 -0700 (PDT)
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
Subject: [PATCH rdma-next 02/10] RDMA/bnxt_re: Add data structures for RoCE mirror support
Date: Fri, 22 Aug 2025 09:37:53 +0530
Message-ID: <20250822040801.776196-3-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250822040801.776196-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250822040801.776196-1-kalesh-anakkur.purayil@broadcom.com>
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


