Return-Path: <linux-rdma+bounces-10529-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E90FAC0A80
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 13:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C034A17CC18
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 11:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BDE28A1FC;
	Thu, 22 May 2025 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRMJ9NgO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FBF28A1F0;
	Thu, 22 May 2025 11:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747912826; cv=none; b=FXEjFO2tauFdbvShjug21/zFlodlzpG1humq1ObrW/T4C3GiHhzvlvcu5fWe2vKmW7eOvpsPZzPm2Kjx0RD7GDYyPnqoHbyOVfPFlfWlNgP3e2E5spoiUAbtoPCjXjRcT/u0KP2a/e4Kz2DyfDd6TpRsg/NedA1DBT5DfmQBd9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747912826; c=relaxed/simple;
	bh=B5b52Gxbl6cfi05GskfaE62/PK/gBhMM9exzJDKRnBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7hfAnMDVZD4vhDNipDXL1wpVsGhm3P2e6ZJn9xxDDptwrI3YRmvjrAKv0rPaQ22eRQA/eBmKHmpi9x/3ezgepbT6JEYk0bXhxCq3q2WqIrungz0h6inR6X9EIvnqUZ6zUz6vKiNG/z2guPqNCKxys9ENobrBc2oMD65K4KPwBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRMJ9NgO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23274dbcbc2so29090265ad.1;
        Thu, 22 May 2025 04:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747912824; x=1748517624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyMHELK/W37ReKJqaI5CZ8imY31+a8EBxUQ+RkojFSw=;
        b=PRMJ9NgOFHMaFGUzgBuQQuAxyQmrgzx3IHj57WjP06KQhzRteAtScDwr+DbkpcZJZo
         JJdtd37u/p6LUm6PbbrAnVkq6YoVQgruVdCc9WRSzt7qQ3pegfdld1Yzggrp6U/DftbJ
         AbQZ83XCJwvwcRZ468wPT9v2+mILGzuzJ2Q8o1BdOOiP7D+ALMMR0PHZ6qRbiqA2WK2l
         cvP5gBI7fbrG0dD36+6o5VD7FeZi+IpZFPKjRsbjQwMHGm/ztg6H7IkvkcoF8wQ0O5Gq
         TpakcZngwWnlXfrTDqjEOevuRmje2KCX7y7pfjJAyLuctWr+ojYeLDgaYl15G3pVEzOf
         XHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747912824; x=1748517624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wyMHELK/W37ReKJqaI5CZ8imY31+a8EBxUQ+RkojFSw=;
        b=xIdmcxB1qsG9H/j9YKmm9m2iBDvHMIUcR1f5ARG8iB6AN8CmOUNe73jzjQzhEX8qTx
         4JwRUZgZ3wbt7KuA7LDvm9RNmio3azK6u2taVL1ExAM+d5vPU4kO5ptgiNkl9vmBbE4h
         uoFxNuYf4OlQyoWGtjBR8emzKLhQzwSurvsuYYg0WrcsdwuSd6vCwRQfZjVxZXoJX+Zc
         wkhY/C3w4xaEWWw8tBDF54PMEwdUOggb8QVYDHiQa53HYdjADoAL/Ow+Ei0On8TO+3ec
         xbm7Sgodp+15Pn/aXzxDz0ljUHQ/3ilcNl+jEmZf2xmsVh5x1fmfp+WrtrGIs8pPgThD
         Az7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+rls6wwvTKNML3osHTpwN1ZfKV+4/KjvW2OClFeNXkBglF2MoraDgs1Qz0DcGH5vs0RyCVlBUN0WF@vger.kernel.org
X-Gm-Message-State: AOJu0YyPZiTDDvQJxPvEV8QlQaxvVF/Ku4Fj1NBmm8hSfzXRXY5z9t4t
	2OSdA8YuoFhYxBUGrNgegwNDQgaEz8tAxix89NCtSpegswOWClJsjq23EluLoHOL
X-Gm-Gg: ASbGnct9gwIGEjF2lEhAnQxCb3VFCsXzHtVz53fLlCIuk/7dhYc5K5DJmrgHLT3NZl5
	l1WHNd/MPDxNwJ7mqQBqSfRIbTLMy9cS2+ckTs7FVd2lsXkHnMOdRAimwnpwgVDfGviElSxZwae
	f25KDKqqXw+2n2vjyK8TdS+ZrrzatH1wubPPlwZTQCCDTu1zEOHXTqRzUGeyCZkeTZz6PnnRWV2
	/SK4c6LWBGMwNlvAK8B+eY4r+AHgRyiPg1jDkdTkHSUwsCs9/3UyzAseyGQCpa5/m6QKtDLEUWe
	iCXkBrKXduVHYwbqn00GMPZfB3t7prsz3+mWrj9P06ni0sxQsd00CifNkprFkVK0ANjP064hHbj
	abA7OTg==
X-Google-Smtp-Source: AGHT+IEvfYpzq+KtCnA48kgadaoajRidcVSbbuTuYcaFBRD35if4dtavF9FBXrZza+w4uOtV1v8BkQ==
X-Received: by 2002:a17:903:41c7:b0:231:7fbc:19d8 with SMTP id d9443c01a7336-231de35159bmr323077995ad.5.1747912824106;
        Thu, 22 May 2025 04:20:24 -0700 (PDT)
