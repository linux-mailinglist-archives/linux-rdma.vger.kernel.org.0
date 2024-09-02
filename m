Return-Path: <linux-rdma+bounces-4683-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD30967F2E
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 08:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F5641F22606
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 06:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217F5154BEE;
	Mon,  2 Sep 2024 06:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Dj1/M5tu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D151AACA
	for <linux-rdma@vger.kernel.org>; Mon,  2 Sep 2024 06:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725257604; cv=none; b=KMgc0fvR23qmgxJKptYmuloEZfLKOCpba8ukqnOskBpxhthq+GUqxdAUDZ//N3wxQ5lqsobZF/ya/5UacgL/4RfsQCnDmh5mNdPgnjTLcMru60S4jSRwcL3OWN2vaMhdwtoG4l3z08x+KBWJTu3W8ljFW4qSOqQMyBb+lvaydHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725257604; c=relaxed/simple;
	bh=TX5GFzH77yfVF/cdwWrEISulUeGN7PBMii5WG+lhoNI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=RAbhpTWmcqKWOvHw5l20N8B4YrBsusgYkBa9TGNx3iJeecvzCDv95nOZLp8VsaVs69GXfQHjeF7Qe7kgVaRtzwRAdis+qvW6zpuw2ANsLpFEv61Ppg1Zvdy8F5XSrBGL9lhdyL0ErepcbMtGsibXM18btrUk7cv9JfYR9vtiUeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Dj1/M5tu; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2057c6c57b5so2983495ad.1
        for <linux-rdma@vger.kernel.org>; Sun, 01 Sep 2024 23:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725257602; x=1725862402; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TvsCwGZswkvekt0UpZVHab8326YO+Ej47S2Dw9ycIGQ=;
        b=Dj1/M5tu2TL310KAJtCocX/ZJIO+oXXRG6K9yg/yaZPHf2rY11/OHhuEJbf9doSLrP
         dunw4Y+aUwzvrfyZ9RMj3bELhgIABnK5UsHQMk8iAeyVgYxtnMZ98/rszJXGcaENGoU5
         j/m76GKS2lqKoaBnPEdiv7hyx3HLUVhm9u2QM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725257602; x=1725862402;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TvsCwGZswkvekt0UpZVHab8326YO+Ej47S2Dw9ycIGQ=;
        b=mo0RXMGq6NHQva6pTTt0hdzbf7jBQnBnKxqLWK0rkTPiLc8OxQKb02DZCnpOyd0tB4
         F2x7osazd5GNnve/VypsbxV47jbLi0xvbR2ijXY7CL/4xwSZ/2bcHW6VtOyPTzhYlPjJ
         l2pyKNeM3EYWxsPiCm+FYVlLqub+PH3sSE2tiHyHKue7yiz5k1+9SAg+kZy2EkLfgORO
         jOPW/2UAlp15BZEsdBKJrALHgB/8BjH+lJyUdM5mFNZve+wzlH+lVosRHLILGoxcdaZr
         tBWG/qz31udvpvn8CaJFtBN8ldYo96YTgoiAAaZQLmJAfFQ12aMX7xM1WUB8J/YtSvjd
         rd+w==
X-Gm-Message-State: AOJu0Yww9sWy9CZybOMVU+bPX7DGDbT72/7pqMA+alvyMI9vWm+iSsm7
	gzO96OQJmSTJF9EAGM1zjpKedV3Sb4KF6d/E/NqGx0XhV6DVD9vGEwPvtP8cn9IOSoNRyReGzst
	HZQ==
X-Google-Smtp-Source: AGHT+IHEXNo2D+Of6Ity4q4kOI828ejY84wbYDWvXYeJHYJ8XJ2ueWfXg5wBn9sxgdfpetVZeSWcaw==
X-Received: by 2002:a17:902:fb0f:b0:205:80e6:b7f2 with SMTP id d9443c01a7336-20580e6b8d8mr18742485ad.11.1725257602492;
        Sun, 01 Sep 2024 23:13:22 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2054a2629c3sm28907955ad.105.2024.09.01.23.13.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Sep 2024 23:13:21 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 1/4] RDMA/bnxt_re: Update HW interface headers
