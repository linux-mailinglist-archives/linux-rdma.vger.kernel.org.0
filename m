Return-Path: <linux-rdma+bounces-8259-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBEEA4CA04
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 18:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B89917C59A
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 17:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB256237185;
	Mon,  3 Mar 2025 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bL02Dg4n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BD5238142
	for <linux-rdma@vger.kernel.org>; Mon,  3 Mar 2025 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022435; cv=none; b=VBlsL6snsXUx1fFHBN1Nlm5W9M5iwHr41+bovEDBBkmjR/uzSK+KcZD9H6g+V+ocTXQoxagfvCmICRPrJZscK7kEXtPVftOiqCgLsOsgA/0nPg0Wm/Ll1fyeJ4PL6qQBPvRnpTQSchpgeClPUa+ArlQh3fXwFYi9N5OptQNj0BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022435; c=relaxed/simple;
	bh=xsZpYdvBSQj35VacJGD6vK3h9P/UC2AbrjldSTMvNds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=sLma5Su7xQGlqIPxBGzBa4gPIBajujLiwXDlr3bwGJIFkWHSlADQrnrBvEVICRSj/AbtcraKimH0NBECDiv+YnVjUrB6BviSRhr1qOHZN5dDT7ea+3K71Wc9M7K0ablj0eKIO4S/T1iqCDoFlg7UQvD3Yr0lly90YgAyGo234m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bL02Dg4n; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2234e5347e2so95375675ad.1
        for <linux-rdma@vger.kernel.org>; Mon, 03 Mar 2025 09:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741022433; x=1741627233; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ByvvkjydNYBBEUvY5go2asNQWQ+u6Im2sCIlC84nrog=;
        b=bL02Dg4nkV9qjp9izlbqh9rmMcqyXeL+C5qX+3fVMMnbb+CNE3mFHIzpVyO3tEzbSu
         G36kJEkBQKANz8whU5lVl8xQLlBze4Iv4tmF5Oywh3I2U4MhRTW5y9uDZkTQZVmry1mr
         oW3g3tGlKyJJo7yMFx77zOkFnCr19SYF43FD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741022433; x=1741627233;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ByvvkjydNYBBEUvY5go2asNQWQ+u6Im2sCIlC84nrog=;
        b=euEdN3hx3286odbPRcfFaDfICDQuGQzLgsp3DPXtpONUJe/hlGs789QHYMe3WuUB46
         EmkQHL8dynUI5qSx5CFSxGrv0XAQjiGW1BJQ3iTo2lciDzmsiSaHG8Tg29o9CljTCXon
         93NVsNa4ROjIkSATAkcYPatakxqkYcGyx6LczAGdhw6692Edb5ChfJdp3YVLl2DS4aNM
         m7DbFA86ndPAXOpuGbNcxtEfzz8qF6+YQafRHDlCy11knPNUaiw27BkdeH1Y4boC+s6r
         t6DLFNECVjhPdBM+Gyv3Dgy+aDOKvv+j4WN5olyhXUmAn0MPVDWU7XYKkcmHrQPC2EN3
         fUvw==
X-Gm-Message-State: AOJu0Yy2bNQGUDa2wsBifIx+eiQ/3d+YPbjE+NmAC4LKOIyV3qWf312/
	5VTbPkWdkdDtKJ7rX0ILvzi6006xMRxsgEIg8VdEH74/624zp6TqRXfBzZ5Qeg==
X-Gm-Gg: ASbGnctzl5T0jKe9WVlmpf40hZWFrd6EQPKmP7OK57PvZ+U5uD+FTM3rgy+lpe6P0dK
	ZJYzB2WC2yLH6vGWCXp6YNoRGbAzJosetqmXJnrGqyUST5rKA+5rl/VPdTuaEzXEZTh8KvP6f27
	/py2GqJ62WhWKNxcSMzC9HD629yzG4hCmzmuI5/Iw0yv42ToMf7FNlkyltqZ1onurf7G/t6DPvY
	JkzdzfxOjTyj/40GeWIFWGLl4+bLvsxW66fOUtuCJ6PYSFzB/BpxqPftsnQv+iHlDxw0dBpY6MK
	O2r+f1e3KcFL2fVg9t0IobKQBW4H2uRxfRb+uEMg+kaDndkEN3FUfXTyj9WAOI732sItB3AnrYz
	OXBWveECPlM/fiEGa4aKpEO+Q
