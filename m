Return-Path: <linux-rdma+bounces-13598-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D271B964B4
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 16:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2679E162919
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 14:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA81A2E7F04;
	Tue, 23 Sep 2025 14:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JEiv2peg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5E52E7BD6
	for <linux-rdma@vger.kernel.org>; Tue, 23 Sep 2025 14:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637498; cv=none; b=dItVx8T1KhIRWbKzSAt6kCvZkav+8/peHiqlKJ8EJhyX5yb+qymYpTvbOMckvzRqe3VlrfxBQBgB4RBypwdTIBKD2adkaG2hKlzysBkP+V9+jyp0dHoJRz5d/hlTzGo57BRzk5YfDv/oJz3lLHZJHKsp1mmCHUko4yBaM/6s710=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637498; c=relaxed/simple;
	bh=B5hoI+7PLIBspWEraeorANR+f8dZPXfedgFU1uJFtv4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Q70dAR2B//oavZ86oosc7/kgTKSFX+E7JUYTdmwDCFYvmVOuLz/s7h0piTEWgQHQ4G1VbbhTR55q7zmlibQRqM8l6bgyztlg6w+FlInWOjXO01EbyUfynPxSSFi3bbBF6PxfS2Ps6g2Z3KcfdBDPCM2BuUJdnbEc9TirIu9rWYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JEiv2peg; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-eb30a3244c3so1110370276.2
        for <linux-rdma@vger.kernel.org>; Tue, 23 Sep 2025 07:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758637496; x=1759242296; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G5mPO8xqzsfGOpJZLw6D9GyICrN3KMKzSmwhoyBY1j4=;
        b=JEiv2pege822pFbQ8a9uL/BNXQpqwh1nJCMwe36hPKzCbIEOmIXt/tKUcmkzYesgMk
         AjOFocqP9lWHBUF6XKO2mKUQCL5mFexgLVgm5NzvzUHKZ4HB6OsNfI/sENdzf4Au5sJb
         gaJUFFY509m8zU9AYu714PbGc610LfmtQouoGrwUJRwF0gTm/RnbknwWC/xN//tMZeHn
         u2l+wTBFnY8Op09iIx/sDQOp3UOjyYzKMWOa9BIS6Tl5q7xaWq+yBdt2UOuF5yandXuw
         D63l214AhQLy6LmeAvmFumLjfBozWcpqPvLuUamsdZCnGSm9TOBL9VKNvmOuUgqMvqaj
         07tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758637496; x=1759242296;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G5mPO8xqzsfGOpJZLw6D9GyICrN3KMKzSmwhoyBY1j4=;
        b=vZ1pJMQxiRLXNztGgqIQagwH5jQD60cs0ffzkfA3vZFKxbfE/mIA1X5UMiKKfAIo5E
         VPoVqA/BZQEcEbFyoA/oIvF5TApYZwHN0cdWa4IFQObQ/B+1hSFbU/JjSUefPNNCXZ4O
         7PY8pyXURQjydNW1R3PUFR8JKcO6OArKxflCdtzcuZeBLFOSuiK4CogArDSzOFG3vZAm
         uXAuCJMRYIF3HIMzpDXsaCtgFHH/ID2UtZtRNx8My0Y2ALyeumX2b3E1w1hrietdJHTt
         ysIfcdsL/EVr2NDCoRUuFARXNE/vT8lyAEIFWR5gA1B3UuTAAuqJAEzKu384X8pMV36b
         SqSA==
X-Forwarded-Encrypted: i=1; AJvYcCXapS/67wv8gYd5I+6zMo+EhQJOKOK+ctF6j5ofJh+3ds5sfgNfVNqA8lKMpC4HPFRBlKhhrCD8GHlc@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6/LGJXtaPnVQQbKqJnkQgxeWuvuzELieU7ypVXv9x+VfYyDuE
	ZcQbEm+IqALSNjDa6a4gqHoBAWM4isL6bBL2aMTm1T6Qdx8/oElDD0gL9/xOhKYDd5Hvp8YY/Wk
	3XwVDy7h9mQ==
X-Google-Smtp-Source: AGHT+IHXOqs5ED8tpOMXSSLnwMjM+CYGLpFS0OLPYxaQn+r5X0g/gBXdJaqE4CGlpDcOboIQm2D/7oFujQX8
X-Received: from ybbeb3.prod.google.com ([2002:a05:6902:2783:b0:ea5:c7a7:28a0])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6902:4089:b0:ead:e880:b090
 with SMTP id 3f1490d57ef6-eb32e82b22cmr2481379276.21.1758637496106; Tue, 23
 Sep 2025 07:24:56 -0700 (PDT)
Date: Tue, 23 Sep 2025 14:24:39 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923142439.943930-1-jmoroni@google.com>
Subject: [PATCH rdma-next] RDMA/irdma: Set irdma_cq cq_num field during CQ create
From: Jacob Moroni <jmoroni@google.com>
To: tatyana.e.nikolova@intel.com
Cc: jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org, 
	Jacob Moroni <jmoroni@google.com>
Content-Type: text/plain; charset="UTF-8"

The driver maintains a CQ table that is used to ensure that a CQ is
still valid when processing CQ related AEs. When a CQ is destroyed,
the table entry is cleared, using irdma_cq.cq_num as the index. This
field was never being set, so it was just always clearing out entry
0.

Additionally, the cq_num field size was increased to accommodate HW
supporting more than 64K CQs.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 1 +
 drivers/infiniband/hw/irdma/verbs.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 646939e3d..fd13b190a 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2503,6 +2503,7 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 	spin_lock_init(&iwcq->lock);
 	INIT_LIST_HEAD(&iwcq->resize_list);
 	INIT_LIST_HEAD(&iwcq->cmpl_generated);
+	iwcq->cq_num = cq_num;
 	info.dev = dev;
 	ukinfo->cq_size = max(entries, 4);
 	ukinfo->cq_id = cq_num;
diff --git a/drivers/infiniband/hw/irdma/verbs.h b/drivers/infiniband/hw/irdma/verbs.h
index ed21c1b56..ac8b38701 100644
--- a/drivers/infiniband/hw/irdma/verbs.h
+++ b/drivers/infiniband/hw/irdma/verbs.h
@@ -140,7 +140,7 @@ struct irdma_srq {
 struct irdma_cq {
 	struct ib_cq ibcq;
 	struct irdma_sc_cq sc_cq;
-	u16 cq_num;
+	u32 cq_num;
 	bool user_mode;
 	atomic_t armed;
 	enum irdma_cmpl_notify last_notify;
-- 
2.51.0.534.gc79095c0ca-goog


