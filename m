Return-Path: <linux-rdma+bounces-129-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02DA7FCD7A
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Nov 2023 04:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D7FC1C2107B
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Nov 2023 03:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA37523D;
	Wed, 29 Nov 2023 03:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fXv/l5me"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6098C1AD
	for <linux-rdma@vger.kernel.org>; Tue, 28 Nov 2023 19:25:20 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701228318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ZNnDj3gZH8Ja7vN1CAquuuBpN9vbVWfJ2FqrFhLWGc=;
	b=fXv/l5me5xpZAVGzgVhZ8SLPM62JoKdD2WyjS7OJsBgJzv3F7K6YZYZONQtBy2RhX6F5W8
	3eSnJEU3e0NEOsxAQTjK8FEowNub6At4vF2j88C1aOFMTTV5gtlKyOgjA/BzTtDgWEv3dF
	uxa2cwegwWqqZsPgoE0tqaIidNwkvqc=
From: Guoqing Jiang <guoqing.jiang@linux.dev>
To: bmt@zurich.ibm.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	guoqing.jiang@linux.dev
Subject: [PATCH 4/4] RDMA/siw: Call orq_get_current if possible
Date: Wed, 29 Nov 2023 11:24:18 +0800
Message-Id: <20231129032418.26705-5-guoqing.jiang@linux.dev>
In-Reply-To: <20231129032418.26705-1-guoqing.jiang@linux.dev>
References: <20231129032418.26705-1-guoqing.jiang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

We can call it in siw_orq_empty.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index 2edba2a864bb..75253f2b3e3d 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -657,7 +657,7 @@ static inline struct siw_sqe *orq_get_free(struct siw_qp *qp)
 
 static inline int siw_orq_empty(struct siw_qp *qp)
 {
-	return qp->orq[qp->orq_get % qp->attrs.orq_size].flags == 0 ? 1 : 0;
+	return orq_get_current(qp)->flags == 0 ? 1 : 0;
 }
 
 static inline struct siw_sqe *irq_alloc_free(struct siw_qp *qp)
-- 
2.35.3