X-Google-Smtp-Source: AGHT+IGHy9esWscwhPOnIlcurqdPw4pTg5HHJ1TP08ksp7pEP4OpAaE5p8LSALs/puDebHFGvjCV1g==
X-Received: by 2002:a05:6a00:1e0f:b0:736:41ec:aaad with SMTP id d2e1a72fcca58-73641ecaf3cmr7607628b3a.14.1741022433507;
        Mon, 03 Mar 2025 09:20:33 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7364ba1371asm3064917b3a.5.2025.03.03.09.20.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Mar 2025 09:20:33 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Preethi G <preethi.gurusiddalingeswaraswamy@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-rc 3/3] RDMA/bnxt_re: Fix reporting maximum SRQs on P7 chips
Date: Mon,  3 Mar 2025 08:59:38 -0800
Message-Id: <1741021178-2569-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1741021178-2569-1-git-send-email-selvin.xavier@broadcom.com>
References: <1741021178-2569-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Preethi G <preethi.gurusiddalingeswaraswamy@broadcom.com>

Firmware reports support for additional SRQs in the max_srq_ext field.
In CREQ_QUERY_FUNC response, if MAX_SRQ_EXTENDED flag is set, driver
should derive the total number of max SRQs by the summation of
"max_srq" and "max_srq_ext" fields.

Fixes: b1b66ae094cd ("bnxt_en: Use FW defined resource limits for RoCE")
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Preethi G <preethi.gurusiddalingeswaraswamy@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_res.h | 5 +++++
 drivers/infiniband/hw/bnxt_re/qplib_sp.c  | 3 +++
 drivers/infiniband/hw/bnxt_re/roce_hsi.h  | 3 ++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index 2fb540f..6a13927 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -607,4 +607,9 @@ static inline bool _is_cq_coalescing_supported(u16 dev_cap_ext_flags2)
 	return dev_cap_ext_flags2 & CREQ_QUERY_FUNC_RESP_SB_CQ_COALESCING_SUPPORTED;
 }
 
+static inline bool _is_max_srq_ext_supported(u16 dev_cap_ext_flags_2)
+{
+	return !!(dev_cap_ext_flags_2 & CREQ_QUERY_FUNC_RESP_SB_MAX_SRQ_EXTENDED);
+}
+
 #endif /* __BNXT_QPLIB_RES_H__ */
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 4ccd440..f231e88 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -176,6 +176,9 @@ int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw)
 	attr->dev_cap_flags = le16_to_cpu(sb->dev_cap_flags);
 	attr->dev_cap_flags2 = le16_to_cpu(sb->dev_cap_ext_flags_2);
 
+	if (_is_max_srq_ext_supported(attr->dev_cap_flags2))
+		attr->max_srq += le16_to_cpu(sb->max_srq_ext);
+
 	bnxt_qplib_query_version(rcfw, attr->fw_ver);
 
 	for (i = 0; i < MAX_TQM_ALLOC_REQ / 4; i++) {
diff --git a/drivers/infiniband/hw/bnxt_re/roce_hsi.h b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
index 0ee60fd..7eceb3e 100644
--- a/drivers/infiniband/hw/bnxt_re/roce_hsi.h
+++ b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
@@ -2215,11 +2215,12 @@ struct creq_query_func_resp_sb {
 	#define CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_IQM_MSN_TABLE   (0x2UL << 4)
 	#define CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_LAST	\
 			CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_IQM_MSN_TABLE
+	#define CREQ_QUERY_FUNC_RESP_SB_MAX_SRQ_EXTENDED                         0x40UL
 	#define CREQ_QUERY_FUNC_RESP_SB_MIN_RNR_RTR_RTS_OPT_SUPPORTED            0x1000UL
 	__le16	max_xp_qp_size;
 	__le16	create_qp_batch_size;
 	__le16	destroy_qp_batch_size;
-	__le16	reserved16;
+	__le16  max_srq_ext;
 	__le64	reserved64;
 };
 
-- 
2.5.5


