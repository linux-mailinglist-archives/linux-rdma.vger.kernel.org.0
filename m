Return-Path: <linux-rdma+bounces-12925-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8C0B35463
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 08:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CACDC6870E3
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 06:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B218D2F83C0;
	Tue, 26 Aug 2025 06:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JbaYTWvR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D220C2F83B2
	for <linux-rdma@vger.kernel.org>; Tue, 26 Aug 2025 06:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189255; cv=none; b=jgWCv8k/jYBJai3/A17KcrogH3gRqIwXvhO5k7KGw4vSoWqAvKaaur9cS6+Ylv3hHcUvEe44IxxxhPJJjoNp4S3RqTy3EoXp9HIaDCo99dmzglRrTamWdIrl4bYzWpJdJ2dKgFw9264zJP4rC4ByjW17tbs6J2Hc4ZCr5sK4w/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189255; c=relaxed/simple;
	bh=QeTeAJHCFEm5UTJkIDJ+Ggdpr1gcHI2zuVaOgJNljnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sS39JD/EMaoJUGk/ZJ7yO2G5uLiKY0Lwg9jtff+6/y/g+xjMG2+uqjIFGG7tpFihDWbJwKeAgkNqwnCHrJ500wgLwgrSIdJaQFmslkIm6ZGeaxtGAJKsPbyJcKmHyVguFZ8yGMlYwCjBPzeZZV2pCwBgBGZSxWxANybQxSn0SJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JbaYTWvR; arc=none smtp.client-ip=209.85.128.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-71d603a269cso40110577b3.1
        for <linux-rdma@vger.kernel.org>; Mon, 25 Aug 2025 23:20:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756189253; x=1756794053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mkme5IBl5KRWoBojbGS0RT/QRiWYZpAh+2JnOlGPjUk=;
        b=fj+pUjyU4sCldiJDslB6tosETD00u3Efn6WT0L2FQu7vnXqsuMWmz3VjNwfrKKVl6+
         X4AeGP2bAn48rGKj5eO9b69y/mrQihfmrnfBAfy8HCImLlc0dR2qUCR1O7t2zrnRZUle
         0tYnUCGKcNWFCLiiUXZx4N/iUbM7rT16esEI7+/o/OPe1LdoqXApVO45eUjeVhXj9fFd
         Gi1BFObH3gCRVXIBM8MpsHPQSkIGxfuzfBUePQy3aKxzNhL8TTyt3Y64+ydeQCPgYe5Y
         kfmpqJGdARnKcztW/RbVAa79leRJW4/xhiWuZUSNsqUN8GJtDTcXebk9rEmaimot20ff
         OdKQ==
X-Gm-Message-State: AOJu0Yx28SKMOR6DrT6DZSbwMn4oQmFvg3oJYsRiXlG0+LWknqYamssb
	fikzE9X9qC6Um/uxDcA5l+7ygROcc4nsa1r4B6FsWdleprI+TJagnS5mDtI2LzfAQMbozs7qKWZ
	XIxUoNwxSWaYwmwhyDGVyp2c5xxjrD9mSi8Z+C94/xT/XmSSeSVe0AAHSJ+DiWnw6X36AnNIsCB
	aFMl3W0CnfwcPxJiquCnt1dho1jX1N6eZu5nBCaLLfrFFFnuyMhQhccOie10NTtS5fKpV5COx36
	H4AuLh3VReZsEgHVyApDQk5wO1pLQ==
X-Gm-Gg: ASbGnctJmL4cv9ScOJBLPZ7jKRViHw3/9zCDZjahhmbDh3qFWF2M4yWSuTyTKTCm+3d
	yMXO1EXbha1fCfE+JsuJGkthVl8ccK0rlaAgTz22p/yhXFjjMcNC/9SAWkcejePCgpLrOTI5jdE
	B2wDQ1bWqZnTIhGptHPpsbGnw8pf1HxyH1hB4PorWqjmcC+p45eS78qMlZrbwwfUtHY0sy1sWvV
	1jbotzSt8Jf9WvffAFzP6Dti93eZ21mPsfemVnRBQnT200gE5wt740Bqf/cLjzNTcvHvNL4no1y
	YuDBjtYtuml28Yr9OglXvKiMn89AvI3mcZ9fIUA5DC4kf83zrpRMWPgqZLMPI8s3XVu/t5aCO4r
	LhyXQnjABA+2Stf6NorJFgCYho2ZILWFnmD+OFzJLTVkgwvicCu8+2IoD+i12sunyaita2ap0p0
	sONmfpVR4OiYy/
