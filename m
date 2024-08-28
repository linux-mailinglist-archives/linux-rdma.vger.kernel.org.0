Return-Path: <linux-rdma+bounces-4622-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BD6963171
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 22:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F7EDB23C23
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 20:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02901AC897;
	Wed, 28 Aug 2024 20:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="YyQglwG7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30E51AC420;
	Wed, 28 Aug 2024 20:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724875575; cv=none; b=MAoxCsFleIRyn7hjQbpIENAY3BM3LDwTuOaYEH1wenM8fgP9YUiFHonCnS9TsZ+jdnQoMNAzTk2w90X1+ZtZnU7p81hygcgVzRawBBSwDk+BzWmi42NkN77TrrqOFesqycy4ihGK8FTAEKpKaSra+Fmqt/SXge2aUFnxNkZtN7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724875575; c=relaxed/simple;
	bh=J1qs/ro+twN/vVxYemNkev8UgQgfYYIICyG0CgtOkRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=AG8hd0XXwNBjx8jZVXMuK/0b64r++t7LwTJzQ6nQaBQV2FRRECX0A0aQzkiTJIdLRuUU/kfVCL80szojYjVIUfC21JYc+gVXRPvP9lVhoLkYBPIz0mEwzGLYPk3xWTq8uNNtBMvK4ivdSL44N8iUCq3QS5hoNS/7oOHt6fEwXag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=YyQglwG7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 937A520B7123; Wed, 28 Aug 2024 13:06:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 937A520B7123
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1724875573;
	bh=BjQepWccjey31JOFXVuSi9lL1FsxjDBdDvU2ED0CBOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=YyQglwG7AJhnbVEdCjDuBK+f/tFj5b+f0NMbTHQhiYKIN+9QvdluFjhQJeBKoIf/Y
	 cRQQtPhx7lbDh2QREmh7ES48h36ft9xc4Lr0Pfr/wKFhRa+4Cxmu9/covsDnNVxylu
	 m254ZOm5IWpk4rTx0Efhl4Pn2KPGEDM4PPuB++K4=
From: longli@linuxonhyperv.com
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Long Li <longli@microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH net] RDMA/mana_ib: use the correct page size for mapping user-mode doorbell page
Date: Wed, 28 Aug 2024 13:06:09 -0700
Message-Id: <1724875569-12912-2-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1724875569-12912-1-git-send-email-longli@linuxonhyperv.com>
References: <1724875569-12912-1-git-send-email-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

When mapping doorbell page from user-mode, the driver should use the system
page size as the doorbell is allocated via mmap() from user-mode.

Cc: stable@vger.kernel.org
Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure Network Adapter")
Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/infiniband/hw/mana/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index f68f54aea820..b26c4ebec2e0 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -511,13 +511,13 @@ int mana_ib_mmap(struct ib_ucontext *ibcontext, struct vm_area_struct *vma)
 	      PAGE_SHIFT;
 	prot = pgprot_writecombine(vma->vm_page_prot);
 
-	ret = rdma_user_mmap_io(ibcontext, vma, pfn, gc->db_page_size, prot,
+	ret = rdma_user_mmap_io(ibcontext, vma, pfn, PAGE_SIZE, prot,
 				NULL);
 	if (ret)
 		ibdev_dbg(ibdev, "can't rdma_user_mmap_io ret %d\n", ret);
 	else
 		ibdev_dbg(ibdev, "mapped I/O pfn 0x%llx page_size %u, ret %d\n",
-			  pfn, gc->db_page_size, ret);
+			  pfn, PAGE_SIZE, ret);
 
 	return ret;
 }
-- 
2.17.1


