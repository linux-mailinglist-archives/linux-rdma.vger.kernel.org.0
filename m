Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2286A19C88E
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Apr 2020 20:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732995AbgDBSMe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Apr 2020 14:12:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34403 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732625AbgDBSMe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Apr 2020 14:12:34 -0400
Received: by mail-wm1-f68.google.com with SMTP id c195so219877wme.1
        for <linux-rdma@vger.kernel.org>; Thu, 02 Apr 2020 11:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lqp05ET+1XfDX1iqS7yisuzG71FWWTr7+XCGTYb780M=;
        b=E55N27A4SrP31PJbf5YtrsW88j1HEB3U96pC8DDlf8pqULouxr2jmJCqVH3eg7g+cO
         x3cLEGX04jDCmiNJWgbaOsWFbreXJQg+g8RNpIRhDs40sGSWqMkTBaWV71MFsYPhuxpC
         HDg5YUteY2Hi93RikantMPRARIDDsCGk/GyPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lqp05ET+1XfDX1iqS7yisuzG71FWWTr7+XCGTYb780M=;
        b=imG7eO3nukv0/6cYVhzEoaauGsNv1n4d4CXWh+wltpJUr7un/ZdTyM+EgxPBCc+B5U
         VIUGpXzKkobXcFET5cMHLDd9bWLa9nzaqISLVIFwJAv7XOfe/oyUpbT1jQC8Z/8qdHP4
         VSlzOCrpE6srowLcfQVcA7hRftuuU8f8blaDSrTV6D+Yk7Xko3W7lIeWgbL30BcTCnly
         +Y2KvK7xfFOWZLNlCRXlW6eHj5J2AP85cHa09OzGFnhG06kQayjt9nV8Qev2ZyMdP94q
         RPiRSXtKwcRqGV9qTQJw1yGJcpDAhDG7+Y5W5zBK5pUUef+gcWGioW/TumM4v8nTicjW
         5zCA==
X-Gm-Message-State: AGi0PuZX/2BbaRSvIG3zpEMfJX+405OgZ0Q66n6iH4YhgWhIk+S87Ynh
        n8wu9CoYcEUfqAdokZgU06m2U8Z6q/FYpFr0WaF1vOmU0cUvs0Sntz9LXPc2XXf6elGGf4wR3cx
        IbbUsrollIbChZZX9DKIdRsa+jgacUkRkYTJ45ZtEX84gRxRR/RWfARIrhqTpTRrTyLbK6NXPfU
        4H14o=
X-Google-Smtp-Source: APiQypJmmpS68fkmfEEtRvgDjnBNHMKLJ02XQCtrtrffcFWVjf7aMVwoj4YWXErff0AF1Jwob8Yc9Q==
X-Received: by 2002:a7b:c5cb:: with SMTP id n11mr4819486wmk.160.1585851152543;
        Thu, 02 Apr 2020 11:12:32 -0700 (PDT)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id k3sm8399351wro.39.2020.04.02.11.12.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2020 11:12:31 -0700 (PDT)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, dledford@redhat.com
Subject: [PATCH for-next 2/4] RDMA/bnxt_re: Update missing hsi data structures
Date:   Thu,  2 Apr 2020 14:12:13 -0400
Message-Id: <1585851136-2316-3-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1585851136-2316-1-git-send-email-devesh.sharma@broadcom.com>
References: <1585851136-2316-1-git-send-email-devesh.sharma@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Adding fast path support data structure into hardware
HSI. These structures are header only definition of
RQE/SRQE/SQE. This is to help calculating the size of
hardware wqe size.

Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/roce_hsi.h | 106 +++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/roce_hsi.h b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
index e4b09e7..6f00f07 100644
--- a/drivers/infiniband/hw/bnxt_re/roce_hsi.h
+++ b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
@@ -210,6 +210,20 @@ struct sq_send {
 	__le32 data[24];
 };
 
