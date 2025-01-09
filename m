Return-Path: <linux-rdma+bounces-6937-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA66A07FFD
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2025 19:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71EA77A3D8F
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2025 18:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6651F1B0416;
	Thu,  9 Jan 2025 18:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NXz9fnyW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB181ACEC8
	for <linux-rdma@vger.kernel.org>; Thu,  9 Jan 2025 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736447944; cv=none; b=ge2X/Zx7rF64VJUpqYk8qhNuonUhVeWGXtyci1bwjFxKM9cwOnL+rUbggutZcv8R7BNNLom9u5rkeRgKXEtrNO2AQKMcUhKz1r+SxkHf7jXFW3uNDufoQPjuXPY8w+Qizb8uSdJZg0sS8iQ0SWrS6Qo2H292W8a8WyVo3mFR0K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736447944; c=relaxed/simple;
	bh=AZ8T2q/mEWPO9L0RpQGp0jnsw9BhPcK7arnxicgNrGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=c0oTZnsJpE3Cobcw9/pK6wcKKJX7MdrE1XaaNIabtKRYZXBEgGJM2e4oMKJE51zPtmarkdyZ4b066jdZg9jBPE+DS//TIqcf9FQr9vJu9fP9qPUxZhncijqbBK1mlPqzyB9YhY1PZQ/KBqyWDqONiUMcvYBto03Yq5nX9WjVQ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NXz9fnyW; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-216395e151bso15492285ad.0
        for <linux-rdma@vger.kernel.org>; Thu, 09 Jan 2025 10:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736447942; x=1737052742; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1q7jYLcw3aU3ZPAOJXyzP/7DRYB7R5v04IV20wQz2WQ=;
        b=NXz9fnyWBn0jQ6A81aXcY7A9yl/nLRqoVVLAa0QOdJrIu1Xu3t5p0Np+Fwf7dWh6iw
         5Jf97y8deIShWN9h+L7MZN3GlGyg57jF5tff/RidQgBRNKZYX0pIpVLfP0zeRe4vdOqU
         8S0Rf20k0HDjXsPTTbOXZqEx825FJbPBpFIUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736447942; x=1737052742;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1q7jYLcw3aU3ZPAOJXyzP/7DRYB7R5v04IV20wQz2WQ=;
        b=M161pjN1VFL1JuUQLnVrAS3I5jGBJKazZ2ITlM+BYml6YJ+BpE1dru1LFaX0G87Jap
         QXmzv/3607daSVJ0QTFAzYRY3eJNomDLDSfORVaqPxkhmw8jO8n5Uc7ihGYd+8L0+mrb
         IymGajrYB18sO0ShMRR6OTZ/LvxaO+crgL8XacqhqEdYtvwnrqFRkmgDSJdU5jWK8uPi
         +A9BnIOQBzItcUtFnnmEoeRMVMpIzubitFclIKayuU/NbmbLEBYyF4pAiOpsev4mW9M9
         8n16rYOE6OFBTPmrvivnmt2LC3/GV2KRujzLKM54A16pPsBdbfoXZ8iaZaFFcrdY7VH+
         Wpuw==
X-Gm-Message-State: AOJu0Ywodj/KonCKbY1+9t/RY7Zfxw5iKZMq7bdJ/3bhJDxwWWxtT0sx
	v1bn5XrqgDo5BpA1hBrzn1BLV+QfMegwJXNBDwb13CzbeN6IxXwv0+NVpcQSPqPhMKHvFpHjjvo
	5Og==
X-Gm-Gg: ASbGncujBV0ixONSMgoNT4N/dqlyNs4hrrMfWCZ/hhKOCgcSJAGl1SQy/MxJKLKcJcj
	eCXQJwFcqvVluWk4VZLscx82yIdbysiyWl3FO94PlqK03HUWb/OOVhRBN96HVsviYaZW5TjoE9/
	yyE+e4wNcY+NYZ6LaNXflDctlDiHF/EyR2mAhgUiy7Sh/7UbZvGe+BKjqv7uw08mrtgea7J8Aht
	u9QScZ67CAJmhCt/S9YXyEjFDqaf8t/ItvoCb9yf8UvefkvjBYe633kCN7+XW34K1X1q8hN2+Cq
	o1Jte4nWaqzXTs5tc0xcyWPWCYEGjaW4T18m
