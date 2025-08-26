Return-Path: <linux-rdma+bounces-12928-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B67ACB3546B
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 08:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A8191B65E85
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 06:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6939A2F9984;
	Tue, 26 Aug 2025 06:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QQEOLPyp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f226.google.com (mail-yb1-f226.google.com [209.85.219.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB612F60DF
	for <linux-rdma@vger.kernel.org>; Tue, 26 Aug 2025 06:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189266; cv=none; b=pZ4lJW/x3fQge3MyxIZCvaMsEPwvKNZ2sU0s1sSHm6uie16nRwPTvzUqZU66GICvrEQr6dqKM8ZAcVBqZDE4QlFfnTp9+Tf7wDm3PmIyZ4U8CjMQ4zTZJw8JiSrUEbtwseZfVKpqS4HaG6isZCbaruJIx/lOC4qdalWIvZXYbVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189266; c=relaxed/simple;
	bh=Cg9f4qbtnLiKGCb8IAHrXciUEFDi5ch7WoJlXdSbRf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zt/cLEtA1o5GLjGa1A8gdR4frVw0mMCe+TGHm4TJiETh38ae4KGKbLtQYBrPR6McBqLmtdLfow0B2O/Nfhrz+qaBxNQ6JrL/tjyLlTZeDRmxVFqOWttnVK3oEFeuA+5neSRYOBIWB2WpmCuEvgd+7Ps5Fx1BC7XOCMklHWdevAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QQEOLPyp; arc=none smtp.client-ip=209.85.219.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f226.google.com with SMTP id 3f1490d57ef6-e96e3094fd9so129580276.1
        for <linux-rdma@vger.kernel.org>; Mon, 25 Aug 2025 23:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756189263; x=1756794063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pC+7q7NodIH0hjI+zyTrTYXj61OEWS4pX8bCO/8fuzk=;
        b=GjpKw5Qld2RcHOlBQ7ByWQfgWBWS8iAF9W/GnEjC+uoc762sf/+XxAwnQmpaDHHxqo
         Kva51fEABZscXnpHEHdp5QqPbNrdnzT8lYUZbqSFx7Kqc5FpVLAhb4PfpEkpcpMVlzLp
         +Ru5k76GYipkdqzDXRTXIn8vpC/YDQlux4GXhq3tkCDj1Du5lCvP5sN9GYOUDPm3F4fp
         9hhOLnc4iUGDqsOmitx2lylbaT2cju/SkQ4LHjAJ6dA51ltR0i6q/F23Y4zY4bRshTDi
         IwMF9hiptr1wWCNvTTU2Q3Ht97Ce5RhkZkJQ4wkXLSLCGi2hM98UlqJbrODJrFRkrOPh
         Yycg==
X-Gm-Message-State: AOJu0YyVHDb1PrPJWatgG3qxOpE22bPv97fuEnwwjDeT0tAhxo4LpRZW
	3Oa5d6lKzi04MLDYyXsS1qzm2zvnEgF9Pw4jBMyPevc1zw70jlUkFofr2IqbqWeuLzOSj6s2gXb
	0qtNE0EEWwpwGbPELA2mvOWlOKYDNw+WDycWaKhchBenDrFgeVaCKMYb1PfPkB+KI/AAOVkU3gY
	mCMQExU+GxX53EcymGxVBuKtU0oRqMy1V+lP0OkEOtFkC6SpdrblZnovFAHek8JzQrkJnA3VAps
	QIPrbkomnk47XcOeqwim/omXlvwzA==
X-Gm-Gg: ASbGncuwI9Z9Q4FnpiOKQ9Uee82ynRrQGjqaO+TbETx2f/hUlfhd4JmdNHpWtJQa+sn
	dF6jInbbSWy0emPwvbuM78YgR3S7Q8F+wgNiJQ4FF5M/5XafAlZe7Nh+WQa8h6gVBc4Exzu5OuK
	X7MKv7NobzYDR4FCHrLto40/lUb0Hh9N+Z+UdzWDSjK60YT/nImCEUJp+Hvw91BvSCmvCz9/ot6
	WFUNhSJI21hgAnY+J6PXwZoNSeV0uWwA/Vits4KfewKIv16J1tKpgxxvvB1YcdKh/d+b3A/lfQA
	NU37MN0D0OSZudyY+Os+y3cZA7f5MCVmekJNBGipxcQhnFvrwqBijMzp5RkLTcle+2KuqOYCIMY
	jeyh36LqEmz+5vMYETn6ujwGj7Mouv6CF8RwaWse1EfNFpbQ1fqa4xn8hF4uUniBEWsOjTFN+Xx
	g4VhI3TxEeaSVE
X-Google-Smtp-Source: AGHT+IHQQKgukcuoAZ1DX4HyKSQdtH3PbHrqHU+3XdYn+vMSxHktlQF9LJMHGExyRqG4p6Jb6O4AhqrcsAHa
X-Received: by 2002:a05:6902:4211:b0:e94:d678:c2b2 with SMTP id 3f1490d57ef6-e951c353afdmr17805963276.35.1756189263276;
        Mon, 25 Aug 2025 23:21:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-721127164desm2162327b3.29.2025.08.25.23.21.02
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Aug 2025 23:21:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e395107e2so4921133b3a.3
        for <linux-rdma@vger.kernel.org>; Mon, 25 Aug 2025 23:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756189262; x=1756794062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pC+7q7NodIH0hjI+zyTrTYXj61OEWS4pX8bCO/8fuzk=;
        b=QQEOLPypEHqSK8670hEZn7Z1FSY9Yfo+fFJc4Hb8wl6CWtTa/OjbWx2kwYvK9I6aoc
         LgfkxDuGZyNeWUGmd/S0UdaH5FYmJdOuDPrAZeWI0rSuH/YrVXW8sly/t4sygWvWz49h
         PqY8rOitW1JpfClJT/J4yQ+LOXH2ZX+GQZQwE=
X-Received: by 2002:a05:6a20:5483:b0:240:265f:4eb0 with SMTP id adf61e73a8af0-24340ad1f7bmr19326433637.4.1756189261931;
        Mon, 25 Aug 2025 23:21:01 -0700 (PDT)
X-Received: by 2002:a05:6a20:5483:b0:240:265f:4eb0 with SMTP id adf61e73a8af0-24340ad1f7bmr19326409637.4.1756189261487;
        Mon, 25 Aug 2025 23:21:01 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4c04c7522fsm4392543a12.5.2025.08.25.23.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:21:01 -0700 (PDT)
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
	Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH V2 rdma-next 09/10] RDMA/bnxt_re: Use firmware provided message timeout value
Date: Tue, 26 Aug 2025 11:55:21 +0530
Message-ID: <20250826062522.1036432-10-kalesh-anakkur.purayil@broadcom.com>
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

Before this patch, we used a hardcoded value of 500 msec as the default
value for L2 firmware message response timeout. With this commit,
the driver is using the firmware timeout value from the firmware.

As part of this change moved bnxt_re_query_hwrm_intf_version() to
bnxt_re_setup_chip_ctx() so that timeout value is queries before
sending first command.

Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
Reviewed-by: Kashyap Desai <kashyap.desai@broadcom.com>
Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Co-developed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h |  3 +++
 drivers/infiniband/hw/bnxt_re/main.c    | 33 ++++++++++++++-----------
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 3a219d67746c..4ac6a312e053 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -288,4 +288,7 @@ static inline int bnxt_re_read_context_allowed(struct bnxt_re_dev *rdev)
 #define BNXT_RE_CONTEXT_TYPE_MRW_SIZE_P7	192
 #define BNXT_RE_CONTEXT_TYPE_SRQ_SIZE_P7	192
 
+#define BNXT_RE_HWRM_CMD_TIMEOUT(rdev)		\
+		((rdev)->chip_ctx->hwrm_cmd_max_timeout * 1000)
+
 #endif
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 059a4963963a..3e1161721738 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -80,6 +80,7 @@ MODULE_LICENSE("Dual BSD/GPL");
 static DEFINE_MUTEX(bnxt_re_mutex);
 
 static int bnxt_re_hwrm_qcaps(struct bnxt_re_dev *rdev);
+static int bnxt_re_query_hwrm_intf_version(struct bnxt_re_dev *rdev);
 
 static int bnxt_re_hwrm_qcfg(struct bnxt_re_dev *rdev, u32 *db_len,
 			     u32 *offset);
@@ -188,6 +189,10 @@ static int bnxt_re_setup_chip_ctx(struct bnxt_re_dev *rdev)
 	rdev->qplib_res.is_vf = BNXT_EN_VF(en_dev);
 	rdev->qplib_res.en_dev = en_dev;
 
+	rc = bnxt_re_query_hwrm_intf_version(rdev);
+	if (rc)
+		goto free_dev_attr;
+
 	bnxt_re_set_drv_mode(rdev);
 
 	bnxt_re_set_db_offset(rdev);
@@ -551,7 +556,7 @@ void bnxt_re_hwrm_free_vnic(struct bnxt_re_dev *rdev)
 
 	req.vnic_id = cpu_to_le32(rdev->mirror_vnic_id);
 	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), NULL,
