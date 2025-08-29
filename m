Return-Path: <linux-rdma+bounces-12997-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDB5B3BB58
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Aug 2025 14:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1489B4666C5
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Aug 2025 12:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D1B319878;
	Fri, 29 Aug 2025 12:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="h3c7igoh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f100.google.com (mail-oa1-f100.google.com [209.85.160.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45EC3176F6
	for <linux-rdma@vger.kernel.org>; Fri, 29 Aug 2025 12:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756470699; cv=none; b=n7NVTubwfnQJjH3qhbuO+dxxEmfCKzPNkOa/JZVr0iyJwNs7HN7UMXFKw+FXOJ5dPoPVwjnuql8RFDHR60AXsQrHgaYT3oT86gyYSbStSxlAit7ux9+PqKPM+g3OI1qX9UhNL5b5mpw1adw3S/WEXzi6PGj2IHLmuMWCdrGwcck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756470699; c=relaxed/simple;
	bh=lq9IgVMd29kJWnEVYAPm2A8C8/2SmU4Hc9oFr+wKG5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dIdsrWOWx4Sa8057deVN36eAFjonmtsFmhOeQ31fiQVXH1QGSv15pfn0I4icfK4Wx5OraRak1kFT78HZppVMjvceJgfbyK1R9Z2HjQW2bVSRw7USmaRCBn817qD22Tonz2fEQ7qpVFJld5nWq+7sBU+5XaAe04RXdQPZQ7UULWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=h3c7igoh; arc=none smtp.client-ip=209.85.160.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f100.google.com with SMTP id 586e51a60fabf-315bb486e6dso369035fac.2
        for <linux-rdma@vger.kernel.org>; Fri, 29 Aug 2025 05:31:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756470696; x=1757075496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5v3XO96dQ7iELlwfLpM0O2b8h9cGc26uAv0tYsfkkvI=;
        b=tKCpwIOb7HWcXQ69h8sFg4AXPi37QwOjWx5odH77M6kYzVsAIVF0ebcPnJtcx98JO1
         0b4WI+YE40Ju9Ebw39pJX7GmHFg/I3SCkWWIAsymdUIVoxHm/1x7tSTc0k1cewpQ2gra
         KKI/68gFws52clQJldas0SPHLsSJApif3rh4cOh2X19AxSMsxqqc7sGkJc1Lmu/R+T30
         tMjVyFHXx3DBKOR6a92w8J5/02gpmEYMH2+pk6ZwZjnYc//Bnlod9eUyKnw+1AT0gIMJ
         VKh+QQ9KwwVe5i0G6/sEJgPPDTNKo+6NfccAg298GC74t9DgYi+RdpTIunSfJrKsEK1e
         w9ZQ==
X-Gm-Message-State: AOJu0Yz6v0wssFaXC4uF+8Nn+CS8A26CSUouHhzZMIYJQeQkjKzusEaG
	pun4dMD8ZX91SIjQ8VaR0lVreXyE+f7PMYtZXVX7IXW9499nGy5UytUcQNgzOL73MjDpbEfbvZj
	jMIdGIEVBGx9HxnMTMdr57iH3JuReKQ5qazTimdpN91j9UgX7xCQig2YLYVbKRNlWzQ4Zb6oxP6
	rJPBxyolKV46YZdy/FJBbE7Pi4qN6v0naiO8FTbSL/ilUjoRKon2eZXyw04bU+uDlc+J1vxk1We
	IrOwGh6tnfCt5wWUg==
X-Gm-Gg: ASbGncvEvpFqLqYYTizoDH3wPhHpU+TAWBq1ZvfQ153gpGYbRBnTgPAZkq97KOebOPE
	5W3GxHFbAvXm0b622WWRFU5e/a0lDsGjcosmmV+/onK0Ai0ec1TUatIuo4XyOOPPFgU0HjHVRul
	PoQBumwfR+PGB1rhgtI71p5/gc6WY41OrnzfLQ8m8bEB1EhFdE7NK/Bg8FANDQ5znBo9+onIm88
	GSyrgF0AGPmo9B/lEO+E+Ad+1/Ps6J4b2qZNgMuZL4YFKQJZY8S6GVgvmOHsgkdxachwBUR67ln
	2SpIl462yNJ3wTSKWsjUikDDDOAxeXH8FqEMIFGUey2jDX20keaRMc1MdqMhbclZgQHIoQdrJOO
	Q4gOP+9YQ1rmuh5pnHQrmtQQxV3myqciqNOSm9VRGbUi6W3QbgIhGmkj9XJVyNmrxyrrxZ+9H7W
	3t
X-Google-Smtp-Source: AGHT+IHXKaNKRl/mpa7/VUo3i1ca9ssX5JomaVDydNaK/JLGcV+kvdcxgAWuxb3xZ67gbzD24sY/fLICn8xy
X-Received: by 2002:a05:6871:8910:b0:315:b264:f221 with SMTP id 586e51a60fabf-315b264fec8mr1282881fac.24.1756470695728;
        Fri, 29 Aug 2025 05:31:35 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-315afff65a4sm363470fac.23.2025.08.29.05.31.35
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Aug 2025 05:31:35 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7f6a341c9b8so479999385a.2
        for <linux-rdma@vger.kernel.org>; Fri, 29 Aug 2025 05:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756470694; x=1757075494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5v3XO96dQ7iELlwfLpM0O2b8h9cGc26uAv0tYsfkkvI=;
        b=h3c7igohjGu06rp//ZpoB/apETQ1knSpfzp+HwaQ91ivQl8O4OqTQFi+UCWcHWXP7E
         KsnfynYC1zoNeG+u7Ibv9/YvNWUBOiU5+XYmVJ3UON5luERcYFujr6rjB1WWHmn5MdGj
         SRXsYFR4QBsyq2T1OsCgJzIy2ubwDtioBsnnU=
X-Received: by 2002:a05:620a:171f:b0:7e0:6aa7:386 with SMTP id af79cd13be357-7ea10fd9eadmr2966315685a.19.1756470694035;
        Fri, 29 Aug 2025 05:31:34 -0700 (PDT)
X-Received: by 2002:a05:620a:171f:b0:7e0:6aa7:386 with SMTP id af79cd13be357-7ea10fd9eadmr2966309385a.19.1756470693183;
        Fri, 29 Aug 2025 05:31:33 -0700 (PDT)
Received: from sjs-csg-thor3-swe-29.lvn.broadcom.net044broadcom.net ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc16536012sm162384585a.66.2025.08.29.05.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 05:31:32 -0700 (PDT)
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
To: leonro@nvidia.com,
	jgg@nvidia.com
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	vikas.gupta@broadcom.com,
	selvin.xavier@broadcom.com,
	anand.subramanian@broadcom.com,
	Siva Reddy Kallam <siva.kallam@broadcom.com>,
	Usman Ansari <usman.ansari@broadcom.com>