X-Google-Smtp-Source: AGHT+IFDwM22WXIK7STEaGXg4H7e0yXWtG05I7WR0DVLyGS3j2OGL+v5nNmc4bjLKHE0uHu1mdu9DFL7D+C3
X-Received: by 2002:a05:690c:b1e:b0:71c:8de:8846 with SMTP id 00721157ae682-71fdc2a890dmr122392657b3.6.1756189252764;
        Mon, 25 Aug 2025 23:20:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-71ff16a3c94sm4614647b3.3.2025.08.25.23.20.52
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Aug 2025 23:20:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-325e31cecd8so1336300a91.3
        for <linux-rdma@vger.kernel.org>; Mon, 25 Aug 2025 23:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756189251; x=1756794051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkme5IBl5KRWoBojbGS0RT/QRiWYZpAh+2JnOlGPjUk=;
        b=JbaYTWvR+2BzqUTRXNMBBvvp05q/KMl17fbHEG11ExBhi8lfGFNPod5dYNyDJwQIoW
         U5/IpyAgOGPdHKJ4lRWwuy3p4hk3p8CMQ4BzQY91PH0cwj7ZGMbAjRxl1nkHygltf9Km
         eUP8JX3MRcMwUVVMvFGHVrmL+C1evk/7hMnIg=
X-Received: by 2002:a17:90b:538b:b0:325:cce7:f65b with SMTP id 98e67ed59e1d1-325cce7f86emr5603630a91.29.1756189251457;
        Mon, 25 Aug 2025 23:20:51 -0700 (PDT)
X-Received: by 2002:a17:90b:538b:b0:325:cce7:f65b with SMTP id 98e67ed59e1d1-325cce7f86emr5603594a91.29.1756189250915;
        Mon, 25 Aug 2025 23:20:50 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4c04c7522fsm4392543a12.5.2025.08.25.23.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:20:50 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	michael.chan@broadcom.com,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH V2 rdma-next 06/10] RDMA/bnxt_re: Add support for mirror vnic
Date: Tue, 26 Aug 2025 11:55:18 +0530
Message-ID: <20250826062522.1036432-7-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250826062522.1036432-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250826062522.1036432-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Saravanan Vajravel <saravanan.vajravel@broadcom.com>

Added below support:
- Querying the pre-reserved mirror_vnic_id
- Allocating/freeing mirror_vnic
- Configuring mirror vnic to associate it with raw qp

