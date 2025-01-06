Return-Path: <linux-rdma+bounces-6830-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B697A0225E
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 11:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA0A33A3113
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 10:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8AF1DA309;
	Mon,  6 Jan 2025 10:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="N6dFMUVX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24951DACBE
	for <linux-rdma@vger.kernel.org>; Mon,  6 Jan 2025 10:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736157680; cv=none; b=HZQzCvI7YBxxgO/PDJmcVl87kZGVAWLFv24puFpnOjU+a3QueeCS4d5l1KcRcX5U8C2KHiiMHuLD3TXTnb9T1GXzBPyX2AGEzM4XwjXlbMbZCeBr+3d0KXP5DO7e4zYkznmPtxcSJtcW3KDfEYu4Oz6O9fFX08gATAAGRuuKlow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736157680; c=relaxed/simple;
	bh=dkUGgPaQv0HlenJL6h3glKDnebubexeUid88hsJAWbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MSRAg8wFE6CsK0z9ebcPoKX9QamUGJvQ51t9rAv42VFcYZp6rpDlcMgGUgFJPFhHmaIf8SOd4udBqeLCOOLKXzWO01W48xjOFItx+ULELCVYK5yHn5sHxqEX+M6r+BaB60I2VfXGhhqh9KY8VPC+ou8k++UKepBoeP+HX8FYjBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=N6dFMUVX; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ee50ffcf14so18063832a91.0
        for <linux-rdma@vger.kernel.org>; Mon, 06 Jan 2025 02:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736157675; x=1736762475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2T8x/Y3tf5HzBNGI9qqdrAzuAwQcN9/qZhlm85+Qs5I=;
        b=N6dFMUVXJ7AddsG7ZSmUaE6E+/6bYxK9qmamDeUmLa1YuP+bHC+zcSmrTSB/hafWSj
         WzGFpWxdGstBgwTXkczmV5mmfN22ZWGUTNQCWkX9+b9Fy9gPjW0RCA+76lG5r+QTYoWU
         fwqtzVdd3oZKdl+OYbAyEAraRs2sRR+qnTWlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736157675; x=1736762475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2T8x/Y3tf5HzBNGI9qqdrAzuAwQcN9/qZhlm85+Qs5I=;
        b=AR8ycgAPZmZzzXpAk3B3xSEVR34k/sN2z0AQeOzfxk80jL+FiJkzKG+hLQHE9gqgaQ
         j6r9FhquoBLjlU/LpxcvDm0CkDYdfweZc+ggBQx/qnRIO3yQO5qhbgGGMlLReH9S1h9z
         yjqb4za4sZI3rWqO3AOQHpBgdlWr4kEjKQZSx4niHax9T4qutftwuKCF831JHMKjVnP0
         uUAYO67e/+fN492UqqTanZ1UtI4wy2NctiCNDY2Yvva2XtpWRismZd32aTQkHGHzimRi
         gjxL1HLxM2FKFblDd+W/dd+CE7ezQ1Y5fuHyTTWUHlbGXTRAwisP8DLXCRQ5RhefK6VQ
         BF7w==
X-Gm-Message-State: AOJu0Ywv9ABh13p7VoBIYAsrEhIxFd04RcrcULuTPMLridl+H0sB55+H
	HtSPRrxHUTSNR+eLyQ/c+fErTzV64qGFH+1FTmj/rA/pGPF19ichHe4VpSHU5w==
X-Gm-Gg: ASbGncvrNnjyvslWShVao1+Ofyn1KJtn8TGWJ3xL6hGbZAG/Spa8/sBoc8UxHrblSP2
	Sx98RQzZXtzmXunSvZ4fK7EDjoGYeQSJGIUddaaN0HMeBj03+BHfTqqR2+QLFp0S+geqQ7nJM2t
	FYe9qHHmiUoFBzG5zwHFUCIVa0cktovy9PVid2ZQIdR1Rcrl1A1pIYemIVB/MToqvfAcdVHd9Ya
	dvq7ZrHWsQd8zEhOUOURQFGRhWNiReyaT18NMezy4r9FyouAHmui8i0a5x5fg37Ib7gy69LTXyK
	G5GbJrJYxKzWs06rkwSvRQgC6AQWCR3VSbhcRcevx+ZbM388V1zl2AYV9+k=
