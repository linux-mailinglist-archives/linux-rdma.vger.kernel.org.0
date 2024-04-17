Return-Path: <linux-rdma+bounces-1969-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A1F8A85DA
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Apr 2024 16:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C186B283052
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Apr 2024 14:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA401420B3;
	Wed, 17 Apr 2024 14:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cLUGaOvD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A76140397;
	Wed, 17 Apr 2024 14:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713363668; cv=none; b=TxOowcosy9JEB0wo8RiPlyKhI4YWxg9imaI1Zxcx4LVccq6W4aEHz1dRQRHMYGR/zn8K1QhjmuH3/xOVAjgcfKu0ggCix9cKSKwzdJCJsTAk+WEdpAqi9+ekJe4qErbZoVeVOWbdQEbM7xMtjttYrWIUuuv+riGUmAOxrmixc58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713363668; c=relaxed/simple;
	bh=nzbEypNfdMuBUIiajF0TN5k+jJSXZyB/hOg3YH0xUFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Qj6Cg8YwnfVnE186HejQLDiHDnE92bKjkn8QRx1bBGgxhVkJqkRzOYi6H4dfIy9hyQlsGNr9Re3KD+DaKnaAiMikgKuohNKaGmYGI7io6jS8VgHaNQ/VbN4gZJnnvgcGosd5GHnmj5fcA8Ut0tVUsVg2Is/FYLt3mHR1ZqIJ3/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cLUGaOvD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id AE49720FD4BE;
	Wed, 17 Apr 2024 07:21:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AE49720FD4BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713363666;
	bh=/ds8xMLrbNW14VpoC1Ecs+aa1pBSel0HOxs3g4z/JF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cLUGaOvDCJiaeKDh217nNIkkao3gLTe/P3sJSG6VLuKRvvHxTZ8QqTb3IsGFFh6Ir
	 jn9MNzm/AHgSzQ6/aorNVzWpwQjN/2tJvLNSdPDiAA9Ad4v0nN8iS5l29CRRa586AU
	 tE8/XtYmiJ9gMBfQb0FIK/RiOH7ww4zFcyYBKRbU=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 1/2] RDMA/mana_ib: Allow registration of DMA-mapped memory in PDs
Date: Wed, 17 Apr 2024 07:20:58 -0700
Message-Id: <1713363659-30156-2-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1713363659-30156-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1713363659-30156-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Allow the HW to register DMA-mapped memory for kernel-level PDs.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/main.c | 3 +++
 include/net/mana/gdma.h           | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index b31dcff32699..820af42d1fe1 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -82,6 +82,9 @@ int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	mana_gd_init_req_hdr(&req.hdr, GDMA_CREATE_PD, sizeof(req),
 			     sizeof(resp));
 
+	if (!udata)
+		flags |= GDMA_PD_FLAG_ALLOW_GPA_MR;
+
 	req.flags = flags;
 	err = mana_gd_send_request(gc, sizeof(req), &req,
 				   sizeof(resp), &resp);
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 27684135bb4d..8d796a30ddde 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -762,6 +762,7 @@ struct gdma_destroy_dma_region_req {
 
 enum gdma_pd_flags {
 	GDMA_PD_FLAG_INVALID = 0,
+	GDMA_PD_FLAG_ALLOW_GPA_MR = 1,
 };
 
 struct gdma_create_pd_req {
-- 
2.43.0