-			    0, DFLT_HWRM_CMD_TIMEOUT);
+			    0, BNXT_RE_HWRM_CMD_TIMEOUT(rdev));
 	rc = bnxt_send_msg(en_dev, &fw_msg);
 	if (rc)
 		ibdev_dbg(&rdev->ibdev,
@@ -571,7 +576,7 @@ int bnxt_re_hwrm_alloc_vnic(struct bnxt_re_dev *rdev)
 	req.vnic_id = cpu_to_le16(rdev->mirror_vnic_id);
 	req.flags = cpu_to_le32(VNIC_ALLOC_REQ_FLAGS_VNIC_ID_VALID);
 	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
-			    sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
+			    sizeof(resp), BNXT_RE_HWRM_CMD_TIMEOUT(rdev));
 	rc = bnxt_send_msg(en_dev, &fw_msg);
 	if (rc)
 		ibdev_dbg(&rdev->ibdev,
@@ -597,7 +602,7 @@ int bnxt_re_hwrm_cfg_vnic(struct bnxt_re_dev *rdev, u32 qp_id)
 	req.mru = cpu_to_le16(rdev->netdev->mtu + VLAN_ETH_HLEN);
 
 	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), NULL,
-			    0, DFLT_HWRM_CMD_TIMEOUT);
+			    0, BNXT_RE_HWRM_CMD_TIMEOUT(rdev));
 	rc = bnxt_send_msg(en_dev, &fw_msg);
 	if (rc)
 		ibdev_dbg(&rdev->ibdev,
@@ -619,7 +624,7 @@ static int bnxt_re_hwrm_qcfg(struct bnxt_re_dev *rdev, u32 *db_len,
 	bnxt_re_init_hwrm_hdr((void *)&req, HWRM_FUNC_QCFG);
 	req.fid = cpu_to_le16(0xffff);
 	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
-			    sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
+			    sizeof(resp), BNXT_RE_HWRM_CMD_TIMEOUT(rdev));
 	rc = bnxt_send_msg(en_dev, &fw_msg);
 	if (!rc) {
 		*db_len = PAGE_ALIGN(le16_to_cpu(resp.l2_doorbell_bar_size_kb) * 1024);
@@ -644,7 +649,7 @@ int bnxt_re_hwrm_qcaps(struct bnxt_re_dev *rdev)
 	bnxt_re_init_hwrm_hdr((void *)&req, HWRM_FUNC_QCAPS);
 	req.fid = cpu_to_le16(0xffff);
 	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
-			    sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
+			    sizeof(resp), BNXT_RE_HWRM_CMD_TIMEOUT(rdev));
 
 	rc = bnxt_send_msg(en_dev, &fw_msg);
 	if (rc)
@@ -672,7 +677,7 @@ static int bnxt_re_hwrm_dbr_pacing_qcfg(struct bnxt_re_dev *rdev)
 	cctx = rdev->chip_ctx;
 	bnxt_re_init_hwrm_hdr((void *)&req, HWRM_FUNC_DBR_PACING_QCFG);
 	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
-			    sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
+			    sizeof(resp), BNXT_RE_HWRM_CMD_TIMEOUT(rdev));
 	rc = bnxt_send_msg(en_dev, &fw_msg);
 	if (rc)
 		return rc;
