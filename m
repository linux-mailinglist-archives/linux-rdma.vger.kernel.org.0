Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07C1F13A355
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2020 09:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgANI5h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jan 2020 03:57:37 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:21800 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728819AbgANI5h (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jan 2020 03:57:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1578992255; x=1610528255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lx3CAt/fJZnCz4dE0drf+aoWRjXuGfTay6KGE6hoztY=;
  b=P8bBEyDYYX3mPA3mMsLi0OPGdREIM1Tv1LnKsgGHUUmf4hzHncHDZHdS
   bHQWXlrXzs09dKzb8oS6DZcl2HtDgdhTAluct4BDVghdjQjsEjBGb8zr4
   ewzxiISQSSe6NxWKfFnkIRTXvMSne1Ts4jDQhfrxn/KCXHI4My4W0/iNT
   8=;
IronPort-SDR: Fi9jxnNHblmtBAEEP2AOMK1/Cm0Rgcr3lw6tuemFhMsizZQxr/BmHT4p3Ist+L/cRfi3v1j39T
 Gk5DW7q0NXCw==
X-IronPort-AV: E=Sophos;i="5.69,432,1571702400"; 
   d="scan'208";a="18572453"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-53356bf6.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 14 Jan 2020 08:57:25 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-53356bf6.us-west-2.amazon.com (Postfix) with ESMTPS id 2B7F1A2887;
        Tue, 14 Jan 2020 08:57:25 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 14 Jan 2020 08:57:24 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 14 Jan 2020 08:57:23 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.133) by
 mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 14 Jan 2020 08:57:20 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        "Yossi Leybovich" <sleybo@amazon.com>
Subject: [PATCH for-next 3/6] RDMA/efa: Device definitions documentation updates
Date:   Tue, 14 Jan 2020 10:57:03 +0200
Message-ID: <20200114085706.82229-4-galpress@amazon.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114085706.82229-1-galpress@amazon.com>
References: <20200114085706.82229-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Various clarifications and updates to the documentation of the device
definitions.
No functional changes in this patch.

Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 37 ++++++++++++-------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
index a589a471d122..d5f3d8795ac0 100644
--- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
+++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
@@ -160,10 +160,16 @@ struct efa_admin_create_qp_resp {
 	/* Common Admin Queue completion descriptor */
 	struct efa_admin_acq_common_desc acq_common_desc;
 
-	/* Opaque handle to be used for consequent operations on the QP */
+	/*
+	 * Opaque handle to be used for consequent admin operations on the
+	 * QP
+	 */
 	u32 qp_handle;
 
-	/* QP number in the given EFA virtual device */
+	/*
+	 * QP number in the given EFA virtual device. Least-significant bits
+	 *    (as needed according to max_qp) carry unique QP ID
+	 */
 	u16 qp_num;
 
 	/* MBZ */
@@ -286,6 +292,7 @@ struct efa_admin_create_ah_cmd {
 	/* PD number */
 	u16 pd;
 
+	/* MBZ */
 	u16 reserved;
 };
 
@@ -296,6 +303,7 @@ struct efa_admin_create_ah_resp {
 	/* Target interface address handle (opaque) */
 	u16 ah;
 
+	/* MBZ */
 	u16 reserved;
 };
 
@@ -372,6 +380,7 @@ struct efa_admin_reg_mr_cmd {
 	 */
 	u8 permissions;
 
+	/* MBZ */
 	u16 reserved16_w5;
 
 	/* number of pages in PBL (redundant, could be calculated) */
@@ -419,20 +428,20 @@ struct efa_admin_create_cq_cmd {
 	struct efa_admin_aq_common_desc aq_common_desc;
 
 	/*
-	 * 4:0 : reserved5
+	 * 4:0 : reserved5 - MBZ
 	 * 5 : interrupt_mode_enabled - if set, cq operates
 	 *    in interrupt mode (i.e. CQ events and MSI-X are
 	 *    generated), otherwise - polling
 	 * 6 : virt - If set, ring base address is virtual
 	 *    (IOVA returned by MR registration)
-	 * 7 : reserved6
+	 * 7 : reserved6 - MBZ
 	 */
 	u8 cq_caps_1;
 
 	/*
 	 * 4:0 : cq_entry_size_words - size of CQ entry in
 	 *    32-bit words, valid values: 4, 8.
-	 * 7:5 : reserved7
+	 * 7:5 : reserved7 - MBZ
 	 */
 	u8 cq_caps_2;
 
@@ -478,6 +487,7 @@ struct efa_admin_destroy_cq_cmd {
 
 	u16 cq_idx;
 
+	/* MBZ */
 	u16 reserved1;
 };
 
@@ -530,7 +540,7 @@ struct efa_admin_get_set_feature_common_desc {
 	/*
 	 * 1:0 : select - 0x1 - current value; 0x3 - default
 	 *    value
-	 * 7:3 : reserved3
+	 * 7:3 : reserved3 - MBZ
 	 */
 	u8 flags;
 
@@ -557,10 +567,10 @@ struct efa_admin_feature_device_attr_desc {
 	/* Bar used for SQ and RQ doorbells */
 	u16 db_bar;
 
-	/* Indicates how many bits are used physical address access */
+	/* Indicates how many bits are used on physical address access */
 	u8 phys_addr_width;
 
-	/* Indicates how many bits are used virtual address access */
+	/* Indicates how many bits are used on virtual address access */
 	u8 virt_addr_width;
 
 	/*
@@ -578,27 +588,28 @@ struct efa_admin_feature_queue_attr_desc {
 	/* The maximum number of queue pairs supported */
 	u32 max_qp;
 
+	/* Maximum number of WQEs per Send Queue */
 	u32 max_sq_depth;
 
-	/* max send wr used in inline-buf */
+	/* Maximum size of data that can be sent inline in a Send WQE */
 	u32 inline_buf_size;
 
+	/* Maximum number of buffer descriptors per Recv Queue */
 	u32 max_rq_depth;
 
 	/* The maximum number of completion queues supported per VF */
 	u32 max_cq;
 
+	/* Maximum number of CQEs per Completion Queue */
 	u32 max_cq_depth;
 
 	/* Number of sub-CQs to be created for each CQ */
 	u16 sub_cqs_per_cq;
 
+	/* MBZ */
 	u16 reserved;
 
-	/*
-	 * Maximum number of SGEs (buffs) allowed for a single send work
-	 *    queue element (WQE)
-	 */
+	/* Maximum number of SGEs (buffers) allowed for a single send WQE */
 	u16 max_wr_send_sges;
 
 	/* Maximum number of SGEs allowed for a single recv WQE */
-- 
2.24.1

