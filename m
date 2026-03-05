Return-Path: <linux-rdma+bounces-17554-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIrOKoq5qWlEDAEAu9opvQ
	(envelope-from <linux-rdma+bounces-17554-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 18:12:42 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A756215EED
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 18:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B30BF31B50A9
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 17:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEA63D2FF4;
	Thu,  5 Mar 2026 17:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0jAi4BJQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43613DEAD2
	for <linux-rdma@vger.kernel.org>; Thu,  5 Mar 2026 17:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772730520; cv=none; b=cuN/ifcY8TQ1HAWQMEGsqu0s1xCWMPZrYEvwt32vatsy54zoN96kBTnnvgMgGyBcT+6cv1JfBpXdG/TcVSLbI7hVC5bB6iAsygh5wBy3a6v48TQbCFaj6cGczTUVFyUaQlb1A3qxsueQRYvmYwBWCgc1zAwyFxeAyynlcxW7/O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772730520; c=relaxed/simple;
	bh=Koa/ken1lMUoYiwsZJNUkx2QvQdCSlqVgWsJbmXoc5c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tPZnkRjSl+i/Yu1pHqbIb8Mupgepb3DMVldEquSB4IV0x+jNY7eySrCm82Vu3R/6nfEJ+tziAKFKdYerOSgyrG1vTAy4yDZscETnv7q8yp8mKWdm7rGrP0+FAXWbide76brXl0L+2CtDyjYXjM4W+z+wfL6va2YxyvENA+rcuMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0jAi4BJQ; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-503915b0a88so150750531cf.1
        for <linux-rdma@vger.kernel.org>; Thu, 05 Mar 2026 09:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772730518; x=1773335318; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mrJniidHLZwmo6yw/3qLULsIE+tfOABpl0eKgJUlyxE=;
        b=0jAi4BJQ2xLgQXT2kVynzwWIpCmcuR/hEgJ25FWrZ8ebeYoGLOp0qRXoYPiv9V0enx
         +jftMjTfuXzMwuc4yTL3iTDRe9Y73mP+0qCupjjPEc6fiBFO44rXD8nkOf6vPcuuhRrE
         RYNnWELTD5z5EDpIA8480maQ8jI6ntJ0EVaW/k0AYzcyVq20FnOfJzhiH1Qh6TGFVDTO
         4A0BS6uy8CSqbKiIBRRix7pDhT5E+FdD3GdtXTV/hWLAtE6t0Ny5WeRHEtEI9cO9acWM
         p70ZzzhOifRSaRextqdbVER6K1hbFUZv0suTZp4ZDTNilXCOrnMDw7vDFGWm/v/m0qZc
         LhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772730518; x=1773335318;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mrJniidHLZwmo6yw/3qLULsIE+tfOABpl0eKgJUlyxE=;
        b=u0svNppR/pvK5YS7iB7vojFW7B8AxWWzFmvz1v3O425t6n07+4fvj9l87L4gbzYY4/
         80/CqehmeOsufZlRUN6ivBJqJJQGfttKaKyXDPuOD8/4yNFeaGAsc6I50heaBuSeX+Tj
         srZpdtJamlmgWlev6lgX/j/DO0o6GjZrtBRccJ5c9PgY42qFJoAjqqWHeHZFIUHZTaQn
         d1r4MNBvg7MAspsffs+GZpn+vaD3QAtO38FiFfkIwqKoSbLqCmloRl44aRPgepLSikx4
         oXyQSC81opbhsQ4bLUuEgrgXYxz4AFw1HY5NdSHpuHQitiXkg4cpFzi8WsIKP4cyQTm7
         WtGg==
X-Gm-Message-State: AOJu0Yx7+q17Y/rqaSb+fOQthXPIYdLsWmRut/IQgFcXfoPuWWDPxsMp
	SOuThD9FXBKj5sHPwW9kyKcdCHgja66j22kjqZOgjMI+n+qjCX3kNVOpAc2AgHrt334k89KPnwG
	4tk/em+hMvw==
X-Received: from qva24.prod.google.com ([2002:a05:6214:8018:b0:89a:6f2:10ce])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:ac8:58c1:0:b0:4ff:9737:dd15
 with SMTP id d75a77b69052e-508db375087mr83772611cf.60.1772730517534; Thu, 05
 Mar 2026 09:08:37 -0800 (PST)
Date: Thu,  5 Mar 2026 17:08:25 +0000
In-Reply-To: <20260305170826.3803155-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260305170826.3803155-1-jmoroni@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260305170826.3803155-5-jmoroni@google.com>
Subject: [PATCH rdma-next v3 4/5] RDMA/umem: Add helpers for umem dmabuf
 revoke lock
From: Jacob Moroni <jmoroni@google.com>
To: tatyana.e.nikolova@intel.com, krzysztof.czurylo@intel.com, jgg@ziepe.ca, 
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org, Jacob Moroni <jmoroni@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 3A756215EED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17554-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Added helpers to acquire and release the umem dmabuf revoke
lock. The intent is to avoid the need for drivers to peek
into the ib_umem_dmabuf internals to get the dma_resv_lock
and bring us one step closer to abstracting ib_umem_dmabuf
away from drivers in general.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/core/umem_dmabuf.c | 16 ++++++++++++++++
 include/rdma/ib_umem.h                |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
index 1a810dbdea9a..9deded3d58b5 100644
--- a/drivers/infiniband/core/umem_dmabuf.c
+++ b/drivers/infiniband/core/umem_dmabuf.c
@@ -334,6 +334,22 @@ struct ib_umem_dmabuf *ib_umem_dmabuf_get_pinned(struct ib_device *device,
 }
 EXPORT_SYMBOL(ib_umem_dmabuf_get_pinned);
 
+void ib_umem_dmabuf_revoke_lock(struct ib_umem_dmabuf *umem_dmabuf)
+{
+	struct dma_buf *dmabuf = umem_dmabuf->attach->dmabuf;
+
+	dma_resv_lock(dmabuf->resv, NULL);
+}
+EXPORT_SYMBOL(ib_umem_dmabuf_revoke_lock);
+
+void ib_umem_dmabuf_revoke_unlock(struct ib_umem_dmabuf *umem_dmabuf)
+{
+	struct dma_buf *dmabuf = umem_dmabuf->attach->dmabuf;
+
+	dma_resv_unlock(dmabuf->resv);
+}
+EXPORT_SYMBOL(ib_umem_dmabuf_revoke_unlock);
+
 void ib_umem_dmabuf_revoke(struct ib_umem_dmabuf *umem_dmabuf)
 {
 	struct dma_buf *dmabuf = umem_dmabuf->attach->dmabuf;
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 28075e617480..38414281a686 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -151,6 +151,8 @@ ib_umem_dmabuf_get_pinned_with_dma_device(struct ib_device *device,
 int ib_umem_dmabuf_map_pages(struct ib_umem_dmabuf *umem_dmabuf);
 void ib_umem_dmabuf_unmap_pages(struct ib_umem_dmabuf *umem_dmabuf);
 void ib_umem_dmabuf_release(struct ib_umem_dmabuf *umem_dmabuf);
+void ib_umem_dmabuf_revoke_lock(struct ib_umem_dmabuf *umem_dmabuf);
+void ib_umem_dmabuf_revoke_unlock(struct ib_umem_dmabuf *umem_dmabuf);
 void ib_umem_dmabuf_revoke(struct ib_umem_dmabuf *umem_dmabuf);
 
 #else /* CONFIG_INFINIBAND_USER_MEM */
@@ -223,6 +225,8 @@ static inline int ib_umem_dmabuf_map_pages(struct ib_umem_dmabuf *umem_dmabuf)
 }
 static inline void ib_umem_dmabuf_unmap_pages(struct ib_umem_dmabuf *umem_dmabuf) { }
 static inline void ib_umem_dmabuf_release(struct ib_umem_dmabuf *umem_dmabuf) { }
+static inline void ib_umem_dmabuf_revoke_lock(struct ib_umem_dmabuf *umem_dmabuf) {}
+static inline void ib_umem_dmabuf_revoke_unlock(struct ib_umem_dmabuf *umem_dmabuf) {}
 static inline void ib_umem_dmabuf_revoke(struct ib_umem_dmabuf *umem_dmabuf) {}
 
 #endif /* CONFIG_INFINIBAND_USER_MEM */
-- 
2.53.0.473.g4a7958ca14-goog


