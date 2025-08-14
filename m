Return-Path: <linux-rdma+bounces-12753-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CC9B26418
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 13:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24AE29E6C03
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 11:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D716262FDC;
	Thu, 14 Aug 2025 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LDW8Spv/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A741286D5D
	for <linux-rdma@vger.kernel.org>; Thu, 14 Aug 2025 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755170396; cv=none; b=sf2oh3Ki+ey0pm/ZyYQ3K9fpjXSw874OSkcUp1IqDPRh/gRS3edvGtHsjDUlvC2xbtJ6EVKdG7a3bfznb10LBztBSrAAS1lgMuqoLBjk4ji30TISkWDo3dFYQffQIwK+eih8E4aOD/HYIW3fAW/JCtbV89F+s5O6gHCcfji90us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755170396; c=relaxed/simple;
	bh=gHYhAYAPZiyTkopSjDyeld1U+CBwo2kU4dkU5/+CwDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bg8vIomy/ILJQ3jKHSvNj7Vt7IVJoiUNbULhm6jNjvoHe9ksfuZtTdoVaZvxEOemlsx/SQwT9ERVVHmqb/kwvpNFLznonSogWyfGyJbV5MR7ersvDQquvKo0Smtum9Z8g8MqyoDEPSsHuPTL6ipHk8bSXLWLM3ionodP4xNAlQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LDW8Spv/; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b47174aec0eso486118a12.2
        for <linux-rdma@vger.kernel.org>; Thu, 14 Aug 2025 04:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755170394; x=1755775194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrpvC06mVDwpok1m4Y2ze1QPcJqo/ZUSXMq8dj2Vog4=;
        b=LDW8Spv/qcKK/+Tjlw0DmUNkB97uBnEwirf6vF3FUQBEaZaf+oOseCic/HszRh6abb
         am+F6P/TRxnkS3IBP1rLjSQFbR/r65H3VoN9KCNSJ/Uw2sH+n0w2WeQdTju4NmCPzuyh
         G/wPwLX9j4qh6FA4hO37cFsnLlSERTZ23xdqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755170394; x=1755775194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FrpvC06mVDwpok1m4Y2ze1QPcJqo/ZUSXMq8dj2Vog4=;
        b=hDFbcOerEClBmZUGl6RAGqJ8y4e8ETXxXvBL1KUTJQn3aU4viGOFH4xomw+IYpNCYw
         7ubFdyNVagRnk/0hpyzpPx6CGjyDe3YJQ1AkV7T95OMxNoKjh1HNiLQKDI+vGM1QUZQR
         dAuTVK21v7tL11MBZ/EfWyh98Oql5r0BOpN0M7WzrfIZKXmIkVfBbH9mL8AAlK4qmScd
         OTdy27FMthhWIxaB+pkjJ4pexbG0D6qj6DanNN1d4CNsTFUvhNufqtoI9PPvwX4Z/B4D
         lIgQUFtjm0gKvHJOs+U6fAGGSchlO+liK7FXVD2cE4Gs+JLAetKSJwwe3TOfgQGfZuej
         yHag==
X-Gm-Message-State: AOJu0Yy8qcCngeTWEgTpZ1FkhjqRXg8pDvlHBlf3CV+lj/RrI1LJT41Y
	tlMlBbaAAIYFC0LvSzvppfGzvpObKogLRAqeMpnh6+QAtxuM8G4ZMC36IZFG/PhWyA==
X-Gm-Gg: ASbGncue6LoIxlo1rK7ftvXl2hFIXqNakCgDV2yrLma9scwEj3R2iISWYFtwpaRR9FC
	CWr0KlXJwDfcitj00EPEyeHKIcGhvwLi/5WCLztXAI2fusSGOSAtxurxqxnitFxrrGAET9iEuqh
	l56Wi4accQCvimA9zSCR3lNHuX/i9CtfSl4HZfpuma/Ecl1xRYqafXffgpKp71BYlEGln16gze1
	UpB/9JcpZxQ7wdyHfNZfqTw+vFmgjlDSEdfCpj5COnSD6OgdxKE8eVDzLxan4JIO3NbTqucWVkl
	2pFUPs/ZrSJ3Umu7SRPNQo1oh27sZuiUQrh9nZdqGHQKF7QHRKEAQKfhEYOJNX2SebBivDwGv6W
	sPGDSFxU2ifbx/3CbtjKbiX2XX1ZGeAOY/lI2cJuOc2luxerDoS1mLaMXPcP/tk154Cyk/XV1Nw
	Ys9782tgrV7OgukdIHdwA7C5eJkjRDeA==
X-Google-Smtp-Source: AGHT+IEWJFBPsIyP1KjRNfhErSsGSOxTcAac3Bmstun3YU0gLNiSSCFHwOwtktmSGk/zCrgOwnyGkw==
X-Received: by 2002:a17:902:cf03:b0:242:a3fc:5900 with SMTP id d9443c01a7336-2445849f706mr39329025ad.8.1755170394214;
        Thu, 14 Aug 2025 04:19:54 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f21c65sm352415175ad.73.2025.08.14.04.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 04:19:53 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Anantha Prabhu <anantha.prabhu@broadcom.com>,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-next 1/9] RDMA/bnxt_re: Update sysfs entries with appropriate data