Subject: [PATCH 5/8] RDMA/bng_re: Add infrastructure for enabling Firmware channel
Date: Fri, 29 Aug 2025 12:30:39 +0000
Message-Id: <20250829123042.44459-6-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829123042.44459-1-siva.kallam@broadcom.com>
References: <20250829123042.44459-1-siva.kallam@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Add infrastructure for enabling Firmware channel.

Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
Reviewed-by: Usman Ansari <usman.ansari@broadcom.com>
---
 drivers/infiniband/hw/bng_re/bng_dev.c | 120 +++++++-
 drivers/infiniband/hw/bng_re/bng_fw.c  | 380 ++++++++++++++++++++++++-
 drivers/infiniband/hw/bng_re/bng_fw.h  | 133 ++++++++-
 drivers/infiniband/hw/bng_re/bng_re.h  |  45 +++
 drivers/infiniband/hw/bng_re/bng_res.c |   2 +
 drivers/infiniband/hw/bng_re/bng_res.h | 102 +++++++
 drivers/infiniband/hw/bng_re/bng_tlv.h | 128 +++++++++
 7 files changed, 904 insertions(+), 6 deletions(-)
 create mode 100644 drivers/infiniband/hw/bng_re/bng_tlv.h

diff --git a/drivers/infiniband/hw/bng_re/bng_dev.c b/drivers/infiniband/hw/bng_re/bng_dev.c
index 7f44ebbad69e..937f3cd97c1e 100644
--- a/drivers/infiniband/hw/bng_re/bng_dev.c
+++ b/drivers/infiniband/hw/bng_re/bng_dev.c
@@ -9,10 +9,10 @@
 
 #include "bng_res.h"
 #include "bng_fw.h"
-#include "bng_re.h"
 #include "bnge.h"
-#include "bnge_hwrm.h"
 #include "bnge_auxr.h"
+#include "bng_re.h"
+#include "bnge_hwrm.h"
 
 static char version[] =
 		BNG_RE_DESC "\n";
@@ -105,6 +105,69 @@ static void bng_re_fill_fw_msg(struct bnge_fw_msg *fw_msg, void *msg,
 	fw_msg->timeout = timeout;
 }
 
