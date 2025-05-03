Return-Path: <linux-rdma+bounces-9956-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A52AA80E4
	for <lists+linux-rdma@lfdr.de>; Sat,  3 May 2025 15:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 230C49850E2
	for <lists+linux-rdma@lfdr.de>; Sat,  3 May 2025 13:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA9A2797B7;
	Sat,  3 May 2025 13:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxolgfP4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2051553A3;
	Sat,  3 May 2025 13:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746279813; cv=none; b=e63/OXvI73ID9Ck4J7Z43/Nu0etsQwXzwqMD70VYulAEK1R81XMECiUVrf7YBJdrtVayiHttBkz/bn0YhAIV+jXBAH1USLrDSTcvN52Z22QNelojyd0UQoBG1lfY8plZkBYg+F7pX88y+hhuTOPsP7QWTsJyAz3Mh06WxrjOvzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746279813; c=relaxed/simple;
	bh=w3d7suSk1ndX33PYKHsRzzZkjQVR65jEUNsug4WcKIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dart4AyN+osteknAoBYVyNLWwBkOwE4URCultBaDsftV1yDmCrbmkimX0jdVgjIY/ZK2jgHRz2BW5xCiFtkPnyVNtEazWOgBjfwT3Gzx3PbNMhFmrEuIuNW4W1hG/ByMXM5EoTNnc7NAVtrcDZ9dOGzyToUI9gTHWBPPvW8+vPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxolgfP4; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-739525d4e12so3060242b3a.3;
        Sat, 03 May 2025 06:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746279811; x=1746884611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkbgT+9NhPah6mGb2anD3IRV21YEs6KjuYx8vRBBwnQ=;
        b=IxolgfP4VMdcOHdQVV6qvZhEs6bSGGDuWr6KIO/yy2IPpwWpeSo71ZNbEzPcqt22RL
         4Z7z7+Nj4jG6/e4ma8pZKcSlwjVt3qrue+HeWRC1wWaDF8396Pyu1rHhrBAuQ9DbWoql
         NmE24MB7ijikD/sFIL+uvngoBM2nUy8wV7d4kXJSzFJJv5J139yVcInfYKbzr9EFMzF8
         fR3rmfdp7LDV3oc33exL0TW2dLZ3QlVx9+muZ49HQ/oLkonUbsdiyY0YoUS9Xi8B0g4O
         l/yjkiZLbniuEfLU4njTHRDDtX/J0DmkkJlK8CRRB3DIrE+3qkdRFZG+zTUPXoOlTxzV
         7AQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746279811; x=1746884611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GkbgT+9NhPah6mGb2anD3IRV21YEs6KjuYx8vRBBwnQ=;
        b=lhL8lwbDjuoZJRYowOEZYJM5nXDAQihn5rGVjggmZ0b8p60kQL58diFqD5ylUiAMOR
         GRfpFTY+3NLHDTPEQs5pDt4KiBsYYEJmHmxdvSnfo2G1ZJ6ZxUPfGEZ5SOQsl/fkdBUy
         Pr0lwViBo+78M++chyINU5OXByqq4fPA8fSZSE1RHvqKYXPQp58CC9qGnGR5mihD6B6j
         JpzaPzZGqXqabZniAsWHDSXjzHQQdwILedMjbsbgPM+r4r13B/AggDrmALZw36spCWWq
         yTLfdmnU4fPs6PC5y3TscPaSJGfHAV5je6++1dljhozpUMvNjUsjxVggJxnInfQfg6Qb
         yo8A==
X-Forwarded-Encrypted: i=1; AJvYcCWPMhRJtFm396+rccW6SkDwIe9w3duDZbjpXWVpa/l6ur4Owcjrb5CzJUFIPRqIXcnCi3prk1OLsWJf@vger.kernel.org
X-Gm-Message-State: AOJu0YyL7ADAJHj2sE6ZyPvBWDG7TdEw7lMPhKIIYiYQ7T9MWIK9L2Ij
	6oQJ3BKn/pX4NNn32i69fFTaiwGgUlQlKCVrio62qrNlMq3SSSSt6w7C775v
X-Gm-Gg: ASbGncvvuBGort61XWu1v0DWXr4Oe4XlczxB7T+oZPWkVCfhQZdOI6SxUr3xpUHWVik
	a5a3J4ZKgHFtDGr3hVl9QhIeSYNQ9gDcsHxh43bCz8g1YDBI/tB0TXcBFBL9e81PbFJ0hy5Wzrb
	nyHjhNxIhru2IIvUHd4XCMXr8kV/s+KRqwvcN8a6SQzOy3IEZ51LIvL9FyM3DWOfctRBGtrymc6
	f6JZpgEEdo44xOoi8pv27Lg1mLaMeN/+jLH7hiwRp3w6t9sMJAWqHG0sqtKb7QzOhYaYL+W0jxW
	NtCpfKLTzWj/yYxCCSMoy1QzUqtt6ItvSPTbDeA98HVknY+qnV+4P/sjYrUyvAhzJesJ75A=
X-Google-Smtp-Source: AGHT+IGlhJmPdZlLpSHAvdAHfGUa4mZo6n0vC5L6midAtO9kGKwakAPiM2mibfid2oA/MW2yA7kMTg==
X-Received: by 2002:a17:90b:3c43:b0:2ff:5e4e:861 with SMTP id 98e67ed59e1d1-30a4e622775mr10474900a91.24.1746279811049;
        Sat, 03 May 2025 06:43:31 -0700 (PDT)
Received: from trigkey.. (FL1-119-244-79-106.tky.mesh.ad.jp. [119.244.79.106])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a4762679csm5561696a91.34.2025.05.03.06.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 May 2025 06:43:30 -0700 (PDT)
From: Daisuke Matsuda <dskmtsd@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: Daisuke Matsuda <dskmtsd@gmail.com>
Subject: [PATCH for-next v2 2/2] RDMA/rxe: Enable asynchronous prefetch for ODP MRs
Date: Sat,  3 May 2025 13:42:24 +0000
Message-ID: <20250503134224.4867-3-dskmtsd@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250503134224.4867-1-dskmtsd@gmail.com>
References: <20250503134224.4867-1-dskmtsd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling ibv_advise_mr(3) with flags other than IBV_ADVISE_MR_FLAG_FLUSH
invokes asynchronous requests. It is best-effort, and thus can safely be
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