X-Google-Smtp-Source: AGHT+IH/p6VZCsq0t7Vz4+ThpBBAneezcxlQJfXCSiciqSdetfKb/I/EW/XuINbyv0knEcxWg/qVyw==
X-Received: by 2002:a17:90b:544e:b0:2ee:7504:bb3d with SMTP id 98e67ed59e1d1-2f4534d62ffmr91368854a91.0.1736157674796;
        Mon, 06 Jan 2025 02:01:14 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9d4c89sm282325265ad.124.2025.01.06.02.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 02:01:13 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	michael.chan@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH for-next v2 1/4] bnxt_en: Add ULP call to notify async events
Date: Mon,  6 Jan 2025 15:23:46 +0530
Message-ID: <20250106095349.2880446-2-kalesh-anakkur.purayil@broadcom.com>
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

From: Michael Chan <michael.chan@broadcom.com>

When the driver receives an async event notification from the Firmware,
we make the new ulp_async_notifier() call to inform the RDMA driver that
a firmware async event has been received. RDMA driver can then take
necessary actions based on the event type.

In the next patch, we will implement the ulp_async_notifier() callbacks
in the RDMA driver.

Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 28 +++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h |  2 ++
 3 files changed, 31 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 4ec4934a4edd..25850730071b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2857,6 +2857,7 @@ static int bnxt_async_event_process(struct bnxt *bp,
 	}
 	__bnxt_queue_sp_work(bp);
 async_event_process_exit:
+	bnxt_ulp_async_events(bp, cmpl);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index b771c84cdd89..59c280634bc5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -345,6 +345,34 @@ void bnxt_ulp_irq_restart(struct bnxt *bp, int err)
 	}
 }
 
+void bnxt_ulp_async_events(struct bnxt *bp, struct hwrm_async_event_cmpl *cmpl)
+{
+	u16 event_id = le16_to_cpu(cmpl->event_id);
+	struct bnxt_en_dev *edev = bp->edev;
+	struct bnxt_ulp_ops *ops;
+	struct bnxt_ulp *ulp;
+
+	if (!bnxt_ulp_registered(edev))
+		return;
+	ulp = edev->ulp_tbl;
+
+	rcu_read_lock();
+
+	ops = rcu_dereference(ulp->ulp_ops);
+	if (!ops || !ops->ulp_async_notifier)
+		goto exit_unlock_rcu;
+	if (!ulp->async_events_bmap || event_id > ulp->max_async_event_id)
+		goto exit_unlock_rcu;
+
+	/* Read max_async_event_id first before testing the bitmap. */
+	smp_rmb();
+
+	if (test_bit(event_id, ulp->async_events_bmap))
+		ops->ulp_async_notifier(ulp->handle, cmpl);
+exit_unlock_rcu:
+	rcu_read_unlock();
+}
+
 int bnxt_register_async_events(struct bnxt_en_dev *edev,
 			       unsigned long *events_bmap,
 			       u16 max_id)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
index 5d6aac60f236..a21294cf197b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
@@ -30,6 +30,8 @@ struct bnxt_msix_entry {
 };
 
 struct bnxt_ulp_ops {
+	/* async_notifier() cannot sleep (in BH context) */
+	void (*ulp_async_notifier)(void *, struct hwrm_async_event_cmpl *);
 	void (*ulp_irq_stop)(void *);
 	void (*ulp_irq_restart)(void *, struct bnxt_msix_entry *);
 };
-- 
2.43.5


