Return-Path: <linux-rdma+bounces-12876-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7ECB30D39
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Aug 2025 06:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D65DA27AA7
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Aug 2025 04:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7DF28DB56;
	Fri, 22 Aug 2025 04:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZL1SWKJf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com [209.85.210.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5907321FF45
	for <linux-rdma@vger.kernel.org>; Fri, 22 Aug 2025 04:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755835385; cv=none; b=IJbdj1n2pQgMcClN5OpqIDIZtx7hQKsFGywTB27oo78zIMygwLl8HfWKqiY26EQHvDlpDRNqrjJNR1loc4/uCvYEkSMfXWkAsxTajvATDs00E249v44WukDYjkHw6erEP6qzbHenetFqtrlfSUjjXXleHuCt3vKf4qCWTOZqME0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755835385; c=relaxed/simple;
	bh=QeTeAJHCFEm5UTJkIDJ+Ggdpr1gcHI2zuVaOgJNljnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R1UpKaDdEgrCqf43fhtGQy4IDOFDs8/D4hMV/0feM6N1CxfcFgoqQ/45bFL9MFfyUPIbjfrpJVcfrGMmgxqsMBk8hldavjWcH+S03FGWD0L9jn3PLgS6i9AbD5mhW3nrUsv+1gISmu6TMnfjsTufr0droN/zexaWSnw257qoBbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZL1SWKJf; arc=none smtp.client-ip=209.85.210.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f227.google.com with SMTP id d2e1a72fcca58-770305d333aso323209b3a.0
        for <linux-rdma@vger.kernel.org>; Thu, 21 Aug 2025 21:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755835384; x=1756440184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mkme5IBl5KRWoBojbGS0RT/QRiWYZpAh+2JnOlGPjUk=;
        b=LrrvXLGKcp9a7kmQCjCEvQwedyeM3prp7wqk/40fCsFKIrIowmvOQaW2hvjb9661sd
         640EyZKJAoSrngTP6EdbdkcCBA8TD9r1suqe7xnpCfaW886WV9ypoPHwimoSFVkior38
         ouaTPvmeJj2iFeslWNwzduz6KmIQngvHmQSZowiwaIGhZBECtdK7I+VxT3Dzs92TVK67
         urUrVx/ZYy3PlA8ORNRf0eQVaOw/7iQxvMiEq+KnCLoA+QnkkX0XavUvrndb9ZPE+eMa
         mSWQfUcZGgG7Jbh2CEqKtLrGmbxeVl7ynKTmrsZ9V7eKaxWAi+qOETJ/iA+nF2LHSAJt
         GGfg==
X-Gm-Message-State: AOJu0YzcpKRmftZYzoqQ49tGsDkmO5T+A17W5ZtWFoNOrJrCZTS5bAz8
	uUDleaZwSx7jjAAz7YzAfRfRJ5cpuejDR2n738hsA+FE4Wb4ot5L604afF+L/8hEBV5/kCf0ifQ
	RnrPW6eC1uOqjZbiwvxYkubAKkBacuKzyWHKdwkl3MWvntiaieQSGFglXwe5ilLAeVhHNF8RZcB
	8XciFU9Q0/51AVHATEsmeLvqH7D58Iy7Uv8reNmT8AFUmlglvOzpL/ALGlSrtsZXkDYB8fWeTc1
	0FhKbCBDk4Retp7D9kHV0u/E0ky1A==
X-Gm-Gg: ASbGncvJ5wbUjZkJuTPlzvuL30VAWoJWlUGes/V1CISKSVbdOWHhoDoqmPNqCo+jCgl
	k9mtIRxDclCfOXeBjjaGp0ruAHUNL0rMNfhRstlZwSB6Sdd7hzqfY8dQncI30MmAGitZAbAImSL
	GsJvB2gq6WxH7EgPAg/JFTNPJOJqRjW0LnQfj0hK7Bgn10pEhK2FapEezzlyQzlYpCU+1NnQiq0
	xnPlAKA2InSxj/JWYWBaNp6Dfof0YT4yDP4KnftqzWx11bH7Jk/O0AgWzC6Lvy5BBWrKyrq7Prr
	1l9Mq7ry+KkNdykK9lKIdgjwQcu4AsjMeDJ1kURcOysIG/73+zGt/DVUEcJri3//Y/wgeNcKqY/
	ITp7A/QtuwzdBeEDZwen7sadW1/fKDL9VBoORG6uGucVK2aL0r1iblGsClszgj9Pq57QPKnvgK1
	MLmHlMz9NHPgYn
X-Google-Smtp-Source: AGHT+IE49YuN8OwfSuGlBOiI9CDUr5wKX+43XhLEOBVgMMzX0xanQQw7iPsCs2Vvbb8E83dvkc0QQqoQCwUD
X-Received: by 2002:a05:6a00:a87:b0:76b:dd55:75e2 with SMTP id d2e1a72fcca58-7702fadbb29mr2256131b3a.15.1755835383564;
        Thu, 21 Aug 2025 21:03:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-76e7d268c01sm833300b3a.14.2025.08.21.21.03.03
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Aug 2025 21:03:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76e2e5c4734so1827990b3a.0
        for <linux-rdma@vger.kernel.org>; Thu, 21 Aug 2025 21:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755835382; x=1756440182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkme5IBl5KRWoBojbGS0RT/QRiWYZpAh+2JnOlGPjUk=;
        b=ZL1SWKJfTMkK/oeoqkt2ggCSTfhAV3OKuCs+NdaavRTPsDbNhJPBYSo7DeGaA+Ka5X
         U3ebT0DUPD1oTnscFehc6zS4799Zz3hLt2H/Wv0MRabcjF2sDRG5uSGILC/24BMsVngv
         WKafvS0XYoc0n3P+/CbjmfJhK0fQTRQ9TBGCk=
X-Received: by 2002:a05:6a00:23d5:b0:748:9d26:bb0a with SMTP id d2e1a72fcca58-7702fadbbedmr2387666b3a.18.1755835381742;
        Thu, 21 Aug 2025 21:03:01 -0700 (PDT)
X-Received: by 2002:a05:6a00:23d5:b0:748:9d26:bb0a with SMTP id d2e1a72fcca58-7702fadbbedmr2387629b3a.18.1755835381309;
        Thu, 21 Aug 2025 21:03:01 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d3abdsm9659814b3a.11.2025.08.21.21.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 21:03:00 -0700 (PDT)
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
Subject: [PATCH rdma-next 06/10] RDMA/bnxt_re: Add support for mirror vnic
Date: Fri, 22 Aug 2025 09:37:57 +0530
Message-ID: <20250822040801.776196-7-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250822040801.776196-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250822040801.776196-1-kalesh-anakkur.purayil@broadcom.com>
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


