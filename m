Return-Path: <linux-rdma+bounces-9949-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2FEAA694B
	for <lists+linux-rdma@lfdr.de>; Fri,  2 May 2025 05:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05A1D1B66A90
	for <lists+linux-rdma@lfdr.de>; Fri,  2 May 2025 03:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE28A19DFB4;
	Fri,  2 May 2025 03:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbhx2baH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C9519D07B;
	Fri,  2 May 2025 03:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746156170; cv=none; b=ZvL6mL/Vp1nHzeUVz127tL0bVBhJH8OULAnuA4niy4hMkg00I082coDit1Sey79EPIJmO5wgs/KAptZnBbeY2g5S4AEBMSl5WVnKqcB7pgKFkuEg6Lfpj3AgUeUD+jY6OGwogxsgKHWJ4bYGOJaQhrY/8B3iDJ0/fzpyLskACZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746156170; c=relaxed/simple;
	bh=BdKu0oMC7/nD8hs7w81lDziT8JF9hMEzpVS5Pu+wuQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uCdHG2owa8N2kutpt9LGXH6miKAEtQXL4gCKCKBilOVakJwhaU4g2gZIZmAYtNEKXVyQsB3YqQHbBs06T8iFevrRQ0YpQ2a/NlFETlqu7p+CrerhkIUX2PBNU4TmQ9fSDM7IkfOspM7vkXIYfBTGUQeYRvCyh3tY7n5gvyhoCWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbhx2baH; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-227d6b530d8so16731645ad.3;
        Thu, 01 May 2025 20:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746156168; x=1746760968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crcCfkxFdjrxFLxSuvrgCSvgU5gXMq8U8EeleetQwqI=;
        b=lbhx2baHq/yldOQFvCe+XZJQFTEIQ1EAuKeaxHn9TdU0W4Um0fKKYICVJeWwbr01nL
         +MR1I7Vvq9dSa7JfRZ7YgCTWqkuqpoQLrB7g6yeAdmwb1zHubmWGvneTDl6aaOaU4DZZ
         Z/0DrZ55zzk+TwThPtb/i497lqt+XNNj7OG/oG+TH+MuAmvOV3prkEhtgUa6DhhbR8f+
         LzbLVaZPJRmM0WtIahgS6QC0xKUXznvqwwo2L+fmlQ4E4qVNNYmBALgQhTpRR6YQn+fh
         fDZ7EsU5ctyed2nzTtKrwV+zbTzbFVL+NqR4PFXn46Rm0K0weRkG04bLSDGhz1P4dp8l
         mz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746156168; x=1746760968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crcCfkxFdjrxFLxSuvrgCSvgU5gXMq8U8EeleetQwqI=;
        b=a09zvXLyRspHKJn33vJ6G09isZ1awtj1DSBdGlVe3mXGUyGt/WzHXQAet/NXcLhRGI
         BXxxVi7Mn2hfVFvOiwMb53PtbxA+BW0P2NHtVhSvsd6I3UCgSgx1B9Jb+4eU0XtWrftx
         eCmCxA35RLe4dhIVlmDvdIXk7lxUeoauZdcv2TmJO1G7m8Iw0DsA1OoSeP5a0GCFCFlk
         F0liolwjyfhx4wP03TZ82gj7ZnzX6v4PupAcR0izG7gW81/oPgc2JtoQ8HA4gxSpjq9d
         /NxukSwtzE5HA8cMchl18wX8v8Cwn3sKJIoSnms6KqbBQq61wE78q7hSovV+FUifBAQL
         FDvw==
X-Forwarded-Encrypted: i=1; AJvYcCWXMjmHGc1AOXATZKdGtGH3O7VpSksSBES/gjMF8flp3rmI3iPBwVeeQNJOJhOsO2iKKXBIDmrhanPZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0+PFqZacTuSkV0q7q/H/35HeEuxMwiBHjnixWnEB/rZZcluec
	m1BUgwF9tPd9sgXctn5sikdxlWWBoYAEb38r8g9d870gdR1kXgOF4hAAn4lUuvg=
X-Gm-Gg: ASbGncvzBZ0mKJaATxFrQ9Gp2rq5jVPjYSeopl2+Il9mzeKRricnbS18PSS0TvZi/mp
	vUHN46TM0GUjh+il7II1TgwQQxV8Uo43uPwM7i6RsZGl9yODEYv4JBLr7YvzGVYCL4KtBk1T/5a
	oGnMLe27LWemCMYBa2O369oDSTFk/q2k62lz2lB+N1yG+32Aljk76/Hz/BxNLNNyh6JAX+irxIn
	OSGLBxG4uuG6z/IS8yI3sfvGcM5cYiIbxX05x1gU1AiX1F4xqTNV7WgAEldQmBUXUHjKIO9maSM
	NDL4NHrZ+HyzlvQDchboGNPjXOAJMsR9FZH2bC9jeqmBSRMGxO3sGLGxlCWRDZl7DkFwjPOLMh7
	f2avI/A==