These functions will be used in the subsequent patch in this series.

Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Reviewed-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h |  4 ++
 drivers/infiniband/hw/bnxt_re/main.c    | 67 +++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 1cb57c8246cc..3f7f6cefe771 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -250,6 +250,10 @@ int bnxt_re_assign_pma_port_counters(struct bnxt_re_dev *rdev, struct ib_mad *ou
 int bnxt_re_assign_pma_port_ext_counters(struct bnxt_re_dev *rdev,
 					 struct ib_mad *out_mad);
 
+void bnxt_re_hwrm_free_vnic(struct bnxt_re_dev *rdev);
+int bnxt_re_hwrm_alloc_vnic(struct bnxt_re_dev *rdev);
+int bnxt_re_hwrm_cfg_vnic(struct bnxt_re_dev *rdev, u32 qp_id);
+
 static inline struct device *rdev_to_dev(struct bnxt_re_dev *rdev)
 {
 	if (rdev)
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 479c2a390885..07d25deffabe 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -540,6 +540,72 @@ static void bnxt_re_fill_fw_msg(struct bnxt_fw_msg *fw_msg, void *msg,
 	fw_msg->timeout = timeout;
 }
 
+void bnxt_re_hwrm_free_vnic(struct bnxt_re_dev *rdev)
+{
+	struct bnxt_en_dev *en_dev = rdev->en_dev;
+	struct hwrm_vnic_free_input req = {};
+	struct bnxt_fw_msg fw_msg = {};
+	int rc;
+
+	bnxt_re_init_hwrm_hdr((void *)&req, HWRM_VNIC_FREE);
+
+	req.vnic_id = cpu_to_le32(rdev->mirror_vnic_id);
+	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), NULL,
+			    0, DFLT_HWRM_CMD_TIMEOUT);
+	rc = bnxt_send_msg(en_dev, &fw_msg);
+	if (rc)
+		ibdev_dbg(&rdev->ibdev,
+			  "Failed to free vnic, rc = %d\n", rc);
+}
+
+int bnxt_re_hwrm_alloc_vnic(struct bnxt_re_dev *rdev)
+{
+	struct bnxt_en_dev *en_dev = rdev->en_dev;
+	struct hwrm_vnic_alloc_output resp = {};
+	struct hwrm_vnic_alloc_input req = {};
+	struct bnxt_fw_msg fw_msg = {};
+	int rc;
+
+	bnxt_re_init_hwrm_hdr((void *)&req, HWRM_VNIC_ALLOC);
+
+	req.vnic_id = cpu_to_le16(rdev->mirror_vnic_id);
+	req.flags = cpu_to_le32(VNIC_ALLOC_REQ_FLAGS_VNIC_ID_VALID);
+	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
+			    sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
+	rc = bnxt_send_msg(en_dev, &fw_msg);
+	if (rc)
+		ibdev_dbg(&rdev->ibdev,
+			  "Failed to alloc vnic, rc = %d\n", rc);
+
+	return rc;
+}
+
+int bnxt_re_hwrm_cfg_vnic(struct bnxt_re_dev *rdev, u32 qp_id)
+{
+	struct bnxt_en_dev *en_dev = rdev->en_dev;
+	struct hwrm_vnic_cfg_input req = {};
+	struct bnxt_fw_msg fw_msg = {};
+	int rc;
+
+	bnxt_re_init_hwrm_hdr((void *)&req, HWRM_VNIC_CFG);
+
+	req.flags = cpu_to_le32(VNIC_CFG_REQ_FLAGS_ROCE_ONLY_VNIC_MODE);
+	req.enables = cpu_to_le32(VNIC_CFG_REQ_ENABLES_RAW_QP_ID |
+				  VNIC_CFG_REQ_ENABLES_MRU);
+	req.vnic_id = cpu_to_le16(rdev->mirror_vnic_id);
+	req.raw_qp_id = cpu_to_le32(qp_id);
+	req.mru = cpu_to_le16(rdev->netdev->mtu + VLAN_ETH_HLEN);
+
+	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), NULL,
+			    0, DFLT_HWRM_CMD_TIMEOUT);
+	rc = bnxt_send_msg(en_dev, &fw_msg);
+	if (rc)
+		ibdev_dbg(&rdev->ibdev,
+			  "Failed to cfg vnic, rc = %d\n", rc);
+
+	return rc;
+}
+
 /* Query device config using common hwrm */
 static int bnxt_re_hwrm_qcfg(struct bnxt_re_dev *rdev, u32 *db_len,
 			     u32 *offset)
@@ -558,6 +624,7 @@ static int bnxt_re_hwrm_qcfg(struct bnxt_re_dev *rdev, u32 *db_len,
 	if (!rc) {
 		*db_len = PAGE_ALIGN(le16_to_cpu(resp.l2_doorbell_bar_size_kb) * 1024);
 		*offset = PAGE_ALIGN(le16_to_cpu(resp.legacy_l2_db_size_kb) * 1024);
+		rdev->mirror_vnic_id = le16_to_cpu(resp.mirror_vnic_id);
 	}
 	return rc;
 }
-- 
2.43.5


