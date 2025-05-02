Return-Path: <linux-rdma+bounces-9948-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CBBAA6949
	for <lists+linux-rdma@lfdr.de>; Fri,  2 May 2025 05:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AAFB1B66A5C
	for <lists+linux-rdma@lfdr.de>; Fri,  2 May 2025 03:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5F51A0BE1;
	Fri,  2 May 2025 03:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJPC3s+L"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F442D600;
	Fri,  2 May 2025 03:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746156164; cv=none; b=Dqdwv+YSjTR4bG6gUwE2T/Km62Zp7VDTUPP+IvBUxO/iG0EdlFUgpyAXL0CwKAbi6qR/QXqEhhjmJiuJTdPpVqhDGVzBRn/joEKWg94RPaFcIpj4J4imtrZKBUpeNK0J7q8ZWd8Hn7sPCG5CrFdc9g+MM9ViWVbFrNrUnCUtAgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746156164; c=relaxed/simple;
	bh=rpGovpBSO+IM8ejTZ/NiOW9J23OPlpvSKh8cn26jSCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGofwlHAJXY/rFTG/AuEnH0XH0wAOgwbyt/1usZ1ea7VjQEhvtG0U6tQHAHGf1Lt9DZkB73ib7dWZQ3Kgeou2z+WEsSGSx7ObN2zkZ2IQtQwUa1lAe91x7PK93/Oo7+CC1Sv5KhcOEzv+T+XxOMaa+bIVxS0ZW48VvFfQIxoeS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJPC3s+L; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-224341bbc1dso21025355ad.3;
        Thu, 01 May 2025 20:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746156162; x=1746760962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3qoVKHW3jws/pKVLuxb4ci6ykvsuNNsnIIlY64wTjw=;
        b=CJPC3s+L9srpkrXl5iZyoAFlEF8gq2Tfl6mp7LvpQKpl1WnegwvVGw4b6Fxa4myfGf
         u8zd6Mtr1hzFWF1aOmMwePNVGxOkzBKEML2+0/iI621MPXApfdPfJNE8qDkco36tKsyV
         eCtjyjLXbhg1yK7f3qj7PvkXVQWKOsk2Jqb9+2qhFKQcC+xuF7tw/DNBLWegS+twS+Td
         IweLyGOq5ZnvL5uLenmewHn5+FZsaw7qV3dRwRffMFQKzHFfaOrLKxWnVn8w8E2QTv5r
         VMzJyohwumrGmbVCpEMnefaOBseVBTq7+OGqscilsXhEJlSmwqBJZeGLdiCxUpdYMe9l
         YVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746156162; x=1746760962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3qoVKHW3jws/pKVLuxb4ci6ykvsuNNsnIIlY64wTjw=;
        b=gDZSIHB+JEAjEBaThM4eZAiy4tgi1K+OVhZxi8dUHvahw0w/TtsWuYaP0E9qz4ETkA
         Agf+qio+sXgUm4lKGwTG9tzm7ouCdC6nocRMr8UyK3AE7m5zqNZgT+NJ7V8PKXVk6gds
         B4uPzb1EwIpPczqyjWrw2DYFonjRXHtNvCTFck1+tESIZUdDPRjpu+tgpmwbjld0I/n9
         J9jzJlXAuTs+uky8uwLACB2hCm9S2BJSR30OH8vclQl3CHUF+QvuBh1oqJBGRGDpkrHd
         VxoQ7dcUoMx9DislUBvxiaPCEI9GSAQvrjpSZcTlzAI0AN8j9Xqrbjo073QIRjaT4TOv
         lA0w==
X-Forwarded-Encrypted: i=1; AJvYcCWprr4DugvNbwzoxf7AJApRJXm1D0NkUEkZ8f5g/9wJcNG9KZ5iJRG9IFNkc+5O4uk1ilyRR6PYuBLp@vger.kernel.org
X-Gm-Message-State: AOJu0YxBdAuhfIR8bgaZiN3Yb7Is2b08FZsvd1KH/u9l0BiYXhMXwT1u
	gIJI9ITDAsoidPpdzxaty3nbYHd/oPTjtIVm9EtjcIAUF8SZVJcBwpLzFLy/rB0=
