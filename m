Return-Path: <linux-rdma+bounces-14169-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD25C282D9
	for <lists+linux-rdma@lfdr.de>; Sat, 01 Nov 2025 17:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A452B3BEF2F
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Nov 2025 16:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3AF2609E3;
	Sat,  1 Nov 2025 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Jrvu8Dpv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAAD255F3F
	for <linux-rdma@vger.kernel.org>; Sat,  1 Nov 2025 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762014705; cv=none; b=faABE8o8Nm4eutvKAXqS12k5/ue18Hn5XmiGUg4bk2VmETT/VgOupbnadw4qflnwWh6xgAzVcFgTp/SezmLbMwnqfy/Sk2vUcbDa4uVhJulO0smHeqCbnSO+G6vz6ufBh4QYEVEBja1IEXA1d+xcAai+DAhv+ocKqeXqcxCsrUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762014705; c=relaxed/simple;
	bh=ahAObGnU0vDJ/JFkZIEyWhKgwaUaUOkuSDA6ht3Gnn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dLDKIbdVdqnN8WdKmjdRi6O141PyFokbsGjm8VFhPl1slEy+sT7l0h6yynwYDHSbR7gRVPf50E4FsE2cxu09PE1I8Y+pU+BudXU9t5w4hyAjYTTaYZQ9Y/FSDmaBMxEjlIzQaJf8Rah6yXduHYqOQPAneyHdUEiatGoyK0Lwt0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Jrvu8Dpv; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4770e7062b5so22801105e9.2
        for <linux-rdma@vger.kernel.org>; Sat, 01 Nov 2025 09:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762014701; x=1762619501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UO8BLo76omficvLZOkllz+k90eYulfRVDXj5KcWWOHQ=;
        b=Jrvu8DpvpJmJdWlLAkbxhUkqYaY39kHoRjMe3nmKTYzes7cG5SbuUIDy9fCp9kKhqs
         2phD+KbDYybUNAXPLOmWYTi/n/Rl9b7JELmIr2xjvPQp9E029ryizDtz3dJpdcqZbvgk
         iuyaV1BFtJlcPwf3qTQlJ3xidnNLYSv5/YA7wbPNVAAEjjP0gHg/NOaT2xHGPgxUifR6
         huInkRjUTYGi8803pXqzszbgyR02Qmop3Ravjzrg+UfH0pAd2mGJcEORRg1WtKdEseDb
         YrLizbcm2jODLfhl6JM9dUSCTApsrEVcbn2PJSAocinfOU4CtTeFnZYWbHZQD6VLihcg
         9PJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762014701; x=1762619501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UO8BLo76omficvLZOkllz+k90eYulfRVDXj5KcWWOHQ=;
        b=gRJioRrpM8RHfFHYJt7NOH6l9mO//RZ74dJXopPqPvhkv2uKEIqufpoyIjrKFcBuCN
         5+iyIsoSi1zQNV1bctNMIIfGRffYoiX+UzAeS9nPIjc0XUvDDdOtTz0Y+BAAii5D09qk
         vq7Auupez1H7AcFMS2jjYb41fpZv0N0aJLNVXbnHuxDqg6KO8RsSJ8cNYEKJpImEMUEw
         mjQO2wxGxoTUJp4Jsa61X7+iGhcppKHelTSLZynGt5RiVdYBecr7+T0dqLVQxkK5R4Uc
         xjBqq6Pg5nqVgib/1jpNu2F34lKAvRibIOAqQSGr8YQcl3trj5DGVJanrTE7SPP1bOQ5
         XYtg==
X-Forwarded-Encrypted: i=1; AJvYcCVRdxvfyD0pddd42NEN2hEnnzuu0ouT6Rdr65MrF4vxyaGILTkVEcdzaCIiS1lbBasOiUoQODiik5cy@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2p7Qx658caFptxl4HQ000/nDjrhExiV1NBlZqZdoarf9Ae98c
	2ki21lnY3vhoQx0A/LhwXKslw3pdJN7nriAEmfpTONN9m1cQ99lJ8tw+TMHVC1rIAQ4=
