Return-Path: <linux-rdma+bounces-6831-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1D3A0225F
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 11:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E72DE163C9C
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 10:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A921DA112;
	Mon,  6 Jan 2025 10:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="K9r0ILcr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF871D9353
	for <linux-rdma@vger.kernel.org>; Mon,  6 Jan 2025 10:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736157681; cv=none; b=V3cn4br7kYPgxWQ8KFSFuX1JzH4zzxgnFgdD5zMYje/D7XDqeYo2rIUD5T62/toqLeB4MOkOn1hR1P6ru4e+HJjauDxftEJUS2lSxD8P9rh125FTiVV4ltJWJNWlPDNWznzDE/B+sebF2tsXPW9kfUTbZjWPHS0xih1Pd6SlRhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736157681; c=relaxed/simple;
	bh=S5sim7deJTpwNThROIWwUf3TRONyBa1CLx4Ap0Ttfsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLlFDhF3VV5LuVzlUt7chcG+evarALMAZMp9CmB4ra5hh5YgS9NiGqxlFS+iPU+PjLMmRSGtplMovHLFDYZYJKRKPffEdnY8fGyrNzlVqQ5Bq2RPtu7dd8NZnu5aC739cm+7bzO4ute0UbN6+xfwMddaJTcp4kywAv4d0o/niaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=K9r0ILcr; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2efd81c7ca4so16525178a91.2
        for <linux-rdma@vger.kernel.org>; Mon, 06 Jan 2025 02:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736157678; x=1736762478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8o9WFlNd3QzSxtSoTJJx9jfQ6BY4QYc+w6YqL60yedc=;
        b=K9r0ILcraYBr5yXZ/WOoOEcFRBWzoT+HJ6KOrbAP86iD0u9mH7ETAl9PifqprdgGHO
         xZ2MZ4XaBsBFsFk/ba2PrMG0E89ZASer6InkFJfh9kCCXGbiXmHrSi/yxMxox/EqUxuu
         iqDNTdXhKhueXZCkqZ3IuKTZhJjPemUlW0TWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736157678; x=1736762478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8o9WFlNd3QzSxtSoTJJx9jfQ6BY4QYc+w6YqL60yedc=;
        b=C8SKFbYgMDOh3kCTo5+jHzsador3BUM53D1qKIbXq0RQAcsRfBqBjdmgNDVTArKllB
         tvN0QRVoWBJXrEzZtVcvil/xcGci7gj2u2yJUszojFfMcW7fHDRPTQdwXCRB1TubuH3h
         ExqZuRDKrJYPF3+4RsKfbjM0lsxTRzTFEV6MrUM4Hneg8T3dSu8Qga29V5hypq/BRSjk
         WH0bJa0K7WU8lkO2Q99y8C+MY1T8/UrOxMLYCb55PHRAdg66i4Yf2ceh6nbWBe6AuU4s
         xjza3XNQAfD1PNr47HgejP4YQm/A7jodlWpsadDf5e5scCpNww8EkuHu4wMo127bkc5G
         xwmg==
X-Gm-Message-State: AOJu0Yy70H2g62XEzgnoRZINTzr8w+R6jQYUNWXQf04flBa51RN9sYMz
	+ARZzZlOYWCZQRDmcyCLIb7Z4OKwC7z/UUOPtr+0yc+hoEncthrn8dCrF6qt2A==
X-Gm-Gg: ASbGncsSYBnLLtLDH/wCN7EFY5ltBINx6+tyq0kUNEiatR0BnsJxz1/2E3T2dgJ8CiK
	yTWzGD2xJQu8gB0/aZTKchSuG5j4iPK/k1vpZIonLr7ZTVGQnL940yT5gODJG8Bwt+VEhfQfAcc
	pnKPDpSPzJQsjosgRXrJHPzPw9DTqIkMJALIA5MBtrayjcxsZx0VKG2o/w7xbZpiRqu+grMjOLQ
	xaFCL8SKK1ucwt8Ke4G1DBwyt/hsfixID3jXxFpnLCRtQVgteooXkhGVENAzxZEcFPHRV3wtE03
	MU6kJ/9UEXDxXoIROx2miYj/WMWOuZll3KZKsRUA8vsergx+s+lme1HFS2Y=
X-Google-Smtp-Source: AGHT+IEd2q14C4MhA4ueExMjiPAYsBYdp14yQDVoviQRpaR1/NL41uYc045r5r4zuhiR2m5Lg+RHTQ==
X-Received: by 2002:a17:90b:270d:b0:2ee:dd9b:e3e8 with SMTP id 98e67ed59e1d1-2f452dfd3b6mr94123081a91.8.1736157678070;
        Mon, 06 Jan 2025 02:01:18 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9d4c89sm282325265ad.124.2025.01.06.02.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 02:01:17 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	michael.chan@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH for-next v2 2/4] RDMA/bnxt_re: Add Async event handling support
