Return-Path: <linux-rdma+bounces-10313-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FEDAB4AB6
	for <lists+linux-rdma@lfdr.de>; Tue, 13 May 2025 07:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96A7919E6D2E
	for <lists+linux-rdma@lfdr.de>; Tue, 13 May 2025 05:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D091E1DF8;
	Tue, 13 May 2025 05:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYVoh3YQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7F11BEF9B;
	Tue, 13 May 2025 05:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747112680; cv=none; b=So3zKz9uifZ16aB+pQ4ayQK8mV56nvmpQwXlJD74cyuInClf2puq7t9kOC/gk9tajuwE6euTtMnUnUJW+AnFO/vpSmzES5PAQTzUyCcfQ2OWLI+PwVOibHJ10Ah5TXyrnInMlIXSNLNrq4xmD8yWLFn0dJ6ldcDWqArwjvanL/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747112680; c=relaxed/simple;
	bh=cR6VkBVjR3P+WKzWL6hmCltVbpjLY2ibucMW0CfylpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lu3yZaNa4rqzUxAKeoQoRqT7gBdh2LjpwfL9uRqHom9Vecy9JdlKJPs5+zEcqBCxUPWqqzQaiG4w7++gpPa95IAZ96TN8yB7Ut5l+m8XKPNnAbiKacH3H9X/ccHjNyASGOWniQABkGOmC6ye9PNChXK54NNQ2TjFtka+NkBjIOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYVoh3YQ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-30aa3980af5so6322872a91.0;
        Mon, 12 May 2025 22:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747112678; x=1747717478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JgEHySdiluuq+EuTAVdxG8aLM6y/2+2x0Hu7qvsc0I=;
        b=JYVoh3YQXHx1oPLGV4oHyGqqauWOArXjAkaLndXot5q8EQk0POygWsVddGN6zbAUPT
         X0SZQmq2vDJmGdk8zuLqBXIVIm7z5xlTd/ILpz8NOSO3My1qjYTHtFm5U5HVhQVuZqaB
         3YRNLT2BDznBPTtX9lUin5P4jlxES+zyEHQuGj8x5bdygS/6E93yT6UbZ+fktDXxOGDq
         X3ZZuR7rJPXGQVRZZS4sA9RlQSn4pVZy+CM6S40aEXx63MI0tkNYRGhmN7+ylww0995r
         Kz/I8FORFn8kNrPBCL1z7lyVPeGQ4KOUpaIVmNUAYfZ6OLJnZdpqVZXK9PP1yBn0oQXM
         aDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747112678; x=1747717478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+JgEHySdiluuq+EuTAVdxG8aLM6y/2+2x0Hu7qvsc0I=;
        b=qkThsQpilBqF/I59WjOcoQfge/+YJnNxgsBeoSPEhkEioEhHCOrLDV/JrICAjz5aYG
         hKTQparbHtQ5V8WkrEfzGouvfapXwP+mVeKHfIJwimB2kGdgalyWVeK/moYH4Vz+9z+i
         w/VaPhKUUajm7F1uIXGvU06ZPPx+yf35hyZhXfzufANRGWG0z4yn4OgNk3BAAdATHmx/
         s85WVKYQuQ+eMuA9hOYbrpt6jOQJxXA/g/PwWVbhLXgB2D6wie0ji1D5llkJNMFDOS8h
         0vXL6BStVC5K7LAEr3muNHySpH41UjbirSz1M/V9qR9K3WVu620t/BVUM5IHHihxGMHh
         QoJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6HaeuX5NT9uwBnzkMQIoq96mj3uP1w4LE19egx+gya5ntfpHu8M37UNYHmaClTr8Nd9EclXyegmxr@vger.kernel.org
X-Gm-Message-State: AOJu0YwZgRBfY8E4UJxBhllPUn08OVHtvSN4XpbiwgpvGTRmV59DVqTJ
	uzpPWH2cGjANLGqx/qey61LXz7W3jX/jD49RNwr6HgDCA0vedXsZ21k6kDw8
X-Gm-Gg: ASbGncuvWq8qODrAsWXyo5oVxEJ+n1hEw6sLBVT0AwstiQ5v6u+HWL3WqTrlKd3H1Ol
	zYpaYIiqJLVbgVYJm59eKK3iPzXTC4sA0R289EibRTiii2X3HroCXfICctAzsHgA6/9wABoP0aa
	ceyD/lkkLqwhrlDQSafuqNidXoBOTICU3A5+2i7ulBSKrIbcm3ZOkBMCMyEW+ARESLWm85abT8r
	AVlRcqPEsq2Mw+MnvBg3VCZdIqUCKPwAGIiJLMl0a5AJ0Y5PEXd7XhzgQB7O9zls8lRLfEWBfdi
	RA9umRUYofBMMDDyagaeBHBtdcpzwfdQvg6wYIyzXYmjO0+z6yvFiKaQfa2IMmJ+GvoiPJL03pL
	PIjcfUw==
X-Google-Smtp-Source: AGHT+IGQ7zjJstwLQNGP1OW+T2TE5ZzuouNVeBKVnDhP2Kje2+7GC+q13d6bN5OPvZT7OJIBwEDDAw==
X-Received: by 2002:a17:90b:4b83:b0:2ff:6608:78cd with SMTP id 98e67ed59e1d1-30c3cff60a3mr27335650a91.9.1747112678080;
        Mon, 12 May 2025 22:04:38 -0700 (PDT)
Received: from trigkey.. (FL1-119-244-79-106.tky.mesh.ad.jp. [119.244.79.106])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30ad4ffb545sm10744493a91.45.2025.05.12.22.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 22:04:37 -0700 (PDT)
From: Daisuke Matsuda <dskmtsd@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: Daisuke Matsuda <dskmtsd@gmail.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH for-next v3 1/2] RDMA/rxe: Implement synchronous prefetch for ODP MRs
Date: Tue, 13 May 2025 05:04:04 +0000
Message-ID: <20250513050405.3456-2-dskmtsd@gmail.com>
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

Minimal implementation of ibv_advise_mr(3) requires synchronous calls being
successful with the IBV_ADVISE_MR_FLAG_FLUSH flag. Asynchronous requests,
which are best-effort, will be supported subsequently.

Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe.c     |  7 +++
 drivers/infiniband/sw/rxe/rxe_loc.h | 10 ++++
 drivers/infiniband/sw/rxe/rxe_odp.c | 82 +++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+)

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
index 6149d9ffe7f7..4c98a02d572c 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -424,3 +424,85 @@ enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
 
 	return RESPST_NONE;
 }
+
+static int rxe_ib_prefetch_sg_list(struct ib_pd *ibpd,
+				   enum ib_uverbs_advise_mr_advice advice,
+				   u32 pf_flags, struct ib_sge *sg_list,
+				   u32 num_sge)
+{
+	struct rxe_pd *pd = container_of(ibpd, struct rxe_pd, ibpd);
+	int ret = 0;
+	u32 i;
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
+	/* Asynchronous call is to be added in the next patch */
+	return -EOPNOTSUPP;
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


