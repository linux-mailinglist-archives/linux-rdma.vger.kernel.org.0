Return-Path: <linux-rdma+bounces-13889-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FA1BE31F8
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 13:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D7C084E78C0
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 11:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0120931AF3B;
	Thu, 16 Oct 2025 11:41:05 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02CB31AF33
	for <linux-rdma@vger.kernel.org>; Thu, 16 Oct 2025 11:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760614864; cv=none; b=VMOYgX4nJV32LvAKi/vjAs9UA9Gmrf10tFpN5pxfSQnc2XqvYBllqnQ+x7OypyiUXrYzZlZMs97xyMeGmKrpOoqp3mHovjtYNwWkgceDLlC71X4Y7cw2FZ8BcW/s4Pv+3LI7llf0JqdtktYRgljqo6A6DMNACAGwLXmL4yxM1Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760614864; c=relaxed/simple;
	bh=BgOPPNuaSwx1tGDNB/zdROgjqq/Y5qkPt3kILFpTbZA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NIvqflY4SrptuQSfzxYV3jN9mG+gegiu6L1I7ihiz4HnvDanbKf7T6Sb7jBrmQOr72aAhDRvoFl7EN8huzpz8NylznfyF5y1KE8SVkFmIJTj4Zo8/MFZ5Cm1d+VcW5yZTuxiUAOLkfuFWTtKyDvkZfK4EP2R7SDGusROq4PWQC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cnQx55GmVznTVq;
	Thu, 16 Oct 2025 19:40:09 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 3735A1A016C;
	Thu, 16 Oct 2025 19:40:54 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Oct 2025 19:40:53 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-rc 4/4] RDMA/hns: Remove an extra blank line
Date: Thu, 16 Oct 2025 19:40:51 +0800
Message-ID: <20251016114051.1963197-5-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251016114051.1963197-1-huangjunxian6@hisilicon.com>
References: <20251016114051.1963197-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100018.china.huawei.com (7.202.181.17)

From: Guofeng Yue <yueguofeng@h-partners.com>

Remove an extra blank line.

Signed-off-by: Guofeng Yue <yueguofeng@h-partners.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index d20cef4b3ac9..7b72ff58bfa0 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -7053,7 +7053,6 @@ static int __hns_roce_hw_v2_init_instance(struct hnae3_handle *handle)
 		goto error_failed_roce_init;
 	}
 
-
 	handle->priv = hr_dev;
 
 	return 0;
-- 
2.33.0