@@ -932,7 +937,7 @@ static int bnxt_re_net_ring_free(struct bnxt_re_dev *rdev,
 	req.ring_type = type;
 	req.ring_id = cpu_to_le16(fw_ring_id);
 	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
-			    sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
+			    sizeof(resp), BNXT_RE_HWRM_CMD_TIMEOUT(rdev));
 	rc = bnxt_send_msg(en_dev, &fw_msg);
 	if (rc)
 		ibdev_err(&rdev->ibdev, "Failed to free HW ring:%d :%#x",
@@ -968,7 +973,7 @@ static int bnxt_re_net_ring_alloc(struct bnxt_re_dev *rdev,
 	req.ring_type = ring_attr->type;
 	req.int_mode = ring_attr->mode;
 	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
-			    sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
+			    sizeof(resp), BNXT_RE_HWRM_CMD_TIMEOUT(rdev));
 	rc = bnxt_send_msg(en_dev, &fw_msg);
 	if (!rc)
 		*fw_ring_id = le16_to_cpu(resp.ring_id);
@@ -994,7 +999,7 @@ static int bnxt_re_net_stats_ctx_free(struct bnxt_re_dev *rdev,
 	bnxt_re_init_hwrm_hdr((void *)&req, HWRM_STAT_CTX_FREE);
 	req.stat_ctx_id = cpu_to_le32(fw_stats_ctx_id);
 	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
-			    sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
+			    sizeof(resp), BNXT_RE_HWRM_CMD_TIMEOUT(rdev));
 	rc = bnxt_send_msg(en_dev, &fw_msg);
 	if (rc)
 		ibdev_err(&rdev->ibdev, "Failed to free HW stats context %#x",
@@ -1024,7 +1029,7 @@ static int bnxt_re_net_stats_ctx_alloc(struct bnxt_re_dev *rdev,
 	req.stats_dma_length = cpu_to_le16(chip_ctx->hw_stats_size);
 	req.stat_ctx_flags = STAT_CTX_ALLOC_REQ_STAT_CTX_FLAGS_ROCE;
 	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
-			    sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
+			    sizeof(resp), BNXT_RE_HWRM_CMD_TIMEOUT(rdev));
 	rc = bnxt_send_msg(en_dev, &fw_msg);
 	if (!rc)
 		stats->fw_id = le32_to_cpu(resp.stat_ctx_id);
@@ -1984,7 +1989,7 @@ static void bnxt_re_read_vpd_info(struct bnxt_re_dev *rdev)
 	kfree(vpd_data);
 }
 
-static void bnxt_re_query_hwrm_intf_version(struct bnxt_re_dev *rdev)
+static int bnxt_re_query_hwrm_intf_version(struct bnxt_re_dev *rdev)
 {
 	struct bnxt_en_dev *en_dev = rdev->en_dev;
 	struct hwrm_ver_get_output resp = {};
@@ -2003,7 +2008,7 @@ static void bnxt_re_query_hwrm_intf_version(struct bnxt_re_dev *rdev)
 	if (rc) {
 		ibdev_err(&rdev->ibdev, "Failed to query HW version, rc = 0x%x",
 			  rc);
-		return;
+		return rc;
 	}
 
 	cctx = rdev->chip_ctx;
@@ -2017,6 +2022,8 @@ static void bnxt_re_query_hwrm_intf_version(struct bnxt_re_dev *rdev)
 
 	if (!cctx->hwrm_cmd_max_timeout)
 		cctx->hwrm_cmd_max_timeout = RCFW_FW_STALL_MAX_TIMEOUT;
+
+	return 0;
 }
 
 static int bnxt_re_ib_init(struct bnxt_re_dev *rdev)
@@ -2223,8 +2230,6 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 	/* Check whether VF or PF */
 	bnxt_re_get_sriov_func_type(rdev);
 
-	bnxt_re_query_hwrm_intf_version(rdev);
-
 	/* Establish RCFW Communication Channel to initialize the context
 	 * memory for the function and all child VFs
 	 */
-- 
2.43.5


