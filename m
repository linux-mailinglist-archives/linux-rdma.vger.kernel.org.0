Return-Path: <linux-rdma+bounces-15309-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E05BCF527D
	for <lists+linux-rdma@lfdr.de>; Mon, 05 Jan 2026 19:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40392302D3AC
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jan 2026 18:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332E7328625;
	Mon,  5 Jan 2026 18:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nH4pnKjB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1332F6911
	for <linux-rdma@vger.kernel.org>; Mon,  5 Jan 2026 18:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767636355; cv=none; b=Gjc9QFnRNBp6dvJpfVxX+gHQLa4vaB0eiJDaXsRGVVUVRqFRQXD1GmXapYsHZupDYV4/8gwrazcYSrmjh3lGOdI7PWAteoqVzVcrxMl8PVu4uzRRa1nzPyKsQOONOzPQ35oQNBnRLr0+eiN1hzph/Y+walJ6qceyuyslOyeUkIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767636355; c=relaxed/simple;
	bh=YCyF7cvbQH+q78vI4df4Y66o65mWldPU1/uIsAXFp4g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Xe2/Dfctiai1Kuv/GdC9LwYL1KK3iVGanuGnWOYzryVh83iKNHIWtYXroVJxAq2HgrRZD7tu52ofYQGvzuzD12tdnMVZoo1OR4db0/QsXv+i/KIQUAYa9EzE34iTieEbu9crP+Tn4UzE/YTHtix35qiF3PfdF3SvDS/zNZR0Efc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nH4pnKjB; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4ee1b7293e7so5578521cf.0
        for <linux-rdma@vger.kernel.org>; Mon, 05 Jan 2026 10:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767636352; x=1768241152; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DUTFqXYNeHk0NIq2Y8aPEtM74BaVRnqo4H7E8HKdnUc=;
        b=nH4pnKjBwjvRNe960ePEHklhXnUxmgTQwkUwTf1aLFFcWL/FKD6Ay232Jin2Zj3Lfy
         CBEb/AhLTl/crfgZ3lPoUWhUSn0w6tzuaM9Rs+tJP1pSIGr0LfOFYARitr3yJWETLlrD
         8M/jxc3aKgJZrvs/LXdxGlKDOKw7ILTRt4qBlfMOijfQ5pVVLsspth15beGa9CUCs5Lb
         mm+bt5sAOUi/np7TDIum5ZFximG8nNvdBM734uh5/as7FEhD+7mxs8ByNpDNxI3HvUyD
         BQd+TgdbKu9RbTPi20IqjAuCAXXqHHkBKOX0PbyDeFhJSPSS5EvYebgJeG9r86JyafrO
         7Ebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767636352; x=1768241152;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DUTFqXYNeHk0NIq2Y8aPEtM74BaVRnqo4H7E8HKdnUc=;
        b=NeaT3OZF4r/Y1Hgit8HFeXxaBvXzoZL11I/czN793/H0yvzXaiKxIPvcAX8M357XZF
         fU0S0iQKnECuW7ttbndFzUupWZ0hXUpu6FOJDH6eWLUYuPseNveDypWTRhJelcLDJpYg
         YXYjB4AL3LzD3JvKSk7lGroPS/5kOc0TZY7qkJ3/nhVO6kx6chYgC+AJcbd1JMyh4hH/
         W3TzcCMEuxjLUo+1K1JKlt3NVKMQOjSrQ+tHoD0gSNR8Q29unLh6YNOefB6taQdhO2Gh
         3xKthpIJtYM30H++LviaSDUo/SOy0hTMYCsaRZuFFklq9VjzdCR8y1FYny0B6kYug5YM
         7JjA==
X-Forwarded-Encrypted: i=1; AJvYcCUIaaRcloN2T+KMDl+AYiJj3bRYJsln6O4nx9ADiNiMfRgLNmYUkWGhU3HOs0SCxlg2ZYxYRLoldXGC@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtd3htFyRdE+kqVGKbPY45LpZw5I1nHqYW6uGUSZzjrzaapUSW
	HOhFu9bx20ZH5p8kLXXYw65XhIvqM21/VDwx/IPs58zFmxWS5poFjbutdqzXx588FRAHLx8gPGk
	qNzjJYs3FrA==
