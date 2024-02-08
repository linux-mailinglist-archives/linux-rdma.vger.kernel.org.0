Return-Path: <linux-rdma+bounces-967-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C38284D942
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Feb 2024 04:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CC851C20DB3
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Feb 2024 03:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8062E630;
	Thu,  8 Feb 2024 03:54:53 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6094C2D054;
	Thu,  8 Feb 2024 03:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707364493; cv=none; b=ureHA9Uc5gigyFYTxRBhNLD3d5HyyiM6RIGsiEAtnjTe8kENVFwm2FZPeTZ7sj0pVfiGMo7Anh2kKwWcL8u50063/XcPFBsg9g5BCv8SPG2x+Kj8w9cGQ9fyXgyo//yvKMCXJ4Cfu+cpq9/vWZJZdLzAN9rQU1z4SKlOARycOYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707364493; c=relaxed/simple;
	bh=8gQe+a5VMwbGZUZID4MLAbdx2ZQzKKCTGHEnuvMsOOY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qLTwZJg2+9A7JpLGxT+rH5nnIWnGfDEg8viR2whN6Dsfc1FO7mMn/ghitwc/1TfztMUUKfVw0koJlPD0pRsh/mCVyr2JufYLqPK0gxzW4oZ4lSZVCOH+YelotzEuNkNIBnABUyjFHdIcCHKq7CRlPcmKVt2GGheSUogHdg5QuzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TVjlt0jQNz1vtL0;
	Thu,  8 Feb 2024 11:54:18 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 82A1614051C;
	Thu,  8 Feb 2024 11:54:46 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 11:54:45 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH v2 for-next 0/2] RDMA/hns: Support configuring congestion control algorithm with QP granularity
Date: Thu, 8 Feb 2024 11:50:36 +0800
Message-ID: <20240208035038.94668-1-huangjunxian6@hisilicon.com>
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
 kwepemi500006.china.huawei.com (7.221.188.68)

Commit 27c5fd271d8b ("RDMA/hns: The UD mode can only be configured
with DCQCN") adds a restriction that only DCQCN is supported for
UD QPs, but at the same time introduced other problem mistakenly.
Patch #1 reverts the previous modification and fixes the algorithm
issue for UD by configuring congestion control algorithm with QP
granularity.

Patch #2 adds support for userspace configuring congestion control
algorithm with QP granularity.

v1 -> v2:
* Not only revert but also fix the UD algorithm issue in patch #1.

Junxian Huang (1):
  RDMA/hns: Support userspace configuring congestion control algorithm
    with QP granularity

Luoyouming (1):
  RDMA/hns: Fix mis-modifying default congestion control algorithm

 drivers/infiniband/hw/hns/hns_roce_device.h | 26 +++++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 18 ++----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  3 +-
 drivers/infiniband/hw/hns/hns_roce_main.c   |  3 +
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 71 +++++++++++++++++++++
 include/uapi/rdma/hns-abi.h                 | 17 +++++
 6 files changed, 118 insertions(+), 20 deletions(-)

--
2.30.0


