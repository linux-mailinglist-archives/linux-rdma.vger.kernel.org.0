Return-Path: <linux-rdma+bounces-16626-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKCeL/Z7hWkBCQQAu9opvQ
	(envelope-from <linux-rdma+bounces-16626-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 06:28:22 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7607FA590
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 06:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDA39301D6B1
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Feb 2026 05:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1862B337690;
	Fri,  6 Feb 2026 05:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bhagngeH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com [209.85.222.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A91F2DB7B2
	for <linux-rdma@vger.kernel.org>; Fri,  6 Feb 2026 05:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770355622; cv=none; b=BwySjmHv1SrtX7VNfPvkBUxMEDuMprumf/QCLuS+fS2dZl27i2nJxXyzkRLCEvwjXMcM1Yd7qKouhCqa+hsWbLwX1sqGjMfvZlpB2zHmGV19qVJKc54Cer6M7+qVNTD6dyn0Migvblf/vKMvYksvn6anJOuUaj36hwSUonbLd3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770355622; c=relaxed/simple;
	bh=GmUZgWF49X5H2Ij5irxHNY40u8q8G9Y4n5/DsRqdE4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vBKcV3eZyTtBMs0y++SVYymWWFcHdOkgUWDo2W0fIBWgjyTmjZGAC2bRfh9Eowa3QIPiApW2oaivhxlb55y9gqpGdfEbHzelZamby+agX4wtp2vimc8eGhr3CCPMcwW4K6PpD3UhtoTbraFwEVuWbPvb/hDTtleY4ReDphIzAGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bhagngeH; arc=none smtp.client-ip=209.85.222.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f228.google.com with SMTP id af79cd13be357-8c6a50c17fdso32971585a.2
        for <linux-rdma@vger.kernel.org>; Thu, 05 Feb 2026 21:27:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770355620; x=1770960420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=McvUYXXcmIiQ8kkJROL0dipBt41qNlhPMLGqW1V5at0=;
        b=j/lnXUE7zIKogt/2LOGxdtzZoMHxdg3s8zc/ytdxpPNX/CI5/MwMU4QUueBTmXHfoM
         8b6ZVw/swzi3PZscYoRV8b4Q2HfJRMgFflfWoO21TEyoY+JbY0S0hrNB6AOSmfaIBulw
         E9u7dIRSG2EdZrhKp0ZKZuVK/70e4qbhvc4/rm3S3/TkKhMtrvAm6ir/001Bt3vUqes5
         kLb7oHChrRwS9MbCCaFJbXn/Z7VoKYTSejgBLk4XjMLoLp9I1/GZFG2z2hKLpcQhlEZJ
         R7vtSJxPoQ01Pb4f5ntYLq0D/zya3xazoDtLhAtz9LW9lfS2Va/VjKWQ3Qb2LIIwYR3M
         Schw==
X-Forwarded-Encrypted: i=1; AJvYcCWUYGk4GpP4HXQ1Sv4e488dSA95ZSnlukWP/0v9zTnDa3109No6tb1x3z9YKLgT2P13/xGsX2NmYbwU@vger.kernel.org
X-Gm-Message-State: AOJu0YwXgI7KYeNwrbuCgwOy5S0s6HzM8fWi2B0JufEUarl3/QRMj1Mq
	PE7YvCrOzw3tsCRM0xpTaz6B1wqj1zVrHR7M+RB4C+BTpwlKuPdkN82P9j8MuasvGxRO9Tb1ako
	mZ86sEMYGHuRAu8nXJgQDukNCwaH1JHrnX/5zx4KBxhSZl3QSCmpef9wfg95KTcso33iRlXdCF1
	MwcId5+Sm3TQVtEVodBzdgDc9hsAj2xSfyy+KREjoI4Aqiha0IBph6YaHsalwDkD9zdY8H3iQrw
	accqQzvEO2NHYE=
X-Gm-Gg: AZuq6aKFKR8x8W68Nk7gXvG9kLP1C6Xe8nvMOUDZDAYHhAzySWdRWayFEz+BhbUQVX5
	FOwooWrF0tkCn9We1Im4FYv2gTzh4hUIwrzCX5iwIseZWACBf5KSirUK6J7t+OnKtLMtVscQ0KY
	2OJR4s0wGE/HHZ+BwZnmazamONrzbWcPtnockl84+ZIpRzlQiFGQrnQ4rcbW7eOUBebbBsv7H3P
	akzWiNoLHHnQuSGtoeKBRQ0HnRdOzD+wQnb6NjCvQdeFNNQm8icR7ntqIjTJIH2qvOfuw5Sxljm
	khytlxfKgBarEFlEIV6UsLLsV6sq20d5eDpo1h/bYV6WR17hbAjeylvRMohDh9hBAwKULrXaI8m
	tPb7InvD4klNI3snFY3gLG4gH9v5P04y4X+ymeI5L2tBodfRlRTppXEaUg1wH+FkqmV44Jny3oA
	svYNQvdJ0PPu61lcF/8ZgW+I+JSZkja89rl2nperbl
X-Received: by 2002:a05:620a:44cf:b0:8c6:a1d5:47e1 with SMTP id af79cd13be357-8caeeb4e117mr189310685a.9.1770355619820;
        Thu, 05 Feb 2026 21:26:59 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8953c0180a7sm2265016d6.18.2026.02.05.21.26.58
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Feb 2026 21:26:59 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a0b7eb0a56so3972615ad.1
        for <linux-rdma@vger.kernel.org>; Thu, 05 Feb 2026 21:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770355618; x=1770960418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=McvUYXXcmIiQ8kkJROL0dipBt41qNlhPMLGqW1V5at0=;
        b=bhagngeHBeNDDJvfRGyru+xgPQ+zZ14t3HCuYVpTsaUedwistyDwimdhoa3QkG7AMa
         NctP0ucORl9W448a/UgYrsaCuR6TTjHN1/svNjE7wteW6uS5wDgr5kG2uDWRb09FDDk/
         hjdw2ImkTGRycvrHrcupgVzMdtQadkkQ2KIC0=
X-Forwarded-Encrypted: i=1; AJvYcCUHx+Cx56LbCUPK08lwhmXmU/C1P211Ms1iVLZ5bqpv2zDPXjoSIXjHTFsw8nGgksAAp16b4smDFST0@vger.kernel.org
X-Received: by 2002:a17:902:e742:b0:2a7:845a:7eb2 with SMTP id d9443c01a7336-2a95162def1mr17423745ad.14.1770355616270;
        Thu, 05 Feb 2026 21:26:56 -0800 (PST)
X-Received: by 2002:a17:902:e742:b0:2a7:845a:7eb2 with SMTP id d9443c01a7336-2a95162def1mr17423335ad.14.1770355615200;
        Thu, 05 Feb 2026 21:26:55 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a95224f10csm10210275ad.101.2026.02.05.21.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 21:26:53 -0800 (PST)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	leonro@nvidia.com,
	jgg@nvidia.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	ajit.khaparde@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Siva Reddy Kallam <siva.kallam@broadcom.com>,
	Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Subject: [PATCH net-next v2] bnge/bng_re: Add a new HSI
Date: Fri,  6 Feb 2026 10:56:13 +0530
Message-ID: <20260206052614.1676580-1-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16626-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E7607FA590
X-Rspamd-Action: no action

The HSI is shared between the firmware and the driver and is
automatically generated.
Add a new HSI for the BNGE driver. The current HSI refers to BNXT,
which will become incompatible with ThorUltra devices as the
BNGE driver adds more features. The BNGE driver will not use the HSI
located in the bnxt folder.
Also, add an HSI for ThorUltra RoCE driver.

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
---
 drivers/infiniband/hw/bng_re/Makefile         |     2 +-
 drivers/infiniband/hw/bng_re/bng_fw.c         |     2 +-
 drivers/infiniband/hw/bng_re/bng_res.c        |     4 +-
 drivers/infiniband/hw/bng_re/bng_res.h        |     2 +-
 drivers/infiniband/hw/bng_re/bng_roce_hsi.h   |  6450 ++++++++
 drivers/infiniband/hw/bng_re/bng_tlv.h        |     2 +-
 drivers/net/ethernet/broadcom/bnge/bnge.h     |     2 +-
 .../net/ethernet/broadcom/bnge/bnge_auxr.c    |     2 +-
 .../net/ethernet/broadcom/bnge/bnge_hwrm.h    |     2 +-
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |     2 +-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |     2 +-
 .../net/ethernet/broadcom/bnge/bnge_rmem.c    |     2 +-
 .../net/ethernet/broadcom/bnge/bnge_txrx.h    |     2 +-
 include/linux/bnge/hsi.h                      | 12609 ++++++++++++++++
 14 files changed, 19072 insertions(+), 13 deletions(-)
 create mode 100644 drivers/infiniband/hw/bng_re/bng_roce_hsi.h
 create mode 100644 include/linux/bnge/hsi.h

diff --git a/drivers/infiniband/hw/bng_re/Makefile b/drivers/infiniband/hw/bng_re/Makefile
index c6aaaf853c77..17e9d5871d40 100644
--- a/drivers/infiniband/hw/bng_re/Makefile
+++ b/drivers/infiniband/hw/bng_re/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-ccflags-y := -I $(srctree)/drivers/net/ethernet/broadcom/bnge -I $(srctree)/drivers/infiniband/hw/bnxt_re
+ccflags-y := -I $(srctree)/drivers/net/ethernet/broadcom/bnge
 
 obj-$(CONFIG_INFINIBAND_BNG_RE) += bng_re.o
 
diff --git a/drivers/infiniband/hw/bng_re/bng_fw.c b/drivers/infiniband/hw/bng_re/bng_fw.c
index 7d9539113cf5..01b3e1cbe719 100644
--- a/drivers/infiniband/hw/bng_re/bng_fw.c
+++ b/drivers/infiniband/hw/bng_re/bng_fw.c
@@ -2,7 +2,7 @@
 // Copyright (c) 2025 Broadcom.
 #include <linux/pci.h>
 
-#include "roce_hsi.h"
+#include "bng_roce_hsi.h"
 #include "bng_res.h"
 #include "bng_fw.h"
 #include "bng_sp.h"
diff --git a/drivers/infiniband/hw/bng_re/bng_res.c b/drivers/infiniband/hw/bng_re/bng_res.c
index c50823758b53..f6e3528e7f4c 100644
--- a/drivers/infiniband/hw/bng_re/bng_res.c
+++ b/drivers/infiniband/hw/bng_re/bng_res.c
@@ -5,9 +5,9 @@
 #include <linux/vmalloc.h>
 #include <rdma/ib_umem.h>
 
-#include <linux/bnxt/hsi.h>
+#include <linux/bnge/hsi.h>
 #include "bng_res.h"
-#include "roce_hsi.h"
+#include "bng_roce_hsi.h"
 
 /* Stats */
 void bng_re_free_stats_ctx_mem(struct pci_dev *pdev,
diff --git a/drivers/infiniband/hw/bng_re/bng_res.h b/drivers/infiniband/hw/bng_re/bng_res.h
index 9997f86d6a0e..2c4e9191ad1c 100644
--- a/drivers/infiniband/hw/bng_re/bng_res.h
+++ b/drivers/infiniband/hw/bng_re/bng_res.h
@@ -4,7 +4,7 @@
 #ifndef __BNG_RES_H__
 #define __BNG_RES_H__
 
-#include "roce_hsi.h"
+#include "bng_roce_hsi.h"
 
 #define BNG_ROCE_FW_MAX_TIMEOUT	60
 
diff --git a/drivers/infiniband/hw/bng_re/bng_roce_hsi.h b/drivers/infiniband/hw/bng_re/bng_roce_hsi.h
new file mode 100644
index 000000000000..1c4666eb0c87
--- /dev/null
+++ b/drivers/infiniband/hw/bng_re/bng_roce_hsi.h
@@ -0,0 +1,6450 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2026 Broadcom */
+
+/* DO NOT MODIFY!!! This file is automatically generated. */
+
+#ifndef __BNG_RE_HSI_H__
+#define __BNG_RE_HSI_H__
+
+#include <linux/bnge/hsi.h>
+
+/* tx_doorbell (size:32b/4B) */
+struct tx_doorbell {
+	__le32	key_idx;
+	#define TX_DOORBELL_IDX_MASK 0xffffffUL
+	#define TX_DOORBELL_IDX_SFT 0
+	#define TX_DOORBELL_KEY_MASK 0xf0000000UL
+	#define TX_DOORBELL_KEY_SFT 28
+	#define TX_DOORBELL_KEY_TX    (0x0UL << 28)
+	#define TX_DOORBELL_KEY_LAST TX_DOORBELL_KEY_TX
+};
+
+/* rx_doorbell (size:32b/4B) */
+struct rx_doorbell {
+	__le32	key_idx;
+	#define RX_DOORBELL_IDX_MASK 0xffffffUL
+	#define RX_DOORBELL_IDX_SFT 0
+	#define RX_DOORBELL_KEY_MASK 0xf0000000UL
+	#define RX_DOORBELL_KEY_SFT 28
+	#define RX_DOORBELL_KEY_RX    (0x1UL << 28)
+	#define RX_DOORBELL_KEY_LAST RX_DOORBELL_KEY_RX
+};
+
+/* cmpl_doorbell (size:32b/4B) */
+struct cmpl_doorbell {
+	__le32	key_mask_valid_idx;
+	#define CMPL_DOORBELL_IDX_MASK      0xffffffUL
+	#define CMPL_DOORBELL_IDX_SFT       0
+	#define CMPL_DOORBELL_IDX_VALID     0x4000000UL
+	#define CMPL_DOORBELL_MASK          0x8000000UL
+	#define CMPL_DOORBELL_KEY_MASK      0xf0000000UL
+	#define CMPL_DOORBELL_KEY_SFT       28
+	#define CMPL_DOORBELL_KEY_CMPL        (0x2UL << 28)
+	#define CMPL_DOORBELL_KEY_LAST       CMPL_DOORBELL_KEY_CMPL
+};
+
+/* status_doorbell (size:32b/4B) */
+struct status_doorbell {
+	__le32	key_idx;
+	#define STATUS_DOORBELL_IDX_MASK 0xffffffUL
+	#define STATUS_DOORBELL_IDX_SFT 0
+	#define STATUS_DOORBELL_KEY_MASK 0xf0000000UL
+	#define STATUS_DOORBELL_KEY_SFT 28
+	#define STATUS_DOORBELL_KEY_STAT  (0x3UL << 28)
+	#define STATUS_DOORBELL_KEY_LAST STATUS_DOORBELL_KEY_STAT
+};
+
+/* cmdq_init (size:128b/16B) */
+struct cmdq_init {
+	__le64	cmdq_pbl;
+	__le16	cmdq_size_cmdq_lvl;
+	#define CMDQ_INIT_CMDQ_LVL_MASK 0x3UL
+	#define CMDQ_INIT_CMDQ_LVL_SFT  0
+	#define CMDQ_INIT_CMDQ_SIZE_MASK 0xfffcUL
+	#define CMDQ_INIT_CMDQ_SIZE_SFT 2
+	__le16	creq_ring_id;
+	__le32	prod_idx;
+};
+
+/* cmdq_base (size:128b/16B) */
+struct cmdq_base {
+	u8	opcode;
+	#define CMDQ_BASE_OPCODE_CREATE_QP                       0x1UL
+	#define CMDQ_BASE_OPCODE_DESTROY_QP                      0x2UL
+	#define CMDQ_BASE_OPCODE_MODIFY_QP                       0x3UL
+	#define CMDQ_BASE_OPCODE_QUERY_QP                        0x4UL
+	#define CMDQ_BASE_OPCODE_CREATE_SRQ                      0x5UL
+	#define CMDQ_BASE_OPCODE_DESTROY_SRQ                     0x6UL
+	#define CMDQ_BASE_OPCODE_QUERY_SRQ                       0x8UL
+	#define CMDQ_BASE_OPCODE_CREATE_CQ                       0x9UL
+	#define CMDQ_BASE_OPCODE_DESTROY_CQ                      0xaUL
+	#define CMDQ_BASE_OPCODE_RESIZE_CQ                       0xcUL
+	#define CMDQ_BASE_OPCODE_ALLOCATE_MRW                    0xdUL
+	#define CMDQ_BASE_OPCODE_DEALLOCATE_KEY                  0xeUL
+	#define CMDQ_BASE_OPCODE_REGISTER_MR                     0xfUL
+	#define CMDQ_BASE_OPCODE_DEREGISTER_MR                   0x10UL
+	#define CMDQ_BASE_OPCODE_ADD_GID                         0x11UL
+	#define CMDQ_BASE_OPCODE_DELETE_GID                      0x12UL
+	#define CMDQ_BASE_OPCODE_MODIFY_GID                      0x17UL
+	#define CMDQ_BASE_OPCODE_QUERY_GID                       0x18UL
+	#define CMDQ_BASE_OPCODE_CREATE_QP1                      0x13UL
+	#define CMDQ_BASE_OPCODE_DESTROY_QP1                     0x14UL
+	#define CMDQ_BASE_OPCODE_CREATE_AH                       0x15UL
+	#define CMDQ_BASE_OPCODE_DESTROY_AH                      0x16UL
+	#define CMDQ_BASE_OPCODE_INITIALIZE_FW                   0x80UL
+	#define CMDQ_BASE_OPCODE_DEINITIALIZE_FW                 0x81UL
+	#define CMDQ_BASE_OPCODE_STOP_FUNC                       0x82UL
+	#define CMDQ_BASE_OPCODE_QUERY_FUNC                      0x83UL
+	#define CMDQ_BASE_OPCODE_SET_FUNC_RESOURCES              0x84UL
+	#define CMDQ_BASE_OPCODE_READ_CONTEXT                    0x85UL
+	#define CMDQ_BASE_OPCODE_VF_BACKCHANNEL_REQUEST          0x86UL
+	#define CMDQ_BASE_OPCODE_READ_VF_MEMORY                  0x87UL
+	#define CMDQ_BASE_OPCODE_COMPLETE_VF_REQUEST             0x88UL
+	#define CMDQ_BASE_OPCODE_EXTEND_CONTEXT_ARRAY_DEPRECATED 0x89UL
+	#define CMDQ_BASE_OPCODE_MAP_TC_TO_COS                   0x8aUL
+	#define CMDQ_BASE_OPCODE_QUERY_VERSION                   0x8bUL
+	#define CMDQ_BASE_OPCODE_MODIFY_ROCE_CC                  0x8cUL
+	#define CMDQ_BASE_OPCODE_QUERY_ROCE_CC                   0x8dUL
+	#define CMDQ_BASE_OPCODE_QUERY_ROCE_STATS                0x8eUL
+	#define CMDQ_BASE_OPCODE_SET_LINK_AGGR_MODE              0x8fUL
+	#define CMDQ_BASE_OPCODE_MODIFY_CQ                       0x90UL
+	#define CMDQ_BASE_OPCODE_QUERY_QP_EXTEND                 0x91UL
+	#define CMDQ_BASE_OPCODE_QUERY_ROCE_STATS_EXT            0x92UL
+	#define CMDQ_BASE_OPCODE_ORCHESTRATE_QID_MIGRATION       0x93UL
+	#define CMDQ_BASE_OPCODE_CREATE_QP_BATCH                 0x94UL
+	#define CMDQ_BASE_OPCODE_DESTROY_QP_BATCH                0x95UL
+	#define CMDQ_BASE_OPCODE_ALLOCATE_ROCE_STATS_EXT_CTX     0x96UL
+	#define CMDQ_BASE_OPCODE_DEALLOCATE_ROCE_STATS_EXT_CTX   0x97UL
+	#define CMDQ_BASE_OPCODE_QUERY_ROCE_STATS_EXT_V2         0x98UL
+	#define CMDQ_BASE_OPCODE_PNO_STATS_CONFIG                0x99UL
+	#define CMDQ_BASE_OPCODE_PNO_DEBUG_TUNNEL_CONFIG         0x9aUL
+	#define CMDQ_BASE_OPCODE_SET_PNO_FABRIC_NEXTHOP_MAC      0x9bUL
+	#define CMDQ_BASE_OPCODE_PNO_PATH_STRPATH_CONFIG         0x9cUL
+	#define CMDQ_BASE_OPCODE_PNO_PATH_QUERY                  0x9dUL
+	#define CMDQ_BASE_OPCODE_PNO_PATH_ACCESS_CONTROL         0x9eUL
+	#define CMDQ_BASE_OPCODE_QUERY_PNO_FABRIC_NEXTHOP_IP     0x9fUL
+	#define CMDQ_BASE_OPCODE_PNO_PATH_PLANE_CONFIG           0xa0UL
+	#define CMDQ_BASE_OPCODE_PNO_TUNNEL_CLOSE                0xa1UL
+	#define CMDQ_BASE_OPCODE_PNO_HOST_PROCESSING_DONE        0xa2UL
+	#define CMDQ_BASE_OPCODE_PNO_STATS_QPARAM                0xa3UL
+	#define CMDQ_BASE_OPCODE_PATH_PROBE_CFG                  0xa4UL
+	#define CMDQ_BASE_OPCODE_PATH_PROBE_DISABLE              0xa5UL
+	#define CMDQ_BASE_OPCODE_ROCE_MIRROR_CFG                 0xa6UL
+	#define CMDQ_BASE_OPCODE_ROCE_CFG                        0xa7UL
+	#define CMDQ_BASE_OPCODE_PNO_EV_MONITORING_CONFIG        0xa8UL
+	#define CMDQ_BASE_OPCODE_LAST                           CMDQ_BASE_OPCODE_PNO_EV_MONITORING_CONFIG
+	u8	cmd_size;
+	__le16	flags;
+	__le16	cookie;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	resp_addr;
+};
+
+/* creq_base (size:128b/16B) */
+struct creq_base {
+	u8	type;
+	#define CREQ_BASE_TYPE_MASK      0x3fUL
+	#define CREQ_BASE_TYPE_SFT       0
+	#define CREQ_BASE_TYPE_QP_EVENT    0x38UL
+	#define CREQ_BASE_TYPE_FUNC_EVENT  0x3aUL
+	#define CREQ_BASE_TYPE_LAST       CREQ_BASE_TYPE_FUNC_EVENT
+	u8	reserved56[7];
+	u8	v;
+	#define CREQ_BASE_V     0x1UL
+	u8	event;
+	u8	reserved48[6];
+};
+
+/* roce_stats_ext_ctx (size:1920b/240B) */
+struct roce_stats_ext_ctx {
+	__le64	tx_atomic_req_pkts;
+	__le64	tx_read_req_pkts;
+	__le64	tx_read_res_pkts;
+	__le64	tx_write_req_pkts;
+	__le64	tx_rc_send_req_pkts;
+	__le64	tx_ud_send_req_pkts;
+	__le64	tx_cnp_pkts;
+	__le64	tx_roce_pkts;
+	__le64	tx_roce_bytes;
+	__le64	rx_out_of_buffer_pkts;
+	__le64	rx_out_of_sequence_pkts;
+	__le64	dup_req;
+	__le64	missing_resp;
+	__le64	seq_err_naks_rcvd;
+	__le64	rnr_naks_rcvd;
+	__le64	to_retransmits;
+	__le64	rx_atomic_req_pkts;
+	__le64	rx_read_req_pkts;
+	__le64	rx_read_res_pkts;
+	__le64	rx_write_req_pkts;
+	__le64	rx_rc_send_pkts;
+	__le64	rx_ud_send_pkts;
+	__le64	rx_dcn_payload_cut;
+	__le64	rx_ecn_marked_pkts;
+	__le64	rx_cnp_pkts;
+	__le64	rx_roce_pkts;
+	__le64	rx_roce_bytes;
+	__le64	rx_roce_good_pkts;
+	__le64	rx_roce_good_bytes;
+	__le64	rx_ack_pkts;
+};
+
+/* cmdq_query_version (size:128b/16B) */
+struct cmdq_query_version {
+	u8	opcode;
+	#define CMDQ_QUERY_VERSION_OPCODE_QUERY_VERSION 0x8bUL
+	#define CMDQ_QUERY_VERSION_OPCODE_LAST         CMDQ_QUERY_VERSION_OPCODE_QUERY_VERSION
+	u8	cmd_size;
+	__le16	flags;
+	__le16	cookie;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	resp_addr;
+};
+
+/* creq_query_version_resp (size:128b/16B) */
+struct creq_query_version_resp {
+	u8	type;
+	#define CREQ_QUERY_VERSION_RESP_TYPE_MASK    0x3fUL
+	#define CREQ_QUERY_VERSION_RESP_TYPE_SFT     0
+	#define CREQ_QUERY_VERSION_RESP_TYPE_QP_EVENT  0x38UL
+	#define CREQ_QUERY_VERSION_RESP_TYPE_LAST     CREQ_QUERY_VERSION_RESP_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	u8	fw_maj;
+	u8	fw_minor;
+	u8	fw_bld;
+	u8	fw_rsvd;
+	u8	v;
+	#define CREQ_QUERY_VERSION_RESP_V     0x1UL
+	u8	event;
+	#define CREQ_QUERY_VERSION_RESP_EVENT_QUERY_VERSION 0x8bUL
+	#define CREQ_QUERY_VERSION_RESP_EVENT_LAST         CREQ_QUERY_VERSION_RESP_EVENT_QUERY_VERSION
+	__le16	reserved16;
+	u8	intf_maj;
+	u8	intf_minor;
+	u8	intf_bld;
+	u8	intf_rsvd;
+};
+
+/* cmdq_initialize_fw (size:1024b/128B) */
+struct cmdq_initialize_fw {
+	u8	opcode;
+	#define CMDQ_INITIALIZE_FW_OPCODE_INITIALIZE_FW 0x80UL
+	#define CMDQ_INITIALIZE_FW_OPCODE_LAST         CMDQ_INITIALIZE_FW_OPCODE_INITIALIZE_FW
+	u8	cmd_size;
+	__le16	flags;
+	#define CMDQ_INITIALIZE_FW_FLAGS_MRAV_RESERVATION_SPLIT                     0x1UL
+	#define CMDQ_INITIALIZE_FW_FLAGS_HW_REQUESTER_RETX_SUPPORTED                0x2UL
+	#define CMDQ_INITIALIZE_FW_FLAGS_DRV_VERSION                                0x4UL
+	#define CMDQ_INITIALIZE_FW_FLAGS_OPTIMIZE_MODIFY_QP_SUPPORTED               0x8UL
+	#define CMDQ_INITIALIZE_FW_FLAGS_L2_VF_RESOURCE_MGMT                        0x10UL
+	#define CMDQ_INITIALIZE_FW_FLAGS_DESTROY_CONTEXT_SB_SUPPORTED               0x20UL
+	#define CMDQ_INITIALIZE_FW_FLAGS_DESTROY_UDCC_SESSION_DATA_SB_SUPPORTED     0x40UL
+	#define CMDQ_INITIALIZE_FW_FLAGS_MIRROR_ON_ROCE_SUPPORTED                   0x80UL
+	__le16	cookie;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	resp_addr;
+	u8	qpc_pg_size_qpc_lvl;
+	#define CMDQ_INITIALIZE_FW_QPC_LVL_MASK      0xfUL
+	#define CMDQ_INITIALIZE_FW_QPC_LVL_SFT       0
+	#define CMDQ_INITIALIZE_FW_QPC_LVL_LVL_0       0x0UL
+	#define CMDQ_INITIALIZE_FW_QPC_LVL_LVL_1       0x1UL
+	#define CMDQ_INITIALIZE_FW_QPC_LVL_LVL_2       0x2UL
+	#define CMDQ_INITIALIZE_FW_QPC_LVL_LAST       CMDQ_INITIALIZE_FW_QPC_LVL_LVL_2
+	#define CMDQ_INITIALIZE_FW_QPC_PG_SIZE_MASK  0xf0UL
+	#define CMDQ_INITIALIZE_FW_QPC_PG_SIZE_SFT   4
+	#define CMDQ_INITIALIZE_FW_QPC_PG_SIZE_PG_4K   (0x0UL << 4)
+	#define CMDQ_INITIALIZE_FW_QPC_PG_SIZE_PG_8K   (0x1UL << 4)
+	#define CMDQ_INITIALIZE_FW_QPC_PG_SIZE_PG_64K  (0x2UL << 4)
+	#define CMDQ_INITIALIZE_FW_QPC_PG_SIZE_PG_2M   (0x3UL << 4)
+	#define CMDQ_INITIALIZE_FW_QPC_PG_SIZE_PG_8M   (0x4UL << 4)
+	#define CMDQ_INITIALIZE_FW_QPC_PG_SIZE_PG_1G   (0x5UL << 4)
+	#define CMDQ_INITIALIZE_FW_QPC_PG_SIZE_LAST   CMDQ_INITIALIZE_FW_QPC_PG_SIZE_PG_1G
+	u8	mrw_pg_size_mrw_lvl;
+	#define CMDQ_INITIALIZE_FW_MRW_LVL_MASK      0xfUL
+	#define CMDQ_INITIALIZE_FW_MRW_LVL_SFT       0
+	#define CMDQ_INITIALIZE_FW_MRW_LVL_LVL_0       0x0UL
+	#define CMDQ_INITIALIZE_FW_MRW_LVL_LVL_1       0x1UL
+	#define CMDQ_INITIALIZE_FW_MRW_LVL_LVL_2       0x2UL
+	#define CMDQ_INITIALIZE_FW_MRW_LVL_LAST       CMDQ_INITIALIZE_FW_MRW_LVL_LVL_2
+	#define CMDQ_INITIALIZE_FW_MRW_PG_SIZE_MASK  0xf0UL
+	#define CMDQ_INITIALIZE_FW_MRW_PG_SIZE_SFT   4
+	#define CMDQ_INITIALIZE_FW_MRW_PG_SIZE_PG_4K   (0x0UL << 4)
+	#define CMDQ_INITIALIZE_FW_MRW_PG_SIZE_PG_8K   (0x1UL << 4)
+	#define CMDQ_INITIALIZE_FW_MRW_PG_SIZE_PG_64K  (0x2UL << 4)
+	#define CMDQ_INITIALIZE_FW_MRW_PG_SIZE_PG_2M   (0x3UL << 4)
+	#define CMDQ_INITIALIZE_FW_MRW_PG_SIZE_PG_8M   (0x4UL << 4)
+	#define CMDQ_INITIALIZE_FW_MRW_PG_SIZE_PG_1G   (0x5UL << 4)
+	#define CMDQ_INITIALIZE_FW_MRW_PG_SIZE_LAST   CMDQ_INITIALIZE_FW_MRW_PG_SIZE_PG_1G
+	u8	srq_pg_size_srq_lvl;
+	#define CMDQ_INITIALIZE_FW_SRQ_LVL_MASK      0xfUL
+	#define CMDQ_INITIALIZE_FW_SRQ_LVL_SFT       0
+	#define CMDQ_INITIALIZE_FW_SRQ_LVL_LVL_0       0x0UL
+	#define CMDQ_INITIALIZE_FW_SRQ_LVL_LVL_1       0x1UL
+	#define CMDQ_INITIALIZE_FW_SRQ_LVL_LVL_2       0x2UL
+	#define CMDQ_INITIALIZE_FW_SRQ_LVL_LAST       CMDQ_INITIALIZE_FW_SRQ_LVL_LVL_2
+	#define CMDQ_INITIALIZE_FW_SRQ_PG_SIZE_MASK  0xf0UL
+	#define CMDQ_INITIALIZE_FW_SRQ_PG_SIZE_SFT   4
+	#define CMDQ_INITIALIZE_FW_SRQ_PG_SIZE_PG_4K   (0x0UL << 4)
+	#define CMDQ_INITIALIZE_FW_SRQ_PG_SIZE_PG_8K   (0x1UL << 4)
+	#define CMDQ_INITIALIZE_FW_SRQ_PG_SIZE_PG_64K  (0x2UL << 4)
+	#define CMDQ_INITIALIZE_FW_SRQ_PG_SIZE_PG_2M   (0x3UL << 4)
+	#define CMDQ_INITIALIZE_FW_SRQ_PG_SIZE_PG_8M   (0x4UL << 4)
+	#define CMDQ_INITIALIZE_FW_SRQ_PG_SIZE_PG_1G   (0x5UL << 4)
+	#define CMDQ_INITIALIZE_FW_SRQ_PG_SIZE_LAST   CMDQ_INITIALIZE_FW_SRQ_PG_SIZE_PG_1G
+	u8	cq_pg_size_cq_lvl;
+	#define CMDQ_INITIALIZE_FW_CQ_LVL_MASK      0xfUL
+	#define CMDQ_INITIALIZE_FW_CQ_LVL_SFT       0
+	#define CMDQ_INITIALIZE_FW_CQ_LVL_LVL_0       0x0UL
+	#define CMDQ_INITIALIZE_FW_CQ_LVL_LVL_1       0x1UL
+	#define CMDQ_INITIALIZE_FW_CQ_LVL_LVL_2       0x2UL
+	#define CMDQ_INITIALIZE_FW_CQ_LVL_LAST       CMDQ_INITIALIZE_FW_CQ_LVL_LVL_2
+	#define CMDQ_INITIALIZE_FW_CQ_PG_SIZE_MASK  0xf0UL
+	#define CMDQ_INITIALIZE_FW_CQ_PG_SIZE_SFT   4
+	#define CMDQ_INITIALIZE_FW_CQ_PG_SIZE_PG_4K   (0x0UL << 4)
+	#define CMDQ_INITIALIZE_FW_CQ_PG_SIZE_PG_8K   (0x1UL << 4)
+	#define CMDQ_INITIALIZE_FW_CQ_PG_SIZE_PG_64K  (0x2UL << 4)
+	#define CMDQ_INITIALIZE_FW_CQ_PG_SIZE_PG_2M   (0x3UL << 4)
+	#define CMDQ_INITIALIZE_FW_CQ_PG_SIZE_PG_8M   (0x4UL << 4)
+	#define CMDQ_INITIALIZE_FW_CQ_PG_SIZE_PG_1G   (0x5UL << 4)
+	#define CMDQ_INITIALIZE_FW_CQ_PG_SIZE_LAST   CMDQ_INITIALIZE_FW_CQ_PG_SIZE_PG_1G
+	u8	tqm_pg_size_tqm_lvl;
+	#define CMDQ_INITIALIZE_FW_TQM_LVL_MASK      0xfUL
+	#define CMDQ_INITIALIZE_FW_TQM_LVL_SFT       0
+	#define CMDQ_INITIALIZE_FW_TQM_LVL_LVL_0       0x0UL
+	#define CMDQ_INITIALIZE_FW_TQM_LVL_LVL_1       0x1UL
+	#define CMDQ_INITIALIZE_FW_TQM_LVL_LVL_2       0x2UL
+	#define CMDQ_INITIALIZE_FW_TQM_LVL_LAST       CMDQ_INITIALIZE_FW_TQM_LVL_LVL_2
+	#define CMDQ_INITIALIZE_FW_TQM_PG_SIZE_MASK  0xf0UL
+	#define CMDQ_INITIALIZE_FW_TQM_PG_SIZE_SFT   4
+	#define CMDQ_INITIALIZE_FW_TQM_PG_SIZE_PG_4K   (0x0UL << 4)
+	#define CMDQ_INITIALIZE_FW_TQM_PG_SIZE_PG_8K   (0x1UL << 4)
+	#define CMDQ_INITIALIZE_FW_TQM_PG_SIZE_PG_64K  (0x2UL << 4)
+	#define CMDQ_INITIALIZE_FW_TQM_PG_SIZE_PG_2M   (0x3UL << 4)
+	#define CMDQ_INITIALIZE_FW_TQM_PG_SIZE_PG_8M   (0x4UL << 4)
+	#define CMDQ_INITIALIZE_FW_TQM_PG_SIZE_PG_1G   (0x5UL << 4)
+	#define CMDQ_INITIALIZE_FW_TQM_PG_SIZE_LAST   CMDQ_INITIALIZE_FW_TQM_PG_SIZE_PG_1G
+	u8	tim_pg_size_tim_lvl;
+	#define CMDQ_INITIALIZE_FW_TIM_LVL_MASK      0xfUL
+	#define CMDQ_INITIALIZE_FW_TIM_LVL_SFT       0
+	#define CMDQ_INITIALIZE_FW_TIM_LVL_LVL_0       0x0UL
+	#define CMDQ_INITIALIZE_FW_TIM_LVL_LVL_1       0x1UL
+	#define CMDQ_INITIALIZE_FW_TIM_LVL_LVL_2       0x2UL
+	#define CMDQ_INITIALIZE_FW_TIM_LVL_LAST       CMDQ_INITIALIZE_FW_TIM_LVL_LVL_2
+	#define CMDQ_INITIALIZE_FW_TIM_PG_SIZE_MASK  0xf0UL
+	#define CMDQ_INITIALIZE_FW_TIM_PG_SIZE_SFT   4
+	#define CMDQ_INITIALIZE_FW_TIM_PG_SIZE_PG_4K   (0x0UL << 4)
+	#define CMDQ_INITIALIZE_FW_TIM_PG_SIZE_PG_8K   (0x1UL << 4)
+	#define CMDQ_INITIALIZE_FW_TIM_PG_SIZE_PG_64K  (0x2UL << 4)
+	#define CMDQ_INITIALIZE_FW_TIM_PG_SIZE_PG_2M   (0x3UL << 4)
+	#define CMDQ_INITIALIZE_FW_TIM_PG_SIZE_PG_8M   (0x4UL << 4)
+	#define CMDQ_INITIALIZE_FW_TIM_PG_SIZE_PG_1G   (0x5UL << 4)
+	#define CMDQ_INITIALIZE_FW_TIM_PG_SIZE_LAST   CMDQ_INITIALIZE_FW_TIM_PG_SIZE_PG_1G
+	__le16	log2_dbr_pg_size;
+	#define CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_MASK   0xfUL
+	#define CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_SFT    0
+	#define CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_PG_4K    0x0UL
+	#define CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_PG_8K    0x1UL
+	#define CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_PG_16K   0x2UL
+	#define CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_PG_32K   0x3UL
+	#define CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_PG_64K   0x4UL
+	#define CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_PG_128K  0x5UL
+	#define CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_PG_256K  0x6UL
+	#define CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_PG_512K  0x7UL
+	#define CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_PG_1M    0x8UL
+	#define CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_PG_2M    0x9UL
+	#define CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_PG_4M    0xaUL
+	#define CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_PG_8M    0xbUL
+	#define CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_PG_16M   0xcUL
+	#define CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_PG_32M   0xdUL
+	#define CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_PG_64M   0xeUL
+	#define CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_PG_128M  0xfUL
+	#define CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_LAST    CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_PG_128M
+	#define CMDQ_INITIALIZE_FW_RSVD_MASK               0xfff0UL
+	#define CMDQ_INITIALIZE_FW_RSVD_SFT                4
+	__le64	qpc_page_dir;
+	__le64	mrw_page_dir;
+	__le64	srq_page_dir;
+	__le64	cq_page_dir;
+	__le64	tqm_page_dir;
+	__le64	tim_page_dir;
+	__le32	number_of_qp;
+	__le32	number_of_mrw;
+	__le32	number_of_srq;
+	__le32	number_of_cq;
+	__le32	max_qp_per_vf;
+	__le32	max_mrw_per_vf;
+	__le32	max_srq_per_vf;
+	__le32	max_cq_per_vf;
+	__le32	max_gid_per_vf;
+	__le32	stat_ctx_id;
+	u8	drv_hsi_ver_maj;
+	u8	drv_hsi_ver_min;
+	u8	drv_hsi_ver_upd;
+	u8	unused40[5];
+	__le16	drv_build_ver_maj;
+	__le16	drv_build_ver_min;
+	__le16	drv_build_ver_upd;
+	__le16	drv_build_ver_patch;
+};
+
+/* creq_initialize_fw_resp (size:128b/16B) */
+struct creq_initialize_fw_resp {
+	u8	type;
+	#define CREQ_INITIALIZE_FW_RESP_TYPE_MASK    0x3fUL
+	#define CREQ_INITIALIZE_FW_RESP_TYPE_SFT     0
+	#define CREQ_INITIALIZE_FW_RESP_TYPE_QP_EVENT  0x38UL
+	#define CREQ_INITIALIZE_FW_RESP_TYPE_LAST     CREQ_INITIALIZE_FW_RESP_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	reserved32;
+	u8	v;
+	#define CREQ_INITIALIZE_FW_RESP_V     0x1UL
+	u8	event;
+	#define CREQ_INITIALIZE_FW_RESP_EVENT_INITIALIZE_FW 0x80UL
+	#define CREQ_INITIALIZE_FW_RESP_EVENT_LAST         CREQ_INITIALIZE_FW_RESP_EVENT_INITIALIZE_FW
+	u8	udcc_session_size;
+	u8	reserved40[5];
+};
+
+/* cmdq_deinitialize_fw (size:128b/16B) */
+struct cmdq_deinitialize_fw {
+	u8	opcode;
+	#define CMDQ_DEINITIALIZE_FW_OPCODE_DEINITIALIZE_FW 0x81UL
+	#define CMDQ_DEINITIALIZE_FW_OPCODE_LAST           CMDQ_DEINITIALIZE_FW_OPCODE_DEINITIALIZE_FW
+	u8	cmd_size;
+	__le16	flags;
+	__le16	cookie;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	resp_addr;
+};
+
+/* creq_deinitialize_fw_resp (size:128b/16B) */
+struct creq_deinitialize_fw_resp {
+	u8	type;
+	#define CREQ_DEINITIALIZE_FW_RESP_TYPE_MASK    0x3fUL
+	#define CREQ_DEINITIALIZE_FW_RESP_TYPE_SFT     0
+	#define CREQ_DEINITIALIZE_FW_RESP_TYPE_QP_EVENT  0x38UL
+	#define CREQ_DEINITIALIZE_FW_RESP_TYPE_LAST     CREQ_DEINITIALIZE_FW_RESP_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	reserved32;
+	u8	v;
+	#define CREQ_DEINITIALIZE_FW_RESP_V     0x1UL
+	u8	event;
+	#define CREQ_DEINITIALIZE_FW_RESP_EVENT_DEINITIALIZE_FW 0x81UL
+	#define CREQ_DEINITIALIZE_FW_RESP_EVENT_LAST           CREQ_DEINITIALIZE_FW_RESP_EVENT_DEINITIALIZE_FW
+	u8	reserved48[6];
+};
+
+/* cmdq_create_qp (size:1152b/144B) */
+struct cmdq_create_qp {
+	u8	opcode;
+	#define CMDQ_CREATE_QP_OPCODE_CREATE_QP 0x1UL
+	#define CMDQ_CREATE_QP_OPCODE_LAST     CMDQ_CREATE_QP_OPCODE_CREATE_QP
+	u8	cmd_size;
+	__le16	flags;
+	__le16	cookie;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	resp_addr;
+	__le64	qp_handle;
+	__le32	qp_flags;
+	#define CMDQ_CREATE_QP_QP_FLAGS_SRQ_USED                   0x1UL
+	#define CMDQ_CREATE_QP_QP_FLAGS_FORCE_COMPLETION           0x2UL
+	#define CMDQ_CREATE_QP_QP_FLAGS_RESERVED_LKEY_ENABLE       0x4UL
+	#define CMDQ_CREATE_QP_QP_FLAGS_FR_PMR_ENABLED             0x8UL
+	#define CMDQ_CREATE_QP_QP_FLAGS_VARIABLE_SIZED_WQE_ENABLED 0x10UL
+	#define CMDQ_CREATE_QP_QP_FLAGS_OPTIMIZED_TRANSMIT_ENABLED 0x20UL
+	#define CMDQ_CREATE_QP_QP_FLAGS_RESPONDER_UD_CQE_WITH_CFA  0x40UL
+	#define CMDQ_CREATE_QP_QP_FLAGS_EXT_STATS_ENABLED          0x80UL
+	#define CMDQ_CREATE_QP_QP_FLAGS_EXPRESS_MODE_ENABLED       0x100UL
+	#define CMDQ_CREATE_QP_QP_FLAGS_STEERING_TAG_VALID         0x200UL
+	#define CMDQ_CREATE_QP_QP_FLAGS_RDMA_READ_OR_ATOMICS_USED  0x400UL
+	#define CMDQ_CREATE_QP_QP_FLAGS_EXT_STATS_CTX_VALID        0x800UL
+	#define CMDQ_CREATE_QP_QP_FLAGS_SCHQ_ID_VALID              0x1000UL
+	#define CMDQ_CREATE_QP_QP_FLAGS_EROCE_VALID                0x2000UL
+	#define CMDQ_CREATE_QP_QP_FLAGS_RQ_PBL_PG_SIZE_VALID       0x4000UL
+	#define CMDQ_CREATE_QP_QP_FLAGS_SQ_PBL_PG_SIZE_VALID       0x8000UL
+	#define CMDQ_CREATE_QP_QP_FLAGS_LAST                      CMDQ_CREATE_QP_QP_FLAGS_SQ_PBL_PG_SIZE_VALID
+	u8	type;
+	#define CMDQ_CREATE_QP_TYPE_RC            0x2UL
+	#define CMDQ_CREATE_QP_TYPE_UD            0x4UL
+	#define CMDQ_CREATE_QP_TYPE_RAW_ETHERTYPE 0x6UL
+	#define CMDQ_CREATE_QP_TYPE_GSI           0x7UL
+	#define CMDQ_CREATE_QP_TYPE_LAST         CMDQ_CREATE_QP_TYPE_GSI
+	u8	sq_pg_size_sq_lvl;
+	#define CMDQ_CREATE_QP_SQ_LVL_MASK      0xfUL
+	#define CMDQ_CREATE_QP_SQ_LVL_SFT       0
+	#define CMDQ_CREATE_QP_SQ_LVL_LVL_0       0x0UL
+	#define CMDQ_CREATE_QP_SQ_LVL_LVL_1       0x1UL
+	#define CMDQ_CREATE_QP_SQ_LVL_LVL_2       0x2UL
+	#define CMDQ_CREATE_QP_SQ_LVL_LAST       CMDQ_CREATE_QP_SQ_LVL_LVL_2
+	#define CMDQ_CREATE_QP_SQ_PG_SIZE_MASK  0xf0UL
+	#define CMDQ_CREATE_QP_SQ_PG_SIZE_SFT   4
+	#define CMDQ_CREATE_QP_SQ_PG_SIZE_PG_4K   (0x0UL << 4)
+	#define CMDQ_CREATE_QP_SQ_PG_SIZE_PG_8K   (0x1UL << 4)
+	#define CMDQ_CREATE_QP_SQ_PG_SIZE_PG_64K  (0x2UL << 4)
+	#define CMDQ_CREATE_QP_SQ_PG_SIZE_PG_2M   (0x3UL << 4)
+	#define CMDQ_CREATE_QP_SQ_PG_SIZE_PG_8M   (0x4UL << 4)
+	#define CMDQ_CREATE_QP_SQ_PG_SIZE_PG_1G   (0x5UL << 4)
+	#define CMDQ_CREATE_QP_SQ_PG_SIZE_LAST   CMDQ_CREATE_QP_SQ_PG_SIZE_PG_1G
+	u8	rq_pg_size_rq_lvl;
+	#define CMDQ_CREATE_QP_RQ_LVL_MASK      0xfUL
+	#define CMDQ_CREATE_QP_RQ_LVL_SFT       0
+	#define CMDQ_CREATE_QP_RQ_LVL_LVL_0       0x0UL
+	#define CMDQ_CREATE_QP_RQ_LVL_LVL_1       0x1UL
+	#define CMDQ_CREATE_QP_RQ_LVL_LVL_2       0x2UL
+	#define CMDQ_CREATE_QP_RQ_LVL_LAST       CMDQ_CREATE_QP_RQ_LVL_LVL_2
+	#define CMDQ_CREATE_QP_RQ_PG_SIZE_MASK  0xf0UL
+	#define CMDQ_CREATE_QP_RQ_PG_SIZE_SFT   4
+	#define CMDQ_CREATE_QP_RQ_PG_SIZE_PG_4K   (0x0UL << 4)
+	#define CMDQ_CREATE_QP_RQ_PG_SIZE_PG_8K   (0x1UL << 4)
+	#define CMDQ_CREATE_QP_RQ_PG_SIZE_PG_64K  (0x2UL << 4)
+	#define CMDQ_CREATE_QP_RQ_PG_SIZE_PG_2M   (0x3UL << 4)
+	#define CMDQ_CREATE_QP_RQ_PG_SIZE_PG_8M   (0x4UL << 4)
+	#define CMDQ_CREATE_QP_RQ_PG_SIZE_PG_1G   (0x5UL << 4)
+	#define CMDQ_CREATE_QP_RQ_PG_SIZE_LAST   CMDQ_CREATE_QP_RQ_PG_SIZE_PG_1G
+	u8	unused_0;
+	__le32	dpi;
+	__le32	sq_size;
+	__le32	rq_size;
+	__le16	sq_fwo_sq_sge;
+	#define CMDQ_CREATE_QP_SQ_SGE_MASK 0xfUL
+	#define CMDQ_CREATE_QP_SQ_SGE_SFT 0
+	#define CMDQ_CREATE_QP_SQ_FWO_MASK 0xfff0UL
+	#define CMDQ_CREATE_QP_SQ_FWO_SFT 4
+	__le16	rq_fwo_rq_sge;
+	#define CMDQ_CREATE_QP_RQ_SGE_MASK 0xfUL
+	#define CMDQ_CREATE_QP_RQ_SGE_SFT 0
+	#define CMDQ_CREATE_QP_RQ_FWO_MASK 0xfff0UL
+	#define CMDQ_CREATE_QP_RQ_FWO_SFT 4
+	__le32	scq_cid;
+	__le32	rcq_cid;
+	__le32	srq_cid;
+	__le32	pd_id;
+	__le64	sq_pbl;
+	__le64	rq_pbl;
+	__le64	irrq_addr;
+	__le64	orrq_addr;
+	__le32	request_xid;
+	__le16	steering_tag;
+	__le16	sq_max_num_wqes;
+	__le32	ext_stats_ctx_id;
+	__le16	schq_id;
+	u8	sq_pbl_pg_size;
+	#define CMDQ_CREATE_QP_SQ_PBL_PG_SIZE_MASK  0xfUL
+	#define CMDQ_CREATE_QP_SQ_PBL_PG_SIZE_SFT   0
+	#define CMDQ_CREATE_QP_SQ_PBL_PG_SIZE_PG_4K   0x0UL
+	#define CMDQ_CREATE_QP_SQ_PBL_PG_SIZE_PG_8K   0x1UL
+	#define CMDQ_CREATE_QP_SQ_PBL_PG_SIZE_PG_64K  0x2UL
+	#define CMDQ_CREATE_QP_SQ_PBL_PG_SIZE_PG_2M   0x3UL
+	#define CMDQ_CREATE_QP_SQ_PBL_PG_SIZE_PG_8M   0x4UL
+	#define CMDQ_CREATE_QP_SQ_PBL_PG_SIZE_PG_1G   0x5UL
+	#define CMDQ_CREATE_QP_SQ_PBL_PG_SIZE_LAST   CMDQ_CREATE_QP_SQ_PBL_PG_SIZE_PG_1G
+	u8	rq_pbl_pg_size;
+	#define CMDQ_CREATE_QP_RQ_PBL_PG_SIZE_MASK  0xfUL
+	#define CMDQ_CREATE_QP_RQ_PBL_PG_SIZE_SFT   0
+	#define CMDQ_CREATE_QP_RQ_PBL_PG_SIZE_PG_4K   0x0UL
+	#define CMDQ_CREATE_QP_RQ_PBL_PG_SIZE_PG_8K   0x1UL
+	#define CMDQ_CREATE_QP_RQ_PBL_PG_SIZE_PG_64K  0x2UL
+	#define CMDQ_CREATE_QP_RQ_PBL_PG_SIZE_PG_2M   0x3UL
+	#define CMDQ_CREATE_QP_RQ_PBL_PG_SIZE_PG_8M   0x4UL
+	#define CMDQ_CREATE_QP_RQ_PBL_PG_SIZE_PG_1G   0x5UL
+	#define CMDQ_CREATE_QP_RQ_PBL_PG_SIZE_LAST   CMDQ_CREATE_QP_RQ_PBL_PG_SIZE_PG_1G
+	__le32	msn_iqp;
+	__le32	irrq_iqp;
+	__le32	orrq_iqp;
+	__le32	msn_size;
+	__le32	irrq_size;
+	__le32	orrq_size;
+	__le16	eroce;
+	#define CMDQ_CREATE_QP_EROCE_COS              0x1UL
+	#define CMDQ_CREATE_QP_EROCE_RESERVED_0_MASK  0xeUL
+	#define CMDQ_CREATE_QP_EROCE_RESERVED_0_SFT   1
+	#define CMDQ_CREATE_QP_EROCE_GRP_MASK         0xf0UL
+	#define CMDQ_CREATE_QP_EROCE_GRP_SFT          4
+	#define CMDQ_CREATE_QP_EROCE_CSIG_ENABLED     0x100UL
+	u8	reserved48[6];
+};
+
+/* creq_create_qp_resp (size:128b/16B) */
+struct creq_create_qp_resp {
+	u8	type;
+	#define CREQ_CREATE_QP_RESP_TYPE_MASK    0x3fUL
+	#define CREQ_CREATE_QP_RESP_TYPE_SFT     0
+	#define CREQ_CREATE_QP_RESP_TYPE_QP_EVENT  0x38UL
+	#define CREQ_CREATE_QP_RESP_TYPE_LAST     CREQ_CREATE_QP_RESP_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	xid;
+	u8	v;
+	#define CREQ_CREATE_QP_RESP_V     0x1UL
+	u8	event;
+	#define CREQ_CREATE_QP_RESP_EVENT_CREATE_QP 0x1UL
+	#define CREQ_CREATE_QP_RESP_EVENT_LAST     CREQ_CREATE_QP_RESP_EVENT_CREATE_QP
+	u8	optimized_transmit_enabled;
+	u8	context_size;
+	u8	reserved32[4];
+};
+
+/* cmdq_destroy_qp (size:192b/24B) */
+struct cmdq_destroy_qp {
+	u8	opcode;
+	#define CMDQ_DESTROY_QP_OPCODE_DESTROY_QP 0x2UL
+	#define CMDQ_DESTROY_QP_OPCODE_LAST      CMDQ_DESTROY_QP_OPCODE_DESTROY_QP
+	u8	cmd_size;
+	__le16	flags;
+	__le16	cookie;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	resp_addr;
+	__le32	qp_cid;
+	__le32	unused_0;
+};
+
+/* creq_destroy_qp_resp (size:128b/16B) */
+struct creq_destroy_qp_resp {
+	u8	type;
+	#define CREQ_DESTROY_QP_RESP_TYPE_MASK    0x3fUL
+	#define CREQ_DESTROY_QP_RESP_TYPE_SFT     0
+	#define CREQ_DESTROY_QP_RESP_TYPE_QP_EVENT  0x38UL
+	#define CREQ_DESTROY_QP_RESP_TYPE_LAST     CREQ_DESTROY_QP_RESP_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	xid;
+	u8	v;
+	#define CREQ_DESTROY_QP_RESP_V     0x1UL
+	u8	event;
+	#define CREQ_DESTROY_QP_RESP_EVENT_DESTROY_QP 0x2UL
+	#define CREQ_DESTROY_QP_RESP_EVENT_LAST      CREQ_DESTROY_QP_RESP_EVENT_DESTROY_QP
+	__le16	udcc_session_id;
+	__le16	udcc_session_data_offset;
+	u8	flags;
+	#define CREQ_DESTROY_QP_RESP_FLAGS_UDCC_SESSION_DATA     0x1UL
+	#define CREQ_DESTROY_QP_RESP_FLAGS_UDCC_RTT_DATA         0x2UL
+	u8	udcc_session_data_size;
+};
+
+/* cmdq_modify_qp (size:1152b/144B) */
+struct cmdq_modify_qp {
+	u8	opcode;
+	#define CMDQ_MODIFY_QP_OPCODE_MODIFY_QP 0x3UL
+	#define CMDQ_MODIFY_QP_OPCODE_LAST     CMDQ_MODIFY_QP_OPCODE_MODIFY_QP
+	u8	cmd_size;
+	__le16	flags;
+	#define CMDQ_MODIFY_QP_FLAGS_SRQ_USED            0x1UL
+	#define CMDQ_MODIFY_QP_FLAGS_EXCLUDE_QP_UDCC     0x2UL
+	__le16	cookie;
+	u8	resp_size;
+	u8	qp_type;
+	#define CMDQ_MODIFY_QP_QP_TYPE_RC            0x2UL
+	#define CMDQ_MODIFY_QP_QP_TYPE_UD            0x4UL
+	#define CMDQ_MODIFY_QP_QP_TYPE_RAW_ETHERTYPE 0x6UL
+	#define CMDQ_MODIFY_QP_QP_TYPE_GSI           0x7UL
+	#define CMDQ_MODIFY_QP_QP_TYPE_LAST         CMDQ_MODIFY_QP_QP_TYPE_GSI
+	__le64	resp_addr;
+	__le32	modify_mask;
+	#define CMDQ_MODIFY_QP_MODIFY_MASK_STATE                   0x1UL
+	#define CMDQ_MODIFY_QP_MODIFY_MASK_EN_SQD_ASYNC_NOTIFY     0x2UL
+	#define CMDQ_MODIFY_QP_MODIFY_MASK_ACCESS                  0x4UL
+	#define CMDQ_MODIFY_QP_MODIFY_MASK_PKEY                    0x8UL
+	#define CMDQ_MODIFY_QP_MODIFY_MASK_QKEY                    0x10UL
+	#define CMDQ_MODIFY_QP_MODIFY_MASK_DGID                    0x20UL
+	#define CMDQ_MODIFY_QP_MODIFY_MASK_FLOW_LABEL              0x40UL
+	#define CMDQ_MODIFY_QP_MODIFY_MASK_SGID_INDEX              0x80UL
+	#define CMDQ_MODIFY_QP_MODIFY_MASK_HOP_LIMIT               0x100UL
+	#define CMDQ_MODIFY_QP_MODIFY_MASK_TRAFFIC_CLASS           0x200UL
+	#define CMDQ_MODIFY_QP_MODIFY_MASK_DEST_MAC                0x400UL
+	#define CMDQ_MODIFY_QP_MODIFY_MASK_PINGPONG_PUSH_MODE      0x800UL
+	#define CMDQ_MODIFY_QP_MODIFY_MASK_PATH_MTU                0x1000UL
+	#define CMDQ_MODIFY_QP_MODIFY_MASK_TIMEOUT                 0x2000UL
+	#define CMDQ_MODIFY_QP_MODIFY_MASK_RETRY_CNT               0x4000UL
+	#define CMDQ_MODIFY_QP_MODIFY_MASK_RNR_RETRY               0x8000UL
+	#define CMDQ_MODIFY_QP_MODIFY_MASK_RQ_PSN                  0x10000UL
+	#define CMDQ_MODIFY_QP_MODIFY_MASK_MAX_RD_ATOMIC           0x20000UL
+	#define CMDQ_MODIFY_QP_MODIFY_MASK_MIN_RNR_TIMER           0x40000UL
+	#define CMDQ_MODIFY_QP_MODIFY_MASK_SQ_PSN                  0x80000UL
+	#define CMDQ_MODIFY_QP_MODIFY_MASK_MAX_DEST_RD_ATOMIC      0x100000UL
+	#define CMDQ_MODIFY_QP_MODIFY_MASK_SQ_SIZE                 0x200000UL
+	#define CMDQ_MODIFY_QP_MODIFY_MASK_RQ_SIZE                 0x400000UL
+	#define CMDQ_MODIFY_QP_MODIFY_MASK_SQ_SGE                  0x800000UL
+	#define CMDQ_MODIFY_QP_MODIFY_MASK_RQ_SGE                  0x1000000UL
+	#define CMDQ_MODIFY_QP_MODIFY_MASK_MAX_INLINE_DATA         0x2000000UL
+	#define CMDQ_MODIFY_QP_MODIFY_MASK_DEST_QP_ID              0x4000000UL
+	#define CMDQ_MODIFY_QP_MODIFY_MASK_SRC_MAC                 0x8000000UL
+	#define CMDQ_MODIFY_QP_MODIFY_MASK_VLAN_ID                 0x10000000UL
+	#define CMDQ_MODIFY_QP_MODIFY_MASK_ENABLE_CC               0x20000000UL
+	#define CMDQ_MODIFY_QP_MODIFY_MASK_TOS_ECN                 0x40000000UL
+	#define CMDQ_MODIFY_QP_MODIFY_MASK_TOS_DSCP                0x80000000UL
+	__le32	qp_cid;
+	u8	network_type_en_sqd_async_notify_new_state;
+	#define CMDQ_MODIFY_QP_NEW_STATE_MASK          0xfUL
+	#define CMDQ_MODIFY_QP_NEW_STATE_SFT           0
+	#define CMDQ_MODIFY_QP_NEW_STATE_RESET           0x0UL
+	#define CMDQ_MODIFY_QP_NEW_STATE_INIT            0x1UL
+	#define CMDQ_MODIFY_QP_NEW_STATE_RTR             0x2UL
+	#define CMDQ_MODIFY_QP_NEW_STATE_RTS             0x3UL
+	#define CMDQ_MODIFY_QP_NEW_STATE_SQD             0x4UL
+	#define CMDQ_MODIFY_QP_NEW_STATE_SQE             0x5UL
+	#define CMDQ_MODIFY_QP_NEW_STATE_ERR             0x6UL
+	#define CMDQ_MODIFY_QP_NEW_STATE_LAST           CMDQ_MODIFY_QP_NEW_STATE_ERR
+	#define CMDQ_MODIFY_QP_EN_SQD_ASYNC_NOTIFY     0x10UL
+	#define CMDQ_MODIFY_QP_UNUSED1                 0x20UL
+	#define CMDQ_MODIFY_QP_NETWORK_TYPE_MASK       0xc0UL
+	#define CMDQ_MODIFY_QP_NETWORK_TYPE_SFT        6
+	#define CMDQ_MODIFY_QP_NETWORK_TYPE_ROCEV1       (0x0UL << 6)
+	#define CMDQ_MODIFY_QP_NETWORK_TYPE_ROCEV2_IPV4  (0x2UL << 6)
+	#define CMDQ_MODIFY_QP_NETWORK_TYPE_ROCEV2_IPV6  (0x3UL << 6)
+	#define CMDQ_MODIFY_QP_NETWORK_TYPE_LAST        CMDQ_MODIFY_QP_NETWORK_TYPE_ROCEV2_IPV6
+	u8	access;
+	#define CMDQ_MODIFY_QP_ACCESS_REMOTE_ATOMIC_REMOTE_READ_REMOTE_WRITE_LOCAL_WRITE_MASK              0xffUL
+	#define CMDQ_MODIFY_QP_ACCESS_REMOTE_ATOMIC_REMOTE_READ_REMOTE_WRITE_LOCAL_WRITE_SFT               0
+	#define CMDQ_MODIFY_QP_ACCESS_LOCAL_WRITE                                                          0x1UL
+	#define CMDQ_MODIFY_QP_ACCESS_REMOTE_WRITE                                                         0x2UL
+	#define CMDQ_MODIFY_QP_ACCESS_REMOTE_READ                                                          0x4UL
+	#define CMDQ_MODIFY_QP_ACCESS_REMOTE_ATOMIC                                                        0x8UL
+	__le16	pkey;
+	__le32	qkey;
+	__le32	dgid[4];
+	__le32	flow_label;
+	__le16	sgid_index;
+	u8	hop_limit;
+	u8	traffic_class;
+	__le16	dest_mac[3];
+	u8	tos_dscp_tos_ecn;
+	#define CMDQ_MODIFY_QP_TOS_ECN_MASK 0x3UL
+	#define CMDQ_MODIFY_QP_TOS_ECN_SFT  0
+	#define CMDQ_MODIFY_QP_TOS_DSCP_MASK 0xfcUL
+	#define CMDQ_MODIFY_QP_TOS_DSCP_SFT 2
+	u8	path_mtu_pingpong_push_enable;
+	#define CMDQ_MODIFY_QP_PINGPONG_PUSH_ENABLE     0x1UL
+	#define CMDQ_MODIFY_QP_UNUSED3_MASK             0xeUL
+	#define CMDQ_MODIFY_QP_UNUSED3_SFT              1
+	#define CMDQ_MODIFY_QP_PATH_MTU_MASK            0xf0UL
+	#define CMDQ_MODIFY_QP_PATH_MTU_SFT             4
+	#define CMDQ_MODIFY_QP_PATH_MTU_MTU_256           (0x0UL << 4)
+	#define CMDQ_MODIFY_QP_PATH_MTU_MTU_512           (0x1UL << 4)
+	#define CMDQ_MODIFY_QP_PATH_MTU_MTU_1024          (0x2UL << 4)
+	#define CMDQ_MODIFY_QP_PATH_MTU_MTU_2048          (0x3UL << 4)
+	#define CMDQ_MODIFY_QP_PATH_MTU_MTU_4096          (0x4UL << 4)
+	#define CMDQ_MODIFY_QP_PATH_MTU_MTU_8192          (0x5UL << 4)
+	#define CMDQ_MODIFY_QP_PATH_MTU_LAST             CMDQ_MODIFY_QP_PATH_MTU_MTU_8192
+	u8	timeout;
+	u8	retry_cnt;
+	u8	rnr_retry;
+	u8	min_rnr_timer;
+	__le32	rq_psn;
+	__le32	sq_psn;
+	u8	max_rd_atomic;
+	u8	max_dest_rd_atomic;
+	__le16	enable_cc;
+	#define CMDQ_MODIFY_QP_ENABLE_CC     0x1UL
+	#define CMDQ_MODIFY_QP_ENH_MODE_MASK 0x6UL
+	#define CMDQ_MODIFY_QP_ENH_MODE_SFT  1
+	#define CMDQ_MODIFY_QP_ENH_COS       0x8UL
+	#define CMDQ_MODIFY_QP_ENH_GRP_MASK  0xf0UL
+	#define CMDQ_MODIFY_QP_ENH_GRP_SFT   4
+	#define CMDQ_MODIFY_QP_UNUSED8_MASK  0xff00UL
+	#define CMDQ_MODIFY_QP_UNUSED8_SFT   8
+	__le32	sq_size;
+	__le32	rq_size;
+	__le16	sq_sge;
+	__le16	rq_sge;
+	__le32	max_inline_data;
+	__le32	dest_qp_id;
+	__le32	pingpong_push_dpi;
+	__le16	src_mac[3];
+	__le16	vlan_pcp_vlan_dei_vlan_id;
+	#define CMDQ_MODIFY_QP_VLAN_ID_MASK 0xfffUL
+	#define CMDQ_MODIFY_QP_VLAN_ID_SFT  0
+	#define CMDQ_MODIFY_QP_VLAN_DEI     0x1000UL
+	#define CMDQ_MODIFY_QP_VLAN_PCP_MASK 0xe000UL
+	#define CMDQ_MODIFY_QP_VLAN_PCP_SFT 13
+	__le64	irrq_addr;
+	__le64	orrq_addr;
+	__le32	ext_modify_mask;
+	#define CMDQ_MODIFY_QP_EXT_MODIFY_MASK_EXT_STATS_CTX          0x1UL
+	#define CMDQ_MODIFY_QP_EXT_MODIFY_MASK_SCHQ_ID_VALID          0x2UL
+	#define CMDQ_MODIFY_QP_EXT_MODIFY_MASK_UDP_SRC_PORT_VALID     0x4UL
+	#define CMDQ_MODIFY_QP_EXT_MODIFY_MASK_RATE_LIMIT_VALID       0x8UL
+	__le32	ext_stats_ctx_id;
+	__le16	schq_id;
+	__le16	udp_src_port;
+	__le32	rate_limit;
+};
+
+/* creq_modify_qp_resp (size:128b/16B) */
+struct creq_modify_qp_resp {
+	u8	type;
+	#define CREQ_MODIFY_QP_RESP_TYPE_MASK    0x3fUL
+	#define CREQ_MODIFY_QP_RESP_TYPE_SFT     0
+	#define CREQ_MODIFY_QP_RESP_TYPE_QP_EVENT  0x38UL
+	#define CREQ_MODIFY_QP_RESP_TYPE_LAST     CREQ_MODIFY_QP_RESP_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	xid;
+	u8	v;
+	#define CREQ_MODIFY_QP_RESP_V     0x1UL
+	u8	event;
+	#define CREQ_MODIFY_QP_RESP_EVENT_MODIFY_QP 0x3UL
+	#define CREQ_MODIFY_QP_RESP_EVENT_LAST     CREQ_MODIFY_QP_RESP_EVENT_MODIFY_QP
+	u8	pingpong_push_state_index_enabled;
+	#define CREQ_MODIFY_QP_RESP_PINGPONG_PUSH_ENABLED     0x1UL
+	#define CREQ_MODIFY_QP_RESP_PINGPONG_PUSH_INDEX_MASK  0xeUL
+	#define CREQ_MODIFY_QP_RESP_PINGPONG_PUSH_INDEX_SFT   1
+	#define CREQ_MODIFY_QP_RESP_PINGPONG_PUSH_STATE       0x10UL
+	u8	shaper_allocation_status;
+	#define CREQ_MODIFY_QP_RESP_SHAPER_ALLOCATED     0x1UL
+	__le16	flags;
+	#define CREQ_MODIFY_QP_RESP_SESSION_ELIGIBLE     0x1UL
+	__le16	reserved16;
+};
+
+/* cmdq_query_qp (size:192b/24B) */
+struct cmdq_query_qp {
+	u8	opcode;
+	#define CMDQ_QUERY_QP_OPCODE_QUERY_QP 0x4UL
+	#define CMDQ_QUERY_QP_OPCODE_LAST    CMDQ_QUERY_QP_OPCODE_QUERY_QP
+	u8	cmd_size;
+	__le16	flags;
+	__le16	cookie;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	resp_addr;
+	__le32	qp_cid;
+	__le32	unused_0;
+};
+
+/* creq_query_qp_resp (size:128b/16B) */
+struct creq_query_qp_resp {
+	u8	type;
+	#define CREQ_QUERY_QP_RESP_TYPE_MASK    0x3fUL
+	#define CREQ_QUERY_QP_RESP_TYPE_SFT     0
+	#define CREQ_QUERY_QP_RESP_TYPE_QP_EVENT  0x38UL
+	#define CREQ_QUERY_QP_RESP_TYPE_LAST     CREQ_QUERY_QP_RESP_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	size;
+	u8	v;
+	#define CREQ_QUERY_QP_RESP_V     0x1UL
+	u8	event;
+	#define CREQ_QUERY_QP_RESP_EVENT_QUERY_QP 0x4UL
+	#define CREQ_QUERY_QP_RESP_EVENT_LAST    CREQ_QUERY_QP_RESP_EVENT_QUERY_QP
+	u8	reserved48[6];
+};
+
+/* creq_query_qp_resp_sb (size:896b/112B) */
+struct creq_query_qp_resp_sb {
+	u8	opcode;
+	#define CREQ_QUERY_QP_RESP_SB_OPCODE_QUERY_QP 0x4UL
+	#define CREQ_QUERY_QP_RESP_SB_OPCODE_LAST    CREQ_QUERY_QP_RESP_SB_OPCODE_QUERY_QP
+	u8	status;
+	__le16	cookie;
+	__le16	flags;
+	u8	resp_size;
+	u8	reserved8;
+	__le32	xid;
+	u8	en_sqd_async_notify_state;
+	#define CREQ_QUERY_QP_RESP_SB_STATE_MASK              0xfUL
+	#define CREQ_QUERY_QP_RESP_SB_STATE_SFT               0
+	#define CREQ_QUERY_QP_RESP_SB_STATE_RESET               0x0UL
+	#define CREQ_QUERY_QP_RESP_SB_STATE_INIT                0x1UL
+	#define CREQ_QUERY_QP_RESP_SB_STATE_RTR                 0x2UL
+	#define CREQ_QUERY_QP_RESP_SB_STATE_RTS                 0x3UL
+	#define CREQ_QUERY_QP_RESP_SB_STATE_SQD                 0x4UL
+	#define CREQ_QUERY_QP_RESP_SB_STATE_SQE                 0x5UL
+	#define CREQ_QUERY_QP_RESP_SB_STATE_ERR                 0x6UL
+	#define CREQ_QUERY_QP_RESP_SB_STATE_LAST               CREQ_QUERY_QP_RESP_SB_STATE_ERR
+	#define CREQ_QUERY_QP_RESP_SB_EN_SQD_ASYNC_NOTIFY     0x10UL
+	#define CREQ_QUERY_QP_RESP_SB_UNUSED3_MASK            0xe0UL
+	#define CREQ_QUERY_QP_RESP_SB_UNUSED3_SFT             5
+	u8	access;
+	#define CREQ_QUERY_QP_RESP_SB_ACCESS_REMOTE_ATOMIC_REMOTE_READ_REMOTE_WRITE_LOCAL_WRITE_MASK              0xffUL
+	#define CREQ_QUERY_QP_RESP_SB_ACCESS_REMOTE_ATOMIC_REMOTE_READ_REMOTE_WRITE_LOCAL_WRITE_SFT               0
+	#define CREQ_QUERY_QP_RESP_SB_ACCESS_LOCAL_WRITE                                                          0x1UL
+	#define CREQ_QUERY_QP_RESP_SB_ACCESS_REMOTE_WRITE                                                         0x2UL
+	#define CREQ_QUERY_QP_RESP_SB_ACCESS_REMOTE_READ                                                          0x4UL
+	#define CREQ_QUERY_QP_RESP_SB_ACCESS_REMOTE_ATOMIC                                                        0x8UL
+	__le16	pkey;
+	__le32	qkey;
+	__le16	udp_src_port;
+	__le16	reserved16;
+	__le32	dgid[4];
+	__le32	flow_label;
+	__le16	sgid_index;
+	u8	hop_limit;
+	u8	traffic_class;
+	__le16	dest_mac[3];
+	__le16	path_mtu_dest_vlan_id;
+	#define CREQ_QUERY_QP_RESP_SB_DEST_VLAN_ID_MASK 0xfffUL
+	#define CREQ_QUERY_QP_RESP_SB_DEST_VLAN_ID_SFT 0
+	#define CREQ_QUERY_QP_RESP_SB_PATH_MTU_MASK    0xf000UL
+	#define CREQ_QUERY_QP_RESP_SB_PATH_MTU_SFT     12
+	#define CREQ_QUERY_QP_RESP_SB_PATH_MTU_MTU_256   (0x0UL << 12)
+	#define CREQ_QUERY_QP_RESP_SB_PATH_MTU_MTU_512   (0x1UL << 12)
+	#define CREQ_QUERY_QP_RESP_SB_PATH_MTU_MTU_1024  (0x2UL << 12)
+	#define CREQ_QUERY_QP_RESP_SB_PATH_MTU_MTU_2048  (0x3UL << 12)
+	#define CREQ_QUERY_QP_RESP_SB_PATH_MTU_MTU_4096  (0x4UL << 12)
+	#define CREQ_QUERY_QP_RESP_SB_PATH_MTU_MTU_8192  (0x5UL << 12)
+	#define CREQ_QUERY_QP_RESP_SB_PATH_MTU_LAST     CREQ_QUERY_QP_RESP_SB_PATH_MTU_MTU_8192
+	u8	timeout;
+	u8	retry_cnt;
+	u8	rnr_retry;
+	u8	min_rnr_timer;
+	__le32	rq_psn;
+	__le32	sq_psn;
+	u8	max_rd_atomic;
+	u8	max_dest_rd_atomic;
+	u8	tos_dscp_tos_ecn;
+	#define CREQ_QUERY_QP_RESP_SB_TOS_ECN_MASK 0x3UL
+	#define CREQ_QUERY_QP_RESP_SB_TOS_ECN_SFT  0
+	#define CREQ_QUERY_QP_RESP_SB_TOS_DSCP_MASK 0xfcUL
+	#define CREQ_QUERY_QP_RESP_SB_TOS_DSCP_SFT 2
+	u8	enable_cc;
+	#define CREQ_QUERY_QP_RESP_SB_ENABLE_CC     0x1UL
+	__le32	sq_size;
+	__le32	rq_size;
+	__le16	sq_sge;
+	__le16	rq_sge;
+	__le32	max_inline_data;
+	__le32	dest_qp_id;
+	__le16	port_id;
+	u8	unused_0;
+	u8	stat_collection_id;
+	__le16	src_mac[3];
+	__le16	vlan_pcp_vlan_dei_vlan_id;
+	#define CREQ_QUERY_QP_RESP_SB_VLAN_ID_MASK 0xfffUL
+	#define CREQ_QUERY_QP_RESP_SB_VLAN_ID_SFT  0
+	#define CREQ_QUERY_QP_RESP_SB_VLAN_DEI     0x1000UL
+	#define CREQ_QUERY_QP_RESP_SB_VLAN_PCP_MASK 0xe000UL
+	#define CREQ_QUERY_QP_RESP_SB_VLAN_PCP_SFT 13
+	__le32	rate_limit;
+	__le32	reserved32;
+};
+
+/* cmdq_query_qp_extend (size:192b/24B) */
+struct cmdq_query_qp_extend {
+	u8	opcode;
+	#define CMDQ_QUERY_QP_EXTEND_OPCODE_QUERY_QP_EXTEND 0x91UL
+	#define CMDQ_QUERY_QP_EXTEND_OPCODE_LAST           CMDQ_QUERY_QP_EXTEND_OPCODE_QUERY_QP_EXTEND
+	u8	cmd_size;
+	__le16	flags;
+	__le16	cookie;
+	u8	resp_size;
+	u8	num_qps;
+	__le64	resp_addr;
+	__le32	function_id;
+	#define CMDQ_QUERY_QP_EXTEND_PF_NUM_MASK  0xffUL
+	#define CMDQ_QUERY_QP_EXTEND_PF_NUM_SFT   0
+	#define CMDQ_QUERY_QP_EXTEND_VF_NUM_MASK  0xffff00UL
+	#define CMDQ_QUERY_QP_EXTEND_VF_NUM_SFT   8
+	#define CMDQ_QUERY_QP_EXTEND_VF_VALID     0x1000000UL
+	__le32	current_index;
+};
+
+/* creq_query_qp_extend_resp (size:128b/16B) */
+struct creq_query_qp_extend_resp {
+	u8	type;
+	#define CREQ_QUERY_QP_EXTEND_RESP_TYPE_MASK    0x3fUL
+	#define CREQ_QUERY_QP_EXTEND_RESP_TYPE_SFT     0
+	#define CREQ_QUERY_QP_EXTEND_RESP_TYPE_QP_EVENT  0x38UL
+	#define CREQ_QUERY_QP_EXTEND_RESP_TYPE_LAST     CREQ_QUERY_QP_EXTEND_RESP_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	size;
+	u8	v;
+	#define CREQ_QUERY_QP_EXTEND_RESP_V     0x1UL
+	u8	event;
+	#define CREQ_QUERY_QP_EXTEND_RESP_EVENT_QUERY_QP_EXTEND 0x91UL
+	#define CREQ_QUERY_QP_EXTEND_RESP_EVENT_LAST           CREQ_QUERY_QP_EXTEND_RESP_EVENT_QUERY_QP_EXTEND
+	__le16	reserved16;
+	__le32	current_index;
+};
+
+/* creq_query_qp_extend_resp_sb (size:384b/48B) */
+struct creq_query_qp_extend_resp_sb {
+	u8	opcode;
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_OPCODE_QUERY_QP_EXTEND 0x91UL
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_OPCODE_LAST           CREQ_QUERY_QP_EXTEND_RESP_SB_OPCODE_QUERY_QP_EXTEND
+	u8	status;
+	__le16	cookie;
+	__le16	flags;
+	u8	resp_size;
+	u8	reserved8;
+	__le32	xid;
+	u8	state;
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_STATE_MASK  0xfUL
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_STATE_SFT   0
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_STATE_RESET   0x0UL
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_STATE_INIT    0x1UL
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_STATE_RTR     0x2UL
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_STATE_RTS     0x3UL
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_STATE_SQD     0x4UL
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_STATE_SQE     0x5UL
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_STATE_ERR     0x6UL
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_STATE_LAST   CREQ_QUERY_QP_EXTEND_RESP_SB_STATE_ERR
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_UNUSED4_MASK 0xf0UL
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_UNUSED4_SFT 4
+	u8	reserved_8;
+	__le16	port_id;
+	__le32	qkey;
+	__le16	sgid_index;
+	u8	network_type;
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_NETWORK_TYPE_ROCEV1      0x0UL
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_NETWORK_TYPE_ROCEV2_IPV4 0x2UL
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_NETWORK_TYPE_ROCEV2_IPV6 0x3UL
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_NETWORK_TYPE_LAST       CREQ_QUERY_QP_EXTEND_RESP_SB_NETWORK_TYPE_ROCEV2_IPV6
+	u8	unused_0;
+	__le32	dgid[4];
+	__le32	dest_qp_id;
+	u8	stat_collection_id;
+	u8	reserved2_8;
+	__le16	reserved_16;
+};
+
+/* creq_query_qp_extend_resp_sb_tlv (size:512b/64B) */
+struct creq_query_qp_extend_resp_sb_tlv {
+	__le16	cmd_discr;
+	u8	reserved_8b;
+	u8	tlv_flags;
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_TLV_TLV_FLAGS_MORE         0x1UL
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_TLV_TLV_FLAGS_MORE_LAST      0x0UL
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_TLV_TLV_FLAGS_MORE_NOT_LAST  0x1UL
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_TLV_TLV_FLAGS_REQUIRED     0x2UL
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_TLV_TLV_FLAGS_REQUIRED_NO    (0x0UL << 1)
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_TLV_TLV_FLAGS_REQUIRED_YES   (0x1UL << 1)
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_TLV_TLV_FLAGS_REQUIRED_LAST CREQ_QUERY_QP_EXTEND_RESP_SB_TLV_TLV_FLAGS_REQUIRED_YES
+	__le16	tlv_type;
+	__le16	length;
+	u8	total_size;
+	u8	reserved56[7];
+	u8	opcode;
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_TLV_OPCODE_QUERY_QP_EXTEND 0x91UL
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_TLV_OPCODE_LAST           CREQ_QUERY_QP_EXTEND_RESP_SB_TLV_OPCODE_QUERY_QP_EXTEND
+	u8	status;
+	__le16	cookie;
+	__le16	flags;
+	u8	resp_size;
+	u8	reserved8;
+	__le32	xid;
+	u8	state;
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_TLV_STATE_MASK  0xfUL
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_TLV_STATE_SFT   0
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_TLV_STATE_RESET   0x0UL
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_TLV_STATE_INIT    0x1UL
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_TLV_STATE_RTR     0x2UL
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_TLV_STATE_RTS     0x3UL
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_TLV_STATE_SQD     0x4UL
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_TLV_STATE_SQE     0x5UL
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_TLV_STATE_ERR     0x6UL
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_TLV_STATE_LAST   CREQ_QUERY_QP_EXTEND_RESP_SB_TLV_STATE_ERR
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_TLV_UNUSED4_MASK 0xf0UL
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_TLV_UNUSED4_SFT 4
+	u8	reserved_8;
+	__le16	port_id;
+	__le32	qkey;
+	__le16	sgid_index;
+	u8	network_type;
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_TLV_NETWORK_TYPE_ROCEV1      0x0UL
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_TLV_NETWORK_TYPE_ROCEV2_IPV4 0x2UL
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_TLV_NETWORK_TYPE_ROCEV2_IPV6 0x3UL
+	#define CREQ_QUERY_QP_EXTEND_RESP_SB_TLV_NETWORK_TYPE_LAST       CREQ_QUERY_QP_EXTEND_RESP_SB_TLV_NETWORK_TYPE_ROCEV2_IPV6
+	u8	unused_0;
+	__le32	dgid[4];
+	__le32	dest_qp_id;
+	u8	stat_collection_id;
+	u8	reserved2_8;
+	__le16	reserved_16;
+};
+
+/* cmdq_create_srq (size:512b/64B) */
+struct cmdq_create_srq {
+	u8	opcode;
+	#define CMDQ_CREATE_SRQ_OPCODE_CREATE_SRQ 0x5UL
+	#define CMDQ_CREATE_SRQ_OPCODE_LAST      CMDQ_CREATE_SRQ_OPCODE_CREATE_SRQ
+	u8	cmd_size;
+	__le16	flags;
+	#define CMDQ_CREATE_SRQ_FLAGS_STEERING_TAG_VALID     0x1UL
+	#define CMDQ_CREATE_SRQ_FLAGS_PBL_PG_SIZE_VALID      0x2UL
+	__le16	cookie;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	resp_addr;
+	__le64	srq_handle;
+	__le16	pg_size_lvl;
+	#define CMDQ_CREATE_SRQ_LVL_MASK      0x3UL
+	#define CMDQ_CREATE_SRQ_LVL_SFT       0
+	#define CMDQ_CREATE_SRQ_LVL_LVL_0       0x0UL
+	#define CMDQ_CREATE_SRQ_LVL_LVL_1       0x1UL
+	#define CMDQ_CREATE_SRQ_LVL_LVL_2       0x2UL
+	#define CMDQ_CREATE_SRQ_LVL_LAST       CMDQ_CREATE_SRQ_LVL_LVL_2
+	#define CMDQ_CREATE_SRQ_PG_SIZE_MASK  0x1cUL
+	#define CMDQ_CREATE_SRQ_PG_SIZE_SFT   2
+	#define CMDQ_CREATE_SRQ_PG_SIZE_PG_4K   (0x0UL << 2)
+	#define CMDQ_CREATE_SRQ_PG_SIZE_PG_8K   (0x1UL << 2)
+	#define CMDQ_CREATE_SRQ_PG_SIZE_PG_64K  (0x2UL << 2)
+	#define CMDQ_CREATE_SRQ_PG_SIZE_PG_2M   (0x3UL << 2)
+	#define CMDQ_CREATE_SRQ_PG_SIZE_PG_8M   (0x4UL << 2)
+	#define CMDQ_CREATE_SRQ_PG_SIZE_PG_1G   (0x5UL << 2)
+	#define CMDQ_CREATE_SRQ_PG_SIZE_LAST   CMDQ_CREATE_SRQ_PG_SIZE_PG_1G
+	#define CMDQ_CREATE_SRQ_UNUSED11_MASK 0xffe0UL
+	#define CMDQ_CREATE_SRQ_UNUSED11_SFT  5
+	__le16	eventq_id;
+	#define CMDQ_CREATE_SRQ_EVENTQ_ID_MASK 0xfffUL
+	#define CMDQ_CREATE_SRQ_EVENTQ_ID_SFT 0
+	#define CMDQ_CREATE_SRQ_UNUSED4_MASK  0xf000UL
+	#define CMDQ_CREATE_SRQ_UNUSED4_SFT   12
+	__le16	srq_size;
+	__le16	srq_fwo;
+	#define CMDQ_CREATE_SRQ_SRQ_FWO_MASK 0xfffUL
+	#define CMDQ_CREATE_SRQ_SRQ_FWO_SFT 0
+	#define CMDQ_CREATE_SRQ_SRQ_SGE_MASK 0xf000UL
+	#define CMDQ_CREATE_SRQ_SRQ_SGE_SFT 12
+	__le32	dpi;
+	__le32	pd_id;
+	__le64	pbl;
+	__le16	steering_tag;
+	u8	pbl_pg_size;
+	#define CMDQ_CREATE_SRQ_PBL_PG_SIZE_MASK  0x7UL
+	#define CMDQ_CREATE_SRQ_PBL_PG_SIZE_SFT   0
+	#define CMDQ_CREATE_SRQ_PBL_PG_SIZE_PG_4K   0x0UL
+	#define CMDQ_CREATE_SRQ_PBL_PG_SIZE_PG_8K   0x1UL
+	#define CMDQ_CREATE_SRQ_PBL_PG_SIZE_PG_64K  0x2UL
+	#define CMDQ_CREATE_SRQ_PBL_PG_SIZE_PG_2M   0x3UL
+	#define CMDQ_CREATE_SRQ_PBL_PG_SIZE_PG_8M   0x4UL
+	#define CMDQ_CREATE_SRQ_PBL_PG_SIZE_PG_1G   0x5UL
+	#define CMDQ_CREATE_SRQ_PBL_PG_SIZE_LAST   CMDQ_CREATE_SRQ_PBL_PG_SIZE_PG_1G
+	u8	reserved40[5];
+	__le64	reserved64;
+};
+
+/* creq_create_srq_resp (size:128b/16B) */
+struct creq_create_srq_resp {
+	u8	type;
+	#define CREQ_CREATE_SRQ_RESP_TYPE_MASK    0x3fUL
+	#define CREQ_CREATE_SRQ_RESP_TYPE_SFT     0
+	#define CREQ_CREATE_SRQ_RESP_TYPE_QP_EVENT  0x38UL
+	#define CREQ_CREATE_SRQ_RESP_TYPE_LAST     CREQ_CREATE_SRQ_RESP_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	xid;
+	u8	v;
+	#define CREQ_CREATE_SRQ_RESP_V     0x1UL
+	u8	event;
+	#define CREQ_CREATE_SRQ_RESP_EVENT_CREATE_SRQ 0x5UL
+	#define CREQ_CREATE_SRQ_RESP_EVENT_LAST      CREQ_CREATE_SRQ_RESP_EVENT_CREATE_SRQ
+	u8	context_size;
+	u8	reserved48[5];
+};
+
+/* cmdq_destroy_srq (size:192b/24B) */
+struct cmdq_destroy_srq {
+	u8	opcode;
+	#define CMDQ_DESTROY_SRQ_OPCODE_DESTROY_SRQ 0x6UL
+	#define CMDQ_DESTROY_SRQ_OPCODE_LAST       CMDQ_DESTROY_SRQ_OPCODE_DESTROY_SRQ
+	u8	cmd_size;
+	__le16	flags;
+	__le16	cookie;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	resp_addr;
+	__le32	srq_cid;
+	__le32	unused_0;
+};
+
+/* creq_destroy_srq_resp (size:128b/16B) */
+struct creq_destroy_srq_resp {
+	u8	type;
+	#define CREQ_DESTROY_SRQ_RESP_TYPE_MASK    0x3fUL
+	#define CREQ_DESTROY_SRQ_RESP_TYPE_SFT     0
+	#define CREQ_DESTROY_SRQ_RESP_TYPE_QP_EVENT  0x38UL
+	#define CREQ_DESTROY_SRQ_RESP_TYPE_LAST     CREQ_DESTROY_SRQ_RESP_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	xid;
+	u8	v;
+	#define CREQ_DESTROY_SRQ_RESP_V     0x1UL
+	u8	event;
+	#define CREQ_DESTROY_SRQ_RESP_EVENT_DESTROY_SRQ 0x6UL
+	#define CREQ_DESTROY_SRQ_RESP_EVENT_LAST       CREQ_DESTROY_SRQ_RESP_EVENT_DESTROY_SRQ
+	__le16	enable_for_arm[3];
+	#define CREQ_DESTROY_SRQ_RESP_UNUSED0_MASK       0xffffUL
+	#define CREQ_DESTROY_SRQ_RESP_UNUSED0_SFT        0
+	#define CREQ_DESTROY_SRQ_RESP_ENABLE_FOR_ARM_MASK 0x30000UL
+	#define CREQ_DESTROY_SRQ_RESP_ENABLE_FOR_ARM_SFT 16
+};
+
+/* cmdq_query_srq (size:192b/24B) */
+struct cmdq_query_srq {
+	u8	opcode;
+	#define CMDQ_QUERY_SRQ_OPCODE_QUERY_SRQ 0x8UL
+	#define CMDQ_QUERY_SRQ_OPCODE_LAST     CMDQ_QUERY_SRQ_OPCODE_QUERY_SRQ
+	u8	cmd_size;
+	__le16	flags;
+	__le16	cookie;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	resp_addr;
+	__le32	srq_cid;
+	__le32	unused_0;
+};
+
+/* creq_query_srq_resp (size:128b/16B) */
+struct creq_query_srq_resp {
+	u8	type;
+	#define CREQ_QUERY_SRQ_RESP_TYPE_MASK    0x3fUL
+	#define CREQ_QUERY_SRQ_RESP_TYPE_SFT     0
+	#define CREQ_QUERY_SRQ_RESP_TYPE_QP_EVENT  0x38UL
+	#define CREQ_QUERY_SRQ_RESP_TYPE_LAST     CREQ_QUERY_SRQ_RESP_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	size;
+	u8	v;
+	#define CREQ_QUERY_SRQ_RESP_V     0x1UL
+	u8	event;
+	#define CREQ_QUERY_SRQ_RESP_EVENT_QUERY_SRQ 0x8UL
+	#define CREQ_QUERY_SRQ_RESP_EVENT_LAST     CREQ_QUERY_SRQ_RESP_EVENT_QUERY_SRQ
+	u8	reserved48[6];
+};
+
+/* creq_query_srq_resp_sb (size:256b/32B) */
+struct creq_query_srq_resp_sb {
+	u8	opcode;
+	#define CREQ_QUERY_SRQ_RESP_SB_OPCODE_QUERY_SRQ 0x8UL
+	#define CREQ_QUERY_SRQ_RESP_SB_OPCODE_LAST     CREQ_QUERY_SRQ_RESP_SB_OPCODE_QUERY_SRQ
+	u8	status;
+	__le16	cookie;
+	__le16	flags;
+	u8	resp_size;
+	u8	reserved8;
+	__le32	xid;
+	__le16	srq_limit;
+	__le16	reserved16;
+	__le32	data[4];
+};
+
+/* cmdq_create_cq (size:512b/64B) */
+struct cmdq_create_cq {
+	u8	opcode;
+	#define CMDQ_CREATE_CQ_OPCODE_CREATE_CQ 0x9UL
+	#define CMDQ_CREATE_CQ_OPCODE_LAST     CMDQ_CREATE_CQ_OPCODE_CREATE_CQ
+	u8	cmd_size;
+	__le16	flags;
+	#define CMDQ_CREATE_CQ_FLAGS_DISABLE_CQ_OVERFLOW_DETECTION     0x1UL
+	#define CMDQ_CREATE_CQ_FLAGS_STEERING_TAG_VALID                0x2UL
+	#define CMDQ_CREATE_CQ_FLAGS_INFINITE_CQ_MODE                  0x4UL
+	#define CMDQ_CREATE_CQ_FLAGS_COALESCING_VALID                  0x8UL
+	#define CMDQ_CREATE_CQ_FLAGS_PBL_PG_SIZE_VALID                 0x10UL
+	__le16	cookie;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	resp_addr;
+	__le64	cq_handle;
+	__le32	pg_size_lvl;
+	#define CMDQ_CREATE_CQ_LVL_MASK      0x3UL
+	#define CMDQ_CREATE_CQ_LVL_SFT       0
+	#define CMDQ_CREATE_CQ_LVL_LVL_0       0x0UL
+	#define CMDQ_CREATE_CQ_LVL_LVL_1       0x1UL
+	#define CMDQ_CREATE_CQ_LVL_LVL_2       0x2UL
+	#define CMDQ_CREATE_CQ_LVL_LAST       CMDQ_CREATE_CQ_LVL_LVL_2
+	#define CMDQ_CREATE_CQ_PG_SIZE_MASK  0x1cUL
+	#define CMDQ_CREATE_CQ_PG_SIZE_SFT   2
+	#define CMDQ_CREATE_CQ_PG_SIZE_PG_4K   (0x0UL << 2)
+	#define CMDQ_CREATE_CQ_PG_SIZE_PG_8K   (0x1UL << 2)
+	#define CMDQ_CREATE_CQ_PG_SIZE_PG_64K  (0x2UL << 2)
+	#define CMDQ_CREATE_CQ_PG_SIZE_PG_2M   (0x3UL << 2)
+	#define CMDQ_CREATE_CQ_PG_SIZE_PG_8M   (0x4UL << 2)
+	#define CMDQ_CREATE_CQ_PG_SIZE_PG_1G   (0x5UL << 2)
+	#define CMDQ_CREATE_CQ_PG_SIZE_LAST   CMDQ_CREATE_CQ_PG_SIZE_PG_1G
+	#define CMDQ_CREATE_CQ_UNUSED27_MASK 0xffffffe0UL
+	#define CMDQ_CREATE_CQ_UNUSED27_SFT  5
+	__le32	cq_fco_cnq_id;
+	#define CMDQ_CREATE_CQ_CNQ_ID_MASK 0xfffUL
+	#define CMDQ_CREATE_CQ_CNQ_ID_SFT 0
+	#define CMDQ_CREATE_CQ_CQ_FCO_MASK 0xfffff000UL
+	#define CMDQ_CREATE_CQ_CQ_FCO_SFT 12
+	__le32	dpi;
+	__le32	cq_size;
+	__le64	pbl;
+	__le16	steering_tag;
+	u8	pbl_pg_size;
+	#define CMDQ_CREATE_CQ_PBL_PG_SIZE_MASK  0x7UL
+	#define CMDQ_CREATE_CQ_PBL_PG_SIZE_SFT   0
+	#define CMDQ_CREATE_CQ_PBL_PG_SIZE_PG_4K   0x0UL
+	#define CMDQ_CREATE_CQ_PBL_PG_SIZE_PG_8K   0x1UL
+	#define CMDQ_CREATE_CQ_PBL_PG_SIZE_PG_64K  0x2UL
+	#define CMDQ_CREATE_CQ_PBL_PG_SIZE_PG_2M   0x3UL
+	#define CMDQ_CREATE_CQ_PBL_PG_SIZE_PG_8M   0x4UL
+	#define CMDQ_CREATE_CQ_PBL_PG_SIZE_PG_1G   0x5UL
+	#define CMDQ_CREATE_CQ_PBL_PG_SIZE_LAST   CMDQ_CREATE_CQ_PBL_PG_SIZE_PG_1G
+	u8	reserved8_1;
+	__le32	coalescing;
+	#define CMDQ_CREATE_CQ_BUF_MAXTIME_MASK          0x1ffUL
+	#define CMDQ_CREATE_CQ_BUF_MAXTIME_SFT           0
+	#define CMDQ_CREATE_CQ_NORMAL_MAXBUF_MASK        0x3e00UL
+	#define CMDQ_CREATE_CQ_NORMAL_MAXBUF_SFT         9
+	#define CMDQ_CREATE_CQ_DURING_MAXBUF_MASK        0x7c000UL
+	#define CMDQ_CREATE_CQ_DURING_MAXBUF_SFT         14
+	#define CMDQ_CREATE_CQ_ENABLE_RING_IDLE_MODE     0x80000UL
+	#define CMDQ_CREATE_CQ_UNUSED12_MASK             0xfff00000UL
+	#define CMDQ_CREATE_CQ_UNUSED12_SFT              20
+	__le64	reserved64;
+};
+
+/* creq_create_cq_resp (size:128b/16B) */
+struct creq_create_cq_resp {
+	u8	type;
+	#define CREQ_CREATE_CQ_RESP_TYPE_MASK    0x3fUL
+	#define CREQ_CREATE_CQ_RESP_TYPE_SFT     0
+	#define CREQ_CREATE_CQ_RESP_TYPE_QP_EVENT  0x38UL
+	#define CREQ_CREATE_CQ_RESP_TYPE_LAST     CREQ_CREATE_CQ_RESP_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	xid;
+	u8	v;
+	#define CREQ_CREATE_CQ_RESP_V     0x1UL
+	u8	event;
+	#define CREQ_CREATE_CQ_RESP_EVENT_CREATE_CQ 0x9UL
+	#define CREQ_CREATE_CQ_RESP_EVENT_LAST     CREQ_CREATE_CQ_RESP_EVENT_CREATE_CQ
+	u8	context_size;
+	u8	reserved48[5];
+};
+
+/* cmdq_destroy_cq (size:192b/24B) */
+struct cmdq_destroy_cq {
+	u8	opcode;
+	#define CMDQ_DESTROY_CQ_OPCODE_DESTROY_CQ 0xaUL
+	#define CMDQ_DESTROY_CQ_OPCODE_LAST      CMDQ_DESTROY_CQ_OPCODE_DESTROY_CQ
+	u8	cmd_size;
+	__le16	flags;
+	__le16	cookie;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	resp_addr;
+	__le32	cq_cid;
+	__le32	unused_0;
+};
+
+/* creq_destroy_cq_resp (size:128b/16B) */
+struct creq_destroy_cq_resp {
+	u8	type;
+	#define CREQ_DESTROY_CQ_RESP_TYPE_MASK    0x3fUL
+	#define CREQ_DESTROY_CQ_RESP_TYPE_SFT     0
+	#define CREQ_DESTROY_CQ_RESP_TYPE_QP_EVENT  0x38UL
+	#define CREQ_DESTROY_CQ_RESP_TYPE_LAST     CREQ_DESTROY_CQ_RESP_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	xid;
+	u8	v;
+	#define CREQ_DESTROY_CQ_RESP_V     0x1UL
+	u8	event;
+	#define CREQ_DESTROY_CQ_RESP_EVENT_DESTROY_CQ 0xaUL
+	#define CREQ_DESTROY_CQ_RESP_EVENT_LAST      CREQ_DESTROY_CQ_RESP_EVENT_DESTROY_CQ
+	__le16	cq_arm_lvl;
+	#define CREQ_DESTROY_CQ_RESP_CQ_ARM_LVL_MASK 0x3UL
+	#define CREQ_DESTROY_CQ_RESP_CQ_ARM_LVL_SFT 0
+	__le16	total_cnq_events;
+	__le16	reserved16;
+};
+
+/* cmdq_resize_cq (size:320b/40B) */
+struct cmdq_resize_cq {
+	u8	opcode;
+	#define CMDQ_RESIZE_CQ_OPCODE_RESIZE_CQ 0xcUL
+	#define CMDQ_RESIZE_CQ_OPCODE_LAST     CMDQ_RESIZE_CQ_OPCODE_RESIZE_CQ
+	u8	cmd_size;
+	__le16	flags;
+	#define CMDQ_RESIZE_CQ_FLAGS_PBL_PG_SIZE_VALID     0x1UL
+	__le16	cookie;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	resp_addr;
+	__le32	cq_cid;
+	__le32	new_cq_size_pg_size_lvl;
+	#define CMDQ_RESIZE_CQ_LVL_MASK        0x3UL
+	#define CMDQ_RESIZE_CQ_LVL_SFT         0
+	#define CMDQ_RESIZE_CQ_LVL_LVL_0         0x0UL
+	#define CMDQ_RESIZE_CQ_LVL_LVL_1         0x1UL
+	#define CMDQ_RESIZE_CQ_LVL_LVL_2         0x2UL
+	#define CMDQ_RESIZE_CQ_LVL_LAST         CMDQ_RESIZE_CQ_LVL_LVL_2
+	#define CMDQ_RESIZE_CQ_PG_SIZE_MASK    0x1cUL
+	#define CMDQ_RESIZE_CQ_PG_SIZE_SFT     2
+	#define CMDQ_RESIZE_CQ_PG_SIZE_PG_4K     (0x0UL << 2)
+	#define CMDQ_RESIZE_CQ_PG_SIZE_PG_8K     (0x1UL << 2)
+	#define CMDQ_RESIZE_CQ_PG_SIZE_PG_64K    (0x2UL << 2)
+	#define CMDQ_RESIZE_CQ_PG_SIZE_PG_2M     (0x3UL << 2)
+	#define CMDQ_RESIZE_CQ_PG_SIZE_PG_8M     (0x4UL << 2)
+	#define CMDQ_RESIZE_CQ_PG_SIZE_PG_1G     (0x5UL << 2)
+	#define CMDQ_RESIZE_CQ_PG_SIZE_LAST     CMDQ_RESIZE_CQ_PG_SIZE_PG_1G
+	#define CMDQ_RESIZE_CQ_NEW_CQ_SIZE_MASK 0x1fffffe0UL
+	#define CMDQ_RESIZE_CQ_NEW_CQ_SIZE_SFT 5
+	__le64	new_pbl;
+	__le32	new_cq_fco;
+	#define CMDQ_RESIZE_CQ_CQ_FCO_MASK 0xfffffUL
+	#define CMDQ_RESIZE_CQ_CQ_FCO_SFT 0
+	#define CMDQ_RESIZE_CQ_RSVD_MASK  0xfff00000UL
+	#define CMDQ_RESIZE_CQ_RSVD_SFT   20
+	u8	pbl_pg_size;
+	#define CMDQ_RESIZE_CQ_PBL_PG_SIZE_MASK  0x7UL
+	#define CMDQ_RESIZE_CQ_PBL_PG_SIZE_SFT   0
+	#define CMDQ_RESIZE_CQ_PBL_PG_SIZE_PG_4K   0x0UL
+	#define CMDQ_RESIZE_CQ_PBL_PG_SIZE_PG_8K   0x1UL
+	#define CMDQ_RESIZE_CQ_PBL_PG_SIZE_PG_64K  0x2UL
+	#define CMDQ_RESIZE_CQ_PBL_PG_SIZE_PG_2M   0x3UL
+	#define CMDQ_RESIZE_CQ_PBL_PG_SIZE_PG_8M   0x4UL
+	#define CMDQ_RESIZE_CQ_PBL_PG_SIZE_PG_1G   0x5UL
+	#define CMDQ_RESIZE_CQ_PBL_PG_SIZE_LAST   CMDQ_RESIZE_CQ_PBL_PG_SIZE_PG_1G
+	u8	unused_0[3];
+};
+
+/* creq_resize_cq_resp (size:128b/16B) */
+struct creq_resize_cq_resp {
+	u8	type;
+	#define CREQ_RESIZE_CQ_RESP_TYPE_MASK    0x3fUL
+	#define CREQ_RESIZE_CQ_RESP_TYPE_SFT     0
+	#define CREQ_RESIZE_CQ_RESP_TYPE_QP_EVENT  0x38UL
+	#define CREQ_RESIZE_CQ_RESP_TYPE_LAST     CREQ_RESIZE_CQ_RESP_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	xid;
+	u8	v;
+	#define CREQ_RESIZE_CQ_RESP_V     0x1UL
+	u8	event;
+	#define CREQ_RESIZE_CQ_RESP_EVENT_RESIZE_CQ 0xcUL
+	#define CREQ_RESIZE_CQ_RESP_EVENT_LAST     CREQ_RESIZE_CQ_RESP_EVENT_RESIZE_CQ
+	u8	reserved48[6];
+};
+
+/* cmdq_allocate_mrw (size:256b/32B) */
+struct cmdq_allocate_mrw {
+	u8	opcode;
+	#define CMDQ_ALLOCATE_MRW_OPCODE_ALLOCATE_MRW 0xdUL
+	#define CMDQ_ALLOCATE_MRW_OPCODE_LAST        CMDQ_ALLOCATE_MRW_OPCODE_ALLOCATE_MRW
+	u8	cmd_size;
+	__le16	flags;
+	__le16	cookie;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	resp_addr;
+	__le64	mrw_handle;
+	u8	mrw_flags;
+	#define CMDQ_ALLOCATE_MRW_MRW_FLAGS_MASK         0xfUL
+	#define CMDQ_ALLOCATE_MRW_MRW_FLAGS_SFT          0
+	#define CMDQ_ALLOCATE_MRW_MRW_FLAGS_MR             0x0UL
+	#define CMDQ_ALLOCATE_MRW_MRW_FLAGS_PMR            0x1UL
+	#define CMDQ_ALLOCATE_MRW_MRW_FLAGS_MW_TYPE1       0x2UL
+	#define CMDQ_ALLOCATE_MRW_MRW_FLAGS_MW_TYPE2A      0x3UL
+	#define CMDQ_ALLOCATE_MRW_MRW_FLAGS_MW_TYPE2B      0x4UL
+	#define CMDQ_ALLOCATE_MRW_MRW_FLAGS_LAST          CMDQ_ALLOCATE_MRW_MRW_FLAGS_MW_TYPE2B
+	#define CMDQ_ALLOCATE_MRW_STEERING_TAG_VALID     0x10UL
+	#define CMDQ_ALLOCATE_MRW_UNUSED3_MASK           0xe0UL
+	#define CMDQ_ALLOCATE_MRW_UNUSED3_SFT            5
+	u8	access;
+	#define CMDQ_ALLOCATE_MRW_ACCESS_CONSUMER_OWNED_KEY     0x20UL
+	__le16	steering_tag;
+	__le32	pd_id;
+};
+
+/* creq_allocate_mrw_resp (size:128b/16B) */
+struct creq_allocate_mrw_resp {
+	u8	type;
+	#define CREQ_ALLOCATE_MRW_RESP_TYPE_MASK    0x3fUL
+	#define CREQ_ALLOCATE_MRW_RESP_TYPE_SFT     0
+	#define CREQ_ALLOCATE_MRW_RESP_TYPE_QP_EVENT  0x38UL
+	#define CREQ_ALLOCATE_MRW_RESP_TYPE_LAST     CREQ_ALLOCATE_MRW_RESP_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	xid;
+	u8	v;
+	#define CREQ_ALLOCATE_MRW_RESP_V     0x1UL
+	u8	event;
+	#define CREQ_ALLOCATE_MRW_RESP_EVENT_ALLOCATE_MRW 0xdUL
+	#define CREQ_ALLOCATE_MRW_RESP_EVENT_LAST        CREQ_ALLOCATE_MRW_RESP_EVENT_ALLOCATE_MRW
+	u8	context_size;
+	u8	reserved48[5];
+};
+
+/* cmdq_deallocate_key (size:192b/24B) */
+struct cmdq_deallocate_key {
+	u8	opcode;
+	#define CMDQ_DEALLOCATE_KEY_OPCODE_DEALLOCATE_KEY 0xeUL
+	#define CMDQ_DEALLOCATE_KEY_OPCODE_LAST          CMDQ_DEALLOCATE_KEY_OPCODE_DEALLOCATE_KEY
+	u8	cmd_size;
+	__le16	flags;
+	__le16	cookie;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	resp_addr;
+	u8	mrw_flags;
+	#define CMDQ_DEALLOCATE_KEY_MRW_FLAGS_MASK     0xfUL
+	#define CMDQ_DEALLOCATE_KEY_MRW_FLAGS_SFT      0
+	#define CMDQ_DEALLOCATE_KEY_MRW_FLAGS_MR         0x0UL
+	#define CMDQ_DEALLOCATE_KEY_MRW_FLAGS_PMR        0x1UL
+	#define CMDQ_DEALLOCATE_KEY_MRW_FLAGS_MW_TYPE1   0x2UL
+	#define CMDQ_DEALLOCATE_KEY_MRW_FLAGS_MW_TYPE2A  0x3UL
+	#define CMDQ_DEALLOCATE_KEY_MRW_FLAGS_MW_TYPE2B  0x4UL
+	#define CMDQ_DEALLOCATE_KEY_MRW_FLAGS_LAST      CMDQ_DEALLOCATE_KEY_MRW_FLAGS_MW_TYPE2B
+	#define CMDQ_DEALLOCATE_KEY_UNUSED4_MASK       0xf0UL
+	#define CMDQ_DEALLOCATE_KEY_UNUSED4_SFT        4
+	u8	unused24[3];
+	__le32	key;
+};
+
+/* creq_deallocate_key_resp (size:128b/16B) */
+struct creq_deallocate_key_resp {
+	u8	type;
+	#define CREQ_DEALLOCATE_KEY_RESP_TYPE_MASK    0x3fUL
+	#define CREQ_DEALLOCATE_KEY_RESP_TYPE_SFT     0
+	#define CREQ_DEALLOCATE_KEY_RESP_TYPE_QP_EVENT  0x38UL
+	#define CREQ_DEALLOCATE_KEY_RESP_TYPE_LAST     CREQ_DEALLOCATE_KEY_RESP_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	xid;
+	u8	v;
+	#define CREQ_DEALLOCATE_KEY_RESP_V     0x1UL
+	u8	event;
+	#define CREQ_DEALLOCATE_KEY_RESP_EVENT_DEALLOCATE_KEY 0xeUL
+	#define CREQ_DEALLOCATE_KEY_RESP_EVENT_LAST          CREQ_DEALLOCATE_KEY_RESP_EVENT_DEALLOCATE_KEY
+	__le16	reserved16;
+	__le32	bound_window_info;
+};
+
+/* cmdq_register_mr (size:512b/64B) */
+struct cmdq_register_mr {
+	u8	opcode;
+	#define CMDQ_REGISTER_MR_OPCODE_REGISTER_MR 0xfUL
+	#define CMDQ_REGISTER_MR_OPCODE_LAST       CMDQ_REGISTER_MR_OPCODE_REGISTER_MR
+	u8	cmd_size;
+	__le16	flags;
+	#define CMDQ_REGISTER_MR_FLAGS_ALLOC_MR               0x1UL
+	#define CMDQ_REGISTER_MR_FLAGS_STEERING_TAG_VALID     0x2UL
+	#define CMDQ_REGISTER_MR_FLAGS_ENABLE_RO              0x4UL
+	#define CMDQ_REGISTER_MR_FLAGS_ENABLE_EROCE           0x8UL
+	__le16	cookie;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	resp_addr;
+	u8	log2_pg_size_lvl;
+	#define CMDQ_REGISTER_MR_LVL_MASK            0x3UL
+	#define CMDQ_REGISTER_MR_LVL_SFT             0
+	#define CMDQ_REGISTER_MR_LVL_LVL_0             0x0UL
+	#define CMDQ_REGISTER_MR_LVL_LVL_1             0x1UL
+	#define CMDQ_REGISTER_MR_LVL_LVL_2             0x2UL
+	#define CMDQ_REGISTER_MR_LVL_LAST             CMDQ_REGISTER_MR_LVL_LVL_2
+	#define CMDQ_REGISTER_MR_LOG2_PG_SIZE_MASK   0x7cUL
+	#define CMDQ_REGISTER_MR_LOG2_PG_SIZE_SFT    2
+	#define CMDQ_REGISTER_MR_LOG2_PG_SIZE_PG_4K    (0xcUL << 2)
+	#define CMDQ_REGISTER_MR_LOG2_PG_SIZE_PG_8K    (0xdUL << 2)
+	#define CMDQ_REGISTER_MR_LOG2_PG_SIZE_PG_64K   (0x10UL << 2)
+	#define CMDQ_REGISTER_MR_LOG2_PG_SIZE_PG_256K  (0x12UL << 2)
+	#define CMDQ_REGISTER_MR_LOG2_PG_SIZE_PG_1M    (0x14UL << 2)
+	#define CMDQ_REGISTER_MR_LOG2_PG_SIZE_PG_2M    (0x15UL << 2)
+	#define CMDQ_REGISTER_MR_LOG2_PG_SIZE_PG_4M    (0x16UL << 2)
+	#define CMDQ_REGISTER_MR_LOG2_PG_SIZE_PG_1G    (0x1eUL << 2)
+	#define CMDQ_REGISTER_MR_LOG2_PG_SIZE_LAST    CMDQ_REGISTER_MR_LOG2_PG_SIZE_PG_1G
+	#define CMDQ_REGISTER_MR_UNUSED1             0x80UL
+	u8	access;
+	#define CMDQ_REGISTER_MR_ACCESS_LOCAL_WRITE       0x1UL
+	#define CMDQ_REGISTER_MR_ACCESS_REMOTE_READ       0x2UL
+	#define CMDQ_REGISTER_MR_ACCESS_REMOTE_WRITE      0x4UL
+	#define CMDQ_REGISTER_MR_ACCESS_REMOTE_ATOMIC     0x8UL
+	#define CMDQ_REGISTER_MR_ACCESS_MW_BIND           0x10UL
+	#define CMDQ_REGISTER_MR_ACCESS_ZERO_BASED        0x20UL
+	__le16	log2_pbl_pg_size;
+	#define CMDQ_REGISTER_MR_LOG2_PBL_PG_SIZE_MASK   0x1fUL
+	#define CMDQ_REGISTER_MR_LOG2_PBL_PG_SIZE_SFT    0
+	#define CMDQ_REGISTER_MR_LOG2_PBL_PG_SIZE_PG_4K    0xcUL
+	#define CMDQ_REGISTER_MR_LOG2_PBL_PG_SIZE_PG_8K    0xdUL
+	#define CMDQ_REGISTER_MR_LOG2_PBL_PG_SIZE_PG_64K   0x10UL
+	#define CMDQ_REGISTER_MR_LOG2_PBL_PG_SIZE_PG_256K  0x12UL
+	#define CMDQ_REGISTER_MR_LOG2_PBL_PG_SIZE_PG_1M    0x14UL
+	#define CMDQ_REGISTER_MR_LOG2_PBL_PG_SIZE_PG_2M    0x15UL
+	#define CMDQ_REGISTER_MR_LOG2_PBL_PG_SIZE_PG_4M    0x16UL
+	#define CMDQ_REGISTER_MR_LOG2_PBL_PG_SIZE_PG_1G    0x1eUL
+	#define CMDQ_REGISTER_MR_LOG2_PBL_PG_SIZE_LAST    CMDQ_REGISTER_MR_LOG2_PBL_PG_SIZE_PG_1G
+	#define CMDQ_REGISTER_MR_UNUSED11_MASK           0xffe0UL
+	#define CMDQ_REGISTER_MR_UNUSED11_SFT            5
+	__le32	key;
+	__le64	pbl;
+	__le64	va;
+	__le64	mr_size;
+	__le16	steering_tag;
+	u8	reserved48[6];
+	__le64	reserved64;
+};
+
+/* creq_register_mr_resp (size:128b/16B) */
+struct creq_register_mr_resp {
+	u8	type;
+	#define CREQ_REGISTER_MR_RESP_TYPE_MASK    0x3fUL
+	#define CREQ_REGISTER_MR_RESP_TYPE_SFT     0
+	#define CREQ_REGISTER_MR_RESP_TYPE_QP_EVENT  0x38UL
+	#define CREQ_REGISTER_MR_RESP_TYPE_LAST     CREQ_REGISTER_MR_RESP_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	xid;
+	u8	v;
+	#define CREQ_REGISTER_MR_RESP_V     0x1UL
+	u8	event;
+	#define CREQ_REGISTER_MR_RESP_EVENT_REGISTER_MR 0xfUL
+	#define CREQ_REGISTER_MR_RESP_EVENT_LAST       CREQ_REGISTER_MR_RESP_EVENT_REGISTER_MR
+	u8	context_size;
+	u8	reserved48[5];
+};
+
+/* cmdq_deregister_mr (size:192b/24B) */
+struct cmdq_deregister_mr {
+	u8	opcode;
+	#define CMDQ_DEREGISTER_MR_OPCODE_DEREGISTER_MR 0x10UL
+	#define CMDQ_DEREGISTER_MR_OPCODE_LAST         CMDQ_DEREGISTER_MR_OPCODE_DEREGISTER_MR
+	u8	cmd_size;
+	__le16	flags;
+	#define CMDQ_DEREGISTER_MR_FLAGS_ENABLE_EROCE     0x1UL
+	__le16	cookie;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	resp_addr;
+	__le32	lkey;
+	__le32	unused_0;
+};
+
+/* creq_deregister_mr_resp (size:128b/16B) */
+struct creq_deregister_mr_resp {
+	u8	type;
+	#define CREQ_DEREGISTER_MR_RESP_TYPE_MASK    0x3fUL
+	#define CREQ_DEREGISTER_MR_RESP_TYPE_SFT     0
+	#define CREQ_DEREGISTER_MR_RESP_TYPE_QP_EVENT  0x38UL
+	#define CREQ_DEREGISTER_MR_RESP_TYPE_LAST     CREQ_DEREGISTER_MR_RESP_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	xid;
+	u8	v;
+	#define CREQ_DEREGISTER_MR_RESP_V     0x1UL
+	u8	event;
+	#define CREQ_DEREGISTER_MR_RESP_EVENT_DEREGISTER_MR 0x10UL
+	#define CREQ_DEREGISTER_MR_RESP_EVENT_LAST         CREQ_DEREGISTER_MR_RESP_EVENT_DEREGISTER_MR
+	__le16	reserved16;
+	__le32	bound_windows;
+};
+
+/* cmdq_add_gid (size:384b/48B) */
+struct cmdq_add_gid {
+	u8	opcode;
+	#define CMDQ_ADD_GID_OPCODE_ADD_GID 0x11UL
+	#define CMDQ_ADD_GID_OPCODE_LAST   CMDQ_ADD_GID_OPCODE_ADD_GID
+	u8	cmd_size;
+	__le16	flags;
+	__le16	cookie;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	resp_addr;
+	__le32	gid[4];
+	__le16	src_mac[3];
+	__le16	vlan;
+	#define CMDQ_ADD_GID_VLAN_VLAN_EN_TPID_VLAN_ID_MASK          0xffffUL
+	#define CMDQ_ADD_GID_VLAN_VLAN_EN_TPID_VLAN_ID_SFT           0
+	#define CMDQ_ADD_GID_VLAN_VLAN_ID_MASK                       0xfffUL
+	#define CMDQ_ADD_GID_VLAN_VLAN_ID_SFT                        0
+	#define CMDQ_ADD_GID_VLAN_TPID_MASK                          0x7000UL
+	#define CMDQ_ADD_GID_VLAN_TPID_SFT                           12
+	#define CMDQ_ADD_GID_VLAN_TPID_TPID_88A8                       (0x0UL << 12)
+	#define CMDQ_ADD_GID_VLAN_TPID_TPID_8100                       (0x1UL << 12)
+	#define CMDQ_ADD_GID_VLAN_TPID_TPID_9100                       (0x2UL << 12)
+	#define CMDQ_ADD_GID_VLAN_TPID_TPID_9200                       (0x3UL << 12)
+	#define CMDQ_ADD_GID_VLAN_TPID_TPID_9300                       (0x4UL << 12)
+	#define CMDQ_ADD_GID_VLAN_TPID_TPID_CFG1                       (0x5UL << 12)
+	#define CMDQ_ADD_GID_VLAN_TPID_TPID_CFG2                       (0x6UL << 12)
+	#define CMDQ_ADD_GID_VLAN_TPID_TPID_CFG3                       (0x7UL << 12)
+	#define CMDQ_ADD_GID_VLAN_TPID_LAST                           CMDQ_ADD_GID_VLAN_TPID_TPID_CFG3
+	#define CMDQ_ADD_GID_VLAN_VLAN_EN                            0x8000UL
+	__le16	ipid;
+	__le16	stats_ctx;
+	#define CMDQ_ADD_GID_STATS_CTX_STATS_CTX_VALID_STATS_CTX_ID_MASK                0xffffUL
+	#define CMDQ_ADD_GID_STATS_CTX_STATS_CTX_VALID_STATS_CTX_ID_SFT                 0
+	#define CMDQ_ADD_GID_STATS_CTX_STATS_CTX_ID_MASK                                0x7fffUL
+	#define CMDQ_ADD_GID_STATS_CTX_STATS_CTX_ID_SFT                                 0
+	#define CMDQ_ADD_GID_STATS_CTX_STATS_CTX_VALID                                  0x8000UL
+	__le16	host_gid_index;
+	__le16	unused_0;
+};
+
+/* creq_add_gid_resp (size:128b/16B) */
+struct creq_add_gid_resp {
+	u8	type;
+	#define CREQ_ADD_GID_RESP_TYPE_MASK    0x3fUL
+	#define CREQ_ADD_GID_RESP_TYPE_SFT     0
+	#define CREQ_ADD_GID_RESP_TYPE_QP_EVENT  0x38UL
+	#define CREQ_ADD_GID_RESP_TYPE_LAST     CREQ_ADD_GID_RESP_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	xid;
+	u8	v;
+	#define CREQ_ADD_GID_RESP_V     0x1UL
+	u8	event;
+	#define CREQ_ADD_GID_RESP_EVENT_ADD_GID 0x11UL
+	#define CREQ_ADD_GID_RESP_EVENT_LAST   CREQ_ADD_GID_RESP_EVENT_ADD_GID
+	u8	reserved48[6];
+};
+
+/* cmdq_delete_gid (size:192b/24B) */
+struct cmdq_delete_gid {
+	u8	opcode;
+	#define CMDQ_DELETE_GID_OPCODE_DELETE_GID 0x12UL
+	#define CMDQ_DELETE_GID_OPCODE_LAST      CMDQ_DELETE_GID_OPCODE_DELETE_GID
+	u8	cmd_size;
+	__le16	flags;
+	__le16	cookie;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	resp_addr;
+	__le16	gid_index;
+	__le16	host_gid_index;
+	u8	unused_0[4];
+};
+
+/* creq_delete_gid_resp (size:128b/16B) */
+struct creq_delete_gid_resp {
+	u8	type;
+	#define CREQ_DELETE_GID_RESP_TYPE_MASK    0x3fUL
+	#define CREQ_DELETE_GID_RESP_TYPE_SFT     0
+	#define CREQ_DELETE_GID_RESP_TYPE_QP_EVENT  0x38UL
+	#define CREQ_DELETE_GID_RESP_TYPE_LAST     CREQ_DELETE_GID_RESP_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	xid;
+	u8	v;
+	#define CREQ_DELETE_GID_RESP_V     0x1UL
+	u8	event;
+	#define CREQ_DELETE_GID_RESP_EVENT_DELETE_GID 0x12UL
+	#define CREQ_DELETE_GID_RESP_EVENT_LAST      CREQ_DELETE_GID_RESP_EVENT_DELETE_GID
+	u8	reserved48[6];
+};
+
+/* cmdq_modify_gid (size:384b/48B) */
+struct cmdq_modify_gid {
+	u8	opcode;
+	#define CMDQ_MODIFY_GID_OPCODE_MODIFY_GID 0x17UL
+	#define CMDQ_MODIFY_GID_OPCODE_LAST      CMDQ_MODIFY_GID_OPCODE_MODIFY_GID
+	u8	cmd_size;
+	__le16	flags;
+	__le16	cookie;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	resp_addr;
+	__le32	gid[4];
+	__le16	src_mac[3];
+	__le16	vlan;
+	#define CMDQ_MODIFY_GID_VLAN_VLAN_ID_MASK  0xfffUL
+	#define CMDQ_MODIFY_GID_VLAN_VLAN_ID_SFT   0
+	#define CMDQ_MODIFY_GID_VLAN_TPID_MASK     0x7000UL
+	#define CMDQ_MODIFY_GID_VLAN_TPID_SFT      12
+	#define CMDQ_MODIFY_GID_VLAN_TPID_TPID_88A8  (0x0UL << 12)
+	#define CMDQ_MODIFY_GID_VLAN_TPID_TPID_8100  (0x1UL << 12)
+	#define CMDQ_MODIFY_GID_VLAN_TPID_TPID_9100  (0x2UL << 12)
+	#define CMDQ_MODIFY_GID_VLAN_TPID_TPID_9200  (0x3UL << 12)
+	#define CMDQ_MODIFY_GID_VLAN_TPID_TPID_9300  (0x4UL << 12)
+	#define CMDQ_MODIFY_GID_VLAN_TPID_TPID_CFG1  (0x5UL << 12)
+	#define CMDQ_MODIFY_GID_VLAN_TPID_TPID_CFG2  (0x6UL << 12)
+	#define CMDQ_MODIFY_GID_VLAN_TPID_TPID_CFG3  (0x7UL << 12)
+	#define CMDQ_MODIFY_GID_VLAN_TPID_LAST      CMDQ_MODIFY_GID_VLAN_TPID_TPID_CFG3
+	#define CMDQ_MODIFY_GID_VLAN_VLAN_EN       0x8000UL
+	__le16	ipid;
+	__le16	gid_index;
+	__le16	stats_ctx;
+	#define CMDQ_MODIFY_GID_STATS_CTX_STATS_CTX_ID_MASK   0x7fffUL
+	#define CMDQ_MODIFY_GID_STATS_CTX_STATS_CTX_ID_SFT    0
+	#define CMDQ_MODIFY_GID_STATS_CTX_STATS_CTX_VALID     0x8000UL
+	__le16	host_gid_index;
+};
+
+/* creq_modify_gid_resp (size:128b/16B) */
+struct creq_modify_gid_resp {
+	u8	type;
+	#define CREQ_MODIFY_GID_RESP_TYPE_MASK    0x3fUL
+	#define CREQ_MODIFY_GID_RESP_TYPE_SFT     0
+	#define CREQ_MODIFY_GID_RESP_TYPE_QP_EVENT  0x38UL
+	#define CREQ_MODIFY_GID_RESP_TYPE_LAST     CREQ_MODIFY_GID_RESP_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	xid;
+	u8	v;
+	#define CREQ_MODIFY_GID_RESP_V     0x1UL
+	u8	event;
+	#define CREQ_MODIFY_GID_RESP_EVENT_ADD_GID 0x11UL
+	#define CREQ_MODIFY_GID_RESP_EVENT_LAST   CREQ_MODIFY_GID_RESP_EVENT_ADD_GID
+	u8	reserved48[6];
+};
+
+/* cmdq_query_gid (size:192b/24B) */
+struct cmdq_query_gid {
+	u8	opcode;
+	#define CMDQ_QUERY_GID_OPCODE_QUERY_GID 0x18UL
+	#define CMDQ_QUERY_GID_OPCODE_LAST     CMDQ_QUERY_GID_OPCODE_QUERY_GID
+	u8	cmd_size;
+	__le16	flags;
+	__le16	cookie;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	resp_addr;
+	__le16	gid_index;
+	u8	unused16[6];
+};
+
+/* creq_query_gid_resp (size:128b/16B) */
+struct creq_query_gid_resp {
+	u8	type;
+	#define CREQ_QUERY_GID_RESP_TYPE_MASK    0x3fUL
+	#define CREQ_QUERY_GID_RESP_TYPE_SFT     0
+	#define CREQ_QUERY_GID_RESP_TYPE_QP_EVENT  0x38UL
+	#define CREQ_QUERY_GID_RESP_TYPE_LAST     CREQ_QUERY_GID_RESP_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	size;
+	u8	v;
+	#define CREQ_QUERY_GID_RESP_V     0x1UL
+	u8	event;
+	#define CREQ_QUERY_GID_RESP_EVENT_QUERY_GID 0x18UL
+	#define CREQ_QUERY_GID_RESP_EVENT_LAST     CREQ_QUERY_GID_RESP_EVENT_QUERY_GID
+	u8	reserved48[6];
+};
+
+/* creq_query_gid_resp_sb (size:320b/40B) */
+struct creq_query_gid_resp_sb {
+	u8	opcode;
+	#define CREQ_QUERY_GID_RESP_SB_OPCODE_QUERY_GID 0x18UL
+	#define CREQ_QUERY_GID_RESP_SB_OPCODE_LAST     CREQ_QUERY_GID_RESP_SB_OPCODE_QUERY_GID
+	u8	status;
+	__le16	cookie;
+	__le16	flags;
+	u8	resp_size;
+	u8	reserved8;
+	__le32	gid[4];
+	__le16	src_mac[3];
+	__le16	vlan;
+	#define CREQ_QUERY_GID_RESP_SB_VLAN_VLAN_EN_TPID_VLAN_ID_MASK          0xffffUL
+	#define CREQ_QUERY_GID_RESP_SB_VLAN_VLAN_EN_TPID_VLAN_ID_SFT           0
+	#define CREQ_QUERY_GID_RESP_SB_VLAN_VLAN_ID_MASK                       0xfffUL
+	#define CREQ_QUERY_GID_RESP_SB_VLAN_VLAN_ID_SFT                        0
+	#define CREQ_QUERY_GID_RESP_SB_VLAN_TPID_MASK                          0x7000UL
+	#define CREQ_QUERY_GID_RESP_SB_VLAN_TPID_SFT                           12
+	#define CREQ_QUERY_GID_RESP_SB_VLAN_TPID_TPID_88A8                       (0x0UL << 12)
+	#define CREQ_QUERY_GID_RESP_SB_VLAN_TPID_TPID_8100                       (0x1UL << 12)
+	#define CREQ_QUERY_GID_RESP_SB_VLAN_TPID_TPID_9100                       (0x2UL << 12)
+	#define CREQ_QUERY_GID_RESP_SB_VLAN_TPID_TPID_9200                       (0x3UL << 12)
+	#define CREQ_QUERY_GID_RESP_SB_VLAN_TPID_TPID_9300                       (0x4UL << 12)
+	#define CREQ_QUERY_GID_RESP_SB_VLAN_TPID_TPID_CFG1                       (0x5UL << 12)
+	#define CREQ_QUERY_GID_RESP_SB_VLAN_TPID_TPID_CFG2                       (0x6UL << 12)
+	#define CREQ_QUERY_GID_RESP_SB_VLAN_TPID_TPID_CFG3                       (0x7UL << 12)
+	#define CREQ_QUERY_GID_RESP_SB_VLAN_TPID_LAST                           CREQ_QUERY_GID_RESP_SB_VLAN_TPID_TPID_CFG3
+	#define CREQ_QUERY_GID_RESP_SB_VLAN_VLAN_EN                            0x8000UL
+	__le16	ipid;
+	__le16	gid_index;
+	__le32	unused_0;
+};
+
+/* cmdq_create_qp1 (size:640b/80B) */
+struct cmdq_create_qp1 {
+	u8	opcode;
+	#define CMDQ_CREATE_QP1_OPCODE_CREATE_QP1 0x13UL
+	#define CMDQ_CREATE_QP1_OPCODE_LAST      CMDQ_CREATE_QP1_OPCODE_CREATE_QP1
+	u8	cmd_size;
+	__le16	flags;
+	__le16	cookie;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	resp_addr;
+	__le64	qp_handle;
+	__le32	qp_flags;
+	#define CMDQ_CREATE_QP1_QP_FLAGS_SRQ_USED             0x1UL
+	#define CMDQ_CREATE_QP1_QP_FLAGS_FORCE_COMPLETION     0x2UL
+	#define CMDQ_CREATE_QP1_QP_FLAGS_RESERVED_LKEY_ENABLE 0x4UL
+	#define CMDQ_CREATE_QP1_QP_FLAGS_LAST                CMDQ_CREATE_QP1_QP_FLAGS_RESERVED_LKEY_ENABLE
+	u8	type;
+	#define CMDQ_CREATE_QP1_TYPE_GSI 0x1UL
+	#define CMDQ_CREATE_QP1_TYPE_LAST CMDQ_CREATE_QP1_TYPE_GSI
+	u8	sq_pg_size_sq_lvl;
+	#define CMDQ_CREATE_QP1_SQ_LVL_MASK      0xfUL
+	#define CMDQ_CREATE_QP1_SQ_LVL_SFT       0
+	#define CMDQ_CREATE_QP1_SQ_LVL_LVL_0       0x0UL
+	#define CMDQ_CREATE_QP1_SQ_LVL_LVL_1       0x1UL
+	#define CMDQ_CREATE_QP1_SQ_LVL_LVL_2       0x2UL
+	#define CMDQ_CREATE_QP1_SQ_LVL_LAST       CMDQ_CREATE_QP1_SQ_LVL_LVL_2
+	#define CMDQ_CREATE_QP1_SQ_PG_SIZE_MASK  0xf0UL
+	#define CMDQ_CREATE_QP1_SQ_PG_SIZE_SFT   4
+	#define CMDQ_CREATE_QP1_SQ_PG_SIZE_PG_4K   (0x0UL << 4)
+	#define CMDQ_CREATE_QP1_SQ_PG_SIZE_PG_8K   (0x1UL << 4)
+	#define CMDQ_CREATE_QP1_SQ_PG_SIZE_PG_64K  (0x2UL << 4)
+	#define CMDQ_CREATE_QP1_SQ_PG_SIZE_PG_2M   (0x3UL << 4)
+	#define CMDQ_CREATE_QP1_SQ_PG_SIZE_PG_8M   (0x4UL << 4)
+	#define CMDQ_CREATE_QP1_SQ_PG_SIZE_PG_1G   (0x5UL << 4)
+	#define CMDQ_CREATE_QP1_SQ_PG_SIZE_LAST   CMDQ_CREATE_QP1_SQ_PG_SIZE_PG_1G
+	u8	rq_pg_size_rq_lvl;
+	#define CMDQ_CREATE_QP1_RQ_LVL_MASK      0xfUL
+	#define CMDQ_CREATE_QP1_RQ_LVL_SFT       0
+	#define CMDQ_CREATE_QP1_RQ_LVL_LVL_0       0x0UL
+	#define CMDQ_CREATE_QP1_RQ_LVL_LVL_1       0x1UL
+	#define CMDQ_CREATE_QP1_RQ_LVL_LVL_2       0x2UL
+	#define CMDQ_CREATE_QP1_RQ_LVL_LAST       CMDQ_CREATE_QP1_RQ_LVL_LVL_2
+	#define CMDQ_CREATE_QP1_RQ_PG_SIZE_MASK  0xf0UL
+	#define CMDQ_CREATE_QP1_RQ_PG_SIZE_SFT   4
+	#define CMDQ_CREATE_QP1_RQ_PG_SIZE_PG_4K   (0x0UL << 4)
+	#define CMDQ_CREATE_QP1_RQ_PG_SIZE_PG_8K   (0x1UL << 4)
+	#define CMDQ_CREATE_QP1_RQ_PG_SIZE_PG_64K  (0x2UL << 4)
+	#define CMDQ_CREATE_QP1_RQ_PG_SIZE_PG_2M   (0x3UL << 4)
+	#define CMDQ_CREATE_QP1_RQ_PG_SIZE_PG_8M   (0x4UL << 4)
+	#define CMDQ_CREATE_QP1_RQ_PG_SIZE_PG_1G   (0x5UL << 4)
+	#define CMDQ_CREATE_QP1_RQ_PG_SIZE_LAST   CMDQ_CREATE_QP1_RQ_PG_SIZE_PG_1G
+	u8	unused_0;
+	__le32	dpi;
+	__le32	sq_size;
+	__le32	rq_size;
+	__le16	sq_fwo_sq_sge;
+	#define CMDQ_CREATE_QP1_SQ_SGE_MASK 0xfUL
+	#define CMDQ_CREATE_QP1_SQ_SGE_SFT 0
+	#define CMDQ_CREATE_QP1_SQ_FWO_MASK 0xfff0UL
+	#define CMDQ_CREATE_QP1_SQ_FWO_SFT 4
+	__le16	rq_fwo_rq_sge;
+	#define CMDQ_CREATE_QP1_RQ_SGE_MASK 0xfUL
+	#define CMDQ_CREATE_QP1_RQ_SGE_SFT 0
+	#define CMDQ_CREATE_QP1_RQ_FWO_MASK 0xfff0UL
+	#define CMDQ_CREATE_QP1_RQ_FWO_SFT 4
+	__le32	scq_cid;
+	__le32	rcq_cid;
+	__le32	srq_cid;
+	__le32	pd_id;
+	__le64	sq_pbl;
+	__le64	rq_pbl;
+};
+
+/* creq_create_qp1_resp (size:128b/16B) */
+struct creq_create_qp1_resp {
+	u8	type;
+	#define CREQ_CREATE_QP1_RESP_TYPE_MASK    0x3fUL
+	#define CREQ_CREATE_QP1_RESP_TYPE_SFT     0
+	#define CREQ_CREATE_QP1_RESP_TYPE_QP_EVENT  0x38UL
+	#define CREQ_CREATE_QP1_RESP_TYPE_LAST     CREQ_CREATE_QP1_RESP_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	xid;
+	u8	v;
+	#define CREQ_CREATE_QP1_RESP_V     0x1UL
+	u8	event;
+	#define CREQ_CREATE_QP1_RESP_EVENT_CREATE_QP1 0x13UL
+	#define CREQ_CREATE_QP1_RESP_EVENT_LAST      CREQ_CREATE_QP1_RESP_EVENT_CREATE_QP1
+	u8	reserved48[6];
+};
+
+/* cmdq_destroy_qp1 (size:192b/24B) */
+struct cmdq_destroy_qp1 {
+	u8	opcode;
+	#define CMDQ_DESTROY_QP1_OPCODE_DESTROY_QP1 0x14UL
+	#define CMDQ_DESTROY_QP1_OPCODE_LAST       CMDQ_DESTROY_QP1_OPCODE_DESTROY_QP1
+	u8	cmd_size;
+	__le16	flags;
+	__le16	cookie;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	resp_addr;
+	__le32	qp1_cid;
+	__le32	unused_0;
+};
+
+/* creq_destroy_qp1_resp (size:128b/16B) */
+struct creq_destroy_qp1_resp {
+	u8	type;
+	#define CREQ_DESTROY_QP1_RESP_TYPE_MASK    0x3fUL
+	#define CREQ_DESTROY_QP1_RESP_TYPE_SFT     0
+	#define CREQ_DESTROY_QP1_RESP_TYPE_QP_EVENT  0x38UL
+	#define CREQ_DESTROY_QP1_RESP_TYPE_LAST     CREQ_DESTROY_QP1_RESP_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	xid;
+	u8	v;
+	#define CREQ_DESTROY_QP1_RESP_V     0x1UL
+	u8	event;
+	#define CREQ_DESTROY_QP1_RESP_EVENT_DESTROY_QP1 0x14UL
+	#define CREQ_DESTROY_QP1_RESP_EVENT_LAST       CREQ_DESTROY_QP1_RESP_EVENT_DESTROY_QP1
+	u8	reserved48[6];
+};
+
+/* cmdq_create_ah (size:512b/64B) */
+struct cmdq_create_ah {
+	u8	opcode;
+	#define CMDQ_CREATE_AH_OPCODE_CREATE_AH 0x15UL
+	#define CMDQ_CREATE_AH_OPCODE_LAST     CMDQ_CREATE_AH_OPCODE_CREATE_AH
+	u8	cmd_size;
+	__le16	flags;
+	__le16	cookie;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	resp_addr;
+	__le64	ah_handle;
+	__le32	dgid[4];
+	u8	type;
+	#define CMDQ_CREATE_AH_TYPE_V1     0x0UL
+	#define CMDQ_CREATE_AH_TYPE_V2IPV4 0x2UL
+	#define CMDQ_CREATE_AH_TYPE_V2IPV6 0x3UL
+	#define CMDQ_CREATE_AH_TYPE_LAST  CMDQ_CREATE_AH_TYPE_V2IPV6
+	u8	hop_limit;
+	__le16	sgid_index;
+	__le32	dest_vlan_id_flow_label;
+	#define CMDQ_CREATE_AH_FLOW_LABEL_MASK  0xfffffUL
+	#define CMDQ_CREATE_AH_FLOW_LABEL_SFT   0
+	#define CMDQ_CREATE_AH_DEST_VLAN_ID_MASK 0xfff00000UL
+	#define CMDQ_CREATE_AH_DEST_VLAN_ID_SFT 20
+	__le32	pd_id;
+	__le32	unused_0;
+	__le16	dest_mac[3];
+	u8	traffic_class;
+	u8	enable_cc;
+	#define CMDQ_CREATE_AH_ENABLE_CC     0x1UL
+};
+
+/* creq_create_ah_resp (size:128b/16B) */
+struct creq_create_ah_resp {
+	u8	type;
+	#define CREQ_CREATE_AH_RESP_TYPE_MASK    0x3fUL
+	#define CREQ_CREATE_AH_RESP_TYPE_SFT     0
+	#define CREQ_CREATE_AH_RESP_TYPE_QP_EVENT  0x38UL
+	#define CREQ_CREATE_AH_RESP_TYPE_LAST     CREQ_CREATE_AH_RESP_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	xid;
+	u8	v;
+	#define CREQ_CREATE_AH_RESP_V     0x1UL
+	u8	event;
+	#define CREQ_CREATE_AH_RESP_EVENT_CREATE_AH 0x15UL
+	#define CREQ_CREATE_AH_RESP_EVENT_LAST     CREQ_CREATE_AH_RESP_EVENT_CREATE_AH
+	u8	reserved48[6];
+};
+
+/* cmdq_destroy_ah (size:192b/24B) */
+struct cmdq_destroy_ah {
+	u8	opcode;
+	#define CMDQ_DESTROY_AH_OPCODE_DESTROY_AH 0x16UL
+	#define CMDQ_DESTROY_AH_OPCODE_LAST      CMDQ_DESTROY_AH_OPCODE_DESTROY_AH
+	u8	cmd_size;
+	__le16	flags;
+	__le16	cookie;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	resp_addr;
+	__le32	ah_cid;
+	__le32	unused_0;
+};
+
+/* creq_destroy_ah_resp (size:128b/16B) */
+struct creq_destroy_ah_resp {
+	u8	type;
+	#define CREQ_DESTROY_AH_RESP_TYPE_MASK    0x3fUL
+	#define CREQ_DESTROY_AH_RESP_TYPE_SFT     0
+	#define CREQ_DESTROY_AH_RESP_TYPE_QP_EVENT  0x38UL
+	#define CREQ_DESTROY_AH_RESP_TYPE_LAST     CREQ_DESTROY_AH_RESP_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	xid;
+	u8	v;
+	#define CREQ_DESTROY_AH_RESP_V     0x1UL
+	u8	event;
+	#define CREQ_DESTROY_AH_RESP_EVENT_DESTROY_AH 0x16UL
+	#define CREQ_DESTROY_AH_RESP_EVENT_LAST      CREQ_DESTROY_AH_RESP_EVENT_DESTROY_AH
+	u8	reserved48[6];
+};
+
+/* cmdq_query_roce_stats (size:192b/24B) */
+struct cmdq_query_roce_stats {
+	u8	opcode;
+	#define CMDQ_QUERY_ROCE_STATS_OPCODE_QUERY_ROCE_STATS 0x8eUL
+	#define CMDQ_QUERY_ROCE_STATS_OPCODE_LAST            CMDQ_QUERY_ROCE_STATS_OPCODE_QUERY_ROCE_STATS
+	u8	cmd_size;
+	__le16	flags;
+	#define CMDQ_QUERY_ROCE_STATS_FLAGS_COLLECTION_ID     0x1UL
+	#define CMDQ_QUERY_ROCE_STATS_FLAGS_FUNCTION_ID       0x2UL
+	__le16	cookie;
+	u8	resp_size;
+	u8	collection_id;
+	__le64	resp_addr;
+	__le32	function_id;
+	#define CMDQ_QUERY_ROCE_STATS_PF_NUM_MASK  0xffUL
+	#define CMDQ_QUERY_ROCE_STATS_PF_NUM_SFT   0
+	#define CMDQ_QUERY_ROCE_STATS_VF_NUM_MASK  0xffff00UL
+	#define CMDQ_QUERY_ROCE_STATS_VF_NUM_SFT   8
+	#define CMDQ_QUERY_ROCE_STATS_VF_VALID     0x1000000UL
+	__le32	reserved32;
+};
+
+/* creq_query_roce_stats_resp (size:128b/16B) */
+struct creq_query_roce_stats_resp {
+	u8	type;
+	#define CREQ_QUERY_ROCE_STATS_RESP_TYPE_MASK    0x3fUL
+	#define CREQ_QUERY_ROCE_STATS_RESP_TYPE_SFT     0
+	#define CREQ_QUERY_ROCE_STATS_RESP_TYPE_QP_EVENT  0x38UL
+	#define CREQ_QUERY_ROCE_STATS_RESP_TYPE_LAST     CREQ_QUERY_ROCE_STATS_RESP_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	size;
+	u8	v;
+	#define CREQ_QUERY_ROCE_STATS_RESP_V     0x1UL
+	u8	event;
+	#define CREQ_QUERY_ROCE_STATS_RESP_EVENT_QUERY_ROCE_STATS 0x8eUL
+	#define CREQ_QUERY_ROCE_STATS_RESP_EVENT_LAST            CREQ_QUERY_ROCE_STATS_RESP_EVENT_QUERY_ROCE_STATS
+	u8	reserved48[6];
+};
+
+/* creq_query_roce_stats_resp_sb (size:3072b/384B) */
+struct creq_query_roce_stats_resp_sb {
+	u8	opcode;
+	#define CREQ_QUERY_ROCE_STATS_RESP_SB_OPCODE_QUERY_ROCE_STATS 0x8eUL
+	#define CREQ_QUERY_ROCE_STATS_RESP_SB_OPCODE_LAST            CREQ_QUERY_ROCE_STATS_RESP_SB_OPCODE_QUERY_ROCE_STATS
+	u8	status;
+	__le16	cookie;
+	__le16	flags;
+	u8	resp_size;
+	u8	rsvd;
+	__le32	num_counters;
+	__le32	rsvd1;
+	__le64	to_retransmits;
+	__le64	seq_err_naks_rcvd;
+	__le64	max_retry_exceeded;
+	__le64	rnr_naks_rcvd;
+	__le64	missing_resp;
+	__le64	unrecoverable_err;
+	__le64	bad_resp_err;
+	__le64	local_qp_op_err;
+	__le64	local_protection_err;
+	__le64	mem_mgmt_op_err;
+	__le64	remote_invalid_req_err;
+	__le64	remote_access_err;
+	__le64	remote_op_err;
+	__le64	dup_req;
+	__le64	res_exceed_max;
+	__le64	res_length_mismatch;
+	__le64	res_exceeds_wqe;
+	__le64	res_opcode_err;
+	__le64	res_rx_invalid_rkey;
+	__le64	res_rx_domain_err;
+	__le64	res_rx_no_perm;
+	__le64	res_rx_range_err;
+	__le64	res_tx_invalid_rkey;
+	__le64	res_tx_domain_err;
+	__le64	res_tx_no_perm;
+	__le64	res_tx_range_err;
+	__le64	res_irrq_oflow;
+	__le64	res_unsup_opcode;
+	__le64	res_unaligned_atomic;
+	__le64	res_rem_inv_err;
+	__le64	res_mem_error;
+	__le64	res_srq_err;
+	__le64	res_cmp_err;
+	__le64	res_invalid_dup_rkey;
+	__le64	res_wqe_format_err;
+	__le64	res_cq_load_err;
+	__le64	res_srq_load_err;
+	__le64	res_tx_pci_err;
+	__le64	res_rx_pci_err;
+	__le64	res_oos_drop_count;
+	__le64	active_qp_count_p0;
+	__le64	active_qp_count_p1;
+	__le64	active_qp_count_p2;
+	__le64	active_qp_count_p3;
+	__le64	xp_sq_overflow_err;
+	__le64	xp_rq_overflow_error;
+};
+
+/* cmdq_query_roce_stats_ext (size:192b/24B) */
+struct cmdq_query_roce_stats_ext {
+	u8	opcode;
+	#define CMDQ_QUERY_ROCE_STATS_EXT_OPCODE_QUERY_ROCE_STATS 0x92UL
+	#define CMDQ_QUERY_ROCE_STATS_EXT_OPCODE_LAST            CMDQ_QUERY_ROCE_STATS_EXT_OPCODE_QUERY_ROCE_STATS
+	u8	cmd_size;
+	__le16	flags;
+	#define CMDQ_QUERY_ROCE_STATS_EXT_FLAGS_COLLECTION_ID     0x1UL
+	#define CMDQ_QUERY_ROCE_STATS_EXT_FLAGS_FUNCTION_ID       0x2UL
+	__le16	cookie;
+	u8	resp_size;
+	u8	collection_id;
+	__le64	resp_addr;
+	__le32	function_id;
+	#define CMDQ_QUERY_ROCE_STATS_EXT_PF_NUM_MASK  0xffUL
+	#define CMDQ_QUERY_ROCE_STATS_EXT_PF_NUM_SFT   0
+	#define CMDQ_QUERY_ROCE_STATS_EXT_VF_NUM_MASK  0xffff00UL
+	#define CMDQ_QUERY_ROCE_STATS_EXT_VF_NUM_SFT   8
+	#define CMDQ_QUERY_ROCE_STATS_EXT_VF_VALID     0x1000000UL
+	__le32	reserved32;
+};
+
+/* creq_query_roce_stats_ext_resp (size:128b/16B) */
+struct creq_query_roce_stats_ext_resp {
+	u8	type;
+	#define CREQ_QUERY_ROCE_STATS_EXT_RESP_TYPE_MASK    0x3fUL
+	#define CREQ_QUERY_ROCE_STATS_EXT_RESP_TYPE_SFT     0
+	#define CREQ_QUERY_ROCE_STATS_EXT_RESP_TYPE_QP_EVENT  0x38UL
+	#define CREQ_QUERY_ROCE_STATS_EXT_RESP_TYPE_LAST     CREQ_QUERY_ROCE_STATS_EXT_RESP_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	size;
+	u8	v;
+	#define CREQ_QUERY_ROCE_STATS_EXT_RESP_V     0x1UL
+	u8	event;
+	#define CREQ_QUERY_ROCE_STATS_EXT_RESP_EVENT_QUERY_ROCE_STATS_EXT 0x92UL
+	#define CREQ_QUERY_ROCE_STATS_EXT_RESP_EVENT_LAST                CREQ_QUERY_ROCE_STATS_EXT_RESP_EVENT_QUERY_ROCE_STATS_EXT
+	u8	reserved48[6];
+};
+
+/* creq_query_roce_stats_ext_resp_sb (size:2368b/296B) */
+struct creq_query_roce_stats_ext_resp_sb {
+	u8	opcode;
+	#define CREQ_QUERY_ROCE_STATS_EXT_RESP_SB_OPCODE_QUERY_ROCE_STATS_EXT 0x92UL
+	#define CREQ_QUERY_ROCE_STATS_EXT_RESP_SB_OPCODE_LAST                CREQ_QUERY_ROCE_STATS_EXT_RESP_SB_OPCODE_QUERY_ROCE_STATS_EXT
+	u8	status;
+	__le16	cookie;
+	__le16	flags;
+	u8	resp_size;
+	u8	rsvd;
+	__le64	rx_ack_pkts;
+	__le64	tx_atomic_req_pkts;
+	__le64	tx_read_req_pkts;
+	__le64	tx_read_res_pkts;
+	__le64	tx_write_req_pkts;
+	__le64	tx_send_req_pkts;
+	__le64	tx_roce_pkts;
+	__le64	tx_roce_bytes;
+	__le64	rx_atomic_req_pkts;
+	__le64	rx_read_req_pkts;
+	__le64	rx_read_res_pkts;
+	__le64	rx_write_req_pkts;
+	__le64	rx_send_req_pkts;
+	__le64	rx_roce_pkts;
+	__le64	rx_roce_bytes;
+	__le64	rx_roce_good_pkts;
+	__le64	rx_roce_good_bytes;
+	__le64	rx_out_of_buffer_pkts;
+	__le64	rx_out_of_sequence_pkts;
+	__le64	tx_cnp_pkts;
+	__le64	rx_cnp_pkts;
+	__le64	rx_ecn_marked_pkts;
+	__le64	tx_cnp_bytes;
+	__le64	rx_cnp_bytes;
+	__le64	seq_err_naks_rcvd;
+	__le64	rnr_naks_rcvd;
+	__le64	missing_resp;
+	__le64	to_retransmit;
+	__le64	dup_req;
+	__le64	rx_dcn_payload_cut;
+	__le64	te_bypassed;
+	__le64	tx_dcn_cnp;
+	__le64	rx_dcn_cnp;
+	__le64	rx_payload_cut;
+	__le64	rx_payload_cut_ignored;
+	__le64	rx_dcn_cnp_ignored;
+};
+
+/* cmdq_query_func (size:128b/16B) */
+struct cmdq_query_func {
+	u8	opcode;
+	#define CMDQ_QUERY_FUNC_OPCODE_QUERY_FUNC 0x83UL
+	#define CMDQ_QUERY_FUNC_OPCODE_LAST      CMDQ_QUERY_FUNC_OPCODE_QUERY_FUNC
+	u8	cmd_size;
+	__le16	flags;
+	__le16	cookie;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	resp_addr;
+};
+
+/* creq_query_func_resp (size:128b/16B) */
+struct creq_query_func_resp {
+	u8	type;
+	#define CREQ_QUERY_FUNC_RESP_TYPE_MASK    0x3fUL
+	#define CREQ_QUERY_FUNC_RESP_TYPE_SFT     0
+	#define CREQ_QUERY_FUNC_RESP_TYPE_QP_EVENT  0x38UL
+	#define CREQ_QUERY_FUNC_RESP_TYPE_LAST     CREQ_QUERY_FUNC_RESP_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	size;
+	u8	v;
+	#define CREQ_QUERY_FUNC_RESP_V     0x1UL
+	u8	event;
+	#define CREQ_QUERY_FUNC_RESP_EVENT_QUERY_FUNC 0x83UL
+	#define CREQ_QUERY_FUNC_RESP_EVENT_LAST      CREQ_QUERY_FUNC_RESP_EVENT_QUERY_FUNC
+	u8	reserved48[6];
+};
+
+/* creq_query_func_resp_sb (size:1728b/216B) */
+struct creq_query_func_resp_sb {
+	u8	opcode;
+	#define CREQ_QUERY_FUNC_RESP_SB_OPCODE_QUERY_FUNC 0x83UL
+	#define CREQ_QUERY_FUNC_RESP_SB_OPCODE_LAST      CREQ_QUERY_FUNC_RESP_SB_OPCODE_QUERY_FUNC
+	u8	status;
+	__le16	cookie;
+	__le16	flags;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	max_mr_size;
+	__le32	max_qp;
+	__le16	max_qp_wr;
+	__le16	dev_cap_flags;
+	#define CREQ_QUERY_FUNC_RESP_SB_RESIZE_QP                            0x1UL
+	#define CREQ_QUERY_FUNC_RESP_SB_CC_GENERATION_MASK                   0xeUL
+	#define CREQ_QUERY_FUNC_RESP_SB_CC_GENERATION_SFT                    1
+	#define CREQ_QUERY_FUNC_RESP_SB_CC_GENERATION_CC_GEN0                  (0x0UL << 1)
+	#define CREQ_QUERY_FUNC_RESP_SB_CC_GENERATION_CC_GEN1                  (0x1UL << 1)
+	#define CREQ_QUERY_FUNC_RESP_SB_CC_GENERATION_CC_GEN1_EXT              (0x2UL << 1)
+	#define CREQ_QUERY_FUNC_RESP_SB_CC_GENERATION_CC_GEN2                  (0x3UL << 1)
+	#define CREQ_QUERY_FUNC_RESP_SB_CC_GENERATION_CC_GEN2_EXT              (0x4UL << 1)
+	#define CREQ_QUERY_FUNC_RESP_SB_CC_GENERATION_LAST                    CREQ_QUERY_FUNC_RESP_SB_CC_GENERATION_CC_GEN2_EXT
+	#define CREQ_QUERY_FUNC_RESP_SB_EXT_STATS                            0x10UL
+	#define CREQ_QUERY_FUNC_RESP_SB_MR_REGISTER_ALLOC                    0x20UL
+	#define CREQ_QUERY_FUNC_RESP_SB_OPTIMIZED_TRANSMIT_ENABLED           0x40UL
+	#define CREQ_QUERY_FUNC_RESP_SB_CQE_V2                               0x80UL
+	#define CREQ_QUERY_FUNC_RESP_SB_PINGPONG_PUSH_MODE                   0x100UL
+	#define CREQ_QUERY_FUNC_RESP_SB_HW_REQUESTER_RETX_ENABLED            0x200UL
+	#define CREQ_QUERY_FUNC_RESP_SB_HW_RESPONDER_RETX_ENABLED            0x400UL
+	#define CREQ_QUERY_FUNC_RESP_SB_LINK_AGGR_SUPPORTED                  0x800UL
+	#define CREQ_QUERY_FUNC_RESP_SB_LINK_AGGR_SUPPORTED_VALID            0x1000UL
+	#define CREQ_QUERY_FUNC_RESP_SB_PSEUDO_STATIC_QP_ALLOC_SUPPORTED     0x2000UL
+	#define CREQ_QUERY_FUNC_RESP_SB_EXPRESS_MODE_SUPPORTED               0x4000UL
+	#define CREQ_QUERY_FUNC_RESP_SB_INTERNAL_QUEUE_MEMORY                0x8000UL
+	__le32	max_cq;
+	__le32	max_cqe;
+	__le32	max_pd;
+	u8	max_sge;
+	u8	max_srq_sge;
+	u8	max_qp_rd_atom;
+	u8	max_qp_init_rd_atom;
+	__le32	max_mr;
+	__le32	max_mw;
+	__le32	max_raw_eth_qp;
+	__le32	max_ah;
+	__le32	max_fmr;
+	__le32	max_srq_wr;
+	__le32	max_pkeys;
+	__le32	max_inline_data;
+	u8	max_map_per_fmr;
+	u8	l2_db_space_size;
+	__le16	max_srq;
+	__le32	max_gid;
+	__le32	tqm_alloc_reqs[12];
+	__le32	max_dpi;
+	u8	max_sge_var_wqe;
+	u8	dev_cap_ext_flags;
+	#define CREQ_QUERY_FUNC_RESP_SB_ATOMIC_OPS_NOT_SUPPORTED         0x1UL
+	#define CREQ_QUERY_FUNC_RESP_SB_DRV_VERSION_RGTR_SUPPORTED       0x2UL
+	#define CREQ_QUERY_FUNC_RESP_SB_CREATE_QP_BATCH_SUPPORTED        0x4UL
+	#define CREQ_QUERY_FUNC_RESP_SB_DESTROY_QP_BATCH_SUPPORTED       0x8UL
+	#define CREQ_QUERY_FUNC_RESP_SB_ROCE_STATS_EXT_CTX_SUPPORTED     0x10UL
+	#define CREQ_QUERY_FUNC_RESP_SB_CREATE_SRQ_SGE_SUPPORTED         0x20UL
+	#define CREQ_QUERY_FUNC_RESP_SB_FIXED_SIZE_WQE_DISABLED          0x40UL
+	#define CREQ_QUERY_FUNC_RESP_SB_DCN_SUPPORTED                    0x80UL
+	__le16	max_inline_data_var_wqe;
+	__le32	start_qid;
+	u8	max_msn_table_size;
+	u8	dev_cap_ext_flags_1;
+	#define CREQ_QUERY_FUNC_RESP_SB_PBL_PAGE_SIZE_SUPPORTED              0x1UL
+	#define CREQ_QUERY_FUNC_RESP_SB_INFINITE_RETRY_TO_RETX_SUPPORTED     0x2UL
+	__le16	dev_cap_ext_flags_2;
+	#define CREQ_QUERY_FUNC_RESP_SB_OPTIMIZE_MODIFY_QP_SUPPORTED             0x1UL
+	#define CREQ_QUERY_FUNC_RESP_SB_CHANGE_UDP_SRC_PORT_WQE_SUPPORTED        0x2UL
+	#define CREQ_QUERY_FUNC_RESP_SB_CQ_COALESCING_SUPPORTED                  0x4UL
+	#define CREQ_QUERY_FUNC_RESP_SB_MEMORY_REGION_RO_SUPPORTED               0x8UL
+	#define CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_MASK          0x30UL
+	#define CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_SFT           4
+	#define CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_HOST_PSN_TABLE  (0x0UL << 4)
+	#define CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_HOST_MSN_TABLE  (0x1UL << 4)
+	#define CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_IQM_MSN_TABLE   (0x2UL << 4)
+	#define CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_LAST           CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_IQM_MSN_TABLE
+	#define CREQ_QUERY_FUNC_RESP_SB_MAX_SRQ_EXTENDED                         0x40UL
+	#define CREQ_QUERY_FUNC_RESP_SB_CHANGE_UDP_SRC_PORT_SUPPORTED            0x80UL
+	#define CREQ_QUERY_FUNC_RESP_SB_DESTROY_CONTEXT_SB_SUPPORTED             0x100UL
+	#define CREQ_QUERY_FUNC_RESP_SB_DEFAULT_ROCE_CC_PARAMS_SUPPORTED         0x200UL
+	#define CREQ_QUERY_FUNC_RESP_SB_MODIFY_QP_RATE_LIMIT_SUPPORTED           0x400UL
+	#define CREQ_QUERY_FUNC_RESP_SB_DESTROY_UDCC_SESSION_SB_SUPPORTED        0x800UL
+	#define CREQ_QUERY_FUNC_RESP_SB_MIN_RNR_RTR_RTS_OPT_SUPPORTED            0x1000UL
+	#define CREQ_QUERY_FUNC_RESP_SB_CQ_OVERFLOW_DETECTION_ENABLED            0x2000UL
+	#define CREQ_QUERY_FUNC_RESP_SB_ICRC_CHECK_DISABLE_SUPPORTED             0x4000UL
+	#define CREQ_QUERY_FUNC_RESP_SB_FORCE_MIRROR_ENABLE_SUPPORTED            0x8000UL
+	__le16	max_xp_qp_size;
+	__le16	create_qp_batch_size;
+	__le16	destroy_qp_batch_size;
+	__le16	max_srq_ext;
+	__le16	roce_cc_tlv_en_flags;
+	#define CREQ_QUERY_FUNC_RESP_SB_ROCE_CC_GEN2_TLV_EN         0x1UL
+	#define CREQ_QUERY_FUNC_RESP_SB_ROCE_CC_GEN1_EXT_TLV_EN     0x2UL
+	#define CREQ_QUERY_FUNC_RESP_SB_ROCE_CC_GEN2_EXT_TLV_EN     0x4UL
+	__le16	pno_flags;
+	#define CREQ_QUERY_FUNC_RESP_SB_PNO_FLAGS_PNO_ENABLED                            0x1UL
+	#define CREQ_QUERY_FUNC_RESP_SB_PNO_FLAGS_PNO_ENABLED_ON_PF                      0x2UL
+	#define CREQ_QUERY_FUNC_RESP_SB_PNO_FLAGS_PNO_EXT_ENABLED                        0x4UL
+	#define CREQ_QUERY_FUNC_RESP_SB_PNO_FLAGS_PNO_EXT_ENABLED_ON_PF                  0x8UL
+	#define CREQ_QUERY_FUNC_RESP_SB_PNO_FLAGS_PSP_ENABLED                            0x10UL
+	#define CREQ_QUERY_FUNC_RESP_SB_PNO_FLAGS_PSP_ENABLED_ON_PF                      0x20UL
+	#define CREQ_QUERY_FUNC_RESP_SB_PNO_FLAGS_DYNAMIC_TUNNELS_ENABLED                0x40UL
+	#define CREQ_QUERY_FUNC_RESP_SB_PNO_FLAGS_PER_TUNNEL_EV_MONITORING_SUPPORTED     0x80UL
+	u8	pno_tnl_dest_grp_auto;
+	u8	pno_max_tnl_per_endpoint;
+	u8	pno_cc_algo;
+	u8	pno_pf_num;
+	__le32	pno_max_endpoints;
+	u8	eroce_spec_dscp[2];
+	u8	eroce_pull_dscp[2];
+	u8	eroce_retx_dscp[2];
+	u8	eroce_rts_dscp[2];
+	u8	eroce_rerouted_dscp[2];
+	u8	eroce_trim_dscp;
+	u8	eroce_trim_last_hop_dscp;
+	u8	eroce_control_dscp;
+	u8	reserved24[3];
+	__le16	pno_num_debug_tunnels;
+	u8	pno_num_cos;
+	u8	reserved40[5];
+	__le32	pno_flags_ext;
+	#define CREQ_QUERY_FUNC_RESP_SB_PNO_FLAGS_EXT_PATH_UPDATE_RTS            0x1UL
+	#define CREQ_QUERY_FUNC_RESP_SB_PNO_FLAGS_EXT_PATH_EVENT                 0x2UL
+	#define CREQ_QUERY_FUNC_RESP_SB_PNO_FLAGS_EXT_PATH_EXP_ARRAY             0x4UL
+	#define CREQ_QUERY_FUNC_RESP_SB_PNO_FLAGS_EXT_PATH_GEN_ARRAY             0x8UL
+	#define CREQ_QUERY_FUNC_RESP_SB_PNO_FLAGS_EXT_PATH_EXP_ARRAY_RANGE       0x10UL
+	#define CREQ_QUERY_FUNC_RESP_SB_PNO_FLAGS_EXT_PATH_PROBE                 0x20UL
+	#define CREQ_QUERY_FUNC_RESP_SB_PNO_FLAGS_EXT_PATH_EVENT_PRECISE_CNT     0x40UL
+	#define CREQ_QUERY_FUNC_RESP_SB_PNO_FLAGS_EXT_PATH_SPRAYING_DISABLE      0x80UL
+	__le16	max_mpr;
+	u8	max_paths_per_path_ctx;
+	u8	max_plane;
+	u8	max_paths_per_plane;
+	u8	max_strpath_tiers;
+	u8	pno_telemetry_type;
+	u8	reserved9_8b;
+	__le32	max_path_ctx_strpath;
+	__le32	max_path_ctx_srv6;
+	__le32	rate_limit_max;
+	__le32	rate_limit_min;
+};
+
+/* cmdq_set_func_resources (size:448b/56B) */
+struct cmdq_set_func_resources {
+	u8	opcode;
+	#define CMDQ_SET_FUNC_RESOURCES_OPCODE_SET_FUNC_RESOURCES 0x84UL
+	#define CMDQ_SET_FUNC_RESOURCES_OPCODE_LAST              CMDQ_SET_FUNC_RESOURCES_OPCODE_SET_FUNC_RESOURCES
+	u8	cmd_size;
+	__le16	flags;
+	#define CMDQ_SET_FUNC_RESOURCES_FLAGS_MRAV_RESERVATION_SPLIT     0x1UL
+	__le16	cookie;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	resp_addr;
+	__le32	number_of_qp;
+	__le32	number_of_mrw;
+	__le32	number_of_srq;
+	__le32	number_of_cq;
+	__le32	max_qp_per_vf;
+	__le32	max_mrw_per_vf;
+	__le32	max_srq_per_vf;
+	__le32	max_cq_per_vf;
+	__le32	max_gid_per_vf;
+	__le32	stat_ctx_id;
+};
+
+/* creq_set_func_resources_resp (size:128b/16B) */
+struct creq_set_func_resources_resp {
+	u8	type;
+	#define CREQ_SET_FUNC_RESOURCES_RESP_TYPE_MASK    0x3fUL
+	#define CREQ_SET_FUNC_RESOURCES_RESP_TYPE_SFT     0
+	#define CREQ_SET_FUNC_RESOURCES_RESP_TYPE_QP_EVENT  0x38UL
+	#define CREQ_SET_FUNC_RESOURCES_RESP_TYPE_LAST     CREQ_SET_FUNC_RESOURCES_RESP_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	reserved32;
+	u8	v;
+	#define CREQ_SET_FUNC_RESOURCES_RESP_V     0x1UL
+	u8	event;
+	#define CREQ_SET_FUNC_RESOURCES_RESP_EVENT_SET_FUNC_RESOURCES 0x84UL
+	#define CREQ_SET_FUNC_RESOURCES_RESP_EVENT_LAST \
+		CREQ_SET_FUNC_RESOURCES_RESP_EVENT_SET_FUNC_RESOURCES
+	u8	reserved48[6];
+};
+
+/* cmdq_read_context (size:192b/24B) */
+struct cmdq_read_context {
+	u8	opcode;
+	#define CMDQ_READ_CONTEXT_OPCODE_READ_CONTEXT 0x85UL
+	#define CMDQ_READ_CONTEXT_OPCODE_LAST        CMDQ_READ_CONTEXT_OPCODE_READ_CONTEXT
+	u8	cmd_size;
+	__le16	flags;
+	__le16	cookie;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	resp_addr;
+	__le32	xid;
+	u8	type;
+	#define CMDQ_READ_CONTEXT_TYPE_QPC 0x0UL
+	#define CMDQ_READ_CONTEXT_TYPE_CQ  0x1UL
+	#define CMDQ_READ_CONTEXT_TYPE_MRW 0x2UL
+	#define CMDQ_READ_CONTEXT_TYPE_SRQ 0x3UL
+	#define CMDQ_READ_CONTEXT_TYPE_LAST CMDQ_READ_CONTEXT_TYPE_SRQ
+	u8	unused_0[3];
+};
+
+/* creq_read_context (size:128b/16B) */
+struct creq_read_context {
+	u8	type;
+	#define CREQ_READ_CONTEXT_TYPE_MASK    0x3fUL
+	#define CREQ_READ_CONTEXT_TYPE_SFT     0
+	#define CREQ_READ_CONTEXT_TYPE_QP_EVENT  0x38UL
+	#define CREQ_READ_CONTEXT_TYPE_LAST     CREQ_READ_CONTEXT_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	reserved32;
+	u8	v;
+	#define CREQ_READ_CONTEXT_V     0x1UL
+	u8	event;
+	#define CREQ_READ_CONTEXT_EVENT_READ_CONTEXT 0x85UL
+	#define CREQ_READ_CONTEXT_EVENT_LAST        CREQ_READ_CONTEXT_EVENT_READ_CONTEXT
+	__le16	reserved16;
+	__le32	reserved_32;
+};
+
+/* cmdq_map_tc_to_cos (size:192b/24B) */
+struct cmdq_map_tc_to_cos {
+	u8	opcode;
+	#define CMDQ_MAP_TC_TO_COS_OPCODE_MAP_TC_TO_COS 0x8aUL
+	#define CMDQ_MAP_TC_TO_COS_OPCODE_LAST         CMDQ_MAP_TC_TO_COS_OPCODE_MAP_TC_TO_COS
+	u8	cmd_size;
+	__le16	flags;
+	__le16	cookie;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	resp_addr;
+	__le16	cos0;
+	#define CMDQ_MAP_TC_TO_COS_COS0_NO_CHANGE 0xffffUL
+	#define CMDQ_MAP_TC_TO_COS_COS0_LAST     CMDQ_MAP_TC_TO_COS_COS0_NO_CHANGE
+	__le16	cos1;
+	#define CMDQ_MAP_TC_TO_COS_COS1_DISABLE   0x8000UL
+	#define CMDQ_MAP_TC_TO_COS_COS1_NO_CHANGE 0xffffUL
+	#define CMDQ_MAP_TC_TO_COS_COS1_LAST     CMDQ_MAP_TC_TO_COS_COS1_NO_CHANGE
+	__le32	unused_0;
+};
+
+/* creq_map_tc_to_cos_resp (size:128b/16B) */
+struct creq_map_tc_to_cos_resp {
+	u8	type;
+	#define CREQ_MAP_TC_TO_COS_RESP_TYPE_MASK    0x3fUL
+	#define CREQ_MAP_TC_TO_COS_RESP_TYPE_SFT     0
+	#define CREQ_MAP_TC_TO_COS_RESP_TYPE_QP_EVENT  0x38UL
+	#define CREQ_MAP_TC_TO_COS_RESP_TYPE_LAST     CREQ_MAP_TC_TO_COS_RESP_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	reserved32;
+	u8	v;
+	#define CREQ_MAP_TC_TO_COS_RESP_V     0x1UL
+	u8	event;
+	#define CREQ_MAP_TC_TO_COS_RESP_EVENT_MAP_TC_TO_COS 0x8aUL
+	#define CREQ_MAP_TC_TO_COS_RESP_EVENT_LAST         CREQ_MAP_TC_TO_COS_RESP_EVENT_MAP_TC_TO_COS
+	u8	reserved48[6];
+};
+
+/* cmdq_query_roce_cc (size:128b/16B) */
+struct cmdq_query_roce_cc {
+	u8	opcode;
+	#define CMDQ_QUERY_ROCE_CC_OPCODE_QUERY_ROCE_CC 0x8dUL
+	#define CMDQ_QUERY_ROCE_CC_OPCODE_LAST         CMDQ_QUERY_ROCE_CC_OPCODE_QUERY_ROCE_CC
+	u8	cmd_size;
+	__le16	flags;
+	__le16	cookie;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	resp_addr;
+};
+
+/* creq_query_roce_cc_resp (size:128b/16B) */
+struct creq_query_roce_cc_resp {
+	u8	type;
+	#define CREQ_QUERY_ROCE_CC_RESP_TYPE_MASK    0x3fUL
+	#define CREQ_QUERY_ROCE_CC_RESP_TYPE_SFT     0
+	#define CREQ_QUERY_ROCE_CC_RESP_TYPE_QP_EVENT  0x38UL
+	#define CREQ_QUERY_ROCE_CC_RESP_TYPE_LAST     CREQ_QUERY_ROCE_CC_RESP_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	size;
+	u8	v;
+	#define CREQ_QUERY_ROCE_CC_RESP_V     0x1UL
+	u8	event;
+	#define CREQ_QUERY_ROCE_CC_RESP_EVENT_QUERY_ROCE_CC 0x8dUL
+	#define CREQ_QUERY_ROCE_CC_RESP_EVENT_LAST         CREQ_QUERY_ROCE_CC_RESP_EVENT_QUERY_ROCE_CC
+	u8	reserved48[6];
+};
+
+/* creq_query_roce_cc_resp_sb (size:256b/32B) */
+struct creq_query_roce_cc_resp_sb {
+	u8	opcode;
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_OPCODE_QUERY_ROCE_CC 0x8dUL
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_OPCODE_LAST         CREQ_QUERY_ROCE_CC_RESP_SB_OPCODE_QUERY_ROCE_CC
+	u8	status;
+	__le16	cookie;
+	__le16	flags;
+	u8	resp_size;
+	u8	reserved8;
+	u8	enable_cc;
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_ENABLE_CC     0x1UL
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_UNUSED7_MASK  0xfeUL
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_UNUSED7_SFT   1
+	u8	tos_dscp_tos_ecn;
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TOS_ECN_MASK 0x3UL
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TOS_ECN_SFT  0
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TOS_DSCP_MASK 0xfcUL
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TOS_DSCP_SFT 2
+	u8	g;
+	u8	num_phases_per_state;
+	__le16	init_cr;
+	__le16	init_tr;
+	u8	alt_vlan_pcp;
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_ALT_VLAN_PCP_MASK 0x7UL
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_ALT_VLAN_PCP_SFT 0
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_RSVD1_MASK       0xf8UL
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_RSVD1_SFT        3
+	u8	alt_tos_dscp;
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_ALT_TOS_DSCP_MASK 0x3fUL
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_ALT_TOS_DSCP_SFT 0
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_RSVD4_MASK       0xc0UL
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_RSVD4_SFT        6
+	u8	cc_mode;
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_CC_MODE_DCTCP         0x0UL
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_CC_MODE_PROBABILISTIC 0x1UL
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_CC_MODE_LAST         CREQ_QUERY_ROCE_CC_RESP_SB_CC_MODE_PROBABILISTIC
+	u8	tx_queue;
+	__le16	rtt;
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_RTT_MASK  0x3fffUL
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_RTT_SFT   0
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_RSVD5_MASK 0xc000UL
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_RSVD5_SFT 14
+	__le16	tcp_cp;
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TCP_CP_MASK 0x3ffUL
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TCP_CP_SFT 0
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_RSVD6_MASK 0xfc00UL
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_RSVD6_SFT  10
+	__le16	inactivity_th;
+	u8	pkts_per_phase;
+	u8	time_per_phase;
+	__le32	reserved32;
+};
+
+/* creq_query_roce_cc_resp_sb_tlv (size:384b/48B) */
+struct creq_query_roce_cc_resp_sb_tlv {
+	__le16	cmd_discr;
+	u8	reserved_8b;
+	u8	tlv_flags;
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TLV_TLV_FLAGS_MORE         0x1UL
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TLV_TLV_FLAGS_MORE_LAST      0x0UL
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TLV_TLV_FLAGS_MORE_NOT_LAST  0x1UL
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TLV_TLV_FLAGS_REQUIRED     0x2UL
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TLV_TLV_FLAGS_REQUIRED_NO    (0x0UL << 1)
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TLV_TLV_FLAGS_REQUIRED_YES   (0x1UL << 1)
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TLV_TLV_FLAGS_REQUIRED_LAST CREQ_QUERY_ROCE_CC_RESP_SB_TLV_TLV_FLAGS_REQUIRED_YES
+	__le16	tlv_type;
+	__le16	length;
+	u8	total_size;
+	u8	reserved56[7];
+	u8	opcode;
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TLV_OPCODE_QUERY_ROCE_CC 0x8dUL
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TLV_OPCODE_LAST         CREQ_QUERY_ROCE_CC_RESP_SB_TLV_OPCODE_QUERY_ROCE_CC
+	u8	status;
+	__le16	cookie;
+	__le16	flags;
+	u8	resp_size;
+	u8	reserved8;
+	u8	enable_cc;
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TLV_ENABLE_CC     0x1UL
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TLV_UNUSED7_MASK  0xfeUL
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TLV_UNUSED7_SFT   1
+	u8	tos_dscp_tos_ecn;
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TLV_TOS_ECN_MASK 0x3UL
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TLV_TOS_ECN_SFT  0
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TLV_TOS_DSCP_MASK 0xfcUL
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TLV_TOS_DSCP_SFT 2
+	u8	g;
+	u8	num_phases_per_state;
+	__le16	init_cr;
+	__le16	init_tr;
+	u8	alt_vlan_pcp;
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TLV_ALT_VLAN_PCP_MASK 0x7UL
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TLV_ALT_VLAN_PCP_SFT 0
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TLV_RSVD1_MASK       0xf8UL
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TLV_RSVD1_SFT        3
+	u8	alt_tos_dscp;
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TLV_ALT_TOS_DSCP_MASK 0x3fUL
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TLV_ALT_TOS_DSCP_SFT 0
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TLV_RSVD4_MASK       0xc0UL
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TLV_RSVD4_SFT        6
+	u8	cc_mode;
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TLV_CC_MODE_DCTCP         0x0UL
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TLV_CC_MODE_PROBABILISTIC 0x1UL
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TLV_CC_MODE_LAST         CREQ_QUERY_ROCE_CC_RESP_SB_TLV_CC_MODE_PROBABILISTIC
+	u8	tx_queue;
+	__le16	rtt;
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TLV_RTT_MASK  0x3fffUL
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TLV_RTT_SFT   0
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TLV_RSVD5_MASK 0xc000UL
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TLV_RSVD5_SFT 14
+	__le16	tcp_cp;
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TLV_TCP_CP_MASK 0x3ffUL
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TLV_TCP_CP_SFT 0
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TLV_RSVD6_MASK 0xfc00UL
+	#define CREQ_QUERY_ROCE_CC_RESP_SB_TLV_RSVD6_SFT  10
+	__le16	inactivity_th;
+	u8	pkts_per_phase;
+	u8	time_per_phase;
+	__le32	reserved32;
+};
+
+/* creq_query_roce_cc_gen1_resp_sb_tlv (size:704b/88B) */
+struct creq_query_roce_cc_gen1_resp_sb_tlv {
+	__le16	cmd_discr;
+	u8	reserved_8b;
+	u8	tlv_flags;
+	#define CREQ_QUERY_ROCE_CC_GEN1_RESP_SB_TLV_TLV_FLAGS_MORE         0x1UL
+	#define CREQ_QUERY_ROCE_CC_GEN1_RESP_SB_TLV_TLV_FLAGS_MORE_LAST      0x0UL
+	#define CREQ_QUERY_ROCE_CC_GEN1_RESP_SB_TLV_TLV_FLAGS_MORE_NOT_LAST  0x1UL
+	#define CREQ_QUERY_ROCE_CC_GEN1_RESP_SB_TLV_TLV_FLAGS_REQUIRED     0x2UL
+	#define CREQ_QUERY_ROCE_CC_GEN1_RESP_SB_TLV_TLV_FLAGS_REQUIRED_NO    (0x0UL << 1)
+	#define CREQ_QUERY_ROCE_CC_GEN1_RESP_SB_TLV_TLV_FLAGS_REQUIRED_YES   (0x1UL << 1)
+	#define CREQ_QUERY_ROCE_CC_GEN1_RESP_SB_TLV_TLV_FLAGS_REQUIRED_LAST CREQ_QUERY_ROCE_CC_GEN1_RESP_SB_TLV_TLV_FLAGS_REQUIRED_YES
+	__le16	tlv_type;
+	__le16	length;
+	__le64	reserved64;
+	__le16	inactivity_th_hi;
+	__le16	min_time_between_cnps;
+	__le16	init_cp;
+	u8	tr_update_mode;
+	u8	tr_update_cycles;
+	u8	fr_num_rtts;
+	u8	ai_rate_increase;
+	__le16	reduction_relax_rtts_th;
+	__le16	additional_relax_cr_th;
+	__le16	cr_min_th;
+	u8	bw_avg_weight;
+	u8	actual_cr_factor;
+	__le16	max_cp_cr_th;
+	u8	cp_bias_en;
+	u8	cp_bias;
+	u8	cnp_ecn;
+	#define CREQ_QUERY_ROCE_CC_GEN1_RESP_SB_TLV_CNP_ECN_NOT_ECT 0x0UL
+	#define CREQ_QUERY_ROCE_CC_GEN1_RESP_SB_TLV_CNP_ECN_ECT_1   0x1UL
+	#define CREQ_QUERY_ROCE_CC_GEN1_RESP_SB_TLV_CNP_ECN_ECT_0   0x2UL
+	#define CREQ_QUERY_ROCE_CC_GEN1_RESP_SB_TLV_CNP_ECN_LAST   CREQ_QUERY_ROCE_CC_GEN1_RESP_SB_TLV_CNP_ECN_ECT_0
+	u8	rtt_jitter_en;
+	__le16	link_bytes_per_usec;
+	__le16	reset_cc_cr_th;
+	u8	cr_width;
+	u8	quota_period_min;
+	u8	quota_period_max;
+	u8	quota_period_abs_max;
+	__le16	tr_lower_bound;
+	u8	cr_prob_factor;
+	u8	tr_prob_factor;
+	__le16	fairness_cr_th;
+	u8	red_div;
+	u8	cnp_ratio_th;
+	__le16	exp_ai_rtts;
+	u8	exp_ai_cr_cp_ratio;
+	u8	use_rate_table;
+	__le16	cp_exp_update_th;
+	__le16	high_exp_ai_rtts_th1;
+	__le16	high_exp_ai_rtts_th2;
+	__le16	actual_cr_cong_free_rtts_th;
+	__le16	severe_cong_cr_th1;
+	__le16	severe_cong_cr_th2;
+	__le32	link64B_per_rtt;
+	u8	cc_ack_bytes;
+	u8	reduce_init_en;
+	__le16	reduce_init_cong_free_rtts_th;
+	u8	random_no_red_en;
+	u8	actual_cr_shift_correction_en;
+	u8	quota_period_adjust_en;
+	u8	reserved[5];
+};
+
+/* creq_query_roce_cc_gen2_resp_sb_tlv (size:512b/64B) */
+struct creq_query_roce_cc_gen2_resp_sb_tlv {
+	__le16	cmd_discr;
+	u8	reserved_8b;
+	u8	tlv_flags;
+	#define CREQ_QUERY_ROCE_CC_GEN2_RESP_SB_TLV_TLV_FLAGS_MORE         0x1UL
+	#define CREQ_QUERY_ROCE_CC_GEN2_RESP_SB_TLV_TLV_FLAGS_MORE_LAST      0x0UL
+	#define CREQ_QUERY_ROCE_CC_GEN2_RESP_SB_TLV_TLV_FLAGS_MORE_NOT_LAST  0x1UL
+	#define CREQ_QUERY_ROCE_CC_GEN2_RESP_SB_TLV_TLV_FLAGS_REQUIRED     0x2UL
+	#define CREQ_QUERY_ROCE_CC_GEN2_RESP_SB_TLV_TLV_FLAGS_REQUIRED_NO    (0x0UL << 1)
+	#define CREQ_QUERY_ROCE_CC_GEN2_RESP_SB_TLV_TLV_FLAGS_REQUIRED_YES   (0x1UL << 1)
+	#define CREQ_QUERY_ROCE_CC_GEN2_RESP_SB_TLV_TLV_FLAGS_REQUIRED_LAST CREQ_QUERY_ROCE_CC_GEN2_RESP_SB_TLV_TLV_FLAGS_REQUIRED_YES
+	__le16	tlv_type;
+	__le16	length;
+	__le64	reserved64;
+	__le16	dcn_qlevel_tbl_thr[8];
+	__le32	dcn_qlevel_tbl_act[8];
+	#define CREQ_QUERY_ROCE_CC_GEN2_RESP_SB_TLV_DCN_QLEVEL_TBL_ACT_CR_MASK     0x3fffUL
+	#define CREQ_QUERY_ROCE_CC_GEN2_RESP_SB_TLV_DCN_QLEVEL_TBL_ACT_CR_SFT      0
+	#define CREQ_QUERY_ROCE_CC_GEN2_RESP_SB_TLV_DCN_QLEVEL_TBL_ACT_INC_CNP     0x4000UL
+	#define CREQ_QUERY_ROCE_CC_GEN2_RESP_SB_TLV_DCN_QLEVEL_TBL_ACT_UPD_IMM     0x8000UL
+	#define CREQ_QUERY_ROCE_CC_GEN2_RESP_SB_TLV_DCN_QLEVEL_TBL_ACT_TR_MASK     0x3fff0000UL
+	#define CREQ_QUERY_ROCE_CC_GEN2_RESP_SB_TLV_DCN_QLEVEL_TBL_ACT_TR_SFT      16
+};
+
+/* creq_query_roce_cc_gen1_ext_resp_sb_tlv (size:896b/112B) */
+struct creq_query_roce_cc_gen1_ext_resp_sb_tlv {
+	__le16	cmd_discr;
+	u8	reserved_8b;
+	u8	tlv_flags;
+	#define CREQ_QUERY_ROCE_CC_GEN1_EXT_RESP_SB_TLV_TLV_FLAGS_MORE         0x1UL
+	#define CREQ_QUERY_ROCE_CC_GEN1_EXT_RESP_SB_TLV_TLV_FLAGS_MORE_LAST      0x0UL
+	#define CREQ_QUERY_ROCE_CC_GEN1_EXT_RESP_SB_TLV_TLV_FLAGS_MORE_NOT_LAST  0x1UL
+	#define CREQ_QUERY_ROCE_CC_GEN1_EXT_RESP_SB_TLV_TLV_FLAGS_REQUIRED     0x2UL
+	#define CREQ_QUERY_ROCE_CC_GEN1_EXT_RESP_SB_TLV_TLV_FLAGS_REQUIRED_NO    (0x0UL << 1)
+	#define CREQ_QUERY_ROCE_CC_GEN1_EXT_RESP_SB_TLV_TLV_FLAGS_REQUIRED_YES   (0x1UL << 1)
+	#define CREQ_QUERY_ROCE_CC_GEN1_EXT_RESP_SB_TLV_TLV_FLAGS_REQUIRED_LAST CREQ_QUERY_ROCE_CC_GEN1_EXT_RESP_SB_TLV_TLV_FLAGS_REQUIRED_YES
+	__le16	tlv_type;
+	__le16	length;
+	__le64	reserved64;
+	__le16	rnd_no_red_mult;
+	#define CREQ_QUERY_ROCE_CC_GEN1_EXT_RESP_SB_TLV_RND_NO_RED_MULT_MASK 0x3ffUL
+	#define CREQ_QUERY_ROCE_CC_GEN1_EXT_RESP_SB_TLV_RND_NO_RED_MULT_SFT 0
+	__le16	no_red_offset;
+	#define CREQ_QUERY_ROCE_CC_GEN1_EXT_RESP_SB_TLV_NO_RED_OFFSET_MASK 0x7ffUL
+	#define CREQ_QUERY_ROCE_CC_GEN1_EXT_RESP_SB_TLV_NO_RED_OFFSET_SFT 0
+	__le16	reduce2_init_cong_free_rtts_th;
+	#define CREQ_QUERY_ROCE_CC_GEN1_EXT_RESP_SB_TLV_REDUCE2_INIT_CONG_FREE_RTTS_TH_MASK 0x3ffUL
+	#define CREQ_QUERY_ROCE_CC_GEN1_EXT_RESP_SB_TLV_REDUCE2_INIT_CONG_FREE_RTTS_TH_SFT 0
+	u8	reduce2_init_en;
+	#define CREQ_QUERY_ROCE_CC_GEN1_EXT_RESP_SB_TLV_REDUCE2_INIT_EN     0x1UL
+	u8	period_adjust_count;
+	#define CREQ_QUERY_ROCE_CC_GEN1_EXT_RESP_SB_TLV_PERIOD_ADJUST_COUNT_MASK 0xffUL
+	#define CREQ_QUERY_ROCE_CC_GEN1_EXT_RESP_SB_TLV_PERIOD_ADJUST_COUNT_SFT 0
+	__le16	current_rate_threshold_1;
+	#define CREQ_QUERY_ROCE_CC_GEN1_EXT_RESP_SB_TLV_CURRENT_RATE_THRESHOLD_1_MASK 0x3fffUL
+	#define CREQ_QUERY_ROCE_CC_GEN1_EXT_RESP_SB_TLV_CURRENT_RATE_THRESHOLD_1_SFT 0
+	__le16	current_rate_threshold_2;
+	#define CREQ_QUERY_ROCE_CC_GEN1_EXT_RESP_SB_TLV_CURRENT_RATE_THRESHOLD_2_MASK 0x3fffUL
+	#define CREQ_QUERY_ROCE_CC_GEN1_EXT_RESP_SB_TLV_CURRENT_RATE_THRESHOLD_2_SFT 0
+	__le32	reserved32;
+	__le64	reserved64_1;
+	u8	rate_table_quota_period[24];
+	#define CREQ_QUERY_ROCE_CC_GEN1_EXT_RESP_SB_TLV_RATE_TABLE_QUOTA_PERIOD_MASK 0xffUL
+	#define CREQ_QUERY_ROCE_CC_GEN1_EXT_RESP_SB_TLV_RATE_TABLE_QUOTA_PERIOD_SFT 0
+	__le16	rate_table_byte_quota[24];
+	#define CREQ_QUERY_ROCE_CC_GEN1_EXT_RESP_SB_TLV_RATE_TABLE_BYTE_QUOTA_MASK 0xffffUL
+	#define CREQ_QUERY_ROCE_CC_GEN1_EXT_RESP_SB_TLV_RATE_TABLE_BYTE_QUOTA_SFT 0
+};
+
+/* creq_query_roce_cc_gen2_ext_resp_sb_tlv (size:256b/32B) */
+struct creq_query_roce_cc_gen2_ext_resp_sb_tlv {
+	__le16	cmd_discr;
+	u8	reserved_8b;
+	u8	tlv_flags;
+	#define CREQ_QUERY_ROCE_CC_GEN2_EXT_RESP_SB_TLV_TLV_FLAGS_MORE         0x1UL
+	#define CREQ_QUERY_ROCE_CC_GEN2_EXT_RESP_SB_TLV_TLV_FLAGS_MORE_LAST      0x0UL
+	#define CREQ_QUERY_ROCE_CC_GEN2_EXT_RESP_SB_TLV_TLV_FLAGS_MORE_NOT_LAST  0x1UL
+	#define CREQ_QUERY_ROCE_CC_GEN2_EXT_RESP_SB_TLV_TLV_FLAGS_REQUIRED     0x2UL
+	#define CREQ_QUERY_ROCE_CC_GEN2_EXT_RESP_SB_TLV_TLV_FLAGS_REQUIRED_NO    (0x0UL << 1)
+	#define CREQ_QUERY_ROCE_CC_GEN2_EXT_RESP_SB_TLV_TLV_FLAGS_REQUIRED_YES   (0x1UL << 1)
+	#define CREQ_QUERY_ROCE_CC_GEN2_EXT_RESP_SB_TLV_TLV_FLAGS_REQUIRED_LAST CREQ_QUERY_ROCE_CC_GEN2_EXT_RESP_SB_TLV_TLV_FLAGS_REQUIRED_YES
+	__le16	tlv_type;
+	__le16	length;
+	__le64	reserved64;
+	__le16	cr2bw_64b_ratio;
+	#define CREQ_QUERY_ROCE_CC_GEN2_EXT_RESP_SB_TLV_CR2BW_64B_RATIO_MASK 0x3ffUL
+	#define CREQ_QUERY_ROCE_CC_GEN2_EXT_RESP_SB_TLV_CR2BW_64B_RATIO_SFT 0
+	u8	sr2_cc_first_cnp_en;
+	#define CREQ_QUERY_ROCE_CC_GEN2_EXT_RESP_SB_TLV_SR2_CC_FIRST_CNP_EN     0x1UL
+	u8	sr2_cc_actual_cr_en;
+	#define CREQ_QUERY_ROCE_CC_GEN2_EXT_RESP_SB_TLV_SR2_CC_ACTUAL_CR_EN     0x1UL
+	__le16	retx_cp;
+	#define CREQ_QUERY_ROCE_CC_GEN2_EXT_RESP_SB_TLV_RETX_CP_MASK 0x3ffUL
+	#define CREQ_QUERY_ROCE_CC_GEN2_EXT_RESP_SB_TLV_RETX_CP_SFT 0
+	__le16	retx_cr;
+	#define CREQ_QUERY_ROCE_CC_GEN2_EXT_RESP_SB_TLV_RETX_CR_MASK 0x3fffUL
+	#define CREQ_QUERY_ROCE_CC_GEN2_EXT_RESP_SB_TLV_RETX_CR_SFT 0
+	__le16	retx_tr;
+	#define CREQ_QUERY_ROCE_CC_GEN2_EXT_RESP_SB_TLV_RETX_TR_MASK 0x3fffUL
+	#define CREQ_QUERY_ROCE_CC_GEN2_EXT_RESP_SB_TLV_RETX_TR_SFT 0
+	u8	hw_retx_cc_reset_en;
+	#define CREQ_QUERY_ROCE_CC_GEN2_EXT_RESP_SB_TLV_ACK_TIMEOUT_EN          0x1UL
+	#define CREQ_QUERY_ROCE_CC_GEN2_EXT_RESP_SB_TLV_RX_NAK_EN               0x2UL
+	#define CREQ_QUERY_ROCE_CC_GEN2_EXT_RESP_SB_TLV_RX_RNR_NAK_EN           0x4UL
+	#define CREQ_QUERY_ROCE_CC_GEN2_EXT_RESP_SB_TLV_MISSING_RESPONSE_EN     0x8UL
+	#define CREQ_QUERY_ROCE_CC_GEN2_EXT_RESP_SB_TLV_DUPLICATE_READ_EN       0x10UL
+	u8	reserved8;
+	__le16	hw_retx_reset_cc_cr_th;
+	#define CREQ_QUERY_ROCE_CC_GEN2_EXT_RESP_SB_TLV_HW_RETX_RESET_CC_CR_TH_MASK 0x3fffUL
+	#define CREQ_QUERY_ROCE_CC_GEN2_EXT_RESP_SB_TLV_HW_RETX_RESET_CC_CR_TH_SFT 0
+	__le16	reserved16;
+};
+
+/* cmdq_modify_roce_cc (size:448b/56B) */
+struct cmdq_modify_roce_cc {
+	u8	opcode;
+	#define CMDQ_MODIFY_ROCE_CC_OPCODE_MODIFY_ROCE_CC 0x8cUL
+	#define CMDQ_MODIFY_ROCE_CC_OPCODE_LAST          CMDQ_MODIFY_ROCE_CC_OPCODE_MODIFY_ROCE_CC
+	u8	cmd_size;
+	__le16	flags;
+	__le16	cookie;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	resp_addr;
+	__le32	modify_mask;
+	#define CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_ENABLE_CC            0x1UL
+	#define CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_G                    0x2UL
+	#define CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_NUMPHASEPERSTATE     0x4UL
+	#define CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_INIT_CR              0x8UL
+	#define CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_INIT_TR              0x10UL
+	#define CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_TOS_ECN              0x20UL
+	#define CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_TOS_DSCP             0x40UL
+	#define CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_ALT_VLAN_PCP         0x80UL
+	#define CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_ALT_TOS_DSCP         0x100UL
+	#define CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_RTT                  0x200UL
+	#define CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_CC_MODE              0x400UL
+	#define CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_TCP_CP               0x800UL
+	#define CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_TX_QUEUE             0x1000UL
+	#define CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_INACTIVITY_CP        0x2000UL
+	#define CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_TIME_PER_PHASE       0x4000UL
+	#define CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_PKTS_PER_PHASE       0x8000UL
+	u8	enable_cc;
+	#define CMDQ_MODIFY_ROCE_CC_ENABLE_CC     0x1UL
+	#define CMDQ_MODIFY_ROCE_CC_RSVD1_MASK    0xfeUL
+	#define CMDQ_MODIFY_ROCE_CC_RSVD1_SFT     1
+	u8	g;
+	u8	num_phases_per_state;
+	u8	pkts_per_phase;
+	__le16	init_cr;
+	__le16	init_tr;
+	u8	tos_dscp_tos_ecn;
+	#define CMDQ_MODIFY_ROCE_CC_TOS_ECN_MASK 0x3UL
+	#define CMDQ_MODIFY_ROCE_CC_TOS_ECN_SFT  0
+	#define CMDQ_MODIFY_ROCE_CC_TOS_DSCP_MASK 0xfcUL
+	#define CMDQ_MODIFY_ROCE_CC_TOS_DSCP_SFT 2
+	u8	alt_vlan_pcp;
+	#define CMDQ_MODIFY_ROCE_CC_ALT_VLAN_PCP_MASK 0x7UL
+	#define CMDQ_MODIFY_ROCE_CC_ALT_VLAN_PCP_SFT 0
+	#define CMDQ_MODIFY_ROCE_CC_RSVD3_MASK       0xf8UL
+	#define CMDQ_MODIFY_ROCE_CC_RSVD3_SFT        3
+	__le16	alt_tos_dscp;
+	#define CMDQ_MODIFY_ROCE_CC_ALT_TOS_DSCP_MASK 0x3fUL
+	#define CMDQ_MODIFY_ROCE_CC_ALT_TOS_DSCP_SFT 0
+	#define CMDQ_MODIFY_ROCE_CC_RSVD4_MASK       0xffc0UL
+	#define CMDQ_MODIFY_ROCE_CC_RSVD4_SFT        6
+	__le16	rtt;
+	#define CMDQ_MODIFY_ROCE_CC_RTT_MASK  0x3fffUL
+	#define CMDQ_MODIFY_ROCE_CC_RTT_SFT   0
+	#define CMDQ_MODIFY_ROCE_CC_RSVD5_MASK 0xc000UL
+	#define CMDQ_MODIFY_ROCE_CC_RSVD5_SFT 14
+	__le16	tcp_cp;
+	#define CMDQ_MODIFY_ROCE_CC_TCP_CP_MASK 0x3ffUL
+	#define CMDQ_MODIFY_ROCE_CC_TCP_CP_SFT 0
+	#define CMDQ_MODIFY_ROCE_CC_RSVD6_MASK 0xfc00UL
+	#define CMDQ_MODIFY_ROCE_CC_RSVD6_SFT  10
+	u8	cc_mode;
+	#define CMDQ_MODIFY_ROCE_CC_CC_MODE_DCTCP_CC_MODE         0x0UL
+	#define CMDQ_MODIFY_ROCE_CC_CC_MODE_PROBABILISTIC_CC_MODE 0x1UL
+	#define CMDQ_MODIFY_ROCE_CC_CC_MODE_LAST                 CMDQ_MODIFY_ROCE_CC_CC_MODE_PROBABILISTIC_CC_MODE
+	u8	tx_queue;
+	__le16	inactivity_th;
+	u8	time_per_phase;
+	u8	reserved8_1;
+	__le16	reserved16;
+	__le32	reserved32;
+	__le64	reserved64;
+};
+
+/* cmdq_modify_roce_cc_tlv (size:640b/80B) */
+struct cmdq_modify_roce_cc_tlv {
+	__le16	cmd_discr;
+	u8	reserved_8b;
+	u8	tlv_flags;
+	#define CMDQ_MODIFY_ROCE_CC_TLV_TLV_FLAGS_MORE         0x1UL
+	#define CMDQ_MODIFY_ROCE_CC_TLV_TLV_FLAGS_MORE_LAST      0x0UL
+	#define CMDQ_MODIFY_ROCE_CC_TLV_TLV_FLAGS_MORE_NOT_LAST  0x1UL
+	#define CMDQ_MODIFY_ROCE_CC_TLV_TLV_FLAGS_REQUIRED     0x2UL
+	#define CMDQ_MODIFY_ROCE_CC_TLV_TLV_FLAGS_REQUIRED_NO    (0x0UL << 1)
+	#define CMDQ_MODIFY_ROCE_CC_TLV_TLV_FLAGS_REQUIRED_YES   (0x1UL << 1)
+	#define CMDQ_MODIFY_ROCE_CC_TLV_TLV_FLAGS_REQUIRED_LAST CMDQ_MODIFY_ROCE_CC_TLV_TLV_FLAGS_REQUIRED_YES
+	__le16	tlv_type;
+	__le16	length;
+	u8	total_size;
+	u8	reserved56[7];
+	u8	opcode;
+	#define CMDQ_MODIFY_ROCE_CC_TLV_OPCODE_MODIFY_ROCE_CC 0x8cUL
+	#define CMDQ_MODIFY_ROCE_CC_TLV_OPCODE_LAST          CMDQ_MODIFY_ROCE_CC_TLV_OPCODE_MODIFY_ROCE_CC
+	u8	cmd_size;
+	__le16	flags;
+	__le16	cookie;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	resp_addr;
+	__le32	modify_mask;
+	#define CMDQ_MODIFY_ROCE_CC_TLV_MODIFY_MASK_ENABLE_CC            0x1UL
+	#define CMDQ_MODIFY_ROCE_CC_TLV_MODIFY_MASK_G                    0x2UL
+	#define CMDQ_MODIFY_ROCE_CC_TLV_MODIFY_MASK_NUMPHASEPERSTATE     0x4UL
+	#define CMDQ_MODIFY_ROCE_CC_TLV_MODIFY_MASK_INIT_CR              0x8UL
+	#define CMDQ_MODIFY_ROCE_CC_TLV_MODIFY_MASK_INIT_TR              0x10UL
+	#define CMDQ_MODIFY_ROCE_CC_TLV_MODIFY_MASK_TOS_ECN              0x20UL
+	#define CMDQ_MODIFY_ROCE_CC_TLV_MODIFY_MASK_TOS_DSCP             0x40UL
+	#define CMDQ_MODIFY_ROCE_CC_TLV_MODIFY_MASK_ALT_VLAN_PCP         0x80UL
+	#define CMDQ_MODIFY_ROCE_CC_TLV_MODIFY_MASK_ALT_TOS_DSCP         0x100UL
+	#define CMDQ_MODIFY_ROCE_CC_TLV_MODIFY_MASK_RTT                  0x200UL
+	#define CMDQ_MODIFY_ROCE_CC_TLV_MODIFY_MASK_CC_MODE              0x400UL
+	#define CMDQ_MODIFY_ROCE_CC_TLV_MODIFY_MASK_TCP_CP               0x800UL
+	#define CMDQ_MODIFY_ROCE_CC_TLV_MODIFY_MASK_TX_QUEUE             0x1000UL
+	#define CMDQ_MODIFY_ROCE_CC_TLV_MODIFY_MASK_INACTIVITY_CP        0x2000UL
+	#define CMDQ_MODIFY_ROCE_CC_TLV_MODIFY_MASK_TIME_PER_PHASE       0x4000UL
+	#define CMDQ_MODIFY_ROCE_CC_TLV_MODIFY_MASK_PKTS_PER_PHASE       0x8000UL
+	u8	enable_cc;
+	#define CMDQ_MODIFY_ROCE_CC_TLV_ENABLE_CC     0x1UL
+	#define CMDQ_MODIFY_ROCE_CC_TLV_RSVD1_MASK    0xfeUL
+	#define CMDQ_MODIFY_ROCE_CC_TLV_RSVD1_SFT     1
+	u8	g;
+	u8	num_phases_per_state;
+	u8	pkts_per_phase;
+	__le16	init_cr;
+	__le16	init_tr;
+	u8	tos_dscp_tos_ecn;
+	#define CMDQ_MODIFY_ROCE_CC_TLV_TOS_ECN_MASK 0x3UL
+	#define CMDQ_MODIFY_ROCE_CC_TLV_TOS_ECN_SFT  0
+	#define CMDQ_MODIFY_ROCE_CC_TLV_TOS_DSCP_MASK 0xfcUL
+	#define CMDQ_MODIFY_ROCE_CC_TLV_TOS_DSCP_SFT 2
+	u8	alt_vlan_pcp;
+	#define CMDQ_MODIFY_ROCE_CC_TLV_ALT_VLAN_PCP_MASK 0x7UL
+	#define CMDQ_MODIFY_ROCE_CC_TLV_ALT_VLAN_PCP_SFT 0
+	#define CMDQ_MODIFY_ROCE_CC_TLV_RSVD3_MASK       0xf8UL
+	#define CMDQ_MODIFY_ROCE_CC_TLV_RSVD3_SFT        3
+	__le16	alt_tos_dscp;
+	#define CMDQ_MODIFY_ROCE_CC_TLV_ALT_TOS_DSCP_MASK 0x3fUL
+	#define CMDQ_MODIFY_ROCE_CC_TLV_ALT_TOS_DSCP_SFT 0
+	#define CMDQ_MODIFY_ROCE_CC_TLV_RSVD4_MASK       0xffc0UL
+	#define CMDQ_MODIFY_ROCE_CC_TLV_RSVD4_SFT        6
+	__le16	rtt;
+	#define CMDQ_MODIFY_ROCE_CC_TLV_RTT_MASK  0x3fffUL
+	#define CMDQ_MODIFY_ROCE_CC_TLV_RTT_SFT   0
+	#define CMDQ_MODIFY_ROCE_CC_TLV_RSVD5_MASK 0xc000UL
+	#define CMDQ_MODIFY_ROCE_CC_TLV_RSVD5_SFT 14
+	__le16	tcp_cp;
+	#define CMDQ_MODIFY_ROCE_CC_TLV_TCP_CP_MASK 0x3ffUL
+	#define CMDQ_MODIFY_ROCE_CC_TLV_TCP_CP_SFT 0
+	#define CMDQ_MODIFY_ROCE_CC_TLV_RSVD6_MASK 0xfc00UL
+	#define CMDQ_MODIFY_ROCE_CC_TLV_RSVD6_SFT  10
+	u8	cc_mode;
+	#define CMDQ_MODIFY_ROCE_CC_TLV_CC_MODE_DCTCP_CC_MODE         0x0UL
+	#define CMDQ_MODIFY_ROCE_CC_TLV_CC_MODE_PROBABILISTIC_CC_MODE 0x1UL
+	#define CMDQ_MODIFY_ROCE_CC_TLV_CC_MODE_LAST                 CMDQ_MODIFY_ROCE_CC_TLV_CC_MODE_PROBABILISTIC_CC_MODE
+	u8	tx_queue;
+	__le16	inactivity_th;
+	u8	time_per_phase;
+	u8	reserved8_1;
+	__le16	reserved16;
+	__le32	reserved32;
+	__le64	reserved64;
+	__le64	reservedtlvpad;
+};
+
+/* cmdq_modify_roce_cc_gen1_tlv (size:768b/96B) */
+struct cmdq_modify_roce_cc_gen1_tlv {
+	__le16	cmd_discr;
+	u8	reserved_8b;
+	u8	tlv_flags;
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_TLV_FLAGS_MORE         0x1UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_TLV_FLAGS_MORE_LAST      0x0UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_TLV_FLAGS_MORE_NOT_LAST  0x1UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_TLV_FLAGS_REQUIRED     0x2UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_TLV_FLAGS_REQUIRED_NO    (0x0UL << 1)
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_TLV_FLAGS_REQUIRED_YES   (0x1UL << 1)
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_TLV_FLAGS_REQUIRED_LAST CMDQ_MODIFY_ROCE_CC_GEN1_TLV_TLV_FLAGS_REQUIRED_YES
+	__le16	tlv_type;
+	__le16	length;
+	__le64	reserved64;
+	__le64	modify_mask;
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_MIN_TIME_BETWEEN_CNPS             0x1UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_INIT_CP                           0x2UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_TR_UPDATE_MODE                    0x4UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_TR_UPDATE_CYCLES                  0x8UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_FR_NUM_RTTS                       0x10UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_AI_RATE_INCREASE                  0x20UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_REDUCTION_RELAX_RTTS_TH           0x40UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_ADDITIONAL_RELAX_CR_TH            0x80UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_CR_MIN_TH                         0x100UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_BW_AVG_WEIGHT                     0x200UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_ACTUAL_CR_FACTOR                  0x400UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_MAX_CP_CR_TH                      0x800UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_CP_BIAS_EN                        0x1000UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_CP_BIAS                           0x2000UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_CNP_ECN                           0x4000UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_RTT_JITTER_EN                     0x8000UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_LINK_BYTES_PER_USEC               0x10000UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_RESET_CC_CR_TH                    0x20000UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_CR_WIDTH                          0x40000UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_QUOTA_PERIOD_MIN                  0x80000UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_QUOTA_PERIOD_MAX                  0x100000UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_QUOTA_PERIOD_ABS_MAX              0x200000UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_TR_LOWER_BOUND                    0x400000UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_CR_PROB_FACTOR                    0x800000UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_TR_PROB_FACTOR                    0x1000000UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_FAIRNESS_CR_TH                    0x2000000UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_RED_DIV                           0x4000000UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_CNP_RATIO_TH                      0x8000000UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_EXP_AI_RTTS                       0x10000000UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_EXP_AI_CR_CP_RATIO                0x20000000UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_CP_EXP_UPDATE_TH                  0x40000000UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_HIGH_EXP_AI_RTTS_TH1              0x80000000UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_HIGH_EXP_AI_RTTS_TH2              0x100000000ULL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_USE_RATE_TABLE                    0x200000000ULL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_LINK64B_PER_RTT                   0x400000000ULL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_ACTUAL_CR_CONG_FREE_RTTS_TH       0x800000000ULL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_SEVERE_CONG_CR_TH1                0x1000000000ULL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_SEVERE_CONG_CR_TH2                0x2000000000ULL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_CC_ACK_BYTES                      0x4000000000ULL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_REDUCE_INIT_EN                    0x8000000000ULL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_REDUCE_INIT_CONG_FREE_RTTS_TH     0x10000000000ULL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_RANDOM_NO_RED_EN                  0x20000000000ULL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_ACTUAL_CR_SHIFT_CORRECTION_EN     0x40000000000ULL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_MODIFY_MASK_QUOTA_PERIOD_ADJUST_EN            0x80000000000ULL
+	__le16	inactivity_th_hi;
+	__le16	min_time_between_cnps;
+	__le16	init_cp;
+	u8	tr_update_mode;
+	u8	tr_update_cycles;
+	u8	fr_num_rtts;
+	u8	ai_rate_increase;
+	__le16	reduction_relax_rtts_th;
+	__le16	additional_relax_cr_th;
+	__le16	cr_min_th;
+	u8	bw_avg_weight;
+	u8	actual_cr_factor;
+	__le16	max_cp_cr_th;
+	u8	cp_bias_en;
+	u8	cp_bias;
+	u8	cnp_ecn;
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_CNP_ECN_NOT_ECT 0x0UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_CNP_ECN_ECT_1   0x1UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_CNP_ECN_ECT_0   0x2UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_TLV_CNP_ECN_LAST   CMDQ_MODIFY_ROCE_CC_GEN1_TLV_CNP_ECN_ECT_0
+	u8	rtt_jitter_en;
+	__le16	link_bytes_per_usec;
+	__le16	reset_cc_cr_th;
+	u8	cr_width;
+	u8	quota_period_min;
+	u8	quota_period_max;
+	u8	quota_period_abs_max;
+	__le16	tr_lower_bound;
+	u8	cr_prob_factor;
+	u8	tr_prob_factor;
+	__le16	fairness_cr_th;
+	u8	red_div;
+	u8	cnp_ratio_th;
+	__le16	exp_ai_rtts;
+	u8	exp_ai_cr_cp_ratio;
+	u8	use_rate_table;
+	__le16	cp_exp_update_th;
+	__le16	high_exp_ai_rtts_th1;
+	__le16	high_exp_ai_rtts_th2;
+	__le16	actual_cr_cong_free_rtts_th;
+	__le16	severe_cong_cr_th1;
+	__le16	severe_cong_cr_th2;
+	__le32	link64B_per_rtt;
+	u8	cc_ack_bytes;
+	u8	reduce_init_en;
+	__le16	reduce_init_cong_free_rtts_th;
+	u8	random_no_red_en;
+	u8	actual_cr_shift_correction_en;
+	u8	quota_period_adjust_en;
+	u8	reserved[5];
+};
+
+/* cmdq_modify_roce_cc_gen2_tlv (size:256b/32B) */
+struct cmdq_modify_roce_cc_gen2_tlv {
+	__le16	cmd_discr;
+	u8	reserved_8b;
+	u8	tlv_flags;
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_TLV_TLV_FLAGS_MORE         0x1UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_TLV_TLV_FLAGS_MORE_LAST      0x0UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_TLV_TLV_FLAGS_MORE_NOT_LAST  0x1UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_TLV_TLV_FLAGS_REQUIRED     0x2UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_TLV_TLV_FLAGS_REQUIRED_NO    (0x0UL << 1)
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_TLV_TLV_FLAGS_REQUIRED_YES   (0x1UL << 1)
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_TLV_TLV_FLAGS_REQUIRED_LAST CMDQ_MODIFY_ROCE_CC_GEN2_TLV_TLV_FLAGS_REQUIRED_YES
+	__le16	tlv_type;
+	__le16	length;
+	__le64	reserved64;
+	__le64	modify_mask;
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_TLV_MODIFY_MASK_DCN_QLEVEL_TBL_IDX         0x1UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_TLV_MODIFY_MASK_DCN_QLEVEL_TBL_THR         0x2UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_TLV_MODIFY_MASK_DCN_QLEVEL_TBL_CR          0x4UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_TLV_MODIFY_MASK_DCN_QLEVEL_TBL_INC_CNP     0x8UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_TLV_MODIFY_MASK_DCN_QLEVEL_TBL_UPD_IMM     0x10UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_TLV_MODIFY_MASK_DCN_QLEVEL_TBL_TR          0x20UL
+	u8	dcn_qlevel_tbl_idx;
+	u8	reserved8;
+	__le16	dcn_qlevel_tbl_thr;
+	__le32	dcn_qlevel_tbl_act;
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_TLV_DCN_QLEVEL_TBL_ACT_CR_MASK     0x3fffUL
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_TLV_DCN_QLEVEL_TBL_ACT_CR_SFT      0
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_TLV_DCN_QLEVEL_TBL_ACT_INC_CNP     0x4000UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_TLV_DCN_QLEVEL_TBL_ACT_UPD_IMM     0x8000UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_TLV_DCN_QLEVEL_TBL_ACT_TR_MASK     0x3fff0000UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_TLV_DCN_QLEVEL_TBL_ACT_TR_SFT      16
+};
+
+/* cmdq_modify_roce_cc_gen1_ext_tlv (size:384b/48B) */
+struct cmdq_modify_roce_cc_gen1_ext_tlv {
+	__le16	cmd_discr;
+	u8	reserved_8b;
+	u8	tlv_flags;
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_EXT_TLV_TLV_FLAGS_MORE         0x1UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_EXT_TLV_TLV_FLAGS_MORE_LAST      0x0UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_EXT_TLV_TLV_FLAGS_MORE_NOT_LAST  0x1UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_EXT_TLV_TLV_FLAGS_REQUIRED     0x2UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_EXT_TLV_TLV_FLAGS_REQUIRED_NO    (0x0UL << 1)
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_EXT_TLV_TLV_FLAGS_REQUIRED_YES   (0x1UL << 1)
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_EXT_TLV_TLV_FLAGS_REQUIRED_LAST CMDQ_MODIFY_ROCE_CC_GEN1_EXT_TLV_TLV_FLAGS_REQUIRED_YES
+	__le16	tlv_type;
+	__le16	length;
+	__le64	reserved64;
+	__le64	modify_mask;
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_EXT_TLV_MODIFY_MASK_RND_NO_RED_MULT                    0x1UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_EXT_TLV_MODIFY_MASK_NO_RED_OFFSET                      0x2UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_EXT_TLV_MODIFY_MASK_REDUCE2_INIT_CONG_FREE_RTTS_TH     0x4UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_EXT_TLV_MODIFY_MASK_REDUCE2_INIT_EN                    0x8UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_EXT_TLV_MODIFY_MASK_PERIOD_ADJUST_COUNT                0x10UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_EXT_TLV_MODIFY_MASK_CURRENT_RATE_THRESHOLD_1           0x20UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_EXT_TLV_MODIFY_MASK_CURRENT_RATE_THRESHOLD_2           0x40UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_EXT_TLV_MODIFY_MASK_RATE_TABLE_IDX                     0x80UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_EXT_TLV_MODIFY_MASK_RATE_TABLE_QUOTA_PERIOD            0x100UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_EXT_TLV_MODIFY_MASK_RATE_TABLE_BYTE_QUOTA              0x200UL
+	__le16	rnd_no_red_mult;
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_EXT_TLV_RND_NO_RED_MULT_MASK 0x3ffUL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_EXT_TLV_RND_NO_RED_MULT_SFT 0
+	__le16	no_red_offset;
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_EXT_TLV_NO_RED_OFFSET_MASK 0x7ffUL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_EXT_TLV_NO_RED_OFFSET_SFT 0
+	__le16	reduce2_init_cong_free_rtts_th;
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_EXT_TLV_REDUCE2_INIT_CONG_FREE_RTTS_TH_MASK 0x3ffUL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_EXT_TLV_REDUCE2_INIT_CONG_FREE_RTTS_TH_SFT 0
+	u8	reduce2_init_en;
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_EXT_TLV_REDUCE2_INIT_EN     0x1UL
+	u8	period_adjust_count;
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_EXT_TLV_PERIOD_ADJUST_COUNT_MASK 0xffUL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_EXT_TLV_PERIOD_ADJUST_COUNT_SFT 0
+	__le16	current_rate_threshold_1;
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_EXT_TLV_CURRENT_RATE_THRESHOLD_1_MASK 0x3fffUL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_EXT_TLV_CURRENT_RATE_THRESHOLD_1_SFT 0
+	__le16	current_rate_threshold_2;
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_EXT_TLV_CURRENT_RATE_THRESHOLD_2_MASK 0x3fffUL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_EXT_TLV_CURRENT_RATE_THRESHOLD_2_SFT 0
+	u8	rate_table_idx;
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_EXT_TLV_RATE_TABLE_IDX_MASK 0xffUL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_EXT_TLV_RATE_TABLE_IDX_SFT 0
+	u8	rate_table_quota_period;
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_EXT_TLV_RATE_TABLE_QUOTA_PERIOD_MASK 0xffUL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_EXT_TLV_RATE_TABLE_QUOTA_PERIOD_SFT 0
+	__le16	rate_table_byte_quota;
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_EXT_TLV_RATE_TABLE_BYTE_QUOTA_MASK 0xffffUL
+	#define CMDQ_MODIFY_ROCE_CC_GEN1_EXT_TLV_RATE_TABLE_BYTE_QUOTA_SFT 0
+	__le64	reserved64_1;
+};
+
+/* cmdq_modify_roce_cc_gen2_ext_tlv (size:384b/48B) */
+struct cmdq_modify_roce_cc_gen2_ext_tlv {
+	__le16	cmd_discr;
+	u8	reserved_8b;
+	u8	tlv_flags;
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_EXT_TLV_TLV_FLAGS_MORE         0x1UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_EXT_TLV_TLV_FLAGS_MORE_LAST      0x0UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_EXT_TLV_TLV_FLAGS_MORE_NOT_LAST  0x1UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_EXT_TLV_TLV_FLAGS_REQUIRED     0x2UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_EXT_TLV_TLV_FLAGS_REQUIRED_NO    (0x0UL << 1)
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_EXT_TLV_TLV_FLAGS_REQUIRED_YES   (0x1UL << 1)
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_EXT_TLV_TLV_FLAGS_REQUIRED_LAST CMDQ_MODIFY_ROCE_CC_GEN2_EXT_TLV_TLV_FLAGS_REQUIRED_YES
+	__le16	tlv_type;
+	__le16	length;
+	__le64	reserved64;
+	__le64	modify_mask;
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_EXT_TLV_MODIFY_MASK_CR2BW_64B_RATIO            0x1UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_EXT_TLV_MODIFY_MASK_SR2_CC_FIRST_CNP_EN        0x2UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_EXT_TLV_MODIFY_MASK_SR2_CC_ACTUAL_CR_EN        0x4UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_EXT_TLV_MODIFY_MASK_RETX_CP                    0x8UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_EXT_TLV_MODIFY_MASK_RETX_CR                    0x10UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_EXT_TLV_MODIFY_MASK_RETX_TR                    0x20UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_EXT_TLV_MODIFY_MASK_HW_RETX_CC_RESET_EN        0x40UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_EXT_TLV_MODIFY_MASK_HW_RETX_RESET_CC_CR_TH     0x80UL
+	__le64	reserved64_1;
+	__le16	cr2bw_64b_ratio;
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_EXT_TLV_CR2BW_64B_RATIO_MASK 0x3ffUL
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_EXT_TLV_CR2BW_64B_RATIO_SFT 0
+	u8	sr2_cc_first_cnp_en;
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_EXT_TLV_SR2_CC_FIRST_CNP_EN     0x1UL
+	u8	sr2_cc_actual_cr_en;
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_EXT_TLV_SR2_CC_ACTUAL_CR_EN     0x1UL
+	__le16	retx_cp;
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_EXT_TLV_RETX_CP_MASK 0x3ffUL
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_EXT_TLV_RETX_CP_SFT 0
+	__le16	retx_cr;
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_EXT_TLV_RETX_CR_MASK 0x3fffUL
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_EXT_TLV_RETX_CR_SFT 0
+	__le16	retx_tr;
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_EXT_TLV_RETX_TR_MASK 0x3fffUL
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_EXT_TLV_RETX_TR_SFT 0
+	u8	hw_retx_cc_reset_en;
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_EXT_TLV_ACK_TIMEOUT_EN          0x1UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_EXT_TLV_RX_NAK_EN               0x2UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_EXT_TLV_RX_RNR_NAK_EN           0x4UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_EXT_TLV_MISSING_RESPONSE_EN     0x8UL
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_EXT_TLV_DUPLICATE_READ_EN       0x10UL
+	u8	reserved8;
+	__le16	hw_retx_reset_cc_cr_th;
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_EXT_TLV_HW_RETX_RESET_CC_CR_TH_MASK 0x3fffUL
+	#define CMDQ_MODIFY_ROCE_CC_GEN2_EXT_TLV_HW_RETX_RESET_CC_CR_TH_SFT 0
+	__le16	reserved16;
+};
+
+/* creq_modify_roce_cc_resp (size:128b/16B) */
+struct creq_modify_roce_cc_resp {
+	u8	type;
+	#define CREQ_MODIFY_ROCE_CC_RESP_TYPE_MASK    0x3fUL
+	#define CREQ_MODIFY_ROCE_CC_RESP_TYPE_SFT     0
+	#define CREQ_MODIFY_ROCE_CC_RESP_TYPE_QP_EVENT  0x38UL
+	#define CREQ_MODIFY_ROCE_CC_RESP_TYPE_LAST     CREQ_MODIFY_ROCE_CC_RESP_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	reserved32;
+	u8	v;
+	#define CREQ_MODIFY_ROCE_CC_RESP_V     0x1UL
+	u8	event;
+	#define CREQ_MODIFY_ROCE_CC_RESP_EVENT_MODIFY_ROCE_CC 0x8cUL
+	#define CREQ_MODIFY_ROCE_CC_RESP_EVENT_LAST          CREQ_MODIFY_ROCE_CC_RESP_EVENT_MODIFY_ROCE_CC
+	u8	reserved48[6];
+};
+
+/* cmdq_set_link_aggr_mode_cc (size:320b/40B) */
+struct cmdq_set_link_aggr_mode_cc {
+	u8	opcode;
+	#define CMDQ_SET_LINK_AGGR_MODE_OPCODE_SET_LINK_AGGR_MODE 0x8fUL
+	#define CMDQ_SET_LINK_AGGR_MODE_OPCODE_LAST              CMDQ_SET_LINK_AGGR_MODE_OPCODE_SET_LINK_AGGR_MODE
+	u8	cmd_size;
+	__le16	flags;
+	__le16	cookie;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	resp_addr;
+	__le32	modify_mask;
+	#define CMDQ_SET_LINK_AGGR_MODE_MODIFY_MASK_AGGR_EN             0x1UL
+	#define CMDQ_SET_LINK_AGGR_MODE_MODIFY_MASK_ACTIVE_PORT_MAP     0x2UL
+	#define CMDQ_SET_LINK_AGGR_MODE_MODIFY_MASK_MEMBER_PORT_MAP     0x4UL
+	#define CMDQ_SET_LINK_AGGR_MODE_MODIFY_MASK_AGGR_MODE           0x8UL
+	#define CMDQ_SET_LINK_AGGR_MODE_MODIFY_MASK_STAT_CTX_ID         0x10UL
+	u8	aggr_enable;
+	#define CMDQ_SET_LINK_AGGR_MODE_AGGR_ENABLE     0x1UL
+	#define CMDQ_SET_LINK_AGGR_MODE_RSVD1_MASK      0xfeUL
+	#define CMDQ_SET_LINK_AGGR_MODE_RSVD1_SFT       1
+	u8	active_port_map;
+	#define CMDQ_SET_LINK_AGGR_MODE_ACTIVE_PORT_MAP_MASK 0xfUL
+	#define CMDQ_SET_LINK_AGGR_MODE_ACTIVE_PORT_MAP_SFT 0
+	#define CMDQ_SET_LINK_AGGR_MODE_RSVD2_MASK          0xf0UL
+	#define CMDQ_SET_LINK_AGGR_MODE_RSVD2_SFT           4
+	u8	member_port_map;
+	u8	link_aggr_mode;
+	#define CMDQ_SET_LINK_AGGR_MODE_AGGR_MODE_ACTIVE_ACTIVE 0x1UL
+	#define CMDQ_SET_LINK_AGGR_MODE_AGGR_MODE_ACTIVE_BACKUP 0x2UL
+	#define CMDQ_SET_LINK_AGGR_MODE_AGGR_MODE_BALANCE_XOR   0x3UL
+	#define CMDQ_SET_LINK_AGGR_MODE_AGGR_MODE_802_3_AD      0x4UL
+	#define CMDQ_SET_LINK_AGGR_MODE_AGGR_MODE_LAST         CMDQ_SET_LINK_AGGR_MODE_AGGR_MODE_802_3_AD
+	__le16	stat_ctx_id[4];
+	__le64	rsvd1;
+};
+
+/* creq_set_link_aggr_mode_resources_resp (size:128b/16B) */
+struct creq_set_link_aggr_mode_resources_resp {
+	u8	type;
+	#define CREQ_SET_LINK_AGGR_MODE_RESP_TYPE_MASK    0x3fUL
+	#define CREQ_SET_LINK_AGGR_MODE_RESP_TYPE_SFT     0
+	#define CREQ_SET_LINK_AGGR_MODE_RESP_TYPE_QP_EVENT  0x38UL
+	#define CREQ_SET_LINK_AGGR_MODE_RESP_TYPE_LAST     CREQ_SET_LINK_AGGR_MODE_RESP_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	reserved32;
+	u8	v;
+	#define CREQ_SET_LINK_AGGR_MODE_RESP_V     0x1UL
+	u8	event;
+	#define CREQ_SET_LINK_AGGR_MODE_RESP_EVENT_SET_LINK_AGGR_MODE 0x8fUL
+	#define CREQ_SET_LINK_AGGR_MODE_RESP_EVENT_LAST              CREQ_SET_LINK_AGGR_MODE_RESP_EVENT_SET_LINK_AGGR_MODE
+	u8	reserved48[6];
+};
+
+/* cmdq_allocate_roce_stats_ext_ctx (size:256b/32B) */
+struct cmdq_allocate_roce_stats_ext_ctx {
+	u8	opcode;
+	#define CMDQ_ALLOCATE_ROCE_STATS_EXT_CTX_OPCODE_ALLOCATE_ROCE_STATS_EXT_CTX 0x96UL
+	#define CMDQ_ALLOCATE_ROCE_STATS_EXT_CTX_OPCODE_LAST                       CMDQ_ALLOCATE_ROCE_STATS_EXT_CTX_OPCODE_ALLOCATE_ROCE_STATS_EXT_CTX
+	u8	cmd_size;
+	__le16	flags;
+	#define CMDQ_ALLOCATE_ROCE_STATS_EXT_CTX_FLAGS_PER_FUNC     0x1UL
+	__le16	cookie;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	resp_addr;
+	__le64	stats_dma_addr;
+	__le32	update_period_ms;
+	__le16	steering_tag;
+	__le16	reserved16;
+};
+
+/* creq_allocate_roce_stats_ext_ctx_resp (size:128b/16B) */
+struct creq_allocate_roce_stats_ext_ctx_resp {
+	u8	type;
+	#define CREQ_ALLOCATE_ROCE_STATS_EXT_CTX_RESP_TYPE_MASK    0x3fUL
+	#define CREQ_ALLOCATE_ROCE_STATS_EXT_CTX_RESP_TYPE_SFT     0
+	#define CREQ_ALLOCATE_ROCE_STATS_EXT_CTX_RESP_TYPE_QP_EVENT  0x38UL
+	#define CREQ_ALLOCATE_ROCE_STATS_EXT_CTX_RESP_TYPE_LAST     CREQ_ALLOCATE_ROCE_STATS_EXT_CTX_RESP_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	roce_stats_ext_xid;
+	u8	v;
+	#define CREQ_ALLOCATE_ROCE_STATS_EXT_CTX_RESP_V     0x1UL
+	u8	event;
+	#define CREQ_ALLOCATE_ROCE_STATS_EXT_CTX_RESP_EVENT_ALLOCATE_ROCE_STATS_EXT_CTX 0x96UL
+	#define CREQ_ALLOCATE_ROCE_STATS_EXT_CTX_RESP_EVENT_LAST                       CREQ_ALLOCATE_ROCE_STATS_EXT_CTX_RESP_EVENT_ALLOCATE_ROCE_STATS_EXT_CTX
+	u8	reserved48[6];
+};
+
+/* cmdq_deallocate_roce_stats_ext_ctx (size:256b/32B) */
+struct cmdq_deallocate_roce_stats_ext_ctx {
+	u8	opcode;
+	#define CMDQ_DEALLOCATE_ROCE_STATS_EXT_CTX_OPCODE_DEALLOCATE_ROCE_STATS_EXT_CTX 0x97UL
+	#define CMDQ_DEALLOCATE_ROCE_STATS_EXT_CTX_OPCODE_LAST                         CMDQ_DEALLOCATE_ROCE_STATS_EXT_CTX_OPCODE_DEALLOCATE_ROCE_STATS_EXT_CTX
+	u8	cmd_size;
+	__le16	flags;
+	__le16	cookie;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	resp_addr;
+	__le32	roce_stats_ext_xid;
+	__le32	reserved32;
+	__le64	reserved64;
+};
+
+/* creq_deallocate_roce_stats_ext_ctx_resp (size:128b/16B) */
+struct creq_deallocate_roce_stats_ext_ctx_resp {
+	u8	type;
+	#define CREQ_DEALLOCATE_ROCE_STATS_EXT_CTX_RESP_TYPE_MASK    0x3fUL
+	#define CREQ_DEALLOCATE_ROCE_STATS_EXT_CTX_RESP_TYPE_SFT     0
+	#define CREQ_DEALLOCATE_ROCE_STATS_EXT_CTX_RESP_TYPE_QP_EVENT  0x38UL
+	#define CREQ_DEALLOCATE_ROCE_STATS_EXT_CTX_RESP_TYPE_LAST     CREQ_DEALLOCATE_ROCE_STATS_EXT_CTX_RESP_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	roce_stats_ext_xid;
+	u8	v;
+	#define CREQ_DEALLOCATE_ROCE_STATS_EXT_CTX_RESP_V     0x1UL
+	u8	event;
+	#define CREQ_DEALLOCATE_ROCE_STATS_EXT_CTX_RESP_EVENT_DEALLOCATE_ROCE_STATS_EXT_CTX 0x97UL
+	#define CREQ_DEALLOCATE_ROCE_STATS_EXT_CTX_RESP_EVENT_LAST                         CREQ_DEALLOCATE_ROCE_STATS_EXT_CTX_RESP_EVENT_DEALLOCATE_ROCE_STATS_EXT_CTX
+	u8	reserved48[6];
+};
+
+/* cmdq_query_roce_stats_ext_v2 (size:256b/32B) */
+struct cmdq_query_roce_stats_ext_v2 {
+	u8	opcode;
+	#define CMDQ_QUERY_ROCE_STATS_EXT_V2_OPCODE_QUERY_ROCE_STATS_EXT_V2 0x98UL
+	#define CMDQ_QUERY_ROCE_STATS_EXT_V2_OPCODE_LAST                   CMDQ_QUERY_ROCE_STATS_EXT_V2_OPCODE_QUERY_ROCE_STATS_EXT_V2
+	u8	cmd_size;
+	__le16	flags;
+	__le16	cookie;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	resp_addr;
+	__le32	roce_stats_ext_xid;
+	__le32	reserved32;
+	__le64	reserved64;
+};
+
+/* creq_query_roce_stats_ext_v2_resp (size:128b/16B) */
+struct creq_query_roce_stats_ext_v2_resp {
+	u8	type;
+	#define CREQ_QUERY_ROCE_STATS_EXT_V2_RESP_TYPE_MASK    0x3fUL
+	#define CREQ_QUERY_ROCE_STATS_EXT_V2_RESP_TYPE_SFT     0
+	#define CREQ_QUERY_ROCE_STATS_EXT_V2_RESP_TYPE_QP_EVENT  0x38UL
+	#define CREQ_QUERY_ROCE_STATS_EXT_V2_RESP_TYPE_LAST     CREQ_QUERY_ROCE_STATS_EXT_V2_RESP_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	size;
+	u8	v;
+	#define CREQ_QUERY_ROCE_STATS_EXT_V2_RESP_V     0x1UL
+	u8	event;
+	#define CREQ_QUERY_ROCE_STATS_EXT_V2_RESP_EVENT_QUERY_ROCE_STATS_EXT_V2 0x98UL
+	#define CREQ_QUERY_ROCE_STATS_EXT_V2_RESP_EVENT_LAST                   CREQ_QUERY_ROCE_STATS_EXT_V2_RESP_EVENT_QUERY_ROCE_STATS_EXT_V2
+	u8	reserved48[6];
+};
+
+/* creq_query_roce_stats_ext_v2_resp_sb (size:2304b/288B) */
+struct creq_query_roce_stats_ext_v2_resp_sb {
+	u8	opcode;
+	#define CREQ_QUERY_ROCE_STATS_EXT_V2_RESP_SB_OPCODE_QUERY_ROCE_STATS_EXT_V2 0x98UL
+	#define CREQ_QUERY_ROCE_STATS_EXT_V2_RESP_SB_OPCODE_LAST                   CREQ_QUERY_ROCE_STATS_EXT_V2_RESP_SB_OPCODE_QUERY_ROCE_STATS_EXT_V2
+	u8	status;
+	__le16	cookie;
+	__le16	flags;
+	#define CREQ_QUERY_ROCE_STATS_EXT_V2_RESP_SB_TS_VALID     0x1UL
+	#define CREQ_QUERY_ROCE_STATS_EXT_V2_RESP_SB_RSVD_MASK    0xfffeUL
+	#define CREQ_QUERY_ROCE_STATS_EXT_V2_RESP_SB_RSVD_SFT     1
+	u8	resp_size;
+	u8	offset;
+	__le64	timestamp;
+	__le32	rsvd[8];
+	__le64	tx_atomic_req_pkts;
+	__le64	tx_read_req_pkts;
+	__le64	tx_read_res_pkts;
+	__le64	tx_write_req_pkts;
+	__le64	tx_rc_send_req_pkts;
+	__le64	tx_ud_send_req_pkts;
+	__le64	tx_cnp_pkts;
+	__le64	tx_roce_pkts;
+	__le64	tx_roce_bytes;
+	__le64	rx_out_of_buffer_pkts;
+	__le64	rx_out_of_sequence_pkts;
+	__le64	dup_req;
+	__le64	missing_resp;
+	__le64	seq_err_naks_rcvd;
+	__le64	rnr_naks_rcvd;
+	__le64	to_retransmits;
+	__le64	rx_atomic_req_pkts;
+	__le64	rx_read_req_pkts;
+	__le64	rx_read_res_pkts;
+	__le64	rx_write_req_pkts;
+	__le64	rx_rc_send_pkts;
+	__le64	rx_ud_send_pkts;
+	__le64	rx_dcn_payload_cut;
+	__le64	rx_ecn_marked_pkts;
+	__le64	rx_cnp_pkts;
+	__le64	rx_roce_pkts;
+	__le64	rx_roce_bytes;
+	__le64	rx_roce_good_pkts;
+	__le64	rx_roce_good_bytes;
+	__le64	rx_ack_pkts;
+};
+
+/* cmdq_roce_mirror_cfg (size:192b/24B) */
+struct cmdq_roce_mirror_cfg {
+	u8	opcode;
+	#define CMDQ_ROCE_MIRROR_CFG_OPCODE_ROCE_MIRROR_CFG 0xa6UL
+	#define CMDQ_ROCE_MIRROR_CFG_OPCODE_LAST           CMDQ_ROCE_MIRROR_CFG_OPCODE_ROCE_MIRROR_CFG
+	u8	cmd_size;
+	__le16	flags;
+	__le16	cookie;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	resp_addr;
+	u8	mirror_flags;
+	#define CMDQ_ROCE_MIRROR_CFG_MIRROR_ENABLE     0x1UL
+	u8	rsvd[7];
+};
+
+/* creq_roce_mirror_cfg_resp (size:128b/16B) */
+struct creq_roce_mirror_cfg_resp {
+	u8	type;
+	#define CREQ_ROCE_MIRROR_CFG_RESP_TYPE_MASK    0x3fUL
+	#define CREQ_ROCE_MIRROR_CFG_RESP_TYPE_SFT     0
+	#define CREQ_ROCE_MIRROR_CFG_RESP_TYPE_QP_EVENT  0x38UL
+	#define CREQ_ROCE_MIRROR_CFG_RESP_TYPE_LAST     CREQ_ROCE_MIRROR_CFG_RESP_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	reserved32;
+	u8	v;
+	#define CREQ_ROCE_MIRROR_CFG_RESP_V     0x1UL
+	u8	event;
+	#define CREQ_ROCE_MIRROR_CFG_RESP_EVENT_ROCE_MIRROR_CFG 0xa6UL
+	#define CREQ_ROCE_MIRROR_CFG_RESP_EVENT_LAST           CREQ_ROCE_MIRROR_CFG_RESP_EVENT_ROCE_MIRROR_CFG
+	u8	reserved48[6];
+};
+
+/* cmdq_roce_cfg (size:192b/24B) */
+struct cmdq_roce_cfg {
+	u8	opcode;
+	#define CMDQ_ROCE_CFG_OPCODE_ROCE_CFG 0xa7UL
+	#define CMDQ_ROCE_CFG_OPCODE_LAST    CMDQ_ROCE_CFG_OPCODE_ROCE_CFG
+	u8	cmd_size;
+	__le16	flags;
+	__le16	cookie;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	resp_addr;
+	__le32	feat_cfg;
+	#define CMDQ_ROCE_CFG_FEAT_CFG_ICRC_CHECK_DISABLE      0x1UL
+	#define CMDQ_ROCE_CFG_FEAT_CFG_FORCE_MIRROR_ENABLE     0x2UL
+	#define CMDQ_ROCE_CFG_FEAT_CFG_RSVD_MASK               0xfffffffcUL
+	#define CMDQ_ROCE_CFG_FEAT_CFG_RSVD_SFT                2
+	__le32	feat_enables;
+	#define CMDQ_ROCE_CFG_FEAT_ENABLES_ICRC_CHECK_DISABLE      0x1UL
+	#define CMDQ_ROCE_CFG_FEAT_ENABLES_FORCE_MIRROR_ENABLE     0x2UL
+	#define CMDQ_ROCE_CFG_FEAT_ENABLES_RSVD_MASK               0xfffffffcUL
+	#define CMDQ_ROCE_CFG_FEAT_ENABLES_RSVD_SFT                2
+};
+
+/* creq_roce_cfg_resp (size:128b/16B) */
+struct creq_roce_cfg_resp {
+	u8	type;
+	#define CREQ_ROCE_CFG_RESP_TYPE_MASK    0x3fUL
+	#define CREQ_ROCE_CFG_RESP_TYPE_SFT     0
+	#define CREQ_ROCE_CFG_RESP_TYPE_QP_EVENT  0x38UL
+	#define CREQ_ROCE_CFG_RESP_TYPE_LAST     CREQ_ROCE_CFG_RESP_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	reserved04;
+	u8	v;
+	#define CREQ_ROCE_CFG_RESP_V     0x1UL
+	u8	event;
+	#define CREQ_ROCE_CFG_RESP_EVENT_ROCE_CFG 0xa7UL
+	#define CREQ_ROCE_CFG_RESP_EVENT_LAST    CREQ_ROCE_CFG_RESP_EVENT_ROCE_CFG
+	__le16	reserved0A;
+	__le32	feat_cfg_cur;
+	#define CREQ_ROCE_CFG_RESP_ICRC_CHECK_DISABLED     0x1UL
+	#define CREQ_ROCE_CFG_RESP_FORCE_MIRROR_ENABLE     0x2UL
+	#define CREQ_ROCE_CFG_RESP_RSVD_MASK               0xfffffffcUL
+	#define CREQ_ROCE_CFG_RESP_RSVD_SFT                2
+};
+
+/* creq_func_event (size:128b/16B) */
+struct creq_func_event {
+	u8	type;
+	#define CREQ_FUNC_EVENT_TYPE_MASK      0x3fUL
+	#define CREQ_FUNC_EVENT_TYPE_SFT       0
+	#define CREQ_FUNC_EVENT_TYPE_FUNC_EVENT  0x3aUL
+	#define CREQ_FUNC_EVENT_TYPE_LAST       CREQ_FUNC_EVENT_TYPE_FUNC_EVENT
+	u8	reserved56[7];
+	u8	v;
+	#define CREQ_FUNC_EVENT_V     0x1UL
+	u8	event;
+	#define CREQ_FUNC_EVENT_EVENT_TX_WQE_ERROR       0x1UL
+	#define CREQ_FUNC_EVENT_EVENT_TX_DATA_ERROR      0x2UL
+	#define CREQ_FUNC_EVENT_EVENT_RX_WQE_ERROR       0x3UL
+	#define CREQ_FUNC_EVENT_EVENT_RX_DATA_ERROR      0x4UL
+	#define CREQ_FUNC_EVENT_EVENT_CQ_ERROR           0x5UL
+	#define CREQ_FUNC_EVENT_EVENT_TQM_ERROR          0x6UL
+	#define CREQ_FUNC_EVENT_EVENT_CFCQ_ERROR         0x7UL
+	#define CREQ_FUNC_EVENT_EVENT_CFCS_ERROR         0x8UL
+	#define CREQ_FUNC_EVENT_EVENT_CFCC_ERROR         0x9UL
+	#define CREQ_FUNC_EVENT_EVENT_CFCM_ERROR         0xaUL
+	#define CREQ_FUNC_EVENT_EVENT_TIM_ERROR          0xbUL
+	#define CREQ_FUNC_EVENT_EVENT_VF_COMM_REQUEST    0x80UL
+	#define CREQ_FUNC_EVENT_EVENT_RESOURCE_EXHAUSTED 0x81UL
+	#define CREQ_FUNC_EVENT_EVENT_LAST              CREQ_FUNC_EVENT_EVENT_RESOURCE_EXHAUSTED
+	u8	reserved48[6];
+};
+
+/* creq_qp_event (size:128b/16B) */
+struct creq_qp_event {
+	u8	type;
+	#define CREQ_QP_EVENT_TYPE_MASK    0x3fUL
+	#define CREQ_QP_EVENT_TYPE_SFT     0
+	#define CREQ_QP_EVENT_TYPE_QP_EVENT  0x38UL
+	#define CREQ_QP_EVENT_TYPE_LAST     CREQ_QP_EVENT_TYPE_QP_EVENT
+	u8	status;
+	#define CREQ_QP_EVENT_STATUS_SUCCESS           0x0UL
+	#define CREQ_QP_EVENT_STATUS_FAIL              0x1UL
+	#define CREQ_QP_EVENT_STATUS_RESOURCES         0x2UL
+	#define CREQ_QP_EVENT_STATUS_INVALID_CMD       0x3UL
+	#define CREQ_QP_EVENT_STATUS_NOT_IMPLEMENTED   0x4UL
+	#define CREQ_QP_EVENT_STATUS_INVALID_PARAMETER 0x5UL
+	#define CREQ_QP_EVENT_STATUS_HARDWARE_ERROR    0x6UL
+	#define CREQ_QP_EVENT_STATUS_INTERNAL_ERROR    0x7UL
+	#define CREQ_QP_EVENT_STATUS_LAST             CREQ_QP_EVENT_STATUS_INTERNAL_ERROR
+	__le16	cookie;
+	__le32	reserved32;
+	u8	v;
+	#define CREQ_QP_EVENT_V     0x1UL
+	u8	event;
+	#define CREQ_QP_EVENT_EVENT_CREATE_QP                   0x1UL
+	#define CREQ_QP_EVENT_EVENT_DESTROY_QP                  0x2UL
+	#define CREQ_QP_EVENT_EVENT_MODIFY_QP                   0x3UL
+	#define CREQ_QP_EVENT_EVENT_QUERY_QP                    0x4UL
+	#define CREQ_QP_EVENT_EVENT_CREATE_SRQ                  0x5UL
+	#define CREQ_QP_EVENT_EVENT_DESTROY_SRQ                 0x6UL
+	#define CREQ_QP_EVENT_EVENT_QUERY_SRQ                   0x8UL
+	#define CREQ_QP_EVENT_EVENT_CREATE_CQ                   0x9UL
+	#define CREQ_QP_EVENT_EVENT_DESTROY_CQ                  0xaUL
+	#define CREQ_QP_EVENT_EVENT_RESIZE_CQ                   0xcUL
+	#define CREQ_QP_EVENT_EVENT_ALLOCATE_MRW                0xdUL
+	#define CREQ_QP_EVENT_EVENT_DEALLOCATE_KEY              0xeUL
+	#define CREQ_QP_EVENT_EVENT_REGISTER_MR                 0xfUL
+	#define CREQ_QP_EVENT_EVENT_DEREGISTER_MR               0x10UL
+	#define CREQ_QP_EVENT_EVENT_ADD_GID                     0x11UL
+	#define CREQ_QP_EVENT_EVENT_DELETE_GID                  0x12UL
+	#define CREQ_QP_EVENT_EVENT_MODIFY_GID                  0x17UL
+	#define CREQ_QP_EVENT_EVENT_QUERY_GID                   0x18UL
+	#define CREQ_QP_EVENT_EVENT_CREATE_QP1                  0x13UL
+	#define CREQ_QP_EVENT_EVENT_DESTROY_QP1                 0x14UL
+	#define CREQ_QP_EVENT_EVENT_CREATE_AH                   0x15UL
+	#define CREQ_QP_EVENT_EVENT_DESTROY_AH                  0x16UL
+	#define CREQ_QP_EVENT_EVENT_INITIALIZE_FW               0x80UL
+	#define CREQ_QP_EVENT_EVENT_DEINITIALIZE_FW             0x81UL
+	#define CREQ_QP_EVENT_EVENT_STOP_FUNC                   0x82UL
+	#define CREQ_QP_EVENT_EVENT_QUERY_FUNC                  0x83UL
+	#define CREQ_QP_EVENT_EVENT_SET_FUNC_RESOURCES          0x84UL
+	#define CREQ_QP_EVENT_EVENT_READ_CONTEXT                0x85UL
+	#define CREQ_QP_EVENT_EVENT_MAP_TC_TO_COS               0x8aUL
+	#define CREQ_QP_EVENT_EVENT_QUERY_VERSION               0x8bUL
+	#define CREQ_QP_EVENT_EVENT_MODIFY_CC                   0x8cUL
+	#define CREQ_QP_EVENT_EVENT_QUERY_CC                    0x8dUL
+	#define CREQ_QP_EVENT_EVENT_QUERY_ROCE_STATS            0x8eUL
+	#define CREQ_QP_EVENT_EVENT_SET_LINK_AGGR_MODE          0x8fUL
+	#define CREQ_QP_EVENT_EVENT_QUERY_QP_EXTEND             0x91UL
+	#define CREQ_QP_EVENT_EVENT_PNO_STATS_CONFIG            0x99UL
+	#define CREQ_QP_EVENT_EVENT_PNO_DEBUG_TUNNEL_CONFIG     0x9aUL
+	#define CREQ_QP_EVENT_EVENT_SET_PNO_FABRIC_NEXTHOP_MAC  0x9bUL
+	#define CREQ_QP_EVENT_EVENT_PNO_PATH_STRPATH_CONFIG     0x9cUL
+	#define CREQ_QP_EVENT_EVENT_PNO_PATH_QUERY              0x9dUL
+	#define CREQ_QP_EVENT_EVENT_PNO_PATH_ACCESS_CONTROL     0x9eUL
+	#define CREQ_QP_EVENT_EVENT_QUERY_PNO_FABRIC_NEXTHOP_IP 0x9fUL
+	#define CREQ_QP_EVENT_EVENT_PNO_PATH_PLANE_CONFIG       0xa0UL
+	#define CREQ_QP_EVENT_EVENT_PNO_TUNNEL_CLOSE            0xa1UL
+	#define CREQ_QP_EVENT_EVENT_ROCE_MIRROR_CFG             0xa6UL
+	#define CREQ_QP_EVENT_EVENT_ROCE_CFG                    0xa7UL
+	#define CREQ_QP_EVENT_EVENT_PNO_EV_MONITORING_CONFIG    0xa8UL
+	#define CREQ_QP_EVENT_EVENT_QP_ERROR_NOTIFICATION       0xc0UL
+	#define CREQ_QP_EVENT_EVENT_CQ_ERROR_NOTIFICATION       0xc1UL
+	#define CREQ_QP_EVENT_EVENT_LAST                       CREQ_QP_EVENT_EVENT_CQ_ERROR_NOTIFICATION
+	u8	reserved48[6];
+};
+
+/* creq_qp_error_notification (size:128b/16B) */
+struct creq_qp_error_notification {
+	u8	type;
+	#define CREQ_QP_ERROR_NOTIFICATION_TYPE_MASK    0x3fUL
+	#define CREQ_QP_ERROR_NOTIFICATION_TYPE_SFT     0
+	#define CREQ_QP_ERROR_NOTIFICATION_TYPE_QP_EVENT  0x38UL
+	#define CREQ_QP_ERROR_NOTIFICATION_TYPE_LAST     CREQ_QP_ERROR_NOTIFICATION_TYPE_QP_EVENT
+	u8	status;
+	u8	req_slow_path_state;
+	u8	req_err_state_reason;
+	#define CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_NO_ERROR                    0x0UL
+	#define CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_OPCODE_ERROR            0x1UL
+	#define CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_TIMEOUT_RETRY_LIMIT     0x2UL
+	#define CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_RNR_TIMEOUT_RETRY_LIMIT 0x3UL
+	#define CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_NAK_ARRIVAL_1           0x4UL
+	#define CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_NAK_ARRIVAL_2           0x5UL
+	#define CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_NAK_ARRIVAL_3           0x6UL
+	#define CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_NAK_ARRIVAL_4           0x7UL
+	#define CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_RX_MEMORY_ERROR         0x8UL
+	#define CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_TX_MEMORY_ERROR         0x9UL
+	#define CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_READ_RESP_LENGTH        0xaUL
+	#define CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_INVALID_READ_RESP       0xbUL
+	#define CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_ILLEGAL_BIND            0xcUL
+	#define CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_ILLEGAL_FAST_REG        0xdUL
+	#define CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_ILLEGAL_INVALIDATE      0xeUL
+	#define CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_CMP_ERROR               0xfUL
+	#define CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_RETRAN_LOCAL_ERROR      0x10UL
+	#define CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_WQE_FORMAT_ERROR        0x11UL
+	#define CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_ORRQ_FORMAT_ERROR       0x12UL
+	#define CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_INVALID_AVID_ERROR      0x13UL
+	#define CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_AV_DOMAIN_ERROR         0x14UL
+	#define CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_CQ_LOAD_ERROR           0x15UL
+	#define CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_SERV_TYPE_ERROR         0x16UL
+	#define CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_INVALID_OP_ERROR        0x17UL
+	#define CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_TX_PCI_ERROR            0x18UL
+	#define CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_RX_PCI_ERROR            0x19UL
+	#define CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_PROD_WQE_MSMTCH_ERROR   0x1aUL
+	#define CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_PSN_RANGE_CHECK_ERROR   0x1bUL
+	#define CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_RETX_SETUP_ERROR        0x1cUL
+	#define CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_SQ_OVERFLOW             0x1dUL
+	#define CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_LAST                       CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_SQ_OVERFLOW
+	__le32	xid;
+	u8	v;
+	#define CREQ_QP_ERROR_NOTIFICATION_V     0x1UL
+	u8	event;
+	#define CREQ_QP_ERROR_NOTIFICATION_EVENT_QP_ERROR_NOTIFICATION 0xc0UL
+	#define CREQ_QP_ERROR_NOTIFICATION_EVENT_LAST                 CREQ_QP_ERROR_NOTIFICATION_EVENT_QP_ERROR_NOTIFICATION
+	u8	res_slow_path_state;
+	u8	res_err_state_reason;
+	#define CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_NO_ERROR                      0x0UL
+	#define CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_EXCEED_MAX                0x1UL
+	#define CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_PAYLOAD_LENGTH_MISMATCH   0x2UL
+	#define CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_EXCEEDS_WQE               0x3UL
+	#define CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_OPCODE_ERROR              0x4UL
+	#define CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_PSN_SEQ_ERROR_RETRY_LIMIT 0x5UL
+	#define CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_RX_INVALID_R_KEY          0x6UL
+	#define CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_RX_DOMAIN_ERROR           0x7UL
+	#define CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_RX_NO_PERMISSION          0x8UL
+	#define CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_RX_RANGE_ERROR            0x9UL
+	#define CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_TX_INVALID_R_KEY          0xaUL
+	#define CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_TX_DOMAIN_ERROR           0xbUL
+	#define CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_TX_NO_PERMISSION          0xcUL
+	#define CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_TX_RANGE_ERROR            0xdUL
+	#define CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_IRRQ_OFLOW                0xeUL
+	#define CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_UNSUPPORTED_OPCODE        0xfUL
+	#define CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_UNALIGN_ATOMIC            0x10UL
+	#define CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_REM_INVALIDATE            0x11UL
+	#define CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_MEMORY_ERROR              0x12UL
+	#define CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_SRQ_ERROR                 0x13UL
+	#define CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_CMP_ERROR                 0x14UL
+	#define CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_INVALID_DUP_RKEY          0x15UL
+	#define CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_WQE_FORMAT_ERROR          0x16UL
+	#define CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_IRRQ_FORMAT_ERROR         0x17UL
+	#define CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_CQ_LOAD_ERROR             0x18UL
+	#define CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_SRQ_LOAD_ERROR            0x19UL
+	#define CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_TX_PCI_ERROR              0x1bUL
+	#define CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_RX_PCI_ERROR              0x1cUL
+	#define CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_PSN_NOT_FOUND             0x1dUL
+	#define CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_RQ_OVERFLOW               0x1eUL
+	#define CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_LAST                         CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_RQ_OVERFLOW
+	__le16	sq_cons_idx;
+	__le16	rq_cons_idx;
+};
+
+/* creq_cq_error_notification (size:128b/16B) */
+struct creq_cq_error_notification {
+	u8	type;
+	#define CREQ_CQ_ERROR_NOTIFICATION_TYPE_MASK    0x3fUL
+	#define CREQ_CQ_ERROR_NOTIFICATION_TYPE_SFT     0
+	#define CREQ_CQ_ERROR_NOTIFICATION_TYPE_CQ_EVENT  0x38UL
+	#define CREQ_CQ_ERROR_NOTIFICATION_TYPE_LAST     CREQ_CQ_ERROR_NOTIFICATION_TYPE_CQ_EVENT
+	u8	status;
+	u8	cq_err_reason;
+	#define CREQ_CQ_ERROR_NOTIFICATION_CQ_ERR_REASON_REQ_CQ_INVALID_ERROR  0x1UL
+	#define CREQ_CQ_ERROR_NOTIFICATION_CQ_ERR_REASON_REQ_CQ_OVERFLOW_ERROR 0x2UL
+	#define CREQ_CQ_ERROR_NOTIFICATION_CQ_ERR_REASON_REQ_CQ_LOAD_ERROR     0x3UL
+	#define CREQ_CQ_ERROR_NOTIFICATION_CQ_ERR_REASON_RES_CQ_INVALID_ERROR  0x4UL
+	#define CREQ_CQ_ERROR_NOTIFICATION_CQ_ERR_REASON_RES_CQ_OVERFLOW_ERROR 0x5UL
+	#define CREQ_CQ_ERROR_NOTIFICATION_CQ_ERR_REASON_RES_CQ_LOAD_ERROR     0x6UL
+	#define CREQ_CQ_ERROR_NOTIFICATION_CQ_ERR_REASON_LAST                 CREQ_CQ_ERROR_NOTIFICATION_CQ_ERR_REASON_RES_CQ_LOAD_ERROR
+	u8	reserved8;
+	__le32	xid;
+	u8	v;
+	#define CREQ_CQ_ERROR_NOTIFICATION_V     0x1UL
+	u8	event;
+	#define CREQ_CQ_ERROR_NOTIFICATION_EVENT_CQ_ERROR_NOTIFICATION 0xc1UL
+	#define CREQ_CQ_ERROR_NOTIFICATION_EVENT_LAST                 CREQ_CQ_ERROR_NOTIFICATION_EVENT_CQ_ERROR_NOTIFICATION
+	u8	reserved48[6];
+};
+
+/* sq_base (size:64b/8B) */
+struct sq_base {
+	u8	wqe_type;
+	#define SQ_BASE_WQE_TYPE_SEND                 0x0UL
+	#define SQ_BASE_WQE_TYPE_SEND_W_IMMEAD        0x1UL
+	#define SQ_BASE_WQE_TYPE_SEND_W_INVALID       0x2UL
+	#define SQ_BASE_WQE_TYPE_WRITE_WQE            0x4UL
+	#define SQ_BASE_WQE_TYPE_WRITE_W_IMMEAD       0x5UL
+	#define SQ_BASE_WQE_TYPE_READ_WQE             0x6UL
+	#define SQ_BASE_WQE_TYPE_ATOMIC_CS            0x8UL
+	#define SQ_BASE_WQE_TYPE_ATOMIC_FA            0xbUL
+	#define SQ_BASE_WQE_TYPE_LOCAL_INVALID        0xcUL
+	#define SQ_BASE_WQE_TYPE_FR_PMR               0xdUL
+	#define SQ_BASE_WQE_TYPE_BIND                 0xeUL
+	#define SQ_BASE_WQE_TYPE_FR_PPMR              0xfUL
+	#define SQ_BASE_WQE_TYPE_SEND_V3              0x10UL
+	#define SQ_BASE_WQE_TYPE_SEND_W_IMMED_V3      0x11UL
+	#define SQ_BASE_WQE_TYPE_SEND_W_INVALID_V3    0x12UL
+	#define SQ_BASE_WQE_TYPE_UDSEND_V3            0x13UL
+	#define SQ_BASE_WQE_TYPE_UDSEND_W_IMMED_V3    0x14UL
+	#define SQ_BASE_WQE_TYPE_WRITE_WQE_V3         0x15UL
+	#define SQ_BASE_WQE_TYPE_WRITE_W_IMMED_V3     0x16UL
+	#define SQ_BASE_WQE_TYPE_READ_WQE_V3          0x17UL
+	#define SQ_BASE_WQE_TYPE_ATOMIC_CS_V3         0x18UL
+	#define SQ_BASE_WQE_TYPE_ATOMIC_FA_V3         0x19UL
+	#define SQ_BASE_WQE_TYPE_LOCAL_INVALID_V3     0x1aUL
+	#define SQ_BASE_WQE_TYPE_FR_PMR_V3            0x1bUL
+	#define SQ_BASE_WQE_TYPE_BIND_V3              0x1cUL
+	#define SQ_BASE_WQE_TYPE_RAWQP1SEND_V3        0x1dUL
+	#define SQ_BASE_WQE_TYPE_CHANGE_UDPSRCPORT_V3 0x1eUL
+	#define SQ_BASE_WQE_TYPE_LAST                SQ_BASE_WQE_TYPE_CHANGE_UDPSRCPORT_V3
+	u8	unused_0[7];
+};
+
+/* sq_sge (size:128b/16B) */
+struct sq_sge {
+	__le64	va_or_pa;
+	__le32	l_key;
+	__le32	size;
+};
+
+/* sq_psn_search (size:64b/8B) */
+struct sq_psn_search {
+	__le32	opcode_start_psn;
+	#define SQ_PSN_SEARCH_START_PSN_MASK 0xffffffUL
+	#define SQ_PSN_SEARCH_START_PSN_SFT 0
+	#define SQ_PSN_SEARCH_OPCODE_MASK   0xff000000UL
+	#define SQ_PSN_SEARCH_OPCODE_SFT    24
+	__le32	flags_next_psn;
+	#define SQ_PSN_SEARCH_NEXT_PSN_MASK 0xffffffUL
+	#define SQ_PSN_SEARCH_NEXT_PSN_SFT 0
+	#define SQ_PSN_SEARCH_FLAGS_MASK   0xff000000UL
+	#define SQ_PSN_SEARCH_FLAGS_SFT    24
+};
+
+/* sq_psn_search_ext (size:128b/16B) */
+struct sq_psn_search_ext {
+	__le32	opcode_start_psn;
+	#define SQ_PSN_SEARCH_EXT_START_PSN_MASK 0xffffffUL
+	#define SQ_PSN_SEARCH_EXT_START_PSN_SFT 0
+	#define SQ_PSN_SEARCH_EXT_OPCODE_MASK   0xff000000UL
+	#define SQ_PSN_SEARCH_EXT_OPCODE_SFT    24
+	__le32	flags_next_psn;
+	#define SQ_PSN_SEARCH_EXT_NEXT_PSN_MASK 0xffffffUL
+	#define SQ_PSN_SEARCH_EXT_NEXT_PSN_SFT 0
+	#define SQ_PSN_SEARCH_EXT_FLAGS_MASK   0xff000000UL
+	#define SQ_PSN_SEARCH_EXT_FLAGS_SFT    24
+	__le16	start_slot_idx;
+	__le16	reserved16;
+	__le32	reserved32;
+};
+
+/* sq_msn_search (size:64b/8B) */
+struct sq_msn_search {
+	__le64	start_idx_next_psn_start_psn;
+	#define SQ_MSN_SEARCH_START_PSN_MASK 0xffffffUL
+	#define SQ_MSN_SEARCH_START_PSN_SFT 0
+	#define SQ_MSN_SEARCH_NEXT_PSN_MASK 0xffffff000000ULL
+	#define SQ_MSN_SEARCH_NEXT_PSN_SFT  24
+	#define SQ_MSN_SEARCH_START_IDX_MASK 0xffff000000000000ULL
+	#define SQ_MSN_SEARCH_START_IDX_SFT 48
+};
+
+/* sq_send (size:1024b/128B) */
+struct sq_send {
+	u8	wqe_type;
+	#define SQ_SEND_WQE_TYPE_SEND           0x0UL
+	#define SQ_SEND_WQE_TYPE_SEND_W_IMMEAD  0x1UL
+	#define SQ_SEND_WQE_TYPE_SEND_W_INVALID 0x2UL
+	#define SQ_SEND_WQE_TYPE_LAST          SQ_SEND_WQE_TYPE_SEND_W_INVALID
+	u8	flags;
+	#define SQ_SEND_FLAGS_INLINE_SE_UC_FENCE_RD_OR_ATOMIC_FENCE_SIGNAL_COMP_MASK                   0xffUL
+	#define SQ_SEND_FLAGS_INLINE_SE_UC_FENCE_RD_OR_ATOMIC_FENCE_SIGNAL_COMP_SFT                    0
+	#define SQ_SEND_FLAGS_SIGNAL_COMP                                                              0x1UL
+	#define SQ_SEND_FLAGS_RD_OR_ATOMIC_FENCE                                                       0x2UL
+	#define SQ_SEND_FLAGS_UC_FENCE                                                                 0x4UL
+	#define SQ_SEND_FLAGS_SE                                                                       0x8UL
+	#define SQ_SEND_FLAGS_INLINE                                                                   0x10UL
+	#define SQ_SEND_FLAGS_WQE_TS_EN                                                                0x20UL
+	#define SQ_SEND_FLAGS_DEBUG_TRACE                                                              0x40UL
+	u8	wqe_size;
+	u8	reserved8_1;
+	__le32	inv_key_or_imm_data;
+	__le32	length;
+	__le32	q_key;
+	__le32	dst_qp;
+	#define SQ_SEND_DST_QP_MASK 0xffffffUL
+	#define SQ_SEND_DST_QP_SFT 0
+	__le32	avid;
+	#define SQ_SEND_AVID_MASK 0xfffffUL
+	#define SQ_SEND_AVID_SFT 0
+	__le32	reserved32;
+	__le32	timestamp;
+	#define SQ_SEND_TIMESTAMP_MASK 0xffffffUL
+	#define SQ_SEND_TIMESTAMP_SFT 0
+	__le32	data[24];
+};
+
+/* sq_send_hdr (size:256b/32B) */
+struct sq_send_hdr {
+	u8	wqe_type;
+	#define SQ_SEND_HDR_WQE_TYPE_SEND           0x0UL
+	#define SQ_SEND_HDR_WQE_TYPE_SEND_W_IMMEAD  0x1UL
+	#define SQ_SEND_HDR_WQE_TYPE_SEND_W_INVALID 0x2UL
+	#define SQ_SEND_HDR_WQE_TYPE_LAST          SQ_SEND_HDR_WQE_TYPE_SEND_W_INVALID
+	u8	flags;
+	#define SQ_SEND_HDR_FLAGS_INLINE_SE_UC_FENCE_RD_OR_ATOMIC_FENCE_SIGNAL_COMP_MASK                   0xffUL
+	#define SQ_SEND_HDR_FLAGS_INLINE_SE_UC_FENCE_RD_OR_ATOMIC_FENCE_SIGNAL_COMP_SFT                    0
+	#define SQ_SEND_HDR_FLAGS_SIGNAL_COMP                                                              0x1UL
+	#define SQ_SEND_HDR_FLAGS_RD_OR_ATOMIC_FENCE                                                       0x2UL
+	#define SQ_SEND_HDR_FLAGS_UC_FENCE                                                                 0x4UL
+	#define SQ_SEND_HDR_FLAGS_SE                                                                       0x8UL
+	#define SQ_SEND_HDR_FLAGS_INLINE                                                                   0x10UL
+	#define SQ_SEND_HDR_FLAGS_WQE_TS_EN                                                                0x20UL
+	#define SQ_SEND_HDR_FLAGS_DEBUG_TRACE                                                              0x40UL
+	u8	wqe_size;
+	u8	reserved8_1;
+	__le32	inv_key_or_imm_data;
+	__le32	length;
+	__le32	q_key;
+	__le32	dst_qp;
+	#define SQ_SEND_HDR_DST_QP_MASK 0xffffffUL
+	#define SQ_SEND_HDR_DST_QP_SFT 0
+	__le32	avid;
+	#define SQ_SEND_HDR_AVID_MASK 0xfffffUL
+	#define SQ_SEND_HDR_AVID_SFT 0
+	__le32	reserved32;
+	__le32	timestamp;
+	#define SQ_SEND_HDR_TIMESTAMP_MASK 0xffffffUL
+	#define SQ_SEND_HDR_TIMESTAMP_SFT 0
+};
+
+/* sq_send_raweth_qp1 (size:1024b/128B) */
+struct sq_send_raweth_qp1 {
+	u8	wqe_type;
+	#define SQ_SEND_RAWETH_QP1_WQE_TYPE_SEND 0x0UL
+	#define SQ_SEND_RAWETH_QP1_WQE_TYPE_LAST SQ_SEND_RAWETH_QP1_WQE_TYPE_SEND
+	u8	flags;
+	#define SQ_SEND_RAWETH_QP1_FLAGS_INLINE_SE_UC_FENCE_RD_OR_ATOMIC_FENCE_SIGNAL_COMP_MASK                   0xffUL
+	#define SQ_SEND_RAWETH_QP1_FLAGS_INLINE_SE_UC_FENCE_RD_OR_ATOMIC_FENCE_SIGNAL_COMP_SFT                    0
+	#define SQ_SEND_RAWETH_QP1_FLAGS_SIGNAL_COMP                                                              0x1UL
+	#define SQ_SEND_RAWETH_QP1_FLAGS_RD_OR_ATOMIC_FENCE                                                       0x2UL
+	#define SQ_SEND_RAWETH_QP1_FLAGS_UC_FENCE                                                                 0x4UL
+	#define SQ_SEND_RAWETH_QP1_FLAGS_SE                                                                       0x8UL
+	#define SQ_SEND_RAWETH_QP1_FLAGS_INLINE                                                                   0x10UL
+	#define SQ_SEND_RAWETH_QP1_FLAGS_WQE_TS_EN                                                                0x20UL
+	#define SQ_SEND_RAWETH_QP1_FLAGS_DEBUG_TRACE                                                              0x40UL
+	u8	wqe_size;
+	u8	reserved8;
+	__le16	lflags;
+	#define SQ_SEND_RAWETH_QP1_LFLAGS_TCP_UDP_CHKSUM     0x1UL
+	#define SQ_SEND_RAWETH_QP1_LFLAGS_IP_CHKSUM          0x2UL
+	#define SQ_SEND_RAWETH_QP1_LFLAGS_NOCRC              0x4UL
+	#define SQ_SEND_RAWETH_QP1_LFLAGS_STAMP              0x8UL
+	#define SQ_SEND_RAWETH_QP1_LFLAGS_T_IP_CHKSUM        0x10UL
+	#define SQ_SEND_RAWETH_QP1_LFLAGS_ROCE_CRC           0x100UL
+	#define SQ_SEND_RAWETH_QP1_LFLAGS_FCOE_CRC           0x200UL
+	__le16	cfa_action;
+	__le32	length;
+	__le32	reserved32_1;
+	__le32	cfa_meta;
+	#define SQ_SEND_RAWETH_QP1_CFA_META_VLAN_VID_MASK     0xfffUL
+	#define SQ_SEND_RAWETH_QP1_CFA_META_VLAN_VID_SFT      0
+	#define SQ_SEND_RAWETH_QP1_CFA_META_VLAN_DE           0x1000UL
+	#define SQ_SEND_RAWETH_QP1_CFA_META_VLAN_PRI_MASK     0xe000UL
+	#define SQ_SEND_RAWETH_QP1_CFA_META_VLAN_PRI_SFT      13
+	#define SQ_SEND_RAWETH_QP1_CFA_META_VLAN_TPID_MASK    0x70000UL
+	#define SQ_SEND_RAWETH_QP1_CFA_META_VLAN_TPID_SFT     16
+	#define SQ_SEND_RAWETH_QP1_CFA_META_VLAN_TPID_TPID88A8  (0x0UL << 16)
+	#define SQ_SEND_RAWETH_QP1_CFA_META_VLAN_TPID_TPID8100  (0x1UL << 16)
+	#define SQ_SEND_RAWETH_QP1_CFA_META_VLAN_TPID_TPID9100  (0x2UL << 16)
+	#define SQ_SEND_RAWETH_QP1_CFA_META_VLAN_TPID_TPID9200  (0x3UL << 16)
+	#define SQ_SEND_RAWETH_QP1_CFA_META_VLAN_TPID_TPID9300  (0x4UL << 16)
+	#define SQ_SEND_RAWETH_QP1_CFA_META_VLAN_TPID_TPIDCFG   (0x5UL << 16)
+	#define SQ_SEND_RAWETH_QP1_CFA_META_VLAN_TPID_LAST     SQ_SEND_RAWETH_QP1_CFA_META_VLAN_TPID_TPIDCFG
+	#define SQ_SEND_RAWETH_QP1_CFA_META_VLAN_RESERVED_MASK 0xff80000UL
+	#define SQ_SEND_RAWETH_QP1_CFA_META_VLAN_RESERVED_SFT 19
+	#define SQ_SEND_RAWETH_QP1_CFA_META_KEY_MASK          0xf0000000UL
+	#define SQ_SEND_RAWETH_QP1_CFA_META_KEY_SFT           28
+	#define SQ_SEND_RAWETH_QP1_CFA_META_KEY_NONE            (0x0UL << 28)
+	#define SQ_SEND_RAWETH_QP1_CFA_META_KEY_VLAN_TAG        (0x1UL << 28)
+	#define SQ_SEND_RAWETH_QP1_CFA_META_KEY_LAST           SQ_SEND_RAWETH_QP1_CFA_META_KEY_VLAN_TAG
+	__le32	reserved32_2;
+	__le32	reserved32_3;
+	__le32	timestamp;
+	#define SQ_SEND_RAWETH_QP1_TIMESTAMP_MASK 0xffffffUL
+	#define SQ_SEND_RAWETH_QP1_TIMESTAMP_SFT 0
+	__le32	data[24];
+};
+
+/* sq_send_raweth_qp1_hdr (size:256b/32B) */
+struct sq_send_raweth_qp1_hdr {
+	u8	wqe_type;
+	#define SQ_SEND_RAWETH_QP1_HDR_WQE_TYPE_SEND 0x0UL
+	#define SQ_SEND_RAWETH_QP1_HDR_WQE_TYPE_LAST SQ_SEND_RAWETH_QP1_HDR_WQE_TYPE_SEND
+	u8	flags;
+	#define SQ_SEND_RAWETH_QP1_HDR_FLAGS_INLINE_SE_UC_FENCE_RD_OR_ATOMIC_FENCE_SIGNAL_COMP_MASK                   0xffUL
+	#define SQ_SEND_RAWETH_QP1_HDR_FLAGS_INLINE_SE_UC_FENCE_RD_OR_ATOMIC_FENCE_SIGNAL_COMP_SFT                    0
+	#define SQ_SEND_RAWETH_QP1_HDR_FLAGS_SIGNAL_COMP                                                              0x1UL
+	#define SQ_SEND_RAWETH_QP1_HDR_FLAGS_RD_OR_ATOMIC_FENCE                                                       0x2UL
+	#define SQ_SEND_RAWETH_QP1_HDR_FLAGS_UC_FENCE                                                                 0x4UL
+	#define SQ_SEND_RAWETH_QP1_HDR_FLAGS_SE                                                                       0x8UL
+	#define SQ_SEND_RAWETH_QP1_HDR_FLAGS_INLINE                                                                   0x10UL
+	#define SQ_SEND_RAWETH_QP1_HDR_FLAGS_WQE_TS_EN                                                                0x20UL
+	#define SQ_SEND_RAWETH_QP1_HDR_FLAGS_DEBUG_TRACE                                                              0x40UL
+	u8	wqe_size;
+	u8	reserved8;
+	__le16	lflags;
+	#define SQ_SEND_RAWETH_QP1_HDR_LFLAGS_TCP_UDP_CHKSUM     0x1UL
+	#define SQ_SEND_RAWETH_QP1_HDR_LFLAGS_IP_CHKSUM          0x2UL
+	#define SQ_SEND_RAWETH_QP1_HDR_LFLAGS_NOCRC              0x4UL
+	#define SQ_SEND_RAWETH_QP1_HDR_LFLAGS_STAMP              0x8UL
+	#define SQ_SEND_RAWETH_QP1_HDR_LFLAGS_T_IP_CHKSUM        0x10UL
+	#define SQ_SEND_RAWETH_QP1_HDR_LFLAGS_ROCE_CRC           0x100UL
+	#define SQ_SEND_RAWETH_QP1_HDR_LFLAGS_FCOE_CRC           0x200UL
+	__le16	cfa_action;
+	__le32	length;
+	__le32	reserved32_1;
+	__le32	cfa_meta;
+	#define SQ_SEND_RAWETH_QP1_HDR_CFA_META_VLAN_VID_MASK     0xfffUL
+	#define SQ_SEND_RAWETH_QP1_HDR_CFA_META_VLAN_VID_SFT      0
+	#define SQ_SEND_RAWETH_QP1_HDR_CFA_META_VLAN_DE           0x1000UL
+	#define SQ_SEND_RAWETH_QP1_HDR_CFA_META_VLAN_PRI_MASK     0xe000UL
+	#define SQ_SEND_RAWETH_QP1_HDR_CFA_META_VLAN_PRI_SFT      13
+	#define SQ_SEND_RAWETH_QP1_HDR_CFA_META_VLAN_TPID_MASK    0x70000UL
+	#define SQ_SEND_RAWETH_QP1_HDR_CFA_META_VLAN_TPID_SFT     16
+	#define SQ_SEND_RAWETH_QP1_HDR_CFA_META_VLAN_TPID_TPID88A8  (0x0UL << 16)
+	#define SQ_SEND_RAWETH_QP1_HDR_CFA_META_VLAN_TPID_TPID8100  (0x1UL << 16)
+	#define SQ_SEND_RAWETH_QP1_HDR_CFA_META_VLAN_TPID_TPID9100  (0x2UL << 16)
+	#define SQ_SEND_RAWETH_QP1_HDR_CFA_META_VLAN_TPID_TPID9200  (0x3UL << 16)
+	#define SQ_SEND_RAWETH_QP1_HDR_CFA_META_VLAN_TPID_TPID9300  (0x4UL << 16)
+	#define SQ_SEND_RAWETH_QP1_HDR_CFA_META_VLAN_TPID_TPIDCFG   (0x5UL << 16)
+	#define SQ_SEND_RAWETH_QP1_HDR_CFA_META_VLAN_TPID_LAST     SQ_SEND_RAWETH_QP1_HDR_CFA_META_VLAN_TPID_TPIDCFG
+	#define SQ_SEND_RAWETH_QP1_HDR_CFA_META_VLAN_RESERVED_MASK 0xff80000UL
+	#define SQ_SEND_RAWETH_QP1_HDR_CFA_META_VLAN_RESERVED_SFT 19
+	#define SQ_SEND_RAWETH_QP1_HDR_CFA_META_KEY_MASK          0xf0000000UL
+	#define SQ_SEND_RAWETH_QP1_HDR_CFA_META_KEY_SFT           28
+	#define SQ_SEND_RAWETH_QP1_HDR_CFA_META_KEY_NONE            (0x0UL << 28)
+	#define SQ_SEND_RAWETH_QP1_HDR_CFA_META_KEY_VLAN_TAG        (0x1UL << 28)
+	#define SQ_SEND_RAWETH_QP1_HDR_CFA_META_KEY_LAST           SQ_SEND_RAWETH_QP1_HDR_CFA_META_KEY_VLAN_TAG
+	__le32	reserved32_2;
+	__le32	reserved32_3;
+	__le32	timestamp;
+	#define SQ_SEND_RAWETH_QP1_HDR_TIMESTAMP_MASK 0xffffffUL
+	#define SQ_SEND_RAWETH_QP1_HDR_TIMESTAMP_SFT 0
+};
+
+/* sq_rdma (size:1024b/128B) */
+struct sq_rdma {
+	u8	wqe_type;
+	#define SQ_RDMA_WQE_TYPE_WRITE_WQE      0x4UL
+	#define SQ_RDMA_WQE_TYPE_WRITE_W_IMMEAD 0x5UL
+	#define SQ_RDMA_WQE_TYPE_READ_WQE       0x6UL
+	#define SQ_RDMA_WQE_TYPE_LAST          SQ_RDMA_WQE_TYPE_READ_WQE
+	u8	flags;
+	#define SQ_RDMA_FLAGS_INLINE_SE_UC_FENCE_RD_OR_ATOMIC_FENCE_SIGNAL_COMP_MASK                   0xffUL
+	#define SQ_RDMA_FLAGS_INLINE_SE_UC_FENCE_RD_OR_ATOMIC_FENCE_SIGNAL_COMP_SFT                    0
+	#define SQ_RDMA_FLAGS_SIGNAL_COMP                                                              0x1UL
+	#define SQ_RDMA_FLAGS_RD_OR_ATOMIC_FENCE                                                       0x2UL
+	#define SQ_RDMA_FLAGS_UC_FENCE                                                                 0x4UL
+	#define SQ_RDMA_FLAGS_SE                                                                       0x8UL
+	#define SQ_RDMA_FLAGS_INLINE                                                                   0x10UL
+	#define SQ_RDMA_FLAGS_WQE_TS_EN                                                                0x20UL
+	#define SQ_RDMA_FLAGS_DEBUG_TRACE                                                              0x40UL
+	u8	wqe_size;
+	u8	reserved8;
+	__le32	imm_data;
+	__le32	length;
+	__le32	reserved32_1;
+	__le64	remote_va;
+	__le32	remote_key;
+	__le32	timestamp;
+	#define SQ_RDMA_TIMESTAMP_MASK 0xffffffUL
+	#define SQ_RDMA_TIMESTAMP_SFT 0
+	__le32	data[24];
+};
+
+/* sq_rdma_hdr (size:256b/32B) */
+struct sq_rdma_hdr {
+	u8	wqe_type;
+	#define SQ_RDMA_HDR_WQE_TYPE_WRITE_WQE      0x4UL
+	#define SQ_RDMA_HDR_WQE_TYPE_WRITE_W_IMMEAD 0x5UL
+	#define SQ_RDMA_HDR_WQE_TYPE_READ_WQE       0x6UL
+	#define SQ_RDMA_HDR_WQE_TYPE_LAST          SQ_RDMA_HDR_WQE_TYPE_READ_WQE
+	u8	flags;
+	#define SQ_RDMA_HDR_FLAGS_INLINE_SE_UC_FENCE_RD_OR_ATOMIC_FENCE_SIGNAL_COMP_MASK                   0xffUL
+	#define SQ_RDMA_HDR_FLAGS_INLINE_SE_UC_FENCE_RD_OR_ATOMIC_FENCE_SIGNAL_COMP_SFT                    0
+	#define SQ_RDMA_HDR_FLAGS_SIGNAL_COMP                                                              0x1UL
+	#define SQ_RDMA_HDR_FLAGS_RD_OR_ATOMIC_FENCE                                                       0x2UL
+	#define SQ_RDMA_HDR_FLAGS_UC_FENCE                                                                 0x4UL
+	#define SQ_RDMA_HDR_FLAGS_SE                                                                       0x8UL
+	#define SQ_RDMA_HDR_FLAGS_INLINE                                                                   0x10UL
+	#define SQ_RDMA_HDR_FLAGS_WQE_TS_EN                                                                0x20UL
+	#define SQ_RDMA_HDR_FLAGS_DEBUG_TRACE                                                              0x40UL
+	u8	wqe_size;
+	u8	reserved8;
+	__le32	imm_data;
+	__le32	length;
+	__le32	reserved32_1;
+	__le64	remote_va;
+	__le32	remote_key;
+	__le32	timestamp;
+	#define SQ_RDMA_HDR_TIMESTAMP_MASK 0xffffffUL
+	#define SQ_RDMA_HDR_TIMESTAMP_SFT 0
+};
+
+/* sq_atomic (size:1024b/128B) */
+struct sq_atomic {
+	u8	wqe_type;
+	#define SQ_ATOMIC_WQE_TYPE_ATOMIC_CS 0x8UL
+	#define SQ_ATOMIC_WQE_TYPE_ATOMIC_FA 0xbUL
+	#define SQ_ATOMIC_WQE_TYPE_LAST     SQ_ATOMIC_WQE_TYPE_ATOMIC_FA
+	u8	flags;
+	#define SQ_ATOMIC_FLAGS_INLINE_SE_UC_FENCE_RD_OR_ATOMIC_FENCE_SIGNAL_COMP_MASK                   0xffUL
+	#define SQ_ATOMIC_FLAGS_INLINE_SE_UC_FENCE_RD_OR_ATOMIC_FENCE_SIGNAL_COMP_SFT                    0
+	#define SQ_ATOMIC_FLAGS_SIGNAL_COMP                                                              0x1UL
+	#define SQ_ATOMIC_FLAGS_RD_OR_ATOMIC_FENCE                                                       0x2UL
+	#define SQ_ATOMIC_FLAGS_UC_FENCE                                                                 0x4UL
+	#define SQ_ATOMIC_FLAGS_SE                                                                       0x8UL
+	#define SQ_ATOMIC_FLAGS_INLINE                                                                   0x10UL
+	#define SQ_ATOMIC_FLAGS_WQE_TS_EN                                                                0x20UL
+	#define SQ_ATOMIC_FLAGS_DEBUG_TRACE                                                              0x40UL
+	__le16	reserved16;
+	__le32	remote_key;
+	__le64	remote_va;
+	__le64	swap_data;
+	__le64	cmp_data;
+	__le32	data[24];
+};
+
+/* sq_atomic_hdr (size:256b/32B) */
+struct sq_atomic_hdr {
+	u8	wqe_type;
+	#define SQ_ATOMIC_HDR_WQE_TYPE_ATOMIC_CS 0x8UL
+	#define SQ_ATOMIC_HDR_WQE_TYPE_ATOMIC_FA 0xbUL
+	#define SQ_ATOMIC_HDR_WQE_TYPE_LAST     SQ_ATOMIC_HDR_WQE_TYPE_ATOMIC_FA
+	u8	flags;
+	#define SQ_ATOMIC_HDR_FLAGS_INLINE_SE_UC_FENCE_RD_OR_ATOMIC_FENCE_SIGNAL_COMP_MASK                   0xffUL
+	#define SQ_ATOMIC_HDR_FLAGS_INLINE_SE_UC_FENCE_RD_OR_ATOMIC_FENCE_SIGNAL_COMP_SFT                    0
+	#define SQ_ATOMIC_HDR_FLAGS_SIGNAL_COMP                                                              0x1UL
+	#define SQ_ATOMIC_HDR_FLAGS_RD_OR_ATOMIC_FENCE                                                       0x2UL
+	#define SQ_ATOMIC_HDR_FLAGS_UC_FENCE                                                                 0x4UL
+	#define SQ_ATOMIC_HDR_FLAGS_SE                                                                       0x8UL
+	#define SQ_ATOMIC_HDR_FLAGS_INLINE                                                                   0x10UL
+	#define SQ_ATOMIC_HDR_FLAGS_WQE_TS_EN                                                                0x20UL
+	#define SQ_ATOMIC_HDR_FLAGS_DEBUG_TRACE                                                              0x40UL
+	__le16	reserved16;
+	__le32	remote_key;
+	__le64	remote_va;
+	__le64	swap_data;
+	__le64	cmp_data;
+};
+
+/* sq_localinvalidate (size:1024b/128B) */
+struct sq_localinvalidate {
+	u8	wqe_type;
+	#define SQ_LOCALINVALIDATE_WQE_TYPE_LOCAL_INVALID 0xcUL
+	#define SQ_LOCALINVALIDATE_WQE_TYPE_LAST         SQ_LOCALINVALIDATE_WQE_TYPE_LOCAL_INVALID
+	u8	flags;
+	#define SQ_LOCALINVALIDATE_FLAGS_INLINE_SE_UC_FENCE_RD_OR_ATOMIC_FENCE_SIGNAL_COMP_MASK                   0xffUL
+	#define SQ_LOCALINVALIDATE_FLAGS_INLINE_SE_UC_FENCE_RD_OR_ATOMIC_FENCE_SIGNAL_COMP_SFT                    0
+	#define SQ_LOCALINVALIDATE_FLAGS_SIGNAL_COMP                                                              0x1UL
+	#define SQ_LOCALINVALIDATE_FLAGS_RD_OR_ATOMIC_FENCE                                                       0x2UL
+	#define SQ_LOCALINVALIDATE_FLAGS_UC_FENCE                                                                 0x4UL
+	#define SQ_LOCALINVALIDATE_FLAGS_SE                                                                       0x8UL
+	#define SQ_LOCALINVALIDATE_FLAGS_INLINE                                                                   0x10UL
+	#define SQ_LOCALINVALIDATE_FLAGS_WQE_TS_EN                                                                0x20UL
+	#define SQ_LOCALINVALIDATE_FLAGS_DEBUG_TRACE                                                              0x40UL
+	__le16	reserved16;
+	__le32	inv_l_key;
+	__le64	reserved64;
+	u8	reserved128[16];
+	__le32	data[24];
+};
+
+/* sq_localinvalidate_hdr (size:256b/32B) */
+struct sq_localinvalidate_hdr {
+	u8	wqe_type;
+	#define SQ_LOCALINVALIDATE_HDR_WQE_TYPE_LOCAL_INVALID 0xcUL
+	#define SQ_LOCALINVALIDATE_HDR_WQE_TYPE_LAST         SQ_LOCALINVALIDATE_HDR_WQE_TYPE_LOCAL_INVALID
+	u8	flags;
+	#define SQ_LOCALINVALIDATE_HDR_FLAGS_INLINE_SE_UC_FENCE_RD_OR_ATOMIC_FENCE_SIGNAL_COMP_MASK                   0xffUL
+	#define SQ_LOCALINVALIDATE_HDR_FLAGS_INLINE_SE_UC_FENCE_RD_OR_ATOMIC_FENCE_SIGNAL_COMP_SFT                    0
+	#define SQ_LOCALINVALIDATE_HDR_FLAGS_SIGNAL_COMP                                                              0x1UL
+	#define SQ_LOCALINVALIDATE_HDR_FLAGS_RD_OR_ATOMIC_FENCE                                                       0x2UL
+	#define SQ_LOCALINVALIDATE_HDR_FLAGS_UC_FENCE                                                                 0x4UL
+	#define SQ_LOCALINVALIDATE_HDR_FLAGS_SE                                                                       0x8UL
+	#define SQ_LOCALINVALIDATE_HDR_FLAGS_INLINE                                                                   0x10UL
+	#define SQ_LOCALINVALIDATE_HDR_FLAGS_WQE_TS_EN                                                                0x20UL
+	#define SQ_LOCALINVALIDATE_HDR_FLAGS_DEBUG_TRACE                                                              0x40UL
+	__le16	reserved16;
+	__le32	inv_l_key;
+	__le64	reserved64;
+	u8	reserved128[16];
+};
+
+/* sq_fr_pmr (size:1024b/128B) */
+struct sq_fr_pmr {
+	u8	wqe_type;
+	#define SQ_FR_PMR_WQE_TYPE_FR_PMR 0xdUL
+	#define SQ_FR_PMR_WQE_TYPE_LAST  SQ_FR_PMR_WQE_TYPE_FR_PMR
+	u8	flags;
+	#define SQ_FR_PMR_FLAGS_SIGNAL_COMP            0x1UL
+	#define SQ_FR_PMR_FLAGS_RD_OR_ATOMIC_FENCE     0x2UL
+	#define SQ_FR_PMR_FLAGS_UC_FENCE               0x4UL
+	#define SQ_FR_PMR_FLAGS_SE                     0x8UL
+	#define SQ_FR_PMR_FLAGS_INLINE                 0x10UL
+	#define SQ_FR_PMR_FLAGS_WQE_TS_EN              0x20UL
+	#define SQ_FR_PMR_FLAGS_DEBUG_TRACE            0x40UL
+	u8	access_cntl;
+	#define SQ_FR_PMR_ACCESS_CNTL_LOCAL_WRITE       0x1UL
+	#define SQ_FR_PMR_ACCESS_CNTL_REMOTE_READ       0x2UL
+	#define SQ_FR_PMR_ACCESS_CNTL_REMOTE_WRITE      0x4UL
+	#define SQ_FR_PMR_ACCESS_CNTL_REMOTE_ATOMIC     0x8UL
+	#define SQ_FR_PMR_ACCESS_CNTL_WINDOW_BIND       0x10UL
+	u8	zero_based_page_size_log;
+	#define SQ_FR_PMR_PAGE_SIZE_LOG_MASK     0x1fUL
+	#define SQ_FR_PMR_PAGE_SIZE_LOG_SFT      0
+	#define SQ_FR_PMR_PAGE_SIZE_LOG_PGSZ_4K    0x0UL
+	#define SQ_FR_PMR_PAGE_SIZE_LOG_PGSZ_8K    0x1UL
+	#define SQ_FR_PMR_PAGE_SIZE_LOG_PGSZ_16K   0x2UL
+	#define SQ_FR_PMR_PAGE_SIZE_LOG_PGSZ_32K   0x3UL
+	#define SQ_FR_PMR_PAGE_SIZE_LOG_PGSZ_64K   0x4UL
+	#define SQ_FR_PMR_PAGE_SIZE_LOG_PGSZ_128K  0x5UL
+	#define SQ_FR_PMR_PAGE_SIZE_LOG_PGSZ_256K  0x6UL
+	#define SQ_FR_PMR_PAGE_SIZE_LOG_PGSZ_512K  0x7UL
+	#define SQ_FR_PMR_PAGE_SIZE_LOG_PGSZ_1M    0x8UL
+	#define SQ_FR_PMR_PAGE_SIZE_LOG_PGSZ_2M    0x9UL
+	#define SQ_FR_PMR_PAGE_SIZE_LOG_PGSZ_4M    0xaUL
+	#define SQ_FR_PMR_PAGE_SIZE_LOG_PGSZ_8M    0xbUL
+	#define SQ_FR_PMR_PAGE_SIZE_LOG_PGSZ_16M   0xcUL
+	#define SQ_FR_PMR_PAGE_SIZE_LOG_PGSZ_32M   0xdUL
+	#define SQ_FR_PMR_PAGE_SIZE_LOG_PGSZ_64M   0xeUL
+	#define SQ_FR_PMR_PAGE_SIZE_LOG_PGSZ_128M  0xfUL
+	#define SQ_FR_PMR_PAGE_SIZE_LOG_PGSZ_256M  0x10UL
+	#define SQ_FR_PMR_PAGE_SIZE_LOG_PGSZ_512M  0x11UL
+	#define SQ_FR_PMR_PAGE_SIZE_LOG_PGSZ_1G    0x12UL
+	#define SQ_FR_PMR_PAGE_SIZE_LOG_PGSZ_2G    0x13UL
+	#define SQ_FR_PMR_PAGE_SIZE_LOG_PGSZ_4G    0x14UL
+	#define SQ_FR_PMR_PAGE_SIZE_LOG_PGSZ_8G    0x15UL
+	#define SQ_FR_PMR_PAGE_SIZE_LOG_PGSZ_16G   0x16UL
+	#define SQ_FR_PMR_PAGE_SIZE_LOG_PGSZ_32G   0x17UL
+	#define SQ_FR_PMR_PAGE_SIZE_LOG_PGSZ_64G   0x18UL
+	#define SQ_FR_PMR_PAGE_SIZE_LOG_PGSZ_128G  0x19UL
+	#define SQ_FR_PMR_PAGE_SIZE_LOG_PGSZ_256G  0x1aUL
+	#define SQ_FR_PMR_PAGE_SIZE_LOG_PGSZ_512G  0x1bUL
+	#define SQ_FR_PMR_PAGE_SIZE_LOG_PGSZ_1T    0x1cUL
+	#define SQ_FR_PMR_PAGE_SIZE_LOG_PGSZ_2T    0x1dUL
+	#define SQ_FR_PMR_PAGE_SIZE_LOG_PGSZ_4T    0x1eUL
+	#define SQ_FR_PMR_PAGE_SIZE_LOG_PGSZ_8T    0x1fUL
+	#define SQ_FR_PMR_PAGE_SIZE_LOG_LAST      SQ_FR_PMR_PAGE_SIZE_LOG_PGSZ_8T
+	#define SQ_FR_PMR_ZERO_BASED             0x20UL
+	__le32	l_key;
+	u8	length[5];
+	u8	reserved8_1;
+	u8	reserved8_2;
+	u8	numlevels_pbl_page_size_log;
+	#define SQ_FR_PMR_PBL_PAGE_SIZE_LOG_MASK     0x1fUL
+	#define SQ_FR_PMR_PBL_PAGE_SIZE_LOG_SFT      0
+	#define SQ_FR_PMR_PBL_PAGE_SIZE_LOG_PGSZ_4K    0x0UL
+	#define SQ_FR_PMR_PBL_PAGE_SIZE_LOG_PGSZ_8K    0x1UL
+	#define SQ_FR_PMR_PBL_PAGE_SIZE_LOG_PGSZ_16K   0x2UL
+	#define SQ_FR_PMR_PBL_PAGE_SIZE_LOG_PGSZ_32K   0x3UL
+	#define SQ_FR_PMR_PBL_PAGE_SIZE_LOG_PGSZ_64K   0x4UL
+	#define SQ_FR_PMR_PBL_PAGE_SIZE_LOG_PGSZ_128K  0x5UL
+	#define SQ_FR_PMR_PBL_PAGE_SIZE_LOG_PGSZ_256K  0x6UL
+	#define SQ_FR_PMR_PBL_PAGE_SIZE_LOG_PGSZ_512K  0x7UL
+	#define SQ_FR_PMR_PBL_PAGE_SIZE_LOG_PGSZ_1M    0x8UL
+	#define SQ_FR_PMR_PBL_PAGE_SIZE_LOG_PGSZ_2M    0x9UL
+	#define SQ_FR_PMR_PBL_PAGE_SIZE_LOG_PGSZ_4M    0xaUL
+	#define SQ_FR_PMR_PBL_PAGE_SIZE_LOG_PGSZ_8M    0xbUL
+	#define SQ_FR_PMR_PBL_PAGE_SIZE_LOG_PGSZ_16M   0xcUL
+	#define SQ_FR_PMR_PBL_PAGE_SIZE_LOG_PGSZ_32M   0xdUL
+	#define SQ_FR_PMR_PBL_PAGE_SIZE_LOG_PGSZ_64M   0xeUL
+	#define SQ_FR_PMR_PBL_PAGE_SIZE_LOG_PGSZ_128M  0xfUL
+	#define SQ_FR_PMR_PBL_PAGE_SIZE_LOG_PGSZ_256M  0x10UL
+	#define SQ_FR_PMR_PBL_PAGE_SIZE_LOG_PGSZ_512M  0x11UL
+	#define SQ_FR_PMR_PBL_PAGE_SIZE_LOG_PGSZ_1G    0x12UL
+	#define SQ_FR_PMR_PBL_PAGE_SIZE_LOG_PGSZ_2G    0x13UL
+	#define SQ_FR_PMR_PBL_PAGE_SIZE_LOG_PGSZ_4G    0x14UL
+	#define SQ_FR_PMR_PBL_PAGE_SIZE_LOG_PGSZ_8G    0x15UL
+	#define SQ_FR_PMR_PBL_PAGE_SIZE_LOG_PGSZ_16G   0x16UL
+	#define SQ_FR_PMR_PBL_PAGE_SIZE_LOG_PGSZ_32G   0x17UL
+	#define SQ_FR_PMR_PBL_PAGE_SIZE_LOG_PGSZ_64G   0x18UL
+	#define SQ_FR_PMR_PBL_PAGE_SIZE_LOG_PGSZ_128G  0x19UL
+	#define SQ_FR_PMR_PBL_PAGE_SIZE_LOG_PGSZ_256G  0x1aUL
+	#define SQ_FR_PMR_PBL_PAGE_SIZE_LOG_PGSZ_512G  0x1bUL
+	#define SQ_FR_PMR_PBL_PAGE_SIZE_LOG_PGSZ_1T    0x1cUL
+	#define SQ_FR_PMR_PBL_PAGE_SIZE_LOG_PGSZ_2T    0x1dUL
+	#define SQ_FR_PMR_PBL_PAGE_SIZE_LOG_PGSZ_4T    0x1eUL
+	#define SQ_FR_PMR_PBL_PAGE_SIZE_LOG_PGSZ_8T    0x1fUL
+	#define SQ_FR_PMR_PBL_PAGE_SIZE_LOG_LAST      SQ_FR_PMR_PBL_PAGE_SIZE_LOG_PGSZ_8T
+	#define SQ_FR_PMR_NUMLEVELS_MASK             0xc0UL
+	#define SQ_FR_PMR_NUMLEVELS_SFT              6
+	#define SQ_FR_PMR_NUMLEVELS_PHYSICAL           (0x0UL << 6)
+	#define SQ_FR_PMR_NUMLEVELS_LAYER1             (0x1UL << 6)
+	#define SQ_FR_PMR_NUMLEVELS_LAYER2             (0x2UL << 6)
+	#define SQ_FR_PMR_NUMLEVELS_LAST              SQ_FR_PMR_NUMLEVELS_LAYER2
+	__le64	pblptr;
+	__le64	va;
+	__le32	data[24];
+};
+
+/* sq_fr_pmr_hdr (size:256b/32B) */
+struct sq_fr_pmr_hdr {
+	u8	wqe_type;
+	#define SQ_FR_PMR_HDR_WQE_TYPE_FR_PMR 0xdUL
+	#define SQ_FR_PMR_HDR_WQE_TYPE_LAST  SQ_FR_PMR_HDR_WQE_TYPE_FR_PMR
+	u8	flags;
+	#define SQ_FR_PMR_HDR_FLAGS_SIGNAL_COMP            0x1UL
+	#define SQ_FR_PMR_HDR_FLAGS_RD_OR_ATOMIC_FENCE     0x2UL
+	#define SQ_FR_PMR_HDR_FLAGS_UC_FENCE               0x4UL
+	#define SQ_FR_PMR_HDR_FLAGS_SE                     0x8UL
+	#define SQ_FR_PMR_HDR_FLAGS_INLINE                 0x10UL
+	#define SQ_FR_PMR_HDR_FLAGS_WQE_TS_EN              0x20UL
+	#define SQ_FR_PMR_HDR_FLAGS_DEBUG_TRACE            0x40UL
+	u8	access_cntl;
+	#define SQ_FR_PMR_HDR_ACCESS_CNTL_LOCAL_WRITE       0x1UL
+	#define SQ_FR_PMR_HDR_ACCESS_CNTL_REMOTE_READ       0x2UL
+	#define SQ_FR_PMR_HDR_ACCESS_CNTL_REMOTE_WRITE      0x4UL
+	#define SQ_FR_PMR_HDR_ACCESS_CNTL_REMOTE_ATOMIC     0x8UL
+	#define SQ_FR_PMR_HDR_ACCESS_CNTL_WINDOW_BIND       0x10UL
+	u8	zero_based_page_size_log;
+	#define SQ_FR_PMR_HDR_PAGE_SIZE_LOG_MASK     0x1fUL
+	#define SQ_FR_PMR_HDR_PAGE_SIZE_LOG_SFT      0
+	#define SQ_FR_PMR_HDR_PAGE_SIZE_LOG_PGSZ_4K    0x0UL
+	#define SQ_FR_PMR_HDR_PAGE_SIZE_LOG_PGSZ_8K    0x1UL
+	#define SQ_FR_PMR_HDR_PAGE_SIZE_LOG_PGSZ_16K   0x2UL
+	#define SQ_FR_PMR_HDR_PAGE_SIZE_LOG_PGSZ_32K   0x3UL
+	#define SQ_FR_PMR_HDR_PAGE_SIZE_LOG_PGSZ_64K   0x4UL
+	#define SQ_FR_PMR_HDR_PAGE_SIZE_LOG_PGSZ_128K  0x5UL
+	#define SQ_FR_PMR_HDR_PAGE_SIZE_LOG_PGSZ_256K  0x6UL
+	#define SQ_FR_PMR_HDR_PAGE_SIZE_LOG_PGSZ_512K  0x7UL
+	#define SQ_FR_PMR_HDR_PAGE_SIZE_LOG_PGSZ_1M    0x8UL
+	#define SQ_FR_PMR_HDR_PAGE_SIZE_LOG_PGSZ_2M    0x9UL
+	#define SQ_FR_PMR_HDR_PAGE_SIZE_LOG_PGSZ_4M    0xaUL
+	#define SQ_FR_PMR_HDR_PAGE_SIZE_LOG_PGSZ_8M    0xbUL
+	#define SQ_FR_PMR_HDR_PAGE_SIZE_LOG_PGSZ_16M   0xcUL
+	#define SQ_FR_PMR_HDR_PAGE_SIZE_LOG_PGSZ_32M   0xdUL
+	#define SQ_FR_PMR_HDR_PAGE_SIZE_LOG_PGSZ_64M   0xeUL
+	#define SQ_FR_PMR_HDR_PAGE_SIZE_LOG_PGSZ_128M  0xfUL
+	#define SQ_FR_PMR_HDR_PAGE_SIZE_LOG_PGSZ_256M  0x10UL
+	#define SQ_FR_PMR_HDR_PAGE_SIZE_LOG_PGSZ_512M  0x11UL
+	#define SQ_FR_PMR_HDR_PAGE_SIZE_LOG_PGSZ_1G    0x12UL
+	#define SQ_FR_PMR_HDR_PAGE_SIZE_LOG_PGSZ_2G    0x13UL
+	#define SQ_FR_PMR_HDR_PAGE_SIZE_LOG_PGSZ_4G    0x14UL
+	#define SQ_FR_PMR_HDR_PAGE_SIZE_LOG_PGSZ_8G    0x15UL
+	#define SQ_FR_PMR_HDR_PAGE_SIZE_LOG_PGSZ_16G   0x16UL
+	#define SQ_FR_PMR_HDR_PAGE_SIZE_LOG_PGSZ_32G   0x17UL
+	#define SQ_FR_PMR_HDR_PAGE_SIZE_LOG_PGSZ_64G   0x18UL
+	#define SQ_FR_PMR_HDR_PAGE_SIZE_LOG_PGSZ_128G  0x19UL
+	#define SQ_FR_PMR_HDR_PAGE_SIZE_LOG_PGSZ_256G  0x1aUL
+	#define SQ_FR_PMR_HDR_PAGE_SIZE_LOG_PGSZ_512G  0x1bUL
+	#define SQ_FR_PMR_HDR_PAGE_SIZE_LOG_PGSZ_1T    0x1cUL
+	#define SQ_FR_PMR_HDR_PAGE_SIZE_LOG_PGSZ_2T    0x1dUL
+	#define SQ_FR_PMR_HDR_PAGE_SIZE_LOG_PGSZ_4T    0x1eUL
+	#define SQ_FR_PMR_HDR_PAGE_SIZE_LOG_PGSZ_8T    0x1fUL
+	#define SQ_FR_PMR_HDR_PAGE_SIZE_LOG_LAST      SQ_FR_PMR_HDR_PAGE_SIZE_LOG_PGSZ_8T
+	#define SQ_FR_PMR_HDR_ZERO_BASED             0x20UL
+	__le32	l_key;
+	u8	length[5];
+	u8	reserved8_1;
+	u8	reserved8_2;
+	u8	numlevels_pbl_page_size_log;
+	#define SQ_FR_PMR_HDR_PBL_PAGE_SIZE_LOG_MASK     0x1fUL
+	#define SQ_FR_PMR_HDR_PBL_PAGE_SIZE_LOG_SFT      0
+	#define SQ_FR_PMR_HDR_PBL_PAGE_SIZE_LOG_PGSZ_4K    0x0UL
+	#define SQ_FR_PMR_HDR_PBL_PAGE_SIZE_LOG_PGSZ_8K    0x1UL
+	#define SQ_FR_PMR_HDR_PBL_PAGE_SIZE_LOG_PGSZ_16K   0x2UL
+	#define SQ_FR_PMR_HDR_PBL_PAGE_SIZE_LOG_PGSZ_32K   0x3UL
+	#define SQ_FR_PMR_HDR_PBL_PAGE_SIZE_LOG_PGSZ_64K   0x4UL
+	#define SQ_FR_PMR_HDR_PBL_PAGE_SIZE_LOG_PGSZ_128K  0x5UL
+	#define SQ_FR_PMR_HDR_PBL_PAGE_SIZE_LOG_PGSZ_256K  0x6UL
+	#define SQ_FR_PMR_HDR_PBL_PAGE_SIZE_LOG_PGSZ_512K  0x7UL
+	#define SQ_FR_PMR_HDR_PBL_PAGE_SIZE_LOG_PGSZ_1M    0x8UL
+	#define SQ_FR_PMR_HDR_PBL_PAGE_SIZE_LOG_PGSZ_2M    0x9UL
+	#define SQ_FR_PMR_HDR_PBL_PAGE_SIZE_LOG_PGSZ_4M    0xaUL
+	#define SQ_FR_PMR_HDR_PBL_PAGE_SIZE_LOG_PGSZ_8M    0xbUL
+	#define SQ_FR_PMR_HDR_PBL_PAGE_SIZE_LOG_PGSZ_16M   0xcUL
+	#define SQ_FR_PMR_HDR_PBL_PAGE_SIZE_LOG_PGSZ_32M   0xdUL
+	#define SQ_FR_PMR_HDR_PBL_PAGE_SIZE_LOG_PGSZ_64M   0xeUL
+	#define SQ_FR_PMR_HDR_PBL_PAGE_SIZE_LOG_PGSZ_128M  0xfUL
+	#define SQ_FR_PMR_HDR_PBL_PAGE_SIZE_LOG_PGSZ_256M  0x10UL
+	#define SQ_FR_PMR_HDR_PBL_PAGE_SIZE_LOG_PGSZ_512M  0x11UL
+	#define SQ_FR_PMR_HDR_PBL_PAGE_SIZE_LOG_PGSZ_1G    0x12UL
+	#define SQ_FR_PMR_HDR_PBL_PAGE_SIZE_LOG_PGSZ_2G    0x13UL
+	#define SQ_FR_PMR_HDR_PBL_PAGE_SIZE_LOG_PGSZ_4G    0x14UL
+	#define SQ_FR_PMR_HDR_PBL_PAGE_SIZE_LOG_PGSZ_8G    0x15UL
+	#define SQ_FR_PMR_HDR_PBL_PAGE_SIZE_LOG_PGSZ_16G   0x16UL
+	#define SQ_FR_PMR_HDR_PBL_PAGE_SIZE_LOG_PGSZ_32G   0x17UL
+	#define SQ_FR_PMR_HDR_PBL_PAGE_SIZE_LOG_PGSZ_64G   0x18UL
+	#define SQ_FR_PMR_HDR_PBL_PAGE_SIZE_LOG_PGSZ_128G  0x19UL
+	#define SQ_FR_PMR_HDR_PBL_PAGE_SIZE_LOG_PGSZ_256G  0x1aUL
+	#define SQ_FR_PMR_HDR_PBL_PAGE_SIZE_LOG_PGSZ_512G  0x1bUL
+	#define SQ_FR_PMR_HDR_PBL_PAGE_SIZE_LOG_PGSZ_1T    0x1cUL
+	#define SQ_FR_PMR_HDR_PBL_PAGE_SIZE_LOG_PGSZ_2T    0x1dUL
+	#define SQ_FR_PMR_HDR_PBL_PAGE_SIZE_LOG_PGSZ_4T    0x1eUL
+	#define SQ_FR_PMR_HDR_PBL_PAGE_SIZE_LOG_PGSZ_8T    0x1fUL
+	#define SQ_FR_PMR_HDR_PBL_PAGE_SIZE_LOG_LAST      SQ_FR_PMR_HDR_PBL_PAGE_SIZE_LOG_PGSZ_8T
+	#define SQ_FR_PMR_HDR_NUMLEVELS_MASK             0xc0UL
+	#define SQ_FR_PMR_HDR_NUMLEVELS_SFT              6
+	#define SQ_FR_PMR_HDR_NUMLEVELS_PHYSICAL           (0x0UL << 6)
+	#define SQ_FR_PMR_HDR_NUMLEVELS_LAYER1             (0x1UL << 6)
+	#define SQ_FR_PMR_HDR_NUMLEVELS_LAYER2             (0x2UL << 6)
+	#define SQ_FR_PMR_HDR_NUMLEVELS_LAST              SQ_FR_PMR_HDR_NUMLEVELS_LAYER2
+	__le64	pblptr;
+	__le64	va;
+};
+
+/* sq_bind (size:1024b/128B) */
+struct sq_bind {
+	u8	wqe_type;
+	#define SQ_BIND_WQE_TYPE_BIND 0xeUL
+	#define SQ_BIND_WQE_TYPE_LAST SQ_BIND_WQE_TYPE_BIND
+	u8	flags;
+	#define SQ_BIND_FLAGS_INLINE_SE_UC_FENCE_RD_OR_ATOMIC_FENCE_SIGNAL_COMP_MASK                   0xffUL
+	#define SQ_BIND_FLAGS_INLINE_SE_UC_FENCE_RD_OR_ATOMIC_FENCE_SIGNAL_COMP_SFT                    0
+	#define SQ_BIND_FLAGS_SIGNAL_COMP                                                              0x1UL
+	#define SQ_BIND_FLAGS_RD_OR_ATOMIC_FENCE                                                       0x2UL
+	#define SQ_BIND_FLAGS_UC_FENCE                                                                 0x4UL
+	#define SQ_BIND_FLAGS_SE                                                                       0x8UL
+	#define SQ_BIND_FLAGS_INLINE                                                                   0x10UL
+	#define SQ_BIND_FLAGS_WQE_TS_EN                                                                0x20UL
+	#define SQ_BIND_FLAGS_DEBUG_TRACE                                                              0x40UL
+	u8	access_cntl;
+	#define SQ_BIND_ACCESS_CNTL_WINDOW_BIND_REMOTE_ATOMIC_REMOTE_WRITE_REMOTE_READ_LOCAL_WRITE_MASK              0xffUL
+	#define SQ_BIND_ACCESS_CNTL_WINDOW_BIND_REMOTE_ATOMIC_REMOTE_WRITE_REMOTE_READ_LOCAL_WRITE_SFT               0
+	#define SQ_BIND_ACCESS_CNTL_LOCAL_WRITE                                                                      0x1UL
+	#define SQ_BIND_ACCESS_CNTL_REMOTE_READ                                                                      0x2UL
+	#define SQ_BIND_ACCESS_CNTL_REMOTE_WRITE                                                                     0x4UL
+	#define SQ_BIND_ACCESS_CNTL_REMOTE_ATOMIC                                                                    0x8UL
+	#define SQ_BIND_ACCESS_CNTL_WINDOW_BIND                                                                      0x10UL
+	u8	reserved8_1;
+	u8	mw_type_zero_based;
+	#define SQ_BIND_ZERO_BASED     0x1UL
+	#define SQ_BIND_MW_TYPE        0x2UL
+	#define SQ_BIND_MW_TYPE_TYPE1    (0x0UL << 1)
+	#define SQ_BIND_MW_TYPE_TYPE2    (0x1UL << 1)
+	#define SQ_BIND_MW_TYPE_LAST    SQ_BIND_MW_TYPE_TYPE2
+	u8	reserved8_2;
+	__le16	reserved16;
+	__le32	parent_l_key;
+	__le32	l_key;
+	__le64	va;
+	u8	length[5];
+	u8	reserved24[3];
+	__le32	data[24];
+};
+
+/* sq_bind_hdr (size:256b/32B) */
+struct sq_bind_hdr {
+	u8	wqe_type;
+	#define SQ_BIND_HDR_WQE_TYPE_BIND 0xeUL
+	#define SQ_BIND_HDR_WQE_TYPE_LAST SQ_BIND_HDR_WQE_TYPE_BIND
+	u8	flags;
+	#define SQ_BIND_HDR_FLAGS_INLINE_SE_UC_FENCE_RD_OR_ATOMIC_FENCE_SIGNAL_COMP_MASK                   0xffUL
+	#define SQ_BIND_HDR_FLAGS_INLINE_SE_UC_FENCE_RD_OR_ATOMIC_FENCE_SIGNAL_COMP_SFT                    0
+	#define SQ_BIND_HDR_FLAGS_SIGNAL_COMP                                                              0x1UL
+	#define SQ_BIND_HDR_FLAGS_RD_OR_ATOMIC_FENCE                                                       0x2UL
+	#define SQ_BIND_HDR_FLAGS_UC_FENCE                                                                 0x4UL
+	#define SQ_BIND_HDR_FLAGS_SE                                                                       0x8UL
+	#define SQ_BIND_HDR_FLAGS_INLINE                                                                   0x10UL
+	#define SQ_BIND_HDR_FLAGS_WQE_TS_EN                                                                0x20UL
+	#define SQ_BIND_HDR_FLAGS_DEBUG_TRACE                                                              0x40UL
+	u8	access_cntl;
+	#define SQ_BIND_HDR_ACCESS_CNTL_WINDOW_BIND_REMOTE_ATOMIC_REMOTE_WRITE_REMOTE_READ_LOCAL_WRITE_MASK              0xffUL
+	#define SQ_BIND_HDR_ACCESS_CNTL_WINDOW_BIND_REMOTE_ATOMIC_REMOTE_WRITE_REMOTE_READ_LOCAL_WRITE_SFT               0
+	#define SQ_BIND_HDR_ACCESS_CNTL_LOCAL_WRITE                                                                      0x1UL
+	#define SQ_BIND_HDR_ACCESS_CNTL_REMOTE_READ                                                                      0x2UL
+	#define SQ_BIND_HDR_ACCESS_CNTL_REMOTE_WRITE                                                                     0x4UL
+	#define SQ_BIND_HDR_ACCESS_CNTL_REMOTE_ATOMIC                                                                    0x8UL
+	#define SQ_BIND_HDR_ACCESS_CNTL_WINDOW_BIND                                                                      0x10UL
+	u8	reserved8_1;
+	u8	mw_type_zero_based;
+	#define SQ_BIND_HDR_ZERO_BASED     0x1UL
+	#define SQ_BIND_HDR_MW_TYPE        0x2UL
+	#define SQ_BIND_HDR_MW_TYPE_TYPE1    (0x0UL << 1)
+	#define SQ_BIND_HDR_MW_TYPE_TYPE2    (0x1UL << 1)
+	#define SQ_BIND_HDR_MW_TYPE_LAST    SQ_BIND_HDR_MW_TYPE_TYPE2
+	u8	reserved8_2;
+	__le16	reserved16;
+	__le32	parent_l_key;
+	__le32	l_key;
+	__le64	va;
+	u8	length[5];
+	u8	reserved24[3];
+};
+
+/* sq_msn_search_v3 (size:128b/16B) */
+struct sq_msn_search_v3 {
+	__le64	idx_psn;
+	#define SQ_MSN_SEARCH_V3_START_PSN_MASK 0xffffffUL
+	#define SQ_MSN_SEARCH_V3_START_PSN_SFT 0
+	#define SQ_MSN_SEARCH_V3_NEXT_PSN_MASK 0xffffff000000ULL
+	#define SQ_MSN_SEARCH_V3_NEXT_PSN_SFT  24
+	#define SQ_MSN_SEARCH_V3_START_IDX_MASK 0xffff000000000000ULL
+	#define SQ_MSN_SEARCH_V3_START_IDX_SFT 48
+	__le32	wqe_opaque;
+	u8	wqe_size;
+	u8	signal;
+	#define SQ_MSN_SEARCH_V3_SGNLD                        0x1UL
+	#define SQ_MSN_SEARCH_V3_PREV_SGNLD_LOCAL_MEM_WQE     0x2UL
+	__le16	reserved;
+};
+
+/* sq_send_v3 (size:1024b/128B) */
+struct sq_send_v3 {
+	u8	wqe_type;
+	#define SQ_SEND_V3_WQE_TYPE_SEND_V3           0x10UL
+	#define SQ_SEND_V3_WQE_TYPE_SEND_W_IMMED_V3   0x11UL
+	#define SQ_SEND_V3_WQE_TYPE_SEND_W_INVALID_V3 0x12UL
+	#define SQ_SEND_V3_WQE_TYPE_LAST             SQ_SEND_V3_WQE_TYPE_SEND_W_INVALID_V3
+	u8	flags;
+	#define SQ_SEND_V3_FLAGS_SIGNAL_COMP            0x1UL
+	#define SQ_SEND_V3_FLAGS_RD_OR_ATOMIC_FENCE     0x2UL
+	#define SQ_SEND_V3_FLAGS_UC_FENCE               0x4UL
+	#define SQ_SEND_V3_FLAGS_SE                     0x8UL
+	#define SQ_SEND_V3_FLAGS_INLINE                 0x10UL
+	#define SQ_SEND_V3_FLAGS_WQE_TS_EN              0x20UL
+	#define SQ_SEND_V3_FLAGS_DEBUG_TRACE            0x40UL
+	u8	wqe_size;
+	#define SQ_SEND_V3_WQE_SIZE_MASK 0x3fUL
+	#define SQ_SEND_V3_WQE_SIZE_SFT 0
+	u8	inline_length;
+	#define SQ_SEND_V3_INLINE_LENGTH_MASK 0xfUL
+	#define SQ_SEND_V3_INLINE_LENGTH_SFT 0
+	__le32	opaque;
+	__le32	inv_key_or_imm_data;
+	__le32	timestamp;
+	#define SQ_SEND_V3_TIMESTAMP_MASK 0xffffffUL
+	#define SQ_SEND_V3_TIMESTAMP_SFT 0
+	__le32	data[28];
+};
+
+/* sq_send_hdr_v3 (size:128b/16B) */
+struct sq_send_hdr_v3 {
+	u8	wqe_type;
+	#define SQ_SEND_HDR_V3_WQE_TYPE_SEND_V3           0x10UL
+	#define SQ_SEND_HDR_V3_WQE_TYPE_SEND_W_IMMED_V3   0x11UL
+	#define SQ_SEND_HDR_V3_WQE_TYPE_SEND_W_INVALID_V3 0x12UL
+	#define SQ_SEND_HDR_V3_WQE_TYPE_LAST             SQ_SEND_HDR_V3_WQE_TYPE_SEND_W_INVALID_V3
+	u8	flags;
+	#define SQ_SEND_HDR_V3_FLAGS_SIGNAL_COMP            0x1UL
+	#define SQ_SEND_HDR_V3_FLAGS_RD_OR_ATOMIC_FENCE     0x2UL
+	#define SQ_SEND_HDR_V3_FLAGS_UC_FENCE               0x4UL
+	#define SQ_SEND_HDR_V3_FLAGS_SE                     0x8UL
+	#define SQ_SEND_HDR_V3_FLAGS_INLINE                 0x10UL
+	#define SQ_SEND_HDR_V3_FLAGS_WQE_TS_EN              0x20UL
+	#define SQ_SEND_HDR_V3_FLAGS_DEBUG_TRACE            0x40UL
+	u8	wqe_size;
+	#define SQ_SEND_HDR_V3_WQE_SIZE_MASK 0x3fUL
+	#define SQ_SEND_HDR_V3_WQE_SIZE_SFT 0
+	u8	inline_length;
+	#define SQ_SEND_HDR_V3_INLINE_LENGTH_MASK 0xfUL
+	#define SQ_SEND_HDR_V3_INLINE_LENGTH_SFT 0
+	__le32	opaque;
+	__le32	inv_key_or_imm_data;
+	__le32	timestamp;
+	#define SQ_SEND_HDR_V3_TIMESTAMP_MASK 0xffffffUL
+	#define SQ_SEND_HDR_V3_TIMESTAMP_SFT 0
+};
+
+/* sq_rawqp1send_v3 (size:1024b/128B) */
+struct sq_rawqp1send_v3 {
+	u8	wqe_type;
+	#define SQ_RAWQP1SEND_V3_WQE_TYPE_RAWQP1SEND_V3 0x1dUL
+	#define SQ_RAWQP1SEND_V3_WQE_TYPE_LAST         SQ_RAWQP1SEND_V3_WQE_TYPE_RAWQP1SEND_V3
+	u8	flags;
+	#define SQ_RAWQP1SEND_V3_FLAGS_SIGNAL_COMP            0x1UL
+	#define SQ_RAWQP1SEND_V3_FLAGS_RD_OR_ATOMIC_FENCE     0x2UL
+	#define SQ_RAWQP1SEND_V3_FLAGS_UC_FENCE               0x4UL
+	#define SQ_RAWQP1SEND_V3_FLAGS_SE                     0x8UL
+	#define SQ_RAWQP1SEND_V3_FLAGS_INLINE                 0x10UL
+	#define SQ_RAWQP1SEND_V3_FLAGS_WQE_TS_EN              0x20UL
+	#define SQ_RAWQP1SEND_V3_FLAGS_DEBUG_TRACE            0x40UL
+	u8	wqe_size;
+	#define SQ_RAWQP1SEND_V3_WQE_SIZE_MASK 0x3fUL
+	#define SQ_RAWQP1SEND_V3_WQE_SIZE_SFT 0
+	u8	inline_length;
+	#define SQ_RAWQP1SEND_V3_INLINE_LENGTH_MASK 0xfUL
+	#define SQ_RAWQP1SEND_V3_INLINE_LENGTH_SFT 0
+	__le32	opaque;
+	__le16	lflags;
+	#define SQ_RAWQP1SEND_V3_LFLAGS_TCP_UDP_CHKSUM     0x1UL
+	#define SQ_RAWQP1SEND_V3_LFLAGS_IP_CHKSUM          0x2UL
+	#define SQ_RAWQP1SEND_V3_LFLAGS_NOCRC              0x4UL
+	#define SQ_RAWQP1SEND_V3_LFLAGS_T_IP_CHKSUM        0x10UL
+	#define SQ_RAWQP1SEND_V3_LFLAGS_OT_IP_CHKSUM       0x20UL
+	#define SQ_RAWQP1SEND_V3_LFLAGS_ROCE_CRC           0x100UL
+	#define SQ_RAWQP1SEND_V3_LFLAGS_FCOE_CRC           0x200UL
+	__le16	cfa_action;
+	__le16	cfa_action_high;
+	#define SQ_RAWQP1SEND_V3_CFA_ACTION_HIGH_MASK 0x3ffUL
+	#define SQ_RAWQP1SEND_V3_CFA_ACTION_HIGH_SFT 0
+	__le16	reserved_2;
+	__le32	cfa_meta;
+	#define SQ_RAWQP1SEND_V3_CFA_META_VLAN_VID_MASK     0xfffUL
+	#define SQ_RAWQP1SEND_V3_CFA_META_VLAN_VID_SFT      0
+	#define SQ_RAWQP1SEND_V3_CFA_META_VLAN_DE           0x1000UL
+	#define SQ_RAWQP1SEND_V3_CFA_META_VLAN_PRI_MASK     0xe000UL
+	#define SQ_RAWQP1SEND_V3_CFA_META_VLAN_PRI_SFT      13
+	#define SQ_RAWQP1SEND_V3_CFA_META_VLAN_TPID_MASK    0x70000UL
+	#define SQ_RAWQP1SEND_V3_CFA_META_VLAN_TPID_SFT     16
+	#define SQ_RAWQP1SEND_V3_CFA_META_VLAN_TPID_TPID88A8  (0x0UL << 16)
+	#define SQ_RAWQP1SEND_V3_CFA_META_VLAN_TPID_TPID8100  (0x1UL << 16)
+	#define SQ_RAWQP1SEND_V3_CFA_META_VLAN_TPID_TPID9100  (0x2UL << 16)
+	#define SQ_RAWQP1SEND_V3_CFA_META_VLAN_TPID_TPID9200  (0x3UL << 16)
+	#define SQ_RAWQP1SEND_V3_CFA_META_VLAN_TPID_TPID9300  (0x4UL << 16)
+	#define SQ_RAWQP1SEND_V3_CFA_META_VLAN_TPID_TPIDCFG   (0x5UL << 16)
+	#define SQ_RAWQP1SEND_V3_CFA_META_VLAN_TPID_LAST     SQ_RAWQP1SEND_V3_CFA_META_VLAN_TPID_TPIDCFG
+	#define SQ_RAWQP1SEND_V3_CFA_META_VLAN_RESERVED_MASK 0xff80000UL
+	#define SQ_RAWQP1SEND_V3_CFA_META_VLAN_RESERVED_SFT 19
+	#define SQ_RAWQP1SEND_V3_CFA_META_KEY_MASK          0xf0000000UL
+	#define SQ_RAWQP1SEND_V3_CFA_META_KEY_SFT           28
+	#define SQ_RAWQP1SEND_V3_CFA_META_KEY_NONE            (0x0UL << 28)
+	#define SQ_RAWQP1SEND_V3_CFA_META_KEY_VLAN_TAG        (0x1UL << 28)
+	#define SQ_RAWQP1SEND_V3_CFA_META_KEY_LAST           SQ_RAWQP1SEND_V3_CFA_META_KEY_VLAN_TAG
+	__le32	timestamp;
+	#define SQ_RAWQP1SEND_V3_TIMESTAMP_MASK 0xffffffUL
+	#define SQ_RAWQP1SEND_V3_TIMESTAMP_SFT 0
+	__le64	reserved_3;
+	__le32	data[24];
+};
+
+/* sq_rawqp1send_hdr_v3 (size:256b/32B) */
+struct sq_rawqp1send_hdr_v3 {
+	u8	wqe_type;
+	#define SQ_RAWQP1SEND_HDR_V3_WQE_TYPE_RAWQP1SEND_V3 0x1dUL
+	#define SQ_RAWQP1SEND_HDR_V3_WQE_TYPE_LAST         SQ_RAWQP1SEND_HDR_V3_WQE_TYPE_RAWQP1SEND_V3
+	u8	flags;
+	#define SQ_RAWQP1SEND_HDR_V3_FLAGS_SIGNAL_COMP            0x1UL
+	#define SQ_RAWQP1SEND_HDR_V3_FLAGS_RD_OR_ATOMIC_FENCE     0x2UL
+	#define SQ_RAWQP1SEND_HDR_V3_FLAGS_UC_FENCE               0x4UL
+	#define SQ_RAWQP1SEND_HDR_V3_FLAGS_SE                     0x8UL
+	#define SQ_RAWQP1SEND_HDR_V3_FLAGS_INLINE                 0x10UL
+	#define SQ_RAWQP1SEND_HDR_V3_FLAGS_WQE_TS_EN              0x20UL
+	#define SQ_RAWQP1SEND_HDR_V3_FLAGS_DEBUG_TRACE            0x40UL
+	u8	wqe_size;
+	#define SQ_RAWQP1SEND_HDR_V3_WQE_SIZE_MASK 0x3fUL
+	#define SQ_RAWQP1SEND_HDR_V3_WQE_SIZE_SFT 0
+	u8	inline_length;
+	#define SQ_RAWQP1SEND_HDR_V3_INLINE_LENGTH_MASK 0xfUL
+	#define SQ_RAWQP1SEND_HDR_V3_INLINE_LENGTH_SFT 0
+	__le32	opaque;
+	__le16	lflags;
+	#define SQ_RAWQP1SEND_HDR_V3_LFLAGS_TCP_UDP_CHKSUM     0x1UL
+	#define SQ_RAWQP1SEND_HDR_V3_LFLAGS_IP_CHKSUM          0x2UL
+	#define SQ_RAWQP1SEND_HDR_V3_LFLAGS_NOCRC              0x4UL
+	#define SQ_RAWQP1SEND_HDR_V3_LFLAGS_T_IP_CHKSUM        0x10UL
+	#define SQ_RAWQP1SEND_HDR_V3_LFLAGS_OT_IP_CHKSUM       0x20UL
+	#define SQ_RAWQP1SEND_HDR_V3_LFLAGS_ROCE_CRC           0x100UL
+	#define SQ_RAWQP1SEND_HDR_V3_LFLAGS_FCOE_CRC           0x200UL
+	__le16	cfa_action;
+	__le16	cfa_action_high;
+	#define SQ_RAWQP1SEND_HDR_V3_CFA_ACTION_HIGH_MASK 0x3ffUL
+	#define SQ_RAWQP1SEND_HDR_V3_CFA_ACTION_HIGH_SFT 0
+	__le16	reserved_2;
+	__le32	cfa_meta;
+	#define SQ_RAWQP1SEND_HDR_V3_CFA_META_VLAN_VID_MASK     0xfffUL
+	#define SQ_RAWQP1SEND_HDR_V3_CFA_META_VLAN_VID_SFT      0
+	#define SQ_RAWQP1SEND_HDR_V3_CFA_META_VLAN_DE           0x1000UL
+	#define SQ_RAWQP1SEND_HDR_V3_CFA_META_VLAN_PRI_MASK     0xe000UL
+	#define SQ_RAWQP1SEND_HDR_V3_CFA_META_VLAN_PRI_SFT      13
+	#define SQ_RAWQP1SEND_HDR_V3_CFA_META_VLAN_TPID_MASK    0x70000UL
+	#define SQ_RAWQP1SEND_HDR_V3_CFA_META_VLAN_TPID_SFT     16
+	#define SQ_RAWQP1SEND_HDR_V3_CFA_META_VLAN_TPID_TPID88A8  (0x0UL << 16)
+	#define SQ_RAWQP1SEND_HDR_V3_CFA_META_VLAN_TPID_TPID8100  (0x1UL << 16)
+	#define SQ_RAWQP1SEND_HDR_V3_CFA_META_VLAN_TPID_TPID9100  (0x2UL << 16)
+	#define SQ_RAWQP1SEND_HDR_V3_CFA_META_VLAN_TPID_TPID9200  (0x3UL << 16)
+	#define SQ_RAWQP1SEND_HDR_V3_CFA_META_VLAN_TPID_TPID9300  (0x4UL << 16)
+	#define SQ_RAWQP1SEND_HDR_V3_CFA_META_VLAN_TPID_TPIDCFG   (0x5UL << 16)
+	#define SQ_RAWQP1SEND_HDR_V3_CFA_META_VLAN_TPID_LAST     SQ_RAWQP1SEND_HDR_V3_CFA_META_VLAN_TPID_TPIDCFG
+	#define SQ_RAWQP1SEND_HDR_V3_CFA_META_VLAN_RESERVED_MASK 0xff80000UL
+	#define SQ_RAWQP1SEND_HDR_V3_CFA_META_VLAN_RESERVED_SFT 19
+	#define SQ_RAWQP1SEND_HDR_V3_CFA_META_KEY_MASK          0xf0000000UL
+	#define SQ_RAWQP1SEND_HDR_V3_CFA_META_KEY_SFT           28
+	#define SQ_RAWQP1SEND_HDR_V3_CFA_META_KEY_NONE            (0x0UL << 28)
+	#define SQ_RAWQP1SEND_HDR_V3_CFA_META_KEY_VLAN_TAG        (0x1UL << 28)
+	#define SQ_RAWQP1SEND_HDR_V3_CFA_META_KEY_LAST           SQ_RAWQP1SEND_HDR_V3_CFA_META_KEY_VLAN_TAG
+	__le32	timestamp;
+	#define SQ_RAWQP1SEND_HDR_V3_TIMESTAMP_MASK 0xffffffUL
+	#define SQ_RAWQP1SEND_HDR_V3_TIMESTAMP_SFT 0
+	__le64	reserved_3;
+};
+
+/* sq_udsend_v3 (size:1024b/128B) */
+struct sq_udsend_v3 {
+	u8	wqe_type;
+	#define SQ_UDSEND_V3_WQE_TYPE_UDSEND_V3         0x13UL
+	#define SQ_UDSEND_V3_WQE_TYPE_UDSEND_W_IMMED_V3 0x14UL
+	#define SQ_UDSEND_V3_WQE_TYPE_LAST             SQ_UDSEND_V3_WQE_TYPE_UDSEND_W_IMMED_V3
+	u8	flags;
+	#define SQ_UDSEND_V3_FLAGS_SIGNAL_COMP            0x1UL
+	#define SQ_UDSEND_V3_FLAGS_RD_OR_ATOMIC_FENCE     0x2UL
+	#define SQ_UDSEND_V3_FLAGS_UC_FENCE               0x4UL
+	#define SQ_UDSEND_V3_FLAGS_SE                     0x8UL
+	#define SQ_UDSEND_V3_FLAGS_INLINE                 0x10UL
+	#define SQ_UDSEND_V3_FLAGS_WQE_TS_EN              0x20UL
+	#define SQ_UDSEND_V3_FLAGS_DEBUG_TRACE            0x40UL
+	u8	wqe_size;
+	#define SQ_UDSEND_V3_WQE_SIZE_MASK 0x3fUL
+	#define SQ_UDSEND_V3_WQE_SIZE_SFT 0
+	u8	inline_length;
+	#define SQ_UDSEND_V3_INLINE_LENGTH_MASK 0xfUL
+	#define SQ_UDSEND_V3_INLINE_LENGTH_SFT 0
+	__le32	opaque;
+	__le32	imm_data;
+	__le32	q_key;
+	__le32	dst_qp;
+	#define SQ_UDSEND_V3_DST_QP_MASK 0xffffffUL
+	#define SQ_UDSEND_V3_DST_QP_SFT 0
+	__le32	avid;
+	#define SQ_UDSEND_V3_AVID_MASK 0xfffffUL
+	#define SQ_UDSEND_V3_AVID_SFT 0
+	__le32	reserved2;
+	__le32	timestamp;
+	#define SQ_UDSEND_V3_TIMESTAMP_MASK 0xffffffUL
+	#define SQ_UDSEND_V3_TIMESTAMP_SFT 0
+	__le32	data[24];
+};
+
+/* sq_udsend_hdr_v3 (size:256b/32B) */
+struct sq_udsend_hdr_v3 {
+	u8	wqe_type;
+	#define SQ_UDSEND_HDR_V3_WQE_TYPE_UDSEND_V3         0x13UL
+	#define SQ_UDSEND_HDR_V3_WQE_TYPE_UDSEND_W_IMMED_V3 0x14UL
+	#define SQ_UDSEND_HDR_V3_WQE_TYPE_LAST             SQ_UDSEND_HDR_V3_WQE_TYPE_UDSEND_W_IMMED_V3
+	u8	flags;
+	#define SQ_UDSEND_HDR_V3_FLAGS_SIGNAL_COMP            0x1UL
+	#define SQ_UDSEND_HDR_V3_FLAGS_RD_OR_ATOMIC_FENCE     0x2UL
+	#define SQ_UDSEND_HDR_V3_FLAGS_UC_FENCE               0x4UL
+	#define SQ_UDSEND_HDR_V3_FLAGS_SE                     0x8UL
+	#define SQ_UDSEND_HDR_V3_FLAGS_INLINE                 0x10UL
+	#define SQ_UDSEND_HDR_V3_FLAGS_WQE_TS_EN              0x20UL
+	#define SQ_UDSEND_HDR_V3_FLAGS_DEBUG_TRACE            0x40UL
+	u8	wqe_size;
+	#define SQ_UDSEND_HDR_V3_WQE_SIZE_MASK 0x3fUL
+	#define SQ_UDSEND_HDR_V3_WQE_SIZE_SFT 0
+	u8	inline_length;
+	#define SQ_UDSEND_HDR_V3_INLINE_LENGTH_MASK 0xfUL
+	#define SQ_UDSEND_HDR_V3_INLINE_LENGTH_SFT 0
+	__le32	opaque;
+	__le32	imm_data;
+	__le32	q_key;
+	__le32	dst_qp;
+	#define SQ_UDSEND_HDR_V3_DST_QP_MASK 0xffffffUL
+	#define SQ_UDSEND_HDR_V3_DST_QP_SFT 0
+	__le32	avid;
+	#define SQ_UDSEND_HDR_V3_AVID_MASK 0xfffffUL
+	#define SQ_UDSEND_HDR_V3_AVID_SFT 0
+	__le32	reserved2;
+	__le32	timestamp;
+	#define SQ_UDSEND_HDR_V3_TIMESTAMP_MASK 0xffffffUL
+	#define SQ_UDSEND_HDR_V3_TIMESTAMP_SFT 0
+};
+
+/* sq_rdma_v3 (size:1024b/128B) */
+struct sq_rdma_v3 {
+	u8	wqe_type;
+	#define SQ_RDMA_V3_WQE_TYPE_WRITE_WQE_V3     0x15UL
+	#define SQ_RDMA_V3_WQE_TYPE_WRITE_W_IMMED_V3 0x16UL
+	#define SQ_RDMA_V3_WQE_TYPE_READ_WQE_V3      0x17UL
+	#define SQ_RDMA_V3_WQE_TYPE_LAST            SQ_RDMA_V3_WQE_TYPE_READ_WQE_V3
+	u8	flags;
+	#define SQ_RDMA_V3_FLAGS_SIGNAL_COMP            0x1UL
+	#define SQ_RDMA_V3_FLAGS_RD_OR_ATOMIC_FENCE     0x2UL
+	#define SQ_RDMA_V3_FLAGS_UC_FENCE               0x4UL
+	#define SQ_RDMA_V3_FLAGS_SE                     0x8UL
+	#define SQ_RDMA_V3_FLAGS_INLINE                 0x10UL
+	#define SQ_RDMA_V3_FLAGS_WQE_TS_EN              0x20UL
+	#define SQ_RDMA_V3_FLAGS_DEBUG_TRACE            0x40UL
+	u8	wqe_size;
+	#define SQ_RDMA_V3_WQE_SIZE_MASK 0x3fUL
+	#define SQ_RDMA_V3_WQE_SIZE_SFT 0
+	u8	inline_length;
+	#define SQ_RDMA_V3_INLINE_LENGTH_MASK 0xfUL
+	#define SQ_RDMA_V3_INLINE_LENGTH_SFT 0
+	__le32	opaque;
+	__le32	imm_data;
+	__le32	reserved2;
+	__le64	remote_va;
+	__le32	remote_key;
+	__le32	timestamp;
+	#define SQ_RDMA_V3_TIMESTAMP_MASK 0xffffffUL
+	#define SQ_RDMA_V3_TIMESTAMP_SFT 0
+	__le32	data[24];
+};
+
+/* sq_rdma_hdr_v3 (size:256b/32B) */
+struct sq_rdma_hdr_v3 {
+	u8	wqe_type;
+	#define SQ_RDMA_HDR_V3_WQE_TYPE_WRITE_WQE_V3     0x15UL
+	#define SQ_RDMA_HDR_V3_WQE_TYPE_WRITE_W_IMMED_V3 0x16UL
+	#define SQ_RDMA_HDR_V3_WQE_TYPE_READ_WQE_V3      0x17UL
+	#define SQ_RDMA_HDR_V3_WQE_TYPE_LAST            SQ_RDMA_HDR_V3_WQE_TYPE_READ_WQE_V3
+	u8	flags;
+	#define SQ_RDMA_HDR_V3_FLAGS_SIGNAL_COMP            0x1UL
+	#define SQ_RDMA_HDR_V3_FLAGS_RD_OR_ATOMIC_FENCE     0x2UL
+	#define SQ_RDMA_HDR_V3_FLAGS_UC_FENCE               0x4UL
+	#define SQ_RDMA_HDR_V3_FLAGS_SE                     0x8UL
+	#define SQ_RDMA_HDR_V3_FLAGS_INLINE                 0x10UL
+	#define SQ_RDMA_HDR_V3_FLAGS_WQE_TS_EN              0x20UL
+	#define SQ_RDMA_HDR_V3_FLAGS_DEBUG_TRACE            0x40UL
+	u8	wqe_size;
+	#define SQ_RDMA_HDR_V3_WQE_SIZE_MASK 0x3fUL
+	#define SQ_RDMA_HDR_V3_WQE_SIZE_SFT 0
+	u8	inline_length;
+	#define SQ_RDMA_HDR_V3_INLINE_LENGTH_MASK 0xfUL
+	#define SQ_RDMA_HDR_V3_INLINE_LENGTH_SFT 0
+	__le32	opaque;
+	__le32	imm_data;
+	__le32	reserved2;
+	__le64	remote_va;
+	__le32	remote_key;
+	__le32	timestamp;
+	#define SQ_RDMA_HDR_V3_TIMESTAMP_MASK 0xffffffUL
+	#define SQ_RDMA_HDR_V3_TIMESTAMP_SFT 0
+};
+
+/* sq_atomic_v3 (size:448b/56B) */
+struct sq_atomic_v3 {
+	u8	wqe_type;
+	#define SQ_ATOMIC_V3_WQE_TYPE_ATOMIC_CS_V3 0x18UL
+	#define SQ_ATOMIC_V3_WQE_TYPE_ATOMIC_FA_V3 0x19UL
+	#define SQ_ATOMIC_V3_WQE_TYPE_LAST        SQ_ATOMIC_V3_WQE_TYPE_ATOMIC_FA_V3
+	u8	flags;
+	#define SQ_ATOMIC_V3_FLAGS_SIGNAL_COMP            0x1UL
+	#define SQ_ATOMIC_V3_FLAGS_RD_OR_ATOMIC_FENCE     0x2UL
+	#define SQ_ATOMIC_V3_FLAGS_UC_FENCE               0x4UL
+	#define SQ_ATOMIC_V3_FLAGS_SE                     0x8UL
+	#define SQ_ATOMIC_V3_FLAGS_INLINE                 0x10UL
+	#define SQ_ATOMIC_V3_FLAGS_WQE_TS_EN              0x20UL
+	#define SQ_ATOMIC_V3_FLAGS_DEBUG_TRACE            0x40UL
+	u8	wqe_size;
+	#define SQ_ATOMIC_V3_WQE_SIZE_MASK 0x3fUL
+	#define SQ_ATOMIC_V3_WQE_SIZE_SFT 0
+	u8	reserved1;
+	__le32	opaque;
+	__le32	remote_key;
+	__le32	reserved2;
+	__le64	remote_va;
+	__le64	swap_data;
+	__le64	cmp_data;
+	__le64	va_or_pa;
+	__le32	l_key;
+	__le32	size;
+};
+
+/* sq_atomic_hdr_v3 (size:320b/40B) */
+struct sq_atomic_hdr_v3 {
+	u8	wqe_type;
+	#define SQ_ATOMIC_HDR_V3_WQE_TYPE_ATOMIC_CS_V3 0x18UL
+	#define SQ_ATOMIC_HDR_V3_WQE_TYPE_ATOMIC_FA_V3 0x19UL
+	#define SQ_ATOMIC_HDR_V3_WQE_TYPE_LAST        SQ_ATOMIC_HDR_V3_WQE_TYPE_ATOMIC_FA_V3
+	u8	flags;
+	#define SQ_ATOMIC_HDR_V3_FLAGS_SIGNAL_COMP            0x1UL
+	#define SQ_ATOMIC_HDR_V3_FLAGS_RD_OR_ATOMIC_FENCE     0x2UL
+	#define SQ_ATOMIC_HDR_V3_FLAGS_UC_FENCE               0x4UL
+	#define SQ_ATOMIC_HDR_V3_FLAGS_SE                     0x8UL
+	#define SQ_ATOMIC_HDR_V3_FLAGS_INLINE                 0x10UL
+	#define SQ_ATOMIC_HDR_V3_FLAGS_WQE_TS_EN              0x20UL
+	#define SQ_ATOMIC_HDR_V3_FLAGS_DEBUG_TRACE            0x40UL
+	u8	wqe_size;
+	#define SQ_ATOMIC_HDR_V3_WQE_SIZE_MASK 0x3fUL
+	#define SQ_ATOMIC_HDR_V3_WQE_SIZE_SFT 0
+	u8	reserved1;
+	__le32	opaque;
+	__le32	remote_key;
+	__le32	reserved2;
+	__le64	remote_va;
+	__le64	swap_data;
+	__le64	cmp_data;
+};
+
+/* sq_localinvalidate_v3 (size:128b/16B) */
+struct sq_localinvalidate_v3 {
+	u8	wqe_type;
+	#define SQ_LOCALINVALIDATE_V3_WQE_TYPE_LOCAL_INVALID_V3 0x1aUL
+	#define SQ_LOCALINVALIDATE_V3_WQE_TYPE_LAST            SQ_LOCALINVALIDATE_V3_WQE_TYPE_LOCAL_INVALID_V3
+	u8	flags;
+	#define SQ_LOCALINVALIDATE_V3_FLAGS_SIGNAL_COMP            0x1UL
+	#define SQ_LOCALINVALIDATE_V3_FLAGS_RD_OR_ATOMIC_FENCE     0x2UL
+	#define SQ_LOCALINVALIDATE_V3_FLAGS_UC_FENCE               0x4UL
+	#define SQ_LOCALINVALIDATE_V3_FLAGS_SE                     0x8UL
+	#define SQ_LOCALINVALIDATE_V3_FLAGS_INLINE                 0x10UL
+	#define SQ_LOCALINVALIDATE_V3_FLAGS_WQE_TS_EN              0x20UL
+	#define SQ_LOCALINVALIDATE_V3_FLAGS_DEBUG_TRACE            0x40UL
+	u8	wqe_size;
+	#define SQ_LOCALINVALIDATE_V3_WQE_SIZE_MASK 0x3fUL
+	#define SQ_LOCALINVALIDATE_V3_WQE_SIZE_SFT 0
+	u8	reserved1;
+	__le32	opaque;
+	__le32	inv_l_key;
+	__le32	reserved2;
+};
+
+/* sq_localinvalidate_hdr_v3 (size:128b/16B) */
+struct sq_localinvalidate_hdr_v3 {
+	u8	wqe_type;
+	#define SQ_LOCALINVALIDATE_HDR_V3_WQE_TYPE_LOCAL_INVALID_V3 0x1aUL
+	#define SQ_LOCALINVALIDATE_HDR_V3_WQE_TYPE_LAST            SQ_LOCALINVALIDATE_HDR_V3_WQE_TYPE_LOCAL_INVALID_V3
+	u8	flags;
+	#define SQ_LOCALINVALIDATE_HDR_V3_FLAGS_SIGNAL_COMP            0x1UL
+	#define SQ_LOCALINVALIDATE_HDR_V3_FLAGS_RD_OR_ATOMIC_FENCE     0x2UL
+	#define SQ_LOCALINVALIDATE_HDR_V3_FLAGS_UC_FENCE               0x4UL
+	#define SQ_LOCALINVALIDATE_HDR_V3_FLAGS_SE                     0x8UL
+	#define SQ_LOCALINVALIDATE_HDR_V3_FLAGS_INLINE                 0x10UL
+	#define SQ_LOCALINVALIDATE_HDR_V3_FLAGS_WQE_TS_EN              0x20UL
+	#define SQ_LOCALINVALIDATE_HDR_V3_FLAGS_DEBUG_TRACE            0x40UL
+	u8	wqe_size;
+	#define SQ_LOCALINVALIDATE_HDR_V3_WQE_SIZE_MASK 0x3fUL
+	#define SQ_LOCALINVALIDATE_HDR_V3_WQE_SIZE_SFT 0
+	u8	reserved1;
+	__le32	opaque;
+	__le32	inv_l_key;
+	__le32	reserved2;
+};
+
+/* sq_fr_pmr_v3 (size:320b/40B) */
+struct sq_fr_pmr_v3 {
+	u8	wqe_type;
+	#define SQ_FR_PMR_V3_WQE_TYPE_FR_PMR_V3 0x1bUL
+	#define SQ_FR_PMR_V3_WQE_TYPE_LAST     SQ_FR_PMR_V3_WQE_TYPE_FR_PMR_V3
+	u8	flags;
+	#define SQ_FR_PMR_V3_FLAGS_SIGNAL_COMP            0x1UL
+	#define SQ_FR_PMR_V3_FLAGS_RD_OR_ATOMIC_FENCE     0x2UL
+	#define SQ_FR_PMR_V3_FLAGS_UC_FENCE               0x4UL
+	#define SQ_FR_PMR_V3_FLAGS_SE                     0x8UL
+	#define SQ_FR_PMR_V3_FLAGS_INLINE                 0x10UL
+	#define SQ_FR_PMR_V3_FLAGS_WQE_TS_EN              0x20UL
+	#define SQ_FR_PMR_V3_FLAGS_DEBUG_TRACE            0x40UL
+	u8	wqe_size_zero_based;
+	#define SQ_FR_PMR_V3_WQE_SIZE_MASK  0x3fUL
+	#define SQ_FR_PMR_V3_WQE_SIZE_SFT   0
+	#define SQ_FR_PMR_V3_ZERO_BASED     0x40UL
+	u8	access_cntl;
+	#define SQ_FR_PMR_V3_ACCESS_CNTL_LOCAL_WRITE       0x1UL
+	#define SQ_FR_PMR_V3_ACCESS_CNTL_REMOTE_READ       0x2UL
+	#define SQ_FR_PMR_V3_ACCESS_CNTL_REMOTE_WRITE      0x4UL
+	#define SQ_FR_PMR_V3_ACCESS_CNTL_REMOTE_ATOMIC     0x8UL
+	#define SQ_FR_PMR_V3_ACCESS_CNTL_WINDOW_BIND       0x10UL
+	__le32	opaque;
+	__le32	l_key;
+	__le16	page_size_log;
+	#define SQ_FR_PMR_V3_PAGE_SIZE_LOG_MASK         0x1fUL
+	#define SQ_FR_PMR_V3_PAGE_SIZE_LOG_SFT          0
+	#define SQ_FR_PMR_V3_PAGE_SIZE_LOG_PGSZ_4K        0x0UL
+	#define SQ_FR_PMR_V3_PAGE_SIZE_LOG_PGSZ_8K        0x1UL
+	#define SQ_FR_PMR_V3_PAGE_SIZE_LOG_PGSZ_16K       0x2UL
+	#define SQ_FR_PMR_V3_PAGE_SIZE_LOG_PGSZ_32K       0x3UL
+	#define SQ_FR_PMR_V3_PAGE_SIZE_LOG_PGSZ_64K       0x4UL
+	#define SQ_FR_PMR_V3_PAGE_SIZE_LOG_PGSZ_128K      0x5UL
+	#define SQ_FR_PMR_V3_PAGE_SIZE_LOG_PGSZ_256K      0x6UL
+	#define SQ_FR_PMR_V3_PAGE_SIZE_LOG_PGSZ_512K      0x7UL
+	#define SQ_FR_PMR_V3_PAGE_SIZE_LOG_PGSZ_1M        0x8UL
+	#define SQ_FR_PMR_V3_PAGE_SIZE_LOG_PGSZ_2M        0x9UL
+	#define SQ_FR_PMR_V3_PAGE_SIZE_LOG_PGSZ_4M        0xaUL
+	#define SQ_FR_PMR_V3_PAGE_SIZE_LOG_PGSZ_8M        0xbUL
+	#define SQ_FR_PMR_V3_PAGE_SIZE_LOG_PGSZ_16M       0xcUL
+	#define SQ_FR_PMR_V3_PAGE_SIZE_LOG_PGSZ_32M       0xdUL
+	#define SQ_FR_PMR_V3_PAGE_SIZE_LOG_PGSZ_64M       0xeUL
+	#define SQ_FR_PMR_V3_PAGE_SIZE_LOG_PGSZ_128M      0xfUL
+	#define SQ_FR_PMR_V3_PAGE_SIZE_LOG_PGSZ_256M      0x10UL
+	#define SQ_FR_PMR_V3_PAGE_SIZE_LOG_PGSZ_512M      0x11UL
+	#define SQ_FR_PMR_V3_PAGE_SIZE_LOG_PGSZ_1G        0x12UL
+	#define SQ_FR_PMR_V3_PAGE_SIZE_LOG_PGSZ_2G        0x13UL
+	#define SQ_FR_PMR_V3_PAGE_SIZE_LOG_PGSZ_4G        0x14UL
+	#define SQ_FR_PMR_V3_PAGE_SIZE_LOG_PGSZ_8G        0x15UL
+	#define SQ_FR_PMR_V3_PAGE_SIZE_LOG_PGSZ_16G       0x16UL
+	#define SQ_FR_PMR_V3_PAGE_SIZE_LOG_PGSZ_32G       0x17UL
+	#define SQ_FR_PMR_V3_PAGE_SIZE_LOG_PGSZ_64G       0x18UL
+	#define SQ_FR_PMR_V3_PAGE_SIZE_LOG_PGSZ_128G      0x19UL
+	#define SQ_FR_PMR_V3_PAGE_SIZE_LOG_PGSZ_256G      0x1aUL
+	#define SQ_FR_PMR_V3_PAGE_SIZE_LOG_PGSZ_512G      0x1bUL
+	#define SQ_FR_PMR_V3_PAGE_SIZE_LOG_PGSZ_1T        0x1cUL
+	#define SQ_FR_PMR_V3_PAGE_SIZE_LOG_PGSZ_2T        0x1dUL
+	#define SQ_FR_PMR_V3_PAGE_SIZE_LOG_PGSZ_4T        0x1eUL
+	#define SQ_FR_PMR_V3_PAGE_SIZE_LOG_PGSZ_8T        0x1fUL
+	#define SQ_FR_PMR_V3_PAGE_SIZE_LOG_LAST          SQ_FR_PMR_V3_PAGE_SIZE_LOG_PGSZ_8T
+	#define SQ_FR_PMR_V3_PBL_PAGE_SIZE_LOG_MASK     0x3e0UL
+	#define SQ_FR_PMR_V3_PBL_PAGE_SIZE_LOG_SFT      5
+	#define SQ_FR_PMR_V3_PBL_PAGE_SIZE_LOG_PGSZ_4K    (0x0UL << 5)
+	#define SQ_FR_PMR_V3_PBL_PAGE_SIZE_LOG_PGSZ_8K    (0x1UL << 5)
+	#define SQ_FR_PMR_V3_PBL_PAGE_SIZE_LOG_PGSZ_16K   (0x2UL << 5)
+	#define SQ_FR_PMR_V3_PBL_PAGE_SIZE_LOG_PGSZ_32K   (0x3UL << 5)
+	#define SQ_FR_PMR_V3_PBL_PAGE_SIZE_LOG_PGSZ_64K   (0x4UL << 5)
+	#define SQ_FR_PMR_V3_PBL_PAGE_SIZE_LOG_PGSZ_128K  (0x5UL << 5)
+	#define SQ_FR_PMR_V3_PBL_PAGE_SIZE_LOG_PGSZ_256K  (0x6UL << 5)
+	#define SQ_FR_PMR_V3_PBL_PAGE_SIZE_LOG_PGSZ_512K  (0x7UL << 5)
+	#define SQ_FR_PMR_V3_PBL_PAGE_SIZE_LOG_PGSZ_1M    (0x8UL << 5)
+	#define SQ_FR_PMR_V3_PBL_PAGE_SIZE_LOG_PGSZ_2M    (0x9UL << 5)
+	#define SQ_FR_PMR_V3_PBL_PAGE_SIZE_LOG_PGSZ_4M    (0xaUL << 5)
+	#define SQ_FR_PMR_V3_PBL_PAGE_SIZE_LOG_PGSZ_8M    (0xbUL << 5)
+	#define SQ_FR_PMR_V3_PBL_PAGE_SIZE_LOG_PGSZ_16M   (0xcUL << 5)
+	#define SQ_FR_PMR_V3_PBL_PAGE_SIZE_LOG_PGSZ_32M   (0xdUL << 5)
+	#define SQ_FR_PMR_V3_PBL_PAGE_SIZE_LOG_PGSZ_64M   (0xeUL << 5)
+	#define SQ_FR_PMR_V3_PBL_PAGE_SIZE_LOG_PGSZ_128M  (0xfUL << 5)
+	#define SQ_FR_PMR_V3_PBL_PAGE_SIZE_LOG_PGSZ_256M  (0x10UL << 5)
+	#define SQ_FR_PMR_V3_PBL_PAGE_SIZE_LOG_PGSZ_512M  (0x11UL << 5)
+	#define SQ_FR_PMR_V3_PBL_PAGE_SIZE_LOG_PGSZ_1G    (0x12UL << 5)
+	#define SQ_FR_PMR_V3_PBL_PAGE_SIZE_LOG_PGSZ_2G    (0x13UL << 5)
+	#define SQ_FR_PMR_V3_PBL_PAGE_SIZE_LOG_PGSZ_4G    (0x14UL << 5)
+	#define SQ_FR_PMR_V3_PBL_PAGE_SIZE_LOG_PGSZ_8G    (0x15UL << 5)
+	#define SQ_FR_PMR_V3_PBL_PAGE_SIZE_LOG_PGSZ_16G   (0x16UL << 5)
+	#define SQ_FR_PMR_V3_PBL_PAGE_SIZE_LOG_PGSZ_32G   (0x17UL << 5)
+	#define SQ_FR_PMR_V3_PBL_PAGE_SIZE_LOG_PGSZ_64G   (0x18UL << 5)
+	#define SQ_FR_PMR_V3_PBL_PAGE_SIZE_LOG_PGSZ_128G  (0x19UL << 5)
+	#define SQ_FR_PMR_V3_PBL_PAGE_SIZE_LOG_PGSZ_256G  (0x1aUL << 5)
+	#define SQ_FR_PMR_V3_PBL_PAGE_SIZE_LOG_PGSZ_512G  (0x1bUL << 5)
+	#define SQ_FR_PMR_V3_PBL_PAGE_SIZE_LOG_PGSZ_1T    (0x1cUL << 5)
+	#define SQ_FR_PMR_V3_PBL_PAGE_SIZE_LOG_PGSZ_2T    (0x1dUL << 5)
+	#define SQ_FR_PMR_V3_PBL_PAGE_SIZE_LOG_PGSZ_4T    (0x1eUL << 5)
+	#define SQ_FR_PMR_V3_PBL_PAGE_SIZE_LOG_PGSZ_8T    (0x1fUL << 5)
+	#define SQ_FR_PMR_V3_PBL_PAGE_SIZE_LOG_LAST      SQ_FR_PMR_V3_PBL_PAGE_SIZE_LOG_PGSZ_8T
+	#define SQ_FR_PMR_V3_NUMLEVELS_MASK             0xc00UL
+	#define SQ_FR_PMR_V3_NUMLEVELS_SFT              10
+	#define SQ_FR_PMR_V3_NUMLEVELS_PHYSICAL           (0x0UL << 10)
+	#define SQ_FR_PMR_V3_NUMLEVELS_LAYER1             (0x1UL << 10)
+	#define SQ_FR_PMR_V3_NUMLEVELS_LAYER2             (0x2UL << 10)
+	#define SQ_FR_PMR_V3_NUMLEVELS_LAST              SQ_FR_PMR_V3_NUMLEVELS_LAYER2
+	__le16	reserved;
+	__le64	va;
+	__le64	length;
+	__le64	pbl_ptr;
+};
+
+/* sq_fr_pmr_hdr_v3 (size:320b/40B) */
+struct sq_fr_pmr_hdr_v3 {
+	u8	wqe_type;
+	#define SQ_FR_PMR_HDR_V3_WQE_TYPE_FR_PMR_V3 0x1bUL
+	#define SQ_FR_PMR_HDR_V3_WQE_TYPE_LAST     SQ_FR_PMR_HDR_V3_WQE_TYPE_FR_PMR_V3
+	u8	flags;
+	#define SQ_FR_PMR_HDR_V3_FLAGS_SIGNAL_COMP            0x1UL
+	#define SQ_FR_PMR_HDR_V3_FLAGS_RD_OR_ATOMIC_FENCE     0x2UL
+	#define SQ_FR_PMR_HDR_V3_FLAGS_UC_FENCE               0x4UL
+	#define SQ_FR_PMR_HDR_V3_FLAGS_SE                     0x8UL
+	#define SQ_FR_PMR_HDR_V3_FLAGS_INLINE                 0x10UL
+	#define SQ_FR_PMR_HDR_V3_FLAGS_WQE_TS_EN              0x20UL
+	#define SQ_FR_PMR_HDR_V3_FLAGS_DEBUG_TRACE            0x40UL
+	u8	wqe_size_zero_based;
+	#define SQ_FR_PMR_HDR_V3_WQE_SIZE_MASK  0x3fUL
+	#define SQ_FR_PMR_HDR_V3_WQE_SIZE_SFT   0
+	#define SQ_FR_PMR_HDR_V3_ZERO_BASED     0x40UL
+	u8	access_cntl;
+	#define SQ_FR_PMR_HDR_V3_ACCESS_CNTL_LOCAL_WRITE       0x1UL
+	#define SQ_FR_PMR_HDR_V3_ACCESS_CNTL_REMOTE_READ       0x2UL
+	#define SQ_FR_PMR_HDR_V3_ACCESS_CNTL_REMOTE_WRITE      0x4UL
+	#define SQ_FR_PMR_HDR_V3_ACCESS_CNTL_REMOTE_ATOMIC     0x8UL
+	#define SQ_FR_PMR_HDR_V3_ACCESS_CNTL_WINDOW_BIND       0x10UL
+	__le32	opaque;
+	__le32	l_key;
+	__le16	page_size_log;
+	#define SQ_FR_PMR_HDR_V3_PAGE_SIZE_LOG_MASK         0x1fUL
+	#define SQ_FR_PMR_HDR_V3_PAGE_SIZE_LOG_SFT          0
+	#define SQ_FR_PMR_HDR_V3_PAGE_SIZE_LOG_PGSZ_4K        0x0UL
+	#define SQ_FR_PMR_HDR_V3_PAGE_SIZE_LOG_PGSZ_8K        0x1UL
+	#define SQ_FR_PMR_HDR_V3_PAGE_SIZE_LOG_PGSZ_16K       0x2UL
+	#define SQ_FR_PMR_HDR_V3_PAGE_SIZE_LOG_PGSZ_32K       0x3UL
+	#define SQ_FR_PMR_HDR_V3_PAGE_SIZE_LOG_PGSZ_64K       0x4UL
+	#define SQ_FR_PMR_HDR_V3_PAGE_SIZE_LOG_PGSZ_128K      0x5UL
+	#define SQ_FR_PMR_HDR_V3_PAGE_SIZE_LOG_PGSZ_256K      0x6UL
+	#define SQ_FR_PMR_HDR_V3_PAGE_SIZE_LOG_PGSZ_512K      0x7UL
+	#define SQ_FR_PMR_HDR_V3_PAGE_SIZE_LOG_PGSZ_1M        0x8UL
+	#define SQ_FR_PMR_HDR_V3_PAGE_SIZE_LOG_PGSZ_2M        0x9UL
+	#define SQ_FR_PMR_HDR_V3_PAGE_SIZE_LOG_PGSZ_4M        0xaUL
+	#define SQ_FR_PMR_HDR_V3_PAGE_SIZE_LOG_PGSZ_8M        0xbUL
+	#define SQ_FR_PMR_HDR_V3_PAGE_SIZE_LOG_PGSZ_16M       0xcUL
+	#define SQ_FR_PMR_HDR_V3_PAGE_SIZE_LOG_PGSZ_32M       0xdUL
+	#define SQ_FR_PMR_HDR_V3_PAGE_SIZE_LOG_PGSZ_64M       0xeUL
+	#define SQ_FR_PMR_HDR_V3_PAGE_SIZE_LOG_PGSZ_128M      0xfUL
+	#define SQ_FR_PMR_HDR_V3_PAGE_SIZE_LOG_PGSZ_256M      0x10UL
+	#define SQ_FR_PMR_HDR_V3_PAGE_SIZE_LOG_PGSZ_512M      0x11UL
+	#define SQ_FR_PMR_HDR_V3_PAGE_SIZE_LOG_PGSZ_1G        0x12UL
+	#define SQ_FR_PMR_HDR_V3_PAGE_SIZE_LOG_PGSZ_2G        0x13UL
+	#define SQ_FR_PMR_HDR_V3_PAGE_SIZE_LOG_PGSZ_4G        0x14UL
+	#define SQ_FR_PMR_HDR_V3_PAGE_SIZE_LOG_PGSZ_8G        0x15UL
+	#define SQ_FR_PMR_HDR_V3_PAGE_SIZE_LOG_PGSZ_16G       0x16UL
+	#define SQ_FR_PMR_HDR_V3_PAGE_SIZE_LOG_PGSZ_32G       0x17UL
+	#define SQ_FR_PMR_HDR_V3_PAGE_SIZE_LOG_PGSZ_64G       0x18UL
+	#define SQ_FR_PMR_HDR_V3_PAGE_SIZE_LOG_PGSZ_128G      0x19UL
+	#define SQ_FR_PMR_HDR_V3_PAGE_SIZE_LOG_PGSZ_256G      0x1aUL
+	#define SQ_FR_PMR_HDR_V3_PAGE_SIZE_LOG_PGSZ_512G      0x1bUL
+	#define SQ_FR_PMR_HDR_V3_PAGE_SIZE_LOG_PGSZ_1T        0x1cUL
+	#define SQ_FR_PMR_HDR_V3_PAGE_SIZE_LOG_PGSZ_2T        0x1dUL
+	#define SQ_FR_PMR_HDR_V3_PAGE_SIZE_LOG_PGSZ_4T        0x1eUL
+	#define SQ_FR_PMR_HDR_V3_PAGE_SIZE_LOG_PGSZ_8T        0x1fUL
+	#define SQ_FR_PMR_HDR_V3_PAGE_SIZE_LOG_LAST          SQ_FR_PMR_HDR_V3_PAGE_SIZE_LOG_PGSZ_8T
+	#define SQ_FR_PMR_HDR_V3_PBL_PAGE_SIZE_LOG_MASK     0x3e0UL
+	#define SQ_FR_PMR_HDR_V3_PBL_PAGE_SIZE_LOG_SFT      5
+	#define SQ_FR_PMR_HDR_V3_PBL_PAGE_SIZE_LOG_PGSZ_4K    (0x0UL << 5)
+	#define SQ_FR_PMR_HDR_V3_PBL_PAGE_SIZE_LOG_PGSZ_8K    (0x1UL << 5)
+	#define SQ_FR_PMR_HDR_V3_PBL_PAGE_SIZE_LOG_PGSZ_16K   (0x2UL << 5)
+	#define SQ_FR_PMR_HDR_V3_PBL_PAGE_SIZE_LOG_PGSZ_32K   (0x3UL << 5)
+	#define SQ_FR_PMR_HDR_V3_PBL_PAGE_SIZE_LOG_PGSZ_64K   (0x4UL << 5)
+	#define SQ_FR_PMR_HDR_V3_PBL_PAGE_SIZE_LOG_PGSZ_128K  (0x5UL << 5)
+	#define SQ_FR_PMR_HDR_V3_PBL_PAGE_SIZE_LOG_PGSZ_256K  (0x6UL << 5)
+	#define SQ_FR_PMR_HDR_V3_PBL_PAGE_SIZE_LOG_PGSZ_512K  (0x7UL << 5)
+	#define SQ_FR_PMR_HDR_V3_PBL_PAGE_SIZE_LOG_PGSZ_1M    (0x8UL << 5)
+	#define SQ_FR_PMR_HDR_V3_PBL_PAGE_SIZE_LOG_PGSZ_2M    (0x9UL << 5)
+	#define SQ_FR_PMR_HDR_V3_PBL_PAGE_SIZE_LOG_PGSZ_4M    (0xaUL << 5)
+	#define SQ_FR_PMR_HDR_V3_PBL_PAGE_SIZE_LOG_PGSZ_8M    (0xbUL << 5)
+	#define SQ_FR_PMR_HDR_V3_PBL_PAGE_SIZE_LOG_PGSZ_16M   (0xcUL << 5)
+	#define SQ_FR_PMR_HDR_V3_PBL_PAGE_SIZE_LOG_PGSZ_32M   (0xdUL << 5)
+	#define SQ_FR_PMR_HDR_V3_PBL_PAGE_SIZE_LOG_PGSZ_64M   (0xeUL << 5)
+	#define SQ_FR_PMR_HDR_V3_PBL_PAGE_SIZE_LOG_PGSZ_128M  (0xfUL << 5)
+	#define SQ_FR_PMR_HDR_V3_PBL_PAGE_SIZE_LOG_PGSZ_256M  (0x10UL << 5)
+	#define SQ_FR_PMR_HDR_V3_PBL_PAGE_SIZE_LOG_PGSZ_512M  (0x11UL << 5)
+	#define SQ_FR_PMR_HDR_V3_PBL_PAGE_SIZE_LOG_PGSZ_1G    (0x12UL << 5)
+	#define SQ_FR_PMR_HDR_V3_PBL_PAGE_SIZE_LOG_PGSZ_2G    (0x13UL << 5)
+	#define SQ_FR_PMR_HDR_V3_PBL_PAGE_SIZE_LOG_PGSZ_4G    (0x14UL << 5)
+	#define SQ_FR_PMR_HDR_V3_PBL_PAGE_SIZE_LOG_PGSZ_8G    (0x15UL << 5)
+	#define SQ_FR_PMR_HDR_V3_PBL_PAGE_SIZE_LOG_PGSZ_16G   (0x16UL << 5)
+	#define SQ_FR_PMR_HDR_V3_PBL_PAGE_SIZE_LOG_PGSZ_32G   (0x17UL << 5)
+	#define SQ_FR_PMR_HDR_V3_PBL_PAGE_SIZE_LOG_PGSZ_64G   (0x18UL << 5)
+	#define SQ_FR_PMR_HDR_V3_PBL_PAGE_SIZE_LOG_PGSZ_128G  (0x19UL << 5)
+	#define SQ_FR_PMR_HDR_V3_PBL_PAGE_SIZE_LOG_PGSZ_256G  (0x1aUL << 5)
+	#define SQ_FR_PMR_HDR_V3_PBL_PAGE_SIZE_LOG_PGSZ_512G  (0x1bUL << 5)
+	#define SQ_FR_PMR_HDR_V3_PBL_PAGE_SIZE_LOG_PGSZ_1T    (0x1cUL << 5)
+	#define SQ_FR_PMR_HDR_V3_PBL_PAGE_SIZE_LOG_PGSZ_2T    (0x1dUL << 5)
+	#define SQ_FR_PMR_HDR_V3_PBL_PAGE_SIZE_LOG_PGSZ_4T    (0x1eUL << 5)
+	#define SQ_FR_PMR_HDR_V3_PBL_PAGE_SIZE_LOG_PGSZ_8T    (0x1fUL << 5)
+	#define SQ_FR_PMR_HDR_V3_PBL_PAGE_SIZE_LOG_LAST      SQ_FR_PMR_HDR_V3_PBL_PAGE_SIZE_LOG_PGSZ_8T
+	#define SQ_FR_PMR_HDR_V3_NUMLEVELS_MASK             0xc00UL
+	#define SQ_FR_PMR_HDR_V3_NUMLEVELS_SFT              10
+	#define SQ_FR_PMR_HDR_V3_NUMLEVELS_PHYSICAL           (0x0UL << 10)
+	#define SQ_FR_PMR_HDR_V3_NUMLEVELS_LAYER1             (0x1UL << 10)
+	#define SQ_FR_PMR_HDR_V3_NUMLEVELS_LAYER2             (0x2UL << 10)
+	#define SQ_FR_PMR_HDR_V3_NUMLEVELS_LAST              SQ_FR_PMR_HDR_V3_NUMLEVELS_LAYER2
+	__le16	reserved;
+	__le64	va;
+	__le64	length;
+	__le64	pbl_ptr;
+};
+
+/* sq_bind_v3 (size:256b/32B) */
+struct sq_bind_v3 {
+	u8	wqe_type;
+	#define SQ_BIND_V3_WQE_TYPE_BIND_V3 0x1cUL
+	#define SQ_BIND_V3_WQE_TYPE_LAST   SQ_BIND_V3_WQE_TYPE_BIND_V3
+	u8	flags;
+	#define SQ_BIND_V3_FLAGS_SIGNAL_COMP            0x1UL
+	#define SQ_BIND_V3_FLAGS_RD_OR_ATOMIC_FENCE     0x2UL
+	#define SQ_BIND_V3_FLAGS_UC_FENCE               0x4UL
+	#define SQ_BIND_V3_FLAGS_SE                     0x8UL
+	#define SQ_BIND_V3_FLAGS_INLINE                 0x10UL
+	#define SQ_BIND_V3_FLAGS_WQE_TS_EN              0x20UL
+	#define SQ_BIND_V3_FLAGS_DEBUG_TRACE            0x40UL
+	u8	wqe_size_zero_based_mw_type;
+	#define SQ_BIND_V3_WQE_SIZE_MASK  0x3fUL
+	#define SQ_BIND_V3_WQE_SIZE_SFT   0
+	#define SQ_BIND_V3_ZERO_BASED     0x40UL
+	#define SQ_BIND_V3_MW_TYPE        0x80UL
+	#define SQ_BIND_V3__TYPE1           (0x0UL << 7)
+	#define SQ_BIND_V3__TYPE2           (0x1UL << 7)
+	#define SQ_BIND_V3__LAST           SQ_BIND_V3__TYPE2
+	u8	access_cntl;
+	#define SQ_BIND_V3_ACCESS_CNTL_LOCAL_WRITE       0x1UL
+	#define SQ_BIND_V3_ACCESS_CNTL_REMOTE_READ       0x2UL
+	#define SQ_BIND_V3_ACCESS_CNTL_REMOTE_WRITE      0x4UL
+	#define SQ_BIND_V3_ACCESS_CNTL_REMOTE_ATOMIC     0x8UL
+	#define SQ_BIND_V3_ACCESS_CNTL_WINDOW_BIND       0x10UL
+	__le32	opaque;
+	__le32	parent_l_key;
+	__le32	l_key;
+	__le64	va;
+	__le64	length;
+};
+
+/* sq_bind_hdr_v3 (size:256b/32B) */
+struct sq_bind_hdr_v3 {
+	u8	wqe_type;
+	#define SQ_BIND_HDR_V3_WQE_TYPE_BIND_V3 0x1cUL
+	#define SQ_BIND_HDR_V3_WQE_TYPE_LAST   SQ_BIND_HDR_V3_WQE_TYPE_BIND_V3
+	u8	flags;
+	#define SQ_BIND_HDR_V3_FLAGS_SIGNAL_COMP            0x1UL
+	#define SQ_BIND_HDR_V3_FLAGS_RD_OR_ATOMIC_FENCE     0x2UL
+	#define SQ_BIND_HDR_V3_FLAGS_UC_FENCE               0x4UL
+	#define SQ_BIND_HDR_V3_FLAGS_SE                     0x8UL
+	#define SQ_BIND_HDR_V3_FLAGS_INLINE                 0x10UL
+	#define SQ_BIND_HDR_V3_FLAGS_WQE_TS_EN              0x20UL
+	#define SQ_BIND_HDR_V3_FLAGS_DEBUG_TRACE            0x40UL
+	u8	wqe_size_zero_based_mw_type;
+	#define SQ_BIND_HDR_V3_WQE_SIZE_MASK  0x3fUL
+	#define SQ_BIND_HDR_V3_WQE_SIZE_SFT   0
+	#define SQ_BIND_HDR_V3_ZERO_BASED     0x40UL
+	#define SQ_BIND_HDR_V3_MW_TYPE        0x80UL
+	#define SQ_BIND_HDR_V3__TYPE1           (0x0UL << 7)
+	#define SQ_BIND_HDR_V3__TYPE2           (0x1UL << 7)
+	#define SQ_BIND_HDR_V3__LAST           SQ_BIND_HDR_V3__TYPE2
+	u8	access_cntl;
+	#define SQ_BIND_HDR_V3_ACCESS_CNTL_LOCAL_WRITE       0x1UL
+	#define SQ_BIND_HDR_V3_ACCESS_CNTL_REMOTE_READ       0x2UL
+	#define SQ_BIND_HDR_V3_ACCESS_CNTL_REMOTE_WRITE      0x4UL
+	#define SQ_BIND_HDR_V3_ACCESS_CNTL_REMOTE_ATOMIC     0x8UL
+	#define SQ_BIND_HDR_V3_ACCESS_CNTL_WINDOW_BIND       0x10UL
+	__le32	opaque;
+	__le32	parent_l_key;
+	__le32	l_key;
+	__le64	va;
+	__le64	length;
+};
+
+/* sq_change_udpsrcport_v3 (size:128b/16B) */
+struct sq_change_udpsrcport_v3 {
+	u8	wqe_type;
+	#define SQ_CHANGE_UDPSRCPORT_V3_WQE_TYPE_CHANGE_UDPSRCPORT_V3 0x1eUL
+	#define SQ_CHANGE_UDPSRCPORT_V3_WQE_TYPE_LAST                SQ_CHANGE_UDPSRCPORT_V3_WQE_TYPE_CHANGE_UDPSRCPORT_V3
+	u8	flags;
+	#define SQ_CHANGE_UDPSRCPORT_V3_FLAGS_SIGNAL_COMP            0x1UL
+	#define SQ_CHANGE_UDPSRCPORT_V3_FLAGS_RD_OR_ATOMIC_FENCE     0x2UL
+	#define SQ_CHANGE_UDPSRCPORT_V3_FLAGS_UC_FENCE               0x4UL
+	#define SQ_CHANGE_UDPSRCPORT_V3_FLAGS_SE                     0x8UL
+	#define SQ_CHANGE_UDPSRCPORT_V3_FLAGS_INLINE                 0x10UL
+	#define SQ_CHANGE_UDPSRCPORT_V3_FLAGS_WQE_TS_EN              0x20UL
+	#define SQ_CHANGE_UDPSRCPORT_V3_FLAGS_DEBUG_TRACE            0x40UL
+	u8	wqe_size;
+	#define SQ_CHANGE_UDPSRCPORT_V3_WQE_SIZE_MASK 0x3fUL
+	#define SQ_CHANGE_UDPSRCPORT_V3_WQE_SIZE_SFT 0
+	u8	reserved_1;
+	__le32	opaque;
+	__le16	udp_src_port;
+	__le16	reserved_2;
+	__le32	reserved_3;
+};
+
+/* sq_change_udpsrcport_hdr_v3 (size:128b/16B) */
+struct sq_change_udpsrcport_hdr_v3 {
+	u8	wqe_type;
+	#define SQ_CHANGE_UDPSRCPORT_HDR_V3_WQE_TYPE_CHANGE_UDPSRCPORT_V3 0x1eUL
+	#define SQ_CHANGE_UDPSRCPORT_HDR_V3_WQE_TYPE_LAST                SQ_CHANGE_UDPSRCPORT_HDR_V3_WQE_TYPE_CHANGE_UDPSRCPORT_V3
+	u8	flags;
+	#define SQ_CHANGE_UDPSRCPORT_HDR_V3_FLAGS_SIGNAL_COMP            0x1UL
+	#define SQ_CHANGE_UDPSRCPORT_HDR_V3_FLAGS_RD_OR_ATOMIC_FENCE     0x2UL
+	#define SQ_CHANGE_UDPSRCPORT_HDR_V3_FLAGS_UC_FENCE               0x4UL
+	#define SQ_CHANGE_UDPSRCPORT_HDR_V3_FLAGS_SE                     0x8UL
+	#define SQ_CHANGE_UDPSRCPORT_HDR_V3_FLAGS_INLINE                 0x10UL
+	#define SQ_CHANGE_UDPSRCPORT_HDR_V3_FLAGS_WQE_TS_EN              0x20UL
+	#define SQ_CHANGE_UDPSRCPORT_HDR_V3_FLAGS_DEBUG_TRACE            0x40UL
+	u8	wqe_size;
+	#define SQ_CHANGE_UDPSRCPORT_HDR_V3_WQE_SIZE_MASK 0x3fUL
+	#define SQ_CHANGE_UDPSRCPORT_HDR_V3_WQE_SIZE_SFT 0
+	u8	reserved_1;
+	__le32	opaque;
+	__le16	udp_src_port;
+	__le16	reserved_2;
+	__le32	reserved_3;
+};
+
+/* rq_wqe (size:1024b/128B) */
+struct rq_wqe {
+	u8	wqe_type;
+	#define RQ_WQE_WQE_TYPE_RCV 0x80UL
+	#define RQ_WQE_WQE_TYPE_LAST RQ_WQE_WQE_TYPE_RCV
+	u8	flags;
+	u8	wqe_size;
+	u8	reserved8;
+	__le32	reserved32;
+	__le32	wr_id[2];
+	#define RQ_WQE_WR_ID_MASK 0xfffffUL
+	#define RQ_WQE_WR_ID_SFT 0
+	u8	reserved128[16];
+	__le32	data[24];
+};
+
+/* rq_wqe_hdr (size:256b/32B) */
+struct rq_wqe_hdr {
+	u8	wqe_type;
+	#define RQ_WQE_HDR_WQE_TYPE_RCV 0x80UL
+	#define RQ_WQE_HDR_WQE_TYPE_LAST RQ_WQE_HDR_WQE_TYPE_RCV
+	u8	flags;
+	u8	wqe_size;
+	u8	reserved8;
+	__le32	reserved32;
+	__le32	wr_id[2];
+	#define RQ_WQE_HDR_WR_ID_MASK 0xfffffUL
+	#define RQ_WQE_HDR_WR_ID_SFT 0
+	u8	reserved128[16];
+};
+
+/* rq_wqe_v3 (size:4096b/512B) */
+struct rq_wqe_v3 {
+	u8	wqe_type;
+	#define RQ_WQE_V3_WQE_TYPE_RCV_V3 0x90UL
+	#define RQ_WQE_V3_WQE_TYPE_LAST  RQ_WQE_V3_WQE_TYPE_RCV_V3
+	u8	flags;
+	u8	wqe_size;
+	u8	reserved1;
+	__le32	opaque;
+	__le64	reserved2;
+	__le32	data[124];
+};
+
+/* rq_wqe_hdr_v3 (size:128b/16B) */
+struct rq_wqe_hdr_v3 {
+	u8	wqe_type;
+	#define RQ_WQE_HDR_V3_WQE_TYPE_RCV_V3 0x90UL
+	#define RQ_WQE_HDR_V3_WQE_TYPE_LAST  RQ_WQE_HDR_V3_WQE_TYPE_RCV_V3
+	u8	flags;
+	u8	wqe_size;
+	u8	reserved1;
+	__le32	opaque;
+	__le64	reserved2;
+};
+
+/* cq_base (size:256b/32B) */
+struct cq_base {
+	__le64	reserved64_1;
+	__le64	reserved64_2;
+	__le64	reserved64_3;
+	u8	cqe_type_toggle;
+	#define CQ_BASE_TOGGLE                    0x1UL
+	#define CQ_BASE_CQE_TYPE_MASK             0x1eUL
+	#define CQ_BASE_CQE_TYPE_SFT              1
+	#define CQ_BASE_CQE_TYPE_REQ                (0x0UL << 1)
+	#define CQ_BASE_CQE_TYPE_RES_RC             (0x1UL << 1)
+	#define CQ_BASE_CQE_TYPE_RES_UD             (0x2UL << 1)
+	#define CQ_BASE_CQE_TYPE_RES_RAWETH_QP1     (0x3UL << 1)
+	#define CQ_BASE_CQE_TYPE_RES_UD_CFA         (0x4UL << 1)
+	#define CQ_BASE_CQE_TYPE_REQ_V3             (0x8UL << 1)
+	#define CQ_BASE_CQE_TYPE_RES_RC_V3          (0x9UL << 1)
+	#define CQ_BASE_CQE_TYPE_RES_UD_V3          (0xaUL << 1)
+	#define CQ_BASE_CQE_TYPE_RES_RAWETH_QP1_V3  (0xbUL << 1)
+	#define CQ_BASE_CQE_TYPE_RES_UD_CFA_V3      (0xcUL << 1)
+	#define CQ_BASE_CQE_TYPE_NO_OP              (0xdUL << 1)
+	#define CQ_BASE_CQE_TYPE_TERMINAL           (0xeUL << 1)
+	#define CQ_BASE_CQE_TYPE_CUT_OFF            (0xfUL << 1)
+	#define CQ_BASE_CQE_TYPE_LAST              CQ_BASE_CQE_TYPE_CUT_OFF
+	u8	status;
+	#define CQ_BASE_STATUS_OK                         0x0UL
+	#define CQ_BASE_STATUS_BAD_RESPONSE_ERR           0x1UL
+	#define CQ_BASE_STATUS_LOCAL_LENGTH_ERR           0x2UL
+	#define CQ_BASE_STATUS_HW_LOCAL_LENGTH_ERR        0x3UL
+	#define CQ_BASE_STATUS_LOCAL_QP_OPERATION_ERR     0x4UL
+	#define CQ_BASE_STATUS_LOCAL_PROTECTION_ERR       0x5UL
+	#define CQ_BASE_STATUS_LOCAL_ACCESS_ERROR         0x6UL
+	#define CQ_BASE_STATUS_MEMORY_MGT_OPERATION_ERR   0x7UL
+	#define CQ_BASE_STATUS_REMOTE_INVALID_REQUEST_ERR 0x8UL
+	#define CQ_BASE_STATUS_REMOTE_ACCESS_ERR          0x9UL
+	#define CQ_BASE_STATUS_REMOTE_OPERATION_ERR       0xaUL
+	#define CQ_BASE_STATUS_RNR_NAK_RETRY_CNT_ERR      0xbUL
+	#define CQ_BASE_STATUS_TRANSPORT_RETRY_CNT_ERR    0xcUL
+	#define CQ_BASE_STATUS_WORK_REQUEST_FLUSHED_ERR   0xdUL
+	#define CQ_BASE_STATUS_HW_FLUSH_ERR               0xeUL
+	#define CQ_BASE_STATUS_OVERFLOW_ERR               0xfUL
+	#define CQ_BASE_STATUS_LAST                      CQ_BASE_STATUS_OVERFLOW_ERR
+	__le16	reserved16;
+	__le32	opaque;
+};
+
+/* cq_req (size:256b/32B) */
+struct cq_req {
+	__le64	qp_handle;
+	__le16	sq_cons_idx;
+	__le16	reserved16_1;
+	__le32	reserved32_2;
+	__le64	reserved64;
+	u8	cqe_type_toggle;
+	#define CQ_REQ_TOGGLE       0x1UL
+	#define CQ_REQ_CQE_TYPE_MASK 0x1eUL
+	#define CQ_REQ_CQE_TYPE_SFT 1
+	#define CQ_REQ_CQE_TYPE_REQ   (0x0UL << 1)
+	#define CQ_REQ_CQE_TYPE_LAST CQ_REQ_CQE_TYPE_REQ
+	#define CQ_REQ_PUSH         0x20UL
+	u8	status;
+	#define CQ_REQ_STATUS_OK                         0x0UL
+	#define CQ_REQ_STATUS_BAD_RESPONSE_ERR           0x1UL
+	#define CQ_REQ_STATUS_LOCAL_LENGTH_ERR           0x2UL
+	#define CQ_REQ_STATUS_LOCAL_QP_OPERATION_ERR     0x3UL
+	#define CQ_REQ_STATUS_LOCAL_PROTECTION_ERR       0x4UL
+	#define CQ_REQ_STATUS_MEMORY_MGT_OPERATION_ERR   0x5UL
+	#define CQ_REQ_STATUS_REMOTE_INVALID_REQUEST_ERR 0x6UL
+	#define CQ_REQ_STATUS_REMOTE_ACCESS_ERR          0x7UL
+	#define CQ_REQ_STATUS_REMOTE_OPERATION_ERR       0x8UL
+	#define CQ_REQ_STATUS_RNR_NAK_RETRY_CNT_ERR      0x9UL
+	#define CQ_REQ_STATUS_TRANSPORT_RETRY_CNT_ERR    0xaUL
+	#define CQ_REQ_STATUS_WORK_REQUEST_FLUSHED_ERR   0xbUL
+	#define CQ_REQ_STATUS_LAST                      CQ_REQ_STATUS_WORK_REQUEST_FLUSHED_ERR
+	__le16	reserved16_2;
+	__le32	reserved32_1;
+};
+
+/* cq_res_rc (size:256b/32B) */
+struct cq_res_rc {
+	__le32	length;
+	__le32	imm_data_or_inv_r_key;
+	__le64	qp_handle;
+	__le64	mr_handle;
+	u8	cqe_type_toggle;
+	#define CQ_RES_RC_TOGGLE         0x1UL
+	#define CQ_RES_RC_CQE_TYPE_MASK  0x1eUL
+	#define CQ_RES_RC_CQE_TYPE_SFT   1
+	#define CQ_RES_RC_CQE_TYPE_RES_RC  (0x1UL << 1)
+	#define CQ_RES_RC_CQE_TYPE_LAST   CQ_RES_RC_CQE_TYPE_RES_RC
+	u8	status;
+	#define CQ_RES_RC_STATUS_OK                         0x0UL
+	#define CQ_RES_RC_STATUS_LOCAL_ACCESS_ERROR         0x1UL
+	#define CQ_RES_RC_STATUS_LOCAL_LENGTH_ERR           0x2UL
+	#define CQ_RES_RC_STATUS_LOCAL_PROTECTION_ERR       0x3UL
+	#define CQ_RES_RC_STATUS_LOCAL_QP_OPERATION_ERR     0x4UL
+	#define CQ_RES_RC_STATUS_MEMORY_MGT_OPERATION_ERR   0x5UL
+	#define CQ_RES_RC_STATUS_REMOTE_INVALID_REQUEST_ERR 0x6UL
+	#define CQ_RES_RC_STATUS_WORK_REQUEST_FLUSHED_ERR   0x7UL
+	#define CQ_RES_RC_STATUS_HW_FLUSH_ERR               0x8UL
+	#define CQ_RES_RC_STATUS_LAST                      CQ_RES_RC_STATUS_HW_FLUSH_ERR
+	__le16	flags;
+	#define CQ_RES_RC_FLAGS_SRQ            0x1UL
+	#define CQ_RES_RC_FLAGS_SRQ_RQ           0x0UL
+	#define CQ_RES_RC_FLAGS_SRQ_SRQ          0x1UL
+	#define CQ_RES_RC_FLAGS_SRQ_LAST        CQ_RES_RC_FLAGS_SRQ_SRQ
+	#define CQ_RES_RC_FLAGS_IMM            0x2UL
+	#define CQ_RES_RC_FLAGS_INV            0x4UL
+	#define CQ_RES_RC_FLAGS_RDMA           0x8UL
+	#define CQ_RES_RC_FLAGS_RDMA_SEND        (0x0UL << 3)
+	#define CQ_RES_RC_FLAGS_RDMA_RDMA_WRITE  (0x1UL << 3)
+	#define CQ_RES_RC_FLAGS_RDMA_LAST       CQ_RES_RC_FLAGS_RDMA_RDMA_WRITE
+	__le32	srq_or_rq_wr_id;
+	#define CQ_RES_RC_SRQ_OR_RQ_WR_ID_MASK 0xfffffUL
+	#define CQ_RES_RC_SRQ_OR_RQ_WR_ID_SFT 0
+};
+
+/* cq_res_ud (size:256b/32B) */
+struct cq_res_ud {
+	__le16	length;
+	#define CQ_RES_UD_LENGTH_MASK 0x3fffUL
+	#define CQ_RES_UD_LENGTH_SFT 0
+	__le16	cfa_metadata;
+	#define CQ_RES_UD_CFA_METADATA_VID_MASK 0xfffUL
+	#define CQ_RES_UD_CFA_METADATA_VID_SFT 0
+	#define CQ_RES_UD_CFA_METADATA_DE      0x1000UL
+	#define CQ_RES_UD_CFA_METADATA_PRI_MASK 0xe000UL
+	#define CQ_RES_UD_CFA_METADATA_PRI_SFT 13
+	__le32	imm_data;
+	__le64	qp_handle;
+	__le16	src_mac[3];
+	__le16	src_qp_low;
+	u8	cqe_type_toggle;
+	#define CQ_RES_UD_TOGGLE         0x1UL
+	#define CQ_RES_UD_CQE_TYPE_MASK  0x1eUL
+	#define CQ_RES_UD_CQE_TYPE_SFT   1
+	#define CQ_RES_UD_CQE_TYPE_RES_UD  (0x2UL << 1)
+	#define CQ_RES_UD_CQE_TYPE_LAST   CQ_RES_UD_CQE_TYPE_RES_UD
+	u8	status;
+	#define CQ_RES_UD_STATUS_OK                       0x0UL
+	#define CQ_RES_UD_STATUS_LOCAL_ACCESS_ERROR       0x1UL
+	#define CQ_RES_UD_STATUS_HW_LOCAL_LENGTH_ERR      0x2UL
+	#define CQ_RES_UD_STATUS_LOCAL_PROTECTION_ERR     0x3UL
+	#define CQ_RES_UD_STATUS_LOCAL_QP_OPERATION_ERR   0x4UL
+	#define CQ_RES_UD_STATUS_MEMORY_MGT_OPERATION_ERR 0x5UL
+	#define CQ_RES_UD_STATUS_WORK_REQUEST_FLUSHED_ERR 0x7UL
+	#define CQ_RES_UD_STATUS_HW_FLUSH_ERR             0x8UL
+	#define CQ_RES_UD_STATUS_LAST                    CQ_RES_UD_STATUS_HW_FLUSH_ERR
+	__le16	flags;
+	#define CQ_RES_UD_FLAGS_SRQ                   0x1UL
+	#define CQ_RES_UD_FLAGS_SRQ_RQ                  0x0UL
+	#define CQ_RES_UD_FLAGS_SRQ_SRQ                 0x1UL
+	#define CQ_RES_UD_FLAGS_SRQ_LAST               CQ_RES_UD_FLAGS_SRQ_SRQ
+	#define CQ_RES_UD_FLAGS_IMM                   0x2UL
+	#define CQ_RES_UD_FLAGS_UNUSED_MASK           0xcUL
+	#define CQ_RES_UD_FLAGS_UNUSED_SFT            2
+	#define CQ_RES_UD_FLAGS_ROCE_IP_VER_MASK      0x30UL
+	#define CQ_RES_UD_FLAGS_ROCE_IP_VER_SFT       4
+	#define CQ_RES_UD_FLAGS_ROCE_IP_VER_V1          (0x0UL << 4)
+	#define CQ_RES_UD_FLAGS_ROCE_IP_VER_V2IPV4      (0x2UL << 4)
+	#define CQ_RES_UD_FLAGS_ROCE_IP_VER_V2IPV6      (0x3UL << 4)
+	#define CQ_RES_UD_FLAGS_ROCE_IP_VER_LAST       CQ_RES_UD_FLAGS_ROCE_IP_VER_V2IPV6
+	#define CQ_RES_UD_FLAGS_META_FORMAT_MASK      0x3c0UL
+	#define CQ_RES_UD_FLAGS_META_FORMAT_SFT       6
+	#define CQ_RES_UD_FLAGS_META_FORMAT_NONE        (0x0UL << 6)
+	#define CQ_RES_UD_FLAGS_META_FORMAT_VLAN        (0x1UL << 6)
+	#define CQ_RES_UD_FLAGS_META_FORMAT_TUNNEL_ID   (0x2UL << 6)
+	#define CQ_RES_UD_FLAGS_META_FORMAT_CHDR_DATA   (0x3UL << 6)
+	#define CQ_RES_UD_FLAGS_META_FORMAT_HDR_OFFSET  (0x4UL << 6)
+	#define CQ_RES_UD_FLAGS_META_FORMAT_LAST       CQ_RES_UD_FLAGS_META_FORMAT_HDR_OFFSET
+	#define CQ_RES_UD_FLAGS_EXT_META_FORMAT_MASK  0xc00UL
+	#define CQ_RES_UD_FLAGS_EXT_META_FORMAT_SFT   10
+	__le32	src_qp_high_srq_or_rq_wr_id;
+	#define CQ_RES_UD_SRQ_OR_RQ_WR_ID_MASK 0xfffffUL
+	#define CQ_RES_UD_SRQ_OR_RQ_WR_ID_SFT 0
+	#define CQ_RES_UD_SRC_QP_HIGH_MASK    0xff000000UL
+	#define CQ_RES_UD_SRC_QP_HIGH_SFT     24
+};
+
+/* cq_res_ud_v2 (size:256b/32B) */
+struct cq_res_ud_v2 {
+	__le16	length;
+	#define CQ_RES_UD_V2_LENGTH_MASK 0x3fffUL
+	#define CQ_RES_UD_V2_LENGTH_SFT 0
+	__le16	cfa_metadata0;
+	#define CQ_RES_UD_V2_CFA_METADATA0_VID_MASK 0xfffUL
+	#define CQ_RES_UD_V2_CFA_METADATA0_VID_SFT 0
+	#define CQ_RES_UD_V2_CFA_METADATA0_DE      0x1000UL
+	#define CQ_RES_UD_V2_CFA_METADATA0_PRI_MASK 0xe000UL
+	#define CQ_RES_UD_V2_CFA_METADATA0_PRI_SFT 13
+	__le32	imm_data;
+	__le64	qp_handle;
+	__le16	src_mac[3];
+	__le16	src_qp_low;
+	u8	cqe_type_toggle;
+	#define CQ_RES_UD_V2_TOGGLE         0x1UL
+	#define CQ_RES_UD_V2_CQE_TYPE_MASK  0x1eUL
+	#define CQ_RES_UD_V2_CQE_TYPE_SFT   1
+	#define CQ_RES_UD_V2_CQE_TYPE_RES_UD  (0x2UL << 1)
+	#define CQ_RES_UD_V2_CQE_TYPE_LAST   CQ_RES_UD_V2_CQE_TYPE_RES_UD
+	u8	status;
+	#define CQ_RES_UD_V2_STATUS_OK                       0x0UL
+	#define CQ_RES_UD_V2_STATUS_LOCAL_ACCESS_ERROR       0x1UL
+	#define CQ_RES_UD_V2_STATUS_HW_LOCAL_LENGTH_ERR      0x2UL
+	#define CQ_RES_UD_V2_STATUS_LOCAL_PROTECTION_ERR     0x3UL
+	#define CQ_RES_UD_V2_STATUS_LOCAL_QP_OPERATION_ERR   0x4UL
+	#define CQ_RES_UD_V2_STATUS_MEMORY_MGT_OPERATION_ERR 0x5UL
+	#define CQ_RES_UD_V2_STATUS_WORK_REQUEST_FLUSHED_ERR 0x7UL
+	#define CQ_RES_UD_V2_STATUS_HW_FLUSH_ERR             0x8UL
+	#define CQ_RES_UD_V2_STATUS_LAST                    CQ_RES_UD_V2_STATUS_HW_FLUSH_ERR
+	__le16	flags;
+	#define CQ_RES_UD_V2_FLAGS_SRQ                    0x1UL
+	#define CQ_RES_UD_V2_FLAGS_SRQ_RQ                   0x0UL
+	#define CQ_RES_UD_V2_FLAGS_SRQ_SRQ                  0x1UL
+	#define CQ_RES_UD_V2_FLAGS_SRQ_LAST                CQ_RES_UD_V2_FLAGS_SRQ_SRQ
+	#define CQ_RES_UD_V2_FLAGS_IMM                    0x2UL
+	#define CQ_RES_UD_V2_FLAGS_UNUSED_MASK            0xcUL
+	#define CQ_RES_UD_V2_FLAGS_UNUSED_SFT             2
+	#define CQ_RES_UD_V2_FLAGS_ROCE_IP_VER_MASK       0x30UL
+	#define CQ_RES_UD_V2_FLAGS_ROCE_IP_VER_SFT        4
+	#define CQ_RES_UD_V2_FLAGS_ROCE_IP_VER_V1           (0x0UL << 4)
+	#define CQ_RES_UD_V2_FLAGS_ROCE_IP_VER_V2IPV4       (0x2UL << 4)
+	#define CQ_RES_UD_V2_FLAGS_ROCE_IP_VER_V2IPV6       (0x3UL << 4)
+	#define CQ_RES_UD_V2_FLAGS_ROCE_IP_VER_LAST        CQ_RES_UD_V2_FLAGS_ROCE_IP_VER_V2IPV6
+	#define CQ_RES_UD_V2_FLAGS_META_FORMAT_MASK       0x3c0UL
+	#define CQ_RES_UD_V2_FLAGS_META_FORMAT_SFT        6
+	#define CQ_RES_UD_V2_FLAGS_META_FORMAT_NONE         (0x0UL << 6)
+	#define CQ_RES_UD_V2_FLAGS_META_FORMAT_ACT_REC_PTR  (0x1UL << 6)
+	#define CQ_RES_UD_V2_FLAGS_META_FORMAT_TUNNEL_ID    (0x2UL << 6)
+	#define CQ_RES_UD_V2_FLAGS_META_FORMAT_CHDR_DATA    (0x3UL << 6)
+	#define CQ_RES_UD_V2_FLAGS_META_FORMAT_HDR_OFFSET   (0x4UL << 6)
+	#define CQ_RES_UD_V2_FLAGS_META_FORMAT_LAST        CQ_RES_UD_V2_FLAGS_META_FORMAT_HDR_OFFSET
+	__le32	src_qp_high_srq_or_rq_wr_id;
+	#define CQ_RES_UD_V2_SRQ_OR_RQ_WR_ID_MASK           0xfffffUL
+	#define CQ_RES_UD_V2_SRQ_OR_RQ_WR_ID_SFT            0
+	#define CQ_RES_UD_V2_CFA_METADATA1_MASK             0xf00000UL
+	#define CQ_RES_UD_V2_CFA_METADATA1_SFT              20
+	#define CQ_RES_UD_V2_CFA_METADATA1_TPID_SEL_MASK     0x700000UL
+	#define CQ_RES_UD_V2_CFA_METADATA1_TPID_SEL_SFT      20
+	#define CQ_RES_UD_V2_CFA_METADATA1_TPID_SEL_TPID88A8   (0x0UL << 20)
+	#define CQ_RES_UD_V2_CFA_METADATA1_TPID_SEL_TPID8100   (0x1UL << 20)
+	#define CQ_RES_UD_V2_CFA_METADATA1_TPID_SEL_TPID9100   (0x2UL << 20)
+	#define CQ_RES_UD_V2_CFA_METADATA1_TPID_SEL_TPID9200   (0x3UL << 20)
+	#define CQ_RES_UD_V2_CFA_METADATA1_TPID_SEL_TPID9300   (0x4UL << 20)
+	#define CQ_RES_UD_V2_CFA_METADATA1_TPID_SEL_TPIDCFG    (0x5UL << 20)
+	#define CQ_RES_UD_V2_CFA_METADATA1_TPID_SEL_LAST      CQ_RES_UD_V2_CFA_METADATA1_TPID_SEL_TPIDCFG
+	#define CQ_RES_UD_V2_CFA_METADATA1_VALID             0x800000UL
+	#define CQ_RES_UD_V2_SRC_QP_HIGH_MASK               0xff000000UL
+	#define CQ_RES_UD_V2_SRC_QP_HIGH_SFT                24
+};
+
+/* cq_res_ud_cfa (size:256b/32B) */
+struct cq_res_ud_cfa {
+	__le16	length;
+	#define CQ_RES_UD_CFA_LENGTH_MASK 0x3fffUL
+	#define CQ_RES_UD_CFA_LENGTH_SFT 0
+	__le16	cfa_code;
+	__le32	imm_data;
+	__le32	qid;
+	#define CQ_RES_UD_CFA_QID_MASK 0xfffffUL
+	#define CQ_RES_UD_CFA_QID_SFT 0
+	__le32	cfa_metadata;
+	#define CQ_RES_UD_CFA_CFA_METADATA_VID_MASK 0xfffUL
+	#define CQ_RES_UD_CFA_CFA_METADATA_VID_SFT  0
+	#define CQ_RES_UD_CFA_CFA_METADATA_DE       0x1000UL
+	#define CQ_RES_UD_CFA_CFA_METADATA_PRI_MASK 0xe000UL
+	#define CQ_RES_UD_CFA_CFA_METADATA_PRI_SFT  13
+	#define CQ_RES_UD_CFA_CFA_METADATA_TPID_MASK 0xffff0000UL
+	#define CQ_RES_UD_CFA_CFA_METADATA_TPID_SFT 16
+	__le16	src_mac[3];
+	__le16	src_qp_low;
+	u8	cqe_type_toggle;
+	#define CQ_RES_UD_CFA_TOGGLE             0x1UL
+	#define CQ_RES_UD_CFA_CQE_TYPE_MASK      0x1eUL
+	#define CQ_RES_UD_CFA_CQE_TYPE_SFT       1
+	#define CQ_RES_UD_CFA_CQE_TYPE_RES_UD_CFA  (0x4UL << 1)
+	#define CQ_RES_UD_CFA_CQE_TYPE_LAST       CQ_RES_UD_CFA_CQE_TYPE_RES_UD_CFA
+	u8	status;
+	#define CQ_RES_UD_CFA_STATUS_OK                       0x0UL
+	#define CQ_RES_UD_CFA_STATUS_LOCAL_ACCESS_ERROR       0x1UL
+	#define CQ_RES_UD_CFA_STATUS_HW_LOCAL_LENGTH_ERR      0x2UL
+	#define CQ_RES_UD_CFA_STATUS_LOCAL_PROTECTION_ERR     0x3UL
+	#define CQ_RES_UD_CFA_STATUS_LOCAL_QP_OPERATION_ERR   0x4UL
+	#define CQ_RES_UD_CFA_STATUS_MEMORY_MGT_OPERATION_ERR 0x5UL
+	#define CQ_RES_UD_CFA_STATUS_WORK_REQUEST_FLUSHED_ERR 0x7UL
+	#define CQ_RES_UD_CFA_STATUS_HW_FLUSH_ERR             0x8UL
+	#define CQ_RES_UD_CFA_STATUS_LAST                    CQ_RES_UD_CFA_STATUS_HW_FLUSH_ERR
+	__le16	flags;
+	#define CQ_RES_UD_CFA_FLAGS_SRQ                   0x1UL
+	#define CQ_RES_UD_CFA_FLAGS_SRQ_RQ                  0x0UL
+	#define CQ_RES_UD_CFA_FLAGS_SRQ_SRQ                 0x1UL
+	#define CQ_RES_UD_CFA_FLAGS_SRQ_LAST               CQ_RES_UD_CFA_FLAGS_SRQ_SRQ
+	#define CQ_RES_UD_CFA_FLAGS_IMM                   0x2UL
+	#define CQ_RES_UD_CFA_FLAGS_UNUSED_MASK           0xcUL
+	#define CQ_RES_UD_CFA_FLAGS_UNUSED_SFT            2
+	#define CQ_RES_UD_CFA_FLAGS_ROCE_IP_VER_MASK      0x30UL
+	#define CQ_RES_UD_CFA_FLAGS_ROCE_IP_VER_SFT       4
+	#define CQ_RES_UD_CFA_FLAGS_ROCE_IP_VER_V1          (0x0UL << 4)
+	#define CQ_RES_UD_CFA_FLAGS_ROCE_IP_VER_V2IPV4      (0x2UL << 4)
+	#define CQ_RES_UD_CFA_FLAGS_ROCE_IP_VER_V2IPV6      (0x3UL << 4)
+	#define CQ_RES_UD_CFA_FLAGS_ROCE_IP_VER_LAST       CQ_RES_UD_CFA_FLAGS_ROCE_IP_VER_V2IPV6
+	#define CQ_RES_UD_CFA_FLAGS_META_FORMAT_MASK      0x3c0UL
+	#define CQ_RES_UD_CFA_FLAGS_META_FORMAT_SFT       6
+	#define CQ_RES_UD_CFA_FLAGS_META_FORMAT_NONE        (0x0UL << 6)
+	#define CQ_RES_UD_CFA_FLAGS_META_FORMAT_VLAN        (0x1UL << 6)
+	#define CQ_RES_UD_CFA_FLAGS_META_FORMAT_TUNNEL_ID   (0x2UL << 6)
+	#define CQ_RES_UD_CFA_FLAGS_META_FORMAT_CHDR_DATA   (0x3UL << 6)
+	#define CQ_RES_UD_CFA_FLAGS_META_FORMAT_HDR_OFFSET  (0x4UL << 6)
+	#define CQ_RES_UD_CFA_FLAGS_META_FORMAT_LAST       CQ_RES_UD_CFA_FLAGS_META_FORMAT_HDR_OFFSET
+	#define CQ_RES_UD_CFA_FLAGS_EXT_META_FORMAT_MASK  0xc00UL
+	#define CQ_RES_UD_CFA_FLAGS_EXT_META_FORMAT_SFT   10
+	__le32	src_qp_high_srq_or_rq_wr_id;
+	#define CQ_RES_UD_CFA_SRQ_OR_RQ_WR_ID_MASK 0xfffffUL
+	#define CQ_RES_UD_CFA_SRQ_OR_RQ_WR_ID_SFT 0
+	#define CQ_RES_UD_CFA_SRC_QP_HIGH_MASK    0xff000000UL
+	#define CQ_RES_UD_CFA_SRC_QP_HIGH_SFT     24
+};
+
+/* cq_res_ud_cfa_v2 (size:256b/32B) */
+struct cq_res_ud_cfa_v2 {
+	__le16	length;
+	#define CQ_RES_UD_CFA_V2_LENGTH_MASK 0x3fffUL
+	#define CQ_RES_UD_CFA_V2_LENGTH_SFT 0
+	__le16	cfa_metadata0;
+	#define CQ_RES_UD_CFA_V2_CFA_METADATA0_VID_MASK 0xfffUL
+	#define CQ_RES_UD_CFA_V2_CFA_METADATA0_VID_SFT 0
+	#define CQ_RES_UD_CFA_V2_CFA_METADATA0_DE      0x1000UL
+	#define CQ_RES_UD_CFA_V2_CFA_METADATA0_PRI_MASK 0xe000UL
+	#define CQ_RES_UD_CFA_V2_CFA_METADATA0_PRI_SFT 13
+	__le32	imm_data;
+	__le32	qid;
+	#define CQ_RES_UD_CFA_V2_QID_MASK 0xfffffUL
+	#define CQ_RES_UD_CFA_V2_QID_SFT 0
+	__le32	cfa_metadata2;
+	__le16	src_mac[3];
+	__le16	src_qp_low;
+	u8	cqe_type_toggle;
+	#define CQ_RES_UD_CFA_V2_TOGGLE             0x1UL
+	#define CQ_RES_UD_CFA_V2_CQE_TYPE_MASK      0x1eUL
+	#define CQ_RES_UD_CFA_V2_CQE_TYPE_SFT       1
+	#define CQ_RES_UD_CFA_V2_CQE_TYPE_RES_UD_CFA  (0x4UL << 1)
+	#define CQ_RES_UD_CFA_V2_CQE_TYPE_LAST       CQ_RES_UD_CFA_V2_CQE_TYPE_RES_UD_CFA
+	u8	status;
+	#define CQ_RES_UD_CFA_V2_STATUS_OK                       0x0UL
+	#define CQ_RES_UD_CFA_V2_STATUS_LOCAL_ACCESS_ERROR       0x1UL
+	#define CQ_RES_UD_CFA_V2_STATUS_HW_LOCAL_LENGTH_ERR      0x2UL
+	#define CQ_RES_UD_CFA_V2_STATUS_LOCAL_PROTECTION_ERR     0x3UL
+	#define CQ_RES_UD_CFA_V2_STATUS_LOCAL_QP_OPERATION_ERR   0x4UL
+	#define CQ_RES_UD_CFA_V2_STATUS_MEMORY_MGT_OPERATION_ERR 0x5UL
+	#define CQ_RES_UD_CFA_V2_STATUS_WORK_REQUEST_FLUSHED_ERR 0x7UL
+	#define CQ_RES_UD_CFA_V2_STATUS_HW_FLUSH_ERR             0x8UL
+	#define CQ_RES_UD_CFA_V2_STATUS_LAST                    CQ_RES_UD_CFA_V2_STATUS_HW_FLUSH_ERR
+	__le16	flags;
+	#define CQ_RES_UD_CFA_V2_FLAGS_SRQ                    0x1UL
+	#define CQ_RES_UD_CFA_V2_FLAGS_SRQ_RQ                   0x0UL
+	#define CQ_RES_UD_CFA_V2_FLAGS_SRQ_SRQ                  0x1UL
+	#define CQ_RES_UD_CFA_V2_FLAGS_SRQ_LAST                CQ_RES_UD_CFA_V2_FLAGS_SRQ_SRQ
+	#define CQ_RES_UD_CFA_V2_FLAGS_IMM                    0x2UL
+	#define CQ_RES_UD_CFA_V2_FLAGS_UNUSED_MASK            0xcUL
+	#define CQ_RES_UD_CFA_V2_FLAGS_UNUSED_SFT             2
+	#define CQ_RES_UD_CFA_V2_FLAGS_ROCE_IP_VER_MASK       0x30UL
+	#define CQ_RES_UD_CFA_V2_FLAGS_ROCE_IP_VER_SFT        4
+	#define CQ_RES_UD_CFA_V2_FLAGS_ROCE_IP_VER_V1           (0x0UL << 4)
+	#define CQ_RES_UD_CFA_V2_FLAGS_ROCE_IP_VER_V2IPV4       (0x2UL << 4)
+	#define CQ_RES_UD_CFA_V2_FLAGS_ROCE_IP_VER_V2IPV6       (0x3UL << 4)
+	#define CQ_RES_UD_CFA_V2_FLAGS_ROCE_IP_VER_LAST        CQ_RES_UD_CFA_V2_FLAGS_ROCE_IP_VER_V2IPV6
+	#define CQ_RES_UD_CFA_V2_FLAGS_META_FORMAT_MASK       0x3c0UL
+	#define CQ_RES_UD_CFA_V2_FLAGS_META_FORMAT_SFT        6
+	#define CQ_RES_UD_CFA_V2_FLAGS_META_FORMAT_NONE         (0x0UL << 6)
+	#define CQ_RES_UD_CFA_V2_FLAGS_META_FORMAT_ACT_REC_PTR  (0x1UL << 6)
+	#define CQ_RES_UD_CFA_V2_FLAGS_META_FORMAT_TUNNEL_ID    (0x2UL << 6)
+	#define CQ_RES_UD_CFA_V2_FLAGS_META_FORMAT_CHDR_DATA    (0x3UL << 6)
+	#define CQ_RES_UD_CFA_V2_FLAGS_META_FORMAT_HDR_OFFSET   (0x4UL << 6)
+	#define CQ_RES_UD_CFA_V2_FLAGS_META_FORMAT_LAST        CQ_RES_UD_CFA_V2_FLAGS_META_FORMAT_HDR_OFFSET
+	__le32	src_qp_high_srq_or_rq_wr_id;
+	#define CQ_RES_UD_CFA_V2_SRQ_OR_RQ_WR_ID_MASK           0xfffffUL
+	#define CQ_RES_UD_CFA_V2_SRQ_OR_RQ_WR_ID_SFT            0
+	#define CQ_RES_UD_CFA_V2_CFA_METADATA1_MASK             0xf00000UL
+	#define CQ_RES_UD_CFA_V2_CFA_METADATA1_SFT              20
+	#define CQ_RES_UD_CFA_V2_CFA_METADATA1_TPID_SEL_MASK     0x700000UL
+	#define CQ_RES_UD_CFA_V2_CFA_METADATA1_TPID_SEL_SFT      20
+	#define CQ_RES_UD_CFA_V2_CFA_METADATA1_TPID_SEL_TPID88A8   (0x0UL << 20)
+	#define CQ_RES_UD_CFA_V2_CFA_METADATA1_TPID_SEL_TPID8100   (0x1UL << 20)
+	#define CQ_RES_UD_CFA_V2_CFA_METADATA1_TPID_SEL_TPID9100   (0x2UL << 20)
+	#define CQ_RES_UD_CFA_V2_CFA_METADATA1_TPID_SEL_TPID9200   (0x3UL << 20)
+	#define CQ_RES_UD_CFA_V2_CFA_METADATA1_TPID_SEL_TPID9300   (0x4UL << 20)
+	#define CQ_RES_UD_CFA_V2_CFA_METADATA1_TPID_SEL_TPIDCFG    (0x5UL << 20)
+	#define CQ_RES_UD_CFA_V2_CFA_METADATA1_TPID_SEL_LAST      CQ_RES_UD_CFA_V2_CFA_METADATA1_TPID_SEL_TPIDCFG
+	#define CQ_RES_UD_CFA_V2_CFA_METADATA1_VALID             0x800000UL
+	#define CQ_RES_UD_CFA_V2_SRC_QP_HIGH_MASK               0xff000000UL
+	#define CQ_RES_UD_CFA_V2_SRC_QP_HIGH_SFT                24
+};
+
+/* cq_res_raweth_qp1 (size:256b/32B) */
+struct cq_res_raweth_qp1 {
+	__le16	length;
+	#define CQ_RES_RAWETH_QP1_LENGTH_MASK 0x3fffUL
+	#define CQ_RES_RAWETH_QP1_LENGTH_SFT 0
+	__le16	raweth_qp1_flags;
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_FLAGS_MASK                  0x3ffUL
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_FLAGS_SFT                   0
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_FLAGS_ERROR                  0x1UL
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_FLAGS_ITYPE_MASK             0x3c0UL
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_FLAGS_ITYPE_SFT              6
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_FLAGS_ITYPE_NOT_KNOWN          (0x0UL << 6)
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_FLAGS_ITYPE_IP                 (0x1UL << 6)
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_FLAGS_ITYPE_TCP                (0x2UL << 6)
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_FLAGS_ITYPE_UDP                (0x3UL << 6)
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_FLAGS_ITYPE_FCOE               (0x4UL << 6)
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_FLAGS_ITYPE_ROCE               (0x5UL << 6)
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_FLAGS_ITYPE_ICMP               (0x7UL << 6)
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_FLAGS_ITYPE_PTP_WO_TIMESTAMP   (0x8UL << 6)
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_FLAGS_ITYPE_PTP_W_TIMESTAMP    (0x9UL << 6)
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_FLAGS_ITYPE_LAST              CQ_RES_RAWETH_QP1_RAWETH_QP1_FLAGS_ITYPE_PTP_W_TIMESTAMP
+	__le16	raweth_qp1_errors;
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_ERRORS_IP_CS_ERROR                       0x10UL
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_ERRORS_L4_CS_ERROR                       0x20UL
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_ERRORS_T_IP_CS_ERROR                     0x40UL
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_ERRORS_T_L4_CS_ERROR                     0x80UL
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_ERRORS_CRC_ERROR                         0x100UL
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_ERRORS_T_PKT_ERROR_MASK                  0xe00UL
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_ERRORS_T_PKT_ERROR_SFT                   9
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_ERRORS_T_PKT_ERROR_NO_ERROR                (0x0UL << 9)
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_ERRORS_T_PKT_ERROR_T_L3_BAD_VERSION        (0x1UL << 9)
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_ERRORS_T_PKT_ERROR_T_L3_BAD_HDR_LEN        (0x2UL << 9)
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_ERRORS_T_PKT_ERROR_TUNNEL_TOTAL_ERROR      (0x3UL << 9)
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_ERRORS_T_PKT_ERROR_T_IP_TOTAL_ERROR        (0x4UL << 9)
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_ERRORS_T_PKT_ERROR_T_UDP_TOTAL_ERROR       (0x5UL << 9)
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_ERRORS_T_PKT_ERROR_T_L3_BAD_TTL            (0x6UL << 9)
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_ERRORS_T_PKT_ERROR_LAST                   CQ_RES_RAWETH_QP1_RAWETH_QP1_ERRORS_T_PKT_ERROR_T_L3_BAD_TTL
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_ERRORS_PKT_ERROR_MASK                    0xf000UL
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_ERRORS_PKT_ERROR_SFT                     12
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_ERRORS_PKT_ERROR_NO_ERROR                  (0x0UL << 12)
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_ERRORS_PKT_ERROR_L3_BAD_VERSION            (0x1UL << 12)
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_ERRORS_PKT_ERROR_L3_BAD_HDR_LEN            (0x2UL << 12)
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_ERRORS_PKT_ERROR_L3_BAD_TTL                (0x3UL << 12)
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_ERRORS_PKT_ERROR_IP_TOTAL_ERROR            (0x4UL << 12)
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_ERRORS_PKT_ERROR_UDP_TOTAL_ERROR           (0x5UL << 12)
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_ERRORS_PKT_ERROR_L4_BAD_HDR_LEN            (0x6UL << 12)
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_ERRORS_PKT_ERROR_L4_BAD_HDR_LEN_TOO_SMALL  (0x7UL << 12)
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_ERRORS_PKT_ERROR_L4_BAD_OPT_LEN            (0x8UL << 12)
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_ERRORS_PKT_ERROR_LAST                     CQ_RES_RAWETH_QP1_RAWETH_QP1_ERRORS_PKT_ERROR_L4_BAD_OPT_LEN
+	__le16	raweth_qp1_cfa_code;
+	__le64	qp_handle;
+	__le32	raweth_qp1_flags2;
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_FLAGS2_IP_CS_CALC                 0x1UL
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_FLAGS2_L4_CS_CALC                 0x2UL
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_FLAGS2_T_IP_CS_CALC               0x4UL
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_FLAGS2_T_L4_CS_CALC               0x8UL
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_FLAGS2_META_FORMAT_MASK           0xf0UL
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_FLAGS2_META_FORMAT_SFT            4
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_FLAGS2_META_FORMAT_NONE             (0x0UL << 4)
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_FLAGS2_META_FORMAT_VLAN             (0x1UL << 4)
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_FLAGS2_META_FORMAT_TUNNEL_ID        (0x2UL << 4)
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_FLAGS2_META_FORMAT_CHDR_DATA        (0x3UL << 4)
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_FLAGS2_META_FORMAT_HDR_OFFSET       (0x4UL << 4)
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_FLAGS2_META_FORMAT_LAST            CQ_RES_RAWETH_QP1_RAWETH_QP1_FLAGS2_META_FORMAT_HDR_OFFSET
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_FLAGS2_IP_TYPE                    0x100UL
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_FLAGS2_COMPLETE_CHECKSUM_CALC     0x200UL
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_FLAGS2_EXT_META_FORMAT_MASK       0xc00UL
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_FLAGS2_EXT_META_FORMAT_SFT        10
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_FLAGS2_COMPLETE_CHECKSUM_MASK     0xffff0000UL
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_FLAGS2_COMPLETE_CHECKSUM_SFT      16
+	__le32	raweth_qp1_metadata;
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_METADATA_PRI_DE_VID_MASK    0xffffUL
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_METADATA_PRI_DE_VID_SFT     0
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_METADATA_VID_MASK           0xfffUL
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_METADATA_VID_SFT            0
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_METADATA_DE                 0x1000UL
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_METADATA_PRI_MASK           0xe000UL
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_METADATA_PRI_SFT            13
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_METADATA_TPID_MASK          0xffff0000UL
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_METADATA_TPID_SFT           16
+	u8	cqe_type_toggle;
+	#define CQ_RES_RAWETH_QP1_TOGGLE                 0x1UL
+	#define CQ_RES_RAWETH_QP1_CQE_TYPE_MASK          0x1eUL
+	#define CQ_RES_RAWETH_QP1_CQE_TYPE_SFT           1
+	#define CQ_RES_RAWETH_QP1_CQE_TYPE_RES_RAWETH_QP1  (0x3UL << 1)
+	#define CQ_RES_RAWETH_QP1_CQE_TYPE_LAST           CQ_RES_RAWETH_QP1_CQE_TYPE_RES_RAWETH_QP1
+	u8	status;
+	#define CQ_RES_RAWETH_QP1_STATUS_OK                       0x0UL
+	#define CQ_RES_RAWETH_QP1_STATUS_LOCAL_ACCESS_ERROR       0x1UL
+	#define CQ_RES_RAWETH_QP1_STATUS_HW_LOCAL_LENGTH_ERR      0x2UL
+	#define CQ_RES_RAWETH_QP1_STATUS_LOCAL_PROTECTION_ERR     0x3UL
+	#define CQ_RES_RAWETH_QP1_STATUS_LOCAL_QP_OPERATION_ERR   0x4UL
+	#define CQ_RES_RAWETH_QP1_STATUS_MEMORY_MGT_OPERATION_ERR 0x5UL
+	#define CQ_RES_RAWETH_QP1_STATUS_WORK_REQUEST_FLUSHED_ERR 0x7UL
+	#define CQ_RES_RAWETH_QP1_STATUS_HW_FLUSH_ERR             0x8UL
+	#define CQ_RES_RAWETH_QP1_STATUS_LAST                    CQ_RES_RAWETH_QP1_STATUS_HW_FLUSH_ERR
+	__le16	flags;
+	#define CQ_RES_RAWETH_QP1_FLAGS_SRQ     0x1UL
+	#define CQ_RES_RAWETH_QP1_FLAGS_SRQ_RQ    0x0UL
+	#define CQ_RES_RAWETH_QP1_FLAGS_SRQ_SRQ   0x1UL
+	#define CQ_RES_RAWETH_QP1_FLAGS_SRQ_LAST CQ_RES_RAWETH_QP1_FLAGS_SRQ_SRQ
+	__le32	raweth_qp1_payload_offset_srq_or_rq_wr_id;
+	#define CQ_RES_RAWETH_QP1_SRQ_OR_RQ_WR_ID_MASK          0xfffffUL
+	#define CQ_RES_RAWETH_QP1_SRQ_OR_RQ_WR_ID_SFT           0
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_PAYLOAD_OFFSET_MASK 0xff000000UL
+	#define CQ_RES_RAWETH_QP1_RAWETH_QP1_PAYLOAD_OFFSET_SFT 24
+};
+
+/* cq_res_raweth_qp1_v2 (size:256b/32B) */
+struct cq_res_raweth_qp1_v2 {
+	__le16	length;
+	#define CQ_RES_RAWETH_QP1_V2_LENGTH_MASK 0x3fffUL
+	#define CQ_RES_RAWETH_QP1_V2_LENGTH_SFT 0
+	__le16	raweth_qp1_flags;
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_FLAGS_MASK                  0x3ffUL
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_FLAGS_SFT                   0
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_FLAGS_ERROR                  0x1UL
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_FLAGS_ITYPE_MASK             0x3c0UL
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_FLAGS_ITYPE_SFT              6
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_FLAGS_ITYPE_NOT_KNOWN          (0x0UL << 6)
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_FLAGS_ITYPE_IP                 (0x1UL << 6)
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_FLAGS_ITYPE_TCP                (0x2UL << 6)
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_FLAGS_ITYPE_UDP                (0x3UL << 6)
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_FLAGS_ITYPE_FCOE               (0x4UL << 6)
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_FLAGS_ITYPE_ROCE               (0x5UL << 6)
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_FLAGS_ITYPE_ICMP               (0x7UL << 6)
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_FLAGS_ITYPE_PTP_WO_TIMESTAMP   (0x8UL << 6)
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_FLAGS_ITYPE_PTP_W_TIMESTAMP    (0x9UL << 6)
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_FLAGS_ITYPE_LAST              CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_FLAGS_ITYPE_PTP_W_TIMESTAMP
+	__le16	raweth_qp1_errors;
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_ERRORS_IP_CS_ERROR                       0x10UL
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_ERRORS_L4_CS_ERROR                       0x20UL
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_ERRORS_T_IP_CS_ERROR                     0x40UL
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_ERRORS_T_L4_CS_ERROR                     0x80UL
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_ERRORS_CRC_ERROR                         0x100UL
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_ERRORS_T_PKT_ERROR_MASK                  0xe00UL
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_ERRORS_T_PKT_ERROR_SFT                   9
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_ERRORS_T_PKT_ERROR_NO_ERROR                (0x0UL << 9)
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_ERRORS_T_PKT_ERROR_T_L3_BAD_VERSION        (0x1UL << 9)
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_ERRORS_T_PKT_ERROR_T_L3_BAD_HDR_LEN        (0x2UL << 9)
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_ERRORS_T_PKT_ERROR_TUNNEL_TOTAL_ERROR      (0x3UL << 9)
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_ERRORS_T_PKT_ERROR_T_IP_TOTAL_ERROR        (0x4UL << 9)
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_ERRORS_T_PKT_ERROR_T_UDP_TOTAL_ERROR       (0x5UL << 9)
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_ERRORS_T_PKT_ERROR_T_L3_BAD_TTL            (0x6UL << 9)
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_ERRORS_T_PKT_ERROR_LAST                   CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_ERRORS_T_PKT_ERROR_T_L3_BAD_TTL
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_ERRORS_PKT_ERROR_MASK                    0xf000UL
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_ERRORS_PKT_ERROR_SFT                     12
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_ERRORS_PKT_ERROR_NO_ERROR                  (0x0UL << 12)
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_ERRORS_PKT_ERROR_L3_BAD_VERSION            (0x1UL << 12)
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_ERRORS_PKT_ERROR_L3_BAD_HDR_LEN            (0x2UL << 12)
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_ERRORS_PKT_ERROR_L3_BAD_TTL                (0x3UL << 12)
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_ERRORS_PKT_ERROR_IP_TOTAL_ERROR            (0x4UL << 12)
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_ERRORS_PKT_ERROR_UDP_TOTAL_ERROR           (0x5UL << 12)
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_ERRORS_PKT_ERROR_L4_BAD_HDR_LEN            (0x6UL << 12)
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_ERRORS_PKT_ERROR_L4_BAD_HDR_LEN_TOO_SMALL  (0x7UL << 12)
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_ERRORS_PKT_ERROR_L4_BAD_OPT_LEN            (0x8UL << 12)
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_ERRORS_PKT_ERROR_LAST                     CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_ERRORS_PKT_ERROR_L4_BAD_OPT_LEN
+	__le16	cfa_metadata0;
+	#define CQ_RES_RAWETH_QP1_V2_CFA_METADATA0_VID_MASK 0xfffUL
+	#define CQ_RES_RAWETH_QP1_V2_CFA_METADATA0_VID_SFT 0
+	#define CQ_RES_RAWETH_QP1_V2_CFA_METADATA0_DE      0x1000UL
+	#define CQ_RES_RAWETH_QP1_V2_CFA_METADATA0_PRI_MASK 0xe000UL
+	#define CQ_RES_RAWETH_QP1_V2_CFA_METADATA0_PRI_SFT 13
+	__le64	qp_handle;
+	__le32	raweth_qp1_flags2;
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_FLAGS2_CS_ALL_OK_MODE             0x8UL
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_FLAGS2_META_FORMAT_MASK           0xf0UL
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_FLAGS2_META_FORMAT_SFT            4
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_FLAGS2_META_FORMAT_NONE             (0x0UL << 4)
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_FLAGS2_META_FORMAT_ACT_REC_PTR      (0x1UL << 4)
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_FLAGS2_META_FORMAT_TUNNEL_ID        (0x2UL << 4)
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_FLAGS2_META_FORMAT_CHDR_DATA        (0x3UL << 4)
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_FLAGS2_META_FORMAT_HDR_OFFSET       (0x4UL << 4)
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_FLAGS2_META_FORMAT_LAST            CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_FLAGS2_META_FORMAT_HDR_OFFSET
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_FLAGS2_IP_TYPE                    0x100UL
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_FLAGS2_COMPLETE_CHECKSUM_CALC     0x200UL
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_FLAGS2_CS_OK_MASK                 0xfc00UL
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_FLAGS2_CS_OK_SFT                  10
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_FLAGS2_COMPLETE_CHECKSUM_MASK     0xffff0000UL
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_FLAGS2_COMPLETE_CHECKSUM_SFT      16
+	__le32	cfa_metadata2;
+	u8	cqe_type_toggle;
+	#define CQ_RES_RAWETH_QP1_V2_TOGGLE                 0x1UL
+	#define CQ_RES_RAWETH_QP1_V2_CQE_TYPE_MASK          0x1eUL
+	#define CQ_RES_RAWETH_QP1_V2_CQE_TYPE_SFT           1
+	#define CQ_RES_RAWETH_QP1_V2_CQE_TYPE_RES_RAWETH_QP1  (0x3UL << 1)
+	#define CQ_RES_RAWETH_QP1_V2_CQE_TYPE_LAST           CQ_RES_RAWETH_QP1_V2_CQE_TYPE_RES_RAWETH_QP1
+	u8	status;
+	#define CQ_RES_RAWETH_QP1_V2_STATUS_OK                       0x0UL
+	#define CQ_RES_RAWETH_QP1_V2_STATUS_LOCAL_ACCESS_ERROR       0x1UL
+	#define CQ_RES_RAWETH_QP1_V2_STATUS_HW_LOCAL_LENGTH_ERR      0x2UL
+	#define CQ_RES_RAWETH_QP1_V2_STATUS_LOCAL_PROTECTION_ERR     0x3UL
+	#define CQ_RES_RAWETH_QP1_V2_STATUS_LOCAL_QP_OPERATION_ERR   0x4UL
+	#define CQ_RES_RAWETH_QP1_V2_STATUS_MEMORY_MGT_OPERATION_ERR 0x5UL
+	#define CQ_RES_RAWETH_QP1_V2_STATUS_WORK_REQUEST_FLUSHED_ERR 0x7UL
+	#define CQ_RES_RAWETH_QP1_V2_STATUS_HW_FLUSH_ERR             0x8UL
+	#define CQ_RES_RAWETH_QP1_V2_STATUS_LAST                    CQ_RES_RAWETH_QP1_V2_STATUS_HW_FLUSH_ERR
+	__le16	flags;
+	#define CQ_RES_RAWETH_QP1_V2_FLAGS_SRQ     0x1UL
+	#define CQ_RES_RAWETH_QP1_V2_FLAGS_SRQ_RQ    0x0UL
+	#define CQ_RES_RAWETH_QP1_V2_FLAGS_SRQ_SRQ   0x1UL
+	#define CQ_RES_RAWETH_QP1_V2_FLAGS_SRQ_LAST CQ_RES_RAWETH_QP1_V2_FLAGS_SRQ_SRQ
+	__le32	raweth_qp1_payload_offset_srq_or_rq_wr_id;
+	#define CQ_RES_RAWETH_QP1_V2_SRQ_OR_RQ_WR_ID_MASK           0xfffffUL
+	#define CQ_RES_RAWETH_QP1_V2_SRQ_OR_RQ_WR_ID_SFT            0
+	#define CQ_RES_RAWETH_QP1_V2_CFA_METADATA1_MASK             0xf00000UL
+	#define CQ_RES_RAWETH_QP1_V2_CFA_METADATA1_SFT              20
+	#define CQ_RES_RAWETH_QP1_V2_CFA_METADATA1_TPID_SEL_MASK     0x700000UL
+	#define CQ_RES_RAWETH_QP1_V2_CFA_METADATA1_TPID_SEL_SFT      20
+	#define CQ_RES_RAWETH_QP1_V2_CFA_METADATA1_TPID_SEL_TPID88A8   (0x0UL << 20)
+	#define CQ_RES_RAWETH_QP1_V2_CFA_METADATA1_TPID_SEL_TPID8100   (0x1UL << 20)
+	#define CQ_RES_RAWETH_QP1_V2_CFA_METADATA1_TPID_SEL_TPID9100   (0x2UL << 20)
+	#define CQ_RES_RAWETH_QP1_V2_CFA_METADATA1_TPID_SEL_TPID9200   (0x3UL << 20)
+	#define CQ_RES_RAWETH_QP1_V2_CFA_METADATA1_TPID_SEL_TPID9300   (0x4UL << 20)
+	#define CQ_RES_RAWETH_QP1_V2_CFA_METADATA1_TPID_SEL_TPIDCFG    (0x5UL << 20)
+	#define CQ_RES_RAWETH_QP1_V2_CFA_METADATA1_TPID_SEL_LAST      CQ_RES_RAWETH_QP1_V2_CFA_METADATA1_TPID_SEL_TPIDCFG
+	#define CQ_RES_RAWETH_QP1_V2_CFA_METADATA1_VALID             0x800000UL
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_PAYLOAD_OFFSET_MASK 0xff000000UL
+	#define CQ_RES_RAWETH_QP1_V2_RAWETH_QP1_PAYLOAD_OFFSET_SFT  24
+};
+
+/* cq_terminal (size:256b/32B) */
+struct cq_terminal {
+	__le64	qp_handle;
+	__le16	sq_cons_idx;
+	__le16	rq_cons_idx;
+	__le32	reserved32_1;
+	__le64	reserved64_3;
+	u8	cqe_type_toggle;
+	#define CQ_TERMINAL_TOGGLE           0x1UL
+	#define CQ_TERMINAL_CQE_TYPE_MASK    0x1eUL
+	#define CQ_TERMINAL_CQE_TYPE_SFT     1
+	#define CQ_TERMINAL_CQE_TYPE_TERMINAL  (0xeUL << 1)
+	#define CQ_TERMINAL_CQE_TYPE_LAST     CQ_TERMINAL_CQE_TYPE_TERMINAL
+	u8	status;
+	#define CQ_TERMINAL_STATUS_OK 0x0UL
+	#define CQ_TERMINAL_STATUS_LAST CQ_TERMINAL_STATUS_OK
+	__le16	reserved16;
+	__le32	reserved32_2;
+};
+
+/* cq_cutoff (size:256b/32B) */
+struct cq_cutoff {
+	__le64	reserved64_1;
+	__le64	reserved64_2;
+	__le64	reserved64_3;
+	u8	cqe_type_toggle;
+	#define CQ_CUTOFF_TOGGLE            0x1UL
+	#define CQ_CUTOFF_CQE_TYPE_MASK     0x1eUL
+	#define CQ_CUTOFF_CQE_TYPE_SFT      1
+	#define CQ_CUTOFF_CQE_TYPE_CUT_OFF    (0xfUL << 1)
+	#define CQ_CUTOFF_CQE_TYPE_LAST      CQ_CUTOFF_CQE_TYPE_CUT_OFF
+	#define CQ_CUTOFF_RESIZE_TOGGLE_MASK 0x60UL
+	#define CQ_CUTOFF_RESIZE_TOGGLE_SFT 5
+	u8	status;
+	#define CQ_CUTOFF_STATUS_OK 0x0UL
+	#define CQ_CUTOFF_STATUS_LAST CQ_CUTOFF_STATUS_OK
+	__le16	reserved16;
+	__le32	reserved32;
+};
+
+/* cq_req_v3 (size:256b/32B) */
+struct cq_req_v3 {
+	__le64	qp_handle;
+	__le16	sq_cons_idx;
+	__le16	reserved1;
+	__le32	reserved2;
+	__le64	reserved3;
+	u8	cqe_type_toggle;
+	#define CQ_REQ_V3_TOGGLE         0x1UL
+	#define CQ_REQ_V3_CQE_TYPE_MASK  0x1eUL
+	#define CQ_REQ_V3_CQE_TYPE_SFT   1
+	#define CQ_REQ_V3_CQE_TYPE_REQ_V3  (0x8UL << 1)
+	#define CQ_REQ_V3_CQE_TYPE_LAST   CQ_REQ_V3_CQE_TYPE_REQ_V3
+	#define CQ_REQ_V3_PUSH           0x20UL
+	u8	status;
+	#define CQ_REQ_V3_STATUS_OK                         0x0UL
+	#define CQ_REQ_V3_STATUS_BAD_RESPONSE_ERR           0x1UL
+	#define CQ_REQ_V3_STATUS_LOCAL_LENGTH_ERR           0x2UL
+	#define CQ_REQ_V3_STATUS_LOCAL_QP_OPERATION_ERR     0x4UL
+	#define CQ_REQ_V3_STATUS_LOCAL_PROTECTION_ERR       0x5UL
+	#define CQ_REQ_V3_STATUS_MEMORY_MGT_OPERATION_ERR   0x7UL
+	#define CQ_REQ_V3_STATUS_REMOTE_INVALID_REQUEST_ERR 0x8UL
+	#define CQ_REQ_V3_STATUS_REMOTE_ACCESS_ERR          0x9UL
+	#define CQ_REQ_V3_STATUS_REMOTE_OPERATION_ERR       0xaUL
+	#define CQ_REQ_V3_STATUS_RNR_NAK_RETRY_CNT_ERR      0xbUL
+	#define CQ_REQ_V3_STATUS_TRANSPORT_RETRY_CNT_ERR    0xcUL
+	#define CQ_REQ_V3_STATUS_WORK_REQUEST_FLUSHED_ERR   0xdUL
+	#define CQ_REQ_V3_STATUS_OVERFLOW_ERR               0xfUL
+	#define CQ_REQ_V3_STATUS_LAST                      CQ_REQ_V3_STATUS_OVERFLOW_ERR
+	__le16	reserved4;
+	__le32	opaque;
+};
+
+/* cq_res_rc_v3 (size:256b/32B) */
+struct cq_res_rc_v3 {
+	__le32	length;
+	__le32	imm_data_or_inv_r_key;
+	__le64	qp_handle;
+	__le64	mr_handle;
+	u8	cqe_type_toggle;
+	#define CQ_RES_RC_V3_TOGGLE            0x1UL
+	#define CQ_RES_RC_V3_CQE_TYPE_MASK     0x1eUL
+	#define CQ_RES_RC_V3_CQE_TYPE_SFT      1
+	#define CQ_RES_RC_V3_CQE_TYPE_RES_RC_V3  (0x9UL << 1)
+	#define CQ_RES_RC_V3_CQE_TYPE_LAST      CQ_RES_RC_V3_CQE_TYPE_RES_RC_V3
+	u8	status;
+	#define CQ_RES_RC_V3_STATUS_OK                         0x0UL
+	#define CQ_RES_RC_V3_STATUS_LOCAL_LENGTH_ERR           0x2UL
+	#define CQ_RES_RC_V3_STATUS_LOCAL_QP_OPERATION_ERR     0x4UL
+	#define CQ_RES_RC_V3_STATUS_LOCAL_PROTECTION_ERR       0x5UL
+	#define CQ_RES_RC_V3_STATUS_LOCAL_ACCESS_ERROR         0x6UL
+	#define CQ_RES_RC_V3_STATUS_REMOTE_INVALID_REQUEST_ERR 0x8UL
+	#define CQ_RES_RC_V3_STATUS_WORK_REQUEST_FLUSHED_ERR   0xdUL
+	#define CQ_RES_RC_V3_STATUS_HW_FLUSH_ERR               0xeUL
+	#define CQ_RES_RC_V3_STATUS_OVERFLOW_ERR               0xfUL
+	#define CQ_RES_RC_V3_STATUS_LAST                      CQ_RES_RC_V3_STATUS_OVERFLOW_ERR
+	__le16	flags;
+	#define CQ_RES_RC_V3_FLAGS_SRQ            0x1UL
+	#define CQ_RES_RC_V3_FLAGS_SRQ_RQ           0x0UL
+	#define CQ_RES_RC_V3_FLAGS_SRQ_SRQ          0x1UL
+	#define CQ_RES_RC_V3_FLAGS_SRQ_LAST        CQ_RES_RC_V3_FLAGS_SRQ_SRQ
+	#define CQ_RES_RC_V3_FLAGS_IMM            0x2UL
+	#define CQ_RES_RC_V3_FLAGS_INV            0x4UL
+	#define CQ_RES_RC_V3_FLAGS_RDMA           0x8UL
+	#define CQ_RES_RC_V3_FLAGS_RDMA_SEND        (0x0UL << 3)
+	#define CQ_RES_RC_V3_FLAGS_RDMA_RDMA_WRITE  (0x1UL << 3)
+	#define CQ_RES_RC_V3_FLAGS_RDMA_LAST       CQ_RES_RC_V3_FLAGS_RDMA_RDMA_WRITE
+	__le32	opaque;
+};
+
+/* cq_res_ud_v3 (size:256b/32B) */
+struct cq_res_ud_v3 {
+	__le16	length;
+	#define CQ_RES_UD_V3_LENGTH_MASK 0x3fffUL
+	#define CQ_RES_UD_V3_LENGTH_SFT 0
+	u8	reserved1;
+	u8	src_qp_high;
+	__le32	imm_data;
+	__le64	qp_handle;
+	__le16	src_mac[3];
+	__le16	src_qp_low;
+	u8	cqe_type_toggle;
+	#define CQ_RES_UD_V3_TOGGLE            0x1UL
+	#define CQ_RES_UD_V3_CQE_TYPE_MASK     0x1eUL
+	#define CQ_RES_UD_V3_CQE_TYPE_SFT      1
+	#define CQ_RES_UD_V3_CQE_TYPE_RES_UD_V3  (0xaUL << 1)
+	#define CQ_RES_UD_V3_CQE_TYPE_LAST      CQ_RES_UD_V3_CQE_TYPE_RES_UD_V3
+	u8	status;
+	#define CQ_RES_UD_V3_STATUS_OK                       0x0UL
+	#define CQ_RES_UD_V3_STATUS_HW_LOCAL_LENGTH_ERR      0x3UL
+	#define CQ_RES_UD_V3_STATUS_LOCAL_QP_OPERATION_ERR   0x4UL
+	#define CQ_RES_UD_V3_STATUS_LOCAL_PROTECTION_ERR     0x5UL
+	#define CQ_RES_UD_V3_STATUS_WORK_REQUEST_FLUSHED_ERR 0xdUL
+	#define CQ_RES_UD_V3_STATUS_HW_FLUSH_ERR             0xeUL
+	#define CQ_RES_UD_V3_STATUS_OVERFLOW_ERR             0xfUL
+	#define CQ_RES_UD_V3_STATUS_LAST                    CQ_RES_UD_V3_STATUS_OVERFLOW_ERR
+	__le16	flags;
+	#define CQ_RES_UD_V3_FLAGS_SRQ               0x1UL
+	#define CQ_RES_UD_V3_FLAGS_SRQ_RQ              0x0UL
+	#define CQ_RES_UD_V3_FLAGS_SRQ_SRQ             0x1UL
+	#define CQ_RES_UD_V3_FLAGS_SRQ_LAST           CQ_RES_UD_V3_FLAGS_SRQ_SRQ
+	#define CQ_RES_UD_V3_FLAGS_IMM               0x2UL
+	#define CQ_RES_UD_V3_FLAGS_UNUSED_MASK       0xcUL
+	#define CQ_RES_UD_V3_FLAGS_UNUSED_SFT        2
+	#define CQ_RES_UD_V3_FLAGS_ROCE_IP_VER_MASK  0x30UL
+	#define CQ_RES_UD_V3_FLAGS_ROCE_IP_VER_SFT   4
+	#define CQ_RES_UD_V3_FLAGS_ROCE_IP_VER_V1      (0x0UL << 4)
+	#define CQ_RES_UD_V3_FLAGS_ROCE_IP_VER_V2IPV4  (0x2UL << 4)
+	#define CQ_RES_UD_V3_FLAGS_ROCE_IP_VER_V2IPV6  (0x3UL << 4)
+	#define CQ_RES_UD_V3_FLAGS_ROCE_IP_VER_LAST   CQ_RES_UD_V3_FLAGS_ROCE_IP_VER_V2IPV6
+	__le32	opaque;
+};
+
+/* cq_res_raweth_qp1_v3 (size:256b/32B) */
+struct cq_res_raweth_qp1_v3 {
+	__le16	length;
+	#define CQ_RES_RAWETH_QP1_V3_LENGTH_MASK 0x3fffUL
+	#define CQ_RES_RAWETH_QP1_V3_LENGTH_SFT 0
+	__le16	raweth_qp1_flags_cfa_metadata1;
+	#define CQ_RES_RAWETH_QP1_V3_ERROR                      0x1UL
+	#define CQ_RES_RAWETH_QP1_V3_ITYPE_MASK                 0x3c0UL
+	#define CQ_RES_RAWETH_QP1_V3_ITYPE_SFT                  6
+	#define CQ_RES_RAWETH_QP1_V3_ITYPE_NOT_KNOWN              (0x0UL << 6)
+	#define CQ_RES_RAWETH_QP1_V3_ITYPE_IP                     (0x1UL << 6)
+	#define CQ_RES_RAWETH_QP1_V3_ITYPE_TCP                    (0x2UL << 6)
+	#define CQ_RES_RAWETH_QP1_V3_ITYPE_UDP                    (0x3UL << 6)
+	#define CQ_RES_RAWETH_QP1_V3_ITYPE_FCOE                   (0x4UL << 6)
+	#define CQ_RES_RAWETH_QP1_V3_ITYPE_ROCE                   (0x5UL << 6)
+	#define CQ_RES_RAWETH_QP1_V3_ITYPE_ICMP                   (0x7UL << 6)
+	#define CQ_RES_RAWETH_QP1_V3_ITYPE_PTP_WO_TIMESTAMP       (0x8UL << 6)
+	#define CQ_RES_RAWETH_QP1_V3_ITYPE_PTP_W_TIMESTAMP        (0x9UL << 6)
+	#define CQ_RES_RAWETH_QP1_V3_ITYPE_LAST                  CQ_RES_RAWETH_QP1_V3_ITYPE_PTP_W_TIMESTAMP
+	#define CQ_RES_RAWETH_QP1_V3_CFA_METADATA1_MASK         0xf000UL
+	#define CQ_RES_RAWETH_QP1_V3_CFA_METADATA1_SFT          12
+	#define CQ_RES_RAWETH_QP1_V3_CFA_METADATA1_TPID_SEL_MASK 0x7000UL
+	#define CQ_RES_RAWETH_QP1_V3_CFA_METADATA1_TPID_SEL_SFT  12
+	#define CQ_RES_RAWETH_QP1_V3_CFA_METADATA1_VALID         0x8000UL
+	__le16	raweth_qp1_errors;
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_ERRORS_IP_CS_ERROR                       0x10UL
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_ERRORS_L4_CS_ERROR                       0x20UL
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_ERRORS_T_IP_CS_ERROR                     0x40UL
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_ERRORS_T_L4_CS_ERROR                     0x80UL
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_ERRORS_CRC_ERROR                         0x100UL
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_ERRORS_T_PKT_ERROR_MASK                  0xe00UL
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_ERRORS_T_PKT_ERROR_SFT                   9
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_ERRORS_T_PKT_ERROR_NO_ERROR                (0x0UL << 9)
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_ERRORS_T_PKT_ERROR_T_L3_BAD_VERSION        (0x1UL << 9)
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_ERRORS_T_PKT_ERROR_T_L3_BAD_HDR_LEN        (0x2UL << 9)
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_ERRORS_T_PKT_ERROR_T_IP_TOTAL_ERROR        (0x3UL << 9)
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_ERRORS_T_PKT_ERROR_T_UDP_TOTAL_ERROR       (0x4UL << 9)
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_ERRORS_T_PKT_ERROR_T_L3_BAD_TTL            (0x5UL << 9)
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_ERRORS_T_PKT_ERROR_T_TOTAL_ERROR           (0x6UL << 9)
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_ERRORS_T_PKT_ERROR_LAST                   CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_ERRORS_T_PKT_ERROR_T_TOTAL_ERROR
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_ERRORS_PKT_ERROR_MASK                    0xf000UL
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_ERRORS_PKT_ERROR_SFT                     12
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_ERRORS_PKT_ERROR_NO_ERROR                  (0x0UL << 12)
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_ERRORS_PKT_ERROR_L3_BAD_VERSION            (0x1UL << 12)
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_ERRORS_PKT_ERROR_L3_BAD_HDR_LEN            (0x2UL << 12)
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_ERRORS_PKT_ERROR_L3_BAD_TTL                (0x3UL << 12)
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_ERRORS_PKT_ERROR_IP_TOTAL_ERROR            (0x4UL << 12)
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_ERRORS_PKT_ERROR_UDP_TOTAL_ERROR           (0x5UL << 12)
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_ERRORS_PKT_ERROR_L4_BAD_HDR_LEN            (0x6UL << 12)
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_ERRORS_PKT_ERROR_L4_BAD_HDR_LEN_TOO_SMALL  (0x7UL << 12)
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_ERRORS_PKT_ERROR_L4_BAD_OPT_LEN            (0x8UL << 12)
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_ERRORS_PKT_ERROR_L4_BAD_SUPAR_CRC          (0x9UL << 12)
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_ERRORS_PKT_ERROR_LAST                     CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_ERRORS_PKT_ERROR_L4_BAD_SUPAR_CRC
+	__le16	cfa_metadata0;
+	#define CQ_RES_RAWETH_QP1_V3_CFA_METADATA0_VID_MASK 0xfffUL
+	#define CQ_RES_RAWETH_QP1_V3_CFA_METADATA0_VID_SFT 0
+	#define CQ_RES_RAWETH_QP1_V3_CFA_METADATA0_DE      0x1000UL
+	#define CQ_RES_RAWETH_QP1_V3_CFA_METADATA0_PRI_MASK 0xe000UL
+	#define CQ_RES_RAWETH_QP1_V3_CFA_METADATA0_PRI_SFT 13
+	__le64	qp_handle;
+	__le32	raweth_qp1_flags2;
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_FLAGS2_IP_CS_CALC                 0x1UL
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_FLAGS2_L4_CS_CALC                 0x2UL
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_FLAGS2_T_IP_CS_CALC               0x4UL
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_FLAGS2_T_L4_CS_CALC               0x8UL
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_FLAGS2_META_FORMAT_MASK           0xf0UL
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_FLAGS2_META_FORMAT_SFT            4
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_FLAGS2_META_FORMAT_NONE             (0x0UL << 4)
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_FLAGS2_META_FORMAT_ACT_REC_PTR      (0x1UL << 4)
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_FLAGS2_META_FORMAT_TUNNEL_ID        (0x2UL << 4)
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_FLAGS2_META_FORMAT_CHDR_DATA        (0x3UL << 4)
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_FLAGS2_META_FORMAT_HDR_OFFSET       (0x4UL << 4)
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_FLAGS2_META_FORMAT_VNIC_ID          (0x5UL << 4)
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_FLAGS2_META_FORMAT_LAST            CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_FLAGS2_META_FORMAT_VNIC_ID
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_FLAGS2_IP_TYPE                    0x100UL
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_FLAGS2_COMPLETE_CHECKSUM_CALC     0x200UL
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_FLAGS2_T_IP_TYPE                  0x400UL
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_FLAGS2_T_IP_TYPE_IPV4               (0x0UL << 10)
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_FLAGS2_T_IP_TYPE_IPV6               (0x1UL << 10)
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_FLAGS2_T_IP_TYPE_LAST              CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_FLAGS2_T_IP_TYPE_IPV6
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_FLAGS2_COMPLETE_CHECKSUM_MASK     0xffff0000UL
+	#define CQ_RES_RAWETH_QP1_V3_RAWETH_QP1_FLAGS2_COMPLETE_CHECKSUM_SFT      16
+	__le32	cfa_metadata2;
+	u8	cqe_type_toggle;
+	#define CQ_RES_RAWETH_QP1_V3_TOGGLE                    0x1UL
+	#define CQ_RES_RAWETH_QP1_V3_CQE_TYPE_MASK             0x1eUL
+	#define CQ_RES_RAWETH_QP1_V3_CQE_TYPE_SFT              1
+	#define CQ_RES_RAWETH_QP1_V3_CQE_TYPE_RES_RAWETH_QP1_V3  (0xbUL << 1)
+	#define CQ_RES_RAWETH_QP1_V3_CQE_TYPE_LAST              CQ_RES_RAWETH_QP1_V3_CQE_TYPE_RES_RAWETH_QP1_V3
+	u8	status;
+	#define CQ_RES_RAWETH_QP1_V3_STATUS_OK                       0x0UL
+	#define CQ_RES_RAWETH_QP1_V3_STATUS_HW_LOCAL_LENGTH_ERR      0x3UL
+	#define CQ_RES_RAWETH_QP1_V3_STATUS_LOCAL_QP_OPERATION_ERR   0x4UL
+	#define CQ_RES_RAWETH_QP1_V3_STATUS_LOCAL_PROTECTION_ERR     0x5UL
+	#define CQ_RES_RAWETH_QP1_V3_STATUS_WORK_REQUEST_FLUSHED_ERR 0xdUL
+	#define CQ_RES_RAWETH_QP1_V3_STATUS_HW_FLUSH_ERR             0xeUL
+	#define CQ_RES_RAWETH_QP1_V3_STATUS_OVERFLOW_ERR             0xfUL
+	#define CQ_RES_RAWETH_QP1_V3_STATUS_LAST                    CQ_RES_RAWETH_QP1_V3_STATUS_OVERFLOW_ERR
+	u8	flags;
+	#define CQ_RES_RAWETH_QP1_V3_FLAGS_SRQ     0x1UL
+	#define CQ_RES_RAWETH_QP1_V3_FLAGS_SRQ_RQ    0x0UL
+	#define CQ_RES_RAWETH_QP1_V3_FLAGS_SRQ_SRQ   0x1UL
+	#define CQ_RES_RAWETH_QP1_V3_FLAGS_SRQ_LAST CQ_RES_RAWETH_QP1_V3_FLAGS_SRQ_SRQ
+	u8	raweth_qp1_payload_offset;
+	__le32	opaque;
+};
+
+/* cq_res_ud_cfa_v3 (size:256b/32B) */
+struct cq_res_ud_cfa_v3 {
+	__le16	length;
+	#define CQ_RES_UD_CFA_V3_LENGTH_MASK 0x3fffUL
+	#define CQ_RES_UD_CFA_V3_LENGTH_SFT 0
+	__le16	cfa_metadata0;
+	#define CQ_RES_UD_CFA_V3_CFA_METADATA0_VID_MASK 0xfffUL
+	#define CQ_RES_UD_CFA_V3_CFA_METADATA0_VID_SFT 0
+	#define CQ_RES_UD_CFA_V3_CFA_METADATA0_DE      0x1000UL
+	#define CQ_RES_UD_CFA_V3_CFA_METADATA0_PRI_MASK 0xe000UL
+	#define CQ_RES_UD_CFA_V3_CFA_METADATA0_PRI_SFT 13
+	__le32	imm_data;
+	__le32	qid_cfa_metadata1_src_qp_high;
+	#define CQ_RES_UD_CFA_V3_QID_MASK                   0x7ffUL
+	#define CQ_RES_UD_CFA_V3_QID_SFT                    0
+	#define CQ_RES_UD_CFA_V3_UNUSED_MASK                0xff800UL
+	#define CQ_RES_UD_CFA_V3_UNUSED_SFT                 11
+	#define CQ_RES_UD_CFA_V3_CFA_METADATA1_MASK         0xf00000UL
+	#define CQ_RES_UD_CFA_V3_CFA_METADATA1_SFT          20
+	#define CQ_RES_UD_CFA_V3_CFA_METADATA1_TPID_SEL_MASK 0x700000UL
+	#define CQ_RES_UD_CFA_V3_CFA_METADATA1_TPID_SEL_SFT  20
+	#define CQ_RES_UD_CFA_V3_CFA_METADATA1_VALID         0x800000UL
+	#define CQ_RES_UD_CFA_V3_SRC_QP_HIGH_MASK           0xff000000UL
+	#define CQ_RES_UD_CFA_V3_SRC_QP_HIGH_SFT            24
+	__le32	cfa_metadata2;
+	__le16	src_mac[3];
+	__le16	src_qp_low;
+	u8	cqe_type_toggle;
+	#define CQ_RES_UD_CFA_V3_TOGGLE                0x1UL
+	#define CQ_RES_UD_CFA_V3_CQE_TYPE_MASK         0x1eUL
+	#define CQ_RES_UD_CFA_V3_CQE_TYPE_SFT          1
+	#define CQ_RES_UD_CFA_V3_CQE_TYPE_RES_UD_CFA_V3  (0xcUL << 1)
+	#define CQ_RES_UD_CFA_V3_CQE_TYPE_LAST          CQ_RES_UD_CFA_V3_CQE_TYPE_RES_UD_CFA_V3
+	u8	status;
+	#define CQ_RES_UD_CFA_V3_STATUS_OK                       0x0UL
+	#define CQ_RES_UD_CFA_V3_STATUS_HW_LOCAL_LENGTH_ERR      0x3UL
+	#define CQ_RES_UD_CFA_V3_STATUS_LOCAL_QP_OPERATION_ERR   0x4UL
+	#define CQ_RES_UD_CFA_V3_STATUS_LOCAL_PROTECTION_ERR     0x5UL
+	#define CQ_RES_UD_CFA_V3_STATUS_WORK_REQUEST_FLUSHED_ERR 0xdUL
+	#define CQ_RES_UD_CFA_V3_STATUS_HW_FLUSH_ERR             0xeUL
+	#define CQ_RES_UD_CFA_V3_STATUS_OVERFLOW_ERR             0xfUL
+	#define CQ_RES_UD_CFA_V3_STATUS_LAST                    CQ_RES_UD_CFA_V3_STATUS_OVERFLOW_ERR
+	__le16	flags;
+	#define CQ_RES_UD_CFA_V3_FLAGS_SRQ                    0x1UL
+	#define CQ_RES_UD_CFA_V3_FLAGS_SRQ_RQ                   0x0UL
+	#define CQ_RES_UD_CFA_V3_FLAGS_SRQ_SRQ                  0x1UL
+	#define CQ_RES_UD_CFA_V3_FLAGS_SRQ_LAST                CQ_RES_UD_CFA_V3_FLAGS_SRQ_SRQ
+	#define CQ_RES_UD_CFA_V3_FLAGS_IMM                    0x2UL
+	#define CQ_RES_UD_CFA_V3_FLAGS_UNUSED_MASK            0xcUL
+	#define CQ_RES_UD_CFA_V3_FLAGS_UNUSED_SFT             2
+	#define CQ_RES_UD_CFA_V3_FLAGS_ROCE_IP_VER_MASK       0x30UL
+	#define CQ_RES_UD_CFA_V3_FLAGS_ROCE_IP_VER_SFT        4
+	#define CQ_RES_UD_CFA_V3_FLAGS_ROCE_IP_VER_V1           (0x0UL << 4)
+	#define CQ_RES_UD_CFA_V3_FLAGS_ROCE_IP_VER_V2IPV4       (0x2UL << 4)
+	#define CQ_RES_UD_CFA_V3_FLAGS_ROCE_IP_VER_V2IPV6       (0x3UL << 4)
+	#define CQ_RES_UD_CFA_V3_FLAGS_ROCE_IP_VER_LAST        CQ_RES_UD_CFA_V3_FLAGS_ROCE_IP_VER_V2IPV6
+	#define CQ_RES_UD_CFA_V3_FLAGS_META_FORMAT_MASK       0x3c0UL
+	#define CQ_RES_UD_CFA_V3_FLAGS_META_FORMAT_SFT        6
+	#define CQ_RES_UD_CFA_V3_FLAGS_META_FORMAT_NONE         (0x0UL << 6)
+	#define CQ_RES_UD_CFA_V3_FLAGS_META_FORMAT_ACT_REC_PTR  (0x1UL << 6)
+	#define CQ_RES_UD_CFA_V3_FLAGS_META_FORMAT_TUNNEL_ID    (0x2UL << 6)
+	#define CQ_RES_UD_CFA_V3_FLAGS_META_FORMAT_CHDR_DATA    (0x3UL << 6)
+	#define CQ_RES_UD_CFA_V3_FLAGS_META_FORMAT_HDR_OFFSET   (0x4UL << 6)
+	#define CQ_RES_UD_CFA_V3_FLAGS_META_FORMAT_VNIC_ID      (0x5UL << 6)
+	#define CQ_RES_UD_CFA_V3_FLAGS_META_FORMAT_LAST        CQ_RES_UD_CFA_V3_FLAGS_META_FORMAT_VNIC_ID
+	__le32	opaque;
+};
+
+/* nq_base (size:128b/16B) */
+struct nq_base {
+	__le16	info10_type;
+	#define NQ_BASE_TYPE_MASK           0x3fUL
+	#define NQ_BASE_TYPE_SFT            0
+	#define NQ_BASE_TYPE_CQ_NOTIFICATION  0x30UL
+	#define NQ_BASE_TYPE_SRQ_EVENT        0x32UL
+	#define NQ_BASE_TYPE_DBQ_EVENT        0x34UL
+	#define NQ_BASE_TYPE_QP_EVENT         0x38UL
+	#define NQ_BASE_TYPE_FUNC_EVENT       0x3aUL
+	#define NQ_BASE_TYPE_NQ_REASSIGN      0x3cUL
+	#define NQ_BASE_TYPE_LAST            NQ_BASE_TYPE_NQ_REASSIGN
+	#define NQ_BASE_INFO10_MASK         0xffc0UL
+	#define NQ_BASE_INFO10_SFT          6
+	__le16	info16;
+	__le32	info32;
+	__le32	info63_v[2];
+	#define NQ_BASE_V          0x1UL
+	#define NQ_BASE_INFO63_MASK 0xfffffffeUL
+	#define NQ_BASE_INFO63_SFT 1
+};
+
+/* nq_cn (size:128b/16B) */
+struct nq_cn {
+	__le16	type;
+	#define NQ_CN_TYPE_MASK           0x3fUL
+	#define NQ_CN_TYPE_SFT            0
+	#define NQ_CN_TYPE_CQ_NOTIFICATION  0x30UL
+	#define NQ_CN_TYPE_LAST            NQ_CN_TYPE_CQ_NOTIFICATION
+	#define NQ_CN_TOGGLE_MASK         0xc0UL
+	#define NQ_CN_TOGGLE_SFT          6
+	__le16	reserved16;
+	__le32	cq_handle_low;
+	__le32	v;
+	#define NQ_CN_V     0x1UL
+	__le32	cq_handle_high;
+};
+
+/* nq_srq_event (size:128b/16B) */
+struct nq_srq_event {
+	u8	type;
+	#define NQ_SRQ_EVENT_TYPE_MASK     0x3fUL
+	#define NQ_SRQ_EVENT_TYPE_SFT      0
+	#define NQ_SRQ_EVENT_TYPE_SRQ_EVENT  0x32UL
+	#define NQ_SRQ_EVENT_TYPE_LAST      NQ_SRQ_EVENT_TYPE_SRQ_EVENT
+	#define NQ_SRQ_EVENT_TOGGLE_MASK   0xc0UL
+	#define NQ_SRQ_EVENT_TOGGLE_SFT    6
+	u8	event;
+	#define NQ_SRQ_EVENT_EVENT_SRQ_THRESHOLD_EVENT 0x1UL
+	#define NQ_SRQ_EVENT_EVENT_LAST               NQ_SRQ_EVENT_EVENT_SRQ_THRESHOLD_EVENT
+	__le16	reserved16;
+	__le32	srq_handle_low;
+	__le32	v;
+	#define NQ_SRQ_EVENT_V     0x1UL
+	__le32	srq_handle_high;
+};
+
+/* nq_dbq_event (size:128b/16B) */
+struct nq_dbq_event {
+	u8	type;
+	#define NQ_DBQ_EVENT_TYPE_MASK     0x3fUL
+	#define NQ_DBQ_EVENT_TYPE_SFT      0
+	#define NQ_DBQ_EVENT_TYPE_DBQ_EVENT  0x34UL
+	#define NQ_DBQ_EVENT_TYPE_LAST      NQ_DBQ_EVENT_TYPE_DBQ_EVENT
+	u8	event;
+	#define NQ_DBQ_EVENT_EVENT_DBQ_THRESHOLD_EVENT 0x1UL
+	#define NQ_DBQ_EVENT_EVENT_LAST               NQ_DBQ_EVENT_EVENT_DBQ_THRESHOLD_EVENT
+	__le16	db_pfid;
+	#define NQ_DBQ_EVENT_DB_PFID_MASK 0xfUL
+	#define NQ_DBQ_EVENT_DB_PFID_SFT 0
+	__le32	db_dpi;
+	#define NQ_DBQ_EVENT_DB_DPI_MASK 0xfffffUL
+	#define NQ_DBQ_EVENT_DB_DPI_SFT 0
+	__le32	v;
+	#define NQ_DBQ_EVENT_V     0x1UL
+	__le32	db_type_db_xid;
+	#define NQ_DBQ_EVENT_DB_XID_MASK 0xfffffUL
+	#define NQ_DBQ_EVENT_DB_XID_SFT  0
+	#define NQ_DBQ_EVENT_DB_TYPE_MASK 0xf0000000UL
+	#define NQ_DBQ_EVENT_DB_TYPE_SFT 28
+};
+
+/* nq_reassign (size:128b/16B) */
+struct nq_reassign {
+	__le16	type;
+	#define NQ_REASSIGN_TYPE_MASK       0x3fUL
+	#define NQ_REASSIGN_TYPE_SFT        0
+	#define NQ_REASSIGN_TYPE_NQ_REASSIGN  0x3cUL
+	#define NQ_REASSIGN_TYPE_LAST        NQ_REASSIGN_TYPE_NQ_REASSIGN
+	__le16	reserved16;
+	__le32	cq_handle_low;
+	__le32	v;
+	#define NQ_REASSIGN_V     0x1UL
+	__le32	cq_handle_high;
+};
+
+/* xrrq_irrq (size:256b/32B) */
+struct xrrq_irrq {
+	__le16	credits_type;
+	#define XRRQ_IRRQ_TYPE           0x1UL
+	#define XRRQ_IRRQ_TYPE_READ_REQ    0x0UL
+	#define XRRQ_IRRQ_TYPE_ATOMIC_REQ  0x1UL
+	#define XRRQ_IRRQ_TYPE_LAST       XRRQ_IRRQ_TYPE_ATOMIC_REQ
+	#define XRRQ_IRRQ_CREDITS_MASK   0xf800UL
+	#define XRRQ_IRRQ_CREDITS_SFT    11
+	__le16	reserved16;
+	__le32	reserved32;
+	__le32	psn;
+	#define XRRQ_IRRQ_PSN_MASK 0xffffffUL
+	#define XRRQ_IRRQ_PSN_SFT 0
+	__le32	msn;
+	#define XRRQ_IRRQ_MSN_MASK 0xffffffUL
+	#define XRRQ_IRRQ_MSN_SFT 0
+	__le64	va_or_atomic_result;
+	__le32	rdma_r_key;
+	__le32	length;
+};
+
+/* xrrq_orrq (size:256b/32B) */
+struct xrrq_orrq {
+	__le16	num_sges_type;
+	#define XRRQ_ORRQ_TYPE           0x1UL
+	#define XRRQ_ORRQ_TYPE_READ_REQ    0x0UL
+	#define XRRQ_ORRQ_TYPE_ATOMIC_REQ  0x1UL
+	#define XRRQ_ORRQ_TYPE_LAST       XRRQ_ORRQ_TYPE_ATOMIC_REQ
+	#define XRRQ_ORRQ_NUM_SGES_MASK  0xf800UL
+	#define XRRQ_ORRQ_NUM_SGES_SFT   11
+	__le16	reserved16;
+	__le32	length;
+	__le32	psn;
+	#define XRRQ_ORRQ_PSN_MASK 0xffffffUL
+	#define XRRQ_ORRQ_PSN_SFT 0
+	__le32	end_psn;
+	#define XRRQ_ORRQ_END_PSN_MASK 0xffffffUL
+	#define XRRQ_ORRQ_END_PSN_SFT 0
+	__le64	first_sge_phy_or_sing_sge_va;
+	__le32	single_sge_l_key;
+	__le32	single_sge_size;
+};
+
+/* ptu_pte (size:64b/8B) */
+struct ptu_pte {
+	__le32	page_next_to_last_last_valid[2];
+	#define PTU_PTE_VALID            0x1UL
+	#define PTU_PTE_LAST             0x2UL
+	#define PTU_PTE_NEXT_TO_LAST     0x4UL
+	#define PTU_PTE_UNUSED_MASK      0xff8UL
+	#define PTU_PTE_UNUSED_SFT       3
+	#define PTU_PTE_PAGE_MASK        0xfffffffffffff000ULL
+	#define PTU_PTE_PAGE_SFT         12
+};
+
+/* ptu_pde (size:64b/8B) */
+struct ptu_pde {
+	__le32	page_valid[2];
+	#define PTU_PDE_VALID      0x1UL
+	#define PTU_PDE_UNUSED_MASK 0xffeUL
+	#define PTU_PDE_UNUSED_SFT 1
+	#define PTU_PDE_PAGE_MASK  0xfffffffffffff000ULL
+	#define PTU_PDE_PAGE_SFT   12
+};
+
+#endif /* _ROCE_HSI_H_ */
diff --git a/drivers/infiniband/hw/bng_re/bng_tlv.h b/drivers/infiniband/hw/bng_re/bng_tlv.h
index 278f4922962d..f74ffc4575c7 100644
--- a/drivers/infiniband/hw/bng_re/bng_tlv.h
+++ b/drivers/infiniband/hw/bng_re/bng_tlv.h
@@ -3,7 +3,7 @@
 #ifndef __BNG_TLV_H__
 #define __BNG_TLV_H__
 
-#include "roce_hsi.h"
+#include "bng_roce_hsi.h"
 
 struct roce_tlv {
 	struct tlv tlv;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index 32fc16a37d02..f376913aa321 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -8,7 +8,7 @@
 #define DRV_SUMMARY	"Broadcom ThorUltra NIC Ethernet Driver"
 
 #include <linux/etherdevice.h>
-#include <linux/bnxt/hsi.h>
+#include <linux/bnge/hsi.h>
 #include "bnge_rmem.h"
 #include "bnge_resc.h"
 #include "bnge_auxr.h"
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c b/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
index d64592b64e17..5f4cb4991964 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
@@ -14,7 +14,7 @@
 #include <asm/byteorder.h>
 #include <linux/bitmap.h>
 #include <linux/auxiliary_bus.h>
-#include <linux/bnxt/hsi.h>
+#include <linux/bnge/hsi.h>
 
 #include "bnge.h"
 #include "bnge_hwrm.h"
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm.h b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm.h
index 6df629761d95..2ed9c92c8c30 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm.h
@@ -4,7 +4,7 @@
 #ifndef _BNGE_HWRM_H_
 #define _BNGE_HWRM_H_
 
-#include <linux/bnxt/hsi.h>
+#include <linux/bnge/hsi.h>
 
 enum bnge_hwrm_ctx_flags {
 	BNGE_HWRM_INTERNAL_CTX_OWNED	= BIT(0),
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index d4b1c0d2c44c..84c90a957719 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -5,7 +5,7 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/pci.h>
-#include <linux/bnxt/hsi.h>
+#include <linux/bnge/hsi.h>
 #include <linux/if_vlan.h>
 #include <net/netdev_queues.h>
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 1ab89febbef5..70f1a7c24814 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -4,7 +4,7 @@
 #ifndef _BNGE_NETDEV_H_
 #define _BNGE_NETDEV_H_
 
-#include <linux/bnxt/hsi.h>
+#include <linux/bnge/hsi.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/refcount.h>
 #include "bnge_db.h"
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
index 79f5ce2e5d08..ee97be440c33 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
@@ -9,7 +9,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/vmalloc.h>
 #include <linux/crash_dump.h>
-#include <linux/bnxt/hsi.h>
+#include <linux/bnge/hsi.h>
 
 #include "bnge.h"
 #include "bnge_hwrm_lib.h"
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
index 2a17ff639100..bd0aa6c221a4 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
@@ -4,7 +4,7 @@
 #ifndef _BNGE_TXRX_H_
 #define _BNGE_TXRX_H_
 
-#include <linux/bnxt/hsi.h>
+#include <linux/bnge/hsi.h>
 #include "bnge_netdev.h"
 
 static inline u32 bnge_tx_avail(struct bnge_net *bn,
diff --git a/include/linux/bnge/hsi.h b/include/linux/bnge/hsi.h
new file mode 100644
index 000000000000..8ea13d5407ee
--- /dev/null
+++ b/include/linux/bnge/hsi.h
@@ -0,0 +1,12609 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2026 Broadcom */
+
+/* DO NOT MODIFY!!! This file is automatically generated. */
+
+#ifndef _BNGE_HSI_H_
+#define _BNGE_HSI_H_
+
+/* hwrm_cmd_hdr (size:128b/16B) */
+struct hwrm_cmd_hdr {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+};
+
+/* hwrm_resp_hdr (size:64b/8B) */
+struct hwrm_resp_hdr {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+};
+
+#define CMD_DISCR_TLV_ENCAP 0x8000UL
+#define CMD_DISCR_LAST     CMD_DISCR_TLV_ENCAP
+
+#define TLV_TYPE_HWRM_REQUEST                    0x1UL
+#define TLV_TYPE_HWRM_RESPONSE                   0x2UL
+#define TLV_TYPE_ROCE_SP_COMMAND                 0x3UL
+#define TLV_TYPE_QUERY_ROCE_CC_GEN1              0x4UL
+#define TLV_TYPE_MODIFY_ROCE_CC_GEN1             0x5UL
+#define TLV_TYPE_QUERY_ROCE_CC_GEN2              0x6UL
+#define TLV_TYPE_MODIFY_ROCE_CC_GEN2             0x7UL
+#define TLV_TYPE_QUERY_ROCE_CC_GEN1_EXT          0x8UL
+#define TLV_TYPE_MODIFY_ROCE_CC_GEN1_EXT         0x9UL
+#define TLV_TYPE_QUERY_ROCE_CC_GEN2_EXT          0xaUL
+#define TLV_TYPE_MODIFY_ROCE_CC_GEN2_EXT         0xbUL
+#define TLV_TYPE_ENGINE_CKV_ALIAS_ECC_PUBLIC_KEY 0x8001UL
+#define TLV_TYPE_ENGINE_CKV_IV                   0x8003UL
+#define TLV_TYPE_ENGINE_CKV_AUTH_TAG             0x8004UL
+#define TLV_TYPE_ENGINE_CKV_CIPHERTEXT           0x8005UL
+#define TLV_TYPE_ENGINE_CKV_HOST_ALGORITHMS      0x8006UL
+#define TLV_TYPE_ENGINE_CKV_HOST_ECC_PUBLIC_KEY  0x8007UL
+#define TLV_TYPE_ENGINE_CKV_ECDSA_SIGNATURE      0x8008UL
+#define TLV_TYPE_ENGINE_CKV_FW_ECC_PUBLIC_KEY    0x8009UL
+#define TLV_TYPE_ENGINE_CKV_FW_ALGORITHMS        0x800aUL
+#define TLV_TYPE_LAST                           TLV_TYPE_ENGINE_CKV_FW_ALGORITHMS
+
+/* tlv (size:64b/8B) */
+struct tlv {
+	__le16	cmd_discr;
+	u8	reserved_8b;
+	u8	flags;
+	#define TLV_FLAGS_MORE         0x1UL
+	#define TLV_FLAGS_MORE_LAST      0x0UL
+	#define TLV_FLAGS_MORE_NOT_LAST  0x1UL
+	#define TLV_FLAGS_REQUIRED     0x2UL
+	#define TLV_FLAGS_REQUIRED_NO    (0x0UL << 1)
+	#define TLV_FLAGS_REQUIRED_YES   (0x1UL << 1)
+	#define TLV_FLAGS_REQUIRED_LAST TLV_FLAGS_REQUIRED_YES
+	__le16	tlv_type;
+	__le16	length;
+};
+
+/* input (size:128b/16B) */
+struct input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+};
+
+/* output (size:64b/8B) */
+struct output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+};
+
+/* hwrm_short_input (size:128b/16B) */
+struct hwrm_short_input {
+	__le16	req_type;
+	__le16	signature;
+	#define SHORT_REQ_SIGNATURE_SHORT_CMD 0x4321UL
+	#define SHORT_REQ_SIGNATURE_LAST     SHORT_REQ_SIGNATURE_SHORT_CMD
+	__le16	target_id;
+	#define SHORT_REQ_TARGET_ID_DEFAULT 0x0UL
+	#define SHORT_REQ_TARGET_ID_TOOLS   0xfffdUL
+	#define SHORT_REQ_TARGET_ID_LAST   SHORT_REQ_TARGET_ID_TOOLS
+	__le16	size;
+	__le64	req_addr;
+};
+
+/* cmd_nums (size:64b/8B) */
+struct cmd_nums {
+	__le16	req_type;
+	#define HWRM_VER_GET                              0x0UL
+	#define HWRM_FUNC_ECHO_RESPONSE                   0xbUL
+	#define HWRM_ERROR_RECOVERY_QCFG                  0xcUL
+	#define HWRM_FUNC_DRV_IF_CHANGE                   0xdUL
+	#define HWRM_FUNC_BUF_UNRGTR                      0xeUL
+	#define HWRM_FUNC_VF_CFG                          0xfUL
+	#define HWRM_RESERVED1                            0x10UL
+	#define HWRM_FUNC_RESET                           0x11UL
+	#define HWRM_FUNC_GETFID                          0x12UL
+	#define HWRM_FUNC_VF_ALLOC                        0x13UL
+	#define HWRM_FUNC_VF_FREE                         0x14UL
+	#define HWRM_FUNC_QCAPS                           0x15UL
+	#define HWRM_FUNC_QCFG                            0x16UL
+	#define HWRM_FUNC_CFG                             0x17UL
+	#define HWRM_FUNC_QSTATS                          0x18UL
+	#define HWRM_FUNC_CLR_STATS                       0x19UL
+	#define HWRM_FUNC_DRV_UNRGTR                      0x1aUL
+	#define HWRM_FUNC_VF_RESC_FREE                    0x1bUL
+	#define HWRM_FUNC_VF_VNIC_IDS_QUERY               0x1cUL
+	#define HWRM_FUNC_DRV_RGTR                        0x1dUL
+	#define HWRM_FUNC_DRV_QVER                        0x1eUL
+	#define HWRM_FUNC_BUF_RGTR                        0x1fUL
+	#define HWRM_PORT_PHY_CFG                         0x20UL
+	#define HWRM_PORT_MAC_CFG                         0x21UL
+	#define HWRM_PORT_TS_QUERY                        0x22UL
+	#define HWRM_PORT_QSTATS                          0x23UL
+	#define HWRM_PORT_LPBK_QSTATS                     0x24UL
+	#define HWRM_PORT_CLR_STATS                       0x25UL
+	#define HWRM_PORT_LPBK_CLR_STATS                  0x26UL
+	#define HWRM_PORT_PHY_QCFG                        0x27UL
+	#define HWRM_PORT_MAC_QCFG                        0x28UL
+	#define HWRM_PORT_MAC_PTP_QCFG                    0x29UL
+	#define HWRM_PORT_PHY_QCAPS                       0x2aUL
+	#define HWRM_PORT_PHY_I2C_WRITE                   0x2bUL
+	#define HWRM_PORT_PHY_I2C_READ                    0x2cUL
+	#define HWRM_PORT_LED_CFG                         0x2dUL
+	#define HWRM_PORT_LED_QCFG                        0x2eUL
+	#define HWRM_PORT_LED_QCAPS                       0x2fUL
+	#define HWRM_QUEUE_QPORTCFG                       0x30UL
+	#define HWRM_QUEUE_QCFG                           0x31UL
+	#define HWRM_QUEUE_CFG                            0x32UL
+	#define HWRM_FUNC_VLAN_CFG                        0x33UL
+	#define HWRM_FUNC_VLAN_QCFG                       0x34UL
+	#define HWRM_QUEUE_PFCENABLE_QCFG                 0x35UL
+	#define HWRM_QUEUE_PFCENABLE_CFG                  0x36UL
+	#define HWRM_QUEUE_PRI2COS_QCFG                   0x37UL
+	#define HWRM_QUEUE_PRI2COS_CFG                    0x38UL
+	#define HWRM_QUEUE_COS2BW_QCFG                    0x39UL
+	#define HWRM_QUEUE_COS2BW_CFG                     0x3aUL
+	#define HWRM_QUEUE_DSCP_QCAPS                     0x3bUL
+	#define HWRM_QUEUE_DSCP2PRI_QCFG                  0x3cUL
+	#define HWRM_QUEUE_DSCP2PRI_CFG                   0x3dUL
+	#define HWRM_VNIC_ALLOC                           0x40UL
+	#define HWRM_VNIC_FREE                            0x41UL
+	#define HWRM_VNIC_CFG                             0x42UL
+	#define HWRM_VNIC_QCFG                            0x43UL
+	#define HWRM_VNIC_TPA_CFG                         0x44UL
+	#define HWRM_VNIC_TPA_QCFG                        0x45UL
+	#define HWRM_VNIC_RSS_CFG                         0x46UL
+	#define HWRM_VNIC_RSS_QCFG                        0x47UL
+	#define HWRM_VNIC_PLCMODES_CFG                    0x48UL
+	#define HWRM_VNIC_PLCMODES_QCFG                   0x49UL
+	#define HWRM_VNIC_QCAPS                           0x4aUL
+	#define HWRM_VNIC_UPDATE                          0x4bUL
+	#define HWRM_RING_ALLOC                           0x50UL
+	#define HWRM_RING_FREE                            0x51UL
+	#define HWRM_RING_CMPL_RING_QAGGINT_PARAMS        0x52UL
+	#define HWRM_RING_CMPL_RING_CFG_AGGINT_PARAMS     0x53UL
+	#define HWRM_RING_AGGINT_QCAPS                    0x54UL
+	#define HWRM_RING_SCHQ_ALLOC                      0x55UL
+	#define HWRM_RING_SCHQ_CFG                        0x56UL
+	#define HWRM_RING_SCHQ_FREE                       0x57UL
+	#define HWRM_RING_RESET                           0x5eUL
+	#define HWRM_RING_GRP_ALLOC                       0x60UL
+	#define HWRM_RING_GRP_FREE                        0x61UL
+	#define HWRM_RING_CFG                             0x62UL
+	#define HWRM_RING_QCFG                            0x63UL
+	#define HWRM_RESERVED5                            0x64UL
+	#define HWRM_RESERVED6                            0x65UL
+	#define HWRM_VNIC_RSS_COS_LB_CTX_ALLOC            0x70UL
+	#define HWRM_VNIC_RSS_COS_LB_CTX_FREE             0x71UL
+	#define HWRM_PSP_CFG                              0x72UL
+	#define HWRM_QUEUE_MPLS_QCAPS                     0x80UL
+	#define HWRM_QUEUE_MPLSTC2PRI_QCFG                0x81UL
+	#define HWRM_QUEUE_MPLSTC2PRI_CFG                 0x82UL
+	#define HWRM_QUEUE_VLANPRI_QCAPS                  0x83UL
+	#define HWRM_QUEUE_VLANPRI2PRI_QCFG               0x84UL
+	#define HWRM_QUEUE_VLANPRI2PRI_CFG                0x85UL
+	#define HWRM_QUEUE_GLOBAL_CFG                     0x86UL
+	#define HWRM_QUEUE_GLOBAL_QCFG                    0x87UL
+	#define HWRM_QUEUE_ADPTV_QOS_RX_FEATURE_QCFG      0x88UL
+	#define HWRM_QUEUE_ADPTV_QOS_RX_FEATURE_CFG       0x89UL
+	#define HWRM_QUEUE_ADPTV_QOS_TX_FEATURE_QCFG      0x8aUL
+	#define HWRM_QUEUE_ADPTV_QOS_TX_FEATURE_CFG       0x8bUL
+	#define HWRM_QUEUE_QCAPS                          0x8cUL
+	#define HWRM_QUEUE_ADPTV_QOS_RX_TUNING_QCFG       0x8dUL
+	#define HWRM_QUEUE_ADPTV_QOS_RX_TUNING_CFG        0x8eUL
+	#define HWRM_QUEUE_ADPTV_QOS_TX_TUNING_QCFG       0x8fUL
+	#define HWRM_CFA_L2_FILTER_ALLOC                  0x90UL
+	#define HWRM_CFA_L2_FILTER_FREE                   0x91UL
+	#define HWRM_CFA_L2_FILTER_CFG                    0x92UL
+	#define HWRM_CFA_L2_SET_RX_MASK                   0x93UL
+	#define HWRM_CFA_VLAN_ANTISPOOF_CFG               0x94UL
+	#define HWRM_CFA_TUNNEL_FILTER_ALLOC              0x95UL
+	#define HWRM_CFA_TUNNEL_FILTER_FREE               0x96UL
+	#define HWRM_CFA_ENCAP_RECORD_ALLOC               0x97UL
+	#define HWRM_CFA_ENCAP_RECORD_FREE                0x98UL
+	#define HWRM_CFA_NTUPLE_FILTER_ALLOC              0x99UL
+	#define HWRM_CFA_NTUPLE_FILTER_FREE               0x9aUL
+	#define HWRM_CFA_NTUPLE_FILTER_CFG                0x9bUL
+	#define HWRM_CFA_EM_FLOW_ALLOC                    0x9cUL
+	#define HWRM_CFA_EM_FLOW_FREE                     0x9dUL
+	#define HWRM_CFA_EM_FLOW_CFG                      0x9eUL
+	#define HWRM_TUNNEL_DST_PORT_QUERY                0xa0UL
+	#define HWRM_TUNNEL_DST_PORT_ALLOC                0xa1UL
+	#define HWRM_TUNNEL_DST_PORT_FREE                 0xa2UL
+	#define HWRM_QUEUE_ADPTV_QOS_TX_TUNING_CFG        0xa3UL
+	#define HWRM_STAT_CTX_ENG_QUERY                   0xafUL
+	#define HWRM_STAT_CTX_ALLOC                       0xb0UL
+	#define HWRM_STAT_CTX_FREE                        0xb1UL
+	#define HWRM_STAT_CTX_QUERY                       0xb2UL
+	#define HWRM_STAT_CTX_CLR_STATS                   0xb3UL
+	#define HWRM_PORT_QSTATS_EXT                      0xb4UL
+	#define HWRM_PORT_PHY_MDIO_WRITE                  0xb5UL
+	#define HWRM_PORT_PHY_MDIO_READ                   0xb6UL
+	#define HWRM_PORT_PHY_MDIO_BUS_ACQUIRE            0xb7UL
+	#define HWRM_PORT_PHY_MDIO_BUS_RELEASE            0xb8UL
+	#define HWRM_PORT_QSTATS_EXT_PFC_WD               0xb9UL
+	#define HWRM_PORT_QSTATS_EXT_PFC_ADV              0xbaUL
+	#define HWRM_PORT_TX_FIR_CFG                      0xbbUL
+	#define HWRM_PORT_TX_FIR_QCFG                     0xbcUL
+	#define HWRM_PORT_ECN_QSTATS                      0xbdUL
+	#define HWRM_FW_LIVEPATCH_QUERY                   0xbeUL
+	#define HWRM_FW_LIVEPATCH                         0xbfUL
+	#define HWRM_FW_RESET                             0xc0UL
+	#define HWRM_FW_QSTATUS                           0xc1UL
+	#define HWRM_FW_HEALTH_CHECK                      0xc2UL
+	#define HWRM_FW_SYNC                              0xc3UL
+	#define HWRM_FW_STATE_QCAPS                       0xc4UL
+	#define HWRM_FW_STATE_QUIESCE                     0xc5UL
+	#define HWRM_FW_STATE_BACKUP                      0xc6UL
+	#define HWRM_FW_STATE_RESTORE                     0xc7UL
+	#define HWRM_FW_SET_TIME                          0xc8UL
+	#define HWRM_FW_GET_TIME                          0xc9UL
+	#define HWRM_FW_SET_STRUCTURED_DATA               0xcaUL
+	#define HWRM_FW_GET_STRUCTURED_DATA               0xcbUL
+	#define HWRM_FW_IPC_MAILBOX                       0xccUL
+	#define HWRM_FW_ECN_CFG                           0xcdUL
+	#define HWRM_FW_ECN_QCFG                          0xceUL
+	#define HWRM_FW_SECURE_CFG                        0xcfUL
+	#define HWRM_EXEC_FWD_RESP                        0xd0UL
+	#define HWRM_REJECT_FWD_RESP                      0xd1UL
+	#define HWRM_FWD_RESP                             0xd2UL
+	#define HWRM_FWD_ASYNC_EVENT_CMPL                 0xd3UL
+	#define HWRM_OEM_CMD                              0xd4UL
+	#define HWRM_PORT_PRBS_TEST                       0xd5UL
+	#define HWRM_PORT_SFP_SIDEBAND_CFG                0xd6UL
+	#define HWRM_PORT_SFP_SIDEBAND_QCFG               0xd7UL
+	#define HWRM_FW_STATE_UNQUIESCE                   0xd8UL
+	#define HWRM_PORT_DSC_DUMP                        0xd9UL
+	#define HWRM_PORT_EP_TX_QCFG                      0xdaUL
+	#define HWRM_PORT_EP_TX_CFG                       0xdbUL
+	#define HWRM_PORT_CFG                             0xdcUL
+	#define HWRM_PORT_QCFG                            0xddUL
+	#define HWRM_PORT_MAC_QCAPS                       0xdfUL
+	#define HWRM_TEMP_MONITOR_QUERY                   0xe0UL
+	#define HWRM_REG_POWER_QUERY                      0xe1UL
+	#define HWRM_CORE_FREQUENCY_QUERY                 0xe2UL
+	#define HWRM_REG_POWER_HISTOGRAM                  0xe3UL
+	#define HWRM_MONITOR_PAX_HISTOGRAM_START          0xe4UL
+	#define HWRM_MONITOR_PAX_HISTOGRAM_COLLECT        0xe5UL
+	#define HWRM_STAT_QUERY_ROCE_STATS                0xe6UL
+	#define HWRM_STAT_QUERY_ROCE_STATS_EXT            0xe7UL
+	#define HWRM_WOL_FILTER_ALLOC                     0xf0UL
+	#define HWRM_WOL_FILTER_FREE                      0xf1UL
+	#define HWRM_WOL_FILTER_QCFG                      0xf2UL
+	#define HWRM_WOL_REASON_QCFG                      0xf3UL
+	#define HWRM_CFA_METER_QCAPS                      0xf4UL
+	#define HWRM_CFA_METER_PROFILE_ALLOC              0xf5UL
+	#define HWRM_CFA_METER_PROFILE_FREE               0xf6UL
+	#define HWRM_CFA_METER_PROFILE_CFG                0xf7UL
+	#define HWRM_CFA_METER_INSTANCE_ALLOC             0xf8UL
+	#define HWRM_CFA_METER_INSTANCE_FREE              0xf9UL
+	#define HWRM_CFA_METER_INSTANCE_CFG               0xfaUL
+	#define HWRM_CFA_VFR_ALLOC                        0xfdUL
+	#define HWRM_CFA_VFR_FREE                         0xfeUL
+	#define HWRM_CFA_VF_PAIR_ALLOC                    0x100UL
+	#define HWRM_CFA_VF_PAIR_FREE                     0x101UL
+	#define HWRM_CFA_VF_PAIR_INFO                     0x102UL
+	#define HWRM_CFA_FLOW_ALLOC                       0x103UL
+	#define HWRM_CFA_FLOW_FREE                        0x104UL
+	#define HWRM_CFA_FLOW_FLUSH                       0x105UL
+	#define HWRM_CFA_FLOW_STATS                       0x106UL
+	#define HWRM_CFA_FLOW_INFO                        0x107UL
+	#define HWRM_CFA_DECAP_FILTER_ALLOC               0x108UL
+	#define HWRM_CFA_DECAP_FILTER_FREE                0x109UL
+	#define HWRM_CFA_VLAN_ANTISPOOF_QCFG              0x10aUL
+	#define HWRM_CFA_REDIRECT_TUNNEL_TYPE_ALLOC       0x10bUL
+	#define HWRM_CFA_REDIRECT_TUNNEL_TYPE_FREE        0x10cUL
+	#define HWRM_CFA_PAIR_ALLOC                       0x10dUL
+	#define HWRM_CFA_PAIR_FREE                        0x10eUL
+	#define HWRM_CFA_PAIR_INFO                        0x10fUL
+	#define HWRM_FW_IPC_MSG                           0x110UL
+	#define HWRM_CFA_REDIRECT_TUNNEL_TYPE_INFO        0x111UL
+	#define HWRM_CFA_REDIRECT_QUERY_TUNNEL_TYPE       0x112UL
+	#define HWRM_CFA_FLOW_AGING_TIMER_RESET           0x113UL
+	#define HWRM_CFA_FLOW_AGING_CFG                   0x114UL
+	#define HWRM_CFA_FLOW_AGING_QCFG                  0x115UL
+	#define HWRM_CFA_FLOW_AGING_QCAPS                 0x116UL
+	#define HWRM_CFA_CTX_MEM_RGTR                     0x117UL
+	#define HWRM_CFA_CTX_MEM_UNRGTR                   0x118UL
+	#define HWRM_CFA_CTX_MEM_QCTX                     0x119UL
+	#define HWRM_CFA_CTX_MEM_QCAPS                    0x11aUL
+	#define HWRM_CFA_COUNTER_QCAPS                    0x11bUL
+	#define HWRM_CFA_COUNTER_CFG                      0x11cUL
+	#define HWRM_CFA_COUNTER_QCFG                     0x11dUL
+	#define HWRM_CFA_COUNTER_QSTATS                   0x11eUL
+	#define HWRM_CFA_TCP_FLAG_PROCESS_QCFG            0x11fUL
+	#define HWRM_CFA_EEM_QCAPS                        0x120UL
+	#define HWRM_CFA_EEM_CFG                          0x121UL
+	#define HWRM_CFA_EEM_QCFG                         0x122UL
+	#define HWRM_CFA_EEM_OP                           0x123UL
+	#define HWRM_CFA_ADV_FLOW_MGNT_QCAPS              0x124UL
+	#define HWRM_CFA_TFLIB                            0x125UL
+	#define HWRM_CFA_LAG_GROUP_MEMBER_RGTR            0x126UL
+	#define HWRM_CFA_LAG_GROUP_MEMBER_UNRGTR          0x127UL
+	#define HWRM_CFA_TLS_FILTER_ALLOC                 0x128UL
+	#define HWRM_CFA_TLS_FILTER_FREE                  0x129UL
+	#define HWRM_CFA_RELEASE_AFM_FUNC                 0x12aUL
+	#define HWRM_ENGINE_CKV_STATUS                    0x12eUL
+	#define HWRM_ENGINE_CKV_CKEK_ADD                  0x12fUL
+	#define HWRM_ENGINE_CKV_CKEK_DELETE               0x130UL
+	#define HWRM_ENGINE_CKV_KEY_ADD                   0x131UL
+	#define HWRM_ENGINE_CKV_KEY_DELETE                0x132UL
+	#define HWRM_ENGINE_CKV_FLUSH                     0x133UL
+	#define HWRM_ENGINE_CKV_RNG_GET                   0x134UL
+	#define HWRM_ENGINE_CKV_KEY_GEN                   0x135UL
+	#define HWRM_ENGINE_CKV_KEY_LABEL_CFG             0x136UL
+	#define HWRM_ENGINE_CKV_KEY_LABEL_QCFG            0x137UL
+	#define HWRM_ENGINE_QG_CONFIG_QUERY               0x13cUL
+	#define HWRM_ENGINE_QG_QUERY                      0x13dUL
+	#define HWRM_ENGINE_QG_METER_PROFILE_CONFIG_QUERY 0x13eUL
+	#define HWRM_ENGINE_QG_METER_PROFILE_QUERY        0x13fUL
+	#define HWRM_ENGINE_QG_METER_PROFILE_ALLOC        0x140UL
+	#define HWRM_ENGINE_QG_METER_PROFILE_FREE         0x141UL
+	#define HWRM_ENGINE_QG_METER_QUERY                0x142UL
+	#define HWRM_ENGINE_QG_METER_BIND                 0x143UL
+	#define HWRM_ENGINE_QG_METER_UNBIND               0x144UL
+	#define HWRM_ENGINE_QG_FUNC_BIND                  0x145UL
+	#define HWRM_ENGINE_SG_CONFIG_QUERY               0x146UL
+	#define HWRM_ENGINE_SG_QUERY                      0x147UL
+	#define HWRM_ENGINE_SG_METER_QUERY                0x148UL
+	#define HWRM_ENGINE_SG_METER_CONFIG               0x149UL
+	#define HWRM_ENGINE_SG_QG_BIND                    0x14aUL
+	#define HWRM_ENGINE_QG_SG_UNBIND                  0x14bUL
+	#define HWRM_ENGINE_CONFIG_QUERY                  0x154UL
+	#define HWRM_ENGINE_STATS_CONFIG                  0x155UL
+	#define HWRM_ENGINE_STATS_CLEAR                   0x156UL
+	#define HWRM_ENGINE_STATS_QUERY                   0x157UL
+	#define HWRM_ENGINE_STATS_QUERY_CONTINUOUS_ERROR  0x158UL
+	#define HWRM_ENGINE_RQ_ALLOC                      0x15eUL
+	#define HWRM_ENGINE_RQ_FREE                       0x15fUL
+	#define HWRM_ENGINE_CQ_ALLOC                      0x160UL
+	#define HWRM_ENGINE_CQ_FREE                       0x161UL
+	#define HWRM_ENGINE_NQ_ALLOC                      0x162UL
+	#define HWRM_ENGINE_NQ_FREE                       0x163UL
+	#define HWRM_ENGINE_ON_DIE_RQE_CREDITS            0x164UL
+	#define HWRM_ENGINE_FUNC_QCFG                     0x165UL
+	#define HWRM_FUNC_RESOURCE_QCAPS                  0x190UL
+	#define HWRM_FUNC_VF_RESOURCE_CFG                 0x191UL
+	#define HWRM_FUNC_BACKING_STORE_QCAPS             0x192UL
+	#define HWRM_FUNC_BACKING_STORE_CFG               0x193UL
+	#define HWRM_FUNC_BACKING_STORE_QCFG              0x194UL
+	#define HWRM_FUNC_VF_BW_CFG                       0x195UL
+	#define HWRM_FUNC_VF_BW_QCFG                      0x196UL
+	#define HWRM_FUNC_HOST_PF_IDS_QUERY               0x197UL
+	#define HWRM_FUNC_QSTATS_EXT                      0x198UL
+	#define HWRM_STAT_EXT_CTX_QUERY                   0x199UL
+	#define HWRM_FUNC_SPD_CFG                         0x19aUL
+	#define HWRM_FUNC_SPD_QCFG                        0x19bUL
+	#define HWRM_FUNC_PTP_PIN_QCFG                    0x19cUL
+	#define HWRM_FUNC_PTP_PIN_CFG                     0x19dUL
+	#define HWRM_FUNC_PTP_CFG                         0x19eUL
+	#define HWRM_FUNC_PTP_TS_QUERY                    0x19fUL
+	#define HWRM_FUNC_PTP_EXT_CFG                     0x1a0UL
+	#define HWRM_FUNC_PTP_EXT_QCFG                    0x1a1UL
+	#define HWRM_FUNC_KEY_CTX_ALLOC                   0x1a2UL
+	#define HWRM_FUNC_BACKING_STORE_CFG_V2            0x1a3UL
+	#define HWRM_FUNC_BACKING_STORE_QCFG_V2           0x1a4UL
+	#define HWRM_FUNC_DBR_PACING_CFG                  0x1a5UL
+	#define HWRM_FUNC_DBR_PACING_QCFG                 0x1a6UL
+	#define HWRM_FUNC_DBR_PACING_BROADCAST_EVENT      0x1a7UL
+	#define HWRM_FUNC_BACKING_STORE_QCAPS_V2          0x1a8UL
+	#define HWRM_FUNC_DBR_PACING_NQLIST_QUERY         0x1a9UL
+	#define HWRM_FUNC_DBR_RECOVERY_COMPLETED          0x1aaUL
+	#define HWRM_FUNC_SYNCE_CFG                       0x1abUL
+	#define HWRM_FUNC_SYNCE_QCFG                      0x1acUL
+	#define HWRM_FUNC_KEY_CTX_FREE                    0x1adUL
+	#define HWRM_FUNC_LAG_MODE_CFG                    0x1aeUL
+	#define HWRM_FUNC_LAG_MODE_QCFG                   0x1afUL
+	#define HWRM_FUNC_LAG_CREATE                      0x1b0UL
+	#define HWRM_FUNC_LAG_UPDATE                      0x1b1UL
+	#define HWRM_FUNC_LAG_FREE                        0x1b2UL
+	#define HWRM_FUNC_LAG_QCFG                        0x1b3UL
+	#define HWRM_FUNC_TTX_PACING_RATE_PROF_QUERY      0x1c3UL
+	#define HWRM_FUNC_TTX_PACING_RATE_QUERY           0x1c4UL
+	#define HWRM_FUNC_PTP_QCFG                        0x1c5UL
+	#define HWRM_SELFTEST_QLIST                       0x200UL
+	#define HWRM_SELFTEST_EXEC                        0x201UL
+	#define HWRM_SELFTEST_IRQ                         0x202UL
+	#define HWRM_SELFTEST_RETRIEVE_SERDES_DATA        0x203UL
+	#define HWRM_PCIE_QSTATS                          0x204UL
+	#define HWRM_MFG_FRU_WRITE_CONTROL                0x205UL
+	#define HWRM_MFG_TIMERS_QUERY                     0x206UL
+	#define HWRM_MFG_OTP_CFG                          0x207UL
+	#define HWRM_MFG_OTP_QCFG                         0x208UL
+	#define HWRM_MFG_HDMA_TEST                        0x209UL
+	#define HWRM_MFG_FRU_EEPROM_WRITE                 0x20aUL
+	#define HWRM_MFG_FRU_EEPROM_READ                  0x20bUL
+	#define HWRM_MFG_SOC_IMAGE                        0x20cUL
+	#define HWRM_MFG_SOC_QSTATUS                      0x20dUL
+	#define HWRM_MFG_PARAM_CRITICAL_DATA_FINALIZE     0x20eUL
+	#define HWRM_MFG_PARAM_CRITICAL_DATA_READ         0x20fUL
+	#define HWRM_MFG_PARAM_CRITICAL_DATA_HEALTH       0x210UL
+	#define HWRM_MFG_PRVSN_EXPORT_CSR                 0x211UL
+	#define HWRM_MFG_PRVSN_IMPORT_CERT                0x212UL
+	#define HWRM_MFG_PRVSN_GET_STATE                  0x213UL
+	#define HWRM_MFG_GET_NVM_MEASUREMENT              0x214UL
+	#define HWRM_MFG_PSOC_QSTATUS                     0x215UL
+	#define HWRM_MFG_SELFTEST_QLIST                   0x216UL
+	#define HWRM_MFG_SELFTEST_EXEC                    0x217UL
+	#define HWRM_STAT_GENERIC_QSTATS                  0x218UL
+	#define HWRM_MFG_PRVSN_EXPORT_CERT                0x219UL
+	#define HWRM_STAT_DB_ERROR_QSTATS                 0x21aUL
+	#define HWRM_MFG_TESTS                            0x21bUL
+	#define HWRM_MFG_WRITE_CERT_NVM                   0x21cUL
+	#define HWRM_PORT_POE_CFG                         0x230UL
+	#define HWRM_PORT_POE_QCFG                        0x231UL
+	#define HWRM_PORT_PHY_FDRSTAT                     0x232UL
+	#define HWRM_PORT_PHY_DBG                         0x23aUL
+	#define HWRM_UDCC_QCAPS                           0x258UL
+	#define HWRM_UDCC_CFG                             0x259UL
+	#define HWRM_UDCC_QCFG                            0x25aUL
+	#define HWRM_UDCC_SESSION_CFG                     0x25bUL
+	#define HWRM_UDCC_SESSION_QCFG                    0x25cUL
+	#define HWRM_UDCC_SESSION_QUERY                   0x25dUL
+	#define HWRM_UDCC_COMP_CFG                        0x25eUL
+	#define HWRM_UDCC_COMP_QCFG                       0x25fUL
+	#define HWRM_UDCC_COMP_QUERY                      0x260UL
+	#define HWRM_QUEUE_PFCWD_TIMEOUT_QCAPS            0x261UL
+	#define HWRM_QUEUE_PFCWD_TIMEOUT_CFG              0x262UL
+	#define HWRM_QUEUE_PFCWD_TIMEOUT_QCFG             0x263UL
+	#define HWRM_QUEUE_ADPTV_QOS_RX_QCFG              0x264UL
+	#define HWRM_QUEUE_ADPTV_QOS_TX_QCFG              0x265UL
+	#define HWRM_TF                                   0x2bcUL
+	#define HWRM_TF_VERSION_GET                       0x2bdUL
+	#define HWRM_TF_SESSION_OPEN                      0x2c6UL
+	#define HWRM_TF_SESSION_REGISTER                  0x2c8UL
+	#define HWRM_TF_SESSION_UNREGISTER                0x2c9UL
+	#define HWRM_TF_SESSION_CLOSE                     0x2caUL
+	#define HWRM_TF_SESSION_QCFG                      0x2cbUL
+	#define HWRM_TF_SESSION_RESC_QCAPS                0x2ccUL
+	#define HWRM_TF_SESSION_RESC_ALLOC                0x2cdUL
+	#define HWRM_TF_SESSION_RESC_FREE                 0x2ceUL
+	#define HWRM_TF_SESSION_RESC_FLUSH                0x2cfUL
+	#define HWRM_TF_SESSION_RESC_INFO                 0x2d0UL
+	#define HWRM_TF_SESSION_HOTUP_STATE_SET           0x2d1UL
+	#define HWRM_TF_SESSION_HOTUP_STATE_GET           0x2d2UL
+	#define HWRM_TF_TBL_TYPE_GET                      0x2daUL
+	#define HWRM_TF_TBL_TYPE_SET                      0x2dbUL
+	#define HWRM_TF_TBL_TYPE_BULK_GET                 0x2dcUL
+	#define HWRM_TF_EM_INSERT                         0x2eaUL
+	#define HWRM_TF_EM_DELETE                         0x2ebUL
+	#define HWRM_TF_EM_HASH_INSERT                    0x2ecUL
+	#define HWRM_TF_EM_MOVE                           0x2edUL
+	#define HWRM_TF_TCAM_SET                          0x2f8UL
+	#define HWRM_TF_TCAM_GET                          0x2f9UL
+	#define HWRM_TF_TCAM_MOVE                         0x2faUL
+	#define HWRM_TF_TCAM_FREE                         0x2fbUL
+	#define HWRM_TF_GLOBAL_CFG_SET                    0x2fcUL
+	#define HWRM_TF_GLOBAL_CFG_GET                    0x2fdUL
+	#define HWRM_TF_IF_TBL_SET                        0x2feUL
+	#define HWRM_TF_IF_TBL_GET                        0x2ffUL
+	#define HWRM_TF_RESC_USAGE_SET                    0x300UL
+	#define HWRM_TF_RESC_USAGE_QUERY                  0x301UL
+	#define HWRM_TF_TBL_TYPE_ALLOC                    0x302UL
+	#define HWRM_TF_TBL_TYPE_FREE                     0x303UL
+	#define HWRM_TFC_TBL_SCOPE_QCAPS                  0x380UL
+	#define HWRM_TFC_TBL_SCOPE_ID_ALLOC               0x381UL
+	#define HWRM_TFC_TBL_SCOPE_CONFIG                 0x382UL
+	#define HWRM_TFC_TBL_SCOPE_DECONFIG               0x383UL
+	#define HWRM_TFC_TBL_SCOPE_FID_ADD                0x384UL
+	#define HWRM_TFC_TBL_SCOPE_FID_REM                0x385UL
+	#define HWRM_TFC_TBL_SCOPE_POOL_ALLOC             0x386UL
+	#define HWRM_TFC_TBL_SCOPE_POOL_FREE              0x387UL
+	#define HWRM_TFC_SESSION_ID_ALLOC                 0x388UL
+	#define HWRM_TFC_SESSION_FID_ADD                  0x389UL
+	#define HWRM_TFC_SESSION_FID_REM                  0x38aUL
+	#define HWRM_TFC_IDENT_ALLOC                      0x38bUL
+	#define HWRM_TFC_IDENT_FREE                       0x38cUL
+	#define HWRM_TFC_IDX_TBL_ALLOC                    0x38dUL
+	#define HWRM_TFC_IDX_TBL_ALLOC_SET                0x38eUL
+	#define HWRM_TFC_IDX_TBL_SET                      0x38fUL
+	#define HWRM_TFC_IDX_TBL_GET                      0x390UL
+	#define HWRM_TFC_IDX_TBL_FREE                     0x391UL
+	#define HWRM_TFC_GLOBAL_ID_ALLOC                  0x392UL
+	#define HWRM_TFC_TCAM_SET                         0x393UL
+	#define HWRM_TFC_TCAM_GET                         0x394UL
+	#define HWRM_TFC_TCAM_ALLOC                       0x395UL
+	#define HWRM_TFC_TCAM_ALLOC_SET                   0x396UL
+	#define HWRM_TFC_TCAM_FREE                        0x397UL
+	#define HWRM_TFC_IF_TBL_SET                       0x398UL
+	#define HWRM_TFC_IF_TBL_GET                       0x399UL
+	#define HWRM_TFC_TBL_SCOPE_CONFIG_GET             0x39aUL
+	#define HWRM_TFC_RESC_USAGE_QUERY                 0x39bUL
+	#define HWRM_TFC_GLOBAL_ID_FREE                   0x39cUL
+	#define HWRM_TFC_TCAM_PRI_UPDATE                  0x39dUL
+	#define HWRM_TFC_HOT_UPGRADE_PROCESS              0x3a0UL
+	#define HWRM_TFC_SPR_BA_SET                       0x3a1UL
+	#define HWRM_TFC_SPR_BA_GET                       0x3a2UL
+	#define HWRM_MGMT_FILTER_ALLOC                    0x3e8UL
+	#define HWRM_MGMT_FILTER_FREE                     0x3e9UL
+	#define HWRM_MGMT_FILTER_CFG                      0x3eaUL
+	#define HWRM_SV                                   0x400UL
+	#define HWRM_DBG_SERDES_TEST                      0xff0eUL
+	#define HWRM_DBG_LOG_BUFFER_FLUSH                 0xff0fUL
+	#define HWRM_DBG_READ_DIRECT                      0xff10UL
+	#define HWRM_DBG_READ_INDIRECT                    0xff11UL
+	#define HWRM_DBG_WRITE_DIRECT                     0xff12UL
+	#define HWRM_DBG_WRITE_INDIRECT                   0xff13UL
+	#define HWRM_DBG_DUMP                             0xff14UL
+	#define HWRM_DBG_ERASE_NVM                        0xff15UL
+	#define HWRM_DBG_CFG                              0xff16UL
+	#define HWRM_DBG_COREDUMP_LIST                    0xff17UL
+	#define HWRM_DBG_COREDUMP_INITIATE                0xff18UL
+	#define HWRM_DBG_COREDUMP_RETRIEVE                0xff19UL
+	#define HWRM_DBG_FW_CLI                           0xff1aUL
+	#define HWRM_DBG_I2C_CMD                          0xff1bUL
+	#define HWRM_DBG_RING_INFO_GET                    0xff1cUL
+	#define HWRM_DBG_CRASHDUMP_HEADER                 0xff1dUL
+	#define HWRM_DBG_CRASHDUMP_ERASE                  0xff1eUL
+	#define HWRM_DBG_DRV_TRACE                        0xff1fUL
+	#define HWRM_DBG_QCAPS                            0xff20UL
+	#define HWRM_DBG_QCFG                             0xff21UL
+	#define HWRM_DBG_CRASHDUMP_MEDIUM_CFG             0xff22UL
+	#define HWRM_DBG_USEQ_ALLOC                       0xff23UL
+	#define HWRM_DBG_USEQ_FREE                        0xff24UL
+	#define HWRM_DBG_USEQ_FLUSH                       0xff25UL
+	#define HWRM_DBG_USEQ_QCAPS                       0xff26UL
+	#define HWRM_DBG_USEQ_CW_CFG                      0xff27UL
+	#define HWRM_DBG_USEQ_SCHED_CFG                   0xff28UL
+	#define HWRM_DBG_USEQ_RUN                         0xff29UL
+	#define HWRM_DBG_USEQ_DELIVERY_REQ                0xff2aUL
+	#define HWRM_DBG_USEQ_RESP_HDR                    0xff2bUL
+	#define HWRM_DBG_COREDUMP_CAPTURE                 0xff2cUL
+	#define HWRM_DBG_PTRACE                           0xff2dUL
+	#define HWRM_DBG_SIM_CABLE_STATE                  0xff2eUL
+	#define HWRM_DBG_TOKEN_QUERY_AUTH_IDS             0xff2fUL
+	#define HWRM_DBG_TOKEN_CFG                        0xff30UL
+	#define HWRM_DBG_TRACE_TRIGGER                    0xff31UL
+	#define HWRM_DBG_TRACE_TRIGGER_STATUS             0xff32UL
+	#define HWRM_NVM_SET_PROFILE                      0xffe9UL
+	#define HWRM_NVM_GET_VPD_FIELD_INFO               0xffeaUL
+	#define HWRM_NVM_SET_VPD_FIELD_INFO               0xffebUL
+	#define HWRM_NVM_DEFRAG                           0xffecUL
+	#define HWRM_NVM_REQ_ARBITRATION                  0xffedUL
+	#define HWRM_NVM_FACTORY_DEFAULTS                 0xffeeUL
+	#define HWRM_NVM_VALIDATE_OPTION                  0xffefUL
+	#define HWRM_NVM_FLUSH                            0xfff0UL
+	#define HWRM_NVM_GET_VARIABLE                     0xfff1UL
+	#define HWRM_NVM_SET_VARIABLE                     0xfff2UL
+	#define HWRM_NVM_INSTALL_UPDATE                   0xfff3UL
+	#define HWRM_NVM_MODIFY                           0xfff4UL
+	#define HWRM_NVM_VERIFY_UPDATE                    0xfff5UL
+	#define HWRM_NVM_GET_DEV_INFO                     0xfff6UL
+	#define HWRM_NVM_ERASE_DIR_ENTRY                  0xfff7UL
+	#define HWRM_NVM_MOD_DIR_ENTRY                    0xfff8UL
+	#define HWRM_NVM_FIND_DIR_ENTRY                   0xfff9UL
+	#define HWRM_NVM_GET_DIR_ENTRIES                  0xfffaUL
+	#define HWRM_NVM_GET_DIR_INFO                     0xfffbUL
+	#define HWRM_NVM_RAW_DUMP                         0xfffcUL
+	#define HWRM_NVM_READ                             0xfffdUL
+	#define HWRM_NVM_WRITE                            0xfffeUL
+	#define HWRM_NVM_RAW_WRITE_BLK                    0xffffUL
+	#define HWRM_LAST                                HWRM_NVM_RAW_WRITE_BLK
+	__le16	unused_0[3];
+};
+
+/* ret_codes (size:64b/8B) */
+struct ret_codes {
+	__le16	error_code;
+	#define HWRM_ERR_CODE_SUCCESS                      0x0UL
+	#define HWRM_ERR_CODE_FAIL                         0x1UL
+	#define HWRM_ERR_CODE_INVALID_PARAMS               0x2UL
+	#define HWRM_ERR_CODE_RESOURCE_ACCESS_DENIED       0x3UL
+	#define HWRM_ERR_CODE_RESOURCE_ALLOC_ERROR         0x4UL
+	#define HWRM_ERR_CODE_INVALID_FLAGS                0x5UL
+	#define HWRM_ERR_CODE_INVALID_ENABLES              0x6UL
+	#define HWRM_ERR_CODE_UNSUPPORTED_TLV              0x7UL
+	#define HWRM_ERR_CODE_NO_BUFFER                    0x8UL
+	#define HWRM_ERR_CODE_UNSUPPORTED_OPTION_ERR       0x9UL
+	#define HWRM_ERR_CODE_HOT_RESET_PROGRESS           0xaUL
+	#define HWRM_ERR_CODE_HOT_RESET_FAIL               0xbUL
+	#define HWRM_ERR_CODE_NO_FLOW_COUNTER_DURING_ALLOC 0xcUL
+	#define HWRM_ERR_CODE_KEY_HASH_COLLISION           0xdUL
+	#define HWRM_ERR_CODE_KEY_ALREADY_EXISTS           0xeUL
+	#define HWRM_ERR_CODE_HWRM_ERROR                   0xfUL
+	#define HWRM_ERR_CODE_BUSY                         0x10UL
+	#define HWRM_ERR_CODE_RESOURCE_LOCKED              0x11UL
+	#define HWRM_ERR_CODE_PF_UNAVAILABLE               0x12UL
+	#define HWRM_ERR_CODE_ENTITY_NOT_PRESENT           0x13UL
+	#define HWRM_ERR_CODE_SECURE_SOC_ERROR             0x14UL
+	#define HWRM_ERR_CODE_TLV_ENCAPSULATED_RESPONSE    0x8000UL
+	#define HWRM_ERR_CODE_UNKNOWN_ERR                  0xfffeUL
+	#define HWRM_ERR_CODE_CMD_NOT_SUPPORTED            0xffffUL
+	#define HWRM_ERR_CODE_LAST                        HWRM_ERR_CODE_CMD_NOT_SUPPORTED
+	__le16	unused_0[3];
+};
+
+/* hwrm_err_output (size:128b/16B) */
+struct hwrm_err_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le32	opaque_0;
+	__le16	opaque_1;
+	u8	cmd_err;
+	u8	valid;
+};
+
+#define HWRM_NA_SIGNATURE ((__le32)(-1))
+#define HWRM_MAX_REQ_LEN 128
+#define HWRM_MAX_RESP_LEN 704
+#define HW_HASH_INDEX_SIZE 0x80
+#define HW_HASH_KEY_SIZE 40
+#define HWRM_RESP_VALID_KEY 1
+#define HWRM_TARGET_ID_BONO 0xFFF8
+#define HWRM_TARGET_ID_KONG 0xFFF9
+#define HWRM_TARGET_ID_APE 0xFFFA
+#define HWRM_TARGET_ID_TOOLS 0xFFFD
+#define HWRM_VERSION_MAJOR 1
+#define HWRM_VERSION_MINOR 15
+#define HWRM_VERSION_UPDATE 1
+#define HWRM_VERSION_RSVD 1
+#define HWRM_VERSION_STR "1.15.1.1"
+
+/* hwrm_ver_get_input (size:192b/24B) */
+struct hwrm_ver_get_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	u8	hwrm_intf_maj;
+	u8	hwrm_intf_min;
+	u8	hwrm_intf_upd;
+	u8	unused_0[5];
+};
+
+/* hwrm_ver_get_output (size:1472b/184B) */
+struct hwrm_ver_get_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	hwrm_intf_maj_8b;
+	u8	hwrm_intf_min_8b;
+	u8	hwrm_intf_upd_8b;
+	u8	hwrm_intf_rsvd_8b;
+	u8	hwrm_fw_maj_8b;
+	u8	hwrm_fw_min_8b;
+	u8	hwrm_fw_bld_8b;
+	u8	hwrm_fw_rsvd_8b;
+	u8	mgmt_fw_maj_8b;
+	u8	mgmt_fw_min_8b;
+	u8	mgmt_fw_bld_8b;
+	u8	mgmt_fw_rsvd_8b;
+	u8	netctrl_fw_maj_8b;
+	u8	netctrl_fw_min_8b;
+	u8	netctrl_fw_bld_8b;
+	u8	netctrl_fw_rsvd_8b;
+	__le32	dev_caps_cfg;
+	#define VER_GET_RESP_DEV_CAPS_CFG_SECURE_FW_UPD_SUPPORTED                  0x1UL
+	#define VER_GET_RESP_DEV_CAPS_CFG_FW_DCBX_AGENT_SUPPORTED                  0x2UL
+	#define VER_GET_RESP_DEV_CAPS_CFG_SHORT_CMD_SUPPORTED                      0x4UL
+	#define VER_GET_RESP_DEV_CAPS_CFG_SHORT_CMD_REQUIRED                       0x8UL
+	#define VER_GET_RESP_DEV_CAPS_CFG_KONG_MB_CHNL_SUPPORTED                   0x10UL
+	#define VER_GET_RESP_DEV_CAPS_CFG_FLOW_HANDLE_64BIT_SUPPORTED              0x20UL
+	#define VER_GET_RESP_DEV_CAPS_CFG_L2_FILTER_TYPES_ROCE_OR_L2_SUPPORTED     0x40UL
+	#define VER_GET_RESP_DEV_CAPS_CFG_VIRTIO_VSWITCH_OFFLOAD_SUPPORTED         0x80UL
+	#define VER_GET_RESP_DEV_CAPS_CFG_TRUSTED_VF_SUPPORTED                     0x100UL
+	#define VER_GET_RESP_DEV_CAPS_CFG_FLOW_AGING_SUPPORTED                     0x200UL
+	#define VER_GET_RESP_DEV_CAPS_CFG_ADV_FLOW_COUNTERS_SUPPORTED              0x400UL
+	#define VER_GET_RESP_DEV_CAPS_CFG_CFA_EEM_SUPPORTED                        0x800UL
+	#define VER_GET_RESP_DEV_CAPS_CFG_CFA_ADV_FLOW_MGNT_SUPPORTED              0x1000UL
+	#define VER_GET_RESP_DEV_CAPS_CFG_CFA_TFLIB_SUPPORTED                      0x2000UL
+	#define VER_GET_RESP_DEV_CAPS_CFG_CFA_TRUFLOW_SUPPORTED                    0x4000UL
+	#define VER_GET_RESP_DEV_CAPS_CFG_SECURE_BOOT_CAPABLE                      0x8000UL
+	#define VER_GET_RESP_DEV_CAPS_CFG_SECURE_SOC_CAPABLE                       0x10000UL
+	#define VER_GET_RESP_DEV_CAPS_CFG_DEBUG_TOKEN_SUPPORTED                    0x20000UL
+	#define VER_GET_RESP_DEV_CAPS_CFG_PSP_SUPPORTED                            0x40000UL
+	#define VER_GET_RESP_DEV_CAPS_CFG_ROCE_COUNTERSET_SUPPORTED                0x80000UL
+	u8	roce_fw_maj_8b;
+	u8	roce_fw_min_8b;
+	u8	roce_fw_bld_8b;
+	u8	roce_fw_rsvd_8b;
+	char	hwrm_fw_name[16];
+	char	mgmt_fw_name[16];
+	char	netctrl_fw_name[16];
+	char	active_pkg_name[16];
+	char	roce_fw_name[16];
+	__le16	chip_num;
+	u8	chip_rev;
+	u8	chip_metal;
+	u8	chip_bond_id;
+	u8	chip_platform_type;
+	#define VER_GET_RESP_CHIP_PLATFORM_TYPE_ASIC      0x0UL
+	#define VER_GET_RESP_CHIP_PLATFORM_TYPE_FPGA      0x1UL
+	#define VER_GET_RESP_CHIP_PLATFORM_TYPE_PALLADIUM 0x2UL
+	#define VER_GET_RESP_CHIP_PLATFORM_TYPE_LAST     VER_GET_RESP_CHIP_PLATFORM_TYPE_PALLADIUM
+	__le16	max_req_win_len;
+	__le16	max_resp_len;
+	__le16	def_req_timeout;
+	u8	flags;
+	#define VER_GET_RESP_FLAGS_DEV_NOT_RDY                   0x1UL
+	#define VER_GET_RESP_FLAGS_EXT_VER_AVAIL                 0x2UL
+	#define VER_GET_RESP_FLAGS_DEV_NOT_RDY_BACKING_STORE     0x4UL
+	u8	unused_0[2];
+	u8	always_1;
+	__le16	hwrm_intf_major;
+	__le16	hwrm_intf_minor;
+	__le16	hwrm_intf_build;
+	__le16	hwrm_intf_patch;
+	__le16	hwrm_fw_major;
+	__le16	hwrm_fw_minor;
+	__le16	hwrm_fw_build;
+	__le16	hwrm_fw_patch;
+	__le16	mgmt_fw_major;
+	__le16	mgmt_fw_minor;
+	__le16	mgmt_fw_build;
+	__le16	mgmt_fw_patch;
+	__le16	netctrl_fw_major;
+	__le16	netctrl_fw_minor;
+	__le16	netctrl_fw_build;
+	__le16	netctrl_fw_patch;
+	__le16	roce_fw_major;
+	__le16	roce_fw_minor;
+	__le16	roce_fw_build;
+	__le16	roce_fw_patch;
+	__le16	max_ext_req_len;
+	__le16	max_req_timeout;
+	__le16	max_psp_supported_pfs;
+	__le16	max_psp_supported_vfs;
+	__le16	max_roce_countersets;
+	__le16	max_ext_req_timeout;
+	u8	unused_1[3];
+	u8	valid;
+};
+
+/* eject_cmpl (size:128b/16B) */
+struct eject_cmpl {
+	__le16	type;
+	#define EJECT_CMPL_TYPE_MASK       0x3fUL
+	#define EJECT_CMPL_TYPE_SFT        0
+	#define EJECT_CMPL_TYPE_STAT_EJECT   0x1aUL
+	#define EJECT_CMPL_TYPE_LAST        EJECT_CMPL_TYPE_STAT_EJECT
+	#define EJECT_CMPL_FLAGS_MASK      0xffc0UL
+	#define EJECT_CMPL_FLAGS_SFT       6
+	#define EJECT_CMPL_FLAGS_ERROR      0x40UL
+	__le16	len;
+	__le32	opaque;
+	__le16	v;
+	#define EJECT_CMPL_V                              0x1UL
+	#define EJECT_CMPL_ERRORS_MASK                    0xfffeUL
+	#define EJECT_CMPL_ERRORS_SFT                     1
+	#define EJECT_CMPL_ERRORS_BUFFER_ERROR_MASK        0xeUL
+	#define EJECT_CMPL_ERRORS_BUFFER_ERROR_SFT         1
+	#define EJECT_CMPL_ERRORS_BUFFER_ERROR_NO_BUFFER     (0x0UL << 1)
+	#define EJECT_CMPL_ERRORS_BUFFER_ERROR_DID_NOT_FIT   (0x1UL << 1)
+	#define EJECT_CMPL_ERRORS_BUFFER_ERROR_BAD_FORMAT    (0x3UL << 1)
+	#define EJECT_CMPL_ERRORS_BUFFER_ERROR_FLUSH         (0x5UL << 1)
+	#define EJECT_CMPL_ERRORS_BUFFER_ERROR_LAST         EJECT_CMPL_ERRORS_BUFFER_ERROR_FLUSH
+	__le16	reserved16;
+	__le32	unused_2;
+};
+
+/* hwrm_cmpl (size:128b/16B) */
+struct hwrm_cmpl {
+	__le16	type;
+	#define CMPL_TYPE_MASK     0x3fUL
+	#define CMPL_TYPE_SFT      0
+	#define CMPL_TYPE_HWRM_DONE  0x20UL
+	#define CMPL_TYPE_LAST      CMPL_TYPE_HWRM_DONE
+	__le16	sequence_id;
+	__le32	unused_1;
+	__le32	v;
+	#define CMPL_V     0x1UL
+	__le32	unused_3;
+};
+
+/* hwrm_fwd_req_cmpl (size:128b/16B) */
+struct hwrm_fwd_req_cmpl {
+	__le16	req_len_type;
+	#define FWD_REQ_CMPL_TYPE_MASK        0x3fUL
+	#define FWD_REQ_CMPL_TYPE_SFT         0
+	#define FWD_REQ_CMPL_TYPE_HWRM_FWD_REQ  0x22UL
+	#define FWD_REQ_CMPL_TYPE_LAST         FWD_REQ_CMPL_TYPE_HWRM_FWD_REQ
+	#define FWD_REQ_CMPL_REQ_LEN_MASK     0xffc0UL
+	#define FWD_REQ_CMPL_REQ_LEN_SFT      6
+	__le16	source_id;
+	__le32	unused0;
+	__le32	req_buf_addr_v[2];
+	#define FWD_REQ_CMPL_V                0x1UL
+	#define FWD_REQ_CMPL_REQ_BUF_ADDR_MASK 0xfffffffeUL
+	#define FWD_REQ_CMPL_REQ_BUF_ADDR_SFT 1
+};
+
+/* hwrm_fwd_resp_cmpl (size:128b/16B) */
+struct hwrm_fwd_resp_cmpl {
+	__le16	type;
+	#define FWD_RESP_CMPL_TYPE_MASK         0x3fUL
+	#define FWD_RESP_CMPL_TYPE_SFT          0
+	#define FWD_RESP_CMPL_TYPE_HWRM_FWD_RESP  0x24UL
+	#define FWD_RESP_CMPL_TYPE_LAST          FWD_RESP_CMPL_TYPE_HWRM_FWD_RESP
+	__le16	source_id;
+	__le16	resp_len;
+	__le16	unused_1;
+	__le32	resp_buf_addr_v[2];
+	#define FWD_RESP_CMPL_V                 0x1UL
+	#define FWD_RESP_CMPL_RESP_BUF_ADDR_MASK 0xfffffffeUL
+	#define FWD_RESP_CMPL_RESP_BUF_ADDR_SFT 1
+};
+
+/* hwrm_async_event_cmpl (size:128b/16B) */
+struct hwrm_async_event_cmpl {
+	__le16	type;
+	#define ASYNC_EVENT_CMPL_TYPE_MASK            0x3fUL
+	#define ASYNC_EVENT_CMPL_TYPE_SFT             0
+	#define ASYNC_EVENT_CMPL_TYPE_HWRM_ASYNC_EVENT  0x2eUL
+	#define ASYNC_EVENT_CMPL_TYPE_LAST             ASYNC_EVENT_CMPL_TYPE_HWRM_ASYNC_EVENT
+	__le16	event_id;
+	#define ASYNC_EVENT_CMPL_EVENT_ID_LINK_STATUS_CHANGE              0x0UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_LINK_MTU_CHANGE                 0x1UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_LINK_SPEED_CHANGE               0x2UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_DCB_CONFIG_CHANGE               0x3UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_PORT_CONN_NOT_ALLOWED           0x4UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_LINK_SPEED_CFG_NOT_ALLOWED      0x5UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_LINK_SPEED_CFG_CHANGE           0x6UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_PORT_PHY_CFG_CHANGE             0x7UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_RESET_NOTIFY                    0x8UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_ERROR_RECOVERY                  0x9UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_RING_MONITOR_MSG                0xaUL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_FUNC_DRVR_UNLOAD                0x10UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_FUNC_DRVR_LOAD                  0x11UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_FUNC_FLR_PROC_CMPLT             0x12UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_PF_DRVR_UNLOAD                  0x20UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_PF_DRVR_LOAD                    0x21UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_VF_FLR                          0x30UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_VF_MAC_ADDR_CHANGE              0x31UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_PF_VF_COMM_STATUS_CHANGE        0x32UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_VF_CFG_CHANGE                   0x33UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_LLFC_PFC_CHANGE                 0x34UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_DEFAULT_VNIC_CHANGE             0x35UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_HW_FLOW_AGED                    0x36UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_DEBUG_NOTIFICATION              0x37UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_EEM_CACHE_FLUSH_REQ             0x38UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_EEM_CACHE_FLUSH_DONE            0x39UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_TCP_FLAG_ACTION_CHANGE          0x3aUL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_EEM_FLOW_ACTIVE                 0x3bUL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_EEM_CFG_CHANGE                  0x3cUL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_TFLIB_DEFAULT_VNIC_CHANGE       0x3dUL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_TFLIB_LINK_STATUS_CHANGE        0x3eUL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_QUIESCE_DONE                    0x3fUL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_DEFERRED_RESPONSE               0x40UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_PFC_WATCHDOG_CFG_CHANGE         0x41UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_ECHO_REQUEST                    0x42UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_PHC_UPDATE                      0x43UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_PPS_TIMESTAMP                   0x44UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_ERROR_REPORT                    0x45UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_DOORBELL_PACING_THRESHOLD       0x46UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_RSS_CHANGE                      0x47UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_DOORBELL_PACING_NQ_UPDATE       0x48UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_HW_DOORBELL_RECOVERY_READ_ERROR 0x49UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_CTX_ERROR                       0x4aUL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_UDCC_SESSION_CHANGE             0x4bUL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_DBG_BUF_PRODUCER                0x4cUL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_PEER_MMAP_CHANGE                0x4dUL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_REPRESENTOR_PAIR_CHANGE         0x4eUL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_VF_STAT_CHANGE                  0x4fUL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_HOST_COREDUMP                   0x50UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_PNO_HOST_DMA_COMPLETE           0x51UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_VF_GID_UPDATE                   0x52UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_ADPTV_QOS                       0x53UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_FABRIC_NEXT_HOP_IP_UPDATED      0x54UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_MAX_RGTR_EVENT_ID               0x55UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_PSP_SM_KEY_ROTATE_NOTIFY        0x56UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_FW_TRACE_MSG                    0xfeUL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_HWRM_ERROR                      0xffUL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_LAST                           ASYNC_EVENT_CMPL_EVENT_ID_HWRM_ERROR
+	__le32	event_data2;
+	u8	opaque_v;
+	#define ASYNC_EVENT_CMPL_V          0x1UL
+	#define ASYNC_EVENT_CMPL_OPAQUE_MASK 0xfeUL
+	#define ASYNC_EVENT_CMPL_OPAQUE_SFT 1
+	u8	timestamp_lo;
+	__le16	timestamp_hi;
+	__le32	event_data1;
+};
+
+/* hwrm_async_event_cmpl_link_status_change (size:128b/16B) */
+struct hwrm_async_event_cmpl_link_status_change {
+	__le16	type;
+	#define ASYNC_EVENT_CMPL_LINK_STATUS_CHANGE_TYPE_MASK            0x3fUL
+	#define ASYNC_EVENT_CMPL_LINK_STATUS_CHANGE_TYPE_SFT             0
+	#define ASYNC_EVENT_CMPL_LINK_STATUS_CHANGE_TYPE_HWRM_ASYNC_EVENT  0x2eUL
+	#define ASYNC_EVENT_CMPL_LINK_STATUS_CHANGE_TYPE_LAST             ASYNC_EVENT_CMPL_LINK_STATUS_CHANGE_TYPE_HWRM_ASYNC_EVENT
+	__le16	event_id;
+	#define ASYNC_EVENT_CMPL_LINK_STATUS_CHANGE_EVENT_ID_LINK_STATUS_CHANGE 0x0UL
+	#define ASYNC_EVENT_CMPL_LINK_STATUS_CHANGE_EVENT_ID_LAST              ASYNC_EVENT_CMPL_LINK_STATUS_CHANGE_EVENT_ID_LINK_STATUS_CHANGE
+	__le32	event_data2;
+	u8	opaque_v;
+	#define ASYNC_EVENT_CMPL_LINK_STATUS_CHANGE_V          0x1UL
+	#define ASYNC_EVENT_CMPL_LINK_STATUS_CHANGE_OPAQUE_MASK 0xfeUL
+	#define ASYNC_EVENT_CMPL_LINK_STATUS_CHANGE_OPAQUE_SFT 1
+	u8	timestamp_lo;
+	__le16	timestamp_hi;
+	__le32	event_data1;
+	#define ASYNC_EVENT_CMPL_LINK_STATUS_CHANGE_EVENT_DATA1_LINK_CHANGE     0x1UL
+	#define ASYNC_EVENT_CMPL_LINK_STATUS_CHANGE_EVENT_DATA1_LINK_CHANGE_DOWN  0x0UL
+	#define ASYNC_EVENT_CMPL_LINK_STATUS_CHANGE_EVENT_DATA1_LINK_CHANGE_UP    0x1UL
+	#define ASYNC_EVENT_CMPL_LINK_STATUS_CHANGE_EVENT_DATA1_LINK_CHANGE_LAST ASYNC_EVENT_CMPL_LINK_STATUS_CHANGE_EVENT_DATA1_LINK_CHANGE_UP
+	#define ASYNC_EVENT_CMPL_LINK_STATUS_CHANGE_EVENT_DATA1_PORT_MASK       0xeUL
+	#define ASYNC_EVENT_CMPL_LINK_STATUS_CHANGE_EVENT_DATA1_PORT_SFT        1
+	#define ASYNC_EVENT_CMPL_LINK_STATUS_CHANGE_EVENT_DATA1_PORT_ID_MASK    0xffff0UL
+	#define ASYNC_EVENT_CMPL_LINK_STATUS_CHANGE_EVENT_DATA1_PORT_ID_SFT     4
+	#define ASYNC_EVENT_CMPL_LINK_STATUS_CHANGE_EVENT_DATA1_PF_ID_MASK      0xff00000UL
+	#define ASYNC_EVENT_CMPL_LINK_STATUS_CHANGE_EVENT_DATA1_PF_ID_SFT       20
+};
+
+/* hwrm_async_event_cmpl_port_conn_not_allowed (size:128b/16B) */
+struct hwrm_async_event_cmpl_port_conn_not_allowed {
+	__le16	type;
+	#define ASYNC_EVENT_CMPL_PORT_CONN_NOT_ALLOWED_TYPE_MASK            0x3fUL
+	#define ASYNC_EVENT_CMPL_PORT_CONN_NOT_ALLOWED_TYPE_SFT             0
+	#define ASYNC_EVENT_CMPL_PORT_CONN_NOT_ALLOWED_TYPE_HWRM_ASYNC_EVENT  0x2eUL
+	#define ASYNC_EVENT_CMPL_PORT_CONN_NOT_ALLOWED_TYPE_LAST             ASYNC_EVENT_CMPL_PORT_CONN_NOT_ALLOWED_TYPE_HWRM_ASYNC_EVENT
+	__le16	event_id;
+	#define ASYNC_EVENT_CMPL_PORT_CONN_NOT_ALLOWED_EVENT_ID_PORT_CONN_NOT_ALLOWED 0x4UL
+	#define ASYNC_EVENT_CMPL_PORT_CONN_NOT_ALLOWED_EVENT_ID_LAST                 ASYNC_EVENT_CMPL_PORT_CONN_NOT_ALLOWED_EVENT_ID_PORT_CONN_NOT_ALLOWED
+	__le32	event_data2;
+	u8	opaque_v;
+	#define ASYNC_EVENT_CMPL_PORT_CONN_NOT_ALLOWED_V          0x1UL
+	#define ASYNC_EVENT_CMPL_PORT_CONN_NOT_ALLOWED_OPAQUE_MASK 0xfeUL
+	#define ASYNC_EVENT_CMPL_PORT_CONN_NOT_ALLOWED_OPAQUE_SFT 1
+	u8	timestamp_lo;
+	__le16	timestamp_hi;
+	__le32	event_data1;
+	#define ASYNC_EVENT_CMPL_PORT_CONN_NOT_ALLOWED_EVENT_DATA1_PORT_ID_MASK                 0xffffUL
+	#define ASYNC_EVENT_CMPL_PORT_CONN_NOT_ALLOWED_EVENT_DATA1_PORT_ID_SFT                  0
+	#define ASYNC_EVENT_CMPL_PORT_CONN_NOT_ALLOWED_EVENT_DATA1_ENFORCEMENT_POLICY_MASK      0xff0000UL
+	#define ASYNC_EVENT_CMPL_PORT_CONN_NOT_ALLOWED_EVENT_DATA1_ENFORCEMENT_POLICY_SFT       16
+	#define ASYNC_EVENT_CMPL_PORT_CONN_NOT_ALLOWED_EVENT_DATA1_ENFORCEMENT_POLICY_NONE        (0x0UL << 16)
+	#define ASYNC_EVENT_CMPL_PORT_CONN_NOT_ALLOWED_EVENT_DATA1_ENFORCEMENT_POLICY_DISABLETX   (0x1UL << 16)
+	#define ASYNC_EVENT_CMPL_PORT_CONN_NOT_ALLOWED_EVENT_DATA1_ENFORCEMENT_POLICY_WARNINGMSG  (0x2UL << 16)
+	#define ASYNC_EVENT_CMPL_PORT_CONN_NOT_ALLOWED_EVENT_DATA1_ENFORCEMENT_POLICY_PWRDOWN     (0x3UL << 16)
+	#define ASYNC_EVENT_CMPL_PORT_CONN_NOT_ALLOWED_EVENT_DATA1_ENFORCEMENT_POLICY_LAST       ASYNC_EVENT_CMPL_PORT_CONN_NOT_ALLOWED_EVENT_DATA1_ENFORCEMENT_POLICY_PWRDOWN
+};
+
+/* hwrm_async_event_cmpl_link_speed_cfg_change (size:128b/16B) */
+struct hwrm_async_event_cmpl_link_speed_cfg_change {
+	__le16	type;
+	#define ASYNC_EVENT_CMPL_LINK_SPEED_CFG_CHANGE_TYPE_MASK            0x3fUL
+	#define ASYNC_EVENT_CMPL_LINK_SPEED_CFG_CHANGE_TYPE_SFT             0
+	#define ASYNC_EVENT_CMPL_LINK_SPEED_CFG_CHANGE_TYPE_HWRM_ASYNC_EVENT  0x2eUL
+	#define ASYNC_EVENT_CMPL_LINK_SPEED_CFG_CHANGE_TYPE_LAST             ASYNC_EVENT_CMPL_LINK_SPEED_CFG_CHANGE_TYPE_HWRM_ASYNC_EVENT
+	__le16	event_id;
+	#define ASYNC_EVENT_CMPL_LINK_SPEED_CFG_CHANGE_EVENT_ID_LINK_SPEED_CFG_CHANGE 0x6UL
+	#define ASYNC_EVENT_CMPL_LINK_SPEED_CFG_CHANGE_EVENT_ID_LAST                 ASYNC_EVENT_CMPL_LINK_SPEED_CFG_CHANGE_EVENT_ID_LINK_SPEED_CFG_CHANGE
+	__le32	event_data2;
+	u8	opaque_v;
+	#define ASYNC_EVENT_CMPL_LINK_SPEED_CFG_CHANGE_V          0x1UL
+	#define ASYNC_EVENT_CMPL_LINK_SPEED_CFG_CHANGE_OPAQUE_MASK 0xfeUL
+	#define ASYNC_EVENT_CMPL_LINK_SPEED_CFG_CHANGE_OPAQUE_SFT 1
+	u8	timestamp_lo;
+	__le16	timestamp_hi;
+	__le32	event_data1;
+	#define ASYNC_EVENT_CMPL_LINK_SPEED_CFG_CHANGE_EVENT_DATA1_PORT_ID_MASK                     0xffffUL
+	#define ASYNC_EVENT_CMPL_LINK_SPEED_CFG_CHANGE_EVENT_DATA1_PORT_ID_SFT                      0
+	#define ASYNC_EVENT_CMPL_LINK_SPEED_CFG_CHANGE_EVENT_DATA1_SUPPORTED_LINK_SPEEDS_CHANGE     0x10000UL
+	#define ASYNC_EVENT_CMPL_LINK_SPEED_CFG_CHANGE_EVENT_DATA1_ILLEGAL_LINK_SPEED_CFG           0x20000UL
+};
+
+/* hwrm_async_event_cmpl_reset_notify (size:128b/16B) */
+struct hwrm_async_event_cmpl_reset_notify {
+	__le16	type;
+	#define ASYNC_EVENT_CMPL_RESET_NOTIFY_TYPE_MASK            0x3fUL
+	#define ASYNC_EVENT_CMPL_RESET_NOTIFY_TYPE_SFT             0
+	#define ASYNC_EVENT_CMPL_RESET_NOTIFY_TYPE_HWRM_ASYNC_EVENT  0x2eUL
+	#define ASYNC_EVENT_CMPL_RESET_NOTIFY_TYPE_LAST             ASYNC_EVENT_CMPL_RESET_NOTIFY_TYPE_HWRM_ASYNC_EVENT
+	__le16	event_id;
+	#define ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_ID_RESET_NOTIFY 0x8UL
+	#define ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_ID_LAST        ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_ID_RESET_NOTIFY
+	__le32	event_data2;
+	#define ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA2_FW_STATUS_CODE_MASK 0xffffUL
+	#define ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA2_FW_STATUS_CODE_SFT 0
+	u8	opaque_v;
+	#define ASYNC_EVENT_CMPL_RESET_NOTIFY_V          0x1UL
+	#define ASYNC_EVENT_CMPL_RESET_NOTIFY_OPAQUE_MASK 0xfeUL
+	#define ASYNC_EVENT_CMPL_RESET_NOTIFY_OPAQUE_SFT 1
+	u8	timestamp_lo;
+	__le16	timestamp_hi;
+	__le32	event_data1;
+	#define ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA1_DRIVER_ACTION_MASK                  0xffUL
+	#define ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA1_DRIVER_ACTION_SFT                   0
+	#define ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA1_DRIVER_ACTION_DRIVER_STOP_TX_QUEUE    0x1UL
+	#define ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA1_DRIVER_ACTION_DRIVER_IFDOWN           0x2UL
+	#define ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA1_DRIVER_ACTION_LAST                   ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA1_DRIVER_ACTION_DRIVER_IFDOWN
+	#define ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA1_REASON_CODE_MASK                    0xff00UL
+	#define ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA1_REASON_CODE_SFT                     8
+	#define ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA1_REASON_CODE_MANAGEMENT_RESET_REQUEST  (0x1UL << 8)
+	#define ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA1_REASON_CODE_FW_EXCEPTION_FATAL        (0x2UL << 8)
+	#define ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA1_REASON_CODE_FW_EXCEPTION_NON_FATAL    (0x3UL << 8)
+	#define ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA1_REASON_CODE_FAST_RESET                (0x4UL << 8)
+	#define ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA1_REASON_CODE_FW_ACTIVATION             (0x5UL << 8)
+	#define ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA1_REASON_CODE_LAST                     ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA1_REASON_CODE_FW_ACTIVATION
+	#define ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA1_DELAY_IN_100MS_TICKS_MASK           0xffff0000UL
+	#define ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA1_DELAY_IN_100MS_TICKS_SFT            16
+};
+
+/* hwrm_async_event_cmpl_error_recovery (size:128b/16B) */
+struct hwrm_async_event_cmpl_error_recovery {
+	__le16	type;
+	#define ASYNC_EVENT_CMPL_ERROR_RECOVERY_TYPE_MASK            0x3fUL
+	#define ASYNC_EVENT_CMPL_ERROR_RECOVERY_TYPE_SFT             0
+	#define ASYNC_EVENT_CMPL_ERROR_RECOVERY_TYPE_HWRM_ASYNC_EVENT  0x2eUL
+	#define ASYNC_EVENT_CMPL_ERROR_RECOVERY_TYPE_LAST             ASYNC_EVENT_CMPL_ERROR_RECOVERY_TYPE_HWRM_ASYNC_EVENT
+	__le16	event_id;
+	#define ASYNC_EVENT_CMPL_ERROR_RECOVERY_EVENT_ID_ERROR_RECOVERY 0x9UL
+	#define ASYNC_EVENT_CMPL_ERROR_RECOVERY_EVENT_ID_LAST          ASYNC_EVENT_CMPL_ERROR_RECOVERY_EVENT_ID_ERROR_RECOVERY
+	__le32	event_data2;
+	u8	opaque_v;
+	#define ASYNC_EVENT_CMPL_ERROR_RECOVERY_V          0x1UL
+	#define ASYNC_EVENT_CMPL_ERROR_RECOVERY_OPAQUE_MASK 0xfeUL
+	#define ASYNC_EVENT_CMPL_ERROR_RECOVERY_OPAQUE_SFT 1
+	u8	timestamp_lo;
+	__le16	timestamp_hi;
+	__le32	event_data1;
+	#define ASYNC_EVENT_CMPL_ERROR_RECOVERY_EVENT_DATA1_FLAGS_MASK                 0xffUL
+	#define ASYNC_EVENT_CMPL_ERROR_RECOVERY_EVENT_DATA1_FLAGS_SFT                  0
+	#define ASYNC_EVENT_CMPL_ERROR_RECOVERY_EVENT_DATA1_FLAGS_MASTER_FUNC           0x1UL
+	#define ASYNC_EVENT_CMPL_ERROR_RECOVERY_EVENT_DATA1_FLAGS_RECOVERY_ENABLED      0x2UL
+};
+
+/* hwrm_async_event_cmpl_ring_monitor_msg (size:128b/16B) */
+struct hwrm_async_event_cmpl_ring_monitor_msg {
+	__le16	type;
+	#define ASYNC_EVENT_CMPL_RING_MONITOR_MSG_TYPE_MASK            0x3fUL
+	#define ASYNC_EVENT_CMPL_RING_MONITOR_MSG_TYPE_SFT             0
+	#define ASYNC_EVENT_CMPL_RING_MONITOR_MSG_TYPE_HWRM_ASYNC_EVENT  0x2eUL
+	#define ASYNC_EVENT_CMPL_RING_MONITOR_MSG_TYPE_LAST             ASYNC_EVENT_CMPL_RING_MONITOR_MSG_TYPE_HWRM_ASYNC_EVENT
+	__le16	event_id;
+	#define ASYNC_EVENT_CMPL_RING_MONITOR_MSG_EVENT_ID_RING_MONITOR_MSG 0xaUL
+	#define ASYNC_EVENT_CMPL_RING_MONITOR_MSG_EVENT_ID_LAST            ASYNC_EVENT_CMPL_RING_MONITOR_MSG_EVENT_ID_RING_MONITOR_MSG
+	__le32	event_data2;
+	#define ASYNC_EVENT_CMPL_RING_MONITOR_MSG_EVENT_DATA2_DISABLE_RING_TYPE_MASK 0xffUL
+	#define ASYNC_EVENT_CMPL_RING_MONITOR_MSG_EVENT_DATA2_DISABLE_RING_TYPE_SFT 0
+	#define ASYNC_EVENT_CMPL_RING_MONITOR_MSG_EVENT_DATA2_DISABLE_RING_TYPE_TX    0x0UL
+	#define ASYNC_EVENT_CMPL_RING_MONITOR_MSG_EVENT_DATA2_DISABLE_RING_TYPE_RX    0x1UL
+	#define ASYNC_EVENT_CMPL_RING_MONITOR_MSG_EVENT_DATA2_DISABLE_RING_TYPE_CMPL  0x2UL
+	#define ASYNC_EVENT_CMPL_RING_MONITOR_MSG_EVENT_DATA2_DISABLE_RING_TYPE_LAST ASYNC_EVENT_CMPL_RING_MONITOR_MSG_EVENT_DATA2_DISABLE_RING_TYPE_CMPL
+	u8	opaque_v;
+	#define ASYNC_EVENT_CMPL_RING_MONITOR_MSG_V          0x1UL
+	#define ASYNC_EVENT_CMPL_RING_MONITOR_MSG_OPAQUE_MASK 0xfeUL
+	#define ASYNC_EVENT_CMPL_RING_MONITOR_MSG_OPAQUE_SFT 1
+	u8	timestamp_lo;
+	__le16	timestamp_hi;
+	__le32	event_data1;
+};
+
+/* hwrm_async_event_cmpl_vf_cfg_change (size:128b/16B) */
+struct hwrm_async_event_cmpl_vf_cfg_change {
+	__le16	type;
+	#define ASYNC_EVENT_CMPL_VF_CFG_CHANGE_TYPE_MASK            0x3fUL
+	#define ASYNC_EVENT_CMPL_VF_CFG_CHANGE_TYPE_SFT             0
+	#define ASYNC_EVENT_CMPL_VF_CFG_CHANGE_TYPE_HWRM_ASYNC_EVENT  0x2eUL
+	#define ASYNC_EVENT_CMPL_VF_CFG_CHANGE_TYPE_LAST             ASYNC_EVENT_CMPL_VF_CFG_CHANGE_TYPE_HWRM_ASYNC_EVENT
+	__le16	event_id;
+	#define ASYNC_EVENT_CMPL_VF_CFG_CHANGE_EVENT_ID_VF_CFG_CHANGE 0x33UL
+	#define ASYNC_EVENT_CMPL_VF_CFG_CHANGE_EVENT_ID_LAST         ASYNC_EVENT_CMPL_VF_CFG_CHANGE_EVENT_ID_VF_CFG_CHANGE
+	__le32	event_data2;
+	#define ASYNC_EVENT_CMPL_VF_CFG_CHANGE_EVENT_DATA2_VF_ID_MASK 0xffffUL
+	#define ASYNC_EVENT_CMPL_VF_CFG_CHANGE_EVENT_DATA2_VF_ID_SFT 0
+	u8	opaque_v;
+	#define ASYNC_EVENT_CMPL_VF_CFG_CHANGE_V          0x1UL
+	#define ASYNC_EVENT_CMPL_VF_CFG_CHANGE_OPAQUE_MASK 0xfeUL
+	#define ASYNC_EVENT_CMPL_VF_CFG_CHANGE_OPAQUE_SFT 1
+	u8	timestamp_lo;
+	__le16	timestamp_hi;
+	__le32	event_data1;
+	#define ASYNC_EVENT_CMPL_VF_CFG_CHANGE_EVENT_DATA1_MTU_CHANGE                0x1UL
+	#define ASYNC_EVENT_CMPL_VF_CFG_CHANGE_EVENT_DATA1_MRU_CHANGE                0x2UL
+	#define ASYNC_EVENT_CMPL_VF_CFG_CHANGE_EVENT_DATA1_DFLT_MAC_ADDR_CHANGE      0x4UL
+	#define ASYNC_EVENT_CMPL_VF_CFG_CHANGE_EVENT_DATA1_DFLT_VLAN_CHANGE          0x8UL
+	#define ASYNC_EVENT_CMPL_VF_CFG_CHANGE_EVENT_DATA1_TRUSTED_VF_CFG_CHANGE     0x10UL
+	#define ASYNC_EVENT_CMPL_VF_CFG_CHANGE_EVENT_DATA1_TF_OWNERSHIP_RELEASE      0x20UL
+};
+
+/* hwrm_async_event_cmpl_default_vnic_change (size:128b/16B) */
+struct hwrm_async_event_cmpl_default_vnic_change {
+	__le16	type;
+	#define ASYNC_EVENT_CMPL_DEFAULT_VNIC_CHANGE_TYPE_MASK            0x3fUL
+	#define ASYNC_EVENT_CMPL_DEFAULT_VNIC_CHANGE_TYPE_SFT             0
+	#define ASYNC_EVENT_CMPL_DEFAULT_VNIC_CHANGE_TYPE_HWRM_ASYNC_EVENT  0x2eUL
+	#define ASYNC_EVENT_CMPL_DEFAULT_VNIC_CHANGE_TYPE_LAST             ASYNC_EVENT_CMPL_DEFAULT_VNIC_CHANGE_TYPE_HWRM_ASYNC_EVENT
+	#define ASYNC_EVENT_CMPL_DEFAULT_VNIC_CHANGE_UNUSED1_MASK         0xffc0UL
+	#define ASYNC_EVENT_CMPL_DEFAULT_VNIC_CHANGE_UNUSED1_SFT          6
+	__le16	event_id;
+	#define ASYNC_EVENT_CMPL_DEFAULT_VNIC_CHANGE_EVENT_ID_ALLOC_FREE_NOTIFICATION 0x35UL
+	#define ASYNC_EVENT_CMPL_DEFAULT_VNIC_CHANGE_EVENT_ID_LAST                   ASYNC_EVENT_CMPL_DEFAULT_VNIC_CHANGE_EVENT_ID_ALLOC_FREE_NOTIFICATION
+	__le32	event_data2;
+	u8	opaque_v;
+	#define ASYNC_EVENT_CMPL_DEFAULT_VNIC_CHANGE_V          0x1UL
+	#define ASYNC_EVENT_CMPL_DEFAULT_VNIC_CHANGE_OPAQUE_MASK 0xfeUL
+	#define ASYNC_EVENT_CMPL_DEFAULT_VNIC_CHANGE_OPAQUE_SFT 1
+	u8	timestamp_lo;
+	__le16	timestamp_hi;
+	__le32	event_data1;
+	#define ASYNC_EVENT_CMPL_DEFAULT_VNIC_CHANGE_EVENT_DATA1_DEF_VNIC_STATE_MASK          0x3UL
+	#define ASYNC_EVENT_CMPL_DEFAULT_VNIC_CHANGE_EVENT_DATA1_DEF_VNIC_STATE_SFT           0
+	#define ASYNC_EVENT_CMPL_DEFAULT_VNIC_CHANGE_EVENT_DATA1_DEF_VNIC_STATE_DEF_VNIC_ALLOC  0x1UL
+	#define ASYNC_EVENT_CMPL_DEFAULT_VNIC_CHANGE_EVENT_DATA1_DEF_VNIC_STATE_DEF_VNIC_FREE   0x2UL
+	#define ASYNC_EVENT_CMPL_DEFAULT_VNIC_CHANGE_EVENT_DATA1_DEF_VNIC_STATE_LAST           ASYNC_EVENT_CMPL_DEFAULT_VNIC_CHANGE_EVENT_DATA1_DEF_VNIC_STATE_DEF_VNIC_FREE
+	#define ASYNC_EVENT_CMPL_DEFAULT_VNIC_CHANGE_EVENT_DATA1_PF_ID_MASK                   0x3fcUL
+	#define ASYNC_EVENT_CMPL_DEFAULT_VNIC_CHANGE_EVENT_DATA1_PF_ID_SFT                    2
+	#define ASYNC_EVENT_CMPL_DEFAULT_VNIC_CHANGE_EVENT_DATA1_VF_ID_MASK                   0x3fffc00UL
+	#define ASYNC_EVENT_CMPL_DEFAULT_VNIC_CHANGE_EVENT_DATA1_VF_ID_SFT                    10
+};
+
+/* hwrm_async_event_cmpl_hw_flow_aged (size:128b/16B) */
+struct hwrm_async_event_cmpl_hw_flow_aged {
+	__le16	type;
+	#define ASYNC_EVENT_CMPL_HW_FLOW_AGED_TYPE_MASK            0x3fUL
+	#define ASYNC_EVENT_CMPL_HW_FLOW_AGED_TYPE_SFT             0
+	#define ASYNC_EVENT_CMPL_HW_FLOW_AGED_TYPE_HWRM_ASYNC_EVENT  0x2eUL
+	#define ASYNC_EVENT_CMPL_HW_FLOW_AGED_TYPE_LAST             ASYNC_EVENT_CMPL_HW_FLOW_AGED_TYPE_HWRM_ASYNC_EVENT
+	__le16	event_id;
+	#define ASYNC_EVENT_CMPL_HW_FLOW_AGED_EVENT_ID_HW_FLOW_AGED 0x36UL
+	#define ASYNC_EVENT_CMPL_HW_FLOW_AGED_EVENT_ID_LAST        ASYNC_EVENT_CMPL_HW_FLOW_AGED_EVENT_ID_HW_FLOW_AGED
+	__le32	event_data2;
+	u8	opaque_v;
+	#define ASYNC_EVENT_CMPL_HW_FLOW_AGED_V          0x1UL
+	#define ASYNC_EVENT_CMPL_HW_FLOW_AGED_OPAQUE_MASK 0xfeUL
+	#define ASYNC_EVENT_CMPL_HW_FLOW_AGED_OPAQUE_SFT 1
+	u8	timestamp_lo;
+	__le16	timestamp_hi;
+	__le32	event_data1;
+	#define ASYNC_EVENT_CMPL_HW_FLOW_AGED_EVENT_DATA1_FLOW_ID_MASK       0x7fffffffUL
+	#define ASYNC_EVENT_CMPL_HW_FLOW_AGED_EVENT_DATA1_FLOW_ID_SFT        0
+	#define ASYNC_EVENT_CMPL_HW_FLOW_AGED_EVENT_DATA1_FLOW_DIRECTION     0x80000000UL
+	#define ASYNC_EVENT_CMPL_HW_FLOW_AGED_EVENT_DATA1_FLOW_DIRECTION_RX    (0x0UL << 31)
+	#define ASYNC_EVENT_CMPL_HW_FLOW_AGED_EVENT_DATA1_FLOW_DIRECTION_TX    (0x1UL << 31)
+	#define ASYNC_EVENT_CMPL_HW_FLOW_AGED_EVENT_DATA1_FLOW_DIRECTION_LAST ASYNC_EVENT_CMPL_HW_FLOW_AGED_EVENT_DATA1_FLOW_DIRECTION_TX
+};
+
+/* hwrm_async_event_cmpl_eem_cache_flush_req (size:128b/16B) */
+struct hwrm_async_event_cmpl_eem_cache_flush_req {
+	__le16	type;
+	#define ASYNC_EVENT_CMPL_EEM_CACHE_FLUSH_REQ_TYPE_MASK            0x3fUL
+	#define ASYNC_EVENT_CMPL_EEM_CACHE_FLUSH_REQ_TYPE_SFT             0
+	#define ASYNC_EVENT_CMPL_EEM_CACHE_FLUSH_REQ_TYPE_HWRM_ASYNC_EVENT  0x2eUL
+	#define ASYNC_EVENT_CMPL_EEM_CACHE_FLUSH_REQ_TYPE_LAST             ASYNC_EVENT_CMPL_EEM_CACHE_FLUSH_REQ_TYPE_HWRM_ASYNC_EVENT
+	__le16	event_id;
+	#define ASYNC_EVENT_CMPL_EEM_CACHE_FLUSH_REQ_EVENT_ID_EEM_CACHE_FLUSH_REQ 0x38UL
+	#define ASYNC_EVENT_CMPL_EEM_CACHE_FLUSH_REQ_EVENT_ID_LAST               ASYNC_EVENT_CMPL_EEM_CACHE_FLUSH_REQ_EVENT_ID_EEM_CACHE_FLUSH_REQ
+	__le32	event_data2;
+	u8	opaque_v;
+	#define ASYNC_EVENT_CMPL_EEM_CACHE_FLUSH_REQ_V          0x1UL
+	#define ASYNC_EVENT_CMPL_EEM_CACHE_FLUSH_REQ_OPAQUE_MASK 0xfeUL
+	#define ASYNC_EVENT_CMPL_EEM_CACHE_FLUSH_REQ_OPAQUE_SFT 1
+	u8	timestamp_lo;
+	__le16	timestamp_hi;
+	__le32	event_data1;
+};
+
+/* hwrm_async_event_cmpl_eem_cache_flush_done (size:128b/16B) */
+struct hwrm_async_event_cmpl_eem_cache_flush_done {
+	__le16	type;
+	#define ASYNC_EVENT_CMPL_EEM_CACHE_FLUSH_DONE_TYPE_MASK            0x3fUL
+	#define ASYNC_EVENT_CMPL_EEM_CACHE_FLUSH_DONE_TYPE_SFT             0
+	#define ASYNC_EVENT_CMPL_EEM_CACHE_FLUSH_DONE_TYPE_HWRM_ASYNC_EVENT  0x2eUL
+	#define ASYNC_EVENT_CMPL_EEM_CACHE_FLUSH_DONE_TYPE_LAST             ASYNC_EVENT_CMPL_EEM_CACHE_FLUSH_DONE_TYPE_HWRM_ASYNC_EVENT
+	__le16	event_id;
+	#define ASYNC_EVENT_CMPL_EEM_CACHE_FLUSH_DONE_EVENT_ID_EEM_CACHE_FLUSH_DONE 0x39UL
+	#define ASYNC_EVENT_CMPL_EEM_CACHE_FLUSH_DONE_EVENT_ID_LAST                ASYNC_EVENT_CMPL_EEM_CACHE_FLUSH_DONE_EVENT_ID_EEM_CACHE_FLUSH_DONE
+	__le32	event_data2;
+	u8	opaque_v;
+	#define ASYNC_EVENT_CMPL_EEM_CACHE_FLUSH_DONE_V          0x1UL
+	#define ASYNC_EVENT_CMPL_EEM_CACHE_FLUSH_DONE_OPAQUE_MASK 0xfeUL
+	#define ASYNC_EVENT_CMPL_EEM_CACHE_FLUSH_DONE_OPAQUE_SFT 1
+	u8	timestamp_lo;
+	__le16	timestamp_hi;
+	__le32	event_data1;
+	#define ASYNC_EVENT_CMPL_EEM_CACHE_FLUSH_DONE_EVENT_DATA1_FID_MASK 0xffffUL
+	#define ASYNC_EVENT_CMPL_EEM_CACHE_FLUSH_DONE_EVENT_DATA1_FID_SFT 0
+};
+
+/* hwrm_async_event_cmpl_deferred_response (size:128b/16B) */
+struct hwrm_async_event_cmpl_deferred_response {
+	__le16	type;
+	#define ASYNC_EVENT_CMPL_DEFERRED_RESPONSE_TYPE_MASK            0x3fUL
+	#define ASYNC_EVENT_CMPL_DEFERRED_RESPONSE_TYPE_SFT             0
+	#define ASYNC_EVENT_CMPL_DEFERRED_RESPONSE_TYPE_HWRM_ASYNC_EVENT  0x2eUL
+	#define ASYNC_EVENT_CMPL_DEFERRED_RESPONSE_TYPE_LAST             ASYNC_EVENT_CMPL_DEFERRED_RESPONSE_TYPE_HWRM_ASYNC_EVENT
+	__le16	event_id;
+	#define ASYNC_EVENT_CMPL_DEFERRED_RESPONSE_EVENT_ID_DEFERRED_RESPONSE 0x40UL
+	#define ASYNC_EVENT_CMPL_DEFERRED_RESPONSE_EVENT_ID_LAST             ASYNC_EVENT_CMPL_DEFERRED_RESPONSE_EVENT_ID_DEFERRED_RESPONSE
+	__le32	event_data2;
+	#define ASYNC_EVENT_CMPL_DEFERRED_RESPONSE_EVENT_DATA2_SEQ_ID_MASK 0xffffUL
+	#define ASYNC_EVENT_CMPL_DEFERRED_RESPONSE_EVENT_DATA2_SEQ_ID_SFT 0
+	u8	opaque_v;
+	#define ASYNC_EVENT_CMPL_DEFERRED_RESPONSE_V          0x1UL
+	#define ASYNC_EVENT_CMPL_DEFERRED_RESPONSE_OPAQUE_MASK 0xfeUL
+	#define ASYNC_EVENT_CMPL_DEFERRED_RESPONSE_OPAQUE_SFT 1
+	u8	timestamp_lo;
+	__le16	timestamp_hi;
+	__le32	event_data1;
+};
+
+/* hwrm_async_event_cmpl_echo_request (size:128b/16B) */
+struct hwrm_async_event_cmpl_echo_request {
+	__le16	type;
+	#define ASYNC_EVENT_CMPL_ECHO_REQUEST_TYPE_MASK            0x3fUL
+	#define ASYNC_EVENT_CMPL_ECHO_REQUEST_TYPE_SFT             0
+	#define ASYNC_EVENT_CMPL_ECHO_REQUEST_TYPE_HWRM_ASYNC_EVENT  0x2eUL
+	#define ASYNC_EVENT_CMPL_ECHO_REQUEST_TYPE_LAST             ASYNC_EVENT_CMPL_ECHO_REQUEST_TYPE_HWRM_ASYNC_EVENT
+	__le16	event_id;
+	#define ASYNC_EVENT_CMPL_ECHO_REQUEST_EVENT_ID_ECHO_REQUEST 0x42UL
+	#define ASYNC_EVENT_CMPL_ECHO_REQUEST_EVENT_ID_LAST        ASYNC_EVENT_CMPL_ECHO_REQUEST_EVENT_ID_ECHO_REQUEST
+	__le32	event_data2;
+	u8	opaque_v;
+	#define ASYNC_EVENT_CMPL_ECHO_REQUEST_V          0x1UL
+	#define ASYNC_EVENT_CMPL_ECHO_REQUEST_OPAQUE_MASK 0xfeUL
+	#define ASYNC_EVENT_CMPL_ECHO_REQUEST_OPAQUE_SFT 1
+	u8	timestamp_lo;
+	__le16	timestamp_hi;
+	__le32	event_data1;
+};
+
+/* hwrm_async_event_cmpl_phc_update (size:128b/16B) */
+struct hwrm_async_event_cmpl_phc_update {
+	__le16	type;
+	#define ASYNC_EVENT_CMPL_PHC_UPDATE_TYPE_MASK            0x3fUL
+	#define ASYNC_EVENT_CMPL_PHC_UPDATE_TYPE_SFT             0
+	#define ASYNC_EVENT_CMPL_PHC_UPDATE_TYPE_HWRM_ASYNC_EVENT  0x2eUL
+	#define ASYNC_EVENT_CMPL_PHC_UPDATE_TYPE_LAST             ASYNC_EVENT_CMPL_PHC_UPDATE_TYPE_HWRM_ASYNC_EVENT
+	__le16	event_id;
+	#define ASYNC_EVENT_CMPL_PHC_UPDATE_EVENT_ID_PHC_UPDATE 0x43UL
+	#define ASYNC_EVENT_CMPL_PHC_UPDATE_EVENT_ID_LAST      ASYNC_EVENT_CMPL_PHC_UPDATE_EVENT_ID_PHC_UPDATE
+	__le32	event_data2;
+	#define ASYNC_EVENT_CMPL_PHC_UPDATE_EVENT_DATA2_PHC_MASTER_FID_MASK 0xffffUL
+	#define ASYNC_EVENT_CMPL_PHC_UPDATE_EVENT_DATA2_PHC_MASTER_FID_SFT 0
+	#define ASYNC_EVENT_CMPL_PHC_UPDATE_EVENT_DATA2_PHC_SEC_FID_MASK   0xffff0000UL
+	#define ASYNC_EVENT_CMPL_PHC_UPDATE_EVENT_DATA2_PHC_SEC_FID_SFT    16
+	u8	opaque_v;
+	#define ASYNC_EVENT_CMPL_PHC_UPDATE_V          0x1UL
+	#define ASYNC_EVENT_CMPL_PHC_UPDATE_OPAQUE_MASK 0xfeUL
+	#define ASYNC_EVENT_CMPL_PHC_UPDATE_OPAQUE_SFT 1
+	u8	timestamp_lo;
+	__le16	timestamp_hi;
+	__le32	event_data1;
+	#define ASYNC_EVENT_CMPL_PHC_UPDATE_EVENT_DATA1_FLAGS_MASK          0xfUL
+	#define ASYNC_EVENT_CMPL_PHC_UPDATE_EVENT_DATA1_FLAGS_SFT           0
+	#define ASYNC_EVENT_CMPL_PHC_UPDATE_EVENT_DATA1_FLAGS_PHC_MASTER      0x1UL
+	#define ASYNC_EVENT_CMPL_PHC_UPDATE_EVENT_DATA1_FLAGS_PHC_SECONDARY   0x2UL
+	#define ASYNC_EVENT_CMPL_PHC_UPDATE_EVENT_DATA1_FLAGS_PHC_FAILOVER    0x3UL
+	#define ASYNC_EVENT_CMPL_PHC_UPDATE_EVENT_DATA1_FLAGS_PHC_RTC_UPDATE  0x4UL
+	#define ASYNC_EVENT_CMPL_PHC_UPDATE_EVENT_DATA1_FLAGS_LAST           ASYNC_EVENT_CMPL_PHC_UPDATE_EVENT_DATA1_FLAGS_PHC_RTC_UPDATE
+	#define ASYNC_EVENT_CMPL_PHC_UPDATE_EVENT_DATA1_PHC_TIME_MSB_MASK   0xffff0UL
+	#define ASYNC_EVENT_CMPL_PHC_UPDATE_EVENT_DATA1_PHC_TIME_MSB_SFT    4
+};
+
+/* hwrm_async_event_cmpl_pps_timestamp (size:128b/16B) */
+struct hwrm_async_event_cmpl_pps_timestamp {
+	__le16	type;
+	#define ASYNC_EVENT_CMPL_PPS_TIMESTAMP_TYPE_MASK            0x3fUL
+	#define ASYNC_EVENT_CMPL_PPS_TIMESTAMP_TYPE_SFT             0
+	#define ASYNC_EVENT_CMPL_PPS_TIMESTAMP_TYPE_HWRM_ASYNC_EVENT  0x2eUL
+	#define ASYNC_EVENT_CMPL_PPS_TIMESTAMP_TYPE_LAST             ASYNC_EVENT_CMPL_PPS_TIMESTAMP_TYPE_HWRM_ASYNC_EVENT
+	__le16	event_id;
+	#define ASYNC_EVENT_CMPL_PPS_TIMESTAMP_EVENT_ID_PPS_TIMESTAMP 0x44UL
+	#define ASYNC_EVENT_CMPL_PPS_TIMESTAMP_EVENT_ID_LAST         ASYNC_EVENT_CMPL_PPS_TIMESTAMP_EVENT_ID_PPS_TIMESTAMP
+	__le32	event_data2;
+	#define ASYNC_EVENT_CMPL_PPS_TIMESTAMP_EVENT_DATA2_EVENT_TYPE              0x1UL
+	#define ASYNC_EVENT_CMPL_PPS_TIMESTAMP_EVENT_DATA2_EVENT_TYPE_INTERNAL       0x0UL
+	#define ASYNC_EVENT_CMPL_PPS_TIMESTAMP_EVENT_DATA2_EVENT_TYPE_EXTERNAL       0x1UL
+	#define ASYNC_EVENT_CMPL_PPS_TIMESTAMP_EVENT_DATA2_EVENT_TYPE_LAST          ASYNC_EVENT_CMPL_PPS_TIMESTAMP_EVENT_DATA2_EVENT_TYPE_EXTERNAL
+	#define ASYNC_EVENT_CMPL_PPS_TIMESTAMP_EVENT_DATA2_PIN_NUMBER_MASK         0xeUL
+	#define ASYNC_EVENT_CMPL_PPS_TIMESTAMP_EVENT_DATA2_PIN_NUMBER_SFT          1
+	#define ASYNC_EVENT_CMPL_PPS_TIMESTAMP_EVENT_DATA2_PPS_TIMESTAMP_UPPER_MASK 0xffff0UL
+	#define ASYNC_EVENT_CMPL_PPS_TIMESTAMP_EVENT_DATA2_PPS_TIMESTAMP_UPPER_SFT 4
+	u8	opaque_v;
+	#define ASYNC_EVENT_CMPL_PPS_TIMESTAMP_V          0x1UL
+	#define ASYNC_EVENT_CMPL_PPS_TIMESTAMP_OPAQUE_MASK 0xfeUL
+	#define ASYNC_EVENT_CMPL_PPS_TIMESTAMP_OPAQUE_SFT 1
+	u8	timestamp_lo;
+	__le16	timestamp_hi;
+	__le32	event_data1;
+	#define ASYNC_EVENT_CMPL_PPS_TIMESTAMP_EVENT_DATA1_PPS_TIMESTAMP_LOWER_MASK 0xffffffffUL
+	#define ASYNC_EVENT_CMPL_PPS_TIMESTAMP_EVENT_DATA1_PPS_TIMESTAMP_LOWER_SFT 0
+};
+
+/* hwrm_async_event_cmpl_error_report (size:128b/16B) */
+struct hwrm_async_event_cmpl_error_report {
+	__le16	type;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_TYPE_MASK            0x3fUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_TYPE_SFT             0
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_TYPE_HWRM_ASYNC_EVENT  0x2eUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_TYPE_LAST             ASYNC_EVENT_CMPL_ERROR_REPORT_TYPE_HWRM_ASYNC_EVENT
+	__le16	event_id;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_EVENT_ID_ERROR_REPORT 0x45UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_EVENT_ID_LAST        ASYNC_EVENT_CMPL_ERROR_REPORT_EVENT_ID_ERROR_REPORT
+	__le32	event_data2;
+	u8	opaque_v;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_V          0x1UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_OPAQUE_MASK 0xfeUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_OPAQUE_SFT 1
+	u8	timestamp_lo;
+	__le16	timestamp_hi;
+	__le32	event_data1;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_EVENT_DATA1_ERROR_TYPE_MASK 0xffUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_EVENT_DATA1_ERROR_TYPE_SFT 0
+};
+
+/* hwrm_async_event_cmpl_dbg_buf_producer (size:128b/16B) */
+struct hwrm_async_event_cmpl_dbg_buf_producer {
+	__le16	type;
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_TYPE_MASK            0x3fUL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_TYPE_SFT             0
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_TYPE_HWRM_ASYNC_EVENT  0x2eUL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_TYPE_LAST             ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_TYPE_HWRM_ASYNC_EVENT
+	__le16	event_id;
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_ID_DBG_BUF_PRODUCER 0x4cUL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_ID_LAST            ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_ID_DBG_BUF_PRODUCER
+	__le32	event_data2;
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA2_CURR_OFF_MASK 0xffffffffUL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA2_CURR_OFF_SFT 0
+	u8	opaque_v;
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_V          0x1UL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_OPAQUE_MASK 0xfeUL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_OPAQUE_SFT 1
+	u8	timestamp_lo;
+	__le16	timestamp_hi;
+	__le32	event_data1;
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_MASK               0xffffUL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_SFT                0
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_SRT_TRACE            0x0UL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_SRT2_TRACE           0x1UL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_CRT_TRACE            0x2UL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_CRT2_TRACE           0x3UL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_RIGP0_TRACE          0x4UL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_L2_HWRM_TRACE        0x5UL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_ROCE_HWRM_TRACE      0x6UL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_CA0_TRACE            0x7UL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_CA1_TRACE            0x8UL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_CA2_TRACE            0x9UL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_RIGP1_TRACE          0xaUL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_AFM_KONG_HWRM_TRACE  0xbUL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_ERR_QPC_TRACE        0xcUL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_MPRT_TRACE           0xdUL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_RERT_TRACE           0xeUL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_MPC_MSG_TRACE        0xfUL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_MPC_CMPL_TRACE       0x10UL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_LAST                ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_MPC_CMPL_TRACE
+};
+
+/* hwrm_async_event_cmpl_hwrm_error (size:128b/16B) */
+struct hwrm_async_event_cmpl_hwrm_error {
+	__le16	type;
+	#define ASYNC_EVENT_CMPL_HWRM_ERROR_TYPE_MASK            0x3fUL
+	#define ASYNC_EVENT_CMPL_HWRM_ERROR_TYPE_SFT             0
+	#define ASYNC_EVENT_CMPL_HWRM_ERROR_TYPE_HWRM_ASYNC_EVENT  0x2eUL
+	#define ASYNC_EVENT_CMPL_HWRM_ERROR_TYPE_LAST             ASYNC_EVENT_CMPL_HWRM_ERROR_TYPE_HWRM_ASYNC_EVENT
+	__le16	event_id;
+	#define ASYNC_EVENT_CMPL_HWRM_ERROR_EVENT_ID_HWRM_ERROR 0xffUL
+	#define ASYNC_EVENT_CMPL_HWRM_ERROR_EVENT_ID_LAST      ASYNC_EVENT_CMPL_HWRM_ERROR_EVENT_ID_HWRM_ERROR
+	__le32	event_data2;
+	#define ASYNC_EVENT_CMPL_HWRM_ERROR_EVENT_DATA2_SEVERITY_MASK    0xffUL
+	#define ASYNC_EVENT_CMPL_HWRM_ERROR_EVENT_DATA2_SEVERITY_SFT     0
+	#define ASYNC_EVENT_CMPL_HWRM_ERROR_EVENT_DATA2_SEVERITY_WARNING   0x0UL
+	#define ASYNC_EVENT_CMPL_HWRM_ERROR_EVENT_DATA2_SEVERITY_NONFATAL  0x1UL
+	#define ASYNC_EVENT_CMPL_HWRM_ERROR_EVENT_DATA2_SEVERITY_FATAL     0x2UL
+	#define ASYNC_EVENT_CMPL_HWRM_ERROR_EVENT_DATA2_SEVERITY_LAST     ASYNC_EVENT_CMPL_HWRM_ERROR_EVENT_DATA2_SEVERITY_FATAL
+	u8	opaque_v;
+	#define ASYNC_EVENT_CMPL_HWRM_ERROR_V          0x1UL
+	#define ASYNC_EVENT_CMPL_HWRM_ERROR_OPAQUE_MASK 0xfeUL
+	#define ASYNC_EVENT_CMPL_HWRM_ERROR_OPAQUE_SFT 1
+	u8	timestamp_lo;
+	__le16	timestamp_hi;
+	__le32	event_data1;
+	#define ASYNC_EVENT_CMPL_HWRM_ERROR_EVENT_DATA1_TIMESTAMP     0x1UL
+};
+
+/* hwrm_async_event_cmpl_error_report_base (size:128b/16B) */
+struct hwrm_async_event_cmpl_error_report_base {
+	__le16	type;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_TYPE_MASK            0x3fUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_TYPE_SFT             0
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_TYPE_HWRM_ASYNC_EVENT  0x2eUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_TYPE_LAST             ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_TYPE_HWRM_ASYNC_EVENT
+	__le16	event_id;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_ID_ERROR_REPORT 0x45UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_ID_LAST        ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_ID_ERROR_REPORT
+	__le32	event_data2;
+	u8	opaque_v;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_V          0x1UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_OPAQUE_MASK 0xfeUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_OPAQUE_SFT 1
+	u8	timestamp_lo;
+	__le16	timestamp_hi;
+	__le32	event_data1;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_MASK                        0xffUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_SFT                         0
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_RESERVED                      0x0UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_PAUSE_STORM                   0x1UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_INVALID_SIGNAL                0x2UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_NVM                           0x3UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_DOORBELL_DROP_THRESHOLD       0x4UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_THERMAL_THRESHOLD             0x5UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_DUAL_DATA_RATE_NOT_SUPPORTED  0x6UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_DUP_UDCC_SES                  0x7UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_DB_DROP                       0x8UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_MD_TEMP                       0x9UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_VNIC_ERR                      0xaUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_LAST                         ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_VNIC_ERR
+};
+
+/* hwrm_async_event_cmpl_error_report_pause_storm (size:128b/16B) */
+struct hwrm_async_event_cmpl_error_report_pause_storm {
+	__le16	type;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_PAUSE_STORM_TYPE_MASK            0x3fUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_PAUSE_STORM_TYPE_SFT             0
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_PAUSE_STORM_TYPE_HWRM_ASYNC_EVENT  0x2eUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_PAUSE_STORM_TYPE_LAST             ASYNC_EVENT_CMPL_ERROR_REPORT_PAUSE_STORM_TYPE_HWRM_ASYNC_EVENT
+	__le16	event_id;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_PAUSE_STORM_EVENT_ID_ERROR_REPORT 0x45UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_PAUSE_STORM_EVENT_ID_LAST        ASYNC_EVENT_CMPL_ERROR_REPORT_PAUSE_STORM_EVENT_ID_ERROR_REPORT
+	__le32	event_data2;
+	u8	opaque_v;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_PAUSE_STORM_V          0x1UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_PAUSE_STORM_OPAQUE_MASK 0xfeUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_PAUSE_STORM_OPAQUE_SFT 1
+	u8	timestamp_lo;
+	__le16	timestamp_hi;
+	__le32	event_data1;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_PAUSE_STORM_EVENT_DATA1_ERROR_TYPE_MASK       0xffUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_PAUSE_STORM_EVENT_DATA1_ERROR_TYPE_SFT        0
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_PAUSE_STORM_EVENT_DATA1_ERROR_TYPE_PAUSE_STORM  0x1UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_PAUSE_STORM_EVENT_DATA1_ERROR_TYPE_LAST        ASYNC_EVENT_CMPL_ERROR_REPORT_PAUSE_STORM_EVENT_DATA1_ERROR_TYPE_PAUSE_STORM
+};
+
+/* hwrm_async_event_cmpl_error_report_invalid_signal (size:128b/16B) */
+struct hwrm_async_event_cmpl_error_report_invalid_signal {
+	__le16	type;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_INVALID_SIGNAL_TYPE_MASK            0x3fUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_INVALID_SIGNAL_TYPE_SFT             0
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_INVALID_SIGNAL_TYPE_HWRM_ASYNC_EVENT  0x2eUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_INVALID_SIGNAL_TYPE_LAST             ASYNC_EVENT_CMPL_ERROR_REPORT_INVALID_SIGNAL_TYPE_HWRM_ASYNC_EVENT
+	__le16	event_id;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_INVALID_SIGNAL_EVENT_ID_ERROR_REPORT 0x45UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_INVALID_SIGNAL_EVENT_ID_LAST        ASYNC_EVENT_CMPL_ERROR_REPORT_INVALID_SIGNAL_EVENT_ID_ERROR_REPORT
+	__le32	event_data2;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_INVALID_SIGNAL_EVENT_DATA2_PIN_ID_MASK 0xffUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_INVALID_SIGNAL_EVENT_DATA2_PIN_ID_SFT 0
+	u8	opaque_v;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_INVALID_SIGNAL_V          0x1UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_INVALID_SIGNAL_OPAQUE_MASK 0xfeUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_INVALID_SIGNAL_OPAQUE_SFT 1
+	u8	timestamp_lo;
+	__le16	timestamp_hi;
+	__le32	event_data1;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_INVALID_SIGNAL_EVENT_DATA1_ERROR_TYPE_MASK          0xffUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_INVALID_SIGNAL_EVENT_DATA1_ERROR_TYPE_SFT           0
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_INVALID_SIGNAL_EVENT_DATA1_ERROR_TYPE_INVALID_SIGNAL  0x2UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_INVALID_SIGNAL_EVENT_DATA1_ERROR_TYPE_LAST           ASYNC_EVENT_CMPL_ERROR_REPORT_INVALID_SIGNAL_EVENT_DATA1_ERROR_TYPE_INVALID_SIGNAL
+};
+
+/* hwrm_async_event_cmpl_error_report_nvm (size:128b/16B) */
+struct hwrm_async_event_cmpl_error_report_nvm {
+	__le16	type;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_NVM_TYPE_MASK            0x3fUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_NVM_TYPE_SFT             0
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_NVM_TYPE_HWRM_ASYNC_EVENT  0x2eUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_NVM_TYPE_LAST             ASYNC_EVENT_CMPL_ERROR_REPORT_NVM_TYPE_HWRM_ASYNC_EVENT
+	__le16	event_id;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_NVM_EVENT_ID_ERROR_REPORT 0x45UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_NVM_EVENT_ID_LAST        ASYNC_EVENT_CMPL_ERROR_REPORT_NVM_EVENT_ID_ERROR_REPORT
+	__le32	event_data2;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_NVM_EVENT_DATA2_ERR_ADDR_MASK 0xffffffffUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_NVM_EVENT_DATA2_ERR_ADDR_SFT 0
+	u8	opaque_v;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_NVM_V          0x1UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_NVM_OPAQUE_MASK 0xfeUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_NVM_OPAQUE_SFT 1
+	u8	timestamp_lo;
+	__le16	timestamp_hi;
+	__le32	event_data1;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_NVM_EVENT_DATA1_ERROR_TYPE_MASK     0xffUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_NVM_EVENT_DATA1_ERROR_TYPE_SFT      0
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_NVM_EVENT_DATA1_ERROR_TYPE_NVM_ERROR  0x3UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_NVM_EVENT_DATA1_ERROR_TYPE_LAST      ASYNC_EVENT_CMPL_ERROR_REPORT_NVM_EVENT_DATA1_ERROR_TYPE_NVM_ERROR
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_NVM_EVENT_DATA1_NVM_ERR_TYPE_MASK   0xff00UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_NVM_EVENT_DATA1_NVM_ERR_TYPE_SFT    8
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_NVM_EVENT_DATA1_NVM_ERR_TYPE_WRITE    (0x1UL << 8)
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_NVM_EVENT_DATA1_NVM_ERR_TYPE_ERASE    (0x2UL << 8)
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_NVM_EVENT_DATA1_NVM_ERR_TYPE_LAST    ASYNC_EVENT_CMPL_ERROR_REPORT_NVM_EVENT_DATA1_NVM_ERR_TYPE_ERASE
+};
+
+/* hwrm_async_event_cmpl_error_report_doorbell_drop_threshold (size:128b/16B) */
+struct hwrm_async_event_cmpl_error_report_doorbell_drop_threshold {
+	__le16	type;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DOORBELL_DROP_THRESHOLD_TYPE_MASK            0x3fUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DOORBELL_DROP_THRESHOLD_TYPE_SFT             0
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DOORBELL_DROP_THRESHOLD_TYPE_HWRM_ASYNC_EVENT  0x2eUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DOORBELL_DROP_THRESHOLD_TYPE_LAST             ASYNC_EVENT_CMPL_ERROR_REPORT_DOORBELL_DROP_THRESHOLD_TYPE_HWRM_ASYNC_EVENT
+	__le16	event_id;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DOORBELL_DROP_THRESHOLD_EVENT_ID_ERROR_REPORT 0x45UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DOORBELL_DROP_THRESHOLD_EVENT_ID_LAST        ASYNC_EVENT_CMPL_ERROR_REPORT_DOORBELL_DROP_THRESHOLD_EVENT_ID_ERROR_REPORT
+	__le32	event_data2;
+	u8	opaque_v;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DOORBELL_DROP_THRESHOLD_V          0x1UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DOORBELL_DROP_THRESHOLD_OPAQUE_MASK 0xfeUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DOORBELL_DROP_THRESHOLD_OPAQUE_SFT 1
+	u8	timestamp_lo;
+	__le16	timestamp_hi;
+	__le32	event_data1;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DOORBELL_DROP_THRESHOLD_EVENT_DATA1_ERROR_TYPE_MASK                   0xffUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DOORBELL_DROP_THRESHOLD_EVENT_DATA1_ERROR_TYPE_SFT                    0
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DOORBELL_DROP_THRESHOLD_EVENT_DATA1_ERROR_TYPE_DOORBELL_DROP_THRESHOLD  0x4UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DOORBELL_DROP_THRESHOLD_EVENT_DATA1_ERROR_TYPE_LAST                    ASYNC_EVENT_CMPL_ERROR_REPORT_DOORBELL_DROP_THRESHOLD_EVENT_DATA1_ERROR_TYPE_DOORBELL_DROP_THRESHOLD
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DOORBELL_DROP_THRESHOLD_EVENT_DATA1_EPOCH_MASK                        0xffffff00UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DOORBELL_DROP_THRESHOLD_EVENT_DATA1_EPOCH_SFT                         8
+};
+
+/* hwrm_async_event_cmpl_error_report_thermal (size:128b/16B) */
+struct hwrm_async_event_cmpl_error_report_thermal {
+	__le16	type;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_TYPE_MASK            0x3fUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_TYPE_SFT             0
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_TYPE_HWRM_ASYNC_EVENT  0x2eUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_TYPE_LAST             ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_TYPE_HWRM_ASYNC_EVENT
+	__le16	event_id;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_ID_ERROR_REPORT 0x45UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_ID_LAST        ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_ID_ERROR_REPORT
+	__le32	event_data2;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA2_CURRENT_TEMP_MASK  0xffUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA2_CURRENT_TEMP_SFT   0
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA2_THRESHOLD_TEMP_MASK 0xff00UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA2_THRESHOLD_TEMP_SFT 8
+	u8	opaque_v;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_V          0x1UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_OPAQUE_MASK 0xfeUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_OPAQUE_SFT 1
+	u8	timestamp_lo;
+	__le16	timestamp_hi;
+	__le32	event_data1;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_ERROR_TYPE_MASK          0xffUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_ERROR_TYPE_SFT           0
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_ERROR_TYPE_THERMAL_EVENT   0x5UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_ERROR_TYPE_LAST           ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_ERROR_TYPE_THERMAL_EVENT
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_THRESHOLD_TYPE_MASK      0x700UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_THRESHOLD_TYPE_SFT       8
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_THRESHOLD_TYPE_WARN        (0x0UL << 8)
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_THRESHOLD_TYPE_CRITICAL    (0x1UL << 8)
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_THRESHOLD_TYPE_FATAL       (0x2UL << 8)
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_THRESHOLD_TYPE_SHUTDOWN    (0x3UL << 8)
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_THRESHOLD_TYPE_LAST       ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_THRESHOLD_TYPE_SHUTDOWN
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_TRANSITION_DIR           0x800UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_TRANSITION_DIR_DECREASING  (0x0UL << 11)
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_TRANSITION_DIR_INCREASING  (0x1UL << 11)
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_TRANSITION_DIR_LAST       ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_TRANSITION_DIR_INCREASING
+};
+
+/* hwrm_async_event_cmpl_error_report_dual_data_rate_not_supported (size:128b/16B) */
+struct hwrm_async_event_cmpl_error_report_dual_data_rate_not_supported {
+	__le16	type;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DUAL_DATA_RATE_NOT_SUPPORTED_TYPE_MASK            0x3fUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DUAL_DATA_RATE_NOT_SUPPORTED_TYPE_SFT             0
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DUAL_DATA_RATE_NOT_SUPPORTED_TYPE_HWRM_ASYNC_EVENT  0x2eUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DUAL_DATA_RATE_NOT_SUPPORTED_TYPE_LAST             ASYNC_EVENT_CMPL_ERROR_REPORT_DUAL_DATA_RATE_NOT_SUPPORTED_TYPE_HWRM_ASYNC_EVENT
+	__le16	event_id;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DUAL_DATA_RATE_NOT_SUPPORTED_EVENT_ID_ERROR_REPORT 0x45UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DUAL_DATA_RATE_NOT_SUPPORTED_EVENT_ID_LAST        ASYNC_EVENT_CMPL_ERROR_REPORT_DUAL_DATA_RATE_NOT_SUPPORTED_EVENT_ID_ERROR_REPORT
+	__le32	event_data2;
+	u8	opaque_v;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DUAL_DATA_RATE_NOT_SUPPORTED_V          0x1UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DUAL_DATA_RATE_NOT_SUPPORTED_OPAQUE_MASK 0xfeUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DUAL_DATA_RATE_NOT_SUPPORTED_OPAQUE_SFT 1
+	u8	timestamp_lo;
+	__le16	timestamp_hi;
+	__le32	event_data1;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DUAL_DATA_RATE_NOT_SUPPORTED_EVENT_DATA1_ERROR_TYPE_MASK                        0xffUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DUAL_DATA_RATE_NOT_SUPPORTED_EVENT_DATA1_ERROR_TYPE_SFT                         0
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DUAL_DATA_RATE_NOT_SUPPORTED_EVENT_DATA1_ERROR_TYPE_DUAL_DATA_RATE_NOT_SUPPORTED  0x6UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DUAL_DATA_RATE_NOT_SUPPORTED_EVENT_DATA1_ERROR_TYPE_LAST                         ASYNC_EVENT_CMPL_ERROR_REPORT_DUAL_DATA_RATE_NOT_SUPPORTED_EVENT_DATA1_ERROR_TYPE_DUAL_DATA_RATE_NOT_SUPPORTED
+};
+
+/* hwrm_func_reset_input (size:192b/24B) */
+struct hwrm_func_reset_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	enables;
+	#define FUNC_RESET_REQ_ENABLES_VF_ID_VALID     0x1UL
+	__le16	vf_id;
+	u8	func_reset_level;
+	#define FUNC_RESET_REQ_FUNC_RESET_LEVEL_RESETALL      0x0UL
+	#define FUNC_RESET_REQ_FUNC_RESET_LEVEL_RESETME       0x1UL
+	#define FUNC_RESET_REQ_FUNC_RESET_LEVEL_RESETCHILDREN 0x2UL
+	#define FUNC_RESET_REQ_FUNC_RESET_LEVEL_RESETVF       0x3UL
+	#define FUNC_RESET_REQ_FUNC_RESET_LEVEL_LAST         FUNC_RESET_REQ_FUNC_RESET_LEVEL_RESETVF
+	u8	unused_0;
+};
+
+/* hwrm_func_reset_output (size:128b/16B) */
+struct hwrm_func_reset_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_func_getfid_input (size:192b/24B) */
+struct hwrm_func_getfid_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	enables;
+	#define FUNC_GETFID_REQ_ENABLES_PCI_ID     0x1UL
+	__le16	pci_id;
+	u8	unused_0[2];
+};
+
+/* hwrm_func_getfid_output (size:128b/16B) */
+struct hwrm_func_getfid_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	fid;
+	u8	unused_0[5];
+	u8	valid;
+};
+
+/* hwrm_func_vf_alloc_input (size:192b/24B) */
+struct hwrm_func_vf_alloc_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	enables;
+	#define FUNC_VF_ALLOC_REQ_ENABLES_FIRST_VF_ID     0x1UL
+	__le16	first_vf_id;
+	__le16	num_vfs;
+};
+
+/* hwrm_func_vf_alloc_output (size:128b/16B) */
+struct hwrm_func_vf_alloc_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	first_vf_id;
+	u8	unused_0[5];
+	u8	valid;
+};
+
+/* hwrm_func_vf_free_input (size:192b/24B) */
+struct hwrm_func_vf_free_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	enables;
+	#define FUNC_VF_FREE_REQ_ENABLES_FIRST_VF_ID     0x1UL
+	__le16	first_vf_id;
+	__le16	num_vfs;
+};
+
+/* hwrm_func_vf_free_output (size:128b/16B) */
+struct hwrm_func_vf_free_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_func_vf_cfg_input (size:576b/72B) */
+struct hwrm_func_vf_cfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	enables;
+	#define FUNC_VF_CFG_REQ_ENABLES_MTU                      0x1UL
+	#define FUNC_VF_CFG_REQ_ENABLES_GUEST_VLAN               0x2UL
+	#define FUNC_VF_CFG_REQ_ENABLES_ASYNC_EVENT_CR           0x4UL
+	#define FUNC_VF_CFG_REQ_ENABLES_DFLT_MAC_ADDR            0x8UL
+	#define FUNC_VF_CFG_REQ_ENABLES_NUM_RSSCOS_CTXS          0x10UL
+	#define FUNC_VF_CFG_REQ_ENABLES_NUM_CMPL_RINGS           0x20UL
+	#define FUNC_VF_CFG_REQ_ENABLES_NUM_TX_RINGS             0x40UL
+	#define FUNC_VF_CFG_REQ_ENABLES_NUM_RX_RINGS             0x80UL
+	#define FUNC_VF_CFG_REQ_ENABLES_NUM_L2_CTXS              0x100UL
+	#define FUNC_VF_CFG_REQ_ENABLES_NUM_VNICS                0x200UL
+	#define FUNC_VF_CFG_REQ_ENABLES_NUM_STAT_CTXS            0x400UL
+	#define FUNC_VF_CFG_REQ_ENABLES_NUM_HW_RING_GRPS         0x800UL
+	#define FUNC_VF_CFG_REQ_ENABLES_NUM_KTLS_TX_KEY_CTXS     0x1000UL
+	#define FUNC_VF_CFG_REQ_ENABLES_NUM_KTLS_RX_KEY_CTXS     0x2000UL
+	#define FUNC_VF_CFG_REQ_ENABLES_NUM_QUIC_TX_KEY_CTXS     0x4000UL
+	#define FUNC_VF_CFG_REQ_ENABLES_NUM_QUIC_RX_KEY_CTXS     0x8000UL
+	__le16	mtu;
+	__le16	guest_vlan;
+	__le16	async_event_cr;
+	u8	dflt_mac_addr[6];
+	__le32	flags;
+	#define FUNC_VF_CFG_REQ_FLAGS_TX_ASSETS_TEST             0x1UL
+	#define FUNC_VF_CFG_REQ_FLAGS_RX_ASSETS_TEST             0x2UL
+	#define FUNC_VF_CFG_REQ_FLAGS_CMPL_ASSETS_TEST           0x4UL
+	#define FUNC_VF_CFG_REQ_FLAGS_RSSCOS_CTX_ASSETS_TEST     0x8UL
+	#define FUNC_VF_CFG_REQ_FLAGS_RING_GRP_ASSETS_TEST       0x10UL
+	#define FUNC_VF_CFG_REQ_FLAGS_STAT_CTX_ASSETS_TEST       0x20UL
+	#define FUNC_VF_CFG_REQ_FLAGS_VNIC_ASSETS_TEST           0x40UL
+	#define FUNC_VF_CFG_REQ_FLAGS_L2_CTX_ASSETS_TEST         0x80UL
+	#define FUNC_VF_CFG_REQ_FLAGS_PPP_PUSH_MODE_ENABLE       0x100UL
+	#define FUNC_VF_CFG_REQ_FLAGS_PPP_PUSH_MODE_DISABLE      0x200UL
+	__le16	num_rsscos_ctxs;
+	__le16	num_cmpl_rings;
+	__le16	num_tx_rings;
+	__le16	num_rx_rings;
+	__le16	num_l2_ctxs;
+	__le16	num_vnics;
+	__le16	num_stat_ctxs;
+	__le16	num_hw_ring_grps;
+	__le32	num_ktls_tx_key_ctxs;
+	__le32	num_ktls_rx_key_ctxs;
+	__le16	num_msix;
+	u8	unused[2];
+	__le32	num_quic_tx_key_ctxs;
+	__le32	num_quic_rx_key_ctxs;
+};
+
+/* hwrm_func_vf_cfg_output (size:128b/16B) */
+struct hwrm_func_vf_cfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_func_qcaps_input (size:192b/24B) */
+struct hwrm_func_qcaps_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	fid;
+	u8	unused_0[6];
+};
+
+/* hwrm_func_qcaps_output (size:1152b/144B) */
+struct hwrm_func_qcaps_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	fid;
+	__le16	port_id;
+	__le32	flags;
+	#define FUNC_QCAPS_RESP_FLAGS_PUSH_MODE_SUPPORTED                   0x1UL
+	#define FUNC_QCAPS_RESP_FLAGS_GLOBAL_MSIX_AUTOMASKING               0x2UL
+	#define FUNC_QCAPS_RESP_FLAGS_PTP_SUPPORTED                         0x4UL
+	#define FUNC_QCAPS_RESP_FLAGS_ROCE_V1_SUPPORTED                     0x8UL
+	#define FUNC_QCAPS_RESP_FLAGS_ROCE_V2_SUPPORTED                     0x10UL
+	#define FUNC_QCAPS_RESP_FLAGS_WOL_MAGICPKT_SUPPORTED                0x20UL
+	#define FUNC_QCAPS_RESP_FLAGS_WOL_BMP_SUPPORTED                     0x40UL
+	#define FUNC_QCAPS_RESP_FLAGS_TX_RING_RL_SUPPORTED                  0x80UL
+	#define FUNC_QCAPS_RESP_FLAGS_TX_BW_CFG_SUPPORTED                   0x100UL
+	#define FUNC_QCAPS_RESP_FLAGS_VF_TX_RING_RL_SUPPORTED               0x200UL
+	#define FUNC_QCAPS_RESP_FLAGS_VF_BW_CFG_SUPPORTED                   0x400UL
+	#define FUNC_QCAPS_RESP_FLAGS_STD_TX_RING_MODE_SUPPORTED            0x800UL
+	#define FUNC_QCAPS_RESP_FLAGS_GENEVE_TUN_FLAGS_SUPPORTED            0x1000UL
+	#define FUNC_QCAPS_RESP_FLAGS_NVGRE_TUN_FLAGS_SUPPORTED             0x2000UL
+	#define FUNC_QCAPS_RESP_FLAGS_GRE_TUN_FLAGS_SUPPORTED               0x4000UL
+	#define FUNC_QCAPS_RESP_FLAGS_MPLS_TUN_FLAGS_SUPPORTED              0x8000UL
+	#define FUNC_QCAPS_RESP_FLAGS_PCIE_STATS_SUPPORTED                  0x10000UL
+	#define FUNC_QCAPS_RESP_FLAGS_ADOPTED_PF_SUPPORTED                  0x20000UL
+	#define FUNC_QCAPS_RESP_FLAGS_ADMIN_PF_SUPPORTED                    0x40000UL
+	#define FUNC_QCAPS_RESP_FLAGS_LINK_ADMIN_STATUS_SUPPORTED           0x80000UL
+	#define FUNC_QCAPS_RESP_FLAGS_WCB_PUSH_MODE                         0x100000UL
+	#define FUNC_QCAPS_RESP_FLAGS_DYNAMIC_TX_RING_ALLOC                 0x200000UL
+	#define FUNC_QCAPS_RESP_FLAGS_HOT_RESET_CAPABLE                     0x400000UL
+	#define FUNC_QCAPS_RESP_FLAGS_ERROR_RECOVERY_CAPABLE                0x800000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT_STATS_SUPPORTED                   0x1000000UL
+	#define FUNC_QCAPS_RESP_FLAGS_ERR_RECOVER_RELOAD                    0x2000000UL
+	#define FUNC_QCAPS_RESP_FLAGS_NOTIFY_VF_DEF_VNIC_CHNG_SUPPORTED     0x4000000UL
+	#define FUNC_QCAPS_RESP_FLAGS_VLAN_ACCELERATION_TX_DISABLED         0x8000000UL
+	#define FUNC_QCAPS_RESP_FLAGS_COREDUMP_CMD_SUPPORTED                0x10000000UL
+	#define FUNC_QCAPS_RESP_FLAGS_CRASHDUMP_CMD_SUPPORTED               0x20000000UL
+	#define FUNC_QCAPS_RESP_FLAGS_PFC_WD_STATS_SUPPORTED                0x40000000UL
+	#define FUNC_QCAPS_RESP_FLAGS_DBG_QCAPS_CMD_SUPPORTED               0x80000000UL
+	u8	mac_address[6];
+	__le16	max_rsscos_ctx;
+	__le16	max_cmpl_rings;
+	__le16	max_tx_rings;
+	__le16	max_rx_rings;
+	__le16	max_l2_ctxs;
+	__le16	max_vnics;
+	__le16	first_vf_id;
+	__le16	max_vfs;
+	__le16	max_stat_ctx;
+	__le32	max_encap_records;
+	__le32	max_decap_records;
+	__le32	max_tx_em_flows;
+	__le32	max_tx_wm_flows;
+	__le32	max_rx_em_flows;
+	__le32	max_rx_wm_flows;
+	__le32	max_mcast_filters;
+	__le32	max_flow_id;
+	__le32	max_hw_ring_grps;
+	__le16	max_sp_tx_rings;
+	__le16	max_msix_vfs;
+	__le32	flags_ext;
+	#define FUNC_QCAPS_RESP_FLAGS_EXT_ECN_MARK_SUPPORTED                          0x1UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT_ECN_STATS_SUPPORTED                         0x2UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT_EXT_HW_STATS_SUPPORTED                      0x4UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT_HOT_RESET_IF_SUPPORT                        0x8UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT_PROXY_MODE_SUPPORT                          0x10UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT_TX_PROXY_SRC_INTF_OVERRIDE_SUPPORT          0x20UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT_SCHQ_SUPPORTED                              0x40UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT_PPP_PUSH_MODE_SUPPORTED                     0x80UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT_EVB_MODE_CFG_NOT_SUPPORTED                  0x100UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT_SOC_SPD_SUPPORTED                           0x200UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT_FW_LIVEPATCH_SUPPORTED                      0x400UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT_FAST_RESET_CAPABLE                          0x800UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT_TX_METADATA_CFG_CAPABLE                     0x1000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT_NVM_OPTION_ACTION_SUPPORTED                 0x2000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT_BD_METADATA_SUPPORTED                       0x4000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT_ECHO_REQUEST_SUPPORTED                      0x8000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT_NPAR_1_2_SUPPORTED                          0x10000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT_PTP_PTM_SUPPORTED                           0x20000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT_PTP_PPS_SUPPORTED                           0x40000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT_VF_CFG_ASYNC_FOR_PF_SUPPORTED               0x80000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT_PARTITION_BW_SUPPORTED                      0x100000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT_DFLT_VLAN_TPID_PCP_SUPPORTED                0x200000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT_KTLS_SUPPORTED                              0x400000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT_EP_RATE_CONTROL                             0x800000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT_MIN_BW_SUPPORTED                            0x1000000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT_TX_COAL_CMPL_CAP                            0x2000000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT_BS_V2_SUPPORTED                             0x4000000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT_BS_V2_REQUIRED                              0x8000000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT_PTP_64BIT_RTC_SUPPORTED                     0x10000000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT_DBR_PACING_SUPPORTED                        0x20000000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT_HW_DBR_DROP_RECOV_SUPPORTED                 0x40000000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT_DISABLE_CQ_OVERFLOW_DETECTION_SUPPORTED     0x80000000UL
+	u8	max_schqs;
+	u8	mpc_chnls_cap;
+	#define FUNC_QCAPS_RESP_MPC_CHNLS_CAP_TCE         0x1UL
+	#define FUNC_QCAPS_RESP_MPC_CHNLS_CAP_RCE         0x2UL
+	#define FUNC_QCAPS_RESP_MPC_CHNLS_CAP_TE_CFA      0x4UL
+	#define FUNC_QCAPS_RESP_MPC_CHNLS_CAP_RE_CFA      0x8UL
+	#define FUNC_QCAPS_RESP_MPC_CHNLS_CAP_PRIMATE     0x10UL
+	__le16	max_key_ctxs_alloc;
+	__le32	flags_ext2;
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_RX_ALL_PKTS_TIMESTAMPS_SUPPORTED      0x1UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_QUIC_SUPPORTED                        0x2UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_KDNET_SUPPORTED                       0x4UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_DBR_PACING_EXT_SUPPORTED              0x8UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_SW_DBR_DROP_RECOVERY_SUPPORTED        0x10UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_GENERIC_STATS_SUPPORTED               0x20UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_UDP_GSO_SUPPORTED                     0x40UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_SYNCE_SUPPORTED                       0x80UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_DBR_PACING_V0_SUPPORTED               0x100UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_TX_PKT_TS_CMPL_SUPPORTED              0x200UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_HW_LAG_SUPPORTED                      0x400UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_ON_CHIP_CTX_SUPPORTED                 0x800UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_STEERING_TAG_SUPPORTED                0x1000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_ENHANCED_VF_SCALE_SUPPORTED           0x2000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_KEY_XID_PARTITION_SUPPORTED           0x4000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_CONCURRENT_KTLS_QUIC_SUPPORTED        0x8000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_SCHQ_CROSS_TC_CAP_SUPPORTED           0x10000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_SCHQ_PER_TC_CAP_SUPPORTED             0x20000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_SCHQ_PER_TC_RESERVATION_SUPPORTED     0x40000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_DB_ERROR_STATS_SUPPORTED              0x80000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_ROCE_VF_RESOURCE_MGMT_SUPPORTED       0x100000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_UDCC_SUPPORTED                        0x200000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_TIMED_TX_SO_TXTIME_SUPPORTED          0x400000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_SW_MAX_RESOURCE_LIMITS_SUPPORTED      0x800000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_TF_INGRESS_NIC_FLOW_SUPPORTED         0x1000000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_LPBK_STATS_SUPPORTED                  0x2000000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_TF_EGRESS_NIC_FLOW_SUPPORTED          0x4000000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_MULTI_LOSSLESS_QUEUES_SUPPORTED       0x8000000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_PEER_MMAP_SUPPORTED                   0x10000000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_TIMED_TX_PACING_SUPPORTED             0x20000000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_VF_STAT_EJECTION_SUPPORTED            0x40000000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_HOST_COREDUMP_SUPPORTED               0x80000000UL
+	__le16	tunnel_disable_flag;
+	#define FUNC_QCAPS_RESP_TUNNEL_DISABLE_FLAG_DISABLE_VXLAN      0x1UL
+	#define FUNC_QCAPS_RESP_TUNNEL_DISABLE_FLAG_DISABLE_NGE        0x2UL
+	#define FUNC_QCAPS_RESP_TUNNEL_DISABLE_FLAG_DISABLE_NVGRE      0x4UL
+	#define FUNC_QCAPS_RESP_TUNNEL_DISABLE_FLAG_DISABLE_L2GRE      0x8UL
+	#define FUNC_QCAPS_RESP_TUNNEL_DISABLE_FLAG_DISABLE_GRE        0x10UL
+	#define FUNC_QCAPS_RESP_TUNNEL_DISABLE_FLAG_DISABLE_IPINIP     0x20UL
+	#define FUNC_QCAPS_RESP_TUNNEL_DISABLE_FLAG_DISABLE_MPLS       0x40UL
+	#define FUNC_QCAPS_RESP_TUNNEL_DISABLE_FLAG_DISABLE_PPPOE      0x80UL
+	__le16	xid_partition_cap;
+	#define FUNC_QCAPS_RESP_XID_PARTITION_CAP_TX_CK     0x1UL
+	#define FUNC_QCAPS_RESP_XID_PARTITION_CAP_RX_CK     0x2UL
+	u8	device_serial_number[8];
+	__le16	ctxs_per_partition;
+	__le16	max_tso_segs;
+	__le32	roce_vf_max_av;
+	__le32	roce_vf_max_cq;
+	__le32	roce_vf_max_mrw;
+	__le32	roce_vf_max_qp;
+	__le32	roce_vf_max_srq;
+	__le32	roce_vf_max_gid;
+	__le32	flags_ext3;
+	#define FUNC_QCAPS_RESP_FLAGS_EXT3_RM_RSV_WHILE_ALLOC_CAP            0x1UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT3_REQUIRE_L2_FILTER                 0x2UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT3_MAX_ROCE_VFS_SUPPORTED            0x4UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT3_RX_RATE_PROFILE_SEL_SUPPORTED     0x8UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT3_BIDI_OPT_SUPPORTED                0x10UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT3_MIRROR_ON_ROCE_SUPPORTED          0x20UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT3_ROCE_VF_DYN_ALLOC_SUPPORT         0x40UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT3_CHANGE_UDP_SRCPORT_SUPPORT        0x80UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT3_PCIE_COMPLIANCE_SUPPORTED         0x100UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT3_MULTI_L2_DB_SUPPORTED             0x200UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT3_PCIE_SECURE_ATS_SUPPORTED         0x400UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT3_MBUF_DATA_SUPPORTED               0x800UL
+	__le16	max_roce_vfs;
+	__le16	max_crypto_rx_flow_filters;
+	u8	unused_3[3];
+	u8	valid;
+};
+
+/* hwrm_func_qcfg_input (size:192b/24B) */
+struct hwrm_func_qcfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	fid;
+	u8	unused_0[6];
+};
+
+/* hwrm_func_qcfg_output (size:1408b/176B) */
+struct hwrm_func_qcfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	fid;
+	__le16	port_id;
+	__le16	vlan;
+	__le16	flags;
+	#define FUNC_QCFG_RESP_FLAGS_OOB_WOL_MAGICPKT_ENABLED     0x1UL
+	#define FUNC_QCFG_RESP_FLAGS_OOB_WOL_BMP_ENABLED          0x2UL
+	#define FUNC_QCFG_RESP_FLAGS_FW_DCBX_AGENT_ENABLED        0x4UL
+	#define FUNC_QCFG_RESP_FLAGS_STD_TX_RING_MODE_ENABLED     0x8UL
+	#define FUNC_QCFG_RESP_FLAGS_FW_LLDP_AGENT_ENABLED        0x10UL
+	#define FUNC_QCFG_RESP_FLAGS_MULTI_HOST                   0x20UL
+	#define FUNC_QCFG_RESP_FLAGS_TRUSTED_VF                   0x40UL
+	#define FUNC_QCFG_RESP_FLAGS_SECURE_MODE_ENABLED          0x80UL
+	#define FUNC_QCFG_RESP_FLAGS_PREBOOT_LEGACY_L2_RINGS      0x100UL
+	#define FUNC_QCFG_RESP_FLAGS_HOT_RESET_ALLOWED            0x200UL
+	#define FUNC_QCFG_RESP_FLAGS_PPP_PUSH_MODE_ENABLED        0x400UL
+	#define FUNC_QCFG_RESP_FLAGS_RING_MONITOR_ENABLED         0x800UL
+	#define FUNC_QCFG_RESP_FLAGS_FAST_RESET_ALLOWED           0x1000UL
+	#define FUNC_QCFG_RESP_FLAGS_MULTI_ROOT                   0x2000UL
+	#define FUNC_QCFG_RESP_FLAGS_ENABLE_RDMA_SRIOV            0x4000UL
+	#define FUNC_QCFG_RESP_FLAGS_ROCE_VNIC_ID_VALID           0x8000UL
+	u8	mac_address[6];
+	__le16	pci_id;
+	__le16	alloc_rsscos_ctx;
+	__le16	alloc_cmpl_rings;
+	__le16	alloc_tx_rings;
+	__le16	alloc_rx_rings;
+	__le16	alloc_l2_ctx;
+	__le16	alloc_vnics;
+	__le16	admin_mtu;
+	__le16	mru;
+	__le16	stat_ctx_id;
+	u8	port_partition_type;
+	#define FUNC_QCFG_RESP_PORT_PARTITION_TYPE_SPF     0x0UL
+	#define FUNC_QCFG_RESP_PORT_PARTITION_TYPE_MPFS    0x1UL
+	#define FUNC_QCFG_RESP_PORT_PARTITION_TYPE_NPAR1_0 0x2UL
+	#define FUNC_QCFG_RESP_PORT_PARTITION_TYPE_NPAR1_5 0x3UL
+	#define FUNC_QCFG_RESP_PORT_PARTITION_TYPE_NPAR2_0 0x4UL
+	#define FUNC_QCFG_RESP_PORT_PARTITION_TYPE_NPAR1_2 0x5UL
+	#define FUNC_QCFG_RESP_PORT_PARTITION_TYPE_UNKNOWN 0xffUL
+	#define FUNC_QCFG_RESP_PORT_PARTITION_TYPE_LAST   FUNC_QCFG_RESP_PORT_PARTITION_TYPE_UNKNOWN
+	u8	port_pf_cnt;
+	#define FUNC_QCFG_RESP_PORT_PF_CNT_UNAVAIL 0x0UL
+	#define FUNC_QCFG_RESP_PORT_PF_CNT_LAST   FUNC_QCFG_RESP_PORT_PF_CNT_UNAVAIL
+	__le16	dflt_vnic_id;
+	__le16	max_mtu_configured;
+	__le32	min_bw;
+	#define FUNC_QCFG_RESP_MIN_BW_BW_VALUE_MASK             0xfffffffUL
+	#define FUNC_QCFG_RESP_MIN_BW_BW_VALUE_SFT              0
+	#define FUNC_QCFG_RESP_MIN_BW_SCALE                     0x10000000UL
+	#define FUNC_QCFG_RESP_MIN_BW_SCALE_BITS                  (0x0UL << 28)
+	#define FUNC_QCFG_RESP_MIN_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define FUNC_QCFG_RESP_MIN_BW_SCALE_LAST                 FUNC_QCFG_RESP_MIN_BW_SCALE_BYTES
+	#define FUNC_QCFG_RESP_MIN_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define FUNC_QCFG_RESP_MIN_BW_BW_VALUE_UNIT_SFT         29
+	#define FUNC_QCFG_RESP_MIN_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define FUNC_QCFG_RESP_MIN_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define FUNC_QCFG_RESP_MIN_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define FUNC_QCFG_RESP_MIN_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define FUNC_QCFG_RESP_MIN_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define FUNC_QCFG_RESP_MIN_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define FUNC_QCFG_RESP_MIN_BW_BW_VALUE_UNIT_LAST         FUNC_QCFG_RESP_MIN_BW_BW_VALUE_UNIT_INVALID
+	__le32	max_bw;
+	#define FUNC_QCFG_RESP_MAX_BW_BW_VALUE_MASK             0xfffffffUL
+	#define FUNC_QCFG_RESP_MAX_BW_BW_VALUE_SFT              0
+	#define FUNC_QCFG_RESP_MAX_BW_SCALE                     0x10000000UL
+	#define FUNC_QCFG_RESP_MAX_BW_SCALE_BITS                  (0x0UL << 28)
+	#define FUNC_QCFG_RESP_MAX_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define FUNC_QCFG_RESP_MAX_BW_SCALE_LAST                 FUNC_QCFG_RESP_MAX_BW_SCALE_BYTES
+	#define FUNC_QCFG_RESP_MAX_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define FUNC_QCFG_RESP_MAX_BW_BW_VALUE_UNIT_SFT         29
+	#define FUNC_QCFG_RESP_MAX_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define FUNC_QCFG_RESP_MAX_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define FUNC_QCFG_RESP_MAX_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define FUNC_QCFG_RESP_MAX_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define FUNC_QCFG_RESP_MAX_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define FUNC_QCFG_RESP_MAX_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define FUNC_QCFG_RESP_MAX_BW_BW_VALUE_UNIT_LAST         FUNC_QCFG_RESP_MAX_BW_BW_VALUE_UNIT_INVALID
+	u8	evb_mode;
+	#define FUNC_QCFG_RESP_EVB_MODE_NO_EVB 0x0UL
+	#define FUNC_QCFG_RESP_EVB_MODE_VEB    0x1UL
+	#define FUNC_QCFG_RESP_EVB_MODE_VEPA   0x2UL
+	#define FUNC_QCFG_RESP_EVB_MODE_LAST  FUNC_QCFG_RESP_EVB_MODE_VEPA
+	u8	options;
+	#define FUNC_QCFG_RESP_OPTIONS_CACHE_LINESIZE_MASK         0x3UL
+	#define FUNC_QCFG_RESP_OPTIONS_CACHE_LINESIZE_SFT          0
+	#define FUNC_QCFG_RESP_OPTIONS_CACHE_LINESIZE_SIZE_64        0x0UL
+	#define FUNC_QCFG_RESP_OPTIONS_CACHE_LINESIZE_SIZE_128       0x1UL
+	#define FUNC_QCFG_RESP_OPTIONS_CACHE_LINESIZE_LAST          FUNC_QCFG_RESP_OPTIONS_CACHE_LINESIZE_SIZE_128
+	#define FUNC_QCFG_RESP_OPTIONS_LINK_ADMIN_STATE_MASK       0xcUL
+	#define FUNC_QCFG_RESP_OPTIONS_LINK_ADMIN_STATE_SFT        2
+	#define FUNC_QCFG_RESP_OPTIONS_LINK_ADMIN_STATE_FORCED_DOWN  (0x0UL << 2)
+	#define FUNC_QCFG_RESP_OPTIONS_LINK_ADMIN_STATE_FORCED_UP    (0x1UL << 2)
+	#define FUNC_QCFG_RESP_OPTIONS_LINK_ADMIN_STATE_AUTO         (0x2UL << 2)
+	#define FUNC_QCFG_RESP_OPTIONS_LINK_ADMIN_STATE_LAST        FUNC_QCFG_RESP_OPTIONS_LINK_ADMIN_STATE_AUTO
+	#define FUNC_QCFG_RESP_OPTIONS_RSVD_MASK                   0xf0UL
+	#define FUNC_QCFG_RESP_OPTIONS_RSVD_SFT                    4
+	__le16	alloc_vfs;
+	__le32	alloc_mcast_filters;
+	__le32	alloc_hw_ring_grps;
+	__le16	alloc_sp_tx_rings;
+	__le16	alloc_stat_ctx;
+	__le16	alloc_msix;
+	__le16	registered_vfs;
+	__le16	l2_doorbell_bar_size_kb;
+	u8	active_endpoints;
+	u8	always_1;
+	__le32	reset_addr_poll;
+	__le16	legacy_l2_db_size_kb;
+	__le16	svif_info;
+	#define FUNC_QCFG_RESP_SVIF_INFO_SVIF_MASK      0x7fffUL
+	#define FUNC_QCFG_RESP_SVIF_INFO_SVIF_SFT       0
+	#define FUNC_QCFG_RESP_SVIF_INFO_SVIF_VALID     0x8000UL
+	u8	mpc_chnls;
+	#define FUNC_QCFG_RESP_MPC_CHNLS_TCE_ENABLED         0x1UL
+	#define FUNC_QCFG_RESP_MPC_CHNLS_RCE_ENABLED         0x2UL
+	#define FUNC_QCFG_RESP_MPC_CHNLS_TE_CFA_ENABLED      0x4UL
+	#define FUNC_QCFG_RESP_MPC_CHNLS_RE_CFA_ENABLED      0x8UL
+	#define FUNC_QCFG_RESP_MPC_CHNLS_PRIMATE_ENABLED     0x10UL
+	u8	db_page_size;
+	#define FUNC_QCFG_RESP_DB_PAGE_SIZE_4KB   0x0UL
+	#define FUNC_QCFG_RESP_DB_PAGE_SIZE_8KB   0x1UL
+	#define FUNC_QCFG_RESP_DB_PAGE_SIZE_16KB  0x2UL
+	#define FUNC_QCFG_RESP_DB_PAGE_SIZE_32KB  0x3UL
+	#define FUNC_QCFG_RESP_DB_PAGE_SIZE_64KB  0x4UL
+	#define FUNC_QCFG_RESP_DB_PAGE_SIZE_128KB 0x5UL
+	#define FUNC_QCFG_RESP_DB_PAGE_SIZE_256KB 0x6UL
+	#define FUNC_QCFG_RESP_DB_PAGE_SIZE_512KB 0x7UL
+	#define FUNC_QCFG_RESP_DB_PAGE_SIZE_1MB   0x8UL
+	#define FUNC_QCFG_RESP_DB_PAGE_SIZE_2MB   0x9UL
+	#define FUNC_QCFG_RESP_DB_PAGE_SIZE_4MB   0xaUL
+	#define FUNC_QCFG_RESP_DB_PAGE_SIZE_LAST FUNC_QCFG_RESP_DB_PAGE_SIZE_4MB
+	__le16	roce_vnic_id;
+	__le32	partition_min_bw;
+	#define FUNC_QCFG_RESP_PARTITION_MIN_BW_BW_VALUE_MASK             0xfffffffUL
+	#define FUNC_QCFG_RESP_PARTITION_MIN_BW_BW_VALUE_SFT              0
+	#define FUNC_QCFG_RESP_PARTITION_MIN_BW_SCALE                     0x10000000UL
+	#define FUNC_QCFG_RESP_PARTITION_MIN_BW_SCALE_BITS                  (0x0UL << 28)
+	#define FUNC_QCFG_RESP_PARTITION_MIN_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define FUNC_QCFG_RESP_PARTITION_MIN_BW_SCALE_LAST                 FUNC_QCFG_RESP_PARTITION_MIN_BW_SCALE_BYTES
+	#define FUNC_QCFG_RESP_PARTITION_MIN_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define FUNC_QCFG_RESP_PARTITION_MIN_BW_BW_VALUE_UNIT_SFT         29
+	#define FUNC_QCFG_RESP_PARTITION_MIN_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define FUNC_QCFG_RESP_PARTITION_MIN_BW_BW_VALUE_UNIT_LAST         FUNC_QCFG_RESP_PARTITION_MIN_BW_BW_VALUE_UNIT_PERCENT1_100
+	__le32	partition_max_bw;
+	#define FUNC_QCFG_RESP_PARTITION_MAX_BW_BW_VALUE_MASK             0xfffffffUL
+	#define FUNC_QCFG_RESP_PARTITION_MAX_BW_BW_VALUE_SFT              0
+	#define FUNC_QCFG_RESP_PARTITION_MAX_BW_SCALE                     0x10000000UL
+	#define FUNC_QCFG_RESP_PARTITION_MAX_BW_SCALE_BITS                  (0x0UL << 28)
+	#define FUNC_QCFG_RESP_PARTITION_MAX_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define FUNC_QCFG_RESP_PARTITION_MAX_BW_SCALE_LAST                 FUNC_QCFG_RESP_PARTITION_MAX_BW_SCALE_BYTES
+	#define FUNC_QCFG_RESP_PARTITION_MAX_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define FUNC_QCFG_RESP_PARTITION_MAX_BW_BW_VALUE_UNIT_SFT         29
+	#define FUNC_QCFG_RESP_PARTITION_MAX_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define FUNC_QCFG_RESP_PARTITION_MAX_BW_BW_VALUE_UNIT_LAST         FUNC_QCFG_RESP_PARTITION_MAX_BW_BW_VALUE_UNIT_PERCENT1_100
+	__le16	host_mtu;
+	__le16	flags2;
+	#define FUNC_QCFG_RESP_FLAGS2_SRIOV_DSCP_INSERT_ENABLED     0x1UL
+	__le16	stag_vid;
+	u8	port_kdnet_mode;
+	#define FUNC_QCFG_RESP_PORT_KDNET_MODE_DISABLED 0x0UL
+	#define FUNC_QCFG_RESP_PORT_KDNET_MODE_ENABLED  0x1UL
+	#define FUNC_QCFG_RESP_PORT_KDNET_MODE_LAST    FUNC_QCFG_RESP_PORT_KDNET_MODE_ENABLED
+	u8	kdnet_pcie_function;
+	__le16	port_kdnet_fid;
+	u8	unused_5;
+	u8	roce_bidi_opt_mode;
+	#define FUNC_QCFG_RESP_ROCE_BIDI_OPT_MODE_DISABLED      0x1UL
+	#define FUNC_QCFG_RESP_ROCE_BIDI_OPT_MODE_DEDICATED     0x2UL
+	#define FUNC_QCFG_RESP_ROCE_BIDI_OPT_MODE_SHARED        0x4UL
+	__le32	num_ktls_tx_key_ctxs;
+	__le32	num_ktls_rx_key_ctxs;
+	u8	lag_id;
+	u8	parif;
+	u8	fw_lag_id;
+	u8	unused_6;
+	__le32	num_quic_tx_key_ctxs;
+	__le32	num_quic_rx_key_ctxs;
+	__le32	roce_max_av_per_vf;
+	__le32	roce_max_cq_per_vf;
+	__le32	roce_max_mrw_per_vf;
+	__le32	roce_max_qp_per_vf;
+	__le32	roce_max_srq_per_vf;
+	__le32	roce_max_gid_per_vf;
+	__le16	xid_partition_cfg;
+	#define FUNC_QCFG_RESP_XID_PARTITION_CFG_TX_CK     0x1UL
+	#define FUNC_QCFG_RESP_XID_PARTITION_CFG_RX_CK     0x2UL
+	__le16	mirror_vnic_id;
+	u8	max_link_width;
+	#define FUNC_QCFG_RESP_MAX_LINK_WIDTH_UNKNOWN 0x0UL
+	#define FUNC_QCFG_RESP_MAX_LINK_WIDTH_X1      0x1UL
+	#define FUNC_QCFG_RESP_MAX_LINK_WIDTH_X2      0x2UL
+	#define FUNC_QCFG_RESP_MAX_LINK_WIDTH_X4      0x4UL
+	#define FUNC_QCFG_RESP_MAX_LINK_WIDTH_X8      0x8UL
+	#define FUNC_QCFG_RESP_MAX_LINK_WIDTH_X16     0x10UL
+	#define FUNC_QCFG_RESP_MAX_LINK_WIDTH_LAST   FUNC_QCFG_RESP_MAX_LINK_WIDTH_X16
+	u8	max_link_speed;
+	#define FUNC_QCFG_RESP_MAX_LINK_SPEED_UNKNOWN 0x0UL
+	#define FUNC_QCFG_RESP_MAX_LINK_SPEED_G1      0x1UL
+	#define FUNC_QCFG_RESP_MAX_LINK_SPEED_G2      0x2UL
+	#define FUNC_QCFG_RESP_MAX_LINK_SPEED_G3      0x3UL
+	#define FUNC_QCFG_RESP_MAX_LINK_SPEED_G4      0x4UL
+	#define FUNC_QCFG_RESP_MAX_LINK_SPEED_G5      0x5UL
+	#define FUNC_QCFG_RESP_MAX_LINK_SPEED_LAST   FUNC_QCFG_RESP_MAX_LINK_SPEED_G5
+	u8	negotiated_link_width;
+	#define FUNC_QCFG_RESP_NEGOTIATED_LINK_WIDTH_UNKNOWN 0x0UL
+	#define FUNC_QCFG_RESP_NEGOTIATED_LINK_WIDTH_X1      0x1UL
+	#define FUNC_QCFG_RESP_NEGOTIATED_LINK_WIDTH_X2      0x2UL
+	#define FUNC_QCFG_RESP_NEGOTIATED_LINK_WIDTH_X4      0x4UL
+	#define FUNC_QCFG_RESP_NEGOTIATED_LINK_WIDTH_X8      0x8UL
+	#define FUNC_QCFG_RESP_NEGOTIATED_LINK_WIDTH_X16     0x10UL
+	#define FUNC_QCFG_RESP_NEGOTIATED_LINK_WIDTH_LAST   FUNC_QCFG_RESP_NEGOTIATED_LINK_WIDTH_X16
+	u8	negotiated_link_speed;
+	#define FUNC_QCFG_RESP_NEGOTIATED_LINK_SPEED_UNKNOWN 0x0UL
+	#define FUNC_QCFG_RESP_NEGOTIATED_LINK_SPEED_G1      0x1UL
+	#define FUNC_QCFG_RESP_NEGOTIATED_LINK_SPEED_G2      0x2UL
+	#define FUNC_QCFG_RESP_NEGOTIATED_LINK_SPEED_G3      0x3UL
+	#define FUNC_QCFG_RESP_NEGOTIATED_LINK_SPEED_G4      0x4UL
+	#define FUNC_QCFG_RESP_NEGOTIATED_LINK_SPEED_G5      0x5UL
+	#define FUNC_QCFG_RESP_NEGOTIATED_LINK_SPEED_LAST   FUNC_QCFG_RESP_NEGOTIATED_LINK_SPEED_G5
+	u8	unused_7[2];
+	u8	pcie_compliance;
+	u8	unused_8;
+	__le16	l2_db_multi_page_size_kb;
+	u8	unused_9[5];
+	u8	valid;
+};
+
+/* hwrm_func_cfg_input (size:1280b/160B) */
+struct hwrm_func_cfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	fid;
+	__le16	num_msix;
+	__le32	flags;
+	#define FUNC_CFG_REQ_FLAGS_SRC_MAC_ADDR_CHECK_DISABLE     0x1UL
+	#define FUNC_CFG_REQ_FLAGS_SRC_MAC_ADDR_CHECK_ENABLE      0x2UL
+	#define FUNC_CFG_REQ_FLAGS_RSVD_MASK                      0x1fcUL
+	#define FUNC_CFG_REQ_FLAGS_RSVD_SFT                       2
+	#define FUNC_CFG_REQ_FLAGS_STD_TX_RING_MODE_ENABLE        0x200UL
+	#define FUNC_CFG_REQ_FLAGS_STD_TX_RING_MODE_DISABLE       0x400UL
+	#define FUNC_CFG_REQ_FLAGS_VIRT_MAC_PERSIST               0x800UL
+	#define FUNC_CFG_REQ_FLAGS_NO_AUTOCLEAR_STATISTIC         0x1000UL
+	#define FUNC_CFG_REQ_FLAGS_TX_ASSETS_TEST                 0x2000UL
+	#define FUNC_CFG_REQ_FLAGS_RX_ASSETS_TEST                 0x4000UL
+	#define FUNC_CFG_REQ_FLAGS_CMPL_ASSETS_TEST               0x8000UL
+	#define FUNC_CFG_REQ_FLAGS_RSSCOS_CTX_ASSETS_TEST         0x10000UL
+	#define FUNC_CFG_REQ_FLAGS_RING_GRP_ASSETS_TEST           0x20000UL
+	#define FUNC_CFG_REQ_FLAGS_STAT_CTX_ASSETS_TEST           0x40000UL
+	#define FUNC_CFG_REQ_FLAGS_VNIC_ASSETS_TEST               0x80000UL
+	#define FUNC_CFG_REQ_FLAGS_L2_CTX_ASSETS_TEST             0x100000UL
+	#define FUNC_CFG_REQ_FLAGS_TRUSTED_VF_ENABLE              0x200000UL
+	#define FUNC_CFG_REQ_FLAGS_DYNAMIC_TX_RING_ALLOC          0x400000UL
+	#define FUNC_CFG_REQ_FLAGS_NQ_ASSETS_TEST                 0x800000UL
+	#define FUNC_CFG_REQ_FLAGS_TRUSTED_VF_DISABLE             0x1000000UL
+	#define FUNC_CFG_REQ_FLAGS_PREBOOT_LEGACY_L2_RINGS        0x2000000UL
+	#define FUNC_CFG_REQ_FLAGS_HOT_RESET_IF_EN_DIS            0x4000000UL
+	#define FUNC_CFG_REQ_FLAGS_PPP_PUSH_MODE_ENABLE           0x8000000UL
+	#define FUNC_CFG_REQ_FLAGS_PPP_PUSH_MODE_DISABLE          0x10000000UL
+	#define FUNC_CFG_REQ_FLAGS_BD_METADATA_ENABLE             0x20000000UL
+	#define FUNC_CFG_REQ_FLAGS_BD_METADATA_DISABLE            0x40000000UL
+	__le32	enables;
+	#define FUNC_CFG_REQ_ENABLES_ADMIN_MTU                0x1UL
+	#define FUNC_CFG_REQ_ENABLES_MRU                      0x2UL
+	#define FUNC_CFG_REQ_ENABLES_NUM_RSSCOS_CTXS          0x4UL
+	#define FUNC_CFG_REQ_ENABLES_NUM_CMPL_RINGS           0x8UL
+	#define FUNC_CFG_REQ_ENABLES_NUM_TX_RINGS             0x10UL
+	#define FUNC_CFG_REQ_ENABLES_NUM_RX_RINGS             0x20UL
+	#define FUNC_CFG_REQ_ENABLES_NUM_L2_CTXS              0x40UL
+	#define FUNC_CFG_REQ_ENABLES_NUM_VNICS                0x80UL
+	#define FUNC_CFG_REQ_ENABLES_NUM_STAT_CTXS            0x100UL
+	#define FUNC_CFG_REQ_ENABLES_DFLT_MAC_ADDR            0x200UL
+	#define FUNC_CFG_REQ_ENABLES_DFLT_VLAN                0x400UL
+	#define FUNC_CFG_REQ_ENABLES_DFLT_IP_ADDR             0x800UL
+	#define FUNC_CFG_REQ_ENABLES_MIN_BW                   0x1000UL
+	#define FUNC_CFG_REQ_ENABLES_MAX_BW                   0x2000UL
+	#define FUNC_CFG_REQ_ENABLES_ASYNC_EVENT_CR           0x4000UL
+	#define FUNC_CFG_REQ_ENABLES_VLAN_ANTISPOOF_MODE      0x8000UL
+	#define FUNC_CFG_REQ_ENABLES_ALLOWED_VLAN_PRIS        0x10000UL
+	#define FUNC_CFG_REQ_ENABLES_EVB_MODE                 0x20000UL
+	#define FUNC_CFG_REQ_ENABLES_NUM_MCAST_FILTERS        0x40000UL
+	#define FUNC_CFG_REQ_ENABLES_NUM_HW_RING_GRPS         0x80000UL
+	#define FUNC_CFG_REQ_ENABLES_CACHE_LINESIZE           0x100000UL
+	#define FUNC_CFG_REQ_ENABLES_NUM_MSIX                 0x200000UL
+	#define FUNC_CFG_REQ_ENABLES_ADMIN_LINK_STATE         0x400000UL
+	#define FUNC_CFG_REQ_ENABLES_HOT_RESET_IF_SUPPORT     0x800000UL
+	#define FUNC_CFG_REQ_ENABLES_SCHQ_ID                  0x1000000UL
+	#define FUNC_CFG_REQ_ENABLES_MPC_CHNLS                0x2000000UL
+	#define FUNC_CFG_REQ_ENABLES_PARTITION_MIN_BW         0x4000000UL
+	#define FUNC_CFG_REQ_ENABLES_PARTITION_MAX_BW         0x8000000UL
+	#define FUNC_CFG_REQ_ENABLES_TPID                     0x10000000UL
+	#define FUNC_CFG_REQ_ENABLES_HOST_MTU                 0x20000000UL
+	#define FUNC_CFG_REQ_ENABLES_KTLS_TX_KEY_CTXS         0x40000000UL
+	#define FUNC_CFG_REQ_ENABLES_KTLS_RX_KEY_CTXS         0x80000000UL
+	__le16	admin_mtu;
+	__le16	mru;
+	__le16	num_rsscos_ctxs;
+	__le16	num_cmpl_rings;
+	__le16	num_tx_rings;
+	__le16	num_rx_rings;
+	__le16	num_l2_ctxs;
+	__le16	num_vnics;
+	__le16	num_stat_ctxs;
+	__le16	num_hw_ring_grps;
+	u8	dflt_mac_addr[6];
+	__le16	dflt_vlan;
+	__be32	dflt_ip_addr[4];
+	__le32	min_bw;
+	#define FUNC_CFG_REQ_MIN_BW_BW_VALUE_MASK             0xfffffffUL
+	#define FUNC_CFG_REQ_MIN_BW_BW_VALUE_SFT              0
+	#define FUNC_CFG_REQ_MIN_BW_SCALE                     0x10000000UL
+	#define FUNC_CFG_REQ_MIN_BW_SCALE_BITS                  (0x0UL << 28)
+	#define FUNC_CFG_REQ_MIN_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define FUNC_CFG_REQ_MIN_BW_SCALE_LAST                 FUNC_CFG_REQ_MIN_BW_SCALE_BYTES
+	#define FUNC_CFG_REQ_MIN_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define FUNC_CFG_REQ_MIN_BW_BW_VALUE_UNIT_SFT         29
+	#define FUNC_CFG_REQ_MIN_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define FUNC_CFG_REQ_MIN_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define FUNC_CFG_REQ_MIN_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define FUNC_CFG_REQ_MIN_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define FUNC_CFG_REQ_MIN_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define FUNC_CFG_REQ_MIN_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define FUNC_CFG_REQ_MIN_BW_BW_VALUE_UNIT_LAST         FUNC_CFG_REQ_MIN_BW_BW_VALUE_UNIT_INVALID
+	__le32	max_bw;
+	#define FUNC_CFG_REQ_MAX_BW_BW_VALUE_MASK             0xfffffffUL
+	#define FUNC_CFG_REQ_MAX_BW_BW_VALUE_SFT              0
+	#define FUNC_CFG_REQ_MAX_BW_SCALE                     0x10000000UL
+	#define FUNC_CFG_REQ_MAX_BW_SCALE_BITS                  (0x0UL << 28)
+	#define FUNC_CFG_REQ_MAX_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define FUNC_CFG_REQ_MAX_BW_SCALE_LAST                 FUNC_CFG_REQ_MAX_BW_SCALE_BYTES
+	#define FUNC_CFG_REQ_MAX_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define FUNC_CFG_REQ_MAX_BW_BW_VALUE_UNIT_SFT         29
+	#define FUNC_CFG_REQ_MAX_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define FUNC_CFG_REQ_MAX_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define FUNC_CFG_REQ_MAX_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define FUNC_CFG_REQ_MAX_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define FUNC_CFG_REQ_MAX_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define FUNC_CFG_REQ_MAX_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define FUNC_CFG_REQ_MAX_BW_BW_VALUE_UNIT_LAST         FUNC_CFG_REQ_MAX_BW_BW_VALUE_UNIT_INVALID
+	__le16	async_event_cr;
+	u8	vlan_antispoof_mode;
+	#define FUNC_CFG_REQ_VLAN_ANTISPOOF_MODE_NOCHECK                 0x0UL
+	#define FUNC_CFG_REQ_VLAN_ANTISPOOF_MODE_VALIDATE_VLAN           0x1UL
+	#define FUNC_CFG_REQ_VLAN_ANTISPOOF_MODE_INSERT_IF_VLANDNE       0x2UL
+	#define FUNC_CFG_REQ_VLAN_ANTISPOOF_MODE_INSERT_OR_OVERRIDE_VLAN 0x3UL
+	#define FUNC_CFG_REQ_VLAN_ANTISPOOF_MODE_LAST                   FUNC_CFG_REQ_VLAN_ANTISPOOF_MODE_INSERT_OR_OVERRIDE_VLAN
+	u8	allowed_vlan_pris;
+	u8	evb_mode;
+	#define FUNC_CFG_REQ_EVB_MODE_NO_EVB 0x0UL
+	#define FUNC_CFG_REQ_EVB_MODE_VEB    0x1UL
+	#define FUNC_CFG_REQ_EVB_MODE_VEPA   0x2UL
+	#define FUNC_CFG_REQ_EVB_MODE_LAST  FUNC_CFG_REQ_EVB_MODE_VEPA
+	u8	options;
+	#define FUNC_CFG_REQ_OPTIONS_CACHE_LINESIZE_MASK         0x3UL
+	#define FUNC_CFG_REQ_OPTIONS_CACHE_LINESIZE_SFT          0
+	#define FUNC_CFG_REQ_OPTIONS_CACHE_LINESIZE_SIZE_64        0x0UL
+	#define FUNC_CFG_REQ_OPTIONS_CACHE_LINESIZE_SIZE_128       0x1UL
+	#define FUNC_CFG_REQ_OPTIONS_CACHE_LINESIZE_LAST          FUNC_CFG_REQ_OPTIONS_CACHE_LINESIZE_SIZE_128
+	#define FUNC_CFG_REQ_OPTIONS_LINK_ADMIN_STATE_MASK       0xcUL
+	#define FUNC_CFG_REQ_OPTIONS_LINK_ADMIN_STATE_SFT        2
+	#define FUNC_CFG_REQ_OPTIONS_LINK_ADMIN_STATE_FORCED_DOWN  (0x0UL << 2)
+	#define FUNC_CFG_REQ_OPTIONS_LINK_ADMIN_STATE_FORCED_UP    (0x1UL << 2)
+	#define FUNC_CFG_REQ_OPTIONS_LINK_ADMIN_STATE_AUTO         (0x2UL << 2)
+	#define FUNC_CFG_REQ_OPTIONS_LINK_ADMIN_STATE_LAST        FUNC_CFG_REQ_OPTIONS_LINK_ADMIN_STATE_AUTO
+	#define FUNC_CFG_REQ_OPTIONS_RSVD_MASK                   0xf0UL
+	#define FUNC_CFG_REQ_OPTIONS_RSVD_SFT                    4
+	__le16	num_mcast_filters;
+	__le16	schq_id;
+	__le16	mpc_chnls;
+	#define FUNC_CFG_REQ_MPC_CHNLS_TCE_ENABLE          0x1UL
+	#define FUNC_CFG_REQ_MPC_CHNLS_TCE_DISABLE         0x2UL
+	#define FUNC_CFG_REQ_MPC_CHNLS_RCE_ENABLE          0x4UL
+	#define FUNC_CFG_REQ_MPC_CHNLS_RCE_DISABLE         0x8UL
+	#define FUNC_CFG_REQ_MPC_CHNLS_TE_CFA_ENABLE       0x10UL
+	#define FUNC_CFG_REQ_MPC_CHNLS_TE_CFA_DISABLE      0x20UL
+	#define FUNC_CFG_REQ_MPC_CHNLS_RE_CFA_ENABLE       0x40UL
+	#define FUNC_CFG_REQ_MPC_CHNLS_RE_CFA_DISABLE      0x80UL
+	#define FUNC_CFG_REQ_MPC_CHNLS_PRIMATE_ENABLE      0x100UL
+	#define FUNC_CFG_REQ_MPC_CHNLS_PRIMATE_DISABLE     0x200UL
+	__le32	partition_min_bw;
+	#define FUNC_CFG_REQ_PARTITION_MIN_BW_BW_VALUE_MASK             0xfffffffUL
+	#define FUNC_CFG_REQ_PARTITION_MIN_BW_BW_VALUE_SFT              0
+	#define FUNC_CFG_REQ_PARTITION_MIN_BW_SCALE                     0x10000000UL
+	#define FUNC_CFG_REQ_PARTITION_MIN_BW_SCALE_BITS                  (0x0UL << 28)
+	#define FUNC_CFG_REQ_PARTITION_MIN_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define FUNC_CFG_REQ_PARTITION_MIN_BW_SCALE_LAST                 FUNC_CFG_REQ_PARTITION_MIN_BW_SCALE_BYTES
+	#define FUNC_CFG_REQ_PARTITION_MIN_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define FUNC_CFG_REQ_PARTITION_MIN_BW_BW_VALUE_UNIT_SFT         29
+	#define FUNC_CFG_REQ_PARTITION_MIN_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define FUNC_CFG_REQ_PARTITION_MIN_BW_BW_VALUE_UNIT_LAST         FUNC_CFG_REQ_PARTITION_MIN_BW_BW_VALUE_UNIT_PERCENT1_100
+	__le32	partition_max_bw;
+	#define FUNC_CFG_REQ_PARTITION_MAX_BW_BW_VALUE_MASK             0xfffffffUL
+	#define FUNC_CFG_REQ_PARTITION_MAX_BW_BW_VALUE_SFT              0
+	#define FUNC_CFG_REQ_PARTITION_MAX_BW_SCALE                     0x10000000UL
+	#define FUNC_CFG_REQ_PARTITION_MAX_BW_SCALE_BITS                  (0x0UL << 28)
+	#define FUNC_CFG_REQ_PARTITION_MAX_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define FUNC_CFG_REQ_PARTITION_MAX_BW_SCALE_LAST                 FUNC_CFG_REQ_PARTITION_MAX_BW_SCALE_BYTES
+	#define FUNC_CFG_REQ_PARTITION_MAX_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define FUNC_CFG_REQ_PARTITION_MAX_BW_BW_VALUE_UNIT_SFT         29
+	#define FUNC_CFG_REQ_PARTITION_MAX_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define FUNC_CFG_REQ_PARTITION_MAX_BW_BW_VALUE_UNIT_LAST         FUNC_CFG_REQ_PARTITION_MAX_BW_BW_VALUE_UNIT_PERCENT1_100
+	__be16	tpid;
+	__le16	host_mtu;
+	__le32	flags2;
+	#define FUNC_CFG_REQ_FLAGS2_KTLS_KEY_CTX_ASSETS_TEST     0x1UL
+	#define FUNC_CFG_REQ_FLAGS2_QUIC_KEY_CTX_ASSETS_TEST     0x2UL
+	__le32	enables2;
+	#define FUNC_CFG_REQ_ENABLES2_KDNET                    0x1UL
+	#define FUNC_CFG_REQ_ENABLES2_DB_PAGE_SIZE             0x2UL
+	#define FUNC_CFG_REQ_ENABLES2_QUIC_TX_KEY_CTXS         0x4UL
+	#define FUNC_CFG_REQ_ENABLES2_QUIC_RX_KEY_CTXS         0x8UL
+	#define FUNC_CFG_REQ_ENABLES2_ROCE_MAX_AV_PER_VF       0x10UL
+	#define FUNC_CFG_REQ_ENABLES2_ROCE_MAX_CQ_PER_VF       0x20UL
+	#define FUNC_CFG_REQ_ENABLES2_ROCE_MAX_MRW_PER_VF      0x40UL
+	#define FUNC_CFG_REQ_ENABLES2_ROCE_MAX_QP_PER_VF       0x80UL
+	#define FUNC_CFG_REQ_ENABLES2_ROCE_MAX_SRQ_PER_VF      0x100UL
+	#define FUNC_CFG_REQ_ENABLES2_ROCE_MAX_GID_PER_VF      0x200UL
+	#define FUNC_CFG_REQ_ENABLES2_XID_PARTITION_CFG        0x400UL
+	#define FUNC_CFG_REQ_ENABLES2_PHYSICAL_SLOT_NUMBER     0x800UL
+	#define FUNC_CFG_REQ_ENABLES2_PCIE_COMPLIANCE          0x1000UL
+	u8	port_kdnet_mode;
+	#define FUNC_CFG_REQ_PORT_KDNET_MODE_DISABLED 0x0UL
+	#define FUNC_CFG_REQ_PORT_KDNET_MODE_ENABLED  0x1UL
+	#define FUNC_CFG_REQ_PORT_KDNET_MODE_LAST    FUNC_CFG_REQ_PORT_KDNET_MODE_ENABLED
+	u8	db_page_size;
+	#define FUNC_CFG_REQ_DB_PAGE_SIZE_4KB   0x0UL
+	#define FUNC_CFG_REQ_DB_PAGE_SIZE_8KB   0x1UL
+	#define FUNC_CFG_REQ_DB_PAGE_SIZE_16KB  0x2UL
+	#define FUNC_CFG_REQ_DB_PAGE_SIZE_32KB  0x3UL
+	#define FUNC_CFG_REQ_DB_PAGE_SIZE_64KB  0x4UL
+	#define FUNC_CFG_REQ_DB_PAGE_SIZE_128KB 0x5UL
+	#define FUNC_CFG_REQ_DB_PAGE_SIZE_256KB 0x6UL
+	#define FUNC_CFG_REQ_DB_PAGE_SIZE_512KB 0x7UL
+	#define FUNC_CFG_REQ_DB_PAGE_SIZE_1MB   0x8UL
+	#define FUNC_CFG_REQ_DB_PAGE_SIZE_2MB   0x9UL
+	#define FUNC_CFG_REQ_DB_PAGE_SIZE_4MB   0xaUL
+	#define FUNC_CFG_REQ_DB_PAGE_SIZE_LAST FUNC_CFG_REQ_DB_PAGE_SIZE_4MB
+	__le16	physical_slot_number;
+	__le32	num_ktls_tx_key_ctxs;
+	__le32	num_ktls_rx_key_ctxs;
+	__le32	num_quic_tx_key_ctxs;
+	__le32	num_quic_rx_key_ctxs;
+	__le32	roce_max_av_per_vf;
+	__le32	roce_max_cq_per_vf;
+	__le32	roce_max_mrw_per_vf;
+	__le32	roce_max_qp_per_vf;
+	__le32	roce_max_srq_per_vf;
+	__le32	roce_max_gid_per_vf;
+	__le16	xid_partition_cfg;
+	#define FUNC_CFG_REQ_XID_PARTITION_CFG_TX_CK     0x1UL
+	#define FUNC_CFG_REQ_XID_PARTITION_CFG_RX_CK     0x2UL
+	u8	pcie_compliance;
+	u8	unused_2;
+};
+
+/* hwrm_func_cfg_output (size:128b/16B) */
+struct hwrm_func_cfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_func_cfg_cmd_err (size:64b/8B) */
+struct hwrm_func_cfg_cmd_err {
+	u8	code;
+	#define FUNC_CFG_CMD_ERR_CODE_UNKNOWN                      0x0UL
+	#define FUNC_CFG_CMD_ERR_CODE_PARTITION_BW_OUT_OF_RANGE    0x1UL
+	#define FUNC_CFG_CMD_ERR_CODE_NPAR_PARTITION_DOWN_FAILED   0x2UL
+	#define FUNC_CFG_CMD_ERR_CODE_TPID_SET_DFLT_VLAN_NOT_SET   0x3UL
+	#define FUNC_CFG_CMD_ERR_CODE_RES_ARRAY_ALLOC_FAILED       0x4UL
+	#define FUNC_CFG_CMD_ERR_CODE_TX_RING_ASSET_TEST_FAILED    0x5UL
+	#define FUNC_CFG_CMD_ERR_CODE_TX_RING_RES_UPDATE_FAILED    0x6UL
+	#define FUNC_CFG_CMD_ERR_CODE_APPLY_MAX_BW_FAILED          0x7UL
+	#define FUNC_CFG_CMD_ERR_CODE_ENABLE_EVB_FAILED            0x8UL
+	#define FUNC_CFG_CMD_ERR_CODE_RSS_CTXT_ASSET_TEST_FAILED   0x9UL
+	#define FUNC_CFG_CMD_ERR_CODE_RSS_CTXT_RES_UPDATE_FAILED   0xaUL
+	#define FUNC_CFG_CMD_ERR_CODE_CMPL_RING_ASSET_TEST_FAILED  0xbUL
+	#define FUNC_CFG_CMD_ERR_CODE_CMPL_RING_RES_UPDATE_FAILED  0xcUL
+	#define FUNC_CFG_CMD_ERR_CODE_NQ_ASSET_TEST_FAILED         0xdUL
+	#define FUNC_CFG_CMD_ERR_CODE_NQ_RES_UPDATE_FAILED         0xeUL
+	#define FUNC_CFG_CMD_ERR_CODE_RX_RING_ASSET_TEST_FAILED    0xfUL
+	#define FUNC_CFG_CMD_ERR_CODE_RX_RING_RES_UPDATE_FAILED    0x10UL
+	#define FUNC_CFG_CMD_ERR_CODE_VNIC_ASSET_TEST_FAILED       0x11UL
+	#define FUNC_CFG_CMD_ERR_CODE_VNIC_RES_UPDATE_FAILED       0x12UL
+	#define FUNC_CFG_CMD_ERR_CODE_FAILED_TO_START_STATS_THREAD 0x13UL
+	#define FUNC_CFG_CMD_ERR_CODE_RDMA_SRIOV_DISABLED          0x14UL
+	#define FUNC_CFG_CMD_ERR_CODE_TX_KTLS_DISABLED             0x15UL
+	#define FUNC_CFG_CMD_ERR_CODE_TX_KTLS_ASSET_TEST_FAILED    0x16UL
+	#define FUNC_CFG_CMD_ERR_CODE_TX_KTLS_RES_UPDATE_FAILED    0x17UL
+	#define FUNC_CFG_CMD_ERR_CODE_RX_KTLS_DISABLED             0x18UL
+	#define FUNC_CFG_CMD_ERR_CODE_RX_KTLS_ASSET_TEST_FAILED    0x19UL
+	#define FUNC_CFG_CMD_ERR_CODE_RX_KTLS_RES_UPDATE_FAILED    0x1aUL
+	#define FUNC_CFG_CMD_ERR_CODE_TX_QUIC_DISABLED             0x1bUL
+	#define FUNC_CFG_CMD_ERR_CODE_TX_QUIC_ASSET_TEST_FAILED    0x1cUL
+	#define FUNC_CFG_CMD_ERR_CODE_TX_QUIC_RES_UPDATE_FAILED    0x1dUL
+	#define FUNC_CFG_CMD_ERR_CODE_RX_QUIC_DISABLED             0x1eUL
+	#define FUNC_CFG_CMD_ERR_CODE_RX_QUIC_ASSET_TEST_FAILED    0x1fUL
+	#define FUNC_CFG_CMD_ERR_CODE_RX_QUIC_RES_UPDATE_FAILED    0x20UL
+	#define FUNC_CFG_CMD_ERR_CODE_INVALID_KDNET_MODE           0x21UL
+	#define FUNC_CFG_CMD_ERR_CODE_SCHQ_CFG_FAIL                0x22UL
+	#define FUNC_CFG_CMD_ERR_CODE_LAST                        FUNC_CFG_CMD_ERR_CODE_SCHQ_CFG_FAIL
+	u8	unused_0[7];
+};
+
+/* hwrm_func_qstats_input (size:192b/24B) */
+struct hwrm_func_qstats_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	fid;
+	u8	flags;
+	#define FUNC_QSTATS_REQ_FLAGS_ROCE_ONLY        0x1UL
+	#define FUNC_QSTATS_REQ_FLAGS_COUNTER_MASK     0x2UL
+	#define FUNC_QSTATS_REQ_FLAGS_L2_ONLY          0x4UL
+	u8	unused_0[5];
+};
+
+/* hwrm_func_qstats_output (size:1408b/176B) */
+struct hwrm_func_qstats_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le64	tx_ucast_pkts;
+	__le64	tx_mcast_pkts;
+	__le64	tx_bcast_pkts;
+	__le64	tx_discard_pkts;
+	__le64	tx_drop_pkts;
+	__le64	tx_ucast_bytes;
+	__le64	tx_mcast_bytes;
+	__le64	tx_bcast_bytes;
+	__le64	rx_ucast_pkts;
+	__le64	rx_mcast_pkts;
+	__le64	rx_bcast_pkts;
+	__le64	rx_discard_pkts;
+	__le64	rx_drop_pkts;
+	__le64	rx_ucast_bytes;
+	__le64	rx_mcast_bytes;
+	__le64	rx_bcast_bytes;
+	__le64	rx_agg_pkts;
+	__le64	rx_agg_bytes;
+	__le64	rx_agg_events;
+	__le64	rx_agg_aborts;
+	u8	clear_seq;
+	u8	unused_0[6];
+	u8	valid;
+};
+
+/* hwrm_func_qstats_ext_input (size:256b/32B) */
+struct hwrm_func_qstats_ext_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	fid;
+	u8	flags;
+	#define FUNC_QSTATS_EXT_REQ_FLAGS_ROCE_ONLY        0x1UL
+	#define FUNC_QSTATS_EXT_REQ_FLAGS_COUNTER_MASK     0x2UL
+	u8	unused_0[1];
+	__le32	enables;
+	#define FUNC_QSTATS_EXT_REQ_ENABLES_SCHQ_ID     0x1UL
+	__le16	schq_id;
+	__le16	traffic_class;
+	u8	unused_1[4];
+};
+
+/* hwrm_func_qstats_ext_output (size:1536b/192B) */
+struct hwrm_func_qstats_ext_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le64	rx_ucast_pkts;
+	__le64	rx_mcast_pkts;
+	__le64	rx_bcast_pkts;
+	__le64	rx_discard_pkts;
+	__le64	rx_error_pkts;
+	__le64	rx_ucast_bytes;
+	__le64	rx_mcast_bytes;
+	__le64	rx_bcast_bytes;
+	__le64	tx_ucast_pkts;
+	__le64	tx_mcast_pkts;
+	__le64	tx_bcast_pkts;
+	__le64	tx_error_pkts;
+	__le64	tx_discard_pkts;
+	__le64	tx_ucast_bytes;
+	__le64	tx_mcast_bytes;
+	__le64	tx_bcast_bytes;
+	__le64	rx_tpa_eligible_pkt;
+	__le64	rx_tpa_eligible_bytes;
+	__le64	rx_tpa_pkt;
+	__le64	rx_tpa_bytes;
+	__le64	rx_tpa_errors;
+	__le64	rx_tpa_events;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_func_clr_stats_input (size:192b/24B) */
+struct hwrm_func_clr_stats_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	fid;
+	u8	unused_0[6];
+};
+
+/* hwrm_func_clr_stats_output (size:128b/16B) */
+struct hwrm_func_clr_stats_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_func_vf_resc_free_input (size:192b/24B) */
+struct hwrm_func_vf_resc_free_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	vf_id;
+	u8	unused_0[6];
+};
+
+/* hwrm_func_vf_resc_free_output (size:128b/16B) */
+struct hwrm_func_vf_resc_free_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_func_drv_rgtr_input (size:896b/112B) */
+struct hwrm_func_drv_rgtr_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	flags;
+	#define FUNC_DRV_RGTR_REQ_FLAGS_FWD_ALL_MODE                     0x1UL
+	#define FUNC_DRV_RGTR_REQ_FLAGS_FWD_NONE_MODE                    0x2UL
+	#define FUNC_DRV_RGTR_REQ_FLAGS_16BIT_VER_MODE                   0x4UL
+	#define FUNC_DRV_RGTR_REQ_FLAGS_FLOW_HANDLE_64BIT_MODE           0x8UL
+	#define FUNC_DRV_RGTR_REQ_FLAGS_HOT_RESET_SUPPORT                0x10UL
+	#define FUNC_DRV_RGTR_REQ_FLAGS_ERROR_RECOVERY_SUPPORT           0x20UL
+	#define FUNC_DRV_RGTR_REQ_FLAGS_MASTER_SUPPORT                   0x40UL
+	#define FUNC_DRV_RGTR_REQ_FLAGS_FAST_RESET_SUPPORT               0x80UL
+	#define FUNC_DRV_RGTR_REQ_FLAGS_RSS_STRICT_HASH_TYPE_SUPPORT     0x100UL
+	#define FUNC_DRV_RGTR_REQ_FLAGS_NPAR_1_2_SUPPORT                 0x200UL
+	#define FUNC_DRV_RGTR_REQ_FLAGS_ASYM_QUEUE_CFG_SUPPORT           0x400UL
+	#define FUNC_DRV_RGTR_REQ_FLAGS_TF_INGRESS_NIC_FLOW_MODE         0x800UL
+	#define FUNC_DRV_RGTR_REQ_FLAGS_TF_EGRESS_NIC_FLOW_MODE          0x1000UL
+	__le32	enables;
+	#define FUNC_DRV_RGTR_REQ_ENABLES_OS_TYPE             0x1UL
+	#define FUNC_DRV_RGTR_REQ_ENABLES_VER                 0x2UL
+	#define FUNC_DRV_RGTR_REQ_ENABLES_TIMESTAMP           0x4UL
+	#define FUNC_DRV_RGTR_REQ_ENABLES_VF_REQ_FWD          0x8UL
+	#define FUNC_DRV_RGTR_REQ_ENABLES_ASYNC_EVENT_FWD     0x10UL
+	__le16	os_type;
+	#define FUNC_DRV_RGTR_REQ_OS_TYPE_UNKNOWN   0x0UL
+	#define FUNC_DRV_RGTR_REQ_OS_TYPE_OTHER     0x1UL
+	#define FUNC_DRV_RGTR_REQ_OS_TYPE_MSDOS     0xeUL
+	#define FUNC_DRV_RGTR_REQ_OS_TYPE_WINDOWS   0x12UL
+	#define FUNC_DRV_RGTR_REQ_OS_TYPE_SOLARIS   0x1dUL
+	#define FUNC_DRV_RGTR_REQ_OS_TYPE_LINUX     0x24UL
+	#define FUNC_DRV_RGTR_REQ_OS_TYPE_FREEBSD   0x2aUL
+	#define FUNC_DRV_RGTR_REQ_OS_TYPE_ESXI      0x68UL
+	#define FUNC_DRV_RGTR_REQ_OS_TYPE_WIN864    0x73UL
+	#define FUNC_DRV_RGTR_REQ_OS_TYPE_WIN2012R2 0x74UL
+	#define FUNC_DRV_RGTR_REQ_OS_TYPE_UEFI      0x8000UL
+	#define FUNC_DRV_RGTR_REQ_OS_TYPE_LAST     FUNC_DRV_RGTR_REQ_OS_TYPE_UEFI
+	u8	ver_maj_8b;
+	u8	ver_min_8b;
+	u8	ver_upd_8b;
+	u8	unused_0[3];
+	__le32	timestamp;
+	u8	unused_1[4];
+	__le32	vf_req_fwd[8];
+	__le32	async_event_fwd[8];
+	__le16	ver_maj;
+	__le16	ver_min;
+	__le16	ver_upd;
+	__le16	ver_patch;
+};
+
+/* hwrm_func_drv_rgtr_output (size:128b/16B) */
+struct hwrm_func_drv_rgtr_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le32	flags;
+	#define FUNC_DRV_RGTR_RESP_FLAGS_IF_CHANGE_SUPPORTED     0x1UL
+	u8	unused_0[3];
+	u8	valid;
+};
+
+/* hwrm_func_drv_unrgtr_input (size:192b/24B) */
+struct hwrm_func_drv_unrgtr_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	flags;
+	#define FUNC_DRV_UNRGTR_REQ_FLAGS_PREPARE_FOR_SHUTDOWN     0x1UL
+	u8	unused_0[4];
+};
+
+/* hwrm_func_drv_unrgtr_output (size:128b/16B) */
+struct hwrm_func_drv_unrgtr_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_func_buf_rgtr_input (size:1024b/128B) */
+struct hwrm_func_buf_rgtr_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	enables;
+	#define FUNC_BUF_RGTR_REQ_ENABLES_VF_ID            0x1UL
+	#define FUNC_BUF_RGTR_REQ_ENABLES_ERR_BUF_ADDR     0x2UL
+	__le16	vf_id;
+	__le16	req_buf_num_pages;
+	__le16	req_buf_page_size;
+	#define FUNC_BUF_RGTR_REQ_REQ_BUF_PAGE_SIZE_16B 0x4UL
+	#define FUNC_BUF_RGTR_REQ_REQ_BUF_PAGE_SIZE_4K  0xcUL
+	#define FUNC_BUF_RGTR_REQ_REQ_BUF_PAGE_SIZE_8K  0xdUL
+	#define FUNC_BUF_RGTR_REQ_REQ_BUF_PAGE_SIZE_64K 0x10UL
+	#define FUNC_BUF_RGTR_REQ_REQ_BUF_PAGE_SIZE_2M  0x15UL
+	#define FUNC_BUF_RGTR_REQ_REQ_BUF_PAGE_SIZE_4M  0x16UL
+	#define FUNC_BUF_RGTR_REQ_REQ_BUF_PAGE_SIZE_1G  0x1eUL
+	#define FUNC_BUF_RGTR_REQ_REQ_BUF_PAGE_SIZE_LAST FUNC_BUF_RGTR_REQ_REQ_BUF_PAGE_SIZE_1G
+	__le16	req_buf_len;
+	__le16	resp_buf_len;
+	u8	unused_0[2];
+	__le64	req_buf_page_addr0;
+	__le64	req_buf_page_addr1;
+	__le64	req_buf_page_addr2;
+	__le64	req_buf_page_addr3;
+	__le64	req_buf_page_addr4;
+	__le64	req_buf_page_addr5;
+	__le64	req_buf_page_addr6;
+	__le64	req_buf_page_addr7;
+	__le64	req_buf_page_addr8;
+	__le64	req_buf_page_addr9;
+	__le64	error_buf_addr;
+	__le64	resp_buf_addr;
+};
+
+/* hwrm_func_buf_rgtr_output (size:128b/16B) */
+struct hwrm_func_buf_rgtr_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_func_drv_qver_input (size:192b/24B) */
+struct hwrm_func_drv_qver_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	reserved;
+	__le16	fid;
+	u8	driver_type;
+	#define FUNC_DRV_QVER_REQ_DRIVER_TYPE_L2   0x0UL
+	#define FUNC_DRV_QVER_REQ_DRIVER_TYPE_ROCE 0x1UL
+	#define FUNC_DRV_QVER_REQ_DRIVER_TYPE_LAST FUNC_DRV_QVER_REQ_DRIVER_TYPE_ROCE
+	u8	unused_0;
+};
+
+/* hwrm_func_drv_qver_output (size:256b/32B) */
+struct hwrm_func_drv_qver_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	os_type;
+	#define FUNC_DRV_QVER_RESP_OS_TYPE_UNKNOWN   0x0UL
+	#define FUNC_DRV_QVER_RESP_OS_TYPE_OTHER     0x1UL
+	#define FUNC_DRV_QVER_RESP_OS_TYPE_MSDOS     0xeUL
+	#define FUNC_DRV_QVER_RESP_OS_TYPE_WINDOWS   0x12UL
+	#define FUNC_DRV_QVER_RESP_OS_TYPE_SOLARIS   0x1dUL
+	#define FUNC_DRV_QVER_RESP_OS_TYPE_LINUX     0x24UL
+	#define FUNC_DRV_QVER_RESP_OS_TYPE_FREEBSD   0x2aUL
+	#define FUNC_DRV_QVER_RESP_OS_TYPE_ESXI      0x68UL
+	#define FUNC_DRV_QVER_RESP_OS_TYPE_WIN864    0x73UL
+	#define FUNC_DRV_QVER_RESP_OS_TYPE_WIN2012R2 0x74UL
+	#define FUNC_DRV_QVER_RESP_OS_TYPE_UEFI      0x8000UL
+	#define FUNC_DRV_QVER_RESP_OS_TYPE_LAST     FUNC_DRV_QVER_RESP_OS_TYPE_UEFI
+	u8	ver_maj_8b;
+	u8	ver_min_8b;
+	u8	ver_upd_8b;
+	u8	unused_0[3];
+	__le16	ver_maj;
+	__le16	ver_min;
+	__le16	ver_upd;
+	__le16	ver_patch;
+	u8	unused_1[7];
+	u8	valid;
+};
+
+/* hwrm_func_resource_qcaps_input (size:192b/24B) */
+struct hwrm_func_resource_qcaps_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	fid;
+	u8	unused_0[6];
+};
+
+/* hwrm_func_resource_qcaps_output (size:704b/88B) */
+struct hwrm_func_resource_qcaps_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	max_vfs;
+	__le16	max_msix;
+	__le16	vf_reservation_strategy;
+	#define FUNC_RESOURCE_QCAPS_RESP_VF_RESERVATION_STRATEGY_MAXIMAL        0x0UL
+	#define FUNC_RESOURCE_QCAPS_RESP_VF_RESERVATION_STRATEGY_MINIMAL        0x1UL
+	#define FUNC_RESOURCE_QCAPS_RESP_VF_RESERVATION_STRATEGY_MINIMAL_STATIC 0x2UL
+	#define FUNC_RESOURCE_QCAPS_RESP_VF_RESERVATION_STRATEGY_LAST          FUNC_RESOURCE_QCAPS_RESP_VF_RESERVATION_STRATEGY_MINIMAL_STATIC
+	__le16	min_rsscos_ctx;
+	__le16	max_rsscos_ctx;
+	__le16	min_cmpl_rings;
+	__le16	max_cmpl_rings;
+	__le16	min_tx_rings;
+	__le16	max_tx_rings;
+	__le16	min_rx_rings;
+	__le16	max_rx_rings;
+	__le16	min_l2_ctxs;
+	__le16	max_l2_ctxs;
+	__le16	min_vnics;
+	__le16	max_vnics;
+	__le16	min_stat_ctx;
+	__le16	max_stat_ctx;
+	__le16	min_hw_ring_grps;
+	__le16	max_hw_ring_grps;
+	__le16	max_tx_scheduler_inputs;
+	__le16	flags;
+	#define FUNC_RESOURCE_QCAPS_RESP_FLAGS_MIN_GUARANTEED     0x1UL
+	__le16	min_msix;
+	__le32	min_ktls_tx_key_ctxs;
+	__le32	max_ktls_tx_key_ctxs;
+	__le32	min_ktls_rx_key_ctxs;
+	__le32	max_ktls_rx_key_ctxs;
+	__le32	min_quic_tx_key_ctxs;
+	__le32	max_quic_tx_key_ctxs;
+	__le32	min_quic_rx_key_ctxs;
+	__le32	max_quic_rx_key_ctxs;
+	u8	unused_0[3];
+	u8	valid;
+};
+
+/* hwrm_func_vf_resource_cfg_input (size:704b/88B) */
+struct hwrm_func_vf_resource_cfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	vf_id;
+	__le16	max_msix;
+	__le16	min_rsscos_ctx;
+	__le16	max_rsscos_ctx;
+	__le16	min_cmpl_rings;
+	__le16	max_cmpl_rings;
+	__le16	min_tx_rings;
+	__le16	max_tx_rings;
+	__le16	min_rx_rings;
+	__le16	max_rx_rings;
+	__le16	min_l2_ctxs;
+	__le16	max_l2_ctxs;
+	__le16	min_vnics;
+	__le16	max_vnics;
+	__le16	min_stat_ctx;
+	__le16	max_stat_ctx;
+	__le16	min_hw_ring_grps;
+	__le16	max_hw_ring_grps;
+	__le16	flags;
+	#define FUNC_VF_RESOURCE_CFG_REQ_FLAGS_MIN_GUARANTEED     0x1UL
+	__le16	min_msix;
+	__le32	min_ktls_tx_key_ctxs;
+	__le32	max_ktls_tx_key_ctxs;
+	__le32	min_ktls_rx_key_ctxs;
+	__le32	max_ktls_rx_key_ctxs;
+	__le32	min_quic_tx_key_ctxs;
+	__le32	max_quic_tx_key_ctxs;
+	__le32	min_quic_rx_key_ctxs;
+	__le32	max_quic_rx_key_ctxs;
+};
+
+/* hwrm_func_vf_resource_cfg_output (size:384b/48B) */
+struct hwrm_func_vf_resource_cfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	reserved_rsscos_ctx;
+	__le16	reserved_cmpl_rings;
+	__le16	reserved_tx_rings;
+	__le16	reserved_rx_rings;
+	__le16	reserved_l2_ctxs;
+	__le16	reserved_vnics;
+	__le16	reserved_stat_ctx;
+	__le16	reserved_hw_ring_grps;
+	__le32	reserved_ktls_tx_key_ctxs;
+	__le32	reserved_ktls_rx_key_ctxs;
+	__le32	reserved_quic_tx_key_ctxs;
+	__le32	reserved_quic_rx_key_ctxs;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_func_backing_store_qcaps_input (size:128b/16B) */
+struct hwrm_func_backing_store_qcaps_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+};
+
+/* hwrm_func_backing_store_qcaps_output (size:832b/104B) */
+struct hwrm_func_backing_store_qcaps_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le32	qp_max_entries;
+	__le16	qp_min_qp1_entries;
+	__le16	qp_max_l2_entries;
+	__le16	qp_entry_size;
+	__le16	srq_max_l2_entries;
+	__le32	srq_max_entries;
+	__le16	srq_entry_size;
+	__le16	cq_max_l2_entries;
+	__le32	cq_max_entries;
+	__le16	cq_entry_size;
+	__le16	vnic_max_vnic_entries;
+	__le16	vnic_max_ring_table_entries;
+	__le16	vnic_entry_size;
+	__le32	stat_max_entries;
+	__le16	stat_entry_size;
+	__le16	tqm_entry_size;
+	__le32	tqm_min_entries_per_ring;
+	__le32	tqm_max_entries_per_ring;
+	__le32	mrav_max_entries;
+	__le16	mrav_entry_size;
+	__le16	tim_entry_size;
+	__le32	tim_max_entries;
+	__le16	mrav_num_entries_units;
+	u8	tqm_entries_multiple;
+	u8	ctx_kind_initializer;
+	__le16	ctx_init_mask;
+	#define FUNC_BACKING_STORE_QCAPS_RESP_CTX_INIT_MASK_QP       0x1UL
+	#define FUNC_BACKING_STORE_QCAPS_RESP_CTX_INIT_MASK_SRQ      0x2UL
+	#define FUNC_BACKING_STORE_QCAPS_RESP_CTX_INIT_MASK_CQ       0x4UL
+	#define FUNC_BACKING_STORE_QCAPS_RESP_CTX_INIT_MASK_VNIC     0x8UL
+	#define FUNC_BACKING_STORE_QCAPS_RESP_CTX_INIT_MASK_STAT     0x10UL
+	#define FUNC_BACKING_STORE_QCAPS_RESP_CTX_INIT_MASK_MRAV     0x20UL
+	#define FUNC_BACKING_STORE_QCAPS_RESP_CTX_INIT_MASK_TKC      0x40UL
+	#define FUNC_BACKING_STORE_QCAPS_RESP_CTX_INIT_MASK_RKC      0x80UL
+	u8	qp_init_offset;
+	u8	srq_init_offset;
+	u8	cq_init_offset;
+	u8	vnic_init_offset;
+	u8	tqm_fp_rings_count;
+	u8	stat_init_offset;
+	u8	mrav_init_offset;
+	u8	tqm_fp_rings_count_ext;
+	u8	tkc_init_offset;
+	u8	rkc_init_offset;
+	__le16	tkc_entry_size;
+	__le16	rkc_entry_size;
+	__le32	tkc_max_entries;
+	__le32	rkc_max_entries;
+	__le16	fast_qpmd_qp_num_entries;
+	u8	rsvd1[5];
+	u8	valid;
+};
+
+/* tqm_fp_ring_cfg (size:128b/16B) */
+struct tqm_fp_ring_cfg {
+	u8	tqm_ring_pg_size_tqm_ring_lvl;
+	#define TQM_FP_RING_CFG_TQM_RING_CFG_TQM_RING_LVL_MASK      0xfUL
+	#define TQM_FP_RING_CFG_TQM_RING_CFG_TQM_RING_LVL_SFT       0
+	#define TQM_FP_RING_CFG_TQM_RING_CFG_TQM_RING_LVL_LVL_0       0x0UL
+	#define TQM_FP_RING_CFG_TQM_RING_CFG_TQM_RING_LVL_LVL_1       0x1UL
+	#define TQM_FP_RING_CFG_TQM_RING_CFG_TQM_RING_LVL_LVL_2       0x2UL
+	#define TQM_FP_RING_CFG_TQM_RING_CFG_TQM_RING_LVL_LAST       TQM_FP_RING_CFG_TQM_RING_CFG_TQM_RING_LVL_LVL_2
+	#define TQM_FP_RING_CFG_TQM_RING_CFG_TQM_RING_PG_SIZE_MASK  0xf0UL
+	#define TQM_FP_RING_CFG_TQM_RING_CFG_TQM_RING_PG_SIZE_SFT   4
+	#define TQM_FP_RING_CFG_TQM_RING_CFG_TQM_RING_PG_SIZE_PG_4K   (0x0UL << 4)
+	#define TQM_FP_RING_CFG_TQM_RING_CFG_TQM_RING_PG_SIZE_PG_8K   (0x1UL << 4)
+	#define TQM_FP_RING_CFG_TQM_RING_CFG_TQM_RING_PG_SIZE_PG_64K  (0x2UL << 4)
+	#define TQM_FP_RING_CFG_TQM_RING_CFG_TQM_RING_PG_SIZE_PG_2M   (0x3UL << 4)
+	#define TQM_FP_RING_CFG_TQM_RING_CFG_TQM_RING_PG_SIZE_PG_8M   (0x4UL << 4)
+	#define TQM_FP_RING_CFG_TQM_RING_CFG_TQM_RING_PG_SIZE_PG_1G   (0x5UL << 4)
+	#define TQM_FP_RING_CFG_TQM_RING_CFG_TQM_RING_PG_SIZE_LAST   TQM_FP_RING_CFG_TQM_RING_CFG_TQM_RING_PG_SIZE_PG_1G
+	u8	unused[3];
+	__le32	tqm_ring_num_entries;
+	__le64	tqm_ring_page_dir;
+};
+
+/* hwrm_func_backing_store_cfg_input (size:2688b/336B) */
+struct hwrm_func_backing_store_cfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	flags;
+	#define FUNC_BACKING_STORE_CFG_REQ_FLAGS_PREBOOT_MODE               0x1UL
+	#define FUNC_BACKING_STORE_CFG_REQ_FLAGS_MRAV_RESERVATION_SPLIT     0x2UL
+	__le32	enables;
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_QP               0x1UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_SRQ              0x2UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_CQ               0x4UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_VNIC             0x8UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_STAT             0x10UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_SP           0x20UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_RING0        0x40UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_RING1        0x80UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_RING2        0x100UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_RING3        0x200UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_RING4        0x400UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_RING5        0x800UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_RING6        0x1000UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_RING7        0x2000UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_MRAV             0x4000UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TIM              0x8000UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_RING8        0x10000UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_RING9        0x20000UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_RING10       0x40000UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TKC              0x80000UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_RKC              0x100000UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_QP_FAST_QPMD     0x200000UL
+	u8	qpc_pg_size_qpc_lvl;
+	#define FUNC_BACKING_STORE_CFG_REQ_QPC_LVL_MASK      0xfUL
+	#define FUNC_BACKING_STORE_CFG_REQ_QPC_LVL_SFT       0
+	#define FUNC_BACKING_STORE_CFG_REQ_QPC_LVL_LVL_0       0x0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_QPC_LVL_LVL_1       0x1UL
+	#define FUNC_BACKING_STORE_CFG_REQ_QPC_LVL_LVL_2       0x2UL
+	#define FUNC_BACKING_STORE_CFG_REQ_QPC_LVL_LAST       FUNC_BACKING_STORE_CFG_REQ_QPC_LVL_LVL_2
+	#define FUNC_BACKING_STORE_CFG_REQ_QPC_PG_SIZE_MASK  0xf0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_QPC_PG_SIZE_SFT   4
+	#define FUNC_BACKING_STORE_CFG_REQ_QPC_PG_SIZE_PG_4K   (0x0UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_QPC_PG_SIZE_PG_8K   (0x1UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_QPC_PG_SIZE_PG_64K  (0x2UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_QPC_PG_SIZE_PG_2M   (0x3UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_QPC_PG_SIZE_PG_8M   (0x4UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_QPC_PG_SIZE_PG_1G   (0x5UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_QPC_PG_SIZE_LAST   FUNC_BACKING_STORE_CFG_REQ_QPC_PG_SIZE_PG_1G
+	u8	srq_pg_size_srq_lvl;
+	#define FUNC_BACKING_STORE_CFG_REQ_SRQ_LVL_MASK      0xfUL
+	#define FUNC_BACKING_STORE_CFG_REQ_SRQ_LVL_SFT       0
+	#define FUNC_BACKING_STORE_CFG_REQ_SRQ_LVL_LVL_0       0x0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_SRQ_LVL_LVL_1       0x1UL
+	#define FUNC_BACKING_STORE_CFG_REQ_SRQ_LVL_LVL_2       0x2UL
+	#define FUNC_BACKING_STORE_CFG_REQ_SRQ_LVL_LAST       FUNC_BACKING_STORE_CFG_REQ_SRQ_LVL_LVL_2
+	#define FUNC_BACKING_STORE_CFG_REQ_SRQ_PG_SIZE_MASK  0xf0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_SRQ_PG_SIZE_SFT   4
+	#define FUNC_BACKING_STORE_CFG_REQ_SRQ_PG_SIZE_PG_4K   (0x0UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_SRQ_PG_SIZE_PG_8K   (0x1UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_SRQ_PG_SIZE_PG_64K  (0x2UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_SRQ_PG_SIZE_PG_2M   (0x3UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_SRQ_PG_SIZE_PG_8M   (0x4UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_SRQ_PG_SIZE_PG_1G   (0x5UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_SRQ_PG_SIZE_LAST   FUNC_BACKING_STORE_CFG_REQ_SRQ_PG_SIZE_PG_1G
+	u8	cq_pg_size_cq_lvl;
+	#define FUNC_BACKING_STORE_CFG_REQ_CQ_LVL_MASK      0xfUL
+	#define FUNC_BACKING_STORE_CFG_REQ_CQ_LVL_SFT       0
+	#define FUNC_BACKING_STORE_CFG_REQ_CQ_LVL_LVL_0       0x0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_CQ_LVL_LVL_1       0x1UL
+	#define FUNC_BACKING_STORE_CFG_REQ_CQ_LVL_LVL_2       0x2UL
+	#define FUNC_BACKING_STORE_CFG_REQ_CQ_LVL_LAST       FUNC_BACKING_STORE_CFG_REQ_CQ_LVL_LVL_2
+	#define FUNC_BACKING_STORE_CFG_REQ_CQ_PG_SIZE_MASK  0xf0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_CQ_PG_SIZE_SFT   4
+	#define FUNC_BACKING_STORE_CFG_REQ_CQ_PG_SIZE_PG_4K   (0x0UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_CQ_PG_SIZE_PG_8K   (0x1UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_CQ_PG_SIZE_PG_64K  (0x2UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_CQ_PG_SIZE_PG_2M   (0x3UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_CQ_PG_SIZE_PG_8M   (0x4UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_CQ_PG_SIZE_PG_1G   (0x5UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_CQ_PG_SIZE_LAST   FUNC_BACKING_STORE_CFG_REQ_CQ_PG_SIZE_PG_1G
+	u8	vnic_pg_size_vnic_lvl;
+	#define FUNC_BACKING_STORE_CFG_REQ_VNIC_LVL_MASK      0xfUL
+	#define FUNC_BACKING_STORE_CFG_REQ_VNIC_LVL_SFT       0
+	#define FUNC_BACKING_STORE_CFG_REQ_VNIC_LVL_LVL_0       0x0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_VNIC_LVL_LVL_1       0x1UL
+	#define FUNC_BACKING_STORE_CFG_REQ_VNIC_LVL_LVL_2       0x2UL
+	#define FUNC_BACKING_STORE_CFG_REQ_VNIC_LVL_LAST       FUNC_BACKING_STORE_CFG_REQ_VNIC_LVL_LVL_2
+	#define FUNC_BACKING_STORE_CFG_REQ_VNIC_PG_SIZE_MASK  0xf0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_VNIC_PG_SIZE_SFT   4
+	#define FUNC_BACKING_STORE_CFG_REQ_VNIC_PG_SIZE_PG_4K   (0x0UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_VNIC_PG_SIZE_PG_8K   (0x1UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_VNIC_PG_SIZE_PG_64K  (0x2UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_VNIC_PG_SIZE_PG_2M   (0x3UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_VNIC_PG_SIZE_PG_8M   (0x4UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_VNIC_PG_SIZE_PG_1G   (0x5UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_VNIC_PG_SIZE_LAST   FUNC_BACKING_STORE_CFG_REQ_VNIC_PG_SIZE_PG_1G
+	u8	stat_pg_size_stat_lvl;
+	#define FUNC_BACKING_STORE_CFG_REQ_STAT_LVL_MASK      0xfUL
+	#define FUNC_BACKING_STORE_CFG_REQ_STAT_LVL_SFT       0
+	#define FUNC_BACKING_STORE_CFG_REQ_STAT_LVL_LVL_0       0x0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_STAT_LVL_LVL_1       0x1UL
+	#define FUNC_BACKING_STORE_CFG_REQ_STAT_LVL_LVL_2       0x2UL
+	#define FUNC_BACKING_STORE_CFG_REQ_STAT_LVL_LAST       FUNC_BACKING_STORE_CFG_REQ_STAT_LVL_LVL_2
+	#define FUNC_BACKING_STORE_CFG_REQ_STAT_PG_SIZE_MASK  0xf0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_STAT_PG_SIZE_SFT   4
+	#define FUNC_BACKING_STORE_CFG_REQ_STAT_PG_SIZE_PG_4K   (0x0UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_STAT_PG_SIZE_PG_8K   (0x1UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_STAT_PG_SIZE_PG_64K  (0x2UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_STAT_PG_SIZE_PG_2M   (0x3UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_STAT_PG_SIZE_PG_8M   (0x4UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_STAT_PG_SIZE_PG_1G   (0x5UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_STAT_PG_SIZE_LAST   FUNC_BACKING_STORE_CFG_REQ_STAT_PG_SIZE_PG_1G
+	u8	tqm_sp_pg_size_tqm_sp_lvl;
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_SP_LVL_MASK      0xfUL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_SP_LVL_SFT       0
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_SP_LVL_LVL_0       0x0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_SP_LVL_LVL_1       0x1UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_SP_LVL_LVL_2       0x2UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_SP_LVL_LAST       FUNC_BACKING_STORE_CFG_REQ_TQM_SP_LVL_LVL_2
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_SP_PG_SIZE_MASK  0xf0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_SP_PG_SIZE_SFT   4
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_SP_PG_SIZE_PG_4K   (0x0UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_SP_PG_SIZE_PG_8K   (0x1UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_SP_PG_SIZE_PG_64K  (0x2UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_SP_PG_SIZE_PG_2M   (0x3UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_SP_PG_SIZE_PG_8M   (0x4UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_SP_PG_SIZE_PG_1G   (0x5UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_SP_PG_SIZE_LAST   FUNC_BACKING_STORE_CFG_REQ_TQM_SP_PG_SIZE_PG_1G
+	u8	tqm_ring0_pg_size_tqm_ring0_lvl;
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING0_LVL_MASK      0xfUL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING0_LVL_SFT       0
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING0_LVL_LVL_0       0x0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING0_LVL_LVL_1       0x1UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING0_LVL_LVL_2       0x2UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING0_LVL_LAST       FUNC_BACKING_STORE_CFG_REQ_TQM_RING0_LVL_LVL_2
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING0_PG_SIZE_MASK  0xf0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING0_PG_SIZE_SFT   4
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING0_PG_SIZE_PG_4K   (0x0UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING0_PG_SIZE_PG_8K   (0x1UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING0_PG_SIZE_PG_64K  (0x2UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING0_PG_SIZE_PG_2M   (0x3UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING0_PG_SIZE_PG_8M   (0x4UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING0_PG_SIZE_PG_1G   (0x5UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING0_PG_SIZE_LAST   FUNC_BACKING_STORE_CFG_REQ_TQM_RING0_PG_SIZE_PG_1G
+	u8	tqm_ring1_pg_size_tqm_ring1_lvl;
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING1_LVL_MASK      0xfUL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING1_LVL_SFT       0
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING1_LVL_LVL_0       0x0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING1_LVL_LVL_1       0x1UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING1_LVL_LVL_2       0x2UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING1_LVL_LAST       FUNC_BACKING_STORE_CFG_REQ_TQM_RING1_LVL_LVL_2
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING1_PG_SIZE_MASK  0xf0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING1_PG_SIZE_SFT   4
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING1_PG_SIZE_PG_4K   (0x0UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING1_PG_SIZE_PG_8K   (0x1UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING1_PG_SIZE_PG_64K  (0x2UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING1_PG_SIZE_PG_2M   (0x3UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING1_PG_SIZE_PG_8M   (0x4UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING1_PG_SIZE_PG_1G   (0x5UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING1_PG_SIZE_LAST   FUNC_BACKING_STORE_CFG_REQ_TQM_RING1_PG_SIZE_PG_1G
+	u8	tqm_ring2_pg_size_tqm_ring2_lvl;
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING2_LVL_MASK      0xfUL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING2_LVL_SFT       0
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING2_LVL_LVL_0       0x0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING2_LVL_LVL_1       0x1UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING2_LVL_LVL_2       0x2UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING2_LVL_LAST       FUNC_BACKING_STORE_CFG_REQ_TQM_RING2_LVL_LVL_2
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING2_PG_SIZE_MASK  0xf0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING2_PG_SIZE_SFT   4
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING2_PG_SIZE_PG_4K   (0x0UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING2_PG_SIZE_PG_8K   (0x1UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING2_PG_SIZE_PG_64K  (0x2UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING2_PG_SIZE_PG_2M   (0x3UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING2_PG_SIZE_PG_8M   (0x4UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING2_PG_SIZE_PG_1G   (0x5UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING2_PG_SIZE_LAST   FUNC_BACKING_STORE_CFG_REQ_TQM_RING2_PG_SIZE_PG_1G
+	u8	tqm_ring3_pg_size_tqm_ring3_lvl;
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING3_LVL_MASK      0xfUL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING3_LVL_SFT       0
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING3_LVL_LVL_0       0x0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING3_LVL_LVL_1       0x1UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING3_LVL_LVL_2       0x2UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING3_LVL_LAST       FUNC_BACKING_STORE_CFG_REQ_TQM_RING3_LVL_LVL_2
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING3_PG_SIZE_MASK  0xf0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING3_PG_SIZE_SFT   4
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING3_PG_SIZE_PG_4K   (0x0UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING3_PG_SIZE_PG_8K   (0x1UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING3_PG_SIZE_PG_64K  (0x2UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING3_PG_SIZE_PG_2M   (0x3UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING3_PG_SIZE_PG_8M   (0x4UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING3_PG_SIZE_PG_1G   (0x5UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING3_PG_SIZE_LAST   FUNC_BACKING_STORE_CFG_REQ_TQM_RING3_PG_SIZE_PG_1G
+	u8	tqm_ring4_pg_size_tqm_ring4_lvl;
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING4_LVL_MASK      0xfUL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING4_LVL_SFT       0
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING4_LVL_LVL_0       0x0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING4_LVL_LVL_1       0x1UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING4_LVL_LVL_2       0x2UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING4_LVL_LAST       FUNC_BACKING_STORE_CFG_REQ_TQM_RING4_LVL_LVL_2
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING4_PG_SIZE_MASK  0xf0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING4_PG_SIZE_SFT   4
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING4_PG_SIZE_PG_4K   (0x0UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING4_PG_SIZE_PG_8K   (0x1UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING4_PG_SIZE_PG_64K  (0x2UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING4_PG_SIZE_PG_2M   (0x3UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING4_PG_SIZE_PG_8M   (0x4UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING4_PG_SIZE_PG_1G   (0x5UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING4_PG_SIZE_LAST   FUNC_BACKING_STORE_CFG_REQ_TQM_RING4_PG_SIZE_PG_1G
+	u8	tqm_ring5_pg_size_tqm_ring5_lvl;
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING5_LVL_MASK      0xfUL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING5_LVL_SFT       0
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING5_LVL_LVL_0       0x0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING5_LVL_LVL_1       0x1UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING5_LVL_LVL_2       0x2UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING5_LVL_LAST       FUNC_BACKING_STORE_CFG_REQ_TQM_RING5_LVL_LVL_2
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING5_PG_SIZE_MASK  0xf0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING5_PG_SIZE_SFT   4
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING5_PG_SIZE_PG_4K   (0x0UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING5_PG_SIZE_PG_8K   (0x1UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING5_PG_SIZE_PG_64K  (0x2UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING5_PG_SIZE_PG_2M   (0x3UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING5_PG_SIZE_PG_8M   (0x4UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING5_PG_SIZE_PG_1G   (0x5UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING5_PG_SIZE_LAST   FUNC_BACKING_STORE_CFG_REQ_TQM_RING5_PG_SIZE_PG_1G
+	u8	tqm_ring6_pg_size_tqm_ring6_lvl;
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING6_LVL_MASK      0xfUL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING6_LVL_SFT       0
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING6_LVL_LVL_0       0x0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING6_LVL_LVL_1       0x1UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING6_LVL_LVL_2       0x2UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING6_LVL_LAST       FUNC_BACKING_STORE_CFG_REQ_TQM_RING6_LVL_LVL_2
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING6_PG_SIZE_MASK  0xf0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING6_PG_SIZE_SFT   4
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING6_PG_SIZE_PG_4K   (0x0UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING6_PG_SIZE_PG_8K   (0x1UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING6_PG_SIZE_PG_64K  (0x2UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING6_PG_SIZE_PG_2M   (0x3UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING6_PG_SIZE_PG_8M   (0x4UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING6_PG_SIZE_PG_1G   (0x5UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING6_PG_SIZE_LAST   FUNC_BACKING_STORE_CFG_REQ_TQM_RING6_PG_SIZE_PG_1G
+	u8	tqm_ring7_pg_size_tqm_ring7_lvl;
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING7_LVL_MASK      0xfUL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING7_LVL_SFT       0
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING7_LVL_LVL_0       0x0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING7_LVL_LVL_1       0x1UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING7_LVL_LVL_2       0x2UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING7_LVL_LAST       FUNC_BACKING_STORE_CFG_REQ_TQM_RING7_LVL_LVL_2
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING7_PG_SIZE_MASK  0xf0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING7_PG_SIZE_SFT   4
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING7_PG_SIZE_PG_4K   (0x0UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING7_PG_SIZE_PG_8K   (0x1UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING7_PG_SIZE_PG_64K  (0x2UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING7_PG_SIZE_PG_2M   (0x3UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING7_PG_SIZE_PG_8M   (0x4UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING7_PG_SIZE_PG_1G   (0x5UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TQM_RING7_PG_SIZE_LAST   FUNC_BACKING_STORE_CFG_REQ_TQM_RING7_PG_SIZE_PG_1G
+	u8	mrav_pg_size_mrav_lvl;
+	#define FUNC_BACKING_STORE_CFG_REQ_MRAV_LVL_MASK      0xfUL
+	#define FUNC_BACKING_STORE_CFG_REQ_MRAV_LVL_SFT       0
+	#define FUNC_BACKING_STORE_CFG_REQ_MRAV_LVL_LVL_0       0x0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_MRAV_LVL_LVL_1       0x1UL
+	#define FUNC_BACKING_STORE_CFG_REQ_MRAV_LVL_LVL_2       0x2UL
+	#define FUNC_BACKING_STORE_CFG_REQ_MRAV_LVL_LAST       FUNC_BACKING_STORE_CFG_REQ_MRAV_LVL_LVL_2
+	#define FUNC_BACKING_STORE_CFG_REQ_MRAV_PG_SIZE_MASK  0xf0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_MRAV_PG_SIZE_SFT   4
+	#define FUNC_BACKING_STORE_CFG_REQ_MRAV_PG_SIZE_PG_4K   (0x0UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_MRAV_PG_SIZE_PG_8K   (0x1UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_MRAV_PG_SIZE_PG_64K  (0x2UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_MRAV_PG_SIZE_PG_2M   (0x3UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_MRAV_PG_SIZE_PG_8M   (0x4UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_MRAV_PG_SIZE_PG_1G   (0x5UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_MRAV_PG_SIZE_LAST   FUNC_BACKING_STORE_CFG_REQ_MRAV_PG_SIZE_PG_1G
+	u8	tim_pg_size_tim_lvl;
+	#define FUNC_BACKING_STORE_CFG_REQ_TIM_LVL_MASK      0xfUL
+	#define FUNC_BACKING_STORE_CFG_REQ_TIM_LVL_SFT       0
+	#define FUNC_BACKING_STORE_CFG_REQ_TIM_LVL_LVL_0       0x0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TIM_LVL_LVL_1       0x1UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TIM_LVL_LVL_2       0x2UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TIM_LVL_LAST       FUNC_BACKING_STORE_CFG_REQ_TIM_LVL_LVL_2
+	#define FUNC_BACKING_STORE_CFG_REQ_TIM_PG_SIZE_MASK  0xf0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TIM_PG_SIZE_SFT   4
+	#define FUNC_BACKING_STORE_CFG_REQ_TIM_PG_SIZE_PG_4K   (0x0UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TIM_PG_SIZE_PG_8K   (0x1UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TIM_PG_SIZE_PG_64K  (0x2UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TIM_PG_SIZE_PG_2M   (0x3UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TIM_PG_SIZE_PG_8M   (0x4UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TIM_PG_SIZE_PG_1G   (0x5UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TIM_PG_SIZE_LAST   FUNC_BACKING_STORE_CFG_REQ_TIM_PG_SIZE_PG_1G
+	__le64	qpc_page_dir;
+	__le64	srq_page_dir;
+	__le64	cq_page_dir;
+	__le64	vnic_page_dir;
+	__le64	stat_page_dir;
+	__le64	tqm_sp_page_dir;
+	__le64	tqm_ring0_page_dir;
+	__le64	tqm_ring1_page_dir;
+	__le64	tqm_ring2_page_dir;
+	__le64	tqm_ring3_page_dir;
+	__le64	tqm_ring4_page_dir;
+	__le64	tqm_ring5_page_dir;
+	__le64	tqm_ring6_page_dir;
+	__le64	tqm_ring7_page_dir;
+	__le64	mrav_page_dir;
+	__le64	tim_page_dir;
+	__le32	qp_num_entries;
+	__le32	srq_num_entries;
+	__le32	cq_num_entries;
+	__le32	stat_num_entries;
+	__le32	tqm_sp_num_entries;
+	__le32	tqm_ring0_num_entries;
+	__le32	tqm_ring1_num_entries;
+	__le32	tqm_ring2_num_entries;
+	__le32	tqm_ring3_num_entries;
+	__le32	tqm_ring4_num_entries;
+	__le32	tqm_ring5_num_entries;
+	__le32	tqm_ring6_num_entries;
+	__le32	tqm_ring7_num_entries;
+	__le32	mrav_num_entries;
+	__le32	tim_num_entries;
+	__le16	qp_num_qp1_entries;
+	__le16	qp_num_l2_entries;
+	__le16	qp_entry_size;
+	__le16	srq_num_l2_entries;
+	__le16	srq_entry_size;
+	__le16	cq_num_l2_entries;
+	__le16	cq_entry_size;
+	__le16	vnic_num_vnic_entries;
+	__le16	vnic_num_ring_table_entries;
+	__le16	vnic_entry_size;
+	__le16	stat_entry_size;
+	__le16	tqm_entry_size;
+	__le16	mrav_entry_size;
+	__le16	tim_entry_size;
+	u8	tqm_ring8_pg_size_tqm_ring_lvl;
+	#define FUNC_BACKING_STORE_CFG_REQ_RING8_TQM_RING_LVL_MASK      0xfUL
+	#define FUNC_BACKING_STORE_CFG_REQ_RING8_TQM_RING_LVL_SFT       0
+	#define FUNC_BACKING_STORE_CFG_REQ_RING8_TQM_RING_LVL_LVL_0       0x0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_RING8_TQM_RING_LVL_LVL_1       0x1UL
+	#define FUNC_BACKING_STORE_CFG_REQ_RING8_TQM_RING_LVL_LVL_2       0x2UL
+	#define FUNC_BACKING_STORE_CFG_REQ_RING8_TQM_RING_LVL_LAST       FUNC_BACKING_STORE_CFG_REQ_RING8_TQM_RING_LVL_LVL_2
+	#define FUNC_BACKING_STORE_CFG_REQ_RING8_TQM_RING_PG_SIZE_MASK  0xf0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_RING8_TQM_RING_PG_SIZE_SFT   4
+	#define FUNC_BACKING_STORE_CFG_REQ_RING8_TQM_RING_PG_SIZE_PG_4K   (0x0UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_RING8_TQM_RING_PG_SIZE_PG_8K   (0x1UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_RING8_TQM_RING_PG_SIZE_PG_64K  (0x2UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_RING8_TQM_RING_PG_SIZE_PG_2M   (0x3UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_RING8_TQM_RING_PG_SIZE_PG_8M   (0x4UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_RING8_TQM_RING_PG_SIZE_PG_1G   (0x5UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_RING8_TQM_RING_PG_SIZE_LAST   FUNC_BACKING_STORE_CFG_REQ_RING8_TQM_RING_PG_SIZE_PG_1G
+	u8	ring8_unused[3];
+	__le32	tqm_ring8_num_entries;
+	__le64	tqm_ring8_page_dir;
+	u8	tqm_ring9_pg_size_tqm_ring_lvl;
+	#define FUNC_BACKING_STORE_CFG_REQ_RING9_TQM_RING_LVL_MASK      0xfUL
+	#define FUNC_BACKING_STORE_CFG_REQ_RING9_TQM_RING_LVL_SFT       0
+	#define FUNC_BACKING_STORE_CFG_REQ_RING9_TQM_RING_LVL_LVL_0       0x0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_RING9_TQM_RING_LVL_LVL_1       0x1UL
+	#define FUNC_BACKING_STORE_CFG_REQ_RING9_TQM_RING_LVL_LVL_2       0x2UL
+	#define FUNC_BACKING_STORE_CFG_REQ_RING9_TQM_RING_LVL_LAST       FUNC_BACKING_STORE_CFG_REQ_RING9_TQM_RING_LVL_LVL_2
+	#define FUNC_BACKING_STORE_CFG_REQ_RING9_TQM_RING_PG_SIZE_MASK  0xf0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_RING9_TQM_RING_PG_SIZE_SFT   4
+	#define FUNC_BACKING_STORE_CFG_REQ_RING9_TQM_RING_PG_SIZE_PG_4K   (0x0UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_RING9_TQM_RING_PG_SIZE_PG_8K   (0x1UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_RING9_TQM_RING_PG_SIZE_PG_64K  (0x2UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_RING9_TQM_RING_PG_SIZE_PG_2M   (0x3UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_RING9_TQM_RING_PG_SIZE_PG_8M   (0x4UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_RING9_TQM_RING_PG_SIZE_PG_1G   (0x5UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_RING9_TQM_RING_PG_SIZE_LAST   FUNC_BACKING_STORE_CFG_REQ_RING9_TQM_RING_PG_SIZE_PG_1G
+	u8	ring9_unused[3];
+	__le32	tqm_ring9_num_entries;
+	__le64	tqm_ring9_page_dir;
+	u8	tqm_ring10_pg_size_tqm_ring_lvl;
+	#define FUNC_BACKING_STORE_CFG_REQ_RING10_TQM_RING_LVL_MASK      0xfUL
+	#define FUNC_BACKING_STORE_CFG_REQ_RING10_TQM_RING_LVL_SFT       0
+	#define FUNC_BACKING_STORE_CFG_REQ_RING10_TQM_RING_LVL_LVL_0       0x0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_RING10_TQM_RING_LVL_LVL_1       0x1UL
+	#define FUNC_BACKING_STORE_CFG_REQ_RING10_TQM_RING_LVL_LVL_2       0x2UL
+	#define FUNC_BACKING_STORE_CFG_REQ_RING10_TQM_RING_LVL_LAST       FUNC_BACKING_STORE_CFG_REQ_RING10_TQM_RING_LVL_LVL_2
+	#define FUNC_BACKING_STORE_CFG_REQ_RING10_TQM_RING_PG_SIZE_MASK  0xf0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_RING10_TQM_RING_PG_SIZE_SFT   4
+	#define FUNC_BACKING_STORE_CFG_REQ_RING10_TQM_RING_PG_SIZE_PG_4K   (0x0UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_RING10_TQM_RING_PG_SIZE_PG_8K   (0x1UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_RING10_TQM_RING_PG_SIZE_PG_64K  (0x2UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_RING10_TQM_RING_PG_SIZE_PG_2M   (0x3UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_RING10_TQM_RING_PG_SIZE_PG_8M   (0x4UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_RING10_TQM_RING_PG_SIZE_PG_1G   (0x5UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_RING10_TQM_RING_PG_SIZE_LAST   FUNC_BACKING_STORE_CFG_REQ_RING10_TQM_RING_PG_SIZE_PG_1G
+	u8	ring10_unused[3];
+	__le32	tqm_ring10_num_entries;
+	__le64	tqm_ring10_page_dir;
+	__le32	tkc_num_entries;
+	__le32	rkc_num_entries;
+	__le64	tkc_page_dir;
+	__le64	rkc_page_dir;
+	__le16	tkc_entry_size;
+	__le16	rkc_entry_size;
+	u8	tkc_pg_size_tkc_lvl;
+	#define FUNC_BACKING_STORE_CFG_REQ_TKC_LVL_MASK      0xfUL
+	#define FUNC_BACKING_STORE_CFG_REQ_TKC_LVL_SFT       0
+	#define FUNC_BACKING_STORE_CFG_REQ_TKC_LVL_LVL_0       0x0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TKC_LVL_LVL_1       0x1UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TKC_LVL_LVL_2       0x2UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TKC_LVL_LAST       FUNC_BACKING_STORE_CFG_REQ_TKC_LVL_LVL_2
+	#define FUNC_BACKING_STORE_CFG_REQ_TKC_PG_SIZE_MASK  0xf0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_TKC_PG_SIZE_SFT   4
+	#define FUNC_BACKING_STORE_CFG_REQ_TKC_PG_SIZE_PG_4K   (0x0UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TKC_PG_SIZE_PG_8K   (0x1UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TKC_PG_SIZE_PG_64K  (0x2UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TKC_PG_SIZE_PG_2M   (0x3UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TKC_PG_SIZE_PG_8M   (0x4UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TKC_PG_SIZE_PG_1G   (0x5UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_TKC_PG_SIZE_LAST   FUNC_BACKING_STORE_CFG_REQ_TKC_PG_SIZE_PG_1G
+	u8	rkc_pg_size_rkc_lvl;
+	#define FUNC_BACKING_STORE_CFG_REQ_RKC_LVL_MASK      0xfUL
+	#define FUNC_BACKING_STORE_CFG_REQ_RKC_LVL_SFT       0
+	#define FUNC_BACKING_STORE_CFG_REQ_RKC_LVL_LVL_0       0x0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_RKC_LVL_LVL_1       0x1UL
+	#define FUNC_BACKING_STORE_CFG_REQ_RKC_LVL_LVL_2       0x2UL
+	#define FUNC_BACKING_STORE_CFG_REQ_RKC_LVL_LAST       FUNC_BACKING_STORE_CFG_REQ_RKC_LVL_LVL_2
+	#define FUNC_BACKING_STORE_CFG_REQ_RKC_PG_SIZE_MASK  0xf0UL
+	#define FUNC_BACKING_STORE_CFG_REQ_RKC_PG_SIZE_SFT   4
+	#define FUNC_BACKING_STORE_CFG_REQ_RKC_PG_SIZE_PG_4K   (0x0UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_RKC_PG_SIZE_PG_8K   (0x1UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_RKC_PG_SIZE_PG_64K  (0x2UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_RKC_PG_SIZE_PG_2M   (0x3UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_RKC_PG_SIZE_PG_8M   (0x4UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_RKC_PG_SIZE_PG_1G   (0x5UL << 4)
+	#define FUNC_BACKING_STORE_CFG_REQ_RKC_PG_SIZE_LAST   FUNC_BACKING_STORE_CFG_REQ_RKC_PG_SIZE_PG_1G
+	__le16	qp_num_fast_qpmd_entries;
+};
+
+/* hwrm_func_backing_store_cfg_output (size:128b/16B) */
+struct hwrm_func_backing_store_cfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_error_recovery_qcfg_input (size:192b/24B) */
+struct hwrm_error_recovery_qcfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	u8	unused_0[8];
+};
+
+/* hwrm_error_recovery_qcfg_output (size:1664b/208B) */
+struct hwrm_error_recovery_qcfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le32	flags;
+	#define ERROR_RECOVERY_QCFG_RESP_FLAGS_HOST       0x1UL
+	#define ERROR_RECOVERY_QCFG_RESP_FLAGS_CO_CPU     0x2UL
+	__le32	driver_polling_freq;
+	__le32	master_func_wait_period;
+	__le32	normal_func_wait_period;
+	__le32	master_func_wait_period_after_reset;
+	__le32	max_bailout_time_after_reset;
+	__le32	fw_health_status_reg;
+	#define ERROR_RECOVERY_QCFG_RESP_FW_HEALTH_STATUS_REG_ADDR_SPACE_MASK    0x3UL
+	#define ERROR_RECOVERY_QCFG_RESP_FW_HEALTH_STATUS_REG_ADDR_SPACE_SFT     0
+	#define ERROR_RECOVERY_QCFG_RESP_FW_HEALTH_STATUS_REG_ADDR_SPACE_PCIE_CFG  0x0UL
+	#define ERROR_RECOVERY_QCFG_RESP_FW_HEALTH_STATUS_REG_ADDR_SPACE_GRC       0x1UL
+	#define ERROR_RECOVERY_QCFG_RESP_FW_HEALTH_STATUS_REG_ADDR_SPACE_BAR0      0x2UL
+	#define ERROR_RECOVERY_QCFG_RESP_FW_HEALTH_STATUS_REG_ADDR_SPACE_BAR1      0x3UL
+	#define ERROR_RECOVERY_QCFG_RESP_FW_HEALTH_STATUS_REG_ADDR_SPACE_LAST     ERROR_RECOVERY_QCFG_RESP_FW_HEALTH_STATUS_REG_ADDR_SPACE_BAR1
+	#define ERROR_RECOVERY_QCFG_RESP_FW_HEALTH_STATUS_REG_ADDR_MASK          0xfffffffcUL
+	#define ERROR_RECOVERY_QCFG_RESP_FW_HEALTH_STATUS_REG_ADDR_SFT           2
+	__le32	fw_heartbeat_reg;
+	#define ERROR_RECOVERY_QCFG_RESP_FW_HEARTBEAT_REG_ADDR_SPACE_MASK    0x3UL
+	#define ERROR_RECOVERY_QCFG_RESP_FW_HEARTBEAT_REG_ADDR_SPACE_SFT     0
+	#define ERROR_RECOVERY_QCFG_RESP_FW_HEARTBEAT_REG_ADDR_SPACE_PCIE_CFG  0x0UL
+	#define ERROR_RECOVERY_QCFG_RESP_FW_HEARTBEAT_REG_ADDR_SPACE_GRC       0x1UL
+	#define ERROR_RECOVERY_QCFG_RESP_FW_HEARTBEAT_REG_ADDR_SPACE_BAR0      0x2UL
+	#define ERROR_RECOVERY_QCFG_RESP_FW_HEARTBEAT_REG_ADDR_SPACE_BAR1      0x3UL
+	#define ERROR_RECOVERY_QCFG_RESP_FW_HEARTBEAT_REG_ADDR_SPACE_LAST     ERROR_RECOVERY_QCFG_RESP_FW_HEARTBEAT_REG_ADDR_SPACE_BAR1
+	#define ERROR_RECOVERY_QCFG_RESP_FW_HEARTBEAT_REG_ADDR_MASK          0xfffffffcUL
+	#define ERROR_RECOVERY_QCFG_RESP_FW_HEARTBEAT_REG_ADDR_SFT           2
+	__le32	fw_reset_cnt_reg;
+	#define ERROR_RECOVERY_QCFG_RESP_FW_RESET_CNT_REG_ADDR_SPACE_MASK    0x3UL
+	#define ERROR_RECOVERY_QCFG_RESP_FW_RESET_CNT_REG_ADDR_SPACE_SFT     0
+	#define ERROR_RECOVERY_QCFG_RESP_FW_RESET_CNT_REG_ADDR_SPACE_PCIE_CFG  0x0UL
+	#define ERROR_RECOVERY_QCFG_RESP_FW_RESET_CNT_REG_ADDR_SPACE_GRC       0x1UL
+	#define ERROR_RECOVERY_QCFG_RESP_FW_RESET_CNT_REG_ADDR_SPACE_BAR0      0x2UL
+	#define ERROR_RECOVERY_QCFG_RESP_FW_RESET_CNT_REG_ADDR_SPACE_BAR1      0x3UL
+	#define ERROR_RECOVERY_QCFG_RESP_FW_RESET_CNT_REG_ADDR_SPACE_LAST     ERROR_RECOVERY_QCFG_RESP_FW_RESET_CNT_REG_ADDR_SPACE_BAR1
+	#define ERROR_RECOVERY_QCFG_RESP_FW_RESET_CNT_REG_ADDR_MASK          0xfffffffcUL
+	#define ERROR_RECOVERY_QCFG_RESP_FW_RESET_CNT_REG_ADDR_SFT           2
+	__le32	reset_inprogress_reg;
+	#define ERROR_RECOVERY_QCFG_RESP_RESET_INPROGRESS_REG_ADDR_SPACE_MASK    0x3UL
+	#define ERROR_RECOVERY_QCFG_RESP_RESET_INPROGRESS_REG_ADDR_SPACE_SFT     0
+	#define ERROR_RECOVERY_QCFG_RESP_RESET_INPROGRESS_REG_ADDR_SPACE_PCIE_CFG  0x0UL
+	#define ERROR_RECOVERY_QCFG_RESP_RESET_INPROGRESS_REG_ADDR_SPACE_GRC       0x1UL
+	#define ERROR_RECOVERY_QCFG_RESP_RESET_INPROGRESS_REG_ADDR_SPACE_BAR0      0x2UL
+	#define ERROR_RECOVERY_QCFG_RESP_RESET_INPROGRESS_REG_ADDR_SPACE_BAR1      0x3UL
+	#define ERROR_RECOVERY_QCFG_RESP_RESET_INPROGRESS_REG_ADDR_SPACE_LAST     ERROR_RECOVERY_QCFG_RESP_RESET_INPROGRESS_REG_ADDR_SPACE_BAR1
+	#define ERROR_RECOVERY_QCFG_RESP_RESET_INPROGRESS_REG_ADDR_MASK          0xfffffffcUL
+	#define ERROR_RECOVERY_QCFG_RESP_RESET_INPROGRESS_REG_ADDR_SFT           2
+	__le32	reset_inprogress_reg_mask;
+	u8	unused_0[3];
+	u8	reg_array_cnt;
+	__le32	reset_reg[16];
+	#define ERROR_RECOVERY_QCFG_RESP_RESET_REG_ADDR_SPACE_MASK    0x3UL
+	#define ERROR_RECOVERY_QCFG_RESP_RESET_REG_ADDR_SPACE_SFT     0
+	#define ERROR_RECOVERY_QCFG_RESP_RESET_REG_ADDR_SPACE_PCIE_CFG  0x0UL
+	#define ERROR_RECOVERY_QCFG_RESP_RESET_REG_ADDR_SPACE_GRC       0x1UL
+	#define ERROR_RECOVERY_QCFG_RESP_RESET_REG_ADDR_SPACE_BAR0      0x2UL
+	#define ERROR_RECOVERY_QCFG_RESP_RESET_REG_ADDR_SPACE_BAR1      0x3UL
+	#define ERROR_RECOVERY_QCFG_RESP_RESET_REG_ADDR_SPACE_LAST     ERROR_RECOVERY_QCFG_RESP_RESET_REG_ADDR_SPACE_BAR1
+	#define ERROR_RECOVERY_QCFG_RESP_RESET_REG_ADDR_MASK          0xfffffffcUL
+	#define ERROR_RECOVERY_QCFG_RESP_RESET_REG_ADDR_SFT           2
+	__le32	reset_reg_val[16];
+	u8	delay_after_reset[16];
+	__le32	err_recovery_cnt_reg;
+	#define ERROR_RECOVERY_QCFG_RESP_ERR_RECOVERY_CNT_REG_ADDR_SPACE_MASK    0x3UL
+	#define ERROR_RECOVERY_QCFG_RESP_ERR_RECOVERY_CNT_REG_ADDR_SPACE_SFT     0
+	#define ERROR_RECOVERY_QCFG_RESP_ERR_RECOVERY_CNT_REG_ADDR_SPACE_PCIE_CFG  0x0UL
+	#define ERROR_RECOVERY_QCFG_RESP_ERR_RECOVERY_CNT_REG_ADDR_SPACE_GRC       0x1UL
+	#define ERROR_RECOVERY_QCFG_RESP_ERR_RECOVERY_CNT_REG_ADDR_SPACE_BAR0      0x2UL
+	#define ERROR_RECOVERY_QCFG_RESP_ERR_RECOVERY_CNT_REG_ADDR_SPACE_BAR1      0x3UL
+	#define ERROR_RECOVERY_QCFG_RESP_ERR_RECOVERY_CNT_REG_ADDR_SPACE_LAST     ERROR_RECOVERY_QCFG_RESP_ERR_RECOVERY_CNT_REG_ADDR_SPACE_BAR1
+	#define ERROR_RECOVERY_QCFG_RESP_ERR_RECOVERY_CNT_REG_ADDR_MASK          0xfffffffcUL
+	#define ERROR_RECOVERY_QCFG_RESP_ERR_RECOVERY_CNT_REG_ADDR_SFT           2
+	u8	unused_1[3];
+	u8	valid;
+};
+
+/* hwrm_func_echo_response_input (size:192b/24B) */
+struct hwrm_func_echo_response_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	event_data1;
+	__le32	event_data2;
+};
+
+/* hwrm_func_echo_response_output (size:128b/16B) */
+struct hwrm_func_echo_response_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_func_ptp_pin_qcfg_input (size:192b/24B) */
+struct hwrm_func_ptp_pin_qcfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	u8	unused_0[8];
+};
+
+/* hwrm_func_ptp_pin_qcfg_output (size:128b/16B) */
+struct hwrm_func_ptp_pin_qcfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	num_pins;
+	u8	state;
+	#define FUNC_PTP_PIN_QCFG_RESP_STATE_PIN0_ENABLED     0x1UL
+	#define FUNC_PTP_PIN_QCFG_RESP_STATE_PIN1_ENABLED     0x2UL
+	#define FUNC_PTP_PIN_QCFG_RESP_STATE_PIN2_ENABLED     0x4UL
+	#define FUNC_PTP_PIN_QCFG_RESP_STATE_PIN3_ENABLED     0x8UL
+	u8	pin0_usage;
+	#define FUNC_PTP_PIN_QCFG_RESP_PIN0_USAGE_NONE     0x0UL
+	#define FUNC_PTP_PIN_QCFG_RESP_PIN0_USAGE_PPS_IN   0x1UL
+	#define FUNC_PTP_PIN_QCFG_RESP_PIN0_USAGE_PPS_OUT  0x2UL
+	#define FUNC_PTP_PIN_QCFG_RESP_PIN0_USAGE_SYNC_IN  0x3UL
+	#define FUNC_PTP_PIN_QCFG_RESP_PIN0_USAGE_SYNC_OUT 0x4UL
+	#define FUNC_PTP_PIN_QCFG_RESP_PIN0_USAGE_LAST    FUNC_PTP_PIN_QCFG_RESP_PIN0_USAGE_SYNC_OUT
+	u8	pin1_usage;
+	#define FUNC_PTP_PIN_QCFG_RESP_PIN1_USAGE_NONE     0x0UL
+	#define FUNC_PTP_PIN_QCFG_RESP_PIN1_USAGE_PPS_IN   0x1UL
+	#define FUNC_PTP_PIN_QCFG_RESP_PIN1_USAGE_PPS_OUT  0x2UL
+	#define FUNC_PTP_PIN_QCFG_RESP_PIN1_USAGE_SYNC_IN  0x3UL
+	#define FUNC_PTP_PIN_QCFG_RESP_PIN1_USAGE_SYNC_OUT 0x4UL
+	#define FUNC_PTP_PIN_QCFG_RESP_PIN1_USAGE_LAST    FUNC_PTP_PIN_QCFG_RESP_PIN1_USAGE_SYNC_OUT
+	u8	pin2_usage;
+	#define FUNC_PTP_PIN_QCFG_RESP_PIN2_USAGE_NONE                      0x0UL
+	#define FUNC_PTP_PIN_QCFG_RESP_PIN2_USAGE_PPS_IN                    0x1UL
+	#define FUNC_PTP_PIN_QCFG_RESP_PIN2_USAGE_PPS_OUT                   0x2UL
+	#define FUNC_PTP_PIN_QCFG_RESP_PIN2_USAGE_SYNC_IN                   0x3UL
+	#define FUNC_PTP_PIN_QCFG_RESP_PIN2_USAGE_SYNC_OUT                  0x4UL
+	#define FUNC_PTP_PIN_QCFG_RESP_PIN2_USAGE_SYNCE_PRIMARY_CLOCK_OUT   0x5UL
+	#define FUNC_PTP_PIN_QCFG_RESP_PIN2_USAGE_SYNCE_SECONDARY_CLOCK_OUT 0x6UL
+	#define FUNC_PTP_PIN_QCFG_RESP_PIN2_USAGE_LAST                     FUNC_PTP_PIN_QCFG_RESP_PIN2_USAGE_SYNCE_SECONDARY_CLOCK_OUT
+	u8	pin3_usage;
+	#define FUNC_PTP_PIN_QCFG_RESP_PIN3_USAGE_NONE                      0x0UL
+	#define FUNC_PTP_PIN_QCFG_RESP_PIN3_USAGE_PPS_IN                    0x1UL
+	#define FUNC_PTP_PIN_QCFG_RESP_PIN3_USAGE_PPS_OUT                   0x2UL
+	#define FUNC_PTP_PIN_QCFG_RESP_PIN3_USAGE_SYNC_IN                   0x3UL
+	#define FUNC_PTP_PIN_QCFG_RESP_PIN3_USAGE_SYNC_OUT                  0x4UL
+	#define FUNC_PTP_PIN_QCFG_RESP_PIN3_USAGE_SYNCE_PRIMARY_CLOCK_OUT   0x5UL
+	#define FUNC_PTP_PIN_QCFG_RESP_PIN3_USAGE_SYNCE_SECONDARY_CLOCK_OUT 0x6UL
+	#define FUNC_PTP_PIN_QCFG_RESP_PIN3_USAGE_LAST                     FUNC_PTP_PIN_QCFG_RESP_PIN3_USAGE_SYNCE_SECONDARY_CLOCK_OUT
+	u8	unused_0;
+	u8	valid;
+};
+
+/* hwrm_func_ptp_pin_cfg_input (size:256b/32B) */
+struct hwrm_func_ptp_pin_cfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	enables;
+	#define FUNC_PTP_PIN_CFG_REQ_ENABLES_PIN0_STATE     0x1UL
+	#define FUNC_PTP_PIN_CFG_REQ_ENABLES_PIN0_USAGE     0x2UL
+	#define FUNC_PTP_PIN_CFG_REQ_ENABLES_PIN1_STATE     0x4UL
+	#define FUNC_PTP_PIN_CFG_REQ_ENABLES_PIN1_USAGE     0x8UL
+	#define FUNC_PTP_PIN_CFG_REQ_ENABLES_PIN2_STATE     0x10UL
+	#define FUNC_PTP_PIN_CFG_REQ_ENABLES_PIN2_USAGE     0x20UL
+	#define FUNC_PTP_PIN_CFG_REQ_ENABLES_PIN3_STATE     0x40UL
+	#define FUNC_PTP_PIN_CFG_REQ_ENABLES_PIN3_USAGE     0x80UL
+	u8	pin0_state;
+	#define FUNC_PTP_PIN_CFG_REQ_PIN0_STATE_DISABLED 0x0UL
+	#define FUNC_PTP_PIN_CFG_REQ_PIN0_STATE_ENABLED  0x1UL
+	#define FUNC_PTP_PIN_CFG_REQ_PIN0_STATE_LAST    FUNC_PTP_PIN_CFG_REQ_PIN0_STATE_ENABLED
+	u8	pin0_usage;
+	#define FUNC_PTP_PIN_CFG_REQ_PIN0_USAGE_NONE     0x0UL
+	#define FUNC_PTP_PIN_CFG_REQ_PIN0_USAGE_PPS_IN   0x1UL
+	#define FUNC_PTP_PIN_CFG_REQ_PIN0_USAGE_PPS_OUT  0x2UL
+	#define FUNC_PTP_PIN_CFG_REQ_PIN0_USAGE_SYNC_IN  0x3UL
+	#define FUNC_PTP_PIN_CFG_REQ_PIN0_USAGE_SYNC_OUT 0x4UL
+	#define FUNC_PTP_PIN_CFG_REQ_PIN0_USAGE_LAST    FUNC_PTP_PIN_CFG_REQ_PIN0_USAGE_SYNC_OUT
+	u8	pin1_state;
+	#define FUNC_PTP_PIN_CFG_REQ_PIN1_STATE_DISABLED 0x0UL
+	#define FUNC_PTP_PIN_CFG_REQ_PIN1_STATE_ENABLED  0x1UL
+	#define FUNC_PTP_PIN_CFG_REQ_PIN1_STATE_LAST    FUNC_PTP_PIN_CFG_REQ_PIN1_STATE_ENABLED
+	u8	pin1_usage;
+	#define FUNC_PTP_PIN_CFG_REQ_PIN1_USAGE_NONE     0x0UL
+	#define FUNC_PTP_PIN_CFG_REQ_PIN1_USAGE_PPS_IN   0x1UL
+	#define FUNC_PTP_PIN_CFG_REQ_PIN1_USAGE_PPS_OUT  0x2UL
+	#define FUNC_PTP_PIN_CFG_REQ_PIN1_USAGE_SYNC_IN  0x3UL
+	#define FUNC_PTP_PIN_CFG_REQ_PIN1_USAGE_SYNC_OUT 0x4UL
+	#define FUNC_PTP_PIN_CFG_REQ_PIN1_USAGE_LAST    FUNC_PTP_PIN_CFG_REQ_PIN1_USAGE_SYNC_OUT
+	u8	pin2_state;
+	#define FUNC_PTP_PIN_CFG_REQ_PIN2_STATE_DISABLED 0x0UL
+	#define FUNC_PTP_PIN_CFG_REQ_PIN2_STATE_ENABLED  0x1UL
+	#define FUNC_PTP_PIN_CFG_REQ_PIN2_STATE_LAST    FUNC_PTP_PIN_CFG_REQ_PIN2_STATE_ENABLED
+	u8	pin2_usage;
+	#define FUNC_PTP_PIN_CFG_REQ_PIN2_USAGE_NONE                      0x0UL
+	#define FUNC_PTP_PIN_CFG_REQ_PIN2_USAGE_PPS_IN                    0x1UL
+	#define FUNC_PTP_PIN_CFG_REQ_PIN2_USAGE_PPS_OUT                   0x2UL
+	#define FUNC_PTP_PIN_CFG_REQ_PIN2_USAGE_SYNC_IN                   0x3UL
+	#define FUNC_PTP_PIN_CFG_REQ_PIN2_USAGE_SYNC_OUT                  0x4UL
+	#define FUNC_PTP_PIN_CFG_REQ_PIN2_USAGE_SYNCE_PRIMARY_CLOCK_OUT   0x5UL
+	#define FUNC_PTP_PIN_CFG_REQ_PIN2_USAGE_SYNCE_SECONDARY_CLOCK_OUT 0x6UL
+	#define FUNC_PTP_PIN_CFG_REQ_PIN2_USAGE_LAST                     FUNC_PTP_PIN_CFG_REQ_PIN2_USAGE_SYNCE_SECONDARY_CLOCK_OUT
+	u8	pin3_state;
+	#define FUNC_PTP_PIN_CFG_REQ_PIN3_STATE_DISABLED 0x0UL
+	#define FUNC_PTP_PIN_CFG_REQ_PIN3_STATE_ENABLED  0x1UL
+	#define FUNC_PTP_PIN_CFG_REQ_PIN3_STATE_LAST    FUNC_PTP_PIN_CFG_REQ_PIN3_STATE_ENABLED
+	u8	pin3_usage;
+	#define FUNC_PTP_PIN_CFG_REQ_PIN3_USAGE_NONE                      0x0UL
+	#define FUNC_PTP_PIN_CFG_REQ_PIN3_USAGE_PPS_IN                    0x1UL
+	#define FUNC_PTP_PIN_CFG_REQ_PIN3_USAGE_PPS_OUT                   0x2UL
+	#define FUNC_PTP_PIN_CFG_REQ_PIN3_USAGE_SYNC_IN                   0x3UL
+	#define FUNC_PTP_PIN_CFG_REQ_PIN3_USAGE_SYNC_OUT                  0x4UL
+	#define FUNC_PTP_PIN_CFG_REQ_PIN3_USAGE_SYNCE_PRIMARY_CLOCK_OUT   0x5UL
+	#define FUNC_PTP_PIN_CFG_REQ_PIN3_USAGE_SYNCE_SECONDARY_CLOCK_OUT 0x6UL
+	#define FUNC_PTP_PIN_CFG_REQ_PIN3_USAGE_LAST                     FUNC_PTP_PIN_CFG_REQ_PIN3_USAGE_SYNCE_SECONDARY_CLOCK_OUT
+	u8	unused_0[4];
+};
+
+/* hwrm_func_ptp_pin_cfg_output (size:128b/16B) */
+struct hwrm_func_ptp_pin_cfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_func_ptp_cfg_input (size:384b/48B) */
+struct hwrm_func_ptp_cfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	enables;
+	#define FUNC_PTP_CFG_REQ_ENABLES_PTP_PPS_EVENT               0x1UL
+	#define FUNC_PTP_CFG_REQ_ENABLES_PTP_FREQ_ADJ_DLL_SOURCE     0x2UL
+	#define FUNC_PTP_CFG_REQ_ENABLES_PTP_FREQ_ADJ_DLL_PHASE      0x4UL
+	#define FUNC_PTP_CFG_REQ_ENABLES_PTP_FREQ_ADJ_EXT_PERIOD     0x8UL
+	#define FUNC_PTP_CFG_REQ_ENABLES_PTP_FREQ_ADJ_EXT_UP         0x10UL
+	#define FUNC_PTP_CFG_REQ_ENABLES_PTP_FREQ_ADJ_EXT_PHASE      0x20UL
+	#define FUNC_PTP_CFG_REQ_ENABLES_PTP_SET_TIME                0x40UL
+	u8	ptp_pps_event;
+	#define FUNC_PTP_CFG_REQ_PTP_PPS_EVENT_INTERNAL     0x1UL
+	#define FUNC_PTP_CFG_REQ_PTP_PPS_EVENT_EXTERNAL     0x2UL
+	u8	ptp_freq_adj_dll_source;
+	#define FUNC_PTP_CFG_REQ_PTP_FREQ_ADJ_DLL_SOURCE_NONE    0x0UL
+	#define FUNC_PTP_CFG_REQ_PTP_FREQ_ADJ_DLL_SOURCE_TSIO_0  0x1UL
+	#define FUNC_PTP_CFG_REQ_PTP_FREQ_ADJ_DLL_SOURCE_TSIO_1  0x2UL
+	#define FUNC_PTP_CFG_REQ_PTP_FREQ_ADJ_DLL_SOURCE_TSIO_2  0x3UL
+	#define FUNC_PTP_CFG_REQ_PTP_FREQ_ADJ_DLL_SOURCE_TSIO_3  0x4UL
+	#define FUNC_PTP_CFG_REQ_PTP_FREQ_ADJ_DLL_SOURCE_PORT_0  0x5UL
+	#define FUNC_PTP_CFG_REQ_PTP_FREQ_ADJ_DLL_SOURCE_PORT_1  0x6UL
+	#define FUNC_PTP_CFG_REQ_PTP_FREQ_ADJ_DLL_SOURCE_PORT_2  0x7UL
+	#define FUNC_PTP_CFG_REQ_PTP_FREQ_ADJ_DLL_SOURCE_PORT_3  0x8UL
+	#define FUNC_PTP_CFG_REQ_PTP_FREQ_ADJ_DLL_SOURCE_INVALID 0xffUL
+	#define FUNC_PTP_CFG_REQ_PTP_FREQ_ADJ_DLL_SOURCE_LAST   FUNC_PTP_CFG_REQ_PTP_FREQ_ADJ_DLL_SOURCE_INVALID
+	u8	ptp_freq_adj_dll_phase;
+	#define FUNC_PTP_CFG_REQ_PTP_FREQ_ADJ_DLL_PHASE_NONE 0x0UL
+	#define FUNC_PTP_CFG_REQ_PTP_FREQ_ADJ_DLL_PHASE_4K   0x1UL
+	#define FUNC_PTP_CFG_REQ_PTP_FREQ_ADJ_DLL_PHASE_8K   0x2UL
+	#define FUNC_PTP_CFG_REQ_PTP_FREQ_ADJ_DLL_PHASE_10M  0x3UL
+	#define FUNC_PTP_CFG_REQ_PTP_FREQ_ADJ_DLL_PHASE_25M  0x4UL
+	#define FUNC_PTP_CFG_REQ_PTP_FREQ_ADJ_DLL_PHASE_LAST FUNC_PTP_CFG_REQ_PTP_FREQ_ADJ_DLL_PHASE_25M
+	u8	unused_0[3];
+	__le32	ptp_freq_adj_ext_period;
+	__le32	ptp_freq_adj_ext_up;
+	__le32	ptp_freq_adj_ext_phase_lower;
+	__le32	ptp_freq_adj_ext_phase_upper;
+	__le64	ptp_set_time;
+};
+
+/* hwrm_func_ptp_cfg_output (size:128b/16B) */
+struct hwrm_func_ptp_cfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_func_ptp_ts_query_input (size:192b/24B) */
+struct hwrm_func_ptp_ts_query_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	flags;
+	#define FUNC_PTP_TS_QUERY_REQ_FLAGS_PPS_TIME     0x1UL
+	#define FUNC_PTP_TS_QUERY_REQ_FLAGS_PTM_TIME     0x2UL
+	u8	unused_0[4];
+};
+
+/* hwrm_func_ptp_ts_query_output (size:320b/40B) */
+struct hwrm_func_ptp_ts_query_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le64	pps_event_ts;
+	__le64	ptm_local_ts;
+	__le64	ptm_system_ts;
+	__le32	ptm_link_delay;
+	u8	unused_0[3];
+	u8	valid;
+};
+
+/* hwrm_func_ptp_ext_cfg_input (size:256b/32B) */
+struct hwrm_func_ptp_ext_cfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	enables;
+	#define FUNC_PTP_EXT_CFG_REQ_ENABLES_PHC_MASTER_FID     0x1UL
+	#define FUNC_PTP_EXT_CFG_REQ_ENABLES_PHC_SEC_FID        0x2UL
+	#define FUNC_PTP_EXT_CFG_REQ_ENABLES_PHC_SEC_MODE       0x4UL
+	#define FUNC_PTP_EXT_CFG_REQ_ENABLES_FAILOVER_TIMER     0x8UL
+	__le16	phc_master_fid;
+	__le16	phc_sec_fid;
+	u8	phc_sec_mode;
+	#define FUNC_PTP_EXT_CFG_REQ_PHC_SEC_MODE_SWITCH  0x0UL
+	#define FUNC_PTP_EXT_CFG_REQ_PHC_SEC_MODE_ALL     0x1UL
+	#define FUNC_PTP_EXT_CFG_REQ_PHC_SEC_MODE_PF_ONLY 0x2UL
+	#define FUNC_PTP_EXT_CFG_REQ_PHC_SEC_MODE_LAST   FUNC_PTP_EXT_CFG_REQ_PHC_SEC_MODE_PF_ONLY
+	u8	unused_0;
+	__le32	failover_timer;
+	u8	unused_1[4];
+};
+
+/* hwrm_func_ptp_ext_cfg_output (size:128b/16B) */
+struct hwrm_func_ptp_ext_cfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_func_ptp_ext_qcfg_input (size:192b/24B) */
+struct hwrm_func_ptp_ext_qcfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	u8	unused_0[8];
+};
+
+/* hwrm_func_ptp_ext_qcfg_output (size:256b/32B) */
+struct hwrm_func_ptp_ext_qcfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	phc_master_fid;
+	__le16	phc_sec_fid;
+	__le16	phc_active_fid0;
+	__le16	phc_active_fid1;
+	__le32	last_failover_event;
+	__le16	from_fid;
+	__le16	to_fid;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_func_ttx_pacing_rate_prof_query_input (size:192b/24B) */
+struct hwrm_func_ttx_pacing_rate_prof_query_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	u8	unused_0[8];
+};
+
+/* hwrm_func_ttx_pacing_rate_prof_query_output (size:128b/16B) */
+struct hwrm_func_ttx_pacing_rate_prof_query_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	start_prof_id;
+	u8	end_prof_id;
+	u8	active_prof_id;
+	#define FUNC_TTX_PACING_RATE_PROF_QUERY_RESP_60M 0x0UL
+	#define FUNC_TTX_PACING_RATE_PROF_QUERY_RESP_50G 0x1UL
+	#define FUNC_TTX_PACING_RATE_PROF_QUERY_RESP_LAST FUNC_TTX_PACING_RATE_PROF_QUERY_RESP_50G
+	u8	unused_0[4];
+	u8	valid;
+};
+
+/* hwrm_func_ttx_pacing_rate_query_input (size:192b/24B) */
+struct hwrm_func_ttx_pacing_rate_query_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	u8	profile_id;
+	u8	unused_0[7];
+};
+
+/* hwrm_func_ttx_pacing_rate_query_output (size:4224b/528B) */
+struct hwrm_func_ttx_pacing_rate_query_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le32	rates[128];
+	u8	profile_id;
+	u8	unused_0[6];
+	u8	valid;
+};
+
+/* hwrm_func_key_ctx_alloc_input (size:384b/48B) */
+struct hwrm_func_key_ctx_alloc_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	fid;
+	__le16	num_key_ctxs;
+	__le32	dma_bufr_size_bytes;
+	u8	key_ctx_type;
+	#define FUNC_KEY_CTX_ALLOC_REQ_KEY_CTX_TYPE_TX      0x0UL
+	#define FUNC_KEY_CTX_ALLOC_REQ_KEY_CTX_TYPE_RX      0x1UL
+	#define FUNC_KEY_CTX_ALLOC_REQ_KEY_CTX_TYPE_QUIC_TX 0x2UL
+	#define FUNC_KEY_CTX_ALLOC_REQ_KEY_CTX_TYPE_QUIC_RX 0x3UL
+	#define FUNC_KEY_CTX_ALLOC_REQ_KEY_CTX_TYPE_LAST   FUNC_KEY_CTX_ALLOC_REQ_KEY_CTX_TYPE_QUIC_RX
+	u8	unused_0[7];
+	__le64	host_dma_addr;
+	__le32	partition_start_xid;
+	u8	unused_1[4];
+};
+
+/* hwrm_func_key_ctx_alloc_output (size:192b/24B) */
+struct hwrm_func_key_ctx_alloc_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	num_key_ctxs_allocated;
+	u8	flags;
+	#define FUNC_KEY_CTX_ALLOC_RESP_FLAGS_KEY_CTXS_CONTIGUOUS     0x1UL
+	u8	unused_0;
+	__le32	partition_start_xid;
+	u8	unused_1[7];
+	u8	valid;
+};
+
+/* hwrm_func_key_ctx_free_input (size:256b/32B) */
+struct hwrm_func_key_ctx_free_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	fid;
+	u8	key_ctx_type;
+	#define FUNC_KEY_CTX_FREE_REQ_KEY_CTX_TYPE_TX      0x0UL
+	#define FUNC_KEY_CTX_FREE_REQ_KEY_CTX_TYPE_RX      0x1UL
+	#define FUNC_KEY_CTX_FREE_REQ_KEY_CTX_TYPE_QUIC_TX 0x2UL
+	#define FUNC_KEY_CTX_FREE_REQ_KEY_CTX_TYPE_QUIC_RX 0x3UL
+	#define FUNC_KEY_CTX_FREE_REQ_KEY_CTX_TYPE_LAST   FUNC_KEY_CTX_FREE_REQ_KEY_CTX_TYPE_QUIC_RX
+	u8	unused_0;
+	__le32	partition_start_xid;
+	__le16	num_entries;
+	u8	unused_1[6];
+};
+
+/* hwrm_func_key_ctx_free_output (size:128b/16B) */
+struct hwrm_func_key_ctx_free_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	rsvd0[7];
+	u8	valid;
+};
+
+/* hwrm_func_backing_store_cfg_v2_input (size:512b/64B) */
+struct hwrm_func_backing_store_cfg_v2_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	type;
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_QP                  0x0UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_SRQ                 0x1UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_CQ                  0x2UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_VNIC                0x3UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_STAT                0x4UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_SP_TQM_RING         0x5UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_FP_TQM_RING         0x6UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_MRAV                0xeUL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_TIM                 0xfUL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_TX_CK               0x13UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_RX_CK               0x14UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_MP_TQM_RING         0x15UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_SQ_DB_SHADOW        0x16UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_RQ_DB_SHADOW        0x17UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_SRQ_DB_SHADOW       0x18UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_CQ_DB_SHADOW        0x19UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_TBL_SCOPE           0x1cUL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_XID_PARTITION       0x1dUL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_SRT_TRACE           0x1eUL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_SRT2_TRACE          0x1fUL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_CRT_TRACE           0x20UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_CRT2_TRACE          0x21UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_RIGP0_TRACE         0x22UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_L2_HWRM_TRACE       0x23UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_ROCE_HWRM_TRACE     0x24UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_TTX_PACING_TQM_RING 0x25UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_CA0_TRACE           0x26UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_CA1_TRACE           0x27UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_CA2_TRACE           0x28UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_RIGP1_TRACE         0x29UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_AFM_KONG_HWRM_TRACE 0x2aUL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_ERR_QPC_TRACE       0x2bUL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_PNO_TQM_RING        0x2cUL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_MPRT_TRACE          0x2dUL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_RERT_TRACE          0x2eUL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_MR                  0x2fUL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_AV                  0x30UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_SQ                  0x31UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_IQM                 0x32UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_MPC_MSG_TRACE       0x33UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_MPC_CMPL_TRACE      0x34UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_INVALID             0xffffUL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_LAST               FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_INVALID
+	__le16	instance;
+	__le32	flags;
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_FLAGS_PREBOOT_MODE        0x1UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_FLAGS_BS_CFG_ALL_DONE     0x2UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_FLAGS_BS_EXTEND           0x4UL
+	__le64	page_dir;
+	__le32	num_entries;
+	__le16	entry_size;
+	u8	page_size_pbl_level;
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_PBL_LEVEL_MASK  0xfUL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_PBL_LEVEL_SFT   0
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_PBL_LEVEL_LVL_0   0x0UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_PBL_LEVEL_LVL_1   0x1UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_PBL_LEVEL_LVL_2   0x2UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_PBL_LEVEL_LAST   FUNC_BACKING_STORE_CFG_V2_REQ_PBL_LEVEL_LVL_2
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_PAGE_SIZE_MASK  0xf0UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_PAGE_SIZE_SFT   4
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_PAGE_SIZE_PG_4K   (0x0UL << 4)
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_PAGE_SIZE_PG_8K   (0x1UL << 4)
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_PAGE_SIZE_PG_64K  (0x2UL << 4)
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_PAGE_SIZE_PG_2M   (0x3UL << 4)
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_PAGE_SIZE_PG_8M   (0x4UL << 4)
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_PAGE_SIZE_PG_1G   (0x5UL << 4)
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_PAGE_SIZE_LAST   FUNC_BACKING_STORE_CFG_V2_REQ_PAGE_SIZE_PG_1G
+	u8	subtype_valid_cnt;
+	__le32	split_entry_0;
+	__le32	split_entry_1;
+	__le32	split_entry_2;
+	__le32	split_entry_3;
+	__le32	enables;
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_ENABLES_NEXT_BS_OFFSET     0x1UL
+	__le32	next_bs_offset;
+};
+
+/* hwrm_func_backing_store_cfg_v2_output (size:128b/16B) */
+struct hwrm_func_backing_store_cfg_v2_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	rsvd0[7];
+	u8	valid;
+};
+
+/* hwrm_func_backing_store_cfg_v2_cmd_err (size:64b/8B) */
+struct hwrm_func_backing_store_cfg_v2_cmd_err {
+	u8	code;
+	#define FUNC_BACKING_STORE_CFG_V2_CMD_ERR_CODE_UNKNOWN         0x0UL
+	#define FUNC_BACKING_STORE_CFG_V2_CMD_ERR_CODE_QP_FAIL         0x1UL
+	#define FUNC_BACKING_STORE_CFG_V2_CMD_ERR_CODE_SRQ_FAIL        0x2UL
+	#define FUNC_BACKING_STORE_CFG_V2_CMD_ERR_CODE_CQ_FAIL         0x3UL
+	#define FUNC_BACKING_STORE_CFG_V2_CMD_ERR_CODE_VNIC_FAIL       0x4UL
+	#define FUNC_BACKING_STORE_CFG_V2_CMD_ERR_CODE_STAT_FAIL       0x5UL
+	#define FUNC_BACKING_STORE_CFG_V2_CMD_ERR_CODE_TQM_SPR_FAIL    0x6UL
+	#define FUNC_BACKING_STORE_CFG_V2_CMD_ERR_CODE_TQM_FPR_FAIL    0x7UL
+	#define FUNC_BACKING_STORE_CFG_V2_CMD_ERR_CODE_MRAV_FAIL       0x8UL
+	#define FUNC_BACKING_STORE_CFG_V2_CMD_ERR_CODE_TIM_FAIL        0x9UL
+	#define FUNC_BACKING_STORE_CFG_V2_CMD_ERR_CODE_V2TRACE_FAIL    0xaUL
+	#define FUNC_BACKING_STORE_CFG_V2_CMD_ERR_CODE_TXCK_FAIL       0xbUL
+	#define FUNC_BACKING_STORE_CFG_V2_CMD_ERR_CODE_RXCK_FAIL       0xcUL
+	#define FUNC_BACKING_STORE_CFG_V2_CMD_ERR_CODE_MPC_FAIL        0xdUL
+	#define FUNC_BACKING_STORE_CFG_V2_CMD_ERR_CODE_SHADOW_DB_FAIL  0xeUL
+	#define FUNC_BACKING_STORE_CFG_V2_CMD_ERR_CODE_XID_FAIL        0xfUL
+	#define FUNC_BACKING_STORE_CFG_V2_CMD_ERR_CODE_TFC_FAIL        0x10UL
+	#define FUNC_BACKING_STORE_CFG_V2_CMD_ERR_CODE_TTXPACE_FAIL    0x11UL
+	#define FUNC_BACKING_STORE_CFG_V2_CMD_ERR_CODE_CDU_ENABLE_FAIL 0x12UL
+	#define FUNC_BACKING_STORE_CFG_V2_CMD_ERR_CODE_SCHQ_ALLOC_FAIL 0x13UL
+	#define FUNC_BACKING_STORE_CFG_V2_CMD_ERR_CODE_LAST           FUNC_BACKING_STORE_CFG_V2_CMD_ERR_CODE_SCHQ_ALLOC_FAIL
+	u8	unused_0[7];
+};
+
+/* hwrm_func_backing_store_qcfg_v2_input (size:192b/24B) */
+struct hwrm_func_backing_store_qcfg_v2_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	type;
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_QP                  0x0UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_SRQ                 0x1UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_CQ                  0x2UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_VNIC                0x3UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_STAT                0x4UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_SP_TQM_RING         0x5UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_FP_TQM_RING         0x6UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_MRAV                0xeUL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_TIM                 0xfUL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_TX_CK               0x13UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_RX_CK               0x14UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_MP_TQM_RING         0x15UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_SQ_DB_SHADOW        0x16UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_RQ_DB_SHADOW        0x17UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_SRQ_DB_SHADOW       0x18UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_CQ_DB_SHADOW        0x19UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_TBL_SCOPE           0x1cUL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_XID_PARTITION_TABLE 0x1dUL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_SRT_TRACE           0x1eUL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_SRT2_TRACE          0x1fUL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_CRT_TRACE           0x20UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_CRT2_TRACE          0x21UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_RIGP0_TRACE         0x22UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_L2_HWRM_TRACE       0x23UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_ROCE_HWRM_TRACE     0x24UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_TTX_PACING_TQM_RING 0x25UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_CA0_TRACE           0x26UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_CA1_TRACE           0x27UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_CA2_TRACE           0x28UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_RIGP1_TRACE         0x29UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_AFM_KONG_HWRM_TRACE 0x2aUL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_ERR_QPC_TRACE       0x2bUL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_PNO_TQM_RING        0x2cUL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_MPRT_TRACE          0x2dUL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_RERT_TRACE          0x2eUL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_MR                  0x2fUL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_AV                  0x30UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_SQ                  0x31UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_IQM                 0x32UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_MPC_MSG_TRACE       0x33UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_MPC_CMPL_TRACE      0x34UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_INVALID             0xffffUL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_LAST               FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_INVALID
+	__le16	instance;
+	u8	rsvd[4];
+};
+
+/* hwrm_func_backing_store_qcfg_v2_output (size:448b/56B) */
+struct hwrm_func_backing_store_qcfg_v2_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	type;
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_QP                  0x0UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_SRQ                 0x1UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_CQ                  0x2UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_VNIC                0x3UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_STAT                0x4UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_SP_TQM_RING         0x5UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_FP_TQM_RING         0x6UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_MRAV                0xeUL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_TIM                 0xfUL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_TX_CK               0x13UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_RX_CK               0x14UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_MP_TQM_RING         0x15UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_TBL_SCOPE           0x1cUL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_XID_PARTITION       0x1dUL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_SRT_TRACE           0x1eUL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_SRT2_TRACE          0x1fUL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_CRT_TRACE           0x20UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_CRT2_TRACE          0x21UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_RIGP0_TRACE         0x22UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_L2_HWRM_TRACE       0x23UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_ROCE_HWRM_TRACE     0x24UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_TTX_PACING_TQM_RING 0x25UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_CA0_TRACE           0x26UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_CA1_TRACE           0x27UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_CA2_TRACE           0x28UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_RIGP1_TRACE         0x29UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_ERR_QPC_TRACE       0x2aUL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_PNO_TQM_RING        0x2cUL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_MPRT_TRACE          0x2dUL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_RERT_TRACE          0x2eUL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_MR                  0x2fUL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_AV                  0x30UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_SQ                  0x31UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_IQM                 0x32UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_MPC_MSG_TRACE       0x33UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_MPC_CMPL_TRACE      0x34UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_INVALID             0xffffUL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_LAST               FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_INVALID
+	__le16	instance;
+	__le32	flags;
+	__le64	page_dir;
+	__le32	num_entries;
+	u8	page_size_pbl_level;
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_PBL_LEVEL_MASK  0xfUL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_PBL_LEVEL_SFT   0
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_PBL_LEVEL_LVL_0   0x0UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_PBL_LEVEL_LVL_1   0x1UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_PBL_LEVEL_LVL_2   0x2UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_PBL_LEVEL_LAST   FUNC_BACKING_STORE_QCFG_V2_RESP_PBL_LEVEL_LVL_2
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_PAGE_SIZE_MASK  0xf0UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_PAGE_SIZE_SFT   4
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_PAGE_SIZE_PG_4K   (0x0UL << 4)
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_PAGE_SIZE_PG_8K   (0x1UL << 4)
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_PAGE_SIZE_PG_64K  (0x2UL << 4)
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_PAGE_SIZE_PG_2M   (0x3UL << 4)
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_PAGE_SIZE_PG_8M   (0x4UL << 4)
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_PAGE_SIZE_PG_1G   (0x5UL << 4)
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_PAGE_SIZE_LAST   FUNC_BACKING_STORE_QCFG_V2_RESP_PAGE_SIZE_PG_1G
+	u8	subtype_valid_cnt;
+	u8	rsvd[2];
+	__le32	split_entry_0;
+	__le32	split_entry_1;
+	__le32	split_entry_2;
+	__le32	split_entry_3;
+	u8	rsvd2[7];
+	u8	valid;
+};
+
+/* qpc_split_entries (size:128b/16B) */
+struct qpc_split_entries {
+	__le32	qp_num_l2_entries;
+	__le32	qp_num_qp1_entries;
+	__le32	qp_num_fast_qpmd_entries;
+	__le32	rsvd;
+};
+
+/* srq_split_entries (size:128b/16B) */
+struct srq_split_entries {
+	__le32	srq_num_l2_entries;
+	__le32	rsvd;
+	__le32	rsvd2[2];
+};
+
+/* cq_split_entries (size:128b/16B) */
+struct cq_split_entries {
+	__le32	cq_num_l2_entries;
+	__le32	rsvd;
+	__le32	rsvd2[2];
+};
+
+/* vnic_split_entries (size:128b/16B) */
+struct vnic_split_entries {
+	__le32	vnic_num_vnic_entries;
+	__le32	rsvd;
+	__le32	rsvd2[2];
+};
+
+/* mrav_split_entries (size:128b/16B) */
+struct mrav_split_entries {
+	__le32	mrav_num_av_entries;
+	__le32	rsvd;
+	__le32	rsvd2[2];
+};
+
+/* ts_split_entries (size:128b/16B) */
+struct ts_split_entries {
+	__le32	region_num_entries;
+	u8	tsid;
+	u8	lkup_static_bkt_cnt_exp[2];
+	u8	locked;
+	__le32	rsvd2[2];
+};
+
+/* ck_split_entries (size:128b/16B) */
+struct ck_split_entries {
+	__le32	num_quic_entries;
+	__le32	rsvd;
+	__le32	rsvd2[2];
+};
+
+/* mr_split_entries (size:128b/16B) */
+struct mr_split_entries {
+	__le32	mr_num_entries;
+	__le32	rsvd;
+	__le32	rsvd2[2];
+};
+
+/* av_split_entries (size:128b/16B) */
+struct av_split_entries {
+	__le32	av_num_entries;
+	__le32	rsvd;
+	__le32	rsvd2[2];
+};
+
+/* sq_split_entries (size:128b/16B) */
+struct sq_split_entries {
+	__le32	sq_num_l2_entries;
+	__le32	rsvd2;
+	__le32	rsvd3[2];
+};
+
+/* hwrm_func_backing_store_qcfg_v2_cmd_err (size:64b/8B) */
+struct hwrm_func_backing_store_qcfg_v2_cmd_err {
+	u8	code;
+	#define FUNC_BACKING_STORE_QCFG_V2_CMD_ERR_CODE_UNKNOWN         0x0UL
+	#define FUNC_BACKING_STORE_QCFG_V2_CMD_ERR_CODE_SHDDB_FAIL      0x1UL
+	#define FUNC_BACKING_STORE_QCFG_V2_CMD_ERR_CODE_XID_FAIL        0x2UL
+	#define FUNC_BACKING_STORE_QCFG_V2_CMD_ERR_CODE_TXPAC_RING_FAIL 0x3UL
+	#define FUNC_BACKING_STORE_QCFG_V2_CMD_ERR_CODE_INVALID_FIELD   0x4UL
+	#define FUNC_BACKING_STORE_QCFG_V2_CMD_ERR_CODE_LAST           FUNC_BACKING_STORE_QCFG_V2_CMD_ERR_CODE_INVALID_FIELD
+	u8	unused_0[7];
+};
+
+/* hwrm_func_backing_store_qcaps_v2_input (size:192b/24B) */
+struct hwrm_func_backing_store_qcaps_v2_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	type;
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_QP                  0x0UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_SRQ                 0x1UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_CQ                  0x2UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_VNIC                0x3UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_STAT                0x4UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_SP_TQM_RING         0x5UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_FP_TQM_RING         0x6UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_MRAV                0xeUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_TIM                 0xfUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_TX_CK               0x13UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_RX_CK               0x14UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_MP_TQM_RING         0x15UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_SQ_DB_SHADOW        0x16UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_RQ_DB_SHADOW        0x17UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_SRQ_DB_SHADOW       0x18UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_CQ_DB_SHADOW        0x19UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_TBL_SCOPE           0x1cUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_XID_PARTITION       0x1dUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_SRT_TRACE           0x1eUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_SRT2_TRACE          0x1fUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_CRT_TRACE           0x20UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_CRT2_TRACE          0x21UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_RIGP0_TRACE         0x22UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_L2_HWRM_TRACE       0x23UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_ROCE_HWRM_TRACE     0x24UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_TTX_PACING_TQM_RING 0x25UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_CA0_TRACE           0x26UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_CA1_TRACE           0x27UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_CA2_TRACE           0x28UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_RIGP1_TRACE         0x29UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_AFM_KONG_HWRM_TRACE 0x2aUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_ERR_QPC_TRACE       0x2bUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_PNO_TQM_RING        0x2cUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_MPRT_TRACE          0x2dUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_RERT_TRACE          0x2eUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_MR                  0x2fUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_AV                  0x30UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_SQ                  0x31UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_IQM                 0x32UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_MPC_MSG_TRACE       0x33UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_MPC_CMPL_TRACE      0x34UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_INVALID             0xffffUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_LAST               FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_INVALID
+	u8	rsvd[6];
+};
+
+/* hwrm_func_backing_store_qcaps_v2_output (size:448b/56B) */
+struct hwrm_func_backing_store_qcaps_v2_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	type;
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_QP                  0x0UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_SRQ                 0x1UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_CQ                  0x2UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_VNIC                0x3UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_STAT                0x4UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_SP_TQM_RING         0x5UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_FP_TQM_RING         0x6UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_MRAV                0xeUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_TIM                 0xfUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_TX_CK               0x13UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_RX_CK               0x14UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_MP_TQM_RING         0x15UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_SQ_DB_SHADOW        0x16UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_RQ_DB_SHADOW        0x17UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_SRQ_DB_SHADOW       0x18UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_CQ_DB_SHADOW        0x19UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_TBL_SCOPE           0x1cUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_XID_PARTITION       0x1dUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_SRT_TRACE           0x1eUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_SRT2_TRACE          0x1fUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_CRT_TRACE           0x20UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_CRT2_TRACE          0x21UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_RIGP0_TRACE         0x22UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_L2_HWRM_TRACE       0x23UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_ROCE_HWRM_TRACE     0x24UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_TTX_PACING_TQM_RING 0x25UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_CA0_TRACE           0x26UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_CA1_TRACE           0x27UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_CA2_TRACE           0x28UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_RIGP1_TRACE         0x29UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_AFM_KONG_HWRM_TRACE 0x2aUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_ERR_QPC_TRACE       0x2bUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_PNO_TQM_RING        0x2cUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_MPRT_TRACE          0x2dUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_RERT_TRACE          0x2eUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_MR                  0x2fUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_AV                  0x30UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_SQ                  0x31UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_IQM                 0x32UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_MPC_MSG_TRACE       0x33UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_MPC_CMPL_TRACE      0x34UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_INVALID             0xffffUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_LAST               FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_INVALID
+	__le16	entry_size;
+	__le32	flags;
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_FLAGS_ENABLE_CTX_KIND_INIT            0x1UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_FLAGS_TYPE_VALID                      0x2UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_FLAGS_DRIVER_MANAGED_MEMORY           0x4UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_FLAGS_ROCE_QP_PSEUDO_STATIC_ALLOC     0x8UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_FLAGS_FW_DBG_TRACE                    0x10UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_FLAGS_FW_BIN_DBG_TRACE                0x20UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_FLAGS_NEXT_BS_OFFSET                  0x40UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_FLAGS_PHYSICAL_PBL_PREFERRED          0x80UL
+	__le32	instance_bit_map;
+	u8	ctx_init_value;
+	u8	ctx_init_offset;
+	u8	entry_multiple;
+	u8	rsvd;
+	__le32	max_num_entries;
+	__le32	min_num_entries;
+	__le16	next_valid_type;
+	u8	subtype_valid_cnt;
+	u8	exact_cnt_bit_map;
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_EXACT_CNT_BIT_MAP_SPLIT_ENTRY_0_EXACT     0x1UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_EXACT_CNT_BIT_MAP_SPLIT_ENTRY_1_EXACT     0x2UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_EXACT_CNT_BIT_MAP_SPLIT_ENTRY_2_EXACT     0x4UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_EXACT_CNT_BIT_MAP_SPLIT_ENTRY_3_EXACT     0x8UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_EXACT_CNT_BIT_MAP_UNUSED_MASK             0xf0UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_EXACT_CNT_BIT_MAP_UNUSED_SFT              4
+	__le32	split_entry_0;
+	__le32	split_entry_1;
+	__le32	split_entry_2;
+	__le32	split_entry_3;
+	__le16	max_instance_count;
+	u8	rsvd3;
+	u8	valid;
+};
+
+/* hwrm_func_dbr_pacing_qcfg_input (size:128b/16B) */
+struct hwrm_func_dbr_pacing_qcfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+};
+
+/* hwrm_func_dbr_pacing_qcfg_output (size:512b/64B) */
+struct hwrm_func_dbr_pacing_qcfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	flags;
+	#define FUNC_DBR_PACING_QCFG_RESP_FLAGS_DBR_NQ_EVENT_ENABLED     0x1UL
+	u8	unused_0[7];
+	__le32	dbr_stat_db_fifo_reg;
+	#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_MASK    0x3UL
+	#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_SFT     0
+	#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_PCIE_CFG  0x0UL
+	#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_GRC       0x1UL
+	#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_BAR0      0x2UL
+	#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_BAR1      0x3UL
+	#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_LAST     FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_BAR1
+	#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_MASK          0xfffffffcUL
+	#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SFT           2
+	__le32	dbr_stat_db_fifo_reg_watermark_mask;
+	u8	dbr_stat_db_fifo_reg_watermark_shift;
+	u8	unused_1[3];
+	__le32	dbr_stat_db_fifo_reg_fifo_room_mask;
+	u8	dbr_stat_db_fifo_reg_fifo_room_shift;
+	u8	unused_2[3];
+	__le32	dbr_throttling_aeq_arm_reg;
+	#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_MASK    0x3UL
+	#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_SFT     0
+	#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_PCIE_CFG  0x0UL
+	#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_GRC       0x1UL
+	#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_BAR0      0x2UL
+	#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_BAR1      0x3UL
+	#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_LAST     FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_BAR1
+	#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_MASK          0xfffffffcUL
+	#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SFT           2
+	u8	dbr_throttling_aeq_arm_reg_val;
+	u8	unused_3[3];
+	__le32	dbr_stat_db_max_fifo_depth;
+	__le32	primary_nq_id;
+	__le32	pacing_threshold;
+	u8	unused_4[7];
+	u8	valid;
+};
+
+/* hwrm_func_drv_if_change_input (size:192b/24B) */
+struct hwrm_func_drv_if_change_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	flags;
+	#define FUNC_DRV_IF_CHANGE_REQ_FLAGS_UP     0x1UL
+	__le32	unused;
+};
+
+/* hwrm_func_drv_if_change_output (size:128b/16B) */
+struct hwrm_func_drv_if_change_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le32	flags;
+	#define FUNC_DRV_IF_CHANGE_RESP_FLAGS_RESC_CHANGE           0x1UL
+	#define FUNC_DRV_IF_CHANGE_RESP_FLAGS_HOT_FW_RESET_DONE     0x2UL
+	#define FUNC_DRV_IF_CHANGE_RESP_FLAGS_CAPS_CHANGE           0x4UL
+	u8	unused_0[3];
+	u8	valid;
+};
+
+/* hwrm_port_phy_cfg_input (size:512b/64B) */
+struct hwrm_port_phy_cfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	flags;
+	#define PORT_PHY_CFG_REQ_FLAGS_RESET_PHY                  0x1UL
+	#define PORT_PHY_CFG_REQ_FLAGS_DEPRECATED                 0x2UL
+	#define PORT_PHY_CFG_REQ_FLAGS_FORCE                      0x4UL
+	#define PORT_PHY_CFG_REQ_FLAGS_RESTART_AUTONEG            0x8UL
+	#define PORT_PHY_CFG_REQ_FLAGS_EEE_ENABLE                 0x10UL
+	#define PORT_PHY_CFG_REQ_FLAGS_EEE_DISABLE                0x20UL
+	#define PORT_PHY_CFG_REQ_FLAGS_EEE_TX_LPI_ENABLE          0x40UL
+	#define PORT_PHY_CFG_REQ_FLAGS_EEE_TX_LPI_DISABLE         0x80UL
+	#define PORT_PHY_CFG_REQ_FLAGS_FEC_AUTONEG_ENABLE         0x100UL
+	#define PORT_PHY_CFG_REQ_FLAGS_FEC_AUTONEG_DISABLE        0x200UL
+	#define PORT_PHY_CFG_REQ_FLAGS_FEC_CLAUSE74_ENABLE        0x400UL
+	#define PORT_PHY_CFG_REQ_FLAGS_FEC_CLAUSE74_DISABLE       0x800UL
+	#define PORT_PHY_CFG_REQ_FLAGS_FEC_CLAUSE91_ENABLE        0x1000UL
+	#define PORT_PHY_CFG_REQ_FLAGS_FEC_CLAUSE91_DISABLE       0x2000UL
+	#define PORT_PHY_CFG_REQ_FLAGS_FORCE_LINK_DWN             0x4000UL
+	#define PORT_PHY_CFG_REQ_FLAGS_FEC_RS544_1XN_ENABLE       0x8000UL
+	#define PORT_PHY_CFG_REQ_FLAGS_FEC_RS544_1XN_DISABLE      0x10000UL
+	#define PORT_PHY_CFG_REQ_FLAGS_FEC_RS544_IEEE_ENABLE      0x20000UL
+	#define PORT_PHY_CFG_REQ_FLAGS_FEC_RS544_IEEE_DISABLE     0x40000UL
+	#define PORT_PHY_CFG_REQ_FLAGS_FEC_RS272_1XN_ENABLE       0x80000UL
+	#define PORT_PHY_CFG_REQ_FLAGS_FEC_RS272_1XN_DISABLE      0x100000UL
+	#define PORT_PHY_CFG_REQ_FLAGS_FEC_RS272_IEEE_ENABLE      0x200000UL
+	#define PORT_PHY_CFG_REQ_FLAGS_FEC_RS272_IEEE_DISABLE     0x400000UL
+	#define PORT_PHY_CFG_REQ_FLAGS_LINK_TRAINING_ENABLE       0x800000UL
+	#define PORT_PHY_CFG_REQ_FLAGS_LINK_TRAINING_DISABLE      0x1000000UL
+	#define PORT_PHY_CFG_REQ_FLAGS_PRECODING_ENABLE           0x2000000UL
+	#define PORT_PHY_CFG_REQ_FLAGS_PRECODING_DISABLE          0x4000000UL
+	__le32	enables;
+	#define PORT_PHY_CFG_REQ_ENABLES_AUTO_MODE                     0x1UL
+	#define PORT_PHY_CFG_REQ_ENABLES_AUTO_DUPLEX                   0x2UL
+	#define PORT_PHY_CFG_REQ_ENABLES_AUTO_PAUSE                    0x4UL
+	#define PORT_PHY_CFG_REQ_ENABLES_AUTO_LINK_SPEED               0x8UL
+	#define PORT_PHY_CFG_REQ_ENABLES_AUTO_LINK_SPEED_MASK          0x10UL
+	#define PORT_PHY_CFG_REQ_ENABLES_WIRESPEED                     0x20UL
+	#define PORT_PHY_CFG_REQ_ENABLES_LPBK                          0x40UL
+	#define PORT_PHY_CFG_REQ_ENABLES_PREEMPHASIS                   0x80UL
+	#define PORT_PHY_CFG_REQ_ENABLES_FORCE_PAUSE                   0x100UL
+	#define PORT_PHY_CFG_REQ_ENABLES_EEE_LINK_SPEED_MASK           0x200UL
+	#define PORT_PHY_CFG_REQ_ENABLES_TX_LPI_TIMER                  0x400UL
+	#define PORT_PHY_CFG_REQ_ENABLES_FORCE_PAM4_LINK_SPEED         0x800UL
+	#define PORT_PHY_CFG_REQ_ENABLES_AUTO_PAM4_LINK_SPEED_MASK     0x1000UL
+	#define PORT_PHY_CFG_REQ_ENABLES_FORCE_LINK_SPEEDS2            0x2000UL
+	#define PORT_PHY_CFG_REQ_ENABLES_AUTO_LINK_SPEEDS2_MASK        0x4000UL
+	__le16	port_id;
+	__le16	force_link_speed;
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEED_100MB 0x1UL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEED_1GB   0xaUL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEED_2GB   0x14UL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEED_2_5GB 0x19UL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEED_10GB  0x64UL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEED_20GB  0xc8UL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEED_25GB  0xfaUL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEED_40GB  0x190UL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEED_50GB  0x1f4UL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEED_100GB 0x3e8UL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEED_10MB  0xffffUL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEED_LAST PORT_PHY_CFG_REQ_FORCE_LINK_SPEED_10MB
+	u8	auto_mode;
+	#define PORT_PHY_CFG_REQ_AUTO_MODE_NONE         0x0UL
+	#define PORT_PHY_CFG_REQ_AUTO_MODE_ALL_SPEEDS   0x1UL
+	#define PORT_PHY_CFG_REQ_AUTO_MODE_ONE_SPEED    0x2UL
+	#define PORT_PHY_CFG_REQ_AUTO_MODE_ONE_OR_BELOW 0x3UL
+	#define PORT_PHY_CFG_REQ_AUTO_MODE_SPEED_MASK   0x4UL
+	#define PORT_PHY_CFG_REQ_AUTO_MODE_LAST        PORT_PHY_CFG_REQ_AUTO_MODE_SPEED_MASK
+	u8	auto_duplex;
+	#define PORT_PHY_CFG_REQ_AUTO_DUPLEX_HALF 0x0UL
+	#define PORT_PHY_CFG_REQ_AUTO_DUPLEX_FULL 0x1UL
+	#define PORT_PHY_CFG_REQ_AUTO_DUPLEX_BOTH 0x2UL
+	#define PORT_PHY_CFG_REQ_AUTO_DUPLEX_LAST PORT_PHY_CFG_REQ_AUTO_DUPLEX_BOTH
+	u8	auto_pause;
+	#define PORT_PHY_CFG_REQ_AUTO_PAUSE_TX                0x1UL
+	#define PORT_PHY_CFG_REQ_AUTO_PAUSE_RX                0x2UL
+	#define PORT_PHY_CFG_REQ_AUTO_PAUSE_AUTONEG_PAUSE     0x4UL
+	u8	mgmt_flag;
+	#define PORT_PHY_CFG_REQ_MGMT_FLAG_LINK_RELEASE     0x1UL
+	#define PORT_PHY_CFG_REQ_MGMT_FLAG_MGMT_VALID       0x80UL
+	__le16	auto_link_speed;
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEED_100MB 0x1UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEED_1GB   0xaUL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEED_2GB   0x14UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEED_2_5GB 0x19UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEED_10GB  0x64UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEED_20GB  0xc8UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEED_25GB  0xfaUL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEED_40GB  0x190UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEED_50GB  0x1f4UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEED_100GB 0x3e8UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEED_10MB  0xffffUL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEED_LAST PORT_PHY_CFG_REQ_AUTO_LINK_SPEED_10MB
+	__le16	auto_link_speed_mask;
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEED_MASK_100MBHD     0x1UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEED_MASK_100MB       0x2UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEED_MASK_1GBHD       0x4UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEED_MASK_1GB         0x8UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEED_MASK_2GB         0x10UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEED_MASK_2_5GB       0x20UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEED_MASK_10GB        0x40UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEED_MASK_20GB        0x80UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEED_MASK_25GB        0x100UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEED_MASK_40GB        0x200UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEED_MASK_50GB        0x400UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEED_MASK_100GB       0x800UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEED_MASK_10MBHD      0x1000UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEED_MASK_10MB        0x2000UL
+	u8	wirespeed;
+	#define PORT_PHY_CFG_REQ_WIRESPEED_OFF 0x0UL
+	#define PORT_PHY_CFG_REQ_WIRESPEED_ON  0x1UL
+	#define PORT_PHY_CFG_REQ_WIRESPEED_LAST PORT_PHY_CFG_REQ_WIRESPEED_ON
+	u8	lpbk;
+	#define PORT_PHY_CFG_REQ_LPBK_NONE     0x0UL
+	#define PORT_PHY_CFG_REQ_LPBK_LOCAL    0x1UL
+	#define PORT_PHY_CFG_REQ_LPBK_REMOTE   0x2UL
+	#define PORT_PHY_CFG_REQ_LPBK_EXTERNAL 0x3UL
+	#define PORT_PHY_CFG_REQ_LPBK_LAST    PORT_PHY_CFG_REQ_LPBK_EXTERNAL
+	u8	force_pause;
+	#define PORT_PHY_CFG_REQ_FORCE_PAUSE_TX     0x1UL
+	#define PORT_PHY_CFG_REQ_FORCE_PAUSE_RX     0x2UL
+	u8	unused_1;
+	__le32	preemphasis;
+	__le16	eee_link_speed_mask;
+	#define PORT_PHY_CFG_REQ_EEE_LINK_SPEED_MASK_RSVD1     0x1UL
+	#define PORT_PHY_CFG_REQ_EEE_LINK_SPEED_MASK_100MB     0x2UL
+	#define PORT_PHY_CFG_REQ_EEE_LINK_SPEED_MASK_RSVD2     0x4UL
+	#define PORT_PHY_CFG_REQ_EEE_LINK_SPEED_MASK_1GB       0x8UL
+	#define PORT_PHY_CFG_REQ_EEE_LINK_SPEED_MASK_RSVD3     0x10UL
+	#define PORT_PHY_CFG_REQ_EEE_LINK_SPEED_MASK_RSVD4     0x20UL
+	#define PORT_PHY_CFG_REQ_EEE_LINK_SPEED_MASK_10GB      0x40UL
+	__le16	force_pam4_link_speed;
+	#define PORT_PHY_CFG_REQ_FORCE_PAM4_LINK_SPEED_50GB  0x1f4UL
+	#define PORT_PHY_CFG_REQ_FORCE_PAM4_LINK_SPEED_100GB 0x3e8UL
+	#define PORT_PHY_CFG_REQ_FORCE_PAM4_LINK_SPEED_200GB 0x7d0UL
+	#define PORT_PHY_CFG_REQ_FORCE_PAM4_LINK_SPEED_LAST PORT_PHY_CFG_REQ_FORCE_PAM4_LINK_SPEED_200GB
+	__le32	tx_lpi_timer;
+	#define PORT_PHY_CFG_REQ_TX_LPI_TIMER_MASK 0xffffffUL
+	#define PORT_PHY_CFG_REQ_TX_LPI_TIMER_SFT 0
+	__le16	auto_link_pam4_speed_mask;
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_PAM4_SPEED_MASK_50G      0x1UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_PAM4_SPEED_MASK_100G     0x2UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_PAM4_SPEED_MASK_200G     0x4UL
+	__le16	force_link_speeds2;
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_1GB            0xaUL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_10GB           0x64UL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_25GB           0xfaUL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_40GB           0x190UL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_50GB           0x1f4UL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_100GB          0x3e8UL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_50GB_PAM4_56   0x1f5UL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_100GB_PAM4_56  0x3e9UL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_200GB_PAM4_56  0x7d1UL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_400GB_PAM4_56  0xfa1UL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_100GB_PAM4_112 0x3eaUL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_200GB_PAM4_112 0x7d2UL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_400GB_PAM4_112 0xfa2UL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_800GB_PAM4_112 0x1f42UL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_LAST          PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_800GB_PAM4_112
+	__le16	auto_link_speeds2_mask;
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_MASK_1GB                0x1UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_MASK_10GB               0x2UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_MASK_25GB               0x4UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_MASK_40GB               0x8UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_MASK_50GB               0x10UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_MASK_100GB              0x20UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_MASK_50GB_PAM4_56       0x40UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_MASK_100GB_PAM4_56      0x80UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_MASK_200GB_PAM4_56      0x100UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_MASK_400GB_PAM4_56      0x200UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_MASK_100GB_PAM4_112     0x400UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_MASK_200GB_PAM4_112     0x800UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_MASK_400GB_PAM4_112     0x1000UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_MASK_800GB_PAM4_112     0x2000UL
+	u8	unused_2[6];
+};
+
+/* hwrm_port_phy_cfg_output (size:128b/16B) */
+struct hwrm_port_phy_cfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_port_phy_cfg_cmd_err (size:64b/8B) */
+struct hwrm_port_phy_cfg_cmd_err {
+	u8	code;
+	#define PORT_PHY_CFG_CMD_ERR_CODE_UNKNOWN       0x0UL
+	#define PORT_PHY_CFG_CMD_ERR_CODE_ILLEGAL_SPEED 0x1UL
+	#define PORT_PHY_CFG_CMD_ERR_CODE_RETRY         0x2UL
+	#define PORT_PHY_CFG_CMD_ERR_CODE_LAST         PORT_PHY_CFG_CMD_ERR_CODE_RETRY
+	u8	unused_0[7];
+};
+
+/* hwrm_port_phy_qcfg_input (size:192b/24B) */
+struct hwrm_port_phy_qcfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	port_id;
+	u8	unused_0[6];
+};
+
+/* hwrm_port_phy_qcfg_output (size:832b/104B) */
+struct hwrm_port_phy_qcfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	link;
+	#define PORT_PHY_QCFG_RESP_LINK_NO_LINK 0x0UL
+	#define PORT_PHY_QCFG_RESP_LINK_SIGNAL  0x1UL
+	#define PORT_PHY_QCFG_RESP_LINK_LINK    0x2UL
+	#define PORT_PHY_QCFG_RESP_LINK_LAST   PORT_PHY_QCFG_RESP_LINK_LINK
+	u8	active_fec_signal_mode;
+	#define PORT_PHY_QCFG_RESP_SIGNAL_MODE_MASK                0xfUL
+	#define PORT_PHY_QCFG_RESP_SIGNAL_MODE_SFT                 0
+	#define PORT_PHY_QCFG_RESP_SIGNAL_MODE_NRZ                   0x0UL
+	#define PORT_PHY_QCFG_RESP_SIGNAL_MODE_PAM4                  0x1UL
+	#define PORT_PHY_QCFG_RESP_SIGNAL_MODE_PAM4_112              0x2UL
+	#define PORT_PHY_QCFG_RESP_SIGNAL_MODE_LAST                 PORT_PHY_QCFG_RESP_SIGNAL_MODE_PAM4_112
+	#define PORT_PHY_QCFG_RESP_ACTIVE_FEC_MASK                 0xf0UL
+	#define PORT_PHY_QCFG_RESP_ACTIVE_FEC_SFT                  4
+	#define PORT_PHY_QCFG_RESP_ACTIVE_FEC_FEC_NONE_ACTIVE        (0x0UL << 4)
+	#define PORT_PHY_QCFG_RESP_ACTIVE_FEC_FEC_CLAUSE74_ACTIVE    (0x1UL << 4)
+	#define PORT_PHY_QCFG_RESP_ACTIVE_FEC_FEC_CLAUSE91_ACTIVE    (0x2UL << 4)
+	#define PORT_PHY_QCFG_RESP_ACTIVE_FEC_FEC_RS544_1XN_ACTIVE   (0x3UL << 4)
+	#define PORT_PHY_QCFG_RESP_ACTIVE_FEC_FEC_RS544_IEEE_ACTIVE  (0x4UL << 4)
+	#define PORT_PHY_QCFG_RESP_ACTIVE_FEC_FEC_RS272_1XN_ACTIVE   (0x5UL << 4)
+	#define PORT_PHY_QCFG_RESP_ACTIVE_FEC_FEC_RS272_IEEE_ACTIVE  (0x6UL << 4)
+	#define PORT_PHY_QCFG_RESP_ACTIVE_FEC_LAST                  PORT_PHY_QCFG_RESP_ACTIVE_FEC_FEC_RS272_IEEE_ACTIVE
+	__le16	link_speed;
+	#define PORT_PHY_QCFG_RESP_LINK_SPEED_100MB 0x1UL
+	#define PORT_PHY_QCFG_RESP_LINK_SPEED_1GB   0xaUL
+	#define PORT_PHY_QCFG_RESP_LINK_SPEED_2GB   0x14UL
+	#define PORT_PHY_QCFG_RESP_LINK_SPEED_2_5GB 0x19UL
+	#define PORT_PHY_QCFG_RESP_LINK_SPEED_10GB  0x64UL
+	#define PORT_PHY_QCFG_RESP_LINK_SPEED_20GB  0xc8UL
+	#define PORT_PHY_QCFG_RESP_LINK_SPEED_25GB  0xfaUL
+	#define PORT_PHY_QCFG_RESP_LINK_SPEED_40GB  0x190UL
+	#define PORT_PHY_QCFG_RESP_LINK_SPEED_50GB  0x1f4UL
+	#define PORT_PHY_QCFG_RESP_LINK_SPEED_100GB 0x3e8UL
+	#define PORT_PHY_QCFG_RESP_LINK_SPEED_200GB 0x7d0UL
+	#define PORT_PHY_QCFG_RESP_LINK_SPEED_400GB 0xfa0UL
+	#define PORT_PHY_QCFG_RESP_LINK_SPEED_800GB 0x1f40UL
+	#define PORT_PHY_QCFG_RESP_LINK_SPEED_10MB  0xffffUL
+	#define PORT_PHY_QCFG_RESP_LINK_SPEED_LAST PORT_PHY_QCFG_RESP_LINK_SPEED_10MB
+	u8	duplex_cfg;
+	#define PORT_PHY_QCFG_RESP_DUPLEX_CFG_HALF 0x0UL
+	#define PORT_PHY_QCFG_RESP_DUPLEX_CFG_FULL 0x1UL
+	#define PORT_PHY_QCFG_RESP_DUPLEX_CFG_LAST PORT_PHY_QCFG_RESP_DUPLEX_CFG_FULL
+	u8	pause;
+	#define PORT_PHY_QCFG_RESP_PAUSE_TX     0x1UL
+	#define PORT_PHY_QCFG_RESP_PAUSE_RX     0x2UL
+	__le16	support_speeds;
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS_100MBHD     0x1UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS_100MB       0x2UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS_1GBHD       0x4UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS_1GB         0x8UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS_2GB         0x10UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS_2_5GB       0x20UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS_10GB        0x40UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS_20GB        0x80UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS_25GB        0x100UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS_40GB        0x200UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS_50GB        0x400UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS_100GB       0x800UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS_10MBHD      0x1000UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS_10MB        0x2000UL
+	__le16	force_link_speed;
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEED_100MB 0x1UL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEED_1GB   0xaUL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEED_2GB   0x14UL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEED_2_5GB 0x19UL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEED_10GB  0x64UL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEED_20GB  0xc8UL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEED_25GB  0xfaUL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEED_40GB  0x190UL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEED_50GB  0x1f4UL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEED_100GB 0x3e8UL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEED_10MB  0xffffUL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEED_LAST PORT_PHY_QCFG_RESP_FORCE_LINK_SPEED_10MB
+	u8	auto_mode;
+	#define PORT_PHY_QCFG_RESP_AUTO_MODE_NONE         0x0UL
+	#define PORT_PHY_QCFG_RESP_AUTO_MODE_ALL_SPEEDS   0x1UL
+	#define PORT_PHY_QCFG_RESP_AUTO_MODE_ONE_SPEED    0x2UL
+	#define PORT_PHY_QCFG_RESP_AUTO_MODE_ONE_OR_BELOW 0x3UL
+	#define PORT_PHY_QCFG_RESP_AUTO_MODE_SPEED_MASK   0x4UL
+	#define PORT_PHY_QCFG_RESP_AUTO_MODE_LAST        PORT_PHY_QCFG_RESP_AUTO_MODE_SPEED_MASK
+	u8	auto_pause;
+	#define PORT_PHY_QCFG_RESP_AUTO_PAUSE_TX                0x1UL
+	#define PORT_PHY_QCFG_RESP_AUTO_PAUSE_RX                0x2UL
+	#define PORT_PHY_QCFG_RESP_AUTO_PAUSE_AUTONEG_PAUSE     0x4UL
+	__le16	auto_link_speed;
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEED_100MB 0x1UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEED_1GB   0xaUL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEED_2GB   0x14UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEED_2_5GB 0x19UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEED_10GB  0x64UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEED_20GB  0xc8UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEED_25GB  0xfaUL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEED_40GB  0x190UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEED_50GB  0x1f4UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEED_100GB 0x3e8UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEED_10MB  0xffffUL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEED_LAST PORT_PHY_QCFG_RESP_AUTO_LINK_SPEED_10MB
+	__le16	auto_link_speed_mask;
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEED_MASK_100MBHD     0x1UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEED_MASK_100MB       0x2UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEED_MASK_1GBHD       0x4UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEED_MASK_1GB         0x8UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEED_MASK_2GB         0x10UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEED_MASK_2_5GB       0x20UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEED_MASK_10GB        0x40UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEED_MASK_20GB        0x80UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEED_MASK_25GB        0x100UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEED_MASK_40GB        0x200UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEED_MASK_50GB        0x400UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEED_MASK_100GB       0x800UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEED_MASK_10MBHD      0x1000UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEED_MASK_10MB        0x2000UL
+	u8	wirespeed;
+	#define PORT_PHY_QCFG_RESP_WIRESPEED_OFF 0x0UL
+	#define PORT_PHY_QCFG_RESP_WIRESPEED_ON  0x1UL
+	#define PORT_PHY_QCFG_RESP_WIRESPEED_LAST PORT_PHY_QCFG_RESP_WIRESPEED_ON
+	u8	lpbk;
+	#define PORT_PHY_QCFG_RESP_LPBK_NONE     0x0UL
+	#define PORT_PHY_QCFG_RESP_LPBK_LOCAL    0x1UL
+	#define PORT_PHY_QCFG_RESP_LPBK_REMOTE   0x2UL
+	#define PORT_PHY_QCFG_RESP_LPBK_EXTERNAL 0x3UL
+	#define PORT_PHY_QCFG_RESP_LPBK_LAST    PORT_PHY_QCFG_RESP_LPBK_EXTERNAL
+	u8	force_pause;
+	#define PORT_PHY_QCFG_RESP_FORCE_PAUSE_TX     0x1UL
+	#define PORT_PHY_QCFG_RESP_FORCE_PAUSE_RX     0x2UL
+	u8	module_status;
+	#define PORT_PHY_QCFG_RESP_MODULE_STATUS_NONE          0x0UL
+	#define PORT_PHY_QCFG_RESP_MODULE_STATUS_DISABLETX     0x1UL
+	#define PORT_PHY_QCFG_RESP_MODULE_STATUS_WARNINGMSG    0x2UL
+	#define PORT_PHY_QCFG_RESP_MODULE_STATUS_PWRDOWN       0x3UL
+	#define PORT_PHY_QCFG_RESP_MODULE_STATUS_NOTINSERTED   0x4UL
+	#define PORT_PHY_QCFG_RESP_MODULE_STATUS_CURRENTFAULT  0x5UL
+	#define PORT_PHY_QCFG_RESP_MODULE_STATUS_OVERHEATED    0x6UL
+	#define PORT_PHY_QCFG_RESP_MODULE_STATUS_NOTAPPLICABLE 0xffUL
+	#define PORT_PHY_QCFG_RESP_MODULE_STATUS_LAST         PORT_PHY_QCFG_RESP_MODULE_STATUS_NOTAPPLICABLE
+	__le32	preemphasis;
+	u8	phy_maj;
+	u8	phy_min;
+	u8	phy_bld;
+	u8	phy_type;
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_UNKNOWN          0x0UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_BASECR           0x1UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_BASEKR4          0x2UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_BASELR           0x3UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_BASESR           0x4UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_BASEKR2          0x5UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_BASEKX           0x6UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_BASEKR           0x7UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_BASET            0x8UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_BASETE           0x9UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_SGMIIEXTPHY      0xaUL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_25G_BASECR_CA_L  0xbUL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_25G_BASECR_CA_S  0xcUL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_25G_BASECR_CA_N  0xdUL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_25G_BASESR       0xeUL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASECR4     0xfUL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASESR4     0x10UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASELR4     0x11UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASEER4     0x12UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASESR10    0x13UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_40G_BASECR4      0x14UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_40G_BASESR4      0x15UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_40G_BASELR4      0x16UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_40G_BASEER4      0x17UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_40G_ACTIVE_CABLE 0x18UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_1G_BASET         0x19UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_1G_BASESX        0x1aUL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_1G_BASECX        0x1bUL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_200G_BASECR4     0x1cUL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_200G_BASESR4     0x1dUL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_200G_BASELR4     0x1eUL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_200G_BASEER4     0x1fUL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_50G_BASECR       0x20UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_50G_BASESR       0x21UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_50G_BASELR       0x22UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_50G_BASEER       0x23UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASECR2     0x24UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASESR2     0x25UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASELR2     0x26UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASEER2     0x27UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASECR      0x28UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASESR      0x29UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASELR      0x2aUL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASEER      0x2bUL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_200G_BASECR2     0x2cUL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_200G_BASESR2     0x2dUL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_200G_BASELR2     0x2eUL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_200G_BASEER2     0x2fUL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASECR8     0x30UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASESR8     0x31UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASELR8     0x32UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASEER8     0x33UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASECR4     0x34UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASESR4     0x35UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASELR4     0x36UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASEER4     0x37UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_800G_BASECR8     0x38UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_800G_BASESR8     0x39UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_800G_BASELR8     0x3aUL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_800G_BASEER8     0x3bUL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_800G_BASEFR8     0x3cUL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_800G_BASEDR8     0x3dUL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_LAST            PORT_PHY_QCFG_RESP_PHY_TYPE_800G_BASEDR8
+	u8	media_type;
+	#define PORT_PHY_QCFG_RESP_MEDIA_TYPE_UNKNOWN   0x0UL
+	#define PORT_PHY_QCFG_RESP_MEDIA_TYPE_TP        0x1UL
+	#define PORT_PHY_QCFG_RESP_MEDIA_TYPE_DAC       0x2UL
+	#define PORT_PHY_QCFG_RESP_MEDIA_TYPE_FIBRE     0x3UL
+	#define PORT_PHY_QCFG_RESP_MEDIA_TYPE_BACKPLANE 0x4UL
+	#define PORT_PHY_QCFG_RESP_MEDIA_TYPE_LAST     PORT_PHY_QCFG_RESP_MEDIA_TYPE_BACKPLANE
+	u8	xcvr_pkg_type;
+	#define PORT_PHY_QCFG_RESP_XCVR_PKG_TYPE_XCVR_INTERNAL 0x1UL
+	#define PORT_PHY_QCFG_RESP_XCVR_PKG_TYPE_XCVR_EXTERNAL 0x2UL
+	#define PORT_PHY_QCFG_RESP_XCVR_PKG_TYPE_LAST         PORT_PHY_QCFG_RESP_XCVR_PKG_TYPE_XCVR_EXTERNAL
+	u8	eee_config_phy_addr;
+	#define PORT_PHY_QCFG_RESP_PHY_ADDR_MASK              0x1fUL
+	#define PORT_PHY_QCFG_RESP_PHY_ADDR_SFT               0
+	#define PORT_PHY_QCFG_RESP_EEE_CONFIG_MASK            0xe0UL
+	#define PORT_PHY_QCFG_RESP_EEE_CONFIG_SFT             5
+	#define PORT_PHY_QCFG_RESP_EEE_CONFIG_EEE_ENABLED      0x20UL
+	#define PORT_PHY_QCFG_RESP_EEE_CONFIG_EEE_ACTIVE       0x40UL
+	#define PORT_PHY_QCFG_RESP_EEE_CONFIG_EEE_TX_LPI       0x80UL
+	u8	parallel_detect;
+	#define PORT_PHY_QCFG_RESP_PARALLEL_DETECT     0x1UL
+	__le16	link_partner_adv_speeds;
+	#define PORT_PHY_QCFG_RESP_LINK_PARTNER_ADV_SPEEDS_100MBHD     0x1UL
+	#define PORT_PHY_QCFG_RESP_LINK_PARTNER_ADV_SPEEDS_100MB       0x2UL
+	#define PORT_PHY_QCFG_RESP_LINK_PARTNER_ADV_SPEEDS_1GBHD       0x4UL
+	#define PORT_PHY_QCFG_RESP_LINK_PARTNER_ADV_SPEEDS_1GB         0x8UL
+	#define PORT_PHY_QCFG_RESP_LINK_PARTNER_ADV_SPEEDS_2GB         0x10UL
+	#define PORT_PHY_QCFG_RESP_LINK_PARTNER_ADV_SPEEDS_2_5GB       0x20UL
+	#define PORT_PHY_QCFG_RESP_LINK_PARTNER_ADV_SPEEDS_10GB        0x40UL
+	#define PORT_PHY_QCFG_RESP_LINK_PARTNER_ADV_SPEEDS_20GB        0x80UL
+	#define PORT_PHY_QCFG_RESP_LINK_PARTNER_ADV_SPEEDS_25GB        0x100UL
+	#define PORT_PHY_QCFG_RESP_LINK_PARTNER_ADV_SPEEDS_40GB        0x200UL
+	#define PORT_PHY_QCFG_RESP_LINK_PARTNER_ADV_SPEEDS_50GB        0x400UL
+	#define PORT_PHY_QCFG_RESP_LINK_PARTNER_ADV_SPEEDS_100GB       0x800UL
+	#define PORT_PHY_QCFG_RESP_LINK_PARTNER_ADV_SPEEDS_10MBHD      0x1000UL
+	#define PORT_PHY_QCFG_RESP_LINK_PARTNER_ADV_SPEEDS_10MB        0x2000UL
+	u8	link_partner_adv_auto_mode;
+	#define PORT_PHY_QCFG_RESP_LINK_PARTNER_ADV_AUTO_MODE_NONE         0x0UL
+	#define PORT_PHY_QCFG_RESP_LINK_PARTNER_ADV_AUTO_MODE_ALL_SPEEDS   0x1UL
+	#define PORT_PHY_QCFG_RESP_LINK_PARTNER_ADV_AUTO_MODE_ONE_SPEED    0x2UL
+	#define PORT_PHY_QCFG_RESP_LINK_PARTNER_ADV_AUTO_MODE_ONE_OR_BELOW 0x3UL
+	#define PORT_PHY_QCFG_RESP_LINK_PARTNER_ADV_AUTO_MODE_SPEED_MASK   0x4UL
+	#define PORT_PHY_QCFG_RESP_LINK_PARTNER_ADV_AUTO_MODE_LAST        PORT_PHY_QCFG_RESP_LINK_PARTNER_ADV_AUTO_MODE_SPEED_MASK
+	u8	link_partner_adv_pause;
+	#define PORT_PHY_QCFG_RESP_LINK_PARTNER_ADV_PAUSE_TX     0x1UL
+	#define PORT_PHY_QCFG_RESP_LINK_PARTNER_ADV_PAUSE_RX     0x2UL
+	__le16	adv_eee_link_speed_mask;
+	#define PORT_PHY_QCFG_RESP_ADV_EEE_LINK_SPEED_MASK_RSVD1     0x1UL
+	#define PORT_PHY_QCFG_RESP_ADV_EEE_LINK_SPEED_MASK_100MB     0x2UL
+	#define PORT_PHY_QCFG_RESP_ADV_EEE_LINK_SPEED_MASK_RSVD2     0x4UL
+	#define PORT_PHY_QCFG_RESP_ADV_EEE_LINK_SPEED_MASK_1GB       0x8UL
+	#define PORT_PHY_QCFG_RESP_ADV_EEE_LINK_SPEED_MASK_RSVD3     0x10UL
+	#define PORT_PHY_QCFG_RESP_ADV_EEE_LINK_SPEED_MASK_RSVD4     0x20UL
+	#define PORT_PHY_QCFG_RESP_ADV_EEE_LINK_SPEED_MASK_10GB      0x40UL
+	__le16	link_partner_adv_eee_link_speed_mask;
+	#define PORT_PHY_QCFG_RESP_LINK_PARTNER_ADV_EEE_LINK_SPEED_MASK_RSVD1     0x1UL
+	#define PORT_PHY_QCFG_RESP_LINK_PARTNER_ADV_EEE_LINK_SPEED_MASK_100MB     0x2UL
+	#define PORT_PHY_QCFG_RESP_LINK_PARTNER_ADV_EEE_LINK_SPEED_MASK_RSVD2     0x4UL
+	#define PORT_PHY_QCFG_RESP_LINK_PARTNER_ADV_EEE_LINK_SPEED_MASK_1GB       0x8UL
+	#define PORT_PHY_QCFG_RESP_LINK_PARTNER_ADV_EEE_LINK_SPEED_MASK_RSVD3     0x10UL
+	#define PORT_PHY_QCFG_RESP_LINK_PARTNER_ADV_EEE_LINK_SPEED_MASK_RSVD4     0x20UL
+	#define PORT_PHY_QCFG_RESP_LINK_PARTNER_ADV_EEE_LINK_SPEED_MASK_10GB      0x40UL
+	__le32	xcvr_identifier_type_tx_lpi_timer;
+	#define PORT_PHY_QCFG_RESP_TX_LPI_TIMER_MASK            0xffffffUL
+	#define PORT_PHY_QCFG_RESP_TX_LPI_TIMER_SFT             0
+	#define PORT_PHY_QCFG_RESP_XCVR_IDENTIFIER_TYPE_MASK    0xff000000UL
+	#define PORT_PHY_QCFG_RESP_XCVR_IDENTIFIER_TYPE_SFT     24
+	#define PORT_PHY_QCFG_RESP_XCVR_IDENTIFIER_TYPE_UNKNOWN   (0x0UL << 24)
+	#define PORT_PHY_QCFG_RESP_XCVR_IDENTIFIER_TYPE_SFP       (0x3UL << 24)
+	#define PORT_PHY_QCFG_RESP_XCVR_IDENTIFIER_TYPE_QSFP      (0xcUL << 24)
+	#define PORT_PHY_QCFG_RESP_XCVR_IDENTIFIER_TYPE_QSFPPLUS  (0xdUL << 24)
+	#define PORT_PHY_QCFG_RESP_XCVR_IDENTIFIER_TYPE_QSFP28    (0x11UL << 24)
+	#define PORT_PHY_QCFG_RESP_XCVR_IDENTIFIER_TYPE_QSFPDD    (0x18UL << 24)
+	#define PORT_PHY_QCFG_RESP_XCVR_IDENTIFIER_TYPE_QSFP112   (0x1eUL << 24)
+	#define PORT_PHY_QCFG_RESP_XCVR_IDENTIFIER_TYPE_SFPDD     (0x1fUL << 24)
+	#define PORT_PHY_QCFG_RESP_XCVR_IDENTIFIER_TYPE_CSFP      (0x20UL << 24)
+	#define PORT_PHY_QCFG_RESP_XCVR_IDENTIFIER_TYPE_LAST     PORT_PHY_QCFG_RESP_XCVR_IDENTIFIER_TYPE_CSFP
+	__le16	fec_cfg;
+	#define PORT_PHY_QCFG_RESP_FEC_CFG_FEC_NONE_SUPPORTED           0x1UL
+	#define PORT_PHY_QCFG_RESP_FEC_CFG_FEC_AUTONEG_SUPPORTED        0x2UL
+	#define PORT_PHY_QCFG_RESP_FEC_CFG_FEC_AUTONEG_ENABLED          0x4UL
+	#define PORT_PHY_QCFG_RESP_FEC_CFG_FEC_CLAUSE74_SUPPORTED       0x8UL
+	#define PORT_PHY_QCFG_RESP_FEC_CFG_FEC_CLAUSE74_ENABLED         0x10UL
+	#define PORT_PHY_QCFG_RESP_FEC_CFG_FEC_CLAUSE91_SUPPORTED       0x20UL
+	#define PORT_PHY_QCFG_RESP_FEC_CFG_FEC_CLAUSE91_ENABLED         0x40UL
+	#define PORT_PHY_QCFG_RESP_FEC_CFG_FEC_RS544_1XN_SUPPORTED      0x80UL
+	#define PORT_PHY_QCFG_RESP_FEC_CFG_FEC_RS544_1XN_ENABLED        0x100UL
+	#define PORT_PHY_QCFG_RESP_FEC_CFG_FEC_RS544_IEEE_SUPPORTED     0x200UL
+	#define PORT_PHY_QCFG_RESP_FEC_CFG_FEC_RS544_IEEE_ENABLED       0x400UL
+	#define PORT_PHY_QCFG_RESP_FEC_CFG_FEC_RS272_1XN_SUPPORTED      0x800UL
+	#define PORT_PHY_QCFG_RESP_FEC_CFG_FEC_RS272_1XN_ENABLED        0x1000UL
+	#define PORT_PHY_QCFG_RESP_FEC_CFG_FEC_RS272_IEEE_SUPPORTED     0x2000UL
+	#define PORT_PHY_QCFG_RESP_FEC_CFG_FEC_RS272_IEEE_ENABLED       0x4000UL
+	u8	duplex_state;
+	#define PORT_PHY_QCFG_RESP_DUPLEX_STATE_HALF 0x0UL
+	#define PORT_PHY_QCFG_RESP_DUPLEX_STATE_FULL 0x1UL
+	#define PORT_PHY_QCFG_RESP_DUPLEX_STATE_LAST PORT_PHY_QCFG_RESP_DUPLEX_STATE_FULL
+	u8	option_flags;
+	#define PORT_PHY_QCFG_RESP_OPTION_FLAGS_MEDIA_AUTO_DETECT     0x1UL
+	#define PORT_PHY_QCFG_RESP_OPTION_FLAGS_SIGNAL_MODE_KNOWN     0x2UL
+	#define PORT_PHY_QCFG_RESP_OPTION_FLAGS_SPEEDS2_SUPPORTED     0x4UL
+	#define PORT_PHY_QCFG_RESP_OPTION_FLAGS_LINK_TRAINING         0x8UL
+	#define PORT_PHY_QCFG_RESP_OPTION_FLAGS_PRECODING             0x10UL
+	char	phy_vendor_name[16];
+	char	phy_vendor_partnumber[16];
+	__le16	support_pam4_speeds;
+	#define PORT_PHY_QCFG_RESP_SUPPORT_PAM4_SPEEDS_50G      0x1UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_PAM4_SPEEDS_100G     0x2UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_PAM4_SPEEDS_200G     0x4UL
+	__le16	force_pam4_link_speed;
+	#define PORT_PHY_QCFG_RESP_FORCE_PAM4_LINK_SPEED_50GB  0x1f4UL
+	#define PORT_PHY_QCFG_RESP_FORCE_PAM4_LINK_SPEED_100GB 0x3e8UL
+	#define PORT_PHY_QCFG_RESP_FORCE_PAM4_LINK_SPEED_200GB 0x7d0UL
+	#define PORT_PHY_QCFG_RESP_FORCE_PAM4_LINK_SPEED_LAST PORT_PHY_QCFG_RESP_FORCE_PAM4_LINK_SPEED_200GB
+	__le16	auto_pam4_link_speed_mask;
+	#define PORT_PHY_QCFG_RESP_AUTO_PAM4_LINK_SPEED_MASK_50G      0x1UL
+	#define PORT_PHY_QCFG_RESP_AUTO_PAM4_LINK_SPEED_MASK_100G     0x2UL
+	#define PORT_PHY_QCFG_RESP_AUTO_PAM4_LINK_SPEED_MASK_200G     0x4UL
+	u8	link_partner_pam4_adv_speeds;
+	#define PORT_PHY_QCFG_RESP_LINK_PARTNER_PAM4_ADV_SPEEDS_50GB      0x1UL
+	#define PORT_PHY_QCFG_RESP_LINK_PARTNER_PAM4_ADV_SPEEDS_100GB     0x2UL
+	#define PORT_PHY_QCFG_RESP_LINK_PARTNER_PAM4_ADV_SPEEDS_200GB     0x4UL
+	u8	link_down_reason;
+	#define PORT_PHY_QCFG_RESP_LINK_DOWN_REASON_RF                      0x1UL
+	#define PORT_PHY_QCFG_RESP_LINK_DOWN_REASON_OTP_SPEED_VIOLATION     0x2UL
+	#define PORT_PHY_QCFG_RESP_LINK_DOWN_REASON_CABLE_REMOVED           0x4UL
+	#define PORT_PHY_QCFG_RESP_LINK_DOWN_REASON_MODULE_FAULT            0x8UL
+	#define PORT_PHY_QCFG_RESP_LINK_DOWN_REASON_BMC_REQUEST             0x10UL
+	#define PORT_PHY_QCFG_RESP_LINK_DOWN_REASON_TX_LASER_DISABLED       0x20UL
+	__le16	support_speeds2;
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_1GB                0x1UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_10GB               0x2UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_25GB               0x4UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_40GB               0x8UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_50GB               0x10UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_100GB              0x20UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_50GB_PAM4_56       0x40UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_100GB_PAM4_56      0x80UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_200GB_PAM4_56      0x100UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_400GB_PAM4_56      0x200UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_100GB_PAM4_112     0x400UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_200GB_PAM4_112     0x800UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_400GB_PAM4_112     0x1000UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_800GB_PAM4_112     0x2000UL
+	__le16	force_link_speeds2;
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_1GB            0xaUL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_10GB           0x64UL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_25GB           0xfaUL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_40GB           0x190UL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_50GB           0x1f4UL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_100GB          0x3e8UL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_50GB_PAM4_56   0x1f5UL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_100GB_PAM4_56  0x3e9UL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_200GB_PAM4_56  0x7d1UL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_400GB_PAM4_56  0xfa1UL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_100GB_PAM4_112 0x3eaUL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_200GB_PAM4_112 0x7d2UL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_400GB_PAM4_112 0xfa2UL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_800GB_PAM4_112 0x1f42UL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_LAST          PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_800GB_PAM4_112
+	__le16	auto_link_speeds2;
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEEDS2_1GB                0x1UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEEDS2_10GB               0x2UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEEDS2_25GB               0x4UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEEDS2_40GB               0x8UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEEDS2_50GB               0x10UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEEDS2_100GB              0x20UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEEDS2_50GB_PAM4_56       0x40UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEEDS2_100GB_PAM4_56      0x80UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEEDS2_200GB_PAM4_56      0x100UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEEDS2_400GB_PAM4_56      0x200UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEEDS2_100GB_PAM4_112     0x400UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEEDS2_200GB_PAM4_112     0x800UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEEDS2_400GB_PAM4_112     0x1000UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEEDS2_800GB_PAM4_112     0x2000UL
+	u8	active_lanes;
+	u8	valid;
+};
+
+/* hwrm_port_mac_cfg_input (size:448b/56B) */
+struct hwrm_port_mac_cfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	flags;
+	#define PORT_MAC_CFG_REQ_FLAGS_MATCH_LINK                    0x1UL
+	#define PORT_MAC_CFG_REQ_FLAGS_VLAN_PRI2COS_ENABLE           0x2UL
+	#define PORT_MAC_CFG_REQ_FLAGS_TUNNEL_PRI2COS_ENABLE         0x4UL
+	#define PORT_MAC_CFG_REQ_FLAGS_IP_DSCP2COS_ENABLE            0x8UL
+	#define PORT_MAC_CFG_REQ_FLAGS_PTP_RX_TS_CAPTURE_ENABLE      0x10UL
+	#define PORT_MAC_CFG_REQ_FLAGS_PTP_RX_TS_CAPTURE_DISABLE     0x20UL
+	#define PORT_MAC_CFG_REQ_FLAGS_PTP_TX_TS_CAPTURE_ENABLE      0x40UL
+	#define PORT_MAC_CFG_REQ_FLAGS_PTP_TX_TS_CAPTURE_DISABLE     0x80UL
+	#define PORT_MAC_CFG_REQ_FLAGS_OOB_WOL_ENABLE                0x100UL
+	#define PORT_MAC_CFG_REQ_FLAGS_OOB_WOL_DISABLE               0x200UL
+	#define PORT_MAC_CFG_REQ_FLAGS_VLAN_PRI2COS_DISABLE          0x400UL
+	#define PORT_MAC_CFG_REQ_FLAGS_TUNNEL_PRI2COS_DISABLE        0x800UL
+	#define PORT_MAC_CFG_REQ_FLAGS_IP_DSCP2COS_DISABLE           0x1000UL
+	#define PORT_MAC_CFG_REQ_FLAGS_PTP_ONE_STEP_TX_TS            0x2000UL
+	#define PORT_MAC_CFG_REQ_FLAGS_ALL_RX_TS_CAPTURE_ENABLE      0x4000UL
+	#define PORT_MAC_CFG_REQ_FLAGS_ALL_RX_TS_CAPTURE_DISABLE     0x8000UL
+	__le32	enables;
+	#define PORT_MAC_CFG_REQ_ENABLES_IPG                            0x1UL
+	#define PORT_MAC_CFG_REQ_ENABLES_LPBK                           0x2UL
+	#define PORT_MAC_CFG_REQ_ENABLES_VLAN_PRI2COS_MAP_PRI           0x4UL
+	#define PORT_MAC_CFG_REQ_ENABLES_TUNNEL_PRI2COS_MAP_PRI         0x10UL
+	#define PORT_MAC_CFG_REQ_ENABLES_DSCP2COS_MAP_PRI               0x20UL
+	#define PORT_MAC_CFG_REQ_ENABLES_RX_TS_CAPTURE_PTP_MSG_TYPE     0x40UL
+	#define PORT_MAC_CFG_REQ_ENABLES_TX_TS_CAPTURE_PTP_MSG_TYPE     0x80UL
+	#define PORT_MAC_CFG_REQ_ENABLES_COS_FIELD_CFG                  0x100UL
+	#define PORT_MAC_CFG_REQ_ENABLES_PTP_FREQ_ADJ_PPB               0x200UL
+	#define PORT_MAC_CFG_REQ_ENABLES_PTP_ADJ_PHASE                  0x400UL
+	#define PORT_MAC_CFG_REQ_ENABLES_PTP_LOAD_CONTROL               0x800UL
+	__le16	port_id;
+	u8	ipg;
+	u8	lpbk;
+	#define PORT_MAC_CFG_REQ_LPBK_NONE   0x0UL
+	#define PORT_MAC_CFG_REQ_LPBK_LOCAL  0x1UL
+	#define PORT_MAC_CFG_REQ_LPBK_REMOTE 0x2UL
+	#define PORT_MAC_CFG_REQ_LPBK_LAST  PORT_MAC_CFG_REQ_LPBK_REMOTE
+	u8	vlan_pri2cos_map_pri;
+	u8	reserved1;
+	u8	tunnel_pri2cos_map_pri;
+	u8	dscp2pri_map_pri;
+	__le16	rx_ts_capture_ptp_msg_type;
+	__le16	tx_ts_capture_ptp_msg_type;
+	u8	cos_field_cfg;
+	#define PORT_MAC_CFG_REQ_COS_FIELD_CFG_RSVD1                     0x1UL
+	#define PORT_MAC_CFG_REQ_COS_FIELD_CFG_VLAN_PRI_SEL_MASK         0x6UL
+	#define PORT_MAC_CFG_REQ_COS_FIELD_CFG_VLAN_PRI_SEL_SFT          1
+	#define PORT_MAC_CFG_REQ_COS_FIELD_CFG_VLAN_PRI_SEL_INNERMOST      (0x0UL << 1)
+	#define PORT_MAC_CFG_REQ_COS_FIELD_CFG_VLAN_PRI_SEL_OUTER          (0x1UL << 1)
+	#define PORT_MAC_CFG_REQ_COS_FIELD_CFG_VLAN_PRI_SEL_OUTERMOST      (0x2UL << 1)
+	#define PORT_MAC_CFG_REQ_COS_FIELD_CFG_VLAN_PRI_SEL_UNSPECIFIED    (0x3UL << 1)
+	#define PORT_MAC_CFG_REQ_COS_FIELD_CFG_VLAN_PRI_SEL_LAST          PORT_MAC_CFG_REQ_COS_FIELD_CFG_VLAN_PRI_SEL_UNSPECIFIED
+	#define PORT_MAC_CFG_REQ_COS_FIELD_CFG_T_VLAN_PRI_SEL_MASK       0x18UL
+	#define PORT_MAC_CFG_REQ_COS_FIELD_CFG_T_VLAN_PRI_SEL_SFT        3
+	#define PORT_MAC_CFG_REQ_COS_FIELD_CFG_T_VLAN_PRI_SEL_INNERMOST    (0x0UL << 3)
+	#define PORT_MAC_CFG_REQ_COS_FIELD_CFG_T_VLAN_PRI_SEL_OUTER        (0x1UL << 3)
+	#define PORT_MAC_CFG_REQ_COS_FIELD_CFG_T_VLAN_PRI_SEL_OUTERMOST    (0x2UL << 3)
+	#define PORT_MAC_CFG_REQ_COS_FIELD_CFG_T_VLAN_PRI_SEL_UNSPECIFIED  (0x3UL << 3)
+	#define PORT_MAC_CFG_REQ_COS_FIELD_CFG_T_VLAN_PRI_SEL_LAST        PORT_MAC_CFG_REQ_COS_FIELD_CFG_T_VLAN_PRI_SEL_UNSPECIFIED
+	#define PORT_MAC_CFG_REQ_COS_FIELD_CFG_DEFAULT_COS_MASK          0xe0UL
+	#define PORT_MAC_CFG_REQ_COS_FIELD_CFG_DEFAULT_COS_SFT           5
+	u8	unused_0[3];
+	__s32	ptp_freq_adj_ppb;
+	u8	unused_1[3];
+	u8	ptp_load_control;
+	#define PORT_MAC_CFG_REQ_PTP_LOAD_CONTROL_NONE      0x0UL
+	#define PORT_MAC_CFG_REQ_PTP_LOAD_CONTROL_IMMEDIATE 0x1UL
+	#define PORT_MAC_CFG_REQ_PTP_LOAD_CONTROL_PPS_EVENT 0x2UL
+	#define PORT_MAC_CFG_REQ_PTP_LOAD_CONTROL_LAST     PORT_MAC_CFG_REQ_PTP_LOAD_CONTROL_PPS_EVENT
+	__s64	ptp_adj_phase;
+};
+
+/* hwrm_port_mac_cfg_output (size:128b/16B) */
+struct hwrm_port_mac_cfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	mru;
+	__le16	mtu;
+	u8	ipg;
+	u8	lpbk;
+	#define PORT_MAC_CFG_RESP_LPBK_NONE   0x0UL
+	#define PORT_MAC_CFG_RESP_LPBK_LOCAL  0x1UL
+	#define PORT_MAC_CFG_RESP_LPBK_REMOTE 0x2UL
+	#define PORT_MAC_CFG_RESP_LPBK_LAST  PORT_MAC_CFG_RESP_LPBK_REMOTE
+	u8	unused_0;
+	u8	valid;
+};
+
+/* hwrm_port_mac_ptp_qcfg_input (size:192b/24B) */
+struct hwrm_port_mac_ptp_qcfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	port_id;
+	u8	unused_0[6];
+};
+
+/* hwrm_port_mac_ptp_qcfg_output (size:704b/88B) */
+struct hwrm_port_mac_ptp_qcfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	flags;
+	#define PORT_MAC_PTP_QCFG_RESP_FLAGS_DIRECT_ACCESS                       0x1UL
+	#define PORT_MAC_PTP_QCFG_RESP_FLAGS_ONE_STEP_TX_TS                      0x4UL
+	#define PORT_MAC_PTP_QCFG_RESP_FLAGS_HWRM_ACCESS                         0x8UL
+	#define PORT_MAC_PTP_QCFG_RESP_FLAGS_PARTIAL_DIRECT_ACCESS_REF_CLOCK     0x10UL
+	#define PORT_MAC_PTP_QCFG_RESP_FLAGS_RTC_CONFIGURED                      0x20UL
+	#define PORT_MAC_PTP_QCFG_RESP_FLAGS_64B_PHC_TIME                        0x40UL
+	u8	unused_0[3];
+	__le32	rx_ts_reg_off_lower;
+	__le32	rx_ts_reg_off_upper;
+	__le32	rx_ts_reg_off_seq_id;
+	__le32	rx_ts_reg_off_src_id_0;
+	__le32	rx_ts_reg_off_src_id_1;
+	__le32	rx_ts_reg_off_src_id_2;
+	__le32	rx_ts_reg_off_domain_id;
+	__le32	rx_ts_reg_off_fifo;
+	__le32	rx_ts_reg_off_fifo_adv;
+	__le32	rx_ts_reg_off_granularity;
+	__le32	tx_ts_reg_off_lower;
+	__le32	tx_ts_reg_off_upper;
+	__le32	tx_ts_reg_off_seq_id;
+	__le32	tx_ts_reg_off_fifo;
+	__le32	tx_ts_reg_off_granularity;
+	__le32	ts_ref_clock_reg_lower;
+	__le32	ts_ref_clock_reg_upper;
+	u8	unused_1[7];
+	u8	valid;
+};
+
+/* tx_port_stats (size:3264b/408B) */
+struct tx_port_stats {
+	__le64	tx_64b_frames;
+	__le64	tx_65b_127b_frames;
+	__le64	tx_128b_255b_frames;
+	__le64	tx_256b_511b_frames;
+	__le64	tx_512b_1023b_frames;
+	__le64	tx_1024b_1518b_frames;
+	__le64	tx_good_vlan_frames;
+	__le64	tx_1519b_2047b_frames;
+	__le64	tx_2048b_4095b_frames;
+	__le64	tx_4096b_9216b_frames;
+	__le64	tx_9217b_16383b_frames;
+	__le64	tx_good_frames;
+	__le64	tx_total_frames;
+	__le64	tx_ucast_frames;
+	__le64	tx_mcast_frames;
+	__le64	tx_bcast_frames;
+	__le64	tx_pause_frames;
+	__le64	tx_pfc_frames;
+	__le64	tx_jabber_frames;
+	__le64	tx_fcs_err_frames;
+	__le64	tx_control_frames;
+	__le64	tx_oversz_frames;
+	__le64	tx_single_dfrl_frames;
+	__le64	tx_multi_dfrl_frames;
+	__le64	tx_single_coll_frames;
+	__le64	tx_multi_coll_frames;
+	__le64	tx_late_coll_frames;
+	__le64	tx_excessive_coll_frames;
+	__le64	tx_frag_frames;
+	__le64	tx_err;
+	__le64	tx_tagged_frames;
+	__le64	tx_dbl_tagged_frames;
+	__le64	tx_runt_frames;
+	__le64	tx_fifo_underruns;
+	__le64	tx_pfc_ena_frames_pri0;
+	__le64	tx_pfc_ena_frames_pri1;
+	__le64	tx_pfc_ena_frames_pri2;
+	__le64	tx_pfc_ena_frames_pri3;
+	__le64	tx_pfc_ena_frames_pri4;
+	__le64	tx_pfc_ena_frames_pri5;
+	__le64	tx_pfc_ena_frames_pri6;
+	__le64	tx_pfc_ena_frames_pri7;
+	__le64	tx_eee_lpi_events;
+	__le64	tx_eee_lpi_duration;
+	__le64	tx_llfc_logical_msgs;
+	__le64	tx_hcfc_msgs;
+	__le64	tx_total_collisions;
+	__le64	tx_bytes;
+	__le64	tx_xthol_frames;
+	__le64	tx_stat_discard;
+	__le64	tx_stat_error;
+};
+
+/* rx_port_stats (size:4224b/528B) */
+struct rx_port_stats {
+	__le64	rx_64b_frames;
+	__le64	rx_65b_127b_frames;
+	__le64	rx_128b_255b_frames;
+	__le64	rx_256b_511b_frames;
+	__le64	rx_512b_1023b_frames;
+	__le64	rx_1024b_1518b_frames;
+	__le64	rx_good_vlan_frames;
+	__le64	rx_1519b_2047b_frames;
+	__le64	rx_2048b_4095b_frames;
+	__le64	rx_4096b_9216b_frames;
+	__le64	rx_9217b_16383b_frames;
+	__le64	rx_total_frames;
+	__le64	rx_ucast_frames;
+	__le64	rx_mcast_frames;
+	__le64	rx_bcast_frames;
+	__le64	rx_fcs_err_frames;
+	__le64	rx_ctrl_frames;
+	__le64	rx_pause_frames;
+	__le64	rx_pfc_frames;
+	__le64	rx_unsupported_opcode_frames;
+	__le64	rx_unsupported_da_pausepfc_frames;
+	__le64	rx_wrong_sa_frames;
+	__le64	rx_align_err_frames;
+	__le64	rx_oor_len_frames;
+	__le64	rx_code_err_frames;
+	__le64	rx_false_carrier_frames;
+	__le64	rx_ovrsz_frames;
+	__le64	rx_jbr_frames;
+	__le64	rx_mtu_err_frames;
+	__le64	rx_match_crc_frames;
+	__le64	rx_promiscuous_frames;
+	__le64	rx_tagged_frames;
+	__le64	rx_double_tagged_frames;
+	__le64	rx_trunc_frames;
+	__le64	rx_good_frames;
+	__le64	rx_pfc_xon2xoff_frames_pri0;
+	__le64	rx_pfc_xon2xoff_frames_pri1;
+	__le64	rx_pfc_xon2xoff_frames_pri2;
+	__le64	rx_pfc_xon2xoff_frames_pri3;
+	__le64	rx_pfc_xon2xoff_frames_pri4;
+	__le64	rx_pfc_xon2xoff_frames_pri5;
+	__le64	rx_pfc_xon2xoff_frames_pri6;
+	__le64	rx_pfc_xon2xoff_frames_pri7;
+	__le64	rx_pfc_ena_frames_pri0;
+	__le64	rx_pfc_ena_frames_pri1;
+	__le64	rx_pfc_ena_frames_pri2;
+	__le64	rx_pfc_ena_frames_pri3;
+	__le64	rx_pfc_ena_frames_pri4;
+	__le64	rx_pfc_ena_frames_pri5;
+	__le64	rx_pfc_ena_frames_pri6;
+	__le64	rx_pfc_ena_frames_pri7;
+	__le64	rx_sch_crc_err_frames;
+	__le64	rx_undrsz_frames;
+	__le64	rx_frag_frames;
+	__le64	rx_eee_lpi_events;
+	__le64	rx_eee_lpi_duration;
+	__le64	rx_llfc_physical_msgs;
+	__le64	rx_llfc_logical_msgs;
+	__le64	rx_llfc_msgs_with_crc_err;
+	__le64	rx_hcfc_msgs;
+	__le64	rx_hcfc_msgs_with_crc_err;
+	__le64	rx_bytes;
+	__le64	rx_runt_bytes;
+	__le64	rx_runt_frames;
+	__le64	rx_stat_discard;
+	__le64	rx_stat_err;
+};
+
+/* hwrm_port_qstats_input (size:320b/40B) */
+struct hwrm_port_qstats_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	port_id;
+	u8	flags;
+	#define PORT_QSTATS_REQ_FLAGS_COUNTER_MASK     0x1UL
+	u8	unused_0[5];
+	__le64	tx_stat_host_addr;
+	__le64	rx_stat_host_addr;
+};
+
+/* hwrm_port_qstats_output (size:128b/16B) */
+struct hwrm_port_qstats_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	tx_stat_size;
+	__le16	rx_stat_size;
+	u8	flags;
+	#define PORT_QSTATS_RESP_FLAGS_CLEARED     0x1UL
+	u8	unused_0[2];
+	u8	valid;
+};
+
+/* tx_port_stats_ext (size:2048b/256B) */
+struct tx_port_stats_ext {
+	__le64	tx_bytes_cos0;
+	__le64	tx_bytes_cos1;
+	__le64	tx_bytes_cos2;
+	__le64	tx_bytes_cos3;
+	__le64	tx_bytes_cos4;
+	__le64	tx_bytes_cos5;
+	__le64	tx_bytes_cos6;
+	__le64	tx_bytes_cos7;
+	__le64	tx_packets_cos0;
+	__le64	tx_packets_cos1;
+	__le64	tx_packets_cos2;
+	__le64	tx_packets_cos3;
+	__le64	tx_packets_cos4;
+	__le64	tx_packets_cos5;
+	__le64	tx_packets_cos6;
+	__le64	tx_packets_cos7;
+	__le64	pfc_pri0_tx_duration_us;
+	__le64	pfc_pri0_tx_transitions;
+	__le64	pfc_pri1_tx_duration_us;
+	__le64	pfc_pri1_tx_transitions;
+	__le64	pfc_pri2_tx_duration_us;
+	__le64	pfc_pri2_tx_transitions;
+	__le64	pfc_pri3_tx_duration_us;
+	__le64	pfc_pri3_tx_transitions;
+	__le64	pfc_pri4_tx_duration_us;
+	__le64	pfc_pri4_tx_transitions;
+	__le64	pfc_pri5_tx_duration_us;
+	__le64	pfc_pri5_tx_transitions;
+	__le64	pfc_pri6_tx_duration_us;
+	__le64	pfc_pri6_tx_transitions;
+	__le64	pfc_pri7_tx_duration_us;
+	__le64	pfc_pri7_tx_transitions;
+};
+
+/* rx_port_stats_ext (size:3904b/488B) */
+struct rx_port_stats_ext {
+	__le64	link_down_events;
+	__le64	continuous_pause_events;
+	__le64	resume_pause_events;
+	__le64	continuous_roce_pause_events;
+	__le64	resume_roce_pause_events;
+	__le64	rx_bytes_cos0;
+	__le64	rx_bytes_cos1;
+	__le64	rx_bytes_cos2;
+	__le64	rx_bytes_cos3;
+	__le64	rx_bytes_cos4;
+	__le64	rx_bytes_cos5;
+	__le64	rx_bytes_cos6;
+	__le64	rx_bytes_cos7;
+	__le64	rx_packets_cos0;
+	__le64	rx_packets_cos1;
+	__le64	rx_packets_cos2;
+	__le64	rx_packets_cos3;
+	__le64	rx_packets_cos4;
+	__le64	rx_packets_cos5;
+	__le64	rx_packets_cos6;
+	__le64	rx_packets_cos7;
+	__le64	pfc_pri0_rx_duration_us;
+	__le64	pfc_pri0_rx_transitions;
+	__le64	pfc_pri1_rx_duration_us;
+	__le64	pfc_pri1_rx_transitions;
+	__le64	pfc_pri2_rx_duration_us;
+	__le64	pfc_pri2_rx_transitions;
+	__le64	pfc_pri3_rx_duration_us;
+	__le64	pfc_pri3_rx_transitions;
+	__le64	pfc_pri4_rx_duration_us;
+	__le64	pfc_pri4_rx_transitions;
+	__le64	pfc_pri5_rx_duration_us;
+	__le64	pfc_pri5_rx_transitions;
+	__le64	pfc_pri6_rx_duration_us;
+	__le64	pfc_pri6_rx_transitions;
+	__le64	pfc_pri7_rx_duration_us;
+	__le64	pfc_pri7_rx_transitions;
+	__le64	rx_bits;
+	__le64	rx_buffer_passed_threshold;
+	__le64	rx_pcs_symbol_err;
+	__le64	rx_corrected_bits;
+	__le64	rx_discard_bytes_cos0;
+	__le64	rx_discard_bytes_cos1;
+	__le64	rx_discard_bytes_cos2;
+	__le64	rx_discard_bytes_cos3;
+	__le64	rx_discard_bytes_cos4;
+	__le64	rx_discard_bytes_cos5;
+	__le64	rx_discard_bytes_cos6;
+	__le64	rx_discard_bytes_cos7;
+	__le64	rx_discard_packets_cos0;
+	__le64	rx_discard_packets_cos1;
+	__le64	rx_discard_packets_cos2;
+	__le64	rx_discard_packets_cos3;
+	__le64	rx_discard_packets_cos4;
+	__le64	rx_discard_packets_cos5;
+	__le64	rx_discard_packets_cos6;
+	__le64	rx_discard_packets_cos7;
+	__le64	rx_fec_corrected_blocks;
+	__le64	rx_fec_uncorrectable_blocks;
+	__le64	rx_filter_miss;
+	__le64	rx_fec_symbol_err;
+};
+
+/* hwrm_port_qstats_ext_input (size:320b/40B) */
+struct hwrm_port_qstats_ext_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	port_id;
+	__le16	tx_stat_size;
+	__le16	rx_stat_size;
+	u8	flags;
+	#define PORT_QSTATS_EXT_REQ_FLAGS_COUNTER_MASK     0x1UL
+	u8	unused_0;
+	__le64	tx_stat_host_addr;
+	__le64	rx_stat_host_addr;
+};
+
+/* hwrm_port_qstats_ext_output (size:128b/16B) */
+struct hwrm_port_qstats_ext_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	tx_stat_size;
+	__le16	rx_stat_size;
+	__le16	total_active_cos_queues;
+	u8	flags;
+	#define PORT_QSTATS_EXT_RESP_FLAGS_CLEAR_ROCE_COUNTERS_SUPPORTED     0x1UL
+	#define PORT_QSTATS_EXT_RESP_FLAGS_CLEARED                           0x2UL
+	u8	valid;
+};
+
+/* hwrm_port_qstats_ext_pfc_wd_input (size:256b/32B) */
+struct hwrm_port_qstats_ext_pfc_wd_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	port_id;
+	__le16	pfc_wd_stat_size;
+	u8	unused_0[4];
+	__le64	pfc_wd_stat_host_addr;
+};
+
+/* hwrm_port_qstats_ext_pfc_wd_output (size:128b/16B) */
+struct hwrm_port_qstats_ext_pfc_wd_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	pfc_wd_stat_size;
+	u8	unused_0[5];
+	u8	valid;
+};
+
+/* hwrm_port_lpbk_qstats_input (size:256b/32B) */
+struct hwrm_port_lpbk_qstats_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	lpbk_stat_size;
+	u8	flags;
+	#define PORT_LPBK_QSTATS_REQ_FLAGS_COUNTER_MASK     0x1UL
+	u8	unused_0[5];
+	__le64	lpbk_stat_host_addr;
+};
+
+/* hwrm_port_lpbk_qstats_output (size:128b/16B) */
+struct hwrm_port_lpbk_qstats_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	lpbk_stat_size;
+	u8	unused_0[5];
+	u8	valid;
+};
+
+/* port_lpbk_stats (size:640b/80B) */
+struct port_lpbk_stats {
+	__le64	lpbk_ucast_frames;
+	__le64	lpbk_mcast_frames;
+	__le64	lpbk_bcast_frames;
+	__le64	lpbk_ucast_bytes;
+	__le64	lpbk_mcast_bytes;
+	__le64	lpbk_bcast_bytes;
+	__le64	lpbk_tx_discards;
+	__le64	lpbk_tx_errors;
+	__le64	lpbk_rx_discards;
+	__le64	lpbk_rx_errors;
+};
+
+/* hwrm_port_ecn_qstats_input (size:256b/32B) */
+struct hwrm_port_ecn_qstats_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	port_id;
+	__le16	ecn_stat_buf_size;
+	u8	flags;
+	#define PORT_ECN_QSTATS_REQ_FLAGS_COUNTER_MASK     0x1UL
+	u8	unused_0[3];
+	__le64	ecn_stat_host_addr;
+};
+
+/* hwrm_port_ecn_qstats_output (size:128b/16B) */
+struct hwrm_port_ecn_qstats_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	ecn_stat_buf_size;
+	u8	mark_en;
+	u8	unused_0[4];
+	u8	valid;
+};
+
+/* port_stats_ecn (size:512b/64B) */
+struct port_stats_ecn {
+	__le64	mark_cnt_cos0;
+	__le64	mark_cnt_cos1;
+	__le64	mark_cnt_cos2;
+	__le64	mark_cnt_cos3;
+	__le64	mark_cnt_cos4;
+	__le64	mark_cnt_cos5;
+	__le64	mark_cnt_cos6;
+	__le64	mark_cnt_cos7;
+};
+
+/* port_stats_ext_pfc_adv (size:1536b/192B) */
+struct port_stats_ext_pfc_adv {
+	__le64	pfc_min_duration_time[8];
+	__le64	pfc_max_duration_time[8];
+	__le64	pfc_weighted_duration_time[8];
+};
+
+/* hwrm_port_qstats_ext_pfc_adv_input (size:320b/40B) */
+struct hwrm_port_qstats_ext_pfc_adv_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	port_id;
+	__le16	pfc_adv_stat_size;
+	u8	flags;
+	#define PORT_QSTATS_EXT_PFC_ADV_REQ_FLAGS_COUNTER_MASK     0x1UL
+	u8	unused_0[3];
+	__le64	tx_pfc_adv_stat_host_addr;
+	__le64	rx_pfc_adv_stat_host_addr;
+};
+
+/* hwrm_port_qstats_ext_pfc_adv_output (size:128b/16B) */
+struct hwrm_port_qstats_ext_pfc_adv_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	pfc_adv_stat_size;
+	u8	unused_0[5];
+	u8	valid;
+};
+
+/* hwrm_port_clr_stats_input (size:192b/24B) */
+struct hwrm_port_clr_stats_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	port_id;
+	u8	flags;
+	#define PORT_CLR_STATS_REQ_FLAGS_ROCE_COUNTERS     0x1UL
+	u8	unused_0[5];
+};
+
+/* hwrm_port_clr_stats_output (size:128b/16B) */
+struct hwrm_port_clr_stats_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_port_lpbk_clr_stats_input (size:192b/24B) */
+struct hwrm_port_lpbk_clr_stats_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	port_id;
+	u8	unused_0[6];
+};
+
+/* hwrm_port_lpbk_clr_stats_output (size:128b/16B) */
+struct hwrm_port_lpbk_clr_stats_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_port_ts_query_input (size:320b/40B) */
+struct hwrm_port_ts_query_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	flags;
+	#define PORT_TS_QUERY_REQ_FLAGS_PATH             0x1UL
+	#define PORT_TS_QUERY_REQ_FLAGS_PATH_TX            0x0UL
+	#define PORT_TS_QUERY_REQ_FLAGS_PATH_RX            0x1UL
+	#define PORT_TS_QUERY_REQ_FLAGS_PATH_LAST         PORT_TS_QUERY_REQ_FLAGS_PATH_RX
+	#define PORT_TS_QUERY_REQ_FLAGS_CURRENT_TIME     0x2UL
+	__le16	port_id;
+	u8	unused_0[2];
+	__le16	enables;
+	#define PORT_TS_QUERY_REQ_ENABLES_TS_REQ_TIMEOUT     0x1UL
+	#define PORT_TS_QUERY_REQ_ENABLES_PTP_SEQ_ID         0x2UL
+	#define PORT_TS_QUERY_REQ_ENABLES_PTP_HDR_OFFSET     0x4UL
+	__le16	ts_req_timeout;
+	__le32	ptp_seq_id;
+	__le16	ptp_hdr_offset;
+	u8	unused_1[6];
+};
+
+/* hwrm_port_ts_query_output (size:192b/24B) */
+struct hwrm_port_ts_query_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le64	ptp_msg_ts;
+	__le16	ptp_msg_seqid;
+	u8	unused_0[5];
+	u8	valid;
+};
+
+/* hwrm_port_phy_qcaps_input (size:192b/24B) */
+struct hwrm_port_phy_qcaps_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	port_id;
+	u8	unused_0[6];
+};
+
+/* hwrm_port_phy_qcaps_output (size:320b/40B) */
+struct hwrm_port_phy_qcaps_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	flags;
+	#define PORT_PHY_QCAPS_RESP_FLAGS_EEE_SUPPORTED                    0x1UL
+	#define PORT_PHY_QCAPS_RESP_FLAGS_EXTERNAL_LPBK_SUPPORTED          0x2UL
+	#define PORT_PHY_QCAPS_RESP_FLAGS_AUTONEG_LPBK_SUPPORTED           0x4UL
+	#define PORT_PHY_QCAPS_RESP_FLAGS_SHARED_PHY_CFG_SUPPORTED         0x8UL
+	#define PORT_PHY_QCAPS_RESP_FLAGS_CUMULATIVE_COUNTERS_ON_RESET     0x10UL
+	#define PORT_PHY_QCAPS_RESP_FLAGS_LOCAL_LPBK_NOT_SUPPORTED         0x20UL
+	#define PORT_PHY_QCAPS_RESP_FLAGS_FW_MANAGED_LINK_DOWN             0x40UL
+	#define PORT_PHY_QCAPS_RESP_FLAGS_NO_FCS                           0x80UL
+	u8	port_cnt;
+	#define PORT_PHY_QCAPS_RESP_PORT_CNT_UNKNOWN 0x0UL
+	#define PORT_PHY_QCAPS_RESP_PORT_CNT_1       0x1UL
+	#define PORT_PHY_QCAPS_RESP_PORT_CNT_2       0x2UL
+	#define PORT_PHY_QCAPS_RESP_PORT_CNT_3       0x3UL
+	#define PORT_PHY_QCAPS_RESP_PORT_CNT_4       0x4UL
+	#define PORT_PHY_QCAPS_RESP_PORT_CNT_12      0xcUL
+	#define PORT_PHY_QCAPS_RESP_PORT_CNT_LAST   PORT_PHY_QCAPS_RESP_PORT_CNT_12
+	__le16	supported_speeds_force_mode;
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS_FORCE_MODE_100MBHD     0x1UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS_FORCE_MODE_100MB       0x2UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS_FORCE_MODE_1GBHD       0x4UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS_FORCE_MODE_1GB         0x8UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS_FORCE_MODE_2GB         0x10UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS_FORCE_MODE_2_5GB       0x20UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS_FORCE_MODE_10GB        0x40UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS_FORCE_MODE_20GB        0x80UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS_FORCE_MODE_25GB        0x100UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS_FORCE_MODE_40GB        0x200UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS_FORCE_MODE_50GB        0x400UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS_FORCE_MODE_100GB       0x800UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS_FORCE_MODE_10MBHD      0x1000UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS_FORCE_MODE_10MB        0x2000UL
+	__le16	supported_speeds_auto_mode;
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS_AUTO_MODE_100MBHD     0x1UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS_AUTO_MODE_100MB       0x2UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS_AUTO_MODE_1GBHD       0x4UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS_AUTO_MODE_1GB         0x8UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS_AUTO_MODE_2GB         0x10UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS_AUTO_MODE_2_5GB       0x20UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS_AUTO_MODE_10GB        0x40UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS_AUTO_MODE_20GB        0x80UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS_AUTO_MODE_25GB        0x100UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS_AUTO_MODE_40GB        0x200UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS_AUTO_MODE_50GB        0x400UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS_AUTO_MODE_100GB       0x800UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS_AUTO_MODE_10MBHD      0x1000UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS_AUTO_MODE_10MB        0x2000UL
+	__le16	supported_speeds_eee_mode;
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS_EEE_MODE_RSVD1     0x1UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS_EEE_MODE_100MB     0x2UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS_EEE_MODE_RSVD2     0x4UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS_EEE_MODE_1GB       0x8UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS_EEE_MODE_RSVD3     0x10UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS_EEE_MODE_RSVD4     0x20UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS_EEE_MODE_10GB      0x40UL
+	__le32	tx_lpi_timer_low;
+	#define PORT_PHY_QCAPS_RESP_TX_LPI_TIMER_LOW_MASK 0xffffffUL
+	#define PORT_PHY_QCAPS_RESP_TX_LPI_TIMER_LOW_SFT 0
+	#define PORT_PHY_QCAPS_RESP_RSVD2_MASK           0xff000000UL
+	#define PORT_PHY_QCAPS_RESP_RSVD2_SFT            24
+	__le32	valid_tx_lpi_timer_high;
+	#define PORT_PHY_QCAPS_RESP_TX_LPI_TIMER_HIGH_MASK 0xffffffUL
+	#define PORT_PHY_QCAPS_RESP_TX_LPI_TIMER_HIGH_SFT 0
+	#define PORT_PHY_QCAPS_RESP_RSVD_MASK             0xff000000UL
+	#define PORT_PHY_QCAPS_RESP_RSVD_SFT              24
+	__le16	supported_pam4_speeds_auto_mode;
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_PAM4_SPEEDS_AUTO_MODE_50G      0x1UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_PAM4_SPEEDS_AUTO_MODE_100G     0x2UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_PAM4_SPEEDS_AUTO_MODE_200G     0x4UL
+	__le16	supported_pam4_speeds_force_mode;
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_PAM4_SPEEDS_FORCE_MODE_50G      0x1UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_PAM4_SPEEDS_FORCE_MODE_100G     0x2UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_PAM4_SPEEDS_FORCE_MODE_200G     0x4UL
+	__le16	flags2;
+	#define PORT_PHY_QCAPS_RESP_FLAGS2_PAUSE_UNSUPPORTED           0x1UL
+	#define PORT_PHY_QCAPS_RESP_FLAGS2_PFC_UNSUPPORTED             0x2UL
+	#define PORT_PHY_QCAPS_RESP_FLAGS2_BANK_ADDR_SUPPORTED         0x4UL
+	#define PORT_PHY_QCAPS_RESP_FLAGS2_SPEEDS2_SUPPORTED           0x8UL
+	#define PORT_PHY_QCAPS_RESP_FLAGS2_REMOTE_LPBK_UNSUPPORTED     0x10UL
+	#define PORT_PHY_QCAPS_RESP_FLAGS2_PFC_ADV_STATS_SUPPORTED     0x20UL
+	u8	internal_port_cnt;
+	u8	unused_0;
+	__le16	supported_speeds2_force_mode;
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_FORCE_MODE_1GB                0x1UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_FORCE_MODE_10GB               0x2UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_FORCE_MODE_25GB               0x4UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_FORCE_MODE_40GB               0x8UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_FORCE_MODE_50GB               0x10UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_FORCE_MODE_100GB              0x20UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_FORCE_MODE_50GB_PAM4_56       0x40UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_FORCE_MODE_100GB_PAM4_56      0x80UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_FORCE_MODE_200GB_PAM4_56      0x100UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_FORCE_MODE_400GB_PAM4_56      0x200UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_FORCE_MODE_100GB_PAM4_112     0x400UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_FORCE_MODE_200GB_PAM4_112     0x800UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_FORCE_MODE_400GB_PAM4_112     0x1000UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_FORCE_MODE_800GB_PAM4_112     0x2000UL
+	__le16	supported_speeds2_auto_mode;
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_AUTO_MODE_1GB                0x1UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_AUTO_MODE_10GB               0x2UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_AUTO_MODE_25GB               0x4UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_AUTO_MODE_40GB               0x8UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_AUTO_MODE_50GB               0x10UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_AUTO_MODE_100GB              0x20UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_AUTO_MODE_50GB_PAM4_56       0x40UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_AUTO_MODE_100GB_PAM4_56      0x80UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_AUTO_MODE_200GB_PAM4_56      0x100UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_AUTO_MODE_400GB_PAM4_56      0x200UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_AUTO_MODE_100GB_PAM4_112     0x400UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_AUTO_MODE_200GB_PAM4_112     0x800UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_AUTO_MODE_400GB_PAM4_112     0x1000UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_AUTO_MODE_800GB_PAM4_112     0x2000UL
+	u8	unused_1[3];
+	u8	valid;
+};
+
+/* hwrm_port_phy_i2c_write_input (size:832b/104B) */
+struct hwrm_port_phy_i2c_write_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	flags;
+	__le32	enables;
+	#define PORT_PHY_I2C_WRITE_REQ_ENABLES_PAGE_OFFSET     0x1UL
+	#define PORT_PHY_I2C_WRITE_REQ_ENABLES_BANK_NUMBER     0x2UL
+	__le16	port_id;
+	u8	i2c_slave_addr;
+	u8	bank_number;
+	__le16	page_number;
+	__le16	page_offset;
+	u8	data_length;
+	u8	unused_1[7];
+	__le32	data[16];
+};
+
+/* hwrm_port_phy_i2c_write_output (size:128b/16B) */
+struct hwrm_port_phy_i2c_write_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_port_phy_i2c_read_input (size:320b/40B) */
+struct hwrm_port_phy_i2c_read_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	flags;
+	__le32	enables;
+	#define PORT_PHY_I2C_READ_REQ_ENABLES_PAGE_OFFSET     0x1UL
+	#define PORT_PHY_I2C_READ_REQ_ENABLES_BANK_NUMBER     0x2UL
+	__le16	port_id;
+	u8	i2c_slave_addr;
+	u8	bank_number;
+	__le16	page_number;
+	__le16	page_offset;
+	u8	data_length;
+	u8	unused_1[7];
+};
+
+/* hwrm_port_phy_i2c_read_output (size:640b/80B) */
+struct hwrm_port_phy_i2c_read_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le32	data[16];
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_port_phy_mdio_write_input (size:320b/40B) */
+struct hwrm_port_phy_mdio_write_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	unused_0[2];
+	__le16	port_id;
+	u8	phy_addr;
+	u8	dev_addr;
+	__le16	reg_addr;
+	__le16	reg_data;
+	u8	cl45_mdio;
+	u8	unused_1[7];
+};
+
+/* hwrm_port_phy_mdio_write_output (size:128b/16B) */
+struct hwrm_port_phy_mdio_write_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_port_phy_mdio_read_input (size:256b/32B) */
+struct hwrm_port_phy_mdio_read_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	unused_0[2];
+	__le16	port_id;
+	u8	phy_addr;
+	u8	dev_addr;
+	__le16	reg_addr;
+	u8	cl45_mdio;
+	u8	unused_1;
+};
+
+/* hwrm_port_phy_mdio_read_output (size:128b/16B) */
+struct hwrm_port_phy_mdio_read_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	reg_data;
+	u8	unused_0[5];
+	u8	valid;
+};
+
+/* hwrm_port_led_cfg_input (size:512b/64B) */
+struct hwrm_port_led_cfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	enables;
+	#define PORT_LED_CFG_REQ_ENABLES_LED0_ID            0x1UL
+	#define PORT_LED_CFG_REQ_ENABLES_LED0_STATE         0x2UL
+	#define PORT_LED_CFG_REQ_ENABLES_LED0_COLOR         0x4UL
+	#define PORT_LED_CFG_REQ_ENABLES_LED0_BLINK_ON      0x8UL
+	#define PORT_LED_CFG_REQ_ENABLES_LED0_BLINK_OFF     0x10UL
+	#define PORT_LED_CFG_REQ_ENABLES_LED0_GROUP_ID      0x20UL
+	#define PORT_LED_CFG_REQ_ENABLES_LED1_ID            0x40UL
+	#define PORT_LED_CFG_REQ_ENABLES_LED1_STATE         0x80UL
+	#define PORT_LED_CFG_REQ_ENABLES_LED1_COLOR         0x100UL
+	#define PORT_LED_CFG_REQ_ENABLES_LED1_BLINK_ON      0x200UL
+	#define PORT_LED_CFG_REQ_ENABLES_LED1_BLINK_OFF     0x400UL
+	#define PORT_LED_CFG_REQ_ENABLES_LED1_GROUP_ID      0x800UL
+	#define PORT_LED_CFG_REQ_ENABLES_LED2_ID            0x1000UL
+	#define PORT_LED_CFG_REQ_ENABLES_LED2_STATE         0x2000UL
+	#define PORT_LED_CFG_REQ_ENABLES_LED2_COLOR         0x4000UL
+	#define PORT_LED_CFG_REQ_ENABLES_LED2_BLINK_ON      0x8000UL
+	#define PORT_LED_CFG_REQ_ENABLES_LED2_BLINK_OFF     0x10000UL
+	#define PORT_LED_CFG_REQ_ENABLES_LED2_GROUP_ID      0x20000UL
+	#define PORT_LED_CFG_REQ_ENABLES_LED3_ID            0x40000UL
+	#define PORT_LED_CFG_REQ_ENABLES_LED3_STATE         0x80000UL
+	#define PORT_LED_CFG_REQ_ENABLES_LED3_COLOR         0x100000UL
+	#define PORT_LED_CFG_REQ_ENABLES_LED3_BLINK_ON      0x200000UL
+	#define PORT_LED_CFG_REQ_ENABLES_LED3_BLINK_OFF     0x400000UL
+	#define PORT_LED_CFG_REQ_ENABLES_LED3_GROUP_ID      0x800000UL
+	__le16	port_id;
+	u8	num_leds;
+	u8	rsvd;
+	u8	led0_id;
+	u8	led0_state;
+	#define PORT_LED_CFG_REQ_LED0_STATE_DEFAULT  0x0UL
+	#define PORT_LED_CFG_REQ_LED0_STATE_OFF      0x1UL
+	#define PORT_LED_CFG_REQ_LED0_STATE_ON       0x2UL
+	#define PORT_LED_CFG_REQ_LED0_STATE_BLINK    0x3UL
+	#define PORT_LED_CFG_REQ_LED0_STATE_BLINKALT 0x4UL
+	#define PORT_LED_CFG_REQ_LED0_STATE_LAST    PORT_LED_CFG_REQ_LED0_STATE_BLINKALT
+	u8	led0_color;
+	#define PORT_LED_CFG_REQ_LED0_COLOR_DEFAULT    0x0UL
+	#define PORT_LED_CFG_REQ_LED0_COLOR_AMBER      0x1UL
+	#define PORT_LED_CFG_REQ_LED0_COLOR_GREEN      0x2UL
+	#define PORT_LED_CFG_REQ_LED0_COLOR_GREENAMBER 0x3UL
+	#define PORT_LED_CFG_REQ_LED0_COLOR_LAST      PORT_LED_CFG_REQ_LED0_COLOR_GREENAMBER
+	u8	unused_0;
+	__le16	led0_blink_on;
+	__le16	led0_blink_off;
+	u8	led0_group_id;
+	u8	rsvd0;
+	u8	led1_id;
+	u8	led1_state;
+	#define PORT_LED_CFG_REQ_LED1_STATE_DEFAULT  0x0UL
+	#define PORT_LED_CFG_REQ_LED1_STATE_OFF      0x1UL
+	#define PORT_LED_CFG_REQ_LED1_STATE_ON       0x2UL
+	#define PORT_LED_CFG_REQ_LED1_STATE_BLINK    0x3UL
+	#define PORT_LED_CFG_REQ_LED1_STATE_BLINKALT 0x4UL
+	#define PORT_LED_CFG_REQ_LED1_STATE_LAST    PORT_LED_CFG_REQ_LED1_STATE_BLINKALT
+	u8	led1_color;
+	#define PORT_LED_CFG_REQ_LED1_COLOR_DEFAULT    0x0UL
+	#define PORT_LED_CFG_REQ_LED1_COLOR_AMBER      0x1UL
+	#define PORT_LED_CFG_REQ_LED1_COLOR_GREEN      0x2UL
+	#define PORT_LED_CFG_REQ_LED1_COLOR_GREENAMBER 0x3UL
+	#define PORT_LED_CFG_REQ_LED1_COLOR_LAST      PORT_LED_CFG_REQ_LED1_COLOR_GREENAMBER
+	u8	unused_1;
+	__le16	led1_blink_on;
+	__le16	led1_blink_off;
+	u8	led1_group_id;
+	u8	rsvd1;
+	u8	led2_id;
+	u8	led2_state;
+	#define PORT_LED_CFG_REQ_LED2_STATE_DEFAULT  0x0UL
+	#define PORT_LED_CFG_REQ_LED2_STATE_OFF      0x1UL
+	#define PORT_LED_CFG_REQ_LED2_STATE_ON       0x2UL
+	#define PORT_LED_CFG_REQ_LED2_STATE_BLINK    0x3UL
+	#define PORT_LED_CFG_REQ_LED2_STATE_BLINKALT 0x4UL
+	#define PORT_LED_CFG_REQ_LED2_STATE_LAST    PORT_LED_CFG_REQ_LED2_STATE_BLINKALT
+	u8	led2_color;
+	#define PORT_LED_CFG_REQ_LED2_COLOR_DEFAULT    0x0UL
+	#define PORT_LED_CFG_REQ_LED2_COLOR_AMBER      0x1UL
+	#define PORT_LED_CFG_REQ_LED2_COLOR_GREEN      0x2UL
+	#define PORT_LED_CFG_REQ_LED2_COLOR_GREENAMBER 0x3UL
+	#define PORT_LED_CFG_REQ_LED2_COLOR_LAST      PORT_LED_CFG_REQ_LED2_COLOR_GREENAMBER
+	u8	unused_2;
+	__le16	led2_blink_on;
+	__le16	led2_blink_off;
+	u8	led2_group_id;
+	u8	rsvd2;
+	u8	led3_id;
+	u8	led3_state;
+	#define PORT_LED_CFG_REQ_LED3_STATE_DEFAULT  0x0UL
+	#define PORT_LED_CFG_REQ_LED3_STATE_OFF      0x1UL
+	#define PORT_LED_CFG_REQ_LED3_STATE_ON       0x2UL
+	#define PORT_LED_CFG_REQ_LED3_STATE_BLINK    0x3UL
+	#define PORT_LED_CFG_REQ_LED3_STATE_BLINKALT 0x4UL
+	#define PORT_LED_CFG_REQ_LED3_STATE_LAST    PORT_LED_CFG_REQ_LED3_STATE_BLINKALT
+	u8	led3_color;
+	#define PORT_LED_CFG_REQ_LED3_COLOR_DEFAULT    0x0UL
+	#define PORT_LED_CFG_REQ_LED3_COLOR_AMBER      0x1UL
+	#define PORT_LED_CFG_REQ_LED3_COLOR_GREEN      0x2UL
+	#define PORT_LED_CFG_REQ_LED3_COLOR_GREENAMBER 0x3UL
+	#define PORT_LED_CFG_REQ_LED3_COLOR_LAST      PORT_LED_CFG_REQ_LED3_COLOR_GREENAMBER
+	u8	unused_3;
+	__le16	led3_blink_on;
+	__le16	led3_blink_off;
+	u8	led3_group_id;
+	u8	rsvd3;
+};
+
+/* hwrm_port_led_cfg_output (size:128b/16B) */
+struct hwrm_port_led_cfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_port_led_qcfg_input (size:192b/24B) */
+struct hwrm_port_led_qcfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	port_id;
+	u8	unused_0[6];
+};
+
+/* hwrm_port_led_qcfg_output (size:448b/56B) */
+struct hwrm_port_led_qcfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	num_leds;
+	u8	led0_id;
+	u8	led0_type;
+	#define PORT_LED_QCFG_RESP_LED0_TYPE_SPEED    0x0UL
+	#define PORT_LED_QCFG_RESP_LED0_TYPE_ACTIVITY 0x1UL
+	#define PORT_LED_QCFG_RESP_LED0_TYPE_INVALID  0xffUL
+	#define PORT_LED_QCFG_RESP_LED0_TYPE_LAST    PORT_LED_QCFG_RESP_LED0_TYPE_INVALID
+	u8	led0_state;
+	#define PORT_LED_QCFG_RESP_LED0_STATE_DEFAULT  0x0UL
+	#define PORT_LED_QCFG_RESP_LED0_STATE_OFF      0x1UL
+	#define PORT_LED_QCFG_RESP_LED0_STATE_ON       0x2UL
+	#define PORT_LED_QCFG_RESP_LED0_STATE_BLINK    0x3UL
+	#define PORT_LED_QCFG_RESP_LED0_STATE_BLINKALT 0x4UL
+	#define PORT_LED_QCFG_RESP_LED0_STATE_LAST    PORT_LED_QCFG_RESP_LED0_STATE_BLINKALT
+	u8	led0_color;
+	#define PORT_LED_QCFG_RESP_LED0_COLOR_DEFAULT    0x0UL
+	#define PORT_LED_QCFG_RESP_LED0_COLOR_AMBER      0x1UL
+	#define PORT_LED_QCFG_RESP_LED0_COLOR_GREEN      0x2UL
+	#define PORT_LED_QCFG_RESP_LED0_COLOR_GREENAMBER 0x3UL
+	#define PORT_LED_QCFG_RESP_LED0_COLOR_LAST      PORT_LED_QCFG_RESP_LED0_COLOR_GREENAMBER
+	u8	unused_0;
+	__le16	led0_blink_on;
+	__le16	led0_blink_off;
+	u8	led0_group_id;
+	u8	led1_id;
+	u8	led1_type;
+	#define PORT_LED_QCFG_RESP_LED1_TYPE_SPEED    0x0UL
+	#define PORT_LED_QCFG_RESP_LED1_TYPE_ACTIVITY 0x1UL
+	#define PORT_LED_QCFG_RESP_LED1_TYPE_INVALID  0xffUL
+	#define PORT_LED_QCFG_RESP_LED1_TYPE_LAST    PORT_LED_QCFG_RESP_LED1_TYPE_INVALID
+	u8	led1_state;
+	#define PORT_LED_QCFG_RESP_LED1_STATE_DEFAULT  0x0UL
+	#define PORT_LED_QCFG_RESP_LED1_STATE_OFF      0x1UL
+	#define PORT_LED_QCFG_RESP_LED1_STATE_ON       0x2UL
+	#define PORT_LED_QCFG_RESP_LED1_STATE_BLINK    0x3UL
+	#define PORT_LED_QCFG_RESP_LED1_STATE_BLINKALT 0x4UL
+	#define PORT_LED_QCFG_RESP_LED1_STATE_LAST    PORT_LED_QCFG_RESP_LED1_STATE_BLINKALT
+	u8	led1_color;
+	#define PORT_LED_QCFG_RESP_LED1_COLOR_DEFAULT    0x0UL
+	#define PORT_LED_QCFG_RESP_LED1_COLOR_AMBER      0x1UL
+	#define PORT_LED_QCFG_RESP_LED1_COLOR_GREEN      0x2UL
+	#define PORT_LED_QCFG_RESP_LED1_COLOR_GREENAMBER 0x3UL
+	#define PORT_LED_QCFG_RESP_LED1_COLOR_LAST      PORT_LED_QCFG_RESP_LED1_COLOR_GREENAMBER
+	u8	unused_1;
+	__le16	led1_blink_on;
+	__le16	led1_blink_off;
+	u8	led1_group_id;
+	u8	led2_id;
+	u8	led2_type;
+	#define PORT_LED_QCFG_RESP_LED2_TYPE_SPEED    0x0UL
+	#define PORT_LED_QCFG_RESP_LED2_TYPE_ACTIVITY 0x1UL
+	#define PORT_LED_QCFG_RESP_LED2_TYPE_INVALID  0xffUL
+	#define PORT_LED_QCFG_RESP_LED2_TYPE_LAST    PORT_LED_QCFG_RESP_LED2_TYPE_INVALID
+	u8	led2_state;
+	#define PORT_LED_QCFG_RESP_LED2_STATE_DEFAULT  0x0UL
+	#define PORT_LED_QCFG_RESP_LED2_STATE_OFF      0x1UL
+	#define PORT_LED_QCFG_RESP_LED2_STATE_ON       0x2UL
+	#define PORT_LED_QCFG_RESP_LED2_STATE_BLINK    0x3UL
+	#define PORT_LED_QCFG_RESP_LED2_STATE_BLINKALT 0x4UL
+	#define PORT_LED_QCFG_RESP_LED2_STATE_LAST    PORT_LED_QCFG_RESP_LED2_STATE_BLINKALT
+	u8	led2_color;
+	#define PORT_LED_QCFG_RESP_LED2_COLOR_DEFAULT    0x0UL
+	#define PORT_LED_QCFG_RESP_LED2_COLOR_AMBER      0x1UL
+	#define PORT_LED_QCFG_RESP_LED2_COLOR_GREEN      0x2UL
+	#define PORT_LED_QCFG_RESP_LED2_COLOR_GREENAMBER 0x3UL
+	#define PORT_LED_QCFG_RESP_LED2_COLOR_LAST      PORT_LED_QCFG_RESP_LED2_COLOR_GREENAMBER
+	u8	unused_2;
+	__le16	led2_blink_on;
+	__le16	led2_blink_off;
+	u8	led2_group_id;
+	u8	led3_id;
+	u8	led3_type;
+	#define PORT_LED_QCFG_RESP_LED3_TYPE_SPEED    0x0UL
+	#define PORT_LED_QCFG_RESP_LED3_TYPE_ACTIVITY 0x1UL
+	#define PORT_LED_QCFG_RESP_LED3_TYPE_INVALID  0xffUL
+	#define PORT_LED_QCFG_RESP_LED3_TYPE_LAST    PORT_LED_QCFG_RESP_LED3_TYPE_INVALID
+	u8	led3_state;
+	#define PORT_LED_QCFG_RESP_LED3_STATE_DEFAULT  0x0UL
+	#define PORT_LED_QCFG_RESP_LED3_STATE_OFF      0x1UL
+	#define PORT_LED_QCFG_RESP_LED3_STATE_ON       0x2UL
+	#define PORT_LED_QCFG_RESP_LED3_STATE_BLINK    0x3UL
+	#define PORT_LED_QCFG_RESP_LED3_STATE_BLINKALT 0x4UL
+	#define PORT_LED_QCFG_RESP_LED3_STATE_LAST    PORT_LED_QCFG_RESP_LED3_STATE_BLINKALT
+	u8	led3_color;
+	#define PORT_LED_QCFG_RESP_LED3_COLOR_DEFAULT    0x0UL
+	#define PORT_LED_QCFG_RESP_LED3_COLOR_AMBER      0x1UL
+	#define PORT_LED_QCFG_RESP_LED3_COLOR_GREEN      0x2UL
+	#define PORT_LED_QCFG_RESP_LED3_COLOR_GREENAMBER 0x3UL
+	#define PORT_LED_QCFG_RESP_LED3_COLOR_LAST      PORT_LED_QCFG_RESP_LED3_COLOR_GREENAMBER
+	u8	unused_3;
+	__le16	led3_blink_on;
+	__le16	led3_blink_off;
+	u8	led3_group_id;
+	u8	unused_4[6];
+	u8	valid;
+};
+
+/* hwrm_port_led_qcaps_input (size:192b/24B) */
+struct hwrm_port_led_qcaps_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	port_id;
+	u8	unused_0[6];
+};
+
+/* hwrm_port_led_qcaps_output (size:384b/48B) */
+struct hwrm_port_led_qcaps_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	num_leds;
+	u8	unused[3];
+	u8	led0_id;
+	u8	led0_type;
+	#define PORT_LED_QCAPS_RESP_LED0_TYPE_SPEED    0x0UL
+	#define PORT_LED_QCAPS_RESP_LED0_TYPE_ACTIVITY 0x1UL
+	#define PORT_LED_QCAPS_RESP_LED0_TYPE_INVALID  0xffUL
+	#define PORT_LED_QCAPS_RESP_LED0_TYPE_LAST    PORT_LED_QCAPS_RESP_LED0_TYPE_INVALID
+	u8	led0_group_id;
+	u8	unused_0;
+	__le16	led0_state_caps;
+	#define PORT_LED_QCAPS_RESP_LED0_STATE_CAPS_ENABLED                 0x1UL
+	#define PORT_LED_QCAPS_RESP_LED0_STATE_CAPS_OFF_SUPPORTED           0x2UL
+	#define PORT_LED_QCAPS_RESP_LED0_STATE_CAPS_ON_SUPPORTED            0x4UL
+	#define PORT_LED_QCAPS_RESP_LED0_STATE_CAPS_BLINK_SUPPORTED         0x8UL
+	#define PORT_LED_QCAPS_RESP_LED0_STATE_CAPS_BLINK_ALT_SUPPORTED     0x10UL
+	__le16	led0_color_caps;
+	#define PORT_LED_QCAPS_RESP_LED0_COLOR_CAPS_RSVD                 0x1UL
+	#define PORT_LED_QCAPS_RESP_LED0_COLOR_CAPS_AMBER_SUPPORTED      0x2UL
+	#define PORT_LED_QCAPS_RESP_LED0_COLOR_CAPS_GREEN_SUPPORTED      0x4UL
+	#define PORT_LED_QCAPS_RESP_LED0_COLOR_CAPS_GRNAMB_SUPPORTED     0x8UL
+	u8	led1_id;
+	u8	led1_type;
+	#define PORT_LED_QCAPS_RESP_LED1_TYPE_SPEED    0x0UL
+	#define PORT_LED_QCAPS_RESP_LED1_TYPE_ACTIVITY 0x1UL
+	#define PORT_LED_QCAPS_RESP_LED1_TYPE_INVALID  0xffUL
+	#define PORT_LED_QCAPS_RESP_LED1_TYPE_LAST    PORT_LED_QCAPS_RESP_LED1_TYPE_INVALID
+	u8	led1_group_id;
+	u8	unused_1;
+	__le16	led1_state_caps;
+	#define PORT_LED_QCAPS_RESP_LED1_STATE_CAPS_ENABLED                 0x1UL
+	#define PORT_LED_QCAPS_RESP_LED1_STATE_CAPS_OFF_SUPPORTED           0x2UL
+	#define PORT_LED_QCAPS_RESP_LED1_STATE_CAPS_ON_SUPPORTED            0x4UL
+	#define PORT_LED_QCAPS_RESP_LED1_STATE_CAPS_BLINK_SUPPORTED         0x8UL
+	#define PORT_LED_QCAPS_RESP_LED1_STATE_CAPS_BLINK_ALT_SUPPORTED     0x10UL
+	__le16	led1_color_caps;
+	#define PORT_LED_QCAPS_RESP_LED1_COLOR_CAPS_RSVD                 0x1UL
+	#define PORT_LED_QCAPS_RESP_LED1_COLOR_CAPS_AMBER_SUPPORTED      0x2UL
+	#define PORT_LED_QCAPS_RESP_LED1_COLOR_CAPS_GREEN_SUPPORTED      0x4UL
+	#define PORT_LED_QCAPS_RESP_LED1_COLOR_CAPS_GRNAMB_SUPPORTED     0x8UL
+	u8	led2_id;
+	u8	led2_type;
+	#define PORT_LED_QCAPS_RESP_LED2_TYPE_SPEED    0x0UL
+	#define PORT_LED_QCAPS_RESP_LED2_TYPE_ACTIVITY 0x1UL
+	#define PORT_LED_QCAPS_RESP_LED2_TYPE_INVALID  0xffUL
+	#define PORT_LED_QCAPS_RESP_LED2_TYPE_LAST    PORT_LED_QCAPS_RESP_LED2_TYPE_INVALID
+	u8	led2_group_id;
+	u8	unused_2;
+	__le16	led2_state_caps;
+	#define PORT_LED_QCAPS_RESP_LED2_STATE_CAPS_ENABLED                 0x1UL
+	#define PORT_LED_QCAPS_RESP_LED2_STATE_CAPS_OFF_SUPPORTED           0x2UL
+	#define PORT_LED_QCAPS_RESP_LED2_STATE_CAPS_ON_SUPPORTED            0x4UL
+	#define PORT_LED_QCAPS_RESP_LED2_STATE_CAPS_BLINK_SUPPORTED         0x8UL
+	#define PORT_LED_QCAPS_RESP_LED2_STATE_CAPS_BLINK_ALT_SUPPORTED     0x10UL
+	__le16	led2_color_caps;
+	#define PORT_LED_QCAPS_RESP_LED2_COLOR_CAPS_RSVD                 0x1UL
+	#define PORT_LED_QCAPS_RESP_LED2_COLOR_CAPS_AMBER_SUPPORTED      0x2UL
+	#define PORT_LED_QCAPS_RESP_LED2_COLOR_CAPS_GREEN_SUPPORTED      0x4UL
+	#define PORT_LED_QCAPS_RESP_LED2_COLOR_CAPS_GRNAMB_SUPPORTED     0x8UL
+	u8	led3_id;
+	u8	led3_type;
+	#define PORT_LED_QCAPS_RESP_LED3_TYPE_SPEED    0x0UL
+	#define PORT_LED_QCAPS_RESP_LED3_TYPE_ACTIVITY 0x1UL
+	#define PORT_LED_QCAPS_RESP_LED3_TYPE_INVALID  0xffUL
+	#define PORT_LED_QCAPS_RESP_LED3_TYPE_LAST    PORT_LED_QCAPS_RESP_LED3_TYPE_INVALID
+	u8	led3_group_id;
+	u8	unused_3;
+	__le16	led3_state_caps;
+	#define PORT_LED_QCAPS_RESP_LED3_STATE_CAPS_ENABLED                 0x1UL
+	#define PORT_LED_QCAPS_RESP_LED3_STATE_CAPS_OFF_SUPPORTED           0x2UL
+	#define PORT_LED_QCAPS_RESP_LED3_STATE_CAPS_ON_SUPPORTED            0x4UL
+	#define PORT_LED_QCAPS_RESP_LED3_STATE_CAPS_BLINK_SUPPORTED         0x8UL
+	#define PORT_LED_QCAPS_RESP_LED3_STATE_CAPS_BLINK_ALT_SUPPORTED     0x10UL
+	__le16	led3_color_caps;
+	#define PORT_LED_QCAPS_RESP_LED3_COLOR_CAPS_RSVD                 0x1UL
+	#define PORT_LED_QCAPS_RESP_LED3_COLOR_CAPS_AMBER_SUPPORTED      0x2UL
+	#define PORT_LED_QCAPS_RESP_LED3_COLOR_CAPS_GREEN_SUPPORTED      0x4UL
+	#define PORT_LED_QCAPS_RESP_LED3_COLOR_CAPS_GRNAMB_SUPPORTED     0x8UL
+	u8	unused_4[3];
+	u8	valid;
+};
+
+/* hwrm_port_phy_fdrstat_input (size:192b/24B) */
+struct hwrm_port_phy_fdrstat_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	port_id;
+	__le16	rsvd[2];
+	__le16	ops;
+	#define PORT_PHY_FDRSTAT_REQ_OPS_START   0x0UL
+	#define PORT_PHY_FDRSTAT_REQ_OPS_STOP    0x1UL
+	#define PORT_PHY_FDRSTAT_REQ_OPS_CLEAR   0x2UL
+	#define PORT_PHY_FDRSTAT_REQ_OPS_COUNTER 0x3UL
+	#define PORT_PHY_FDRSTAT_REQ_OPS_LAST   PORT_PHY_FDRSTAT_REQ_OPS_COUNTER
+};
+
+/* hwrm_port_phy_fdrstat_output (size:3072b/384B) */
+struct hwrm_port_phy_fdrstat_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le64	start_time;
+	__le64	end_time;
+	__le64	cmic_start_time;
+	__le64	cmic_end_time;
+	__le64	accumulated_uncorrected_codewords;
+	__le64	accumulated_corrected_codewords;
+	__le64	accumulated_total_codewords;
+	__le64	accumulated_symbol_errors;
+	__le64	accumulated_codewords_err_s0;
+	__le64	accumulated_codewords_err_s1;
+	__le64	accumulated_codewords_err_s2;
+	__le64	accumulated_codewords_err_s3;
+	__le64	accumulated_codewords_err_s4;
+	__le64	accumulated_codewords_err_s5;
+	__le64	accumulated_codewords_err_s6;
+	__le64	accumulated_codewords_err_s7;
+	__le64	accumulated_codewords_err_s8;
+	__le64	accumulated_codewords_err_s9;
+	__le64	accumulated_codewords_err_s10;
+	__le64	accumulated_codewords_err_s11;
+	__le64	accumulated_codewords_err_s12;
+	__le64	accumulated_codewords_err_s13;
+	__le64	accumulated_codewords_err_s14;
+	__le64	accumulated_codewords_err_s15;
+	__le64	accumulated_codewords_err_s16;
+	__le64	uncorrected_codewords;
+	__le64	corrected_codewords;
+	__le64	total_codewords;
+	__le64	symbol_errors;
+	__le64	codewords_err_s0;
+	__le64	codewords_err_s1;
+	__le64	codewords_err_s2;
+	__le64	codewords_err_s3;
+	__le64	codewords_err_s4;
+	__le64	codewords_err_s5;
+	__le64	codewords_err_s6;
+	__le64	codewords_err_s7;
+	__le64	codewords_err_s8;
+	__le64	codewords_err_s9;
+	__le64	codewords_err_s10;
+	__le64	codewords_err_s11;
+	__le64	codewords_err_s12;
+	__le64	codewords_err_s13;
+	__le64	codewords_err_s14;
+	__le64	codewords_err_s15;
+	__le64	codewords_err_s16;
+	__le32	window_size;
+	__le16	unused_0[1];
+	u8	unused_1;
+	u8	valid;
+};
+
+/* hwrm_port_phy_fdrstat_cmd_err (size:64b/8B) */
+struct hwrm_port_phy_fdrstat_cmd_err {
+	u8	code;
+	#define PORT_PHY_FDRSTAT_CMD_ERR_CODE_UNKNOWN     0x0UL
+	#define PORT_PHY_FDRSTAT_CMD_ERR_CODE_NOT_STARTED 0x1UL
+	#define PORT_PHY_FDRSTAT_CMD_ERR_CODE_LAST       PORT_PHY_FDRSTAT_CMD_ERR_CODE_NOT_STARTED
+	u8	unused_0[7];
+};
+
+/* hwrm_port_mac_qcaps_input (size:192b/24B) */
+struct hwrm_port_mac_qcaps_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	port_id;
+	u8	unused_0[6];
+};
+
+/* hwrm_port_mac_qcaps_output (size:128b/16B) */
+struct hwrm_port_mac_qcaps_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	flags;
+	#define PORT_MAC_QCAPS_RESP_FLAGS_LOCAL_LPBK_NOT_SUPPORTED     0x1UL
+	#define PORT_MAC_QCAPS_RESP_FLAGS_REMOTE_LPBK_SUPPORTED        0x2UL
+	u8	unused_0[6];
+	u8	valid;
+};
+
+/* hwrm_queue_qportcfg_input (size:192b/24B) */
+struct hwrm_queue_qportcfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	flags;
+	#define QUEUE_QPORTCFG_REQ_FLAGS_PATH     0x1UL
+	#define QUEUE_QPORTCFG_REQ_FLAGS_PATH_TX    0x0UL
+	#define QUEUE_QPORTCFG_REQ_FLAGS_PATH_RX    0x1UL
+	#define QUEUE_QPORTCFG_REQ_FLAGS_PATH_LAST QUEUE_QPORTCFG_REQ_FLAGS_PATH_RX
+	__le16	port_id;
+	u8	drv_qmap_cap;
+	#define QUEUE_QPORTCFG_REQ_DRV_QMAP_CAP_DISABLED 0x0UL
+	#define QUEUE_QPORTCFG_REQ_DRV_QMAP_CAP_ENABLED  0x1UL
+	#define QUEUE_QPORTCFG_REQ_DRV_QMAP_CAP_LAST    QUEUE_QPORTCFG_REQ_DRV_QMAP_CAP_ENABLED
+	u8	unused_0;
+};
+
+/* hwrm_queue_qportcfg_output (size:1344b/168B) */
+struct hwrm_queue_qportcfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	max_configurable_queues;
+	u8	max_configurable_lossless_queues;
+	u8	queue_cfg_allowed;
+	u8	queue_cfg_info;
+	#define QUEUE_QPORTCFG_RESP_QUEUE_CFG_INFO_ASYM_CFG             0x1UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_CFG_INFO_USE_PROFILE_TYPE     0x2UL
+	u8	queue_pfcenable_cfg_allowed;
+	u8	queue_pri2cos_cfg_allowed;
+	u8	queue_cos2bw_cfg_allowed;
+	u8	queue_id0;
+	u8	queue_id0_service_profile;
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID0_SERVICE_PROFILE_LOSSY          0x0UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID0_SERVICE_PROFILE_LOSSLESS       0x1UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID0_SERVICE_PROFILE_LOSSLESS_ROCE  0x1UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID0_SERVICE_PROFILE_LOSSY_ROCE_CNP 0x2UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID0_SERVICE_PROFILE_LOSSLESS_NIC   0x3UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID0_SERVICE_PROFILE_UNKNOWN        0xffUL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID0_SERVICE_PROFILE_LAST          QUEUE_QPORTCFG_RESP_QUEUE_ID0_SERVICE_PROFILE_UNKNOWN
+	u8	queue_id1;
+	u8	queue_id1_service_profile;
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID1_SERVICE_PROFILE_LOSSY          0x0UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID1_SERVICE_PROFILE_LOSSLESS       0x1UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID1_SERVICE_PROFILE_LOSSLESS_ROCE  0x1UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID1_SERVICE_PROFILE_LOSSY_ROCE_CNP 0x2UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID1_SERVICE_PROFILE_LOSSLESS_NIC   0x3UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID1_SERVICE_PROFILE_UNKNOWN        0xffUL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID1_SERVICE_PROFILE_LAST          QUEUE_QPORTCFG_RESP_QUEUE_ID1_SERVICE_PROFILE_UNKNOWN
+	u8	queue_id2;
+	u8	queue_id2_service_profile;
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID2_SERVICE_PROFILE_LOSSY          0x0UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID2_SERVICE_PROFILE_LOSSLESS       0x1UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID2_SERVICE_PROFILE_LOSSLESS_ROCE  0x1UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID2_SERVICE_PROFILE_LOSSY_ROCE_CNP 0x2UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID2_SERVICE_PROFILE_LOSSLESS_NIC   0x3UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID2_SERVICE_PROFILE_UNKNOWN        0xffUL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID2_SERVICE_PROFILE_LAST          QUEUE_QPORTCFG_RESP_QUEUE_ID2_SERVICE_PROFILE_UNKNOWN
+	u8	queue_id3;
+	u8	queue_id3_service_profile;
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID3_SERVICE_PROFILE_LOSSY          0x0UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID3_SERVICE_PROFILE_LOSSLESS       0x1UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID3_SERVICE_PROFILE_LOSSLESS_ROCE  0x1UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID3_SERVICE_PROFILE_LOSSY_ROCE_CNP 0x2UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID3_SERVICE_PROFILE_LOSSLESS_NIC   0x3UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID3_SERVICE_PROFILE_UNKNOWN        0xffUL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID3_SERVICE_PROFILE_LAST          QUEUE_QPORTCFG_RESP_QUEUE_ID3_SERVICE_PROFILE_UNKNOWN
+	u8	queue_id4;
+	u8	queue_id4_service_profile;
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID4_SERVICE_PROFILE_LOSSY          0x0UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID4_SERVICE_PROFILE_LOSSLESS       0x1UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID4_SERVICE_PROFILE_LOSSLESS_ROCE  0x1UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID4_SERVICE_PROFILE_LOSSY_ROCE_CNP 0x2UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID4_SERVICE_PROFILE_LOSSLESS_NIC   0x3UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID4_SERVICE_PROFILE_UNKNOWN        0xffUL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID4_SERVICE_PROFILE_LAST          QUEUE_QPORTCFG_RESP_QUEUE_ID4_SERVICE_PROFILE_UNKNOWN
+	u8	queue_id5;
+	u8	queue_id5_service_profile;
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID5_SERVICE_PROFILE_LOSSY          0x0UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID5_SERVICE_PROFILE_LOSSLESS       0x1UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID5_SERVICE_PROFILE_LOSSLESS_ROCE  0x1UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID5_SERVICE_PROFILE_LOSSY_ROCE_CNP 0x2UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID5_SERVICE_PROFILE_LOSSLESS_NIC   0x3UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID5_SERVICE_PROFILE_UNKNOWN        0xffUL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID5_SERVICE_PROFILE_LAST          QUEUE_QPORTCFG_RESP_QUEUE_ID5_SERVICE_PROFILE_UNKNOWN
+	u8	queue_id6;
+	u8	queue_id6_service_profile;
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID6_SERVICE_PROFILE_LOSSY          0x0UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID6_SERVICE_PROFILE_LOSSLESS       0x1UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID6_SERVICE_PROFILE_LOSSLESS_ROCE  0x1UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID6_SERVICE_PROFILE_LOSSY_ROCE_CNP 0x2UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID6_SERVICE_PROFILE_LOSSLESS_NIC   0x3UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID6_SERVICE_PROFILE_UNKNOWN        0xffUL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID6_SERVICE_PROFILE_LAST          QUEUE_QPORTCFG_RESP_QUEUE_ID6_SERVICE_PROFILE_UNKNOWN
+	u8	queue_id7;
+	u8	queue_id7_service_profile;
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID7_SERVICE_PROFILE_LOSSY          0x0UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID7_SERVICE_PROFILE_LOSSLESS       0x1UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID7_SERVICE_PROFILE_LOSSLESS_ROCE  0x1UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID7_SERVICE_PROFILE_LOSSY_ROCE_CNP 0x2UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID7_SERVICE_PROFILE_LOSSLESS_NIC   0x3UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID7_SERVICE_PROFILE_UNKNOWN        0xffUL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID7_SERVICE_PROFILE_LAST          QUEUE_QPORTCFG_RESP_QUEUE_ID7_SERVICE_PROFILE_UNKNOWN
+	u8	queue_id0_service_profile_type;
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID0_SERVICE_PROFILE_TYPE_ROCE     0x1UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID0_SERVICE_PROFILE_TYPE_NIC      0x2UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID0_SERVICE_PROFILE_TYPE_CNP      0x4UL
+	char	qid0_name[16];
+	char	qid1_name[16];
+	char	qid2_name[16];
+	char	qid3_name[16];
+	char	qid4_name[16];
+	char	qid5_name[16];
+	char	qid6_name[16];
+	char	qid7_name[16];
+	u8	queue_id1_service_profile_type;
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID1_SERVICE_PROFILE_TYPE_ROCE     0x1UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID1_SERVICE_PROFILE_TYPE_NIC      0x2UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID1_SERVICE_PROFILE_TYPE_CNP      0x4UL
+	u8	queue_id2_service_profile_type;
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID2_SERVICE_PROFILE_TYPE_ROCE     0x1UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID2_SERVICE_PROFILE_TYPE_NIC      0x2UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID2_SERVICE_PROFILE_TYPE_CNP      0x4UL
+	u8	queue_id3_service_profile_type;
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID3_SERVICE_PROFILE_TYPE_ROCE     0x1UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID3_SERVICE_PROFILE_TYPE_NIC      0x2UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID3_SERVICE_PROFILE_TYPE_CNP      0x4UL
+	u8	queue_id4_service_profile_type;
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID4_SERVICE_PROFILE_TYPE_ROCE     0x1UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID4_SERVICE_PROFILE_TYPE_NIC      0x2UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID4_SERVICE_PROFILE_TYPE_CNP      0x4UL
+	u8	queue_id5_service_profile_type;
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID5_SERVICE_PROFILE_TYPE_ROCE     0x1UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID5_SERVICE_PROFILE_TYPE_NIC      0x2UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID5_SERVICE_PROFILE_TYPE_CNP      0x4UL
+	u8	queue_id6_service_profile_type;
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID6_SERVICE_PROFILE_TYPE_ROCE     0x1UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID6_SERVICE_PROFILE_TYPE_NIC      0x2UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID6_SERVICE_PROFILE_TYPE_CNP      0x4UL
+	u8	queue_id7_service_profile_type;
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID7_SERVICE_PROFILE_TYPE_ROCE     0x1UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID7_SERVICE_PROFILE_TYPE_NIC      0x2UL
+	#define QUEUE_QPORTCFG_RESP_QUEUE_ID7_SERVICE_PROFILE_TYPE_CNP      0x4UL
+	u8	valid;
+};
+
+/* hwrm_queue_qcfg_input (size:192b/24B) */
+struct hwrm_queue_qcfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	flags;
+	#define QUEUE_QCFG_REQ_FLAGS_PATH     0x1UL
+	#define QUEUE_QCFG_REQ_FLAGS_PATH_TX    0x0UL
+	#define QUEUE_QCFG_REQ_FLAGS_PATH_RX    0x1UL
+	#define QUEUE_QCFG_REQ_FLAGS_PATH_LAST QUEUE_QCFG_REQ_FLAGS_PATH_RX
+	__le32	queue_id;
+};
+
+/* hwrm_queue_qcfg_output (size:128b/16B) */
+struct hwrm_queue_qcfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le32	queue_len;
+	u8	service_profile;
+	#define QUEUE_QCFG_RESP_SERVICE_PROFILE_LOSSY    0x0UL
+	#define QUEUE_QCFG_RESP_SERVICE_PROFILE_LOSSLESS 0x1UL
+	#define QUEUE_QCFG_RESP_SERVICE_PROFILE_UNKNOWN  0xffUL
+	#define QUEUE_QCFG_RESP_SERVICE_PROFILE_LAST    QUEUE_QCFG_RESP_SERVICE_PROFILE_UNKNOWN
+	u8	queue_cfg_info;
+	#define QUEUE_QCFG_RESP_QUEUE_CFG_INFO_ASYM_CFG     0x1UL
+	u8	unused_0;
+	u8	valid;
+};
+
+/* hwrm_queue_cfg_input (size:320b/40B) */
+struct hwrm_queue_cfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	flags;
+	#define QUEUE_CFG_REQ_FLAGS_PATH_MASK 0x3UL
+	#define QUEUE_CFG_REQ_FLAGS_PATH_SFT  0
+	#define QUEUE_CFG_REQ_FLAGS_PATH_TX     0x0UL
+	#define QUEUE_CFG_REQ_FLAGS_PATH_RX     0x1UL
+	#define QUEUE_CFG_REQ_FLAGS_PATH_BIDIR  0x2UL
+	#define QUEUE_CFG_REQ_FLAGS_PATH_LAST  QUEUE_CFG_REQ_FLAGS_PATH_BIDIR
+	__le32	enables;
+	#define QUEUE_CFG_REQ_ENABLES_DFLT_LEN            0x1UL
+	#define QUEUE_CFG_REQ_ENABLES_SERVICE_PROFILE     0x2UL
+	__le32	queue_id;
+	__le32	dflt_len;
+	u8	service_profile;
+	#define QUEUE_CFG_REQ_SERVICE_PROFILE_LOSSY    0x0UL
+	#define QUEUE_CFG_REQ_SERVICE_PROFILE_LOSSLESS 0x1UL
+	#define QUEUE_CFG_REQ_SERVICE_PROFILE_UNKNOWN  0xffUL
+	#define QUEUE_CFG_REQ_SERVICE_PROFILE_LAST    QUEUE_CFG_REQ_SERVICE_PROFILE_UNKNOWN
+	u8	unused_0[7];
+};
+
+/* hwrm_queue_cfg_output (size:128b/16B) */
+struct hwrm_queue_cfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_queue_pfcenable_qcfg_input (size:192b/24B) */
+struct hwrm_queue_pfcenable_qcfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	port_id;
+	u8	unused_0[6];
+};
+
+/* hwrm_queue_pfcenable_qcfg_output (size:128b/16B) */
+struct hwrm_queue_pfcenable_qcfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le32	flags;
+	#define QUEUE_PFCENABLE_QCFG_RESP_FLAGS_PRI0_PFC_ENABLED              0x1UL
+	#define QUEUE_PFCENABLE_QCFG_RESP_FLAGS_PRI1_PFC_ENABLED              0x2UL
+	#define QUEUE_PFCENABLE_QCFG_RESP_FLAGS_PRI2_PFC_ENABLED              0x4UL
+	#define QUEUE_PFCENABLE_QCFG_RESP_FLAGS_PRI3_PFC_ENABLED              0x8UL
+	#define QUEUE_PFCENABLE_QCFG_RESP_FLAGS_PRI4_PFC_ENABLED              0x10UL
+	#define QUEUE_PFCENABLE_QCFG_RESP_FLAGS_PRI5_PFC_ENABLED              0x20UL
+	#define QUEUE_PFCENABLE_QCFG_RESP_FLAGS_PRI6_PFC_ENABLED              0x40UL
+	#define QUEUE_PFCENABLE_QCFG_RESP_FLAGS_PRI7_PFC_ENABLED              0x80UL
+	#define QUEUE_PFCENABLE_QCFG_RESP_FLAGS_PRI0_PFC_WATCHDOG_ENABLED     0x100UL
+	#define QUEUE_PFCENABLE_QCFG_RESP_FLAGS_PRI1_PFC_WATCHDOG_ENABLED     0x200UL
+	#define QUEUE_PFCENABLE_QCFG_RESP_FLAGS_PRI2_PFC_WATCHDOG_ENABLED     0x400UL
+	#define QUEUE_PFCENABLE_QCFG_RESP_FLAGS_PRI3_PFC_WATCHDOG_ENABLED     0x800UL
+	#define QUEUE_PFCENABLE_QCFG_RESP_FLAGS_PRI4_PFC_WATCHDOG_ENABLED     0x1000UL
+	#define QUEUE_PFCENABLE_QCFG_RESP_FLAGS_PRI5_PFC_WATCHDOG_ENABLED     0x2000UL
+	#define QUEUE_PFCENABLE_QCFG_RESP_FLAGS_PRI6_PFC_WATCHDOG_ENABLED     0x4000UL
+	#define QUEUE_PFCENABLE_QCFG_RESP_FLAGS_PRI7_PFC_WATCHDOG_ENABLED     0x8000UL
+	u8	unused_0[3];
+	u8	valid;
+};
+
+/* hwrm_queue_pfcenable_cfg_input (size:192b/24B) */
+struct hwrm_queue_pfcenable_cfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	flags;
+	#define QUEUE_PFCENABLE_CFG_REQ_FLAGS_PRI0_PFC_ENABLED              0x1UL
+	#define QUEUE_PFCENABLE_CFG_REQ_FLAGS_PRI1_PFC_ENABLED              0x2UL
+	#define QUEUE_PFCENABLE_CFG_REQ_FLAGS_PRI2_PFC_ENABLED              0x4UL
+	#define QUEUE_PFCENABLE_CFG_REQ_FLAGS_PRI3_PFC_ENABLED              0x8UL
+	#define QUEUE_PFCENABLE_CFG_REQ_FLAGS_PRI4_PFC_ENABLED              0x10UL
+	#define QUEUE_PFCENABLE_CFG_REQ_FLAGS_PRI5_PFC_ENABLED              0x20UL
+	#define QUEUE_PFCENABLE_CFG_REQ_FLAGS_PRI6_PFC_ENABLED              0x40UL
+	#define QUEUE_PFCENABLE_CFG_REQ_FLAGS_PRI7_PFC_ENABLED              0x80UL
+	#define QUEUE_PFCENABLE_CFG_REQ_FLAGS_PRI0_PFC_WATCHDOG_ENABLED     0x100UL
+	#define QUEUE_PFCENABLE_CFG_REQ_FLAGS_PRI1_PFC_WATCHDOG_ENABLED     0x200UL
+	#define QUEUE_PFCENABLE_CFG_REQ_FLAGS_PRI2_PFC_WATCHDOG_ENABLED     0x400UL
+	#define QUEUE_PFCENABLE_CFG_REQ_FLAGS_PRI3_PFC_WATCHDOG_ENABLED     0x800UL
+	#define QUEUE_PFCENABLE_CFG_REQ_FLAGS_PRI4_PFC_WATCHDOG_ENABLED     0x1000UL
+	#define QUEUE_PFCENABLE_CFG_REQ_FLAGS_PRI5_PFC_WATCHDOG_ENABLED     0x2000UL
+	#define QUEUE_PFCENABLE_CFG_REQ_FLAGS_PRI6_PFC_WATCHDOG_ENABLED     0x4000UL
+	#define QUEUE_PFCENABLE_CFG_REQ_FLAGS_PRI7_PFC_WATCHDOG_ENABLED     0x8000UL
+	__le16	port_id;
+	u8	unused_0[2];
+};
+
+/* hwrm_queue_pfcenable_cfg_output (size:128b/16B) */
+struct hwrm_queue_pfcenable_cfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_queue_pri2cos_qcfg_input (size:192b/24B) */
+struct hwrm_queue_pri2cos_qcfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	flags;
+	#define QUEUE_PRI2COS_QCFG_REQ_FLAGS_PATH      0x1UL
+	#define QUEUE_PRI2COS_QCFG_REQ_FLAGS_PATH_TX     0x0UL
+	#define QUEUE_PRI2COS_QCFG_REQ_FLAGS_PATH_RX     0x1UL
+	#define QUEUE_PRI2COS_QCFG_REQ_FLAGS_PATH_LAST  QUEUE_PRI2COS_QCFG_REQ_FLAGS_PATH_RX
+	#define QUEUE_PRI2COS_QCFG_REQ_FLAGS_IVLAN     0x2UL
+	u8	port_id;
+	u8	unused_0[3];
+};
+
+/* hwrm_queue_pri2cos_qcfg_output (size:192b/24B) */
+struct hwrm_queue_pri2cos_qcfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	pri0_cos_queue_id;
+	u8	pri1_cos_queue_id;
+	u8	pri2_cos_queue_id;
+	u8	pri3_cos_queue_id;
+	u8	pri4_cos_queue_id;
+	u8	pri5_cos_queue_id;
+	u8	pri6_cos_queue_id;
+	u8	pri7_cos_queue_id;
+	u8	queue_cfg_info;
+	#define QUEUE_PRI2COS_QCFG_RESP_QUEUE_CFG_INFO_ASYM_CFG     0x1UL
+	u8	unused_0[6];
+	u8	valid;
+};
+
+/* hwrm_queue_pri2cos_cfg_input (size:320b/40B) */
+struct hwrm_queue_pri2cos_cfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	flags;
+	#define QUEUE_PRI2COS_CFG_REQ_FLAGS_PATH_MASK 0x3UL
+	#define QUEUE_PRI2COS_CFG_REQ_FLAGS_PATH_SFT  0
+	#define QUEUE_PRI2COS_CFG_REQ_FLAGS_PATH_TX     0x0UL
+	#define QUEUE_PRI2COS_CFG_REQ_FLAGS_PATH_RX     0x1UL
+	#define QUEUE_PRI2COS_CFG_REQ_FLAGS_PATH_BIDIR  0x2UL
+	#define QUEUE_PRI2COS_CFG_REQ_FLAGS_PATH_LAST  QUEUE_PRI2COS_CFG_REQ_FLAGS_PATH_BIDIR
+	#define QUEUE_PRI2COS_CFG_REQ_FLAGS_IVLAN     0x4UL
+	__le32	enables;
+	#define QUEUE_PRI2COS_CFG_REQ_ENABLES_PRI0_COS_QUEUE_ID     0x1UL
+	#define QUEUE_PRI2COS_CFG_REQ_ENABLES_PRI1_COS_QUEUE_ID     0x2UL
+	#define QUEUE_PRI2COS_CFG_REQ_ENABLES_PRI2_COS_QUEUE_ID     0x4UL
+	#define QUEUE_PRI2COS_CFG_REQ_ENABLES_PRI3_COS_QUEUE_ID     0x8UL
+	#define QUEUE_PRI2COS_CFG_REQ_ENABLES_PRI4_COS_QUEUE_ID     0x10UL
+	#define QUEUE_PRI2COS_CFG_REQ_ENABLES_PRI5_COS_QUEUE_ID     0x20UL
+	#define QUEUE_PRI2COS_CFG_REQ_ENABLES_PRI6_COS_QUEUE_ID     0x40UL
+	#define QUEUE_PRI2COS_CFG_REQ_ENABLES_PRI7_COS_QUEUE_ID     0x80UL
+	u8	port_id;
+	u8	pri0_cos_queue_id;
+	u8	pri1_cos_queue_id;
+	u8	pri2_cos_queue_id;
+	u8	pri3_cos_queue_id;
+	u8	pri4_cos_queue_id;
+	u8	pri5_cos_queue_id;
+	u8	pri6_cos_queue_id;
+	u8	pri7_cos_queue_id;
+	u8	unused_0[7];
+};
+
+/* hwrm_queue_pri2cos_cfg_output (size:128b/16B) */
+struct hwrm_queue_pri2cos_cfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_queue_cos2bw_qcfg_input (size:192b/24B) */
+struct hwrm_queue_cos2bw_qcfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	port_id;
+	u8	unused_0[6];
+};
+
+/* hwrm_queue_cos2bw_qcfg_output (size:896b/112B) */
+struct hwrm_queue_cos2bw_qcfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	queue_id0;
+	u8	unused_0;
+	__le16	unused_1;
+	__le32	queue_id0_min_bw;
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID0_MIN_BW_BW_VALUE_MASK             0xfffffffUL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID0_MIN_BW_BW_VALUE_SFT              0
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID0_MIN_BW_SCALE                     0x10000000UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID0_MIN_BW_SCALE_BITS                  (0x0UL << 28)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID0_MIN_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID0_MIN_BW_SCALE_LAST                 QUEUE_COS2BW_QCFG_RESP_QUEUE_ID0_MIN_BW_SCALE_BYTES
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID0_MIN_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID0_MIN_BW_BW_VALUE_UNIT_SFT         29
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID0_MIN_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID0_MIN_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID0_MIN_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID0_MIN_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID0_MIN_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID0_MIN_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID0_MIN_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_QCFG_RESP_QUEUE_ID0_MIN_BW_BW_VALUE_UNIT_INVALID
+	__le32	queue_id0_max_bw;
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID0_MAX_BW_BW_VALUE_MASK             0xfffffffUL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID0_MAX_BW_BW_VALUE_SFT              0
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID0_MAX_BW_SCALE                     0x10000000UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID0_MAX_BW_SCALE_BITS                  (0x0UL << 28)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID0_MAX_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID0_MAX_BW_SCALE_LAST                 QUEUE_COS2BW_QCFG_RESP_QUEUE_ID0_MAX_BW_SCALE_BYTES
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID0_MAX_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID0_MAX_BW_BW_VALUE_UNIT_SFT         29
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID0_MAX_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID0_MAX_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID0_MAX_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID0_MAX_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID0_MAX_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID0_MAX_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID0_MAX_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_QCFG_RESP_QUEUE_ID0_MAX_BW_BW_VALUE_UNIT_INVALID
+	u8	queue_id0_tsa_assign;
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID0_TSA_ASSIGN_SP             0x0UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID0_TSA_ASSIGN_ETS            0x1UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID0_TSA_ASSIGN_RESERVED_FIRST 0x2UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID0_TSA_ASSIGN_RESERVED_LAST  0xffUL
+	u8	queue_id0_pri_lvl;
+	u8	queue_id0_bw_weight;
+	u8	queue_id1;
+	__le32	queue_id1_min_bw;
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MIN_BW_BW_VALUE_MASK             0xfffffffUL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MIN_BW_BW_VALUE_SFT              0
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MIN_BW_SCALE                     0x10000000UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MIN_BW_SCALE_BITS                  (0x0UL << 28)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MIN_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MIN_BW_SCALE_LAST                 QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MIN_BW_SCALE_BYTES
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_SFT         29
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_INVALID
+	__le32	queue_id1_max_bw;
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MAX_BW_BW_VALUE_MASK             0xfffffffUL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MAX_BW_BW_VALUE_SFT              0
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MAX_BW_SCALE                     0x10000000UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MAX_BW_SCALE_BITS                  (0x0UL << 28)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MAX_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MAX_BW_SCALE_LAST                 QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MAX_BW_SCALE_BYTES
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_SFT         29
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_INVALID
+	u8	queue_id1_tsa_assign;
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_TSA_ASSIGN_SP             0x0UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_TSA_ASSIGN_ETS            0x1UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_TSA_ASSIGN_RESERVED_FIRST 0x2UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_TSA_ASSIGN_RESERVED_LAST  0xffUL
+	u8	queue_id1_pri_lvl;
+	u8	queue_id1_bw_weight;
+	u8	queue_id2;
+	__le32	queue_id2_min_bw;
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MIN_BW_BW_VALUE_MASK             0xfffffffUL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MIN_BW_BW_VALUE_SFT              0
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MIN_BW_SCALE                     0x10000000UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MIN_BW_SCALE_BITS                  (0x0UL << 28)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MIN_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MIN_BW_SCALE_LAST                 QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MIN_BW_SCALE_BYTES
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_SFT         29
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_INVALID
+	__le32	queue_id2_max_bw;
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MAX_BW_BW_VALUE_MASK             0xfffffffUL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MAX_BW_BW_VALUE_SFT              0
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MAX_BW_SCALE                     0x10000000UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MAX_BW_SCALE_BITS                  (0x0UL << 28)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MAX_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MAX_BW_SCALE_LAST                 QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MAX_BW_SCALE_BYTES
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_SFT         29
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_INVALID
+	u8	queue_id2_tsa_assign;
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_TSA_ASSIGN_SP             0x0UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_TSA_ASSIGN_ETS            0x1UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_TSA_ASSIGN_RESERVED_FIRST 0x2UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_TSA_ASSIGN_RESERVED_LAST  0xffUL
+	u8	queue_id2_pri_lvl;
+	u8	queue_id2_bw_weight;
+	u8	queue_id3;
+	__le32	queue_id3_min_bw;
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MIN_BW_BW_VALUE_MASK             0xfffffffUL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MIN_BW_BW_VALUE_SFT              0
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MIN_BW_SCALE                     0x10000000UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MIN_BW_SCALE_BITS                  (0x0UL << 28)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MIN_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MIN_BW_SCALE_LAST                 QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MIN_BW_SCALE_BYTES
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_SFT         29
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_INVALID
+	__le32	queue_id3_max_bw;
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MAX_BW_BW_VALUE_MASK             0xfffffffUL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MAX_BW_BW_VALUE_SFT              0
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MAX_BW_SCALE                     0x10000000UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MAX_BW_SCALE_BITS                  (0x0UL << 28)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MAX_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MAX_BW_SCALE_LAST                 QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MAX_BW_SCALE_BYTES
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_SFT         29
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_INVALID
+	u8	queue_id3_tsa_assign;
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_TSA_ASSIGN_SP             0x0UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_TSA_ASSIGN_ETS            0x1UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_TSA_ASSIGN_RESERVED_FIRST 0x2UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_TSA_ASSIGN_RESERVED_LAST  0xffUL
+	u8	queue_id3_pri_lvl;
+	u8	queue_id3_bw_weight;
+	u8	queue_id4;
+	__le32	queue_id4_min_bw;
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MIN_BW_BW_VALUE_MASK             0xfffffffUL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MIN_BW_BW_VALUE_SFT              0
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MIN_BW_SCALE                     0x10000000UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MIN_BW_SCALE_BITS                  (0x0UL << 28)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MIN_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MIN_BW_SCALE_LAST                 QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MIN_BW_SCALE_BYTES
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_SFT         29
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_INVALID
+	__le32	queue_id4_max_bw;
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MAX_BW_BW_VALUE_MASK             0xfffffffUL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MAX_BW_BW_VALUE_SFT              0
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MAX_BW_SCALE                     0x10000000UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MAX_BW_SCALE_BITS                  (0x0UL << 28)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MAX_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MAX_BW_SCALE_LAST                 QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MAX_BW_SCALE_BYTES
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_SFT         29
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_INVALID
+	u8	queue_id4_tsa_assign;
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_TSA_ASSIGN_SP             0x0UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_TSA_ASSIGN_ETS            0x1UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_TSA_ASSIGN_RESERVED_FIRST 0x2UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_TSA_ASSIGN_RESERVED_LAST  0xffUL
+	u8	queue_id4_pri_lvl;
+	u8	queue_id4_bw_weight;
+	u8	queue_id5;
+	__le32	queue_id5_min_bw;
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MIN_BW_BW_VALUE_MASK             0xfffffffUL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MIN_BW_BW_VALUE_SFT              0
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MIN_BW_SCALE                     0x10000000UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MIN_BW_SCALE_BITS                  (0x0UL << 28)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MIN_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MIN_BW_SCALE_LAST                 QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MIN_BW_SCALE_BYTES
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_SFT         29
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_INVALID
+	__le32	queue_id5_max_bw;
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MAX_BW_BW_VALUE_MASK             0xfffffffUL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MAX_BW_BW_VALUE_SFT              0
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MAX_BW_SCALE                     0x10000000UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MAX_BW_SCALE_BITS                  (0x0UL << 28)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MAX_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MAX_BW_SCALE_LAST                 QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MAX_BW_SCALE_BYTES
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_SFT         29
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_INVALID
+	u8	queue_id5_tsa_assign;
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_TSA_ASSIGN_SP             0x0UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_TSA_ASSIGN_ETS            0x1UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_TSA_ASSIGN_RESERVED_FIRST 0x2UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_TSA_ASSIGN_RESERVED_LAST  0xffUL
+	u8	queue_id5_pri_lvl;
+	u8	queue_id5_bw_weight;
+	u8	queue_id6;
+	__le32	queue_id6_min_bw;
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MIN_BW_BW_VALUE_MASK             0xfffffffUL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MIN_BW_BW_VALUE_SFT              0
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MIN_BW_SCALE                     0x10000000UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MIN_BW_SCALE_BITS                  (0x0UL << 28)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MIN_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MIN_BW_SCALE_LAST                 QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MIN_BW_SCALE_BYTES
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_SFT         29
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_INVALID
+	__le32	queue_id6_max_bw;
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MAX_BW_BW_VALUE_MASK             0xfffffffUL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MAX_BW_BW_VALUE_SFT              0
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MAX_BW_SCALE                     0x10000000UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MAX_BW_SCALE_BITS                  (0x0UL << 28)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MAX_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MAX_BW_SCALE_LAST                 QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MAX_BW_SCALE_BYTES
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_SFT         29
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_INVALID
+	u8	queue_id6_tsa_assign;
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_TSA_ASSIGN_SP             0x0UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_TSA_ASSIGN_ETS            0x1UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_TSA_ASSIGN_RESERVED_FIRST 0x2UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_TSA_ASSIGN_RESERVED_LAST  0xffUL
+	u8	queue_id6_pri_lvl;
+	u8	queue_id6_bw_weight;
+	u8	queue_id7;
+	__le32	queue_id7_min_bw;
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MIN_BW_BW_VALUE_MASK             0xfffffffUL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MIN_BW_BW_VALUE_SFT              0
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MIN_BW_SCALE                     0x10000000UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MIN_BW_SCALE_BITS                  (0x0UL << 28)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MIN_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MIN_BW_SCALE_LAST                 QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MIN_BW_SCALE_BYTES
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_SFT         29
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_INVALID
+	__le32	queue_id7_max_bw;
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MAX_BW_BW_VALUE_MASK             0xfffffffUL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MAX_BW_BW_VALUE_SFT              0
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MAX_BW_SCALE                     0x10000000UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MAX_BW_SCALE_BITS                  (0x0UL << 28)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MAX_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MAX_BW_SCALE_LAST                 QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MAX_BW_SCALE_BYTES
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_SFT         29
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_INVALID
+	u8	queue_id7_tsa_assign;
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_TSA_ASSIGN_SP             0x0UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_TSA_ASSIGN_ETS            0x1UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_TSA_ASSIGN_RESERVED_FIRST 0x2UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_TSA_ASSIGN_RESERVED_LAST  0xffUL
+	u8	queue_id7_pri_lvl;
+	u8	queue_id7_bw_weight;
+	u8	unused_2[4];
+	u8	valid;
+};
+
+/* hwrm_queue_cos2bw_cfg_input (size:1024b/128B) */
+struct hwrm_queue_cos2bw_cfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	flags;
+	__le32	enables;
+	#define QUEUE_COS2BW_CFG_REQ_ENABLES_COS_QUEUE_ID0_VALID     0x1UL
+	#define QUEUE_COS2BW_CFG_REQ_ENABLES_COS_QUEUE_ID1_VALID     0x2UL
+	#define QUEUE_COS2BW_CFG_REQ_ENABLES_COS_QUEUE_ID2_VALID     0x4UL
+	#define QUEUE_COS2BW_CFG_REQ_ENABLES_COS_QUEUE_ID3_VALID     0x8UL
+	#define QUEUE_COS2BW_CFG_REQ_ENABLES_COS_QUEUE_ID4_VALID     0x10UL
+	#define QUEUE_COS2BW_CFG_REQ_ENABLES_COS_QUEUE_ID5_VALID     0x20UL
+	#define QUEUE_COS2BW_CFG_REQ_ENABLES_COS_QUEUE_ID6_VALID     0x40UL
+	#define QUEUE_COS2BW_CFG_REQ_ENABLES_COS_QUEUE_ID7_VALID     0x80UL
+	__le16	port_id;
+	u8	queue_id0;
+	u8	unused_0;
+	__le32	queue_id0_min_bw;
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID0_MIN_BW_BW_VALUE_MASK             0xfffffffUL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID0_MIN_BW_BW_VALUE_SFT              0
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID0_MIN_BW_SCALE                     0x10000000UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID0_MIN_BW_SCALE_BITS                  (0x0UL << 28)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID0_MIN_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID0_MIN_BW_SCALE_LAST                 QUEUE_COS2BW_CFG_REQ_QUEUE_ID0_MIN_BW_SCALE_BYTES
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID0_MIN_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID0_MIN_BW_BW_VALUE_UNIT_SFT         29
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID0_MIN_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID0_MIN_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID0_MIN_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID0_MIN_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID0_MIN_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID0_MIN_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID0_MIN_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_CFG_REQ_QUEUE_ID0_MIN_BW_BW_VALUE_UNIT_INVALID
+	__le32	queue_id0_max_bw;
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID0_MAX_BW_BW_VALUE_MASK             0xfffffffUL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID0_MAX_BW_BW_VALUE_SFT              0
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID0_MAX_BW_SCALE                     0x10000000UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID0_MAX_BW_SCALE_BITS                  (0x0UL << 28)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID0_MAX_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID0_MAX_BW_SCALE_LAST                 QUEUE_COS2BW_CFG_REQ_QUEUE_ID0_MAX_BW_SCALE_BYTES
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID0_MAX_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID0_MAX_BW_BW_VALUE_UNIT_SFT         29
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID0_MAX_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID0_MAX_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID0_MAX_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID0_MAX_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID0_MAX_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID0_MAX_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID0_MAX_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_CFG_REQ_QUEUE_ID0_MAX_BW_BW_VALUE_UNIT_INVALID
+	u8	queue_id0_tsa_assign;
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID0_TSA_ASSIGN_SP             0x0UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID0_TSA_ASSIGN_ETS            0x1UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID0_TSA_ASSIGN_RESERVED_FIRST 0x2UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID0_TSA_ASSIGN_RESERVED_LAST  0xffUL
+	u8	queue_id0_pri_lvl;
+	u8	queue_id0_bw_weight;
+	u8	queue_id1;
+	__le32	queue_id1_min_bw;
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MIN_BW_BW_VALUE_MASK             0xfffffffUL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MIN_BW_BW_VALUE_SFT              0
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MIN_BW_SCALE                     0x10000000UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MIN_BW_SCALE_BITS                  (0x0UL << 28)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MIN_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MIN_BW_SCALE_LAST                 QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MIN_BW_SCALE_BYTES
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_SFT         29
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_INVALID
+	__le32	queue_id1_max_bw;
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MAX_BW_BW_VALUE_MASK             0xfffffffUL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MAX_BW_BW_VALUE_SFT              0
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MAX_BW_SCALE                     0x10000000UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MAX_BW_SCALE_BITS                  (0x0UL << 28)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MAX_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MAX_BW_SCALE_LAST                 QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MAX_BW_SCALE_BYTES
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_SFT         29
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_INVALID
+	u8	queue_id1_tsa_assign;
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_TSA_ASSIGN_SP             0x0UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_TSA_ASSIGN_ETS            0x1UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_TSA_ASSIGN_RESERVED_FIRST 0x2UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_TSA_ASSIGN_RESERVED_LAST  0xffUL
+	u8	queue_id1_pri_lvl;
+	u8	queue_id1_bw_weight;
+	u8	queue_id2;
+	__le32	queue_id2_min_bw;
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MIN_BW_BW_VALUE_MASK             0xfffffffUL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MIN_BW_BW_VALUE_SFT              0
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MIN_BW_SCALE                     0x10000000UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MIN_BW_SCALE_BITS                  (0x0UL << 28)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MIN_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MIN_BW_SCALE_LAST                 QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MIN_BW_SCALE_BYTES
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_SFT         29
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_INVALID
+	__le32	queue_id2_max_bw;
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MAX_BW_BW_VALUE_MASK             0xfffffffUL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MAX_BW_BW_VALUE_SFT              0
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MAX_BW_SCALE                     0x10000000UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MAX_BW_SCALE_BITS                  (0x0UL << 28)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MAX_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MAX_BW_SCALE_LAST                 QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MAX_BW_SCALE_BYTES
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_SFT         29
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_INVALID
+	u8	queue_id2_tsa_assign;
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_TSA_ASSIGN_SP             0x0UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_TSA_ASSIGN_ETS            0x1UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_TSA_ASSIGN_RESERVED_FIRST 0x2UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_TSA_ASSIGN_RESERVED_LAST  0xffUL
+	u8	queue_id2_pri_lvl;
+	u8	queue_id2_bw_weight;
+	u8	queue_id3;
+	__le32	queue_id3_min_bw;
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MIN_BW_BW_VALUE_MASK             0xfffffffUL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MIN_BW_BW_VALUE_SFT              0
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MIN_BW_SCALE                     0x10000000UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MIN_BW_SCALE_BITS                  (0x0UL << 28)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MIN_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MIN_BW_SCALE_LAST                 QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MIN_BW_SCALE_BYTES
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_SFT         29
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_INVALID
+	__le32	queue_id3_max_bw;
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MAX_BW_BW_VALUE_MASK             0xfffffffUL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MAX_BW_BW_VALUE_SFT              0
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MAX_BW_SCALE                     0x10000000UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MAX_BW_SCALE_BITS                  (0x0UL << 28)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MAX_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MAX_BW_SCALE_LAST                 QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MAX_BW_SCALE_BYTES
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_SFT         29
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_INVALID
+	u8	queue_id3_tsa_assign;
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_TSA_ASSIGN_SP             0x0UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_TSA_ASSIGN_ETS            0x1UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_TSA_ASSIGN_RESERVED_FIRST 0x2UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_TSA_ASSIGN_RESERVED_LAST  0xffUL
+	u8	queue_id3_pri_lvl;
+	u8	queue_id3_bw_weight;
+	u8	queue_id4;
+	__le32	queue_id4_min_bw;
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MIN_BW_BW_VALUE_MASK             0xfffffffUL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MIN_BW_BW_VALUE_SFT              0
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MIN_BW_SCALE                     0x10000000UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MIN_BW_SCALE_BITS                  (0x0UL << 28)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MIN_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MIN_BW_SCALE_LAST                 QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MIN_BW_SCALE_BYTES
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_SFT         29
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_INVALID
+	__le32	queue_id4_max_bw;
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MAX_BW_BW_VALUE_MASK             0xfffffffUL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MAX_BW_BW_VALUE_SFT              0
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MAX_BW_SCALE                     0x10000000UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MAX_BW_SCALE_BITS                  (0x0UL << 28)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MAX_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MAX_BW_SCALE_LAST                 QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MAX_BW_SCALE_BYTES
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_SFT         29
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_INVALID
+	u8	queue_id4_tsa_assign;
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_TSA_ASSIGN_SP             0x0UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_TSA_ASSIGN_ETS            0x1UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_TSA_ASSIGN_RESERVED_FIRST 0x2UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_TSA_ASSIGN_RESERVED_LAST  0xffUL
+	u8	queue_id4_pri_lvl;
+	u8	queue_id4_bw_weight;
+	u8	queue_id5;
+	__le32	queue_id5_min_bw;
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MIN_BW_BW_VALUE_MASK             0xfffffffUL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MIN_BW_BW_VALUE_SFT              0
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MIN_BW_SCALE                     0x10000000UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MIN_BW_SCALE_BITS                  (0x0UL << 28)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MIN_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MIN_BW_SCALE_LAST                 QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MIN_BW_SCALE_BYTES
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_SFT         29
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_INVALID
+	__le32	queue_id5_max_bw;
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MAX_BW_BW_VALUE_MASK             0xfffffffUL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MAX_BW_BW_VALUE_SFT              0
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MAX_BW_SCALE                     0x10000000UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MAX_BW_SCALE_BITS                  (0x0UL << 28)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MAX_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MAX_BW_SCALE_LAST                 QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MAX_BW_SCALE_BYTES
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_SFT         29
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_INVALID
+	u8	queue_id5_tsa_assign;
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_TSA_ASSIGN_SP             0x0UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_TSA_ASSIGN_ETS            0x1UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_TSA_ASSIGN_RESERVED_FIRST 0x2UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_TSA_ASSIGN_RESERVED_LAST  0xffUL
+	u8	queue_id5_pri_lvl;
+	u8	queue_id5_bw_weight;
+	u8	queue_id6;
+	__le32	queue_id6_min_bw;
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MIN_BW_BW_VALUE_MASK             0xfffffffUL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MIN_BW_BW_VALUE_SFT              0
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MIN_BW_SCALE                     0x10000000UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MIN_BW_SCALE_BITS                  (0x0UL << 28)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MIN_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MIN_BW_SCALE_LAST                 QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MIN_BW_SCALE_BYTES
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_SFT         29
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_INVALID
+	__le32	queue_id6_max_bw;
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MAX_BW_BW_VALUE_MASK             0xfffffffUL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MAX_BW_BW_VALUE_SFT              0
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MAX_BW_SCALE                     0x10000000UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MAX_BW_SCALE_BITS                  (0x0UL << 28)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MAX_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MAX_BW_SCALE_LAST                 QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MAX_BW_SCALE_BYTES
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_SFT         29
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_INVALID
+	u8	queue_id6_tsa_assign;
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_TSA_ASSIGN_SP             0x0UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_TSA_ASSIGN_ETS            0x1UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_TSA_ASSIGN_RESERVED_FIRST 0x2UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_TSA_ASSIGN_RESERVED_LAST  0xffUL
+	u8	queue_id6_pri_lvl;
+	u8	queue_id6_bw_weight;
+	u8	queue_id7;
+	__le32	queue_id7_min_bw;
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MIN_BW_BW_VALUE_MASK             0xfffffffUL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MIN_BW_BW_VALUE_SFT              0
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MIN_BW_SCALE                     0x10000000UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MIN_BW_SCALE_BITS                  (0x0UL << 28)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MIN_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MIN_BW_SCALE_LAST                 QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MIN_BW_SCALE_BYTES
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_SFT         29
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_INVALID
+	__le32	queue_id7_max_bw;
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MAX_BW_BW_VALUE_MASK             0xfffffffUL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MAX_BW_BW_VALUE_SFT              0
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MAX_BW_SCALE                     0x10000000UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MAX_BW_SCALE_BITS                  (0x0UL << 28)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MAX_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MAX_BW_SCALE_LAST                 QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MAX_BW_SCALE_BYTES
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_SFT         29
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_INVALID
+	u8	queue_id7_tsa_assign;
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_TSA_ASSIGN_SP             0x0UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_TSA_ASSIGN_ETS            0x1UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_TSA_ASSIGN_RESERVED_FIRST 0x2UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_TSA_ASSIGN_RESERVED_LAST  0xffUL
+	u8	queue_id7_pri_lvl;
+	u8	queue_id7_bw_weight;
+	u8	unused_1[5];
+};
+
+/* hwrm_queue_cos2bw_cfg_output (size:128b/16B) */
+struct hwrm_queue_cos2bw_cfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_queue_dscp_qcaps_input (size:192b/24B) */
+struct hwrm_queue_dscp_qcaps_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	u8	port_id;
+	u8	unused_0[7];
+};
+
+/* hwrm_queue_dscp_qcaps_output (size:128b/16B) */
+struct hwrm_queue_dscp_qcaps_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	num_dscp_bits;
+	u8	unused_0;
+	__le16	max_entries;
+	u8	unused_1[3];
+	u8	valid;
+};
+
+/* hwrm_queue_dscp2pri_qcfg_input (size:256b/32B) */
+struct hwrm_queue_dscp2pri_qcfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le64	dest_data_addr;
+	u8	port_id;
+	u8	unused_0;
+	__le16	dest_data_buffer_size;
+	u8	unused_1[4];
+};
+
+/* hwrm_queue_dscp2pri_qcfg_output (size:128b/16B) */
+struct hwrm_queue_dscp2pri_qcfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	entry_cnt;
+	u8	default_pri;
+	u8	unused_0[4];
+	u8	valid;
+};
+
+/* hwrm_queue_dscp2pri_cfg_input (size:320b/40B) */
+struct hwrm_queue_dscp2pri_cfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le64	src_data_addr;
+	__le32	flags;
+	#define QUEUE_DSCP2PRI_CFG_REQ_FLAGS_USE_HW_DEFAULT_PRI     0x1UL
+	__le32	enables;
+	#define QUEUE_DSCP2PRI_CFG_REQ_ENABLES_DEFAULT_PRI     0x1UL
+	u8	port_id;
+	u8	default_pri;
+	__le16	entry_cnt;
+	u8	unused_0[4];
+};
+
+/* hwrm_queue_dscp2pri_cfg_output (size:128b/16B) */
+struct hwrm_queue_dscp2pri_cfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_queue_pfcwd_timeout_cfg_input (size:192b/24B) */
+struct hwrm_queue_pfcwd_timeout_cfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	pfcwd_timeout_value;
+	u8	unused_0[6];
+};
+
+/* hwrm_queue_pfcwd_timeout_cfg_output (size:128b/16B) */
+struct hwrm_queue_pfcwd_timeout_cfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_queue_pfcwd_timeout_qcfg_input (size:128b/16B) */
+struct hwrm_queue_pfcwd_timeout_qcfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+};
+
+/* hwrm_queue_pfcwd_timeout_qcfg_output (size:128b/16B) */
+struct hwrm_queue_pfcwd_timeout_qcfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	pfcwd_timeout_value;
+	u8	unused_0[5];
+	u8	valid;
+};
+
+/* hwrm_vnic_alloc_input (size:192b/24B) */
+struct hwrm_vnic_alloc_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	flags;
+	#define VNIC_ALLOC_REQ_FLAGS_DEFAULT                  0x1UL
+	#define VNIC_ALLOC_REQ_FLAGS_VIRTIO_NET_FID_VALID     0x2UL
+	#define VNIC_ALLOC_REQ_FLAGS_VNIC_ID_VALID            0x4UL
+	__le16	virtio_net_fid;
+	__le16	vnic_id;
+};
+
+/* hwrm_vnic_alloc_output (size:128b/16B) */
+struct hwrm_vnic_alloc_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le32	vnic_id;
+	u8	unused_0[3];
+	u8	valid;
+};
+
+/* hwrm_vnic_update_input (size:256b/32B) */
+struct hwrm_vnic_update_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	vnic_id;
+	__le32	enables;
+	#define VNIC_UPDATE_REQ_ENABLES_VNIC_STATE_VALID               0x1UL
+	#define VNIC_UPDATE_REQ_ENABLES_MRU_VALID                      0x2UL
+	#define VNIC_UPDATE_REQ_ENABLES_METADATA_FORMAT_TYPE_VALID     0x4UL
+	u8	vnic_state;
+	#define VNIC_UPDATE_REQ_VNIC_STATE_NORMAL 0x0UL
+	#define VNIC_UPDATE_REQ_VNIC_STATE_DROP   0x1UL
+	#define VNIC_UPDATE_REQ_VNIC_STATE_LAST  VNIC_UPDATE_REQ_VNIC_STATE_DROP
+	u8	metadata_format_type;
+	#define VNIC_UPDATE_REQ_METADATA_FORMAT_TYPE_0 0x0UL
+	#define VNIC_UPDATE_REQ_METADATA_FORMAT_TYPE_1 0x1UL
+	#define VNIC_UPDATE_REQ_METADATA_FORMAT_TYPE_2 0x2UL
+	#define VNIC_UPDATE_REQ_METADATA_FORMAT_TYPE_3 0x3UL
+	#define VNIC_UPDATE_REQ_METADATA_FORMAT_TYPE_4 0x4UL
+	#define VNIC_UPDATE_REQ_METADATA_FORMAT_TYPE_LAST VNIC_UPDATE_REQ_METADATA_FORMAT_TYPE_4
+	__le16	mru;
+	u8	unused_1[4];
+};
+
+/* hwrm_vnic_update_output (size:128b/16B) */
+struct hwrm_vnic_update_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_vnic_free_input (size:192b/24B) */
+struct hwrm_vnic_free_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	vnic_id;
+	u8	unused_0[4];
+};
+
+/* hwrm_vnic_free_output (size:128b/16B) */
+struct hwrm_vnic_free_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_vnic_cfg_input (size:384b/48B) */
+struct hwrm_vnic_cfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	flags;
+	#define VNIC_CFG_REQ_FLAGS_DEFAULT                              0x1UL
+	#define VNIC_CFG_REQ_FLAGS_VLAN_STRIP_MODE                      0x2UL
+	#define VNIC_CFG_REQ_FLAGS_BD_STALL_MODE                        0x4UL
+	#define VNIC_CFG_REQ_FLAGS_ROCE_DUAL_VNIC_MODE                  0x8UL
+	#define VNIC_CFG_REQ_FLAGS_ROCE_ONLY_VNIC_MODE                  0x10UL
+	#define VNIC_CFG_REQ_FLAGS_RSS_DFLT_CR_MODE                     0x20UL
+	#define VNIC_CFG_REQ_FLAGS_ROCE_MIRRORING_CAPABLE_VNIC_MODE     0x40UL
+	#define VNIC_CFG_REQ_FLAGS_PORTCOS_MAPPING_MODE                 0x80UL
+	__le32	enables;
+	#define VNIC_CFG_REQ_ENABLES_DFLT_RING_GRP            0x1UL
+	#define VNIC_CFG_REQ_ENABLES_RSS_RULE                 0x2UL
+	#define VNIC_CFG_REQ_ENABLES_COS_RULE                 0x4UL
+	#define VNIC_CFG_REQ_ENABLES_LB_RULE                  0x8UL
+	#define VNIC_CFG_REQ_ENABLES_MRU                      0x10UL
+	#define VNIC_CFG_REQ_ENABLES_DEFAULT_RX_RING_ID       0x20UL
+	#define VNIC_CFG_REQ_ENABLES_DEFAULT_CMPL_RING_ID     0x40UL
+	#define VNIC_CFG_REQ_ENABLES_QUEUE_ID                 0x80UL
+	#define VNIC_CFG_REQ_ENABLES_RX_CSUM_V2_MODE          0x100UL
+	#define VNIC_CFG_REQ_ENABLES_L2_CQE_MODE              0x200UL
+	#define VNIC_CFG_REQ_ENABLES_RAW_QP_ID                0x400UL
+	__le16	vnic_id;
+	__le16	dflt_ring_grp;
+	__le16	rss_rule;
+	__le16	cos_rule;
+	__le16	lb_rule;
+	__le16	mru;
+	__le16	default_rx_ring_id;
+	__le16	default_cmpl_ring_id;
+	__le16	queue_id;
+	u8	rx_csum_v2_mode;
+	#define VNIC_CFG_REQ_RX_CSUM_V2_MODE_DEFAULT 0x0UL
+	#define VNIC_CFG_REQ_RX_CSUM_V2_MODE_ALL_OK  0x1UL
+	#define VNIC_CFG_REQ_RX_CSUM_V2_MODE_MAX     0x2UL
+	#define VNIC_CFG_REQ_RX_CSUM_V2_MODE_LAST   VNIC_CFG_REQ_RX_CSUM_V2_MODE_MAX
+	u8	l2_cqe_mode;
+	#define VNIC_CFG_REQ_L2_CQE_MODE_DEFAULT    0x0UL
+	#define VNIC_CFG_REQ_L2_CQE_MODE_COMPRESSED 0x1UL
+	#define VNIC_CFG_REQ_L2_CQE_MODE_MIXED      0x2UL
+	#define VNIC_CFG_REQ_L2_CQE_MODE_LAST      VNIC_CFG_REQ_L2_CQE_MODE_MIXED
+	__le32	raw_qp_id;
+};
+
+/* hwrm_vnic_cfg_output (size:128b/16B) */
+struct hwrm_vnic_cfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_vnic_qcaps_input (size:192b/24B) */
+struct hwrm_vnic_qcaps_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	enables;
+	u8	unused_0[4];
+};
+
+/* hwrm_vnic_qcaps_output (size:192b/24B) */
+struct hwrm_vnic_qcaps_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	mru;
+	u8	unused_0[2];
+	__le32	flags;
+	#define VNIC_QCAPS_RESP_FLAGS_UNUSED                                  0x1UL
+	#define VNIC_QCAPS_RESP_FLAGS_VLAN_STRIP_CAP                          0x2UL
+	#define VNIC_QCAPS_RESP_FLAGS_BD_STALL_CAP                            0x4UL
+	#define VNIC_QCAPS_RESP_FLAGS_ROCE_DUAL_VNIC_CAP                      0x8UL
+	#define VNIC_QCAPS_RESP_FLAGS_ROCE_ONLY_VNIC_CAP                      0x10UL
+	#define VNIC_QCAPS_RESP_FLAGS_RSS_DFLT_CR_CAP                         0x20UL
+	#define VNIC_QCAPS_RESP_FLAGS_ROCE_MIRRORING_CAPABLE_VNIC_CAP         0x40UL
+	#define VNIC_QCAPS_RESP_FLAGS_OUTERMOST_RSS_CAP                       0x80UL
+	#define VNIC_QCAPS_RESP_FLAGS_COS_ASSIGNMENT_CAP                      0x100UL
+	#define VNIC_QCAPS_RESP_FLAGS_RX_CMPL_V2_CAP                          0x200UL
+	#define VNIC_QCAPS_RESP_FLAGS_VNIC_STATE_CAP                          0x400UL
+	#define VNIC_QCAPS_RESP_FLAGS_VIRTIO_NET_VNIC_ALLOC_CAP               0x800UL
+	#define VNIC_QCAPS_RESP_FLAGS_METADATA_FORMAT_CAP                     0x1000UL
+	#define VNIC_QCAPS_RESP_FLAGS_RSS_STRICT_HASH_TYPE_CAP                0x2000UL
+	#define VNIC_QCAPS_RESP_FLAGS_RSS_HASH_TYPE_DELTA_CAP                 0x4000UL
+	#define VNIC_QCAPS_RESP_FLAGS_RING_SELECT_MODE_TOEPLITZ_CAP           0x8000UL
+	#define VNIC_QCAPS_RESP_FLAGS_RING_SELECT_MODE_XOR_CAP                0x10000UL
+	#define VNIC_QCAPS_RESP_FLAGS_RING_SELECT_MODE_TOEPLITZ_CHKSM_CAP     0x20000UL
+	#define VNIC_QCAPS_RESP_FLAGS_RSS_IPV6_FLOW_LABEL_CAP                 0x40000UL
+	#define VNIC_QCAPS_RESP_FLAGS_RX_CMPL_V3_CAP                          0x80000UL
+	#define VNIC_QCAPS_RESP_FLAGS_L2_CQE_MODE_CAP                         0x100000UL
+	#define VNIC_QCAPS_RESP_FLAGS_RSS_IPSEC_AH_SPI_IPV4_CAP               0x200000UL
+	#define VNIC_QCAPS_RESP_FLAGS_RSS_IPSEC_ESP_SPI_IPV4_CAP              0x400000UL
+	#define VNIC_QCAPS_RESP_FLAGS_RSS_IPSEC_AH_SPI_IPV6_CAP               0x800000UL
+	#define VNIC_QCAPS_RESP_FLAGS_RSS_IPSEC_ESP_SPI_IPV6_CAP              0x1000000UL
+	#define VNIC_QCAPS_RESP_FLAGS_OUTERMOST_RSS_TRUSTED_VF_CAP            0x2000000UL
+	#define VNIC_QCAPS_RESP_FLAGS_PORTCOS_MAPPING_MODE                    0x4000000UL
+	#define VNIC_QCAPS_RESP_FLAGS_RSS_PROF_TCAM_MODE_ENABLED              0x8000000UL
+	#define VNIC_QCAPS_RESP_FLAGS_VNIC_RSS_HASH_MODE_CAP                  0x10000000UL
+	#define VNIC_QCAPS_RESP_FLAGS_HW_TUNNEL_TPA_CAP                       0x20000000UL
+	#define VNIC_QCAPS_RESP_FLAGS_RE_FLUSH_CAP                            0x40000000UL
+	__le16	max_aggs_supported;
+	u8	unused_1[5];
+	u8	valid;
+};
+
+/* hwrm_vnic_tpa_cfg_input (size:384b/48B) */
+struct hwrm_vnic_tpa_cfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	flags;
+	#define VNIC_TPA_CFG_REQ_FLAGS_TPA                       0x1UL
+	#define VNIC_TPA_CFG_REQ_FLAGS_ENCAP_TPA                 0x2UL
+	#define VNIC_TPA_CFG_REQ_FLAGS_RSC_WND_UPDATE            0x4UL
+	#define VNIC_TPA_CFG_REQ_FLAGS_GRO                       0x8UL
+	#define VNIC_TPA_CFG_REQ_FLAGS_AGG_WITH_ECN              0x10UL
+	#define VNIC_TPA_CFG_REQ_FLAGS_AGG_WITH_SAME_GRE_SEQ     0x20UL
+	#define VNIC_TPA_CFG_REQ_FLAGS_GRO_IPID_CHECK            0x40UL
+	#define VNIC_TPA_CFG_REQ_FLAGS_GRO_TTL_CHECK             0x80UL
+	#define VNIC_TPA_CFG_REQ_FLAGS_AGG_PACK_AS_GRO           0x100UL
+	__le32	enables;
+	#define VNIC_TPA_CFG_REQ_ENABLES_MAX_AGG_SEGS      0x1UL
+	#define VNIC_TPA_CFG_REQ_ENABLES_MAX_AGGS          0x2UL
+	#define VNIC_TPA_CFG_REQ_ENABLES_MAX_AGG_TIMER     0x4UL
+	#define VNIC_TPA_CFG_REQ_ENABLES_MIN_AGG_LEN       0x8UL
+	#define VNIC_TPA_CFG_REQ_ENABLES_TNL_TPA_EN        0x10UL
+	__le16	vnic_id;
+	__le16	max_agg_segs;
+	#define VNIC_TPA_CFG_REQ_MAX_AGG_SEGS_1   0x0UL
+	#define VNIC_TPA_CFG_REQ_MAX_AGG_SEGS_2   0x1UL
+	#define VNIC_TPA_CFG_REQ_MAX_AGG_SEGS_4   0x2UL
+	#define VNIC_TPA_CFG_REQ_MAX_AGG_SEGS_8   0x3UL
+	#define VNIC_TPA_CFG_REQ_MAX_AGG_SEGS_MAX 0x1fUL
+	#define VNIC_TPA_CFG_REQ_MAX_AGG_SEGS_LAST VNIC_TPA_CFG_REQ_MAX_AGG_SEGS_MAX
+	__le16	max_aggs;
+	#define VNIC_TPA_CFG_REQ_MAX_AGGS_1   0x0UL
+	#define VNIC_TPA_CFG_REQ_MAX_AGGS_2   0x1UL
+	#define VNIC_TPA_CFG_REQ_MAX_AGGS_4   0x2UL
+	#define VNIC_TPA_CFG_REQ_MAX_AGGS_8   0x3UL
+	#define VNIC_TPA_CFG_REQ_MAX_AGGS_16  0x4UL
+	#define VNIC_TPA_CFG_REQ_MAX_AGGS_MAX 0x7UL
+	#define VNIC_TPA_CFG_REQ_MAX_AGGS_LAST VNIC_TPA_CFG_REQ_MAX_AGGS_MAX
+	u8	unused_0[2];
+	__le32	max_agg_timer;
+	__le32	min_agg_len;
+	__le32	tnl_tpa_en_bitmap;
+	#define VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_VXLAN           0x1UL
+	#define VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_GENEVE          0x2UL
+	#define VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_NVGRE           0x4UL
+	#define VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_GRE             0x8UL
+	#define VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_IPV4            0x10UL
+	#define VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_IPV6            0x20UL
+	#define VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_VXLAN_GPE       0x40UL
+	#define VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_VXLAN_CUST1     0x80UL
+	#define VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_GRE_CUST1       0x100UL
+	#define VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_UPAR1           0x200UL
+	#define VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_UPAR2           0x400UL
+	#define VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_UPAR3           0x800UL
+	#define VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_UPAR4           0x1000UL
+	#define VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_UPAR5           0x2000UL
+	#define VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_UPAR6           0x4000UL
+	#define VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_UPAR7           0x8000UL
+	#define VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_UPAR8           0x10000UL
+	u8	unused_1[4];
+};
+
+/* hwrm_vnic_tpa_cfg_output (size:128b/16B) */
+struct hwrm_vnic_tpa_cfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_vnic_tpa_qcfg_input (size:192b/24B) */
+struct hwrm_vnic_tpa_qcfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	vnic_id;
+	u8	unused_0[6];
+};
+
+/* hwrm_vnic_tpa_qcfg_output (size:256b/32B) */
+struct hwrm_vnic_tpa_qcfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le32	flags;
+	#define VNIC_TPA_QCFG_RESP_FLAGS_TPA                       0x1UL
+	#define VNIC_TPA_QCFG_RESP_FLAGS_ENCAP_TPA                 0x2UL
+	#define VNIC_TPA_QCFG_RESP_FLAGS_RSC_WND_UPDATE            0x4UL
+	#define VNIC_TPA_QCFG_RESP_FLAGS_GRO                       0x8UL
+	#define VNIC_TPA_QCFG_RESP_FLAGS_AGG_WITH_ECN              0x10UL
+	#define VNIC_TPA_QCFG_RESP_FLAGS_AGG_WITH_SAME_GRE_SEQ     0x20UL
+	#define VNIC_TPA_QCFG_RESP_FLAGS_GRO_IPID_CHECK            0x40UL
+	#define VNIC_TPA_QCFG_RESP_FLAGS_GRO_TTL_CHECK             0x80UL
+	__le16	max_agg_segs;
+	#define VNIC_TPA_QCFG_RESP_MAX_AGG_SEGS_1   0x0UL
+	#define VNIC_TPA_QCFG_RESP_MAX_AGG_SEGS_2   0x1UL
+	#define VNIC_TPA_QCFG_RESP_MAX_AGG_SEGS_4   0x2UL
+	#define VNIC_TPA_QCFG_RESP_MAX_AGG_SEGS_8   0x3UL
+	#define VNIC_TPA_QCFG_RESP_MAX_AGG_SEGS_MAX 0x1fUL
+	#define VNIC_TPA_QCFG_RESP_MAX_AGG_SEGS_LAST VNIC_TPA_QCFG_RESP_MAX_AGG_SEGS_MAX
+	__le16	max_aggs;
+	#define VNIC_TPA_QCFG_RESP_MAX_AGGS_1   0x0UL
+	#define VNIC_TPA_QCFG_RESP_MAX_AGGS_2   0x1UL
+	#define VNIC_TPA_QCFG_RESP_MAX_AGGS_4   0x2UL
+	#define VNIC_TPA_QCFG_RESP_MAX_AGGS_8   0x3UL
+	#define VNIC_TPA_QCFG_RESP_MAX_AGGS_16  0x4UL
+	#define VNIC_TPA_QCFG_RESP_MAX_AGGS_MAX 0x7UL
+	#define VNIC_TPA_QCFG_RESP_MAX_AGGS_LAST VNIC_TPA_QCFG_RESP_MAX_AGGS_MAX
+	__le32	max_agg_timer;
+	__le32	min_agg_len;
+	__le32	tnl_tpa_en_bitmap;
+	#define VNIC_TPA_QCFG_RESP_TNL_TPA_EN_BITMAP_VXLAN           0x1UL
+	#define VNIC_TPA_QCFG_RESP_TNL_TPA_EN_BITMAP_GENEVE          0x2UL
+	#define VNIC_TPA_QCFG_RESP_TNL_TPA_EN_BITMAP_NVGRE           0x4UL
+	#define VNIC_TPA_QCFG_RESP_TNL_TPA_EN_BITMAP_GRE             0x8UL
+	#define VNIC_TPA_QCFG_RESP_TNL_TPA_EN_BITMAP_IPV4            0x10UL
+	#define VNIC_TPA_QCFG_RESP_TNL_TPA_EN_BITMAP_IPV6            0x20UL
+	#define VNIC_TPA_QCFG_RESP_TNL_TPA_EN_BITMAP_VXLAN_GPE       0x40UL
+	#define VNIC_TPA_QCFG_RESP_TNL_TPA_EN_BITMAP_VXLAN_CUST1     0x80UL
+	#define VNIC_TPA_QCFG_RESP_TNL_TPA_EN_BITMAP_GRE_CUST1       0x100UL
+	#define VNIC_TPA_QCFG_RESP_TNL_TPA_EN_BITMAP_UPAR1           0x200UL
+	#define VNIC_TPA_QCFG_RESP_TNL_TPA_EN_BITMAP_UPAR2           0x400UL
+	#define VNIC_TPA_QCFG_RESP_TNL_TPA_EN_BITMAP_UPAR3           0x800UL
+	#define VNIC_TPA_QCFG_RESP_TNL_TPA_EN_BITMAP_UPAR4           0x1000UL
+	#define VNIC_TPA_QCFG_RESP_TNL_TPA_EN_BITMAP_UPAR5           0x2000UL
+	#define VNIC_TPA_QCFG_RESP_TNL_TPA_EN_BITMAP_UPAR6           0x4000UL
+	#define VNIC_TPA_QCFG_RESP_TNL_TPA_EN_BITMAP_UPAR7           0x8000UL
+	#define VNIC_TPA_QCFG_RESP_TNL_TPA_EN_BITMAP_UPAR8           0x10000UL
+	u8	unused_0[3];
+	u8	valid;
+};
+
+/* hwrm_vnic_rss_cfg_input (size:384b/48B) */
+struct hwrm_vnic_rss_cfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	hash_type;
+	#define VNIC_RSS_CFG_REQ_HASH_TYPE_IPV4                0x1UL
+	#define VNIC_RSS_CFG_REQ_HASH_TYPE_TCP_IPV4            0x2UL
+	#define VNIC_RSS_CFG_REQ_HASH_TYPE_UDP_IPV4            0x4UL
+	#define VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6                0x8UL
+	#define VNIC_RSS_CFG_REQ_HASH_TYPE_TCP_IPV6            0x10UL
+	#define VNIC_RSS_CFG_REQ_HASH_TYPE_UDP_IPV6            0x20UL
+	#define VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6_FLOW_LABEL     0x40UL
+	#define VNIC_RSS_CFG_REQ_HASH_TYPE_AH_SPI_IPV4         0x80UL
+	#define VNIC_RSS_CFG_REQ_HASH_TYPE_ESP_SPI_IPV4        0x100UL
+	#define VNIC_RSS_CFG_REQ_HASH_TYPE_AH_SPI_IPV6         0x200UL
+	#define VNIC_RSS_CFG_REQ_HASH_TYPE_ESP_SPI_IPV6        0x400UL
+	__le16	vnic_id;
+	u8	ring_table_pair_index;
+	u8	hash_mode_flags;
+	#define VNIC_RSS_CFG_REQ_HASH_MODE_FLAGS_DEFAULT         0x1UL
+	#define VNIC_RSS_CFG_REQ_HASH_MODE_FLAGS_INNERMOST_4     0x2UL
+	#define VNIC_RSS_CFG_REQ_HASH_MODE_FLAGS_INNERMOST_2     0x4UL
+	#define VNIC_RSS_CFG_REQ_HASH_MODE_FLAGS_OUTERMOST_4     0x8UL
+	#define VNIC_RSS_CFG_REQ_HASH_MODE_FLAGS_OUTERMOST_2     0x10UL
+	__le64	ring_grp_tbl_addr;
+	__le64	hash_key_tbl_addr;
+	__le16	rss_ctx_idx;
+	u8	flags;
+	#define VNIC_RSS_CFG_REQ_FLAGS_HASH_TYPE_INCLUDE               0x1UL
+	#define VNIC_RSS_CFG_REQ_FLAGS_HASH_TYPE_EXCLUDE               0x2UL
+	#define VNIC_RSS_CFG_REQ_FLAGS_IPSEC_HASH_TYPE_CFG_SUPPORT     0x4UL
+	u8	ring_select_mode;
+	#define VNIC_RSS_CFG_REQ_RING_SELECT_MODE_TOEPLITZ          0x0UL
+	#define VNIC_RSS_CFG_REQ_RING_SELECT_MODE_XOR               0x1UL
+	#define VNIC_RSS_CFG_REQ_RING_SELECT_MODE_TOEPLITZ_CHECKSUM 0x2UL
+	#define VNIC_RSS_CFG_REQ_RING_SELECT_MODE_LAST             VNIC_RSS_CFG_REQ_RING_SELECT_MODE_TOEPLITZ_CHECKSUM
+	u8	unused_1[4];
+};
+
+/* hwrm_vnic_rss_cfg_output (size:128b/16B) */
+struct hwrm_vnic_rss_cfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_vnic_rss_cfg_cmd_err (size:64b/8B) */
+struct hwrm_vnic_rss_cfg_cmd_err {
+	u8	code;
+	#define VNIC_RSS_CFG_CMD_ERR_CODE_UNKNOWN                      0x0UL
+	#define VNIC_RSS_CFG_CMD_ERR_CODE_INTERFACE_NOT_READY          0x1UL
+	#define VNIC_RSS_CFG_CMD_ERR_CODE_UNABLE_TO_GET_RSS_CFG        0x2UL
+	#define VNIC_RSS_CFG_CMD_ERR_CODE_HASH_TYPE_UNSUPPORTED        0x3UL
+	#define VNIC_RSS_CFG_CMD_ERR_CODE_HASH_TYPE_ERR                0x4UL
+	#define VNIC_RSS_CFG_CMD_ERR_CODE_HASH_MODE_FAIL               0x5UL
+	#define VNIC_RSS_CFG_CMD_ERR_CODE_RING_GRP_TABLE_ALLOC_ERR     0x6UL
+	#define VNIC_RSS_CFG_CMD_ERR_CODE_HASH_KEY_ALLOC_ERR           0x7UL
+	#define VNIC_RSS_CFG_CMD_ERR_CODE_DMA_FAILED                   0x8UL
+	#define VNIC_RSS_CFG_CMD_ERR_CODE_RX_RING_ALLOC_ERR            0x9UL
+	#define VNIC_RSS_CFG_CMD_ERR_CODE_CMPL_RING_ALLOC_ERR          0xaUL
+	#define VNIC_RSS_CFG_CMD_ERR_CODE_HW_SET_RSS_FAILED            0xbUL
+	#define VNIC_RSS_CFG_CMD_ERR_CODE_CTX_INVALID                  0xcUL
+	#define VNIC_RSS_CFG_CMD_ERR_CODE_VNIC_INVALID                 0xdUL
+	#define VNIC_RSS_CFG_CMD_ERR_CODE_VNIC_RING_TABLE_PAIR_INVALID 0xeUL
+	#define VNIC_RSS_CFG_CMD_ERR_CODE_LAST                        VNIC_RSS_CFG_CMD_ERR_CODE_VNIC_RING_TABLE_PAIR_INVALID
+	u8	unused_0[7];
+};
+
+/* hwrm_vnic_rss_qcfg_input (size:192b/24B) */
+struct hwrm_vnic_rss_qcfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	rss_ctx_idx;
+	__le16	vnic_id;
+	u8	unused_0[4];
+};
+
+/* hwrm_vnic_rss_qcfg_output (size:512b/64B) */
+struct hwrm_vnic_rss_qcfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le32	hash_type;
+	#define VNIC_RSS_QCFG_RESP_HASH_TYPE_IPV4                0x1UL
+	#define VNIC_RSS_QCFG_RESP_HASH_TYPE_TCP_IPV4            0x2UL
+	#define VNIC_RSS_QCFG_RESP_HASH_TYPE_UDP_IPV4            0x4UL
+	#define VNIC_RSS_QCFG_RESP_HASH_TYPE_IPV6                0x8UL
+	#define VNIC_RSS_QCFG_RESP_HASH_TYPE_TCP_IPV6            0x10UL
+	#define VNIC_RSS_QCFG_RESP_HASH_TYPE_UDP_IPV6            0x20UL
+	#define VNIC_RSS_QCFG_RESP_HASH_TYPE_IPV6_FLOW_LABEL     0x40UL
+	#define VNIC_RSS_QCFG_RESP_HASH_TYPE_AH_SPI_IPV4         0x80UL
+	#define VNIC_RSS_QCFG_RESP_HASH_TYPE_ESP_SPI_IPV4        0x100UL
+	#define VNIC_RSS_QCFG_RESP_HASH_TYPE_AH_SPI_IPV6         0x200UL
+	#define VNIC_RSS_QCFG_RESP_HASH_TYPE_ESP_SPI_IPV6        0x400UL
+	u8	unused_0[4];
+	__le32	hash_key[10];
+	u8	hash_mode_flags;
+	#define VNIC_RSS_QCFG_RESP_HASH_MODE_FLAGS_DEFAULT         0x1UL
+	#define VNIC_RSS_QCFG_RESP_HASH_MODE_FLAGS_INNERMOST_4     0x2UL
+	#define VNIC_RSS_QCFG_RESP_HASH_MODE_FLAGS_INNERMOST_2     0x4UL
+	#define VNIC_RSS_QCFG_RESP_HASH_MODE_FLAGS_OUTERMOST_4     0x8UL
+	#define VNIC_RSS_QCFG_RESP_HASH_MODE_FLAGS_OUTERMOST_2     0x10UL
+	u8	ring_select_mode;
+	#define VNIC_RSS_QCFG_RESP_RING_SELECT_MODE_TOEPLITZ          0x0UL
+	#define VNIC_RSS_QCFG_RESP_RING_SELECT_MODE_XOR               0x1UL
+	#define VNIC_RSS_QCFG_RESP_RING_SELECT_MODE_TOEPLITZ_CHECKSUM 0x2UL
+	#define VNIC_RSS_QCFG_RESP_RING_SELECT_MODE_LAST             VNIC_RSS_QCFG_RESP_RING_SELECT_MODE_TOEPLITZ_CHECKSUM
+	u8	unused_1[5];
+	u8	valid;
+};
+
+/* hwrm_vnic_plcmodes_cfg_input (size:320b/40B) */
+struct hwrm_vnic_plcmodes_cfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	flags;
+	#define VNIC_PLCMODES_CFG_REQ_FLAGS_REGULAR_PLACEMENT     0x1UL
+	#define VNIC_PLCMODES_CFG_REQ_FLAGS_JUMBO_PLACEMENT       0x2UL
+	#define VNIC_PLCMODES_CFG_REQ_FLAGS_HDS_IPV4              0x4UL
+	#define VNIC_PLCMODES_CFG_REQ_FLAGS_HDS_IPV6              0x8UL
+	#define VNIC_PLCMODES_CFG_REQ_FLAGS_HDS_FCOE              0x10UL
+	#define VNIC_PLCMODES_CFG_REQ_FLAGS_HDS_ROCE              0x20UL
+	#define VNIC_PLCMODES_CFG_REQ_FLAGS_VIRTIO_PLACEMENT      0x40UL
+	__le32	enables;
+	#define VNIC_PLCMODES_CFG_REQ_ENABLES_JUMBO_THRESH_VALID      0x1UL
+	#define VNIC_PLCMODES_CFG_REQ_ENABLES_HDS_OFFSET_VALID        0x2UL
+	#define VNIC_PLCMODES_CFG_REQ_ENABLES_HDS_THRESHOLD_VALID     0x4UL
+	#define VNIC_PLCMODES_CFG_REQ_ENABLES_MAX_BDS_VALID           0x8UL
+	__le32	vnic_id;
+	__le16	jumbo_thresh;
+	__le16	hds_offset;
+	__le16	hds_threshold;
+	__le16	max_bds;
+	u8	unused_0[4];
+};
+
+/* hwrm_vnic_plcmodes_cfg_output (size:128b/16B) */
+struct hwrm_vnic_plcmodes_cfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_vnic_plcmodes_cfg_cmd_err (size:64b/8B) */
+struct hwrm_vnic_plcmodes_cfg_cmd_err {
+	u8	code;
+	#define VNIC_PLCMODES_CFG_CMD_ERR_CODE_UNKNOWN               0x0UL
+	#define VNIC_PLCMODES_CFG_CMD_ERR_CODE_INVALID_HDS_THRESHOLD 0x1UL
+	#define VNIC_PLCMODES_CFG_CMD_ERR_CODE_LAST                 VNIC_PLCMODES_CFG_CMD_ERR_CODE_INVALID_HDS_THRESHOLD
+	u8	unused_0[7];
+};
+
+/* hwrm_vnic_rss_cos_lb_ctx_alloc_input (size:128b/16B) */
+struct hwrm_vnic_rss_cos_lb_ctx_alloc_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+};
+
+/* hwrm_vnic_rss_cos_lb_ctx_alloc_output (size:128b/16B) */
+struct hwrm_vnic_rss_cos_lb_ctx_alloc_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	rss_cos_lb_ctx_id;
+	u8	unused_0[5];
+	u8	valid;
+};
+
+/* hwrm_vnic_rss_cos_lb_ctx_free_input (size:192b/24B) */
+struct hwrm_vnic_rss_cos_lb_ctx_free_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	rss_cos_lb_ctx_id;
+	u8	unused_0[6];
+};
+
+/* hwrm_vnic_rss_cos_lb_ctx_free_output (size:128b/16B) */
+struct hwrm_vnic_rss_cos_lb_ctx_free_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_ring_alloc_input (size:768b/96B) */
+struct hwrm_ring_alloc_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	enables;
+	#define RING_ALLOC_REQ_ENABLES_RING_ARB_CFG              0x2UL
+	#define RING_ALLOC_REQ_ENABLES_STAT_CTX_ID_VALID         0x8UL
+	#define RING_ALLOC_REQ_ENABLES_MAX_BW_VALID              0x20UL
+	#define RING_ALLOC_REQ_ENABLES_RX_RING_ID_VALID          0x40UL
+	#define RING_ALLOC_REQ_ENABLES_NQ_RING_ID_VALID          0x80UL
+	#define RING_ALLOC_REQ_ENABLES_RX_BUF_SIZE_VALID         0x100UL
+	#define RING_ALLOC_REQ_ENABLES_SCHQ_ID                   0x200UL
+	#define RING_ALLOC_REQ_ENABLES_MPC_CHNLS_TYPE            0x400UL
+	#define RING_ALLOC_REQ_ENABLES_STEERING_TAG_VALID        0x800UL
+	#define RING_ALLOC_REQ_ENABLES_RX_RATE_PROFILE_VALID     0x1000UL
+	#define RING_ALLOC_REQ_ENABLES_DPI_VALID                 0x2000UL
+	u8	ring_type;
+	#define RING_ALLOC_REQ_RING_TYPE_L2_CMPL   0x0UL
+	#define RING_ALLOC_REQ_RING_TYPE_TX        0x1UL
+	#define RING_ALLOC_REQ_RING_TYPE_RX        0x2UL
+	#define RING_ALLOC_REQ_RING_TYPE_ROCE_CMPL 0x3UL
+	#define RING_ALLOC_REQ_RING_TYPE_RX_AGG    0x4UL
+	#define RING_ALLOC_REQ_RING_TYPE_NQ        0x5UL
+	#define RING_ALLOC_REQ_RING_TYPE_LAST     RING_ALLOC_REQ_RING_TYPE_NQ
+	u8	cmpl_coal_cnt;
+	#define RING_ALLOC_REQ_CMPL_COAL_CNT_COAL_OFF 0x0UL
+	#define RING_ALLOC_REQ_CMPL_COAL_CNT_COAL_4   0x1UL
+	#define RING_ALLOC_REQ_CMPL_COAL_CNT_COAL_8   0x2UL
+	#define RING_ALLOC_REQ_CMPL_COAL_CNT_COAL_12  0x3UL
+	#define RING_ALLOC_REQ_CMPL_COAL_CNT_COAL_16  0x4UL
+	#define RING_ALLOC_REQ_CMPL_COAL_CNT_COAL_24  0x5UL
+	#define RING_ALLOC_REQ_CMPL_COAL_CNT_COAL_32  0x6UL
+	#define RING_ALLOC_REQ_CMPL_COAL_CNT_COAL_48  0x7UL
+	#define RING_ALLOC_REQ_CMPL_COAL_CNT_COAL_64  0x8UL
+	#define RING_ALLOC_REQ_CMPL_COAL_CNT_COAL_96  0x9UL
+	#define RING_ALLOC_REQ_CMPL_COAL_CNT_COAL_128 0xaUL
+	#define RING_ALLOC_REQ_CMPL_COAL_CNT_COAL_192 0xbUL
+	#define RING_ALLOC_REQ_CMPL_COAL_CNT_COAL_256 0xcUL
+	#define RING_ALLOC_REQ_CMPL_COAL_CNT_COAL_320 0xdUL
+	#define RING_ALLOC_REQ_CMPL_COAL_CNT_COAL_384 0xeUL
+	#define RING_ALLOC_REQ_CMPL_COAL_CNT_COAL_MAX 0xfUL
+	#define RING_ALLOC_REQ_CMPL_COAL_CNT_LAST    RING_ALLOC_REQ_CMPL_COAL_CNT_COAL_MAX
+	__le16	flags;
+	#define RING_ALLOC_REQ_FLAGS_RX_SOP_PAD                        0x1UL
+	#define RING_ALLOC_REQ_FLAGS_DISABLE_CQ_OVERFLOW_DETECTION     0x2UL
+	#define RING_ALLOC_REQ_FLAGS_NQ_DBR_PACING                     0x4UL
+	#define RING_ALLOC_REQ_FLAGS_TX_PKT_TS_CMPL_ENABLE             0x8UL
+	__le64	page_tbl_addr;
+	__le32	fbo;
+	u8	page_size;
+	u8	page_tbl_depth;
+	__le16	schq_id;
+	__le32	length;
+	__le16	logical_id;
+	__le16	cmpl_ring_id;
+	__le16	queue_id;
+	__le16	rx_buf_size;
+	__le16	rx_ring_id;
+	__le16	nq_ring_id;
+	__le16	ring_arb_cfg;
+	#define RING_ALLOC_REQ_RING_ARB_CFG_ARB_POLICY_MASK      0xfUL
+	#define RING_ALLOC_REQ_RING_ARB_CFG_ARB_POLICY_SFT       0
+	#define RING_ALLOC_REQ_RING_ARB_CFG_ARB_POLICY_SP          0x1UL
+	#define RING_ALLOC_REQ_RING_ARB_CFG_ARB_POLICY_WFQ         0x2UL
+	#define RING_ALLOC_REQ_RING_ARB_CFG_ARB_POLICY_LAST       RING_ALLOC_REQ_RING_ARB_CFG_ARB_POLICY_WFQ
+	#define RING_ALLOC_REQ_RING_ARB_CFG_RSVD_MASK            0xf0UL
+	#define RING_ALLOC_REQ_RING_ARB_CFG_RSVD_SFT             4
+	#define RING_ALLOC_REQ_RING_ARB_CFG_ARB_POLICY_PARAM_MASK 0xff00UL
+	#define RING_ALLOC_REQ_RING_ARB_CFG_ARB_POLICY_PARAM_SFT 8
+	__le16	steering_tag;
+	__le32	reserved3;
+	__le32	stat_ctx_id;
+	__le32	reserved4;
+	__le32	max_bw;
+	#define RING_ALLOC_REQ_MAX_BW_BW_VALUE_MASK             0xfffffffUL
+	#define RING_ALLOC_REQ_MAX_BW_BW_VALUE_SFT              0
+	#define RING_ALLOC_REQ_MAX_BW_SCALE                     0x10000000UL
+	#define RING_ALLOC_REQ_MAX_BW_SCALE_BITS                  (0x0UL << 28)
+	#define RING_ALLOC_REQ_MAX_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define RING_ALLOC_REQ_MAX_BW_SCALE_LAST                 RING_ALLOC_REQ_MAX_BW_SCALE_BYTES
+	#define RING_ALLOC_REQ_MAX_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define RING_ALLOC_REQ_MAX_BW_BW_VALUE_UNIT_SFT         29
+	#define RING_ALLOC_REQ_MAX_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define RING_ALLOC_REQ_MAX_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define RING_ALLOC_REQ_MAX_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define RING_ALLOC_REQ_MAX_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define RING_ALLOC_REQ_MAX_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define RING_ALLOC_REQ_MAX_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define RING_ALLOC_REQ_MAX_BW_BW_VALUE_UNIT_LAST         RING_ALLOC_REQ_MAX_BW_BW_VALUE_UNIT_INVALID
+	u8	int_mode;
+	#define RING_ALLOC_REQ_INT_MODE_LEGACY 0x0UL
+	#define RING_ALLOC_REQ_INT_MODE_RSVD   0x1UL
+	#define RING_ALLOC_REQ_INT_MODE_MSIX   0x2UL
+	#define RING_ALLOC_REQ_INT_MODE_POLL   0x3UL
+	#define RING_ALLOC_REQ_INT_MODE_LAST  RING_ALLOC_REQ_INT_MODE_POLL
+	u8	mpc_chnls_type;
+	#define RING_ALLOC_REQ_MPC_CHNLS_TYPE_TCE     0x0UL
+	#define RING_ALLOC_REQ_MPC_CHNLS_TYPE_RCE     0x1UL
+	#define RING_ALLOC_REQ_MPC_CHNLS_TYPE_TE_CFA  0x2UL
+	#define RING_ALLOC_REQ_MPC_CHNLS_TYPE_RE_CFA  0x3UL
+	#define RING_ALLOC_REQ_MPC_CHNLS_TYPE_PRIMATE 0x4UL
+	#define RING_ALLOC_REQ_MPC_CHNLS_TYPE_LAST   RING_ALLOC_REQ_MPC_CHNLS_TYPE_PRIMATE
+	u8	rx_rate_profile_sel;
+	#define RING_ALLOC_REQ_RX_RATE_PROFILE_SEL_DEFAULT   0x0UL
+	#define RING_ALLOC_REQ_RX_RATE_PROFILE_SEL_POLL_MODE 0x1UL
+	#define RING_ALLOC_REQ_RX_RATE_PROFILE_SEL_LAST     RING_ALLOC_REQ_RX_RATE_PROFILE_SEL_POLL_MODE
+	u8	unused_4;
+	__le64	cq_handle;
+	__le16	dpi;
+	__le16	unused_5[3];
+};
+
+/* hwrm_ring_alloc_output (size:128b/16B) */
+struct hwrm_ring_alloc_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	ring_id;
+	__le16	logical_ring_id;
+	u8	push_buffer_index;
+	#define RING_ALLOC_RESP_PUSH_BUFFER_INDEX_PING_BUFFER 0x0UL
+	#define RING_ALLOC_RESP_PUSH_BUFFER_INDEX_PONG_BUFFER 0x1UL
+	#define RING_ALLOC_RESP_PUSH_BUFFER_INDEX_LAST       RING_ALLOC_RESP_PUSH_BUFFER_INDEX_PONG_BUFFER
+	u8	unused_0[2];
+	u8	valid;
+};
+
+/* hwrm_ring_free_input (size:256b/32B) */
+struct hwrm_ring_free_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	u8	ring_type;
+	#define RING_FREE_REQ_RING_TYPE_L2_CMPL   0x0UL
+	#define RING_FREE_REQ_RING_TYPE_TX        0x1UL
+	#define RING_FREE_REQ_RING_TYPE_RX        0x2UL
+	#define RING_FREE_REQ_RING_TYPE_ROCE_CMPL 0x3UL
+	#define RING_FREE_REQ_RING_TYPE_RX_AGG    0x4UL
+	#define RING_FREE_REQ_RING_TYPE_NQ        0x5UL
+	#define RING_FREE_REQ_RING_TYPE_LAST     RING_FREE_REQ_RING_TYPE_NQ
+	u8	flags;
+	#define RING_FREE_REQ_FLAGS_VIRTIO_RING_VALID 0x1UL
+	#define RING_FREE_REQ_FLAGS_LAST             RING_FREE_REQ_FLAGS_VIRTIO_RING_VALID
+	__le16	ring_id;
+	__le32	prod_idx;
+	__le32	opaque;
+	__le32	unused_1;
+};
+
+/* hwrm_ring_free_output (size:128b/16B) */
+struct hwrm_ring_free_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_ring_reset_input (size:192b/24B) */
+struct hwrm_ring_reset_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	u8	ring_type;
+	#define RING_RESET_REQ_RING_TYPE_L2_CMPL     0x0UL
+	#define RING_RESET_REQ_RING_TYPE_TX          0x1UL
+	#define RING_RESET_REQ_RING_TYPE_RX          0x2UL
+	#define RING_RESET_REQ_RING_TYPE_ROCE_CMPL   0x3UL
+	#define RING_RESET_REQ_RING_TYPE_RX_RING_GRP 0x6UL
+	#define RING_RESET_REQ_RING_TYPE_LAST       RING_RESET_REQ_RING_TYPE_RX_RING_GRP
+	u8	unused_0;
+	__le16	ring_id;
+	u8	unused_1[4];
+};
+
+/* hwrm_ring_reset_output (size:128b/16B) */
+struct hwrm_ring_reset_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	push_buffer_index;
+	#define RING_RESET_RESP_PUSH_BUFFER_INDEX_PING_BUFFER 0x0UL
+	#define RING_RESET_RESP_PUSH_BUFFER_INDEX_PONG_BUFFER 0x1UL
+	#define RING_RESET_RESP_PUSH_BUFFER_INDEX_LAST       RING_RESET_RESP_PUSH_BUFFER_INDEX_PONG_BUFFER
+	u8	unused_0[3];
+	u8	consumer_idx[3];
+	u8	valid;
+};
+
+/* hwrm_ring_aggint_qcaps_input (size:128b/16B) */
+struct hwrm_ring_aggint_qcaps_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+};
+
+/* hwrm_ring_aggint_qcaps_output (size:384b/48B) */
+struct hwrm_ring_aggint_qcaps_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le32	cmpl_params;
+	#define RING_AGGINT_QCAPS_RESP_CMPL_PARAMS_INT_LAT_TMR_MIN                  0x1UL
+	#define RING_AGGINT_QCAPS_RESP_CMPL_PARAMS_INT_LAT_TMR_MAX                  0x2UL
+	#define RING_AGGINT_QCAPS_RESP_CMPL_PARAMS_TIMER_RESET                      0x4UL
+	#define RING_AGGINT_QCAPS_RESP_CMPL_PARAMS_RING_IDLE                        0x8UL
+	#define RING_AGGINT_QCAPS_RESP_CMPL_PARAMS_NUM_CMPL_DMA_AGGR                0x10UL
+	#define RING_AGGINT_QCAPS_RESP_CMPL_PARAMS_NUM_CMPL_DMA_AGGR_DURING_INT     0x20UL
+	#define RING_AGGINT_QCAPS_RESP_CMPL_PARAMS_CMPL_AGGR_DMA_TMR                0x40UL
+	#define RING_AGGINT_QCAPS_RESP_CMPL_PARAMS_CMPL_AGGR_DMA_TMR_DURING_INT     0x80UL
+	#define RING_AGGINT_QCAPS_RESP_CMPL_PARAMS_NUM_CMPL_AGGR_INT                0x100UL
+	__le32	nq_params;
+	#define RING_AGGINT_QCAPS_RESP_NQ_PARAMS_INT_LAT_TMR_MIN     0x1UL
+	__le16	num_cmpl_dma_aggr_min;
+	__le16	num_cmpl_dma_aggr_max;
+	__le16	num_cmpl_dma_aggr_during_int_min;
+	__le16	num_cmpl_dma_aggr_during_int_max;
+	__le16	cmpl_aggr_dma_tmr_min;
+	__le16	cmpl_aggr_dma_tmr_max;
+	__le16	cmpl_aggr_dma_tmr_during_int_min;
+	__le16	cmpl_aggr_dma_tmr_during_int_max;
+	__le16	int_lat_tmr_min_min;
+	__le16	int_lat_tmr_min_max;
+	__le16	int_lat_tmr_max_min;
+	__le16	int_lat_tmr_max_max;
+	__le16	num_cmpl_aggr_int_min;
+	__le16	num_cmpl_aggr_int_max;
+	__le16	timer_units;
+	u8	unused_0[1];
+	u8	valid;
+};
+
+/* hwrm_ring_cmpl_ring_qaggint_params_input (size:192b/24B) */
+struct hwrm_ring_cmpl_ring_qaggint_params_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	ring_id;
+	__le16	flags;
+	#define RING_CMPL_RING_QAGGINT_PARAMS_REQ_FLAGS_UNUSED_0_MASK 0x3UL
+	#define RING_CMPL_RING_QAGGINT_PARAMS_REQ_FLAGS_UNUSED_0_SFT 0
+	#define RING_CMPL_RING_QAGGINT_PARAMS_REQ_FLAGS_IS_NQ        0x4UL
+	u8	unused_0[4];
+};
+
+/* hwrm_ring_cmpl_ring_qaggint_params_output (size:256b/32B) */
+struct hwrm_ring_cmpl_ring_qaggint_params_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	flags;
+	#define RING_CMPL_RING_QAGGINT_PARAMS_RESP_FLAGS_TIMER_RESET     0x1UL
+	#define RING_CMPL_RING_QAGGINT_PARAMS_RESP_FLAGS_RING_IDLE       0x2UL
+	__le16	num_cmpl_dma_aggr;
+	__le16	num_cmpl_dma_aggr_during_int;
+	__le16	cmpl_aggr_dma_tmr;
+	__le16	cmpl_aggr_dma_tmr_during_int;
+	__le16	int_lat_tmr_min;
+	__le16	int_lat_tmr_max;
+	__le16	num_cmpl_aggr_int;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_ring_cmpl_ring_cfg_aggint_params_input (size:320b/40B) */
+struct hwrm_ring_cmpl_ring_cfg_aggint_params_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	ring_id;
+	__le16	flags;
+	#define RING_CMPL_RING_CFG_AGGINT_PARAMS_REQ_FLAGS_TIMER_RESET     0x1UL
+	#define RING_CMPL_RING_CFG_AGGINT_PARAMS_REQ_FLAGS_RING_IDLE       0x2UL
+	#define RING_CMPL_RING_CFG_AGGINT_PARAMS_REQ_FLAGS_IS_NQ           0x4UL
+	__le16	num_cmpl_dma_aggr;
+	__le16	num_cmpl_dma_aggr_during_int;
+	__le16	cmpl_aggr_dma_tmr;
+	__le16	cmpl_aggr_dma_tmr_during_int;
+	__le16	int_lat_tmr_min;
+	__le16	int_lat_tmr_max;
+	__le16	num_cmpl_aggr_int;
+	__le16	enables;
+	#define RING_CMPL_RING_CFG_AGGINT_PARAMS_REQ_ENABLES_NUM_CMPL_DMA_AGGR                0x1UL
+	#define RING_CMPL_RING_CFG_AGGINT_PARAMS_REQ_ENABLES_NUM_CMPL_DMA_AGGR_DURING_INT     0x2UL
+	#define RING_CMPL_RING_CFG_AGGINT_PARAMS_REQ_ENABLES_CMPL_AGGR_DMA_TMR                0x4UL
+	#define RING_CMPL_RING_CFG_AGGINT_PARAMS_REQ_ENABLES_INT_LAT_TMR_MIN                  0x8UL
+	#define RING_CMPL_RING_CFG_AGGINT_PARAMS_REQ_ENABLES_INT_LAT_TMR_MAX                  0x10UL
+	#define RING_CMPL_RING_CFG_AGGINT_PARAMS_REQ_ENABLES_NUM_CMPL_AGGR_INT                0x20UL
+	u8	unused_0[4];
+};
+
+/* hwrm_ring_cmpl_ring_cfg_aggint_params_output (size:128b/16B) */
+struct hwrm_ring_cmpl_ring_cfg_aggint_params_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_ring_grp_alloc_input (size:192b/24B) */
+struct hwrm_ring_grp_alloc_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	cr;
+	__le16	rr;
+	__le16	ar;
+	__le16	sc;
+};
+
+/* hwrm_ring_grp_alloc_output (size:128b/16B) */
+struct hwrm_ring_grp_alloc_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le32	ring_group_id;
+	u8	unused_0[3];
+	u8	valid;
+};
+
+/* hwrm_ring_grp_free_input (size:192b/24B) */
+struct hwrm_ring_grp_free_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	ring_group_id;
+	u8	unused_0[4];
+};
+
+/* hwrm_ring_grp_free_output (size:128b/16B) */
+struct hwrm_ring_grp_free_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+#define DEFAULT_FLOW_ID 0xFFFFFFFFUL
+#define ROCEV1_FLOW_ID 0xFFFFFFFEUL
+#define ROCEV2_FLOW_ID 0xFFFFFFFDUL
+#define ROCEV2_CNP_FLOW_ID 0xFFFFFFFCUL
+
+/* hwrm_cfa_l2_filter_alloc_input (size:768b/96B) */
+struct hwrm_cfa_l2_filter_alloc_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	flags;
+	#define CFA_L2_FILTER_ALLOC_REQ_FLAGS_PATH              0x1UL
+	#define CFA_L2_FILTER_ALLOC_REQ_FLAGS_PATH_TX             0x0UL
+	#define CFA_L2_FILTER_ALLOC_REQ_FLAGS_PATH_RX             0x1UL
+	#define CFA_L2_FILTER_ALLOC_REQ_FLAGS_PATH_LAST          CFA_L2_FILTER_ALLOC_REQ_FLAGS_PATH_RX
+	#define CFA_L2_FILTER_ALLOC_REQ_FLAGS_LOOPBACK          0x2UL
+	#define CFA_L2_FILTER_ALLOC_REQ_FLAGS_DROP              0x4UL
+	#define CFA_L2_FILTER_ALLOC_REQ_FLAGS_OUTERMOST         0x8UL
+	#define CFA_L2_FILTER_ALLOC_REQ_FLAGS_TRAFFIC_MASK      0x30UL
+	#define CFA_L2_FILTER_ALLOC_REQ_FLAGS_TRAFFIC_SFT       4
+	#define CFA_L2_FILTER_ALLOC_REQ_FLAGS_TRAFFIC_NO_ROCE_L2  (0x0UL << 4)
+	#define CFA_L2_FILTER_ALLOC_REQ_FLAGS_TRAFFIC_L2          (0x1UL << 4)
+	#define CFA_L2_FILTER_ALLOC_REQ_FLAGS_TRAFFIC_ROCE        (0x2UL << 4)
+	#define CFA_L2_FILTER_ALLOC_REQ_FLAGS_TRAFFIC_LAST       CFA_L2_FILTER_ALLOC_REQ_FLAGS_TRAFFIC_ROCE
+	#define CFA_L2_FILTER_ALLOC_REQ_FLAGS_XDP_DISABLE       0x40UL
+	#define CFA_L2_FILTER_ALLOC_REQ_FLAGS_SOURCE_VALID      0x80UL
+	__le32	enables;
+	#define CFA_L2_FILTER_ALLOC_REQ_ENABLES_L2_ADDR             0x1UL
+	#define CFA_L2_FILTER_ALLOC_REQ_ENABLES_L2_ADDR_MASK        0x2UL
+	#define CFA_L2_FILTER_ALLOC_REQ_ENABLES_L2_OVLAN            0x4UL
+	#define CFA_L2_FILTER_ALLOC_REQ_ENABLES_L2_OVLAN_MASK       0x8UL
+	#define CFA_L2_FILTER_ALLOC_REQ_ENABLES_L2_IVLAN            0x10UL
+	#define CFA_L2_FILTER_ALLOC_REQ_ENABLES_L2_IVLAN_MASK       0x20UL
+	#define CFA_L2_FILTER_ALLOC_REQ_ENABLES_T_L2_ADDR           0x40UL
+	#define CFA_L2_FILTER_ALLOC_REQ_ENABLES_T_L2_ADDR_MASK      0x80UL
+	#define CFA_L2_FILTER_ALLOC_REQ_ENABLES_T_L2_OVLAN          0x100UL
+	#define CFA_L2_FILTER_ALLOC_REQ_ENABLES_T_L2_OVLAN_MASK     0x200UL
+	#define CFA_L2_FILTER_ALLOC_REQ_ENABLES_T_L2_IVLAN          0x400UL
+	#define CFA_L2_FILTER_ALLOC_REQ_ENABLES_T_L2_IVLAN_MASK     0x800UL
+	#define CFA_L2_FILTER_ALLOC_REQ_ENABLES_SRC_TYPE            0x1000UL
+	#define CFA_L2_FILTER_ALLOC_REQ_ENABLES_SRC_ID              0x2000UL
+	#define CFA_L2_FILTER_ALLOC_REQ_ENABLES_TUNNEL_TYPE         0x4000UL
+	#define CFA_L2_FILTER_ALLOC_REQ_ENABLES_DST_ID              0x8000UL
+	#define CFA_L2_FILTER_ALLOC_REQ_ENABLES_MIRROR_VNIC_ID      0x10000UL
+	#define CFA_L2_FILTER_ALLOC_REQ_ENABLES_NUM_VLANS           0x20000UL
+	#define CFA_L2_FILTER_ALLOC_REQ_ENABLES_T_NUM_VLANS         0x40000UL
+	u8	l2_addr[6];
+	u8	num_vlans;
+	u8	t_num_vlans;
+	u8	l2_addr_mask[6];
+	__le16	l2_ovlan;
+	__le16	l2_ovlan_mask;
+	__le16	l2_ivlan;
+	__le16	l2_ivlan_mask;
+	u8	unused_1[2];
+	u8	t_l2_addr[6];
+	u8	unused_2[2];
+	u8	t_l2_addr_mask[6];
+	__le16	t_l2_ovlan;
+	__le16	t_l2_ovlan_mask;
+	__le16	t_l2_ivlan;
+	__le16	t_l2_ivlan_mask;
+	u8	src_type;
+	#define CFA_L2_FILTER_ALLOC_REQ_SRC_TYPE_NPORT 0x0UL
+	#define CFA_L2_FILTER_ALLOC_REQ_SRC_TYPE_PF    0x1UL
+	#define CFA_L2_FILTER_ALLOC_REQ_SRC_TYPE_VF    0x2UL
+	#define CFA_L2_FILTER_ALLOC_REQ_SRC_TYPE_VNIC  0x3UL
+	#define CFA_L2_FILTER_ALLOC_REQ_SRC_TYPE_KONG  0x4UL
+	#define CFA_L2_FILTER_ALLOC_REQ_SRC_TYPE_APE   0x5UL
+	#define CFA_L2_FILTER_ALLOC_REQ_SRC_TYPE_BONO  0x6UL
+	#define CFA_L2_FILTER_ALLOC_REQ_SRC_TYPE_TANG  0x7UL
+	#define CFA_L2_FILTER_ALLOC_REQ_SRC_TYPE_LAST CFA_L2_FILTER_ALLOC_REQ_SRC_TYPE_TANG
+	u8	unused_3;
+	__le32	src_id;
+	u8	tunnel_type;
+	#define CFA_L2_FILTER_ALLOC_REQ_TUNNEL_TYPE_NONTUNNEL    0x0UL
+	#define CFA_L2_FILTER_ALLOC_REQ_TUNNEL_TYPE_VXLAN        0x1UL
+	#define CFA_L2_FILTER_ALLOC_REQ_TUNNEL_TYPE_NVGRE        0x2UL
+	#define CFA_L2_FILTER_ALLOC_REQ_TUNNEL_TYPE_L2GRE        0x3UL
+	#define CFA_L2_FILTER_ALLOC_REQ_TUNNEL_TYPE_IPIP         0x4UL
+	#define CFA_L2_FILTER_ALLOC_REQ_TUNNEL_TYPE_GENEVE       0x5UL
+	#define CFA_L2_FILTER_ALLOC_REQ_TUNNEL_TYPE_MPLS         0x6UL
+	#define CFA_L2_FILTER_ALLOC_REQ_TUNNEL_TYPE_STT          0x7UL
+	#define CFA_L2_FILTER_ALLOC_REQ_TUNNEL_TYPE_IPGRE        0x8UL
+	#define CFA_L2_FILTER_ALLOC_REQ_TUNNEL_TYPE_VXLAN_V4     0x9UL
+	#define CFA_L2_FILTER_ALLOC_REQ_TUNNEL_TYPE_IPGRE_V1     0xaUL
+	#define CFA_L2_FILTER_ALLOC_REQ_TUNNEL_TYPE_L2_ETYPE     0xbUL
+	#define CFA_L2_FILTER_ALLOC_REQ_TUNNEL_TYPE_VXLAN_GPE_V6 0xcUL
+	#define CFA_L2_FILTER_ALLOC_REQ_TUNNEL_TYPE_VXLAN_GPE    0x10UL
+	#define CFA_L2_FILTER_ALLOC_REQ_TUNNEL_TYPE_ANYTUNNEL    0xffUL
+	#define CFA_L2_FILTER_ALLOC_REQ_TUNNEL_TYPE_LAST        CFA_L2_FILTER_ALLOC_REQ_TUNNEL_TYPE_ANYTUNNEL
+	u8	unused_4;
+	__le16	dst_id;
+	__le16	mirror_vnic_id;
+	u8	pri_hint;
+	#define CFA_L2_FILTER_ALLOC_REQ_PRI_HINT_NO_PREFER    0x0UL
+	#define CFA_L2_FILTER_ALLOC_REQ_PRI_HINT_ABOVE_FILTER 0x1UL
+	#define CFA_L2_FILTER_ALLOC_REQ_PRI_HINT_BELOW_FILTER 0x2UL
+	#define CFA_L2_FILTER_ALLOC_REQ_PRI_HINT_MAX          0x3UL
+	#define CFA_L2_FILTER_ALLOC_REQ_PRI_HINT_MIN          0x4UL
+	#define CFA_L2_FILTER_ALLOC_REQ_PRI_HINT_LAST        CFA_L2_FILTER_ALLOC_REQ_PRI_HINT_MIN
+	u8	unused_5;
+	__le32	unused_6;
+	__le64	l2_filter_id_hint;
+};
+
+/* hwrm_cfa_l2_filter_alloc_output (size:192b/24B) */
+struct hwrm_cfa_l2_filter_alloc_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le64	l2_filter_id;
+	__le32	flow_id;
+	#define CFA_L2_FILTER_ALLOC_RESP_FLOW_ID_VALUE_MASK 0x3fffffffUL
+	#define CFA_L2_FILTER_ALLOC_RESP_FLOW_ID_VALUE_SFT 0
+	#define CFA_L2_FILTER_ALLOC_RESP_FLOW_ID_TYPE      0x40000000UL
+	#define CFA_L2_FILTER_ALLOC_RESP_FLOW_ID_TYPE_INT    (0x0UL << 30)
+	#define CFA_L2_FILTER_ALLOC_RESP_FLOW_ID_TYPE_EXT    (0x1UL << 30)
+	#define CFA_L2_FILTER_ALLOC_RESP_FLOW_ID_TYPE_LAST  CFA_L2_FILTER_ALLOC_RESP_FLOW_ID_TYPE_EXT
+	#define CFA_L2_FILTER_ALLOC_RESP_FLOW_ID_DIR       0x80000000UL
+	#define CFA_L2_FILTER_ALLOC_RESP_FLOW_ID_DIR_RX      (0x0UL << 31)
+	#define CFA_L2_FILTER_ALLOC_RESP_FLOW_ID_DIR_TX      (0x1UL << 31)
+	#define CFA_L2_FILTER_ALLOC_RESP_FLOW_ID_DIR_LAST   CFA_L2_FILTER_ALLOC_RESP_FLOW_ID_DIR_TX
+	u8	unused_0[3];
+	u8	valid;
+};
+
+/* hwrm_cfa_l2_filter_free_input (size:192b/24B) */
+struct hwrm_cfa_l2_filter_free_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le64	l2_filter_id;
+};
+
+/* hwrm_cfa_l2_filter_free_output (size:128b/16B) */
+struct hwrm_cfa_l2_filter_free_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_cfa_l2_filter_cfg_input (size:384b/48B) */
+struct hwrm_cfa_l2_filter_cfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	flags;
+	#define CFA_L2_FILTER_CFG_REQ_FLAGS_PATH                  0x1UL
+	#define CFA_L2_FILTER_CFG_REQ_FLAGS_PATH_TX                 0x0UL
+	#define CFA_L2_FILTER_CFG_REQ_FLAGS_PATH_RX                 0x1UL
+	#define CFA_L2_FILTER_CFG_REQ_FLAGS_PATH_LAST              CFA_L2_FILTER_CFG_REQ_FLAGS_PATH_RX
+	#define CFA_L2_FILTER_CFG_REQ_FLAGS_DROP                  0x2UL
+	#define CFA_L2_FILTER_CFG_REQ_FLAGS_TRAFFIC_MASK          0xcUL
+	#define CFA_L2_FILTER_CFG_REQ_FLAGS_TRAFFIC_SFT           2
+	#define CFA_L2_FILTER_CFG_REQ_FLAGS_TRAFFIC_NO_ROCE_L2      (0x0UL << 2)
+	#define CFA_L2_FILTER_CFG_REQ_FLAGS_TRAFFIC_L2              (0x1UL << 2)
+	#define CFA_L2_FILTER_CFG_REQ_FLAGS_TRAFFIC_ROCE            (0x2UL << 2)
+	#define CFA_L2_FILTER_CFG_REQ_FLAGS_TRAFFIC_LAST           CFA_L2_FILTER_CFG_REQ_FLAGS_TRAFFIC_ROCE
+	#define CFA_L2_FILTER_CFG_REQ_FLAGS_REMAP_OP_MASK         0x30UL
+	#define CFA_L2_FILTER_CFG_REQ_FLAGS_REMAP_OP_SFT          4
+	#define CFA_L2_FILTER_CFG_REQ_FLAGS_REMAP_OP_NO_UPDATE      (0x0UL << 4)
+	#define CFA_L2_FILTER_CFG_REQ_FLAGS_REMAP_OP_BYPASS_LKUP    (0x1UL << 4)
+	#define CFA_L2_FILTER_CFG_REQ_FLAGS_REMAP_OP_ENABLE_LKUP    (0x2UL << 4)
+	#define CFA_L2_FILTER_CFG_REQ_FLAGS_REMAP_OP_RESTORE_FW_OP  (0x3UL << 4)
+	#define CFA_L2_FILTER_CFG_REQ_FLAGS_REMAP_OP_LAST          CFA_L2_FILTER_CFG_REQ_FLAGS_REMAP_OP_RESTORE_FW_OP
+	__le32	enables;
+	#define CFA_L2_FILTER_CFG_REQ_ENABLES_DST_ID                 0x1UL
+	#define CFA_L2_FILTER_CFG_REQ_ENABLES_NEW_MIRROR_VNIC_ID     0x2UL
+	#define CFA_L2_FILTER_CFG_REQ_ENABLES_PROF_FUNC              0x4UL
+	#define CFA_L2_FILTER_CFG_REQ_ENABLES_L2_CONTEXT_ID          0x8UL
+	__le64	l2_filter_id;
+	__le32	dst_id;
+	__le32	new_mirror_vnic_id;
+	__le32	prof_func;
+	__le32	l2_context_id;
+};
+
+/* hwrm_cfa_l2_filter_cfg_output (size:128b/16B) */
+struct hwrm_cfa_l2_filter_cfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_cfa_l2_set_rx_mask_input (size:448b/56B) */
+struct hwrm_cfa_l2_set_rx_mask_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	vnic_id;
+	__le32	mask;
+	#define CFA_L2_SET_RX_MASK_REQ_MASK_MCAST               0x2UL
+	#define CFA_L2_SET_RX_MASK_REQ_MASK_ALL_MCAST           0x4UL
+	#define CFA_L2_SET_RX_MASK_REQ_MASK_BCAST               0x8UL
+	#define CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS         0x10UL
+	#define CFA_L2_SET_RX_MASK_REQ_MASK_OUTERMOST           0x20UL
+	#define CFA_L2_SET_RX_MASK_REQ_MASK_VLANONLY            0x40UL
+	#define CFA_L2_SET_RX_MASK_REQ_MASK_VLAN_NONVLAN        0x80UL
+	#define CFA_L2_SET_RX_MASK_REQ_MASK_ANYVLAN_NONVLAN     0x100UL
+	__le64	mc_tbl_addr;
+	__le32	num_mc_entries;
+	u8	unused_0[4];
+	__le64	vlan_tag_tbl_addr;
+	__le32	num_vlan_tags;
+	u8	unused_1[4];
+};
+
+/* hwrm_cfa_l2_set_rx_mask_output (size:128b/16B) */
+struct hwrm_cfa_l2_set_rx_mask_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_cfa_l2_set_rx_mask_cmd_err (size:64b/8B) */
+struct hwrm_cfa_l2_set_rx_mask_cmd_err {
+	u8	code;
+	#define CFA_L2_SET_RX_MASK_CMD_ERR_CODE_UNKNOWN                    0x0UL
+	#define CFA_L2_SET_RX_MASK_CMD_ERR_CODE_NTUPLE_FILTER_CONFLICT_ERR 0x1UL
+	#define CFA_L2_SET_RX_MASK_CMD_ERR_CODE_MAX_VLAN_TAGS              0x2UL
+	#define CFA_L2_SET_RX_MASK_CMD_ERR_CODE_INVALID_VNIC_ID            0x3UL
+	#define CFA_L2_SET_RX_MASK_CMD_ERR_CODE_INVALID_ACTION             0x4UL
+	#define CFA_L2_SET_RX_MASK_CMD_ERR_CODE_LAST                      CFA_L2_SET_RX_MASK_CMD_ERR_CODE_INVALID_ACTION
+	u8	unused_0[7];
+};
+
+/* hwrm_cfa_tunnel_filter_alloc_input (size:704b/88B) */
+struct hwrm_cfa_tunnel_filter_alloc_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	flags;
+	#define CFA_TUNNEL_FILTER_ALLOC_REQ_FLAGS_LOOPBACK     0x1UL
+	__le32	enables;
+	#define CFA_TUNNEL_FILTER_ALLOC_REQ_ENABLES_L2_FILTER_ID       0x1UL
+	#define CFA_TUNNEL_FILTER_ALLOC_REQ_ENABLES_L2_ADDR            0x2UL
+	#define CFA_TUNNEL_FILTER_ALLOC_REQ_ENABLES_L2_IVLAN           0x4UL
+	#define CFA_TUNNEL_FILTER_ALLOC_REQ_ENABLES_L3_ADDR            0x8UL
+	#define CFA_TUNNEL_FILTER_ALLOC_REQ_ENABLES_L3_ADDR_TYPE       0x10UL
+	#define CFA_TUNNEL_FILTER_ALLOC_REQ_ENABLES_T_L3_ADDR_TYPE     0x20UL
+	#define CFA_TUNNEL_FILTER_ALLOC_REQ_ENABLES_T_L3_ADDR          0x40UL
+	#define CFA_TUNNEL_FILTER_ALLOC_REQ_ENABLES_TUNNEL_TYPE        0x80UL
+	#define CFA_TUNNEL_FILTER_ALLOC_REQ_ENABLES_VNI                0x100UL
+	#define CFA_TUNNEL_FILTER_ALLOC_REQ_ENABLES_DST_VNIC_ID        0x200UL
+	#define CFA_TUNNEL_FILTER_ALLOC_REQ_ENABLES_MIRROR_VNIC_ID     0x400UL
+	__le64	l2_filter_id;
+	u8	l2_addr[6];
+	__le16	l2_ivlan;
+	__le32	l3_addr[4];
+	__le32	t_l3_addr[4];
+	u8	l3_addr_type;
+	u8	t_l3_addr_type;
+	u8	tunnel_type;
+	#define CFA_TUNNEL_FILTER_ALLOC_REQ_TUNNEL_TYPE_NONTUNNEL    0x0UL
+	#define CFA_TUNNEL_FILTER_ALLOC_REQ_TUNNEL_TYPE_VXLAN        0x1UL
+	#define CFA_TUNNEL_FILTER_ALLOC_REQ_TUNNEL_TYPE_NVGRE        0x2UL
+	#define CFA_TUNNEL_FILTER_ALLOC_REQ_TUNNEL_TYPE_L2GRE        0x3UL
+	#define CFA_TUNNEL_FILTER_ALLOC_REQ_TUNNEL_TYPE_IPIP         0x4UL
+	#define CFA_TUNNEL_FILTER_ALLOC_REQ_TUNNEL_TYPE_GENEVE       0x5UL
+	#define CFA_TUNNEL_FILTER_ALLOC_REQ_TUNNEL_TYPE_MPLS         0x6UL
+	#define CFA_TUNNEL_FILTER_ALLOC_REQ_TUNNEL_TYPE_STT          0x7UL
+	#define CFA_TUNNEL_FILTER_ALLOC_REQ_TUNNEL_TYPE_IPGRE        0x8UL
+	#define CFA_TUNNEL_FILTER_ALLOC_REQ_TUNNEL_TYPE_VXLAN_V4     0x9UL
+	#define CFA_TUNNEL_FILTER_ALLOC_REQ_TUNNEL_TYPE_IPGRE_V1     0xaUL
+	#define CFA_TUNNEL_FILTER_ALLOC_REQ_TUNNEL_TYPE_L2_ETYPE     0xbUL
+	#define CFA_TUNNEL_FILTER_ALLOC_REQ_TUNNEL_TYPE_VXLAN_GPE_V6 0xcUL
+	#define CFA_TUNNEL_FILTER_ALLOC_REQ_TUNNEL_TYPE_VXLAN_GPE    0x10UL
+	#define CFA_TUNNEL_FILTER_ALLOC_REQ_TUNNEL_TYPE_ANYTUNNEL    0xffUL
+	#define CFA_TUNNEL_FILTER_ALLOC_REQ_TUNNEL_TYPE_LAST        CFA_TUNNEL_FILTER_ALLOC_REQ_TUNNEL_TYPE_ANYTUNNEL
+	u8	tunnel_flags;
+	#define CFA_TUNNEL_FILTER_ALLOC_REQ_TUNNEL_FLAGS_TUN_FLAGS_OAM_CHECKSUM_EXPLHDR     0x1UL
+	#define CFA_TUNNEL_FILTER_ALLOC_REQ_TUNNEL_FLAGS_TUN_FLAGS_CRITICAL_OPT_S1          0x2UL
+	#define CFA_TUNNEL_FILTER_ALLOC_REQ_TUNNEL_FLAGS_TUN_FLAGS_EXTHDR_SEQNUM_S0         0x4UL
+	__le32	vni;
+	__le32	dst_vnic_id;
+	__le32	mirror_vnic_id;
+};
+
+/* hwrm_cfa_tunnel_filter_alloc_output (size:192b/24B) */
+struct hwrm_cfa_tunnel_filter_alloc_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le64	tunnel_filter_id;
+	__le32	flow_id;
+	#define CFA_TUNNEL_FILTER_ALLOC_RESP_FLOW_ID_VALUE_MASK 0x3fffffffUL
+	#define CFA_TUNNEL_FILTER_ALLOC_RESP_FLOW_ID_VALUE_SFT 0
+	#define CFA_TUNNEL_FILTER_ALLOC_RESP_FLOW_ID_TYPE      0x40000000UL
+	#define CFA_TUNNEL_FILTER_ALLOC_RESP_FLOW_ID_TYPE_INT    (0x0UL << 30)
+	#define CFA_TUNNEL_FILTER_ALLOC_RESP_FLOW_ID_TYPE_EXT    (0x1UL << 30)
+	#define CFA_TUNNEL_FILTER_ALLOC_RESP_FLOW_ID_TYPE_LAST  CFA_TUNNEL_FILTER_ALLOC_RESP_FLOW_ID_TYPE_EXT
+	#define CFA_TUNNEL_FILTER_ALLOC_RESP_FLOW_ID_DIR       0x80000000UL
+	#define CFA_TUNNEL_FILTER_ALLOC_RESP_FLOW_ID_DIR_RX      (0x0UL << 31)
+	#define CFA_TUNNEL_FILTER_ALLOC_RESP_FLOW_ID_DIR_TX      (0x1UL << 31)
+	#define CFA_TUNNEL_FILTER_ALLOC_RESP_FLOW_ID_DIR_LAST   CFA_TUNNEL_FILTER_ALLOC_RESP_FLOW_ID_DIR_TX
+	u8	unused_0[3];
+	u8	valid;
+};
+
+/* hwrm_cfa_tunnel_filter_free_input (size:192b/24B) */
+struct hwrm_cfa_tunnel_filter_free_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le64	tunnel_filter_id;
+};
+
+/* hwrm_cfa_tunnel_filter_free_output (size:128b/16B) */
+struct hwrm_cfa_tunnel_filter_free_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_cfa_ntuple_filter_alloc_output (size:192b/24B) */
+struct hwrm_cfa_ntuple_filter_alloc_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le64	ntuple_filter_id;
+	__le32	flow_id;
+	#define CFA_NTUPLE_FILTER_ALLOC_RESP_FLOW_ID_VALUE_MASK 0x3fffffffUL
+	#define CFA_NTUPLE_FILTER_ALLOC_RESP_FLOW_ID_VALUE_SFT 0
+	#define CFA_NTUPLE_FILTER_ALLOC_RESP_FLOW_ID_TYPE      0x40000000UL
+	#define CFA_NTUPLE_FILTER_ALLOC_RESP_FLOW_ID_TYPE_INT    (0x0UL << 30)
+	#define CFA_NTUPLE_FILTER_ALLOC_RESP_FLOW_ID_TYPE_EXT    (0x1UL << 30)
+	#define CFA_NTUPLE_FILTER_ALLOC_RESP_FLOW_ID_TYPE_LAST  CFA_NTUPLE_FILTER_ALLOC_RESP_FLOW_ID_TYPE_EXT
+	#define CFA_NTUPLE_FILTER_ALLOC_RESP_FLOW_ID_DIR       0x80000000UL
+	#define CFA_NTUPLE_FILTER_ALLOC_RESP_FLOW_ID_DIR_RX      (0x0UL << 31)
+	#define CFA_NTUPLE_FILTER_ALLOC_RESP_FLOW_ID_DIR_TX      (0x1UL << 31)
+	#define CFA_NTUPLE_FILTER_ALLOC_RESP_FLOW_ID_DIR_LAST   CFA_NTUPLE_FILTER_ALLOC_RESP_FLOW_ID_DIR_TX
+	u8	unused_0[3];
+	u8	valid;
+};
+
+/* hwrm_cfa_ntuple_filter_alloc_cmd_err (size:64b/8B) */
+struct hwrm_cfa_ntuple_filter_alloc_cmd_err {
+	u8	code;
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_UNKNOWN            0x0UL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_ZERO_MAC           0x65UL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_BC_MC_MAC          0x66UL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_INVALID_VNIC       0x67UL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_INVALID_PF_FID     0x68UL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_INVALID_L2_CTXT_ID 0x69UL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_NULL_L2_CTXT_CFG   0x6aUL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_NULL_L2_DATA_FLD   0x6bUL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_INVALID_CFA_LAYOUT 0x6cUL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_L2_CTXT_ALLOC_FAIL 0x6dUL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_ROCE_FLOW_ERR      0x6eUL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_INVALID_OWNER_FID  0x6fUL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_ZERO_REF_CNT       0x70UL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_INVALID_FLOW_TYPE  0x71UL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_INVALID_IVLAN      0x72UL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_MAX_VLAN_ID        0x73UL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_INVALID_TNL_REQ    0x74UL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_L2_ADDR            0x75UL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_L2_IVLAN           0x76UL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_L3_ADDR            0x77UL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_L3_ADDR_TYPE       0x78UL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_T_L3_ADDR_TYPE     0x79UL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_DST_VNIC_ID        0x7aUL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_VNI                0x7bUL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_INVALID_DST_ID     0x7cUL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_FAIL_ROCE_L2_FLOW  0x7dUL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_INVALID_NPAR_VLAN  0x7eUL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_ATSP_ADD           0x7fUL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_DFLT_VLAN_FAIL     0x80UL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_INVALID_L3_TYPE    0x81UL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_VAL_FAIL_TNL_FLOW  0x82UL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_LAST              CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_VAL_FAIL_TNL_FLOW
+	u8	unused_0[7];
+};
+
+/* hwrm_cfa_ntuple_filter_free_input (size:192b/24B) */
+struct hwrm_cfa_ntuple_filter_free_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le64	ntuple_filter_id;
+};
+
+/* hwrm_cfa_ntuple_filter_free_output (size:128b/16B) */
+struct hwrm_cfa_ntuple_filter_free_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_cfa_ntuple_filter_cfg_input (size:384b/48B) */
+struct hwrm_cfa_ntuple_filter_cfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	enables;
+	#define CFA_NTUPLE_FILTER_CFG_REQ_ENABLES_NEW_DST_ID                0x1UL
+	#define CFA_NTUPLE_FILTER_CFG_REQ_ENABLES_NEW_MIRROR_VNIC_ID        0x2UL
+	#define CFA_NTUPLE_FILTER_CFG_REQ_ENABLES_NEW_METER_INSTANCE_ID     0x4UL
+	__le32	flags;
+	#define CFA_NTUPLE_FILTER_CFG_REQ_FLAGS_DEST_FID              0x1UL
+	#define CFA_NTUPLE_FILTER_CFG_REQ_FLAGS_DEST_RFS_RING_IDX     0x2UL
+	#define CFA_NTUPLE_FILTER_CFG_REQ_FLAGS_NO_L2_CONTEXT         0x4UL
+	__le64	ntuple_filter_id;
+	__le32	new_dst_id;
+	__le32	new_mirror_vnic_id;
+	__le16	new_meter_instance_id;
+	#define CFA_NTUPLE_FILTER_CFG_REQ_NEW_METER_INSTANCE_ID_INVALID 0xffffUL
+	#define CFA_NTUPLE_FILTER_CFG_REQ_NEW_METER_INSTANCE_ID_LAST   CFA_NTUPLE_FILTER_CFG_REQ_NEW_METER_INSTANCE_ID_INVALID
+	u8	unused_1[6];
+};
+
+/* hwrm_cfa_ntuple_filter_cfg_output (size:128b/16B) */
+struct hwrm_cfa_ntuple_filter_cfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_tunnel_dst_port_alloc_input (size:192b/24B) */
+struct hwrm_tunnel_dst_port_alloc_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	u8	tunnel_type;
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_VXLAN              0x1UL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_GENEVE             0x5UL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_VXLAN_V4           0x9UL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_IPGRE_V1           0xaUL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_L2_ETYPE           0xbUL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_VXLAN_GPE_V6       0xcUL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_CUSTOM_GRE         0xdUL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_ECPRI              0xeUL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_SRV6               0xfUL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_VXLAN_GPE          0x10UL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_GRE                0x11UL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_ULP_DYN_UPAR       0x12UL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES01 0x13UL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES02 0x14UL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES03 0x15UL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES04 0x16UL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES05 0x17UL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES06 0x18UL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES07 0x19UL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_LAST              TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES07
+	u8	tunnel_next_proto;
+	__be16	tunnel_dst_port_val;
+	u8	unused_0[4];
+};
+
+/* hwrm_tunnel_dst_port_alloc_output (size:128b/16B) */
+struct hwrm_tunnel_dst_port_alloc_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	tunnel_dst_port_id;
+	u8	error_info;
+	#define TUNNEL_DST_PORT_ALLOC_RESP_ERROR_INFO_SUCCESS         0x0UL
+	#define TUNNEL_DST_PORT_ALLOC_RESP_ERROR_INFO_ERR_ALLOCATED   0x1UL
+	#define TUNNEL_DST_PORT_ALLOC_RESP_ERROR_INFO_ERR_NO_RESOURCE 0x2UL
+	#define TUNNEL_DST_PORT_ALLOC_RESP_ERROR_INFO_ERR_ENABLED     0x3UL
+	#define TUNNEL_DST_PORT_ALLOC_RESP_ERROR_INFO_LAST           TUNNEL_DST_PORT_ALLOC_RESP_ERROR_INFO_ERR_ENABLED
+	u8	upar_in_use;
+	#define TUNNEL_DST_PORT_ALLOC_RESP_UPAR_IN_USE_UPAR0     0x1UL
+	#define TUNNEL_DST_PORT_ALLOC_RESP_UPAR_IN_USE_UPAR1     0x2UL
+	#define TUNNEL_DST_PORT_ALLOC_RESP_UPAR_IN_USE_UPAR2     0x4UL
+	#define TUNNEL_DST_PORT_ALLOC_RESP_UPAR_IN_USE_UPAR3     0x8UL
+	#define TUNNEL_DST_PORT_ALLOC_RESP_UPAR_IN_USE_UPAR4     0x10UL
+	#define TUNNEL_DST_PORT_ALLOC_RESP_UPAR_IN_USE_UPAR5     0x20UL
+	#define TUNNEL_DST_PORT_ALLOC_RESP_UPAR_IN_USE_UPAR6     0x40UL
+	#define TUNNEL_DST_PORT_ALLOC_RESP_UPAR_IN_USE_UPAR7     0x80UL
+	u8	unused_0[3];
+	u8	valid;
+};
+
+/* hwrm_tunnel_dst_port_alloc_cmd_err (size:64b/8B) */
+struct hwrm_tunnel_dst_port_alloc_cmd_err {
+	u8	code;
+	#define TUNNEL_DST_PORT_ALLOC_CMD_ERR_UNKNOWN              0x0UL
+	#define TUNNEL_DST_PORT_ALLOC_CMD_ERR_TUNNEL_ALLOC_ERR     0x1UL
+	#define TUNNEL_DST_PORT_ALLOC_CMD_ERR_ACCESS_DENIED        0x2UL
+	#define TUNNEL_DST_PORT_ALLOC_CMD_ERR_GET_PORT_FAILED      0x3UL
+	#define TUNNEL_DST_PORT_ALLOC_CMD_ERR_PORT_NUM_ERR         0x4UL
+	#define TUNNEL_DST_PORT_ALLOC_CMD_ERR_CUSTOM_TNL_PORT_ERR  0x5UL
+	#define TUNNEL_DST_PORT_ALLOC_CMD_ERR_TUNNEL_QUERY_ERR     0x6UL
+	#define TUNNEL_DST_PORT_ALLOC_CMD_ERR_GRE_MODE_UNSUPPORTED 0x7UL
+	#define TUNNEL_DST_PORT_ALLOC_CMD_ERR_GRE_ALREADY_ALLOC    0x8UL
+	#define TUNNEL_DST_PORT_ALLOC_CMD_ERR_TUNNEL_TYPE_INVALID  0x9UL
+	#define TUNNEL_DST_PORT_ALLOC_CMD_ERR_UPAR_ERR             0xaUL
+	#define TUNNEL_DST_PORT_ALLOC_CMD_ERR_LAST                TUNNEL_DST_PORT_ALLOC_CMD_ERR_UPAR_ERR
+	u8	unused_0[7];
+};
+
+/* hwrm_tunnel_dst_port_free_input (size:192b/24B) */
+struct hwrm_tunnel_dst_port_free_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	u8	tunnel_type;
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_VXLAN              0x1UL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_GENEVE             0x5UL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_VXLAN_V4           0x9UL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_IPGRE_V1           0xaUL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_L2_ETYPE           0xbUL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_VXLAN_GPE_V6       0xcUL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_CUSTOM_GRE         0xdUL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_ECPRI              0xeUL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_SRV6               0xfUL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_VXLAN_GPE          0x10UL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_GRE                0x11UL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_ULP_DYN_UPAR       0x12UL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES01 0x13UL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES02 0x14UL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES03 0x15UL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES04 0x16UL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES05 0x17UL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES06 0x18UL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES07 0x19UL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_LAST              TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES07
+	u8	tunnel_next_proto;
+	__le16	tunnel_dst_port_id;
+	u8	unused_0[4];
+};
+
+/* hwrm_tunnel_dst_port_free_output (size:128b/16B) */
+struct hwrm_tunnel_dst_port_free_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	error_info;
+	#define TUNNEL_DST_PORT_FREE_RESP_ERROR_INFO_SUCCESS           0x0UL
+	#define TUNNEL_DST_PORT_FREE_RESP_ERROR_INFO_ERR_NOT_OWNER     0x1UL
+	#define TUNNEL_DST_PORT_FREE_RESP_ERROR_INFO_ERR_NOT_ALLOCATED 0x2UL
+	#define TUNNEL_DST_PORT_FREE_RESP_ERROR_INFO_LAST             TUNNEL_DST_PORT_FREE_RESP_ERROR_INFO_ERR_NOT_ALLOCATED
+	u8	unused_1[6];
+	u8	valid;
+};
+
+/* ctx_hw_stats (size:1280b/160B) */
+struct ctx_hw_stats {
+	__le64	rx_ucast_pkts;
+	__le64	rx_mcast_pkts;
+	__le64	rx_bcast_pkts;
+	__le64	rx_discard_pkts;
+	__le64	rx_error_pkts;
+	__le64	rx_ucast_bytes;
+	__le64	rx_mcast_bytes;
+	__le64	rx_bcast_bytes;
+	__le64	tx_ucast_pkts;
+	__le64	tx_mcast_pkts;
+	__le64	tx_bcast_pkts;
+	__le64	tx_error_pkts;
+	__le64	tx_discard_pkts;
+	__le64	tx_ucast_bytes;
+	__le64	tx_mcast_bytes;
+	__le64	tx_bcast_bytes;
+	__le64	tpa_pkts;
+	__le64	tpa_bytes;
+	__le64	tpa_events;
+	__le64	tpa_aborts;
+};
+
+#define HWRM_STAT_COMMON_CMD_ERR_CODE_UNKNOWN                 0x0UL
+#define HWRM_STAT_COMMON_CMD_ERR_CODE_INVALID_FID             0x65UL
+#define HWRM_STAT_COMMON_CMD_ERR_CODE_INVALID_CTX_ID          0x66UL
+#define HWRM_STAT_COMMON_CMD_ERR_CODE_INVALID_PAYLOAD         0x67UL
+#define HWRM_STAT_COMMON_CMD_ERR_CODE_CTX_STAT_RETRIEVAL_FAIL 0x68UL
+#define HWRM_STAT_COMMON_CMD_ERR_CODE_RES_NOT_ALLOCATED       0x69UL
+#define HWRM_STAT_COMMON_CMD_ERR_CODE_LAST                   HWRM_STAT_COMMON_CMD_ERR_CODE_RES_NOT_ALLOCATED
+
+/* ctx_hw_stats_ext (size:1408b/176B) */
+struct ctx_hw_stats_ext {
+	__le64	rx_ucast_pkts;
+	__le64	rx_mcast_pkts;
+	__le64	rx_bcast_pkts;
+	__le64	rx_discard_pkts;
+	__le64	rx_error_pkts;
+	__le64	rx_ucast_bytes;
+	__le64	rx_mcast_bytes;
+	__le64	rx_bcast_bytes;
+	__le64	tx_ucast_pkts;
+	__le64	tx_mcast_pkts;
+	__le64	tx_bcast_pkts;
+	__le64	tx_error_pkts;
+	__le64	tx_discard_pkts;
+	__le64	tx_ucast_bytes;
+	__le64	tx_mcast_bytes;
+	__le64	tx_bcast_bytes;
+	__le64	rx_tpa_eligible_pkt;
+	__le64	rx_tpa_eligible_bytes;
+	__le64	rx_tpa_pkt;
+	__le64	rx_tpa_bytes;
+	__le64	rx_tpa_errors;
+	__le64	rx_tpa_events;
+};
+
+/* ctx_eng_stats (size:512b/64B) */
+struct ctx_eng_stats {
+	__le64	eng_bytes_in;
+	__le64	eng_bytes_out;
+	__le64	aux_bytes_in;
+	__le64	aux_bytes_out;
+	__le64	commands;
+	__le64	error_commands;
+	__le64	cce_engine_usage;
+	__le64	cdd_engine_usage;
+};
+
+/* hwrm_stat_ctx_alloc_input (size:384b/48B) */
+struct hwrm_stat_ctx_alloc_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le64	stats_dma_addr;
+	__le32	update_period_ms;
+	u8	stat_ctx_flags;
+	#define STAT_CTX_ALLOC_REQ_STAT_CTX_FLAGS_ROCE             0x1UL
+	#define STAT_CTX_ALLOC_REQ_STAT_CTX_FLAGS_DUP_HOST_BUF     0x2UL
+	u8	unused_0;
+	__le16	stats_dma_length;
+	__le16	flags;
+	#define STAT_CTX_ALLOC_REQ_FLAGS_STEERING_TAG_VALID     0x1UL
+	__le16	steering_tag;
+	__le32	stat_ctx_id;
+	__le16	alloc_seq_id;
+	u8	unused_1[6];
+};
+
+/* hwrm_stat_ctx_alloc_output (size:128b/16B) */
+struct hwrm_stat_ctx_alloc_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le32	stat_ctx_id;
+	u8	unused_0[3];
+	u8	valid;
+};
+
+/* hwrm_stat_ctx_alloc_cmd_err (size:64b/8B) */
+struct hwrm_stat_ctx_alloc_cmd_err {
+	u8	code;
+	#define STAT_CTX_ALLOC_CMD_ERR_CODE_UNKNOWN            0x0UL
+	#define STAT_CTX_ALLOC_CMD_ERR_CODE_INVALID_FID        0x1UL
+	#define STAT_CTX_ALLOC_CMD_ERR_CODE_INVALID_FLAG       0x2UL
+	#define STAT_CTX_ALLOC_CMD_ERR_CODE_INVALID_DMA_ADDR   0x3UL
+	#define STAT_CTX_ALLOC_CMD_ERR_CODE_RES_NOT_AVAIL      0x4UL
+	#define STAT_CTX_ALLOC_CMD_ERR_CODE_RES_POOL_EXHAUSTED 0x5UL
+	#define STAT_CTX_ALLOC_CMD_ERR_CODE_CTX_ALLOC_FAIL     0x6UL
+	#define STAT_CTX_ALLOC_CMD_ERR_CODE_LAST              STAT_CTX_ALLOC_CMD_ERR_CODE_CTX_ALLOC_FAIL
+	u8	unused_0[7];
+};
+
+/* hwrm_stat_ctx_free_input (size:192b/24B) */
+struct hwrm_stat_ctx_free_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	stat_ctx_id;
+	u8	unused_0[4];
+};
+
+/* hwrm_stat_ctx_free_output (size:128b/16B) */
+struct hwrm_stat_ctx_free_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le32	stat_ctx_id;
+	u8	unused_0[3];
+	u8	valid;
+};
+
+/* hwrm_stat_ctx_free_cmd_err (size:64b/8B) */
+struct hwrm_stat_ctx_free_cmd_err {
+	u8	code;
+	#define STAT_CTX_FREE_CMD_ERR_CODE_UNKNOWN          0x0UL
+	#define STAT_CTX_FREE_CMD_ERR_CODE_INVALID_CTX_ID   0x1UL
+	#define STAT_CTX_FREE_CMD_ERR_CODE_RES_DEALLOC_FAIL 0x2UL
+	#define STAT_CTX_FREE_CMD_ERR_CODE_CTX_FREE_FAIL    0x3UL
+	#define STAT_CTX_FREE_CMD_ERR_CODE_LAST            STAT_CTX_FREE_CMD_ERR_CODE_CTX_FREE_FAIL
+	u8	unused_0[7];
+};
+
+/* hwrm_stat_ctx_query_input (size:192b/24B) */
+struct hwrm_stat_ctx_query_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	stat_ctx_id;
+	u8	flags;
+	#define STAT_CTX_QUERY_REQ_FLAGS_COUNTER_MASK     0x1UL
+	u8	unused_0[3];
+};
+
+/* hwrm_stat_ctx_query_output (size:1408b/176B) */
+struct hwrm_stat_ctx_query_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le64	tx_ucast_pkts;
+	__le64	tx_mcast_pkts;
+	__le64	tx_bcast_pkts;
+	__le64	tx_discard_pkts;
+	__le64	tx_error_pkts;
+	__le64	tx_ucast_bytes;
+	__le64	tx_mcast_bytes;
+	__le64	tx_bcast_bytes;
+	__le64	rx_ucast_pkts;
+	__le64	rx_mcast_pkts;
+	__le64	rx_bcast_pkts;
+	__le64	rx_discard_pkts;
+	__le64	rx_error_pkts;
+	__le64	rx_ucast_bytes;
+	__le64	rx_mcast_bytes;
+	__le64	rx_bcast_bytes;
+	__le64	rx_agg_pkts;
+	__le64	rx_agg_bytes;
+	__le64	rx_agg_events;
+	__le64	rx_agg_aborts;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_stat_ext_ctx_query_input (size:192b/24B) */
+struct hwrm_stat_ext_ctx_query_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	stat_ctx_id;
+	u8	flags;
+	#define STAT_EXT_CTX_QUERY_REQ_FLAGS_COUNTER_MASK     0x1UL
+	u8	unused_0[3];
+};
+
+/* hwrm_stat_ext_ctx_query_output (size:1536b/192B) */
+struct hwrm_stat_ext_ctx_query_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le64	rx_ucast_pkts;
+	__le64	rx_mcast_pkts;
+	__le64	rx_bcast_pkts;
+	__le64	rx_discard_pkts;
+	__le64	rx_error_pkts;
+	__le64	rx_ucast_bytes;
+	__le64	rx_mcast_bytes;
+	__le64	rx_bcast_bytes;
+	__le64	tx_ucast_pkts;
+	__le64	tx_mcast_pkts;
+	__le64	tx_bcast_pkts;
+	__le64	tx_error_pkts;
+	__le64	tx_discard_pkts;
+	__le64	tx_ucast_bytes;
+	__le64	tx_mcast_bytes;
+	__le64	tx_bcast_bytes;
+	__le64	rx_tpa_eligible_pkt;
+	__le64	rx_tpa_eligible_bytes;
+	__le64	rx_tpa_pkt;
+	__le64	rx_tpa_bytes;
+	__le64	rx_tpa_errors;
+	__le64	rx_tpa_events;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_stat_ctx_eng_query_input (size:192b/24B) */
+struct hwrm_stat_ctx_eng_query_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	stat_ctx_id;
+	u8	unused_0[4];
+};
+
+/* hwrm_stat_ctx_eng_query_output (size:640b/80B) */
+struct hwrm_stat_ctx_eng_query_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le64	eng_bytes_in;
+	__le64	eng_bytes_out;
+	__le64	aux_bytes_in;
+	__le64	aux_bytes_out;
+	__le64	commands;
+	__le64	error_commands;
+	__le64	cce_engine_usage;
+	__le64	cdd_engine_usage;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_stat_ctx_clr_stats_input (size:192b/24B) */
+struct hwrm_stat_ctx_clr_stats_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	stat_ctx_id;
+	u8	unused_0[4];
+};
+
+/* hwrm_stat_ctx_clr_stats_output (size:128b/16B) */
+struct hwrm_stat_ctx_clr_stats_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_pcie_qstats_input (size:256b/32B) */
+struct hwrm_pcie_qstats_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	pcie_stat_size;
+	u8	unused_0[6];
+	__le64	pcie_stat_host_addr;
+};
+
+/* hwrm_pcie_qstats_output (size:128b/16B) */
+struct hwrm_pcie_qstats_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	pcie_stat_size;
+	u8	unused_0[5];
+	u8	valid;
+};
+
+/* hwrm_pcie_qstats_cmd_err (size:64b/8B) */
+struct hwrm_pcie_qstats_cmd_err {
+	u8	code;
+	#define PCIE_QSTATS_CMD_ERR_CODE_UNKNOWN                0x0UL
+	#define PCIE_QSTATS_CMD_ERR_CODE_LEGACY_INVALID_PF_ID   0x1UL
+	#define PCIE_QSTATS_CMD_ERR_CODE_GENERIC_INVALID_EP_IDX 0x2UL
+	#define PCIE_QSTATS_CMD_ERR_CODE_GENERIC_MEM_ALLOC_FAIL 0x3UL
+	#define PCIE_QSTATS_CMD_ERR_CODE_LAST                  PCIE_QSTATS_CMD_ERR_CODE_GENERIC_MEM_ALLOC_FAIL
+	u8	unused_0[7];
+};
+
+/* pcie_ctx_hw_stats (size:768b/96B) */
+struct pcie_ctx_hw_stats {
+	__le64	pcie_pl_signal_integrity;
+	__le64	pcie_dl_signal_integrity;
+	__le64	pcie_tl_signal_integrity;
+	__le64	pcie_link_integrity;
+	__le64	pcie_tx_traffic_rate;
+	__le64	pcie_rx_traffic_rate;
+	__le64	pcie_tx_dllp_statistics;
+	__le64	pcie_rx_dllp_statistics;
+	__le64	pcie_equalization_time;
+	__le32	pcie_ltssm_histogram[4];
+	__le64	pcie_recovery_histogram;
+};
+
+/* pcie_ctx_hw_stats_v2 (size:4544b/568B) */
+struct pcie_ctx_hw_stats_v2 {
+	__le64	pcie_pl_signal_integrity;
+	__le64	pcie_dl_signal_integrity;
+	__le64	pcie_tl_signal_integrity;
+	__le64	pcie_link_integrity;
+	__le64	pcie_tx_traffic_rate;
+	__le64	pcie_rx_traffic_rate;
+	__le64	pcie_tx_dllp_statistics;
+	__le64	pcie_rx_dllp_statistics;
+	__le64	pcie_equalization_time;
+	__le32	pcie_ltssm_histogram[4];
+	__le64	pcie_recovery_histogram;
+	__le32	pcie_tl_credit_nph_histogram[8];
+	__le32	pcie_tl_credit_ph_histogram[8];
+	__le32	pcie_tl_credit_pd_histogram[8];
+	__le32	pcie_cmpl_latest_times[4];
+	__le32	pcie_cmpl_longest_time;
+	__le32	pcie_cmpl_shortest_time;
+	__le32	unused_0[2];
+	__le32	pcie_cmpl_latest_headers[4][4];
+	__le32	pcie_cmpl_longest_headers[4][4];
+	__le32	pcie_cmpl_shortest_headers[4][4];
+	__le32	pcie_wr_latency_histogram[12];
+	__le32	pcie_wr_latency_all_normal_count;
+	__le32	unused_1;
+	__le64	pcie_posted_packet_count;
+	__le64	pcie_non_posted_packet_count;
+	__le64	pcie_other_packet_count;
+	__le64	pcie_blocked_packet_count;
+	__le64	pcie_cmpl_packet_count;
+	__le32	pcie_rd_latency_histogram[12];
+	__le32	pcie_rd_latency_all_normal_count;
+	__le32	unused_2;
+};
+
+/* hwrm_stat_generic_qstats_input (size:256b/32B) */
+struct hwrm_stat_generic_qstats_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	generic_stat_size;
+	u8	flags;
+	#define STAT_GENERIC_QSTATS_REQ_FLAGS_COUNTER_MASK     0x1UL
+	u8	unused_0[5];
+	__le64	generic_stat_host_addr;
+};
+
+/* hwrm_stat_generic_qstats_output (size:128b/16B) */
+struct hwrm_stat_generic_qstats_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	generic_stat_size;
+	u8	unused_0[5];
+	u8	valid;
+};
+
+/* hwrm_stat_generic_qstats_cmd_err (size:64b/8B) */
+struct hwrm_stat_generic_qstats_cmd_err {
+	u8	code;
+	#define STAT_GENERIC_QSTATS_CMD_ERR_CODE_UNKNOWN           0x0UL
+	#define STAT_GENERIC_QSTATS_CMD_ERR_CODE_INVALID_EP_ID     0x1UL
+	#define STAT_GENERIC_QSTATS_CMD_ERR_CODE_INVALID_STAT_SIZE 0x2UL
+	#define STAT_GENERIC_QSTATS_CMD_ERR_CODE_INVALID_DMA_ADDR  0x3UL
+	#define STAT_GENERIC_QSTATS_CMD_ERR_CODE_HOST_NOT_ACTIVE   0x4UL
+	#define STAT_GENERIC_QSTATS_CMD_ERR_CODE_MEM_ALLOC_FAIL    0x5UL
+	#define STAT_GENERIC_QSTATS_CMD_ERR_CODE_LAST             STAT_GENERIC_QSTATS_CMD_ERR_CODE_MEM_ALLOC_FAIL
+	u8	unused_0[7];
+};
+
+/* generic_sw_hw_stats (size:1472b/184B) */
+struct generic_sw_hw_stats {
+	__le64	pcie_statistics_tx_tlp;
+	__le64	pcie_statistics_rx_tlp;
+	__le64	pcie_credit_fc_hdr_posted;
+	__le64	pcie_credit_fc_hdr_nonposted;
+	__le64	pcie_credit_fc_hdr_cmpl;
+	__le64	pcie_credit_fc_data_posted;
+	__le64	pcie_credit_fc_data_nonposted;
+	__le64	pcie_credit_fc_data_cmpl;
+	__le64	pcie_credit_fc_tgt_nonposted;
+	__le64	pcie_credit_fc_tgt_data_posted;
+	__le64	pcie_credit_fc_tgt_hdr_posted;
+	__le64	pcie_credit_fc_cmpl_hdr_posted;
+	__le64	pcie_credit_fc_cmpl_data_posted;
+	__le64	pcie_cmpl_longest;
+	__le64	pcie_cmpl_shortest;
+	__le64	cache_miss_count_cfcq;
+	__le64	cache_miss_count_cfcs;
+	__le64	cache_miss_count_cfcc;
+	__le64	cache_miss_count_cfcm;
+	__le64	hw_db_recov_dbs_dropped;
+	__le64	hw_db_recov_drops_serviced;
+	__le64	hw_db_recov_dbs_recovered;
+	__le64	hw_db_recov_oo_drop_count;
+};
+
+/* hwrm_stat_db_error_qstats_input (size:128b/16B) */
+struct hwrm_stat_db_error_qstats_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+};
+
+/* hwrm_stat_db_error_qstats_output (size:320b/40B) */
+struct hwrm_stat_db_error_qstats_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le32	tx_db_drop_invalid_qp_state;
+	__le32	rx_db_drop_invalid_rq_state;
+	__le32	tx_db_drop_format_error;
+	__le32	express_db_dropped_misc_error;
+	__le32	express_db_dropped_sq_overflow;
+	__le32	express_db_dropped_rq_overflow;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_stat_query_roce_stats_input (size:256b/32B) */
+struct hwrm_stat_query_roce_stats_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	roce_stat_size;
+	u8	unused_0[6];
+	__le64	roce_stat_host_addr;
+};
+
+/* hwrm_stat_query_roce_stats_output (size:128b/16B) */
+struct hwrm_stat_query_roce_stats_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	roce_stat_size;
+	u8	unused_0[5];
+	u8	valid;
+};
+
+/* stat_query_roce_stats_data (size:2944b/368B) */
+struct stat_query_roce_stats_data {
+	__le64	to_retransmits;
+	__le64	seq_err_naks_rcvd;
+	__le64	max_retry_exceeded;
+	__le64	rnr_naks_rcvd;
+	__le64	missing_resp;
+	__le64	unrecoverable_err;
+	__le64	bad_resp_err;
+	__le64	local_qp_op_err;
+	__le64	local_protection_err;
+	__le64	mem_mgmt_op_err;
+	__le64	remote_invalid_req_err;
+	__le64	remote_access_err;
+	__le64	remote_op_err;
+	__le64	dup_req;
+	__le64	res_exceed_max;
+	__le64	res_length_mismatch;
+	__le64	res_exceeds_wqe;
+	__le64	res_opcode_err;
+	__le64	res_rx_invalid_rkey;
+	__le64	res_rx_domain_err;
+	__le64	res_rx_no_perm;
+	__le64	res_rx_range_err;
+	__le64	res_tx_invalid_rkey;
+	__le64	res_tx_domain_err;
+	__le64	res_tx_no_perm;
+	__le64	res_tx_range_err;
+	__le64	res_irrq_oflow;
+	__le64	res_unsup_opcode;
+	__le64	res_unaligned_atomic;
+	__le64	res_rem_inv_err;
+	__le64	res_mem_error;
+	__le64	res_srq_err;
+	__le64	res_cmp_err;
+	__le64	res_invalid_dup_rkey;
+	__le64	res_wqe_format_err;
+	__le64	res_cq_load_err;
+	__le64	res_srq_load_err;
+	__le64	res_tx_pci_err;
+	__le64	res_rx_pci_err;
+	__le64	res_oos_drop_count;
+	__le64	active_qp_count_p0;
+	__le64	active_qp_count_p1;
+	__le64	active_qp_count_p2;
+	__le64	active_qp_count_p3;
+	__le64	xp_sq_overflow_err;
+	__le64	xp_rq_overflow_error;
+};
+
+/* hwrm_stat_query_roce_stats_ext_input (size:256b/32B) */
+struct hwrm_stat_query_roce_stats_ext_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	roce_stat_size;
+	u8	unused_0[6];
+	__le64	roce_stat_host_addr;
+};
+
+/* hwrm_stat_query_roce_stats_ext_output (size:128b/16B) */
+struct hwrm_stat_query_roce_stats_ext_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	roce_stat_size;
+	u8	unused_0[5];
+	u8	valid;
+};
+
+/* stat_query_roce_stats_ext_data (size:2240b/280B) */
+struct stat_query_roce_stats_ext_data {
+	__le64	tx_atomic_req_pkts;
+	__le64	tx_read_req_pkts;
+	__le64	tx_read_res_pkts;
+	__le64	tx_write_req_pkts;
+	__le64	tx_send_req_pkts;
+	__le64	tx_roce_pkts;
+	__le64	tx_roce_bytes;
+	__le64	rx_atomic_req_pkts;
+	__le64	rx_read_req_pkts;
+	__le64	rx_read_res_pkts;
+	__le64	rx_write_req_pkts;
+	__le64	rx_send_req_pkts;
+	__le64	rx_roce_pkts;
+	__le64	rx_roce_bytes;
+	__le64	rx_roce_good_pkts;
+	__le64	rx_roce_good_bytes;
+	__le64	rx_out_of_buffer_pkts;
+	__le64	rx_out_of_sequence_pkts;
+	__le64	tx_cnp_pkts;
+	__le64	rx_cnp_pkts;
+	__le64	rx_ecn_marked_pkts;
+	__le64	tx_cnp_bytes;
+	__le64	rx_cnp_bytes;
+	__le64	seq_err_naks_rcvd;
+	__le64	rnr_naks_rcvd;
+	__le64	missing_resp;
+	__le64	to_retransmit;
+	__le64	dup_req;
+	__le64	rx_dcn_payload_cut;
+	__le64	te_bypassed;
+	__le64	tx_dcn_cnp;
+	__le64	rx_dcn_cnp;
+	__le64	rx_payload_cut;
+	__le64	rx_payload_cut_ignored;
+	__le64	rx_dcn_cnp_ignored;
+};
+
+/* hwrm_fw_reset_input (size:192b/24B) */
+struct hwrm_fw_reset_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	u8	embedded_proc_type;
+	#define FW_RESET_REQ_EMBEDDED_PROC_TYPE_BOOT                  0x0UL
+	#define FW_RESET_REQ_EMBEDDED_PROC_TYPE_MGMT                  0x1UL
+	#define FW_RESET_REQ_EMBEDDED_PROC_TYPE_NETCTRL               0x2UL
+	#define FW_RESET_REQ_EMBEDDED_PROC_TYPE_ROCE                  0x3UL
+	#define FW_RESET_REQ_EMBEDDED_PROC_TYPE_HOST                  0x4UL
+	#define FW_RESET_REQ_EMBEDDED_PROC_TYPE_AP                    0x5UL
+	#define FW_RESET_REQ_EMBEDDED_PROC_TYPE_CHIP                  0x6UL
+	#define FW_RESET_REQ_EMBEDDED_PROC_TYPE_HOST_RESOURCE_REINIT  0x7UL
+	#define FW_RESET_REQ_EMBEDDED_PROC_TYPE_IMPACTLESS_ACTIVATION 0x8UL
+	#define FW_RESET_REQ_EMBEDDED_PROC_TYPE_LAST                 FW_RESET_REQ_EMBEDDED_PROC_TYPE_IMPACTLESS_ACTIVATION
+	u8	selfrst_status;
+	#define FW_RESET_REQ_SELFRST_STATUS_SELFRSTNONE      0x0UL
+	#define FW_RESET_REQ_SELFRST_STATUS_SELFRSTASAP      0x1UL
+	#define FW_RESET_REQ_SELFRST_STATUS_SELFRSTPCIERST   0x2UL
+	#define FW_RESET_REQ_SELFRST_STATUS_SELFRSTIMMEDIATE 0x3UL
+	#define FW_RESET_REQ_SELFRST_STATUS_LAST            FW_RESET_REQ_SELFRST_STATUS_SELFRSTIMMEDIATE
+	u8	host_idx;
+	u8	flags;
+	#define FW_RESET_REQ_FLAGS_RESET_GRACEFUL     0x1UL
+	#define FW_RESET_REQ_FLAGS_FW_ACTIVATION      0x2UL
+	u8	unused_0[4];
+};
+
+/* hwrm_fw_reset_output (size:128b/16B) */
+struct hwrm_fw_reset_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	selfrst_status;
+	#define FW_RESET_RESP_SELFRST_STATUS_SELFRSTNONE      0x0UL
+	#define FW_RESET_RESP_SELFRST_STATUS_SELFRSTASAP      0x1UL
+	#define FW_RESET_RESP_SELFRST_STATUS_SELFRSTPCIERST   0x2UL
+	#define FW_RESET_RESP_SELFRST_STATUS_SELFRSTIMMEDIATE 0x3UL
+	#define FW_RESET_RESP_SELFRST_STATUS_LAST            FW_RESET_RESP_SELFRST_STATUS_SELFRSTIMMEDIATE
+	u8	unused_0[6];
+	u8	valid;
+};
+
+/* hwrm_fw_qstatus_input (size:192b/24B) */
+struct hwrm_fw_qstatus_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	u8	embedded_proc_type;
+	#define FW_QSTATUS_REQ_EMBEDDED_PROC_TYPE_BOOT    0x0UL
+	#define FW_QSTATUS_REQ_EMBEDDED_PROC_TYPE_MGMT    0x1UL
+	#define FW_QSTATUS_REQ_EMBEDDED_PROC_TYPE_NETCTRL 0x2UL
+	#define FW_QSTATUS_REQ_EMBEDDED_PROC_TYPE_ROCE    0x3UL
+	#define FW_QSTATUS_REQ_EMBEDDED_PROC_TYPE_HOST    0x4UL
+	#define FW_QSTATUS_REQ_EMBEDDED_PROC_TYPE_AP      0x5UL
+	#define FW_QSTATUS_REQ_EMBEDDED_PROC_TYPE_CHIP    0x6UL
+	#define FW_QSTATUS_REQ_EMBEDDED_PROC_TYPE_LAST   FW_QSTATUS_REQ_EMBEDDED_PROC_TYPE_CHIP
+	u8	unused_0[7];
+};
+
+/* hwrm_fw_qstatus_output (size:128b/16B) */
+struct hwrm_fw_qstatus_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	selfrst_status;
+	#define FW_QSTATUS_RESP_SELFRST_STATUS_SELFRSTNONE    0x0UL
+	#define FW_QSTATUS_RESP_SELFRST_STATUS_SELFRSTASAP    0x1UL
+	#define FW_QSTATUS_RESP_SELFRST_STATUS_SELFRSTPCIERST 0x2UL
+	#define FW_QSTATUS_RESP_SELFRST_STATUS_SELFRSTPOWER   0x3UL
+	#define FW_QSTATUS_RESP_SELFRST_STATUS_LAST          FW_QSTATUS_RESP_SELFRST_STATUS_SELFRSTPOWER
+	u8	nvm_option_action_status;
+	#define FW_QSTATUS_RESP_NVM_OPTION_ACTION_STATUS_NVMOPT_ACTION_NONE     0x0UL
+	#define FW_QSTATUS_RESP_NVM_OPTION_ACTION_STATUS_NVMOPT_ACTION_HOTRESET 0x1UL
+	#define FW_QSTATUS_RESP_NVM_OPTION_ACTION_STATUS_NVMOPT_ACTION_WARMBOOT 0x2UL
+	#define FW_QSTATUS_RESP_NVM_OPTION_ACTION_STATUS_NVMOPT_ACTION_COLDBOOT 0x3UL
+	#define FW_QSTATUS_RESP_NVM_OPTION_ACTION_STATUS_LAST                  FW_QSTATUS_RESP_NVM_OPTION_ACTION_STATUS_NVMOPT_ACTION_COLDBOOT
+	u8	unused_0[5];
+	u8	valid;
+};
+
+/* hwrm_fw_set_time_input (size:256b/32B) */
+struct hwrm_fw_set_time_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	year;
+	#define FW_SET_TIME_REQ_YEAR_UNKNOWN 0x0UL
+	#define FW_SET_TIME_REQ_YEAR_LAST   FW_SET_TIME_REQ_YEAR_UNKNOWN
+	u8	month;
+	u8	day;
+	u8	hour;
+	u8	minute;
+	u8	second;
+	u8	unused_0;
+	__le16	millisecond;
+	__le16	zone;
+	#define FW_SET_TIME_REQ_ZONE_UTC     0
+	#define FW_SET_TIME_REQ_ZONE_UNKNOWN 65535
+	#define FW_SET_TIME_REQ_ZONE_LAST   FW_SET_TIME_REQ_ZONE_UNKNOWN
+	u8	unused_1[4];
+};
+
+/* hwrm_fw_set_time_output (size:128b/16B) */
+struct hwrm_fw_set_time_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_fw_get_time_input (size:128b/16B) */
+struct hwrm_fw_get_time_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+};
+
+/* hwrm_fw_get_time_output (size:192b/24B) */
+struct hwrm_fw_get_time_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	year;
+	#define FW_GET_TIME_RESP_YEAR_UNKNOWN 0x0UL
+	#define FW_GET_TIME_RESP_YEAR_LAST   FW_GET_TIME_RESP_YEAR_UNKNOWN
+	u8	month;
+	u8	day;
+	u8	hour;
+	u8	minute;
+	u8	second;
+	u8	unused_0;
+	__le16	millisecond;
+	__le16	zone;
+	#define FW_GET_TIME_RESP_ZONE_UTC     0
+	#define FW_GET_TIME_RESP_ZONE_UNKNOWN 65535
+	#define FW_GET_TIME_RESP_ZONE_LAST   FW_GET_TIME_RESP_ZONE_UNKNOWN
+	u8	unused_1[3];
+	u8	valid;
+};
+
+/* hwrm_struct_hdr (size:128b/16B) */
+struct hwrm_struct_hdr {
+	__le16	struct_id;
+	#define STRUCT_HDR_STRUCT_ID_LLDP_CFG              0x41bUL
+	#define STRUCT_HDR_STRUCT_ID_DCBX_ETS              0x41dUL
+	#define STRUCT_HDR_STRUCT_ID_DCBX_PFC              0x41fUL
+	#define STRUCT_HDR_STRUCT_ID_DCBX_APP              0x421UL
+	#define STRUCT_HDR_STRUCT_ID_DCBX_FEATURE_STATE    0x422UL
+	#define STRUCT_HDR_STRUCT_ID_LLDP_GENERIC          0x424UL
+	#define STRUCT_HDR_STRUCT_ID_LLDP_DEVICE           0x426UL
+	#define STRUCT_HDR_STRUCT_ID_POWER_BKUP            0x427UL
+	#define STRUCT_HDR_STRUCT_ID_PEER_MMAP             0x429UL
+	#define STRUCT_HDR_STRUCT_ID_AFM_OPAQUE            0x1UL
+	#define STRUCT_HDR_STRUCT_ID_PORT_DESCRIPTION      0xaUL
+	#define STRUCT_HDR_STRUCT_ID_RSS_V2                0x64UL
+	#define STRUCT_HDR_STRUCT_ID_MSIX_PER_VF           0xc8UL
+	#define STRUCT_HDR_STRUCT_ID_UDCC_RTT_BUCKET_COUNT 0x12cUL
+	#define STRUCT_HDR_STRUCT_ID_UDCC_RTT_BUCKET_BOUND 0x12dUL
+	#define STRUCT_HDR_STRUCT_ID_DBG_TOKEN_CLAIMS      0x190UL
+	#define STRUCT_HDR_STRUCT_ID_LAST                 STRUCT_HDR_STRUCT_ID_DBG_TOKEN_CLAIMS
+	__le16	len;
+	u8	version;
+	#define STRUCT_HDR_VERSION_0 0x0UL
+	#define STRUCT_HDR_VERSION_1 0x1UL
+	#define STRUCT_HDR_VERSION_LAST STRUCT_HDR_VERSION_1
+	u8	count;
+	__le16	subtype;
+	__le16	next_offset;
+	#define STRUCT_HDR_NEXT_OFFSET_LAST 0x0UL
+	u8	unused_0[6];
+};
+
+/* hwrm_struct_data_dcbx_ets (size:256b/32B) */
+struct hwrm_struct_data_dcbx_ets {
+	u8	destination;
+	#define STRUCT_DATA_DCBX_ETS_DESTINATION_CONFIGURATION   0x1UL
+	#define STRUCT_DATA_DCBX_ETS_DESTINATION_RECOMMMENDATION 0x2UL
+	#define STRUCT_DATA_DCBX_ETS_DESTINATION_LAST           STRUCT_DATA_DCBX_ETS_DESTINATION_RECOMMMENDATION
+	u8	max_tcs;
+	__le16	unused1;
+	u8	pri0_to_tc_map;
+	u8	pri1_to_tc_map;
+	u8	pri2_to_tc_map;
+	u8	pri3_to_tc_map;
+	u8	pri4_to_tc_map;
+	u8	pri5_to_tc_map;
+	u8	pri6_to_tc_map;
+	u8	pri7_to_tc_map;
+	u8	tc0_to_bw_map;
+	u8	tc1_to_bw_map;
+	u8	tc2_to_bw_map;
+	u8	tc3_to_bw_map;
+	u8	tc4_to_bw_map;
+	u8	tc5_to_bw_map;
+	u8	tc6_to_bw_map;
+	u8	tc7_to_bw_map;
+	u8	tc0_to_tsa_map;
+	#define STRUCT_DATA_DCBX_ETS_TC0_TO_TSA_MAP_TSA_TYPE_SP              0x0UL
+	#define STRUCT_DATA_DCBX_ETS_TC0_TO_TSA_MAP_TSA_TYPE_CBS             0x1UL
+	#define STRUCT_DATA_DCBX_ETS_TC0_TO_TSA_MAP_TSA_TYPE_ETS             0x2UL
+	#define STRUCT_DATA_DCBX_ETS_TC0_TO_TSA_MAP_TSA_TYPE_VENDOR_SPECIFIC 0xffUL
+	#define STRUCT_DATA_DCBX_ETS_TC0_TO_TSA_MAP_LAST                    STRUCT_DATA_DCBX_ETS_TC0_TO_TSA_MAP_TSA_TYPE_VENDOR_SPECIFIC
+	u8	tc1_to_tsa_map;
+	u8	tc2_to_tsa_map;
+	u8	tc3_to_tsa_map;
+	u8	tc4_to_tsa_map;
+	u8	tc5_to_tsa_map;
+	u8	tc6_to_tsa_map;
+	u8	tc7_to_tsa_map;
+	u8	unused_0[4];
+};
+
+/* hwrm_struct_data_dcbx_pfc (size:64b/8B) */
+struct hwrm_struct_data_dcbx_pfc {
+	u8	pfc_priority_bitmap;
+	u8	max_pfc_tcs;
+	u8	mbc;
+	u8	unused_0[5];
+};
+
+/* hwrm_struct_data_dcbx_app (size:64b/8B) */
+struct hwrm_struct_data_dcbx_app {
+	__be16	protocol_id;
+	u8	protocol_selector;
+	#define STRUCT_DATA_DCBX_APP_PROTOCOL_SELECTOR_ETHER_TYPE   0x1UL
+	#define STRUCT_DATA_DCBX_APP_PROTOCOL_SELECTOR_TCP_PORT     0x2UL
+	#define STRUCT_DATA_DCBX_APP_PROTOCOL_SELECTOR_UDP_PORT     0x3UL
+	#define STRUCT_DATA_DCBX_APP_PROTOCOL_SELECTOR_TCP_UDP_PORT 0x4UL
+	#define STRUCT_DATA_DCBX_APP_PROTOCOL_SELECTOR_LAST        STRUCT_DATA_DCBX_APP_PROTOCOL_SELECTOR_TCP_UDP_PORT
+	u8	priority;
+	u8	valid;
+	u8	unused_0[3];
+};
+
+/* hwrm_struct_data_dcbx_feature_state (size:64b/8B) */
+struct hwrm_struct_data_dcbx_feature_state {
+	u8	dcbx_mode;
+	#define STRUCT_DATA_DCBX_FEATURE_STATE_DCBX_MODE_DCBX_DISABLED 0x0UL
+	#define STRUCT_DATA_DCBX_FEATURE_STATE_DCBX_MODE_DCBX_IEEE     0x1UL
+	#define STRUCT_DATA_DCBX_FEATURE_STATE_DCBX_MODE_DCBX_CEE      0x2UL
+	#define STRUCT_DATA_DCBX_FEATURE_STATE_DCBX_MODE_LAST         STRUCT_DATA_DCBX_FEATURE_STATE_DCBX_MODE_DCBX_CEE
+	u8	ets_state;
+	u8	pfc_state;
+	u8	app_state;
+	#define STRUCT_DATA_DCBX_FEATURE_STATE_APP_STATE_ENABLE_BIT_POS    0x7UL
+	#define STRUCT_DATA_DCBX_FEATURE_STATE_APP_STATE_WILLING_BIT_POS   0x6UL
+	#define STRUCT_DATA_DCBX_FEATURE_STATE_APP_STATE_ADVERTISE_BIT_POS 0x5UL
+	#define STRUCT_DATA_DCBX_FEATURE_STATE_APP_STATE_LAST             STRUCT_DATA_DCBX_FEATURE_STATE_APP_STATE_ADVERTISE_BIT_POS
+	u8	unused[3];
+	u8	resets;
+	#define STRUCT_DATA_DCBX_FEATURE_STATE_RESETS_RESET_ETS   0x1UL
+	#define STRUCT_DATA_DCBX_FEATURE_STATE_RESETS_RESET_PFC   0x2UL
+	#define STRUCT_DATA_DCBX_FEATURE_STATE_RESETS_RESET_APP   0x4UL
+	#define STRUCT_DATA_DCBX_FEATURE_STATE_RESETS_RESET_STATE 0x8UL
+	#define STRUCT_DATA_DCBX_FEATURE_STATE_RESETS_LAST       STRUCT_DATA_DCBX_FEATURE_STATE_RESETS_RESET_STATE
+};
+
+/* hwrm_struct_data_lldp (size:64b/8B) */
+struct hwrm_struct_data_lldp {
+	u8	admin_state;
+	#define STRUCT_DATA_LLDP_ADMIN_STATE_DISABLE 0x0UL
+	#define STRUCT_DATA_LLDP_ADMIN_STATE_TX      0x1UL
+	#define STRUCT_DATA_LLDP_ADMIN_STATE_RX      0x2UL
+	#define STRUCT_DATA_LLDP_ADMIN_STATE_ENABLE  0x3UL
+	#define STRUCT_DATA_LLDP_ADMIN_STATE_LAST   STRUCT_DATA_LLDP_ADMIN_STATE_ENABLE
+	u8	port_description_state;
+	#define STRUCT_DATA_LLDP_PORT_DESCRIPTION_STATE_DISABLE 0x0UL
+	#define STRUCT_DATA_LLDP_PORT_DESCRIPTION_STATE_ENABLE  0x1UL
+	#define STRUCT_DATA_LLDP_PORT_DESCRIPTION_STATE_LAST   STRUCT_DATA_LLDP_PORT_DESCRIPTION_STATE_ENABLE
+	u8	system_name_state;
+	#define STRUCT_DATA_LLDP_SYSTEM_NAME_STATE_DISABLE 0x0UL
+	#define STRUCT_DATA_LLDP_SYSTEM_NAME_STATE_ENABLE  0x1UL
+	#define STRUCT_DATA_LLDP_SYSTEM_NAME_STATE_LAST   STRUCT_DATA_LLDP_SYSTEM_NAME_STATE_ENABLE
+	u8	system_desc_state;
+	#define STRUCT_DATA_LLDP_SYSTEM_DESC_STATE_DISABLE 0x0UL
+	#define STRUCT_DATA_LLDP_SYSTEM_DESC_STATE_ENABLE  0x1UL
+	#define STRUCT_DATA_LLDP_SYSTEM_DESC_STATE_LAST   STRUCT_DATA_LLDP_SYSTEM_DESC_STATE_ENABLE
+	u8	system_cap_state;
+	#define STRUCT_DATA_LLDP_SYSTEM_CAP_STATE_DISABLE 0x0UL
+	#define STRUCT_DATA_LLDP_SYSTEM_CAP_STATE_ENABLE  0x1UL
+	#define STRUCT_DATA_LLDP_SYSTEM_CAP_STATE_LAST   STRUCT_DATA_LLDP_SYSTEM_CAP_STATE_ENABLE
+	u8	mgmt_addr_state;
+	#define STRUCT_DATA_LLDP_MGMT_ADDR_STATE_DISABLE 0x0UL
+	#define STRUCT_DATA_LLDP_MGMT_ADDR_STATE_ENABLE  0x1UL
+	#define STRUCT_DATA_LLDP_MGMT_ADDR_STATE_LAST   STRUCT_DATA_LLDP_MGMT_ADDR_STATE_ENABLE
+	u8	async_event_notification_state;
+	#define STRUCT_DATA_LLDP_ASYNC_EVENT_NOTIFICATION_STATE_DISABLE 0x0UL
+	#define STRUCT_DATA_LLDP_ASYNC_EVENT_NOTIFICATION_STATE_ENABLE  0x1UL
+	#define STRUCT_DATA_LLDP_ASYNC_EVENT_NOTIFICATION_STATE_LAST   STRUCT_DATA_LLDP_ASYNC_EVENT_NOTIFICATION_STATE_ENABLE
+	u8	unused_0;
+};
+
+/* hwrm_struct_data_lldp_generic (size:2112b/264B) */
+struct hwrm_struct_data_lldp_generic {
+	u8	tlv_type;
+	#define STRUCT_DATA_LLDP_GENERIC_TLV_TYPE_CHASSIS            0x1UL
+	#define STRUCT_DATA_LLDP_GENERIC_TLV_TYPE_PORT               0x2UL
+	#define STRUCT_DATA_LLDP_GENERIC_TLV_TYPE_SYSTEM_NAME        0x3UL
+	#define STRUCT_DATA_LLDP_GENERIC_TLV_TYPE_SYSTEM_DESCRIPTION 0x4UL
+	#define STRUCT_DATA_LLDP_GENERIC_TLV_TYPE_PORT_NAME          0x5UL
+	#define STRUCT_DATA_LLDP_GENERIC_TLV_TYPE_PORT_DESCRIPTION   0x6UL
+	#define STRUCT_DATA_LLDP_GENERIC_TLV_TYPE_LAST              STRUCT_DATA_LLDP_GENERIC_TLV_TYPE_PORT_DESCRIPTION
+	u8	subtype;
+	u8	length;
+	u8	unused1[5];
+	__le32	tlv_value[64];
+};
+
+/* hwrm_struct_data_lldp_device (size:1472b/184B) */
+struct hwrm_struct_data_lldp_device {
+	__le16	ttl;
+	u8	mgmt_addr_len;
+	u8	mgmt_addr_type;
+	u8	unused_3[4];
+	__le32	mgmt_addr[8];
+	__le32	system_caps;
+	u8	intf_num_type;
+	u8	mgmt_addr_oid_length;
+	u8	unused_4[2];
+	__le32	intf_num;
+	u8	unused_5[4];
+	__le32	mgmt_addr_oid[32];
+};
+
+/* hwrm_struct_data_port_description (size:64b/8B) */
+struct hwrm_struct_data_port_description {
+	u8	port_id;
+	u8	unused_0[7];
+};
+
+/* hwrm_struct_data_rss_v2 (size:128b/16B) */
+struct hwrm_struct_data_rss_v2 {
+	__le16	flags;
+	#define STRUCT_DATA_RSS_V2_FLAGS_HASH_VALID     0x1UL
+	__le16	rss_ctx_id;
+	__le16	num_ring_groups;
+	__le16	hash_type;
+	#define STRUCT_DATA_RSS_V2_HASH_TYPE_IPV4         0x1UL
+	#define STRUCT_DATA_RSS_V2_HASH_TYPE_TCP_IPV4     0x2UL
+	#define STRUCT_DATA_RSS_V2_HASH_TYPE_UDP_IPV4     0x4UL
+	#define STRUCT_DATA_RSS_V2_HASH_TYPE_IPV6         0x8UL
+	#define STRUCT_DATA_RSS_V2_HASH_TYPE_TCP_IPV6     0x10UL
+	#define STRUCT_DATA_RSS_V2_HASH_TYPE_UDP_IPV6     0x20UL
+	__le64	hash_key_ring_group_ids;
+};
+
+/* hwrm_struct_data_power_information (size:192b/24B) */
+struct hwrm_struct_data_power_information {
+	__le32	bkup_power_info_ver;
+	__le32	platform_bkup_power_count;
+	__le32	load_milli_watt;
+	__le32	bkup_time_milli_seconds;
+	__le32	bkup_power_status;
+	__le32	bkup_power_charge_time;
+};
+
+/* hwrm_struct_data_peer_mmap (size:1600b/200B) */
+struct hwrm_struct_data_peer_mmap {
+	__le16	fid;
+	__le16	count;
+	__le32	unused_0;
+	__le64	hpa_0;
+	__le64	gpa_0;
+	__le64	size_0;
+	__le64	hpa_1;
+	__le64	gpa_1;
+	__le64	size_1;
+	__le64	hpa_2;
+	__le64	gpa_2;
+	__le64	size_2;
+	__le64	hpa_3;
+	__le64	gpa_3;
+	__le64	size_3;
+	__le64	hpa_4;
+	__le64	gpa_4;
+	__le64	size_4;
+	__le64	hpa_5;
+	__le64	gpa_5;
+	__le64	size_5;
+	__le64	hpa_6;
+	__le64	gpa_6;
+	__le64	size_6;
+	__le64	hpa_7;
+	__le64	gpa_7;
+	__le64	size_7;
+};
+
+/* hwrm_struct_data_peer_mmap_v2 (size:1792b/224B) */
+struct hwrm_struct_data_peer_mmap_v2 {
+	__le16	fid;
+	__le16	count;
+	__le32	unused_0;
+	__le64	hpa_0;
+	__le64	gpa_0;
+	__le64	size_0;
+	__le64	hpa_1;
+	__le64	gpa_1;
+	__le64	size_1;
+	__le64	hpa_2;
+	__le64	gpa_2;
+	__le64	size_2;
+	__le64	hpa_3;
+	__le64	gpa_3;
+	__le64	size_3;
+	__le64	hpa_4;
+	__le64	gpa_4;
+	__le64	size_4;
+	__le64	hpa_5;
+	__le64	gpa_5;
+	__le64	size_5;
+	__le64	hpa_6;
+	__le64	gpa_6;
+	__le64	size_6;
+	__le64	hpa_7;
+	__le64	gpa_7;
+	__le64	size_7;
+	__le16	ds_port;
+	__le16	auth_status;
+	#define STRUCT_DATA_PEER_MMAP_V2_AUTH_STATUS_SUCCESS       0x0UL
+	#define STRUCT_DATA_PEER_MMAP_V2_AUTH_STATUS_NONCE_MIS     0xdUL
+	#define STRUCT_DATA_PEER_MMAP_V2_AUTH_STATUS_SIG_INVALID   0xeUL
+	#define STRUCT_DATA_PEER_MMAP_V2_AUTH_STATUS_AUTH_FAILED   0xfUL
+	#define STRUCT_DATA_PEER_MMAP_V2_AUTH_STATUS_CERT_N_VAL    0x10UL
+	#define STRUCT_DATA_PEER_MMAP_V2_AUTH_STATUS_INVA_CMD_CODE 0x11UL
+	#define STRUCT_DATA_PEER_MMAP_V2_AUTH_STATUS_INVALID_HDR   0x12UL
+	#define STRUCT_DATA_PEER_MMAP_V2_AUTH_STATUS_LAST         STRUCT_DATA_PEER_MMAP_V2_AUTH_STATUS_INVALID_HDR
+	__le32	unused_2;
+	__le16	status[8];
+	#define STRUCT_DATA_PEER_MMAP_V2_STATUS_SUCCESS           0x0UL
+	#define STRUCT_DATA_PEER_MMAP_V2_STATUS_HDR_VER_MISMATCH  0x1UL
+	#define STRUCT_DATA_PEER_MMAP_V2_STATUS_PKT_SOM_MISSING   0x2UL
+	#define STRUCT_DATA_PEER_MMAP_V2_STATUS_OUT_OF_ORDER_PKTS 0x3UL
+	#define STRUCT_DATA_PEER_MMAP_V2_STATUS_ALREADY_ADDED     0x4UL
+	#define STRUCT_DATA_PEER_MMAP_V2_STATUS_ALREADY_DELETED   0x5UL
+	#define STRUCT_DATA_PEER_MMAP_V2_STATUS_NOT_ADDED         0x6UL
+	#define STRUCT_DATA_PEER_MMAP_V2_STATUS_NOT_DELETED       0x7UL
+	#define STRUCT_DATA_PEER_MMAP_V2_STATUS_NO_EP_CNTX        0x8UL
+	#define STRUCT_DATA_PEER_MMAP_V2_STATUS_INVALID_BUF_SZ    0xaUL
+	#define STRUCT_DATA_PEER_MMAP_V2_STATUS_ALLOC_MEM_FAILED  0xbUL
+	#define STRUCT_DATA_PEER_MMAP_V2_STATUS_ENTRY_CNT_ERR     0xcUL
+	#define STRUCT_DATA_PEER_MMAP_V2_STATUS_NO_RESPONSE       0x13UL
+	#define STRUCT_DATA_PEER_MMAP_V2_STATUS_IPC_ERROR         0x14UL
+	#define STRUCT_DATA_PEER_MMAP_V2_STATUS_LAST             STRUCT_DATA_PEER_MMAP_V2_STATUS_IPC_ERROR
+};
+
+/* hwrm_struct_data_msix_per_vf (size:320b/40B) */
+struct hwrm_struct_data_msix_per_vf {
+	__le16	pf_id;
+	__le16	count;
+	__le32	unused_0;
+	__le16	start_vf_0;
+	__le16	msix_0;
+	__le16	start_vf_1;
+	__le16	msix_1;
+	__le16	start_vf_2;
+	__le16	msix_2;
+	__le16	start_vf_3;
+	__le16	msix_3;
+	__le16	start_vf_4;
+	__le16	msix_4;
+	__le16	start_vf_5;
+	__le16	msix_5;
+	__le16	start_vf_6;
+	__le16	msix_6;
+	__le16	start_vf_7;
+	__le16	msix_7;
+};
+
+/* hwrm_struct_data_dbg_token_claims (size:128b/16B) */
+struct hwrm_struct_data_dbg_token_claims {
+	__s32	claim_number;
+	#define STRUCT_DATA_DBG_TOKEN_CLAIMS_CLAIM_NUMBER_EXP       4
+	#define STRUCT_DATA_DBG_TOKEN_CLAIMS_CLAIM_NUMBER_CTI       7
+	#define STRUCT_DATA_DBG_TOKEN_CLAIMS_CLAIM_NUMBER_AUTH_ID   -67000
+	#define STRUCT_DATA_DBG_TOKEN_CLAIMS_CLAIM_NUMBER_PERSIST   -67001
+	#define STRUCT_DATA_DBG_TOKEN_CLAIMS_CLAIM_NUMBER_SDB_EN    -68000
+	#define STRUCT_DATA_DBG_TOKEN_CLAIMS_CLAIM_NUMBER_DIAGRW_EN -68003
+	#define STRUCT_DATA_DBG_TOKEN_CLAIMS_CLAIM_NUMBER_FW_CLI    -68100
+	#define STRUCT_DATA_DBG_TOKEN_CLAIMS_CLAIM_NUMBER_LAST     STRUCT_DATA_DBG_TOKEN_CLAIMS_CLAIM_NUMBER_FW_CLI
+	__le16	data_type;
+	#define STRUCT_DATA_DBG_TOKEN_CLAIMS_DATA_TYPE_UINT_1_BYTE  0x1UL
+	#define STRUCT_DATA_DBG_TOKEN_CLAIMS_DATA_TYPE_UINT_2_BYTES 0x2UL
+	#define STRUCT_DATA_DBG_TOKEN_CLAIMS_DATA_TYPE_UINT_4_BYTES 0x3UL
+	#define STRUCT_DATA_DBG_TOKEN_CLAIMS_DATA_TYPE_UINT_8_BYTES 0x4UL
+	#define STRUCT_DATA_DBG_TOKEN_CLAIMS_DATA_TYPE_BOOLEAN      0x5UL
+	#define STRUCT_DATA_DBG_TOKEN_CLAIMS_DATA_TYPE_LAST        STRUCT_DATA_DBG_TOKEN_CLAIMS_DATA_TYPE_BOOLEAN
+	__le16	unused_0;
+	u8	claim_data[8];
+};
+
+/* hwrm_fw_set_structured_data_input (size:256b/32B) */
+struct hwrm_fw_set_structured_data_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le64	src_data_addr;
+	__le16	data_len;
+	u8	hdr_cnt;
+	u8	unused_0[5];
+};
+
+/* hwrm_fw_set_structured_data_output (size:128b/16B) */
+struct hwrm_fw_set_structured_data_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_fw_set_structured_data_cmd_err (size:64b/8B) */
+struct hwrm_fw_set_structured_data_cmd_err {
+	u8	code;
+	#define FW_SET_STRUCTURED_DATA_CMD_ERR_CODE_UNKNOWN       0x0UL
+	#define FW_SET_STRUCTURED_DATA_CMD_ERR_CODE_BAD_HDR_CNT   0x1UL
+	#define FW_SET_STRUCTURED_DATA_CMD_ERR_CODE_BAD_FMT       0x2UL
+	#define FW_SET_STRUCTURED_DATA_CMD_ERR_CODE_BAD_ID        0x3UL
+	#define FW_SET_STRUCTURED_DATA_CMD_ERR_CODE_ALREADY_ADDED 0x4UL
+	#define FW_SET_STRUCTURED_DATA_CMD_ERR_CODE_INST_IN_PROG  0x5UL
+	#define FW_SET_STRUCTURED_DATA_CMD_ERR_CODE_LAST         FW_SET_STRUCTURED_DATA_CMD_ERR_CODE_INST_IN_PROG
+	u8	unused_0[7];
+};
+
+/* hwrm_fw_get_structured_data_input (size:256b/32B) */
+struct hwrm_fw_get_structured_data_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le64	dest_data_addr;
+	__le16	data_len;
+	__le16	structure_id;
+	__le16	subtype;
+	#define FW_GET_STRUCTURED_DATA_REQ_SUBTYPE_UNUSED                  0x0UL
+	#define FW_GET_STRUCTURED_DATA_REQ_SUBTYPE_ALL                     0xffffUL
+	#define FW_GET_STRUCTURED_DATA_REQ_SUBTYPE_NEAR_BRIDGE_ADMIN       0x100UL
+	#define FW_GET_STRUCTURED_DATA_REQ_SUBTYPE_NEAR_BRIDGE_PEER        0x101UL
+	#define FW_GET_STRUCTURED_DATA_REQ_SUBTYPE_NEAR_BRIDGE_OPERATIONAL 0x102UL
+	#define FW_GET_STRUCTURED_DATA_REQ_SUBTYPE_NON_TPMR_ADMIN          0x200UL
+	#define FW_GET_STRUCTURED_DATA_REQ_SUBTYPE_NON_TPMR_PEER           0x201UL
+	#define FW_GET_STRUCTURED_DATA_REQ_SUBTYPE_NON_TPMR_OPERATIONAL    0x202UL
+	#define FW_GET_STRUCTURED_DATA_REQ_SUBTYPE_HOST_OPERATIONAL        0x300UL
+	#define FW_GET_STRUCTURED_DATA_REQ_SUBTYPE_CLAIMS_SUPPORTED        0x320UL
+	#define FW_GET_STRUCTURED_DATA_REQ_SUBTYPE_CLAIMS_ACTIVE           0x321UL
+	#define FW_GET_STRUCTURED_DATA_REQ_SUBTYPE_LAST                   FW_GET_STRUCTURED_DATA_REQ_SUBTYPE_CLAIMS_ACTIVE
+	u8	count;
+	u8	unused_0;
+};
+
+/* hwrm_fw_get_structured_data_output (size:128b/16B) */
+struct hwrm_fw_get_structured_data_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	hdr_cnt;
+	u8	unused_0[6];
+	u8	valid;
+};
+
+/* hwrm_fw_get_structured_data_cmd_err (size:64b/8B) */
+struct hwrm_fw_get_structured_data_cmd_err {
+	u8	code;
+	#define FW_GET_STRUCTURED_DATA_CMD_ERR_CODE_UNKNOWN 0x0UL
+	#define FW_GET_STRUCTURED_DATA_CMD_ERR_CODE_BAD_ID  0x3UL
+	#define FW_GET_STRUCTURED_DATA_CMD_ERR_CODE_LAST   FW_GET_STRUCTURED_DATA_CMD_ERR_CODE_BAD_ID
+	u8	unused_0[7];
+};
+
+/* hwrm_fw_ipc_msg_input (size:320b/40B) */
+struct hwrm_fw_ipc_msg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	enables;
+	#define FW_IPC_MSG_REQ_ENABLES_COMMAND_ID        0x1UL
+	#define FW_IPC_MSG_REQ_ENABLES_SRC_PROCESSOR     0x2UL
+	#define FW_IPC_MSG_REQ_ENABLES_DATA_OFFSET       0x4UL
+	#define FW_IPC_MSG_REQ_ENABLES_LENGTH            0x8UL
+	__le16	command_id;
+	#define FW_IPC_MSG_REQ_COMMAND_ID_ROCE_LAG          0x1UL
+	#define FW_IPC_MSG_REQ_COMMAND_ID_MHB_HOST          0x2UL
+	#define FW_IPC_MSG_REQ_COMMAND_ID_ROCE_DRVR_VERSION 0x3UL
+	#define FW_IPC_MSG_REQ_COMMAND_ID_LOG2H             0x4UL
+	#define FW_IPC_MSG_REQ_COMMAND_ID_LAST             FW_IPC_MSG_REQ_COMMAND_ID_LOG2H
+	u8	src_processor;
+	#define FW_IPC_MSG_REQ_SRC_PROCESSOR_CFW  0x1UL
+	#define FW_IPC_MSG_REQ_SRC_PROCESSOR_BONO 0x2UL
+	#define FW_IPC_MSG_REQ_SRC_PROCESSOR_APE  0x3UL
+	#define FW_IPC_MSG_REQ_SRC_PROCESSOR_KONG 0x4UL
+	#define FW_IPC_MSG_REQ_SRC_PROCESSOR_LAST FW_IPC_MSG_REQ_SRC_PROCESSOR_KONG
+	u8	unused_0;
+	__le32	data_offset;
+	__le16	length;
+	u8	unused_1[2];
+	__le64	opaque;
+};
+
+/* hwrm_fw_ipc_msg_output (size:256b/32B) */
+struct hwrm_fw_ipc_msg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le32	msg_data_1;
+	__le32	msg_data_2;
+	__le64	reserved64;
+	u8	reserved48[7];
+	u8	valid;
+};
+
+/* hwrm_fw_ipc_mailbox_input (size:256b/32B) */
+struct hwrm_fw_ipc_mailbox_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	u8	flags;
+	u8	unused;
+	u8	event_id;
+	u8	port_id;
+	__le32	event_data1;
+	__le32	event_data2;
+	u8	unused_0[4];
+};
+
+/* hwrm_fw_ipc_mailbox_output (size:128b/16B) */
+struct hwrm_fw_ipc_mailbox_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_fw_ipc_mailbox_cmd_err (size:64b/8B) */
+struct hwrm_fw_ipc_mailbox_cmd_err {
+	u8	code;
+	#define FW_IPC_MAILBOX_CMD_ERR_CODE_UNKNOWN 0x0UL
+	#define FW_IPC_MAILBOX_CMD_ERR_CODE_BAD_ID  0x3UL
+	#define FW_IPC_MAILBOX_CMD_ERR_CODE_LAST   FW_IPC_MAILBOX_CMD_ERR_CODE_BAD_ID
+	u8	unused_0[7];
+};
+
+/* hwrm_fw_ecn_cfg_input (size:192b/24B) */
+struct hwrm_fw_ecn_cfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	flags;
+	#define FW_ECN_CFG_REQ_FLAGS_ENABLE_ECN     0x1UL
+	u8	unused_0[6];
+};
+
+/* hwrm_fw_ecn_cfg_output (size:128b/16B) */
+struct hwrm_fw_ecn_cfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_fw_ecn_qcfg_input (size:128b/16B) */
+struct hwrm_fw_ecn_qcfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+};
+
+/* hwrm_fw_ecn_qcfg_output (size:128b/16B) */
+struct hwrm_fw_ecn_qcfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	flags;
+	#define FW_ECN_QCFG_RESP_FLAGS_ENABLE_ECN     0x1UL
+	u8	unused_0[5];
+	u8	valid;
+};
+
+/* hwrm_fw_health_check_input (size:128b/16B) */
+struct hwrm_fw_health_check_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+};
+
+/* hwrm_fw_health_check_output (size:128b/16B) */
+struct hwrm_fw_health_check_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le32	fw_status;
+	#define FW_HEALTH_CHECK_RESP_FW_STATUS_SBI_BOOTED           0x1UL
+	#define FW_HEALTH_CHECK_RESP_FW_STATUS_SBI_MISMATCH         0x2UL
+	#define FW_HEALTH_CHECK_RESP_FW_STATUS_SRT_BOOTED           0x4UL
+	#define FW_HEALTH_CHECK_RESP_FW_STATUS_SRT_MISMATCH         0x8UL
+	#define FW_HEALTH_CHECK_RESP_FW_STATUS_CRT_BOOTED           0x10UL
+	#define FW_HEALTH_CHECK_RESP_FW_STATUS_CRT_MISMATCH         0x20UL
+	#define FW_HEALTH_CHECK_RESP_FW_STATUS_SECOND_RT            0x40UL
+	#define FW_HEALTH_CHECK_RESP_FW_STATUS_FASTBOOTED           0x80UL
+	#define FW_HEALTH_CHECK_RESP_FW_STATUS_DIR_HDR_BOOTED       0x100UL
+	#define FW_HEALTH_CHECK_RESP_FW_STATUS_DIR_HDR_MISMATCH     0x200UL
+	#define FW_HEALTH_CHECK_RESP_FW_STATUS_MBR_CORRUPT          0x400UL
+	#define FW_HEALTH_CHECK_RESP_FW_STATUS_CFG_MISMATCH         0x800UL
+	#define FW_HEALTH_CHECK_RESP_FW_STATUS_FRU_MISMATCH         0x1000UL
+	#define FW_HEALTH_CHECK_RESP_FW_STATUS_CRT2_BOOTED          0x2000UL
+	#define FW_HEALTH_CHECK_RESP_FW_STATUS_CRT2_MISMATCH        0x4000UL
+	#define FW_HEALTH_CHECK_RESP_FW_STATUS_GXRT_BOOTED          0x8000UL
+	#define FW_HEALTH_CHECK_RESP_FW_STATUS_GXRT_MISMATCH        0x10000UL
+	#define FW_HEALTH_CHECK_RESP_FW_STATUS_SRT2_BOOTED          0x20000UL
+	#define FW_HEALTH_CHECK_RESP_FW_STATUS_SRT2_MISMATCH        0x40000UL
+	#define FW_HEALTH_CHECK_RESP_FW_STATUS_ART_MISMATCH         0x80000UL
+	#define FW_HEALTH_CHECK_RESP_FW_STATUS_ART_BOOTED           0x100000UL
+	u8	unused_0[3];
+	u8	valid;
+};
+
+/* hwrm_fw_livepatch_query_input (size:192b/24B) */
+struct hwrm_fw_livepatch_query_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	u8	fw_target;
+	#define FW_LIVEPATCH_QUERY_REQ_FW_TARGET_COMMON_FW 0x1UL
+	#define FW_LIVEPATCH_QUERY_REQ_FW_TARGET_SECURE_FW 0x2UL
+	#define FW_LIVEPATCH_QUERY_REQ_FW_TARGET_MPRT_FW   0x3UL
+	#define FW_LIVEPATCH_QUERY_REQ_FW_TARGET_RERT_FW   0x4UL
+	#define FW_LIVEPATCH_QUERY_REQ_FW_TARGET_AUXRT_FW  0x5UL
+	#define FW_LIVEPATCH_QUERY_REQ_FW_TARGET_LAST     FW_LIVEPATCH_QUERY_REQ_FW_TARGET_AUXRT_FW
+	u8	unused_0[7];
+};
+
+/* hwrm_fw_livepatch_query_output (size:640b/80B) */
+struct hwrm_fw_livepatch_query_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	char	install_ver[32];
+	char	active_ver[32];
+	__le16	status_flags;
+	#define FW_LIVEPATCH_QUERY_RESP_STATUS_FLAGS_INSTALL     0x1UL
+	#define FW_LIVEPATCH_QUERY_RESP_STATUS_FLAGS_ACTIVE      0x2UL
+	u8	unused_0[5];
+	u8	valid;
+};
+
+/* hwrm_fw_livepatch_input (size:256b/32B) */
+struct hwrm_fw_livepatch_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	u8	opcode;
+	#define FW_LIVEPATCH_REQ_OPCODE_ACTIVATE   0x1UL
+	#define FW_LIVEPATCH_REQ_OPCODE_DEACTIVATE 0x2UL
+	#define FW_LIVEPATCH_REQ_OPCODE_LAST      FW_LIVEPATCH_REQ_OPCODE_DEACTIVATE
+	u8	fw_target;
+	#define FW_LIVEPATCH_REQ_FW_TARGET_COMMON_FW 0x1UL
+	#define FW_LIVEPATCH_REQ_FW_TARGET_SECURE_FW 0x2UL
+	#define FW_LIVEPATCH_REQ_FW_TARGET_MPRT_FW   0x3UL
+	#define FW_LIVEPATCH_REQ_FW_TARGET_RERT_FW   0x4UL
+	#define FW_LIVEPATCH_REQ_FW_TARGET_AUXRT_FW  0x5UL
+	#define FW_LIVEPATCH_REQ_FW_TARGET_LAST     FW_LIVEPATCH_REQ_FW_TARGET_AUXRT_FW
+	u8	loadtype;
+	#define FW_LIVEPATCH_REQ_LOADTYPE_NVM_INSTALL   0x1UL
+	#define FW_LIVEPATCH_REQ_LOADTYPE_MEMORY_DIRECT 0x2UL
+	#define FW_LIVEPATCH_REQ_LOADTYPE_LAST         FW_LIVEPATCH_REQ_LOADTYPE_MEMORY_DIRECT
+	u8	flags;
+	__le32	patch_len;
+	__le64	host_addr;
+};
+
+/* hwrm_fw_livepatch_output (size:128b/16B) */
+struct hwrm_fw_livepatch_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_fw_sync_input (size:192b/24B) */
+struct hwrm_fw_sync_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	sync_action;
+	#define FW_SYNC_REQ_SYNC_ACTION_SYNC_SBI         0x1UL
+	#define FW_SYNC_REQ_SYNC_ACTION_SYNC_SRT         0x2UL
+	#define FW_SYNC_REQ_SYNC_ACTION_SYNC_CRT         0x4UL
+	#define FW_SYNC_REQ_SYNC_ACTION_SYNC_DIR_HDR     0x8UL
+	#define FW_SYNC_REQ_SYNC_ACTION_WRITE_MBR        0x10UL
+	#define FW_SYNC_REQ_SYNC_ACTION_SYNC_CFG         0x20UL
+	#define FW_SYNC_REQ_SYNC_ACTION_SYNC_FRU         0x40UL
+	#define FW_SYNC_REQ_SYNC_ACTION_SYNC_CRT2        0x80UL
+	#define FW_SYNC_REQ_SYNC_ACTION_SYNC_GXRT        0x100UL
+	#define FW_SYNC_REQ_SYNC_ACTION_SYNC_SRT2        0x200UL
+	#define FW_SYNC_REQ_SYNC_ACTION_SYNC_ART         0x400UL
+	#define FW_SYNC_REQ_SYNC_ACTION_ACTION           0x80000000UL
+	u8	unused_0[4];
+};
+
+/* hwrm_fw_sync_output (size:128b/16B) */
+struct hwrm_fw_sync_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le32	sync_status;
+	#define FW_SYNC_RESP_SYNC_STATUS_ERR_CODE_MASK       0xffUL
+	#define FW_SYNC_RESP_SYNC_STATUS_ERR_CODE_SFT        0
+	#define FW_SYNC_RESP_SYNC_STATUS_ERR_CODE_SUCCESS      0x0UL
+	#define FW_SYNC_RESP_SYNC_STATUS_ERR_CODE_IN_PROGRESS  0x1UL
+	#define FW_SYNC_RESP_SYNC_STATUS_ERR_CODE_TIMEOUT      0x2UL
+	#define FW_SYNC_RESP_SYNC_STATUS_ERR_CODE_GENERAL      0x3UL
+	#define FW_SYNC_RESP_SYNC_STATUS_ERR_CODE_LAST        FW_SYNC_RESP_SYNC_STATUS_ERR_CODE_GENERAL
+	#define FW_SYNC_RESP_SYNC_STATUS_SYNC_ERR            0x40000000UL
+	#define FW_SYNC_RESP_SYNC_STATUS_SYNC_COMPLETE       0x80000000UL
+	u8	unused_0[3];
+	u8	valid;
+};
+
+/* hwrm_fw_sync_cmd_err (size:64b/8B) */
+struct hwrm_fw_sync_cmd_err {
+	u8	code;
+	#define FW_SYNC_CMD_ERR_CODE_UNKNOWN          0x0UL
+	#define FW_SYNC_CMD_ERR_CODE_INVALID_LEN      0x1UL
+	#define FW_SYNC_CMD_ERR_CODE_INVALID_CRID     0x2UL
+	#define FW_SYNC_CMD_ERR_CODE_NO_WORKSPACE_MEM 0x2UL
+	#define FW_SYNC_CMD_ERR_CODE_SYNC_FAILED      0x3UL
+	#define FW_SYNC_CMD_ERR_CODE_LAST            FW_SYNC_CMD_ERR_CODE_SYNC_FAILED
+	u8	unused_0[7];
+};
+
+/* hwrm_fw_state_qcaps_input (size:128b/16B) */
+struct hwrm_fw_state_qcaps_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+};
+
+/* hwrm_fw_state_qcaps_output (size:256b/32B) */
+struct hwrm_fw_state_qcaps_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le32	backup_memory;
+	__le32	quiesce_timeout;
+	__le32	fw_status_blackout;
+	__le32	fw_status_max_wait;
+	u8	unused_0[4];
+	u8	unused_1[3];
+	u8	valid;
+};
+
+/* hwrm_fw_state_quiesce_input (size:192b/24B) */
+struct hwrm_fw_state_quiesce_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	u8	flags;
+	#define FW_STATE_QUIESCE_REQ_FLAGS_ERROR_RECOVERY     0x1UL
+	u8	unused_0[7];
+};
+
+/* hwrm_fw_state_quiesce_output (size:192b/24B) */
+struct hwrm_fw_state_quiesce_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le32	quiesce_status;
+	#define FW_STATE_QUIESCE_RESP_QUIESCE_STATUS_INITIATED     0x80000000UL
+	u8	unused_0[4];
+	u8	unused_1[7];
+	u8	valid;
+};
+
+/* hwrm_fw_state_unquiesce_input (size:128b/16B) */
+struct hwrm_fw_state_unquiesce_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+};
+
+/* hwrm_fw_state_unquiesce_output (size:192b/24B) */
+struct hwrm_fw_state_unquiesce_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le32	unquiesce_status;
+	#define FW_STATE_UNQUIESCE_RESP_UNQUIESCE_STATUS_COMPLETE     0x80000000UL
+	u8	unused_0[4];
+	u8	unused_1[7];
+	u8	valid;
+};
+
+/* hwrm_fw_state_backup_input (size:256b/32B) */
+struct hwrm_fw_state_backup_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	u8	backup_pg_size_backup_lvl;
+	#define FW_STATE_BACKUP_REQ_BACKUP_LVL_MASK      0xfUL
+	#define FW_STATE_BACKUP_REQ_BACKUP_LVL_SFT       0
+	#define FW_STATE_BACKUP_REQ_BACKUP_LVL_LVL_0       0x0UL
+	#define FW_STATE_BACKUP_REQ_BACKUP_LVL_LVL_1       0x1UL
+	#define FW_STATE_BACKUP_REQ_BACKUP_LVL_LVL_2       0x2UL
+	#define FW_STATE_BACKUP_REQ_BACKUP_LVL_LAST       FW_STATE_BACKUP_REQ_BACKUP_LVL_LVL_2
+	#define FW_STATE_BACKUP_REQ_BACKUP_PG_SIZE_MASK  0xf0UL
+	#define FW_STATE_BACKUP_REQ_BACKUP_PG_SIZE_SFT   4
+	#define FW_STATE_BACKUP_REQ_BACKUP_PG_SIZE_PG_4K   (0x0UL << 4)
+	#define FW_STATE_BACKUP_REQ_BACKUP_PG_SIZE_PG_8K   (0x1UL << 4)
+	#define FW_STATE_BACKUP_REQ_BACKUP_PG_SIZE_PG_64K  (0x2UL << 4)
+	#define FW_STATE_BACKUP_REQ_BACKUP_PG_SIZE_PG_2M   (0x3UL << 4)
+	#define FW_STATE_BACKUP_REQ_BACKUP_PG_SIZE_PG_8M   (0x4UL << 4)
+	#define FW_STATE_BACKUP_REQ_BACKUP_PG_SIZE_PG_1G   (0x5UL << 4)
+	#define FW_STATE_BACKUP_REQ_BACKUP_PG_SIZE_LAST   FW_STATE_BACKUP_REQ_BACKUP_PG_SIZE_PG_1G
+	u8	unused_0[7];
+	__le64	backup_page_dir;
+};
+
+/* hwrm_fw_state_backup_output (size:192b/24B) */
+struct hwrm_fw_state_backup_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le32	backup_status;
+	#define FW_STATE_BACKUP_RESP_BACKUP_STATUS_ERR_CODE_MASK         0xffUL
+	#define FW_STATE_BACKUP_RESP_BACKUP_STATUS_ERR_CODE_SFT          0
+	#define FW_STATE_BACKUP_RESP_BACKUP_STATUS_ERR_CODE_SUCCESS        0x0UL
+	#define FW_STATE_BACKUP_RESP_BACKUP_STATUS_ERR_CODE_QUIESCE_ERROR  0x1UL
+	#define FW_STATE_BACKUP_RESP_BACKUP_STATUS_ERR_CODE_GENERAL        0x3UL
+	#define FW_STATE_BACKUP_RESP_BACKUP_STATUS_ERR_CODE_LAST          FW_STATE_BACKUP_RESP_BACKUP_STATUS_ERR_CODE_GENERAL
+	#define FW_STATE_BACKUP_RESP_BACKUP_STATUS_RESET_REQUIRED        0x40000000UL
+	#define FW_STATE_BACKUP_RESP_BACKUP_STATUS_COMPLETE              0x80000000UL
+	u8	unused_0[4];
+	u8	unused_1[7];
+	u8	valid;
+};
+
+/* hwrm_fw_state_restore_input (size:256b/32B) */
+struct hwrm_fw_state_restore_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	u8	restore_pg_size_restore_lvl;
+	#define FW_STATE_RESTORE_REQ_RESTORE_LVL_MASK      0xfUL
+	#define FW_STATE_RESTORE_REQ_RESTORE_LVL_SFT       0
+	#define FW_STATE_RESTORE_REQ_RESTORE_LVL_LVL_0       0x0UL
+	#define FW_STATE_RESTORE_REQ_RESTORE_LVL_LVL_1       0x1UL
+	#define FW_STATE_RESTORE_REQ_RESTORE_LVL_LVL_2       0x2UL
+	#define FW_STATE_RESTORE_REQ_RESTORE_LVL_LAST       FW_STATE_RESTORE_REQ_RESTORE_LVL_LVL_2
+	#define FW_STATE_RESTORE_REQ_RESTORE_PG_SIZE_MASK  0xf0UL
+	#define FW_STATE_RESTORE_REQ_RESTORE_PG_SIZE_SFT   4
+	#define FW_STATE_RESTORE_REQ_RESTORE_PG_SIZE_PG_4K   (0x0UL << 4)
+	#define FW_STATE_RESTORE_REQ_RESTORE_PG_SIZE_PG_8K   (0x1UL << 4)
+	#define FW_STATE_RESTORE_REQ_RESTORE_PG_SIZE_PG_64K  (0x2UL << 4)
+	#define FW_STATE_RESTORE_REQ_RESTORE_PG_SIZE_PG_2M   (0x3UL << 4)
+	#define FW_STATE_RESTORE_REQ_RESTORE_PG_SIZE_PG_8M   (0x4UL << 4)
+	#define FW_STATE_RESTORE_REQ_RESTORE_PG_SIZE_PG_1G   (0x5UL << 4)
+	#define FW_STATE_RESTORE_REQ_RESTORE_PG_SIZE_LAST   FW_STATE_RESTORE_REQ_RESTORE_PG_SIZE_PG_1G
+	u8	unused_0[7];
+	__le64	restore_page_dir;
+};
+
+/* hwrm_fw_state_restore_output (size:128b/16B) */
+struct hwrm_fw_state_restore_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le32	restore_status;
+	#define FW_STATE_RESTORE_RESP_RESTORE_STATUS_ERR_CODE_MASK                  0xffUL
+	#define FW_STATE_RESTORE_RESP_RESTORE_STATUS_ERR_CODE_SFT                   0
+	#define FW_STATE_RESTORE_RESP_RESTORE_STATUS_ERR_CODE_SUCCESS                 0x0UL
+	#define FW_STATE_RESTORE_RESP_RESTORE_STATUS_ERR_CODE_GENERAL                 0x1UL
+	#define FW_STATE_RESTORE_RESP_RESTORE_STATUS_ERR_CODE_FORMAT_PARSE            0x2UL
+	#define FW_STATE_RESTORE_RESP_RESTORE_STATUS_ERR_CODE_INTEGRITY_CHECK         0x3UL
+	#define FW_STATE_RESTORE_RESP_RESTORE_STATUS_ERR_CODE_LAST                   FW_STATE_RESTORE_RESP_RESTORE_STATUS_ERR_CODE_INTEGRITY_CHECK
+	#define FW_STATE_RESTORE_RESP_RESTORE_STATUS_FAILURE_ROLLBACK_COMPLETED     0x40000000UL
+	#define FW_STATE_RESTORE_RESP_RESTORE_STATUS_COMPLETE                       0x80000000UL
+	u8	unused_0[3];
+	u8	valid;
+};
+
+/* hwrm_fw_secure_cfg_input (size:256b/32B) */
+struct hwrm_fw_secure_cfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	u8	enable;
+	#define FW_SECURE_CFG_REQ_ENABLE_NVRAM 0x1UL
+	#define FW_SECURE_CFG_REQ_ENABLE_GRC   0x2UL
+	#define FW_SECURE_CFG_REQ_ENABLE_UART  0x3UL
+	#define FW_SECURE_CFG_REQ_ENABLE_LAST FW_SECURE_CFG_REQ_ENABLE_UART
+	u8	config_mode;
+	#define FW_SECURE_CFG_REQ_CONFIG_MODE_PERSISTENT     0x1UL
+	#define FW_SECURE_CFG_REQ_CONFIG_MODE_RUNTIME        0x2UL
+	u8	nvm_lock_mode;
+	#define FW_SECURE_CFG_REQ_NVM_LOCK_MODE_NONE    0x0UL
+	#define FW_SECURE_CFG_REQ_NVM_LOCK_MODE_PARTIAL 0x1UL
+	#define FW_SECURE_CFG_REQ_NVM_LOCK_MODE_FULL    0x2UL
+	#define FW_SECURE_CFG_REQ_NVM_LOCK_MODE_CHIP    0x3UL
+	#define FW_SECURE_CFG_REQ_NVM_LOCK_MODE_LAST   FW_SECURE_CFG_REQ_NVM_LOCK_MODE_CHIP
+	u8	nvm_partial_lock_mask;
+	#define FW_SECURE_CFG_REQ_NVM_PARTIAL_LOCK_MASK_EXE     0x1UL
+	#define FW_SECURE_CFG_REQ_NVM_PARTIAL_LOCK_MASK_CFG     0x2UL
+	u8	grc_ctrl;
+	#define FW_SECURE_CFG_REQ_GRC_CTRL_RO 0x0UL
+	#define FW_SECURE_CFG_REQ_GRC_CTRL_RW 0x1UL
+	#define FW_SECURE_CFG_REQ_GRC_CTRL_LAST FW_SECURE_CFG_REQ_GRC_CTRL_RW
+	u8	uart_ctrl;
+	#define FW_SECURE_CFG_REQ_UART_CTRL_DISABLE 0x0UL
+	#define FW_SECURE_CFG_REQ_UART_CTRL_ENABLE  0x1UL
+	#define FW_SECURE_CFG_REQ_UART_CTRL_LAST   FW_SECURE_CFG_REQ_UART_CTRL_ENABLE
+	u8	unused_0[2];
+	__le32	unused_1[2];
+};
+
+/* hwrm_fw_secure_cfg_output (size:128b/16B) */
+struct hwrm_fw_secure_cfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_exec_fwd_resp_input (size:1024b/128B) */
+struct hwrm_exec_fwd_resp_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	encap_request[26];
+	__le16	encap_resp_target_id;
+	u8	unused_0[6];
+};
+
+/* hwrm_exec_fwd_resp_output (size:128b/16B) */
+struct hwrm_exec_fwd_resp_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_reject_fwd_resp_input (size:1024b/128B) */
+struct hwrm_reject_fwd_resp_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	encap_request[26];
+	__le16	encap_resp_target_id;
+	u8	unused_0[6];
+};
+
+/* hwrm_reject_fwd_resp_output (size:128b/16B) */
+struct hwrm_reject_fwd_resp_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_fwd_resp_input (size:1792b/224B) */
+struct hwrm_fwd_resp_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	encap_resp_target_id;
+	__le16	encap_resp_cmpl_ring;
+	__le16	encap_resp_len;
+	u8	unused_0;
+	u8	unused_1;
+	__le64	encap_resp_addr;
+	__le32	encap_resp[48];
+};
+
+/* hwrm_fwd_resp_output (size:128b/16B) */
+struct hwrm_fwd_resp_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_fwd_async_event_cmpl_input (size:320b/40B) */
+struct hwrm_fwd_async_event_cmpl_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	encap_async_event_target_id;
+	u8	unused_0[6];
+	__le32	encap_async_event_cmpl[4];
+};
+
+/* hwrm_fwd_async_event_cmpl_output (size:128b/16B) */
+struct hwrm_fwd_async_event_cmpl_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_temp_monitor_query_input (size:128b/16B) */
+struct hwrm_temp_monitor_query_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+};
+
+/* hwrm_temp_monitor_query_output (size:192b/24B) */
+struct hwrm_temp_monitor_query_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	temp;
+	u8	phy_temp;
+	u8	om_temp;
+	u8	flags;
+	#define TEMP_MONITOR_QUERY_RESP_FLAGS_TEMP_NOT_AVAILABLE             0x1UL
+	#define TEMP_MONITOR_QUERY_RESP_FLAGS_PHY_TEMP_NOT_AVAILABLE         0x2UL
+	#define TEMP_MONITOR_QUERY_RESP_FLAGS_OM_NOT_PRESENT                 0x4UL
+	#define TEMP_MONITOR_QUERY_RESP_FLAGS_OM_TEMP_NOT_AVAILABLE          0x8UL
+	#define TEMP_MONITOR_QUERY_RESP_FLAGS_EXT_TEMP_FIELDS_AVAILABLE      0x10UL
+	#define TEMP_MONITOR_QUERY_RESP_FLAGS_THRESHOLD_VALUES_AVAILABLE     0x20UL
+	u8	temp2;
+	u8	phy_temp2;
+	u8	om_temp2;
+	u8	warn_threshold;
+	u8	critical_threshold;
+	u8	fatal_threshold;
+	u8	shutdown_threshold;
+	u8	unused_0[4];
+	u8	valid;
+};
+
+/* hwrm_reg_power_query_input (size:128b/16B) */
+struct hwrm_reg_power_query_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+};
+
+/* hwrm_reg_power_query_output (size:192b/24B) */
+struct hwrm_reg_power_query_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le32	flags;
+	#define REG_POWER_QUERY_RESP_FLAGS_IN_POWER_AVAILABLE      0x1UL
+	#define REG_POWER_QUERY_RESP_FLAGS_OUT_POWER_AVAILABLE     0x2UL
+	__le32	in_power_mw;
+	__le32	out_power_mw;
+	u8	unused_0[3];
+	u8	valid;
+};
+
+/* hwrm_core_frequency_query_input (size:128b/16B) */
+struct hwrm_core_frequency_query_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+};
+
+/* hwrm_core_frequency_query_output (size:128b/16B) */
+struct hwrm_core_frequency_query_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le32	core_frequency_hz;
+	u8	unused_0[3];
+	u8	valid;
+};
+
+/* hwrm_reg_power_histogram_input (size:192b/24B) */
+struct hwrm_reg_power_histogram_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	flags;
+	#define REG_POWER_HISTOGRAM_REQ_FLAGS_CLEAR_HISTOGRAM     0x1UL
+	__le32	unused_0;
+};
+
+/* hwrm_reg_power_histogram_output (size:1088b/136B) */
+struct hwrm_reg_power_histogram_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	flags;
+	#define REG_POWER_HISTOGRAM_RESP_FLAGS_POWER_IN_OUT       0x1UL
+	#define REG_POWER_HISTOGRAM_RESP_FLAGS_POWER_IN_OUT_INPUT   0x0UL
+	#define REG_POWER_HISTOGRAM_RESP_FLAGS_POWER_IN_OUT_OUTPUT  0x1UL
+	#define REG_POWER_HISTOGRAM_RESP_FLAGS_POWER_IN_OUT_LAST   REG_POWER_HISTOGRAM_RESP_FLAGS_POWER_IN_OUT_OUTPUT
+	u8	unused_0[2];
+	__le32	sampling_period;
+	__le64	sample_count;
+	__le32	power_hist[26];
+	u8	unused_1[7];
+	u8	valid;
+};
+
+#define BUCKET_NO_DATA_FOR_SAMPLE 0x0UL
+#define BUCKET_RANGE_8W_OR_LESS   0x1UL
+#define BUCKET_RANGE_8W_TO_9W     0x2UL
+#define BUCKET_RANGE_9W_TO_10W    0x3UL
+#define BUCKET_RANGE_10W_TO_11W   0x4UL
+#define BUCKET_RANGE_11W_TO_12W   0x5UL
+#define BUCKET_RANGE_12W_TO_13W   0x6UL
+#define BUCKET_RANGE_13W_TO_14W   0x7UL
+#define BUCKET_RANGE_14W_TO_15W   0x8UL
+#define BUCKET_RANGE_15W_TO_16W   0x9UL
+#define BUCKET_RANGE_16W_TO_18W   0xaUL
+#define BUCKET_RANGE_18W_TO_20W   0xbUL
+#define BUCKET_RANGE_20W_TO_22W   0xcUL
+#define BUCKET_RANGE_22W_TO_24W   0xdUL
+#define BUCKET_RANGE_24W_TO_26W   0xeUL
+#define BUCKET_RANGE_26W_TO_28W   0xfUL
+#define BUCKET_RANGE_28W_TO_30W   0x10UL
+#define BUCKET_RANGE_30W_TO_32W   0x11UL
+#define BUCKET_RANGE_32W_TO_34W   0x12UL
+#define BUCKET_RANGE_34W_TO_36W   0x13UL
+#define BUCKET_RANGE_36W_TO_38W   0x14UL
+#define BUCKET_RANGE_38W_TO_40W   0x15UL
+#define BUCKET_RANGE_40W_TO_42W   0x16UL
+#define BUCKET_RANGE_42W_TO_44W   0x17UL
+#define BUCKET_RANGE_44W_TO_50W   0x18UL
+#define BUCKET_RANGE_OVER_50W     0x19UL
+#define BUCKET_LAST              BUCKET_RANGE_OVER_50W
+
+/* hwrm_monitor_pax_histogram_start_input (size:448b/56B) */
+struct hwrm_monitor_pax_histogram_start_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	flags;
+	#define MONITOR_PAX_HISTOGRAM_START_REQ_FLAGS_PROFILE      0x1UL
+	#define MONITOR_PAX_HISTOGRAM_START_REQ_FLAGS_PROFILE_READ   0x1UL
+	#define MONITOR_PAX_HISTOGRAM_START_REQ_FLAGS_PROFILE_WRITE  0x0UL
+	#define MONITOR_PAX_HISTOGRAM_START_REQ_FLAGS_PROFILE_LAST  MONITOR_PAX_HISTOGRAM_START_REQ_FLAGS_PROFILE_WRITE
+	u8	unused_0[4];
+	__le64	start_addr;
+	__le64	end_addr;
+	__le32	axuser_value;
+	__le32	axuser_mask;
+	u8	lsb_sel;
+	u8	unused_1[7];
+};
+
+/* hwrm_monitor_pax_histogram_start_output (size:192b/24B) */
+struct hwrm_monitor_pax_histogram_start_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le64	timestamp;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+#define PAX_HISTOGRAM_BUCKET0       0x0UL
+#define PAX_HISTOGRAM_BUCKET1       0x1UL
+#define PAX_HISTOGRAM_BUCKET2       0x2UL
+#define PAX_HISTOGRAM_BUCKET3       0x3UL
+#define PAX_HISTOGRAM_BUCKET4       0x4UL
+#define PAX_HISTOGRAM_BUCKET5       0x5UL
+#define PAX_HISTOGRAM_BUCKET6       0x6UL
+#define PAX_HISTOGRAM_BUCKET7       0x7UL
+#define PAX_HISTOGRAM_BUCKET8       0x8UL
+#define PAX_HISTOGRAM_BUCKET9       0x9UL
+#define PAX_HISTOGRAM_BUCKET10      0xaUL
+#define PAX_HISTOGRAM_BUCKET11      0xbUL
+#define PAX_HISTOGRAM_BUCKET12      0xcUL
+#define PAX_HISTOGRAM_BUCKET13      0xdUL
+#define PAX_HISTOGRAM_BUCKET14      0xeUL
+#define PAX_HISTOGRAM_BUCKET15      0xfUL
+#define PAX_HISTOGRAM_MIN_LATENCY   0x10UL
+#define PAX_HISTOGRAM_MAX_LATENCY   0x11UL
+#define PAX_HISTOGRAM_EVENT_COUNTER 0x12UL
+#define PAX_HISTOGRAM_ACCUMULATOR   0x13UL
+#define PAX_HISTOGRAM_LAST         PAX_HISTOGRAM_ACCUMULATOR
+
+/* hwrm_monitor_pax_histogram_collect_input (size:192b/24B) */
+struct hwrm_monitor_pax_histogram_collect_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	flags;
+	#define MONITOR_PAX_HISTOGRAM_COLLECT_REQ_FLAGS_PROFILE      0x1UL
+	#define MONITOR_PAX_HISTOGRAM_COLLECT_REQ_FLAGS_PROFILE_READ   0x1UL
+	#define MONITOR_PAX_HISTOGRAM_COLLECT_REQ_FLAGS_PROFILE_WRITE  0x0UL
+	#define MONITOR_PAX_HISTOGRAM_COLLECT_REQ_FLAGS_PROFILE_LAST  MONITOR_PAX_HISTOGRAM_COLLECT_REQ_FLAGS_PROFILE_WRITE
+	u8	unused_0[4];
+};
+
+/* hwrm_monitor_pax_histogram_collect_output (size:2752b/344B) */
+struct hwrm_monitor_pax_histogram_collect_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le64	timestamp;
+	__le64	histogram_data_mst0[20];
+	__le64	histogram_data_mst1[20];
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_wol_filter_alloc_input (size:512b/64B) */
+struct hwrm_wol_filter_alloc_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	flags;
+	__le32	enables;
+	#define WOL_FILTER_ALLOC_REQ_ENABLES_MAC_ADDRESS           0x1UL
+	#define WOL_FILTER_ALLOC_REQ_ENABLES_PATTERN_OFFSET        0x2UL
+	#define WOL_FILTER_ALLOC_REQ_ENABLES_PATTERN_BUF_SIZE      0x4UL
+	#define WOL_FILTER_ALLOC_REQ_ENABLES_PATTERN_BUF_ADDR      0x8UL
+	#define WOL_FILTER_ALLOC_REQ_ENABLES_PATTERN_MASK_ADDR     0x10UL
+	#define WOL_FILTER_ALLOC_REQ_ENABLES_PATTERN_MASK_SIZE     0x20UL
+	__le16	port_id;
+	u8	wol_type;
+	#define WOL_FILTER_ALLOC_REQ_WOL_TYPE_MAGICPKT 0x0UL
+	#define WOL_FILTER_ALLOC_REQ_WOL_TYPE_BMP      0x1UL
+	#define WOL_FILTER_ALLOC_REQ_WOL_TYPE_INVALID  0xffUL
+	#define WOL_FILTER_ALLOC_REQ_WOL_TYPE_LAST    WOL_FILTER_ALLOC_REQ_WOL_TYPE_INVALID
+	u8	unused_0[5];
+	u8	mac_address[6];
+	__le16	pattern_offset;
+	__le16	pattern_buf_size;
+	__le16	pattern_mask_size;
+	u8	unused_1[4];
+	__le64	pattern_buf_addr;
+	__le64	pattern_mask_addr;
+};
+
+/* hwrm_wol_filter_alloc_output (size:128b/16B) */
+struct hwrm_wol_filter_alloc_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	wol_filter_id;
+	u8	unused_0[6];
+	u8	valid;
+};
+
+/* hwrm_wol_filter_free_input (size:256b/32B) */
+struct hwrm_wol_filter_free_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	flags;
+	#define WOL_FILTER_FREE_REQ_FLAGS_FREE_ALL_WOL_FILTERS     0x1UL
+	__le32	enables;
+	#define WOL_FILTER_FREE_REQ_ENABLES_WOL_FILTER_ID     0x1UL
+	__le16	port_id;
+	u8	wol_filter_id;
+	u8	unused_0[5];
+};
+
+/* hwrm_wol_filter_free_output (size:128b/16B) */
+struct hwrm_wol_filter_free_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_wol_filter_qcfg_input (size:448b/56B) */
+struct hwrm_wol_filter_qcfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	port_id;
+	__le16	handle;
+	u8	unused_0[4];
+	__le64	pattern_buf_addr;
+	__le16	pattern_buf_size;
+	u8	unused_1[6];
+	__le64	pattern_mask_addr;
+	__le16	pattern_mask_size;
+	u8	unused_2[6];
+};
+
+/* hwrm_wol_filter_qcfg_output (size:256b/32B) */
+struct hwrm_wol_filter_qcfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	next_handle;
+	u8	wol_filter_id;
+	u8	wol_type;
+	#define WOL_FILTER_QCFG_RESP_WOL_TYPE_MAGICPKT 0x0UL
+	#define WOL_FILTER_QCFG_RESP_WOL_TYPE_BMP      0x1UL
+	#define WOL_FILTER_QCFG_RESP_WOL_TYPE_INVALID  0xffUL
+	#define WOL_FILTER_QCFG_RESP_WOL_TYPE_LAST    WOL_FILTER_QCFG_RESP_WOL_TYPE_INVALID
+	__le32	unused_0;
+	u8	mac_address[6];
+	__le16	pattern_offset;
+	__le16	pattern_size;
+	__le16	pattern_mask_size;
+	u8	unused_1[3];
+	u8	valid;
+};
+
+/* hwrm_wol_reason_qcfg_input (size:320b/40B) */
+struct hwrm_wol_reason_qcfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	port_id;
+	u8	unused_0[6];
+	__le64	wol_pkt_buf_addr;
+	__le16	wol_pkt_buf_size;
+	u8	unused_1[6];
+};
+
+/* hwrm_wol_reason_qcfg_output (size:128b/16B) */
+struct hwrm_wol_reason_qcfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	wol_filter_id;
+	u8	wol_reason;
+	#define WOL_REASON_QCFG_RESP_WOL_REASON_MAGICPKT 0x0UL
+	#define WOL_REASON_QCFG_RESP_WOL_REASON_BMP      0x1UL
+	#define WOL_REASON_QCFG_RESP_WOL_REASON_INVALID  0xffUL
+	#define WOL_REASON_QCFG_RESP_WOL_REASON_LAST    WOL_REASON_QCFG_RESP_WOL_REASON_INVALID
+	u8	wol_pkt_len;
+	u8	unused_0[4];
+	u8	valid;
+};
+
+/* hwrm_dbg_qcaps_input (size:192b/24B) */
+struct hwrm_dbg_qcaps_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	fid;
+	u8	unused_0[6];
+};
+
+/* hwrm_dbg_qcaps_output (size:192b/24B) */
+struct hwrm_dbg_qcaps_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	fid;
+	u8	unused_0[2];
+	__le32	coredump_component_disable_caps;
+	#define DBG_QCAPS_RESP_COREDUMP_COMPONENT_DISABLE_CAPS_NVRAM     0x1UL
+	__le32	flags;
+	#define DBG_QCAPS_RESP_FLAGS_CRASHDUMP_NVM             0x1UL
+	#define DBG_QCAPS_RESP_FLAGS_CRASHDUMP_HOST_DDR        0x2UL
+	#define DBG_QCAPS_RESP_FLAGS_CRASHDUMP_SOC_DDR         0x4UL
+	#define DBG_QCAPS_RESP_FLAGS_USEQ                      0x8UL
+	#define DBG_QCAPS_RESP_FLAGS_COREDUMP_HOST_DDR         0x10UL
+	#define DBG_QCAPS_RESP_FLAGS_COREDUMP_HOST_CAPTURE     0x20UL
+	#define DBG_QCAPS_RESP_FLAGS_PTRACE                    0x40UL
+	#define DBG_QCAPS_RESP_FLAGS_REG_ACCESS_RESTRICTED     0x80UL
+	u8	unused_1[3];
+	u8	valid;
+};
+
+/* hwrm_dbg_qcfg_input (size:192b/24B) */
+struct hwrm_dbg_qcfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	fid;
+	__le16	flags;
+	#define DBG_QCFG_REQ_FLAGS_CRASHDUMP_SIZE_FOR_DEST_MASK         0x3UL
+	#define DBG_QCFG_REQ_FLAGS_CRASHDUMP_SIZE_FOR_DEST_SFT          0
+	#define DBG_QCFG_REQ_FLAGS_CRASHDUMP_SIZE_FOR_DEST_DEST_NVM       0x0UL
+	#define DBG_QCFG_REQ_FLAGS_CRASHDUMP_SIZE_FOR_DEST_DEST_HOST_DDR  0x1UL
+	#define DBG_QCFG_REQ_FLAGS_CRASHDUMP_SIZE_FOR_DEST_DEST_SOC_DDR   0x2UL
+	#define DBG_QCFG_REQ_FLAGS_CRASHDUMP_SIZE_FOR_DEST_LAST          DBG_QCFG_REQ_FLAGS_CRASHDUMP_SIZE_FOR_DEST_DEST_SOC_DDR
+	__le32	coredump_component_disable_flags;
+	#define DBG_QCFG_REQ_COREDUMP_COMPONENT_DISABLE_FLAGS_NVRAM     0x1UL
+};
+
+/* hwrm_dbg_qcfg_output (size:256b/32B) */
+struct hwrm_dbg_qcfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	fid;
+	u8	unused_0[2];
+	__le32	coredump_size;
+	__le32	flags;
+	#define DBG_QCFG_RESP_FLAGS_UART_LOG               0x1UL
+	#define DBG_QCFG_RESP_FLAGS_UART_LOG_SECONDARY     0x2UL
+	#define DBG_QCFG_RESP_FLAGS_FW_TRACE               0x4UL
+	#define DBG_QCFG_RESP_FLAGS_FW_TRACE_SECONDARY     0x8UL
+	#define DBG_QCFG_RESP_FLAGS_DEBUG_NOTIFY           0x10UL
+	#define DBG_QCFG_RESP_FLAGS_JTAG_DEBUG             0x20UL
+	__le16	async_cmpl_ring;
+	u8	unused_2[2];
+	__le32	crashdump_size;
+	u8	unused_3[3];
+	u8	valid;
+};
+
+/* hwrm_dbg_crashdump_medium_cfg_input (size:320b/40B) */
+struct hwrm_dbg_crashdump_medium_cfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	output_dest_flags;
+	#define DBG_CRASHDUMP_MEDIUM_CFG_REQ_TYPE_DDR     0x1UL
+	__le16	pg_size_lvl;
+	#define DBG_CRASHDUMP_MEDIUM_CFG_REQ_LVL_MASK      0x3UL
+	#define DBG_CRASHDUMP_MEDIUM_CFG_REQ_LVL_SFT       0
+	#define DBG_CRASHDUMP_MEDIUM_CFG_REQ_LVL_LVL_0       0x0UL
+	#define DBG_CRASHDUMP_MEDIUM_CFG_REQ_LVL_LVL_1       0x1UL
+	#define DBG_CRASHDUMP_MEDIUM_CFG_REQ_LVL_LVL_2       0x2UL
+	#define DBG_CRASHDUMP_MEDIUM_CFG_REQ_LVL_LAST       DBG_CRASHDUMP_MEDIUM_CFG_REQ_LVL_LVL_2
+	#define DBG_CRASHDUMP_MEDIUM_CFG_REQ_PG_SIZE_MASK  0x1cUL
+	#define DBG_CRASHDUMP_MEDIUM_CFG_REQ_PG_SIZE_SFT   2
+	#define DBG_CRASHDUMP_MEDIUM_CFG_REQ_PG_SIZE_PG_4K   (0x0UL << 2)
+	#define DBG_CRASHDUMP_MEDIUM_CFG_REQ_PG_SIZE_PG_8K   (0x1UL << 2)
+	#define DBG_CRASHDUMP_MEDIUM_CFG_REQ_PG_SIZE_PG_64K  (0x2UL << 2)
+	#define DBG_CRASHDUMP_MEDIUM_CFG_REQ_PG_SIZE_PG_2M   (0x3UL << 2)
+	#define DBG_CRASHDUMP_MEDIUM_CFG_REQ_PG_SIZE_PG_8M   (0x4UL << 2)
+	#define DBG_CRASHDUMP_MEDIUM_CFG_REQ_PG_SIZE_PG_1G   (0x5UL << 2)
+	#define DBG_CRASHDUMP_MEDIUM_CFG_REQ_PG_SIZE_LAST   DBG_CRASHDUMP_MEDIUM_CFG_REQ_PG_SIZE_PG_1G
+	#define DBG_CRASHDUMP_MEDIUM_CFG_REQ_UNUSED11_MASK 0xffe0UL
+	#define DBG_CRASHDUMP_MEDIUM_CFG_REQ_UNUSED11_SFT  5
+	__le32	size;
+	__le32	coredump_component_disable_flags;
+	#define DBG_CRASHDUMP_MEDIUM_CFG_REQ_NVRAM     0x1UL
+	__le32	unused_0;
+	__le64	pbl;
+};
+
+/* hwrm_dbg_crashdump_medium_cfg_output (size:128b/16B) */
+struct hwrm_dbg_crashdump_medium_cfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_1[7];
+	u8	valid;
+};
+
+/* coredump_segment_record (size:128b/16B) */
+struct coredump_segment_record {
+	__le16	component_id;
+	__le16	segment_id;
+	__le16	max_instances;
+	u8	version_hi;
+	u8	version_low;
+	u8	seg_flags;
+	u8	compress_flags;
+	#define SFLAG_COMPRESSED_ZLIB     0x1UL
+	u8	unused_0[2];
+	__le32	segment_len;
+};
+
+/* hwrm_dbg_coredump_list_input (size:256b/32B) */
+struct hwrm_dbg_coredump_list_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le64	host_dest_addr;
+	__le32	host_buf_len;
+	__le16	seq_no;
+	u8	flags;
+	#define DBG_COREDUMP_LIST_REQ_FLAGS_CRASHDUMP     0x1UL
+	u8	unused_0;
+};
+
+/* hwrm_dbg_coredump_list_output (size:128b/16B) */
+struct hwrm_dbg_coredump_list_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	flags;
+	#define DBG_COREDUMP_LIST_RESP_FLAGS_MORE     0x1UL
+	u8	unused_0;
+	__le16	total_segments;
+	__le16	data_len;
+	u8	unused_1;
+	u8	valid;
+};
+
+/* hwrm_dbg_coredump_initiate_input (size:256b/32B) */
+struct hwrm_dbg_coredump_initiate_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	component_id;
+	__le16	segment_id;
+	__le16	instance;
+	__le16	unused_0;
+	u8	seg_flags;
+	#define DBG_COREDUMP_INITIATE_REQ_SEG_FLAGS_LIVE_DATA                0x1UL
+	#define DBG_COREDUMP_INITIATE_REQ_SEG_FLAGS_CRASH_DATA               0x2UL
+	#define DBG_COREDUMP_INITIATE_REQ_SEG_FLAGS_COLLECT_CTX_L1_CACHE     0x4UL
+	u8	unused_1[7];
+};
+
+/* hwrm_dbg_coredump_initiate_output (size:128b/16B) */
+struct hwrm_dbg_coredump_initiate_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* coredump_data_hdr (size:128b/16B) */
+struct coredump_data_hdr {
+	__le32	address;
+	__le32	flags_length;
+	#define COREDUMP_DATA_HDR_FLAGS_LENGTH_ACTUAL_LEN_MASK     0xffffffUL
+	#define COREDUMP_DATA_HDR_FLAGS_LENGTH_ACTUAL_LEN_SFT      0
+	#define COREDUMP_DATA_HDR_FLAGS_LENGTH_INDIRECT_ACCESS     0x1000000UL
+	__le32	instance;
+	__le32	next_offset;
+};
+
+/* hwrm_dbg_coredump_retrieve_input (size:448b/56B) */
+struct hwrm_dbg_coredump_retrieve_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le64	host_dest_addr;
+	__le32	host_buf_len;
+	__le32	unused_0;
+	__le16	component_id;
+	__le16	segment_id;
+	__le16	instance;
+	__le16	unused_1;
+	u8	seg_flags;
+	u8	unused_2;
+	__le16	unused_3;
+	__le32	unused_4;
+	__le32	seq_no;
+	__le32	unused_5;
+};
+
+/* hwrm_dbg_coredump_retrieve_output (size:128b/16B) */
+struct hwrm_dbg_coredump_retrieve_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	flags;
+	#define DBG_COREDUMP_RETRIEVE_RESP_FLAGS_MORE     0x1UL
+	u8	unused_0;
+	__le16	data_len;
+	u8	unused_1[3];
+	u8	valid;
+};
+
+#define HWRM_NVM_COMMON_CMD_ERR_UNKNOWN          0x0UL
+#define HWRM_NVM_COMMON_CMD_ERR_ACCESS_DENIED    0x65UL
+#define HWRM_NVM_COMMON_CMD_ERR_FW_BUSY          0x66UL
+#define HWRM_NVM_COMMON_CMD_ERR_FW_ABORT         0x67UL
+#define HWRM_NVM_COMMON_CMD_ERR_FW_UPGRD_IN_PROG 0x68UL
+#define HWRM_NVM_COMMON_CMD_ERR_NO_WORKSPACE_MEM 0x69UL
+#define HWRM_NVM_COMMON_CMD_ERR_RESOURCE_LOCKED  0x6aUL
+#define HWRM_NVM_COMMON_CMD_ERR_FILE_OPEN_FAILED 0x6bUL
+#define HWRM_NVM_COMMON_CMD_ERR_DMA_FAILED       0x6cUL
+#define HWRM_NVM_COMMON_CMD_ERR_LAST            HWRM_NVM_COMMON_CMD_ERR_DMA_FAILED
+
+/* hwrm_nvm_raw_write_blk_input (size:320b/40B) */
+struct hwrm_nvm_raw_write_blk_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le64	host_src_addr;
+	__le32	dest_addr;
+	__le32	len;
+	u8	flags;
+	#define NVM_RAW_WRITE_BLK_REQ_FLAGS_SECURITY_SOC_NVM     0x1UL
+	u8	unused_0[7];
+};
+
+/* hwrm_nvm_raw_write_blk_output (size:128b/16B) */
+struct hwrm_nvm_raw_write_blk_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_nvm_raw_write_blk_cmd_err (size:64b/8B) */
+struct hwrm_nvm_raw_write_blk_cmd_err {
+	u8	code;
+	#define NVM_RAW_WRITE_BLK_CMD_ERR_CODE_UNKNOWN      0x0UL
+	#define NVM_RAW_WRITE_BLK_CMD_ERR_CODE_INVALID_LEN  0x1UL
+	#define NVM_RAW_WRITE_BLK_CMD_ERR_CODE_INVALID_ADDR 0x2UL
+	#define NVM_RAW_WRITE_BLK_CMD_ERR_CODE_WRITE_FAILED 0x3UL
+	#define NVM_RAW_WRITE_BLK_CMD_ERR_CODE_LAST        NVM_RAW_WRITE_BLK_CMD_ERR_CODE_WRITE_FAILED
+	u8	unused_0[7];
+};
+
+/* hwrm_nvm_read_input (size:320b/40B) */
+struct hwrm_nvm_read_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le64	host_dest_addr;
+	__le16	dir_idx;
+	u8	unused_0[2];
+	__le32	offset;
+	__le32	len;
+	u8	unused_1[4];
+};
+
+/* hwrm_nvm_read_output (size:128b/16B) */
+struct hwrm_nvm_read_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_nvm_read_cmd_err (size:64b/8B) */
+struct hwrm_nvm_read_cmd_err {
+	u8	code;
+	#define NVM_READ_CMD_ERR_CODE_UNKNOWN              0x0UL
+	#define NVM_READ_CMD_ERR_CODE_UNKNOWN_DIR_ERR      0x1UL
+	#define NVM_READ_CMD_ERR_CODE_INVALID_LEN          0x2UL
+	#define NVM_READ_CMD_ERR_CODE_READ_FAILED          0x3UL
+	#define NVM_READ_CMD_ERR_CODE_FRU_CRC_CHECK_FAILED 0x4UL
+	#define NVM_READ_CMD_ERR_CODE_LAST                NVM_READ_CMD_ERR_CODE_FRU_CRC_CHECK_FAILED
+	u8	unused_0[7];
+};
+
+/* hwrm_nvm_raw_dump_input (size:320b/40B) */
+struct hwrm_nvm_raw_dump_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le64	host_dest_addr;
+	__le32	offset;
+	__le32	len;
+	u8	flags;
+	#define NVM_RAW_DUMP_REQ_FLAGS_SECURITY_SOC_NVM     0x1UL
+	u8	unused_0[7];
+};
+
+/* hwrm_nvm_raw_dump_output (size:128b/16B) */
+struct hwrm_nvm_raw_dump_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_nvm_raw_dump_cmd_err (size:64b/8B) */
+struct hwrm_nvm_raw_dump_cmd_err {
+	u8	code;
+	#define NVM_RAW_DUMP_CMD_ERR_CODE_UNKNOWN         0x0UL
+	#define NVM_RAW_DUMP_CMD_ERR_CODE_INVALID_LEN     0x1UL
+	#define NVM_RAW_DUMP_CMD_ERR_CODE_INVALID_OFFSET  0x2UL
+	#define NVM_RAW_DUMP_CMD_ERR_CODE_VALIDATE_FAILED 0x3UL
+	#define NVM_RAW_DUMP_CMD_ERR_CODE_LAST           NVM_RAW_DUMP_CMD_ERR_CODE_VALIDATE_FAILED
+	u8	unused_0[7];
+};
+
+/* hwrm_nvm_get_dir_entries_input (size:192b/24B) */
+struct hwrm_nvm_get_dir_entries_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le64	host_dest_addr;
+};
+
+/* hwrm_nvm_get_dir_entries_output (size:128b/16B) */
+struct hwrm_nvm_get_dir_entries_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_nvm_get_dir_entries_cmd_err (size:64b/8B) */
+struct hwrm_nvm_get_dir_entries_cmd_err {
+	u8	code;
+	#define NVM_GET_DIR_ENTRIES_CMD_ERR_CODE_UNKNOWN             0x0UL
+	#define NVM_GET_DIR_ENTRIES_CMD_ERR_CODE_GET_DIR_LIST_FAILED 0x1UL
+	#define NVM_GET_DIR_ENTRIES_CMD_ERR_CODE_LAST               NVM_GET_DIR_ENTRIES_CMD_ERR_CODE_GET_DIR_LIST_FAILED
+	u8	unused_0[7];
+};
+
+/* hwrm_nvm_get_dir_info_input (size:128b/16B) */
+struct hwrm_nvm_get_dir_info_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+};
+
+/* hwrm_nvm_get_dir_info_output (size:192b/24B) */
+struct hwrm_nvm_get_dir_info_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le32	entries;
+	__le32	entry_length;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_nvm_write_input (size:448b/56B) */
+struct hwrm_nvm_write_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le64	host_src_addr;
+	__le16	dir_type;
+	__le16	dir_ordinal;
+	__le16	dir_ext;
+	__le16	dir_attr;
+	__le32	dir_data_length;
+	__le16	option;
+	__le16	flags;
+	#define NVM_WRITE_REQ_FLAGS_KEEP_ORIG_ACTIVE_IMG     0x1UL
+	#define NVM_WRITE_REQ_FLAGS_BATCH_MODE               0x2UL
+	#define NVM_WRITE_REQ_FLAGS_BATCH_LAST               0x4UL
+	#define NVM_WRITE_REQ_FLAGS_SKIP_CRID_CHECK          0x8UL
+	__le32	dir_item_length;
+	__le32	offset;
+	__le32	len;
+	__le32	unused_0;
+};
+
+/* hwrm_nvm_write_output (size:128b/16B) */
+struct hwrm_nvm_write_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le32	dir_item_length;
+	__le16	dir_idx;
+	u8	unused_0;
+	u8	valid;
+};
+
+/* hwrm_nvm_write_cmd_err (size:64b/8B) */
+struct hwrm_nvm_write_cmd_err {
+	u8	code;
+	#define NVM_WRITE_CMD_ERR_CODE_UNKNOWN              0x0UL
+	#define NVM_WRITE_CMD_ERR_CODE_FRAG_ERR             0x1UL
+	#define NVM_WRITE_CMD_ERR_CODE_NO_SPACE             0x2UL
+	#define NVM_WRITE_CMD_ERR_CODE_WRITE_FAILED         0x3UL
+	#define NVM_WRITE_CMD_ERR_CODE_REQD_ERASE_FAILED    0x4UL
+	#define NVM_WRITE_CMD_ERR_CODE_VERIFY_FAILED        0x5UL
+	#define NVM_WRITE_CMD_ERR_CODE_INVALID_HEADER       0x6UL
+	#define NVM_WRITE_CMD_ERR_CODE_UPDATE_DIGEST_FAILED 0x7UL
+	#define NVM_WRITE_CMD_ERR_CODE_LAST                NVM_WRITE_CMD_ERR_CODE_UPDATE_DIGEST_FAILED
+	u8	unused_0[7];
+};
+
+/* hwrm_nvm_modify_input (size:320b/40B) */
+struct hwrm_nvm_modify_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le64	host_src_addr;
+	__le16	dir_idx;
+	__le16	flags;
+	#define NVM_MODIFY_REQ_FLAGS_BATCH_MODE     0x1UL
+	#define NVM_MODIFY_REQ_FLAGS_BATCH_LAST     0x2UL
+	__le32	offset;
+	__le32	len;
+	u8	unused_1[4];
+};
+
+/* hwrm_nvm_modify_output (size:128b/16B) */
+struct hwrm_nvm_modify_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_nvm_modify_cmd_err (size:64b/8B) */
+struct hwrm_nvm_modify_cmd_err {
+	u8	code;
+	#define NVM_MODIFY_CMD_ERR_CODE_UNKNOWN              0x0UL
+	#define NVM_MODIFY_CMD_ERR_CODE_UNKNOWN_DIR_ERR      0x1UL
+	#define NVM_MODIFY_CMD_ERR_CODE_INVALID_OFFSET       0x2UL
+	#define NVM_MODIFY_CMD_ERR_CODE_ITEM_TOO_BIG_ERR     0x3UL
+	#define NVM_MODIFY_CMD_ERR_CODE_BLK_BOUNDARY_ERR     0x4UL
+	#define NVM_MODIFY_CMD_ERR_CODE_SECURITY_VIOLATION   0x5UL
+	#define NVM_MODIFY_CMD_ERR_CODE_WRITE_FAILED         0x6UL
+	#define NVM_MODIFY_CMD_ERR_CODE_ERASE_SECTORS_FAILED 0x7UL
+	#define NVM_MODIFY_CMD_ERR_CODE_COMPUTE_CRC_FAILED   0x8UL
+	#define NVM_MODIFY_CMD_ERR_CODE_LAST                NVM_MODIFY_CMD_ERR_CODE_COMPUTE_CRC_FAILED
+	u8	unused_0[7];
+};
+
+/* hwrm_nvm_find_dir_entry_input (size:256b/32B) */
+struct hwrm_nvm_find_dir_entry_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	enables;
+	#define NVM_FIND_DIR_ENTRY_REQ_ENABLES_DIR_IDX_VALID     0x1UL
+	__le16	dir_idx;
+	__le16	dir_type;
+	__le16	dir_ordinal;
+	__le16	dir_ext;
+	u8	opt_ordinal;
+	#define NVM_FIND_DIR_ENTRY_REQ_OPT_ORDINAL_MASK 0x3UL
+	#define NVM_FIND_DIR_ENTRY_REQ_OPT_ORDINAL_SFT 0
+	#define NVM_FIND_DIR_ENTRY_REQ_OPT_ORDINAL_EQ    0x0UL
+	#define NVM_FIND_DIR_ENTRY_REQ_OPT_ORDINAL_GE    0x1UL
+	#define NVM_FIND_DIR_ENTRY_REQ_OPT_ORDINAL_GT    0x2UL
+	#define NVM_FIND_DIR_ENTRY_REQ_OPT_ORDINAL_LAST NVM_FIND_DIR_ENTRY_REQ_OPT_ORDINAL_GT
+	u8	unused_0[3];
+};
+
+/* hwrm_nvm_find_dir_entry_output (size:256b/32B) */
+struct hwrm_nvm_find_dir_entry_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le32	dir_item_length;
+	__le32	dir_data_length;
+	__le32	fw_ver;
+	__le16	dir_ordinal;
+	__le16	dir_idx;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_nvm_find_dir_entry_cmd_err (size:64b/8B) */
+struct hwrm_nvm_find_dir_entry_cmd_err {
+	u8	code;
+	#define NVM_FIND_DIR_ENTRY_CMD_ERR_CODE_UNKNOWN          0x0UL
+	#define NVM_FIND_DIR_ENTRY_CMD_ERR_CODE_MGMT_FW_DISABLED 0x1UL
+	#define NVM_FIND_DIR_ENTRY_CMD_ERR_CODE_UNKNOWN_DIR_ERR  0x2UL
+	#define NVM_FIND_DIR_ENTRY_CMD_ERR_CODE_LAST            NVM_FIND_DIR_ENTRY_CMD_ERR_CODE_UNKNOWN_DIR_ERR
+	u8	unused_0[7];
+};
+
+/* hwrm_nvm_erase_dir_entry_input (size:192b/24B) */
+struct hwrm_nvm_erase_dir_entry_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	dir_idx;
+	u8	unused_0[6];
+};
+
+/* hwrm_nvm_erase_dir_entry_output (size:128b/16B) */
+struct hwrm_nvm_erase_dir_entry_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_nvm_erase_dir_entry_cmd_err (size:64b/8B) */
+struct hwrm_nvm_erase_dir_entry_cmd_err {
+	u8	code;
+	#define NVM_ERASE_DIR_ENTRY_CMD_ERR_CODE_UNKNOWN            0x0UL
+	#define NVM_ERASE_DIR_ENTRY_CMD_ERR_CODE_UNKNOWN_DIR_ERR    0x1UL
+	#define NVM_ERASE_DIR_ENTRY_CMD_ERR_CODE_SECURITY_VIOLATION 0x5UL
+	#define NVM_ERASE_DIR_ENTRY_CMD_ERR_CODE_LAST              NVM_ERASE_DIR_ENTRY_CMD_ERR_CODE_SECURITY_VIOLATION
+	u8	unused_0[7];
+};
+
+/* hwrm_nvm_get_dev_info_input (size:192b/24B) */
+struct hwrm_nvm_get_dev_info_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	u8	flags;
+	#define NVM_GET_DEV_INFO_REQ_FLAGS_SECURITY_SOC_NVM     0x1UL
+	u8	unused_0[7];
+};
+
+/* hwrm_nvm_get_dev_info_output (size:832b/104B) */
+struct hwrm_nvm_get_dev_info_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	manufacturer_id;
+	__le16	device_id;
+	__le32	sector_size;
+	__le32	nvram_size;
+	__le32	reserved_size;
+	__le32	available_size;
+	u8	nvm_cfg_ver_maj;
+	u8	nvm_cfg_ver_min;
+	u8	nvm_cfg_ver_upd;
+	u8	flags;
+	#define NVM_GET_DEV_INFO_RESP_FLAGS_FW_VER_VALID     0x1UL
+	char	pkg_name[16];
+	__le16	hwrm_fw_major;
+	__le16	hwrm_fw_minor;
+	__le16	hwrm_fw_build;
+	__le16	hwrm_fw_patch;
+	__le16	mgmt_fw_major;
+	__le16	mgmt_fw_minor;
+	__le16	mgmt_fw_build;
+	__le16	mgmt_fw_patch;
+	__le16	roce_fw_major;
+	__le16	roce_fw_minor;
+	__le16	roce_fw_build;
+	__le16	roce_fw_patch;
+	__le16	netctrl_fw_major;
+	__le16	netctrl_fw_minor;
+	__le16	netctrl_fw_build;
+	__le16	netctrl_fw_patch;
+	__le16	srt2_fw_major;
+	__le16	srt2_fw_minor;
+	__le16	srt2_fw_build;
+	__le16	srt2_fw_patch;
+	__le16	art_fw_major;
+	__le16	art_fw_minor;
+	__le16	art_fw_build;
+	__le16	art_fw_patch;
+	u8	security_soc_fw_major;
+	u8	security_soc_fw_minor;
+	u8	security_soc_fw_build;
+	u8	security_soc_fw_patch;
+	u8	unused_0[3];
+	u8	valid;
+};
+
+/* hwrm_nvm_mod_dir_entry_input (size:256b/32B) */
+struct hwrm_nvm_mod_dir_entry_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	enables;
+	#define NVM_MOD_DIR_ENTRY_REQ_ENABLES_CHECKSUM     0x1UL
+	__le16	dir_idx;
+	__le16	dir_ordinal;
+	__le16	dir_ext;
+	__le16	dir_attr;
+	__le32	checksum;
+};
+
+/* hwrm_nvm_mod_dir_entry_output (size:128b/16B) */
+struct hwrm_nvm_mod_dir_entry_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_nvm_mod_dir_entry_cmd_err (size:64b/8B) */
+struct hwrm_nvm_mod_dir_entry_cmd_err {
+	u8	code;
+	#define NVM_MOD_DIR_ENTRY_CMD_ERR_CODE_UNKNOWN            0x0UL
+	#define NVM_MOD_DIR_ENTRY_CMD_ERR_CODE_UNKNOWN_DIR_ERR    0x1UL
+	#define NVM_MOD_DIR_ENTRY_CMD_ERR_CODE_SECURITY_VIOLATION 0x5UL
+	#define NVM_MOD_DIR_ENTRY_CMD_ERR_CODE_LAST              NVM_MOD_DIR_ENTRY_CMD_ERR_CODE_SECURITY_VIOLATION
+	u8	unused_0[7];
+};
+
+/* hwrm_nvm_verify_update_input (size:192b/24B) */
+struct hwrm_nvm_verify_update_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	dir_type;
+	__le16	dir_ordinal;
+	__le16	dir_ext;
+	u8	unused_0[2];
+};
+
+/* hwrm_nvm_verify_update_output (size:128b/16B) */
+struct hwrm_nvm_verify_update_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_nvm_install_update_input (size:192b/24B) */
+struct hwrm_nvm_install_update_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	install_type;
+	#define NVM_INSTALL_UPDATE_REQ_INSTALL_TYPE_NORMAL 0x0UL
+	#define NVM_INSTALL_UPDATE_REQ_INSTALL_TYPE_ALL    0xffffffffUL
+	#define NVM_INSTALL_UPDATE_REQ_INSTALL_TYPE_LAST  NVM_INSTALL_UPDATE_REQ_INSTALL_TYPE_ALL
+	__le16	flags;
+	#define NVM_INSTALL_UPDATE_REQ_FLAGS_ERASE_UNUSED_SPACE     0x1UL
+	#define NVM_INSTALL_UPDATE_REQ_FLAGS_REMOVE_UNUSED_PKG      0x2UL
+	#define NVM_INSTALL_UPDATE_REQ_FLAGS_ALLOWED_TO_DEFRAG      0x4UL
+	#define NVM_INSTALL_UPDATE_REQ_FLAGS_VERIFY_ONLY            0x8UL
+	u8	unused_0[2];
+};
+
+/* hwrm_nvm_install_update_output (size:192b/24B) */
+struct hwrm_nvm_install_update_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le64	installed_items;
+	u8	result;
+	#define NVM_INSTALL_UPDATE_RESP_RESULT_SUCCESS                      0x0UL
+	#define NVM_INSTALL_UPDATE_RESP_RESULT_FAILURE                      0xffUL
+	#define NVM_INSTALL_UPDATE_RESP_RESULT_MALLOC_FAILURE               0xfdUL
+	#define NVM_INSTALL_UPDATE_RESP_RESULT_INVALID_INDEX_PARAMETER      0xfbUL
+	#define NVM_INSTALL_UPDATE_RESP_RESULT_INVALID_TYPE_PARAMETER       0xf3UL
+	#define NVM_INSTALL_UPDATE_RESP_RESULT_INVALID_PREREQUISITE         0xf2UL
+	#define NVM_INSTALL_UPDATE_RESP_RESULT_INVALID_FILE_HEADER          0xecUL
+	#define NVM_INSTALL_UPDATE_RESP_RESULT_INVALID_SIGNATURE            0xebUL
+	#define NVM_INSTALL_UPDATE_RESP_RESULT_INVALID_PROP_STREAM          0xeaUL
+	#define NVM_INSTALL_UPDATE_RESP_RESULT_INVALID_PROP_LENGTH          0xe9UL
+	#define NVM_INSTALL_UPDATE_RESP_RESULT_INVALID_MANIFEST             0xe8UL
+	#define NVM_INSTALL_UPDATE_RESP_RESULT_INVALID_TRAILER              0xe7UL
+	#define NVM_INSTALL_UPDATE_RESP_RESULT_INVALID_CHECKSUM             0xe6UL
+	#define NVM_INSTALL_UPDATE_RESP_RESULT_INVALID_ITEM_CHECKSUM        0xe5UL
+	#define NVM_INSTALL_UPDATE_RESP_RESULT_INVALID_DATA_LENGTH          0xe4UL
+	#define NVM_INSTALL_UPDATE_RESP_RESULT_INVALID_DIRECTIVE            0xe1UL
+	#define NVM_INSTALL_UPDATE_RESP_RESULT_UNSUPPORTED_CHIP_REV         0xceUL
+	#define NVM_INSTALL_UPDATE_RESP_RESULT_UNSUPPORTED_DEVICE_ID        0xcdUL
+	#define NVM_INSTALL_UPDATE_RESP_RESULT_UNSUPPORTED_SUBSYS_VENDOR    0xccUL
+	#define NVM_INSTALL_UPDATE_RESP_RESULT_UNSUPPORTED_SUBSYS_ID        0xcbUL
+	#define NVM_INSTALL_UPDATE_RESP_RESULT_UNSUPPORTED_PLATFORM         0xc5UL
+	#define NVM_INSTALL_UPDATE_RESP_RESULT_DUPLICATE_ITEM               0xc4UL
+	#define NVM_INSTALL_UPDATE_RESP_RESULT_ZERO_LENGTH_ITEM             0xc3UL
+	#define NVM_INSTALL_UPDATE_RESP_RESULT_INSTALL_CHECKSUM_ERROR       0xb9UL
+	#define NVM_INSTALL_UPDATE_RESP_RESULT_INSTALL_DATA_ERROR           0xb8UL
+	#define NVM_INSTALL_UPDATE_RESP_RESULT_INSTALL_AUTHENTICATION_ERROR 0xb7UL
+	#define NVM_INSTALL_UPDATE_RESP_RESULT_ITEM_NOT_FOUND               0xb0UL
+	#define NVM_INSTALL_UPDATE_RESP_RESULT_ITEM_LOCKED                  0xa7UL
+	#define NVM_INSTALL_UPDATE_RESP_RESULT_LAST                        NVM_INSTALL_UPDATE_RESP_RESULT_ITEM_LOCKED
+	u8	problem_item;
+	#define NVM_INSTALL_UPDATE_RESP_PROBLEM_ITEM_NONE    0x0UL
+	#define NVM_INSTALL_UPDATE_RESP_PROBLEM_ITEM_PACKAGE 0xffUL
+	#define NVM_INSTALL_UPDATE_RESP_PROBLEM_ITEM_LAST   NVM_INSTALL_UPDATE_RESP_PROBLEM_ITEM_PACKAGE
+	u8	reset_required;
+	#define NVM_INSTALL_UPDATE_RESP_RESET_REQUIRED_NONE  0x0UL
+	#define NVM_INSTALL_UPDATE_RESP_RESET_REQUIRED_PCI   0x1UL
+	#define NVM_INSTALL_UPDATE_RESP_RESET_REQUIRED_POWER 0x2UL
+	#define NVM_INSTALL_UPDATE_RESP_RESET_REQUIRED_LAST NVM_INSTALL_UPDATE_RESP_RESET_REQUIRED_POWER
+	u8	unused_0[4];
+	u8	valid;
+};
+
+/* hwrm_nvm_install_update_cmd_err (size:64b/8B) */
+struct hwrm_nvm_install_update_cmd_err {
+	u8	code;
+	#define NVM_INSTALL_UPDATE_CMD_ERR_CODE_UNKNOWN            0x0UL
+	#define NVM_INSTALL_UPDATE_CMD_ERR_CODE_FRAG_ERR           0x1UL
+	#define NVM_INSTALL_UPDATE_CMD_ERR_CODE_NO_SPACE           0x2UL
+	#define NVM_INSTALL_UPDATE_CMD_ERR_CODE_ANTI_ROLLBACK      0x3UL
+	#define NVM_INSTALL_UPDATE_CMD_ERR_CODE_NO_VOLTREG_SUPPORT 0x4UL
+	#define NVM_INSTALL_UPDATE_CMD_ERR_CODE_DEFRAG_FAILED      0x5UL
+	#define NVM_INSTALL_UPDATE_CMD_ERR_CODE_UNKNOWN_DIR_ERR    0x6UL
+	#define NVM_INSTALL_UPDATE_CMD_ERR_CODE_LAST              NVM_INSTALL_UPDATE_CMD_ERR_CODE_UNKNOWN_DIR_ERR
+	u8	unused_0[7];
+};
+
+/* hwrm_nvm_flush_input (size:128b/16B) */
+struct hwrm_nvm_flush_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+};
+
+/* hwrm_nvm_flush_output (size:128b/16B) */
+struct hwrm_nvm_flush_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_nvm_flush_cmd_err (size:64b/8B) */
+struct hwrm_nvm_flush_cmd_err {
+	u8	code;
+	#define NVM_FLUSH_CMD_ERR_CODE_UNKNOWN 0x0UL
+	#define NVM_FLUSH_CMD_ERR_CODE_FAIL    0x1UL
+	#define NVM_FLUSH_CMD_ERR_CODE_LAST   NVM_FLUSH_CMD_ERR_CODE_FAIL
+	u8	unused_0[7];
+};
+
+/* hwrm_nvm_get_variable_input (size:320b/40B) */
+struct hwrm_nvm_get_variable_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le64	dest_data_addr;
+	__le16	data_len;
+	__le16	option_num;
+	#define NVM_GET_VARIABLE_REQ_OPTION_NUM_RSVD_0    0x0UL
+	#define NVM_GET_VARIABLE_REQ_OPTION_NUM_RSVD_FFFF 0xffffUL
+	#define NVM_GET_VARIABLE_REQ_OPTION_NUM_LAST     NVM_GET_VARIABLE_REQ_OPTION_NUM_RSVD_FFFF
+	__le16	dimensions;
+	__le16	index_0;
+	__le16	index_1;
+	__le16	index_2;
+	__le16	index_3;
+	u8	flags;
+	#define NVM_GET_VARIABLE_REQ_FLAGS_FACTORY_DFLT           0x1UL
+	#define NVM_GET_VARIABLE_REQ_FLAGS_VALIDATE_OPT_VALUE     0x2UL
+	u8	unused_0;
+};
+
+/* hwrm_nvm_get_variable_output (size:128b/16B) */
+struct hwrm_nvm_get_variable_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	data_len;
+	__le16	option_num;
+	#define NVM_GET_VARIABLE_RESP_OPTION_NUM_RSVD_0    0x0UL
+	#define NVM_GET_VARIABLE_RESP_OPTION_NUM_RSVD_FFFF 0xffffUL
+	#define NVM_GET_VARIABLE_RESP_OPTION_NUM_LAST     NVM_GET_VARIABLE_RESP_OPTION_NUM_RSVD_FFFF
+	u8	flags;
+	#define NVM_GET_VARIABLE_RESP_FLAGS_VALIDATE_OPT_VALUE     0x1UL
+	u8	unused_0[2];
+	u8	valid;
+};
+
+/* hwrm_nvm_get_variable_cmd_err (size:64b/8B) */
+struct hwrm_nvm_get_variable_cmd_err {
+	u8	code;
+	#define NVM_GET_VARIABLE_CMD_ERR_CODE_UNKNOWN          0x0UL
+	#define NVM_GET_VARIABLE_CMD_ERR_CODE_VAR_NOT_EXIST    0x1UL
+	#define NVM_GET_VARIABLE_CMD_ERR_CODE_CORRUPT_VAR      0x2UL
+	#define NVM_GET_VARIABLE_CMD_ERR_CODE_LEN_TOO_SHORT    0x3UL
+	#define NVM_GET_VARIABLE_CMD_ERR_CODE_INDEX_INVALID    0x4UL
+	#define NVM_GET_VARIABLE_CMD_ERR_CODE_ACCESS_DENIED    0x5UL
+	#define NVM_GET_VARIABLE_CMD_ERR_CODE_CB_FAILED        0x6UL
+	#define NVM_GET_VARIABLE_CMD_ERR_CODE_INVALID_DATA_LEN 0x7UL
+	#define NVM_GET_VARIABLE_CMD_ERR_CODE_NO_MEM           0x8UL
+	#define NVM_GET_VARIABLE_CMD_ERR_CODE_LAST            NVM_GET_VARIABLE_CMD_ERR_CODE_NO_MEM
+	u8	unused_0[7];
+};
+
+/* hwrm_nvm_set_variable_input (size:320b/40B) */
+struct hwrm_nvm_set_variable_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le64	src_data_addr;
+	__le16	data_len;
+	__le16	option_num;
+	#define NVM_SET_VARIABLE_REQ_OPTION_NUM_RSVD_0    0x0UL
+	#define NVM_SET_VARIABLE_REQ_OPTION_NUM_RSVD_FFFF 0xffffUL
+	#define NVM_SET_VARIABLE_REQ_OPTION_NUM_LAST     NVM_SET_VARIABLE_REQ_OPTION_NUM_RSVD_FFFF
+	__le16	dimensions;
+	__le16	index_0;
+	__le16	index_1;
+	__le16	index_2;
+	__le16	index_3;
+	u8	flags;
+	#define NVM_SET_VARIABLE_REQ_FLAGS_FORCE_FLUSH                0x1UL
+	#define NVM_SET_VARIABLE_REQ_FLAGS_ENCRYPT_MODE_MASK          0xeUL
+	#define NVM_SET_VARIABLE_REQ_FLAGS_ENCRYPT_MODE_SFT           1
+	#define NVM_SET_VARIABLE_REQ_FLAGS_ENCRYPT_MODE_NONE            (0x0UL << 1)
+	#define NVM_SET_VARIABLE_REQ_FLAGS_ENCRYPT_MODE_HMAC_SHA1       (0x1UL << 1)
+	#define NVM_SET_VARIABLE_REQ_FLAGS_ENCRYPT_MODE_AES256          (0x2UL << 1)
+	#define NVM_SET_VARIABLE_REQ_FLAGS_ENCRYPT_MODE_HMAC_SHA1_AUTH  (0x3UL << 1)
+	#define NVM_SET_VARIABLE_REQ_FLAGS_ENCRYPT_MODE_LAST           NVM_SET_VARIABLE_REQ_FLAGS_ENCRYPT_MODE_HMAC_SHA1_AUTH
+	#define NVM_SET_VARIABLE_REQ_FLAGS_FLAGS_UNUSED_0_MASK        0x70UL
+	#define NVM_SET_VARIABLE_REQ_FLAGS_FLAGS_UNUSED_0_SFT         4
+	#define NVM_SET_VARIABLE_REQ_FLAGS_FACTORY_DEFAULT            0x80UL
+	u8	unused_0;
+};
+
+/* hwrm_nvm_set_variable_output (size:128b/16B) */
+struct hwrm_nvm_set_variable_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_nvm_set_variable_cmd_err (size:64b/8B) */
+struct hwrm_nvm_set_variable_cmd_err {
+	u8	code;
+	#define NVM_SET_VARIABLE_CMD_ERR_CODE_UNKNOWN              0x0UL
+	#define NVM_SET_VARIABLE_CMD_ERR_CODE_VAR_NOT_EXIST        0x1UL
+	#define NVM_SET_VARIABLE_CMD_ERR_CODE_CORRUPT_VAR          0x2UL
+	#define NVM_SET_VARIABLE_CMD_ERR_CODE_LEN_TOO_SHORT        0x3UL
+	#define NVM_SET_VARIABLE_CMD_ERR_CODE_ACTION_NOT_SUPPORTED 0x4UL
+	#define NVM_SET_VARIABLE_CMD_ERR_CODE_INDEX_INVALID        0x5UL
+	#define NVM_SET_VARIABLE_CMD_ERR_CODE_ACCESS_DENIED        0x6UL
+	#define NVM_SET_VARIABLE_CMD_ERR_CODE_CB_FAILED            0x7UL
+	#define NVM_SET_VARIABLE_CMD_ERR_CODE_INVALID_DATA_LEN     0x8UL
+	#define NVM_SET_VARIABLE_CMD_ERR_CODE_NO_MEM               0x9UL
+	#define NVM_SET_VARIABLE_CMD_ERR_CODE_LAST                NVM_SET_VARIABLE_CMD_ERR_CODE_NO_MEM
+	u8	unused_0[7];
+};
+
+/* hwrm_nvm_defrag_input (size:192b/24B) */
+struct hwrm_nvm_defrag_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	flags;
+	#define NVM_DEFRAG_REQ_FLAGS_DEFRAG     0x1UL
+	u8	unused_0[4];
+};
+
+/* hwrm_nvm_defrag_output (size:128b/16B) */
+struct hwrm_nvm_defrag_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_nvm_defrag_cmd_err (size:64b/8B) */
+struct hwrm_nvm_defrag_cmd_err {
+	u8	code;
+	#define NVM_DEFRAG_CMD_ERR_CODE_UNKNOWN    0x0UL
+	#define NVM_DEFRAG_CMD_ERR_CODE_FAIL       0x1UL
+	#define NVM_DEFRAG_CMD_ERR_CODE_CHECK_FAIL 0x2UL
+	#define NVM_DEFRAG_CMD_ERR_CODE_LAST      NVM_DEFRAG_CMD_ERR_CODE_CHECK_FAIL
+	u8	unused_0[7];
+};
+
+/* hwrm_nvm_get_vpd_field_info_input (size:192b/24B) */
+struct hwrm_nvm_get_vpd_field_info_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	u8	tag_id[2];
+	u8	unused_0[6];
+};
+
+/* hwrm_nvm_get_vpd_field_info_output (size:2176b/272B) */
+struct hwrm_nvm_get_vpd_field_info_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	data[256];
+	__le16	data_len;
+	u8	unused_0[5];
+	u8	valid;
+};
+
+/* hwrm_nvm_get_vpd_field_info_cmd_err (size:64b/8B) */
+struct hwrm_nvm_get_vpd_field_info_cmd_err {
+	u8	code;
+	#define NVM_GET_VPD_FIELD_INFO_CMD_ERR_CODE_UNKNOWN          0x0UL
+	#define NVM_GET_VPD_FIELD_INFO_CMD_ERR_CODE_NOT_CACHED       0x1UL
+	#define NVM_GET_VPD_FIELD_INFO_CMD_ERR_CODE_VPD_PARSE_FAILED 0x2UL
+	#define NVM_GET_VPD_FIELD_INFO_CMD_ERR_CODE_INVALID_TAG_ID   0x3UL
+	#define NVM_GET_VPD_FIELD_INFO_CMD_ERR_CODE_LAST            NVM_GET_VPD_FIELD_INFO_CMD_ERR_CODE_INVALID_TAG_ID
+	u8	unused_0[7];
+};
+
+/* hwrm_nvm_set_vpd_field_info_input (size:256b/32B) */
+struct hwrm_nvm_set_vpd_field_info_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le64	host_src_addr;
+	u8	tag_id[2];
+	__le16	data_len;
+	u8	unused_0[4];
+};
+
+/* hwrm_nvm_set_vpd_field_info_output (size:128b/16B) */
+struct hwrm_nvm_set_vpd_field_info_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_nvm_set_profile_input (size:256b/32B) */
+struct hwrm_nvm_set_profile_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le64	src_data_addr;
+	__le16	data_len;
+	u8	option_count;
+	u8	flags;
+	#define NVM_SET_PROFILE_REQ_FLAGS_FORCE_FLUSH         0x1UL
+	#define NVM_SET_PROFILE_REQ_FLAGS_FLAGS_UNUSED_0_MASK 0x3eUL
+	#define NVM_SET_PROFILE_REQ_FLAGS_FLAGS_UNUSED_0_SFT  1
+	#define NVM_SET_PROFILE_REQ_FLAGS_VALIDATE_ONLY       0x40UL
+	#define NVM_SET_PROFILE_REQ_FLAGS_FACTORY_DEFAULT     0x80UL
+	u8	profile_type;
+	#define NVM_SET_PROFILE_REQ_PROFILE_TYPE_NONE  0x0UL
+	#define NVM_SET_PROFILE_REQ_PROFILE_TYPE_EROCE 0x1UL
+	#define NVM_SET_PROFILE_REQ_PROFILE_TYPE_LAST NVM_SET_PROFILE_REQ_PROFILE_TYPE_EROCE
+	u8	unused_2[3];
+};
+
+/* hwrm_nvm_set_profile_output (size:128b/16B) */
+struct hwrm_nvm_set_profile_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_nvm_set_profile_cmd_err (size:64b/8B) */
+struct hwrm_nvm_set_profile_cmd_err {
+	u8	code;
+	#define NVM_SET_PROFILE_CMD_ERR_CODE_UNKNOWN              0x0UL
+	#define NVM_SET_PROFILE_CMD_ERR_CODE_VAR_NOT_EXIST        0x1UL
+	#define NVM_SET_PROFILE_CMD_ERR_CODE_CORRUPT_VAR          0x2UL
+	#define NVM_SET_PROFILE_CMD_ERR_CODE_LEN_TOO_SHORT        0x3UL
+	#define NVM_SET_PROFILE_CMD_ERR_CODE_ACTION_NOT_SUPPORTED 0x4UL
+	#define NVM_SET_PROFILE_CMD_ERR_CODE_INDEX_INVALID        0x5UL
+	#define NVM_SET_PROFILE_CMD_ERR_CODE_ACCESS_DENIED        0x6UL
+	#define NVM_SET_PROFILE_CMD_ERR_CODE_CB_FAILED            0x7UL
+	#define NVM_SET_PROFILE_CMD_ERR_CODE_INVALID_DATA_LEN     0x8UL
+	#define NVM_SET_PROFILE_CMD_ERR_CODE_NO_MEM               0x9UL
+	#define NVM_SET_PROFILE_CMD_ERR_CODE_PROVISION_ERROR      0xaUL
+	#define NVM_SET_PROFILE_CMD_ERR_CODE_LAST                NVM_SET_PROFILE_CMD_ERR_CODE_PROVISION_ERROR
+	u8	err_index;
+	u8	unused_0[6];
+};
+
+/* hwrm_nvm_set_profile_sb (size:128b/16B) */
+struct hwrm_nvm_set_profile_sb {
+	__le16	data_len;
+	__le16	option_num;
+	#define NVM_SET_PROFILE_SB_OPTION_NUM_RSVD_0    0x0UL
+	#define NVM_SET_PROFILE_SB_OPTION_NUM_RSVD_FFFF 0xffffUL
+	#define NVM_SET_PROFILE_SB_OPTION_NUM_LAST     NVM_SET_PROFILE_SB_OPTION_NUM_RSVD_FFFF
+	__le16	dimensions;
+	__le16	index_0;
+	__le16	index_1;
+	__le16	index_2;
+	__le16	index_3;
+	u8	flags;
+	#define NVM_SET_PROFILE_SB_FLAGS_FLAGS_UNUSED_0_MASK 0xffUL
+	#define NVM_SET_PROFILE_SB_FLAGS_FLAGS_UNUSED_0_SFT 0
+	u8	unused_0;
+};
+
+/* hwrm_selftest_qlist_input (size:128b/16B) */
+struct hwrm_selftest_qlist_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+};
+
+/* hwrm_selftest_qlist_output (size:2240b/280B) */
+struct hwrm_selftest_qlist_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	num_tests;
+	u8	available_tests;
+	#define SELFTEST_QLIST_RESP_AVAILABLE_TESTS_NVM_TEST                 0x1UL
+	#define SELFTEST_QLIST_RESP_AVAILABLE_TESTS_LINK_TEST                0x2UL
+	#define SELFTEST_QLIST_RESP_AVAILABLE_TESTS_REGISTER_TEST            0x4UL
+	#define SELFTEST_QLIST_RESP_AVAILABLE_TESTS_MEMORY_TEST              0x8UL
+	#define SELFTEST_QLIST_RESP_AVAILABLE_TESTS_PCIE_SERDES_TEST         0x10UL
+	#define SELFTEST_QLIST_RESP_AVAILABLE_TESTS_ETHERNET_SERDES_TEST     0x20UL
+	u8	offline_tests;
+	#define SELFTEST_QLIST_RESP_OFFLINE_TESTS_NVM_TEST                 0x1UL
+	#define SELFTEST_QLIST_RESP_OFFLINE_TESTS_LINK_TEST                0x2UL
+	#define SELFTEST_QLIST_RESP_OFFLINE_TESTS_REGISTER_TEST            0x4UL
+	#define SELFTEST_QLIST_RESP_OFFLINE_TESTS_MEMORY_TEST              0x8UL
+	#define SELFTEST_QLIST_RESP_OFFLINE_TESTS_PCIE_SERDES_TEST         0x10UL
+	#define SELFTEST_QLIST_RESP_OFFLINE_TESTS_ETHERNET_SERDES_TEST     0x20UL
+	u8	unused_0;
+	__le16	test_timeout;
+	u8	unused_1[2];
+	char	test_name[8][32];
+	u8	eyescope_target_BER_support;
+	#define SELFTEST_QLIST_RESP_EYESCOPE_TARGET_BER_SUPPORT_BER_1E8_SUPPORTED  0x0UL
+	#define SELFTEST_QLIST_RESP_EYESCOPE_TARGET_BER_SUPPORT_BER_1E9_SUPPORTED  0x1UL
+	#define SELFTEST_QLIST_RESP_EYESCOPE_TARGET_BER_SUPPORT_BER_1E10_SUPPORTED 0x2UL
+	#define SELFTEST_QLIST_RESP_EYESCOPE_TARGET_BER_SUPPORT_BER_1E11_SUPPORTED 0x3UL
+	#define SELFTEST_QLIST_RESP_EYESCOPE_TARGET_BER_SUPPORT_BER_1E12_SUPPORTED 0x4UL
+	#define SELFTEST_QLIST_RESP_EYESCOPE_TARGET_BER_SUPPORT_LAST              SELFTEST_QLIST_RESP_EYESCOPE_TARGET_BER_SUPPORT_BER_1E12_SUPPORTED
+	u8	unused_2[6];
+	u8	valid;
+};
+
+/* hwrm_selftest_exec_input (size:192b/24B) */
+struct hwrm_selftest_exec_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	u8	flags;
+	#define SELFTEST_EXEC_REQ_FLAGS_NVM_TEST                 0x1UL
+	#define SELFTEST_EXEC_REQ_FLAGS_LINK_TEST                0x2UL
+	#define SELFTEST_EXEC_REQ_FLAGS_REGISTER_TEST            0x4UL
+	#define SELFTEST_EXEC_REQ_FLAGS_MEMORY_TEST              0x8UL
+	#define SELFTEST_EXEC_REQ_FLAGS_PCIE_SERDES_TEST         0x10UL
+	#define SELFTEST_EXEC_REQ_FLAGS_ETHERNET_SERDES_TEST     0x20UL
+	u8	unused_0[7];
+};
+
+/* hwrm_selftest_exec_output (size:128b/16B) */
+struct hwrm_selftest_exec_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	requested_tests;
+	#define SELFTEST_EXEC_RESP_REQUESTED_TESTS_NVM_TEST                 0x1UL
+	#define SELFTEST_EXEC_RESP_REQUESTED_TESTS_LINK_TEST                0x2UL
+	#define SELFTEST_EXEC_RESP_REQUESTED_TESTS_REGISTER_TEST            0x4UL
+	#define SELFTEST_EXEC_RESP_REQUESTED_TESTS_MEMORY_TEST              0x8UL
+	#define SELFTEST_EXEC_RESP_REQUESTED_TESTS_PCIE_SERDES_TEST         0x10UL
+	#define SELFTEST_EXEC_RESP_REQUESTED_TESTS_ETHERNET_SERDES_TEST     0x20UL
+	u8	test_success;
+	#define SELFTEST_EXEC_RESP_TEST_SUCCESS_NVM_TEST                 0x1UL
+	#define SELFTEST_EXEC_RESP_TEST_SUCCESS_LINK_TEST                0x2UL
+	#define SELFTEST_EXEC_RESP_TEST_SUCCESS_REGISTER_TEST            0x4UL
+	#define SELFTEST_EXEC_RESP_TEST_SUCCESS_MEMORY_TEST              0x8UL
+	#define SELFTEST_EXEC_RESP_TEST_SUCCESS_PCIE_SERDES_TEST         0x10UL
+	#define SELFTEST_EXEC_RESP_TEST_SUCCESS_ETHERNET_SERDES_TEST     0x20UL
+	u8	unused_0[5];
+	u8	valid;
+};
+
+/* hwrm_selftest_irq_input (size:128b/16B) */
+struct hwrm_selftest_irq_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+};
+
+/* hwrm_selftest_irq_output (size:128b/16B) */
+struct hwrm_selftest_irq_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* dbc_dbc (size:64b/8B) */
+struct dbc_dbc {
+	__le32	index;
+	#define DBC_DBC_INDEX_MASK 0xffffffUL
+	#define DBC_DBC_INDEX_SFT  0
+	#define DBC_DBC_EPOCH      0x1000000UL
+	#define DBC_DBC_TOGGLE_MASK 0x6000000UL
+	#define DBC_DBC_TOGGLE_SFT 25
+	__le32	type_path_xid;
+	#define DBC_DBC_XID_MASK          0xfffffUL
+	#define DBC_DBC_XID_SFT           0
+	#define DBC_DBC_PATH_MASK         0x3000000UL
+	#define DBC_DBC_PATH_SFT          24
+	#define DBC_DBC_PATH_ROCE           (0x0UL << 24)
+	#define DBC_DBC_PATH_L2             (0x1UL << 24)
+	#define DBC_DBC_PATH_ENGINE         (0x2UL << 24)
+	#define DBC_DBC_PATH_LAST          DBC_DBC_PATH_ENGINE
+	#define DBC_DBC_VALID             0x4000000UL
+	#define DBC_DBC_DEBUG_TRACE       0x8000000UL
+	#define DBC_DBC_TYPE_MASK         0xf0000000UL
+	#define DBC_DBC_TYPE_SFT          28
+	#define DBC_DBC_TYPE_SQ             (0x0UL << 28)
+	#define DBC_DBC_TYPE_RQ             (0x1UL << 28)
+	#define DBC_DBC_TYPE_SRQ            (0x2UL << 28)
+	#define DBC_DBC_TYPE_SRQ_ARM        (0x3UL << 28)
+	#define DBC_DBC_TYPE_CQ             (0x4UL << 28)
+	#define DBC_DBC_TYPE_CQ_ARMSE       (0x5UL << 28)
+	#define DBC_DBC_TYPE_CQ_ARMALL      (0x6UL << 28)
+	#define DBC_DBC_TYPE_CQ_ARMENA      (0x7UL << 28)
+	#define DBC_DBC_TYPE_SRQ_ARMENA     (0x8UL << 28)
+	#define DBC_DBC_TYPE_CQ_CUTOFF_ACK  (0x9UL << 28)
+	#define DBC_DBC_TYPE_NQ             (0xaUL << 28)
+	#define DBC_DBC_TYPE_NQ_ARM         (0xbUL << 28)
+	#define DBC_DBC_TYPE_CQ_REASSIGN    (0xcUL << 28)
+	#define DBC_DBC_TYPE_NQ_MASK        (0xeUL << 28)
+	#define DBC_DBC_TYPE_NULL           (0xfUL << 28)
+	#define DBC_DBC_TYPE_LAST          DBC_DBC_TYPE_NULL
+};
+
+/* db_push_start (size:64b/8B) */
+struct db_push_start {
+	u64	db;
+	#define DB_PUSH_START_DB_INDEX_MASK     0xffffffUL
+	#define DB_PUSH_START_DB_INDEX_SFT      0
+	#define DB_PUSH_START_DB_PI_LO_MASK     0xff000000UL
+	#define DB_PUSH_START_DB_PI_LO_SFT      24
+	#define DB_PUSH_START_DB_XID_MASK       0xfffff00000000ULL
+	#define DB_PUSH_START_DB_XID_SFT        32
+	#define DB_PUSH_START_DB_PI_HI_MASK     0xf0000000000000ULL
+	#define DB_PUSH_START_DB_PI_HI_SFT      52
+	#define DB_PUSH_START_DB_TYPE_MASK      0xf000000000000000ULL
+	#define DB_PUSH_START_DB_TYPE_SFT       60
+	#define DB_PUSH_START_DB_TYPE_PUSH_START  (0xcULL << 60)
+	#define DB_PUSH_START_DB_TYPE_PUSH_END    (0xdULL << 60)
+	#define DB_PUSH_START_DB_TYPE_LAST       DB_PUSH_START_DB_TYPE_PUSH_END
+};
+
+/* db_push_end (size:64b/8B) */
+struct db_push_end {
+	u64	db;
+	#define DB_PUSH_END_DB_INDEX_MASK      0xffffffUL
+	#define DB_PUSH_END_DB_INDEX_SFT       0
+	#define DB_PUSH_END_DB_PI_LO_MASK      0xff000000UL
+	#define DB_PUSH_END_DB_PI_LO_SFT       24
+	#define DB_PUSH_END_DB_XID_MASK        0xfffff00000000ULL
+	#define DB_PUSH_END_DB_XID_SFT         32
+	#define DB_PUSH_END_DB_PI_HI_MASK      0xf0000000000000ULL
+	#define DB_PUSH_END_DB_PI_HI_SFT       52
+	#define DB_PUSH_END_DB_PATH_MASK       0x300000000000000ULL
+	#define DB_PUSH_END_DB_PATH_SFT        56
+	#define DB_PUSH_END_DB_PATH_ROCE         (0x0ULL << 56)
+	#define DB_PUSH_END_DB_PATH_L2           (0x1ULL << 56)
+	#define DB_PUSH_END_DB_PATH_ENGINE       (0x2ULL << 56)
+	#define DB_PUSH_END_DB_PATH_LAST        DB_PUSH_END_DB_PATH_ENGINE
+	#define DB_PUSH_END_DB_DEBUG_TRACE     0x800000000000000ULL
+	#define DB_PUSH_END_DB_TYPE_MASK       0xf000000000000000ULL
+	#define DB_PUSH_END_DB_TYPE_SFT        60
+	#define DB_PUSH_END_DB_TYPE_PUSH_START   (0xcULL << 60)
+	#define DB_PUSH_END_DB_TYPE_PUSH_END     (0xdULL << 60)
+	#define DB_PUSH_END_DB_TYPE_LAST        DB_PUSH_END_DB_TYPE_PUSH_END
+};
+
+/* db_push_info (size:64b/8B) */
+struct db_push_info {
+	u32	push_size_push_index;
+	#define DB_PUSH_INFO_PUSH_INDEX_MASK 0xffffffUL
+	#define DB_PUSH_INFO_PUSH_INDEX_SFT 0
+	#define DB_PUSH_INFO_PUSH_SIZE_MASK 0x1f000000UL
+	#define DB_PUSH_INFO_PUSH_SIZE_SFT  24
+	u32	reserved32;
+};
+
+/* fw_status_reg (size:32b/4B) */
+struct fw_status_reg {
+	u32	fw_status;
+	#define FW_STATUS_REG_CODE_MASK              0xffffUL
+	#define FW_STATUS_REG_CODE_SFT               0
+	#define FW_STATUS_REG_CODE_READY               0x8000UL
+	#define FW_STATUS_REG_CODE_LAST               FW_STATUS_REG_CODE_READY
+	#define FW_STATUS_REG_IMAGE_DEGRADED         0x10000UL
+	#define FW_STATUS_REG_RECOVERABLE            0x20000UL
+	#define FW_STATUS_REG_CRASHDUMP_ONGOING      0x40000UL
+	#define FW_STATUS_REG_CRASHDUMP_COMPLETE     0x80000UL
+	#define FW_STATUS_REG_SHUTDOWN               0x100000UL
+	#define FW_STATUS_REG_CRASHED_NO_MASTER      0x200000UL
+	#define FW_STATUS_REG_RECOVERING             0x400000UL
+	#define FW_STATUS_REG_MANU_DEBUG_STATUS      0x800000UL
+};
+
+/* hcomm_status (size:64b/8B) */
+struct hcomm_status {
+	u32	sig_ver;
+	#define HCOMM_STATUS_VER_MASK      0xffUL
+	#define HCOMM_STATUS_VER_SFT       0
+	#define HCOMM_STATUS_VER_LATEST      0x1UL
+	#define HCOMM_STATUS_VER_LAST       HCOMM_STATUS_VER_LATEST
+	#define HCOMM_STATUS_SIGNATURE_MASK 0xffffff00UL
+	#define HCOMM_STATUS_SIGNATURE_SFT 8
+	#define HCOMM_STATUS_SIGNATURE_VAL   (0x484353UL << 8)
+	#define HCOMM_STATUS_SIGNATURE_LAST HCOMM_STATUS_SIGNATURE_VAL
+	u32	fw_status_loc;
+	#define HCOMM_STATUS_TRUE_ADDR_SPACE_MASK    0x3UL
+	#define HCOMM_STATUS_TRUE_ADDR_SPACE_SFT     0
+	#define HCOMM_STATUS_FW_STATUS_LOC_ADDR_SPACE_PCIE_CFG  0x0UL
+	#define HCOMM_STATUS_FW_STATUS_LOC_ADDR_SPACE_GRC       0x1UL
+	#define HCOMM_STATUS_FW_STATUS_LOC_ADDR_SPACE_BAR0      0x2UL
+	#define HCOMM_STATUS_FW_STATUS_LOC_ADDR_SPACE_BAR1      0x3UL
+	#define HCOMM_STATUS_FW_STATUS_LOC_ADDR_SPACE_LAST     HCOMM_STATUS_FW_STATUS_LOC_ADDR_SPACE_BAR1
+	#define HCOMM_STATUS_TRUE_OFFSET_MASK        0xfffffffcUL
+	#define HCOMM_STATUS_TRUE_OFFSET_SFT         2
+};
+
+#define HCOMM_STATUS_STRUCT_LOC 0x31001F0UL
+
+#endif /* _BNGE_HSI_H_ */
-- 
2.47.1


