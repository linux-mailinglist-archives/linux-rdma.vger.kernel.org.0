Return-Path: <linux-rdma+bounces-13574-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 396ABB9209D
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 17:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85FF02A70E4
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 15:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B42B2EBB88;
	Mon, 22 Sep 2025 15:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gS15zjDz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vk1-f225.google.com (mail-vk1-f225.google.com [209.85.221.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2502EB84F
	for <linux-rdma@vger.kernel.org>; Mon, 22 Sep 2025 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555835; cv=none; b=YUzdO3JymbDb6dOP4mESkFEOSMyZaPAScbiVRWvOImfFbAVw137UXsx5PIjE8XE84h3+/4FdcqqHBMdX+a1ZrwLoY+UolauP4UK7v7CrQ3rm7TwOERU9He4WkQ7GO3uh2GNaEiQVnL7SeGkpu4Or8s3iSsFrE0R4pzZBeTADKUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555835; c=relaxed/simple;
	bh=NCsd03VKZKcpXek7MQgKB0GsPTAtho9P42JpNeEff/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cZpBEgi9tFhb5ZcIfDX+HyGBJunzxzO4qxOwHW2foUvVJFPsMi8hUE48kJtx4aZjq2+HxMJ5pUlP9wCBMikieqTh4VMq+3UTg0Ablq8Q7y60E+rCFUmhXHg3w3XhJ8mXAc6JZWyVruJU+fh8JPABeZwRHGOE2VnBgqiGGeJF+og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gS15zjDz; arc=none smtp.client-ip=209.85.221.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f225.google.com with SMTP id 71dfb90a1353d-54aa0792200so1223173e0c.3
        for <linux-rdma@vger.kernel.org>; Mon, 22 Sep 2025 08:43:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758555832; x=1759160632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IfNdr1FqEiRk9iohzgT0ZpxaUEsBNSp++Axx7xgwbPY=;
        b=bP82jcofstn34v+k2RZg/MpC0kTQL7NicyxvYi9dlbcNkmQDl08nA1PpORupCZAx7u
         wGk7TUazv7Jbk3qiH0c9aqApQY9u0M5xy/Qq22X05C2zI9HMxeY67CcJjTNp8m7wYjUi
         7KGxRqnYHxoxjZeRVWhyVT1f6eWKOYxwTxggX3siP5FgCiKqUHoRSvJSNY+BGlAS11A4
         PJtCF96oEJ2AxhlYjCco4HJI1mon6ilqR34ojEqNhijQ8pXIwjci1oXkZUbomvjCE6io
         uEZTNXOJQwSGHBIKeE+ksvoqA1mEZ4REzMp2EJsK6THyPw/RhJbLtZ9hXADcC35WtvF7
         NgFw==
X-Gm-Message-State: AOJu0Yx3z7rFVgyYEoq6ZMh92u4JDl3aO50ZA8LkA+Lc77jWnV4n+eM8
	D096S1amT1l8jjHnkod+tVEKHCklvrihbKA0sywF7iDBzLzC8FNAo6Dytf1xFSum7szEmK38KuQ
	vunF22oxgyV88DWG6k4PE2+5kGKuZNpRqSMbYDByKpavqkDFtZaU4zNjarmg1ZPrcLV5ODrmtHE
	H+6vhb7AXSKivvxEPYehtEecKeRFU0HxGe9RxYThG5ixsWdxytdedQ4EQcnt6A1S0hxlu0JjWZo
	yDj6wstwMq8nd0nyw==
X-Gm-Gg: ASbGnctXoe1sJw2qgi29A6RpbtYAiwuw3spkLzi31g+R52nRFRtr11pnaIUTMUqY4AF
	/QYUy3ca9urRrCi6Qgj3q12e28hTTaiBa5tEFEdzdnrolt+UHDyCX/GGH2HWAA+/pwslRC/9Vji
	h3qVpjJFzt9eGSM+PEQ1wlCgoKnuOFb3GwF9dRlT4C3i7860cWs7LsuEE6NBy/LigfXTAWVbxY8
	UJmaEkSRfgMUbwz1nUK0JkbtwAEFkuMe8PAGaTHm9kD30tLWT+aEE9JU/EPl3uZU6agcRfBk6i1
	JG3uRhmj1kxd2xLMvSZa7feW6WCHsOzlf1dkEY85nxNQJcRcV7a/6UCOxzjlZDQ8Bq+vz+F8VbZ
	nSUqOXYOjnJlG+ioo5NwiqBoiN2gQnBkiNbml5nzikiTKULj2ZUpftPuQa2eLGUQUdW+e29sbYQ
	==
X-Google-Smtp-Source: AGHT+IG8izzqzicfy0d+UMe5gMfv/3HNmC7TlL/oYjDnDlhBpLlU/G87kn7e3Tfh9KTVZxRMrpx1OJUkVyFh
X-Received: by 2002:a05:6122:91b:b0:54a:9cff:6fe7 with SMTP id 71dfb90a1353d-54a9cff7164mr2311588e0c.4.1758555831368;
        Mon, 22 Sep 2025 08:43:51 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-54bc5cacbbbsm50307e0c.5.2025.09.22.08.43.51
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Sep 2025 08:43:51 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-84ef374c241so82933185a.3
        for <linux-rdma@vger.kernel.org>; Mon, 22 Sep 2025 08:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758555830; x=1759160630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfNdr1FqEiRk9iohzgT0ZpxaUEsBNSp++Axx7xgwbPY=;
        b=gS15zjDzlscV7PECyHCbkoQFrqVZx2fAzIcMaI+uAOWnaYJcC0N1TxR6Ns/oR1LQe9
         ZPb5Tqm6xkkYoLd86BpHCyydsjSJajdGUh4bVzGMCBGFKUhioNAguKxG2AIBSaULzMeV
         dDxGrQJ8R9F7gHWa/fLs9PqMWEQM7ZE9MqEGI=
X-Received: by 2002:a05:620a:298f:b0:848:2315:b8f1 with SMTP id af79cd13be357-8482315c175mr520499685a.21.1758555829951;
        Mon, 22 Sep 2025 08:43:49 -0700 (PDT)
X-Received: by 2002:a05:620a:298f:b0:848:2315:b8f1 with SMTP id af79cd13be357-8482315c175mr520494085a.21.1758555828982;
        Mon, 22 Sep 2025 08:43:48 -0700 (PDT)
Received: from sjs-csg-thor3-swe-29.lvn.broadcom.net044broadcom.net ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-84ada77bb17sm179496785a.30.2025.09.22.08.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 08:43:48 -0700 (PDT)
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
To: leonro@nvidia.com,
	jgg@nvidia.com
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	vikas.gupta@broadcom.com,
	selvin.xavier@broadcom.com,
	anand.subramanian@broadcom.com,
	usman.ansari@broadcom.com,
	Siva Reddy Kallam <siva.kallam@broadcom.com>
Subject: [PATCH v2 6/8] RDMA/bng_re: Enable Firmware channel and query device attributes
Date: Mon, 22 Sep 2025 15:43:01 +0000
Message-Id: <20250922154303.246809-7-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250922154303.246809-1-siva.kallam@broadcom.com>
References: <20250922154303.246809-1-siva.kallam@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Enable Firmware channel and query device attributes

Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
Reviewed-by: Usman Ansari <usman.ansari@broadcom.com>
---
 drivers/infiniband/hw/bng_re/Makefile  |   2 +-
 drivers/infiniband/hw/bng_re/bng_dev.c |  18 ++
 drivers/infiniband/hw/bng_re/bng_fw.c  | 279 ++++++++++++++++++++++++-
 drivers/infiniband/hw/bng_re/bng_fw.h  |   9 +
 drivers/infiniband/hw/bng_re/bng_re.h  |   2 +
 drivers/infiniband/hw/bng_re/bng_res.h |   7 +
 drivers/infiniband/hw/bng_re/bng_sp.c  | 131 ++++++++++++
 drivers/infiniband/hw/bng_re/bng_sp.h  |  47 +++++
 8 files changed, 491 insertions(+), 4 deletions(-)
 create mode 100644 drivers/infiniband/hw/bng_re/bng_sp.c
 create mode 100644 drivers/infiniband/hw/bng_re/bng_sp.h

diff --git a/drivers/infiniband/hw/bng_re/Makefile b/drivers/infiniband/hw/bng_re/Makefile
index 1b957defbabc..556b763b43f9 100644
--- a/drivers/infiniband/hw/bng_re/Makefile
+++ b/drivers/infiniband/hw/bng_re/Makefile
@@ -4,4 +4,4 @@ ccflags-y := -I $(srctree)/drivers/net/ethernet/broadcom/bnge -I $(srctree)/driv
 obj-$(CONFIG_INFINIBAND_BNG_RE) += bng_re.o
 
 bng_re-y := bng_dev.o bng_fw.o \
-	    bng_res.o
+	    bng_res.o bng_sp.o
diff --git a/drivers/infiniband/hw/bng_re/bng_dev.c b/drivers/infiniband/hw/bng_re/bng_dev.c
index a0fba30187ff..cdebe408f50f 100644
--- a/drivers/infiniband/hw/bng_re/bng_dev.c
+++ b/drivers/infiniband/hw/bng_re/bng_dev.c
@@ -8,6 +8,7 @@
 #include <rdma/ib_verbs.h>
 
 #include "bng_res.h"
+#include "bng_sp.h"
 #include "bng_fw.h"
 #include "bnge.h"
 #include "bnge_auxr.h"
@@ -59,6 +60,9 @@ static void bng_re_destroy_chip_ctx(struct bng_re_dev *rdev)
 	if (!rdev->chip_ctx)
 		return;
 
+	kfree(rdev->dev_attr);
+	rdev->dev_attr = NULL;
+
 	chip_ctx = rdev->chip_ctx;
 	rdev->chip_ctx = NULL;
 	rdev->rcfw.res = NULL;
@@ -71,6 +75,7 @@ static int bng_re_setup_chip_ctx(struct bng_re_dev *rdev)
 {
 	struct bng_re_chip_ctx *chip_ctx;
 	struct bnge_auxr_dev *aux_dev;
+	int rc = -ENOMEM;
 
 	aux_dev = rdev->aux_dev;
 	rdev->bng_res.pdev = aux_dev->pdev;
@@ -83,8 +88,16 @@ static int bng_re_setup_chip_ctx(struct bng_re_dev *rdev)
 
 	rdev->chip_ctx = chip_ctx;
 	rdev->bng_res.cctx = rdev->chip_ctx;
+	rdev->dev_attr = kzalloc(sizeof(*rdev->dev_attr), GFP_KERNEL);
+	if (!rdev->dev_attr)
+		goto free_chip_ctx;
+	rdev->bng_res.dattr = rdev->dev_attr;
 
 	return 0;
+free_chip_ctx:
+	kfree(rdev->chip_ctx);
+	rdev->chip_ctx = NULL;
+	return rc;
 }
 
 static void bng_re_init_hwrm_hdr(struct input *hdr, u16 opcd)
@@ -302,7 +315,12 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
 		goto free_ring;
 	}
 
+	rc = bng_re_get_dev_attr(&rdev->rcfw);
+	if (rc)
+		goto disable_rcfw;
 	return 0;
+disable_rcfw:
+	bng_re_disable_rcfw_channel(&rdev->rcfw);
 free_ring:
 	bng_re_net_ring_free(rdev, rdev->rcfw.creq.ring_id, type);
 free_rcfw:
diff --git a/drivers/infiniband/hw/bng_re/bng_fw.c b/drivers/infiniband/hw/bng_re/bng_fw.c
index 1bfed58e6703..f16fd21dfbce 100644
--- a/drivers/infiniband/hw/bng_re/bng_fw.c
+++ b/drivers/infiniband/hw/bng_re/bng_fw.c
@@ -6,6 +6,49 @@
 #include "bng_res.h"
 #include "bng_fw.h"
 
+/**
+ * bng_re_map_rc  -  map return type based on opcode
+ * @opcode:  roce slow path opcode
+ *
+ * case #1
+ * Firmware initiated error recovery is a safe state machine and
+ * driver can consider all the underlying rdma resources are free.
+ * In this state, it is safe to return success for opcodes related to
+ * destroying rdma resources (like destroy qp, destroy cq etc.).
+ *
+ * case #2
+ * If driver detect potential firmware stall, it is not safe state machine
+ * and the driver can not consider all the underlying rdma resources are
+ * freed.
+ * In this state, it is not safe to return success for opcodes related to
+ * destroying rdma resources (like destroy qp, destroy cq etc.).
+ *
+ * Scope of this helper function is only for case #1.
+ *
+ * Returns:
+ * 0 to communicate success to caller.
+ * Non zero error code to communicate failure to caller.
+ */
+static int bng_re_map_rc(u8 opcode)
+{
+	switch (opcode) {
+	case CMDQ_BASE_OPCODE_DESTROY_QP:
+	case CMDQ_BASE_OPCODE_DESTROY_SRQ:
+	case CMDQ_BASE_OPCODE_DESTROY_CQ:
+	case CMDQ_BASE_OPCODE_DEALLOCATE_KEY:
+	case CMDQ_BASE_OPCODE_DEREGISTER_MR:
+	case CMDQ_BASE_OPCODE_DELETE_GID:
+	case CMDQ_BASE_OPCODE_DESTROY_QP1:
+	case CMDQ_BASE_OPCODE_DESTROY_AH:
+	case CMDQ_BASE_OPCODE_DEINITIALIZE_FW:
+	case CMDQ_BASE_OPCODE_MODIFY_ROCE_CC:
+	case CMDQ_BASE_OPCODE_SET_LINK_AGGR_MODE:
+		return 0;
+	default:
+		return -ETIMEDOUT;
+	}
+}
+
 void bng_re_free_rcfw_channel(struct bng_re_rcfw *rcfw)
 {
 	kfree(rcfw->crsqe_tbl);
@@ -168,8 +211,6 @@ static int bng_re_process_func_event(struct bng_re_rcfw *rcfw,
 	return 0;
 }
 
-
-
 /* CREQ Completion handlers */
 static void bng_re_service_creq(struct tasklet_struct *t)
 {
@@ -229,6 +270,214 @@ static void bng_re_service_creq(struct tasklet_struct *t)
 		wake_up_nr(&rcfw->cmdq.waitq, num_wakeup);
 }
 
+static int __send_message_basic_sanity(struct bng_re_rcfw *rcfw,
+				       struct bng_re_cmdqmsg *msg,
+				       u8 opcode)
+{
+	struct bng_re_cmdq_ctx *cmdq;
+
+	cmdq = &rcfw->cmdq;
+
+	if (test_bit(FIRMWARE_STALL_DETECTED, &cmdq->flags))
+		return -ETIMEDOUT;
+
+	if (test_bit(FIRMWARE_INITIALIZED_FLAG, &cmdq->flags) &&
+	    opcode == CMDQ_BASE_OPCODE_INITIALIZE_FW) {
+		dev_err(&rcfw->pdev->dev, "RCFW already initialized!");
+		return -EINVAL;
+	}
+
+	if (!test_bit(FIRMWARE_INITIALIZED_FLAG, &cmdq->flags) &&
+	    (opcode != CMDQ_BASE_OPCODE_QUERY_FUNC &&
+	     opcode != CMDQ_BASE_OPCODE_INITIALIZE_FW &&
+	     opcode != CMDQ_BASE_OPCODE_QUERY_VERSION)) {
+		dev_err(&rcfw->pdev->dev,
+			"RCFW not initialized, reject opcode 0x%x",
+			opcode);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int __send_message(struct bng_re_rcfw *rcfw,
+			  struct bng_re_cmdqmsg *msg, u8 opcode)
+{
+	u32 bsize, free_slots, required_slots;
+	struct bng_re_cmdq_ctx *cmdq;
+	struct bng_re_crsqe *crsqe;
+	struct bng_fw_cmdqe *cmdqe;
+	struct bng_re_hwq *hwq;
+	u32 sw_prod, cmdq_prod;
+	struct pci_dev *pdev;
+	u16 cookie;
+	u8 *preq;
+
+	cmdq = &rcfw->cmdq;
+	hwq = &cmdq->hwq;
+	pdev = rcfw->pdev;
+
+	/* Cmdq are in 16-byte units, each request can consume 1 or more
+	 * cmdqe
+	 */
+	spin_lock_bh(&hwq->lock);
+	required_slots = bng_re_get_cmd_slots(msg->req);
+	free_slots = HWQ_FREE_SLOTS(hwq);
+	cookie = cmdq->seq_num & BNG_FW_MAX_COOKIE_VALUE;
+	crsqe = &rcfw->crsqe_tbl[cookie];
+
+	if (required_slots >= free_slots) {
+		dev_info_ratelimited(&pdev->dev,
+				     "CMDQ is full req/free %d/%d!",
+				     required_slots, free_slots);
+		spin_unlock_bh(&hwq->lock);
+		return -EAGAIN;
+	}
+	__set_cmdq_base_cookie(msg->req, msg->req_sz, cpu_to_le16(cookie));
+
+	bsize = bng_re_set_cmd_slots(msg->req);
+	crsqe->free_slots = free_slots;
+	crsqe->resp = (struct creq_qp_event *)msg->resp;
+	crsqe->is_waiter_alive = true;
+	crsqe->is_in_used = true;
+	crsqe->opcode = opcode;
+
+	crsqe->req_size = __get_cmdq_base_cmd_size(msg->req, msg->req_sz);
+	if (__get_cmdq_base_resp_size(msg->req, msg->req_sz) && msg->sb) {
+		struct bng_re_rcfw_sbuf *sbuf = msg->sb;
+
+		__set_cmdq_base_resp_addr(msg->req, msg->req_sz,
+					  cpu_to_le64(sbuf->dma_addr));
+		__set_cmdq_base_resp_size(msg->req, msg->req_sz,
+					  ALIGN(sbuf->size,
+						BNG_FW_CMDQE_UNITS) /
+						BNG_FW_CMDQE_UNITS);
+	}
+
+	preq = (u8 *)msg->req;
+	do {
+		/* Locate the next cmdq slot */
+		sw_prod = HWQ_CMP(hwq->prod, hwq);
+		cmdqe = bng_re_get_qe(hwq, sw_prod, NULL);
+		/* Copy a segment of the req cmd to the cmdq */
+		memset(cmdqe, 0, sizeof(*cmdqe));
+		memcpy(cmdqe, preq, min_t(u32, bsize, sizeof(*cmdqe)));
+		preq += min_t(u32, bsize, sizeof(*cmdqe));
+		bsize -= min_t(u32, bsize, sizeof(*cmdqe));
+		hwq->prod++;
+	} while (bsize > 0);
+	cmdq->seq_num++;
+
+	cmdq_prod = hwq->prod & 0xFFFF;
+	if (test_bit(FIRMWARE_FIRST_FLAG, &cmdq->flags)) {
+		/* The very first doorbell write
+		 * is required to set this flag
+		 * which prompts the FW to reset
+		 * its internal pointers
+		 */
+		cmdq_prod |= BIT(FIRMWARE_FIRST_FLAG);
+		clear_bit(FIRMWARE_FIRST_FLAG, &cmdq->flags);
+	}
+	/* ring CMDQ DB */
+	wmb();
+	writel(cmdq_prod, cmdq->cmdq_mbox.prod);
+	writel(BNG_FW_CMDQ_TRIG_VAL, cmdq->cmdq_mbox.db);
+	spin_unlock_bh(&hwq->lock);
+	/* Return the CREQ response pointer */
+	return 0;
+}
+
+/**
+ * __wait_for_resp   -	Don't hold the cpu context and wait for response
+ * @rcfw:    rcfw channel instance of rdev
+ * @cookie:  cookie to track the command
+ *
+ * Wait for command completion in sleepable context.
+ *
+ * Returns:
+ * 0 if command is completed by firmware.
+ * Non zero error code for rest of the case.
+ */
+static int __wait_for_resp(struct bng_re_rcfw *rcfw, u16 cookie)
+{
+	struct bng_re_cmdq_ctx *cmdq;
+	struct bng_re_crsqe *crsqe;
+
+	cmdq = &rcfw->cmdq;
+	crsqe = &rcfw->crsqe_tbl[cookie];
+
+	do {
+		wait_event_timeout(cmdq->waitq,
+				   !crsqe->is_in_used,
+				   secs_to_jiffies(rcfw->max_timeout));
+
+		if (!crsqe->is_in_used)
+			return 0;
+
+		bng_re_service_creq(&rcfw->creq.creq_tasklet);
+
+		if (!crsqe->is_in_used)
+			return 0;
+	} while (true);
+};
+
+/**
+ * bng_re_rcfw_send_message   -	interface to send
+ * and complete rcfw command.
+ * @rcfw:   rcfw channel instance of rdev
+ * @msg:    message to send
+ *
+ * This function does not account shadow queue depth. It will send
+ * all the command unconditionally as long as send queue is not full.
+ *
+ * Returns:
+ * 0 if command completed by firmware.
+ * Non zero if the command is not completed by firmware.
+ */
+int bng_re_rcfw_send_message(struct bng_re_rcfw *rcfw,
+			     struct bng_re_cmdqmsg *msg)
+{
+	struct creq_qp_event *evnt = (struct creq_qp_event *)msg->resp;
+	struct bng_re_crsqe *crsqe;
+	u16 cookie;
+	int rc;
+	u8 opcode;
+
+	opcode = __get_cmdq_base_opcode(msg->req, msg->req_sz);
+
+	rc = __send_message_basic_sanity(rcfw, msg, opcode);
+	if (rc)
+		return rc == -ENXIO ? bng_re_map_rc(opcode) : rc;
+
+	rc = __send_message(rcfw, msg, opcode);
+	if (rc)
+		return rc;
+
+	cookie = le16_to_cpu(__get_cmdq_base_cookie(msg->req, msg->req_sz))
+				& BNG_FW_MAX_COOKIE_VALUE;
+
+	rc = __wait_for_resp(rcfw, cookie);
+
+	if (rc) {
+		spin_lock_bh(&rcfw->cmdq.hwq.lock);
+		crsqe = &rcfw->crsqe_tbl[cookie];
+		crsqe->is_waiter_alive = false;
+		if (rc == -ENODEV)
+			set_bit(FIRMWARE_STALL_DETECTED, &rcfw->cmdq.flags);
+		spin_unlock_bh(&rcfw->cmdq.hwq.lock);
+		return -ETIMEDOUT;
+	}
+
+	if (evnt->status) {
+		/* failed with status */
+		dev_err(&rcfw->pdev->dev, "cmdq[%#x]=%#x status %#x\n",
+			cookie, opcode, evnt->status);
+		rc = -EIO;
+	}
+
+	return rc;
+}
+
 static int bng_re_map_cmdq_mbox(struct bng_re_rcfw *rcfw)
 {
 	struct bng_re_cmdq_mbox *mbox;
@@ -278,7 +527,6 @@ static irqreturn_t bng_re_creq_irq(int irq, void *dev_instance)
 	prefetch(bng_re_get_qe(hwq, sw_cons, NULL));
 
 	tasklet_schedule(&creq->creq_tasklet);
-
 	return IRQ_HANDLED;
 }
 
@@ -395,6 +643,30 @@ void bng_re_disable_rcfw_channel(struct bng_re_rcfw *rcfw)
 	creq->msix_vec = 0;
 }
 
+static void bng_re_start_rcfw(struct bng_re_rcfw *rcfw)
+{
+	struct bng_re_cmdq_ctx *cmdq;
+	struct bng_re_creq_ctx *creq;
+	struct bng_re_cmdq_mbox *mbox;
+	struct cmdq_init init = {0};
+
+	cmdq = &rcfw->cmdq;
+	creq = &rcfw->creq;
+	mbox = &cmdq->cmdq_mbox;
+
+	init.cmdq_pbl = cpu_to_le64(cmdq->hwq.pbl[BNG_PBL_LVL_0].pg_map_arr[0]);
+	init.cmdq_size_cmdq_lvl =
+			cpu_to_le16(((rcfw->cmdq_depth <<
+				      CMDQ_INIT_CMDQ_SIZE_SFT) &
+				    CMDQ_INIT_CMDQ_SIZE_MASK) |
+				    ((cmdq->hwq.level <<
+				      CMDQ_INIT_CMDQ_LVL_SFT) &
+				    CMDQ_INIT_CMDQ_LVL_MASK));
+	init.creq_ring_id = cpu_to_le16(creq->ring_id);
+	/* Write to the mailbox register */
+	__iowrite32_copy(mbox->reg.bar_reg, &init, sizeof(init) / 4);
+}
+
 int bng_re_enable_fw_channel(struct bng_re_rcfw *rcfw,
 			     int msix_vector,
 			     int cp_bar_reg_off)
@@ -425,5 +697,6 @@ int bng_re_enable_fw_channel(struct bng_re_rcfw *rcfw,
 		return rc;
 	}
 
+	bng_re_start_rcfw(rcfw);
 	return 0;
 }
diff --git a/drivers/infiniband/hw/bng_re/bng_fw.h b/drivers/infiniband/hw/bng_re/bng_fw.h
index d1773832b592..88476d6c1d07 100644
--- a/drivers/infiniband/hw/bng_re/bng_fw.h
+++ b/drivers/infiniband/hw/bng_re/bng_fw.h
@@ -136,6 +136,13 @@ struct bng_re_cmdqmsg {
 	u8			block;
 };
 
+static inline void bng_re_rcfw_cmd_prep(struct cmdq_base *req,
+					u8 opcode, u8 cmd_size)
+{
+	req->opcode = opcode;
+	req->cmd_size = cmd_size;
+}
+
 static inline void bng_re_fill_cmdqmsg(struct bng_re_cmdqmsg *msg,
 				       void *req, void *resp, void *sb,
 				       u32 req_sz, u32 res_sz, u8 block)
@@ -195,4 +202,6 @@ void bng_re_disable_rcfw_channel(struct bng_re_rcfw *rcfw);
 int bng_re_rcfw_start_irq(struct bng_re_rcfw *rcfw, int msix_vector,
 			  bool need_init);
 void bng_re_rcfw_stop_irq(struct bng_re_rcfw *rcfw, bool kill);
+int bng_re_rcfw_send_message(struct bng_re_rcfw *rcfw,
+			     struct bng_re_cmdqmsg *msg);
 #endif
diff --git a/drivers/infiniband/hw/bng_re/bng_re.h b/drivers/infiniband/hw/bng_re/bng_re.h
index 033ca94d5164..7598dd91043b 100644
--- a/drivers/infiniband/hw/bng_re/bng_re.h
+++ b/drivers/infiniband/hw/bng_re/bng_re.h
@@ -74,6 +74,8 @@ struct bng_re_dev {
 	struct bng_re_res		bng_res;
 	struct bng_re_rcfw		rcfw;
 	struct bng_re_nq_record		*nqr;
+	/* Device Resources */
+	struct bng_re_dev_attr		*dev_attr;
 };
 
 #endif
diff --git a/drivers/infiniband/hw/bng_re/bng_res.h b/drivers/infiniband/hw/bng_re/bng_res.h
index f40f3477125f..7315db347aa6 100644
--- a/drivers/infiniband/hw/bng_re/bng_res.h
+++ b/drivers/infiniband/hw/bng_re/bng_res.h
@@ -30,6 +30,7 @@
 #define BNG_RE_DBR_EPOCH_SHIFT	24
 #define BNG_RE_DBR_TOGGLE_SHIFT	25
 
+#define BNG_MAX_TQM_ALLOC_REQ	48
 
 struct bng_re_reg_desc {
 	u8		bar_id;
@@ -127,6 +128,7 @@ struct bng_re_hwq {
 struct bng_re_res {
 	struct pci_dev			*pdev;
 	struct bng_re_chip_ctx		*cctx;
+	struct bng_re_dev_attr		*dattr;
 };
 
 static inline void *bng_re_get_qe(struct bng_re_hwq *hwq,
@@ -186,6 +188,11 @@ static inline void bng_re_hwq_incr_cons(u32 max_elements, u32 *cons, u32 cnt,
 	}
 }
 
+static inline bool _is_max_srq_ext_supported(u16 dev_cap_ext_flags_2)
+{
+	return !!(dev_cap_ext_flags_2 & CREQ_QUERY_FUNC_RESP_SB_MAX_SRQ_EXTENDED);
+}
+
 void bng_re_free_hwq(struct bng_re_res *res,
 		     struct bng_re_hwq *hwq);
 
diff --git a/drivers/infiniband/hw/bng_re/bng_sp.c b/drivers/infiniband/hw/bng_re/bng_sp.c
new file mode 100644
index 000000000000..83099e05328d
--- /dev/null
+++ b/drivers/infiniband/hw/bng_re/bng_sp.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2025 Broadcom.
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+
+#include "bng_res.h"
+#include "bng_fw.h"
+#include "bng_sp.h"
+#include "bng_tlv.h"
+
+static bool bng_re_is_atomic_cap(struct bng_re_rcfw *rcfw)
+{
+	u16 pcie_ctl2 = 0;
+
+	pcie_capability_read_word(rcfw->pdev, PCI_EXP_DEVCTL2, &pcie_ctl2);
+	return (pcie_ctl2 & PCI_EXP_DEVCTL2_ATOMIC_REQ);
+}
+
+static void bng_re_query_version(struct bng_re_rcfw *rcfw,
+				 char *fw_ver)
+{
+	struct creq_query_version_resp resp = {};
+	struct bng_re_cmdqmsg msg = {};
+	struct cmdq_query_version req = {};
+	int rc;
+
+	bng_re_rcfw_cmd_prep((struct cmdq_base *)&req,
+			     CMDQ_BASE_OPCODE_QUERY_VERSION,
+			     sizeof(req));
+
+	bng_re_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req), sizeof(resp), 0);
+	rc = bng_re_rcfw_send_message(rcfw, &msg);
+	if (rc)
+		return;
+	fw_ver[0] = resp.fw_maj;
+	fw_ver[1] = resp.fw_minor;
+	fw_ver[2] = resp.fw_bld;
+	fw_ver[3] = resp.fw_rsvd;
+}
+
+int bng_re_get_dev_attr(struct bng_re_rcfw *rcfw)
+{
+	struct bng_re_dev_attr *attr = rcfw->res->dattr;
+	struct creq_query_func_resp resp = {};
+	struct bng_re_cmdqmsg msg = {};
+	struct creq_query_func_resp_sb *sb;
+	struct bng_re_rcfw_sbuf sbuf;
+	struct cmdq_query_func req = {};
+	u8 *tqm_alloc;
+	int i, rc;
+	u32 temp;
+
+	bng_re_rcfw_cmd_prep((struct cmdq_base *)&req,
+			     CMDQ_BASE_OPCODE_QUERY_FUNC,
+			     sizeof(req));
+
+	sbuf.size = ALIGN(sizeof(*sb), BNG_FW_CMDQE_UNITS);
+	sbuf.sb = dma_alloc_coherent(&rcfw->pdev->dev, sbuf.size,
+				     &sbuf.dma_addr, GFP_KERNEL);
+	if (!sbuf.sb)
+		return -ENOMEM;
+	sb = sbuf.sb;
+	req.resp_size = sbuf.size / BNG_FW_CMDQE_UNITS;
+	bng_re_fill_cmdqmsg(&msg, &req, &resp, &sbuf, sizeof(req),
+			    sizeof(resp), 0);
+	rc = bng_re_rcfw_send_message(rcfw, &msg);
+	if (rc)
+		goto bail;
+	/* Extract the context from the side buffer */
+	attr->max_qp = le32_to_cpu(sb->max_qp);
+	/* max_qp value reported by FW doesn't include the QP1 */
+	attr->max_qp += 1;
+	attr->max_qp_rd_atom =
+		sb->max_qp_rd_atom > BNG_RE_MAX_OUT_RD_ATOM ?
+		BNG_RE_MAX_OUT_RD_ATOM : sb->max_qp_rd_atom;
+	attr->max_qp_init_rd_atom =
+		sb->max_qp_init_rd_atom > BNG_RE_MAX_OUT_RD_ATOM ?
+		BNG_RE_MAX_OUT_RD_ATOM : sb->max_qp_init_rd_atom;
+	attr->max_qp_wqes = le16_to_cpu(sb->max_qp_wr) - 1;
+
+	/* Adjust for max_qp_wqes for variable wqe */
+	attr->max_qp_wqes = min_t(u32, attr->max_qp_wqes, BNG_VAR_MAX_WQE - 1);
+
+	attr->max_qp_sges = min_t(u32, sb->max_sge_var_wqe, BNG_VAR_MAX_SGE);
+	attr->max_cq = le32_to_cpu(sb->max_cq);
+	attr->max_cq_wqes = le32_to_cpu(sb->max_cqe);
+	attr->max_cq_sges = attr->max_qp_sges;
+	attr->max_mr = le32_to_cpu(sb->max_mr);
+	attr->max_mw = le32_to_cpu(sb->max_mw);
+
+	attr->max_mr_size = le64_to_cpu(sb->max_mr_size);
+	attr->max_pd = 64 * 1024;
+	attr->max_raw_ethy_qp = le32_to_cpu(sb->max_raw_eth_qp);
+	attr->max_ah = le32_to_cpu(sb->max_ah);
+
+	attr->max_srq = le16_to_cpu(sb->max_srq);
+	attr->max_srq_wqes = le32_to_cpu(sb->max_srq_wr) - 1;
+	attr->max_srq_sges = sb->max_srq_sge;
+	attr->max_pkey = 1;
+	attr->max_inline_data = le32_to_cpu(sb->max_inline_data);
+	/*
+	 * Read the max gid supported by HW.
+	 * For each entry in HW  GID in HW table, we consume 2
+	 * GID entries in the kernel GID table.  So max_gid reported
+	 * to stack can be up to twice the value reported by the HW, up to 256 gids.
+	 */
+	attr->max_sgid = le32_to_cpu(sb->max_gid);
+	attr->max_sgid = min_t(u32, BNG_RE_NUM_GIDS_SUPPORTED, 2 * attr->max_sgid);
+	attr->dev_cap_flags = le16_to_cpu(sb->dev_cap_flags);
+	attr->dev_cap_flags2 = le16_to_cpu(sb->dev_cap_ext_flags_2);
+
+	if (_is_max_srq_ext_supported(attr->dev_cap_flags2))
+		attr->max_srq += le16_to_cpu(sb->max_srq_ext);
+
+	bng_re_query_version(rcfw, attr->fw_ver);
+	for (i = 0; i < BNG_MAX_TQM_ALLOC_REQ / 4; i++) {
+		temp = le32_to_cpu(sb->tqm_alloc_reqs[i]);
+		tqm_alloc = (u8 *)&temp;
+		attr->tqm_alloc_reqs[i * 4] = *tqm_alloc;
+		attr->tqm_alloc_reqs[i * 4 + 1] = *(++tqm_alloc);
+		attr->tqm_alloc_reqs[i * 4 + 2] = *(++tqm_alloc);
+		attr->tqm_alloc_reqs[i * 4 + 3] = *(++tqm_alloc);
+	}
+
+	attr->max_dpi = le32_to_cpu(sb->max_dpi);
+	attr->is_atomic = bng_re_is_atomic_cap(rcfw);
+bail:
+	dma_free_coherent(&rcfw->pdev->dev, sbuf.size,
+			  sbuf.sb, sbuf.dma_addr);
+	return rc;
+}
diff --git a/drivers/infiniband/hw/bng_re/bng_sp.h b/drivers/infiniband/hw/bng_re/bng_sp.h
new file mode 100644
index 000000000000..e15190515ed1
--- /dev/null
+++ b/drivers/infiniband/hw/bng_re/bng_sp.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (c) 2025 Broadcom.
+
+#ifndef __BNG_SP_H__
+#define __BNG_SP_H__
+
+#include "bng_fw.h"
+
+#define BNG_VAR_MAX_WQE		4352
+#define BNG_VAR_MAX_SGE		13
+
+struct bng_re_dev_attr {
+#define FW_VER_ARR_LEN			4
+	u8				fw_ver[FW_VER_ARR_LEN];
+#define BNG_RE_NUM_GIDS_SUPPORTED	256
+	u16				max_sgid;
+	u16				max_mrw;
+	u32				max_qp;
+#define BNG_RE_MAX_OUT_RD_ATOM		126
+	u32				max_qp_rd_atom;
+	u32				max_qp_init_rd_atom;
+	u32				max_qp_wqes;
+	u32				max_qp_sges;
+	u32				max_cq;
+	u32				max_cq_wqes;
+	u32				max_cq_sges;
+	u32				max_mr;
+	u64				max_mr_size;
+	u32				max_pd;
+	u32				max_mw;
+	u32				max_raw_ethy_qp;
+	u32				max_ah;
+	u32				max_srq;
+	u32				max_srq_wqes;
+	u32				max_srq_sges;
+	u32				max_pkey;
+	u32				max_inline_data;
+	u32				l2_db_size;
+	u8				tqm_alloc_reqs[BNG_MAX_TQM_ALLOC_REQ];
+	bool				is_atomic;
+	u16                             dev_cap_flags;
+	u16                             dev_cap_flags2;
+	u32                             max_dpi;
+};
+
+int bng_re_get_dev_attr(struct bng_re_rcfw *rcfw);
+#endif
-- 
2.34.1


