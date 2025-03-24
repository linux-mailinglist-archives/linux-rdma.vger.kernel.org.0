Return-Path: <linux-rdma+bounces-8910-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D4AA6D388
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Mar 2025 05:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF385188BCE0
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Mar 2025 04:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597C31EB3E;
	Mon, 24 Mar 2025 04:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Lh0pYdBI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DA436D
	for <linux-rdma@vger.kernel.org>; Mon, 24 Mar 2025 04:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742790328; cv=none; b=si6NTLhNGciKQQeq7al8WCerjbUJVnC9FA0+jIVSj7Kq0EVo01od8XtFra4KK9czXfZtxoIwXmvJdYpsjLMc+o7P+chaMBZXsqVoLPPJyqnR2mGiV1DeJHUYhtSeZqdmxvdpWt9OVRPM1eujPc7K4HI+P/L17i5Jh8XXahh4nQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742790328; c=relaxed/simple;
	bh=jlK3SOk+DPRoeBFQFY9IDHgQgwCu/g+dd/FpKPMHPE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SE5KuHSA8AxPpt5s75L0dpWdctIHFdoE7xhByNy32Shxc+IZDeUrx0SZBdHsKr60fOE6pTVhuaPX1UR1n0Sj7g6OoSyQ16aJUEtJtPel5bGehQ72C715KX17fLej3YXFxmv7JYVh5Vg/mHjsW/pf/ffYuY3LT3l0hTmjBlLgCMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Lh0pYdBI; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-225477548e1so67906605ad.0
        for <linux-rdma@vger.kernel.org>; Sun, 23 Mar 2025 21:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1742790326; x=1743395126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nccPZMF/3OPD4xflblSJtApsFVPzbW4EePugIjtZ7i8=;
        b=Lh0pYdBIl57GjD/b7G1t/8ORG7V81UjNme7ptrpwI03pAP8+X6Oqhl29+4vaahlcQa
         crXMVQCfIGevpOBqN+lv5n1fZOG/FGapyhj28A/B2BUHXuj1R2jNg0OW5+cLUp9CIWqu
         8bkgFrXvNF/ZVikQpPsMtJulp/OY0GxCcHo+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742790326; x=1743395126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nccPZMF/3OPD4xflblSJtApsFVPzbW4EePugIjtZ7i8=;
        b=P9bEWtBm5+dRdxH+ZspFk7XD2waJEOsaRnqQnrgVVww+GF92cxRcAwWqbU8BTZo8p5
         f5xYK56SghpFgXGiIjQ/M0pSTnNoN7U8ts6kSboqKIR5t5fl7QPRuUKC5M/XyloKpxvn
         7ml1gBZePk9kHAOoyXEiUCO1rbb2S7Z9Yrw1W/Ciy6mLMfBfYwhvkJ9SCh+kmcMgaPkz
         hfwRWTm4td7bkgqQYfFw8COA0xS9Vb1W2Ce1ixOWwvrL8enbcoROh8Ufak6n/M45VBk3
         rhVgzgcQbzlasWQSpTtLFiCyzWM3uO2eJD98xHJ7ZlBcuHQY7hzUzjDWdiyuFEcLMskY
         0RxQ==
X-Gm-Message-State: AOJu0YzRD0/KtWLHtXammnkRY5sEdLqzmsxobubtdNG9RIw/Y9HmQ4EN
	dWISFk6o+PDvWQlD/bxWfk1yUiCkhGus57iivMR1UhkC7dUQb4f4UYZxymk5ig==
X-Gm-Gg: ASbGncuhyahP3ZhoguwtmHLylcAlToCk3f6pHowhGaT/oCc81Sr3w1Tp1OuJUp3wdoK
	IL8o9zZdMgB/8/UKCmwOYTIIM41SBz+hgkQTfpJsnC/8JDdPq9hQlKfXvVd1q/Xib4Nk/zOPnuD
	nM7RgKuespVZMHA1SUxUuP2AOzv28VYe2e/1yHvP9ZMYpJmzG8iOfnhUW/s33zHtRiBx4jneVx4
	WMJPzscKw7uPaWlBev57u59jlaDO9z3zB+W8KmWAooOKywBNo2kSOpViPabs+SMJyPlpKIKB6Zn
	Xw/dh9uSbymMsxrYORlvDzJBBQtcItnXueMTfRvtZwCI4McR88RWaBJFYSHWHr8mlFmNjTHugHg
	QLl1xkWwfaM9l/TkGKL5PP2TRzCernlof0SUBqkX0cjfJnPw=
X-Google-Smtp-Source: AGHT+IFQqWlZdKd7YIkTo7hkLbrVLfjOSGFvwQwtdQpulvgs7Vp7pISxGEmdOO8kwk0zM2FRH99PBg==
X-Received: by 2002:a17:902:f706:b0:220:e63c:5aff with SMTP id d9443c01a7336-22780e2562dmr185918745ad.47.1742790325887;
        Sun, 23 Mar 2025 21:25:25 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811d9f1bsm60405895ad.166.2025.03.23.21.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 21:25:25 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-rc] RDMA/bnxt_re: Fix budget handling of notification queue
Date: Mon, 24 Mar 2025 09:39:35 +0530
Message-ID: <20250324040935.90182-1-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kashyap Desai <kashyap.desai@broadcom.com>

The cited commit in Fixes tag introduced a bug which can cause hang
of completion queue processing because of notification queue budget
goes to zero.

Found while doing nfs over rdma mount and umount.
Below message is noticed because of the existing bug.

kernel: cm_destroy_id_wait_timeout: cm_id=00000000ff6c6cc6 timed out. state 11 -> 0, refcnt=1

Fix to handle this issue -
Driver will not change nq->budget upon create and destroy of cq and srq
rdma resources.

Fixes: cb97b377a135 ("RDMA/bnxt_re: Refurbish CQ to NQ hash calculation")
Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 6f5db32082dd..cb9b820c613d 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1784,8 +1784,6 @@ int bnxt_re_destroy_srq(struct ib_srq *ib_srq, struct ib_udata *udata)
 	bnxt_qplib_destroy_srq(&rdev->qplib_res, qplib_srq);
 	ib_umem_release(srq->umem);
 	atomic_dec(&rdev->stats.res.srq_count);
-	if (nq)
-		nq->budget--;
 	return 0;
 }
 
@@ -1907,8 +1905,6 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 			goto fail;
 		}
 	}
-	if (nq)
-		nq->budget++;
 	active_srqs = atomic_inc_return(&rdev->stats.res.srq_count);
 	if (active_srqs > rdev->stats.res.srq_watermark)
 		rdev->stats.res.srq_watermark = active_srqs;
@@ -3078,7 +3074,6 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	ib_umem_release(cq->umem);
 
 	atomic_dec(&rdev->stats.res.cq_count);
-	nq->budget--;
 	kfree(cq->cql);
 	return 0;
 }
-- 
2.43.5


