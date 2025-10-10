Return-Path: <linux-rdma+bounces-13811-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B60CDBCB75A
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Oct 2025 04:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35CE3C3126
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Oct 2025 02:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45A3211A09;
	Fri, 10 Oct 2025 02:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cse.ust.hk header.i=@cse.ust.hk header.b="id8rfZo3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from cse.ust.hk (cssvr7.cse.ust.hk [143.89.41.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866EB1531C1;
	Fri, 10 Oct 2025 02:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=143.89.41.157
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760064946; cv=pass; b=UR0ZzsjwfIpaedKD3/QZ9pnXKlvOYegRhS69a/MrfVpJti2Jarj46b2cWlfTSnhLnGXjJlGGx9l7MCFIL6o+7cf7QMK/chlsxV7n/Q2Lgz4+g9H09hza88KFTDw9xe2g9SL1VZtTbINEOxvPwR7js6Qso0OYiZm3MsfHm9fqmhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760064946; c=relaxed/simple;
	bh=uSSSEvOfORkttJCFVoomahgXm43OdHV2GHhZQasriTA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AXkzW13eLjAVf2h4VGU8ToC834TozlQPe5KfR54y5wcAzb2zAq4JOllni/5JtABDjK7D4n/kAlw009JX+xbmLlbrks5gA3jR3fLVllBp+04Ditf+iYkjpCDV5f6JTdP/DoSfCjyPWxYRJTIM2x4sHT80UuTiTXuE1QOQGhuU9OQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.ust.hk; spf=pass smtp.mailfrom=cse.ust.hk; dkim=pass (1024-bit key) header.d=cse.ust.hk header.i=@cse.ust.hk header.b=id8rfZo3; arc=pass smtp.client-ip=143.89.41.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.ust.hk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.ust.hk
Received: from osx.local (ecs-119-8-240-33.compute.hwclouds-dns.com [119.8.240.33] (may be forged))
	(authenticated bits=0)
	by cse.ust.hk (8.18.1/8.12.5) with ESMTPSA id 59A2tMqU2401514
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 10 Oct 2025 10:55:28 +0800
ARC-Seal: i=1; a=rsa-sha256; d=cse.ust.hk; s=arccse; t=1760064929; cv=none;
	b=qEq9YC9HI5GgM9DS4ZHelPOBqS/+LuwLn73gXvZMaOmGlu7RUvP5uQBOL5whmhtV4qRxoo9VZD+PUnFcWDLJmgzEEZPGcaGrzkjWd7NfFNmOacamrH5QgE4xUadcj7p4ECP+3KsL1qnSMjeWV0Z/ohCkvPAIJJ0AZYfi/oJBkjM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=cse.ust.hk; s=arccse;
	t=1760064929; c=relaxed/relaxed;
	bh=18YD3awppm/CxXXQEZqsIBz/YS/zAyZwUu+GjWw8Gw4=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=PeNnvRXnZsorZXd+xuDrCg02D7rWzDORQ36zG/cpS6E2qctJp0J25HY7eekcec/xDPKWRyyuD8wc2PWXpGVWV4PPeGEJGlvo5mVnxQ5i4sWaoL0amEL3FIk18z8VkghDRxKbuq2n+RUmgA4i2WUKF+ins0m7dTYAmrFczH1VN08=
ARC-Authentication-Results: i=1; cse.ust.hk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cse.ust.hk;
	s=cseusthk; t=1760064929;
	bh=18YD3awppm/CxXXQEZqsIBz/YS/zAyZwUu+GjWw8Gw4=;
	h=Date:From:To:Cc:Subject:From;
	b=id8rfZo3cFVzcJKN0aCVKLfjrqY3jhKQR+bP6liKcf970OHX/nLBgg5ZeY0wpEb7q
	 i614y1t/Ktl6v0f02to79zZbvmUiMsnzXimy8bWXwRvYFhhepw6sl62sXxFN8BIGgA
	 ic3AW9sopw8if0oecvSbhboKd3MUYEnqaS2Z6q80=
Date: Fri, 10 Oct 2025 10:55:17 +0800
From: Shuhao Fu <sfual@cse.ust.hk>
To: Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] RDMA/uverbs: fix umem release in UVERBS_METHOD_CQ_CREATE
Message-ID: <aOh1le4YqtYwj-hH@osx.local>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Env-From: sfual

In `UVERBS_METHOD_CQ_CREATE`, umem should be released if anything goes
wrong. Currently, if `create_cq_umem` fails, umem would not be
released or referenced, causing a possible leak.

In this patch, we release umem at `UVERBS_METHOD_CQ_CREATE`, the driver
should not release umem if it returns an error code.

Fixes: 1a40c362ae26 ("RDMA/uverbs: Add a common way to create CQ with umem")
Signed-off-by: Shuhao Fu <sfual@cse.ust.hk>
---
Change to v1: [1]
- do not let driver free umem

[1] https://lore.kernel.org/linux-rdma/aOflenF0XHtm80G9@homelab/
---
 drivers/infiniband/core/uverbs_std_types_cq.c |  4 +++-
 drivers/infiniband/hw/efa/efa_verbs.c         | 12 +++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index 37cd37556..9344020de 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -193,8 +193,10 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 
 	ret = umem ? ib_dev->ops.create_cq_umem(cq, &attr, umem, attrs) :
 		ib_dev->ops.create_cq(cq, &attr, attrs);
-	if (ret)
+	if (ret) {
+		ib_umem_release(umem);
 		goto err_free;
+	}
 
 	obj->uevent.uobject.object = cq;
 	obj->uevent.uobject.user_handle = user_handle;
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index d9a12681f..89c58aedf 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1216,13 +1216,13 @@ int efa_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		if (umem->length < cq->size) {
 			ibdev_dbg(&dev->ibdev, "External memory too small\n");
 			err = -EINVAL;
-			goto err_free_mem;
+			goto err_out;
 		}
 
 		if (!ib_umem_is_contiguous(umem)) {
 			ibdev_dbg(&dev->ibdev, "Non contiguous CQ unsupported\n");
 			err = -EINVAL;
-			goto err_free_mem;
+			goto err_out;
 		}
 
 		cq->cpu_addr = NULL;
@@ -1251,7 +1251,7 @@ int efa_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 
 	err = efa_com_create_cq(&dev->edev, &params, &result);
 	if (err)
-		goto err_free_mem;
+		goto err_free_mapped;
 
 	resp.db_off = result.db_off;
 	resp.cq_idx = result.cq_idx;
@@ -1299,10 +1299,8 @@ int efa_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	efa_cq_user_mmap_entries_remove(cq);
 err_destroy_cq:
 	efa_destroy_cq_idx(dev, cq->cq_idx);
-err_free_mem:
-	if (umem)
-		ib_umem_release(umem);
-	else
+err_free_mapped:
+	if (!umem)
 		efa_free_mapped(dev, cq->cpu_addr, cq->dma_addr, cq->size, DMA_FROM_DEVICE);
 
 err_out:
-- 
2.39.5 (Apple Git-154)


