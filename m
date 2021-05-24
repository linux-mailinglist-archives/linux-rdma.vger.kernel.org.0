Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAAED38E011
	for <lists+linux-rdma@lfdr.de>; Mon, 24 May 2021 06:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhEXENv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 May 2021 00:13:51 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:39504 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhEXENv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 May 2021 00:13:51 -0400
Received: by mail-pl1-f179.google.com with SMTP id t9so5524297ply.6
        for <linux-rdma@vger.kernel.org>; Sun, 23 May 2021 21:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=STovX67F4zASu4rBIJlIj7wF3gHTIy4ggdJxmKGT6z4=;
        b=jQ7llQm18acysaAfKHNUXYVaBllxq6IY/923npbQPl/j4pxDxJIZUCI8PBs6XMO7wn
         rv0oUC0LhEwWcuxHu7HSdiuqf0s1wotMh/FLUwf2YVxKl1f8TGbYXxFwOC4gYOt4XI0K
         wBKsZcoxkPwNBCvj0ziBo26MZKB6CGt0mTikYpoXXTuOu4qjj0l9moRy+RULaKca25m7
         CrX7ihFzbMiMIFmc18SSKCp8xlkB6N5WWRF1TV3PqKRrLELE4Rbm7CNCBkq3QtdSSXym
         Md4qeL5ZJg8Jmyn14qNcVIf9S+F5GmvOm/cSVInSWPd5r6oBUrE8S9L9hoCOZMEvYA/U
         f0hw==
X-Gm-Message-State: AOAM5327XkJt1nLWgTmDALlx5Mh+OcZKBaG1hqEtaG37n/jmJsyKIMYU
        WiC15zmAhGNxDWOrlM9oi2A=
X-Google-Smtp-Source: ABdhPJzMKmj3ayVCDzLHeBqts1fp6pahtuEQ/NLXFF6iFQ2dAJ+zRRE+1isqy/fDhjMNilJIahzV4Q==
X-Received: by 2002:a17:90a:aa12:: with SMTP id k18mr23120595pjq.232.1621829542351;
        Sun, 23 May 2021 21:12:22 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id q9sm13141979pjm.23.2021.05.23.21.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 21:12:21 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Subject: [PATCH v2 3/5] RDMA/srp: Apply the __packed attribute to members instead of structures
Date:   Sun, 23 May 2021 21:12:09 -0700
Message-Id: <20210524041211.9480-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210524041211.9480-1-bvanassche@acm.org>
References: <20210524041211.9480-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Applying the __packed attribute to an entire data structure results in
suboptimal code on architectures that do not support unaligned accesses.
Hence apply the __packed attribute only to those data members that are
not naturally aligned.

Cc: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/scsi/srp.h | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/include/scsi/srp.h b/include/scsi/srp.h
index 177d8026e96f..dfe0984b58a9 100644
--- a/include/scsi/srp.h
+++ b/include/scsi/srp.h
@@ -107,10 +107,10 @@ struct srp_direct_buf {
  * having the 20-byte structure padded to 24 bytes on 64-bit architectures.
  */
 struct srp_indirect_buf {
-	struct srp_direct_buf	table_desc;
+	struct srp_direct_buf	table_desc __packed __aligned(4);
 	__be32			len;
-	struct srp_direct_buf	desc_list[];
-} __attribute__((packed));
+	struct srp_direct_buf	desc_list[] __packed __aligned(4);
+};
 
 /* Immediate data buffer descriptor as defined in SRP2. */
 struct srp_imm_buf {
@@ -175,13 +175,13 @@ struct srp_login_rsp {
 	u8	opcode;
 	u8	reserved1[3];
 	__be32	req_lim_delta;
-	u64	tag;
+	u64	tag __packed __aligned(4);
 	__be32	max_it_iu_len;
 	__be32	max_ti_iu_len;
 	__be16	buf_fmt;
 	u8	rsp_flags;
 	u8	reserved2[25];
-} __attribute__((packed));
+};
 
 struct srp_login_rej {
 	u8	opcode;
@@ -207,10 +207,6 @@ struct srp_t_logout {
 	u64	tag;
 };
 
-/*
- * We need the packed attribute because the SRP spec only aligns the
- * 8-byte LUN field to 4 bytes.
- */
 struct srp_tsk_mgmt {
 	u8	opcode;
 	u8	sol_not;
@@ -225,10 +221,6 @@ struct srp_tsk_mgmt {
 	u8	reserved5[8];
 };
 
-/*
- * We need the packed attribute because the SRP spec only aligns the
- * 8-byte LUN field to 4 bytes.
- */
 struct srp_cmd {
 	u8	opcode;
 	u8	sol_not;
@@ -266,7 +258,7 @@ struct srp_rsp {
 	u8	sol_not;
 	u8	reserved1[2];
 	__be32	req_lim_delta;
-	u64	tag;
+	u64	tag __packed __aligned(4);
 	u8	reserved2[2];
 	u8	flags;
 	u8	status;
@@ -275,7 +267,7 @@ struct srp_rsp {
 	__be32	sense_data_len;
 	__be32	resp_data_len;
 	u8	data[];
-} __attribute__((packed));
+};
 
 struct srp_cred_req {
 	u8	opcode;
@@ -301,13 +293,13 @@ struct srp_aer_req {
 	u8	sol_not;
 	u8	reserved[2];
 	__be32	req_lim_delta;
-	u64	tag;
+	u64	tag __packed __aligned(4);
 	u32	reserved2;
 	struct scsi_lun	lun;
 	__be32	sense_data_len;
 	u32	reserved3;
 	u8	sense_data[];
-} __attribute__((packed));
+};
 
 struct srp_aer_rsp {
 	u8	opcode;
