Return-Path: <linux-rdma+bounces-5505-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE1A9AE551
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2024 14:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45A2C282570
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2024 12:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39081DD0C5;
	Thu, 24 Oct 2024 12:46:28 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EC01D9A53;
	Thu, 24 Oct 2024 12:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729773988; cv=none; b=dZrMtaqEbGRLoQdRi56MHQbef89u6ZsLn+lf5MnjbnN1HMJf0HThOf0VMv3fADMZAqm1Q00U4q5O//XcXRqVgfeWIc2n/XdS76Y3YlhMrs4RvtDexS0am5pg89izxG/r1XUjPv15gXo1SLBye8+SdVCkeGiloeWLI+ksU61BmxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729773988; c=relaxed/simple;
	bh=QNwjFWo7qZa5gqnLQy7NU0n0xNcFA0uT41FESyevKdA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=agTLEr21k3mPDGo2MFAJD+4yU3xLGmAjmKZgFER0hhnkS3kPDMQjBNS4DqhgioIVf0k8CU4mnrOhZhoZAEi+u6OAVz06cY1TkhA/1PHZijB0/1KROOWsQ5yBHRVWnq8NfOVQTo2hwfYbNtYEYNaZ+qNNsTgKwrQBN5q9NxM2AGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XZ5GX5K25z1jvkv;
	Thu, 24 Oct 2024 20:44:52 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 1EACE140336;
	Thu, 24 Oct 2024 20:46:17 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Oct 2024 20:46:16 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
	<tangchengchang@huawei.com>
Subject: [PATCH v2 for-rc 0/5] RDMA/hns: Bugfixes
Date: Thu, 24 Oct 2024 20:39:55 +0800
Message-ID: <20241024124000.2931869-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100018.china.huawei.com (7.202.181.17)

Some hns bugfixes.
Patch #5 has been sent once before:
https://lore.kernel.org/lkml/4c202653-1ad7-d885-55b7-07c77a549b09@hisilicon.com/T/#m05883778af8e39438d864e9c0fb9062aa09f362c

v1 -> v2:
* Add spin_lock_init() for the newly-added flush_lock in patch #2.

Junxian Huang (1):
  RDMA/hns: Use dev_* printings in hem code instead of ibdev_*

Yuyu Li (1):
  RDMA/hns: Modify debugfs name

wenglianfa (3):
  RDMA/hns: Fix an AEQE overflow error caused by untimely update of
    eq_db_ci
  RDMA/hns: Fix flush cqe error when racing with destroy qp
  RDMA/hns: Fix cpu stuck caused by printings during reset

 drivers/infiniband/hw/hns/hns_roce_cq.c      |   4 +-
 drivers/infiniband/hw/hns/hns_roce_debugfs.c |   3 +-
 drivers/infiniband/hw/hns/hns_roce_device.h  |   3 +
 drivers/infiniband/hw/hns/hns_roce_hem.c     |  48 +++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c   | 155 +++++++++++--------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h   |   5 +
 drivers/infiniband/hw/hns/hns_roce_mr.c      |   4 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c      |  69 ++++++---
 drivers/infiniband/hw/hns/hns_roce_srq.c     |   4 +-
 9 files changed, 178 insertions(+), 117 deletions(-)

--
2.33.0


