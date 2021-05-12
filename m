Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21DE737B483
	for <lists+linux-rdma@lfdr.de>; Wed, 12 May 2021 05:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhELD3L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 23:29:11 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:45766 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhELD3K (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 May 2021 23:29:10 -0400
Received: by mail-pg1-f180.google.com with SMTP id q15so12962635pgg.12
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 20:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3L77qsW4ZKuP/IDKiGViaG6824W9YPVT7keFJzoQ2EA=;
        b=fRJ7IlqulkSDR8id3f/uoVH6oOPb1GB3NDf5kx7+LxA4HieySrqNNkF5GwbV5ryoQ6
         pZgmBJFGnjy2hU2agYyn8Q6VMyGUp8uNvyMBb+I2EBakwg5gwHNvHezRgdaEXCqQOFmw
         IFSDxLmrnoZbTG0YZuFR0QyO347qLerFqHbaOV7mdgwSrdgNhgQkVDRV+i8DKGKXEtum
         YJw2dX7Xy/5iuU+LiaUNOKpyMFanS1IBeQJANkU1IqsYfyURe9hua1fSg4apy03a4wow
         3YFQEdeBGA5Gge1K7gYLMPTUlxYjKKGhQpQQlS4gznGzVXgjShMRrdOF27zjHmUvGBQx
         ITRA==
X-Gm-Message-State: AOAM532equ2JKRvjStIFvel5mj16HcKwckyYFE1TfF7dMnaaINXqPvGy
        eTOgPugJgt8dGpBwIMSqyWA=
X-Google-Smtp-Source: ABdhPJyWA3aycje66h4lVwecH2DlTGYHvwggvm+jASIWKM+oxRICMYJR9HQ3dY98cWKbRJHxWTC7eQ==
X-Received: by 2002:a63:d14b:: with SMTP id c11mr9184512pgj.162.1620790083379;
        Tue, 11 May 2021 20:28:03 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:76b9:3c77:17e3:3073])
        by smtp.gmail.com with ESMTPSA id q194sm15008703pfc.62.2021.05.11.20.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 20:28:02 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Subject: [PATCH 3/5] RDMA/srp: Apply the __packed attribute to members instead of structures
Date:   Tue, 11 May 2021 20:27:50 -0700
Message-Id: <20210512032752.16611-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512032752.16611-1-bvanassche@acm.org>
References: <20210512032752.16611-1-bvanassche@acm.org>
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
index 177d8026e96f..84d2b5fc1409 100644
--- a/include/scsi/srp.h
+++ b/include/scsi/srp.h
@@ -107,10 +107,10 @@ struct srp_direct_buf {
  * having the 20-byte structure padded to 24 bytes on 64-bit architectures.
  */
 struct srp_indirect_buf {
-	struct srp_direct_buf	table_desc;
+	struct srp_direct_buf	table_desc __packed;
 	__be32			len;
-	struct srp_direct_buf	desc_list[];
-} __attribute__((packed));
+	struct srp_direct_buf	desc_list[] __packed;
+};
 
 /* Immediate data buffer descriptor as defined in SRP2. */
 struct srp_imm_buf {
@@ -175,13 +175,13 @@ struct srp_login_rsp {
 	u8	opcode;
 	u8	reserved1[3];
 	__be32	req_lim_delta;
-	u64	tag;
+	u64	tag __packed;
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
+	u64	tag __packed;
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
+	u64	tag __packed;
 	u32	reserved2;
 	struct scsi_lun	lun;
 	__be32	sense_data_len;
 	u32	reserved3;
 	u8	sense_data[];
-} __attribute__((packed));
+};
 
 struct srp_aer_rsp {
 	u8	opcode;
