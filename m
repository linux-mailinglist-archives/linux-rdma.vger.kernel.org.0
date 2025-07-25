Return-Path: <linux-rdma+bounces-12475-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8AEB1181C
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jul 2025 07:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAA26189E712
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jul 2025 05:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A12C245010;
	Fri, 25 Jul 2025 05:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rAH2giPO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959A43A1DB
	for <linux-rdma@vger.kernel.org>; Fri, 25 Jul 2025 05:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753422859; cv=none; b=eqIrzINaqhUs8ULgMmNquHvJ6beMMcp54NfEfwEwVWskfQNPs7WuCLVVnuxboHY/4sP1PY7XolN3SBuN3bmKxuJvQKbzwTt4MjR8rXRyQxPbGYwlZgxiUj1JHPfOMGxa3JwMYQWVG+QPsmjlmYFlZV/dQXyI+VgIhWQaorRWbVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753422859; c=relaxed/simple;
	bh=GkD44Wr81JxSEfnPjKcYmYktxMYvGOrkg2OwZv7d6Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i3tlPkYgRJyzFpZATrz0W6TcoVWYUZt+G6UQPL32P3yfNH7GNz0Phr67Pr/BsUCwMFEievRMivIosQalowNLuLCkR7LcRiuPwXl1bjnPKh3UbFe+TtnZ9at8xCfZS6c8OpW7SuXr4SbueiB6xAmqFxdpYDbIlL13leSpf/ZHrRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rAH2giPO; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753422854; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=D59luFjehK3uAKQ1z3AwdidW09R+N7BjVOnp0Ruiaeo=;
	b=rAH2giPOFS0nd47ilSRBF3PSJ71Kzt3y/IFIkiSZOXJ6QjSxDJ4L5P8kZr60bvxDeg9J00tOy5pdWm8vWc6T7hkIQoUhr9Wkbbe+223eZ3Pp5rFh8H7NDkU1VrL3C8fGTtyb5evfI7P9CXEnZcRuLdb5paOZAtPXXWCufPu4b/o=
Received: from localhost(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0WjwB5et_1753422853 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 25 Jul 2025 13:54:13 +0800
From: Boshi Yu <boshiyu@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	chengyou@linux.alibaba.com,
	kaishen@linux.alibaba.com
Subject: [PATCH for-next 3/3] RDMA/erdma: Fix unset QPN of GSI QP
Date: Fri, 25 Jul 2025 13:53:56 +0800
Message-ID: <20250725055410.67520-4-boshiyu@linux.alibaba.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250725055410.67520-1-boshiyu@linux.alibaba.com>
References: <20250725055410.67520-1-boshiyu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The QPN of the GSI QP was not set, which may cause issues.
Set the QPN to 1 when creating the GSI QP.

Fixes: 999a0a2e9b87 ("RDMA/erdma: Support UD QPs and UD WRs")
Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_verbs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 32b11ce228dc..996860f49b2f 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -1022,6 +1022,8 @@ int erdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 		old_entry = xa_store(&dev->qp_xa, 1, qp, GFP_KERNEL);
 		if (xa_is_err(old_entry))
 			ret = xa_err(old_entry);
+		else
+			qp->ibqp.qp_num = 1;
 	} else {
 		ret = xa_alloc_cyclic(&dev->qp_xa, &qp->ibqp.qp_num, qp,
 				      XA_LIMIT(1, dev->attrs.max_qp - 1),
-- 
2.46.0