+static int bng_re_net_ring_free(struct bng_re_dev *rdev,
+				u16 fw_ring_id, int type)
+{
+	struct bnge_auxr_dev *aux_dev = rdev->aux_dev;
+	struct hwrm_ring_free_input req = {};
+	struct hwrm_ring_free_output resp;
+	struct bnge_fw_msg fw_msg = {};
+	int rc = -EINVAL;
+
+	if (!rdev)
+		return rc;
+
+	if (!aux_dev)
+		return rc;
+
+	bng_re_init_hwrm_hdr((void *)&req, HWRM_RING_FREE);
+	req.ring_type = type;
+	req.ring_id = cpu_to_le16(fw_ring_id);
+	bng_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
+			    sizeof(resp), BNGE_DFLT_HWRM_CMD_TIMEOUT);
+	rc = bnge_send_msg(aux_dev, &fw_msg);
+	if (rc)
+		ibdev_err(&rdev->ibdev, "Failed to free HW ring:%d :%#x",
+			  req.ring_id, rc);
+	return rc;
+}
+
+static int bng_re_net_ring_alloc(struct bng_re_dev *rdev,
+				 struct bng_re_ring_attr *ring_attr,
+				 u16 *fw_ring_id)
+{
+	struct bnge_auxr_dev *aux_dev = rdev->aux_dev;
+	struct hwrm_ring_alloc_input req = {};
+	struct hwrm_ring_alloc_output resp;
+	struct bnge_fw_msg fw_msg = {};
+	int rc = -EINVAL;
+
+	if (!aux_dev)
+		return rc;
+
+	bng_re_init_hwrm_hdr((void *)&req, HWRM_RING_ALLOC);
+	req.enables = 0;
+	req.page_tbl_addr =  cpu_to_le64(ring_attr->dma_arr[0]);
+	if (ring_attr->pages > 1) {
+		/* Page size is in log2 units */
+		req.page_size = BNGE_PAGE_SHIFT;
+		req.page_tbl_depth = 1;
+	}
+	req.fbo = 0;
+	/* Association of ring index with doorbell index and MSIX number */
+	req.logical_id = cpu_to_le16(ring_attr->lrid);
+	req.length = cpu_to_le32(ring_attr->depth + 1);
+	req.ring_type = ring_attr->type;
+	req.int_mode = ring_attr->mode;
+	bng_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
+			   sizeof(resp), BNGE_DFLT_HWRM_CMD_TIMEOUT);
+	rc = bnge_send_msg(aux_dev, &fw_msg);
+	if (!rc)
+		*fw_ring_id = le16_to_cpu(resp.ring_id);
+
+	return rc;
+}
+
 static void bng_re_query_hwrm_version(struct bng_re_dev *rdev)
 {
 	struct bnge_auxr_dev *aux_dev = rdev->aux_dev;
@@ -143,7 +206,13 @@ static void bng_re_query_hwrm_version(struct bng_re_dev *rdev)
 
 static void bng_re_dev_uninit(struct bng_re_dev *rdev)
 {
+	bng_re_disable_rcfw_channel(&rdev->rcfw);
+	bng_re_net_ring_free(rdev, rdev->rcfw.creq.ring_id,
+			     RING_ALLOC_REQ_RING_TYPE_NQ);
 	bng_re_free_rcfw_channel(&rdev->rcfw);
+
+	kfree(rdev->nqr);
+	rdev->nqr = NULL;
 	bng_re_destroy_chip_ctx(rdev);
 	if (test_and_clear_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags))
 		bnge_unregister_dev(rdev->aux_dev);
@@ -151,6 +220,11 @@ static void bng_re_dev_uninit(struct bng_re_dev *rdev)
 
 static int bng_re_dev_init(struct bng_re_dev *rdev)
 {
+	struct bng_re_ring_attr rattr = {};
+	struct bng_re_creq_ctx *creq;
+	u32 db_offt;
+	int vid;
+	u8 type;
 	int rc;
 
 	/* Registered a new RoCE device instance to netdev */
@@ -191,8 +265,48 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
 		goto fail;
 	}
 
-	return 0;
+	/* Allocate nq record memory */
+	rdev->nqr = kzalloc(sizeof(*rdev->nqr), GFP_KERNEL);
+	if (!rdev->nqr) {
+		bng_re_destroy_chip_ctx(rdev);
+		bnge_unregister_dev(rdev->aux_dev);
+		clear_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
+		return -ENOMEM;
+	}
 
+	rdev->nqr->num_msix = rdev->aux_dev->auxr_info->msix_requested;
+	memcpy(rdev->nqr->msix_entries, rdev->aux_dev->msix_info,
+	       sizeof(struct bnge_msix_info) * rdev->nqr->num_msix);
+
+	type = RING_ALLOC_REQ_RING_TYPE_NQ;
+	creq = &rdev->rcfw.creq;
+	rattr.dma_arr = creq->hwq.pbl[BNG_PBL_LVL_0].pg_map_arr;
+	rattr.pages = creq->hwq.pbl[creq->hwq.level].pg_count;
+	rattr.type = type;
+	rattr.mode = RING_ALLOC_REQ_INT_MODE_MSIX;
+	rattr.depth = BNG_FW_CREQE_MAX_CNT - 1;
+	rattr.lrid = rdev->nqr->msix_entries[BNG_RE_CREQ_NQ_IDX].ring_idx;
+	rc = bng_re_net_ring_alloc(rdev, &rattr, &creq->ring_id);
+	if (rc) {
+		ibdev_err(&rdev->ibdev, "Failed to allocate CREQ: %#x\n", rc);
+		goto free_rcfw;
+	}
+	db_offt = rdev->nqr->msix_entries[BNG_RE_CREQ_NQ_IDX].db_offset;
+	vid = rdev->nqr->msix_entries[BNG_RE_CREQ_NQ_IDX].vector;
+
+	rc = bng_re_enable_fw_channel(&rdev->rcfw,
+					vid, db_offt);
+	if (rc) {
+		ibdev_err(&rdev->ibdev, "Failed to enable RCFW channel: %#x\n",
+			  rc);
+		goto free_ring;
+	}
+
+	return 0;
+free_ring:
+	bng_re_net_ring_free(rdev, rdev->rcfw.creq.ring_id, type);
+free_rcfw:
+	bng_re_free_rcfw_channel(&rdev->rcfw);
 fail:
 	bng_re_dev_uninit(rdev);
 	return rc;
diff --git a/drivers/infiniband/hw/bng_re/bng_fw.c b/drivers/infiniband/hw/bng_re/bng_fw.c
index bf7bbcf9b56e..2bc697e40837 100644
--- a/drivers/infiniband/hw/bng_re/bng_fw.c
+++ b/drivers/infiniband/hw/bng_re/bng_fw.c
@@ -2,6 +2,7 @@
 // Copyright (c) 2025 Broadcom.
 #include <linux/pci.h>
 
+#include "roce_hsi.h"
 #include "bng_res.h"
 #include "bng_fw.h"
 
@@ -61,10 +62,387 @@ int bng_re_alloc_fw_channel(struct bng_re_res *res,
 	spin_lock_init(&rcfw->tbl_lock);
 
 	rcfw->max_timeout = res->cctx->hwrm_cmd_max_timeout;
-
 	return 0;
 
 fail:
 	bng_re_free_rcfw_channel(rcfw);
 	return -ENOMEM;
 }
+
+static int bng_re_process_qp_event(struct bng_re_rcfw *rcfw,
+				   struct creq_qp_event *qp_event,
+				   u32 *num_wait)
+{
+	struct bng_re_hwq *hwq = &rcfw->cmdq.hwq;
+	struct bng_re_crsqe *crsqe;
+	u32 req_size;
+	u16 cookie;
+	bool is_waiter_alive;
+	struct pci_dev *pdev;
+	u32 wait_cmds = 0;
+	int rc = 0;
+
+	pdev = rcfw->pdev;
+	switch (qp_event->event) {
+	case CREQ_QP_EVENT_EVENT_QP_ERROR_NOTIFICATION:
+		dev_err(&pdev->dev, "Received QP error notification\n");
+		break;
+	default:
+		/*
+		 * Command Response
+		 * cmdq->lock needs to be acquired to synchronie
+		 * the command send and completion reaping. This function
+		 * is always called with creq->lock held. Using
+		 * the nested variant of spin_lock.
+		 *
+		 */
+
+		spin_lock_nested(&hwq->lock, SINGLE_DEPTH_NESTING);
+		cookie = le16_to_cpu(qp_event->cookie);
+		cookie &= BNG_FW_MAX_COOKIE_VALUE;
+		crsqe = &rcfw->crsqe_tbl[cookie];
+
+		if (WARN_ONCE(test_bit(FIRMWARE_STALL_DETECTED,
+				       &rcfw->cmdq.flags),
+		    "Unreponsive rcfw channel detected.!!")) {
+			dev_info(&pdev->dev,
+				 "rcfw timedout: cookie = %#x, free_slots = %d",
+				 cookie, crsqe->free_slots);
+			spin_unlock(&hwq->lock);
+			return rc;
+		}
+
+		if (crsqe->is_waiter_alive) {
+			if (crsqe->resp) {
+				memcpy(crsqe->resp, qp_event, sizeof(*qp_event));
+				/* Insert write memory barrier to ensure that
+				 * response data is copied before clearing the
+				 * flags
+				 */
+				smp_wmb();
+			}
+		}
+
+		wait_cmds++;
+
+		req_size = crsqe->req_size;
+		is_waiter_alive = crsqe->is_waiter_alive;
+
+		crsqe->req_size = 0;
+		if (!is_waiter_alive)
+			crsqe->resp = NULL;
+
+		crsqe->is_in_used = false;
+
+		hwq->cons += req_size;
+
+		spin_unlock(&hwq->lock);
+	}
+	*num_wait += wait_cmds;
+	return rc;
+}
+
+/* function events */
+static int bng_re_process_func_event(struct bng_re_rcfw *rcfw,
+				     struct creq_func_event *func_event)
+{
+	int rc;
+
+	switch (func_event->event) {
+	case CREQ_FUNC_EVENT_EVENT_TX_WQE_ERROR:
+		break;
+	case CREQ_FUNC_EVENT_EVENT_TX_DATA_ERROR:
+		break;
+	case CREQ_FUNC_EVENT_EVENT_RX_WQE_ERROR:
+		break;
+	case CREQ_FUNC_EVENT_EVENT_RX_DATA_ERROR:
+		break;
+	case CREQ_FUNC_EVENT_EVENT_CQ_ERROR:
+		break;
+	case CREQ_FUNC_EVENT_EVENT_TQM_ERROR:
+		break;
+	case CREQ_FUNC_EVENT_EVENT_CFCQ_ERROR:
+		break;
+	case CREQ_FUNC_EVENT_EVENT_CFCS_ERROR:
+		/* SRQ ctx error, call srq_handler??
+		 * But there's no SRQ handle!
+		 */
+		break;
+	case CREQ_FUNC_EVENT_EVENT_CFCC_ERROR:
+		break;
+	case CREQ_FUNC_EVENT_EVENT_CFCM_ERROR:
+		break;
+	case CREQ_FUNC_EVENT_EVENT_TIM_ERROR:
+		break;
+	case CREQ_FUNC_EVENT_EVENT_VF_COMM_REQUEST:
+		break;
+	case CREQ_FUNC_EVENT_EVENT_RESOURCE_EXHAUSTED:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return rc;
+}
+
+
+
+/* CREQ Completion handlers */
+static void bng_re_service_creq(struct tasklet_struct *t)
+{
+	struct bng_re_rcfw *rcfw = from_tasklet(rcfw, t, creq.creq_tasklet);
+	struct bng_re_creq_ctx *creq = &rcfw->creq;
+	u32 type, budget = BNG_FW_CREQ_ENTRY_POLL_BUDGET;
+	struct bng_re_hwq *hwq = &creq->hwq;
+	struct creq_base *creqe;
+	u32 num_wakeup = 0;
+	u32 hw_polled = 0;
+
+	/* Service the CREQ until budget is over */
+	spin_lock_bh(&hwq->lock);
+	while (budget > 0) {
+		creqe = bng_re_get_qe(hwq, hwq->cons, NULL);
+		if (!BNG_FW_CREQ_CMP_VALID(creqe, creq->creq_db.dbinfo.flags))
+			break;
+		/* The valid test of the entry must be done first before
+		 * reading any further.
+		 */
+		dma_rmb();
+
+		type = creqe->type & CREQ_BASE_TYPE_MASK;
+		switch (type) {
+		case CREQ_BASE_TYPE_QP_EVENT:
+			bng_re_process_qp_event
+				(rcfw, (struct creq_qp_event *)creqe,
+				 &num_wakeup);
+			creq->stats.creq_qp_event_processed++;
+			break;
+		case CREQ_BASE_TYPE_FUNC_EVENT:
+			if (!bng_re_process_func_event
+			    (rcfw, (struct creq_func_event *)creqe))
+				creq->stats.creq_func_event_processed++;
+			else
+				dev_warn(&rcfw->pdev->dev,
+					 "aeqe:%#x Not handled\n", type);
+			break;
+		default:
+			if (type != ASYNC_EVENT_CMPL_TYPE_HWRM_ASYNC_EVENT)
+				dev_warn(&rcfw->pdev->dev,
+					 "creqe with event 0x%x not handled\n",
+					 type);
+			break;
+		}
+		budget--;
+		hw_polled++;
+		bng_re_hwq_incr_cons(hwq->max_elements, &hwq->cons,
+				     1, &creq->creq_db.dbinfo.flags);
+	}
+
+	if (hw_polled)
+		bng_re_ring_nq_db(&creq->creq_db.dbinfo,
+				  rcfw->res->cctx, true);
+	spin_unlock_bh(&hwq->lock);
+	if (num_wakeup)
+		wake_up_nr(&rcfw->cmdq.waitq, num_wakeup);
+}
+
+static int bng_re_map_cmdq_mbox(struct bng_re_rcfw *rcfw)
+{
+	struct bng_re_cmdq_mbox *mbox;
+	resource_size_t bar_reg;
+	struct pci_dev *pdev;
+
+	pdev = rcfw->pdev;
+	mbox = &rcfw->cmdq.cmdq_mbox;
+
+	mbox->reg.bar_id = BNG_FW_COMM_PCI_BAR_REGION;
+	mbox->reg.len = BNG_FW_COMM_SIZE;
+	mbox->reg.bar_base = pci_resource_start(pdev, mbox->reg.bar_id);
+	if (!mbox->reg.bar_base) {
+		dev_err(&pdev->dev,
+			"CMDQ BAR region %d resc start is 0!\n",
+			mbox->reg.bar_id);
+		return -ENOMEM;
+	}
+
+	bar_reg = mbox->reg.bar_base + BNG_FW_COMM_BASE_OFFSET;
+	mbox->reg.len = BNG_FW_COMM_SIZE;
+	mbox->reg.bar_reg = ioremap(bar_reg, mbox->reg.len);
+	if (!mbox->reg.bar_reg) {
+		dev_err(&pdev->dev,
+			"CMDQ BAR region %d mapping failed\n",
+			mbox->reg.bar_id);
+		return -ENOMEM;
+	}
+
+	mbox->prod = (void  __iomem *)(mbox->reg.bar_reg +
+			BNG_FW_PF_VF_COMM_PROD_OFFSET);
+	mbox->db = (void __iomem *)(mbox->reg.bar_reg + BNG_FW_COMM_TRIG_OFFSET);
+	return 0;
+}
+
+static irqreturn_t bng_re_creq_irq(int irq, void *dev_instance)
+{
+	struct bng_re_rcfw *rcfw = dev_instance;
+	struct bng_re_creq_ctx *creq;
+	struct bng_re_hwq *hwq;
+	u32 sw_cons;
+
+	creq = &rcfw->creq;
+	hwq = &creq->hwq;
+	/* Prefetch the CREQ element */
+	sw_cons = HWQ_CMP(hwq->cons, hwq);
+	prefetch(bng_re_get_qe(hwq, sw_cons, NULL));
+
+	tasklet_schedule(&creq->creq_tasklet);
+
+	return IRQ_HANDLED;
+}
+
+int bng_re_rcfw_start_irq(struct bng_re_rcfw *rcfw, int msix_vector,
+			  bool need_init)
+{
+	struct bng_re_creq_ctx *creq;
+	struct bng_re_res *res;
+	int rc;
+
+	creq = &rcfw->creq;
+	res = rcfw->res;
+
+	if (creq->irq_handler_avail)
+		return -EFAULT;
+
+	creq->msix_vec = msix_vector;
+	if (need_init)
+		tasklet_setup(&creq->creq_tasklet, bng_re_service_creq);
+	else
+		tasklet_enable(&creq->creq_tasklet);
+
+	creq->irq_name = kasprintf(GFP_KERNEL, "bng_re-creq@pci:%s",
+				   pci_name(res->pdev));
+	if (!creq->irq_name)
+		return -ENOMEM;
+	rc = request_irq(creq->msix_vec, bng_re_creq_irq, 0,
+			 creq->irq_name, rcfw);
+	if (rc) {
+		kfree(creq->irq_name);
+		creq->irq_name = NULL;
+		tasklet_disable(&creq->creq_tasklet);
+		return rc;
+	}
+	creq->irq_handler_avail = true;
+
+	bng_re_ring_nq_db(&creq->creq_db.dbinfo, res->cctx, true);
+	atomic_inc(&rcfw->rcfw_intr_enabled);
+
+	return 0;
+}
+
+static int bng_re_map_creq_db(struct bng_re_rcfw *rcfw, u32 reg_offt)
+{
+	struct bng_re_creq_db *creq_db;
+	resource_size_t bar_reg;
+	struct pci_dev *pdev;
+
+	pdev = rcfw->pdev;
+	creq_db = &rcfw->creq.creq_db;
+
+	creq_db->dbinfo.flags = 0;
+	creq_db->reg.bar_id = BNG_FW_COMM_CONS_PCI_BAR_REGION;
+	creq_db->reg.bar_base = pci_resource_start(pdev, creq_db->reg.bar_id);
+	if (!creq_db->reg.bar_id)
+		dev_err(&pdev->dev,
+			"CREQ BAR region %d resc start is 0!",
+			creq_db->reg.bar_id);
+
+	bar_reg = creq_db->reg.bar_base + reg_offt;
+
+	creq_db->reg.len = BNG_FW_CREQ_DB_LEN;
+	creq_db->reg.bar_reg = ioremap(bar_reg, creq_db->reg.len);
+	if (!creq_db->reg.bar_reg) {
+		dev_err(&pdev->dev,
+			"CREQ BAR region %d mapping failed",
+			creq_db->reg.bar_id);
+		return -ENOMEM;
+	}
+	creq_db->dbinfo.db = creq_db->reg.bar_reg;
+	creq_db->dbinfo.hwq = &rcfw->creq.hwq;
+	creq_db->dbinfo.xid = rcfw->creq.ring_id;
+	return 0;
+}
+
+void bng_re_rcfw_stop_irq(struct bng_re_rcfw *rcfw, bool kill)
+{
+	struct bng_re_creq_ctx *creq;
+
+	creq = &rcfw->creq;
+
+	if (!creq->irq_handler_avail)
+		return;
+
+	creq->irq_handler_avail = false;
+	/* Mask h/w interrupts */
+	bng_re_ring_nq_db(&creq->creq_db.dbinfo, rcfw->res->cctx, false);
+	/* Sync with last running IRQ-handler */
+	synchronize_irq(creq->msix_vec);
+	free_irq(creq->msix_vec, rcfw);
+	kfree(creq->irq_name);
+	creq->irq_name = NULL;
+	atomic_set(&rcfw->rcfw_intr_enabled, 0);
+	if (kill)
+		tasklet_kill(&creq->creq_tasklet);
+	tasklet_disable(&creq->creq_tasklet);
+}
+
+void bng_re_disable_rcfw_channel(struct bng_re_rcfw *rcfw)
+{
+	struct bng_re_creq_ctx *creq;
+	struct bng_re_cmdq_ctx *cmdq;
+
+	creq = &rcfw->creq;
+	cmdq = &rcfw->cmdq;
+	/* Make sure the HW channel is stopped! */
+	bng_re_rcfw_stop_irq(rcfw, true);
+
+	iounmap(cmdq->cmdq_mbox.reg.bar_reg);
+	iounmap(creq->creq_db.reg.bar_reg);
+
+	cmdq->cmdq_mbox.reg.bar_reg = NULL;
+	creq->creq_db.reg.bar_reg = NULL;
+	creq->msix_vec = 0;
+}
+
+int bng_re_enable_fw_channel(struct bng_re_rcfw *rcfw,
+			     int msix_vector,
+			     int cp_bar_reg_off)
+{
+	struct bng_re_cmdq_ctx *cmdq;
+	struct bng_re_creq_ctx *creq;
+	int rc;
+
+	cmdq = &rcfw->cmdq;
+	creq = &rcfw->creq;
+
+	/* Assign defaults */
+	cmdq->seq_num = 0;
+	set_bit(FIRMWARE_FIRST_FLAG, &cmdq->flags);
+	init_waitqueue_head(&cmdq->waitq);
+
+	rc = bng_re_map_cmdq_mbox(rcfw);
+	if (rc)
+		return rc;
+
+	rc = bng_re_map_creq_db(rcfw, cp_bar_reg_off);
+	if (rc)
+		return rc;
+
+	rc = bng_re_rcfw_start_irq(rcfw, msix_vector, true);
+	if (rc) {
+		dev_err(&rcfw->pdev->dev,
+			"Failed to request IRQ for CREQ rc = 0x%x\n", rc);
+		bng_re_disable_rcfw_channel(rcfw);
+		return rc;
+	}
+
+	return 0;
+}
diff --git a/drivers/infiniband/hw/bng_re/bng_fw.h b/drivers/infiniband/hw/bng_re/bng_fw.h
index 351f73baa9df..d1773832b592 100644
--- a/drivers/infiniband/hw/bng_re/bng_fw.h
+++ b/drivers/infiniband/hw/bng_re/bng_fw.h
@@ -4,9 +4,26 @@
 #ifndef __BNG_FW_H__
 #define __BNG_FW_H__
 
+#include "bng_tlv.h"
+
+/* FW DB related */
+#define BNG_FW_CMDQ_TRIG_VAL		1
+#define BNG_FW_COMM_PCI_BAR_REGION	0
+#define BNG_FW_COMM_CONS_PCI_BAR_REGION	2
+#define BNG_FW_COMM_SIZE		0x104
+#define BNG_FW_COMM_BASE_OFFSET		0x600
+#define BNG_FW_COMM_TRIG_OFFSET		0x100
+#define BNG_FW_PF_VF_COMM_PROD_OFFSET	0xc
+#define BNG_FW_CREQ_DB_LEN		8
+
 /* CREQ */
-#define BNG_FW_CREQE_MAX_CNT	(64 * 1024)
-#define BNG_FW_CREQE_UNITS	16
+#define BNG_FW_CREQE_MAX_CNT		(64 * 1024)
+#define BNG_FW_CREQE_UNITS		16
+#define BNG_FW_CREQ_ENTRY_POLL_BUDGET	0x100
+#define BNG_FW_CREQ_CMP_VALID(hdr, pass)			\
+	(!!((hdr)->v & CREQ_BASE_V) ==				\
+	   !((pass) & BNG_RE_FLAG_EPOCH_CONS_MASK))
+#define BNG_FW_CREQ_ENTRY_POLL_BUDGET	0x100
 
 /* CMDQ */
 struct bng_fw_cmdqe {
@@ -17,6 +34,15 @@ struct bng_fw_cmdqe {
 #define BNG_FW_CMDQE_UNITS		sizeof(struct bng_fw_cmdqe)
 #define BNG_FW_CMDQE_BYTES(depth)	((depth) * BNG_FW_CMDQE_UNITS)
 
+#define BNG_FW_MAX_COOKIE_VALUE		(BNG_FW_CMDQE_MAX_CNT - 1)
+#define BNG_FW_CMD_IS_BLOCKING		0x8000
+
+/* Crsq buf is 1024-Byte */
+struct bng_re_crsbe {
+	u8			data[1024];
+};
+
+
 static inline u32 bng_fw_cmdqe_npages(u32 depth)
 {
 	u32 npages;
@@ -31,14 +57,43 @@ static inline u32 bng_fw_cmdqe_page_size(u32 depth)
 {
 	return (bng_fw_cmdqe_npages(depth) * PAGE_SIZE);
 }
+struct bng_re_cmdq_mbox {
+	struct bng_re_reg_desc		reg;
+	void __iomem			*prod;
+	void __iomem			*db;
+};
 
 /* HWQ */
 struct bng_re_cmdq_ctx {
 	struct bng_re_hwq		hwq;
+	struct bng_re_cmdq_mbox		cmdq_mbox;
+	unsigned long			flags;
+#define FIRMWARE_INITIALIZED_FLAG	(0)
+#define FIRMWARE_STALL_DETECTED		(3)
+#define FIRMWARE_FIRST_FLAG		(31)
+	wait_queue_head_t		waitq;
+	u32				seq_num;
+};
+
+struct bng_re_creq_db {
+	struct bng_re_reg_desc	reg;
+	struct bng_re_db_info	dbinfo;
+};
+
+struct bng_re_creq_stat {
+	u64	creq_qp_event_processed;
+	u64	creq_func_event_processed;
 };
 
 struct bng_re_creq_ctx {
 	struct bng_re_hwq		hwq;
+	struct bng_re_creq_db		creq_db;
+	struct bng_re_creq_stat		stats;
+	struct tasklet_struct		creq_tasklet;
+	u16				ring_id;
+	int				msix_vec;
+	bool				irq_handler_avail;
+	char				*irq_name;
 };
 
 struct bng_re_crsqe {
@@ -47,6 +102,14 @@ struct bng_re_crsqe {
 	/* Free slots at the time of submission */
 	u32			free_slots;
 	u8			opcode;
+	bool			is_waiter_alive;
+	bool			is_in_used;
+};
+
+struct bng_re_rcfw_sbuf {
+	void *sb;
+	dma_addr_t dma_addr;
+	u32 size;
 };
 
 /* RoCE FW Communication Channels */
@@ -61,9 +124,75 @@ struct bng_re_rcfw {
 	u32			cmdq_depth;
 	/* cached from chip cctx for quick reference in slow path */
 	u16			max_timeout;
+	atomic_t		rcfw_intr_enabled;
+};
+
+struct bng_re_cmdqmsg {
+	struct cmdq_base	*req;
+	struct creq_base	*resp;
+	void			*sb;
+	u32			req_sz;
+	u32			res_sz;
+	u8			block;
 };
 
+static inline void bng_re_fill_cmdqmsg(struct bng_re_cmdqmsg *msg,
+				       void *req, void *resp, void *sb,
+				       u32 req_sz, u32 res_sz, u8 block)
+{
+	msg->req = req;
+	msg->resp = resp;
+	msg->sb = sb;
+	msg->req_sz = req_sz;
+	msg->res_sz = res_sz;
+	msg->block = block;
+}
+
+/* Get the number of command units required for the req. The
+ * function returns correct value only if called before
+ * setting using bng_re_set_cmd_slots
+ */
+static inline u32 bng_re_get_cmd_slots(struct cmdq_base *req)
+{
+	u32 cmd_units = 0;
+
+	if (HAS_TLV_HEADER(req)) {
+		struct roce_tlv *tlv_req = (struct roce_tlv *)req;
+
+		cmd_units = tlv_req->total_size;
+	} else {
+		cmd_units = (req->cmd_size + BNG_FW_CMDQE_UNITS - 1) /
+			    BNG_FW_CMDQE_UNITS;
+	}
+
+	return cmd_units;
+}
+
+static inline u32 bng_re_set_cmd_slots(struct cmdq_base *req)
+{
+	u32 cmd_byte = 0;
+
+	if (HAS_TLV_HEADER(req)) {
+		struct roce_tlv *tlv_req = (struct roce_tlv *)req;
+
+		cmd_byte = tlv_req->total_size * BNG_FW_CMDQE_UNITS;
+	} else {
+		cmd_byte = req->cmd_size;
+		req->cmd_size = (req->cmd_size + BNG_FW_CMDQE_UNITS - 1) /
+				 BNG_FW_CMDQE_UNITS;
+	}
+
+	return cmd_byte;
+}
+
 void bng_re_free_rcfw_channel(struct bng_re_rcfw *rcfw);
 int bng_re_alloc_fw_channel(struct bng_re_res *res,
 			    struct bng_re_rcfw *rcfw);
+int bng_re_enable_fw_channel(struct bng_re_rcfw *rcfw,
+			     int msix_vector,
+			     int cp_bar_reg_off);
+void bng_re_disable_rcfw_channel(struct bng_re_rcfw *rcfw);
+int bng_re_rcfw_start_irq(struct bng_re_rcfw *rcfw, int msix_vector,
+			  bool need_init);
+void bng_re_rcfw_stop_irq(struct bng_re_rcfw *rcfw, bool kill);
 #endif
diff --git a/drivers/infiniband/hw/bng_re/bng_re.h b/drivers/infiniband/hw/bng_re/bng_re.h
index 18f80e2a1a46..033ca94d5164 100644
--- a/drivers/infiniband/hw/bng_re/bng_re.h
+++ b/drivers/infiniband/hw/bng_re/bng_re.h
@@ -4,6 +4,8 @@
 #ifndef __BNG_RE_H__
 #define __BNG_RE_H__
 
+#include "bng_res.h"
+
 #define BNG_ROCE_DRV_MODULE_NAME	"bng_re"
 #define BNG_RE_ADEV_NAME		"bng_en"
 
@@ -12,12 +14,54 @@
 #define	rdev_to_dev(rdev)	((rdev) ? (&(rdev)->ibdev.dev) : NULL)
 
 #define BNG_RE_MIN_MSIX		2
+#define BNG_RE_MAX_MSIX		BNGE_MAX_ROCE_MSIX
+
+#define BNG_RE_CREQ_NQ_IDX	0
+/* NQ specific structures  */
+struct bng_re_nq_db {
+	struct bng_re_reg_desc	reg;
+	struct bng_re_db_info	dbinfo;
+};
+
+struct bng_re_nq {
+	struct pci_dev			*pdev;
+	struct bng_re_res		*res;
+	char				*name;
+	struct bng_re_hwq		hwq;
+	struct bng_re_nq_db		nq_db;
+	u16				ring_id;
+	int				msix_vec;
+	cpumask_t			mask;
+	struct tasklet_struct		nq_tasklet;
+	bool				requested;
+	int				budget;
+	u32				load;
+
+	struct workqueue_struct		*cqn_wq;
+};
+
+struct bng_re_nq_record {
+	struct bnge_msix_info	msix_entries[BNG_RE_MAX_MSIX];
+	struct bng_re_nq	nq[BNG_RE_MAX_MSIX];
+	int			num_msix;
+	/* serialize NQ access */
+	struct mutex		load_lock;
+};
 
 struct bng_re_en_dev_info {
 	struct bng_re_dev *rdev;
 	struct bnge_auxr_dev *auxr_dev;
 };
 
+struct bng_re_ring_attr {
+	dma_addr_t	*dma_arr;
+	int		pages;
+	int		type;
+	u32		depth;
+	u32		lrid; /* Logical ring id */
+	u8		mode;
+};
+
 struct bng_re_dev {
 	struct ib_device		ibdev;
 	unsigned long			flags;
@@ -29,6 +73,7 @@ struct bng_re_dev {
 	int				fn_id;
 	struct bng_re_res		bng_res;
 	struct bng_re_rcfw		rcfw;
+	struct bng_re_nq_record		*nqr;
 };
 
 #endif
diff --git a/drivers/infiniband/hw/bng_re/bng_res.c b/drivers/infiniband/hw/bng_re/bng_res.c
index 2119d1f39b65..cb42c0fd2cdf 100644
--- a/drivers/infiniband/hw/bng_re/bng_res.c
+++ b/drivers/infiniband/hw/bng_re/bng_res.c
@@ -5,6 +5,7 @@
 #include <linux/vmalloc.h>
 #include <rdma/ib_umem.h>
 
+#include <linux/bnxt/hsi.h>
 #include "bng_res.h"
 #include "roce_hsi.h"
 
@@ -235,6 +236,7 @@ int bng_re_alloc_init_hwq(struct bng_re_hwq *hwq,
 	hwq->depth = hwq_attr->depth;
 	hwq->max_elements = hwq->depth;
 	hwq->element_size = stride;
+	hwq->qe_ppg = pg_size / stride;
 	/* For direct access to the elements */
 	lvl = hwq->level;
 	if (hwq_attr->sginfo->nopte && hwq->level)
diff --git a/drivers/infiniband/hw/bng_re/bng_res.h b/drivers/infiniband/hw/bng_re/bng_res.h
index e6123abadfad..f40f3477125f 100644
--- a/drivers/infiniband/hw/bng_re/bng_res.h
+++ b/drivers/infiniband/hw/bng_re/bng_res.h
@@ -4,6 +4,8 @@
 #ifndef __BNG_RES_H__
 #define __BNG_RES_H__
 
+#include "roce_hsi.h"
+
 #define BNG_ROCE_FW_MAX_TIMEOUT	60
 
 #define PTR_CNT_PER_PG		(PAGE_SIZE / sizeof(void *))
@@ -11,6 +13,12 @@
 #define PTR_PG(x)		(((x) & ~PTR_MAX_IDX_PER_PG) / PTR_CNT_PER_PG)
 #define PTR_IDX(x)		((x) & PTR_MAX_IDX_PER_PG)
 
+#define HWQ_CMP(idx, hwq)	((idx) & ((hwq)->max_elements - 1))
+#define HWQ_FREE_SLOTS(hwq)	(hwq->max_elements - \
+				((HWQ_CMP(hwq->prod, hwq)\
+				- HWQ_CMP(hwq->cons, hwq))\
+				& (hwq->max_elements - 1)))
+
 #define MAX_PBL_LVL_0_PGS		1
 #define MAX_PBL_LVL_1_PGS		512
 #define MAX_PBL_LVL_1_PGS_SHIFT		9
@@ -18,6 +26,41 @@
 #define MAX_PBL_LVL_2_PGS		(256 * 512)
 #define MAX_PDL_LVL_SHIFT               9
 
+#define BNG_RE_DBR_VALID		(0x1UL << 26)
+#define BNG_RE_DBR_EPOCH_SHIFT	24
+#define BNG_RE_DBR_TOGGLE_SHIFT	25
+
+
+struct bng_re_reg_desc {
+	u8		bar_id;
+	resource_size_t	bar_base;
+	unsigned long	offset;
+	void __iomem	*bar_reg;
+	size_t		len;
+};
+
+struct bng_re_db_info {
+	void __iomem		*db;
+	void __iomem		*priv_db;
+	struct bng_re_hwq	*hwq;
+	u32			xid;
+	u32			max_slot;
+	u32                     flags;
+	u8			toggle;
+};
+
+enum bng_re_db_info_flags_mask {
+	BNG_RE_FLAG_EPOCH_CONS_SHIFT        = 0x0UL,
+	BNG_RE_FLAG_EPOCH_PROD_SHIFT        = 0x1UL,
+	BNG_RE_FLAG_EPOCH_CONS_MASK         = 0x1UL,
+	BNG_RE_FLAG_EPOCH_PROD_MASK         = 0x2UL,
+};
+
+enum bng_re_db_epoch_flag_shift {
+	BNG_RE_DB_EPOCH_CONS_SHIFT  = BNG_RE_DBR_EPOCH_SHIFT,
+	BNG_RE_DB_EPOCH_PROD_SHIFT  = (BNG_RE_DBR_EPOCH_SHIFT - 1),
+};
+
 struct bng_re_chip_ctx {
 	u16	chip_num;
 	u16	hw_stats_size;
@@ -77,6 +120,8 @@ struct bng_re_hwq {
 	u16				element_size;
 	u32				prod;
 	u32				cons;
+	/* queue entry per page */
+	u16				qe_ppg;
 };
 
 struct bng_re_res {
@@ -84,6 +129,63 @@ struct bng_re_res {
 	struct bng_re_chip_ctx		*cctx;
 };
 
+static inline void *bng_re_get_qe(struct bng_re_hwq *hwq,
+				  u32 indx, u64 *pg)
+{
+	u32 pg_num, pg_idx;
+
+	pg_num = (indx / hwq->qe_ppg);
+	pg_idx = (indx % hwq->qe_ppg);
+	if (pg)
+		*pg = (u64)&hwq->pbl_ptr[pg_num];
+	return (void *)(hwq->pbl_ptr[pg_num] + hwq->element_size * pg_idx);
+}
+
+#define BNG_RE_INIT_DBHDR(xid, type, indx, toggle) \
+	(((u64)(((xid) & DBC_DBC_XID_MASK) | DBC_DBC_PATH_ROCE |  \
+		(type) | BNG_RE_DBR_VALID) << 32) | (indx) |  \
+	 (((u32)(toggle)) << (BNG_RE_DBR_TOGGLE_SHIFT)))
+
+static inline void bng_re_ring_db(struct bng_re_db_info *info,
+				  u32 type)
+{
+	u64 key = 0;
+	u32 indx;
+	u8 toggle = 0;
+
+	if (type == DBC_DBC_TYPE_CQ_ARMALL ||
+	    type == DBC_DBC_TYPE_CQ_ARMSE)
+		toggle = info->toggle;
+
+	indx = (info->hwq->cons & DBC_DBC_INDEX_MASK) |
+	       ((info->flags & BNG_RE_FLAG_EPOCH_CONS_MASK) <<
+		 BNG_RE_DB_EPOCH_CONS_SHIFT);
+
+	key =  BNG_RE_INIT_DBHDR(info->xid, type, indx, toggle);
+	writeq(key, info->db);
+}
+
+static inline void bng_re_ring_nq_db(struct bng_re_db_info *info,
+				     struct bng_re_chip_ctx *cctx,
+				     bool arm)
+{
+	u32 type;
+
+	type = arm ? DBC_DBC_TYPE_NQ_ARM : DBC_DBC_TYPE_NQ;
+	bng_re_ring_db(info, type);
+}
+
+static inline void bng_re_hwq_incr_cons(u32 max_elements, u32 *cons, u32 cnt,
+					u32 *dbinfo_flags)
+{
+	/* move cons and update toggle/epoch if wrap around */
+	*cons += cnt;
+	if (*cons >= max_elements) {
+		*cons %= max_elements;
+		*dbinfo_flags ^= 1UL << BNG_RE_FLAG_EPOCH_CONS_SHIFT;
+	}
+}
+
 void bng_re_free_hwq(struct bng_re_res *res,
 		     struct bng_re_hwq *hwq);
 
diff --git a/drivers/infiniband/hw/bng_re/bng_tlv.h b/drivers/infiniband/hw/bng_re/bng_tlv.h
new file mode 100644
index 000000000000..278f4922962d
--- /dev/null
+++ b/drivers/infiniband/hw/bng_re/bng_tlv.h
@@ -0,0 +1,128 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+
+#ifndef __BNG_TLV_H__
+#define __BNG_TLV_H__
+
+#include "roce_hsi.h"
+
+struct roce_tlv {
+	struct tlv tlv;
+	u8 total_size; // in units of 16 byte chunks
+	u8 unused[7];  // for 16 byte alignment
+};
+
+/*
+ * TLV size in units of 16 byte chunks
+ */
+#define TLV_SIZE ((sizeof(struct roce_tlv) + 15) / 16)
+/*
+ * TLV length in bytes
+ */
+#define TLV_BYTES (TLV_SIZE * 16)
+
+#define HAS_TLV_HEADER(msg) (le16_to_cpu(((struct tlv *)(msg))->cmd_discr) == CMD_DISCR_TLV_ENCAP)
+#define GET_TLV_DATA(tlv)   ((void *)&((uint8_t *)(tlv))[TLV_BYTES])
+
+static inline u8 __get_cmdq_base_opcode(struct cmdq_base *req, u32 size)
+{
+	if (HAS_TLV_HEADER(req) && size > TLV_BYTES)
+		return ((struct cmdq_base *)GET_TLV_DATA(req))->opcode;
+	else
+		return req->opcode;
+}
+
+static inline void __set_cmdq_base_opcode(struct cmdq_base *req,
+					  u32 size, u8 val)
+{
+	if (HAS_TLV_HEADER(req) && size > TLV_BYTES)
+		((struct cmdq_base *)GET_TLV_DATA(req))->opcode = val;
+	else
+		req->opcode = val;
+}
+
+static inline __le16 __get_cmdq_base_cookie(struct cmdq_base *req, u32 size)
+{
+	if (HAS_TLV_HEADER(req) && size > TLV_BYTES)
+		return ((struct cmdq_base *)GET_TLV_DATA(req))->cookie;
+	else
+		return req->cookie;
+}
+
+static inline void __set_cmdq_base_cookie(struct cmdq_base *req,
+					  u32 size, __le16 val)
+{
+	if (HAS_TLV_HEADER(req) && size > TLV_BYTES)
+		((struct cmdq_base *)GET_TLV_DATA(req))->cookie = val;
+	else
+		req->cookie = val;
+}
+
+static inline __le64 __get_cmdq_base_resp_addr(struct cmdq_base *req, u32 size)
+{
+	if (HAS_TLV_HEADER(req) && size > TLV_BYTES)
+		return ((struct cmdq_base *)GET_TLV_DATA(req))->resp_addr;
+	else
+		return req->resp_addr;
+}
+
+static inline void __set_cmdq_base_resp_addr(struct cmdq_base *req,
+					     u32 size, __le64 val)
+{
+	if (HAS_TLV_HEADER(req) && size > TLV_BYTES)
+		((struct cmdq_base *)GET_TLV_DATA(req))->resp_addr = val;
+	else
+		req->resp_addr = val;
+}
+
+static inline u8 __get_cmdq_base_resp_size(struct cmdq_base *req, u32 size)
+{
+	if (HAS_TLV_HEADER(req) && size > TLV_BYTES)
+		return ((struct cmdq_base *)GET_TLV_DATA(req))->resp_size;
+	else
+		return req->resp_size;
+}
+
+static inline void __set_cmdq_base_resp_size(struct cmdq_base *req,
+					     u32 size, u8 val)
+{
+	if (HAS_TLV_HEADER(req) && size > TLV_BYTES)
+		((struct cmdq_base *)GET_TLV_DATA(req))->resp_size = val;
+	else
+		req->resp_size = val;
+}
+
+static inline u8 __get_cmdq_base_cmd_size(struct cmdq_base *req, u32 size)
+{
+	if (HAS_TLV_HEADER(req) && size > TLV_BYTES)
+		return ((struct roce_tlv *)(req))->total_size;
+	else
+		return req->cmd_size;
+}
+
+static inline void __set_cmdq_base_cmd_size(struct cmdq_base *req,
+					    u32 size, u8 val)
+{
+	if (HAS_TLV_HEADER(req) && size > TLV_BYTES)
+		((struct cmdq_base *)GET_TLV_DATA(req))->cmd_size = val;
+	else
+		req->cmd_size = val;
+}
+
+static inline __le16 __get_cmdq_base_flags(struct cmdq_base *req, u32 size)
+{
+	if (HAS_TLV_HEADER(req) && size > TLV_BYTES)
+		return ((struct cmdq_base *)GET_TLV_DATA(req))->flags;
+	else
+		return req->flags;
+}
+
+static inline void __set_cmdq_base_flags(struct cmdq_base *req,
+					 u32 size, __le16 val)
+{
+	if (HAS_TLV_HEADER(req) && size > TLV_BYTES)
+		((struct cmdq_base *)GET_TLV_DATA(req))->flags = val;
+	else
+		req->flags = val;
+}
+
+#endif /* __BNG_TLV_H__ */
-- 
2.34.1


