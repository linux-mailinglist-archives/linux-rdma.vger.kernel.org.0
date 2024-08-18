Return-Path: <linux-rdma+bounces-4403-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA2B955B1C
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Aug 2024 08:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD0B51F21A4E
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Aug 2024 06:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14C2DDBE;
	Sun, 18 Aug 2024 06:10:16 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615A9D515
	for <linux-rdma@vger.kernel.org>; Sun, 18 Aug 2024 06:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723961416; cv=none; b=pU+4G69D16bf4DlO7XG56CFlCsC9jDAher9N+v29wAJ0cKpTqr+baNFCv5Ct1zZmWDAcGp87kZUJywIethIOwY6I8LApuPwIy66cHB31G/cE8Sg6tib1pLL7DsksCf6mJ32dFVcyjY9XrIj/FUEmqnh3nYC3P/vmPJvf+SWKGa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723961416; c=relaxed/simple;
	bh=fVU9Ff/RvN8lPvTIUWYAak7/VfaSzwPxJuARB/1Cw1k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UfpD1x4SQB+6aDvEfFlYNTUKc0muctz1hylcYXf+FpjjulCfkliGay4VQvfXk/RfgnGGWXb+d4r3iE7JrlnIinK50yVKU1uou9CPIRvIIjcmikbC/KojsF6GQa2CE/Ve/B4dXwwPGVQj/OqxaTPMWl8XYspHBfVM32dvyYwWd2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WmlZ84jNvz1S876;
	Sun, 18 Aug 2024 14:05:04 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id DE6BC180042;
	Sun, 18 Aug 2024 14:10:01 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sun, 18 Aug
 2024 14:10:01 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <phaddad@nvidia.com>,
	<linux-rdma@vger.kernel.org>
CC: <zhangzekun11@huawei.com>
Subject: [PATCH net-next 1/2] RDMA/core: Remove unused declaration rdma_resolve_ip_route()
Date: Sun, 18 Aug 2024 13:57:01 +0800
Message-ID: <20240818055702.79547-2-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240818055702.79547-1-zhangzekun11@huawei.com>
References: <20240818055702.79547-1-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf500003.china.huawei.com (7.202.181.241)

The definition of rdma_resolve_ip_route() has been removed since
commit 6aaecd385685 ("RDMA/core: Simplify roce_resolve_route_from_path()").
Let's remove this unused declaration.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/infiniband/core/core_priv.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index dd7715ba9fd1..05102769a918 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -325,9 +325,6 @@ void ib_qp_usecnt_inc(struct ib_qp *qp);
 void ib_qp_usecnt_dec(struct ib_qp *qp);
 
 struct rdma_dev_addr;
-int rdma_resolve_ip_route(struct sockaddr *src_addr,
-			  const struct sockaddr *dst_addr,
-			  struct rdma_dev_addr *addr);
 
 int rdma_addr_find_l2_eth_by_grh(const union ib_gid *sgid,
 				 const union ib_gid *dgid,
-- 
2.17.1


