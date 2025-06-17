Return-Path: <linux-rdma+bounces-11394-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 745C2ADC528
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 10:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 541407A61FC
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 08:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8E728F955;
	Tue, 17 Jun 2025 08:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzFZFpkC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABBE28F51A
	for <linux-rdma@vger.kernel.org>; Tue, 17 Jun 2025 08:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750149392; cv=none; b=EyUiVWt8KErqxtfioxbBpx+ml93n/qbFx8HFSNGom573u8s8L/7fgUEc4hNMrkMTo9f5OTl6pXoJ0c0VQJHoiyrrPw8abnWe6uVLKF56yYubaIsRS1TdIhKUJiis5xXDal5udeAjb7VL2hDoUMDvSemY+Sp7sPtLf17CZstlA9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750149392; c=relaxed/simple;
	bh=CPlITQZ6cl1nml5/WV7PXh/Jwjy8/62phWPsbFmMcWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oom53Ghs14HzoA8DFggCeXpJ9Sgmlcu7EPWPGtATbEpVlAC4iW/rb3e9nhLacnv4XSvopisgc5HUJDy+nBLsumlSSV2fk701xDbPmNIA+ePtQ0e536TjniZHEKbuyCJIlGjsD+Niv91j4E7CA3dGJCZNjy47c3VHkUkJVmSjwPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzFZFpkC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061B2C4CEE3;
	Tue, 17 Jun 2025 08:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750149390;
	bh=CPlITQZ6cl1nml5/WV7PXh/Jwjy8/62phWPsbFmMcWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NzFZFpkCYHxfwRVR/tZv8rjvbljmj1UTBS9a1Acle3aHfuCWI6JV91450EWXTMhao
	 3UHWRKofB8Ztt5KJXo3QpYxfXeEsQLczAGoqpD7tXYc190Bdh8SGk4QSbOoHF+Dckb
	 YOFSUqIrpVxOYlw7+99pBUvpEKasCjhGmbg2vjC3NILVUVbZDIyJOnUNG+mJMB9J7U
	 rtu3xvj3PUJv30g+EOjCgwk0/Dk3Cg3cPne8Kg7WztZc7kCEJjS5D0nrBz0GWtWXSU
	 QuraDfal7Pe7jSyd0+4g9t5RqtNweTji1WxhcLNVwQ3KPUhOBl9i4tIwSQQcdb+iQA
	 QVEYor6dIT/og==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-next 6/7] RDMA/counter: Check CAP_NET_RAW check in user namespace for RDMA counters
Date: Tue, 17 Jun 2025 11:35:50 +0300
Message-ID: <d999171056ded97b5dddf0e4e970555205dc28e6.1750148509.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750148509.git.leon@kernel.org>
References: <cover.1750148509.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Parav Pandit <parav@nvidia.com>

Currently, the capability check is done in the default
init_user_ns user namespace. When a process runs in a
non default user namespace, such check fails.

Since the RDMA device is a resource within a network namespace,
use the network namespace associated with the RDMA device to
determine its owning user namespace.

Fixes: 1bd8e0a9d0fd ("RDMA/counter: Allow manual mode configuration support")
Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/counters.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/counters.c b/drivers/infiniband/core/counters.c
index e6ec7b7a40af..c3aa6d7fc66b 100644
--- a/drivers/infiniband/core/counters.c
+++ b/drivers/infiniband/core/counters.c
@@ -461,7 +461,7 @@ static struct ib_qp *rdma_counter_get_qp(struct ib_device *dev, u32 qp_num)
 		return NULL;
 
 	qp = container_of(res, struct ib_qp, res);
-	if (qp->qp_type == IB_QPT_RAW_PACKET && !capable(CAP_NET_RAW))
+	if (qp->qp_type == IB_QPT_RAW_PACKET && !rdma_dev_has_raw_cap(dev))
 		goto err;
 
 	return qp;
-- 
2.49.0


