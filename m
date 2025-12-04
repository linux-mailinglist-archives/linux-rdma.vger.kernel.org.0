Return-Path: <linux-rdma+bounces-14882-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB042CA2FE9
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Dec 2025 10:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 803F0312388E
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Dec 2025 09:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BA133033B;
	Thu,  4 Dec 2025 09:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="n0q0rcLg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53088632B;
	Thu,  4 Dec 2025 09:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764840306; cv=none; b=Qs/+2ARM1P6U4OEIB+M3XMzAac34WSBeQFSYoGcOgHva9vlqSbQ46CZwd8743fZZcRVLdBmRylerFb/97yURd7OnZIzy/Wsf/ccDeiP8gNWvs8rIaF/Sof5UYkmpWFltpiyoWre5wvZguw5Gqp7OS1nEpZBI1nZgk1ltHUviRNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764840306; c=relaxed/simple;
	bh=4xMQcOgZ98xKGqIhEaX7o23kKvpaYdnzLzWlSiFWer8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tw9XfPQAMf15rGjFnEQRS/kWM+LU0tZBK5wW2dgJeQx4YMf3oITJQIS59C1Ailb8mnki5VJgirfkUp8+xiJBg+zvheb4th51bPrvH4xoN4mIkPPPOKffsOiWErl/voriXyW3mmn+9zmbT4H3CD3viGEiP+VY9Y7pp1GEzaJ4Sdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=n0q0rcLg; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764840295; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=RtoMOndX4hAyjb5HgYjhq44JrEwNFpCluKYWWcdrFt8=;
	b=n0q0rcLgLhtUWfuf854kbmSBkLLarBahHY+usAO7IuoLwL4Zzaxyl6ZRU7nAmL2/oxzXjolMKLCpBkLFGO43GJxwC8ndS1WhewVTzpdbtphBI7YnBczwtpWHR/AzPhgcEwimrlw3KcFXwWF23x05Ls8MaMRscJ0JmKh+4svLzeE=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Wu3q5m0_1764840291 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 04 Dec 2025 17:24:54 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: krzysztof.czurylo@intel.com
Cc: tatyana.e.nikolova@intel.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next 2/2] RDMA/irdma: Simplify bool conversion
Date: Thu,  4 Dec 2025 17:24:14 +0800
Message-ID: <20251204092414.1261795-2-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251204092414.1261795-1-jiapeng.chong@linux.alibaba.com>
References: <20251204092414.1261795-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

./drivers/infiniband/hw/irdma/uk.c:1412:6-11: WARNING: conversion to bool not needed here.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=27521
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/infiniband/hw/irdma/uk.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma/uk.c
index f0846b800913..91669326d464 100644
--- a/drivers/infiniband/hw/irdma/uk.c
+++ b/drivers/infiniband/hw/irdma/uk.c
@@ -1408,8 +1408,7 @@ int irdma_uk_cq_poll_cmpl(struct irdma_cq_uk *cq,
 		 * from SW for all unprocessed WQEs. For GEN3 and beyond
 		 * FW will generate/flush these CQEs so move to the next CQE
 		 */
-			move_cq_head = qp->uk_attrs->hw_rev <= IRDMA_GEN_2 ?
-						false : true;
+			move_cq_head = qp->uk_attrs->hw_rev > IRDMA_GEN_2;
 	}
 
 	if (move_cq_head) {
-- 
2.43.7