X-Google-Smtp-Source: AGHT+IEotxnMoM+FPQdcGf/RTwZRjntvYRQ/r+0emzrw6xu07anlWyk5s7BWHPRZRqCZk/XRdf8vAffeeVPI
X-Received: from qvbpj11.prod.google.com ([2002:a05:6214:4b0b:b0:88a:25ce:560c])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:ac8:5741:0:b0:4ff:4a7c:da11
 with SMTP id d75a77b69052e-4ffa76a1195mr5376741cf.11.1767636351978; Mon, 05
 Jan 2026 10:05:51 -0800 (PST)
Date: Mon,  5 Jan 2026 18:05:50 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260105180550.2907858-1-jmoroni@google.com>
Subject: [PATCH rdma-next] RDMA/irdma: Remove fixed 1 ms delay during AH wait loop
From: Jacob Moroni <jmoroni@google.com>
To: tatyana.e.nikolova@intel.com, krzysztof.czurylo@intel.com
Cc: jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org, 
	Jacob Moroni <jmoroni@google.com>
Content-Type: text/plain; charset="UTF-8"

The AH CQP command wait loop executes in an atomic context and was
using a fixed 1 ms delay. Since many AH create commands can complete
much faster than 1 ms, use poll_timeout_us_atomic with a 1 us delay.

Also, use the timeout value indicated during the capability exchange
rather than a hard-coded value.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/hw/irdma/main.h  |  2 ++
 drivers/infiniband/hw/irdma/utils.c |  2 +-
 drivers/infiniband/hw/irdma/verbs.c | 16 ++++++++--------
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index baab61e42..d320d1a22 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -23,6 +23,7 @@
 #include <linux/workqueue.h>
 #include <linux/slab.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/crc32c.h>
 #include <linux/kthread.h>
 #ifndef CONFIG_64BIT
@@ -528,6 +529,7 @@ void irdma_cq_wq_destroy(struct irdma_pci_f *rf, struct irdma_sc_cq *cq);
 void irdma_srq_event(struct irdma_sc_srq *srq);
 void irdma_srq_wq_destroy(struct irdma_pci_f *rf, struct irdma_sc_srq *srq);
 void irdma_cleanup_pending_cqp_op(struct irdma_pci_f *rf);
+int irdma_get_timeout_threshold(struct irdma_sc_dev *dev);
 int irdma_hw_modify_qp(struct irdma_device *iwdev, struct irdma_qp *iwqp,
 		       struct irdma_modify_qp_info *info, bool wait);
 int irdma_qp_suspend_resume(struct irdma_sc_qp *qp, bool suspend);
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index cc2a12f73..3bac7c258 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -572,7 +572,7 @@ void irdma_cleanup_pending_cqp_op(struct irdma_pci_f *rf)
 	}
 }
 
-static int irdma_get_timeout_threshold(struct irdma_sc_dev *dev)
+int irdma_get_timeout_threshold(struct irdma_sc_dev *dev)
 {
 	u16 time_s = dev->vc_caps.cqp_timeout_s;
 
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 6d9af41a2..1f1efd497 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -5027,15 +5027,15 @@ static int irdma_create_hw_ah(struct irdma_device *iwdev, struct irdma_ah *ah, b
 	}
 
 	if (!sleep) {
-		int cnt = CQP_COMPL_WAIT_TIME_MS * CQP_TIMEOUT_THRESHOLD;
+		const u64 tmout_ms = irdma_get_timeout_threshold(&rf->sc_dev) *
+			CQP_COMPL_WAIT_TIME_MS;
 
-		do {
-			irdma_cqp_ce_handler(rf, &rf->ccq.sc_cq);
-			mdelay(1);
-		} while (!ah->sc_ah.ah_info.ah_valid && --cnt);
-
-		if (!cnt) {
-			ibdev_dbg(&iwdev->ibdev, "VERBS: CQP create AH timed out");
+		if (poll_timeout_us_atomic(irdma_cqp_ce_handler(rf,
+								&rf->ccq.sc_cq),
+					   ah->sc_ah.ah_info.ah_valid, 1,
+					   tmout_ms * USEC_PER_MSEC, false)) {
+			ibdev_dbg(&iwdev->ibdev,
+				  "VERBS: CQP create AH timed out");
 			err = -ETIMEDOUT;
 			goto err_ah_create;
 		}
-- 
2.52.0.351.gbe84eed79e-goog


