Return-Path: <linux-rdma+bounces-13152-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EA1B488AD
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 11:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F113C43E4
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 09:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64BF2EFD86;
	Mon,  8 Sep 2025 09:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DwToJ4aS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f226.google.com (mail-il1-f226.google.com [209.85.166.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205B827F4F5
	for <linux-rdma@vger.kernel.org>; Mon,  8 Sep 2025 09:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324340; cv=none; b=ABcesocDsa+Bhlnpkp4cOJdA27pcdIebGd+oUBtX2PU4E/PfFrlfVx/7Pn0NKzY7D4hr+j3L4Xo1djTxaspYrRxEori1a/TEWxjWbd6WW8CFrlxKBAa3rgc+6AZihxlJ3ekyKAOTSYbrIUWOqmQgI9QHPOYO7Ip8aFA8Cb78EMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324340; c=relaxed/simple;
	bh=URxXyW3n4tEzic0YzMl54scAG+O0ruGhCR+yNKdnoYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KgBzi2kUbQJXXGVewXhDyirXobN5JrssYGtqvnyAuW1GqqLiEJdAZpoS6dkbC4/1E8tn6xpbc2rHr/7xIr9PrCCw7qIWAirwtw1L7QrPFL9xIoACo+5nFbXoo/HOBTha30+HPVsJtQ9BmlRdKTBMWdXBCQsPVQX9tcz7SSgCOuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DwToJ4aS; arc=none smtp.client-ip=209.85.166.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f226.google.com with SMTP id e9e14a558f8ab-407240934c9so8801385ab.2
        for <linux-rdma@vger.kernel.org>; Mon, 08 Sep 2025 02:38:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757324338; x=1757929138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VHn2rfCY6VGJ+gLqN8/4kMdjhkTzDUSRh8Er45sGSj4=;
        b=vbkD6LvIjKYmRzFajsPA9gJT00a+XDHyzV+pvyofRvnYwuofNRd/8mwEvjeEQmvBpG
         5cjO5KqNgm7foZ2mrRqIQlsvZbF7p2HaqqmJ+uRWdpk9uaeABK2pP/JPimapdzwwZiKw
         S7qzzuVgJc+oCl/IPEc/J5AN+W/GYX2KUOkaDEIqI/zN0Re+GB3XjDQ7zEaduuJy6C06
         AZlZh6C3WoWnvqU+tW4VYRv8Nd9WiLYIR5/UKaa9lmauVc7TXt7//Gz0DxE7bPN6Qvaz
         IKSikYigCV++nFAF+U3FsDlkbMWqgbqjO2b3UTeergVvT0Cl+x+0nAjVdPyPTgHC3IPy
         C6Qw==
X-Gm-Message-State: AOJu0YxpF+XyZjNoOsACKSiOvvdxbtMHFW16aY7NJaprGaxaduO4DSer
	pYCZED1v61u/8DgbJEPqdtdWD1AkML/Q+z+ruymoC3B5YhjI8cKjxO0m96zhA+BhCyG1XxemmD0
	x6O4gt6D//3GSg5+D20cbH4ReJ8ljCDnffk1t5YwVfc//eST+N18tFnZ71gSrlr2xYWxgBiTzGl
	b/JDBr7CQ5v0XfulXeaTZen94InMYHowwDVtb7ZmksE/D/xFae9mvjCTOK1rKQmytz8AiZcaHik
	I0wGzVbvpNQnRq+1cpDxoNKWKFqQg==
X-Gm-Gg: ASbGncs97exgUH2YyZmXG0OZiDHER5qeeY8vxL2+DgD9dgYggTuilGAoJYSylnt8eOg
	kzO8c14/l+bDHF4/g2s5Ha4BhpkX+b6QfGdArjctYCjkgJbU5+qsoUR5W6zy1/at32c+q0ID+6o
	UE9/k6bwz5PS066f0ge/agZFf37/hrBNxSC/CkuULpe+UHQc8Ur+5pP64GnvAIPYwWW8r/dxcnu
	NFv4ZK1g1/EDB3Wcqk/83PgbiIDxRnxjjx8qtTeAQgk18cDQWxHFiywcvs49BSaBBbQriN/SyXb
	JedO83rqU6NB73WlqIktwapRKHxz+khSL/FMIuV14psWpTRNUbw7jCGeyBvJ01vMenOFmfl3hlh
	7TcwMFWVSEkPT/MW+TLcX6HlgyYgdX8XNpiW6MasmkLX+kUU5IEzc4gpMt1EoXr3yhhERFNMM/p
	okFdE4kVXKHY9v
X-Google-Smtp-Source: AGHT+IHcmm/vNNboEPsgDHH/Vne1/s3gFLHnUPncv5wDDv405wxYXCBXXto1RNnByoowmjcn1Cym9Nmx2pAh
X-Received: by 2002:a05:6e02:1a27:b0:406:7c54:9f6c with SMTP id e9e14a558f8ab-4067c549fe1mr44977545ab.7.1757324338233;
        Mon, 08 Sep 2025 02:38:58 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-5103964c173sm746636173.31.2025.09.08.02.38.57
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Sep 2025 02:38:58 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b4d3ab49a66so7168231a12.3
        for <linux-rdma@vger.kernel.org>; Mon, 08 Sep 2025 02:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757324337; x=1757929137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHn2rfCY6VGJ+gLqN8/4kMdjhkTzDUSRh8Er45sGSj4=;
        b=DwToJ4aS7w987lBWM9U3JR1NsxcPwF9XCdVK9eZdFyx+pFmyOMECqGapyOJHUDa+RI
         p6Q9eL3dBKxnhxGX4tUjCT5cztTAfio79MFZAxPXtCOaWj4ZdGRrHPQMWurJ75TgDnUy
         P6h0gkH6TsRxWvz0o3Rv9TS7L3k+VXG4jEE0k=
X-Received: by 2002:a17:90a:d40e:b0:32b:c26b:4da1 with SMTP id 98e67ed59e1d1-32d43fad064mr9364810a91.25.1757324336674;
        Mon, 08 Sep 2025 02:38:56 -0700 (PDT)
X-Received: by 2002:a17:90a:d40e:b0:32b:c26b:4da1 with SMTP id 98e67ed59e1d1-32d43fad064mr9364796a91.25.1757324336196;
        Mon, 08 Sep 2025 02:38:56 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32d8ead7bbbsm1629283a91.16.2025.09.08.02.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 02:38:55 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Anantha Prabhu <anantha.prabhu@broadcom.com>,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH V2 rdma-next 1/2] RDMA/bnxt_re: Update sysfs entries with appropriate data
Date: Mon,  8 Sep 2025 15:15:15 +0530
Message-ID: <20250908094516.18222-2-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250908094516.18222-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250908094516.18222-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

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
index 0bdc2f66e136..4703ed3ec928 100644
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
+	return sysfs_emit(buf, "%s\n", buffer);
+}
+static DEVICE_ATTR_RO(board_id);
+
 static struct attribute *bnxt_re_attributes[] = {
 	&dev_attr_hw_rev.attr,
 	&dev_attr_hca_type.attr,
+	&dev_attr_board_id.attr,
 	NULL
 };
 
@@ -1947,6 +1965,30 @@ static void bnxt_re_net_register_async_event(struct bnxt_re_dev *rdev)
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
@@ -2251,6 +2293,9 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
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


