Return-Path: <linux-rdma+bounces-9955-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CBCAA80E1
	for <lists+linux-rdma@lfdr.de>; Sat,  3 May 2025 15:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2BB24643C0
	for <lists+linux-rdma@lfdr.de>; Sat,  3 May 2025 13:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345E21553A3;
	Sat,  3 May 2025 13:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3cdu6H8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6192313C3F6;
	Sat,  3 May 2025 13:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746279807; cv=none; b=N9utMRIV0KSo2LL0DiNAdIx1Rb78t7mBOkL4zOqwALAjitx+aBTQdvPRhfijCblPkVRntlt2BNj8/lQCoYtE3d7wrgQxwtp4JEX9EDo4lZQLn1i6TR/H+TnwkET8BGou9paQzM5JSRJios0vmxuMloLKGRoO3qTpfPaZM+S89ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746279807; c=relaxed/simple;
	bh=agVXWU7IabDNVQcplrsg3ugWMhL9eZuRz7bxm/bUoBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xkd5yplG+Ja1Bimxe0FkBCDiXKIYIQnpVAqRQb4Iu/yK+i0ZxgR8bcRlat+QVv9hyN1jX+kBvsF+TFUSbJIEu4ANycdcoybkshukuWKIHnWcY16r0TLwxl6kvNrsRDmPYmgqOC7gn0WOXjYOAsVOToBThGfvdPJ91XzE1xsTLEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3cdu6H8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-227a8cdd241so37939615ad.3;
        Sat, 03 May 2025 06:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746279804; x=1746884604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kDD3NbT5GbBrQXb+ZvVdJbcx5oASxx7m0AfshCqDoI=;
        b=Y3cdu6H8LLZ6SDoLIa6gTcBvXLGG8oCjvKaZEbb3q3R6K8mU720PpBKVrV+wtPj7Cn
         N24SqIQAbRU90XsvuQFn80NWi85lJMmWToSAUqmPjaZi53R0LgMcesZYAvlalG3xUlk1
         LxYyHFLabfC/AQmDhgsGNEeleaPm48WxFARuabKqwz535lu+fziBhzo7zZItCFvHzG7Q
         mHUCN9don0ly39W9yg84qfBDn7wF037FCqFvLOlfSblMGOe4t5RrxwQqjr/yJUlbRYEc
         ZYPwzbVYQNLbp0Oa5XVn8QzrX930g9Ccvczimuo71tyIUnMuUrpQLWK1zIMnd33VR6mB
         XJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746279804; x=1746884604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kDD3NbT5GbBrQXb+ZvVdJbcx5oASxx7m0AfshCqDoI=;
        b=ZO0z3Ni6cYd7nmYvx4ZgqjhWAnKkPKrte5/MFOcx16iUFinlcN3R4EcxhUjRuJetzm
         v7rW1g8XlFJV9WRsglaWchZozx3V8a2TICwClebESSvZyjwHu3bm5NIFkpQJfBC7evC6
         GhZh3dY7uQILCsDjPlnfhMTZ+40e5DfYefYckiTX7lPnlM6uYt8SwWcgGqf0OLJkaSzm
         n7xlZtBUZAOuB2x94+nXwloJsSyMktMCl5ym3gXIkhYy5Jq8q72RWRiwwxl6w7ytT7nc
         Fx6bqfDmFaUQIFQBmJWsns9VxKZxW5ZlE8N6GoXep7F2uNQc0A/2FVJ9GFxCg9SzFe2X
         SIpw==
X-Forwarded-Encrypted: i=1; AJvYcCWXR2Vn5qy29mxhdZTTYBo5CzD7qMPCCm1ZNGLlx720Eng+2qe4LTGr7Ft8BZaMfg4KOMEArHEB5fb+@vger.kernel.org
X-Gm-Message-State: AOJu0YzzNeKYdFggvy2ev9nKATjw/UoTKRpfQaCUyr0S8qBFYDjGw6fE
	zYigL2I8czFs4xN0SgaKwLEzFLwxYXOSz3DJsjaB9/M6nJ96NKCshLq8gXDu
X-Gm-Gg: ASbGncvpT4H5xC5/8G0BvOH30sgG6lKyUgzJMf0ja2AYRhqpOShfBLaGVRrVtOh9diT
	m29kH8aHYxZY22NBr1VtvvUhxpRc713frncu6BoZRPuplLdnCOuPF2VszgN/jfUQ+huetCxo80+
	6exk2kzc0RomAriZ1KfLcssIvQnShSREdxVUvC57onSxo4YD1PnZGydGEKneouTzXwNIuNlj4Dl
	+N0+X69zWvTNH/CwYv1291OAhklwsSBoTo8lK2L1sr0bW5GmEEHRTjpU1qKOQ12HbOCuFtPpxui
	J7QMmCczHxq9g3+L3jHazCsgrhZHJ9cOZBoJZyIAhvYrbjsdwqBKdOd1ghz+/rvECJihbws=
X-Google-Smtp-Source: AGHT+IFgZdWgwwvPTrw45n5njzfayxUXAVDBKguTALkg6ny5BpS5371nDA27KrYZOgRyZ4LwbyAEWg==
X-Received: by 2002:a17:903:4403:b0:224:10a2:cad5 with SMTP id d9443c01a7336-22e18b65ebbmr47731035ad.10.1746279804474;
        Sat, 03 May 2025 06:43:24 -0700 (PDT)
Received: from trigkey.. (FL1-119-244-79-106.tky.mesh.ad.jp. [119.244.79.106])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a4762679csm5561696a91.34.2025.05.03.06.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 May 2025 06:43:24 -0700 (PDT)
From: Daisuke Matsuda <dskmtsd@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: Daisuke Matsuda <dskmtsd@gmail.com>
Subject: [PATCH for-next v2 1/2] RDMA/rxe: Implement synchronous prefetch for ODP MRs
Date: Sat,  3 May 2025 13:42:23 +0000
Message-ID: <20250503134224.4867-2-dskmtsd@gmail.com>
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
index f7dbb9cddd12..21b070f3dbb8 100644
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
+static inline int rxe_ib_advise_mr(struct ib_pd *pd, enum ib_uverbs_advise_mr_advice advice,
+				   u32 flags, struct ib_sge *sg_list, u32 num_sge,
+				   struct uverbs_attr_bundle *attrs)
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