Date: Sun,  1 Sep 2024 22:52:28 -0700
Message-Id: <1725256351-12751-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1725256351-12751-1-git-send-email-selvin.xavier@broadcom.com>
References: <1725256351-12751-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

Updating the HW structures for the pcie relax ordering support.
Newly added interface structures will be used in the
followup patch.

Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/roce_hsi.h | 36 ++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/roce_hsi.h b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
index 0425309..3ec8952 100644
--- a/drivers/infiniband/hw/bnxt_re/roce_hsi.h
+++ b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
@@ -409,7 +409,7 @@ struct creq_deinitialize_fw_resp {
 	u8	reserved48[6];
 };
 
-/* cmdq_create_qp (size:768b/96B) */
+/* cmdq_create_qp (size:832b/104B) */
 struct cmdq_create_qp {
 	u8	opcode;
 	#define CMDQ_CREATE_QP_OPCODE_CREATE_QP 0x1UL
@@ -430,8 +430,11 @@ struct cmdq_create_qp {
 	#define CMDQ_CREATE_QP_QP_FLAGS_OPTIMIZED_TRANSMIT_ENABLED 0x20UL
 	#define CMDQ_CREATE_QP_QP_FLAGS_RESPONDER_UD_CQE_WITH_CFA  0x40UL
 	#define CMDQ_CREATE_QP_QP_FLAGS_EXT_STATS_ENABLED          0x80UL
+	#define CMDQ_CREATE_QP_QP_FLAGS_EXPRESS_MODE_ENABLED       0x100UL
+	#define CMDQ_CREATE_QP_QP_FLAGS_STEERING_TAG_VALID         0x200UL
+	#define CMDQ_CREATE_QP_QP_FLAGS_RDMA_READ_OR_ATOMICS_USED  0x400UL
 	#define CMDQ_CREATE_QP_QP_FLAGS_LAST                      \
-		CMDQ_CREATE_QP_QP_FLAGS_EXT_STATS_ENABLED
+		CMDQ_CREATE_QP_QP_FLAGS_RDMA_READ_OR_ATOMICS_USED
 	u8	type;
 	#define CMDQ_CREATE_QP_TYPE_RC            0x2UL
 	#define CMDQ_CREATE_QP_TYPE_UD            0x4UL
@@ -492,6 +495,9 @@ struct cmdq_create_qp {
 	__le64	rq_pbl;
 	__le64	irrq_addr;
 	__le64	orrq_addr;
+	__le32	request_xid;
+	__le16	steering_tag;
+	__le16	reserved16;
 };
 
 /* creq_create_qp_resp (size:128b/16B) */
@@ -972,13 +978,14 @@ struct creq_query_qp_extend_resp_sb_tlv {
 	__le16	reserved_16;
 };
 
-/* cmdq_create_srq (size:384b/48B) */
+/* cmdq_create_srq (size:448b/56B) */
 struct cmdq_create_srq {
 	u8	opcode;
 	#define CMDQ_CREATE_SRQ_OPCODE_CREATE_SRQ 0x5UL
 	#define CMDQ_CREATE_SRQ_OPCODE_LAST      CMDQ_CREATE_SRQ_OPCODE_CREATE_SRQ
 	u8	cmd_size;
 	__le16	flags;
+	#define CMDQ_CREATE_SRQ_FLAGS_STEERING_TAG_VALID	0x1UL
 	__le16	cookie;
 	u8	resp_size;
 	u8	reserved8;
@@ -1012,6 +1019,8 @@ struct cmdq_create_srq {
 	__le32	dpi;
 	__le32	pd_id;
 	__le64	pbl;
+	__le16	steering_tag;
+	u8	reserved48[6];
 };
 
 /* creq_create_srq_resp (size:128b/16B) */
@@ -1118,7 +1127,7 @@ struct creq_query_srq_resp_sb {
 	__le32	data[4];
 };
 
-/* cmdq_create_cq (size:384b/48B) */
+/* cmdq_create_cq (size:448b/56B) */
 struct cmdq_create_cq {
 	u8	opcode;
 	#define CMDQ_CREATE_CQ_OPCODE_CREATE_CQ 0x9UL
@@ -1126,6 +1135,8 @@ struct cmdq_create_cq {
 	u8	cmd_size;
 	__le16	flags;
 	#define CMDQ_CREATE_CQ_FLAGS_DISABLE_CQ_OVERFLOW_DETECTION     0x1UL
+	#define CMDQ_CREATE_CQ_FLAGS_STEERING_TAG_VALID                0x2UL
+	#define CMDQ_CREATE_CQ_FLAGS_INFINITE_CQ_MODE                  0x4UL
 	__le16	cookie;
 	u8	resp_size;
 	u8	reserved8;
@@ -1157,6 +1168,8 @@ struct cmdq_create_cq {
 	__le32	dpi;
 	__le32	cq_size;
 	__le64	pbl;
+	__le16	steering_tag;
+	u8	reserved48[6];
 };
 
 /* creq_create_cq_resp (size:128b/16B) */
@@ -1288,11 +1301,12 @@ struct cmdq_allocate_mrw {
 	#define CMDQ_ALLOCATE_MRW_MRW_FLAGS_MW_TYPE2A  0x3UL
 	#define CMDQ_ALLOCATE_MRW_MRW_FLAGS_MW_TYPE2B  0x4UL
 	#define CMDQ_ALLOCATE_MRW_MRW_FLAGS_LAST      CMDQ_ALLOCATE_MRW_MRW_FLAGS_MW_TYPE2B
-	#define CMDQ_ALLOCATE_MRW_UNUSED4_MASK       0xf0UL
-	#define CMDQ_ALLOCATE_MRW_UNUSED4_SFT        4
+	#define CMDQ_ALLOCATE_MRW_STEERING_TAG_VALID     0x10UL
+	#define CMDQ_ALLOCATE_MRW_UNUSED4_MASK       0xe0UL
+	#define CMDQ_ALLOCATE_MRW_UNUSED4_SFT        5
 	u8	access;
 	#define CMDQ_ALLOCATE_MRW_ACCESS_CONSUMER_OWNED_KEY     0x20UL
-	__le16	unused16;
+	__le16	steering_tag;
 	__le32	pd_id;
 };
 
@@ -1359,14 +1373,16 @@ struct creq_deallocate_key_resp {
 	__le32	bound_window_info;
 };
 
-/* cmdq_register_mr (size:384b/48B) */
+/* cmdq_register_mr (size:448b/56B) */
 struct cmdq_register_mr {
 	u8	opcode;
 	#define CMDQ_REGISTER_MR_OPCODE_REGISTER_MR 0xfUL
 	#define CMDQ_REGISTER_MR_OPCODE_LAST       CMDQ_REGISTER_MR_OPCODE_REGISTER_MR
 	u8	cmd_size;
 	__le16	flags;
-	#define CMDQ_REGISTER_MR_FLAGS_ALLOC_MR     0x1UL
+	#define CMDQ_REGISTER_MR_FLAGS_ALLOC_MR			0x1UL
+	#define CMDQ_REGISTER_MR_FLAGS_STEERING_TAG_VALID	0x2UL
+	#define CMDQ_REGISTER_MR_FLAGS_ENABLE_RO		0x4UL
 	__le16	cookie;
 	u8	resp_size;
 	u8	reserved8;
@@ -1415,6 +1431,8 @@ struct cmdq_register_mr {
 	__le64	pbl;
 	__le64	va;
 	__le64	mr_size;
+	__le16  steering_tag;
+	u8      reserved48[6];
 };
 
 /* creq_register_mr_resp (size:128b/16B) */
-- 
2.5.5


