Return-Path: <linux-rdma+bounces-10528-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A01AC0A7E
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 13:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F2CB3BC9A7
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 11:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82372286425;
	Thu, 22 May 2025 11:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htJcKYj2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBBC236453;
	Thu, 22 May 2025 11:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747912822; cv=none; b=krLxl3BibAG+Yzm22M6Su2A4pWXvbPzSCherQ+tVuAU93BhtQ3cgrlx3XOmgvaya4cbqFO/6OBtiidySKjYeALnbDiJZbrVWU0OxRtUpA5e85Pt6QvMpUagbbJAf5Mm7mtINBjMbgQLhMpy7Q2zRZ2H3ym7yPOgH4wnif7ff/Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747912822; c=relaxed/simple;
	bh=jRsYt1VrwrUle3YyojqmPFAa2IOpAKCPjlqfUjpxhEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Okf8ChrlRQs4TVDflgmaweV9na1DdpFHTNg+1zz81GeX8/gNEwMNt93lb7Ft4ryBDfHh52/RkD5dsLJ+QR/l1HOd+fkd6xtLFnesnZkWdm89MJK5nB/T/kZO/3Ym6/Vhnnrnf+O8Ke4tsMsKLmk7Rrd+VjhloPhdZgniKSLU/as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htJcKYj2; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-879d2e419b9so6683906a12.2;
        Thu, 22 May 2025 04:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747912819; x=1748517619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhQcPwb5ovBgxN4UfBAYPgVenAPp+lY8SlTh9Tbhrz8=;
        b=htJcKYj2hANQvSrQKKYdmv/nmwoxex7c+Io2GZcKiIBozOesqojbY7NjV1ZvtbPxY1
         gzMZkTVMPWeQYK/iE3Rsjc/W6q0suFgIie210EcsdiLFZmSWAeCrfJuFyBMIukLE3jzh
         cJ5JoWlzGpmnVa+el0BCOB8AeXhLJqJVKs/gwKg6sU9yPQBO61+I5ZiK2rvJHDY1ZEmS
         oxXuXVDtOYzDtYGeDiDYnMVgeW+Y1IkCcxUh6SG5POevLIDlJPg0Dhh+NI31VKXEnSFl
         LRj7R9YumfvioDlhfqAS8dqE47adA0p5Wefy2J0epTXcPQt8mtIlwKBl45TKybYWrg3T
         DWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747912819; x=1748517619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VhQcPwb5ovBgxN4UfBAYPgVenAPp+lY8SlTh9Tbhrz8=;
        b=qZjh4fu0XJGAfmnIeRghddH1CCJhrkTu/1nYm6orEJ/L6W/fUHpRSsJPKfZdERrdbC
         NNW8vegNc2ypPKgAU42bNWTQWkplxF0rPkxIEdtVbDKnlLD8bUn+UncoQW2UJSCOKolC
         XkAud8dqQEOUujhwvgGnTw6rAEBGPjIRuTNxESVP/k0/IJUAHYmJ2Jxme2X1pOjLHtxk
         uPgY8DLIu4qgC993HfW8Nae/gik8TMKTzfD79LndwW0EE1ncGzrs7q+9C6l23adLoY8H
         ddOZ/ljDBJd3GFe4ysBbxP+Vbit/z9VOJFlmaZ7Q3jMbOVFF4YRuBAtaMs9ILsGZtGuS
         dCRw==
X-Forwarded-Encrypted: i=1; AJvYcCWNozz1phogf4Lzxcwn2XKyUYd62YNhfw9FbItWgCNlGmDE2AJjuA4IRbcRoe2pmmJOiEhsp6PH2YxW@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8UVYqqmo2Wfep/lAlR3b9MFdp8nKLJqvHUfjyMfJb+ALSvZOX
	6xfpZRRpKky3TXkVfwGRmGan7EvBZGB2o6ahNIzi6OQTvdN7Y0VhJ+d65b3xZxwD
X-Gm-Gg: ASbGncvHR7AuqKBaSJCNZqiliDJHIBLOVdY0gcZEkg0TCnlGrSetUupMF8y7TH26cMQ
	tjZYRUW0oW9oGaOUvjxustp7TSWjeFPEhZriC08EtuA9y93pihd0NjVeGcDvLOC+OihbeMN3LZd
	bTlVuH96JP11MDqI5SuaVRGUqzHbqTqWrzhAmQ9e2xRLJwfz/pjMyAD0GGs1LnedrIe0rCrvrLU
	tuoWVU+OTwLPCCtM7ccNDUSL+PiCGlvOskcl3EI0IUERzF2dPCgLu/iKpZ3nxuFtcX81HJ9GFEQ
	JzAQL4kaJCY2tR74wloROQUOlPT/EHjXsaHBNfmVRtq0W+Hnlm34BfiKsZwEF8v/fyWfeXQI+w2
	vkdX/+A==
X-Google-Smtp-Source: AGHT+IGPIKe04rIjz0g9W2iM2ItC746hBNyTzj52ykJ4l2pF9OvDfAdE9D+qpzEaLW5S1py+5WV/Pg==
X-Received: by 2002:a17:902:e74c:b0:231:d0c4:e806 with SMTP id d9443c01a7336-231d459a971mr378335435ad.32.1747912818840;
        Thu, 22 May 2025 04:20:18 -0700 (PDT)
Received: from trigkey.. (FL1-119-244-79-106.tky.mesh.ad.jp. [119.244.79.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ac93b3sm107730145ad.4.2025.05.22.04.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 04:20:18 -0700 (PDT)
From: Daisuke Matsuda <dskmtsd@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: Daisuke Matsuda <dskmtsd@gmail.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH for-next v4 1/2] RDMA/rxe: Implement synchronous prefetch for ODP MRs
Date: Thu, 22 May 2025 11:19:54 +0000
Message-ID: <20250522111955.3227-2-dskmtsd@gmail.com>
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
index a1416626f61a..c723d8a6cfec 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -422,3 +422,85 @@ enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
 
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