+/* sq_send_hdr (size:256b/32B) */
+struct sq_send_hdr {
+	u8	wqe_type;
+	u8	flags;
+	u8	wqe_size;
+	u8	reserved8_1;
+	__le32	inv_key_or_imm_data;
+	__le32	length;
+	__le32	q_key;
+	__le32	dst_qp;
+	__le32	avid;
+	__le64	reserved64;
+};
+
 /* Send Raw Ethernet and QP1 SQ WQE (40 bytes) */
 struct sq_send_raweth_qp1 {
 	u8 wqe_type;
@@ -265,6 +279,21 @@ struct sq_send_raweth_qp1 {
 	__le32 data[24];
 };
 
+/* sq_send_raweth_qp1_hdr (size:256b/32B) */
+struct sq_send_raweth_qp1_hdr {
+	u8	wqe_type;
+	u8	flags;
+	u8	wqe_size;
+	u8	reserved8;
+	__le16	lflags;
+	__le16	cfa_action;
+	__le32	length;
+	__le32	reserved32_1;
+	__le32	cfa_meta;
+	__le32	reserved32_2;
+	__le64	reserved64;
+};
+
 /* RDMA SQ WQE (40 bytes) */
 struct sq_rdma {
 	u8 wqe_type;
@@ -288,6 +317,20 @@ struct sq_rdma {
 	__le32 data[24];
 };
 
+/* sq_rdma_hdr (size:256b/32B) */
+struct sq_rdma_hdr {
+	u8	wqe_type;
+	u8	flags;
+	u8	wqe_size;
+	u8	reserved8;
+	__le32	imm_data;
+	__le32	length;
+	__le32	reserved32_1;
+	__le64	remote_va;
+	__le32	remote_key;
+	__le32	reserved32_2;
+};
+
 /* Atomic SQ WQE (40 bytes) */
 struct sq_atomic {
 	u8 wqe_type;
@@ -307,6 +350,17 @@ struct sq_atomic {
 	__le32 data[24];
 };
 
+/* sq_atomic_hdr (size:256b/32B) */
+struct sq_atomic_hdr {
+	u8	wqe_type;
+	u8	flags;
+	__le16	reserved16;
+	__le32	remote_key;
+	__le64	remote_va;
+	__le64	swap_data;
+	__le64	cmp_data;
+};
+
 /* Local Invalidate SQ WQE (40 bytes) */
 struct sq_localinvalidate {
 	u8 wqe_type;
@@ -324,6 +378,16 @@ struct sq_localinvalidate {
 	__le32 data[24];
 };
 
+/* sq_localinvalidate_hdr (size:256b/32B) */
+struct sq_localinvalidate_hdr {
+	u8	wqe_type;
+	u8	flags;
+	__le16	reserved16;
+	__le32	inv_l_key;
+	__le64	reserved64;
+	u8	reserved128[16];
+};
+
 /* FR-PMR SQ WQE (40 bytes) */
 struct sq_fr_pmr {
 	u8 wqe_type;
@@ -380,6 +444,21 @@ struct sq_fr_pmr {
 	__le32 data[24];
 };
 
+/* sq_fr_pmr_hdr (size:256b/32B) */
+struct sq_fr_pmr_hdr {
+	u8	wqe_type;
+	u8	flags;
+	u8	access_cntl;
+	u8	zero_based_page_size_log;
+	__le32	l_key;
+	u8	length[5];
+	u8	reserved8_1;
+	u8	reserved8_2;
+	u8	numlevels_pbl_page_size_log;
+	__le64	pblptr;
+	__le64	va;
+};
+
 /* Bind SQ WQE (40 bytes) */
 struct sq_bind {
 	u8 wqe_type;
@@ -417,6 +496,22 @@ struct sq_bind {
 	#define SQ_BIND_DATA_SFT				    0
 };
 
+/* sq_bind_hdr (size:256b/32B) */
+struct sq_bind_hdr {
+	u8	wqe_type;
+	u8	flags;
+	u8	access_cntl;
+	u8	reserved8_1;
+	u8	mw_type_zero_based;
+	u8	reserved8_2;
+	__le16	reserved16;
+	__le32	parent_l_key;
+	__le32	l_key;
+	__le64	va;
+	u8	length[5];
+	u8	reserved24[3];
+};
+
 /* RQ/SRQ WQE Structures */
 /* RQ/SRQ WQE (40 bytes) */
 struct rq_wqe {
@@ -435,6 +530,17 @@ struct rq_wqe {
 	__le32 data[24];
 };
 
+/* rq_wqe_hdr (size:256b/32B) */
+struct rq_wqe_hdr {
+	u8	wqe_type;
+	u8	flags;
+	u8	wqe_size;
+	u8	reserved8;
+	__le32	reserved32;
+	__le32	wr_id[2];
+	u8	reserved128[16];
+};
+
 /* CQ CQE Structures */
 /* Base CQE (32 bytes) */
 struct cq_base {
-- 
1.8.3.1

