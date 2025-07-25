Return-Path: <linux-rdma+bounces-12476-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CC4B11828
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jul 2025 07:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1DB5657BE
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jul 2025 05:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112AB26CE17;
	Fri, 25 Jul 2025 05:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KWgvLjJc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E51C76026
	for <linux-rdma@vger.kernel.org>; Fri, 25 Jul 2025 05:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753423169; cv=none; b=tOJ/VmhUh/DHvIK5UkeG+ovn+Qv5YW2GMYbwYQuI3pblPGTCRWnRzRwH+JDW/NcRVX8EiuRpbqFXNx6rRqtN7Y6+2OodZ+73cyhXATvgsvqXdZxxL+rdKbvznXnaFp5JeBTF9kuBb91RYTbwNzcVmgdxfm0F9IL6zYd4LNt3ygc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753423169; c=relaxed/simple;
	bh=AXJX/kV3p6GNI4O8f/AD72yIt1cJsgUKrrRvJpOZ0Ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Et4JDDCC8N1SLw1NwNyocIEnvOt46wYwNc1RSEN60ItcPWbJu5nb0/Smo6y1z4rliXE9G4Upt+XZPuvEoute9srvIK4qITGNz+UcvX08+01SAv9eLYucZ1H7qKvgLnf31vqufcuwZslabUJ7wTG31U5hEoQmJB0gXcx0hDj5/Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KWgvLjJc; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753423164; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=jAoA/apGfajG1N5TlOBziklWIJtZfL0xc7xcR2p3VNg=;
	b=KWgvLjJcRa1Lw6IRN/pzvOKzt/Rp0Vwv7ol0q/pab1zu2Ar1jglabqEElJ1SkmxBN9G5z4jvCVcTRB3vJkpa74MkWm+dJAD+KGCS+IDQ+WOJYlw/YyJO4ondwWuidZKVD5Zpgefk6dRGDL802eW4ZWMtDRPr7oIXkzoJLuvg2B4=
Received: from localhost(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0WjwDLDi_1753422852 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 25 Jul 2025 13:54:13 +0800
From: Boshi Yu <boshiyu@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	chengyou@linux.alibaba.com,
	kaishen@linux.alibaba.com
Subject: [PATCH for-next 2/3] RDMA/erdma: Fix ignored return value of init_kernel_qp
Date: Fri, 25 Jul 2025 13:53:55 +0800
Message-ID: <20250725055410.67520-3-boshiyu@linux.alibaba.com>
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

The init_kernel_qp interface may fail. Check its return value and free
related resources properly when it does.

Fixes: 155055771704 ("RDMA/erdma: Add verbs implementation")
Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_verbs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index b4dadd306837..32b11ce228dc 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -1059,7 +1059,9 @@ int erdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 		if (ret)
 			goto err_out_cmd;
 	} else {
-		init_kernel_qp(dev, qp, attrs);
+		ret = init_kernel_qp(dev, qp, attrs);
+		if (ret)
+			goto err_out_xa;
 	}
 
 	qp->attrs.max_send_sge = attrs->cap.max_send_sge;
-- 
2.46.0