Date: Mon,  6 Jan 2025 15:23:47 +0530
Message-ID: <20250106095349.2880446-3-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250106095349.2880446-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250106095349.2880446-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using the option provided by Ethernet driver, register for FW Async
event. During probe, while registering with Ethernet driver, provide
the ulp hook 'ulp_async_notifier' for receiving the firmware events.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h |  1 +
 drivers/infiniband/hw/bnxt_re/main.c    | 47 +++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 2975b11b79bf..018386295bcd 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -229,6 +229,7 @@ struct bnxt_re_dev {
 	DECLARE_HASHTABLE(srq_hash, MAX_SRQ_HASH_BITS);
 	struct dentry			*dbg_root;
 	struct dentry			*qp_debugfs;
+	unsigned long			event_bitmap;
 };
 
 #define to_bnxt_re_dev(ptr, member)	\
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 6d1800e285ef..1dc305689d7b 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -295,6 +295,20 @@ static void bnxt_re_vf_res_config(struct bnxt_re_dev *rdev)
 				      &rdev->qplib_ctx);
 }
 
+static void bnxt_re_async_notifier(void *handle, struct hwrm_async_event_cmpl *cmpl)
+{
+	struct bnxt_re_dev *rdev = (struct bnxt_re_dev *)handle;
+	u32 data1, data2;
+	u16 event_id;
+
+	event_id = le16_to_cpu(cmpl->event_id);
+	data1 = le32_to_cpu(cmpl->event_data1);
+	data2 = le32_to_cpu(cmpl->event_data2);
+
+	ibdev_dbg(&rdev->ibdev, "Async event_id = %d data1 = %d data2 = %d",
+		  event_id, data1, data2);
+}
+
 static void bnxt_re_stop_irq(void *handle)
 {
 	struct bnxt_re_en_dev_info *en_info = auxiliary_get_drvdata(handle);
@@ -361,6 +375,7 @@ static void bnxt_re_start_irq(void *handle, struct bnxt_msix_entry *ent)
 }
 
 static struct bnxt_ulp_ops bnxt_re_ulp_ops = {
+	.ulp_async_notifier = bnxt_re_async_notifier,
 	.ulp_irq_stop = bnxt_re_stop_irq,
 	.ulp_irq_restart = bnxt_re_start_irq
 };
@@ -1785,6 +1800,34 @@ static int bnxt_re_setup_qos(struct bnxt_re_dev *rdev)
 	return 0;
 }
 
+static void bnxt_re_net_unregister_async_event(struct bnxt_re_dev *rdev)
+{
+	int rc;
+
+	if (rdev->is_virtfn)
+		return;
+
+	memset(&rdev->event_bitmap, 0, sizeof(rdev->event_bitmap));
+	rc = bnxt_register_async_events(rdev->en_dev, &rdev->event_bitmap,
+					ASYNC_EVENT_CMPL_EVENT_ID_DCB_CONFIG_CHANGE);
+	if (rc)
+		ibdev_err(&rdev->ibdev, "Failed to unregister async event");
+}
+
+static void bnxt_re_net_register_async_event(struct bnxt_re_dev *rdev)
+{
+	int rc;
+
+	if (rdev->is_virtfn)
+		return;
+
+	rdev->event_bitmap |= (1 << ASYNC_EVENT_CMPL_EVENT_ID_DCB_CONFIG_CHANGE);
+	rc = bnxt_register_async_events(rdev->en_dev, &rdev->event_bitmap,
+					ASYNC_EVENT_CMPL_EVENT_ID_DCB_CONFIG_CHANGE);
+	if (rc)
+		ibdev_err(&rdev->ibdev, "Failed to unregister async event");
+}
+
 static void bnxt_re_query_hwrm_intf_version(struct bnxt_re_dev *rdev)
 {
 	struct bnxt_en_dev *en_dev = rdev->en_dev;
@@ -1864,6 +1907,8 @@ static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev, u8 op_type)
 
 	bnxt_re_debugfs_rem_pdev(rdev);
 
+	bnxt_re_net_unregister_async_event(rdev);
+
 	if (test_and_clear_bit(BNXT_RE_FLAG_QOS_WORK_REG, &rdev->flags))
 		cancel_delayed_work_sync(&rdev->worker);
 
@@ -2077,6 +2122,8 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 
 	bnxt_re_debugfs_add_pdev(rdev);
 
+	bnxt_re_net_register_async_event(rdev);
+
 	return 0;
 free_sctx:
 	bnxt_re_net_stats_ctx_free(rdev, rdev->qplib_ctx.stats.fw_id);
-- 
2.43.5