Date: Thu, 14 Aug 2025 16:55:47 +0530
Message-ID: <20250814112555.221665-2-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250814112555.221665-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250814112555.221665-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anantha Prabhu <anantha.prabhu@broadcom.com>

Updated the existing sysfs entries with correct data.
This change is to align the behavior with our OOB driver.
Added "board_id" sysfs entry which will provide the
VPD Part number, if exists.

Signed-off-by: Anantha Prabhu <anantha.prabhu@broadcom.com>
Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h |  2 +
 drivers/infiniband/hw/bnxt_re/main.c    | 49 ++++++++++++++++++++++++-
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 6df5a2738c95..b5d0e38c7396 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -227,6 +227,8 @@ struct bnxt_re_dev {
 	struct workqueue_struct		*dcb_wq;
 	struct dentry                   *cc_config;
 	struct bnxt_re_dbg_cc_config_params *cc_config_params;
+#define BNXT_VPD_FLD_LEN	32
+	char			board_partno[BNXT_VPD_FLD_LEN];
 };
 
 #define to_bnxt_re_dev(ptr, member)	\
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 293b0a96c8e3..20c6a961cb18 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -975,7 +975,7 @@ static ssize_t hw_rev_show(struct device *device, struct device_attribute *attr,
 	struct bnxt_re_dev *rdev =
 		rdma_device_to_drv_device(device, struct bnxt_re_dev, ibdev);
 
-	return sysfs_emit(buf, "0x%x\n", rdev->en_dev->pdev->vendor);
+	return sysfs_emit(buf, "0x%x\n", rdev->en_dev->pdev->revision);
 }
 static DEVICE_ATTR_RO(hw_rev);
 
@@ -985,13 +985,31 @@ static ssize_t hca_type_show(struct device *device,
 	struct bnxt_re_dev *rdev =
 		rdma_device_to_drv_device(device, struct bnxt_re_dev, ibdev);
 
-	return sysfs_emit(buf, "%s\n", rdev->ibdev.node_desc);
+	return sysfs_emit(buf, "0x%x\n", rdev->en_dev->pdev->device);
 }
 static DEVICE_ATTR_RO(hca_type);
 
+static ssize_t board_id_show(struct device *device, struct device_attribute *attr,
+			     char *buf)
+{
+	struct bnxt_re_dev *rdev = rdma_device_to_drv_device(device,
+							     struct bnxt_re_dev, ibdev);
+	char buffer[BNXT_VPD_FLD_LEN] = {};
+
+	if (!rdev->is_virtfn)
+		memcpy(buffer, rdev->board_partno, BNXT_VPD_FLD_LEN - 1);
+	else
+		scnprintf(buffer, BNXT_VPD_FLD_LEN, "0x%x-VF",
+			  rdev->en_dev->pdev->device);
+
+	return scnprintf(buf, PAGE_SIZE, "%s\n", buffer);
+}
+static DEVICE_ATTR_RO(board_id);
+
 static struct attribute *bnxt_re_attributes[] = {
 	&dev_attr_hw_rev.attr,
 	&dev_attr_hca_type.attr,
+	&dev_attr_board_id.attr,
 	NULL
 };
 
@@ -1945,6 +1963,30 @@ static void bnxt_re_net_register_async_event(struct bnxt_re_dev *rdev)
 				   ASYNC_EVENT_CMPL_EVENT_ID_DCB_CONFIG_CHANGE);
 }
 
+static void bnxt_re_read_vpd_info(struct bnxt_re_dev *rdev)
+{
+	struct pci_dev *pdev = rdev->en_dev->pdev;
+	unsigned int vpd_size, kw_len;
+	int pos, size;
+	u8 *vpd_data;
+
+	vpd_data = pci_vpd_alloc(pdev, &vpd_size);
+	if (IS_ERR(vpd_data)) {
+		pci_warn(pdev, "Unable to read VPD, err=%ld\n", PTR_ERR(vpd_data));
+		return;
+	}
+
+	pos = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
+					   PCI_VPD_RO_KEYWORD_PARTNO, &kw_len);
+	if (pos < 0)
+		goto free;
+
+	size = min_t(int, kw_len, BNXT_VPD_FLD_LEN - 1);
+	memcpy(rdev->board_partno, &vpd_data[pos], size);
+free:
+	kfree(vpd_data);
+}
+
 static void bnxt_re_query_hwrm_intf_version(struct bnxt_re_dev *rdev)
 {
 	struct bnxt_en_dev *en_dev = rdev->en_dev;
@@ -2247,6 +2289,9 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 	bnxt_re_init_dcb_wq(rdev);
 	bnxt_re_net_register_async_event(rdev);
 
+	if (!rdev->is_virtfn)
+		bnxt_re_read_vpd_info(rdev);
+
 	return 0;
 free_sctx:
 	bnxt_re_net_stats_ctx_free(rdev, rdev->qplib_ctx.stats.fw_id);
-- 
2.43.5