X-Gm-Gg: ASbGncu9SLkiz+tOQ4i4oMV3DNysaP+JubYIf19Q3TuRJhDKtHv7e3P50u4NnjQ4GGM
	6J4LNLhPcjeaaszs78ikKWLkQ340RT+ZAkUaNL/s8lP18WO0nNOG13cbCdwH8EiADnloBhkveQb
	vzvCdxEKwwpNxeMUeiOz06gfjP9HJgIbZLuyT92OjUHcpGg6gylMZQ4edMtdA+EKV5K0E1D+7Gd
	tYgcbpc0hK3ozieMsVkC9rKnl13x4CyTHiW+DbwAjp1cX7Vst7zAe6lfLPQGvvtRWO5P7FjE8zF
	lo0pzIUVZQdFH5u9P+49Ajaf1zbbCfDQDk8+DhQ6Akoi7wZWvp9gLVv7h0sfyoE41ADfRfqSW3M
	KfohJII1Dkp+bGNzmpzxKBCJHkkytlQ9qTO18anfQ97bA7Tdb9ZWj6pshrNjF1RZ3z9wt6+ktv8
	9/YxlN+zVL3Xq70KYyuUoRgl/y7Xev1bOMqLo=
X-Google-Smtp-Source: AGHT+IGhqxlDi5PsKQEtT2GbrmcEYyIWNPNJ7Q2aowygqH7rpeTAh2rcioL+mbwEHLHEctDCYPi+Xg==
X-Received: by 2002:a05:600c:8b8b:b0:46d:5189:3583 with SMTP id 5b1f17b1804b1-477303303e5mr60797365e9.0.1762014701097;
        Sat, 01 Nov 2025 09:31:41 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c394e33sm56742285e9.13.2025.11.01.09.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 09:31:40 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Subject: [PATCH 1/5] RDMA/core: RDMA/mlx5: replace use of system_unbound_wq with system_dfl_wq
Date: Sat,  1 Nov 2025 17:31:11 +0100
Message-ID: <20251101163121.78400-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251101163121.78400-1-marco.crivellari@suse.com>
References: <20251101163121.78400-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

system_unbound_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

Adding system_dfl_wq to encourage its use when unbound work should be used.

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/infiniband/core/ucma.c   | 2 +-
 drivers/infiniband/hw/mlx5/odp.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index f86ece701db6..ec3be65a2b88 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -366,7 +366,7 @@ static int ucma_event_handler(struct rdma_cm_id *cm_id,
 	if (event->event == RDMA_CM_EVENT_DEVICE_REMOVAL) {
 		xa_lock(&ctx_table);
 		if (xa_load(&ctx_table, ctx->id) == ctx)
-			queue_work(system_unbound_wq, &ctx->close_work);
+			queue_work(system_dfl_wq, &ctx->close_work);
 		xa_unlock(&ctx_table);
 	}
 	return 0;
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 0e8ae85af5a6..6441abdf1f3b 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -265,7 +265,7 @@ static void destroy_unused_implicit_child_mr(struct mlx5_ib_mr *mr)
 
 	/* Freeing a MR is a sleeping operation, so bounce to a work queue */
 	INIT_WORK(&mr->odp_destroy.work, free_implicit_child_mr_work);
-	queue_work(system_unbound_wq, &mr->odp_destroy.work);
+	queue_work(system_dfl_wq, &mr->odp_destroy.work);
 }
 
 static bool mlx5_ib_invalidate_range(struct mmu_interval_notifier *mni,
@@ -2093,6 +2093,6 @@ int mlx5_ib_advise_mr_prefetch(struct ib_pd *pd,
 		destroy_prefetch_work(work);
 		return rc;
 	}
-	queue_work(system_unbound_wq, &work->work);
+	queue_work(system_dfl_wq, &work->work);
 	return 0;
 }
-- 
2.51.0