X-Gm-Gg: ASbGncsysh7zfKEvNLetBYnSOSPKceRjAeMsdRIanFrI2MRQuuNCo2GAeHq+QAK1DAx
	0HH2YCCEIV6Piexsow5fc6Uw4v8SMqKBBEt/e1b83K8FZyxWrZjdkNZ7gw7Pcy80DUZy5P6kiPq
	a4q9sogLtn9+Mm8148850JM6Qq/+UeyTQsYLtfQRkVlf4I9s54OqaDoXmv5Cpk3yQGomFMc2HUK
	i0h75iXVMA8QErbTQbgrq5etUvXRHBCDBlvXIMnA47Jf8jY2sL3R1tNCDZN2kx7vOYnwMZrIZy6
	JsPCriDPO+dk4xRg0Uh4wa0tDx60ncAIgTohiYkw6wJ6vlqXU8BUVtDpousBsp+BDtwJgMs=
X-Google-Smtp-Source: AGHT+IFufFuf2CdtVSf62g1LVL5moa2cGY7Cgf1FWCkJ0c0zYJjvi3rCe71HBjew1KeVQsS41y0Lfw==
X-Received: by 2002:a17:903:238b:b0:224:1220:7f40 with SMTP id d9443c01a7336-22e102b3e03mr22350145ad.3.1746156162339;
        Thu, 01 May 2025 20:22:42 -0700 (PDT)
Received: from trigkey.. (FL1-119-244-79-106.tky.mesh.ad.jp. [119.244.79.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1094063bsm3974625ad.248.2025.05.01.20.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 20:22:41 -0700 (PDT)
From: Daisuke Matsuda <dskmtsd@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: Daisuke Matsuda <dskmtsd@gmail.com>
Subject: [PATCH for-next v1 1/2] RDMA/rxe: Implement synchronous prefetch for ODP MRs
Date: Fri,  2 May 2025 03:22:15 +0000
Message-ID: <20250502032216.2312-2-dskmtsd@gmail.com>
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

Minimal implementation of ibv_advise_mr(3) requires synchronous calls being
successful with the IBV_ADVISE_MR_FLAG_FLUSH flag. Asynchronous requests,
which are best-effort, will be added subsequently.

Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c     |  7 +++
 drivers/infiniband/sw/rxe/rxe_loc.h | 10 ++++
 drivers/infiniband/sw/rxe/rxe_odp.c | 86 +++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 3a77d6db1720..e891199cbdef 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -34,6 +34,10 @@ void rxe_dealloc(struct ib_device *ib_dev)
 	mutex_destroy(&rxe->usdev_lock);
 }
 
+static const struct ib_device_ops rxe_ib_dev_odp_ops = {
+	.advise_mr = rxe_ib_advise_mr,
+};
+
 /* initialize rxe device parameters */
 static void rxe_init_device_param(struct rxe_dev *rxe, struct net_device *ndev)
 {
@@ -103,6 +107,9 @@ static void rxe_init_device_param(struct rxe_dev *rxe, struct net_device *ndev)
 		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_SRQ_RECV;
 		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_FLUSH;
 		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_ATOMIC_WRITE;
+
+		/* set handler for ODP prefetching API - ibv_advise_mr(3) */
+		ib_set_device_ops(&rxe->ib_dev, &rxe_ib_dev_odp_ops);
 	}
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index f7dbb9cddd12..ca302ced0922 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -197,6 +197,9 @@ enum resp_states rxe_odp_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
 			    unsigned int length);
 enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value);
+int rxe_ib_advise_mr(struct ib_pd *pd, enum ib_uverbs_advise_mr_advice advice,
+		     u32 flags, struct ib_sge *sg_list, u32 num_sge,
+		     struct uverbs_attr_bundle *attrs);
 #else /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
 static inline int
 rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