X-Google-Smtp-Source: AGHT+IEcXRsplwpkPypleSvEnPMerG17oo6wxpKrObWBXKL2hFdTwH1do6qXSFEjAx4wCYEWNHR3Nw==
X-Received: by 2002:a17:903:120f:b0:220:eade:d77e with SMTP id d9443c01a7336-22e103559d3mr19937535ad.40.1746156168386;
        Thu, 01 May 2025 20:22:48 -0700 (PDT)
Received: from trigkey.. (FL1-119-244-79-106.tky.mesh.ad.jp. [119.244.79.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1094063bsm3974625ad.248.2025.05.01.20.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 20:22:47 -0700 (PDT)
From: Daisuke Matsuda <dskmtsd@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: Daisuke Matsuda <dskmtsd@gmail.com>
Subject: [PATCH for-next v1 2/2] RDMA/rxe: Enable asynchronous prefetch for ODP MRs
Date: Fri,  2 May 2025 03:22:16 +0000
Message-ID: <20250502032216.2312-3-dskmtsd@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502032216.2312-1-dskmtsd@gmail.com>
References: <20250502032216.2312-1-dskmtsd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling ibv_advise_mr(3) with flags other than IBV_ADVISE_MR_FLAG_FLUSH
invokes asynchronous request. It is best-effort, and thus can safely be
deferred to the system-wide workqueue.

Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_odp.c | 81 ++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index e5c60b061d7e..d98b385a18ce 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -425,6 +425,73 @@ enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
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
+			continue;
+		}
+
+		umem_odp = to_ib_umem_odp(work->frags[i].mr->umem);
+		mutex_unlock(&umem_odp->umem_mutex);
+	}
+
+	kvfree(work);
+}
+
+static int rxe_init_prefetch_work(struct ib_pd *ibpd,
+				  enum ib_uverbs_advise_mr_advice advice,
+				  u32 pf_flags, struct prefetch_mr_work *work,
+				  struct ib_sge *sg_list, u32 num_sge)
+{
+	struct rxe_pd *pd = container_of(ibpd, struct rxe_pd, ibpd);
+	u32 i;
+
+	INIT_WORK(&work->work, rxe_ib_prefetch_mr_work);
+	work->pf_flags = pf_flags;
+
+	for (i = 0; i < num_sge; ++i) {
+		struct rxe_mr *mr;
+
+		mr = lookup_mr(pd, IB_ACCESS_LOCAL_WRITE,
+			       sg_list[i].lkey, RXE_LOOKUP_LOCAL);
+		if (IS_ERR(mr)) {
+			work->num_sge = i;
+			return PTR_ERR(mr);
+		}
+		work->frags[i].io_virt = sg_list[i].addr;
+		work->frags[i].length = sg_list[i].length;
+		work->frags[i].mr = mr;
+
+		rxe_put(mr);
+	}
+	work->num_sge = num_sge;
+	return 0;
+}
+
 static int rxe_ib_prefetch_sg_list(struct ib_pd *ibpd,
 				   enum ib_uverbs_advise_mr_advice advice,
 				   u32 pf_flags, struct ib_sge *sg_list,
@@ -478,6 +545,8 @@ static int rxe_ib_advise_mr_prefetch(struct ib_pd *ibpd,
 				     u32 flags, struct ib_sge *sg_list, u32 num_sge)
 {
 	u32 pf_flags = RXE_PAGEFAULT_DEFAULT;
+	struct prefetch_mr_work *work;
+	int rc;
 
 	if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH)
 		pf_flags |= RXE_PAGEFAULT_RDONLY;
@@ -490,7 +559,17 @@ static int rxe_ib_advise_mr_prefetch(struct ib_pd *ibpd,
 		return rxe_ib_prefetch_sg_list(ibpd, advice, pf_flags, sg_list,
 					       num_sge);
 
-	/* Asynchronous call is "best-effort" */
+	/* Asynchronous call is "best-effort" and allowed to fail */
+	work = kvzalloc(struct_size(work, frags, num_sge), GFP_KERNEL);
+	if (!work)
+		return -ENOMEM;
+
+	rc = rxe_init_prefetch_work(ibpd, advice, pf_flags, work, sg_list, num_sge);
+	if (rc) {
+		kvfree(work);
+		return rc;
+	}
+	queue_work(system_unbound_wq, &work->work);
 
 	return 0;
 }
-- 
2.43.0