X-Google-Smtp-Source: AGHT+IHNpDbxByazLeEhL4lRFZpRwZU1oy/AbAn+tqvA49U+i59yO3rusOPo/Zu0da/iI+3eiZMGxA==
X-Received: by 2002:a17:902:f542:b0:216:11cf:7b1 with SMTP id d9443c01a7336-21a8d666e13mr64852445ad.15.1736447941844;
        Thu, 09 Jan 2025 10:39:01 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22dd30sm1017475ad.171.2025.01.09.10.38.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jan 2025 10:39:01 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 1/2] RDMA/bnxt_re: Pass the context for ulp_irq_stop
Date: Thu,  9 Jan 2025 10:18:12 -0800
Message-Id: <1736446693-6692-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1736446693-6692-1-git-send-email-selvin.xavier@broadcom.com>
References: <1736446693-6692-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

ulp_irq_stop() can be invoked from a context where FW is healthy or
when FW is in a reset state. In the latter case, ULP must stop all
interactions with HW/FW and also with application and stack. Added a
new parameter to the ulp_irq_stop() function to achieve that.

Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Reviewed-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c          | 12 +++++++++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c |  5 ++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h |  2 +-
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 1988bf88..33956fc 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -83,6 +83,8 @@ static int bnxt_re_hwrm_qcaps(struct bnxt_re_dev *rdev);
 
 static int bnxt_re_hwrm_qcfg(struct bnxt_re_dev *rdev, u32 *db_len,
 			     u32 *offset);
+static void bnxt_re_dispatch_event(struct ib_device *ibdev, struct ib_qp *qp,
+				   u8 port_num, enum ib_event_type event);
 static void bnxt_re_set_db_offset(struct bnxt_re_dev *rdev)
 {
 	struct bnxt_qplib_chip_ctx *cctx;
@@ -411,7 +413,7 @@ static void bnxt_re_async_notifier(void *handle, struct hwrm_async_event_cmpl *c
 	}
 }
 
-static void bnxt_re_stop_irq(void *handle)
+static void bnxt_re_stop_irq(void *handle, bool reset)
 {
 	struct bnxt_re_en_dev_info *en_info = auxiliary_get_drvdata(handle);
 	struct bnxt_qplib_rcfw *rcfw;
@@ -422,6 +424,14 @@ static void bnxt_re_stop_irq(void *handle)
 	rdev = en_info->rdev;
 	rcfw = &rdev->rcfw;
 
+	if (reset) {
+		set_bit(ERR_DEVICE_DETACHED, &rdev->rcfw.cmdq.flags);
+		set_bit(BNXT_RE_FLAG_ERR_DEVICE_DETACHED, &rdev->flags);
+		wake_up_all(&rdev->rcfw.cmdq.waitq);
+		bnxt_re_dispatch_event(&rdev->ibdev, NULL, 1,
+				       IB_EVENT_DEVICE_FATAL);
+	}
+
 	for (indx = BNXT_RE_NQ_IDX; indx < rdev->nqr->num_msix; indx++) {
 		nq = &rdev->nqr->nq[indx - 1];
 		bnxt_qplib_nq_stop_irq(nq, false);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index 59c2806..8541e8d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -297,6 +297,7 @@ void bnxt_ulp_irq_stop(struct bnxt *bp)
 {
 	struct bnxt_en_dev *edev = bp->edev;
 	struct bnxt_ulp_ops *ops;
+	bool reset = false;
 
 	if (!edev || !(edev->flags & BNXT_EN_FLAG_MSIX_REQUESTED))
 		return;
@@ -310,7 +311,9 @@ void bnxt_ulp_irq_stop(struct bnxt *bp)
 		ops = rtnl_dereference(ulp->ulp_ops);
 		if (!ops || !ops->ulp_irq_stop)
 			return;
-		ops->ulp_irq_stop(ulp->handle);
+		if (test_bit(BNXT_STATE_FW_RESET_DET, &bp->state))
+			reset = true;
+		ops->ulp_irq_stop(ulp->handle, reset);
 	}
 }
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
index a21294c..45f3571 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
@@ -32,7 +32,7 @@ struct bnxt_msix_entry {
 struct bnxt_ulp_ops {
 	/* async_notifier() cannot sleep (in BH context) */
 	void (*ulp_async_notifier)(void *, struct hwrm_async_event_cmpl *);
-	void (*ulp_irq_stop)(void *);
+	void (*ulp_irq_stop)(void *, bool);
 	void (*ulp_irq_restart)(void *, struct bnxt_msix_entry *);
 };
 
-- 
2.5.5