@@ -225,6 +228,13 @@ static inline enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr,
 {
 	return RESPST_ERR_UNSUPPORTED_OPCODE;
 }
+int rxe_ib_advise_mr(struct ib_pd *pd, enum ib_uverbs_advise_mr_advice advice,
+		     u32 flags, struct ib_sge *sg_list, u32 num_sge,
+		     struct uverbs_attr_bundle *attrs)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
 
 #endif /* RXE_LOC_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index 6149d9ffe7f7..e5c60b061d7e 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -424,3 +424,89 @@ enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
 
 	return RESPST_NONE;
 }
+
+static int rxe_ib_prefetch_sg_list(struct ib_pd *ibpd,
+				   enum ib_uverbs_advise_mr_advice advice,
+				   u32 pf_flags, struct ib_sge *sg_list,
+				   u32 num_sge)
+{
+	struct rxe_pd *pd = container_of(ibpd, struct rxe_pd, ibpd);
+	unsigned int i;
+	int ret = 0;
+
+	for (i = 0; i < num_sge; ++i) {
+		struct rxe_mr *mr;
+		struct ib_umem_odp *umem_odp;
+
+		mr = lookup_mr(pd, IB_ACCESS_LOCAL_WRITE,
+			       sg_list[i].lkey, RXE_LOOKUP_LOCAL);
+
+		if (IS_ERR(mr)) {
+			rxe_dbg_pd(pd, "mr with lkey %x not found\n", sg_list[i].lkey);
+			return PTR_ERR(mr);
+		}
+
+		if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_WRITE &&
+		    !mr->umem->writable) {
+			rxe_dbg_mr(mr, "missing write permission\n");
+			rxe_put(mr);
+			return -EPERM;
+		}
+
+		ret = rxe_odp_do_pagefault_and_lock(mr, sg_list[i].addr,
+						    sg_list[i].length, pf_flags);
+		if (ret < 0) {
+			if (sg_list[i].length == 0)
+				continue;
+
+			rxe_dbg_mr(mr, "failed to prefetch the mr\n");
+			rxe_put(mr);
+			return ret;
+		}
+
+		umem_odp = to_ib_umem_odp(mr->umem);
+		mutex_unlock(&umem_odp->umem_mutex);
+
+		rxe_put(mr);
+	}
+
+	return 0;
+}
+
+static int rxe_ib_advise_mr_prefetch(struct ib_pd *ibpd,
+				     enum ib_uverbs_advise_mr_advice advice,
+				     u32 flags, struct ib_sge *sg_list, u32 num_sge)
+{
+	u32 pf_flags = RXE_PAGEFAULT_DEFAULT;
+
+	if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH)
+		pf_flags |= RXE_PAGEFAULT_RDONLY;
+
+	if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_NO_FAULT)
+		pf_flags |= RXE_PAGEFAULT_SNAPSHOT;
+
+	/* Synchronous call */
+	if (flags & IB_UVERBS_ADVISE_MR_FLAG_FLUSH)
+		return rxe_ib_prefetch_sg_list(ibpd, advice, pf_flags, sg_list,
+					       num_sge);
+
+	/* Asynchronous call is "best-effort" */
+
+	return 0;
+}
+
+int rxe_ib_advise_mr(struct ib_pd *ibpd,
+		     enum ib_uverbs_advise_mr_advice advice,
+		     u32 flags,
+		     struct ib_sge *sg_list,
+		     u32 num_sge,
+		     struct uverbs_attr_bundle *attrs)
+{
+	if (advice != IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH &&
+	    advice != IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_WRITE &&
+	    advice != IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_NO_FAULT)
+		return -EOPNOTSUPP;
+
+	return rxe_ib_advise_mr_prefetch(ibpd, advice, flags,
+					 sg_list, num_sge);
+}
-- 
2.43.0


