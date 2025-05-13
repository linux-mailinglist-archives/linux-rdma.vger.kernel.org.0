Return-Path: <linux-rdma+bounces-10314-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC858AB4AB8
	for <lists+linux-rdma@lfdr.de>; Tue, 13 May 2025 07:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCDA8860575
	for <lists+linux-rdma@lfdr.de>; Tue, 13 May 2025 05:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594811E3762;
	Tue, 13 May 2025 05:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JF2o+Ud5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C791BEF9B;
	Tue, 13 May 2025 05:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747112689; cv=none; b=QUhmR350PB6JvKGqqigfTFVLQ16UT5b+CSef9hFWEQCr18Ow7YXnVlaJQGIl2wI/2pIIuKi9EgCDhJjbxk5NuNH/6eYFuWzHLievZz6Q905jsH3RLTT3Muzx6flkAwfs0UR92wnv4pvQbun4h8sWPdmiiHtWzlatYxvcm+x1U8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747112689; c=relaxed/simple;
	bh=LGz1txiWghIZcSLUqlxspDyZYmpBLLzXkkI6c58D49w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XhoDHr7+NNZgZCT7KjXz0Jzc9SAUf7KSp87GbFgtkcoCZWhYZiLm1U2xoLycybwzE9iEF5QiM3pdvNRo/lOxBbXO7DEunP5q+lE38cCr6631L5c/i6EmbymsJ1GMBu6sBmDES5xPeYPR3O26kgz+TyZbzAayYRysWA0LqMaGdt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JF2o+Ud5; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-30a89c31ae7so6844339a91.2;
        Mon, 12 May 2025 22:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747112687; x=1747717487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGMMYICEA6yi0x1V/+Su91nHfwS9QAhqK1x9pOl+LpM=;
        b=JF2o+Ud5hlzGmlQTVje7D2n8KTfznewUcF9cpFhetQzpVj7rPP+J6t9gIY8uiuRivJ
         sNTJ/w4M8DwI8YYCag1ug1hPqi+FMIAfcoZwgajy++oEIHt54q1Zjgt0/A+5stl9eZEn
         uh+SqrxSM+GzKpwFW4DkPb0jNbpy4GRVMkluF8XiHbn7Cg1JRr1vw6gryz181+AV9PDP
         uihvRiVer821U0ZPxSS/Z1uAAWqBZjJ4BhaYZD3zmrdvZ6620tEJFisizd01+SztuIEO
         G/fSi6Yi6dMV7Pi41tLKAzeK7gS9Nl0BNLeBNguvnkEihk/G55xITTcbK+gYKI5qaUEV
         QmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747112687; x=1747717487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGMMYICEA6yi0x1V/+Su91nHfwS9QAhqK1x9pOl+LpM=;
        b=hB023iPcufZOzfTRx+d8RrqiKtDdaRlV4zbsUaA+8lBaGlvmX+u+rpGaF+bzhvCBgI
         wrHDPx8HktVXJdDQ4pP/EXLHckZ4WLH3gvWIYLQ1u3Y3mHlzlkHSJR59Bgl2FP/eP8BQ
         PJ0cRqPEt72L1PDKE1hAdm2E9qKTuAwGRyZ05iPlg1xUwDasX41SMSUXF3C3evsInlcM
         E9jofTCW9bW0MupEmfPMXJDs2g1yD75GD0Iknt3FrdQYB61iZ8uwbV0eR2ryyBJBj+z0
         N4k81GsKnfvgDE36CNFD3VDooMbGNAw6fKdi693Fg2usMXRVisLDJ9PC/U/bbZ14qvLp
         4I3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVb0xFwzlCMP8IPoEoTAqBio34Nsp4kxly4qPNjsJVJlbLSkOpXnBW4XhJzWQ/M3A+q4g/8EaNZ22qO@vger.kernel.org
X-Gm-Message-State: AOJu0YzI99JdZofzv+6GUyD/UAiC7MU74ztQJiFcj2W8E58eGeD5pUrV
	50tgcNRqzXrXmjyPWMoL3XtckSKcsnod1ngboGqvF9h4QNjq4bpLA1ghb6Uq
X-Gm-Gg: ASbGnculYVjK/IqxehPjuliHsQgkKcU+FJEwPdl85Z0loOzByjXcNi4nlPTZqTdy6ra
	4U9o0V67S8YbwpuHoH5+8MdrYTBYms3bH++bT5G1NGmG1ltR3Ljqj6OeRyarb2U1d1JvfmxpkYD
	YePbhwQPhPdvYT/v+YZ72qycKaHq8+vCo1yfJCb8eOM9hZuPDq0kQrmvuEijw50YCFWZGYifsQQ
	IjRU9ce1QhZL6hB35LslM5XowKil13Mso6kTSzHfKbCrjeZvX4SFbntG761O6DAvsd15Dnfd1/5
	6iB/nmx/d9pwrtVwS1NM8a96EJQ8QKI6Zf4EQaZC4B0zctW1FzI3zJ1NzaMuv50fJDZlYR8djjs
	9tHIReHnnlQS2/QFT
X-Google-Smtp-Source: AGHT+IFs+q0OaqtLBs4eT4DP8/0g4WfTOJ4fphf2ovAtdiiEWdphTfb/auryyAS+TzXT37NrXNOT1Q==
X-Received: by 2002:a17:90a:d2cc:b0:30c:5255:ffd6 with SMTP id 98e67ed59e1d1-30c52560062mr14647808a91.6.1747112686663;
        Mon, 12 May 2025 22:04:46 -0700 (PDT)
Received: from trigkey.. (FL1-119-244-79-106.tky.mesh.ad.jp. [119.244.79.106])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30ad4ffb545sm10744493a91.45.2025.05.12.22.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 22:04:46 -0700 (PDT)
From: Daisuke Matsuda <dskmtsd@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: Daisuke Matsuda <dskmtsd@gmail.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH for-next v3 2/2] RDMA/rxe: Enable asynchronous prefetch for ODP MRs
Date: Tue, 13 May 2025 05:04:05 +0000
Message-ID: <20250513050405.3456-3-dskmtsd@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250513050405.3456-1-dskmtsd@gmail.com>
References: <20250513050405.3456-1-dskmtsd@gmail.com>
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
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_odp.c | 84 ++++++++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index 4c98a02d572c..0f3b281a265f 100644
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
@@ -475,6 +542,8 @@ static int rxe_ib_advise_mr_prefetch(struct ib_pd *ibpd,
 				     u32 flags, struct ib_sge *sg_list, u32 num_sge)
 {
 	u32 pf_flags = RXE_PAGEFAULT_DEFAULT;
+	struct prefetch_mr_work *work;
+	int rc;
 
 	if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH)
 		pf_flags |= RXE_PAGEFAULT_RDONLY;
@@ -487,8 +556,19 @@ static int rxe_ib_advise_mr_prefetch(struct ib_pd *ibpd,
 		return rxe_ib_prefetch_sg_list(ibpd, advice, pf_flags, sg_list,
 					       num_sge);
 
-	/* Asynchronous call is to be added in the next patch */
-	return -EOPNOTSUPP;
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
+
+	return 0;
 }
 
 int rxe_ib_advise_mr(struct ib_pd *ibpd,
-- 
2.43.0


