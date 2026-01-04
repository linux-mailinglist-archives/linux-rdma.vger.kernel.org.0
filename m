Return-Path: <linux-rdma+bounces-15282-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 912E2CF0ABF
	for <lists+linux-rdma@lfdr.de>; Sun, 04 Jan 2026 07:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DA8F300E03C
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Jan 2026 06:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D012E040E;
	Sun,  4 Jan 2026 06:41:10 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA742DEA80
	for <linux-rdma@vger.kernel.org>; Sun,  4 Jan 2026 06:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767508870; cv=none; b=mTz1BEYurX6BoWSIXDRghybqMIAmUaycqKvg0d7F6POWqSfTeNvejJO3YBJ8ruXH9PDTlSRa1owULBmvji7vfj7G4VjeqC4cudAGvonKCvfVAv2q/tWZNN7sR1GG0TR9eoOujcjxWdqNSlRztglXedQXfAKglRR/lpGfUcUXlfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767508870; c=relaxed/simple;
	bh=4ntpBDoWupTPq+ohHWXf9nEpF+Wa78efWQRpvmRhz20=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oMM7c+BUeV+SevSYQyOCpMpp15SJY4ocJSJJD6v8jbZgsUx8fuwi4hKFufwRxqvnJasfhAf3DG6f9KB01/Xhd5uYuIugJjz432H96Vs53zKTnAW8FtG9EtIBlC3gwShPnctQ0preQVuLoF57YMcDmsZM8/rYOYigb4FKdEv+0to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dkSRN1nhpz12LDV;
	Sun,  4 Jan 2026 14:37:52 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 5594E4056D;
	Sun,  4 Jan 2026 14:40:58 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sun, 4 Jan 2026 14:40:57 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-rc 0/4] RDMA/hns: Misc fixes
Date: Sun, 4 Jan 2026 14:40:53 +0800
Message-ID: <20260104064057.1582216-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
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

This patchset provides some misc bugfixes for hns.

Chengchang Tang (2):
  RDMA/hns: Fix WQ_MEM_RECLAIM warning
  RDMA/hns: Notify ULP of remaining soft-WCs during reset

Junxian Huang (2):
  RDMA/hns: Return actual error code instead of fixed EINVAL
  RDMA/hns: Fix RoCEv1 failure due to DSCP

 drivers/infiniband/hw/hns/hns_roce_ah.c       | 23 ++++----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c    | 54 ++++++++++++++-----
 drivers/infiniband/hw/hns/hns_roce_restrack.c |  4 +-
 3 files changed, 53 insertions(+), 28 deletions(-)

--
2.33.0


