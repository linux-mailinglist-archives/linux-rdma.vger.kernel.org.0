Return-Path: <linux-rdma+bounces-6851-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F85A03583
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 03:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A6AD3A4360
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 02:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D76618A6B8;
	Tue,  7 Jan 2025 02:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DX/hb4z7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE08157493
	for <linux-rdma@vger.kernel.org>; Tue,  7 Jan 2025 02:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736218413; cv=none; b=OP5BvYIOYstrbY8jNXNw/lpwskHOhTCwX/HioB3yMOCjNC5eE3TcaZztCHuiNUDDZMA/nhWudNWHBDa4A+lrSTpXHiYBRzVamhJ6jeEbGhz9EVjWQPMWTIfKZZtiUX/zCRV6VGre9MaBu1P9pVeJvXDCJgXFNXDfIMOa6FvU7k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736218413; c=relaxed/simple;
	bh=CFt2wRtVsghTC9fPCTpEo5HM5TJN8QOuhLfOm6ek8ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JOt8gkB3c3PWTZSmMenzBhEGBlw7r1BfDBR8+I39M1e3DVkce94mWNHUaSXSxJOzhDc4CotZAza5duWl26Ts+vE2AX6hs25TGUrWKqMxwpv+k60sy62704as9kZaa7SHG0KbA8ZqJsixreDbeiXzGN7tLGAi0QpzzR2J/JZGWR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DX/hb4z7; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2164b1f05caso213679635ad.3
        for <linux-rdma@vger.kernel.org>; Mon, 06 Jan 2025 18:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736218410; x=1736823210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSGckmjUr1gcXmHMYI9glP3WZPfHuctvVdT8PdD1UKk=;
        b=DX/hb4z7F/Qdk8AFi2XSlv1cgvGlB/uul+RhEHIZplAXoWGwA7jNp2nMJOwre+2vVD
         yAzh5gBTj17KDIEB4L0JSE+jIMA7NwTgAPXWnnT2SZw0yPixp4E6wXYzY0vljXWU77VH
         lPlENAahI88sRkW1pGbg8Lw6yKI/l0MVkL0QI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736218410; x=1736823210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GSGckmjUr1gcXmHMYI9glP3WZPfHuctvVdT8PdD1UKk=;
        b=FXB/D7ny45UzhQSmFvVv7SJb3QNvk5TFFN5rU8eSupWCFr0XAM7MO0codZLFkelW4x
         l3y4hkWNBQ1nz6alZePAlR8qBLWEXt5avZKe12qJRI0+x3KG6JGCr9JYsoIW16x8HSR8
         7tMFGfzLFaVEJqtYjMbvm7j1Wwfz8co8vHKnbxkJW4lL6GJ36Z88WO0H/YZjJCMKJhV9
         V6E6N+XzpaoFbSRCl2L86QtOLfZZBYsVd8El8yF8YjheeCe1JOh2H2z7zDAXk+udE8j/
         AxdyjjB+w8BjZ8ujapRyFUC9H/aEFZvEs/vF/j1B2mNgL3NgyJwxmvqv0oxD4V0vrdm6
         XhuA==
X-Gm-Message-State: AOJu0Yy/jIprajiNxlf5Ky0oWBU5D0lcDi6kwctONhf4ux3H+DrUnh0A
	56Lhbn/f5h2d8jI3RCZKzTcFQcnz70BTiyamUxsqsIxKWv18S4jujJxLOkv9rA==
X-Gm-Gg: ASbGncsze+poi3wriocyza8lNFz3B+2BbRCvBsKuDNwg9IzKzI5uIvIAX0VEcvqZ+Kg
	iBF3TWXBNAbGZDNSQz3lxS4LJkVQPUJYBWNNfY/lohEHmH1Su4fhtb+IoKza9492vx7ETDrgVT7
	1Ofa7ld21yGCeEjcGPfAsd1US9PuQeET8Xdm4BWmN966jFuPR/E6GuIfwejjiExZaJW5ql+qn7M
	MsnGnArvd6l/NH/7YMBPOzd3r6MhNyzeeBrX2kNCt4V3phcBL3C9DAwuK3PBJBNrSGDZbJpnae4
	wJNEqHDtBkIJBVxbbEsk2x7NWAoB1lh530YJMIemCLjlWRtQvoGRCKN25dE=
X-Google-Smtp-Source: AGHT+IF8L9qH9kH4c40fqzSLcDB2Cq23VhevoV2vqYcWkmBP/ZD2HoBe7xwgmrWqd3aL19PBH0l0bA==
X-Received: by 2002:a17:902:e546:b0:215:9894:5670 with SMTP id d9443c01a7336-219e6ea26b3mr726800715ad.16.1736218409764;
        Mon, 06 Jan 2025 18:53:29 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f692fsm300093285ad.216.2025.01.06.18.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 18:53:29 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-next v2 RESEND 2/4] RDMA/bnxt_re: Add Async event handling support
Date: Tue,  7 Jan 2025 08:15:50 +0530
Message-ID: <20250107024553.2926983-3-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250107024553.2926983-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250107024553.2926983-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using the option provided by Ethernet driver, register for FW Async
event. During probe, while registeriung with Ethernet driver, provide
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