Received: from trigkey.. (FL1-119-244-79-106.tky.mesh.ad.jp. [119.244.79.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ac93b3sm107730145ad.4.2025.05.22.04.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 04:20:23 -0700 (PDT)
From: Daisuke Matsuda <dskmtsd@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: Daisuke Matsuda <dskmtsd@gmail.com>
Subject: [PATCH for-next v4 2/2] RDMA/rxe: Enable asynchronous prefetch for ODP MRs
Date: Thu, 22 May 2025 11:19:55 +0000
Message-ID: <20250522111955.3227-3-dskmtsd@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250522111955.3227-1-dskmtsd@gmail.com>
References: <20250522111955.3227-1-dskmtsd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling ibv_advise_mr(3) with flags other than IBV_ADVISE_MR_FLAG_FLUSH
invokes an asynchronous request. It is best-effort, and thus can safely be
deferred to the system-wide workqueue.

The reference counter in rxe_mr is used to ensure that the MRs persist and
that rxe is not terminated until the queued work is done.

Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_odp.c | 81 ++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index c723d8a6cfec..2b112b07ec8c 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -423,6 +423,46 @@ enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
 	return RESPST_NONE;
 }
 
+struct prefetch_mr_work {
+	struct work_struct work;
+	u32 pf_flags;
+	u32 num_sge;
+	struct {
+		u64 io_virt;
+		struct rxe_mr *mr;
+		size_t length;
+	} frags[];
+};
+
+static void rxe_ib_prefetch_mr_work(struct work_struct *w)
+{
+	struct prefetch_mr_work *work =
+		container_of(w, struct prefetch_mr_work, work);
+	int ret;
+	u32 i;
+
+	/* We rely on IB/core that work is executed if we have num_sge != 0 only. */
+	WARN_ON(!work->num_sge);
+	for (i = 0; i < work->num_sge; ++i) {
+		struct ib_umem_odp *umem_odp;
+
+		ret = rxe_odp_do_pagefault_and_lock(work->frags[i].mr, work->frags[i].io_virt,
+						    work->frags[i].length, work->pf_flags);
+		if (ret < 0) {
+			rxe_dbg_mr(work->frags[i].mr, "failed to prefetch the mr\n");
+			goto deref;
+		}
+
+		umem_odp = to_ib_umem_odp(work->frags[i].mr->umem);
+		mutex_unlock(&umem_odp->umem_mutex);
+
+deref:
+		rxe_put(work->frags[i].mr);
+	}
+
+	kvfree(work);
+}
+
 static int rxe_ib_prefetch_sg_list(struct ib_pd *ibpd,
 				   enum ib_uverbs_advise_mr_advice advice,
 				   u32 pf_flags, struct ib_sge *sg_list,
@@ -472,7 +512,11 @@ static int rxe_ib_advise_mr_prefetch(struct ib_pd *ibpd,
 				     enum ib_uverbs_advise_mr_advice advice,
 				     u32 flags, struct ib_sge *sg_list, u32 num_sge)
 {
+	struct rxe_pd *pd = container_of(ibpd, struct rxe_pd, ibpd);
 	u32 pf_flags = RXE_PAGEFAULT_DEFAULT;
+	struct prefetch_mr_work *work;
+	struct rxe_mr *mr;
+	u32 i;
 
 	if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH)
 		pf_flags |= RXE_PAGEFAULT_RDONLY;
@@ -485,8 +529,41 @@ static int rxe_ib_advise_mr_prefetch(struct ib_pd *ibpd,
 		return rxe_ib_prefetch_sg_list(ibpd, advice, pf_flags, sg_list,
 					       num_sge);
 
-	/* Asynchronous call is to be added in the next patch */
-	return -EOPNOTSUPP;
+	/* Asynchronous call is "best-effort" and allowed to fail */
+	work = kvzalloc(struct_size(work, frags, num_sge), GFP_KERNEL);
+	if (!work)
+		return -ENOMEM;
+
+	INIT_WORK(&work->work, rxe_ib_prefetch_mr_work);
+	work->pf_flags = pf_flags;
+	work->num_sge = num_sge;
+
+	for (i = 0; i < num_sge; ++i) {
+		/* takes a reference, which will be released in the queued work */
+		mr = lookup_mr(pd, IB_ACCESS_LOCAL_WRITE,
+			       sg_list[i].lkey, RXE_LOOKUP_LOCAL);
+		if (IS_ERR(mr))
+			goto err;
+
+		work->frags[i].io_virt = sg_list[i].addr;
+		work->frags[i].length = sg_list[i].length;
+		work->frags[i].mr = mr;
+	}
+
+	queue_work(system_unbound_wq, &work->work);
+
+	return 0;
+
+ err:
+	/* rollback reference counts for the invalid request */
+	while (i > 0) {
+		i--;
+		rxe_put(work->frags[i].mr);
+	}
+
+	kvfree(work);
+
+	return PTR_ERR(mr);
 }
 
 int rxe_ib_advise_mr(struct ib_pd *ibpd,
-- 
2.43.0


